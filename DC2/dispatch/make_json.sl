#!/bin/bash -l
#SBATCH -p roma
#SBATCH -N 1
#SBATCH -n 1 
#SBATCH --mem=20G
#SBATCH -t 54:00:00
#SBATCH -J testres
#SBATCH --output=make_json_w_2023_06.%j.log
#SBATCH --error=make_json_w_2023_06.%j.log
#SBATCH --chdir /sdf/group/rubin/sandbox/eiger/metrics_json/
srun gen3_to_job.py '/sdf/group/rubin/repo/dc2/'  '2.2i/runs/test-med-1/w_2023_06/DM-37822'  --dataset_name 'DC2_test-med-1'
