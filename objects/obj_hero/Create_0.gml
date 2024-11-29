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

// Function for the shooting weapon.
hero_shoot = function()
{
	// Reset the cooldown for this weapon.
	hero_shoot_cooldown = max(global.shooting[? "attack_speed"], 1) * (1 / 60);

	// Execute the function to handle this weapon.
	shooting_attack_h();
}

// Function for the swiping weapon
hero_swipe = function()
{	
	// Reset the cooldown for this weapon.
	hero_swipe_cooldown = max(global.swipe[? "attack_speed"], 1) * (1 / 60);
	
	// Execute the function that handles this weapon.
	swipe_attack_h();
}
	

// Function for the trail weapon
hero_trail = function()
{
	// Reset the cooldown for this weapon.
	hero_trail_cooldown = max(global.trail[? "attack_speed"], 1) * (1 / 60);

	// Execute the function that handles the weapon.
	attack_trail_h();
}

// Create shadow object to follow.
var _shadow = instance_create_layer(x, y, "Shadows", obj_shadow);
// Set shadow owner.
_shadow.owner_object = self;