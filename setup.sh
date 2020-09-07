# Originally: http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac

if [ "$1" == "upgrade" ]; then
  echo "upgrading and resetting system.."
  command=upgrade
else
  echo "installing system.."
  command=install
fi

######################################################################### Inputs

echo Enter your email address:
read email
username=$(whoami)

################################################################ macOS cli tools

echo "installing command line tools.."
xcode-select --install

####################################################################### homebrew

# check for homebrew, install if we don't have it
if test ! $(which brew); then
  echo "installing homebrew.."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# update homebrew
echo "updating homebrew.."
brew update

binaries=(
  asdf
  git
  hub
  rbenv
  rbenv-gemset
  ruby-build
  wget
  zsh-completions
)

echo "installing homebrew binaries.."
brew $command ${binaries[@]}

# homebrew cask apps
apps=(
  imageoptim
  nvalt
  qlcolorcode
  qlimagesize
  qlmarkdown
  quicklook-csv
  quicklook-json
  suspicious-package
)

echo "installing cask apps.."
brew cask install ${apps[@]}

####################################################################### dotfiles

echo "copying dotfiles and global configs.."
cp ./.zshrc ~/.zshrc
cp ./.gemrc ~/.gemrc
cp ./.railsrc ~/.railsrc

# default configs
configs=( bundle ssh )
for config in "${configs[@]}"
do
  mkdir -p ~/.$config
  cp ./.$config/config ~/.$config/config
done

############################################################################ SSH

# Generate an SSH key (if none exist)
if [ ! -f ~/.ssh/id_rsa ]; then
  echo "generating ssh key.."
  mkdir ~/.ssh
  ssh-keygen -t rsa -b 4096 -C "$email"
  ssh-add ~/.ssh/id_rsa
fi

############################################################################ Git

echo "setting up git.."
sed "s/\[email\]/$email/" .gitconfig > ./.gitconfig_complete
sed -i '' "s/\[username\]/$username/" ./.gitconfig_complete
cp ./.gitconfig_complete ~/.gitconfig && rm ./.gitconfig_complete
cp ./.gitignore ~/.gitignore

########################################################################## Files

echo "copying files.."
cp ./files/FiraMono-Regular.otf ~/Library/Fonts/
cp ./files/FiraMono-Bold.otf ~/Library/Fonts/

################################################################### Sublime Text

echo "setting up sublime text.."
# Link subl to st
if [[ -f /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl && ! -f /usr/local/bin/st ]]; then
  echo "linking st -> subl..."
  ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/st
fi
cp ./sublime-text3/* ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/

################################################################### macOS tweaks

echo "tweaking macOS.."

# Show ~/Library folder
chflags nohidden ~/Library
[[ $(xattr ~/Library) = com.apple.FinderInfo ]] && xattr -d com.apple.FinderInfo ~/Library

# Enable mouse right click
# NOTE: Restart required
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode TwoButton

# Safari dev menu
# NOTE: Ensure terminal app has been granted full disk access
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true && defaults write com.apple.Safari IncludeDevelopMenu -bool true && defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true && defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true && defaults write -g WebKitDeveloperExtras -bool true

########################################################################### tidy

echo "tidying..."
brew cleanup

########################################################################### done

echo "done!"
echo "....."
echo "full app list: ~/Library/Mobile\ Documents/com~apple~CloudDocs/Library/apps.md"
