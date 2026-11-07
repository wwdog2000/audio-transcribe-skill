
---
name: audio-transcribe-cli-mcp
description: Transcribe local audio and video files or publicly accessible YouTube videos into text using Alibaba Cloud Bailian ASR. Use when the user asks to transcribe audio, video, YouTube links, extract dialogue, identify speakers, or obtain timestamps.
---

# Audio and Video Transcription Skill

## 1. Purpose

This skill supports two transcription workflows:

1. Local audio and video transcription using the existing `asr` command.
2. YouTube video transcription using the `asr-youtube` command.

Both workflows use Alibaba Cloud Bailian ASR for speech recognition.

Always choose the correct workflow based on the user's input.

## 2. Requirements

Common requirements:

- macOS or Linux
- Python 3.10 or newer
- ffmpeg and ffprobe installed and available in PATH
- audio-transcribe-cli-mcp installed
- `asr` command available
- `DASHSCOPE_API_KEY` configured in the environment

Additional requirements for YouTube transcription:

- `yt-dlp` installed and available in PATH
- `asr-youtube` command installed and available in PATH
- Internet access

## 3. Identify the Input Type

Before transcription, identify the input.

### Local audio or video files

Supported examples:

- MP4, MOV, MKV
- MP3, WAV, M4A
- AAC, FLAC, OGG, OPUS
- Other formats supported by ffmpeg

Use the `asr` command for local files.

### YouTube URLs

Recognize common YouTube URL formats:

- https://www.youtube.com/watch?v=VIDEO_ID
- https://youtu.be/VIDEO_ID
- https://www.youtube.com/shorts/VIDEO_ID
- https://m.youtube.com/watch?v=VIDEO_ID

Use the `asr-youtube` command for YouTube URLs.

The first version supports individual publicly accessible videos.

It does not promise support for:

- Playlists
- Private videos
- Login-restricted videos
- Age-restricted or otherwise inaccessible videos

Never attempt to bypass access controls.

If the input is neither a local file nor a supported YouTube URL, ask the user to provide a valid input.

## 4. Check the Environment

Before running transcription, check the required commands.

For local files:

```bash
python3 --version
ffmpeg -version
ffprobe -version
asr --help
```

For YouTube URLs, additionally check:

```bash
yt-dlp --version
asr-youtube --help
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

If a required command is missing, explain which dependency is missing and provide the appropriate installation instructions.

Do not claim that a command is installed unless its availability has been verified.

## 5. Workflow A: Local File Transcription

### Step 1: Identify the input file

Obtain the exact local file path from the user.

If the user has not specified a file, ask for its location.

Never guess a file path.

### Step 2: Transcribe the file

Use:

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

To preserve intermediate files for troubleshooting:

```bash
asr "/absolute/path/to/input.mp4" --keep-workdir --out "/absolute/path/to/result.txt"
```

### Step 3: Verify the output

After execution:

1. Check the command exit status.
2. Confirm that the output file exists.
3. Check that the output file is not empty.
4. Report the output file path to the user.
5. If transcription fails, explain the actual error.

Do not claim successful transcription unless the output has been verified.

## 6. Workflow B: YouTube Transcription

### Step 1: Identify the YouTube URL

Obtain the YouTube URL from the user.

If the user asks to transcribe a YouTube video and provides a URL, use the YouTube workflow.

Do not pass a YouTube URL directly to the `asr` command.

### Step 2: Check the YouTube environment

Run:

```bash
yt-dlp --version
asr-youtube --help
```

Also verify the common requirements and API key configuration in Section 4.

If `asr-youtube` is unavailable, explain that the YouTube transcription component has not been installed correctly.

### Step 3: Download and transcribe

Use the following command:

```bash
asr-youtube "https://www.youtube.com/watch?v=VIDEO_ID"
```

The command automatically:

1. Downloads the video's audio using yt-dlp.
2. Extracts audio into MP3 format using ffmpeg.
3. Sends the audio to Alibaba Cloud Bailian ASR.
4. Saves the transcription result as a TXT file.
5. Removes temporary audio files after successful execution.

The default behavior enables speaker diarization.

### Step 4: Optional parameters

Specify the output file:

```bash
asr-youtube "URL" --out "/absolute/path/to/transcript.txt"
```

Include sentence-level timestamps:

```bash
asr-youtube "URL" --timestamps
```

Disable speaker diarization:

```bash
asr-youtube "URL" --no-speakers
```

Keep the downloaded MP3 file:

```bash
asr-youtube "URL" --keep-audio
```

Combine options when needed:

```bash
asr-youtube "URL" --timestamps --keep-audio --out transcript.txt
```

### Step 5: Verify the output

After execution:

1. Check the command exit status.
2. Confirm that the transcript file exists.
3. Check that the transcript file is not empty.
4. Report the output path to the user.
5. If requested, report the location of the retained MP3 file.
6. If transcription fails, explain the actual error.

Do not claim successful transcription unless the output has been verified.

## 7. Safety and Usage Rules

- Never overwrite the original audio or video file.
- Do not expose API keys in logs or output.
- Ask for permission before accessing local user files.
- Do not upload user files to unrelated services.
- Keep generated transcripts separate from original media.
- Do not invent missing dialogue or transcription content.
- Only download YouTube content when the user has the necessary rights or authorization and the use complies with applicable laws and platform terms.
- Never bypass private-video restrictions, DRM, login requirements, or other access controls.
- Do not download playlists unless a future version explicitly supports them.

## 8. Example User Requests

Local file transcription:

- Convert this MP4 video into Chinese text.
- Extract dialogue from this MOV file.
- Transcribe this meeting recording.
- Identify different speakers in this audio.
- Generate a timestamped transcript.

YouTube transcription:

- Transcribe this YouTube video.
- Convert this YouTube link into Chinese text.
- Extract the dialogue from this YouTube video.
- Transcribe this video and identify different speakers.
- Save the YouTube transcript with timestamps.
- Download the audio and save both MP3 and TXT files.

## 9. Troubleshooting

### API key error

Check whether `DASHSCOPE_API_KEY` is configured correctly.

Never ask the user to paste their API key into the conversation.

### ffmpeg not found

Install ffmpeg and ensure it is available in PATH.

macOS:

```bash
brew install ffmpeg
```

### asr command not found

Install the original ASR package:

```bash
python3 -m pip install --upgrade audio-transcribe-cli-mcp
```

### yt-dlp not found

macOS:

```bash
brew install yt-dlp
```

Other systems:

```bash
python3 -m pip install --user --upgrade yt-dlp
```

### asr-youtube command not found

Run the project installer again:

```bash
bash install.sh
```

Then reload the shell configuration:

```bash
source ~/.zshrc
```

Verify:

```bash
asr-youtube --help
```

### YouTube download failure

Possible causes:

- Invalid or inaccessible video URL
- Network connection problems
- YouTube changes affecting yt-dlp
- Video access restrictions
- Unsupported video format

Check the actual yt-dlp error before recommending a solution.

### Recognition failure

Check network access, API key validity, Bailian service availability, and account quota.

### File not found

Check the file path, filename, and permissions.
