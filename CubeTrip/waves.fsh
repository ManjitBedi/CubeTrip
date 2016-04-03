// Based on code from http://www.shadertoy.com.

void main() {
    
    // use the uniform provided by iOS
    vec2 uv = v_tex_coord;
    
    // the default color is black
    // or in other words, the background color will be black
    vec3 wave_color = vec3(0.0);
    
    // To create the waves
    float wave_width = 0.02;
    uv = -1.0 + 2.0 * uv;
    uv.y += 0.1;
    
    // create 3 waves
    for(float i = 0.0; i < 3.0; i++) {
        
        // vary the y position by adding u_time &
        // each wave's height is based on the previous wave's height
        uv.y += (0.07 * sin(uv.x + i/7.0 + u_time ));
        
        wave_width = abs(1.0 / (150.0 * uv.y));
        
        // the color of the wave will be a glowing white
        // the waves will blend into a ribbon like shape
        wave_color += vec3(wave_width * 3.0, wave_width *3.0, wave_width *3.0);
    }
    
    gl_FragColor = vec4(wave_color, 1.0);
}