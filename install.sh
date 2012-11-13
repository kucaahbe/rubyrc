#!/bin/sh

# install configuration files in home directory
ln -svf $PWD/gemrc ~/.gemrc
ln -svf $PWD/irbrc ~/.irbrc

RAILS_TEMPLATES=$PWD/rails-templates
cd $RAILS_TEMPLATES; sh install.sh; cd ..

echo symlinks created

if [ "$1" = "--init" ]
then
  RBENV_URL='git://github.com/sstephenson/rbenv.git'
  RBENV_GEMSET_URL='git://github.com/jamis/rbenv-gemset.git'
  RUBY_BUILD_URL='git://github.com/sstephenson/ruby-build.git'

  GIT_CLONE='git clone --'

  rm -rf $HOME/.rbenv

  echo installing rbenv
  $GIT_CLONE $RBENV_URL         $HOME/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $HOME/.zshenv.local
  echo 'eval "$(rbenv init -)"'               >> $HOME/.zshenv.local
  mkdir -p $HOME/.rbenv/plugins

  sleep 1
  echo installing rbenv-gemset
  $GIT_CLONE $RBENV_GEMSET_URL  $HOME/.rbenv/plugins/rbenv-gemset

  sleep 1
  echo installing ruby-build
  $GIT_CLONE $RUBY_BUILD_URL  $HOME/.rbenv/plugins/ruby-build

  echo restart $SHELL now
else
  echo
  echo use $0 --init to bootstrap rbenv
fi
