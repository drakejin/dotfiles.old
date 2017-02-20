#/bin/sh
###########      signature       ###########
# @version 0.1
# @last-update : 2017-02-20
# @file : python-install.sh 
# @git : https://github.com/drake-jin/.dotfiles 
# @desc : 
#   1. install pyenv, autoenv and virtualenv 
#   2. etc utilities for developing python environment
#
# !!Notice :
#    this setting can't control well-known port cuase' Develop language is owned for normal user.
#   therefore, if you use well-known port, You should use ufw to redirect to non well-known ports from well-knowns.
################################################

#Requirements


sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils

#pyenv install
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | zsh

#virtualenv install
git clone https://github.com/yyuu/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

#autoenv install
git clone git://github.com/kennethreitz/autoenv.git ~/.autoenv
exec "$SHELL"


