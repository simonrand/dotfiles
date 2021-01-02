# Originally: http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac

if [ "$1" == "upgrade" ]; then
  echo "upgrading and resetting system.."
  command=upgrade
else
  echo "installing/resetting system.."
  command=install
fi

username=$(whoami)

################################################################### macOS tweaks

sh ./scripts/macos.sh

################################################################ macOS cli tools

echo "installing command line tools.."
xcode-select --install

####################################################################### Homebrew

sh ./scripts/homebrew.sh $command

####################################################################### dotfiles

sh ./scripts/dotfiles.sh

########################################################################### asdf

sh ./scripts/asdf.sh

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

########################################################################### done

echo "done!"
echo "....."
echo "uninstallable app list: ~/Sync/Library/dotfiles/uninstallable_apps.md"
echo "setup notes: ~/Sync/Library/dotfiles/notes.md"
