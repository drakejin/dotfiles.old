


echo "vimrc를 설치합니다"
# https://github.com/amix/vimrc
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.sh


echo "nodejs 버전관리 프로그램인 nvm을 설치합니다."
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash



# zshrcCustom의 셋업을 불러옵니다.
echo "source ~/.dotfiles/zshrcCustom" >> ~/.zshrc
source ~/.zshrc

# nvm으로 nodejs설치
ln -s ~/dotfiles/gitconfig ~/.gitconfig


