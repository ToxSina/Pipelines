__Input required:__
*   FastQ or gzipped FastQ files which are to be placed in a directory called 00_DATA. They need to have the endings .fastq or .fq (or .fastq.gz / .fq.gz if gzipped) and just before that ending a pair identifier (_1 vs _2)
*   List of input file identifiers (basenames): infiles.txt This needs to include one of the identifiers per line. Identifiers are the part of the input file name with the ending and pair identifier removed (so there's one identifier for two paired read inout files)
  
If the input files do not match the naming requirements, they can be renamed using the ```rename.sh``` script. It has to be moved into the directory with the files, so If you do it after setting up the directory structure into 00_DATA, if you do it before into the directory you are storing your raw data in.
The script has of course to be adapted to replace the correct pattern.

__Directories needed to create:__  
00_DATA  
01_RAWQC
02_TRIMMED  
03_TRIMQC  
04_ALIGNED  
05_SORTED  
logs  


(In the future there might be a setup script for this purpose.)

Adapt slurm_alignment to use the appropriate HISAT2 reference.  
Human HG38: ```/rds/project/rds-XUr6B1Jhndg/sb2534_Sina/databases/GRCh38/GRCh38_Hisat2```  
Mouse mm39: ```/rds/project/rds-XUr6B1Jhndg/sb2534_Sina/databases/mouse/current/genome/mm39_Hisat2```  

Adapt slurm_featurecount to use the appropriate gtf file.  
Human HG38: ```/rds/project/rds-XUr6B1Jhndg/sb2534_Sina/databases/GRCh38/Homo_sapiens.GRCh38.104.gtf```  
Mouse mm39: ```/rds/project/rds-XUr6B1Jhndg/sb2534_Sina/databases/mouse/current/genome/Mus_musculus.GRCm39.106.gtf```  

__Run in this order__ (scripts under the same number can be run in parallel, but the previous number has to be finished before starting the next):
1) ```rename.sh``` (if neccessary, put into 00_DATA, adapt and run)
2) ```rawqc.sh``` & ```trimming.sh```
3) ```gzip.sh``` (At this point raw data can be removed if it is already archived on Citrix)
4) ```trimqc.sh``` & ```alignment.sh```
5) ```featureCounts.sh``` (At this point 04_ALIGNED can be removed, as sorted files are smaller and better further on. If you are not going to reuse or archive trimmed files, you can also remove 02_TRIMMED.)
