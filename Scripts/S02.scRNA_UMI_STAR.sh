############################################
### Tanglab Single-Cell RNA-Seq Pipeline ###
### Author: Zorro Dong                   ###
### Date: 2018-07-25                     ###
############################################

sample=$1

######Reference and scripts######
dir_database=/datg/luping/WORKFLOW/Tanglab_Single_Cell_RNA_Seq/Tanglab_Single_Cell_RNA_Seq_cellranger-mm10-3.0.0/database
dir_scripts=/datg/luping/WORKFLOW/Tanglab_Single_Cell_RNA_Seq/Tanglab_Single_Cell_RNA_Seq_cellranger-mm10-3.0.0/scripts

genomeDir=${dir_database}/star
ref=${dir_database}/fasta/genome.fa
gtf=${dir_database}/genes/genes.gtf
barcode=${dir_scripts}/barcode_96_8bp.txt
trim_script=${dir_scripts}/trim_TSO_polyA.pl
norm_script=${dir_scripts}/scRNA_Normalization.R

#######Tools#######
#/datb1/luping/software/anaconda/envs/Tanglab_Single_Cell_RNA_Seq/bin/umi_tools
umi_tools=umi_tools
#/datb1/luping/software/anaconda/envs/Tanglab_Single_Cell_RNA_Seq/bin/STAR
STAR=STAR
#/datb1/luping/software/anaconda/envs/Tanglab_Single_Cell_RNA_Seq/bin/seqtk
seqtk=seqtk
#/datb1/luping/software/anaconda/envs/Tanglab_Single_Cell_RNA_Seq/bin/featureCounts
featureCounts=featureCounts
#/datb1/luping/software/anaconda/envs/Tanglab_Single_Cell_RNA_Seq/bin/samtools
samtools=samtools
Rscript=/home/software/installed_software/R-3.3.2/bin/Rscript
perl=/usr/bin/perl

######Step3 Mapping With STAR######
$STAR --runThreadN 4 \
     --genomeDir $genomeDir \
     --readFilesIn $sample.R1.clean.fq.gz \
     --readFilesCommand zcat \
     --outFilterMultimapNmax 3 \
     --outFilterMismatchNmax 4 \
     --outFileNamePrefix $sample. \
     --outSAMtype BAM SortedByCoordinate

######Step4 Add feature using featureCounts of subread#######
$featureCounts -a $gtf -o gene_assigned -M -R BAM $sample.Aligned.sortedByCoord.out.bam -T 4

#######Step5 sort and index bam file######
$samtools sort -m 15000000000 $sample.Aligned.sortedByCoord.out.bam.featureCounts.bam -o $sample.assigned_sorted.bam
$samtools index $sample.assigned_sorted.bam && rm $sample.R1.extracted.fq.gz $sample.R1.trim.fq.gz $sample.Aligned.sortedByCoord.out.bam.featureCounts.bam $sample.Aligned.sortedByCoord.out.bam
