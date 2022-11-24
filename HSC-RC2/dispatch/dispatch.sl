#!/bin/bash -l

#SBATCH -p roma
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --mem=20G
#SBATCH -t 24:00:00
#SBATCH -J dispatch
#SBATCH --output=dispatch_w_2022_48.%j.log
#SBATCH --error=dispatch_w_2022_48.%j.log

srun dispatch.sh
