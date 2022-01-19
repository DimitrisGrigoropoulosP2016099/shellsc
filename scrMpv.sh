#!/bin/bash
#P2016099

FirstOpt="video noVideo exit"
SecondOpt="record No"

select option in $FirstOpt; do
    if [ "$option" == "video" ]; then
        echo -n "search: "
        read -r search
        id="$(youtube-dl ytsearch:"$search" --get-id)"
        link="https://www.youtube.com/watch?v=${id}"
        select opt in $SecondOpt; do
            if [ "$opt" == "record" ]; then
                echo -n "Name file: "
                read -r name
                echo "Now playing "$(youtube-dl "$link" --get-title)""
                mpv --cache=yes --stream-record="$name".mkv --ytdl-format=bestvideo[height "$link" <=?1080]+bestaudio/best
                break
            elif [ "$opt" == "No" ]; then
                echo " Now playing "$(youtube-dl "$link" --get-title)""
                mpv --cache=yes --ytdl-format=bestvideo[height "$link" <=?1080]+bestaudio/best
                break
            fi
        done
    elif [ "$option" == "noVideo" ]; then
        echo -n "search: "
        read -r search
        id="$(youtube-dl ytsearch:"$search" --get-id)"
        link="https://www.youtube.com/watch?v=${id}"
        select opt in $SecondOpt; do
            if [ "$opt" == "record" ]; then
                echo -n "Name file: "
                read -r name
                echo "Now playing "$(youtube-dl "$link" --get-title)""
                mpv --cache=yes --video=no --stream-record="$name".mkv --ytdl-format=bestaudio/best "$link"
                break
            elif [ "$opt" == "No" ]; then
                echo "Now playing "$(youtube-dl "$link" --get-title)""
                mpv --cache=yes --video=no --ytdl-format=bestaudio/best "$link"
                break
            fi
        done
    elif [ "$option" == "exit" ]; then
        break
    fi
done
