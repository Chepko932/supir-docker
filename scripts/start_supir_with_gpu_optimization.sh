#!/usr/bin/env bash

echo "Starting SUPIR with GPU Optimization"

VENV_PATH=$(cat /workspace/SUPIR/venv_path)
source ${VENV_PATH}/bin/activate
export HF_HOME="/workspace"
cd /workspace/SUPIR

nohup python3 gradio_demo.py \
            --ip 0.0.0.0 \
            --port 3001 \
            --use_image_slider \
            --loading_half_params \
            --use_tile_vae \
            --load_8bit_llava > /workspace/logs/supir.log 2>&1 &

deactivate
