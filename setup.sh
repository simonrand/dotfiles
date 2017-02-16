# Originally: http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac

if [ "$1" == "upgrade" ]; then
  echo "upgrading system.."
  command=upgrade
else
  echo "installing system.."
  command=install
fi

# Get some inputs
echo Enter your email address:
read email
echo Enter your system username:
read username

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
  alfred
  banktivity
  betterzipql
  dash
  dropbox
  duet
  google-chrome
  google-drive
  handbrake
  iterm2
  polymail
  postico
  qbittorrent
  qlcolorcode
  qlimagesize
  qlmarkdown
  qlprettypatch
  quicklook-csv
  quicklook-json
  sequel-pro
  sketchup
  skype
  slack
  sublime-text
  superduper
  suspicious-package
  transmit
  vlc
)

# Install apps to /Applications
echo "installing apps..."
brew cask install ${apps[@]}

# Link subl to st
echo "linking st -> subl..."
ln -s /usr/local/bin/subl /usr/local/bin/st

# # Copy latest dotfiles
echo "copying dotfiles"
cp ./.bash_profile ~/.bash_profile
cp ./.gemrc ~/.gemrc
cp ./.railsrc ~/.railsrc

# NOTE: item2 plist will only work with /Users/simon home folder
cp ./iterm/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

sed "s/\[email\]/$email/" .gitconfig > ./.gitconfig_complete
sed -i '' "s/\[username\]/$username/" ./.gitconfig_complete
cp ./.gitconfig_complete ~/.gitconfig && rm ./.gitconfig_complete
cp ./.gitignore ~/.gitignore

configs=( bundle ssh )
for config in "${configs[@]}"
do
  mkdir -p ~/.$config
  cp ./.$config/config ~/.$config/config
done

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

# Generate an SSH key (if none exist)
if [ ! -f ~/.ssh/id_rsa ]; then
  mkdir ~/.ssh
  ssh-keygen -t rsa -b 4096 -C "$email"
  ssh-add ~/.ssh/id_rsa
fi

# Tidy up
echo "tidying..."
brew cleanup

# App store apps
echo "app store:"
echo "  [ ] 1Password"
echo "  [ ] Affinity Designer"
echo "  [ ] Affinity Photo"
echo "  [ ] Base"
echo "  [ ] Clear"
echo "  [ ] Divvy"
echo "  [ ] iA Writer"
echo "  [ ] Numbers"
echo "  [ ] Pages"
echo "  [ ] Tweetbot"
echo "  [ ] Xcode"
echo "..."

# Divvy shortcuts
echo "divvy shortcuts:"
echo "divvy://import/YnBsaXN0MDDUAQIDBAUIVldUJHRvcFgkb2JqZWN0c1gkdmVyc2lvblkkYXJjaGl2ZXLRBgdUcm9vdIABqgkKFCssMztCSlJVJG51bGzSCwwNDlYkY2xhc3NaTlMub2JqZWN0c4AJpQ8QERITgAKABYAGgAeACN0VFhcYGRobHB0eHyALISIjJCIiJSYnJiklKl8QEnNlbGVjdGlvbkVuZENvbHVtbl8QEXNlbGVjdGlvblN0YXJ0Um93XGtleUNvbWJvQ29kZVdlbmFibGVkXWtleUNvbWJvRmxhZ3NfEBRzZWxlY3Rpb25TdGFydENvbHVtbltzaXplQ29sdW1uc1pzdWJkaXZpZGVkV25hbWVLZXlWZ2xvYmFsXxAPc2VsZWN0aW9uRW5kUm93WHNpemVSb3dzEAMQABASCRAICIADCBAHgARQ0i0uLzJYJGNsYXNzZXNaJGNsYXNzbmFtZaIwMVhTaG9ydGN1dFhOU09iamVjdFhTaG9ydGN1dN0VFhcYGRobHB0eHyALKSI0JCI2JSYnJiklKhATCRAECIADCIAE3RUWFxgZGhscHR4fIAspIjwkIiIlJicmKSUqEBQJCIADCIAE3RUWFxgZGhscHR4fIAspIkMkIkUlJicmKSUqEBcJEAYIgAMIgATdFRYXGBkaGxwdHh8gC0siTCQiIiUmJyYpJSoQBRAVCQiAAwiABNItLlNUo1RVMV5OU011dGFibGVBcnJheVdOU0FycmF5EgABhqBfEA9OU0tleWVkQXJjaGl2ZXIACAARABYAHwAoADIANQA6ADwARwBNAFIAWQBkAGYAbABuAHAAcgB0AHYAkQCmALoAxwDPAN0A9AEAAQsBEwEaASwBNQE3ATkBOwE8AT4BPwFBAUIBRAFGAUcBTAFVAWABYwFsAXUBfgGZAZsBnAGeAZ8BoQGiAaQBvwHBAcIBwwHFAcYByAHjAeUB5gHoAekB6wHsAe4CCQILAg0CDgIPAhECEgIUAhkCHQIsAjQCOQAAAAAAAAIBAAAAAAAAAFgAAAAAAAAAAAAAAAAAAAJL"

echo "final notes:"
echo "[ ] Finder - Make menu bar dark"
echo "[ ] Finder - Add home folder to sidebar and make default folder"
echo "[ ] Safari - Install Ghostery, Shut Up and 1Password extension"
echo "[ ] Safari - Turn on Developer menu"
echo "Set up sync folders:"
echo "[ ] Alfred"
echo "[ ] Dash"
echo "..."

echo "done!"
