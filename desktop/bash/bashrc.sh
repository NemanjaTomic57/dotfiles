#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
PS1='[\u@\h \W]\$ '
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias open='xdg-open'
alias sc='cd ~/Documents/workspace/dotfiles/scripts/shell/bin/'
alias ws='cd ~/Documents/workspace/'
alias df='cd ~/Documents/workspace/dotfiles/desktop/'

# Shell scripts 
export PATH="$HOME/Desktop/dotfiles/scripts/shell/bin/:$PATH"
