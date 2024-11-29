is_alive = false
show_debug_message("Bot stats:")
show_debug_message(neural_network.w)
show_debug_message(neural_network.b)
obj_manager.send_data(neural_network.w, neural_network.b, hitpoints)
instance_destroy(neural_network)