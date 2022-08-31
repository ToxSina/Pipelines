__Input required:__
* List of input file identifiers (basenames): ```infiles.txt```

If the input files do not match the naming requirements, they can be renamed using the ```rename.sh``` script. It has to be moved into the directory with the files, so If you do it after setting up the directory structure into 00_DATA, if you do it before into the directory you are storing your raw data in.
The script has of course to be adapted to replace the correct pattern.

__Directories needed to create:__   
00_DATA  
01_RAWQC  
02_TRIMMED  
03_TRIMQC  
04_FILTER  
05_FILTERQC  
06_ASSEMBLY  
07_SCAFFOLD  
08_WEIGHT  
09_ALIGN  
10_RMA  
11_HOST  
logs  
temp  
TEMP  


This might have to be run in batches (so create batch files from ```infiles.txt```)
by using
```split -d -l <#samples per batch> batch infiles.txt```

Example Host database for slurm_filterHost:  
Human HG38: ```/rds/project/rds-XUr6B1Jhndg/sb2534_Sina/databases/GRCh38/GRCh38_Bowtie2```

__Run in this order__ (scripts under the same number can be run in parallel, but the previous number has to be finished before starting the next):   
1) ```rawqc.sh``` & ```trimming.sh```
2) ```gzip.sh``` (At this point raw data can be removed if it is already archived on Citrix)
3) ```trimqc.sh``` & ```filter.sh```
4) ```filterqc.sh``` & ```assembly.sh```
5) If assemblies don't finish in the 36 hrs: ```reSpades.sh``` (for these infiles, save them in ```redo.txt```)
6) ```scaffold.sh```
7) ```weight.sh```
8) ```align.sh```
9) ```lrrma.sh```




