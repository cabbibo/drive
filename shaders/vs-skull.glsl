
varying vec3 vPos;
varying vec3 vNorm;
varying vec3 vMNorm;
varying vec3 vMPos;
varying vec3 vEye;

varying float fb;
uniform sampler2D t_audio;

void main(){

   
  float t = atan( vNorm.z , vNorm.x );
  float l = abs( sin( t *4. ) );
  vec4 a2 = texture2D( t_audio , vec2( l , 0. ) );

    vPos = position.xyz * vec3( 1. ,  length( a2 ) , 1. );

  vMPos = (modelMatrix * vec4( vPos ,1. )).xyz;

  vEye = cameraPosition - vMPos;

    vNorm = normal;
  vMNorm = normalize(normalMatrix * normal);

  fb = 0.;

  if( dot( normalize( vEye )  ,normal ) < 0. ){
    fb = 1.;
  }


  gl_Position = projectionMatrix * modelViewMatrix * vec4( vPos , 1. );
}
