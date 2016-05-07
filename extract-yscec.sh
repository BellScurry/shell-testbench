#
# Usage: program <directory which contains .tar files> [destination (default: submission/)]
#

# Determine destination
if [ $# -gt 1 ]; then
    destination=$2
else
    destination="submission/"
    
    if [ ! -e "submission/" ]; then
        echo "$0: There is no directory submission/, so make the directory."
        mkdir 'submission/'
    fi
fi

zipfile_count=0
# Extract
for file in $1*
do
    # Check if the file is tar-compatible file. If compatible, it returns 0. Else, it returns non-zero value.
    tar -tf $file
    if [ $? -eq 0 ]; then
        tar -xf $file -C $destination
        echo $structure
    else
        # Check if the file is zip-compatible file. If compatiable, it returns 0. Else, it returns non-zero value.
        unzip -t $file > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            mkdir -p "$destination/ZIP$zipfile_count"
            unzip $file -d "$destination/ZIP$zipfile_count"
            zipfile_count=$(($zipfile_count+1))
        fi
    fi
done

# Notice user that this program exit.
echo "$0: Exit Program"
