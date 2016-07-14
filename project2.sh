###   Unzip the .zip file downloaded from YSCEC.
###   Usage: yscec_unzip <zip file from YSCEC> <directory to which you unzip>
yscec_unzip () {

    ###   We need $1 and $2, so $# must be 2.
    if [ "$#" -ne 2 ]; then
        echo "wrong number of parameters were passed to function yscec_unzip()"
        echo "Usage: yscec_unzip <zip file from YSCEC> <directory to which you unzip>"
        exit -1
    fi

    #ascii_zipfile=$(echo $1 | perl -pe 's/[^[:ascii:]]//g')
    #mv "$1" $ascii_zipfile
    
    mkdir $2
    unzip $1 -d $2
}

###   Trim all prefix attatched by YSCEC in filenames.
###   Usage: yscec_remove_prefix_in <target directory>
yscec_remove_prefix_in () {
    
    ###   We need $1, so $# must be 1.
    if [ "$#" -ne 1 ]; then
        echo "wrong number of parameters were passed to function yscec_remove_prefix_in()"
        echo "Usage: yscec_remove_prefix_in <target directory>"
        exit -1
    fi

    ###   Renaming files.
    for file in $1/*
    do
        ###   Extract filename from path.
        filename=$(echo ${file} | sed -e 's/^.*\/\(.*\)/\1/')

        ###   Remove Non-ascii Characters in Filenames.
        ascii_filename=$(echo ${filename} | perl -pe 's/[^[:ascii:]]//g')
    
        ###   Trim Prefix Attatched by YSCEC in Filenames.
        real_filename=$(echo ${ascii_filename} | sed -e 's/^.*assignsubmission_file_\(.*\)$/\1/') 
    
        ###   Modify Filename.
        mv $1/$filename $1/$real_filename
    done
}

yscec_unzip $1 "submission"
yscec_remove_prefix_in "submission"
