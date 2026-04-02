#!/bin/bash

# notes, make the text larger and down below near the bottom
# put an arrow on the working side
# ed has control, duane has control

# notes for paper,
# write up would include a market for data analyst. Target audience is data analysts, neuroscientists, and software developers. Song Mao.
# Write up an abstract, 
# what is the problem: the need to annotate sections for brain structures.
# on a common platform, users can share their screen and annotate together. with a web browser
# missing tools, ability to draw contours into volumes
# and co annotate with experts. people at different sections can annotate together.
# we have a web based tool that allows users to annotate together. machine independent, can be used on any computer with a web browser.
# we have brainsharer based on neuroglancer

# organize the results sections
# intro by david and beth

# 3rd section, can we make this work?

# 4th discussion and conclusion, future work, limitations, etc.


set -euo pipefail

FONT="fontcolor=yellow:fontsize=52:box=1:boxcolor=black@0.5"
BOTTOM="x=(w-text_w)/2:y=h-th-10"
#BL="x=(w-text_w)/4:y=h-th-10"
BL="x=100:y=h-th-10"

BR="x=(w-text_w):y=h-th-10"
SAG24QUAD="x=1550:y=150"
THREED24QUAD="x=1550:y=590"
LAYER_Y=132
IMAGE_DIR="media/image"
VIDEO_INPUT_DIR="media/video/input/demo2"
VIDEO_TMP_DIR="media/video/tmp/demo2"
VIDEO_OUTPUT_DIR="media/video/output/demo2"
VIDEO_FINAL_DIR="media/video/final"

#rm -vf "$VIDEO_TMP_DIR/*.mp4"

if [ ! -f "$IMAGE_DIR/right-arrow.png" ]; then
    echo "Input image not found: $IMAGE_DIR/right-arrow.png"
    exit 1
else
    echo "Input image found: $IMAGE_DIR/right-arrow.png"
fi

if [ ! -f "$IMAGE_DIR/left-arrow.png" ]; then
    echo "Input image not found: $IMAGE_DIR/left-arrow.png"
    exit 1
else
    echo "Input image found: $IMAGE_DIR/left-arrow.png"
fi

for segment in {1..5}; do
    if [ ! -f "$VIDEO_INPUT_DIR/segment${segment}.mp4" ]; then
        echo "Input video not found: $VIDEO_INPUT_DIR/segment${segment}.mp4"
        exit 1
    else
        echo "Input video found: $VIDEO_INPUT_DIR/segment${segment}.mp4"
    fi
done

##### Start segment 1 #####
echo "Start segment 1"
SEGMENT1_TEXT1="Viewing mouse brain DK55 in sagittal, coronal, horizontal and 3D between two users with two different browsers. "
SEGMENT1_TEXT2="Edward is on the right browser window and will share his screen with Duane."
SEGMENT1_TEXT3="User Duane is on the left browser window and will click the observe button to watch Edwards screen."
SEGMENT1_TEXT4="Edward will expand the sagittal view."
SEGMENT1_TEXT5="The sagittal view shows an incorrectly drawn polgon on the cerebellum."
SEGMENT1_TEXT6="Edward will delete this polygon."

ffmpeg -hide_banner -loglevel error -y -i $VIDEO_INPUT_DIR/segment1.mp4 -an -vf \
"
drawtext=text='$SEGMENT1_TEXT1':$FONT:$BOTTOM:enable='between(t,0,3)', \
drawtext=text='$SEGMENT1_TEXT2':$FONT:$BR:enable='between(t,4,8)', \
drawtext=text='$SEGMENT1_TEXT3':$FONT:$BL:enable='between(t,9,12)', \
drawtext=text='$SEGMENT1_TEXT4':$FONT:$BR:enable='between(t,13,16)', \
drawtext=text='$SEGMENT1_TEXT5':$FONT:$BOTTOM:enable='between(t,17,19)', \
drawtext=text='$SEGMENT1_TEXT6':$FONT:$BR:enable='between(t,20,28)', \
" \
"$VIDEO_TMP_DIR/segment1.text.mp4"

##### Start drawing of labels on segment 1 #####
#cp -vf "$VIDEO_TMP_DIR/segment1.mp4" "$VIDEO_OUTPUT_DIR/segment1.mp4"
ffmpeg -hide_banner -loglevel error -y -i "$VIDEO_TMP_DIR/segment1.text.mp4" -an \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-filter_complex \
"[0][1]overlay=$SAG24QUAD:enable='between(t,0,3)'[v1]; \
[v1][2]overlay=$THREED24QUAD:enable='between(t,4,8)'[v2]; \
[v2][3]overlay=x=1400:y=528:enable='between(t,9,12)'[v3]; \
[v3][4]overlay=x=1700:y=500:enable='between(t,13,16)'[v4]; \
[v4][5]overlay=x=1700:y=300:enable='between(t,17,19)'[v5]; \
[v5][6]overlay=x=1740:y=270:enable='between(t,20,28)'[v6]" \
-map "[v6]" "$VIDEO_OUTPUT_DIR/segment1.mp4"
echo "Finished segment 6, output saved to $VIDEO_OUTPUT_DIR/segment1.mp4"
##### End drawing of labels on segment 1 here ####
echo "Finished processing segment 1 to $VIDEO_OUTPUT_DIR/segment1.mp4"
##### End segment 1 #####

##### Start segment 2 #####
echo "Start segment 2"
SEGMENT2_TEXT1="Edward finds the polygon in the list on the far right of the screen and deletes the polygon."

ffmpeg -hide_banner -loglevel error -y -i $VIDEO_INPUT_DIR/segment2.mp4 -an -vf \
"
drawtext=text='$SEGMENT2_TEXT1':$FONT:$BR:enable='between(t,0,10)', \
" \
"$VIDEO_TMP_DIR/segment2.text.mp4"

##### Start drawing of labels on segment 2 #####
#cp -vf "$VIDEO_TMP_DIR/segment2.mp4" "$VIDEO_OUTPUT_DIR/segment2.mp4"
ffmpeg -hide_banner -loglevel error -y -i "$VIDEO_TMP_DIR/segment2.text.mp4" -an \
-i "$IMAGE_DIR/left-arrow.png" -filter_complex \
"[0][1]overlay=$SAG24QUAD:enable='between(t,0,10)'[v1]" \
-map "[v1]" "$VIDEO_OUTPUT_DIR/segment2.mp4"
echo "Finished segment 2, output saved to $VIDEO_OUTPUT_DIR/segment2.mp4"
##### End drawing of labels on segment 2 here ####
##### End segment 2 #####

##### Start segment 3 #####
echo "Start segment 3"
SEGMENT3_TEXT1="Duane is now sharing and draws a polygon that has errors."

ffmpeg -hide_banner -loglevel error -y -i $VIDEO_INPUT_DIR/segment3.mp4 -an -vf \
"
drawtext=text='$SEGMENT3_TEXT1':$FONT:$BL:enable='between(t,0,20)', \
" \
"$VIDEO_TMP_DIR/segment3.text.mp4"

##### Start drawing of labels on segment 3 #####
#cp -vf "$VIDEO_TMP_DIR/segment3.mp4" "$VIDEO_OUTPUT_DIR/segment3.mp4"
ffmpeg -hide_banner -loglevel error -y -i "$VIDEO_TMP_DIR/segment3.text.mp4" -an \
-i "$IMAGE_DIR/left-arrow.png" -filter_complex \
"[0][1]overlay=$SAG24QUAD:enable='between(t,0,20)'[v1]" \
-map "[v1]" "$VIDEO_OUTPUT_DIR/segment3.mp4"
echo "Finished segment 3, output saved to $VIDEO_OUTPUT_DIR/segment3.mp4"
##### End drawing of labels on segment 3 here ####
##### End segment 3 #####

##### Start segment 4 #####
echo "Start segment 4"
SEGMENT4_TEXT1="Duane now swaps over to Edward."
SEGMENT4_TEXT2="Edward now adjusts the point width to a higher value to make it easier to click on the points."
SEGMENT4_TEXT3="Edward adds more points to the polygon."
SEGMENT4_TEXT4="Edward moves the points to the edge of the cerebellum."
SEGMENT4_TEXT5="Edward swaps control to Duane."
SEGMENT4_TEXT6="Duane moves to section 306 to start a new polygon."
SEGMENT4_TEXT7="Duane draws a new polygon on the cerebellum."

ffmpeg -hide_banner -loglevel error -y -i $VIDEO_INPUT_DIR/segment4.mp4 -an -vf \
"
drawtext=text='$SEGMENT4_TEXT1':$FONT:$BL:enable='between(t,0,6)', \
drawtext=text='$SEGMENT4_TEXT2':$FONT:$BR:enable='between(t,8,10)', \
drawtext=text='$SEGMENT4_TEXT3':$FONT:$BR:enable='between(t,20,30)', \
drawtext=text='$SEGMENT4_TEXT4':$FONT:$BR:enable='between(t,35,44)', \
drawtext=text='$SEGMENT4_TEXT5':$FONT:$BR:enable='between(t,49,51)', \
drawtext=text='$SEGMENT4_TEXT6':$FONT:$BL:enable='between(t,55,60)', \
drawtext=text='$SEGMENT4_TEXT7':$FONT:$BL:enable='between(t,65,85)', \

" \
"$VIDEO_TMP_DIR/segment4.text.mp4"

##### Start drawing of labels on segment 4 #####
#cp -vf "$VIDEO_TMP_DIR/segment4.mp4" "$VIDEO_OUTPUT_DIR/segment4.mp4"
ffmpeg -hide_banner -loglevel error -y -i "$VIDEO_TMP_DIR/segment4.text.mp4" -an \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-filter_complex \
"[0][1]overlay=$SAG24QUAD:enable='between(t,0,6)'[v1]; \
[v1][2]overlay=$THREED24QUAD:enable='between(t,8,10)'[v2]; \
[v2][3]overlay=x=1400:y=528:enable='between(t,20,30)'[v3]; \
[v3][4]overlay=x=1700:y=500:enable='between(t,35,44)'[v4]; \
[v4][5]overlay=x=1700:y=300:enable='between(t,49,51)'[v5]; \
[v5][6]overlay=x=1700:y=300:enable='between(t,55,60)'[v6]; \
[v6][7]overlay=x=1740:y=270:enable='between(t,65,85)'[v7]" \
-map "[v7]" "$VIDEO_OUTPUT_DIR/segment4.mp4"
echo "Finished segment 4, output saved to $VIDEO_OUTPUT_DIR/segment4.mp4"
##### End drawing of labels on segment 4 here ####
##### End segment 4 #####

##### Start segment 5 #####
echo "Start segment 5"
SEGMENT5_TEXT1="Duane swaps back to Edward."
SEGMENT5_TEXT2="Edward stops sharing." 
SEGMENT5_TEXT3="Duane is now disconnected."
SEGMENT5_TEXT4="Edward saves and ends the session."

ffmpeg -hide_banner -loglevel error -y -i $VIDEO_INPUT_DIR/segment5.mp4 -an -vf \
"
drawtext=text='$SEGMENT5_TEXT1':$FONT:$BL:enable='between(t,0,3)', \
drawtext=text='$SEGMENT5_TEXT2':$FONT:$BR:enable='between(t,5,7)', \
drawtext=text='$SEGMENT5_TEXT3':$FONT:$BL:enable='between(t,7,8)', \
drawtext=text='$SEGMENT5_TEXT4':$FONT:$BR:enable='between(t,8,15)', \
" \
"$VIDEO_TMP_DIR/segment5.text.mp4"

##### Start drawing of labels on segment 5 #####
#cp -vf "$VIDEO_TMP_DIR/segment5.mp4" "$VIDEO_OUTPUT_DIR/segment5.mp4"
ffmpeg -hide_banner -loglevel error -y -i "$VIDEO_TMP_DIR/segment5.text.mp4" -an \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-filter_complex \
"[0][1]overlay=$SAG24QUAD:enable='between(t,0,3)'[v1]; \
[v1][2]overlay=$THREED24QUAD:enable='between(t,5,7)'[v2]; \
[v2][3]overlay=x=1400:y=528:enable='between(t,7,8)'[v3]; \
[v3][4]overlay=x=1740:y=270:enable='between(t,8,15)'[v4]" \
-map "[v4]" "$VIDEO_OUTPUT_DIR/segment5.mp4"
echo "Finished segment 5, output saved to $VIDEO_OUTPUT_DIR/segment5.mp4"
##### End drawing of labels on segment 5 here ####
##### End segment 5 #####


##### Concatenate all segment outputs with transitions
echo "Concatenating all segments"
mapfile -t SEGMENT_FILES < <(find "$VIDEO_OUTPUT_DIR" -maxdepth 1 -type f -name 'segment?.mp4' | sort -V)

CONCAT_LIST="files.txt"
rm -vf "$CONCAT_LIST"
touch $CONCAT_LIST
for file in "${SEGMENT_FILES[@]}"; do
    echo "file '$file'" >> "$CONCAT_LIST"
done
echo "Here are the files to be used for concatenation:"
cat "$CONCAT_LIST"
FINAL_VIDEO="$VIDEO_FINAL_DIR/DK55.multiuser.annotation.demo.mp4"

ffmpeg -hide_banner -loglevel error -y -f concat -safe 0 -i "$CONCAT_LIST" -c copy "$FINAL_VIDEO"

#rsync -auv --progress ./media/ mothra:/home/eddyod/programming/cerebellum_annotation/media/


if [ -f "$FINAL_VIDEO" ]; then
    echo "Concatenation successful: $FINAL_VIDEO"
    echo "Finished"
else
    echo "Concatenation failed: $FINAL_VIDEO not found"
    exit 1
fi


