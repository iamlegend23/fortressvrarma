//its a bit modified code By Meatball (randomWeather2 Script)
//I only needed snow so I cutted off some stuff 

density = _this select 0;

neo_fnc_snow_init = {
        private["_unit"];
        _unit = _this select 0;
       
        snowEmitter = "#particlesource" createVehicleLocal getpos _unit;
		
		snowEmitter setParticleCircle [0.0, [0, 0, 0]];
		snowEmitter setParticleRandom [0, [10, 10, 7], [0, 0, 0], 0, 0.01, [0, 0, 0, 0.1], 0, 0];
		snowEmitter setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 13,1], "","Billboard", 1, 7, [0,0,0], [0,0,0], 1, 0.0000001, 0.000, 1.7,[0.07],[[1,1,1,1]],[0,1], 0.2, 1.2, "", "", _unit];

		snowEmitter setDropInterval 0.0;  
        snowEmitter attachto [_unit,[0,0,8]];
        [_unit,snowEmitter] spawn neo_mb_fnc_snow_setAhead;
};

neo_mb_fnc_snow_setAhead = {
        private["_unit","_vel","_attached"];
        _unit = _this select 0;
        snowEmitter = _this select 1;
        _attached = _unit;
        while {!(isNull snowEmitter) && !(isNull _unit) && alive player} do 
		{
                if (vehicle _unit != _unit) then 
				{
                    _attached = vehicle _unit;
                }
				else 
				{
                    if (_attached != _unit) then 
					{
                        _attached = _unit;
                    };
                };
                
				_vel = speed _attached;
                _dir = getdir _attached;
                snowEmitter attachto [_attached,[0,_vel*0.5,8]];
				snowEmitter setDropInterval density;

				_unitPos = getPosASL _unit;
				
				// Disable snow underwater.  On by Default
				if (underwater _unit) then { snowEmitter setDropInterval 0; };
				
				// Disable snow when indoors.  On by Default.  Change intSnow to 1 on line 60 if you wish it to snow in buildings/vehicles/under roofs.
				intSnow = 1;
				if (intSnow == 0) then 
				{
					roofOverhead = lineIntersects [eyePos _unit,[_unitPos select 0,_unitPos select 1,(_unitPos select 2)+35]];
					if (roofOverhead) then 
					{
						snowEmitter setDropInterval 0.0; 
					};
				};
				
				// Disable snow below 100m altitude.  Off/Commented out by default.  Change '100' to any altitude you wish it to snow above.
				//if ((_unitPos select 2) < 100) then {snowEmitter setDropInterval 0;};
				
				// Snow only at night. Off/Commented out by default. Change if statement to sunormoon == 0 to snow only during the day.  sunormoon == 1 means the sun is out, sunormoon == 0 means the sun is down.
				//if (sunormoon == 1) then {snowEmitter setDropInterval 0;};
               
			   sleep 1;
        };
		deleteVehicle snowEmitter;
		waitUntil {alive player};
		if (isNil {player getVariable "FS_isHided"}) exitWith 
		{
			[player] spawn neo_fnc_snow_init; // restarting snow
		};
};

1 setFog 1;
[player] spawn neo_fnc_snow_init;