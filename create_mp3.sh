rm -vf *.mp3

for i in *.txt
do
mp3file=$(echo "$i" | sed 's/txt/mp3/g')
#echo $mp3file
piper.sh $i --name $mp3file
done
