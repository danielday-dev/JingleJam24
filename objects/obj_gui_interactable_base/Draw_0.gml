var imageIndex = GUI_isHovered() | (GUI_isActive() << 1);
if (disabled) imageIndex = 4;

draw_panel(x, y, sprite_width, sprite_height, imageIndex);