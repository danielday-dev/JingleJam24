disabled = !canInteractFunc();
if (!visible || !hoverable || !GUI_canInteract()) {
	if (GUIElement_hovered == id) 
		GUIElement_hovered = noone;
	return;
}

if (GUIElement_hovered == noone) 
	GUIElement_hovered = id;