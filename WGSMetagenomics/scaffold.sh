while read f; do
  [ -z "$f" ] && continue 
  sbatch slurm_scaffolds ${f}
done<infiles.txt
