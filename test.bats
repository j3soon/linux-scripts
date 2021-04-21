#!/usr/bin/env bats

@test "install" {
  SCRIPT="$BATS_TEST_DIRNAME/install-to-bashrc.sh"
  TEMP_DIR="$(mktemp -d)"
  # Mock home directory
  export HOME="$TEMP_DIR"
  BASHRC="$HOME/.bashrc"
  [ ! -f $BASHRC ]
  run touch $BASHRC
  [ -f $BASHRC ]
  run $SCRIPT
  [ "$status" -eq 0 ]
  result="$(cat $BASHRC)"
  content="export PATH=$BATS_TEST_DIRNAME:\$PATH"
  expected="$(echo $content)" # Add trailing newline
  [ "$result" = "$expected" ]
  run $SCRIPT
  [ "$status" -eq 1 ]
  [ "$result" = "$expected" ]
  rm -rf -- $TEMP_DIR # May not execute due to error
}

@test "print global IP" {
  SCRIPT="$BATS_TEST_DIRNAME/print-global-ip.sh"
  run $SCRIPT
  result=$output
  [ "$status" -eq 0 ]
  ip="$(curl https://ipinfo.io/ip)"
  expected="$(echo $ip)" # Add trailing newline
  [ "$result" = "$expected" ]
}

@test "download .gitignore" {
  SCRIPT="$BATS_TEST_DIRNAME/download-gitignore.sh"
  TEMP_DIR="$(mktemp -d)"
  cd $TEMP_DIR
  # Test Error: No argument
  run $SCRIPT
  [ "$status" -eq 1 ]
  # Test Error: Language not supported
  run $SCRIPT 123
  [ "$status" -eq 1 ]
  # Test Python
  run $SCRIPT Python
  [ "$status" -eq 0 ]
  [ -f "$TEMP_DIR/.gitignore" ]
  run rm $TEMP_DIR/.gitignore
  [ ! -f "$TEMP_DIR/.gitignore" ]
  # Test cpp
  run $SCRIPT cpp
  [ "$status" -eq 0 ]
  [ -f "$TEMP_DIR/.gitignore" ]
  run rm $TEMP_DIR/.gitignore
  [ ! -f "$TEMP_DIR/.gitignore" ]
  # Test Error: .gitignore exist
  run touch .gitignore
  run $SCRIPT 123
  [ "$status" -eq 1 ]
  rm -rf -- $TEMP_DIR # May not execute due to error
}

@test "git commit empty" {
  SCRIPT="$BATS_TEST_DIRNAME/git-commit-empty.sh"
  TEMP_DIR="$(mktemp -d)"
  cd $TEMP_DIR
  run git init
  run git config --get user.name
  if [ "$status" -ne 0 ]; then
    git config user.email "you@example.com"
    git config user.name "Your Name"
  fi
  # Test Normal
  run git log
  echo $output
  [ "$status" -ne 0 ]
  run $SCRIPT
  echo $output
  [ "$status" -eq 0 ]
  run git log
  [ "$status" -eq 0 ]
  # Test Error: Contain commit
  run git log
  [ "$status" -eq 0 ]
  run $SCRIPT
  [ "$status" -eq 1 ]
  rm -rf -- $TEMP_DIR # May not execute due to error
}