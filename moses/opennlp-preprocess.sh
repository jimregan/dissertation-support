#!/bin/bash

OPENNLP_PATH=/tmp/apache-opennlp-1.8.1
SCRDIR=$(dirname "$0")
OPENNLP_MODELS=$SCRDIR
OPENNLP=$OPENNLP_PATH/bin/opennlp
MOSESDIR=/home/jim/Playing/mosesdecoder

if [ $1 = "en" ]
then
	TOK=$OPENNLP_MODELS/en-token.bin
	POS=$OPENNLP_MODELS/en-pos-maxent.bin
	LWR="perl $MOSESDIR/scripts/tokenizer/lowercase.perl"
else
	TOK=$OPENNLP_MODELS/ga-token.bin.zip
	POS=$OPENNLP_MODELS/ga-pos-maxent.zip
	LWR="bash $SCRDIR/tolower.sh"
fi

$OPENNLP TokenizerME $TOK |grep -v '^Execution time:' | $LWR | perl scripts/tokenizer/replace-unicode-punctuation.perl

