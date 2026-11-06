#!/bin/bash

# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return ;;
esac

# Read host overrides early so Bash can hand off to Zsh without loading
# interactive Bash configuration first.
[ -r ~/.shellrc-local ] && source ~/.shellrc-local

# Replace Bash with Zsh only in an interactive terminal, when enabled and
# available; the exported marker prevents child shells from handing off again.
if [ "${SHELL_AUTOEXEC_DONE:-}" != true ] &&
   [ "${FORCE_ZSH:-false}" = true ] &&
   test -t 1 && command -v zsh > /dev/null; then
    export SHELL_AUTOEXEC_DONE=true
    exec zsh
fi

# Ignore commands starting with a space and consecutive duplicate entries.
HISTCONTROL=ignoreboth
# Append history on exit instead of overwriting the history file.
shopt -s histappend
# Maximum commands retained in the current shell's history list.
HISTSIZE=1000
# Maximum lines retained in the history file.
HISTFILESIZE=2000

# Refresh LINES and COLUMNS after commands when the terminal is resized.
shopt -s checkwinsize

# Include the chroot name in the prompt when present.
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Load Bash completion if the system startup files have not already done so.
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Shared shell environment, aliases, colors, and host overrides.
[ -r ~/.shellrc ] && source ~/.shellrc

# Keep the root prompt distinct, even if a local user_color override exists.
[[ $EUID -eq 0 ]] && user_color=${rred}

# Visual Studio Code Terminal Shell Integration
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path bash)"

exitstatus() {
    local last_status=$?

    if [ "$last_status" -ne 0 ]; then
        printf '%b' "$rred"
    fi
}

sec_env() {
    if [ -n "${SEC_ENV:-}" ]; then
        printf '%b(%s)%b ' "$rred" "$SEC_ENV" "$rst"
    fi
}

scm() {
    local branch

    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || {
        printf ' '
        return
    }

    if [ -n "$branch" ]; then
        printf ' [%b%s%b]' "$lcyn" "$branch" "$rst"
    else
        printf ' '
    fi
}

PS1="\$(sec_env)${user_color:-${lblu}}\\u${rst}@${host_color:-${rgrn}}${host_alias:-\\h}${rst} \$(exitstatus)\\w${rst}\$(scm)\\$ "
PS2="${lylw}> ${rst}"