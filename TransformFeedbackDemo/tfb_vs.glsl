#version 440            

layout(location = 0) uniform mat4 PVM;
layout(location = 1) uniform float time;
layout(location = 2) uniform float slider = 0.5;
layout(location = 3) uniform float speedSlider = 0.005;

layout(location = 0) in vec3 pos_attrib;///particles
layout(location = 1) in vec3 vel_attrib;
layout(location = 2) in float age_attrib;



layout(xfb_buffer = 0) out;

layout(xfb_offset = 0, xfb_stride = 28) out vec3 pos_out; 
layout(xfb_offset = 12, xfb_stride = 28) out vec3 vel_out; 
layout(xfb_offset = 24, xfb_stride = 28) out float age_out;


//Basic velocity field
vec3 v0(vec3 p);

//pseudorandom number
float rand(vec2 co);

void main(void)
{
	//Draw current particles
	gl_Position = PVM*vec4(pos_attrib, 1.0);
	gl_PointSize = 10.0*slider;

	if(gl_VertexID>100 && gl_VertexID<1000){//this changes the size for some of them
	 gl_PointSize = 40.0*slider;
     }

	//Compute particle attributes for next frame
	vel_out = v0(pos_attrib);
	pos_out = pos_attrib + tan(speedSlider*0.1*vel_out*time);
	age_out = age_attrib - 1.0;

	//Reinitialize particles as needed
	if(age_out <= 0.0 || length(pos_out) > 2.0f)
	{
		vec2 seed = vec2(float(gl_VertexID), sin( time)); //seed for the random number generator

		age_out = 500.0 + 100.0*rand(seed);
		//Pseudorandom position
		pos_out = pos_attrib*0.0002 + 0.5*vec3(rand(seed.xx), rand(seed.yy), rand(seed.xy));
	}
}

vec3 v0(vec3 p)
{
	return vec3(sin(p.y*10.0+time-10.0), -sin(p.x*10.0+9.0*time+10.0), +cos(2.4*p.z+2.0*time));
}

float rand(vec2 co)
{
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

