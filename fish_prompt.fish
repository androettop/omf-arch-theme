# name: Gianu
function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function fish_prompt
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l green (set_color -o green)
  set -l white (set_color -o white)
  set -l normal (set_color normal)


  set -l cwd $white(basename (prompt_pwd))

  if [ (_git_branch_name) ]
    set -l git_branch $green(_git_branch_name)
    set git_info "$normal($green$git_branch"

    if [ (_is_git_dirty) ]
      set -l dirty "$yellow ✗"
      set git_info "$git_info$dirty"
    end

    set git_info "$git_info$normal)"
  end

  echo -n -s $cyan '[' (whoami) '@' (hostname -s) ' ' $cwd $cyan ']$ '
end

