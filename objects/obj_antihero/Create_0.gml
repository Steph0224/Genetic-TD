// Default state conf
state = 0

// Is active conf
is_active = false
is_alive = true

// Target conf and pathfinding
target = obj_enemy
health_target = obj_heart


// Colide conf
collide_up = false
collide_down = false
collide_left = false
collide_right = false

// Set the maximum hitpoints that the player can have.
hitpoints_max = 10;

// Set the starting hitpoints of the player (to the max).
hitpoints = hitpoints_max;

// Variables for tracking enemies.
nearest_enemy = undefined;
nearest_distance = 1000;
mouse_position_x = 0;
mouse_position_y = 0;

// Cooldowns for the weapon attacks (from frames to seconds).
hero_shoot_cooldown = 30 * (1 / 60);
hero_swipe_cooldown = 30 * (1 / 60);
hero_trail_cooldown = 30 * (1 / 60);
hero_trail_uses = 10

// Other confs
can_move = true


// SENSORS CONFIGURATION

// Preparing sight
sensor_view_distance = 1600

// Preparing sensors
nearest_target = noone
nearest_heart = noone
nearest_shoot = noone

// Preparing sensor measurments
d_nearest_target = sensor_view_distance
d_nearest_heart = sensor_view_distance
d_nearest_shoot = sensor_view_distance
health_sensor = hitpoints_max
b_shoot_ready = true
b_swipe_ready = true
b_trail_ready = true
b_wall_between_enemy = false



// Function for the shooting weapon.
hero_shoot = function()
{
	// Reset the cooldown for this weapon.
	hero_shoot_cooldown = max(global.shooting[? "attack_speed"], 1) * (1 / 60);

	// Execute the function to handle this weapon.
	shooting_attack_agent();
}

// Function for the swiping weapon
hero_swipe = function()
{	
	// Reset the cooldown for this weapon.
	hero_swipe_cooldown = max(global.swipe[? "attack_speed"], 1) * (1 / 60);
	
	// Execute the function that handles this weapon.
	swipe_attack();
}
	

// Function for the trail weapon
hero_trail = function()
{
	// Reset the cooldown for this weapon.
	hero_trail_cooldown = max(global.trail[? "attack_speed"], 1) * (1 / 60);
	hero_trail_uses -= 1
	// Execute the function that handles the weapon.
	attack_trail();
}


// Funcion para escapar del enemigo
hero_scape = function()
{	
	if (instance_exists(nearest_target)) {
    // Calcular la dirección opuesta a obj_hero
    var _dx = x - nearest_target.x;
    var _dy = y - nearest_target.y;
    
    // Calcular la distancia al obj_hero
    var _distance = point_distance(x, y, nearest_target.x, nearest_target.y);
    
    // Normalizar el vector para obtener la dirección
    if (_distance > 0) {
        _dx /= _distance;
        _dy /= _distance;
    }
    
    // Velocidad de alejamiento
    var _vel = 4;
    
    // Intentar mover al enemigo en la dirección opuesta
    var _new_x = x + _dx * _vel;
    var _new_y = y + _dy * _vel;
	
	 // Detección de colisiones
    if (!place_meeting(_new_x, _new_y, obj_wall)) {
        x = _new_x;
        y = _new_y;
    }
	
	}
}

// Funcion para perseguir enemigo
chase_target = function(){
	//show_debug_message("is targetting")
	if (instance_exists(nearest_target)){
		if (can_move){
			mp_potential_step_object(nearest_target.x, nearest_target.y, 5, obj_wall)
		}
		image_xscale = -sign(hspeed)
		if (image_xscale == 0){
			image_xscale = 1
		}
			image_yscale = 1
		}
	
}

// Funcion para perseguir vida
chase_health = function(){
	
	if (instance_exists(health_target)){
		if (can_move){
			mp_potential_step_object(nearest_heart.x, nearest_heart.y, 5, obj_wall)
		}
			image_xscale = -sign(hspeed)
		if (image_xscale == 0){
			image_xscale = 1
		}
			image_yscale = 1	
		}
}


// Funcion para designar el estado que se usara
set_state = function(){
	switch (state) {
		case 5:
			chase_health()
			break
		case 4:
			if (can_move) hero_scape()
			break;
		case 3:
			if (hero_trail_cooldown <= 0 and hero_trail_uses > 0) hero_trail()
			can_move = false
			break
		case 2:
			if (can_move) chase_target()
			break
		case 1:
			if (can_move) chase_target()
			if (hero_swipe_cooldown <= 0) hero_swipe()
			break
		case 0:
			if (hero_shoot_cooldown <= 0) hero_shoot()
			break
	}
}

// Create shadow object to follow.
var _shadow = instance_create_layer(x, y, "Shadows", obj_shadow);
// Set shadow owner.
_shadow.owner_object = self;




// NN CONFIGURATION

neural_network = instance_create_layer(x, y, "Instances", obj_nn)

function get_sensor_matrix(){
	var _matrix = create_random_matrix(neural_network.n_inputs, 1)
	_matrix[0][0] = 1 - (d_nearest_target/sensor_view_distance)
	_matrix[1][0] = 1 - (d_nearest_heart/sensor_view_distance)
	_matrix[2][0] = 1 - (d_nearest_shoot/sensor_view_distance)
	_matrix[3][0] = 1 - (health_sensor/hitpoints_max)
	_matrix[4][0] = int64(b_shoot_ready)
	_matrix[5][0] = int64(b_swipe_ready)
	_matrix[6][0] = int64(b_trail_ready)
	_matrix[7][0] = int64(b_wall_between_enemy)
	return _matrix
}

function get_player_input(){
	var _x = get_sensor_matrix()
	var _y = neural_network.evaluate(_x)
	var _max_state = get_max_arr_index(_y)
	state = _max_state
	//show_debug_message(state)
}