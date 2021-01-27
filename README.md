# Neal K's Dotfiles

Dotfile repository for nkaviratna

Either follow the install guide below, or use the dockerfile to create an image (meant for gitpod usage)

----

## Prereqs

- install zsh: https://gist.github.com/derhuerst/12a1558a4b408b3b2b6e
- install tmux: `sudo apt-get install tmux`
- install git, bash if your distro doesn't have it already D:

## Setup

1. clone repository to /home/nkaviratna/.dotfiles
2. intialize and update zprezto submodule and it's own submodules
3. create symlinks listed below
4. run compaudit in zsh to ensure no permissions / ownership needs to change

### Symlinks:
- ln ~/.dotfiles/zprezto ~/.zprezto -s -b && ls ~/.zprezto -lsa
- ln ~/.dotfiles/zshrc /home/nkaviratna/.zprezto/runcoms/zshrc -s -b && ls /home/nkaviratna/.zprezto/runcoms/zshrc -lsa
- ln ~/.dotfiles/zshrc ~/.zshrc -s -b && ls ~/.zshrc -lsa
- ln ~/.dotfiles/zsh ~/.zsh -s -b && ls ~/.zsh -lsa
- ln ~/.dotfiles/bashrc ~/.bashrc -s -b && ls ~/.bashrc -lsa
- ln ~/.dotfiles/gitconfig ~/.gitconfig -s -b && ls ~/.gitconfig -lsa
- ln ~/.dotfiles/zpreztorc ~/.zpreztorc -s -b && ls ~/.zpreztorc -lsa
- ln ~/.dotfiles/tmux.conf ~/.tmux.conf -s -b && ls ~/.tmux.conf -lsa
