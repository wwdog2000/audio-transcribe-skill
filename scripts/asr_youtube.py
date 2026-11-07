#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
YouTube Audio Transcription
Download YouTube audio with yt-dlp,
then transcribe it using the existing Alibaba Cloud ASR CLI.
"""

import argparse
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path
from urllib.parse import urlparse


APP_NAME = "asr-youtube"

YOUTUBE_HOSTS = {
    "youtube.com",
    "www.youtube.com",
    "m.youtube.com",
    "music.youtube.com",
    "youtu.be",
    "www.youtube-nocookie.com",
}


def check_youtube_url(url):
    """Check whether the URL belongs to YouTube."""

    try:
        parsed = urlparse(url.strip())
        host = (parsed.hostname or "").lower()

        if parsed.scheme not in ("http", "https"):
            return False

        return host in YOUTUBE_HOSTS

    except Exception:
        return False


def print_error(message):
    print(f"\n[ERROR] {message}", file=sys.stderr)


def download_audio(url, workdir):
    """Download and extract audio from a YouTube video."""

    ytdlp = shutil.which("yt-dlp")

    if not ytdlp:
        raise RuntimeError(
            "yt-dlp was not found.\n"
            "Please install it first:\n"
            "macOS: brew install yt-dlp\n"
            "Other systems: python3 -m pip install yt-dlp"
        )

    output_template = str(
        workdir / "%(title).180B [%(id)s].%(ext)s"
    )

    command = [
        ytdlp,
        "--no-playlist",
        "--extract-audio",
        "--audio-format",
        "mp3",
        "--audio-quality",
        "5",
        "--output",
        output_template,
        "--print",
        "after_move:filepath",
        url,
    ]

    print("\n[1/3] Downloading YouTube audio...")
    print("Please wait. The time required depends on the video length.")

    result = subprocess.run(
        command,
        capture_output=True,
        text=True,
        encoding="utf-8",
        errors="replace",
    )

    if result.returncode != 0:
        details = result.stderr.strip() or "Unknown yt-dlp error."
        raise RuntimeError(
            "YouTube audio download failed.\n\n" + details
        )

    # yt-dlp prints the final audio path after extraction.
    possible_paths = [
        Path(line.strip().strip('"'))
        for line in result.stdout.splitlines()
        if line.strip()
    ]

    audio_path = next(
        (
            path for path in reversed(possible_paths)
            if path.is_file()
        ),
        None,
    )

    # Fallback: find the generated MP3 file in the temporary directory.
    if audio_path is None:
        mp3_files = list(workdir.glob("*.mp3"))

        if mp3_files:
            audio_path = mp3_files[0]

    if audio_path is None or not audio_path.is_file():
        raise RuntimeError(
            "Download finished, but the MP3 audio file could not be found."
        )

    if audio_path.stat().st_size == 0:
        raise RuntimeError("The downloaded audio file is empty.")

    print(f"\nAudio downloaded: {audio_path.name}")

    return audio_path


def transcribe_audio(audio_path, output_path, timestamps=False,
                     no_speakers=False):
    """Run the existing ASR CLI."""

    asr_command = shutil.which("asr")

    if not asr_command:
        raise RuntimeError(
            "The existing 'asr' command was not found.\n"
            "Please check the audio-transcribe-cli-mcp installation.\n"
            "Test it with: asr --help"
        )

    command = [
        asr_command,
        str(audio_path),
        "--out",
        str(output_path),
    ]

    if timestamps:
        command.append("--timestamps")

    if no_speakers:
        command.append("--no-speakers")

    print("\n[2/3] Sending audio to Alibaba Cloud Bailian ASR...")
    print("Speaker diarization:",
          "disabled" if no_speakers else "enabled")
    print("Sentence timestamps:",
          "enabled" if timestamps else "disabled")

    result = subprocess.run(command, check=False)

    if result.returncode != 0:
        raise RuntimeError(
            f"ASR transcription failed (exit code {result.returncode})."
        )

    if not output_path.is_file():
        raise RuntimeError(
            "ASR finished, but the output text file was not found."
        )

    if output_path.stat().st_size == 0:
        raise RuntimeError(
            "ASR finished, but the output text file is empty."
        )

    print("\n[3/3] Transcription completed.")
    print(f"Transcript: {output_path}")


def build_parser():
    parser = argparse.ArgumentParser(
        prog=APP_NAME,
        description=(
            "Download YouTube audio and transcribe it "
            "using Alibaba Cloud Bailian ASR."
        ),
        formatter_class=argparse.RawTextHelpFormatter,
        epilog=(
            "Examples:\n"
            '  asr-youtube "https://www.youtube.com/watch?v=VIDEO_ID"\n'
            '  asr-youtube "URL" --out transcript.txt\n'
            '  asr-youtube "URL" --timestamps\n'
            '  asr-youtube "URL" --no-speakers\n'
            '  asr-youtube "URL" --keep-audio\n'
        ),
    )

    parser.add_argument(
        "url",
        help="YouTube video URL",
    )

    parser.add_argument(
        "--out",
        help="Output transcript file path",
        default=None,
    )

    parser.add_argument(
        "--timestamps",
        action="store_true",
        help="Include sentence-level timestamps",
    )

    parser.add_argument(
        "--no-speakers",
        action="store_true",
        help="Disable speaker diarization",
    )

    parser.add_argument(
        "--keep-audio",
        action="store_true",
        help="Keep the downloaded MP3 file next to the transcript",
    )

    return parser


def main():
    parser = build_parser()
    args = parser.parse_args()

    url = args.url.strip()

    if not check_youtube_url(url):
        print_error(
            "Invalid YouTube URL.\n"
            "Please provide a valid YouTube video link."
        )
        return 1

    if not shutil.which("ffmpeg"):
        print_error(
            "FFmpeg was not found. Please install FFmpeg first."
        )
        return 1

    if not shutil.which("ffprobe"):
        print_error(
            "ffprobe was not found. Please install FFmpeg first."
        )
        return 1

    if not shutil.which("asr"):
        print_error(
            "The existing ASR command was not found.\n"
            "Please run: asr --help"
        )
        return 1

    output_path = None

    try:
        with tempfile.TemporaryDirectory(
            prefix="asr-youtube-"
        ) as temp_dir:

            workdir = Path(temp_dir)

            # Step 1: Download audio.
            audio_path = download_audio(url, workdir)

            # Step 2: Determine transcript output path.
            if args.out:
                output_path = Path(args.out).expanduser().resolve()
            else:
                output_path = (
                    Path.cwd() / f"{audio_path.stem}.txt"
                )

            if not output_path.parent.exists():
                raise RuntimeError(
                    "Output directory does not exist:\n"
                    f"{output_path.parent}"
                )

            # Step 3: Transcribe using the existing ASR command.
            transcribe_audio(
                audio_path=audio_path,
                output_path=output_path,
                timestamps=args.timestamps,
                no_speakers=args.no_speakers,
            )

            # Optional: preserve downloaded audio.
            if args.keep_audio:
                saved_audio = (
                    output_path.parent / f"{audio_path.stem}.mp3"
                )

                shutil.copy2(audio_path, saved_audio)

                print(f"Audio file saved: {saved_audio}")

        print("\n======================================")
        print(" YouTube transcription successful!")
        print("======================================")
        print(f"Output: {output_path}")

        return 0

    except KeyboardInterrupt:
        print_error("Operation cancelled by user.")
        return 130

    except Exception as exc:
        print_error(str(exc))
        return 1


if __name__ == "__main__":
    sys.exit(main())
