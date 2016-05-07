# Trim all white space
for file in $1/* 
do
    renamed_file="$(echo -e "${file}" | tr -d '[[:space:]]')"
    command="mv '$file' $renamed_file"
    eval $command
done
