FONT="fontcolor=yellow:fontsize=32:box=1:boxcolor=black@0.5"
BOTTOM="x=(w-text_w)/2:y=h-th-10"
SAG24QUAD="x=1550:y=150"
THREED24QUAD="x=1550:y=590"
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
SEGMENT6_TEXT8="A new layer will appear."
SEGMENT6_TEXT9="Click the layer to access the controls."
SEGMENT6_TEXT10="Go go the segments tab to view the 3D mesh."
SEGMENT6_TEXT11="Click off the polygons and view the 3D mesh on its own."
SEGMENT6_TEXT12="The 3D mesh can be rotated and zoomed in on to view different perspectives of the cerebellum."
SEGMENT6_TEXT13="Turn the polygons back on."
SEGMENT6_TEXT14="Revert to the sagittal, coronal, horizontal and 3D view and move the view around."
SEGMENt6_TEXT15="Maximize the horizontal view"
SEGMENT6_TEXT16="Revert to the sagittal, coronal, horizontal and 3D view and move the view around."
SEGMENT6_TEXT17="Save the view and finish the demonstration"

ffmpeg -y -i "$VIDEO_INPUT_DIR/segment6.mp4" -an -vf \
"
drawtext=text='$SEGMENT6_TEXT1':$FONT:$BOTTOM:enable='between(t,0,3)', \
drawtext=text='$SEGMENT6_TEXT2':$FONT:$BOTTOM:enable='between(t,4,6)', \
drawtext=text='$SEGMENT6_TEXT3':$FONT:$BOTTOM:enable='between(t,7,24)', \
drawtext=text='$SEGMENT6_TEXT4':$FONT:$BOTTOM:enable='between(t,29,36)', \
drawtext=text='$SEGMENT6_TEXT5':$FONT:$BOTTOM:enable='between(t,39,46)', \
drawtext=text='$SEGMENT6_TEXT6':$FONT:$BOTTOM:enable='between(t,51,54)', \
drawtext=text='$SEGMENT6_TEXT7':$FONT:$BOTTOM:enable='between(t,55,65)', \
drawtext=text='$SEGMENT6_TEXT8':$FONT:$BOTTOM:enable='between(t,87,130)', \
drawtext=text='$SEGMENT6_TEXT9':$FONT:$BOTTOM:enable='between(t,135,140)' \
drawtext=text='$SEGMENT6_TEXT10':$FONT:$BOTTOM:enable='between(t,142,148)' \
drawtext=text='$SEGMENT6_TEXT11':$FONT:$BOTTOM:enable='between(t,150,154)' \
drawtext=text='$SEGMENT6_TEXT12':$FONT:$BOTTOM:enable='between(t,156,160)' \
drawtext=text='$SEGMENT6_TEXT13':$FONT:$BOTTOM:enable='between(t,162,164)' \
drawtext=text='$SEGMENT6_TEXT14':$FONT:$BOTTOM:enable='between(t,166,170)' \
drawtext=text='$SEGMENT6_TEXT15':$FONT:$BOTTOM:enable='between(t,172,176)' \
drawtext=text='$SEGMENT6_TEXT16':$FONT:$BOTTOM:enable='between(t,178,184)' \
drawtext=text='$SEGMENT6_TEXT17':$FONT:$BOTTOM:enable='between(t,186,192)' \
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
"[0][1]overlay=$SAG24QUAD:enable='between(t,0,3)'[v1]; \
[v1][2]overlay=$THREED24QUAD:enable='between(t,4,6)'[v2]; \
[v2][3]overlay=x=1512:y=600:enable='between(t,11,13)'[v3]; \
[v3][4]overlay=x=1512:y=150:enable='between(t,21,22)'[v4]; \
[v4][5]overlay=x=888:y=180:enable='between(t,23,24)'[v5]" \
-map "[v5]" "$VIDEO_OUTPUT_DIR/segment6.mp4"
