while read f; do
  [ -z "$f" ] && continue 
  sbatch slurm_reSpades ${f}
done<infiles.txt
