event_inherited();
depth--;

if (!variable_global_exists("GUIElement_hoveredStack") ||
	!variable_global_exists("GUIElement_hovered") ||
	!variable_global_exists("GUIElement_active")) {
	globalvar GUIElement_hoveredStack;
	GUIElement_hoveredStack = []
	globalvar GUIElement_hovered;
	GUIElement_hovered = noone;
	globalvar GUIElement_active;
	GUIElement_active = noone;
}