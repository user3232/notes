#!/bin/sh

# call like that:
# $ sh shell.sh 'How are you?' 'Today?'
# filename
echo $0
# script argument 1
echo $1
# script argument 2
echo $2
# ...
# script argument 9

# then to read next arguments:
shift [9]
# and one more ...

# number of arguments
echo $#

###########################
# Variables substitution
###########################

ANIMAL=duck
echo One $ANIMAL, two ${ANIMAL}s

THIS_ONE_SET=Hello
# default substitutions if not defined or empty (:)
# ${varname[:]-default} -> substitutes
# ${varname[:]=default} -> substitutes and defines varname
# 
echo $THIS_ONE_SET ${THIS_ONE_NOT:-World}



