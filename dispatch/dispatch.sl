#!/bin/bash -l

#SBATCH -p rubin
#SBATCH -N 1
#SBATCH -n 1 
#SBATCH --mem=20G
#SBATCH -t 54:00:00
#SBATCH -J verify
#SBATCH --output=dispatch_w40.%j.log 
#SBATCH --error=dispatch_w40.%j.log 

srun dispatch.sh 
