if (!isServer) exitWith {};

_un = _this select 0;
_vp = primaryWeapon _un; 
_mg = primaryWeaponMagazine _un; 

if (count _mg == 0) exitWith {};
_mg = _mg select 0;

While {alive _un} do 
{
	if (({_x == _mg} count (magazines _un)) < 2) then 
	{
		{_un addMagazineGlobal  _mg} forEach [0,0]
	};
	sleep 2;
};

if (SERVER getVariable ['ChckbxEndless', FALSE]) then
{
	removeAllWeapons _un;
};
// Активация 
// as = [this] execVM "скрипт.sqf";