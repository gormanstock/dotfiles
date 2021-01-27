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
RUN cd /home/gitpod/.dotfiles && git rev-parse HEAD
RUN cd /home/gitpod/.dotfiles && git submodule update --init --recursive

# remove existing files
RUN rm ~/.bashrc || rm ~/.gitconfig || rm /home/gitpod/.zprezto/runcoms/zshrc

# symlinks
RUN ln ~/.dotfiles/zshrc /home/gitpod/.zprezto/runcoms/zshrc -s && ls /home/gitpod/.zprezto/runcoms/zshrc -lsa
RUN ln ~/.dotfiles/zshrc ~/.zshrc -s && ls ~/.zshrc -lsa
RUN ln ~/.dotfiles/zsh ~/.zsh -s && ls ~/.zsh -lsa
RUN ln ~/.dotfiles/bashrc ~/.bashrc -s && ls ~/.bashrc -lsa
RUN ln ~/.dotfiles/gitconfig ~/.gitconfig -s && ls ~/.gitconfig -lsa
RUN ln ~/.dotfiles/zprezto ~/.zprezto -s && ls ~/.zprezto -lsa
RUN ln ~/.dotfiles/zpreztorc ~/.zpreztorc -s && ls ~/.zpreztorc -lsa
RUN ln ~/.dotfiles/tmux.conf ~/.tmux.conf -s && ls ~/.tmux.conf -lsa


