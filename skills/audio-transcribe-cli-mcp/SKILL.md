
---
name: audio-transcribe-cli-mcp
description: Transcribe audio and video files into text using Alibaba Cloud Bailian ASR. Use when the user asks to transcribe, convert speech to text, extract dialogue, identify speakers, or obtain timestamps from local audio or video files.
---

# Audio and Video Transcription Skill

## Purpose

Use the audio-transcribe-cli-mcp command-line tool to convert local audio and video files into text through Alibaba Cloud Bailian ASR.

## Requirements

- macOS or Linux
- Python 3.10 or newer
- ffmpeg and ffprobe installed and available in PATH
- Python package audio-transcribe-cli-mcp installed
- DASHSCOPE_API_KEY configured in the environment

## Supported Input

The tool supports audio and video formats accepted by ffmpeg, including:

- MP4, MOV, MKV
- MP3, WAV, M4A
- AAC, FLAC, OGG, OPUS
- Other ffmpeg-supported formats

## Workflow

### Step 1: Identify the input file

Obtain the exact local file path from the user.

If the user has not specified a file, ask for its location.

Never guess a file path.

### Step 2: Check the environment

Check whether the following commands are available:

```bash
python3 --version
ffmpeg -version
ffprobe -version
asr --help
```

Check whether the API key is configured without displaying its value:

```bash
if [ -n "$DASHSCOPE_API_KEY" ]; then
  echo "API key configured"
else
  echo "API key missing"
fi
```

Never print, expose, or transmit the API key to the user or unrelated services.

### Step 3: Transcribe the file

Use the following command:

```bash
asr "/absolute/path/to/input.mp4" --out "/absolute/path/to/result.txt"
```

For speaker diarization:

```bash
asr "/absolute/path/to/input.mp4" --out "/absolute/path/to/result.txt"
```

Speaker separation is enabled by default.

To disable speaker separation:

```bash
asr "/absolute/path/to/input.mp4" --no-speakers --out "/absolute/path/to/result.txt"
```

To include sentence-level timestamps:

```bash
asr "/absolute/path/to/input.mp4" --timestamps --out "/absolute/path/to/result.txt"
```

### Step 4: Verify the output

After execution:

1. Check the command exit status.
2. Confirm that the output file exists.
3. Check that the output file is not empty.
4. Report the output file path to the user.
5. If transcription fails, explain the actual error.

Do not claim successful transcription unless the output has been verified.

## Safety Rules

- Never overwrite the original audio or video file.
- Do not upload user files to unrelated services.
- Do not expose API keys in logs or output.
- Ask for permission before executing commands that access user files.
- Keep generated transcripts separate from original media.
- Do not invent missing dialogue or transcription content.

## Example User Requests

- Convert this MP4 video into Chinese text.
- Extract dialogue from this MOV file.
- Transcribe this meeting recording.
- Identify different speakers in this audio.
- Generate a timestamped transcript.
- Save the transcription result as a TXT file.

## Troubleshooting

### API key error

Check DASHSCOPE_API_KEY configuration.

### ffmpeg not found

Install ffmpeg and ensure it is available in PATH.

### asr command not found

Install the Python package:

```bash
python3 -m pip install audio-transcribe-cli-mcp
```

### File not found

Check the file path, filename, and permissions.

### Recognition failure

Check network access, API key validity, Bailian service availability, and account quota.
