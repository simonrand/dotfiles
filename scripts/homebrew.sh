####################################################################### homebrew

cd $(dirname $0)

if [ "$1" == "upgrade" ]; then
  command=upgrade
else
  command=install
fi

# Check for homebrew, install if we don't have it
if test ! $(which brew); then
  echo "installing homebrew.."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "updating homebrew.."
brew update

# Packages
packages=$(cat ~/Sync/Library/dotfiles/packages)

echo "installing homebrew packages.."
brew $command ${packages[@]}

# Casks
casks=$(cat ~/Sync/Library/dotfiles/casks)

echo "installing homebrew casks.."
brew cask $command ${casks[@]}

########################################################################### tidy

echo "tidying..."
brew cleanup
rm -rf "$(brew --cache)"
