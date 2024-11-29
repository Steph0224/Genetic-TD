// Adds two hitpoints as long as its not over max.
hitpoints = min(hitpoints + 2, hitpoints_max);

with (other){
	instance_destroy()
}