class FortSaveMenu
{
	idd = -1;
	movingEnable = false;
	controlsBackground[] = {};
	controls[] = {IGUIBack_2200, RscEdit_1400, RscButton_1600, RscButton_1601, RscText_1000};
	objects[] = {};
	onLoad = "_this call compile preprocessFileLineNumbers 'dialog\FortSaveMenu.sqf'";

	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by Admin, v1.063, #Fajada)
	////////////////////////////////////////////////////////

	class IGUIBack_2200: IGUIBack
	{
		idc = 2200;
		x = 12.5 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 13.5 * GUI_GRID_W;
		h = 6.5 * GUI_GRID_H;
	};
	class RscText_1000: RscText
	{
		idc = 1000;
		text = "VR FortSaver"; //--- ToDo: Localize;
		x = 13 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 12.5 * GUI_GRID_W;
		h = 2 * GUI_GRID_H;
		sizeEx = 1.5 * GUI_GRID_H;
	};
	class RscEdit_1400: RscEdit
	{
		idc = 1400;
		x = 13.5 * GUI_GRID_W + GUI_GRID_X;
		y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 12 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
	};
	class RscButton_1600: RscButton
	{
		idc = 1600;
		text = $STR_FS_Copy; 
		x = 14 * GUI_GRID_W + GUI_GRID_X;
		y = 12 * GUI_GRID_H + GUI_GRID_Y;
		w = 3.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		
		action = "copyToClipboard (ctrlText 1400); closeDialog 0;";
	};
	class RscButton_1601: RscButton
	{
		idc = 1601;
		text = $STR_FS_Cancel;
		x = 18 * GUI_GRID_W + GUI_GRID_X;
		y = 12 * GUI_GRID_H + GUI_GRID_Y;
		w = 6.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		
		action = "closeDialog 0;";
	};
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////

};