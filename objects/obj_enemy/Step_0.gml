// Set depth to negative y.
// This will cause instances to draw from
// top to bottom.
depth = -y;

// Find the nearest enemy.
// And reset the distance to some high number.

nearest_target = instance_nearest(x, y, target);
nearest_target_d = 10000;

nearest_heart = instance_nearest(x, y, health_target)

if (nearest_target)
{
	// Get the distance to that enemy.
	nearest_target_d = point_distance(x, y, nearest_target.x, nearest_target.y);
}

decide_state()

if (enemy_trail_cooldown - 1 <= 0){
	can_move = true
}

// Reduce cooldown timer for attacks.
enemy_shoot_cooldown -= delta_time * 0.000001;
enemy_swipe_cooldown -= delta_time * 0.000001;
enemy_trail_cooldown -= delta_time * 0.000001;


set_state()