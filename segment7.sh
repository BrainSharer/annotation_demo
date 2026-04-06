#!/bin/bash

set -euo pipefail

FONT="fontcolor=yellow:fontsize=32:box=1:boxcolor=black@0.5"
BOTTOM="x=(w-text_w)/2:y=h-th-10"
SAG24QUAD="x=1550:y=150"
THREED24QUAD="x=1550:y=590"
LAYER_Y=132
IMAGE_DIR="media/image"
VIDEO_INPUT_DIR="media/video/input/demo1"
VIDEO_TMP_DIR="media/video/tmp/demo1"
VIDEO_OUTPUT_DIR="media/video/output/demo1"
VIDEO_FINAL_DIR="media/video/final/demo1"
TEXT_OUTPUT="$VIDEO_TMP_DIR/segment7.text.mp4"
if [ ! -f "$VIDEO_INPUT_DIR/segment7.mp4" ]; then
    echo "Input video not found: $VIDEO_INPUT_DIR/segment7.mp4"
    exit 1
else
    echo "Input video found: $VIDEO_INPUT_DIR/segment7.mp4"
fi

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

# turn off annotations
# switch to fixed color and pick a light blue
# turn Opacity 3d down to 0.85
# zoom in and move around
# go to 4 views and move the horiz view around.
# create new annotation layer
# import DK55 5N left and then right
# create mesh for left and then right
# got selection lower left and go to 1st polygon
# go to each mesh and turn them on
# go to 3D view and move around
# turn off new annotation layer
# control click C1, and go to render tab, increase resolution all the way
# move around
# save and end

echo -n "Start segment 7"
if [ -f "$VIDEO_TMP_DIR/segment7.text.mp4" ]; then
    echo " and $VIDEO_TMP_DIR/segment7.text.mp4 already exists, skipping text overlay step."
else
    echo " and adding text overlay."
    SEGMENT7_TEXT1="Click off the polygons and view the 3D mesh on its own."
    SEGMENT7_TEXT2="Switch to a fixed color and pick a light green for the mesh."
    SEGMENT7_TEXT3="Turn the opacity of the 3D mesh down to 0.85."
    SEGMENT7_TEXT4="The 3D mesh can be rotated and zoomed in on to view different perspectives of the cerebellum."
    SEGMENT7_TEXT5="Go to the 4 views."
    SEGMENT7_TEXT6="Create a new annotation layer."
    SEGMENT7_TEXT7="Import the DK55 5N left and then right"
    SEGMENT7_TEXT8="Go to the selection lower left and go to the first polygon."
    SEGMENT7_TEXT9="Create a 3D mesh for the left and then right."
    SEGMENT7_TEXT10="Go to each mesh and turn them on."
    SEGMENT7_TEXT11="Go to the 3D view and move around."
    SEGMENT7_TEXT12="Turn off the new annotation layer and move around."
    SEGMENT7_TEXT13="Control click C1, and go to the render tab, increase the resolution all the way."
    SEGMENT7_TEXT14="Move around."
    SEGMENT7_TEXT15="Save and end."

    ffmpeg -hide_banner -loglevel error -y -i "$VIDEO_INPUT_DIR/segment7.mp4" -an -vf \
    "
    drawtext=text='$SEGMENT7_TEXT1':$FONT:$BOTTOM:enable='between(t,0,5)', \
    drawtext=text='$SEGMENT7_TEXT2':$FONT:$BOTTOM:enable='between(t,6,14)', \
    drawtext=text='$SEGMENT7_TEXT3':$FONT:$BOTTOM:enable='between(t,16,27)', \
    drawtext=text='$SEGMENT7_TEXT4':$FONT:$BOTTOM:enable='between(t,28,44)', \
    drawtext=text='$SEGMENT7_TEXT5':$FONT:$BOTTOM:enable='between(t,51,53)', \
    drawtext=text='$SEGMENT7_TEXT6':$FONT:$BOTTOM:enable='between(t,58,60)', \
    drawtext=text='$SEGMENT7_TEXT7':$FONT:$BOTTOM:enable='between(t,62,90)', \
    drawtext=text='$SEGMENT7_TEXT8':$FONT:$BOTTOM:enable='between(t,93,100)', \
    drawtext=text='$SEGMENT7_TEXT9':$FONT:$BOTTOM:enable='between(t,110,120)', \
    drawtext=text='$SEGMENT7_TEXT10':$FONT:$BOTTOM:enable='between(t,125,135)', \
    drawtext=text='$SEGMENT7_TEXT11':$FONT:$BOTTOM:enable='between(t,139,143)', \
    drawtext=text='$SEGMENT7_TEXT12':$FONT:$BOTTOM:enable='between(t,144,150)', \
    drawtext=text='$SEGMENT7_TEXT13':$FONT:$BOTTOM:enable='between(t,170,186)', \
    drawtext=text='$SEGMENT7_TEXT14':$FONT:$BOTTOM:enable='between(t,187,205)', \
    drawtext=text='$SEGMENT7_TEXT15':$FONT:$BOTTOM:enable='between(t,210,218)' \
    " \
    "$VIDEO_TMP_DIR/segment7.text.mp4"
    echo "Text overlay added, saved to $VIDEO_TMP_DIR/segment7.text.mp4"
fi
##### Adding images to segment 7

ffmpeg -hide_banner -loglevel error -y -i "$VIDEO_TMP_DIR/segment7.text.mp4" -an \
-i "$IMAGE_DIR/right-arrow.png" \
-i "$IMAGE_DIR/right-arrow.png" \
-i "$IMAGE_DIR/right-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/right-arrow.png" \
-i "$IMAGE_DIR/right-arrow.png" \
-i "$IMAGE_DIR/right-arrow.png" \
-i "$IMAGE_DIR/right-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/right-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-filter_complex \
"[0][1]overlay=x=200:y=$LAYER_Y:enable='between(t,0,5)'[v1]; \
[v1][2]overlay=x=1750:y=200:enable='between(t,6,14)'[v2]; \
[v2][3]overlay=x=1450:y=400:enable='between(t,16,27)'[v3]; \
[v3][4]overlay=x=1550:y=155:enable='between(t,51,53)'[v4]; \
[v4][5]overlay=x=675:y=145:enable='between(t,58,60)'[v5]; \
[v5][6]overlay=x=1450:y=190:enable='between(t,62,90)'[v6]; \
[v6][7]overlay=x=1450:y=750:enable='between(t,93,100)'[v7]; \
[v7][8]overlay=x=1550:y=340:enable='between(t,110,120)'[v8]; \
[v8][9]overlay=x=1500:y=165:enable='between(t,126,135)'[v9]; \
[v9][10]overlay=x=1550:y=625:enable='between(t,136,139)'[v10]; \
[v10][11]overlay=x=800:y=150:enable='between(t,144,146)'[v11]; \
[v11][12]overlay=x=300:y=150:enable='between(t,170,172)'[v12]; \
[v12][13]overlay=x=1450:y=275:enable='between(t,178,185)'[v13]; \
[v13][14]overlay=x=200:y=175:enable='between(t,210,218)'[v14]" \
-map "[v14]" "$VIDEO_OUTPUT_DIR/segment7.mp4"
echo " and finished, output saved to $VIDEO_OUTPUT_DIR/segment7.mp4"
##### Finished segment 7

