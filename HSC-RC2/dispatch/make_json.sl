#!/bin/bash -l

SBATCH -p roma
SBATCH -N 1
SBATCH -n 1
SBATCH --mem=20G
SBATCH -t 24:00:00
SBATCH -J verify
SBATCH --output=/sdf/home/e/eiger/u/weekly_pipelines/HSC-RC2/dispatch/make_json/w_2023_11.%j.log
SBATCH --error=/sdf/home/e/eiger/u/weekly_pipelines/HSC-RC2/dispatch/make_json/w_2023_11.%j.log
SBATCH --chdir /sdf/home/e/eiger/u/weekly_pipelines/HSC-RC2/dispatch/metrics_json/w_2023_11

srun gen3_to_job.py /sdf/group/rubin/repo/main/  "HSC/runs/RC2/w_2023_11/DM-38360" --dataset_name 'HSC_RC2'

