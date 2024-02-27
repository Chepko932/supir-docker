#!/usr/bin/env python3
import os
from huggingface_hub import snapshot_download


if __name__ == '__main__':
    llava_model = os.getenv('LLAVA_MODEL', 'liuhaotian/llava-v1.5-7b')
    llava_clip_model = 'openai/clip-vit-large-patch14-336'
    sdxl_clip_model = 'openai/clip-vit-large-patch14'

    print(f'Downloading LLaVA model: {llava_model}')
    snapshot_download(llava_model)

    print(f'Downloading LLaVA CLIP model: {llava_clip_model}')
    snapshot_download(llava_clip_model)

    print(f'Downloading SDXL CLIP model: {sdxl_clip_model}')
    snapshot_download(sdxl_clip_model)
