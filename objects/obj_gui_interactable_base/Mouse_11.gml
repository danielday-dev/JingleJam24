var len = array_length(GUIElement_hoveredStack);
for (var i = 0; i < len; i++) {
	if (GUIElement_hoveredStack[i] == id) {
		array_delete(GUIElement_hoveredStack, i, 1);
		break;
	}
}

if (!GUI_isHovered()) return;

var len = array_length(GUIElement_hoveredStack);
if (len > 0 && GUIElement_active == noone) {
	GUIElement_hovered = GUIElement_hoveredStack[len - 1];
} else {
	GUIElement_hovered = noone;
}