ANSWER_FILE="friday.c"
COUNT=1
INPUT_FILE=input.txt

if $# -gt 0; then
    INPUT_FILE=$1
fi

rm output.txt
rm *.out

echo -e "Project1 Scoring Results\n<INPUT FILE> $INPUT_FILE" >> output.txt

for FILE in ./*.c
do
    ###   Remove Non-ascii Characters.
    ASCII_FILENAME=$(echo ${FILE} | perl -pe 's/[^[:ascii:]]//g')
    
    ###   Trim Prefix Attatched by YSCEC.
    STUDENT_ID=$(echo ${ASCII_FILENAME} | sed -e 's/^.*assignsubmission_file_\(.*\)$/\1/' -e 's/^\(.*\)\.c$/\1/') 
    
    ###   Modify Filename.
    NEW_FILE=${STUDENT_ID}".c"
    mv "$FILE" ${NEW_FILE}
    #echo $STUDENT_ID

    ###   Start Scoring.
    gcc ${NEW_FILE} -o ${STUDENT_ID}.out
    echo -e "\n\n---------STUDENT $COUNT: ${STUDENT_ID}------" >> output.txt
    COUNT=$(($COUNT+1))
    while read LINE
    do
        echo $LINE | ${STUDENT_ID}.out >> output.txt
    done < $INPUT_FILE
done
