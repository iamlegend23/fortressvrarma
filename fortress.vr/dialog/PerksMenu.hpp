
class PerksMenu 
{
	idd = -1;
	movingEnable = false;
	controlsBackground[] = {};
	controls[] = {IGUIBack_2200, RscText_1000, RscText_1001, RscText_1002, RscText_1003, RscText_1004, RscText_1005, RscText_1006, RscText_1007, RscText_1009, RscText_1010, RscCheckbox_2800, RscCheckbox_2801, RscCheckbox_2803, RscCheckbox_2806, RscCheckbox_2808, RscCheckbox_2809, Chckbx_WH, Chckbx_AutoHeal, Chckbx_CAS, RscButton_1600};
	objects[] = {};
	onLoad = "_this call compile preprocessFileLineNumbers 'dialog\PerksMenu.sqf'";
	
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by Admin, v1.063, #Qyzafo)
	////////////////////////////////////////////////////////


	class IGUIBack_2200: IGUIBack
	{
		idc = 2200;

		x = 6 * GUI_GRID_W + GUI_GRID_X;
		y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 17 * GUI_GRID_W;
		h = 12.5 * GUI_GRID_H;
	};
	class RscText_1000: RscText
	{
		idc = 1000;

		text = $STR_FS_PERKS;
		x = 7 * GUI_GRID_W + GUI_GRID_X;
		y = 5 * GUI_GRID_H + GUI_GRID_Y;
		w = 9 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		sizeEx = 1.5 * GUI_GRID_H;
	};
	class RscText_1001: RscText
	{
		idc = 1001;

		text = "Payback"; //--- ToDo: Localize;
		x = 7 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		tooltip = $STR_FS_PERK_PAYBACK; 
	};
	class RscText_1002: RscText
	{
		idc = 1002;

		text = "Artillery"; //--- ToDo: Localize;
		x = 7 * GUI_GRID_W + GUI_GRID_X;
		y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		tooltip = $STR_FS_PERK_Artillery;
	};
	class RscText_1004: RscText
	{
		idc = 1004;

		text = "Zeus's pet"; //--- ToDo: Localize;
		x = 7 * GUI_GRID_W + GUI_GRID_X;
		y = 10 * GUI_GRID_H + GUI_GRID_Y;
		w = 5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		tooltip = $STR_FS_PERK_ZEUSPET;
	};
	class RscText_1007: RscText
	{
		idc = 1007;

		text = "Deadshot"; //--- ToDo: Localize;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		tooltip = $STR_FS_PERK_DEADSHOT; //--- ToDo: Localize;
	};
	class RscText_1009: RscText
	{
		idc = 1009;

		text = "Mirror"; //--- ToDo: Localize;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		tooltip = $STR_FS_PERK_MIRROR;
	};
	class RscText_1010: RscText
	{
		idc = 1010;

		text = "Tickets++"; //--- ToDo: Localize;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 10 * GUI_GRID_H + GUI_GRID_Y;
		w = 5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		tooltip = $STR_FS_PERK_TICKETS;
	};
	class RscCheckbox_2800: RscCheckbox
	{
		idc = 2800;
		onButtonDown = "0 call FS_PerksMenu_Uncheck";

		x = 13 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class RscCheckbox_2801: RscCheckbox
	{
		idc = 2801;
		onButtonDown = "1 call FS_PerksMenu_Uncheck";

		x = 13 * GUI_GRID_W + GUI_GRID_X;
		y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class RscCheckbox_2803: RscCheckbox
	{
		idc = 2803;
		onButtonDown = "2 call FS_PerksMenu_Uncheck";

		x = 13 * GUI_GRID_W + GUI_GRID_X;
		y = 10 * GUI_GRID_H + GUI_GRID_Y;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class RscCheckbox_2806: RscCheckbox
	{
		idc = 2806;
		onButtonDown = "3 call FS_PerksMenu_Uncheck";

		x = 20.5 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class RscCheckbox_2808: RscCheckbox
	{
		idc = 2808;
		onButtonDown = "4 call FS_PerksMenu_Uncheck";

		x = 20.5 * GUI_GRID_W + GUI_GRID_X;
		y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class RscCheckbox_2809: RscCheckbox
	{
		idc = 2809;
		onButtonDown = "5 call FS_PerksMenu_Uncheck";

		x = 20.5 * GUI_GRID_W + GUI_GRID_X;
		y = 10 * GUI_GRID_H + GUI_GRID_Y;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class RscButton_1600: RscButton
	{
		idc = 1600;
		action = "call FS_SetPerk";

		text = $STR_FS_PERKS_DONE;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 15 * GUI_GRID_H + GUI_GRID_Y;
		w = 6.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class RscText_1003: RscText
	{
		idc = 1003;
		
		text = "Wallhack"; //--- ToDo: Localize;
		x = 7 * GUI_GRID_W + GUI_GRID_X;
		y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 6 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		tooltip = $STR_FS_PERK_Wallhack;
	};
	class Chckbx_WH: RscCheckbox
	{
		idc = 2802;
		onButtonDown = "6 call FS_PerksMenu_Uncheck";

		x = 13 * GUI_GRID_W + GUI_GRID_X;
		y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class RscText_1006: RscText
	{
		idc = 1006;

		text = "AutoHeal"; //--- ToDo: Localize;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 6 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		tooltip = $STR_FS_PERK_AutoHeal; //--- ToDo: Localize;
	};
	class Chckbx_AutoHeal: RscCheckbox
	{
		idc = 2804;
		onButtonDown = "7 call FS_PerksMenu_Uncheck";

		x = 20.5 * GUI_GRID_W + GUI_GRID_X;
		y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class RscText_1005: RscText
	{
		idc = 1005;

		text = "Aviator"; //--- ToDo: Localize;
		x = 7 * GUI_GRID_W + GUI_GRID_X;
		y = 13 * GUI_GRID_H + GUI_GRID_Y;
		w = 6 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		tooltip = $STR_FS_PERK_Aviator; //--- ToDo: Localize;
	};
	class Chckbx_CAS: RscCheckbox
	{
		idc = 2805;
		onButtonDown = "8 call FS_PerksMenu_Uncheck";

		x = 13 * GUI_GRID_W + GUI_GRID_X;
		y = 13 * GUI_GRID_H + GUI_GRID_Y;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
		
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////
};