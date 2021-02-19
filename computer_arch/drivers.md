
# Shortcuts

* \<alt\>\<shift\>\<left\|right\> - select block relative to cursor.
* \<ctrl\>\<shift\>\<up\|down\> - mult-cursor.
* \<alt\>\<shift\>\<cursor\> - block selection.

```mermaid

graph LR;
  A --> B;

```

```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```


# What is a program?



* Program package is one file with code saved in appropriate format.

* Program source is one file with code and possibly references to other files with code.

* Project is one executable file producing executable file.

* **Program is program with arguments.**

* **Programming is program with arguments producing program (possibly many times).**

* **To program is to have machine with program returning programs.**

* **Everything you do or could done is name program and name its arguments.**

## What is executed?

System is a program which execute oder programs.

System is first firmware, => firmware executes then boot loader
=> boot loader executes then operating system =>
OS executes user programs.

Microprocesor executes firmware, but at the end also boot loader, OS
and user programs.

Each program must have compatible ABI (application binary interface) 
of its runtime program.

![https://en.wikipedia.org/wiki/Memory_address](images/Paging.svg "Memory")

![https://en.wikipedia.org/wiki/Executable_and_Linkable_Format](images/ELF_Executable_and_Linkable_Format_diagram_by_Ange_Albertini.png "ELF")


# Architecture

Harvard architecture:

![https://en.wikipedia.org/wiki/Harvard_architecture](images/Harvard_architecture.svg "Harvard")

Von Neumann architecture:

![https://en.wikipedia.org/wiki/Von_Neumann_architecture](images/Von_Neumann_Architecture.svg "Neumann")


## [Modified Harvard architecture](https://en.wikipedia.org/wiki/Modified_Harvard_architecture#Modified_Harvard_architecture)


> Accordingly, some pure Harvard machines are specialty products. Most modern computers instead implement a modified Harvard architecture. Those modifications are various ways to loosen the strict separation between code and data, while still supporting the higher performance concurrent data and instruction access of the Harvard architecture.
> 
> Split-cache (or almost-von-Neumann) architecture
> 
> The most common modification builds a memory hierarchy with separate CPU caches for instructions and data at lower levels of the hierarchy. There is a single address space for instructions and data, providing the von Neumann model, but the CPU fetches instructions from the instruction cache and fetches data from the data cache.[1] Most programmers never need to be aware of the fact that the processor core implements a (modified) Harvard architecture, although they benefit from its speed advantages. Only programmers who generate and store instructions into memory need to be aware of issues such as cache coherency, if the store doesn't modify or invalidate a cached copy of the instruction in an instruction cache. 

# Stack machines


From Wikipedia article [Stack machine](https://en.wikipedia.org/wiki/Stack_machine);

```assembly
# stack contents (leftmost = top):
push A          #           A
push B          #     B     A
push C          # C   B     A
subtract        #     B-C   A
multiply        #           A*(B-C)
push D          #     D     A*(B-C)
push E          # E   D     A*(B-C)
add             #     D+E   A*(B-C)
add             #           A*(B-C)+(D+E)
```


# Sequentiality

Computing machines are build philosophicaly as sequential.
Von Neumann architecture is sequential, with ist typical register 
program counter (PC), which is usualy incremented after featching
an instruction and holds memory adress of next instruction that would 
be executed.

This gives also 
[Consequences in high-level programming](https://en.wikipedia.org/wiki/Program_counter#Consequences_in_machine_architecture):

Modern high-level programming languages still follow the sequential-execution model and, indeed, a common way of identifying programming errors is with a “procedure execution” in which the programmer's finger identifies the point of execution as a PC would. The high-level language is essentially the machine language of a virtual machine,[10] too complex to be built as hardware but instead emulated or interpreted by software.

However, new programming models transcend sequential-execution programming:

* When writing a multi-threaded program, the programmer may write each thread as a sequence of instructions without specifying the timing of any instruction relative to instructions in other threads.
* In event-driven programming, the programmer may write sequences of instructions to respond to events without specifying an overall sequence for the program.
* In dataflow programming, the programmer may write each section of a computing pipeline without specifying the timing relative to other sections.



# Adresses

Typically smallest adressable unit of space is Byte (8 bits).

It can be [flat memory](https://en.wikipedia.org/wiki/Flat_memory_model)
adress space - continous index. It can be result of simulation by OS/hardware.

But [Harvard Architecture](https://en.wikipedia.org/wiki/Harvard_architecture)
has to adress spacess, one for code, one for data. It also can be
some segments simulated into continous linear indexex.

Memory translation is scheme used by OS for example for adress space
protection of concurent programs, resources protection, etc..

## Absolute adressing

## Relative adressing

Typically DLLs will use relative adresses.

Object files also uses somethint like that, but needs prelinking.

# Configurable machines - Boot sequence of x86

1. First instruction is located at reset vector (FFFFFFF0h) usually pointing
at some location at the ROM.
2. Now in ROM, usually Power On Self Test (POST) which set up DRAM and PCI bus
3. (Now in ROM) travel list of bootable devices
   1. Load boot sector to linear adress 7C00h in RAM
   2. Now in RAM, run Kernel


## [BIOS](https://en.wikipedia.org/wiki/BIOS)

After the option ROM scan is completed and all detected ROM modules with valid checksums have been called, or immediately after POST in a BIOS version that does not scan for option ROMs, the BIOS calls INT 19h to start boot processing.

When INT 19h is called, the BIOS attempts to locate boot loader software on a "boot device", such as a hard disk, a floppy disk, CD, or DVD. It loads and executes the first boot software it finds, giving it control of the PC.

The BIOS uses the boot devices set in EEPROM, CMOS RAM or, in the earliest PCs, DIP switches. The BIOS checks each device in order to see if it is bootable by attempting to load the first sector (boot sector). If the sector cannot be read, the BIOS proceeds to the next device. If the sector is read successfully, some BIOSes will also check for the boot sector signature 0x55 0xAA in the last two bytes of the sector (which is 512 bytes long), before accepting a boot sector and considering the device bootable.

When a bootable device is found, the BIOS transfers control to the loaded sector. The BIOS does not interpret the contents of the boot sector other than to possibly check for the boot sector signature in the last two bytes. Interpretation of data structures like partition tables and BIOS Parameter Blocks is done by the boot program in the boot sector itself or by other programs loaded through the boot process.

A non-disk device such as a network adapter attempts booting by a procedure that is defined by its option ROM or the equivalent integrated into the motherboard BIOS ROM. As such, option ROMs may also influence or supplant the boot process defined by the motherboard BIOS ROM. 

# Piping programs

## Piping standard input, output and error streams of programs

Pipe | is program for joining programs standard input, output and error streams.
Input output and error are (variable) memory locations with data (files).
[Example](https://en.wikipedia.org/wiki/Named_pipe):

```bash
$ ps -a | sort | uniq | grep -v sh
```
ps -a returns lines with running processes names,
sort sorts those lines, uniq filters repeating lines,
grep -v sh filters lines containing sh string.



Piped programs can be run:

*  in sequence + buffer for whole data, 
*  in pararelly with process freezing and scheduling + buffer for data chunks (64 KB).

## Named pipes

Pipe semantics can be also represented as (special) file created
by command:

```bash
mkfifo -m 0666 fileNamePath
```

Programs can read or write to this file, but it blocks until
there is one reader and one writer. 
[Named pipe file doc](https://linux.die.net/man/7/fifo):

> A FIFO special file (a named pipe) is similar to a pipe, 
> except that it is accessed as part of the file system. 
> It can be opened by multiple processes for reading or writing. 
> When processes are exchanging data via the FIFO, 
> the kernel passes all data internally without writing it to the file system. 
> Thus, the FIFO special file has no contents on the file system; 
> the file system entry merely serves as a reference point 
> so that processes can access the pipe using a name in the file system.

Shell syntax for expresions for files is 
[process substitution](https://en.wikipedia.org/wiki/Process_substitution#Anonymous_named_pipe).


[Example](https://en.wikipedia.org/wiki/Named_pipe#In_Unix) + comments:

```bash
# create pipe file (descriptor)
mkfifo my_pipe

# compress data from named pipe to file out.gz
# do not wait for process termination (empty pipe will block)
# will work as server, need to be killed for termination
# (or maybe error...)
gzip -9 -c <my_pipe >out.gz &
# no FILE argument or - read std in,
# -c write on std out,
# -1 compress fast, -9 compress good,
# <in_file is std in redirection to file name/path,
# >out_file std out redirection to name/path of file,
# & don't wait for program termination but
# immediately returns to shell.
# gzip settings can be specified by PATH variable, eg.:
# > GZIP="-8v --name"; export GZIP

# In a separate process shell, independently, 
# one could send the data to be compressed:
cat file > my_pipe

# The named pipe can be deleted just like any file:
rm my_pipe
```

[**Very important info on named pipes on Windows!!!**](https://en.wikipedia.org/wiki/Named_pipe#In_Windows)



## Network pipes

It is possible to connect other types of files using as pipe program netcat.
It allows connection of processes standart in out err by TCP/IP network.


# Memory


[Memory hierarchy](https://en.wikipedia.org/wiki/Memory_hierarchy)

There are four major storage levels.

1. Internal – Processor registers and cache.
2. Main – the system RAM and controller cards.
3. On-line mass storage – Secondary storage.
4. Off-line bulk storage – Tertiary and Off-line storage.

This is a general memory hierarchy structuring. Many other structures are useful. For example, a paging algorithm may be considered as a level for virtual memory when designing a computer architecture, and one can include a level of nearline storage between online and offline storage. 

![https://en.wikipedia.org/wiki/Memory_hierarchy](images/ComputerMemoryHierarchy.svg "Memory hierarchy")



[Virtual memory](https://en.wikipedia.org/wiki/Virtual_memory)

![virtual memory diagram](./images/Virtual_memory.svg "Virtual memory diagram")

From Wikipedia [Page Cache](https://en.wikipedia.org/wiki/Page_cache):

![https://en.wikipedia.org/wiki/Page_cache](./images/IO_stack_of_the_Linux_kernel.svg "Linux kernel's storage stack.")


## Virtual memory common uses

From Wikipedia [Memmory mapped file](https://en.wikipedia.org/wiki/Memory-mapped_file):

> Perhaps the most common use for a memory-mapped file is the process loader in most modern operating systems (including Microsoft Windows and Unix-like systems.) When a process is started, the operating system uses a memory mapped file to bring the executable file, along with any loadable modules, into memory for execution. Most memory-mapping systems use a technique called demand paging, where the file is loaded into physical memory in subsets (one page each), and only when that page is actually referenced. In the specific case of executable files, this permits the OS to selectively load only those portions of a process image that actually need to execute.
> 
> Another common use for memory-mapped files is to share memory between multiple processes. In modern protected mode operating systems, processes are generally not permitted to access memory space that is allocated for use by another process. (A program's attempt to do so causes invalid page faults or segmentation violations.) There are a number of techniques available to safely share memory, and memory-mapped file I/O is one of the most popular. Two or more applications can simultaneously map a single physical file into memory and access this memory. For example, the Microsoft Windows operating system provides a mechanism for applications to memory-map a shared segment of the system's page file itself and share data via this section. 



[mmap](https://en.wikipedia.org/wiki/Mmap):

In computing, mmap(2) is a POSIX-compliant Unix system call that maps files or devices into memory. 



# Files

Control of computer hardware is done by files, in my opinion because
file can be given arguments, as program, but
this file program have also resource semantics, as hardware is finite
resource. 

We can copy and use the same program and we can get predicted
results, but we can't copy harddrives perform operations on those and
expect predicted results in any simple way.


## Filesystem

[devtemfs for /dev service](https://unix.stackexchange.com/questions/77933/using-devtmpfs-for-dev):

> devtmpfs is a file system with automated device nodes populated by the kernel. 
> This means you don't have to have udev running nor to create a static /dev 
> layout with additional, unneeded and not present device nodes. Instead the 
> kernel populates the appropriate information based on the known devices.
> 
> On the other hand the standard /dev handling requires either udev, an 
> additional daemon running or to statically create device nodes on /dev.


[driver-core: devtmpfs - driver core maintained /dev tmpfs](https://lwn.net/Articles/330985/):

> Devtmpfs lets the kernel create a tmpfs very early at kernel
> initialization, before any driver core device is registered. Every
> device with a major/minor will have a device node created in this
> tmpfs instance. After the rootfs is mounted by the kernel, the
> populated tmpfs is mounted at /dev. In initramfs, it can be moved
> to the manually mounted root filesystem before /sbin/init is
> executed.
> 
> The tmpfs instance can be changed and altered by userspace at any time,
> and in any way needed - just like today's udev-mounted tmpfs. Unmodified
> udev versions will run just fine on top of it, and will recognize an
> already existing kernel-created device node and use it.
> The default node permissions are root:root 0600. Only if none of these
> values have been changed by userspace, the driver core will remove the
> device node when the device goes away. If the device node was altered
> by udev, by applying the appropriate permissions and ownership, it will
> need to be removed by udev - just as it usually works today.
> 
> This makes init=/bin/sh work without any further userspace support.
> /dev will be fully populated and dynamic, and always reflect the current
> device state of the kernel. Especially in the face of the already
> implemented dynamic device numbers for block devices, this can be very
> helpful in a rescue situation, where static devices nodes no longer
> work.
> Custom, embedded-like systems should be able to use this as a dynamic
> /dev directory without any need for aditional userspace tools.
> 
> With the kernel populated /dev, existing initramfs or kernel-mount
> bootup logic can be optimized to be more efficient, and not to require a
> full coldplug run, which is currently needed to bootstrap the inital
> /dev directory content, before continuing bringing up the rest of
> the system. There will be no missed events to replay, because /dev is
> available before the first kernel device is registered with the core.
> A coldplug run can take, depending on the speed of the system and the
> amount of devices which need to be handled, from one to several seconds.


## Unix file types

Type of unix file is first of characters describing files
outputted by command ls -l

* \- hyphen: means regular file, (layout may be arbitrary),
* d directory: it has directory file layout, but there are many filesystems, each can have diffrent,
* l symbolic link: has textual structure representing path (absolute/relative) to referenced file,
* p FIFO (named pipe): pipe structure (- maybe name, buffer, file descriptors, currently conected programs), typically half duplex inter proces communication IPC,
* s Socket, socket structure (but maybe not file), IPC full duplex,
* c Device Character File: device structure, unbuferred acces to data,
* b Device Block File: device structure, buffered access of data.

Device files commonly are part of virtual file system traditionally mounted
at /dev, possibly associated with controlling deamon (monitoring addition and
removal of hardware) - at linux this deamon is called udev.

## Typical unix devices and pseudo devices

Tip, to check device type, do for example:
``` bash
ls -l /dev/zero
# crw-rw-rw- 1 root root 1, 5 lut  4 11:42 /dev/zero
```

List of some linux/win devices can be found in 
[Wikipedia](https://en.wikipedia.org/wiki/Device_file).

File types linux/win also 
[Wikipedia](https://en.wikipedia.org/wiki/Unix_file_types).



Pseudo devices:

* /dev/null - character write anything, read nothing (EOF end of file),
* /dev/zero - character pseudo device - write anything, read zeros,

Bidirectional data connection and transfer .SCSI driver, also used by 
libATA (modern PATA/SATA driver), USB, IEEE 1394, etc.

* /dev/sd - mass-storage driver
  * /dev/sda - first registered device
  * /dev/sdb, sdc, etc. - second, third, etc. registered devices
* /dev/ses - Enclosure driver
* /dev/sg - generic SCSI layer
* /dev/sr - “ROM” driver (data-oriented optical disc drives)


NVMe driver, non-volatile storage media attached via a PCI Express (PCIe) bus.
The acronym NVM stands for non-volatile memory, which is often NAND flash memory
that comes in several physical form factors, including solid-state drives (SSDs),
PCI Express (PCIe) add-in cards, M.2 cards, and other forms.

* /dev/nvme
  * /dev/nvme0 - first registered device's device controller (character device)
  * /dev/nvme0n1 - first registered device's first namespace (block device)
  * /dev/nvme0n1p1 - first registered device's first namespace's first partition (block device)

Graphics:

* /dev/fb - frame buffer - display pixel buffer

Printers:

* /dev/lp - line printer

Terminals:

* /dev/tty - ....
  * /dev/ttyS - (platform) serial port driver
  * /dev/ttyUSB - USB serial converters, modems, etc.


Pseudo terminals:

* /dev/pt - 


Mouse, keyboard:
* /dev/psaux (PS/2)

Sound cards, (DSP - digital signal processor):
* /dev/dsp

USB devices:
* /dev/usb (USB Devices)


# System calls tools

From Wikipedia article [System calls](https://en.wikipedia.org/wiki/System_call):

On Unix, Unix-like and other POSIX-compliant operating systems, popular system 
calls are open, read, write, close, wait, exec, fork, exit, and kill. Many 
modern operating systems have hundreds of system calls. For example, Linux and 
OpenBSD each have over 300 different calls,[2][3] NetBSD has close to 500,[4] 
FreeBSD has over 500,[5] Windows 7 has close to 700,[6] while Plan 9 has 51.[7]

Tools such as strace, ftrace and truss allow a process to execute from start and 
report all system calls the process invokes, or can attach to an already running 
process and intercept any system call made by said process if the operation does 
not violate the permissions of the user. This special ability of the program is 
usually also implemented with a system call, e.g. strace is implemented with 
ptrace or system calls on files in procfs. 


## Comunication of user space program with kernel

For RISC (Reduced Instruction Set Computer, eg. microcontroller) then 
program puts system call number in some register and execute software
interrupt.

For CISC (Complex Instruction Set Computer, eg. x86) it is also possible
to use SYSCALL/SYSRET (AMD) and SYSENTER/SYSEXIT (Intel)


[Manu Garg (2006). "Sysenter Based System Call Mechanism in Linux 2.6"](http://articles.manugarg.com/systemcallinlinux2_6.html):

> Linux 2.5 began using this on the x86, where available; formerly it used the 
> INT instruction, where the system call number was placed in the EAX register 
> before interrupt 0x80 was executed.

[Processor mode and context switching](https://en.wikipedia.org/wiki/System_call#Processor_mode_and_context_switching). 
**When program do system call actually no new (kernel) program is executed,
instead temporarly oryginal program is lifted to karnel priviliges by 
temporarly setting (if allowed) processor status register (=execusion mode) 
to more priviliged, and this system call is actualy executed by oryginal 
program.**

It means that process context switch is not neccessary, but does occur.
To machine processes are abstractions. Proces is kernelish if processor
execusion mode is set to kernel, userish if processor execusion mode
is set to user. Machine see only tape of instructions (not processes), 
some are allowed if processor status register has some value, other not.

**Multithreading** 
[Processor mode and context switching](https://en.wikipedia.org/wiki/System_call#Processor_mode_and_context_switching):

> One-to-one model: Every user thread gets attached to a distinct kernel-level 
> thread during a system call. This model solves the above problem of blocking 
> system calls. It is found in all major Linux distributions, macOS, iOS, recent 
> Windows and Solaris versions.


## Groups of system calls

[Wikipedia system calls](https://en.wikipedia.org/wiki/System_call).

**Process control** - create process (for example, fork on Unix-like systems, 
or NtCreateProcess in the Windows NT Native API), terminate process,
load, execute, get/set process attributes, wait for time, wait event, 
signal event, allocate and free memory.

**File management** - create file, delete file, open, close, read, write, 
reposition, get/set file attributes.

**Device management** - request device, release device, read, write, 
reposition, get/set device attributes, logically attach or detach devices.

**Information maintenance** - get/set time or date, get/set system data,
get/set process, file, or device attributes.

**Communication** - create, delete communication connection, send, 
receive messages, transfer status information, attach or detach remote devices.

**Protection** - get/set file permissions.


## Fork-exec

From Wikipedia [Fork-exec](https://en.wikipedia.org/wiki/Fork%E2%80%93exec):

> fork() is the name of the system call that the parent process uses to "divide" itself ("fork") into two identical processes. After calling fork(), the created child process is an exact copy of the parent except for the return value of the fork() call. This includes open files, register state, and all memory allocations, which includes the program's executable code. In some cases the two continue to run the same binary, but often one (usually the child) switches to running another binary executable using the exec() system call.
> 
>When a process forks, a complete copy of the executing program is made into the new process. This new process (which is a child of the parent) has a new process identifier (PID). The fork() function returns the child's PID to the parent, while it returns 0 to the child, in order to allow the two identical processes to distinguish one another.
> 
> The parent process can either continue execution or wait for the child process to complete. The child, after discovering that it is the child, replaces itself completely with another program, so that the code and address space of the original program are lost.
>
> If the parent chooses to wait for the child to die, then the parent will receive the exit code of the program that the child executed. To prevent the child becoming a zombie the parent should call wait on its children, either periodically or upon receiving the SIGCHLD signal, which indicates a child process has terminated.

> One can also asynchronously wait on their children to finish, by using a signal handler for SIGCHLD, if they need to ensure everything is cleaned up. Here's an example of a signal handler that catches any incoming SIGCHLD signals and handles multiple concurrent signals received.
> 
>  void cleanup(int signal) {
>    int status;
>    while (waitpid((pid_t) (-1), 0, WNOHANG) > 0) {}
>  }
> 
> When the child process calls exec(), all data in the original program is lost, and it is replaced with a running copy of the new program. This is known as overlaying. Although all data are replaced, the file descriptors that were open in the parent are closed only if the program has explicitly marked them close-on-exec. This allows for the common practice of the parent creating a pipe prior to calling fork() and using it to communicate with the executed program. 


# Linking

From Wikipedia [Realocation (Computing)](https://en.wikipedia.org/wiki/Relocation_(computing)):

The following example uses Donald Knuth's MIX architecture and MIXAL assembly language. The principles are the same for any architecture, though the details will change.

![https://en.wikipedia.org/wiki/Relocation_(computing)#Example](images/Relocation_example.png "Realocation of assembly/machine code")


    (A) Program SUBR is compiled to produce object file 
    (B), shown as both machine code and assembler. The compiler may start the compiled code at an arbitrary location, often location 1 as shown. Location 13 contains the machine code for the jump instruction to statement ST in location 5.
    (C) If SUBR is later linked with other code it may be stored at a location other than 1. In this example the linker places it at location 120. The address in the jump instruction, which is now at location 133, must be relocated to point to the new location of the code for statement ST, now 125. [1 61 shown in the instruction is the MIX machine code representation of 125].
    (D) When the program is loaded into memory to run it may be loaded at some location other than the one assigned by the linker. This example shows SUBR now at location 300. The address in the jump instruction, now at 313, needs to be relocated again so that it points to the updated location of ST, 305. [4 49 is the MIX machine representation of 305].

# Program memory (literal)




* stack: 
  * [Stack machine](https://en.wikipedia.org/wiki/Stack_machine)
  * [Stack based memory allocation](https://en.wikipedia.org/wiki/Stack-based_memory_allocation)
  * [Call stack](https://en.wikipedia.org/wiki/Call_stack)
* heap: 
  * [C dynamic allocation](https://en.wikipedia.org/wiki/C_dynamic_memory_allocation#Implementations)
  * [sbrk](https://en.wikipedia.org/wiki/Sbrk)
  * [mmap](https://en.wikipedia.org/wiki/Mmap)
* bss - [Uninitialized data](https://en.wikipedia.org/wiki/.bss)
* data - [Data segment](https://en.wikipedia.org/wiki/Data_segment)
* text - [Code segment](https://en.wikipedia.org/wiki/Code_segment)



![](images/Program_memory_layout.svg "Program memory layout")

Call stack layout:

![](images/ProgramCallStack2_en.png)
![](images/Call_stack_layout.svg)


# Lets program something (eg. C++)


First step, first program name, can be one of those:

* command line (standard),
* os shell (standard),
* some program (not standard), but may be usful:
  * perl script (better than shell),
  * node script,
  * python script.

And now everything will be done from here.

Actually every other solution will be facade of this (read IDE),
it is good to know, because it ease understending how to use
any IDE, or why can be simpler not to use IDE as main starting point.



# Memory mapped IO

For MIPS architecture IO registers are mapped to memory
at address 0xffff0000 at kernel space.

![Exemplary processor memory layaut (MIPS)](images/MIPS_detailed_memory_layout.png)






# Networking!!!

## Datagram

Datagram - header and payload, not dependent on any previous state,
state can be inside payload is private.
A datagram needs to be self-contained without reliance on earlier exchanges.
Datagram service routes datagrams without first creating a predetermined path. 
Datagram service is therefore considered connectionless.
Datagram service is often compared to a mail delivery service; 
the user only provides the destination address, 
but receives no guarantee of delivery, 
and no confirmation upon successful delivery.

[Source: Wikipedia Datagram](https://en.wikipedia.org/wiki/Datagram#Definition)


The header contains all the information sufficient for routing 
from the originating equipment to the destination without relying 
on prior exchanges between the equipment and the network. 
Headers may include source and destination addresses as well as a type field. 
The payload is the data to be transported. 
This process of nesting data payloads in a tagged header is called encapsulation.

[Source: Wikipedia Datagram](https://en.wikipedia.org/wiki/Datagram#Structure)


The term datagram is generally reserved for packets of an unreliable service, 
which cannot notify the sender if delivery fails, 
while the term packet applies to any packet, reliable or not.
[Source: Wikipedia Datagram](https://en.wikipedia.org/wiki/Datagram#Internet_Protocol)




And always one end is master other is slave.
It is mutual agreement and convension.
One site commands other site.


# Situation

1 data line, 1 control line.

Master 



# 2 independent state machines electricaly connected - Physical Layer - Wires Buffers Control transistors

Bits, switches, voltage



## Services


[From Wikipedia Data Link Layer # Services](
  https://en.wikipedia.org/wiki/Data_link_layer#Services
  )

The services provided by the data link layer are:

* Encapsulation of network layer data packets into frames
* Frame synchronization
* In the logical link control (LLC) sublayer:
  * Error control (automatic repeat request, ARQ), in addition to 
  ARQ provided by some transport-layer protocols, 
  to forward error correction (FEC)
  techniques provided on the physical layer, and to error-detection and 
  packet canceling provided at all layers, including the network layer. 
  Data-link-layer error control (i.e. retransmission of erroneous packets) 
  is provided in wireless networks and V.42 telephone network modems, 
  but not in LAN protocols such as Ethernet, since bit errors are so 
  uncommon in short wires. In that case, only error detection and 
  canceling of erroneous packets are provided.
  * Flow control, in addition to the one provided on the transport layer. 
  Data-link-layer flow control is not used in LAN protocols such as Ethernet, 
  but in modems and wireless networks.
* In the medium access control (MAC) sublayer:
  * Multiple access protocols for channel-access control, 
  for example CSMA/CD protocols for collision detection 
  and re-transmission in Ethernet bus networks and hub networks, 
  or the CSMA/CA protocol for collision avoidance in wireless networks.
  * Physical addressing (MAC addressing)
  * LAN switching (packet switching), including MAC filtering, 
  Spanning Tree Protocol (STP) and Shortest Path Bridging (SPB)
  * Data packet queuing or scheduling
  * Store-and-forward switching or cut-through switching
  * Quality of Service (QoS) control
  * Virtual LANs (VLAN)





## Ethernet packed recognition

It is not so obvious what is begining and what is ending.
The only recognisable thing is something that differs from
everything else. It can take different forms, but general
known methods to be able to reckognise frames from stream of bits 
are those:

* stamps at constant intervals -> remove stamps after
* specific amount of time between frames -> lower bandwidth
* character counting (but prone to errors in length) -> remove count after
* byte stuffing - begining is DLE STX, end is DLE ETX, 
  any DLE in data must be escapet with additional DLE -> remove STX, ETX and
  every escaping DLE
* [Consistent Overhead Byte Stuffing (COBS)](https://en.wikipedia.org/wiki/Consistent_Overhead_Byte_Stuffing) - employs a particular byte value, typically zero,
  to serve as a packet delimiter. When zero is used as a delimiter, 
  the algorithm replaces each zero data byte with a non-zero value 
  so that no zero data bytes will appear in the packet and thus 
  be misinterpreted as packet boundaries. Linked list alghoritm:
  First, insert a zero byte at the beginning of the packet, 
  and after every run of 254 non-zero bytes. 
  This encoding is obviously reversible. 
  It is not necessary to insert a zero byte at the end of the packet 
  if it happens to end with exactly 254 non-zero bytes.
  Second, replace each zero byte with the offset to the next zero byte, 
  or the end of the packet. Because of the extra zeros added 
  in the first step, each offset is guaranteed to be at most 255.
* bit stuffing - separator is bit pattern (eg. 1 zero 
  and 6 ones and 1 zero - 01111110), when data needs this
  particular pattern transmitter inserts zero after 5 consecutive
  ones -> receiver removes this every zero.
* Idle bits - but time gap synchronization is usually used in combination 
  with another method offrame synchronization like packet 
  length indication because it might fail if line noise 
  is encountered and by that needs a backup technique 
  (“CSMA/CD(Ethernet)” for an example).
  * IDLE in some configuration can't be distinguished from HI or LO.
  If the bits are encoded using return to zero signaling time gaps cannot be used.
  * If supported by physical link medium bit can have 3 states:
    * Hi - high, eg. 5V
    * Lo - low, eg. -5V
    * Idle - idle, not connected eg. 0V 

[Source Wikipedia Data Link Layer # MAC](https://en.wikipedia.org/wiki/Data_link_layer#Media_access_control_sublayer)



Ethernet packet is recognised from noise of bits using
start byte, length and idle.

Proper packet have following parts:

* Preamble - 10101010 - 7 bytes - for clock synchronization
* Start Data Frame (SDF) character - 10101011 - byte stuffing start,
but next bytes are not stuffed because data length is used,
* MAC destination - constant length - not used for recognition
* MAC source - constant length - not used for recognition
* Tag - constant length - not used for recognition
* EtherType or Length:
  * EtherType (if value > 1536 (Ethernet II)) - 2 bytes:
    * value 0x0800 (IPv4) - but IPv4 header have header filds:
    Total Length - length of fragment (less/equal than Ethernet frame max data),
    Fragment Offset - telling which fragment of IP is it,
    Flags - bit 3 indicates if moore fragments to come, so Total Length can
    be used to know when packed ends
  * Length (if value < 1500 (IEEE 802.3)) - 2 bytes - used for 
  ignoring eventual SDF characters
  * EtherType value of 0x8100 means the frame is tagged (802.1Q VLAN tagging),
  and the true EtherType/Length is located after the Q-tag.
* Data - bounded variable length, 42 or 46 to 1500 - not used for recognition
* CRC - 4 bytes - cyclic redundancy check - not used for recognition
* Interpacket gap - 12 bytes - Idle bits - electrical differential line state when
transmitters not connected - can be additionaly used if available
to recognise packet borders


## Access to common media

Problem: there are 4 computers connected to the same
media, 1 is server, 3 are clients with questions to server,
but only one computer can set a voltage to medium, how
can electical access to the medium be synchronized?

Problem to be solvable:

* There must be some way to detect collision, and
* there must be agreement what to do in case of collision, and
* there must be some randomnes in decision to prevent infinite cycles,
* additionaly to inform maybe transmitting/receiving others about
  collision intensional collision may be generated by sending jamming.


Collision detection while transmitting on shared electrical bus can be done
by monitoring what voltage is expected and what actual is for 0-1 collision,
and voltage (doubled) value for 1-1 or 0-0 collison. It
could be done by differential amplifiers with few reference voltages.

Agreement for aquaiering medium could be:
> "Before speaking, each guest politely waits for 
> the current speaker to finish. If two guests start 
> speaking at the same time, both stop and 
> wait for short, random periods of time."
> 
> --<cite>[Wikipedia CSMA/CD](
  https://en.wikipedia.org/wiki/Carrier-sense_multiple_access_with_collision_detection
)</cite>


Detected collisions should be additionaly jammed, in case
of Ethernet and Carrier-sense multiple access with 
collision detection (CSMA/CD) protocol this colud
be realised as fallows:

> This in turn means: A station noting a collision has 
> occurred is sending a 4 to 6 byte long pattern 
> composed of 1-0 bit combinations.
> 
> The purpose of this is to ensure that any other 
> node which may currently be receiving a frame 
> will receive the jam signal in place of the 
> correct 32-bit MAC CRC, this causes the other 
> receivers to discard the frame due to a CRC error. 
> 
> --<cite>[Wikipedia CSMA/CD # Jam signal](
  https://en.wikipedia.org/wiki/Carrier-sense_multiple_access_with_collision_detection#Jam_signal
)</cite>


Ethernet without switches used protocol named 
Carrier-sense multiple access with collision detection (CSMA/CD).
Now it is not neccessary, but for example for Wifi it is.

> Modern Ethernet networks, built with switches 
> and full-duplex connections, no longer need to use 
> CSMA/CD because each Ethernet segment, 
> or collision domain, is now isolated. CSMA/CD is 
> still supported for backwards compatibility and 
> for half-duplex connections.
> 
> --<cite>[Wikipedia CSMA/CD](
  https://en.wikipedia.org/wiki/Carrier-sense_multiple_access_with_collision_detection
)</cite>








## Clock recovery

Transmitter and receiver have different (controlled) clocks.
Those clocks must be synchronised before reading Ethernet frame.
It only can be done when fragment or statistical fragments of
frame are (isomorphic) to clock signal of transmitter.

If we have such clock sequence in frame (in Ethernet Preamble,
but frame data can be additionally encoded in 8b/10b for example which
give frequently changing bits which would be similar to clock) we
can compare transmitted clock sequence with local clock sequence,
gether those comparison (this could be counted to signed
integer or pulses can fill charge container) and feed this sum
to control of local clock frequency. This way frequency and phase
of local clock will aproach frequency and phase of transmitter
clock represented in frame.


> The receiver generates a clock from an approximate 
> frequency reference, and then phase-aligns the clock 
> to the transitions in the data stream with a 
> phase-locked loop (PLL). This is one method of performing 
> a process commonly known as clock and data recovery (CDR).
> -- <cite>[[Source Wikipedia Clock recovery](https://en.wikipedia.org/wiki/Clock_recovery)]</cite>



## Carrier recovery

When signals are transmitted using carrier wave modulation (wifi, radio) there
is need for carrier recovery before demodulation.

Procedure in carier recovery is very similar to clock recovery,
but in this case amplitudes of signal are recovered.


## Speed and duplex negotiations

It is done by [Autonegotiation protocol](https://en.wikipedia.org/wiki/Autonegotiation);
from time to time fast link pulse (FLP) burst is send.
Every fast link pulse burst transmits a word of 16 bits known as a link code word.
In this work standard informations are specified, beside others technology of peers with:
* duplexity and
* speed informations.

Additional informations can be exchanged by next pages.
If one of peers is switch, it will become master,
otherwise master is randomly choosen. Master will dictate
speed and duplexity of slave. 

1000BASE-T Example ([Wikipedia Autonegotiation](https://en.wikipedia.org/wiki/Autonegotiation)); 
The 1000BASE-T supported modes and master-slave 
data (which is used to decide which of the two devices acts as the master, 
and which one acts as the slave) are sent using a single message page, 
followed by a single unformatted page. The message page contains:

* half duplex capability
* whether the device is single port or multiport
* whether master/slave is manually configured or not
* whether the device is manually configured as master or slave

The unformatted page contains a 10-bit word, called a master-slave seed value. 

References:

1. [Telecommunications Technology Handbook, Daniel Minoli, 11.2.6 PCS
PMA Sublayer, and Baseband Medium, Type 1000Base-T]
2. [Structured Cable Systems, A.B. Semenov, S.K. Strizhakov, I.R. Suncheley,
2.3 Transmission of information along electrical and fiber-optical channels,
Engineering solutions for 1000Base-T]

# 2 directly connected devices - Link Layer - Ethernet Protocol

Frames 



# N not-directly connected devices - Network Layer - IP Protocol




# Program API standard - Segments , streams...? - Transport Layer - TCP Protocol

Useful programs: netcat (nc), ss .


Virtual circuit between to endpoints before data exchange begins.


Bidirectional data (over)flow constrol menagement service.
Bidirectional connection establishment service.
Multiple program to program (via socket number) service.

TCP provides stream of data.

Segment numbering for ordered stream of data.
Checking data (by checksums) and delivery by acknoledgements (ACK).

Flow control for "baud rate synchronisation". Stop-and-wait after each
frame for ACK (then continue) or timeout (then retransmitt).
Or sliding window; ACK after n frames, probably n can be negotiated
or is dynamically set (based on network traffic).


# Application layer

## MAIL neccessary Binary-->Text encodings - Base64



Pretty Good Privacy (PGP) documentation (RFC 4880) uses the term 
ASCII armor for binary-to-text encoding when referring to 
[Base64](https://en.wikipedia.org/wiki/Base64). 


## Client Server

[From Wikipedia Network Socket](https://en.wikipedia.org/wiki/Network_socket#Socket_states_in_the_client-server_model)

Computer processes that provide application services are referred to as servers, 
and create sockets on start up that are in listening state. 
These sockets are waiting for initiatives from client programs.


A TCP server may serve several clients concurrently, 
by creating a child process for each client and establishing 
a TCP connection between the child process and the client. 
Unique dedicated sockets are created for each connection. 
These are in established state when a socket-to-socket virtual 
connection or virtual circuit (VC), also known as a TCP session, 
is established with the remote socket, providing a duplex byte stream.


A server may create several concurrently established TCP sockets 
with the same local port number and local IP address, 
each mapped to its own server-child process, serving its own client process. 
They are treated as different sockets by the operating system, 
since the remote socket address (the client IP address and/or port number) 
are different; i.e. since they have different socket pair tuples. 


## Routers (in network layer) and Error messages (at client in transport layer)


[Wikipedia ICMP](https://en.wikipedia.org/wiki/Internet_Control_Message_Protocol)

For example, every device (such as an intermediate router) 
forwarding an IP datagram first decrements the time to live (TTL) 
field in the IP header by one. If the resulting TTL is 0, 
the packet is discarded and an ICMP time exceeded 
in transit message is sent to the datagram's source address. 




# Inter Process Communication (IPC)



## Unix domain sockets

> man unix 7
> man unix 



Useful programs: netcat (nc), ss .

[Source StackOverflow What are u_str, Recv-Q and Send-Q in ss output?](
  https://askubuntu.com/questions/916241/what-are-u-str-recv-q-and-send-q-in-ss-output)

ss dumps socket statistics. Netid u_str is abbreviation for unix_stream i.e., 
AF_UNIX socket family and SOCK_STREAM socket type:

    The AF_UNIX (also known as AF_LOCAL) socket family is used to communicate 
    between processes on the same machine efficiently. Traditionally, 
    UNIX domain sockets can be either unnamed, or bound to a filesystem pathname 
    (marked as being of type socket). 
    Linux also supports an abstract namespace which is independent of the filesystem.

    SOCK_STREAM Provides sequenced, reliable, two-way, connection- based byte streams. 
    An out-of-band data transmission mechanism may be supported.

[From the quick intro to ss](/usr/share/doc/iproute2-doc/ss.html):

    Then two columns (Recv-Q and Send-Q) showing amount of 
    data queued for receive and transmit.

For unix sockets, it is unix_diag_rqlen from unix_diag.h.




# File systems


Persistent hierarchical monitorable dynamical data.
Abstract user interface build with files.
Can be monitored as a whole. For multiple tasks it 
must work as process (system service) otherwise it
could be library. Simulates named groups of text (binary),
with physical semantic, as for example library of
books with additional hierarchical (tree or graph)
plus protection and security.
Maintainence of integrity -> protection against
program abnormal termination -> tranactional use of files.
Correction of damaged structures.

API:

* open - read - allowed rights
* open - write - allowed rights
* close - if opened - if allowed..
* create - if allowed
* delate - if allowed


File metadata - A file system stores all the metadata 
associated with the file—including the file name, 
the length of the contents of a file, 
and the location of the file in the folder 
hierarchy—separate from the contents of the file
[[Wikipedia File System](https://en.wikipedia.org/wiki/File_system#Metadata)]. 

User metadata can be mapped to file using 
[extended file attributes](https://en.wikipedia.org/wiki/Extended_file_attributes)



Multiple physical file systems can be mounted at multiple partitions.



Transactional operations on multiple files:
[Journaling file systems](https://en.wikipedia.org/wiki/Journaling_file_system)
is one technique used to 
introduce transaction-level consistency to file system structures. 
Journal transactions are not exposed to programs as part of the OS API; 
they are only used internally to ensure consistency 
at the granularity of a single system call. 


# I/O tasks

* routing
* arbitration
* switching


## Channel I/O

[From Wikipedia Channel I/O - Overview](https://en.wikipedia.org/wiki/Channel_I/O#Overview)

> Channel architecture avoids this problem by using a logically independent, 
> low-cost facility. Channel processors are simple, but self-contained, 
> with minimal logic and sufficient scratchpad memory (working storage) 
> to handle I/O tasks. They are typically not powerful or flexible enough 
> to be used as a computer on their own and can be construed as a form 
> of coprocessor. On some systems the channels use memory or registers 
> addressable by the central processor as their scratchpad memory, 
> while on other systems it is present in the channel hardware.

> A CPU designates a block of storage or sends a relatively small channel 
> programs to the channel in order to handle I/O tasks, which the channel 
> and controller can, in many cases, complete without further intervention 
> from the CPU (exception: those channel programs which utilize 'program 
> controlled interrupts', PCIs, to facilitate program loading, demand 
> paging and other essential system tasks).

> When I/O transfer is complete or an error is detected, the controller 
> communicates with the CPU through the channel using an interrupt. 
> Since the channel has direct access to the main memory, it is also 
> often referred to as a direct memory access (DMA) controller.

> In the most recent implementations, the channel program is initiated 
> and the channel processor performs all required processing until 
> either an ending condition. This eliminates much of the CPU—Channel 
> interaction and greatly improves overall system performance. 
> The channel may report several different types of ending conditions, 
> which may be unambiguously normal, may unambiguously indicate an error 
> or whose meaning may depend on the context and the results of a 
> subsequent sense operation. In some systems an I/O controller can 
> request an automatic retry of some operations without CPU 
> intervention. In earlier implementations, any error, no matter 
> how small, required CPU intervention, and the overhead was, 
> consequently, much higher. A program-controlled interruption 
> (PCI) is still supported for certain "legacy" operations, 
> but the trend is to move away from such PCIs, except where unavoidable. 


# Computer devices

## Devices


Device controller is computer microcomputer designed to comunicate
by means of some protocol with some sort of devices equipped 
with device microcomputer. Software talking to device controller
is called device driver (short but somewhat misleading name).

For example, computer have SATA controller which can communicate
by SATA bus with SATA disk. SATA controller will have address
(indirectly by some registers or dedicated commands) and 
feedback in the form of interrupts.

For example disk read could be: CPU places disk data
start addres in buffer1 (register), length in buffer2,
and starts controller by issuing comand startIO.
Then controller would sent frames by SATA bus
to SATA disk device with secific commands and arguments,
wait for response, collect data responses, aggregated
them and put in output buffer3 for CPU, then
issued interrupt to let know processor that answer
waits in buffer3. But controller and its protocols
must be ready for more scenarios, such as command
fail, device error, timeout, bus errors, task abort,
power failure, etc.


## Connections

There is buisy check execute interconnected with registers and functions
blocks (aka CPU).

CPU is connected to 
* DDR3 bus driver (probably MMU Memory Management Unit) 
  which is connected to DRAMs by DDR3 bus,
* PCIe bus driver which is connected to graphics by PCIe bus,
* and Platform Controller Hub driver which is connected to other 
  devices by DMI (Direct Media Interface) bus, eg.
  * USB by USB bus,
  * Disks by SATA bus,
  * Ethernet driver by PCIe bus,
  * older/slower devices by PCI bus
  * fast disks on servers by SCSI (Small Computer System Interface) bus



## Device access

Block device = random acces to blocks, 
also possibly provided by scanning, eg.:
* disk
* RAM
* tape

Character device = delivers of accepts stream 
of characters, not addresable and not seekable, eg.:
* printers (terminal printer)
* network interfaces
* mice/touchpad

Different devices eg.:
* memory mapped screen buffer (not address but also not stream)
* clock (generating interrupts)



## IO Session


> Every controller has a small number of registers that are used to communicate
> with it. For example, a minimal disk controller might have registers for specifying
> the disk address, memory address, sector count, and direction (read or write). To
> activate the controller, the driver gets a command from the operating system, then
> translates it into the appropriate values to write into the device registers. The col-
> lection of all the device registers forms the **I/O port space**, a subject we will come
> back to in Chap. 5.
>
> On some computers, the device registers are mapped into the operating sys-
> tem’s address space (the addresses it can use), so they can be read and written like
> ordinary memory words. On such computers, no special I/O instructions are re-
> quired and user programs can be kept away from the hardware by not putting these
> memory addresses within their reach (e.g., by using base and limit registers). On
> other computers, the device registers are put in a special I/O port space, with each
> register having a port address. On these machines, special **IN** and **OUT** instructions
> are available in kernel mode to allow drivers to read and write the registers. The
> former scheme eliminates the need for special I/O instructions but uses up some of
> the address space. The latter uses no address space but requires special instruc-
> tions. Both systems are widely used.
> 
> 
> [CPU to IO connection][CPU_to_IO_connection] and here 


IO session can be done in three different ways [IO session][IO_session]:

* Command and device status polling:
  
  User program issues a system call, which the kernel then translates into a procedure
  call to the appropriate driver. The driver then starts the I/O and sits in a tight loop
  continuously polling the device to see if it is done (usually there is some bit that in-
  dicates that the device is still busy). When the I/O has completed, the driver puts
  the data (if any) where they are needed and returns.

* Command execution with request to interrupt:

  In step 1, the
  driver tells the controller what to do by writing into its device registers. The con-
  troller then starts the device. When the controller has finished reading or writing
  the number of bytes it has been told to transfer, it signals the interrupt controller
  (PIC programable interrupt controller)
  chip using certain bus lines in step 2. If the interrupt controller is ready to accept
  the interrupt (which it may not be if it is busy handling a higher-priority one), it as-
  serts a pin on the CPU chip telling it, in step 3. In step 4, the interrupt controller
  puts the number of the device on the bus so the CPU can read it and know which
  device has just finished (many devices may be running at the same time).
  Once the CPU has decided to take the interrupt, the program counter and PSW
  are typically then pushed onto the current stack and the CPU switched into kernel
  mode. The device number may be used as an index into part of memory to find the
  address of the interrupt handler for this device. This part of memory is called the
  interrupt vector. Once the interrupt handler (part of the driver for the interrupting
  device) has started, it removes the stacked program counter and PSW and saves
  them, then queries the device to learn its status. When the handler is all finished, it
  returns to the previously running user program to the first instruction that was not
  yet executed.

* Command DMA (Direct Memory Access) controler to command device controller:

  The third method for doing I/O makes use of special hardware: a DMA
  (Direct Memory Access) chip that can control the flow of bits between memory
  and some controller without constant CPU intervention. The CPU sets up the
  DMA chip, telling it how many bytes to transfer, the device and memory addresses
  involved, and the direction, and lets it go. When the DMA chip is done, it causes
  an interrupt, which is handled as described above. DMA and I/O hardware in gen-
  eral will be discussed in more detail in Chap. 5.


[CPU_to_IO_connection]: Modern Operating Systems, Andrew S. Tanenbaum, 1.3.4 I/O Devices
[IO_session]: Modern Operating Systems, Andrew S. Tanenbaum, 1.3.4 I/O Devices



## DMA Direct Memory Access

Two possibilities:
* motherbord global DMA controller
* every device controller have DMA module


### Global DMA controller

DMA controller, it is connected
to global bus or buses (links) to devices
and main memory, and **it is allowed to master those buses**
or to master bus controller, but should have lower priority
than CPU. In some way it is CPU with few instructions, but
slave to main CPU. 
DMA controller registers should also be
exposed (residing) as CPU registers (for easiest/fastest access).


But there arises particular problem, different devices
needs different setups, loops and increments for data
setting/getting and closing procedures. So to do it
DMA controller would have to be programmable. It is
possible and probably done, but programming DMA would
have been by CPU, and particular programs would have been
taken from memory, so it would dyfit DMA purpouse.

But devices could have big data buffers, and (buffer)
instructions for gethering/setting buffored data,
then CPU would initiate and close those instruction,
and DMA controler would only transfer data in the loop
when CPU dont use buses. Thus DMA controller would support
instructions only for read/write device buffer fragment 
(at some bus address), increment/decrement to next buffer
fragment, and transfer data to/from DMA internal buffer
or other device buffer.

Data transfer to/from DMA controller buffer is useful
for deffering bus access. 


DMA controller would typicaly have buffers for:
* control - specyfying probably: 
  * source/target device buffer port address
  * transfer direction
  * ...
* data - for temporary data
* count - number of bytes/words to transfer, used by internal loop


### Local DMA controllers

Every device would have DMA controller, and CPU would have one also.
CPU DMA would have highest priority (but lower than CPU), then lower
priority would have memory DMA, and the lowest priorities would have
rest of devices.

Talking protocol between DMA controllers would be simple,
there would be buffers for:
* Source/Target IO port address of peer DMA controller
* Count number of bytes/words for transfer
* And some acknowledgement method (buffer/interrupt/message)

Also inter device initialization and cleanup would enter particular
DMA controllers.


## Memory-Mapped I/O

Addres space for device controllers can be mapped
and synchronized with RAM, this way CPU can (indirectly)
talk with controller, for example:

```assembly
MOV to_IO_port_mapped_in_RAM from_CPU_reg
MOV to_CPU_reg from_IO_port_mapped_in_RAM 
```

x86 supports this interface (and also I/O port space).
Typical address regions for x86 IBM PC compatibles are:
* 640K to 1M − 1 => device data buffers, and
* 0 to 64K − 1 => I/O ports.

Synchronization is not so difficult:
* schared (simple) buses can be snooped by device controllers
  and synchronised accordingly
* messages buses may:
  * use broadcast messages ,
  * or memory controller can have configurable lookup table
    and sends messages to interested peers..


**Caching must be disabled for addresses mapped to devices buffers!**

## I/O port space

Devices in the lowest lewels communicate by
buffers and chip enable. For example disk controller
will have at least two buffers: select function and data,
those two buffers have addresses, they can only be separatly
selected and filled, so those would be disk ports probably...


Address space for device controllers is through specyfic
commands, for example commands in assembly could be as fallows:

```assembly
IN to_cpu_reg from_IO_port
OUT to_IO_port from_cpu_reg
```

x86 supports this interface (and also memory mapped I/O).





# Interrupts and Interrupt Controller

To list OS interrupts issue command:

```bash
cat /proc/interrupts
```

## I/O software construct

To use I/O devices one can:
* constantly check resource - **Programmed I/O**
* constantly wait for byte/word - **Interrupt driven I/O**
* constantly wait for count bytes/words buffer - **DMA driven I/O**

(DMA controllers usually are mch solower than CUP, so it is not
always the best solution, but usually it is.)

## Operating system typical I/O stack

```
User level I/O software
Kernel device-independent I/O software
Kernel particular Device drivers
Kernel Interrupt handlers
Hardware
```

## Device drivers software structure

Device drivers can be structured in kernel as 
processes, with their own states, stacks, and program
counters. This way interrupts can be handled
inside process, and waiting for interrupt from outside
would look like waiting for process.


**Drivers have to be reentrant** (network driver
processes one packet, by in the mean time other
packet arrives).


## Device driver as process

Driver as process would need:
1.  Save any registers (including the PSW) that have not already been
    saved by the interrupt hardware.
2.  Set up a context for the interrupt-service procedure. Doing this may
    involve setting up the TLB, MMU and a page table.
3.  Set up a stack for the interrupt service-procedure.
4.  Acknowledge the interrupt controller. If there is no centralized 
    interrupt controller, reenable interrupts.
5.  Copy the registers from where they were saved (possibly some stack)
    to the process table.
6.  Run the interrupt-service procedure. It will extract information from
    the interrupting device controller’s registers.
7.  Choose which process to run next. If the interrupt has caused some
    high-priority process that was blocked to become ready, it may be
    chosen to run now.
8.  Set up the MMU context for the process to run next. Some TLB setup 
    may also be needed.
9.  Load the new process’ registers, including its PSW.
10. Start running the new process.


### Non-sherable devices and spooling

(From Tanebaum)

Spooling is a way of dealing with dedicated I/O devices in a multiprogramming
system. Consider a typical spooled device: a printer. Although it would be
technically easy to let any user process open the character special file for the
printer, suppose a process opened it and then did nothing for hours. No other
process could print anything. Instead what is done is to create a special
process, called a daemon, and a special directory, called a spooling directory.
To print a file, a process first generates the entire file to be printed and
puts it in the spooling directory. It is up to the daemon, which is the only
process having permission to use the printer’s special file, to print the files
in the directory. By protecting the special file against direct use by users,
the problem of having someone keeping it open unnecessarily long is eliminated.
Spooling is used not only for printers. It is also used in other I/O situations.
For example, file transfer over a network often uses a network daemon. To send a
file somewhere, a user puts it in a network spooling directory. Later on, the
network daemon takes it out and transmits it.


## PIC Programmable Interval Controller

<https://wiki.osdev.org/PIC>

manage hardware interrupts and send them to the 
appropriate system interrupt. This allows the 
system to respond to devices needs without loss 
of time (from polling the device, for instance).

It is important to note that APIC has 
replaced the 8259 PIC in more modern systems, 
especially those with multiple cores/processors. 


## APIC 


## Interrupts calling

Interrupts can (and often do) happen at highly inconvenient moments, for ex-
ample, while another interrupt handler is running. For this reason, the CPU has a
way to disable interrupts and then reenable them later. While interrupts are dis-
abled, any devices that finish continue to assert their interrupt signals, but the CPU
is not interrupted until interrupts are enabled again. If multiple devices finish
while interrupts are disabled, the interrupt controller decides which one to let
through first, usually based on static priorities assigned to each device. The
highest-priority device wins and gets to be serviced first. The others must wait.
[Modern Operating Systems, Andrew S. Tanenbaum, 1.3.4 I/O Devices]




## Interrupts CPU subcycle

In instruction cycle there is time to check 
one line state to see if there is interrupt
pending, if ther is (e.g. state high), than
next instruction should be fetched from
main interrupt handler addres (which will
save current program counter save current
process state, etc. and will start dispatching
specific interrupt handling).

It is minimally done by SM (State Machine)  which would need:
* main state of SM, because after eventual interrupt
  instruction cycle must return to main cycle
  and interrupt line must be disabled for time
  of interrupt handling (or first next instruction
  must be interrupt disable)
* interrupt enabled state, disabled by instruction
  or implicitly when starting interrupt handler,
  reanabled just before interrupt service end
* interrupt mask state, for filtering interrupts,
  mask all means interrupts disabled, but usually 
  there are NMI (Non Maskable Interrupts)
* normal PC state, for saving program counter
  before interrupt, may be also states for
  other registers, because interrupt handling
  may need process context switch


There are spourious interrupt, those are too short
interrupts, coused by for example electrical interference,
or device malfunction. They shold be ignored - **without**
interrupt handled acknoledgement.


## Level-triggered interrupt

<https://en.wikipedia.org/wiki/Interrupt#Level-triggered>

A level-triggered interrupt is requested by holding 
the interrupt signal at its particular (high or low) 
active logic level. A device invokes a level-triggered 
interrupt by driving the signal to and holding it 
at the active level. It negates the signal when 
the processor commands it to do so, typically after 
the device has been serviced.

## Edge-triggered interrupt

<https://en.wikipedia.org/wiki/Interrupt#Edge-triggered>

An edge-triggered interrupt is an interrupt signaled 
by a level transition on the interrupt line, 
either a falling edge (high to low) or a rising edge 
(low to high). A device wishing to signal an interrupt 
drives a pulse onto the line and then releases the 
line to its inactive state. If the pulse is too short 
to be detected by polled I/O then special hardware 
may be required to detect it. 


## Processor response

<https://en.wikipedia.org/wiki/Interrupt#Processor_response>

The processor samples the interrupt trigger signal during each instruction
cycle, and will respond to the trigger only if the signal is asserted when
sampling occurs. Regardless of the triggering method, the processor will begin
interrupt processing at the next instruction boundary following a detected
trigger, thus ensuring:

* The Program Counter (PC) is saved in a known place.
* All instructions before the one pointed to by the PC have fully executed.
* No instruction beyond the one pointed to by the PC has been executed, 
  or any such instructions are undone before handling the interrupt.
* The execution state of the instruction pointed to by the PC is known.

## Shared IRQs

<https://en.wikipedia.org/wiki/Interrupt#Shared_IRQs>

Multiple devices may share an edge-triggered interrupt line if they are designed
to. The interrupt line must have a pull-down or pull-up resistor so that when
not actively driven it settles to its inactive state, which is the default state
of it. Devices signal an interrupt by briefly driving the line to its
non-default state, and let the line float (do not actively drive it) when not
signaling an interrupt.

However, interrupt pulses from different devices may merge if they occur close
in time. To avoid losing interrupts the CPU must trigger on the trailing edge of
the pulse (e.g. the rising edge if the line is pulled up and driven low). After
detecting an interrupt the CPU must check all the devices for service
requirements.

Edge-triggered interrupts do not suffer the problems that level-triggered
interrupts have with sharing. Service of a low-priority device can be postponed
arbitrarily, while interrupts from high-priority devices continue to be received
and get serviced. If there is a device that the CPU does not know how to
service, which may raise spurious interrupts, it won't interfere with interrupt
signaling of other devices. However, it is easy for an edge-triggered interrupt
to be missed - for example, when interrupts are masked for a period - and unless
there is some type of hardware latch that records the event it is impossible to
recover. This problem caused many "lockups" in early computer hardware because
the processor did not know it was expected to do something. More modern hardware
often has one or more interrupt status registers that latch interrupts requests;
well-written edge-driven interrupt handling code can check these registers to
ensure no events are missed. 

PCIe uses inband interrupt signals, reliving problem of sharing small
number of interrupt lines (many number of interrupt lines is not posible
for bigger systems).


## Sharing media - the ways

Listening and when free:

* pulsing = connect, pulse, disconnect => exclusive conduction => detect edge, buffer events,
* switching = connect, keep, disconnect => exclusive connection => detect level
* mastered bus = listen, response, listen => master-slaves => detection:
  * pulses by edges counting resolved to address
  * frames by logic gates stored in buffers and decoded to address


## Message Signaled Interrupts and Doorbell

<https://en.wikipedia.org/wiki/Interrupt#Doorbell>

In a push button analogy applied to computer systems, the term doorbell or
doorbell interrupt is often used to describe a mechanism whereby a software
system can signal or notify a computer hardware device that there is some work
to be done. Typically, the software system will place data in some well-known
and mutually agreed upon memory location(s), and "ring the doorbell" by writing
to a different memory location. This different memory location is often called
the doorbell region, and there may even be multiple doorbells serving different
purposes in this region. It is this act of writing to the doorbell region of
memory that "rings the bell" and notifies the hardware device that the data are
ready and waiting. The hardware device would now know that the data are valid
and can be acted upon. It would typically write the data to a hard disk drive,
or send them over a network, or encrypt them, etc.

The term doorbell interrupt is usually a misnomer. It is similar to an
interrupt, because it causes some work to be done by the device; however, the
doorbell region is sometimes implemented as a polled region, sometimes the
doorbell region writes through to physical device registers, and sometimes the
doorbell region is hardwired directly to physical device registers. When either
writing through or directly to physical device registers, this may cause a real
interrupt to occur at the device's central processor unit (CPU), if it has one.

Doorbell interrupts can be compared to Message Signaled Interrupts, as they have
some similarities. 

## Typeahead


Interrupts at keystrokes, but also FIFO queue two-buffer for storing
keystrokes and interrupt for buffer full or 10 new keystrokes and 
cyclic buffer.


## Inter Processor Interrupts (IPIs)

<https://en.wikipedia.org/wiki/Inter-processor_interrupt>

Actions that might be requested include:

* flushes of memory management unit caches, such as translation lookaside 
  buffers, on other processors when memory mappings are changed by one processor;
* stopping when the system is being shut down by one processor.


On IBM PC compatible computers that use the Advanced Programmable Interrupt
Controller (APIC), IPI signalling is often performed using the APIC. When a CPU
wishes to send an interrupt to another CPU, it stores the interrupt vector and
the identifier of the target's local APIC in the Interrupt Command Register
(ICR) of its own local APIC. A message is then sent via the APIC bus to the
target's local APIC, which therefore issues a corresponding interrupt to its own
CPU. 





# Memory controller







# BIOS and UEFI

## BIOS

<https://riptutorial.com/x86/example/23463/bios-calls>
<https://wiki.osdev.org/BIOS>

BIOS is set of functions describing basic hardware,
it is shipped with specific motherbard. 

BIOS rutines are called using interrupts and few
registers. They are implemented as interrupts
handlers. Somewhere is documentation (Ralf Brown's Interrupt List).
BIOS functions can be accessed (pretty only) in real mode!

Example of clock services are:


|Int<br/>number| Function<br/>numin $ah<br/>register|Description|Data|
| ---- |-----| --------------- | ------------------------------------------------- |
| 1A   | 00  | Read RTC        | Clock ticks in CX:DX                              |
| 1A   | 01  | Set RTC         |                                                   |
| 1A   | 02  | Read RTC Time   | CH hour, CL minutes, DH seconds, DL the DST flag  |
| 1A   | 03  | Set RTC Time    | CH h CL DH DL                                     |
| 1A   | 04  | Read RTC Date   | CH century, CL year, DH month, DL day, all in BCD |
| 1A   | 05  | Set RTC Date    |                                                   |
| 1A   | 06  | Set RTC Alarm   |                                                   |
| 1A   | 07  | Reset RTC Alarm |                                                   |



```assembly
;How to read the system RTC (Real Time Clock):

mov ah, 0x00      ; Select 'Read RTC' function
int 0x1A          ; RTC services interrupt
shl ecx, 16       ; Clock ticks are split in the CX:DX pair, 
                  ; so shift ECX left by 16...
or cx, dx         ; and add in the low half of the pair
mov <new_day>, al ; AL is non-zero if the last call to 
                  ; this function was before midnight
                  ; Now ECX holds the clock ticks 
                  ; (approx. 18.2/sec) since midnight
                  ; and <new_day> is non-zero if we passed 
                  ; midnight since the lastread


;How to read the system time from the RTC:

mov ah, 0x02             ; Select 'Read system time' function
int 0x1A                 ; RTC services interrupt
                         ; Now CH contains hour, CL minutes, 
                         ; DH seconds, and DL the DST flag,
                         ; all encoded in BCD (DL is zero if in standard time)
                         ; Now we can decode them into a string 
                         ; (we'll ignore DST for now)

mov al, ch               ; Get hour
shr al, 4                ; Discard one's place for now
add al, 48               ; Add ASCII code of digit 0
mov [CLOCK_STRING+0], al ; Set ten's place of hour
mov al, ch               ; Get hour again
and al, 0x0F             ; Discard ten's place this time
add al, 48               ; Add ASCII code of digit 0 again
mov [CLOCK_STRING+1], al ; Set one's place of hour

mov al, cl               ; Get minute
shr al, 4                ; Discard one's place for now
add al, 48               ; Add ASCII code of digit 0
mov [CLOCK_STRING+3], al ; Set ten's place of minute
mov al, cl               ; Get minute again
and al, 0x0F             ; Discard ten's place this time
add al, 48               ; Add ASCII code of digit 0 again
mov [CLOCK_STRING+4], al ; Set one's place of minute

mov al, dh               ; Get second
shr al, 4                ; Discard one's place for now
add al, 48               ; Add ASCII code of digit 0
mov [CLOCK_STRING+6], al ; Set ten's place of second
mov al, dh               ; Get second again
and al, 0x0F             ; Discard ten's place this time
add al, 48               ; Add ASCII code of digit 0 again
mov [CLOCK_STRING+7], al ; Set one's place of second
;...
db CLOCK_STRING "00:00:00", 0   ; Place in some separate (non-code) area



;How to read the system date from the RTC:

mov ah, 0x04             ; Select 'Read system date' function
int 0x1A                 ; RTC services interrupt
                         ; Now CH contains century, CL year, 
                         ; DH month, and DL day, all in BCD
                         ; Decoding to a string is similar to 
                         ; the RTC Time example above
```

# Computer buses architecture

## Primitive shared one bus without special protocols

The simplest architecture have one global bus.
It is set of shared electrical lines, which
must be arbitrated somehow. It could be done
by CU (Control Unit) as a process of specialised
instructions. This way there is many address spaces
(e.g. for RAM, Flash, Disk) differentiated by 
commands (read disk -> readWDisk toBuffer fromAddressImm,
read memory -> readW toBuffer fromAddressImm, etc.).
Bus frequency must be synchronized with particular device,
this is bootleneck of this architecture because CPU is idle 
when waiting long time for slow devices and unable to use
bus for communication with other devices. 
This is improved using interrupts.

(More efficient and scalable architectures uses 
switching, routing, full duplexing with inband interrupts.)


Bus would have subgroups:

* data lines - for data transfer
* address lines - for addressing data of devices, e.g.:
  * RAM
  * Disk
  * Flash
* control address lines (select lines) - for selecting devices
* control enable lines - for enabling devices
* interrupt line - for devices notifications

And (minimal) devices grups:

* CPU
  * CU (Control Unit)
  * Registers
  * ALU
  * Bus controller
* RAM
  * Memory Controller
* Flash/ROM 
  * ROM controller
* IO
  * Interrupts
    * Interrupts controller
  * Disks
    * Disk controller
  * Terminal
    * Terminal controller
  * Keyboard
    * Keyboard controller

Communication with devices would be implemented in instructions:

```assembly
;readDisk <to_register> <from_disk_id> <from_address>
;in <to_register> <from_disk_id 5 MSB> <from_function> <from_arg1> <from_arg2> ...

readDisk eax 11011000 10101010
; shorthand for
;in eax 11011000 00000001 10101010
```

So for egzample when program would like read disk computer would:

* CU would read instruction from memory with arguments destined for disk read
* decode it, and then will build disk controller instruction: 
  * set disk controller instruction type to read:
    * connect instruction argument buffer 
      (containing disk address - 5 MSB and buffer bits - 3 LSB, eg. 11011 000,
      000 is disk function buffer) with 
      Bus Controller buffer controlling bus select lines
      => all devices monitor those lines, appriopriate disk controller
      will answare when will recive enable signal
    * connect CPU buffer (containing reading function code eg. 0000 0001) 
      to bus data lines,
      => disk controller data buffer will be writen with instruction code (read)
    * enable transmission direction (from cpu to disk) using enable line 1
      => data buffer will be writable, cpu register readable 
    * enable transmission using enable line 2 => disk controller instruction buffer 
      will be writen with read instruction code (0000 0001)
  * set disk controller data address (eg. 1010 1010):
    * connect instruction argument buffer 
      (containing disk address - 5 MSB and buffer bits - 3 LSB, eg. 11011 001,
      001 is disk address buffer) 
      with Bus Controller buffer controlling bus select lines
      => disk controller data buffer will be treated as data address buffer
    * connect CPU buffer (containing disk data address eg. 1010 1010) 
      to bus data lines,
      => disk controller data buffer will be writen with data address
    * enable transmission direction (from cpu to disk) using enable line 1
      => data buffer will be writable, cpu register readable 
    * enable transmission using enable line 2 => disk controller address buffer 
      will be writen with address (1010 1010)
  * wait or get notified (because disk reading is slow):
    * transfer disk data to register (eax) waiting fixed number of cycles:
      * connect instruction argument buffer 
        (containing disk address - 5 MSB and buffer bits - 3 LSB, eg. 11011 010,
        010 is disk data out buffer) with 
        Bus Controller buffer controlling bus select lines
        => disk controller data buffer will be treated as data out buffer
      * connect CPU buffer (waiting for data eg. eax) 
        to bus data lines,
        => disk controller data buffer will write out data to bus
      * enable transmission direction (from disk to cpu) using enable line 1
        => data buffer will be readable, cpu register writable 
      * enable transmission using enable line 2 => disk controller data out buffer 
        will be read to cpu (eax)
      * wait
      * done, do next instruction
    * specify notification request, do other work, when notified read disk data out buffer:
      * bus select = interrupt disk buffer (port) eg. 11011 111, 111 
      * bus data = interrupt enable eg. 0000 0001 (simplified form, could be also
        interrupt information, eg. disk id in other buffers for providing to interrupt
        controller.)
      * transmission direction = cpu to controller
      * enable transmission
      * temporarly done, do next instructions
      * when cup is interrupted:
        * transfer disk data out to register eax
      * done, do next instruction 



# Cache (distributed memory) coherence

<Michael E. Thomadakis, The Architecture of the Nehalem Processor and Nehalem-EP SMP Platforms>



Invalid:

Initially all blocks in a cache do not store actual data and they are in the
**“Invalid”** state. When a core reads a dataobject, it always checks first the L1
memory to see if the block is already there. The first time a block is accessed
results in a cache read miss and it is in the Invalid state. If the block is
not in L1 but is found in the L2 cache (L1 miss and L2 hit), it is transferred
to the L1 data cache and the data access instruction proceeds. 
If the block is neither in the L2, then it must be retrieved from the “un-core”.
In general, a read-miss causes the core to retrieve the entire 64-byte cache
block containing the object into the appropriate cache (L1, L2, L3, or all).
This operationis called a cache-line fill.  

“Exclusive” :

A block read for the first time by any core transitions to the **“Exclusive”** state.
The next time a core needs to access the same or nearby memory locations, if the
block is still in the cache the data object is retrieved directly from the cache
instead of going back to memory. This is called a **cache hit**. 


“Shared”:

When a core A has already retrieved a block in the Exclusive state and core B
requires to read the same block,the cache coherence h/w stores a copy of this
block in the cache of core B and changes its state to **“Shared”**. 


Write hit and Write miss:

When a core wants to write an operand to memory, it first checks if the
corresponding block is already in the cache. If a valid cache line does exist,
the processor can write the operand into the cache instead of writing it out to
system memory. This operation is called a **write hit**. A write which refers to
a memory location not currently in the cache causes a **write-miss**. In
this case the core performs a **cache line-fill**, **write allocation** and proceeds
to modify the value of the operand in the cache line without writing directly to
memory. 


Write allocate optimisation:

The Intel64 architecture does not **write-allocate** on a **write miss** if
when the write operation is **“non-temporal”**. When data is **“streamed”** in and out
of the processor, as the case may be with SIMD/vector operands, there is no
need to store this data in the cache as it is not expected to be needed in the
near future. Write allocate operations are costly especially when the block to
enter the cache would have to evict a modified block already resident in a
conflicting cache location. The Intel compilers may select the non-temporal
write operations when it is evident that the written data are streamed out of
the processor. 


Modified:

When a core attempts to modify data in a block in the Shared
state, the h/w issues a **“Request-for-Ownership” (RfO) transaction** which
**invalidates** **all** copies in **other caches** and **transitions its own (unique now)** copy
**to Modified** state.  The owning core can read and write to this block without
having to notify the other cores. If any of the cores previously sharing this
block attempts to read this block, it will receive a cache-miss since the block
is Invalid in that core’s cache.  Note that when a core attempts to modify data
in a Exclusive state block, NO “Request-for-Ownership” transaction is necessary
since it is certain that no other processor is caching copies of this block. 


Snooping:

For Nehalem which is a multi-processor platform, the processors have the
ability to “snoop” (eavesdrop) the address bus for other processor’s accesses to
system memory and to their internal caches. They use this snooping ability to
keep their internal caches consistent both with system memory and with the
caches in other interconnected processors. If through snooping one processor
detects that another processor intends to write to a memory location that it
currently has cached in Shared state, the snooping processor will invalidate its
cache block forcing it to perform a cache line fill the next time it accesses
the same memory location. If a core detects that another core is trying to
access a memory location that it has modified in its cache, but has not yet
written back to system memory, the owning core signals the requesting core (by
means of the“HITM#” signal) that the cache block is held in Modified state and
will perform an implicit write-back of the modified data. The implicit
write-back is transferred directly to the requesting core and snooped by the
memory controller to assure that system memory has been updated. Here, the
processor with the valid data can transfer the block directly to the other core
without actually writing it to system memory; however, it is the responsibility
of the memory controller to snoop this operation and update memory. 


Associativity and replacement strategy:

Each memory block can be stored in a unique set of cache locations, based on a
subset of their memory block identification. A cache **memory with associativity**
K can store each memory block to up to K alternative locations. If all K cache
slots are occupied by memory blocks, the K+1 request will not have room to store
this latest memory block. This requires that one of the existing K blocks has to
be written out to memory (or the inclusive L3 cache) if this block is in
Modified state. Cache memories commonly use a **Least Recently Used (LRU)** 
**cache replacement strategy** where they evict the block which has not 
been accessed recently. 


Store buffer:

As we mentioned, before written out to memory, **data** operands are first
**saved** in a **store buffer**. They are then written from the **store buffer** to memory
when the system **path to memory is available**. Note that when all 10 of the
**line-fill buffers in a core become occupied**, outstanding data access operations
**queue** up in the **load and store buffers** and cannot proceed. When this happens
the core’s front end suspends issuing newmicro-ops to the RS and OOO engine to
maintain pipeline consistency.


5.2.3  The Un-Core Domain and Multi-Socket Cache Coherence


In the Nehalem processor the “un-core” domain essentially is a shared last level
L3 cache (“LLC”), a memory access chip-set (“Northbridge”), and a QPI socket
interconnection interface. The un-core supports cache line access
requests (such as, L2 cache misses, “un-cacheable” loads and stores) from the
on-chip cores and transfers data among the L3 cache, the local IMC, the remote
socket and the I/O Hub. 


Memory consistency in a multi-core, multi-socket system
like the Nehalem-PE, is maintained across sockets. With the introduction of the
Intel Quick-Path Interconnect protocol the, 4 MESI states are supplemented with
a fifth, “Forward” (F) state. 

Forward:

A specific cache memory is chosen to store a block
in the Forward state and it is allowed to forward it to other requesters. Blocks
in the Shared state cannot be directly forwarded. Forwarding of a block from a
single cached location only is done to avoid cache coherence protocol complexity
and unnecessary data transfers. This would occur if multiple caches were
allowed to forward the same block to a requester. Forwarding is
done beneficially when a block belongs to a remote IMC, it is already cached by
the remote L3 and it can be forwarded by th L3 faster than accessing the remote
DRAM. 

Global Queue:

Cache line requests from the on-chip four cores, from a remote chip or the
I/O hub are handled by the Global Queue(GQ) which resides in the
Uncore. The GQ buffers, schedules and manages the flow of data traffic through
the uncore. The operations of the GQ is most-critical for the efficient
exchange of data within and among Nehalem processor chips. The GQ
contains 3 request queues for the different request types:

Write Queue(WQ): is a
16-entry queue for store (write) memory access operations from the local
cores.

Load Queue(LQ): is a 32-entry queue for load (read) memory requests by the
local cores.

QPI Queue(QQ): is a 12-entry queue for off-chip requests delivered
by the QPI links.

According to [10], each pair of cores share one port to the
Global Queue. Thus for the two core pairs on a chip there is a total of 64
request buffers for read operations to the local DRAM. We suspect that this
buffer limit places an artificial upper bound in the available read bandwidth to
the local DRAM. Unfortunately, no other information is available to elucidate the
limitations of the GQ h/w. A “cross-bar” switch assists GQ to exchange data
among the connected parts. 

When the GQ receives a cache line request from one of
the cores, it first checks the on-chip Last Level Cache (L3) to see if the line
is already cached there. As the L3 is inclusive, the answer can be quickly
determined. If the line is in the L3 and was owned by the requesting core it can
be returned to the core from the L3 cache directly. If the line is being used by
multiple cores, the GQ snoops the other cores to see if there is a modified
copy. If so the L3 cache is updated and the line is sent to the requesting core.
In the event of an L3 cache miss, the GQ sends out requests for the line. Since
the cache line could be cached in the other Nehalem chip, a request through the
QPI to the remote L3 cache is made. As each Nehalem processor chip has its own
local integrated memory controller, the GQ must identify the “home” location of
the requested cache line from the physical address. If the address identifies
home as being on the local chip, then the GQ makes a simultaneous request to the
local IMC. If home belongs to the remote chip, the request sent by the QPI will
also be used to access the remote IMC. 


This process can be viewed in the terms of
the QPI protocol as follows. Each socket has a “Caching Agent” (CA) which might
be thought of as the GQ plus the L3 cache and a “Home agent” (HA) which is the
IMC. An L3 cache miss results in simultaneous queries for the line from all the
CAs and the HA (wherever home is). In a Nehalem-EP system there are 3 caching
agents, namely the 2 sockets and an I/O hub. If none of the CAs has the cache
line, the home agent ultimately delivers it to the caching agent that requested
it. Clearly, the IMC has queues for handling local and remote, read and write
requests.



# Cache

Cache is a way of mediated comunication between memory and CPU 
increasing speed.


Basic Snoopy Protocols:

* Write Invalidate Protocol:
  * Multiple readers, single writer
  * Write to shared data:  an invalidate is sent to all caches which snoop and invalidate any copies
  * Read Miss: 
    * Write-through: memory is always up-to-date
    * Write-back: snoop in caches to find most recent copy
* Write Broadcast Protocol:
  * Write to shared data: broadcast on bus, processors snoop, and update copies
  * Read miss: memory is always up-to-date
* Write serialization: bus serializes requests
  * Bus is single point of arbitration


## One cache for N CPUs - write throught


If for example memory is much slower than CPU but there
could be few memory modules with parralel access, then
big blocks of memory data could be provided to cache,
to which CPU could have fast serial random access.
After work of CPU, data in cache would be synchronised with 
memory. This is big simplification, but it gives image
of situation.



## Simple cache networks

There could be few cache modules and few CPUs and memory.
Data in memory and caches from the view of CPU instructions
(indirectly) reading and writing memory must be the same.

It is interesting how this could be solved, because
similar problems frequently arise in programming.

### Rule

Any change to local reference must inform/change other
references. But it is not so simple/efficient
in practice, because, how to know (keep track) about any other
references (with finite resources - cache size for example..), 
and how to inform/change other 
references (connections could be indirect, information transmission
could be implayed - by earsdropping for example..).

And of course it is neccessary to remember that 
there is situations impossible to solve
at this level, it is when at least 2 CPU change data
to different value at the same time.
But it is avoided by locks in computer programs.

To propagate change communication links must be available.
The communication link may be:

* Mediated
* Direct
* Half direct (eavesdrop, snoop on).

And additionaly:
* one way (half duplex) or
* two way (duplex)


### Interconnected servers

Situation; there is:

* Memory server (not very needed, used when no one needs data)
* Cache servers 1,2,3
* CPU (clients) 1,2,3

And all are interconnected, but sending
message takes limited random time.


What if two clients change data one after other?...

What if one client change data and other read old
data before notification came? Other should then
ask others if data is valid..

How to reduce traffic?
How to add routs to speed up main traffic?


### Tree topology - Problematic


CPU read write data synchronization in situation
where CPU can communicate with cache and caches
can communicate with memory (communication
between caches is impossible).


CPU1 want to read data, then asks/commands for this data Cache1, then:
* Cache1 has this data => CPU1 recives data.
* Cache1 have not this data => Cache1 asks Memory 
  => Cache1 saves data => CPU1 receives data.

CPU1 want to write data, then asks/commands for this data Cache1, then:
* Cache1 has this data 
  1. => Cache1 casches new value 
  2. => Cache1 asks/commands Memory to write data => Memory write data
  3. => Memory asks Cache2 to write data:
     * Cache2 have old data (needs marker)
       1. => Cache2 writes new data
     * Cache2 have changed data
       1. => **problem** => need transactions/acknowledgements 
     * Cache2 haven't got data
       1. => Cache2 do notching 
  4. => CPU1 written data.





### Tree with snooping topology - linearly scalable

It is easier to construct fast synchronization
when snooping is available.

Components are connected in tree topology but also
every cache can snoop every bus. For 3 caches
every cache will also snoop 3 buses.

![Tree with snooping](images/mermaid/cache.svg "Cache")

Then every cache line in every cache will be in one of states
(which must be saved and managed in caches):
* Invalidated (I) - line not in cache, or client asked for line removal/refresh
* Shared (S) - line in cache, and possibly in other caches, asked for read by client
* Modified (M) - line in cache, and possibly in other caches, 
  asked for modification by client

And then when remote cache line changes state,
(which is known because cache snoops every bus) 
local cache line must change accordingly to table below:

| --------Remote<br/>Local   | M<br/>- |	S<br/>- |	I<br/>- |
|---|---|---|---|
| M | ✖ | ✖ | ✔ |
| S | ✖ | ✔ | ✔ |
| I | ✔ | ✔ | ✔ |

So for example:
* Multiple reads => multiple cache lines in state (S)
* Read/Write when nobady else cares => others dont care, do nothing with it (I)
* Write when somebody cares => others change state to invalid (I), modifier
  must write to memory (because from there others will read valid data).


### Page directory solution - logaritmicly scalable 


## Distributed schared memory

### Distributed directory in ccNUMA

Directory is **subset** of addresses manager mediating
between caches and (subset of all) memory.
Every non local memory instruction must go through
directory (one of many directories), by ask and acknoledgement,
also directory can instruct caches (to invalidate line for example).

For each line in (part of) memory there is directory with lines.
Directory line is telling
what caches have this line cached and who is designated owner.


Some example with 2 memories (directories) and 3 caches:

```
|--------------------------------------------------|
|  Directory1:            |   Directory2:          |
|--------------------------------------------------|
|  1: 101                 |   1: 010               |
|  2: 010                 |   2: 100               |
|  3: 110                 |   3: 001               |
|  4: 000                 |   4: ...               |
|  ...                    |   ...                  |
|  19: ...                |   19: ...              |
|--------------------------------------------------|
|  Memory1:               |  Memory2:              |
|--------------------------------------------------|
|  1: some data 1         |  21: some data 21      |
|  2: some data 2         |  22: some data 22      |
|  3: some data 3         |  23: some data 23      |
|  4: some data 4         |  24: some data 24      |
|  ..                     |  ...                   |
|  19: some data 19       |  29: some data 29      |
|--------------------------------------------------|
|  Cache1:                |  Cache2:               |
|--------------------------------------------------|
|  1: some data 1, 1      |  1: some data 21, 1    |
|  2: some data 22, 22    |  2: some data 2, 2     |
|  3: some data 3, 3      |  3: some data 23, 23   |
|  ...                    |  ...                   |
|--------------------------------------------------|
|  Cache3:                |                        |
|  1: some data 1, 1      |                        |
|  2: some data 2, 2      |                        |
|  3: some data 23, 23    |                        |
|  ...                    |                        |
|--------------------------------------------------|

```

![Distributed directory](./images/cache/Distributed_directory.png "Cache")

Behavior of shared directory:

* On reads, directory tells requesting node exactly where
  to get the line from
  * Either from home node (if the line is clean)
  * Or from the owning node (if the line is dirty)
  * Either way, retrieving data involves only point-to-point
    communication
* On writes, the advantage of directories depends on the 
  number of sharers:
    * In the limit, if all caches are sharing data, all caches must be communicated with (just like broadcast in a snooping protocol)


Useful links:
* Lecture notes by  Randal Bryant and Nathan Beckmann, [Parallel Computer Architecture and Programming, ](http://www.cs.cmu.edu/afs/cs/academic/class/15418-s19/www/schedule.html)
* <http://www.cs.cmu.edu/afs/cs/academic/class/15418-s19/www/lectures/>



## Cache build and organization

The question are:
* at what address put memory address
  data in finite cache? 
* and how to find cached memory address data?
* and how to do it in one or only few operations?

Basically there are two solutions:
* every address will have predefined place, but because
  this is onto mapping, memory addresses will be partitioned
  and only one point of partition could be in cache at 
  specific time (e.g. memory have M lines, cache have N lines,
  then every address will have cache addres `M mod N` so at particular
  cache address can be one of `M/N` memory addresses and nowhere else), or
* paralelly search all cache lines

On figure below there are examples of predefined place solution (Direct Mapped, 
1-Way Associative) and simulated parrallel solution (2-Way Associative),
true parralel solution would be  ∞-Way Associative (memory address can
be at any cache address).


![Cache associativity](images/cache/Cache,associative-fill-both.png)

### SRAM - 1-Way-associative cache

One way associative cache could be realized as SRAM table.
For cache and retrive instructions there would be needed also:
* cache(address) -> ok => modulo aritmetic module,
* retrive(address) -> maybe => address comparison module, 
* storage of fragment of memory address.

This is because, to put address data at this cache, cache address
must be computed (e.g.: `cache_addr = mem_addr % cache_size`), 
to retrive cached address data, also cache address must be computed
and additionally since at cache address there can be (in this situation)
many possible memory addresses, requested address must be compared
with stored (stored it must not be full address but bits filling 
partition size: `cache_line = memory_address_distinguisher & memory_data` ).

Mechanism for cache_address and memory_address_distinguisher is by
using tag fild inside cache line. Examples are in [Wikipedia Cache Placement
Policy](https://en.wikipedia.org/wiki/Cache_placement_policies) article.


But question arises, does cache use phisycal or virtual addresses?
Physycal addresses works, but need translations. So how to use virtual
addresses? This is possible and used but boring, so let left this
question open.

Cache row entries usually have the following structure:
`cache line = tag + data block + flag bits `.

![Cache tagging ways](images/cache/Cache,associative-read.svg)



### SRAM + - N-Way-associative cache

Nice optimisation, using still SRAM, would be to allow N address mapping,
for example:
```
cache_addr = mem_addr % cache_size
OR
cache_addr = mem_addr % cache_size + 1
OR
cache_addr = mem_addr % cache_size + 2
...
OR
cache_addr = mem_addr % cache_size + N
```

then, N cache addresses maight be needed to check for memory 
address and its data. It is slower but still easly predictable,
and in optimistic situations similar to 1-Way associative.


### CAM (Content Addressable Memory) - Fully-associative cache

[Wikipedia CAM](https://en.wikipedia.org/wiki/Content-addressable_memory)

Content-addressable memory (CAM) is a special type of computer memory used in
certain very-high-speed searching applications. It is also known as associative
memory or associative storage[a] and compares input search data (tag) against a
table of stored data, and returns the address of matching data (or in the case
of associative memory, the matching data).


CAM is frequently used in networking devices where it speeds forwarding
information base and routing table operations. 


Unlike a RAM chip, which has simple storage cells, each individual memory bit
in a fully parallel CAM must have its own associated comparison circuit to
detect a match between the stored bit and the input bit. Additionally, match
outputs from each cell in the data word must be combined to yield a complete
data word match signal. The additional circuitry increases the physical size
and manufacturing cost of the CAM chip. The extra circuitry also increases
power dissipation since every comparison circuit is active on every clock
cycle.


So fully-associative cache needs to store in **every** cache line:
* memory address,
* memory address data,
* cache line address itself,
* memory comparer.

Then every line would be connected to buses:
* cache address
* (in/out) cache address data

Because there must be possibility to write/read selected line.

And also:
* every cache line must have schared connection to search address bus (in),
* every cache line must have schared connection to search matching 
  cache address bus (out).

Because when searching for memory address, searched address must be
broadcasted to every cache line and compared there, if (at most)
one cache line have match, it would transfer cache line (itself) address 
to (shared out) cache addres bus, then chache line address can be
used to address apriopriate line and return cached memory data.



# HTTP protocol


## Uniform Resource Locators (URLs)


```
          userinfo          host        port
       ┌───────┴───────┐ ┌────┴────────┐ ┌┴┐
http://john.doe:password@www.example.com:123/forum/questions/?tag=networking&order=newest#top
└─┬─┘ └───────────┬────────────────────────┘└─┬─────────────┘└────────┬──────────────────┘└┬─┘
scheme         authority                      path                  query             fragment
```




# Magnetic Hard Disk Drive (HDD)

<https://commons.wikimedia.org/w/index.php?title=File%3AHarddrive-engineerguy.ogv>
<https://en.wikipedia.org/wiki/Hard_disk_drive>


## Mechanical addresses

<https://superuser.com/questions/974581/chs-to-lba-mapping-disk-storage>
<https://en.wikipedia.org/wiki/Cylinder-head-sector>


![Disk 2](images/devices/disk/Cylinder_Head_Sector.svg)


Magnetic disks are composed of:
* platters - flat disks on which magnetizable material is sputtered,
  rotating usualy 10 000 rpm (rounds per minute),
* arms with heds - magnetic sensing movable devices, 
  all moving in the same way

Addreses are composed of:
* tracks - circles on platters
* cylinders - tracks strictly below each other
* sectors - fragments of track (usually 512 B), consisting of:
  * preamble - to distinguish sectors and informations as:
    * cylinder number
  * data
  * ECC - check/management informations

The slowest operation for address accessing is **seek** which
is changing tracks/cylinders by the arm.


![Disk addresses](images/devices/disk/Disk-Cylinder_Track_Sector.png)
![Disk sectors](images/devices/disk/Disk_sectors.png)


Before use disk needs to be partitioned, 
preambles and ECC must be written.

Depending on organization address may be:
* platter# track# sector#
* cylinder# sector#

### Bad sectors

There are always bed sectors, which are detected when disk testing.
So every track have few replacement sectors at the end available
to disposal. Also disk came from manufacturer with list of bad sectors.
Disk controller or operating system can do track sectors remap.



## Logical addresses 


### MBR and Partition(s)

Sector 0 contains the MBR (Master Boot Record), 
which contains:
* boot code 
* ...
* partition table at the end, which contains: 
  * list of partitions (for x84 it can contain up to 4 entries),
    consisting of:  
    * start sector (32 bit)
    * size (32 bit)
  * indicator of active partision - for booting


Maximum partition size for MBR can be 2TB (assuming 512 B sector size).
For this reason, new scheme now is also supported - GPT (GUID Partition Table).

### Partition(s) 

Partition have partition table with:
* a boot block, 
* the free storage administration (free list or bitmap), 
* root directory, 
* empty file system,
* entry telling which file system is used in the partition.


### Booting

At this point the system can be booted. When the power is turned on, the BIOS
runs initially and then reads in the master boot record and jumps to it. This
boot program then checks to see which partition is active. Then it reads in the
boot sector from that partition and runs it. The boot sector contains a small
program that generally loads a larger bootstrap loader that searches the file
system to find the operating system kernel. That pro- gram is loaded into memory
and executed.




# Instructions and devices virtualization

Intel and AMD in x86 line introduced virtualization (in 2005).
This extension allows to specify which operations should cause
trap in user mode. It is controlled by hardware bitmap set
by the hypervisor.

This way containers can be done by trap-and-emulate method,
othervise binary translation is needed.

## Devices virtualization

Early forms of device emulation implemented shadow forms of device interfaces in
the hypervisor to provide the guest operating system with a virtual interface to
the hardware. This virtual interface would consist of the expected interface,
including a virtual address space representing the device (such as shadow PCI)
and virtual interrupt. But with a device driver talking to a virtual interface
and a hypervisor translating this communication to actual hardware, there's a
considerable amount of overhead—particularly in high-bandwidth devices like
network adapters.


Shared resource problem:

* Virtual device driver connected to traps of device instructions at supervisor 
  will work as routers or switches and use original drivers underneath 
  for actual work.
* A different approach to handling I/O is to dedicate one of the 
  virtual machines to run a standard operating system and reflect 
  all I/O calls from the other ones to it.
  This approach is enhanced when paravirtualization is used, so the 
  command being issued to the hypervisor actually says what 
  the guest OS wants (e.g., read block 1403 from disk 1) 
  rather than being a series of commands writing to device 
  registers, in which case the hypervisor has to play Sherlock Holmes 
  and figure out what it is trying to do. Xen uses this approach 
  to I/O, with the virtual machine that does I/O called domain 0.
* with time, more and more devices are providing virtual interface,
  so mediator at host on/hypervisor between guest and device is not
  needed, multiple guest are directly connected to such a devices.


<https://wiki.xen.org/wiki/Xen_PCI_Passthrough>
The IOMMU allows Xen to limit what memory a device is allowed to access. It
also allows Xen to give the device the same virtualized memory layout that the
guest sees. This solves both the security problem and the memory virtualization
problem. 

```
> lspci
```

## Type 1 and Type 2 hypervisors

There are two main types of hypervisors (as on figure below [Tanebaum, 7.3]):
* Type 1 - hypervisor is operating system (only program working truely in kernel
  mode), its job is to provide multiple copies of the actual hardware,
* Type 2 - hypervisor is underlaying operating system program (or kernel module).

![Hypervisors types](images/virtualization/Virtualization_hypervisor_types.png)
![Type 1 Hypervisor](images/virtualization/Virtualization_Type_1_Hypervisor.png)


What happens when the guest operating system (which thinks it is in kernel mode)
executes an instruction that is allowed only when the CPU really is in kernel
mode? Normally, on CPUs without VT, the instruction fails and the operating
system crashes. On CPUs with VT, when the guest operating system executes a
sensitive instruction, a trap to the hypervisor does occur. The hypervisor can
then inspect the instruction to see if it was issued by the guest operating
system in the virtual machine or by a user program in the virtual machine. In
the former case, it arranges for the instruction to be carried out; in the
latter case, it emulates what the real hardware would do when confronted with a
sensitive instruction executed in user mode.


Our default hypervisor type will be Type 2.

## How (Type 2/1) hypervisor starts?

When hypervisor is run it behaves as booting computer.
It will check dvd, usb, disks to find booting code
(installer or installed system). This is funny because,
if hypervisor would use identical machine as OS in which
it is running, it will run the same OS and itself, and
then it would do the same infinitly times. Of course
before running hypervisor it can be configured, to for
example see only part of disks, have access to virtual
CD with mounted iso image file of Linux, etc...


## Useful consequences

Useful:
* Resources (devices) could be virtually routed/switched
* Network cards can be also virtualized
* Drivers can be presented as generic, e.g.:
  * SATA disk can be presented as simple IDE
  * accelerated graphics as VGA, etc.


## MMU virtualization

MMU in simplest form maps linear addresses to physical
in the form of page tables.
Virtualization needs nested mapping, for example: 
virtual linear addresses to virtual physical addresses 
(to linear addresses) to physical addresses.

MMU is dynamicaly configurable hardware translator of
addresses from CPU to Main Memory (controller using bus).

MMU also dynamicaly **arbitrates** memory bus, so every 
device connected to this bus must be also connected to MMU who will
decide current bus master.

MMU also protects computer by checking processor state (user or kernel) 
and compares with memory address current state (user, kernel, not allocated)
using page tables. (MMU protect dynamically specified user, kernel or 
unspecyfied memory address space).

## I/O MMU and DMA virtualization

I/O MMU uses page tables to map logical addresses (of devices)
to physical addresses (of bus).

It solves simple but important problem, Memory Mapped Devices
existing in guest kernel would be in user space, and underlaying
addresses will be different for different guests. So this
addresses must be translated, it can be done using IOMMU and
its page tables. It also isolates device addresses accesses
from different guests.

DMA (subproccessor allowed to access memory and devices buses) 
can (among others) copy (using bus) device buffer to main memory.


Input–Output Memory Management Unit (IOMMU) 
is a memory management unit (MMU) that connects 
a direct-memory-access–capable (DMA-capable) I/O bus 
to the main memory. The IOMMU maps device-visible virtual addresses 
(also called device addresses or I/O addresses in this context) 
to physical addresses. Some units also provide memory protection 
from faulty or malicious devices. <https://en.wikipedia.org/wiki/Input%E2%80%93output_memory_management_unit>



OS build devices port map, this map is than translated by dynamically
configurable IOMMU to addresses of bus pins (for out of band communication) 
or assigned addresses (like IP or MAC, for in band communication).
 
IOMMU can be also connected (by for example PCIE) to MMU for 
synchronization of main memory with devices port map.
This way there exists two address spaces, but IO address space
is synchronized with fragment of main memory address space
and fragment of main memory is synchronized with IO. This
probably needs acknowledges maybe also mapped to main memory.


It is possible to dynamically map main memory to IO address buffer,
it would result in pointer semantics, if not used inter main memory
copying is needed (however synchronization done by hardware or software
between main memory and device buffer always needs copying).

<https://en.wikipedia.org/wiki/Heterogeneous_System_Architecture>
![Zero copy](images/buses/buses_HSA-enabled_virtual_memory_with_distinct_graphics_card.svg)


Uniform address space can be simulated by software (hardware can
also help). 
Pure hardware architecture would be address consisting
of device bus address + device internal memory address.

# Para virtualization

Paravirtualization is operating system for other operating systems. Native
operating systems must be mapped to conforming format. 
(Guest OS has to be aware of the virtual machine API.)

![Paravirtualization and true virtualization](images/virtualization/Virtualization_Paravirtualization.png)


Paravirtualization presents machine-like software interface that explicitly
exposes the fact that it is a virtualized environment. For instance, it offers a
set of hypercalls, which allow the guest to send explicit requests to the
hypervisor (much as a system call offers kernel services to applications).
Guests use hypercalls for privileged sensitive operations like updating the page
tables, but because they do it explicitly in cooperation with the hypervisor,
the overall system can be simpler and faster.

![Portable paravirtualization](images/virtualization/Virtualization_portable_paravirtualization.png)

# Process level virtualization

Well-known examples include:
* the WINE compatibility layer that allows Windows application to run on
  POSIX-compliant systems like Linux, BSD, and OS X, 
* the QEMU emulator that allows applications for one architecture to run on
  another.



# Buses arbiters
Images from <http://www.mathcs.emory.edu/~cheung/Courses/355/Syllabus/5-bus/bus-arbiter.html>

![Bus arbitration idea](images/buses/Buses_arbitration.png)

## Idea

![Bus arbitration idea](images/buses/buses.gif)


## Daisy

![Bus arbitration idea](images/buses/buses_arbiter_daisy.gif)


## PCI centralized arbiter


![Bus arbitration idea](images/buses/buses_arbiter_centralized.gif)


# Busses

```
cat /proc/interrupts  # lists the current interrupts in use
cat /proc/ioports     # lists the ioports (base addresses) in use
cat /proc/dma         # lists the current dmas in use
```

```
  _________
 |   CPU   |
 |  Cache  |
 |_________|
      |
+==================================================+ bus
      |                |                |      
 _____|_____      _____|_____      _____|_____ 
| IO buffer |    |    Data   |    |    Data   |
|  Memory   |    |   Status  |    |   Status  |
|___________|    |  Command  |    |  Command  |
                 |           |    |           |                              
                 | Controller|    | Controller|
                 |___________|    |___________|
                       |                |      
                  _____|_____      _____|_____ 
                 |   Device  |    |   Device  |
                 |___________|    |___________|

```

controller registers:
* data register -holds data byte going to/from device
* status register -holds bits indicating if device is ready, error, etc.
* command register -bit for read, bit for write, etc. 
  (may be combined with the status register)

access to controller registers either by:
* memory-mapped I/O (but must be setup by OS first),
* isolated I/O -special instructions (e.g., IN, OUT, INS, OUTs) 
  are required, use port numbers as addresses of the controller registers


Channel controller: provides for transfers of multiple blocks by traversing
linked-list-like channel programs; interrupt only when end of channel program
reached (or on error). A channel has the equivalent of a program counter.
Each channel instruction is called a "channel command word" (CCW).
Each CCW has address and count fields to support a block.

```
 ___________
| Channel   |
| PC = CCW1 |
|___________|

 ______________________________ 
| r/w | address | count | next |
|_____|_________|_______|______|
            CCW1
 ______________________________ 
| r/w | address | count | next |
|_____|_________|_______|______|
            CCW2
 ______________________________ 
| r/w | address | count | next |
|_____|_________|_______|______|
            CCW3

```

CCWs can also provide scatter-gather
* scatter -read data from a single physical block on an I/O 
  device and send different parts to multiple, non-contiguous 
  I/O buffers in memory
* gather -read data from multiple, non-contiguous I/O buffers 
  in memory and write a single physical block to the device



# PCI


Devices connected to the PCI bus appear to a bus master to be connected directly
to its own bus and are assigned addresses in the processor's address space.
It is a parallel bus, synchronous to a single bus clock. [Wikipedia Conventional PCI]


## Interrupts: INTA#, INTB#, INTC#, INTD#

<https://linux.die.net/HOWTO/Plug-and-Play-HOWTO-7.html>

Device puts a voltage on a dedicated interrupt wire (also called line or trace)
which is often reserved for that device alone. This voltage signal is called an
Interrupt ReQuest (IRQ) or just an "interrupt" for short. There are the
equivalent of 16 (or 24, etc.) such wires in a PC and each wire leads
(indirectly) to a certain device driver. Each wire has a unique IRQ (Interrupt
ReQuest) number. The device must put its interrupt on the correct wire and the
device driver must listen for the interrupt on the correct wire. Which wire the
device sends such "help requests" on is determined by the IRQ number stored in
the device. This same IRQ number must be known to the device driver so that the
device driver knows which IRQ line to listen on.

### Details

Each PCI card (and device mounted on the motherboard) has 4 possible interrupts:
INTA#, INTB#, INTC#, INTD#. From now on we will call them just A, B, C, and D.
Each has its own pin on the edge connector of a PCI card. Thus for a 7-slot
system (for 7 cards) there could be 7 x 4 = 28 different interrupt lines for
these cards. Devices built into the motherboard also have additional interrupts.
But the specs permit a fewer number of interrupt lines, so some PCI buses seem
to be made with only 4 or 8 interrupt lines. This is not too restrictive since
interrupts may be shared. For 4 interrupt line (wires, traces, or links) LNKA,
LNKB, LNKC, LNKD there is a programmable "interrupt router" chip that routes
LNKA, LNKB, LNKC, LNKD to selected IRQs. This routing can be changed by the BIOS
or Linux. For example, LNKA may be routed to IRQ5. Suppose we designate the B
interrupt from slot 3 as interrupt 3B. Then interrupts 3B and 2A could both be
permanently connected to LNKA which is routed to IRQ5. These 2 interrupts: 3B
and 2A are permanently shared by hardwiring on the motherboard.

One may type "dmesg" on the command line to see how interrupt lines like LNKA
are routed (or linked) to IRQs (*5 means that it's linked to IRQ 5). Look for
"PCI Interrupt Link". Note that "link" is used here with two meanings: 1. the
linking (routing) of PCI interrupt lines to IRQs. 2. the label of an interrupt
line such as LNKB (link B). The interrupt line labels seem to be provided by the
Bios ?? and they may have many different names like: LNKC, LNK2, APCF, LUBA,
LIDE, etc. Question: When a large number of interrupt lines are shown disabled,
do they all physically exist on the motherboard? Or do they just exist only in
the ACPI BIOS software so that the BIOS can work with motherboards which have
more interrupt lines?

```
> dmesg | grep "PCI Interrupt Link"
[    0.244528] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.244621] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.244714] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.244804] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.244892] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.244980] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.245068] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.245156] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 10 11 12 14 15) *0, disabled.
```


One simple method of connecting (hard-wiring) these lines from PCI devices (such
as 3B) to the interrupts LNKA, etc. would be to connect all A interrupts (INTA#)
to line LNKA, all B's to LNKB, etc. This method was once used many years ago but
it is not a good solution. Here's why. If a card only needs one interrupt, it's
required that it use A. If it needs two interrupts, it must use both A and B,
etc. Thus INTA# is used much more often than INTD#. So one winds up with an
excessive number of interrupts sharing the first line (LNKA connected to all the
INTA#). To overcome this problem one may connect them in a more random way so
that each of the 4 interrupt lines (LNKA, LNKB, LNKC, LNKD) will share about the
same number of actual PCI interrupts.

One method of doing this would be to have wire LNKA share interrupts 1A, 2B, 3C,
4D, 5A, 6B, 7C. This is done by physically connecting wire W to wires 1A, 2B,
etc. Likewise wire LNKB could be connected to wires 1B, 2C, 3D, 4A, 5B, 6C, 7D,
etc. Then on startup, the BIOS maps the LNKB, LNKA, LNKC, LNKD to IRQs. After
that, it writes the IRQ that each device uses into a hardware configuration
register in each device. From then on, any program interrogating this register
can find out what IRQ the device uses. Note that just writing the IRQ in a
register on a PCI card doesn't in any way set the IRQ for that device. 


## Address spaces

Problem of addresses: they must be unique, and there must be a way
to search for existing, assign new, and delate unused.

But from different point of view this problem is very simple,
any inter computer bus will have finite dimentions, and every
slot for card have its placement, so also address. There
can be bridges but it is not a problem. So every slot would
have to have buffer with slot number. Then devices would need
to support "slotted" protocol and unambigious communication
would be possible.

For systems where devices would be assembled only once, simpler
solution would be if manufacturer assigned address buffers 
in ROM, dip switches, etc and provided software with those
addresses in BIOS. (It is done partially for devices such as
first keybord, signaling diodes, etc.)

Configuration must allocate devices resources, which are
described in devices configuration buffers, but there might
be conflicts, so it is not so easy for wird hardware compositions,
sometimes it can't be done automatically.
But when configuration is finely done, it can be stored for next computer reboot
in nonvolentaile memory (disk or bios). 
PnP/PCI BIOS stores this configurabion in BIOS's ESCD Database.
Kernel can also store it.
But than some device could be added, and problem arises again,
reconfiguration and possibly balancing must be done once again,
by BIOS and maybe kernel.
Then the kernel provides the device drivers with functions (program code)
that the drivers may use to find out: 
* if their device exists, 
* how it's been configured, 
* and functions to modify the configuration if needed.

The kernel uses for it PnP PCI standard, ACPI, etc. This by no means guarantees
that all drivers will fully and correctly use these features. And legacy devices
that the BIOS doesn't know about, may not get configured until you (or some
configuration utility) puts its address, irq, etc. into a configuration file. 
But the kernel helps avoid resource conflicts by not allowing two devices
that it knows about to use the same bus-resources at the same time (IRQs, DMA, memory).
Also on 32-bit PCs there is 4GB of main memory address space and much of 
this bus-resource is available for device IO 
(unless you have 4GB of main memory installed).

**Documentation**: /usr/.../.../Documentation where one of the ... contains 
the word "kernel-doc" or the like. see pci.txt ("How to Write Linux PCI Drivers") 
and the file: /usr/include/linux/pci.h.


After successful configuration applications frendly address spaces 
(memory, IO) can be configured.
PCI offers 3 address spaces for the x86 processor family, 64 and 32 bits:
* I/O port address space - can be dynamically assigned by software. 
  Often, the device driver does both of these (sort of). The device driver 
  doesn't actually need to set an I/O address if it finds out that the address 
  has been previously set (perhaps by the BIOS) and is willing to accept 
  that address. Once the driver has either found out what address has been 
  previously set or sets the address itself, then it obviously knows what 
  the address is so there is no need to let the driver know the 
  address --it already knows it.
  There are two main steps to **allocate** the I/O addresses 
  (or some other bus-resources such as interrupts on the ISA bus):
  * Set the I/O address, etc. in the hardware (in one of its registers)
  * Let its device driver know what this I/O address, etc. is
* separate memory address space - can be dynamically assigned by software. 
  Many devices are 
  assigned address space in main memory. It's sometimes called "shared memory" 
  or "memory-mapped IO" or "IO memory". 
  **This memory is physically located inside the physical device** 
  **but the computer accesses it just like it would access memory on memory chips.** 
* DMA Direct Memory Access. Normally the CPU would make a transfer from a device 
  to main memory in a two step process:
  * reading a chunk of bytes from the I/O memory space of the device and 
    putting these bytes into CPU itself
  * writing these bytes from the CPU to main memory

  But in case of DMA it is done by device capable of main memory bus mastering.
  It uses usualy memory mapped address space, but theoretically could use also IO
  port address space.

* PCI Configuration Space - using fixed addressing scheme, allows software 
  to determine the amount of memory and I/O address space needed by each device.


### Choice of addressing space !!!

To access both I/O and (main) memory address "spaces" the same address bus is
used (the wires used for the address are shared). How does the device know
whether or not an address which appears on the address bus is a memory address
or I/O address? 

There are 4 dedicated wires on the bus that convey this sort of information.

For the PCI bus it's the same basic idea (also using 4 wires) but it's done a
little differently. Instead of only one of the four wires being asserted, a
binary number is put on the wires (16 different possibilities). Thus, more info
may be conveyed by these 4 wires.. Four of these 16 numbers serve the I/O and
memory spaces as in the above paragraph. In addition there is also configuration
address space which uses up two more numbers. This leaves 10 more numbers left
over for other purposes.

### Communicating Directly via Memory

Traditionally, most I/O devices used only I/O memory to communicate with the
CPU. The device driver, running on the CPU would read and write data to/from the
I/O address space and main memory. Unfortunately, this requires two steps. For
example, 1. read data from a device (in IO address space) and temporarily store
in in the CPU; 2. write this data to main memory. A faster way would be for the
device itself to put the data directly into main memory. One way to do this is
by using ISA DMA Channels or PCI bus mastering. Another way is for the physical
device to actually contain some main memory (at high addresses so as not to
conflict with main memory chip addresses). This way the device reads and writes
directly to it's self-contained main memory without having to bother with DMA or
bus mastering. Such a device may also use IO addresses.


Commands below prints various memory (virtual) addresses.

### IO port memory sections


```
## how IOports memory is regionised?
> sudo cat /proc/ioports
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0062-0062 : PNP0C09:00
    0062-0062 : EC data
  0064-0064 : keyboard
...
```

### Main memory sections

```
## how main memory is regionised?
> sudo cat /proc/iomem
00000000-00000fff : Reserved
00001000-00087fff : System RAM
00088000-000bffff : Reserved
  000a0000-000bffff : PCI Bus 0000:00
000c0000-000c3fff : PCI Bus 0000:00
000c4000-000c7fff : PCI Bus 0000:00
000c8000-000cbfff : PCI Bus 0000:00
000cc000-000cffff : PCI Bus 0000:00
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
20000000-201fffff : Reserved
  20000000-201fffff : pnp 00:06
20200000-40003fff : System RAM
40004000-40004fff : Reserved
  40004000-40004fff : pnp 00:06
40005000-b3b90017 : System RAM
b3b90018-b3ba0057 : System RAM
...


```

### PCI bus contents


For the PCI bus, the notation: 
* 00:1a:0 means: 
  * the PCI bus 00 (the main PCI bus), 
  * PCI card (or chip) 1a, 
  * and function 0 (the 1st device) on the card or chip. 
* 00:08:1 means:
  * the PCI bus 00 (the main PCI bus), 
  * PCI card (or chip) 1a, 
  * 2nd device on the card or chip.


Command for listing CPU buses: 

```
## check what is at (main) PCI bus
> lspci
00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM Controller (rev 09)
00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v2/3rd Gen Core processor PCI Express Root Port (rev 09)
00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core processor Graphics Controller (rev 09)
00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB xHCI Host Controller (rev 04)
00:1a.0 USB controller: Intel Corporation 7 Series/C216 Chipset Family USB Enhanced Host Controller #2 (rev 04)
00:1b.0 Audio device: Intel Corporation 7 Series/C216 Chipset Family High Definition Audio Controller (rev 04)
00:1c.0 PCI bridge: Intel Corporation 7 Series/C216 Chipset Family PCI Express Root Port 1 (rev c4)
00:1c.1 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 2 (rev c4)
00:1d.0 USB controller: Intel Corporation 7 Series/C216 Chipset Family USB Enhanced Host Controller #1 (rev 04)
00:1f.0 ISA bridge: Intel Corporation HM76 Express Chipset LPC Controller (rev 04)
00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family 6-port SATA Controller [AHCI mode] (rev 04)
00:1f.3 SMBus: Intel Corporation 7 Series/C216 Chipset Family SMBus Controller (rev 04)
01:00.0 VGA compatible controller: NVIDIA Corporation GF108M [GeForce GT 635M] (rev a1)
01:00.1 Audio device: NVIDIA Corporation GF108 High Definition Audio Controller (rev a1)
02:00.0 Ethernet controller: Qualcomm Atheros AR8162 Fast Ethernet (rev 10)
03:00.0 Network controller: Qualcomm Atheros AR9485 Wireless Network Adapter (rev 01)

## extended check what is at (main) PCI bus
> lspci -vv
00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM Controller (rev 09)
	Subsystem: Lenovo 3rd Gen Core processor DRAM Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: <access denied>
	Kernel driver in use: ivb_uncore

00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v2/3rd Gen Core processor PCI Express Root Port (rev 09) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: d2000000-d30fffff
	Prefetchable memory behind bridge: 00000000c0000000-00000000d1ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport
	Kernel modules: shpchp
...


```


### Memory and IO port address spaces setup

In a typical system, the firmware (or operating system) queries all PCI buses at
startup time (via PCI Configuration Space) to find out what devices are present
and what system resources (memory space, I/O space, interrupt lines, etc.) each
needs. It then allocates the resources and tells each device what its allocation
is.


The PCI configuration space also contains a small amount of device type
information, which helps an operating system choose device drivers for it, or at
least to have a dialogue with a user about the system configuration.


Devices may have an on-board ROM containing executable code for x86 or PA-RISC
processors, an Open Firmware driver, or an EFI driver. These are typically
necessary for devices used during system startup, before device drivers are
loaded by the operating system. 

(Not PCIe) In addition, there are PCI Latency Timers that are a 
mechanism for PCI Bus-Mastering devices to share the PCI bus "fairly".
Each PCI device that can operate in bus-master mode is required 
to implement a timer, called the Latency Timer, that limits the 
time that device can hold the PCI bus. When the counter reaches zero, 
the device is required to release the bus. If the bus is IDLE it may 
simply grab the bus again and transfer more data.


# Booting PC and BIOS

## Booting PC

<https://linux.die.net/HOWTO/Plug-and-Play-HOWTO.html#toc2.13>

When the PC is first turned on the BIOS chip runs its program to get the
computer started (the first step is to check out the motherboard hardware). If
the operating system is stored on the hard-drive (as it normally is) then the
BIOS must know about the hard-drive. If the hard-drive is PnP then the BIOS may
use PnP methods to find it. Also, in order to permit the user to manually
configure the BIOS's CMOS and respond to error messages when the computer starts
up, a screen (video card) and keyboard are also required. Thus the BIOS must
always PnP-configure devices needed to load the operating system from the
hard-drive.


# Great Linux Resources

[Guides](http://www.tldp.org/guides.html)

[HowTo's](http://www.tldp.org/docs.html#howto)



# Process


Machine executes instructions within machine context, one important fragment
of this context is kernel mode indicator. So there are to logical path 
of instructions.


Process is **kernel** when **kernel mode** switch is enabled
in machine. Change of mode (**mode switch**) can be caused by:
* specyfic machine instruction in user mode may enable kernel mode, but
  execution will jump to kernel mode address, (by system calls),
* specyfic machine instruction in kernel mode may disable kernel mode
  (after it will typically jump to user address),
* interrupt, then machine at any mode may be forced to enable kernel mode,
  and jump to kernel mode (interrupt) address
  (this mechanism is also used for enabling kernel mode in user mode).
  In kernel mode, most of interrupts can be disabled/enabled
  as neccessary.


When on one machine there is no way to machine to distinguish processes.
**Kernel**, by kernel mode, prowides this distinction. Additionally
kernel can be set up in such a way that it could be switched to
in neccessary times or even after every machine step, so by
this it can controll any other process.


Usually kernel is idealised and realized as machine resorces
controller serving and managing user processes.
This way without kernel process help, user processes can't do much,
but with help, they can much and usually much easier.


## OS services

For User processes OS prepares enviroment where each process have:
* separate virtual user address space for its own use,
* common virtual kernel address space, which user process cannot
  access, but this way kernel process can access its address space
  without changing address spacess,
* resources services, by having resources map and logic and performing
  also some task as background process (as swapper or pagedeamon, etc.),
* state services, required for pausing and executing user process.


Kernel (OS) services are **re-entrant**, meaning that multiple
servises are proper. This needs re-entrant instructions path,
so at least kernel services needs private stack whenever entered.
Process is path, processes are paralel, so it is enaugh if every
process (task, theread) have place for (per process) kernel stack
in its user virtual memory space (because memory space context switch
is not needed whend executing OS service instructions in kernel mode).


So here we have something new, kernel execution context:
* kernel executes in **process context** when executed instructions 
  (or some part of them) have addresses at user virtual memory space
  and kernel mode is enabled. As for example system call
  using per process kernel stack.
* kernel executes in **system context** - when executed instructions
  have addresses at kernel virtual memory space and kernel mode is enabled. 
  As for example interrupt driver handles.


## User Process

OS creates enviroment for user processes, but what are user processes?
As some philosopher said, bether ask how process behaves..:

* User process executes path of instructions, where:
  * set of instruction is the same for every user process, but
  * paths maight be different for every user process.
* User process is at some point on path of instructions,
  * it is specyfied by (per user process) program counter (PC).
* User process owns (temporally) (private) memory resources, in the sense that:
  * same name (address) of memory points to different memory resource
    for every user process, but
  * when user processes mutually agreeed with OS, memory resource may be
    shared by user processes and have same or different (per user process) 
    address (name),
  * set of memory names (addresses) are the same for every user process.
* User process owns (temporally) other resources by means of owning memory.
* User process is fundamental scheduling entity - it can be paused by kernel, and
  * only one user process can execute instructions on single (physical) CPU,
  * so so called threads are user proceesses,  
* User process can request resources/services form kernel (OS)
  * using system calls
* User process can be only created by:
  * kernel or
  * other user process using system call.
* User process can be only killed by:
  * kernel or
  * by itself using system call or
  * by other process (with required premissions by OS) using system call.
* User process have parent:
  * other user process or
  * init user process
  * pageout deamon is not user process, so its parents are
    neither inin nor other user process

## Path of the process samurai

Samurai:
* fork system call creates new process, which begins life in **idle state**,
* next fork (executing in kernel mode) moves process to **ready to run state**,
  waiting to be scheduled
* kernel selects it for execution, kernel initiates context switch and after
  setting new context, CPU starts executing process instructions, process
  is in **running state**
* next context switch to kernel, as a result of system call or interrupt,
  and return to running state, but if system call needs wait:
  * it calls sleep, and its moved to queue of sleeping processes, now in
    **sleeping state**
  * when resource available, event occured, kernel moves process to 
    **ready to run state**
  * when finly executing, first it will finish system call
* finally process system calls exit and becomes in **zombie state**,
  where exit status code and usage statistics are keep
  * it stay in this state until parent proccess call sleep, then all
    process informations and resources are removed.



## Process context

Context have components:
* user address space segments (.text, .bss, ...)
* control informations (address translation map, kernel stack, 
  u area, proc structure, all is kept in process user mem space, but
  user process is not allowed to access it)
* credentials (user, group ID)
* enivroment variables (inharatable key value dictionary of strings,
  stored at the bottom of the stack)
* hardware context:
  * program counter (PC),
  * user stack pointer (SP) - address of uppermost element of the stack
  * processor status word (PSW) - bits about machine state as:
    * current and previous execution modes
    * current and previous interrupt levels
    * etc
  * memory management registers - containing address of process page table
  * floating point unit (FPU) registers

    when context switch registers are saved in part of u area called 
    process control block (PCB)



## User credentials and processes

Credentials:
* user id (UID) - user id number
* group id (GID) - group id number
* superuser - UID=0, GID=1, login=root (typically)
  * can access other users files or
  * privilaged system calls


## New processes versus programs

* each process runs single program at a time (fork) 
* multiple processes can run same program concurrently (fork) 
* process may invoke a new program (new process with program) several times (exec)
* **fork** system call creates new process
* **exec** system call invokes new program
* **exit** system call terminates process


# Signals

In Unix signals are delivered and handled by process.
From OS view communication entity is process 
(not thread, logical thread, etc.).

There is 5 default actions:
* abort - terminate and generate core dump (writing contents of
  process address space and registers context to file)
* exit - terminate process
* ignore - ignore signal
* stop - suspend process
* continue - resume process

Process can override default and specify its action.
It can do it at any time. It can block signal temporarly
(which means that signal will not be delivered).
SIGKILL and SIGSTOP cannot be blocked.
Any action can be **only** taken by process itself,
including termination.


## Signal delivery

Process will be aware of (synchronous) signal when it itself checks for
pending signals implicitly calling kernel function *issig()*
which is called:
* befor return from sys call or interrupt
* before blocking on an interruptable event
* immediately after waking up from interruptable event

If there are (synchronous) interrupts kernel calls *psig()* which:
* terminates process or
* calls *sendsig()* to invoke user defined handler
  * it returns to user mode
  * transfers control to user signal handler
  * resume user code after handler completes0


Asynchronous interrupts are supported by hardware,
and can happend and change control at any time.
If in the middle of sys call, usually sys call
is aborted and restarter by the kernel.

## Signal sending (generation)

(Synchronous) Signals can be generated by:
* exceptions
* other processes
  * terminal process forks-execs command but read characters
    if Ctrl+C it sends sigkill to foreground process (runned command)
  * terminal background processes wishing to read write to terminal
    can send job control signals to parent terminal
* io notifications
* alarms


## Signaling waiting processes

Wake sleeping process or not? This is the question. :-)
Well, no good answer. But lets do it that way:
let process declare to wake it or not.


So sleep (blocking) have 2 cathegories:
* interruptable
* uninterruptable


## Debugger as exception signal handler


Exception (like division by 0) generates traps,
that are handled by kernel. Then kernel can
invoke default action (terminate) or signal
handler (if registered). 

This handler (needed for debugging) need access
to process address space, but if it have same
stack as process, then this stack will be 
polluted by handler if handler is used for debugging.
It could be overcome if handler would use stack
of different thread, this way it would be different
stack and handler would have straight access to
process address space.

This would work as: 
* victim rises exeption, it is transported by the kernel
  to handler catch (as remote procedure call RPC)
* handler clear it (or not), it is transported by the kernel
  to victim waiting with will continue (or terminate)
  (this is also RPC)


(MACH) Kernel can support "exeption transport" by ports,
where thread can register handler, then tread is one end
of port, handler (in diffrent thread) is other. Port
keeps quequ of messages (containing message, exception type, 
PC, stack, etc.). Debugger in this configuration can
be another process (task). Child processes inheiraits
exeption ports (so it is possible to debug children processes).


## Error handling

When the victim raises an exception, the initial message sent to the (task or
thread) exception port contains the reply port, identity of the thread and task
that caused the exception, and exception type. After processing the exception,
the handler sends a reply message to the reply port. The task in which the
exception occurred owns the receive rights to this port, and the victim thread
is waiting to read the reply. When the reply arrives, the victim receives it and
resumes normal execution.

Since the handler and the victim are threads in the same task, the handler
shares the victim's address space. It can also access the victim's register
context using the *thread_get_state* and thread_set state calls.



## Debugger Interactions

A debugger controls a task by registering a port to which it has receive rights
as the task's exception port. When a thread in that task has an exception that
cannot be cleared by its error handler, the kernel sends a message to this port,
and the debugger receives this message. **The exception only stops the victim**
**thread — all other threads in the task continue to run**. 

A debugger may suspend the whole task using the *task_suspend* call if necessary.
Mach offers several facilities that the debugger can use to control the task. It
can access the victim's address space using *vmread* or *vmwrite*, or its register
context by *thread_get_state* or *thread_set_state*. It can suspend or resume the
application, or terminate it by task_terminate. 

Mach IPC is location-independent, meaning that messages can be sent to ports on
the same or remote machines. The *netmsgserver*, a special user task, extends
Mach IPC transparently over the network. It allocates "proxy" ports for all
remote ports, receives messages intended for them, and forwards these messages
across the network transparently to the sender. This allows a debugger to
control a task on any node on the network, just as it would control a local
task.


# User is process

How to identify process with human?


## Login

![Process groups and login](images/process_groups/Login%20session.png)


### Simple typical scenario

The init process forks a child for each terminal listed in the /etc/inittab
file. The child process calls setpgrp, becoming a group leader, and then execs
the getty program, which displays a login prompt and waits for input. When a
user types in his login name, getty execs the login program, which asks for and
verifies the password, and finally, execs the login shell. Hence the login shell
is a direct child of init and is also a process group leader. Usually, other
processes do not create their own groups (except for system daemons started from
a login session); hence all processes belonging to a login session will be in
the same process group.


Init process have PID = 1. Current (as of 2020) distributions use
systemd with PID = 1. It is first user process (it is the user and helper), 
father/mother of other processes/users.

Foreground process usualy have unobstructed access to the (controlling) terminal.

Abstraction:
* session object - represents login session
* job object - represents job control


Each process belongs to both:
* session and
* process group (job)

Each controlling terminal is asociated with both:
* session and
* foreground process group (so many processes can
  read write to from terminal)


Process which is not group leader (nor session leader)
can create new session, if so it becames new session leader
and group leader with its PID.

Processes can move from one group to other within session.

# Inter Process Communication IPC

There are several similarities between the IPC mechanisms and the file system:
* The resource ID is like a file descriptor. 
* The get calls resemble open, 
* IPCRMID resembles unlink, 
* and the send and receive calls resemble read and write. 
* The shmdt call provides close-like functionality for shared memory. 

For message queues and semaphores, however, there is no equivalent of the close
system call, which might be desirable for removing resources cleanly. As a
result, processes using a message queue or semaphore may suddenly find that the
resource no longer exists. 

In contrast, the keys associated with a resource form a namespace that 
is distinct from the file system name space.

Each mechanism has its own name space, and the key uniquely identifies 
a resource within it. Because the key is a simple, user-chosen integer, 
it is useful only on a single machine and is unsuitable for 
a distributed environment. Also, it is difficult for
unrelated processes to choose and agree upon an integer-valued key and avoid
conflicts with keys used by other applications.


Much of the functionality provided by System V IPC can be duplicated by other
file system facilities such as file locking or pipes. However, the IPC
facilities are much more versatile and flexible, and offer better performance
than their file system counterparts.

## IPC resources (queues, shared mem, semaphores,...)

Each resource (queue, shared memory, semaphore) have:
* key - integer identificator
* creator - user and group IDs
* owner - after creation creator is owner, process that
  have permisions to change owner may change owner.
  Those permisions have:
  * creator process
  * current owner process
  * superuser process
* permisions for owner, group and others which specify permissions to:
  * read - allowed / not allowed
  * write - allowed / not allowed
  * execute - allowed / not allowed

Process aquires permisions by making system call (shmget, semget, msgget, ...).
Call specify if create or find resouce by key, and if calling process
have proper permissions resourceID is returned, which could be used to
communicate.

Each resource have control system call that provides command for
reading status, and to deallocate resource, and possibly others.

Those resources must be explicitly dealocated, otherwise they will persist.

So for this to work each resource has resource table is system (typically fixed size).

### Pipes, synchronized, transfers streams

Parent process can create pipe resource as 2 file descriptors.
Since child processes inheiraits opened file descriptors, they
can use them for communication:
* one descriptor is read
* other descriptor is write

Read contents is removed. When file is full writer waits.
When file is empty reader waits. Data is transmitted as stream.


### Message queues FIFO, synchronized, transfers discrete elements

Can can transmit data as discrete messages (not as streams).

Messages (4 byte type + data) can be used providing:
* message queue ID - identyfying system resource
* message buffer - for type+data
* count - number of bytes buffer have (for type+data)
* flag - additional options


Messages are stored in system structure. Once message is read
it is removed from the queue.


### Shared Memory, no synchronization, transfers objects

A shared memory region is a portion of physical memory that is shared by
multiple processes. Processes may attach this region to any suitable virtual
address range in their address space. This address range may differ for each
process. Once attached, the region may be accessed like any other memory
location without requiring system calls to read or write data to it. Hence,
shared memory provides the fastest mechanism for processes to share data. If a
process writes to a shared memory location, the new contents of that location
are immediately visible to all processes sharing the region.


A process initially obtains or creates a shared memory region by calling
```
shimid = shmget (key, size, flag);
```
where size is the size of this region.


The process then attaches the region to a virtual address, using
```
addr = shmat (shmid, shmaddr, shmflag);
```
The shmaddr argument suggests an address to which the region 
may be attached. The shmflag argument can specify the SHM_RND flag, 
which asks the kernel to round shmaddr down by an 
appropriate alignment factor. If shmaddr is zero, 
the kernel is free to choose any address.


A process can detach a shared memory region from its address space by calling
```
shmdt (shmaddr);
```
To destroy the region completely, a process must use the IPC_RMID command 
of the shmctl system call. This marks the region for deletion, 
and the region will be destroyed when all processes detach it from 
their address space. The kernel maintains a count of processes attached to each 
region. Once a region has been marked for deletion, new processes 
cannot attach to it. If the region is not explicitly deleted, 
the kernel will retain it even if no process is attached to it.

### mmap, not synchronized, transfers objects

Most modern UNIX variants (including SVR4) also provide the mmap system call, 
which maps a file (or part of a file) into the address space of the caller. 
Processes can use mmap for IPC by mapping the same file into their address 
space (in the MAP_SHARED mode). The effect is similar to a shared memory region 
that is initialized to the contents of the file. If a process modifies a mapped
file, the change is immediately visible to all processes that have mapped that file; 
the kernel will also update the file on disk. One advantage of mmap is 
that it uses the file system name space instead of keys. 
Unlike shared memory, whose pages are backed by swap space,
mmap'ed pages are backed by the file to which they are mapped.


## Security of IPC

Security is a problem, because the resource IDs are actually indexes into a
global resource table. An unauthorized process can access a resource simply by
guessing the ID. It can thus read or write messages or shared memory, or tamper
with semaphores used by other processes. The per- permissions associated with
each resource offer some protection, but many applications must share the
resources with processes belonging to different users, and hence cannot use very
restrictive permis- permissions. Using the sequence number as a component of the
resource ID provides a little more protec- protection, since there are more IDs
to guess from, but still poses a serious problem for applications that are
concerned about security.

# Multiprocessors

Symmetric multiprocessing (SMP) is by far the more popular approach. In an SMP
system, all CPUs are equal, share a single copy of the kernel text and data, and
compete for system resources such as devices and memory. Each CPU may run
the kernel code, and any user process may be scheduled on any processor.


![UMA, NUMA, NORMA](images/multiproc/Multiprocessors_arch.png)

One of the basic assumptions in the traditional synchronization model is that a
thread retains exclu- exclusive use of the kernel (except for interrupts) until
it is ready to leave the kernel or block on a resource. This is no longer
valid on a multiprocessor, since each processor could be executing kernel code
at the same time. We now need to protect all kinds of data that did not need
protection on a uniprocessor.

## Hardware synchronization support

Consider the
basic operation of locking a resource for exclusive use by setting a 
locked flag maintained in a shared memory location. This may be 
accomplished by the following sequence of operations:
1. Read the flag.
2. If the flag is 0 (hence, the resource is unlocked), 
   lock the resource by setting the flag to 1.
3. Return TRUE if the lock was obtained, or else return FALSE.

On a multiprocessor, two threads on two different processors may 
simultaneously attempt to carry out this sequence of operations. 
Then both threads may think they have exclusive
access to the resource. To avoid such a disaster, the hardware has 
to provide a more powerful primitive that can combine the three 
subtasks into a single indivisible operation. Many architectures
solve this problem by providing either an atomic 
test-and-set or a conditional store instruction.

### Atomic Test-and-Set

An atomic test-and-set operation usually acts on a single bit in memory. It
tests the bit, sets it to one, and returns its old value. Thus at the completion
of the operation the value of the bit is one (locked), and the return value
indicates whether it was already set to one prior to this operation. The
operation is guaranteed to be atomic, so if two threads on two processors both
issue the same instruction on the same bit, one operation will complete before
the other starts. Further, the operation is also atomic with respect to
interrupts, so that an interrupt can occur only after the operation completes.

### Load-Linked and Store-Conditional Instructions

Some processors such as the MIPS R4000 and Digital's Alpha AXP use a pair of
special load and store instructions to provide an atomic read-modify-write
operation. The load-linked instruction (also called the load-locked instruction)
loads a value from memory into a register and sets a flag that causes the
hardware to monitor the location. If any processor writes to such a monitored
loca- location, the hardware will clear the flag. The store-conditional
instruction stores a new value into the location provided the flag is still set.
In addition, it sets the value of another register to indicate if the store
occurred.

### swap-atomic instruction


## Software synchronization

The sleep/wakeup mechanism does not function correctly on a multiprocessor.
Example (lost wakeup):
* first thread lock resources
* second thread find it locked
* first thead relise locked resource while second thread goes to sleep
* second thread will be not waken up because there would be no event
  telling that resource have been relised, problem!


Other means must be used.

### Semaphores

Semaphores may be used for resources locking and synchronization.
Altrough they will require atomic test-and-set instruction for
synchronization of semaphore internals. Also semaphores would need
few context switches, they are slow.

The semaphore semantics force allocation in a first-come, first-served.
It can mess resources locking when scheduling is involved.
It can be overcome but better use specialized locking mechanizms.

## Primitive synchronization

### Spin Locks (simple lock or a simple mutex)

The simplest locking primitive is a spin lock, also called a simple lock or a
simple mutex. If a resource is protected by a spin lock,a thread trying to
acquire the resource will busy-wait (loop, or spin) until the resource is
unlocked. It is usually a scalar variable that is zero if available and one if
locked. The variable is manipulated using a busy-wait loop around an atomic
test-and-set or similar instruction available on the machine.


The most important characteristic of spin locks is that a thread ties up a CPU
while waiting for the lock to be released. It is essential, then, to hold spin
locks only for extremely short durations. In particular, they must not be held
across blocking operations. It may also be desirable to block inter- interrupts
on the current processor prior to acquiring a spin lock, so as to guarantee low
holding time on the lock.

**On a uniprocessor, if a thread tries to acquire a spin lock** 
**that is already held, it will loop forever.**

The major advantage of spin locks is that they are inexpensive.


They are ideal for locking data structures that need to be accessed briefly,
such as while removing an item from a doubly linked list or while performing a
load-modtfy-store type of operation on a variable. Hence they are used to
protect those data structures that do not need protection in a uniprocessor
system. They are also used extensively to protect more complex locks.
Semaphores, for instance, use a spin lock to guarantee atomicity of their
operations.

### Condition Variables

A condition variable is a more complex mechanism associated with a predicate (a
logical expres- expression that evaluates to TRUE or FALSE) based on some shared
data. It allows threads to block on it and provides facilities to wakeup one or
all blocked threads when the result of the predicate changes. It is more useful
for waiting on events than for resource locking.

Implementation:

```{c} 
struct condition {
  proc *next; /* doubly linked list */
  proc *prev; /* of blocked threads*/
  spinlock_t listLock; /*protects this list */
};

void wait (condition *c, spinlock_t *s)
{
  spinlock (&c->listLock);
  add self to the linked list;
  spin_unlock (&c->listLock);
  spin_unlock (s); /* release spinlock before blocking */
  swtch(); /* perform context switch */
  /* When we return from swtch, the event has occurred */
  spin_lock (s); /* acquire the spin lock again */
  return;
}

void do_signal (condition *c)
/* Wake up one thread waiting on this condition */
{
  spinlock (&c->listl_ock);
  remove one thread from linked list, if it is nonempty;
  spinunlock (&c->listLock);
  if a thread was removed from the list, make it runnable;
  return;
}

void dobroadcast (condition *c)
/* Wake up all threads waiting on this condition */
{
  spinlock (&c->l i stLock);
  while (linked list is nonempty) {
    remove a thread from linked list;
    make it runnable;
  }
  spin_unlock (&c->listLock);
}
```

The predicate itself is not part of the condition variable. It must be tested by
the calling routine before calling wait(). Further, note that the implementation
uses two separate mutexes. One is listLock, which protects the doubly linked
list of threads blocked on the condition. The second mutex protects the tested
data itself. It is not a part of the condition variable, but is passed as an
argument to the wait () function. The swtch () function and the code to make
blocked threads runnable may use a third mutex to protect the scheduler queues.

We thus have a situation where a thread tries to acquire one spin lock while
holding another. This is not disastrous since the restriction on spin locks is
only that threads are not allowed to block while holding one. Deadlocks are
avoided by maintaining a strict locking order—the lock on the predicate must be
acquired before listLock.

One of the major advantages of a condition variable is that it provides two ways
to handle event completion. When an event occurs, there is the option of waking
up just one thread with dosignal () or all threads with do_broadcast(). Each may
be appropriate in different circumstances.


# Filesystem


## Files

A file is logically a container for data.
Users may create a file and store data by writing it to the file.
A file permits both sequential and random access to its data.

The commonly supported attributes of a file include the following:
* File type — Besides regular files, UNIX recognizes several special 
  types of files including directories, FIFOs (first-in, first-out files), 
  symbolic links, and special files that represent block or character devices.
* Number of hard links to the file.
* File size in bytes.
* Device ID — Identifies the device on which the file is located.
* Inode number — There is a single inode associated with each file 
  or directory regardless of how many links it has. Each inode on a 
  given disk partition has a unique inode number. Hence a file is 
  uniquely identified by specifying its device ID and inode number. 
  These identifiers are not stored in the inode itself. The device
  ID is a property of the file system—all files of a single file 
  system have the same device ID. Directory entries store the inode 
  number along with the filename.
* User and group IDs of the owner of the file.
* Timestamps — There are three timestamps for each file: 
  * the time the file was last accessed, 
  * the time it was last modified, 
  * and the time its attributes (excluding the other timestamps) 
    were last changed.
* Permissions. There are three 
  types of permissions associated with each file:
  * read, 
  * write, 
  * and execute. 
  
  The users trying to access a file are also divided into three categories:
  * the owner of the file,
  * people in the same group as the owner, 
  * and everybody else (that is, owner, group, and others).
* Mode flags:
  * suid - When a user executes the file, if the suid flag is set, 
    the kernel sets the user's effective UID to that of the owner of the file
  * sgid - sgid flag affects the effective GID in the same way. 
  * and sticky. sticky flag also is used for executable files and 
    requests the kernel to retain the program image in the swap area 
    after execution terminates. System administrators often 
    set the sticky flag for frequently executed files in order to improve 
    performance.

When a file is created, it inherits the effective UID of the creating process.
Its owner GID may take one of two values. In SVR3, the file inherits the
effective GID of the creator. In 4.3BSD, it inherits the GID of the directory in
which it is created. S VR4 uses the sgid flag of the parent direc- directory to
select the behavior.

The link and unlink calls create and delete hard links respectively. The kernel
deletes the file only after all its hard links have been removed, and no one is
actively using the file. The utimes system call changes the access and modify
timestamps of the file. The chown call changes the owner UID and GID. The chmod
system call changes the permissions and mode flags of the file.


## Directories



## File descriptors

* When the user calls open, the kernel creates an open file object to represent
  the open in- instance of the file. It also allocates a file descriptor, which
  acts as a handle, or reference, to the open file object. The open system call
  returns the file descriptor (fd) to the caller. A user may open the same file
  several times; also, multiple users may open the same file. In each case, the
  kernel gener- generates a new open file object and a new file descriptor.
* The file descriptor is a per-process object. The same descriptor number in two
  different processes may, and usually does, refer to different files. The process
  passes the file descriptor to I/O-related system calls such as read and write.
  The kernel uses the descriptor to quickly locate the open file object and other
  data structures associated with the open file. This way, the kernel can per-
  perform tasks such as pathname parsing and access control once during the open,
  rather than on each I/O operation. Open files may be closed by the close system
  call and also are closed automatically when the process terminates.
* Each file descriptor represents an independent session with the file. The
  associated open file object holds the context for that session. This includes
  the mode in which the file was opened and the offset pointer at which the next
  read or write must start. In UNIX, files are accessed sequentially by default.
  When the user opens the file, the kernel initializes the offset pointer to zero.
  Subse- Subsequently, each read or write advances the pointer by the amount of
  data transferred.
* process may duplicate a descriptor through the dup or dup2 system calls. 
  These calls create a new descriptor that references the same open 
  file object and hence shares the same session.
* Similarly, the fork system call duplicates all the descriptors in the 
  parent and passes them on to the child. This form of sharing is 
  fundamentally different from having multiple open instances. Since
  the two descriptors share the same session to the file, they both see 
  the same view of the file and use the same offset pointer.
* A process may pass a file descriptor to another unrelated process. 
  This has the effect of passing a reference to the open file object. 
  The kernel copies the descriptor into the first free slot in 
  the receiver's descriptor table. The two descriptors share the 
  same open file object and hence the same offset pointer. 
  Usually, the sending process closes its descriptor after 
  sending it. This does not close the open file, even if the 
  other process has not yet received the descriptor, since the kernel 
  holds on to the second descriptor while it is in transit.


## Scatter-Gather I/O

To atomically read (or write) data from a file into a number 
of noncontiguous buffers in their address space, UNIX provides
readv and writev system calls that perform scatter-gather I/O, 
moving data from the file into multiple buffers in user space.

```
nbytes = writev (fd, iov, iovcnt);
```

f d is the file descriptor, i ov is a pointer 
to an array of (base, length) pairs (struct iovec)
that describe the set of source buffers, and iovcnt 
is the number of elements in the array.


![Scatter-gather I/O](images/filesystem/Filesystem_Scatter-gather_IO.png)


## File Locking

By default, UNIX allows multiple processes to concurrently access the file for
reading or writing. Each read or write call is atomic, but there is no
synchronization across system call boundaries. As a result, if a process reads a
file through multiple read calls, another process may change the file between
two reads.

Advisory locks are not enforced by the kernel and only protect the file from
cooperating processes that explicitly check for the lock. Mandatory locks are
enforced by the kernel, which will reject op- operations conflicting with the
lock. Locking requests may be blocking or nonblocking.


# Filesystems


Although the UNIX file hierarchy appears monolithic, it is actually composed of
one or more inde- independent subtrees, each of which contains a complete,
self-contained file system. One file system is configured to be the root file
system, and its root directory becomes the system root directory. The other file
systems are attached to the existing structure by mounting each new file system
onto a di- directory in the existing tree. Once mounted, the root directory of
the mounted file system covers or hides the directory on which it is mounted,
and any access to the "mounted-on " directory is lated to an access to the root
directory of the mounted file system. The mounted file system remains visible
until it is unmounted.


![Multiple filesystems](images/filesystem/Filesystem_multiple_fs.png)

Example:

fs0 is installed as the root file system of the machine, 
and the file system fs1 is mounted on the /usr directory of fs0
/usr is called the "mounted-on" directory or the mount point, 
and any attempts to access /usr results in accessing the 
root directory of the file system mounted on it.

If the /usr directory of fsO contains any files, they are hidden, or covered,
when fsl is mounted on it, and may no longer accessed by users. When fsl is
unmounted, these files become visible and are accessible once again. Pathname
parsing routines in the kernel must understand mount points and behave correctly
when traversing mount points in either direction.

To track mounted file systems kernel must use:
* mount table or
* (virtual file system list or
* etc.

The notion of mountable subsystems serves to hide the details of the storage
organization from the user.

## Logical disks

A logical disk is a storage abstraction that the kernel sees as a linear
sequence of fixed sized, ran- randomly accessible, blocks. The disk device
driver (see Section 16.6) maps these blocks to the under- underlying physical
storage. The newfs or mkfs utilities create a UNIX file system on the disk. Each
filesystem is fully contained in a single logical disk, and one logical disk may
contain only one file system.

In the simplest case, each logical disk is mapped to a single, entire,
physical disk. The most common feature is to divide a disk into a number of
physically contiguous partitions, each a logical device.

Modern UNIX systems support many other useful storage configurations. Several
disks may be combined into a single logical disk or volume, thus supporting
files larger than the size of a single disk. Disk mirroring allows a
redundant copy of all data, increasing the reliability of the file system.
Stripe sets provide increased throughput from a file system by striping the data
across a set of disks. Several types of RAID (Redundant Arrays of Inexpensive
Disks) configurations provide a mix of reliability and performance enhancements
to suit the requirements of different types of installations.



A partition can be logically viewed as a linear array of blocks. The size of a
disk block is 512 bytes multiplied by some power of two (different releases have
used block sizes of 512, 1024, or 2048 bytes). It represents the granularity of
space allocation for a file, and that of an I/O operation. The physical block
number (or simply, the block number) is an index into this array, and uniquely
identifies a block on a given disk partition. This number must be translated by
the disk driver into cylinder, track, and sector numbers. The translation
depends on the physical characteristics of the disk (number of cylinders and
tracks, sec- sectors per track, etc.) and the location of the partition on the
disk.

At the beginning of the partition is the boot area, which may contain code
required to bootstrap (load and initialize) the operating system. Although
only one partition needs to contain this information, each partition contains a
possibly empty boot area. The boot area is followed by the superblock, which
contains attributes and metadata of the file system itself.


Following the superblock is the inode list, which is a linear array of inodes.
There is one inode for each file. Inodes are described in Section 9.2.2. Each
inode can be identified by its inode number, which equals its index in the inode
list. The size of an inode is 64 bytes. Several inodes fit into a single disk
block. The starting offsets of the superblock and the inode list are the same
for all partitions on a system. Consequently, an inode number can be easily
translated to a block number and the offset of the inode from the start of that
block. The inode list has a fixed size (configured while creating the file
system on that partition), which limits the maximum number of files the par-
partition can contain. The space after the inode list is the data area. It holds
data blocks for files and directories, as well as indirect blocks, which hold
pointers to file data blocks and are described in Section 9.2.2.


![Disk memory map](images/devices/disk/IO_disk_logical_memory_layout.png)

An s5fs directory is a special file containing a list of files and
subdirectories. It contains fixed-size records of 16 bytes each. The first two
bytes contain the inode number, and the next fourteen the file name. This places
a limit of 65535 files per disk partition (since 0 is not a valid inode number)
and 14 characters per file name. If the filename has fewer than fourteen
characters, it is terminated by a NULL character. Because the directory is a
file, it also has an inode, which contains a field identify- identifying the
file as a directory. The first two entries in the directory are ".", which
represents the direc- directory itself, and "..", which denotes the parent
directory. If the inode number of an entry is zero, it indicates that the
corresponding file no longer exists. The root directory of a partition, as well
as its ".." entry, always has an inode number of 2. This is how the file system
can identify its root direc- directory.


![Disk table](images/devices/disk/IO_disk_inode_block_array.png)


The superblock contains metadata about the file system itself. 
There is one superblock for each file system, and it resides 
at the beginning of the file system on disk. The kernel reads 
the superblock when mounting the file system and stores it in 
memory until the file system is unmounted. The superblock contains 
the following information:

* Size in blocks of the file system.
* Size in blocks of the inode list.
* Number of free blocks and inodes.
* Free block list.
* Free inode list.


## Special Files


One of the distinctive features of the UNIX file system is the generalization of
the file abstraction to include all kinds of I/O-related objects, such as
directories, symbolic links, hardware devices like disks, terminals and
printers, pseudodevices such as the system memory, and communication 
abstractions such as pipes and sockets. 


(Special) files can be accessed and operates in two logical ways:
* through file descriptors, and the same set of system calls 
  that operate on ordinary files
* When file dont represent byte-stream model, because require much richer 
  data abstractions such as record-based or indexed-sequential access. 
  Such applications find the UNIX model inadequate and end up layering 
  their own access methods on top of it. Some I/O objects do not support 
  all file operations. Terminals and printers, for instance, have no notion 
  of random access or seeks.


Suppose a user issues a read system call to a character device file. In a
traditional UNIX system, the kernel will:
1. Use the file descriptor to get to the open file object.
2. Check the entry to see if the file is open for read.
3. Get the pointer to the in-core inode from this entry. 
   In-core inodes (also called in-memory modes) are file system 
   data structures that keep attributes of active files in memory. 
4. Lock the inode so as to serialize access to the file.
5. Check the inode mode field and find that the file is a character device file.
6. Use the major device number (stored in the inode) to index into 
   a table of character devices and obtain the cdevsw entry 
   for this device. This entry is an array of pointers to
   functions that implement specific operations for this device.
7. From the cdevsw, obtain the pointer to the dread routine for this device.
8. Invoke the d_read operation to perform the device-specific 
   processing of the read request. 
9. Unlock the inode and return to the user.



Read code looks like the following:

```
struct cdevsw {
  int (*d_open)();
  int (*d_close)();
  int (*d_read)();
  int (*d_write)();
  ...
} cdevsw[];

result = (*(cdevsw[major].d_read))(...);
```

where major is the major device number of that device.

## Coexistens of filesystems

Database applications, for example, need better support for transaction
processing. Applications that use large, read-mostly or read-only files would
prefer extent-based allocation, which improves the performance of sequential
reads.


## The Vnode/Vfs Architecture

The vnode/vfs architecture has several important objectives:
* The system should support several file system types simultaneously. 
  These include UNIX (s5fs or ufs) and non-UNIX (DOS, A/UX, etc.) 
  file systems.
* Different disk partitions may contain different types of file systems. 
  Once they are mounted on each other, however, they must present 
  the traditional picture of a single homogenous file system. 
  The user is presented with a consistent view of the entire 
  file tree and need not be aware of the differences in the 
  on-disk representations of the subtrees.
* There should be complete support for sharing files over a network. 
  A file system on a remote machine should be accessible just like 
  a local file system.
* Vendors should be able to create their own file system types and 
  add them to the kernel in a modular manner.


The main goal was to provide a framework in the kernel for file access and
manipulation, and a well-defined interface between the kernel and the modules
that implemented specific filesystems.

## Vnode/Vfs Interface

The vnode (virtual node) abstraction represents a file in the UNIX kernel; the
vfs (virtual file sys- system) represents a file system. Both can be regarded as
abstract base classes, from which we can de- derive subclasses that provide
specific implementations for different file system types such as s5fs, ufs, NFS,
and FAT (the MS-DOS file system).


### Virtual node (Vnode)

Virtual node (Vnode) is abstract file operations.


```
struct vnode {
  u_short v_flag;             /* V_ROOT, etc. */
  u_short v_count;            /* reference count */
  struct vfs *vfsmountedhere; /* for mount points */
  struct vnodeops *v_op;      /* vnode operations vector */
  struct vfs *vfsp;           /* file system to which it belongs */
  struct stdata *v_stream;    /* pointer to associated stream, if any */
  struct page *v_page;        /* resident page list */
  enum vtype vtype;           /* file type */
  dev_t v_rdev;               /* device ID for device files */
  caddr_t v_data;             /* pointer to private data structure */
  ...
};

struct vnodeops {
  int (*vop_open)();
  int (*vop_dose)();
  int (*vop_read)();
  int (*vop_write)();
  int (*vop_ioctl)();
  int (*vop_getattr)();
  int (*vop_setattr)();
  int (*vop_access)();
  int (*vop_lookup)();
  int (*vop_create)();
  int (*vop_remove)();
  int (*vop_link)();
  int (*vop_rename)();
  int (*vop_mkdir)();
  int (*vop_rmdir)();
  int (*vop_readdir)();
  int (*vop_symlink)();
  int (*vop_read1ink)();
  void (*vop_inactive)();
  void (*vop_rwlock)();
  void (*vop_rwun1ock)();
  int (*vop_realvp)();
  int (*vop_getpage)();
  int (*vop_putpage)();
  int (*vop_map)();
  int (*vop_pol1)();
  ...
}
```

### Dynamic allocation release

The v_count field of the vnode maintains a reference count that determines how
long the vnode must remain in the kernel. A vnode is allocated and assigned to a
file when the file is first accessed. Thereafter, other objects may maintain
pointers, or references, to this vnode and expect to access the vnode using that
pointer. This means that as long as such references exist, the kernel must
retain the vnode and not reassign it to another file. This reference count is
one of the generic properties of the vnode and is manipulated by the
file-system-independent code. Two macros, VN_HOLD and VN_RELE, increment and
decrement the reference count, respectively. When the reference count reaches
zero, the file is inactive and the vnode may be released or reassigned.


### Virtual filesystem (Vfs)

Vfs - virtual file system is abstraction of
mounting and unmounting names organized
it tree hierarchy. What those names meen
is different case.

```
struct vfsops {
  int (*vfs_mount)();
  int (*vfs_unmount)();
  int (*vfs_root)();
  int (*vfs_statvfs)();
  int (*vfs_sync)();
}
```

### Filesystems Operations System Lookup Table

Kernel has map, mapping filesystem type name to 
type dependent operations:

```
struct vfssw {
  char *vsw_name;             /* file system type name */
  int (*vsw_init)();          /* address of initialization routine*/
  struct vfsops *vsw_vfsops;  /* yfs operations vector for this fs */
} vfssw[];
```


## Mounting

Mounting filesystem is done by system call:

```
mount (spec, dir, flags, type, dataptr, datalen)
```

The mount system call obtains the vnode of the mount point directory by calling
lookuppn(). It checks that the vnode represents a directory and that no other
file system is mounted on it. (Note that lookuppn() acquires a hold on this
directory, which remains until the file system is un- unmounted.) It then
searches the vfssw[] table to find the entry matching the type name. Having
located the switch entry, the kernel invokes its vswi ni t operation. This calls
a file- system-specific initialization routine that allocates data structures
and resources needed to operate the file system. The kernel then allocates a new
vfs structure and initializes it as follows:

1. Adds the structure to the linked list headed by rootvfs.
2. Sets the vf s_op field to point to the vfsops vector specified 
   in the switch entry.
3. Sets the vf s_vnodecovered field to point to the vnode of the 
   mount point directory.



# The Memory File System

The entire file system is built in the virtual address space of the process that
handled the mount operation. This process does not return from the mount call,
but remains in the kernel, wait- waiting for I/O requests to the file system.
Each mf snode, which is the file-system-dependent part of the vnode, contains
the PID of the mount process, which now functions as an I/O server. To perform
I/O, the calling process places a request on a queue that is maintained in the
mfsdata structure, wakes up the mount process, and sleeps while the request is
serviced. The mount process satisfies the request by copying the data from or to
the appropriate portion of its ad- address space, and awakens the caller. Since
the file system is in the virtual memory of the mount process, it can be paged
out like any other data, by the standard memory management mechanisms. The pages
of the mfs files com- compete with all the other processes for physical memory.
Pages that are not actively referenced are written to the swap area, and must be
faulted in if needed later. This allows the system to support a temporary file
system that may be much larger than the physical memory. Although this file
system is substantially faster than an on-disk system, it has several draw-
drawbacks, largely due to the limitations of the BSD memory architecture. Using
a separate process to handle all I/O requires two context switches for each
operation. The file system still resides in a separate (albeit virtual) address
space, which means we still need extra in-memory copy operations.



# The tmpfs File System


tmpfs is implemented entirely in the kernel, without requiring a separate server
process. All file metadata is stored in non-paged memory, dynamically allocated
from the kernel heap. The data blocks are in paged memory and are represented
using the anonymous page facility in the VM sub- subsystem. Each such page is
mapped by an anonymous object (struct anon), which contains the lo- location of
the page in physical memory or on the swap device. The tmpnode, which is the
file- system-dependent object for each file, has a pointer to the anonymous map
(struct anonjnap) for the file. This map is an array of pointers to the
anonymous object for each page of the file. The link- linkages are shown in
Figure 9-9. Because the pages themselves are in paged memory, they can be
swapped out by the paging subsystem and compete for physical memory with other
processes, just as in mfs.

These anonymous objects and maps are also used by the VM subsystem to describe
pages of a process's address space. This allows a process to directly map a
tmpfs file into its address space, using the mmap system call interface. Such a
mapping is implemented by sharing the anonjnap of the file with that process.
The process can thus directly access the pages of that file without copying them
into its address space.

The tmpfs implementation addresses several shortcomings of the mfs approach. It
does not use a separate I/O server and thus avoids wasteful context switches.
Holding the meta-data in un- unpaged kernel memory eliminates the
memory-to-memory copies and some disk I/O. The support for memory mapping allows
fast, direct access to file data.

![Tmp filesystem](images/filesystem/Filesystem_tmpfilesystem.png)


# /proc filesystem


Lets find commands working with PID within man pages:
```
apropos pid
```

Lets find firefox:
```
pidof firefox
```

Lets pickup its stack using filesystem:
```
sudo cat /proc/3302/stack
```

Lets print some info:
```
ps -q 3302 -eo pid,tid,class
```

Each process is represented by a directory under
/proc, and the directory name is the decimal representation 
of the process ID. Each directory contains the following 
files and subdirectories:

* **status** - This read-only file contains information about the process state. 
  Its format is defined by struct pstatus, which includes 
  * the process ID, 
  * process group and session IDs, 
  * sizes and locations of the stack and heap, 
  * and other information.
* **psinfo** - This read-only file contains information needed 
  by the ps(l) command. Its format is defined by struct psinfo, 
  which includes some of the fields of:
  * the status file, and other information such as the 
  * image size 
  * and the device ID of the controlling terminal.
* **ctl** - This write-only file allows users to perform control 
  operations on the target process by writing formatted 
  messages to this file. 
* **map** - This read-only file describes the virtual address 
  map of the process. It contains an array of prmap structures, 
  each element of which describes a single contiguous address 
  range in the process. 
* **as** - This read-write file maps the virtual address space of the process. 
  * Any address in the process may be accessed by 
    lseekmg to that offset in this file,
  * and then performing a read or write.
* **sigact** - This read-only file contains signal handling information. 
  The file contains an array of sigaction structures (see Section 4.5), 
  one for each signal.
* **cred** - This read-only file contains the user credentials of the process. 
  Its format is defined by struct prcred.
* **object** - This directory contains one file for each object 
  mapped into the address space of the process (see Section 14.2). 
  A user can get a file descriptor for
  the object by opening the corresponding file.
* **lwp** This directory contains one subdirectory for each LWP 
  (see Chapter 3) of the process. Each subdirectory contains 
  three files similar to the status, psinfo, and ctl: 
  * lwpstatus, 
  * lwpsinfo,
  * and lwpctl - which provide per-LWP status and control operations.


It is important to note that these are not physical files with real storage.
They merely provide an interface to the process. Operations on these files are
translated by the /proc file system to appropriate actions on the target
process or its address space. Several users may open a /proc file concurrently.

There is no explicit support for breakpoints. They may be implemented simply by
using the write system call to deposit a breakpoint instruction at any point in
the text segment. Most systems designate an approved breakpoint instruction.
Alternatively, we could use any illegal instruction that causes a trap to the
kernel. The /proc interface provides mechanisms to handle children of a target
process. The debug- debugger can set an inherit-on-fork flag in the target
process and monitor exits from fork and vfork calls. This causes both parent and
child to stop on return from fork. When the parent stops, the debugger can
examine the return value from fork to determine the child PID and open the /proc
files of the child. Since the child stops before it returns from fork, the
debugger has complete control over it from that point.



# Kernel memory allocation

When the system boots, the kernel reserves part of physical memory for its own
text and static data structures. This portion is never released and hence is
unavailable for any other purpose. The rest of the memory is managed
dynamically—the kernel allocates portions of it to various clients (processes
and kernel subsystems), which release it when it is no longer needed.

UNIX divides memory into fixed-size frames or pages. The page size is a power of
two, with 4 kilobytes being a fairly typical value.2 Because UNIX is a virtual
memory system, pages that are logically contiguous in a process address space
need not be physically adjacent in memory.

This simplifies the task of page allocation. The kernel maintains a linked list
of free pages. When a process needs some pages, the kernel removes them from the
free list; when the pages are released, the kernel returns them to the free
list.

The get_page () and freepage () routines (SVR4) implement 
page-level allocator. Page allocator have 2 clients:
* user processes virtual memory system:
  * allocates pages to user processes to hold portions of their address space,
* kernel for various tasks, e. g.:
  * pathname translation routine
  * The alllocb () routine allocates STREAMS buffers of arbitrary size.
  * zombi e structures to retain exit status and resource usage
  * possibliy: proc structure, vnodes, file descriptors blocks, etc. ...

![Page allocator](images/memory/virtmem_page_allocator.png)



## Kernel memory allocator (KMA)


When the system boots, the kernel first reserves space for its own text and
static data struc- structures, as well as some pre-defined pools such as the
block buffer cache. The page-level allocator manages the remaining physical
memory, which is contended for both by the kernel's own dynamic allocation
requests and by user processes.

The page-level allocator pre-allocates part of this space to the KMA, which must
use this memory pool efficiently. Some implementations allow no change in the
total memory given to the KMA. Others allow the KMA to steal more memory from
the paging system. Some even permit a two-way exchange, so the paging system can
steal back excess free memory held by the KMA.

If the KMA runs out of memory, it blocks the caller until more memory is free.
The caller may send a flag in the request, asking the KMA to return a failure
status (usually a NULL pointer) instead of blocking. This option is most used by
interrupt handlers, which must take some corrective action if the request fails.
For example, if a network interrupt cannot allocate memory to hold an incoming
packet, it may simply drop the packet, hoping the sender will retransmit it
later. The KMA must monitor which parts of its pool are allocated and which are
free. Once a piece of memory is freed, it should be available to other requests.


## Resource map allocator

The resource map is a set of (base, size) pairs that monitor areas of free
memory (see Figure 12-2). Initially, the pool is described by a single map
entry, whose base equals the starting address of the pool and size equals the
total memory in the pool (Figure 12-2(a)). As clients allocate and free chunks
of memory, the pool becomes fragmented, and the kernel creates one map entry for
each contiguous free region. The entries are sorted in order of increasing base
address, making it easy to coalesce adjacent free regions.

The kernel can satisfy new allocation requests using:
* **First fit** allocates memory from the first free region that 
  has enough space. This is the fastest algorithm, but may not be 
  optimal for reducing fragmentation.
* **Best fit** allocates memory from the smallest region that is 
  large enough to satisfy the request. This has the drawback that 
  it might leave several free regions that are too small to be useful.
* **Worst fit** Allocates memory from the largest available region, 
  unless a perfect fit is found. This may seem counter-intuitive, 
  but its usefulness is based on the expectation that
  the region left behind after the allocation will be large 
  enough to be used for a future request.

## Simple Power-of-Two Free Lists

Thepower-of-two free lists method is used frequently to implement malloc() and
free() in the user-level C library. This approach uses a set of free lists. Each
list stores buffers of a particular size, and all the sizes are powers of two.
For example, in Figure 12-3, there are six free lists, storing buffers of sizes
32, 64, 128, 256, 512, and 1024 bytes.

Each buffer has a one-word header, which reduces its usable area by this amount.
When the buffer is free, its header stores a pointer to the next free buffer.
When the buffer is allocated, its header points to the free list to which it
should be returned. In some implementations, it contains the size of the
allocated area instead. This helps detect certain bugs, but requires the free()
routine to compute the free list location from the size.

To allocate memory, the client calls malloc(), passing the required size as an
argument. The allocator computes the size of the smallest buffer that is large
enough to satisfy the request. This involves adding space for the header to the
requested size and rounding the resulting value to the next power of two. The
32-byte buffers satisfy requests for 0-28 bytes, the 64-byte buffers sat-
satisfy requests for 29-60 bytes, and so on. The allocator then removes a buffer
from the appropriate free list and writes a pointer to the free list in the
header. It returns to the caller a pointer to the byte immediately following the
header in the buffer.


When the client releases the buffer, it calls the free() routine, passing the
pointer returned by mal 1 oc () as an argument. The user does not have to
specify the size of the buffer being freed. It is essential, however, to free
the entire buffer obtained from mal loc(); there is no provision for freeing
only part of the allocated buffer. The free() routine moves the pointer back
four bytes to access the header. It obtains the free list pointer from the
header and puts the buffer on that list. The allocator can be initialized either
by preallocating a number of buffers to each list or by leaving the lists empty
at first and calling the page-level allocator to populate them as required.


![Power of 2 free lists](images/memory/virtmem_free_lists.png)

Subsequently, if a list becomes empty, the allocator may handle 
a new malloc() request for that size in one of three ways: 
* Block the request until a buffer of the appropriate size is released. 
* Satisfy the request with a larger buffer, 
  beginning with the next list and continuing the 
  search until it finds a nonempty list. 
* Obtain additional memory from the page-level allocator 
  to create more buffers of that size. 

Each method has its benefits and drawbacks,
and the proper choice depends on the situation. For example, a kernel
implementation of this algorithm may use an additional priority argument for al-
allocation requests. In this case, the allocator may block low-priority requests
that cannot be satisfied from the correct free list, but complete high-priority
requests by one of the other two methods.


## Summary

The Dynix and slab allocators offer significant improvements over these methods.
Dynix uses a power-of-two method, but adds per-processor caches and fast garbage
collection (the coa- lesce-to-page layer). The slab allocator is a modified zone
algorithm. It improves performance through object reuse and balanced address
distribution. It also uses a simple garbage collection al- algorithm that bounds
the worst-case performance. As was previously noted, adding per-CPU caches to
the slab algorithm would provide an excellent allocator.

# Virtual memory (on demand)

## Requirements

Virtual memory requires:
* Address space management — The kernel: 
  * allocates the address space to the process during fork 
  * and releases it when the process exits.
  * If the process makes an exec system call, the kernel releases 
    the old address space and allocates a new one that 
    corresponds to the new program. 
  * Also changing the size of the data region or the stack, 
  * and adding a new region (such as shared memory).
* Address translation — 
  * For each instruction that accesses memory, the MMU needs to
    translate virtual addresses generated by the process to 
    physical addresses in main memory.
  * In a demand-paged system, a page is the unit of memory allocation, 
    protection, and address translation. 
  * The virtual address is converted into a virtual page number 
    and an offset within that page. 
  * The virtual page number is converted to a physical page number 
    using some kind of address translation maps. 
  * If an instruction accesses a page that is not in
    physical memory (not resident), it will cause a page fault exception. 
    The fault handler in the kernel must resolve the fault by bringing 
    the page into memory.
* Physical memory management — Physical memory is the most important 
  resource controlled by the memory management subsystem. 
  * Both the kernel and the user processes contend for memory, 
  * and these requests must be satisfied quickly. 
  * The total size of all active processes is usually much larger than that of
    physical memory, which can hold only a limited subset of this data. 
  * Hence the system uses physical memory as a cache of useful data. 
  * The kernel must optimize the utilization of this cache and ensure 
    consistency and currency of the data.
* Memory protection — Processes must not access or modify pages in 
  an unauthorized manner. 
  * The kernel must protect its own code and data against modification by
    user processes. 
  * For security reasons, the kernel must also prevent processes from reading 
    its code or data.  
  * Processes should not be able to access pages belonging to other processes. 
  * A part of the process's address space may even be protected from 
    the process itself. For example, the text region of a process is 
    usually write-protected, so that the process cannot accidentally
    corrupt it. 
  * The kernel implements the system's memory protection policies using
    the available hardware mechanisms. 
  * If the kernel detects an attempt to access an illegal location, 
    it notifies the offending process by sending it a segmentation 
    violation (SIGSEGV) signal.
* Memory sharing — 
  * For instance, all processes running the same program can 
    share a single copy of the text region of the program. 
  * Processes may explicitly ask to share a region
    of memory with other cooperating processes. 
  * The text regions of standard libraries may be shared in the 
    same manner. 
  * After a. fork, the parent and child may share a single copy
    of data and stack pages as long as neither tries to modify them.
* Other facilities — Some of the other functions provided by the 
  memory management system include support for: 
  * memory-mapped files, 
  * dynamically linked shared libraries, and 
  * execution of programs residing on remote nodes.

## The Virtual Address Space

The address space of a process comprises all (virtual) memory 
locations that the program may reference or access. 
At any instant, the address space, along with the process's register 
context, reflects the current state of the program. 
When the process invokes a new program via exec, the kernel
builds an address space that corresponds to the new image.



## Page swapping

The total size of all active programs is often much greater 
than the physical memory, which consequently holds only some 
of the pages of each process. If a process needs a page that 
is not resident, the kernel makes room for it by appropriating 
another page and discarding its old contents.
UNIX uses a swap area, comprising one or more disk partitions, 
to hold such temporary pages. **When the system is initially configured,** 
**certain disk partitions are left unformatted and are reserved**
**for swapping**. They may not be used by the file system.


If a page that has been saved on swap is accessed again, the kernel handles the
page fault by reading it in from the swap area. To do so, it must maintain some
type of swap map that describes the location of all outswapped pages. If this
page must be removed from memory again, it must be saved only if its contents
are different from the saved copy. This happens if the page is dirty, that is,
if it was modified since it was last read in from the swap area. The kernel thus
needs some way to recognize if a page is dirty. This can be easy for some
systems where the page table entries have a hardware-supported dirty bit.
Without such hardware support, the kernel must obtain this information in other
ways.

Text pages do not need to be saved in the swap area, since 
they can be recovered from the executable file itself. 
Some implementations swap out text pages as well, 
for performance reasons.

**Swap maps** are usually very efficient, and the kernel can look up the swap
location of a page simply by indexing into an in-memory table. To locate the
page in the executable file, the kernel must go through the file system, which
involves examining the inode and perhaps some indirect blocks



## Translation Maps

The paging system may use **four different types of translation maps** 
to implement virtual memory. The hardware address translation maps 
are the only data structures known to the MMU hardware. 
The other maps dare known only to the operating system.

To manage translations there is:
* **Hardware address translations** system - 
  * For each instruction that accesses 
    memory, the hardware has to translate the virtual address in the program 
    to a location in physical memory. 
  * Each machine provides some hardware address translation mechanism, typically:  
    * translation lookaside buffers (TLBs) 
    * and page tables. 
    * Hardware dictates the form of these data structures, but the
    * **operating system is responsible for their setup and maintenance**.
* **Address space map** system - 
  * When the hardware is unable to translate an address, it generates a page
    fault. This might happen because the page is not in physical memory or because the hardware does not have a valid translation for it. 
  * The fault handler in the kernel must resolve the fault by bringing
    the page into memory if necessary and loading 
    a valid hardware translation entry.
* **Physical memory map** system — Frequently, the kernel also needs to 
  perform the reverse   mapping and determine the owning process 
  and the virtual page number for a given physical page. For instance,
  when the kernel removes an active page from physical memory, 
  * it must invalidate any translation for that page. 
  * To do so, it must locate the page table entry and/or TLB entry for the page; 
  * Thus the kernel maintains a physical memory map that keeps track of 
    what data is stored in each physical page.
* **Backing store map** system — When the fault handler cannot find a 
  page in physical memory, it allocates a new page 
  and initializes it in one of two ways: 
  * by filling it with zeroes or 
  * by reading it in from secondary storage. In this case, 
    the kernel must maintain maps to locate pages on the backing
    store, which includes: 
    * the executable file, 
    * from a shared library object file, 
    * or from its saved copy in the swap area. 

![4 memory maps](images/memory/virtmem_address_translation_maps.png)

4.3BSD uses a small number of fundamental data structures—the core map describes
physi- physical memory, the page tables describe virtual memory, and the disk
maps describe the swap areas. There are also resource maps to manage allocation
of resources such as page tables and swap space. Finally, some important
information is stored in the proc structure and u area of each process.


## Replacement policy

To make room for a new page, the kernel must reclaim 
a page that is currently in memory.

Most UNIX variants implement a global replacement policy, but reserve a
minimum number of resident pages for each active process.

Ideally, we want to keep those pages that are going to be needed in the near
future. We call this set of pages the **working set of a process**. If the page
reference behavior of the processes were known in advance, the working set could
be determined exactly, at least in the- theory. In practice, we have little
advance knowledge of the access pattern of processes, and we must rely on
empirical studies of typical processes to guide our implementation.

Such studies have shown that processes tend to exhibit **locality of reference**,
that is, a process tends to localize its references to a small subset of
its pages, and this subset changes slowly. For instance, when executing a
function, all instructions are on the page (or pages) containing that func-
function, and after a while, the process may move to a different function, thus
changing its working set. Similarly for data references, loops that operate on
arrays and functions that perform several opera- operations on a structure are
examples of code that exhibits locality of reference.

The practical inference is that recently accessed pages are more likely to be
accessed again in the near future. Thus, a good approximation to the working set
is the set of pages most recently accessed. This leads to a **least recently used**
(LRU) policy for page replacement—discard those pages that have not been
accessed for the longest time.


## Pages

Typically, there is: 
* one page table for kernel addresses and 
* one or more page tables to describe the user address space of each process.

## Page table

The page table forms a link between the MMU and the kernel, 
both of which can access, use, and modify the PTEs. 
The hardware also has a set of MMU registers, which point to the
page tables. The MMU is responsible for using the PTE 
to translate virtual addresses, checking the valid and protection bits 
in the process, and for setting referenced and modified bits as appropriate.

The kernel must 
* set up the page tables, 
* fill in the PTEs with the correct data, 
* and set the MMU registers to point to them. 
  These registers usually need to be reset on each context switch.



A page table is an array of entries, 
one per virtual page of the process. 

The index of the page table entry (PTE) in the 
table defines the page it describes.

A page table entry is usually 32 bits in size and is divided 
into several fields. These fields contain: 
* the physical page frame number,
* protection information,
* a valid bit, 
* a modified bit,
* (optionally) a referenced bit.

The page table format is hardware-prescribed; other than that: 
* page tables are simply data structures located in main memory,
* Several page tables reside in memory at any time. 
* The MMU uses only the active tables, whose locations are loaded in 
  hardware page table registers. 
* Typically, on a uniprocessor, there are two active page tables:
  * one for the kernel 
  * and one for the currently running process.



The MMU breaks a virtual address into:
* the virtual page number 
* and the offset within the page

It then locates page table entry for this page,:
* extracts the physical page number, 
* and combines that with the offset to compute the physical address.

Address translation may fail for three reasons:
* Bounds error — 
  * The address does not lie in the range of valid addresses for the process.
  * There is no page table entry for that page.
* Validation error — The page table entry is marked invalid. 
  * This usually means the page is not resident in memory. T
* Protection error — The page does not permit the type of access desired, e.g.:
  * write access to a read-only page 
  * or user access to a kernel page.

In all such cases, the MMU raises an exception and passes control to a handler
in the kernel. Such an exception is called a **page fault**, and the fault handler
is passed the offending virtual address as well as the type of fault (validation
or protection—bounds errors result in a validation fault). The handler may try
to service the fault by bringing the page into memory or to notify the process
by sending it a signal (usually SIGSEGV).

If the fault can be successfully handled, the process (when it eventually runs
again) must restart the instruction that caused the fault. This requires the
hardware to save the correct information required to restart the offending
instruction prior to generating the page fault.

Every time a page is written to, the hardware sets the modified bit in its PTE.
If the operating system finds this bit set, it saves the page on stable storage
before recycling it. If the hardware sup- supports a referenced bit in its PTEs,
it sets this bit on each reference to a page. This allows the operat- operating
system to monitor the usage of resident pages and recycle those that do not seem
useful.



### Page table storage

If a process has a large virtual address space, its page table may become
extremely large. For instance, if a process has an address space of 2 gigabytes
and the page size is 1024 bytes, then the page table must have 2 million
entries, and thus be 8 megabytes in size. It is impractical to keep such a large
table in physical memory. Moreover, most of this address space is probably not
really being used—a typical process address space comprises a number of regions
(text, data, stack, etc.) scattered in different parts of this space. Thus the
system needs a more compact way of describing the address space.

This problem is addressed by:
* **having segmented page tables**. It works best when the system explicitly 
  supports segmentation. Each segment of the process has its own page table, 
  which is just large enough to hold the valid address range for that segment.
* **Paging the page table itself**. With such a multitiered page table
  hierarchy, we need to allocate only those pages of the lower-level table 
  that map valid addresses of the process. The two-level approach is common.



## Translation Lookaside Buffer (TLB).

The TLB is an associative cache of recent address translations. TLB entries are
similar to page table entries and contain address translation and protection
informa- information. They may also have a tag that identifies the process to
which the address belongs. The cache is associative in the sense that the lookup
is content-based rather than index-based—the virtual page number is searched for
simultaneously in all the TLB entries.

The MMU usually controls most TLB operations. When it cannot find a translation
in the TLB, it looks it up in the software address maps (such as the page
tables) and loads it into a TLB entry. The operating system also needs to
cooperate in some situations. If the kernel changes a page table entry, the
change is not automatically propagated to the TLB's cached copy of the entry.
The kernel must explicitly purge any TLB entry that it invalidates, so that the
MMU will reload it from memory when the page is next accessed.

The hardware defines the way in which the kernel can operate on the TLB. It may
either provide explicit instructions for loading or invalidating TLB entries, or
such functions may occur as a byproduct of certain instructions. On some systems
(such as the MIPS R3000), the hardware uses only the TLBs, and any page tables
or other maps are managed solely by the kernel. On such sys- systems, the
operating system is involved on each TLB miss and must load the correct
translation into the TLB.

Although all MMUs must provide the same basic functionality, the way in which
they do so may vary a lot. The MMU architecture dictates the virtual and
physical page size, the types of pro- protection available, and the format of
the address translation entries. On machines with hardware- supported page
tables, the MMU defines the page table hierarchy and the registers that map the
page tables. It also defines the division of labor between itself and the
kernel, and the extent of the ker- kernel's role in manipulating the address and
translation caches.

### x86

UNIX implementations on the x86 use segmentation only for memory protection,
kernel en- entry, and context switching [Robb 87]. It hides the notion of
segmentation from user processes, who see a flat address space. To achieve this,
the kernel sets up all user segments with base address 0 and a large size that
excludes only the high end of virtual memory, which is reserved for kernel code
and data. Code segments are protected as read-only and data as read-write, but
both refer to the same locations. Each LDT also refers to some special
segments—a call gate segment for system call entry and a task state segment
(TSS) to save the register context across a context switch.

The x86 uses a two-level page table scheme (Figure 13-6). The 4-kilobyte page
size implies that a process may have up to one million pages. Rather than having
one huge page table, the x86 uses a number of small page tables for each
process. Each page table is one page in size, and thus holds 1024 PTEs. It maps
a contiguous region 4 megabytes in size, aligned at a 4-megabyte bound-
boundary. Hence a process may have up to 1024 page tables. Most processes,
however, have sparse ad- address spaces and use only a few page tables.

Each process also has a page directory, which contains PTEs that map the page
tables them- themselves. The directory is one page in size and holds 1024 PTEs,
one for each page table. The page directory is the level-1 page table, and the
page tables themselves are the level-2 tables.

The control register CR3 stores the physical page number of the current page
directory in its 20 high-order bits. Hence it is also known as the PDBR (Page
Directory Base Register). Virtual ad- addresses on the 80x86 can be broken into
3 parts. The top 10 bits contain the DIR field, which be- becomes the index into
the page directory. This is combined with the page number from CR3 to give the
physical address of the page directory entry for the appropriate page table. The
next 10 bits contain the PAGE field, which stores the virtual page number
relative to the start of that region. This is used as an index in the page table
to get the desired PTE, which in turn contains the physical page number of the
desired page. This in turn is combined with the low-order 12 bits of the virtual
ad- address, which contain the byte offset in the page, to yield the physical
address.

Each page table entry contains the physical page number, protection field, and
valid, refer- referenced, and modified bits (Figure 13-7). The protection field
has two bits—one to specify read-only (bit clear) or read-write (bit set) access
and another to specify if the page is a user page (bit clear) or supervisor (bit
set). When the process is running in kernel mode, all pages are accessible
read-write (write protection is ignored). In user mode, supervisor pages are
inaccessible regardless of the read- write bit setting, which only applies to
user pages. Since both page directory entries as well as page table entries have
protection fields, access must be permitted by both entries.

The support for the referenced bit simplifies the kernel's task of monitoring
page usage. The CR3 register needs to be reset on each context switch so that it
points to the page directory of the new process.

The TLB in the x86 architecture is never directly accessed by the kernel. The
entire TLB, however, is flushed automatically whenever the PDBR is written to,
either explicitly by a move in- instruction or as an indirect result of a
context switch.



# BSD virtual memory


## Physical memory

Physical memory can be viewed as a linear array of bytes.
It is logically divided into pages.
This memory can be divided into three sections:
* At the low end is the nonpaged pool, which contains the kernel 
  code and the portion of the kernel, data that can be allocated 
  either statically or at boot time. Most UNIX implementations require 
  all kernel pages to be nonpageable.
* The very high end of physical memory is reserved for error 
  messages generated during a system crash.
* In between these two regions is the paged pool, It contains all 
  the pages belonging to: 
  * user processes, 
  * as well as dynamically allocated kernel pages. Those are marked 
    nonpageable, even though they are part of the paged pool.




![Physical memory map](images/memory/virtmem_physical_memory.png)

These physical pages are called page frames, 
and the frame holds the contents of a process page. 

The page stored in the frame can be replaced at any time 
by a different page, and thus we need to maintain information 
about the contents of each frame. This is done using a core map,

### Core map

A core map is an array of struct cmap entries, 
one entry for each frame in the paged pool. 
The core map itself is a kernel data structure, 
**allocated at boot time and resident in the nonpaged pool**. 
The core map entry contains the following information about the frame:
* **Name** - 
  * type = data|stack|text, 
  * owner = process ID, 
  * virtual page number
* **Free list** - Forward and backward pointers to link free 
  pages onto a free list.
* **Text page cache** - disk address of text page 
  (device and block number), it is for sharing text pages,
  replacing owner.
* **Synchronization** - A set of flags synchronizes access to the page. 
  The page is locked while moving it to or from the disk.

# SVR4 Virtual Memory



## mmap


To map a file into memory, it must first be opened using 
the traditional open system call. This is followed by a call 
to mmap, which has the following syntax:

```
paddr = mmap (addr, len, prot, flags, fd, offset);
```

This establishes a mapping between the byte range [offset, offset+1 en] 
in the file represented by fd, and the address range [paddr, paddr+1 en) 
in the calling process. The flags include the mapping, which may be 
MAP_SHARED or MAP_PRIVATE. The caller may set prot to a combination of
PROT_READ, PROT_WRITE, and PROTEXECUTE.

The system chooses a suitable value for paddr. 
paddr will never be 0, and the mapping will
not overlay existing mappings, mmap ignores the addr parameter 
unless the caller specifies the MAP_FIXED flag.
In that case, paddr must be exactly the same as addr. 
If addr is unsuitable (it either is not page-aligned or does not fall 
in the range of valid user addresses), mmap returns an error.
The use of MAP_FIXED is discouraged, for it results in non-portable code.

mmap works on whole pages. This requires that offset be page-aligned. 
If MAP_FIXED has been specified, addr should also be page-aligned. 
If len is not a multiple of the page size, it will be
rounded upward to make it so.

The mapping remains in effect until it is unmapped by a call to

```
munmap (addr, len);
```

or by remapping the address range to another file by 
calling mmap with a MAP_RENAME flag. 


Protections may be changed on a per-page basis by

```
mprotect (addr, len, prot);
```


# IO

CPU as a result of computer instructions controls
its subsystems and external connectors connected to:
* Memory Management Unit MMU or Main Memory
* System or PCIe bus controller which is connected to
  * PCIe device controller which can be connected to
    * Disk controller
    * PCI bus controller which can be connected to ...
      * Mouse/Keyboard controller ...
  * PCIe adapter which could be connected to
    * other PCIe bus controller, etc. etc.
* Graphics controller


So for example CPU to control keyboadr, actually controls
PCIe (main) controller.

Each controller may have one or more devices attached to it.


![Instructions buses controlers and devices](images/buses/IO_CPU_and_Controlers.png)

The controller has a set of Control and Status Registers (CSRs) for each device.
Each device may have one or several CSRs, and their functions are completely
device-dependent. The driver writes to the CSRs to issue commands to the device
and reads them to obtain completion status and error information. These
registers are very different from other general-purpose registers. Writing to a
control register directly results in some device action, such as initiating disk
I/O or performing a form-feed on a printer. Reading a status register may also
have side effects, such as clearing the register. Hence the driver will not get
the same results if it reads a device register twice in succession. Likewise, if
it tries to read a register to which it has just written, the value read may be
quite different from what was written (because a single register could server as
a control and status register, allowing both reads and writes).

## Device controllers address space

The I/O space of a computer includes the set of all device 
registers, as well as frame buffers for memory-mapped 
devices such as graphics terminals. 

Each register has a well-defined address in the I/O space. 

These addresses are usually assigned at boot time, using a set 
of parameters specified in a configuration file used to build the system. 

The system might assign a range of addresses to
each controller, which in turn might allocate space 
for each device it manages.

There are two ways in which I/O space is configured in a system. 
* On some architectures such as the Intel 80x86, the I/O space 
  is separate from main memory and is accessed by special I/O
  instructions (such as inb and outb). 
* Others, such as the Motorola 680x0, use an approach called
  memory-mapped device I/O. This approach maps I/O registers 
  into a part of main memory and uses ordinary memory access 
  instructions to read and write the registers.

## Device controllers data transfer

There are two ways of transferring data between 
the kernel and the device, and the
method used depends on the device itself:
* Programmed I/O (PIO), PIO devices require the CPU to 
  move data to or from the device one byte at a time. 
  Whenever the device is ready for the next byte, 
  it issues an interrupt. 
* DMA, if a device supports DMA, the kernel may give it the 
  location (source or destination) of the data in memory, 
  the amount of data to transfer, and other relevant information. 
  The device will complete the transfer by directly accessing memory, 
  without CPU intervention. When the transfer completes, 
  the device will interrupt the CPU, indicating that it is ready
  for the next operation.
* Direct Virtual Memory Access (DVMA), where the device interacts directly 
  with the MMU to transfer data to virtual addresses. In such a case, 
  a device may directly transfer data to another device without 
  going through main memory.

## IO interrupts

Devices use interrupts to get the attention of the CPU. Interrupt handling is
highly machine- dependent, but we can discuss a few general principles. Many
UNIX systems define a set of inter- interrupt priority levels (ipls). The number
of ipls supported is different for each system. The lowest ipl is zero; in fact,
all user code and most of the normal kernel code runs at ipl 0. The highest ipl
is implementation-dependent: Some common values are 6, 7, 15, and 31. If the ipl
of an arriving interrupt is lower than the current ipl of the system, the
interrupt is blocked until the system ipl falls below that of the pending
interrupt. This allows the system to prioritize different types of interrupts.

The kernel uses a set of routines to manipulate the ipl. For instance, spltty()
raises the ipl to that of the terminal interrupt. The splx() routine lowers
the ipl to a previously saved value.

Usually all interrupts invoke a common routine in the kernel and pass it some
information that identifies the interrupt. This routine saves the register
context, raises the ipl of the system to that of the interrupt, and calls the
handler for that interrupt. When the handler completes, it returns control to
the common routine, which restores the ipl to its previous value, restores the
saved regis- register context, and returns from the interrupt.

How does the kernel identify the correct interrupt handler? This depends on
whether the system supports vectored or polled interrupts. In a completely
vectored system, each device pro- provides a unique interrupt vector number,
which is an index into an interrupt vector table. The entries in the table are
pointers to the appropriate interrupt handlers.

On some systems, the interrupt may only supply the ipl. Alternatively, it may
supply a vec- vector, but multiple devices may map to the same vector. In either
case, the kernel may have to decide which of several interrupt handlers to
invoke. It maintains a linked list of all handlers that share the same ipl (or
the same vector). When an interrupt arrives, the common routine loops through
the chain and polls each driver. The driver in turn checks if the interrupt was
generated by one of its devices. If so, it handles the interrupt and returns
success to the common routine. If not, it returns failure, and the common
routine polls the next device.

# Device Driver Framework

Two main types of devices are:
* A block device stores data and performs I/O in fixed-size, 
  randomly accessible blocks.
* A character device can store and transfer arbitrary-sized data.
  The kernel interprets the data as a continuous byte-stream 
  that is accessed sequentially. The character device is not 
  randomly addressable and does not permit a seek operation.

Not all devices fall neatly into one of these categories. 
In UNIX, **every device that does not have the properties** 
**of a block device is classified as a character device**. 


Exemplary exceptions:
* Some devices do no I/O at all. 
* The hardware clock, for example, is a device whose job is merely to 
  interrupt the CPU at fixed intervals, typically 100 times per second. 
* Memory-mapped screens are randomly addressable, yet are treated 
  as character devices. 
* Some block devices, such as disks, also provide a character device
  interface, since that is more efficient for certain operations.


### Pseudodevices

A driver does not have to control a physical device. It may simply use the
driver interface to provide special functionality (pseudodevice), for example:
* The mem driver, allows users to read or write locations in physical memory.
* The null device is a bit-sink—it only allows writes and 
  simply discards all data written to it.

## Extending kernel (by pseudodevices)

One important advantage of a pseudodevice driver is that it is often the only
way a third- party vendor can add functionality to a UNIX kernel. UNIX drivers
support a general-purpose entry point called ioctl. This may be invoked with an
arbitrary number of driver-specific commands. This allows a pseudodevice driver
to provide a rich set of kernel functions to the user, without actually
modifying the kernel itself.

Modern UNIX systems support a third class of drivers, called STREAMS drivers.
STREAMS drivers typically control network interfaces and terminals, and replace
character drivers used in earlier implementations for such devices. For
compatibility reasons, the STREAMS driver interface is derived from that of
character drivers.


## Invoking Driver Code

The kernel invokes the device driver in several ways:
* Configuration — The kernel calls the driver at boot time to 
  check for and initialize the device.
* I/O — The I/O subsystem calls the driver to read or write data.
* Control — The user may make control requests such as opening or 
  closing the device, or rewinding a tape drive.
* Interrupts — The device generates interrupts upon I/O completion, 
  or other change in its status.


This suggests partitioning the driver into two parts, usually called the top
half and the bottom half. 
* The top half contains the **synchronous routines**. Top-half routines
  execute in process context. They may access the address space and the u area of
  the calling process, and may even put the process to sleep if necessary.
* The bottom half contains the **asynchronous routines**.  Bottom-half 
  routines run in system context and usually have no relation to the
  currently running process. They are therefore not allowed to access the current
  user address space or the u area. Also, they are not allowed to sleep, since
  that may block an unrelated process.

The two halves of the driver need to synchronize their activities with each
other. If an object is accessed by both halves, then the top-half routines must
block interrupts (by raising the ipt) while manipulating it. Otherwise, the
device might interrupt while the object is in an inconsistent state, with
unpredictable results.

## The Device Switches

The device switch is a data structure that defines 
the entry points each device must support:
* struct bdevsw for block devices 
* and struct cdevsw for character devices.

The kernel maintains a separate array for each type of switch, and each device
driver has an entry in the appropriate array. If a driver provides both a block
and a character interface, it will have an entry in both arrays.


Whenever the kernel wants to per- perform an action on a device, it locates the
driver in the switch table and invokes the appropriate function of the driver.
For example, to read data from a character device, 
the kernel invokes the d_read() function of the device. 

A device may not support all entry points. For instance, a line printer does not
normally al- allow reads. For such entry points, the driver can use the global
routine nodev(), which simply re- returns the error code ENODEV. For some entry
points, the driver may wish to take no action. For in- instance, many devices
perform no special action when closed. In such a case, the driver may use the
global routine null dev (), which simply returns 0 (indicating success).

As mentioned earlier, STREAMS drivers are nominally treated and accessed as
character device drivers. They are identified by the d_str field, which is NULL
for ordinary character drivers. For a STREAMS driver, this field points to a
struct streamtab, which contains pointers to STREAMS-specific functions and
data.

Some (synchronous) routines:
* dioctl() - Generic entry point for control operations to a character device. Each
  driver may define a set of commands invoked through its ioctl interface.
  The arguments to this function include and, an integer that specifies which
  command to execute, and arg, a pointer to a command-specific set of ar-
  arguments. This is a highly versatile entry point that supports arbitrary op-
  operations on the device.
* d_open() - Called each time the device is opened, and may bring device on-line or
  initialize data structures. Devices that require exclusive access (such as
  printers or tape drives) may set a flag when opened and clear it when
  closed. If the flag is already set, d_open() may block or fail.

* dsegmapO Maps the device memory into the process address space. Used by mem-
  memory-mapped character devices to set up the mapping in response to the
  mmap system call.
* d_xpol 1 () Polls the device to check if an event of 
  interest has occurred. Can be used to check if a device is ready 
  for reading or writing without blocking, if an error condition 
  has occurred, and so on.

Some (asynchronous) routines:
* d_strategy() Common entry point for read and write requests to a block device. So
  named since the driver may use some strategy to reorder pending requests
  to optimize performance. Operates asynchronously—if the device is busy,
  this routine merely queues the request and returns. When the I/O com-
  completes, the interrupt handler will dequeue the next request and start the
  next I/O.
* d_xhalt() Shuts down the devices controlled by this driver. 
  Called during system shutdown or when unloading a driver from the kernel.


The driver entry points for interrupt handling and initialization are typically
not accessed through the switch table. Instead, they are specified in a master
configuration file, which is used to build the kernel. This file contains an
entry for each controller and driver. The entry also contains information such
as the ipl, interrupt vector number, and the base address of the CSRs for the
driver.


# The I/O Subsystem

The I/O subsystem is the portion of the kernel that 
controls the device-independent part of I/O operations 
and interacts with the device drivers to handle the 
device-dependent part. It is also responsible for device 
naming and protection, and for providing user applications 
with a consistent interface to all devices.

## Major and Minor Device Numbers

The name space of devices describes how different 
devices are identified and referenced.

Namespaces:
* The hardware name space identifies devices by the
  controller they are attached to and the logical 
  device number on that controller.
* The kernel uses a numbering scheme to name devices.
* Users require a simple and familiar name space and use file
  system pathnames for this purpose. 

The I/O subsystem defines the semantics of the kernel and user
name spaces and performs the mapping between them.


The kernel identifies each device by: 
* the device type (block or character), 
* The major device number - identifies the type of
  device, or more specifically, the driver. 
  * The major number is the index of that driver in the appropriate switch table.
* The minor device number identifies the specific instance of
  the device. 

For example, all disks may have major number 5, and each disk will 
have a different minor number. Block and character devices have 
their own independent sets of major numbers. Thus
major number 5 for block devices may refer to the disk driver, 
while that for character devices may refer to line printers.

A single driver may be configured with multiple major numbers. This is useful if
the driver manages different types of devices that perform some common
processing. Likewise, a single de- device may be represented by multiple minor
numbers. For example, a tape drive may use one minor number to select an
auto-rewind mode and another for no-rewind mode. Finally, if a device has both a
block and a character interface, it uses separate entries in both switch tables,
and hence separate major numbers for each.

UNIX provides a consistent interface to files and devices by introducing the
notion of a device file. This is a special file located anywhere in the file
system and associated with a specific de- device. By convention, all device
files are maintained in the directory **/dev** or a subdirectory thereof.

Internally, the device file is quite different from ordinary files. It has no
data blocks on disk, but it does have a permanent inode in the file system in
which it is located (usually, the root file system). The ditnode field of the
inode shows that the file type is either IFBLK (for block devices) or IFCHR (for
character devices). Instead of the list of block numbers, the inode contains a
field called dirdev, which stores the major and minor numbers of the device it
represents. This allows the kernel to translate from the user-level device name
(the pathname) to the internal device name (the major, minor pair).


The device file cannot be created in the usual way. Only a superuser may create
a device file, using the privileged system call 
```
mknod (path, mode, dev); 
```
where path is the pathname of the special file, 
mode specifies the file type (IFBLK or IFCHR) and permissions, 
and dev is the combined major and minor device number.

The mknod call creates a special file and initializes the di_node and di_rdev
fields of the inode from the arguments.

## The specfs File System

specfs associates an in-core object called a vnode with every open file. The
interface defines a set of abstract operations on each vnode, and each file
system supplies its own implementation of these functions.


To see how this happens, let us take an example where a user opens the file
/dev/lp. The di- directory /dev is in the root file system, which is of type
ufs. The open system call translates the path- pathname by repeatedly calling
ufs_lookup(), first to locate the vnode for dev, then the vnode for Ip. When uf
s_l ookup () obtains the vnode for Ip, it finds that the file type is IFCHR. It
then extracts the major and minor device numbers from the inode and passes them
to a routine called specvp ().

The specfs file system keeps all snodes in a hash table, indexed by the device
numbers, specvp () searches the hash table and, if the snode is not found,
creates a new snode and vnode. The snode has a field called s_real vp, in which
specvp () stores a pointer to the vnode of/dev/lp. Fi- Finally, it returns a
pointer to the specfs vnode to ufs_l ookup(), which passes it back to the open
system call. Hence open sees the specfs vnode and not the vnode of the file
/dev/lp. The specfs vnode shadows the vnode of /dev/lp, and its vop field points
to the vector of specfs operations (such as spec_read() and specwriteQ), which
in turn call the device driver entry points.

Before returning, open invokes the VOPOPEN operation on the vnode, which calls
specopenQ in the case of a device file. The specopenQ function calls the
d_open() routine of the driver, which performs the necessary steps to open the
device. The term snode refers to shadow node. In effect, the specfs vnode
shadows the "real" vnode and intercepts all operations on it.


![Opening device file](images/devices/IO_opening_specfs_file.png)

In practice, it is possible to have several device files, each representing
the same device (their dirdev fields will have the same value).
These files may be in the same or different file systems.

The first time a user opens a device file for a particular device, the kernel
creates an snode and a common snode. Subsequently, if another user opens the
same file, it will share these objects. If a user opens another file that
represents the same device, the kernel will create a new snode, which will
reference the common snode through its scommonvp field. The common snode is not
directly associated with a device file; hence, its sreal vp field is NULL. Its
scommonvp field points to itself.

## Device Cloning

In many cases, a user wants to open an instance of a device, but does not
particularly want a specific minor number. For example, network protocols are
usually implemented as device drivers and, if there are multiple active
connections using the same protocol, each uses a different minor device number.
A user who wants to establish such a connection does not care which minor number
is used—any unused number will do. Although he or she could loop through all
valid numbers searching for an unused one, that should not be the user's
responsibility. It is desirable that the user specify that he wants any
arbitrary minor device and that the kernel find an available device number.


One way a device can support cloning is by reserving one or more minor numbers
for cloning. When a user opens a device file using such a number, the d_open()
routine generates an unused minor number for this instance of the device. It
modifies the s_dev field of the snode to reflect the new minor number (using the
pointer passed to it) and updates internal data structures to reflect this
mapping. In this way, multiple users can open the device by supplying the
reserved minor number. The driver will return a different minor number (hence, a
different logical instance of the device) to each caller.


For instance, suppose the clone driver has major number 63. Then the device file
/dev/tcp may represent all TCP (transmission control protocol) streams. If the
TCP driver has a major device number 31, then the /dev/tcp file will have major
number 63 and minor number 31. When a user opens /dev/tcp, the kernel allocates
an snode and calls spec_open(). specopenQ invokes the d_open operation of the
clone driver (implemented by the clnopenQ routine), passing it a pointer to the
device number (hence, a pointer to the sdev field of the snode).

## I/O to a Character Device

The I/O subsystem plays a very small role in performing I/O to a character
device. The driver does most of the work itself. When a user process first opens
a character device, the kernel creates an


## The poll System Call


The poll system call allows a user to multiplex I/O over several descriptors.
Consider a server pro- program that opens several network connections, each
represented by a device file. It acquires a differ- different file descriptor
for each connection. If it wants to wait for an incoming message on a specific
connection, it issues a read on that descriptor. The read system call will block
the server until data arrives, then wake it up and return the data.

Suppose the server wants to wait for a message to arrive at any connection. Now
the read system call is ineffective, since a read on one descriptor may block
even though data is available on other connections. The server must use the poll
system call, which allows it to wait simultaneously for events on a set of
descriptors and return when any event occurs. Its syntax is:

```
poll (fds, nfds, timeout);
```

where fds points to an array of size nfds, whose elements are described by:

```
struct pollfd {
  int fd;         /*file descriptor */
  short events;   /* events of interest */
  short revents;  /* returned events */
};
```

For each descriptor, events specifies which events are of interest to the
caller, and on return, revents contains the events that have occurred. Both
values are bitmasks.

Each descriptor of intrest must correspond to an open file, 
otherwise the call fails.

poll examines all the specified descriptors. If any event of interest has
occurred, it returns immediately after examining all descriptors. If not, it
blocks the process until any interesting event occurs. When it returns, the
revent s field of each po 11 f d shows which, if any, of the events of in-
interest have occurred on that descriptor, poll also returns if timeout
milliseconds expire, even if no events have occurred. If timeout is 0, poll
returns immediately. If timeout is INFTIM or -I,poll returns only when an event
of interest occurs (or the system call is interrupted). The return value of poll
equals the number of events that have occurred, or 0 if the call times out, or
-1 if it fails for another reason.


An ordinary file or a block device is always considered ready for I/O, and
select is really useful only for character device files.


## Block I/O

I/O to block devices requires a lot more involvement of the I/O subsystem. There
are two types of block devices—those that contain a UNIX file system, and raw or
unformatted devices. The latter are only accessed directly through their device
files. Although formatted devices may also be used in this way, they are
normally accessed as a result of I/O to the files resident on them.

The buf structure forms the only interface between the kernel and the block
device driver. When the kernel wants to read or write to the device, it invokes
the d_strategy () routine of the driver, pass- passing it a pointer to a struct
buf. This structure contains all the information required for the I/O op-
operation, such as:

* Major and minor numbers of the target device
* Starting block number of the data on the device
* Number of bytes to be transferred (which must be a multiple of the sector size)
* The location of the data (source or destination) in memory
* Flags that specify whether the operation is a read or a write, 
  and whether it is synchronous
* Address of a completion routine to be called from the interrupt handler

When the I/O completes, the interrupt handler writes status information in the
buf structure and passes it to the completion routine. The completion status
includes the following information:

Flags that indicate that the I/O is complete, and whether it was successful
* An error code, if the operation failed
* The residual byte count, that is, the number of bytes not transferred

The buf structure is also used by the block buffer cache, 
to hold administrative information about a cache block. ...


The kernel addresses a disk block by specifying a vnode, and an offset in that
vnode. If the vnode represents a device special file, then the offset is
physical, relative to the start of the device. If the vnode represents an
ordinary file, the offset is logical, relative to the start of the file. Hence a
data block of an ordinary file can be addressed in two ways—either by its file
vnode and logical offset, or by the device vnode and physical offset. The latter
is used only when a user directly accesses the underlying device. This could
lead to two aliases for the same block in the ker- kernel, resulting in two
different copies of the block in memory. To avoid such inconsistencies, direct
access to the block device file must be restricted to when the file system is
not mounted.


## Raw I/O to a Block Device

The problem with read and write system calls is that they copy the data
twice—once between the user space and the kernel, and once between the kernel
and the disk. This allows the kernel to cache the data, which is beneficial for
typical applications. For applications that want to perform large data transfers
to or from the disk, and whose access patterns do not benefit from caching, such
an ap- approach is inefficient and slow.

One alternative is to use mmap to map the data into the address space. While
this eliminates the extra copy, its semantics are different from those of read
and write system calls. Moreover, the mmap system call is a relatively new
feature, not available on all implementations. UNIX provides a facility called
raw I/O, which permits unbuffered access to block devices. It too avoids the
extra copy, thus providing high performance.

To allow raw I/O, the block device must also present a raw, or character
interface. Hence it must have an entry in the character device switch.
Applications perform raw I/O by issuing read or write system calls to the
associated character device, which result in calling the d_read() or d_write()
routines of that device. These routines directly call the kernel function
physiock(), which does the following:

1. Validates the I/O parameters, such as making sure the I/O 
   does not start beyond the end of the device.
2. Allocates a buf structure from a freelist.
3. Calls as_f aul t () to fault in the user pages involved in the operation.
4. Locks the user pages in memory so they cannot be paged out.
5. Calls the dstrategyf) routine of the associated block device. 
   The character driver passes the device number as an argument to physiock ().
6. Sleeps until the I/O completes.
7. Unlocks the user pages.
8. Returns the results of the operation 
   (transfer count, error status, etc.) to the caller.


## The DDI/DKI Specification

Even though device drivers are part of the kernel, they are usually written
independently by device vendors, frequently without access to the kernel source
code. This is possible due to the switch- based, procedural interface between
the kernel and the driver. To develop a driver for a UNIX ker- kernel, the
vendor simply supplies an implementation of the interface, which includes the
switch func- functions, interrupt handler, and configuration and initialization
functions. Entries are added to the ap- appropriate configuration files (such as
conf.c, which contains the bdevsw[] and cdevsw[] tables) and the kernel is
rebuilt, linking the driver with the set of kernel object files provided by the
operat- operating system vendor.

The preceding sections discussed this part of the interface in detail. However,
the interface described so far is incomplete, since it only covers the calls
made by the kernel to the driver. The driver, too, must invoke several kernel
functions to access services such as data transfer, memory allocation, and
synchronization. Moreover, since multiple, independently written drivers coexist
in the kernel and may be active concurrently, it is important that they not
interfere with each other or with the kernel.



# STREAMS

## Messages

The simplest message consists of three objects—a struct msgb (or type rnbl k_t),
a struct datab (type dbl k_t), and a data buffer. A multipart message may be
constructed by chaining such triplets together, as shown in Figure 17-4. 

In the msgb, the b_next and bprev fields link a message onto a queue, while
b_cont chains the different parts of the same message. The b_datap field points
to the associated datab. Both the msgb and the datab contain information about
the actual data buffer. The dbbase and dbl im fields of the datab point to the
beginning and end of the buffer. 

Only part of the buffer may contain useful data, so the brptr and b_wptr fields
of the msgb point to the beginning and end of the valid data in the buffer. The
allocb() routine allocates a buffer and initializes both the b_rptr and bwptr to
point to the beginning of the buffer (dbbase). 

As a module writes data into the buffer, it advances bwptr (always checking
against db_l im). As a module reads data from the buffer, it advances brptr
(checking that it does not read past bwptr), thus removing the data from the
buffer.

![Streams message allocation](images/streams/streams_message.png)

## Virtual Copying

The datab is reference counted, and its db_ref field is used for that purpose. 
Multiple msgb's may share a single datab, thus sharing the data in 
the associated buffer. This allows efficient virtual copying of the data.

![Streams message allocation](images/streams/streams_message_sharing_buffer.png)

One example of the use of virtual copying is in the TCP/IP protocol. The TCP
layer provides reliable transport, and hence must ensure that every message
reaches its destination. If the receiver does not acknowledge the message within
a specified period of time, the sender retransmits it. To do so, it must retain
a copy of each message it sends until the message is acknowledged. Physically
copying every message is wasteful, hence TCP uses the virtual copying mechanism.
When the TCP module receives a message to send downstream, it calls the STREAMS
routine dupmsg(), which creates another msgb that references the same datab.
This results in two logical messages, each ref- referencing the same data. TCP
sends one message downstream, while holding on to the other.

When the driver sends the message and releases the msgb, the datab and data
buffer are not freed, because the reference count is still non-zero. Eventually,
when the receiver acknowledges the message, the TCP module frees the other msgb.
This drops the reference count on the datab to zero, and STREAMS releases the
datab and the associated data buffer.

## Queues and Modules


Modules are the building blocks of the stream. Each module comprises a pair of
queues—a read queue and a write queue.

Each queue must supply four procedures—put, service, open, and close. These are
the only functions required for other STREAMS objects to be able to communicate
with the queue. The moduleinfo structure contains default high and low
watermarks, packet sizes, and other parameters for the queue.

The open and close procedures are called synchronously by processes opening and
closing the stream. The put procedure performs immediate processing of a
message. If a message cannot be processed immediately, the put procedure adds
the message to the queue's message queue. Later, when the service 
procedure is invoked, it will perform delayed processing of these messages.


## Stream I/O

The stream performs I/O by passing messages from one queue to another. A user
process writes to the device using the write otputmsg system calls. The stream
head allocates a message (a msgb, da- tab, and data buffer) and copies the data
into it. It then sends it downstream to the next queue, and eventually the data
reaches the driver. Data from the device arrives asynchronously, and the driver
sends it upstream toward the stream head. A process receives data through read
and getmsg calls. If there is no data available at the stream head, the process
blocks.

Stream I/O is asynchronous. The only place where an I/O operation may block the
process is at the stream head. The put and service procedures of the module and
driver are non-blocking.

If the put procedure cannot send the data to the next queue, it places the
message on its own message queue, from where it may be retrieved later by the
service procedure. If the service procedure re- removes a message from the queue
and discovers that it cannot process it at this time, it returns the message to
the queue and tries again later.

The put and service procedures must synchronize with each other while accessing
common data structures. Because the read-side put procedure may be called from
interrupt handlers, it may interrupt the execution of either service procedure,
or of the write-side put procedure. Additional locking is required on
multiprocessors, since the procedures may run concurrently on different
proccessors.

## The STREAMS Scheduler

When the put procedure defers the processing of data, it calls putq() to place
the message onto the queue and then calls qenabl e() to schedule the queue for
servicing, qenabl e() sets the QENAB flag for the queue and adds the queue to
the tail of the list of queues waiting to be scheduled. If the QENAB flag is
already set, qenable() does nothing, since the queue has already been scheduled.
Fi- Finally, qenabl e() sets a global flag called qrunflag, which specifies that
a queue is waiting to be scheduled.

STREAMS scheduling is implemented by a routine called runqueues() and has no
relation to UNIX process scheduling. The kernel calls runqueues () whenever a
process tries to perform an I/O or control operation on a stream. This allows
many operations to complete quickly before a context switch occurs. The kernel
also calls runqueues () just before returning to user mode after a context
switch.

The runqueues () routine checks if any streams need to be scheduled. If so, it
calls queuerun(), which scans the scheduler list, and calls the service
procedure of each queue on it. The service procedure must try to process all the
messages on the queue.

## The Driver End

The driver end is like any module, but with a few important differences. First,
it must be prepared to receive interrupts. This requires it to have an interrupt
handler and make the handler known to the kernel, in a machine-dependent manner.
Devices generate interrupts upon receiving incoming data. The driver must
package the data into a message and arrange to send it upstream. When the driver
receives a message coming down from the stream head, it must extract the data
from the message and send it to the device.


Drivers usually implement some form of flow control, as most devices require it.
In many cases, especially for incoming data, the driver resorts to dropping
messages when it cannot manage the load. Hence, if the driver cannot allocate a
buffer, or if its queues overflow, it silently discards incoming or outgoing
messages. It is the responsibility of applications to recover correctly from
dropped packets. Higher-level protocols such as TCP ensure reliable transport by
retaining a copy of each message until it reaches its destination; if the
receiver does not acknowledge the message within a certain period of time, the
protocol retransmits it.

The driver end also differs from the module in the way it is opened and
initialized. STREAMS drivers are opened by the open system call, while modules
are pushed onto streams by ioctl calls.

## The Stream Head

The stream head is responsible for system call handling. It is also the only
part of the stream where an I/O operation may block the calling process. While
each module or driver has its own put, serv- service, open, and close
procedures, all stream heads share a common set of routines internal to STREAMS.

A process writes data to a stream using the write or putmsg system calls. The
write system call allows only ordinary data to be written and does not guarantee
message boundaries. It is useful for applications that have a byte-stream view
of the stream. The putmsg system call allows the user to supply a control
message and a data message in one call. STREAMS combines them into a single
message whose first datab has type M_PROTO and the next has the type M_DATA. 

In either case, the stream head copies the data from the user address space into
STREAMS messages and then calls canput() to see if the stream has room for the
data (the next flow- controlled module or driver is not full). If so, it sends
the data downstream by calling putnext() and returns control to the caller. If
canput() returns FALSE, the calling process blocks on the stream head until the
head is back-enabled by the next flow-controlled module.

Hence, when the write ox putmsg system call returns, the data has not
necessarily reached the device. The caller is guaranteed that the data has
safely been copied into the kernel and has either reached the device or been
queued at a module or driver.

A process reads data from the stream using read or getmsg. The read system call
only reads ordinary data. A module may send a M_SETOPTS message to the stream
head, asking it to treat MPROTO messages as ordinary data. After this, the read
call reads the contents of both M_DATA and M_PROTO messages. In any case, the
read system call does not preserve message boundaries or re- return information
about message types. It is primarily used when the application has a byte-stream
view of the data.

The getmsg system call, in contrast, retrieves both M_PROTO and M_DATA messages.
It pre- preserves message boundaries and returns the two types of messages in
separate return arguments. If an incoming message consists of an M_PROTO block
followed by one or more MDATA blocks, getmsg will separate the two parts
correctly.

In either case, if data is already available at the stream head, the kernel
extracts it from the message, copies it into user space, and returns control to
the caller. If there is no message waiting at the head, the kernel blocks the
caller until a message arrives. Several processes may attempt to read from the
same stream. If no message is waiting, all will block. When a message arrives,
the kernel will give it to one of these processes. The interface does not define
which process will receive the message.

When a message reaches the stream head, the kernel checks if a process is
waiting for it. If so, the kernel copies the message into the process's address
space and wakes up the process, which then returns from the read or getmsg. If
no process is waiting, the kernel queues the message at the stream head. If the
stream head's queue becomes full, further messages will be queued at the preced-
preceding flow-controlled queue, and so on.

## Multiplexing

STREAMS provides a facility called multiplexing, which allows multiple streams
to be linked to a single stream, called a multiplexor. Multiplexing is
restricted to drivers and is not supported for modules. 


### Upper Multiplexors

Upper multiplexing is simply a result of opening multiple minor devices to the
same driver. STREAMS provides no special support except the processing in the
open and close system calls. Any driver that supports multiple minor devices is
an upper multiplexor.

Since the two streams have the same major device number, they will be handled by
the same driver. The open procedure of the driver will be called twice, once for
each stream. The driver will manage two sets of queues, per- perhaps with
different modules pushed on them. When data comes in from the device, the driver
exam- examines the data and decides which stream should receive it. The decision
is usually based on informa- information contained in the data, or on which port
on the controller card the data arrived.

For example, Figure 17-13 describes an ethernet driver acting as an upper
multiplexor. The two streams may contain different modules. For instance, one
stream may be using an IP module and another an ICMP module. When data arrives
from the network, the driver examines its contents to decide which stream should
receive the data.


### Lower Multiplexors

A lower multiplexor driver is a pseudodevice driver. Instead of controlling a
physical device, it in- interfaces with one or more streams below it. To build
such a configuration, a user creates the upper and lower streams, and links the
upper stream to each of the lower streams. STREAMS provides special ioctl
commands called ILINK and IUNLINK to set up and dismantle lower multiplexors.


## Higher lever network interfaces


![Connection oriented services](images/streams/streams_connection_oriented_interface.png)


Connectionless protocols operate differently (Figure 17-20). Both the server and
the client call t_open() and t_bind(), just as before. Since there are no
connections to be made, we do not need t_listen(), t_connect(), or t_accept()
calls. Instead, the server sits in a loop, calling t_rcvudata(), which blocks
until a client sends a message. When a message arrives, the call re- returns to
the server with the address and port number of the sender, along with the body
of the mes- message. The server processes the message and replies to the client
calling t_sndudata(). The client likewise calls t_sndudata() to send messages
and trcvudataQ to receive replies.

![Connectionless oriented services](images/streams/streams_connectionless_protocol.png)




