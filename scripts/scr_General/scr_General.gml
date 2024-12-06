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


function draw_number(_x, _y, _width, _height, _number, _gold = false, _figures = 1) {
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
		var len = array_length(numbers);
	}
	
	
	var baseColor = negative ? c_red : c_white;
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


