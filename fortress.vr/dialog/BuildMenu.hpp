class BuildMenu 
{
	idd = -1;
	movingEnable = false;
	controlsBackground[] = {};
	controls[] = {IGUIBack_2200, RscListbox_1500, RscListbox_1501, RscButton_1600, RscButton_1601, RscText_1000};
	objects[] = {};
	onLoad = "_this call compile preprocessFileLineNumbers 'dialog\BuildMenu.sqf'";
	
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by Admin, v1.063, #Kaheji)
	////////////////////////////////////////////////////////

	class IGUIBack_2200: IGUIBack
	{
		idc = 2200;

		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 4 * GUI_GRID_H + GUI_GRID_Y;
		w = 37.5 * GUI_GRID_W;
		h = 17.5 * GUI_GRID_H;
	};
	class RscListbox_1500: RscListBox
	{
		idc = 1500;

		x = 2 * GUI_GRID_W + GUI_GRID_X;
		y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 17 * GUI_GRID_W;
		h = 12.5 * GUI_GRID_H;
	};
	class RscListbox_1501: RscListBox
	{
		idc = 1501;

		x = 19.5 * GUI_GRID_W + GUI_GRID_X;
		y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 12.5 * GUI_GRID_H;
	};
	class RscButton_1600: RscButton
	{
		idc = 1600;
		action = "[FS_FORTIFICATIONS select (lbCurSel 1500)] call FS_Construct_Item; closeDialog 0;";

		text = $STR_FS_BUILD_BUTTON;
		x = 6.5 * GUI_GRID_W + GUI_GRID_X;
		y = 20 * GUI_GRID_H + GUI_GRID_Y;
		w = 9 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class RscButton_1601: RscButton
	{
		idc = 1601;
		action = "[FS_OTHERSTUFF select (lbCurSel 1501)] call FS_Construct_Item; closeDialog 0;";

		text = $STR_FS_BUILD_BUTTON;
		x = 23.5 * GUI_GRID_W + GUI_GRID_X;
		y = 20 * GUI_GRID_H + GUI_GRID_Y;
		w = 9 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class RscText_1000: RscText
	{
		idc = 1000;

		text = $STR_FS_BUILD_CHOOSE; 
		x = 9.5 * GUI_GRID_W + GUI_GRID_X;
		y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 23.5 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		sizeEx = 1.5 * GUI_GRID_H;
	};
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////

};