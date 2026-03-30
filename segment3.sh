rm -vf segment3.text.mp4
rm -vf segment3.text.images.mp4
rm -vf segment3_text_*.txt
rm -vf segment3_*.mp3

FONT="fontcolor=white:fontsize=24:box=1:boxcolor=black@0.5"
BOTTOM="x=(w-text_w)/2:y=h-th-10"
TEXT1="Continue to draw annotations on the cerebellum every 10 sections till we get to the middle of the brain."

counter=1
for i in "$TEXT1";
do
 filename="segment3_text_$counter.txt"
 echo "$i" > "$filename"
 mp3file=$(echo "$filename" | sed 's/txt/mp3/g')
 piper.sh $filename --name $mp3file
 ((counter++))
done

ffmpeg -i media/videos/segment3.mp4 -an -vf \
"
drawtext=text='$TEXT1':$FONT:$BOTTOM:enable='between(t,0,200)', \
" \
media/videos/segment3.text.images.mp4
