#!/bin/bash
OPTIND=1

print_help () {
  echo "Usage: screenstalk.sh [OPTIONS]         "
  echo "Options:                                "
  echo " -t       interval in minutes           "
  echo " -h       print help (this message)     "
  echo "-t and -n will be asked if not specified"
}

while getopts "t:h?" opt; do
  case "$opt" in
    t) # time / interval
      napset=1
      nap=$OPTARG
      ;;
    h)
      print_help
      ;;
    *)
  esac
done

[[ ! $napset == 1 ]] && read -p "Enter number of minutes between screen captures:" nap

ne=$(( nap * 60 ))

save_dir="$HOME/screenstalk"

if [ ! -d $save_dir ]
then
  mkdir $save_dir 
fi

i=0
while true
do

  screen="$save_dir/$(date +%Y%m%d_%H%M%S)_$i.jpg"
  echo fullpath: $screen

  import -window root $screen 

  sleep $ne 
  i=$(( $i + 1 ))
done
