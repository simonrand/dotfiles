configs=( bundle ssh )
for config in "${configs[@]}"
do
  cp ./.$config/config ~/.$config/config
done
