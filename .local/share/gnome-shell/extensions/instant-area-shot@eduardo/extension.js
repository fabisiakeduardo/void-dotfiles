import GLib from 'gi://GLib';
import Gio from 'gi://Gio';
import Meta from 'gi://Meta';
import Shell from 'gi://Shell';

export default class InstantAreaShotExtension {
    enable() {
        this._action = global.display.grab_accelerator(
            '<Control><Shift>s', Meta.KeyBindingFlags.NONE);
        this._signal = global.display.connect(
            'accelerator-activated',
            (_d, action) => {
                if (action === this._action)
                    this._select();
            });
    }

    disable() {
        if (this._action) {
            global.display.ungrab_accelerator(this._action);
            this._action = 0;
        }
        if (this._signal) {
            global.display.disconnect(this._signal);
            this._signal = 0;
        }
    }

    _select() {
        const shot = new Shell.Screenshot();
        shot.select_area((x, y, w, h) => {
            if (w <= 0 || h <= 0)
                return;
            const dir = GLib.build_filenamev(
                [GLib.get_home_dir(), 'Pictures', 'Screenshots']);
            GLib.mkdir_with_parents(dir, 0o755);
            const stamp = GLib.DateTime.new_now_local().format('%Y-%m-%d_%H-%M-%S');
            const file = GLib.build_filenamev([dir, `${stamp}.png`]);
            shot.screenshot_area(x, y, w, h, false, 0, file, (_s, res) => {
                try {
                    shot.screenshot_area_finish(res);
                    Gio.Subprocess.new(
                        ['/bin/sh', '-c', `wl-copy < '${file}'`],
                        Gio.SubprocessFlags.NONE);
                } catch (e) {
                    console.error(`instant-area-shot: ${e}`);
                }
            });
        });
    }
}
