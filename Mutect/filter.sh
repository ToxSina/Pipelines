while read f; do
  [ -z "$f" ] && continue 
  sbatch slurm_mutectFilter ${f}_vsLongitudinalNormal
done<FibrePanel.txt
