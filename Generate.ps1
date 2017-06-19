$ErrorActionPreference = "Stop"

# All the input files should be in this directory.
$inputPath = "D:\tmp\tv"
$outputPath = "D:\tmp\out"

$makemedia = Join-Path $PSScriptRoot "Makemedia.exe"

# v8-MultiPeriod-MultiContent: different aspect ratios and languages in different periods.
# Video inputs are:
# 1) (12min) Tear of Steel 3840x1714 9:4 24 fps, 3 audio, 5 text
# 2)
# 3) (10min cut) Fires Beneath Water 320x168 40:21 29.97 fps, 2 audio, 0 text, by-nc-sa/3.0
# 4)
# 5) (2min) Caminades - Llamigos 1920x1080 16:9 24 fps, 1 audio, 0 text
#
# We use some royalty free music from bensound.com to generate additional audio tracks to fill out silent clips.
# We add this music track to every period with its own language code, to enable one to check whether a player can keep
# following the same language across many periods with different contents.
#
# We preserve aspect ratio but use the GPMF quality levels, adjusting width to match aspect ratio.

# Period 1
$tosRoot = Join-Path $inputPath "tos"

& $makemedia --language en --input (Join-Path $tosRoot "video.mp4") --input (Join-Path $tosRoot "audio.mp4") `
    --language en-x-high --input (Join-Path $tosRoot "audio_high.wav") `
    --language en-x-low --input (Join-Path $tosRoot "audio_low.wav") `
    --language x-popmusic --input (Join-Path $inputPath "bensound-popdance-loop.mp3") `
    --language zh-cmn --input (Join-Path $tosRoot "TOS-zh.srt") `
    --language ru --input (Join-Path $tosRoot "TOS-ru.srt") `
    --language en --input (Join-Path $tosRoot "TOS-en.srt") `
    --language es --input (Join-Path $tosRoot "TOS-es.srt") `
    --language nl-NL --input (Join-Path $tosRoot "TOS-nl.srt") `
    --cpix (Join-Path $inputPath "Axinom-v8-MultiContent-Period1.xml") `
    --aspectratio "9:4" `
    --debug-overlay `
    --h264 `
    --h265 `
    --output (Join-Path $outputPath "Period1") `
    --verbose

# Period 3
$firesRoot = Join-Path $inputPath "FiresBeneathWater"

& $makemedia --language en --input (Join-Path $firesRoot "video_en_10min.mp4") `
    --input (Join-Path $firesRoot "audio_en.mp4") `
    --language es --input (Join-Path $firesRoot "audio_es.mp4") `
    --language x-popmusic --input (Join-Path $inputPath "bensound-popdance-loop.mp3") `
    --cpix (Join-Path $inputPath "Axinom-v8-MultiContent-Period3.xml") `
    --aspectratio "40:21" `
    --debug-overlay `
    --h264 `
    --h265 `
    --output (Join-Path $outputPath "Period3") `
    --verbose

# Period 5
& $makemedia --input (Join-Path $inputPath "Caminandes-Llamigos-1080p.mp4") `
    --language x-popmusic --input (Join-Path $inputPath "bensound-popdance-loop.mp3") `
    --cpix (Join-Path $inputPath "Axinom-v8-MultiContent-Period5.xml") `
    --aspectratio "16:9" `
    --debug-overlay `
    --h264 `
    --h265 `
    --output (Join-Path $outputPath "Period5") `
    --verbose