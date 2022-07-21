while read f; do
  [ -z "$f" ] && continue 
  sbatch slurm_rawqc ${f}
done<infiles.txt
