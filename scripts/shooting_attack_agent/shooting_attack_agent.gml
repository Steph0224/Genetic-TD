// Define a function to execute the shooting attack.
function shooting_attack_agent() 
{
	// If an enemy is found...
	if (instance_exists(nearest_target))
	{
		// Get the direction from the hero to the enemy.
		var _direction = point_direction(x, y, nearest_target.x, nearest_target.y);
		
		var _shoot_offset_x = 0
		var _shoot_offset_y = 0
		
		if (_direction < 91){
			_shoot_offset_x = 30 * 1.5
			_shoot_offset_y = -50 * 1.5
		}
		
		if (_direction > 90 and _direction < 181){
			_shoot_offset_x = -40 * 1.5
			_shoot_offset_y = -50 * 1.5
		}
		
		if (_direction > 180 and _direction < 271){
			_shoot_offset_x = -40 * 1.5
			_shoot_offset_y = 0 
		}
		
		if (_direction > 270 and _direction < 361){
			_shoot_offset_x = 40 * 1.5
			_shoot_offset_y = 0
		}
	
		// Get the angle we should start creating bullets aiming towards.
		var _angle_difference = (global.shooting[? "number_of_shots"] - 1) * 20;
	
		// The starting angle.
		var _angle = -_angle_difference / 2;
	
		// Play the sound effect.
		audio_play_sound(snd_lightning_throw, 0, 0, 1, undefined, 1.0);
	
		// Create a bullet and assign it to temp variable _bullet.
		var _bullet = instance_create_layer(x, y, "Instances", obj_hero_bullet);
		_bullet.is_from_player = true
		
		// Change values of the bullet...
		with (_bullet) 
		{
			// Set the bullet's direction.
			direction = _direction + _angle;
			
			// Set speed of the bullet.
			speed = 30;
			
			// Rotate the bullet to face it's moving direction.
			image_angle = direction;
		}
	}
}