#/bin/sh
###########      signature       ###########
# @version 0.1
# @last-update : 2017-01-26
# @file : defualt-install.sh 
# @git : https://github.com/drake-jin/.dotfiles 
# @desc : tooooooooooo booooooooaaarrrrrrrrrriiiiinnnnnngggg first installation on ubuntu. then, i organized some commands.
#
################################################

#Init package installations
#Please Run install.sh on user auth. 
sudo apt-get install -y git vim tmux gcc make cmake

#Setting zsh
sudo apt-get install -y zsh
chsh -s `which zsh`
url -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
zsh
echo "source ~/.dotfiles/.user-value" >> ~/.zshrc

source ~/.zshrc

#install python2 or python3
sudo apt-get install -y python-pip python3-pip
pip install --upgrade pip
pip3 install --upgrade pip

#pip doesn't support grip package. 
#grip CLI program can work about reading and writting
#turn on any browser and enter localhost:6419 that port is default.
pip3 install grip
#for test execute this command $greop ~/.dotfile/README.md




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
./fonts/install.sh
rm -rf fonts


#setting tmuxp
#It is save your workspace(detail is referred to this page 
#http://tmuxp.git-pull.com/en/latest/quickstart.html
#this page is tutorial about tmuxp
pip install tmuxp


#fisa-vimrc + humiaozuzu-vimrc dependency
sudo apt-get install curl vim exuberant-ctags git ack-grep
sudo pip install pep8 flake8 pyflakes isort yapf

ln -s ~/.dotfiles/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/vimrc ~/.vimrc


