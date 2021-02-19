

# MS Build

https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild-project-file-schema-reference?view=vs-2019

## Links

- https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild?view=vs-2019
- https://docs.microsoft.com/en-us/aspnet/web-forms/overview/deployment/web-deployment-in-the-enterprise/understanding-the-project-file


## Overview

![MS build csproj structure](images/MSBuild_structure.png)

- properties to manage variables for the build process.
- items to identify the inputs to the build process, like code files
- targets and tasks to provide execution instructions to
  MSBuild, using properties and items defined elsewhere in
  the project file


```console
$ msbuild -h
$ msbuild Publish.proj /t:LogMessage
```


```
- project
  - PropertyGroup
    - Property
  - ItemGroup
    - Item
      - ItemMetadata
  - Target
    - Task
    - PropertyGroup
      - Property
    - ItemGroup 
      - Item
        - ItemMetadata

```

## Refering MSBuild elements

The following table lists MSBuild special characters:

- `%` - 	(ASCI `%25`) - 	Referencing metadata
- `$` - 	(ASCI `%24`) - 	Referencing properties
- `@` - 	(ASCI `%40`) - 	Referencing item lists
- `'` - 	(ASCI `%27`) - 	Conditions and other expressions
- `;` - 	(ASCI `%3B`) - 	List separator
- `?` -   (ASCI `%3F`) -  Wildcard character for file names
  in `Include` and `Exclude` attributes
- `*` -   (ASCI `%2A`) -  Wildcard character for use in file
  names in `Include` and `Exclude` attributes

The following table describes the reserved XML characters
that must be replaced by the corresponding named entity so
that the project file can be parsed.

- `<` -	escape with `&lt;`
- `>` -	escape with `&gt;`
- `&` -	escape with `&amp;`
- `"` -	escape with `&quot;`
- `'` -	escape with `&apos;`

## Example

Example `Publish.proj`:

```xml
<Project 
  ToolsVersion="4.0" 
  DefaultTargets="FullPublish" 
  xmlns="http://schemas.microsoft.com/developer/msbuild/2003"
>
  
  <!-- PropertyGroup defines constants: -->
  <PropertyGroup>    
    <ServerName>FABRIKAM\TEST1</ServerName>
    <ConnectionString>
      Data Source=FABRIKAM\TESTDB;InitialCatalog=ContactManager,...
    </ConnectionString>
    <MySettingsReferencingOther>$(ServerName)1</MySettingsReferencingOther>
    <!-- If condition true set OutputRoot: -->
    <Configuration Condition=" '$(Configuration)'=='' ">Release</Configuration>
    <OutputRoot Condition=" '$(OutputRoot)'=='' ">..\Publish\Out\</OutputRoot>
    <!-- commands also can be stored: -->
    <_Cmd>"$(VsdbCmdExe)" 
      /a:Deploy 
      /cs:"%(DbPublishPackages.DatabaseConnectionString)" 
      /p:TargetDatabase=%(DbPublishPackages.TargetDatabase)             
      /manifest:"%(DbPublishPackages.FullPath)" 
      /script:"$(_CmDbScriptPath)" 
      $(_DbDeployOrScript)
    </_Cmd>
  </PropertyGroup>
  <PropertyGroup>   
    <FullPublishDependsOn>
      Clean;
      BuildProjects;      
      GatherPackagesForPublishing;
      PublishDbPackages;
      PublishWebPackages;
    </FullPublishDependsOn>
  </PropertyGroup>
  <!-- xml also may be stored in properties: -->
  <!-- Conditioned may be whole property group!!! -->
  <PropertyGroup Condition="'$(Flavor)'=='DEBUG'">
    <ConfigTemplate>
        <Configuration>
            <Startup>
                <SupportedRuntime
                    ImageVersion="$(MySupportedVersion)"
                    Version="$(MySupportedVersion)"/>
                <RequiredRuntime
                    ImageVersion="$(MyRequiredVersion)"
                    Version="$(MyRequiredVersion)"
                    SafeMode="$(MySafeMode)"/>
            </Startup>
        </Configuration>
    </ConfigTemplate>
  </PropertyGroup>



  <!-- ItemGroup defines imput lists (of files) -->
  <ItemGroup>
    <ProjectsToBuild Include="$(SourceRoot)ContactManager-WCF.sln"/>
  </ItemGroup>
  <!-- Item types can be referenced throughout the project file by using the syntax @(<ItemType>) -->
  <ItemGroup>
    <Reference Include="Microsoft.CSharp" />
    <Reference Include="System.Runtime.Serialization" />
    <Reference Include="System.ServiceModel" />
  </ItemGroup>
  <!-- @(Compile) will have list of all files to compile -->
  <ItemGroup>
    <Compile Include="Controllers\AccountController.cs;one.cs;three.cs" />
    <Compile Include="Controllers\ContactsController.cs" />
    <Compile Include="Controllers\HomeController.cs" />
  </ItemGroup>
  <ItemGroup>
    <Content Include="Content\Custom.css" />
    <Content Include="CreateDatabase.sql" />
    <Content Include="DropDatabase.sql" />
  </ItemGroup>
  <ItemGroup>
    <FirstItem Include="rhinoceros">
      <Class>mammal</Class>
      <Size>large</Size>
    </FirstItem>
  </ItemGroup>
  <ItemGroup>
    <CSFile Include="*.cs" Exclude="Form2.cs;Form3.cs"/>
  </ItemGroup>
  <ItemGroup>
    <theItem Include="andromeda;tadpole;cartwheel" />
  </ItemGroup>


  <Target Name = "go">
      <Message Text="IndexOf  @(theItem->IndexOf('r'))" />
      <Message Text="Replace  @(theItem->Replace('tadpole', 'pinwheel'))" />
      <Message Text="Length   @(theItem->get_Length())" />
      <Message Text="Chars    @(theItem->get_Chars(2))" />
  </Target>
  <!-- 
    Output:
    IndexOf  3;-1;2
    Replace  andromeda;pinwheel;cartwheel
    Length   9;7;9
    Chars    d;d;r
   -->

  <Target Name="MyTarget">
    <ItemGroup>
      <SecondItem Include="@(FirstItem)" KeepMetadata="Class" />
    </ItemGroup>

    <Message Text="FirstItem: %(FirstItem.Identity)" />
    <Message Text="  Class: %(FirstItem.Class)" />
    <Message Text="  Size:  %(FirstItem.Size)"  />

    <Message Text="SecondItem: %(SecondItem.Identity)" />
    <Message Text="  Class: %(SecondItem.Class)" />
    <Message Text="  Size:  %(SecondItem.Size)"  />
  </Target>
  <Target Name="RunMyCmd">
    <Exec Command="$(_Cmd)"/>
  </Target>
  <Target Name="FullPublish" DependsOnTargets="$(FullPublishDependsOn)" />
  <Target Name="LogMessage">
    <Message Text="Hello world!" />
  </Target>
  <Target Name="BuildProjects" Condition=" '$(BuildingInTeamBuild)'!='true' ">
    <MSBuild Projects="@(ProjectsToBuild)"           
            Properties="OutDir=$(OutputRoot);
                        Configuration=$(Configuration);
                        DeployOnBuild=true;
                        DeployTarget=Package"
            Targets="Build" 
    />
  </Target>
  <Target Name="Clean" Condition=" '$(BuildingInTeamBuild)'!='true' ">
    <Message Text="Cleaning up the output directory [$(OutputRoot)]"/>
    <ItemGroup>
      <_FilesToDelete Include="$(OutputRoot)**\*"/>
    </ItemGroup>
    <Delete Files="@(_FilesToDelete)"/>
    <RemoveDir Directories="$(OutputRoot)"/>
  </Target>
</Project>
```

## Referencing

Every defined thing may be referenced elseware:

```sh
$(ServerName)
$(ConfigTemplate.Configuration.Startup.SupportedRuntime.ImageVersion)
# To insert a comma and a space between items
# Use item notation similar to the following:
@(CSFile, ', ')

```

## Overriding

Properties can be set/overriden from command args:

```console
$ msbuild Publish.proj /p:ServerName=FABRIKAM\TESTWEB1
```

## Targets and Tasks

In the MSBuild schema, a Task element represents an
individual build instruction (or task). MSBuild includes a
multitude of predefined tasks. For example:

- The `Copy` task copies files to a new location.
- The `Csc` task invokes the Visual C# compiler.
- The `Exec` task runs a specified program.
- The `Message` task writes a message to a logger.


Target element is a set of one or more tasks that are
executed sequentially, and a project file can contain
multiple targets. When you want to run a task, or a set of
tasks, you invoke the target that contains them.


## Batching

In MSBuild project files, batching is a technique for
iterating over collections. The value of the Outputs
attribute, `"%(DbPublishPackages.Identity)"`, refers to the
Identity metadata property of the DbPublishPackages item
list. This notation, `Outputs=%(ItemList.ItemMetadataName)`,
is translated as:

- Split the items in DbPublishPackages into batches of items
  that contain the same Identity metadata value.
- Execute the target once per batch.


# Project items

- commonly used items: https://docs.microsoft.com/en-us/visualstudio/msbuild/common-msbuild-project-items?view=vs-2019
- item group container: https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild-project-file-schema-reference?view=vs-2019
- items: https://docs.microsoft.com/en-us/visualstudio/msbuild/item-element-msbuild?view=vs-2019


```xml
<!-- Condition  Optional attribute. Condition to be evaluated.  -->
<!-- Label  Optional attribute. Identifies the ItemGroup. -->
<ItemGroup Condition="'String A' == 'String B'" Label="Label">
  <!-- item: -->
  <Res Include = "Strings.fr.resources" >
    <Culture>fr</Culture>
  </Res>
  <Res Include = "Dialogs.fr.resources" >
    <Culture>fr</Culture>
  </Res>

  <!-- 
    Attributes:  

    - Include - Optional attribute. The file or wildcard to include 
      in the list of items.
    - Exclude - Optional attribute. The file or wildcard to include 
      in the list of items.
    - Condition - Optional attribute. The condition to be evaluated.
    - Remove - Optional attribute. The file or wildcard to remove 
      from the list of items.
    - Update - Optional attribute. Enables you to modify metadata of 
      an item; typically used to override the default metadata of 
      specific items after a group of items is intially specified 
      (such as with a wildcard).

      This attribute is valid only if it's specified for an item in 
      an ItemGroup that is not in a Target.
    - ..... - other attributes (see links above)
  -->
  <CodeFiles Include="**\*.cs" Exclude="**\generated\*.cs" />
  <CodeFiles Include="..\..\Resources\Constants.cs" >
    <MyMetadata>HelloWorld</MyMetadata>
  </CSFile>
</ItemGroup>
```

## EmbeddedResources

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">

  <PropertyGroup>
    <TargetFramework>netcoreapp3.0</TargetFramework>
  </PropertyGroup>

  <PropertyGroup>
    <EmbedLocalReferences Condition=" '$(EmbedLocalReferences)' == '' ">False</EmbedLocalReferences>
  </PropertyGroup>

  <!-- typically -->
  <ItemGroup>
    <EmbeddedResource Include="SQLScripts\01-Tables.sql" />
    <EmbeddedResource Include="SQLScripts\02-Sprocs.sql" />
  </ItemGroup>

  <!-- also as fragment of task -->
  <!-- Following will cause output assembly contains all .dll references as EmbeddedResource. -->
  <!-- https://stackoverflow.com/questions/51607558/msbuild-create-embeddedresource-before-build -->
  <Target Name="EmbedLocal" BeforeTargets="ResolveReferences" Condition=" '$(EmbedLocalReferences)' == 'True' ">
    <Message Text="Run EmbedLocal for $(MSBuildProjectFullPath)..." Importance="high"/>
    <ItemGroup>
      <EmbeddedResource Include="@(ReferenceCopyLocalPaths->WithMetadataValue( 'Extension', '.dll' )->Metadata( 'FullPath' ))">
        <LogicalName>%(ReferenceCopyLocalPaths.Filename)%(ReferenceCopyLocalPaths.Extension)</LogicalName>
      </EmbeddedResource>
    </ItemGroup>   
    <Message Text="Embed local references complete for $(OutputPath)$(TargetFileName)." Importance="high" />
  </Target>

</Project>
```

## None

Represents files that should have no role in the build process.

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
<ItemGroup>
  <None Include="file that does not matter" />
</ItemGroup>
</Project>

```

# Project Items Common Metadata

https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild-well-known-item-metadata?view=vs-2019

Eg. include:

```xml
<ItemGroup>
    <MyItem Include="Source\Program.cs" />
</ItemGroup>
```


## `%(FullPath)` 
Contains the full path of the item. For example:

`C:\MyProject\Source\Program.cs`


## `%(RootDir)`

Contains the root directory of the item. For example:

`C:\`

## `%(Filename)`

Contains the file name of the item, without the
  extension. For example:

`Program`

## `%(Extension)`

Contains the file name extension of the item. For
  example:

`.cs`


## `%(RelativeDir)`

Contains the path specified in the Include attribute, up to the final
backslash (`\`). For example:

`Source\`

If the Include attribute is a full path, `%(RelativeDir)` begins with
the root directory `%(RootDir)`. For example:

`C:\MyProject\Source\`

## `%(Directory)`

Contains the directory of the item, without the root directory. For
example:

`MyProject\Source\`


## `%(RecursiveDir)`

If the Include attribute contains the wildcard
`**`, this metadata specifies the part of the path that replaces the
wildcard. 

If the folder `C:\MySolution\MyProject\Source\` contains the file
`Program.cs`, and if the project file contains this item:

```xml
<ItemGroup> 
  <MyItem Include="C:\**\Program.cs" /> 
</ItemGroup>
```    

then the value of `%(MyItem.RecursiveDir)` would be
`MySolution\MyProject\Source\`.


## `%(Identity)`
The item specified in the Include attribute. For example:

`Source\Program.cs`

## `%(ModifiedTime)`

Contains the timestamp from the last time the item was modified. For
example:

`2004-07-01 00:21:31.5073316`

## `%(CreatedTime)`

Contains the timestamp from when the item was created. For example:

`2004-06-25 09:26:45.8237425`

## `%(AccessedTime)`

Contains the timestamp from the last time the item was accessed.

`2004-08-14 16:52:36.3168743`


# Project properties

https://docs.microsoft.com/en-us/visualstudio/msbuild/common-msbuild-project-properties?view=vs-2019


```xml
<Project Sdk="Microsoft.NET.Sdk.Web">

  <PropertyGroup>
    <TargetFramework>netcoreapp3.0</TargetFramework>

    <!-- The path of csc.exe, the C# compiler. -->
    <CscToolPath>/somting/somting/csc</CscToolPath>
  </PropertyGroup>


</Project>
```

# MS Build CLI reference

https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild-command-line-reference?view=vs-2019

# Resource file generator (Resgen.exe)

https://docs.microsoft.com/en-us/dotnet/framework/tools/resgen-exe-resource-file-generator

# MS Bulid API

https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild-api?view=vs-2019

