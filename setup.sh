# Originally: http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac

# Command line tools
echo "installing command line tools..."
xcode-select --install

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
echo "updating homebrew..."
brew update

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

binaries=(
  git
  bash-completion
  rbenv
  ruby-build
  rbenv-gemset
  elixir
  node
  postgres
  mysql
  nginx
  wget
)

echo "installing binaries..."
brew install ${binaries[@]}

# Homebrew Cask
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# Install apps
# Apps
apps=(
  divvy
  dropbox
  google-chrome
  flash
  iterm2-beta
  sublime-text3
  atom
  qlcolorcode
  qlmarkdown
  quicklook-json
  qlprettypatch
  quicklook-csv
  betterzipql
  qlimagesize
  suspicious-package
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

# Link subl to st
echo "linking st -> subl..."
ln -s /usr/local/bin/subl /usr/local/bin/st

# Copy latest dotfiles
echo "copying dotfiles"
cp ./.bash_profile ~/.bash_profile
cp ./.gemrc ~/.gemrc
cp ./iterm/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

# Install Package Control for Sublime 3 and setup
package_path=~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages
if [ ! -f "$package_path"/Package\ Control.sublime-package ]; then
  echo "Downloading Sublime Text Package Control.."
  mkdir -p "$package_path"
  wget https://packagecontrol.io/Package%20Control.sublime-package -O "$package_path"/Package\ Control.sublime-package
fi
cp ./sublime-text3/* ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

# OSX tweaks
chflags nohidden ~/Library/

# TODO Generate SSH keys (if none exist)

# Tidy up
echo "tidying..."
brew cleanup

# Final notes
echo "[ ] Add home folder to sidebar and make default folder"
echo "[ ] Install Ghostery"


