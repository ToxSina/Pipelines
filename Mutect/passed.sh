while read f; do
  [ -z "$f" ] && continue 
  sbatch slurm_passing ${f}_vsNormals
done<nonnormal.txt
