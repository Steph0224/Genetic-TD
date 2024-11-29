// state conf
state = "idle"

// Create variable for max hitpoints.
hitpoints_max = 2 * global.enemy_health_bonus;

// Create variable for hitpoints.
hitpoints = hitpoints_max;

// Pathfinding conf
target = obj_antihero
health_target = obj_heart
nearest_heart = noone

// Bot behavior conf
nearest_target = undefined
nearest_target_d = 10000
sensor_distance = 1000

// Set weapons cooldown
enemy_shoot_cooldown = 30 * (1 / 60);
enemy_swipe_cooldown = 30 * (1 / 60);
enemy_trail_cooldown = 30 * (1 / 60);

// other confs
can_move = true

// Create variable to show/hide the healthbar.
show_healthbar = 0;

// Create shadow object to follow.
var _shadow = instance_create_layer(x, y, "Shadows", obj_shadow);
// Set shadow owner.
_shadow.owner_object = self;


enemy_shoot = function()
{
	// Reset the cooldown for this weapon.
	enemy_shoot_cooldown = max(global.shooting[? "attack_speed"], 1) * (1 / 60);

	// Execute the function to handle this weapon.
	shooting_attack();
}

// Function for the swiping weapon
enemy_swipe = function()
{	
	// Reset the cooldown for this weapon.
	enemy_swipe_cooldown = max(global.swipe[? "attack_speed"], 1) * (1 / 60);
	
	// Execute the function that handles this weapon.
	swipe_attack();
}

// Function for the swiping weapon
enemy_trail = function()
{	
	// Reset the cooldown for this weapon.
	enemy_trail_cooldown = max(global.trail[? "attack_speed"], 1) * (1 / 60);
	
	// Can't move while shielding
	can_move = false
	
	// Execute the function that handles this weapon.
	attack_trail();
}

// Function for the enemy to run away from the player
enemy_scape = function()
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

chase_target = function(){
	
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

decide_state = function(){
	if (hitpoints > hitpoints_max * 0.3){
		if (nearest_target) {
			state = (nearest_target_d < sensor_distance) ? "attack" : "idle"
		} else {
			state = "idle"
		}
	} else {
		state = "life"
	}
}

set_state = function(){
	switch (state) {
		case "idle":
			speed = 0.001
			break;
		case "attack":
			chase_target()
			if (enemy_swipe_cooldown <= 0) enemy_swipe()
			break;
		case "life":
			chase_health()	
	}
}