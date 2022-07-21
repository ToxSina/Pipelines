while read f; do
  [ -z "$f" ] && continue 
  mutect="-I 05_SORTED/$f.sorted.bam -XL Y -O 06_PON/${f}_pon.vcf.gz"
  echo  $mutect
 sbatch slurm_pons "${mutect}"

done <pons.txt
