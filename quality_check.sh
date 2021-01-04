#!/usr/bin/env bash
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --job-name=ribosome_fastqualitycheck
#SBATCH --mail-user=aimee.n.freiberg@gmail.com
#SBATCH --mail-type=begin,end,fail




#quality check with fastqc


#load fastqc module
#UHTS/Quality Control fastqc Version 0.11.7
module add UHTS/Quality_control/fastqc/0.11.7

#run quality check
cd ../rawdata/Fastq_files/
fastqc SRR9596295.fastq SRR9596296.fastq SRR9596300.fastq SRR9596303.fastq SRR9596304.fastq SRR9596310.fastq