
#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# Audio Transcribe Skill Installer
# Supports:
# 1. Local audio/video transcription
# 2. YouTube audio transcription
# ==========================================

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PYTHON_BIN="python3"
LOCAL_BIN="$HOME/.local/bin"
SHARE_DIR="$HOME/.local/share/audio-transcribe-skill"

SKILL_SOURCE="$PROJECT_ROOT/skills/audio-transcribe-cli-mcp/SKILL.md"
YOUTUBE_SOURCE="$PROJECT_ROOT/scripts/asr_youtube.py"

SKILL_DIR_CLAUDE="$HOME/.claude/skills/audio-transcribe-cli-mcp"
SKILL_DIR_AGENTS="$HOME/.agents/skills/audio-transcribe-cli-mcp"

echo ""
echo "=========================================="
echo " Audio Transcribe Skill Installer"
echo "=========================================="
echo ""

# ------------------------------------------
# 1. Check Python
# ------------------------------------------

echo "[1/7] Checking Python..."

if ! command -v "$PYTHON_BIN" >/dev/null 2>&1; then
    echo "[ERROR] Python 3 was not found."
    echo "Please install Python 3.10 or newer."
    exit 1
fi

PYTHON_VERSION="$("$PYTHON_BIN" -c \
'import sys; print(".".join(map(str, sys.version_info[:3])))')"

if ! "$PYTHON_BIN" -c \
'import sys; sys.exit(0 if sys.version_info >= (3, 10) else 1)'; then
    echo "[ERROR] Python 3.10 or newer is required."
    echo "Current version: $PYTHON_VERSION"
    exit 1
fi

echo "Python version: $PYTHON_VERSION"

# ------------------------------------------
# 2. Check FFmpeg
# ------------------------------------------

echo ""
echo "[2/7] Checking FFmpeg..."

if ! command -v ffmpeg >/dev/null 2>&1; then
    echo "[ERROR] FFmpeg was not found."
    echo "macOS installation:"
    echo "  brew install ffmpeg"
    exit 1
fi

if ! command -v ffprobe >/dev/null 2>&1; then
    echo "[ERROR] ffprobe was not found."
    echo "Please install FFmpeg:"
    echo "  brew install ffmpeg"
    exit 1
fi

echo "FFmpeg: OK"
echo "ffprobe: OK"

# ------------------------------------------
# 3. Install original ASR package
# ------------------------------------------

echo ""
echo "[3/7] Installing original ASR package..."

"$PYTHON_BIN" -m pip install --upgrade audio-transcribe-cli-mcp

if ! command -v asr >/dev/null 2>&1; then
    echo "[ERROR] The 'asr' command was not found after installation."
    echo "Please check your Python PATH configuration."
    exit 1
fi

echo "Original ASR command: OK"

# ------------------------------------------
# 4. Install yt-dlp
# ------------------------------------------

echo ""
echo "[4/7] Checking yt-dlp..."

if command -v yt-dlp >/dev/null 2>&1; then
    echo "yt-dlp is already installed."
elif command -v brew >/dev/null 2>&1; then
    echo "Installing yt-dlp using Homebrew..."
    brew install yt-dlp
elif command -v pipx >/dev/null 2>&1; then
    echo "Installing yt-dlp using pipx..."
    pipx install yt-dlp
else
    echo "Installing yt-dlp using pip..."
    "$PYTHON_BIN" -m pip install --user --upgrade yt-dlp
fi

if ! command -v yt-dlp >/dev/null 2>&1; then
    echo "[ERROR] yt-dlp installation could not be verified."
    echo "Please install it manually:"
    echo "  macOS: brew install yt-dlp"
    echo "  Other systems: python3 -m pip install --user yt-dlp"
    exit 1
fi

echo "yt-dlp: OK"

# ------------------------------------------
# 5. Install YouTube transcription script
# ------------------------------------------

echo ""
echo "[5/7] Installing YouTube transcription command..."

if [ ! -f "$YOUTUBE_SOURCE" ]; then
    echo "[ERROR] YouTube script was not found:"
    echo "$YOUTUBE_SOURCE"
    exit 1
fi

mkdir -p "$LOCAL_BIN"
mkdir -p "$SHARE_DIR"

cp "$YOUTUBE_SOURCE" "$SHARE_DIR/asr_youtube.py"

chmod +x "$SHARE_DIR/asr_youtube.py"

cat > "$LOCAL_BIN/asr-youtube" <<'EOF'
#!/usr/bin/env bash

exec python3 "$HOME/.local/share/audio-transcribe-skill/asr_youtube.py" "$@"
EOF

chmod +x "$LOCAL_BIN/asr-youtube"

echo "YouTube script installed."
echo "Command: asr-youtube"

# ------------------------------------------
# 6. Configure PATH
# ------------------------------------------

echo ""
echo "[6/7] Configuring command PATH..."

SHELL_NAME="$(basename "${SHELL:-bash}")"

case "$SHELL_NAME" in
    zsh)
        SHELL_RC="$HOME/.zshrc"
        ;;
    bash)
        SHELL_RC="$HOME/.bashrc"
        ;;
    *)
        SHELL_RC="$HOME/.profile"
        ;;
esac

mkdir -p "$(dirname "$SHELL_RC")"
touch "$SHELL_RC"

PATH_LINE='export PATH="$HOME/.local/bin:$PATH"'

if ! grep -Fq "$PATH_LINE" "$SHELL_RC"; then
    printf '\n# Audio Transcribe Skill\n%s\n' "$PATH_LINE" >> "$SHELL_RC"
    echo "Added ~/.local/bin to PATH in $SHELL_RC"
else
    echo "PATH configuration already exists."
fi

# Also update PATH for the current installation session.
export PATH="$HOME/.local/bin:$PATH"

# ------------------------------------------
# 7. Install Skill instructions
# ------------------------------------------

echo ""
echo "[7/7] Installing Skill instructions..."

if [ ! -f "$SKILL_SOURCE" ]; then
    echo "[ERROR] SKILL.md was not found:"
    echo "$SKILL_SOURCE"
    exit 1
fi

mkdir -p "$SKILL_DIR_CLAUDE"
mkdir -p "$SKILL_DIR_AGENTS"

cp "$SKILL_SOURCE" "$SKILL_DIR_CLAUDE/SKILL.md"
cp "$SKILL_SOURCE" "$SKILL_DIR_AGENTS/SKILL.md"

echo "Claude Skill installed."
echo "Agents Skill installed."

# ------------------------------------------
# Final verification
# ------------------------------------------

echo ""
echo "=========================================="
echo " Installation completed!"
echo "=========================================="

echo ""
echo "Installed components:"
echo "  [OK] Python"
echo "  [OK] FFmpeg"
echo "  [OK] Original ASR CLI"
echo "  [OK] yt-dlp"
echo "  [OK] YouTube transcription script"
echo "  [OK] asr-youtube command"
echo "  [OK] Skill instructions"

echo ""
echo "Please restart your terminal or run:"
echo "  source $SHELL_RC"

echo ""
echo "Then test the following commands:"
echo "  asr --help"
echo "  yt-dlp --version"
echo "  asr-youtube --help"

echo ""
