
# Offers

## Senior regular .net

[NBC Sp. z o. o. .Net Developer Regular/Senior](https://it-leaders.pl/oferta-pracy/net-developer-regular-senior-krakow-1311)

Budujemy 7-osobowy zespół w Naszym krakowskim teamie:)
Dołącz do Nas :)

Wyzwania, jakie czekają na Ciebie na w/w stanowisku:

* będziesz odpowiedzialny/a za projekt rozwoju systemu do
  realizacji procesu KYC w Banku,
* współudział w tworzeniu architektury aplikacji,
* tworzenie nowych oraz konserwacja już funkcjonujących
  modułów oprogramowania zgodnie z dostarczoną specyfikacją,
* tworzenie dokumentacji technicznej,
* uczestniczenie we wdrożeniach systemów informatycznych,
* współpraca z doświadczonymi programistami,
* możliwość pracy zdalnej - 4 dni w miesiącu.

Dobrze odnajdziesz się w tej roli jeśli posiadasz:

* praktyczną znajomość C#, js, .NET Core,
* znajomość HTML5, CSS3, TypeScript, Bootstrap,
* znajomość przynajmniej jednego z narzędzi: Angular, Vue,
  React,
* znajomość ORM mappers (Entity Framework, Dapper, lub
  NHibernate),
* znajomość SQL Server 2012+,
* znajomość ’Clean Code’, ’SOLID’,
* język angielski na poziomie pozwalającym czytanie
  dokumentacji technicznej.

Mile widziane:

* doświadczenie w bankowości/ ubezpieczeniach,
* znajomość RabbitMQ, Elasticsearch.


# javascript communication

Communication methods [(see here)](https://javascript.info/network):

* [WebSocket](https://javascript.info/websocket), 
  * [also on Wikipedia](https://en.wikipedia.org/wiki/WebSocket)
  * AMQP is usually on top of WebSocket (WS: or WSS: )
  * RabbitMQ ...
* [Long polling](https://javascript.info/long-polling)
* [Server Sent Events](https://javascript.info/server-sent-events)


Interesting [comparison on StackOverflow](https://stackoverflow.com/questions/12555043/my-understanding-of-http-polling-long-polling-http-streaming-and-websockets  )






# Docker and asp.net

[Microservices based ecomerce example (by Microsoft)](https://github.com/dotnet-architecture/eShopOnContainers)


Containerization is an approach to software development in
which an application or service, its dependencies, and its
configuration (abstracted as deployment manifest files) are
packaged together as a container image. The containerized
application can be tested as a unit and deployed as a
container image instance to the host operating system (OS).

Containers also isolate applications from each other on a
shared OS. Containerized applications run on top of a
container host that in turn runs on the OS (Linux or
Windows). Containers therefore have a significantly smaller
footprint than virtual machine (VM) images.

For example, Docker may be a container host, containing few
containers:
* Application container
* Service container


The main goal of an image is that it makes the environment
(dependencies) the same across different deployments. This
means that you can debug it on your machine and then deploy
it to another machine with the same environment guaranteed.

A container image is a way to package an app or service and
deploy it in a reliable and reproducible way. You could say
that Docker isn't only a technology but also a philosophy
and a process.

When using Docker, you won't hear developers say, "It works
on my machine, why not in production?" They can simply say,
"It runs on Docker", because the packaged Docker application
can be executed on any supported Docker environment, and it
runs the way it was intended to on all deployment targets
(such as Dev, QA, staging, and production).


## Glossary

[Full glossary can be found here.](https://docs.docker.com/glossary/)

* **Container** image: A package with all the dependencies
  and information needed to create a container. An image
  includes all the dependencies (such as frameworks) plus
  deployment and execution configuration to be used by a
  container runtime. Usually, an image derives from multiple
  base images that are layers stacked on top of each other
  to form the container's filesystem. An image is immutable
  once it has been created.
* **Dockerfile**: A text file that contains instructions for
  building a Docker image. It's like a batch script, the
  first line states the base image to begin with and then
  follow the instructions to install required programs, copy
  files, and so on, until you get the working environment
  you need.
* **Build**: The action of building a container image based
  on the information and context provided by its Dockerfile,
  plus additional files in the folder where the image is
  built.
* **Container**: An instance of a Docker image. A container
  represents the execution of a single application, process,
  or service. It consists of the contents of a Docker image,
  an execution environment, and a standard set of
  instructions. When scaling a service, you create multiple
  instances of a container from the same image. Or a batch
  job can create multiple containers from the same image,
  passing different parameters to each instance.
* **Volumes**: Offer a writable filesystem that the
  container can use. Since images are read-only but most
  programs need to write to the filesystem, volumes add a
  writable layer, on top of the container image, so the
  programs have access to a writable filesystem. The program
  doesn't know it's accessing a layered filesystem, it's
  just the filesystem as usual. Volumes live in the host
  system and are managed by Docker.
* **Tag**: A mark or label you can apply to images so that
  different images or versions of the same image (depending
  on the version number or the target environment) can be
  identified.
* **Multi-stage Build**: Is a feature, since Docker 17.05 or
  higher, that helps to reduce the size of the final images.
  In a few sentences, with multi-stage build you can use,
  for example, a large base image, containing the SDK, for
  compiling and publishing the application and then using
  the publishing folder with a small runtime-only base
  image, to produce a much smaller final image.
* **Repository (repo)**: A collection of related Docker
  images, labeled with a tag that indicates the image
  version. Some repos contain multiple variants of a
  specific image, such as an image containing SDKs
  (heavier), an image containing only runtimes (lighter),
  etc. Those variants can be marked with tags. A single repo
  can contain platform variants, such as a Linux image and a
  Windows image.
* **Registry**: A service that provides access to
  repositories. The default registry for most public images
  is Docker Hub (owned by Docker as an organization). A
  registry usually contains repositories from multiple
  teams. Companies often have private registries to store
  and manage images they've created. Azure Container
  Registry is another example.
* **Multi-arch image**: For multi-architecture, it's a
  feature that simplifies the selection of the appropriate
  image, according to the platform where Docker is running.
  For example, when a Dockerfile requests a base image FROM
  mcr.microsoft.com/dotnet/core/sdk:3.1 from the registry,
  it actually gets 3.1-sdk-nanoserver-1909,
  3.1-sdk-nanoserver-1809 or 3.1-sdk-buster-slim, depending
  on the operating system and version where Docker is
  running.
* **Docker** Hub: A public registry to upload images and
  work with them. Docker Hub provides Docker image hosting,
  public or private registries, build triggers and web
  hooks, and integration with GitHub and Bitbucket.
* **Compose**: A command-line tool and YAML file format with
  metadata for defining and running multi-container
  applications. You define a single application based on
  multiple images with one or more .yml files that can
  override values depending on the environment. After you've
  created the definitions, you can deploy the whole
  multi-container application with a single command
  (docker-compose up) that creates a container per image on
  the Docker host.
* **Cluster**: A collection of Docker hosts exposed as if it
  were a single virtual Docker host, so that the application
  can scale to multiple instances of the services spread
  across multiple hosts within the cluster. Docker clusters
  can be created with Kubernetes, Azure Service Fabric,
  Docker Swarm and Mesosphere DC/OS.
* **Orchestrator**: A tool that simplifies management of
  clusters and Docker hosts. Orchestrators enable you to
  manage their images, containers, and hosts through a
  command-line interface (CLI) or a graphical UI. You can
  manage container networking, configurations, load
  balancing, service discovery, high availability, Docker
  host configuration, and more. An orchestrator is
  responsible for running, distributing, scaling, and
  healing workloads across a collection of nodes. Typically,
  orchestrator products are the same products that provide
  cluster infrastructure, like Kubernetes and Azure Service
  Fabric, among other offerings in the market.

## Workflow

When using Docker, a developer creates an app or service and
packages it and its dependencies into a container image. An
image is a static representation of the app or service and
its configuration and dependencies.

To run the app or service, the app's image is instantiated
to create a container, which will be running on the Docker
host. Containers are initially tested in a development
environment or PC.


Developers should store images in a registry, which acts as
a library of images and is needed when deploying to
production orchestrators. Docker maintains a public registry
via Docker Hub; other vendors provide registries for
different collections of images, including Azure Container
Registry. Alternatively, enterprises can have a private
registry on-premises for their own Docker images.


Developement process will generate 2 images:

* development image: used to develop and build .NET Core apps.
  * You don't deploy this image to production. 
  * Instead, it's an image that you use to build the content
    you place into a production image. 
  * This image would be used in your continuous integration
    (CI) environment or 
  * build environment when using Docker multi-stage builds.
* production image: used to run .NET Core apps.


# Conteined system

Docker may **abstract** boundary between hosts (machines),
for example cluster tool can be configured to:

* clone up to n instances on single machine (server) (because
  for example it has 2*n processors),
* than use other machine in similar way

Also, when there is few communicating images running as containers,
their communication can also be abstracted, making ilusion
of running on same server with great CPU and memory resources.


## Process

In the container model, a container image instance
represents a single process. By defining a container image
as a process boundary, you can create primitives that can be
used to scale the process or to batch it.


When you design a container image, you'll see an [ENTRYPOINT](https://docs.docker.com/engine/reference/builder/#entrypoint)
definition in the Dockerfile. This defines the process whose
lifetime controls the lifetime of the container. When the
process completes, the container lifecycle ends.

If the process fails, the container ends, and the
orchestrator takes over. If the orchestrator was configured
to keep five instances running and one fails, the
orchestrator will create another container instance to
replace the failed process. 


You might find a scenario where you want multiple processes
running in a single container. For that scenario, since
there can be only one entry point per container, you could
run a script within the container that launches as many
programs as needed. For example, you can use Supervisor or a
similar tool to take care of launching multiple processes
inside a single container.

## Monolithic application and dynamic number of copies

A monolithic containerized application include multiple
components, libraries, or internal layers in each container
(working as full app). Most of its functionality is within a
single container, with internal layers or libraries, and
scales out by cloning the container on multiple servers/VMs.

This will also need router for pointing clients to container
instance.

# Dockerized filesystem


## Container lifetime storage

Image is on special filesystem, which when running container process
trap every change to filesystem. 

So container is:
* read only image
* every change to image filesystem is trapped and saved 
  to override layer (which is cached with copy-on-write policy)
  * this layer is called **local storage**
  * this functionality is (probably) implemented as custom filesystem
    (Overlay File System)


Application does not know that is works
with special filesystem.

But local storage is persistent only when container is running.

## Docker Host lifetime storage

Volumes are directories mapped from the host OS to
directories in containers. When code in the container has
access to the directory, that access is actually to a
directory on the host OS. This directory is not tied to the
lifetime of the container itself, and the directory is
managed by Docker and isolated from the core functionality
of the host machine. Thus, data volumes are designed to
persist data independently of the life of the container. If
you delete a container or an image from the Docker host, the
data persisted in the data volume isn't deleted.

Volumes can be named or anonymous (the default). Named
volumes are the evolution of Data Volume Containers and make
it easy to share data between containers. Volumes also
support volume drivers that allow you to store data on
remote hosts, among other options.

## Remote storage (databases, caches)

Types:

* SQL database: SQL Server, PostgreSQL, Oracle
* remote cache like Redis can be used in containerized
  applications the same way they are used when developing
  without containers. This is a proven way to store business
  application data.
* NoSQL databases: MongoDB


# Service-oriented architecture (SOA) 

SOA means that you structure your application by decomposing
it into multiple services (most commonly as HTTP services)
that can be classified as different types like subsystems or
tiers.

Those services can now be deployed as Docker containers.
If so Docker clustering software or an orchestrator can help
with scaling.

# Microservices

Microservices architecture is an approach to building a
server application as a set of small services. That means a
microservices architecture is mainly oriented to the
back-end, although the approach is also being used for the
front end. 

* Each service runs in its own process and
* communicates with other processes using protocols such as:
  * HTTP/HTTPS, 
  * WebSockets, or 
  * Advanced Message Queuing Protocol (AMQP). 


AMQP is a binary, application layer protocol, designed to
efficiently support a wide variety of messaging
applications and communication patterns. It is: 
* flow controlled,
* message-oriented communication with message-delivery
  guarantees such as:
  * at-most-once 
  * at-least-once
  * exactly-once
* authentication and/or encryption based on 
  * SASL and/or 
  * TLS
* It assumes an underlying reliable transport layer
  protocol such as Transmission Control Protocol (TCP)



Architecting fine-grained microservices-based applications
enables continuous integration and continuous delivery
practices. It also accelerates delivery of new functions
into the application. Fine-grained composition of
applications also allows you to run and test microservices
in isolation, and to evolve them autonomously while
maintaining clear contracts between them. As long as you
don't change the interfaces or contracts, you can change the
internal implementation of any microservice or add new
functionality without breaking other microservices.  


The following are important aspects to enable success in going into production with a microservices-based system:

* Monitoring and health checks of the services and
  infrastructure.
* Scalable infrastructure for the services (that is, cloud
  and orchestrators).
* Security design and implementation at multiple levels:
  authentication, authorization, secrets management, secure
  communication, etc.
* Rapid application delivery, usually with different teams
  focusing on different microservices.
* DevOps and CI/CD practices and infrastructure.


# Client communication with system

## Direct client-to-microservice communication

Each microservice has a public endpoint, sometimes with a
different TCP port for each microservice. An example of a
URL for a particular service could be the following URL in
Azure:

http://eshoponcontainers.westus.cloudapp.azure.com:88/

In a production environment based on a cluster, that URL
would map to the load balancer used in the cluster, which in
turn distributes the requests across the microservices. 

In production environments, you could have an Application
Delivery Controller (ADC) like Azure Application Gateway
between your microservices and the Internet. This acts as a
transparent tier that not only performs load balancing, but
secures your services by offering SSL termination. This
improves the load of your hosts by offloading CPU-intensive
SSL termination and other routing duties to the Azure
Application Gateway. In any case, a load balancer and ADC
are transparent from a logical application architecture
point of view.


## Indirect client-to-api-gateway communication


API Gateway also called "Backend for Frontend" (BFF) is
middle tier that abstracts api-s of multiple microservices.
It is implemented as microservice.  Also it separate public
api from internal microservices apis.

In a microservices architecture, the client apps usually
need to consume functionality from more than one
microservice. If that consumption is performed directly, the
client needs to handle multiple calls to microservice
endpoints. 

API gateway sits between the client apps and the
microservices. It acts as a reverse proxy, routing requests
from clients to services. It can also provide additional
cross-cutting features such as authentication, SSL
termination, and cache.

Apps connect to a single endpoint, the API Gateway, that's
configured to forward requests to individual microservices.
In this example, the API Gateway would be implemented as a
custom ASP.NET Core WebHost service running as a container.

It's very much recommended to split the API Gateway in
multiple services or multiple smaller API Gateways, one per
client app form-factor type, for instance.


## API Gateway features

API Gateway interface can be described in context of HTTP
by [OpenAPI](https://swagger.io/docs/specification/basic-structure/).
About Open API and similar:
* [Wikipedia OpenAPI](https://en.wikipedia.org/wiki/OpenAPI_Specification)
* [REST](https://en.wikipedia.org/wiki/Representational_state_transfer)

Reverse proxy or gateway routing. The API Gateway offers a
reverse proxy to redirect or route requests (layer 7
routing, usually HTTP requests) to the endpoints of the
internal microservices. The gateway provides a single
endpoint or URL for the client apps and then internally maps
the requests to a group of internal microservices.

Requests aggregation. As part of the gateway pattern you can
aggregate multiple client requests (usually HTTP requests)
targeting multiple internal microservices into a single
client request. This pattern is especially convenient when a
client page/screen needs information from several
microservices. 

Cross-cutting concerns or gateway offloading. Depending on
the features offered by each API Gateway product, you can
offload functionality from individual microservices to the
gateway, which simplifies the implementation of each
microservice by consolidating cross-cutting concerns into
one tier. This is especially convenient for specialized
features that can be complex to implement properly in every
internal microservice, such as the following functionality:

* Authentication and authorization
* Service discovery integration
* Response caching
* Retry policies, circuit breaker, and QoS
* Rate limiting and throttling
* Load balancing
* Logging, tracing, correlation
* Headers, query strings, and claims transformation
* IP whitelisting

### Ocelot

Ocelot is a lightweight API Gateway, recommended for simpler
approaches. Ocelot is an Open Source .NET Core-based API
Gateway especially made for microservices architectures that
need unified points of entry into their systems. It's
lightweight, fast, and scalable and provides routing and
authentication among many other features.

The main reason to choose Ocelot for the eShopOnContainers
reference application is because Ocelot is a .NET Core
lightweight API Gateway that you can deploy into the same
application deployment environment where you're deploying
your microservices/containers, such as a Docker Host,
Kubernetes, etc. And since it's based on .NET Core, it's
cross-platform allowing you to deploy on Linux or Windows.

## Communication types

Protocol synchronization:

* Synchronous protocol. HTTP is a synchronous protocol. The
  client sends a request and waits for a response from the
  service. That's independent of the client code execution
  that could be synchronous (thread is blocked) or
  asynchronous (thread isn't blocked, and the response will
  reach a callback eventually). The important point here is
  that the protocol (HTTP/HTTPS) is synchronous and the
  client code can only continue its task when it receives
  the HTTP server response.
* Asynchronous protocol. Other protocols like AMQP (a
  protocol supported by many operating systems and cloud
  environments) use asynchronous messages. The client code
  or message sender usually doesn't wait for a response. It
  just sends the message as when sending a message to a
  RabbitMQ queue or any other message broker.


Single or multiple receivers:

* Single receiver. Each request must be processed by exactly
  one receiver or service.
* Multiple receivers. Each request can be processed by zero
  to multiple receivers. This type of communication must be
  asynchronous. An example is the publish/subscribe
  mechanism used in patterns like Event-driven architecture.
  This is based on an event-bus interface or message broker
  when propagating data updates between multiple
  microservices through events; it's usually implemented
  through a service bus or similar artifact


A microservice-based application will often use a
combination of these communication styles. The most common
type is single-receiver communication with a synchronous
protocol like HTTP/HTTPS when invoking a regular Web API
HTTP service. 

Microservices also typically use messaging protocols for
asynchronous communication between microservices.

For microservices system what is important is being able to
integrate your microservices asynchronously while
maintaining the independence of microservices,


The goal of each microservice is to be autonomous and
available to the client consumer, even if the other services
that are part of the end-to-end application are down or
unhealthy.

# eventual consistency

For microservices use eventual consistency!.
If guarantiess are nedded, some additional tasks
may be done.

## How is it done?

For weak consistency may be used integration events using:
* an event bus or 
* message broker or 
* even HTTP by polling the other services instead.

## Communication context

Depending on context:

* for publishing services outside the Docker host or microservice cluster
  * HTTP and REST
  * Request/response communication is especially well suited
    for querying data for a real-time UI (a live user
    interface) from client apps
* communicating between services internally (within your Docker host or microservices cluster):
  * like WCF using TCP and binary format
  * asynchronous, message-based communication mechanisms such as AMQP


In a lightweight message broker, the infrastructure is
typically "dumb," acting only as a message broker, with
simple implementations such as RabbitMQ.

## Multiple-receivers message-based communication

As a more flexible approach, you might also want to use a
publish/subscribe mechanism so that your communication from
the sender will be available to additional subscriber
microservices or to external applications. Thus, it helps
you to follow the open/closed principle in the sending
service. That way, additional subscribers can be added in
the future without the need to modify the sender service.

When using asynchronous event-driven communication, a
microservice publishes an integration event when something
happens within its domain and another microservice needs to
be aware of it, like a price change in a product catalog
microservice. Additional microservices subscribe to the
events so they can receive them asynchronously. When that
happens, the receivers might update their own domain
entities, which can cause more integration events to be
published. This publish/subscribe system is usually
performed by using an implementation of an event bus. The
event bus can be designed as an abstraction or interface,
with the API that's needed to subscribe or unsubscribe to
events and to publish events. The event bus can also have
one or more implementations based on any inter-process and
messaging broker, like a messaging queue or service bus that
supports asynchronous communication and a publish/subscribe
model.

The messaging technologies available for implementing your
abstract event bus are at different levels. For instance,
products like RabbitMQ (a messaging broker transport) and
Azure Service Bus sit at a lower level than other products
like, NServiceBus, MassTransit, or Brighter, which can work
on top of RabbitMQ and Azure Service Bus. 

## API versioning

If you're using an HTTP-based mechanism such as REST, one
approach is to embed the API version number in the URL or
into an HTTP header.

## Microservices addressability

[Service registry](https://auth0.com/blog/an-introduction-to-microservices-part-3-the-service-registry/)

Each microservice has a unique name (URL) that's used to
resolve its location. Your microservice needs to be
addressable wherever it's running.

In the same way that DNS resolves a URL to a particular
computer, your microservice needs to have a unique name so
that its current location is discoverable. 

This implies that there's an interaction between how your
service is deployed and how it's discovered, because there
needs to be a service registry. In the same vein, when a
computer fails, the registry service must be able to
indicate where the service is now running.


The registry is a database containing the network locations
of service instances. A service registry needs to be highly
available and up-to-date. Clients could cache network
locations obtained from the service registry. However, that
information eventually goes out of date and clients can no
longer discover service instances. Consequently, a service
registry consists of a cluster of servers that use a
replication protocol to maintain consistency.

In some microservice deployment environments (called
clusters, to be covered in a later section), service
discovery is built-in. For example, an Azure Container
Service with Kubernetes (AKS) environment can handle service
instance registration and deregistration. It also runs a
proxy on each cluster host that plays the role of
server-side discovery router.


## Behaviour on fault

A microservice needs to be resilient to failures and to be
able to restart often on another machine for availability.
This resiliency also comes down to the state that was saved
on behalf of the microservice, where the microservice can
recover this state from, and whether the microservice can
restart successfully. In other words, there needs to be
resiliency in the compute capability (the process can
restart at any time) as well as resilience in the state or
data (no data loss, and the data remains consistent).

[Polly Library with resilence policies](https://github.com/App-vNext/Polly)


## Diagnostics Logs

It may seem obvious, and it's often overlooked, but a
microservice must report its health and diagnostics.
Otherwise, there's little insight from an operations
perspective. Correlating diagnostic events across a set of
independent services and dealing with machine clock skews to
make sense of the event order is challenging. In the same
way that you interact with a microservice over agreed-upon
protocols and data formats, there's a need for
standardization in how to log health and diagnostic events
that ultimately end up in an event store for querying and
viewing. In a microservices approach, it's key that
different teams agree on a single logging format. There
needs to be a consistent approach to viewing diagnostic
events in the application.


## Health checks

Health is different from diagnostics. Health is about the
microservice reporting its current state to take appropriate
actions. A good example is working with upgrade and
deployment mechanisms to maintain availability. Although a
service might currently be unhealthy due to a process crash
or machine reboot, the service might still be operational.
The last thing you need is to make this worse by performing
an upgrade. The best approach is to do an investigation
first or allow time for the microservice to recover. Health
events from a microservice help us make informed decisions
and, in effect, help create self-healing services.

Open-source library called Beat Pulse, available on GitHub
and as a NuGet package. This library also does health
checks, with a twist, it handles two types of checks:

* Liveness: Checks if the microservice is alive, that is, if
  it's able to accept requests and respond.
* Readiness: Checks if the microservice's dependencies
  (Database, queue services, etc.) are themselves ready, so
  the microservice can do what it's supposed to do.

In a distributed application where multiple services are
executed across many nodes in an orchestrator cluster, being
able to correlate distributed events is a challenge.

A microservice-based application should not try to store the
output stream of events or logfiles by itself, and not even
try to manage the routing of the events to a central place.
It should be transparent, meaning that each process should
just write its event stream to a standard output that
underneath will be collected by the execution environment
infrastructure where it's running. An example of these event
stream routers is Microsoft.Diagnostic.EventFlow, which
collects event streams from multiple sources and publishes
it to output systems. These can include simple standard
output for a development environment or cloud systems like
Azure Monitor and Azure Diagnostics. There are also good
third-party log analysis platforms and tools that can
search, alert, report, and monitor logs, even in real time,
like Splunk.


## Orchestrators managing health and diagnostics information

When you create a microservice-based application, you need
to deal with complexity. Of course, a single microservice is
simple to deal with, but dozens or hundreds of types and
thousands of instances of microservices is a complex
problem. It isn't just about building your microservice
architecture—you also need high availability,
addressability, resiliency, health, and diagnostics if you
intend to have a stable and cohesive system.


Development teams should focus on solving
business problems and building custom applications with
microservice-based approaches. They should not focus on
solving complex infrastructure problems; if they did, the
cost of any microservice-based application would be huge.
Therefore, there are microservice-oriented platforms,
referred to as orchestrators or microservice clusters, that
try to solve the hard problems of building and running a
service and using infrastructure resources efficiently. This
reduces the complexities of building applications that use a
microservices approach.

# Orchestrators

[Kubernates](https://kubernetes.io/)

[Helm](https://helm.sh/) (for configuring Kubernates??)


# Dockered microservices

## Create a Dockerfile related to an existing .NET base image

You need a Dockerfile for each custom image you want to
build; you also need a Dockerfile for each container to be
deployed, whether you deploy automatically from Visual
Studio or manually using the Docker CLI (docker run and
docker-compose commands). If your application contains a
single custom service, you need a single Dockerfile. If your
application contains multiple services (as in a
microservices architecture), you need one Dockerfile for
each service.

The Dockerfile is placed in the root folder of your
application or service. It contains the commands that tell
Docker how to set up and run your application or service in
a container. You can manually create a Dockerfile in code
and add it to your project along with your .NET
dependencies.


You usually build a custom image for your container on top
of a base image you get from an official repository like the
Docker Hub registry. That is precisely what happens under
the covers when you enable Docker support in Visual Studio.
Your Dockerfile will use an existing `dotnet/core/aspnet`
image.


```Dockerfile
# the image is based on version 3.1 of the official 
# ASP.NET Core Docker image (multi-arch for Linux and Windows)
# multiarch setup: mcr.microsoft.com/dotnet/core/aspnet:3.1
# linux setup: mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim
# windows setup: mcr.microsoft.com/dotnet/core/aspnet:3.1-nanoserver-1909
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
ARG source
WORKDIR /app
# instruct Docker to listen on the TCP port you will use at runtime:
EXPOSE 80
COPY ${source:-obj/Docker/publish} .
# how to run docker container process?
# just run:$ dotnet MySingleContainerWebApp.dll
ENTRYPOINT ["dotnet", " MySingleContainerWebApp.dll "]
```

Notes:

* other microsoft images on dockerhub see [.NET Core Docker Image](https://hub.docker.com/_/microsoft-dotnet-core/)
* ENTRYPOINT is how to start application
* EXPOSE defines TCP port

### Dockerfiles

The Dockerfile is similar to a batch script. Similar to what
you would do if you had to set up the machine from the
command line.

It starts with a base image that sets up the initial
context, it's like the startup filesystem, that sits on top
of the host OS. It's not an OS, but you can think of it like
"the" OS inside the container.

The execution of every command line creates a new layer on
the filesystem with the changes from the previous one, so
that, when combined, produce the resulting filesystem.

Since every new layer "rests" on top of the previous one and
the resulting image size increases with every command,
images can get very large if they have to include, for
example, the SDK needed to build and publish an application.














