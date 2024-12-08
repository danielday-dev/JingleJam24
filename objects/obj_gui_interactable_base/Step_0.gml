disabled = !canInteractFunc();
if (!visible || !hoverable || !GUI_canInteract()) {
	if (GUIElement_hovered == id) 
		GUIElement_hovered = noone;
	return;
}

if (GUIElement_hovered <= 0) // IDK WHY ITS NOT 'noone' BUT OKAY
	GUIElement_hovered = id;