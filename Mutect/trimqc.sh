while read f; do
  [ -z "$f" ] && continue 
  sbatch slurm_trimqc ${f}
done<infiles.txt
