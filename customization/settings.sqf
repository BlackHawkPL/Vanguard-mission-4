ace_cookoff_enable = false;
ace_cookoff_ammoCookoffDuration = 0;
ace_cookoff_enableAmmoCookoff = false;
ace_hearing_enableCombatDeafness = false;
ACE_weather_syncWind = false;
ACE_wind = [0,0,0];
setWind [2,2, true];

//ACE
//Who can use SurgicalKit. 0 = anyone, 1 = Medics, 2 = Doctors
ace_medical_medicSetting_SurgicalKit = 2;
//Remove SurgicalKit on use. 0 = no, 1 = yes.
ace_medical_consumeItem_SurgicalKit = 0;
//Where can SurgicalKits be used (see also Condition below). 0 = Anywhere, 1 = Medical Vehicles, 2 = Medical Facility, 3 = Vheicles and Facility, 0 = disabled.
ace_medical_useLocation_SurgicalKit = 0;
//When can the SuricalKit be used. 0 = Anytime, 1 = When pation is stable (no pain, bleeding)
ace_medical_useCondition_SurgicalKit = 1;

ace_repair_engineerSetting_repair = 0;
ace_repair_engineerSetting_wheel = 0;
ace_repair_repairDamageThreshold = 1;
ace_repair_repairDamageThreshold_engineer = 1;
ace_repair_fullRepairLocation = 1;
ace_repair_engineerSetting_fullRepair = 0;
ace_repair_wheelRepairRequiredItems = 1;

if (isServer) then { //This scope is only for the server

	setViewDistance 2500; //View distance for the server (the ai's)

	FW_TimeLimit = 0; //Time limit in minutes, to disable the time limit set it to 0
	FW_TimeLimitMessage = "TIME LIMIT REACHED!"; //The message displayed when the time runs out

	[west, "US Army", "player"] call FNC_AddTeam; //Adds a player team called USMC on side west
	[east, "MSV", "player"] call FNC_AddTeam; //Adds a ai team called VDV on side east
	
	// [resistance, "Local Militia", "player"] call FNC_AddTeam; //Adds a player team called Local Militia on side resistance (aka independent)

	condition = 0;
	
};

if (!isDedicated) then { //This scope is only for the player

	FW_DebugMessagesEnabled = false;//Only disable debug messages when the mission is released

	setViewDistance 2500; //View distance for the player

	FW_terrainGridPFH_handle = [{
        if (time > 0 && {getTerrainGrid != 2}) then {
            setTerrainGrid 2;
        };
    }, 1] call CBA_fnc_addPerFrameHandler;

	[{!isNull (findDisplay 46)},
    {
        (findDisplay 46) displayAddEventHandler ["MouseMoving", {
            if (serverCommandAvailable "#kick") then {
                FW_IsAdmin = true;
            } else {
                FW_IsAdmin = false;
            };
        }];
    }] call CBA_fnc_WaitUntilAndExecute;
    
	_action = ["admin_menu", "Admin Menu", "", {}, {!isNil "FW_IsAdmin" && {FW_IsAdmin}}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

	_action = ["end_red", "End mission, winner: MSV", "", {
		"MSV VICTORY" remoteExecCall ["FNC_EndMission", 2];
	}, {!isNil "FW_IsAdmin" && {FW_IsAdmin}}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "admin_menu"], _action] call ace_interact_menu_fnc_addActionToObject;
	
	_action = ["end_blu", "End mission, winner: US Army", "", {
		"US ARMY VICTORY" remoteExecCall ["FNC_EndMission", 2];
	}, {!isNil "FW_IsAdmin" && {FW_IsAdmin}}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "admin_menu"], _action] call ace_interact_menu_fnc_addActionToObject;
	
	switch (side player) do { //Checks what team the player is on

		case west: { //If player is west he receives this respawn ticket count
			
			FW_RespawnTickets = 0;//If respawn is enabled you must create empty game logics, for respawn points, following the name format fw_side_respawn. Example: fw_west_respawn
			
		}; //End of west case
	}; //End of switch
};