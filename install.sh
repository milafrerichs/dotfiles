#bin/sh
brew install neovim
brew install tmux
brew install cmake
brew install zsh
brew install tig

ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.vimrc.after ~/.vimrc.after
ln -s ~/dotfiles/.vimrc.before ~/.vimrc.before
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.zshrc.history ~/.zshrc.history
ln -s ~/dotfiles/.working_man.yml ~/.working_man.yml
ln -s ~/dotfiles/tmuxinator.yml ~/tmuxinator.yml
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/justfile ~/justfile
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

#needed for middleman
gem install bundler
gem install eventmachine -- --with-cppflags=-I/usr/local/opt/openssl/include  
