while read f; do
  [ -z "$f" ] && continue 
  echo ${f}
cp ${f} 00_DATA/.
done<samples.txt

