rm -vf segment1.text.mp4
rm -vf segment1.text.images.mp4
rm -vf text_*.txt
rm -vf *.mp3

FONT="fontcolor=yellow:fontsize=24:box=1:boxcolor=black@0.5"
BOTTOM="x=(w-text_w)/2:y=h-th-10"
TEXT1="Viewing mouse brain DK55 in sagittal, coronal, horizontal and 3D"
TEXT2="Moving the horizontal view in sagittal view"
TEXT3="Moving the horizontal view to section 44 using the dropdown z menu"
TEXT4="Expanding the sagittal quadrant"
TEXT5="Zooming in"
TEXT6="Setting the field of view to 20 microns"

counter=1
for i in "$TEXT1" "$TEXT2" "$TEXT3" "$TEXT4" "$TEXT5" "$TEXT6";
do
 filename="text_$counter.txt"
 echo "$i" > "$filename"
 mp3file=$(echo "$filename" | sed 's/txt/mp3/g')
 piper.sh $filename --name $mp3file
 ((counter++))
done



ffmpeg -i media/video/segment1.mp4 -an -vf \
"
drawtext=text='$TEXT1':$FONT:$BOTTOM:enable='between(t,0,3)', \
drawtext=text='$TEXT2':$FONT:$BOTTOM:enable='between(t,4,15)', \
drawtext=text='$TEXT3':$FONT:$BOTTOM:enable='between(t,17,22)', \
drawtext=text='$TEXT4':$FONT:$BOTTOM:enable='between(t,23,26)', \
drawtext=text='$TEXT5':$FONT:$BOTTOM:enable='between(t,27,30)', \
drawtext=text='$TEXT6':$FONT:$BOTTOM:enable='between(t,31,40)', \
" \
segment1.text.mp4

echo ""

echo "Adding images"

ffmpeg -i segment1.text.mp4 -an -i down-arrow.png -i down-arrow.png -i down-arrow.png  -i down-arrow.png -i down-arrow.png -i down-arrow.png \
-i left-arrow.png -i left-arrow.png -i left-arrow.png \
-filter_complex \
"[0][1]overlay=x=796:y=600:enable='between(t,4,5)'[v1]; \
[v1][2]overlay=x=796:y=640:enable='between(t,6,7)'[v2]; \
[v2][3]overlay=x=796:y=680:enable='between(t,8,9)'[v3]; \
[v3][4]overlay=x=796:y=720:enable='between(t,10,11)'[v4]; \
[v4][5]overlay=x=796:y=760:enable='between(t,12,13)'[v5]; \
[v5][6]overlay=x=796:y=800:enable='between(t,14,15)'[v6]; \
[v6][7]overlay=x=425:y=142:enable='between(t,17,22)'[v7]; \
[v7][8]overlay=x=866:y=191:enable='between(t,23,26)'[v8]; \
[v8][9]overlay=x=348:y=218:enable='between(t,31,40)'[v9]" \
-map "[v9]" segment1.text.images.mp4

	
 

