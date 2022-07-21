while read f; do
  [ -z "$f" ] && continue 
  mutect="-I 04_SORTED/$f.sorted.bam -XL Y -O 05_MUTECT/${f}_pon.vcf.gz"
  echo  $mutect
 sbatch 05_MUTECT/slurm_pons "${mutect}"

done <pons.txt
