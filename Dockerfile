FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env

WORKDIR /app

RUN apt-get update && apt-get install -y git && git clone https://github.com/aserdja/Hillel.HW17.git .

WORKDIR /app/HW17

RUN dotnet restore
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0

WORKDIR /app/HW17
COPY --from=build-env /app/HW17/out .

EXPOSE 8080

ENTRYPOINT ["dotnet", "HW17.dll"]