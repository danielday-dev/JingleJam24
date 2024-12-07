if (GUI_isHovered() && GUI_isActive()) event_user(0);
if (GUIElement_active == id) GUIElement_active = noone;

var len = array_length(GUIElement_hoveredStack);
if (len > 0) {
	GUIElement_hovered = GUIElement_hoveredStack[len - 1];
} else {
	GUIElement_hovered = noone;
}