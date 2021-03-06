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

a=(data/trimmed/adi/*_trimmed_1.fastq) #18
b=(data/trimmed/adi/*_trimmed_2.fastq)
base=$(basename ${a["SGE_TASK_ID"-1]} "_trimmed_1.fastq")
f=${a["SGE_TASK_ID"-1]}
r=${b["SGE_TASK_ID"-1]}

tophat2 --b2-very-sensitive -z pigz -p 8 -o data/mapped/adi/$base ref/adi_genome $f $r 