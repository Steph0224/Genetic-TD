// Call parent event to set up general eney stuff.
event_inherited();

// Set animation speed.
image_speed = 1;

// Set max hitpoints specifically for this enemy type.
hitpoints_max = 3 * global.enemy_health_bonus;

// Set hitpoints specifically for this enemy type.
hitpoints = hitpoints_max;

// New variables needed
close_sensor_distance = 400
very_close_sensor_distance = 200

// Set sprites for this enemy type.
walk_sprite = spr_pigun_walk;
attack_sprite = spr_pigun_attack;
hit_sprite = spr_pigun_hit;

// Custom decide_state
decide_state = function(){
	if (hitpoints < hitpoints_max * 0.3){
		state = "life"
	} else {
		if (nearest_target){
			if (nearest_target_d < very_close_sensor_distance){
				state = "very_close_attack"
			} else {
				if (nearest_target_d < close_sensor_distance){
					state = "escape"
				} else {
					state = (nearest_target_d < sensor_distance) ? "ranged_attack" : "idle"
				}
			}
		} else {
			state = "idle"
		}
	}
}

// Custom set_state
set_state = function(){
	switch (state) {
		case "idle":
			speed = 0.001
			break;
		case "very_close_attack":
			chase_target()
			if (enemy_swipe_cooldown <= 0) enemy_swipe()
			break;
		case "escape":
			enemy_scape()
			break;
		case "ranged_attack":
			if (enemy_shoot_cooldown <= 0) enemy_shoot()
			break;
		case "life":
			chase_health()
	}
}