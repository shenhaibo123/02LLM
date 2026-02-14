# 05 对齐与 RLHF / DPO / RLAIF 概览

> 本文档由 Vibe Writing 大模型生成初稿，并结合本仓库实践与个人学习需求进行整理与校订。

## 1. 本篇目标
 
 - 理解「对齐（Alignment）」在大模型中的含义与目标。
 - 从整体上把握 RLHF、DPO、RLAIF 等方法的流程与差异。
 - 了解 MiniMind 项目中相关训练脚本的基本角色。
 
 ## 2. 为什么需要对齐
 
 - 仅靠预训练模型存在的问题：有害、跑偏、不守指令。
 - 「有能力但不听话」与「有能力又听话」的区别。
 - 对齐的三大目标：有用（Helpful）、诚实（Honest）、无害（Harmless）。
 
 ## 3. RLHF 的三阶段流程（概念级）
 
 - 1）预训练 + 指令微调得到初始策略模型。
 - 2）构建偏好数据并训练奖励模型（Reward Model）。
 - 3）使用强化学习算法（如 PPO）基于奖励信号继续优化策略模型。
 
 ## 4. DPO / RLAIF 等变体的直观理解
 
 - DPO：用偏好数据直接优化策略，无需显式奖励模型。
 - RLAIF：用模型生成的偏好替代人工标注，降低成本。
 - GRPO / SPO 等：不同的目标函数与训练稳定性权衡。
 
 ## 5. MiniMind 中的对应实现
 
 - `train_dpo.py`：DPO 训练流程。
 - `train_ppo.py`、`train_grpo.py`、`train_spo.py`：RLAIF 系列训练脚本。
 - 相关数据集格式与配置的简要说明。
 
 ## 6. 延伸阅读与思考
 
 - 推荐阅读：OpenAI InstructGPT / RLHF 博客、Hugging Face RLHF 教程。
 - 思考题：如果没有人工偏好数据，能否完成「对齐」？
 
