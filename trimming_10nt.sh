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

#To trim 10 nt from the 3'end:
for x in $(ls -d *clipped.fastq)
do 
echo ${x}
fastx_trimmer -Q 33 -t 10 -m 25 -i ${x} -o $(basename ${x} .fastq)_t10.fastq > /dev/null
done

