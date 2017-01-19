#!bin/bash

sudo apt-get install -y tmux zsh vim git gcc make cmake python-pip
#dot vimrc setting
sudo apt-get install -y vim-gtk ack-grep ctags
pip install --upgrade pip

#setting tmux 
#https://github.com/tony/tmux-config
#(all setting is following this git page)

git clone https://github.com/tony/tmux-config.git ~/.tmux
ln -s ~/.tmux/.tmux.conf ~/.tmux.conf
cd ~/.tmux
git submodule init
git submodule update
cd ~/.tmux/vendor/tmux-mem-cpu-load
cmake .
make
sudo make install
cd ~
tmux source-file ~/.tmux.conf
sudo pip install psutil
sudo cp ~/.tmux/vendor/basic-cpu-and-memory.tmux /usr/local/bin/tmux-mem-cpu-load
sudo chmod +x /usr/local/bin/tmux-mem-cpu-load
#tmux Setting Notice
#To start a session:
#	tmux
#To reattach a previous session:
#	tmux attach
#To reload config file
#<Control + b>: (which could Ctrl-B or Ctrl-A if you overidden it) then source-file ~/.tmux.conf




#setting powerline fonts
git clone https://github.com/powerline/fonts
cd fonts
./install.sh
cd ..
rm -rf fonts

#setting tmuxp
#It is save your workspace(detail is referred to this page 
#http://tmuxp.git-pull.com/en/latest/quickstart.html
#this page is tutorial about tmuxp
pip install tmuxp

#dot vimrc config 
#https://github.com/humiaozuzu/dot-vimrc

git clone git://github.com/humiaozuzu/dot-vimrc.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vi ubuntu-config/dot-vimsetting


# the end.








