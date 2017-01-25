# ubuntu-config
This project is for my ubuntu initial setting on vmware-tools

1. default-install.sh 
  
    > - tmux setting
    > - pip install 
    > - link vimrc
    > - link gitconfig

2. vmware-tools-install.sh 

    > - is just install about vmware-tools


# Installation
it is simple but,it need to follow this guide correctly. because of this shell script is wrack.

``` bash
#go to your Home
cd ~
#install git 
sudo apt install -y git
#clone this git
git clone https://github.com/Likemilk/ubuntu-config
#run below first. and read this file (there are some helpful comments)
./.dotfiles/default-install.sh 
#run below file second. and read this file( there are some helpful comments)
./.dotfiles/vmware-tools-install.sh 
```
the initial setting is done. **Congratulation.**

# Git Config

``` bash
git config --global user.name "drake-jin"
git config --global user.email dydwls121200@gmail.com 
git config --global core.editor vim
````



