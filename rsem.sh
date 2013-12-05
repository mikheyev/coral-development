#!/bin/bash
#$ -q long
#$ -j y
#$ -cwd
#$ -l h_vmem=30G
#$ -l virtual_free=30G
#$ -N rs
. $HOME/.bashrc
export TEMPDIR=/genefs/MikheyevU/temp
export TMPDIR=/genefs/MikheyevU/temp
export TEMP=/genefs/MikheyevU/temp
export TMP=/genefs/MikheyevU/temp

a=(data/trimmed/adi/*_trimmed_1.fastq) #18
b=(data/trimmed/adi/*_trimmed_2.fastq)
base=$(basename ${a["SGE_TASK_ID"-1]} "_trimmed_1.fastq")
f=${a["SGE_TASK_ID"-1]}
r=${b["SGE_TASK_ID"-1]}

rsem-calculate-expression -p 12 --bowtie-n 3 --paired-end $f $r ref/adi_cufflinks_transcripts_renamed data/mapped/adi/rsem/$base
