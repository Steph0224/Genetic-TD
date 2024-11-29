initgen(n_players)

first_bot = instance_nearest(0, 0, obj_antihero)
if (instance_exists(obj_antihero)){
	first_bot.x = obj_spawnpos.x
	first_bot.y = obj_spawnpos.y
	first_bot.is_active = true
}