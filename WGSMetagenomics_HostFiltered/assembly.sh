while read f; do
  [ -z "$f" ] && continue 
  sbatch slurm_assembly ${f}
done<infiles.txt
