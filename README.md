# 🎙️ Audio Transcribe Skill

**一句话把视频/音频变成带时间轴的文字稿。**

这是一个面向 AI 助手（如 Claude Code、Codex）的语音转文字技能包。底层通过阿里云百炼的 ASR 服务，自动帮你提取文字，支持中英文、多人对话分离和句级时间戳。

## ✨ 核心功能
* 🎬 **视频转文字** / 🎵 **音频转文字**
* 🗣️ **自动区分说话人**（默认开启）
* ⏱️ **生成句级时间戳**（SRT 格式的基础）
* 📄 **一键导出纯文本 (TXT)**
* 🤖 **无缝接入 AI 助手**（自动安装为 Claude/Codex Skill）

---

## 🛠️ 第一步：准备工作

在安装前，请确保你的电脑（Mac/Linux）上有：
1. **Python 3.10+**（终端输入 `python3 --version` 检查）
2. **FFmpeg**（终端输入 `ffmpeg -version` 检查）
   * *如果没装 FFmpeg，Mac 用户可以用 `brew install ffmpeg`（M系列芯片），或者直接从 [ffmpeg.org](https://ffmpeg.org/download.html) 下载 Mac 静态包。*
3. **阿里云百炼 API Key**（[点此注册获取](https://bailian.console.aliyun.com/)）

---

## 📦 第二步：一键安装

打开终端，复制粘贴以下两行命令并回车：

```bash
git clone https://github.com/YOUR_USERNAME/audio-transcribe-skill.git
cd audio-transcribe-skill && bash install.sh
