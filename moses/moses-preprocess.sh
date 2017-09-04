#!/bin/bash

MOSESDIR=/home/jim/Playing/mosesdecoder
LANG=$1

perl $MOSESDIR/scripts/tokenizer/tokenizer.perl -l $LANG | perl $MOSESDIR/scripts/tokenizer/lowercase.perl | perl scripts/tokenizer/replace-unicode-punctuation.perl
