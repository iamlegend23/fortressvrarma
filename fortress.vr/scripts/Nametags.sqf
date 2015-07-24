
/*	
	as = group player execVM "scripts\nametags.sqf"
	
	Each member of the group must have a unique name in order for this script to work.
	If the unit does not have a name, there will be 'Alpha 1-1 (Admin)' string in %1 variable instead,
	and arma3's engine does not want to work with this sh1t.
	
	//[texture, color, pos, width, height, angle, text, shadow, textSize, font, textAlign, drawSideArrows]
*/	

FS_GetNameTag = {
	format ["%1 %2 %3", name _this, localize 'STR_FS_ProgressionMenu_LVL', _this getVariable ['VRFORTRESS_PlayerLVL', 0]]
};

FS_SetUphead = {
	private ["_z", "_this"];
	_z = _this select 2;
	_this set [2, _z + 0.5];
	_this
};

FS_getTagSize = {
	private "_this";
	if (_this < 5) exitWith {0.05}; 
	(0.05 * 5 / _this)
};

{
	if (_x != player) then {
		_x spawn {
			private "_id";
			_id = 0;
			az = compile format ["
				_id = addMissionEventHandler ['Draw3D', {
					if (player distance %1 < 12) then {
						drawIcon3D ['', [1,1,1,1], %1 modelToWorld ((%1 selectionPosition 'head') call FS_SetUphead), 0, 0, 0, %1 call FS_GetNameTag, 1, (player distance %1) call FS_getTagSize]
					};
				}];		
			", _this];
			call az;
			waitUntil {isNull _this};
			removeMissionEventHandler ["Draw3D", _id];
		};
	};
}
forEach (units _this);





