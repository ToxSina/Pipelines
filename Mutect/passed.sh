while read f; do
  [ -z "$f" ] && continue 
  sbatch slurm_passing ${f}
done<nonnormal.txt
