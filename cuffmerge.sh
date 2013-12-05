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

ls -1 data/mapped/adi/*/transcripts.gtf > data/mapped/adi/assembly_GTF_list.txt
cuffmerge -p 12 -o data/mapped/adi/ data/mapped/adi/assembly_GTF_list.txt
