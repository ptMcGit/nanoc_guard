#!/bin/bash

# Add gems, add/configure guard-nanoc, run the command

if_missing_guard_nanoc ()
{
    # or, is commented out
    [ -z "$(sed -n '/group :nanoc do/,/end/p' < Gemfile | grep -E '^[^#]+guard-nanoc' )" ] 
}

add_guard_nanoc ()
{
    # add to Gemfile
    sed -i '$a \\ngroup :nanoc do\n  gem \x27guard-nanoc\x27\nend' Gemfile
}

create_guard_file ()
{
    bundle exec guard init nanoc 
}

start_nanoc_with_guard ()
{
    "bundle exec nanoc live"
}

# expecting that app root directory is current directory

[ -z "$(ls $(pwd) )" ] && {
    echo "Did you forget to mount a volume with your project in it?" >&2
    exit 1
}

# Install needed gems

bundle check &> /dev/null || {
    bundle check | sed '$d' >&2
    echo "Installing missing gems..." >&2
    bundle install
}

# guard-nanoc gem

if_missing_guard_nanoc && {
    echo "No valid 'guard-nanoc' entry found in Gemfile." >&2
    echo "Adding 'guard-nanoc' to Gemfile." >&2
    add_guard_nanoc
}

# Add Guardfile, if none

[ -f ./Guardfile ] || {
    echo "No guard file found. Creating one." >&2
    create_guard_file
}

exec bundle exec nanoc "$@"
