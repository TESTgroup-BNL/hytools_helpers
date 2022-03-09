#!/bin/bash
#######################################################################################
#SBATCH --job-name=hytools-slurm
#SBATCH --out="hytools_job-%j.out"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --tasks-per-node=1
#SBATCH --mem-per-cpu=16GB
#SBATCH --mail-type=ALL
#######################################################################################

#######################################################################################
### Set script options:
#conda_env=/data2/sserbin/conda_envs/isofit_develop
#conda_env=/data2/sserbin/conda_envs/isofit_develop
conda_env=/data2/sserbin/conda_envs/hytools
#######################################################################################

#######################################################################################
### SLURM usage example
#######################################################################################

#######################################################################################
echo " "
echo "Starting at: " `date`
echo "Job submitted to the ${SLURM_JOB_PARTITION} partition on ${SLURM_CLUSTER_NAME}"
echo "Job name: ${SLURM_JOB_NAME}, Job ID: ${SLURM_JOB_ID}"
echo "There are ${SLURM_CPUS_ON_NODE} CPUs on compute node $(hostname)"

echo "Run started on: " `date`

START=$(date +%s.%N)

### set conda environment, if required. e.g.
# https://github.com/conda/conda/issues/7980
# https://github.com/conda/conda/issues/8536
#
# to find base environment, run "conda info | grep -i 'base environment'"
# replace prefix $conda_base_env with path to conda location
# e.g. conda_base_env=/home/sserbin/miniconda3/
conda_base_env=/home/sserbin/miniconda3/
# for bash
source ${conda_base_env}etc/profile.d/conda.sh
#
# for csh
# source ${conda_base_env}etc/profile.d/conda.csh
# others may also be availible in ${conda_base_env}etc/profile.d/

# load conda environment
conda activate ${conda_env}
python --version
which python

### run workflow and summary script
echo " "
echo "Run Hytools workflow"
#python workflow.py ${1}
#python summarize.py ${1}

python modex_examples/image_correct.py --config ${1}

echo " "
echo "Run completed on: " `date`

END=$(date +%s.%N)
RUNTIME=$(echo "$END - $START" | bc -l)
echo "Total runtime:" ${RUNTIME}
#######################################################################################

### EOF
