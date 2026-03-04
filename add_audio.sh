

ffmpeg -y -an -i segment1.text.images.mp4 \
-itsoffset 1s -i text_1.mp3 \
-itsoffset 11s -i text_2.mp3 \
-itsoffset 27s -i text_3.mp3 \
-filter_complex "[0:a][1:a][2:a]amix=inputs=3[a]" -map 0:v -map [a] -c:v copy -c:a aac output.mp4

