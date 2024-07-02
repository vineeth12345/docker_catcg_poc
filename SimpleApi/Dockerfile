# Use the official .NET SDK image for build stage
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Set the working directory
WORKDIR /src

# Copy the .csproj file and restore the dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application code
COPY . ./
RUN dotnet publish -c Release -o /app

# Use the official .NET runtime image for runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0

WORKDIR /app
COPY --from=build /app .

# Set the entry point for the application
ENTRYPOINT ["dotnet", "SimpleApi.dll"]

