// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "UI/UI_Shine"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255

		_ColorMask ("Color Mask", Float) = 15

		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
		_Add_Texture("Add_Texture", 2D) = "black" {}
		_Noise_Speed("Noise_Speed", Vector) = (0,-0.2,0,0)
		_Noise_Power("Noise_Power", Float) = 0.2
		_Noise_Texture("Noise_Texture", 2D) = "white" {}
		[HDR]_Add_Color("Add_Color", Color) = (1,1,1,0)
		_Add_Shine("Add_Shine", Float) = 5
		_Rotator("Rotator", Float) = 1
		_Panner_Speed("Panner_Speed", Range( 0 , 20)) = 2
		_Panner_Time("Panner_Time", Range( 2 , 20)) = 2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}

	SubShader
	{
		LOD 0

		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True" }
		
		Stencil
		{
			Ref [_Stencil]
			ReadMask [_StencilReadMask]
			WriteMask [_StencilWriteMask]
			CompFront [_StencilComp]
			PassFront [_StencilOp]
			FailFront Keep
			ZFailFront Keep
			CompBack Always
			PassBack Keep
			FailBack Keep
			ZFailBack Keep
		}


		Cull Off
		Lighting Off
		ZWrite Off
		ZTest [unity_GUIZTestMode]
		Blend One One
		ColorMask [_ColorMask]

		
		Pass
		{
			Name "Default"
		CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0

			#include "UnityCG.cginc"
			#include "UnityUI.cginc"

			#pragma multi_compile __ UNITY_UI_CLIP_RECT
			#pragma multi_compile __ UNITY_UI_ALPHACLIP
			
			#include "UnityShaderVariables.cginc"
			
			struct appdata_t
			{
				float4 vertex   : POSITION;
				half4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				float2 texcoord  : TEXCOORD0;
				float4 worldPosition : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				
			};
			
			uniform fixed4 _Color;
			uniform fixed4 _TextureSampleAdd;
			uniform half4 _ClipRect;
			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			uniform half _Add_Shine;
			uniform sampler2D _Add_Texture;
			uniform half _Panner_Time;
			uniform half _Panner_Speed;
			uniform float4 _Add_Texture_ST;
			uniform half _Rotator;
			uniform sampler2D _Noise_Texture;
			uniform half2 _Noise_Speed;
			uniform float4 _Noise_Texture_ST;
			uniform half _Noise_Power;
			uniform half4 _Add_Color;

			
			v2f vert( appdata_t IN  )
			{
				v2f OUT;
				UNITY_SETUP_INSTANCE_ID( IN );
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
				UNITY_TRANSFER_INSTANCE_ID(IN, OUT);
				OUT.worldPosition = IN.vertex;
				
				OUT.vertex = UnityObjectToClipPos(OUT.worldPosition);

				OUT.texcoord = IN.texcoord;
				
				OUT.color = IN.color * _Color;
				return OUT;
			}

			fixed4 frag(v2f IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );

				float2 uv_MainTex = IN.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				half4 tex2DNode5 = tex2D( _MainTex, uv_MainTex );
				float mulTime53 = _Time.y * ( 1.0 / _Panner_Time );
				float2 uv_Add_Texture = IN.texcoord.xy * _Add_Texture_ST.xy + _Add_Texture_ST.zw;
				float cos24 = cos( _Rotator );
				float sin24 = sin( _Rotator );
				float2 rotator24 = mul( uv_Add_Texture, float2x2( cos24 , -sin24 , sin24 , cos24 ));
				float2 panner9 = ( ( ( ( frac( mulTime53 ) * _Panner_Speed ) - ( _Panner_Speed / 2.0 ) ) * ( 1.0 * _Panner_Time ) ) * half2( 0,1 ) + rotator24);
				float2 uv_Noise_Texture = IN.texcoord.xy * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
				float2 panner15 = ( 1.0 * _Time.y * _Noise_Speed + uv_Noise_Texture);
				half2 temp_cast_0 = (tex2D( _Noise_Texture, panner15 ).r).xx;
				half2 lerpResult11 = lerp( panner9 , temp_cast_0 , _Noise_Power);
				
				half4 color = ( ( tex2DNode5 + ( tex2DNode5.a * ( _Add_Shine * tex2D( _Add_Texture, lerpResult11 ) ) * _Add_Color ) ) * IN.color );
				
				#ifdef UNITY_UI_CLIP_RECT
                color.a *= UnityGet2DClipping(IN.worldPosition.xy, _ClipRect);
                #endif
				
				#ifdef UNITY_UI_ALPHACLIP
				clip (color.a - 0.001);
				#endif

				return color;
			}
		ENDCG
		}
	}
}
