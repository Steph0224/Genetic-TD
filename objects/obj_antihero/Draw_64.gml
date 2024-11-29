if (is_active){
draw_text_transformed(150, 20, "target distance = " + string(1 - (d_nearest_target/sensor_view_distance)), 1, 1, 0)
draw_text_transformed(150, 50, "heart_distance = " + string(1 - (d_nearest_heart/sensor_view_distance)), 1, 1, 0)
draw_text_transformed(150, 80, "shoot distance = " + string(1 - (d_nearest_shoot/sensor_view_distance)), 1, 1, 0)
draw_text_transformed(150, 110, "health sensor = " + string(1 - (health_sensor/hitpoints_max)), 1, 1, 0)
draw_text_transformed(150, 140, "shoot ready = " + string(b_shoot_ready), 1, 1, 0)
draw_text_transformed(150, 170, "swipe ready = " + string(b_swipe_ready), 1, 1, 0)
draw_text_transformed(150, 200, "trail ready = " + string(b_trail_ready), 1, 1, 0)
draw_text_transformed(150, 230, "wall between = " + string(b_wall_between_enemy), 1, 1, 0)
}