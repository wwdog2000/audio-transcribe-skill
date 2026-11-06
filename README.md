# 🎙️ Audio Transcribe Skill

**一句话，把视频和音频转换成带时间轴的文字稿。**

Audio Transcribe Skill 是一个面向 AI 助手的语音转文字技能包，适用于 Claude Code、Codex 等支持 Agent Skills 的 AI 工具。

本项目基于阿里云百炼 ASR（Automatic Speech Recognition）服务，可以自动提取音频或视频中的语音内容，支持中英文识别、多人对话说话人区分以及句级时间戳。

项目的目标是让没有编程经验的用户，也能快速安装和使用音视频转文字工具，并将其接入自己的 AI 工作流。

## ✨ 一、核心功能

- 🎬 **视频转文字**：支持从视频文件中自动提取音轨并识别语音。
- 🎵 **音频转文字**：支持常见音频格式。
- 🗣️ **说话人区分**：自动识别不同说话人，默认开启。
- ⏱️ **时间戳**：生成带句级时间信息的识别结果。
- 📄 **文本导出**：支持将识别结果保存为 TXT 文件。
- 🤖 **AI 助手集成**：可安装为 Claude Code、Codex 等工具使用的 Agent Skill。

## 🛠️ 二、安装前的准备

本项目支持 macOS 和 Linux 环境。

开始安装前，请确认电脑具备以下条件：

### 1. Python 3.10 或更高版本

打开终端，输入：

```bash
python3 --version
```

如果显示 Python 3.10 或更高版本，即可继续。

### 2. FFmpeg

FFmpeg 用于从视频中提取音频，以及进行必要的音频处理。

检查是否已经安装：

```bash
ffmpeg -version
```

同时确认 ffprobe 可用：

```bash
ffprobe -version
```

如果是 macOS 用户，可以通过 Homebrew 安装：

```bash
brew install ffmpeg
```

### 3. 阿里云百炼 API Key

本工具使用阿里云百炼 ASR 服务进行语音识别，需要配置 `DASHSCOPE_API_KEY`。

请登录阿里云百炼平台，开通相关服务并获取 API Key：

[阿里云百炼控制台](https://bailian.console.aliyun.com/)

注意：API Key 相当于账户访问凭证，请妥善保管，不要公开或上传到 GitHub。

## 📦 三、一键安装

### 1. 下载项目

打开终端，依次执行：

```bash
git clone https://github.com/wwdog2000/audio-transcribe-skill.git
```

进入项目目录：

```bash
cd audio-transcribe-skill
```

### 2. 执行安装脚本

运行：

```bash
bash install.sh
```

安装脚本将自动执行以下操作：

1. 检查 Python 版本。
2. 检查 FFmpeg 和 ffprobe 是否安装。
3. 安装音视频转文字 CLI 工具及相关依赖。
4. 将 Agent Skill 安装到 Claude Code 和 Codex 对应的技能目录。

安装完成后，可以检查命令是否可用：

```bash
asr --help
```

如果能够显示命令帮助信息，说明 CLI 已经可以正常调用。

## 🔑 四、配置 API Key

安装完成后，需要配置阿里云百炼 API Key。

macOS 用户如果使用 Zsh，可以按照以下步骤操作。

### 1. 打开配置文件

```bash
nano ~/.zshrc
```

### 2. 添加 API Key

在文件末尾添加以下内容，将占位符替换成自己的真实 API Key：

```bash
export DASHSCOPE_API_KEY="sk-你的真实API-Key"
```

### 3. 保存并使配置生效

在 nano 编辑器中：

- 按 `Control + O`，然后按回车保存。
- 按 `Control + X` 退出。

然后执行：

```bash
source ~/.zshrc
```

### 4. 检查配置

可以通过下面的命令检查 API Key 是否已经设置：

```bash
if [ -n "$DASHSCOPE_API_KEY" ]; then echo "API Key 已配置"; else echo "API Key 未配置"; fi
```

如果显示 API Key 已配置，说明环境变量已经生效。

**安全提醒：**

- 不要将真实 API Key 写入公开的 README、代码或示例文件。
- 不要将包含 API Key 的 `.env` 文件上传到 GitHub。
- 音频和视频文件会上传至阿里云百炼进行语音识别。处理私人或敏感录音前，请确认已获得必要授权。
- 不要将原始音视频文件上传到本项目的公开仓库。

## 🚀 五、开始使用

安装和配置完成后，就可以直接在终端中使用 `asr` 命令。

### 1. 最简单的用法

将桌面上的视频转换为文字：

```bash
asr "/Users/你的用户名/Desktop/测试视频.mp4"
```

默认情况下，识别结果会保存为当前目录下的 `result.txt`。

### 2. 指定输出文件

如果希望将识别结果保存到指定位置：

```bash
asr "/Users/你的用户名/Desktop/测试视频.mp4" --out "/Users/你的用户名/Desktop/识别结果.txt"
```

### 3. 常用参数

| 使用需求 | 命令 |
|---|---|
| 自动区分说话人 | 默认开启，无需添加参数 |
| 不区分说话人 | `asr video.mp4 --no-speakers` |
| 添加句级时间戳 | `asr video.mp4 --timestamps` |
| 指定输出文件 | `asr video.mp4 --out result.txt` |
| 查看所有参数 | `asr --help` |

### 4. 实际使用示例

**视频转文字：**

```bash
asr interview.mp4 --out interview.txt
```

**音频转文字：**

```bash
asr meeting.mp3 --out meeting.txt
```

**不区分说话人：**

```bash
asr interview.mp4 --no-speakers --out interview.txt
```

**生成带时间戳的文字稿：**

```bash
asr meeting.mp3 --timestamps --out meeting.txt
```

说明：`--timestamps` 会输出带时间信息的文本，采用 SRT 风格的时间标记，但输出文件仍然是文本文件，并非标准 `.srt` 字幕文件。

## 📊 六、工作原理

整个处理过程可以简单理解为：

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

整个过程由 CLI 工具自动完成，用户只需要提供音视频文件路径和必要的参数。

## 🤖 七、在 AI 助手中使用

本项目不仅可以在终端中独立运行，还可以作为 Agent Skill 接入 AI 助手。

安装脚本会将技能文件复制到对应的用户级 Skill 目录。

### 1. Claude Code

安装目录：

```text
~/.claude/skills/audio-transcribe-cli-mcp/
```

### 2. Codex

安装目录：

```text
~/.agents/skills/audio-transcribe-cli-mcp/
```

如果 AI 助手没有立即识别到新安装的 Skill，可以尝试重启应用或重新加载技能。

### 3. 使用示例

安装成功后，可以直接向 AI 助手提出自然语言请求，例如：

```text
帮我把桌面上的 interview.mp4 转换成文字稿，
自动区分说话人，并保存为 interview.txt。
```

AI 助手可以根据 Skill 中的说明调用 `asr` 命令完成任务。

**注意：** AI 助手能否自动识别并调用 Skill，取决于所使用工具对 Agent Skills 的支持情况及其配置。

## 🚑 八、常见问题排查

### 1. 提示 `asr: command not found`

说明系统没有找到 `asr` 命令。

可以检查：

```bash
python3 -m pip show audio-transcribe-cli-mcp
```

如果尚未安装，可以尝试：

```bash
python3 -m pip install audio-transcribe-cli-mcp
```

如果已经安装但命令仍不可用，需要检查 Python 的安装路径和 PATH 环境变量。

### 2. 提示 `ffmpeg not found`

说明 FFmpeg 未安装，或者系统无法找到对应命令。

macOS 用户可以执行：

```bash
brew install ffmpeg
```

安装完成后重新检查：

```bash
ffmpeg -version
ffprobe -version
```

### 3. 提示 API Key 错误

首先检查环境变量：

```bash
if [ -n "$DASHSCOPE_API_KEY" ]; then echo "已设置"; else echo "未设置"; fi
```

如果显示未设置，请重新检查第四部分的配置步骤。

同时确认阿里云百炼 API Key 有效，并且相关服务已经开通。

### 4. AI 助手没有识别到 Skill

检查对应目录是否存在：

Claude Code：

```bash
ls ~/.claude/skills/audio-transcribe-cli-mcp/
```

Codex：

```bash
ls ~/.agents/skills/audio-transcribe-cli-mcp/
```

确认目录中包含 `SKILL.md`，然后重启对应的 AI 助手。

## 📁 九、项目目录结构

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

## 🔗 十、项目来源与开源协议

本项目基于以下开源项目构建：

**上游项目：**

[OstrichHermit/audio-transcribe-cli-mcp](https://github.com/OstrichHermit/audio-transcribe-cli-mcp)

**PyPI：**

[audio-transcribe-cli-mcp](https://pypi.org/project/audio-transcribe-cli-mcp/)

上游项目提供底层音视频转文字 CLI、MCP Server 和相关功能。

本仓库主要面向初学者，提供更直观的安装说明、安装脚本及 AI Agent Skill 封装，方便用户在 Claude Code、Codex 等工具中使用。

本项目采用 MIT License。上游项目的原作者及其版权声明应按照原项目许可证要求保留。

---

**让音视频转文字变得简单，让 AI 助手拥有真正可用的语音识别能力。**
