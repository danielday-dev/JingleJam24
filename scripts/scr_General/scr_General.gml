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