# Setting up your local machine to run check-yo-self

## Introduction

The check-yo-self app is designed to demonstrate several things:

1. ASP<i>.</i>NET Core WebApi basics
2. Entity Framework Core basics
3. Elasticsearch basics
4. How to create an API that generates its own SDK NuGet using NSwag
for consumption by other developers who will use the API
5. How to use the backend-for-frontend pattern
6. How to write a very basic Angular frontend
7. How to use Docker, including building container images, configuration
and voluming
8. How to use docker-compose to create a local development environment

## Machine Setup

The project contains absolutely no proprietary content. It was built
exclusively using open source and free software. In order to run this
application on your machine, `you should install the following prerequisites:`

1. [git](https://git-scm.com/downloads)
2. [Docker Desktop](https://www.docker.com/products/docker-desktop)
3. [.NET SDK 2.2 or greater](https://dotnet.microsoft.com/download)
4. [Visual Studio Code](https://code.visualstudio.com/download)
5. [NodeJS LTS Version](https://nodejs.org/en/download/)
6. [Omnisharp Extension for Visual Studio Code (install within Visual Studio Code)](https://marketplace.visualstudio.com/items?itemName=ms-vscode.csharp)
7. [PowerShell 6](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-6)

All source code for this project can be found in the following GitHub repos:

1. [check-yo-self-prep-script (this repo)](https://github.com/tylertechgraves/check-yo-self-prep-script)
2. [check-yo-self](https://github.com/tylertechgraves/check-yo-self)
3. [check-yo-self-api](https://github.com/tylertechgraves/check-yo-self-api)
4. [check-yo-self-indexer](https://github.com/tylertechgraves/check-yo-self-indexer)
5. [check-yo-self-bootstrapper](https://github.com/tylertechgraves/check-yo-self-bootstrapper)

### Creating a local NuGet package feed

Finally, you will need to set up a local NuGet package feed.
The instructions Microsoft provides aren't the best, but here they are:

https://docs.microsoft.com/en-us/nuget/hosting-packages/local-feeds

Or you can just do what I tell you.  That seems easiest, doesn't it?

On a Windows machine, you'll need to create a folder and share it.
That will result in a UNC path that looks something like this:

`\\<your machine name>\<some path>`

On other operating systems (MacOS & Linux), just create a folder and note its name.

Finally, run the following command to add this source to your machine's
global NuGet configuration file (NuGet.Config):

```bash
nuget sources Add -Name "LocalNuGetPackageFeed" -Source <folder/UNC path you created above>
```

If you want to update the config XML yourself without using the command above,
you can find your global NuGet.Config file in the following locations:

Windows: %appdata%\NuGet\NuGet.Config

Mac/Linux: ~/.config/NuGet/NuGet.Config or ~/.nuget/NuGet/NuGet.Config (varies by OS distribution)

### Using the prepare-check-yo-self-launch script

The prepare-check-yo-self-launch script will set up everything you need to run
check-yo-self on your machine within a Docker environment.

Running the script is simple.

First, clone all the GitHub repos listed above into the same folder on your machine.
Make sure to use the repo names as the folder names into which you clone
the code.  So it should look something like this when you're done:

check-yo-self-repos/</br>
├── check-yo-self/</br>
├── check-yo-self-api/</br>
├── check-yo-self-bootstrapper/</br>
├── check-yo-self-indexer/</br>
└── check-yo-self-prep-script/

Next, select one of the two available scripts. There is a PowerShell version
and a bash shell version. Depending on your OS, you will likely want to choose
one over the other.

Update the script, replacing the `LOCAL_NUGET_PACKAGE_SOURCE_DIRECTORY`
script variable with the path on your machine to your local NuGet package feed.

Finally, run the script.  The script will generate NuGets for the API SDK
and for the indexer SDK, then it will create the Docker images required
to run the docker-compose environment in which check-yo-self is design to run.

Finally, you will run

```bash
docker-compose up -d
```

in the check-yo-self-indexer project to run the platform services.

Allow Elasticsearch to completely come to life before proceeding.
You can check to see if Elasticsearch is running by hitting Kibana at
[http://localhost:5601](http://localhost:5601).  Once Kibana is ready
and able to query Elasticsearch, continue.

Finally, you will run

```bash
docker-compose up -d
```

in the check-yo-self-api project to run the check-yo-self services.
Once those services are running, navigate to [http://localhost:5000](http://localhost:5000)
to run and test the check-yo-self app.
