shader_type canvas_item;


uniform vec2 direction = vec2(1,1);
//hollup do we even need directon, cannit be x or y or none? might want dir later tho.


uniform float deformationFactor = 1;

void vertex(){

	float spriteWidth = abs(VERTEX.x);
	
	vec2 scale = 1.0 - direction * deformationFactor; //cant be zero tho
	
	vec2 vertexOld = VERTEX;
	VERTEX.x = vertexOld.x * scale.x / scale.y;
	VERTEX.y = vertexOld.y * scale.y / scale.x;
//	VERTEX.xy += deformation * spriteWidth * 0.4;
	
}