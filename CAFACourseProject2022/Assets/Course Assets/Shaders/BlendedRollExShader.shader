// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "EffectShader/BlendedRollEx" {
Properties {
	_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
	_intensity("Intensity",Float) = 1
	_MainTex ("Main Texture", 2D) = "white" {}
	_NoiseTex ("Noise Texture", 2D) = "white" {}
	[KeywordEnum(r,g,b,a)] _opacityMapChannel("OpacityMapChannel", Int) = 3
	_RollTimeX ("Roll Time X", Float) = 0.2
	_RollTimeY ("Roll Time Y", Float) = 0
	_Angle ("Angle", float) = 0

	//[KeywordEnum(r,g,b,a)] _opacityMapChannel1("OpacityMapChannel_1", Int) = 3
	_RollTimeX1("Roll Time X_1", Float) = 0.2
	_RollTimeY1("Roll Time Y_1", Float) = 0
	_Angle1("Angle_1", float) = 0

	[HideInInspector] _Color("Color", Color) = (1.0,1.0,1.0,1.0)
	//_PlayTime("PlayTime", float) = 0
}

Category {
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha OneMinusSrcAlpha
	Cull Off Lighting Off ZWrite Off  ZTest LEqual
	BindChannels {
		Bind "Color", color
		Bind "Vertex", vertex
		Bind "TexCoord", texcoord
	}

	// ---- Fragment program cards
	SubShader {
		Pass {

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma multi_compile_particles

			#include "UnityCG.cginc"

			sampler2D _MainTex;
			sampler2D _NoiseTex;
			half _intensity;
			float _RollTimeX;
			float _RollTimeY;
			fixed4 _TintColor;
			half _opacityMapChannel;
			fixed4 _Color;

			float _RollTimeX1;
			float _RollTimeY1;

			struct appdata_t {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float2 texMain : TEXCOORD0;
				float2 texNoise : TEXCOORD1;
			};
			float4 _MainTex_ST;
			float4 _NoiseTex_ST;

			float _Angle;
			float _Angle1;
			//half _PlayTime;

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.color = v.color;
				float ag = radians(_Angle);
				float cosV = cos(ag);
				float sinV = sin(ag);
				o.texMain = v.texcoord.xy - float2(0.5f, 0.5f) + _MainTex_ST.zw;
				o.texMain = float2(cosV*o.texMain.x - sinV*o.texMain.y, sinV*o.texMain.x + cosV*o.texMain.y)/_MainTex_ST.xy + float2(0.5f,0.5f) ;

				float ag1 = radians(_Angle1);
				float cosV1 = cos(ag1);
				float sinV1 = sin(ag1);
				o.texNoise = v.texcoord.xy - float2(0.5f, 0.5f) + _NoiseTex_ST.zw;
				o.texNoise = float2(cosV1*o.texNoise.x - sinV1 * o.texNoise.y, sinV1*o.texNoise.x + cosV1 * o.texNoise.y) / _NoiseTex_ST.xy + float2(0.5f, 0.5f);
				return o;
			}
			fixed4 frag (v2f i) : COLOR
			{
				float2 uvoft = i.texMain;
				uvoft.x += _Time.x * _RollTimeX;
				uvoft.y += _Time.x * _RollTimeY;

				float2 uvoft1 = i.texNoise;
				uvoft1.x += _Time.x * _RollTimeX1;
				uvoft1.y += _Time.x * _RollTimeY1;

				fixed4 offsetColor = tex2D(_NoiseTex, uvoft1);
				fixed4 mainColor = tex2D(_MainTex, uvoft);
				fixed4 col;
				col = 2.0 * i.color * _TintColor * mainColor * _intensity;
				if (_opacityMapChannel == 0)
					col.a *= offsetColor.r;
				if (_opacityMapChannel == 1)
					col.a *= offsetColor.g;
				if (_opacityMapChannel == 2)
					col.a *= offsetColor.b;
				if (_opacityMapChannel == 3)
					col.a *= offsetColor.a;
				col = clamp(col, 0, 1);
				return col * _Color;
			}
			ENDCG
		}
	}
}
}