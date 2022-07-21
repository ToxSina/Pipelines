l=""
while read f; do
  [ -z "$f" ] && continue
  n="05_SORTED/${f}.sorted.bam" 
  l+="${n} "
done<renamed.txt
#echo ${l}
sbatch slurm_featurecount "${l}"

