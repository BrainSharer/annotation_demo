set -euo pipefail

FONT="fontcolor=yellow:fontsize=32:box=1:boxcolor=black@0.5"
BOTTOM="x=(w-text_w)/2:y=h-th-10"
SAG24QUAD="x=1550:y=150"
THREED24QUAD="x=1550:y=590"
LAYER_Y=132
IMAGE_DIR="media/image"
VIDEO_INPUT_DIR="media/video/input"
VIDEO_TMP_DIR="media/video/tmp"
VIDEO_OUTPUT_DIR="media/video/output"

SEGMENT6_TEXT1="Revert to the sagittal, coronal, horizontal and 3D view."
SEGMENT6_TEXT2="Switch to the 3D view and view the polygons within the whole brain."
SEGMENT6_TEXT3="Move the 3D view around to view different perspectives."
SEGMENT6_TEXT4="Label the volume. Typing 'cerebellum' will label the volume."
SEGMENT6_TEXT5="Click the new button to export the data."
SEGMENT6_TEXT6="Highlight the mauve colored volume near the top right and click the down arrow."
SEGMENT6_TEXT7="A popup window will appear where you can select the smoothing of the 3D mesh."
SEGMENT6_TEXT7a="Click the Run button, this will take a few seconds to complete."
SEGMENT6_TEXT8="A new layer will appear."
SEGMENT6_TEXT9="Click the layer to access the controls."
SEGMENT6_TEXT10="Go go the segments tab to view the 3D mesh."
SEGMENT6_TEXT11="Click off the polygons and view the 3D mesh on its own."
SEGMENT6_TEXT12="The 3D mesh can be rotated and zoomed in on to view different perspectives of the cerebellum."
SEGMENT6_TEXT13="Toggle the volume rendering to view the 3D mesh within the context of the whole brain."
SEGMENT6_TEXT14="Turn the polygons back on."
SEGMENT6_TEXT15="Revert to the sagittal, coronal, horizontal and 3D view and move the view around."
SEGMENT6_TEXT16="Maximize the horizontal view and move the view around."
SEGMENT6_TEXT17="Revert to the sagittal, coronal, horizontal and 3D view and move the view around."
SEGMENT6_TEXT18="Save the view and finish the demonstration"


if [ ! -d "$VIDEO_TMP_DIR" ]; then
    mkdir -p "$VIDEO_TMP_DIR"
fi

if [ ! -f "$VIDEO_INPUT_DIR/segment6.mp4" ]; then
    echo "Input video not found: $VIDEO_INPUT_DIR/segment6.mp4"
    exit 1
fi


if [ ! -f "$VIDEO_TMP_DIR/segment6.text.mp4" ]; then
    echo "Input video not found, creating: $VIDEO_TMP_DIR/segment6.text.mp4"
    ffmpeg -i "$VIDEO_INPUT_DIR/segment6.mp4" -an -vf \
    "
    drawtext=text='$SEGMENT6_TEXT1':$FONT:$BOTTOM:enable='between(t,0,3)', \
    drawtext=text='$SEGMENT6_TEXT2':$FONT:$BOTTOM:enable='between(t,4,6)', \
    drawtext=text='$SEGMENT6_TEXT3':$FONT:$BOTTOM:enable='between(t,7,24)', \
    drawtext=text='$SEGMENT6_TEXT4':$FONT:$BOTTOM:enable='between(t,29,36)', \
    drawtext=text='$SEGMENT6_TEXT5':$FONT:$BOTTOM:enable='between(t,39,46)', \
    drawtext=text='$SEGMENT6_TEXT6':$FONT:$BOTTOM:enable='between(t,51,54)', \
    drawtext=text='$SEGMENT6_TEXT7':$FONT:$BOTTOM:enable='between(t,55,65)', \
    drawtext=text='$SEGMENT6_TEXT7a':$FONT:$BOTTOM:enable='between(t,67,86)', \
    drawtext=text='$SEGMENT6_TEXT8':$FONT:$BOTTOM:enable='between(t,87,92)', \
    drawtext=text='$SEGMENT6_TEXT9':$FONT:$BOTTOM:enable='between(t,93,94)', \
    drawtext=text='$SEGMENT6_TEXT10':$FONT:$BOTTOM:enable='between(t,95,100)', \
    drawtext=text='$SEGMENT6_TEXT11':$FONT:$BOTTOM:enable='between(t,104,105)', \
    drawtext=text='$SEGMENT6_TEXT12':$FONT:$BOTTOM:enable='between(t,109,124)', \
    drawtext=text='$SEGMENT6_TEXT13':$FONT:$BOTTOM:enable='between(t,129,144)', \
    drawtext=text='$SEGMENT6_TEXT14':$FONT:$BOTTOM:enable='between(t,145,150)', \
    drawtext=text='$SEGMENT6_TEXT15':$FONT:$BOTTOM:enable='between(t,151,156)', \
    drawtext=text='$SEGMENT6_TEXT16':$FONT:$BOTTOM:enable='between(t,157,164)', \
    drawtext=text='$SEGMENT6_TEXT17':$FONT:$BOTTOM:enable='between(t,165,194)', \
    drawtext=text='$SEGMENT6_TEXT18':$FONT:$BOTTOM:enable='between(t,195,198)' \
    " \
    "$VIDEO_TMP_DIR/segment6.text.mp4"
fi
##### Adding images to segment 6

ffmpeg -y -i "$VIDEO_TMP_DIR/segment6.text.mp4" -an \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/right-arrow.png"  \
-i "$IMAGE_DIR/right-arrow.png" \
-i "$IMAGE_DIR/right-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/right-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-i "$IMAGE_DIR/left-arrow.png" \
-filter_complex \
"[0][1]overlay=$SAG24QUAD:enable='between(t,0,3)'[v1]; \
[v1][2]overlay=$THREED24QUAD:enable='between(t,4,6)'[v2]; \
[v2][3]overlay=x=1400:y=528:enable='between(t,29,36)'[v3]; \
[v3][4]overlay=x=1700:y=500:enable='between(t,39,46)'[v4]; \
[v4][5]overlay=x=1700:y=300:enable='between(t,51,54)'[v5]; \
[v5][6]overlay=x=1072:y=542:enable='between(t,55,65)'[v6]; \
[v6][7]overlay=x=650:y=$LAYER_Y:enable='between(t,87,92)'[v7]; \
[v7][8]overlay=x=368:y=$LAYER_Y:enable='between(t,93,94)'[v8]; \
[v8][9]overlay=x=1684:y=184:enable='between(t,95,100)'[v9]; \
[v9][10]overlay=x=394:y=$LAYER_Y:enable='between(t,104,108)'[v10]; \
[v10][11]overlay=x=1740:y=270:enable='between(t,129,144)'[v11]; \
[v11][12]overlay=x=368:y=$LAYER_Y:enable='between(t,145,150)'[v12]; \
[v12][13]overlay=$SAG24QUAD:enable='between(t,151,156)'[v13]; \
[v13][14]overlay=x=840:y=600:enable='between(t,157,158)'[v14]; \
[v14][15]overlay=$SAG24QUAD:enable='between(t,165,194)'[v15]; \
[v15][16]overlay=x=220:y=170:enable='between(t,195,198)'[v16]" \
-map "[v16]" "$VIDEO_OUTPUT_DIR/segment6.mp4"

rsync -auv --progress "$VIDEO_OUTPUT_DIR/segment6.mp4" mothra:/home/eddyod/programming/cerebellum_annotation/media/video/output/
