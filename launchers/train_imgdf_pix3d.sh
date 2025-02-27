
RED='\033[0;31m'
NC='\033[0m' # No Color

gpu=1
lr=1e-4

nepochs=10000
nepochs_decay=100

# model stuff
model='imgdf'
cat='chair'

vq_model='pvqvae'
vq_cfg='configs/pvqvae_snet.yaml'
vq_ckpt='saved_ckpt/pretrained-pvqvae.pth'
vq_dset='pix3d'
vq_cat='all'

# dataset stuff
batch_size=16
max_dataset_size=10000000
dataset_mode='pix3d_img'
trunc_thres=0.2

display_freq=300
print_freq=300

today=$(date '+%m%d')
me=`basename "$0"`
me=$(echo $me | cut -d'.' -f 1)

note='bs16-test'

name="${model}-${dataset_mode}-${cat}-LR${lr}-${note}"

debug=0
if [ $debug = 1 ]; then
    printf "${RED}Debugging!${NC}\n"
	batch_size=6
	max_dataset_size=24
    nepochs=400
    nepochs_decay=0
	update_html_freq=1
	display_freq=100
	print_freq=1
    name="DEBUG-${name}"
fi

CUDA_LAUNCH_BLOCKING=1 python train.py --name ${name} --gpu_ids ${gpu} --lr ${lr} --batch_size ${batch_size} \
                --model ${model} \
                --vq_model ${vq_model} --vq_cfg ${vq_cfg} --vq_ckpt ${vq_ckpt} --vq_dset ${vq_dset} --vq_cat ${vq_cat} \
                --nepochs ${nepochs} --nepochs_decay ${nepochs_decay} \
                --dataset_mode ${dataset_mode} --cat ${cat} --max_dataset_size ${max_dataset_size} --trunc_thres ${trunc_thres} \
                --display_freq ${display_freq} --print_freq ${print_freq} \
                --debug ${debug}
