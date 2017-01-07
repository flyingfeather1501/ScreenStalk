#!/bin/bash

# init vars
OPTIND=1
nap=10m
save_dir="$HOME/screenstalk"
[[ ! -d $save_dir ]] && mkdir $save_dir

# init functions
print_help_and_exit () {
  echo "Usage: screenstalk.sh [OPTIONS]         "
  echo "Options:                                "
  echo " -t       interval   (default: 10m)     "
  echo " -h       print help (this message)     "
  echo "-t will be asked if not specified"
  exit $1
}

loop_stop () {
  echo
  echo "Interrupt signal received"
  exit 0
}

# getopts
while getopts "t:h?" opt; do
  case "$opt" in
    t) # time / interval
      nap=$OPTARG
      ;;
    h)
      print_help_and_exit 0
      ;;
    *)
  esac
done

trap loop_stop INT

# the loop
i=0
while true; do
  sleep $nap
  if [[ $? == 1 ]]; then
    echo "Invalid interval"
    exit 1
  fi

  screen="$save_dir/$(date +%Y%m%d_%H%M%S)_$i.jpg"
  echo fullpath: $screen

  import -window root $screen

  i=$(( $i + 1 ))
done
