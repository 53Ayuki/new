// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Effect/Alpha_TextureDistortion"
{
	Properties
	{
		[Toggle]_Desaturate("Desaturate", Float) = 0
		[Enum(ADD,1,Alpha,10)]_Dst("Dst", Float) = 10
		_Indensity("Indensity", Float) = 1
		_Indensity_Power("Indensity_Power", Float) = 1
		_Opacity("Opacity", Float) = 1
		[HDR]_Color("Color", Color) = (1,1,1,1)
		_MainTex("MainTex", 2D) = "white" {}
		_MainU("MainU", Float) = 0
		_MainV("MainV", Float) = 0
		_AlphaTex("AlphaTex", 2D) = "white" {}
		[Toggle(_DISTORTIONINALPHA1_ON)] _DistortionInAlpha1("DistortionInAlpha", Float) = 0
		_AlphaU("AlphaU", Float) = 0
		_AlphaV("AlphaV", Float) = 0
		_DistortionTex("DistortionTex", 2D) = "white" {}
		_DistortionIndensity("DistortionIndensity", Float) = 0
		_DistortionU("DistortionU", Float) = 0
		_DistortionV("DistortionV", Float) = 0

		_StencilComp("Stencil Comparison", Float) = 8
		_Stencil("Stencil ID", Float) = 0
		_StencilOp("Stencil Operation", Float) = 0
		_StencilWriteMask("Stencil Write Mask", Float) = 255
		_StencilReadMask("Stencil Read Mask", Float) = 255
	}

	Category
	{
		Stencil
		{
			Ref[_Stencil]
			Comp[_StencilComp]
			Pass[_StencilOp]
			ReadMask[_StencilReadMask]
			WriteMask[_StencilWriteMask]
		}

		Tags { "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
		Blend SrcAlpha[_Dst]
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
				#pragma shader_feature _DISTORTIONINALPHA1_ON

				#pragma vertex vert
				#pragma fragment frag
				
				#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

				struct VertexInput
				{
					float4 vertex : POSITION;
					float2 uv_texcoord : TEXCOORD0;
					half4 vertexColor : COLOR;
				};

				struct VertexOutput
				{
					float4 clipPos : SV_POSITION;
					half4 vertexColor : COLOR;
					float2 uv_texcoord : TEXCOORD0;
				};

				CBUFFER_START(UnityPerMaterial)
				uniform half _Dst;
				uniform half _Desaturate;
				uniform half _MainU;
				uniform half _MainV;
				uniform float4 _MainTex_ST;
				uniform float4 _DistortionTex_ST;
				uniform half _DistortionU;
				uniform half _DistortionV;
				uniform half _DistortionIndensity;
				uniform half _Indensity;
				uniform half4 _Color;
				uniform half _Indensity_Power;
				uniform half _Opacity;
				uniform half _AlphaU;
				uniform half _AlphaV;
				uniform float4 _AlphaTex_ST;
				CBUFFER_END

				uniform sampler2D _MainTex;
				uniform sampler2D _AlphaTex;
				uniform sampler2D _DistortionTex;

				VertexOutput vert(VertexInput v)
				{
					VertexOutput o = (VertexOutput)0;
					o.clipPos = TransformObjectToHClip(v.vertex.xyz);
					o.uv_texcoord = v.uv_texcoord;
					o.vertexColor = v.vertexColor;
					
					return o;
				}

				half4 frag(VertexOutput i) : SV_Target
				{
					half2 appendResult6 = half2(_MainU , _MainV);
					float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
					float2 uv_DistortionTex = i.uv_texcoord * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					half2 appendResult55 = half2(_DistortionU , _DistortionV);
					half3 desaturateInitialColor61 = tex2D(_DistortionTex, (uv_DistortionTex + (appendResult55 * _Time.y))).rgb;
					float desaturateDot61 = dot(desaturateInitialColor61, half3(0.299, 0.587, 0.114));
					half3 desaturateVar61 = lerp(desaturateInitialColor61, desaturateDot61.xxx, 1.0);
					float3 lerpResult65 = lerp(float3(((appendResult6 * _Time.y) + uv_MainTex) ,  0.0) , desaturateVar61 , _DistortionIndensity);
					float4 tex2DNode1 = tex2D(_MainTex, lerpResult65.xy);
					half desaturateDot30 = dot(tex2DNode1.rgb, half3(0.299, 0.587, 0.114));
					half3 desaturateVar30 = lerp(tex2DNode1.rgb, desaturateDot30.xxx, ((_Desaturate) ? (1.0) : (0.0)));
					half3 color = pow(desaturateVar30 * _Indensity * _Color.rgb * i.vertexColor.rgb, _Indensity_Power.xxx);
					half2 appendResult45 = half2(_AlphaU , _AlphaV);
					float2 uv_AlphaTex = i.uv_texcoord * _AlphaTex_ST.xy + _AlphaTex_ST.zw;
					float2 temp_output_48_0 = ((appendResult45 * _Time.y) + uv_AlphaTex);

					float3 lerpResult66 = lerp(float3(temp_output_48_0 ,  0.0) , desaturateVar61 , _DistortionIndensity);
					#ifdef _DISTORTIONINALPHA1_ON
						float3 staticSwitch69 = lerpResult66;
					#else
						float3 staticSwitch69 = float3(temp_output_48_0 ,  0.0);
					#endif
					half3 desaturateInitialColor50 = tex2D(_AlphaTex, staticSwitch69.xy).rgb;
					half desaturateDot50 = dot(desaturateInitialColor50, half3(0.299, 0.587, 0.114));
					half desaturateVar50 = lerp(desaturateInitialColor50.x, desaturateDot50, 1.0);
					half Alpha = tex2DNode1.a * _Color.a * _Opacity * i.vertexColor.a * desaturateVar50;
					return half4(color, Alpha);
				}

				ENDHLSL
			}
		}
	}
}
