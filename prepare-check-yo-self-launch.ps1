$LOCAL_NUGET_PACKAGE_SOURCE_DIRECTORY="~/.nuget/NuGet/local-nuget-package-source"

# Let's start with our dependencies (NuGets)
# Create indexer SDK NuGet
Set-Location ../check-yo-self-indexer/check-yo-self-indexer-SDK/build-scripts
pwsh ./packNugets.ps1
# Copy SDK NuGet to the local package source folder
Copy-Item -Force ../nupkg/*.nupkg $LOCAL_NUGET_PACKAGE_SOURCE_DIRECTORY

Set-Location ../../

# Create API SDK NuGet
Set-Location ../check-yo-self-api/check-yo-self-api-SDK/build-scripts
pwsh ./packNugets.ps1
# Copy SDK NuGet to the local package source folder
Copy-Item -Force ../nupkg/*.nupkg $LOCAL_NUGET_PACKAGE_SOURCE_DIRECTORY

Set-Location ../../

# Now let's deal with Docker container image building
# Create indexer Docker image
Set-Location ../check-yo-self-indexer
pwsh ./dockerize.ps1
# Create indexer Docker image
Set-Location ../check-yo-self-api
pwsh ./dockerize.ps1
# Create front-end/BFF app Docker image
Set-Location ../check-yo-self
npm i
pwsh ./dockerize.ps1
# Create bootstrapper Docker image
Set-Location ../check-yo-self-bootstrapper
pwsh ./dockerize.ps1