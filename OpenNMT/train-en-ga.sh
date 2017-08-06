DATA=/home/jim/bitext
. /home/jim/torch/install/bin/torch-activate

th train.lua -layers 4 -rnn_size 1000 -brnn -word_vec_size 600 -data ${DATA}/enga-out-train.t7 \
	    -save_model ${DATA}/onmt_enga-4-1000-600 -gpuid 1

