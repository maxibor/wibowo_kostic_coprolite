#!/usr/bin/env bash

#SBATCH --cpus-per-task=6 
#SBATCH --mem=24gb
#SBATCH -p short
#SBATCH -t 01:59:59
#SBATCH -o slurm_log/slurm.%j.log
#SBATCH -e slurm_log/slurm.%j.err
#SBATCH -J pydamage
#SBATCH --array 0-559%6
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=borry@shh.mpg.de 
 
BAM=(/projects1/microbiome_sciences/raw_data/external.backup/wibowo2020/MAG_alignedBAMs/*.bam)

COUTPUT=${BAM[$SLURM_ARRAY_TASK_ID]#"/projects1/microbiome_sciences/raw_data/external.backup/wibowo2020/MAG_alignedBAMs/"}
COUTPUT=${COUTPUT%'.bam'}
CFILE=${BAM[$SLURM_ARRAY_TASK_ID]}

CMD_A="ln -s $CFILE work/$COUTPUT.bam"
CMD_B="samtools sort -@ 6 work/$COUTPUT.bam -o work/$COUTPUT.sorted.bam"
CMD_C="samtools index -@ 6 work/$COUTPUT.sorted.bam work/$COUTPUT.sorted.bam.bai"
CMD_D="pydamage -m 1000 -c 2 --plot -o pydamage_output/$COUTPUT -p 6 work/$COUTPUT.sorted.bam"
# echo ${CMD_A}
# echo ${CMD_B}
# echo ${CMD_C}
echo ${CMD_D}
# $CMD_A
# $CMD_B
# $CMD_C
$CMD_D
