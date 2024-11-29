bots_number_counter = instance_number(obj_antihero)
life_time_counter += 1

if ((life_time_counter / 60) >= 35){
	show_debug_message("stop")
	var _active_agent = instance_nearest(obj_spawnpos.x, obj_spawnpos.y, obj_antihero)
	if (instance_exists(_active_agent)){
		if (_active_agent.is_active){
			instance_destroy(_active_agent)
		}
	}
}

if (bots_number_counter <= 0 and !with_softmax){
	
	// destroy enemies
	with (obj_enemy){
		instance_destroy()
	}
	
	// destroy hearts
	with (obj_heart){
		instance_destroy()
	}
	
	// Create enemies again
	instance_create_layer(480, 544, "Instances", obj_pigun)
	instance_create_layer(1920, 2048, "Instances", obj_rooster)
	instance_create_layer(1920, 1344, "Instances", obj_pigun)
	instance_create_layer(3296, 384, "Instances", obj_pigun)
	
	
	// Create hearts again
	
	instance_create_layer(512, 1920, "Instances", obj_heart)
	instance_create_layer(1856, 160, "Instances", obj_heart)
	instance_create_layer(3360, 1952, "Instances", obj_heart)
	
	
	// Getting the index of the two best bots
	var _best_wb_index = get_max_index(bot_results)
	var _second_best_wb_index = get_second_max_index(bot_results)
	
	// Getting the weights of the best bot
	var _best_w = bot_weights[|_best_wb_index][0]
	var _best_b = bot_weights[|_best_wb_index][1]
	
	// Getting the weight of the second best bot
	var _second_best_w = bot_weights[|_second_best_wb_index][0]
	var _second_best_b = bot_weights[|_second_best_wb_index][1]
	
	ds_list_clear(bot_results)
	ds_list_clear(bot_weights)
	
	show_debug_message("Gen")
	show_debug_message(obj_optimizer.n_generations)
	
	show_debug_message("Best w (manager)")
	show_debug_message(_best_wb_index)
	show_debug_message(_best_w)
	show_debug_message(_best_b)
	
	show_debug_message("Second best w (manager)")
	show_debug_message(_second_best_wb_index)
	show_debug_message(_second_best_w)
	
	obj_optimizer.best_w = _best_w
	obj_optimizer.best_b = _best_b
	
	obj_optimizer.second_best_w = _second_best_w
	obj_optimizer.second_best_b = _second_best_b
	
	obj_optimizer.nextgen()

} 

if (bots_number_counter <= 0 and with_softmax) {
	
	// destroy enemies
	with (obj_enemy){
		instance_destroy()
	}
	
	// destroy hearts
	with (obj_heart){
		instance_destroy()
	}
	
	// Create enemies again
	instance_create_layer(480, 544, "Instances", obj_pigun)
	instance_create_layer(1920, 2048, "Instances", obj_pigun)
	instance_create_layer(1920, 1344, "Instances", obj_pigun)
	instance_create_layer(3296, 384, "Instances", obj_pigun)
	
	
	// Create hearts again
	
	instance_create_layer(512, 1920, "Instances", obj_heart)
	instance_create_layer(1856, 160, "Instances", obj_heart)
	instance_create_layer(3360, 1952, "Instances", obj_heart)
	
	
	// Getting the index of the two best bots
	
	var _prob_list = softmax(bot_results)
	var _best_wb_index = choose_weighted(_prob_list)
	
	// Getting the weights of the best bot
	var _best_w = bot_weights[|_best_wb_index][0]
	var _best_b = bot_weights[|_best_wb_index][1]
	
	ds_list_clear(bot_results)
	ds_list_clear(bot_weights)
	
	show_debug_message("Gen")
	show_debug_message(obj_optimizer.n_generations)
	show_debug_message("Best w (manager)")
	show_debug_message(_best_wb_index)
	show_debug_message(_best_w)
	show_debug_message(_best_b)
	
	
	obj_optimizer.best_w = _best_w
	obj_optimizer.best_b = _best_b
	
	obj_optimizer.nextgen()

}

