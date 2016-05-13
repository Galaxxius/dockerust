# ACHTUNG 
This is just a copy/fork of **@Dids** (on Twitter) great project Didstopia/rust-server. 
I love it! Thank you for bringing Rust into a handy format and creating this, Dids <3

So, all thanks go to Dids. I do some modifications here only for learning purposes.

-Galaxxius
# ACHTUNG ENDE 

# Rust server that runs inside a Docker container

**NOTE**: This image will install/update on startup. The path ```/steamcmd/rust``` can be mounted on the host for data persistence.
Also note that this image provides the new web-based RCON, so you should set ```RUST_RCON_PASSWORD``` to a more secure password.

# How to run the server
1. Set the environment variables you wish to modify from below (note the RCON password!)
2. Optionally mount ```/steamcmd/rust``` somewhere on the host or inside another container to keep your data safe
3. Enjoy!

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
