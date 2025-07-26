#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
PS1='[\u@\h \W]\$ '
alias ls='ls --color=auto'

# Custom aliases
alias grep='grep --color=auto'
alias open='xdg-open'

# Kubernetes aliases
alias k='kubectl'
alias kgp='kubectl get pods'
alias kdr='kubectl --dry-run=client'
alias kgs='kubectl get svc'
alias kdesc='kubectl describe'
alias kga='kubectl get all'

# Composer for PHP
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Cargo for Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Gem for Ruby
export PATH="$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH"

# uv path
. "$HOME/.local/bin/env"

if [ -f "$HOME/.bashrc.local" ]; then
  source "$HOME/.bashrc.local"
fi
