#!/bin/bash
#$ -q long
#$ -j y
#$ -cwd
#$ -l h_vmem=10G
#$ -l virtual_free=10G
#$ -N trim
. $HOME/.bashrc
export TEMPDIR=/genefs/MikheyevU/temp
export TMPDIR=/genefs/MikheyevU/temp
export TEMP=/genefs/MikheyevU/temp
export TMP=/genefs/MikheyevU/temp

a=(rawdata/adi/*_1.fastq)
b=(rawdata/adi/*_2.fastq)
base=$(basename ${a["SGE_TASK_ID"-1]} "_1.fastq")
f=${a["SGE_TASK_ID"-1]}
r=${b["SGE_TASK_ID"-1]}

java -Xmx9g -jar /apps/MikheyevU/sasha/trimmomatic/trimmomatic-0.32.jar PE -phred33 $f $r trimmed/adi/$base"_trimmed_1.fastq.gz" trimmed/adi/$base"_trimmed_u1.fastq.gz" trimmed/adi/$base"_trimmed_2.fastq.gz" trimmed/adi/$base"_trimmed_u2.fastq.gz" ILLUMINACLIP:/apps/MikheyevU/sasha/trimmomatic/adapters/RNA-seq-Nextera.fa:2:30:10 LEADING:20 MAXINFO:30:0.8 MINLEN:30