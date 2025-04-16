#version 330

in vec2 texcoord;
uniform sampler2D tex;
uniform float opacity;

vec4 default_post_processing(vec4 c);

vec4 window_shader() {
    vec2 texsize = textureSize(tex, 0);
    vec4 color = texture2D(tex, texcoord / texsize, 0);

    // Convert to grayscale using luminance
    float gray = 0.2126 * color.r + 0.7152 * color.g + 0.0722 * color.b;

    // Increase contrast
    float contrast = 1; // Adjust this value to control contrast (1.0 = no change)
    gray = (gray - 0.5) * contrast + 0.5;

    // Clamp the result to avoid overshooting
    gray = clamp(gray, 0.0, 1.0);

    // Apply opacity
    color = vec4(vec3(gray) * opacity, color.a * opacity);

    return default_post_processing(color);
}
