if (isServer) then { //This scope is only for the server

	setViewDistance 2500; //View distance for the server (the ai's)

	FW_TimeLimit = 300; //Time limit in minutes, to disable the time limit set it to 0
	FW_TimeLimitMessage = "TIME LIMIT REACHED!"; //The message displayed when the time runs out

	[west, "US Army", "player"] call FNC_AddTeam; //Adds a player team called USMC on side west
	[east, "MSV", "player"] call FNC_AddTeam; //Adds a ai team called VDV on side east
	
	// [resistance, "Local Militia", "player"] call FNC_AddTeam; //Adds a player team called Local Militia on side resistance (aka independent)

	condition = 0;
	
	ace_cookoff_enable = false;
    ace_cookoff_ammoCookoffDuration = 0;
    ace_hearing_enableCombatDeafness = false;
    ACE_weather_syncWind = false;
    ACE_wind = [0,0,0];
    setWind [2,2, true];
	
};

if (!isDedicated) then { //This scope is only for the player

	FW_DebugMessagesEnabled = true;//Only disable debug messages when the mission is released

	setViewDistance 2500; //View distance for the player
	
	switch (side player) do { //Checks what team the player is on

		case west: { //If player is west he receives this respawn ticket count
			
			FW_RespawnTickets = 0;//If respawn is enabled you must create empty game logics, for respawn points, following the name format fw_side_respawn. Example: fw_west_respawn
			
		}; //End of west case
	}; //End of switch

	[{if (time > 0 && {getTerrainGrid != 2}) then {setTerrainGrid 2;}}, 0] call CBA_fnc_addPerFrameHandler;
};