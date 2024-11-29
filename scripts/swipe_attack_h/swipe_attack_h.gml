// Define function to execute a swipe attack.
function swipe_attack_h() 
{
	// Play attack sound effect.
	audio_play_sound(snd_attack_chimes_1, 0, 0, 1, undefined, 1.0);
	
	var _direction = point_direction(x, y, mouse_position_x, mouse_position_y);
	
	var _melee_offset_x = 0
		
	if (_direction < 91){
		_melee_offset_x = 150
	}
		
	if (_direction > 270 and _direction < 361){
		_melee_offset_x = 150
	}
	
	if (_direction > 90 and _direction < 181){
		_melee_offset_x = -150
	}
		
	if (_direction > 180 and _direction < 271){
		_melee_offset_x = -150
	}

	// Create the swipe attack object.
	instance_create_layer(x + _melee_offset_x, y, "Instances", obj_hero_swipe);
}