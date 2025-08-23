#!/usr/bin/env bash

cols=$(tput cols)
lines=$(tput lines)

trap "tput cnorm; clear; exit" INT
tput civis

num_flakes=$((cols / 2))
for ((i=0; i<num_flakes; i++)); do
    x=$((RANDOM % cols))
    y=$((RANDOM % lines))
    flakes_x[i]=$x
    flakes_y[i]=$y
done

while true; do
    for ((i=0; i<num_flakes; i++)); do
        tput cup "${flakes_y[i]}" "${flakes_x[i]}"
        printf " "
        flakes_y[i]=$(( (flakes_y[i] + 1) % lines ))
        drift=$((RANDOM % 3 - 1))
        flakes_x[i]=$(( (flakes_x[i] + drift + cols) % cols ))
        tput cup "${flakes_y[i]}" "${flakes_x[i]}"
        printf "."
    done
    sleep 0.03
done
