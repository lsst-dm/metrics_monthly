#!/bin/bash -l
#SBATCH -p roma
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --mem=20G
#SBATCH -t 54:00:00
#SBATCH --output=resource_usage.%j.log
#SBATCH --error=resource_usage.%j.log
srun resource_usage.sh