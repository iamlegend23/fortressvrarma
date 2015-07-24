
class BarracksMenu 
{
	idd = 60013;
	movingEnable = false;
	controlsBackground[] = {};
	objects[] = {};
	onLoad = "_this call compile preprocessFileLineNumbers 'dialog\BarracksMenu.sqf'";
	controls[]=
	{
		IGUIBack_2200,
		RscText_1000,
		RscText_1002,
		SelStance,
		RscText_1003,
		SelSide,
		RscText_1004,
		SelMove,
		RscText_1005,
		SelGroup,
		BtnOK,
		BtnCancel,
		RscListbox_1500
	};
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by Admin, v1.063, #Fakabe)
	////////////////////////////////////////////////////////

	class IGUIBack_2200: IGUIBack
	{
		idc = 2200;
		x = 7 * GUI_GRID_W + GUI_GRID_X;
		y = 6 * GUI_GRID_H + GUI_GRID_Y;
		w = 23.5 * GUI_GRID_W;
		h = 11.5 * GUI_GRID_H;
	};
	class RscText_1000: RscText
	{
		idc = 1000;
		text = $STR_FS_Barracks;
		x = 7.5 * GUI_GRID_W + GUI_GRID_X;
		y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 16 * GUI_GRID_W;
		h = 2 * GUI_GRID_H;
		sizeEx = 1.5 * GUI_GRID_H;
	};
	class RscText_1002: RscText
	{
		idc = 1002;
		text = $STR_FS_Barracks_Stance;
		x = 8 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class SelStance: RscCombo
	{
		idc = 2101;
		x = 13 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 6 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class RscText_1003: RscText
	{
		idc = 1003;
		text = $STR_FS_Barracks_Side;
		x = 8 * GUI_GRID_W + GUI_GRID_X;
		y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class SelSide: RscCombo
	{
		idc = 2102;
		x = 13 * GUI_GRID_W + GUI_GRID_X;
		y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 6 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class RscText_1004: RscText
	{
		idc = 1004;
		text = $STR_FS_Barracks_DisableMove;
		x = 8 * GUI_GRID_W + GUI_GRID_X;
		y = 12 * GUI_GRID_H + GUI_GRID_Y;
		w = 5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class SelMove: RscCombo
	{
		idc = 2103;
		x = 13 * GUI_GRID_W + GUI_GRID_X;
		y = 12 * GUI_GRID_H + GUI_GRID_Y;
		w = 6 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class RscText_1005: RscText
	{
		idc = 1005;
		text = $STR_FS_Barracks_Group;
		x = 8 * GUI_GRID_W + GUI_GRID_X;
		y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class SelGroup: RscCombo
	{
		idc = 2104;
		x = 13 * GUI_GRID_W + GUI_GRID_X;
		y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 6 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class BtnOK: RscButton
	{
		idc = 1600;
		text = $STR_FS_PERKS_DONE;
		x = 8.5 * GUI_GRID_W + GUI_GRID_X;
		y = 15.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		
		action = "call FS_CreateUnit; closeDialog 0;";
	};
	class BtnCancel: RscButton
	{
		idc = 1601;
		text = $STR_FS_Cancel;
		x = 14 * GUI_GRID_W + GUI_GRID_X;
		y = 15.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		
		action = "closeDialog 0";
	};
	class RscListbox_1500: RscListbox
	{
		idc = 1500;
		x = 20 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 9.5 * GUI_GRID_W;
		h = 7.5 * GUI_GRID_H;
	};
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////

};