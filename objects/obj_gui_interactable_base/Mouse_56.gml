if (!GUI_isActive()) return;
if (GUI_isHovered()) event_user(0);
GUIElement_active = noone;