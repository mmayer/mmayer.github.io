#!/bin/sh
prg=`basename $0`

year=`date '+%Y'`
sed -i "s/^&copy; .*/\&copy; $year/" index.md

if git status index.md | grep modified >/dev/null; then
	echo "Updated copyright to $year..."
	echo "Pushing updated file..."
	git commit -m "Copyright $year" index.md
	git push
fi
