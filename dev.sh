#!/usr/bin/env bash

# adapted from https://github.com/dracula/visual-studio-code/blob/master/bootstrap.sh

repo_dir="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"

attach() {
    sourcegraph_theme_path="$( find ~/.vscode/extensions -maxdepth 1 -type d -name 'sourcegraph.vscode-sourcegraph-theme*' )"
    if [[ "$sourcegraph_theme_path" ]]; then
        sourcegraph_theme_dir="$( basename "$sourcegraph_theme_path" )"
        mkdir -p ~/.vscode/extensions/disabled
        mv "$sourcegraph_theme_path" ~/.vscode/extensions/disabled/"$sourcegraph_theme_dir"
    fi
    ln -s "$repo_dir" ~/.vscode/extensions/vscode-sourcegraph-theme
}

eject() {
    rm -f ~/.vscode/extensions/vscode-sourcegraph-theme
    if [ -d ~/.vscode/extensions/disabled ]; then
        disabled_path="$( find ~/.vscode/extensions/disabled -maxdepth 1 -type d -name 'sourcegraph.vscode-sourcegraph-theme*' )"
        sourcegraph_theme_dir="$( basename "$disabled_path" )"
        mv "$disabled_path" ~/.vscode/extensions/"$sourcegraph_theme_dir"
        rm -r ~/.vscode/extensions/disabled
    fi
}

case "$1" in
    attach)
        attach
        ;;
    eject)
        eject
        ;;
esac