#!/usr/bin/env bash
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --qos 24h 
#SBATCH --job-name=clip_adapter
#SBATCH --mail-user=aimee.n.freiberg@gmail.com
#SBATCH --mail-type=begin,end,fail


#clipping adaptor of raw fastq files

#add the fastx module
module add UHTS/Analysis/fastx_toolkit/0.0.13.2;

#clip adaptor from raw FASTQ files
cd ../rawdata/Fastq_files/

for x in $(ls -d *.fastq)
do 
echo ${x}
fastx_clipper -Q 33 -a AGATCGGAAGAGCAC -v -c -l 25 -i ${x} -o $(basename ${x} .fastq)_clipped.fastq > /dev/null
done