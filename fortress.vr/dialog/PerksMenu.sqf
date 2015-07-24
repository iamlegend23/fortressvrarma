
FS_CHBXS = 
[
	(_this select 0) displayCtrl 2800, 
	(_this select 0) displayCtrl 2801, 
	(_this select 0) displayCtrl 2803, 
	(_this select 0) displayCtrl 2806, 
	(_this select 0) displayCtrl 2808, 
	(_this select 0) displayCtrl 2809,  
	(_this select 0) displayCtrl 2802, 	// WH
	(_this select 0) displayCtrl 2804, 	// AutoHeal
	(_this select 0) displayCtrl 2805 	// CAS
];

if (PERK_ASSIGNED) exitWith {closeDialog 0};

#ifndef FS_PERKSMENU_OPENED_FIRST_TIME
#define FS_PERKSMENU_OPENED_FIRST_TIME

///////////////////////////////////////////////////
//	Do not change anything below 
///////////////////////////////////////////////////

FS_PerksMenu_Uncheck = {
	private ["_untouched", "_i", "_this"];
	_untouched = FS_CHBXS select _this;
	for "_i" from 0 to ((count FS_CHBXS) - 1) do 
	{
		_chkbx = FS_CHBXS select _i;
		if (_untouched != _chkbx) then 
		{
			// uncheck
			_chkbx cbSetChecked false;
		};
	};
};

FS_SetPerk = {
	private ["_pos", "_count", "_i", "_chkbx"];
	_pos = 0;
	_count = 0;
	for "_i" from 0 to ((count FS_CHBXS) - 1) do 
	{
		_chkbx = FS_CHBXS select _i;
		if (cbChecked _chkbx) then { _count = _count + 1; _pos = _i; };
	};
	if (_count <= 0) exitWith {cutText [localize "STR_FS_PERK_NOPERKSELECTED", "PLAIN DOWN", 2]; playSound "hint";};
	if (_count > 1) exitWith {cutText [localize "STR_FS_PERK_ONLY1PERK", "PLAIN DOWN", 2]; playSound "hint";};
	cutText ["", "PLAIN DOWN", 2];
	
	switch (_pos) do 
	{
		case 0: { /* PayBack 		*/ 	player addEventHandler ["Killed", {_this spawn FS_Perks_Payback}];};
		case 1: { /* Artillery 		*/ 	[] spawn FS_Perk_Artillery; };
		case 2: { /* Zeus's pet 	*/ 	PERK_ZEUSPETBONUS = 15; };
		case 3: { /* DeadShot 		*/ 	[[player, nil, 3, 2, 200, 3, true], "hyp_fnc_traceFire"] call BIS_fnc_MP; };
		case 4: { /* Mirror 		*/ 	player addEventHandler ["hit", {_this call FS_Perks_Mirror}];};
		case 5: { /* Tickets++ 		*/ 	PERK_TICKETS_PP = CONST_ADDTICKETS_COUNT; };
		case 6: { /* Wall Hack 		*/ 	PERK_WH = TRUE; };
		case 7: { /* AutoHeal 		*/ 	[] spawn FS_Perk_AutoHeal; };
		case 8: { /* CAS 			*/ 	[] spawn FS_Perk_CAS; };
	};
	
	PERK_ASSIGNED = TRUE;
	closeDialog 0;
};

FS_Perk_AutoHeal = {
	while {true} do 
	{	
		if ((damage player > 0) && (alive player)) then 
		{
			_dam = damage player;
			_dam = _dam - 0.1;
			if (_dam < 0) then { _dam = 0; };
			player setDamage _dam;
		};
		sleep 1;
	}; 
};

FS_Perk_Artillery = {
	private ["_center", "_group"];
	PERK_ARTILLERY_READY = FALSE;
	while {true} do {
		
		["RespawnAdded", [localize "STR_FS_PERK_EFFECT", localize "STR_FS_PERK_ARTYREADY", "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa"]] call BIS_fnc_showNotification;
		["RespawnAdded", [localize "STR_FS_PERK_EFFECT", localize "STR_FS_PERK_ARTYHELP", "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa"]] call BIS_fnc_showNotification;
		
		onMapSingleClick "if (PRESSED_CTRL) then {_pos spawn FS_Perk_Artillery_MapClick;}; false";
		PERK_ARTILLERY_READY = TRUE;
		
		waitUntil {!PERK_ARTILLERY_READY};
		sleep CONST_ARTY_RELOAD_TIME + floor random CONST_ARTY_RELOAD_TIME;
	};
};
FS_Perk_Artillery_MapClick = {
	private ["_this"];
	onMapSingleClick "false";
	
	["['RespawnAdded', [localize 'STR_FS_PERK_ARTYSUPPORT', localize 'STR_FS_PERK_ARTYINBOUND', '\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa']] spawn BIS_fnc_showNotification", "FS_compileAndRun"] call BIS_fnc_MP;
	
	_marker = createMarker [str(round random 1000000), _this];
	_marker setMarkerType "hd_warning";
	_marker setMarkerColor "ColorRed";
	_marker setMarkerText "Artillery strike!";
	
	[getMarkerPos _marker, 6] spawn FESS_fnc_Bomber;
	sleep 10;
	
	PERK_ARTILLERY_READY = FALSE;
	deleteMarker _marker;
};


FS_Perk_CAS = {
	private ["_center", "_group"];
	PERK_CAS_READY = FALSE;
	while {true} do {
		
		["RespawnAdded", [localize "STR_FS_PERK_EFFECT", localize "STR_FS_PERK_CASREADY", "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa"]] call BIS_fnc_showNotification;
		["RespawnAdded", [localize "STR_FS_PERK_EFFECT", localize "STR_FS_PERK_CASHELP", "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa"]] call BIS_fnc_showNotification;
		
		onMapSingleClick "if (_alt) then {_pos spawn FS_Perk_CAS_MapCLick;}; false";
		PERK_CAS_READY = TRUE;
		
		waitUntil {!PERK_CAS_READY};
		sleep CONST_CAS_RELOAD_TIME + floor random CONST_CAS_RELOAD_TIME;
	};
};
FS_Perk_CAS_MapCLick = {
	private ["_this"];
	onMapSingleClick "false";
	
	["['RespawnAdded', [localize 'STR_FS_PERK_CASSUPPORT', localize 'STR_FS_PERK_CASINBOUND', '\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa']] spawn BIS_fnc_showNotification", "FS_compileAndRun"] call BIS_fnc_MP;
	
	
	_marker = createMarker [str(round random 1000000), _this];
	_marker setMarkerType "hd_warning";
	_marker setMarkerColor "ColorRed";
	_marker setMarkerText "CAS inbound!";
	
	_center = createCenter sideLogic;
	_group = createGroup _center;
	_logic = _group createUnit ["LOGIC", [0,0,0], [], 0, "NONE"];
	_logic setVariable ["vehicle", "B_Plane_CAS_01_F"];
	_logic setVariable ["type", 2];
	_logic setPos _this;
	
	[_logic, [], true] spawn VRF_fnc_CAS;
	waitUntil {isNull _logic};
	PERK_CAS_READY = FALSE;
	deleteMarker _marker;
};

FS_Perks_Payback = {
	private ["_player", "_killer", "_bomb"];
	_player = _this select 0;
	_killer = _this select 1;
	if ((_player == _killer) || (isNull _killer)) exitWith {};
	_bomb = "M_Mo_82mm_AT_LG" createVehicle getPosATL _killer;
};

FS_Perks_Mirror = {
	private ["_player", "_attacker", "_dam", "_attackerDam"];
	_player = _this select 0;
	_attacker = _this select 1;
	_dam = _this select 2;
	if (_player == _attacker) exitWith {};
	_attackerDam = damage _attacker;
	_attacker setDamage (_attackerDam + _dam * CONST_PAYBACK_MULT);
};


#endif 