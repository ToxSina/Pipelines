for f in *.gz; do mv "$f" "$(echo "$f" | sed s/HLJKTBGXL_//)"; done
