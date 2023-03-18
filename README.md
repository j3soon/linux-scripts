# Linux Scripts

[![Test suite status](https://github.com/j3soon/linux-scripts/actions/workflows/main.yml/badge.svg?branch=master&event=push)](https://github.com/j3soon/linux-scripts/actions/workflows/main.yml)

## Installation

```sh
git clone https://github.com/j3soon/linux-scripts.git
cd linux-scripts
./install-to-bashrc.sh
```

## Run Once

Take `init-ubuntu` as an example:

```sh
sudo apt install -y curl && sh -c "$(curl -sSL https://raw.githubusercontent.com/j3soon/linux-scripts/master/init-ubuntu.sh)"
```

## Testing

Install [bats](https://github.com/sstephenson/bats).

```
./test.bats
# or bats test.bats
```