#bin/sh
brew install vim
brew install tmux
brew install cmake
brew install zsh
brew install rbenv
brew install tig

eval "$(rbenv init -)"

ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.vimrc.after ~/.vimrc.after
ln -s ~/dotfiles/.vimrc.before ~/.vimrc.before
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.zshrc.history ~/.zshrc.history
ln -s ~/dotfiles/.working_man.yml ~/.working_man.yml
ln -s ~/dotfiles/tmuxinator.yml ~/tmuxinator.yml
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh


~/.vim/bundle/YouCompleteMe/install.py --clang-completer

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

#needed for middleman
gem install bundler
gem install eventmachine -- --with-cppflags=-I/usr/local/opt/openssl/include  
