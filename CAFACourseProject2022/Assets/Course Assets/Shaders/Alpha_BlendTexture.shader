// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Effect/Alpha_BlendTexture"
{
	Properties
	{
		[Enum(ADD,1,Alpha,10)]_Dst("Dst", Float) = 10
		[Enum(Off, 0, On, 1)]_ZWriteMode("ZWrite", float) = 0
		[Enum(None, 0, Front, 1,Back, 2)]_CullMode("Cull", float) = 0 
		_Indensity("Indensity", Float) = 1
		_Opacity("Opacity", Float) = 1
		[HDR]_Color("Color", Color) = (1,1,1,1)
		_MainTex("MainTex", 2D) = "white" {}
		_MainU("MainU", Float) = 0
		_MainV("MainV", Float) = 0
		_AlphaTex1("AlphaTex", 2D) = "white" {}
		_AlphaU1("AlphaU", Float) = 0
		_AlphaV1("AlphaV", Float) = 0

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
		Blend SrcAlpha [_Dst]
		BlendOp Add
		Cull [_CullMode] Lighting Off ZTest LEqual ZWrite [_ZWriteMode]  Fog{Mode Off}

		SubShader
		{
			Pass
			{
				HLSLPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
				#pragma target 3.0

				uniform sampler2D _MainTex;
				uniform sampler2D _AlphaTex1;

				CBUFFER_START(UnityPerMaterial)
				uniform half _MainU;
				uniform half _MainV;
				uniform float4 _MainTex_ST;
				uniform half _Indensity;
				uniform half4 _Color;
				uniform half _Opacity;
				uniform half _AlphaU1;
				uniform half _AlphaV1;
				uniform float4 _AlphaTex1_ST;
				CBUFFER_END

				struct appdata_t {
					float4 vertex : POSITION;
					half4 color : COLOR;
					float2 texcoord : TEXCOORD0;
				};

				struct v2f {
					float4 vertex : POSITION;
					half4 vertexColor : COLOR;
					float2 uv_texcoord : TEXCOORD0;
				};

				v2f vert(appdata_t v)
				{
					v2f o;
					o.vertex = TransformObjectToHClip(v.vertex.xyz);
					o.vertexColor = v.color;
					o.uv_texcoord = v.texcoord;
					return o;
				}

				half4 frag(v2f i) : COLOR
				{
					half2 appendResult6 = half2(_MainU , _MainV);
					float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
					float2 Main_UV39 = (appendResult6 * _Time.y) + uv_MainTex;
					half4 tex2DNode1 = tex2D(_MainTex, Main_UV39);
					half desaturateDot30 = dot(tex2DNode1.rgb, half3(0.299, 0.587, 0.114));
					half3 color = tex2DNode1.rgb * _Indensity * _Color.rgb  * i.vertexColor.rgb;

					half2 appendResult45 = half2(_AlphaU1 , _AlphaV1);
					float2 uv_AlphaTex1 = i.uv_texcoord * _AlphaTex1_ST.xy + _AlphaTex1_ST.zw;
					half desaturateInitialColor50 = tex2D(_AlphaTex1, ((appendResult45 * _Time.y) + uv_AlphaTex1)).r;

					half alpha = tex2DNode1.a * _Color.a * _Opacity * i.vertexColor.a * desaturateInitialColor50;
					return half4(color, alpha);
				}
				ENDHLSL
			}
		}
	}
}
