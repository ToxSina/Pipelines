while read f; do
  [ -z "$f" ] && continue 
  sbatch slurm_index ${f}
done<infiles.txt
