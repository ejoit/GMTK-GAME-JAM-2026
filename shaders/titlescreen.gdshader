shader_type canvas_item;
uniform float tile_size = 10.0;
uniform float gap = 0.2;
uniform float speed = 0.2;


void vertex() {
	UV.x += TIME * speed;
	UV.y += TIME * speed;
}
