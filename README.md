# docker-palaceserver

Run "The Palace Server" as a Docker container.

## Read the the original licence
The original installer asked to agree to this: [License](license.txt), so only continue if you agree.

## Build it
`docker build -t palaceserver .`

## Run it
`docker run -p 9998:9998 -p 9990:9990 --name pserver palaceserver`

## Connect
Start your Palace client and connect to [palace://localhost:9998](palace://localhost:9998)
