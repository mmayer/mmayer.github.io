#!/bin/sh
prg=`basename $0`

# We need GNU sed. On a Mac, "sed" is likely not GNU sed, therefore...
sed=`which gsed` 2>/dev/null
test "$sed" = "" && sed=`which sed`

year=`date '+%Y'`
$sed -i "s/^&copy; .*/\&copy; $year/" index.md

if git status index.md | grep modified >/dev/null; then
	echo "Updated copyright to $year..."
	echo "Pushing updated file..."
	git commit -m "Copyright $year" index.md
	git push
fi
