#
#   IFS : Internal Field Separator
#
#   $IFS : Shell's special variable
#
#

var1="a:b:c:d:e"

# Do not split this line.
IFS=":" read -ra array <<< $var1

for i in {0..4}
do
    echo ${array[$i]}
done

array_length=${#array[@]}
echo "Array Length = $array_length"

for ((i=0 ; i < $array_length ; i++ )); do
    echo ${array[$i]}
done
