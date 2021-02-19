# dotnet commands mother

## dependencies

`dotnet restore` - Restores the dependencies and tools of a
project.

## tamplates

The `dotnet new` command creates a .NET Core project or
other artifacts based on a template.

The command calls the template engine to create the
artifacts on disk based on the specified template and
options.

`dotnet new` internally uses (when neccessary) `dotnet restore` command, so explicitly restoring is not needed.

Core project templates can be found in
[dotnet new command](https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-new)

Structure of template creation command is:

```
dotnet new <TEMPLATE> [--dry-run] [--force] [-i|--install {PATH|NUGET_ID}]
    [-lang|--language {"C#"|"F#"|VB}] [-n|--name <OUTPUT_NAME>]
    [--nuget-source <SOURCE>] [-o|--output <OUTPUT_DIRECTORY>]
    [-u|--uninstall] [--update-apply] [--update-check] [Template options]

dotnet new <TEMPLATE> [-l|--list] [--type <TYPE>]

dotnet new -h|--help
```

# asp .net core + react

Project template is created using:

```console
$ # view installed templates
$ dotnet new spa -l
Templates                                 Short Name      Language      Tags
-----------------------------------------------------------------------------------
ASP.NET Core with Angular                 angular         [C#]          Web/MVC/SPA
ASP.NET Core with React.js                react           [C#]          Web/MVC/SPA
ASP.NET Core with React.js and Redux      reactredux      [C#]          Web/MVC/SPA
$
$ # what would happen if we create pure asp.net project?
$ dotnet new react --dry-run -lang 'C#'
File actions would have been taken:
  Create: .gitignore
  Create: appsettings.Development.json
  Create: appsettings.json
  Create: simple.csproj
  Create: Program.cs
  Create: Startup.cs
  Create: WeatherForecast.cs
  Create: ClientApp/.gitignore
  Create: ClientApp/package-lock.json
  Create: ClientApp/package.json
  Create: ClientApp/README.md
  Create: ClientApp/public/favicon.ico
  Create: ClientApp/public/index.html
  Create: ClientApp/public/manifest.json
  Create: ClientApp/src/App.js
  Create: ClientApp/src/App.test.js
  Create: ClientApp/src/custom.css
  Create: ClientApp/src/index.js
  Create: ClientApp/src/registerServiceWorker.js
  Create: ClientApp/src/components/Counter.js
  Create: ClientApp/src/components/FetchData.js
  Create: ClientApp/src/components/Home.js
  Create: ClientApp/src/components/Layout.js
  Create: ClientApp/src/components/NavMenu.css
  Create: ClientApp/src/components/NavMenu.js
  Create: Controllers/WeatherForecastController.cs
  Create: Pages/Error.cshtml
  Create: Pages/Error.cshtml.cs
  Create: Pages/_ViewImports.cshtml
  Create: Properties/launchSettings.json

Processing post-creation actions...
Action would have been taken automatically:
  Restore NuGet packages required by this project.
```

# Local mssql on Ubuntu 18.04 (systemd)

[SQL server on Ubuntu 18.04](https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-ubuntu?view=sql-server-ver15)

tex78MM!!.kk

## Links

Usefull:

- [Managing systemd services](https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units)
- [Changing mssql access rights (groups)](https://www.sqlpac.com/referentiel/docs-en/ms-sql-2019-ubuntu-systemctl-service-management-mssql.html)

## Status?

What is status of mssql-server ?

```console
$ systemctl status mssql-server --no-pager
● mssql-server.service - Microsoft SQL Server Database Engine
   Loaded: loaded (/lib/systemd/system/mssql-server.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2020-07-14 00:42:48 CEST; 2h 26min ago
     Docs: https://docs.microsoft.com/en-us/sql/linux
 Main PID: 4657 (sqlservr)
    Tasks: 188
   CGroup: /system.slice/mssql-server.service
           ├─4657 /opt/mssql/bin/sqlservr
           └─4699 /opt/mssql/bin/sqlservr

lip 14 00:43:01 mk-Lenovo-G780 sqlservr[4657]: [159B blob data]
lip 14 00:43:01 mk-Lenovo-G780 sqlservr[4657]: [156B blob data]
lip 14 00:43:01 mk-Lenovo-G780 sqlservr[4657]: [160B blob data]
lip 14 00:43:01 mk-Lenovo-G780 sqlservr[4657]: [61B blob data]
lip 14 00:43:03 mk-Lenovo-G780 sqlservr[4657]: [96B blob data]
lip 14 00:43:03 mk-Lenovo-G780 sqlservr[4657]: [66B blob data]
lip 14 00:43:03 mk-Lenovo-G780 sqlservr[4657]: [96B blob data]
lip 14 00:43:03 mk-Lenovo-G780 sqlservr[4657]: [100B blob data]
lip 14 00:43:04 mk-Lenovo-G780 sqlservr[4657]: [71B blob data]
lip 14 00:43:04 mk-Lenovo-G780 sqlservr[4657]: [124B blob data]
$
```

## Starting and stopping

Starting/stopping need sudo or service password:

```console
$ # as user there is choice:
$ systemctl stop mssql-server
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===
Authentication is required to stop 'mssql-server.service'.
Multiple identities can be used for authentication:
 1.  Ubuntu (ubuntu)
 2.  mssql
Choose identity to authenticate as (1-2):
$
$
$ # or as root
$ sudo systemctl stop mssql-server
[sudo] user:
$
```

## Autostarting

```console
$ # To start a service at boot:
$ sudo systemctl enable mssql-server
Added /etc/systemd/system/multi-user.target.wants/mssql-server.service.
$ # To disable the service from starting automatically:
$ sudo systemctl disable mssql-server
Removed /etc/systemd/system/multi-user.target.wants/mssql-server.service.
```

# Setting number of system file watchers

React project, FSWatcher module needs to watch many files it seems...
To change system settings

```console
$ # append string "fs.inotify.max_user_watches=524288" to /etc/sysctl.conf
$ echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
$ # reload sysctl:
$ sudo sysctl -p
```

Links:

- https://github.com/guard/listen/wiki/Increasing-the-amount-of-inotify-watchers#the-technical-details



# Dealing with Duplicate Assembly Attributes in .Net Core

Warning `Duplicate 'global::System.Runtime.Versioning.TargetFrameworkAttribute' attribute`
in file `obj/Debug/netcoreapp3.1/.NETCoreApp,Version=v3.1.AssemblyAttributes.cs`
can be overcome by adding to \*.csproj PropertyGroup following property:
`<GenerateTargetFrameworkAttribute>false</GenerateTargetFrameworkAttribute>`

Links with description:

- https://johnkoerner.com/csharp/dealing-with-duplicate-attribute-errors-in-net-core/
- https://stackoverflow.com/questions/61997928/errorcs0579duplicate-globalsystem-runtime-versioning-targetframeworkattribu



# ASP Host default configuration

Code below specify object representing host creation
process. Host represents web server.

```csharp
Host.CreateDefaultBuilder(args)
  .ConfigureWebHostDefaults(webBuilder =>
  {
      webBuilder.UseStartup<Startup>();
  });
```

`Host` represents fully configured OS environement
and executable code to loop (react). It is a black box with:

- function `Host.StartAsync` - for starting process,
- `Host.StopAsync` - for stopping process (and its children?), and
- property `Host.Services` - set of black boxes with executable code

So this is host, it gives us nothing, it could be anything.
In Haskell it would be IO (), some sideeffect specification..
But there is ready ASP host, to create it one uses `Host.CreateDefaultBuilder`
function which returns APS Host creation object (`IHostBuilder`),
this object can be configured, it contains informations how to:

- setup cwd
- choose env var prefix
- read from program args
- select files to load configurations from to IConfiguration
- do other things..

APS Host creation object (`IHostBuilder`) is further extended by
`GenericHostBuilderExtensions.ConfigureWebHostDefaults`
to `IWebHostBuilder`. This `IWebHostBuilder` is instance
of ASP Web Host instantation process. It contains informations
how to:

- specify web server (configured by default to Kestrel)
- inject parameters to web server
- include and select additional services:
  - logging
  - middleware
  - and other
- and other

`IWebHostBuilder` is configurable. Futher configuration is done using
extensions, `WebHostBuilderExtensions.UseStartup` configure class
which will be used to further configure `IWebHostBuilder`.

(`UseStartup` `TStartup` generic argument is the type containing the
startup methods for the application. I think this class
should have adhere to some interface, or at least have
default constructor, or execute method but type information
dont specify nothing more than is should be class..)

Below code creates and runs web server:

```csharp
IHostBuilder_Instance.Build().Run();
```

After configuration of `IHost` instantation process
(boxed in `IWebHostBuilder`), `IHost` is instantiated
by `IWebHostBuilder.Build`

So there is `IHost` (or rather `IWebHost`), now this is
particular web application programm, `IHost.Run` starts it.

## Services configuration

Host services (what are those?, what it can be?) specific
configuration is inside `Startup` class.

See:

https://docs.microsoft.com/en-us/aspnet/core/fundamentals/startup?view=aspnetcore-3.1

# ASP application controllers

Read:

https://docs.microsoft.com/en-us/aspnet/core/web-api/?view=aspnetcore-3.1

# ASP Dependency Injection (DI)

> DI is an alternative to static/global object access
> patterns. You may not be able to realize the benefits of
> DI if you mix it with static object access.
> (https://docs.microsoft.com/en-us/aspnet/core/fundamentals/dependency-injection?view=aspnetcore-3.1#recommendations)

If there are many possible algorithms sharing common abstraction,
one may construct such a structure that differences will
be passed as arguments or create algorithm builder.

Options are:

- particularity as interface and algorithm factory
- particularity as interface and algorithm constructor argument

For example:

```csharp
public class Particularity {
  public Particularity() {}
  public Task WriteMessage(string msg) {
    Console.WriteLine($"Particularity.WriteMessage called. Message: {msg}");
    return Task.FromResult(0);
  }
}
public class ParticularAlgorithm {
  Particularity _particularity = new Particularity();
  public ParticularAlgorithm() {}
  public async Task DoAsync() {
    await _particularity.WriteMessage(
      "ParticularAlgorithm.DoAsync created this message.");
  }
}
```

But we can have abstract algorithm using interfaces:

```csharp
public interface IParticular {
  Task WriteMessage(string msg);
}
public class Particularity : IParticular {
  public Particularity() {}
  public Task WriteMessage(string msg) {
    Console.WriteLine($"Particularity.WriteMessage called. Message: {msg}");
    return Task.FromResult(0);
  }
}
public class ParticularAlgorithm {
  IParticular _particularity;
  public ParticularAlgorithm(IParticular p) { _particularity = p; }
  public async Task DoAsync() {
    await _particularity.WriteMessage(
      "ParticularAlgorithm.DoAsync created this message.");
  }
}
```

# Middelware

GenericHost with web request / response pipeline:

![pipeline](middleware-pipeline.svg)



# Lunching App (and Server)

https://docs.microsoft.com/en-us/aspnet/core/fundamentals/servers/?view=aspnetcore-3.1&tabs=linux#server-startup

- In Visual Studio Code: The app and server are started by
  Omnisharp, which activates the CoreCLR debugger.
- When launching the app from a command prompt in the
  project's folder, dotnet run launches the app and server
  - The configuration is specified by the -c|--configuration
    option, which is set to either Debug (default) or
    Release
  - A launchSettings.json file provides configuration when
    launching an app with dotnet run or with a debugger
    built into tooling. If launch profiles are present in a
    launchSettings.json file, use the --launch-profile
    {PROFILE NAME} option with the dotnet run command


# ASP static files service configuration

React in this example dont explicitly interact with web server,
React app is downloaded by the clients as static files served
by web server static files services.

```csharp
public class Startup
{
  public void ConfigureServices(IServiceCollection services)
  {
    services.AddSpaStaticFiles(configuration =>
    {
        configuration.RootPath = "ClientApp/build";
    });
  }
}
```

# Configuration setup (providers)

configuration sources:

- Settings files, such as appsettings.json
- Environment variables
- Azure Key Vault
- Azure App Configuration
- Command-line arguments
- Custom providers, installed or created
- Directory files
- In-memory .NET objects

CreateDefaultBuilder provides default configuration for the app in the following order:

1. ChainedConfigurationProvider : Adds an existing
   IConfiguration as a source. In the default configuration
   case, adds the host configuration and setting it as the
   first source for the app configuration.
2. appsettings.json using the JSON configuration provider.
3. appsettings.Environment.json using the JSON configuration
   provider. For example, appsettings.Production.json and
   appsettings.Development.json.
4. App secrets when the app runs in the Development
   environment.
5. Environment variables using the Environment Variables
   configuration provider.
6. Command-line arguments using the Command-line
   configuration provider.

## What providers are registered and in what order

Following code have to be added as middelware (with some
route) (this way informations could be computed at any time
at runtime).

```csharp
public class LogConfigProviders {
    private IConfigurationRoot ConfigRoot;
    private ILog<LogConfigProviders> Log;
    // when this class will be registered in DI engine
    // configRoot and log will be injected
    public LogConfigProviders(IConfiguration configRoot,
        ILog<LogConfigProviders> log) {
        ConfigRoot = (IConfigurationRoot)configRoot;
        Log= log;
    }
    public void LogProviders() {
        string str = "";
        foreach (var provider in ConfigRoot.Providers.ToList()) {
            str += provider.ToString() + "\n";
        }
        Log(str);
    }
}
```

Example of ASP page displaing similar info is here:

https://docs.microsoft.com/en-us/aspnet/core/fundamentals/configuration/?view=aspnetcore-3.1#default-configuration

## JSON config files

For example `appsettings.json`:

```json
{
  "Position": {
    "Title": "Editor",
    "Name": "Joe Smith"
  },
  "MyKey": "My appsettings.json Value",
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft": "Warning",
      "Microsoft.Hosting.Lifetime": "Information"
    }
  },
  "AllowedHosts": "*"
}
```

Values (using dependency injection on `IConfiguration`) can
be accessed as fallows:

```csharp
public string ReadSomeConfigs(IConfiguration Configuration) {
  return  $"MyKey value: {Configuration["MyKey"]} \n" +
          $"Title: {Configuration["Position:Title"]} \n" +
          $"Name: {Configuration["Position:Name"]} \n" +
          $"Default Log Level: {Configuration["Logging:LogLevel:Default"]}";
}
```

```csharp
public class PositionOptions {
  public const string Position = "Position";
  public string Title { get; set; }
  public string Name { get; set; }
}

public class UsePositionOptions {
  private readonly IConfiguration Configuration;
  public UsePositionOptions(IConfiguration configuration) {
    Configuration = configuration;
  }
  public string Go() {
    var po1 = new PositionOptions();
    Configuration.GetSection(PositionOptions.Position).Bind(po1);
    var po2 = Configuration.GetSection(PositionOptions.Position)
      .Get<PositionOptions>();
    return $"Title: {po1.Title} \n" + $"Name: {po2.Name}");
  }
}

public class InjectPositionOptions {
  private readonly PositionOptions _options;
  public InjectPositionOptions(IOptions<PositionOptions> options) {
    _options = options;
  }
  public string Go() {
    return $"Title: {_options.Title} \n" + $"Name: {_options.Name}");
  }
}
```

## Environment variables

Environment variables can simulate JSON (and its hierarchy).
To simulate following:

```json
{
  "position": {
    "title": "mr.",
    "name": "John"
  }
}
```

One can set environment variables and run app:

```sh
# beware those are local to shell session
set Position__Title=mr.
set Position__Name=John
# App must be run from same shell to see those:
dotnet run
```

Hierarchy separator for env vars is `__` double undercore.

## Custom prefixed environment variables

One can specify to read env vars with custom prefix,
strip this prefix and override 'normal' env vars.
Variables set in this way would have highest precedence.

```csharp
Host
  .CreateDefaultBuilder(args)
  .ConfigureAppConfiguration(
    (hostingContext, config) => {
      config.AddEnvironmentVariables(prefix: "MyCustomPrefix_");
    }
  )
  .ConfigureWebHostDefaults(
    webBuilder => {
      webBuilder.UseStartup<Startup>();
    }
  );
```

```sh
# beware those are local to shell session
set MyCustomPrefix_Position__Title="mr."
set MyCustomPrefix_Position__Name="John"
# App must be run from same shell to see those:
dotnet run
```

## Special prefixes

Environment variables with the prefixes shown in the table
are loaded into the app with the default configuration or
when no prefix is supplied to AddEnvironmentVariables.

```
CUSTOMCONNSTR_{K}   --> ConnectionStrings:{K} --> Configuration entry not created.
MYSQLCONNSTR_{K}    --> ConnectionStrings:{K} --> ConnectionStrings:{K}_Provider:MySql.Data.MySqlClient
SQLAZURECONNSTR_{K} --> ConnectionStrings:{K} -->	ConnectionStrings:{K}_Provider:System.Data.SqlClient
SQLCONNSTR_{K} 	    --> ConnectionStrings:{K} -->	ConnectionStrings:{K}_Provider:System.Data.SqlClient
```

https://docs.microsoft.com/en-us/aspnet/core/fundamentals/configuration/?view=aspnetcore-3.1#connection-string-prefixes

## Command line arguments as configuration key-values

By default those key-values overrides key-values specified
in configuration files and environment variables.

Key-value may be separated by:

- `=` (equall sign) or
- `` (space) whan key is proceeded by `\` (backslash) or `--` (double hyphen)

For example:

```sh
dotnet run Position:Title="mr." --Position:Name "John"
```

## INI, JSON, XML, Files, Memory,... configuration provider

First in App:

```csharp
Host
  .CreateDefaultBuilder(args)
  .ConfigureAppConfiguration(
    (hostingContext, config) => {
      // clear factory of key-vals providers
      config.Sources.Clear();
      // read hosting env var: development, production, staging
      var env = hostingContext.HostingEnvironment;
      // add key-vals from specified ini files:
      config
        .AddIniFile("MyIniConfig.ini", optional: true, reloadOnChange: true)
        .AddIniFile($"MyIniConfig.{env.EnvironmentName}.ini",
                    optional: true,
                    reloadOnChange: true);
      // add key-vals from specified json file:
      config.AddJsonFile("MyConfig.json",
                         optional: true,
                         reloadOnChange: true);
      // add key-vals from specified xml file:
      config.AddXmlFile("MyXMLFile.xml",
                        optional: true,
                        reloadOnChange: true);
      // add key-vals - keys as file-name, vals as file-content :
      var path = Path.Combine(
        Directory.GetCurrentDirectory(),
        "path/to/files");
      config.AddKeyPerFile(directoryPath: path, optional: true);
      // add key-vals from dictionary (in memory);
      var Dict = new Dictionary<string, string>
      {
          {"MyKey", "Dictionary MyKey Value"},
          {"Position:Title", "Dictionary_Title"},
          {"Position:Name", "Dictionary_Name" },
          {"Logging:LogLevel:Default", "Warning"}
      };
      config.AddInMemoryCollection(Dict);
      // add key-vals from env
      config.AddEnvironmentVariables();
      // add key-vals from command args
      if (args != null) {
        config.AddCommandLine(args);
      }
    }
  )
  .ConfigureWebHostDefaults(
    webBuilder => {
      webBuilder.UseStartup<Startup>();
    }
  );
```

Than ini file can be used:

```ini
MyKey="MyIniConfig.ini Value"

[Position]
Title="My INI Config title"
Name="My INI Config name"

[Logging:LogLevel]
Default=Information
Microsoft=Warning
```

Xml file:

```xml
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <MyKey>MyXMLFile Value</MyKey>
  <Position>
    <Title>Title from  MyXMLFile</Title>
    <Name>Name from MyXMLFile</Name>
  </Position>
  <Logging>
    <LogLevel>
      <Default>Information</Default>
      <Microsoft>Warning</Microsoft>
    </LogLevel>
  </Logging>
</configuration>
```

For xml files, `name` attribute is of importance,
it allows repeating tags:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
  <section name="section0">
    <key name="key0">value 00</key>
    <key name="key1">value 01</key>
  </section>
  <section name="section1">
    <key name="key0">value 10</key>
    <key name="key1">value 11</key>
  </section>
</configuration>
```

This would be accessed like this:

```csharp
var key00 = "section:section0:key:key0";
var key01 = "section:section0:key:key1";

var val00 = Configuration[key00]; // --> value 00
var val01 = Configuration[key01]; // --> value 01
```

Other attributes will be read as values:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
  <key attribute="value" />
  <section>
    <key attribute="value" />
  </section>
</configuration>
```

```csharp
var key_attr = "key:attribute";
var section_key_attr = "section:key:attribute";

var val_of_key_attr = Configuration[key_attr]; // --> value
var val_of_section_key_attr = Configuration[val_of_section_key_attr]; // --> value
```

## Key-per-file configuration provider

The KeyPerFileConfigurationProvider uses a directory's files
as configuration key-value pairs. The key is the file name.
The value contains the file's contents. The Key-per-file
configuration provider is used in Docker hosting scenarios.

- An `Action<KeyPerFileConfigurationSource>` delegate that
  configures the source.
- Whether the directory is optional and the path to the
  directory.
- The double-underscore (`__`) is used as a configuration
  key delimiter in file names. For example, the file name
  `Logging__LogLevel__System` produces the configuration key
  `Logging:LogLevel:System`.

```csharp
var path = Path.Combine(
  Directory.GetCurrentDirectory(),
  "path/to/files");
config.AddKeyPerFile(directoryPath: path, optional: true);
```

# Configuration access

For examplary read configuration from below:

```json
{
  "Position": {
    "Title": "Editor",
    "Name": "Joe Smith"
  },
  "MyKey": "My appsettings.json Value",
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft": "Warning",
      "Microsoft.Hosting.Lifetime": "Information"
    }
  },
  "AllowedHosts": "*"
}
```

Typically in context of middelware:

```csharp
IConfiguration Config;

// configuration leaf:
var number = Config.GetValue<int>("NumberKey", 99);

// configuration subsection:
IConfiguration PositionConfig = Config.GetSection("Position");
var pos_title = PositionConfig["Title"]; // --> "Editor"
var pos_name  = PositionConfig["Name"]; // --> "Joe Smith"

// does subsection exists?:
if (!PositionConfig.Exists()) {
    throw new System.Exception("Position does not exist.");
}

// configuration children
var children = PositionConfig.GetChildren();
List<string> flatten = new List<string>();
foreach (var subSection in children) {
  flatten.Add($"Key = {subSection.Key}, value = {subSection.Value}");
}
```

## Configure options with a delegate

```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.Configure<MyOptions>(myOptions =>
    {
        myOptions.Option1 = "Value configured in delegate";
        myOptions.Option2 = 500;
    });

    services.AddRazorPages();
}
public void UseMyOptions() 
{
  // this must be injected
  IOptions<MyOptions> myOpts;
  Console.WriteLine($"Option1: {myOpts.Value.Option1}");
  Console.WriteLine($"Option2: {myOpts.Value.Option2}");
}
```

## Framework available configuration providers

https://docs.microsoft.com/en-us/aspnet/core/fundamentals/configuration/?view=aspnetcore-3.1#configuration-providers



## Options validation

```csharp
public class MyConfigOptions
{
    public const string MyConfig = "MyConfig";

    [RegularExpression(@"^[a-zA-Z''-'\s]{1,40}$")]
    public string Key1 { get; set; }
    [Range(0, 1000,
        ErrorMessage = "Value for {0} must be between {1} and {2}.")]
    public int Key2 { get; set; }
    public int Key3 { get; set; }
}

public void ConfigureServices(IServiceCollection services)
{
  services.AddOptions<MyConfigOptions>()
    .Bind(Configuration.GetSection(MyConfigOptions.MyConfig))
    .ValidateDataAnnotations()
    .Validate(
      config => {
        if (config.Key2 != 0)
        {
          return config.Key3 > config.Key2;
        }
        return true;
      }, 
      "Key3 must be > than Key2." // Failure message.
    );
}

public ContentResult Index()
{
  string msg;
  try
  {
    msg = $"Key1: {_config.Value.Key1} \n" +
          $"Key2: {_config.Value.Key2} \n" +
          $"Key3: {_config.Value.Key3}";
  }
  catch (OptionsValidationException optValEx)
  {
    return Content(optValEx.Message);
  }
  return Content(msg);
}
```

## IValidateOptions for complex validation

https://docs.microsoft.com/en-us/aspnet/core/fundamentals/configuration/options?view=aspnetcore-3.1#ivalidateoptions-for-complex-validation

## Options post-configuration

```csharp
services.PostConfigure<MyOptions>(
  myOptions => {
    myOptions.Option1 = "post_configured_option1_value";
  }
);
services.PostConfigure<MyOptions>(
  "named_options_1", 
  myOptions => {
    myOptions.Option1 = "post_configured_option1_value";
  }
);
services.PostConfigureAll<MyOptions>(
  myOptions => {
    myOptions.Option1 = "post_configured_option1_value";
  }
);
```

## Accessing options during startup

`IOptions<TOptions>` and `IOptionsMonitor<TOptions>` can be
used in Startup.Configure, since services are built before
the Configure method executes.

Don't use `IOptions<TOptions>` or
`IOptionsMonitor<TOptions>` in Startup.ConfigureServices. An
inconsistent options state may exist due to the ordering of
service registrations.

```csharp
public void Configure(
  IApplicationBuilder app, 
  IOptionsMonitor<MyOptions> optionsAccessor
) {
    var option1 = optionsAccessor.CurrentValue.Option1;
}
```

# Execution profiles (development, production)


## launch.json

Profiles are in `.vscode/launch.json`.  Profile can be selected
using: `dotnet run --launch-profile "SampleApp"`. Inside profile
there is section `env` for setting env vars.


This could be also done manually, e.g.:

```sh
set ASPNETCORE_ENVIRONMENT=Development
#  --no-launch-profile to not override 
dotnet run --no-launch-profile
```

## At Linux

Per use:

```sh
ASPNETCORE_ENVIRONMENT=Development dotnet run
```

Per session:

```sh
export ASPNETCORE_ENVIRONMENT=Development
dotnet run
```

Permanent (per user):

```sh
echo 'export ASPNETCORE_ENVIRONMENT=Development' >> ~/.bashrc
```

Permanent (per machine) use `bash_profile`.

## Using at startup

Access to env vars can by obtained by injecting service
to Startup class:

```csharp
public class Startup
{
  public Startup(IConfiguration configuration, IWebHostEnvironment env)
  {
    Configuration = configuration;
    _env = env;
  }

  public IConfiguration Configuration { get; }
  private readonly IWebHostEnvironment _env;
}
```

# Logging

`CreateDefaultBuilder`, adds the following logging providers:

- Console
- Debug
- EventSource

## Cleaning logs providers

```csharp
public static IHostBuilder CreateHostBuilder(string[] args) =>
  Host
    .CreateDefaultBuilder(args)
    .ConfigureLogging(
      logging => {
        logging.ClearProviders();
        logging.AddConsole();
      }
    )
    .ConfigureWebHostDefaults(
      webBuilder => {
        webBuilder.UseStartup<Startup>();
      }
    );
```

## Creating logs

Logging is service, it is usable when services are ready (so
it is accessible typically for middeware, first access can
be after host build (next configure function), and for
example in `Startup.Configure`).  Logging needs name
context, which typically is class name.  Example:

https://docs.microsoft.com/en-us/aspnet/core/fundamentals/logging/?view=aspnetcore-3.1#create-logs

https://docs.microsoft.com/en-us/aspnet/core/fundamentals/logging/?view=aspnetcore-3.1#create-logs-in-main

https://docs.microsoft.com/en-us/aspnet/core/fundamentals/logging/?view=aspnetcore-3.1#create-logs-in-startup

```csharp
public class Program {
  public static void Main(string[] args) {
    var host = CreateHostBuilder(args).Build();
    var logger = host.Services.GetRequiredService<ILogger<Program>>();
    logger.LogInformation("Host created.");
    host.Run();
  }
  public static IHostBuilder CreateHostBuilder(string[] args) =>
    Host
      .CreateDefaultBuilder(args)
      .ConfigureWebHostDefaults(
        webBuilder => {
          webBuilder.UseStartup<Startup>();
        }
      );
}
public class Startup {
  public void Configure(
    IApplicationBuilder app, 
    IWebHostEnvironment env,
    ILogger<Startup> logger
  ) {
    if (env.IsDevelopment()) {
      logger.LogInformation("In Development.");
      app.UseDeveloperExceptionPage();
    }
    else {
      logger.LogInformation("Not Development.");
      app.UseExceptionHandler("/Error");
      app.UseHsts();
    }
    app.UseHttpsRedirection();
    app.UseStaticFiles();
    app.UseRouting();
    app.UseAuthorization();
    app.UseEndpoints(endpoints =>
    {
      endpoints.MapControllers();
      endpoints.MapRazorPages();
    });
  }
}
```

Without Startup:

https://docs.microsoft.com/en-us/aspnet/core/fundamentals/startup?view=aspnetcore-3.1#configure-services-without-startup

```csharp
public class Program {
  public static void Main(string[] args) {
      CreateHostBuilder(args).Build().Run();
  }

  public static IHostBuilder CreateHostBuilder(string[] args) =>
    Host
    .CreateDefaultBuilder(args)
    .ConfigureAppConfiguration(
      (hostingContext, config) => { }
    )
    .ConfigureWebHostDefaults(
      webBuilder => {
        webBuilder
        .ConfigureServices(
          services => {
            services.AddControllersWithViews();
          }
        )
        .Configure(
          app => {
            var loggerFactory = app.ApplicationServices.GetRequiredService<ILoggerFactory>();
            var logger = loggerFactory.CreateLogger<Program>();
            var env = app.ApplicationServices.GetRequiredService<IWebHostEnvironment>();
            var config = app.ApplicationServices.GetRequiredService<IConfiguration>();
            logger.LogInformation("Logged in Configure");
            if (env.IsDevelopment()) {
              app.UseDeveloperExceptionPage();
            }
            else{
              app.UseExceptionHandler("/Home/Error");
              app.UseHsts();
            }
            var configValue = config["MyConfigKey"];
          }
        );
      }
    );
}
```


## Logging Configuration

`appsettings.json`:

```json
{
  "Logging": {
    "LogLevel": { // All providers, LogLevel applies to all the enabled providers.
      "Default": "Error", // Default logging, Error and higher.
      "Microsoft": "Warning" // All Microsoft* categories, Warning and higher.
    },
    "Debug": { // Debug provider.
      "LogLevel": {
        "Default": "Information", // Overrides preceding LogLevel:Default setting.
        "Microsoft.Hosting": "Trace" // Debug:Microsoft.Hosting category.
      }
    },
    "EventSource": { // EventSource provider
      "LogLevel": {
        "Default": "Warning" // All categories of EventSource provider.
      }
    },
    "Console": {
      "IncludeScopes": true,
      "LogLevel": {
        "Microsoft.AspNetCore.Mvc.Razor.Internal": "Warning",
        "Microsoft.AspNetCore.Mvc.Razor.Razor": "Debug",
        "Microsoft.AspNetCore.Mvc.Razor": "Error",
        "Default": "Information"
      }
    }
  }
}
```

Every configuration can be set by many differnt providers,
e.g.:

```sh
set Logging__LogLevel__Microsoft=Information
dotnet run
```

## Log event ID

Each log can specify an event ID. This allows grouping
of log categories by id.

```csharp
public class MyLogEvents {
    public const int GetItemFound       = 1002;
    public const int GetItemNotFound    = 4000;
}

// ... 
_logger.LogInformation(MyLogEvents.GetItemFound, "Getting item {Name}", Name);
_logger.LogWarning(MyLogEvents.GetItemNotFound, "Get({Name}) NOT FOUND", Name);
```

## Applying filters to logging actions

```csharp
public static IHostBuilder CreateHostBuilder(string[] args) =>
  Host.CreateDefaultBuilder(args)
  .ConfigureLogging(
    logging => {
      logging.AddFilter(
        (provider, category, logLevel) => {
          if (provider.Contains("ConsoleLoggerProvider")
              && category.Contains("Controller")
              && logLevel >= LogLevel.Information) {
              return true;
          }
          else if (provider.Contains("ConsoleLoggerProvider")
              && category.Contains("Microsoft")
              && logLevel >= LogLevel.Information) {
              return true;
          }
          else {
              return false;
          }
        }
      );
    }
  )
  .ConfigureWebHostDefaults(
    webBuilder => {
      webBuilder.UseStartup<Startup>();
    }
  );
```

## Scoped console logger

Log scopes

```csharp
public class Scopes
{
    public static void Main(string[] args)
    {
        CreateHostBuilder(args).Build().Run();
    }

    public static IHostBuilder CreateHostBuilder(string[] args) =>
        Host.CreateDefaultBuilder(args)
            .ConfigureLogging((hostingContext, logging) =>
            {
                logging.ClearProviders();
                logging.AddConsole(options => options.IncludeScopes = true);
                logging.AddDebug();
            })
            .ConfigureWebHostDefaults(webBuilder =>
            {
                webBuilder.UseStartup<Startup>();
            });
}

[HttpGet("{id}")]
public async Task<ActionResult<TodoItemDTO>> GetTodoItem(long id)
{
    TodoItem todoItem;

    using (_logger.BeginScope("using block message"))
    {
        _logger.LogInformation(MyLogEvents.GetItem, "Getting item {Id}", id);

        todoItem = await _context.TodoItems.FindAsync(id);

        if (todoItem == null)
        {
            _logger.LogWarning(MyLogEvents.GetItemNotFound, 
                "Get({Id}) NOT FOUND", id);
            return NotFound();
        }
    }

    return ItemToDTO(todoItem);
}
```

## Logging DebugLogProvider

The Debug provider writes log output by using the
`System.Diagnostics.Debug` class. Calls to
`System.Diagnostics.Debug.WriteLine` write to the Debug
provider.

On Linux, the Debug provider log location is
distribution-dependent and may be one of the following:

- `/var/log/message`
- `/var/log/syslog`

## Logging EventSourceLog

The EventSource provider writes to a cross-platform event
source with the name Microsoft-Extensions-Logging. 

## Logs viewing - dotnet trace tooling

The `dotnet-trace` tool is a cross-platform CLI global tool
that enables the collection of .NET Core traces of a running
process. The tool collects
`Microsoft.Extensions.Logging.EventSource` provider data using
a `LoggingEventSource`.

Use the dotnet trace tooling to collect a trace from an app:

1. Run the app with the dotnet run command.
2. Determine the process identifier (PID) of the .NET Core app:
   (`$ pidof app_assembly_name`)
3. Execute the dotnet trace command.
4. Stop the dotnet trace tooling by pressing the Enter key or Ctrl+C.
5. Open the trace with some GUI program.

```sh
dotnet trace collect -p {PID} 
    --providers Microsoft-Extensions-Logging:{Keyword}:{Event Level}
        :FilterSpecs=\"
            {Logger Category 1}:{Event Level 1};
            {Logger Category 2}:{Event Level 2};
            ...
            {Logger Category N}:{Event Level N}\"

```


## Logging in normal applications


```csharp
class Program {
  static void Main(string[] args) {
    var loggerFactory = LoggerFactory.Create(
      builder => {
        builder
          .AddFilter("Microsoft", LogLevel.Warning)
          .AddFilter("System", LogLevel.Warning)
          .AddFilter("LoggingConsoleApp.Program", LogLevel.Debug)
          .AddConsole()
          .AddEventLog();
      }
    );
    ILogger logger = loggerFactory.CreateLogger<Program>();
    logger.LogInformation("Example log message");
  }
}
```

# Routing

https://docs.microsoft.com/en-us/aspnet/core/fundamentals/routing?view=aspnetcore-3.1

Routing is responsible for matching incoming HTTP requests
and dispatching those requests to the app's executable
**endpoints**.

Routing uses a pair of middleware, registered by
`UseRouting` and `UseEndpoints`:

- UseRouting adds route matching to the middleware pipeline.
  This middleware looks at the set of endpoints defined in
  the app, and selects the best match based on the request.
- UseEndpoints adds endpoint execution to the middleware
  pipeline. It runs the delegate associated with the
  selected endpoint.


## Endpoints

**Endpoints** are the app's units of executable
request-handling code, The `MapGet` method is used to define
an endpoint. An endpoint is something that can be:

- Selected, by matching the URL and HTTP method.
- Executed, by running the delegate.

Endpoints that can be matched and executed by the app are
configured in UseEndpoints. For example,: 

- `MapGet`, 
- `MapPost`,
- and similar

Additional methods that can be used to connect ASP.NET Core
framework features to the routing system are:

- `MapRazorPages` for Razor Pages
- `MapControllers` for controllers
- `MapHub<THub>` for SignalR
- `MapGrpcService<TService>` for gRPC

```csharp
app.UseEndpoints(
  endpoints => {
    //  The string /hello/{name:alpha} is a route template. 
    // It is used to configure how the endpoint is matched. 
    // :alpha is route constraints (matching alphabetic characters)
    endpoints.MapGet(
      "/hello/{name:alpha}", // {name:alpha} is binding to name var
                             // name is captured in HttpRequest.RouteValues
      async context => {
        var name = context.Request.RouteValues["name"];
        await context.Response.WriteAsync($"Hello {name}!");
      }
    );
  }
);

app.UseRazorPages();
```

## Endpoint metadata

```cs
public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
{
  if (env.IsDevelopment()){
      app.UseDeveloperExceptionPage();
  }
  // Matches request to an endpoint.
  app.UseRouting();

  // Endpoint aware middleware. 
  // Middleware can use metadata from the matched endpoint.
  app.UseAuthentication();
  app.UseAuthorization();

  // Execute the matched endpoint.
  app.UseEndpoints(
    endpoints => {
      // Configure the Health Check endpoint and require an authorized user.
      endpoints.MapHealthChecks("/healthz").RequireAuthorization();

      // Configure another endpoint, no authorization requirements.
      endpoints.MapGet(
        "/", 
        async context =>{
          await context.Response.WriteAsync("Hello World!");
        }
      );
    }
  );
}
```

In the preceding example, there are two endpoints, but only
the health check endpoint has an authorization policy
attached. If the request matches the health check endpoint,
/healthz, an authorization check is performed. This
demonstrates that endpoints can have extra data attached to
them. This extra data is called endpoint metadata:

- The metadata can be processed by routing-aware middleware.
- The metadata can be of any .NET type.


## Endpoints behaviour and access in middleware


- The endpoint is always null before UseRouting is called.
- If a match is found, the endpoint is non-null between
  UseRouting and UseEndpoints.
- The UseEndpoints middleware is terminal when a match is
  found. Terminal middleware is defined later in this
  document.
- The middleware after UseEndpoints execute only when no
  match is found.

Middeware can be configured with use of `HttpContext`:

```cs
app.Use(
  next => {
    context => {
      Console.WriteLine($"1. Endpoint: {context.GetEndpoint()?.DisplayName ?? "(null)"}");
      return next(context);
    }
  }
);
```

## UseRouting and other middeware interactions

The `UseRouting` middleware uses the `SetEndpoint` method to
attach the endpoint to the current context (`HttpContext`). It's possible to
replace the `UseRouting` middleware with custom logic and
still get the benefits of using endpoints. Endpoints are a
low-level primitive like middleware, and aren't coupled to
the routing implementation. Most apps don't need to replace
UseRouting with custom logic.


- Middleware can run before UseRouting to modify the data
  that routing operates upon.
  - Usually middleware that appears before routing modifies
    some property of the request, such as UseRewriter,
    UseHttpMethodOverride, or UsePathBase.
- Middleware can run between UseRouting and UseEndpoints to
  process the results of routing before the endpoint is
  executed.
  - Middleware that runs between UseRouting and
    UseEndpoints:
    - Usually inspects metadata to understand the endpoints.
    - Often makes security decisions, as done by
      UseAuthorization and UseCors.
  - The combination of middleware and metadata allows configuring policies per-endpoint.

## Terminal middleware or routing?

Recall, An endpoint defines both:

- A delegate to process requests.
- A collection of arbitrary metadata. The metadata is used
  to implement cross-cutting concerns based on policies and
  configuration attached to each endpoint.


```cs
public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
{
    // Approach 1: Writing a terminal middleware.
    app.Use(
      next => 
        async context => {
          if (context.Request.Path == "/") {
              await context.Response.WriteAsync("Hello terminal middleware!");
              return; // because it is terminal !!!
          }
          await next(context);
        }
    );

    // enable routing support
    app.UseRouting();

    app.UseEndpoints(
      endpoints => {
        // Approach 2: Using routing.
        endpoints.MapGet(
          "/Movie", 
          async context => {
            await context.Response.WriteAsync("Hello routing!");
          }
        );
      }
    );
}
```

Terminal middleware or routing?:

- Both approaches allow terminating the processing pipeline:
  - Middleware terminates the pipeline by returning rather
    than invoking next.
  - Endpoints are always terminal.
- Terminal middleware allows positioning the middleware at
  an arbitrary place in the pipeline:
  - Endpoints execute at the position of UseEndpoints.
- Terminal middleware allows arbitrary code to determine
  when the middleware matches:
  - Custom route matching code can be verbose and difficult
    to write correctly.
  - Routing provides straightforward solutions for typical
    apps. Most apps don't require custom route matching
    code.
- Endpoints interface with middleware such as
  UseAuthorization and UseCors.
  - Using a terminal middleware with UseAuthorization or
    UseCors requires manual interfacing with the
    authorization system.

Terminal middleware can be an effective tool, but can
require:

- A significant amount of coding and testing.
- Manual integration with other systems to achieve the
  desired level of flexibility.


## Route templates

https://docs.microsoft.com/en-us/aspnet/core/fundamentals/routing?view=aspnetcore-3.1#route-template-reference

| Route Template                         | Example Matching URI  | The request URI…                                                        |
|----------------------------------------|-----------------------|-------------------------------------------------------------------------|
| hello                                  | /hello                | Only /hello.                                                            |
| {Page=Home}                            | /                     | Matches and sets Page to Home.                                          |
| {Page=Home}                            | /Contact              | Matches and sets Page to Contact.                                       |
| {controller}/{action}/{id?}            | /Products/List        | Maps to the Products controller and List action.                        |
| {controller}/{action}/{id?}            | /Products/Details/123 | Maps to the Products controller and  Details action with id set to 123. |
| {controller=Home}/{action=Index}/{id?} | /                     | Maps to the Home controller and Index method. id is ignored.            |
| {controller=Home}/{action=Index}/{id?} | /Products             | Maps to the Products controller and Index method. id is ignored.        |


## Route constraints

https://docs.microsoft.com/en-us/aspnet/core/fundamentals/routing?view=aspnetcore-3.1#route-constraint-reference

| constraint        | Example                           | Example Matches               | Notes                         |
|-------------------|-----------------------------------|-------------------------------|-------------------------------|
| int               | {id:int}                          | 123456789, -123456789         | Integer                       |
| bool              | {active:bool}                     | true, FALSE                   | true/false, Case-insensitive  |
| datetime          | {dob:datetime}                    | 2016-12-31, 2016-12-31 7:32pm | DateTime invariant culture    |
| decimal           | {price:decimal}                   | 49.99, -1,000.01              | decimal invariant culture     |
| double            | {weight:double}                   | 1.234, -1,001.01e8            | double invariant culture      |
| float             | {weight:float}                    | 1.234, -1,001.01e8            | float invariant culture       |
| guid              | {id:guid}                         | CD2C1638-1638-72D5-1638-DE... | Guid                          |
| long              | {ticks:long}                      | 123456789, -123456789         | long                          |
| minlength(value)  | {username:minlength(4)}           | Rick                          | String >= 4 chars             |
| maxlength(value)  | {filename:maxlength(8)}           | MyFile                        | String <= 8 chars             |
| length(length)    | {filename:length(12)}             | somefile.txt                  | String 12 chars               |
| length(min,max)   | {filename:length(8,16)}           | somefile.txt                  | String [8, 16] chars          |
| min(value)        | {age:min(18)}                     | 19                            | Integer >= 18                 |
| max(value)        | {age:max(120)}                    | 91                            | Integer <= 120                |
| range(min,max)    | {age:range(18,120)}               | 91                            | Integer in [18, 120]          |
| alpha             | {name:alpha}                      | Rick                          | String [a-z] case-insensitive |
| regex(expression) | {post:regex(^\\d{{2}}-\\d{{3}}$)} | 30-230                        | RegExp                        |
| required          | {name:required}                   | Rick                          | Par required                  |


## Regexp


To use the regular expression `^\d{3}-\d{2}-\d{4}$` or
`^[a-z]{2}$` in an inline constraint, use one of the
following:

- Replace `\` characters provided in the string as `\\`
  characters in the C# source file in order to escape the
  `\` string escape character.
  (`^\\d{{3}}-\\d{{2}}-\\d{{4}}$` or `^[[a-z]]{{2}}$`)
- Verbatim string literals. (`@"^\d{3}-\d{2}-\d{4}$"` or
  `@"^[a-z]{2}$"`)

To constrain a parameter to a known set of possible values,
use a regular expression. For example,
`{action:regex(^(list|get|create)$)}` only matches the
action route value to `list`, `get`, or `create`.

## Host matching in routes with RequireHost


```cs
public void Configure(IApplicationBuilder app) {
  app.UseRouting();
  app.UseEndpoints(
    endpoints => {
      endpoints
      .MapGet(
        "/", 
        context => context.Response.WriteAsync("Hi Contoso!")
      )
      .RequireHost("contoso.com");

      endpoints
      .MapGet(
        "/", 
        context => context.Response.WriteAsync("AdventureWorks!")
      )
      .RequireHost("adventure-works.com");

      endpoints.MapHealthChecks("/healthz").RequireHost("*:8080");
    }
  );
}

[Host("contoso.com", "adventure-works.com")]
public class ProductController : Controller {
  public IActionResult Index()     {
    return ControllerContext.MyDisplayRouteInfo();
  }
  [Host("example.com:8080")]
  public IActionResult Privacy() {
    return ControllerContext.MyDisplayRouteInfo();
  }
}
```

## Routing performance problems

When an app has performance problems, routing is often
suspected as the problem. The reason routing is suspected is
that frameworks like controllers and Razor Pages report the
amount of time spent inside the framework in their logging
messages. When there's a significant difference between the
time reported by controllers and the total time of the
request:

- Developers eliminate their app code as the source of the problem.
- It's common to assume routing is the cause.

## Debug diagnostics

For detailed routing diagnostic output, set
`Logging:LogLevel:Microsoft` to `Debug`. In the development
environment, set the log level in
`appsettings.Development.json`:

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft": "Debug",
      "Microsoft.Hosting.Lifetime": "Information"
    }
  }
}
```

# Dispalying (and logging) exceptions

https://docs.microsoft.com/en-us/aspnet/core/fundamentals/error-handling?view=aspnetcore-3.1

Obviously (probably) every request/response pipeline is
in catch all try/catch block, maybe even each middleware.

If exception occures, it is catched to not crush App,
and by default exception is reported as error page,
but this can be customised.

## Defaults

The default exception page includes the following
information about the exception and the request:

- Stack trace
- Query string parameters (if any)
- Cookies (if any)
- Headers


```cs
if (env.IsDevelopment()) {
  app.UseDeveloperExceptionPage();
}
else {
  app.UseExceptionHandler("/Error");
  app.UseHsts();
}
```

## Access the exception

Use `IExceptionHandlerPathFeature` to access the exception and
the original request path in an error handler controller or
page: 

```cs
if (env.IsDevelopment()) {
    app.UseDeveloperExceptionPage();
}
else {
  app.UseExceptionHandler(
    errorApp => {
      errorApp.Run(
        async context => {
          context.Response.StatusCode = 500;
          context.Response.ContentType = "text/html";

          await context.Response.WriteAsync("<html lang=\"en\"><body>\r\n");
          await context.Response.WriteAsync("ERROR!<br><br>\r\n");

          var exceptionHandlerPathFeature = 
              context.Features.Get<IExceptionHandlerPathFeature>();

          // Use exceptionHandlerPathFeature to process the exception (for example, 
          // logging), but do NOT expose sensitive error information directly to 
          // the client.

          if (exceptionHandlerPathFeature?.Error is FileNotFoundException) {
              await context.Response.WriteAsync("File error thrown!<br><br>\r\n");
          }

          await context.Response.WriteAsync("<a href=\"/\">Home</a><br>\r\n");
          await context.Response.WriteAsync("</body></html>\r\n");
          await context.Response.WriteAsync(new string(' ', 512)); // IE padding
        }
      );
    }
  );
  app.UseHsts();
}
```

## UseStatusCodePages with lambda

To specify custom error-handling and response-writing code,
use the overload of `UseStatusCodePages` that takes a lambda
expression:

```cs
app.UseStatusCodePages(
  async context => {
    context.HttpContext.Response.ContentType = "text/plain";

    await context.HttpContext.Response.WriteAsync(
      "Status code page, status code: " + 
      context.HttpContext.Response.StatusCode);
  }
);
```

## Database error page

Database Error Page Middleware captures database-related
exceptions that can be resolved by using Entity Framework
migrations. When these exceptions occur, an HTML response
with details of possible actions to resolve the issue is
generated. This page should be enabled only in the
Development environment. Enable the page by adding code to
Startup.Configure:

```cs
if (env.IsDevelopment()) {
    app.UseDatabaseErrorPage();
}
```
`UseDatabaseErrorPage` requires the
`Microsoft.AspNetCore.Diagnostics.EntityFrameworkCore` NuGet
package.

# HTTP requests using IHttpClientFactory

https://docs.microsoft.com/en-us/aspnet/core/fundamentals/http-requests?view=aspnetcore-3.1

An `IHttpClientFactory` can be registered and used to
configure and create `HttpClient` instances in an app. 


## HttpClient: Normal | Named | Typed

(**An `IHttpClientBuilder` is returned when adding named or typed clients.**)



```cs
public class Startup {
  public Startup(IConfiguration configuration) {
    Configuration = configuration;
  }
  public IConfiguration Configuration { get; }
  public void ConfigureServices(IServiceCollection services) {
    services
    .AddHttpClient()
    .AddHttpClient(
      "github", 
      c => {
        c.BaseAddress = new Uri("https://api.github.com/");
        // Github API versioning
        c.DefaultRequestHeaders.Add("Accept", "application/vnd.github.v3+json");
        // Github requires a user-agent
        c.DefaultRequestHeaders.Add("User-Agent", "HttpClientFactory-Sample");
      }
    )
    .AddHttpClient<GitHubService>()

    // Remaining code deleted for brevity.
  }
}
public class BasicUsageModel : PageModel {
  private readonly IHttpClientFactory _clientFactory;
  public IEnumerable<GitHubBranch> Branches { get; private set; }
  public bool GetBranchesError { get; private set; }

  private readonly GitHubService _gitHubService;
  public IEnumerable<GitHubIssue> LatestIssues { get; private set; }
  public bool HasIssue => LatestIssues.Any();
  public bool GetIssuesError { get; private set; }

  public BasicUsageModel(
    IHttpClientFactory clientFactory, 
    GitHubService gitHubService
  ) {
    _clientFactory = clientFactory;
    _gitHubService = gitHubService;
  }

  public async Task OnGet() {
    // use of basic client:
    var request = new HttpRequestMessage(HttpMethod.Get,
        "https://api.github.com/repos/aspnet/AspNetCore.Docs/branches");
    request.Headers.Add("Accept", "application/vnd.github.v3+json");
    request.Headers.Add("User-Agent", "HttpClientFactory-Sample");
    var client = _clientFactory.CreateClient();

    // use of named client:
    var request = new HttpRequestMessage(HttpMethod.Get,
            "repos/aspnet/AspNetCore.Docs/branches");
    var client = _clientFactory.CreateClient("github");

    // do work
    var response = await client.SendAsync(request);
    if (response.IsSuccessStatusCode) {
      using var responseStream = await response.Content.ReadAsStreamAsync();
      Branches = await JsonSerializer.DeserializeAsync
          <IEnumerable<GitHubBranch>>(responseStream);
    }
    else {
      GetBranchesError = true;
      Branches = Array.Empty<GitHubBranch>();
    }


    // use of typed client
    try {
      LatestIssues = await _gitHubService.GetAspNetDocsIssues();
    }
    catch(HttpRequestException) {
      GetIssuesError = true;
      LatestIssues = Array.Empty<GitHubIssue>();
    }
  }
}

public class GitHubService {
  public HttpClient Client { get; }

  public GitHubService(HttpClient client) {
    client.BaseAddress = new Uri("https://api.github.com/");
    // GitHub API versioning
    client.DefaultRequestHeaders.Add("Accept",
        "application/vnd.github.v3+json");
    // GitHub requires a user-agent
    client.DefaultRequestHeaders.Add("User-Agent",
        "HttpClientFactory-Sample");

    Client = client;
  }

  public async Task<IEnumerable<GitHubIssue>> GetAspNetDocsIssues()
  {
    var response = await Client.GetAsync(
        "/repos/aspnet/AspNetCore.Docs/issues?state=open&sort=created&direction=desc");

    response.EnsureSuccessStatusCode();

    using var responseStream = await response.Content.ReadAsStreamAsync();
    return await JsonSerializer.DeserializeAsync
        <IEnumerable<GitHubIssue>>(responseStream);
  }
}
```

## HttpMethod

https://docs.microsoft.com/en-us/dotnet/api/system.net.http.httpmethod?view=netcore-3.1

| Property | Description                                                                         |
|----------|-------------------------------------------------------------------------------------|
| Delete   | HTTP DELETE protocol method                                                         |
| Get      | HTTP GET protocol method                                                            |
| Head     | HTTP HEAD protocol method. GET without a message-body                               |
| Method   | HTTP method                                                                         |
| Options  | HTTP OPTIONS protocol method                                                        |
| Patch    | Gets the HTTP PATCH protocol method                                                 |
| Post     | HTTP POST protocol method that is used to post a new entity as an addition to a URI |
| Put      | HTTP PUT protocol method that is used to replace an entity identified by a URI      |
| Trace    | HTTP TRACE protocol method                                                          |


```cs
public async Task SaveItemAsync(TodoItem todoItem) {
  var todoItemJson = new StringContent(
      JsonSerializer.Serialize(todoItem),
      Encoding.UTF8,
      "application/json");

  using var httpResponse =
      await _httpClient.PutAsync($"/api/TodoItems/{todoItem.Id}", todoItemJson);

  httpResponse.EnsureSuccessStatusCode();
}
```

## Content types

- `System.Net.Http.StringContent`
- `System.Net.Http.ByteArrayContent`
- `System.Net.Http.MultipartContent`
- `System.Net.Http.ReadOnlyMemoryContent`
- `System.Net.Http.StreamContent`
- `System.Net.Http.Json.JsonContent`


## client middleware

`HttpClient` has the concept of delegating handlers that can
be linked together for outgoing HTTP requests. 

To create a delegating handler:

- Derive from `DelegatingHandler`.
- Override `SendAsync`. Execute code before passing the
  request to the next handler in the pipeline

(**An `IHttpClientBuilder` is returned when adding named or typed clients.**)


```cs
public void ConfigureServices(IServiceCollection services)
{
  services.AddTransient<ValidateHeaderHandler>();
  services.AddHttpClient(
    "externalservice", 
    c => {
      // Assume this is an "external" service which requires an API KEY
      c.BaseAddress = new Uri("https://localhost:5001/");
    }
  )
    // client are connections, they are reused
    // to prevent infinite connections, max lifetime can be set
    // IHttpClientFactory tracks and disposes resources used by HttpClient instances.
    .SetHandlerLifetime(TimeSpan.FromMinutes(5))
    .AddHttpMessageHandler<ValidateHeaderHandler>();

  // Remaining code deleted for brevity.
}

public class ValidateHeaderHandler : DelegatingHandler
{
    protected override async Task<HttpResponseMessage> SendAsync(
        HttpRequestMessage request,
        CancellationToken cancellationToken)
    {
        if (!request.Headers.Contains("X-API-KEY"))
        {
            return new HttpResponseMessage(HttpStatusCode.BadRequest)
            {
                Content = new StringContent(
                    "You must supply an API key header called X-API-KEY")
            };
        }

        return await base.SendAsync(request, cancellationToken);
    }
}
```

## Alternatives to IHttpClientFactory

https://docs.microsoft.com/en-us/aspnet/core/fundamentals/http-requests?view=aspnetcore-3.1#alternatives-to-ihttpclientfactory

Using `IHttpClientFactory` in a DI-enabled app avoids:

- Resource exhaustion problems by pooling `HttpMessageHandler`
  instances.
- Stale DNS problems by cycling `HttpMessageHandler` instances
  at regular intervals.

There are alternative ways to solve the preceding problems
using a long-lived `SocketsHttpHandler` instance.

- Create an instance of `SocketsHttpHandler` when the app
  starts and use it for the life of the app.
- Configure `PooledConnectionLifetime` to an appropriate value
  based on DNS refresh times.
- Create HttpClient instances using 
  `new HttpClient(handler, disposeHandler: false)` as needed.

The preceding approaches solve the resource management
problems that `IHttpClientFactory` solves in a similar way.

- The `SocketsHttpHandler` shares connections across
  `HttpClient` instances. This sharing prevents socket
  exhaustion.
- The `SocketsHttpHandler` cycles connections according to
  `PooledConnectionLifetime` to avoid stale DNS problems.


## IHttpClientFactory and Cookies

The pooled `HttpMessageHandler` instances results in
`CookieContainer` objects being shared. Unanticipated
`CookieContainer` object sharing often results in incorrect
code. For apps that require cookies, consider either:

    Disabling automatic cookie handling
    Avoiding `IHttpClientFactory`

Call `ConfigurePrimaryHttpMessageHandler` to disable automatic cookie handling:

```cs
services
.AddHttpClient("configured-disable-automatic-cookies")
.ConfigurePrimaryHttpMessageHandler(
  () => {
    return new SocketsHttpHandler(){
      UseCookies = false,
    };
  }
);
```

## HttpClient Logging

The log category used for each client includes the name of
the client. A client named `MyNamedClient`, for example,
logs messages with a category of
`"System.Net.Http.HttpClient.MyNamedClient.LogicalHandler"`.
Messages suffixed with `LogicalHandler` occur outside the
request handler pipeline. On the request, messages are
logged before any other handlers in the pipeline have
processed it. On the response, messages are logged after any
other pipeline handlers have received the response.


Logging also occurs inside the request handler pipeline. In
the `MyNamedClient` example, those messages are logged with
the log category
`"System.Net.Http.HttpClient.MyNamedClient.ClientHandler"`.
For the request, this occurs after all other handlers have
run and immediately before the request is sent. On the
response, this logging includes the state of the response
before it passes back through the handler pipeline.


## HttpClient Configure the HttpMessageHandler

```cs
public void ConfigureServices(IServiceCollection services) {            
    services
    .AddHttpClient("configured-inner-handler")
      .ConfigurePrimaryHttpMessageHandler(
        () => {
          return new HttpClientHandler() {
              AllowAutoRedirect = false,
              UseDefaultCredentials = true
          };
        }
      );

    //
    // Remaining code deleted for brevity.
}
```

## Using HttpClient without other bullshit (in Console e.g.)

In a console app, add the following package references to
the project:

- `Microsoft.Extensions.Hosting`
- `Microsoft.Extensions.Http`

In the following example:

- `IHttpClientFactory` is registered in the Generic Host's
  service container.
- `MyService` creates a client factory instance from the
  service, which is used to create an `HttpClient`.
  `HttpClient` is used to retrieve a webpage.
- `Main` creates a scope to execute the service's `GetPage`
  method and write the first 500 characters of the webpage
  content to the console.


```cs
using System;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

class Program {
  static async Task<int> Main(string[] args) {
    var builder = new HostBuilder()
    .ConfigureServices(
      (hostContext, services) => {
        services.AddHttpClient();
        services.AddTransient<IMyService, MyService>();
      }
    )
    .UseConsoleLifetime();


    var host = builder.Build();
    using (var serviceScope = host.Services.CreateScope()) {
      var services = serviceScope.ServiceProvider;
      try {
        var myService = services.GetRequiredService<IMyService>();
        var pageContent = await myService.GetPage();
        Console.WriteLine(pageContent.Substring(0, 500));
      }
      catch (Exception ex) {
        var logger = services.GetRequiredService<ILogger<Program>>();
        logger.LogError(ex, "An error occurred.");
      }
    }

    return 0;
  }

  public interface IMyService {
    Task<string> GetPage();
  }

  public class MyService : IMyService {
    private readonly IHttpClientFactory _clientFactory;
    public MyService(IHttpClientFactory clientFactory) {
        _clientFactory = clientFactory;
    }

    public async Task<string> GetPage() {
      // Content from BBC One: Dr. Who website (©BBC)
      var request = new HttpRequestMessage(HttpMethod.Get,
          "https://www.bbc.co.uk/programmes/b006q2x0");
      var client = _clientFactory.CreateClient();
      var response = await client.SendAsync(request);

      if (response.IsSuccessStatusCode) {
        return await response.Content.ReadAsStringAsync();
      }
      else {
        return $"StatusCode: {response.StatusCode}";
      }
    }
  }
}
```


# Static files

Static files, such as HTML, CSS, images, and JavaScript, are
assets an ASP.NET Core app serves directly to clients by
default.

Static files are stored within the project's web root
directory. The default directory is `{content root}/wwwroot`,
but it can be changed with the `UseWebRoot` method.

Web Application project templates contain several folders
within the `wwwroot` folder:

- `wwwroot`
  - `css`
  - `js`
  - `lib`

Consider creating the `wwwroot/images` folder:

- and adding the `wwwroot/images/MyImage.jpg` file. 
- The URI format to access a file in the images folder is 
  `https://<hostname>/images/<image_file_name>`. 
- For example, `https://localhost:5001/images/MyImage.jpg`


The following markup references `wwwroot/images/MyImage.jpg`:

```html
<img src="~/images/MyImage.jpg" class="img" alt="My image" />
```

## Serve files outside of web root and http response headers

For files:


- `wwwroot`
  - `css`
  - `images`
  - `js`
- `MyStaticFiles`
  - `images`
    - `red-rose.jpg`

```cs
public void Configure(IApplicationBuilder app, IWebHostEnvironment env) {

  // using Microsoft.Extensions.FileProviders;
  // using System.IO;
  app.UseStaticFiles(
    new StaticFileOptions {
      FileProvider = new PhysicalFileProvider(
        Path.Combine(env.ContentRootPath, "MyStaticFiles")
      ),
      RequestPath = "/StaticFiles",
      OnPrepareResponse = ctx => {
        // using Microsoft.AspNetCore.Http;
        ctx.Context.Response.Headers.Append(
          "Cache-Control", 
          // Static files are publicly cacheable for 600 seconds
          $"public, max-age=604800"
        );
      }
    }
  );

}
```

A request to
`https://<hostname>/StaticFiles/images/red-rose.jpg` serves
the `red-rose.jpg` file.

```html
<img src="~/StaticFiles/images/red-rose.jpg" class="img" alt="A red rose" />
```

## Static file authorization

The Static File Middleware doesn't provide authorization
checks. Any files served by it, including those under
`wwwroot`, are publicly accessible. To serve files based on
authorization:

- Store them outside of `wwwroot` and any directory
  accessible to the Static File Middleware.
- Serve them via an action method to which authorization is
  applied and return a `FileResult` object:

```cs
[Authorize]
public IActionResult BannerImage()
{
  var filePath = Path.Combine(
    _env.ContentRootPath, 
    "MyStaticFiles", 
    "images", 
    "red-rose.jpg"
  );

  return PhysicalFile(filePath, "image/jpeg");
}
```

## Directory browsing

Directory browsing allows directory listing within specified
directories.  Directory browsing is disabled by default for
security reasons. 

Enable directory browsing with:

- `AddDirectoryBrowser` in `Startup.ConfigureServices`.
- `UseDirectoryBrowser` in `Startup.Configure`.

```cs
public void ConfigureServices(IServiceCollection services)
{
    services.AddControllersWithViews();
    services.AddDirectoryBrowser();
}

public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
{
    // using Microsoft.Extensions.FileProviders;
    // using System.IO;
    app.UseStaticFiles(
      new StaticFileOptions {
        FileProvider = new PhysicalFileProvider(
          Path.Combine(env.WebRootPath, "images")
        ),
        RequestPath = "/MyImages"
      }
    );

    app.UseDirectoryBrowser(
      new DirectoryBrowserOptions {
        FileProvider = new PhysicalFileProvider(
          Path.Combine(env.WebRootPath, "images")
        ),
        RequestPath = "/MyImages"
      }
    );
}
```

## Serve default documents

https://docs.microsoft.com/en-us/aspnet/core/fundamentals/static-files?view=aspnetcore-3.1#serve-default-documents

## UseFileServer for default documents

`UseFileServer` combines the functionality of
`UseStaticFiles`, `UseDefaultFiles`, and optionally
`UseDirectoryBrowser`.

Call `app.UseFileServer` to enable the serving of static
files and the default file. Directory browsing isn't
enabled. The following code shows `Startup.Configure` with
`UseFileServer`:

```cs
public void ConfigureServices(IServiceCollection services) {
  services.AddDirectoryBrowser();
}
public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
{
    app.UseStaticFiles(); // For the wwwroot folder.

    // using Microsoft.Extensions.FileProviders;
    // using System.IO;
    app.UseFileServer(
      new FileServerOptions {
        FileProvider = new PhysicalFileProvider(
          Path.Combine(env.ContentRootPath, "MyStaticFiles")
        ),
        RequestPath = "/StaticFiles",
        EnableDirectoryBrowsing = true
      }
    );
}
```

- URI: `https://<hostname>/StaticFiles/images/MyImage.jpg`
  - response: `MyStaticFiles/images/MyImage.jpg`
- URI: `https://<hostname>/StaticFiles`
  - response: `MyStaticFiles/default.html`
  - If no default-named file exists in the `MyStaticFiles`
    directory, response: the directory listing with
    clickable links

`UseDefaultFiles` and `UseDirectoryBrowser` perform a
client-side redirect from the target URI without a trailing
`/` to the target URI with a trailing `/`. 

- For example, from `https://<hostname>/StaticFiles` to
  `https://<hostname>/StaticFiles/`
- Relative URLs within the StaticFiles directory are invalid
  without a trailing slash (`/`).


## Connecting file extensions with MIME content type

- The Static File Middleware understands almost 400 known
  file content types. 
- If the user requests a file with an unknown file type, the
  Static File Middleware passes the request to the next
  middleware in the pipeline. 
  - If no middleware handles the request, a 404 Not Found
    response is returned. 
    - This behaviour can be changed using
      `StaticFileOptions.ServeUnknownFileTypes`
      - Enabling ServeUnknownFileTypes is a security risk.
        It's disabled by default, and its use is
        discouraged.  `FileExtensionContentTypeProvider`
        provides a safer alternative to serving files with
        non-standard extensions.
  - If directory browsing is enabled, a link to the file is
    displayed in a directory listing.


```cs
public void Configure(IApplicationBuilder app, IWebHostEnvironment env) {
  // using Microsoft.AspNetCore.StaticFiles;
  // using Microsoft.Extensions.FileProviders;
  // using System.IO;

  // Set up custom content types - associating file extension to MIME type
  var provider = new FileExtensionContentTypeProvider();
  provider.Mappings[".myapp"] = "application/x-msdownload"; // Add new mapping
  provider.Mappings[".htm3"] = "text/html";                 // Add new mapping
  provider.Mappings[".image"] = "image/png";                // Add new mapping
  provider.Mappings[".rtf"] = "application/x-msdownload";   // Replace mapping
  provider.Mappings.Remove(".mp4");                         // Remove mapping

  app.UseStaticFiles(
    new StaticFileOptions {
      FileProvider = new PhysicalFileProvider(
        Path.Combine(env.WebRootPath, "images")
      ),
      RequestPath = "/MyImages",
      ContentTypeProvider = provider,                       // Connect mappings
      ServeUnknownFileTypes = true,                         // Serve unmapped
      DefaultContentType = "image/png"                      // Type of unmapped
    }
  );
}
```

# Razor Pages

**Razor synthax!!!!** is here:

https://docs.microsoft.com/en-us/aspnet/core/mvc/views/razor?view=aspnetcore-3.1

Overview of razor is here:

https://docs.microsoft.com/en-us/aspnet/core/razor-pages/?view=aspnetcore-3.1&tabs=visual-studio-code

**Typically it is technology for server served filled html pages.**

Create template proj:

```sh
dotnet new webapp
```

```cs
public void ConfigureServices(IServiceCollection services) {
    services.AddRazorPages();
}
public void Configure(IApplicationBuilder app, IWebHostEnvironment env) {
    app.UseEndpoints(
      endpoints => {
        endpoints.MapRazorPages();
      }
    );
}
```

## Page - Razor view file

- `@page` makes the file into an MVC action - which means
  that it handles requests directly, without going through a
  controller. 
- `@page` must be the first Razor directive on a page. 
- `@page` affects the behavior of other Razor constructs. 
- Razor Pages file names have a `.cshtml` suffix.

```html
@page

<h1>Hello, world!</h1>
<h2>The time on the server is @DateTime.Now</h2>
```


## Page Model

- `@model name` connects page with context
- `public class name : PageModel {}` provides implementation

```html
@page
@using RazorPagesIntro.Pages
@model Index2Model

<h2>Separate page model</h2>
<p>
    @Model.Message
</p>
```

```csharp
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;
using System;

namespace RazorPagesIntro.Pages {
  public class Index2Model : PageModel {
    public string Message { get; private set; } = "PageModel in C#";
    public void OnGet() {
      Message += $" Server time is { DateTime.Now }";
    }
  }
}
```

Connections works as in example:

| File name and path            | matching URL             |
|-------------------------------|--------------------------|
| `/Pages/Index.cshtml`         | `/` or `/Index`          |
| `/Pages/Contact.cshtml`       | `/Contact`               |
| `/Pages/Store/Contact.cshtml` | `/Store/Contact`         |
| `/Pages/Store/Index.cshtml`   | `/Store or /Store/Index` |


## Basic form example


```cs
// Here is minimal configuration, database is needed
public class Startup {
  public void ConfigureServices(IServiceCollection services) {
    services.AddDbContext<CustomerDbContext>(
      options => options.UseInMemoryDatabase("name")
    );
    services.AddRazorPages();
  }
}


// Here is data model:
namespace RazorPagesContacts.Models {
  using System.ComponentModel.DataAnnotations;
  public class Customer {
    public int Id { get; set; }
    [Required, StringLength(10)]
    public string Name { get; set; }
  }
}


// here is connection to database (db context):
namespace RazorPagesContacts.Data {
  using Microsoft.EntityFrameworkCore;
  using RazorPagesContacts.Models;
  public class CustomerDbContext : DbContext {
    public CustomerDbContext(DbContextOptions options)
        : base(options)
    {
    }
    public DbSet<Customer> Customers { get; set; }
  }
}

// here is page model
namespace RazorPagesContacts.Pages.Customers {
  using Microsoft.AspNetCore.Mvc;
  using Microsoft.AspNetCore.Mvc.RazorPages;
  using RazorPagesContacts.Data;
  using RazorPagesContacts.Models;
  using System.Threading.Tasks;
  public class CreateModel : PageModel {
    private readonly CustomerDbContext _context;
    public CreateModel(CustomerDbContext context) {
      _context = context;
    }
    [BindProperty]
    public Customer Customer { get; set; }

    public IActionResult OnGet() {
      return Page();
    }
    public async Task<IActionResult> OnPostAsync() {
      if (!ModelState.IsValid) {
        return Page();
      }
      _context.Customers.Add(Customer);
      await _context.SaveChangesAsync();
      return RedirectToPage("./Index");
    }
  }
}
```

Here is view:

```html
@page
@model RazorPagesContacts.Pages.Customers.CreateModel
@addTagHelper *, Microsoft.AspNetCore.Mvc.TagHelpers

<p>Enter a customer name:</p>

<form method="post">
    Name:
    <input asp-for="Customer.Name" />
    <input type="submit" />
</form>
```

The rendered HTML from `Pages/Create.cshtml`:

```html
<p>Enter a customer name:</p>

<form method="post">
    Name:
    <input type="text" data-val="true"
           data-val-length="The field Name must be a string with a maximum length of 10."
           data-val-length-max="10" data-val-required="The Name field is required."
           id="Customer_Name" maxlength="10" name="Customer.Name" value="" />
    <input type="submit" />
    <input name="__RequestVerificationToken" type="hidden"
           value="<Antiforgery token here>" />
</form>
```


# Model View Controller (MVC)

MVC contains fundamental parts, where:

- View - offers display and possible actions, it uses view model for data synchronization
- View model - data shaped for use by view
- Model - independent data
- Controller - flow and logic backed on model plus display


## Straight example!

Lets display variable named "Message":

```cs
// Paths are important for connectiong!!!
// /Controllers/HomeController.cs
public class HomeController : Controller {
  public IActionResult About() {
    ViewData["Message"] = "Your application description page.";
    return View();
  }
}
```

This is how it will be displayed:

```html
@* Paths are important for connectiong!!!: *@
@* /Views/Home/About.cshtml *@
@{
    ViewData["Title"] = "About";
}
<h2>@ViewData["Title"].</h2>
<h3>@ViewData["Message"]</h3>

<p>Use this area to provide additional information.</p>
```


## Controller view discovery

When an action returns a view, a process called view discovery takes place.

- The default behavior of the View method (`return View();`)
  is to return a view with the same name as the action
  method from which it's called.
  - For example, the `About` `ActionResult` method name of
    the controller is used to search for a view file named
    `About.cshtml`. 
- It doesn't matter if you implicitly return the ViewResult
  with `return View();` or explicitly pass the view name to
  the View method with `return View("<ViewName>");`. In both
  cases, view discovery searches for a matching view file in
  this order:
  - `Views/[ControllerName]/[ViewName].cshtml`
  - `Views/Shared/[ViewName].cshtml`


## Controller --> ViewModel (Passing data to views) 


Lets have address structure filled with some particular
values, here is how to display it (serve client request):

```cs
namespace WebApplication1.ViewModels {
  public class Address {
    public string Name { get; set; }
    public string Street { get; set; }
    public string City { get; set; }
    public string State { get; set; }
    public string PostalCode { get; set; }
  }
}
namespace WebApplication1.Controllers {
  public class MyController : Controller {
    public IActionResult Contact() {
      ViewData["Message"] = "Your contact page.";

      var viewModel = new Address()
      {
        Name = "Microsoft",
        Street = "One Microsoft Way",
        City = "Redmond",
        State = "WA",
        PostalCode = "98052-6399"
      };

      return View(viewModel);
      // or more verbosely:
      // return View("Views/MyController/Contact.cshtml", viewModel);
    }
  }
}
```

And here is how to generate markup
(`Views/MyController/Contact.cshtml`):

```html
@model WebApplication1.ViewModels.Address
@* above connets this view with viewModel of type Address *@

<h2>Contact</h2>
<address>
    @Model.Street<br>
    @Model.City, @Model.State @Model.PostalCode<br>
    <abbr title="Phone">P:</abbr> 425.555.0100
</address>
```

## Action

Ready steady go! Action! Group of those is Controller.

An action (or action method) is a method on a controller
which handles requests.

**Requests are mapped to actions through routing.**

By convention, controller classes:

- Reside in the project's root-level Controllers folder.
- Inherit from Microsoft.AspNetCore.Mvc.Controller.

A controller is an instantiable class in which at least one of the following conditions is true:

- The class name is suffixed with Controller.
- The class inherits from a class whose name is suffixed with Controller.
- The [Controller] attribute is applied to the class.
- A controller class must not have an associated [NonController] attribute.


A controller is responsible for the initial processing of
the request and instantiation of the model.

The controller takes the result of the model's processing
(if any) and returns either the proper view and its
associated view data or the result of the API call. 

**Public methods on a controller, except those with the [NonAction] attribute, are actions.**

Controllers usually inherit from Controller, although this
isn't required.


## Routing

ASP.NET Core controllers use the Routing middleware to match
the URLs of incoming requests and map them to actions.
Routes templates:

- Are defined in startup code or attributes.
- Describe how URL paths are matched to actions.
- Are used to generate URLs for links. The generated links
  are typically returned in responses.

Actions are either: 

- conventionally-routed or 
- attribute-routed.

Routing is configured using the `UseRouting` and
`UseEndpoints` middleware. To use controllers:

- Call `MapControllers` inside `UseEndpoints` to map
  attribute routed controllers.
- Call `MapControllerRoute` or `MapAreaControllerRoute`, to
  map both conventionally routed controllers and attribute
  routed controllers.


## Conventional Routing

It's called conventional routing because it establishes a convention for URL paths:

- The first path segment, `{controller=Home}`, maps to the
  controller name.
- The second segment, `{action=Index}`, maps to the action
  name.
- The third segment, `{id?}` is used for an optional id. The
  `?` in `{id?}` makes it optional. id is used to map to a
  model entity.

Using this default route, the URL path:

- `/Products/List` maps to the `ProductsController.List`
  action.
- `/Blog/Article/17` maps to `BlogController.Article` and
  typically model binds the `id` parameter to 17.

Conventional routing mapping:

- Is based on the controller and action names only.
- Isn't based on namespaces, source file locations, or
  method parameters.


## Dedicated conventional route

It's called so because:

- It uses conventional routing.
- It's dedicated to a specific action.

Because controller and action don't appear in the route
template `"blog/{*article}"` as parameters:

- They can only have the default values `{ controller =
  "Blog", action = "Article" }`.
- This route always maps to the action
  `BlogController.Article`.

`/Blog`, `/Blog/Article`, and `/Blog/{any-string}` are the
only URL paths that match the blog route.

The preceding example:

- `blog` route has a higher priority for matches than the
  `default` route because it is added first.
- Is an example of Slug style routing where it's typical to
  have an article name as part of the URL.

## Route name vs. endpoint name

The route name concept is represented in routing as
`IEndpointNameMetadata`.  The terms route name and endpoint
name: **are interchangeable**.

## MVC routing example

The route template `"{controller=Home}/{action=Index}/{id?}"`:
matches a URL path like `/Products/Details/5` in the following way:

- It extracts the route values 
  `{ controller = Products, action = Details, id = 5 }` 
- The extraction of route values results in a match if 
  - the app has a controller named `ProductsController` 
  - and a `Details`


```cs
public class ProductsController : Controller {
  public IActionResult Details(int id) {
    return ControllerContext.MyDisplayRouteInfo(id);
  }
  /*
    Below are two actions that match:
    - The URL path /Products33/Edit/17
    - Route data { controller = Products33, action = Edit, id = 17 }.
    This is a typical pattern for MVC controllers:
    - Edit(int) displays a form to edit a product.
    - Edit(int, Product) processes the posted form.
    To resolve the correct route:
    - Edit(int, Product) is selected when the request is an HTTP POST.
    - Edit(int) is selected when the HTTP verb is anything else. 
      Edit(int) is generally called via GET.

    If routing can't choose a best candidate, 
    an AmbiguousMatchException is thrown.
  */
  public IActionResult Edit(int id){
    return ControllerContext.MyDisplayRouteInfo(id);
  }
  [HttpPost]
  public IActionResult Edit(int id, Product product) {
    return ControllerContext.MyDisplayRouteInfo(id, product.name);
  }
}

public class Startup {
  public Startup(IConfiguration configuration) {
      Configuration = configuration;
  }
  public IConfiguration Configuration { get; }
  public void ConfigureServices(IServiceCollection services) {
      services.AddControllers();
  }
  public void Configure(IApplicationBuilder app, IWebHostEnvironment env) {
    app.UseEndpoints(
      endpoints => {
        // dedicated conventional route
        endpoints.MapControllerRoute(name: "blog",
                pattern: "blog/{*article}",
                defaults: new { controller = "Blog", action = "Article" });

        // default conventional route
        endpoints.MapControllerRoute(
          name: "default",
          pattern: "{controller=Home}/{action=Index}/{id?}"
        );
        // above is equivalent to:
        // endpoints.MapDefaultControllerRoute();
      }
    );

    return;
  }
}

public class Program {
  public static void Main(string[] args) {

    // A catch-all parameter may match routes incorrectly due to a bug in routing.
    // An opt-in fix for this bug is contained in .NET Core 3.1.301 SDK and later. 
    // The following code sets an internal switch that fixes this bug:
    AppContext.SetSwitch(
      "Microsoft.AspNetCore.Routing.UseCorrectCatchAllBehavior", 
      true
    );
    CreateHostBuilder(args).Build().Run();
  }
}
```

## Attribute routing for REST APIs

Attribute routing uses a set of attributes to map actions
directly to route templates.

The following keywords are reserved route parameter names
when using Controllers or Razor Pages:

- action
- area
- controller
- handler
- page

Using page as a route parameter with attribute routing is a
common error. Doing that results in inconsistent and
confusing behavior with URL generation.

ASP.NET Core has the following HTTP verb templates:

- [HttpGet]
- [HttpPost]
- [HttpPut]
- [HttpDelete]
- [HttpHead]
- [HttpPatch]


```cs
public class HomeController : Controller {
  [Route("")]
  [Route("Home")]
  [Route("[controller]/[action]")] // == [Route("Home/Index")]
  public IActionResult Index() {
    return ControllerContext.MyDisplayRouteInfo();
  }

  [Route("[controller]/[action]")] // == [Route("Home/About")]
  public IActionResult About() {
    return ControllerContext.MyDisplayRouteInfo();
  }
}

[Route("[controller]/[action]")]
public class Home2Controller : Controller {
  [Route("~/")]
  [Route("/Home2")]
  [Route("~/Home2/Index")]
  public IActionResult Index() {
    return ControllerContext.MyDisplayRouteInfo();
  }

  // == [Route("Home2/About")]
  public IActionResult About() {
    return ControllerContext.MyDisplayRouteInfo();
  }
}


[Route("api/[controller]")]
[ApiController]
public class Test2Controller : ControllerBase {
  [HttpGet]   // GET /api/test2
  public IActionResult ListProducts() {
    return ControllerContext.MyDisplayRouteInfo();
  }
  [HttpGet("{id}")]   // GET /api/test2/xyz
  public IActionResult GetProduct(string id) {
    return ControllerContext.MyDisplayRouteInfo(id);
  }
  [HttpGet("int/{id:int}")] // GET /api/test2/int/3
  public IActionResult GetIntProduct(int id) {
    return ControllerContext.MyDisplayRouteInfo(id);
  }
  /*
    The GetInt2Product action contains {id} in the template, but doesn't 
    constrain id to values that can be converted to an integer. 
    A GET request to /api/test2/int2/abc:

    - Matches this route.
    - Model binding fails to convert abc to an integer. 
      The id parameter of the method is integer.
    - Returns a 400 Bad Request because model binding 
      failed to convertabc to an integer.
   */
  [HttpGet("int2/{id}")]  // GET /api/test2/int2/3
  public IActionResult GetInt2Product(int id) {
    return ControllerContext.MyDisplayRouteInfo(id);
  }
  [HttpGet("/products3")]
  public IActionResult ListProducts() {
    return ControllerContext.MyDisplayRouteInfo();
  }
  [HttpPost("/products3")]
  [HttpPost("Checkout")]  // Matches POST 'api/test2/Checkout'
  public IActionResult CreateProduct(MyProduct myProduct) {
    return ControllerContext.MyDisplayRouteInfo(myProduct.Name);
  }
}

public class Startup {
  public Startup(IConfiguration configuration) {
      Configuration = configuration;
  }
  public IConfiguration Configuration { get; }
  public void ConfigureServices(IServiceCollection services) {
      services.AddControllers();
  }
  public void Configure(IApplicationBuilder app, IWebHostEnvironment env) {
    app.UseEndpoints(
      endpoints => {
        // enable attribute routing
        endpoints.MapControllers();
      }
    );

    return;
  }
}
```

## Route order

**Attribute Routing** builds a tree and matches all endpoints
simultaneously:

- The route entries behave as if placed in an ideal
  ordering.
- The most specific routes have a chance to execute before
  the more general routes.

**Conventional routing**, the developer is responsible for
placing routes in the desired order.


## Routing Token replacement in route templates: [controller], [action], [area]

For convenience, attribute routes support token replacement
for reserved route parameters by enclosing a token in one of
the following:

- Square brackets: []
- Curly braces: {}

The tokens:

- `[action]` is replaced with action name, 
- `[area]` is replaced with area name, 
- `[controller]` is replaced with controller name 

from the action where the route is defined.

Token replacement occurs as the last step of building the
attribute routes. 


Routing tockens + inheiratance example:

```cs
[ApiController]
[Route("api/[controller]/[action]", Name = "[controller]_[action]")]
public abstract class MyBase2Controller : ControllerBase {}

public class Products11Controller : MyBase2Controller {
   // /api/products11/
  [HttpGet]                     
  public IActionResult List() {
    return ControllerContext.MyDisplayRouteInfo();
  }
  // /api/products11/edit/3
  [HttpGet("{id}")]              
  public IActionResult Edit(int id) {
    return ControllerContext.MyDisplayRouteInfo(id);
  }
}
```

## Route to action mapping global transformation

Example normal routing table with entier (route => action), for example:

`/SubscriptionManagement/ListAll` => `SubscriptionManagementController.ListAll`

May be transformed to (diffrent_route(route) => action), for example:

`/subscription-management/list-all` => `SubscriptionManagementController.ListAll`

This can be done creating `IOutboundParameterTransformer` instance, and
registering it inside `services.AddControllersWithViews` delegate.

```cs
public class SubscriptionManagementController : Controller {
    [HttpGet("[controller]/[action]")] // = SubscriptionManagement/ListAll
    public IActionResult ListAll() {
        return ControllerContext.MyDisplayRouteInfo();
    }
}

// this changes CamelCase to camel-case
public class SlugifyParameterTransformer : IOutboundParameterTransformer {
    public string TransformOutbound(object value) {
        if (value == null) { return null; }
        return Regex.Replace(
          value.ToString(),
          "([a-z])([A-Z])", // <- first change from lower to upper letter
          "$1-$2",
          RegexOptions.CultureInvariant,
          TimeSpan.FromMilliseconds(100)
        ).ToLowerInvariant();
    }
}

public void ConfigureServices(IServiceCollection services)
{
  services.AddControllersWithViews(
    options => {
      options.Conventions.Add(               // <-- additionally
        new RouteTokenTransformerConvention( // <-- transform all route tokens
          new SlugifyParameterTransformer()  // <-- in this way
        )
      );
    }
  );
}
```

## URL Generation

There is reverse mapping: `Action => URL`.

One may not specify full action addres, because
link generation is usually in context of other
action, and base on this full action address can
be deduced.

Example:

```cs
public class UrlGenerationController : Controller {
    public IActionResult Source() {
      // Generates /UrlGeneration/Destination
      var url = Url.Action("Destination");
      return ControllerContext.MyDisplayRouteInfo("", $" URL = {url}");
    }

    public IActionResult Destination() {
      return ControllerContext.MyDisplayRouteInfo();
    }
}
/* 
ambient vals:              { controller = "UrlGeneration", action = "Source" }
vals passed to Url.Action: { action = "Destination" }
route template:            {controller}/{action}/{id?}

result:                    /UrlGeneration/Destination
*/
```

## Area routes

```cs
app.UseEndpoints(
  endpoints => {

    // endpoints.MapAreaControllerRoute(
    //   "blog_route", 
    //   "Blog",
    //   "Manage/{controller}/{action}/{id?}"
    // ); // (evivalent to following)
    endpoints.MapControllerRoute(
      "blog_route", 
      "Manage/{controller}/{action}/{id?}",
      defaults: new { area = "Blog" }, 
      constraints: new { area = "Blog" }
    );

    endpoints.MapControllerRoute(
      "default_route", 
      "{controller}/{action}/{id?}"
    );
});


using Microsoft.AspNetCore.Mvc;

namespace MyApp.Namespace1 {
  [Area("Blog")]
  public class UsersController : Controller {
    // GET /manage/users/adduser
    public IActionResult AddUser() {
      var area = ControllerContext.ActionDescriptor.RouteValues["area"];
      var actionName = ControllerContext.ActionDescriptor.ActionName;
      var controllerName = ControllerContext.ActionDescriptor.ControllerName;

      return Content(
        $"area name:{area}" +
        $" controller:{controllerName}" +
        $" action name: {actionName}"
      );
    }        
  }
}

using Microsoft.AspNetCore.Mvc;

namespace MyApp.Namespace4 {
  [Area("Duck")]
  public class UsersController : Controller {
    // GET /Manage/users/GenerateURLInArea
    public IActionResult GenerateURLInArea() {
      // Uses the 'ambient' value of area.
      var url = Url.Action("Index", "Home");
      // Returns /Manage/Home/Index
      return Content(url);
    }
    // GET /Manage/users/GenerateURLOutsideOfArea
    public IActionResult GenerateURLOutsideOfArea() {
      // Uses the empty value for area.
      var url = Url.Action("Index", "Home", new { area = "" });
      // Returns /Manage
      return Content(url);
    }
  }
}

public class HomeController : Controller {
  public IActionResult About() {
    var url = Url.Action("AddUser", "Users", new { Area = "Zebra" });
    return Content($"URL: {url}");
  }
}
```

## Action injection with FromServices

The FromServicesAttribute enables injecting a service
directly into an action method without using constructor
injection:

```cs
public IActionResult About([FromServices] IDateTime dateTime) {
    return Content( $"Current server time: {dateTime.Now}" );
}
```

## Access settings from a controller

How to inject only reelevant options? :

```cs
// how fragment of configuration look like?
public class SampleWebSettings {
  public string Title { get; set; }
  public int Updates { get; set; }
}

// inject all options and register options fragment to be DI accessible
public class Startup {
  public IConfiguration Configuration { get; }
  private readonly IWebHostEnvironment _env;
  public Startup(IConfiguration configuration, IWebHostEnvironment env) {
    Configuration = configuration;
    _env = env;
  }

  // register in DI engine SampleWebSettings as part of Configuration
  public void ConfigureServices(IServiceCollection services) {
    services.AddSingleton<IDateTime, SystemDateTime>();
    // Configuration is 
    services.Configure<SampleWebSettings>(Configuration);

    services.AddControllersWithViews();
  }
}

// load into options from external file
public class Program {
  public static void Main(string[] args) {
    CreateHostBuilder(args).Build().Run();
  }

  public static IHostBuilder CreateHostBuilder(string[] args) =>  
    Host
    .CreateDefaultBuilder(args)
    .ConfigureAppConfiguration(
      (hostingContext, config) => {
        config.AddJsonFile(
          "samplewebsettings.json",
          optional: false,
          reloadOnChange: true
        );
      }
    )
    .ConfigureWebHostDefaults(
      webBuilder => {
        webBuilder.UseStartup<Startup>();
      }
    );
}

// inject fragment of configuration into controller
public class SettingsController : Controller {
  private readonly SampleWebSettings _settings;
  // constructor will be injected only with reelevant options!!!!
  public SettingsController(IOptions<SampleWebSettings> settingsOptions) {
    _settings = settingsOptions.Value;
  }
  public IActionResult Index() {
    ViewData["Title"] = _settings.Title;
    ViewData["Updates"] = _settings.Updates;
    return View();
  }
}
```

## view with configuration injection

For configuration loaded form example `appsettings.json`

```json
{
   "root": {
      "parent": {
         "child": "myvalue"
      }
   }
}
```

View can access child value in following way:

```html
@using Microsoft.Extensions.Configuration
@* @inject <type> <name> *@
@inject IConfiguration Configuration
@{
   string myValue = Configuration["root:parent:child"];
   ...
}
```

## view with service injection

```cs
using Microsoft.AspNetCore.Mvc;
using ViewInjectSample.Model;

namespace ViewInjectSample.Controllers {
  public class ProfileController : Controller {
    [Route("Profile")]
    public IActionResult Index() {
      // TODO: look up profile based on logged-in user
      var profile = new Profile() {
        Name = "Steve",
        FavColor = "Blue",
        Gender = "Male",
        State = new State("Ohio","OH")
      };
      return View(profile);
    }
  }
}

using System.Collections.Generic;

namespace ViewInjectSample.Model.Services {
  public class ProfileOptionsService {
    public List<string> ListGenders() {
      // keeping this simple
      return new List<string>() {"Female", "Male"};
    }
    public List<State> ListStates() {
      // a few states from USA
      return new List<State>() {
          new State("Alabama", "AL"),
          new State("Alaska", "AK"),
          new State("Ohio", "OH")
      };
    }
    public List<string> ListColors() {
      return new List<string>() { "Blue","Green","Red","Yellow" };
    }
  }
}
```

```html
@using System.Threading.Tasks
@using ViewInjectSample.Model.Services
@model ViewInjectSample.Model.Profile
@inject ProfileOptionsService Options
<!DOCTYPE html>
<html>
<head>
    <title>Update Profile</title>
</head>
<body>
<div>
    <h1>Update Profile</h1>
    Name: @Html.TextBoxFor(m => m.Name)
    <br/>
    Gender: @Html.DropDownList("Gender",
           Options.ListGenders().Select(g => 
                new SelectListItem() { Text = g, Value = g }))
    <br/>

    State: @Html.DropDownListFor(m => m.State.Code,
           Options.ListStates().Select(s => 
                new SelectListItem() { Text = s.Name, Value = s.Code}))
    <br />

    Fav. Color: @Html.DropDownList("FavColor",
           Options.ListColors().Select(c => 
                new SelectListItem() { Text = c, Value = c }))
    </div>
</body>
</html>
```




# Session management

Strategies:

| Storage approach  | Storage mechanism                                |
|-------------------|--------------------------------------------------|
| Cookies           | HTTP cookies. Server-side app code may interract |
| Session state     | HTTP cookies and server-side app code            |
| TempData          | HTTP cookies or session state                    |
| Query strings     | HTTP query strings                               |
| Hidden fields     | HTTP form fields                                 |
| HttpContext.Items | Server-side app code                             |
| Cache             | Server-side app code                             |


## Enabling session

To enable the session middleware, `Startup` must contain:

- Any of the `IDistributedCache` memory caches. The
  IDistributedCache implementation is used as a backing
  store for session. 
- A call to `AddSession` in `ConfigureServices`.
- A call to `UseSession` in `Configure`.

Usage:
- `HttpContext.Session` is available after session state is configured.

The default session provider in ASP.NET Core loads session
records from the underlying `IDistributedCache` backing
store asynchronously only if the `ISession.LoadAsync` method
is explicitly called before the `TryGetValue`, `Set`, or
`Remove` methods. If `LoadAsync` isn't called first, the
underlying session record is loaded synchronously, which can
incur a performance penalty at scale.

To have apps enforce this pattern, wrap the
`DistributedSessionStore` and `DistributedSession`
implementations with versions that throw an exception if the
`LoadAsync` method isn't called before `TryGetValue`, `Set`,
or `Remove`. Register the wrapped versions in the services
container.

## Session options

To override session defaults, use `SessionOptions`.
- `Cookie` - Determines the settings used to create the
  cookie. 
  - `Name` defaults to `SessionDefaults.CookieName`
    (`.AspNetCore.Session`). 
  - `Path` defaults to `SessionDefaults.CookiePath` (`/`). 
  - `SameSite` defaults to `SameSiteMode.Lax` (1). 
  - `HttpOnly` defaults to `true`. 
  - `IsEssential` defaults to `false`.
- `IdleTimeout` - The `IdleTimeout` indicates how long the
  session can be idle before its contents are abandoned.
  Each session access resets the timeout. This setting only
  applies to the content of the session, not the cookie. The
  default is 20 minutes.
- `IOTimeout` - The maximum amount of time allowed to load a
  session from the store or to commit it back to the store.
  This setting may only apply to asynchronous operations.
  This timeout can be disabled using `InfiniteTimeSpan`. The
  default is 1 minute.


## Set and get Session values

Session state is accessed from a Razor Pages PageModel class
or MVC Controller class with `HttpContext.Session`. This
property is an `ISession` implementation.

ISession extension methods:

- `Get(ISession, String)`
- `GetInt32(ISession, String)`
- `GetString(ISession, String)`
- `SetInt32(ISession, String, Int32)`
- `SetString(ISession, String, String)`


## Example


```cs
public class Startup {
  public Startup(IConfiguration configuration) {
    Configuration = configuration;
  }
  public IConfiguration Configuration { get; }
  public void ConfigureServices(IServiceCollection services) {
    services.AddDistributedMemoryCache();
    services.AddSession(
      options => {
        options.IdleTimeout = TimeSpan.FromSeconds(10);
        options.Cookie.HttpOnly = true;
        options.Cookie.IsEssential = true;
      }
    );
    services.AddControllersWithViews();
    services.AddRazorPages();
  }
  public void Configure(IApplicationBuilder app, IWebHostEnvironment env) {
    app.UseSession();
  }
}
```

## Query strings

A limited amount of data can be passed from one request to
another by adding it to the new request's query string. This
is useful for capturing state in a persistent manner that
allows links with embedded state to be shared through email
or social networks. Because URL query strings are public,
never use query strings for sensitive data.


## Hidden fields

Data can be saved in hidden form fields and posted back on
the next request. This is common in multi-page forms.
Because the client can potentially tamper with the data, the
app must always revalidate the data stored in hidden fields.

## HttpContext.Items

The `HttpContext.Items` collection is used to store data
while processing a single request. The collection's contents
are discarded after a request is processed. The `Items`
collection is often used to allow components or middleware
to communicate when they operate at different points in time
during a request and have no direct way to pass parameters.


## Cache

https://docs.microsoft.com/en-us/aspnet/core/fundamentals/app-state?view=aspnetcore-3.1#cache

- Caching is an efficient way to store and retrieve data.
  The app can control the lifetime of cached items. For more
  information, see Response caching in ASP.NET Core.
- Cached data isn't associated with a specific request,
  user, or session. Do not cache user-specific data that may
  be retrieved by other user requests.
- To cache application wide data, see Cache in-memory in
  ASP.NET Core.


# Tag helpers

Tag helpers are razor custom html tag mappings (macros).

https://docs.microsoft.com/en-us/aspnet/core/mvc/views/tag-helpers/built-in/?view=aspnetcore-3.1


# RESTful services (ASP.net Core APIs)

A web API consists of one or more controller classes that
derive from `ControllerBase`. (Controller also derives from
ControllerBase but adds support for views, so adds
functionality for handling web pages.)


`ControllerBase` have few usefull methods, some of them are:

- `CreatedAtAction` - returns a 201 status code.
- `BadRequest` - Returns 400 status code.
- `NotFound` - Returns 404 status code.
- `PhysicalFile` - Returns a file.
- `TryUpdateModelAsync` - Invokes model binding.
- `TryValidateModel` - Invokes model validation.


## API Attributes

The `Microsoft.AspNetCore.Mvc` namespace provides attributes
that can be used to configure the behavior of web API
controllers and action methods.

```cs
/*
  Attributes to specify 
  - the supported HTTP action verb and 
  - any known HTTP status codes that could be returned
*/
[HttpPost]
[ProducesResponseType(StatusCodes.Status201Created)]
[ProducesResponseType(StatusCodes.Status400BadRequest)]
public ActionResult<Pet> Create(Pet pet)
{
    pet.Id = _petsInMemoryStore.Any() ? 
             _petsInMemoryStore.Max(p => p.Id) + 1 : 1;
    _petsInMemoryStore.Add(pet);

    return CreatedAtAction(nameof(GetById), new { id = pet.Id }, pet);
}
```

Some useful attributes are:

- `[Route]` - Specifies URL pattern for a controller or
  action.
- `[Bind]` - Specifies prefix and properties to include for
  model binding.
- `[HttpGet]` - Identifies an action that supports the HTTP
  GET action verb.
- `[HttpPost]` - Identifies an action that supports the HTTP
  POST action verb.
- `[Consumes]` - Specifies data types that an action
  accepts.
- `[Produces]` - Specifies data types that an action
  returns.
- `[ApiController]` attribute can be applied to a controller
  class to enable the following opinionated, API-specific
  behaviors:
  - Attribute routing requirement
  - Automatic HTTP 400 responses
  - Binding source parameter inference
  - Multipart/form-data request inference
  - Problem details for error status codes
  - (Actions are inaccessible via conventional routes
    defined by `UseEndpoints`, `UseMvc`, or
    `UseMvcWithDefaultRoute` in `Startup.Configure`.)


```cs
// single controller will have [ApiController] attribute
[ApiController]
public class MyController : ControllerBase {
}
```

```cs
// Multiple child controllers have [ApiController] attribute
[ApiController]
public class MyControllerBase : ControllerBase {
}
```

```cs
// All controllers will have [ApiController] attribute
[assembly: ApiController]
namespace WebApiSample
{
    public class Startup
    {
        ...
    }
}
```

## Binding source parameter inference

A binding source attribute defines the location at which an
action parameter's value is found. The following binding
source attributes exist:

- `[FromBody]` - Request body
- `[FromForm]` - Form data in the request body
- `[FromHeader]` - Request header
- `[FromQuery]` - Request query string parameter
- `[FromRoute]` - Route data from the current request
- `[FromServices]` - The request service injected as an action parameter



## Problem details for error status codes

```cs
public class SomeController : ControllerBase {
  public ActionResult<Pet> SomeAction() {
    return NotFound();
  }
}
```
The NotFound method produces an HTTP 404 status code with a
`ProblemDetails` body. For example:

```json
{
  type: "https://tools.ietf.org/html/rfc7231#section-6.5.4",
  title: "Not Found",
  status: 404,
  traceId: "0HLHLV31KRN83:00000001"
}
```


## Controlling API behaviour

```cs
services
.AddControllers()
.ConfigureApiBehaviorOptions(
  options => {
    // Multipart/form-data request inference
    options.SuppressConsumesConstraintForFormFileParameters = true;
    // Enable binding
    options.SuppressInferBindingSourcesForParameters = true;
    //disable the automatic 400 behavior
    options.SuppressModelStateInvalidFilter = true;
    // Disable ProblemDetails response
    options.SuppressMapClientErrors = true;
    options.ClientErrorMapping[StatusCodes.Status404NotFound].Link =
        "https://httpstatuses.com/404";
  }
);
```


## Request content type [Consumes] attribute


```cs
[ApiController]
[Route("api/[controller]")]
public class ConsumesController : ControllerBase
{
    [HttpPost]
    [Consumes("application/json")]
    public IActionResult PostJson(IEnumerable<int> values) =>
        Ok(new { Consumes = "application/json", Values = values });

    [HttpPost]
    [Consumes("application/x-www-form-urlencoded")]
    public IActionResult PostForm([FromForm] IEnumerable<int> values) =>
        Ok(new { Consumes = "application/x-www-form-urlencoded", Values = values });
}
```

## Identity provider

Open source: https://identityserver.io/

https://docs.identityserver.io/en/latest/quickstarts/0_overview.html

# Swagger / OpenAPI

Swagger is a language-agnostic specification for describing
REST APIs. The Swagger project was donated to the OpenAPI
Initiative, where it's now referred to as OpenAPI. Both
names are used interchangeably; however, OpenAPI is
preferred. It allows both computers and humans to understand
the capabilities of a service without any direct access to
the implementation (source code, network access,
documentation). One goal is to minimize the amount of work
needed to connect disassociated services. Another goal is to
reduce the amount of time needed to accurately document a
service.



## OpenAPI specification (openapi.json)

The core to the OpenAPI flow is the specification—by
default, a document named openapi.json. It's generated by
the OpenAPI tool chain (or third-party implementations of
it) based on your service. It describes the capabilities of
your API and how to access it with HTTP. It drives the
Swagger UI and is used by the tool chain to enable discovery
and client code generation. Here's an example of an OpenAPI
specification, reduced for brevity:

```json
{
  "openapi": "3.0.1",
  "info": {
    "title": "API V1",
    "version": "v1"
  },
  "paths": {
    "/api/Todo": {
      "get": {
        "tags": [
          "Todo"
        ],
        "operationId": "ApiTodoGet",
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "text/plain": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/ToDoItem"
                  }
                }
              },
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/ToDoItem"
                  }
                }
              },
              "text/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/ToDoItem"
                  }
                }
              }
            }
          }
        }
      },
      "post": {
        …
      }
    },
    "/api/Todo/{id}": {
      "get": {
        …
      },
      "put": {
        …
      },
      "delete": {
        …
      }
    }
  },
  "components": {
    "schemas": {
      "ToDoItem": {
        "type": "object",
        "properties": {
          "id": {
            "type": "integer",
            "format": "int32"
          },
          "name": {
            "type": "string",
            "nullable": true
          },
          "isCompleted": {
            "type": "boolean"
          }
        },
        "additionalProperties": false
      }
    }
  }
}
```

## Example

```sh
dotnet add TodoApi.csproj package Swashbuckle.AspNetCore -v 5.5.0
```

```cs
public void ConfigureServices(IServiceCollection services)
{
    services.AddDbContext<TodoContext>(opt =>
        opt.UseInMemoryDatabase("TodoList"));
    services.AddControllers();

    // Register the Swagger generator, defining 1 or more Swagger documents
    services.AddSwaggerGen();
}

public void Configure(IApplicationBuilder app)
{
    // Enable middleware to serve generated Swagger as a JSON endpoint.
    app.UseSwagger();

    // Enable middleware to serve swagger-ui (HTML, JS, CSS, etc.),
    // specifying the Swagger JSON endpoint.
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "My API V1");
        // To serve the Swagger UI at the app's root (http://localhost:<port>/)
        // set the RoutePrefix property to an empty string:
        c.RoutePrefix = string.Empty;
    });

    app.UseRouting();
    app.UseEndpoints(endpoints =>
    {
        endpoints.MapControllers();
    });
}
```

# JsonPatch in ASP.NET Core web API

Used for PATCH HTTP method probably...

https://docs.microsoft.com/en-us/aspnet/core/web-api/jsonpatch?view=aspnetcore-3.1

# Return responses in different formats

https://docs.microsoft.com/en-us/aspnet/core/web-api/advanced/formatting?view=aspnetcore-3.1


# Auto checking responses formats

https://docs.microsoft.com/en-us/aspnet/core/web-api/advanced/analyzers?view=aspnetcore-3.1&tabs=visual-studio


# Very nice CLI for HTTP repl

https://docs.microsoft.com/en-us/aspnet/core/web-api/http-repl?view=aspnetcore-3.1&tabs=linux






# RealTime - SignalR

https://github.com/dotnet/AspNetCore/tree/master/src/SignalR

SignalR supports the following techniques for handling
real-time communication (in order of graceful fallback):

- WebSockets
- Server-Sent Events
- Long Polling

SignalR automatically chooses the best transport method that
is within the capabilities of the server and client.

Very useful technical resources are on github:

- [Hub protocol](https://github.com/aspnet/AspNetCore/blob/master/src/SignalR/docs/specs/HubProtocol.md)
- [Transport protocol](https://github.com/aspnet/AspNetCore/blob/master/src/SignalR/docs/specs/TransportProtocols.md)


## Example in TypeScript

https://docs.microsoft.com/en-us/aspnet/core/tutorials/signalr-typescript-webpack?view=aspnetcore-3.1&tabs=visual-studio-code

https://github.com/aspnet/SignalR-samples


## Hubs

The SignalR Hubs API enables you to call methods on
connected clients from the server. In the server code, you
define methods that are called by client. In the client
code, you define methods that are called from the server.
SignalR takes care of everything behind the scenes that
makes real-time client-to-server and server-to-client
communications possible.

```cs
services.AddSignalR();

app.UseRouting();
app.UseEndpoints(endpoints =>
{
    endpoints.MapHub<ChatHub>("/chathub");
});

public class ChatHub : Hub
{
    public Task SendMessage(string user, string message)
    {
        return Clients.All.SendAsync("ReceiveMessage", user, message);
    }
}

public interface IChatClient
{
    Task ReceiveMessage(string user, string message);
    Task ReceiveMessage(string message);
}

public class StronglyTypedChatHub : Hub<IChatClient>
{
    public async Task SendMessage(string user, string message)
    {
        await Clients.All.ReceiveMessage(user, message);
    }

    public Task SendMessageToCaller(string message)
    {
        return Clients.Caller.ReceiveMessage(message);
    }
}
```

The Hub class has a `Hub.Context` property that contains the
following properties with information about the connection:

- `ConnectionId` - Gets the unique ID for the connection,
  assigned by SignalR. There is one connection ID for each
  connection.
- `UserIdentifier` - Gets the user identifier. By default,
  SignalR uses the `ClaimTypes.NameIdentifier` from the
  `ClaimsPrincipal` associated with the connection as the
  user identifier.
- `User` - Gets the `ClaimsPrincipal` associated with the current user.
- `Items` - Gets a key/value collection that can be used to
  share data within the scope of this connection. Data can
  be stored in this collection and it will persist for the
  connection across different hub method invocations.
- `Features` - Gets the collection of features available on
  the connection. For now, this collection isn't needed in
  most scenarios, so it isn't documented in detail yet.
- `ConnectionAborted`- Gets a CancellationToken that
  notifies when the connection is aborted.

`Hub.Context` also contains the following methods:

- `GetHttpContext` - Returns the HttpContext for the
  connection, or null if the connection is not associated
  with an HTTP request. For HTTP connections, you can use
  this method to get information such as HTTP headers and
  query strings.
- `Abort` - Aborts the connection.

The Hub class has a `Hub.Clients` property that contains the
following properties for communication between server and
client:

- `All` - Calls a method on all connected clients
- `Caller` - Calls a method on the client that invoked the
  hub method
- `Others` - Calls a method on all connected clients except
  the client that invoked the method
- `AllExcept` - Calls a method on all connected clients
  except for the specified connections
- `Client` - Calls a method on a specific connected client
- `Clients` - Calls a method on specific connected clients
- `Group` - Calls a method on all connections in the
  specified group
- `GroupExcept` - Calls a method on all connections in the
  specified group, except the specified connections
- `Groups` - Calls a method on multiple groups of
  connections
- `OthersInGroup` - Calls a method on a group of
  connections, excluding the client that invoked the hub
  method
- `User` - Calls a method on all connections associated with
  a specific user
- `Users` - Calls a method on all connections associated
  with the specified users


Each property or method in the preceding tables returns an
object with a `SendAsync` method. The `SendAsync` method
allows you to supply the name and parameters of the client
method to call.

## Handle events for a connection

The SignalR Hubs API provides the `OnConnectedAsync` and
`OnDisconnectedAsync` virtual methods to manage and track
connections. Override the `OnConnectedAsync` virtual method to
perform actions when a client connects to the Hub, such as
adding it to a group.

```cs
public override async Task OnConnectedAsync()
{
    await Groups.AddToGroupAsync(Context.ConnectionId, "SignalR Users");
    await base.OnConnectedAsync();
}
public override async Task OnDisconnectedAsync(Exception exception)
{
    await Groups.RemoveFromGroupAsync(Context.ConnectionId, "SignalR Users");
    await base.OnDisconnectedAsync(exception);
}
```

## Errors received by JS clients

Exceptions thrown in your hub methods are sent to the client
that invoked the method. On the JavaScript client, the
invoke method returns a JavaScript Promise. When the client
receives an error with a handler attached to the promise
using catch, it's invoked and passed as a JavaScript `Error`
object.

```js
connection.invoke("SendMessage", user, message).catch(err => console.error(err));
// Microsoft.AspNetCore.SignalR.HubException: 
//     An unexpected error occurred invoking 'MethodName' on the server.
```

If you have an exceptional condition you do want to
propagate to the client, you can use the HubException class.
If you throw a HubException from your hub method, SignalR
will send the entire message to the client, unmodified.

```cs
public Task ThrowException()
{
    throw new HubException("This error will be sent to the client!");
}
```
## Get an instance of IHubContext

In ASP.NET Core SignalR, you can access an instance of
`IHubContext` via dependency injection. You can inject an
instance of `IHubContext` into a controller, middleware, or
other DI service. Use the instance to send messages to
clients.

(When hub methods are called from outside of the Hub class,
there's no caller associated with the invocation. Therefore,
there's no access to the `ConnectionId`, `Caller`, and
`Others` properties.)

```cs
public class HomeController : Controller
{
    private readonly IHubContext<NotificationHub> _hubContext;

    public HomeController(IHubContext<NotificationHub> hubContext)
    {
        _hubContext = hubContext;
    }
}
public async Task<IActionResult> Index()
{
    await _hubContext.Clients.All.SendAsync("Notify", $"Home page loaded at: {DateTime.Now}");
    return View();
}

app.Use(async (context, next) =>
{
    var hubContext = context.RequestServices
                            .GetRequiredService<IHubContext<ChatHub>>();
    //...
    
    if (next != null)
    {
        await next.Invoke();
    }
});

public class Program
{
    public static void Main(string[] args)
    {
        var host = CreateHostBuilder(args).Build();
        var hubContext = host.Services.GetService(typeof(IHubContext<ChatHub>));
        host.Run();
    }

    public static IHostBuilder CreateHostBuilder(string[] args) =>
        Host.CreateDefaultBuilder(args)
            .ConfigureWebHostDefaults(webBuilder => {
                webBuilder.UseStartup<Startup>();
            });
}

public class ChatController : Controller
{
    public IHubContext<ChatHub, IChatClient> _strongChatHubContext { get; }

    public ChatController(IHubContext<ChatHub, IChatClient> chatHubContext)
    {
        _strongChatHubContext = chatHubContext;
    }

    public async Task SendMessage(string message)
    {
        await _strongChatHubContext.Clients.All.ReceiveMessage(message);
    }
}
```

## Clients languages/environments

There are librarits for JS/TS, .Net Core, Java

## Scaling

(See https://docs.microsoft.com/en-us/aspnet/core/signalr/scale?view=aspnetcore-3.1)


SignalR can be scaled using: 

- proxy, e.g.: [NGINX as a WebSocket
  Proxy.](https://www.nginx.com/blog/websocket-nginx/)
- backplane providers (key-value server with messaging
  support) like: [Redis](https://redis.io/),
  [Orleans](https://github.com/OrleansContrib/SignalR.Orleans),
  [NCache](https://www.alachisoft.com/ncache/asp-net-core-signalr.html)
  and load balancer server (for sticky sessions) e.g.: 
  [Nginx](https://docs.nginx.com/nginx/admin-guide/load-balancer/http-load-balancer/#sticky).




# WebSockets support in ASP.NET Core

https://docs.microsoft.com/en-us/aspnet/core/fundamentals/websockets?view=aspnetcore-3.1

```cs

public void Configure(...) {

  var webSocketOptions = new WebSocketOptions() 
  {
      KeepAliveInterval = TimeSpan.FromSeconds(120),
      ReceiveBufferSize = 4 * 1024
  };

  app.UseWebSockets(webSocketOptions);

  // ....

  app.Use(async (context, next) =>
{
    if (context.Request.Path == "/ws")
    {
        if (context.WebSockets.IsWebSocketRequest)
        {
            WebSocket webSocket = await context.WebSockets.AcceptWebSocketAsync();
            await Echo(context, webSocket);
        }
        else
        {
            context.Response.StatusCode = 400;
        }
    }
    else
    {
        await next();
    }

});
}
```

## Middeware

When using a WebSocket, you must keep the middleware
pipeline running for the duration of the connection. If you
attempt to send or receive a WebSocket message after the
middleware pipeline ends, you may get an exception like the
following:

```
System.Net.WebSockets.WebSocketException (0x80004005): The remote party closed the WebSocket connection without completing the close handshake. ---> System.ObjectDisposedException: Cannot write to the response body, the response has completed.
Object name: 'HttpResponseStream'.
```

It can be solved:


```cs
app.Use(async (context, next) => {
    var socket = await context.WebSockets.AcceptWebSocketAsync();
    var socketFinishedTcs = new TaskCompletionSource<object>();

    BackgroundSocketProcessor.AddSocket(socket, socketFinishedTcs); 

    await socketFinishedTcs.Task;
});
```

## Send and receive messages

The `AcceptWebSocketAsync` method upgrades the TCP
connection to a `WebSocket` connection and provides a
`WebSocket` object. Use the `WebSocket` object to send and
receive messages.

Messages are sent and received in a loop until the client
closes the connection:

```cs
private async Task Echo(HttpContext context, WebSocket webSocket)
{
    var buffer = new byte[1024 * 4];
    WebSocketReceiveResult result = await webSocket.ReceiveAsync(new ArraySegment<byte>(buffer), CancellationToken.None);
    while (!result.CloseStatus.HasValue)
    {
        await webSocket.SendAsync(new ArraySegment<byte>(buffer, 0, result.Count), result.MessageType, result.EndOfMessage, CancellationToken.None);

        result = await webSocket.ReceiveAsync(new ArraySegment<byte>(buffer), CancellationToken.None);
    }
    await webSocket.CloseAsync(result.CloseStatus.Value, result.CloseStatusDescription, CancellationToken.None);
}
```

## WebSocket origin restriction

The protections provided by CORS don't apply to WebSockets.
Browsers do not:

- Perform CORS pre-flight requests.
- Respect the restrictions specified in Access-Control
  headers when making `WebSocket` requests.

However, browsers do send the Origin header when issuing
`WebSocket` requests. Applications should be configured to
validate these headers to ensure that only WebSockets coming
from the expected origins are allowed.

If you're hosting your server on `"https://server.com"` and
hosting your client on "`https://client.com"`, add
"`https://client.com"` to the `AllowedOrigins` list for
WebSockets to verify.

```cs
var webSocketOptions = new WebSocketOptions()
{
    KeepAliveInterval = TimeSpan.FromSeconds(120),
    ReceiveBufferSize = 4 * 1024
};
webSocketOptions.AllowedOrigins.Add("https://client.com");
webSocketOptions.AllowedOrigins.Add("https://www.client.com");

app.UseWebSockets(webSocketOptions);
```


## Collect a network trace with tcpdump

https://docs.microsoft.com/en-us/aspnet/core/signalr/diagnostics?view=aspnetcore-3.1#collect-a-network-trace-with-tcpdump-macos-and-linux-only

You can collect raw TCP traces using tcpdump by running the
following command from a command shell. You may need to be
root or prefix the command with sudo if you get a
permissions error:

```sh
tcpdump -i [interface] -w trace.pcap
```

Replace [interface] with the network interface you wish to
capture on. Usually, this is something like `/dev/eth0` (for
your standard Ethernet interface) or `/dev/lo0` (for localhost
traffic). For more information, see the tcpdump man page on
your host system.


# Remote Procedure Calls (RPC)

## Links

- https://docs.microsoft.com/en-us/aspnet/core/grpc/?view=aspnetcore-3.1
- [official documentation of protobuf](https://developers.google.com/protocol-buffers/docs/proto3)

## Overview

.Net gRPC works on top of protobuf protocol.
Interfaces are written as `.proto` files
and transpiled to target language/platform.

gRPC uses a contract-first approach to API development.
Protocol buffers (protobuf) are used as the Interface Design
Language (IDL) by default. The *.proto file contains:

- The definition of the gRPC service.
- The messages sent between clients and servers


```proto
syntax = "proto3";

option csharp_namespace = "GrpcGreeter";

package greet;

// The greeting service definition.
service Greeter {
  // Sends a greeting
  rpc SayHello (HelloRequest) returns (HelloReply);
}

// The request message containing the user's name.
message HelloRequest {
  string name = 1;
}

// The response message containing the greetings.
message HelloReply {
  string message = 1;
}
```

In .net tool for transpiling is setup in `.project` XML file:

```xml
<ItemGroup>
  <Protobuf Include="Protos\greet.proto" />
</ItemGroup>
```

```cs
public class Startup
{
    // This method gets called by the runtime. Use this method to add services to the container.
    // For more information on how to configure your application, visit https://go.microsoft.com/fwlink/?LinkID=398940
    public void ConfigureServices(IServiceCollection services)
    {
        services.AddGrpc();
    }

    // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
        if (env.IsDevelopment())
        {
            app.UseDeveloperExceptionPage();
        }

        app.UseRouting();

        app.UseEndpoints(endpoints =>
        {
            // Communication with gRPC endpoints must be made through a gRPC client.
            // To learn how to create a client, visit: https://go.microsoft.com/fwlink/?linkid=2086909
            endpoints.MapGrpcService<GreeterService>();
        });
    }
}

// asp.net core service:
// Greeter.GreeterBase is generated from .proto file
public class GreeterService : Greeter.GreeterBase
{
    private readonly ILogger<GreeterService> _logger;

    public GreeterService(ILogger<GreeterService> logger)
    {
        _logger = logger;
    }

    public override Task<HelloReply> SayHello(HelloRequest request,
        ServerCallContext context)
    {
        _logger.LogInformation("Saying hello to {Name}", request.Name);
        return Task.FromResult(new HelloReply 
        {
            Message = "Hello " + request.Name
        });
    }
}

// .net core client:
// A gRPC client is created using a channel, which represents 
// a long-lived connection to a gRPC service. A channel can be 
// created using GrpcChannel.ForAddress.
var channel = GrpcChannel.ForAddress("https://localhost:5001");
var client = new Greeter.GreeterClient(channel);

var response = await client.SayHelloAsync(
    new HelloRequest { Name = "World" });

Console.WriteLine(response.Message);
```

## C# Project template

To create server and client with gRPC support:


```sh
## create server:
  dotnet new grpc -o GrpcGreeter # creates project in GrpcGreeter subdir
  code -r GrpcGreeter&           # opens vscode at GrpcGreeter dir

## create client:
  dotnet new console -o GrpcGreeterClient
  code -r GrpcGreeterClient&

# add client neccessary libraries:
  cd GrpcGreeterClient
  dotnet add GrpcGreeterClient.csproj package Grpc.Net.Client
  dotnet add GrpcGreeterClient.csproj package Google.Protobuf
  dotnet add GrpcGreeterClient.csproj package Grpc.Tools

# copy proto from server:
mkdir Protos
cp ../GrpcGreeter/Protos/greet.proto Protos/greet.proto

# update client project:
  # backup optionally
date_time=$(date -Iseconds)
proj_file=GrpcGreeterClient.csproj
backup_name="$date_time'_'$proj_file"
cp $proj_file $backup_name
  # content to add after ItemGroup element of Project root element:
proto_config_value=$(cat <<'EOF'
<Protobuf Include="Protos\greet.proto" GrpcServices="Client" />
EOF
)
  # See: https://www.technomancy.org/xml/
  # sudo apt install xmlstarlet
  # xmlstarlet ed --help
  # xmlstarlet -i or --insert <xpath> -t (--type) elem|text|attr -n <name> [-v (--value) <value>]
  # to transform and override the same file one may use:
  #    mktemp command or 
  #    xmlstarlet ed --inplace option t
xmlstarlet ed --inplace -a "/Project/ItemGroup" -t elem -n ItemGroup -v "$proto_config_value" $proj_file

# build client
dotnet build
```

## Asp.net core project template


One needs to add gRPC middleware, and configure server
(Kestrel) to use TLS (with Application-Layer Protocol
Negotiation (ALPN) for handshake) and protocol negotiation
and HTTP2

`appsettings.json`:

```json
{
  "Kestrel": {
    "Endpoints": {
      "HttpsInlineCertFile": {
        "Url": "https://localhost:5001",
        "Protocols": "Http2",
        "Certificate": {
          "Path": "<path to .pfx file>",
          "Password": "<certificate password>"
        }
      }
    }
  }
}
```

`Startup.cs`:

```cs
public class Startup
{
    // This method gets called by the runtime. Use this method to add services to the container.
    // For more information on how to configure your application, visit https://go.microsoft.com/fwlink/?LinkID=398940
    public void ConfigureServices(IServiceCollection services)
    {
        services.AddGrpc();
    }

    // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
        if (env.IsDevelopment())
        {
            app.UseDeveloperExceptionPage();
        }

        app.UseRouting();

        app.UseEndpoints(endpoints =>
        {
            // Communication with gRPC endpoints must be made through a gRPC client.
            // To learn how to create a client, visit: https://go.microsoft.com/fwlink/?linkid=2086909
            endpoints.MapGrpcService<GreeterService>();
        });
    }
}
```

## Access for JS clients

Two possible solutions:
- add gRPC-Web protocol support to asp.net core server or
- setup proxy (Envoy) translating gRPC-Web to HTTP2

There is a JavaScript gRPC-Web client. For instructions on
how to use gRPC-Web from JavaScript, see write JavaScript
client code with gRPC-Web:

https://github.com/grpc/grpc-web/tree/master/net/grpc/gateway/examples/helloworld#write-client-code

## gRPC-Web server support

```cs
public void ConfigureServices(IServiceCollection services)
{
    services.AddGrpc();
}

public void Configure(IApplicationBuilder app)
{
    app.UseRouting();

    app.UseGrpcWeb(); // Must be added between UseRouting and UseEndpoints

    app.UseEndpoints(endpoints =>
    {
        endpoints.MapGrpcService<GreeterService>().EnableGrpcWeb();
    });
}
```

## gRPC-Web and CORS

Browser security prevents a web page from making requests to
a different domain than the one that served the web page.
This restriction applies to making gRPC-Web calls with
browser apps. For example, a browser app served by
`https://www.contoso.com` is blocked from calling gRPC-Web
services hosted on `https://services.contoso.com`. Cross
Origin Resource Sharing (CORS) can be used to relax this
restriction.

```cs
public void ConfigureServices(IServiceCollection services)
{
    services.AddGrpc();

    services.AddCors(o => o.AddPolicy("AllowAll", builder =>
    {
        builder.AllowAnyOrigin()
               .AllowAnyMethod()
               .AllowAnyHeader()
               .WithExposedHeaders(
                 "Grpc-Status", 
                 "Grpc-Message", 
                 "Grpc-Encoding", 
                 "Grpc-Accept-Encoding");
    }));
}

public void Configure(IApplicationBuilder app)
{
    app.UseRouting();

    app.UseGrpcWeb();
    app.UseCors();

    app.UseEndpoints(endpoints =>
    {
        endpoints.MapGrpcService<GreeterService>().EnableGrpcWeb()
                                                  .RequireCors("AllowAll");
    });
}
```

## Configuration

https://docs.microsoft.com/en-us/aspnet/core/grpc/configuration?view=aspnetcore-3.1

## Authentication and autorization

https://docs.microsoft.com/en-us/aspnet/core/grpc/authn-and-authz?view=aspnetcore-3.1

Many ASP.NET Core supported authentication mechanisms work with gRPC:

- Azure Active Directory
- Client Certificate
- IdentityServer
- JWT Token
- OAuth 2.0
- OpenID Connect
- WS-Federation

For more information on configuring authentication on the
server, see ASP.NET Core authentication:

https://docs.microsoft.com/en-us/aspnet/core/security/authentication/identity?view=aspnetcore-3.1


By default, all methods in a service can be called by
unauthenticated users. To require authentication, apply the
`[Authorize]` attribute to the service:

You can use the constructor arguments and properties of the
`[Authorize]` attribute to restrict access to only users
matching specific authorization policies. For example, if
you have a custom authorization policy called
MyAuthorizationPolicy, ensure that only users matching that
policy can access the service using the following code.

Individual service methods can have the `[Authorize]`
attribute applied as well. If the current user doesn't match
the policies applied to both the method and the class, an
error is returned to the caller:


```cs
[Authorize]
public class TicketerService : Ticketer.TicketerBase
{
    public override Task<AvailableTicketsResponse> GetAvailableTickets(
        Empty request, ServerCallContext context)
    {
        // ... buy tickets for the current user ...
    }

    [Authorize("Administrators")]
    public override Task<BuyTicketsResponse> RefundTickets(
        BuyTicketsRequest request, ServerCallContext context)
    {
        // ... refund tickets (something only Administrators can do) ..
    }
}
```

## Logging | Tracing | Metrics

https://docs.microsoft.com/en-us/aspnet/core/grpc/diagnostics?view=aspnetcore-3.1


- Logging - Structured logs written to .NET Core logging.
  `ILogger` is used by app frameworks to write logs, and by
  users for their own logging in an app.
- Tracing - Events related to an operation written using
  `DiaganosticSource` and `Activity`. Traces from diagnostic
  source are commonly used to collect app telemetry by
  libraries such as `Application Insights` and `OpenTelemetry`.
- Metrics - Representation of data measures over intervals
  of time, for example, requests per second. Metrics are
  emitted using `EventCounter` and can be observed using
  `dotnet-counters` command line tool or with `Application
  Insights`.

## CLI - dotnet-grpc

dotnet-grpc is a .NET Core Global Tool for managing Protobuf
(.proto) references within a .NET gRPC project. The tool can
be used to add, refresh, remove, and list Protobuf
references.

To install:

```sh
dotnet tool install -g dotnet-grpc
```

See:

https://docs.microsoft.com/en-us/aspnet/core/grpc/dotnet-grpc?view=aspnetcore-3.1

https://github.com/grpc/grpc/blob/master/doc/command_line_tool.md

https://github.com/grpc/grpc/blob/master/doc/server-reflection.md

https://developers.google.com/protocol-buffers/docs/proto3#json


## Trableshoot and samples

https://docs.microsoft.com/en-us/aspnet/core/grpc/troubleshoot?view=aspnetcore-3.1

https://github.com/grpc/grpc-dotnet/tree/master/examples


# Entity Framework (EF) Core

https://docs.microsoft.com/en-us/aspnet/core/data/ef-rp/intro?view=aspnetcore-3.1&tabs=visual-studio-code

https://www.entityframeworktutorial.net/efcore/create-model-for-existing-database-in-ef-core.aspx

Tutorial on Linux uses:

- [SQLite](https://www.sqlite.org/)
- [SQLiteBrowser](https://sqlitebrowser.org/)
- [Entity Framework Core](https://docs.microsoft.com/en-us/ef/efcore-and-ef6/)

```sh
dotnet tool install --global dotnet-ef
dotnet ef database update
```

## data model

One need to create POCO (Plain Old CLR Objects) classes of
things and interconnections. At begining no need for
validation creation, deletion, factiories and other.


## db context

Entity framework needs one primary configuration selecting:

- what is data model (at least one class from which there is
  navigation to other classes with navigations to other
  classes, ... in summary specifying objects graph)
- database provider library
  - with connection string (typically addres (may be file,
    url with protocol,...) and authorization method and
    secrets)


In practise, EF needs: 

- class inheiraiting from `DbContext` with public fields
  specifying collections of specific data classes
  (`DbSet<...> `) which should be mapped to DB tables.
- DI creation of database (and its schema) if not exists in `Program` class.
- DI setup for Database in `Startup` class. 
- Connection string in `appsettings.json` configuration file.

```cs
using Microsoft.EntityFrameworkCore;
using ContosoUniversity.Models;

namespace ContosoUniversity.Data
{
    public class SchoolContext : DbContext
    {
        public SchoolContext (DbContextOptions<SchoolContext> options)
            : base(options)
        {
        }

        public DbSet<Student> Students { get; set; }
        public DbSet<Enrollment> Enrollments { get; set; }
        public DbSet<Course> Courses { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Course>().ToTable("Course");
            modelBuilder.Entity<Enrollment>().ToTable("Enrollment");
            modelBuilder.Entity<Student>().ToTable("Student");
        }
    }
}

namespace ContosoUniversity 
{
    public class Startup
    {
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddRazorPages();

            services.AddDbContext<SchoolContext>(options =>
                    options.UseSqlite(Configuration.GetConnectionString("SchoolContext")));
        }
    }

    using ContosoUniversity.Data;
    using Microsoft.Extensions.DependencyInjection;
    using Microsoft.AspNetCore.Hosting;
    using Microsoft.Extensions.Hosting;
    using Microsoft.Extensions.Logging;
    using System;

    public class Program
    {
        public static void Main(string[] args)
        {
            var host = CreateHostBuilder(args).Build();

            CreateDbIfNotExists(host);

            host.Run();
        }

        private static void CreateDbIfNotExists(IHost host)
        {
            using (var scope = host.Services.CreateScope())
            {
                var services = scope.ServiceProvider;

                try
                {
                    var context = services.GetRequiredService<SchoolContext>();
                    // context.Database.EnsureCreated();
                    DbInitializer.Initialize(context);
                }
                catch (Exception ex)
                {
                    var logger = services.GetRequiredService<ILogger<Program>>();
                    logger.LogError(ex, "An error occurred creating the DB.");
                }
            }
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<Startup>();
                });
    }
}

using ContosoUniversity.Data;
using ContosoUniversity.Models;
using System;
using System.Linq;

namespace ContosoUniversity.Data
{
    public static class DbInitializer
    {
        public static void Initialize(SchoolContext context)
        {
            context.Database.EnsureCreated();

            // Look for any students.
            if (context.Students.Any())
            {
                return;   // DB has been seeded
            }

            var students = new Student[]
            {
                new Student{FirstMidName="Carson",LastName="Alexander",EnrollmentDate=DateTime.Parse("2019-09-01")},
                new Student{FirstMidName="Meredith",LastName="Alonso",EnrollmentDate=DateTime.Parse("2017-09-01")},
                new Student{FirstMidName="Arturo",LastName="Anand",EnrollmentDate=DateTime.Parse("2018-09-01")},
                new Student{FirstMidName="Gytis",LastName="Barzdukas",EnrollmentDate=DateTime.Parse("2017-09-01")},
                new Student{FirstMidName="Yan",LastName="Li",EnrollmentDate=DateTime.Parse("2017-09-01")},
                new Student{FirstMidName="Peggy",LastName="Justice",EnrollmentDate=DateTime.Parse("2016-09-01")},
                new Student{FirstMidName="Laura",LastName="Norman",EnrollmentDate=DateTime.Parse("2018-09-01")},
                new Student{FirstMidName="Nino",LastName="Olivetto",EnrollmentDate=DateTime.Parse("2019-09-01")}
            };

            context.Students.AddRange(students);
            context.SaveChanges();

            var courses = new Course[]
            {
                new Course{CourseID=1050,Title="Chemistry",Credits=3},
                new Course{CourseID=4022,Title="Microeconomics",Credits=3},
                new Course{CourseID=4041,Title="Macroeconomics",Credits=3},
                new Course{CourseID=1045,Title="Calculus",Credits=4},
                new Course{CourseID=3141,Title="Trigonometry",Credits=4},
                new Course{CourseID=2021,Title="Composition",Credits=3},
                new Course{CourseID=2042,Title="Literature",Credits=4}
            };

            context.Courses.AddRange(courses);
            context.SaveChanges();

            var enrollments = new Enrollment[]
            {
                new Enrollment{StudentID=1,CourseID=1050,Grade=Grade.A},
                new Enrollment{StudentID=1,CourseID=4022,Grade=Grade.C},
                new Enrollment{StudentID=1,CourseID=4041,Grade=Grade.B},
                new Enrollment{StudentID=2,CourseID=1045,Grade=Grade.B},
                new Enrollment{StudentID=2,CourseID=3141,Grade=Grade.F},
                new Enrollment{StudentID=2,CourseID=2021,Grade=Grade.F},
                new Enrollment{StudentID=3,CourseID=1050},
                new Enrollment{StudentID=4,CourseID=1050},
                new Enrollment{StudentID=4,CourseID=4022,Grade=Grade.F},
                new Enrollment{StudentID=5,CourseID=4041,Grade=Grade.C},
                new Enrollment{StudentID=6,CourseID=1045},
                new Enrollment{StudentID=7,CourseID=3141,Grade=Grade.A},
            };

            context.Enrollments.AddRange(enrollments);
            context.SaveChanges();
        }
    }
}
```

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft": "Warning",
      "Microsoft.Hosting.Lifetime": "Information"
    }
  },
  "AllowedHosts": "*",
  "ConnectionStrings": {
    "SchoolContext": "Data Source=CU.db"
  }
}
```

# Servers -> Kestrel

Kestrel supports the following scenarios:

- HTTPS
- Opaque upgrade used to enable WebSockets
- Unix sockets for high performance behind Nginx
- HTTP/2

Kestrel requires:

- Application-Layer Protocol Negotiation (ALPN) connection
- TLS 1.2 or later connection

Kestrel can be used by itself or with a reverse proxy server.


Capabilities:

- Kestrel used as an edge server without a reverse proxy
  server doesn't support sharing the same IP and port among
  multiple processes. Because:
  - When Kestrel is configured to listen on a port, Kestrel
    handles all of the traffic for that port regardless of
    requests' Host headers (http header contain address/name
    which theoretically can be mapped to processes).
- A reverse proxy that can share ports has the ability to
  forward requests to Kestrel on a unique IP and port.
  - i.e. Nginx
  - this way Kestrel is in internal network, but it should
    serve only requests for specific addresses/dnsnames, it
    can be done by configuring host filtering middelware
    (it is not the same as possibility to have 2 kestrel
    processes one serving dns1.com other dns2.com at the
    same IP address and port, we have one process serving
    for example dns1.com and ignoring others)

## Setting up workspace

```cs
using Microsoft.AspNetCore.Server.Kestrel.Core;

public static IHostBuilder CreateHostBuilder(string[] args) =>
    Host.CreateDefaultBuilder(args)
        .ConfigureServices((context, services) =>
        {
            services.Configure<KestrelServerOptions>(
                context.Configuration.GetSection("Kestrel"));
        })
        // `ConfigureWebHostDefaults` internaly calls `UseKestrel`!!!
        .ConfigureWebHostDefaults(webBuilder =>
        {
            webBuilder.ConfigureKestrel(serverOptions =>
            {
                // The maximum number of concurrent open TCP connections 
                // can be set for the entire app
                serverOptions.Limits.MaxConcurrentConnections = 100;
                // There's a separate limit for connections that have been 
                // upgraded from HTTP or HTTPS to another protocol (for example, 
                // on a WebSockets request). After a connection is upgraded, 
                // it isn't counted against the MaxConcurrentConnections limit.
                serverOptions.Limits.MaxConcurrentUpgradedConnections = 100;
                // The default maximum request body size is 30,000,000 bytes, 
                // which is approximately 28.6 MB. 
                // The recommended approach to override the limit in an ASP.NET Core MVC app 
                // is to use the RequestSizeLimitAttribute attribute on an action method.
                // Global limit can be set as below:
                serverOptions.Limits.MaxRequestBodySize = 10 * 1024;
                // Kestrel checks every second if data is arriving at the specified 
                // rate in bytes/second. If the rate drops below the minimum, 
                // the connection is timed out. 
                // The grace period is the amount of time that Kestrel gives the client 
                // to increase its send rate up to the minimum; 
                // the rate isn't checked during that time.
                serverOptions.Limits.MinRequestBodyDataRate =
                    new MinDataRate(bytesPerSecond: 100, 
                        gracePeriod: TimeSpan.FromSeconds(10));
                // Analogous to MinRequestBodyDataRate
                serverOptions.Limits.MinResponseDataRate =
                    new MinDataRate(bytesPerSecond: 100, 
                        gracePeriod: TimeSpan.FromSeconds(10));
                // endpoints configuration
                serverOptions.Listen(IPAddress.Loopback, 5000);
                serverOptions.Listen(IPAddress.Loopback, 5001, 
                    listenOptions =>
                    {
                        listenOptions.UseHttps("testCert.pfx", 
                            "testPassword");
                    });
                // Keep alive...
                serverOptions.Limits.KeepAliveTimeout = 
                    TimeSpan.FromMinutes(2);
                // Gets or sets the maximum amount of time the server spends 
                // receiving request headers. Defaults to 30 seconds.
                serverOptions.Limits.RequestHeadersTimeout = 
                    TimeSpan.FromMinutes(1);
                
                // Http2.MaxStreamsPerConnection limits the number of concurrent 
                // request streams per HTTP/2 connection. Excess streams are refused.
                serverOptions.Limits.Http2.MaxStreamsPerConnection = 100;
                // Http2.MaxFrameSize indicates the maximum allowed size of an 
                // HTTP/2 connection frame payload received or sent by the server. 
                // The value is provided in octets and 
                // must be between 2^14 (16,384) and 2^24-1 (16,777,215).
                serverOptions.Limits.Http2.MaxFrameSize = 16384; // default value is 2^14 (16,384)

            })
            .UseStartup<Startup>();
        });

using Microsoft.Extensions.Configuration

public class Startup
{
    public Startup(IConfiguration configuration)
    {
        Configuration = configuration;
    }

    public IConfiguration Configuration { get; }

    public void ConfigureServices(IServiceCollection services)
    {
        services.Configure<KestrelServerOptions>(
            Configuration.GetSection("Kestrel"));
    }

    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
        ...
    }
}

```
```json
{
  "Kestrel": {
    "Limits": {
      "MaxConcurrentConnections": 100,
      "MaxConcurrentUpgradedConnections": 100
    },
    "DisableStringReuse": true
  }
}
```

## Developer certificate

A development certificate is created:

- When the .NET Core SDK is installed.
- The dev-certs tool is used to create a certificate.

Some browsers require granting explicit permission to trust
the local development certificate.

Project templates configure apps to run on HTTPS by default
and include HTTPS redirection and HSTS support.

## Endpoints


```cs
webBuilder.UseKestrel((context, serverOptions) =>
{
    serverOptions.Configure(context.Configuration.GetSection("Kestrel"))
        .Endpoint("HTTPS", listenOptions =>
        {
            listenOptions.HttpsOptions.SslProtocols = SslProtocols.Tls12;
        });
});
```

## Server Name Indication (SNI) - TLS Extension

https://tools.ietf.org/html/rfc6066#section-3

TLS does not provide a mechanism for a client to tell a server the
name of the server it is contacting.  It may be desirable for clients
to provide this information to facilitate secure connections to
servers that host multiple 'virtual' servers at a single underlying
network address.

In order to provide any of the server names, clients MAY include an
extension of type "server_name" in the (extended) client hello.  The
"extension_data" field of this extension SHALL contain
"ServerNameList"


## Virtual servers

Server Name Indication (SNI) can be used to host multiple domains on
the same IP address and port. For SNI to function, the client sends
the host name for the secure session to the server during the TLS
handshake so that the server can provide the correct certificate. The
client uses the furnished certificate for encrypted communication with
the server during the secure session that follows the TLS handshake.

Kestrel supports SNI via the ServerCertificateSelector callback. The
callback is invoked once per connection to allow the app to inspect
the host name and select the appropriate certificate.

SNI support requires:

- Running on target framework netcoreapp2.1 or later. On net461 or
  later, the callback is invoked but the name is always null. The name
  is also null if the client doesn't provide the host name parameter
  in the TLS handshake.
- All websites run on the same Kestrel instance. Kestrel doesn't
  support sharing an IP address and port across multiple instances
  without a reverse proxy.


```cs
webBuilder.ConfigureKestrel(serverOptions =>
{
    serverOptions.ListenAnyIP(5005, listenOptions =>
    {
        listenOptions.UseHttps(httpsOptions =>
        {
            var localhostCert = CertificateLoader.LoadFromStoreCert(
                "localhost", "My", StoreLocation.CurrentUser,
                allowInvalid: true);
            var exampleCert = CertificateLoader.LoadFromStoreCert(
                "example.com", "My", StoreLocation.CurrentUser,
                allowInvalid: true);
            var subExampleCert = CertificateLoader.LoadFromStoreCert(
                "sub.example.com", "My", StoreLocation.CurrentUser,
                allowInvalid: true);
            var certs = new Dictionary<string, X509Certificate2>(
                StringComparer.OrdinalIgnoreCase);
            certs["localhost"] = localhostCert;
            certs["example.com"] = exampleCert;
            certs["sub.example.com"] = subExampleCert;

            httpsOptions.ServerCertificateSelector = (connectionContext, name) =>
            {
                if (name != null && certs.TryGetValue(name, out var cert))
                {
                    return cert;
                }

                return exampleCert;
            };
        });
    });
});
```

## Connection logging

Call UseConnectionLogging to emit Debug level logs for byte-level
communication on a connection. Connection logging is helpful for
troubleshooting problems in low-level communication, such as during
TLS encryption and behind proxies. If UseConnectionLogging is placed
before UseHttps, encrypted traffic is logged. If UseConnectionLogging
is placed after UseHttps, decrypted traffic is logged.

```cs
webBuilder.ConfigureKestrel(serverOptions =>
{
    serverOptions.Listen(IPAddress.Any, 8000, listenOptions =>
    {
        listenOptions.UseConnectionLogging();
    });
});
```


## Determine which port Kestrel actually bound at runtime

When the port number 0 is specified, Kestrel dynamically binds to an
available port. The following example shows how to determine which
port Kestrel actually bound at runtime:

```cs
public void Configure(IApplicationBuilder app)
{
    var serverAddressesFeature = 
        app.ServerFeatures.Get<IServerAddressesFeature>();

    app.UseStaticFiles();

    app.Run(async (context) =>
    {
        context.Response.ContentType = "text/html";
        await context.Response
            .WriteAsync("<!DOCTYPE html><html lang=\"en\"><head>" +
                "<title></title></head><body><p>Hosted by Kestrel</p>");

        if (serverAddressesFeature != null)
        {
            await context.Response
                .WriteAsync("<p>Listening on the following addresses: " +
                    string.Join(", ", serverAddressesFeature.Addresses) +
                    "</p>");
        }

        await context.Response.WriteAsync("<p>Request URL: " +
            $"{context.Request.GetDisplayUrl()}<p>");
    });
}
```


## ListenOptions.Protocols

The Protocols property establishes the HTTP protocols (HttpProtocols)
enabled on a connection endpoint or for the server. Assign a value to
the Protocols property from the HttpProtocols enum.

- Http1 - HTTP/1.1 only. Can be used with or without TLS.
- Http2 - HTTP/2 only. May be used without TLS only if the client
  supports a Prior Knowledge mode.
- Http1AndHttp2 - HTTP/1.1 and HTTP/2. HTTP/2 requires the client to
  select HTTP/2 in the TLS Application-Layer Protocol Negotiation
  (ALPN) handshake; otherwise, the connection defaults to HTTP/1.1.


The default ListenOptions.Protocols value for any endpoint is
HttpProtocols.Http1AndHttp2.

# Servers -> Nginx (production environment)

- Typical folder for webapp on production server with Linux is:
  `var/www/helloapp`
- to create package: `dotnet publish --configuration Release`, which
  will copy all neccessary files to 
  `bin/Release/<target_framework_moniker>/publish` folder
- typical tools for copying package from developer machine to server
  machine are  SCP and SFTP.
- on server application must be run:
  - manually by `dotnet <app_assembly>.dll`
  - automatically by:
    - docker
    - systemd
    - ...
- app can be accessed by client at `http://<serveraddress>:<port>`

## Reverse proxy server

A reverse proxy server (IIS, Apache, or Nginx) may reside on a
dedicated machine or may be deployed alongside an HTTP server (Kestrel
is mandatory for ASP.net Core).

- Nginx server has to forward requests to Kestrel 
  [(see Using the Forwarded header)](https://www.nginx.com/resources/wiki/start/topics/examples/forwarded/),
- Kestrel must know that it will work with forwarded
  packets.

ASP.net app should be configured as fallows:


```cs
public class Setup {
  public void ConfigureServices() {
    // using System.Net;
    services.Configure<ForwardedHeadersOptions>(options =>
    {
      options.KnownProxies.Add(IPAddress.Parse("10.0.0.100"));
    });
  }
  /* 
    Proxies running on loopback addresses (127.0.0.0/8, [::1]), 
    including the standard localhost address (127.0.0.1), are 
    trusted by default. If other trusted proxies or networks within 
    the organization handle requests between the Internet and the 
    web server, add them to the list of KnownProxies or KnownNetworks 
    with ForwardedHeadersOptions. The following example adds 
    a trusted proxy server at IP address 10.0.0.100 to the 
    Forwarded Headers Middleware KnownProxies in Startup.ConfigureServices
  */
  public void Configure() {
    // using Microsoft.AspNetCore.HttpOverrides;
    app.UseForwardedHeaders(new ForwardedHeadersOptions
    {
      ForwardedHeaders = ForwardedHeaders.XForwardedFor | ForwardedHeaders.XForwardedProto
    });
    app.UseAuthentication();
  }
}
```


## Install nginx on Ubuntu

To install nginx:

```console
$ sudo tee /etc/apt/sources.list.d/nginx.list <<'EOF'
> deb https://nginx.org/packages/ubuntu/ Bionic nginx
> deb-src https://nginx.org/packages/ubuntu/ Bionic nginx
> EOF
deb https://nginx.org/packages/ubuntu/ Bionic nginx
deb-src https://nginx.org/packages/ubuntu/ Bionic nginx
$ sudo apt-get update
$ sudo apt-get install nginx
$ # eventually:
$ sudo apt-get install fcgiwrap nginx-doc
$
$ # start service:
$ sudo service nginx start
$ # Verify a browser displays the default landing page for Nginx:
$ # curl http://<server_IP_address>/index.nginx-debian.html
```

## Configure nginx on Ubuntu

Nginx should be configured to work as reverse proxy forwarding packets
to Kestrel working at `http://127.0.0.1:5000`. Configuration can be
set up in file `/etc/nginx/sites-available/default`:

```nginx
server {
    listen   80 default_server;
    # listen [::]:80 default_server deferred;
    return   444;
}

server {
    listen        80;
    server_name   example.com *.example.com;
    location / {
        proxy_pass         http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header   Upgrade $http_upgrade;
        proxy_set_header   Connection keep-alive;
        proxy_set_header   Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header   X-Forwarded-Proto $scheme;
    }
}
```

Sometimes ASP.net Core apps needs big header sizes, it can be
configured using:

- [proxy_buffer_size](https://nginx.org/docs/http/ngx_http_proxy_module.html#proxy_buffer_size)
- [proxy_buffers](https://nginx.org/docs/http/ngx_http_proxy_module.html#proxy_buffers)
- [proxy_busy_buffers_size](https://nginx.org/docs/http/ngx_http_proxy_module.html#proxy_busy_buffers_size)
- [large_client_header_buffers](https://nginx.org/docs/http/ngx_http_core_module.html#large_client_header_buffers)


To apply configurations to nginx:

```console
$ # to verify synthax of config files:
$ sudo nginx -t
$ # to apply configurations:
$ sudo nginx -s reload
$ # run the app, (kill it with ctrl+c)
$ dotnet <app_assembly.dll>
ctrl+c
$
```

## Init scripts (`systemd`)

`systemd` OS service have services for application management.
(Other solution is to use for example `dockerd`,
but than docker will need to be managed by `systemd`.)

To add management service for something, service definition file must
be created. (Global configuration files are: `systemd-system.conf`,
`system.conf.d`, `systemd-user.conf`, `user.conf.d`)



```sh
sudo nano /etc/systemd/system/kestrel-helloapp.service
```

for ASP.net Core it could be:

```ini
[Unit]
Description=Example .NET Web API App running on Ubuntu

[Service]
WorkingDirectory=/var/www/helloapp
ExecStart=/usr/bin/dotnet /var/www/helloapp/helloapp.dll
Restart=always
# Restart service after 10 seconds if the dotnet service crashes:
RestartSec=10
# The default value is 90 seconds for most distributions.
TimeoutStopSec=90
KillSignal=SIGINT
SyslogIdentifier=dotnet-example
User=www-data
Environment=ASPNETCORE_ENVIRONMENT=Production
Environment=DOTNET_PRINT_TELEMETRY_MESSAGE=false

[Install]
WantedBy=multi-user.target
```

To apply configuration, start service and check its status:

```console
$ sudo systemctl enable kestrel-helloapp.service
$ sudo systemctl start kestrel-helloapp.service
$ sudo systemctl status kestrel-helloapp.service

◝ kestrel-helloapp.service - Example .NET Web API App running on Ubuntu
    Loaded: loaded (/etc/systemd/system/kestrel-helloapp.service; enabled)
    Active: active (running) since Thu 2016-10-18 04:09:35 NZDT; 35s ago
Main PID: 9021 (dotnet)
    CGroup: /system.slice/kestrel-helloapp.service
            └─9021 /usr/local/bin/dotnet /var/www/helloapp/helloapp.dll
```


The user that manages the service is specified by the User option. The
`User` (`www-data`) must exist and have proper ownership of the app's
files.

`TimeoutStopSec` is the duration of time to wait for the app to shut
down after it receives the initial interrupt signal. If the app
doesn't shut down in this period, SIGKILL is issued to terminate the
app. Provide the value as unitless seconds (for example, 150), a time
span value (for example, 2min 30s), or infinity to disable the
timeout.


Proper values of key-val pairs in configuration files can be
generated using `systemd-escape` program:

```console
$ systemd-escape 'Conne ction / i st &a $ENV @ __ + * yo'
Conne\x20ction\x20-\x20i\x20st\x20\x26a\x20\x24ENV\x20\x40\x20__\x20\x2b\x20\x2a\x20yo
```

## View logs

```console
$ sudo journalctl -fu kestrel-helloapp.service --since "2016-10-18" --until "2016-10-18 04:00"
```

## Enabling and configuring Ubuntu securites

- Enable AppArmor -  AppArmor is a Linux Security Modules (LSM) that
  implements a Mandatory Access Control system which allows confining
  the program to a limited set of resources.
- Configure the firewall - Close off all external ports that are not
  in use. Uncomplicated firewall (ufw) provides a front end for
  iptables by providing a CLI for configuring the firewall.

```console
$ sudo apt-get install ufw

$ # this allows for SSH:
$ sudo ufw allow 22/tcp
$ # this allows browsers HTTP:
$ sudo ufw allow 80/tcp
$ # this allows browsers HTTPS:
$ sudo ufw allow 443/tcp

$ sudo ufw enable
```

## Control request response headers by ModSecurity proxy server

[ModSecurity](https://www.modsecurity.org/about.html) is a toolkit for
real-time web application monitoring, logging, and access control.
ModSecurity it is tool for HTTP traffic inspection.

ModSecurity: 
- can work as reverse proxie effectively behaveing as HTTP router
- can narrow down the HTTP features you are willing to accept (e.g.,
  request methods, request headers, content types, etc.).
- give access to the HTTP traffic stream, in real-time, along with the
  ability to inspect it.
- uses full request and response buffering.

## Nginx and HTTPS

Configure the app to use a certificate in development for the dotnet
run command or development environment (F5 or Ctrl+F5 in Visual Studio
Code) by replacing default certificate from configuration file
(`appsettings.json`):

```json
{
  "Kestrel": {
    "Endpoints": {
      "Http": {
        "Url": "http://localhost:5000"
      },
      "HttpsInlineCertFile": {
        "Url": "https://localhost:5001",
        "Certificate": {
          "Path": "<path to .pfx file>",
          "Password": "<certificate password>"
        }
      },
      "HttpsInlineCertStore": {
        "Url": "https://localhost:5002",
        "Certificate": {
          "Subject": "<subject; required>",
          "Store": "<certificate store; required>",
          "Location": "<location; defaults to CurrentUser>",
          "AllowInvalid": "<true or false; defaults to false>"
        }
      },
      "HttpsDefaultCert": {
        "Url": "https://localhost:5003"
      },
      "Https": {
        "Url": "https://*:5004",
        "Certificate": {
          "Path": "<path to .pfx file>",
          "Password": "<certificate password>"
        }
      }
    },
    "Certificates": {
      "Default": {
        "Path": "<path to .pfx file>",
        "Password": "<certificate password>"
      }
    }
  }
}
```

Than configure the reverse proxy (Nginx server) for secure (HTTPS)
client connections:

In `/etc/nginx/nginx.conf` :

```nginx
http {
    proxy_redirect          off;
    proxy_set_header        Host $host;
    proxy_set_header        X-Real-IP $remote_addr;
    proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header        X-Forwarded-Proto $scheme;
    client_max_body_size    10m;
    client_body_buffer_size 128k;
    proxy_connect_timeout   90;
    proxy_send_timeout      90;
    proxy_read_timeout      90;
    proxy_buffers           32 4k;
    limit_req_zone $binary_remote_addr zone=one:10m rate=5r/s;
    server_tokens  off;

    sendfile on;
    keepalive_timeout   29; # Adjust to the lowest possible value that makes sense for your use case.
    client_body_timeout 10; client_header_timeout 10; send_timeout 10;

    upstream helloapp{
        server localhost:5000;
    }

    server {
        listen     *:80;
        add_header Strict-Transport-Security max-age=15768000;
        return     301 https://$host$request_uri;
    }

    server {
        listen                    *:443 ssl;
        server_name               example.com;
        ssl_certificate           /etc/ssl/certs/testCert.crt;
        ssl_certificate_key       /etc/ssl/certs/testCert.key;
        ssl_protocols             TLSv1.1 TLSv1.2;
        ssl_prefer_server_ciphers on;
        ssl_ciphers               "EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH";
        ssl_ecdh_curve            secp384r1;
        ssl_session_cache         shared:SSL:10m;
        ssl_session_tickets       off;
        ssl_stapling              on; #ensure your cert is capable
        ssl_stapling_verify       on; #ensure your cert is capable

        add_header Strict-Transport-Security "max-age=63072000; includeSubdomains; preload";
        add_header X-Frame-Options DENY;

        # This header prevents most browsers from MIME-sniffing a 
        # response away from the declared content type, as the header 
        # instructs the browser not to override the response content type. 
        # With the nosniff option, if the server says the content is "text/html", 
        # the browser renders it as "text/html".
        add_header X-Content-Type-Options nosniff;

        # this mitigates clickjacking
        # https://blog.qualys.com/securitylabs/2015/10/20/clickjacking-a-common-implementation-mistake-that-can-put-your-websites-in-danger
        add_header X-Frame-Options "SAMEORIGIN";

        #Redirects all traffic
        location / {
            proxy_pass http://helloapp;
            limit_req  zone=one burst=10 nodelay;
        }
    }
}
```

This:
- Configures the server to listen to HTTPS traffic on port 443 by
  specifying a valid certificate issued by a trusted Certificate
  Authority (CA).
- Hardens the security by employing some of the practices depicted in
  the following /etc/nginx/nginx.conf file. Examples include choosing
  a stronger cipher and redirecting all traffic over HTTP to HTTPS.
- Adds an HTTP Strict-Transport-Security (HSTS) header. It ensures all
    subsequent requests made by the client are over HTTPS. If HTTPS
    will be disabled in the future, use one of the following
    approaches:
  - Don't add the HSTS header.
  - Choose a short max-age value.


# Apache

https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/linux-apache?view=aspnetcore-3.1

Module configuration files are in `/etc/httpd/conf.modules.d/`.
For helloapp create `/etc/httpd/conf.modules.d/helloapp.conf`:

```
<VirtualHost *:*>
    RequestHeader set "X-Forwarded-Proto" expr=%{REQUEST_SCHEME}
</VirtualHost>

<VirtualHost *:80>
    ProxyPreserveHost On
    ProxyPass / http://127.0.0.1:5000/
    ProxyPassReverse / http://127.0.0.1:5000/
    ServerName www.example.com
    ServerAlias *.example.com
    ErrorLog ${APACHE_LOG_DIR}helloapp-error.log
    CustomLog ${APACHE_LOG_DIR}helloapp-access.log common
</VirtualHost>
```

The VirtualHost block can appear multiple times, in one or more files
on a server. In the preceding configuration file, Apache accepts
public traffic on port 80. The domain www.example.com is being served,
and the *.example.com alias resolves to the same website. See
Name-based virtual host support for more information. Requests are
proxied at the root to port 5000 of the server at 127.0.0.1. For
bi-directional communication, ProxyPass and ProxyPassReverse are
required.

# Authentication - ASP.NET Core Identity


ASP.NET Core Identity:

- Is an API that supports user interface (UI) login functionality.
- Manages users, passwords, profile data, roles, claims, tokens, email
  confirmation, and more.

Users can create an account with the login information stored in
Identity or they can use an external login provider. Supported
external login providers include: 
- Facebook, 
- Google, 
- Microsoft Account, and 
- Twitter.

Identity is typically configured using a SQL Server database to store
user names, passwords, and profile data. Alternatively, another
persistent store can be used, for example, Azure Table Storage.


ASP.NET Core Identity adds user interface (UI) login functionality to
ASP.NET Core web apps. To secure web APIs and SPAs, use one of the
following:
- Azure Active Directory
- Azure Active Directory B2C (Azure AD B2C)
- IdentityServer4

IdentityServer4 is an OpenID Connect and OAuth 2.0 framework for
ASP.NET Core.

# JSON Web Token (JWT)

[JSON Web Token (JWT)](https://jwt.io/introduction/) is an open
standard (RFC 7519) that defines a compact and self-contained way for
securely transmitting information between parties as a JSON object.
This information can be verified and trusted because it is digitally
signed. JWTs can be signed using a secret (with the HMAC algorithm) or
a public/private key pair using RSA or ECDSA.

Although JWTs can be encrypted to also provide secrecy between
parties, we will focus on signed tokens. Signed tokens can verify the
integrity of the claims contained within it, while encrypted tokens
hide those claims from other parties. When tokens are signed using
public/private key pairs, the signature also certifies that only the
party holding the private key is the one that signed it.


Here are some scenarios where JSON Web Tokens are useful:

- **Authorization**: This is the most common scenario for using JWT.
  Once the user is logged in, each subsequent request will include the
  JWT, allowing the user to access routes, services, and resources
  that are permitted with that token. Single Sign On is a feature that
  widely uses JWT nowadays, because of its small overhead and its
  ability to be easily used across different domains.
- **Information Exchange**: JSON Web Tokens are a good way of securely
  transmitting information between parties. Because JWTs can be
  signed—for example, using public/private key pairs—you can be sure
  the senders are who they say they are. Additionally, as the
  signature is calculated using the header and the payload, you can
  also verify that the content hasn't been tampered with.

In its compact form, JSON Web Tokens consist of three parts separated
by dots (.), which are (https://en.wikipedia.org/wiki/JSON_Web_Token):

- Header (JSON encoded in base64)
  - The header typically consists of two parts: the type of the token,
    which is JWT, and 
  - the signing algorithm being used, such as HMAC SHA256 or RSA.
- Payload (JSON encoded in base64). There are three types of claims: 
  - registered, hese are a set of predefined claims which are not
    mandatory but recommended, to provide a set of useful,
    interoperable claims. Some of them are: 
    - iss (issuer), 
    - exp (expiration time), 
    - sub (subject), 
    - aud (audience), and
    - [others](https://tools.ietf.org/html/rfc7519#section-4.1).
  - public - These can be defined at will by those using JWTs. But to
    avoid collisions they should be defined in the IANA JSON Web Token
    Registry or be defined as a URI that contains a collision
    resistant namespace., and 
  - private - These are the custom claims created to share
    information between parties that agree on using them and are
    neither registered or public claims.
- Signature (JSON encoded in base64)
  - To create the signature part you have to take the encoded header, 
  - the encoded payload, 
  - a secret, 
  - the algorithm specified in the header, 
  - and sign that.

Therefore, a JWT typically looks like the following.

`xxxxx.yyyyy.zzzzz`


Do note that for signed tokens this information, though protected
against tampering, is readable by anyone. Do not put secret
information in the payload or header elements of a JWT unless it is
encrypted.

For example if you want to use the HMAC SHA256 algorithm, the
signature will be created in the following way:

```
base64UrlEncode(
  HMACSHA256(
    base64UrlEncode(header) + "." + base64UrlEncode(payload),
    secret
  )
)
```

Example header:

```json
{
  "alg": "HS256",
  "typ": "JWT"
}
```

Example payload:

```json
{
  "sub": "1234567890",
  "name": "John Doe",
  "admin": true
}
```

Example verify signature generator function:

```
base64UrlEncode(
  HMACSHA256(
    base64UrlEncode(header) + "." +
    base64UrlEncode(payload),
    your-256-bit-secret
  )
)
```

Example result:

```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.cThIIoDvwdueQB468K5xDc5633seEFoqwxjF_xSJyQQ
```

Browser typical usage:

![JWT usage](images/client-credentials-grant.png)


# ASP.NET Core data protection

https://docs.microsoft.com/en-us/aspnet/core/security/data-protection/using-data-protection?view=aspnetcore-3.1

At its simplest, protecting data consists of the following steps:

1. Create a data protector from a data protection provider.
2. Call the Protect method with the data you want to protect.
3. Call the Unprotect method with the data you want to turn back into
   plain text.

## IDataProtectionProvider

The provider interface represents the root of the data protection
system. It cannot directly be used to protect or unprotect data.
Instead, the consumer must get a reference to an IDataProtector by
calling IDataProtectionProvider.CreateProtector(purpose), where
purpose is a string that describes the intended consumer use case.

## IDataProtector

The protector interface is returned by a call to CreateProtector, and
it's this interface which consumers can use to perform protect and
unprotect operations.

To protect a piece of data, pass the data to the Protect method. The
basic interface defines a method which converts byte[] -> byte[], but
there's also an overload (provided as an extension method) which
converts string -> string.

If the protected payload has been tampered with or was produced by a
different IDataProtector, the Unprotect method will throw
CryptographicException.

The concept of same vs. different IDataProtector ties back to the
concept of purpose. If two IDataProtector instances were generated
from the same root IDataProtectionProvider but via different purpose
strings in the call to IDataProtectionProvider.CreateProtector, then
they're considered different protectors, and one won't be able to
unprotect payloads generated by the other.

## ITimeLimitedDataProtector

https://docs.microsoft.com/en-us/aspnet/core/security/data-protection/consumer-apis/limited-lifetime-payloads?view=aspnetcore-3.1


## IKeyManager

https://docs.microsoft.com/en-us/aspnet/core/security/data-protection/consumer-apis/dangerous-unprotect?view=aspnetcore-3.1

```cs
// get a reference to the key manager and revoke all keys in the key ring
var keyManager = services.GetService<IKeyManager>();
Console.WriteLine("Revoking all keys in the key ring...");
keyManager.RevokeAllKeys(DateTimeOffset.Now, "Sample revocation.");
```

The value returned by the Protect method is now protected (enciphered
and tamper-proofed), and the application can send it to an untrusted
client.

## Without dependency injection (DI)

https://docs.microsoft.com/en-us/aspnet/core/security/data-protection/configuration/non-di-scenarios?view=aspnetcore-3.1


## Key ring storage (filesystem, redis)

https://docs.microsoft.com/en-us/aspnet/core/security/data-protection/implementation/key-storage-providers?view=aspnetcore-3.1&tabs=visual-studio

```cs
// Redis
public void ConfigureServices(IServiceCollection services)
{
    var redis = ConnectionMultiplexer.Connect("<URI>");
    services.AddDataProtection()
        .PersistKeysToStackExchangeRedis(redis, "DataProtection-Keys");
}
// File system
public void ConfigureServices(IServiceCollection services)
{
    services.AddDataProtection()
        .PersistKeysToFileSystem(new DirectoryInfo(@"c:\temp-keys\"));
}
```

## Key storage format in ASP.NET Core

https://docs.microsoft.com/en-us/aspnet/core/security/data-protection/implementation/key-storage-format?view=aspnetcore-3.1

Objects are stored at rest in XML representation. The default
directory for key storage is:

- Windows: `*%LOCALAPPDATA%\ASP.NET\DataProtection-Keys*`
- macOS / Linux: `$HOME/.aspnet/DataProtection-Keys`

## EphemeralDataProtectionProvider

https://docs.microsoft.com/en-us/aspnet/core/security/data-protection/implementation/key-storage-ephemeral?view=aspnetcore-3.1

This type provides a basic implementation of IDataProtectionProvider
whose key repository is held solely in-memory and isn't written out to
any backing store.

Each instance of EphemeralDataProtectionProvider uses its own unique
master key. Therefore, if an IDataProtector rooted at an
EphemeralDataProtectionProvider generates a protected payload, that
payload can only be unprotected by an equivalent IDataProtector (given
the same purpose chain) rooted at the same
EphemeralDataProtectionProvider instance.


# Secret Manager

https://docs.microsoft.com/en-us/aspnet/core/security/app-secrets?view=aspnetcore-3.1&tabs=linux

Dont store secrets in (publicated) source code, at least
store it in env vars witch overrides configuration files
key values.

Bether use SecretManager tool.

The Secret Manager tool stores sensitive data during the development
of an ASP.NET Core project. In this context, a piece of sensitive data
is an app secret. App secrets are stored in a separate location from
the project tree. The app secrets are associated with a specific
project or shared across several projects. The app secrets aren't
checked into source control.

## How the Secret Manager tool works

The Secret Manager tool abstracts away the implementation details,
such as where and how the values are stored. You can use the tool
without knowing these implementation details. The values are stored in
a JSON configuration file in a system-protected user profile folder on
the local machine:

```
~/.microsoft/usersecrets/<user_secrets_id>/secrets.json
```

In the preceding file paths, replace `<user_secrets_id>` with the
UserSecretsId value specified in the `.csproj` file.

## Use

The Secret Manager tool includes an init command in .NET Core SDK
3.0.100 or later. To use user secrets, run the following command in
the project directory:

```console
$ dotnet user-secrets init
```

The preceding command adds a UserSecretsId element within a
PropertyGroup of the .csproj file. By default, the inner text of
UserSecretsId is a GUID. The inner text is arbitrary, but is unique to
the project.

```xml
<PropertyGroup>
  <TargetFramework>netcoreapp3.1</TargetFramework>
  <UserSecretsId>79a3edd0-2092-40a2-a04d-dcb46d5ca9ed</UserSecretsId>
</PropertyGroup>
```

## Set a secret

Define an app secret consisting of a key and its value. The secret is
associated with the project's UserSecretsId value. For example, run
the following command from the directory in which the .csproj file
exists:

```console
$ # call from .csproj folder
$ dotnet user-secrets set "Movies:ServiceApiKey" "12345"
$ # batch of secrets:
$ cat ./input.json | dotnet user-secrets set
$ # or call from any folder specyfying to wihich proj it applys:
$ dotnet user-secrets set "Movies:ServiceApiKey" "12345" --project "C:\apps\WebApp1\src\WebApp1"
```

In the preceding example, the colon denotes that Movies is an object
literal with a ServiceApiKey property.

Secrets are in encoded file `secrets.json` similar to:

```json
{
  "Movies:ServiceApiKey": "12345"
}
```

## Access a secret

The ASP.NET Core Configuration API provides access to Secret Manager
secrets.

The user secrets configuration source is automatically added in
development mode when the project calls CreateDefaultBuilder to
initialize a new instance of the host with preconfigured defaults.
CreateDefaultBuilder calls AddUserSecrets when the EnvironmentName is
Development.

User secrets can be retrieved via the Configuration API:

```cs
public class Startup
{
    private string _moviesApiKey = null;

    public Startup(IConfiguration configuration)
    {
        Configuration = configuration;
    }

    public IConfiguration Configuration { get; }

    public void ConfigureServices(IServiceCollection services)
    {
        // **********************
        // ****** its here!!! ***
        // **********************
        _moviesApiKey = Configuration["Movies:ServiceApiKey"];
    }

    public void Configure(IApplicationBuilder app)
    {
        app.Run(async (context) =>
        {
            var result = string.IsNullOrEmpty(_moviesApiKey) ? "Null" : "Not Null";
            await context.Response.WriteAsync($"Secret is {result}");
        });
    }
}
```

Automatically suck all secrets to POCO:

```cs
public class MovieSettings {
  public string ConnectionString { get; set; }
  public string ServiceApiKey { get; set; }
}

public class Consumer {
  public void GetSecrets() {
    var moviesConfig = Configuration.GetSection("Movies")
      .Get<MovieSettings>();
    _moviesApiKey = moviesConfig.ServiceApiKey;
  }
}
```

To list all stored secrets:

```console
$ dotnet user-secrets list
Movies:ConnectionString = Server=(localdb)\mssqllocaldb;Database=Movie-1;Trusted_Connection=True;MultipleActiveResultSets=true
Movies:ServiceApiKey = 12345
```

## Remove a secret

```console
$ # rem secret with key:
$ dotnet user-secrets remove "Movies:ConnectionString"
$ # rem all secrets:
$ dotnet user-secrets clear
```

# Enforce HTTPS in ASP.NET Core

## API projects

Do not use RequireHttpsAttribute on Web APIs that receive sensitive
information. RequireHttpsAttribute uses HTTP status codes to redirect
browsers from HTTP to HTTPS. API clients may not understand or obey
redirects from HTTP to HTTPS. Such clients may send information over
HTTP. Web APIs should either:

- Not listen on HTTP.
- Close the connection with status code 400 (Bad Request) and not
  serve the request.

## HSTS and API projects

The default API projects don't include HSTS because HSTS is generally
a browser only instruction. Other callers, such as phone or desktop
apps, do not obey the instruction. Even within browsers, a single
authenticated call to an API over HTTP has risks on insecure networks.

- The secure approach is to configure API projects to only listen to
  and respond over HTTPS.

## Require HTTPS

ASP.NET Core recommend that production ASP.NET Core web apps use:

- HTTPS Redirection Middleware (UseHttpsRedirection) to redirect HTTP
  requests to HTTPS.
- HSTS Middleware (UseHsts) to send HTTP Strict Transport Security
  Protocol (HSTS) headers to clients.

## Reverse proxies

Apps deployed in a reverse proxy configuration allow the proxy to
handle connection security (HTTPS). If the proxy also handles HTTPS
redirection, there's no need to use HTTPS Redirection Middleware. If
the proxy server also handles writing HSTS headers (for example,
native HSTS support in IIS 10.0 (1709) or later), HSTS Middleware
isn't required by the app. For more information, see Opt-out of
HTTPS/HSTS on project creation.

## HTTPS Redirection Middleware alternative approach

An alternative to using HTTPS Redirection Middleware
(UseHttpsRedirection) is to use URL Rewriting Middleware
(AddRedirectToHttps). AddRedirectToHttps can also set the status code
and port when the redirect is executed. For more information, see URL
Rewriting Middleware.

When redirecting to HTTPS without the requirement for additional
redirect rules, we recommend using HTTPS Redirection Middleware
(UseHttpsRedirection) described in this topic.


## HTTP Strict Transport Security Protocol (HSTS)

Per OWASP, HTTP Strict Transport Security (HSTS) is an opt-in security
enhancement that's specified by a web app through the use of a
response header. When a browser that supports HSTS receives this
header:

- The browser stores configuration for the domain that prevents
  sending any communication over HTTP. The browser forces all
  communication over HTTPS.
- The browser prevents the user from using untrusted or invalid
  certificates. The browser disables prompts that allow a user to
  temporarily trust such a certificate.

Because HSTS is enforced by the client, it has some limitations:

- The client must support HSTS.
- HSTS requires at least one successful HTTPS request to establish the
  HSTS policy.
- The application must check every HTTP request and redirect or reject
  the HTTP request.

ASP.NET Core 2.1 and later implements HSTS with the UseHsts extension
method. 

UseHsts isn't recommended in development because the HSTS settings are
highly cacheable by browsers. By default, UseHsts excludes the local
loopback address.

UseHsts excludes the following loopback hosts:

- localhost : The IPv4 loopback address.
- 127.0.0.1 : The IPv4 loopback address.
- [::1] : The IPv6 loopback address.

## Opt-out of HTTPS/HSTS on project creation

In some backend service scenarios where connection security is handled
at the public-facing edge of the network, configuring connection
security at each node isn't required. Web apps that are generated from
the templates in Visual Studio or from the dotnet new command enable
HTTPS redirection and HSTS.

To opt-out of HTTPS/HSTS:

```console
$ dotnet new webapp --no-https
```

## How to set up a developer certificate for Docker

[See this GitHub issue.](https://github.com/dotnet/AspNetCore.Docs/issues/6199)

## All platforms - certificate not trusted

Run the following commands:

```console
$ dotnet dev-certs https --clean
$ dotnet dev-certs https --trust
```

Close any browser instances open. Open a new browser window to app.
Certificate trust is cached by browsers.

The preceding commands solve most browser trust issues. If the browser
is still not trusting the certificate, follow the platform-specific
suggestions that follow.

## Hosting ASP.NET Core images with Docker over HTTPS

https://docs.microsoft.com/en-us/aspnet/core/security/docker-https?view=aspnetcore-3.1


# EU cookis and stored data encryption

https://docs.microsoft.com/en-us/aspnet/core/security/gdpr?view=aspnetcore-3.1

## Encryption at rest

Some databases and storage mechanisms allow for encryption at rest.
Encryption at rest:

- Encrypts stored data automatically.
- Encrypts without configuration, programming, or other work for the
  software that accesses the data.
- Is the easiest and safest option.
- Allows the database to manage keys and encryption.

For example:

- Microsoft SQL and Azure SQL provide Transparent Data Encryption
  (TDE).
- SQL Azure encrypts the database by default
- Azure Blobs, Files, Table, and Queue Storage are encrypted by
  default.

For databases that don't provide built-in encryption at rest, you may
be able to use disk encryption to provide the same protection. For
example:

- BitLocker for Windows Server
- Linux:
  - eCryptfs
  - EncFS.

# !! Prevent Cross-Site Request Forgery (XSRF/CSRF) attacks in ASP.NET Core

https://docs.microsoft.com/en-us/aspnet/core/security/anti-request-forgery?view=aspnetcore-3.1

An example of a CSRF attack:

1. A user signs into www.good-banking-site.com using forms
   authentication. The server authenticates the user and issues a
   response that includes an authentication cookie. The site is
   vulnerable to attack because it trusts any request that it receives
   with a valid authentication cookie.

2. The user visits a malicious site, www.bad-crook-site.com.
   The malicious site, www.bad-crook-site.com, contains an HTML form
   similar to the following:
   ```HTML
   <h1>Congratulations! You're a Winner!</h1>
   <form action="http://good-banking-site.com/api/account" method="post">
       <input type="hidden" name="Transaction" value="withdraw">
       <input type="hidden" name="Amount" value="1000000">
       <input type="submit" value="Click to collect your prize!">
   </form>
   ```
   Notice that the form's action posts to the vulnerable site, not to
   the malicious site. This is the "cross-site" part of CSRF.
3. The user selects the submit button. The browser makes the request
   and automatically includes the authentication cookie for the
   requested domain, www.good-banking-site.com.
4. The request runs on the www.good-banking-site.com server with the
   user's authentication context and can perform any action that an
   authenticated user is allowed to perform.


In addition to the scenario where the user selects the button to
submit the form, the malicious site could:
- Run a script that automatically submits the form.
- Send the form submission as an AJAX request.
- Hide the form using CSS.

These alternative scenarios don't require any action or input from the
user other than initially visiting the malicious site.

Using HTTPS doesn't prevent a CSRF attack. The malicious site can send
an https://www.good-banking-site.com/ request just as easily as it can
send an insecure request.

Some attacks target endpoints that respond to GET requests, in which
case an image tag can be used to perform the action. This form of
attack is common on forum sites that permit images but block
JavaScript. Apps that change state on GET requests, where variables or
resources are altered, are vulnerable to malicious attacks. GET
requests that change state are insecure. A best practice is to never
change state on a GET request.

CSRF attacks are possible against web apps that use cookies for
authentication because:

- Browsers store cookies issued by a web app.
- Stored cookies include session cookies for authenticated users.
- Browsers send all of the cookies associated with a domain to the web
  app every request regardless of how the request to app was generated
  within the browser.

However, CSRF attacks aren't limited to exploiting cookies. For
example, Basic and Digest authentication are also vulnerable. After a
user signs in with Basic or Digest authentication, the browser
automatically sends the credentials until the session† ends.

†In this context, session refers to the client-side session during
which the user is authenticated. It's unrelated to server-side
sessions or ASP.NET Core Session Middleware.

Users can guard against CSRF vulnerabilities by taking precautions:

- Sign off of web apps when finished using them.
- Clear browser cookies periodically.

However, CSRF vulnerabilities are fundamentally a problem with the web
app, not the end user.

# Prevent open redirect attacks in ASP.NET Core

https://docs.microsoft.com/en-us/aspnet/core/security/preventing-open-redirects?view=aspnetcore-3.1

For example, consider an app at contoso.com that includes a login page
at http://contoso.com/Account/LogOn?returnUrl=/Home/About. The attack
follows these steps:

1. The user clicks a malicious link to
   http://contoso.com/Account/LogOn?returnUrl=http://contoso1.com/Account/LogOn
   (the second URL is "contoso1.com", not "contoso.com").
2. The user logs in successfully.
3. The user is redirected (by the site) to
   http://contoso1.com/Account/LogOn (a malicious site that looks
   exactly like real site).
4. The user logs in again (giving malicious site their credentials)
   and is redirected back to the real site.

The user likely believes that their first attempt to log in failed and
that their second attempt is successful. The user most likely remains
unaware that their credentials are compromised.


# Prevent Cross-Site Scripting (XSS) in ASP.NET Core

https://docs.microsoft.com/en-us/aspnet/core/security/cross-site-scripting?view=aspnetcore-3.1

Cross-Site Scripting (XSS) is a security vulnerability which enables
an attacker to place client side scripts (usually JavaScript) into web
pages. When other users load affected pages the attacker's scripts
will run, enabling the attacker to steal cookies and session tokens,
change the contents of the web page through DOM manipulation or
redirect the browser to another page. XSS vulnerabilities generally
occur when an application takes user input and outputs it to a page
without validating, encoding or escaping it.

# CORS enabling and works

https://docs.microsoft.com/en-us/aspnet/core/security/cors?view=aspnetcore-3.1

https://developer.mozilla.org/docs/Web/HTTP/CORS

## How CORS works

This section describes what happens in a CORS request at the level of
the HTTP messages.

- CORS is not a security feature. CORS is a W3C standard that allows a
  server to relax the same-origin policy.
  - For example, a malicious actor could use Cross-Site Scripting
    (XSS) against your site and execute a cross-site request to their
    CORS enabled site to steal information.
- An API isn't safer by allowing CORS.
  - It's up to the client (browser) to enforce CORS. The server
    executes the request and returns the response, it's the client
    that returns an error and blocks the response. For example, any of
    the following tools will display the server response:
    - Fiddler
    - Postman
    - .NET HttpClient
    - A web browser by entering the URL in the address bar.
- It's a way for a server to allow browsers to execute a cross-origin
  XHR or Fetch API request that otherwise would be forbidden.
  - Browsers without CORS can't do cross-origin requests. Before CORS,
    JSONP was used to circumvent this restriction. JSONP doesn't use
    XHR, it uses the `<script>` tag to receive the response. Scripts
    are allowed to be loaded cross-origin.

The CORS specification introduced several new HTTP headers that enable
cross-origin requests. If a browser supports CORS, it sets these
headers automatically for cross-origin requests. Custom JavaScript
code isn't required to enable CORS.

The PUT test button on the deployed sample

The following is an example of a cross-origin request from the Values
test button to https://cors1.azurewebsites.net/api/values. The Origin
header:

- Provides the domain of the site that's making the request.
- Is required and must be different from the host.

General headers
```
Request URL: https://cors1.azurewebsites.net/api/values
Request Method: GET
Status Code: 200 OK
```

Response headers
```
Content-Encoding: gzip
Content-Type: text/plain; charset=utf-8
Server: Microsoft-IIS/10.0
Set-Cookie: ARRAffinity=8f...;Path=/;HttpOnly;Domain=cors1.azurewebsites.net
Transfer-Encoding: chunked
Vary: Accept-Encoding
X-Powered-By: ASP.NET
```

Request headers
```
Accept: */*
Accept-Encoding: gzip, deflate, br
Accept-Language: en-US,en;q=0.9
Connection: keep-alive
Host: cors1.azurewebsites.net
Origin: https://cors3.azurewebsites.net
Referer: https://cors3.azurewebsites.net/
Sec-Fetch-Dest: empty
Sec-Fetch-Mode: cors
Sec-Fetch-Site: cross-site
User-Agent: Mozilla/5.0 ...
```

In OPTIONS requests, the server sets the Response headers
Access-Control-Allow-Origin: {allowed origin} header in the response.
For example, the deployed sample, Delete `[EnableCors]` button OPTIONS
request contains the following headers:

General headers
```
Request URL: https://cors3.azurewebsites.net/api/TodoItems2/MyDelete2/5
Request Method: OPTIONS
Status Code: 204 No Content
```

Response headers
```
Access-Control-Allow-Headers: Content-Type,x-custom-header
Access-Control-Allow-Methods: PUT,DELETE,GET,OPTIONS
Access-Control-Allow-Origin: https://cors1.azurewebsites.net
Server: Microsoft-IIS/10.0
Set-Cookie: ARRAffinity=8f...;Path=/;HttpOnly;Domain=cors3.azurewebsites.net
Vary: Origin
X-Powered-By: ASP.NET
```

Request headers
```
Accept: */*
Accept-Encoding: gzip, deflate, br
Accept-Language: en-US,en;q=0.9
Access-Control-Request-Headers: content-type
Access-Control-Request-Method: DELETE
Connection: keep-alive
Host: cors3.azurewebsites.net
Origin: https://cors1.azurewebsites.net
Referer: https://cors1.azurewebsites.net/test?number=2
Sec-Fetch-Dest: empty
Sec-Fetch-Mode: cors
Sec-Fetch-Site: cross-site
User-Agent: Mozilla/5.0
```

In the preceding Response headers, the server sets the
Access-Control-Allow-Origin header in the response. The
https://cors1.azurewebsites.net value of this header matches the
Origin header from the request.

If AllowAnyOrigin is called, the Access-Control-Allow-Origin: *, the
wildcard value, is returned. AllowAnyOrigin allows any origin.

If the response doesn't include the Access-Control-Allow-Origin
header, the cross-origin request fails. Specifically, the browser
disallows the request. Even if the server returns a successful
response, the browser doesn't make the response available to the
client app.


# !Security cheetsheet

https://cheatsheetseries.owasp.org/cheatsheets/DotNet_Security_Cheat_Sheet.html


# Usefull catches

https://docs.microsoft.com/en-us/aspnet/core/performance/performance-best-practices?view=aspnetcore-3.1


