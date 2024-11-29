// Call parent event to set up general eney stuff.
event_inherited();

// Set animation speed.
image_speed = 1;

// Set max hitpoints for this enemy type.
hitpoints_max = 2 * global.enemy_health_bonus;

// Set hitpoints.
hitpoints = hitpoints_max;

// New variable needed
close_sensor_distance = 400

// Set sprites for this enemy type.
walk_sprite = spr_pumpkill_walk;
attack_sprite = spr_pumpkill_attack;
hit_sprite = spr_pumpkill_hit;

// Custom decide_state
decide_state = function(){
	if (nearest_target) {
		if (nearest_target_d < close_sensor_distance){
			state = "close_attack"
		} else {
			state = (nearest_target_d < sensor_distance) ? "ranged_attack" : "idle"
		}
	} else {
		state = "idle"
	}
	
}

// Custom set_state
set_state = function(){
	switch (state) {
		case "idle":
			speed = 0.001
			break;
		case "close_attack":
			chase_target()
			if (enemy_swipe_cooldown <= 0) enemy_swipe()
			break;
		case "ranged_attack":
			if (enemy_shoot_cooldown <= 0) enemy_shoot()
	}
}