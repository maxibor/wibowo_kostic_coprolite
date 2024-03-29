#!/bin/bash
#SBATCH --job-name=st2     # Job name
#SBATCH --mail-type=END,FAIL         # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=borry@shh.mpg.de # Where to send mail	
#SBATCH --ntasks=1                   # Run a single task
#SBATCH --partition=medium	
#SBATCH --cpus-per-task=6            # Number of CPU cores per task
#SBATCH --mem=500gb                   # Job memory request
#SBATCH --time=47:59:00              # Time limit hrs:min:sec
#SBATCH --output=st2_%j.log     # Standard output and error log

pwd; hostname; date

rm -rf wib_st2
sourcetracker2 gibbs -i /projects1/users/borry/33_marsha_wibowo/wibowo_kostic_coprolite/all_samp_st2.biom \
                     -m /projects1/users/borry/33_marsha_wibowo/wibowo_kostic_coprolite/labels_st2.tsv \
                     -o wib_st2 \
                     --source_rarefaction_depth 11148 \
                     --sink_rarefaction_depth 11148 \
                     --jobs 6
date
