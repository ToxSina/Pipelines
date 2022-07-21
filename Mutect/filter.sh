while read f; do
  [ -z "$f" ] && continue 
  sbatch slurm_mutectFilter ${f}_vsNormals
done<nonnormal.txt
