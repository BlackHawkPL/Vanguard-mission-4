["Bradley Spawn parameter", "For choosing where bradleys spawn", "BlackHawk"] call FNC_RegisterModule;

if ((["bradleySpawn",0] call BIS_fnc_getParamValue) == 1) then {
	OTHER_SPAWN = true;
};