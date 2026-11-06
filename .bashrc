#!/bin/bash
# .bashrc
# Karol Kozlowski

# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return ;;
esac

# Read host overrides early so Bash can hand off to Zsh without loading
# interactive Bash configuration first.
[ -r ~/.shellrc-local ] && source ~/.shellrc-local

if [ "${SHELL_AUTOEXEC_DONE:-}" != true ] &&
   [ "${FORCE_ZSH:-false}" = true ] &&
   test -t 1 && command -v zsh > /dev/null; then
    export SHELL_AUTOEXEC_DONE=true
    exec zsh
fi

# History
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize

# Include the chroot name in the prompt when present.
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# alert uses Bash history formatting, so it remains Bash-specific.
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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
    if [ $? == 0 ]; then
        echo -ne ""
    else
        echo -ne "${rred}"
    fi
}

sec_env() {
    if [ -n "${SEC_ENV:-}" ]; then
        local red="${rred:-\[\033[1;31m\]}"
        echo -ne "${red}(${SEC_ENV})${rst} "
    fi
}

scm() {
    info=""

    if [ -d "$(git rev-parse --git-dir 2>/dev/null)" ]; then
        if git config --local --get remote.origin.url >/dev/null 2>/dev/null; then
            git_color="${lcyn}"
            branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        elif git config --local --get svn-remote.svn.url >/dev/null 2>/dev/null; then
            git_color="${lpur}"
            branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        fi
    fi

    if [ -n "$branch" ]; then
        info=" ${info}[${git_color}${branch}${rst}]${rst}"
    else
        info=" "
    fi

    echo -ne "$info"
}

PS1="\$(sec_env)${user_color:-${lblu}}\\u${rst}@${host_color:-${rgrn}}${host_alias:-\\h}${rst} \$(exitstatus)\\w${rst}\$(scm)\\$ "
PS2="${lylw}> ${rst}"