#!/bin/zsh
SCRIPT_PATH=/Users/paul/Code/Git/facefusionchines/run.sh

osascript <<EOF
tell application "Terminal"
    do script "bash '$SCRIPT_PATH'"
    activate
end tell
EOF
