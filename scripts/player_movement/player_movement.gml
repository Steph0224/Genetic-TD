// Declare player movement script.
function player_movement(_collide_up, _collide_down, _collide_left, _collide_right) {
	// Set speed to 0.
	// We increase it again below.
	speed = 0;

	// If the W key is down...
	if (keyboard_check(ord("W")) and !_collide_up)
	{
		// Add -10 to vertical speed.
		vspeed += -10;
	}
	
	// If the S key is down...
	if (keyboard_check(ord("S")) and !_collide_down)
	{
		// Add 10 to vertical speed.
		vspeed += 10;
	}
	
	// If the A key is down...
	if (keyboard_check(ord("A")) and !_collide_left)
	{
		// Add -10 to horizontal speed.
		hspeed += -10;
	}

	// If the D key is down...
	if (keyboard_check(ord("D")) and !_collide_right)
	{
		// Add 10 to horizontal speed.
		hspeed += 10;
	}

	// Set the direction from the direction
	// from 0, 0 to hspeed, vspeed.
	direction = point_direction(x, y, x + hspeed, y + vspeed);

	// Set speed to a fixed value in the current direction.
	// This essentially normalizes the curent hspeed and vspeed values.
	speed = min(speed, 10);

	// If hspeed does not equal 0...
	if (hspeed != 0)
	{
		// Flip sprite horizontally based on hspeed.
		image_xscale = 1 * -sign(hspeed);
		image_yscale = 1;
	}

	// If sprite is not the hit sprite,
	// meaning the hero isn't currently being hit...
	if (sprite_index != spr_hero_hit)
	{
		// If speed is over 0...
		if (speed > 0)
		{
			// Set sprite to the running sprite.
			sprite_index = spr_hero_run;
			image_index += 0;
		}
	
		// Else speed is 0...
		else
		{
			// Set sprite to the idle sprite.
			sprite_index = spr_hero_idle;
			image_index += 0;
		}
	}
}