
##### Speed up segment 3
ffmpeg -i videos/segment3_full.mp4 -filter:v "setpts=PTS/15" -an videos/segment3.mp4
##### Speed up segment 5
ffmpeg -i videos/segment5_full.mp4 -filter:v "setpts=PTS/15" -an videos/segment5.mp4
