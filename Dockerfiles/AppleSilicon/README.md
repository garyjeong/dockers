### Base Command
```
<!-- Base -->
docker build -t [Image Name] .
docker run -t -d --name [Container Name]

<!-- SSH Container -->
docker build -t [Image Name] -f [Dockerfile Name] .
docker run -t -d -p [SSH Out Port]:22 --name [Container Name]
```
