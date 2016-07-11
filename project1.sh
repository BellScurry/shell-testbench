ANSWER_FILE="friday.c"

for file in ./*.c
do
    TRIMMED=$(echo ${file} | tr -d '[[:space:]]')
    STUDENT_ID=$(echo ${TRIMMED} | sed 's/^.*assignsubmission_file_\?\(.*\).c$/\1/')
    mv "$file" ${STUDENT_ID}".c"
    #echo ${file}
    #echo $STUDENT_ID
    #file -bi $file
done
