#!/usr/bin/env bash

set -euo pipefail

ENV_NAME=${ENV_NAME:-minimind}
PYTHON_VERSION=${PYTHON_VERSION:-3.10}
DATA_ROOT=${DATA_ROOT:-dataset}
DOWNLOAD_PRETRAIN=${DOWNLOAD_PRETRAIN:-1}
DOWNLOAD_SFT_MINI=${DOWNLOAD_SFT_MINI:-1}
DOWNLOAD_DPO=${DOWNLOAD_DPO:-1}

if ! command -v conda >/dev/null 2>&1; then
  echo "conda not found, please install Miniconda or Anaconda first." >&2
  exit 1
fi

eval "$(conda shell.bash hook)"

if ! conda env list | grep -qE "^[[:space:]]*${ENV_NAME}[[:space:]]"; then
  conda create -n "$ENV_NAME" "python=${PYTHON_VERSION}" -y
fi

conda activate "$ENV_NAME"

pip install --upgrade pip
pip install -r requirements.txt

mkdir -p "$DATA_ROOT"

BASE_URL=${MINIMIND_DATASET_BASE_URL:-"https://huggingface.co/datasets/jingyaogong/minimind_dataset/resolve/main"}

if [[ "$DOWNLOAD_PRETRAIN" == "1" ]]; then
  curl -L "${BASE_URL}/pretrain_hq.jsonl" -o "${DATA_ROOT}/pretrain_hq.jsonl"
fi

if [[ "$DOWNLOAD_SFT_MINI" == "1" ]]; then
  curl -L "${BASE_URL}/sft_mini_512.jsonl" -o "${DATA_ROOT}/sft_mini_512.jsonl"
fi

if [[ "$DOWNLOAD_DPO" == "1" ]]; then
  curl -L "${BASE_URL}/dpo.jsonl" -o "${DATA_ROOT}/dpo.jsonl"
fi
