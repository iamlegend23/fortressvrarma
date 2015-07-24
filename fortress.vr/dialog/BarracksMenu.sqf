disableSerialization;

FS_BARRACKS_TYPES = ["B_sniper_F", "B_Soldier_lite_F", "B_soldier_AR_F", "B_soldier_LAT_F"];
FS_BARRACKS_STANCES = ["AUTO", "UP", "MIDDLE", "DOWN"];
FS_BARRACKS_STANCES_TRNSLTN = [localize "STR_FS_Barracks_STANCE_AUTO", localize "STR_FS_Barracks_STANCE_UP", localize "STR_FS_Barracks_STANCE_MIDDLE", localize "STR_FS_Barracks_STANCE_DOWN"];
FS_BARRACKS_SIDES = [WEST];
FS_BARRACKS_SIDES_TRNSLTN = [localize "STR_WEST"];
FS_BARRACKS_AIMOVE = [TRUE, FALSE];
FS_BARRACKS_AIMOVE_TRNSLTN = [localize "STR_FS_Barracks_Yes", localize "STR_FS_Barracks_No"];
FS_BARRACKS_GROUPS = [localize "STR_FS_Barracks_GROUP_PLAYER", localize "STR_FS_Barracks_GROUP_NEW"];

/////////////////////////////////////////////////

_SelTypes = (_this select 0) displayCtrl 1500;
_SelStances = (_this select 0) displayCtrl 2101;
_SelSides = (_this select 0) displayCtrl 2102;
_SelMove = (_this select 0) displayCtrl 2103;
_SelGroup = (_this select 0) displayCtrl 2104;

// TYPES
{
	_SelTypes lbAdd gettext (configFile >> "CfgVehicles" >> _x >> "displayName");
	_SelTypes lbSetTooltip [_foreachindex, gettext (configFile >> "CfgVehicles" >> _x >> "_generalMacro")];
}
forEach FS_BARRACKS_TYPES;
_SelTypes lbSetCurSel (profileNameSpace getVariable ["VRFORTRESS_Barracks_SelTypes", 0]);

// STANCES
{
	_SelStances lbAdd _x;
}
forEach FS_BARRACKS_STANCES_TRNSLTN;
_SelStances lbSetCurSel (profileNameSpace getVariable ["VRFORTRESS_Barracks_SelStances", 0]);

// SIDES
{
	_SelSides lbAdd _x;
}
forEach FS_BARRACKS_SIDES_TRNSLTN;
_SelSides lbSetCurSel (profileNameSpace getVariable ["VRFORTRESS_Barracks_SelSides", 0]);

// DISABLE AI MOVE
{
	_SelMove lbAdd _x;
}
forEach FS_BARRACKS_AIMOVE_TRNSLTN;
_SelMove lbSetCurSel (profileNameSpace getVariable ["VRFORTRESS_Barracks_SelMove", 0]);

// GROUP
{
	_SelGroup lbAdd _x;
}
forEach FS_BARRACKS_GROUPS;
_SelGroup lbSetCurSel (profileNameSpace getVariable ["VRFORTRESS_Barracks_SelGroup", 0]);

#ifndef FS_BARRACKS_OPENED_FIRST_TIME
#define FS_BARRACKS_OPENED_FIRST_TIME

FS_CreateUnit = {
	disableSerialization;
	
	_SelTypes 		= (findDisplay 60013) displayCtrl 1500;
	_SelStances 	= (findDisplay 60013) displayCtrl 2101;
	_SelSides 		= (findDisplay 60013) displayCtrl 2102;
	_SelMove 		= (findDisplay 60013) displayCtrl 2103;
	_SelGroup 		= (findDisplay 60013) displayCtrl 2104;

	_params = 
	[
		FS_BARRACKS_TYPES select lbCurSel _SelTypes,
		FS_BARRACKS_STANCES select lbCurSel _SelStances,
		FS_BARRACKS_SIDES select lbCurSel _SelSides,
		FS_BARRACKS_AIMOVE select lbCurSel _SelMove
	];
	
	profileNameSpace setVariable ["VRFORTRESS_Barracks_SelTypes", lbCurSel _SelTypes];
	profileNameSpace setVariable ["VRFORTRESS_Barracks_SelStances", lbCurSel _SelStances];
	profileNameSpace setVariable ["VRFORTRESS_Barracks_SelSides", lbCurSel _SelSides];
	profileNameSpace setVariable ["VRFORTRESS_Barracks_SelMove", lbCurSel _SelMove];
	profileNameSpace setVariable ["VRFORTRESS_Barracks_SelGroup", lbCurSel _SelGroup];

	if (lbCurSel _SelGroup == 0) then 
	{
		_params pushBack group player;
	};
	
	_params call FS_Construct_Item;
	
};


#endif
