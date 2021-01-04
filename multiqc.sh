#!/usr/bin/env bash
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --qos 24h
#SBATCH --job-name=multiqc
#SBATCH --mail-user=aimee.n.freiberg@gmail.com
#SBATCH --mail-type=begin,end,fail

#overview of data quality of all samples 

#add module
module add UHTS/Analysis/MultiQC/1.8

#change directive
cd ./output_qualitycheck

#combine quality info
multiqc *.zip 