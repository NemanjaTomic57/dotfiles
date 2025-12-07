#
# ~/.bashrc
#

# NOTE:
# OSH_THEME="brainy"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
PS1='[\u@\h \W]\$ '
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias open='xdg-open'
alias sc='cd ~/Documents/workspace/dotfiles/scripts/shell/bin/'
alias ws='cd ~/Documents/workspace/'
alias dotfiles='cd ~/Documents/workspace/dotfiles/desktop/'
alias sourcebash='source /home/nemo/Documents/workspace/dotfiles/desktop/bash/bashrc.sh'

# Shell scripts 
export PATH="$HOME/Desktop/dotfiles/scripts/shell/bin/:$PATH"

# pyenv for managing non-system python versions
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"
