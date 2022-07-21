while read f; do
  [ -z "$f" ] && continue 
  mutect="-I 04_SORTED/$f.sorted.bam -I 04_SORTED/ABS5182-NF2HETVC_S7.sorted.bam -I 04_SORTED/ABS5351-NF2HETVC_S8.sorted.bam -I 04_SORTED/ABS5247-NF2WTVC_S9.sorted.bam  -tumor $f -normal ABS5182-NF2HETVC_S7 -normal ABS5351-NF2HETVC_S8 -normal ABS5247-NF2WTVC_S9  -XL Y -O 05_MUTECT/${f}_vsNF2Normal.vcf.gz"
  sbatch 05_MUTECT/slurm_mutect "${mutect}"

done <NF2.txt
