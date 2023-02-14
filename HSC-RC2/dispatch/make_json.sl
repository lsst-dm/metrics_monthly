#!/bin/bash -l

#SBATCH -p roma
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --mem=20G
#SBATCH -t 24:00:00
#SBATCH -J verify
#SBATCH --output=/fs/ddn/sdf/group/rubin/sandbox/hchiang2/metrics_json/make_json_w_2023_03.%j.log
#SBATCH --error=/fs/ddn/sdf/group/rubin/sandbox/hchiang2/metrics_json/make_json_w_2023_03.%j.log
#SBATCH --chdir /fs/ddn/sdf/group/rubin/sandbox/hchiang2/metrics_json/w_2023_03

srun gen3_to_job.py /sdf/group/rubin/repo/main_20210215/  "HSC/runs/RC2/w_2023_03/DM-37570" --dataset_name 'HSC_RC2'

