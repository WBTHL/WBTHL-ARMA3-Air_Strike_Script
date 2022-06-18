_standByPos = [1584, 4950, 0];
tr1 setTriggerActivation ["ALPHA","PRESENT",false];

posGot = false;
hint "Open the map and click where you want to strike."
onMapSingleClick "target setPos _pos; posGot = true; false";

@posGot;
onMapSingleClick "";
hint "";
a1 sideChat "Target location received. Taking off. Out."
_marker = createMarker ["m1", getPos target];
"m1" setMarkerType "mil_destroy";
"m1" setMarkerColor "ColorRed";
"m1" setMarkerText "Strike Target";
a1 setFuel 1;
a1 doMove getPos target;

#TakeOff
? (getPos a1 select 2) < 20 : goto "TakeOff";
a1 sideChat "Taken off. Out.";
a1 flyInHeight 1000;

#Approach
? (a1 distance2D target) > 2500 : goto "Approach";
a1 sideChat "Approaching. Out.";

#Near
? (a1 distance2D target) > 1000 : goto "Near";
{a1 setPylonLoadout [_x, ""]} forEach [3, 4, 5, 6, 7, 8];
a1 sideChat "Bombs away. Returning to the base. Out.";
~10
_i = 0;
#Fire
"Bo_mk82" createVehicle [(getPos target select 0) + random(100) - 50, (getPos target select 1) + random(100) - 50, 0]
~0.2
_i = _i + 1;
? _i < 6 : goto "Fire";
deleteMarker "m1";
a1 landAt 0;

@a1 distance2D _standByPos < 3;
a1 setFuel 0;
{a1 setPylonLoadout [_x, "PylonMissile_1Rnd_Mk82_F"]} forEach [3, 4, 5, 6, 7, 8];
tr1 setTriggerActivation ["ALPHA","PRESENT",true];
hint "Air strike is now available.";
~5
hint "";
exit;