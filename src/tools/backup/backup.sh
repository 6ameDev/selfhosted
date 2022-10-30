#!/bin/bash

## Terminate if any command fails
set -e

## Source variables
source ~/.duplicity_env

## Remove old backups
duplicity remove-older-than 360D --force rclone://dropbox:/config

## Run backup
duplicity --verbosity info --encrypt-sign-key="$GPG_KEY" --full-if-older-than 30D --asynchronous-upload --log-file "/var/log/duplicity.log" --exclude '/var/data/config/duplicity' --include '/var/data/config/' --exclude '**' / rclone://dropbox:/config

## Cleanup
duplicity cleanup --force rclone://dropbox:/config

## Unset variables for safety
unset GPG_KEY
unset PASSPHRASE
