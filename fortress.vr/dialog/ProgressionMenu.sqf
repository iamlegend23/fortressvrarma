_this spawn {
	disableSerialization;
	hintSilent "";

	_killed = SERVER getVariable ['FS_InfKilledByPlayers', 0];
	_killedByPlayer = player getVariable ['FS_RoundKills', 0];
	_killedTotal = profileNameSpace getVariable ['VRFORTRESS_InfKills', 0];

	_list1 = (_this select 0) displayCtrl 1500;
	_list2 = (_this select 0) displayCtrl 1501;

	_LvlProgressionSlider = (_this select 0) displayCtrl 1900;
	_PrevLvlName = (_this select 0) displayCtrl 1003;
	_NextLvlName = (_this select 0) displayCtrl 1004;
	_EnemiesKilledNumber = (_this select 0) displayCtrl 1005;
	_EnemiesKilledByYouNumber = (_this select 0) displayCtrl 1006;
	_EnemiesKilledTotalNumber = (_this select 0) displayCtrl 1007;

	_EnemiesKilledNumber ctrlSetText str(_killed);
	_EnemiesKilledByYouNumber ctrlSetText str(_killedByPlayer);
	_EnemiesKilledTotalNumber ctrlSetText str(_killedTotal);

	///////////////////////////////////////

	FS_ExpToNextLVL = {
		50 * _this + _this * _this
	};

	//hint format ["%1 %2 %3 %4 %5 %6 %7 %8 %9 %10", 1 call FS_KillsToNextLVL, 2 call FS_KillsToNextLVL, 3 call FS_KillsToNextLVL, 4 call FS_KillsToNextLVL, 5 call FS_KillsToNextLVL, 6 call FS_KillsToNextLVL, 7 call FS_KillsToNextLVL, 8 call FS_KillsToNextLVL, 9 call FS_KillsToNextLVL, 10 call FS_KillsToNextLVL];

	//_exp = 0;
	//_killsArray = profileNameSpace getVariable ["VRFORTRESS_KillsArray", []];
	//{
	//	if (_x isKindOf "MAN") then { _exp = _exp + 5 } else {
	//		if (_x isKindOf "TANK") then {
	//			_exp = _exp + 30;
	//		};
	//	};
	//} forEach _killsArray;
	
	_countedKills = _killedTotal - _killedByPlayer; // where we need to start progressing 

	_prevLvl = 1;
	while {_countedKills >= _prevLvl call FS_ExpToNextLVL} do {
		_prevLvl = _prevLvl + 1;
	};
	_prevLvl = _prevLvl - 1;
	_nextLvl = _prevLvl + 1;
	
	_prevLvlKills = _prevLvl call FS_ExpToNextLVL;
	_nextLvlKills = _nextLvl call FS_ExpToNextLVL;
	_PrevLvlName ctrlSetText format ["%1 %2", localize "STR_FS_ProgressionMenu_LVL", _prevLvl];
	_NextLvlName ctrlSetText format ["%1 %2", localize "STR_FS_ProgressionMenu_LVL", _nextLvl];

	// Ok now lets draw
	
	_startPos = (_countedKills - _prevLvlKills) / (_nextLvlKills - _prevLvlKills);
	_LvlProgressionSlider progressSetPosition _startPos;
	while {_countedKills < _killedTotal} do {
		_countedKills = _countedKills + 1;
		_startPos = (_countedKills - _prevLvlKills) / (_nextLvlKills - _prevLvlKills);
		_LvlProgressionSlider progressSetPosition _startPos;
		if (_startPos >= 1) then {
			_prevLvl = _nextLvl;
			_nextLvl = _prevLvl + 1;
			_prevLvlKills = _prevLvl call FS_ExpToNextLVL;
			_nextLvlKills = _nextLvl call FS_ExpToNextLVL;
			_PrevLvlName ctrlSetText format ["%1 %2", localize "STR_FS_ProgressionMenu_LVL", _prevLvl];
			_NextLvlName ctrlSetText format ["%1 %2", localize "STR_FS_ProgressionMenu_LVL", _nextLvl];
			
			profileNameSpace setVariable ["VRFORTRESS_PlayerLVL", _prevLvl];
			player setVariable ["VRFORTRESS_PlayerLVL", _prevLvl, TRUE];
		};
		playSound "hint";
		sleep (5 / _killedByPlayer);
		if (!Dialog) exitWith {};
	};
	FS_ExpToNextLVL = nil;
};