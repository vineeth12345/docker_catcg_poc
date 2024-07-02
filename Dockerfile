FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

COPY ["SimpleApi/SimpleApi.csproj", "SimpleApi/"]
RUN dotnet restore "SimpleApi/SimpleApi.csproj"

COPY . .
WORKDIR "/src/SimpleApi"
RUN dotnet build "SimpleApi.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "SimpleApi.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SimpleApi.dll"]
