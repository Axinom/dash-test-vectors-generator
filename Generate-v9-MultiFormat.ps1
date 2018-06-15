$ErrorActionPreference = "Stop"

# All the input files should be in this directory.
$inputRoot = "D:\tmp\tv"
$outputRoot = "D:\tmp\out"

$makemedia = Join-Path $PSScriptRoot "Makemedia.exe"

$optimize = "Balance"
$standardParameters = @("--h264", "--optimize", $optimize, "--debug-overlay", "--embed-clearkey")

# v9-MultiFormat - a Multi-DRM video available as both "cbcs" and "cenc" encryption modes, in both HLS and DASH format, with PlayReady, Widevine and FairPlay DRM (where compatible).
# HLS includes embedded clear keys. Axinom DRM Clear Key test server will also serve clear keys for DASH players on demand (but not embedded in manifest).
# No subtitles in this one because v9 workflow does not do HLS subtitles and we want to keep the two in sync. See you in v10!

$tosRoot = Join-Path $inputRoot "tos"

$keysPath = Join-Path $inputRoot "v9-MultiFormat.xml"

& $makemedia --language en --input (Join-Path $tosRoot "video.mp4") --input (Join-Path $tosRoot "audio.mp4") `
    --language en-x-high --input (Join-Path $tosRoot "audio_high.wav") `
    --language en-x-low --input (Join-Path $tosRoot "audio_low.wav") `
    --language x-popmusic --input (Join-Path $inputRoot "bensound-popdance-loop.mp3") `
    --cpix $keysPath `
    --aspectratio "9:4" `
    $standardParameters `
    --output (Join-Path $outputRoot "v9-MultiFormat")