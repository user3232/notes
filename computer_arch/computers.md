
<style>
body {
text-align: justify}
</style>


# What is this about?


* How computer works?
* What is possible?
* What is needed?
* How things are translated to assembler?
* How things are translated to transistors?
* How to build computer from switches?
* What is proccess?



# Computing process

Computer executes stream of bytes on tape which
alters bytes on the same or other tape. 
Tape moves incrementaly but can also be moved
by execution. Its oparation is purely mechanical. 

Conceptually computing process is as fallows:

```
                       __________   
                      |          |    Memory
  Instruction         |          |----------
----------------------| Machine  |     IO 
  Handler             |          |----------
----------------------|__________| 
                                    
```

Machine reads instruction or handler tape and move it forward, 
based on read iword it:
* moves any tape (instruction, memory, io) or
* copy data from to any tape or
* set data to any tape.

Then machine reads instruction or handler tape and process repeats.
Handler tape is kernel.


# Computer realisation


**Computer** is realized as paths for voltage configured by switches.
Switches can be controled by the same voltage. State is voltage.


**ROM** memory is paths. It can be realised as DIP switch and voltage source
and ground sink.


**RAM** memory is paths configured by self switches 
(switches switching themself),
which can be configured by voltage at time and persist its state 
(when voltage is off switches get its default state).
Memory cell for 1 bit can be realized as: 2 transistors 
(with different default states npn and pnp) with interconnection of
voltage passing by first transistor and control of second transistor,
and other way around. 2 resistors (typically transistors) to control current.
State access transistor (typically 2). Bus control transistors, configuring
read/write paths. Voltage source and ground sink. 
Voltage passing by selected transistor is bit state.

**NVM** (non vailentale memory) is paths configured configured by switches,
which can be configured by voltage at time and persist its state 
(even when voltage is off). It can be realised as paths and voltage
source and ground sink, controlled by switches controlled by magnetization.
There is magnetizing header which must be placed over 
memory bit physical region.


**Addressing** is realized as giving voltage to paths 
connected to control of transistors
controling other paths. Those transistors control tree like paths,
so few addressing lines can generate much more possible paths. 
Paths to control transistors are enlonged to the longest of them,
so voltage propagation delays would be the same.


**Functions** is encoding path to path. Any (finite valued) 
mathematical function can be
thought as mapping inputs (represented as paths) 
to outputs (represented as paths).
It can be realised as addressing with custom control transistors placement
(not neccessarely tree like).


**Control Unit** is buisy wait (enabling buses/subsystems in sequence). It:

* selects source to instruction address and target to decoder address (fetch instruction), 
* set decoder with instruction (fetch instruction), 
* decode instruction value (decode), 
* selects source  and target addresses (execute instruction), 
* set memory/register (execute instruction), 
* increment next instruction address,
* check IOs (can be dynamically configured which),
  * fetch/decode/execute instructions for IO if needed,

and loop back.

It can be realised as counters selecting apriopriate functions.
(Counter = increment by 1 function + memory element)




# Machine with IO executing program (single program scenerio)

Assume machine can execute one program.
This program must be buisy wait or it will
be not responsive to IO.


Machine execute one program.
Program is computing and then terminate.
In the mean time IO interrupt occures,
temporarly interrupt code at predefined
address is executed. It can alter memory
of main program so main program execution
may change, but no more interaction is possible.
Interaction as bidirectional communication
is possible only between two buisy/IO waits programs.
Only few registers are reserved for kernel.
For kernel and user code most registers are shared, so
copy of those resources must be saved someware.
Kernel and user code can use shared stack,
but stack is constructed in such a way that,
its sharing is save when some conventions are
preserved by kernel. So shared registers can be
saved on the stack, kernel than can use them, and
after that registers can be loaded from the stack.





# Executable file (ELF)

Assume we have one program computer with IO interrupts.
We can ignore interrupts, then default handler will handle
them or no operation will be performed.

Computer is busy wait program realised as paths and transistors.
This busy wait function takes implicit arguments (as predefined addresses):

* normal execution function handeler (user)
* interrupt execution function handler (kernel)
* dynamic memory region (user and kernel)
  * stack (user and kernel)
  * heap (user maybe kernel)
* static memory region (user)
* static memory region (kernel)











# ELF navigation


How is it realised?
How does it works?

What does is?
What is it needed?


Assembler from which ELF will be generated


```assembly

.rodata
msg:    "Hi there\n"
const:  77

.text
.global main

main:   pushl   %ebp
        movl    %esp, %ebp         
        call    getchar         
        cmpl    $'A', %eax         
        jne     skip         
        pushl   $msg         
        call    printf         
        addl    $4, %esp

skip:   movl    $0, %eax
        movl    %ebp, %esp
        popl    %ebp
        ret

``` 




ELF will contain
(static block = not changable memory layout, constant size):

* text section - static block of program codes,
* data section (.rodata, .bss, etc.) - static block(s) of program data,
* maps for execution:
  * block name to block address,
  * global name to block name to location address
* maps for linking:
  * ...



Runtime ready ELF is:

* ELF Header:
  * where it should start executing?
* ELF Program Header Table:
  * where it should be loaded?
  * start address of program,
  * size in memory,
* .text - program with every address set:
  * labels are resolved to adressess,
  * external labels (sys cols) are resolved to adressess,
* .data - program data as stream of bytes
  * every string -> bytes
  * every number, float -> bytes, etc. 


Link ready machine code with gaps and link tables (as ELF):
* Section header table:
  * address of null terminated name of section
  * type of section
  * flags, eg.: for .text  allocated, executable, for .rodata allocated,
  * virtual addresses of sections to be loaded,
  * offset in image file
  * size in image file



## Static executable


To execute program image => neede info is: 
* instructions translated to machine numbers
* references translated to machine (virtual) addresses
* (in different words fully resolved .text and .data).


Loader (puts program image in memory, register as proces and starts) 
=> need info (from ELF header) is:
* image type,
* where start execution,
* to what address load image.



Linker => needed info is:
* sections to work with
* global symbol/system call tables
=> produces program image


Assembler => needed info is:
* sections to work with
* local symbol/sys call tables
=> produces linkable image




## Header





## Symbol table - informations exposed to OS

Navigation from name of assembly place to memory address:

* Label - name of address,
* Section = .text | .bss | .rodata | ... ,
* Offset = address within section,
* Local? = Local | Global -> is lab,
* Seq# = uint name isomorphism.


| Label    | Section     | Offset | Local? | Seq# |
|----------|-------------|--------|--------|------|
| msg      | rodata      |    0   | local  | 0    |
| const    | rodata      |   11   | local  | 1    |
| main     | text        |    0   | global | 2    |
| skip     | text        |   26   | local  | 3    |
| getchar  | ?(external) |   ?    | global | 4    |
| printf   | ?(external) |   ?    | global | 5    |



## Realocation table - informations to be filled by OS


* Section - name of binary block,
* Offset - address within section block,
* Rel Type - where search for machine code address, displacement - externaly (by OS), absolute (code within ELF),
* Seq# - uint name isomorphism.


| Section | Offset | Rel          | Seq# | (Notes) |
|---------|--------|--------------|------|---------|
| text    |   4    | displacement | 4    | getchar |
| text    |   14   | absolute     | 0    | $msg    |
| text    |   19   | displacement | 5    | printf  |



## RODATA section to machine code translation


* Offset - address of data in this block,
* Contents - machine code for data (number to bin, string to bin),
* Explanation - my explanation (assembler to machine code),
* location counter - internal for table building, for computing next offset.



| Offset | Contents (bin) | Explanation |
|--------|----------------|-------------|
| 0      |                |    "H"      |
| 1      |                |    "i"      |
| 2      |                |    " "      |
| 3      |                |    "t"      |
| 4      |                |    "h"      |
| 5      |                |    "e"      |
| 6      |                |    "r"      |
| 7      |                |    "e"      |
| 8      |                |    "\n"     |
| 9      |                |    "\0"     |
| 10     |                |    77       |




## TEXT section to machine code translation


* Offset - byte address of data in this block,
* Contents - machine code,
* Explanation - my explanation (assembler to machine code),
* location counter - used for table building, for next ofset computation.


| Offset | Contents (bin) | Explanation      |
|--------|----------------|------------------|
| 0      |                | pushl %ebp       |
| 1      |                | movl  %esp, %ebp |
| 3      |                | call getchar     |
| 4      |                | getchar          |
| 8      |                | cmpl %'A',%eax   |
| 11     |                | jne skip         |
| 13     |                | pushl            |
| 14     |                | $msg             |
| 18     |                | call             |
| 19     |                | printf           |
| 23     |                | addl $4,%esp     |
| 26     |                | movl $0,%eax     |
| 31     |                | movl %ebp,%esp   |
| 33     |                | popl %ebp        |
| 34     |                | ret              |



# How works program loading?

Statically, every instruction and external instruction
and data are resolved to machine code, then program image
is added to collection of programs and copied to virtual
(RAM) memory, as if it only existed with kernel.


Dynamically, references (to libraries, data)
are resolved when needed and probably Symbol Table is updated
with address of symbol and also machine code seying its reference
is overriten with address.

For this program must have address of resolver code. On Linux
it is ld.so dynamically loaded program library.


# How works program linking?

Process of resolving symbols.
It needs to build masp:
* symbol name to address, and
* code place to symbol.


When static image is build, all code and data symbols
are overriten with apriopriate addresses.


When dynamic image is build, symbol->addres table and place->symbol table
are exported along with code and date (with unresolved symbols for externals).


Probably in machine code symbols are instruction: resolve symbol with id, 
for example symbol with id 5 could be written in machine code as:


```assembly
sym 5  => 0000 0101 | 0000 0000 0000 0000 0000 0000 0000 0101 => opcode | id 
```

# How works dynamic linking?


So how are resolved symbols from external libraries?
What is convension for named addresses? Probably
program (virtual) memory is divided to sections so every named memory:
* have agreed relative offset address of section-name->section-offset map and
* symbol-name->section-name-offset map.

Then it is possible to resolve names of form:
library-path symbol-name-path .



# How works interpeter?


Interpreter is (static or dynamic) program loaded to memory and executed,
which then:
* maps data to program code and
* adds produced code to itself.

It can do it at once or typically pice by pice.

Everytime interpreter is run it must do something for itself,
it would be moor efficient if for new interpretation task,
it would clone itself after self managment and run separately.
Fork, exec functions (system calls) do something like that
(they create new proccesses with state cloned from parent actual state 
- opened files, what about opened dlls?, etc. and with replaced code).
But I don't know how it could be done perfectly. Every time interpreter
needs to start from scratch, or it must get informations from server/service.

Fork may be the answer, because after initialization, there may be only fork
and only work on interpretation of script. It would be demonized world,
comunication by something like this: 
```./interpreterCommunicatorWithDeamon scriptToInterpret.script```.


# How works copying (forking) new processes?

New process has the same image and (part of) state as orginal process.
It could be done efficiently using cached memory, adding new process id
to orginal process memory pages and setting mode copy, split owners, 
normal mode on page write. Then forking would cost almost nothing
and could be done very quickly.



# Why process groups?


# How memory protection works? How hardware architecture can support this?


# How operates virtual memory? Could it be skipped by user/kernel program?


# How things can communicate using memory locations?

2 things cannot do different things to one thing at the same time!!!
Some oracle is needed... Bistable component???...

One big buisy wait, or two buisy waits?

Full buffer, or some kind of queue?

What with the scheme of ordering/sequencing/succession?


# How memory pages are implemented and supported by hardware?


# How communication of programm with kernel works?

There is no communiction, computer works as fallows:

```...do atom check, do atom check, ...```

so to "communicate" do atom must influence check.

Computer is one program, user programs are Program fragments
that can be put only in predefined places.

We actually dont run programs but put user programs code in 
apriopriate places and computer runes them, but it look
likes we run them.


# How meny processes kernel has?

No more and no less than one.!

It is possible to split kernel to few processes doing
not (much) interconnected things, where finishing
those things sooner or later (undeterministically) wouldnt
make a diffrence, but still managment of those process scheduling
would be done by one process and this process whould be called
"kernel core" for example, and kernel processes would be like
user processes but with moore privilages.

It would be useful when some kernel services would need to wait
to make final decision how to serve.


# How hardware could shorten system call time?

E.g. getTime is system call, is it possible shortcut
for not protected informations?

How would work security of such a system call shortcut?


# How hardware could accelerate contex switch? process/process, process/kernel?

What is context actually?
It is probably access to memory locations protection...
Some memory is accessable to everyone, other only for kernel...


# What is the difference between function and macro from CPU point of view?

Functions must be reentrant, must have algorithm for allocation its memory
every time they are executed, so they **must** use call stack with function
frames. This call stack is actually memory vector (free access) 
and agreement how to use it. It could be stored as machine code.


Macro would be code, not reentrant, something as static function with only
references. It could be stored as machine code.


Parametrised macro would code which could be parametrised.
There is no common agreement how to stora such a thing as machine code.


# What is, what needs serial communication at hardware level?



# What is, what needs parrallel communication at hardware level?



# How works buffored communications at hardware level, what it needs?


# Governation, what are implications and necessities of master/slaves, peer/peer schemes?


# How works ISA, SATA, eSATA controller/devices communication at hardware level?


# How works I2C, SPI communication?


# Networks, what are types neccessieties implications?


# Virtualisation support at hardware level?


# Where is virtual machine in computer Program?


# How copy data and allow CPU handle other tasks?

Rule number 1: one thing cannot be used by two things at the same time!!!

So it is possible only when we have situation isomorphic to having two RAMs:

* memory needed by CPU is in cache, then disk controller can comunicate with
  RAM controller (with CPU governation) by main bus letting CPU do other work.
* RAM (which typically have 8 data banks) have 2 data and address paths,
  CPU uses one path, than other path may by used by disk

This also needs controlling 2 things: CPU work and Copy work.
So there could be slave controllers (for RAM, Disk, other IOs).





# To do

.text segment
.bss segment
.data segment
heap
stack

.ktext
.kdata

memory protection
system calls infrastructure

  

