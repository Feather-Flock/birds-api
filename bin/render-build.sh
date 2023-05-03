#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle rails db:{drop,create,migrate,seed}
