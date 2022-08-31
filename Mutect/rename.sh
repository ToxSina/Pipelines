for f in *.bam; do mv "$f" "$(echo "$f" | sed s/22s00//)"; done
