
// Level
laptop addAction [format ["<t color='#bbbbff'>%1</t>", localize "STR_FS_ProgressionMenu_CheckLVL"], {createDialog "ProgressionMenu"}, [], 9, true, true, "", ""];

if (SERVER getVariable "ChckbxEnPerks") then 
{
	// Activate Perk
	laptop addAction [format ["<t color='#ff00ff'>%1</t>", localize "STR_FS_ActivatePerk"], {createDialog "PerksMenu"}, [], 10, true, true, "", "!PERK_ASSIGNED"];
}
else 
{
	PERK_ASSIGNED = TRUE; 
};

// Create NPC
sattel addAction [format ["<t color='#bbbbff'>%1</t>", localize "STR_FS_CreateNPC"], {createDialog "BarracksMenu"}, [], 10, true, true, "", "(call FS_RefreshUnitsPool < BARRACKS_UNITSLIM)"];

// SAVE fortress
laptop addAction [format ["<t color='#66cc33'>%1</t>", localize "STR_FS_SAVEFORTRESS"], {createDialog "FortSaveMenu"}]; 

if (isServer) then
{
	// WIPE fortress
	laptop addAction [format ["<t color='#ff1111'>%1</t>", localize "STR_FS_WIPEFORTRESS"], {createDialog "FortWipeMenu"}]; 
	// LOAD fortress
	laptop addAction [format ["<t color='#ffcc00'>%1</t>", localize "STR_FS_LOADFORTRESS"], {createDialog "FortLoadMenu"}]; 
};

// VA
sattel addAction ["<t color='#66cc33'>Virtual Arsenal</t>", {['Open', true] call BIS_fnc_arsenal}, [], 10, true, true, "", "!(SERVER getVariable ['ChckbxEndless', FALSE]) || (SERVER getVariable ['ChckbxEndless', FALSE] && !SIM_START)"]; 

// Build menu
sattel addAction [format ["<t color='#ffcc00'>%1</t>", localize "STR_FS_OpenBuilder"], {createDialog "BuildMenu";}, [], 8, false, true, "", ""];