# static variables
FONT="fontcolor=yellow:fontsize=32:box=1:boxcolor=black@0.5"
BOTTOM="x=(w-text_w)/2:y=h-th-10"
SAG24QUAD="x=1455:y=169"
IMAGE_DIR="media/image"
VIDEO_INPUT_DIR="media/video/input"
VIDEO_TMP_DIR="media/video/tmp"
VIDEO_OUTPUT_DIR="media/video/output"

##### Start segment 1
SEGMENT1_TEXT1="Viewing mouse brain DK55 in sagittal, coronal, horizontal and 3D"
SEGMENT1_TEXT2="Moving the horizontal view in sagittal view"
SEGMENT1_TEXT3="Moving the horizontal view to section 44 using the dropdown z menu"
SEGMENT1_TEXT4="Expanding the sagittal quadrant"
SEGMENT1_TEXT5="Zooming in"
SEGMENT1_TEXT6="Setting the field of view to 20 micrometers"

ffmpeg -y -i $VIDEO_INPUT_DIR/segment1.mp4 -an -vf \
"
drawtext=text='$SEGMENT1_TEXT1':$FONT:$BOTTOM:enable='between(t,0,3)', \
drawtext=text='$SEGMENT1_TEXT2':$FONT:$BOTTOM:enable='between(t,4,15)', \
drawtext=text='$SEGMENT1_TEXT3':$FONT:$BOTTOM:enable='between(t,17,22)', \
drawtext=text='$SEGMENT1_TEXT4':$FONT:$BOTTOM:enable='between(t,23,26)', \
drawtext=text='$SEGMENT1_TEXT5':$FONT:$BOTTOM:enable='between(t,27,30)', \
drawtext=text='$SEGMENT1_TEXT6':$FONT:$BOTTOM:enable='between(t,31,40)', \
" \
$VIDEO_TMP_DIR/segment1.text.mp4

ffmpeg -y -i $VIDEO_TMP_DIR/segment1.text.mp4 -an \
-i $IMAGE_DIR/down-arrow.png \
-i $IMAGE_DIR/down-arrow.png \
-i $IMAGE_DIR/down-arrow.png  \
-i $IMAGE_DIR/down-arrow.png \
-i $IMAGE_DIR/down-arrow.png \
-i $IMAGE_DIR/down-arrow.png \
-i $IMAGE_DIR/left-arrow.png \
-i $IMAGE_DIR/left-arrow.png \
-i $IMAGE_DIR/left-arrow.png \
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
-map "[v9]" $VIDEO_OUTPUT_DIR/segment1.mp4

##### Finished segment 1
##### Start segment 2
SEGMENT2_TEXT1="Create a new annotation layer."
SEGMENT2_TEXT2="Create a new volume."
SEGMENT2_TEXT3="Draw the 1st polygon on section 44 on the cerebellum."
SEGMENT2_TEXT4="Use the z drop down menu to go to section 54."
SEGMENT2_TEXT5="Draw the 2nd polygon on section 54."

ffmpeg -y -i "$VIDEO_INPUT_DIR/segment2.mp4" -an -vf \
"
drawtext=text='$SEGMENT2_TEXT1':$FONT:$BOTTOM:enable='between(t,0,8)', \
drawtext=text='$SEGMENT2_TEXT2':$FONT:$BOTTOM:enable='between(t,10,15)', \
drawtext=text='$SEGMENT2_TEXT3':$FONT:$BOTTOM:enable='between(t,18,33)', \
drawtext=text='$SEGMENT2_TEXT4':$FONT:$BOTTOM:enable='between(t,36,43)', \
drawtext=text='$SEGMENT2_TEXT5':$FONT:$BOTTOM:enable='between(t,45,58)', \
" \
"$VIDEO_TMP_DIR/segment2.text.mp4"

##### Adding images to segment 2
ffmpeg -y -i "$VIDEO_TMP_DIR/segment2.text.mp4" -an \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png"  \
-i "$IMAGE_DIR/left-arrow.png" \
-filter_complex \
"[0][1]overlay=x=363:y=165:enable='between(t,3,7)'[v1]; \
[v1][2]overlay=x=1735:y=186:enable='between(t,9,11)'[v2]; \
[v2][3]overlay=x=1735:y=212:enable='between(t,12,16)'[v3]; \
[v3][4]overlay=x=452:y=142:enable='between(t,36,44)'[v4]" \
-map "[v4]" "$VIDEO_OUTPUT_DIR/segment2.mp4"

##### Finished segment 2
##### Start segment 3
SEGMENT3_TEXT1="Continue to draw annotations on the cerebellum every 10 sections till we get to the middle of the brain."
ffmpeg -y -i "$VIDEO_INPUT_DIR/segment3.mp4" -an -vf \
"
drawtext=text='$SEGMENT3_TEXT1':$FONT:$BOTTOM:enable='between(t,0,200)', \
" \
$VIDEO_OUTPUT_DIR/segment3.mp4

##### Finished segment 3
##### Start segment 4
SEGMENT4_TEXT1="Save the current view."
SEGMENT4_TEXT2="Revert to the sagittal, coronal, horizontal and 3D view."
SEGMENT4_TEXT3="Switch to the 3D view and view the polygons within the 1st half of the brain."
SEGMENT4_TEXT4="Revert to the sagittal, coronal, horizontal and 3D view."
SEGMENT4_TEXT5="Focus on the sagittal view."
SEGMENT4_TEXT6="Continue drawing the annotations on the cerebellum."

ffmpeg -y -i "$VIDEO_INPUT_DIR/segment4.mp4" -an -vf \
"
drawtext=text='$SEGMENT4_TEXT1':$FONT:$BOTTOM:enable='between(t,0,6)', \
drawtext=text='$SEGMENT4_TEXT2':$FONT:$BOTTOM:enable='between(t,7,10)', \
drawtext=text='$SEGMENT4_TEXT3':$FONT:$BOTTOM:enable='between(t,11,13)', \
drawtext=text='$SEGMENT4_TEXT4':$FONT:$BOTTOM:enable='between(t,21,22)', \
drawtext=text='$SEGMENT4_TEXT5':$FONT:$BOTTOM:enable='between(t,23,24)', \
drawtext=text='$SEGMENT4_TEXT6':$FONT:$BOTTOM:enable='between(t,26,28)', \
" \
"$VIDEO_TMP_DIR/segment4.text.mp4"
##### Adding images to segment 4
ffmpeg -y -i "$VIDEO_TMP_DIR/segment4.text.mp4" -an \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png"  \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-filter_complex \
"[0][1]overlay=x=260:y=200:enable='between(t,0,6)'[v1]; \
[v1][2]overlay=x=1512:y=150:enable='between(t,7,10)'[v2]; \
[v2][3]overlay=x=1512:y=600:enable='between(t,11,13)'[v3]; \
[v3][4]overlay=x=1512:y=150:enable='between(t,21,22)'[v4]; \
[v4][5]overlay=x=888:y=180:enable='between(t,23,24)'[v5]" \
-map "[v5]" "$VIDEO_OUTPUT_DIR/segment4.mp4"

##### Finished segment 4
##### Start segment 5
SEGMENT5_TEXT1="Continue to draw annotations on the cerebellum every 10 sections until finished."
ffmpeg -y -i "$VIDEO_INPUT_DIR/segment5.mp4" -an -vf \
"
drawtext=text='$SEGMENT5_TEXT1':$FONT:$BOTTOM:enable='between(t,0,200)', \
" \
$VIDEO_OUTPUT_DIR/segment5.mp4

##### Finished segment 5
##### Start segment 6
SEGMENT6_TEXT1="Revert to the sagittal, coronal, horizontal and 3D view."
SEGMENT6_TEXT2="Switch to the 3D view and view the polygons within the whole brain."
SEGMENT6_TEXT3="Revert to the sagittal, coronal, horizontal and 3D view."
SEGMENT6_TEXT4="Focus on the sagittal view."
SEGMENT6_TEXT5="Continue drawing the annotations on the cerebellum."

ffmpeg -y -i "$VIDEO_INPUT_DIR/segment6.mp4" -an -vf \
"
drawtext=text='$SEGMENT6_TEXT1':$FONT:$BOTTOM:enable='between(t,0,6)', \
drawtext=text='$SEGMENT6_TEXT2':$FONT:$BOTTOM:enable='between(t,7,10)', \
drawtext=text='$SEGMENT6_TEXT3':$FONT:$BOTTOM:enable='between(t,11,13)', \
drawtext=text='$SEGMENT6_TEXT4':$FONT:$BOTTOM:enable='between(t,21,22)', \
drawtext=text='$SEGMENT6_TEXT5':$FONT:$BOTTOM:enable='between(t,23,24)', \
" \
"$VIDEO_TMP_DIR/segment6.text.mp4"
##### Adding images to segment 6
ffmpeg -y -i "$VIDEO_TMP_DIR/segment6.text.mp4" -an \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png"  \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-filter_complex \
"[0][1]overlay=$SAG24QUAD:enable='between(t,0,6)'[v1]; \
[v1][2]overlay=x=1512:y=150:enable='between(t,7,10)'[v2]; \
[v2][3]overlay=x=1512:y=600:enable='between(t,11,13)'[v3]; \
[v3][4]overlay=x=1512:y=150:enable='between(t,21,22)'[v4]; \
[v4][5]overlay=x=888:y=180:enable='between(t,23,24)'[v5]" \
-map "[v5]" "$VIDEO_OUTPUT_DIR/segment6.mp4"

##### Finished segment 6

##### Concatenate all segment outputs with transitions
mapfile -t SEGMENT_FILES < <(find "$VIDEO_OUTPUT_DIR" -maxdepth 1 -type f -name 'segment*.mp4' | sort -V)

CONCAT_LIST="files.txt"
rm -vf "$CONCAT_LIST"
touch $CONCAT_LIST
for file in "${SEGMENT_FILES[@]}"; do
    echo "file '$file'" >> "$CONCAT_LIST"
done

ffmpeg -y -f concat -safe 0 -i "$CONCAT_LIST" -c copy "$VIDEO_OUTPUT_DIR/DK55.annotation.demo.mp4"
