while read f; do
  [ -z "$f" ] && continue 
  sbatch slurm_weight ${f}
done<infiles.txt
