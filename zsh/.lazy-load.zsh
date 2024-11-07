#!/usr/bin/env zsh

#lengthAfterTransforming Create wrappers around common nvm consumers.
# nvm, node, yarn and npm will load nvm.sh on their first invocation,
# posing no start up time penalty for the shells that aren't going to use them at all.
# There is only single time penalty for one shell.

load-cargo(){
    export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
    export PATH=$PATH:$JAVA_HOME/bin
    . "$HOME/.cargo/env"
}

load-nvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

nvm() {
    unset -f nvm
    load-nvm
    nvm "$@"
}

node() {
    unset -f node
    load-nvm
    node "$@"
}

npm() {
    unset -f npm
    load-nvm
    npm "$@"
}

pnpm() {
    unset -f pnpm
    load-nvm
    pnpm "$@"
}

yarn() {
    unset -f yarn
    load-nvm
    yarn "$@"
}

function cd() {
    builtin cd "$@"
    pwd > ~/.current_dir
}
