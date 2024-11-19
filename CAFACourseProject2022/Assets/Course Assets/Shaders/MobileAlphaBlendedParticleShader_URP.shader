// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

Shader "Mobile/Particles/TintAlpha Blended_URP" {
	Properties{
		_TintColor("Tint Color", Color) = (0.5,0.5,0.5,0.5)
		_MainTex("Particle Texture", 2D) = "white" {}
		[HideInInspector] _Color("Color", Color) = (1,1,1,1)
	}

		Category{
			Tags { "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" "PreviewType" = "Plane" "RenderPipeline" = "UniversalPipeline" }
			Blend SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			Lighting Off Cull[_Cull] ZTest LEqual ZWrite Off

			SubShader {
				Pass {
					HLSLPROGRAM
					#pragma vertex vert
					#pragma fragment frag
					#pragma target 2.0
					#pragma multi_compile_particles

					#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
					#define fixed4 half4
					#define fixed3 half3
					#define fixed2 half2
					#define fixed half

					sampler2D _MainTex;

					CBUFFER_START(UnityPerMaterial)
					fixed4 _TintColor;
					fixed4 _Color;
					float4 _MainTex_ST;
					CBUFFER_END

					struct appdata_t {
						float4 vertex : POSITION;
						fixed4 color : COLOR;
						float2 texcoord : TEXCOORD0;
						UNITY_VERTEX_INPUT_INSTANCE_ID
					};

					struct v2f {
						float4 vertex : SV_POSITION;
						fixed4 color : COLOR;
						float2 texcoord : TEXCOORD0;
						UNITY_VERTEX_OUTPUT_STEREO
					};

					

					v2f vert(appdata_t v)
					{
						v2f o;
						UNITY_SETUP_INSTANCE_ID(v);
						UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
						float3 positionWS = TransformObjectToWorld(v.vertex);
						o.vertex = TransformWorldToHClip(positionWS);
						o.color = v.color;
						o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
						return o;
					}

					fixed4 frag(v2f i) : SV_Target
					{
						fixed4 col =_TintColor * tex2D(_MainTex, i.texcoord) * _Color * i.color;
						return col;
					}
					ENDHLSL
				}
			}
		}
}