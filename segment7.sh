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

if [ ! -f "$TEXT_OUTPUT" ]; then
    echo "Start segment 7"
    SEGMENT7_TEXT1="Click off the polygons and view the 3D mesh on its own."
    SEGMENT7_TEXT2="Adjust the color of the 3D mesh."
    SEGMENT7_TEXT3="Toggle the volume rendering to view the 3D mesh within the context of the whole brain."
    SEGMENT7_TEXT4="The 3D mesh can be rotated and zoomed in on to view different perspectives of the cerebellum."
    SEGMENT7_TEXT5="Turn the polygons back on."
    SEGMENT7_TEXT6="Revert to the sagittal, coronal, horizontal and 3D view and move the view around."
    SEGMENT7_TEXT7="Save the view and finish the demonstration"

    ffmpeg -hide_banner -loglevel error -y -i "$VIDEO_INPUT_DIR/segment7.mp4" -an -vf \
    "
    drawtext=text='$SEGMENT7_TEXT1':$FONT:$BOTTOM:enable='between(t,0,5)', \
    drawtext=text='$SEGMENT7_TEXT2':$FONT:$BOTTOM:enable='between(t,6,14)', \
    drawtext=text='$SEGMENT7_TEXT3':$FONT:$BOTTOM:enable='between(t,20,24)', \
    drawtext=text='$SEGMENT7_TEXT4':$FONT:$BOTTOM:enable='between(t,25,44)', \
    drawtext=text='$SEGMENT7_TEXT5':$FONT:$BOTTOM:enable='between(t,45,47)', \
    drawtext=text='$SEGMENT7_TEXT6':$FONT:$BOTTOM:enable='between(t,49,73)', \
    drawtext=text='$SEGMENT7_TEXT7':$FONT:$BOTTOM:enable='between(t,74,87)', \
    " \
    "$TEXT_OUTPUT"
    echo "Finished adding text to segment 7, output saved to $TEXT_OUTPUT"
else
    echo "Input video already exists: $TEXT_OUTPUT, skipping text addition for segment 7"
fi
##### Adding images to segment 7

ffmpeg -hide_banner -loglevel error -y -i "$TEXT_OUTPUT" -an \
-i "$IMAGE_DIR/right-arrow.png" \
-i "$IMAGE_DIR/right-arrow.png" \
-i "$IMAGE_DIR/right-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-filter_complex \
"[0][1]overlay=x=200:y=$LAYER_Y:enable='between(t,0,5)'[v1]; \
[v1][2]overlay=x=1750:y=200:enable='between(t,6,14)'[v2]; \
[v2][3]overlay=x=1750:y=250:enable='between(t,20,24)'[v3]; \
[v3][4]overlay=x=400:y=$LAYER_Y:enable='between(t,45,47)'[v4]; \
[v4][5]overlay=x=1550:y=145:enable='between(t,49,60)'[v5]; \
[v5][6]overlay=x=200:y=150:enable='between(t,74,87)'[v6]" \
-map "[v6]" "$VIDEO_OUTPUT_DIR/segment7.mp4"

echo "Finished adding images to segment 7, output saved to $VIDEO_OUTPUT_DIR/segment7.mp4"