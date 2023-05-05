!/bin/bash -l
SBATCH -p roma
SBATCH -N 1
SBATCH -n 1
SBATCH --mem=20G
SBATCH -t 54:00:00
SBATCH -J testres
SBATCH --output=/sdf/home/e/eiger/u/weekly_pipelines/DC2/dispatch/make_json/w_2023_13.%j.log
SBATCH --error=/sdf/home/e/eiger/u/weekly_pipelines/DC2/dispatch/make_json/w_2023_13.%j.log
SBATCH --chdir /sdf/home/e/eiger/u/weekly_pipelines/DC2/dispatch/metrics_json/w_2023_13

srun gen3_to_job.py /sdf/group/rubin/repo/dc2/  "2.2i/runs/test-med-1/w_2023_13/DM-38781" --dataset_name 'DC2_test-med-1'

