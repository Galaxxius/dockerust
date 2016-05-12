#!/usr/bin/env bash

pid=0

trap 'exit_handler' SIGHUP SIGINT SIGQUIT SIGTERM
exit_handler()
{
	echo "Shutdown signal received"

	if [ -f "/steamcmd/rust/server/$RUST_SERVER_IDENTITY/UserPersistence.db" ]; then
		# Backup the current blueprint data
		cp -fr "/steamcmd/rust/server/$RUST_SERVER_IDENTITY/UserPersistence.db" "/steamcmd/rust/UserPersistence.db.bak"
	fi
	
	# Execute the RCON shutdown command
	node /shutdown_app/app.js
	sleep 1

	# Force kill and exit
	kill $pid
	exit
}

# Create the necessary folder structure
if [ ! -d "/steamcmd/rust" ]; then
	echo "Creating folder structure.."
	mkdir -p /steamcmd/rust
fi

# Install/update steamcmd
echo "Installing/updating steamcmd.."
curl -s http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -v -C /steamcmd -zx

# Check if we are auto-updating or not
if [ "$RUST_DISABLE_AUTO_UPDATE" = "1" ]; then
	if [ ! -f "/steamcmd/rust/RustDedicated" ]; then
		# Install/update Rust from install.txt
		echo "Installing/updating Rust.."
		bash /steamcmd/steamcmd.sh +runscript /install.txt
	else
		echo "Rust seems to be installed, skipping automatic update.."
	fi
else
	# Install/update Rust from install.txt
	echo "Installing/updating Rust.."
	bash /steamcmd/steamcmd.sh +runscript /install.txt
fi

# Check if this is actually a modded server
if [ -d "/oxide" ]; then
	# Install/update Oxide
	echo "Installing/updating Oxide.."
	cp -fr /oxide/* /steamcmd/rust/
fi

# Add RCON support if necessary
RUST_STARTUP_COMMAND=$RUST_SERVER_STARTUP_ARGUMENTS
if [ ! -z ${RUST_RCON_PORT+x} ]; then
	RUST_STARTUP_COMMAND="$RUST_STARTUP_COMMAND +rcon.port $RUST_RCON_PORT"
fi
if [ ! -z ${RUST_RCON_PASSWORD+x} ]; then
	RUST_STARTUP_COMMAND="$RUST_STARTUP_COMMAND +rcon.password $RUST_RCON_PASSWORD"
fi
if [ ! -z ${RUST_RESPAWN_ON_RESTART+x} ]; then
	if [ "$RUST_RESPAWN_ON_RESTART" = "1" ]; then
		RUST_STARTUP_COMMAND="$RUST_STARTUP_COMMAND +spawn.fill_groups 1"
	fi
fi

if [ ! -z ${RUST_RCON_WEB+x} ]; then
	RUST_STARTUP_COMMAND="$RUST_STARTUP_COMMAND +rcon.web $RUST_RCON_WEB"
	if [ "$RUST_RCON_WEB" = "1" ]; then
		# Fix the webrcon (customize a few elements)
		bash /tmp/fix_conn.sh

		# Start nginx (in the background)
		echo "Starting web server.."
		nginx && sleep 5
		#nginx -g "daemon off;" && sleep 5
	fi
fi

# Check if a special seed override file exists
if [ -f "/steamcmd/rust/seed_override" ]; then
	RUST_SEED_OVERRIDE=`cat /steamcmd/rust/seed_override`
	echo "Found seed override: $RUST_SEED_OVERRIDE"

	# Modify the server identity to include the override seed
	RUST_SERVER_IDENTITY=$RUST_SEED_OVERRIDE
	RUST_SERVER_SEED=$RUST_SEED_OVERRIDE

	# Prepare the identity directory (if it doesn't exist)
	if [ ! -d "/steamcmd/rust/server/$RUST_SEED_OVERRIDE" ]; then
		echo "Creating seed override identity directory.."
		mkdir -p "/steamcmd/rust/server/$RUST_SEED_OVERRIDE"
		if [ -f "/steamcmd/rust/UserPersistence.db.bak" ]; then
			echo "Copying blueprint backup in place.."
			cp -fr "/steamcmd/rust/UserPersistence.db.bak" "/steamcmd/rust/server/$RUST_SEED_OVERRIDE/UserPersistence.db"
		fi
	fi
fi

# Set the working directory
cd /steamcmd/rust

# Run the server
echo "Starting Rust.."
/steamcmd/rust/RustDedicated $RUST_STARTUP_COMMAND +server.identity "$RUST_SERVER_IDENTITY" +server.seed "$RUST_SERVER_SEED"  +server.hostname "$RUST_SERVER_NAME" +server.url "$RUST_SERVER_URL" +server.headerimage "$RUST_SERVER_BANNER_URL" +server.description "$RUST_SERVER_DESCRIPTION" +server.maxplayers $RUST_SERVER_MAXPLAYERS +server.worldsize $RUST_SERVER_WORLDSIZE &
pid="$!"

wait
