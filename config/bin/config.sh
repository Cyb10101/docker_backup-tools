#!/usr/bin/env bash

function includeScriptDir() {
    if [[ -d "$1" ]]; then
        for FILE in "$1"/*.sh; do
            echo "-> Executing ${FILE}"
            # run custom scripts, only once
            . "$FILE"
        done
    fi
}

# Run "entrypoint" scripts
function runEntrypoints() {
    # Try to find entrypoint
    ENTRYPOINT_SCRIPT="/opt/docker/bin/entrypoints/${TASK}.sh"

    if [ -f "$ENTRYPOINT_SCRIPT" ]; then
        . "$ENTRYPOINT_SCRIPT"
    fi

    # Run default
    if [ -f "/opt/docker/bin/entrypoints/default.sh" ]; then
        . /opt/docker/bin/entrypoints/default.sh
    fi

    exit 1
}

# Run "entrypoint" provisioning
function runProvisionEntrypoint() {
    includeScriptDir "/opt/docker/bin/entrypoint.d"
    includeScriptDir "/entrypoint.d"
}
