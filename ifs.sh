#
#   IFS : Internal Field Separator
#
#   $IFS : Shell's special variable
#
#

var1="1:2:3:4:5"

# Do not split this line.
IFS=":" read -ra array <<< $var1

for i in {0..4}
do
    echo ${array[$i]}
done
