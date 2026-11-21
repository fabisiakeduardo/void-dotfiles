import GLib from 'gi://GLib';
import Gio from 'gi://Gio';
import Meta from 'gi://Meta';
import Shell from 'gi://Shell';
import St from 'gi://St';

import {Extension} from 'resource:///org/gnome/shell/extensions/extension.js';
import * as Main from 'resource:///org/gnome/shell/ui/main.js';
import {SelectArea, Flashspot} from 'resource:///org/gnome/shell/ui/screenshot.js';

export default class InstantAreaShotExtension extends Extension {
    enable() {
        this._settings = this.getSettings();
        this._running = false;
        Main.wm.addKeybinding(
            'binding', this._settings,
            Meta.KeyBindingFlags.IGNORE_AUTOREPEAT,
            Shell.ActionMode.NORMAL,
            () => {
                if (this._running)
                    return;
                this._running = true;
                this._run()
                    .catch(e => console.error(`instant-area-shot: ${e}`))
                    .finally(() => {
                        this._running = false;
                    });
            });
    }

    disable() {
        Main.wm.removeKeybinding('binding');
        this._settings = null;
    }

    async _run() {
        let area;
        try {
            area = await new SelectArea().selectAsync();
        } catch {
            return;
        }
        if (!area || area.width <= 0 || area.height <= 0)
            return;

        const stream = Gio.MemoryOutputStream.new_resizable();
        const shooter = new Shell.Screenshot();
        const flash = new Promise(resolve => {
            shooter.connect('screenshot_taken', (_s, rect) =>
                new Flashspot(rect).fire(resolve));
        });
        await Promise.all([
            flash,
            shooter.screenshot_area(
                area.x, area.y, area.width, area.height, stream),
        ]);
        const bytes = stream.steal_as_bytes();
        stream.close(null);

        const file = this._nextShotFile();
        const out = file.replace(
            null, false, Gio.FileCreateFlags.NONE, null);
        out.write_bytes(bytes, null);
        out.close(null);

        St.Clipboard.get_default().set_content(
            St.ClipboardType.CLIPBOARD, 'image/png', bytes);

        global.display.get_sound_player().play_from_file(
            Gio.File.new_for_path(
                `${global.datadir}/sounds/screen-capture.oga`),
            'Screenshot taken', null);
    }

    _nextShotFile() {
        const base = GLib.get_user_special_dir(
            GLib.UserDirectory.DIRECTORY_PICTURES) ?? GLib.get_home_dir();
        const dir = GLib.build_filenamev([base, 'Screenshots']);
        GLib.mkdir_with_parents(dir, 0o755);

        const stamp = GLib.DateTime.new_now_local()
            .format('%Y-%m-%d_%H-%M-%S');
        for (let idx = 0; ; idx++) {
            const name = idx === 0 ? `${stamp}.png` : `${stamp}-${idx}.png`;
            const file = Gio.File.new_for_path(
                GLib.build_filenamev([dir, name]));
            if (!file.query_exists(null))
                return file;
        }
    }
}
