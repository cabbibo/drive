
uniform vec3 lightPos;
uniform float time;
uniform float timeMatMultiplier;
uniform float falloffPower;
uniform float falloffMultiplier;
uniform float eyeBand;
uniform sampler2D tNormal;
uniform sampler2D t_audio;

uniform vec3 color1;
uniform vec3 color2;
uniform vec3 color3;
uniform vec3 color4;

varying vec3 vNorm;
varying vec3 vPos;
varying vec4 vAudio;

varying float vDisplacement;
varying mat3 vNormalMat;
varying vec3 vLightDir;
varying vec3 vLightPos;
varying vec3 vView;
varying vec3 vMVPos;


varying float vAudioLookup;

void main(){ 

  vec3 nNormal = normalize( vNormalMat * vNorm  );
  vec3 nView = normalize(vView);
  vec3 nReflection = normalize( reflect( vView , nNormal )); 

  vec3 refl = reflect( vLightDir , nNormal );
  float facingRatio = abs( dot(  nNormal, refl) );

  vec4 dColor =  texture2D( t_audio , vec2(abs(sin( pow( length( vMVPos) ,3. )/ (eyeBand * 200000000.) ))  ,0. ));

  vec3 facing = dColor.xyz; //* facingRatio*facingRatio*facingRatio;
  vec3 nonFacing = dColor.xyz *  (1.-facingRatio)* (1.-facingRatio)* (1.-facingRatio);


  vec4 colorOuter =  (pow( vDisplacement ,3. ) / 100. ) * vec4(.5 * dColor.xyz + nonFacing, 1.0 );

  float d = min( 1. , max( 0. , pow( vDisplacement/ falloffMultiplier  , falloffPower ) ));

  vec3 displacementColor = color1 * ( 1. - d )  * dColor.xyz;
  vec3 dColor2 = color4 * (d )  * dColor.xyz;

  gl_FragColor = dColor * vAudio *  vec4(  facing * color2 + nonFacing * color3 + displacementColor + dColor2, 1. );// * dColor2;
   

}

