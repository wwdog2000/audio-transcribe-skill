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
💡 提示：把 YOUR_USERNAME 换成你的 GitHub 用户名（例如 <你的GitHub用户名>）。
安装脚本会自动检查环境、下载依赖，并把技能注入到你的 Claude Code 或 Codex 中。

🔑 第三步：配置 API Key
在终端里直接运行下面这行命令（记得替换成你真实的 Key）：

bash
echo 'export DASHSCOPE_API_KEY="sk-你的真实Key"' >> ~/.zshrc && source ~/.zshrc
🔒 安全警告：千万不要把你的 API Key 上传到 GitHub 公开仓库！

🚀 第四步：开始使用
最简单的用法
处理你桌面上的视频，结果会保存在当前目录的 result.txt 中：

bash
asr "/Users/你的用户名/Desktop/测试视频.mp4" --out result.txt
进阶用法
需求	命令
自动区分说话人	(默认已开启，无需加参数)
不要区分说话人	asr "视频.mp4" --no-speakers --out result.txt
给文字加上时间戳	asr "视频.mp4" --timestamps --out result.txt
查看所有高级功能	asr --help
📊 它是怎么工作的？
text
[你的视频/音频] 
      │
      ▼ (FFmpeg 自动提取音轨)
[纯音频流] 
      │
      ▼ (上传至阿里云百炼 ASR)
[识别结果] 
      │
      ▼ (本地保存)
[result.txt 文字稿 + 时间戳 + 说话人]
🤖 在 AI 助手里怎么用？
安装脚本完成后，你的技能已经存放在这里：

Claude Code: ~/.claude/skills/audio-transcribe-cli-mcp/

Codex: ~/.agents/skills/audio-transcribe-cli-mcp/

如果 AI 助手没有识别到它，请重启一下你的 AI 应用。
之后，你只需要对 AI 说：“帮我用 asr 把桌面的视频转成文字”，它就会自动帮你执行。

🚑 常见问题排查 (Troubleshooting)
报错 asr: command not found：
手动补装一下：python3 -m pip install audio-transcribe-cli-mcp

报错 ffmpeg not found：
说明环境变量没配好，或者没安装。请参考第一步重新检查。

提示 API Key 错误：
在终端输入 echo $DASHSCOPE_API_KEY，看看有没有输出你的 Key。如果是空的，说明第三步没配好，重新执行一次第三步。

📜 开源协议 & 致谢
MIT License.
本项目的底层引擎基于 audio-transcribe-cli-mcp 构建，本仓库主要提供针对小白的保姆级安装脚本和 AI 技能封装。
