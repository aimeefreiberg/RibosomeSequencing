#!/usr/bin/env bash
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --job-name=SAMtoBAM
#SBATCH --mail-user=aimee.n.freiberg@gmail.com
#SBATCH --mail-type=begin,end,fail#quality check with Ribo-seQC

#add R module
#module add R/3.6.1

# run ribo-seqQC script
#R ribo_seqQC.r
#change directive to where the bam files are


#load packages
install.packages("RiboseQC") #select 63
library("RiboseQC")
install.packages("Rsamtools")
library("Rsamtools")

#load annotated file
bamfile <- system.file("ex1.bam", package="Rsamtools")
bam <- scanBam(bamFile, param=param)

#load in annotation gtf file
annotation <- load_annotation("Rattus_norvegicus.Rnor_6.0.101.gtf")

