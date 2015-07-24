cutText ["", "BLACK IN", 10];

_Hint_Brief = localize "STR_FS_HINT_BRIEF"; 

_Journal_Brief = format ["<br/>%1<br/><br/>%2<br/><br/>%3<br/><br/>%4<br/><br/>%5<br/><br/>%6<br/><br/>", localize "STR_FS_HINT_KEYS_01", localize "STR_FS_HINT_KEYS_02", localize "STR_FS_HINT_KEYS_03", localize "STR_FS_HINT_KEYS_04", localize "STR_FS_HINT_KEYS_05", localize "STR_FS_HINT_KEYS_06"]; 

_Journal_SaveLoad = format ["<br/>%1<br/><br/>%2<br/><br/>%3<br/><br/>", localize "STR_FS_SAVELOAD_01", localize "STR_FS_SAVELOAD_02", localize "STR_FS_SAVELOAD_03"];

hint _Hint_Brief;
player createDiarySubject ["VRF","VR Fortress"];
player createDiaryRecord ["VRF", [localize "STR_FS_Title_Construction", _Journal_Brief]];
player createDiaryRecord ["VRF", [localize "STR_FS_Title_SaveNLoad", _Journal_SaveLoad]];

// Generating 20-symbol unique player ID for VRFortress Mission
if (isNil {profileNameSpace getVariable "VRFORTRESS_PlayerID"}) then 
{
	_generatedID = "VRF";
	_alph = 
	[
		"a","b","c","d","e","f","g","h",	
		"i","k","l","m","n","o","p","q",	
		"r","s","t","v","x","y","z",
		"A","B","C","D","E","F","G","H",
		"I","K","L","M","N","O","P","Q",
		"R","S","T","V","X","Y","Z",
		"0","1","2","3","4","5","6","7","8","9"
	];
	if (!isNil {BIS_fnc_arrayShuffle}) then 
	{
		_alph = _alph call BIS_fnc_arrayShuffle; 
	};
	
	for "_i" from 0 to 16 do 
	{
		_char = _alph select floor random count _alph;
		_generatedID = _generatedID + _char;
	};
	
	profileNameSpace setVariable ["VRFORTRESS_PlayerID", _generatedID];
};

_generatedID = profileNameSpace getVariable "VRFORTRESS_PlayerID";
player setVariable ["VRFORTRESS_PlayerID", _generatedID, TRUE];

//////////////////////////////////////////
// Nametags script & Levels Features
//////////////////////////////////////////

player setVariable ["VRFORTRESS_PlayerLVL", profileNameSpace getVariable ["VRFORTRESS_PlayerLVL", 0], TRUE];
as = group player execVM "scripts\Nametags.sqf";
as = [] execVM "scripts\LevelFeatures.sqf";

//////////////////////////////////////////
//	Waiting for server
//////////////////////////////////////////

waitUntil {!isNil {SERVER getVariable "ticketsCount"}};
ticketsCount = SERVER getVariable "ticketsCount";

// published by server in ParametersMenu.sqf
waitUntil {!isNil {SERVER getVariable "ChckbxEnPerks"}};	
if (SERVER getVariable "ChckbxEnPerks") then { as = [] execVM "scripts\bulletTrace.sqf"; };

as = [] execVM "scripts\addActions.sqf";

// published by server in ParametersMenu.sqf
waitUntil {!isNil {SERVER getVariable "ChckbxEnKS"}}; 
if (SERVER getVariable "ChckbxEnKS") then
{
	Heli_Script = compile preprocessFile "scripts\heli.sqf";
	as = [] execVM "scripts\killstreaks.sqf"; 
};

// published by server in ParametersMenu.sqf
waitUntil {!isNil {SERVER getVariable "startingTime"}}; 
setDate [2035, 4, 29, SERVER getVariable "startingTime", 0];

// published by server in ParametersMenu.sqf
waitUntil {!isNil {SERVER getVariable "ChckbxEndless"}};	
if (SERVER getVariable "ChckbxEndless") then { as = [] execVM "endlessMode.sqf"; };

// SNOW 
// published by server in ParametersMenu.sqf
waitUntil {!isNil {SERVER getVariable "ChckbxEnSnow"}}; 
if (SERVER getVariable "ChckbxEnSnow") then 
{
	_density = SERVER getVariable "SEL_SNOWDNST";
	as = [_density] execVM "scripts\snow.sqf";
};	