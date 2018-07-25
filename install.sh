#bin/sh
brew install vim
brew install tmux
brew install cmake
brew install zsh
brew install rbenv
brew install tig

eval "$(rbenv init -)"

ln -s .vimrc ~/.vimrc
ln -s .vimrc.after ~/.vimrc.after
ln -s .vimrc.before ~/.vimrc.before
ln -s .zshrc ~/.zshrc
ln -s .zshrc.history ~/.zshrc.history
ln -s .working_man.yml ~/.working_man.yml
ln -s tmuxinator.yml ~/tmuxinator.yml
ln -s .gitconfig ~/.gitconfig
curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh


~/.vim/bundle/YouCompleteMe/install.py --clang-completer

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

#needed for middleman
gem install bundler
gem install eventmachine -- --with-cppflags=-I/usr/local/opt/openssl/include  
