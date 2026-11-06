
#!/bin/bash

set -euo pipefail

echo "======================================"
echo " Audio Transcribe Skill Installer"
echo "======================================"

# 定位项目根目录
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_SOURCE="$PROJECT_DIR/skills/audio-transcribe-cli-mcp/SKILL.md"

# 检查 Python
echo ""
echo "[1/4] Checking Python..."

if ! command -v python3 >/dev/null 2>&1; then
    echo "ERROR: Python 3 is not installed."
    exit 1
fi

python3 -c '
import sys
if sys.version_info < (3, 10):
    print("ERROR: Python 3.10 or newer is required.")
    sys.exit(1)
print("Python version:", sys.version.split()[0])
'

# 检查 ffmpeg
echo ""
echo "[2/4] Checking ffmpeg..."

if ! command -v ffmpeg >/dev/null 2>&1; then
    echo "ERROR: ffmpeg not found."
    echo "Install it with: brew install ffmpeg"
    exit 1
fi

if ! command -v ffprobe >/dev/null 2>&1; then
    echo "ERROR: ffprobe not found."
    exit 1
fi

echo "ffmpeg and ffprobe are ready."

# 安装 Python 包
echo ""
echo "[3/4] Installing transcription CLI..."

python3 -m pip install --upgrade audio-transcribe-cli-mcp

# 检查 Skill 文件
echo ""
echo "[4/4] Installing Agent Skill..."

if [ ! -f "$SKILL_SOURCE" ]; then
    echo "ERROR: SKILL.md not found:"
    echo "$SKILL_SOURCE"
    exit 1
fi

# Claude Code
CLAUDE_DIR="$HOME/.claude/skills/audio-transcribe-cli-mcp"
mkdir -p "$CLAUDE_DIR"
cp "$SKILL_SOURCE" "$CLAUDE_DIR/SKILL.md"

echo "Installed for Claude Code."

# Codex / Agent Skills
CODEX_DIR="$HOME/.agents/skills/audio-transcribe-cli-mcp"
mkdir -p "$CODEX_DIR"
cp "$SKILL_SOURCE" "$CODEX_DIR/SKILL.md"

echo "Installed for Codex."

# 验证命令
echo ""
if command -v asr >/dev/null 2>&1; then
    echo "ASR command: $(command -v asr)"
else
    echo "WARNING: asr command is not currently in PATH."
    echo "Check your Python installation and PATH."
fi

echo ""
echo "======================================"
echo " Installation completed!"
echo "======================================"

echo ""
echo "Next step:"
echo 'Configure DASHSCOPE_API_KEY in ~/.zshrc'
echo 'Then run: source ~/.zshrc'
echo ""
echo 'Test with: asr --help'
