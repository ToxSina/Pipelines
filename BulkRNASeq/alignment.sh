while read f; do
  [ -z "$f" ] && continue 
  sbatch slurm_alignment ${f}
done<redo.txt
