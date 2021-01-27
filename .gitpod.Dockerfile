FROM gitpod/workspace-full

USER gitpod

#
# Dotfiles and preferences
#

# Prereqs
RUN sudo apt-get update 
RUN sudo apt-get upgrade -y
RUN sudo apt-get install zsh -y
RUN sudo apt-get install tmux -y

# clone dotfiles
RUN git clone https://github.com/NealKaviratna/dotfiles.git /home/gitpod/.dotfiles
RUN cd /home/gitpod/.dotfiles && git reset HEAD . && git checkout -- . && git submodule update --recursive && git pull --recurse-submodules && git submodule update --recursive --remote && git submodule update --init --recursive  

# symlinks
RUN ln ~/.dotfiles/zprezto ~/.zprezto -s -b && ls ~/.zprezto -lsa
RUN ln ~/.dotfiles/zshrc /home/gitpod/.zprezto/runcoms/zshrc -s && ls /home/gitpod/.zprezto/runcoms/zshrc -lsa
RUN ln ~/.dotfiles/zshrc ~/.zshrc -s -b && ls ~/.zshrc -lsa
RUN ln ~/.dotfiles/zsh ~/.zsh -s -b && ls ~/.zsh -lsa
RUN ln ~/.dotfiles/bashrc ~/.bashrc -s -b && ls ~/.bashrc -lsa
RUN ln ~/.dotfiles/gitconfig ~/.gitconfig -s -b && ls ~/.gitconfig -lsa
RUN ln ~/.dotfiles/zpreztorc ~/.zpreztorc -s -b && ls ~/.zpreztorc -lsa
RUN ln ~/.dotfiles/tmux.conf ~/.tmux.conf -s -b && ls ~/.tmux.conf -lsa


