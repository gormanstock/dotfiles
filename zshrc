#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# don't complete remotes for tab complete
__git_commit_tags() {}
__git_heads_remote() {}
zstyle :completion::complete:git-checkout:argument-rest:headrefs command "git for-each-ref --format='%(refname)' refs/heads 2>/dev/null"
zstyle :completion::complete:git-show:argument-rest:headrefs command "git for-each-ref --format='%(refname)' refs/heads 2>/dev/null"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# non git aliases
alias ga="git add"
alias gr="git restore"
alias gc="git commit -m"
alias deepclean="docker system prune --all"
alias open="gp open"
alias stop="gp stop"
alias back="cd -"
alias home="cd /workspace/gitpod-dev-environment"
alias k="kubectl"
alias tf="terraform"
alias awsk8="aws eks --region us-east-2 update-kubeconfig --name"
alias port-dev-backend="awsk8 ot-dev-eks && gp ports visibility 8000:public && k port-forward deployments/django-backend -n ot-dev-service 8000:8000"
alias port-staging-backend="awsk8 ot-dev-eks && gp ports visibility 8000:public && k port-forward deployments/django-backend -n ot-staging-service 8000:8000"
alias service="cd /workspace/gitpod-dev-environment/service"
alias frontend="cd /workspace/gitpod-dev-environment/service/frontend"
alias backend="cd /workspace/gitpod-dev-environment/service/backend"
alias compute-service="cd /workspace/gitpod-dev-environment/compute-service"
alias models="cd /workspace/gitpod-dev-environment/models"
alias gitcommands="git config --list --show-origin"
alias updatedotfiles="cd ~/.dotfiles && git nored && git pull"
alias calogin="aws codeartifact login --repository pypi-store --domain ottertune --tool"
alias zsh{config,rc}="gp open ~/.dotfiles/zshrc"
alias c="clear"
alias x="exit"
alias dotfiles="cd ~/.dotfiles"
alias work="cd /workspace/gitpod-dev-environment"
alias req="pip install -r requirements.txt"
alias nodoze="gp timeout extend"
alias h="history -10" # last 10 history commands
alias hc="history -c" # clear history
alias hg="history | grep " # +command
alias ag="alias | grep "

hash -d he_do_be_workin_tho="/workspace/gitpod-dev-environment"


cd ~he_do_be_workin_tho
#----------------------------------------------------------
# COMPLETION SETTINGS
# add custom completion scripts
fpath=(~/.zsh/completion $fpath) 

# compsys initialization
autoload -U compinit
compinit

# show completion menu when number of options is at least 2
zstyle ':completion:*' menu select=2
#----------------------------------------------------------

export HISTSIZE=10000
export HISEFILESIZE=10000
export HISTFILE=/workspace/.zhistory

export PATH=/ide/bin:$PATH

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change. (From gitpod)
export PATH="$PATH:$HOME/.rvm/bin"

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
export JAVA_HOME=/home/linuxbrew/.linuxbrew

export CODEARTIFACT_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain ottertune --domain-owner 691523222388 --query authorizationToken --output text`
export REACT_APP_API_BASE=`gp url 8000`
export REACT_APP_STATIC_IMAGE_BASE=`gp url 8000`/static/
export VITE_API_BASE=`gp url 8000`
export VITE_STATIC_IMAGE_BASE=`gp url 8000`/static/
export ALLOWED_HOSTS=".gitpod.io"
export DISPLAY=:0
test -v GITPOD_REPO_ROOT && gp-vncsession
