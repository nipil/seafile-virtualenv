#!/bin/bash

[ $# -ne 2 ] && exit
[[ "$1" == "seafile.sh" || "$1" == "seahub.sh" ]] || exit
[[ "$2" == "start" || "$2" == "stop" || "$2" == "restart" ]] || exit

BASE=seafile_dir
source $BASE/venv/bin/activate
$BASE/seafile-server-latest/$1 $2
