#!/bin/bash

# Run the server
docker run -p 28015:28015/tcp -p 28015:28015/udp -p 28016:28016 -p 80:8080 -v /steamcmd/rust:/steamcmd/rust -e RUST_RESPAWN_ON_RESTART=1 --name dockerust galaxxius/dockerust:latest
docker logs -f dockerust
