DATA=/home/jim/bitext
. /home/jim/torch/install/bin/torch-activate
th preprocess.lua -train_src ${DATA}/all.en.bpetok -train_tgt ${DATA}/all.ga.bpetok \
    -valid_src ${DATA}/valid2k.en.bpetok -valid_tgt ${DATA}/valid2k.ga.bpetok\
    -save_data ${DATA}/enga-out
