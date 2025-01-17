#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4[] in_v0;  
layout(location = 1) in vec4[] in_v1;
layout(location = 2) in vec4[] in_v2;
layout(location = 3) in vec4[] in_up;

layout(location = 0) out vec4[] out_v0;
layout(location = 1) out vec4[] out_v1;
layout(location = 2) out vec4[] out_v2;
layout(location = 3) out vec4[] out_up;

#define TESS_LVL_INNER 5
#define TESS_LVL_OUTER 5


void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
    out_v0[gl_InvocationID] = in_v0[gl_InvocationID];
    out_v1[gl_InvocationID] = in_v1[gl_InvocationID];
    out_v2[gl_InvocationID] = in_v2[gl_InvocationID];
    out_up[gl_InvocationID] = in_up[gl_InvocationID];

	// TODO: Set level of tesselation
    float tessLvl = 0.f;
    vec3 camPos = inverse(camera.view)[3].xyz;
    float dist = length(in_v0[0].xyz - camPos);
    if (dist < 2.0) {
        tessLvl = 20.0;
    } else if (dist < 5.0) {
        tessLvl = 10.0;
    } else if (dist < 10.0) {
        tessLvl = 5.0;
    } else if (dist < 15.0) {
        tessLvl = 2.5;
    } else {
        tessLvl = 1.0;
    }

    gl_TessLevelInner[0] = tessLvl;
    gl_TessLevelInner[1] = tessLvl;

    gl_TessLevelOuter[0] = tessLvl;
    gl_TessLevelOuter[1] = tessLvl;
    gl_TessLevelOuter[2] = tessLvl;
    gl_TessLevelOuter[3] = tessLvl;
}
