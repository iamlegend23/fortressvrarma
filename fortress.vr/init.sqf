
START_PISTOL = "hgun_ACPC2_F";
START_PISTOL_AMMO = "9Rnd_45ACP_Mag";

player LinkItem "ItemMap";
{player addMagazine START_PISTOL_AMMO} forEach [0,0,0,0,0,0];
player AddWeapon START_PISTOL;

[player, [missionNameSpace, "FS_PLAYER_LOADOUT"]] call BIS_fnc_saveInventory;
['Preload', true] call BIS_fnc_arsenal;
as = [] execVM "scripts\A3_FESS_fnc_Bomber.sqf";

FS_CountDownMsg = {
	disableSerialization;
	_layer = "FS_CountDown" call BIS_fnc_rscLayer;
	_layer cutRsc ["RscDynamicText", "PLAIN"];
	_ctrl = (uiNamespace getVariable "BIS_dynamicText") displayCtrl 9999;
	_ctrl ctrlSetPosition [0,0];
	_ctrl ctrlCommit 0;
	_text = format
	[
		"<t align = 'center' shadow = '0' size = '0.7'>%1</t>",
		_this
	];
	_ctrl ctrlSetStructuredText parseText _text;
	_ctrl ctrlSetFade 1;
	_ctrl ctrlCommit 2;
};
FS_FindPlayerByID = {
	private ["_unit", "_x", "_this"];
	_unit = objNull;
	{
		if ((isPlayer _x) && (_x getVariable "VRFORTRESS_PlayerID" == _this)) exitWith 
		{
			_unit = _x;
		};
	}
	forEach allUnits;
	_unit
};
FS_GetUnitsCount = {
	{side _x == (_this select 0) && alive _x} count allUnits
};
FS_GlobalHint = {
	hint _this;
};
FS_Janitor = {
	if (!isServer) exitWith {};
	{
		_x removeAllEventHandlers "killed"; 
		removeAllActions _x;
		deleteVehicle _x;
	}
	forEach AllDead;
};
FS_fnc_TrackLabel = {
	// Exit if player uses wall hack perk
	if (missionNameSpace getVariable ["PERK_WH", FALSE]) exitWith {};
	
	private ["_leader", "_grp", "_marker"];
	_leader = _this select 0;
	_grp = group _leader;
	_marker = createMarkerLocal [str(random(100000000)), getPos _leader];
	
	if (count _this > 1) then { _marker setMarkerTypeLocal (_this select 1) } else { _marker setMarkerTypeLocal "o_inf" };
	
	switch (side _leader) do
	{
		case EAST: { _marker setMarkerColorLocal "ColorEAST"; };
		case WEST: { _marker setMarkerColorLocal "ColorWEST"; };
		default { _marker setMarkerColorLocal "ColorGUER"; };
	};
	
	while {{alive _x} count units _grp > 0} do
	{
		while {alive _leader} do
		{
			_marker setMarkerPosLocal getPos _leader;
			sleep 0.1;
		};
		sleep 2.5;
		if ({alive _x} count units _grp > 0) then 
		{
			_leader = leader _grp;
		};
	};
	deleteMarkerLocal _marker;
};
FS_fnc_SpawnSpecialWave = {
	if (!isServer) exitWith {};
	_squadSize = _this select 0;
	_squadCount = _this select 1;
	_specialType = _this select 2;
	_VRClass = "O_Protagonist_VR_F";
	_skill = SERVER getVariable ["SEL_AISKILL", 0.5];
	_pool = ["O_recon_F"];

	for [{_i=0},{_i < _squadCount},{_i=_i+1}] do
	{
		_NewGrp = createGroup EAST;
		_pos = [getMarkerPos "Respawn_WEST", 200, [0, 360]] call SHK_pos;
		for [{_j=0},{_j < _squadSize},{_j=_j+1}] do
		{
			_VRClass createUnit [_pos, _NewGrp, "", _skill, "PRIVATE"];
			_unit = units _NewGrp select _j;
			
			_class = _pool select (round(random(count _pool - 1)));
			[_unit, "O_recon_F", []] spawn BIS_fnc_loadInventory; 
			_unit execVM "scripts\elite.sqf"; 
			
			_unit setVariable ["FS_Class", _class, TRUE];
			_unit addEventHandler ["Killed", { _this call FS_KilledEH; }];
			
		};
		
		_NewWP = _NewGrp addWaypoint [getMarkerPos "Respawn_WEST", 5];
		_NewWP setWaypointType "SAD";
		_NewWP setWaypointSpeed "FULL";	
		_NewGrp allowFleeing 0;
	};
};
FS_fnc_SpawnWave = {
	private ["_amount", "_timer", "_faction", "_pool_NATO", "_pool_AAF", "_pool_CSAT", "_side", "_current_pool", "_i", "_j", "_NewWP", "_NewGrp", "_VRClass", "_pos", "_rndmClass", "_unit", "_skill"];

	_amount = if (count _this > 0) then {_this select 0} else {1};
	_timer = if (count _this > 1) then {_this select 1} else {0};
	_faction = if (count _this > 2) then {_this select 2} else {"AAF"};

	_pool_NATO = ["B_Soldier_SL_F", "B_Soldier_TL_F", "B_soldier_AR_F", "B_soldier_LAT_F", "B_Soldier_A_F", "B_soldier_AAR_F", "B_medic_F"];
	_pool_AAF = ["I_medic_F", "I_Soldier_AAR_F", "I_Soldier_AR_F", "I_Soldier_SL_F", "I_Soldier_TL_F", "I_Soldier_LAT_F", "I_Soldier_A_F"];
	_pool_CSAT = ["O_medic_F", "O_Soldier_AAR_F", "O_Soldier_AR_F", "O_Soldier_SL_F", "O_Soldier_TL_F", "O_Soldier_LAT_F", "O_Soldier_F"];

	_side = 0;
	_current_pool = [];
	_VRClass = "";
	
	switch (_faction) do {
		case "NATO": { _current_pool = _pool_NATO; _side = WEST; _VRClass = "B_Soldier_VR_F";};
		case "CSAT": { _current_pool = _pool_CSAT; _side = EAST; _VRClass = "O_Soldier_VR_F";};
		default { _current_pool = _pool_AAF; _side = INDEPENDENT; _VRClass = "I_Soldier_VR_F";};
	};
	
	for [{_i=_timer},{_i >= 0},{_i=_i-1}] do 
	{
		[format ["%1 %2", localize "STR_FS_NEWVAWEIN" + " " + str _i], "FS_CountDownMsg"] spawn BIS_fnc_MP;
		sleep 1;
	};
	[format ["%1", localize "STR_FS_WAVESTARTED"], "FS_CountDownMsg"] spawn BIS_fnc_MP;
	
	for [{_i=0},{_i < _amount},{_i=_i+1}] do 
	{
		// To prevent EPIC FPS DROP; waiting before spawning next portion of soldiers
		if ([EAST] call FS_GetUnitsCount >= (SERVER getVariable ["SEL_AILIMIT", 40])) then 
		{
			WaitUntil {[EAST] call FS_GetUnitsCount <= ((SERVER getVariable ["SEL_AILIMIT", 40]) - 10)};
			call FS_Janitor;
		};
		
		_pos = [getMarkerPos "Respawn_WEST", 200, [0, 360]] call SHK_pos;
		_NewGrp = createGroup _side;
		_skill = SERVER getVariable ["SEL_AISKILL", 0.5];
		
		for [{_j=0},{_j < 8},{_j=_j+1}] do
		{
			_VRClass createUnit [_pos, _NewGrp, "", _skill, "PRIVATE"];
		};
		for [{_j=0},{_j < count units _NewGrp},{_j=_j+1}] do
		{
			_rndmClass = _current_pool select (round(random(count _current_pool - 1)));
			_unit = units _NewGrp select _j;
			_unit setVariable ["FS_Class", _rndmClass, TRUE];
			_unit addEventHandler ["Killed", { _this call FS_KilledEH; }];
			[_unit, _rndmClass, ["uniform"]] spawn BIS_fnc_loadInventory;
		};
		
		_NewWP = _NewGrp addWaypoint [getMarkerPos "Respawn_WEST", 5];
		_NewWP setWaypointType "SAD";
		_NewWP setWaypointSpeed "FULL";	
		_NewGrp allowFleeing 0;
		
		[[_NewGrp, 'o_inf'], "FS_fnc_GroupMarkers"] call BIS_fnc_MP;
		[[leader _NewGrp], "FS_fnc_TrackLabel"] call BIS_fnc_MP;
	};
};
FS_KilledEH = {
	_victim = _this select 0;
	_killer = _this select 1;
	
	if (isNull _killer) exitWith {};
	
	_kills = _killer getVariable ["FS_KillCounter", 0];
	
	_PlayerKilledinTotal = SERVER getVariable ["FS_InfKilledByPlayers", 0];
	SERVER setVariable ["FS_InfKilledByPlayers", _PlayerKilledinTotal + 1, TRUE];
	
	//////////////////////////////////////////////////
	// Kills while player is LEFT GUNNER in heli 	//
	//////////////////////////////////////////////////
	
		if (typeOf vehicle _killer == 'B_Heli_Transport_01_camo_F') then 
		{
			// The REAL killer is Player-Gunner, not Effective-Commander-Bot
			_killer = (crew vehicle _killer) select 1; 
			
			if (!isNull _killer) then 
			{
				_kills = _killer getVariable ["FS_KillCounter", 0];
				_killer setVariable ['FS_KillCounter', _kills + 1, TRUE]; 
			};
		};
		
	//////////////////////////////////////////////////
	// CAS Kills 								 	//
	//////////////////////////////////////////////////
	
		if (typeOf vehicle _killer == 'B_Plane_CAS_01_F') then 
		{
			// The REAL killer is Player who called CAS
			_id = vehicle _killer getVariable "FS_CASowner"; 
			_killer = _id call FS_FindPlayerByID;
			
			if (!isNull _killer) then 
			{
				_kills = _killer getVariable ["FS_KillCounter", 0];
				_killer setVariable ['FS_KillCounter', _kills + 1, TRUE]; 
			};
		};
	
	//////////////////////////////////////////////////
	// Kills while player Gunner in xMG 			//
	//////////////////////////////////////////////////
	
		if (typeOf vehicle _killer == 'B_HMG_01_high_F' || typeOf vehicle _killer == 'B_GMG_01_high_F') then 
		{
			_killer = (crew vehicle _killer) select 0;
			
			if (!isNull _killer) then 
			{
				_kills = _killer getVariable ["FS_KillCounter", 0];
				_killer setVariable ['FS_KillCounter', _kills + 1, TRUE]; 
			};
		};
		
	//////////////////////////////////////////////////
	// Kills while player on foots 					//
	//////////////////////////////////////////////////
		
		if (vehicle _killer == _killer) then 
		{
			_killer setVariable ['FS_KillCounter', _kills + 1, TRUE]; 
		};
		
	//////////////////////////////////////////////////
	// Increasing Total Player's Kills Number		//
	//////////////////////////////////////////////////
		
		[[_killer, _victim], "FS_IncPlayerKillsCounter"] call BIS_fnc_MP;

};
FS_IncPlayerKillsCounter = {
	private ["_this", "_player", "_victim", "_typeVictim", "_i", "_j", "_RoundKills"];
	_player = _this select 0;
	_victim = _this select 1;
	_typeVictim = _victim getVariable ["FS_Class", typeOf _victim];
	
	if (player != _player) exitWith {};
	
	// Increase Kill Counter
	profileNameSpace setVariable 
	[
		"VRFORTRESS_InfKills", 
		(profileNameSpace getVariable ["VRFORTRESS_InfKills", 0]) + 1
	];	
	
	// Store Killed Unit into Global Kills history
	_killsArray = profileNameSpace getVariable ["VRFORTRESS_KillsArray", []];
	if ( {(_x select 0) == _typeVictim} count _killsArray == 0) then 
	{
		_killsArray pushBack [_typeVictim, 1];
	}
	else
	{
		for "_i" from 0 to count _killsArray - 1 do
		{
			if ((_killsArray select _i) select 0 == _typeVictim) exitWith 
			{
				_j = (_killsArray select _i) select 1;
				(_killsArray select _i) set [1, _j + 1];
			};
		};
	};
	profileNameSpace setVariable ["VRFORTRESS_KillsArray", _killsArray];
	
	// Setting how much player killed in Current Game
	_RoundKills = player getVariable ["FS_RoundKills", 0];
	player setVariable ["FS_RoundKills", _RoundKills + 1];
};


FS_VehDestroyHandler = {
	private ["_car", "_group", "_this", "_x"];
	_car = _this select 0;
	_group = _this select 1;
	
	while {canMove _car && alive _car} do 
	{
		{
		_unit = _x;
			{
				_x reveal [_unit, 4];
			} forEach units _group;
		} forEach units group player;
		sleep 2;
	};
	sleep 20;
	if (!canMove _car) then {_car setDamage 1};
	sleep 15;
	{deleteVehicle _x} forEach units _group;
	deleteVehicle _car;
	deleteGroup _group;
};

FS_spawn_vehicle = {
	private ["_NewGrp", "_vehs", "_type", "_cargo", "_chute", "_x", "_lastWave", "_curWave"];
	_NewGrp = createGroup EAST;
	_curWave = _this select 0;
	_lastWave = _this select 1;
	_vehs = ["O_MRAP_02_hmg_F", "O_MRAP_02_hmg_F", "O_APC_Tracked_02_cannon_F", "O_MBT_02_cannon_F"];
	
	// Levelling
	if (_curWave == 1) exitWith {};
	if (_curWave / _lastWave > 0) then { _vehs = ["O_MRAP_02_hmg_F", "O_MRAP_02_hmg_F"]; };
	if (_curWave / _lastWave >= 0.5) then { _vehs = ["O_APC_Tracked_02_cannon_F"]; };
	if (_curWave / _lastWave >= 0.8) then { _vehs = ["O_MBT_02_cannon_F"]; };
	
	// Random choosing
	_type = _vehs select floor random count _vehs;
	_cargo = _type createVehicle ([getMarkerPos "Respawn_WEST", 40, [0,360]] call shk_pos);
	[_cargo, _NewGrp, false, "", "O_crew_F"] spawn BIS_fnc_spawnCrew;
	[_cargo, 60] call bis_fnc_setHeight;
	
	_chute = createVehicle ["B_Parachute_02_F", position _cargo, [], 0, "CAN_COLLIDE"];
	_chute setDir ([_chute, getMarkerPos "Respawn_WEST"] call BIS_fnc_relativeDirTo);
	_chute setVelocity [0,0,-10];
	_chute setPos getPos _cargo;
	_cargo attachTo [_chute, [0,0,0]];
	
	// Unfortunately, BIS_fnc_loadInventory does NOT work with bots inside vehicles :(
	//{ [_x, "O_crew_F", ["uniform"]] spawn BIS_fnc_loadInventory; } forEach units _NewGrp;
	
	while {(getPosATL _cargo) select 2 > 2} do { sleep 0.2; };
	detach _cargo;
	_cargo setPosASL getPosASL _cargo;
	
	[_cargo, _NewGrp] spawn FS_VehDestroyHandler;
	_cargo addEventHandler ["Killed", { _this call FS_KilledEH; }];
};

FS_fnc_SpawnBoss = {
	private ["_pilotClass", "_heliClass", "_VRClass", "_side", "_faction", "_pos", "_NewGrp", "_newHeli", "_NewWP", "_unit"];
	_pilotClass = "";
	_heliClass = "";
	_VRClass = "";
	_side = EAST;
	_faction = if (count _this > 0) then {_this select 0} else {"AAF"};
	
	switch (_faction) do {
		case "NATO": { _side = WEST; _VRClass = "B_Soldier_VR_F"; _pilotClass = "B_helipilot_F"; _heliClass = "B_Heli_Attack_01_F";};
		case "CSAT": { _side = EAST; _VRClass = "O_Soldier_VR_F"; _pilotClass = "O_helipilot_F"; _heliClass = "O_Heli_Attack_02_black_F"; };
		default { _side = GUER; _VRClass = "I_Soldier_VR_F"; _pilotClass = "I_helipilot_F"; _heliClass = "I_Heli_light_03_F";};
	};
	
	_pos = [getMarkerPos "Respawn_WEST", 200, [0, 360]] call SHK_pos;
	_NewGrp = createGroup _side;
	for [{_j=0},{_j < 2},{_j=_j+1}] do
	{
		_VRClass createUnit [_pos, _NewGrp, "", 0.5, "PRIVATE"];
	};
	for [{_j=0},{_j < count units _NewGrp},{_j=_j+1}] do
	{
		_unit = units _NewGrp select _j;
		[_unit, _pilotClass, ["uniform"]] spawn BIS_fnc_loadInventory;
	};
	_newHeli = _heliClass createVehicle _pos;
	units _NewGrp select 0 moveInDriver _newHeli; 
	units _NewGrp select 1 moveInGunner _newHeli; 
	units _NewGrp select 2 moveInCommander _newHeli; 

	_NewWP = _NewGrp addWaypoint [getMarkerPos "Respawn_WEST", 5];
	_NewWP setWaypointType "SAD";
	_NewWP setWaypointSpeed "FULL";	
	_NewGrp allowFleeing 0;
	
	_NewGrp spawn {
		while {{alive _x} count _NewGrp > 0} do {
			{ _this reveal [_x, 4] } forEach units group player;
			sleep 5;
		};
	};
	
	[[leader _NewGrp, "b_air"], "FS_fnc_TrackLabel"] call BIS_fnc_MP;
	[_newHeli, _NewGrp] spawn FS_VehDestroyHandler;
};
FS_hideObjectGlobal = {
	if (!isServer) exitWith {};
	(_this select 0) hideObjectGlobal (_this select 1);
	(_this select 0) enableSimulationGlobal !(_this select 1);
};
FS_ShowMsg_LastStand = {
	if ((isNil {player getVariable "FS_isHided"}) && (alive player)) then {
		[['RespawnAdded', [localize 'STR_FS_LASTSTAND_01', localize 'STR_FS_LASTSTAND_02','\A3\ui_f\data\gui\cfg\Debriefing\endDefault_ca.paa']], 'BIS_fnc_showNotification'] call BIS_fnc_MP;
		playSound "mp_laststand";
	};
};
FS_PlayMusicGlobal = {
	3 fadeMusic 0;
	sleep 3;
	playMusic _this;
	3 fadeMusic 1;
};
FS_PlaySoundGlobal = {
	playSound _this;
};

FS_FillMineField = {
	if (!isServer) exitWith {};
	private ["_this", "_dir", "_count", "_type", "_i", "_distance", "_pos", "_x", "_mine", "_Try", "_TryLimit"];

	_dir = markerDir _this;
	_count = 35;
	_type = "APERSBoundingMine_Range_Ammo"; // ["APERSTripMine_Wire_Ammo", "APERSBoundingMine_Range_Mag", "APERSMine_Range_Mag", "ClaymoreDirectionalMine_Remote_Mag"]
	_TryLimit = 100; // How many attempts to find a good place
	if (isNil {SYSTEM_MINES}) then { SYSTEM_MINES = []; };
	for "_i" from 1 to _count do
	{
		_Try = 0;
		_pos = [0,0,0];
		_distance = 0;
		while {_distance < 5} do 
		{
			_Try = _Try + 1;
			if (_Try >= _TryLimit) exitWith { _i = _count; /* Too Many Mines */ };
			
			_distance = 100;
			_pos = [_this] call SHK_Pos;
			{
				if (_pos distance _x < _distance) then { _distance = _pos distance _x; };
			}
			forEach AllMines;
		};
		if (_Try < _TryLimit) then 
		{
			_mine = _type createVehicle _pos;
			_mine setDir _dir;
			_mine allowDamage false;
			SYSTEM_MINES = SYSTEM_MINES + [_mine];
			[_mine, "FS_RevealMine"] call BIS_fnc_MP;
		};
	};
	SERVER setVariable ["SYSTEM_MINES", SYSTEM_MINES, TRUE];
};
FS_RevealMine = {
	WEST revealMine _this;
};
FS_GlobalSwitchMove = { (_this select 0) switchMove (_this select 1); };
FS_GlobalWeather = {
	// [time in seconds to change, overcast, rain]
	(_this select 0) setOvercast (_this select 1);
	(_this select 0) setRain (_this select 2); 
};

FS_compileAndRun = {
	call compile _this;
};

////////////////////////////////////////////////
//	KEYLOGGER :P
////////////////////////////////////////////////

PRESSED_SHIFT = FALSE;
PRESSED_CTRL = FALSE; 
PRESSED_ALT = FALSE; 
PRESSED_Q = FALSE;
PRESSED_E = FALSE;
PRESSED_TAB = FALSE;
PRESSED_RALT = FALSE;

KeyEvents = {
	private ["_type", "_this", "_param", "_key"];
	_type = _this select 0;
	_param = _this select 1;

	_key = _param select 1;
	PRESSED_SHIFT = _param select 2;
	PRESSED_CTRL = _param select 3; 
	PRESSED_ALT = _param select 4; 
	
	//hint str(_key);
	
	switch (_type) do 
	{
		case "KeyDown": 
		{
			switch (_key) do 
			{
				case 16: { PRESSED_Q = TRUE; };
				case 18: { PRESSED_E = TRUE; };
				case 15: { PRESSED_TAB = TRUE; };
				case 184: { PRESSED_RALT = TRUE; };
			};
		};
		case "KeyUp": 
		{
			switch (_key) do 
			{
				case 16: { PRESSED_Q = FALSE; };
				case 18: { PRESSED_E = FALSE; };
				case 15: { PRESSED_TAB = FALSE; };
				case 184: { PRESSED_RALT = FALSE; };
				
				case 42: { PRESSED_SHIFT = FALSE; };
				case 29: { PRESSED_CTRL = FALSE; };
				case 56: { PRESSED_ALT = FALSE; };
			};
		};
	};
	false
};

[] spawn {
	waitUntil {!isNull (findDisplay 46)};
	disableSerialization; 
	_display = findDisplay 46;
	_display displayAddEventHandler ["KeyDown", {["KeyDown",_this] call KeyEvents}];
	_display displayAddEventHandler ["KeyUp", {["KeyUp",_this] call KeyEvents}];
	// Open Builder on RALT
	_display displayAddEventHandler ["KeyDown", {if (!isNil {PARAMETERS_SET} && !Dialog && _this select 1 == 184) then {createDialog "BuildMenu"}; }]; 
};

////////////////////////////////////////////////
//	REDEFINING BIS FUNCTIONS INTO MY OWN
////////////////////////////////////////////////

VRF_fnc_CAS = compile preprocessfilelinenumbers "scripts\VRF_fnc_CAS.sqf";
VRF_fnc_CamShake = compile preprocessfilelinenumbers "scripts\VRF_fnc_CamShake.sqf";
VRF_fnc_SetUnlimAmmo = compile preprocessfilelinenumbers "scripts\VRF_fnc_SetUnlimAmmo.sqf";

////////////////////////////////////////////////
//	PERKS & KillStreaks
////////////////////////////////////////////////

// Do not touch those three
PERK_ASSIGNED = FALSE;
PERK_TICKETS_PP = 0;
PERK_ZEUSPETBONUS = 0;

KS_Cost_Zeus = 40;
KS_Cost_Heli = 25;
KS_Cost_Ammo = 15;
KS_Cost_Armor = 10;

// How many AI teammates player can recruit
BARRACKS_MP_LIM = 2;
BARRACKS_SP_LIM = 6;

// time in seconds before displaying how to start the game
REMIND_TIME = 150;

///////////////////////////////////////////////////
//	Variables you can change freely
///////////////////////////////////////////////////

CONST_RESPAWN_GODMODETIME = 15;
CONST_ADDTICKETS_COUNT = 3; // if it is not 3, you should change it in stringtable.csv too
CONST_PAYBACK_MULT = 2; 	// same here
CONST_CAS_RELOAD_TIME = 250;
CONST_ARTY_RELOAD_TIME = 350;

////////////////////////////////////////////////
//	SYSTEM (do not touch anything here)
////////////////////////////////////////////////

SIM_START = FALSE;
HELI_ON_SITE = FALSE;
ZEUS_ON_SITE = FALSE;
BARRACKS_UNITSLIM = if (isMultiplayer) then {BARRACKS_MP_LIM} else {BARRACKS_SP_LIM};

if (isServer) then { 

	laptop attachTo [stol, [0,0.4,0.57]]; 
	satTel attachTo [stol ,[0,-0.4,0.6]];
};

as = [] execVM "scripts\defence.sqf";
as = [] execVM "scripts\3Dmarkers.sqf";

player setVariable ["FS_KillCounter", 0];

if (isServer) then
{
	call compile preprocessfilelinenumbers "SHK_Pos\shk_pos_init.sqf";
	0 = ["area", 17, 0] execVM "scripts\Zen_GenerateVRArea.sqf"; 
	0 = ["area_1", 17, 0] execVM "scripts\Zen_GenerateVRArea.sqf"; 
	0 = ["area_2", 17, 0] execVM "scripts\Zen_GenerateVRArea.sqf"; 
	0 = ["area_3", 17, 0] execVM "scripts\Zen_GenerateVRArea.sqf"; 
	{
		if (!isPlayer _x) then {deleteVehicle _x};
	}
	forEach units group player;		
	
	{ _x setMarkerAlpha 0} forEach ["MINES_N", "MINES_E", "MINES_S", "MINES_W"];
};

waitUntil {time > 1};

["RespawnAdded", [localize "STR_FS_SYSTEM_MSG_01", localize "STR_FS_SYSTEM_MSG_02","\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa"]] call BIS_fnc_showNotification;

//playMusic "LeadTrack01_F_Bootcamp";
playMusic "intro";

if (isServer) then {
	while {isNil {PARAMETERS_SET}} do 
	{
		createDialog "ParametersMenu"; 
		waitUntil {!Dialog};
		sleep 1;
	};
};

// Virtual Arsenal Guard
[] spawn {
	while {true} do {
		waitUntil {sleep 0.5; !(isnull (uinamespace getvariable ["BIS_fnc_arsenal_cam",objnull]))};
		player allowDamage false;
		waitUntil {sleep 0.5; isnull (uinamespace getvariable ["BIS_fnc_arsenal_cam",objnull])};
		[player, [missionNameSpace, "FS_PLAYER_LOADOUT"]] call BIS_fnc_saveInventory;
		if (SIM_START) then { player allowDamage true; };
	};
};

player allowDamage FALSE;
waitUntil {SIM_START};
player allowDamage TRUE;

//playMusic "LeadTrack01_F_EPA";
	
	// SpawnManager === === === ===
	if (isServer) then 
	{
		phrasesEnd = [
			"mp_counterAttackEnd01", 
			"mp_counterAttackEnd02", 
			"mp_counterAttackEnd03", 
			"mp_counterAttackEnd04", 
			"mp_counterAttackEnd05"
		];			
		phrasesStart = [
			"mp_counterAttack01", 
			"mp_counterAttack02", 
			"mp_counterAttack03", 
			"mp_counterAttack04"
		];
		startingWave = (SERVER getVariable "startingWave") - 1;
		wavesCount = SERVER getVariable "wavesCount";
		wavesDelay = SERVER getVariable "wavesDelay";
		
		_k = 0;
		while {_k < wavesCount} do
		{
			sleep 5;
			if (([EAST] call FS_GetUnitsCount == 0) || (_k == 0)) then
			{
				sleep 2;
				call FS_Janitor;
				
				if (_k > 0) then 
				{
					_sentence = phrasesEnd select floor random count phrasesStart;
					[_sentence, "FS_PlaySoundGlobal"] call BIS_fnc_MP;
				};
				
				_k = _k + 1;
				[startingWave + _k, wavesDelay, "CSAT"] spawn FS_fnc_SpawnWave;
				["delay_theme", "FS_PlayMusicGlobal"] call BIS_fnc_MP;
				
				sleep (wavesDelay);
				
				// Recon strike
				//[0, 0, ""] spawn FS_fnc_SpawnSpecialWave;
				
				// AI Artillery
				if (SERVER getVariable "ChckbxAIArt") then {
					[getMarkerPos "Respawn_WEST", 5 + _k] spawn FESS_fnc_Bomber;
					sleep 22;
				};
				
				if ((_k == wavesCount) && (SERVER getVariable "ChckbxEnBoss")) then 
				{
					["boss_theme", "FS_PlayMusicGlobal"] call BIS_fnc_MP;
				} 
				else 
				{
					["LeadTrack01a_F_EPB", "FS_PlayMusicGlobal"] call BIS_fnc_MP;
				};
				
				_sentence = phrasesStart select floor random count phrasesStart;
				[_sentence, "FS_PlaySoundGlobal"] call BIS_fnc_MP;
				
				if (SERVER getVariable "ChckbxAIVeh") then 
				{
					[startingWave + _k, startingWave + wavesCount] spawn FS_spawn_vehicle; 
				};
				sleep 5;
			};
			if ((_k == wavesCount) && (SERVER getVariable "ChckbxEnBoss")) then 
			{
				[getMarkerPos "Respawn_WEST", 15 + _k] spawn FESS_fnc_Bomber;
				["CSAT"] call FS_fnc_SpawnBoss;
				sleep 5;
			};
		};
		
		waitUntil {[EAST] call FS_GetUnitsCount == 0};
		MISSION_COMPLETED = TRUE;
		publicVariable "MISSION_COMPLETED";
		
		_sentence = phrasesEnd select floor random count phrasesStart;
		[_sentence, "FS_PlaySoundGlobal"] call BIS_fnc_MP;
	};
	// SpawnManager === === === ===

waitUntil { missionNameSpace getVariable ["MISSION_COMPLETED", false] };

playMusic "victory_theme";

_ppCCBase = [0.199, 0.587, 0.114, 0.0];
//_ppCCIn = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1.0, 1.0, 1.0, 1.0], _ppCCBase];
_ppCCIn = [1, 1, 0, [0.0, 0.0, 0.0, 0.5], [0.8, 0.8, 8.0, 0.4], _ppCCBase];
			
"colorCorrections" ppEffectAdjust _ppCCIn;
"colorCorrections" ppEffectCommit 2;
"colorCorrections" ppEffectEnable true;

sleep 3;

createDialog "ProgressionMenu";
/*
disableSerialization;
_layer = "FS_MissionCompletedScreen" call BIS_fnc_rscLayer;
_layer cutRsc ["RscDynamicText", "PLAIN"];
_ctrl = (uiNamespace getVariable "BIS_dynamicText") displayCtrl 9999;
_ctrl ctrlSetPosition
[
	0.3 * safezoneW + safezoneX,
	0.2 * safezoneH + safezoneY,
	0.4 * safezoneW,
	0.2 * safezoneH
];
_ctrl ctrlCommit 0;
_text = format
[
	"<t align = 'center' shadow = '0' size = '0.7'>Enemies killed: %1<br/>Enemies killed by YOU: %2<br/>Enemies killed total: %3</t>",
	SERVER getVariable ['FS_InfKilledByPlayers', 0],
	player getVariable ['FS_RoundKills', 0],
	profileNameSpace getVariable ['VRFORTRESS_InfKills', 0]
];
_ctrl ctrlSetStructuredText parseText _text;
//_ctrl ctrlSetFade 1;
//_ctrl ctrlCommit 2;
*/
sleep 15;
["end1", true] call BIS_fnc_endMission;
markAsFinishedOnSteam;


