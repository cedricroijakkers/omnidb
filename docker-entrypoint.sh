#!/bin/bash

# Wrapper to run the start script while still being able to catch Ctrl-C
# Copied from: https://github.com/docker-library/mysql/issues/47
asyncRun() {
    "$@" &
    pid="$!"
    trap "echo 'Stopping PID $pid'; kill -SIGTERM $pid" SIGINT SIGTERM

    # A signal emitted while waiting will make the wait command return code > 128
    # Let's wrap it in a loop that doesn't end before the process is indeed stopped
    while kill -0 $pid > /dev/null 2>&1; do
        wait
    done
}

# Start OmniDB with asyncRun
asyncRun python3 omnidb-server.py -p 8080 -e $EXTERNAL_WEBSOCKET_PORT -H 0.0.0.0 -d /etc/omnidb