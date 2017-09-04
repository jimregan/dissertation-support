#!/bin/bash

MOSESDIR=/home/jim/Playing/mosesdecoder
LANG=$1
SCRDIR=$(dirname "$0")

if [ $1 = "en" ]
then
        LWR="perl $MOSESDIR/scripts/tokenizer/lowercase.perl"
else
        LWR="bash $SCRDIR/tolower.sh"
fi

perl $MOSESDIR/scripts/tokenizer/tokenizer.perl -l $LANG | $LWR | perl scripts/tokenizer/replace-unicode-punctuation.perl
