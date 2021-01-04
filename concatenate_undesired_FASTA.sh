#!/usr/bin/env bash
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --job-name=fastafile_concatenation
#SBATCH --mail-user=aimee.n.freiberg@gmail.com
#SBATCH --mail-type=begin,end,fail

#concatenate annotation files for 'undesired' RNAs
cat Rn45s.fasta Rn28s.fasta Rn45s.fasta Rn5-8s.fasta Rn5s.fasta rn6-rRNA_snRNA_snoRNA.fasta rn6-tRNAs.fasta > annotation_undesired_RNA.fasta
