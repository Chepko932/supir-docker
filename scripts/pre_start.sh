#!/usr/bin/env bash

export PYTHONUNBUFFERED=1

echo "Template version: ${TEMPLATE_VERSION}"

if [[ -e "/workspace/template_version" ]]; then
    EXISTING_VERSION=$(cat /workspace/template_version)
else
    EXISTING_VERSION="0.0.0"
fi

sync_apps() {
    # Sync venv to workspace to support Network volumes
    echo "Syncing venv to workspace, please wait..."
    rsync -remove-source-files -rlptDu /venv/ /workspace/venv/

    # Sync SUPIR to workspace to support Network volumes
    echo "Syncing SUPIR to workspace, please wait..."
    rsync -rlptDu /SUPIR/ /workspace/SUPIR/

    echo "Syncing models to workspace, please wait..."
    rsync --remove-source-files -rlptDu /hub/ /workspace/hub/

    echo "${TEMPLATE_VERSION}" > /workspace/template_version
}

fix_venvs() {
    # Fix the venv to make it work from /workspace
    echo "Fixing venv..."
    /fix_venv.sh /venv /workspace/venv
}

if [ "$(printf '%s\n' "$EXISTING_VERSION" "$TEMPLATE_VERSION" | sort -V | head -n 1)" = "$EXISTING_VERSION" ]; then
    if [ "$EXISTING_VERSION" != "$TEMPLATE_VERSION" ]; then
        sync_apps
        fix_venvs
    else
        echo "Existing version is the same as the template version, no syncing required."
    fi
else
    echo "Existing version is newer than the template version, not syncing!"
fi

if [[ ${DISABLE_AUTOLAUNCH} ]]
then
    echo "Auto launching is disabled so the application will not be started automatically"
    echo "You can launch it manually:"
    echo ""
    echo "   cd /workspace/SUPIR"
    echo "   deactivate && source /workspace/venv/bin/activate"
    echo "   export HF_HOME=\"/workspace\""
    echo "   python3 gradio_demo.py --ip 0.0.0.0 --port 3001 --use_image_slider --loading_half_params --use_tile_vae --load_8bit_llava"
else
    echo "Starting SUPIR"
    source /workspace/venv/bin/activate
    export HF_HOME="/workspace"

    if [[ ${NO_GPU_OPTIMIZATION} ]]
    then
        nohup python3 gradio_demo.py \
            --ip 0.0.0.0 \
            --port 3001 \
            --use_image_slider > /workspace/logs/supir.log 2>&1 &
    else
        nohup python3 gradio_demo.py \
            --ip 0.0.0.0 \
            --port 3001 \
            --use_image_slider \
            --loading_half_params \
            --use_tile_vae \
            --load_8bit_llava > /workspace/logs/supir.log 2>&1 &
    fi
    echo "SUPIR started"
    echo "Log file: /workspace/logs/supir.log"
    deactivate
fi

echo "All services have been started"
