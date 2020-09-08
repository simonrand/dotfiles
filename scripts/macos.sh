################################################################### macOS tweaks

cd $(dirname $0)

echo "tweaking macOS.."

# Symlink iCloud Drive
if [ ! -f ~/iCloud ]; then
  ln -s ~/Library/Mobile\ Documents/com\~apple\~CloudDocs ~/iCloud
fi

# Show ~/Library folder
chflags nohidden ~/Library
[[ $(xattr ~/Library) = com.apple.FinderInfo ]] && xattr -d com.apple.FinderInfo ~/Library

# Enable mouse right click
# NOTE: Restart required
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode TwoButton && defaults write com.apple.AppleMultitouchMouse.plist MouseButtonMode TwoButton && defaults write ~/Library/Preferences/com.apple.driver.AppleHIDMouse.plist Button2 -int 2

# Safari dev menu
# NOTE: Ensure terminal app has been granted full disk access
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true && defaults write com.apple.Safari IncludeDevelopMenu -bool true && defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true && defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true && defaults write -g WebKitDeveloperExtras -bool true
