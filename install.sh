# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew install -y git vim tree tig fzf the_silver_searcher zsh-syntax-highlighting wget
brew upgrade vim
brew cask install iterm2

# install fonts
cd ~
git clone https://github.com/powerline/fonts.git
cd ~/fonts
./install.sh
cd ~
rm -rf ~/fonts

# zsh install
export ZSH="$HOME/.oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /bin/zsh

# powerlevel 9k install
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
# Then edit your ~/.zshrc and set ZSH_THEME="powerlevel9k/powerlevel9k".
# terminal iterm2 theme
mkdir ~/themes
mkdir ~/themes/iterm2
cd ~/themes/iterm2
wget https://github.com/mbadolato/iTerm2-Color-Schemes/tarball/master
mv master master.tar.gz
tar xvf master.tar.gz
rm master.tar.gz
cd ~/


#Tmux를 설치합니다.
sudo easy_install pip
sudo pip install psutil tmuxp
cp ~/.tmux/vendor/basic-cpu-and-memory.tmux /usr/local/bin/tmux-mem-cpu-load
chmod +x /usr/local/bin/tmux-mem-cpu-load
# tmux Notice #1
#To start a session:
#	tmux
#To reattach a previous session:
#	tmux attach
#To reload config file
#<Control + b>: (which could Ctrl-B or Ctrl-A if you overidden it) then source-file ~/.tmux.conf

# tmux Notice #2  tmux setting  one time

# For mouse support (for switching panes and windows)
# Only needed if you are using Terminal.app (iTerm has mouse support)
# Install http://www.culater.net/software/SIMBL/SIMBL.php
# Then install https://bitheap.org/mouseterm/

# More on mouse support http://floriancrouzat.net/2010/07/run-tmux-with-mouse-support-in-mac-os-x-terminal-app/

# Enable mouse support in ~/.tmux.conf
# set-option -g mouse-select-pane on
# set-option -g mouse-select-window on
# set-window-option -g mode-mouse on

# Install Teamocil to pre define workspaces
# https://github.com/remiprev/teamocil

# See http://files.floriancrouzat.net/dotfiles/.tmux.conf for configuration examples


echo "vimrc를 설치합니다"
# https://github.com/amix/vimrc
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.sh


# NVM 을 install합니다.
echo "nodejs 버전관리 프로그램인 nvm을 설치합니다."
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# zshrcCustom의 셋업을 불러옵니다.
echo "source ~/.dotfiles/zshrcCustom" >> ~/.zshrc
source ~/.zshrc

# .gitconfig를 옮깁니다.
ln -s ~/dotfiles/gitconfig ~/.gitconfig



echo "설치가 끝났으면 install.sh를 참고 하여 아직 남은 셋팅들에 대해서 마무리 해주세요."
echo "1. iTerm의 폰트 및 터미널 색상변경"
# 터미널 프로파일 들어가서 ~/themes/iterm2/mbadolato-iTerm2-Color-Schemes-d6098c7/terminal/Solarized\ Dark.terminal  이걸 가져오기 하면 됨




