
# Audio Transcribe Skill

**AI-powered Audio & Video Transcription with Alibaba Cloud Bailian ASR**

一个面向 AI 助手的语音转文字 Skill。

通过阿里云百炼语音识别服务，将本地视频、音频自动转换成文字，支持多人说话人分离和句级时间戳。

## Features

- Video to Text
- Audio to Text
- Automatic audio extraction via FFmpeg
- Speaker diarization
- Sentence-level timestamps
- TXT output
- Claude Code Skill support
- Codex Skill support

## Project Architecture

```text
audio-transcribe-skill/
├── README.md
├── install.sh
├── .gitignore
├── LICENSE
├── skills/
│   └── audio-transcribe-cli-mcp/
│       └── SKILL.md
└── examples/
    └── 使用示例.md
```

## Requirements

- macOS or Linux
- Python 3.10+
- FFmpeg
- Alibaba Cloud Bailian API Key

## Installation

### Step 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/audio-transcribe-skill.git

cd audio-transcribe-skill
```

Replace YOUR_USERNAME with your GitHub username.

### Step 2. Run installer

```bash
bash install.sh
```

The installer will:

1. Check Python.
2. Check FFmpeg.
3. Install audio-transcribe-cli-mcp.
4. Install the Skill for Claude Code.
5. Install the Skill for Codex.

### Step 3. Configure Alibaba Cloud API Key

Create an API Key in Alibaba Cloud Bailian:

https://bailian.console.aliyun.com/

Open your terminal:

```bash
nano ~/.zshrc
```

Add this line at the bottom:

```bash
export DASHSCOPE_API_KEY="YOUR_API_KEY"
```

Replace YOUR_API_KEY with your actual key.

Save the file:

- Press Control + O
- Press Enter
- Press Control + X

Reload the configuration:

```bash
source ~/.zshrc
```

Verify that the key exists without printing its value:

```bash
if [ -n "$DASHSCOPE_API_KEY" ]; then
  echo "API Key configured."
else
  echo "API Key missing."
fi
```

**Security:** Never upload your API Key to GitHub.

## Usage

### Transcribe a video

```bash
asr "/path/to/video.mp4" --out result.txt
```

### Transcribe an audio file

```bash
asr "/path/to/audio.mp3" --out result.txt
```

### Speaker diarization

```bash
asr "/path/to/video.mp4" --out result.txt
```

Speaker separation is enabled by default.

### Disable speaker diarization

```bash
asr "/path/to/video.mp4" --no-speakers --out result.txt
```

### Include timestamps

```bash
asr "/path/to/video.mp4" --timestamps --out result.txt
```

### Check the CLI

```bash
asr --help
```

## Agent Skill Installation

The installer copies the Skill to:

Claude Code:

```text
~/.claude/skills/audio-transcribe-cli-mcp/
```

Codex:

```text
~/.agents/skills/audio-transcribe-cli-mcp/
```

Restart the AI application if the Skill is not detected.

## Original Engine

This project uses the existing open-source project:

https://github.com/OstrichHermit/audio-transcribe-cli-mcp

Python package:

https://pypi.org/project/audio-transcribe-cli-mcp/

The original project provides the ASR engine and MCP Server.

This repository provides a beginner-friendly installation and Agent Skill package.

## Troubleshooting

### asr: command not found

Run:

```bash
python3 -m pip install audio-transcribe-cli-mcp
```

### ffmpeg not found

Run:

```bash
brew install ffmpeg
```

### API Key error

Check your DASHSCOPE_API_KEY environment variable.

### Skill not detected

Check whether SKILL.md exists in the relevant skills directory and restart your AI application.

## License

MIT License.
