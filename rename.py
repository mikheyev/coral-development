from Bio import SeqIO
import pdb
# add official gene names to transcripts. Create map from genes to isoforms

names = {} #transcript[gene name]
for line in open("ref/gene_names.txt"):
	line =line.split()
	names[line[0]] = line[1]

outfile = open("ref/adi_cufflinks_transcripts_renamed.fa","w") # output fasta
transfile = open("ref/transcript-to-gene-map.txt","w") # gene to isoform map
for rec in SeqIO.parse("ref/adi_cufflinks_transcripts.fa","fasta"):
	isoform_name = rec.description.split("=")[1]
	if rec.id in names:
		rec.id = isoform_name
		rec.description = rec.id
	else:
		rec.description = rec.id
		rec.id = isoform_name		
	SeqIO.write(rec,outfile,"fasta")
	transfile.write("%s\t%s\n" % (rec.description, rec.id))

