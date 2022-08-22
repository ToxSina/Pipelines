while read f; do
  [ -z "$f" ] && continue 
  sbatch slurm_filterHost ${f}
done<infiles.txt
