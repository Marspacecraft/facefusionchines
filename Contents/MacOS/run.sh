
osascript <<EOF
tell application "Terminal"
    do script "bash '$SCRIPT_PATH'"
    activate
end tell
EOF
