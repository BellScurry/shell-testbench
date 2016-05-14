#
#   Usage: program <$1> [$2]
#
#   $1 := zip file from YSCEC
#   $2 := destination (default: submission/)
#

# YSCEC always gives us .zip file.
tmpdir="tmp_yscec_submission"
unzip $1 -d $tmpdir

# Trim all white space
for file in $tmpdir/*
do
    renamed_file="$(echo -e "${file}" | tr -d '[[:space:]]')"
    command="mv '$file' $renamed_file"
    eval $command
done

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

# Extract
for file in $tmpdir/*
do
    # Check if the file is tar-compatible file. If compatible, it returns 0. Else, it returns non-zero value.
    tar -tf $file > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        
        ##  Tar compatible files.
        declare structure=($(tar -tf $file))
        num_tree=0
        for((i=0; i<${#structure[@]}; i++ )); do
            if [[ ${structure[$i]} =~ ^[^\/]*\/$ ]]; then
                num_tree=$(($num_tree+1))
            fi
        done
        
        #echo "File: $file, N(tree)=$num_tree"
        if [ $num_tree -ne 1 ]; then
            # Remove prefix from YSCEC (..assignsubmission_file_) and file extension (all string at the right side of '.' character)
            newfilename=$(echo $file | sed 's/^.*assignsubmission_file_\([^.]*\).*/\1/')
            bad_tarfile+=($newfilename)

            mkdir -p "$destination/$newfilename"
            tar -xf $file -C "$destination/$newfilename"
        else
            tar -xf $file -C $destination
        fi
    else
        # Check if the file is zip-compatible file. If compatiable, it returns 0. Else, it returns non-zero value.
        unzip -t $file >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            # Remove prefix from YSCEC (..assignsubmission_file_) and file extension (all string at the right side of '.' character)
            newfilename=$(echo $file | sed 's/^.*assignsubmission_file_\([^.]*\).*/\1/')
            bad_zipfile+=($newfilename)

            mkdir -p "$destination/$newfilename"
            unzip $file -d "$destination/$newfilename"
        fi
    fi
done

# Remove temporary directory
rm -rf $tmpdir

# Debug Zone

# Notice user that this program exit.
echo "$0: ------Result------"
echo "$0: Bad tar files: Total ${#bad_tarfile[@]}"
for (( i=0; i < ${#bad_tarfile[@]}; i++ )) do
    echo -e "\t${bad_tarfile[$i]}"
done

echo "$0: Bad zip files: Total ${#bad_zipfile[@]}, ${bad_zipfile[@]}"
for (( i=0; i < ${#bad_zipfile[@]}; i++ )) do
    echo -e "\t${bad_zipfile[$i]}"
done

echo "$0: Exit Program"
