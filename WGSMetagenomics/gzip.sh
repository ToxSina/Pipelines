while read f; do
  [ -z "$f" ] && continue 
  sbatch slurm_gzip 02_TRIMMED/${f}.trimmed_1.fastq
  sbatch slurm_gzip 02_TRIMMED/${f}.trimmed_2.fastq
done<infiles.txt
