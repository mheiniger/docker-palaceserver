# docker-palaceserver

Run "The Palace Server" as a Docker container.

## Read the the original licence
The original installer asked to agree to this: [License](license.txt), so only continue if you agree.

## optional for development: Build it
`docker-compose build`

## Run it
`docker-compose up`

## Connect
Start your Palace client and connect to [palace://127.0.1.1:9998](palace://127.0.1.1:9998)

On the first start you will be connected to a default palace.

## What do after the first start

* In your working directory, it now added a folder "run" which contains folder you can customize to make the palace your own.
* If you want to replace the pserver.pat file with the rooms, you need to stop the server first (ctrl-c).
* You can log in to your Palace with the default passwords: "owner" or "operator"
* Please change the default passwords with:
    ```
    `ownerpassword <password>
    `operatorpassword <password>
    ```

## When running on a server like Portainer etc.

* Make sure you define the $PWD variable and point it to a path where you want to store your palace data. For example `/home/<your-username>/dockerData/palace9998`