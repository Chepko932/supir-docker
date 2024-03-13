variable "APP" {
    default = "supir"
}

variable "RELEASE" {
    default = "2.0.1"
}

variable "CU_VERSION" {
    default = "118"
}

target "default" {
    dockerfile = "Dockerfile"
    tags = ["ashleykza/${APP}:${RELEASE}"]
    args = {
        RELEASE = "${RELEASE}"
        INDEX_URL = "https://download.pytorch.org/whl/cu${CU_VERSION}"
        TORCH_VERSION = "2.2.0+cu${CU_VERSION}"
        XFORMERS_VERSION = "0.0.24+cu${CU_VERSION}"
        SUPIR_COMMIT = "b6d497b31fc0eba3b0fa3d4759b9be0d5ea62ee4"
        LLAVA_MODEL = "liuhaotian/llava-v1.5-7b"
        RUNPODCTL_VERSION = "v1.14.2"
        VENV_PATH = "/workspace/venvs/SUPIR"
    }
}
