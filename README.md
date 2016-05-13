# Rust server that runs inside a Digital Ocean Docker oneclick-app

**NOTE**: 
This is just a copy/fork of **@Dids** (on Twitter) great project Didstopia/rust-server. 
I love it! Thank you for bringing Rust into a handy format and creating this, Dids <3
So, all thanks go to Dids. I do some modifications here only for learning purposes.

Use cloudconfig.yaml for a Docker one-click app on Digital Ocean:
https://www.digitalocean.com/features/one-click-apps/docker/

Be sure to choose a droplet with at least 2GB RAM ;)

#What´s inside
1. Fresh Rust
2. Fresh Oxide
3. Fresh webrcon ( port 80)
4. All server data is persisted on the host droplet in /steamcmd/rust

You should set ```RUST_RCON_PASSWORD``` to a more secure password.

# How to run the server
1. Select the docker oneclick-app and paste the cloud config data
2. Set/change the environment variables you wish to modify from below (especially the RCON password!)
3. Spin up the droplet
4. Enjoy!

The following environment variables are available:
```
RUST_SERVER_STARTUP_ARGUMENTS (DEFAULT: "-batchmode -load -logfile /dev/stdout +server.secure 1")
RUST_SERVER_IDENTITY (DEFAULT: "dockerust" - Mainly used for the name of the save directory)
RUST_SERVER_SEED (DEFAULT: "12345" - The server map seed, must be an integer)
RUST_SERVER_NAME (DEFAULT: "Dockerust Server" - The publicly visible server name)
RUST_SERVER_DESCRIPTION (DEFAULT: "This is a Rust server running inside a Docker container!" - The publicly visible server description)
RUST_SERVER_URL (DEFAULT: "https://github.com/Galaxxius" - The publicly visible server website)
RUST_SERVER_BANNER_URL (DEFAULT: "" - The publicly visible server banner image URL)
ENV RUST_SERVER_MAXPLAYERS (DEFAULT: "50" - Number of allowed players on the server)
ENV RUST_SERVER_WORLDSIZE (DEFAULT: "4000" - World size for map generation. Values between 2000 and 8000 are possible)
RUST_RCON_WEB (DEFAULT "1" - Set to 1 or 0 to enable or disable the web-based RCON server)
RUST_RCON_PORT (DEFAULT: "28016" - RCON server port)
RUST_RCON_PASSWORD (DEFAULT: "changeme" - RCON server password, please change this!)
RUST_RESPAWN_ON_RESTART (DEFAULT: "0" - Controls whether to respawn resources on startup)
RUST_DISABLE_AUTO_UPDATE (DEFAULT: "0" - Disables automatic updating on startup)
```
