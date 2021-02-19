#!/bin/sh

myFunction() {
  echo $1
}

echo Script first argument = $1
echo Calling myFunction without argument gives:
myFunction
echo Calling myFunction with "\"Hello World\"" argument gives:
myFunction "Hello World"
echo Script first argument is steel = $1