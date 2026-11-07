# 🎙️ Audio Transcribe Skill

**Simple Audio & Video Transcription for AI Assistants**

[中文](#中文说明) | [English](#english-documentation)

[![Python](https://img.shields.io/badge/Python-3.10%2B-blue)](https://www.python.org/)
[![Platform](https://img.shields.io/badge/Platform-macOS%20%7C%20Linux-lightgrey)]()
[![ASR](https://img.shields.io/badge/ASR-Aliyun%20Bailian-orange)](https://bailian.console.aliyun.com/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

A lightweight audio and video transcription tool for AI assistants such as Claude Code and Codex.

Powered by Alibaba Cloud Bailian ASR, it converts audio and video into text, supports speaker diarization and sentence-level timestamps, and exports transcription results as TXT files.

Designed for beginners, this project provides an installation script and an easy-to-follow setup guide.

---

# 中文说明

## 一、项目简介

Audio Transcribe Skill 是一个面向 AI 助手的音视频转文字工具，适用于 Claude Code、Codex 等支持 Agent Skills 的 AI 工具。

本项目基于阿里云百炼 ASR（Automatic Speech Recognition）服务，可以自动提取音频或视频中的语音内容，支持中英文识别、多人对话说话人区分以及句级时间戳。

项目的目标是让没有编程经验的用户，也能快速安装和使用音视频转文字工具，并将其接入自己的 AI 工作流。

## 二、核心功能

| 功能 | 说明 |
|---|---|
| 🎬 视频转文字 | 从视频文件中提取音轨并识别语音 |
| 🎵 音频转文字 | 支持常见音频格式 |
| 🗣️ 说话人区分 | 自动区分不同说话人，默认开启 |
| ⏱️ 时间戳 | 支持句级时间信息 |
| 📄 文本导出 | 将识别结果保存为 TXT 文件 |
| 🤖 AI 助手集成 | 支持 Claude Code、Codex 等 Agent Skills 环境 |

## 三、安装前的准备

本项目支持 macOS 和 Linux。

需要准备：

- Python 3.10 或更高版本
- FFmpeg 和 ffprobe
- 阿里云百炼 API Key
- Git

### 1. 检查 Python

打开终端，执行：

```bash
python3 --version
```

如果显示 Python 3.10 或更高版本，即可继续。

如果没有安装 Python，请访问：

https://www.python.org/downloads/

下载安装后重新打开终端检查。

### 2. 检查 FFmpeg

执行：

```bash
ffmpeg -version
ffprobe -version
```

如果两条命令都能显示版本信息，说明已经安装。

macOS 用户可以使用 Homebrew 安装：

```bash
brew install ffmpeg
```

Linux 用户请使用对应发行版的包管理器安装 FFmpeg。

### 3. 获取阿里云百炼 API Key

本工具使用阿里云百炼 ASR 服务进行语音识别。

访问：

https://bailian.console.aliyun.com/

登录账号，开通相关服务并获取 API Key。

请妥善保存 API Key，不要公开或上传到 GitHub。

## 四、一键安装

### 1. 下载项目

打开终端，执行：

```bash
git clone https://github.com/wwdog2000/audio-transcribe-skill.git
```

进入项目目录：

```bash
cd audio-transcribe-skill
```

### 2. 执行安装脚本

```bash
bash install.sh
```

安装脚本会自动执行：

1. 检查 Python 版本。
2. 检查 FFmpeg 和 ffprobe。
3. 安装音视频转文字 CLI 工具及相关依赖。
4. 将 Agent Skill 安装到 Claude Code 和 Codex 对应目录。

如果出现：

```text
Installation completed!
```

说明安装脚本已经执行完成。

**注意：** 安装脚本执行完成不一定代表 `asr` 命令已经可以正常使用。还需要进行下面的验证。

### 3. 验证安装

执行：

```bash
asr --help
```

如果显示命令帮助信息，说明 CLI 已经可以正常调用。

如果出现：

```text
command not found: asr
```

请查看「常见问题排查」。

## 五、配置 API Key

API Key 是调用阿里云百炼服务的必要条件。

### macOS 用户：使用 TextEdit 图形界面配置

本教程不要求使用 nano 编辑器。

**第一步：打开配置文件**

在终端中复制：

```bash
touch ~/.zshrc && open -e ~/.zshrc
```

按回车。

系统会使用 Mac 自带的 TextEdit 打开配置文件。

**第二步：添加 API Key**

在文本文件最后添加：

```bash
export DASHSCOPE_API_KEY="sk-你的真实API-Key"
```

请将示例文字替换成自己的真实 API Key。

如果文件中已有其他内容，不要删除，只需另起一行添加。

如果 TextEdit 使用富文本格式，请先选择：

「格式」→「制作为纯文本」。

**第三步：保存**

按下：

```text
Command + S
```

保存后关闭 TextEdit。

**第四步：使配置生效**

回到终端执行：

```bash
source ~/.zshrc
```

**第五步：检查配置**

```bash
if [ -n "$DASHSCOPE_API_KEY" ]; then
  echo "API Key 已配置"
else
  echo "API Key 未配置"
fi
```

看到：

```text
API Key 已配置
```

说明配置成功。

### Linux 用户：配置环境变量

Linux 用户根据实际使用的 Shell，编辑对应配置文件，例如 Bash 用户可以使用：

```bash
nano ~/.bashrc
```

在文件末尾添加：

```bash
export DASHSCOPE_API_KEY="sk-你的真实API-Key"
```

保存后执行：

```bash
source ~/.bashrc
```

检查：

```bash
if [ -n "$DASHSCOPE_API_KEY" ]; then
  echo "API Key configured"
else
  echo "API Key not configured"
fi
```

### 安全提醒

- 不要将真实 API Key 写入公开 README 或代码。
- 不要将包含 API Key 的配置文件上传到 GitHub。
- 音视频文件会上传至阿里云百炼进行语音识别。
- 处理私人或敏感录音前，请确认已获得必要授权。

## 六、开始使用

安装和配置完成后，可以直接在终端中使用 `asr` 命令。

### 1. 视频转文字

```bash
asr "/Users/你的用户名/Desktop/测试视频.mp4"
```

默认情况下，识别结果保存为当前目录下的：

```text
result.txt
```

### 2. 指定输出文件

```bash
asr "/Users/你的用户名/Desktop/测试视频.mp4" --out "/Users/你的用户名/Desktop/识别结果.txt"
```

### 3. 常用参数

| 使用需求 | 命令 |
|---|---|
| 自动区分说话人 | 默认开启 |
| 不区分说话人 | `asr video.mp4 --no-speakers` |
| 添加句级时间戳 | `asr video.mp4 --timestamps` |
| 指定输出文件 | `asr video.mp4 --out result.txt` |
| 查看所有参数 | `asr --help` |

### 4. 实际使用示例

视频转文字：

```bash
asr interview.mp4 --out interview.txt
```

音频转文字：

```bash
asr meeting.mp3 --out meeting.txt
```

不区分说话人：

```bash
asr interview.mp4 --no-speakers --out interview.txt
```

生成带时间戳的文字稿：

```bash
asr meeting.mp3 --timestamps --out meeting.txt
```

说明：`--timestamps` 会输出带时间信息的文本，采用 SRT 风格的时间标记，但输出文件仍然是文本文件，并非标准 `.srt` 字幕文件。

### 5. macOS 初学者：如何快速输入文件路径？

不需要手动输入很长的文件路径。

1. 打开终端。
2. 输入 `asr `，注意最后有一个空格。
3. 打开 Finder，找到需要转写的视频或音频。
4. 将文件直接拖入终端窗口。
5. 在路径后面添加 `--out result.txt`。
6. 按回车开始转写。

这样可以避免文件路径输入错误。

## 七、在 AI 助手中使用

本项目不仅可以在终端中独立运行，还可以作为 Agent Skill 接入 AI 助手。

安装脚本会将技能文件复制到对应目录。

**Claude Code**

```text
~/.claude/skills/audio-transcribe-cli-mcp/
```

**Codex**

```text
~/.agents/skills/audio-transcribe-cli-mcp/
```

目录中应包含：

```text
SKILL.md
```

### 使用示例

安装成功后，可以向 AI 助手提出自然语言请求：

```text
帮我把桌面上的 interview.mp4 转换成文字稿，
自动区分说话人，并保存为 interview.txt。
```

AI 助手可以根据 Skill 中的说明调用 `asr` 命令完成任务。

如果 AI 助手没有立即识别到新安装的 Skill，可以尝试重启应用或重新加载技能。

注意：AI 助手能否自动识别并调用 Skill，取决于所使用工具对 Agent Skills 的支持情况及其配置。

## 八、常见问题排查

### 1. 提示 `asr: command not found`

说明系统没有找到 `asr` 命令。

检查：

```bash
python3 -m pip show audio-transcribe-cli-mcp
```

如果尚未安装，可以尝试：

```bash
python3 -m pip install audio-transcribe-cli-mcp
```

如果已经安装但命令仍不可用，需要检查 Python 的安装路径和 PATH 环境变量。

### 2. 提示 `ffmpeg not found`

macOS 用户可以执行：

```bash
brew install ffmpeg
```

然后重新检查：

```bash
ffmpeg -version
ffprobe -version
```

### 3. 提示 API Key 错误

检查环境变量：

```bash
if [ -n "$DASHSCOPE_API_KEY" ]; then
  echo "已设置"
else
  echo "未设置"
fi
```

如果显示未设置，请重新检查 API Key 配置步骤。

同时确认阿里云百炼 API Key 有效，并且相关服务已经开通。

### 4. AI 助手没有识别到 Skill

检查 Claude Code：

```bash
ls ~/.claude/skills/audio-transcribe-cli-mcp/
```

检查 Codex：

```bash
ls ~/.agents/skills/audio-transcribe-cli-mcp/
```

确认目录中包含 `SKILL.md`，然后重启对应的 AI 助手。

### 5. 说话人区分效果不理想

工具会自动检测说话人数量。

如果音频中说话人音色接近，或者录音质量较差，可能影响区分效果。

识别结果也可能存在标点或专有名词错误，建议将文字稿交给 AI 进一步校对。

## 九、安装完成检查清单

| 检查项目 | 成功标志 |
|---|---|
| Python | 版本为 3.10 或更高 |
| FFmpeg | 能显示版本信息 |
| ffprobe | 能显示版本信息 |
| 安装脚本 | 显示 `Installation completed!` |
| ASR 命令 | `asr --help` 正常 |
| API Key | 显示 `API Key 已配置` |
| 转写测试 | 成功生成 `result.txt` |
| Skill 文件 | 找到 `SKILL.md` |

建议先通过终端完成一次音视频转写测试，再使用 AI 助手调用。

## 十、工作原理

```text
输入视频 / 音频
       │
       ▼
FFmpeg 提取音轨
       │
       ▼
音频数据处理
       │
       ▼
上传至阿里云百炼 ASR
       │
       ▼
语音识别与说话人区分
       │
       ▼
返回识别结果
       │
       ▼
本地保存文字稿
       │
       ▼
result.txt
```

整个过程由 CLI 工具自动完成。

用户只需要提供音视频文件路径和必要参数。

## 十一、项目目录结构

```text
audio-transcribe-skill/
│
├── README.md
├── install.sh
├── .gitignore
├── LICENSE
│
├── skills/
│   └── audio-transcribe-cli-mcp/
│       └── SKILL.md
│
└── examples/
    └── 使用示例.md
```

## 十二、项目来源与开源协议

本项目基于以下开源项目构建：

**上游项目：**

https://github.com/OstrichHermit/audio-transcribe-cli-mcp

**PyPI：**

https://pypi.org/project/audio-transcribe-cli-mcp/

上游项目提供底层音视频转文字 CLI、MCP Server 和相关功能。

本仓库主要面向初学者，提供更直观的安装说明、安装脚本及 AI Agent Skill 封装。

本项目采用 MIT License。上游项目的原作者及其版权声明应按照原项目许可证要求保留。

---

# English Documentation

## 1. Introduction

Audio Transcribe Skill is a lightweight audio and video transcription tool designed for AI assistants such as Claude Code and Codex.

Powered by Alibaba Cloud Bailian ASR (Automatic Speech Recognition), it extracts speech from audio and video files and converts it into text.

The tool supports Chinese and English recognition, speaker diarization, sentence-level timestamps, and TXT output.

This project aims to make audio transcription accessible to beginners and easy to integrate into AI workflows.

## 2. Features

| Feature | Description |
|---|---|
| 🎬 Video Transcription | Extract audio from video files and transcribe speech |
| 🎵 Audio Transcription | Transcribe common audio formats |
| 🗣️ Speaker Diarization | Automatically distinguish speakers; enabled by default |
| ⏱️ Timestamps | Support sentence-level timestamps |
| 📄 TXT Export | Save transcription results as TXT files |
| 🤖 AI Integration | Install as an Agent Skill for Claude Code and Codex |

## 3. Prerequisites

This project supports macOS and Linux.

Before installation, make sure you have:

- Python 3.10 or newer
- FFmpeg and ffprobe
- An Alibaba Cloud Bailian API Key
- Git

### 3.1 Check Python

Open your terminal and run:

```bash
python3 --version
```

Python 3.10 or newer is required.

If Python is not installed, download it from:

https://www.python.org/downloads/

### 3.2 Check FFmpeg

Run:

```bash
ffmpeg -version
ffprobe -version
```

Both commands should display version information.

On macOS, install FFmpeg using Homebrew:

```bash
brew install ffmpeg
```

On Linux, install FFmpeg using your distribution's package manager.

### 3.3 Get an Alibaba Cloud Bailian API Key

This tool uses Alibaba Cloud Bailian ASR for speech recognition.

Visit:

https://bailian.console.aliyun.com/

Sign in, enable the required service, and obtain your API Key.

Keep your API Key private. Never publish it in your GitHub repository.

## 4. Installation

### 4.1 Clone the Repository

Open your terminal and run:

```bash
git clone https://github.com/wwdog2000/audio-transcribe-skill.git
```

Enter the project directory:

```bash
cd audio-transcribe-skill
```

### 4.2 Run the Installation Script

Execute:

```bash
bash install.sh
```

The installer automatically:

1. Checks the Python version.
2. Checks whether FFmpeg and ffprobe are installed.
3. Installs the transcription CLI and its dependencies.
4. Copies the Agent Skill to the Claude Code and Codex skill directories.

If you see:

```text
Installation completed!
```

the installation script has finished.

**Important:** This message does not necessarily mean that the `asr` command is already available. Verify it in the next step.

### 4.3 Verify the Installation

Run:

```bash
asr --help
```

If the command displays its help information, the CLI is ready to use.

If you see:

```text
command not found: asr
```

please refer to the Troubleshooting section.

## 5. Configure the API Key

An Alibaba Cloud Bailian API Key is required to use the transcription service.

### macOS: Configure with TextEdit

This method uses the built-in macOS text editor. You do not need to use a terminal text editor such as nano.

**Step 1: Open the configuration file**

Run:

```bash
touch ~/.zshrc && open -e ~/.zshrc
```

Press Enter.

TextEdit will open the configuration file. If the file does not exist, the command creates it first.

**Step 2: Add your API Key**

Add the following line at the end of the file:

```bash
export DASHSCOPE_API_KEY="sk-your-real-api-key"
```

Replace the example value with your actual API Key.

Do not delete existing configuration entries.

If TextEdit opens the file in rich-text mode, choose:

Format → Make Plain Text.

**Step 3: Save the file**

Press:

```text
Command + S
```

Then close TextEdit.

**Step 4: Apply the configuration**

Return to the terminal and run:

```bash
source ~/.zshrc
```

**Step 5: Verify the API Key**

Run:

```bash
if [ -n "$DASHSCOPE_API_KEY" ]; then
  echo "API Key configured"
else
  echo "API Key not configured"
fi
```

If the output is:

```text
API Key configured
```

your environment variable is available in the current terminal session.

### Linux: Configure the Environment Variable

For Linux users running Bash, edit:

```bash
nano ~/.bashrc
```

Add:

```bash
export DASHSCOPE_API_KEY="sk-your-real-api-key"
```

Save the file and run:

```bash
source ~/.bashrc
```

Verify:

```bash
if [ -n "$DASHSCOPE_API_KEY" ]; then
  echo "API Key configured"
else
  echo "API Key not configured"
fi
```

### Security Notice

- Never publish your real API Key in a public repository.
- Never upload configuration files containing API Keys to GitHub.
- Audio and video files are uploaded to Alibaba Cloud Bailian for speech recognition.
- Obtain the necessary authorization before processing private or sensitive recordings.

## 6. Usage

After installation and API Key configuration, you can use the `asr` command directly.

### 6.1 Transcribe a Video

```bash
asr "/Users/your-username/Desktop/video.mp4"
```

By default, the transcription result is saved as:

```text
result.txt
```

in the current working directory.

### 6.2 Specify an Output File

```bash
asr "/Users/your-username/Desktop/video.mp4" --out "/Users/your-username/Desktop/transcript.txt"
```

### 6.3 Common Options

| Task | Command |
|---|---|
| Enable speaker diarization | Enabled by default |
| Disable speaker diarization | `asr video.mp4 --no-speakers` |
| Add sentence-level timestamps | `asr video.mp4 --timestamps` |
| Specify output file | `asr video.mp4 --out result.txt` |
| Display all options | `asr --help` |

### 6.4 Examples

Transcribe a video:

```bash
asr interview.mp4 --out interview.txt
```

Transcribe an audio file:

```bash
asr meeting.mp3 --out meeting.txt
```

Disable speaker diarization:

```bash
asr interview.mp4 --no-speakers --out interview.txt
```

Generate a transcript with timestamps:

```bash
asr meeting.mp3 --timestamps --out meeting.txt
```

**Note:** The `--timestamps` option produces text with SRT-style time markers. The output remains a text file and is not a standard `.srt` subtitle file.

### 6.5 Beginner Tip: How to Enter a File Path on macOS

You do not need to type a long file path manually.

1. Open Terminal.
2. Type `asr `, including the trailing space.
3. Open Finder and locate your audio or video file.
4. Drag the file directly into the Terminal window.
5. Add `--out result.txt` after the file path.
6. Press Enter to start transcription.

This method helps avoid incorrect file paths.

## 7. Use with AI Assistants

This project can run independently in the terminal or be integrated into supported AI assistants as an Agent Skill.

The installation script copies the Skill file into the following directories.

**Claude Code:**

```text
~/.claude/skills/audio-transcribe-cli-mcp/
```

**Codex:**

```text
~/.agents/skills/audio-transcribe-cli-mcp/
```

The directory should contain:

```text
SKILL.md
```

### Example Prompt

After installation, you can ask your AI assistant:

```text
Please transcribe interview.mp4 on my Desktop,
identify different speakers,
and save the result as interview.txt.
```

The AI assistant can use the instructions in the Skill to call the `asr` command.

If the Skill is not immediately recognized, restart the AI assistant or reload its skills.

**Note:** Automatic Skill discovery and execution depend on the AI assistant's Agent Skills support and configuration.

## 8. Troubleshooting

### 8.1 `asr: command not found`

The system cannot locate the `asr` command.

Check whether the package is installed:

```bash
python3 -m pip show audio-transcribe-cli-mcp
```

If it is not installed, try:

```bash
python3 -m pip install audio-transcribe-cli-mcp
```

If the package is installed but the command is still unavailable, check your Python installation path and PATH environment variable.

### 8.2 `ffmpeg not found`

On macOS, run:

```bash
brew install ffmpeg
```

Then verify:

```bash
ffmpeg -version
ffprobe -version
```

### 8.3 API Key Error

Check the environment variable:

```bash
if [ -n "$DASHSCOPE_API_KEY" ]; then
  echo "Configured"
else
  echo "Not configured"
fi
```

If it is not configured, repeat the API Key setup steps.

Also verify that your API Key is valid and the required Alibaba Cloud Bailian service is enabled.

### 8.4 AI Assistant Cannot Find the Skill

Check the Claude Code directory:

```bash
ls ~/.claude/skills/audio-transcribe-cli-mcp/
```

Check the Codex directory:

```bash
ls ~/.agents/skills/audio-transcribe-cli-mcp/
```

Make sure `SKILL.md` exists, then restart the corresponding AI assistant.

### 8.5 Speaker Diarization Is Not Accurate

The tool automatically detects the number of speakers.

Similar voices or poor recording quality may affect speaker identification.

Transcription results may also contain punctuation or proper-name errors. You can use an AI assistant to proofread and improve the transcript.

## 9. Installation Checklist

| Check | Expected Result |
|---|---|
| Python | Version 3.10 or newer |
| FFmpeg | Version information displayed |
| ffprobe | Version information displayed |
| Installer | `Installation completed!` |
| ASR command | `asr --help` works |
| API Key | Environment variable configured |
| Transcription test | `result.txt` generated successfully |
| Skill installation | `SKILL.md` exists |

We recommend completing one successful transcription from the terminal before using the AI assistant integration.

## 10. How It Works

```text
Input Audio / Video
        │
        ▼
FFmpeg Audio Extraction
        │
        ▼
Audio Processing
        │
        ▼
Upload to Alibaba Cloud Bailian ASR
        │
        ▼
Speech Recognition and Diarization
        │
        ▼
Return Transcription Results
        │
        ▼
Save Transcript Locally
        │
        ▼
result.txt
```

The CLI handles the entire process automatically.

Users only need to provide an audio or video file path and the required options.

## 11. Project Structure

```text
audio-transcribe-skill/
│
├── README.md
├── install.sh
├── .gitignore
├── LICENSE
│
├── skills/
│   └── audio-transcribe-cli-mcp/
│       └── SKILL.md
│
└── examples/
    └── 使用示例.md
```

## 12. Credits and License

This project is built on the following upstream project:

**Upstream Repository:**

https://github.com/OstrichHermit/audio-transcribe-cli-mcp

**PyPI Package:**

https://pypi.org/project/audio-transcribe-cli-mcp/

The upstream project provides the underlying audio/video transcription CLI, MCP Server, and related functionality.

This repository focuses on beginner-friendly installation instructions, an installation script, and Agent Skill integration for tools such as Claude Code and Codex.

This project is released under the MIT License. Original copyright notices and license requirements from the upstream project must be preserved.

---

**Make audio transcription simple and give AI assistants practical speech recognition capabilities.**
