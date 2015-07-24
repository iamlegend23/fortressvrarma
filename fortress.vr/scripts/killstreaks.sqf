
FS_KillStreak_Heli = {
	private ["_isLocal", "_NewGrp", "_pilot", "_pos", "_heli"];
	_isLocal = (player == _this);
	if (!_isLocal) exitWith {};
	
	HELI_ON_SITE = TRUE;
	publicVariable "HELI_ON_SITE";
	
	_heli = "B_Heli_Transport_01_camo_F" createVehicle [3778,3918.86,0];
	_heli setDir 54.585;
	_heli setPos [3778,3918.86,0];
	_NewGrp = createGroup WEST;
	"B_Soldier_VR_F" createUnit [getPos _heli, _NewGrp, "", 0.5, "PRIVATE"];
	_pilot = units _NewGrp select 0;
	[_pilot, "B_helipilot_F", ["uniform"]] spawn BIS_fnc_loadInventory;
	_pilot moveInDriver _heli;
	_heli engineON true;
	_heli spawn Heli_Script;
	sleep 20;
	5 fadeMusic 0;
	sleep 5;
	0 fadeMusic 1;
	playMusic "LeadTrack02_F_EPC";
	sleep 5;
	if (!alive _this) then 
	{
		HELI_ON_SITE = FALSE;
		publicVariable "HELI_ON_SITE";
		
		_heli setDamage 1;
		sleep 20;
		deleteVehicle _pilot;
		deleteGroup _NewGrp;
		deleteVehicle _heli;
		
	}
	else 
	{
		_kills = _this getVariable "FS_KillCounter";
		_pos = getPosATL _this;
		_this allowDamage false;
		_this moveInGunner _heli;
		_heli addEventHandler ["Fired", {(_this select 0) setAmmo ["LMG_Minigun_Transport", 2000]}];
		
		for "_i" from 0 to 95 do 
		{
			sleep 1;
			if ((!alive _heli) || (_i == 95)) exitWith 
			{
				_kills = (_this getVariable "FS_KillCounter") - _kills;
				["ScoreAdded", [localize "STR_FS_EnemiesKilled", _kills]] call BIS_fnc_showNotification;
				
				_this allowDamage true;
				_this setPosATL _pos;
				
				HELI_ON_SITE = FALSE;
				publicVariable "HELI_ON_SITE";
				
				_heli setDamage 1;
				sleep 20;
				deleteVehicle _pilot;
				deleteGroup _NewGrp;
				deleteVehicle _heli; 
			};
		};
	};
};

FS_KillStreak_UnlimAmmo = {
	private ["_isLocal", "_eh", "_i", "_this"];
	_isLocal = (_this == player);
	if (!_isLocal) exitWith {};
	
	_eh = _this addEventHandler ["Fired", {player setAmmo [currentweapon player, 100000]}];
	["Countdown", [format ["100 %1", localize "STR_FS_UnlimitedAmmo"]]] call BIS_fnc_showNotification;
	
	for "_i" from 0 to 100 do
	{
		if (100 - _i == 60) then {["Countdown", [format ["60 %1", localize "STR_FS_UnlimitedAmmo"]]] call BIS_fnc_showNotification;};
		if (100 - _i == 10) then {["Countdown", [format ["10 %1", localize "STR_FS_UnlimitedAmmo"]]] call BIS_fnc_showNotification;};
		if (100 - _i == 0) then {["Countdown", [format ["0 %1", localize "STR_FS_UnlimitedAmmo"]]] call BIS_fnc_showNotification;};
		if (!alive _this) exitWith { _this removeEventHandler ["Fired", _eh]; };
		sleep 1;
	};
	_this removeEventHandler ["Fired", _eh];
};

FS_KillStreak_GodMode = {
	private ["_isLocal", "_this", "_i"];
	_isLocal = (_this == player);
	if (!_isLocal) exitWith {};
	_this allowDamage false;
	["Countdown", [format ["40 %1", localize "STR_FS_EnhancedArmor"]]] call BIS_fnc_showNotification;
	for "_i" from 0 to 40 do
	{
		if (40 - _i == 20) then {["Countdown", [format ["20 %1", localize "STR_FS_EnhancedArmor"]]] call BIS_fnc_showNotification;};
		if (40 - _i == 5) then {["Countdown", [format ["5 %1", localize "STR_FS_EnhancedArmor"]]] call BIS_fnc_showNotification;};
		if (!alive _this) exitWith { _this allowDamage true; };
		sleep 1;
	};
	_this allowDamage true;
};

FS_KillStreak_Earthquake = {
	private ["_isLocal", "_center", "_group", "_logic", "_kills", "_maxkills", "_this"];
	_isLocal = (_this == player);
	
	ZEUS_ON_SITE = TRUE; // We do not need to public this because this code runs on client too
	
	if (PERK_TICKETS_PP > 0) then 
	{
		ticketsCount = ticketsCount + PERK_TICKETS_PP;
		publicVariable "ticketsCount";
		["['ScoreAdded', [localize 'STR_FS_TicketsAdded', CONST_ADDTICKETS_COUNT]] spawn BIS_fnc_showNotification", "FS_compileAndRun"] call BIS_fnc_MP;
	};
	
	// Color
	_ppCCBase = [0.199, 0.587, 0.114, 0.0];
	_ppCCIn = [1, 1, 0, [0.0, 0.0, 0.0, 0.4], [1.0, 1.0, 1.0, 1.0], _ppCCBase];
	_ppCCOut = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1.0, 1.0, 1.0, 1.0], _ppCCBase];
	"colorCorrections" ppEffectAdjust _ppCCIn;
	"colorCorrections" ppEffectCommit 2;
	"colorCorrections" ppEffectEnable true;
	
	2 fadeMusic 0;
	sleep 2;
	0 fadeMusic 1;
	playMusic "zeus_theme";
	[4] spawn BIS_fnc_earthquake;
	sleep 5;
	"colorCorrections" ppEffectAdjust _ppCCOut;
	"colorCorrections" ppEffectCommit 60;

	if (!_isLocal) exitWith {};
	// [time in seconds to change, overcast, rain]
	[[15, 0.75, 1], "FS_GlobalWeather"] call BIS_fnc_MP;
	sleep 10;
	
	_center = createCenter sideLogic;
	_group = createGroup _center;
	_logic = _group createUnit ["LOGIC", [0,0,0], [], 0, "NONE"];
	_kills = 0;
	_maxkills = 10 + round(random 20) + PERK_ZEUSPETBONUS;
	{
		if ((side _x == EAST) && (alive _x) && (_kills < _maxkills)) then 
		{
			_logic setPos getPos _x;
			[[0.005,0.3 + random 1,[_logic,200]],"VRF_fnc_CamShake"] call bis_fnc_mp;
			[_logic, [], true] call BIS_fnc_moduleLightning;
			sleep random(3);
			if (!alive _x) then { _kills = _kills + 1; };
			
			// Storing kill into global history
			[[player, _x], "FS_IncPlayerKillsCounter"] call BIS_fnc_MP;
		};
	}
	forEach AllUnits;
	// [time in seconds to change, overcast, rain]
	[[30, 0.75, 0], "FS_GlobalWeather"] call BIS_fnc_MP;
	sleep 4;
	["ScoreAdded", [localize "STR_FS_EnemiesKilled", _kills]] call BIS_fnc_showNotification;
	
	// Setting how much player killed in Current Game
	_RoundKills = player getVariable ["FS_RoundKills", 0];
	player setVariable ["FS_RoundKills", _RoundKills + _kills];
	
	deleteVehicle _logic;
	deleteGroup _group;
	deleteCenter _center;
	
	ZEUS_ON_SITE = FALSE;
	publicVariable "ZEUS_ON_SITE";
};


// ==================================================

if (isNil {player getVariable "FS_KillCounter"}) then 
{
	player setVariable ["FS_KillCounter", 0, true];
};

FS_AddAction_Zeus = {
	_callZeus = player addAction [localize "STR_FS_KS_ZEUS", 
	{
		[player, "FS_KillStreak_Earthquake"] call BIS_fnc_MP; 
		player removeAction (player getVariable 'FS_KSZeus_Action');
		player setVariable ['FS_KSZeus_Action', -1];
		["['RespawnAdded', [localize 'STR_FS_ZeusAwoken1',localize 'STR_FS_ZeusAwoken2','\a3\ui_f_curator\data\logos\arma3_curator_eye_64_ca.paa']] spawn BIS_fnc_showNotification", "FS_compileAndRun"] call BIS_fnc_MP;
	}, [], 0, false, true, "", "!ZEUS_ON_SITE"];
	player setVariable ["FS_KSZeus_Action", _callZeus];
};
FS_AddAction_Heli = {
	_callHeli = player addAction [localize "STR_FS_KS_HELI", 
	{
		player spawn FS_KillStreak_Heli; 
		player removeAction (player getVariable 'FS_KSHeli_Action');
		player setVariable ['FS_KSHeli_Action', -1];
		["['RespawnAdded', [localize 'STR_FS_HeliSupport1', localize 'STR_FS_HeliSupport3','\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa']] spawn BIS_fnc_showNotification", 'FS_compileAndRun'] call BIS_fnc_MP;
	}, [], 0, false, true, "", "!HELI_ON_SITE"];
	player setVariable ["FS_KSHeli_Action", _callHeli];
};
FS_AddAction_Ammo = {
	_callUnlimAmmo = player addAction [localize "STR_FS_KS_AMMO", 
	{
		player spawn FS_KillStreak_UnlimAmmo; 
		player removeAction (player getVariable 'FS_KSUnlimAmmo_Action');
		player setVariable ['FS_KSUnlimAmmo_Action', -1];
		["['RespawnAdded', [localize 'STR_FS_AmmoSupport1',localize 'STR_FS_AmmoSupport3','\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa']] spawn BIS_fnc_showNotification", 'FS_compileAndRun'] call BIS_fnc_MP;
	}];
	player setVariable ["FS_KSUnlimAmmo_Action", _callUnlimAmmo];
};
FS_AddAction_Armor = {
	_callGodmode = player addAction [localize "STR_FS_KS_ARMOR", 
	{
		player spawn FS_KillStreak_GodMode; 
		player removeAction (player getVariable 'FS_KSGodmode_Action');
		player setVariable ['FS_KSGodmode_Action', -1];
		["['RespawnAdded', [localize 'STR_FS_EnhArmor1',localize 'STR_FS_EnhArmor3','\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa']] spawn BIS_fnc_showNotification", "FS_compileAndRun"] call BIS_fnc_MP;
	}];
	player setVariable ["FS_KSGodmode_Action", _callGodmode];
};

while {true} do 
{
	while {alive player} do 
	{
		sleep 1;
		_counter = player getVariable "FS_KillCounter";
		
		// zeus
		if (_counter >= KS_Cost_Zeus) then 
		{
			if (isNil {player getVariable 'FS_KSZeus_Action'}) then 
			{
				["RespawnAdded", [localize 'STR_FS_ZeusAdded1', localize 'STR_FS_ZeusAdded2','\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa']] call BIS_fnc_showNotification;
				playSound "killstrk_zeus";
				[] spawn FS_AddAction_Zeus;
			};
		};
		
		// helicopter
		if (_counter >= KS_Cost_Heli) then 
		{
			if (isNil {player getVariable 'FS_KSHeli_Action'}) then 
			{
				["RespawnAdded", [localize "STR_FS_HeliSupport1",localize "STR_FS_HeliSupport2","\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa"]] call BIS_fnc_showNotification;
				playSound "killstrk_heli";
				[] spawn FS_AddAction_Heli;
			};
		};
		
		// unlimited ammo
		if (_counter >= KS_Cost_Ammo) then 
		{
			if (isNil {player getVariable 'FS_KSUnlimAmmo_Action'}) then 
			{
				["RespawnAdded", [localize "STR_FS_AmmoSupport1",localize "STR_FS_AmmoSupport2","\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa"]] call BIS_fnc_showNotification;
				playSound "killstrk_unlimammo";
				[] spawn FS_AddAction_Ammo;
			};
		};
		
		// enhanced armor
		if (_counter >= KS_Cost_Armor) then 
		{
			if (isNil {player getVariable 'FS_KSGodmode_Action'}) then 
			{
				["RespawnAdded", [localize "STR_FS_EnhArmor1",localize "STR_FS_EnhArmor2","\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa"]] call BIS_fnc_showNotification;
				playSound "killstrk_godmode";
				[] spawn FS_AddAction_Armor;
			};
		};
		
	};
	waitUntil {alive player};
};