#!/usr/bin/env bash
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=1G
#SBATCH --qos 24h
#SBATCH --job-name=annotation
#SBATCH --mail-user=aimee.n.freiberg@gmail.com
#SBATCH --mail-type=begin,end,fail

#removing unwanted RNA and annotating

# add modules
module add UHTS/Aligner/bowtie/1.2.0

#remove unwanted RNA
cd ../clipping/clipped_data/
for x in $(ls -d *t10_f2_tr.fastq)
do 
echo ${x}
bowtie -S -t -p 4 /data/users/afreiberg/Ribosome_sequencing/data_annotation_files/index_undesired_RNA ${x} --un $(basename ${x} .fastq)_no_undesiredRNA.fastq 2> $(basename ${x} .fastq)_no_undesiredRNA.log > /dev/null
done