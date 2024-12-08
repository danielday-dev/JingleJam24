function getDeltaTime(){
	return delta_time / 1000000.0;
}

function setGUIVisibility(_layerName, _visible) {
	if (!variable_global_exists("guiDict")) return;
	var elements = ds_map_find_value(global.guiDict, _layerName);
	if (elements == undefined) return;
	
	var len = array_length(elements);
	
	for (var i = 0; i < len; i++) {
		elements[i].visible = _visible;
	}
}
function registerGUIElement(_layerName, _id) {
	if (!variable_global_exists("guiDict")) 
		global.guiDict = ds_map_create(); 

	var arr = ds_map_find_value(global.guiDict, _layerName);
	if (arr == undefined) {
		arr = [ id ];	
		ds_map_add(global.guiDict, _layerName, arr);	
	} else {
		arr[array_length(arr)] = id;
	}
	
	id.depth = -9999;
	id.visible = false;
}

function draw_debugEnabled() {
	return keyboard_check(vk_f4);	
}

function draw_panel(_x, _y, _width, _height, state = 0, scale = 1.0) {
	var sprite = spr_gui_interactable_base;
	var tw = sprite_get_width(sprite) / 3, th = sprite_get_height(sprite) / 3;
	var tws = tw * scale, ths = th * scale;
	var right = _x + _width, bottom = _y + _height;
	
	draw_sprite_part_ext(sprite, state, 0, 0, tw, th, _x, _y, scale, scale, c_white, 1.0);
	draw_sprite_part_ext(sprite, state, tw * 2, th * 2, tw, th, right - tws, bottom - ths, scale, scale, c_white, 1.0);
	draw_sprite_part_ext(sprite, state, tw * 2, 0, tw, th, right - tws, _y, scale, scale, c_white, 1.0);
	draw_sprite_part_ext(sprite, state, 0, th * 2, tw, th, _x, bottom - ths, scale, scale, c_white, 1.0);

	var ow = _width - (tws * 2), oh = _height - (ths * 2);
	var ox = _x + tws, oy = _y + ths;
	var iw = ow / tw , ih = oh / th;

	draw_sprite_part_ext(sprite, state, tw, th, tw, th, ox, oy, iw, ih, c_white, 1.0);
	draw_sprite_part_ext(sprite, state, tw, 0, tw, th, ox, _y, iw, scale, c_white, 1.0);
	draw_sprite_part_ext(sprite, state, tw, th * 2, tw, th, ox, bottom - ths, iw, scale, c_white, 1.0);
	draw_sprite_part_ext(sprite, state, 0, th, tw, th, _x, oy, scale, ih, c_white, 1.);
	draw_sprite_part_ext(sprite, state, tw * 2, th, tw,th, right - tws, oy, scale, ih, c_white, 1.);
}

function draw_text_bound(_x, _y, _width, _height, _text, scale = 1.0, _color = make_color_rgb(246, 214, 189)) {
	if (draw_debugEnabled()) draw_rectangle(_x, _y, _x + _width, _y + _height, true);
	
	var sw = _width / scale, sh = _height / scale;
	var textWidth = string_width_ext(_text, -1, sw) * scale;
	var textHeight = string_height_ext(_text, -1, sw) * scale;
	
	var cx = _x + (_width * 0.5), cy = _y + (_height * 0.5);
	var sx = cx - (textWidth * 0.5), sy = cy - (textHeight * 0.5);
	//draw_text_ext_color(sx, sy, _text, -1, _width, _color, _color, _color, _color, 1.0);
	draw_text_ext_transformed_color(sx, sy, _text, -1, sw, scale, scale, 0, _color, _color, _color, _color, 1.0);
}

function draw_number(_x, _y, _width, _height, _number, _gold = false, _figures = 1, redOverwrite = false) {
	if (draw_debugEnabled()) draw_rectangle(_x, _y, _x + _width, _y + _height, true);
	
	var negative = _number < 0;
	_number = abs(_number);
	
	var numbers = [];
	var fraction = frac(_number);
	while (_number > 0) {
		array_insert(numbers, 0, floor(_number) mod 10);
		_number = floor(_number / 10);	
	}
	while (array_length(numbers) < _figures) {
		array_insert(numbers, 0, 0);
	}
	
	var allNine = true;
	var len = array_length(numbers);
	for (var i = 0; i < len && allNine; i++) 
		if (numbers[i] != 9)
			allNine = false;
	if (allNine && fraction > 0) {
		array_insert(numbers, 0, 0);
		len = array_length(numbers);
	}
	
	
	var baseColor = (negative || redOverwrite) ? c_red : c_white;
	var sprite = _gold ? spr_icons_numbers_gold : spr_icons_numbers;
	var spriteWidth = sprite_get_width(sprite);
	var spriteHeight = sprite_get_height(sprite);
	var partialHeight = spriteHeight * fraction;
	var invPartialHeight =  spriteHeight - partialHeight;
	
	var stride = spriteWidth;
	var scale = min(_width / (stride * len), _height / spriteHeight);
	stride *= scale;

	var offsetX = (_width - (stride * len)) * 0.5;
	var offsetY = (_height - (spriteHeight * scale)) * 0.5;
	
	
	var carryFraction = fraction != 0;
	for (var i = len - 1; i >= 0; i--) {
		var dx = _x + (i * stride) + offsetX;
		var dy = _y + offsetY;
		if (!carryFraction) {
			draw_sprite_ext(sprite, numbers[i], dx, dy, scale, scale, 0, baseColor, 1.0);
		} else {		
			draw_sprite_part_ext(sprite, numbers[i], 0, partialHeight, spriteWidth, invPartialHeight, dx, dy, scale, scale, baseColor, 1.0);
			draw_sprite_part_ext(sprite, (numbers[i] + 1) mod 10, 0, 0, spriteWidth, partialHeight, dx, dy + (invPartialHeight * scale), scale, scale, baseColor, 1.0);
			carryFraction = numbers[i] >= 9;
		}
	}
}

function draw_healthBar(_x, _y, _w, _h, _health, _maxHealth, _potentialDamage = 0) {
	draw_panel(_x, _y, _w, _h, 0, 0.5);
	var border = 6;
	
	var tw = _w - (border * 2), th = _h - (border * 2);
	
	var hpCol = make_color_rgb(246, 214, 189);
	var potentialHpCol = make_color_rgb(172, 107, 38);
	var backCol = make_color_rgb(8, 20, 30);
	draw_rectangle_color(_x + border, _y + border, _x + border + tw, _y + border + th, backCol, backCol, backCol, backCol, false);

	var hp = max(0, _health);
	if (_potentialDamage > 0) {
		var potentialHp = max(0, hp - _potentialDamage);
		if (hp > 0) draw_rectangle_color(_x + border, _y + border, _x + border + (tw * (hp / _maxHealth)), _y + border + th, potentialHpCol, potentialHpCol, potentialHpCol, potentialHpCol, false);
		if (potentialHp > 0) draw_rectangle_color(_x + border, _y + border, _x + border + (tw * (potentialHp / _maxHealth)), _y + border + th, hpCol, hpCol, hpCol, hpCol, false);
	} else if (_potentialDamage < 0) {
		var potentialHp = min(_maxHealth, hp - _potentialDamage);
		if (hp > 0) draw_rectangle_color(_x + border, _y + border, _x + border + (tw * (potentialHp / _maxHealth)), _y + border + th, potentialHpCol, potentialHpCol, potentialHpCol, potentialHpCol, false);
		if (potentialHp > 0) draw_rectangle_color(_x + border, _y + border, _x + border + (tw * (hp / _maxHealth)), _y + border + th, hpCol, hpCol, hpCol, hpCol, false);
	} else {
		if (hp > 0) draw_rectangle_color(_x + border, _y + border, _x + border + (tw * (hp / _maxHealth)), _y + border + th, hpCol, hpCol, hpCol, hpCol, false);
	}
	

}

