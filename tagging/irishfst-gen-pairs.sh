#!/bin/sh
FST_PATH="/home/jim/Playing/irishfst-1"
FSTBIN_PATH="$FST_PATH/bin/all.fst"
printf "set quit-on-fail ON \n load $FSTBIN_PATH\n pairs > pairs.tsv\n" | foma
