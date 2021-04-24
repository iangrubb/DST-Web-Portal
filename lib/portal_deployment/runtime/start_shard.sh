#!/bin/bash

/home/dst/steamcmd.sh +@ShutdownOnFailedCommand 1 +@NoPromptForPassword 1 +login anonymous +force_install_dir /home/dst/portal_deployment/game_logic +app_update 343050 +quit

cd /home/dst/portal_deployment/game_logic/bin
exec ./dontstarve_dedicated_server_nullrenderer -cluster $1 -shard $2 -persistent_storage_root "/home/dst/portal_deployment/game_files" -conf_dir "clusters"
