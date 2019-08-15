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

All source code for this project can be found in the following GitHub repos:

1. [check-yo-self-prep-script (this repo)](https://github.com/tylertechgraves/check-yo-self-prep-script)
2. [check-yo-self](https://github.com/tylertechgraves/check-yo-self)
3. [check-yo-self-api](https://github.com/tylertechgraves/check-yo-self-api)
4. [check-yo-self-indexer](https://github.com/tylertechgraves/check-yo-self-indexer)
5. [check-yo-self-bootstrapper](https://github.com/tylertechgraves/check-yo-self-bootstrapper)

Finally, you will need to set up a local NuGet package feed.
[Use these instructions to accomplish this task.](https://docs.microsoft.com/en-us/nuget/hosting-packages/local-feeds)

### Using the prepare-check-yo-self-launch script

The prepare-check-yo-self-launch script will set up everything you need to run
check-yo-self on your machine within a Docker environment.

Running the script is simple.

First, clone all the GitHub repos listed above into the same folder on your machine.

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