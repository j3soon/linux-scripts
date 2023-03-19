# Linux Scripts

[![Test suite status](https://github.com/j3soon/linux-scripts/actions/workflows/main.yml/badge.svg?branch=master&event=push)](https://github.com/j3soon/linux-scripts/actions/workflows/main.yml)

Most of the scripts are only tested on Ubuntu, and may require changes when running on other distros.

## Run Once

You can run individual scripts by `curl`.

Take `init-ubuntu` as an example:

```sh
sudo apt-get update
sudo apt-get install -y curl && bash -c "$(curl -fsSL https://raw.githubusercontent.com/j3soon/linux-scripts/master/init-ubuntu.sh)"
```

## Clone the Repo

```sh
git clone https://github.com/j3soon/linux-scripts.git
cd linux-scripts
```

## Installation

You can install the directory to `$PATH`:

```sh
# If using bash
./install-to-bashrc.sh
# If using zsh
./install-to-zshrc.sh
```

## Testing

Install [bats](https://github.com/sstephenson/bats).

```
./test.bats
# or bats test.bats
```