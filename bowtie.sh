#!/bin/bash
#$ -q long
#$ -j y
#$ -cwd
#$ -N tophat
#$ -l h_vmem=20G
#$ -l virtual_free=20G

. $HOME/.bashrc

export TEMPDIR=/genefs/MikheyevU/temp
export TEMP=/genefs/MikheyevU/temp
export TMP=/genefs/MikheyevU/temp

a=(trimmed/adi/*_trimmed_1.fastq.gz)
b=(trimmed/adi/*_trimmed_2.fastq.gz)
base=$(basename ${a["SGE_TASK_ID"-1]} "_trimmed_1.fastq.gz")
f=${a["SGE_TASK_ID"-1]}
r=${b["SGE_TASK_ID"-1]}

tophat2 --b2-very-sensitive -z pigz --G ref/aug_repeatmask_pasa_input.gff3 -p 8 -o data/mapped/adi/$base ref/adi_genome $f $r 