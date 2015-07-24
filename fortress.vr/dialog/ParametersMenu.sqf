///////////////////////////////////////////////////
//	Do not change anything below 
///////////////////////////////////////////////////

if (!isServer || !isNil {PARAMETERS_SET}) exitWith {closedialog 0;};

Ranks = [];

_SEL_WAVESCOUNT 	= (_this select 0) displayCtrl 2100;
_SEL_STARTWAVE 		= (_this select 0) displayCtrl 2101;
_SEL_STARTTIME 		= (_this select 0) displayCtrl 2102;
_SEL_AISKILL 		= (_this select 0) displayCtrl 2103;
_SEL_TICKETSCOUNT 	= (_this select 0) displayCtrl 2104;
_SEL_AILIMIT 		= (_this select 0) displayCtrl 2105;
_SEL_SNOWDNST		= (_this select 0) displayCtrl 2106;

{ _SEL_WAVESCOUNT lbAdd str(_x) } forEach [1,2,3,4,5,6,7,8,9,10];
_SEL_WAVESCOUNT lbsetcursel (profileNameSpace getVariable ["VRFORTRESS_WAVESCOUNT", 4]);

{ _SEL_STARTWAVE lbAdd str(_x) } forEach [1,2,3,4,5,6];
_SEL_STARTWAVE lbsetcursel (profileNameSpace getVariable ["VRFORTRESS_STARTWAVE", 0]);

{ _SEL_STARTTIME lbAdd _x } forEach ["13","18","19","20"];
_SEL_STARTTIME lbsetcursel (profileNameSpace getVariable ["VRFORTRESS_STARTTIME", 0]);

{
	Ranks = Ranks + [gettext (_x >> "displayName")];
	_SEL_AISKILL lbAdd gettext (_x >> "displayName");
	//_SEL_AISKILL lbSetPicture [_foreachindex,gettext (_x >> "texture")];
	_SEL_AISKILL lbSetTooltip [_foreachindex,gettext (_x >> "displayName")];
} 
foreach ("isclass _x" configclasses (configfile >> "CfgRanks"));
_SEL_AISKILL lbsetcursel (profileNameSpace getVariable ["VRFORTRESS_AISKILL", 1]);

{ _SEL_TICKETSCOUNT lbAdd str(_x) } forEach [1,5,10,15,20,25,30,35,40,45,50,999];
_SEL_TICKETSCOUNT lbsetcursel (profileNameSpace getVariable ["VRFORTRESS_TICKETSCOUNT", 4]);

{ _SEL_AILIMIT lbAdd str(_x) } forEach [20, 30, 40, 50, 60, 70, 80, 90, 100];
_SEL_AILIMIT lbsetcursel (profileNameSpace getVariable ["VRFORTRESS_AILIMIT", 2]);

//////////////////////////////////////////////
											//
FS_SNOW_DENS = [0.01, 0.001, 0.0001];		//
											//
//////////////////////////////////////////////


{ _SEL_SNOWDNST lbAdd _x } forEach [localize "STR_FS_Snow1", localize "STR_FS_Snow2", localize "STR_FS_Snow3"];
_SEL_SNOWDNST lbsetcursel (profileNameSpace getVariable ["VRFORTRESS_SNOWDNST", 0]);

((_this select 0) displayCtrl 2800) cbSetChecked (profileNameSpace getVariable ["VRFORTRESS_EnPerks", FALSE]);
((_this select 0) displayCtrl 2801) cbSetChecked (profileNameSpace getVariable ["VRFORTRESS_EnKS", FALSE]);
((_this select 0) displayCtrl 2802) cbSetChecked (profileNameSpace getVariable ["VRFORTRESS_EnBoss", FALSE]);
((_this select 0) displayCtrl 2803) cbSetChecked (profileNameSpace getVariable ["VRFORTRESS_Endless", FALSE]);
((_this select 0) displayCtrl 2804) cbSetChecked (profileNameSpace getVariable ["VRFORTRESS_AIArt", FALSE]);
((_this select 0) displayCtrl 2805) cbSetChecked (profileNameSpace getVariable ["VRFORTRESS_AIVeh", FALSE]);
((_this select 0) displayCtrl 2806) cbSetChecked (profileNameSpace getVariable ["VRFORTRESS_MineFields", FALSE]);
((_this select 0) displayCtrl 2807) cbSetChecked (profileNameSpace getVariable ["VRFORTRESS_EnSnow", FALSE]);

#ifndef FS_PARAMSMENU_OPENED_FIRST_TIME
#define FS_PARAMSMENU_OPENED_FIRST_TIME

FS_SetMissionParameters = {

	playSound "hint";	
	
	_SEL_WAVESCOUNT 	= (findDisplay 60012) displayCtrl 2100;
	_SEL_STARTWAVE 		= (findDisplay 60012) displayCtrl 2101;
	_SEL_STARTTIME 		= (findDisplay 60012) displayCtrl 2102;
	_SEL_AISKILL 		= (findDisplay 60012) displayCtrl 2103;
	_SEL_TICKETSCOUNT 	= (findDisplay 60012) displayCtrl 2104;
	_SEL_AILIMIT 		= (findDisplay 60012) displayCtrl 2105;
	_SEL_SNOWDNST 		= (findDisplay 60012) displayCtrl 2106;
	
	SERVER setVariable ["ChckbxEnPerks", cbChecked ((findDisplay 60012) displayCtrl 2800), true];
	SERVER setVariable ["ChckbxEnKS", cbChecked ((findDisplay 60012) displayCtrl 2801), true];
	SERVER setVariable ["ChckbxEnBoss", cbChecked ((findDisplay 60012) displayCtrl 2802), true];
	SERVER setVariable ["ChckbxEndless", cbChecked ((findDisplay 60012) displayCtrl 2803), true];
	SERVER setVariable ["ChckbxAIArt", cbChecked ((findDisplay 60012) displayCtrl 2804), true];
	SERVER setVariable ["ChckbxAIVeh", cbChecked ((findDisplay 60012) displayCtrl 2805), true];
	SERVER setVariable ["ChckbxMineFields", cbChecked ((findDisplay 60012) displayCtrl 2806), true];
	SERVER setVariable ["ChckbxEnSnow", cbChecked ((findDisplay 60012) displayCtrl 2807), true];
	
	_rank = lbCurSel 2103;
	for "_i" from 0 to count Ranks - 1 do 
	{
		if (_rank == _i) exitWith { SERVER setVariable ["SEL_AISKILL", 1 - 1 / (_i + 1), true]; }; 
	};
	SERVER setVariable ["SEL_AILIMIT", parseNumber (_SEL_AILIMIT lbText (lbCurSel _SEL_AILIMIT)), true];
	SERVER setVariable ["SEL_SNOWDNST", FS_SNOW_DENS select lbCurSel _SEL_SNOWDNST, true];
	SERVER setVariable ["ticketsCount", parseNumber (_SEL_TICKETSCOUNT lbText (lbCurSel _SEL_TICKETSCOUNT)), true];
	SERVER setVariable ["wavesCount", parseNumber (_SEL_WAVESCOUNT lbText (lbCurSel _SEL_WAVESCOUNT)), true];
	SERVER setVariable ["wavesDelay", 35, true];
	SERVER setVariable ["startingWave", parseNumber (_SEL_STARTWAVE lbText (lbCurSel _SEL_STARTWAVE)), true];
	SERVER setVariable ["startingTime", parseNumber (_SEL_STARTTIME lbText (lbCurSel _SEL_STARTTIME)), true];

	if (SERVER getVariable "ChckbxMineFields") then 
	{
		{ _x call FS_FillMineField; _x setMarkerAlpha 1;} forEach ["MINES_N", "MINES_E", "MINES_S", "MINES_W"];
	};
	
	Ranks = nil;
	PARAMETERS_SET = TRUE;
	publicVariable "PARAMETERS_SET";
	
	// Saving parameters for next time
	profileNameSpace setVariable ["VRFORTRESS_WAVESCOUNT", lbCurSel _SEL_WAVESCOUNT];
	profileNameSpace setVariable ["VRFORTRESS_STARTWAVE", lbCurSel _SEL_STARTWAVE];
	profileNameSpace setVariable ["VRFORTRESS_STARTTIME", lbCurSel _SEL_STARTTIME];
	profileNameSpace setVariable ["VRFORTRESS_AISKILL", lbCurSel _SEL_AISKILL];
	profileNameSpace setVariable ["VRFORTRESS_TICKETSCOUNT", lbCurSel _SEL_TICKETSCOUNT];
	profileNameSpace setVariable ["VRFORTRESS_AILIMIT", lbCurSel _SEL_AILIMIT];
	profileNameSpace setVariable ["VRFORTRESS_SNOWDNST", lbCurSel _SEL_SNOWDNST];
	profileNameSpace setVariable ["VRFORTRESS_EnPerks", SERVER getVariable 'ChckbxEnPerks'];
	profileNameSpace setVariable ["VRFORTRESS_EnKS", SERVER getVariable 'ChckbxEnKS'];
	profileNameSpace setVariable ["VRFORTRESS_EnBoss", SERVER getVariable 'ChckbxEnBoss'];
	profileNameSpace setVariable ["VRFORTRESS_Endless", SERVER getVariable 'ChckbxEndless'];
	profileNameSpace setVariable ["VRFORTRESS_AIArt", SERVER getVariable 'ChckbxAIArt'];
	profileNameSpace setVariable ["VRFORTRESS_AIVeh", SERVER getVariable 'ChckbxAIVeh'];
	profileNameSpace setVariable ["VRFORTRESS_MineFields", SERVER getVariable 'ChckbxMineFields'];
	profileNameSpace setVariable ["VRFORTRESS_EnSnow", SERVER getVariable 'ChckbxEnSnow'];
};

#endif 