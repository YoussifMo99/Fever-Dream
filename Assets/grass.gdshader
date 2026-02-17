shader_type spatial;
render_mode cull_disabled;

uniform float sway = 1.14;
uniform float sway_ = 0.34;
uniform float sway_pow = 1.3;
uniform float grass_roughness = 0.3;
uniform float sway_noise_sampeling_scale = 0.12;
uniform float sway_time_scale = 0.2;
uniform vec3 sway_dir = vec3(1.0, 0.0, 1.0);
uniform sampler2D sway_noise : hint_default_white;
uniform float color_scale = 0.3;
uniform float color_grad_height = -0.5;
uniform vec4 top_color : source_color = vec4(0.2, 0.8, 0.2, 1.0);
uniform vec4 bot_color : source_color = vec4(0.1, 0.3, 0.1, 1.0);
uniform vec3 grass_scale = vec3(1.0, 1.0, 1.0);

varying vec3 vert;
varying float curent_wind;

float sclamp(float f, float sc) {
    return clamp(((f - 0.5) * sc) + 0.5, 0.0, 1.0);
}

void vertex() {
    // Get world position for noise sampling
    vec3 world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
    
    // Sample noise texture for wind variation
    vec2 noise_uv = world_pos.xz * sway_noise_sampeling_scale + TIME * sway_time_scale;
    float noise_sample = texture(sway_noise, noise_uv).r;
    
    // Apply wind sway - more at the top (based on UV.y)
    float sway_amount = pow(UV.y, sway_pow) * sway * noise_sample;
    VERTEX += normalize(sway_dir) * sway_amount;
    
    // Scale the grass
    VERTEX *= grass_scale;
    
    // Pass to fragment shader
    vert = VERTEX;
    curent_wind = noise_sample;
}

void fragment() {
    // Color gradient from bottom to top based on vertex height
    float height_factor = clamp((vert.y - color_grad_height) * color_scale, 0.0, 1.0);
    vec3 grass_color = mix(bot_color.rgb, top_color.rgb, height_factor);
    
    ALBEDO = grass_color;
    ROUGHNESS = grass_roughness;
}