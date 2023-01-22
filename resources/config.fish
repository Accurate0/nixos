function _is_home_dir
    set -l GIT (git rev-parse --show-toplevel 2>/dev/null)
    if test "$HOME" = "$GIT"
        echo yes
    end
end

function _git_branch_name
    echo (command git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
end

function _git_dirty
    echo (command git status -s --ignore-submodules=dirty 2>/dev/null)
end

function _reverse_search
    set -l _CMD (history | fzf)
    eval $_CMD
    commandline -f repaint
end

function fish_user_key_bindings
    bind \cr _reverse_search
end


function fish_greeting
    fortune -a -s -n 50
end

function fish_right_prompt
    set -g old_status $status
    set -l red (set_color red)

    if test (echo $old_status) -ne 0
        echo -n "$red" "$old_status" (set_color normal)
    end
end

function fish_prompt
    set -l white (set_color white)
    set -l yellow (set_color yellow)
    set -l green (set_color green)
    set -l normal (set_color normal)

    set -l cwd (basename (prompt_pwd))
    echo -e ""

    echo -n $normal
    echo -n -s ' ' $cwd $normal

    if ! test (_is_home_dir)
        if test (_git_branch_name)
            set -l git_branch (_git_branch_name)

            if test (_git_dirty)
                set git_info $yellow $git_branch
            else
                set git_info $green $git_branch
            end

            echo -n -s ' ' $git_info $normal
        end
    end

    # cursor
    echo -n -e "\033[5 q"
    echo -n -s ' ' $normal
end
