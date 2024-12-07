if (!visible) return;

GUIElement_hoveredStack[array_length(GUIElement_hoveredStack)] = id;
if (GUIElement_active == noone || GUI_isActive()) {
	GUIElement_hovered = id;
} else {
	GUIElement_hovered = noone;
}
