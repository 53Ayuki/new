Shader "Effect/RimDisslove"
{
	Properties
	{
		[Enum(ADD,1,Alpha,10)]_Dst("Dst", Float) = 10
		_MainTex("Main Texture", 2D) = "black" {}
		_RollTimeX("Roll Time X", Float) = 0.2
		_RollTimeY("Roll Time Y", Float) = 0

		_NoiseTex("Disslove Noise Texture", 2D) = "white" {}
		_RollTimeX1("Noise Roll Time X", Float) = 0.2
		_RollTimeY1("Noise Roll Time Y", Float) = 0
		

		_MaskTex("Mask Texture", 2D) = "white" {}
		_RollTimeX2("Mask Roll Time X", Float) = 0.2
		_RollTimeY2("Mask Roll Time Y", Float) = 0

		
		_RimColor("Rim Color", color) = (1.0, 0, 0, 1.0)
		_RimPower("Rim Power", Range(0.0001, 3.0)) = 1.0
		_RimIntensity("Rim Intensity", Range(0, 100.0)) = 1.0

		
		_AlphaClipOff("Alpha Clip Off",Range(0, 1)) = 0.0
	}
		SubShader
		{
			LOD 100

			Tags { "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
			Blend SrcAlpha[_Dst]
			Cull Back Lighting Off ZTest LEqual ZWrite Off

			Pass
			{
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"


				struct appdata
				{
					float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
					float3 normal : NORMAL;
				};

				struct v2f
				{
					float2 uv : TEXCOORD0;
					float2 uv1 : TEXCOORD1;
					float uv2 : TEXCOORD2;
					float4 vertex : SV_POSITION;
					float3 worldNormal : TEXCOORD3;
					float3 worldViewDir : TEXCOORD4;
				};

				sampler2D _MainTex;
				float4 _MainTex_ST;
				sampler2D _NoiseTex;
				float4 _NoiseTex_ST;
				sampler2D _MaskTex;
				float4 _MaskTex_ST;
				fixed4 _RimColor;
				fixed _RimPower;
				fixed _AlphaClipOff;
				fixed _RimIntensity;

				half _RollTimeX;
				half _RollTimeY;
				half _RollTimeX1;
				half _RollTimeY1;
				half _RollTimeX2;
				half _RollTimeY2;

				v2f vert(appdata v)
				{
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.uv = TRANSFORM_TEX(v.uv, _MainTex);
					o.uv1 = TRANSFORM_TEX(v.uv, _NoiseTex);
					o.uv2 = TRANSFORM_TEX(v.uv, _MaskTex);

					o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
					float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
					o.worldViewDir = _WorldSpaceCameraPos.xyz - worldPos;
					return o;
				}

				fixed4 frag(v2f i) : SV_Target
				{
					float2 uvoft1 = i.uv1;
					uvoft1.x += _Time.yx * _RollTimeX1;
					uvoft1.y += _Time.yx * _RollTimeY1;
					half noise = tex2D(_NoiseTex, uvoft1);

					if (noise - _AlphaClipOff < 0.001)
						discard;
								
					float2 uvoft = i.uv;
					uvoft.x += _Time.yx * _RollTimeX;
					uvoft.y += _Time.yx * _RollTimeY;

					fixed4 diffuse = tex2D(_MainTex, uvoft);

					float2 uvoft2 = i.uv2;
					uvoft2.x += _Time.yx * _RollTimeX2;
					uvoft2.y += _Time.yx * _RollTimeY2;
					half mask = tex2D(_MaskTex, uvoft2).a;

					float3 worldNormal = normalize(i.worldNormal);
					float3 worldViewDir = normalize(i.worldViewDir);

					fixed rim = pow(1 - saturate(dot(worldViewDir, worldNormal)), _RimPower);

					fixed3 rimColor = _RimColor * rim * _RimIntensity;

					fixed3 color = diffuse * rim + rimColor;
					fixed alpha = diffuse.a * _RimColor.a * rim * mask;

					return fixed4(color, alpha);
				}
				ENDCG
			}
	}

}

