#ffmpeg -y -an -i segment1.text.images.mp4 \
#-itsoffset 1 -i text_1.mp3 \
#-itsoffset 4 -i text_2.mp3 \
#-itsoffset 17 -i text_3.mp3 \
#-itsoffset 23 -i text_4.mp3 \
#-itsoffset 27 -i text_5.mp3 \
#-itsoffset 31 -i text_6.mp3 \
ffmpeg -y -i segment1.text.images.mp4 \
-itsoffset 1 -i text_1.mp3 \
-itsoffset 15 -i text_2.mp3 \
-filter_complex amix -map 0:v -map 1:a -map 2:a \
-c:v copy -async 1 -c:a aac -strict experimental output.mp4


exit
ffmpeg -y -i segment1.text.images.mp4 \ 
-itsoffset 1 -i text_1.mp3 \
-itsoffset 15 -i text_2.mp3 \
-filter_complex amix -map 0:v -map 1:a -map 2:a \
-c:v copy -async 1 -c:a aac -strict experimental output.mp4


#ffmpeg -y -i video.mp4 -itsoffset 10 -i audio1.mp3 -itsoffset 15 -i audio2.mp3 -filter_complex "[0:a][1:a][2:a]amix=inputs=3[a]" -map 0:v -map "[a]" -c:v copy -async 1 output.mp4
