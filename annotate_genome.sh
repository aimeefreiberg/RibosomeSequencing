#!/usr/bin/env bash
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=1G
#SBATCH --qos 24h
#SBATCH --job-name=annotation
#SBATCH --mail-user=aimee.n.freiberg@gmail.com
#SBATCH --mail-type=begin,end,fail

#genome annotation

# add modules
module add UHTS/Aligner/bowtie/1.2.0
module add UHTS/Analysis/samtools/1.8

cd ./unwanted_RNA_removed

#Mapping the files to genome (after removing the rRNA etc)
for x in $(ls -d *no_undesiredRNA.fastq)
do 
echo ${x}
bowtie -S -t -p 4 -v 1 -m 1 --best --strata /data/users/afreiberg/Ribosome_sequencing/data_annotation_files/index_genome -q ${x} 2> $(basename ${x} .fastq)_Rnor_6.log | samtools view -h -F 4 -b > $(basename ${x} .fastq)_Rnor_6.bam
done


