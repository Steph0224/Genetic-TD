// If our hitpoints is over 0,
// AND we are not currently being hit.
if (sprite_index != spr_hero_hit)
{
	// Reduce hitpoints.
	hitpoints -= 1;

	// Create a text popup.
	var _text = instance_create_layer(x, y, "UpgradeScreen", obj_text_popup);
	// Set text for popup.
	_text.text = 1;
	// Set colour for popup.
	_text.color = c_red;
	
	// Change sprite index to hit.
	sprite_index = spr_hero_hit;
	// Reset image index.
	image_index = 0;
}