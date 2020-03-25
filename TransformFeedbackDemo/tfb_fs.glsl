#version 430

layout(location = 0) out vec4 fragcolor;           
layout(location = 1) uniform float time;

void main(void)
{  
	//fragcolor = vec4(1.0,1.0,0.0,1.0);

	vec2 coord=gl_PointCoord.xy-vec2(0.3);//discard fragmnets that are out of this 
	float r=length(coord);

	if(r>0.5) discard;

	//fragcolor=vec4(r)*sin(time);//bubble like
    //fragcolor=vec4(r,0.0,0.1,1.0);
	
	if(gl_PointCoord.y>0.4)
    {
     fragcolor = vec4(1.0,0.0,r,1.0);
    }
  else{
     fragcolor=vec4(r,0.0,0.1,1.0);
  }
	
}




















