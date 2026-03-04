
##### speed up 1:22 to 11:24
##### speed up 11:48 to 20:01

##### Extract 1st normal speed to segment 1
ffmpeg -ss 00:00:00 -i videos/DK55.demo.full.notext.nospeed.mp4 -t 00:01:22 segment1.mp4

##### Extract and speed up segment 2
ffmpeg -i videos/DK55.demo.full.notext.nospeed.mp4 -ss 00:01:22 -to 00:11:24 -an tmp2.mp4
ffmpeg -i tmp2.mp4 -filter:v "setpts=PTS/15" -an segment2.mp4
rm -vf tmp2.mp4

##### Extract 2nd normal speed to segment 3
ffmpeg -i videos/DK55.demo.full.notext.nospeed.mp4 -ss 00:11:24 -to 00:11:48 segment3.mp4

##### Extract and speed up segment 4
ffmpeg -i videos/DK55.demo.full.notext.nospeed.mp4 -ss 00:11:48 -to 00:20:01 -an tmp4.mp4
ffmpeg -i tmp4.mp4 -filter:v "setpts=PTS/15" segment4.mp4
rm -vf tmp4.mp4

##### Extract last segment
ffmpeg -i videos/DK55.demo.full.notext.nospeed.mp4 -ss 00:20:01 segment5.mp4

##### Concatenate
ffmpeg -f concat -safe 0 -i concat.files.txt -c copy videos/DK55.demo.speed.mp4
