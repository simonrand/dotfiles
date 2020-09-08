####################################################################### dotfiles

cd $(dirname $0)

echo "copying dotfiles and global configs.."
cp ../.zshrc ~/.zshrc
cp ../.gemrc ~/.gemrc
cp ../.railsrc ~/.railsrc

# default configs
configs=( bundle ssh )
for config in "${configs[@]}"
do
  mkdir -p ~/.$config
  cp ../.$config/config ~/.$config/config
done
