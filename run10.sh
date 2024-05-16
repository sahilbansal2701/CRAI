#!/bin/bash

# Function to run the command and measure time
measure_time() {
    local arg1=$1
    start=$(date +%s%N)         # Start time in nanoseconds
    ./$arg1 < input > output.txt
    end=$(date +%s%N)           # End time in nanoseconds
    elapsed=$((end-start))      # Elapsed time in nanoseconds
    echo $elapsed               # Print nanoseconds
}

avg_time() {
    local arg1=$1
    # Run the command and measure time 10 times
    total_nanoseconds=0
    for ((i=1; i<=10; i++)); do
        result=$(measure_time "$arg1")
        total_nanoseconds=$((total_nanoseconds + result))
    done

    # Calculate and print the average time in nanoseconds
    average_nanoseconds=$((total_nanoseconds / 10))
    echo "$arg1 Average Time: $average_nanoseconds nanoseconds"

    for ((i=1; i<=10; i++))
    do
        output=$(time ./"$arg1" < input > output.txt)
    done
}

avg_time "vcat0"
avg_time "vcat0_aesv1"
avg_time "vcat0_aesv2"
avg_time "vcat0_aesv3"
avg_time "vcat0_aesv4"

avg_time "vcat0"
avg_time "vcat0_aesv1"
avg_time "vcat0_aesv2"
avg_time "vcat0_aesv3"
avg_time "vcat0_aesv4"









