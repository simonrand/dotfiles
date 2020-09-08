####################################################################### homebrew

if [ "$1" == "upgrade" ]; then
  command=upgrade
else
  command=install
fi

# check for homebrew, install if we don't have it
if test ! $(which brew); then
  echo "installing homebrew.."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# update homebrew
echo "updating homebrew.."
# brew update

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
# brew $command ${binaries[@]}

# homebrew cask apps
apps=(
  alfred
  android-studio
  arduino
  balsamiq-wireframes
  brave-browser
  dandbrake
  dash
  drawio
  firefox
  google-chrome
  imageoptim
  insomnia
  iterm2
  licecap
  mullvadvpn
  notion
  nvalt
  postico
  proxyman
  qlcolorcode
  qlimagesize
  qlmarkdown
  quicklook-csv
  quicklook-json
  rectangle
  runjs
  sequel-pro
  sketchup
  slack
  sublime-merge
  sublime-text
  superduper
  suspicious-package
  syncthing
  teamviewer
  transmission
  transmit
  virtualbox
  vlc
  whatsapp
)

echo "installing cask apps.."
# brew cask $command ${apps[@]}

echo $command
