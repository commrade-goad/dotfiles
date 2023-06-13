#!/bin/bash
INPUTFILE=$1
OUTPUTFILE=$2

print_help() {
	echo "== HELP =="
	echo "USAGE : convert-sjis.sh [input] [output]"
}

main () {
	if [ -z $INPUTFILE ]
		then print_help
	elif [ -z $OUTPUTFILE ]
		then print_help
	else
		iconv -f shift-jis -t utf-8 < "$INPUTFILE" > "$OUTPUTFILE"
	fi
}
main
