rm -vf segment2.text.mp4
rm -vf segment2.text.images.mp4
rm -vf segment2_text_*.txt
rm -vf segment2_*.mp3

FONT="fontcolor=white:fontsize=24:box=1:boxcolor=black@0.5"
BOTTOM="x=(w-text_w)/2:y=h-th-10"
TEXT1="Create a new annotation layer."
TEXT2="Create a new volume."
TEXT3="Draw the 1st polygon on section 44 on the cerebellum."
TEXT4="Use the z drop down menu to go to section 54."
TEXT5="Draw the 2nd polygon on section 54."

counter=1
for i in "$TEXT1" "$TEXT2" "$TEXT3" "$TEXT4" "$TEXT5";
do
 filename="segment2_text_$counter.txt"
 echo "$i" > "$filename"
 mp3file=$(echo "$filename" | sed 's/txt/mp3/g')
 piper.sh $filename --name $mp3file
 ((counter++))
done

ffmpeg -i videos/segment2.mp4 -an -vf \
"
drawtext=text='$TEXT1':$FONT:$BOTTOM:enable='between(t,0,8)', \
drawtext=text='$TEXT2':$FONT:$BOTTOM:enable='between(t,10,15)', \
drawtext=text='$TEXT3':$FONT:$BOTTOM:enable='between(t,18,33)', \
drawtext=text='$TEXT4':$FONT:$BOTTOM:enable='between(t,36,43)', \
drawtext=text='$TEXT5':$FONT:$BOTTOM:enable='between(t,45,58)', \
" \
segment2.text.mp4

echo ""

echo "Adding images"

ffmpeg -i segment2.text.mp4 -an -i left-arrow.png -i left-arrow.png -i left-arrow.png  -i left-arrow.png \
-filter_complex \
"[0][1]overlay=x=363:y=165:enable='between(t,3,7)'[v1]; \
[v1][2]overlay=x=1735:y=186:enable='between(t,9,11)'[v2]; \
[v2][3]overlay=x=1735:y=212:enable='between(t,12,16)'[v3]; \
[v3][4]overlay=x=452:y=142:enable='between(t,36,44)'[v4]" \
-map "[v4]" segment2.text.images.mp4

	
 

