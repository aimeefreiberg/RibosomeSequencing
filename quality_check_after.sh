#!/usr/bin/env bash
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --qos 24h
#SBATCH --job-name=ribosome_fastqualitycheck
#SBATCH --mail-user=aimee.n.freiberg@gmail.com
#SBATCH --mail-type=begin,end,fail


#quality check with fastqc after adapter clipping and trimming


#load fastqc module
#UHTS/Quality Control fastqc Version 0.11.7
module add UHTS/Quality_control/fastqc/0.11.7

#run quality check
cd ../clipping/clipped_data

for x in $(ls -d *_f2_tr.fastq)
do
echo $x
fastqc $x
done