
waitUntil {!isNil {SERVER getVariable "ChckbxEndless"}};

if (SERVER getVariable "ChckbxEndless") then 
{
	_Journal_Endless = format ["<br/>%1<br/><br/>%2<br/><br/>%3<br/><br/>%4<br/><br/>", localize "STR_FS_ENDLESS_01", localize "STR_FS_ENDLESS_02", localize "STR_FS_ENDLESS_03", localize "STR_FS_ENDLESS_04"]; 

	player createDiaryRecord ["VRF", [localize "STR_FS_ENDLESS_TITLE", _Journal_Endless]];
	
	["RespawnAdded", [localize "STR_FS_SYSTEM_MSG_01", localize "STR_FS_SYSTEM_MSG_03","\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa"]] call BIS_fnc_showNotification;
	
	if (isServer) then 
	{
		waitUntil {SIM_START};
		ticketsCount = 0;
		SERVER setVariable ["ticketsCount", ticketsCount, true];
		wavesCount = 999;
		SERVER setVariable ["wavesCount", wavesCount, true];
			
		publicVariable "wavesCount";
		publicVariable "ticketsCount";
		
	};
};