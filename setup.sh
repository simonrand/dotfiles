# Originally: http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac

if [ "$1" == "upgrade" ]; then
  echo "upgrading and resetting system.."
  command=upgrade
else
  echo "installing/resetting system.."
  command=install
fi

username=$(whoami)

################################################################ macOS cli tools

echo "installing command line tools.."
xcode-select --install

sh ./scripts/homebrew.sh $command

####################################################################### dotfiles

sh ./scripts/dotfiles.sh

############################################################################ SSH

sh ./scripts/ssh.sh

############################################################################ Git

sh ./scripts/git.sh

########################################################################## Files

echo "copying files.."
cp ./files/FiraMono-Regular.otf ~/Library/Fonts/
cp ./files/FiraMono-Bold.otf ~/Library/Fonts/

################################################################### Sublime Text

sh ./scripts/sublime_text.sh

################################################################### macOS tweaks

sh ./scripts/macos.sh

########################################################################### tidy

echo "tidying..."
brew cleanup

########################################################################### done

echo "done!"
echo "....."
echo "full app list: ~/Library/Mobile\ Documents/com~apple~CloudDocs/Library/apps.md"
echo "setup notes: ~/Library/Mobile\ Documents/com~apple~CloudDocs/Library/notes.md"
