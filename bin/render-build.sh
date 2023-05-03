#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle rake db:{drop,create,migrate,seed}
