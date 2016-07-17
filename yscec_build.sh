echo "Usage: $0 <submission file directory> <executable directory>"

mkdir $2

for file in $2/*
do
    ###   Remove path info and extension.
    submission_name=$(echo $file | sed -e 's/\(.*\/\)*\(.*\)\..*/\2/')
    gcc -o "$2/$submission_name" $file
done
