Shader "Effect/Alpha_Disslove"
{
	Properties
	{
		[Enum(ADD,1,Alpha,10)]_Dst("Dst", Float) = 10
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("MainTex", 2D) = "white" {}
		_Brightness("Brightness", Float) = 1
		_MainTexUVSpeed("MainTexUVSpeed", Vector) = (0,0,0,0)
		_DissloveTex("DissloveTex", 2D) = "white" {}
		_SoftValue("SoftValue", Float) = 3
		_DissloveTexUVSpeed("DissloveTexUVSpeed", Vector) = (0,0,0,0)
		_MaskTex_R("MaskTex_R", 2D) = "white" {}
		_MaskMult("MaskMult", Float) = 1
		_MaskTexUVSpeed("MaskTexUVSpeed", Vector) = (0,0,0,0)
	}

	Category
	{
		Tags { "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
		Blend SrcAlpha [_Dst]
		BlendOp Add
		Cull Off Lighting Off ZTest LEqual ZWrite Off Fog{Mode Off}

		SubShader
		{
			Pass
			{
				HLSLPROGRAM
				#pragma multi_compile_instancing
				#pragma prefer_hlslcc gles
				#pragma exclude_renderers d3d11_9x

				#pragma vertex vert
				#pragma fragment frag

				#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

				struct VertexInput
				{
					float4 vertex : POSITION;
					float4 ase_texcoord : TEXCOORD0;
					float4 ase_texcoord1 : TEXCOORD1;
					half4 ase_color : COLOR;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct VertexOutput
				{
					float4 clipPos : SV_POSITION;
					float4 ase_texcoord3 : TEXCOORD3;
					float4 ase_texcoord4 : TEXCOORD4;
					half4 ase_color : COLOR;
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				CBUFFER_START(UnityPerMaterial)
				float4 _MainTex_ST;
				float4 _MainTexUVSpeed;
				half4 _Color;
				float4 _DissloveTex_ST;
				half4 _DissloveTexUVSpeed;
				float4 _MaskTex_R_ST;
				half4 _MaskTexUVSpeed;
				half _CullMode;
				half _Brightness;
				half _SoftValue;
				half _MaskMult;

				CBUFFER_END
				TEXTURE2D(_MainTex);
				SAMPLER(sampler_MainTex);
				TEXTURE2D(_DissloveTex);
				SAMPLER(sampler_DissloveTex);
				TEXTURE2D(_MaskTex_R);
				SAMPLER(sampler_MaskTex_R);

				VertexOutput VertexFunction(VertexInput v)
				{
					VertexOutput o = (VertexOutput)0;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_TRANSFER_INSTANCE_ID(v, o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					o.ase_texcoord3.xy = v.ase_texcoord.xy;
					o.ase_texcoord4 = v.ase_texcoord1;
					o.ase_color = v.ase_color;
					o.clipPos = TransformObjectToHClip(v.vertex.xyz);
					return o;
				}

				VertexOutput vert(VertexInput v)
				{
					return VertexFunction(v);
				}

				half4 frag(VertexOutput IN) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID(IN);
					UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

					float2 uv_MainTex = IN.ase_texcoord3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					float2 appendResult58 = (float2((_MainTexUVSpeed.x * _TimeParameters.x) , (_TimeParameters.x * _MainTexUVSpeed.y)));
					float2 appendResult62 = (float2(IN.ase_texcoord4.z , IN.ase_texcoord4.w));
					half4 tex2DNode1 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, (uv_MainTex + appendResult58 + appendResult62));

					float2 uv_DissloveTex = IN.ase_texcoord3.xy * _DissloveTex_ST.xy + _DissloveTex_ST.zw;
					float2 appendResult53 = (float2((_DissloveTexUVSpeed.x * _TimeParameters.x) , (_TimeParameters.x * _DissloveTexUVSpeed.y)));
					float lerpResult45 = lerp(_SoftValue , -1.5 , IN.ase_texcoord4.x);
					float2 uv_MaskTex_R = IN.ase_texcoord3.xy * _MaskTex_R_ST.xy + _MaskTex_R_ST.zw;
					float2 appendResult48 = (float2((_MaskTexUVSpeed.x * _TimeParameters.x) , (_TimeParameters.x * _MaskTexUVSpeed.y)));

					half3 Color = (tex2DNode1 * _Brightness * _Color * IN.ase_color).rgb;
					half Alpha = saturate((_Color.a * tex2DNode1.a * saturate(((SAMPLE_TEXTURE2D(_DissloveTex, sampler_DissloveTex, (uv_DissloveTex + appendResult53)).r * _SoftValue) - lerpResult45)) * (SAMPLE_TEXTURE2D(_MaskTex_R, sampler_MaskTex_R, (uv_MaskTex_R + appendResult48)).r * _MaskMult) * IN.ase_color.a));

					return half4(Color, Alpha);
				}

				ENDHLSL
			}

		}
	}	
}