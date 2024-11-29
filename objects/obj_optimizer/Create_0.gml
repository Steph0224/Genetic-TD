n_players = 15
first_bot = noone
n_generations = 0
alarm_set(0, 1)
bots = ds_list_create()

function create_bot(){
		var _xoffset = random_range(-16, 16)
		var _bot = instance_create_layer(obj_startpos.x + _xoffset, obj_startpos.y, "Instances", obj_antihero)
		_bot.image_blend = make_color_hsv(random(255), 255, 255)
		return _bot
}

function initgen(_n){
	repeat(_n){
		var _bot = create_bot()
		ds_list_add(bots, _bot)		
	}
}

function nextgen(){
	
	ds_list_clear(bots)
	 
	 // Creating arrays copies
	 best_w_copy = matrix_copy(best_w)
	 best_b_copy = matrix_copy(best_b)
	 
	 best_w_copy_2 = matrix_copy(best_w)
	 best_b_copy_2 = matrix_copy(best_b)
	 
	
	initgen(n_players)
	
	
	for(var _i = 0; _i < n_players; _i++){
		var _pob = bots[|_i]
		if(_i < 1){
			_pob.neural_network.w = best_w_copy
			_pob.neural_network.b = best_b_copy
			_pob.x = obj_spawnpos.x
			_pob.y = obj_spawnpos.y
			_pob.is_active = true
		} else {
			
			var _offset = 0
			var _prob_w = 0
			var _prob_b = 0
			
			if (_i < n_players - 2){
				if (random(100) < 50){
				_offset = random_range(-2, 2) * choose(1, -1)
				_prob_w = 15
				_prob_b = 20
			} else {
				_offset = random_range(1, -1) * choose(1, -1)
				_prob_w = 35
				_prob_b = 15
			}
			
			if(random(100) < 20){
				_prob_w = 20
				_prob_b = 7
				_offset = random_range(0.5, -0.5) * choose(1, -1)
			}
			} else {
				_prob_w = 20
				_prob_b = 5
				_offset = random_range(-1.5, 1.5)
			}
			
			_pob.neural_network.w = mutate_matrix(best_w_copy_2, _prob_w, _offset)
			_pob.neural_network.b = mutate_matrix(best_b_copy_2, _prob_b, _offset)
		}
	}
	
	
	n_generations += 1
}


function nextgen_with_crossover(){
	
	ds_list_clear(bots)
	 
	 // Creating arrays copies
	 best_w_copy = matrix_copy(best_w)
	 best_b_copy = matrix_copy(best_b)
	 
	 best_w_copy_2 = matrix_copy(best_w)
	 best_b_copy_2 = matrix_copy(best_b)

	 best_w_copy_3 = matrix_copy(best_w)
	 best_b_copy_3 = matrix_copy(best_b)
	 
	 second_best_w_copy = matrix_copy(second_best_w)
	 second_best_b_copy = matrix_copy(second_best_b)
	 
	 // Getting crossovered offsprings
	 crossovered_w = one_point_crossover(best_w_copy_3, second_best_w_copy)
	 crossovered_b = one_point_crossover(best_b_copy_3, second_best_b_copy)
	
	
	initgen(n_players)
	
	
	for(var _i = 0; _i < n_players - 2; _i++){
		var _pob = bots[|_i]
		if(_i < 1){
			_pob.neural_network.w = best_w_copy
			_pob.neural_network.b = best_b_copy
			_pob.x = obj_spawnpos.x
			_pob.y = obj_spawnpos.y
			_pob.is_active = true
		} else {
			
			var _offset = 0
			var _prob_w = 0
			var _prob_b = 0
			
			if (_i < n_players - 4){
				if (random(100) < 50){
				_offset = random_range(-2, 2) * choose(1, -1)
				_prob_w = 15
				_prob_b = 20
			} else {
				_offset = random_range(1, -1) * choose(1, -1)
				_prob_w = 35
				_prob_b = 15
			}
			
			if(random(100) < 20){
				_prob_w = 20
				_prob_b = 7
				_offset = random_range(0.5, -0.5) * choose(1, -1)
			}
			} else {
				_prob_w = 20
				_prob_b = 5
				_offset = random_range(-1.5, 1.5)
			}
			
			_pob.neural_network.w = mutate_matrix(best_w_copy_2, _prob_w, _offset)
			_pob.neural_network.b = mutate_matrix(best_b_copy_2, _prob_b, _offset)
		}
	}
	
	// Adding crossover bots
	var _almost_last_bot = bots[|n_players - 2]
	var _last_bot = bots[|n_players - 1]
	
	_almost_last_bot.neural_network.w = crossovered_w[0]
	_almost_last_bot.neural_network.b = crossovered_b[0]
	_last_bot.neural_network.w = crossovered_w[1]
	_last_bot.neural_network.b = crossovered_b[1]
	
	n_generations += 1
}

best_w = noone
best_b = noone

second_best_w = noone
second_best_b = noone