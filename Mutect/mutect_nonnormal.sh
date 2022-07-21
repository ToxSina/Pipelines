while read f; do
  [ -z "$f" ] && continue
  mutect="-I 04_SORTED/$f.sorted.bam -I 04_SORTED/<normal1.bam> <...> -I <normalN.bam> -tumor $f -normal <normal1> <...> -normal <normalN> -XL Y -O 05_MUTECT/${f}_vsNormals.vcf.gz"
  sbatch slurm_mutect "${mutect}"

done <nonnormal.txt
