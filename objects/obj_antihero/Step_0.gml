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

// Set depth to minus our y position.
// This is also done in enemies, with the
// result being instances higher up on the screen
// being drawn first.
depth = -y;

// Check if died
if (hitpoints <= 0){
	instance_destroy()
}

// GAME CONFIGURATION ENDED


// Check if shield is down
if (hero_trail_cooldown - 1 <= 0){
	can_move = true
}


// Collide calcs
collide_up = place_meeting(x, y-15, obj_wall)
collide_down = place_meeting(x, y+15, obj_wall)
collide_left = place_meeting(x-15, y, obj_wall)
collide_right = place_meeting(x+15, y, obj_wall)


// Reduce cooldown timer for attacks
hero_shoot_cooldown -= delta_time * 0.000001;
hero_swipe_cooldown -= delta_time * 0.000001;
hero_trail_cooldown -= delta_time * 0.000001;


// Find the nearest things
nearest_target = instance_nearest(x, y, target);
nearest_heart = instance_nearest(x, y, obj_heart);
nearest_shoot = instance_nearest(x, y, obj_hero_bullet)

if (instance_exists(nearest_shoot)){
	if (nearest_shoot.is_from_player){
		nearest_shoot = noone
	} 
}

// GETTING SENSOR MEASUREMENTS

// Distance from targer
if (instance_exists(nearest_target)){
	d_nearest_target = point_distance(x, y, nearest_target.x, nearest_target.y)
	d_nearest_target = min(d_nearest_target, sensor_view_distance)
} else {
	d_nearest_target = sensor_view_distance
}

// Distance from heart
if (instance_exists(nearest_heart)){
	d_nearest_heart = point_distance(x, y, nearest_heart.x, nearest_heart.y)
	d_nearest_heart = min(d_nearest_heart, sensor_view_distance)
} else {
	d_nearest_heart = sensor_view_distance
}

// Distance from bullet
if (instance_exists(nearest_shoot)){
	d_nearest_shoot = point_distance(x, y, nearest_shoot.x, nearest_shoot.y)
	d_nearest_shoot = min(d_nearest_shoot, sensor_view_distance)
} else {
	d_nearest_shoot = sensor_view_distance
}

// If there is a wall between your target
if (instance_exists(nearest_target)){
	var _collist = ds_list_create()
	var _num = collision_line_list(x, y, nearest_target.x, nearest_target.y, obj_wall, false, true, _collist, true)
	b_wall_between_enemy = (_num > 0) ? true : false 
	ds_list_destroy(_collist)
} else {
	b_wall_between_enemy = false
}

// Bool sensors
health_sensor = hitpoints
b_shoot_ready = hero_shoot_cooldown <= 0
b_swipe_ready = hero_swipe_cooldown <= 0
b_trail_ready = hero_trail_cooldown <= 0

if (hero_trail_uses <= 0) b_trail_ready = false

if (is_active and is_alive){

get_player_input()
set_state()

}