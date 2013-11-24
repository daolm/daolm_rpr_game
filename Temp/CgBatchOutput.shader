Shader "DiffSpecNormal"
{
	Properties 
	{
_Diffuse("_Diffuse", 2D) = "gray" {}
_Normal("_Normal", 2D) = "bump" {}
_Specular("Specular", 2D) = "black" {}
_Specular_Power("Specular_Power", Range(0,1) ) = 0.5
_MainColor("Main Color", Color) = (1,1,1,1)

	}
	
	SubShader 
	{
		Tags
		{
"Queue"="Geometry"
"IgnoreProjector"="False"
"RenderType"="Opaque"

		}

		
Cull Back
ZWrite On
ZTest LEqual
ColorMask RGBA
Fog{
}


			
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }
Program "vp" {
// Vertex combos: 9
//   opengl - ALU: 8 to 81
//   d3d9 - ALU: 8 to 84
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_Diffuse_ST]
Vector 24 [_Normal_ST]
Vector 25 [_Specular_ST]
"!!ARBvp1.0
# 45 ALU
PARAM c[26] = { { 1 },
		state.matrix.mvp,
		program.local[5..25] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[22].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MOV R0.w, c[0].x;
MUL R1, R0.xyzz, R0.yzzx;
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.w, R2, R2;
MAD R0.w, R0.x, R0.x, -R0;
DP4 R0.z, R1, c[20];
DP4 R0.y, R1, c[19];
DP4 R0.x, R1, c[18];
ADD R0.xyz, R2, R0;
MUL R1.xyz, R0.w, c[21];
ADD result.texcoord[3].xyz, R0, R1;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[22].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[14];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP3 result.texcoord[2].y, R3, R1;
DP3 result.texcoord[4].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[25], c[25].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 45 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 21 [unity_Scale]
Vector 22 [_Diffuse_ST]
Vector 23 [_Normal_ST]
Vector 24 [_Specular_ST]
"vs_2_0
; 48 ALU
def c25, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c21.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mov r0.w, c25.x
mul r1, r0.xyzz, r0.yzzx
dp4 r2.z, r0, c16
dp4 r2.y, r0, c15
dp4 r2.x, r0, c14
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp4 r0.z, r1, c19
dp4 r0.y, r1, c18
dp4 r0.x, r1, c17
mul r1.xyz, r0.w, c20
add r0.xyz, r2, r0
add oT3.xyz, r0, r1
mov r0.w, c25.x
mov r0.xyz, c12
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c21.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
mov r1, c8
dp4 r4.y, c13, r0
dp4 r4.x, c13, r1
dp3 oT2.y, r4, r2
dp3 oT4.y, r2, r3
dp3 oT2.z, v2, r4
dp3 oT2.x, r4, v1
dp3 oT4.z, v2, r3
dp3 oT4.x, v1, r3
mad oT0.zw, v3.xyxy, c23.xyxy, c23
mad oT0.xy, v3, c22, c22.zwzw
mad oT1.xy, v3, c24, c24.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (tmpvar_7 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_14;
  mediump vec4 normal_15;
  normal_15 = tmpvar_13;
  highp float vC_16;
  mediump vec3 x3_17;
  mediump vec3 x2_18;
  mediump vec3 x1_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHAr, normal_15);
  x1_19.x = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAg, normal_15);
  x1_19.y = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAb, normal_15);
  x1_19.z = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normal_15.xyzz * normal_15.yzzx);
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHBr, tmpvar_23);
  x2_18.x = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBg, tmpvar_23);
  x2_18.y = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBb, tmpvar_23);
  x2_18.z = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y));
  vC_16 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = (unity_SHC.xyz * vC_16);
  x3_17 = tmpvar_28;
  tmpvar_14 = ((x1_19 + x2_18) + x3_17);
  shlight_3 = tmpvar_14;
  tmpvar_6 = shlight_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = (tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 Tex2D2_5;
  highp vec4 UnpackNormal0_6;
  highp vec4 Tex2D0_7;
  highp vec4 Tex2D1_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_7 = tmpvar_10;
  lowp vec4 packednormal_11;
  packednormal_11 = Tex2D0_7;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = ((packednormal_11.xyz * 2.0) - 1.0);
  UnpackNormal0_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Specular, xlv_TEXCOORD1);
  Tex2D2_5 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (_MainColor * Tex2D1_8).xyz;
  tmpvar_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = UnpackNormal0_6.xyz;
  tmpvar_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (Tex2D2_5 * vec4(_Specular_Power)).xyz;
  tmpvar_4 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_3);
  tmpvar_3 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  mediump vec3 lightDir_19;
  lightDir_19 = xlv_TEXCOORD2;
  mediump vec3 viewDir_20;
  viewDir_20 = tmpvar_18;
  mediump vec4 res_21;
  highp float nh_22;
  mediump float tmpvar_23;
  tmpvar_23 = max (0.0, dot (tmpvar_17, normalize((lightDir_19 + viewDir_20))));
  nh_22 = tmpvar_23;
  res_21.xyz = (_LightColor0.xyz * max (0.0, dot (lightDir_19, tmpvar_17)));
  lowp float tmpvar_24;
  tmpvar_24 = dot (_LightColor0.xyz, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_25;
  tmpvar_25 = (pow (nh_22, 0.0) * tmpvar_24);
  res_21.w = tmpvar_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = (res_21 * 2.0);
  res_21 = tmpvar_26;
  mediump vec4 c_27;
  c_27.xyz = ((tmpvar_2 * tmpvar_26.xyz) + (tmpvar_26.xyz * (tmpvar_26.w * tmpvar_4)));
  c_27.w = 1.0;
  c_1 = c_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (c_1.xyz + (tmpvar_2 * xlv_TEXCOORD3));
  c_1.xyz = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = c_1.xyz;
  c_1.xyz = tmpvar_29;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (tmpvar_7 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_14;
  mediump vec4 normal_15;
  normal_15 = tmpvar_13;
  highp float vC_16;
  mediump vec3 x3_17;
  mediump vec3 x2_18;
  mediump vec3 x1_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHAr, normal_15);
  x1_19.x = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAg, normal_15);
  x1_19.y = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAb, normal_15);
  x1_19.z = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normal_15.xyzz * normal_15.yzzx);
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHBr, tmpvar_23);
  x2_18.x = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBg, tmpvar_23);
  x2_18.y = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBb, tmpvar_23);
  x2_18.z = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y));
  vC_16 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = (unity_SHC.xyz * vC_16);
  x3_17 = tmpvar_28;
  tmpvar_14 = ((x1_19 + x2_18) + x3_17);
  shlight_3 = tmpvar_14;
  tmpvar_6 = shlight_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = (tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 Tex2D2_5;
  highp vec4 UnpackNormal0_6;
  highp vec4 Tex2D0_7;
  highp vec4 Tex2D1_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_7 = tmpvar_10;
  lowp vec4 packednormal_11;
  packednormal_11 = Tex2D0_7;
  lowp vec3 normal_12;
  normal_12.xy = ((packednormal_11.wy * 2.0) - 1.0);
  normal_12.z = sqrt((1.0 - clamp (dot (normal_12.xy, normal_12.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = normal_12;
  UnpackNormal0_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Specular, xlv_TEXCOORD1);
  Tex2D2_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (_MainColor * Tex2D1_8).xyz;
  tmpvar_2 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = UnpackNormal0_6.xyz;
  tmpvar_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (Tex2D2_5 * vec4(_Specular_Power)).xyz;
  tmpvar_4 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_3);
  tmpvar_3 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(xlv_TEXCOORD4);
  mediump vec3 lightDir_20;
  lightDir_20 = xlv_TEXCOORD2;
  mediump vec3 viewDir_21;
  viewDir_21 = tmpvar_19;
  mediump vec4 res_22;
  highp float nh_23;
  mediump float tmpvar_24;
  tmpvar_24 = max (0.0, dot (tmpvar_18, normalize((lightDir_20 + viewDir_21))));
  nh_23 = tmpvar_24;
  res_22.xyz = (_LightColor0.xyz * max (0.0, dot (lightDir_20, tmpvar_18)));
  lowp float tmpvar_25;
  tmpvar_25 = dot (_LightColor0.xyz, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_26;
  tmpvar_26 = (pow (nh_23, 0.0) * tmpvar_25);
  res_22.w = tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = (res_22 * 2.0);
  res_22 = tmpvar_27;
  mediump vec4 c_28;
  c_28.xyz = ((tmpvar_2 * tmpvar_27.xyz) + (tmpvar_27.xyz * (tmpvar_27.w * tmpvar_4)));
  c_28.w = 1.0;
  c_1 = c_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (c_1.xyz + (tmpvar_2 * xlv_TEXCOORD3));
  c_1.xyz = tmpvar_29;
  mediump vec3 tmpvar_30;
  tmpvar_30 = c_1.xyz;
  c_1.xyz = tmpvar_30;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 21 [unity_Scale]
Vector 22 [_Diffuse_ST]
Vector 23 [_Normal_ST]
Vector 24 [_Specular_ST]
"agal_vs
c25 1.0 0.0 0.0 0.0
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaabfaaaappabaaaaaa mul r1.xyz, a1, c21.w
bcaaaaaaacaaaiacabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r2.w, r1.xyzz, c5
bcaaaaaaaaaaabacabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r0.x, r1.xyzz, c4
bcaaaaaaaaaaaeacabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r0.z, r1.xyzz, c6
aaaaaaaaaaaaacacacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r2.w
aaaaaaaaaaaaaiacbjaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c25.x
adaaaaaaabaaapacaaaaaakeacaaaaaaaaaaaacjacaaaaaa mul r1, r0.xyzz, r0.yzzx
bdaaaaaaacaaaeacaaaaaaoeacaaaaaabaaaaaoeabaaaaaa dp4 r2.z, r0, c16
bdaaaaaaacaaacacaaaaaaoeacaaaaaaapaaaaoeabaaaaaa dp4 r2.y, r0, c15
bdaaaaaaacaaabacaaaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 r2.x, r0, c14
adaaaaaaaaaaaiacacaaaappacaaaaaaacaaaappacaaaaaa mul r0.w, r2.w, r2.w
adaaaaaaadaaaiacaaaaaaaaacaaaaaaaaaaaaaaacaaaaaa mul r3.w, r0.x, r0.x
acaaaaaaaaaaaiacadaaaappacaaaaaaaaaaaappacaaaaaa sub r0.w, r3.w, r0.w
bdaaaaaaaaaaaeacabaaaaoeacaaaaaabdaaaaoeabaaaaaa dp4 r0.z, r1, c19
bdaaaaaaaaaaacacabaaaaoeacaaaaaabcaaaaoeabaaaaaa dp4 r0.y, r1, c18
bdaaaaaaaaaaabacabaaaaoeacaaaaaabbaaaaoeabaaaaaa dp4 r0.x, r1, c17
adaaaaaaabaaahacaaaaaappacaaaaaabeaaaaoeabaaaaaa mul r1.xyz, r0.w, c20
abaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaadaaahaeaaaaaakeacaaaaaaabaaaakeacaaaaaa add v3.xyz, r0.xyzz, r1.xyzz
aaaaaaaaaaaaaiacbjaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c25.x
aaaaaaaaaaaaahacamaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c12
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r1.z, r0, c10
bdaaaaaaabaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r1.y, r0, c9
bdaaaaaaabaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r1.x, r0, c8
adaaaaaaaeaaahacabaaaakeacaaaaaabfaaaappabaaaaaa mul r4.xyz, r1.xyzz, c21.w
acaaaaaaadaaahacaeaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r4.xyzz, a0
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaaaaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r0.yzxx
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaafaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r5.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacafaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r5.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaaeaaaeacanaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c13, r0
aaaaaaaaaaaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c9
aaaaaaaaabaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c8
bdaaaaaaaeaaacacanaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.y, c13, r0
bdaaaaaaaeaaabacanaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.x, c13, r1
bcaaaaaaacaaacaeaeaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v2.y, r4.xyzz, r2.xyzz
bcaaaaaaaeaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v4.y, r2.xyzz, r3.xyzz
bcaaaaaaacaaaeaeabaaaaoeaaaaaaaaaeaaaakeacaaaaaa dp3 v2.z, a1, r4.xyzz
bcaaaaaaacaaabaeaeaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v2.x, r4.xyzz, a5
bcaaaaaaaeaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v4.z, a1, r3.xyzz
bcaaaaaaaeaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v4.x, a5, r3.xyzz
adaaaaaaafaaamacadaaaaeeaaaaaaaabhaaaaeeabaaaaaa mul r5.zw, a3.xyxy, c23.xyxy
abaaaaaaaaaaamaeafaaaaopacaaaaaabhaaaaoeabaaaaaa add v0.zw, r5.wwzw, c23
adaaaaaaafaaadacadaaaaoeaaaaaaaabgaaaaoeabaaaaaa mul r5.xy, a3, c22
abaaaaaaaaaaadaeafaaaafeacaaaaaabgaaaaooabaaaaaa add v0.xy, r5.xyyy, c22.zwzw
adaaaaaaafaaadacadaaaaoeaaaaaaaabiaaaaoeabaaaaaa mul r5.xy, a3, c24
abaaaaaaabaaadaeafaaaafeacaaaaaabiaaaaooabaaaaaa add v1.xy, r5.xyyy, c24.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 387
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 418
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 457
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 384
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 398
#line 406
#line 425
#line 467
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 81
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 90
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 136
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 140
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 144
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 148
    return ((x1 + x2) + x3);
}
#line 425
void vert( inout appdata_full v, out Input o ) {
    highp vec4 VertexOutputMaster0_0_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_1_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    #line 429
    highp vec4 VertexOutputMaster0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
}
#line 470
v2f_surf vert_surf( in appdata_full v ) {
    #line 472
    v2f_surf o;
    Input customInputData;
    vert( v, customInputData);
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 476
    o.pack0.xy = ((v.texcoord.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _Normal_ST.xy) + _Normal_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Specular_ST.xy) + _Specular_ST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 480
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 484
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    #line 489
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec2(xl_retval.pack1);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
    xlv_TEXCOORD4 = vec3(xl_retval.viewDir);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 387
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 418
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 457
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 384
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 398
#line 406
#line 425
#line 467
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 398
mediump vec4 LightingBlinnPhongEditor_PrePass( in EditorSurfaceOutput s, in mediump vec4 light ) {
    mediump vec3 spec = (light.w * s.Gloss);
    mediump vec4 c;
    #line 402
    c.xyz = ((s.Albedo * light.xyz) + (light.xyz * spec));
    c.w = s.Alpha;
    return c;
}
#line 172
lowp float Luminance( in lowp vec3 c ) {
    #line 174
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 406
mediump vec4 LightingBlinnPhongEditor( in EditorSurfaceOutput s, in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diff = max( 0.0, dot( lightDir, s.Normal));
    #line 410
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    mediump vec4 res;
    res.xyz = (_LightColor0.xyz * diff);
    #line 414
    res.w = (spec * Luminance( _LightColor0.xyz));
    res *= (atten * 2.0);
    return LightingBlinnPhongEditor_PrePass( s, res);
}
#line 271
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 273
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 432
void surf( in Input IN, inout EditorSurfaceOutput o ) {
    #line 434
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Alpha = 1.0;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 438
    o.Gloss = vec3( 0.0);
    o.Specular = 0.0;
    o.Custom = vec4( 0.0);
    highp vec4 Tex2D1 = texture( _Diffuse, IN.uv_Diffuse.xyxy.xy);
    #line 442
    highp vec4 Multiply1 = (_MainColor * Tex2D1);
    highp vec4 Tex2D0 = texture( _Normal, IN.uv_Normal.xyxy.xy);
    highp vec4 UnpackNormal0 = vec4( UnpackNormal( Tex2D0).xyz, 1.0);
    highp vec4 Tex2D2 = texture( _Specular, IN.uv_Specular.xyxy.xy);
    #line 446
    highp vec4 Multiply0 = (Tex2D2 * vec4( _Specular_Power));
    highp vec4 Master0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_5_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    #line 450
    highp vec4 Master0_7_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_6_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    o.Albedo = vec3( Multiply1);
    o.Normal = vec3( UnpackNormal0);
    #line 454
    o.Gloss = vec3( Multiply0);
    o.Normal = normalize(o.Normal);
}
#line 491
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 493
    Input surfIN;
    surfIN.uv_Diffuse = IN.pack0.xy;
    surfIN.uv_Normal = IN.pack0.zw;
    surfIN.uv_Specular = IN.pack1.xy;
    #line 497
    EditorSurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 501
    o.Alpha = 0.0;
    surf( surfIN, o);
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    #line 505
    c = LightingBlinnPhongEditor( o, IN.lightDir, normalize(IN.viewDir), atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec2(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 14 [unity_LightmapST]
Vector 15 [_Diffuse_ST]
Vector 16 [_Normal_ST]
Vector 17 [_Specular_ST]
"!!ARBvp1.0
# 8 ALU
PARAM c[18] = { program.local[0],
		state.matrix.mvp,
		program.local[5..17] };
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[14], c[14].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 8 instructions, 0 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_LightmapST]
Vector 13 [_Diffuse_ST]
Vector 14 [_Normal_ST]
Vector 15 [_Specular_ST]
"vs_2_0
; 8 ALU
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
mad oT0.zw, v3.xyxy, c14.xyxy, c14
mad oT0.xy, v3, c13, c13.zwzw
mad oT1.xy, v3, c15, c15.zwzw
mad oT2.xy, v4, c12, c12.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform highp vec4 _MainColor;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 UnpackNormal0_4;
  highp vec4 Tex2D0_5;
  highp vec4 Tex2D1_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_5 = tmpvar_8;
  lowp vec4 packednormal_9;
  packednormal_9 = Tex2D0_5;
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((packednormal_9.xyz * 2.0) - 1.0);
  UnpackNormal0_4 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (_MainColor * Tex2D1_6).xyz;
  tmpvar_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = UnpackNormal0_4.xyz;
  tmpvar_3 = tmpvar_12;
  tmpvar_3 = normalize(tmpvar_3);
  lowp vec3 tmpvar_13;
  tmpvar_13 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  mediump vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_2 * tmpvar_13);
  c_1.xyz = tmpvar_14;
  c_1.w = 1.0;
  mediump vec3 tmpvar_15;
  tmpvar_15 = c_1.xyz;
  c_1.xyz = tmpvar_15;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform highp vec4 _MainColor;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 UnpackNormal0_4;
  highp vec4 Tex2D0_5;
  highp vec4 Tex2D1_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_5 = tmpvar_8;
  lowp vec4 packednormal_9;
  packednormal_9 = Tex2D0_5;
  lowp vec3 normal_10;
  normal_10.xy = ((packednormal_9.wy * 2.0) - 1.0);
  normal_10.z = sqrt((1.0 - clamp (dot (normal_10.xy, normal_10.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = normal_10;
  UnpackNormal0_4 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (_MainColor * Tex2D1_6).xyz;
  tmpvar_2 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = UnpackNormal0_4.xyz;
  tmpvar_3 = tmpvar_13;
  tmpvar_3 = normalize(tmpvar_3);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  lowp vec3 tmpvar_15;
  tmpvar_15 = ((8.0 * tmpvar_14.w) * tmpvar_14.xyz);
  mediump vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_2 * tmpvar_15);
  c_1.xyz = tmpvar_16;
  c_1.w = 1.0;
  mediump vec3 tmpvar_17;
  tmpvar_17 = c_1.xyz;
  c_1.xyz = tmpvar_17;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_LightmapST]
Vector 13 [_Diffuse_ST]
Vector 14 [_Normal_ST]
Vector 15 [_Specular_ST]
"agal_vs
[bc]
adaaaaaaaaaaamacadaaaaeeaaaaaaaaaoaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c14.xyxy
abaaaaaaaaaaamaeaaaaaaopacaaaaaaaoaaaaoeabaaaaaa add v0.zw, r0.wwzw, c14
adaaaaaaaaaaadacadaaaaoeaaaaaaaaanaaaaoeabaaaaaa mul r0.xy, a3, c13
abaaaaaaaaaaadaeaaaaaafeacaaaaaaanaaaaooabaaaaaa add v0.xy, r0.xyyy, c13.zwzw
adaaaaaaaaaaadacadaaaaoeaaaaaaaaapaaaaoeabaaaaaa mul r0.xy, a3, c15
abaaaaaaabaaadaeaaaaaafeacaaaaaaapaaaaooabaaaaaa add v1.xy, r0.xyyy, c15.zwzw
adaaaaaaaaaaadacaeaaaaoeaaaaaaaaamaaaaoeabaaaaaa mul r0.xy, a4, c12
abaaaaaaacaaadaeaaaaaafeacaaaaaaamaaaaooabaaaaaa add v2.xy, r0.xyyy, c12.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
aaaaaaaaacaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, c0
"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 387
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 418
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 457
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    highp vec2 lmap;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 384
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 398
#line 406
#line 425
#line 465
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 469
#line 486
uniform sampler2D unity_Lightmap;
#line 81
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 425
void vert( inout appdata_full v, out Input o ) {
    highp vec4 VertexOutputMaster0_0_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_1_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    #line 429
    highp vec4 VertexOutputMaster0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
}
#line 469
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 473
    vert( v, customInputData);
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _Normal_ST.xy) + _Normal_ST.zw);
    #line 477
    o.pack1.xy = ((v.texcoord.xy * _Specular_ST.xy) + _Specular_ST.zw);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 481
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec2(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.lmap);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 387
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 418
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 457
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    highp vec2 lmap;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 384
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 398
#line 406
#line 425
#line 465
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 469
#line 486
uniform sampler2D unity_Lightmap;
#line 176
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 178
    return (2.0 * color.xyz);
}
#line 271
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 273
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 432
void surf( in Input IN, inout EditorSurfaceOutput o ) {
    #line 434
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Alpha = 1.0;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 438
    o.Gloss = vec3( 0.0);
    o.Specular = 0.0;
    o.Custom = vec4( 0.0);
    highp vec4 Tex2D1 = texture( _Diffuse, IN.uv_Diffuse.xyxy.xy);
    #line 442
    highp vec4 Multiply1 = (_MainColor * Tex2D1);
    highp vec4 Tex2D0 = texture( _Normal, IN.uv_Normal.xyxy.xy);
    highp vec4 UnpackNormal0 = vec4( UnpackNormal( Tex2D0).xyz, 1.0);
    highp vec4 Tex2D2 = texture( _Specular, IN.uv_Specular.xyxy.xy);
    #line 446
    highp vec4 Multiply0 = (Tex2D2 * vec4( _Specular_Power));
    highp vec4 Master0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_5_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    #line 450
    highp vec4 Master0_7_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_6_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    o.Albedo = vec3( Multiply1);
    o.Normal = vec3( UnpackNormal0);
    #line 454
    o.Gloss = vec3( Multiply0);
    o.Normal = normalize(o.Normal);
}
#line 487
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    #line 490
    surfIN.uv_Diffuse = IN.pack0.xy;
    surfIN.uv_Normal = IN.pack0.zw;
    surfIN.uv_Specular = IN.pack1.xy;
    EditorSurfaceOutput o;
    #line 494
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 498
    surf( surfIN, o);
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    #line 502
    lowp vec3 lm = DecodeLightmap( lmtex);
    c.xyz += (o.Albedo * lm);
    c.w = o.Alpha;
    c.xyz += o.Emission;
    #line 506
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec2(xlv_TEXCOORD1);
    xlt_IN.lmap = vec2(xlv_TEXCOORD2);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 23 [unity_Scale]
Vector 24 [_Diffuse_ST]
Vector 25 [_Normal_ST]
Vector 26 [_Specular_ST]
"!!ARBvp1.0
# 50 ALU
PARAM c[27] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..26] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[23].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MOV R0.w, c[0].x;
MUL R1, R0.xyzz, R0.yzzx;
DP4 R2.z, R0, c[18];
DP4 R2.y, R0, c[17];
DP4 R2.x, R0, c[16];
MUL R0.w, R2, R2;
MAD R0.w, R0.x, R0.x, -R0;
DP4 R0.z, R1, c[21];
DP4 R0.y, R1, c[20];
DP4 R0.x, R1, c[19];
ADD R0.xyz, R2, R0;
MUL R1.xyz, R0.w, c[22];
ADD result.texcoord[3].xyz, R0, R1;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[23].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[15];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
DP3 result.texcoord[2].y, R3, R1;
DP3 result.texcoord[4].y, R1, R2;
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
ADD result.texcoord[5].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[5].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[26], c[26].zwzw;
END
# 50 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 23 [unity_Scale]
Vector 24 [_Diffuse_ST]
Vector 25 [_Normal_ST]
Vector 26 [_Specular_ST]
"vs_2_0
; 53 ALU
def c27, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c23.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mov r0.w, c27.x
mul r1, r0.xyzz, r0.yzzx
dp4 r2.z, r0, c18
dp4 r2.y, r0, c17
dp4 r2.x, r0, c16
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp4 r0.z, r1, c21
dp4 r0.y, r1, c20
dp4 r0.x, r1, c19
mul r1.xyz, r0.w, c22
add r0.xyz, r2, r0
add oT3.xyz, r0, r1
mov r0.w, c27.x
mov r0.xyz, c12
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c23.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c9
dp4 r4.y, c15, r0
mov r1, c8
dp4 r4.x, c15, r1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c27.y
mul r1.y, r1, c13.x
dp3 oT2.y, r4, r2
dp3 oT4.y, r2, r3
dp3 oT2.z, v2, r4
dp3 oT2.x, r4, v1
dp3 oT4.z, v2, r3
dp3 oT4.x, v1, r3
mad oT5.xy, r1.z, c14.zwzw, r1
mov oPos, r0
mov oT5.zw, r0
mad oT0.zw, v3.xyxy, c25.xyxy, c25
mad oT0.xy, v3, c24, c24.zwzw
mad oT1.xy, v3, c26, c26.zwzw
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (tmpvar_7 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_14;
  mediump vec4 normal_15;
  normal_15 = tmpvar_13;
  highp float vC_16;
  mediump vec3 x3_17;
  mediump vec3 x2_18;
  mediump vec3 x1_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHAr, normal_15);
  x1_19.x = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAg, normal_15);
  x1_19.y = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAb, normal_15);
  x1_19.z = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normal_15.xyzz * normal_15.yzzx);
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHBr, tmpvar_23);
  x2_18.x = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBg, tmpvar_23);
  x2_18.y = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBb, tmpvar_23);
  x2_18.z = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y));
  vC_16 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = (unity_SHC.xyz * vC_16);
  x3_17 = tmpvar_28;
  tmpvar_14 = ((x1_19 + x2_18) + x3_17);
  shlight_3 = tmpvar_14;
  tmpvar_6 = shlight_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = (tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 Tex2D2_5;
  highp vec4 UnpackNormal0_6;
  highp vec4 Tex2D0_7;
  highp vec4 Tex2D1_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_7 = tmpvar_10;
  lowp vec4 packednormal_11;
  packednormal_11 = Tex2D0_7;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = ((packednormal_11.xyz * 2.0) - 1.0);
  UnpackNormal0_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Specular, xlv_TEXCOORD1);
  Tex2D2_5 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (_MainColor * Tex2D1_8).xyz;
  tmpvar_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = UnpackNormal0_6.xyz;
  tmpvar_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (Tex2D2_5 * vec4(_Specular_Power)).xyz;
  tmpvar_4 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_3);
  tmpvar_3 = tmpvar_17;
  lowp float tmpvar_18;
  mediump float lightShadowDataX_19;
  highp float dist_20;
  lowp float tmpvar_21;
  tmpvar_21 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x;
  dist_20 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = max (float((dist_20 > (xlv_TEXCOORD5.z / xlv_TEXCOORD5.w))), lightShadowDataX_19);
  tmpvar_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD4);
  mediump vec3 lightDir_25;
  lightDir_25 = xlv_TEXCOORD2;
  mediump vec3 viewDir_26;
  viewDir_26 = tmpvar_24;
  mediump float atten_27;
  atten_27 = tmpvar_18;
  mediump vec4 res_28;
  highp float nh_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, dot (tmpvar_17, normalize((lightDir_25 + viewDir_26))));
  nh_29 = tmpvar_30;
  res_28.xyz = (_LightColor0.xyz * max (0.0, dot (lightDir_25, tmpvar_17)));
  lowp float tmpvar_31;
  tmpvar_31 = dot (_LightColor0.xyz, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_32;
  tmpvar_32 = (pow (nh_29, 0.0) * tmpvar_31);
  res_28.w = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (res_28 * (atten_27 * 2.0));
  res_28 = tmpvar_33;
  mediump vec4 c_34;
  c_34.xyz = ((tmpvar_2 * tmpvar_33.xyz) + (tmpvar_33.xyz * (tmpvar_33.w * tmpvar_4)));
  c_34.w = 1.0;
  c_1 = c_34;
  mediump vec3 tmpvar_35;
  tmpvar_35 = (c_1.xyz + (tmpvar_2 * xlv_TEXCOORD3));
  c_1.xyz = tmpvar_35;
  mediump vec3 tmpvar_36;
  tmpvar_36 = c_1.xyz;
  c_1.xyz = tmpvar_36;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (tmpvar_8 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_15;
  mediump vec4 normal_16;
  normal_16 = tmpvar_14;
  highp float vC_17;
  mediump vec3 x3_18;
  mediump vec3 x2_19;
  mediump vec3 x1_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAr, normal_16);
  x1_20.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAg, normal_16);
  x1_20.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAb, normal_16);
  x1_20.z = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = (normal_16.xyzz * normal_16.yzzx);
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBr, tmpvar_24);
  x2_19.x = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBg, tmpvar_24);
  x2_19.y = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBb, tmpvar_24);
  x2_19.z = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y));
  vC_17 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (unity_SHC.xyz * vC_17);
  x3_18 = tmpvar_29;
  tmpvar_15 = ((x1_20 + x2_19) + x3_18);
  shlight_3 = tmpvar_15;
  tmpvar_6 = shlight_3;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = (tmpvar_11 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD5 = o_30;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 Tex2D2_5;
  highp vec4 UnpackNormal0_6;
  highp vec4 Tex2D0_7;
  highp vec4 Tex2D1_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_7 = tmpvar_10;
  lowp vec4 packednormal_11;
  packednormal_11 = Tex2D0_7;
  lowp vec3 normal_12;
  normal_12.xy = ((packednormal_11.wy * 2.0) - 1.0);
  normal_12.z = sqrt((1.0 - clamp (dot (normal_12.xy, normal_12.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = normal_12;
  UnpackNormal0_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Specular, xlv_TEXCOORD1);
  Tex2D2_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (_MainColor * Tex2D1_8).xyz;
  tmpvar_2 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = UnpackNormal0_6.xyz;
  tmpvar_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (Tex2D2_5 * vec4(_Specular_Power)).xyz;
  tmpvar_4 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_3);
  tmpvar_3 = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(xlv_TEXCOORD4);
  mediump vec3 lightDir_21;
  lightDir_21 = xlv_TEXCOORD2;
  mediump vec3 viewDir_22;
  viewDir_22 = tmpvar_20;
  mediump float atten_23;
  atten_23 = tmpvar_19;
  mediump vec4 res_24;
  highp float nh_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_18, normalize((lightDir_21 + viewDir_22))));
  nh_25 = tmpvar_26;
  res_24.xyz = (_LightColor0.xyz * max (0.0, dot (lightDir_21, tmpvar_18)));
  lowp float tmpvar_27;
  tmpvar_27 = dot (_LightColor0.xyz, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_28;
  tmpvar_28 = (pow (nh_25, 0.0) * tmpvar_27);
  res_24.w = tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = (res_24 * (atten_23 * 2.0));
  res_24 = tmpvar_29;
  mediump vec4 c_30;
  c_30.xyz = ((tmpvar_2 * tmpvar_29.xyz) + (tmpvar_29.xyz * (tmpvar_29.w * tmpvar_4)));
  c_30.w = 1.0;
  c_1 = c_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = (c_1.xyz + (tmpvar_2 * xlv_TEXCOORD3));
  c_1.xyz = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = c_1.xyz;
  c_1.xyz = tmpvar_32;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [unity_NPOTScale]
Vector 24 [_Diffuse_ST]
Vector 25 [_Normal_ST]
Vector 26 [_Specular_ST]
"agal_vs
c27 1.0 0.5 0.0 0.0
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaabgaaaappabaaaaaa mul r1.xyz, a1, c22.w
bcaaaaaaacaaaiacabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r2.w, r1.xyzz, c5
bcaaaaaaaaaaabacabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r0.x, r1.xyzz, c4
bcaaaaaaaaaaaeacabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r0.z, r1.xyzz, c6
aaaaaaaaaaaaacacacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r2.w
aaaaaaaaaaaaaiacblaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c27.x
adaaaaaaabaaapacaaaaaakeacaaaaaaaaaaaacjacaaaaaa mul r1, r0.xyzz, r0.yzzx
bdaaaaaaacaaaeacaaaaaaoeacaaaaaabbaaaaoeabaaaaaa dp4 r2.z, r0, c17
bdaaaaaaacaaacacaaaaaaoeacaaaaaabaaaaaoeabaaaaaa dp4 r2.y, r0, c16
bdaaaaaaacaaabacaaaaaaoeacaaaaaaapaaaaoeabaaaaaa dp4 r2.x, r0, c15
adaaaaaaaaaaaiacacaaaappacaaaaaaacaaaappacaaaaaa mul r0.w, r2.w, r2.w
adaaaaaaadaaaiacaaaaaaaaacaaaaaaaaaaaaaaacaaaaaa mul r3.w, r0.x, r0.x
acaaaaaaaaaaaiacadaaaappacaaaaaaaaaaaappacaaaaaa sub r0.w, r3.w, r0.w
bdaaaaaaaaaaaeacabaaaaoeacaaaaaabeaaaaoeabaaaaaa dp4 r0.z, r1, c20
bdaaaaaaaaaaacacabaaaaoeacaaaaaabdaaaaoeabaaaaaa dp4 r0.y, r1, c19
bdaaaaaaaaaaabacabaaaaoeacaaaaaabcaaaaoeabaaaaaa dp4 r0.x, r1, c18
adaaaaaaabaaahacaaaaaappacaaaaaabfaaaaoeabaaaaaa mul r1.xyz, r0.w, c21
abaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaadaaahaeaaaaaakeacaaaaaaabaaaakeacaaaaaa add v3.xyz, r0.xyzz, r1.xyzz
aaaaaaaaaaaaaiacblaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c27.x
aaaaaaaaaaaaahacamaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c12
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r1.z, r0, c10
bdaaaaaaabaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r1.y, r0, c9
bdaaaaaaabaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r1.x, r0, c8
adaaaaaaaeaaahacabaaaakeacaaaaaabgaaaappabaaaaaa mul r4.xyz, r1.xyzz, c22.w
acaaaaaaadaaahacaeaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r4.xyzz, a0
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaaaaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r0.yzxx
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaafaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r5.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacafaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r5.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaaeaaaeacaoaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c14, r0
aaaaaaaaaaaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c9
bdaaaaaaaeaaacacaoaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.y, c14, r0
aaaaaaaaabaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c8
bdaaaaaaaeaaabacaoaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.x, c14, r1
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 r0.w, a0, c3
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r0.z, a0, c2
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 r0.x, a0, c0
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 r0.y, a0, c1
adaaaaaaabaaahacaaaaaapeacaaaaaablaaaaffabaaaaaa mul r1.xyz, r0.xyww, c27.y
adaaaaaaabaaacacabaaaaffacaaaaaaanaaaaaaabaaaaaa mul r1.y, r1.y, c13.x
abaaaaaaabaaadacabaaaafeacaaaaaaabaaaakkacaaaaaa add r1.xy, r1.xyyy, r1.z
bcaaaaaaacaaacaeaeaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v2.y, r4.xyzz, r2.xyzz
bcaaaaaaaeaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v4.y, r2.xyzz, r3.xyzz
bcaaaaaaacaaaeaeabaaaaoeaaaaaaaaaeaaaakeacaaaaaa dp3 v2.z, a1, r4.xyzz
bcaaaaaaacaaabaeaeaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v2.x, r4.xyzz, a5
bcaaaaaaaeaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v4.z, a1, r3.xyzz
bcaaaaaaaeaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v4.x, a5, r3.xyzz
adaaaaaaafaaadaeabaaaafeacaaaaaabhaaaaoeabaaaaaa mul v5.xy, r1.xyyy, c23
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
aaaaaaaaafaaamaeaaaaaaopacaaaaaaaaaaaaaaaaaaaaaa mov v5.zw, r0.wwzw
adaaaaaaafaaamacadaaaaeeaaaaaaaabjaaaaeeabaaaaaa mul r5.zw, a3.xyxy, c25.xyxy
abaaaaaaaaaaamaeafaaaaopacaaaaaabjaaaaoeabaaaaaa add v0.zw, r5.wwzw, c25
adaaaaaaafaaadacadaaaaoeaaaaaaaabiaaaaoeabaaaaaa mul r5.xy, a3, c24
abaaaaaaaaaaadaeafaaaafeacaaaaaabiaaaaooabaaaaaa add v0.xy, r5.xyyy, c24.zwzw
adaaaaaaafaaadacadaaaaoeaaaaaaaabkaaaaoeabaaaaaa mul r5.xy, a3, c26
abaaaaaaabaaadaeafaaaafeacaaaaaabkaaaaooabaaaaaa add v1.xy, r5.xyyy, c26.zwzw
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 395
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 426
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 465
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 384
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 392
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 406
#line 414
#line 433
#line 476
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 501
#line 81
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 90
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 136
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 140
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 144
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 148
    return ((x1 + x2) + x3);
}
#line 433
void vert( inout appdata_full v, out Input o ) {
    highp vec4 VertexOutputMaster0_0_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_1_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    #line 437
    highp vec4 VertexOutputMaster0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
}
#line 479
v2f_surf vert_surf( in appdata_full v ) {
    #line 481
    v2f_surf o;
    Input customInputData;
    vert( v, customInputData);
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 485
    o.pack0.xy = ((v.texcoord.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _Normal_ST.xy) + _Normal_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Specular_ST.xy) + _Specular_ST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 489
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 493
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    #line 497
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec2(xl_retval.pack1);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
    xlv_TEXCOORD4 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD5 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 395
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 426
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 465
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 384
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 392
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 406
#line 414
#line 433
#line 476
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 501
#line 406
mediump vec4 LightingBlinnPhongEditor_PrePass( in EditorSurfaceOutput s, in mediump vec4 light ) {
    mediump vec3 spec = (light.w * s.Gloss);
    mediump vec4 c;
    #line 410
    c.xyz = ((s.Albedo * light.xyz) + (light.xyz * spec));
    c.w = s.Alpha;
    return c;
}
#line 172
lowp float Luminance( in lowp vec3 c ) {
    #line 174
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 414
mediump vec4 LightingBlinnPhongEditor( in EditorSurfaceOutput s, in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diff = max( 0.0, dot( lightDir, s.Normal));
    #line 418
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    mediump vec4 res;
    res.xyz = (_LightColor0.xyz * diff);
    #line 422
    res.w = (spec * Luminance( _LightColor0.xyz));
    res *= (atten * 2.0);
    return LightingBlinnPhongEditor_PrePass( s, res);
}
#line 271
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 273
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 440
void surf( in Input IN, inout EditorSurfaceOutput o ) {
    #line 442
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Alpha = 1.0;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 446
    o.Gloss = vec3( 0.0);
    o.Specular = 0.0;
    o.Custom = vec4( 0.0);
    highp vec4 Tex2D1 = texture( _Diffuse, IN.uv_Diffuse.xyxy.xy);
    #line 450
    highp vec4 Multiply1 = (_MainColor * Tex2D1);
    highp vec4 Tex2D0 = texture( _Normal, IN.uv_Normal.xyxy.xy);
    highp vec4 UnpackNormal0 = vec4( UnpackNormal( Tex2D0).xyz, 1.0);
    highp vec4 Tex2D2 = texture( _Specular, IN.uv_Specular.xyxy.xy);
    #line 454
    highp vec4 Multiply0 = (Tex2D2 * vec4( _Specular_Power));
    highp vec4 Master0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_5_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    #line 458
    highp vec4 Master0_7_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_6_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    o.Albedo = vec3( Multiply1);
    o.Normal = vec3( UnpackNormal0);
    #line 462
    o.Gloss = vec3( Multiply0);
    o.Normal = normalize(o.Normal);
}
#line 384
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 388
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 501
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_Diffuse = IN.pack0.xy;
    #line 505
    surfIN.uv_Normal = IN.pack0.zw;
    surfIN.uv_Specular = IN.pack1.xy;
    EditorSurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 509
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    surf( surfIN, o);
    #line 513
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    c = LightingBlinnPhongEditor( o, IN.lightDir, normalize(IN.viewDir), atten);
    c.xyz += (o.Albedo * IN.vlight);
    #line 517
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec2(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_ProjectionParams]
Vector 15 [unity_LightmapST]
Vector 16 [_Diffuse_ST]
Vector 17 [_Normal_ST]
Vector 18 [_Specular_ST]
"!!ARBvp1.0
# 13 ALU
PARAM c[19] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[15], c[15].zwzw;
END
# 13 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_LightmapST]
Vector 15 [_Diffuse_ST]
Vector 16 [_Normal_ST]
Vector 17 [_Specular_ST]
"vs_2_0
; 13 ALU
def c18, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c18.x
mul r1.y, r1, c12.x
mad oT3.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov oT3.zw, r0
mad oT0.zw, v3.xyxy, c16.xyxy, c16
mad oT0.xy, v3, c15, c15.zwzw
mad oT1.xy, v3, c17, c17.zwzw
mad oT2.xy, v4, c14, c14.zwzw
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform highp vec4 _MainColor;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 UnpackNormal0_4;
  highp vec4 Tex2D0_5;
  highp vec4 Tex2D1_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_5 = tmpvar_8;
  lowp vec4 packednormal_9;
  packednormal_9 = Tex2D0_5;
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((packednormal_9.xyz * 2.0) - 1.0);
  UnpackNormal0_4 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (_MainColor * Tex2D1_6).xyz;
  tmpvar_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = UnpackNormal0_4.xyz;
  tmpvar_3 = tmpvar_12;
  tmpvar_3 = normalize(tmpvar_3);
  lowp float tmpvar_13;
  mediump float lightShadowDataX_14;
  highp float dist_15;
  lowp float tmpvar_16;
  tmpvar_16 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_14 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((dist_15 > (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w))), lightShadowDataX_14);
  tmpvar_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz), vec3((tmpvar_13 * 2.0)));
  mediump vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_2 * tmpvar_19);
  c_1.xyz = tmpvar_20;
  c_1.w = 1.0;
  mediump vec3 tmpvar_21;
  tmpvar_21 = c_1.xyz;
  c_1.xyz = tmpvar_21;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = o_3;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform highp vec4 _MainColor;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform sampler2D _ShadowMapTexture;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 UnpackNormal0_4;
  highp vec4 Tex2D0_5;
  highp vec4 Tex2D1_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_5 = tmpvar_8;
  lowp vec4 packednormal_9;
  packednormal_9 = Tex2D0_5;
  lowp vec3 normal_10;
  normal_10.xy = ((packednormal_9.wy * 2.0) - 1.0);
  normal_10.z = sqrt((1.0 - clamp (dot (normal_10.xy, normal_10.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = normal_10;
  UnpackNormal0_4 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (_MainColor * Tex2D1_6).xyz;
  tmpvar_2 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = UnpackNormal0_4.xyz;
  tmpvar_3 = tmpvar_13;
  tmpvar_3 = normalize(tmpvar_3);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  lowp vec3 tmpvar_16;
  tmpvar_16 = ((8.0 * tmpvar_15.w) * tmpvar_15.xyz);
  lowp vec3 tmpvar_17;
  tmpvar_17 = max (min (tmpvar_16, ((tmpvar_14.x * 2.0) * tmpvar_15.xyz)), (tmpvar_16 * tmpvar_14.x));
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_2 * tmpvar_17);
  c_1.xyz = tmpvar_18;
  c_1.w = 1.0;
  mediump vec3 tmpvar_19;
  tmpvar_19 = c_1.xyz;
  c_1.xyz = tmpvar_19;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_ProjectionParams]
Vector 13 [unity_NPOTScale]
Vector 14 [unity_LightmapST]
Vector 15 [_Diffuse_ST]
Vector 16 [_Normal_ST]
Vector 17 [_Specular_ST]
"agal_vs
c18 0.5 0.0 0.0 0.0
[bc]
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 r0.w, a0, c3
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r0.z, a0, c2
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 r0.x, a0, c0
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 r0.y, a0, c1
adaaaaaaabaaahacaaaaaapeacaaaaaabcaaaaaaabaaaaaa mul r1.xyz, r0.xyww, c18.x
adaaaaaaabaaacacabaaaaffacaaaaaaamaaaaaaabaaaaaa mul r1.y, r1.y, c12.x
abaaaaaaabaaadacabaaaafeacaaaaaaabaaaakkacaaaaaa add r1.xy, r1.xyyy, r1.z
adaaaaaaadaaadaeabaaaafeacaaaaaaanaaaaoeabaaaaaa mul v3.xy, r1.xyyy, c13
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
aaaaaaaaadaaamaeaaaaaaopacaaaaaaaaaaaaaaaaaaaaaa mov v3.zw, r0.wwzw
adaaaaaaaaaaamacadaaaaeeaaaaaaaabaaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c16.xyxy
abaaaaaaaaaaamaeaaaaaaopacaaaaaabaaaaaoeabaaaaaa add v0.zw, r0.wwzw, c16
adaaaaaaaaaaadacadaaaaoeaaaaaaaaapaaaaoeabaaaaaa mul r0.xy, a3, c15
abaaaaaaaaaaadaeaaaaaafeacaaaaaaapaaaaooabaaaaaa add v0.xy, r0.xyyy, c15.zwzw
adaaaaaaaaaaadacadaaaaoeaaaaaaaabbaaaaoeabaaaaaa mul r0.xy, a3, c17
abaaaaaaabaaadaeaaaaaafeacaaaaaabbaaaaooabaaaaaa add v1.xy, r0.xyyy, c17.zwzw
adaaaaaaaaaaadacaeaaaaoeaaaaaaaaaoaaaaoeabaaaaaa mul r0.xy, a4, c14
abaaaaaaacaaadaeaaaaaafeacaaaaaaaoaaaaooabaaaaaa add v2.xy, r0.xyyy, c14.zwzw
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
aaaaaaaaacaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, c0
"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 395
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 426
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 465
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 384
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 392
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 406
#line 414
#line 433
#line 474
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 478
uniform sampler2D unity_Lightmap;
#line 81
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 433
void vert( inout appdata_full v, out Input o ) {
    highp vec4 VertexOutputMaster0_0_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_1_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    #line 437
    highp vec4 VertexOutputMaster0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
}
#line 478
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 482
    vert( v, customInputData);
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _Normal_ST.xy) + _Normal_ST.zw);
    #line 486
    o.pack1.xy = ((v.texcoord.xy * _Specular_ST.xy) + _Specular_ST.zw);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 490
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 494
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec2(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.lmap);
    xlv_TEXCOORD3 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 395
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 426
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 465
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 384
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 392
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 406
#line 414
#line 433
#line 474
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 478
uniform sampler2D unity_Lightmap;
#line 176
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 178
    return (2.0 * color.xyz);
}
#line 271
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 273
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 440
void surf( in Input IN, inout EditorSurfaceOutput o ) {
    #line 442
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Alpha = 1.0;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 446
    o.Gloss = vec3( 0.0);
    o.Specular = 0.0;
    o.Custom = vec4( 0.0);
    highp vec4 Tex2D1 = texture( _Diffuse, IN.uv_Diffuse.xyxy.xy);
    #line 450
    highp vec4 Multiply1 = (_MainColor * Tex2D1);
    highp vec4 Tex2D0 = texture( _Normal, IN.uv_Normal.xyxy.xy);
    highp vec4 UnpackNormal0 = vec4( UnpackNormal( Tex2D0).xyz, 1.0);
    highp vec4 Tex2D2 = texture( _Specular, IN.uv_Specular.xyxy.xy);
    #line 454
    highp vec4 Multiply0 = (Tex2D2 * vec4( _Specular_Power));
    highp vec4 Master0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_5_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    #line 458
    highp vec4 Master0_7_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_6_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    o.Albedo = vec3( Multiply1);
    o.Normal = vec3( UnpackNormal0);
    #line 462
    o.Gloss = vec3( Multiply0);
    o.Normal = normalize(o.Normal);
}
#line 384
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 388
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 497
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 499
    Input surfIN;
    surfIN.uv_Diffuse = IN.pack0.xy;
    surfIN.uv_Normal = IN.pack0.zw;
    surfIN.uv_Specular = IN.pack1.xy;
    #line 503
    EditorSurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 507
    o.Alpha = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 511
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec3 lm = DecodeLightmap( lmtex);
    c.xyz += (o.Albedo * min( lm, vec3( (atten * 2.0))));
    c.w = o.Alpha;
    #line 515
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec2(xlv_TEXCOORD1);
    xlt_IN.lmap = vec2(xlv_TEXCOORD2);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 18 [unity_4LightAtten0]
Vector 19 [unity_LightColor0]
Vector 20 [unity_LightColor1]
Vector 21 [unity_LightColor2]
Vector 22 [unity_LightColor3]
Vector 23 [unity_SHAr]
Vector 24 [unity_SHAg]
Vector 25 [unity_SHAb]
Vector 26 [unity_SHBr]
Vector 27 [unity_SHBg]
Vector 28 [unity_SHBb]
Vector 29 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 30 [unity_Scale]
Vector 31 [_Diffuse_ST]
Vector 32 [_Normal_ST]
Vector 33 [_Specular_ST]
"!!ARBvp1.0
# 76 ALU
PARAM c[34] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..33] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[30].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[16];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[15];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[17];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[18];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[20];
MAD R1.xyz, R0.x, c[19], R1;
MAD R0.xyz, R0.z, c[21], R1;
MAD R1.xyz, R0.w, c[22], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R3.z, R0, c[28];
DP4 R3.y, R0, c[27];
DP4 R3.x, R0, c[26];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[29];
MOV R1.w, c[0].x;
DP4 R2.z, R4, c[25];
DP4 R2.y, R4, c[24];
DP4 R2.x, R4, c[23];
ADD R2.xyz, R2, R3;
ADD R0.xyz, R2, R0;
ADD result.texcoord[3].xyz, R0, R1;
MOV R1.xyz, c[13];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[30].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1, c[14];
MUL R0.xyz, R0, vertex.attrib[14].w;
DP4 R3.z, R1, c[11];
DP4 R3.y, R1, c[10];
DP4 R3.x, R1, c[9];
DP3 result.texcoord[2].y, R3, R0;
DP3 result.texcoord[4].y, R0, R2;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[32].xyxy, c[32];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[31], c[31].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[33], c[33].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 76 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 17 [unity_4LightAtten0]
Vector 18 [unity_LightColor0]
Vector 19 [unity_LightColor1]
Vector 20 [unity_LightColor2]
Vector 21 [unity_LightColor3]
Vector 22 [unity_SHAr]
Vector 23 [unity_SHAg]
Vector 24 [unity_SHAb]
Vector 25 [unity_SHBr]
Vector 26 [unity_SHBg]
Vector 27 [unity_SHBb]
Vector 28 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 29 [unity_Scale]
Vector 30 [_Diffuse_ST]
Vector 31 [_Normal_ST]
Vector 32 [_Specular_ST]
"vs_2_0
; 79 ALU
def c33, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c29.w
dp4 r0.x, v0, c5
add r1, -r0.x, c15
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c14
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c33.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c16
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c17
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c33.x
dp4 r2.z, r4, c24
dp4 r2.y, r4, c23
dp4 r2.x, r4, c22
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c33.y
mul r0, r0, r1
mul r1.xyz, r0.y, c19
mad r1.xyz, r0.x, c18, r1
mad r0.xyz, r0.z, c20, r1
mad r1.xyz, r0.w, c21, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c27
dp4 r3.y, r0, c26
dp4 r3.x, r0, c25
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c28
add r2.xyz, r2, r3
add r0.xyz, r2, r0
add oT3.xyz, r0, r1
mov r1.w, c33.x
mov r1.xyz, c12
dp4 r0.z, r1, c10
dp4 r0.y, r1, c9
dp4 r0.x, r1, c8
mad r3.xyz, r0, c29.w, -v0
mov r1.xyz, v1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r1.yzxw
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c13, r0
mov r1, c9
mov r0, c8
dp4 r4.y, c13, r1
dp4 r4.x, c13, r0
dp3 oT2.y, r4, r2
dp3 oT4.y, r2, r3
dp3 oT2.z, v2, r4
dp3 oT2.x, r4, v1
dp3 oT4.z, v2, r3
dp3 oT4.x, v1, r3
mad oT0.zw, v3.xyxy, c31.xyxy, c31
mad oT0.xy, v3, c30, c30.zwzw
mad oT1.xy, v3, c32, c32.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_8;
  mediump vec3 tmpvar_15;
  mediump vec4 normal_16;
  normal_16 = tmpvar_14;
  highp float vC_17;
  mediump vec3 x3_18;
  mediump vec3 x2_19;
  mediump vec3 x1_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAr, normal_16);
  x1_20.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAg, normal_16);
  x1_20.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAb, normal_16);
  x1_20.z = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = (normal_16.xyzz * normal_16.yzzx);
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBr, tmpvar_24);
  x2_19.x = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBg, tmpvar_24);
  x2_19.y = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBb, tmpvar_24);
  x2_19.z = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y));
  vC_17 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (unity_SHC.xyz * vC_17);
  x3_18 = tmpvar_29;
  tmpvar_15 = ((x1_20 + x2_19) + x3_18);
  shlight_3 = tmpvar_15;
  tmpvar_6 = shlight_3;
  highp vec3 tmpvar_30;
  tmpvar_30 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosX0 - tmpvar_30.x);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosY0 - tmpvar_30.y);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosZ0 - tmpvar_30.z);
  highp vec4 tmpvar_34;
  tmpvar_34 = (((tmpvar_31 * tmpvar_31) + (tmpvar_32 * tmpvar_32)) + (tmpvar_33 * tmpvar_33));
  highp vec4 tmpvar_35;
  tmpvar_35 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_31 * tmpvar_8.x) + (tmpvar_32 * tmpvar_8.y)) + (tmpvar_33 * tmpvar_8.z)) * inversesqrt(tmpvar_34))) * (1.0/((1.0 + (tmpvar_34 * unity_4LightAtten0)))));
  highp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_6 + ((((unity_LightColor[0].xyz * tmpvar_35.x) + (unity_LightColor[1].xyz * tmpvar_35.y)) + (unity_LightColor[2].xyz * tmpvar_35.z)) + (unity_LightColor[3].xyz * tmpvar_35.w)));
  tmpvar_6 = tmpvar_36;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = (tmpvar_11 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 Tex2D2_5;
  highp vec4 UnpackNormal0_6;
  highp vec4 Tex2D0_7;
  highp vec4 Tex2D1_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_7 = tmpvar_10;
  lowp vec4 packednormal_11;
  packednormal_11 = Tex2D0_7;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = ((packednormal_11.xyz * 2.0) - 1.0);
  UnpackNormal0_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Specular, xlv_TEXCOORD1);
  Tex2D2_5 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (_MainColor * Tex2D1_8).xyz;
  tmpvar_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = UnpackNormal0_6.xyz;
  tmpvar_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (Tex2D2_5 * vec4(_Specular_Power)).xyz;
  tmpvar_4 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_3);
  tmpvar_3 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  mediump vec3 lightDir_19;
  lightDir_19 = xlv_TEXCOORD2;
  mediump vec3 viewDir_20;
  viewDir_20 = tmpvar_18;
  mediump vec4 res_21;
  highp float nh_22;
  mediump float tmpvar_23;
  tmpvar_23 = max (0.0, dot (tmpvar_17, normalize((lightDir_19 + viewDir_20))));
  nh_22 = tmpvar_23;
  res_21.xyz = (_LightColor0.xyz * max (0.0, dot (lightDir_19, tmpvar_17)));
  lowp float tmpvar_24;
  tmpvar_24 = dot (_LightColor0.xyz, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_25;
  tmpvar_25 = (pow (nh_22, 0.0) * tmpvar_24);
  res_21.w = tmpvar_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = (res_21 * 2.0);
  res_21 = tmpvar_26;
  mediump vec4 c_27;
  c_27.xyz = ((tmpvar_2 * tmpvar_26.xyz) + (tmpvar_26.xyz * (tmpvar_26.w * tmpvar_4)));
  c_27.w = 1.0;
  c_1 = c_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (c_1.xyz + (tmpvar_2 * xlv_TEXCOORD3));
  c_1.xyz = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = c_1.xyz;
  c_1.xyz = tmpvar_29;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_8;
  mediump vec3 tmpvar_15;
  mediump vec4 normal_16;
  normal_16 = tmpvar_14;
  highp float vC_17;
  mediump vec3 x3_18;
  mediump vec3 x2_19;
  mediump vec3 x1_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAr, normal_16);
  x1_20.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAg, normal_16);
  x1_20.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAb, normal_16);
  x1_20.z = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = (normal_16.xyzz * normal_16.yzzx);
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBr, tmpvar_24);
  x2_19.x = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBg, tmpvar_24);
  x2_19.y = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBb, tmpvar_24);
  x2_19.z = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y));
  vC_17 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (unity_SHC.xyz * vC_17);
  x3_18 = tmpvar_29;
  tmpvar_15 = ((x1_20 + x2_19) + x3_18);
  shlight_3 = tmpvar_15;
  tmpvar_6 = shlight_3;
  highp vec3 tmpvar_30;
  tmpvar_30 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosX0 - tmpvar_30.x);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosY0 - tmpvar_30.y);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosZ0 - tmpvar_30.z);
  highp vec4 tmpvar_34;
  tmpvar_34 = (((tmpvar_31 * tmpvar_31) + (tmpvar_32 * tmpvar_32)) + (tmpvar_33 * tmpvar_33));
  highp vec4 tmpvar_35;
  tmpvar_35 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_31 * tmpvar_8.x) + (tmpvar_32 * tmpvar_8.y)) + (tmpvar_33 * tmpvar_8.z)) * inversesqrt(tmpvar_34))) * (1.0/((1.0 + (tmpvar_34 * unity_4LightAtten0)))));
  highp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_6 + ((((unity_LightColor[0].xyz * tmpvar_35.x) + (unity_LightColor[1].xyz * tmpvar_35.y)) + (unity_LightColor[2].xyz * tmpvar_35.z)) + (unity_LightColor[3].xyz * tmpvar_35.w)));
  tmpvar_6 = tmpvar_36;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = (tmpvar_11 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 Tex2D2_5;
  highp vec4 UnpackNormal0_6;
  highp vec4 Tex2D0_7;
  highp vec4 Tex2D1_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_7 = tmpvar_10;
  lowp vec4 packednormal_11;
  packednormal_11 = Tex2D0_7;
  lowp vec3 normal_12;
  normal_12.xy = ((packednormal_11.wy * 2.0) - 1.0);
  normal_12.z = sqrt((1.0 - clamp (dot (normal_12.xy, normal_12.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = normal_12;
  UnpackNormal0_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Specular, xlv_TEXCOORD1);
  Tex2D2_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (_MainColor * Tex2D1_8).xyz;
  tmpvar_2 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = UnpackNormal0_6.xyz;
  tmpvar_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (Tex2D2_5 * vec4(_Specular_Power)).xyz;
  tmpvar_4 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_3);
  tmpvar_3 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(xlv_TEXCOORD4);
  mediump vec3 lightDir_20;
  lightDir_20 = xlv_TEXCOORD2;
  mediump vec3 viewDir_21;
  viewDir_21 = tmpvar_19;
  mediump vec4 res_22;
  highp float nh_23;
  mediump float tmpvar_24;
  tmpvar_24 = max (0.0, dot (tmpvar_18, normalize((lightDir_20 + viewDir_21))));
  nh_23 = tmpvar_24;
  res_22.xyz = (_LightColor0.xyz * max (0.0, dot (lightDir_20, tmpvar_18)));
  lowp float tmpvar_25;
  tmpvar_25 = dot (_LightColor0.xyz, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_26;
  tmpvar_26 = (pow (nh_23, 0.0) * tmpvar_25);
  res_22.w = tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = (res_22 * 2.0);
  res_22 = tmpvar_27;
  mediump vec4 c_28;
  c_28.xyz = ((tmpvar_2 * tmpvar_27.xyz) + (tmpvar_27.xyz * (tmpvar_27.w * tmpvar_4)));
  c_28.w = 1.0;
  c_1 = c_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (c_1.xyz + (tmpvar_2 * xlv_TEXCOORD3));
  c_1.xyz = tmpvar_29;
  mediump vec3 tmpvar_30;
  tmpvar_30 = c_1.xyz;
  c_1.xyz = tmpvar_30;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 17 [unity_4LightAtten0]
Vector 18 [unity_LightColor0]
Vector 19 [unity_LightColor1]
Vector 20 [unity_LightColor2]
Vector 21 [unity_LightColor3]
Vector 22 [unity_SHAr]
Vector 23 [unity_SHAg]
Vector 24 [unity_SHAb]
Vector 25 [unity_SHBr]
Vector 26 [unity_SHBg]
Vector 27 [unity_SHBb]
Vector 28 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 29 [unity_Scale]
Vector 30 [_Diffuse_ST]
Vector 31 [_Normal_ST]
Vector 32 [_Specular_ST]
"agal_vs
c33 1.0 0.0 0.0 0.0
[bc]
adaaaaaaadaaahacabaaaaoeaaaaaaaabnaaaappabaaaaaa mul r3.xyz, a1, c29.w
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.x, a0, c5
bfaaaaaaabaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.x, r0.x
abaaaaaaabaaapacabaaaaaaacaaaaaaapaaaaoeabaaaaaa add r1, r1.x, c15
bcaaaaaaadaaaiacadaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r3.w, r3.xyzz, c5
bcaaaaaaaeaaabacadaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r4.x, r3.xyzz, c4
bcaaaaaaadaaabacadaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r3.x, r3.xyzz, c6
adaaaaaaacaaapacadaaaappacaaaaaaabaaaaoeacaaaaaa mul r2, r3.w, r1
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bfaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r0.x, r0.x
abaaaaaaaaaaapacaaaaaaaaacaaaaaaaoaaaaoeabaaaaaa add r0, r0.x, c14
adaaaaaaabaaapacabaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r1, r1, r1
aaaaaaaaaeaaaeacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r4.z, r3.x
adaaaaaaafaaapacaeaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r5, r4.x, r0
abaaaaaaacaaapacafaaaaoeacaaaaaaacaaaaoeacaaaaaa add r2, r5, r2
aaaaaaaaaeaaaiaccbaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r4.w, c33.x
bdaaaaaaaeaaacacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r4.y, a0, c6
adaaaaaaafaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r5, r0, r0
abaaaaaaabaaapacafaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r5, r1
bfaaaaaaaaaaacacaeaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r0.y, r4.y
abaaaaaaaaaaapacaaaaaaffacaaaaaabaaaaaoeabaaaaaa add r0, r0.y, c16
adaaaaaaafaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r5, r0, r0
abaaaaaaabaaapacafaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r5, r1
adaaaaaaaaaaapacadaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r0, r3.x, r0
abaaaaaaaaaaapacaaaaaaoeacaaaaaaacaaaaoeacaaaaaa add r0, r0, r2
adaaaaaaacaaapacabaaaaoeacaaaaaabbaaaaoeabaaaaaa mul r2, r1, c17
aaaaaaaaaeaaacacadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r4.y, r3.w
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
akaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rsq r1.y, r1.y
akaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r1.w, r1.w
akaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rsq r1.z, r1.z
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
abaaaaaaabaaapacacaaaaoeacaaaaaacbaaaaaaabaaaaaa add r1, r2, c33.x
bdaaaaaaacaaaeacaeaaaaoeacaaaaaabiaaaaoeabaaaaaa dp4 r2.z, r4, c24
bdaaaaaaacaaacacaeaaaaoeacaaaaaabhaaaaoeabaaaaaa dp4 r2.y, r4, c23
bdaaaaaaacaaabacaeaaaaoeacaaaaaabgaaaaoeabaaaaaa dp4 r2.x, r4, c22
afaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r1.x, r1.x
afaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rcp r1.y, r1.y
afaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rcp r1.w, r1.w
afaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rcp r1.z, r1.z
ahaaaaaaaaaaapacaaaaaaoeacaaaaaacbaaaaffabaaaaaa max r0, r0, c33.y
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
adaaaaaaabaaahacaaaaaaffacaaaaaabdaaaaoeabaaaaaa mul r1.xyz, r0.y, c19
adaaaaaaafaaahacaaaaaaaaacaaaaaabcaaaaoeabaaaaaa mul r5.xyz, r0.x, c18
abaaaaaaabaaahacafaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r5.xyzz, r1.xyzz
adaaaaaaaaaaahacaaaaaakkacaaaaaabeaaaaoeabaaaaaa mul r0.xyz, r0.z, c20
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaahacaaaaaappacaaaaaabfaaaaoeabaaaaaa mul r1.xyz, r0.w, c21
abaaaaaaabaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r1.xyz, r1.xyzz, r0.xyzz
adaaaaaaaaaaapacaeaaaakeacaaaaaaaeaaaacjacaaaaaa mul r0, r4.xyzz, r4.yzzx
adaaaaaaabaaaiacadaaaappacaaaaaaadaaaappacaaaaaa mul r1.w, r3.w, r3.w
bdaaaaaaadaaaeacaaaaaaoeacaaaaaablaaaaoeabaaaaaa dp4 r3.z, r0, c27
bdaaaaaaadaaacacaaaaaaoeacaaaaaabkaaaaoeabaaaaaa dp4 r3.y, r0, c26
bdaaaaaaadaaabacaaaaaaoeacaaaaaabjaaaaoeabaaaaaa dp4 r3.x, r0, c25
adaaaaaaafaaaiacaeaaaaaaacaaaaaaaeaaaaaaacaaaaaa mul r5.w, r4.x, r4.x
acaaaaaaabaaaiacafaaaappacaaaaaaabaaaappacaaaaaa sub r1.w, r5.w, r1.w
adaaaaaaaaaaahacabaaaappacaaaaaabmaaaaoeabaaaaaa mul r0.xyz, r1.w, c28
abaaaaaaacaaahacacaaaakeacaaaaaaadaaaakeacaaaaaa add r2.xyz, r2.xyzz, r3.xyzz
abaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaadaaahaeaaaaaakeacaaaaaaabaaaakeacaaaaaa add v3.xyz, r0.xyzz, r1.xyzz
aaaaaaaaabaaaiaccbaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r1.w, c33.x
aaaaaaaaabaaahacamaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, c12
bdaaaaaaaaaaaeacabaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r0.z, r1, c10
bdaaaaaaaaaaacacabaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r0.y, r1, c9
bdaaaaaaaaaaabacabaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r0.x, r1, c8
adaaaaaaafaaahacaaaaaakeacaaaaaabnaaaappabaaaaaa mul r5.xyz, r0.xyzz, c29.w
acaaaaaaadaaahacafaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r5.xyzz, a0
aaaaaaaaabaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, a5
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaabaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r1.yzxx
adaaaaaaafaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r5.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacafaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r5.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaaeaaaeacanaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c13, r0
aaaaaaaaabaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c9
aaaaaaaaaaaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c8
bdaaaaaaaeaaacacanaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.y, c13, r1
bdaaaaaaaeaaabacanaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.x, c13, r0
bcaaaaaaacaaacaeaeaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v2.y, r4.xyzz, r2.xyzz
bcaaaaaaaeaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v4.y, r2.xyzz, r3.xyzz
bcaaaaaaacaaaeaeabaaaaoeaaaaaaaaaeaaaakeacaaaaaa dp3 v2.z, a1, r4.xyzz
bcaaaaaaacaaabaeaeaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v2.x, r4.xyzz, a5
bcaaaaaaaeaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v4.z, a1, r3.xyzz
bcaaaaaaaeaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v4.x, a5, r3.xyzz
adaaaaaaafaaamacadaaaaeeaaaaaaaabpaaaaeeabaaaaaa mul r5.zw, a3.xyxy, c31.xyxy
abaaaaaaaaaaamaeafaaaaopacaaaaaabpaaaaoeabaaaaaa add v0.zw, r5.wwzw, c31
adaaaaaaafaaadacadaaaaoeaaaaaaaaboaaaaoeabaaaaaa mul r5.xy, a3, c30
abaaaaaaaaaaadaeafaaaafeacaaaaaaboaaaaooabaaaaaa add v0.xy, r5.xyyy, c30.zwzw
adaaaaaaafaaadacadaaaaoeaaaaaaaacaaaaaoeabaaaaaa mul r5.xy, a3, c32
abaaaaaaabaaadaeafaaaafeacaaaaaacaaaaaooabaaaaaa add v1.xy, r5.xyyy, c32.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 387
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 418
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 457
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 384
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 398
#line 406
#line 425
#line 467
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 493
#line 81
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 90
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 95
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    highp vec4 toLightY = (lightPosY - pos.y);
    #line 99
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    #line 103
    lengthSq += (toLightZ * toLightZ);
    highp vec4 ndotl = vec4( 0.0);
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    #line 107
    ndotl += (toLightZ * normal.z);
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 111
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    col += (lightColor1 * diff.y);
    #line 115
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 136
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 140
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 144
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 148
    return ((x1 + x2) + x3);
}
#line 425
void vert( inout appdata_full v, out Input o ) {
    highp vec4 VertexOutputMaster0_0_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_1_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    #line 429
    highp vec4 VertexOutputMaster0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
}
#line 470
v2f_surf vert_surf( in appdata_full v ) {
    #line 472
    v2f_surf o;
    Input customInputData;
    vert( v, customInputData);
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 476
    o.pack0.xy = ((v.texcoord.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _Normal_ST.xy) + _Normal_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Specular_ST.xy) + _Specular_ST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 480
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 484
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    #line 488
    highp vec3 worldPos = (_Object2World * v.vertex).xyz;
    o.vlight += Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldN);
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec2(xl_retval.pack1);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
    xlv_TEXCOORD4 = vec3(xl_retval.viewDir);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 387
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 418
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 457
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 384
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 398
#line 406
#line 425
#line 467
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 493
#line 398
mediump vec4 LightingBlinnPhongEditor_PrePass( in EditorSurfaceOutput s, in mediump vec4 light ) {
    mediump vec3 spec = (light.w * s.Gloss);
    mediump vec4 c;
    #line 402
    c.xyz = ((s.Albedo * light.xyz) + (light.xyz * spec));
    c.w = s.Alpha;
    return c;
}
#line 172
lowp float Luminance( in lowp vec3 c ) {
    #line 174
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 406
mediump vec4 LightingBlinnPhongEditor( in EditorSurfaceOutput s, in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diff = max( 0.0, dot( lightDir, s.Normal));
    #line 410
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    mediump vec4 res;
    res.xyz = (_LightColor0.xyz * diff);
    #line 414
    res.w = (spec * Luminance( _LightColor0.xyz));
    res *= (atten * 2.0);
    return LightingBlinnPhongEditor_PrePass( s, res);
}
#line 271
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 273
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 432
void surf( in Input IN, inout EditorSurfaceOutput o ) {
    #line 434
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Alpha = 1.0;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 438
    o.Gloss = vec3( 0.0);
    o.Specular = 0.0;
    o.Custom = vec4( 0.0);
    highp vec4 Tex2D1 = texture( _Diffuse, IN.uv_Diffuse.xyxy.xy);
    #line 442
    highp vec4 Multiply1 = (_MainColor * Tex2D1);
    highp vec4 Tex2D0 = texture( _Normal, IN.uv_Normal.xyxy.xy);
    highp vec4 UnpackNormal0 = vec4( UnpackNormal( Tex2D0).xyz, 1.0);
    highp vec4 Tex2D2 = texture( _Specular, IN.uv_Specular.xyxy.xy);
    #line 446
    highp vec4 Multiply0 = (Tex2D2 * vec4( _Specular_Power));
    highp vec4 Master0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_5_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    #line 450
    highp vec4 Master0_7_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_6_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    o.Albedo = vec3( Multiply1);
    o.Normal = vec3( UnpackNormal0);
    #line 454
    o.Gloss = vec3( Multiply0);
    o.Normal = normalize(o.Normal);
}
#line 493
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_Diffuse = IN.pack0.xy;
    #line 497
    surfIN.uv_Normal = IN.pack0.zw;
    surfIN.uv_Specular = IN.pack1.xy;
    EditorSurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 501
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    surf( surfIN, o);
    #line 505
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    c = LightingBlinnPhongEditor( o, IN.lightDir, normalize(IN.viewDir), atten);
    c.xyz += (o.Albedo * IN.vlight);
    #line 509
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec2(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 31 [unity_Scale]
Vector 32 [_Diffuse_ST]
Vector 33 [_Normal_ST]
Vector 34 [_Specular_ST]
"!!ARBvp1.0
# 81 ALU
PARAM c[35] = { { 1, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..34] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[31].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[17];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[16];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[18];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[19];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[21];
MAD R1.xyz, R0.x, c[20], R1;
MAD R0.xyz, R0.z, c[22], R1;
MAD R1.xyz, R0.w, c[23], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R3.z, R0, c[29];
DP4 R3.y, R0, c[28];
DP4 R3.x, R0, c[27];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[30];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R4, c[26];
DP4 R2.y, R4, c[25];
DP4 R2.x, R4, c[24];
ADD R2.xyz, R2, R3;
ADD R0.xyz, R2, R0;
ADD result.texcoord[3].xyz, R0, R1;
MOV R1.xyz, c[13];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[31].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1, c[15];
MUL R0.xyz, R0, vertex.attrib[14].w;
DP4 R3.z, R1, c[11];
DP4 R3.y, R1, c[10];
DP4 R3.x, R1, c[9];
DP3 result.texcoord[2].y, R3, R0;
DP3 result.texcoord[4].y, R0, R2;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].z;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
ADD result.texcoord[5].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[5].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[33].xyxy, c[33];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[32], c[32].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[34], c[34].zwzw;
END
# 81 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 31 [unity_Scale]
Vector 32 [_Diffuse_ST]
Vector 33 [_Normal_ST]
Vector 34 [_Specular_ST]
"vs_2_0
; 84 ALU
def c35, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c31.w
dp4 r0.x, v0, c5
add r1, -r0.x, c17
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c16
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c35.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c18
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c19
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c35.x
dp4 r2.z, r4, c26
dp4 r2.y, r4, c25
dp4 r2.x, r4, c24
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c35.y
mul r0, r0, r1
mul r1.xyz, r0.y, c21
mad r1.xyz, r0.x, c20, r1
mad r0.xyz, r0.z, c22, r1
mad r1.xyz, r0.w, c23, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c29
dp4 r3.y, r0, c28
dp4 r3.x, r0, c27
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c30
add r2.xyz, r2, r3
add r0.xyz, r2, r0
add oT3.xyz, r0, r1
mov r1.w, c35.x
mov r1.xyz, c12
dp4 r0.z, r1, c10
dp4 r0.y, r1, c9
dp4 r0.x, r1, c8
mad r3.xyz, r0, c31.w, -v0
mov r1.xyz, v1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r1.yzxw
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c8
dp4 r4.x, c15, r0
mov r1, c9
dp4 r4.y, c15, r1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c35.z
mul r1.y, r1, c13.x
dp3 oT2.y, r4, r2
dp3 oT4.y, r2, r3
dp3 oT2.z, v2, r4
dp3 oT2.x, r4, v1
dp3 oT4.z, v2, r3
dp3 oT4.x, v1, r3
mad oT5.xy, r1.z, c14.zwzw, r1
mov oPos, r0
mov oT5.zw, r0
mad oT0.zw, v3.xyxy, c33.xyxy, c33
mad oT0.xy, v3, c32, c32.zwzw
mad oT1.xy, v3, c34, c34.zwzw
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_8;
  mediump vec3 tmpvar_15;
  mediump vec4 normal_16;
  normal_16 = tmpvar_14;
  highp float vC_17;
  mediump vec3 x3_18;
  mediump vec3 x2_19;
  mediump vec3 x1_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAr, normal_16);
  x1_20.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAg, normal_16);
  x1_20.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAb, normal_16);
  x1_20.z = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = (normal_16.xyzz * normal_16.yzzx);
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBr, tmpvar_24);
  x2_19.x = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBg, tmpvar_24);
  x2_19.y = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBb, tmpvar_24);
  x2_19.z = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y));
  vC_17 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (unity_SHC.xyz * vC_17);
  x3_18 = tmpvar_29;
  tmpvar_15 = ((x1_20 + x2_19) + x3_18);
  shlight_3 = tmpvar_15;
  tmpvar_6 = shlight_3;
  highp vec3 tmpvar_30;
  tmpvar_30 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosX0 - tmpvar_30.x);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosY0 - tmpvar_30.y);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosZ0 - tmpvar_30.z);
  highp vec4 tmpvar_34;
  tmpvar_34 = (((tmpvar_31 * tmpvar_31) + (tmpvar_32 * tmpvar_32)) + (tmpvar_33 * tmpvar_33));
  highp vec4 tmpvar_35;
  tmpvar_35 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_31 * tmpvar_8.x) + (tmpvar_32 * tmpvar_8.y)) + (tmpvar_33 * tmpvar_8.z)) * inversesqrt(tmpvar_34))) * (1.0/((1.0 + (tmpvar_34 * unity_4LightAtten0)))));
  highp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_6 + ((((unity_LightColor[0].xyz * tmpvar_35.x) + (unity_LightColor[1].xyz * tmpvar_35.y)) + (unity_LightColor[2].xyz * tmpvar_35.z)) + (unity_LightColor[3].xyz * tmpvar_35.w)));
  tmpvar_6 = tmpvar_36;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = (tmpvar_11 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 Tex2D2_5;
  highp vec4 UnpackNormal0_6;
  highp vec4 Tex2D0_7;
  highp vec4 Tex2D1_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_7 = tmpvar_10;
  lowp vec4 packednormal_11;
  packednormal_11 = Tex2D0_7;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = ((packednormal_11.xyz * 2.0) - 1.0);
  UnpackNormal0_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Specular, xlv_TEXCOORD1);
  Tex2D2_5 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (_MainColor * Tex2D1_8).xyz;
  tmpvar_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = UnpackNormal0_6.xyz;
  tmpvar_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (Tex2D2_5 * vec4(_Specular_Power)).xyz;
  tmpvar_4 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_3);
  tmpvar_3 = tmpvar_17;
  lowp float tmpvar_18;
  mediump float lightShadowDataX_19;
  highp float dist_20;
  lowp float tmpvar_21;
  tmpvar_21 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x;
  dist_20 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = max (float((dist_20 > (xlv_TEXCOORD5.z / xlv_TEXCOORD5.w))), lightShadowDataX_19);
  tmpvar_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD4);
  mediump vec3 lightDir_25;
  lightDir_25 = xlv_TEXCOORD2;
  mediump vec3 viewDir_26;
  viewDir_26 = tmpvar_24;
  mediump float atten_27;
  atten_27 = tmpvar_18;
  mediump vec4 res_28;
  highp float nh_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, dot (tmpvar_17, normalize((lightDir_25 + viewDir_26))));
  nh_29 = tmpvar_30;
  res_28.xyz = (_LightColor0.xyz * max (0.0, dot (lightDir_25, tmpvar_17)));
  lowp float tmpvar_31;
  tmpvar_31 = dot (_LightColor0.xyz, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_32;
  tmpvar_32 = (pow (nh_29, 0.0) * tmpvar_31);
  res_28.w = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (res_28 * (atten_27 * 2.0));
  res_28 = tmpvar_33;
  mediump vec4 c_34;
  c_34.xyz = ((tmpvar_2 * tmpvar_33.xyz) + (tmpvar_33.xyz * (tmpvar_33.w * tmpvar_4)));
  c_34.w = 1.0;
  c_1 = c_34;
  mediump vec3 tmpvar_35;
  tmpvar_35 = (c_1.xyz + (tmpvar_2 * xlv_TEXCOORD3));
  c_1.xyz = tmpvar_35;
  mediump vec3 tmpvar_36;
  tmpvar_36 = c_1.xyz;
  c_1.xyz = tmpvar_36;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_12 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_9;
  mediump vec3 tmpvar_16;
  mediump vec4 normal_17;
  normal_17 = tmpvar_15;
  highp float vC_18;
  mediump vec3 x3_19;
  mediump vec3 x2_20;
  mediump vec3 x1_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAr, normal_17);
  x1_21.x = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAg, normal_17);
  x1_21.y = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHAb, normal_17);
  x1_21.z = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normal_17.xyzz * normal_17.yzzx);
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBr, tmpvar_25);
  x2_20.x = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBg, tmpvar_25);
  x2_20.y = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = dot (unity_SHBb, tmpvar_25);
  x2_20.z = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y));
  vC_18 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = (unity_SHC.xyz * vC_18);
  x3_19 = tmpvar_30;
  tmpvar_16 = ((x1_21 + x2_20) + x3_19);
  shlight_3 = tmpvar_16;
  tmpvar_6 = shlight_3;
  highp vec3 tmpvar_31;
  tmpvar_31 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosX0 - tmpvar_31.x);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosY0 - tmpvar_31.y);
  highp vec4 tmpvar_34;
  tmpvar_34 = (unity_4LightPosZ0 - tmpvar_31.z);
  highp vec4 tmpvar_35;
  tmpvar_35 = (((tmpvar_32 * tmpvar_32) + (tmpvar_33 * tmpvar_33)) + (tmpvar_34 * tmpvar_34));
  highp vec4 tmpvar_36;
  tmpvar_36 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_32 * tmpvar_9.x) + (tmpvar_33 * tmpvar_9.y)) + (tmpvar_34 * tmpvar_9.z)) * inversesqrt(tmpvar_35))) * (1.0/((1.0 + (tmpvar_35 * unity_4LightAtten0)))));
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_6 + ((((unity_LightColor[0].xyz * tmpvar_36.x) + (unity_LightColor[1].xyz * tmpvar_36.y)) + (unity_LightColor[2].xyz * tmpvar_36.z)) + (unity_LightColor[3].xyz * tmpvar_36.w)));
  tmpvar_6 = tmpvar_37;
  highp vec4 o_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_40;
  tmpvar_40.x = tmpvar_39.x;
  tmpvar_40.y = (tmpvar_39.y * _ProjectionParams.x);
  o_38.xy = (tmpvar_40 + tmpvar_39.w);
  o_38.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = (tmpvar_12 * (((_World2Object * tmpvar_14).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD5 = o_38;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 Tex2D2_5;
  highp vec4 UnpackNormal0_6;
  highp vec4 Tex2D0_7;
  highp vec4 Tex2D1_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_7 = tmpvar_10;
  lowp vec4 packednormal_11;
  packednormal_11 = Tex2D0_7;
  lowp vec3 normal_12;
  normal_12.xy = ((packednormal_11.wy * 2.0) - 1.0);
  normal_12.z = sqrt((1.0 - clamp (dot (normal_12.xy, normal_12.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = normal_12;
  UnpackNormal0_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Specular, xlv_TEXCOORD1);
  Tex2D2_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (_MainColor * Tex2D1_8).xyz;
  tmpvar_2 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = UnpackNormal0_6.xyz;
  tmpvar_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (Tex2D2_5 * vec4(_Specular_Power)).xyz;
  tmpvar_4 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_3);
  tmpvar_3 = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(xlv_TEXCOORD4);
  mediump vec3 lightDir_21;
  lightDir_21 = xlv_TEXCOORD2;
  mediump vec3 viewDir_22;
  viewDir_22 = tmpvar_20;
  mediump float atten_23;
  atten_23 = tmpvar_19;
  mediump vec4 res_24;
  highp float nh_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_18, normalize((lightDir_21 + viewDir_22))));
  nh_25 = tmpvar_26;
  res_24.xyz = (_LightColor0.xyz * max (0.0, dot (lightDir_21, tmpvar_18)));
  lowp float tmpvar_27;
  tmpvar_27 = dot (_LightColor0.xyz, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_28;
  tmpvar_28 = (pow (nh_25, 0.0) * tmpvar_27);
  res_24.w = tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = (res_24 * (atten_23 * 2.0));
  res_24 = tmpvar_29;
  mediump vec4 c_30;
  c_30.xyz = ((tmpvar_2 * tmpvar_29.xyz) + (tmpvar_29.xyz * (tmpvar_29.w * tmpvar_4)));
  c_30.w = 1.0;
  c_1 = c_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = (c_1.xyz + (tmpvar_2 * xlv_TEXCOORD3));
  c_1.xyz = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = c_1.xyz;
  c_1.xyz = tmpvar_32;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 18 [unity_4LightAtten0]
Vector 19 [unity_LightColor0]
Vector 20 [unity_LightColor1]
Vector 21 [unity_LightColor2]
Vector 22 [unity_LightColor3]
Vector 23 [unity_SHAr]
Vector 24 [unity_SHAg]
Vector 25 [unity_SHAb]
Vector 26 [unity_SHBr]
Vector 27 [unity_SHBg]
Vector 28 [unity_SHBb]
Vector 29 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 30 [unity_Scale]
Vector 31 [unity_NPOTScale]
Vector 32 [_Diffuse_ST]
Vector 33 [_Normal_ST]
Vector 34 [_Specular_ST]
"agal_vs
c35 1.0 0.0 0.5 0.0
[bc]
adaaaaaaadaaahacabaaaaoeaaaaaaaaboaaaappabaaaaaa mul r3.xyz, a1, c30.w
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.x, a0, c5
bfaaaaaaabaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.x, r0.x
abaaaaaaabaaapacabaaaaaaacaaaaaabaaaaaoeabaaaaaa add r1, r1.x, c16
bcaaaaaaadaaaiacadaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r3.w, r3.xyzz, c5
bcaaaaaaaeaaabacadaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r4.x, r3.xyzz, c4
bcaaaaaaadaaabacadaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r3.x, r3.xyzz, c6
adaaaaaaacaaapacadaaaappacaaaaaaabaaaaoeacaaaaaa mul r2, r3.w, r1
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bfaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r0.x, r0.x
abaaaaaaaaaaapacaaaaaaaaacaaaaaaapaaaaoeabaaaaaa add r0, r0.x, c15
adaaaaaaabaaapacabaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r1, r1, r1
aaaaaaaaaeaaaeacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r4.z, r3.x
adaaaaaaafaaapacaeaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r5, r4.x, r0
abaaaaaaacaaapacafaaaaoeacaaaaaaacaaaaoeacaaaaaa add r2, r5, r2
aaaaaaaaaeaaaiaccdaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r4.w, c35.x
bdaaaaaaaeaaacacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r4.y, a0, c6
adaaaaaaafaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r5, r0, r0
abaaaaaaabaaapacafaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r5, r1
bfaaaaaaaaaaacacaeaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r0.y, r4.y
abaaaaaaaaaaapacaaaaaaffacaaaaaabbaaaaoeabaaaaaa add r0, r0.y, c17
adaaaaaaafaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r5, r0, r0
abaaaaaaabaaapacafaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r5, r1
adaaaaaaaaaaapacadaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r0, r3.x, r0
abaaaaaaaaaaapacaaaaaaoeacaaaaaaacaaaaoeacaaaaaa add r0, r0, r2
adaaaaaaacaaapacabaaaaoeacaaaaaabcaaaaoeabaaaaaa mul r2, r1, c18
aaaaaaaaaeaaacacadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r4.y, r3.w
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
akaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rsq r1.y, r1.y
akaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r1.w, r1.w
akaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rsq r1.z, r1.z
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
abaaaaaaabaaapacacaaaaoeacaaaaaacdaaaaaaabaaaaaa add r1, r2, c35.x
bdaaaaaaacaaaeacaeaaaaoeacaaaaaabjaaaaoeabaaaaaa dp4 r2.z, r4, c25
bdaaaaaaacaaacacaeaaaaoeacaaaaaabiaaaaoeabaaaaaa dp4 r2.y, r4, c24
bdaaaaaaacaaabacaeaaaaoeacaaaaaabhaaaaoeabaaaaaa dp4 r2.x, r4, c23
afaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r1.x, r1.x
afaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rcp r1.y, r1.y
afaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rcp r1.w, r1.w
afaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rcp r1.z, r1.z
ahaaaaaaaaaaapacaaaaaaoeacaaaaaacdaaaaffabaaaaaa max r0, r0, c35.y
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
adaaaaaaabaaahacaaaaaaffacaaaaaabeaaaaoeabaaaaaa mul r1.xyz, r0.y, c20
adaaaaaaafaaahacaaaaaaaaacaaaaaabdaaaaoeabaaaaaa mul r5.xyz, r0.x, c19
abaaaaaaabaaahacafaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r5.xyzz, r1.xyzz
adaaaaaaaaaaahacaaaaaakkacaaaaaabfaaaaoeabaaaaaa mul r0.xyz, r0.z, c21
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaahacaaaaaappacaaaaaabgaaaaoeabaaaaaa mul r1.xyz, r0.w, c22
abaaaaaaabaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r1.xyz, r1.xyzz, r0.xyzz
adaaaaaaaaaaapacaeaaaakeacaaaaaaaeaaaacjacaaaaaa mul r0, r4.xyzz, r4.yzzx
adaaaaaaabaaaiacadaaaappacaaaaaaadaaaappacaaaaaa mul r1.w, r3.w, r3.w
bdaaaaaaadaaaeacaaaaaaoeacaaaaaabmaaaaoeabaaaaaa dp4 r3.z, r0, c28
bdaaaaaaadaaacacaaaaaaoeacaaaaaablaaaaoeabaaaaaa dp4 r3.y, r0, c27
bdaaaaaaadaaabacaaaaaaoeacaaaaaabkaaaaoeabaaaaaa dp4 r3.x, r0, c26
adaaaaaaafaaaiacaeaaaaaaacaaaaaaaeaaaaaaacaaaaaa mul r5.w, r4.x, r4.x
acaaaaaaabaaaiacafaaaappacaaaaaaabaaaappacaaaaaa sub r1.w, r5.w, r1.w
adaaaaaaaaaaahacabaaaappacaaaaaabnaaaaoeabaaaaaa mul r0.xyz, r1.w, c29
abaaaaaaacaaahacacaaaakeacaaaaaaadaaaakeacaaaaaa add r2.xyz, r2.xyzz, r3.xyzz
abaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaadaaahaeaaaaaakeacaaaaaaabaaaakeacaaaaaa add v3.xyz, r0.xyzz, r1.xyzz
aaaaaaaaabaaaiaccdaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r1.w, c35.x
aaaaaaaaabaaahacamaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, c12
bdaaaaaaaaaaaeacabaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r0.z, r1, c10
bdaaaaaaaaaaacacabaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r0.y, r1, c9
bdaaaaaaaaaaabacabaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r0.x, r1, c8
adaaaaaaafaaahacaaaaaakeacaaaaaaboaaaappabaaaaaa mul r5.xyz, r0.xyzz, c30.w
acaaaaaaadaaahacafaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r5.xyzz, a0
aaaaaaaaabaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, a5
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaabaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r1.yzxx
adaaaaaaafaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r5.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacafaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r5.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaaeaaaeacaoaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c14, r0
aaaaaaaaaaaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c8
bdaaaaaaaeaaabacaoaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.x, c14, r0
aaaaaaaaabaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c9
bdaaaaaaaeaaacacaoaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.y, c14, r1
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 r0.w, a0, c3
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r0.z, a0, c2
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 r0.x, a0, c0
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 r0.y, a0, c1
adaaaaaaabaaahacaaaaaapeacaaaaaacdaaaakkabaaaaaa mul r1.xyz, r0.xyww, c35.z
adaaaaaaabaaacacabaaaaffacaaaaaaanaaaaaaabaaaaaa mul r1.y, r1.y, c13.x
abaaaaaaabaaadacabaaaafeacaaaaaaabaaaakkacaaaaaa add r1.xy, r1.xyyy, r1.z
bcaaaaaaacaaacaeaeaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v2.y, r4.xyzz, r2.xyzz
bcaaaaaaaeaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v4.y, r2.xyzz, r3.xyzz
bcaaaaaaacaaaeaeabaaaaoeaaaaaaaaaeaaaakeacaaaaaa dp3 v2.z, a1, r4.xyzz
bcaaaaaaacaaabaeaeaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v2.x, r4.xyzz, a5
bcaaaaaaaeaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v4.z, a1, r3.xyzz
bcaaaaaaaeaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v4.x, a5, r3.xyzz
adaaaaaaafaaadaeabaaaafeacaaaaaabpaaaaoeabaaaaaa mul v5.xy, r1.xyyy, c31
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
aaaaaaaaafaaamaeaaaaaaopacaaaaaaaaaaaaaaaaaaaaaa mov v5.zw, r0.wwzw
adaaaaaaafaaamacadaaaaeeaaaaaaaacbaaaaeeabaaaaaa mul r5.zw, a3.xyxy, c33.xyxy
abaaaaaaaaaaamaeafaaaaopacaaaaaacbaaaaoeabaaaaaa add v0.zw, r5.wwzw, c33
adaaaaaaafaaadacadaaaaoeaaaaaaaacaaaaaoeabaaaaaa mul r5.xy, a3, c32
abaaaaaaaaaaadaeafaaaafeacaaaaaacaaaaaooabaaaaaa add v0.xy, r5.xyyy, c32.zwzw
adaaaaaaafaaadacadaaaaoeaaaaaaaaccaaaaoeabaaaaaa mul r5.xy, a3, c34
abaaaaaaabaaadaeafaaaafeacaaaaaaccaaaaooabaaaaaa add v1.xy, r5.xyyy, c34.zwzw
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 395
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 426
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 465
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 384
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 392
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 406
#line 414
#line 433
#line 476
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 81
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 90
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 95
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    highp vec4 toLightY = (lightPosY - pos.y);
    #line 99
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    #line 103
    lengthSq += (toLightZ * toLightZ);
    highp vec4 ndotl = vec4( 0.0);
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    #line 107
    ndotl += (toLightZ * normal.z);
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 111
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    col += (lightColor1 * diff.y);
    #line 115
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 136
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 140
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 144
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 148
    return ((x1 + x2) + x3);
}
#line 433
void vert( inout appdata_full v, out Input o ) {
    highp vec4 VertexOutputMaster0_0_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_1_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    #line 437
    highp vec4 VertexOutputMaster0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
}
#line 479
v2f_surf vert_surf( in appdata_full v ) {
    #line 481
    v2f_surf o;
    Input customInputData;
    vert( v, customInputData);
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 485
    o.pack0.xy = ((v.texcoord.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _Normal_ST.xy) + _Normal_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Specular_ST.xy) + _Specular_ST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 489
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 493
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    #line 497
    highp vec3 worldPos = (_Object2World * v.vertex).xyz;
    o.vlight += Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldN);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 501
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec2(xl_retval.pack1);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
    xlv_TEXCOORD4 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD5 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 395
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 426
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 465
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 384
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 392
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 406
#line 414
#line 433
#line 476
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 406
mediump vec4 LightingBlinnPhongEditor_PrePass( in EditorSurfaceOutput s, in mediump vec4 light ) {
    mediump vec3 spec = (light.w * s.Gloss);
    mediump vec4 c;
    #line 410
    c.xyz = ((s.Albedo * light.xyz) + (light.xyz * spec));
    c.w = s.Alpha;
    return c;
}
#line 172
lowp float Luminance( in lowp vec3 c ) {
    #line 174
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 414
mediump vec4 LightingBlinnPhongEditor( in EditorSurfaceOutput s, in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diff = max( 0.0, dot( lightDir, s.Normal));
    #line 418
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    mediump vec4 res;
    res.xyz = (_LightColor0.xyz * diff);
    #line 422
    res.w = (spec * Luminance( _LightColor0.xyz));
    res *= (atten * 2.0);
    return LightingBlinnPhongEditor_PrePass( s, res);
}
#line 271
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 273
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 440
void surf( in Input IN, inout EditorSurfaceOutput o ) {
    #line 442
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Alpha = 1.0;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 446
    o.Gloss = vec3( 0.0);
    o.Specular = 0.0;
    o.Custom = vec4( 0.0);
    highp vec4 Tex2D1 = texture( _Diffuse, IN.uv_Diffuse.xyxy.xy);
    #line 450
    highp vec4 Multiply1 = (_MainColor * Tex2D1);
    highp vec4 Tex2D0 = texture( _Normal, IN.uv_Normal.xyxy.xy);
    highp vec4 UnpackNormal0 = vec4( UnpackNormal( Tex2D0).xyz, 1.0);
    highp vec4 Tex2D2 = texture( _Specular, IN.uv_Specular.xyxy.xy);
    #line 454
    highp vec4 Multiply0 = (Tex2D2 * vec4( _Specular_Power));
    highp vec4 Master0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_5_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    #line 458
    highp vec4 Master0_7_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_6_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    o.Albedo = vec3( Multiply1);
    o.Normal = vec3( UnpackNormal0);
    #line 462
    o.Gloss = vec3( Multiply0);
    o.Normal = normalize(o.Normal);
}
#line 384
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 388
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 503
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 505
    Input surfIN;
    surfIN.uv_Diffuse = IN.pack0.xy;
    surfIN.uv_Normal = IN.pack0.zw;
    surfIN.uv_Specular = IN.pack1.xy;
    #line 509
    EditorSurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 513
    o.Alpha = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 517
    c = LightingBlinnPhongEditor( o, IN.lightDir, normalize(IN.viewDir), atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec2(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (tmpvar_7 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_14;
  mediump vec4 normal_15;
  normal_15 = tmpvar_13;
  highp float vC_16;
  mediump vec3 x3_17;
  mediump vec3 x2_18;
  mediump vec3 x1_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHAr, normal_15);
  x1_19.x = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAg, normal_15);
  x1_19.y = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAb, normal_15);
  x1_19.z = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normal_15.xyzz * normal_15.yzzx);
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHBr, tmpvar_23);
  x2_18.x = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBg, tmpvar_23);
  x2_18.y = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBb, tmpvar_23);
  x2_18.z = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y));
  vC_16 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = (unity_SHC.xyz * vC_16);
  x3_17 = tmpvar_28;
  tmpvar_14 = ((x1_19 + x2_18) + x3_17);
  shlight_3 = tmpvar_14;
  tmpvar_6 = shlight_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = (tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 Tex2D2_5;
  highp vec4 UnpackNormal0_6;
  highp vec4 Tex2D0_7;
  highp vec4 Tex2D1_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_7 = tmpvar_10;
  lowp vec4 packednormal_11;
  packednormal_11 = Tex2D0_7;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = ((packednormal_11.xyz * 2.0) - 1.0);
  UnpackNormal0_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Specular, xlv_TEXCOORD1);
  Tex2D2_5 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (_MainColor * Tex2D1_8).xyz;
  tmpvar_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = UnpackNormal0_6.xyz;
  tmpvar_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (Tex2D2_5 * vec4(_Specular_Power)).xyz;
  tmpvar_4 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_3);
  tmpvar_3 = tmpvar_17;
  lowp float shadow_18;
  lowp float tmpvar_19;
  tmpvar_19 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD5.xyz);
  highp float tmpvar_20;
  tmpvar_20 = (_LightShadowData.x + (tmpvar_19 * (1.0 - _LightShadowData.x)));
  shadow_18 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD4);
  mediump vec3 lightDir_22;
  lightDir_22 = xlv_TEXCOORD2;
  mediump vec3 viewDir_23;
  viewDir_23 = tmpvar_21;
  mediump float atten_24;
  atten_24 = shadow_18;
  mediump vec4 res_25;
  highp float nh_26;
  mediump float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_17, normalize((lightDir_22 + viewDir_23))));
  nh_26 = tmpvar_27;
  res_25.xyz = (_LightColor0.xyz * max (0.0, dot (lightDir_22, tmpvar_17)));
  lowp float tmpvar_28;
  tmpvar_28 = dot (_LightColor0.xyz, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_29;
  tmpvar_29 = (pow (nh_26, 0.0) * tmpvar_28);
  res_25.w = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30 = (res_25 * (atten_24 * 2.0));
  res_25 = tmpvar_30;
  mediump vec4 c_31;
  c_31.xyz = ((tmpvar_2 * tmpvar_30.xyz) + (tmpvar_30.xyz * (tmpvar_30.w * tmpvar_4)));
  c_31.w = 1.0;
  c_1 = c_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = (c_1.xyz + (tmpvar_2 * xlv_TEXCOORD3));
  c_1.xyz = tmpvar_32;
  mediump vec3 tmpvar_33;
  tmpvar_33 = c_1.xyz;
  c_1.xyz = tmpvar_33;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 395
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 426
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 465
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 384
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 392
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 406
#line 414
#line 433
#line 476
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 501
#line 81
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 90
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 136
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 140
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 144
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 148
    return ((x1 + x2) + x3);
}
#line 433
void vert( inout appdata_full v, out Input o ) {
    highp vec4 VertexOutputMaster0_0_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_1_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    #line 437
    highp vec4 VertexOutputMaster0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
}
#line 479
v2f_surf vert_surf( in appdata_full v ) {
    #line 481
    v2f_surf o;
    Input customInputData;
    vert( v, customInputData);
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 485
    o.pack0.xy = ((v.texcoord.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _Normal_ST.xy) + _Normal_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Specular_ST.xy) + _Specular_ST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 489
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 493
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    #line 497
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec2(xl_retval.pack1);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
    xlv_TEXCOORD4 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD5 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 395
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 426
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 465
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 384
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 392
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 406
#line 414
#line 433
#line 476
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 501
#line 406
mediump vec4 LightingBlinnPhongEditor_PrePass( in EditorSurfaceOutput s, in mediump vec4 light ) {
    mediump vec3 spec = (light.w * s.Gloss);
    mediump vec4 c;
    #line 410
    c.xyz = ((s.Albedo * light.xyz) + (light.xyz * spec));
    c.w = s.Alpha;
    return c;
}
#line 172
lowp float Luminance( in lowp vec3 c ) {
    #line 174
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 414
mediump vec4 LightingBlinnPhongEditor( in EditorSurfaceOutput s, in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diff = max( 0.0, dot( lightDir, s.Normal));
    #line 418
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    mediump vec4 res;
    res.xyz = (_LightColor0.xyz * diff);
    #line 422
    res.w = (spec * Luminance( _LightColor0.xyz));
    res *= (atten * 2.0);
    return LightingBlinnPhongEditor_PrePass( s, res);
}
#line 271
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 273
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 440
void surf( in Input IN, inout EditorSurfaceOutput o ) {
    #line 442
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Alpha = 1.0;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 446
    o.Gloss = vec3( 0.0);
    o.Specular = 0.0;
    o.Custom = vec4( 0.0);
    highp vec4 Tex2D1 = texture( _Diffuse, IN.uv_Diffuse.xyxy.xy);
    #line 450
    highp vec4 Multiply1 = (_MainColor * Tex2D1);
    highp vec4 Tex2D0 = texture( _Normal, IN.uv_Normal.xyxy.xy);
    highp vec4 UnpackNormal0 = vec4( UnpackNormal( Tex2D0).xyz, 1.0);
    highp vec4 Tex2D2 = texture( _Specular, IN.uv_Specular.xyxy.xy);
    #line 454
    highp vec4 Multiply0 = (Tex2D2 * vec4( _Specular_Power));
    highp vec4 Master0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_5_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    #line 458
    highp vec4 Master0_7_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_6_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    o.Albedo = vec3( Multiply1);
    o.Normal = vec3( UnpackNormal0);
    #line 462
    o.Gloss = vec3( Multiply0);
    o.Normal = normalize(o.Normal);
}
#line 384
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 388
    return shadow;
}
#line 501
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_Diffuse = IN.pack0.xy;
    #line 505
    surfIN.uv_Normal = IN.pack0.zw;
    surfIN.uv_Specular = IN.pack1.xy;
    EditorSurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 509
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    surf( surfIN, o);
    #line 513
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    c = LightingBlinnPhongEditor( o, IN.lightDir, normalize(IN.viewDir), atten);
    c.xyz += (o.Albedo * IN.vlight);
    #line 517
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec2(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform highp vec4 _MainColor;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 UnpackNormal0_4;
  highp vec4 Tex2D0_5;
  highp vec4 Tex2D1_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_5 = tmpvar_8;
  lowp vec4 packednormal_9;
  packednormal_9 = Tex2D0_5;
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((packednormal_9.xyz * 2.0) - 1.0);
  UnpackNormal0_4 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (_MainColor * Tex2D1_6).xyz;
  tmpvar_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = UnpackNormal0_4.xyz;
  tmpvar_3 = tmpvar_12;
  tmpvar_3 = normalize(tmpvar_3);
  lowp float shadow_13;
  lowp float tmpvar_14;
  tmpvar_14 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_15;
  tmpvar_15 = (_LightShadowData.x + (tmpvar_14 * (1.0 - _LightShadowData.x)));
  shadow_13 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz), vec3((shadow_13 * 2.0)));
  mediump vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_2 * tmpvar_16);
  c_1.xyz = tmpvar_17;
  c_1.w = 1.0;
  mediump vec3 tmpvar_18;
  tmpvar_18 = c_1.xyz;
  c_1.xyz = tmpvar_18;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 395
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 426
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 465
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 384
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 392
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 406
#line 414
#line 433
#line 474
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 478
uniform sampler2D unity_Lightmap;
#line 81
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 433
void vert( inout appdata_full v, out Input o ) {
    highp vec4 VertexOutputMaster0_0_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_1_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    #line 437
    highp vec4 VertexOutputMaster0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
}
#line 478
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 482
    vert( v, customInputData);
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _Normal_ST.xy) + _Normal_ST.zw);
    #line 486
    o.pack1.xy = ((v.texcoord.xy * _Specular_ST.xy) + _Specular_ST.zw);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 490
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 494
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec2(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.lmap);
    xlv_TEXCOORD3 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 395
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 426
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 465
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 384
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 392
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 406
#line 414
#line 433
#line 474
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 478
uniform sampler2D unity_Lightmap;
#line 176
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 178
    return (2.0 * color.xyz);
}
#line 271
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 273
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 440
void surf( in Input IN, inout EditorSurfaceOutput o ) {
    #line 442
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Alpha = 1.0;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 446
    o.Gloss = vec3( 0.0);
    o.Specular = 0.0;
    o.Custom = vec4( 0.0);
    highp vec4 Tex2D1 = texture( _Diffuse, IN.uv_Diffuse.xyxy.xy);
    #line 450
    highp vec4 Multiply1 = (_MainColor * Tex2D1);
    highp vec4 Tex2D0 = texture( _Normal, IN.uv_Normal.xyxy.xy);
    highp vec4 UnpackNormal0 = vec4( UnpackNormal( Tex2D0).xyz, 1.0);
    highp vec4 Tex2D2 = texture( _Specular, IN.uv_Specular.xyxy.xy);
    #line 454
    highp vec4 Multiply0 = (Tex2D2 * vec4( _Specular_Power));
    highp vec4 Master0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_5_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    #line 458
    highp vec4 Master0_7_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_6_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    o.Albedo = vec3( Multiply1);
    o.Normal = vec3( UnpackNormal0);
    #line 462
    o.Gloss = vec3( Multiply0);
    o.Normal = normalize(o.Normal);
}
#line 384
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 388
    return shadow;
}
#line 497
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 499
    Input surfIN;
    surfIN.uv_Diffuse = IN.pack0.xy;
    surfIN.uv_Normal = IN.pack0.zw;
    surfIN.uv_Specular = IN.pack1.xy;
    #line 503
    EditorSurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 507
    o.Alpha = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 511
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec3 lm = DecodeLightmap( lmtex);
    c.xyz += (o.Albedo * min( lm, vec3( (atten * 2.0))));
    c.w = o.Alpha;
    #line 515
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec2(xlv_TEXCOORD1);
    xlt_IN.lmap = vec2(xlv_TEXCOORD2);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_8;
  mediump vec3 tmpvar_15;
  mediump vec4 normal_16;
  normal_16 = tmpvar_14;
  highp float vC_17;
  mediump vec3 x3_18;
  mediump vec3 x2_19;
  mediump vec3 x1_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAr, normal_16);
  x1_20.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAg, normal_16);
  x1_20.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAb, normal_16);
  x1_20.z = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = (normal_16.xyzz * normal_16.yzzx);
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBr, tmpvar_24);
  x2_19.x = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBg, tmpvar_24);
  x2_19.y = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBb, tmpvar_24);
  x2_19.z = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y));
  vC_17 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (unity_SHC.xyz * vC_17);
  x3_18 = tmpvar_29;
  tmpvar_15 = ((x1_20 + x2_19) + x3_18);
  shlight_3 = tmpvar_15;
  tmpvar_6 = shlight_3;
  highp vec3 tmpvar_30;
  tmpvar_30 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosX0 - tmpvar_30.x);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosY0 - tmpvar_30.y);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosZ0 - tmpvar_30.z);
  highp vec4 tmpvar_34;
  tmpvar_34 = (((tmpvar_31 * tmpvar_31) + (tmpvar_32 * tmpvar_32)) + (tmpvar_33 * tmpvar_33));
  highp vec4 tmpvar_35;
  tmpvar_35 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_31 * tmpvar_8.x) + (tmpvar_32 * tmpvar_8.y)) + (tmpvar_33 * tmpvar_8.z)) * inversesqrt(tmpvar_34))) * (1.0/((1.0 + (tmpvar_34 * unity_4LightAtten0)))));
  highp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_6 + ((((unity_LightColor[0].xyz * tmpvar_35.x) + (unity_LightColor[1].xyz * tmpvar_35.y)) + (unity_LightColor[2].xyz * tmpvar_35.z)) + (unity_LightColor[3].xyz * tmpvar_35.w)));
  tmpvar_6 = tmpvar_36;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = (tmpvar_11 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 Tex2D2_5;
  highp vec4 UnpackNormal0_6;
  highp vec4 Tex2D0_7;
  highp vec4 Tex2D1_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_7 = tmpvar_10;
  lowp vec4 packednormal_11;
  packednormal_11 = Tex2D0_7;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = ((packednormal_11.xyz * 2.0) - 1.0);
  UnpackNormal0_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Specular, xlv_TEXCOORD1);
  Tex2D2_5 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (_MainColor * Tex2D1_8).xyz;
  tmpvar_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = UnpackNormal0_6.xyz;
  tmpvar_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (Tex2D2_5 * vec4(_Specular_Power)).xyz;
  tmpvar_4 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_3);
  tmpvar_3 = tmpvar_17;
  lowp float shadow_18;
  lowp float tmpvar_19;
  tmpvar_19 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD5.xyz);
  highp float tmpvar_20;
  tmpvar_20 = (_LightShadowData.x + (tmpvar_19 * (1.0 - _LightShadowData.x)));
  shadow_18 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD4);
  mediump vec3 lightDir_22;
  lightDir_22 = xlv_TEXCOORD2;
  mediump vec3 viewDir_23;
  viewDir_23 = tmpvar_21;
  mediump float atten_24;
  atten_24 = shadow_18;
  mediump vec4 res_25;
  highp float nh_26;
  mediump float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_17, normalize((lightDir_22 + viewDir_23))));
  nh_26 = tmpvar_27;
  res_25.xyz = (_LightColor0.xyz * max (0.0, dot (lightDir_22, tmpvar_17)));
  lowp float tmpvar_28;
  tmpvar_28 = dot (_LightColor0.xyz, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_29;
  tmpvar_29 = (pow (nh_26, 0.0) * tmpvar_28);
  res_25.w = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30 = (res_25 * (atten_24 * 2.0));
  res_25 = tmpvar_30;
  mediump vec4 c_31;
  c_31.xyz = ((tmpvar_2 * tmpvar_30.xyz) + (tmpvar_30.xyz * (tmpvar_30.w * tmpvar_4)));
  c_31.w = 1.0;
  c_1 = c_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = (c_1.xyz + (tmpvar_2 * xlv_TEXCOORD3));
  c_1.xyz = tmpvar_32;
  mediump vec3 tmpvar_33;
  tmpvar_33 = c_1.xyz;
  c_1.xyz = tmpvar_33;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 395
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 426
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 465
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 384
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 392
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 406
#line 414
#line 433
#line 476
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 81
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 90
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 95
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    highp vec4 toLightY = (lightPosY - pos.y);
    #line 99
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    #line 103
    lengthSq += (toLightZ * toLightZ);
    highp vec4 ndotl = vec4( 0.0);
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    #line 107
    ndotl += (toLightZ * normal.z);
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 111
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    col += (lightColor1 * diff.y);
    #line 115
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 136
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 140
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 144
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 148
    return ((x1 + x2) + x3);
}
#line 433
void vert( inout appdata_full v, out Input o ) {
    highp vec4 VertexOutputMaster0_0_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_1_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    #line 437
    highp vec4 VertexOutputMaster0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
}
#line 479
v2f_surf vert_surf( in appdata_full v ) {
    #line 481
    v2f_surf o;
    Input customInputData;
    vert( v, customInputData);
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 485
    o.pack0.xy = ((v.texcoord.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _Normal_ST.xy) + _Normal_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Specular_ST.xy) + _Specular_ST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 489
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 493
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    #line 497
    highp vec3 worldPos = (_Object2World * v.vertex).xyz;
    o.vlight += Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldN);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 501
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec2(xl_retval.pack1);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
    xlv_TEXCOORD4 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD5 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 395
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 426
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 465
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 384
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 392
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 406
#line 414
#line 433
#line 476
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 406
mediump vec4 LightingBlinnPhongEditor_PrePass( in EditorSurfaceOutput s, in mediump vec4 light ) {
    mediump vec3 spec = (light.w * s.Gloss);
    mediump vec4 c;
    #line 410
    c.xyz = ((s.Albedo * light.xyz) + (light.xyz * spec));
    c.w = s.Alpha;
    return c;
}
#line 172
lowp float Luminance( in lowp vec3 c ) {
    #line 174
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 414
mediump vec4 LightingBlinnPhongEditor( in EditorSurfaceOutput s, in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diff = max( 0.0, dot( lightDir, s.Normal));
    #line 418
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    mediump vec4 res;
    res.xyz = (_LightColor0.xyz * diff);
    #line 422
    res.w = (spec * Luminance( _LightColor0.xyz));
    res *= (atten * 2.0);
    return LightingBlinnPhongEditor_PrePass( s, res);
}
#line 271
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 273
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 440
void surf( in Input IN, inout EditorSurfaceOutput o ) {
    #line 442
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Alpha = 1.0;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 446
    o.Gloss = vec3( 0.0);
    o.Specular = 0.0;
    o.Custom = vec4( 0.0);
    highp vec4 Tex2D1 = texture( _Diffuse, IN.uv_Diffuse.xyxy.xy);
    #line 450
    highp vec4 Multiply1 = (_MainColor * Tex2D1);
    highp vec4 Tex2D0 = texture( _Normal, IN.uv_Normal.xyxy.xy);
    highp vec4 UnpackNormal0 = vec4( UnpackNormal( Tex2D0).xyz, 1.0);
    highp vec4 Tex2D2 = texture( _Specular, IN.uv_Specular.xyxy.xy);
    #line 454
    highp vec4 Multiply0 = (Tex2D2 * vec4( _Specular_Power));
    highp vec4 Master0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_5_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    #line 458
    highp vec4 Master0_7_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_6_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    o.Albedo = vec3( Multiply1);
    o.Normal = vec3( UnpackNormal0);
    #line 462
    o.Gloss = vec3( Multiply0);
    o.Normal = normalize(o.Normal);
}
#line 384
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 388
    return shadow;
}
#line 503
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 505
    Input surfIN;
    surfIN.uv_Diffuse = IN.pack0.xy;
    surfIN.uv_Normal = IN.pack0.zw;
    surfIN.uv_Specular = IN.pack1.xy;
    #line 509
    EditorSurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 513
    o.Alpha = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 517
    c = LightingBlinnPhongEditor( o, IN.lightDir, normalize(IN.viewDir), atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec2(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 4
//   opengl - ALU: 7 to 28, TEX: 2 to 4
//   d3d9 - ALU: 6 to 27, TEX: 2 to 4
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 26 ALU, 3 TEX
PARAM c[5] = { program.local[0..2],
		{ 0.2199707, 0.70703125, 0.070983887, 2 },
		{ 1, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MOV R0.w, c[4].x;
MAD R1.xy, R1.wyzw, c[3].w, -R0.w;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R0.w, R1.z, R1;
ADD R0.w, -R0, c[4].x;
RSQ R0.w, R0.w;
RCP R1.z, R0.w;
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R1;
DP3 R0.w, fragment.texcoord[2], R1;
MAX R0.w, R0, c[4].y;
MOV R3.xyz, c[3];
MUL R0.xyz, R0, c[2];
MUL R1.xyz, R0.w, c[0];
DP3 R1.w, R3, c[0];
MUL R1, R1, c[3].w;
MUL R2.xyz, R2, c[1].x;
MUL R2.xyz, R1.w, R2;
MUL R2.xyz, R1, R2;
MAD R1.xyz, R0, R1, R2;
MAD result.color.xyz, R0, fragment.texcoord[3], R1;
MOV result.color.w, c[4].x;
END
# 26 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
"ps_2_0
; 26 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 0.21997070, 0.70703125, 0.07098389, 1.00000000
def c4, 2.00000000, -1.00000000, 0.00000000, 0
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t3.xyz
texld r2, t0, s0
texld r1, t1, s2
mul r2.xyz, r2, c2
mov r0.y, t0.w
mov r0.x, t0.z
mul r1.xyz, r1, c1.x
texld r0, r0, s1
mov r0.x, r0.w
mad_pp r3.xy, r0, c4.x, c4.y
mul_pp r0.xy, r3, r3
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c3.w
rsq_pp r0.x, r0.x
rcp_pp r3.z, r0.x
dp3_pp r0.x, r3, r3
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, r3
dp3_pp r0.x, t2, r0
max_pp r0.x, r0, c4.z
mov_pp r3.xyz, c0
mul_pp r0.xyz, r0.x, c0
dp3_pp r0.w, c3, r3
mul_pp r0, r0, c4.x
mul_pp r1.xyz, r0.w, r1
mul_pp r1.xyz, r0, r1
mad_pp r0.xyz, r2, r0, r1
mov_pp r0.w, c3
mad_pp r0.xyz, r2, t3, r0
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
"agal_ps
c3 0.219971 0.707031 0.070984 1.0
c4 2.0 -1.0 0.0 0.0
[bc]
ciaaaaaaacaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r2, v0, s0 <2d wrap linear point>
ciaaaaaaabaaapacabaaaaoeaeaaaaaaacaaaaaaafaababb tex r1, v1, s2 <2d wrap linear point>
adaaaaaaacaaahacacaaaakeacaaaaaaacaaaaoeabaaaaaa mul r2.xyz, r2.xyzz, c2
aaaaaaaaaaaaacacaaaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v0.w
aaaaaaaaaaaaabacaaaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v0.z
adaaaaaaabaaahacabaaaakeacaaaaaaabaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c1.x
ciaaaaaaaaaaapacaaaaaafeacaaaaaaabaaaaaaafaababb tex r0, r0.xyyy, s1 <2d wrap linear point>
aaaaaaaaaaaaabacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r0.w
adaaaaaaadaaadacaaaaaafeacaaaaaaaeaaaaaaabaaaaaa mul r3.xy, r0.xyyy, c4.x
abaaaaaaadaaadacadaaaafeacaaaaaaaeaaaaffabaaaaaa add r3.xy, r3.xyyy, c4.y
adaaaaaaaaaaabacadaaaaffacaaaaaaadaaaaffacaaaaaa mul r0.x, r3.y, r3.y
bfaaaaaaabaaaiacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.w, r3.x
adaaaaaaabaaaiacabaaaappacaaaaaaadaaaaaaacaaaaaa mul r1.w, r1.w, r3.x
acaaaaaaaaaaabacabaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r1.w, r0.x
abaaaaaaaaaaabacaaaaaaaaacaaaaaaadaaaappabaaaaaa add r0.x, r0.x, c3.w
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
afaaaaaaadaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r3.z, r0.x
bcaaaaaaaaaaabacadaaaakeacaaaaaaadaaaakeacaaaaaa dp3 r0.x, r3.xyzz, r3.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaadaaaakeacaaaaaa mul r0.xyz, r0.x, r3.xyzz
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaaaaaaakeacaaaaaa dp3 r0.x, v2, r0.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaakkabaaaaaa max r0.x, r0.x, c4.z
aaaaaaaaadaaahacaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r3.xyz, c0
adaaaaaaaaaaahacaaaaaaaaacaaaaaaaaaaaaoeabaaaaaa mul r0.xyz, r0.x, c0
bcaaaaaaaaaaaiacadaaaaoeabaaaaaaadaaaakeacaaaaaa dp3 r0.w, c3, r3.xyzz
adaaaaaaaaaaapacaaaaaaoeacaaaaaaaeaaaaaaabaaaaaa mul r0, r0, c4.x
adaaaaaaabaaahacaaaaaappacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.w, r1.xyzz
adaaaaaaabaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.xyzz, r1.xyzz
adaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
aaaaaaaaaaaaaiacadaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c3
adaaaaaaabaaahacacaaaakeacaaaaaaadaaaaoeaeaaaaaa mul r1.xyz, r2.xyzz, v3
abaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r1.xyzz, r0.xyzz
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 2 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 7 ALU, 2 TEX
PARAM c[2] = { program.local[0],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[2], 2D;
MUL R1.xyz, R1, c[0];
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[1].y;
MOV result.color.w, c[1].x;
END
# 7 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 2 [unity_Lightmap] 2D
"ps_2_0
; 6 ALU, 2 TEX
dcl_2d s0
dcl_2d s2
def c1, 8.00000000, 1.00000000, 0, 0
dcl t0.xy
dcl t2.xy
texld r1, t0, s0
texld r0, t2, s2
mul_pp r0.xyz, r0.w, r0
mul r1.xyz, r1, c0
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c1.x
mov_pp r0.w, c1.y
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 2 [unity_Lightmap] 2D
"agal_ps
c1 8.0 1.0 0.0 0.0
[bc]
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r1, v0, s0 <2d wrap linear point>
ciaaaaaaaaaaapacacaaaaoeaeaaaaaaacaaaaaaafaababb tex r0, v2, s2 <2d wrap linear point>
adaaaaaaaaaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r0.w, r0.xyzz
adaaaaaaabaaahacabaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r1.xyzz, c0
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaaaabaaaaaa mul r0.xyz, r0.xyzz, c1.x
aaaaaaaaaaaaaiacabaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c1.y
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_ShadowMapTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 28 ALU, 4 TEX
PARAM c[5] = { program.local[0..2],
		{ 0.2199707, 0.70703125, 0.070983887, 2 },
		{ 1, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R2.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R0.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TXP R3.x, fragment.texcoord[5], texture[3], 2D;
MOV R0.w, c[4].x;
MAD R1.xy, R1.wyzw, c[3].w, -R0.w;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R0.w, R1.z, R1;
MOV R3.yzw, c[3].xxyz;
ADD R0.w, -R0, c[4].x;
RSQ R0.w, R0.w;
RCP R1.z, R0.w;
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R1;
DP3 R0.w, fragment.texcoord[2], R1;
MAX R0.w, R0, c[4].y;
MUL R1.xyz, R0.w, c[0];
DP3 R1.w, R3.yzww, c[0];
MUL R1, R3.x, R1;
MUL R3.xyz, R0, c[1].x;
MUL R0, R1, c[3].w;
MUL R1.xyz, R0.w, R3;
MUL R2.xyz, R2, c[2];
MUL R1.xyz, R0, R1;
MAD R0.xyz, R2, R0, R1;
MAD result.color.xyz, R2, fragment.texcoord[3], R0;
MOV result.color.w, c[4].x;
END
# 28 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_ShadowMapTexture] 2D
"ps_2_0
; 27 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.21997070, 0.70703125, 0.07098389, 1.00000000
def c4, 2.00000000, -1.00000000, 0.00000000, 0
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t3.xyz
dcl t5
texld r2, t0, s0
texldp r4, t5, s3
texld r1, t1, s2
mul r2.xyz, r2, c2
mov r0.y, t0.w
mov r0.x, t0.z
mul r1.xyz, r1, c1.x
texld r0, r0, s1
mov r0.x, r0.w
mad_pp r3.xy, r0, c4.x, c4.y
mul_pp r0.xy, r3, r3
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c3.w
rsq_pp r0.x, r0.x
rcp_pp r3.z, r0.x
dp3_pp r0.x, r3, r3
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, r3
dp3_pp r0.x, t2, r0
max_pp r0.x, r0, c4.z
mov_pp r3.xyz, c0
mul_pp r0.xyz, r0.x, c0
dp3_pp r0.w, c3, r3
mul_pp r0, r4.x, r0
mul_pp r0, r0, c4.x
mul_pp r1.xyz, r0.w, r1
mul_pp r1.xyz, r0, r1
mad_pp r0.xyz, r2, r0, r1
mov_pp r0.w, c3
mad_pp r0.xyz, r2, t3, r0
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_ShadowMapTexture] 2D
"agal_ps
c3 0.219971 0.707031 0.070984 1.0
c4 2.0 -1.0 0.0 0.0
[bc]
ciaaaaaaacaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r2, v0, s0 <2d wrap linear point>
aeaaaaaaaaaaapacafaaaaoeaeaaaaaaafaaaappaeaaaaaa div r0, v5, v5.w
ciaaaaaaaeaaapacaaaaaafeacaaaaaaadaaaaaaafaababb tex r4, r0.xyyy, s3 <2d wrap linear point>
ciaaaaaaabaaapacabaaaaoeaeaaaaaaacaaaaaaafaababb tex r1, v1, s2 <2d wrap linear point>
adaaaaaaacaaahacacaaaakeacaaaaaaacaaaaoeabaaaaaa mul r2.xyz, r2.xyzz, c2
aaaaaaaaaaaaacacaaaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v0.w
aaaaaaaaaaaaabacaaaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v0.z
adaaaaaaabaaahacabaaaakeacaaaaaaabaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c1.x
ciaaaaaaaaaaapacaaaaaafeacaaaaaaabaaaaaaafaababb tex r0, r0.xyyy, s1 <2d wrap linear point>
aaaaaaaaaaaaabacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r0.w
adaaaaaaadaaadacaaaaaafeacaaaaaaaeaaaaaaabaaaaaa mul r3.xy, r0.xyyy, c4.x
abaaaaaaadaaadacadaaaafeacaaaaaaaeaaaaffabaaaaaa add r3.xy, r3.xyyy, c4.y
adaaaaaaaaaaabacadaaaaffacaaaaaaadaaaaffacaaaaaa mul r0.x, r3.y, r3.y
bfaaaaaaabaaaiacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.w, r3.x
adaaaaaaabaaaiacabaaaappacaaaaaaadaaaaaaacaaaaaa mul r1.w, r1.w, r3.x
acaaaaaaaaaaabacabaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r1.w, r0.x
abaaaaaaaaaaabacaaaaaaaaacaaaaaaadaaaappabaaaaaa add r0.x, r0.x, c3.w
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
afaaaaaaadaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r3.z, r0.x
bcaaaaaaaaaaabacadaaaakeacaaaaaaadaaaakeacaaaaaa dp3 r0.x, r3.xyzz, r3.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaadaaaakeacaaaaaa mul r0.xyz, r0.x, r3.xyzz
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaaaaaaakeacaaaaaa dp3 r0.x, v2, r0.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaakkabaaaaaa max r0.x, r0.x, c4.z
aaaaaaaaadaaahacaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r3.xyz, c0
adaaaaaaaaaaahacaaaaaaaaacaaaaaaaaaaaaoeabaaaaaa mul r0.xyz, r0.x, c0
bcaaaaaaaaaaaiacadaaaaoeabaaaaaaadaaaakeacaaaaaa dp3 r0.w, c3, r3.xyzz
adaaaaaaaaaaapacaeaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r0, r4.x, r0
adaaaaaaaaaaapacaaaaaaoeacaaaaaaaeaaaaaaabaaaaaa mul r0, r0, c4.x
adaaaaaaabaaahacaaaaaappacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.w, r1.xyzz
adaaaaaaabaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.xyzz, r1.xyzz
adaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
aaaaaaaaaaaaaiacadaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c3
adaaaaaaabaaahacacaaaakeacaaaaaaadaaaaoeaeaaaaaa mul r1.xyz, r2.xyzz, v3
abaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r1.xyzz, r0.xyzz
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 13 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 1, 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R2, fragment.texcoord[2], texture[3], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TXP R3.x, fragment.texcoord[3], texture[2], 2D;
MUL R1.xyz, R2.w, R2;
MUL R2.xyz, R2, R3.x;
MUL R1.xyz, R1, c[1].y;
MUL R3.xyz, R1, R3.x;
MUL R2.xyz, R2, c[1].z;
MIN R1.xyz, R1, R2;
MAX R1.xyz, R1, R3;
MUL R0.xyz, R0, c[0];
MUL result.color.xyz, R0, R1;
MOV result.color.w, c[1].x;
END
# 13 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [unity_Lightmap] 2D
"ps_2_0
; 11 ALU, 3 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s3
def c1, 8.00000000, 2.00000000, 1.00000000, 0
dcl t0.xy
dcl t2.xy
dcl t3
texld r1, t0, s0
texldp r3, t3, s2
texld r0, t2, s3
mul_pp r2.xyz, r0, r3.x
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c1.x
mul_pp r2.xyz, r2, c1.y
min_pp r2.xyz, r0, r2
mul_pp r0.xyz, r0, r3.x
max_pp r0.xyz, r2, r0
mul r1.xyz, r1, c0
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c1.z
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [unity_Lightmap] 2D
"agal_ps
c1 8.0 2.0 1.0 0.0
[bc]
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r1, v0, s0 <2d wrap linear point>
aeaaaaaaaaaaapacadaaaaoeaeaaaaaaadaaaappaeaaaaaa div r0, v3, v3.w
ciaaaaaaadaaapacaaaaaafeacaaaaaaacaaaaaaafaababb tex r3, r0.xyyy, s2 <2d wrap linear point>
ciaaaaaaaaaaapacacaaaaoeaeaaaaaaadaaaaaaafaababb tex r0, v2, s3 <2d wrap linear point>
adaaaaaaacaaahacaaaaaakeacaaaaaaadaaaaaaacaaaaaa mul r2.xyz, r0.xyzz, r3.x
adaaaaaaaaaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r0.w, r0.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaaaabaaaaaa mul r0.xyz, r0.xyzz, c1.x
adaaaaaaacaaahacacaaaakeacaaaaaaabaaaaffabaaaaaa mul r2.xyz, r2.xyzz, c1.y
agaaaaaaacaaahacaaaaaakeacaaaaaaacaaaakeacaaaaaa min r2.xyz, r0.xyzz, r2.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaadaaaaaaacaaaaaa mul r0.xyz, r0.xyzz, r3.x
ahaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa max r0.xyz, r2.xyzz, r0.xyzz
adaaaaaaabaaahacabaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r1.xyzz, c0
adaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r1.xyzz, r0.xyzz
aaaaaaaaaaaaaiacabaaaakkabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c1.z
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3"
}

}
	}
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardAdd" }
		ZWrite Off Blend One One Fog { Color (0,0,0,0) }
Program "vp" {
// Vertex combos: 5
//   opengl - ALU: 27 to 36
//   d3d9 - ALU: 30 to 39
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 19 [unity_Scale]
Matrix 13 [_LightMatrix0]
Vector 20 [_Diffuse_ST]
Vector 21 [_Normal_ST]
Vector 22 [_Specular_ST]
"!!ARBvp1.0
# 35 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_Diffuse_ST]
Vector 20 [_Normal_ST]
Vector 21 [_Specular_ST]
"vs_2_0
; 38 ALU
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp3 oT2.y, r0, r2
dp3 oT2.z, v2, r0
dp3 oT2.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT3.y, r2, r3
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
dp4 oT4.z, r0, c14
dp4 oT4.y, r0, c13
dp4 oT4.x, r0, c12
mad oT0.zw, v3.xyxy, c20.xyxy, c20
mad oT0.xy, v3, c19, c19.zwzw
mad oT1.xy, v3, c21, c21.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 Tex2D2_6;
  highp vec4 UnpackNormal0_7;
  highp vec4 Tex2D0_8;
  highp vec4 Tex2D1_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_8 = tmpvar_11;
  lowp vec4 packednormal_12;
  packednormal_12 = Tex2D0_8;
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((packednormal_12.xyz * 2.0) - 1.0);
  UnpackNormal0_7 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Specular, xlv_TEXCOORD1);
  Tex2D2_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (_MainColor * Tex2D1_9).xyz;
  tmpvar_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = UnpackNormal0_7.xyz;
  tmpvar_4 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (Tex2D2_6 * vec4(_Specular_Power)).xyz;
  tmpvar_5 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_4);
  tmpvar_4 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (xlv_TEXCOORD4, xlv_TEXCOORD4);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_LightTexture0, vec2(tmpvar_20));
  mediump vec3 lightDir_22;
  lightDir_22 = lightDir_2;
  mediump float atten_23;
  atten_23 = tmpvar_21.w;
  mediump vec4 res_24;
  highp float nh_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_18, normalize((lightDir_22 + normalize(xlv_TEXCOORD3)))));
  nh_25 = tmpvar_26;
  res_24.xyz = (_LightColor0.xyz * max (0.0, dot (lightDir_22, tmpvar_18)));
  lowp float tmpvar_27;
  tmpvar_27 = dot (_LightColor0.xyz, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_28;
  tmpvar_28 = (pow (nh_25, 0.0) * tmpvar_27);
  res_24.w = tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = (res_24 * (atten_23 * 2.0));
  res_24 = tmpvar_29;
  mediump vec4 c_30;
  c_30.xyz = ((tmpvar_3 * tmpvar_29.xyz) + (tmpvar_29.xyz * (tmpvar_29.w * tmpvar_5)));
  c_30.w = 1.0;
  c_1.xyz = c_30.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 Tex2D2_6;
  highp vec4 UnpackNormal0_7;
  highp vec4 Tex2D0_8;
  highp vec4 Tex2D1_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_8 = tmpvar_11;
  lowp vec4 packednormal_12;
  packednormal_12 = Tex2D0_8;
  lowp vec3 normal_13;
  normal_13.xy = ((packednormal_12.wy * 2.0) - 1.0);
  normal_13.z = sqrt((1.0 - clamp (dot (normal_13.xy, normal_13.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = normal_13;
  UnpackNormal0_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Specular, xlv_TEXCOORD1);
  Tex2D2_6 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_MainColor * Tex2D1_9).xyz;
  tmpvar_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = UnpackNormal0_7.xyz;
  tmpvar_4 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (Tex2D2_6 * vec4(_Specular_Power)).xyz;
  tmpvar_5 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_4);
  tmpvar_4 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (xlv_TEXCOORD4, xlv_TEXCOORD4);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_LightTexture0, vec2(tmpvar_21));
  mediump vec3 lightDir_23;
  lightDir_23 = lightDir_2;
  mediump float atten_24;
  atten_24 = tmpvar_22.w;
  mediump vec4 res_25;
  highp float nh_26;
  mediump float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_19, normalize((lightDir_23 + normalize(xlv_TEXCOORD3)))));
  nh_26 = tmpvar_27;
  res_25.xyz = (_LightColor0.xyz * max (0.0, dot (lightDir_23, tmpvar_19)));
  lowp float tmpvar_28;
  tmpvar_28 = dot (_LightColor0.xyz, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_29;
  tmpvar_29 = (pow (nh_26, 0.0) * tmpvar_28);
  res_25.w = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30 = (res_25 * (atten_24 * 2.0));
  res_25 = tmpvar_30;
  mediump vec4 c_31;
  c_31.xyz = ((tmpvar_3 * tmpvar_30.xyz) + (tmpvar_30.xyz * (tmpvar_30.w * tmpvar_5)));
  c_31.w = 1.0;
  c_1.xyz = c_31.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_Diffuse_ST]
Vector 20 [_Normal_ST]
Vector 21 [_Specular_ST]
"agal_vs
c22 1.0 0.0 0.0 0.0
[bc]
aaaaaaaaaaaaaiacbgaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c22.x
aaaaaaaaaaaaahacbaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c16
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r1.z, r0, c10
bdaaaaaaabaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r1.y, r0, c9
bdaaaaaaabaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r1.x, r0, c8
adaaaaaaacaaahacabaaaakeacaaaaaabcaaaappabaaaaaa mul r2.xyz, r1.xyzz, c18.w
acaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r2.xyzz, a0
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaaaaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r0.yzxx
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaaeaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r4.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacaeaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r4.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaaeaaaeacbbaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c17, r0
aaaaaaaaaaaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c9
bdaaaaaaaeaaacacbbaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.y, c17, r0
aaaaaaaaabaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c8
bdaaaaaaaeaaabacbbaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.x, c17, r1
adaaaaaaabaaahacaeaaaakeacaaaaaabcaaaappabaaaaaa mul r1.xyz, r4.xyzz, c18.w
acaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r0.xyz, r1.xyzz, a0
bcaaaaaaacaaacaeaaaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v2.y, r0.xyzz, r2.xyzz
bcaaaaaaacaaaeaeabaaaaoeaaaaaaaaaaaaaakeacaaaaaa dp3 v2.z, a1, r0.xyzz
bcaaaaaaacaaabaeaaaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v2.x, r0.xyzz, a5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bcaaaaaaadaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v3.y, r2.xyzz, r3.xyzz
bcaaaaaaadaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v3.z, a1, r3.xyzz
bcaaaaaaadaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v3.x, a5, r3.xyzz
bdaaaaaaaeaaaeaeaaaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 v4.z, r0, c14
bdaaaaaaaeaaacaeaaaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 v4.y, r0, c13
bdaaaaaaaeaaabaeaaaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 v4.x, r0, c12
adaaaaaaaaaaamacadaaaaeeaaaaaaaabeaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c20.xyxy
abaaaaaaaaaaamaeaaaaaaopacaaaaaabeaaaaoeabaaaaaa add v0.zw, r0.wwzw, c20
adaaaaaaaaaaadacadaaaaoeaaaaaaaabdaaaaoeabaaaaaa mul r0.xy, a3, c19
abaaaaaaaaaaadaeaaaaaafeacaaaaaabdaaaaooabaaaaaa add v0.xy, r0.xyyy, c19.zwzw
adaaaaaaaaaaadacadaaaaoeaaaaaaaabfaaaaoeabaaaaaa mul r0.xy, a3, c21
abaaaaaaabaaadaeaaaaaafeacaaaaaabfaaaaooabaaaaaa add v1.xy, r0.xyyy, c21.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
"
}

SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 389
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 420
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 459
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    mediump vec3 lightDir;
    mediump vec3 viewDir;
    highp vec3 _LightCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 384
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
#line 388
uniform highp vec4 _MainColor;
#line 400
#line 408
#line 427
#line 469
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 491
#line 81
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return ((objSpaceLightPos.xyz * unity_Scale.w) - v.xyz);
}
#line 90
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 427
void vert( inout appdata_full v, out Input o ) {
    highp vec4 VertexOutputMaster0_0_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_1_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    #line 431
    highp vec4 VertexOutputMaster0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
}
#line 472
v2f_surf vert_surf( in appdata_full v ) {
    #line 474
    v2f_surf o;
    Input customInputData;
    vert( v, customInputData);
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 478
    o.pack0.xy = ((v.texcoord.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _Normal_ST.xy) + _Normal_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Specular_ST.xy) + _Specular_ST.zw);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 482
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    #line 486
    o.viewDir = viewDirForLight;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec2(xl_retval.pack1);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec3(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 389
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 420
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 459
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    mediump vec3 lightDir;
    mediump vec3 viewDir;
    highp vec3 _LightCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 384
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
#line 388
uniform highp vec4 _MainColor;
#line 400
#line 408
#line 427
#line 469
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 491
#line 400
mediump vec4 LightingBlinnPhongEditor_PrePass( in EditorSurfaceOutput s, in mediump vec4 light ) {
    mediump vec3 spec = (light.w * s.Gloss);
    mediump vec4 c;
    #line 404
    c.xyz = ((s.Albedo * light.xyz) + (light.xyz * spec));
    c.w = s.Alpha;
    return c;
}
#line 172
lowp float Luminance( in lowp vec3 c ) {
    #line 174
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 408
mediump vec4 LightingBlinnPhongEditor( in EditorSurfaceOutput s, in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diff = max( 0.0, dot( lightDir, s.Normal));
    #line 412
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    mediump vec4 res;
    res.xyz = (_LightColor0.xyz * diff);
    #line 416
    res.w = (spec * Luminance( _LightColor0.xyz));
    res *= (atten * 2.0);
    return LightingBlinnPhongEditor_PrePass( s, res);
}
#line 271
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 273
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 434
void surf( in Input IN, inout EditorSurfaceOutput o ) {
    #line 436
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Alpha = 1.0;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 440
    o.Gloss = vec3( 0.0);
    o.Specular = 0.0;
    o.Custom = vec4( 0.0);
    highp vec4 Tex2D1 = texture( _Diffuse, IN.uv_Diffuse.xyxy.xy);
    #line 444
    highp vec4 Multiply1 = (_MainColor * Tex2D1);
    highp vec4 Tex2D0 = texture( _Normal, IN.uv_Normal.xyxy.xy);
    highp vec4 UnpackNormal0 = vec4( UnpackNormal( Tex2D0).xyz, 1.0);
    highp vec4 Tex2D2 = texture( _Specular, IN.uv_Specular.xyxy.xy);
    #line 448
    highp vec4 Multiply0 = (Tex2D2 * vec4( _Specular_Power));
    highp vec4 Master0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_5_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    #line 452
    highp vec4 Master0_7_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_6_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    o.Albedo = vec3( Multiply1);
    o.Normal = vec3( UnpackNormal0);
    #line 456
    o.Gloss = vec3( Multiply0);
    o.Normal = normalize(o.Normal);
}
#line 491
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_Diffuse = IN.pack0.xy;
    #line 495
    surfIN.uv_Normal = IN.pack0.zw;
    surfIN.uv_Specular = IN.pack1.xy;
    EditorSurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 499
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    surf( surfIN, o);
    #line 503
    lowp vec3 lightDir = normalize(IN.lightDir);
    lowp vec4 c = LightingBlinnPhongEditor( o, lightDir, normalize(IN.viewDir), (texture( _LightTexture0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * 1.0));
    c.w = 0.0;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec2(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Matrix 5 [_World2Object]
Vector 11 [unity_Scale]
Vector 12 [_Diffuse_ST]
Vector 13 [_Normal_ST]
Vector 14 [_Specular_ST]
"!!ARBvp1.0
# 27 ALU
PARAM c[15] = { { 1 },
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[9];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[7];
DP4 R2.y, R1, c[6];
DP4 R2.x, R1, c[5];
MAD R2.xyz, R2, c[11].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[10];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[7];
DP4 R3.y, R0, c[6];
DP4 R3.x, R0, c[5];
DP3 result.texcoord[2].y, R3, R1;
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[13].xyxy, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[12], c[12].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[14], c[14].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 27 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_WorldSpaceLightPos0]
Matrix 4 [_World2Object]
Vector 10 [unity_Scale]
Vector 11 [_Diffuse_ST]
Vector 12 [_Normal_ST]
Vector 13 [_Specular_ST]
"vs_2_0
; 30 ALU
def c14, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c14.x
mov r0.xyz, c8
dp4 r1.z, r0, c6
dp4 r1.y, r0, c5
dp4 r1.x, r0, c4
mad r3.xyz, r1, c10.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c6
dp4 r4.z, c9, r0
mov r0, c5
mov r1, c4
dp4 r4.y, c9, r0
dp4 r4.x, c9, r1
dp3 oT2.y, r4, r2
dp3 oT3.y, r2, r3
dp3 oT2.z, v2, r4
dp3 oT2.x, r4, v1
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
mad oT0.zw, v3.xyxy, c12.xyxy, c12
mad oT0.xy, v3, c11, c11.zwzw
mad oT1.xy, v3, c13, c13.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 Tex2D2_6;
  highp vec4 UnpackNormal0_7;
  highp vec4 Tex2D0_8;
  highp vec4 Tex2D1_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_8 = tmpvar_11;
  lowp vec4 packednormal_12;
  packednormal_12 = Tex2D0_8;
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((packednormal_12.xyz * 2.0) - 1.0);
  UnpackNormal0_7 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Specular, xlv_TEXCOORD1);
  Tex2D2_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (_MainColor * Tex2D1_9).xyz;
  tmpvar_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = UnpackNormal0_7.xyz;
  tmpvar_4 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (Tex2D2_6 * vec4(_Specular_Power)).xyz;
  tmpvar_5 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_4);
  tmpvar_4 = tmpvar_18;
  lightDir_2 = xlv_TEXCOORD2;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_2;
  mediump vec4 res_20;
  highp float nh_21;
  mediump float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_18, normalize((lightDir_19 + normalize(xlv_TEXCOORD3)))));
  nh_21 = tmpvar_22;
  res_20.xyz = (_LightColor0.xyz * max (0.0, dot (lightDir_19, tmpvar_18)));
  lowp float tmpvar_23;
  tmpvar_23 = dot (_LightColor0.xyz, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_24;
  tmpvar_24 = (pow (nh_21, 0.0) * tmpvar_23);
  res_20.w = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (res_20 * 2.0);
  res_20 = tmpvar_25;
  mediump vec4 c_26;
  c_26.xyz = ((tmpvar_3 * tmpvar_25.xyz) + (tmpvar_25.xyz * (tmpvar_25.w * tmpvar_5)));
  c_26.w = 1.0;
  c_1.xyz = c_26.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 Tex2D2_6;
  highp vec4 UnpackNormal0_7;
  highp vec4 Tex2D0_8;
  highp vec4 Tex2D1_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_8 = tmpvar_11;
  lowp vec4 packednormal_12;
  packednormal_12 = Tex2D0_8;
  lowp vec3 normal_13;
  normal_13.xy = ((packednormal_12.wy * 2.0) - 1.0);
  normal_13.z = sqrt((1.0 - clamp (dot (normal_13.xy, normal_13.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = normal_13;
  UnpackNormal0_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Specular, xlv_TEXCOORD1);
  Tex2D2_6 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_MainColor * Tex2D1_9).xyz;
  tmpvar_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = UnpackNormal0_7.xyz;
  tmpvar_4 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (Tex2D2_6 * vec4(_Specular_Power)).xyz;
  tmpvar_5 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_4);
  tmpvar_4 = tmpvar_19;
  lightDir_2 = xlv_TEXCOORD2;
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_2;
  mediump vec4 res_21;
  highp float nh_22;
  mediump float tmpvar_23;
  tmpvar_23 = max (0.0, dot (tmpvar_19, normalize((lightDir_20 + normalize(xlv_TEXCOORD3)))));
  nh_22 = tmpvar_23;
  res_21.xyz = (_LightColor0.xyz * max (0.0, dot (lightDir_20, tmpvar_19)));
  lowp float tmpvar_24;
  tmpvar_24 = dot (_LightColor0.xyz, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_25;
  tmpvar_25 = (pow (nh_22, 0.0) * tmpvar_24);
  res_21.w = tmpvar_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = (res_21 * 2.0);
  res_21 = tmpvar_26;
  mediump vec4 c_27;
  c_27.xyz = ((tmpvar_3 * tmpvar_26.xyz) + (tmpvar_26.xyz * (tmpvar_26.w * tmpvar_5)));
  c_27.w = 1.0;
  c_1.xyz = c_27.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_WorldSpaceLightPos0]
Matrix 4 [_World2Object]
Vector 10 [unity_Scale]
Vector 11 [_Diffuse_ST]
Vector 12 [_Normal_ST]
Vector 13 [_Specular_ST]
"agal_vs
c14 1.0 0.0 0.0 0.0
[bc]
aaaaaaaaaaaaaiacaoaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c14.x
aaaaaaaaaaaaahacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c8
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaagaaaaoeabaaaaaa dp4 r1.z, r0, c6
bdaaaaaaabaaacacaaaaaaoeacaaaaaaafaaaaoeabaaaaaa dp4 r1.y, r0, c5
bdaaaaaaabaaabacaaaaaaoeacaaaaaaaeaaaaoeabaaaaaa dp4 r1.x, r0, c4
adaaaaaaacaaahacabaaaakeacaaaaaaakaaaappabaaaaaa mul r2.xyz, r1.xyzz, c10.w
acaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r2.xyzz, a0
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaaaaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r0.yzxx
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaaeaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r4.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacaeaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r4.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaaaaaapacagaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c6
bdaaaaaaaeaaaeacajaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c9, r0
aaaaaaaaaaaaapacafaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c5
aaaaaaaaabaaapacaeaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c4
bdaaaaaaaeaaacacajaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.y, c9, r0
bdaaaaaaaeaaabacajaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.x, c9, r1
bcaaaaaaacaaacaeaeaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v2.y, r4.xyzz, r2.xyzz
bcaaaaaaadaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v3.y, r2.xyzz, r3.xyzz
bcaaaaaaacaaaeaeabaaaaoeaaaaaaaaaeaaaakeacaaaaaa dp3 v2.z, a1, r4.xyzz
bcaaaaaaacaaabaeaeaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v2.x, r4.xyzz, a5
bcaaaaaaadaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v3.z, a1, r3.xyzz
bcaaaaaaadaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v3.x, a5, r3.xyzz
adaaaaaaaaaaamacadaaaaeeaaaaaaaaamaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c12.xyxy
abaaaaaaaaaaamaeaaaaaaopacaaaaaaamaaaaoeabaaaaaa add v0.zw, r0.wwzw, c12
adaaaaaaaaaaadacadaaaaoeaaaaaaaaalaaaaoeabaaaaaa mul r0.xy, a3, c11
abaaaaaaaaaaadaeaaaaaafeacaaaaaaalaaaaooabaaaaaa add v0.xy, r0.xyyy, c11.zwzw
adaaaaaaaaaaadacadaaaaoeaaaaaaaaanaaaaoeabaaaaaa mul r0.xy, a3, c13
abaaaaaaabaaadaeaaaaaafeacaaaaaaanaaaaooabaaaaaa add v1.xy, r0.xyyy, c13.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 387
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 418
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 457
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    mediump vec3 lightDir;
    mediump vec3 viewDir;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 384
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 398
#line 406
#line 425
#line 466
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 487
#line 81
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 90
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 425
void vert( inout appdata_full v, out Input o ) {
    highp vec4 VertexOutputMaster0_0_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_1_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    #line 429
    highp vec4 VertexOutputMaster0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
}
#line 469
v2f_surf vert_surf( in appdata_full v ) {
    #line 471
    v2f_surf o;
    Input customInputData;
    vert( v, customInputData);
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 475
    o.pack0.xy = ((v.texcoord.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _Normal_ST.xy) + _Normal_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Specular_ST.xy) + _Specular_ST.zw);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 479
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    #line 483
    o.viewDir = viewDirForLight;
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec2(xl_retval.pack1);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 387
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 418
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 457
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    mediump vec3 lightDir;
    mediump vec3 viewDir;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 384
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 398
#line 406
#line 425
#line 466
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 487
#line 398
mediump vec4 LightingBlinnPhongEditor_PrePass( in EditorSurfaceOutput s, in mediump vec4 light ) {
    mediump vec3 spec = (light.w * s.Gloss);
    mediump vec4 c;
    #line 402
    c.xyz = ((s.Albedo * light.xyz) + (light.xyz * spec));
    c.w = s.Alpha;
    return c;
}
#line 172
lowp float Luminance( in lowp vec3 c ) {
    #line 174
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 406
mediump vec4 LightingBlinnPhongEditor( in EditorSurfaceOutput s, in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diff = max( 0.0, dot( lightDir, s.Normal));
    #line 410
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    mediump vec4 res;
    res.xyz = (_LightColor0.xyz * diff);
    #line 414
    res.w = (spec * Luminance( _LightColor0.xyz));
    res *= (atten * 2.0);
    return LightingBlinnPhongEditor_PrePass( s, res);
}
#line 271
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 273
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 432
void surf( in Input IN, inout EditorSurfaceOutput o ) {
    #line 434
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Alpha = 1.0;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 438
    o.Gloss = vec3( 0.0);
    o.Specular = 0.0;
    o.Custom = vec4( 0.0);
    highp vec4 Tex2D1 = texture( _Diffuse, IN.uv_Diffuse.xyxy.xy);
    #line 442
    highp vec4 Multiply1 = (_MainColor * Tex2D1);
    highp vec4 Tex2D0 = texture( _Normal, IN.uv_Normal.xyxy.xy);
    highp vec4 UnpackNormal0 = vec4( UnpackNormal( Tex2D0).xyz, 1.0);
    highp vec4 Tex2D2 = texture( _Specular, IN.uv_Specular.xyxy.xy);
    #line 446
    highp vec4 Multiply0 = (Tex2D2 * vec4( _Specular_Power));
    highp vec4 Master0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_5_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    #line 450
    highp vec4 Master0_7_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_6_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    o.Albedo = vec3( Multiply1);
    o.Normal = vec3( UnpackNormal0);
    #line 454
    o.Gloss = vec3( Multiply0);
    o.Normal = normalize(o.Normal);
}
#line 487
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_Diffuse = IN.pack0.xy;
    #line 491
    surfIN.uv_Normal = IN.pack0.zw;
    surfIN.uv_Specular = IN.pack1.xy;
    EditorSurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 495
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    surf( surfIN, o);
    #line 499
    lowp vec3 lightDir = IN.lightDir;
    lowp vec4 c = LightingBlinnPhongEditor( o, lightDir, normalize(IN.viewDir), 1.0);
    c.w = 0.0;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec2(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 19 [unity_Scale]
Matrix 13 [_LightMatrix0]
Vector 20 [_Diffuse_ST]
Vector 21 [_Normal_ST]
Vector 22 [_Specular_ST]
"!!ARBvp1.0
# 36 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].w, R0, c[16];
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 36 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_Diffuse_ST]
Vector 20 [_Normal_ST]
Vector 21 [_Specular_ST]
"vs_2_0
; 39 ALU
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp4 r0.w, v0, c7
dp3 oT2.y, r0, r2
dp3 oT2.z, v2, r0
dp3 oT2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT3.y, r2, r3
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
dp4 oT4.w, r0, c15
dp4 oT4.z, r0, c14
dp4 oT4.y, r0, c13
dp4 oT4.x, r0, c12
mad oT0.zw, v3.xyxy, c20.xyxy, c20
mad oT0.xy, v3, c19, c19.zwzw
mad oT1.xy, v3, c21, c21.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 Tex2D2_6;
  highp vec4 UnpackNormal0_7;
  highp vec4 Tex2D0_8;
  highp vec4 Tex2D1_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_8 = tmpvar_11;
  lowp vec4 packednormal_12;
  packednormal_12 = Tex2D0_8;
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((packednormal_12.xyz * 2.0) - 1.0);
  UnpackNormal0_7 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Specular, xlv_TEXCOORD1);
  Tex2D2_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (_MainColor * Tex2D1_9).xyz;
  tmpvar_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = UnpackNormal0_7.xyz;
  tmpvar_4 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (Tex2D2_6 * vec4(_Specular_Power)).xyz;
  tmpvar_5 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_4);
  tmpvar_4 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_19;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w) + 0.5);
  tmpvar_20 = texture2D (_LightTexture0, P_21);
  highp float tmpvar_22;
  tmpvar_22 = dot (xlv_TEXCOORD4.xyz, xlv_TEXCOORD4.xyz);
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_LightTextureB0, vec2(tmpvar_22));
  mediump vec3 lightDir_24;
  lightDir_24 = lightDir_2;
  mediump float atten_25;
  atten_25 = ((float((xlv_TEXCOORD4.z > 0.0)) * tmpvar_20.w) * tmpvar_23.w);
  mediump vec4 res_26;
  highp float nh_27;
  mediump float tmpvar_28;
  tmpvar_28 = max (0.0, dot (tmpvar_18, normalize((lightDir_24 + normalize(xlv_TEXCOORD3)))));
  nh_27 = tmpvar_28;
  res_26.xyz = (_LightColor0.xyz * max (0.0, dot (lightDir_24, tmpvar_18)));
  lowp float tmpvar_29;
  tmpvar_29 = dot (_LightColor0.xyz, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_30;
  tmpvar_30 = (pow (nh_27, 0.0) * tmpvar_29);
  res_26.w = tmpvar_30;
  mediump vec4 tmpvar_31;
  tmpvar_31 = (res_26 * (atten_25 * 2.0));
  res_26 = tmpvar_31;
  mediump vec4 c_32;
  c_32.xyz = ((tmpvar_3 * tmpvar_31.xyz) + (tmpvar_31.xyz * (tmpvar_31.w * tmpvar_5)));
  c_32.w = 1.0;
  c_1.xyz = c_32.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 Tex2D2_6;
  highp vec4 UnpackNormal0_7;
  highp vec4 Tex2D0_8;
  highp vec4 Tex2D1_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_8 = tmpvar_11;
  lowp vec4 packednormal_12;
  packednormal_12 = Tex2D0_8;
  lowp vec3 normal_13;
  normal_13.xy = ((packednormal_12.wy * 2.0) - 1.0);
  normal_13.z = sqrt((1.0 - clamp (dot (normal_13.xy, normal_13.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = normal_13;
  UnpackNormal0_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Specular, xlv_TEXCOORD1);
  Tex2D2_6 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_MainColor * Tex2D1_9).xyz;
  tmpvar_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = UnpackNormal0_7.xyz;
  tmpvar_4 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (Tex2D2_6 * vec4(_Specular_Power)).xyz;
  tmpvar_5 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_4);
  tmpvar_4 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_20;
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w) + 0.5);
  tmpvar_21 = texture2D (_LightTexture0, P_22);
  highp float tmpvar_23;
  tmpvar_23 = dot (xlv_TEXCOORD4.xyz, xlv_TEXCOORD4.xyz);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_LightTextureB0, vec2(tmpvar_23));
  mediump vec3 lightDir_25;
  lightDir_25 = lightDir_2;
  mediump float atten_26;
  atten_26 = ((float((xlv_TEXCOORD4.z > 0.0)) * tmpvar_21.w) * tmpvar_24.w);
  mediump vec4 res_27;
  highp float nh_28;
  mediump float tmpvar_29;
  tmpvar_29 = max (0.0, dot (tmpvar_19, normalize((lightDir_25 + normalize(xlv_TEXCOORD3)))));
  nh_28 = tmpvar_29;
  res_27.xyz = (_LightColor0.xyz * max (0.0, dot (lightDir_25, tmpvar_19)));
  lowp float tmpvar_30;
  tmpvar_30 = dot (_LightColor0.xyz, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_31;
  tmpvar_31 = (pow (nh_28, 0.0) * tmpvar_30);
  res_27.w = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (res_27 * (atten_26 * 2.0));
  res_27 = tmpvar_32;
  mediump vec4 c_33;
  c_33.xyz = ((tmpvar_3 * tmpvar_32.xyz) + (tmpvar_32.xyz * (tmpvar_32.w * tmpvar_5)));
  c_33.w = 1.0;
  c_1.xyz = c_33.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_Diffuse_ST]
Vector 20 [_Normal_ST]
Vector 21 [_Specular_ST]
"agal_vs
c22 1.0 0.0 0.0 0.0
[bc]
aaaaaaaaaaaaaiacbgaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c22.x
aaaaaaaaaaaaahacbaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c16
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r1.z, r0, c10
bdaaaaaaabaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r1.y, r0, c9
bdaaaaaaabaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r1.x, r0, c8
adaaaaaaacaaahacabaaaakeacaaaaaabcaaaappabaaaaaa mul r2.xyz, r1.xyzz, c18.w
acaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r2.xyzz, a0
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaaaaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r0.yzxx
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaaeaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r4.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacaeaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r4.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaaeaaaeacbbaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c17, r0
aaaaaaaaaaaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c9
bdaaaaaaaeaaacacbbaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.y, c17, r0
aaaaaaaaabaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c8
bdaaaaaaaeaaabacbbaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.x, c17, r1
adaaaaaaabaaahacaeaaaakeacaaaaaabcaaaappabaaaaaa mul r1.xyz, r4.xyzz, c18.w
acaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r0.xyz, r1.xyzz, a0
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bcaaaaaaacaaacaeaaaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v2.y, r0.xyzz, r2.xyzz
bcaaaaaaacaaaeaeabaaaaoeaaaaaaaaaaaaaakeacaaaaaa dp3 v2.z, a1, r0.xyzz
bcaaaaaaacaaabaeaaaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v2.x, r0.xyzz, a5
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bcaaaaaaadaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v3.y, r2.xyzz, r3.xyzz
bcaaaaaaadaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v3.z, a1, r3.xyzz
bcaaaaaaadaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v3.x, a5, r3.xyzz
bdaaaaaaaeaaaiaeaaaaaaoeacaaaaaaapaaaaoeabaaaaaa dp4 v4.w, r0, c15
bdaaaaaaaeaaaeaeaaaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 v4.z, r0, c14
bdaaaaaaaeaaacaeaaaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 v4.y, r0, c13
bdaaaaaaaeaaabaeaaaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 v4.x, r0, c12
adaaaaaaaaaaamacadaaaaeeaaaaaaaabeaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c20.xyxy
abaaaaaaaaaaamaeaaaaaaopacaaaaaabeaaaaoeabaaaaaa add v0.zw, r0.wwzw, c20
adaaaaaaaaaaadacadaaaaoeaaaaaaaabdaaaaoeabaaaaaa mul r0.xy, a3, c19
abaaaaaaaaaaadaeaaaaaafeacaaaaaabdaaaaooabaaaaaa add v0.xy, r0.xyyy, c19.zwzw
adaaaaaaaaaaadacadaaaaoeaaaaaaaabfaaaaoeabaaaaaa mul r0.xy, a3, c21
abaaaaaaabaaadaeaaaaaafeacaaaaaabfaaaaooabaaaaaa add v1.xy, r0.xyyy, c21.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 398
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 429
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 468
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    mediump vec3 lightDir;
    mediump vec3 viewDir;
    highp vec4 _LightCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 384
uniform sampler2D _LightTextureB0;
#line 389
#line 393
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
#line 397
uniform highp vec4 _MainColor;
#line 409
#line 417
#line 436
#line 478
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 500
#line 81
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return ((objSpaceLightPos.xyz * unity_Scale.w) - v.xyz);
}
#line 90
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 436
void vert( inout appdata_full v, out Input o ) {
    highp vec4 VertexOutputMaster0_0_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_1_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    #line 440
    highp vec4 VertexOutputMaster0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
}
#line 481
v2f_surf vert_surf( in appdata_full v ) {
    #line 483
    v2f_surf o;
    Input customInputData;
    vert( v, customInputData);
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 487
    o.pack0.xy = ((v.texcoord.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _Normal_ST.xy) + _Normal_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Specular_ST.xy) + _Specular_ST.zw);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 491
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    #line 495
    o.viewDir = viewDirForLight;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec2(xl_retval.pack1);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec4(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 398
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 429
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 468
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    mediump vec3 lightDir;
    mediump vec3 viewDir;
    highp vec4 _LightCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 384
uniform sampler2D _LightTextureB0;
#line 389
#line 393
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
#line 397
uniform highp vec4 _MainColor;
#line 409
#line 417
#line 436
#line 478
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 500
#line 409
mediump vec4 LightingBlinnPhongEditor_PrePass( in EditorSurfaceOutput s, in mediump vec4 light ) {
    mediump vec3 spec = (light.w * s.Gloss);
    mediump vec4 c;
    #line 413
    c.xyz = ((s.Albedo * light.xyz) + (light.xyz * spec));
    c.w = s.Alpha;
    return c;
}
#line 172
lowp float Luminance( in lowp vec3 c ) {
    #line 174
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 417
mediump vec4 LightingBlinnPhongEditor( in EditorSurfaceOutput s, in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diff = max( 0.0, dot( lightDir, s.Normal));
    #line 421
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    mediump vec4 res;
    res.xyz = (_LightColor0.xyz * diff);
    #line 425
    res.w = (spec * Luminance( _LightColor0.xyz));
    res *= (atten * 2.0);
    return LightingBlinnPhongEditor_PrePass( s, res);
}
#line 389
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 385
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 271
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 273
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 443
void surf( in Input IN, inout EditorSurfaceOutput o ) {
    #line 445
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Alpha = 1.0;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 449
    o.Gloss = vec3( 0.0);
    o.Specular = 0.0;
    o.Custom = vec4( 0.0);
    highp vec4 Tex2D1 = texture( _Diffuse, IN.uv_Diffuse.xyxy.xy);
    #line 453
    highp vec4 Multiply1 = (_MainColor * Tex2D1);
    highp vec4 Tex2D0 = texture( _Normal, IN.uv_Normal.xyxy.xy);
    highp vec4 UnpackNormal0 = vec4( UnpackNormal( Tex2D0).xyz, 1.0);
    highp vec4 Tex2D2 = texture( _Specular, IN.uv_Specular.xyxy.xy);
    #line 457
    highp vec4 Multiply0 = (Tex2D2 * vec4( _Specular_Power));
    highp vec4 Master0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_5_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    #line 461
    highp vec4 Master0_7_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_6_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    o.Albedo = vec3( Multiply1);
    o.Normal = vec3( UnpackNormal0);
    #line 465
    o.Gloss = vec3( Multiply0);
    o.Normal = normalize(o.Normal);
}
#line 500
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_Diffuse = IN.pack0.xy;
    #line 504
    surfIN.uv_Normal = IN.pack0.zw;
    surfIN.uv_Specular = IN.pack1.xy;
    EditorSurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 508
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    surf( surfIN, o);
    #line 512
    lowp vec3 lightDir = normalize(IN.lightDir);
    lowp vec4 c = LightingBlinnPhongEditor( o, lightDir, normalize(IN.viewDir), (((float((IN._LightCoord.z > 0.0)) * UnitySpotCookie( IN._LightCoord)) * UnitySpotAttenuate( IN._LightCoord.xyz)) * 1.0));
    c.w = 0.0;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec2(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 19 [unity_Scale]
Matrix 13 [_LightMatrix0]
Vector 20 [_Diffuse_ST]
Vector 21 [_Normal_ST]
Vector 22 [_Specular_ST]
"!!ARBvp1.0
# 35 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_Diffuse_ST]
Vector 20 [_Normal_ST]
Vector 21 [_Specular_ST]
"vs_2_0
; 38 ALU
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp3 oT2.y, r0, r2
dp3 oT2.z, v2, r0
dp3 oT2.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT3.y, r2, r3
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
dp4 oT4.z, r0, c14
dp4 oT4.y, r0, c13
dp4 oT4.x, r0, c12
mad oT0.zw, v3.xyxy, c20.xyxy, c20
mad oT0.xy, v3, c19, c19.zwzw
mad oT1.xy, v3, c21, c21.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 Tex2D2_6;
  highp vec4 UnpackNormal0_7;
  highp vec4 Tex2D0_8;
  highp vec4 Tex2D1_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_8 = tmpvar_11;
  lowp vec4 packednormal_12;
  packednormal_12 = Tex2D0_8;
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((packednormal_12.xyz * 2.0) - 1.0);
  UnpackNormal0_7 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Specular, xlv_TEXCOORD1);
  Tex2D2_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (_MainColor * Tex2D1_9).xyz;
  tmpvar_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = UnpackNormal0_7.xyz;
  tmpvar_4 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (Tex2D2_6 * vec4(_Specular_Power)).xyz;
  tmpvar_5 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_4);
  tmpvar_4 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (xlv_TEXCOORD4, xlv_TEXCOORD4);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(tmpvar_20));
  lowp vec4 tmpvar_22;
  tmpvar_22 = textureCube (_LightTexture0, xlv_TEXCOORD4);
  mediump vec3 lightDir_23;
  lightDir_23 = lightDir_2;
  mediump float atten_24;
  atten_24 = (tmpvar_21.w * tmpvar_22.w);
  mediump vec4 res_25;
  highp float nh_26;
  mediump float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_18, normalize((lightDir_23 + normalize(xlv_TEXCOORD3)))));
  nh_26 = tmpvar_27;
  res_25.xyz = (_LightColor0.xyz * max (0.0, dot (lightDir_23, tmpvar_18)));
  lowp float tmpvar_28;
  tmpvar_28 = dot (_LightColor0.xyz, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_29;
  tmpvar_29 = (pow (nh_26, 0.0) * tmpvar_28);
  res_25.w = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30 = (res_25 * (atten_24 * 2.0));
  res_25 = tmpvar_30;
  mediump vec4 c_31;
  c_31.xyz = ((tmpvar_3 * tmpvar_30.xyz) + (tmpvar_30.xyz * (tmpvar_30.w * tmpvar_5)));
  c_31.w = 1.0;
  c_1.xyz = c_31.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 Tex2D2_6;
  highp vec4 UnpackNormal0_7;
  highp vec4 Tex2D0_8;
  highp vec4 Tex2D1_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_8 = tmpvar_11;
  lowp vec4 packednormal_12;
  packednormal_12 = Tex2D0_8;
  lowp vec3 normal_13;
  normal_13.xy = ((packednormal_12.wy * 2.0) - 1.0);
  normal_13.z = sqrt((1.0 - clamp (dot (normal_13.xy, normal_13.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = normal_13;
  UnpackNormal0_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Specular, xlv_TEXCOORD1);
  Tex2D2_6 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_MainColor * Tex2D1_9).xyz;
  tmpvar_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = UnpackNormal0_7.xyz;
  tmpvar_4 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (Tex2D2_6 * vec4(_Specular_Power)).xyz;
  tmpvar_5 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_4);
  tmpvar_4 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (xlv_TEXCOORD4, xlv_TEXCOORD4);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_LightTextureB0, vec2(tmpvar_21));
  lowp vec4 tmpvar_23;
  tmpvar_23 = textureCube (_LightTexture0, xlv_TEXCOORD4);
  mediump vec3 lightDir_24;
  lightDir_24 = lightDir_2;
  mediump float atten_25;
  atten_25 = (tmpvar_22.w * tmpvar_23.w);
  mediump vec4 res_26;
  highp float nh_27;
  mediump float tmpvar_28;
  tmpvar_28 = max (0.0, dot (tmpvar_19, normalize((lightDir_24 + normalize(xlv_TEXCOORD3)))));
  nh_27 = tmpvar_28;
  res_26.xyz = (_LightColor0.xyz * max (0.0, dot (lightDir_24, tmpvar_19)));
  lowp float tmpvar_29;
  tmpvar_29 = dot (_LightColor0.xyz, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_30;
  tmpvar_30 = (pow (nh_27, 0.0) * tmpvar_29);
  res_26.w = tmpvar_30;
  mediump vec4 tmpvar_31;
  tmpvar_31 = (res_26 * (atten_25 * 2.0));
  res_26 = tmpvar_31;
  mediump vec4 c_32;
  c_32.xyz = ((tmpvar_3 * tmpvar_31.xyz) + (tmpvar_31.xyz * (tmpvar_31.w * tmpvar_5)));
  c_32.w = 1.0;
  c_1.xyz = c_32.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_Diffuse_ST]
Vector 20 [_Normal_ST]
Vector 21 [_Specular_ST]
"agal_vs
c22 1.0 0.0 0.0 0.0
[bc]
aaaaaaaaaaaaaiacbgaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c22.x
aaaaaaaaaaaaahacbaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c16
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r1.z, r0, c10
bdaaaaaaabaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r1.y, r0, c9
bdaaaaaaabaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r1.x, r0, c8
adaaaaaaacaaahacabaaaakeacaaaaaabcaaaappabaaaaaa mul r2.xyz, r1.xyzz, c18.w
acaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r2.xyzz, a0
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaaaaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r0.yzxx
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaaeaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r4.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacaeaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r4.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaaeaaaeacbbaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c17, r0
aaaaaaaaaaaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c9
bdaaaaaaaeaaacacbbaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.y, c17, r0
aaaaaaaaabaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c8
bdaaaaaaaeaaabacbbaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.x, c17, r1
adaaaaaaabaaahacaeaaaakeacaaaaaabcaaaappabaaaaaa mul r1.xyz, r4.xyzz, c18.w
acaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r0.xyz, r1.xyzz, a0
bcaaaaaaacaaacaeaaaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v2.y, r0.xyzz, r2.xyzz
bcaaaaaaacaaaeaeabaaaaoeaaaaaaaaaaaaaakeacaaaaaa dp3 v2.z, a1, r0.xyzz
bcaaaaaaacaaabaeaaaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v2.x, r0.xyzz, a5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bcaaaaaaadaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v3.y, r2.xyzz, r3.xyzz
bcaaaaaaadaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v3.z, a1, r3.xyzz
bcaaaaaaadaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v3.x, a5, r3.xyzz
bdaaaaaaaeaaaeaeaaaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 v4.z, r0, c14
bdaaaaaaaeaaacaeaaaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 v4.y, r0, c13
bdaaaaaaaeaaabaeaaaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 v4.x, r0, c12
adaaaaaaaaaaamacadaaaaeeaaaaaaaabeaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c20.xyxy
abaaaaaaaaaaamaeaaaaaaopacaaaaaabeaaaaoeabaaaaaa add v0.zw, r0.wwzw, c20
adaaaaaaaaaaadacadaaaaoeaaaaaaaabdaaaaoeabaaaaaa mul r0.xy, a3, c19
abaaaaaaaaaaadaeaaaaaafeacaaaaaabdaaaaooabaaaaaa add v0.xy, r0.xyyy, c19.zwzw
adaaaaaaaaaaadacadaaaaoeaaaaaaaabfaaaaoeabaaaaaa mul r0.xy, a3, c21
abaaaaaaabaaadaeaaaaaafeacaaaaaabfaaaaooabaaaaaa add v1.xy, r0.xyyy, c21.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
"
}

SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 390
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 421
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 460
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    mediump vec3 lightDir;
    mediump vec3 viewDir;
    highp vec3 _LightCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 384
uniform sampler2D _LightTextureB0;
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
uniform sampler2D _Specular;
#line 388
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 401
#line 409
#line 428
#line 470
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 492
#line 81
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return ((objSpaceLightPos.xyz * unity_Scale.w) - v.xyz);
}
#line 90
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 428
void vert( inout appdata_full v, out Input o ) {
    highp vec4 VertexOutputMaster0_0_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_1_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    #line 432
    highp vec4 VertexOutputMaster0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
}
#line 473
v2f_surf vert_surf( in appdata_full v ) {
    #line 475
    v2f_surf o;
    Input customInputData;
    vert( v, customInputData);
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 479
    o.pack0.xy = ((v.texcoord.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _Normal_ST.xy) + _Normal_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Specular_ST.xy) + _Specular_ST.zw);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 483
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    #line 487
    o.viewDir = viewDirForLight;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec2(xl_retval.pack1);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec3(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 390
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 421
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 460
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    mediump vec3 lightDir;
    mediump vec3 viewDir;
    highp vec3 _LightCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 384
uniform sampler2D _LightTextureB0;
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
uniform sampler2D _Specular;
#line 388
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 401
#line 409
#line 428
#line 470
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 492
#line 401
mediump vec4 LightingBlinnPhongEditor_PrePass( in EditorSurfaceOutput s, in mediump vec4 light ) {
    mediump vec3 spec = (light.w * s.Gloss);
    mediump vec4 c;
    #line 405
    c.xyz = ((s.Albedo * light.xyz) + (light.xyz * spec));
    c.w = s.Alpha;
    return c;
}
#line 172
lowp float Luminance( in lowp vec3 c ) {
    #line 174
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 409
mediump vec4 LightingBlinnPhongEditor( in EditorSurfaceOutput s, in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diff = max( 0.0, dot( lightDir, s.Normal));
    #line 413
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    mediump vec4 res;
    res.xyz = (_LightColor0.xyz * diff);
    #line 417
    res.w = (spec * Luminance( _LightColor0.xyz));
    res *= (atten * 2.0);
    return LightingBlinnPhongEditor_PrePass( s, res);
}
#line 271
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 273
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 435
void surf( in Input IN, inout EditorSurfaceOutput o ) {
    #line 437
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Alpha = 1.0;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 441
    o.Gloss = vec3( 0.0);
    o.Specular = 0.0;
    o.Custom = vec4( 0.0);
    highp vec4 Tex2D1 = texture( _Diffuse, IN.uv_Diffuse.xyxy.xy);
    #line 445
    highp vec4 Multiply1 = (_MainColor * Tex2D1);
    highp vec4 Tex2D0 = texture( _Normal, IN.uv_Normal.xyxy.xy);
    highp vec4 UnpackNormal0 = vec4( UnpackNormal( Tex2D0).xyz, 1.0);
    highp vec4 Tex2D2 = texture( _Specular, IN.uv_Specular.xyxy.xy);
    #line 449
    highp vec4 Multiply0 = (Tex2D2 * vec4( _Specular_Power));
    highp vec4 Master0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_5_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    #line 453
    highp vec4 Master0_7_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_6_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    o.Albedo = vec3( Multiply1);
    o.Normal = vec3( UnpackNormal0);
    #line 457
    o.Gloss = vec3( Multiply0);
    o.Normal = normalize(o.Normal);
}
#line 492
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_Diffuse = IN.pack0.xy;
    #line 496
    surfIN.uv_Normal = IN.pack0.zw;
    surfIN.uv_Specular = IN.pack1.xy;
    EditorSurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 500
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    surf( surfIN, o);
    #line 504
    lowp vec3 lightDir = normalize(IN.lightDir);
    lowp vec4 c = LightingBlinnPhongEditor( o, lightDir, normalize(IN.viewDir), ((texture( _LightTextureB0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * texture( _LightTexture0, IN._LightCoord).w) * 1.0));
    c.w = 0.0;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec2(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 19 [unity_Scale]
Matrix 13 [_LightMatrix0]
Vector 20 [_Diffuse_ST]
Vector 21 [_Normal_ST]
Vector 22 [_Specular_ST]
"!!ARBvp1.0
# 33 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R3, R1;
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 33 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_Diffuse_ST]
Vector 20 [_Normal_ST]
Vector 21 [_Specular_ST]
"vs_2_0
; 36 ALU
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT2.y, r4, r2
dp3 oT3.y, r2, r3
dp3 oT2.z, v2, r4
dp3 oT2.x, r4, v1
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
dp4 oT4.y, r0, c13
dp4 oT4.x, r0, c12
mad oT0.zw, v3.xyxy, c20.xyxy, c20
mad oT0.xy, v3, c19, c19.zwzw
mad oT1.xy, v3, c21, c21.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 Tex2D2_6;
  highp vec4 UnpackNormal0_7;
  highp vec4 Tex2D0_8;
  highp vec4 Tex2D1_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_8 = tmpvar_11;
  lowp vec4 packednormal_12;
  packednormal_12 = Tex2D0_8;
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((packednormal_12.xyz * 2.0) - 1.0);
  UnpackNormal0_7 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Specular, xlv_TEXCOORD1);
  Tex2D2_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (_MainColor * Tex2D1_9).xyz;
  tmpvar_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = UnpackNormal0_7.xyz;
  tmpvar_4 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (Tex2D2_6 * vec4(_Specular_Power)).xyz;
  tmpvar_5 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_4);
  tmpvar_4 = tmpvar_18;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_LightTexture0, xlv_TEXCOORD4);
  mediump vec3 lightDir_20;
  lightDir_20 = lightDir_2;
  mediump float atten_21;
  atten_21 = tmpvar_19.w;
  mediump vec4 res_22;
  highp float nh_23;
  mediump float tmpvar_24;
  tmpvar_24 = max (0.0, dot (tmpvar_18, normalize((lightDir_20 + normalize(xlv_TEXCOORD3)))));
  nh_23 = tmpvar_24;
  res_22.xyz = (_LightColor0.xyz * max (0.0, dot (lightDir_20, tmpvar_18)));
  lowp float tmpvar_25;
  tmpvar_25 = dot (_LightColor0.xyz, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_26;
  tmpvar_26 = (pow (nh_23, 0.0) * tmpvar_25);
  res_22.w = tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = (res_22 * (atten_21 * 2.0));
  res_22 = tmpvar_27;
  mediump vec4 c_28;
  c_28.xyz = ((tmpvar_3 * tmpvar_27.xyz) + (tmpvar_27.xyz * (tmpvar_27.w * tmpvar_5)));
  c_28.w = 1.0;
  c_1.xyz = c_28.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 Tex2D2_6;
  highp vec4 UnpackNormal0_7;
  highp vec4 Tex2D0_8;
  highp vec4 Tex2D1_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Normal, xlv_TEXCOORD0.zw);
  Tex2D0_8 = tmpvar_11;
  lowp vec4 packednormal_12;
  packednormal_12 = Tex2D0_8;
  lowp vec3 normal_13;
  normal_13.xy = ((packednormal_12.wy * 2.0) - 1.0);
  normal_13.z = sqrt((1.0 - clamp (dot (normal_13.xy, normal_13.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = normal_13;
  UnpackNormal0_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Specular, xlv_TEXCOORD1);
  Tex2D2_6 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_MainColor * Tex2D1_9).xyz;
  tmpvar_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = UnpackNormal0_7.xyz;
  tmpvar_4 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (Tex2D2_6 * vec4(_Specular_Power)).xyz;
  tmpvar_5 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_4);
  tmpvar_4 = tmpvar_19;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_LightTexture0, xlv_TEXCOORD4);
  mediump vec3 lightDir_21;
  lightDir_21 = lightDir_2;
  mediump float atten_22;
  atten_22 = tmpvar_20.w;
  mediump vec4 res_23;
  highp float nh_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_19, normalize((lightDir_21 + normalize(xlv_TEXCOORD3)))));
  nh_24 = tmpvar_25;
  res_23.xyz = (_LightColor0.xyz * max (0.0, dot (lightDir_21, tmpvar_19)));
  lowp float tmpvar_26;
  tmpvar_26 = dot (_LightColor0.xyz, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_27;
  tmpvar_27 = (pow (nh_24, 0.0) * tmpvar_26);
  res_23.w = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = (res_23 * (atten_22 * 2.0));
  res_23 = tmpvar_28;
  mediump vec4 c_29;
  c_29.xyz = ((tmpvar_3 * tmpvar_28.xyz) + (tmpvar_28.xyz * (tmpvar_28.w * tmpvar_5)));
  c_29.w = 1.0;
  c_1.xyz = c_29.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_Diffuse_ST]
Vector 20 [_Normal_ST]
Vector 21 [_Specular_ST]
"agal_vs
c22 1.0 0.0 0.0 0.0
[bc]
aaaaaaaaaaaaaiacbgaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c22.x
aaaaaaaaaaaaahacbaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c16
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r1.z, r0, c10
bdaaaaaaabaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r1.y, r0, c9
bdaaaaaaabaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r1.x, r0, c8
adaaaaaaacaaahacabaaaakeacaaaaaabcaaaappabaaaaaa mul r2.xyz, r1.xyzz, c18.w
acaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r2.xyzz, a0
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaaaaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r0.yzxx
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaaeaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r4.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacaeaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r4.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaaeaaaeacbbaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c17, r0
aaaaaaaaaaaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c9
bdaaaaaaaeaaacacbbaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.y, c17, r0
aaaaaaaaabaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c8
bdaaaaaaaeaaabacbbaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.x, c17, r1
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bcaaaaaaacaaacaeaeaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v2.y, r4.xyzz, r2.xyzz
bcaaaaaaadaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v3.y, r2.xyzz, r3.xyzz
bcaaaaaaacaaaeaeabaaaaoeaaaaaaaaaeaaaakeacaaaaaa dp3 v2.z, a1, r4.xyzz
bcaaaaaaacaaabaeaeaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v2.x, r4.xyzz, a5
bcaaaaaaadaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v3.z, a1, r3.xyzz
bcaaaaaaadaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v3.x, a5, r3.xyzz
bdaaaaaaaeaaacaeaaaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 v4.y, r0, c13
bdaaaaaaaeaaabaeaaaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 v4.x, r0, c12
adaaaaaaaaaaamacadaaaaeeaaaaaaaabeaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c20.xyxy
abaaaaaaaaaaamaeaaaaaaopacaaaaaabeaaaaoeabaaaaaa add v0.zw, r0.wwzw, c20
adaaaaaaaaaaadacadaaaaoeaaaaaaaabdaaaaoeabaaaaaa mul r0.xy, a3, c19
abaaaaaaaaaaadaeaaaaaafeacaaaaaabdaaaaooabaaaaaa add v0.xy, r0.xyyy, c19.zwzw
adaaaaaaaaaaadacadaaaaoeaaaaaaaabfaaaaoeabaaaaaa mul r0.xy, a3, c21
abaaaaaaabaaadaeaaaaaafeacaaaaaabfaaaaooabaaaaaa add v1.xy, r0.xyyy, c21.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
aaaaaaaaaeaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.zw, c0
"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 389
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 420
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 459
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    mediump vec3 lightDir;
    mediump vec3 viewDir;
    highp vec2 _LightCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 384
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
#line 388
uniform highp vec4 _MainColor;
#line 400
#line 408
#line 427
#line 469
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 491
#line 81
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 90
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 427
void vert( inout appdata_full v, out Input o ) {
    highp vec4 VertexOutputMaster0_0_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_1_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    #line 431
    highp vec4 VertexOutputMaster0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
}
#line 472
v2f_surf vert_surf( in appdata_full v ) {
    #line 474
    v2f_surf o;
    Input customInputData;
    vert( v, customInputData);
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 478
    o.pack0.xy = ((v.texcoord.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _Normal_ST.xy) + _Normal_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Specular_ST.xy) + _Specular_ST.zw);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 482
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    #line 486
    o.viewDir = viewDirForLight;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xy;
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec2(xl_retval.pack1);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec2(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 389
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 420
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 459
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec2 pack1;
    mediump vec3 lightDir;
    mediump vec3 viewDir;
    highp vec2 _LightCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 384
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
#line 388
uniform highp vec4 _MainColor;
#line 400
#line 408
#line 427
#line 469
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Normal_ST;
uniform highp vec4 _Specular_ST;
#line 491
#line 400
mediump vec4 LightingBlinnPhongEditor_PrePass( in EditorSurfaceOutput s, in mediump vec4 light ) {
    mediump vec3 spec = (light.w * s.Gloss);
    mediump vec4 c;
    #line 404
    c.xyz = ((s.Albedo * light.xyz) + (light.xyz * spec));
    c.w = s.Alpha;
    return c;
}
#line 172
lowp float Luminance( in lowp vec3 c ) {
    #line 174
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 408
mediump vec4 LightingBlinnPhongEditor( in EditorSurfaceOutput s, in mediump vec3 lightDir, in mediump vec3 viewDir, in mediump float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    mediump float diff = max( 0.0, dot( lightDir, s.Normal));
    #line 412
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    mediump vec4 res;
    res.xyz = (_LightColor0.xyz * diff);
    #line 416
    res.w = (spec * Luminance( _LightColor0.xyz));
    res *= (atten * 2.0);
    return LightingBlinnPhongEditor_PrePass( s, res);
}
#line 271
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 273
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 434
void surf( in Input IN, inout EditorSurfaceOutput o ) {
    #line 436
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Alpha = 1.0;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 440
    o.Gloss = vec3( 0.0);
    o.Specular = 0.0;
    o.Custom = vec4( 0.0);
    highp vec4 Tex2D1 = texture( _Diffuse, IN.uv_Diffuse.xyxy.xy);
    #line 444
    highp vec4 Multiply1 = (_MainColor * Tex2D1);
    highp vec4 Tex2D0 = texture( _Normal, IN.uv_Normal.xyxy.xy);
    highp vec4 UnpackNormal0 = vec4( UnpackNormal( Tex2D0).xyz, 1.0);
    highp vec4 Tex2D2 = texture( _Specular, IN.uv_Specular.xyxy.xy);
    #line 448
    highp vec4 Multiply0 = (Tex2D2 * vec4( _Specular_Power));
    highp vec4 Master0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_5_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    #line 452
    highp vec4 Master0_7_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_6_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    o.Albedo = vec3( Multiply1);
    o.Normal = vec3( UnpackNormal0);
    #line 456
    o.Gloss = vec3( Multiply0);
    o.Normal = normalize(o.Normal);
}
#line 491
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_Diffuse = IN.pack0.xy;
    #line 495
    surfIN.uv_Normal = IN.pack0.zw;
    surfIN.uv_Specular = IN.pack1.xy;
    EditorSurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 499
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    surf( surfIN, o);
    #line 503
    lowp vec3 lightDir = IN.lightDir;
    lowp vec4 c = LightingBlinnPhongEditor( o, lightDir, normalize(IN.viewDir), (texture( _LightTexture0, IN._LightCoord).w * 1.0));
    c.w = 0.0;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec2(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec2(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 5
//   opengl - ALU: 24 to 36, TEX: 3 to 5
//   d3d9 - ALU: 25 to 37, TEX: 3 to 5
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 30 ALU, 4 TEX
PARAM c[5] = { program.local[0..2],
		{ 0, 0.2199707, 0.70703125, 0.070983887 },
		{ 2, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
MAD R1.xy, R1.wyzw, c[4].x, -c[4].y;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R1.z, R1, R1.w;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
ADD R1.z, -R1, c[4].y;
RSQ R1.z, R1.z;
RCP R1.z, R1.z;
DP3 R2.w, R1, R1;
DP3 R1.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R2.w, R2.w;
MUL R3.xyz, R2.w, R1;
RSQ R1.w, R1.w;
MUL R1.xyz, R1.w, fragment.texcoord[2];
DP3 R1.x, R1, R3;
MAX R1.x, R1, c[3];
MOV R3.xyz, c[3].yzww;
MUL R1.xyz, R1.x, c[0];
DP3 R1.w, R3, c[0];
MUL R2.xyz, R2, c[1].x;
MUL R0.xyz, R0, c[2];
MOV result.color.w, c[3].x;
TEX R0.w, R0.w, texture[3], 2D;
MUL R1, R0.w, R1;
MUL R1, R1, c[4].x;
MUL R2.xyz, R1.w, R2;
MUL R2.xyz, R1, R2;
MAD result.color.xyz, R0, R1, R2;
END
# 30 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_LightTexture0] 2D
"ps_2_0
; 31 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.21997070, 0.70703125, 0.07098389, 1.00000000
def c4, 2.00000000, -1.00000000, 0.00000000, 0
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t4.xyz
texld r3, t0, s0
texld r2, t1, s2
dp3 r1.x, t4, t4
mov r1.xy, r1.x
mov r0.y, t0.w
mov r0.x, t0.z
texld r0, r0, s1
texld r5, r1, s3
mov r0.x, r0.w
mad_pp r4.xy, r0, c4.x, c4.y
mul_pp r0.xy, r4, r4
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c3.w
rsq_pp r0.x, r0.x
rcp_pp r4.z, r0.x
dp3_pp r1.x, r4, r4
dp3_pp r0.x, t2, t2
rsq_pp r1.x, r1.x
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, t2
mul_pp r1.xyz, r1.x, r4
dp3_pp r0.x, r0, r1
mov_pp r1.xyz, c0
dp3_pp r0.w, c3, r1
mul r1.xyz, r2, c1.x
max_pp r0.x, r0, c4.z
mul_pp r0.xyz, r0.x, c0
mul_pp r0, r5.x, r0
mul_pp r0, r0, c4.x
mul_pp r1.xyz, r0.w, r1
mul_pp r1.xyz, r0, r1
mul r2.xyz, r3, c2
mad_pp r0.xyz, r2, r0, r1
mov_pp r0.w, c4.z
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "POINT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_LightTexture0] 2D
"agal_ps
c3 0.219971 0.707031 0.070984 1.0
c4 2.0 -1.0 0.0 0.0
[bc]
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
ciaaaaaaacaaapacabaaaaoeaeaaaaaaacaaaaaaafaababb tex r2, v1, s2 <2d wrap linear point>
bcaaaaaaaaaaabacaeaaaaoeaeaaaaaaaeaaaaoeaeaaaaaa dp3 r0.x, v4, v4
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
aaaaaaaaabaaacacaaaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r1.y, v0.w
aaaaaaaaabaaabacaaaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r1.x, v0.z
ciaaaaaaabaaapacabaaaafeacaaaaaaabaaaaaaafaababb tex r1, r1.xyyy, s1 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaafeacaaaaaaadaaaaaaafaababb tex r0, r0.xyyy, s3 <2d wrap linear point>
aaaaaaaaaaaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r1.y
aaaaaaaaaaaaabacabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r1.w
adaaaaaaaeaaadacaaaaaafeacaaaaaaaeaaaaaaabaaaaaa mul r4.xy, r0.xyyy, c4.x
abaaaaaaaeaaadacaeaaaafeacaaaaaaaeaaaaffabaaaaaa add r4.xy, r4.xyyy, c4.y
adaaaaaaaaaaabacaeaaaaffacaaaaaaaeaaaaffacaaaaaa mul r0.x, r4.y, r4.y
bfaaaaaaacaaaiacaeaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r2.w, r4.x
adaaaaaaacaaaiacacaaaappacaaaaaaaeaaaaaaacaaaaaa mul r2.w, r2.w, r4.x
acaaaaaaaaaaabacacaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r2.w, r0.x
abaaaaaaaaaaabacaaaaaaaaacaaaaaaadaaaappabaaaaaa add r0.x, r0.x, c3.w
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
afaaaaaaaeaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r4.z, r0.x
bcaaaaaaabaaabacaeaaaakeacaaaaaaaeaaaakeacaaaaaa dp3 r1.x, r4.xyzz, r4.xyzz
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r0.x, v2, v2
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaaoeaeaaaaaa mul r0.xyz, r0.x, v2
adaaaaaaabaaahacabaaaaaaacaaaaaaaeaaaakeacaaaaaa mul r1.xyz, r1.x, r4.xyzz
bcaaaaaaaaaaabacaaaaaakeacaaaaaaabaaaakeacaaaaaa dp3 r0.x, r0.xyzz, r1.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaakkabaaaaaa max r0.x, r0.x, c4.z
adaaaaaaabaaahacaaaaaaaaacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r0.x, c0
aaaaaaaaaaaaahacaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c0
bcaaaaaaabaaaiacadaaaaoeabaaaaaaaaaaaakeacaaaaaa dp3 r1.w, c3, r0.xyzz
adaaaaaaaaaaapacaaaaaappacaaaaaaabaaaaoeacaaaaaa mul r0, r0.w, r1
adaaaaaaabaaahacacaaaakeacaaaaaaabaaaaaaabaaaaaa mul r1.xyz, r2.xyzz, c1.x
adaaaaaaaaaaapacaaaaaaoeacaaaaaaaeaaaaaaabaaaaaa mul r0, r0, c4.x
adaaaaaaabaaahacaaaaaappacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.w, r1.xyzz
adaaaaaaabaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.xyzz, r1.xyzz
adaaaaaaacaaahacadaaaakeacaaaaaaacaaaaoeabaaaaaa mul r2.xyz, r3.xyzz, c2
adaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
aaaaaaaaaaaaaiacaeaaaakkabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c4.z
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 24 ALU, 3 TEX
PARAM c[5] = { program.local[0..2],
		{ 0, 0.2199707, 0.70703125, 0.070983887 },
		{ 2, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
MAD R1.xy, R1.wyzw, c[4].x, -c[4].y;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R0.w, R1.z, R1;
ADD R0.w, -R0, c[4].y;
RSQ R0.w, R0.w;
RCP R1.z, R0.w;
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R1;
DP3 R0.w, fragment.texcoord[2], R1;
MAX R0.w, R0, c[3].x;
MOV R3.xyz, c[3].yzww;
MUL R1.xyz, R0.w, c[0];
DP3 R1.w, R3, c[0];
MUL R1, R1, c[4].x;
MUL R2.xyz, R2, c[1].x;
MUL R2.xyz, R1.w, R2;
MUL R2.xyz, R1, R2;
MUL R0.xyz, R0, c[2];
MAD result.color.xyz, R0, R1, R2;
MOV result.color.w, c[3].x;
END
# 24 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
"ps_2_0
; 25 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 0.21997070, 0.70703125, 0.07098389, 1.00000000
def c4, 2.00000000, -1.00000000, 0.00000000, 0
dcl t0
dcl t1.xy
dcl t2.xyz
texld r2, t0, s0
texld r1, t1, s2
mov r0.y, t0.w
mov r0.x, t0.z
mul r1.xyz, r1, c1.x
mul r2.xyz, r2, c2
texld r0, r0, s1
mov r0.x, r0.w
mad_pp r3.xy, r0, c4.x, c4.y
mul_pp r0.xy, r3, r3
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c3.w
rsq_pp r0.x, r0.x
rcp_pp r3.z, r0.x
dp3_pp r0.x, r3, r3
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, r3
dp3_pp r0.x, t2, r0
max_pp r0.x, r0, c4.z
mov_pp r3.xyz, c0
mul_pp r0.xyz, r0.x, c0
dp3_pp r0.w, c3, r3
mul_pp r0, r0, c4.x
mul_pp r1.xyz, r0.w, r1
mul_pp r1.xyz, r0, r1
mad_pp r0.xyz, r2, r0, r1
mov_pp r0.w, c4.z
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
"agal_ps
c3 0.219971 0.707031 0.070984 1.0
c4 2.0 -1.0 0.0 0.0
[bc]
ciaaaaaaacaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r2, v0, s0 <2d wrap linear point>
ciaaaaaaabaaapacabaaaaoeaeaaaaaaacaaaaaaafaababb tex r1, v1, s2 <2d wrap linear point>
aaaaaaaaaaaaacacaaaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v0.w
aaaaaaaaaaaaabacaaaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v0.z
adaaaaaaabaaahacabaaaakeacaaaaaaabaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c1.x
adaaaaaaacaaahacacaaaakeacaaaaaaacaaaaoeabaaaaaa mul r2.xyz, r2.xyzz, c2
ciaaaaaaaaaaapacaaaaaafeacaaaaaaabaaaaaaafaababb tex r0, r0.xyyy, s1 <2d wrap linear point>
aaaaaaaaaaaaabacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r0.w
adaaaaaaadaaadacaaaaaafeacaaaaaaaeaaaaaaabaaaaaa mul r3.xy, r0.xyyy, c4.x
abaaaaaaadaaadacadaaaafeacaaaaaaaeaaaaffabaaaaaa add r3.xy, r3.xyyy, c4.y
adaaaaaaaaaaabacadaaaaffacaaaaaaadaaaaffacaaaaaa mul r0.x, r3.y, r3.y
bfaaaaaaabaaaiacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.w, r3.x
adaaaaaaabaaaiacabaaaappacaaaaaaadaaaaaaacaaaaaa mul r1.w, r1.w, r3.x
acaaaaaaaaaaabacabaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r1.w, r0.x
abaaaaaaaaaaabacaaaaaaaaacaaaaaaadaaaappabaaaaaa add r0.x, r0.x, c3.w
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
afaaaaaaadaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r3.z, r0.x
bcaaaaaaaaaaabacadaaaakeacaaaaaaadaaaakeacaaaaaa dp3 r0.x, r3.xyzz, r3.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaadaaaakeacaaaaaa mul r0.xyz, r0.x, r3.xyzz
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaaaaaaakeacaaaaaa dp3 r0.x, v2, r0.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaakkabaaaaaa max r0.x, r0.x, c4.z
aaaaaaaaadaaahacaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r3.xyz, c0
adaaaaaaaaaaahacaaaaaaaaacaaaaaaaaaaaaoeabaaaaaa mul r0.xyz, r0.x, c0
bcaaaaaaaaaaaiacadaaaaoeabaaaaaaadaaaakeacaaaaaa dp3 r0.w, c3, r3.xyzz
adaaaaaaaaaaapacaaaaaaoeacaaaaaaaeaaaaaaabaaaaaa mul r0, r0, c4.x
adaaaaaaabaaahacaaaaaappacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.w, r1.xyzz
adaaaaaaabaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.xyzz, r1.xyzz
adaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
aaaaaaaaaaaaaiacaeaaaakkabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c4.z
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 36 ALU, 5 TEX
PARAM c[5] = { program.local[0..2],
		{ 0, 0.5, 2, 1 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1.xyz, fragment.texcoord[1], texture[2], 2D;
RCP R0.x, fragment.texcoord[4].w;
MAD R2.xy, fragment.texcoord[4], R0.x, c[3].y;
DP3 R1.w, fragment.texcoord[4], fragment.texcoord[4];
MUL R1.xyz, R1, c[1].x;
MOV result.color.w, c[3].x;
TEX R0.w, R2, texture[3], 2D;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R1.w, R1.w, texture[4], 2D;
MAD R2.xy, R2.wyzw, c[3].z, -c[3].w;
MUL R2.zw, R2.xyxy, R2.xyxy;
ADD_SAT R2.z, R2, R2.w;
ADD R2.z, -R2, c[3].w;
RSQ R2.z, R2.z;
RCP R2.z, R2.z;
DP3 R3.x, R2, R2;
DP3 R2.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R3.x, R3.x;
MUL R3.xyz, R3.x, R2;
RSQ R2.w, R2.w;
MUL R2.xyz, R2.w, fragment.texcoord[2];
DP3 R2.x, R2, R3;
MOV R3.xyz, c[4];
DP3 R2.w, R3, c[0];
MAX R2.x, R2, c[3];
SLT R3.x, c[3], fragment.texcoord[4].z;
MUL R0.w, R3.x, R0;
MUL R2.xyz, R2.x, c[0];
MUL R0.w, R0, R1;
MUL R2, R0.w, R2;
MUL R2, R2, c[3].z;
MUL R1.xyz, R2.w, R1;
MUL R1.xyz, R2, R1;
MUL R0.xyz, R0, c[2];
MAD result.color.xyz, R0, R2, R1;
END
# 36 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
"ps_2_0
; 37 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c3, 0.00000000, 1.00000000, 0.50000000, 2.00000000
def c4, 0.21997070, 0.70703125, 0.07098389, 0
def c5, 2.00000000, -1.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t4
texld r3, t0, s0
texld r2, t1, s2
dp3 r0.x, t4, t4
mov r4.xy, r0.x
rcp r0.x, t4.w
mad r0.xy, t4, r0.x, c3.z
mov r1.y, t0.w
mov r1.x, t0.z
texld r1, r1, s1
texld r4, r4, s4
texld r0, r0, s3
mov r0.y, r1
mov r0.x, r1.w
mad_pp r5.xy, r0, c5.x, c5.y
mul_pp r0.xy, r5, r5
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c3.y
rsq_pp r0.x, r0.x
rcp_pp r5.z, r0.x
dp3_pp r1.x, r5, r5
dp3_pp r0.x, t2, t2
rsq_pp r1.x, r1.x
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, t2
mul_pp r1.xyz, r1.x, r5
dp3_pp r0.x, r0, r1
max_pp r0.x, r0, c3
mul_pp r1.xyz, r0.x, c0
cmp r0.x, -t4.z, c3, c3.y
mul_pp r0.x, r0, r0.w
mul_pp r0.x, r0, r4
mov_pp r4.xyz, c0
dp3_pp r1.w, c4, r4
mul_pp r0, r0.x, r1
mul r1.xyz, r2, c1.x
mul_pp r0, r0, c3.w
mul_pp r1.xyz, r0.w, r1
mul_pp r1.xyz, r0, r1
mul r2.xyz, r3, c2
mad_pp r0.xyz, r2, r0, r1
mov_pp r0.w, c3.x
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
"agal_ps
c3 0.0 1.0 0.5 2.0
c4 0.219971 0.707031 0.070984 0.0
c5 2.0 -1.0 0.0 0.0
[bc]
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
bcaaaaaaaaaaabacaeaaaaoeaeaaaaaaaeaaaaoeaeaaaaaa dp3 r0.x, v4, v4
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
afaaaaaaabaaabacaeaaaappaeaaaaaaaaaaaaaaaaaaaaaa rcp r1.x, v4.w
adaaaaaaabaaadacaeaaaaoeaeaaaaaaabaaaaaaacaaaaaa mul r1.xy, v4, r1.x
abaaaaaaabaaadacabaaaafeacaaaaaaadaaaakkabaaaaaa add r1.xy, r1.xyyy, c3.z
aaaaaaaaacaaacacaaaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r2.y, v0.w
aaaaaaaaacaaabacaaaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r2.x, v0.z
aaaaaaaaaeaaadacacaaaafeacaaaaaaaaaaaaaaaaaaaaaa mov r4.xy, r2.xyyy
ciaaaaaaaeaaapacaeaaaafeacaaaaaaabaaaaaaafaababb tex r4, r4.xyyy, s1 <2d wrap linear point>
ciaaaaaaacaaapacabaaaaoeaeaaaaaaacaaaaaaafaababb tex r2, v1, s2 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaafeacaaaaaaaeaaaaaaafaababb tex r0, r0.xyyy, s4 <2d wrap linear point>
ciaaaaaaabaaapacabaaaafeacaaaaaaadaaaaaaafaababb tex r1, r1.xyyy, s3 <2d wrap linear point>
aaaaaaaaaaaaacacaeaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r4.y
aaaaaaaaaaaaabacaeaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r4.w
adaaaaaaaeaaadacaaaaaafeacaaaaaaafaaaaaaabaaaaaa mul r4.xy, r0.xyyy, c5.x
abaaaaaaaeaaadacaeaaaafeacaaaaaaafaaaaffabaaaaaa add r4.xy, r4.xyyy, c5.y
adaaaaaaaaaaabacaeaaaaffacaaaaaaaeaaaaffacaaaaaa mul r0.x, r4.y, r4.y
bfaaaaaaacaaaiacaeaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r2.w, r4.x
adaaaaaaacaaaiacacaaaappacaaaaaaaeaaaaaaacaaaaaa mul r2.w, r2.w, r4.x
acaaaaaaaaaaabacacaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r2.w, r0.x
abaaaaaaaaaaabacaaaaaaaaacaaaaaaadaaaaffabaaaaaa add r0.x, r0.x, c3.y
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
afaaaaaaaeaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r4.z, r0.x
bcaaaaaaabaaabacaeaaaakeacaaaaaaaeaaaakeacaaaaaa dp3 r1.x, r4.xyzz, r4.xyzz
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r0.x, v2, v2
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
adaaaaaaabaaahacabaaaaaaacaaaaaaaeaaaakeacaaaaaa mul r1.xyz, r1.x, r4.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaaoeaeaaaaaa mul r0.xyz, r0.x, v2
bcaaaaaaaaaaabacaaaaaakeacaaaaaaabaaaakeacaaaaaa dp3 r0.x, r0.xyzz, r1.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaadaaaaoeabaaaaaa max r0.x, r0.x, c3
adaaaaaaabaaahacaaaaaaaaacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r0.x, c0
bfaaaaaaadaaaiacaeaaaakkaeaaaaaaaaaaaaaaaaaaaaaa neg r3.w, v4.z
ckaaaaaaaaaaabacadaaaappacaaaaaaafaaaakkabaaaaaa slt r0.x, r3.w, c5.z
adaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaappacaaaaaa mul r0.x, r0.x, r1.w
aaaaaaaaaeaaahacaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r4.xyz, c0
adaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaappacaaaaaa mul r0.x, r0.x, r0.w
bcaaaaaaabaaaiacaeaaaaoeabaaaaaaaeaaaakeacaaaaaa dp3 r1.w, c4, r4.xyzz
adaaaaaaaaaaapacaaaaaaaaacaaaaaaabaaaaoeacaaaaaa mul r0, r0.x, r1
adaaaaaaabaaahacacaaaakeacaaaaaaabaaaaaaabaaaaaa mul r1.xyz, r2.xyzz, c1.x
adaaaaaaaaaaapacaaaaaaoeacaaaaaaadaaaappabaaaaaa mul r0, r0, c3.w
adaaaaaaabaaahacaaaaaappacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.w, r1.xyzz
adaaaaaaabaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.xyzz, r1.xyzz
adaaaaaaacaaahacadaaaakeacaaaaaaacaaaaoeabaaaaaa mul r2.xyz, r3.xyzz, c2
adaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
aaaaaaaaaaaaaiacadaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c3.x
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 32 ALU, 5 TEX
PARAM c[5] = { program.local[0..2],
		{ 0, 0.2199707, 0.70703125, 0.070983887 },
		{ 2, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R1.w, fragment.texcoord[4], texture[4], CUBE;
MAD R2.xy, R2.wyzw, c[4].x, -c[4].y;
MUL R2.zw, R2.xyxy, R2.xyxy;
ADD_SAT R2.z, R2, R2.w;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
ADD R2.z, -R2, c[4].y;
RSQ R2.z, R2.z;
RCP R2.z, R2.z;
DP3 R3.x, R2, R2;
DP3 R2.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R3.x, R3.x;
MUL R3.xyz, R3.x, R2;
RSQ R2.w, R2.w;
MUL R2.xyz, R2.w, fragment.texcoord[2];
DP3 R2.x, R2, R3;
MAX R2.x, R2, c[3];
MOV R3.xyz, c[3].yzww;
MUL R2.xyz, R2.x, c[0];
DP3 R2.w, R3, c[0];
MUL R1.xyz, R1, c[1].x;
MUL R0.xyz, R0, c[2];
MOV result.color.w, c[3].x;
TEX R0.w, R0.w, texture[3], 2D;
MUL R0.w, R0, R1;
MUL R2, R0.w, R2;
MUL R2, R2, c[4].x;
MUL R1.xyz, R2.w, R1;
MUL R1.xyz, R2, R1;
MAD result.color.xyz, R0, R2, R1;
END
# 32 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"ps_2_0
; 33 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
def c3, 0.21997070, 0.70703125, 0.07098389, 1.00000000
def c4, 2.00000000, -1.00000000, 0.00000000, 0
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t4.xyz
texld r3, t0, s0
texld r2, t1, s2
dp3 r1.x, t4, t4
mov r1.xy, r1.x
mov r0.y, t0.w
mov r0.x, t0.z
texld r4, r1, s3
texld r1, r0, s1
texld r0, t4, s4
mov r0.y, r1
mov r0.x, r1.w
mad_pp r5.xy, r0, c4.x, c4.y
mul_pp r0.xy, r5, r5
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c3.w
rsq_pp r0.x, r0.x
rcp_pp r5.z, r0.x
dp3_pp r1.x, r5, r5
dp3_pp r0.x, t2, t2
rsq_pp r1.x, r1.x
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, t2
mul_pp r1.xyz, r1.x, r5
dp3_pp r0.x, r0, r1
max_pp r0.x, r0, c4.z
mul_pp r1.xyz, r0.x, c0
mul r0.x, r4, r0.w
mov_pp r4.xyz, c0
dp3_pp r1.w, c3, r4
mul_pp r0, r0.x, r1
mul r1.xyz, r2, c1.x
mul_pp r0, r0, c4.x
mul_pp r1.xyz, r0.w, r1
mul_pp r1.xyz, r0, r1
mul r2.xyz, r3, c2
mad_pp r0.xyz, r2, r0, r1
mov_pp r0.w, c4.z
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"agal_ps
c3 0.219971 0.707031 0.070984 1.0
c4 2.0 -1.0 0.0 0.0
[bc]
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
ciaaaaaaacaaapacabaaaaoeaeaaaaaaacaaaaaaafaababb tex r2, v1, s2 <2d wrap linear point>
bcaaaaaaabaaabacaeaaaaoeaeaaaaaaaeaaaaoeaeaaaaaa dp3 r1.x, v4, v4
aaaaaaaaabaaadacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r1.xy, r1.x
aaaaaaaaaaaaacacaaaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v0.w
aaaaaaaaaaaaabacaaaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v0.z
ciaaaaaaaeaaapacabaaaafeacaaaaaaadaaaaaaafaababb tex r4, r1.xyyy, s3 <2d wrap linear point>
ciaaaaaaabaaapacaaaaaafeacaaaaaaabaaaaaaafaababb tex r1, r0.xyyy, s1 <2d wrap linear point>
ciaaaaaaaaaaapacaeaaaaoeaeaaaaaaaeaaaaaaafbababb tex r0, v4, s4 <cube wrap linear point>
aaaaaaaaaaaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r1.y
aaaaaaaaaaaaabacabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r1.w
adaaaaaaaeaaadacaaaaaafeacaaaaaaaeaaaaaaabaaaaaa mul r4.xy, r0.xyyy, c4.x
abaaaaaaaeaaadacaeaaaafeacaaaaaaaeaaaaffabaaaaaa add r4.xy, r4.xyyy, c4.y
adaaaaaaaaaaabacaeaaaaffacaaaaaaaeaaaaffacaaaaaa mul r0.x, r4.y, r4.y
bfaaaaaaacaaaiacaeaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r2.w, r4.x
adaaaaaaacaaaiacacaaaappacaaaaaaaeaaaaaaacaaaaaa mul r2.w, r2.w, r4.x
acaaaaaaaaaaabacacaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r2.w, r0.x
abaaaaaaaaaaabacaaaaaaaaacaaaaaaadaaaappabaaaaaa add r0.x, r0.x, c3.w
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
afaaaaaaaeaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r4.z, r0.x
bcaaaaaaabaaabacaeaaaakeacaaaaaaaeaaaakeacaaaaaa dp3 r1.x, r4.xyzz, r4.xyzz
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r0.x, v2, v2
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaabaaahacabaaaaaaacaaaaaaaeaaaakeacaaaaaa mul r1.xyz, r1.x, r4.xyzz
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaaoeaeaaaaaa mul r0.xyz, r0.x, v2
bcaaaaaaaaaaabacaaaaaakeacaaaaaaabaaaakeacaaaaaa dp3 r0.x, r0.xyzz, r1.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaakkabaaaaaa max r0.x, r0.x, c4.z
aaaaaaaaaeaaahacaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r4.xyz, c0
adaaaaaaabaaahacaaaaaaaaacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r0.x, c0
adaaaaaaaaaaabacaeaaaappacaaaaaaaaaaaappacaaaaaa mul r0.x, r4.w, r0.w
bcaaaaaaabaaaiacadaaaaoeabaaaaaaaeaaaakeacaaaaaa dp3 r1.w, c3, r4.xyzz
adaaaaaaaaaaapacaaaaaaaaacaaaaaaabaaaaoeacaaaaaa mul r0, r0.x, r1
adaaaaaaabaaahacacaaaakeacaaaaaaabaaaaaaabaaaaaa mul r1.xyz, r2.xyzz, c1.x
adaaaaaaaaaaapacaaaaaaoeacaaaaaaaeaaaaaaabaaaaaa mul r0, r0, c4.x
adaaaaaaabaaahacaaaaaappacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.w, r1.xyzz
adaaaaaaabaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.xyzz, r1.xyzz
adaaaaaaacaaahacadaaaakeacaaaaaaacaaaaoeabaaaaaa mul r2.xyz, r3.xyzz, c2
adaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
aaaaaaaaaaaaaiacaeaaaakkabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c4.z
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 26 ALU, 4 TEX
PARAM c[5] = { program.local[0..2],
		{ 0, 0.2199707, 0.70703125, 0.070983887 },
		{ 2, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R0.w, fragment.texcoord[4], texture[3], 2D;
MAD R1.xy, R1.wyzw, c[4].x, -c[4].y;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R1.z, R1, R1.w;
ADD R1.z, -R1, c[4].y;
RSQ R1.z, R1.z;
RCP R1.z, R1.z;
DP3 R1.w, R1, R1;
RSQ R1.w, R1.w;
MUL R1.xyz, R1.w, R1;
DP3 R1.x, fragment.texcoord[2], R1;
MAX R1.x, R1, c[3];
MOV R3.xyz, c[3].yzww;
MUL R1.xyz, R1.x, c[0];
DP3 R1.w, R3, c[0];
MUL R1, R0.w, R1;
MUL R1, R1, c[4].x;
MUL R2.xyz, R2, c[1].x;
MUL R2.xyz, R1.w, R2;
MUL R2.xyz, R1, R2;
MUL R0.xyz, R0, c[2];
MAD result.color.xyz, R0, R1, R2;
MOV result.color.w, c[3].x;
END
# 26 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_LightTexture0] 2D
"ps_2_0
; 26 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.21997070, 0.70703125, 0.07098389, 1.00000000
def c4, 2.00000000, -1.00000000, 0.00000000, 0
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t4.xy
texld r2, t0, s0
texld r1, t1, s2
texld r3, t4, s3
mov r0.y, t0.w
mov r0.x, t0.z
mul r1.xyz, r1, c1.x
mul r2.xyz, r2, c2
texld r0, r0, s1
mov r0.x, r0.w
mad_pp r3.xy, r0, c4.x, c4.y
mul_pp r0.xy, r3, r3
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c3.w
rsq_pp r0.x, r0.x
rcp_pp r3.z, r0.x
dp3_pp r0.x, r3, r3
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, r3
mov_pp r3.xyz, c0
dp3_pp r0.x, t2, r0
max_pp r0.x, r0, c4.z
mul_pp r0.xyz, r0.x, c0
dp3_pp r0.w, c3, r3
mul_pp r0, r3.w, r0
mul_pp r0, r0, c4.x
mul_pp r1.xyz, r0.w, r1
mul_pp r1.xyz, r0, r1
mad_pp r0.xyz, r2, r0, r1
mov_pp r0.w, c4.z
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_Specular_Power]
Vector 2 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 1 [_Normal] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_LightTexture0] 2D
"agal_ps
c3 0.219971 0.707031 0.070984 1.0
c4 2.0 -1.0 0.0 0.0
[bc]
ciaaaaaaacaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r2, v0, s0 <2d wrap linear point>
aaaaaaaaaaaaacacaaaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v0.w
aaaaaaaaaaaaabacaaaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v0.z
aaaaaaaaabaaadacaaaaaafeacaaaaaaaaaaaaaaaaaaaaaa mov r1.xy, r0.xyyy
adaaaaaaacaaahacacaaaakeacaaaaaaacaaaaoeabaaaaaa mul r2.xyz, r2.xyzz, c2
ciaaaaaaadaaapacabaaaafeacaaaaaaabaaaaaaafaababb tex r3, r1.xyyy, s1 <2d wrap linear point>
ciaaaaaaabaaapacabaaaaoeaeaaaaaaacaaaaaaafaababb tex r1, v1, s2 <2d wrap linear point>
ciaaaaaaaaaaapacaeaaaaoeaeaaaaaaadaaaaaaafaababb tex r0, v4, s3 <2d wrap linear point>
aaaaaaaaaaaaacacadaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r3.y
aaaaaaaaaaaaabacadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r3.w
adaaaaaaadaaadacaaaaaafeacaaaaaaaeaaaaaaabaaaaaa mul r3.xy, r0.xyyy, c4.x
abaaaaaaadaaadacadaaaafeacaaaaaaaeaaaaffabaaaaaa add r3.xy, r3.xyyy, c4.y
adaaaaaaaaaaabacadaaaaffacaaaaaaadaaaaffacaaaaaa mul r0.x, r3.y, r3.y
bfaaaaaaabaaaiacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.w, r3.x
adaaaaaaabaaaiacabaaaappacaaaaaaadaaaaaaacaaaaaa mul r1.w, r1.w, r3.x
acaaaaaaaaaaabacabaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r1.w, r0.x
abaaaaaaaaaaabacaaaaaaaaacaaaaaaadaaaappabaaaaaa add r0.x, r0.x, c3.w
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
afaaaaaaadaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r3.z, r0.x
bcaaaaaaaaaaabacadaaaakeacaaaaaaadaaaakeacaaaaaa dp3 r0.x, r3.xyzz, r3.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaadaaaakeacaaaaaa mul r0.xyz, r0.x, r3.xyzz
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaaaaaaakeacaaaaaa dp3 r0.x, v2, r0.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaakkabaaaaaa max r0.x, r0.x, c4.z
adaaaaaaadaaahacaaaaaaaaacaaaaaaaaaaaaoeabaaaaaa mul r3.xyz, r0.x, c0
aaaaaaaaaaaaahacaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c0
bcaaaaaaadaaaiacadaaaaoeabaaaaaaaaaaaakeacaaaaaa dp3 r3.w, c3, r0.xyzz
adaaaaaaaaaaapacaaaaaappacaaaaaaadaaaaoeacaaaaaa mul r0, r0.w, r3
adaaaaaaaaaaapacaaaaaaoeacaaaaaaaeaaaaaaabaaaaaa mul r0, r0, c4.x
adaaaaaaabaaahacabaaaakeacaaaaaaabaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c1.x
adaaaaaaabaaahacaaaaaappacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.w, r1.xyzz
adaaaaaaabaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.xyzz, r1.xyzz
adaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
aaaaaaaaaaaaaiacaeaaaakkabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c4.z
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3"
}

}
	}
	Pass {
		Name "PREPASS"
		Tags { "LightMode" = "PrePassBase" }
		Fog {Mode Off}
Program "vp" {
// Vertex combos: 1
//   opengl - ALU: 21 to 21
//   d3d9 - ALU: 22 to 22
SubProgram "opengl " {
Keywords { }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [unity_Scale]
Vector 10 [_Normal_ST]
"!!ARBvp1.0
# 21 ALU
PARAM c[11] = { program.local[0],
		state.matrix.mvp,
		program.local[5..10] };
TEMP R0;
TEMP R1;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
DP3 R0.y, R1, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[1].xyz, R0, c[9].w;
DP3 R0.y, R1, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[2].xyz, R0, c[9].w;
DP3 R0.y, R1, c[7];
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[3].xyz, R0, c[9].w;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 21 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_Scale]
Vector 9 [_Normal_ST]
"vs_2_0
; 22 ALU
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
dp3 r0.y, r1, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul oT1.xyz, r0, c8.w
dp3 r0.y, r1, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul oT2.xyz, r0, c8.w
dp3 r0.y, r1, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul oT3.xyz, r0, c8.w
mad oT0.xy, v3, c9, c9.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _Normal_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_3 = tmpvar_1.xyz;
  tmpvar_4 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_5;
  tmpvar_5[0].x = tmpvar_3.x;
  tmpvar_5[0].y = tmpvar_4.x;
  tmpvar_5[0].z = tmpvar_2.x;
  tmpvar_5[1].x = tmpvar_3.y;
  tmpvar_5[1].y = tmpvar_4.y;
  tmpvar_5[1].z = tmpvar_2.y;
  tmpvar_5[2].x = tmpvar_3.z;
  tmpvar_5[2].y = tmpvar_4.z;
  tmpvar_5[2].z = tmpvar_2.z;
  vec3 v_6;
  v_6.x = _Object2World[0].x;
  v_6.y = _Object2World[1].x;
  v_6.z = _Object2World[2].x;
  vec3 v_7;
  v_7.x = _Object2World[0].y;
  v_7.y = _Object2World[1].y;
  v_7.z = _Object2World[2].y;
  vec3 v_8;
  v_8.x = _Object2World[0].z;
  v_8.y = _Object2World[1].z;
  v_8.z = _Object2World[2].z;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  xlv_TEXCOORD1 = ((tmpvar_5 * v_6) * unity_Scale.w);
  xlv_TEXCOORD2 = ((tmpvar_5 * v_7) * unity_Scale.w);
  xlv_TEXCOORD3 = ((tmpvar_5 * v_8) * unity_Scale.w);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _Normal;
void main ()
{
  lowp vec4 res_1;
  lowp vec3 worldN_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 UnpackNormal0_5;
  highp vec4 Tex2D0_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Normal, xlv_TEXCOORD0);
  Tex2D0_6 = tmpvar_7;
  lowp vec4 packednormal_8;
  packednormal_8 = Tex2D0_6;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((packednormal_8.xyz * 2.0) - 1.0);
  UnpackNormal0_5 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = UnpackNormal0_5.xyz;
  tmpvar_4 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(tmpvar_4);
  tmpvar_4 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD1, tmpvar_11);
  worldN_2.x = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD2, tmpvar_11);
  worldN_2.y = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD3, tmpvar_11);
  worldN_2.z = tmpvar_14;
  tmpvar_3 = worldN_2;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tmpvar_3 * 0.5) + 0.5);
  res_1.xyz = tmpvar_15;
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _Normal_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_3 = tmpvar_1.xyz;
  tmpvar_4 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_5;
  tmpvar_5[0].x = tmpvar_3.x;
  tmpvar_5[0].y = tmpvar_4.x;
  tmpvar_5[0].z = tmpvar_2.x;
  tmpvar_5[1].x = tmpvar_3.y;
  tmpvar_5[1].y = tmpvar_4.y;
  tmpvar_5[1].z = tmpvar_2.y;
  tmpvar_5[2].x = tmpvar_3.z;
  tmpvar_5[2].y = tmpvar_4.z;
  tmpvar_5[2].z = tmpvar_2.z;
  vec3 v_6;
  v_6.x = _Object2World[0].x;
  v_6.y = _Object2World[1].x;
  v_6.z = _Object2World[2].x;
  vec3 v_7;
  v_7.x = _Object2World[0].y;
  v_7.y = _Object2World[1].y;
  v_7.z = _Object2World[2].y;
  vec3 v_8;
  v_8.x = _Object2World[0].z;
  v_8.y = _Object2World[1].z;
  v_8.z = _Object2World[2].z;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Normal_ST.xy) + _Normal_ST.zw);
  xlv_TEXCOORD1 = ((tmpvar_5 * v_6) * unity_Scale.w);
  xlv_TEXCOORD2 = ((tmpvar_5 * v_7) * unity_Scale.w);
  xlv_TEXCOORD3 = ((tmpvar_5 * v_8) * unity_Scale.w);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _Normal;
void main ()
{
  lowp vec4 res_1;
  lowp vec3 worldN_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 UnpackNormal0_5;
  highp vec4 Tex2D0_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Normal, xlv_TEXCOORD0);
  Tex2D0_6 = tmpvar_7;
  lowp vec4 packednormal_8;
  packednormal_8 = Tex2D0_6;
  lowp vec3 normal_9;
  normal_9.xy = ((packednormal_8.wy * 2.0) - 1.0);
  normal_9.z = sqrt((1.0 - clamp (dot (normal_9.xy, normal_9.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = normal_9;
  UnpackNormal0_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = UnpackNormal0_5.xyz;
  tmpvar_4 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(tmpvar_4);
  tmpvar_4 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD1, tmpvar_12);
  worldN_2.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD2, tmpvar_12);
  worldN_2.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD3, tmpvar_12);
  worldN_2.z = tmpvar_15;
  tmpvar_3 = worldN_2;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tmpvar_3 * 0.5) + 0.5);
  res_1.xyz = tmpvar_16;
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 387
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 418
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 457
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    highp vec3 TtoW0;
    highp vec3 TtoW1;
    highp vec3 TtoW2;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 384
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 398
#line 406
#line 425
#line 466
uniform highp vec4 _Normal_ST;
#line 425
void vert( inout appdata_full v, out Input o ) {
    highp vec4 VertexOutputMaster0_0_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_1_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    #line 429
    highp vec4 VertexOutputMaster0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
}
#line 467
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 470
    Input customInputData;
    vert( v, customInputData);
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _Normal_ST.xy) + _Normal_ST.zw);
    #line 474
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    o.TtoW0 = ((rotation * xll_matrixindex_mf3x3_i (mat3( _Object2World), 0).xyz) * unity_Scale.w);
    o.TtoW1 = ((rotation * xll_matrixindex_mf3x3_i (mat3( _Object2World), 1).xyz) * unity_Scale.w);
    #line 478
    o.TtoW2 = ((rotation * xll_matrixindex_mf3x3_i (mat3( _Object2World), 2).xyz) * unity_Scale.w);
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.TtoW0);
    xlv_TEXCOORD2 = vec3(xl_retval.TtoW1);
    xlv_TEXCOORD3 = vec3(xl_retval.TtoW2);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 387
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 418
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 457
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    highp vec3 TtoW0;
    highp vec3 TtoW1;
    highp vec3 TtoW2;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 384
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 398
#line 406
#line 425
#line 466
uniform highp vec4 _Normal_ST;
#line 271
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 273
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 432
void surf( in Input IN, inout EditorSurfaceOutput o ) {
    #line 434
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Alpha = 1.0;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 438
    o.Gloss = vec3( 0.0);
    o.Specular = 0.0;
    o.Custom = vec4( 0.0);
    highp vec4 Tex2D1 = texture( _Diffuse, IN.uv_Diffuse.xyxy.xy);
    #line 442
    highp vec4 Multiply1 = (_MainColor * Tex2D1);
    highp vec4 Tex2D0 = texture( _Normal, IN.uv_Normal.xyxy.xy);
    highp vec4 UnpackNormal0 = vec4( UnpackNormal( Tex2D0).xyz, 1.0);
    highp vec4 Tex2D2 = texture( _Specular, IN.uv_Specular.xyxy.xy);
    #line 446
    highp vec4 Multiply0 = (Tex2D2 * vec4( _Specular_Power));
    highp vec4 Master0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_5_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    #line 450
    highp vec4 Master0_7_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_6_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    o.Albedo = vec3( Multiply1);
    o.Normal = vec3( UnpackNormal0);
    #line 454
    o.Gloss = vec3( Multiply0);
    o.Normal = normalize(o.Normal);
}
#line 481
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 483
    Input surfIN;
    surfIN.uv_Normal = IN.pack0.xy;
    EditorSurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 487
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    surf( surfIN, o);
    #line 491
    lowp vec3 worldN;
    worldN.x = dot( IN.TtoW0, o.Normal);
    worldN.y = dot( IN.TtoW1, o.Normal);
    worldN.z = dot( IN.TtoW2, o.Normal);
    #line 495
    o.Normal = worldN;
    lowp vec4 res;
    res.xyz = ((o.Normal * 0.5) + 0.5);
    res.w = o.Specular;
    #line 499
    return res;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec2(xlv_TEXCOORD0);
    xlt_IN.TtoW0 = vec3(xlv_TEXCOORD1);
    xlt_IN.TtoW1 = vec3(xlv_TEXCOORD2);
    xlt_IN.TtoW2 = vec3(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   opengl - ALU: 15 to 15, TEX: 1 to 1
//   d3d9 - ALU: 16 to 16, TEX: 1 to 1
SubProgram "opengl " {
Keywords { }
SetTexture 0 [_Normal] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 15 ALU, 1 TEX
PARAM c[1] = { { 0, 2, 1, 0.5 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[0], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[0].y, -c[0].z;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
ADD R0.z, -R0, c[0];
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R0;
DP3 R0.z, fragment.texcoord[3], R1;
DP3 R0.x, R1, fragment.texcoord[1];
DP3 R0.y, R1, fragment.texcoord[2];
MAD result.color.xyz, R0, c[0].w, c[0].w;
MOV result.color.w, c[0].x;
END
# 15 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
SetTexture 0 [_Normal] 2D
"ps_2_0
; 16 ALU, 1 TEX
dcl_2d s0
def c0, 2.00000000, -1.00000000, 1.00000000, 0.50000000
def c1, 0.00000000, 0, 0, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r0, t0, s0
mov r0.x, r0.w
mad_pp r1.xy, r0, c0.x, c0.y
mul_pp r0.xy, r1, r1
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c0.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
dp3_pp r0.x, r1, r1
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r1
dp3 r0.z, t3, r1
dp3 r0.x, r1, t1
dp3 r0.y, r1, t2
mad_pp r0.xyz, r0, c0.w, c0.w
mov_pp r0.w, c1.x
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3"
}

}
	}
	Pass {
		Name "PREPASS"
		Tags { "LightMode" = "PrePassFinal" }
		ZWrite Off
Program "vp" {
// Vertex combos: 4
//   opengl - ALU: 21 to 29
//   d3d9 - ALU: 21 to 29
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Matrix 5 [_Object2World]
Vector 17 [unity_Scale]
Vector 18 [_Diffuse_ST]
Vector 19 [_Specular_ST]
"!!ARBvp1.0
# 29 ALU
PARAM c[20] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[17].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[12];
DP4 R2.y, R0, c[11];
DP4 R2.x, R0, c[10];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[15];
DP4 R3.y, R1, c[14];
DP4 R3.x, R1, c[13];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MAD R0.x, R0, R0, -R0.y;
ADD R3.xyz, R2, R3;
MUL R2.xyz, R0.x, c[16];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R0.xyz, R1.xyww, c[0].x;
MUL R0.y, R0, c[9].x;
ADD result.texcoord[2].xyz, R3, R2;
ADD result.texcoord[1].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[1].zw, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
END
# 29 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Matrix 4 [_Object2World]
Vector 17 [unity_Scale]
Vector 18 [_Diffuse_ST]
Vector 19 [_Specular_ST]
"vs_2_0
; 29 ALU
def c20, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c17.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c20.y
dp4 r2.z, r0, c12
dp4 r2.y, r0, c11
dp4 r2.x, r0, c10
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c15
dp4 r3.y, r1, c14
dp4 r3.x, r1, c13
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
mad r0.x, r0, r0, -r0.y
add r3.xyz, r2, r3
mul r2.xyz, r0.x, c16
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r0.xyz, r1.xyww, c20.x
mul r0.y, r0, c8.x
add oT2.xyz, r3, r2
mad oT1.xy, r0.z, c9.zwzw, r0
mov oPos, r1
mov oT1.zw, r1
mad oT0.zw, v2.xyxy, c19.xyxy, c19
mad oT0.xy, v2, c18, c18.zwzw
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  tmpvar_2 = tmpvar_9;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  highp vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec4 Tex2D2_8;
  highp vec4 UnpackNormal0_9;
  highp vec4 Tex2D0_10;
  highp vec4 Tex2D1_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Normal, tmpvar_4);
  Tex2D0_10 = tmpvar_13;
  lowp vec4 packednormal_14;
  packednormal_14 = Tex2D0_10;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = ((packednormal_14.xyz * 2.0) - 1.0);
  UnpackNormal0_9 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Specular, xlv_TEXCOORD0.zw);
  Tex2D2_8 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (_MainColor * Tex2D1_11).xyz;
  tmpvar_5 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = UnpackNormal0_9.xyz;
  tmpvar_6 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (Tex2D2_8 * vec4(_Specular_Power)).xyz;
  tmpvar_7 = tmpvar_19;
  tmpvar_6 = normalize(tmpvar_6);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_22;
  mediump vec4 c_23;
  c_23.xyz = ((tmpvar_5 * light_3.xyz) + (light_3.xyz * (tmpvar_21.w * tmpvar_7)));
  c_23.w = 1.0;
  c_2.w = c_23.w;
  c_2.xyz = c_23.xyz;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  tmpvar_2 = tmpvar_9;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  highp vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec4 Tex2D2_8;
  highp vec4 UnpackNormal0_9;
  highp vec4 Tex2D0_10;
  highp vec4 Tex2D1_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Normal, tmpvar_4);
  Tex2D0_10 = tmpvar_13;
  lowp vec4 packednormal_14;
  packednormal_14 = Tex2D0_10;
  lowp vec3 normal_15;
  normal_15.xy = ((packednormal_14.wy * 2.0) - 1.0);
  normal_15.z = sqrt((1.0 - clamp (dot (normal_15.xy, normal_15.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = normal_15;
  UnpackNormal0_9 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Specular, xlv_TEXCOORD0.zw);
  Tex2D2_8 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_MainColor * Tex2D1_11).xyz;
  tmpvar_5 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = UnpackNormal0_9.xyz;
  tmpvar_6 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (Tex2D2_8 * vec4(_Specular_Power)).xyz;
  tmpvar_7 = tmpvar_20;
  tmpvar_6 = normalize(tmpvar_6);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_22.w;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_23;
  mediump vec4 c_24;
  c_24.xyz = ((tmpvar_5 * light_3.xyz) + (light_3.xyz * (tmpvar_22.w * tmpvar_7)));
  c_24.w = 1.0;
  c_2.w = c_24.w;
  c_2.xyz = c_24.xyz;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 387
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 418
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 457
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 screen;
    highp vec3 vlight;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 384
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 398
#line 406
#line 425
#line 465
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Specular_ST;
uniform sampler2D _LightBuffer;
#line 481
uniform lowp vec4 unity_Ambient;
#line 283
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 285
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 136
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 140
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 144
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 148
    return ((x1 + x2) + x3);
}
#line 425
void vert( inout appdata_full v, out Input o ) {
    highp vec4 VertexOutputMaster0_0_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_1_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    #line 429
    highp vec4 VertexOutputMaster0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
}
#line 467
v2f_surf vert_surf( in appdata_full v ) {
    #line 469
    v2f_surf o;
    Input customInputData;
    vert( v, customInputData);
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 473
    o.pack0.xy = ((v.texcoord.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _Specular_ST.xy) + _Specular_ST.zw);
    o.screen = ComputeScreenPos( o.pos);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 477
    o.vlight = ShadeSH9( vec4( worldN, 1.0));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.screen);
    xlv_TEXCOORD2 = vec3(xl_retval.vlight);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 387
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 418
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 457
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 screen;
    highp vec3 vlight;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 384
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 398
#line 406
#line 425
#line 465
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Specular_ST;
uniform sampler2D _LightBuffer;
#line 481
uniform lowp vec4 unity_Ambient;
#line 398
mediump vec4 LightingBlinnPhongEditor_PrePass( in EditorSurfaceOutput s, in mediump vec4 light ) {
    mediump vec3 spec = (light.w * s.Gloss);
    mediump vec4 c;
    #line 402
    c.xyz = ((s.Albedo * light.xyz) + (light.xyz * spec));
    c.w = s.Alpha;
    return c;
}
#line 271
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 273
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 432
void surf( in Input IN, inout EditorSurfaceOutput o ) {
    #line 434
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Alpha = 1.0;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 438
    o.Gloss = vec3( 0.0);
    o.Specular = 0.0;
    o.Custom = vec4( 0.0);
    highp vec4 Tex2D1 = texture( _Diffuse, IN.uv_Diffuse.xyxy.xy);
    #line 442
    highp vec4 Multiply1 = (_MainColor * Tex2D1);
    highp vec4 Tex2D0 = texture( _Normal, IN.uv_Normal.xyxy.xy);
    highp vec4 UnpackNormal0 = vec4( UnpackNormal( Tex2D0).xyz, 1.0);
    highp vec4 Tex2D2 = texture( _Specular, IN.uv_Specular.xyxy.xy);
    #line 446
    highp vec4 Multiply0 = (Tex2D2 * vec4( _Specular_Power));
    highp vec4 Master0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_5_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    #line 450
    highp vec4 Master0_7_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_6_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    o.Albedo = vec3( Multiply1);
    o.Normal = vec3( UnpackNormal0);
    #line 454
    o.Gloss = vec3( Multiply0);
    o.Normal = normalize(o.Normal);
}
#line 482
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    #line 485
    surfIN.uv_Diffuse = IN.pack0.xy;
    surfIN.uv_Specular = IN.pack0.zw;
    EditorSurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 489
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    surf( surfIN, o);
    #line 493
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    light = (-log2(light));
    light.xyz += IN.vlight;
    #line 497
    mediump vec4 c = LightingBlinnPhongEditor_PrePass( o, light);
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.screen = vec4(xlv_TEXCOORD1);
    xlt_IN.vlight = vec3(xlv_TEXCOORD2);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_ProjectionParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Matrix 9 [_Object2World]
Vector 15 [unity_LightmapST]
Vector 16 [_Diffuse_ST]
Vector 17 [_Specular_ST]
"!!ARBvp1.0
# 21 ALU
PARAM c[18] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..17] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[1].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[14].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[14];
MOV result.texcoord[1].zw, R0;
MUL result.texcoord[3].xyz, R1, c[14].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MUL result.texcoord[3].w, -R0.x, R0.y;
END
# 21 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Matrix 8 [_Object2World]
Vector 15 [unity_LightmapST]
Vector 16 [_Diffuse_ST]
Vector 17 [_Specular_ST]
"vs_2_0
; 21 ALU
def c18, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c18.x
mul r1.y, r1, c12.x
mad oT1.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov r0.x, c14.w
add r0.y, c18, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov oT1.zw, r0
mul oT3.xyz, r1, c14.w
mad oT0.zw, v1.xyxy, c17.xyxy, c17
mad oT0.xy, v1, c16, c16.zwzw
mad oT2.xy, v2, c15, c15.zwzw
mul oT3.w, -r0.x, r0.y
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  tmpvar_2.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_2.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  highp vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 Tex2D2_11;
  highp vec4 UnpackNormal0_12;
  highp vec4 Tex2D0_13;
  highp vec4 Tex2D1_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_14 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Normal, tmpvar_7);
  Tex2D0_13 = tmpvar_16;
  lowp vec4 packednormal_17;
  packednormal_17 = Tex2D0_13;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = ((packednormal_17.xyz * 2.0) - 1.0);
  UnpackNormal0_12 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_Specular, xlv_TEXCOORD0.zw);
  Tex2D2_11 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_MainColor * Tex2D1_14).xyz;
  tmpvar_8 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = UnpackNormal0_12.xyz;
  tmpvar_9 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (Tex2D2_11 * vec4(_Specular_Power)).xyz;
  tmpvar_10 = tmpvar_22;
  tmpvar_9 = normalize(tmpvar_9);
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_24.w;
  highp float tmpvar_25;
  tmpvar_25 = ((sqrt(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_27;
  light_6.xyz = (tmpvar_24.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  mediump vec4 c_28;
  c_28.xyz = ((tmpvar_8 * light_6.xyz) + (light_6.xyz * (tmpvar_24.w * tmpvar_10)));
  c_28.w = 1.0;
  c_2.w = c_28.w;
  c_2.xyz = c_28.xyz;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  tmpvar_2.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_2.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  highp vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 Tex2D2_11;
  highp vec4 UnpackNormal0_12;
  highp vec4 Tex2D0_13;
  highp vec4 Tex2D1_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_14 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Normal, tmpvar_7);
  Tex2D0_13 = tmpvar_16;
  lowp vec4 packednormal_17;
  packednormal_17 = Tex2D0_13;
  lowp vec3 normal_18;
  normal_18.xy = ((packednormal_17.wy * 2.0) - 1.0);
  normal_18.z = sqrt((1.0 - clamp (dot (normal_18.xy, normal_18.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = normal_18;
  UnpackNormal0_12 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_Specular, xlv_TEXCOORD0.zw);
  Tex2D2_11 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_MainColor * Tex2D1_14).xyz;
  tmpvar_8 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = UnpackNormal0_12.xyz;
  tmpvar_9 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (Tex2D2_11 * vec4(_Specular_Power)).xyz;
  tmpvar_10 = tmpvar_23;
  tmpvar_9 = normalize(tmpvar_9);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_25.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (unity_LightmapInd, xlv_TEXCOORD2);
  highp float tmpvar_28;
  tmpvar_28 = ((sqrt(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((8.0 * tmpvar_26.w) * tmpvar_26.xyz);
  lmFull_4 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((8.0 * tmpvar_27.w) * tmpvar_27.xyz);
  lmIndirect_3 = tmpvar_30;
  light_6.xyz = (tmpvar_25.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  mediump vec4 c_31;
  c_31.xyz = ((tmpvar_8 * light_6.xyz) + (light_6.xyz * (tmpvar_25.w * tmpvar_10)));
  c_31.w = 1.0;
  c_2.w = c_31.w;
  c_2.xyz = c_31.xyz;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 387
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 418
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 457
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 screen;
    highp vec2 lmap;
    highp vec4 lmapFadePos;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 384
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 398
#line 406
#line 425
#line 466
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Specular_ST;
#line 483
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 487
uniform lowp vec4 unity_Ambient;
#line 283
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 285
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 425
void vert( inout appdata_full v, out Input o ) {
    highp vec4 VertexOutputMaster0_0_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_1_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    #line 429
    highp vec4 VertexOutputMaster0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
}
#line 469
v2f_surf vert_surf( in appdata_full v ) {
    #line 471
    v2f_surf o;
    Input customInputData;
    vert( v, customInputData);
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 475
    o.pack0.xy = ((v.texcoord.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _Specular_ST.xy) + _Specular_ST.zw);
    o.screen = ComputeScreenPos( o.pos);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    #line 479
    o.lmapFadePos.xyz = (((_Object2World * v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
    o.lmapFadePos.w = ((-(glstate_matrix_modelview0 * v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.screen);
    xlv_TEXCOORD2 = vec2(xl_retval.lmap);
    xlv_TEXCOORD3 = vec4(xl_retval.lmapFadePos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 387
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 418
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 457
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 screen;
    highp vec2 lmap;
    highp vec4 lmapFadePos;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 384
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 398
#line 406
#line 425
#line 466
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Specular_ST;
#line 483
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 487
uniform lowp vec4 unity_Ambient;
#line 176
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 178
    return (2.0 * color.xyz);
}
#line 398
mediump vec4 LightingBlinnPhongEditor_PrePass( in EditorSurfaceOutput s, in mediump vec4 light ) {
    mediump vec3 spec = (light.w * s.Gloss);
    mediump vec4 c;
    #line 402
    c.xyz = ((s.Albedo * light.xyz) + (light.xyz * spec));
    c.w = s.Alpha;
    return c;
}
#line 271
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 273
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 432
void surf( in Input IN, inout EditorSurfaceOutput o ) {
    #line 434
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Alpha = 1.0;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 438
    o.Gloss = vec3( 0.0);
    o.Specular = 0.0;
    o.Custom = vec4( 0.0);
    highp vec4 Tex2D1 = texture( _Diffuse, IN.uv_Diffuse.xyxy.xy);
    #line 442
    highp vec4 Multiply1 = (_MainColor * Tex2D1);
    highp vec4 Tex2D0 = texture( _Normal, IN.uv_Normal.xyxy.xy);
    highp vec4 UnpackNormal0 = vec4( UnpackNormal( Tex2D0).xyz, 1.0);
    highp vec4 Tex2D2 = texture( _Specular, IN.uv_Specular.xyxy.xy);
    #line 446
    highp vec4 Multiply0 = (Tex2D2 * vec4( _Specular_Power));
    highp vec4 Master0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_5_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    #line 450
    highp vec4 Master0_7_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_6_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    o.Albedo = vec3( Multiply1);
    o.Normal = vec3( UnpackNormal0);
    #line 454
    o.Gloss = vec3( Multiply0);
    o.Normal = normalize(o.Normal);
}
#line 488
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    #line 491
    surfIN.uv_Diffuse = IN.pack0.xy;
    surfIN.uv_Specular = IN.pack0.zw;
    EditorSurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 495
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    surf( surfIN, o);
    #line 499
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    light = (-log2(light));
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    #line 503
    lowp vec4 lmtex2 = texture( unity_LightmapInd, IN.lmap.xy);
    mediump float lmFade = ((length(IN.lmapFadePos) * unity_LightmapFade.z) + unity_LightmapFade.w);
    mediump vec3 lmFull = DecodeLightmap( lmtex);
    mediump vec3 lmIndirect = DecodeLightmap( lmtex2);
    #line 507
    mediump vec3 lm = mix( lmIndirect, lmFull, vec3( xll_saturate_f(lmFade)));
    light.xyz += lm;
    mediump vec4 c = LightingBlinnPhongEditor_PrePass( o, light);
    c.xyz += o.Emission;
    #line 511
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.screen = vec4(xlv_TEXCOORD1);
    xlt_IN.lmap = vec2(xlv_TEXCOORD2);
    xlt_IN.lmapFadePos = vec4(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Matrix 5 [_Object2World]
Vector 17 [unity_Scale]
Vector 18 [_Diffuse_ST]
Vector 19 [_Specular_ST]
"!!ARBvp1.0
# 29 ALU
PARAM c[20] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[17].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[12];
DP4 R2.y, R0, c[11];
DP4 R2.x, R0, c[10];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[15];
DP4 R3.y, R1, c[14];
DP4 R3.x, R1, c[13];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MAD R0.x, R0, R0, -R0.y;
ADD R3.xyz, R2, R3;
MUL R2.xyz, R0.x, c[16];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R0.xyz, R1.xyww, c[0].x;
MUL R0.y, R0, c[9].x;
ADD result.texcoord[2].xyz, R3, R2;
ADD result.texcoord[1].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[1].zw, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
END
# 29 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Matrix 4 [_Object2World]
Vector 17 [unity_Scale]
Vector 18 [_Diffuse_ST]
Vector 19 [_Specular_ST]
"vs_2_0
; 29 ALU
def c20, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c17.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c20.y
dp4 r2.z, r0, c12
dp4 r2.y, r0, c11
dp4 r2.x, r0, c10
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c15
dp4 r3.y, r1, c14
dp4 r3.x, r1, c13
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
mad r0.x, r0, r0, -r0.y
add r3.xyz, r2, r3
mul r2.xyz, r0.x, c16
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r0.xyz, r1.xyww, c20.x
mul r0.y, r0, c8.x
add oT2.xyz, r3, r2
mad oT1.xy, r0.z, c9.zwzw, r0
mov oPos, r1
mov oT1.zw, r1
mad oT0.zw, v2.xyxy, c19.xyxy, c19
mad oT0.xy, v2, c18, c18.zwzw
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  tmpvar_2 = tmpvar_9;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  highp vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec4 Tex2D2_8;
  highp vec4 UnpackNormal0_9;
  highp vec4 Tex2D0_10;
  highp vec4 Tex2D1_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Normal, tmpvar_4);
  Tex2D0_10 = tmpvar_13;
  lowp vec4 packednormal_14;
  packednormal_14 = Tex2D0_10;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = ((packednormal_14.xyz * 2.0) - 1.0);
  UnpackNormal0_9 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Specular, xlv_TEXCOORD0.zw);
  Tex2D2_8 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (_MainColor * Tex2D1_11).xyz;
  tmpvar_5 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = UnpackNormal0_9.xyz;
  tmpvar_6 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (Tex2D2_8 * vec4(_Specular_Power)).xyz;
  tmpvar_7 = tmpvar_19;
  tmpvar_6 = normalize(tmpvar_6);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_22;
  mediump vec4 c_23;
  c_23.xyz = ((tmpvar_5 * light_3.xyz) + (light_3.xyz * (tmpvar_21.w * tmpvar_7)));
  c_23.w = 1.0;
  c_2.w = c_23.w;
  c_2.xyz = c_23.xyz;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  tmpvar_2 = tmpvar_9;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  highp vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec4 Tex2D2_8;
  highp vec4 UnpackNormal0_9;
  highp vec4 Tex2D0_10;
  highp vec4 Tex2D1_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Normal, tmpvar_4);
  Tex2D0_10 = tmpvar_13;
  lowp vec4 packednormal_14;
  packednormal_14 = Tex2D0_10;
  lowp vec3 normal_15;
  normal_15.xy = ((packednormal_14.wy * 2.0) - 1.0);
  normal_15.z = sqrt((1.0 - clamp (dot (normal_15.xy, normal_15.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = normal_15;
  UnpackNormal0_9 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Specular, xlv_TEXCOORD0.zw);
  Tex2D2_8 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_MainColor * Tex2D1_11).xyz;
  tmpvar_5 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = UnpackNormal0_9.xyz;
  tmpvar_6 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (Tex2D2_8 * vec4(_Specular_Power)).xyz;
  tmpvar_7 = tmpvar_20;
  tmpvar_6 = normalize(tmpvar_6);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_22.w;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_23;
  mediump vec4 c_24;
  c_24.xyz = ((tmpvar_5 * light_3.xyz) + (light_3.xyz * (tmpvar_22.w * tmpvar_7)));
  c_24.w = 1.0;
  c_2.w = c_24.w;
  c_2.xyz = c_24.xyz;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 387
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 418
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 457
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 screen;
    highp vec3 vlight;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 384
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 398
#line 406
#line 425
#line 465
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Specular_ST;
uniform sampler2D _LightBuffer;
#line 481
uniform lowp vec4 unity_Ambient;
#line 283
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 285
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 136
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 140
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 144
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 148
    return ((x1 + x2) + x3);
}
#line 425
void vert( inout appdata_full v, out Input o ) {
    highp vec4 VertexOutputMaster0_0_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_1_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    #line 429
    highp vec4 VertexOutputMaster0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
}
#line 467
v2f_surf vert_surf( in appdata_full v ) {
    #line 469
    v2f_surf o;
    Input customInputData;
    vert( v, customInputData);
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 473
    o.pack0.xy = ((v.texcoord.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _Specular_ST.xy) + _Specular_ST.zw);
    o.screen = ComputeScreenPos( o.pos);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 477
    o.vlight = ShadeSH9( vec4( worldN, 1.0));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.screen);
    xlv_TEXCOORD2 = vec3(xl_retval.vlight);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 387
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 418
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 457
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 screen;
    highp vec3 vlight;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 384
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 398
#line 406
#line 425
#line 465
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Specular_ST;
uniform sampler2D _LightBuffer;
#line 481
uniform lowp vec4 unity_Ambient;
#line 398
mediump vec4 LightingBlinnPhongEditor_PrePass( in EditorSurfaceOutput s, in mediump vec4 light ) {
    mediump vec3 spec = (light.w * s.Gloss);
    mediump vec4 c;
    #line 402
    c.xyz = ((s.Albedo * light.xyz) + (light.xyz * spec));
    c.w = s.Alpha;
    return c;
}
#line 271
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 273
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 432
void surf( in Input IN, inout EditorSurfaceOutput o ) {
    #line 434
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Alpha = 1.0;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 438
    o.Gloss = vec3( 0.0);
    o.Specular = 0.0;
    o.Custom = vec4( 0.0);
    highp vec4 Tex2D1 = texture( _Diffuse, IN.uv_Diffuse.xyxy.xy);
    #line 442
    highp vec4 Multiply1 = (_MainColor * Tex2D1);
    highp vec4 Tex2D0 = texture( _Normal, IN.uv_Normal.xyxy.xy);
    highp vec4 UnpackNormal0 = vec4( UnpackNormal( Tex2D0).xyz, 1.0);
    highp vec4 Tex2D2 = texture( _Specular, IN.uv_Specular.xyxy.xy);
    #line 446
    highp vec4 Multiply0 = (Tex2D2 * vec4( _Specular_Power));
    highp vec4 Master0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_5_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    #line 450
    highp vec4 Master0_7_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_6_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    o.Albedo = vec3( Multiply1);
    o.Normal = vec3( UnpackNormal0);
    #line 454
    o.Gloss = vec3( Multiply0);
    o.Normal = normalize(o.Normal);
}
#line 482
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    #line 485
    surfIN.uv_Diffuse = IN.pack0.xy;
    surfIN.uv_Specular = IN.pack0.zw;
    EditorSurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 489
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    surf( surfIN, o);
    #line 493
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    light.xyz += IN.vlight;
    mediump vec4 c = LightingBlinnPhongEditor_PrePass( o, light);
    #line 497
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.screen = vec4(xlv_TEXCOORD1);
    xlt_IN.vlight = vec3(xlv_TEXCOORD2);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_ProjectionParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Matrix 9 [_Object2World]
Vector 15 [unity_LightmapST]
Vector 16 [_Diffuse_ST]
Vector 17 [_Specular_ST]
"!!ARBvp1.0
# 21 ALU
PARAM c[18] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..17] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[1].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[14].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[14];
MOV result.texcoord[1].zw, R0;
MUL result.texcoord[3].xyz, R1, c[14].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MUL result.texcoord[3].w, -R0.x, R0.y;
END
# 21 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Matrix 8 [_Object2World]
Vector 15 [unity_LightmapST]
Vector 16 [_Diffuse_ST]
Vector 17 [_Specular_ST]
"vs_2_0
; 21 ALU
def c18, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c18.x
mul r1.y, r1, c12.x
mad oT1.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov r0.x, c14.w
add r0.y, c18, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov oT1.zw, r0
mul oT3.xyz, r1, c14.w
mad oT0.zw, v1.xyxy, c17.xyxy, c17
mad oT0.xy, v1, c16, c16.zwzw
mad oT2.xy, v2, c15, c15.zwzw
mul oT3.w, -r0.x, r0.y
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  tmpvar_2.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_2.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  highp vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 Tex2D2_11;
  highp vec4 UnpackNormal0_12;
  highp vec4 Tex2D0_13;
  highp vec4 Tex2D1_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_14 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Normal, tmpvar_7);
  Tex2D0_13 = tmpvar_16;
  lowp vec4 packednormal_17;
  packednormal_17 = Tex2D0_13;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = ((packednormal_17.xyz * 2.0) - 1.0);
  UnpackNormal0_12 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_Specular, xlv_TEXCOORD0.zw);
  Tex2D2_11 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_MainColor * Tex2D1_14).xyz;
  tmpvar_8 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = UnpackNormal0_12.xyz;
  tmpvar_9 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (Tex2D2_11 * vec4(_Specular_Power)).xyz;
  tmpvar_10 = tmpvar_22;
  tmpvar_9 = normalize(tmpvar_9);
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_24.w;
  highp float tmpvar_25;
  tmpvar_25 = ((sqrt(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_27;
  light_6.xyz = (tmpvar_24.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  mediump vec4 c_28;
  c_28.xyz = ((tmpvar_8 * light_6.xyz) + (light_6.xyz * (tmpvar_24.w * tmpvar_10)));
  c_28.w = 1.0;
  c_2.w = c_28.w;
  c_2.xyz = c_28.xyz;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Specular_ST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Specular_ST.xy) + _Specular_ST.zw);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  tmpvar_2.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_2.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform highp vec4 _MainColor;
uniform highp float _Specular_Power;
uniform sampler2D _Specular;
uniform sampler2D _Normal;
uniform sampler2D _Diffuse;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  highp vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 Tex2D2_11;
  highp vec4 UnpackNormal0_12;
  highp vec4 Tex2D0_13;
  highp vec4 Tex2D1_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Diffuse, xlv_TEXCOORD0.xy);
  Tex2D1_14 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Normal, tmpvar_7);
  Tex2D0_13 = tmpvar_16;
  lowp vec4 packednormal_17;
  packednormal_17 = Tex2D0_13;
  lowp vec3 normal_18;
  normal_18.xy = ((packednormal_17.wy * 2.0) - 1.0);
  normal_18.z = sqrt((1.0 - clamp (dot (normal_18.xy, normal_18.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = normal_18;
  UnpackNormal0_12 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_Specular, xlv_TEXCOORD0.zw);
  Tex2D2_11 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_MainColor * Tex2D1_14).xyz;
  tmpvar_8 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = UnpackNormal0_12.xyz;
  tmpvar_9 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (Tex2D2_11 * vec4(_Specular_Power)).xyz;
  tmpvar_10 = tmpvar_23;
  tmpvar_9 = normalize(tmpvar_9);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_25.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (unity_LightmapInd, xlv_TEXCOORD2);
  highp float tmpvar_28;
  tmpvar_28 = ((sqrt(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((8.0 * tmpvar_26.w) * tmpvar_26.xyz);
  lmFull_4 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((8.0 * tmpvar_27.w) * tmpvar_27.xyz);
  lmIndirect_3 = tmpvar_30;
  light_6.xyz = (tmpvar_25.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  mediump vec4 c_31;
  c_31.xyz = ((tmpvar_8 * light_6.xyz) + (light_6.xyz * (tmpvar_25.w * tmpvar_10)));
  c_31.w = 1.0;
  c_2.w = c_31.w;
  c_2.xyz = c_31.xyz;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 387
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 418
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 457
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 screen;
    highp vec2 lmap;
    highp vec4 lmapFadePos;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 384
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 398
#line 406
#line 425
#line 466
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Specular_ST;
#line 483
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 487
uniform lowp vec4 unity_Ambient;
#line 283
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 285
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 425
void vert( inout appdata_full v, out Input o ) {
    highp vec4 VertexOutputMaster0_0_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_1_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    #line 429
    highp vec4 VertexOutputMaster0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 VertexOutputMaster0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
}
#line 469
v2f_surf vert_surf( in appdata_full v ) {
    #line 471
    v2f_surf o;
    Input customInputData;
    vert( v, customInputData);
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 475
    o.pack0.xy = ((v.texcoord.xy * _Diffuse_ST.xy) + _Diffuse_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _Specular_ST.xy) + _Specular_ST.zw);
    o.screen = ComputeScreenPos( o.pos);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    #line 479
    o.lmapFadePos.xyz = (((_Object2World * v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
    o.lmapFadePos.w = ((-(glstate_matrix_modelview0 * v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.screen);
    xlv_TEXCOORD2 = vec2(xl_retval.lmap);
    xlv_TEXCOORD3 = vec4(xl_retval.lmapFadePos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 387
struct EditorSurfaceOutput {
    mediump vec3 Albedo;
    mediump vec3 Normal;
    mediump vec3 Emission;
    mediump vec3 Gloss;
    mediump float Specular;
    mediump float Alpha;
    mediump vec4 Custom;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 418
struct Input {
    highp vec2 uv_Diffuse;
    highp vec2 uv_Normal;
    highp vec2 uv_Specular;
};
#line 457
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 screen;
    highp vec2 lmap;
    highp vec4 lmapFadePos;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _Diffuse;
uniform sampler2D _Normal;
#line 384
uniform sampler2D _Specular;
uniform highp float _Specular_Power;
uniform highp vec4 _MainColor;
#line 398
#line 406
#line 425
#line 466
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Diffuse_ST;
uniform highp vec4 _Specular_ST;
#line 483
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 487
uniform lowp vec4 unity_Ambient;
#line 176
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 178
    return (2.0 * color.xyz);
}
#line 398
mediump vec4 LightingBlinnPhongEditor_PrePass( in EditorSurfaceOutput s, in mediump vec4 light ) {
    mediump vec3 spec = (light.w * s.Gloss);
    mediump vec4 c;
    #line 402
    c.xyz = ((s.Albedo * light.xyz) + (light.xyz * spec));
    c.w = s.Alpha;
    return c;
}
#line 271
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 273
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 432
void surf( in Input IN, inout EditorSurfaceOutput o ) {
    #line 434
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Alpha = 1.0;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 438
    o.Gloss = vec3( 0.0);
    o.Specular = 0.0;
    o.Custom = vec4( 0.0);
    highp vec4 Tex2D1 = texture( _Diffuse, IN.uv_Diffuse.xyxy.xy);
    #line 442
    highp vec4 Multiply1 = (_MainColor * Tex2D1);
    highp vec4 Tex2D0 = texture( _Normal, IN.uv_Normal.xyxy.xy);
    highp vec4 UnpackNormal0 = vec4( UnpackNormal( Tex2D0).xyz, 1.0);
    highp vec4 Tex2D2 = texture( _Specular, IN.uv_Specular.xyxy.xy);
    #line 446
    highp vec4 Multiply0 = (Tex2D2 * vec4( _Specular_Power));
    highp vec4 Master0_2_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_3_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_5_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    #line 450
    highp vec4 Master0_7_NoInput = vec4( 0.0, 0.0, 0.0, 0.0);
    highp vec4 Master0_6_NoInput = vec4( 1.0, 1.0, 1.0, 1.0);
    o.Albedo = vec3( Multiply1);
    o.Normal = vec3( UnpackNormal0);
    #line 454
    o.Gloss = vec3( Multiply0);
    o.Normal = normalize(o.Normal);
}
#line 488
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    #line 491
    surfIN.uv_Diffuse = IN.pack0.xy;
    surfIN.uv_Specular = IN.pack0.zw;
    EditorSurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 495
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    surf( surfIN, o);
    #line 499
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec4 lmtex2 = texture( unity_LightmapInd, IN.lmap.xy);
    #line 503
    mediump float lmFade = ((length(IN.lmapFadePos) * unity_LightmapFade.z) + unity_LightmapFade.w);
    mediump vec3 lmFull = DecodeLightmap( lmtex);
    mediump vec3 lmIndirect = DecodeLightmap( lmtex2);
    mediump vec3 lm = mix( lmIndirect, lmFull, vec3( xll_saturate_f(lmFade)));
    #line 507
    light.xyz += lm;
    mediump vec4 c = LightingBlinnPhongEditor_PrePass( o, light);
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.screen = vec4(xlv_TEXCOORD1);
    xlt_IN.lmap = vec2(xlv_TEXCOORD2);
    xlt_IN.lmapFadePos = vec4(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 4
//   opengl - ALU: 10 to 25, TEX: 3 to 5
//   d3d9 - ALU: 10 to 23, TEX: 3 to 5
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_Specular_Power]
Vector 1 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_LightBuffer] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 14 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0, fragment.texcoord[1], texture[3], 2D;
TEX R2.xyz, fragment.texcoord[0].zwzw, texture[2], 2D;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R2.xyz, R2, c[0].x;
LG2 R0.w, R0.w;
MUL R2.xyz, -R0.w, R2;
LG2 R0.x, R0.x;
LG2 R0.z, R0.z;
LG2 R0.y, R0.y;
ADD R0.xyz, -R0, fragment.texcoord[2];
MUL R2.xyz, R0, R2;
MUL R1.xyz, R1, c[1];
MAD result.color.xyz, R1, R0, R2;
MOV result.color.w, c[2].x;
END
# 14 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_Specular_Power]
Vector 1 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_LightBuffer] 2D
"ps_2_0
; 15 ALU, 3 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s3
def c2, 1.00000000, 0, 0, 0
dcl t0
dcl t1
dcl t2.xyz
texld r2, t0, s0
mov r0.y, t0.w
mov r0.x, t0.z
mov r1.xy, r0
mul r2.xyz, r2, c1
texldp r0, t1, s3
texld r1, r1, s2
log_pp r3.x, r0.w
mul r1.xyz, r1, c0.x
log_pp r0.x, r0.x
log_pp r0.z, r0.z
log_pp r0.y, r0.y
add_pp r0.xyz, -r0, t2
mul_pp r1.xyz, -r3.x, r1
mul_pp r1.xyz, r0, r1
mov_pp r0.w, c2.x
mad_pp r0.xyz, r2, r0, r1
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_Specular_Power]
Vector 1 [_MainColor]
Vector 2 [unity_LightmapFade]
SetTexture 0 [_Diffuse] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_LightBuffer] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 25 ALU, 5 TEX
PARAM c[4] = { program.local[0..2],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TXP R0, fragment.texcoord[1], texture[3], 2D;
TEX R1, fragment.texcoord[2], texture[5], 2D;
TEX R2, fragment.texcoord[2], texture[4], 2D;
TEX R3.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R4.xyz, fragment.texcoord[0].zwzw, texture[2], 2D;
MUL R2.xyz, R2.w, R2;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[3].y;
DP4 R2.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.w, R2.w;
RCP R1.w, R1.w;
MAD R2.xyz, R2, c[3].y, -R1;
MAD_SAT R1.w, R1, c[2].z, c[2];
MAD R1.xyz, R1.w, R2, R1;
MUL R2.xyz, R4, c[0].x;
LG2 R0.w, R0.w;
MUL R2.xyz, -R0.w, R2;
LG2 R0.x, R0.x;
LG2 R0.y, R0.y;
LG2 R0.z, R0.z;
ADD R0.xyz, -R0, R1;
MUL R1.xyz, R0, R2;
MUL R2.xyz, R3, c[1];
MAD result.color.xyz, R2, R0, R1;
MOV result.color.w, c[3].x;
END
# 25 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_Specular_Power]
Vector 1 [_MainColor]
Vector 2 [unity_LightmapFade]
SetTexture 0 [_Diffuse] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_LightBuffer] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"ps_2_0
; 23 ALU, 5 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c3, 8.00000000, 1.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3
texld r3, t0, s0
texldp r1, t1, s3
texld r4, t2, s5
mul_pp r4.xyz, r4.w, r4
mov r0.y, t0.w
mov r0.x, t0.z
mul_pp r4.xyz, r4, c3.x
log_pp r1.x, r1.x
log_pp r1.y, r1.y
log_pp r1.z, r1.z
texld r2, r0, s2
texld r0, t2, s4
mul_pp r5.xyz, r0.w, r0
dp4 r0.x, t3, t3
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r2.xyz, r2, c0.x
mad_pp r5.xyz, r5, c3.x, -r4
mad_sat r0.x, r0, c2.z, c2.w
mad_pp r0.xyz, r0.x, r5, r4
add_pp r1.xyz, -r1, r0
log_pp r0.x, r1.w
mul_pp r0.xyz, -r0.x, r2
mul_pp r0.xyz, r1, r0
mul r2.xyz, r3, c1
mov_pp r0.w, c3.y
mad_pp r0.xyz, r2, r1, r0
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_Specular_Power]
Vector 1 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_LightBuffer] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0, fragment.texcoord[1], texture[3], 2D;
TEX R2.xyz, fragment.texcoord[0].zwzw, texture[2], 2D;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R2.xyz, R2, c[0].x;
ADD R0.xyz, R0, fragment.texcoord[2];
MUL R2.xyz, R0.w, R2;
MUL R2.xyz, R0, R2;
MUL R1.xyz, R1, c[1];
MAD result.color.xyz, R1, R0, R2;
MOV result.color.w, c[2].x;
END
# 10 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_Specular_Power]
Vector 1 [_MainColor]
SetTexture 0 [_Diffuse] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_LightBuffer] 2D
"ps_2_0
; 10 ALU, 3 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s3
def c2, 1.00000000, 0, 0, 0
dcl t0
dcl t1
dcl t2.xyz
texld r2, t0, s0
mov r0.y, t0.w
mov r0.x, t0.z
mul r2.xyz, r2, c1
texld r1, r0, s2
texldp r0, t1, s3
mul r1.xyz, r1, c0.x
mul_pp r1.xyz, r0.w, r1
add_pp r0.xyz, r0, t2
mul_pp r1.xyz, r0, r1
mov_pp r0.w, c2.x
mad_pp r0.xyz, r2, r0, r1
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_Specular_Power]
Vector 1 [_MainColor]
Vector 2 [unity_LightmapFade]
SetTexture 0 [_Diffuse] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_LightBuffer] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 21 ALU, 5 TEX
PARAM c[4] = { program.local[0..2],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1, fragment.texcoord[2], texture[5], 2D;
TEX R2, fragment.texcoord[2], texture[4], 2D;
TEX R4.xyz, fragment.texcoord[0].zwzw, texture[2], 2D;
TXP R0, fragment.texcoord[1], texture[3], 2D;
TEX R3.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R1.xyz, R1.w, R1;
DP4 R1.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.w, R1.w;
RCP R1.w, R1.w;
MUL R1.xyz, R1, c[3].y;
MUL R2.xyz, R2.w, R2;
MAD R2.xyz, R2, c[3].y, -R1;
MAD_SAT R1.w, R1, c[2].z, c[2];
MAD R1.xyz, R1.w, R2, R1;
MUL R4.xyz, R4, c[0].x;
ADD R0.xyz, R0, R1;
MUL R2.xyz, R0.w, R4;
MUL R1.xyz, R0, R2;
MUL R2.xyz, R3, c[1];
MAD result.color.xyz, R2, R0, R1;
MOV result.color.w, c[3].x;
END
# 21 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_Specular_Power]
Vector 1 [_MainColor]
Vector 2 [unity_LightmapFade]
SetTexture 0 [_Diffuse] 2D
SetTexture 2 [_Specular] 2D
SetTexture 3 [_LightBuffer] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"ps_2_0
; 19 ALU, 5 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c3, 8.00000000, 1.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3
texld r4, t0, s0
texldp r1, t1, s3
texld r3, t2, s5
mul_pp r3.xyz, r3.w, r3
mov r0.y, t0.w
mov r0.x, t0.z
mul_pp r3.xyz, r3, c3.x
texld r2, r0, s2
texld r0, t2, s4
mul_pp r5.xyz, r0.w, r0
dp4 r0.x, t3, t3
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r2.xyz, r2, c0.x
mad_pp r5.xyz, r5, c3.x, -r3
mad_sat r0.x, r0, c2.z, c2.w
mad_pp r0.xyz, r0.x, r5, r3
add_pp r0.xyz, r1, r0
mul_pp r1.xyz, r1.w, r2
mul_pp r1.xyz, r0, r1
mul r2.xyz, r4, c1
mov_pp r0.w, c3.y
mad_pp r0.xyz, r2, r0, r1
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}

}
	}

#LINE 123

	}
	Fallback "Diffuse"
}