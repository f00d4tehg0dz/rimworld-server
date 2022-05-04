# rimworld-server
containerization of Rimworld mod Open World Server


Build by hand
```
git clone https://github.com/antimodes201/rimworld-server.git
docker build -t antimodes201/rimworld-server:latest .
```

Docker Pull
```
docker pull antimodes201/rimworld-server
```

Docker Run with defaults
change the volume options to a directory on your node and maybe use a different name then the one in the example

```
docker run -it -p 25555:25555/udp -p 25555:25555 -v /app/docker/temp-vol:/rimworld \
--name rimworld \
antimodes201/rimworld-server:latest
```

Currently exposed environmental variables and their default values
- GAME_PORT 25555
- TZ America/New_York

