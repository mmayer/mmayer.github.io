#!/bin/sh
prg=`basename $0`

year=`date '+%Y'`
if grep "^&copy; $year" index.md >/dev/null; then
	# Already up to date. Nothing to do.
	exit 0
fi

# We need GNU sed. On a Mac, "sed" is likely not GNU sed, therefore...
sed=`which gsed` 2>/dev/null
test "$sed" = "" && sed=`which sed`

$sed -i "s/^&copy; .*/\&copy; $year/" index.md

if git status index.md | grep modified >/dev/null; then
	echo "Updated copyright to $year..."
	echo "Pushing updated file..."
	git commit -m "Copyright $year" index.md
	git push
fi
