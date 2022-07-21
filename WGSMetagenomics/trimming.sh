while read f; do
  [ -z "$f" ] && continue 
  sbatch slurm_trimming ${f}
done<infiles.txt
