
// Teammates map markers
as = player execVM "scripts\teammates_mapMarkers.sqf";

// Returning of loadout
[player, [missionNameSpace, "FS_PLAYER_LOADOUT"], []] call BIS_fnc_loadInventory;

if (isNil {FIRST_SPAWN}) exitWith { FIRST_SPAWN = TRUE; };

cutText ["", "BLACK IN", 5];
playSound "Simulation_Restart";

setPlayerRespawnTime 10;

_newBody = _this select 0; // NOT the same as 'player'
_oldBody = _this select 1;
removeAllActions _oldBody;

player setVariable ["FS_KillCounter", 0, TRUE];

// If _x < 0 then player already used his killstreak

if (_newBody getVariable "FS_KSZeus_Action" < 0) then {player setVariable ["FS_KSZeus_Action", nil];};
if (_newBody getVariable "FS_KSHeli_Action" < 0) then {player setVariable ["FS_KSHeli_Action", nil];};
if (_newBody getVariable "FS_KSUnlimAmmo_Action" < 0) then {player setVariable ["FS_KSUnlimAmmo_Action", nil];};
if (_newBody getVariable "FS_KSGodmode_Action" < 0) then {player setVariable ["FS_KSGodmode_Action", nil];};

// Returning Zeus
if (!isNil {player getVariable "FS_KSZeus_Action"}) then {
	[] spawn FS_AddAction_Zeus;
};
// Returning helicopter
if (!isNil {player getVariable "FS_KSHeli_Action"}) then {
	[] spawn FS_AddAction_Heli;
};
// Returning unlimited ammo
if (!isNil {player getVariable "FS_KSUnlimAmmo_Action"}) then {
	[] spawn FS_AddAction_Ammo;
};
// Returning Godmode
if (!isNil {player getVariable "FS_KSGodmode_Action"}) then {
	[] spawn FS_AddAction_Armor;
};
	
// Respawn manager === === === === === === === ===
// setplayerrespawntime 1e10 to disable;

ticketsCount = SERVER getVariable ["ticketsCount", 0];

if (ticketsCount > 0) then 
{
	ticketsCount = ticketsCount - 1;
	SERVER setVariable ["ticketsCount", ticketsCount, true];
	
	["hint format ['\n%1 %2 %3\n\n', localize 'STR_FS_TicketsMSG1', ticketsCount, localize 'STR_FS_TicketsMSG2']", "FS_compileAndRun"] call BIS_fnc_MP;
}
else 
{
	player setVariable ["FS_isHided", TRUE, true];
	_GrpPlayer = group player;
	[player] join GrpNull;
	player setCaptive true;
	
	if ({isPlayer _x} count units _GrpPlayer == 1) then 
	{
		[[], "FS_ShowMsg_LastStand"] call BIS_fnc_MP;
	};
	player switchMove "";
	[[player, true], "FS_hideObjectGlobal"] call BIS_fnc_MP;
	player allowDamage false;
	removeAllWeapons player;
	removeAllItems player;
	_pos = getMarkerPos "Respawn_WEST";
	player setPosATL [_pos select 0, _pos select 1,-5];
	
	playSound "Simulation_Fatal";
	[] execVM "spectator\specta.sqf";
	
	while {SIM_START} do 
	{
		if ({alive _x && isPlayer _x} count units _GrpPlayer == 0) then 
		{
			if (SIM_START) then 
			{
				[["end1", false], "BIS_fnc_EndMission"] call BIS_fnc_MP; 
				SIM_START = false;
				publicVariable "SIM_START";
			};
		};
		sleep 1;
	};
};
