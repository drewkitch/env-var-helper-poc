#!/bin/bash

ACTION=$1 && shift

case "${ACTION}" in
  cp)
    FILE_LOCATION=$1 && shift
    ENV_FILE=$1
    ruby cp_file.rb $FILE_LOCATION $ENV_FILE
    ;;
  rm)
    echo "I don't do anything at the moment.."
    ;;
  *)
    echo "Usage: $0 {cp|rm}"
    exit 1
esac
