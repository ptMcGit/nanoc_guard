# `nanoc` with `guard-nanoc`  #

## What is this? ##

An implementation of `nanoc` with `guard-nanoc` for Docker.

The goal of this project is to containerize a `nanoc` development environment.
`guard-nanoc` monitors files for changes.

## `entrypoint.sh` ##

The entrypoint script does the following:

- bundle installs any missing gems
- bundle installs `guard-nanoc`, if missing
- creates `Guardfile`, if none present
- executes `bundle exec nanoc` with `live` if no command arguments provided 

## How to use it ##

You'll want to bind mount your project folder to `/data`; you'll also want bind a port on the host to 3000 on the container:

``` Shell
docker run -v /home/bob/my_project:/data -p 3000:3000 skynarwhal/nanoc_with_guard
``` 



