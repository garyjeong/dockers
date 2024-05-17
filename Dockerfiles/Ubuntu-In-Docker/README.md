```
docker build -t ubuntu-server .
docker run -d --privileged -p 2222:22 --cpus="3" --name ubuntu-server ubuntu-server
ssh root@localhost -p 2222
```