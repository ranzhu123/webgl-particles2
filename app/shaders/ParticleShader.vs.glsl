#define PS_CAM_MAX_DIST 12.0
#define PS_MAX_SIZE 20.0
#define PS_SIZE_AT_MAX_DIST 3.0

uniform sampler2D tPos;
uniform float uTime;

varying vec3 vColor;

void main() {
    // animate color
    vColor = vec3(
        1.0,//-sin(uTime*2.0 + position.z*4.0),
        1.0,//cos(uTime*2.0 + position.z*4.0),
        sin(uTime*2.0 + position.z*4.0)
    ) / 2.0 + 0.5;

    vec4 posSample = texture2D(tPos, position.xy);
    vec3 pos = posSample.rgb;

    vec3 camToPos = pos - cameraPosition;
    float camDist = length(camToPos);

    // gl_PointSize = max(PS_MAX_SIZE*(1.0-camDist/PS_CAM_MAX_DIST), 1.0);
    gl_PointSize = max(PS_SIZE_AT_MAX_DIST * PS_CAM_MAX_DIST/camDist, 1.0);

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}