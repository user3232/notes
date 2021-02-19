##########################################
# make execution
##########################################


# make calling
# $ make  # run default task (all or top most)
# $ make task # run selected task
# $ make -d   # prints lots of informations
# $ make -n		# dry run
# $ make -p		# print make internal database
# $ make -r		# turn off builtin rules
# $ make --trace # print tracing informations


##########################################
# Including files:
##########################################


# files can be included:
# include foo bar.mk c.mk d.mk


##########################################
# Variables and references:
##########################################


AFLAGS = -f elf64# 			# variable with compiler flags
AFLAGS_DEBUG = $(AFLAGS)#	# variable with debug flags
AFLAGS_DEBUG += -g -F dwarf## variable with debug flags
                            # -> -f elf64 -g -F dwarf
ASM = nasm#                   # variable with compiler path
LD = ld#                      # variable with linker path
EMPTYVAR =#                   # empty variable
EMPTYVAR = redefined#         # variable can be redefined

$(warning only references can also be used)
$(warning typically when they cause sideeffects)

# create build directory
BIN = ./bin
$(info $(shell mkdir -p $(BIN)))

# Target specific variables:
# One may declare task and 
# its dependencies specific variable.
# It will be valid inside task and its
# dependencies task actions, this behaviour
# can be suppressed using 'private'
tarsk_and_deps : AFLAGS = -f elf64 -g
# tarsk_and_deps : private AFLAGS = -f elf64 -g


# Pattern-specific Variable Values:
# 'elf64_arch/%.o' and '%.o' is called **stem**
# patern is moore specyfic if it has longer stem
elf64_arch/%.o: EXAMPLE_FLAGS := -f elf64 -g
%.o: EXAMPLE_FLAGS := -g


##########################################
# Predefined variables
##########################################


# Predefined variables used by implicit rules (tasks) are:
# https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html


##########################################
# Enviroment
##########################################


# MAKEFILE_LIST is special (make) variable
# its appended with name of parsed file
# each time file is parsed
# finally it contain space separated directory
# list
last_parsed_file := $(lastword $(MAKEFILE_LIST))

# Every shell enviroment variable is visible with 
# with the same name, e.g. $(PATH) will contain
# system path.

# export variables to sub-make (subshell)
export last_parsed_file
# to prevent exporting to sub-make (subshell)
unexport last_parsed_file
# to export all, use single export:
# export


##########################################
# Tasks
##########################################


# top most and default (all) task:
all: $(BIN)/main

# variable with tasks (and also files) needed for build
OBJECTS = $(BIN)/main.o $(BIN)/dict.o $(BIN)/lib.o $(BIN)/main.lst $(BIN)/dict.lst $(BIN)/lib.lst

# build task for executable main
# action(s) must be tab indented
# they will be pushed to /bin/sh
# each line to separate subshell
# make will echo every action line if it not start with @
$(BIN)/main: $(OBJECTS) # dependences are from variable reference
	$(LD) -o $(BIN)/main $(BIN)/main.o $(BIN)/dict.o $(BIN)/lib.o

# compile task for main
$(BIN)/main.o $(BIN)/main.lst: main.asm colon.inc words.inc
	$(ASM) $(AFLAGS) -l $(BIN)/main.lst -o $(BIN)/main.o main.asm
# compile task for lib
$(BIN)/lib.o $(BIN)/lib.lst: lib.asm 
	$(ASM) $(AFLAGS) -l $(BIN)/lib.lst -o $(BIN)/lib.o lib.asm
# compile task for dict
$(BIN)/dict.o $(BIN)/dict.lst: dict.asm 
	$(ASM) $(AFLAGS) -l $(BIN)/dict.lst -o $(BIN)/dict.o dict.asm

# one may create multiple targets with single action:
foo bar biz &: baz boz
	echo $^ > foo	# prints all dependencies to foo file
	echo $^ > bar	# prints all dependencies to bar file
	echo $^ > biz	# prints all dependencies to biz file


##########################################
# Phony tasks
##########################################


# Phony tasks are tasks which have no file backup!
# That is it. They differ because their version
# (taken from timestamp, which not exists for not file)
# is never actual.

baz: ;# (phony) task with no dependencies and actions
boz: ;# (phony) task with no dependencies and actions

# phony task
clean:
	rm -f $(BIN)/main.lst $(BIN)/main.o $(BIN)/lib.lst $(BIN)/lib.o $(BIN)/dict.lst $(BIN)/dict.o $(BIN)/main

# phony task
help:
	echo 'This is the help' 

##########################################
# Functions
##########################################


# variable functions :
whoami    := $(shell whoami)#	# := is strict binding
host-type := $(shell arch)#		# $(shell ...) if function
MAJKI := ${MAKE} host-type=${host-type} whoami=${whoami}#

hash := $(shell printf 'Hellow world\n')
file_list := $(shell find . -name "*.asm")

# one may use variable to shell script binding:
hash_alt != printf 'Hellow world\n'
file_list_alt != find . -name '*.asm'


yo:
	@echo "I am: $(whoami)"
	@echo "My host is: $(host-type)"
	@echo "MAKE is: $(MAJKI)"
	@echo "hash is: $(hash)"
	@echo "file_list is: $(file_list)"
	@echo "hash_alt is: $(hash_alt)"
	@echo "file_list_alt is: $(file_list_alt)"


# substitutions:
foo := a.o b.o l.a c.o#
bar := $(foo:.o=.c)# 					# -> a.c b.c l.a c.c
bar_equiv := $(patsubst %.o,%.c,$(foo))## -> a.c b.c l.a c.c

substitutions:
	@echo $(bar)
	@echo $(bar_equiv)


##########################################
# Text Functions
##########################################


substitute := $(subst ee,EE,feet on the street)
# -> fEEt on the strEEt
needs_made =   	   	  # -> spaces and tabs
ifneq   "$(strip $(needs_made))" ""
will_make = yes
else
will_make = no
endif
# -> will_make = no
findstring = $(findstring a,a b c)
# -> a
different_sources := foo.c bar.c baz.s ugh.h
c_s_sources := $(filter %.c %.s,$(sources))
# -> foo.c bar.c baz.s
my_objects := main1.o foo.o main2.o bar.o
my_mains := main1.o main2.o
my_objects_without_mains := $(filter-out $(my_mains),$(my_objects))
# -> foo.o bar.o
sorted := $(sort foo bar lose)
# -> bar foo lose
second_word := $(word 2, foo bar baz)
# -> bar
word_sublist := $(wordlist 2, 3, foo bar baz)
# -> bar baz
number_of_words := $(words 1 2 yo hey)
# -> 4
last_word_of_text := $(word $(words text), 1 2 3 4 yo )
# -> yo
first_word := $(firstword foo bar)
# -> foo
lastword := $(lastword one two)
# -> two


##########################################
# Dir Functions
##########################################


dir_names := $(dir src/foo.c hacks)
# -> src/ ./
not_dir_names := $(notdir src/foo.c hacks)
# -> foo.c hacks
names_suffixes := $(suffix src/foo.c src-1.0/bar.c hacks)
# -> .c .c
base_names := $(basename src/foo.c src-1.0/bar hacks)
# -> src/foo src-1.0/bar hacks
added_suffixes := $(addsuffix .c,foo bar)
# -> foo.c bar.c
added_preffixes := $(addprefix src/,foo bar)
# -> src/foo src/bar
join_pairwise := $(join a b,.c .o)
# -> a.c b.o

# $(wildcard pattern)
# $(realpath names…)
# $(abspath names…)


##########################################
# Test Functions
##########################################


# $(if condition,then-part[,else-part])
# $(or condition1[,condition2[,condition3…]])
# $(and condition1[,condition2[,condition3…]])


##########################################
# Special Functions
##########################################


# foreach:
find_files = $(wildcard $(dir)/*)
dirs := a b c d
files := $(foreach dir,$(dirs),$(find_files))
# is quivalent to:
files := $(wildcard a/* b/* c/* d/*)


# read/write file:

# reading not supported by make --version < 4.2
# read_lib_asm := $(file < lib.asm)
read_lib_asm := $(shell cat lib.asm)
override_test_file := $(file >> test," Overriden by make function ")
append_test_file := $(file >> test," Appended by make function ")

# macros:

reverse = $(2) $(1)
foo = $(call reverse,a,b)
# -> b a

# keeping variable not expanded: 

# The value function provides
# a way for you to use the value of a variable without
# having it expanded
value_function_example = $PATH
value_function_example_task:
	# probably ATH because $P is undefined
	@echo $(FOO)
	# ok, will show $PATH env variable
	@echo $(value FOO)

# complex macros:

# use eval function
# example
# https://www.gnu.org/software/make/manual/html_node/Eval-Function.html


# what is variable origin? (undefined, default, environment, file ...)

phony_origin := $(origin .PHONY)

# what is flavor of variable? (undefined, recursive, simple)
phony_origin_flavor := $(flavor phony_origin)
# -> simple


# diagnostic functions:

# $(error text…)
$(warning I worn you)
$(info Just logging)


# taking results of shell:

content_of_dict := $(shell cat dict.asm)


##########################################
# Nested variables
##########################################


x = variable1#
variable2 := Hello#
y = $(subst 1,2,$(x))#	# y -> variable2 
z = y# 					# z -> y
a := $($($(z)))# 		# a ->  $(variable2) -> Hellow

x_objects := a.o b.o c.o
y_objects := 1.o 2.o 3.o
x_or_y := y
sources := $($(x_or_y)_objects:.o=.c)## -> 1.c 2.c 3.c

dir = .
$(dir)_objects := $(wildcard $(dir)/*.o)
define $(dir)_print =
cat $($(dir)_objects)
endef

nestedVariables:
	@echo $(a)
	@echo $(sources)
	@echo $($(dir)_objects)
	@echo $($(dir)_print)


##########################################
# Multiline variables
##########################################


# = means that two-lines variable is lazyely bound
# When used in a recipe, 
# the below example is 
# functionally equivalent to this: 
#
# two-lines = echo foo; echo $(bar)
# note 2 subshells will be executed
define two-lines =
echo foo
echo $(bar)
endef


##########################################
# Conditionals
##########################################


# As this example illustrates, conditionals work at the
# textual level: the lines of the conditional are treated as
# part of the makefile, or ignored, according to the
# condition.

libs_for_gcc = -lgnu
normal_libs =

ifeq ($(CC),gcc)
  libs=$(libs_for_gcc)
else
  libs=$(normal_libs)
endif


# declare what task are phony (for optimization)
.PHONY: clean help baz boz

