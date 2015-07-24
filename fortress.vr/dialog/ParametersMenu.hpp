class ParametersMenu 
{
	idd = 60012;
	movingEnable = false;
	controlsBackground[] = {};
	controls[] = {IGUIBack_2200, RscText_1000, RscText_1001, RscText_1002, RscText_1003, RscText_1004, RscText_1005, RscText_1006, RscText_1007, RscText_1008, RscText_1009, RscText_1010, RscText_1011, RscText_1012, RscText_1013, RscText_1014, RscText_1015, ChckbxEnPerks, ChckbxEnKS, ChckbxEnBoss, ChckbxEndless, ChckbxAIArt, ChckbxAIVeh, ChckbxMineFields, ChkbxEnSnow, SelStartWave, SelWavesCount, SelStartTime, SelAISkill, SelAILimit, SelTicketsCount, BtnDone, SelSnowDensity};
	objects[] = {};
	onLoad = "_this call compile preprocessFileLineNumbers 'dialog\ParametersMenu.sqf'";
	
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by Admin, v1.063, #Laxiky)
	////////////////////////////////////////////////////////

	class IGUIBack_2200: IGUIBack
	{
		idc = 2200;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 37.5 * GUI_GRID_W;
		h = 14.5 * GUI_GRID_H;
	};
	class RscText_1002: RscText
	{
		idc = 1002;
		text = $STR_FS_EnPerks;
		x = 2 * GUI_GRID_W + GUI_GRID_X;
		y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 8.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		sizeEx = 0.8 * GUI_GRID_H;
	};
	class RscText_1003: RscText
	{
		idc = 1003;
		text = $STR_FS_EnKS;
		x = 2 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 8.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		sizeEx = 0.8 * GUI_GRID_H;
	};
	class RscText_1004: RscText
	{
		idc = 1004;
		text = $STR_FS_EnBoss;
		x = 2 * GUI_GRID_W + GUI_GRID_X;
		y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 8.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		sizeEx = 0.8 * GUI_GRID_H;
	};
	class RscText_1005: RscText
	{
		idc = 1005;
		text = $STR_FS_StartTime; 
		x = 12.5 * GUI_GRID_W + GUI_GRID_X;
		y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		sizeEx = 0.8 * GUI_GRID_H;
	};
	class RscText_1006: RscText
	{
		idc = 1006;
		text = $STR_FS_WavesCount;
		x = 12.5 * GUI_GRID_W + GUI_GRID_X;
		y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		sizeEx = 0.8 * GUI_GRID_H;
	};
	class RscText_1007: RscText
	{
		idc = 1007;
		text = $STR_FS_StartWave;
		x = 12.5 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		sizeEx = 0.8 * GUI_GRID_H;
	};
	class RscText_1000: RscText
	{
		idc = 1000;
		text = $STR_FS_EndlessMode;
		x = 2 * GUI_GRID_W + GUI_GRID_X;
		y = 12 * GUI_GRID_H + GUI_GRID_Y;
		w = 8.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		sizeEx = 0.8 * GUI_GRID_H;
	};
	class RscText_1001: RscText
	{
		idc = 1001;
		text = $STR_FS_AISkill;
		x = 26 * GUI_GRID_W + GUI_GRID_X;
		y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 6 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		sizeEx = 0.8 * GUI_GRID_H;
	};
	class RscText_1008: RscText
	{
		idc = 1008;
		text = $STR_FS_AIArt;
		x = 26 * GUI_GRID_W + GUI_GRID_X;
		y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 9.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		sizeEx = 0.8 * GUI_GRID_H;
	};
	class RscText_1009: RscText
	{
		idc = 1009;
		text = $STR_FS_AIveh;
		x = 26 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 9.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		sizeEx = 0.8 * GUI_GRID_H;
	};
	class RscText_1010: RscText
	{
		idc = 1010;
		text = $STR_FS_TicketsCount; 
		x = 12.5 * GUI_GRID_W + GUI_GRID_X;
		y = 12 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		sizeEx = 0.8 * GUI_GRID_H;
	};
	class RscText_1011: RscText
	{
		idc = 1011;
		text = $STR_FS_PlaceMines; 
		x = 2 * GUI_GRID_W + GUI_GRID_X;
		y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 8.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		sizeEx = 0.8 * GUI_GRID_H;
	};
	class BtnDone: RscButton
	{
		idc = 1600;
		text = $STR_FS_PERKS_DONE;
		x = 14 * GUI_GRID_W + GUI_GRID_X;
		y = 16.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		action = "call FS_SetMissionParameters; closeDialog 0;";
	};
	class RscText_1012: RscText
	{
		idc = 1012;
		text = $STR_FS_AILimit;
		tooltip = $STR_FS_AILimit2;
		x = 26 * GUI_GRID_W + GUI_GRID_X;
		y = 12 * GUI_GRID_H + GUI_GRID_Y;
		w = 6 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		sizeEx = 0.8 * GUI_GRID_H;
	};
	class RscText_1013: RscText
	{
		idc = 1013;
		text = $STR_FS_Params; 
		x = 2 * GUI_GRID_W + GUI_GRID_X;
		y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 14.5 * GUI_GRID_W;
		h = 2 * GUI_GRID_H;
		sizeEx = 2 * GUI_GRID_H;
	};
	class RscText_1014: RscText
	{
		idc = 1014;

		text = $STR_FS_SnowDensity; 
		x = 12.5 * GUI_GRID_W + GUI_GRID_X;
		y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		sizeEx = 0.8 * GUI_GRID_H;
	};
	class RscText_1015: RscText
	{
		idc = 1015;
		text = $STR_FS_EnSnow;
		x = 2 * GUI_GRID_W + GUI_GRID_X;
		y = 15 * GUI_GRID_H + GUI_GRID_Y;
		w = 8.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		sizeEx = 0.8 * GUI_GRID_H;
	};
	class ChckbxEnPerks: RscCheckbox
	{
		idc = 2800;

		x = 10.5 * GUI_GRID_W + GUI_GRID_X;
		y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class ChckbxEnKS: RscCheckbox
	{
		idc = 2801;

		x = 10.5 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class ChckbxEnBoss: RscCheckbox
	{
		idc = 2802;

		x = 10.5 * GUI_GRID_W + GUI_GRID_X;
		y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class ChckbxEndless: RscCheckbox
	{
		idc = 2803;

		x = 10.5 * GUI_GRID_W + GUI_GRID_X;
		y = 12 * GUI_GRID_H + GUI_GRID_Y;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class ChckbxAIArt: RscCheckbox
	{
		idc = 2804;

		x = 36 * GUI_GRID_W + GUI_GRID_X;
		y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class ChkbxEnSnow: RscCheckbox
	{
		idc = 2807;

		x = 10.5 * GUI_GRID_W + GUI_GRID_X;
		y = 15 * GUI_GRID_H + GUI_GRID_Y;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class ChckbxAIVeh: RscCheckbox
	{
		idc = 2805;

		x = 36 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class ChckbxMineFields: RscCheckbox
	{
		idc = 2806;

		x = 10.5 * GUI_GRID_W + GUI_GRID_X;
		y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class SelWavesCount: RscCombo
	{
		idc = 2100;

		x = 19.5 * GUI_GRID_W + GUI_GRID_X;
		y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 5.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};

	class SelStartWave: RscCombo
	{
		idc = 2101;

		x = 19.5 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 5.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class SelStartTime: RscCombo
	{
		idc = 2102;

		x = 19.5 * GUI_GRID_W + GUI_GRID_X;
		y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 5.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class SelSnowDensity: RscCombo
	{
		idc = 2106;

		x = 19.5 * GUI_GRID_W + GUI_GRID_X;
		y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 5.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class SelAISkill: RscCombo
	{
		idc = 2103;

		x = 32 * GUI_GRID_W + GUI_GRID_X;
		y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class SelTicketsCount: RscCombo
	{
		idc = 2104;

		x = 19.5 * GUI_GRID_W + GUI_GRID_X;
		y = 12 * GUI_GRID_H + GUI_GRID_Y;
		w = 5.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class SelAILimit: RscCombo
	{
		idc = 2105;

		x = 32 * GUI_GRID_W + GUI_GRID_X;
		y = 12 * GUI_GRID_H + GUI_GRID_Y;
		w = 5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////

};