```
docker build -t ubuntu-silicon-server .
docker run -d -p 2222:22 --name ubuntu-silicon-server ubuntu-silicon-server
ssh root@localhost -p 2222
```

