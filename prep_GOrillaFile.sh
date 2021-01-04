#!/usr/bin/env bash
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --qos 24h
#SBATCH --job-name=file_adjust
#SBATCH --mail-user=aimee.n.freiberg@gmail.com
#SBATCH --mail-type=begin,end,fail

#remove " from all ensembl gene names
for x in all_genes.txt positivechange_genes.txt negativechange_genes.txt
do
sed -ie 's/"//g' $x
done