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
BL="x=100:y=h-th-10"
LEFT_USER_PANEL_X=200
RIGHT_USER_PANEL_X=2050
LEFT_SELECTION_PANEL_X=200
RIGHT_SELECTION_PANEL_X=3350

BR="x=(w-text_w):y=h-th-10"
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

for segment in {1..4}; do
    if [ ! -f "$VIDEO_INPUT_DIR/segment${segment}.mp4" ]; then
        echo "Input video not found: $VIDEO_INPUT_DIR/segment${segment}.mp4"
        exit 1
    else
        echo "Input video found: $VIDEO_INPUT_DIR/segment${segment}.mp4"
    fi
done

##### Start segment 1 #####
echo -n "Start segment 1"
SEGMENT1_TEXT1="Viewing mouse brain DK55 in sagittal, coronal, horizontal and 3D between two users with two different browsers. "
SEGMENT1_TEXT2="Edward is on the right browser window and will share his screen with Duane."
SEGMENT1_TEXT3="User Duane is on the left browser window and will click the observe button to watch Edwards screen."
SEGMENT1_TEXT4="Edward will expand the sagittal view."
SEGMENT1_TEXT5="The sagittal view shows an incorrectly drawn polgon on the cerebellum."
SEGMENT1_TEXT6="Edward will delete this polygon."

if [ -f "$VIDEO_TMP_DIR/segment1.text.mp4" ]; then
    echo " and $VIDEO_TMP_DIR/segment1.text.mp4 already exists, skipping text overlay step."
else
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
fi

##### Start drawing of labels on segment 1 #####
if [ -f "$VIDEO_OUTPUT_DIR/segment1.mp4" ]; then
    echo " and $VIDEO_OUTPUT_DIR/segment1.mp4 already exists, skipping label overlay step."
else
    ffmpeg -hide_banner -loglevel error -y -i "$VIDEO_TMP_DIR/segment1.text.mp4" -an \
    -i "$IMAGE_DIR/left-arrow.png" \
    -i "$IMAGE_DIR/left-arrow.png" \
    -i "$IMAGE_DIR/left-arrow.png" \
    -i "$IMAGE_DIR/left-arrow.png" \
    -i "$IMAGE_DIR/right-arrow.png" \
    -filter_complex \
    "
    [0][1]overlay=x=$RIGHT_USER_PANEL_X:y=150:enable='between(t,4,8)'[v1]; \
    [v1][2]overlay=x=$LEFT_USER_PANEL_X:y=150:enable='between(t,9,12)'[v2]; \
    [v2][3]overlay=x=2800:y=175:enable='between(t,13,16)'[v3]; \
    [v3][4]overlay=x=3200:y=500:enable='between(t,18,23)'[v4]; \
    [v4][5]overlay=x=$RIGHT_SELECTION_PANEL_X:y=850:enable='between(t,24,28)'[v5]" \
    -map "[v5]" "$VIDEO_OUTPUT_DIR/segment1.mp4"
    echo " and finished segment 1, output saved to $VIDEO_OUTPUT_DIR/segment1.mp4"
fi
##### End segment 1 #####

##### Start segment 2 #####
echo -n "Start segment 2"
SEGMENT2_TEXT1="Duane is now sharing and draws a polygon that has errors."

if [ -f "$VIDEO_TMP_DIR/segment2.text.mp4" ]; then
    echo " and $VIDEO_TMP_DIR/segment2.text.mp4 already exists, skipping text overlay step."
else
    ffmpeg -hide_banner -loglevel error -y -i $VIDEO_INPUT_DIR/segment2.mp4 -an -vf \
    "
    drawtext=text='$SEGMENT2_TEXT1':$FONT:$BL:enable='between(t,0,20)', \
    " \
    "$VIDEO_TMP_DIR/segment2.text.mp4"
fi

if [ -f "$VIDEO_OUTPUT_DIR/segment2.mp4" ]; then
    echo " and $VIDEO_OUTPUT_DIR/segment2.mp4 already exists, skipping label overlay step."
else
    ffmpeg -hide_banner -loglevel error -y -i "$VIDEO_TMP_DIR/segment2.text.mp4" -an \
    -i "$IMAGE_DIR/left-arrow.png" -filter_complex \
    "[0][1]overlay=x=1000:y=500:enable='between(t,0,20)'[v1]" \
    -map "[v1]" "$VIDEO_OUTPUT_DIR/segment2.mp4"
    echo " and finished segment 2, output saved to $VIDEO_OUTPUT_DIR/segment2.mp4"
fi  
##### End segment 2 #####

##### Start segment 3 #####
echo -n "Start segment 3"
SEGMENT3_TEXT1="Edward now adjusts the point width to a higher value to make it easier to click on the points."
SEGMENT3_TEXT2="Edward adds more points to the polygon."
SEGMENT3_TEXT3="Edward moves the points to the edge of the cerebellum."
SEGMENT3_TEXT4="Edward swaps control to Duane."
SEGMENT3_TEXT5="Duane moves to section 306 to start a new polygon."
SEGMENT3_TEXT6="Duane draws a new polygon on the cerebellum."

if [ -f "$VIDEO_TMP_DIR/segment3.text.mp4" ]; then
    echo " and $VIDEO_TMP_DIR/segment3.text.mp4 already exists, skipping text overlay step."
else
    ffmpeg -hide_banner -loglevel error -y -i $VIDEO_INPUT_DIR/segment3.mp4 -an -vf \
    "
    drawtext=text='$SEGMENT3_TEXT1':$FONT:$BR:enable='between(t,0,10)', \
    drawtext=text='$SEGMENT3_TEXT2':$FONT:$BR:enable='between(t,20,30)', \
    drawtext=text='$SEGMENT3_TEXT3':$FONT:$BR:enable='between(t,35,44)', \
    drawtext=text='$SEGMENT3_TEXT4':$FONT:$BR:enable='between(t,49,51)', \
    drawtext=text='$SEGMENT3_TEXT5':$FONT:$BL:enable='between(t,55,60)', \
    drawtext=text='$SEGMENT3_TEXT6':$FONT:$BL:enable='between(t,65,85)', \
    " \
    "$VIDEO_TMP_DIR/segment3.text.mp4"
fi

if [ -f "$VIDEO_OUTPUT_DIR/segment3.mp4" ]; then
    echo " and $VIDEO_OUTPUT_DIR/segment3.mp4 already exists, skipping label overlay step."
else
    ffmpeg -hide_banner -loglevel error -y -i "$VIDEO_TMP_DIR/segment3.text.mp4" -an \
    -i "$IMAGE_DIR/right-arrow.png" \
    -i "$IMAGE_DIR/left-arrow.png" \
    -i "$IMAGE_DIR/left-arrow.png" \
    -i "$IMAGE_DIR/left-arrow.png" \
    -i "$IMAGE_DIR/left-arrow.png" \
    -i "$IMAGE_DIR/left-arrow.png" \
    -filter_complex \
    "[0][1]overlay=$RIGHT_SELECTION_PANEL_X:y=750:enable='between(t,0,10)'[v1]; \
    [v1][2]overlay=x=2800:y=650:enable='between(t,20,30)'[v2]; \
    [v2][3]overlay=x=2790:y=650:enable='between(t,35,44)'[v3]; \
    [v3][4]overlay=x=2100:y=245:enable='between(t,49,51)'[v4]; \
    [v4][5]overlay=x=390:y=250:enable='between(t,55,58)'[v5]; \
    [v5][6]overlay=x=900:y=475:enable='between(t,65,85)'[v6]" \
    -map "[v6]" "$VIDEO_OUTPUT_DIR/segment3.mp4"
    echo " and finished segment 3, output saved to $VIDEO_OUTPUT_DIR/segment3.mp4"
fi
##### End segment 3 #####

##### Start segment 4 #####
echo -n "Start segment 4"
SEGMENT4_TEXT1="Duane swaps back to Edward."
SEGMENT4_TEXT2="Edward stops sharing." 
SEGMENT4_TEXT3="Duane is now disconnected."
SEGMENT4_TEXT4="Edward saves and ends the session."

if [ -f "$VIDEO_TMP_DIR/segment4.text.mp4" ]; then
    echo " and $VIDEO_TMP_DIR/segment4.text.mp4 already exists, skipping text overlay step."
else
    ffmpeg -hide_banner -loglevel error -y -i $VIDEO_INPUT_DIR/segment4.mp4 -an -vf \
    "
    drawtext=text='$SEGMENT4_TEXT1':$FONT:$BL:enable='between(t,0,3)', \
    drawtext=text='$SEGMENT4_TEXT2':$FONT:$BR:enable='between(t,5,7)', \
    drawtext=text='$SEGMENT4_TEXT3':$FONT:$BL:enable='between(t,7,8)', \
    drawtext=text='$SEGMENT4_TEXT4':$FONT:$BR:enable='between(t,8,15)', \
    " \
    "$VIDEO_TMP_DIR/segment4.text.mp4"
fi

if [ -f "$VIDEO_OUTPUT_DIR/segment4.mp4" ]; then
    echo " and $VIDEO_OUTPUT_DIR/segment4.mp4 already exists, skipping label overlay step."
else
    ffmpeg -hide_banner -loglevel error -y -i "$VIDEO_TMP_DIR/segment4.text.mp4" -an \
    -i "$IMAGE_DIR/left-arrow.png" \
    -i "$IMAGE_DIR/left-arrow.png" \
    -i "$IMAGE_DIR/left-arrow.png" \
    -i "$IMAGE_DIR/left-arrow.png" \
    -filter_complex \
    "[0][1]overlay=x=$LEFT_USER_PANEL_X:y=205:enable='between(t,0,3)'[v1]; \
    [v1][2]overlay=x=2100:y=205:enable='between(t,5,7)'[v2]; \
    [v2][3]overlay=x=$LEFT_USER_PANEL_X:y=205:enable='between(t,7,8)'[v3]; \
    [v3][4]overlay=x=2100:y=205:enable='between(t,9,15)'[v4]" \
    -map "[v4]" "$VIDEO_OUTPUT_DIR/segment4.mp4"
    echo " and finished segment 4, output saved to $VIDEO_OUTPUT_DIR/segment4.mp4"
fi
##### End segment 4 #####

######################################################

##### Concatenate all segment outputs with transitions
echo ""
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

if [ -f "$FINAL_VIDEO" ]; then
    echo " and $FINAL_VIDEO already exists, skipping concatenation step."
    exit 0
else
    ffmpeg -hide_banner -loglevel error -y -f concat -safe 0 -i "$CONCAT_LIST" -c copy "$FINAL_VIDEO"
fi
#rsync -auv --progress ./media/ mothra:/home/eddyod/programming/cerebellum_annotation/media/


if [ -f "$FINAL_VIDEO" ]; then
    echo "Concatenation successful: $FINAL_VIDEO"
    echo "Finished"
else
    echo "Concatenation failed: $FINAL_VIDEO not found"
    exit 1
fi


