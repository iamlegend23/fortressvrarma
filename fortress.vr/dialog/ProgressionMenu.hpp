
class ProgressionMenu 
{
	idd = 198345;
	movingEnable = false;
	controlsBackground[] = {};
	controls[] = {IGUIBack_2200, EnemiesKilledText, EnemiesKilledByYouText, EnemiesKilledTotalText, LvlProgressionSlider, PrevLvlName, NextLvlName, EnemiesKilledNumber, EnemiesKilledByYouNumber, EnemiesKilledTotalNumber};
	objects[] = {};
	onLoad = "_this call compile preprocessFileLineNumbers 'dialog\ProgressionMenu.sqf'";
	
	class _CT_PROGRESS
	{
		access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
		idc = CT_PROGRESS; // Control identification (without it, the control won't be displayed)
		type = CT_PROGRESS; // Type
		style = ST_LEFT; // Style
		default = 0; // Control selected by default (only one within a display can be used)
		blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

		texture = "#(argb,8,8,3)color(1,1,1,1)"; // Bar texture
		colorBar[] = {1,1,1,1}; // Bar color
		colorFrame[] = {0,0,0,1}; // Frame color

		tooltip = ""; // Tooltip text
		tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
		tooltipColorText[] = {1,1,1,1}; // Tooltip text color
		tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

		//onCanDestroy = "systemChat str ['onCanDestroy',_this]; true";
		//onDestroy = "systemChat str ['onDestroy',_this]; false";
	};
	
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by Admin, v1.063, #Jobohy)
	////////////////////////////////////////////////////////

	class IGUIBack_2200: IGUIBack
	{
		idc = 2200;
		x = 8.5 * GUI_GRID_W + GUI_GRID_X;
		y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 23 * GUI_GRID_W;
		h = 9.5 * GUI_GRID_H;
	};
	class EnemiesKilledText: RscText
	{
		idc = 1000;
		text = $STR_FS_ProgressionMenu_EnemiesKilled; 
		x = 9 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 13 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
	};
	class EnemiesKilledByYouText: RscText
	{
		idc = 1001;
		text = $STR_FS_ProgressionMenu_EnemiesKilledByYou; 
		x = 9 * GUI_GRID_W + GUI_GRID_X;
		y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 13 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
	};
	class EnemiesKilledTotalText: RscText
	{
		idc = 1002;
		text = $STR_FS_ProgressionMenu_EnemiesKilledTotal; 
		x = 9 * GUI_GRID_W + GUI_GRID_X;
		y = 4 * GUI_GRID_H + GUI_GRID_Y;
		w = 13 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
	};
	class LvlProgressionSlider: _CT_PROGRESS
	{
		idc = 1900;
		x = 9.5 * GUI_GRID_W + GUI_GRID_X;
		y = 8 * GUI_GRID_H + GUI_GRID_Y;
		w = 21 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class PrevLvlName: RscText
	{
		idc = 1003;
		text = ""; 
		x = 9.5 * GUI_GRID_W + GUI_GRID_X;
		y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 9.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class NextLvlName: RscText
	{
		idc = 1004;
		text = ""; 
		x = 25.5 * GUI_GRID_W + GUI_GRID_X;
		y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class EnemiesKilledNumber: RscText
	{
		idc = 1005;
		text = "0"; 
		x = 26.5 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 4.5 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
	};
	class EnemiesKilledByYouNumber: RscText
	{
		idc = 1006;
		text = "0"; 
		x = 26.5 * GUI_GRID_W + GUI_GRID_X;
		y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 4.5 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
	};
	class EnemiesKilledTotalNumber: RscText
	{
		idc = 1007;
		text = "0"; 
		x = 26.5 * GUI_GRID_W + GUI_GRID_X;
		y = 4 * GUI_GRID_H + GUI_GRID_Y;
		w = 4.5 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
	};
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////

};