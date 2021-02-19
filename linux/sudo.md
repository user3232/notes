
# Refs

This note is based on:

- [Sudo Mastery, 2nd Edition](https://www.tiltedwindmillpress.com/product/sudo-mastery-2nd-edition/)


# Intro

Unix allows multiple users (as programs, or (interactive) programs
controlled by person) to use operating system. For example turn on
system processes monitor, it will show many running programs belonging
to different users (root, www-data, mk, syslog, ...). Usually those
users are system users, but it would be not so different it it were
humans logged to console and running commands.


User is shell. Now the question arises: How can shell become another
user (shell)?

## Users and groups

- https://www.cyberciti.biz/open-source/command-line-hacks/linux-run-command-as-different-user/
- https://wiki.archlinux.org/index.php/Users_and_groups
- https://wiki.archlinux.org/index.php/Capabilities
- https://wiki.ubuntu.com/Security/Privileges
- https://serverfault.com/questions/485473/what-is-the-canonical-use-for-the-sys-and-adm-groups
- https://linuxize.com/post/how-to-list-users-in-linux/
- https://websiteforstudents.com/how-to-list-all-user-groups-on-ubuntu-18-04-16-04-with-examples/
- https://www.pluralsight.com/guides/linux-permissions
- https://www.pluralsight.com/guides/user-and-group-management-linux
- https://www.cyberciti.biz/tips/allow-a-normal-user-to-run-commands-as-root.html
- https://linux.die.net/man/7/capabilities


## setuid and setgid programs

While programs normally work with the privileges of the user who runs
them, `setuid` and `setgid` programs change their effective UID and
GID to some other value. From `man setuid`:

```
SETUID(2)             Linux Programmer's Manual            SETUID(2)

NAME
       setuid - set user identity

SYNOPSIS
       #include <sys/types.h>
       #include <unistd.h>

       int setuid(uid_t uid);

DESCRIPTION
       setuid()  sets  the effective user ID of the calling process.
       If the calling process is privileged (more precisely: if  the
       process has the CAP_SETUID capability in its user namespace),
       the real UID and saved set-user-ID are also set.

       Under Linux, setuid() is implemented like the  POSIX  version
       with the _POSIX_SAVED_IDS feature.  This allows a set-user-ID
       (other than root) program to drop all of its user privileges,
       do  some  un-privileged  work, and then reengage the original
       effective user ID in a secure manner.

       If the user is root or the program is set-user-ID-root,  spe‐
       cial  care  must be taken: setuid() checks the effective user
       ID of the caller and if it is  the  superuser,  all  process-
       related  user  ID's are set to uid.  After this has occurred,
       it is impossible for the program to regain root privileges.

       Thus, a set-user-ID-root program wishing to temporarily  drop
       root privileges, assume the identity of an unprivileged user,
       and  then  regain  root  privileges  afterward   cannot   use
       setuid().  You can accomplish this with seteuid(2).
```

Some programs need this functionality, for example to allow user
change its password user must change `/etc/passwd` file, but it
can't do it because this file is owned by root. One solution to
this is write program using `setuid` and `getuid` which inside
temporarly change user to root to access file and allow changes
only related to calling user. But `setuid`/`getuid` needs special
permissions of user. So user must be allowed to run program
containing this but no arbitrary programs containing this
(i.e. user programs).

The way to do it is:

> The setuid bit can be set on an executable file so that when run,
> the program will have the privileges of the owner of the file
> instead of the real user, if they are different. This is the
> difference between effective uid (user id) and real uid.
>
> Some common utilities, such as passwd, are owned root and configured
> this way out of necessity (passwd needs to access /etc/shadow which
> can only be read by root).
>
> The best strategy when doing this is to do whatever you need to do
> as superuser right away then lower privileges so that bugs or misuse
> are less likely to happen while running root. To do this, you set
> the process's effective uid to its real uid.
>
> Read the rest from: [Unix Stackexchange: Using the setuid bit properly](https://unix.stackexchange.com/questions/166817/using-the-setuid-bit-properly).

### Important!

Most operating systems **don't let you make shell scripts setuid**, it
is **allowed only for programs**.

### Links

- https://unix.stackexchange.com/questions/166817/using-the-setuid-bit-properly
- http://manpages.ubuntu.com/manpages/bionic/man1/super.1.html
- https://www.liquidweb.com/kb/how-do-i-set-up-setuid-setgid-and-sticky-bits-on-linux/
- Inter process communication, what if processess belongs to different
  users? 
  https://opensource.com/article/19/4/interprocess-communication-linux-storage


### Example: Running nginx as non root

Following links provide few examples:

- https://www.exratione.com/2014/03/running-nginx-as-a-non-root-user/
- https://unix.stackexchange.com/questions/134301/why-does-nginx-starts-process-as-root
  - https://unix.stackexchange.com/a/134324
- https://help.dreamhost.com/hc/en-us/articles/222784068-The-most-important-steps-to-take-to-make-an-nginx-server-more-secure


## Access Control Lists (ACLs)


Then there are several varieties of access control lists (ACLs) which
more broadly expand the user-group-others ownership model. ACLs allow
you to declare something like "This person owns the file, but these
groups and people can modify it, with these exclusions, and these
groups and people (with some exclusions, of course!) can execute it,
while these other people can read data from it, except for..." At this
point the systems administrator gets aheadache and starts
contemplating a career change.

## sudo

Sudo is a program that controls access to running commands as root or
other users. The system owner creates a list of privileged commands
that each user can perform. When the user needs to run a command that
requires root-level privilege, he asks sudo to run the command for
him. Sudo consults its permissions list. If the user has permission to
run that command, it runs the command. If the user does not have
permission to run the command, sudo tells him so. Running sudo does
not require the root password, but rather the user's own password (or
some other authentication).

The system administrator can delegate root-level privileges to
specific people for very specific tasks without giving out the root
password. She can tell sudo to require authentication for some users
or commands and not for others. She can permit users access on some
machines and not others, all with a single shared configuration file.

Some applications, notably big enterprise database software, rununder
a specific dedicated account. Users must switch to this account before
managing the software. You can configure sudo to permit users to run
specific commands as this account. Maybe your junior database
administrators only need to run backups, while the lead DBA needs a
full-on shell prompt as the database account. Sudo lets you do that.

Finally, sudo logs everything everybody asks it to do. It can even
replay the contents of individual sudo sessions, to show you exactly
who broke what.

# To what groups User=shell=program is associated?

```console
$ id mk
uid=1000(mk) gid=1000(mk) grupy=1000(mk),4(adm),24(cdrom),27(sudo)
```


# Running Commands as Another User

Running commands as root isn't always desirable. Some software,
notably databases and application servers, might have a dedicated user
just for themselves. The application expects to run as that user, and
that user's environment is configured to manage the application.
Applications ranging from big Java programs to tiny tools such as
Ansible use this model. You can run a command as a specific user by
adding the -u flag.

```sh
sudo -u oracle sqlplus
```

# Running Commands as Another Group

User groups:

- Every user has a primary group, listed with their account in
  `/etc/passwd` or its equivalent. 
- Groups from additional sources, such as `/etc/group` , are
  considered secondary groups. 

Some programs only work if the user's primary group is its preferred
group. This gets really, really annoying, as you would probably prefer
to use groups for their intended purpose rather than babysitting one
piece of picky software. Depending on how your operating system
handles groups and how your software is installed, you might need to
change your primary group to run a command. Use the -g flag and a
group name.

```sh
sudo -g operator stupidpickycommand
```




