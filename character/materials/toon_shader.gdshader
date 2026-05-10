shader_type spatial;

uniform sampler2D albedo_texture;

// Control artístico
uniform vec3 light_color : source_color = vec3(1.0);
uniform vec3 shadow_color : source_color = vec3(0.3);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec3 color = texture(albedo_texture, UV).rgb;
	ALBEDO = color;
}

void light() {
	//float light = dot(NORMAL, LIGHT);
	//float toon = step(0.5, light);
	//
	//vec3 final_light = mix(shadow_color, light_color, toon);
	//
	//DIFFUSE_LIGHT = vec3(final_light);
}
