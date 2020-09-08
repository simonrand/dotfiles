############################################################################ SSH

# Generate a SSH key (if none exist)
if [ ! -f ~/.ssh/id_rsa ]; then
  echo Enter your ssh key email address:
  read email

  echo "generating ssh key.."
  mkdir ~/.ssh
  ssh-keygen -t rsa -b 4096 -C "$email"
  ssh-add ~/.ssh/id_rsa
fi
