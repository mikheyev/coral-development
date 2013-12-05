#!/bin/bash
#$ -q long
#$ -j y
#$ -cwd
#$ -N cuff
#$ -l h_vmem=20G
#$ -l virtual_free=20G

. $HOME/.bashrc

export TEMPDIR=/genefs/MikheyevU/temp
export TEMP=/genefs/MikheyevU/temp
export TMP=/genefs/MikheyevU/temp

a=(data/mapped/adi/*/accepted_hits.bam) #18
b=$(dirname ${a["SGE_TASK_ID"-1]})

cufflinks -p 12 -o $b ${a["SGE_TASK_ID"-1]}
