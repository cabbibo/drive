
varying vec3 vPos;
varying vec3 vNorm;
varying vec3 vMNorm;
varying vec3 vMPos;
varying vec3 vEye;

varying float fb;
uniform sampler2D t_audio;

void main(){

  vNorm = normal;
  vMNorm = normalize(normalMatrix * normal);
  vPos = position.xyz;

  vMPos = (modelMatrix * vec4( vPos ,1. )).xyz;

  vEye = cameraPosition - vMPos;

  fb = 0.;

  vec4 t =  modelViewMatrix * vec4( vPos , 1. );
  if( dot( normalize( t.xyz )  , normalize( vMNorm ) ) < 0. ){
    fb = 1.;
  }


  gl_Position = projectionMatrix * modelViewMatrix * vec4( position , 1. );
}
