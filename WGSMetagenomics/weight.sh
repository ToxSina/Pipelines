while read f; do
  [ -z "$f" ] && continue 
  sbatch slurm_weight ${f}
done<lastOne.txt
