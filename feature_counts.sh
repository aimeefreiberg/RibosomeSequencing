#!/usr/bin/env bash
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=1G
#SBATCH --qos 24h
#SBATCH --job-name=annotation
#SBATCH --mail-user=aimee.n.freiberg@gmail.com
#SBATCH --mail-type=begin,end,fail

#try2
#add module
module add UHTS/Analysis/subread/2.0.1

#change directive
cd ../annotated_data/matched_genome/

#get feature counts
featureCounts -t exon -g gene_id -a Rattus_norvegicus.Rnor_6.0.101.gtf -o genome_counts.txt SRR9596300_clipped_t10_f2_tr_no_undesiredRNA_Rnor_6_sorted.bam SRR9596303_clipped_t10_f2_tr_no_undesiredRNA_Rnor_6_sorted.bam SRR9596296_clipped_t10_f2_tr_no_undesiredRNA_Rnor_6_sorted.bam SRR9596295_clipped_t10_f2_tr_no_undesiredRNA_Rnor_6_sorted.bam SRR9596310_clipped_t10_f2_tr_no_undesiredRNA_Rnor_6_sorted.bam SRR9596304_clipped_t10_f2_tr_no_undesiredRNA_Rnor_6_sorted.bam
