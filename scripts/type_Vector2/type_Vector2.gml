function Vector2(_x, _y) constructor {
	x = _x;
    y = _y;
	
	static equal = function(_other) {
		return x == _other.x && y == _other.y;
    }
    static add = function(_other) {
		return new Vector2(x + _other.x, y + _other.y);
    }
    static subtract = function(_other) {
		return new Vector2(x - _other.x, y - _other.y);
    }
    static multiply = function(_other) {
		return new Vector2(x * _other.x, y * _other.y);
    }
    static divide = function(_other) {
		return new Vector2(x / _other.x, y / _other.y);
    }
    static dot = function(_other) {
		return (x * _other.x) + (y * _other.y);
    }
    static length = function() {
		return sqrt(self.dot(self));
    }
    static normal = function() {
		var length = self.length();
		return self.divide(new Vector2(length, length));
    }
    static angle = function() {
		var normal = self.normal();
		return arctan2(normal.x, normal.y);
    }
    static interpolate = function(_other, _t) {
		return new Vector2(
			lerp(x, _other.x, _t),
			lerp(y, _other.y, _t)
		);
    }
	static manhattan = function() {
		return abs(x) + abs(y);	
	}
}