__Input required:__
* List of input file identifiers (basenames): ```infiles.txt```
* List of non-normal identifiers (not controls): ```nonnormal.txt```
* List of normals for creating a Panel Of Normals if needed: ```pons.list``` (must include file path at least relative, so 06_PON/...)
* For filtering out the variants passing filter, ```pysam``` needs to be installed (it's easiest to have it in a conda environment and use ```conda activate pysam```)!

If the input files do not match the naming requirements, they can be renamed using the ```rename.sh``` script. It has to be moved into the directory with the files, so If you do it after setting up the directory structure into 00_DATA, if you do it before into the directory you are storing your raw data in.
The script has of course to be adapted to replace the correct pattern.

__Directories needed to create:__   
00_DATA  
01_RAWQC  
02_TRIMMED  
03_TRIMQC  
04_ALIGNED  
05_SORTED  
06_PON  
07_MUTECT  
08_FILTERED  
logs  


(In the future there might be a setup script for this purpose.)

Replace appropriate Bowtie2 reference in slurm_alignment:  
Mouse mm28 (not current): ```/rds/project/rds-XUr6B1Jhndg/sb2534_Sina/databases/mm28/mm10_bowtie2```  
Human hs38: ```/rds/project/rds-XUr6B1Jhndg/sb2534_Sina/databases/GRCh38/GRch38_Bowtie2```  

Replace appropriate FASTA reference in slurm_mutect and slurm_mutectFilter:  
Mouse mm28 (not current): ```/rds/project/rds-XUr6B1Jhndg/sb2534_Sina/databases/mm28/Mus_musculus.GRCm38.dna.toplevel.fa```  
Human hs38: ```/rds/project/rds-XUr6B1Jhndg/sb2534_Sina/databases/GRCh38/Homo_sapiens.GRCh38.dna.primary_assembly.fa```  

__Run in this order__ (scripts under the same number can be run in parallel, but the previous number has to be finished before starting the next):  
1) ```rawqc.sh``` & ```trimming.sh```
2) ```gzip.sh``` (At this point raw data can be removed if it is already archived on Citrix)
3) ```trimqc.sh``` & ```alignment.sh```
4) ```index.sh``` 
5) Only if creating new PON: ```mutect_pons.sh```, then ```sbatch slurm_multivcf```, then ```sbatch slurm_pon```
6) ```mutect_nonnormal.sh```
7) ```filter.sh```
8) ```passed.sh```

Further analysis: Run passed vcfs through the ENSEMBL VEP (Variant Effect Predictor)
