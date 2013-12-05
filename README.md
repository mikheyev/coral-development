# An investigation of regulatory changes during the larval development of the coral *Acropora digitifera*


The bioinformatic pipeline for read mapping, and extracting counts goes as follows. The [output](https://github.com/mikheyev/coral-development/tree/master/output) folde contains informative output form the various stages of the analysis and the gene count files. The [ref](https://github.com/mikheyev/coral-development/tree/master/ref) folder contains only a list of gene to isoform associations.

## trim.sh
   - adaptor and quality trimming
   
## tophat.sh 
   - Perform Reference Annotation Based Transcript (RABT) assembly using tophat2

## cufflinks.sh
   - Assemble transcripts from mapped reads 

## cuffmerge.sh
   - Merge cufflinks assemblies

Now we have to associate official gene names with our cufflinks transcripts. This would have been easier, if the gff on the [Marine Genomics](http://marinegenomics.oist.jp/genomes/downloads?project_id=3) web site was correct, as we could have used it directly in the tophat/cufflinks pipeline. Instead, it seems to refer to an earlier assembly version. So, we use blast to match up our transcripts with the canonical gene annotations.

	cd ref
	makeblastdb -in adi_v1.0.1.cdna.fa -out adi_v1.0.1.cdna -dbtype nucl
	blastn -query adi_cufflinks_transcripts.fa -db adi_v1.0.1.cdna -outfmt 6 -max_target_seqs 1 -num_threads 6  > gene_names.txt
	cd ..
	python rename.py 

Make rsem reference using official gene ids added to fasta files, and isoform inferred by cufflinks.

	cd ref
	rsem-prepare-reference --transcript-to-gene-map transcript-to-gene-map.txt --no-polyA adi_cufflinks_transcripts_renamed.fa adi_cufflinks_transcripts_renamed
	cd ..

## rsem.sh
   - Re-map reads to extracted transcripts using RSEM

Collect isoform and gene counts using **collect.py**

	python collect.py genes data/mapped/adi/rsem/ | gzip > output/adi_gene_counts.csv.gz
	python collect.py isoforms data/mapped/adi/rsem/ | gzip > output/adi_isoform_counts.csv.gz

