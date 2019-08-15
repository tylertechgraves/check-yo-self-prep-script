#!/bin/bash

LOCAL_NUGET_PACKAGE_SOURCE_DIRECTORY="$HOME/.nuget/NuGet/local-nuget-package-source"

# Let's start with our dependencies (NuGets)
# Create indexer SDK NuGet
cd ../check-yo-self-indexer/check-yo-self-indexer-SDK/build-scripts || exit
./packNugets.sh
# Copy SDK NuGet to the local package source folder
cp -f ../nupkg/*.nupkg "$LOCAL_NUGET_PACKAGE_SOURCE_DIRECTORY"

cd ../../ || exit

# Create API SDK NuGet
cd ../check-yo-self-api/check-yo-self-api-SDK/build-scripts || exit
./packNugets.sh
# Copy SDK NuGet to the local package source folder
cp -f ../nupkg/*.nupkg "$LOCAL_NUGET_PACKAGE_SOURCE_DIRECTORY"

cd ../../ || exit

# Now let's deal with Docker container image building
# Create indexer Docker image
cd ../check-yo-self-indexer || exit
./dockerize.sh
# Create indexer Docker image
cd ../check-yo-self-api || exit
./dockerize.sh
# Create front-end/BFF app Docker image
cd ../check-yo-self || exit
npm i
./dockerize.sh
# Create bootstrapper Docker image
cd ../check-yo-self-bootstrapper || exit
./dockerize.sh