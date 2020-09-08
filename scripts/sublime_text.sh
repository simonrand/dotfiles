################################################################### Sublime Text

cd $(dirname $0)

echo "setting up sublime text.."

# Install Package Control for Sublime 3 and setup
package_path=~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages
if [ ! -f "$package_path"/Package\ Control.sublime-package ]; then
  echo "downloading sublime text package control.."
  mkdir -p "$package_path"
  wget https://packagecontrol.io/Package%20Control.sublime-package -O "$package_path"/Package\ Control.sublime-package
fi

# Link subl to st
if [[ -f /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl && ! -f /usr/local/bin/st ]]; then
  echo "linking st -> subl..."
  ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/st
fi

# Copy config files
cp ../sublime-text3/* ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
