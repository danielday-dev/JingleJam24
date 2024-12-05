// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function linear(t) {
	return t;	
}
function square(t) {
	return t * t;	
}
function flip(t){
	return 1 - t;
}

function ease(t){
	return lerp(ease_in(t), ease_out(t), t);
}
function ease_in(t) {
	return square(t);
}
function ease_out(t) {
	return flip(square(flip(t)));
}

function ease_sin(t) {
	return -(cos(pi * t) - 1) / 2;	
}
function ease_in_sin(t) {
  return 1 - cos((t * pi) / 2);
}

function ease_out_sin(t) {
  return sin((t * pi) / 2);
}
