shader_type spatial;

uniform float completion: hint_range(0, 1) = 0;
uniform vec4 INCOMPLETE_COLOR: source_color = vec4(0.16862745098,0.16862745098, 0.1725490196,0.5);
uniform vec4 COMPLETE_COLOR: source_color = vec4(0.97647058823, 0.65882352941, 0.0, 1.0);

void vertex() {
	if(completion >= 1.0) {
		vec3 u = vec3(sin(TIME/2.0), 0.0, 0.0);
		float s = cos(TIME/2.0);
		vec3 v = VERTEX;
		VERTEX = 2.0f * dot(u, v) * u
          + (s*s - dot(u, u)) * v
          + 2.0f * s * cross(u, v);;
	}
}

void fragment() {
	if(completion < 1.0) {
		if(completion * 10.0 >= 2.5*(VERTEX.x + 2.0)) {
			ALBEDO = COMPLETE_COLOR.rgb;
			ALPHA = COMPLETE_COLOR.a;
		} else if (completion * 10.0 >= floor(2.5*(VERTEX.x + 2.0))) {
			ALBEDO = INCOMPLETE_COLOR.rgb + (COMPLETE_COLOR.rgb - INCOMPLETE_COLOR.rgb) * (completion * 10.0 - floor(completion * 10.0));
			ALPHA = INCOMPLETE_COLOR.a + (COMPLETE_COLOR.a - INCOMPLETE_COLOR.a) * (completion * 10.0 - floor(completion * 10.0));
		} else {
			ALBEDO = INCOMPLETE_COLOR.rgb;
			ALPHA = INCOMPLETE_COLOR.a;
		}
	} else {
		ALBEDO = INCOMPLETE_COLOR.rgb + (COMPLETE_COLOR.rgb - INCOMPLETE_COLOR.rgb) * (((VERTEX.x + 2.0)*1.25 - TIME*2.0) - floor((VERTEX.x + 2.0)*1.25 - TIME*2.0));
		ALPHA = INCOMPLETE_COLOR.a + (COMPLETE_COLOR.a - INCOMPLETE_COLOR.a) * (((VERTEX.x + 2.0)*1.25 + TIME*2.0) - floor((VERTEX.x + 2.0)*1.25 + TIME*2.0));
	}
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
