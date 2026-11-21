# Void-macOS-OLED + Craftzdog — Fish Shell Configuration

set -g fish_greeting ""

# PATH Setup (mise, local binaries, AI CLIs, Bun, Cargo, Antigravity)
fish_add_path -g ~/.local/bin
fish_add_path -g ~/.local/share/mise/shims
fish_add_path -g ~/.grok/bin
fish_add_path -g ~/.bun/bin
fish_add_path -g ~/.cargo/bin
fish_add_path -g ~/.gemini/antigravity-cli/bin

# Default Editors & Environment
set -gx EDITOR nvim
set -gx VISUAL code
set -gx PAGER less
set -gx BAT_THEME "base16"
set -gx COLORTERM truecolor

# FZF — Void OLED + Gargantua Amber theme
set -gx FZF_DEFAULT_OPTS " \
  --height=45% --layout=reverse --border=rounded --margin=1 --padding=1 \
  --color=bg+:#18181c,bg:#060608,spinner:#ff8c38,hl:#ff8c38 \
  --color=fg:#d4d4d8,header:#ff8c38,info:#a1a1aa,pointer:#ff8c38 \
  --color=marker:#34d399,fg+:#ffffff,prompt:#ff8c38,hl+:#ffb36b \
  --color=border:#27272a,label:#f3f4f6"

if type -q fd
    set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"
    set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
end

# Fish Syntax Highlighting — Void OLED + Amber Palette
set -g fish_color_normal ededf0
set -g fish_color_command 60a5fa
set -g fish_color_keyword c084fc
set -g fish_color_quote 34d399
set -g fish_color_redirection ff8c38
set -g fish_color_end a1a1aa
set -g fish_color_error ff5f56
set -g fish_color_param d4d4d8
set -g fish_color_comment 52525b
set -g fish_color_selection --background=2c2018
set -g fish_color_operator ff8c38
set -g fish_color_escape fbbf24
set -g fish_color_autosuggestion 52525b
set -g fish_color_valid_path --underline
set -g fish_pager_color_progress a1a1aa
set -g fish_pager_color_prefix ff8c38 --bold
set -g fish_pager_color_completion d4d4d8
set -g fish_pager_color_description 71717a

if status is-interactive
    # Vim keybindings in Fish (Esc or jk -> Normal mode, i -> Insert mode!)
    fish_vi_key_bindings
    bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"

    # Activate mise (Node.js, Python, Java, Bun)
    if type -q mise
        mise activate fish | source
    end

    # Activate Starship prompt
    if type -q starship
        starship init fish | source
    end

    # Activate Zoxide smart cd
    if type -q zoxide
        zoxide init fish | source
    end

    # FZF Fish keybindings (Ctrl+R history, Ctrl+T files, Alt+C cd) in both insert & normal mode
    if type -q fzf
        fzf --fish | source
    end

    # Atuin (Rust SQLite shell history search)
    if type -q atuin
        atuin init fish --disable-up-arrow | source
    end

    # Yazi (Rust terminal file manager — changes directory on exit with `y`)
    if type -q yazi
        function y --description "Yazi file manager with cwd sync"
            set tmp (mktemp -t "yazi-cwd.XXXXXX")
            yazi $argv --cwd-file="$tmp"
            if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
                builtin cd -- "$cwd"
            end
            rm -f -- "$tmp"
        end
    end

    # Craftzdog Ctrl+G: Fuzzy jump to any git project in ~/Projects or ~
    function fzf_git_project --description "Jump to a git repository with fzf (Craftzdog Ctrl+G)"
        set -l repo (fd -H -t d '^\.git$' ~/Projects ~ --max-depth 3 2>/dev/null | sed 's|/.git/$||' | fzf --prompt="󰊢 Project ❯ ")
        if test -n "$repo"
            cd "$repo"
            commandline -f repaint
        end
    end
    bind -M insert \cg fzf_git_project
    bind -M default \cg fzf_git_project

    # Craftzdog `ide`: launch Tmux IDE layout (Neovim top + 2 split shells bottom)
    function ide --description "Launch Craftzdog Tmux IDE layout"
        if set -q TMUX
            tmux split-window -v -p 25 -c "$PWD"
            tmux split-window -h -p 50 -c "$PWD"
            tmux select-pane -t 1
            nvim .
        else
            set -l sess (basename "$PWD" | tr '.' '_')
            tmux new-session -d -s "$sess" -c "$PWD" "nvim ."
            tmux split-window -v -p 25 -t "$sess" -c "$PWD"
            tmux split-window -h -p 50 -t "$sess" -c "$PWD"
            tmux select-pane -t "$sess":1.1
            tmux attach-session -t "$sess"
        end
    end

    # Modern Omarchy / Craftzdog Aliases
    if type -q eza
        alias ls 'eza --icons=auto --group-directories-first'
        alias ll 'eza -lh --icons=auto --group-directories-first --git'
        alias lla 'eza -lha --icons=auto --group-directories-first --git'
        alias la 'eza -lha --icons=auto --group-directories-first --git'
        alias lt 'eza --tree --level=2 --icons=auto --group-directories-first'
    end

    if type -q bat
        alias cat 'bat --paging=never'
    end

    if type -q zoxide
        alias cd 'z'
    end

    # Full Rust-rewritten CLI replacements
    type -q dust; and alias du 'dust'
    type -q procs; and alias ps 'procs'
    type -q rg; and alias grep 'rg'
    type -q fd; and alias find 'fd'
    type -q sd; and alias sed 'sd'
    type -q gping; and alias ping 'gping'
    type -q btm; and alias htop 'btm'
    type -q difft; and alias diff 'difft'
    type -q xh; and alias http 'xh'
    type -q tokei; and alias cloc 'tokei'
    type -q hyperfine; and alias bench 'hyperfine'
    type -q hexyl; and alias hex 'hexyl'

    alias v 'nvim'
    alias vim 'nvim'
    alias c 'code .'
    alias g 'git'
    alias ga 'git add'
    alias gc 'git commit'
    alias gp 'git push'
    alias gs 'git status -sb'
    alias gl 'git log --oneline --graph --decorate -n 20'
    alias gd 'git diff'
    alias lg 'lazygit'
    alias ff 'fastfetch'
    alias top 'btop'
    alias update 'yay -Syu'
    alias .. 'cd ..'
    alias ... 'cd ../..'
    alias cls 'clear'

    function blackhole-restart --description "Restart Hidamari animated black hole wallpaper"
        flatpak kill io.github.jeffshee.Hidamari 2>/dev/null
        systemctl --user stop hidamari-live.service 2>/dev/null
        systemctl --user reset-failed hidamari-live.service 2>/dev/null
        systemd-run --user --unit=hidamari-live flatpak run io.github.jeffshee.Hidamari --background >/dev/null 2>&1
        echo "Black hole live wallpaper restarted."
    end
end

# Dotfiles bare repo (git --git-dir=~/.dotfiles --work-tree=~)
alias dotfiles 'git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
