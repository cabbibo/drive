varying vec3 vPos;
varying vec3 vNorm;
varying vec3 vMNorm;
varying vec3 vMPos;
varying vec3 vEye;
varying float fb;
uniform vec3 lightPos;

uniform float time;
uniform sampler2D t_audio;

uniform vec3 skullOut;
uniform vec3 skullIn;
$simplex

void main(){

   
  float t = atan( vNorm.z , vNorm.x );

  float l = abs( sin( t *4. ) );

  vec4 a2 = texture2D( t_audio , vec2( l , 0. ) );

  float al = length( a2 );
  float s = snoise( vPos * vec3( .0001 , .1 , .0001 ) + vec3( sin( time * .01 ) , cos(time * .04 ), cos( time * .07)) );
   if( abs(s) < al*al*.5 ){

    discard;
  }


  vec3 c = skullIn;

  if( fb < .5 ){
  
    c = skullOut;

  }

  gl_FragColor = vec4( c  , 1.);

}
