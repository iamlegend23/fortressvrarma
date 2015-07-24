
FS_Construct_Item = {
	private ["_x", "_y", "_z", "_type", "_name", "_item", "_build", "_cancel", "_this"];
	
	if (isNil {player getVariable "FS_Current_Constructing_Z"}) then
	{
		player setVariable ["FS_Current_Constructing_Y", 3];
		player setVariable ["FS_Current_Constructing_Z", 0.5];
	};
	_x = 0;
	_Y = player getVariable "FS_Current_Constructing_Y";
	_z = player getVariable "FS_Current_Constructing_Z";
	
	_type = _this select 0;

	//////////////////////////////////////////
	// Placable units module 
	if (count _this > 1) exitWith 
	{
		private ["_stance", "_side", "_disableMove", "_group", "_VRClass", "_unit"];
		_stance = _this select 1;
		_side = _this select 2;
		_disableMove = _this select 3;
		_group = if (count _this > 4) then {_this select 4} else {createGroup _side};
		
		if ((isNil {player getVariable "FS_Constructing_Unit"}) && (isNil {player getVariable "FS_Constructing_Item"})) then 
		{
			/* Example
			["B_soldier_AR_F", "MIDDLE", WEST, TRUE, group player] call FS_Construct_Item
			*/
			
			if (side player == SIDEENEMY) exitWith {cutText [localize "STR_FS_TeamKillerMsg", "PLAIN"];};
			
			_VRClass = "";
			switch (_side) do {
				case EAST: {_VRClass = "O_Soldier_VR_F"};
				case WEST: {_VRClass = "B_Soldier_VR_F"};
				default {_VRClass = "I_Soldier_VR_F"};
			};
			
			_VRClass createUnit [position player, _group, "", 0.75, "PRIVATE"]; 
			_unit = units _group select ((count units _group) - 1);
			
			if (_disableMove) then {_unit disableAI "MOVE"};
			_unit setUnitPos _stance;
			[_unit, _type, ["uniform"]] spawn BIS_fnc_loadInventory;
			
			_unit attachTo [player, [_x,_y,_z]];
			_build = player addAction [format ["<t color='#ffcc00'>%1</t>", localize "STR_FS_ActBuild"], {as = [] call FS_Build_Item}, [], 10, false, true];
			_cancel = player addAction [format ["<t color='#ffcc00'>%1</t>", localize "STR_FS_ActCancel"], {as = [] call FS_Cancel_Building}, [], 9, false, true];
		
			player forceWalk true;
			player setVariable ["FS_Constructing_Unit", _unit];
			player setVariable ["FS_Constructing_Act", _build];
			player setVariable ["FS_Constructing_Cancel", _cancel];
			
			_unit setVariable ["FS_Class", _type, TRUE];
			[_unit] spawn FS_ChangeRelPos;
		}
		else
		{
			as = [] call FS_Cancel_Building;
			[_type, _stance, _side, _disableMove, _group] call FS_Construct_Item;
		};
	};
	// Affects this, FS_Cancel_Building and FS_Build_Item functions (!)
	/////////////////////////////////////////////////////////////
	
	if ((isNil {player getVariable "FS_Constructing_Unit"}) && (isNil {player getVariable "FS_Constructing_Item"})) then 
	{
		_item = _type createVehicle getPos player;
		_item attachTo [player, [_x,_y,_z]];
		_build = player addAction [format ["<t color='#ffcc00'>%1</t>", localize "STR_FS_ActBuild"], {as = [] call FS_Build_Item}, [], 10, false, true];
		_cancel = player addAction [format ["<t color='#ffcc00'>%1</t>", localize "STR_FS_ActCancel"], {as = [] call FS_Cancel_Building}, [], 9, false, true];
		
		player forceWalk true;
		player setVariable ["FS_Constructing_Item", _item];
		player setVariable ["FS_Constructing_Act", _build];
		player setVariable ["FS_Constructing_Cancel", _cancel];
		[_item] spawn FS_ChangeRelPos;
		
		playSound "hint";
	}
	else 
	{
		as = [] call FS_Cancel_Building;
		[_type] call FS_Construct_Item;
	};
};
FS_ChangeRelPos = {
	private ["_x", "_y", "_z", "_item", "_i", "_orientation"];
	_x = 0;
	_y = player getVariable "FS_Current_Constructing_Y";
	_z = player getVariable "FS_Current_Constructing_Z";
	_item = _this select 0;
	
	_i = 0;
	_j = 0;
	_orientation = [[0,1,0], [1,1,0], [1,0,0], [1,-1,0], [0,-1,0], [-1,-1,0], [-1,0,0], [-1,1,0]];
	_Vorientation = [[0,0,1], [1,0,1], [1,0,0], [1,0,-1], [0,0,-1], [-1,0,-1], [-1,0,0], [-1,0,1]];
    
	while {((!isNil {player getVariable "FS_Constructing_Item"}) || (!isNil {player getVariable "FS_Constructing_Unit"})) && (alive player)} do 
	{
		if (PRESSED_CTRL && ((inputAction "prevAction" > 0) || (inputAction "nextAction" > 0))) then 
		{
			if (inputAction "prevAction" > 0) then {_z = _z + 0.025;};
			if (inputAction "nextAction" > 0) then {_z = _z - 0.025;};
			_item attachTO [player, [_x, _y, _z]];
			player setVariable ["FS_Current_Constructing_Z", _z];
			sleep 0.05;	
		};
		if ((currentWeapon player == START_PISTOL) && !PRESSED_CTRL && (PRESSED_E || PRESSED_Q)) then 
		{
			if (PRESSED_E) then { _y = _y + 0.15; };
			if (PRESSED_Q) then { _y = _y - 0.15; };
			player setVariable ["FS_Current_Constructing_Y", _Y];
			_item attachTO [player, [_x, _y, _z]];
			sleep 0.05;
		};
		if ((currentWeapon player == START_PISTOL) && PRESSED_CTRL && (PRESSED_E || PRESSED_Q)) then
		{
			if (PRESSED_E) then {_z = _z + 0.05;};
			if (PRESSED_Q) then {_z = _z - 0.05;};
			_item attachTO [player, [_x, _y, _z]];
			player setVariable ["FS_Current_Constructing_Z", _z];
			sleep 0.05;	
		};
		if ((currentWeapon player == START_PISTOL) && PRESSED_SHIFT) then 
		{
			_i = (_i + 1) mod count _orientation;
			_item setVectorDirAndUp [_orientation select _i, _Vorientation select _j]; 
			waitUntil {!PRESSED_SHIFT};
		};
		if ((currentWeapon player == START_PISTOL) && PRESSED_TAB) then 
		{
			_j = (_j + 1) mod count _Vorientation;
			_item setVectorDirAndUp [_orientation select _i, _Vorientation select _j]; 
			waitUntil {!PRESSED_TAB};
		};
	};
	if (!alive player) then {as = [] call FS_Cancel_Building;};
};

FS_Build_Item = {
	private ["_name", "_item", "_id", "_type"];
	if (!isNil {player getVariable "FS_Constructing_Act"}) then 
	{
		player removeAction (player getVariable "FS_Constructing_Act");
		player setVariable ["FS_Constructing_Act",nil];
	};
	if (!isNil {player getVariable "FS_Constructing_Cancel"}) then 
	{
		player removeAction (player getVariable "FS_Constructing_Cancel");
		player setVariable ["FS_Constructing_Cancel",nil];
	};
	if ((!isNil {player getVariable "FS_Constructing_Item"}) || (!isNil {player getVariable "FS_Constructing_Unit"})) then 
	{
		_item = if (!isNil {player getVariable "FS_Constructing_Item"}) then {player getVariable "FS_Constructing_Item"} else {player getVariable "FS_Constructing_Unit"};
		
		_type = _item getVariable ["FS_Class", typeOf _item];
		_name = getText (configFile >> "CfgVehicles" >> _type >> "displayName");
		
		// For deleting
		_id = profileNameSpace getVariable "VRFORTRESS_PlayerID";
		_item setVariable ["FS_ObjectOwner", str(name player), true];
		_item setVariable ["FS_ObjectOwnerID", _id, true];
		// For info about object
		_item setVariable ["FS_ObjectName", _name, true];
		// For rapid spawn
		if (!isNil {player getVariable "FS_Constructing_Item"}) then 
		{ player setVariable ["FS_PrevBuilding", typeOf _item] } 
		else 
		{
			player setVariable ["FS_PrevUnit", typeOf _item];
			_item setVariable ["FS_NoSave", TRUE, TRUE];
			
			_item call FS_AddToUnitsPool;
			
			// Unlimited ammo for friendly AIs
			[[_item], "VRF_fnc_SetUnlimAmmo"] spawn bis_fnc_MP;
			
			// The unit will take a seat in nearest vehicle
			if (group _item != group player) then 
			{
				private ["_vehs"];
				
				group _item setFormDir getDir _item;
				_vehs = _item nearEntities ["Land", 4];
				{
					if (typeOf _x in ["B_HMG_01_high_F", "B_GMG_01_high_F"]) exitWith 
					{
						if (count crew _x == 0) then 
						{
							group _item setFormDir getDir _x;
							_item moveInGunner _x;
						};
					};
				} forEach _vehs;
			};
		};
		
		player setVariable ["FS_Constructing_Item",nil];
		player setVariable ["FS_Constructing_Unit",nil];
		
		//////////////////////////////////////////////////
		// These two functions affects FS_LoadFortress (!)
		// -----------------------------------------------
		// For exploding barrels! :)
		if (typeOf _item == "Land_MetalBarrel_F") then 
		{
			_item call FS_Explosive_Barrel;
		};
		// For sitting on chairs and in toilets; 
		// Complicated; Special function was created for this feature (FS_ChairAction)
		// Uses function FS_GlobalSwitchMove from init.sqf
		if ((typeOf _item == "Land_CampingChair_V2_F") || (typeOf _item == "Land_FieldToilet_F")) then 
		{
			[[_item, TRUE, player], "FS_ChairAction"] call BIS_fnc_MP;
		};
		//////////////////////////////////////////////////
		
		detach _item;
	};
	player forceWalk false;
};

FS_AddToUnitsPool = 
{
	0 = [] call FS_RefreshUnitsPool;
	
	_placedUnits = player getVariable ["FS_PlacedUnits", []];
	_placedUnits pushBack _this;
	
	player setVariable ["FS_PlacedUnits", _placedUnits];
};
FS_RefreshUnitsPool = {
	private ["_aliveUnits", "_placedUnits", "_x"];
	// Refreshing pool of units created by Player
	_aliveUnits = [];
	_placedUnits = player getVariable ["FS_PlacedUnits", []];
	{
		if (!isNull _x) then
		{
			if (alive _x) then 
			{
				_aliveUnits pushBack _x;
			};
		};
	}
	forEach _placedUnits;
	player setVariable ["FS_PlacedUnits", _aliveUnits];
	
	count _aliveUnits
};

FS_Explosive_Barrel = {
	private "_this";
	_this addEventHandler ["Hit", 
	{
		private ['_item', '_takenDamage', '_damage'];
		_item = _this select 0;
		_takenDamage = _this select 2;
		_damage = getDammage _item;
	
		if (_takenDamage > 0.5 || _damage >= 0.9) then 
		{
			_mine = "M_Mo_82mm_AT_LG" createVehicle position _item; 
			_mine setPosATL getPosATL _item;
			_mine setVelocity [0,0,-100];
			_item removeAllEventHandlers 'Hit';
			
			_item spawn 
			{
				private ['_this', '_smoke', '_fire', '_effects'];
				_this setVelocity [random 5, random 5, 10 + random 10];
				sleep 6;
				deleteVehicle _this;
			};
		};
	}];
};
FS_ChairAction = {
	private ["_this", "_sitAct", "_standAct", "_chair", "_forAllUsers"];
	_chair = _this select 0;
	_forAllUsers = _this select 1;
	_isLocal = player == _this select 2;
	if (!_forAllUsers && !_isLocal) exitWith {};
	
	_sitAct = _chair addAction [localize "STR_FS_ChairSitDown", 
	{
		private ['_this', '_chair', '_caller', '_id', '_anim', '_animList', '_animSets'];
		_chair = _this select 0;
		_caller = _this select 1;
		_id = _this select 2;
		_chair removeAction _id;
		
		// To prevent two sitters at a time
		_chair setVariable ["FS_ChairIsOccupied", TRUE, TRUE];
		
		// Animations pool
		_animSets = 
		[
			['HubSittingChairUA_idle1', 'HubSittingChairUA_idle2', 'HubSittingChairUA_idle3'],
			['HubSittingChairUB_idle1', 'HubSittingChairUB_idle2', 'HubSittingChairUB_idle3', 'HubSittingChairUB_move1'],
			['HubSittingChairUC_idle1', 'HubSittingChairUC_idle2', 'HubSittingChairUC_idle3']
		];
		if (primaryWeapon _caller != '') then 
		{  
			_animSets pushBack ['HubSittingChairA_idle1', 'HubSittingChairA_idle2', 'HubSittingChairA_idle3'];
			_animSets pushBack ['HubSittingChairB_idle1', 'HubSittingChairB_idle2', 'HubSittingChairB_idle3'];
			_animSets pushBack ['HubSittingChairC_idle1', 'HubSittingChairC_idle2', 'HubSittingChairC_idle3'];
		};
		_animList = _animSets select floor random count _animSets;
		_caller setVariable ['FS_ChairAnims', _animList];
		// Set initial anim
		_anim = _animList select floor random count _animList;
		[[_caller, _anim], 'FS_GlobalSwitchMove'] call BIS_fnc_MP;
		// Changing animations while sitting
		_id = _caller addEventHandler ['AnimDone', 
		{
			private ['_this', '_animList', '_newAnim', '_player'];
			_player = _this select 0;
			_animList = _player getVariable 'FS_ChairAnims';
			_newAnim = _animList select floor random count _animList;
			[[_player, _newAnim], 'FS_GlobalSwitchMove'] call BIS_fnc_MP;
		}];
		_caller setVariable ['FS_ChairAnimEH', _id]; // do not move this line; its double use of _id variable
		
		if (typeOF _chair == "Land_FieldToilet_F") then 
		{
			_caller attachTo [_chair, [0,0.6,-1.1]];
		} 
		else
		{
			_caller attachTo [_chair, [0,-0.13,-0.435]];
		};
		_caller setDir 180;
		_caller setVariable ['FS_Chair', _chair];
		
		cutText [localize 'STR_FS_ChairStandUp', 'PLAIN DOWN', 5];
		
		_caller spawn 
		{
			private ['_this', '_chair', '_id'];
			_chair = _this getVariable 'FS_Chair';
			_id = _this getVariable 'FS_ChairAnimEH';
			
			waitUntil {PRESSED_SHIFT || !alive _this || isNull _chair};
			detach _this;
			_this setPosATL getPosATL _chair;
			_this setVariable ['FS_Chair', nil];
			_this setVariable ['FS_ChairAnimEH', nil];
			_this removeEventHandler ['AnimDone', _id];
			_chair setVariable ["FS_ChairIsOccupied", FALSE, TRUE];
			[[_this, 'AidlPercMstpSrasWrflDnon_G01_player'], 'FS_GlobalSwitchMove'] call BIS_fnc_MP;
			[[_chair, FALSE, player], "FS_ChairAction"] call BIS_fnc_MP;
		};
	}, [], 10, false, true, "", "!(_target getVariable ['FS_ChairIsOccupied', FALSE])"];

};

FS_Cancel_Building = {
	private ["_item"];
	if (!isNil {player getVariable "FS_Constructing_Act"}) then 
	{
		player removeAction (player getVariable "FS_Constructing_Act");
		player setVariable ["FS_Constructing_Act",nil];
	};
	if (!isNil {player getVariable "FS_Constructing_Cancel"}) then 
	{
		player removeAction (player getVariable "FS_Constructing_Cancel");
		player setVariable ["FS_Constructing_Cancel",nil];
	};
	if (!isNil {player getVariable "FS_Constructing_Item"}) then 
	{
		_item = player getVariable "FS_Constructing_Item";
		player setVariable ["FS_Constructing_Item",nil];
		detach _item; 
		deleteVehicle _item;
	};	
	if (!isNil {player getVariable "FS_Constructing_Unit"}) then 
	{
		_unit = player getVariable "FS_Constructing_Unit";
		player setVariable ["FS_Constructing_Unit",nil];
		detach _unit; 
		deleteVehicle _unit;
	};
	player forceWalk false;
};

FS_DeleteTarget = {
	private ["_target", "_playerId", "_ownerID", "_owner"];
	_target = cursorTarget;
	_playerId = profileNameSpace getVariable "VRFORTRESS_PlayerID";
	
	if (isNil {_target getVariable "FS_ObjectOwner"}) exitWith {};
	_ownerID = _target getVariable "FS_ObjectOwnerID";
	_owner = _target getVariable "FS_ObjectOwner";

	if (!alive _target || (_ownerID == _playerId) || (_ownerID == "EMPTY") || serverCommandAvailable "#logout" || isServer) then 
	{
		deleteVehicle _target;
		playSound "hint"; 
	}
	else 
	{
		cutText [localize "STR_FS_BUILD_DELOBJECT", "PLAIN", 2];
	};
};

FS_CheckCursorTarget = {
	private ["_target", "_name", "_owner"];
	while {true} do 
	{
		if (currentWeapon player == START_PISTOL) then 
		{
			_target = cursorTarget;
			if (!isNil {_target getVariable "FS_ObjectOwner"}) then 
			{
				_name = _target getVariable "FS_ObjectName";
				_owner = _target getVariable "FS_ObjectOwner";
				hintSilent format ["%1 placed by %2", _name, _owner];
			};
		};
		sleep 0.5;
	};
};

FS_Rapid_Spawn = {
	private ["_type"];
	while {true} do 
	{
		waitUntil {(PRESSED_CTRL && ((inputAction "nextAction" > 0) || (inputAction "prevAction" > 0)))}; 
		
		if ((isNil {player getVariable "FS_Constructing_Item"}) && (isNil {player getVariable "FS_Constructing_Unit"}) && (!isNil {player getVariable "FS_PrevBuilding"})) then 
		{
			_type = player getVariable "FS_PrevBuilding";
			[_type] call FS_Construct_Item;
		};
		sleep 0.5; 
	};
};

FS_Deleting = {
	while {true} do 
	{
		waitUntil {inputAction "nextWeapon" > 0}; 
		if (currentWeapon player == START_PISTOL) then { [] spawn FS_DeleteTarget; };
		waitUntil {inputAction "nextWeapon" == 0};
	};
};

FS_isExists = {
	private ["_cfgDefault", "_cfgTemplate"];
	_cfgDefault = configfile >> "CfgVehicles" >> "Land_PencilYellow_F";
	_cfgTemplate = [["CfgVehicles",_this],_cfgDefault] call bis_fnc_loadClass;
	if (_cfgTemplate != _cfgDefault) then {true} else {false};
};

FS_WipeFortress = {
	if (!isServer) exitWith { hint "\nOnly server can Wipe!\n\n"; };
	private ["_wipeMines", "_wipeGraff", "_wipeAll", "_x", "_allItems", "_placedObjects", "_item", "_wipeList"];
	
	_wipeMines 	= if (count _this > 0) then {_this select 0} else {false};
	_wipeGraff 	= if (count _this > 1) then {_this select 1} else {false};
	_wipeAll 	= if (count _this > 2) then {_this select 2} else {false};
	
	_allItems = allMissionObjects "All";
	_placedObjects = [];
	_item = [];
	_wipeList = [];
	
	if (_wipeMines) then 
	{
		{ deleteVehicle _x } forEach AllMines;
	};
	if (_wipeGraff) then {_wipeList = _wipeList + ["Land_Graffiti_01_F", "Land_Graffiti_03_F", "Land_Poster_01_F"]};
	{
		if (_wipeAll || typeOf _x in _wipeList) then 
		{
			if (!isNil {_x getVariable "FS_ObjectName"}) then 
			{
				_x setVariable ["FS_ObjectOwner", nil, true];
				_x setVariable ["FS_ObjectOwnerID", nil, true];
				_x setVariable ["FS_ObjectName", nil, true];
				deleteVehicle _x;
			};
		};
	}
	forEach _allItems;
};

FS_SaveFortress = {
	private ["_x", "_allItems", "_placedObjects", "_item", "_blacklist", "_tempMines"];
	_blacklist = [];
	_allItems = allMissionObjects "All";
	_placedObjects = [];
	_item = [];

	// Deleting non existing mines
	_tempMines = [];
	SYSTEM_MINES = SERVER getVariable ["SYSTEM_MINES", []];
	{
		if !(isNull _x) then { _tempMines = _tempMines + [_x]; };
	}
	forEach SYSTEM_MINES;
	SYSTEM_MINES = _tempMines;
	SERVER setVariable ["SYSTEM_MINES", SYSTEM_MINES, TRUE];
	
	// Saving Mines placed by players
	if (isNil {SYSTEM_MINES}) then { SYSTEM_MINES = []; };
	{
		if !(_x in SYSTEM_MINES) then 
		{
			_item = [typeOf _x, getPosATL _x, vectorDir _x, vectorUP _x];
			_placedObjects = _placedObjects + [_item];
		};
	}
	forEach allMines; 
	
	// Saving objects placed by players
	{
		if ((!isNil {_x getVariable "FS_ObjectName"}) && !(_x getVariable ["FS_NoSave", FALSE])) then 
		{
			// Saving [class, dir, pos, vectorDir, vectorUP]
			if !(typeOf _x in _blacklist) then 
			{
				_item = [typeOf _x, getPosATL _x, vectorDir _x, vectorUP _x];
				// Little hack : we will turn object back to initial state before saving it's coordinates. 
				// It will help us later with loading.
				_x setVectorDirAndUp [[0,1,0], [0,0,1]];
				_item set [1, getPosATL _x];
				_x setVectorDirAndUp [_item select 2, _item select 3];
				_placedObjects set [count _placedObjects, _item];
			};
		};
	}
	forEach _allItems;
	
	str(_placedObjects)
};

FS_LoadFortress = {
	if (!isServer) exitWith 
	{
		hint "\nOnly server can Load!\n\n"; 
	};
	private ["_placedObjects", "_type", "_dir", "_pos", "_name", "_vector", "_owner", "_ownerID", "_item"];
	_placedObjects = call compile _this;
	{
		_type = _x select 0;
		_dir = _x select 1;
		_j = 0;
		if (typeName _dir != typeName []) then { 
			// user trying to load an old save-file with stored directions
			// example : [typeOf _x, getDir _x, getPosATL _x, vectorDir _x, vectorUP _x]
			_j = 0;
		} else {
			// user trying to load a new save-file without stored getDir's
			// example : [typeOf _x, getPosATL _x, vectorDir _x, vectorUP _x]
			_j = -1;
		};
		_pos = _x select 2 + _j;
		_name = gettext (configFile >> "CfgVehicles" >> _type >> "displayName");
		_vector = _x select 3 + _j;
		_vectorUP = _x select 4 + _j;
		_owner = "FortLoadeR";
		_ownerID = "EMPTY";
		
		_item = _type createVehicle _pos;
		_item setVariable ["FS_ObjectName", _name, true];
		_item setVariable ["FS_ObjectOwner", _owner, true];
		_item setVariable ["FS_ObjectOwnerID", _ownerID, true];

		_item setPosATL _pos;
		_item setVectorDirAndUp [_vector, _vectorUP];
		
		// Exploding barrels
		if (_type == "Land_MetalBarrel_F") then 
		{
			_item call FS_Explosive_Barrel;
		};
		// Adding chairs\toilets actions
		if ((_type == "Land_CampingChair_V2_F") || (typeOf _item == "Land_FieldToilet_F")) then 
		{
			[[_item, TRUE, player], "FS_ChairAction"] call BIS_fnc_MP;
		};
	}
	forEach _placedObjects;
	
	// Reveal downloaded mines
	{ [_x, "FS_RevealMine"] call BIS_fnc_MP; } forEach allMines;
	
	playSound "hint";
	cutText ["Fort was loaded!", "PLAIN DOWN", 2]; 
};

// === === === === === === === === === === === === === === === ===

[] spawn FS_CheckCursorTarget;
[] spawn FS_Rapid_Spawn;
[] spawn FS_Deleting;






