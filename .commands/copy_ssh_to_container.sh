#!/bin/zsh

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <keyword>"
  exit 1
fi

keyword=$1

container_id=$(docker ps -a --filter "name=$keyword" --format "{{.ID}}")

# List private keys ignoring .pub files
keys=(~/.ssh/id_*(.))

num_keys=${#keys[@]}

if [ "$num_keys" -eq 0 ]; then
  echo "No private keys found."
  exit 1
fi

# Automatically select the key if there's only one option
if [ "$num_keys" -eq 1 ]; then
  private_key="${keys[1]}"
  echo "Automatically selected private key: $private_key"
else
  echo "Select a private key:"
  private_key=$(printf "%s\n" "${keys[@]}" | fzf)
fi

docker cp "$private_key" "${container_id}:/home/vscode/.ssh/$(basename $private_key)"

if [ "$?" -eq 0 ]; then
  echo "Private key successfully copied to the container."
else
  echo "Failed to copy the private key to the container."
fi
