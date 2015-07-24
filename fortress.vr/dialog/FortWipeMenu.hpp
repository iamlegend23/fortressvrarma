class FortWipeMenu 
{
	idd = -1;
	movingEnable = false;
	controlsBackground[] = {};
	controls[] = {IGUIBack_2200, RscText_1000, RscButton_1601, RscButton_1600, RscButton_1602, RscButton_1603};
	objects[] = {};

	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by Admin, v1.063, #Taquje)
	////////////////////////////////////////////////////////

	class IGUIBack_2200: IGUIBack
	{
		idc = 2200;

		x = 6.5 * GUI_GRID_W + GUI_GRID_X;
		y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 12 * GUI_GRID_W;
		h = 11.5 * GUI_GRID_H;
	};
	class RscText_1000: RscText
	{
		idc = 1000;

		text = $STR_FS_WipeMenu;
		x = 7.5 * GUI_GRID_W + GUI_GRID_X;
		y = 5 * GUI_GRID_H + GUI_GRID_Y;
		w = 9 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		sizeEx = 1.2 * GUI_GRID_H;
	};
	class RscButton_1601: RscButton
	{
		idc = 1600;
		action = "closeDialog 0;";

		text = $STR_FS_PERKS_DONE; // From perks
		x = 7.5 * GUI_GRID_W + GUI_GRID_X;
		y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 9 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
	};
	class RscButton_1600: RscButton
	{
		idc = 1600;
		action = "[true, false, false] call FS_WipeFortress;";

		text = $STR_FS_WipeMines;
		x = 7.5 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 9 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
	};
	class RscButton_1602: RscButton
	{
		idc = 1600;
		action = "[false, true, false] call FS_WipeFortress;";

		text = $STR_FS_WipeGraf;
		x = 7.5 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 9 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
	};
	class RscButton_1603: RscButton
	{
		idc = 1600;
		action = "[false, false, true] call FS_WipeFortress;";

		text = $STR_FS_WipeAll;
		x = 7.5 * GUI_GRID_W + GUI_GRID_X;
		y = 11 * GUI_GRID_H + GUI_GRID_Y;
		w = 9 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
	};
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////

};