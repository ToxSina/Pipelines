while read f; do
  [ -z "$f" ] && continue 
  sbatch slurm_readgroups ${f}
done<infiles.txt
