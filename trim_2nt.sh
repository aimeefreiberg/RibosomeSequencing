#!/usr/bin/env bash
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --qos 24h 
#SBATCH --job-name=trim_10nt 
#SBATCH --mail-user=aimee.n.freiberg@gmail.com
#SBATCH --mail-type=begin,end,fail

#add module
module add UHTS/Analysis/fastx_toolkit/0.0.13.2

#change working directive to clipped data
cd ./clipped_data/

#trim 2 nt from  5' end
for x in $(ls -d *t10.fastq)
do
echo ${x}; fastx_trimmer -Q 33 -f 2 -m 25 -i ${x} -o $(basename ${x} .fastq)_f2_tr.fastq > /dev/null
done