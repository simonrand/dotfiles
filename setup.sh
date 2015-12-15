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
  iterm2
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
cp ./com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

# Tidy up
echo "tidying..."
brew cleanup
