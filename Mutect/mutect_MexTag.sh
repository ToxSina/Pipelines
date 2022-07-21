while read f; do
  [ -z "$f" ] && continue 
  mutect="-I 04_SORTED/$f.sorted.bam -I 04_SORTED/ADD5284MexTAg_S5.sorted.bam -I 04_SORTED/ADD5286MexTAg_S6.sorted.bam  -tumor $f -normal ADD5284MexTAg_S5 -normal ADD5286MexTAg_S6  -XL Y -O 05_MUTECT/${f}_vsMexTAGNormal.vcf.gz"
  sbatch 05_MUTECT/slurm_mutect "${mutect}"

done <MexTAG.txt
