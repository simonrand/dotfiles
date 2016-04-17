# Originally: http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac

if [ "$1" == "upgrade" ]; then
  echo "upgrading system.."
  command=upgrade
else
  echo "installing system.."
  command=install
fi

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
brew $command coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew $command findutils

# Install Bash 4
brew $command bash

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew $command homebrew/dupes/grep

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
brew $command ${binaries[@]}

# Install apps
# Apps
apps=(
  atom
  betterzipql
  dropbox
  flash
  google-chrome
  iterm2-beta
  polymail
  postico
  qlcolorcode
  qlimagesize
  qlmarkdown
  qlprettypatch
  quicklook-csv
  quicklook-json
  sequel-pro
  sublime-text3
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
  echo "downloading sublime text package control.."
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
echo "[ ] Safari - Install Ghostery"
echo "[ ] Safari - Turn on Developer menu"
echo "App Store:"
echo "  [ ] 1Password"
echo "  [ ] Affinity Designer"
echo "  [ ] Base"
echo "  [ ] Clear"
echo "  [ ] Divvy"
echo "  [ ] iaWriter"
echo "  [ ] Paste"
