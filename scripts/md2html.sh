#!/bin/sh

if (( $# == 0 )); then
	input="index.md"
    output="index.html"
elif (( $# == 1 )); then
	input=$1
	output="index.html"
elif (( $# == 2 )); then
	input=$1
	output=$2
else
	>&2 echo "Too much arguments"
	exit 1
fi

pandoc --listings --highlight-style=zenburn --toc --css=https://dimaglushkov.xyz/public/pandoc-md2html.css -t html5 -s $input -o $output
