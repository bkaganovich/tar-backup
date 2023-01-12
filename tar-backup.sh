#!/bin/bash

# File: tar-backup.sh
# Version: 0.6
# Updated: Thu 12 Jan 2023 20:15:17 IST

# Create gzip tarball archive backup of specified directories and files.

# Usage: ./tar-backup.sh -a <archive-name> -i <input-directory> -o <output-directory>

check_input_dir(){
    # check if input dir variable is empty
    if [ -z "$inputdir" ]; then
        if [ $# -eq 0 ] #no arg vars, manual mode
        then
            #enter path of target input dirs
            read -p "Enter full path of target input dir: " inputdir
        fi
    fi
    # check if input dir exists
    if [ ! -d "$inputdir" ]; then
        echo "Error: $inputdir is not a valid directory. Please make sure the input directory exists."
        exit 1
    fi

    # Check if the input directory is writable
    if [ ! -w "$inputdir" ]; then
        echo "Error: $inputdir is not writable."
        exit 1
    fi
}

check_archive_name(){
    # check if archive variable is empty
    if [ -z "$archive" ]; then
        if [ $# -eq 0 ] #no arg vars, manual mode
        then
            #enter archive name
            read -p "Enter archive name: " archive
        fi
    fi
}

check_output_dir(){
    #prompt for output backup dir
    read -p "Change output directory? [y/n] (default: $HOME/backups/) " choice

    if [ "$choice" == "y" ] || [ "$choice" == "Y" ];
    then
        read -p "Enter full path for output dir: " outputdir
    fi
}

create_output_dir(){
    #archive operation
    if [ ! -d "$outputdir" ]; then
    echo "backups directory does not exist. Creating it now..."
    mkdir -p $outputdir
    fi
}

# Default output backup dir (ending with /):
outputdir="$HOME/backups/"

#timestamp format yyyy.mm.dd.hhmmss
today=$(date +'%Y.%m.%d.%H%M%S')

while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -a)
        archive="$2"
        shift 2
        ;;
        -i)
        inputdir="$2"
        shift 2
        ;;
        -o)
        outputdir="$2"
        shift 2
        ;;
        -h|--help)
        echo "Usage: ./tar-backup.sh -a <archive-name> -i <input-directory> -o <output-directory>"
        exit 0
        ;;
        *)
        echo "Unknown option: $key"
        echo "Usage: ./tar-backup.sh -a <archive-name> -i <input-directory> -o <output-directory>"
        exit 1
        ;;
    esac
done

check_input_dir
check_archive_name
check_output_dir
create_output_dir

cd $outputdir
filename="$archive-$today.tar.gz"

printf "\nCompressing...\n"

tar -C $inputdir -czf $filename .

#result
printf "\nCreated $outputdir$filename\n"

#timer
duration=$SECONDS
hours=$(($duration / 3600))
duration=$(($duration % 3600))
minutes=$(($duration / 60))
seconds=$(($duration % 60))
echo "Completed in $hours hour(s), $minutes minute(s), and $seconds second(s)."