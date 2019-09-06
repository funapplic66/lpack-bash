#!/bin/bash

# -- Creates a .lbry archive with zstd compression that supports JS and CSS
# -- Inspired by
# https://open.lbry.com/blog#4 ( lbry://@upside#e/blog#4 ) lpack post
# and https://open.lbry.com/@BrendonBrewer:3/websites:0 ( lbry://@BrendonBrewer#3/websites#0 )
# -- Requirements:
# -- Usage:
# $ chmod +x lpack.bash
# $ lpack.bash /path/to/your/html/files yourfilename.lbry

if [ ! -x "$(command -v zstd)" ]; then
	echo "zstd does not exist on your system. Please install zstd and try again. Exiting..."
	exit 127
fi

if [ ! -x "$(command -v tar)" ]; then
	echo "tar does not exist on your system. Please install tar and try again. Exiting..."
	exit 127
fi

if [[ -z $1 ]] || [[ -z $2 ]]; then
	echo "Please specify the path to your html files and a output.lbry filename."
	echo "Usage: lpack.bash /path/to/your/html/files yourfilename.lbry"
	echo "Exiting..."
	exit 1
fi

if [[ ! -e $1 ]] || [[ ! -d $1 ]]; then
	echo "The directory you specified does not exist or not a directory. Exiting..."
	exit 1
fi

# Get the paths prepared
webdir=$1
outputfile=$(realpath $2)
tempdir='/tmp/lpack'

# Copy website dir to temp dir
rm -rf $tempdir
mkdir -p $tempdir
cp -r "$webdir"/* "$tempdir"/

# loop through files in the dir and compress them with zstd
#for filename in "$tempdir/*"; do
echo "# Iterating through files and compressing..."
find $tempdir -type f -print0 | while IFS= read -r -d $'\0' filename; do
	[ -e "$filename" ] || continue
	cat $filename | zstd -5f - > $filename.zip ; mv $filename.zip $filename
done

echo "# Files have been individually compressed."

# tarify everything
echo "# Packing files into the destination file..."
cd "$tempdir"
tar --exclude=".DS_*" --exclude="._*" -cvf "$outputfile" $(find "." -type f | sed -e "s/^\.\///g")

echo "# Destination file saved to: $outputfile"
echo "# Upload to LBRY and have fun!"
