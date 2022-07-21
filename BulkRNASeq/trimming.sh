while read f; do
  [ -z "$f" ] && continue 
  sbatch slurm_trimming ${f}
done<redo.txt
