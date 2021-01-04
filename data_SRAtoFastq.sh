#!/usr/bin/env bash
# data download and preparation

#!/usr/bin/env bash
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=0-01:00:00
#SBATCH --job-name=ribosome_SRAtoFastqc
#SBATCH --mail-user=aimee.freiberg@gmail.com
#SBATCH --mail-type=begin,end,fail


# after downloading SRA files convert them into fastqfiles
#add the module  UTHS Analysis sratoolkit version 2.10.7
module add UHTS/Analysis/sratoolkit/2.10.7;

#run conversion to fastqc files for later fastqc data analysis
cd ./SRA_Files

fasterq-dump SRR9596295 SRR9596296 SRR9596303 SRR9596310 SRR9596300 SRR9596295

#created files were transfered to Fastq_files folder