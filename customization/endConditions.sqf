_westCasualty = "US Army" call FNC_CasualtyPercentage; //Gets the casualty percentage of team "USMC"
_eastCasualty = "MSV" call FNC_CasualtyPercentage; //Gets the casualty percentage of team "VDV"

if (condition == 1) exitWith {
	
	"MSV VICTORY<br />US Army has retreated due to casualties." call FNC_EndMission;
	
};

if (condition == 2) exitWith {
	
	"US Army VICTORY<br />MSV has retreated due to casualties." call FNC_EndMission;
	
};

sleep (60); //This determines how frequently the end conditions should be checked in seconds