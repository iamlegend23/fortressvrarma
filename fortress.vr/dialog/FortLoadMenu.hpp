class FortLoadMenu 
{
	//A sample Dialog from a dialog tutorial
	idd = -1;
	movingEnable = false;
	controlsBackground[] = {};
	controls[] = {IGUIBack_2200, RscEdit_1400, RscButton_1600, RscButton_1601, RscText_1000};
	objects[] = {};

	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by Admin, v1.063, #Laqaru)
	////////////////////////////////////////////////////////
	
	class IGUIBack_2200: IGUIBack
	{
		idc = 2200;
		x = 8.5 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 15 * GUI_GRID_W;
		h = 6 * GUI_GRID_H;
	};
	class RscText_1000: RscText
	{
		idc = 1000;
		text = "VR FortLoader"; //--- ToDo: Localize;
		x = 9 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 13 * GUI_GRID_W;
		h = 2.5 * GUI_GRID_H;
		sizeEx = 1.5 * GUI_GRID_H;
	};
	class RscEdit_1400: RscEdit
	{
		idc = 1400;
		x = 9.5 * GUI_GRID_W + GUI_GRID_X;
		y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 13 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		tooltip = $STR_FS_FortCode; 
	};
	class RscButton_1600: RscButton
	{
		idc = 1600;
		text = $STR_FS_PERKS_DONE; // from Perks
		x = 10.5 * GUI_GRID_W + GUI_GRID_X;
		y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 4.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		
		action = "(ctrlText 1400) call FS_LoadFortress; closeDialog 0;";
	};
	class RscButton_1601: RscButton
	{
		idc = 1601;
		text = $STR_FS_Cancel;
		x = 15.5 * GUI_GRID_W + GUI_GRID_X;
		y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 6 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		
		action = "closeDialog 0;";
	};
	
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////
};