############################################################################ Git

cd $(dirname $0)

echo "setting up git.."
cp ../.gitignore ~/.gitignore

# Generate a gitconfig file (if none exists)
if [ ! -f ~/.gitconfig ]; then
  echo Enter your Git config email address:
  read email

  sed "s/\[email\]/$email/" ../.gitconfig > ./.gitconfig_complete
  sed -i '' "s/\[username\]/$username/" ./.gitconfig_complete
  cp ./.gitconfig_complete ~/.gitconfig && rm ./.gitconfig_complete
fi
