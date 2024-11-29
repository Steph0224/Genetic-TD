// The manager in charge of getting the rl going
with_softmax = false

hits_counter = 0
hearts_counter = 0
life_time_counter = 0
bots_number_counter = 10

bot_results = ds_list_create()
bot_weights = ds_list_create()

send_data = function(_w, _b, _hitpoints){
	var _wb = array_create(2)
	_wb[0] = _w
	_wb[1] = _b
	
	var _bonus = 0
	
	if (instance_number(obj_enemy) <= 0){
		_bonus += 10
	}
	
	if ((instance_number(obj_enemy) <= 0) and _hitpoints >= 4){
		_bonus += 5
	}
	
	if ((instance_number(obj_enemy) <= 0) and _hitpoints >= 6){
		_bonus += 10
	}
	
	var _efficiency = hits_counter + hearts_counter + ((life_time_counter / 60) / 2) + _bonus
	hits_counter = 0
	hearts_counter = 0
	life_time_counter = 0
	ds_list_add(bot_results, _efficiency) 
	ds_list_add(bot_weights, _wb)
	
	with (obj_enemy){
		instance_destroy()
	}
	
	with (obj_heart){
		instance_destroy()
	}
	
	with (obj_hero_bullet){
		instance_destroy()
	}
	
	// Create enemies again
	instance_create_layer(480, 544, "Instances", obj_rooster)
	instance_create_layer(1920, 2048, "Instances", obj_pigun)
	instance_create_layer(1920, 1344, "Instances", obj_pigun)
	instance_create_layer(3296, 384, "Instances", obj_pigun)
	
	// Create hearts again
	instance_create_layer(512, 1920, "Instances", obj_heart)
	instance_create_layer(1856, 160, "Instances", obj_heart)
	instance_create_layer(3360, 1952, "Instances", obj_heart)
	
	nearest_agent = instance_nearest(x, y, obj_antihero)
	if (instance_exists(nearest_agent)){
		nearest_agent.x = obj_spawnpos.x
		nearest_agent.y = obj_spawnpos.y
		nearest_agent.is_active = true
	}
}