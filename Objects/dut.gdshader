shader_type spatial;

instance uniform int bit_type = 0;

void vertex() {
	vec3 u = vec3(0.0, 0.0, sin(TIME));
		float s = cos(TIME);
		vec3 v = VERTEX;
		VERTEX = 2.0f * dot(u, v) * u
          + (s*s - dot(u, u)) * v
          + 2.0f * s * cross(u, v);
}

void fragment() {
	if (bit_type == 0) {
		ALBEDO = vec3(0.4,0.4,0.4);
	} else if (bit_type == 1) {
		ALBEDO = vec3(0.9,0.6,0.2);
	} else if (bit_type == 2) {
		ALBEDO = vec3(0.1,0.1,1.0);
	} else if (bit_type == 3) {
		ALBEDO = vec3(0.9,0.1,1.0);
	}
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
