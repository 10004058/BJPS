#!/bin/sh
#SBATCH --job-name emdeddings-extraction        # this is a parameter to help you sort your job when listing it
#SBATCH --ntasks 1                              # number of tasks in your job. One by default
#SBATCH --cpus-per-task 1                       # number of cpus for each task. One by default
#SBATCH --partition shared-gpu                  # the partition to use. By default debug-cpu
#SBATCH --gres=gpu:1,,VramPerGpu:10GB           # Request 1 GPU
#SBATCH --time 12:00:00                         # maximum run time.a
#SBATCH --mem=32G
#SBATCH --nodelist=								# update the node name
ID=500
cd /home/users/ 								# update the path
ml GCCcore/12.3.0 Python/3.11.3                 # load a Python 3.11.3
# Activate virtual environment
source /home/users/ 							# update the path
# Start the server in the background
ollama serve > ollama_generation_${ID}.log 2>&1 &
# Give the server a few seconds to start
sleep 10
# Run your Python client with the ID
srun --ntasks=1 python kg-generation.py --id $ID
# Deactivate virtual environment
deactivate