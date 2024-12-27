# test
# ~/.config/fish/config.fish

# set caps lock as escape
setxkbmap -option caps:escape

# export fzf settigns
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1"

# Bob the fish config
set -g theme_color_scheme dark
set -g theme_display_git_untracked no
set -g theme_display_git_ahead_verbose yes
set -g theme_display_hg yes
set -g theme_display_virtualenv yes
set -g theme_display_ruby no
set -g theme_display_user yes
set -g theme_title_display_process yes
set -g theme_title_display_path no
set -g theme_date_format "+%a %H:%M"
set -g theme_avoid_ambiguous_glyphs yes
set -g default_user zach

# terminal startup commands
# fastfetch --logo-type none
# todoist-cli --color --indent l --filter today

# If not running interactively, don't do anything
if status is-interactive

    # Set environment variables
    set -gx EDITOR nvim
    set -gx PAGER less
    set -g fish_greeting ""

    # Add directories to PATH
    set -gx PATH $HOME/.local/bin $PATH
    set -gx PATH $HOME/usr/bin $PATH
    set -gx PATH /home/zach/Apps $PATH

    # Aliases
    abbr ls 'exa --icons --group-directories-first --sort=extension'
    abbr grep 'grep --color=auto'
    abbr shutit 'shutdown -h 0'
    abbr lq 'exa --icons -1 -T -R --color=always -L'
    abbr lqa 'exa --icons -1 -T -R --color=always -L 9'
    abbr ytdl 'yt-dlp -P /home/zach/Videos/youtube --convert-subs srt --remux-video mp4 --write-auto-subs -u SAMCOUCAIL -p aaa -i'
    abbr nv 'nvim'
    abbr weather 'curl wttr.in/14530'
    abbr removebg 'source ~/scripts/rm_bg/bin/activate; python ~/scripts/remove_bg.py; deactivate'
    abbr javacall 'javac *.java'
    abbr clock 'peaclock blue'
    abbr tt 'tt -notheme -showwpm -n'
    abbr pipe 'bash /home/zach/Apps/pipes.sh/pipes.sh -t 0'
    abbr texclean 'find . -maxdepth 1 -type f ! -name "*.tex" ! -name "*.pdf" -exec rm -f {} \;'
    abbr checkra1n 'sudo ~/Apps/checkra1n'
    abbr beeper '~/Apps/beeper-3.106.2x86_64.AppImage'
    abbr timer 'uairctl'
    abbr term 'bash /home/zach/scripts/termdown.sh'
    abbr mail 'cmdg'
    abbr edex 'cd /home/zach/Apps/; ./eDEX-UI-Linux-x86_64.AppImage; cd'
    abbr yt 'ytfzf --force-youtube --upload-date=relevance -t '
    abbr rmt 'trash'
    abbr trash-empty 'sudo trash-empty'
    abbr shitpost 'bash ~/scripts/shitpost.sh'
    abbr p 'sudo pacman'
    abbr sus 'bash ~/scripts/suspend.sh'
    abbr balena './Apps/balenaEtcher-linux-x64/balena-etcher'
    abbr llc './Apps/LosslessCut-linux-x86_64.AppImage'
    abbr osu './Apps/osu.AppImage'
    abbr h './Apps/habitctl/target/release/habitctl'
    abbr bt 'bluetuith'
    abbr cal 'gcalcli'
    abbr mvn-new 'mvn archetype:generate -DgroupId=com.example -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false -DartifactId='
    abbr td 'todoist-cli --color --indent'
    abbr tdday 'todoist-cli --color --indent l --filter today'

		# abbr fastfetch 'fastfetch --logo-type none'
		abbr config '/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
		abbr gpom 'git push origin main'
		abbr gp 'sudo gopro webcam -a -r 1080 -f linear'
		abbr wifi 'nmtui'
		abbr rsync 'rsync --progress'
		abbr landscape 'bash ~/scripts/landscape-gif.sh'
		abbr remind 'bash /home/zach/scripts/reminder.sh -t'
		abbr history 'history | fzf | xclip -selection clipboard'
		abbr commit 'git commit -m'
		abbr nf 'nvim (fzf --tmux)'
		abbr fzf 'fzf --tmux'
		abbr color 'bash -c "$(wget -qO- https://git.io/vQgMr)"'
		abbr com 'for cmd in (ls /usr/bin /bin /usr/local/bin); echo $cmd; end | fzf'
end

function fish_user_key_bindings
    bind tt peco_todoist_item
    bind tp peco_todoist_project
    bind tl peco_todoist_labels
    bind tc peco_todoist_close
    bind td peco_todoist_delete
end



# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd
    builtin pwd -L
end

# A copy of fish's internal cd function. This makes it possible to use
# `alias cd=z` without causing an infinite loop.
if ! builtin functions --query __zoxide_cd_internal
    if builtin functions --query cd
        builtin functions --copy cd __zoxide_cd_internal
    else
        alias __zoxide_cd_internal='builtin cd'
    end
end

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd
    __zoxide_cd_internal $argv
end

# =============================================================================
#
# Hook configuration for zoxide.
#

# Initialize hook to add new entries to the database.
function __zoxide_hook --on-variable PWD
    test -z "$fish_private_mode"
    and command zoxide add -- (__zoxide_pwd)
end

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

if test -z $__zoxide_z_prefix
    set __zoxide_z_prefix 'z!'
end
set __zoxide_z_prefix_regex ^(string escape --style=regex $__zoxide_z_prefix)

# Jump to a directory using only keywords.
function __zoxide_z
    set -l argc (count $argv)
    if test $argc -eq 0
        __zoxide_cd $HOME
    else if test "$argv" = -
        __zoxide_cd -
    else if test $argc -eq 1 -a -d $argv[1]
        __zoxide_cd $argv[1]
    else if set -l result (string replace --regex $__zoxide_z_prefix_regex '' $argv[-1]); and test -n $result
        __zoxide_cd $result
    else
        set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
        and __zoxide_cd $result
    end
end

# Completions.
function __zoxide_z_complete
    set -l tokens (commandline --current-process --tokenize)
    set -l curr_tokens (commandline --cut-at-cursor --current-process --tokenize)

    if test (count $tokens) -le 2 -a (count $curr_tokens) -eq 1
        # If there are < 2 arguments, use `cd` completions.
        complete --do-complete "'' "(commandline --cut-at-cursor --current-token) | string match --regex '.*/$'
    else if test (count $tokens) -eq (count $curr_tokens); and ! string match --quiet --regex $__zoxide_z_prefix_regex. $tokens[-1]
        # If the last argument is empty and the one before doesn't start with
        # $__zoxide_z_prefix, use interactive selection.
        set -l query $tokens[2..-1]
        set -l result (zoxide query --exclude (__zoxide_pwd) --interactive -- $query)
        and echo $__zoxide_z_prefix$result
        commandline --function repaint
    end
end
complete --command __zoxide_z --no-files --arguments '(__zoxide_z_complete)'

# Jump to a directory using interactive search.
function __zoxide_zi
    set -l result (command zoxide query --interactive -- $argv)
    and __zoxide_cd $result
end

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

abbr --erase cd &>/dev/null
alias cd=__zoxide_z

abbr --erase cdi &>/dev/null
alias cdi=__zoxide_zi

# =============================================================================
#
# To initialize zoxide, add this to your configuration (usually
# ~/.config/fish/config.fish):
#
#   zoxide init fish | source


thefuck --alias | source
