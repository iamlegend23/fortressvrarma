
_pe_cloak = "#particlesource" createVehicleLocal getposATL _this;
_pe_cloak setParticleCircle [0, [0, 0, 0]];
_pe_cloak setParticleRandom [0.2, [0, 0, 0], [0.0, 0.0, 0], 1, 0.5, [0, 0, 0, 0], 0, 0];
_pe_cloak setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract",1, 0, 1, 0],"","Billboard",1,1.0,[0, 0, 0],[0, 0, 0.0],0,3,3,0.1,[1.0],[[1, 0.7, 0.7, 0.0]],[1],0,0,"","",_this];
_pe_cloak setDropInterval 0.04;
	
// Particles ON
_pe_cloak setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract",1, 0, 1, 0],"","Billboard",1,1.0,[0, 0, 0],[0, 0, 0.0],0,3,3,0.1,[1.0],[[1, 0.7, 0.7, 0.35]],[1],0,0,"","",_this];

sleep 1;

if (isServer) then {
	_this hideObjectGlobal true;
	_this allowDamage true;
	// Unlimited ammo
	[_this] spawn VRF_fnc_SetUnlimAmmo;
};

waitUntil {!alive _this};
deleteVehicle _pe_cloak;

if (isServer) then {
	_this hideObjectGlobal false;
};

