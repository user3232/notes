# Shell scripting

## Resources

Links:

* [Wikibooks - Bourne Shell Scripting](https://en.wikibooks.org/wiki/Bourne_Shell_Scripting)
* [Advanced Bash-Scripting Guide](http://tldp.org/LDP/abs/html/index.html)

# Shell as calculator

https://unix.stackexchange.com/questions/480121/simple-command-line-calculator

## sh

POSIX shell: 

```console
$ echo $(( 22 + 333 ))
355
$ echo $((22*333))
7326
$ # some shells have most of the 
$ # C language math syntax (including comma):
$ echo $((a=22,b=333,c=a*b,c))
7326
$ cat <<< $(( 236 - 192 ))
44
$ # Some shells could do floating math:
$ ksh -c 'echo $((1234/3.0))'
411.333333333333333
```

## bc

At the next level is (also POSIX) bc

```console
$ echo '22*333' | bc
7326
$ # if shell supports it:
$ bc <<<'22*333'
7326
$ echo 's(3.1415/2)' | bc -l  # s is sine function
.99999999892691403749
```

Common functions:

- s (x): The sine of x, x is in radians.
- c (x) : The cosine of x, x is in radians.
- a (x) : The arctangent of x, arctangent returns radians.
- l (x) : The natural logarithm of x.
- e (x) : The exponential function of raising e to the value x.
- j (n,x) : The bessel function of integer order n of x.
- sqrt(x) : Square root of the number x. If the expression is
  negative, a run time error is generated.

In addition to the math functions, the following functions are also
supported :

- length(x) : returns the number of digits in x.
- read() : Reads the number from the standard input.
- scale(expression) : The value of the scale function is the number of
  digits after the decimal point in the expression.
- ibase and obase define the conversion base for input and output
  numbers. The default for both input and output is base 10.
- last (an extension) is a variable that has the value of the last
  printed number.

# Create (symbolic) link 

```console
$ ln -s ~/doc/some_file.pdf some_file_link.pdf
$ # Pass the -f to the ln command to overwrite links:
$ ln -f -s /path/to/my-cool-file.txt link.txt
```

# Envioronment

Whenever you start a new process from another process (for
instance by issuing a command to your shell program in
interactive mode), the new process becomes what is called a
child process of the first process (the ls program runs as a
child process of your shell, for instance). This is where it
becomes important to know about multiprocessing and process
interaction: a child process always starts with a copy of
the environment of the parent process. This means two
things:

1. A child process can never make changes to the operating
   environment of its parent—it only has access to a copy of
   that environment;
2. If you actually do want to make changes in the
   environment of your shell (or specifically want to avoid
   it), you have to know when a command runs as a child
   process and when it runs within your current shell; you
   might otherwise pick a variant that has the opposite
   effect of that which you want.

# Running a shell command

Shell commands or scripts run in the following way: 

* Interactive mode command:
  * current environment for a shell command or
  * child process for a new program
* Shell non-interactive mode (script):
  * child process
* Dot-notation run command (. MyScript)
  * current environment 
* Through Unix executable permission with interpreter 
  selection (#!/bin/sh)
  * child process 

# Background processes

Running a process as a background process means telling the
operating system that you want to start a process, but that
it should not attach itself to any of the interactive
devices (keyboard, screen, etc.) that its parent process is
using. And more than that, it also tells the operating
system that the request to start this child process should
return immediately and that the parent process should then
be allowed to continue working without having to wait for
its child process to end. 


In sh it is done by appending ampersand (&) to command, e.g.:

```sh
#!/bin/sh
# long task writing dates to file scriptout
N=0 && while [ $N -lt 10000 ]
do date >> scriptout
N=`expr $N + 1`
done&
```

Executing above script example:

```console
$ . long_job.sh
$ # we have controll but job works:
$ jobs
[1]+  Działa                 N=0 && while [ $N -lt 10000 ]; do
    date >> scriptout; N=`expr $N + 1`;
done &
$ # after a while..
$ jobs
[1]+  Zakończono             N=0 && while [ $N -lt 10000 ]; do
    date >> scriptout; N=`expr $N + 1`;
done
```

# The command execution environment (CEE)

The complete list of resources included in the shell's CEE is:

* Open files held in the parent process that started the
  shell. These files are inherited. This list of files
  includes the files accessed through redirection (such as
  standard input, output and error files).
* The current working directory: the "current" directory of
  the shell.
* The file creation mode:The default set of file permissions
  set when a new file is created.
* The active traps.
* Shell parameters and variables set during the call to the
  shell or inherited from the parent process.
* Shell functions inherited from the parent process.
* Shell options set by set or shopts, or as command line
  options to the shell executable.
* Shell aliases (if available in your shell).
* The process id of the shell and of some processes started
  by the parent process.

Whenever the shell executes a command that starts a child
process, that command is executed it its own CEE. This CEE
inherits a copy of part of the CEE of its parent, but not
the entire parent CEE. The inherited copy includes:

* Open files.
* The working directory.
* The file creation mode mask.
* Any shell variables and functions that are marked to be
  exported to child processes.
* Traps set by the shell.


# Environment variable

An environment variable is sort of like a bulletin board:
anybody can post any kind of value there for everybody to
read (as long as they have access to the board). And
whatever is posted there can be interpreted by any reader in
whatever way they like. This makes the environment variable
a very general mechanism for passing data along from one
place to another.

```console
$ VAR=Hello
$ VAR=Goodbye
$ VAR=$PATH
$ XX= "`whoami`@`hostname -s` `pwd` \$ "
$ echo $XX
xx@xx-Comp-GXXX /home/xx/prog/shell $
```

To display defined variables:
```console
$ set
lots of definitions ...
```

One of the things that the shell does to avoid processes
inadvertently affecting one another, is environment
separation. Basically this means that whenever a new
(sub)process is started, it has its own CEE and environment.

The compromise between the two extremes that Stephen Bourne
and others came up with is this: a subprocess has an
environment which contains copies of the variables in the
environment of its parent process — but only those variables
that are marked to be exported (i.e. copied to
subprocesses). In other words, you can have any variable
copied into the environment of your subprocesses, but you
have to let the shell know that's what you want first.
Here's an example of the distinction:

```console
$ echo $PATH
/usr/local/bin:/usr/bin:/bin
$ VAR=value
$ echo $VAR
value
$
$ # inner shell start
$ sh
$ echo $PATH
/usr/local/bin:/usr/bin:/bin
$ echo $VAR

$ exit        # Quitting the inner shell
$ # inner shell end
$
$ export VAR  # This is back in the outer shell
$             # export VAR1 VAR2 ... VARN
$ sh
$ echo $VAR
value
```


# Command-line arguments 

Script name can be accessed by (pseudo) variable:
`$0`.

Command line arguments are accessed by (pseudo) variables:
`$1 $2 $3 $4 $5 $6 $7 $8 $9`

Further arguments are accessed in the same
way after shifting: `shift [n]`
(but 0 < n < 10, no shift back and `$0` stays the same!).

```sh
#!/bin/sh

# filename
echo $0
# script argument 1
echo $1
# script argument 2
echo $2

# access arguments 10, 11, ...
shift 9
```

To print all arguments:

```sh
#!/bin/sh
# prints arguments
while [ $# -gt 0 ]
do
    echo $1
    shift
done
```

Or alternatively:

```sh
#!/bin/sh
# prints arguments
for arg
do
  echo $arg
done
```


# Special variables

Special variables:

* `$0` : script name
* `$1` to `$9` : script arguments 1 to 9
* `$#` : number of script arguments
* `$?` : The exit status of the last command executed (0 if
  it succeeded, non-zero if there was an error).
* `$$` : The process id of the current process.
* `$!` : The process id of the last background command.
* `$*` : All the command-line arguments. When quoted,
  expands to all command-line arguments as a single word
  (i.e. "$*" = "$1 $2 $3 ...").
* `$@` : All the command-line arguments. When quoted,
  expands to all command-line arguments quoted individually
  (i.e. "$@" = "$1" "$2" "$3" ...).



# Your profile

Profile is defined in `$HOME/.profile` file (which typically
is sh), for example:

```sh
#!/bin/sh

# if common profile exists execute it
if [ -f /etc/profile ]; then
 . /etc/profile
fi
# change prompt to:
PS1= "`whoami`@`hostname -s` `pwd` \$ "
# use this prompt in children:
export PS1
# other things if wished..
```

# Multitasking and job control

A job is a program you start within the shell. By default a
new job will suspend the shell and take control over the
input and output: every stroke you type at the keyboard will
go to the job, as will every mouse movement. Nothing but the
job will be able to write to the monitor. This is what we
call a foreground job: it's in the foreground, clearly
visible to you as a user and obscuring all other jobs in the
system from view. 

When we talk about job control in the shell, we are talking
about the abilities described above: to start programs in
the background, to suspend running programs and to resume
suspended programs, either in the foreground or in the
background.

## Dictionary

* Job: A process that is executing an instance of a computer
  program.
* Job control: The ability to selectively stop (suspend) the
  execution of jobs and continue (resume) their execution at
  a later point.
* Job ID: An ID (usually an integer) that uniquely
  identifies a job. Can be used to refer to jobs for
  different tools and commands.
* Process ID (or PID): An ID (usually an integer) that
  uniquely identifies a process. Can be used to refer to
  processes for different tools and commands. Not the same
  as a Job ID.
* Foreground job (or foreground process): A job that has
  access to the terminal (i.e. can read from the keyboard
  and write to the monitor).
* Background job (or background process): A job that does
  not have access to the terminal (i.e. cannot read from the
  keyboard or write to the monitor).
* Stop (or suspend): Stop the execution of a job and return
  terminal control to the shell. A stopped job is not a
  terminated job.
* Terminate: Unload a program from memory and destroy the
  job that was running the program.



## Background job

Example:

```console
$ ls * > /dev/null &
[1] 4808
$
```

Where:

* `ls * > /dev/null` : starts command, then
* `&` makes it to background.
* `[1]` is job id and
* `4808` is process id (PID)

When the task finishes, you will receive a notice similar to
the following: 

```console
[1]+  Done     ls * > /dev/null &
```

To move process to foreground, use: `fg %<job id>`
To suspend (stop) running process use: `CTRL+Z`

Then to resume in foreground: `fg %<job id>`, or
to resume in background: `bg %<job id>`.

To stop process one can also `kill -SIGSTOP %<job id>` or
`kill -SIGSTOP processId`

## Job control tools and job status

The standard list of job control tools consists of the following:

* `bg [job spec]`: Moves a job to the background.
* `fg [job spec]`: Moves a job to the foreground.
* `jobs [-lnprs] [job spec]`: Lists the active jobs.
  * `-l` lists the process IDs as well as normal output
  * `-n` limits the output to information about jobs whose
    status has changed since the last status report
  * `-p` lists only the process ID of the jobs' process group leader
  * `-r` limits output to data on running jobs
  * `-s` limits output to data on stopped jobs
* `kill [job spec]`: Terminate a job or send a signal to a process.
* `CTRL+C`: Terminate a job (same as 'kill' using the SIGTERM signal).
* `CRTL+Z`: Suspend a foreground job.
* `wait [job spec]`: Wait for background jobs to terminate.

All of these commands can take a job specification ` [job spec]` as an
argument. A job specification starts with a percent sign and
can be any of the following:

* `%n`: A job ID (n is number).
* `%s`: The job whose command-line started with the string s.
* `%?s`: The jobs whose command-lines contained the string s.
* `%%`: The current job (i.e. the most recent one that you managed using job control).
* `%+`: The current job (i.e. the most recent one that you managed using job control).
* `%-`: The previous job.


## Process states

We recognize the following states:

* Running - This is where the job is doing what it's
  supposed to do. You probably don't need to interrupt it
  unless you really want to give the program your personal
  attention (for example, to stop the program, or to find
  out how far through a file download has proceeded). You'll
  generally find that anything in the foreground that's not
  waiting for your attention is in this state, unless it's
  been put to sleep.
* Sleeping - When programs need to retrieve input that's not
  yet available, there is no need for them to continue using
  CPU resources. As such, they will enter a sleep mode until
  another batch of input arrives. You will see more sleeping
  processes, since they are not as likely to be processing
  data at an exact moment of time.
* Stopped - The stopped state indicates that the program was
  stopped by the operating system. This usually occurs when
  the user suspends a foreground job (e.g. pressing CTRL-Z)
  or if it receives SIGSTOP. At that point, the job cannot
  actively consume CPU resources and aside from still being
  loaded in memory, won't impact the rest of the system. It
  will resume at the point where it left off once it
  receives the SIGCONT signal or is otherwise resumed from
  the shell. The difference between sleeping and stopped is
  that "sleep" is a form of waiting until a planned event
  happens, whereas "stop" can be user-initiated and
  indefinite.
* Zombie - A zombie process appears if the parent's program
  terminated before the child could provide its return value
  to the parent. These processes will get cleaned up by the
  init process but sometimes a reboot will be required to
  get rid of them.

# Substitutions

## Variable substitution

Variables are referenced using `${variable_name}`

Modifiers:
* `${varname:-default}` (commonly used as default)
  * varname undefined or empty => return default
* `${varname-default}` (commonly used as default)
  * varname undefined => return default
* `${varname:=default}` (commonly used as configure)
  * varname undefined or empty => return default and assign
    default to varname
* `${varname=default}` (commonly used as configure)
  * varname undefined => return default and assign default to varname
* `${varname:+substitute}` (commonly used as test)
  * if varname defined and not empty => return default
* `${varname+substitute}` (commonly used as test)
  * if varname defined or empty => return default
* `${varname:?message}` (commonly usd for debugging)
  * if varname undefined => message is printed and the
    command or script exits with a non-zero exit status. Or,
    if there is no message, the text "parameter null or not
    set" is printed.
* `${varname?message}` (commonly usd for debugging)
  * if varname undefined or empty => message is printed and the
    command or script exits with a non-zero exit status. Or,
    if there is no message, the text "parameter null or not
    set" is printed.


## Command output substitution

Command substitution is accomplished using either of two notations: 
* The original Bourne Shell used grave accents (`` `command` ``),
  which is still generally supported by most shells. 
* Later on the POSIX 1003.1 standard added the `$( command )` notation.

Example of old school:

```console
$ # old school
$ cp myfile backup/myfile-`date`
$ echo yo yo today is `date`
yo yo today is sob, 11 lip 2020, 19:18:27 CEST
```
Example of POSIX school:

```console
$ cp myfile backup/myfile-$(date)
$ echo yo yo today is $(date)
yo yo today is sob, 11 lip 2020, 19:19:11 CEST
```


# Comparison

For testing varables, immediates, there is program `test`.
It return comparison outcom as return code/exit status,
0 for true, other value (typically 1) for false. This can 
be found in `$?` pseudo variable. For example to test two
strings for equality, one can do:

```console
$ test "string 1" = "string 2"
$ echo $?
1
```

Shortcut for `test ...` is:
```console
$ [ "Hello World" = "Hello World" ]
$ echo $?
0 
```

Another shortcut for `test ...` is:
```console
$ [[ "Hello World" = "Hello World" ]]
$ echo $?
0 
```

`test` command (program) takes following arguments:

* File conditions:
  * `-b` : file file exists and is a block special file
  * `-c` : file file exists and is a character special file
  * `-d` : file file exists and is a directory
  * `-f` : file file exists and is a regular data file
  * `-g` : file file exists and has its set-group-id bit set
  * `-k` : file file exists and has its sticky bit set
  * `-p` : file file exists and is a named pipe
  * `-r` : file file exists and is readable
  * `-s` : file file exists and its size is greater than zero
  * `-t  [n]` : The open file descriptor with number n is a
    terminal device; n is optional, default 1
  * `-u` : file file exists and has its set-user-id bit set
  * `-w` : file file exists and is writable
  * `-x` : file file exists and is executable
* String conditions:
  * `-n s` : s has non-zero length
  * `-z s` : s has zero length
  * `s0 = s1` : s0 and s1 are identical
  * `s0 != s1` : s0 and s1 are different
  * `s` : s is not null (often used to check that an
    environment variable has a value)
* Integer conditions:
  * `n0 -eq n1` : n0 is equal to n1
  * `n0 -ge n1` : n0 is greater than or equal to n1
  * `n0 -gt n1` : n0 is strictly greater than n1
  * `n0 -le n1` : n0 is less than or equal to n1
  * `n0 -lt n1` : n0 is strictly less than n1
  * `n0 -ne n1` : n0 is not equal to n1
* Finally, conditions can be combined and grouped:
  * `\( B \)` : Parentheses are used for grouping conditions
    (don't forget the backslashes). A grouped condition (B)
    is true if B is true.
  * `! B` : Negation; is true if B is false.
  * `B0 -a B1` : And; is true if B0 and B1 are both true.
  * `B0 -o B1` : Or; is true if either B0 or B1 is true.


# Branching

## if

`command-list` is list of commands, executed in list order.
Last command return value will be return value of `command-list`.
`than` is executed if corresponding if `command-list` returned 0.
If no `than` was executed than `else` will be executed if it exists.
Conditional construction must be ended with `fi`.

```sh
if command-list
then command-list
elif command-list
then command-list
#...
else command-list
fi
```

Simple example:
```console
$ if [ 1 -gt 0 ]
$ then
$   echo YES
$ fi
YES
```

## case

`case` takes a value and compares it to a fixed set of
expected values or patterns. The case statement is used very
frequently to evaluate command line arguments to scripts.

Case structure is:

```sh
case value in
pattern0 ) command-list-0 ;;
pattern1 ) command-list-1 ;;
#...
esac
```

Where:
* The value can be any value, including an environment variable.
* Each pattern is a regular expression and 
* the command list 
  * executed is the one for the first pattern that matches
    the value (so make sure you don't have overlapping
    patterns). 
  * Each command list must end with a double semicolon. 
  * The return status is zero if the statement terminates
    without syntax errors.

Example:

```console
$ rank=captain
$ case $rank in
$     colonel) echo Hannibal Smith;;
$     captain) echo Howling Mad Murdock;;
$     lieutenant) echo Templeton Peck;;
$     sergeant) echo B.A. Baracus;;
$     *) echo OOPS;;
$ esac
Howling Mad Murdock
```

# Repetitions

## while

```sh
while command-list1
do command-list2
done
```

The while-statement is interpreted as follows:

1. Execute the commands in command list 1.
2. If the exit status of the last command is non-zero, the
   statement terminates.
3. Otherwise execute the commands in command list 2 and go
   back to step 1.
4. If the statement does not contain a syntax error and it
   ever terminates, it terminates with exit status zero.


Example:

```console
$ counter=0
$ while [ $counter -lt 3 ]
$ do
$   echo $counter
$   counter=`expr $counter + 1`
$ done
0
1
2
```

## until

The interpretation of this statement is almost the same as
that of the while-statement. The only difference is that the
commands in command list 2 are executed as long as the last
command of command list 1 returns a non-zero status. Or, to
put it more simply: command list 2 is executed as long as
the condition of the loop is not met.

```sh
# this script will 
# waite for myfile.txt to grow to 10000 lines
until [ $lines -eq 10000 ]
do
    lines=`wc -l dates | awk '{print $1}'`
    sleep 5
done
```

## for

The for-statement loops over a fixed, finite set of values.

```sh
for name in w1 w2 w... wn
do command-list
done
```

* This statement executes the command list for each value
  named after the 'in'. 
* Within the command list, the "current" value wi is
  available through the variable name. 
* The value list must be separated from the 'do' by a
  semicolon or a newline. 
* And the command list must be separated from the 'done' by
  a semicolon or a newline.

Example:

```sh
$ for myval in Abel Bertha Charlie
$ do
$   echo $myval Company
$ done
Abel Company
Bertha Company
Charlie Company
```

# Command joining

Bourne Shell also offers a method of directly linking two
commands together and making the execution of one of them
conditional on the outcome (the exit status) of the other.

## && operator (continue if ok)

The `&&` operator joins two commands together and only
executes the second if the exit status of the first is zero
(i.e. the first command "succeeds").

```console
$ echo Hello World > tempfile.txt && rm tempfile.txt
$ # above will succeed only if creation of
$ # tempfile.txt succeeds
$ # this example will succeed
$ # check: $echo $? 
$ # equals 0 
$ test -f my_important_file && cp my_important_file backup
```

The exit status of the joined commands is the exit status of
the last command that actually got executed. 

## || (do something if not ok)

The `||` operator executes the second command only if the exit
status of the first command is not zero (i.e. it fails).

```sh
test -f my_file || echo Hello World > my_file
# Make sure we do not overwrite a file; 
# create a new file only if it doesn't exist yet
```
The exit status of the joined commands is the exit status of
the last command that actually got executed. 

## Command list

Command list can be created using `;` operator.  There is no
conditional execution; all commands are executed, even if
one of them fails. 

```sh
# This is commands list:
mkdir newdir;cd newdir
# This is also (the same) commands list:
mkdir newdir
cd newdir
```

## Command group executed in same process {}

Command list may be grouped, taking command list
in curly parenthases. Such command group will behave
identically as command list.

```console
$ { mkdir newdir;cd newdir; }
$ # this will create newdir and
$ # change current directory to newdir
```

## Command group executed in new process ()

Command list may be grouped taking it in elipsis.
Such command group will be executed in
separate process.

```console
$ (mkdir newdir;cd newdir;)
$ # this will create newdir in new process and
$ # change current directory to newdir also in new process
$ # calling process will have orginal directory
```



# Functions

Shell have named functions, it gives the possibility to
associate a name with a command list and execute the command
list by using the name as a command. 

This is what it looks like: 

```sh
name () command-group
```

where :
* `name` is name of function
* `()` signify it is function, and also that function
  does not take explicit parameters (but implicit as
  `$1`, `$2`, `$?`, `$fun_arg`, etc. are ok) in elipsis
  `(...)`, but if function is executed in new process
  command line arguments will be passed to function.
* command-group is command-list in parenthasis:
  * `{ command-list }` (executed in the same shell / process) or
  * `(command-list)` (executed in new shell / process)


Examples:

```console
$ repeatOne () { echo $1; }
$ repeatOne 'Hello World!'
Hellow World!
```

In script function may be defined as fallows:

```sh
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
```

Now running above script:

```console
$ . function_exemple.sh "Goodby!"
Script first argument = Goodby!
Calling myFunction without argument gives:

Calling myFunction with "Hello World" argument gives:
Hello World
Script first argument is steel = Goodby!
```

## So what is function for shell?

A function, as far as the shell is concerned, is just a very
verbose variable definition. And that's really all it is: a
name (a text string) that is associated with a value (some
more text) and can be replaced by that value when the name
is used. Just like a shell variable. And we can prove it
too: just define a function in the interactive shell, then
give the 'set' command (to list all the variable definitions
in your current environment). Your function will be in the
list. 

Because functions are really a special kind of shell variable
definition, they behave exactly the same way "normal" variables do:

* Functions are defined by listing their name, a definition
  operator and then the value of the function. Functions use
  a different definition operator though: `()` instead of
  `=`. This tells the shell to add some special
  considerations to the function (like not needing the `$`
  character when using the function).
* Functions are part of the environment. That means that
  when commands are issued from the shell, functions are
  also copied into the copy of the environment that is given
  to the issued command.
* Functions can also be passed to new subprocesses if they
  are marked for export, using the `export` command. Some
  shells will require a special command-line argument to
  `export` for functions (bash, for instance, requires you
  to do an `export -f` to export functions).
* You can drop function definitions by using the `unset`
  command.

Also:

* functions behave just like commands (they are expanded
  into a command list, after all)
* you can use command-line arguments with functions and the
  positional variables to match.
* you can also redirect input and output to and from
  commands and pipe commands together as well

# Shell patterns

The Bourne shell recognizes the following metacharacters: 


* `*` : Matches any string.
* `?` : Matches any single character.
* `[characters]` : Matches any character enclosed in the
  angle brackets.
* `[!characters]` : Matches any character not enclosed in the
  angle brackets.
* `pat0|pat1` : Matches any string that matches pat0 or pat1
  (only in case-statement patterns!)

When selecting files, the metacharacters match all files
except files whose names start with a period ("."). Files
that start with a period are either special files or are
assumed to be configuration files. For that reason these
files are semi-protected, in the sense that you cannot just
pick them up with the metacharacters. In order to include
these files when selecting with regular expressions, you
must include the leading period explicitly. For example: 

```console
$ # Lising all files whose names start with a period 
$ /home$ ls .*
.
..
.profile 
```

# Escaping

Shell patterns and variable references, block, calls etc.
can be escaped.

To escape:

* `\` : backslash, for single character quoting.
* `''` : single quotes, to quote entire strings.
* `""` : double quotes, to quote entire strings but still allow for some special characters.
  * '``' : will pass expressions inside

## Single char quotation (escape)

How to list folder with spaces:

```console
$ ls file\ with\ spaces.txt
file with spaces.txt
```

## Full quotation (escape)

Everything is treated as single string
between single quotes:

```console
$ echo '*** `pwd` $(pwd) $HOME ***'
*** `pwd` $(pwd) $HOME ***
$ cat >quote_multiline.sh <<'EOF'
> #!/bin/sh
> echo 'test multiline
> single quoted `pwd` $HOME $(pwd)
> string
> '
> EOF
$ sh quote_multiline.sh
test multiline
single quoted `pwd` $HOME $(pwd)
string

$ # Using here documents 
$ # ('EOF' is uniqer string delimeter, 
$ # single quote around it are significant,
$ # any delimeter may be used):
$ cat <<'EOF'
> *** `pwd` $HOME $(pwd) ***
> and other line
> EOF
*** `pwd` $HOME $(pwd) ***
and other line
```

## Partial quotation

To quote only whitespaces (without new lines)
and substitute variable and substitute command output

```console
$ echo "*** home=$HOME `pwd` $(pwd) ***"
*** home=/home/mk /home/mk/programming ***
$ # Using here documents 
$ # (EOF is uniqer string delimeter, 
$ # any delimeter may be used):
$ cat <<EOF
> *** Process working dir = `pwd` ***
> Home dir = $HOME
> $(pwd) 
> EOF
*** Process working dir = /home/mk/programming /home/mk/programming ***
Home dir = /home/mk
/home/mk/programming
```

## Multiline command

```console
$ # A multiline command
$ echo This is a \
> very long command!
This is a very long command! 
```


# Everything is memory and time!

On computer everything is memory state and time.
Memory is addressed. Time is ticked.


# Every memory address may be named by file

Here files hierarchy is method of addressing.
It can also contain some level of abstraction.
Usually reading, writing, opening etc. works
different for different file types.

But conclusion is important, everything on
computer may by named by file, and a lot of things
are.

For example: 
* Your (data) files are files. 
* Your directories are files. 
* Your hard drive is a file. 
* Your keyboard, monitor and printer are files. 
  * Yes, really: your keyboard is a read-only file of infinite size. 
  * Your monitor and printer are infinitely sized write-only files. 
* Your network connection is a read/write file.
* processes that run programs is also something, on UNIX it is
  addressed by file
* etc.

## Addresses may be connected, connection may be named by file

There are few frequently used addresses (files); those are
keyboard and display. Other things (files) may want to use
them.

Idea is as fallows, every process have few standard connections:
* Standard in (stdin) - the standard stream for input into a
  file.
* Standard out (stdout) - the standard stream for output out
  of a file.
* Standard error (stderr) - the standard stream for error
  output from a file.

# Streams in shell

What do you have to do to hook your script up to the
standard out, or read from the standard in? Well, the happy
answer is: nothing. Your scripts are automatically connected
to the standard in, out and error stream of the process that
is running them. 

# Cross-connecting processes streams

Wait, is it not just already heppening? Yes it is!  Standard
input of the interactive session is connected to the
keyboard file. In fact it is connected to the standard
output stream of the keyboard file. And the standard output
and error of the interactive session are connected to the
standard input of the monitor file. So you can connect the
streams of the interactive session to the streams of
devices.

## What are consequences?

You can connect your interactive shell session to the
printer or the network rather than to the monitor (or in
addition to the monitor) using streams. You can run a
program and have its output go directly to the printer by
reconnecting the standard output stream of the program. You
can connect the standard output stream of one program
directly to the standard input stream of another program and
make chains of programs. And the Bourne Shell makes it
really simple to do all that. 

# Redirecting

Bourne Shell has default connections and everything you do
is always a change in the default connections, connecting a
file to a (different) stream using the shell is actually
called redirecting.


There are several operators built in to the Bourne Shell
that relate to redirecting. The most basic and general one
is the pipe operator. The others are related to redirecting
to file. 


# Redirecting to file

First of all, so how to write program standard output
to regular file?

In order to achieve this you can imagine that we can use the
chaining mechanism described above: let a program generate
output through the standard output stream, then connect that
stream (i.e. redirect the output) to the standard input
stream of a program that creates a data file in the file
system.

And this is correct way of thinking. But for common operations
there also exists shortcuts:

* `process > data_file` : redirect the output of process to the data_file; create the file if necessary, overwrite its existing contents otherwise.
* `process >> data_file` : redirect the output of process to the data_file; create the file if necessary, append to its existing contents otherwise.
* `process < data_file` : read the contents of the data_file and redirect that contents to process as input.


## Redirecting standard output writing to file

To redirect source stream to sink stream:
```console
$ command arg1 arg2 1> outputfile.txt 2> errorfile.txt
```
Where:
* `command arg1 arg2` is command with args
* `1> outputfile.txt` is shell construct to configure
  process stdout (filedescriptor number = `1`) stream as
  file `outputfile.txt`
* `2> outputfile.txt` is shell construct to
  configure process stderr stream as file `errorfile.txt`.

Example, let hava program (script) writing to stdout:

```sh
#!/bin/sh
# hello.sh
# emits Hello to stdout
echo Hello
```

Above programm can be used to create file:

```console
$ # hello.sh 1> hello_file.txt
$ # have shortcut:
$ hello.sh > hello_file.txt
$ # lets examine:
$ cat hello_file.txt
Hello
$ # lets now append something..
$ hello.sh >> hello_file.txt
$ cat hello_file.txt
Hello
Hello
$ # no, lets overwrite this 
$ hello.sh > hello_file.txt
$ cat hello_file.txt
Hello
```

## Redirecting standard input reading to file

To redirect sing stream to source stream:
```console
$ command arg1 arg2 0< inputfile.txt
```
Where:
* `command arg1 arg2` is command with args
* `0< inputfile.txt` is shell construct to configure process
  stdin (filedescriptor number = `0`) stream as file
  `intputfile.txt`

By default 'stdin' is fed from your keyboard; run the 'cat'
command without any arguments and it will just sit there,
waiting for you to type something or end typing by signal CTRL+D:

```console
$ cat
I can type here
I can type here
How to finish it?
How to finish it?
CTRL+D was it?
CTRL+D was it?
$
```

To redirect input:

```console
$ # this uses command arguments
$ cat hello_file.txt
$ # and this cat is called without
$ # arguments, but telling shell
$ # to redirect input
$ cat < hello_file.txt
```

Next command configures `cat` command (without arguments) 
to use `hellow_file.txt` as stdin stream and file
`cat_out_hellow_file.txt` as stdout (overwrite) stream.

```console
$ cat > hellow_file.txt
Hellow

$ cat hellow_file.txt 
Hellow
$ cat < hellow_file.txt > cat_out_hellow_file.txt
$ # is shortcut of
$ # cat 0< hellow_file.txt 1> cat_out_hellow_file.txt
$ cat cat_out_hellow_file.txt 
Hellow
$ # order does not matter
$ cat > cat_out_hellow_file.txt < hellow_file.txt
$ cat hellow_file.txt 
Hellow
```

## Referencing existing streams (filedescriptors)

To reference filedescriptor (which may point to diffrent
files at different times) one can use `&n` where `n` is
filedescriptor number. It is available in context of
redirectors.

Example, how to redirect stdout and stderr to same file:

```console
$ ls nosuchfile.txt > alloutput.txt 2>&1
$ # alternatively:
$ ls nosuchfile.txt 1> alloutput.txt 2> alloutput.txt
```



# Pipes

A note on piped commands: piped processes run in parallel on
the Unix environment. Sometimes one process will be blocked,
waiting for input from another process. But each process in
a pipeline is, in principle, running simultaneously with all
the others. 

## Pipe fail

Pipe default return code is return code of last command.
If last command succeds even if earlier faild than overall
result is success. 

This behavior can be changed to if any fail, pipe also fail
setting shell options, this could be done inside shell using:

```sh
set -o pipefail
```
[set command reference](http://linuxcommand.org/lc3_man_pages/seth.html)

```
NAME
  set - Set or unset values of shell options and positional 
        parameters.
SYNOPSIS
  set [--abefhkmnptuvxBCHP] [-o option-name] [arg ...]
DESCRIPTION
  Set or unset values of shell options and positional 
  parameters.
  
  Change the value of shell attributes and positional 
  parameters, or display the names and values of shell 
  variables.
  
  Options:
    -o option-name
        Set the variable corresponding to option-name:
            pipefail      the return value of a pipeline is the 
                          status of the last command to exit with 
                          a non-zero status, or zero if no command 
                          exited with a non-zero status
```


## Piping processes

Interesting example:

```console
$ ps -ef | grep oracle | awk '{print $2}' | xargs kill -9
```

In this command, `ps` lists the processes and `grep` narrows
the results down to oracle. The `awk` tool pulls out the
second column of each line. And `xargs` feeds each line, one
at a time, to `kill` as a command line argument.


## Pipes brunching

```console
$ ps -ef | grep oracle | tee /tmp/myprocesses.txt
```

The `tee` will copy whatever is given to its stdin and
redirect this to the argument given (a file); it will also
then send a further copy to its stdout - which means you can
effectively intercept the pipe, take a copy at this stage,
and carry on piping up other commands; useful maybe for
outputting to a logfile, and copying to the screen. 

## Named pipes (file)

There is a variation on the in-line pipe which we have been
discussing called the 'named pipe'. A named pipe is actually
a file with its own 'stdin' and 'stdout' - which you attach
processes to. This is useful for allowing programs to talk
to each other, especially when you don't know exactly when
one program will try and talk to the other (waiting for a
backup to finish etc.) and when you don't want to write a
complicated network-based listener or do a clumsy polling
loop.

```console
$ # To create a 'named pipe', you use the 'mkfifo' command
$ mkfifo mypipe 
```

# What is going on in my script? (debugging)

<https://en.wikibooks.org/wiki/Bourne_Shell_Scripting/Debugging_and_signal_handling>

Tracing on:

```console
$ sh -x script_name.sh
```

Verbose mode:

```console
$ sh -v script_name.sh
```






