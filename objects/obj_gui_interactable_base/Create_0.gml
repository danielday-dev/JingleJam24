event_inherited();
depth--;

canInteractFunc = function() { return true; };
hoverable = false;
disabled = false;

if (!variable_global_exists("GUIElement_hovered") ||
	!variable_global_exists("GUIElement_active")) {
	globalvar GUIElement_hovered;
	GUIElement_hovered = noone;
	globalvar GUIElement_active;
	GUIElement_active = noone;
}