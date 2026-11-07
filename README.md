# 🎙️ Audio Transcribe Skill

**Simple Audio & Video Transcription for AI Assistants**

[中文说明](#中文说明) | [English Documentation](#english-documentation)

[![Python](https://img.shields.io/badge/Python-3.10%2B-blue)](https://www.python.org/)
[![Platform](https://img.shields.io/badge/Platform-macOS%20%7C%20Linux-lightgrey)](https://github.com/wwdog2000/audio-transcribe-skill)
[![ASR](https://img.shields.io/badge/ASR-Aliyun%20Bailian-orange)](https://bailian.console.aliyun.com/)
[![YouTube](https://img.shields.io/badge/YouTube-Transcription-red)](https://www.youtube.com/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

A lightweight audio and video transcription tool for AI assistants such as Claude Code and Codex.

Powered by Alibaba Cloud Bailian ASR, this project converts local audio/video files and YouTube videos into text. It supports speaker diarization, sentence-level timestamps, and TXT export.

Designed for beginners, this project provides an installation script and an easy-to-follow setup guide.

---

# 中文说明

## 一、项目简介

**一款轻量级音视频转文字工具，支持本地音视频文件和 YouTube 视频转录。**

Audio Transcribe Skill 是一个面向 AI 助手的音视频转文字工具，适用于 Claude Code、Codex 等支持 Agent Skills 的 AI 工具。

本项目基于阿里云百炼 ASR（Automatic Speech Recognition）服务，可以自动提取音频或视频中的语音内容，并转换成文字。

目前支持两种转录方式：

- **本地音视频转录**：直接处理电脑中的音频或视频文件。
- **YouTube 视频转录**：输入 YouTube 视频链接，自动下载音频并完成语音识别。

支持说话人区分、句级时间戳和 TXT 文件导出。

项目的目标是让没有编程经验的用户，也能快速安装和使用音视频转文字工具，并将其接入自己的 AI 工作流。

## 二、核心功能

| 功能 | 说明 |
|---|---|
| 🎬 本地视频转文字 | 从本地视频文件中提取音轨并识别语音 |
| 🎵 本地音频转文字 | 支持常见音频格式 |
| ▶️ YouTube 转文字 | 输入 YouTube 链接，自动下载音频并转录 |
| 🗣️ 说话人区分 | 自动区分不同说话人，默认开启 |
| ⏱️ 时间戳 | 支持句级时间信息 |
| 📄 文本导出 | 将识别结果保存为 TXT 文件 |
| 🎧 音频保留 | 可选择保留下载的 YouTube 音频 |
| 🤖 AI 助手集成 | 支持 Claude Code、Codex 等 Agent Skills 环境 |

## 三、工作原理

本项目采用两条处理流程，共用同一个 ASR 识别引擎。

### 1. 本地音视频转录

```text
本地音频 / 视频文件
        │
        ▼
      FFmpeg
        │
        ▼
    音频处理
        │
        ▼
   Alibaba Cloud
      Bailian ASR
        │
        ▼
    语音识别
        │
        ▼
    TXT 文字稿
```

### 2. YouTube 视频转录

```text
YouTube 视频链接
        │
        ▼
      yt-dlp
        │
        ▼
    下载视频音频
        │
        ▼
      FFmpeg
        │
        ▼
     MP3 音频
        │
        ▼
   原有 asr 命令
        │
        ▼
   Alibaba Cloud
      Bailian ASR
        │
        ▼
    TXT 文字稿
```

两种方式均使用原有的 `audio-transcribe-cli-mcp` 识别引擎。

YouTube 功能只是增加了音频下载和转录入口，没有替换原有 ASR 工具。

## 四、安装前的准备

本项目支持 macOS 和 Linux。

需要准备：

- Python 3.10 或更高版本
- FFmpeg 和 ffprobe
- Git
- 阿里云百炼 API Key
- 网络连接

YouTube 转录还需要 `yt-dlp`。安装脚本会自动检查并尝试安装该工具。

### 1. 检查 Python

打开终端，执行：

```bash
python3 --version
```

如果显示 Python 3.10 或更高版本，即可继续。

如果没有安装 Python，请访问：

https://www.python.org/downloads/

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

## 五、一键安装

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
3. 安装或升级音视频转文字 CLI 工具。
4. 检查并安装 yt-dlp。
5. 安装 YouTube 转录脚本。
6. 创建 `asr-youtube` 命令。
7. 配置必要的命令搜索路径。
8. 将 Agent Skill 安装到 Claude Code 和 Codex 对应目录。

如果出现：

```text
Installation completed!
```

说明安装脚本已经执行完成。

### 3. 验证安装

依次执行：

检查原有 ASR 命令：

```bash
asr --help
```

检查 YouTube 转录命令：

```bash
asr-youtube --help
```

检查 yt-dlp：

```bash
yt-dlp --version
```

如果三项都能正常显示帮助信息或版本号，说明相关工具已经安装。

**注意：** 安装完成不代表 API Key 已经配置，也不代表已经完成真实视频转录。还需要进行后续测试。

## 六、配置 API Key

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

说明当前终端已经读取到 API Key。

### Linux 用户：配置环境变量

Linux 用户根据实际使用的 Shell，编辑对应配置文件。

例如 Bash 用户：

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
- 本地文件和 YouTube 下载的音频会通过阿里云百炼服务进行语音识别。
- 处理私人或敏感录音前，请确认已获得必要授权。
- 下载 YouTube 内容时，请遵守适用法律、平台条款和版权要求。

## 七、开始使用

安装和配置完成后，可以直接在终端中使用。

### 1. 本地视频转文字

```bash
asr "/Users/你的用户名/Desktop/测试视频.mp4"
```

默认情况下，识别结果保存为当前目录下的 `result.txt`。

### 2. 本地音频转文字

```bash
asr "/Users/你的用户名/Desktop/会议录音.mp3"
```

### 3. 指定输出文件

```bash
asr "/Users/你的用户名/Desktop/测试视频.mp4" \
  --out "/Users/你的用户名/Desktop/识别结果.txt"
```

### 4. 本地转录常用参数

| 使用需求 | 命令 |
|---|---|
| 自动区分说话人 | 默认开启 |
| 不区分说话人 | `asr video.mp4 --no-speakers` |
| 添加句级时间戳 | `asr video.mp4 --timestamps` |
| 指定输出文件 | `asr video.mp4 --out result.txt` |
| 查看所有参数 | `asr --help` |

### 5. YouTube 视频转文字

这是本次升级新增的功能。

只需要提供 YouTube 视频链接，不需要手动下载视频或提取音频。

**基本使用：**

```bash
asr-youtube "https://www.youtube.com/watch?v=VIDEO_ID"
```

命令会自动完成：

1. 检查 YouTube 链接。
2. 使用 yt-dlp 下载视频音频。
3. 使用 FFmpeg 将音频转换为 MP3。
4. 调用原有 `asr` 命令。
5. 完成语音识别。
6. 生成 TXT 文字稿。
7. 清理临时音频文件。

默认情况下，文字稿保存在当前工作目录，文件名根据视频标题生成。

### 6. 指定 YouTube 转录文件

```bash
asr-youtube "https://www.youtube.com/watch?v=VIDEO_ID" \
  --out "./youtube-transcript.txt"
```

### 7. YouTube 转录常用参数

| 使用需求 | 命令 |
|---|---|
| 基本转录 | `asr-youtube "YouTube链接"` |
| 指定输出文件 | `--out "./result.txt"` |
| 添加时间戳 | `--timestamps` |
| 不区分说话人 | `--no-speakers` |
| 保留下载音频 | `--keep-audio` |
| 查看所有参数 | `asr-youtube --help` |

### 8. 组合使用参数

例如：转录 YouTube 视频、添加时间戳、保留下载音频，并指定文字稿路径。

```bash
asr-youtube "https://www.youtube.com/watch?v=VIDEO_ID" \
  --timestamps \
  --keep-audio \
  --out "./youtube-transcript.txt"
```

### 9. 关于下载音频

默认情况下，YouTube 视频下载的临时 MP3 会在转录结束后清理。

如果需要保留音频文件，请添加：

```bash
--keep-audio
```

这样可以在后续进行音频剪辑、复听或其他处理。

### 10. 关于时间戳

`--timestamps` 会输出带时间信息的文本，采用 SRT 风格的时间标记。

但输出文件仍然是 TXT 文本文件，并非标准 `.srt` 字幕文件。

### 11. macOS 初学者：如何快速输入本地文件路径？

不需要手动输入很长的文件路径。

1. 打开终端。
2. 输入 `asr `，注意最后有一个空格。
3. 打开 Finder，找到需要转写的视频或音频。
4. 将文件直接拖入终端窗口。
5. 在路径后面添加 `--out result.txt`。
6. 按回车开始转写。

这样可以避免文件路径输入错误。

## 八、在 AI 助手中使用

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

### 1. 本地文件转录示例

安装成功后，可以向 AI 助手提出自然语言请求：

```text
帮我把桌面上的 interview.mp4 转换成文字稿，
自动区分说话人，并保存为 interview.txt。
```

### 2. YouTube 视频转录示例

```text
帮我把这个 YouTube 视频转换成文字稿：

https://www.youtube.com/watch?v=VIDEO_ID

保留说话人区分，并添加时间戳。
```

AI 助手可以根据 Skill 中的说明，选择对应命令完成转录。

如果 AI 助手没有立即识别到新安装的 Skill，可以尝试重启应用或重新加载技能。

注意：AI 助手能否自动识别并调用 Skill，取决于所使用工具对 Agent Skills 的支持情况及其配置。

## 九、常见问题排查

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

### 2. 提示 `asr-youtube: command not found`

重新进入项目目录，执行：

```bash
bash install.sh
```

然后检查：

```bash
asr-youtube --help
```

如果仍然找不到命令，检查：

```bash
echo "$PATH"
```

确认 `~/.local/bin` 已经加入 PATH。

### 3. 提示 `yt-dlp: command not found`

macOS 用户可以执行：

```bash
brew install yt-dlp
```

然后检查：

```bash
yt-dlp --version
```

### 4. 提示 `ffmpeg not found`

macOS 用户可以执行：

```bash
brew install ffmpeg
```

然后重新检查：

```bash
ffmpeg -version
ffprobe -version
```

### 5. 提示 API Key 错误

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

### 6. YouTube 视频下载失败

请检查：

- YouTube 链接是否正确。
- 视频是否可以公开访问。
- 当前网络是否能够访问 YouTube。
- yt-dlp 是否为较新版本。
- FFmpeg 是否已经安装。
- 视频是否存在地区、年龄或访问权限限制。

### 7. 说话人区分效果不理想

如果音频中说话人音色接近，或者录音质量较差，可能影响区分效果。

识别结果也可能存在标点或专有名词错误，建议将文字稿交给 AI 进一步校对。

### 8. 识别失败或没有生成 TXT

检查：

- API Key 是否有效。
- 网络是否正常。
- 阿里云百炼服务是否可用。
- 账户是否有足够的服务额度。
- 输入文件是否完整。
- 输出目录是否具有写入权限。

## 十、安装完成检查清单

| 检查项目 | 成功标志 |
|---|---|
| Python | 版本为 3.10 或更高 |
| FFmpeg | 能显示版本信息 |
| ffprobe | 能显示版本信息 |
| 安装脚本 | 显示 `Installation completed!` |
| ASR 命令 | `asr --help` 正常 |
| YouTube 命令 | `asr-youtube --help` 正常 |
| yt-dlp | 能显示版本信息 |
| API Key | 显示 `API Key 已配置` |
| 本地转录测试 | 成功生成 TXT 文件 |
| YouTube 转录测试 | 成功生成 TXT 文件 |
| Skill 文件 | 找到 `SKILL.md` |

建议先通过终端分别完成一次本地文件转录和 YouTube 转录测试，再使用 AI 助手调用。

## 十一、项目目录结构

```text
audio-transcribe-skill/
│
├── README.md
├── install.sh
├── .gitignore
├── LICENSE
│
├── scripts/
│   └── asr_youtube.py
│
├── skills/
│   └── audio-transcribe-cli-mcp/
│       └── SKILL.md
│
└── examples/
    └── 使用示例.md
```

其中：

| 文件 | 作用 |
|---|---|
| `README.md` | 项目说明和使用教程 |
| `install.sh` | 一键安装脚本 |
| `scripts/asr_youtube.py` | YouTube 下载与转录程序 |
| `SKILL.md` | AI 助手的技能说明文件 |
| `.gitignore` | Git 忽略文件配置 |
| `LICENSE` | 开源协议 |

## 十二、项目来源与开源协议

本项目基于以下开源项目构建：

**上游项目：**

https://github.com/OstrichHermit/audio-transcribe-cli-mcp

**PyPI：**

https://pypi.org/project/audio-transcribe-cli-mcp/

上游项目提供底层音视频转文字 CLI、MCP Server 和相关功能。

本仓库主要面向初学者，提供更直观的安装说明、YouTube 转录入口、安装脚本及 AI Agent Skill 封装。

本项目采用 MIT License。上游项目的原作者及其版权声明应按照原项目许可证要求保留。

---

# English Documentation

## 1. Introduction

Audio Transcribe Skill is a lightweight audio and video transcription tool designed for AI assistants such as Claude Code and Codex.

Powered by Alibaba Cloud Bailian ASR (Automatic Speech Recognition), it converts local audio/video files and YouTube videos into text.

It supports speaker diarization, sentence-level timestamps, and TXT export.

This project aims to make audio transcription accessible to beginners and easy to integrate into AI workflows.

Two transcription workflows are supported:

- **Local transcription:** Process audio and video files stored on your computer.
- **YouTube transcription:** Provide a YouTube URL and automatically download and transcribe its audio.

## 2. Features

| Feature | Description |
|---|---|
| 🎬 Local Video Transcription | Extract audio from local video files and transcribe speech |
| 🎵 Local Audio Transcription | Transcribe common audio formats |
| ▶️ YouTube Transcription | Download audio from YouTube URLs and transcribe it |
| 🗣️ Speaker Diarization | Automatically distinguish speakers; enabled by default |
| ⏱️ Timestamps | Support sentence-level timestamps |
| 📄 TXT Export | Save transcription results as TXT files |
| 🎧 Keep Downloaded Audio | Optionally retain downloaded YouTube audio |
| 🤖 AI Integration | Install as an Agent Skill for Claude Code and Codex |

## 3. How It Works

The project provides two workflows using the same ASR engine.

### Local Audio and Video

```text
Local Audio / Video
        │
        ▼
      FFmpeg
        │
        ▼
    Audio Processing
        │
        ▼
 Alibaba Cloud Bailian ASR
        │
        ▼
  Speech Recognition
        │
        ▼
    TXT Transcript
```

### YouTube Videos

```text
YouTube Video URL
        │
        ▼
      yt-dlp
        │
        ▼
   Download Audio
        │
        ▼
      FFmpeg
        │
        ▼
     MP3 Audio
        │
        ▼
    Existing asr CLI
        │
        ▼
 Alibaba Cloud Bailian ASR
        │
        ▼
    TXT Transcript
```

Both workflows use the existing `audio-transcribe-cli-mcp` recognition engine.

YouTube support adds an audio download and transcription entry point without replacing the original ASR tool.

## 4. Prerequisites

This project supports macOS and Linux.

Before installation, make sure you have:

- Python 3.10 or newer
- FFmpeg and ffprobe
- Git
- An Alibaba Cloud Bailian API Key
- Network access

For YouTube transcription, `yt-dlp` is also required. The installer checks for and attempts to install it automatically.

### 4.1 Check Python

```bash
python3 --version
```

Python 3.10 or newer is required.

If Python is not installed, download it from:

https://www.python.org/downloads/

### 4.2 Check FFmpeg

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

### 4.3 Get an Alibaba Cloud Bailian API Key

This tool uses Alibaba Cloud Bailian ASR for speech recognition.

Visit:

https://bailian.console.aliyun.com/

Sign in, enable the required service, and obtain your API Key.

Keep your API Key private. Never publish it in your GitHub repository.

## 5. Installation

### 5.1 Clone the Repository

```bash
git clone https://github.com/wwdog2000/audio-transcribe-skill.git
```

Enter the project directory:

```bash
cd audio-transcribe-skill
```

### 5.2 Run the Installation Script

Execute:

```bash
bash install.sh
```

The installer automatically:

1. Checks the Python version.
2. Checks whether FFmpeg and ffprobe are installed.
3. Installs or upgrades the transcription CLI.
4. Checks for and installs yt-dlp.
5. Installs the YouTube transcription script.
6. Creates the `asr-youtube` command.
7. Configures the required command path.
8. Copies the Agent Skill to the Claude Code and Codex skill directories.

If you see:

```text
Installation completed!
```

the installation script has finished.

### 5.3 Verify the Installation

Check the original ASR command:

```bash
asr --help
```

Check the YouTube command:

```bash
asr-youtube --help
```

Check yt-dlp:

```bash
yt-dlp --version
```

All three commands should display help information or version numbers.

**Important:** Successful installation does not mean your API Key is configured or that transcription has been tested. Complete the following setup and tests.

## 6. Configure the API Key

An Alibaba Cloud Bailian API Key is required to use the transcription service.

### macOS: Configure with TextEdit

This method uses the built-in macOS text editor. You do not need to use a terminal text editor such as nano.

**Step 1: Open the configuration file**

Run:

```bash
touch ~/.zshrc && open -e ~/.zshrc
```

Press Enter.

TextEdit will open the configuration file.

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
- Local media and downloaded YouTube audio are sent to Alibaba Cloud Bailian for speech recognition.
- Obtain the necessary authorization before processing private or sensitive recordings.
- Follow applicable laws, platform terms, and copyright requirements when downloading YouTube content.

## 7. Usage

### 7.1 Local Video Transcription

```bash
asr "/Users/your-username/Desktop/video.mp4"
```

By default, the transcription result is saved as `result.txt` in the current working directory.

### 7.2 Local Audio Transcription

```bash
asr "/Users/your-username/Desktop/meeting.mp3"
```

### 7.3 Specify an Output File

```bash
asr "/Users/your-username/Desktop/video.mp4" \
  --out "/Users/your-username/Desktop/transcript.txt"
```

### 7.4 Local Transcription Options

| Task | Command |
|---|---|
| Enable speaker diarization | Enabled by default |
| Disable speaker diarization | `asr video.mp4 --no-speakers` |
| Add sentence-level timestamps | `asr video.mp4 --timestamps` |
| Specify output file | `asr video.mp4 --out result.txt` |
| Display all options | `asr --help` |

### 7.5 YouTube Video Transcription

This is the new feature introduced in this release.

Simply provide a YouTube video URL. You do not need to manually download the video or extract its audio.

**Basic usage:**

```bash
asr-youtube "https://www.youtube.com/watch?v=VIDEO_ID"
```

The command automatically:

1. Validates the YouTube URL.
2. Uses yt-dlp to download the video's audio.
3. Uses FFmpeg to convert the audio to MP3.
4. Calls the existing `asr` command.
5. Performs speech recognition.
6. Generates a TXT transcript.
7. Cleans up temporary audio files.

By default, the transcript is saved in the current working directory using a filename based on the video title.

### 7.6 Specify the YouTube Transcript File

```bash
asr-youtube "https://www.youtube.com/watch?v=VIDEO_ID" \
  --out "./youtube-transcript.txt"
```

### 7.7 YouTube Transcription Options

| Task | Option |
|---|---|
| Basic transcription | `asr-youtube "YouTube URL"` |
| Specify output file | `--out "./result.txt"` |
| Add timestamps | `--timestamps` |
| Disable speaker diarization | `--no-speakers` |
| Keep downloaded audio | `--keep-audio` |
| Display all options | `asr-youtube --help` |

### 7.8 Combine Options

For example, transcribe a YouTube video with timestamps, retain the downloaded audio, and specify the transcript path:

```bash
asr-youtube "https://www.youtube.com/watch?v=VIDEO_ID" \
  --timestamps \
  --keep-audio \
  --out "./youtube-transcript.txt"
```

### 7.9 Downloaded Audio

By default, temporary downloaded MP3 files are cleaned up after transcription.

To keep a copy of the downloaded audio, add:

```bash
--keep-audio
```

The audio can then be used for further editing, review, or processing.

### 7.10 Timestamps

The `--timestamps` option produces text with SRT-style time markers.

The output remains a TXT file and is not a standard `.srt` subtitle file.

### 7.11 Beginner Tip: Enter a File Path on macOS

You do not need to type a long file path manually.

1. Open Terminal.
2. Type `asr `, including the trailing space.
3. Open Finder and locate your audio or video file.
4. Drag the file directly into the Terminal window.
5. Add `--out result.txt` after the file path.
6. Press Enter to start transcription.

This method helps avoid incorrect file paths.

## 8. Use with AI Assistants

This project can run independently in the terminal or be integrated into supported AI assistants as an Agent Skill.

The installation script copies the Skill file into the following directories.

**Claude Code**

```text
~/.claude/skills/audio-transcribe-cli-mcp/
```

**Codex**

```text
~/.agents/skills/audio-transcribe-cli-mcp/
```

The directory should contain:

```text
SKILL.md
```

### 8.1 Local File Example

After installation, you can ask your AI assistant:

```text
Please transcribe interview.mp4 on my Desktop,
identify different speakers,
and save the result as interview.txt.
```

### 8.2 YouTube Example

```text
Please transcribe this YouTube video:

https://www.youtube.com/watch?v=VIDEO_ID

Keep speaker diarization enabled and include timestamps.
```

The AI assistant can use the instructions in the Skill to select the appropriate command.

If the Skill is not immediately recognized, restart the AI assistant or reload its skills.

**Note:** Automatic Skill discovery and execution depend on the AI assistant's Agent Skills support and configuration.

## 9. Troubleshooting

### 9.1 `asr: command not found`

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

### 9.2 `asr-youtube: command not found`

Run the installer again from the project directory:

```bash
bash install.sh
```

Then check:

```bash
asr-youtube --help
```

If the command is still unavailable, check:

```bash
echo "$PATH"
```

Make sure `~/.local/bin` is included in PATH.

### 9.3 `yt-dlp: command not found`

On macOS, run:

```bash
brew install yt-dlp
```

Then verify:

```bash
yt-dlp --version
```

### 9.4 `ffmpeg not found`

On macOS, run:

```bash
brew install ffmpeg
```

Then verify:

```bash
ffmpeg -version
ffprobe -version
```

### 9.5 API Key Error

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

### 9.6 YouTube Download Failure

Check:

- Whether the YouTube URL is valid.
- Whether the video is publicly accessible.
- Whether your network can access YouTube.
- Whether yt-dlp is up to date.
- Whether FFmpeg is installed.
- Whether the video has regional, age, or access restrictions.

### 9.7 Speaker Diarization Is Not Accurate

Similar voices or poor recording quality may affect speaker identification.

Transcription results may also contain punctuation or proper-name errors. You can use an AI assistant to proofread and improve the transcript.

### 9.8 Transcription Failed or No TXT File Was Generated

Check:

- Whether the API Key is valid.
- Whether the network connection is working.
- Whether Alibaba Cloud Bailian is available.
- Whether your account has sufficient service quota.
- Whether the input file is valid.
- Whether the output directory is writable.

## 10. Installation Checklist

| Check | Expected Result |
|---|---|
| Python | Version 3.10 or newer |
| FFmpeg | Version information displayed |
| ffprobe | Version information displayed |
| Installer | `Installation completed!` |
| ASR command | `asr --help` works |
| YouTube command | `asr-youtube --help` works |
| yt-dlp | Version information displayed |
| API Key | Environment variable configured |
| Local transcription test | TXT file generated successfully |
| YouTube transcription test | TXT file generated successfully |
| Skill installation | `SKILL.md` exists |

We recommend completing one successful local transcription and one successful YouTube transcription from the terminal before using the AI assistant integration.

## 11. Project Structure

```text
audio-transcribe-skill/
│
├── README.md
├── install.sh
├── .gitignore
├── LICENSE
│
├── scripts/
│   └── asr_youtube.py
│
├── skills/
│   └── audio-transcribe-cli-mcp/
│       └── SKILL.md
│
└── examples/
    └── 使用示例.md
```

| File | Description |
|---|---|
| `README.md` | Project overview and user guide |
| `install.sh` | One-click installation script |
| `scripts/asr_youtube.py` | YouTube audio download and transcription program |
| `SKILL.md` | AI assistant skill instructions |
| `.gitignore` | Git ignore configuration |
| `LICENSE` | Open-source license |

## 12. Credits and License

This project is built on the following upstream project:

**Upstream Repository:**

https://github.com/OstrichHermit/audio-transcribe-cli-mcp

**PyPI Package:**

https://pypi.org/project/audio-transcribe-cli-mcp/

The upstream project provides the underlying audio/video transcription CLI, MCP Server, and related functionality.

This repository focuses on beginner-friendly installation instructions, YouTube transcription support, an installation script, and Agent Skill integration.

This project is released under the MIT License. Original copyright notices and license requirements from the upstream project must be preserved.

---

**Make audio transcription simple and give AI assistants practical speech recognition capabilities.**
