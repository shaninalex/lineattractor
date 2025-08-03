shader_type canvas_item;

uniform vec4 circle_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float radius : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    vec2 uv = (UV - vec2(0.5)) * 2.0;
    float dist = length(uv);
    if (dist > radius) {
        discard;
    }
    COLOR = circle_color;
}
