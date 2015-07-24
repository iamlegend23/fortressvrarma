
if (!isPlayer _this) exitWith {};

_markerType = "mil_dot";
_text = name _this;

_objmark = createMarker [format ["%1",_this], getPos _this];
_objmark setMarkerColor "colorBLUFOR";
_objmark setMarkerType _markerType;
_objmark setMarkerText _text;

while {alive _this} do 
{
	_objmark setMarkerPos getpos _this;
	sleep 0.1;
};

deleteMarker _objmark;
