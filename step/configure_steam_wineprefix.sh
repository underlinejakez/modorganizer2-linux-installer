#!/bin/bash

if [ -n "${game_protontricks[*]}" ]; then
	log_info "applying protontricks ${game_protontricks[@]}"
	WINETRICKS="$downloaded_winetricks" \
	protontricks "$game_appid" -q "${game_protontricks[@]}" \
		| "$dialog" loading "Configuring game prefix\nThis may take a while"

	# FIXME this check won't work properly because of the piping above
	# the installer entrypoint also sets -e so it shouldn't even be reached
	if [ "$?" != "0" ]; then
		# TODO retry, passing option '--force' to winetricks, if issue #61 is detected
		"$dialog" errorbox \
			"Error while installing winetricks, check the terminal for more details"
		exit 1
	fi
fi

