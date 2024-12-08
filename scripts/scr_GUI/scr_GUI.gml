function GUI_isHovered() {
	return GUIElement_hovered == id;	
}
function GUI_isActive() {
	return GUIElement_active == id;
}
function GUI_canInteract() {
	return !disabled && !Animator_isActive() && canInteractFunc();
}