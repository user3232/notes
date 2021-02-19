

# Examplary linux administration tools and tasks

https://www.linuxbox.pl/

System LinuxBox Project powstał na bazie pakietów opartych o
system Slackware i przy pomocy dokumentacji Linux From
Scratch.

## Instalacja i uruchomienie systemu Linux pracującego jako Router:

* Plain – Standalone
* BGP – Border Gateway Protocol
* OSPF – Open Shortest Path First
* NAT – Network Address Translation
* IPv6 – Internet Protocol version 6
* VLAN – Virtual Local Area Network
* VLAN QinQ – Virtual Local Area Network (VLAN w VLAN-ie)

## Instalacja i uruchomienie zarządzania pasmem QoS z Filtrami Mieszającymi:

* HTB – Hierarchical Token Bucket
* HFSC – Hierarchical Fair-Service Curve
* FQ_CODEL – Fair Queuing with Controlled Delay
* SFQ – Stochastic Fairness Queueing

## Instalacja i uruchomienie zarządzania pasmem QoS z użyciem IPSet:

* Nowatorska funkcja bazująca w oparciu o interfejsy fizyczne z pominięciem interfejsów wirtualnych tak jak to było kiedyś – teraz już tego nie trzeba !
* Stosowana przy większych sieciach bądź sieciach o dużym natężeniu ruchu gdzie nawet użycie filtrów mieszających staje się mało wydajne powodując wzrost czasu odpowiedzi na Ping bądź odczuwalne spowolnienia a nawet zatory !

## Instalacja i uruchomienie systemu pracującego jako serwer sieciowy:

* WWW – Apache2, Nginx
* Baza Danych – MySQL (Oracle, Percona, MariaDB), PostgreSQL
* Poczty – Postfix, Dovecot
* FTP – Proftpd
* DNS – Bind (Standalone, Anycast)
* Czasu – NTP
* Logowanie – uLog, rSyslog

## Instalacja i uruchomienie na systemach Linux tuneli VPN:

* OpenVPN – Open Virtual Private Network
* IPSec – IP Security
* L2TP – Layer 2 Tunneling Protocol
* PPTP – Point to Point Tunneling Protocol

## Instalacja i uruchomienie statystyk na systemach Linux:

* Cacti
* SmokePing
* LSTAT – Linux Statistics
* MRTG – Multi Router Traffic Grapher

## Instalacja i uruchomienie protokołu SNMP

Simple Network Management Protocol (SNMP)


## LMS – LAN Management System (konkretnie iLMS)

## Wdrożenie PPPoE na istniejącej sieci typu Plain

Rozproszone Koncentratory PPPoE

## Wdrożenie panelu do obsługi Hostingu i-MSCP – 

internet – Multi Server Control Panel





# Linux From Scratch

http://www.linuxfromscratch.org/

## What is Linux From Scratch?

Linux From Scratch (LFS) is a project that provides you with
step-by-step instructions for building your own customized
Linux system entirely from source.  

### Why would I want an LFS system?

Many wonder why they should go through the hassle of
building a Linux system from scratch when they could just
download an existing Linux distribution. However, there are
several benefits of building LFS. Consider the following:

### LFS teaches people how a Linux system works internally

Building LFS teaches you about all that makes Linux tick,
how things work together and depend on each other. And most
importantly, how to customize it to your own tastes and
needs.

### Building LFS produces a very compact Linux system

When you install a regular distribution, you often end up
installing a lot of programs that you would probably never
use. They're just sitting there taking up (precious) disk
space. It's not hard to get an LFS system installed under
100 MB. Does that still sound like a lot? A few of us have
been working on creating a very small embedded LFS system.
We installed a system that was just enough to run the Apache
web server; total disk space usage was approximately 8 MB.
With further stripping, that can be brought down to 5 MB or
less. Try that with a regular distribution.

### LFS is extremely flexible

Building LFS could be compared to a finished house. LFS will
give you the skeleton of a house, but it's up to you to
install plumbing, electrical outlets, kitchen, bath,
wallpaper, etc. You have the ability to turn it into
whatever type of system you need it to be, customized
completely for you.

### LFS offers you added security

You will compile the entire system from source, thus
allowing you to audit everything, if you wish to do so, and
apply all the security patches you want or need to apply.
You don't have to wait for someone else to provide a new
binary package that (hopefully) fixes a security hole.
Often, you never truly know whether a security hole is fixed
or not unless you do it yourself.


