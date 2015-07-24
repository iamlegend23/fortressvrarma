FESS_fnc_Bomber = {
	/* ARMA 3 function FESS_fnc_Bomber
	
	Description:
		causes a mines to fall in the area of ~100-150 meters
	Parameters:
	_this select 0 : center , format [x,y,z]
	_this select 1 : rounds count
	_this select 2 : debug true\false
	_this select 3 : type of rounds
	_this select 4 : height 
	_this select 5 : delay beetween bombs
	
	[getPos player, 10, true] spawn FESS_fnc_Bomber
	
	** Improvement: now each projectile has it's own unique trajectory.
	Bombs fall at different angles from different directions and with different velocities.
	
	*/
	
    private["_this","_pos","_mine","_x","_y","_radius","_i","_counter","_debug", "_type", "_height", "_delay", "_velocity", "_pos1", "_pos2"];
    _pos = _this select 0;
	_counter = if(count _this > 1) then {_this select 1} else {5};
	_debug = if(count _this > 2) then {_this select 2} else {false};
	_type = if(count _this > 3) then {_this select 3} else { "Sh_82mm_AMOS" };
	_height = if(count _this > 4) then {_this select 4} else { 300 };
	_delay = if(count _this > 5) then {_this select 5} else { 0.5 };
	
	//["mp_alarm", "FS_PlaySoundGlobal"] call BIS_fnc_MP;
	sleep (3 + random 7);
	
	for "_i" from 1 to _counter do 
	{
		_radius = 25 + random 25;
		_x = _radius - random(_radius*2); 
		_y = _radius - random(_radius*2); 
			
		_mine = _type createVehicle [(_pos select 0) + _x, (_pos select 1) + _y, _height];  
		_mine setPos [(_pos select 0) + _x, (_pos select 1) + _y, _height];
		
		_pos1 = (getPosATL _mine);
		_pos2 = [_pos, [0, _radius], [0, 360]] call SHK_Pos;
		_velocity = [(_pos2 select 0) - (_pos1 select 0), (_pos2 select 1) - (_pos1 select 1), (_pos2 select 2) - (_pos1 select 2)];
		
		_mine setVelocity _velocity;
		
		if(_debug) then {
			private["_mark"];
			_mark = createMarker [format ["%1",random 10000], [(_pos select 0) + _x, (_pos select 1) + _y]];
			_mark setMarkerType "hd_destroy";
		};
		sleep (_delay + random 1);
	};
	true
};