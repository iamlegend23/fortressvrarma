disableSerialization;
 
_list1 = (_this select 0) displayCtrl 1500;
_list2 = (_this select 0) displayCtrl 1501;
 
FS_FORTIFICATIONS = ["Land_BagFence_Corner_F", "Land_BagFence_End_F", "Land_BagFence_Long_F", "Land_BagFence_Round_F", "Land_BagFence_Short_F", "Land_HBarrier_1_F", "Land_HBarrier_3_F", "Land_HBarrier_5_F", "Land_HBarrierBig_F", "Land_HBarrier_Big_F", "Land_HBarrierTower_F", "Land_HBarrierWall_corner_F", "Land_HBarrierWall_corridor_F", "Land_HBarrierWall4_F", "Land_HBarrierWall6_F", "Land_HBarrierWall_corridor_F", "CamoNet_BLUFOR_F", "CamoNet_BLUFOR_big_F", "Land_Razorwire_F", "Land_Wall_IndCnc_4_F" "Land_Mil_WallBig_4m_F", "Land_CncBarrierMedium_F", "Land_Canal_Wall_10m_F", "Land_Canal_WallSmall_10m_F", "BlockConcrete_F", "Land_Shoot_House_Panels_Window_F", "Land_Shoot_House_Tunnel_Stand_F", "Land_Shoot_House_Tunnel_F", "Land_Medevac_house_V1_F", "Land_Cargo_House_V2_F", "Land_Cargo_HQ_V2_F", "Land_Cargo_Patrol_V2_F", "Land_Cargo_Tower_V2_F", "Land_BarGate_F", "Land_Mil_WallBig_Gate_F", "Land_Mil_WallBig_4m_F", "Land_Mil_WallBig_Corner_F", "Land_BagBunker_Large_F", "Land_BagBunker_Small_F", "Land_BagBunker_Tower_F"];
 
{
        _list1 lbAdd gettext (configFile >> "CfgVehicles" >> _x >> "displayName");
        _list1 lbSetTooltip [_foreachindex, gettext (configFile >> "CfgVehicles" >> _x >> "_generalMacro")];
}
forEach FS_FORTIFICATIONS;
_list1 lbsetcursel 0;
 
//FS_OTHERSTUFF = ["Land_PierLadder_F", "Land_GH_Stairs_F", "Land_Obstacle_Ramp_F", "Land_Graffiti_01_F", "Land_Graffiti_03_F", "Land_Poster_01_F", "Land_FieldToilet_F", "Land_PhoneBooth_02_F", "Box_NATO_Grenades_F", "Box_NATO_AmmoOrd_F", "Box_NATO_Ammo_F", "Land_Target_Oval_F", "TargetP_Inf_Acc2_F", "B_Quadbike_01_F", "B_G_Offroad_01_F", "B_Heli_Light_01_F", "B_HMG_01_high_F", "B_GMG_01_high_F", "Land_PortableLight_single_F", "Land_PortableLight_double_F", "Land_FirePlace_F", "Land_CampingChair_V2_F", "Land_MetalBarrel_F", "B_Heli_Transport_03_unarmed_F", "C_Kart_01_F", "Flag_UK_F"];
 
FS_OTHERSTUFF = ["C_Hatchback_01_sport_F", "B_Quadbike_01_F", "B_G_Offroad_01_F", "Land_CargoBox_V1_F", "Land_Cargo20_blue_F", "Land_Cargo40_white_F", "Land_IronPipes_F", "Land_Pallet_F",  "B_Heli_Light_01_F", "B_HMG_01_high_F", "B_GMG_01_high_F", "B_Heli_Transport_03_unarmed_F", "C_Kart_01_F", "Land_SlideCastle_F", "Land_Carousel_01_F", "Land_Pallets_stack_F", "Flag_UK_F", "Land_PierLadder_F", "Land_GH_Stairs_F", "Land_RampConcrete_F", "Land_RampConcreteHigh_F", "Land_HelipadCircle_F", "Box_NATO_Wps_F", "Box_NATO_WpsSpecial_F", "Box_NATO_Ammo_F", "Box_NATO_AmmoOrd_F", "Box_NATO_Grenades_F", "Box_NATO_Support_F", "Land_FieldToilet_F", "PortableHelipadLight_01_blue_F","PortableHelipadLight_01_red_F","PortableHelipadLight_01_white_F","PortableHelipadLight_01_green_F","PortableHelipadLight_01_yellow_F", "Land_LampAirport_F", "Land_LampHalogen_F"];
 
{
        _list2 lbAdd gettext (configFile >> "CfgVehicles" >> _x >> "displayName");
        _list2 lbSetTooltip [_foreachindex, gettext (configFile >> "CfgVehicles" >> _x >> "_generalMacro")];
}
forEach FS_OTHERSTUFF;
_list2 lbsetcursel 0;
