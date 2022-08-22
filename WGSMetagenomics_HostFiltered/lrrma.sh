while read f; do
  [ -z "$f" ] && continue 
  sbatch slurm_lrRMA ${f}
done< infiles.txt
