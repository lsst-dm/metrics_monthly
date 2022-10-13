#!/bin/bash -l

#SBATCH -p rubin
#SBATCH -N 1
#SBATCH -n 1 
#SBATCH --mem=20G
#SBATCH -t 54:00:00
#SBATCH -J verify
#SBATCH --output=make_json_w40.%j.log 
#SBATCH --error=make_json_w40.%j.log 
#SBATCH --chdir /sdf/group/rubin/sandbox/hchiang2/metrics_json/w_2022_40

srun gen3_to_job.py /sdf/group/rubin/repo/main_20210215/  "HSC/runs/RC2/w_2022_40/DM-36356" --dataset_name 'HSC_RC2'

