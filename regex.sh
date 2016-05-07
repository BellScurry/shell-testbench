#
#   IFS : Internal Field Separator
#
#   $IFS : Shell's special variable
#
#

var1="1:2:3:4:5"
var2=${var1//:/}
echo $var2
echo $var[1]
