# Neal K's Dotfiles

Dotfile repository for nkaviratna

## Prereqs

- install zsh: https://gist.github.com/derhuerst/12a1558a4b408b3b2b6e
- install tmux: `sudo apt-get install tmux`
- install git, bash if your distro doesn't have it already D:

## Setup

1. clone repository to /home/nkaviratna/.dotfiles
2. create symlinks listed below
3. apply zprezto patch to submodule
4. run compaudit in zsh to ensure no permissions / ownership needs to change

### Symlinks:
- ln ~/.dotfiles/zshrc /home/nkaviratna/.zprezto/runcoms/zshrc -s && ls /home/nkaviratna/.zprezto/runcoms/zshrc -lsa
- ln ~/.dotfiles/zsh ~/.zsh -s && ls ~/.zsh -lsa
- ln ~/.dotfiles/bashrc ~/.bashrc -s && ls ~/.bashrc -lsa
- ln ~/.dotfiles/gitconfig ~/.gitconfig -s && ls ~/.gitconfig -lsa
- ln ~/.dotfiles/zprezto ~/.zprezto -s && ls ~/.zprezto -lsa
- ln ~/.dotfiles/zpreztorc ~/.zpreztorc -s && ls ~/.zpreztorc -lsa
- ln ~/.dotfiles/tmux.conf ~/.tmux.conf -s && ls ~/.tmux.conf -lsa

## Notes:

- Only contains cli useful dotfiles at the moment

## License

tbd
