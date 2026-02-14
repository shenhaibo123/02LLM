# 环境与数据准备：从零跑通 MiniMind

> 初稿由 Vibe Writing 大模型生成，并结合我在本仓库中的实际折腾过程持续更新。

这一篇想做的事情很简单：**从一台“干净”的机器开始，把环境装好、依赖装好、数据目录准备好，让后面的预训练 / 微调 / 推理实验都能顺利跑起来。**

对应的自动化脚本在：

- `Doc/进阶实践/prepare/setup_env_and_data.sh`

后续如果环境有任何调整，我会优先更新这两个地方：这个文档和上面的脚本。

## 1. 仓库与 Conda 环境

假设当前目录已经是本仓库根目录：

- `/Users/shenhaibo/Desktop/02LLM`

建议使用 conda 管理环境，避免和系统或其他项目的包冲突。准备工作由脚本统一完成：

```bash
cd /Users/shenhaibo/Desktop/02LLM
bash Doc/进阶实践/prepare/setup_env_and_data.sh
```

脚本内部做了几件事：

1. 使用 conda 创建或复用环境
   - 默认环境名为 `minimind`，Python 版本默认为 `3.10`：
   - 如需自定义环境名或 Python 版本，可以在命令前设置环境变量：

     ```bash
     ENV_NAME=my-minimind PYTHON_VERSION=3.11 bash Doc/进阶实践/prepare/setup_env_and_data.sh
     ```

   - 首次运行时会执行：
     - `conda create -n minimind python=3.10 -y`
   - 之后自动 `conda activate minimind`

2. 升级 pip
3. 按 `requirements.txt` 安装依赖
   - 文件位于仓库根目录：[requirements.txt](file:///Users/shenhaibo/Desktop/02LLM/requirements.txt)
   - 包括：
     - `torch` / `torchvision`
     - `transformers` / `trl` / `peft`
     - `datasets` / `sentence_transformers`
     - `streamlit` / `Flask` / `ngrok`
     - 以及 `wandb`、`swanlab` 等训练可视化工具

如果你使用的是国内环境，可能需要提前配置 pip 源，这里脚本没有强行指定源，方便你按自己习惯配置：

- 比如在执行脚本前先运行一次：

  ```bash
  pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
  ```

## 2. 数据目录约定与自动下载：dataset/

本仓库的 `dataset/dataset.md` 中只有一句很简短的说明：

- 「将所有下载的数据集文件放置到当前目录」

也就是说，数据集的默认约定是：

- 根目录下的 `dataset/` 作为统一入口；
- 预训练、SFT、对齐相关的数据都可以按子目录进行归档。

在准备脚本中，默认会：

- 创建 `dataset/` 目录（可通过环境变量 `DATA_ROOT` 自定义）
- 从上游公开数据集 `jingyaogong/minimind_dataset` 自动下载若干核心文件：
  - `pretrain_hq.jsonl`：高质量预训练语料
  - `sft_mini_512.jsonl`：体积较小的指令微调语料
  - `dpo.jsonl`（可选）：用于 DPO / RLAIF 的偏好数据

默认行为对应脚本中的环境变量：

- `DATA_ROOT`：数据目录（默认 `dataset`）
- `DOWNLOAD_PRETRAIN`：是否下载 `pretrain_hq.jsonl`（默认 `1`）
- `DOWNLOAD_SFT_MINI`：是否下载 `sft_mini_512.jsonl`（默认 `1`）
- `DOWNLOAD_DPO`：是否下载 `dpo.jsonl`（默认 `1`）
- `MINIMIND_DATASET_BASE_URL`：数据源基础 URL，默认指向 Hugging Face，如需使用镜像可覆盖

例如，只下载 SFT 小数据集而跳过预训练和 DPO：

```bash
DOWNLOAD_PRETRAIN=0 DOWNLOAD_SFT_MINI=1 DOWNLOAD_DPO=0 bash Doc/进阶实践/prepare/setup_env_and_data.sh
```

脚本执行后，`DATA_ROOT` 目录下预期出现至少以下文件：

- `pretrain_hq.jsonl`（如果 `DOWNLOAD_PRETRAIN=1`）
- `sft_mini_512.jsonl`（如果 `DOWNLOAD_SFT_MINI=1`）
- `dpo.jsonl`（如果 `DOWNLOAD_DPO=1`）

## 3. 运行脚本后的手动检查清单

执行完 `setup_env_and_data.sh` 之后，可以按下面的 checklist 快速确认一遍：

1. 虚拟环境是否存在并可激活？
   - 预期有 `.venv/` 目录
   - 运行 `source .venv/bin/activate` 没有报错
   - `which python` 指向 `.venv` 内部
2. 主要依赖是否装好？
   - 在激活环境后执行：

     ```bash
     python -c "import torch, transformers, trl, peft; print('ok')"
     ```

   - 如果能正常输出 `ok`，说明最关键的几类包已经安装成功。
3. `dataset/` 是否存在？
   - 预期有 `dataset/` 目录
   - 你可以先随便放一个小文件进去，例如 `dataset/README_local.md`，方便后面实验时自查

## 4. 与后续章节的衔接

完成这一节后，你就有了一个「可用的实验地基」：

- Python 环境和依赖准备好；
- 数据目录约定好；
- 你知道虚拟环境在哪、怎么激活。

后面的「进阶实践」可以直接基于这套基础设施展开，例如：

- 在「预训练实践」文章中：
  - 假定已经执行过 `setup_env_and_data.sh`
  - 只需要强调数据格式和配置文件即可
- 在「指令微调」文章中：
  - 默认代码环境已经 ready
  - 重点放在数据构造、指令模板和 loss 曲线分析上

「深度探索」部分同样可以把这篇文档当作前置依赖，不用每篇重复环境说明。

## 5. 下一步建议

有了这一篇之后，后续可以考虑写的方向包括：

- 写一篇「最小可运行示例」：
  - 只用一个极小数据集，跑一两步 `trainer/train_pretrain.py`
  - 确认训练 loop 可以正常跑通
- 写一篇「快速推理体验」：
  - 使用上游提供的某个 MiniMind 权重
  - 跑 `scripts/chat_openai_api.py` 或 `scripts/web_demo.py`

这些内容都可以直接放在 `Doc/进阶实践` 目录下，和本篇形成一个小系列。
