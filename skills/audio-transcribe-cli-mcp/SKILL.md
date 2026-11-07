
---
name: audio-transcribe-cli-mcp
description: Transcribe local audio and video files or publicly accessible YouTube videos into text using Alibaba Cloud Bailian ASR. Use when the user asks to transcribe audio, video, YouTube links, extract dialogue, identify speakers, or obtain timestamps.
---

---
name: audio-transcribe-cli-mcp
description: Transcribe local audio and video files or YouTube videos into text using Alibaba Cloud Bailian ASR. Use when the user asks to transcribe recordings, convert speech to text, extract dialogue, identify speakers, or obtain timestamps.
---

# Audio and Video Transcription Skill

## Purpose

Convert audio and video into text using Alibaba Cloud Bailian ASR.

This Skill supports two input types:

1. Local audio and video files.
2. YouTube video URLs.

Choose the appropriate workflow according to the user's input.

## Requirements

- macOS or Linux.
- Python 3.10 or newer.
- ffmpeg and ffprobe installed and available in PATH.
- Python package `audio-transcribe-cli-mcp` installed.
- `DASHSCOPE_API_KEY` configured in the environment.
- `yt-dlp` installed for YouTube transcription.
- `asr` command available for local transcription.
- `asr-youtube` command available for YouTube transcription.

## Supported Input

### Local audio and video

Formats supported by ffmpeg, including:

- Video: MP4, MOV, MKV.
- Audio: MP3, WAV, M4A.
- Other formats supported by ffmpeg.

### YouTube videos

Supported URL formats include:

- `https://www.youtube.com/watch?v=VIDEO_ID`
- `https://youtu.be/VIDEO_ID`
- `https://www.youtube.com/shorts/VIDEO_ID`

Only public or otherwise accessible videos can be downloaded. Private, restricted, age-restricted, or region-blocked videos may fail.

## Workflow

### Step 1: Identify the input type

Determine whether the user provided:

- A local audio or video file path.
- A YouTube video URL.

If the input is a local file, use Workflow A.

If the input is a YouTube URL, use Workflow B.

If the input is missing or unclear, ask the user for the file path or video URL.

Never guess a file path or video URL.

### Step 2: Check the environment

Check the required commands:

```bash
python3 --version
ffmpeg -version
ffprobe -version
asr --help
```

Check the API key without displaying its value:

```bash
if [ -n "$DASHSCOPE_API_KEY" ]; then
  echo "API key configured"
else
  echo "API key missing"
fi
```

For YouTube transcription, also check:

```bash
yt-dlp --version
asr-youtube --help
```

Never print, expose, or transmit the API key to unrelated services.

## Workflow A: Local Audio and Video Transcription

### Step A1: Identify the file

Obtain the exact local file path from the user.

If the user has not specified a file, ask for its location.

### Step A2: Transcribe the file

Basic transcription:

```bash
asr "/absolute/path/to/input.mp4" --out "/absolute/path/to/result.txt"
```

Speaker separation is enabled by default.

To disable speaker separation:

```bash
asr "/absolute/path/to/input.mp4" --no-speakers --out "/absolute/path/to/result.txt"
```

To include timestamps:

```bash
asr "/absolute/path/to/input.mp4" --timestamps --out "/absolute/path/to/result.txt"
```

### Step A3: Verify the output

After execution:

1. Check the command exit status.
2. Confirm that the output file exists.
3. Check that the output file is not empty.
4. Report the output file path.
5. If transcription fails, explain the actual error.

Do not claim successful transcription unless the output has been verified.

## Workflow B: YouTube Video Transcription

### Step B1: Obtain the YouTube URL

Ask the user to provide the YouTube video URL if it has not been supplied.

Do not download an entire playlist. The YouTube transcription command processes one video at a time.

### Step B2: Transcribe the YouTube video

Basic transcription:

```bash
asr-youtube "https://www.youtube.com/watch?v=VIDEO_ID"
```

The command automatically:

1. Validates the YouTube URL.
2. Uses `yt-dlp` to download the video's audio.
3. Uses ffmpeg to convert the audio to MP3.
4. Calls the existing `asr` command.
5. Generates a TXT transcript.
6. Cleans up temporary audio files.

The default transcript is saved in the current working directory.

### Step B3: Specify the output file

To specify the transcript path:

```bash
asr-youtube "https://www.youtube.com/watch?v=VIDEO_ID" --out "./transcript.txt"
```

### Step B4: Enable timestamps

To include timestamps:

```bash
asr-youtube "https://www.youtube.com/watch?v=VIDEO_ID" --timestamps
```

### Step B5: Disable speaker separation

To disable speaker separation:

```bash
asr-youtube "https://www.youtube.com/watch?v=VIDEO_ID" --no-speakers
```

### Step B6: Keep the downloaded audio

By default, temporary downloaded audio is removed after transcription.

To keep a copy of the downloaded MP3 next to the transcript:

```bash
asr-youtube "https://www.youtube.com/watch?v=VIDEO_ID" --keep-audio
```

Options can be combined:

```bash
asr-youtube "https://www.youtube.com/watch?v=VIDEO_ID" \
  --timestamps \
  --keep-audio \
  --out "./youtube-transcript.txt"
```

### Step B7: Verify the output

After execution:

1. Check the command exit status.
2. Confirm that the transcript file exists.
3. Check that the transcript is not empty.
4. Report the transcript path.
5. If the user requested `--keep-audio`, confirm that the audio file exists.
6. If transcription fails, explain the actual error.

Do not claim successful transcription unless the output has been verified.

## Common Command Options

| Option | Local ASR | YouTube ASR | Description |
|---|---|---|---|
| `--out` | Yes | Yes | Specify output TXT path |
| `--timestamps` | Yes | Yes | Include timestamps |
| `--no-speakers` | Yes | Yes | Disable speaker separation |
| `--keep-audio` | No | Yes | Keep downloaded YouTube audio |

## Safety Rules

- Never overwrite original audio or video files.
- Do not upload user files to unrelated services.
- Do not expose API keys in logs or output.
- Ask for permission before executing commands that access user files or download online media.
- Keep generated transcripts separate from original media.
- Do not invent missing dialogue or transcription content.
- Do not download entire playlists unless the user explicitly requests a playlist workflow.
- Do not bypass access restrictions on private or restricted videos.

## Example User Requests

### Local files

- Convert this MP4 video into Chinese text.
- Extract dialogue from this MOV file.
- Transcribe this meeting recording.
- Identify different speakers in this audio.
- Generate a timestamped transcript.
- Save the transcription result as a TXT file.

### YouTube videos

- Transcribe this YouTube video: [URL]
- Convert this YouTube video into Chinese text.
- Extract all spoken dialogue from this YouTube video.
- Transcribe this YouTube video with timestamps.
- Transcribe this YouTube video and keep the downloaded audio.

## Troubleshooting

### API key error

Check whether `DASHSCOPE_API_KEY` is configured and whether the key is valid.

### ffmpeg or ffprobe not found

Install ffmpeg and ensure both commands are available in PATH.

### asr command not found

Install the Python package:

```bash
python3 -m pip install audio-transcribe-cli-mcp
```

### asr-youtube command not found

Run the project installer again:

```bash
bash install.sh
```

Then check:

```bash
asr-youtube --help
```

### yt-dlp not found

Install yt-dlp:

```bash
brew install yt-dlp
```

Then verify:

```bash
yt-dlp --version
```

### YouTube download failure

Check:

- Whether the URL is valid.
- Whether the video is publicly accessible.
- Whether yt-dlp is up to date.
- Whether the network can access YouTube.
- Whether ffmpeg is installed.

### Recognition failure

Check network access, API key validity, Alibaba Cloud Bailian service availability, and account quota.

### File not found

Check the file path, filename, and permissions.
