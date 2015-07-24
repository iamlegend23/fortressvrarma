
FS_LvlProgression_BetterStamina = {
	
	['RespawnAdded', [format ['%1 %2', localize 'STR_FS_ProgressionMenu_LVL', 5], localize 'STR_FS_LvlFeatures_BetterStaminaDescription', '\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa']] spawn BIS_fnc_showNotification;
	
	_playerLVL = profileNameSpace getVariable ["VRFORTRESS_PlayerLVL", 0];
	
	while {true} do {
		_fat = getFatigue player;
		//hint str(_fat);
		if (_fat > 0) then {
			_fat = _fat - 0.005;
			if (_fat < 0) then {_fat = 0};
			player setFatigue _fat;
		};
		sleep 0.5;
	};
};

FS_LvlProgression_RespawnProtection = {
	private ["_currentPlayer", "_corpse"];
	["RespawnAdded", [localize "STR_FS_PERK_EFFECT", format ["%1 : %2 %3", localize "STR_FS_PERK_SPAWNPROTECTIONADDED", CONST_RESPAWN_GODMODETIME, localize "STR_FS_PERK_seconds"],"\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa"]] call BIS_fnc_showNotification;
	
	_ppCCBase = [0.199, 0.587, 0.114, 0.0];
	_ppCCIn = [1, 1, 0, [0.0, 0.0, 0.0, 0.5], [0.8, 0.8, 8.0, 0.4], _ppCCBase];
	"colorCorrections" ppEffectAdjust _ppCCIn;
	"colorCorrections" ppEffectCommit 2;
	"colorCorrections" ppEffectEnable true;
		
	_currentPlayer = _this select 0;
	_corpse = _this select 1;
	_currentPlayer allowDamage false;
	sleep (CONST_RESPAWN_GODMODETIME - 2);
	
	_ppCCIn = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1.0, 1.0, 1.0, 1.0], _ppCCBase];
	"colorCorrections" ppEffectAdjust _ppCCIn;
	"colorCorrections" ppEffectCommit 2;
	"colorCorrections" ppEffectEnable true;
	
	sleep 2;
	_currentPlayer allowDamage true;
};

////////////////////////////

//_Journal_SaveLoad = format ["<br/>%1<br/><br/>%2<br/><br/>%3<br/><br/>", localize "STR_FS_SAVELOAD_01", localize "STR_FS_SAVELOAD_02", localize "STR_FS_SAVELOAD_03"];

//player createDiarySubject ["VRF","VR Fortress"];
//player createDiaryRecord ["Levels", [localize "STR_FS_Title_Construction", _Journal_Brief]];

waitUntil {!isNil {PARAMETERS_SET}};

_playerLVL = profileNameSpace getVariable ["VRFORTRESS_PlayerLVL", 0];

if ( _playerLVL >= 3 ) then {
	['RespawnAdded', [format ['%1 %2', localize 'STR_FS_ProgressionMenu_LVL', 3], localize 'STR_FS_LvlFeatures_SpawnProtectionDescription', '\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa']] spawn BIS_fnc_showNotification;
	player addEventHandler ["Respawn", {_this spawn FS_LvlProgression_RespawnProtection}];
};
if ( _playerLVL >= 5 ) then { [] spawn FS_LvlProgression_BetterStamina; };














