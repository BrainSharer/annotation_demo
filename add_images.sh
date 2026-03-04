echo "Adding images"


ffmpeg -i ./videos/output_video.mp4 -i left-arrow.png -i left-arrow.png -i right-arrow.png -i left-arrow.png \
-filter_complex \
"[0][1]overlay=x=315:y=280:enable='between(t,24,36)'[v1]; \
[v1][2]overlay=x=298:y=122:enable='between(t,40,42)'[v2]; \
[v2][3]overlay=x=1600:y=144:enable='between(t,42,44)'[v3]; \
[v3][4]overlay=x=360:y=100:enable='between(t,59,61)'[v4]" \
-map "[v4]" ./videos/output_arrows.mp4
	
 
