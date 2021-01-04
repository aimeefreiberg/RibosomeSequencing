#!/usr/bin/env bash
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=1G
#SBATCH --qos 24h
#SBATCH --job-name=build_index
#SBATCH --mail-user=aimee.n.freiberg@gmail.com
#SBATCH --mail-type=begin,end,fail



#build indexes for annotation
#add modules
module add UHTS/Aligner/bowtie/1.2.0

#index remove RNA
bowtie-build annotation_undesired_RNA.fasta index_undesired_RNA


#index genome
bowtie-build Rattus_norvegicus.Rnor_6.0.dna.toplevel.fa index_genome