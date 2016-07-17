###   scored file directory : $1
###   input file : $2
###   output file : $3

echo "Usage : $0 <scored file directory> <input file> <output file>"

for target in $1/*
do
    student_id=$(echo $target | sed -e 's/\(.*\/\)*\(.*\)/\2/')
    echo $student_id >> $3
    
    while IFS= read -r line || [[ -n $line ]];
    do
        echo $line | $target >> $3
        echo -e "\n" >> $3
    done < $2
done
