Shader "Sprites/MotionBlur" 
{
	Properties
	{
		[PerRendererData] _MainTex("Sprite Texture", 2D) = "white" {}
		_Color("Tint", Color) = (1,1,1,1)
		[MaterialToggle] PixelSnap("Pixel snap", Float) = 0
		[HideInInspector] _RendererColor("RendererColor", Color) = (1,1,1,1)
		[HideInInspector] _Flip("Flip", Vector) = (1,1,1,1)
		[HideInInspector][PerRendererData] _AlphaTex("External Alpha", 2D) = "white" {}
		[PerRendererData] _EnableExternalAlpha("Enable External Alpha", Float) = 0

		_MotionBlurIntensity("Motion Blur Intensity", Range(0, 0.1)) = 0.01
		_MotionBlurSamples("Motion Blur Samples", Range(0, 5)) = 10

		_StencilComp("Stencil Comparison", Float) = 8
		_Stencil("Stencil ID", Float) = 0
		_StencilOp("Stencil Operation", Float) = 0
		_StencilWriteMask("Stencil Write Mask", Float) = 255
		_StencilReadMask("Stencil Read Mask", Float) = 255

		
	}

	SubShader
	{
		Tags
		{
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
			"PreviewType" = "Plane"
			"CanUseSpriteAtlas" = "True"
		}

		Stencil
		{
			Ref[_Stencil]
			Comp[_StencilComp]
			Pass[_StencilOp]
			ReadMask[_StencilReadMask]
			WriteMask[_StencilWriteMask]
		}

		Cull Off
		Lighting Off
		ZWrite Off
		Blend One OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM
			#pragma vertex SpriteVert
			#pragma fragment CustomSpriteFrag // Originally SpriteFrag
			#pragma target 2.0
			#pragma multi_compile_instancing
			#pragma multi_compile_local _ PIXELSNAP_ON
			#pragma multi_compile _ ETC1_EXTERNAL_ALPHA
			#include "UnitySprites.cginc"
			
			float _MotionBlurIntensity;
			int _MotionBlurSamples;
			
			float2 OffsetUV(float2 xy, float offset) {
				return xy + float2(0, offset);
			}

			fixed4 CustomSpriteFrag(v2f IN) : SV_Target // Copy of SpriteFrag from UnitySprites.cginc
			{
				fixed4 c = SampleSpriteTexture(IN.texcoord) * IN.color;

				// Motion blur
				half weight = 0.999, totalWeight = 1;
				for (int sample = 1; sample <= _MotionBlurSamples; sample++) {
					totalWeight += weight *= 1;
					c += SampleSpriteTexture(OffsetUV(IN.texcoord, sample * _MotionBlurIntensity)) * weight;
				}
				c /= totalWeight;

				c.rgb *= c.a;
				return c;
			}
			ENDCG
		}
	}
}