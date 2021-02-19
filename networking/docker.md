# Infrastructure

## Configuration and data storage

The contents of `/var/lib/docker/`, includes: 
* images, 
* containers, 
* volumes, 
* and networks

## Docker drivers

Docker Engine on Ubuntu supports overlay2, aufs and btrfs
storage drivers.  Docker Engine uses the overlay2 storage
driver by default. 


## How to uninstall old versions?

Older versions of Docker were called docker, docker.io, or
docker-engine. If these are installed, uninstall them (it
preserves the contents of `/var/lib/docker/`):

```console
$ sudo apt-get remove docker docker-engine docker.io containerd runc
$ # To delete all images, containers, and volumes:
$ sudo rm -rf /var/lib/docker
```

It’s OK if apt-get reports that none of these packages are
installed.


## How to install?


You can install Docker Engine in different ways, depending
on your needs:

* Most users set up Docker’s repositories and install from
  them, for ease of installation and upgrade tasks. This is
  the recommended approach.
* Some users download the DEB package and install it
  manually and manage upgrades completely manually. This is
  useful in situations such as installing Docker on
  air-gapped systems with no access to the internet.
* In testing and development environments, some users choose
  to use automated convenience scripts to install Docker.

Example:

```console
$ sudo apt-get update

$ # install software allowing apt by https (apt-transport-https)
$ # install software allowing ca-certificates (ca-certificates)
$ # install software for downloads (curl)
$ # install software for kryptographic keys (gnupg-agent)
$ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
$ # Add Docker’s official GPG key:
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ # Verify that you now have the key with the fingerprint 
$ # 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
$ # by searching for the last 8 characters of the fingerprint.
$ sudo apt-key fingerprint 0EBFCD88

pub   rsa4096 2017-02-22 [SCEA]
      9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid           [ unknown] Docker Release (CE deb) <docker@docker.com>
sub   rsa4096 2017-02-22 [S]
$ # set up the stable repository:
$ # $(lsb_release -cs)
$ # returns the name of your Ubuntu distribution, such as xenial
$ sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
$ # Update the apt package index
$ sudo apt-get update
$ # install the latest version of Docker Engine and containerd
$ sudo apt-get install docker-ce docker-ce-cli containerd.io
$ # Verify that Docker Engine is installed correctly
$ # by running the hello-world image
$ sudo docker run hello-world
```

## docker group

After installation the docker group is created but no users
are added to it. You need to use sudo to run Docker commands.

The Docker daemon binds to a Unix socket instead of a TCP
port. By default that Unix socket is owned by the user root
and other users can only access it using sudo. The Docker
daemon always runs as the root user.

When the Docker daemon starts, it creates a Unix socket
accessible by members of the docker group. (This socket
controls dockerd which have root privileges.)

## no sudo -> adding trusted user to doker group

To add user to docker group, and change ownership
of ~/.docker to user:

```console
$ # make sure docker group exists
$ sudo groupadd docker
groupadd: group 'docker' already exists
$ # add yourself (user using shell) to group:
$ # usermod [options] LOGIN
$ # -a : add the user to supplementary groups
$ # -G : a list of supplementary groups
$ sudo usermod -a -G docker $USER
$ # to list members of docker group
$ grep docker /etc/group
docker:x:134:mk
$ # activate the changes to groups
$ newgroup docker
$ # test if it works
$ docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world

$ # change ownerchip of profile file
$ # chown [OPTION]... [OWNER][:[GROUP]] FILE...
$ # -R : recursive  
$ sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
$ # change profile file permissions (allow user grup everything)
$ # chmod [OPTION]... MODE[,MODE]... FILE...
$ #   MODE = [ugoa...][[-+=][rwxXst...]...]
$ #   +(add), -(rem), =(set only) 
$ #   u(user), g(group), o(others), a(all) 
$ #   r(read), w(write), x(exec), 
$ #   X(execute/search only for dir or x), 
$ #   s(set user or group ID on exec)
$ sudo chmod g+rwx "$HOME/.docker" -R
$ # To enable dockerd at boot
$ sudo systemctl enable docker
$ # To disable dockerd at boot
$ sudo systemctl disable docker

```



## Remote access and logs

https://docs.docker.com/engine/install/linux-postinstall/#configure-where-the-docker-daemon-listens-for-connections

https://docs.docker.com/engine/install/linux-postinstall/#configuring-remote-access-with-systemd-unit-file

https://docs.docker.com/engine/install/linux-postinstall/#configure-default-logging-driver


## Security

**Only trusted users should be allowed to control** 
**Docker daemon.**

## Security - Docker Content Trust Signature Verification


The Docker Engine can be configured to only run signed
images. The Docker Content Trust signature verification
feature is built directly into the dockerd binary.  This is
configured in the Dockerd configuration file.

To enable this feature, trustpinning can be configured in
daemon.json, whereby only repositories signed with a
user-specified root key can be pulled and run.

This feature provides more insight to administrators than
previously available with the CLI for enforcing and
performing image signature verification.

For more information on configuring Docker Content Trust
Signature Verificiation, go to Content trust in Docker.


## Other kernel security features

Capabilities are just one of the many security features
provided by modern Linux kernels. It is also possible to
leverage existing, well-known systems like TOMOYO, AppArmor,
SELinux, GRSEC, etc. with Docker.

While Docker currently only enables capabilities, it doesn’t
interfere with the other systems. This means that there are
many different ways to harden a Docker host. Here are a few
examples.

* You can run a kernel with GRSEC and PAX. This adds many
  safety checks, both at compile-time and run-time; it also
  defeats many exploits, thanks to techniques like address
  randomization. It doesn’t require Docker-specific
  configuration, since those security features apply
  system-wide, independent of containers.
* If your distribution comes with security model templates
  for Docker containers, you can use them out of the box.
  For instance, we ship a template that works with AppArmor
  and Red Hat comes with SELinux policies for Docker. These
  templates provide an extra safety net (even though it
  overlaps greatly with capabilities).
* You can define your own policies using your favorite
  access control mechanism.

Just as you can use third-party tools to augment Docker
containers, including special network topologies or shared
filesystems, tools exist to harden Docker containers without
the need to modify Docker itself.



# Overview

Docker is an open platform for developing, shipping, and
running applications. Docker enables you to separate your
applications from your infrastructure so you can deliver
software quickly. With Docker, you can manage your
infrastructure in the same ways you manage your
applications.

Docker provides the ability to package and run an
application in a loosely isolated environment called a
container.

Docker Engine is a client-server application with these
major components:

* A server which is a type of long-running program called a
  daemon process (the `dockerd` command).
  * The Docker daemon (dockerd) listens for Docker API
    requests and manages Docker objects such as images,
    containers, networks, and volumes. A daemon can also
    communicate with other daemons to manage Docker
    services.
* A REST API which specifies interfaces that programs can
  use to talk to the daemon and instruct it what to do.
* A command line interface (CLI) client (the `docker`
  command).
  * The CLI uses the Docker REST API to control or interact
    with the Docker daemon through scripting or direct CLI
    commands.
  * The Docker client (docker) is the primary way that many
    Docker users interact with Docker. When you use commands
    such as docker run, the client sends these commands to
    dockerd, which carries them out. The docker command uses
    the Docker API. The Docker client can communicate with
    more than one daemon.


A Docker registry stores Docker images. Docker Hub is a
public registry that anyone can use, and Docker is
configured to look for images on Docker Hub by default. You
can even run your own private registry.

When you use the docker pull or docker run commands, the
required images are pulled from your configured registry.
When you use the docker push command, your image is pushed
to your configured registry.


## Docker technology

Docker is written in go and takes advantage of several
features of the Linux kernel to deliver its functionality.

### Docker creates a set of namespaces for that container.

These namespaces provide a layer of isolation. Each aspect
of a container runs in a separate namespace and its access
is limited to that namespace.

Docker Engine uses namespaces such as the following on Linux:

* The pid namespace: Process isolation (PID: Process ID).
* The net namespace: Managing network interfaces (NET: Networking).
* The ipc namespace: Managing access to IPC resources (IPC: InterProcess Communication).
* The mnt namespace: Managing filesystem mount points (MNT: Mount).
* The uts namespace: Isolating kernel and version identifiers. (UTS: Unix Timesharing System).

### Control groups

Docker Engine on Linux also relies on another technology
called control groups (cgroups). A cgroup limits an
application to a specific set of resources. Control groups
allow Docker Engine to share available hardware resources to
containers and optionally enforce limits and constraints.
For example, you can limit the memory available to a
specific container.

### Union file systems

Union file systems, or UnionFS, are file systems that
operate by creating layers, making them very lightweight and
fast. Docker Engine uses UnionFS to provide the building
blocks for containers. Docker Engine can use multiple
UnionFS variants, including AUFS, btrfs, vfs, and
DeviceMapper.

### Container format

Docker Engine combines the namespaces, control groups, and
UnionFS into a wrapper called a container format. The
default container format is libcontainer. In the future,
Docker may support other container formats by integrating
with technologies such as BSD Jails or Solaris Zones.


## Docker objects

When you use Docker, you are creating and using docker objects:
* images, 
  * An image is a read-only template with instructions for
    creating a Docker container. 
  * Often, an image is based on another image, with some
    additional customization. 
  * To build your own image, you create a Dockerfile with a
    simple syntax for defining: 
    * the steps needed to create the image and run it. 
    * Each instruction in a Dockerfile creates a layer in the image. 
    * When you change the Dockerfile and rebuild the image,
      only those layers which have changed are rebuilt. 
* containers, 
  * A container is a runnable instance of an image.
  * You can create, start, stop, move, or delete a container using the Docker API or CLI
  * You can connect a container to one or more networks
  * attach storage to it, 
  * or even create a new image based on its current state.
  * You can control how isolated a container’s network,
    storage, or other underlying subsystems are from other
    containers or from the host machine.
  * A container is defined by:
    * its image 
    * as well as any configuration options you provide to it when you create it
    * and when you start it.
* services
  * Services allow you to scale containers across multiple
    Docker daemons, which all work together as a swarm with
    multiple managers and workers.
  * Each member of a swarm is a Docker daemon
  * all the daemons communicate using the Docker API
  * A service allows you to define the desired state, such
    as the number of replicas of the service that must be
    available at any given time. 
  * By default, the service is load-balanced across all
    worker nodes. 
  * To the consumer, the Docker service appears to be a
    single application.
* networks, 
* volumes, 
* plugins, 
* other

# Linux namespaces and cgroups

[Interesting slides](https://fr.slideshare.net/jpetazzo/anatomy-of-a-container-namespaces-cgroups-some-filesystem-magic-linuxcon)

Two things:

* **cgroup**: Control Groups provide a mechanism for
  aggregating/partitioning sets of tasks, and all their
  future children, into hierarchical groups with specialized
  behaviour.
* **namespace**: wraps a global system resource in an
  abstraction that makes it appear to the processes within
  the namespace that they have their own isolated instance
  of the global resource.

**cgroups** limits the resources which a process or set of
processes can use these resources could be
CPU,Memory,Network I/O or access to filesystem while
**namespace** restrict the visibility of group of processes
to the rest of the system. (`chroot` change root directory
`\` into something..., doing with better isolation: `jchroot` [(source at github)](https://github.com/vincentbernat/jchroot))

**Namespaces**: provides process isolation, complete isolation
of containers, separate file system. There are 6 types:

1. mount ns - for file system.
2. UTS(Unique time sharing) ns- which checks for different
   hostnames of running containers
3. IPC ns - interprocess communication
4. Network ns- takes care of different ip allocation to different containers
5. PID ns - process id isolation
6. user ns- different username(uid)

## cgroups

[cgroup nr 1 resource](https://man7.org/linux/man-pages/man7/cgroup_namespaces.7.html)

[Few cgroups administration examples are here.](https://fr.slideshare.net/kerneltlv/namespaces-and-cgroups-the-basis-of-linux-containers)


https://www.linuxjournal.com/content/everything-you-need-know-about-linux-containers-part-i-linux-control-groups-and-process

cgroups do:
* resources metering
* resources limiting
* device node access control

resources are:
* memory
* cpu
* blockIO
* network (*)

When child process is created it is put in the same cgroup

cgroups can be created, and process can be assigned to it:

```console
$ # to create, mkdir in /sys/fs/cgroup
$ sudo mkdir /sys/fs/cgroup/mygroup
$ # to assign current (bash) process to mygroup
$ echo $$ > /sys/fs/cgroup/mygroup/tasks
```

## namespaces

**One may create customized namespace** of each type and
assign processes there.

* Namespacess provides processes with their own view of the
  system.
* Each process is in (at least) one namespace of each type.
* `clone` system call creates new process and new namespace
* `unshare` system call create new namespace and attaches
  calling process to it. (`man 1 unshare`, `man 1 nsenter`)
* `setns` system call attaches calling process to existing
  namespace
* Namespaces can be accessed from system by pseudo-files in
  `ls -al /proc/<pid>/ns`
* when last namespace process exits, namespace is destroyed
  (can be configured to be preserved also)




## PID namespace

For pid namespace: 
* processes within (concrete) PID namespace 
  only see processes in the same PID namespace.
* (concrete) PID namespace has its onw numbering (starting at 1)
* when PID 1 terminates, all processes in namespace terminates
* **PID namespaces can be nested**
* a process ends up having multiple PIDs 
  (one per namespace in which it is **nested**)

## net namespace

Processes inside netns get their own network stack:

* network interfaces (including `lo`)
* routing tables
* iptables rules
* sockets (`ss`, `netstat`)
* loopback device
* ...

The default initial network namespace - init_net -
includes loopback device, all physical devices,
the network tables, etc.

This namespace works as fallows
* a network device belongs to exactly one netns
* a socket belongs to exactly one netns
* each newly created network namespace includes only
  loopback device

Example creating new network namespaces:

```console
$ # Create netns named 'myns1'
$ # internally calls unshare syscall with CLONE_NEW_NET flag
$ sudo ip netns add myns1
$ ls /var/run/netns/myns1
/var/run/netns/myns1
$ # Create netns named 'myns2'
$ # internally calls unshare syscall with CLONE_NEW_NET flag
$ ip netns add myns2
$ ls /var/run/netns/myns2
/var/run/netns/myns2
$ # To list netns
$ ip netns list
myns2
myns1
$ # delate netns
$ sudo ip netns del myns2
$ ip netns list
$ # To move netword interface to some netns:
$ ip link set eth0 netns myns1
$ # To start process in new netns:
$ ip netns exec myns1 bash
$ sudo ip netns del myns1
```


## mnt namespace

Customization gives:
* processes can have their own root namespace (`/`)
* private mounts
  * `/tmp` per process
  * masking other namespaces (`/sys`, `/proc`)
* mounts totally private or shared

Behaviour is as fallows:
* In the new mount namespace, all previous mounts will be visible
* and from now on mounts and unmounts in that mount namespace are
  invisible to the rest of the system
* mounts/unmounts in the global namespace are visible in
  that namespace


## uts namespace

For hostname (`gethostname`, `sethostname`)
and uname

## ipc namespace

Allows processes belonging to ipcns have own:
* (OS) semaphores
* message queues
* shared memory


## user namespace

Allows to map user id (UID) or group id (GID) ranges,
for example:
* UID 0 to 2000 in container can be mapped to 10000 to 12000
  at host (normally)
* UID 0 (root) in container mapped to non-privileged user

Also:
* each process will have different set of UIDs, GIDs, capabilities
* user namespace allows non root user to create process in
  which it will be root (this is basis for unprivilaged
  containers)



# Running Container

**Fundamentally, a container is nothing but a running process**,
who can spawn child processes who will inheirait container isolation.
So to get into container (isolated space) one can run bash as pid 1,
then spawn ssh server, than spawn other processes, services, servers,
than client can login to ssh server (by TCP and usuall port 22) 
using ssh client and than it have remote bash.

Container (root process) have: 
* some added encapsulation features applied to it in
  order to: 
  * keep it isolated from the host 
  * keep it isolated from from other containers. 
* each container interacts with its own
  private filesystem (provided by a Docker image) containing:
  * everything needed to run an application:
    * the code or binary, 
    * runtimes, 
    * dependencies,
    * and any other filesystem objects required.


## Dockerfile = image prescription

Dockerfiles describe how to assemble a private filesystem
for a container, and can also contain some metadata
describing how to run a container based on this image.

Image is complete binary file (snapshot), as a program executable
file.

When image is executed it became container, as procces in OS.

## Isolation realization

Behind the scenes Docker creates a set of namespaces and
control groups for the container.

# Example build and run

## Running container control flow

The following command runs an ubuntu container, attaches
interactively to your local command-line session, and runs
`/bin/bash`.

```console
$ docker run -i -t ubuntu /bin/bash
```

When you run this command, the following happens (assuming
you are using the default registry configuration):

* If you do not have the ubuntu image locally, Docker pulls
  it from your configured registry, as though you had run
  docker pull ubuntu manually.
* Docker creates a new container, as though you had run a
  docker container create command manually.
* Docker allocates a read-write filesystem to the container,
  as its final layer. This allows a running container to
  create or modify files and directories in its local
  filesystem.
* Docker creates a network interface to connect the
  container to the default network, since you did not
  specify any networking options. This includes assigning an
  IP address to the container. By default, containers can
  connect to external networks using the host machine’s
  network connection.
* Docker starts the container and executes /bin/bash.
  Because the container is running interactively and
  attached to your terminal (due to the -i and -t flags),
  you can provide input using your keyboard while the output
  is logged to your terminal.
* When you type exit to terminate the /bin/bash command, the
  container stops but is not removed. You can start it again
  or remove it.

## Example

```console
$ # we are in root folder of project 
$ # containing Dockerfile
$ # needed to build image
$ docker build --tag bulletinboard:1.0 .
Sending build context to Docker daemon  45.57kB
...
Successfully built f2fa022600e1
Successfully tagged bulletinboard:1.0
$ # To list local images:
$ sudo docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
bulletinboard       1.0                 f2fa022600e1        4 hours ago         183MB
node                current-slim        bff5da27561f        2 weeks ago         167MB
$ # to see layers of image, its history:
$ sudo docker history bulletinboard:1.0
...
$ # To run image, with port mapping 8000 (OS) to 8080 (inside docker)
$ # run in background (--detach), labeled (named) as bb
$ sudo docker run --publish 8000:8080 --detach --name bb bulletinboard:1.0
6c2959ea015b7cfad0009f2c1d46b7b8c78f216a2c90e9db34fc938981a515d5
$ # now conteinarized process can be used
$ # when not needed, stop (kill) it and remove container
$ sudo docker rm --force bb
bb
```



# Docker image building

To remember:
* Every `RUN` command in dockerfile creates layer
  * One RUN command including multiple shell commands
    also creates one layer
* base images can be changed (using multistage builds)
  * Starting with big base image, switching to smaller
    image and copying from earlier images creates image
    based on last (smaller image)
* Similar images may by based on (custom) base image
* Debugging image may be based on production image
  (runtime in debugging does not need development dependencies
  from point of view of process, sources, source maps may be 
  external).
* It is advised to explicitly tag images... (name+tag)
* It is advised to use volumes (or bind mounts for devel)
  for storing application data
  * maybe for memory database (SQLite)?...
  * is it include dynamic configuration files?
  * it is used for build folders when developing (images are
    read only, so any change to source would need to build
    updated image)
* In production, it is advised to use `secrets` for
  sensitive app data and `configs` for non-sensitive data
  (configuration) files
* `docker build` copies every file from context_folder
  (which is `cwd` by default) to `dokerd`, to not copy not
  neccessary files one can use:
  * changed `cwd` folder by 
    `$ docker build -f path/to/Dockerfile path/to/context_folder ...`
  * use `.dockerignore` file specifying what to
    include/ignore as context_folder contents
  * use hyphen (`-`) as Dockerfile path, this means to `docker build`
    that Dockerfile will come from stdin (or pipe) and defauld build
    context is set to empty (this could be overriden by specifying
    `-f` flag, e.g. <br/>
    * `$ echo -e 'FROM busybox' | docker build -f- path_to_context`  
    * `$ docker build -f- path_to_context <file_redirected_to_stdin`) 
* if your build contains several layers, you can order them
  from the less frequently changed (to ensure the build
  cache is reusable) to the more frequently changed:
  * Install tools you need to build your application
  * Install or update library dependencies
  * Generate your application
* Only the following instructions create layers 
  * RUN, 
  * COPY, 
  * ADD . 
* Other instructions create temporary intermediate images,
  and do not increase the size of the build.


# Dockerfile format

```Dockerfile
########################################
# Mandatory parent image
########################################
# synthax:
# FROM [--platform=<platform>] <image> [AS <name>]

# Dockerfile must start by stating parent image:
FROM parent_image

########################################
# Labels (metadata of images, containers, ...)
########################################
# laybel key may contain:
# lower case letters, numbers, dots and hyphens 
# consequtive dots or hypens are not allowed,
# label key must start with letter.
# Laybels keys must be unique, so unique prefix
# is advised.
# Ouner of domains, or some unique name shoud use it.
# for example, having domain
# http://www.company.com than:
LABEL com.company.version="0.0.1-beta"
LABEL com.company.vendor1="ACME Incorporated"
LABEL com.company.vendor2=ZENITH\ Incorporated
LABEL com.company.release-date="2015-02-12"
LABEL com.company.version.is-production=""


########################################
# Env variables and build arguments
########################################
# declare env variable foo
# with value /bar
ENV foo /bar

# enviroment variables can be used as in shell:
USER ${user:-some_user}
# Dockerfile may use arguments, they are injected
# when explicitly used ARG command, they may have
# default values provided additionally.
# ARG is scoped to build stage
# To use an arg in multiple stages,
# each stage must include the ARG instruction.
ARG user=default_user
# when Dockerfile is used by following build
# $ docker build --build-arg user=what_user .
# below $user is expanded to what_user
USER $user


########################################
# Running commands
########################################
# The RUN instruction will execute any commands 
# * in a new layer 
# * on top of the current image 
# * and commit the results. 
# The resulting committed image will be used for the 
# next step in the Dockerfile.
# shell synthax:
# RUN <command>
# is translated to:
# $ /bin/sh -c command
RUN /bin/bash -c 'source $HOME/.bashrc; \
echo $HOME'
# equivalently:
RUN /bin/bash -c 'source $HOME/.bashrc; echo $HOME'
# exec synthax:
# RUN ["executable", "param1", "param2"]
# Unlike the shell form, the exec form 
# does not invoke a command shell.
RUN ["/bin/bash", "-c", "echo hello"]

########################################
# Installing software
########################################
# enable pipe fail swith in shell!!:
#   set -o pipefail
# wget - The non-interactive network downloader.
#   -O -  # output file to stdout (-) (for pipe)
# wc - words count
# map stdout to file /number
#   > /number  
RUN set -o pipefail && wget -O - https://some.site | wc -l > /number

########################################
# Installing software
########################################
# use multiline (one RUN = one layer)
RUN apt-get update && apt-get install -y \
    aufs-tools \
    automake \
    build-essential \
    curl \
    dpkg-sig \
    libcap-dev \
    libsqlite3-dev \
    mercurial \
    reprepro \
    ruby1.9.1 \
    ruby1.9.1-dev \
    s3cmd=1.1.* \
 && rm -rf /var/lib/apt/lists/*



########################################
# How to execute container? (CMD)
########################################

# exec form:
# The exec form is parsed as a JSON array, 
# which means that you must use double-quotes (“) 
# around words not single-quotes (‘).
# CMD ["executable","param1","param2"]

# shell form:
# CMD command param1 param2

# default parameters to ENTRYPOINT
# CMD ["param1","param2"]
CMD ["apache2","-DFOREGROUND"]

########################################
# EXPOSE (ports on which a container 
#         listens for connections)
########################################

EXPOSE 80

########################################
# ENV (declare/connect to env variables)
########################################

# e.g. ensure that nginx is on the path:
ENV PATH /usr/local/nginx/bin:$PATH
# define some constants
ENV PG_MAJOR 9.3
ENV PG_VERSION 9.3.4

# setting/unsetting env vars must be done
# in the same layer!!!!!!!! eg:
RUN export ADMIN_USER="mark" \
    && echo $ADMIN_USER > ./mark \
    && unset ADMIN_USER
CMD sh

########################################
# COPY (copy files from build context)
########################################
# COPY files individually, rather than all at once. 
# This ensures that each step’s build cache is only 
# invalidated (forcing the step to be re-run) 
# if the specifically required files change.
COPY requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt
COPY . /tmp/

########################################
# ENTRYPOINT (allaws container to take params)
########################################
# ENTRYPOINT is to set the image’s main command, 
# allowing that image to be run as though it was 
# that command (and then use CMD as the default flags).

ENTRYPOINT ["s3cmd"]
CMD ["--help"]

# default action: s3cmd --help
# $ docker run s3cmd
# provide commands to execute: s3cmd commands.sh.s3
# $ docker run s3cmd commands.sh.s3

########################################
# VOLUME (mutable storage)
########################################
# The VOLUME instruction should be used to expose:
# * any database storage area, 
# * configuration storage, 
# * or files/folders created by your docker container. 

# You are strongly encouraged to use VOLUME for any:
# * mutable and/or 
# * user-serviceable parts of your image.

########################################
# USER (non-privileged execution)
########################################
# If a service can run without privileges, 
# use USER to change to a non-root user. 
# Start by creating the user and group in the 
# Dockerfile with something like 
# RUN groupadd -r postgres && useradd --no-log-init -r -g postgres postgres.


```



# Dockerd resources management

## Clean up unused

```console
$
$
$ docker system prune --volumes

WARNING! This will remove:
        - all stopped containers
        - all networks not used by at least one container
        - all volumes not used by at least one container
        - all dangling images
        - all build cache
Are you sure you want to continue? [y/N] y
$
$
$ docker image prune

WARNING! This will remove all dangling images.
Are you sure you want to continue? [y/N] y
$
$ # To remove all images which are not used by existing containers
$ docker image prune -a

WARNING! This will remove all images without at least one container associated to them.
Are you sure you want to continue? [y/N] y
$ docker image prune -a --force --filter "until=24h"
$
$
$ docker container prune

WARNING! This will remove all stopped containers.
Are you sure you want to continue? [y/N] y
$ docker container prune --force --filter "until=24h"
$
$
$ docker volume prune

WARNING! This will remove all volumes not used by at least one container.
Are you sure you want to continue? [y/N] y
$ docker volume prune --force --filter "label!=keep"
$
$
$ docker network prune

WARNING! This will remove all networks not used by at least one container.
Are you sure you want to continue? [y/N] y
```

# Docker daemon

## Configuration

Two options:
* use command line args for `dockerd`
* use config file `/etc/docker/daemon.json`

For example:

```json
{
  "debug": true,
  "tls": true,
  "tlscert": "/var/docker/server.pem",
  "tlskey": "/var/docker/serverkey.pem",
  "hosts": ["tcp://192.168.59.3:2376"]
}
```

Equivalently:

```sh
dockerd --debug \
  --tls=true \
  --tlscert=/var/docker/server.pem \
  --tlskey=/var/docker/serverkey.pem \
  --host tcp://192.168.59.3:2376
```

`systemd` starts `dockerd` with default host (unix socket),
this will conflict with shell or json specifying
host. One may need to change `systemd` config in
`/etc/systemd/system/docker.service.d/docker.conf`

```systemd
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd
```

To refresh `systemd`:

```console
$ sudo systemctl daemon-reload
```


## Directories (data, logs)

Important directories:

* persisted data:
  * `/var/lib/docker` : images, containers, networsks,
    volumes, etc.
* logs:
  * `journalctl -u docker.service` : ubuntu
  * `/var/log/syslog` : ubuntu
* systemd dockerd
  * `/etc/systemd/system/docker.service.d` 
  * `/etc/systemd/system` 


## Debugging

Debugging can be enabled by config file or command
line arg to `systemd -D`.

```json
{
  "debug": true,
  "log-level": "debug"
}
```
equivalently:

```console
$ sudo systemctrl stop docker
$ sudo docker -D
$ # If the daemon is unresponsive, you can force a 
$ # full stack trace to be logged using SIGUSR1:
$ sudo kill -SIGUSR1 $(pidof dockerd)
```

## Logs

To see logs:

```console
$ journalctl -u docker.service
-- Logs begin at Fri 2020-04-24 21:19:05 CEST, end at Sun 2020-07-19 22:00:26 CEST. --
lip 17 01:15:42 mk-Lenovo-G780 systemd[1]: Starting Docker Application Container Engine...
lip 17 01:15:42 mk-Lenovo-G780 dockerd[3258]: time="2020-07-17T01:15:42.685121881+02:00" level=info msg="Starting up"

$ # look for starts, stacks, or something...
$ journalctl -u docker.service | grep "start"
lip 17 01:15:43 mk-Lenovo-G780 dockerd[3258]: time="2020-07-17T01:15:43.066295889+02:00" level=info msg="Loading containers: start."
lip 18 11:16:25 mk-Lenovo-G780 dockerd[18883]: time="2020-07-18T11:16:25.566075635+02:00" level=info msg="Loading containers: start."
lip 19 00:57:15 mk-Lenovo-G780 dockerd[6626]: time="2020-07-19T00:57:15.710596848+02:00" level=info msg="Loading containers: start."
```

## Is service running

```console
$ docker info
Client:
 Debug Mode: false

Server:
 Containers: 2
  Running: 0
  Paused: 0
  Stopped: 2
 Images: 8
 Server Version: 19.03.6
 Storage Driver: overlay2
  Backing Filesystem: extfs
  Supports d_type: true
  Native Overlay Diff: true
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog

$ sudo systemctl is-active docker
active
$ $ sudo service docker status
● docker.service - Docker Application Container Engine
   Loaded: loaded (/lib/systemd/system/docker.service; disabled; vendor preset: enabled)
   Active: active (running) since Sun 2020-07-19 22:13:58 CEST; 1min 5s ago
     Docs: https://docs.docker.com
 Main PID: 676 (dockerd)
    Tasks: 16
   CGroup: /system.slice/docker.service
           └─676 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock

lip 19 22:13:55 mk-Lenovo-G780 dockerd[676]: time="2020-07-19T22:13:55.105745800+02:00" level=warning msg="Your kernel does not support swap memory limit"
lip 19 22:13:55 mk-Lenovo-G780 dockerd[676]: time="2020-07-19T22:13:55.105798726+02:00" level=warning msg="Your kernel does not support cgroup rt period"
lip 19 22:13:55 mk-Lenovo-G780 dockerd[676]: time="2020-07-19T22:13:55.105807827+02:00" level=warning msg="Your kernel does not support cgroup rt runtime"
lip 19 22:13:55 mk-Lenovo-G780 dockerd[676]: time="2020-07-19T22:13:55.105993654+02:00" level=info msg="Loading containers: start."
lip 19 22:13:56 mk-Lenovo-G780 dockerd[676]: time="2020-07-19T22:13:56.731045272+02:00" level=info msg="Default bridge (docker0) is assigned with an IP address 172.17.0.0/
lip 19 22:13:57 mk-Lenovo-G780 dockerd[676]: time="2020-07-19T22:13:57.058580880+02:00" level=info msg="Loading containers: done."
lip 19 22:13:58 mk-Lenovo-G780 dockerd[676]: time="2020-07-19T22:13:58.054922848+02:00" level=info msg="Docker daemon" commit=369ce74a3c graphdriver(s)=overlay2 version=19
lip 19 22:13:58 mk-Lenovo-G780 dockerd[676]: time="2020-07-19T22:13:58.088219405+02:00" level=info msg="Daemon has completed initialization"
lip 19 22:13:58 mk-Lenovo-G780 dockerd[676]: time="2020-07-19T22:13:58.336534870+02:00" level=info msg="API listen on /var/run/docker.sock"
lip 19 22:13:58 mk-Lenovo-G780 systemd[1]: Started Docker Application Container Engine.


```

## dockerd remote access and proxy support

For proxy configuration create a file named 
`/etc/systemd/system/docker.service.d/http-proxy.conf`


```ini
# /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
# this is comment
; it is also comment
; whitechars after '=' are ignored
; Lines ending in a backslash are concatenated with 
; the following line while reading and the backslash 
; is replaced by a space character.
Environment="HTTP_PROXY=http://proxy.example.com:80"
Environment="HTTPS_PROXY=https://proxy.example.com:443"
Environment="NO_PROXY=localhost,127.0.0.1,docker-registry.example.com,.corp"
```

For remote access edit `docker.service` file to include:

```ini
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://127.0.0.1:2375
```

(The `-H fd://` syntax is used when running docker inside of
systemd. Systemd itself will create a socket in the
docker.socket unit file and listen to it, and this socket is
connected to the docker daemon with the `fd://` syntax in the
docker.service unit file.)

Alternatively remote acces can be configured by editing
`/etc/docker/daemon.json` to include:

```json
{
  "hosts": ["unix:///var/run/docker.sock", "tcp://127.0.0.1:2375"]
}
```


Then apply:

```console
$ # create dropdown dir
$ sudo mkdir -p /etc/systemd/system/docker.service.d
$ # flush changes
$ sudo systemctl daemon-reload
$ # restart docker
$ sudo systemctl restart docker
$
$ # Verify that the proxy configuration has been 
$ # loaded and matches the changes made
$ sudo systemctl show --property=Environment docker
    
Environment=HTTP_PROXY=http://proxy.example.com:80 HTTPS_PROXY=https://proxy.example.com:443 NO_PROXY=localhost,127.0.0.1,docker-registry.example.com,.corp
$
$ # Check to see whether the change was honored by 
$ # reviewing the output of netstat to confirm dockerd 
$ # is listening on the configured port.
$ sudo netstat -lntp | grep dockerd
tcp        0      0 127.0.0.1:2375          0.0.0.0:* 
```

## Manual integration with systemd

Below files for service and socket must be
copied to `/etc/systemd/system` . Actual files
can be found at [github](https://github.com/moby/moby/tree/master/contrib/init/systemd)


```ini
# docker.service
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network-online.target docker.socket firewalld.service
Wants=network-online.target
Requires=docker.socket

[Service]
Type=notify
# the default is not to use systemd for cgroups 
# because the delegate issues still
# exists and systemd currently does not support 
# the cgroup feature set required
# for containers run by docker
ExecStart=/usr/bin/dockerd -H fd://
ExecReload=/bin/kill -s HUP $MAINPID
LimitNOFILE=1048576
# Having non-zero Limit*s causes performance 
# problems due to accounting overhead
# in the kernel. We recommend using cgroups 
# to do container-local accounting.
LimitNPROC=infinity
LimitCORE=infinity
# Uncomment TasksMax if your systemd version supports it.
# Only systemd 226 and above support this version.
#TasksMax=infinity
TimeoutStartSec=0
# set delegate yes so that systemd does 
# not reset the cgroups of docker containers
Delegate=yes
# kill only the docker process, not all processes 
# in the cgroup
KillMode=process
# restart the docker process if it exits prematurely
Restart=on-failure
StartLimitBurst=3
StartLimitInterval=60s

[Install]
WantedBy=multi-user.target
```


```ini
# docker.socket
[Unit]
Description=Docker Socket for the API

[Socket]
# If /var/run is not implemented as a symlink to /run, 
# you may need to specify
# ListenStream=/var/run/docker.sock instead.
ListenStream=/run/docker.sock
SocketMode=0660
SocketUser=root
SocketGroup=docker

[Install]
WantedBy=sockets.target
```


# Docker networking

Use cases:

* container communication inside `dockerd` 
  * user defined bridges
* `dockerd` with outside
  * host network - (sharing network stack with machine)
* container communication between `dockerd`
  * overlay networks
* container simulate MAC address:
  * macvlan network

## Disable container networking

To compleatly disable networking, one may use none driver
(`--network none` flag):

```console
$ docker run --rm -dit \
  --network none \
  --name no-net-alpine \
  alpine:latest \
  ash
```


# Bridge network

Docker (software) bridge network is link layer (driver)
device.  --> Device supporting local network addressing
(forwarding), using some transport.

From Wikipedia: 
* The protocols of the link layer operate within
  the scope of the local network connection to which a host is
  attached. 
* The link includes all hosts accessible without traversing a
  router.
* The link layer is used to move packets between the
  Internet layer interfaces of two different hosts on the
  same link.
* MAC address is link layer address

In terms of Docker, a bridge network uses a software bridge
which allows containers connected to the same bridge network
to communicate, while providing isolation from containers
which are not connected to that bridge network. The Docker
bridge driver automatically installs rules in the host
machine so that containers on different bridge networks
cannot communicate directly with each other.

Bridge networks apply to containers running on the same
Docker daemon host.

When you start Docker:, 
* a default bridge network (also called bridge) is created automatically, and 
* newly-started containers connect to it unless otherwise specified. 
* You can also create user-defined custom bridge networks. 
* User-defined bridge networks are superior to the default bridge network.

## Mechanizm

When you create or remove a user-defined bridge or connect
or disconnect a container from a user-defined bridge, Docker
uses tools specific to the operating system to manage the
underlying network infrastructure (such as adding or
removing bridge devices or configuring iptables rules on
Linux).


## Default bridge network:

Default bridge network:

* allows only IP addressing (no container aliases, etc)
  * aliases can be supported but container must be configured
    with `--link` options
* provides no network isolation between containers
* every container have the same MTU (Maximum Transmission
  Unit) and iptables rules
* Linked containers on the default bridge network share
  environment variables

To configure the default bridge network, you specify options
in daemon.json e.g.:

```json
{
  "bip": "192.168.1.5/24",
  "fixed-cidr": "192.168.1.5/25",
  "fixed-cidr-v6": "2001:db8::/64",
  "mtu": 1500,
  "default-gateway": "10.20.1.1",
  "default-gateway-v6": "2001:db8:abcd::89",
  "dns": ["10.20.1.2","10.20.1.3"]
}
```

## User defined bridge network

For user-defined bridge network:

* Containers can resolve each other by name or alias.
  * For example, let system have web service container
    called web and database container called db. Then they
    can refer to web and db as addresses. Using default
    bridge network, configuration must be altered using
    `--link` option for every involved container.
* Unspecified containers are isolated from user def net
* Containers may be dynamically connected/disconnected to
  user def net
* Each user-defined network creates a configurable bridge.
* User-defined bridge networks are created and configured
  using `docker network create`
* Containers connected to the same user-defined bridge
  network effectively expose all ports to each other. 
* For a port to be accessible to containers or non-Docker
  hosts on different networks, that port must be published
  using the `-p` or `--publish` flag.


## Usage

```console
$ # To create user-defined brigde network:
$ docker network create my-net
$ # To create user-defined brigde network (with IPv6 support):
$ docker network create --ipv6 my-net
$ # To remove user-defined brigde network:
$ docker network rm my-net
$ # To get help:
$ docker network create --help
$ # create container and connect it to network:
$ #   --publish 8080 (dockerd port): 80 (container port)
$ docker create --name my-nginx \
  --network my-net \
  --publish 8080:80 \
  nginx:latest
$ # at runtime container may be connected to network by:
$ docker network connect my-net my-nginx
$ # at runtime container may be disconnected to network by:
$ docker network disconnect my-net my-nginx
$ # To enable forwarding from Docker containers 
$ # to the outside:
$ #    1. Configure the Linux kernel to allow IP forwarding.
$ #    2. Change the policy for the iptables FORWARD policy 
$ #       from DROP to ACCEPT
$ # (this is not preserved on reboot)
$ sysctl net.ipv4.conf.all.forwarding=1
$ sudo iptables -P FORWARD ACCEPT
```

# Docker overlay networks

...

# Docker macvlan network

```console
$ docker network create -d macvlan \
  --subnet=192.168.32.0/24 \
  --ip-range=192.168.32.128/25 \
  --gateway=192.168.32.254 \
  --aux-address="my-router=192.168.32.129" \
  -o parent=eth0 macnet32

```



# Docker Bridge network tutorial


Lets perform few steps:

* run two containers
* list running containers
* inspect bridge network
* attach console to alpine1 container
* check configured ip addresses (it should have ip `172.17.0.2/16`), 
* ping google.com, 
* ping alpine2 container at address `172.17.0.3/16`
* detach console from alpine1 (`ctrl+p ctrl+q`)
* stop alpine1 and alpine2
* remove alpine1 and alpine2

```console
$ # Run 2 containers.
$ # -dit flag :
$ #    d : detached, run in background
$ #    i : interactive, ability to type into container
$ #    t : output to TTY
$ # --name x : x is now name of the container
$ # alpine   : is image
$ # ash      : image main command arg - run (b)ash
$ docker run -dit --name alpine1 alpine ash
$ docker run -dit --name alpine2 alpine ash
$ 
$ # list running containers
$ docker container ls
$ 
$ # Inspect the bridge network to see 
$ # what containers are connected to it
$ docker network inspect bridge
$ # importan things for now is:
$ # 
$ #   "Subnet": "172.17.0.0/16",
$ #   "Gateway": "172.17.0.1"
$ # 
$ #   "MacAddress": "02:42:ac:11:00:02",
$ #   "IPv4Address": "172.17.0.2/16",
$ #
$ #   "MacAddress": "02:42:ac:11:00:03",
$ #   "IPv4Address": "172.17.0.3/16",
$ 
$ docker attach alpine1
/ # 
/ # 
/ # ip addr show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
5: eth0@if6: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP 
    link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever
/ # 
/ # 
/ # ping -c 2 google.com
PING google.com (216.58.209.14): 56 data bytes
64 bytes from 216.58.209.14: seq=0 ttl=117 time=26.233 ms
64 bytes from 216.58.209.14: seq=1 ttl=117 time=19.789 ms

--- google.com ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 19.789/23.011/26.233 ms
/ # 
/ # 
/ # ping -c 2 172.17.0.3
PING 172.17.0.3 (172.17.0.3): 56 data bytes
64 bytes from 172.17.0.3: seq=0 ttl=64 time=0.214 ms
64 bytes from 172.17.0.3: seq=1 ttl=64 time=0.142 ms

--- 172.17.0.3 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 0.142/0.178/0.214 ms
/ # 
/ # read escape sequence
$
$ # stop containers and than remove them
$ docker container stop alpine1 alpine2
$ docker container rm alpine1 alpine2
```

# Docker container not isolated from network tutorial

It is called host network in docker language.


```console
$ # run (or restart if running) container (docker run --rm option)
$ docker run --rm -d --network host --name my_nginx nginx
e842323bd29ea05c606e5df4f2f2889dc94f6ce061f7198450a6a55a5342e72d
$
$ # Access Nginx by browsing to http://localhost:80/.
$ 
$ # show system network interfaces
$ ip addr show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 
   qdisc noqueue state UNKNOWN group default qlen 1000
      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
      inet 127.0.0.1/8 scope host lo
         valid_lft forever preferred_lft forever
      inet6 ::1/128 scope host 
         valid_lft forever preferred_lft forever
2: enp2s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 
   qdisc mq state DOWN group default qlen 1000
      link/ether 20:89:84:9e:69:15 brd ff:ff:ff:ff:ff:ff
3: wlp3s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 
   qdisc noqueue state UP group default qlen 1000
      link/ether 24:fd:52:75:64:8d brd ff:ff:ff:ff:ff:ff
      inet 192.168.0.192/24 brd 192.168.0.255 
        scope global dynamic noprefixroute wlp3s0
         valid_lft 72917sec preferred_lft 72917sec
      inet6 2a02:a31a:a13c:b480:6e82:5aea:4ee5:f551/64 
        scope global dynamic noprefixroute 
         valid_lft 1111556sec preferred_lft 506756sec
      inet6 fe80::672e:3dc6:4e73:a985/64 scope link noprefixroute 
         valid_lft forever preferred_lft forever
4: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 
   qdisc noqueue state DOWN group default 
      link/ether 02:42:9f:65:85:cc brd ff:ff:ff:ff:ff:ff
      inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
         valid_lft forever preferred_lft forever
$ 
$ # Show processes network interfaces (sockets) using netstat:
$ #   -t : TCP addresses
$ #   -u : UDP addresses
$ #   -l : show only listening sockets
$ #   -p : process pid and name to which socket belongs
$ #   -n : numerical value of address 
$ #        (instead of host:port or user names)
$ # and filter to lines containing port :80
$ sudo netstat -tulpn | grep :80
tcp   0 0 0.0.0.0:80  0.0.0.0:* LISTEN 25326/nginx: master 
tcp6  0 0 :::80       :::*      LISTEN 25326/nginx: master
$ # Proto Recv-Q Send-Q Loc_addr Foreign_addr State PID/Prog_name
$
$ sudo netstat -tulpn
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local_Address Foreign_Address State PID/Prog_name    
tcp  0 0 127.0.0.1:42377 0.0.0.0:* LISTEN 1877/containerd  
tcp  0 0 127.0.0.1:3306  0.0.0.0:* LISTEN 1976/mysqld   
tcp  0 0 127.0.0.53:53   0.0.0.0:* LISTEN 961/systemd-resolve 
tcp  0 0 127.0.0.1:631   0.0.0.0:* LISTEN 13043/cupsd   
tcp6 0 0 :::80           :::*      LISTEN 25326/nginx: master  
tcp6 0 0 :::1716         :::*      LISTEN 3374/kdeconnectd 
tcp6 0 0 ::1:631         :::*      LISTEN 13043/cupsd   
udp  0 0 0.0.0.0:631     0.0.0.0:*        13045/cups-browsed  
udp  0 0 0.0.0.0:5353    0.0.0.0:*        1423/avahi-daemon:  
udp  0 0 0.0.0.0:38602   0.0.0.0:*        1423/avahi-daemon:  
udp  0 0 127.0.0.53:53   0.0.0.0:*        961/systemd-resolve 
udp  0 0 0.0.0.0:68      0.0.0.0:*        2784/dhclient    
udp6 0 0 :::5353         :::*             1423/avahi-daemon:  
udp6 0 0 :::1716         :::*             3374/kdeconnectd 
udp6 0 0 :::50904        :::*             1423/avahi-daemon:
$
$ # stop container (it will also remove because 
$ # it started container was run with --rm) 
$ docker container stop my_nginx
my_nginx
```









