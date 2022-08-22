while read f; do
  [ -z "$f" ] && continue 
  sbatch slurm_filterqc ${f}
done<infiles.txt
