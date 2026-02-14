# 进阶实践目录

> 本目录用于记录在 MiniMind 基础上做的「完整训练流程」与「工程向实战」相关笔记，偏向实践与调参，而不是纯概念介绍。初稿由 Vibe Writing 大模型生成，并结合实际实验结果持续更新。

推荐可以写在这里的内容，包括但不限于：

- **预训练实践**：如何准备数据、配置 `trainer/train_pretrain.py`，以及在有限算力下做「玩得起」的预训练实验。
- **指令微调（SFT）**：使用 `trainer/train_full_sft.py` 或 `trainer/train_lora.py`，构建小规模高质量指令数据集，并观察模型行为变化。
- **LoRA 与参数高效微调**：不同 r 值、不同 target layer 的实验记录，对比显存占用与效果。
- **DPO / RLAIF 系列**：基于 `trainer/train_dpo.py`、`trainer/train_ppo.py`、`trainer/train_grpo.py`、`trainer/train_spo.py` 的对齐实验，包括数据格式、训练曲线、主观体验。
- **从训练到推理**：如何将进阶实践中的模型权重接到 `scripts/serve_openai_api.py` 和 `scripts/chat_openai_api.py` 上，形成闭环。

写作风格建议：

- 尽量记录「具体配置 + 现象 + 个人理解」，而不仅是步骤罗列。
- 多引用本仓库中的具体脚本和配置片段，形成代码联动的长文笔记。

