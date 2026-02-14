# 03 分词器与 Tokenizer 基础

> 本文档由 Vibe Writing 大模型生成初稿，并结合本仓库实践与个人学习需求进行整理与校订。

## 1. 本篇目标
 
- 理解「token」与「字符 / 词」的区别。
- 掌握常见分词算法（BPE、WordPiece、Unigram）的直观概念。
- 了解如何从 0 训练一个自定义 Tokenizer，并在 MiniMind 中使用。
 
 ## 2. 为什么需要分词器
 
 - 模型只能处理有限大小的词表。
 - 直接按「字 / 词」建表的问题：稀疏、冗余、OOV。
 - 使用 subword 的折中方案。
 
 ## 3. 常见分词算法概览
 
 - BPE（Byte Pair Encoding）的基本思路。
 - Unigram Language Model 的直观理解。
 - 不同算法在中文与多语言场景下的优缺点。
 
 ## 4. 训练自定义 Tokenizer 的流程
 
 - 准备原始语料与清洗。
 - 使用工具（如 `tokenizers` 库）训练词表。
 - 保存并加载：`tokenizer.json` 与 `tokenizer_config.json`。
 
 ## 5. 与 MiniMind 项目的关系
 
 - 对应到 `model/tokenizer.json` 与 `train_tokenizer.py`。
 - 训练好的分词器如何与模型参数对齐。
 
 ## 6. 延伸阅读与思考
 
 - 推荐阅读：SentencePiece / Hugging Face Tokenizers 文档。
 - 思考题：如果词表太小 / 太大，会分别带来什么问题？
 
