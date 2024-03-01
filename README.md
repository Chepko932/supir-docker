# Docker image for SUPIR (Scaling Up to Excellence: Practicing Model Scaling for Photo-Realistic Image Restoration In the Wild)

> [!IMPORTANT]
> This needs at least 24GB VRAM for 1x upscale. If you want to upscale more than 1x,
> you will need more than 24GB of VRAM.  48GB VRAM is recommended.

> [!NOTE]
> Loading of models on start takes a few minutes, so you can view the log
> to watch the progress. You will be able to access the port when you see 
> `Running on local URL:  http://0.0.0.0:3001` in the log.

## Installs

* Ubuntu 22.04 LTS
* CUDA 12.1
* Python 3.10.12
* [SUPIR](
  https://github.com/ashleykleynhans/SUPIR)
* Torch 2.2.0
* xformers 0.0.24
* Jupyter Lab
* [runpodctl](https://github.com/runpod/runpodctl)
* [OhMyRunPod](https://github.com/kodxana/OhMyRunPod)
* [RunPod File Uploader](https://github.com/kodxana/RunPod-FilleUploader)
* [croc](https://github.com/schollz/croc)
* [rclone](https://rclone.org/)

## Available on RunPod

This image is designed to work on [RunPod](https://runpod.io?ref=2xxro4sy).
You can use my custom [RunPod template](
https://runpod.io/console/gpu-cloud?template=aa31uo64wv&ref=2xxro4sy)
to launch it on RunPod.

## Running Locally

### Install Nvidia CUDA Driver

- [Linux](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html)
- [Windows](https://docs.nvidia.com/cuda/cuda-installation-guide-microsoft-windows/index.html)

### Start the Docker container

```bash
docker run -d \
  --gpus all \
  -v /workspace \
  -p 3000:3001 \
  -p 8888:8888 \
  -p 2999:2999 \
  -e JUPYTER_PASSWORD=Jup1t3R! \
  ashleykza/supir:latest
```

## Models

| Model                             | Description |
|-----------------------------------|-------------|
| SUPIR-v0F.ckpt                    | SUPIR F     |
| SUPIR-v0Q.ckpt                    | SUPIR Q     |
| liuhaotian/llava-v1.5-7b          | LLaVA       |
| sd_xl_base_1.0_0.9vae.safetensors | SDXL        |
| openai/clip-vit-large-patch14-336 | LLaVA CLIP  |
| openai/clip-vit-large-patch14     | SDXL CLIP1  |
| open_clip_pytorch_model.bin       | SDXL CLIP2  |

You can obviously substitute the image name and tag with your own.

## Ports

| Connect Port | Internal Port | Description          |
|--------------|---------------|----------------------|
| 3000         | 3001          | SUPIR                |
| 8888         | 8888          | Jupyter Lab          |
| 2999         | 2999          | RunPod File Uploader |

## Environment Variables

| Variable             | Description                                | Default   |
|----------------------|--------------------------------------------|-----------|
| JUPYTER_PASSWORD     | Password for Jupyter Lab                   | Jup1t3R!  |
| DISABLE_AUTOLAUNCH   | Disable SUPIR from launching automatically | (not set) |
| NO_GPU_OPTIMIZATION  | Disable GPU optimization for A100/H100     | (not set) |

## Logs

SUPIR creates a log file, and you can tail the log instead of
killing the service to view the logs.

| Application | Log file                  |
|-------------|---------------------------|
| SUPIR       | /workspace/logs/supir.log |

For example:

```bash
tail -f /workspace/logs/supir.log
```

## Community and Contributing

Pull requests and issues on [GitHub](https://github.com/ashleykleynhans/supir-docker)
are welcome. Bug fixes and new features are encouraged.

You can contact me and get help with deploying your container
to RunPod on the RunPod Discord Server below,
my username is **ashleyk**.

<a target="_blank" href="https://discord.gg/pJ3P2DbUUq">![Discord Banner 2](https://discordapp.com/api/guilds/912829806415085598/widget.png?style=banner2)</a>

## Appreciate my work?

<a href="https://www.buymeacoffee.com/ashleyk" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
