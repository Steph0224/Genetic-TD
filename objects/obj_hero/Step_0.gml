// If the game is paused...
if (global.paused)
{
	// Exit this event while paused.
	exit;
}

// Check if game is running.
if (instance_exists(obj_upgrade) || instance_exists(obj_template_complete) || instance_exists(obj_game_over))
{	
	// Stop moving the hero.
	speed = 0;

	// Exit event while on upgrade screen.
	exit;
}

if (hero_trail_cooldown - 1 <= 0){
	can_move = true
}

// Collide calcs
collide_up = place_meeting(x, y-15, obj_wall)
collide_down = place_meeting(x, y+15, obj_wall)
collide_left = place_meeting(x-15, y, obj_wall)
collide_right = place_meeting(x+15, y, obj_wall)

// Execute player movement function.
if (can_move){
	player_movement(collide_up, collide_down, collide_left, collide_right);
} else {
	hspeed = 0
	vspeed = 0
}


// Execute function that keeps the player in the room.
keep_in_room();

// Set depth to minus our y position.
// This is also done in enemies, with the
// result being instances higher up on the screen
// being drawn first.
depth = -y;

// Find the nearest enemy.
// And reset the distance to some high number.
nearest_enemy = instance_nearest(x, y, obj_enemy);
nearest_distance = 1000;

// If an enemy instance is found.
if (nearest_enemy)
{
	// Get the distance to that enemy.
	nearest_distance = point_distance(x, y, nearest_enemy.x, nearest_enemy.y);
}

// Reduce cooldown timer for attacks.
hero_shoot_cooldown -= delta_time * 0.000001;
hero_swipe_cooldown -= delta_time * 0.000001;
hero_trail_cooldown -= delta_time * 0.000001;

// Get mouse position
mouse_position_x =  device_mouse_x(0)
mouse_position_y =	device_mouse_y(0)

// Check if function cooldown is finished.
if ( mouse_check_button(mb_left) and hero_shoot_cooldown <= 0)
{
	// Call function.
	hero_shoot();	
}

// Check if function cooldown is finished.
if (mouse_check_button(mb_right) and hero_swipe_cooldown <= 0)
{
	// Call function.
	hero_swipe();	
}

// Check if function cooldown is finished.
if (keyboard_check_pressed(vk_space) and hero_trail_cooldown <= 0 and hero_trail_uses > 0)
{
	// Call function.
	hero_trail();
	can_move = false
	hero_trail_uses -= 1
}