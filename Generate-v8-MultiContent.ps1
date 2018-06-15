$ErrorActionPreference = "Stop"

# All the input files should be in this directory.
$inputRoot = "D:\tmp\tv"
$outputRoot = "D:\tmp\out"

$makemedia = Join-Path $PSScriptRoot "Makemedia.exe"
$glue = Join-Path $PSScriptRoot "Glue.exe"

$optimize = "Balance"
$standardParameters = @("--h264", "--h265", "--optimize", $optimize, "--debug-overlay")

# v8-MultiContent: different aspect ratios and languages in different periods.
# Video inputs are:
# 01) (12min) Tears of Steel 3840x1714 9:4 24 fps, 3 audio, 5 text
# 02) (30sec, 25fps reduced, 4:3 crop) park_joy + ducks_take_off + crowd_run 3840x2160 16:9 25 fps, 0 audio, 0 text
# 03) (10min cut) Fires Beneath Water 320x168 40:21 29.97 fps, 2 audio, 0 text, by-nc-sa/3.0
# 04) (10 sec) life 1920x1080 16:9 30 fps, 0 audio, 0 text
# 05) (2min) Caminades - Llamigos 1920x1080 16:9 24 fps, 1 audio, 0 text
# 06) (19sec) west_wind_easy 1920x1080 16:9 29.97 fps, 0 audio, 0 text
# 07) (10sec, 25fps reduced, 1:1 crop) in_to_tree 3840x2160 16:9 50 fps, 0 audio, 0 text
# 08) (10sec, 25fps reduced) mobcal_ter 1280x720 16:9 50 fps, 0 audio, 0 text
# 09) (10sec, 25fps reduced, 16:10 crop) parkrun_ter 1280x720 16:9 50 fps, 0 audio, 0 text
# 10) (10sec, 25fps reduced) shields_ter 1280x720 16:9 50 fps, 0 audio, 0 text
#
# We use some royalty free music from bensound.com to generate additional audio tracks to fill out silent clips.
# We add one music track to every period with its own language code, to enable one to check whether a player can keep
# following the same language across many periods with different contents.
#
# We add some random subtitles to various periods just to have some text present and observe player selection behavior.
#
# We preserve aspect ratio but use the GPMF quality levels, adjusting width to match aspect ratio.

# Language code zxx - no linguistic content

# Period 1
$tosRoot = Join-Path $inputRoot "tos"

& $makemedia --language en --input (Join-Path $tosRoot "video.mp4") --input (Join-Path $tosRoot "audio.mp4") `
    --language en-x-high --input (Join-Path $tosRoot "audio_high.wav") `
    --language en-x-low --input (Join-Path $tosRoot "audio_low.wav") `
    --language x-popmusic --input (Join-Path $inputRoot "bensound-popdance-loop.mp3") `
    --language zh-cmn --input (Join-Path $tosRoot "TOS-zh.srt") `
    --language ru --input (Join-Path $tosRoot "TOS-ru.srt") `
    --language en --input (Join-Path $tosRoot "TOS-en.srt") `
    --language es --input (Join-Path $tosRoot "TOS-es.srt") `
    --language nl-NL --input (Join-Path $tosRoot "TOS-nl.srt") `
    --language x-complex --input (Join-Path $inputRoot "Complex.srt") `
    --cpix (Join-Path $inputRoot "Axinom-v8-MultiContent-Period01.xml") `
    --aspectratio "9:4" `
    $standardParameters `
    --output (Join-Path $outputRoot "Period01")

# Period 2
& $makemedia --language en --input (Join-Path $inputRoot "Period02_video.mp4") `
    --language x-moose --input (Join-Path $inputRoot "bensound-moose-loop.mp3") `
    --language x-dubstep --input (Join-Path $inputRoot "bensound-dubstep-loop.mp3") `
    --language x-scifi --input (Join-Path $inputRoot "bensound-scifi-loop.mp3") `
    --language x-popmusic --input (Join-Path $inputRoot "bensound-popdance-loop.mp3") `
    --cpix (Join-Path $inputRoot "Axinom-v8-MultiContent-Period02.xml") `
    --aspectratio "4:3" `
    $standardParameters `
    --output (Join-Path $outputRoot "Period02")

# Period 3
$firesRoot = Join-Path $inputRoot "FiresBeneathWater"

& $makemedia --language en --input (Join-Path $firesRoot "video_en_10min.mp4") `
    --input (Join-Path $firesRoot "audio_en.mp4") `
    --language es --input (Join-Path $firesRoot "audio_es.mp4") `
    --language x-popmusic --input (Join-Path $inputRoot "bensound-popdance-loop.mp3") `
    --cpix (Join-Path $inputRoot "Axinom-v8-MultiContent-Period03.xml") `
    --aspectratio "40:21" `
    $standardParameters `
    --output (Join-Path $outputRoot "Period03")

# Period 4
& $makemedia --language en --input (Join-Path $inputRoot "life.mp4") `
    --language x-dance --input (Join-Path $inputRoot "bensound-dance-loop.mp3") `
    --language x-popmusic --input (Join-Path $inputRoot "bensound-popdance-loop.mp3") `
    --language nl-NL --input (Join-Path $tosRoot "TOS-nl.srt") `
    --cpix (Join-Path $inputRoot "Axinom-v8-MultiContent-Period04.xml") `
    --aspectratio "16:9" `
    $standardParameters `
    --output (Join-Path $outputRoot "Period04")

# Period 5
$caminadesRoot = Join-Path $inputRoot "CaminadesLlamigos"

& $makemedia --language en --input (Join-Path $caminadesRoot "video.mp4") `
    --language zxx --input (Join-Path $caminadesRoot "audio.mp4") `
    --language x-popmusic --input (Join-Path $inputRoot "bensound-popdance-loop.mp3") `
    --cpix (Join-Path $inputRoot "Axinom-v8-MultiContent-Period05.xml") `
    --aspectratio "16:9" `
    $standardParameters `
    --output (Join-Path $outputRoot "Period05")

# Period 6
& $makemedia --language en --input (Join-Path $inputRoot "west_wind_easy_1080p.y4m") `
    --language x-soul --input (Join-Path $inputRoot "bensound-retrosoul-loop.mp3") `
    --language x-popmusic --input (Join-Path $inputRoot "bensound-popdance-loop.mp3") `
    --language nl-NL --input (Join-Path $tosRoot "TOS-nl.srt") `
    --language zh-cmn --input (Join-Path $tosRoot "TOS-zh.srt") `
    --cpix (Join-Path $inputRoot "Axinom-v8-MultiContent-Period06.xml") `
    --aspectratio "16:9" `
    $standardParameters `
    --output (Join-Path $outputRoot "Period06")

# Period 7
& $makemedia --language en --input (Join-Path $inputRoot "in_to_tree_25.mp4") `
    --language x-badass --input (Join-Path $inputRoot "bensound-badass-loop.mp3") `
    --language x-popmusic --input (Join-Path $inputRoot "bensound-popdance-loop.mp3") `
    --cpix (Join-Path $inputRoot "Axinom-v8-MultiContent-Period07.xml") `
    --aspectratio "1:1" `
    $standardParameters `
    --output (Join-Path $outputRoot "Period07")

# Period 8
& $makemedia --language en --input (Join-Path $inputRoot "mobcal_ter_25.mp4") `
    --language x-funny --input (Join-Path $inputRoot "bensound-funnysong-loop.mp3") `
    --language x-badass --input (Join-Path $inputRoot "bensound-badass-loop.mp3") `
    --language x-popmusic --input (Join-Path $inputRoot "bensound-popdance-loop.mp3") `
    --language zh-cmn --input (Join-Path $tosRoot "TOS-zh.srt") `
    --cpix (Join-Path $inputRoot "Axinom-v8-MultiContent-Period08.xml") `
    --aspectratio "16:9" `
    $standardParameters `
    --output (Join-Path $outputRoot "Period08")

# Period 9
& $makemedia --language en --input (Join-Path $inputRoot "parkrun_ter_25.mp4") `
    --language x-groovy --input (Join-Path $inputRoot "bensound-groovyhiphop-loop.mp3") `
    --language x-badass --input (Join-Path $inputRoot "bensound-badass-loop.mp3") `
    --language x-popmusic --input (Join-Path $inputRoot "bensound-popdance-loop.mp3") `
    --language nl-NL --input (Join-Path $tosRoot "TOS-nl.srt") `
    --language zh-cmn --input (Join-Path $tosRoot "TOS-zh.srt") `
    --cpix (Join-Path $inputRoot "Axinom-v8-MultiContent-Period09.xml") `
    --aspectratio "16:10" `
    $standardParameters `
    --output (Join-Path $outputRoot "Period09")

# Period 10
& $makemedia --language en --input (Join-Path $inputRoot "shields_ter_25.mp4") `
    --language x-sexy --input (Join-Path $inputRoot "bensound-sexy-loop.mp3") `
    --language x-badass --input (Join-Path $inputRoot "bensound-badass-loop.mp3") `
    --language x-popmusic --input (Join-Path $inputRoot "bensound-popdance-loop.mp3") `
    --language zh-cmn --input (Join-Path $tosRoot "TOS-zh.srt") `
    --language nl-NL --input (Join-Path $tosRoot "TOS-nl.srt") `
    --cpix (Join-Path $inputRoot "Axinom-v8-MultiContent-Period10.xml") `
    --aspectratio "16:9" `
    $standardParameters `
    --output (Join-Path $outputRoot "Period10")

# Merge them all!

& $glue --input (Join-Path $outputRoot "Period01/Clear") `
    --input (Join-Path $outputRoot "Period02/Clear") `
    --input (Join-Path $outputRoot "Period03/Clear") `
    --input (Join-Path $outputRoot "Period04/Clear") `
    --input (Join-Path $outputRoot "Period05/Clear") `
    --input (Join-Path $outputRoot "Period06/Clear") `
    --input (Join-Path $outputRoot "Period07/Clear") `
    --input (Join-Path $outputRoot "Period08/Clear") `
    --input (Join-Path $outputRoot "Period09/Clear") `
    --input (Join-Path $outputRoot "Period10/Clear") `
    --output (Join-Path $outputRoot "Final/Clear")

& $glue --input (Join-Path $outputRoot "Period01/Encrypted") `
    --input (Join-Path $outputRoot "Period02/Encrypted") `
    --input (Join-Path $outputRoot "Period03/Encrypted") `
    --input (Join-Path $outputRoot "Period04/Encrypted") `
    --input (Join-Path $outputRoot "Period05/Encrypted") `
    --input (Join-Path $outputRoot "Period06/Encrypted") `
    --input (Join-Path $outputRoot "Period07/Encrypted") `
    --input (Join-Path $outputRoot "Period08/Encrypted") `
    --input (Join-Path $outputRoot "Period09/Encrypted") `
    --input (Join-Path $outputRoot "Period10/Encrypted") `
    --output (Join-Path $outputRoot "Final/Encrypted")