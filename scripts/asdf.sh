########################################################################### asdf

echo "installing asdf plugins.."

asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
sh ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
