#!/bin/bash
#SBATCH -p meta_gpu-x                                   # partition (queue) (test_cpu-ivy, ml_cpu-ivy, meta_gpu-ti, gpu_tesla-P100, meta_gpu-black, ml_gpu-rtx2080)
#SBATCH --mem 8000                                      # memory pool for all cores
#SBATCH -t 2-00:00                                      # time (D-HH:MM)
#SBATCH -N 1                                            # number of nodes
#SBATCH -c 2                                            # number of cores
#SBATCH -a 1-2                                          # array size
#SBATCH --gres=gpu:1                                    # reserves one GPU
#SBATCH -o logs/bench_cluster/%x.%N.%j.out              # STDOUT  (the folder log has to be created prior to running or this won't work)
#SBATCH -e logs/bench_cluster/%x.%N.%j.err              # STDERR  (the folder log has to be created prior to running or this won't work)
#SBATCH -J openml_learning_curves                       # sets the job name. If not specified, the file name will be used as job name
# Print some information about the job to STDOUT
echo "Workingdir: $PWD";
echo "Started at $(date)";
echo "Running job $SLURM_JOB_NAME using $SLURM_JOB_CPUS_PER_NODE cpus per node with given JID $SLURM_JOB_ID on queue $SLURM_JOB_PARTITION"; 

# Activate venv
source env/bin/activate

# Array jobs 
python3 run_openml_task.py --run_id $SLURM_ARRAY_TASK_ID

# Done
echo "DONE";
echo "Finished at $(date)";