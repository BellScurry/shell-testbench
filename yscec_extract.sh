###   Unzip the .zip file downloaded from YSCEC.
###   Trim all prefix attatched by YSCEC in filenames.
###   Usage: yscec_remove_prefix_in <zip file from YSCEC> <directory to which you unzip>
yscec_extract () {
     
    if [ "$#" -ne 2 ]; then
        echo "wrong number of parameters were passed to function yscec_extract()"
        echo "Usage: yscec_unzip <zip file from YSCEC> <directory to which you unzip>"
        exit -1
    fi

    mkdir $2
    unzip "$1" -d $2

    ###   Renaming files.
    for file in $2/*
    do
        ###   Extract filename from path.
        filename=$(echo ${file} | sed -e 's/^.*\/\(.*\)/\1/')

        ###   Remove Non-ascii Characters in Filenames.
        ascii_filename=$(echo ${filename} | perl -pe 's/[^[:ascii:]]//g')
    
        ###   Trim Prefix Attatched by YSCEC in Filenames.
        real_filename=$(echo ${ascii_filename} | sed -e 's/^.*assignsubmission_file_\(.*\)$/\1/') 
    
        ###   Modify Filename.
        mv "$2/$filename" $2/$real_filename
    done
}

yscec_extract $1 $2
