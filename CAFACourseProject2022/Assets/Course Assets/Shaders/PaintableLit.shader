Shader "Neopets/PaintableLit"
{
	Properties
	{
		[NoScaleOffset]_BaseMap("BaseMap", 2D) = "white" {}
		_BaseColor("BaseColor", Color) = (1, 1, 1, 1)
		[NoScaleOffset]_MRAMap("MRAMap", 2D) = "black" {}
		_Smoothness("Smoothness", Range(0, 1)) = 0.5
		_OcclusionStrength("OcclusionStrength", Range(0, 1)) = 1
		[NoScaleOffset]_BumpMap("BumpMap", 2D) = "bump" {}
		_EmissionColor("EmissionColor", Color) = (0, 0, 0, 0)
		Vector1_f104b915aaef41b69539acbf337f0b81("EmissiveIntensity", Float) = 1
		[NoScaleOffset]_CheekMap("CheekMap", 2D) = "black" {}
		Vector4_700df69d953c4e0e8d13cc36c1e28d41("CheekTilingOffset", Vector) = (1, 0, 0, 0)
		[NoScaleOffset]_LipMap("LipMap", 2D) = "black" {}
		Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1("LipTilingOffset", Vector) = (1, 0, 0, 0)
		[NoScaleOffset]_EyeShadowMap("EyeShadowMap", 2D) = "black" {}
		Vector4_79165151a1a14973895d00e05edb1141("EyeShadowTilingOffset", Vector) = (1, 0, 0, 0)
		[NoScaleOffset]_PupilMap("PupilMap", 2D) = "black" {}
		Vector4_3c5a0575ad994c0484082879b48be7eb("PupilTilingOffset", Vector) = (1, 0, 0, 0)
		[NoScaleOffset]_MaskMap("Mask", 2D) = "black" {}
		Vector1_7bf270fe91494824b4209d2dc1faae23("PaintSmoothness", Float) = 0.7
		Vector1_0de750b9c41b4a5daef844a1599f5ac7("PaintMetallic", Float) = 0.01
		Vector1_2871f666316541908d110962eef07f02("ShapeNoiseScale", Float) = 115
		Vector1_b5cc7f6f25194a778cb438f45fbbce66("BumpNoiseScale", Float) = 25
		Vector1_8e760635099b4147956bb9600d13cac2("NormalStrength", Float) = 0.3
		[NoScaleOffset]_GlitterMap("GlitterTexture", 2D) = "white" {}
		Vector2_55edcb19ba1d459dbb3c027e66abbc1e("GlitterTiling", Vector) = (10, 10, 0, 0)
		Vector1_f6677799b193415b8be7686b658a6e85("GlitterIntensity", Float) = 10
		[HDR]Color_1bf9c5e6f5c34360a490da1c94e6a7c1("GlitterColor", Color) = (1, 1, 1, 0)
		Vector1_353a19306a364e939d35b1adffceaf21("AlphaCutoff", Range(0, 1)) = 0
		Vector1_9e8e677800b644e19c377f91787c52f4("Appear", Range(0, 1)) = 0
		[NoScaleOffset]Texture2D_f176501ab1eb4c009adb04a9e3357df5("NoiseTexture", 2D) = "black" {}
		Vector1_8198268cf31e477b821e90f882ffb838("Appear_Side", Range(0, 1)) = 0
		Color_4411c24bb9114a90bac0609a3e38417f("Appear_LIght", Color) = (0, 0, 0, 0)
		Color_3d38e1bc34e4408ca62ad21c702a4991("Appear_Color", Color) = (0, 0, 0, 0)
		Vector2_d7f0b0cac82442babeaa593fef472e04("Noise_Speed", Vector) = (0, 0, 0, 0)
		Vector1_f66b7945f53b4d85aa034d136a32a8b2("Noise_Power", Float) = 0
		[HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
		[HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
		[HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
	}
		SubShader
	{
		Tags
		{
			"RenderPipeline" = "UniversalPipeline"
			"RenderType" = "Opaque"
			"UniversalMaterialType" = "Lit"
			"Queue" = "Geometry"
		}
		Pass
		{
			Name "Universal Forward"
			Tags
			{
				"LightMode" = "UniversalForward"
			}

		// Render State
		Cull Back
	Blend One Zero
	ZTest LEqual
	ZWrite On

		// Debug
		// <None>

		// --------------------------------------------------
		// Pass

		HLSLPROGRAM

		// Pragmas
		#pragma target 4.5
	#pragma exclude_renderers gles gles3 glcore
	#pragma multi_compile_instancing
	#pragma multi_compile_fog
	#pragma multi_compile _ DOTS_INSTANCING_ON
	#pragma vertex vert
	#pragma fragment frag

		// DotsInstancingOptions: <None>
		// HybridV1InjectedBuiltinProperties: <None>

		// Keywords
		#pragma multi_compile _ _SCREEN_SPACE_OCCLUSION
	#pragma multi_compile _ LIGHTMAP_ON
	#pragma multi_compile _ DIRLIGHTMAP_COMBINED
	#pragma multi_compile _ _MAIN_LIGHT_SHADOWS
	#pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
	#pragma multi_compile _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS _ADDITIONAL_OFF
	#pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
	#pragma multi_compile _ _SHADOWS_SOFT
	#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
	#pragma multi_compile _ SHADOWS_SHADOWMASK
		// GraphKeywords: <None>

		// Defines
		#define _NORMALMAP 1
		#define _NORMAL_DROPOFF_TS 1
		#define ATTRIBUTES_NEED_NORMAL
		#define ATTRIBUTES_NEED_TANGENT
		#define ATTRIBUTES_NEED_TEXCOORD0
		#define ATTRIBUTES_NEED_TEXCOORD1
		#define VARYINGS_NEED_POSITION_WS
		#define VARYINGS_NEED_NORMAL_WS
		#define VARYINGS_NEED_TANGENT_WS
		#define VARYINGS_NEED_TEXCOORD0
		#define VARYINGS_NEED_TEXCOORD1
		#define VARYINGS_NEED_VIEWDIRECTION_WS
		#define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
		#define FEATURES_GRAPH_VERTEX
		/* WARNING: $splice Could not find named fragment 'PassInstancing' */
		#define SHADERPASS SHADERPASS_FORWARD
		/* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

		// Includes
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

		// --------------------------------------------------
		// Structs and Packing

		struct Attributes
	{
		float3 positionOS : POSITION;
		float3 normalOS : NORMAL;
		float4 tangentOS : TANGENT;
		float4 uv0 : TEXCOORD0;
		float4 uv1 : TEXCOORD1;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : INSTANCEID_SEMANTIC;
		#endif
	};
	struct Varyings
	{
		float4 positionCS : SV_POSITION;
		float3 positionWS;
		float3 normalWS;
		float4 tangentWS;
		float4 texCoord0;
		float4 texCoord1;
		float3 viewDirectionWS;
		#if defined(LIGHTMAP_ON)
		float2 lightmapUV;
		#endif
		#if !defined(LIGHTMAP_ON)
		float3 sh;
		#endif
		float4 fogFactorAndVertexLight;
		float4 shadowCoord;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};
	struct SurfaceDescriptionInputs
	{
		float3 ObjectSpaceNormal;
		float3 WorldSpaceNormal;
		float3 TangentSpaceNormal;
		float3 WorldSpaceTangent;
		float3 WorldSpaceBiTangent;
		float3 ObjectSpaceViewDirection;
		float3 WorldSpaceViewDirection;
		float3 WorldSpacePosition;
		float4 uv0;
		float4 uv1;
	};
	struct VertexDescriptionInputs
	{
		float3 ObjectSpaceNormal;
		float3 ObjectSpaceTangent;
		float3 ObjectSpacePosition;
	};
	struct PackedVaryings
	{
		float4 positionCS : SV_POSITION;
		float3 interp0 : TEXCOORD0;
		float3 interp1 : TEXCOORD1;
		float4 interp2 : TEXCOORD2;
		float4 interp3 : TEXCOORD3;
		float4 interp4 : TEXCOORD4;
		float3 interp5 : TEXCOORD5;
		#if defined(LIGHTMAP_ON)
		float2 interp6 : TEXCOORD6;
		#endif
		#if !defined(LIGHTMAP_ON)
		float3 interp7 : TEXCOORD7;
		#endif
		float4 interp8 : TEXCOORD8;
		float4 interp9 : TEXCOORD9;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};

		PackedVaryings PackVaryings(Varyings input)
	{
		PackedVaryings output;
		output.positionCS = input.positionCS;
		output.interp0.xyz = input.positionWS;
		output.interp1.xyz = input.normalWS;
		output.interp2.xyzw = input.tangentWS;
		output.interp3.xyzw = input.texCoord0;
		output.interp4.xyzw = input.texCoord1;
		output.interp5.xyz = input.viewDirectionWS;
		#if defined(LIGHTMAP_ON)
		output.interp6.xy = input.lightmapUV;
		#endif
		#if !defined(LIGHTMAP_ON)
		output.interp7.xyz = input.sh;
		#endif
		output.interp8.xyzw = input.fogFactorAndVertexLight;
		output.interp9.xyzw = input.shadowCoord;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}
	Varyings UnpackVaryings(PackedVaryings input)
	{
		Varyings output;
		output.positionCS = input.positionCS;
		output.positionWS = input.interp0.xyz;
		output.normalWS = input.interp1.xyz;
		output.tangentWS = input.interp2.xyzw;
		output.texCoord0 = input.interp3.xyzw;
		output.texCoord1 = input.interp4.xyzw;
		output.viewDirectionWS = input.interp5.xyz;
		#if defined(LIGHTMAP_ON)
		output.lightmapUV = input.interp6.xy;
		#endif
		#if !defined(LIGHTMAP_ON)
		output.sh = input.interp7.xyz;
		#endif
		output.fogFactorAndVertexLight = input.interp8.xyzw;
		output.shadowCoord = input.interp9.xyzw;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}

	// --------------------------------------------------
	// Graph

	// Graph Properties
	CBUFFER_START(UnityPerMaterial)
float4 _BaseMap_TexelSize;
float4 _BaseColor;
float4 _MRAMap_TexelSize;
float _Smoothness;
float _OcclusionStrength;
float4 _BumpMap_TexelSize;
float4 _EmissionColor;
float Vector1_f104b915aaef41b69539acbf337f0b81;
float4 _CheekMap_TexelSize;
float4 Vector4_700df69d953c4e0e8d13cc36c1e28d41;
float4 _LipMap_TexelSize;
float4 Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1;
float4 _EyeShadowMap_TexelSize;
float4 Vector4_79165151a1a14973895d00e05edb1141;
float4 _PupilMap_TexelSize;
float4 Vector4_3c5a0575ad994c0484082879b48be7eb;
float4 _MaskMap_TexelSize;
float Vector1_7bf270fe91494824b4209d2dc1faae23;
float Vector1_0de750b9c41b4a5daef844a1599f5ac7;
float Vector1_2871f666316541908d110962eef07f02;
float Vector1_b5cc7f6f25194a778cb438f45fbbce66;
float Vector1_8e760635099b4147956bb9600d13cac2;
float4 _GlitterMap_TexelSize;
float2 Vector2_55edcb19ba1d459dbb3c027e66abbc1e;
float Vector1_f6677799b193415b8be7686b658a6e85;
float4 Color_1bf9c5e6f5c34360a490da1c94e6a7c1;
float Vector1_353a19306a364e939d35b1adffceaf21;
float Vector1_9e8e677800b644e19c377f91787c52f4;
float4 Texture2D_f176501ab1eb4c009adb04a9e3357df5_TexelSize;
float Vector1_8198268cf31e477b821e90f882ffb838;
float4 Color_4411c24bb9114a90bac0609a3e38417f;
float4 Color_3d38e1bc34e4408ca62ad21c702a4991;
float2 Vector2_d7f0b0cac82442babeaa593fef472e04;
float Vector1_f66b7945f53b4d85aa034d136a32a8b2;
CBUFFER_END

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_BaseMap);
SAMPLER(sampler_BaseMap);
TEXTURE2D(_MRAMap);
SAMPLER(sampler_MRAMap);
TEXTURE2D(_BumpMap);
SAMPLER(sampler_BumpMap);
TEXTURE2D(_CheekMap);
SAMPLER(sampler_CheekMap);
TEXTURE2D(_LipMap);
SAMPLER(sampler_LipMap);
TEXTURE2D(_EyeShadowMap);
SAMPLER(sampler_EyeShadowMap);
TEXTURE2D(_PupilMap);
SAMPLER(sampler_PupilMap);
TEXTURE2D(_MaskMap);
SAMPLER(sampler_MaskMap);
TEXTURE2D(_GlitterMap);
SAMPLER(sampler_GlitterMap);
TEXTURE2D(Texture2D_f176501ab1eb4c009adb04a9e3357df5);
SAMPLER(samplerTexture2D_f176501ab1eb4c009adb04a9e3357df5);

// Graph Functions

void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
{
	Out = A * B;
}

void Unity_Add_float(float A, float B, out float Out)
{
	Out = A + B;
}

void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
{
	RGBA = float4(R, G, B, A);
	RGB = float3(R, G, B);
	RG = float2(R, G);
}

void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
{
	Out = lerp(A, B, T);
}

void Unity_OneMinus_float(float In, out float Out)
{
	Out = 1 - In;
}


float2 Unity_GradientNoise_Dir_float(float2 p)
{
	// Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
	p = p % 289;
	// need full precision, otherwise half overflows when p > 1
	float x = float(34 * p.x + 1) * p.x % 289 + p.y;
	x = (34 * x + 1) * x % 289;
	x = frac(x / 41) * 2 - 1;
	return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
}

void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
{
	float2 p = UV * Scale;
	float2 ip = floor(p);
	float2 fp = frac(p);
	float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
	float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
	float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
	float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
	fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
	Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
}

void Unity_Multiply_float(float A, float B, out float Out)
{
	Out = A * B;
}

void Unity_Step_float(float Edge, float In, out float Out)
{
	Out = step(Edge, In);
}

void Unity_NormalUnpack_float(float4 In, out float3 Out)
{
				Out = UnpackNormal(In);
			}

void Unity_Lerp_float(float A, float B, float T, out float Out)
{
	Out = lerp(A, B, T);
}

void Unity_NormalFromHeight_Tangent_float(float In, float Strength, float3 Position, float3x3 TangentMatrix, out float3 Out)
{
	float3 worldDerivativeX = ddx(Position);
	float3 worldDerivativeY = ddy(Position);

	float3 crossX = cross(TangentMatrix[2].xyz, worldDerivativeX);
	float3 crossY = cross(worldDerivativeY, TangentMatrix[2].xyz);
	float d = dot(worldDerivativeX, crossY);
	float sgn = d < 0.0 ? (-1.0f) : 1.0f;
	float surface = sgn / max(0.000000000000001192093f, abs(d));

	float dHdx = ddx(In);
	float dHdy = ddy(In);
	float3 surfGrad = surface * (dHdx*crossY + dHdy * crossX);
	Out = SafeNormalize(TangentMatrix[2].xyz - (Strength * surfGrad));
	Out = TransformWorldToTangent(Out, TangentMatrix);
}

void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
{
	Out = lerp(A, B, T);
}

void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
{
	Out = UV * Tiling + Offset;
}

void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
{
	Out = A - B;
}

void Unity_Normalize_float3(float3 In, out float3 Out)
{
	Out = normalize(In);
}

void Unity_Add_float3(float3 A, float3 B, out float3 Out)
{
	Out = A + B;
}

void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
{
	Out = dot(A, B);
}

void Unity_Saturate_float(float In, out float Out)
{
	Out = saturate(In);
}

void Unity_Exponential2_float(float In, out float Out)
{
	Out = exp2(In);
}

void Unity_Power_float(float A, float B, out float Out)
{
	Out = pow(A, B);
}

void Unity_Add_float4(float4 A, float4 B, out float4 Out)
{
	Out = A + B;
}

void Unity_Subtract_float(float A, float B, out float Out)
{
	Out = A - B;
}

// Graph Vertex
struct VertexDescription
{
	float3 Position;
	float3 Normal;
	float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
	VertexDescription description = (VertexDescription)0;
	description.Position = IN.ObjectSpacePosition;
	description.Normal = IN.ObjectSpaceNormal;
	description.Tangent = IN.ObjectSpaceTangent;
	return description;
}

// Graph Pixel
struct SurfaceDescription
{
	float3 BaseColor;
	float3 NormalTS;
	float3 Emission;
	float Metallic;
	float Smoothness;
	float Occlusion;
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
	SurfaceDescription surface = (SurfaceDescription)0;
	UnityTexture2D _Property_46f41194bebd49dd90523a9187559d47_Out_0 = UnityBuildTexture2DStructNoScale(_BaseMap);
	float4 _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0 = SAMPLE_TEXTURE2D(_Property_46f41194bebd49dd90523a9187559d47_Out_0.tex, _Property_46f41194bebd49dd90523a9187559d47_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_R_4 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.r;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_G_5 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.g;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_B_6 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.b;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_A_7 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.a;
	float4 _Property_3cc81970230a4e2680f1056abe28f14c_Out_0 = _BaseColor;
	float4 _Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2;
	Unity_Multiply_float(_SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0, _Property_3cc81970230a4e2680f1056abe28f14c_Out_0, _Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2);
	UnityTexture2D _Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0 = UnityBuildTexture2DStructNoScale(_CheekMap);
	float4 _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0 = Vector4_700df69d953c4e0e8d13cc36c1e28d41;
	float _Split_5022297589804f21900b69c657b81fa0_R_1 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[0];
	float _Split_5022297589804f21900b69c657b81fa0_G_2 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[1];
	float _Split_5022297589804f21900b69c657b81fa0_B_3 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[2];
	float _Split_5022297589804f21900b69c657b81fa0_A_4 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[3];
	float4 _UV_5c27d34f7fe0493fa46cacf01b32cccc_Out_0 = IN.uv1;
	float4 _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2;
	Unity_Multiply_float((_Split_5022297589804f21900b69c657b81fa0_R_1.xxxx), _UV_5c27d34f7fe0493fa46cacf01b32cccc_Out_0, _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2);
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_R_1 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[0];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_G_2 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[1];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_B_3 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[2];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_A_4 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[3];
	float _Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2;
	Unity_Add_float(_Split_5022297589804f21900b69c657b81fa0_G_2, _Split_f75341ed066d43c2ba64dd1807c3cdd5_R_1, _Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2);
	float _Add_b8d09a71819044be96521761cc153267_Out_2;
	Unity_Add_float(_Split_f75341ed066d43c2ba64dd1807c3cdd5_G_2, _Split_5022297589804f21900b69c657b81fa0_B_3, _Add_b8d09a71819044be96521761cc153267_Out_2);
	float4 _Combine_0939f9cc49e54d3ea511e937525deee6_RGBA_4;
	float3 _Combine_0939f9cc49e54d3ea511e937525deee6_RGB_5;
	float2 _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6;
	Unity_Combine_float(_Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2, _Add_b8d09a71819044be96521761cc153267_Out_2, 0, 0, _Combine_0939f9cc49e54d3ea511e937525deee6_RGBA_4, _Combine_0939f9cc49e54d3ea511e937525deee6_RGB_5, _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6);
	float4 _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0 = SAMPLE_TEXTURE2D(_Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0.tex, _Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0.samplerstate, _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6);
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_R_4 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.r;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_G_5 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.g;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_B_6 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.b;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_A_7 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.a;
	float4 _Lerp_2241ae8feb5941da9183bb461c252132_Out_3;
	Unity_Lerp_float4(_Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2, _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0, (_SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_A_7.xxxx), _Lerp_2241ae8feb5941da9183bb461c252132_Out_3);
	UnityTexture2D _Property_5f8a386b21984e2988fde7598f635a9a_Out_0 = UnityBuildTexture2DStructNoScale(_LipMap);
	float4 _Property_c857b47c21154b86a27f46398299df91_Out_0 = Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1;
	float _Split_f308ae64287f48e8872c952e6828cb36_R_1 = _Property_c857b47c21154b86a27f46398299df91_Out_0[0];
	float _Split_f308ae64287f48e8872c952e6828cb36_G_2 = _Property_c857b47c21154b86a27f46398299df91_Out_0[1];
	float _Split_f308ae64287f48e8872c952e6828cb36_B_3 = _Property_c857b47c21154b86a27f46398299df91_Out_0[2];
	float _Split_f308ae64287f48e8872c952e6828cb36_A_4 = _Property_c857b47c21154b86a27f46398299df91_Out_0[3];
	float4 _UV_c1af69e74f4e4df791b33b8f07716d5b_Out_0 = IN.uv1;
	float4 _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2;
	Unity_Multiply_float((_Split_f308ae64287f48e8872c952e6828cb36_R_1.xxxx), _UV_c1af69e74f4e4df791b33b8f07716d5b_Out_0, _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2);
	float _Split_3123c7f71f9749b2aa01689ddefb9374_R_1 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[0];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_G_2 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[1];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_B_3 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[2];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_A_4 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[3];
	float _Add_f2f7dee5f2844fb8822bccad48406ade_Out_2;
	Unity_Add_float(_Split_f308ae64287f48e8872c952e6828cb36_G_2, _Split_3123c7f71f9749b2aa01689ddefb9374_R_1, _Add_f2f7dee5f2844fb8822bccad48406ade_Out_2);
	float _Add_5287d7b9aac546af90e5e834b37567d2_Out_2;
	Unity_Add_float(_Split_3123c7f71f9749b2aa01689ddefb9374_G_2, _Split_f308ae64287f48e8872c952e6828cb36_B_3, _Add_5287d7b9aac546af90e5e834b37567d2_Out_2);
	float4 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGBA_4;
	float3 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGB_5;
	float2 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6;
	Unity_Combine_float(_Add_f2f7dee5f2844fb8822bccad48406ade_Out_2, _Add_5287d7b9aac546af90e5e834b37567d2_Out_2, 0, 0, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGBA_4, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGB_5, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6);
	float4 _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_5f8a386b21984e2988fde7598f635a9a_Out_0.tex, _Property_5f8a386b21984e2988fde7598f635a9a_Out_0.samplerstate, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6);
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_R_4 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.r;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_G_5 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.g;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_B_6 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.b;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_A_7 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.a;
	float4 _Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3;
	Unity_Lerp_float4(_Lerp_2241ae8feb5941da9183bb461c252132_Out_3, _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0, (_SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_A_7.xxxx), _Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3);
	UnityTexture2D _Property_034f7053a4c04630b179945137478563_Out_0 = UnityBuildTexture2DStructNoScale(_EyeShadowMap);
	float4 _Property_ec0501c48b2f47fca24e4415b083a817_Out_0 = Vector4_79165151a1a14973895d00e05edb1141;
	float _Split_a65775607697471ebf0abd88cba1cc94_R_1 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[0];
	float _Split_a65775607697471ebf0abd88cba1cc94_G_2 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[1];
	float _Split_a65775607697471ebf0abd88cba1cc94_B_3 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[2];
	float _Split_a65775607697471ebf0abd88cba1cc94_A_4 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[3];
	float4 _UV_561d401f6e7242d99119d7be74ed408f_Out_0 = IN.uv1;
	float4 _Multiply_9434dd79d3204d6f97de52affd770331_Out_2;
	Unity_Multiply_float((_Split_a65775607697471ebf0abd88cba1cc94_R_1.xxxx), _UV_561d401f6e7242d99119d7be74ed408f_Out_0, _Multiply_9434dd79d3204d6f97de52affd770331_Out_2);
	float _Split_48b01121140e4699b1b0d4a54f925206_R_1 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[0];
	float _Split_48b01121140e4699b1b0d4a54f925206_G_2 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[1];
	float _Split_48b01121140e4699b1b0d4a54f925206_B_3 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[2];
	float _Split_48b01121140e4699b1b0d4a54f925206_A_4 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[3];
	float _Add_70cfb275974e4ed78884eb9ddb51407c_Out_2;
	Unity_Add_float(_Split_a65775607697471ebf0abd88cba1cc94_G_2, _Split_48b01121140e4699b1b0d4a54f925206_R_1, _Add_70cfb275974e4ed78884eb9ddb51407c_Out_2);
	float _Add_bf85759250cd46a5a834e59e8174d47f_Out_2;
	Unity_Add_float(_Split_48b01121140e4699b1b0d4a54f925206_G_2, _Split_a65775607697471ebf0abd88cba1cc94_B_3, _Add_bf85759250cd46a5a834e59e8174d47f_Out_2);
	float4 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGBA_4;
	float3 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGB_5;
	float2 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6;
	Unity_Combine_float(_Add_70cfb275974e4ed78884eb9ddb51407c_Out_2, _Add_bf85759250cd46a5a834e59e8174d47f_Out_2, 0, 0, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGBA_4, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGB_5, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6);
	float4 _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0 = SAMPLE_TEXTURE2D(_Property_034f7053a4c04630b179945137478563_Out_0.tex, _Property_034f7053a4c04630b179945137478563_Out_0.samplerstate, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6);
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_R_4 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.r;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_G_5 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.g;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_B_6 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.b;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_A_7 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.a;
	float4 _Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3;
	Unity_Lerp_float4(_Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3, _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0, (_SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_A_7.xxxx), _Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3);
	UnityTexture2D _Property_f0ad144d6d604946a0265c0ff45af34a_Out_0 = UnityBuildTexture2DStructNoScale(_PupilMap);
	float4 _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0 = Vector4_3c5a0575ad994c0484082879b48be7eb;
	float _Split_597b0aa14ac147bb8547d10058ea208e_R_1 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[0];
	float _Split_597b0aa14ac147bb8547d10058ea208e_G_2 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[1];
	float _Split_597b0aa14ac147bb8547d10058ea208e_B_3 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[2];
	float _Split_597b0aa14ac147bb8547d10058ea208e_A_4 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[3];
	float4 _UV_fa01ab9e6ed045c0932df0bd20747d29_Out_0 = IN.uv1;
	float4 _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2;
	Unity_Multiply_float((_Split_597b0aa14ac147bb8547d10058ea208e_R_1.xxxx), _UV_fa01ab9e6ed045c0932df0bd20747d29_Out_0, _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2);
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_R_1 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[0];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_G_2 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[1];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_B_3 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[2];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_A_4 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[3];
	float _Add_8655d6d32b1b40259250182a69e8b8b7_Out_2;
	Unity_Add_float(_Split_597b0aa14ac147bb8547d10058ea208e_G_2, _Split_6051d27c6349400fbb5a5932d8d2c7ad_R_1, _Add_8655d6d32b1b40259250182a69e8b8b7_Out_2);
	float _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2;
	Unity_Add_float(_Split_6051d27c6349400fbb5a5932d8d2c7ad_G_2, _Split_597b0aa14ac147bb8547d10058ea208e_B_3, _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2);
	float4 _Combine_3c3cf19616e143188639a90935b8a10b_RGBA_4;
	float3 _Combine_3c3cf19616e143188639a90935b8a10b_RGB_5;
	float2 _Combine_3c3cf19616e143188639a90935b8a10b_RG_6;
	Unity_Combine_float(_Add_8655d6d32b1b40259250182a69e8b8b7_Out_2, _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2, 0, 0, _Combine_3c3cf19616e143188639a90935b8a10b_RGBA_4, _Combine_3c3cf19616e143188639a90935b8a10b_RGB_5, _Combine_3c3cf19616e143188639a90935b8a10b_RG_6);
	float4 _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0 = SAMPLE_TEXTURE2D(_Property_f0ad144d6d604946a0265c0ff45af34a_Out_0.tex, _Property_f0ad144d6d604946a0265c0ff45af34a_Out_0.samplerstate, _Combine_3c3cf19616e143188639a90935b8a10b_RG_6);
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_R_4 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.r;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_G_5 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.g;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_B_6 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.b;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_A_7 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.a;
	float4 _Lerp_9134832094eb464f874ea325fccb805d_Out_3;
	Unity_Lerp_float4(_Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3, _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0, (_SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_A_7.xxxx), _Lerp_9134832094eb464f874ea325fccb805d_Out_3);
	UnityTexture2D _Property_33d05c2bee3a48cbad54c88a071627d0_Out_0 = UnityBuildTexture2DStructNoScale(_MaskMap);
	float4 _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0 = SAMPLE_TEXTURE2D(_Property_33d05c2bee3a48cbad54c88a071627d0_Out_0.tex, _Property_33d05c2bee3a48cbad54c88a071627d0_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_R_4 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.r;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_G_5 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.g;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_B_6 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.b;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_A_7 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.a;
	UnityTexture2D _Property_90c3e617459146b89270ca735ff67027_Out_0 = UnityBuildTexture2DStructNoScale(_MaskMap);
	float4 _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0 = SAMPLE_TEXTURE2D(_Property_90c3e617459146b89270ca735ff67027_Out_0.tex, _Property_90c3e617459146b89270ca735ff67027_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_R_4 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.r;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_G_5 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.g;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_B_6 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.b;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.a;
	float _OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1;
	Unity_OneMinus_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1);
	float _Property_1a86dcb475f34e9c8bb3d74526142f51_Out_0 = Vector1_2871f666316541908d110962eef07f02;
	float _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2;
	Unity_GradientNoise_float(IN.uv0.xy, _Property_1a86dcb475f34e9c8bb3d74526142f51_Out_0, _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2);
	float _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2;
	Unity_Multiply_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2, _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2);
	float _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2;
	Unity_Add_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2, _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2);
	float _Step_d74a28341b3b47d2b929db9c36d76662_Out_2;
	Unity_Step_float(_OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1, _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2, _Step_d74a28341b3b47d2b929db9c36d76662_Out_2);
	float4 _Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3;
	Unity_Lerp_float4(_Lerp_9134832094eb464f874ea325fccb805d_Out_3, _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0, (_Step_d74a28341b3b47d2b929db9c36d76662_Out_2.xxxx), _Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3);
	UnityTexture2D _Property_ef39b7e1c5c6465f842c5dfa050e47e1_Out_0 = UnityBuildTexture2DStructNoScale(_BumpMap);
	float4 _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0 = SAMPLE_TEXTURE2D(_Property_ef39b7e1c5c6465f842c5dfa050e47e1_Out_0.tex, _Property_ef39b7e1c5c6465f842c5dfa050e47e1_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_R_4 = _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0.r;
	float _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_G_5 = _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0.g;
	float _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_B_6 = _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0.b;
	float _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_A_7 = _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0.a;
	float3 _NormalUnpack_b1e6ba1d5cc34fc6bed28052e3d03168_Out_1;
	Unity_NormalUnpack_float(_SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0, _NormalUnpack_b1e6ba1d5cc34fc6bed28052e3d03168_Out_1);
	float _Property_7671b3b7eef84a8c9d7825a9036c8bff_Out_0 = Vector1_b5cc7f6f25194a778cb438f45fbbce66;
	float _GradientNoise_4be9f93cabe14a849abe7b8ed37b6bbd_Out_2;
	Unity_GradientNoise_float(IN.uv0.xy, _Property_7671b3b7eef84a8c9d7825a9036c8bff_Out_0, _GradientNoise_4be9f93cabe14a849abe7b8ed37b6bbd_Out_2);
	float _Add_3e0bbf4ee4904868940bafe39dd7423f_Out_2;
	Unity_Add_float(_GradientNoise_4be9f93cabe14a849abe7b8ed37b6bbd_Out_2, 0.3, _Add_3e0bbf4ee4904868940bafe39dd7423f_Out_2);
	float _Multiply_2e36cc2586dc491abb678f1f1cf3d350_Out_2;
	Unity_Multiply_float(_GradientNoise_4be9f93cabe14a849abe7b8ed37b6bbd_Out_2, _SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _Multiply_2e36cc2586dc491abb678f1f1cf3d350_Out_2);
	float _Lerp_c862be95f9354a0ab4024a518282ec79_Out_3;
	Unity_Lerp_float(0.3, _Add_3e0bbf4ee4904868940bafe39dd7423f_Out_2, _Multiply_2e36cc2586dc491abb678f1f1cf3d350_Out_2, _Lerp_c862be95f9354a0ab4024a518282ec79_Out_3);
	float _Property_6721bad2e28e4210a1fa01a48f73c858_Out_0 = Vector1_8e760635099b4147956bb9600d13cac2;
	float3 _NormalFromHeight_392055ed45084230899320a5058871be_Out_1;
	float3x3 _NormalFromHeight_392055ed45084230899320a5058871be_TangentMatrix = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
	float3 _NormalFromHeight_392055ed45084230899320a5058871be_Position = IN.WorldSpacePosition;
	Unity_NormalFromHeight_Tangent_float(_Lerp_c862be95f9354a0ab4024a518282ec79_Out_3,_Property_6721bad2e28e4210a1fa01a48f73c858_Out_0,_NormalFromHeight_392055ed45084230899320a5058871be_Position,_NormalFromHeight_392055ed45084230899320a5058871be_TangentMatrix, _NormalFromHeight_392055ed45084230899320a5058871be_Out_1);
	float3 _Lerp_cfff89d8630c4d3b975d173579abd871_Out_3;
	Unity_Lerp_float3(_NormalUnpack_b1e6ba1d5cc34fc6bed28052e3d03168_Out_1, _NormalFromHeight_392055ed45084230899320a5058871be_Out_1, (_Step_d74a28341b3b47d2b929db9c36d76662_Out_2.xxx), _Lerp_cfff89d8630c4d3b975d173579abd871_Out_3);
	UnityTexture2D _Property_9e2e155797564e99b75bfe8d3f7be32d_Out_0 = UnityBuildTexture2DStructNoScale(_MRAMap);
	float4 _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0 = SAMPLE_TEXTURE2D(_Property_9e2e155797564e99b75bfe8d3f7be32d_Out_0.tex, _Property_9e2e155797564e99b75bfe8d3f7be32d_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_R_4 = _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0.r;
	float _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_G_5 = _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0.g;
	float _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_B_6 = _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0.b;
	float _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_A_7 = _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0.a;
	float4 _Property_b6f5177f3ae44d2cb157e753cff0343c_Out_0 = _EmissionColor;
	float4 _Multiply_8c3b33adad4c4e69a14a0843a37bf4d0_Out_2;
	Unity_Multiply_float((_SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_A_7.xxxx), _Property_b6f5177f3ae44d2cb157e753cff0343c_Out_0, _Multiply_8c3b33adad4c4e69a14a0843a37bf4d0_Out_2);
	float _Property_80e0e6200a1642e1884a71644e4682bf_Out_0 = Vector1_f104b915aaef41b69539acbf337f0b81;
	float4 _Multiply_f86d698f353e49b8ac4e704412805883_Out_2;
	Unity_Multiply_float(_Multiply_8c3b33adad4c4e69a14a0843a37bf4d0_Out_2, (_Property_80e0e6200a1642e1884a71644e4682bf_Out_0.xxxx), _Multiply_f86d698f353e49b8ac4e704412805883_Out_2);
	UnityTexture2D _Property_fe9310b7c4f2436d8e27d43b3fe188aa_Out_0 = UnityBuildTexture2DStructNoScale(_GlitterMap);
	float2 _Property_2032db54a42245aaa9312efadd4f15e3_Out_0 = Vector2_55edcb19ba1d459dbb3c027e66abbc1e;
	float2 _TilingAndOffset_721ed8d53fd54eef98ca2df1ba7cfdf5_Out_3;
	Unity_TilingAndOffset_float(IN.uv0.xy, _Property_2032db54a42245aaa9312efadd4f15e3_Out_0, float2 (0, 0), _TilingAndOffset_721ed8d53fd54eef98ca2df1ba7cfdf5_Out_3);
	float4 _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_fe9310b7c4f2436d8e27d43b3fe188aa_Out_0.tex, UnityBuildSamplerStateStruct(SamplerState_Point_Repeat).samplerstate, _TilingAndOffset_721ed8d53fd54eef98ca2df1ba7cfdf5_Out_3);
	float _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_R_4 = _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0.r;
	float _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_G_5 = _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0.g;
	float _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_B_6 = _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0.b;
	float _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_A_7 = _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0.a;
	float3 _Vector3_ed002c12350a46b69f196e5d728582cd_Out_0 = float3(_SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_R_4, _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_G_5, _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_B_6);
	float3 _Subtract_3a4ad3383c6f43b4825e534b6fcefded_Out_2;
	Unity_Subtract_float3(_Vector3_ed002c12350a46b69f196e5d728582cd_Out_0, float3(0.5, 0.5, 0.5), _Subtract_3a4ad3383c6f43b4825e534b6fcefded_Out_2);
	float3 _Normalize_956cacc929084d28952105a8c1bcea48_Out_1;
	Unity_Normalize_float3(_Subtract_3a4ad3383c6f43b4825e534b6fcefded_Out_2, _Normalize_956cacc929084d28952105a8c1bcea48_Out_1);
	float3 _Add_8543d53668cc40b5a1bc702cfb07701b_Out_2;
	Unity_Add_float3(_Normalize_956cacc929084d28952105a8c1bcea48_Out_1, IN.ObjectSpaceNormal, _Add_8543d53668cc40b5a1bc702cfb07701b_Out_2);
	float3 _Normalize_472c4ae9e2c94183aeab11d54efdf6e9_Out_1;
	Unity_Normalize_float3(_Add_8543d53668cc40b5a1bc702cfb07701b_Out_2, _Normalize_472c4ae9e2c94183aeab11d54efdf6e9_Out_1);
	float _DotProduct_ed89b1c6e5fa4f83ba62172883d90a01_Out_2;
	Unity_DotProduct_float3(_Normalize_472c4ae9e2c94183aeab11d54efdf6e9_Out_1, IN.ObjectSpaceViewDirection, _DotProduct_ed89b1c6e5fa4f83ba62172883d90a01_Out_2);
	float _Saturate_9dc8013924fd4863b579da0965a6c1e2_Out_1;
	Unity_Saturate_float(_DotProduct_ed89b1c6e5fa4f83ba62172883d90a01_Out_2, _Saturate_9dc8013924fd4863b579da0965a6c1e2_Out_1);
	float _Property_410af66ac63f4b6ca91752d4e6c8c4b1_Out_0 = Vector1_f6677799b193415b8be7686b658a6e85;
	float _Add_225974d87fe74eed99d56fbe9aea1572_Out_2;
	Unity_Add_float(_Property_410af66ac63f4b6ca91752d4e6c8c4b1_Out_0, 1, _Add_225974d87fe74eed99d56fbe9aea1572_Out_2);
	float _Exponential_8ae78e15f67946618ffb2645de1f1589_Out_1;
	Unity_Exponential2_float(_Add_225974d87fe74eed99d56fbe9aea1572_Out_2, _Exponential_8ae78e15f67946618ffb2645de1f1589_Out_1);
	float _Power_3eee35aa9ed846d7a8ccf6fe2caa881f_Out_2;
	Unity_Power_float(_Saturate_9dc8013924fd4863b579da0965a6c1e2_Out_1, _Exponential_8ae78e15f67946618ffb2645de1f1589_Out_1, _Power_3eee35aa9ed846d7a8ccf6fe2caa881f_Out_2);
	float4 _Property_c551a4d6fd90454c8320eac950ac91da_Out_0 = IsGammaSpace() ? LinearToSRGB(Color_1bf9c5e6f5c34360a490da1c94e6a7c1) : Color_1bf9c5e6f5c34360a490da1c94e6a7c1;
	float4 _Multiply_7499b43960a14a42bdb8aafd89235b59_Out_2;
	Unity_Multiply_float((_Power_3eee35aa9ed846d7a8ccf6fe2caa881f_Out_2.xxxx), _Property_c551a4d6fd90454c8320eac950ac91da_Out_0, _Multiply_7499b43960a14a42bdb8aafd89235b59_Out_2);
	float4 _Lerp_e45407912adb4284a451fec5b49c8abc_Out_3;
	Unity_Lerp_float4(_Multiply_f86d698f353e49b8ac4e704412805883_Out_2, _Multiply_7499b43960a14a42bdb8aafd89235b59_Out_2, (_Step_d74a28341b3b47d2b929db9c36d76662_Out_2.xxxx), _Lerp_e45407912adb4284a451fec5b49c8abc_Out_3);
	float4 _Add_7daf6aeef3334209844501eb66f273d6_Out_2;
	Unity_Add_float4(float4(0, 0, 0, 0), _Lerp_e45407912adb4284a451fec5b49c8abc_Out_3, _Add_7daf6aeef3334209844501eb66f273d6_Out_2);
	float _Property_a50a3f7883c643f3ab2704942ad380db_Out_0 = Vector1_0de750b9c41b4a5daef844a1599f5ac7;
	float _Lerp_c9309f6c8a3444369988184556880232_Out_3;
	Unity_Lerp_float(_SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_R_4, _Property_a50a3f7883c643f3ab2704942ad380db_Out_0, _Step_d74a28341b3b47d2b929db9c36d76662_Out_2, _Lerp_c9309f6c8a3444369988184556880232_Out_3);
	float _Property_c368716654714d7eb4e5d93e94d992ce_Out_0 = _Smoothness;
	float _Multiply_9e88f987c3944d87a5f9197876696d2b_Out_2;
	Unity_Multiply_float(_SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_G_5, _Property_c368716654714d7eb4e5d93e94d992ce_Out_0, _Multiply_9e88f987c3944d87a5f9197876696d2b_Out_2);
	float _Property_a7dee795de614222ba4e4569b151c9e8_Out_0 = Vector1_7bf270fe91494824b4209d2dc1faae23;
	float _Lerp_f176bf104e364901a15faca7f74a33fd_Out_3;
	Unity_Lerp_float(_Multiply_9e88f987c3944d87a5f9197876696d2b_Out_2, _Property_a7dee795de614222ba4e4569b151c9e8_Out_0, _Step_d74a28341b3b47d2b929db9c36d76662_Out_2, _Lerp_f176bf104e364901a15faca7f74a33fd_Out_3);
	float _Property_b349e081a1f74f9cae70aff3922ba018_Out_0 = _OcclusionStrength;
	float _Subtract_a72bdf3527a4494ea66bc1773ad1a7da_Out_2;
	Unity_Subtract_float(1, _Property_b349e081a1f74f9cae70aff3922ba018_Out_0, _Subtract_a72bdf3527a4494ea66bc1773ad1a7da_Out_2);
	float _Multiply_3a3ed483ad5d435cb751ace06d019def_Out_2;
	Unity_Multiply_float(_Property_b349e081a1f74f9cae70aff3922ba018_Out_0, _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_B_6, _Multiply_3a3ed483ad5d435cb751ace06d019def_Out_2);
	float _Add_78b726c350d14be58e392670cc9a8503_Out_2;
	Unity_Add_float(_Subtract_a72bdf3527a4494ea66bc1773ad1a7da_Out_2, _Multiply_3a3ed483ad5d435cb751ace06d019def_Out_2, _Add_78b726c350d14be58e392670cc9a8503_Out_2);
	surface.BaseColor = (_Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3.xyz);
	surface.NormalTS = _Lerp_cfff89d8630c4d3b975d173579abd871_Out_3;
	surface.Emission = (_Add_7daf6aeef3334209844501eb66f273d6_Out_2.xyz);
	surface.Metallic = _Lerp_c9309f6c8a3444369988184556880232_Out_3;
	surface.Smoothness = _Lerp_f176bf104e364901a15faca7f74a33fd_Out_3;
	surface.Occlusion = _Add_78b726c350d14be58e392670cc9a8503_Out_2;
	return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
	VertexDescriptionInputs output;
	ZERO_INITIALIZE(VertexDescriptionInputs, output);

	output.ObjectSpaceNormal = input.normalOS;
	output.ObjectSpaceTangent = input.tangentOS.xyz;
	output.ObjectSpacePosition = input.positionOS;

	return output;
}
	SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
	SurfaceDescriptionInputs output;
	ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
	float3 unnormalizedNormalWS = input.normalWS;
	const float renormFactor = 1.0 / length(unnormalizedNormalWS);

	// use bitangent on the fly like in hdrp
	// IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
	float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
	float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);

	output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
	output.ObjectSpaceNormal = normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
	output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);

	// to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
	// This is explained in section 2.2 in "surface gradient based bump mapping framework"
	output.WorldSpaceTangent = renormFactor * input.tangentWS.xyz;
	output.WorldSpaceBiTangent = renormFactor * bitang;

	output.WorldSpaceViewDirection = input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
	output.ObjectSpaceViewDirection = TransformWorldToObjectDir(output.WorldSpaceViewDirection);
	output.WorldSpacePosition = input.positionWS;
	output.uv0 = input.texCoord0;
	output.uv1 = input.texCoord1;
#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

	return output;
}

	// --------------------------------------------------
	// Main

	#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"

	ENDHLSL
}
Pass
{
	Name "GBuffer"
	Tags
	{
		"LightMode" = "UniversalGBuffer"
	}

		// Render State
		Cull Back
	Blend One Zero
	ZTest LEqual
	ZWrite On

		// Debug
		// <None>

		// --------------------------------------------------
		// Pass

		HLSLPROGRAM

		// Pragmas
		#pragma target 4.5
	#pragma exclude_renderers gles gles3 glcore
	#pragma multi_compile_instancing
	#pragma multi_compile_fog
	#pragma multi_compile _ DOTS_INSTANCING_ON
	#pragma vertex vert
	#pragma fragment frag

		// DotsInstancingOptions: <None>
		// HybridV1InjectedBuiltinProperties: <None>

		// Keywords
		#pragma multi_compile _ LIGHTMAP_ON
	#pragma multi_compile _ DIRLIGHTMAP_COMBINED
	#pragma multi_compile _ _MAIN_LIGHT_SHADOWS
	#pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
	#pragma multi_compile _ _SHADOWS_SOFT
	#pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
	#pragma multi_compile _ _GBUFFER_NORMALS_OCT
		// GraphKeywords: <None>

		// Defines
		#define _NORMALMAP 1
		#define _NORMAL_DROPOFF_TS 1
		#define ATTRIBUTES_NEED_NORMAL
		#define ATTRIBUTES_NEED_TANGENT
		#define ATTRIBUTES_NEED_TEXCOORD0
		#define ATTRIBUTES_NEED_TEXCOORD1
		#define VARYINGS_NEED_POSITION_WS
		#define VARYINGS_NEED_NORMAL_WS
		#define VARYINGS_NEED_TANGENT_WS
		#define VARYINGS_NEED_TEXCOORD0
		#define VARYINGS_NEED_TEXCOORD1
		#define VARYINGS_NEED_VIEWDIRECTION_WS
		#define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
		#define FEATURES_GRAPH_VERTEX
		/* WARNING: $splice Could not find named fragment 'PassInstancing' */
		#define SHADERPASS SHADERPASS_GBUFFER
		/* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

		// Includes
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

		// --------------------------------------------------
		// Structs and Packing

		struct Attributes
	{
		float3 positionOS : POSITION;
		float3 normalOS : NORMAL;
		float4 tangentOS : TANGENT;
		float4 uv0 : TEXCOORD0;
		float4 uv1 : TEXCOORD1;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : INSTANCEID_SEMANTIC;
		#endif
	};
	struct Varyings
	{
		float4 positionCS : SV_POSITION;
		float3 positionWS;
		float3 normalWS;
		float4 tangentWS;
		float4 texCoord0;
		float4 texCoord1;
		float3 viewDirectionWS;
		#if defined(LIGHTMAP_ON)
		float2 lightmapUV;
		#endif
		#if !defined(LIGHTMAP_ON)
		float3 sh;
		#endif
		float4 fogFactorAndVertexLight;
		float4 shadowCoord;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};
	struct SurfaceDescriptionInputs
	{
		float3 ObjectSpaceNormal;
		float3 WorldSpaceNormal;
		float3 TangentSpaceNormal;
		float3 WorldSpaceTangent;
		float3 WorldSpaceBiTangent;
		float3 ObjectSpaceViewDirection;
		float3 WorldSpaceViewDirection;
		float3 WorldSpacePosition;
		float4 uv0;
		float4 uv1;
	};
	struct VertexDescriptionInputs
	{
		float3 ObjectSpaceNormal;
		float3 ObjectSpaceTangent;
		float3 ObjectSpacePosition;
	};
	struct PackedVaryings
	{
		float4 positionCS : SV_POSITION;
		float3 interp0 : TEXCOORD0;
		float3 interp1 : TEXCOORD1;
		float4 interp2 : TEXCOORD2;
		float4 interp3 : TEXCOORD3;
		float4 interp4 : TEXCOORD4;
		float3 interp5 : TEXCOORD5;
		#if defined(LIGHTMAP_ON)
		float2 interp6 : TEXCOORD6;
		#endif
		#if !defined(LIGHTMAP_ON)
		float3 interp7 : TEXCOORD7;
		#endif
		float4 interp8 : TEXCOORD8;
		float4 interp9 : TEXCOORD9;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};

		PackedVaryings PackVaryings(Varyings input)
	{
		PackedVaryings output;
		output.positionCS = input.positionCS;
		output.interp0.xyz = input.positionWS;
		output.interp1.xyz = input.normalWS;
		output.interp2.xyzw = input.tangentWS;
		output.interp3.xyzw = input.texCoord0;
		output.interp4.xyzw = input.texCoord1;
		output.interp5.xyz = input.viewDirectionWS;
		#if defined(LIGHTMAP_ON)
		output.interp6.xy = input.lightmapUV;
		#endif
		#if !defined(LIGHTMAP_ON)
		output.interp7.xyz = input.sh;
		#endif
		output.interp8.xyzw = input.fogFactorAndVertexLight;
		output.interp9.xyzw = input.shadowCoord;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}
	Varyings UnpackVaryings(PackedVaryings input)
	{
		Varyings output;
		output.positionCS = input.positionCS;
		output.positionWS = input.interp0.xyz;
		output.normalWS = input.interp1.xyz;
		output.tangentWS = input.interp2.xyzw;
		output.texCoord0 = input.interp3.xyzw;
		output.texCoord1 = input.interp4.xyzw;
		output.viewDirectionWS = input.interp5.xyz;
		#if defined(LIGHTMAP_ON)
		output.lightmapUV = input.interp6.xy;
		#endif
		#if !defined(LIGHTMAP_ON)
		output.sh = input.interp7.xyz;
		#endif
		output.fogFactorAndVertexLight = input.interp8.xyzw;
		output.shadowCoord = input.interp9.xyzw;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}

	// --------------------------------------------------
	// Graph

	// Graph Properties
	CBUFFER_START(UnityPerMaterial)
float4 _BaseMap_TexelSize;
float4 _BaseColor;
float4 _MRAMap_TexelSize;
float _Smoothness;
float _OcclusionStrength;
float4 _BumpMap_TexelSize;
float4 _EmissionColor;
float Vector1_f104b915aaef41b69539acbf337f0b81;
float4 _CheekMap_TexelSize;
float4 Vector4_700df69d953c4e0e8d13cc36c1e28d41;
float4 _LipMap_TexelSize;
float4 Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1;
float4 _EyeShadowMap_TexelSize;
float4 Vector4_79165151a1a14973895d00e05edb1141;
float4 _PupilMap_TexelSize;
float4 Vector4_3c5a0575ad994c0484082879b48be7eb;
float4 _MaskMap_TexelSize;
float Vector1_7bf270fe91494824b4209d2dc1faae23;
float Vector1_0de750b9c41b4a5daef844a1599f5ac7;
float Vector1_2871f666316541908d110962eef07f02;
float Vector1_b5cc7f6f25194a778cb438f45fbbce66;
float Vector1_8e760635099b4147956bb9600d13cac2;
float4 _GlitterMap_TexelSize;
float2 Vector2_55edcb19ba1d459dbb3c027e66abbc1e;
float Vector1_f6677799b193415b8be7686b658a6e85;
float4 Color_1bf9c5e6f5c34360a490da1c94e6a7c1;
float Vector1_353a19306a364e939d35b1adffceaf21;
float Vector1_9e8e677800b644e19c377f91787c52f4;
float4 Texture2D_f176501ab1eb4c009adb04a9e3357df5_TexelSize;
float Vector1_8198268cf31e477b821e90f882ffb838;
float4 Color_4411c24bb9114a90bac0609a3e38417f;
float4 Color_3d38e1bc34e4408ca62ad21c702a4991;
float2 Vector2_d7f0b0cac82442babeaa593fef472e04;
float Vector1_f66b7945f53b4d85aa034d136a32a8b2;
CBUFFER_END

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_BaseMap);
SAMPLER(sampler_BaseMap);
TEXTURE2D(_MRAMap);
SAMPLER(sampler_MRAMap);
TEXTURE2D(_BumpMap);
SAMPLER(sampler_BumpMap);
TEXTURE2D(_CheekMap);
SAMPLER(sampler_CheekMap);
TEXTURE2D(_LipMap);
SAMPLER(sampler_LipMap);
TEXTURE2D(_EyeShadowMap);
SAMPLER(sampler_EyeShadowMap);
TEXTURE2D(_PupilMap);
SAMPLER(sampler_PupilMap);
TEXTURE2D(_MaskMap);
SAMPLER(sampler_MaskMap);
TEXTURE2D(_GlitterMap);
SAMPLER(sampler_GlitterMap);
TEXTURE2D(Texture2D_f176501ab1eb4c009adb04a9e3357df5);
SAMPLER(samplerTexture2D_f176501ab1eb4c009adb04a9e3357df5);

// Graph Functions

void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
{
	Out = A * B;
}

void Unity_Add_float(float A, float B, out float Out)
{
	Out = A + B;
}

void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
{
	RGBA = float4(R, G, B, A);
	RGB = float3(R, G, B);
	RG = float2(R, G);
}

void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
{
	Out = lerp(A, B, T);
}

void Unity_OneMinus_float(float In, out float Out)
{
	Out = 1 - In;
}


float2 Unity_GradientNoise_Dir_float(float2 p)
{
	// Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
	p = p % 289;
	// need full precision, otherwise half overflows when p > 1
	float x = float(34 * p.x + 1) * p.x % 289 + p.y;
	x = (34 * x + 1) * x % 289;
	x = frac(x / 41) * 2 - 1;
	return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
}

void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
{
	float2 p = UV * Scale;
	float2 ip = floor(p);
	float2 fp = frac(p);
	float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
	float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
	float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
	float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
	fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
	Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
}

void Unity_Multiply_float(float A, float B, out float Out)
{
	Out = A * B;
}

void Unity_Step_float(float Edge, float In, out float Out)
{
	Out = step(Edge, In);
}

void Unity_NormalUnpack_float(float4 In, out float3 Out)
{
				Out = UnpackNormal(In);
			}

void Unity_Lerp_float(float A, float B, float T, out float Out)
{
	Out = lerp(A, B, T);
}

void Unity_NormalFromHeight_Tangent_float(float In, float Strength, float3 Position, float3x3 TangentMatrix, out float3 Out)
{
	float3 worldDerivativeX = ddx(Position);
	float3 worldDerivativeY = ddy(Position);

	float3 crossX = cross(TangentMatrix[2].xyz, worldDerivativeX);
	float3 crossY = cross(worldDerivativeY, TangentMatrix[2].xyz);
	float d = dot(worldDerivativeX, crossY);
	float sgn = d < 0.0 ? (-1.0f) : 1.0f;
	float surface = sgn / max(0.000000000000001192093f, abs(d));

	float dHdx = ddx(In);
	float dHdy = ddy(In);
	float3 surfGrad = surface * (dHdx*crossY + dHdy * crossX);
	Out = SafeNormalize(TangentMatrix[2].xyz - (Strength * surfGrad));
	Out = TransformWorldToTangent(Out, TangentMatrix);
}

void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
{
	Out = lerp(A, B, T);
}

void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
{
	Out = UV * Tiling + Offset;
}

void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
{
	Out = A - B;
}

void Unity_Normalize_float3(float3 In, out float3 Out)
{
	Out = normalize(In);
}

void Unity_Add_float3(float3 A, float3 B, out float3 Out)
{
	Out = A + B;
}

void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
{
	Out = dot(A, B);
}

void Unity_Saturate_float(float In, out float Out)
{
	Out = saturate(In);
}

void Unity_Exponential2_float(float In, out float Out)
{
	Out = exp2(In);
}

void Unity_Power_float(float A, float B, out float Out)
{
	Out = pow(A, B);
}

void Unity_Add_float4(float4 A, float4 B, out float4 Out)
{
	Out = A + B;
}

void Unity_Subtract_float(float A, float B, out float Out)
{
	Out = A - B;
}

// Graph Vertex
struct VertexDescription
{
	float3 Position;
	float3 Normal;
	float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
	VertexDescription description = (VertexDescription)0;
	description.Position = IN.ObjectSpacePosition;
	description.Normal = IN.ObjectSpaceNormal;
	description.Tangent = IN.ObjectSpaceTangent;
	return description;
}

// Graph Pixel
struct SurfaceDescription
{
	float3 BaseColor;
	float3 NormalTS;
	float3 Emission;
	float Metallic;
	float Smoothness;
	float Occlusion;
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
	SurfaceDescription surface = (SurfaceDescription)0;
	UnityTexture2D _Property_46f41194bebd49dd90523a9187559d47_Out_0 = UnityBuildTexture2DStructNoScale(_BaseMap);
	float4 _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0 = SAMPLE_TEXTURE2D(_Property_46f41194bebd49dd90523a9187559d47_Out_0.tex, _Property_46f41194bebd49dd90523a9187559d47_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_R_4 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.r;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_G_5 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.g;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_B_6 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.b;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_A_7 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.a;
	float4 _Property_3cc81970230a4e2680f1056abe28f14c_Out_0 = _BaseColor;
	float4 _Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2;
	Unity_Multiply_float(_SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0, _Property_3cc81970230a4e2680f1056abe28f14c_Out_0, _Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2);
	UnityTexture2D _Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0 = UnityBuildTexture2DStructNoScale(_CheekMap);
	float4 _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0 = Vector4_700df69d953c4e0e8d13cc36c1e28d41;
	float _Split_5022297589804f21900b69c657b81fa0_R_1 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[0];
	float _Split_5022297589804f21900b69c657b81fa0_G_2 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[1];
	float _Split_5022297589804f21900b69c657b81fa0_B_3 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[2];
	float _Split_5022297589804f21900b69c657b81fa0_A_4 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[3];
	float4 _UV_5c27d34f7fe0493fa46cacf01b32cccc_Out_0 = IN.uv1;
	float4 _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2;
	Unity_Multiply_float((_Split_5022297589804f21900b69c657b81fa0_R_1.xxxx), _UV_5c27d34f7fe0493fa46cacf01b32cccc_Out_0, _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2);
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_R_1 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[0];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_G_2 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[1];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_B_3 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[2];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_A_4 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[3];
	float _Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2;
	Unity_Add_float(_Split_5022297589804f21900b69c657b81fa0_G_2, _Split_f75341ed066d43c2ba64dd1807c3cdd5_R_1, _Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2);
	float _Add_b8d09a71819044be96521761cc153267_Out_2;
	Unity_Add_float(_Split_f75341ed066d43c2ba64dd1807c3cdd5_G_2, _Split_5022297589804f21900b69c657b81fa0_B_3, _Add_b8d09a71819044be96521761cc153267_Out_2);
	float4 _Combine_0939f9cc49e54d3ea511e937525deee6_RGBA_4;
	float3 _Combine_0939f9cc49e54d3ea511e937525deee6_RGB_5;
	float2 _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6;
	Unity_Combine_float(_Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2, _Add_b8d09a71819044be96521761cc153267_Out_2, 0, 0, _Combine_0939f9cc49e54d3ea511e937525deee6_RGBA_4, _Combine_0939f9cc49e54d3ea511e937525deee6_RGB_5, _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6);
	float4 _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0 = SAMPLE_TEXTURE2D(_Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0.tex, _Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0.samplerstate, _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6);
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_R_4 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.r;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_G_5 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.g;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_B_6 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.b;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_A_7 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.a;
	float4 _Lerp_2241ae8feb5941da9183bb461c252132_Out_3;
	Unity_Lerp_float4(_Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2, _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0, (_SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_A_7.xxxx), _Lerp_2241ae8feb5941da9183bb461c252132_Out_3);
	UnityTexture2D _Property_5f8a386b21984e2988fde7598f635a9a_Out_0 = UnityBuildTexture2DStructNoScale(_LipMap);
	float4 _Property_c857b47c21154b86a27f46398299df91_Out_0 = Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1;
	float _Split_f308ae64287f48e8872c952e6828cb36_R_1 = _Property_c857b47c21154b86a27f46398299df91_Out_0[0];
	float _Split_f308ae64287f48e8872c952e6828cb36_G_2 = _Property_c857b47c21154b86a27f46398299df91_Out_0[1];
	float _Split_f308ae64287f48e8872c952e6828cb36_B_3 = _Property_c857b47c21154b86a27f46398299df91_Out_0[2];
	float _Split_f308ae64287f48e8872c952e6828cb36_A_4 = _Property_c857b47c21154b86a27f46398299df91_Out_0[3];
	float4 _UV_c1af69e74f4e4df791b33b8f07716d5b_Out_0 = IN.uv1;
	float4 _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2;
	Unity_Multiply_float((_Split_f308ae64287f48e8872c952e6828cb36_R_1.xxxx), _UV_c1af69e74f4e4df791b33b8f07716d5b_Out_0, _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2);
	float _Split_3123c7f71f9749b2aa01689ddefb9374_R_1 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[0];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_G_2 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[1];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_B_3 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[2];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_A_4 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[3];
	float _Add_f2f7dee5f2844fb8822bccad48406ade_Out_2;
	Unity_Add_float(_Split_f308ae64287f48e8872c952e6828cb36_G_2, _Split_3123c7f71f9749b2aa01689ddefb9374_R_1, _Add_f2f7dee5f2844fb8822bccad48406ade_Out_2);
	float _Add_5287d7b9aac546af90e5e834b37567d2_Out_2;
	Unity_Add_float(_Split_3123c7f71f9749b2aa01689ddefb9374_G_2, _Split_f308ae64287f48e8872c952e6828cb36_B_3, _Add_5287d7b9aac546af90e5e834b37567d2_Out_2);
	float4 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGBA_4;
	float3 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGB_5;
	float2 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6;
	Unity_Combine_float(_Add_f2f7dee5f2844fb8822bccad48406ade_Out_2, _Add_5287d7b9aac546af90e5e834b37567d2_Out_2, 0, 0, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGBA_4, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGB_5, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6);
	float4 _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_5f8a386b21984e2988fde7598f635a9a_Out_0.tex, _Property_5f8a386b21984e2988fde7598f635a9a_Out_0.samplerstate, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6);
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_R_4 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.r;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_G_5 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.g;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_B_6 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.b;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_A_7 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.a;
	float4 _Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3;
	Unity_Lerp_float4(_Lerp_2241ae8feb5941da9183bb461c252132_Out_3, _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0, (_SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_A_7.xxxx), _Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3);
	UnityTexture2D _Property_034f7053a4c04630b179945137478563_Out_0 = UnityBuildTexture2DStructNoScale(_EyeShadowMap);
	float4 _Property_ec0501c48b2f47fca24e4415b083a817_Out_0 = Vector4_79165151a1a14973895d00e05edb1141;
	float _Split_a65775607697471ebf0abd88cba1cc94_R_1 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[0];
	float _Split_a65775607697471ebf0abd88cba1cc94_G_2 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[1];
	float _Split_a65775607697471ebf0abd88cba1cc94_B_3 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[2];
	float _Split_a65775607697471ebf0abd88cba1cc94_A_4 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[3];
	float4 _UV_561d401f6e7242d99119d7be74ed408f_Out_0 = IN.uv1;
	float4 _Multiply_9434dd79d3204d6f97de52affd770331_Out_2;
	Unity_Multiply_float((_Split_a65775607697471ebf0abd88cba1cc94_R_1.xxxx), _UV_561d401f6e7242d99119d7be74ed408f_Out_0, _Multiply_9434dd79d3204d6f97de52affd770331_Out_2);
	float _Split_48b01121140e4699b1b0d4a54f925206_R_1 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[0];
	float _Split_48b01121140e4699b1b0d4a54f925206_G_2 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[1];
	float _Split_48b01121140e4699b1b0d4a54f925206_B_3 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[2];
	float _Split_48b01121140e4699b1b0d4a54f925206_A_4 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[3];
	float _Add_70cfb275974e4ed78884eb9ddb51407c_Out_2;
	Unity_Add_float(_Split_a65775607697471ebf0abd88cba1cc94_G_2, _Split_48b01121140e4699b1b0d4a54f925206_R_1, _Add_70cfb275974e4ed78884eb9ddb51407c_Out_2);
	float _Add_bf85759250cd46a5a834e59e8174d47f_Out_2;
	Unity_Add_float(_Split_48b01121140e4699b1b0d4a54f925206_G_2, _Split_a65775607697471ebf0abd88cba1cc94_B_3, _Add_bf85759250cd46a5a834e59e8174d47f_Out_2);
	float4 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGBA_4;
	float3 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGB_5;
	float2 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6;
	Unity_Combine_float(_Add_70cfb275974e4ed78884eb9ddb51407c_Out_2, _Add_bf85759250cd46a5a834e59e8174d47f_Out_2, 0, 0, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGBA_4, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGB_5, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6);
	float4 _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0 = SAMPLE_TEXTURE2D(_Property_034f7053a4c04630b179945137478563_Out_0.tex, _Property_034f7053a4c04630b179945137478563_Out_0.samplerstate, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6);
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_R_4 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.r;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_G_5 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.g;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_B_6 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.b;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_A_7 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.a;
	float4 _Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3;
	Unity_Lerp_float4(_Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3, _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0, (_SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_A_7.xxxx), _Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3);
	UnityTexture2D _Property_f0ad144d6d604946a0265c0ff45af34a_Out_0 = UnityBuildTexture2DStructNoScale(_PupilMap);
	float4 _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0 = Vector4_3c5a0575ad994c0484082879b48be7eb;
	float _Split_597b0aa14ac147bb8547d10058ea208e_R_1 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[0];
	float _Split_597b0aa14ac147bb8547d10058ea208e_G_2 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[1];
	float _Split_597b0aa14ac147bb8547d10058ea208e_B_3 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[2];
	float _Split_597b0aa14ac147bb8547d10058ea208e_A_4 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[3];
	float4 _UV_fa01ab9e6ed045c0932df0bd20747d29_Out_0 = IN.uv1;
	float4 _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2;
	Unity_Multiply_float((_Split_597b0aa14ac147bb8547d10058ea208e_R_1.xxxx), _UV_fa01ab9e6ed045c0932df0bd20747d29_Out_0, _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2);
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_R_1 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[0];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_G_2 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[1];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_B_3 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[2];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_A_4 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[3];
	float _Add_8655d6d32b1b40259250182a69e8b8b7_Out_2;
	Unity_Add_float(_Split_597b0aa14ac147bb8547d10058ea208e_G_2, _Split_6051d27c6349400fbb5a5932d8d2c7ad_R_1, _Add_8655d6d32b1b40259250182a69e8b8b7_Out_2);
	float _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2;
	Unity_Add_float(_Split_6051d27c6349400fbb5a5932d8d2c7ad_G_2, _Split_597b0aa14ac147bb8547d10058ea208e_B_3, _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2);
	float4 _Combine_3c3cf19616e143188639a90935b8a10b_RGBA_4;
	float3 _Combine_3c3cf19616e143188639a90935b8a10b_RGB_5;
	float2 _Combine_3c3cf19616e143188639a90935b8a10b_RG_6;
	Unity_Combine_float(_Add_8655d6d32b1b40259250182a69e8b8b7_Out_2, _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2, 0, 0, _Combine_3c3cf19616e143188639a90935b8a10b_RGBA_4, _Combine_3c3cf19616e143188639a90935b8a10b_RGB_5, _Combine_3c3cf19616e143188639a90935b8a10b_RG_6);
	float4 _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0 = SAMPLE_TEXTURE2D(_Property_f0ad144d6d604946a0265c0ff45af34a_Out_0.tex, _Property_f0ad144d6d604946a0265c0ff45af34a_Out_0.samplerstate, _Combine_3c3cf19616e143188639a90935b8a10b_RG_6);
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_R_4 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.r;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_G_5 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.g;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_B_6 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.b;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_A_7 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.a;
	float4 _Lerp_9134832094eb464f874ea325fccb805d_Out_3;
	Unity_Lerp_float4(_Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3, _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0, (_SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_A_7.xxxx), _Lerp_9134832094eb464f874ea325fccb805d_Out_3);
	UnityTexture2D _Property_33d05c2bee3a48cbad54c88a071627d0_Out_0 = UnityBuildTexture2DStructNoScale(_MaskMap);
	float4 _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0 = SAMPLE_TEXTURE2D(_Property_33d05c2bee3a48cbad54c88a071627d0_Out_0.tex, _Property_33d05c2bee3a48cbad54c88a071627d0_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_R_4 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.r;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_G_5 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.g;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_B_6 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.b;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_A_7 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.a;
	UnityTexture2D _Property_90c3e617459146b89270ca735ff67027_Out_0 = UnityBuildTexture2DStructNoScale(_MaskMap);
	float4 _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0 = SAMPLE_TEXTURE2D(_Property_90c3e617459146b89270ca735ff67027_Out_0.tex, _Property_90c3e617459146b89270ca735ff67027_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_R_4 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.r;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_G_5 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.g;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_B_6 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.b;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.a;
	float _OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1;
	Unity_OneMinus_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1);
	float _Property_1a86dcb475f34e9c8bb3d74526142f51_Out_0 = Vector1_2871f666316541908d110962eef07f02;
	float _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2;
	Unity_GradientNoise_float(IN.uv0.xy, _Property_1a86dcb475f34e9c8bb3d74526142f51_Out_0, _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2);
	float _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2;
	Unity_Multiply_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2, _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2);
	float _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2;
	Unity_Add_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2, _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2);
	float _Step_d74a28341b3b47d2b929db9c36d76662_Out_2;
	Unity_Step_float(_OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1, _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2, _Step_d74a28341b3b47d2b929db9c36d76662_Out_2);
	float4 _Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3;
	Unity_Lerp_float4(_Lerp_9134832094eb464f874ea325fccb805d_Out_3, _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0, (_Step_d74a28341b3b47d2b929db9c36d76662_Out_2.xxxx), _Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3);
	UnityTexture2D _Property_ef39b7e1c5c6465f842c5dfa050e47e1_Out_0 = UnityBuildTexture2DStructNoScale(_BumpMap);
	float4 _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0 = SAMPLE_TEXTURE2D(_Property_ef39b7e1c5c6465f842c5dfa050e47e1_Out_0.tex, _Property_ef39b7e1c5c6465f842c5dfa050e47e1_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_R_4 = _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0.r;
	float _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_G_5 = _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0.g;
	float _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_B_6 = _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0.b;
	float _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_A_7 = _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0.a;
	float3 _NormalUnpack_b1e6ba1d5cc34fc6bed28052e3d03168_Out_1;
	Unity_NormalUnpack_float(_SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0, _NormalUnpack_b1e6ba1d5cc34fc6bed28052e3d03168_Out_1);
	float _Property_7671b3b7eef84a8c9d7825a9036c8bff_Out_0 = Vector1_b5cc7f6f25194a778cb438f45fbbce66;
	float _GradientNoise_4be9f93cabe14a849abe7b8ed37b6bbd_Out_2;
	Unity_GradientNoise_float(IN.uv0.xy, _Property_7671b3b7eef84a8c9d7825a9036c8bff_Out_0, _GradientNoise_4be9f93cabe14a849abe7b8ed37b6bbd_Out_2);
	float _Add_3e0bbf4ee4904868940bafe39dd7423f_Out_2;
	Unity_Add_float(_GradientNoise_4be9f93cabe14a849abe7b8ed37b6bbd_Out_2, 0.3, _Add_3e0bbf4ee4904868940bafe39dd7423f_Out_2);
	float _Multiply_2e36cc2586dc491abb678f1f1cf3d350_Out_2;
	Unity_Multiply_float(_GradientNoise_4be9f93cabe14a849abe7b8ed37b6bbd_Out_2, _SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _Multiply_2e36cc2586dc491abb678f1f1cf3d350_Out_2);
	float _Lerp_c862be95f9354a0ab4024a518282ec79_Out_3;
	Unity_Lerp_float(0.3, _Add_3e0bbf4ee4904868940bafe39dd7423f_Out_2, _Multiply_2e36cc2586dc491abb678f1f1cf3d350_Out_2, _Lerp_c862be95f9354a0ab4024a518282ec79_Out_3);
	float _Property_6721bad2e28e4210a1fa01a48f73c858_Out_0 = Vector1_8e760635099b4147956bb9600d13cac2;
	float3 _NormalFromHeight_392055ed45084230899320a5058871be_Out_1;
	float3x3 _NormalFromHeight_392055ed45084230899320a5058871be_TangentMatrix = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
	float3 _NormalFromHeight_392055ed45084230899320a5058871be_Position = IN.WorldSpacePosition;
	Unity_NormalFromHeight_Tangent_float(_Lerp_c862be95f9354a0ab4024a518282ec79_Out_3,_Property_6721bad2e28e4210a1fa01a48f73c858_Out_0,_NormalFromHeight_392055ed45084230899320a5058871be_Position,_NormalFromHeight_392055ed45084230899320a5058871be_TangentMatrix, _NormalFromHeight_392055ed45084230899320a5058871be_Out_1);
	float3 _Lerp_cfff89d8630c4d3b975d173579abd871_Out_3;
	Unity_Lerp_float3(_NormalUnpack_b1e6ba1d5cc34fc6bed28052e3d03168_Out_1, _NormalFromHeight_392055ed45084230899320a5058871be_Out_1, (_Step_d74a28341b3b47d2b929db9c36d76662_Out_2.xxx), _Lerp_cfff89d8630c4d3b975d173579abd871_Out_3);
	UnityTexture2D _Property_9e2e155797564e99b75bfe8d3f7be32d_Out_0 = UnityBuildTexture2DStructNoScale(_MRAMap);
	float4 _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0 = SAMPLE_TEXTURE2D(_Property_9e2e155797564e99b75bfe8d3f7be32d_Out_0.tex, _Property_9e2e155797564e99b75bfe8d3f7be32d_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_R_4 = _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0.r;
	float _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_G_5 = _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0.g;
	float _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_B_6 = _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0.b;
	float _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_A_7 = _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0.a;
	float4 _Property_b6f5177f3ae44d2cb157e753cff0343c_Out_0 = _EmissionColor;
	float4 _Multiply_8c3b33adad4c4e69a14a0843a37bf4d0_Out_2;
	Unity_Multiply_float((_SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_A_7.xxxx), _Property_b6f5177f3ae44d2cb157e753cff0343c_Out_0, _Multiply_8c3b33adad4c4e69a14a0843a37bf4d0_Out_2);
	float _Property_80e0e6200a1642e1884a71644e4682bf_Out_0 = Vector1_f104b915aaef41b69539acbf337f0b81;
	float4 _Multiply_f86d698f353e49b8ac4e704412805883_Out_2;
	Unity_Multiply_float(_Multiply_8c3b33adad4c4e69a14a0843a37bf4d0_Out_2, (_Property_80e0e6200a1642e1884a71644e4682bf_Out_0.xxxx), _Multiply_f86d698f353e49b8ac4e704412805883_Out_2);
	UnityTexture2D _Property_fe9310b7c4f2436d8e27d43b3fe188aa_Out_0 = UnityBuildTexture2DStructNoScale(_GlitterMap);
	float2 _Property_2032db54a42245aaa9312efadd4f15e3_Out_0 = Vector2_55edcb19ba1d459dbb3c027e66abbc1e;
	float2 _TilingAndOffset_721ed8d53fd54eef98ca2df1ba7cfdf5_Out_3;
	Unity_TilingAndOffset_float(IN.uv0.xy, _Property_2032db54a42245aaa9312efadd4f15e3_Out_0, float2 (0, 0), _TilingAndOffset_721ed8d53fd54eef98ca2df1ba7cfdf5_Out_3);
	float4 _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_fe9310b7c4f2436d8e27d43b3fe188aa_Out_0.tex, UnityBuildSamplerStateStruct(SamplerState_Point_Repeat).samplerstate, _TilingAndOffset_721ed8d53fd54eef98ca2df1ba7cfdf5_Out_3);
	float _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_R_4 = _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0.r;
	float _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_G_5 = _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0.g;
	float _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_B_6 = _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0.b;
	float _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_A_7 = _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0.a;
	float3 _Vector3_ed002c12350a46b69f196e5d728582cd_Out_0 = float3(_SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_R_4, _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_G_5, _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_B_6);
	float3 _Subtract_3a4ad3383c6f43b4825e534b6fcefded_Out_2;
	Unity_Subtract_float3(_Vector3_ed002c12350a46b69f196e5d728582cd_Out_0, float3(0.5, 0.5, 0.5), _Subtract_3a4ad3383c6f43b4825e534b6fcefded_Out_2);
	float3 _Normalize_956cacc929084d28952105a8c1bcea48_Out_1;
	Unity_Normalize_float3(_Subtract_3a4ad3383c6f43b4825e534b6fcefded_Out_2, _Normalize_956cacc929084d28952105a8c1bcea48_Out_1);
	float3 _Add_8543d53668cc40b5a1bc702cfb07701b_Out_2;
	Unity_Add_float3(_Normalize_956cacc929084d28952105a8c1bcea48_Out_1, IN.ObjectSpaceNormal, _Add_8543d53668cc40b5a1bc702cfb07701b_Out_2);
	float3 _Normalize_472c4ae9e2c94183aeab11d54efdf6e9_Out_1;
	Unity_Normalize_float3(_Add_8543d53668cc40b5a1bc702cfb07701b_Out_2, _Normalize_472c4ae9e2c94183aeab11d54efdf6e9_Out_1);
	float _DotProduct_ed89b1c6e5fa4f83ba62172883d90a01_Out_2;
	Unity_DotProduct_float3(_Normalize_472c4ae9e2c94183aeab11d54efdf6e9_Out_1, IN.ObjectSpaceViewDirection, _DotProduct_ed89b1c6e5fa4f83ba62172883d90a01_Out_2);
	float _Saturate_9dc8013924fd4863b579da0965a6c1e2_Out_1;
	Unity_Saturate_float(_DotProduct_ed89b1c6e5fa4f83ba62172883d90a01_Out_2, _Saturate_9dc8013924fd4863b579da0965a6c1e2_Out_1);
	float _Property_410af66ac63f4b6ca91752d4e6c8c4b1_Out_0 = Vector1_f6677799b193415b8be7686b658a6e85;
	float _Add_225974d87fe74eed99d56fbe9aea1572_Out_2;
	Unity_Add_float(_Property_410af66ac63f4b6ca91752d4e6c8c4b1_Out_0, 1, _Add_225974d87fe74eed99d56fbe9aea1572_Out_2);
	float _Exponential_8ae78e15f67946618ffb2645de1f1589_Out_1;
	Unity_Exponential2_float(_Add_225974d87fe74eed99d56fbe9aea1572_Out_2, _Exponential_8ae78e15f67946618ffb2645de1f1589_Out_1);
	float _Power_3eee35aa9ed846d7a8ccf6fe2caa881f_Out_2;
	Unity_Power_float(_Saturate_9dc8013924fd4863b579da0965a6c1e2_Out_1, _Exponential_8ae78e15f67946618ffb2645de1f1589_Out_1, _Power_3eee35aa9ed846d7a8ccf6fe2caa881f_Out_2);
	float4 _Property_c551a4d6fd90454c8320eac950ac91da_Out_0 = IsGammaSpace() ? LinearToSRGB(Color_1bf9c5e6f5c34360a490da1c94e6a7c1) : Color_1bf9c5e6f5c34360a490da1c94e6a7c1;
	float4 _Multiply_7499b43960a14a42bdb8aafd89235b59_Out_2;
	Unity_Multiply_float((_Power_3eee35aa9ed846d7a8ccf6fe2caa881f_Out_2.xxxx), _Property_c551a4d6fd90454c8320eac950ac91da_Out_0, _Multiply_7499b43960a14a42bdb8aafd89235b59_Out_2);
	float4 _Lerp_e45407912adb4284a451fec5b49c8abc_Out_3;
	Unity_Lerp_float4(_Multiply_f86d698f353e49b8ac4e704412805883_Out_2, _Multiply_7499b43960a14a42bdb8aafd89235b59_Out_2, (_Step_d74a28341b3b47d2b929db9c36d76662_Out_2.xxxx), _Lerp_e45407912adb4284a451fec5b49c8abc_Out_3);
	float4 _Add_7daf6aeef3334209844501eb66f273d6_Out_2;
	Unity_Add_float4(float4(0, 0, 0, 0), _Lerp_e45407912adb4284a451fec5b49c8abc_Out_3, _Add_7daf6aeef3334209844501eb66f273d6_Out_2);
	float _Property_a50a3f7883c643f3ab2704942ad380db_Out_0 = Vector1_0de750b9c41b4a5daef844a1599f5ac7;
	float _Lerp_c9309f6c8a3444369988184556880232_Out_3;
	Unity_Lerp_float(_SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_R_4, _Property_a50a3f7883c643f3ab2704942ad380db_Out_0, _Step_d74a28341b3b47d2b929db9c36d76662_Out_2, _Lerp_c9309f6c8a3444369988184556880232_Out_3);
	float _Property_c368716654714d7eb4e5d93e94d992ce_Out_0 = _Smoothness;
	float _Multiply_9e88f987c3944d87a5f9197876696d2b_Out_2;
	Unity_Multiply_float(_SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_G_5, _Property_c368716654714d7eb4e5d93e94d992ce_Out_0, _Multiply_9e88f987c3944d87a5f9197876696d2b_Out_2);
	float _Property_a7dee795de614222ba4e4569b151c9e8_Out_0 = Vector1_7bf270fe91494824b4209d2dc1faae23;
	float _Lerp_f176bf104e364901a15faca7f74a33fd_Out_3;
	Unity_Lerp_float(_Multiply_9e88f987c3944d87a5f9197876696d2b_Out_2, _Property_a7dee795de614222ba4e4569b151c9e8_Out_0, _Step_d74a28341b3b47d2b929db9c36d76662_Out_2, _Lerp_f176bf104e364901a15faca7f74a33fd_Out_3);
	float _Property_b349e081a1f74f9cae70aff3922ba018_Out_0 = _OcclusionStrength;
	float _Subtract_a72bdf3527a4494ea66bc1773ad1a7da_Out_2;
	Unity_Subtract_float(1, _Property_b349e081a1f74f9cae70aff3922ba018_Out_0, _Subtract_a72bdf3527a4494ea66bc1773ad1a7da_Out_2);
	float _Multiply_3a3ed483ad5d435cb751ace06d019def_Out_2;
	Unity_Multiply_float(_Property_b349e081a1f74f9cae70aff3922ba018_Out_0, _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_B_6, _Multiply_3a3ed483ad5d435cb751ace06d019def_Out_2);
	float _Add_78b726c350d14be58e392670cc9a8503_Out_2;
	Unity_Add_float(_Subtract_a72bdf3527a4494ea66bc1773ad1a7da_Out_2, _Multiply_3a3ed483ad5d435cb751ace06d019def_Out_2, _Add_78b726c350d14be58e392670cc9a8503_Out_2);
	surface.BaseColor = (_Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3.xyz);
	surface.NormalTS = _Lerp_cfff89d8630c4d3b975d173579abd871_Out_3;
	surface.Emission = (_Add_7daf6aeef3334209844501eb66f273d6_Out_2.xyz);
	surface.Metallic = _Lerp_c9309f6c8a3444369988184556880232_Out_3;
	surface.Smoothness = _Lerp_f176bf104e364901a15faca7f74a33fd_Out_3;
	surface.Occlusion = _Add_78b726c350d14be58e392670cc9a8503_Out_2;
	return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
	VertexDescriptionInputs output;
	ZERO_INITIALIZE(VertexDescriptionInputs, output);

	output.ObjectSpaceNormal = input.normalOS;
	output.ObjectSpaceTangent = input.tangentOS.xyz;
	output.ObjectSpacePosition = input.positionOS;

	return output;
}
	SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
	SurfaceDescriptionInputs output;
	ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
	float3 unnormalizedNormalWS = input.normalWS;
	const float renormFactor = 1.0 / length(unnormalizedNormalWS);

	// use bitangent on the fly like in hdrp
	// IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
	float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
	float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);

	output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
	output.ObjectSpaceNormal = normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
	output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);

	// to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
	// This is explained in section 2.2 in "surface gradient based bump mapping framework"
	output.WorldSpaceTangent = renormFactor * input.tangentWS.xyz;
	output.WorldSpaceBiTangent = renormFactor * bitang;

	output.WorldSpaceViewDirection = input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
	output.ObjectSpaceViewDirection = TransformWorldToObjectDir(output.WorldSpaceViewDirection);
	output.WorldSpacePosition = input.positionWS;
	output.uv0 = input.texCoord0;
	output.uv1 = input.texCoord1;
#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

	return output;
}

	// --------------------------------------------------
	// Main

	#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRGBufferPass.hlsl"

	ENDHLSL
}
Pass
{
	Name "ShadowCaster"
	Tags
	{
		"LightMode" = "ShadowCaster"
	}

		// Render State
		Cull Back
	Blend One Zero
	ZTest LEqual
	ZWrite On
	ColorMask 0

		// Debug
		// <None>

		// --------------------------------------------------
		// Pass

		HLSLPROGRAM

		// Pragmas
		#pragma target 4.5
	#pragma exclude_renderers gles gles3 glcore
	#pragma multi_compile_instancing
	#pragma multi_compile _ DOTS_INSTANCING_ON
	#pragma vertex vert
	#pragma fragment frag

		// DotsInstancingOptions: <None>
		// HybridV1InjectedBuiltinProperties: <None>

		// Keywords
		// PassKeywords: <None>
		// GraphKeywords: <None>

		// Defines
		#define _NORMALMAP 1
		#define _NORMAL_DROPOFF_TS 1
		#define ATTRIBUTES_NEED_NORMAL
		#define ATTRIBUTES_NEED_TANGENT
		#define VARYINGS_NEED_NORMAL_WS
		#define FEATURES_GRAPH_VERTEX
		/* WARNING: $splice Could not find named fragment 'PassInstancing' */
		#define SHADERPASS SHADERPASS_SHADOWCASTER
		/* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

		// Includes
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

		// --------------------------------------------------
		// Structs and Packing

		struct Attributes
	{
		float3 positionOS : POSITION;
		float3 normalOS : NORMAL;
		float4 tangentOS : TANGENT;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : INSTANCEID_SEMANTIC;
		#endif
	};
	struct Varyings
	{
		float4 positionCS : SV_POSITION;
		float3 normalWS;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};
	struct SurfaceDescriptionInputs
	{
	};
	struct VertexDescriptionInputs
	{
		float3 ObjectSpaceNormal;
		float3 ObjectSpaceTangent;
		float3 ObjectSpacePosition;
	};
	struct PackedVaryings
	{
		float4 positionCS : SV_POSITION;
		float3 interp0 : TEXCOORD0;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};

		PackedVaryings PackVaryings(Varyings input)
	{
		PackedVaryings output;
		output.positionCS = input.positionCS;
		output.interp0.xyz = input.normalWS;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}
	Varyings UnpackVaryings(PackedVaryings input)
	{
		Varyings output;
		output.positionCS = input.positionCS;
		output.normalWS = input.interp0.xyz;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}

	// --------------------------------------------------
	// Graph

	// Graph Properties
	CBUFFER_START(UnityPerMaterial)
float4 _BaseMap_TexelSize;
float4 _BaseColor;
float4 _MRAMap_TexelSize;
float _Smoothness;
float _OcclusionStrength;
float4 _BumpMap_TexelSize;
float4 _EmissionColor;
float Vector1_f104b915aaef41b69539acbf337f0b81;
float4 _CheekMap_TexelSize;
float4 Vector4_700df69d953c4e0e8d13cc36c1e28d41;
float4 _LipMap_TexelSize;
float4 Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1;
float4 _EyeShadowMap_TexelSize;
float4 Vector4_79165151a1a14973895d00e05edb1141;
float4 _PupilMap_TexelSize;
float4 Vector4_3c5a0575ad994c0484082879b48be7eb;
float4 _MaskMap_TexelSize;
float Vector1_7bf270fe91494824b4209d2dc1faae23;
float Vector1_0de750b9c41b4a5daef844a1599f5ac7;
float Vector1_2871f666316541908d110962eef07f02;
float Vector1_b5cc7f6f25194a778cb438f45fbbce66;
float Vector1_8e760635099b4147956bb9600d13cac2;
float4 _GlitterMap_TexelSize;
float2 Vector2_55edcb19ba1d459dbb3c027e66abbc1e;
float Vector1_f6677799b193415b8be7686b658a6e85;
float4 Color_1bf9c5e6f5c34360a490da1c94e6a7c1;
float Vector1_353a19306a364e939d35b1adffceaf21;
float Vector1_9e8e677800b644e19c377f91787c52f4;
float4 Texture2D_f176501ab1eb4c009adb04a9e3357df5_TexelSize;
float Vector1_8198268cf31e477b821e90f882ffb838;
float4 Color_4411c24bb9114a90bac0609a3e38417f;
float4 Color_3d38e1bc34e4408ca62ad21c702a4991;
float2 Vector2_d7f0b0cac82442babeaa593fef472e04;
float Vector1_f66b7945f53b4d85aa034d136a32a8b2;
CBUFFER_END

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_BaseMap);
SAMPLER(sampler_BaseMap);
TEXTURE2D(_MRAMap);
SAMPLER(sampler_MRAMap);
TEXTURE2D(_BumpMap);
SAMPLER(sampler_BumpMap);
TEXTURE2D(_CheekMap);
SAMPLER(sampler_CheekMap);
TEXTURE2D(_LipMap);
SAMPLER(sampler_LipMap);
TEXTURE2D(_EyeShadowMap);
SAMPLER(sampler_EyeShadowMap);
TEXTURE2D(_PupilMap);
SAMPLER(sampler_PupilMap);
TEXTURE2D(_MaskMap);
SAMPLER(sampler_MaskMap);
TEXTURE2D(_GlitterMap);
SAMPLER(sampler_GlitterMap);
TEXTURE2D(Texture2D_f176501ab1eb4c009adb04a9e3357df5);
SAMPLER(samplerTexture2D_f176501ab1eb4c009adb04a9e3357df5);

// Graph Functions
// GraphFunctions: <None>

// Graph Vertex
struct VertexDescription
{
	float3 Position;
	float3 Normal;
	float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
	VertexDescription description = (VertexDescription)0;
	description.Position = IN.ObjectSpacePosition;
	description.Normal = IN.ObjectSpaceNormal;
	description.Tangent = IN.ObjectSpaceTangent;
	return description;
}

// Graph Pixel
struct SurfaceDescription
{
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
	SurfaceDescription surface = (SurfaceDescription)0;
	return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
	VertexDescriptionInputs output;
	ZERO_INITIALIZE(VertexDescriptionInputs, output);

	output.ObjectSpaceNormal = input.normalOS;
	output.ObjectSpaceTangent = input.tangentOS.xyz;
	output.ObjectSpacePosition = input.positionOS;

	return output;
}
	SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
	SurfaceDescriptionInputs output;
	ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

	return output;
}

	// --------------------------------------------------
	// Main

	#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"

	ENDHLSL
}
Pass
{
	Name "DepthOnly"
	Tags
	{
		"LightMode" = "DepthOnly"
	}

		// Render State
		Cull Back
	Blend One Zero
	ZTest LEqual
	ZWrite On
	ColorMask 0

		// Debug
		// <None>

		// --------------------------------------------------
		// Pass

		HLSLPROGRAM

		// Pragmas
		#pragma target 4.5
	#pragma exclude_renderers gles gles3 glcore
	#pragma multi_compile_instancing
	#pragma multi_compile _ DOTS_INSTANCING_ON
	#pragma vertex vert
	#pragma fragment frag

		// DotsInstancingOptions: <None>
		// HybridV1InjectedBuiltinProperties: <None>

		// Keywords
		// PassKeywords: <None>
		// GraphKeywords: <None>

		// Defines
		#define _NORMALMAP 1
		#define _NORMAL_DROPOFF_TS 1
		#define ATTRIBUTES_NEED_NORMAL
		#define ATTRIBUTES_NEED_TANGENT
		#define FEATURES_GRAPH_VERTEX
		/* WARNING: $splice Could not find named fragment 'PassInstancing' */
		#define SHADERPASS SHADERPASS_DEPTHONLY
		/* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

		// Includes
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

		// --------------------------------------------------
		// Structs and Packing

		struct Attributes
	{
		float3 positionOS : POSITION;
		float3 normalOS : NORMAL;
		float4 tangentOS : TANGENT;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : INSTANCEID_SEMANTIC;
		#endif
	};
	struct Varyings
	{
		float4 positionCS : SV_POSITION;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};
	struct SurfaceDescriptionInputs
	{
	};
	struct VertexDescriptionInputs
	{
		float3 ObjectSpaceNormal;
		float3 ObjectSpaceTangent;
		float3 ObjectSpacePosition;
	};
	struct PackedVaryings
	{
		float4 positionCS : SV_POSITION;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};

		PackedVaryings PackVaryings(Varyings input)
	{
		PackedVaryings output;
		output.positionCS = input.positionCS;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}
	Varyings UnpackVaryings(PackedVaryings input)
	{
		Varyings output;
		output.positionCS = input.positionCS;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}

	// --------------------------------------------------
	// Graph

	// Graph Properties
	CBUFFER_START(UnityPerMaterial)
float4 _BaseMap_TexelSize;
float4 _BaseColor;
float4 _MRAMap_TexelSize;
float _Smoothness;
float _OcclusionStrength;
float4 _BumpMap_TexelSize;
float4 _EmissionColor;
float Vector1_f104b915aaef41b69539acbf337f0b81;
float4 _CheekMap_TexelSize;
float4 Vector4_700df69d953c4e0e8d13cc36c1e28d41;
float4 _LipMap_TexelSize;
float4 Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1;
float4 _EyeShadowMap_TexelSize;
float4 Vector4_79165151a1a14973895d00e05edb1141;
float4 _PupilMap_TexelSize;
float4 Vector4_3c5a0575ad994c0484082879b48be7eb;
float4 _MaskMap_TexelSize;
float Vector1_7bf270fe91494824b4209d2dc1faae23;
float Vector1_0de750b9c41b4a5daef844a1599f5ac7;
float Vector1_2871f666316541908d110962eef07f02;
float Vector1_b5cc7f6f25194a778cb438f45fbbce66;
float Vector1_8e760635099b4147956bb9600d13cac2;
float4 _GlitterMap_TexelSize;
float2 Vector2_55edcb19ba1d459dbb3c027e66abbc1e;
float Vector1_f6677799b193415b8be7686b658a6e85;
float4 Color_1bf9c5e6f5c34360a490da1c94e6a7c1;
float Vector1_353a19306a364e939d35b1adffceaf21;
float Vector1_9e8e677800b644e19c377f91787c52f4;
float4 Texture2D_f176501ab1eb4c009adb04a9e3357df5_TexelSize;
float Vector1_8198268cf31e477b821e90f882ffb838;
float4 Color_4411c24bb9114a90bac0609a3e38417f;
float4 Color_3d38e1bc34e4408ca62ad21c702a4991;
float2 Vector2_d7f0b0cac82442babeaa593fef472e04;
float Vector1_f66b7945f53b4d85aa034d136a32a8b2;
CBUFFER_END

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_BaseMap);
SAMPLER(sampler_BaseMap);
TEXTURE2D(_MRAMap);
SAMPLER(sampler_MRAMap);
TEXTURE2D(_BumpMap);
SAMPLER(sampler_BumpMap);
TEXTURE2D(_CheekMap);
SAMPLER(sampler_CheekMap);
TEXTURE2D(_LipMap);
SAMPLER(sampler_LipMap);
TEXTURE2D(_EyeShadowMap);
SAMPLER(sampler_EyeShadowMap);
TEXTURE2D(_PupilMap);
SAMPLER(sampler_PupilMap);
TEXTURE2D(_MaskMap);
SAMPLER(sampler_MaskMap);
TEXTURE2D(_GlitterMap);
SAMPLER(sampler_GlitterMap);
TEXTURE2D(Texture2D_f176501ab1eb4c009adb04a9e3357df5);
SAMPLER(samplerTexture2D_f176501ab1eb4c009adb04a9e3357df5);

// Graph Functions
// GraphFunctions: <None>

// Graph Vertex
struct VertexDescription
{
	float3 Position;
	float3 Normal;
	float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
	VertexDescription description = (VertexDescription)0;
	description.Position = IN.ObjectSpacePosition;
	description.Normal = IN.ObjectSpaceNormal;
	description.Tangent = IN.ObjectSpaceTangent;
	return description;
}

// Graph Pixel
struct SurfaceDescription
{
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
	SurfaceDescription surface = (SurfaceDescription)0;
	return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
	VertexDescriptionInputs output;
	ZERO_INITIALIZE(VertexDescriptionInputs, output);

	output.ObjectSpaceNormal = input.normalOS;
	output.ObjectSpaceTangent = input.tangentOS.xyz;
	output.ObjectSpacePosition = input.positionOS;

	return output;
}
	SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
	SurfaceDescriptionInputs output;
	ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

	return output;
}

	// --------------------------------------------------
	// Main

	#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"

	ENDHLSL
}
Pass
{
	Name "DepthNormals"
	Tags
	{
		"LightMode" = "DepthNormals"
	}

		// Render State
		Cull Back
	Blend One Zero
	ZTest LEqual
	ZWrite On

		// Debug
		// <None>

		// --------------------------------------------------
		// Pass

		HLSLPROGRAM

		// Pragmas
		#pragma target 4.5
	#pragma exclude_renderers gles gles3 glcore
	#pragma multi_compile_instancing
	#pragma multi_compile _ DOTS_INSTANCING_ON
	#pragma vertex vert
	#pragma fragment frag

		// DotsInstancingOptions: <None>
		// HybridV1InjectedBuiltinProperties: <None>

		// Keywords
		// PassKeywords: <None>
		// GraphKeywords: <None>

		// Defines
		#define _NORMALMAP 1
		#define _NORMAL_DROPOFF_TS 1
		#define ATTRIBUTES_NEED_NORMAL
		#define ATTRIBUTES_NEED_TANGENT
		#define ATTRIBUTES_NEED_TEXCOORD0
		#define ATTRIBUTES_NEED_TEXCOORD1
		#define VARYINGS_NEED_POSITION_WS
		#define VARYINGS_NEED_NORMAL_WS
		#define VARYINGS_NEED_TANGENT_WS
		#define VARYINGS_NEED_TEXCOORD0
		#define FEATURES_GRAPH_VERTEX
		/* WARNING: $splice Could not find named fragment 'PassInstancing' */
		#define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
		/* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

		// Includes
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

		// --------------------------------------------------
		// Structs and Packing

		struct Attributes
	{
		float3 positionOS : POSITION;
		float3 normalOS : NORMAL;
		float4 tangentOS : TANGENT;
		float4 uv0 : TEXCOORD0;
		float4 uv1 : TEXCOORD1;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : INSTANCEID_SEMANTIC;
		#endif
	};
	struct Varyings
	{
		float4 positionCS : SV_POSITION;
		float3 positionWS;
		float3 normalWS;
		float4 tangentWS;
		float4 texCoord0;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};
	struct SurfaceDescriptionInputs
	{
		float3 WorldSpaceNormal;
		float3 TangentSpaceNormal;
		float3 WorldSpaceTangent;
		float3 WorldSpaceBiTangent;
		float3 WorldSpacePosition;
		float4 uv0;
	};
	struct VertexDescriptionInputs
	{
		float3 ObjectSpaceNormal;
		float3 ObjectSpaceTangent;
		float3 ObjectSpacePosition;
	};
	struct PackedVaryings
	{
		float4 positionCS : SV_POSITION;
		float3 interp0 : TEXCOORD0;
		float3 interp1 : TEXCOORD1;
		float4 interp2 : TEXCOORD2;
		float4 interp3 : TEXCOORD3;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};

		PackedVaryings PackVaryings(Varyings input)
	{
		PackedVaryings output;
		output.positionCS = input.positionCS;
		output.interp0.xyz = input.positionWS;
		output.interp1.xyz = input.normalWS;
		output.interp2.xyzw = input.tangentWS;
		output.interp3.xyzw = input.texCoord0;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}
	Varyings UnpackVaryings(PackedVaryings input)
	{
		Varyings output;
		output.positionCS = input.positionCS;
		output.positionWS = input.interp0.xyz;
		output.normalWS = input.interp1.xyz;
		output.tangentWS = input.interp2.xyzw;
		output.texCoord0 = input.interp3.xyzw;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}

	// --------------------------------------------------
	// Graph

	// Graph Properties
	CBUFFER_START(UnityPerMaterial)
float4 _BaseMap_TexelSize;
float4 _BaseColor;
float4 _MRAMap_TexelSize;
float _Smoothness;
float _OcclusionStrength;
float4 _BumpMap_TexelSize;
float4 _EmissionColor;
float Vector1_f104b915aaef41b69539acbf337f0b81;
float4 _CheekMap_TexelSize;
float4 Vector4_700df69d953c4e0e8d13cc36c1e28d41;
float4 _LipMap_TexelSize;
float4 Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1;
float4 _EyeShadowMap_TexelSize;
float4 Vector4_79165151a1a14973895d00e05edb1141;
float4 _PupilMap_TexelSize;
float4 Vector4_3c5a0575ad994c0484082879b48be7eb;
float4 _MaskMap_TexelSize;
float Vector1_7bf270fe91494824b4209d2dc1faae23;
float Vector1_0de750b9c41b4a5daef844a1599f5ac7;
float Vector1_2871f666316541908d110962eef07f02;
float Vector1_b5cc7f6f25194a778cb438f45fbbce66;
float Vector1_8e760635099b4147956bb9600d13cac2;
float4 _GlitterMap_TexelSize;
float2 Vector2_55edcb19ba1d459dbb3c027e66abbc1e;
float Vector1_f6677799b193415b8be7686b658a6e85;
float4 Color_1bf9c5e6f5c34360a490da1c94e6a7c1;
float Vector1_353a19306a364e939d35b1adffceaf21;
float Vector1_9e8e677800b644e19c377f91787c52f4;
float4 Texture2D_f176501ab1eb4c009adb04a9e3357df5_TexelSize;
float Vector1_8198268cf31e477b821e90f882ffb838;
float4 Color_4411c24bb9114a90bac0609a3e38417f;
float4 Color_3d38e1bc34e4408ca62ad21c702a4991;
float2 Vector2_d7f0b0cac82442babeaa593fef472e04;
float Vector1_f66b7945f53b4d85aa034d136a32a8b2;
CBUFFER_END

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_BaseMap);
SAMPLER(sampler_BaseMap);
TEXTURE2D(_MRAMap);
SAMPLER(sampler_MRAMap);
TEXTURE2D(_BumpMap);
SAMPLER(sampler_BumpMap);
TEXTURE2D(_CheekMap);
SAMPLER(sampler_CheekMap);
TEXTURE2D(_LipMap);
SAMPLER(sampler_LipMap);
TEXTURE2D(_EyeShadowMap);
SAMPLER(sampler_EyeShadowMap);
TEXTURE2D(_PupilMap);
SAMPLER(sampler_PupilMap);
TEXTURE2D(_MaskMap);
SAMPLER(sampler_MaskMap);
TEXTURE2D(_GlitterMap);
SAMPLER(sampler_GlitterMap);
TEXTURE2D(Texture2D_f176501ab1eb4c009adb04a9e3357df5);
SAMPLER(samplerTexture2D_f176501ab1eb4c009adb04a9e3357df5);

// Graph Functions

void Unity_NormalUnpack_float(float4 In, out float3 Out)
{
				Out = UnpackNormal(In);
			}


float2 Unity_GradientNoise_Dir_float(float2 p)
{
	// Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
	p = p % 289;
	// need full precision, otherwise half overflows when p > 1
	float x = float(34 * p.x + 1) * p.x % 289 + p.y;
	x = (34 * x + 1) * x % 289;
	x = frac(x / 41) * 2 - 1;
	return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
}

void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
{
	float2 p = UV * Scale;
	float2 ip = floor(p);
	float2 fp = frac(p);
	float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
	float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
	float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
	float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
	fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
	Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
}

void Unity_Add_float(float A, float B, out float Out)
{
	Out = A + B;
}

void Unity_Multiply_float(float A, float B, out float Out)
{
	Out = A * B;
}

void Unity_Lerp_float(float A, float B, float T, out float Out)
{
	Out = lerp(A, B, T);
}

void Unity_NormalFromHeight_Tangent_float(float In, float Strength, float3 Position, float3x3 TangentMatrix, out float3 Out)
{
	float3 worldDerivativeX = ddx(Position);
	float3 worldDerivativeY = ddy(Position);

	float3 crossX = cross(TangentMatrix[2].xyz, worldDerivativeX);
	float3 crossY = cross(worldDerivativeY, TangentMatrix[2].xyz);
	float d = dot(worldDerivativeX, crossY);
	float sgn = d < 0.0 ? (-1.0f) : 1.0f;
	float surface = sgn / max(0.000000000000001192093f, abs(d));

	float dHdx = ddx(In);
	float dHdy = ddy(In);
	float3 surfGrad = surface * (dHdx*crossY + dHdy * crossX);
	Out = SafeNormalize(TangentMatrix[2].xyz - (Strength * surfGrad));
	Out = TransformWorldToTangent(Out, TangentMatrix);
}

void Unity_OneMinus_float(float In, out float Out)
{
	Out = 1 - In;
}

void Unity_Step_float(float Edge, float In, out float Out)
{
	Out = step(Edge, In);
}

void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
{
	Out = lerp(A, B, T);
}

// Graph Vertex
struct VertexDescription
{
	float3 Position;
	float3 Normal;
	float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
	VertexDescription description = (VertexDescription)0;
	description.Position = IN.ObjectSpacePosition;
	description.Normal = IN.ObjectSpaceNormal;
	description.Tangent = IN.ObjectSpaceTangent;
	return description;
}

// Graph Pixel
struct SurfaceDescription
{
	float3 NormalTS;
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
	SurfaceDescription surface = (SurfaceDescription)0;
	UnityTexture2D _Property_ef39b7e1c5c6465f842c5dfa050e47e1_Out_0 = UnityBuildTexture2DStructNoScale(_BumpMap);
	float4 _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0 = SAMPLE_TEXTURE2D(_Property_ef39b7e1c5c6465f842c5dfa050e47e1_Out_0.tex, _Property_ef39b7e1c5c6465f842c5dfa050e47e1_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_R_4 = _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0.r;
	float _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_G_5 = _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0.g;
	float _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_B_6 = _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0.b;
	float _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_A_7 = _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0.a;
	float3 _NormalUnpack_b1e6ba1d5cc34fc6bed28052e3d03168_Out_1;
	Unity_NormalUnpack_float(_SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0, _NormalUnpack_b1e6ba1d5cc34fc6bed28052e3d03168_Out_1);
	float _Property_7671b3b7eef84a8c9d7825a9036c8bff_Out_0 = Vector1_b5cc7f6f25194a778cb438f45fbbce66;
	float _GradientNoise_4be9f93cabe14a849abe7b8ed37b6bbd_Out_2;
	Unity_GradientNoise_float(IN.uv0.xy, _Property_7671b3b7eef84a8c9d7825a9036c8bff_Out_0, _GradientNoise_4be9f93cabe14a849abe7b8ed37b6bbd_Out_2);
	float _Add_3e0bbf4ee4904868940bafe39dd7423f_Out_2;
	Unity_Add_float(_GradientNoise_4be9f93cabe14a849abe7b8ed37b6bbd_Out_2, 0.3, _Add_3e0bbf4ee4904868940bafe39dd7423f_Out_2);
	UnityTexture2D _Property_90c3e617459146b89270ca735ff67027_Out_0 = UnityBuildTexture2DStructNoScale(_MaskMap);
	float4 _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0 = SAMPLE_TEXTURE2D(_Property_90c3e617459146b89270ca735ff67027_Out_0.tex, _Property_90c3e617459146b89270ca735ff67027_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_R_4 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.r;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_G_5 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.g;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_B_6 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.b;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.a;
	float _Multiply_2e36cc2586dc491abb678f1f1cf3d350_Out_2;
	Unity_Multiply_float(_GradientNoise_4be9f93cabe14a849abe7b8ed37b6bbd_Out_2, _SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _Multiply_2e36cc2586dc491abb678f1f1cf3d350_Out_2);
	float _Lerp_c862be95f9354a0ab4024a518282ec79_Out_3;
	Unity_Lerp_float(0.3, _Add_3e0bbf4ee4904868940bafe39dd7423f_Out_2, _Multiply_2e36cc2586dc491abb678f1f1cf3d350_Out_2, _Lerp_c862be95f9354a0ab4024a518282ec79_Out_3);
	float _Property_6721bad2e28e4210a1fa01a48f73c858_Out_0 = Vector1_8e760635099b4147956bb9600d13cac2;
	float3 _NormalFromHeight_392055ed45084230899320a5058871be_Out_1;
	float3x3 _NormalFromHeight_392055ed45084230899320a5058871be_TangentMatrix = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
	float3 _NormalFromHeight_392055ed45084230899320a5058871be_Position = IN.WorldSpacePosition;
	Unity_NormalFromHeight_Tangent_float(_Lerp_c862be95f9354a0ab4024a518282ec79_Out_3,_Property_6721bad2e28e4210a1fa01a48f73c858_Out_0,_NormalFromHeight_392055ed45084230899320a5058871be_Position,_NormalFromHeight_392055ed45084230899320a5058871be_TangentMatrix, _NormalFromHeight_392055ed45084230899320a5058871be_Out_1);
	float _OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1;
	Unity_OneMinus_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1);
	float _Property_1a86dcb475f34e9c8bb3d74526142f51_Out_0 = Vector1_2871f666316541908d110962eef07f02;
	float _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2;
	Unity_GradientNoise_float(IN.uv0.xy, _Property_1a86dcb475f34e9c8bb3d74526142f51_Out_0, _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2);
	float _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2;
	Unity_Multiply_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2, _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2);
	float _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2;
	Unity_Add_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2, _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2);
	float _Step_d74a28341b3b47d2b929db9c36d76662_Out_2;
	Unity_Step_float(_OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1, _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2, _Step_d74a28341b3b47d2b929db9c36d76662_Out_2);
	float3 _Lerp_cfff89d8630c4d3b975d173579abd871_Out_3;
	Unity_Lerp_float3(_NormalUnpack_b1e6ba1d5cc34fc6bed28052e3d03168_Out_1, _NormalFromHeight_392055ed45084230899320a5058871be_Out_1, (_Step_d74a28341b3b47d2b929db9c36d76662_Out_2.xxx), _Lerp_cfff89d8630c4d3b975d173579abd871_Out_3);
	surface.NormalTS = _Lerp_cfff89d8630c4d3b975d173579abd871_Out_3;
	return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
	VertexDescriptionInputs output;
	ZERO_INITIALIZE(VertexDescriptionInputs, output);

	output.ObjectSpaceNormal = input.normalOS;
	output.ObjectSpaceTangent = input.tangentOS.xyz;
	output.ObjectSpacePosition = input.positionOS;

	return output;
}
	SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
	SurfaceDescriptionInputs output;
	ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
	float3 unnormalizedNormalWS = input.normalWS;
	const float renormFactor = 1.0 / length(unnormalizedNormalWS);

	// use bitangent on the fly like in hdrp
	// IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
	float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
	float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);

	output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
	output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);

	// to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
	// This is explained in section 2.2 in "surface gradient based bump mapping framework"
	output.WorldSpaceTangent = renormFactor * input.tangentWS.xyz;
	output.WorldSpaceBiTangent = renormFactor * bitang;

	output.WorldSpacePosition = input.positionWS;
	output.uv0 = input.texCoord0;
#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

	return output;
}

	// --------------------------------------------------
	// Main

	#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"

	ENDHLSL
}
Pass
{
	Name "Meta"
	Tags
	{
		"LightMode" = "Meta"
	}

		// Render State
		Cull Off

		// Debug
		// <None>

		// --------------------------------------------------
		// Pass

		HLSLPROGRAM

		// Pragmas
		#pragma target 4.5
	#pragma exclude_renderers gles gles3 glcore
	#pragma vertex vert
	#pragma fragment frag

		// DotsInstancingOptions: <None>
		// HybridV1InjectedBuiltinProperties: <None>

		// Keywords
		#pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
		// GraphKeywords: <None>

		// Defines
		#define _NORMALMAP 1
		#define _NORMAL_DROPOFF_TS 1
		#define ATTRIBUTES_NEED_NORMAL
		#define ATTRIBUTES_NEED_TANGENT
		#define ATTRIBUTES_NEED_TEXCOORD0
		#define ATTRIBUTES_NEED_TEXCOORD1
		#define ATTRIBUTES_NEED_TEXCOORD2
		#define VARYINGS_NEED_NORMAL_WS
		#define VARYINGS_NEED_TEXCOORD0
		#define VARYINGS_NEED_TEXCOORD1
		#define VARYINGS_NEED_VIEWDIRECTION_WS
		#define FEATURES_GRAPH_VERTEX
		/* WARNING: $splice Could not find named fragment 'PassInstancing' */
		#define SHADERPASS SHADERPASS_META
		/* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

		// Includes
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"

		// --------------------------------------------------
		// Structs and Packing

		struct Attributes
	{
		float3 positionOS : POSITION;
		float3 normalOS : NORMAL;
		float4 tangentOS : TANGENT;
		float4 uv0 : TEXCOORD0;
		float4 uv1 : TEXCOORD1;
		float4 uv2 : TEXCOORD2;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : INSTANCEID_SEMANTIC;
		#endif
	};
	struct Varyings
	{
		float4 positionCS : SV_POSITION;
		float3 normalWS;
		float4 texCoord0;
		float4 texCoord1;
		float3 viewDirectionWS;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};
	struct SurfaceDescriptionInputs
	{
		float3 ObjectSpaceNormal;
		float3 WorldSpaceNormal;
		float3 ObjectSpaceViewDirection;
		float3 WorldSpaceViewDirection;
		float4 uv0;
		float4 uv1;
	};
	struct VertexDescriptionInputs
	{
		float3 ObjectSpaceNormal;
		float3 ObjectSpaceTangent;
		float3 ObjectSpacePosition;
	};
	struct PackedVaryings
	{
		float4 positionCS : SV_POSITION;
		float3 interp0 : TEXCOORD0;
		float4 interp1 : TEXCOORD1;
		float4 interp2 : TEXCOORD2;
		float3 interp3 : TEXCOORD3;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};

		PackedVaryings PackVaryings(Varyings input)
	{
		PackedVaryings output;
		output.positionCS = input.positionCS;
		output.interp0.xyz = input.normalWS;
		output.interp1.xyzw = input.texCoord0;
		output.interp2.xyzw = input.texCoord1;
		output.interp3.xyz = input.viewDirectionWS;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}
	Varyings UnpackVaryings(PackedVaryings input)
	{
		Varyings output;
		output.positionCS = input.positionCS;
		output.normalWS = input.interp0.xyz;
		output.texCoord0 = input.interp1.xyzw;
		output.texCoord1 = input.interp2.xyzw;
		output.viewDirectionWS = input.interp3.xyz;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}

	// --------------------------------------------------
	// Graph

	// Graph Properties
	CBUFFER_START(UnityPerMaterial)
float4 _BaseMap_TexelSize;
float4 _BaseColor;
float4 _MRAMap_TexelSize;
float _Smoothness;
float _OcclusionStrength;
float4 _BumpMap_TexelSize;
float4 _EmissionColor;
float Vector1_f104b915aaef41b69539acbf337f0b81;
float4 _CheekMap_TexelSize;
float4 Vector4_700df69d953c4e0e8d13cc36c1e28d41;
float4 _LipMap_TexelSize;
float4 Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1;
float4 _EyeShadowMap_TexelSize;
float4 Vector4_79165151a1a14973895d00e05edb1141;
float4 _PupilMap_TexelSize;
float4 Vector4_3c5a0575ad994c0484082879b48be7eb;
float4 _MaskMap_TexelSize;
float Vector1_7bf270fe91494824b4209d2dc1faae23;
float Vector1_0de750b9c41b4a5daef844a1599f5ac7;
float Vector1_2871f666316541908d110962eef07f02;
float Vector1_b5cc7f6f25194a778cb438f45fbbce66;
float Vector1_8e760635099b4147956bb9600d13cac2;
float4 _GlitterMap_TexelSize;
float2 Vector2_55edcb19ba1d459dbb3c027e66abbc1e;
float Vector1_f6677799b193415b8be7686b658a6e85;
float4 Color_1bf9c5e6f5c34360a490da1c94e6a7c1;
float Vector1_353a19306a364e939d35b1adffceaf21;
float Vector1_9e8e677800b644e19c377f91787c52f4;
float4 Texture2D_f176501ab1eb4c009adb04a9e3357df5_TexelSize;
float Vector1_8198268cf31e477b821e90f882ffb838;
float4 Color_4411c24bb9114a90bac0609a3e38417f;
float4 Color_3d38e1bc34e4408ca62ad21c702a4991;
float2 Vector2_d7f0b0cac82442babeaa593fef472e04;
float Vector1_f66b7945f53b4d85aa034d136a32a8b2;
CBUFFER_END

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_BaseMap);
SAMPLER(sampler_BaseMap);
TEXTURE2D(_MRAMap);
SAMPLER(sampler_MRAMap);
TEXTURE2D(_BumpMap);
SAMPLER(sampler_BumpMap);
TEXTURE2D(_CheekMap);
SAMPLER(sampler_CheekMap);
TEXTURE2D(_LipMap);
SAMPLER(sampler_LipMap);
TEXTURE2D(_EyeShadowMap);
SAMPLER(sampler_EyeShadowMap);
TEXTURE2D(_PupilMap);
SAMPLER(sampler_PupilMap);
TEXTURE2D(_MaskMap);
SAMPLER(sampler_MaskMap);
TEXTURE2D(_GlitterMap);
SAMPLER(sampler_GlitterMap);
TEXTURE2D(Texture2D_f176501ab1eb4c009adb04a9e3357df5);
SAMPLER(samplerTexture2D_f176501ab1eb4c009adb04a9e3357df5);

// Graph Functions

void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
{
	Out = A * B;
}

void Unity_Add_float(float A, float B, out float Out)
{
	Out = A + B;
}

void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
{
	RGBA = float4(R, G, B, A);
	RGB = float3(R, G, B);
	RG = float2(R, G);
}

void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
{
	Out = lerp(A, B, T);
}

void Unity_OneMinus_float(float In, out float Out)
{
	Out = 1 - In;
}


float2 Unity_GradientNoise_Dir_float(float2 p)
{
	// Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
	p = p % 289;
	// need full precision, otherwise half overflows when p > 1
	float x = float(34 * p.x + 1) * p.x % 289 + p.y;
	x = (34 * x + 1) * x % 289;
	x = frac(x / 41) * 2 - 1;
	return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
}

void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
{
	float2 p = UV * Scale;
	float2 ip = floor(p);
	float2 fp = frac(p);
	float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
	float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
	float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
	float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
	fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
	Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
}

void Unity_Multiply_float(float A, float B, out float Out)
{
	Out = A * B;
}

void Unity_Step_float(float Edge, float In, out float Out)
{
	Out = step(Edge, In);
}

void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
{
	Out = UV * Tiling + Offset;
}

void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
{
	Out = A - B;
}

void Unity_Normalize_float3(float3 In, out float3 Out)
{
	Out = normalize(In);
}

void Unity_Add_float3(float3 A, float3 B, out float3 Out)
{
	Out = A + B;
}

void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
{
	Out = dot(A, B);
}

void Unity_Saturate_float(float In, out float Out)
{
	Out = saturate(In);
}

void Unity_Exponential2_float(float In, out float Out)
{
	Out = exp2(In);
}

void Unity_Power_float(float A, float B, out float Out)
{
	Out = pow(A, B);
}

void Unity_Add_float4(float4 A, float4 B, out float4 Out)
{
	Out = A + B;
}

// Graph Vertex
struct VertexDescription
{
	float3 Position;
	float3 Normal;
	float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
	VertexDescription description = (VertexDescription)0;
	description.Position = IN.ObjectSpacePosition;
	description.Normal = IN.ObjectSpaceNormal;
	description.Tangent = IN.ObjectSpaceTangent;
	return description;
}

// Graph Pixel
struct SurfaceDescription
{
	float3 BaseColor;
	float3 Emission;
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
	SurfaceDescription surface = (SurfaceDescription)0;
	UnityTexture2D _Property_46f41194bebd49dd90523a9187559d47_Out_0 = UnityBuildTexture2DStructNoScale(_BaseMap);
	float4 _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0 = SAMPLE_TEXTURE2D(_Property_46f41194bebd49dd90523a9187559d47_Out_0.tex, _Property_46f41194bebd49dd90523a9187559d47_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_R_4 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.r;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_G_5 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.g;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_B_6 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.b;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_A_7 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.a;
	float4 _Property_3cc81970230a4e2680f1056abe28f14c_Out_0 = _BaseColor;
	float4 _Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2;
	Unity_Multiply_float(_SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0, _Property_3cc81970230a4e2680f1056abe28f14c_Out_0, _Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2);
	UnityTexture2D _Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0 = UnityBuildTexture2DStructNoScale(_CheekMap);
	float4 _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0 = Vector4_700df69d953c4e0e8d13cc36c1e28d41;
	float _Split_5022297589804f21900b69c657b81fa0_R_1 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[0];
	float _Split_5022297589804f21900b69c657b81fa0_G_2 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[1];
	float _Split_5022297589804f21900b69c657b81fa0_B_3 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[2];
	float _Split_5022297589804f21900b69c657b81fa0_A_4 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[3];
	float4 _UV_5c27d34f7fe0493fa46cacf01b32cccc_Out_0 = IN.uv1;
	float4 _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2;
	Unity_Multiply_float((_Split_5022297589804f21900b69c657b81fa0_R_1.xxxx), _UV_5c27d34f7fe0493fa46cacf01b32cccc_Out_0, _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2);
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_R_1 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[0];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_G_2 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[1];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_B_3 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[2];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_A_4 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[3];
	float _Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2;
	Unity_Add_float(_Split_5022297589804f21900b69c657b81fa0_G_2, _Split_f75341ed066d43c2ba64dd1807c3cdd5_R_1, _Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2);
	float _Add_b8d09a71819044be96521761cc153267_Out_2;
	Unity_Add_float(_Split_f75341ed066d43c2ba64dd1807c3cdd5_G_2, _Split_5022297589804f21900b69c657b81fa0_B_3, _Add_b8d09a71819044be96521761cc153267_Out_2);
	float4 _Combine_0939f9cc49e54d3ea511e937525deee6_RGBA_4;
	float3 _Combine_0939f9cc49e54d3ea511e937525deee6_RGB_5;
	float2 _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6;
	Unity_Combine_float(_Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2, _Add_b8d09a71819044be96521761cc153267_Out_2, 0, 0, _Combine_0939f9cc49e54d3ea511e937525deee6_RGBA_4, _Combine_0939f9cc49e54d3ea511e937525deee6_RGB_5, _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6);
	float4 _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0 = SAMPLE_TEXTURE2D(_Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0.tex, _Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0.samplerstate, _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6);
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_R_4 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.r;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_G_5 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.g;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_B_6 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.b;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_A_7 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.a;
	float4 _Lerp_2241ae8feb5941da9183bb461c252132_Out_3;
	Unity_Lerp_float4(_Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2, _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0, (_SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_A_7.xxxx), _Lerp_2241ae8feb5941da9183bb461c252132_Out_3);
	UnityTexture2D _Property_5f8a386b21984e2988fde7598f635a9a_Out_0 = UnityBuildTexture2DStructNoScale(_LipMap);
	float4 _Property_c857b47c21154b86a27f46398299df91_Out_0 = Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1;
	float _Split_f308ae64287f48e8872c952e6828cb36_R_1 = _Property_c857b47c21154b86a27f46398299df91_Out_0[0];
	float _Split_f308ae64287f48e8872c952e6828cb36_G_2 = _Property_c857b47c21154b86a27f46398299df91_Out_0[1];
	float _Split_f308ae64287f48e8872c952e6828cb36_B_3 = _Property_c857b47c21154b86a27f46398299df91_Out_0[2];
	float _Split_f308ae64287f48e8872c952e6828cb36_A_4 = _Property_c857b47c21154b86a27f46398299df91_Out_0[3];
	float4 _UV_c1af69e74f4e4df791b33b8f07716d5b_Out_0 = IN.uv1;
	float4 _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2;
	Unity_Multiply_float((_Split_f308ae64287f48e8872c952e6828cb36_R_1.xxxx), _UV_c1af69e74f4e4df791b33b8f07716d5b_Out_0, _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2);
	float _Split_3123c7f71f9749b2aa01689ddefb9374_R_1 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[0];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_G_2 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[1];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_B_3 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[2];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_A_4 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[3];
	float _Add_f2f7dee5f2844fb8822bccad48406ade_Out_2;
	Unity_Add_float(_Split_f308ae64287f48e8872c952e6828cb36_G_2, _Split_3123c7f71f9749b2aa01689ddefb9374_R_1, _Add_f2f7dee5f2844fb8822bccad48406ade_Out_2);
	float _Add_5287d7b9aac546af90e5e834b37567d2_Out_2;
	Unity_Add_float(_Split_3123c7f71f9749b2aa01689ddefb9374_G_2, _Split_f308ae64287f48e8872c952e6828cb36_B_3, _Add_5287d7b9aac546af90e5e834b37567d2_Out_2);
	float4 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGBA_4;
	float3 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGB_5;
	float2 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6;
	Unity_Combine_float(_Add_f2f7dee5f2844fb8822bccad48406ade_Out_2, _Add_5287d7b9aac546af90e5e834b37567d2_Out_2, 0, 0, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGBA_4, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGB_5, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6);
	float4 _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_5f8a386b21984e2988fde7598f635a9a_Out_0.tex, _Property_5f8a386b21984e2988fde7598f635a9a_Out_0.samplerstate, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6);
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_R_4 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.r;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_G_5 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.g;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_B_6 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.b;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_A_7 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.a;
	float4 _Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3;
	Unity_Lerp_float4(_Lerp_2241ae8feb5941da9183bb461c252132_Out_3, _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0, (_SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_A_7.xxxx), _Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3);
	UnityTexture2D _Property_034f7053a4c04630b179945137478563_Out_0 = UnityBuildTexture2DStructNoScale(_EyeShadowMap);
	float4 _Property_ec0501c48b2f47fca24e4415b083a817_Out_0 = Vector4_79165151a1a14973895d00e05edb1141;
	float _Split_a65775607697471ebf0abd88cba1cc94_R_1 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[0];
	float _Split_a65775607697471ebf0abd88cba1cc94_G_2 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[1];
	float _Split_a65775607697471ebf0abd88cba1cc94_B_3 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[2];
	float _Split_a65775607697471ebf0abd88cba1cc94_A_4 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[3];
	float4 _UV_561d401f6e7242d99119d7be74ed408f_Out_0 = IN.uv1;
	float4 _Multiply_9434dd79d3204d6f97de52affd770331_Out_2;
	Unity_Multiply_float((_Split_a65775607697471ebf0abd88cba1cc94_R_1.xxxx), _UV_561d401f6e7242d99119d7be74ed408f_Out_0, _Multiply_9434dd79d3204d6f97de52affd770331_Out_2);
	float _Split_48b01121140e4699b1b0d4a54f925206_R_1 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[0];
	float _Split_48b01121140e4699b1b0d4a54f925206_G_2 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[1];
	float _Split_48b01121140e4699b1b0d4a54f925206_B_3 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[2];
	float _Split_48b01121140e4699b1b0d4a54f925206_A_4 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[3];
	float _Add_70cfb275974e4ed78884eb9ddb51407c_Out_2;
	Unity_Add_float(_Split_a65775607697471ebf0abd88cba1cc94_G_2, _Split_48b01121140e4699b1b0d4a54f925206_R_1, _Add_70cfb275974e4ed78884eb9ddb51407c_Out_2);
	float _Add_bf85759250cd46a5a834e59e8174d47f_Out_2;
	Unity_Add_float(_Split_48b01121140e4699b1b0d4a54f925206_G_2, _Split_a65775607697471ebf0abd88cba1cc94_B_3, _Add_bf85759250cd46a5a834e59e8174d47f_Out_2);
	float4 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGBA_4;
	float3 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGB_5;
	float2 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6;
	Unity_Combine_float(_Add_70cfb275974e4ed78884eb9ddb51407c_Out_2, _Add_bf85759250cd46a5a834e59e8174d47f_Out_2, 0, 0, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGBA_4, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGB_5, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6);
	float4 _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0 = SAMPLE_TEXTURE2D(_Property_034f7053a4c04630b179945137478563_Out_0.tex, _Property_034f7053a4c04630b179945137478563_Out_0.samplerstate, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6);
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_R_4 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.r;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_G_5 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.g;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_B_6 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.b;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_A_7 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.a;
	float4 _Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3;
	Unity_Lerp_float4(_Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3, _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0, (_SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_A_7.xxxx), _Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3);
	UnityTexture2D _Property_f0ad144d6d604946a0265c0ff45af34a_Out_0 = UnityBuildTexture2DStructNoScale(_PupilMap);
	float4 _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0 = Vector4_3c5a0575ad994c0484082879b48be7eb;
	float _Split_597b0aa14ac147bb8547d10058ea208e_R_1 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[0];
	float _Split_597b0aa14ac147bb8547d10058ea208e_G_2 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[1];
	float _Split_597b0aa14ac147bb8547d10058ea208e_B_3 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[2];
	float _Split_597b0aa14ac147bb8547d10058ea208e_A_4 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[3];
	float4 _UV_fa01ab9e6ed045c0932df0bd20747d29_Out_0 = IN.uv1;
	float4 _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2;
	Unity_Multiply_float((_Split_597b0aa14ac147bb8547d10058ea208e_R_1.xxxx), _UV_fa01ab9e6ed045c0932df0bd20747d29_Out_0, _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2);
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_R_1 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[0];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_G_2 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[1];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_B_3 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[2];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_A_4 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[3];
	float _Add_8655d6d32b1b40259250182a69e8b8b7_Out_2;
	Unity_Add_float(_Split_597b0aa14ac147bb8547d10058ea208e_G_2, _Split_6051d27c6349400fbb5a5932d8d2c7ad_R_1, _Add_8655d6d32b1b40259250182a69e8b8b7_Out_2);
	float _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2;
	Unity_Add_float(_Split_6051d27c6349400fbb5a5932d8d2c7ad_G_2, _Split_597b0aa14ac147bb8547d10058ea208e_B_3, _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2);
	float4 _Combine_3c3cf19616e143188639a90935b8a10b_RGBA_4;
	float3 _Combine_3c3cf19616e143188639a90935b8a10b_RGB_5;
	float2 _Combine_3c3cf19616e143188639a90935b8a10b_RG_6;
	Unity_Combine_float(_Add_8655d6d32b1b40259250182a69e8b8b7_Out_2, _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2, 0, 0, _Combine_3c3cf19616e143188639a90935b8a10b_RGBA_4, _Combine_3c3cf19616e143188639a90935b8a10b_RGB_5, _Combine_3c3cf19616e143188639a90935b8a10b_RG_6);
	float4 _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0 = SAMPLE_TEXTURE2D(_Property_f0ad144d6d604946a0265c0ff45af34a_Out_0.tex, _Property_f0ad144d6d604946a0265c0ff45af34a_Out_0.samplerstate, _Combine_3c3cf19616e143188639a90935b8a10b_RG_6);
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_R_4 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.r;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_G_5 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.g;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_B_6 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.b;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_A_7 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.a;
	float4 _Lerp_9134832094eb464f874ea325fccb805d_Out_3;
	Unity_Lerp_float4(_Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3, _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0, (_SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_A_7.xxxx), _Lerp_9134832094eb464f874ea325fccb805d_Out_3);
	UnityTexture2D _Property_33d05c2bee3a48cbad54c88a071627d0_Out_0 = UnityBuildTexture2DStructNoScale(_MaskMap);
	float4 _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0 = SAMPLE_TEXTURE2D(_Property_33d05c2bee3a48cbad54c88a071627d0_Out_0.tex, _Property_33d05c2bee3a48cbad54c88a071627d0_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_R_4 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.r;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_G_5 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.g;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_B_6 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.b;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_A_7 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.a;
	UnityTexture2D _Property_90c3e617459146b89270ca735ff67027_Out_0 = UnityBuildTexture2DStructNoScale(_MaskMap);
	float4 _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0 = SAMPLE_TEXTURE2D(_Property_90c3e617459146b89270ca735ff67027_Out_0.tex, _Property_90c3e617459146b89270ca735ff67027_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_R_4 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.r;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_G_5 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.g;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_B_6 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.b;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.a;
	float _OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1;
	Unity_OneMinus_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1);
	float _Property_1a86dcb475f34e9c8bb3d74526142f51_Out_0 = Vector1_2871f666316541908d110962eef07f02;
	float _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2;
	Unity_GradientNoise_float(IN.uv0.xy, _Property_1a86dcb475f34e9c8bb3d74526142f51_Out_0, _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2);
	float _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2;
	Unity_Multiply_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2, _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2);
	float _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2;
	Unity_Add_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2, _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2);
	float _Step_d74a28341b3b47d2b929db9c36d76662_Out_2;
	Unity_Step_float(_OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1, _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2, _Step_d74a28341b3b47d2b929db9c36d76662_Out_2);
	float4 _Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3;
	Unity_Lerp_float4(_Lerp_9134832094eb464f874ea325fccb805d_Out_3, _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0, (_Step_d74a28341b3b47d2b929db9c36d76662_Out_2.xxxx), _Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3);
	UnityTexture2D _Property_9e2e155797564e99b75bfe8d3f7be32d_Out_0 = UnityBuildTexture2DStructNoScale(_MRAMap);
	float4 _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0 = SAMPLE_TEXTURE2D(_Property_9e2e155797564e99b75bfe8d3f7be32d_Out_0.tex, _Property_9e2e155797564e99b75bfe8d3f7be32d_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_R_4 = _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0.r;
	float _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_G_5 = _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0.g;
	float _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_B_6 = _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0.b;
	float _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_A_7 = _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0.a;
	float4 _Property_b6f5177f3ae44d2cb157e753cff0343c_Out_0 = _EmissionColor;
	float4 _Multiply_8c3b33adad4c4e69a14a0843a37bf4d0_Out_2;
	Unity_Multiply_float((_SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_A_7.xxxx), _Property_b6f5177f3ae44d2cb157e753cff0343c_Out_0, _Multiply_8c3b33adad4c4e69a14a0843a37bf4d0_Out_2);
	float _Property_80e0e6200a1642e1884a71644e4682bf_Out_0 = Vector1_f104b915aaef41b69539acbf337f0b81;
	float4 _Multiply_f86d698f353e49b8ac4e704412805883_Out_2;
	Unity_Multiply_float(_Multiply_8c3b33adad4c4e69a14a0843a37bf4d0_Out_2, (_Property_80e0e6200a1642e1884a71644e4682bf_Out_0.xxxx), _Multiply_f86d698f353e49b8ac4e704412805883_Out_2);
	UnityTexture2D _Property_fe9310b7c4f2436d8e27d43b3fe188aa_Out_0 = UnityBuildTexture2DStructNoScale(_GlitterMap);
	float2 _Property_2032db54a42245aaa9312efadd4f15e3_Out_0 = Vector2_55edcb19ba1d459dbb3c027e66abbc1e;
	float2 _TilingAndOffset_721ed8d53fd54eef98ca2df1ba7cfdf5_Out_3;
	Unity_TilingAndOffset_float(IN.uv0.xy, _Property_2032db54a42245aaa9312efadd4f15e3_Out_0, float2 (0, 0), _TilingAndOffset_721ed8d53fd54eef98ca2df1ba7cfdf5_Out_3);
	float4 _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_fe9310b7c4f2436d8e27d43b3fe188aa_Out_0.tex, UnityBuildSamplerStateStruct(SamplerState_Point_Repeat).samplerstate, _TilingAndOffset_721ed8d53fd54eef98ca2df1ba7cfdf5_Out_3);
	float _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_R_4 = _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0.r;
	float _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_G_5 = _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0.g;
	float _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_B_6 = _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0.b;
	float _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_A_7 = _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0.a;
	float3 _Vector3_ed002c12350a46b69f196e5d728582cd_Out_0 = float3(_SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_R_4, _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_G_5, _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_B_6);
	float3 _Subtract_3a4ad3383c6f43b4825e534b6fcefded_Out_2;
	Unity_Subtract_float3(_Vector3_ed002c12350a46b69f196e5d728582cd_Out_0, float3(0.5, 0.5, 0.5), _Subtract_3a4ad3383c6f43b4825e534b6fcefded_Out_2);
	float3 _Normalize_956cacc929084d28952105a8c1bcea48_Out_1;
	Unity_Normalize_float3(_Subtract_3a4ad3383c6f43b4825e534b6fcefded_Out_2, _Normalize_956cacc929084d28952105a8c1bcea48_Out_1);
	float3 _Add_8543d53668cc40b5a1bc702cfb07701b_Out_2;
	Unity_Add_float3(_Normalize_956cacc929084d28952105a8c1bcea48_Out_1, IN.ObjectSpaceNormal, _Add_8543d53668cc40b5a1bc702cfb07701b_Out_2);
	float3 _Normalize_472c4ae9e2c94183aeab11d54efdf6e9_Out_1;
	Unity_Normalize_float3(_Add_8543d53668cc40b5a1bc702cfb07701b_Out_2, _Normalize_472c4ae9e2c94183aeab11d54efdf6e9_Out_1);
	float _DotProduct_ed89b1c6e5fa4f83ba62172883d90a01_Out_2;
	Unity_DotProduct_float3(_Normalize_472c4ae9e2c94183aeab11d54efdf6e9_Out_1, IN.ObjectSpaceViewDirection, _DotProduct_ed89b1c6e5fa4f83ba62172883d90a01_Out_2);
	float _Saturate_9dc8013924fd4863b579da0965a6c1e2_Out_1;
	Unity_Saturate_float(_DotProduct_ed89b1c6e5fa4f83ba62172883d90a01_Out_2, _Saturate_9dc8013924fd4863b579da0965a6c1e2_Out_1);
	float _Property_410af66ac63f4b6ca91752d4e6c8c4b1_Out_0 = Vector1_f6677799b193415b8be7686b658a6e85;
	float _Add_225974d87fe74eed99d56fbe9aea1572_Out_2;
	Unity_Add_float(_Property_410af66ac63f4b6ca91752d4e6c8c4b1_Out_0, 1, _Add_225974d87fe74eed99d56fbe9aea1572_Out_2);
	float _Exponential_8ae78e15f67946618ffb2645de1f1589_Out_1;
	Unity_Exponential2_float(_Add_225974d87fe74eed99d56fbe9aea1572_Out_2, _Exponential_8ae78e15f67946618ffb2645de1f1589_Out_1);
	float _Power_3eee35aa9ed846d7a8ccf6fe2caa881f_Out_2;
	Unity_Power_float(_Saturate_9dc8013924fd4863b579da0965a6c1e2_Out_1, _Exponential_8ae78e15f67946618ffb2645de1f1589_Out_1, _Power_3eee35aa9ed846d7a8ccf6fe2caa881f_Out_2);
	float4 _Property_c551a4d6fd90454c8320eac950ac91da_Out_0 = IsGammaSpace() ? LinearToSRGB(Color_1bf9c5e6f5c34360a490da1c94e6a7c1) : Color_1bf9c5e6f5c34360a490da1c94e6a7c1;
	float4 _Multiply_7499b43960a14a42bdb8aafd89235b59_Out_2;
	Unity_Multiply_float((_Power_3eee35aa9ed846d7a8ccf6fe2caa881f_Out_2.xxxx), _Property_c551a4d6fd90454c8320eac950ac91da_Out_0, _Multiply_7499b43960a14a42bdb8aafd89235b59_Out_2);
	float4 _Lerp_e45407912adb4284a451fec5b49c8abc_Out_3;
	Unity_Lerp_float4(_Multiply_f86d698f353e49b8ac4e704412805883_Out_2, _Multiply_7499b43960a14a42bdb8aafd89235b59_Out_2, (_Step_d74a28341b3b47d2b929db9c36d76662_Out_2.xxxx), _Lerp_e45407912adb4284a451fec5b49c8abc_Out_3);
	float4 _Add_7daf6aeef3334209844501eb66f273d6_Out_2;
	Unity_Add_float4(float4(0, 0, 0, 0), _Lerp_e45407912adb4284a451fec5b49c8abc_Out_3, _Add_7daf6aeef3334209844501eb66f273d6_Out_2);
	surface.BaseColor = (_Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3.xyz);
	surface.Emission = (_Add_7daf6aeef3334209844501eb66f273d6_Out_2.xyz);
	return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
	VertexDescriptionInputs output;
	ZERO_INITIALIZE(VertexDescriptionInputs, output);

	output.ObjectSpaceNormal = input.normalOS;
	output.ObjectSpaceTangent = input.tangentOS.xyz;
	output.ObjectSpacePosition = input.positionOS;

	return output;
}
	SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
	SurfaceDescriptionInputs output;
	ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
	float3 unnormalizedNormalWS = input.normalWS;
	const float renormFactor = 1.0 / length(unnormalizedNormalWS);


	output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
	output.ObjectSpaceNormal = normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale


	output.WorldSpaceViewDirection = input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
	output.ObjectSpaceViewDirection = TransformWorldToObjectDir(output.WorldSpaceViewDirection);
	output.uv0 = input.texCoord0;
	output.uv1 = input.texCoord1;
#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

	return output;
}

	// --------------------------------------------------
	// Main

	#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"

	ENDHLSL
}
Pass
{
		// Name: <None>
		Tags
		{
			"LightMode" = "Universal2D"
		}

		// Render State
		Cull Back
	Blend One Zero
	ZTest LEqual
	ZWrite On

		// Debug
		// <None>

		// --------------------------------------------------
		// Pass

		HLSLPROGRAM

		// Pragmas
		#pragma target 4.5
	#pragma exclude_renderers gles gles3 glcore
	#pragma vertex vert
	#pragma fragment frag

		// DotsInstancingOptions: <None>
		// HybridV1InjectedBuiltinProperties: <None>

		// Keywords
		// PassKeywords: <None>
		// GraphKeywords: <None>

		// Defines
		#define _NORMALMAP 1
		#define _NORMAL_DROPOFF_TS 1
		#define ATTRIBUTES_NEED_NORMAL
		#define ATTRIBUTES_NEED_TANGENT
		#define ATTRIBUTES_NEED_TEXCOORD0
		#define ATTRIBUTES_NEED_TEXCOORD1
		#define VARYINGS_NEED_TEXCOORD0
		#define VARYINGS_NEED_TEXCOORD1
		#define FEATURES_GRAPH_VERTEX
		/* WARNING: $splice Could not find named fragment 'PassInstancing' */
		#define SHADERPASS SHADERPASS_2D
		/* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

		// Includes
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

		// --------------------------------------------------
		// Structs and Packing

		struct Attributes
	{
		float3 positionOS : POSITION;
		float3 normalOS : NORMAL;
		float4 tangentOS : TANGENT;
		float4 uv0 : TEXCOORD0;
		float4 uv1 : TEXCOORD1;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : INSTANCEID_SEMANTIC;
		#endif
	};
	struct Varyings
	{
		float4 positionCS : SV_POSITION;
		float4 texCoord0;
		float4 texCoord1;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};
	struct SurfaceDescriptionInputs
	{
		float4 uv0;
		float4 uv1;
	};
	struct VertexDescriptionInputs
	{
		float3 ObjectSpaceNormal;
		float3 ObjectSpaceTangent;
		float3 ObjectSpacePosition;
	};
	struct PackedVaryings
	{
		float4 positionCS : SV_POSITION;
		float4 interp0 : TEXCOORD0;
		float4 interp1 : TEXCOORD1;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};

		PackedVaryings PackVaryings(Varyings input)
	{
		PackedVaryings output;
		output.positionCS = input.positionCS;
		output.interp0.xyzw = input.texCoord0;
		output.interp1.xyzw = input.texCoord1;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}
	Varyings UnpackVaryings(PackedVaryings input)
	{
		Varyings output;
		output.positionCS = input.positionCS;
		output.texCoord0 = input.interp0.xyzw;
		output.texCoord1 = input.interp1.xyzw;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}

	// --------------------------------------------------
	// Graph

	// Graph Properties
	CBUFFER_START(UnityPerMaterial)
float4 _BaseMap_TexelSize;
float4 _BaseColor;
float4 _MRAMap_TexelSize;
float _Smoothness;
float _OcclusionStrength;
float4 _BumpMap_TexelSize;
float4 _EmissionColor;
float Vector1_f104b915aaef41b69539acbf337f0b81;
float4 _CheekMap_TexelSize;
float4 Vector4_700df69d953c4e0e8d13cc36c1e28d41;
float4 _LipMap_TexelSize;
float4 Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1;
float4 _EyeShadowMap_TexelSize;
float4 Vector4_79165151a1a14973895d00e05edb1141;
float4 _PupilMap_TexelSize;
float4 Vector4_3c5a0575ad994c0484082879b48be7eb;
float4 _MaskMap_TexelSize;
float Vector1_7bf270fe91494824b4209d2dc1faae23;
float Vector1_0de750b9c41b4a5daef844a1599f5ac7;
float Vector1_2871f666316541908d110962eef07f02;
float Vector1_b5cc7f6f25194a778cb438f45fbbce66;
float Vector1_8e760635099b4147956bb9600d13cac2;
float4 _GlitterMap_TexelSize;
float2 Vector2_55edcb19ba1d459dbb3c027e66abbc1e;
float Vector1_f6677799b193415b8be7686b658a6e85;
float4 Color_1bf9c5e6f5c34360a490da1c94e6a7c1;
float Vector1_353a19306a364e939d35b1adffceaf21;
float Vector1_9e8e677800b644e19c377f91787c52f4;
float4 Texture2D_f176501ab1eb4c009adb04a9e3357df5_TexelSize;
float Vector1_8198268cf31e477b821e90f882ffb838;
float4 Color_4411c24bb9114a90bac0609a3e38417f;
float4 Color_3d38e1bc34e4408ca62ad21c702a4991;
float2 Vector2_d7f0b0cac82442babeaa593fef472e04;
float Vector1_f66b7945f53b4d85aa034d136a32a8b2;
CBUFFER_END

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_BaseMap);
SAMPLER(sampler_BaseMap);
TEXTURE2D(_MRAMap);
SAMPLER(sampler_MRAMap);
TEXTURE2D(_BumpMap);
SAMPLER(sampler_BumpMap);
TEXTURE2D(_CheekMap);
SAMPLER(sampler_CheekMap);
TEXTURE2D(_LipMap);
SAMPLER(sampler_LipMap);
TEXTURE2D(_EyeShadowMap);
SAMPLER(sampler_EyeShadowMap);
TEXTURE2D(_PupilMap);
SAMPLER(sampler_PupilMap);
TEXTURE2D(_MaskMap);
SAMPLER(sampler_MaskMap);
TEXTURE2D(_GlitterMap);
SAMPLER(sampler_GlitterMap);
TEXTURE2D(Texture2D_f176501ab1eb4c009adb04a9e3357df5);
SAMPLER(samplerTexture2D_f176501ab1eb4c009adb04a9e3357df5);

// Graph Functions

void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
{
	Out = A * B;
}

void Unity_Add_float(float A, float B, out float Out)
{
	Out = A + B;
}

void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
{
	RGBA = float4(R, G, B, A);
	RGB = float3(R, G, B);
	RG = float2(R, G);
}

void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
{
	Out = lerp(A, B, T);
}

void Unity_OneMinus_float(float In, out float Out)
{
	Out = 1 - In;
}


float2 Unity_GradientNoise_Dir_float(float2 p)
{
	// Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
	p = p % 289;
	// need full precision, otherwise half overflows when p > 1
	float x = float(34 * p.x + 1) * p.x % 289 + p.y;
	x = (34 * x + 1) * x % 289;
	x = frac(x / 41) * 2 - 1;
	return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
}

void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
{
	float2 p = UV * Scale;
	float2 ip = floor(p);
	float2 fp = frac(p);
	float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
	float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
	float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
	float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
	fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
	Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
}

void Unity_Multiply_float(float A, float B, out float Out)
{
	Out = A * B;
}

void Unity_Step_float(float Edge, float In, out float Out)
{
	Out = step(Edge, In);
}

// Graph Vertex
struct VertexDescription
{
	float3 Position;
	float3 Normal;
	float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
	VertexDescription description = (VertexDescription)0;
	description.Position = IN.ObjectSpacePosition;
	description.Normal = IN.ObjectSpaceNormal;
	description.Tangent = IN.ObjectSpaceTangent;
	return description;
}

// Graph Pixel
struct SurfaceDescription
{
	float3 BaseColor;
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
	SurfaceDescription surface = (SurfaceDescription)0;
	UnityTexture2D _Property_46f41194bebd49dd90523a9187559d47_Out_0 = UnityBuildTexture2DStructNoScale(_BaseMap);
	float4 _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0 = SAMPLE_TEXTURE2D(_Property_46f41194bebd49dd90523a9187559d47_Out_0.tex, _Property_46f41194bebd49dd90523a9187559d47_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_R_4 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.r;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_G_5 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.g;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_B_6 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.b;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_A_7 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.a;
	float4 _Property_3cc81970230a4e2680f1056abe28f14c_Out_0 = _BaseColor;
	float4 _Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2;
	Unity_Multiply_float(_SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0, _Property_3cc81970230a4e2680f1056abe28f14c_Out_0, _Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2);
	UnityTexture2D _Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0 = UnityBuildTexture2DStructNoScale(_CheekMap);
	float4 _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0 = Vector4_700df69d953c4e0e8d13cc36c1e28d41;
	float _Split_5022297589804f21900b69c657b81fa0_R_1 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[0];
	float _Split_5022297589804f21900b69c657b81fa0_G_2 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[1];
	float _Split_5022297589804f21900b69c657b81fa0_B_3 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[2];
	float _Split_5022297589804f21900b69c657b81fa0_A_4 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[3];
	float4 _UV_5c27d34f7fe0493fa46cacf01b32cccc_Out_0 = IN.uv1;
	float4 _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2;
	Unity_Multiply_float((_Split_5022297589804f21900b69c657b81fa0_R_1.xxxx), _UV_5c27d34f7fe0493fa46cacf01b32cccc_Out_0, _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2);
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_R_1 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[0];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_G_2 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[1];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_B_3 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[2];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_A_4 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[3];
	float _Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2;
	Unity_Add_float(_Split_5022297589804f21900b69c657b81fa0_G_2, _Split_f75341ed066d43c2ba64dd1807c3cdd5_R_1, _Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2);
	float _Add_b8d09a71819044be96521761cc153267_Out_2;
	Unity_Add_float(_Split_f75341ed066d43c2ba64dd1807c3cdd5_G_2, _Split_5022297589804f21900b69c657b81fa0_B_3, _Add_b8d09a71819044be96521761cc153267_Out_2);
	float4 _Combine_0939f9cc49e54d3ea511e937525deee6_RGBA_4;
	float3 _Combine_0939f9cc49e54d3ea511e937525deee6_RGB_5;
	float2 _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6;
	Unity_Combine_float(_Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2, _Add_b8d09a71819044be96521761cc153267_Out_2, 0, 0, _Combine_0939f9cc49e54d3ea511e937525deee6_RGBA_4, _Combine_0939f9cc49e54d3ea511e937525deee6_RGB_5, _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6);
	float4 _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0 = SAMPLE_TEXTURE2D(_Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0.tex, _Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0.samplerstate, _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6);
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_R_4 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.r;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_G_5 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.g;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_B_6 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.b;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_A_7 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.a;
	float4 _Lerp_2241ae8feb5941da9183bb461c252132_Out_3;
	Unity_Lerp_float4(_Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2, _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0, (_SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_A_7.xxxx), _Lerp_2241ae8feb5941da9183bb461c252132_Out_3);
	UnityTexture2D _Property_5f8a386b21984e2988fde7598f635a9a_Out_0 = UnityBuildTexture2DStructNoScale(_LipMap);
	float4 _Property_c857b47c21154b86a27f46398299df91_Out_0 = Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1;
	float _Split_f308ae64287f48e8872c952e6828cb36_R_1 = _Property_c857b47c21154b86a27f46398299df91_Out_0[0];
	float _Split_f308ae64287f48e8872c952e6828cb36_G_2 = _Property_c857b47c21154b86a27f46398299df91_Out_0[1];
	float _Split_f308ae64287f48e8872c952e6828cb36_B_3 = _Property_c857b47c21154b86a27f46398299df91_Out_0[2];
	float _Split_f308ae64287f48e8872c952e6828cb36_A_4 = _Property_c857b47c21154b86a27f46398299df91_Out_0[3];
	float4 _UV_c1af69e74f4e4df791b33b8f07716d5b_Out_0 = IN.uv1;
	float4 _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2;
	Unity_Multiply_float((_Split_f308ae64287f48e8872c952e6828cb36_R_1.xxxx), _UV_c1af69e74f4e4df791b33b8f07716d5b_Out_0, _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2);
	float _Split_3123c7f71f9749b2aa01689ddefb9374_R_1 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[0];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_G_2 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[1];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_B_3 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[2];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_A_4 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[3];
	float _Add_f2f7dee5f2844fb8822bccad48406ade_Out_2;
	Unity_Add_float(_Split_f308ae64287f48e8872c952e6828cb36_G_2, _Split_3123c7f71f9749b2aa01689ddefb9374_R_1, _Add_f2f7dee5f2844fb8822bccad48406ade_Out_2);
	float _Add_5287d7b9aac546af90e5e834b37567d2_Out_2;
	Unity_Add_float(_Split_3123c7f71f9749b2aa01689ddefb9374_G_2, _Split_f308ae64287f48e8872c952e6828cb36_B_3, _Add_5287d7b9aac546af90e5e834b37567d2_Out_2);
	float4 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGBA_4;
	float3 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGB_5;
	float2 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6;
	Unity_Combine_float(_Add_f2f7dee5f2844fb8822bccad48406ade_Out_2, _Add_5287d7b9aac546af90e5e834b37567d2_Out_2, 0, 0, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGBA_4, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGB_5, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6);
	float4 _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_5f8a386b21984e2988fde7598f635a9a_Out_0.tex, _Property_5f8a386b21984e2988fde7598f635a9a_Out_0.samplerstate, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6);
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_R_4 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.r;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_G_5 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.g;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_B_6 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.b;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_A_7 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.a;
	float4 _Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3;
	Unity_Lerp_float4(_Lerp_2241ae8feb5941da9183bb461c252132_Out_3, _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0, (_SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_A_7.xxxx), _Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3);
	UnityTexture2D _Property_034f7053a4c04630b179945137478563_Out_0 = UnityBuildTexture2DStructNoScale(_EyeShadowMap);
	float4 _Property_ec0501c48b2f47fca24e4415b083a817_Out_0 = Vector4_79165151a1a14973895d00e05edb1141;
	float _Split_a65775607697471ebf0abd88cba1cc94_R_1 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[0];
	float _Split_a65775607697471ebf0abd88cba1cc94_G_2 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[1];
	float _Split_a65775607697471ebf0abd88cba1cc94_B_3 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[2];
	float _Split_a65775607697471ebf0abd88cba1cc94_A_4 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[3];
	float4 _UV_561d401f6e7242d99119d7be74ed408f_Out_0 = IN.uv1;
	float4 _Multiply_9434dd79d3204d6f97de52affd770331_Out_2;
	Unity_Multiply_float((_Split_a65775607697471ebf0abd88cba1cc94_R_1.xxxx), _UV_561d401f6e7242d99119d7be74ed408f_Out_0, _Multiply_9434dd79d3204d6f97de52affd770331_Out_2);
	float _Split_48b01121140e4699b1b0d4a54f925206_R_1 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[0];
	float _Split_48b01121140e4699b1b0d4a54f925206_G_2 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[1];
	float _Split_48b01121140e4699b1b0d4a54f925206_B_3 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[2];
	float _Split_48b01121140e4699b1b0d4a54f925206_A_4 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[3];
	float _Add_70cfb275974e4ed78884eb9ddb51407c_Out_2;
	Unity_Add_float(_Split_a65775607697471ebf0abd88cba1cc94_G_2, _Split_48b01121140e4699b1b0d4a54f925206_R_1, _Add_70cfb275974e4ed78884eb9ddb51407c_Out_2);
	float _Add_bf85759250cd46a5a834e59e8174d47f_Out_2;
	Unity_Add_float(_Split_48b01121140e4699b1b0d4a54f925206_G_2, _Split_a65775607697471ebf0abd88cba1cc94_B_3, _Add_bf85759250cd46a5a834e59e8174d47f_Out_2);
	float4 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGBA_4;
	float3 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGB_5;
	float2 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6;
	Unity_Combine_float(_Add_70cfb275974e4ed78884eb9ddb51407c_Out_2, _Add_bf85759250cd46a5a834e59e8174d47f_Out_2, 0, 0, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGBA_4, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGB_5, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6);
	float4 _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0 = SAMPLE_TEXTURE2D(_Property_034f7053a4c04630b179945137478563_Out_0.tex, _Property_034f7053a4c04630b179945137478563_Out_0.samplerstate, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6);
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_R_4 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.r;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_G_5 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.g;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_B_6 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.b;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_A_7 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.a;
	float4 _Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3;
	Unity_Lerp_float4(_Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3, _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0, (_SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_A_7.xxxx), _Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3);
	UnityTexture2D _Property_f0ad144d6d604946a0265c0ff45af34a_Out_0 = UnityBuildTexture2DStructNoScale(_PupilMap);
	float4 _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0 = Vector4_3c5a0575ad994c0484082879b48be7eb;
	float _Split_597b0aa14ac147bb8547d10058ea208e_R_1 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[0];
	float _Split_597b0aa14ac147bb8547d10058ea208e_G_2 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[1];
	float _Split_597b0aa14ac147bb8547d10058ea208e_B_3 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[2];
	float _Split_597b0aa14ac147bb8547d10058ea208e_A_4 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[3];
	float4 _UV_fa01ab9e6ed045c0932df0bd20747d29_Out_0 = IN.uv1;
	float4 _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2;
	Unity_Multiply_float((_Split_597b0aa14ac147bb8547d10058ea208e_R_1.xxxx), _UV_fa01ab9e6ed045c0932df0bd20747d29_Out_0, _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2);
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_R_1 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[0];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_G_2 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[1];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_B_3 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[2];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_A_4 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[3];
	float _Add_8655d6d32b1b40259250182a69e8b8b7_Out_2;
	Unity_Add_float(_Split_597b0aa14ac147bb8547d10058ea208e_G_2, _Split_6051d27c6349400fbb5a5932d8d2c7ad_R_1, _Add_8655d6d32b1b40259250182a69e8b8b7_Out_2);
	float _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2;
	Unity_Add_float(_Split_6051d27c6349400fbb5a5932d8d2c7ad_G_2, _Split_597b0aa14ac147bb8547d10058ea208e_B_3, _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2);
	float4 _Combine_3c3cf19616e143188639a90935b8a10b_RGBA_4;
	float3 _Combine_3c3cf19616e143188639a90935b8a10b_RGB_5;
	float2 _Combine_3c3cf19616e143188639a90935b8a10b_RG_6;
	Unity_Combine_float(_Add_8655d6d32b1b40259250182a69e8b8b7_Out_2, _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2, 0, 0, _Combine_3c3cf19616e143188639a90935b8a10b_RGBA_4, _Combine_3c3cf19616e143188639a90935b8a10b_RGB_5, _Combine_3c3cf19616e143188639a90935b8a10b_RG_6);
	float4 _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0 = SAMPLE_TEXTURE2D(_Property_f0ad144d6d604946a0265c0ff45af34a_Out_0.tex, _Property_f0ad144d6d604946a0265c0ff45af34a_Out_0.samplerstate, _Combine_3c3cf19616e143188639a90935b8a10b_RG_6);
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_R_4 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.r;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_G_5 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.g;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_B_6 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.b;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_A_7 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.a;
	float4 _Lerp_9134832094eb464f874ea325fccb805d_Out_3;
	Unity_Lerp_float4(_Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3, _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0, (_SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_A_7.xxxx), _Lerp_9134832094eb464f874ea325fccb805d_Out_3);
	UnityTexture2D _Property_33d05c2bee3a48cbad54c88a071627d0_Out_0 = UnityBuildTexture2DStructNoScale(_MaskMap);
	float4 _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0 = SAMPLE_TEXTURE2D(_Property_33d05c2bee3a48cbad54c88a071627d0_Out_0.tex, _Property_33d05c2bee3a48cbad54c88a071627d0_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_R_4 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.r;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_G_5 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.g;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_B_6 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.b;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_A_7 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.a;
	UnityTexture2D _Property_90c3e617459146b89270ca735ff67027_Out_0 = UnityBuildTexture2DStructNoScale(_MaskMap);
	float4 _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0 = SAMPLE_TEXTURE2D(_Property_90c3e617459146b89270ca735ff67027_Out_0.tex, _Property_90c3e617459146b89270ca735ff67027_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_R_4 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.r;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_G_5 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.g;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_B_6 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.b;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.a;
	float _OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1;
	Unity_OneMinus_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1);
	float _Property_1a86dcb475f34e9c8bb3d74526142f51_Out_0 = Vector1_2871f666316541908d110962eef07f02;
	float _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2;
	Unity_GradientNoise_float(IN.uv0.xy, _Property_1a86dcb475f34e9c8bb3d74526142f51_Out_0, _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2);
	float _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2;
	Unity_Multiply_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2, _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2);
	float _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2;
	Unity_Add_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2, _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2);
	float _Step_d74a28341b3b47d2b929db9c36d76662_Out_2;
	Unity_Step_float(_OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1, _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2, _Step_d74a28341b3b47d2b929db9c36d76662_Out_2);
	float4 _Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3;
	Unity_Lerp_float4(_Lerp_9134832094eb464f874ea325fccb805d_Out_3, _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0, (_Step_d74a28341b3b47d2b929db9c36d76662_Out_2.xxxx), _Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3);
	surface.BaseColor = (_Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3.xyz);
	return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
	VertexDescriptionInputs output;
	ZERO_INITIALIZE(VertexDescriptionInputs, output);

	output.ObjectSpaceNormal = input.normalOS;
	output.ObjectSpaceTangent = input.tangentOS.xyz;
	output.ObjectSpacePosition = input.positionOS;

	return output;
}
	SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
	SurfaceDescriptionInputs output;
	ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





	output.uv0 = input.texCoord0;
	output.uv1 = input.texCoord1;
#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

	return output;
}

	// --------------------------------------------------
	// Main

	#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"

	ENDHLSL
}
	}
		SubShader
	{
		Tags
		{
			"RenderPipeline" = "UniversalPipeline"
			"RenderType" = "Opaque"
			"UniversalMaterialType" = "Lit"
			"Queue" = "Geometry"
		}
		Pass
		{
			Name "Universal Forward"
			Tags
			{
				"LightMode" = "UniversalForward"
			}

		// Render State
		Cull Back
	Blend One Zero
	ZTest LEqual
	ZWrite On

		// Debug
		// <None>

		// --------------------------------------------------
		// Pass

		HLSLPROGRAM

		// Pragmas
		#pragma target 2.0
	#pragma only_renderers gles gles3 glcore d3d11
	#pragma multi_compile_instancing
	#pragma multi_compile_fog
	#pragma vertex vert
	#pragma fragment frag

		// DotsInstancingOptions: <None>
		// HybridV1InjectedBuiltinProperties: <None>

		// Keywords
		#pragma multi_compile _ _SCREEN_SPACE_OCCLUSION
	#pragma multi_compile _ LIGHTMAP_ON
	#pragma multi_compile _ DIRLIGHTMAP_COMBINED
	#pragma multi_compile _ _MAIN_LIGHT_SHADOWS
	#pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
	#pragma multi_compile _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS _ADDITIONAL_OFF
	#pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
	#pragma multi_compile _ _SHADOWS_SOFT
	#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
	#pragma multi_compile _ SHADOWS_SHADOWMASK
		// GraphKeywords: <None>

		// Defines
		#define _NORMALMAP 1
		#define _NORMAL_DROPOFF_TS 1
		#define ATTRIBUTES_NEED_NORMAL
		#define ATTRIBUTES_NEED_TANGENT
		#define ATTRIBUTES_NEED_TEXCOORD0
		#define ATTRIBUTES_NEED_TEXCOORD1
		#define VARYINGS_NEED_POSITION_WS
		#define VARYINGS_NEED_NORMAL_WS
		#define VARYINGS_NEED_TANGENT_WS
		#define VARYINGS_NEED_TEXCOORD0
		#define VARYINGS_NEED_TEXCOORD1
		#define VARYINGS_NEED_VIEWDIRECTION_WS
		#define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
		#define FEATURES_GRAPH_VERTEX
		/* WARNING: $splice Could not find named fragment 'PassInstancing' */
		#define SHADERPASS SHADERPASS_FORWARD
		/* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

		// Includes
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

		// --------------------------------------------------
		// Structs and Packing

		struct Attributes
	{
		float3 positionOS : POSITION;
		float3 normalOS : NORMAL;
		float4 tangentOS : TANGENT;
		float4 uv0 : TEXCOORD0;
		float4 uv1 : TEXCOORD1;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : INSTANCEID_SEMANTIC;
		#endif
	};
	struct Varyings
	{
		float4 positionCS : SV_POSITION;
		float3 positionWS;
		float3 normalWS;
		float4 tangentWS;
		float4 texCoord0;
		float4 texCoord1;
		float3 viewDirectionWS;
		#if defined(LIGHTMAP_ON)
		float2 lightmapUV;
		#endif
		#if !defined(LIGHTMAP_ON)
		float3 sh;
		#endif
		float4 fogFactorAndVertexLight;
		float4 shadowCoord;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};
	struct SurfaceDescriptionInputs
	{
		float3 ObjectSpaceNormal;
		float3 WorldSpaceNormal;
		float3 TangentSpaceNormal;
		float3 WorldSpaceTangent;
		float3 WorldSpaceBiTangent;
		float3 ObjectSpaceViewDirection;
		float3 WorldSpaceViewDirection;
		float3 WorldSpacePosition;
		float4 uv0;
		float4 uv1;
	};
	struct VertexDescriptionInputs
	{
		float3 ObjectSpaceNormal;
		float3 ObjectSpaceTangent;
		float3 ObjectSpacePosition;
	};
	struct PackedVaryings
	{
		float4 positionCS : SV_POSITION;
		float3 interp0 : TEXCOORD0;
		float3 interp1 : TEXCOORD1;
		float4 interp2 : TEXCOORD2;
		float4 interp3 : TEXCOORD3;
		float4 interp4 : TEXCOORD4;
		float3 interp5 : TEXCOORD5;
		#if defined(LIGHTMAP_ON)
		float2 interp6 : TEXCOORD6;
		#endif
		#if !defined(LIGHTMAP_ON)
		float3 interp7 : TEXCOORD7;
		#endif
		float4 interp8 : TEXCOORD8;
		float4 interp9 : TEXCOORD9;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};

		PackedVaryings PackVaryings(Varyings input)
	{
		PackedVaryings output;
		output.positionCS = input.positionCS;
		output.interp0.xyz = input.positionWS;
		output.interp1.xyz = input.normalWS;
		output.interp2.xyzw = input.tangentWS;
		output.interp3.xyzw = input.texCoord0;
		output.interp4.xyzw = input.texCoord1;
		output.interp5.xyz = input.viewDirectionWS;
		#if defined(LIGHTMAP_ON)
		output.interp6.xy = input.lightmapUV;
		#endif
		#if !defined(LIGHTMAP_ON)
		output.interp7.xyz = input.sh;
		#endif
		output.interp8.xyzw = input.fogFactorAndVertexLight;
		output.interp9.xyzw = input.shadowCoord;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}
	Varyings UnpackVaryings(PackedVaryings input)
	{
		Varyings output;
		output.positionCS = input.positionCS;
		output.positionWS = input.interp0.xyz;
		output.normalWS = input.interp1.xyz;
		output.tangentWS = input.interp2.xyzw;
		output.texCoord0 = input.interp3.xyzw;
		output.texCoord1 = input.interp4.xyzw;
		output.viewDirectionWS = input.interp5.xyz;
		#if defined(LIGHTMAP_ON)
		output.lightmapUV = input.interp6.xy;
		#endif
		#if !defined(LIGHTMAP_ON)
		output.sh = input.interp7.xyz;
		#endif
		output.fogFactorAndVertexLight = input.interp8.xyzw;
		output.shadowCoord = input.interp9.xyzw;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}

	// --------------------------------------------------
	// Graph

	// Graph Properties
	CBUFFER_START(UnityPerMaterial)
float4 _BaseMap_TexelSize;
float4 _BaseColor;
float4 _MRAMap_TexelSize;
float _Smoothness;
float _OcclusionStrength;
float4 _BumpMap_TexelSize;
float4 _EmissionColor;
float Vector1_f104b915aaef41b69539acbf337f0b81;
float4 _CheekMap_TexelSize;
float4 Vector4_700df69d953c4e0e8d13cc36c1e28d41;
float4 _LipMap_TexelSize;
float4 Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1;
float4 _EyeShadowMap_TexelSize;
float4 Vector4_79165151a1a14973895d00e05edb1141;
float4 _PupilMap_TexelSize;
float4 Vector4_3c5a0575ad994c0484082879b48be7eb;
float4 _MaskMap_TexelSize;
float Vector1_7bf270fe91494824b4209d2dc1faae23;
float Vector1_0de750b9c41b4a5daef844a1599f5ac7;
float Vector1_2871f666316541908d110962eef07f02;
float Vector1_b5cc7f6f25194a778cb438f45fbbce66;
float Vector1_8e760635099b4147956bb9600d13cac2;
float4 _GlitterMap_TexelSize;
float2 Vector2_55edcb19ba1d459dbb3c027e66abbc1e;
float Vector1_f6677799b193415b8be7686b658a6e85;
float4 Color_1bf9c5e6f5c34360a490da1c94e6a7c1;
float Vector1_353a19306a364e939d35b1adffceaf21;
float Vector1_9e8e677800b644e19c377f91787c52f4;
float4 Texture2D_f176501ab1eb4c009adb04a9e3357df5_TexelSize;
float Vector1_8198268cf31e477b821e90f882ffb838;
float4 Color_4411c24bb9114a90bac0609a3e38417f;
float4 Color_3d38e1bc34e4408ca62ad21c702a4991;
float2 Vector2_d7f0b0cac82442babeaa593fef472e04;
float Vector1_f66b7945f53b4d85aa034d136a32a8b2;
CBUFFER_END

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_BaseMap);
SAMPLER(sampler_BaseMap);
TEXTURE2D(_MRAMap);
SAMPLER(sampler_MRAMap);
TEXTURE2D(_BumpMap);
SAMPLER(sampler_BumpMap);
TEXTURE2D(_CheekMap);
SAMPLER(sampler_CheekMap);
TEXTURE2D(_LipMap);
SAMPLER(sampler_LipMap);
TEXTURE2D(_EyeShadowMap);
SAMPLER(sampler_EyeShadowMap);
TEXTURE2D(_PupilMap);
SAMPLER(sampler_PupilMap);
TEXTURE2D(_MaskMap);
SAMPLER(sampler_MaskMap);
TEXTURE2D(_GlitterMap);
SAMPLER(sampler_GlitterMap);
TEXTURE2D(Texture2D_f176501ab1eb4c009adb04a9e3357df5);
SAMPLER(samplerTexture2D_f176501ab1eb4c009adb04a9e3357df5);

// Graph Functions

void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
{
	Out = A * B;
}

void Unity_Add_float(float A, float B, out float Out)
{
	Out = A + B;
}

void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
{
	RGBA = float4(R, G, B, A);
	RGB = float3(R, G, B);
	RG = float2(R, G);
}

void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
{
	Out = lerp(A, B, T);
}

void Unity_OneMinus_float(float In, out float Out)
{
	Out = 1 - In;
}


float2 Unity_GradientNoise_Dir_float(float2 p)
{
	// Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
	p = p % 289;
	// need full precision, otherwise half overflows when p > 1
	float x = float(34 * p.x + 1) * p.x % 289 + p.y;
	x = (34 * x + 1) * x % 289;
	x = frac(x / 41) * 2 - 1;
	return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
}

void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
{
	float2 p = UV * Scale;
	float2 ip = floor(p);
	float2 fp = frac(p);
	float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
	float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
	float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
	float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
	fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
	Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
}

void Unity_Multiply_float(float A, float B, out float Out)
{
	Out = A * B;
}

void Unity_Step_float(float Edge, float In, out float Out)
{
	Out = step(Edge, In);
}

void Unity_NormalUnpack_float(float4 In, out float3 Out)
{
				Out = UnpackNormal(In);
			}

void Unity_Lerp_float(float A, float B, float T, out float Out)
{
	Out = lerp(A, B, T);
}

void Unity_NormalFromHeight_Tangent_float(float In, float Strength, float3 Position, float3x3 TangentMatrix, out float3 Out)
{
	float3 worldDerivativeX = ddx(Position);
	float3 worldDerivativeY = ddy(Position);

	float3 crossX = cross(TangentMatrix[2].xyz, worldDerivativeX);
	float3 crossY = cross(worldDerivativeY, TangentMatrix[2].xyz);
	float d = dot(worldDerivativeX, crossY);
	float sgn = d < 0.0 ? (-1.0f) : 1.0f;
	float surface = sgn / max(0.000000000000001192093f, abs(d));

	float dHdx = ddx(In);
	float dHdy = ddy(In);
	float3 surfGrad = surface * (dHdx*crossY + dHdy * crossX);
	Out = SafeNormalize(TangentMatrix[2].xyz - (Strength * surfGrad));
	Out = TransformWorldToTangent(Out, TangentMatrix);
}

void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
{
	Out = lerp(A, B, T);
}

void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
{
	Out = UV * Tiling + Offset;
}

void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
{
	Out = A - B;
}

void Unity_Normalize_float3(float3 In, out float3 Out)
{
	Out = normalize(In);
}

void Unity_Add_float3(float3 A, float3 B, out float3 Out)
{
	Out = A + B;
}

void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
{
	Out = dot(A, B);
}

void Unity_Saturate_float(float In, out float Out)
{
	Out = saturate(In);
}

void Unity_Exponential2_float(float In, out float Out)
{
	Out = exp2(In);
}

void Unity_Power_float(float A, float B, out float Out)
{
	Out = pow(A, B);
}

void Unity_Add_float4(float4 A, float4 B, out float4 Out)
{
	Out = A + B;
}

void Unity_Subtract_float(float A, float B, out float Out)
{
	Out = A - B;
}

// Graph Vertex
struct VertexDescription
{
	float3 Position;
	float3 Normal;
	float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
	VertexDescription description = (VertexDescription)0;
	description.Position = IN.ObjectSpacePosition;
	description.Normal = IN.ObjectSpaceNormal;
	description.Tangent = IN.ObjectSpaceTangent;
	return description;
}

// Graph Pixel
struct SurfaceDescription
{
	float3 BaseColor;
	float3 NormalTS;
	float3 Emission;
	float Metallic;
	float Smoothness;
	float Occlusion;
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
	SurfaceDescription surface = (SurfaceDescription)0;
	UnityTexture2D _Property_46f41194bebd49dd90523a9187559d47_Out_0 = UnityBuildTexture2DStructNoScale(_BaseMap);
	float4 _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0 = SAMPLE_TEXTURE2D(_Property_46f41194bebd49dd90523a9187559d47_Out_0.tex, _Property_46f41194bebd49dd90523a9187559d47_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_R_4 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.r;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_G_5 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.g;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_B_6 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.b;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_A_7 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.a;
	float4 _Property_3cc81970230a4e2680f1056abe28f14c_Out_0 = _BaseColor;
	float4 _Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2;
	Unity_Multiply_float(_SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0, _Property_3cc81970230a4e2680f1056abe28f14c_Out_0, _Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2);
	UnityTexture2D _Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0 = UnityBuildTexture2DStructNoScale(_CheekMap);
	float4 _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0 = Vector4_700df69d953c4e0e8d13cc36c1e28d41;
	float _Split_5022297589804f21900b69c657b81fa0_R_1 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[0];
	float _Split_5022297589804f21900b69c657b81fa0_G_2 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[1];
	float _Split_5022297589804f21900b69c657b81fa0_B_3 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[2];
	float _Split_5022297589804f21900b69c657b81fa0_A_4 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[3];
	float4 _UV_5c27d34f7fe0493fa46cacf01b32cccc_Out_0 = IN.uv1;
	float4 _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2;
	Unity_Multiply_float((_Split_5022297589804f21900b69c657b81fa0_R_1.xxxx), _UV_5c27d34f7fe0493fa46cacf01b32cccc_Out_0, _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2);
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_R_1 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[0];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_G_2 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[1];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_B_3 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[2];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_A_4 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[3];
	float _Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2;
	Unity_Add_float(_Split_5022297589804f21900b69c657b81fa0_G_2, _Split_f75341ed066d43c2ba64dd1807c3cdd5_R_1, _Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2);
	float _Add_b8d09a71819044be96521761cc153267_Out_2;
	Unity_Add_float(_Split_f75341ed066d43c2ba64dd1807c3cdd5_G_2, _Split_5022297589804f21900b69c657b81fa0_B_3, _Add_b8d09a71819044be96521761cc153267_Out_2);
	float4 _Combine_0939f9cc49e54d3ea511e937525deee6_RGBA_4;
	float3 _Combine_0939f9cc49e54d3ea511e937525deee6_RGB_5;
	float2 _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6;
	Unity_Combine_float(_Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2, _Add_b8d09a71819044be96521761cc153267_Out_2, 0, 0, _Combine_0939f9cc49e54d3ea511e937525deee6_RGBA_4, _Combine_0939f9cc49e54d3ea511e937525deee6_RGB_5, _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6);
	float4 _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0 = SAMPLE_TEXTURE2D(_Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0.tex, _Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0.samplerstate, _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6);
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_R_4 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.r;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_G_5 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.g;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_B_6 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.b;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_A_7 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.a;
	float4 _Lerp_2241ae8feb5941da9183bb461c252132_Out_3;
	Unity_Lerp_float4(_Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2, _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0, (_SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_A_7.xxxx), _Lerp_2241ae8feb5941da9183bb461c252132_Out_3);
	UnityTexture2D _Property_5f8a386b21984e2988fde7598f635a9a_Out_0 = UnityBuildTexture2DStructNoScale(_LipMap);
	float4 _Property_c857b47c21154b86a27f46398299df91_Out_0 = Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1;
	float _Split_f308ae64287f48e8872c952e6828cb36_R_1 = _Property_c857b47c21154b86a27f46398299df91_Out_0[0];
	float _Split_f308ae64287f48e8872c952e6828cb36_G_2 = _Property_c857b47c21154b86a27f46398299df91_Out_0[1];
	float _Split_f308ae64287f48e8872c952e6828cb36_B_3 = _Property_c857b47c21154b86a27f46398299df91_Out_0[2];
	float _Split_f308ae64287f48e8872c952e6828cb36_A_4 = _Property_c857b47c21154b86a27f46398299df91_Out_0[3];
	float4 _UV_c1af69e74f4e4df791b33b8f07716d5b_Out_0 = IN.uv1;
	float4 _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2;
	Unity_Multiply_float((_Split_f308ae64287f48e8872c952e6828cb36_R_1.xxxx), _UV_c1af69e74f4e4df791b33b8f07716d5b_Out_0, _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2);
	float _Split_3123c7f71f9749b2aa01689ddefb9374_R_1 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[0];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_G_2 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[1];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_B_3 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[2];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_A_4 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[3];
	float _Add_f2f7dee5f2844fb8822bccad48406ade_Out_2;
	Unity_Add_float(_Split_f308ae64287f48e8872c952e6828cb36_G_2, _Split_3123c7f71f9749b2aa01689ddefb9374_R_1, _Add_f2f7dee5f2844fb8822bccad48406ade_Out_2);
	float _Add_5287d7b9aac546af90e5e834b37567d2_Out_2;
	Unity_Add_float(_Split_3123c7f71f9749b2aa01689ddefb9374_G_2, _Split_f308ae64287f48e8872c952e6828cb36_B_3, _Add_5287d7b9aac546af90e5e834b37567d2_Out_2);
	float4 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGBA_4;
	float3 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGB_5;
	float2 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6;
	Unity_Combine_float(_Add_f2f7dee5f2844fb8822bccad48406ade_Out_2, _Add_5287d7b9aac546af90e5e834b37567d2_Out_2, 0, 0, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGBA_4, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGB_5, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6);
	float4 _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_5f8a386b21984e2988fde7598f635a9a_Out_0.tex, _Property_5f8a386b21984e2988fde7598f635a9a_Out_0.samplerstate, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6);
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_R_4 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.r;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_G_5 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.g;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_B_6 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.b;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_A_7 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.a;
	float4 _Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3;
	Unity_Lerp_float4(_Lerp_2241ae8feb5941da9183bb461c252132_Out_3, _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0, (_SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_A_7.xxxx), _Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3);
	UnityTexture2D _Property_034f7053a4c04630b179945137478563_Out_0 = UnityBuildTexture2DStructNoScale(_EyeShadowMap);
	float4 _Property_ec0501c48b2f47fca24e4415b083a817_Out_0 = Vector4_79165151a1a14973895d00e05edb1141;
	float _Split_a65775607697471ebf0abd88cba1cc94_R_1 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[0];
	float _Split_a65775607697471ebf0abd88cba1cc94_G_2 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[1];
	float _Split_a65775607697471ebf0abd88cba1cc94_B_3 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[2];
	float _Split_a65775607697471ebf0abd88cba1cc94_A_4 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[3];
	float4 _UV_561d401f6e7242d99119d7be74ed408f_Out_0 = IN.uv1;
	float4 _Multiply_9434dd79d3204d6f97de52affd770331_Out_2;
	Unity_Multiply_float((_Split_a65775607697471ebf0abd88cba1cc94_R_1.xxxx), _UV_561d401f6e7242d99119d7be74ed408f_Out_0, _Multiply_9434dd79d3204d6f97de52affd770331_Out_2);
	float _Split_48b01121140e4699b1b0d4a54f925206_R_1 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[0];
	float _Split_48b01121140e4699b1b0d4a54f925206_G_2 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[1];
	float _Split_48b01121140e4699b1b0d4a54f925206_B_3 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[2];
	float _Split_48b01121140e4699b1b0d4a54f925206_A_4 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[3];
	float _Add_70cfb275974e4ed78884eb9ddb51407c_Out_2;
	Unity_Add_float(_Split_a65775607697471ebf0abd88cba1cc94_G_2, _Split_48b01121140e4699b1b0d4a54f925206_R_1, _Add_70cfb275974e4ed78884eb9ddb51407c_Out_2);
	float _Add_bf85759250cd46a5a834e59e8174d47f_Out_2;
	Unity_Add_float(_Split_48b01121140e4699b1b0d4a54f925206_G_2, _Split_a65775607697471ebf0abd88cba1cc94_B_3, _Add_bf85759250cd46a5a834e59e8174d47f_Out_2);
	float4 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGBA_4;
	float3 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGB_5;
	float2 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6;
	Unity_Combine_float(_Add_70cfb275974e4ed78884eb9ddb51407c_Out_2, _Add_bf85759250cd46a5a834e59e8174d47f_Out_2, 0, 0, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGBA_4, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGB_5, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6);
	float4 _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0 = SAMPLE_TEXTURE2D(_Property_034f7053a4c04630b179945137478563_Out_0.tex, _Property_034f7053a4c04630b179945137478563_Out_0.samplerstate, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6);
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_R_4 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.r;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_G_5 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.g;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_B_6 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.b;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_A_7 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.a;
	float4 _Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3;
	Unity_Lerp_float4(_Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3, _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0, (_SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_A_7.xxxx), _Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3);
	UnityTexture2D _Property_f0ad144d6d604946a0265c0ff45af34a_Out_0 = UnityBuildTexture2DStructNoScale(_PupilMap);
	float4 _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0 = Vector4_3c5a0575ad994c0484082879b48be7eb;
	float _Split_597b0aa14ac147bb8547d10058ea208e_R_1 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[0];
	float _Split_597b0aa14ac147bb8547d10058ea208e_G_2 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[1];
	float _Split_597b0aa14ac147bb8547d10058ea208e_B_3 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[2];
	float _Split_597b0aa14ac147bb8547d10058ea208e_A_4 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[3];
	float4 _UV_fa01ab9e6ed045c0932df0bd20747d29_Out_0 = IN.uv1;
	float4 _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2;
	Unity_Multiply_float((_Split_597b0aa14ac147bb8547d10058ea208e_R_1.xxxx), _UV_fa01ab9e6ed045c0932df0bd20747d29_Out_0, _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2);
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_R_1 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[0];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_G_2 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[1];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_B_3 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[2];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_A_4 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[3];
	float _Add_8655d6d32b1b40259250182a69e8b8b7_Out_2;
	Unity_Add_float(_Split_597b0aa14ac147bb8547d10058ea208e_G_2, _Split_6051d27c6349400fbb5a5932d8d2c7ad_R_1, _Add_8655d6d32b1b40259250182a69e8b8b7_Out_2);
	float _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2;
	Unity_Add_float(_Split_6051d27c6349400fbb5a5932d8d2c7ad_G_2, _Split_597b0aa14ac147bb8547d10058ea208e_B_3, _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2);
	float4 _Combine_3c3cf19616e143188639a90935b8a10b_RGBA_4;
	float3 _Combine_3c3cf19616e143188639a90935b8a10b_RGB_5;
	float2 _Combine_3c3cf19616e143188639a90935b8a10b_RG_6;
	Unity_Combine_float(_Add_8655d6d32b1b40259250182a69e8b8b7_Out_2, _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2, 0, 0, _Combine_3c3cf19616e143188639a90935b8a10b_RGBA_4, _Combine_3c3cf19616e143188639a90935b8a10b_RGB_5, _Combine_3c3cf19616e143188639a90935b8a10b_RG_6);
	float4 _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0 = SAMPLE_TEXTURE2D(_Property_f0ad144d6d604946a0265c0ff45af34a_Out_0.tex, _Property_f0ad144d6d604946a0265c0ff45af34a_Out_0.samplerstate, _Combine_3c3cf19616e143188639a90935b8a10b_RG_6);
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_R_4 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.r;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_G_5 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.g;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_B_6 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.b;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_A_7 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.a;
	float4 _Lerp_9134832094eb464f874ea325fccb805d_Out_3;
	Unity_Lerp_float4(_Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3, _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0, (_SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_A_7.xxxx), _Lerp_9134832094eb464f874ea325fccb805d_Out_3);
	UnityTexture2D _Property_33d05c2bee3a48cbad54c88a071627d0_Out_0 = UnityBuildTexture2DStructNoScale(_MaskMap);
	float4 _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0 = SAMPLE_TEXTURE2D(_Property_33d05c2bee3a48cbad54c88a071627d0_Out_0.tex, _Property_33d05c2bee3a48cbad54c88a071627d0_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_R_4 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.r;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_G_5 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.g;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_B_6 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.b;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_A_7 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.a;
	UnityTexture2D _Property_90c3e617459146b89270ca735ff67027_Out_0 = UnityBuildTexture2DStructNoScale(_MaskMap);
	float4 _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0 = SAMPLE_TEXTURE2D(_Property_90c3e617459146b89270ca735ff67027_Out_0.tex, _Property_90c3e617459146b89270ca735ff67027_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_R_4 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.r;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_G_5 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.g;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_B_6 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.b;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.a;
	float _OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1;
	Unity_OneMinus_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1);
	float _Property_1a86dcb475f34e9c8bb3d74526142f51_Out_0 = Vector1_2871f666316541908d110962eef07f02;
	float _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2;
	Unity_GradientNoise_float(IN.uv0.xy, _Property_1a86dcb475f34e9c8bb3d74526142f51_Out_0, _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2);
	float _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2;
	Unity_Multiply_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2, _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2);
	float _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2;
	Unity_Add_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2, _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2);
	float _Step_d74a28341b3b47d2b929db9c36d76662_Out_2;
	Unity_Step_float(_OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1, _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2, _Step_d74a28341b3b47d2b929db9c36d76662_Out_2);
	float4 _Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3;
	Unity_Lerp_float4(_Lerp_9134832094eb464f874ea325fccb805d_Out_3, _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0, (_Step_d74a28341b3b47d2b929db9c36d76662_Out_2.xxxx), _Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3);
	UnityTexture2D _Property_ef39b7e1c5c6465f842c5dfa050e47e1_Out_0 = UnityBuildTexture2DStructNoScale(_BumpMap);
	float4 _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0 = SAMPLE_TEXTURE2D(_Property_ef39b7e1c5c6465f842c5dfa050e47e1_Out_0.tex, _Property_ef39b7e1c5c6465f842c5dfa050e47e1_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_R_4 = _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0.r;
	float _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_G_5 = _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0.g;
	float _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_B_6 = _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0.b;
	float _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_A_7 = _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0.a;
	float3 _NormalUnpack_b1e6ba1d5cc34fc6bed28052e3d03168_Out_1;
	Unity_NormalUnpack_float(_SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0, _NormalUnpack_b1e6ba1d5cc34fc6bed28052e3d03168_Out_1);
	float _Property_7671b3b7eef84a8c9d7825a9036c8bff_Out_0 = Vector1_b5cc7f6f25194a778cb438f45fbbce66;
	float _GradientNoise_4be9f93cabe14a849abe7b8ed37b6bbd_Out_2;
	Unity_GradientNoise_float(IN.uv0.xy, _Property_7671b3b7eef84a8c9d7825a9036c8bff_Out_0, _GradientNoise_4be9f93cabe14a849abe7b8ed37b6bbd_Out_2);
	float _Add_3e0bbf4ee4904868940bafe39dd7423f_Out_2;
	Unity_Add_float(_GradientNoise_4be9f93cabe14a849abe7b8ed37b6bbd_Out_2, 0.3, _Add_3e0bbf4ee4904868940bafe39dd7423f_Out_2);
	float _Multiply_2e36cc2586dc491abb678f1f1cf3d350_Out_2;
	Unity_Multiply_float(_GradientNoise_4be9f93cabe14a849abe7b8ed37b6bbd_Out_2, _SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _Multiply_2e36cc2586dc491abb678f1f1cf3d350_Out_2);
	float _Lerp_c862be95f9354a0ab4024a518282ec79_Out_3;
	Unity_Lerp_float(0.3, _Add_3e0bbf4ee4904868940bafe39dd7423f_Out_2, _Multiply_2e36cc2586dc491abb678f1f1cf3d350_Out_2, _Lerp_c862be95f9354a0ab4024a518282ec79_Out_3);
	float _Property_6721bad2e28e4210a1fa01a48f73c858_Out_0 = Vector1_8e760635099b4147956bb9600d13cac2;
	float3 _NormalFromHeight_392055ed45084230899320a5058871be_Out_1;
	float3x3 _NormalFromHeight_392055ed45084230899320a5058871be_TangentMatrix = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
	float3 _NormalFromHeight_392055ed45084230899320a5058871be_Position = IN.WorldSpacePosition;
	Unity_NormalFromHeight_Tangent_float(_Lerp_c862be95f9354a0ab4024a518282ec79_Out_3,_Property_6721bad2e28e4210a1fa01a48f73c858_Out_0,_NormalFromHeight_392055ed45084230899320a5058871be_Position,_NormalFromHeight_392055ed45084230899320a5058871be_TangentMatrix, _NormalFromHeight_392055ed45084230899320a5058871be_Out_1);
	float3 _Lerp_cfff89d8630c4d3b975d173579abd871_Out_3;
	Unity_Lerp_float3(_NormalUnpack_b1e6ba1d5cc34fc6bed28052e3d03168_Out_1, _NormalFromHeight_392055ed45084230899320a5058871be_Out_1, (_Step_d74a28341b3b47d2b929db9c36d76662_Out_2.xxx), _Lerp_cfff89d8630c4d3b975d173579abd871_Out_3);
	UnityTexture2D _Property_9e2e155797564e99b75bfe8d3f7be32d_Out_0 = UnityBuildTexture2DStructNoScale(_MRAMap);
	float4 _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0 = SAMPLE_TEXTURE2D(_Property_9e2e155797564e99b75bfe8d3f7be32d_Out_0.tex, _Property_9e2e155797564e99b75bfe8d3f7be32d_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_R_4 = _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0.r;
	float _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_G_5 = _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0.g;
	float _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_B_6 = _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0.b;
	float _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_A_7 = _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0.a;
	float4 _Property_b6f5177f3ae44d2cb157e753cff0343c_Out_0 = _EmissionColor;
	float4 _Multiply_8c3b33adad4c4e69a14a0843a37bf4d0_Out_2;
	Unity_Multiply_float((_SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_A_7.xxxx), _Property_b6f5177f3ae44d2cb157e753cff0343c_Out_0, _Multiply_8c3b33adad4c4e69a14a0843a37bf4d0_Out_2);
	float _Property_80e0e6200a1642e1884a71644e4682bf_Out_0 = Vector1_f104b915aaef41b69539acbf337f0b81;
	float4 _Multiply_f86d698f353e49b8ac4e704412805883_Out_2;
	Unity_Multiply_float(_Multiply_8c3b33adad4c4e69a14a0843a37bf4d0_Out_2, (_Property_80e0e6200a1642e1884a71644e4682bf_Out_0.xxxx), _Multiply_f86d698f353e49b8ac4e704412805883_Out_2);
	UnityTexture2D _Property_fe9310b7c4f2436d8e27d43b3fe188aa_Out_0 = UnityBuildTexture2DStructNoScale(_GlitterMap);
	float2 _Property_2032db54a42245aaa9312efadd4f15e3_Out_0 = Vector2_55edcb19ba1d459dbb3c027e66abbc1e;
	float2 _TilingAndOffset_721ed8d53fd54eef98ca2df1ba7cfdf5_Out_3;
	Unity_TilingAndOffset_float(IN.uv0.xy, _Property_2032db54a42245aaa9312efadd4f15e3_Out_0, float2 (0, 0), _TilingAndOffset_721ed8d53fd54eef98ca2df1ba7cfdf5_Out_3);
	float4 _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_fe9310b7c4f2436d8e27d43b3fe188aa_Out_0.tex, UnityBuildSamplerStateStruct(SamplerState_Point_Repeat).samplerstate, _TilingAndOffset_721ed8d53fd54eef98ca2df1ba7cfdf5_Out_3);
	float _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_R_4 = _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0.r;
	float _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_G_5 = _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0.g;
	float _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_B_6 = _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0.b;
	float _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_A_7 = _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0.a;
	float3 _Vector3_ed002c12350a46b69f196e5d728582cd_Out_0 = float3(_SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_R_4, _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_G_5, _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_B_6);
	float3 _Subtract_3a4ad3383c6f43b4825e534b6fcefded_Out_2;
	Unity_Subtract_float3(_Vector3_ed002c12350a46b69f196e5d728582cd_Out_0, float3(0.5, 0.5, 0.5), _Subtract_3a4ad3383c6f43b4825e534b6fcefded_Out_2);
	float3 _Normalize_956cacc929084d28952105a8c1bcea48_Out_1;
	Unity_Normalize_float3(_Subtract_3a4ad3383c6f43b4825e534b6fcefded_Out_2, _Normalize_956cacc929084d28952105a8c1bcea48_Out_1);
	float3 _Add_8543d53668cc40b5a1bc702cfb07701b_Out_2;
	Unity_Add_float3(_Normalize_956cacc929084d28952105a8c1bcea48_Out_1, IN.ObjectSpaceNormal, _Add_8543d53668cc40b5a1bc702cfb07701b_Out_2);
	float3 _Normalize_472c4ae9e2c94183aeab11d54efdf6e9_Out_1;
	Unity_Normalize_float3(_Add_8543d53668cc40b5a1bc702cfb07701b_Out_2, _Normalize_472c4ae9e2c94183aeab11d54efdf6e9_Out_1);
	float _DotProduct_ed89b1c6e5fa4f83ba62172883d90a01_Out_2;
	Unity_DotProduct_float3(_Normalize_472c4ae9e2c94183aeab11d54efdf6e9_Out_1, IN.ObjectSpaceViewDirection, _DotProduct_ed89b1c6e5fa4f83ba62172883d90a01_Out_2);
	float _Saturate_9dc8013924fd4863b579da0965a6c1e2_Out_1;
	Unity_Saturate_float(_DotProduct_ed89b1c6e5fa4f83ba62172883d90a01_Out_2, _Saturate_9dc8013924fd4863b579da0965a6c1e2_Out_1);
	float _Property_410af66ac63f4b6ca91752d4e6c8c4b1_Out_0 = Vector1_f6677799b193415b8be7686b658a6e85;
	float _Add_225974d87fe74eed99d56fbe9aea1572_Out_2;
	Unity_Add_float(_Property_410af66ac63f4b6ca91752d4e6c8c4b1_Out_0, 1, _Add_225974d87fe74eed99d56fbe9aea1572_Out_2);
	float _Exponential_8ae78e15f67946618ffb2645de1f1589_Out_1;
	Unity_Exponential2_float(_Add_225974d87fe74eed99d56fbe9aea1572_Out_2, _Exponential_8ae78e15f67946618ffb2645de1f1589_Out_1);
	float _Power_3eee35aa9ed846d7a8ccf6fe2caa881f_Out_2;
	Unity_Power_float(_Saturate_9dc8013924fd4863b579da0965a6c1e2_Out_1, _Exponential_8ae78e15f67946618ffb2645de1f1589_Out_1, _Power_3eee35aa9ed846d7a8ccf6fe2caa881f_Out_2);
	float4 _Property_c551a4d6fd90454c8320eac950ac91da_Out_0 = IsGammaSpace() ? LinearToSRGB(Color_1bf9c5e6f5c34360a490da1c94e6a7c1) : Color_1bf9c5e6f5c34360a490da1c94e6a7c1;
	float4 _Multiply_7499b43960a14a42bdb8aafd89235b59_Out_2;
	Unity_Multiply_float((_Power_3eee35aa9ed846d7a8ccf6fe2caa881f_Out_2.xxxx), _Property_c551a4d6fd90454c8320eac950ac91da_Out_0, _Multiply_7499b43960a14a42bdb8aafd89235b59_Out_2);
	float4 _Lerp_e45407912adb4284a451fec5b49c8abc_Out_3;
	Unity_Lerp_float4(_Multiply_f86d698f353e49b8ac4e704412805883_Out_2, _Multiply_7499b43960a14a42bdb8aafd89235b59_Out_2, (_Step_d74a28341b3b47d2b929db9c36d76662_Out_2.xxxx), _Lerp_e45407912adb4284a451fec5b49c8abc_Out_3);
	float4 _Add_7daf6aeef3334209844501eb66f273d6_Out_2;
	Unity_Add_float4(float4(0, 0, 0, 0), _Lerp_e45407912adb4284a451fec5b49c8abc_Out_3, _Add_7daf6aeef3334209844501eb66f273d6_Out_2);
	float _Property_a50a3f7883c643f3ab2704942ad380db_Out_0 = Vector1_0de750b9c41b4a5daef844a1599f5ac7;
	float _Lerp_c9309f6c8a3444369988184556880232_Out_3;
	Unity_Lerp_float(_SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_R_4, _Property_a50a3f7883c643f3ab2704942ad380db_Out_0, _Step_d74a28341b3b47d2b929db9c36d76662_Out_2, _Lerp_c9309f6c8a3444369988184556880232_Out_3);
	float _Property_c368716654714d7eb4e5d93e94d992ce_Out_0 = _Smoothness;
	float _Multiply_9e88f987c3944d87a5f9197876696d2b_Out_2;
	Unity_Multiply_float(_SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_G_5, _Property_c368716654714d7eb4e5d93e94d992ce_Out_0, _Multiply_9e88f987c3944d87a5f9197876696d2b_Out_2);
	float _Property_a7dee795de614222ba4e4569b151c9e8_Out_0 = Vector1_7bf270fe91494824b4209d2dc1faae23;
	float _Lerp_f176bf104e364901a15faca7f74a33fd_Out_3;
	Unity_Lerp_float(_Multiply_9e88f987c3944d87a5f9197876696d2b_Out_2, _Property_a7dee795de614222ba4e4569b151c9e8_Out_0, _Step_d74a28341b3b47d2b929db9c36d76662_Out_2, _Lerp_f176bf104e364901a15faca7f74a33fd_Out_3);
	float _Property_b349e081a1f74f9cae70aff3922ba018_Out_0 = _OcclusionStrength;
	float _Subtract_a72bdf3527a4494ea66bc1773ad1a7da_Out_2;
	Unity_Subtract_float(1, _Property_b349e081a1f74f9cae70aff3922ba018_Out_0, _Subtract_a72bdf3527a4494ea66bc1773ad1a7da_Out_2);
	float _Multiply_3a3ed483ad5d435cb751ace06d019def_Out_2;
	Unity_Multiply_float(_Property_b349e081a1f74f9cae70aff3922ba018_Out_0, _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_B_6, _Multiply_3a3ed483ad5d435cb751ace06d019def_Out_2);
	float _Add_78b726c350d14be58e392670cc9a8503_Out_2;
	Unity_Add_float(_Subtract_a72bdf3527a4494ea66bc1773ad1a7da_Out_2, _Multiply_3a3ed483ad5d435cb751ace06d019def_Out_2, _Add_78b726c350d14be58e392670cc9a8503_Out_2);
	surface.BaseColor = (_Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3.xyz);
	surface.NormalTS = _Lerp_cfff89d8630c4d3b975d173579abd871_Out_3;
	surface.Emission = (_Add_7daf6aeef3334209844501eb66f273d6_Out_2.xyz);
	surface.Metallic = _Lerp_c9309f6c8a3444369988184556880232_Out_3;
	surface.Smoothness = _Lerp_f176bf104e364901a15faca7f74a33fd_Out_3;
	surface.Occlusion = _Add_78b726c350d14be58e392670cc9a8503_Out_2;
	return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
	VertexDescriptionInputs output;
	ZERO_INITIALIZE(VertexDescriptionInputs, output);

	output.ObjectSpaceNormal = input.normalOS;
	output.ObjectSpaceTangent = input.tangentOS.xyz;
	output.ObjectSpacePosition = input.positionOS;

	return output;
}
	SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
	SurfaceDescriptionInputs output;
	ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
	float3 unnormalizedNormalWS = input.normalWS;
	const float renormFactor = 1.0 / length(unnormalizedNormalWS);

	// use bitangent on the fly like in hdrp
	// IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
	float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
	float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);

	output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
	output.ObjectSpaceNormal = normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
	output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);

	// to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
	// This is explained in section 2.2 in "surface gradient based bump mapping framework"
	output.WorldSpaceTangent = renormFactor * input.tangentWS.xyz;
	output.WorldSpaceBiTangent = renormFactor * bitang;

	output.WorldSpaceViewDirection = input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
	output.ObjectSpaceViewDirection = TransformWorldToObjectDir(output.WorldSpaceViewDirection);
	output.WorldSpacePosition = input.positionWS;
	output.uv0 = input.texCoord0;
	output.uv1 = input.texCoord1;
#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

	return output;
}

	// --------------------------------------------------
	// Main

	#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"

	ENDHLSL
}
Pass
{
	Name "ShadowCaster"
	Tags
	{
		"LightMode" = "ShadowCaster"
	}

		// Render State
		Cull Back
	Blend One Zero
	ZTest LEqual
	ZWrite On
	ColorMask 0

		// Debug
		// <None>

		// --------------------------------------------------
		// Pass

		HLSLPROGRAM

		// Pragmas
		#pragma target 2.0
	#pragma only_renderers gles gles3 glcore d3d11
	#pragma multi_compile_instancing
	#pragma vertex vert
	#pragma fragment frag

		// DotsInstancingOptions: <None>
		// HybridV1InjectedBuiltinProperties: <None>

		// Keywords
		// PassKeywords: <None>
		// GraphKeywords: <None>

		// Defines
		#define _NORMALMAP 1
		#define _NORMAL_DROPOFF_TS 1
		#define ATTRIBUTES_NEED_NORMAL
		#define ATTRIBUTES_NEED_TANGENT
		#define VARYINGS_NEED_NORMAL_WS
		#define FEATURES_GRAPH_VERTEX
		/* WARNING: $splice Could not find named fragment 'PassInstancing' */
		#define SHADERPASS SHADERPASS_SHADOWCASTER
		/* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

		// Includes
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

		// --------------------------------------------------
		// Structs and Packing

		struct Attributes
	{
		float3 positionOS : POSITION;
		float3 normalOS : NORMAL;
		float4 tangentOS : TANGENT;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : INSTANCEID_SEMANTIC;
		#endif
	};
	struct Varyings
	{
		float4 positionCS : SV_POSITION;
		float3 normalWS;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};
	struct SurfaceDescriptionInputs
	{
	};
	struct VertexDescriptionInputs
	{
		float3 ObjectSpaceNormal;
		float3 ObjectSpaceTangent;
		float3 ObjectSpacePosition;
	};
	struct PackedVaryings
	{
		float4 positionCS : SV_POSITION;
		float3 interp0 : TEXCOORD0;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};

		PackedVaryings PackVaryings(Varyings input)
	{
		PackedVaryings output;
		output.positionCS = input.positionCS;
		output.interp0.xyz = input.normalWS;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}
	Varyings UnpackVaryings(PackedVaryings input)
	{
		Varyings output;
		output.positionCS = input.positionCS;
		output.normalWS = input.interp0.xyz;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}

	// --------------------------------------------------
	// Graph

	// Graph Properties
	CBUFFER_START(UnityPerMaterial)
float4 _BaseMap_TexelSize;
float4 _BaseColor;
float4 _MRAMap_TexelSize;
float _Smoothness;
float _OcclusionStrength;
float4 _BumpMap_TexelSize;
float4 _EmissionColor;
float Vector1_f104b915aaef41b69539acbf337f0b81;
float4 _CheekMap_TexelSize;
float4 Vector4_700df69d953c4e0e8d13cc36c1e28d41;
float4 _LipMap_TexelSize;
float4 Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1;
float4 _EyeShadowMap_TexelSize;
float4 Vector4_79165151a1a14973895d00e05edb1141;
float4 _PupilMap_TexelSize;
float4 Vector4_3c5a0575ad994c0484082879b48be7eb;
float4 _MaskMap_TexelSize;
float Vector1_7bf270fe91494824b4209d2dc1faae23;
float Vector1_0de750b9c41b4a5daef844a1599f5ac7;
float Vector1_2871f666316541908d110962eef07f02;
float Vector1_b5cc7f6f25194a778cb438f45fbbce66;
float Vector1_8e760635099b4147956bb9600d13cac2;
float4 _GlitterMap_TexelSize;
float2 Vector2_55edcb19ba1d459dbb3c027e66abbc1e;
float Vector1_f6677799b193415b8be7686b658a6e85;
float4 Color_1bf9c5e6f5c34360a490da1c94e6a7c1;
float Vector1_353a19306a364e939d35b1adffceaf21;
float Vector1_9e8e677800b644e19c377f91787c52f4;
float4 Texture2D_f176501ab1eb4c009adb04a9e3357df5_TexelSize;
float Vector1_8198268cf31e477b821e90f882ffb838;
float4 Color_4411c24bb9114a90bac0609a3e38417f;
float4 Color_3d38e1bc34e4408ca62ad21c702a4991;
float2 Vector2_d7f0b0cac82442babeaa593fef472e04;
float Vector1_f66b7945f53b4d85aa034d136a32a8b2;
CBUFFER_END

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_BaseMap);
SAMPLER(sampler_BaseMap);
TEXTURE2D(_MRAMap);
SAMPLER(sampler_MRAMap);
TEXTURE2D(_BumpMap);
SAMPLER(sampler_BumpMap);
TEXTURE2D(_CheekMap);
SAMPLER(sampler_CheekMap);
TEXTURE2D(_LipMap);
SAMPLER(sampler_LipMap);
TEXTURE2D(_EyeShadowMap);
SAMPLER(sampler_EyeShadowMap);
TEXTURE2D(_PupilMap);
SAMPLER(sampler_PupilMap);
TEXTURE2D(_MaskMap);
SAMPLER(sampler_MaskMap);
TEXTURE2D(_GlitterMap);
SAMPLER(sampler_GlitterMap);
TEXTURE2D(Texture2D_f176501ab1eb4c009adb04a9e3357df5);
SAMPLER(samplerTexture2D_f176501ab1eb4c009adb04a9e3357df5);

// Graph Functions
// GraphFunctions: <None>

// Graph Vertex
struct VertexDescription
{
	float3 Position;
	float3 Normal;
	float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
	VertexDescription description = (VertexDescription)0;
	description.Position = IN.ObjectSpacePosition;
	description.Normal = IN.ObjectSpaceNormal;
	description.Tangent = IN.ObjectSpaceTangent;
	return description;
}

// Graph Pixel
struct SurfaceDescription
{
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
	SurfaceDescription surface = (SurfaceDescription)0;
	return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
	VertexDescriptionInputs output;
	ZERO_INITIALIZE(VertexDescriptionInputs, output);

	output.ObjectSpaceNormal = input.normalOS;
	output.ObjectSpaceTangent = input.tangentOS.xyz;
	output.ObjectSpacePosition = input.positionOS;

	return output;
}
	SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
	SurfaceDescriptionInputs output;
	ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

	return output;
}

	// --------------------------------------------------
	// Main

	#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"

	ENDHLSL
}
Pass
{
	Name "DepthOnly"
	Tags
	{
		"LightMode" = "DepthOnly"
	}

		// Render State
		Cull Back
	Blend One Zero
	ZTest LEqual
	ZWrite On
	ColorMask 0

		// Debug
		// <None>

		// --------------------------------------------------
		// Pass

		HLSLPROGRAM

		// Pragmas
		#pragma target 2.0
	#pragma only_renderers gles gles3 glcore d3d11
	#pragma multi_compile_instancing
	#pragma vertex vert
	#pragma fragment frag

		// DotsInstancingOptions: <None>
		// HybridV1InjectedBuiltinProperties: <None>

		// Keywords
		// PassKeywords: <None>
		// GraphKeywords: <None>

		// Defines
		#define _NORMALMAP 1
		#define _NORMAL_DROPOFF_TS 1
		#define ATTRIBUTES_NEED_NORMAL
		#define ATTRIBUTES_NEED_TANGENT
		#define FEATURES_GRAPH_VERTEX
		/* WARNING: $splice Could not find named fragment 'PassInstancing' */
		#define SHADERPASS SHADERPASS_DEPTHONLY
		/* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

		// Includes
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

		// --------------------------------------------------
		// Structs and Packing

		struct Attributes
	{
		float3 positionOS : POSITION;
		float3 normalOS : NORMAL;
		float4 tangentOS : TANGENT;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : INSTANCEID_SEMANTIC;
		#endif
	};
	struct Varyings
	{
		float4 positionCS : SV_POSITION;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};
	struct SurfaceDescriptionInputs
	{
	};
	struct VertexDescriptionInputs
	{
		float3 ObjectSpaceNormal;
		float3 ObjectSpaceTangent;
		float3 ObjectSpacePosition;
	};
	struct PackedVaryings
	{
		float4 positionCS : SV_POSITION;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};

		PackedVaryings PackVaryings(Varyings input)
	{
		PackedVaryings output;
		output.positionCS = input.positionCS;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}
	Varyings UnpackVaryings(PackedVaryings input)
	{
		Varyings output;
		output.positionCS = input.positionCS;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}

	// --------------------------------------------------
	// Graph

	// Graph Properties
	CBUFFER_START(UnityPerMaterial)
float4 _BaseMap_TexelSize;
float4 _BaseColor;
float4 _MRAMap_TexelSize;
float _Smoothness;
float _OcclusionStrength;
float4 _BumpMap_TexelSize;
float4 _EmissionColor;
float Vector1_f104b915aaef41b69539acbf337f0b81;
float4 _CheekMap_TexelSize;
float4 Vector4_700df69d953c4e0e8d13cc36c1e28d41;
float4 _LipMap_TexelSize;
float4 Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1;
float4 _EyeShadowMap_TexelSize;
float4 Vector4_79165151a1a14973895d00e05edb1141;
float4 _PupilMap_TexelSize;
float4 Vector4_3c5a0575ad994c0484082879b48be7eb;
float4 _MaskMap_TexelSize;
float Vector1_7bf270fe91494824b4209d2dc1faae23;
float Vector1_0de750b9c41b4a5daef844a1599f5ac7;
float Vector1_2871f666316541908d110962eef07f02;
float Vector1_b5cc7f6f25194a778cb438f45fbbce66;
float Vector1_8e760635099b4147956bb9600d13cac2;
float4 _GlitterMap_TexelSize;
float2 Vector2_55edcb19ba1d459dbb3c027e66abbc1e;
float Vector1_f6677799b193415b8be7686b658a6e85;
float4 Color_1bf9c5e6f5c34360a490da1c94e6a7c1;
float Vector1_353a19306a364e939d35b1adffceaf21;
float Vector1_9e8e677800b644e19c377f91787c52f4;
float4 Texture2D_f176501ab1eb4c009adb04a9e3357df5_TexelSize;
float Vector1_8198268cf31e477b821e90f882ffb838;
float4 Color_4411c24bb9114a90bac0609a3e38417f;
float4 Color_3d38e1bc34e4408ca62ad21c702a4991;
float2 Vector2_d7f0b0cac82442babeaa593fef472e04;
float Vector1_f66b7945f53b4d85aa034d136a32a8b2;
CBUFFER_END

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_BaseMap);
SAMPLER(sampler_BaseMap);
TEXTURE2D(_MRAMap);
SAMPLER(sampler_MRAMap);
TEXTURE2D(_BumpMap);
SAMPLER(sampler_BumpMap);
TEXTURE2D(_CheekMap);
SAMPLER(sampler_CheekMap);
TEXTURE2D(_LipMap);
SAMPLER(sampler_LipMap);
TEXTURE2D(_EyeShadowMap);
SAMPLER(sampler_EyeShadowMap);
TEXTURE2D(_PupilMap);
SAMPLER(sampler_PupilMap);
TEXTURE2D(_MaskMap);
SAMPLER(sampler_MaskMap);
TEXTURE2D(_GlitterMap);
SAMPLER(sampler_GlitterMap);
TEXTURE2D(Texture2D_f176501ab1eb4c009adb04a9e3357df5);
SAMPLER(samplerTexture2D_f176501ab1eb4c009adb04a9e3357df5);

// Graph Functions
// GraphFunctions: <None>

// Graph Vertex
struct VertexDescription
{
	float3 Position;
	float3 Normal;
	float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
	VertexDescription description = (VertexDescription)0;
	description.Position = IN.ObjectSpacePosition;
	description.Normal = IN.ObjectSpaceNormal;
	description.Tangent = IN.ObjectSpaceTangent;
	return description;
}

// Graph Pixel
struct SurfaceDescription
{
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
	SurfaceDescription surface = (SurfaceDescription)0;
	return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
	VertexDescriptionInputs output;
	ZERO_INITIALIZE(VertexDescriptionInputs, output);

	output.ObjectSpaceNormal = input.normalOS;
	output.ObjectSpaceTangent = input.tangentOS.xyz;
	output.ObjectSpacePosition = input.positionOS;

	return output;
}
	SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
	SurfaceDescriptionInputs output;
	ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

	return output;
}

	// --------------------------------------------------
	// Main

	#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"

	ENDHLSL
}
Pass
{
	Name "DepthNormals"
	Tags
	{
		"LightMode" = "DepthNormals"
	}

		// Render State
		Cull Back
	Blend One Zero
	ZTest LEqual
	ZWrite On

		// Debug
		// <None>

		// --------------------------------------------------
		// Pass

		HLSLPROGRAM

		// Pragmas
		#pragma target 2.0
	#pragma only_renderers gles gles3 glcore d3d11
	#pragma multi_compile_instancing
	#pragma vertex vert
	#pragma fragment frag

		// DotsInstancingOptions: <None>
		// HybridV1InjectedBuiltinProperties: <None>

		// Keywords
		// PassKeywords: <None>
		// GraphKeywords: <None>

		// Defines
		#define _NORMALMAP 1
		#define _NORMAL_DROPOFF_TS 1
		#define ATTRIBUTES_NEED_NORMAL
		#define ATTRIBUTES_NEED_TANGENT
		#define ATTRIBUTES_NEED_TEXCOORD0
		#define ATTRIBUTES_NEED_TEXCOORD1
		#define VARYINGS_NEED_POSITION_WS
		#define VARYINGS_NEED_NORMAL_WS
		#define VARYINGS_NEED_TANGENT_WS
		#define VARYINGS_NEED_TEXCOORD0
		#define FEATURES_GRAPH_VERTEX
		/* WARNING: $splice Could not find named fragment 'PassInstancing' */
		#define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
		/* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

		// Includes
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

		// --------------------------------------------------
		// Structs and Packing

		struct Attributes
	{
		float3 positionOS : POSITION;
		float3 normalOS : NORMAL;
		float4 tangentOS : TANGENT;
		float4 uv0 : TEXCOORD0;
		float4 uv1 : TEXCOORD1;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : INSTANCEID_SEMANTIC;
		#endif
	};
	struct Varyings
	{
		float4 positionCS : SV_POSITION;
		float3 positionWS;
		float3 normalWS;
		float4 tangentWS;
		float4 texCoord0;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};
	struct SurfaceDescriptionInputs
	{
		float3 WorldSpaceNormal;
		float3 TangentSpaceNormal;
		float3 WorldSpaceTangent;
		float3 WorldSpaceBiTangent;
		float3 WorldSpacePosition;
		float4 uv0;
	};
	struct VertexDescriptionInputs
	{
		float3 ObjectSpaceNormal;
		float3 ObjectSpaceTangent;
		float3 ObjectSpacePosition;
	};
	struct PackedVaryings
	{
		float4 positionCS : SV_POSITION;
		float3 interp0 : TEXCOORD0;
		float3 interp1 : TEXCOORD1;
		float4 interp2 : TEXCOORD2;
		float4 interp3 : TEXCOORD3;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};

		PackedVaryings PackVaryings(Varyings input)
	{
		PackedVaryings output;
		output.positionCS = input.positionCS;
		output.interp0.xyz = input.positionWS;
		output.interp1.xyz = input.normalWS;
		output.interp2.xyzw = input.tangentWS;
		output.interp3.xyzw = input.texCoord0;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}
	Varyings UnpackVaryings(PackedVaryings input)
	{
		Varyings output;
		output.positionCS = input.positionCS;
		output.positionWS = input.interp0.xyz;
		output.normalWS = input.interp1.xyz;
		output.tangentWS = input.interp2.xyzw;
		output.texCoord0 = input.interp3.xyzw;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}

	// --------------------------------------------------
	// Graph

	// Graph Properties
	CBUFFER_START(UnityPerMaterial)
float4 _BaseMap_TexelSize;
float4 _BaseColor;
float4 _MRAMap_TexelSize;
float _Smoothness;
float _OcclusionStrength;
float4 _BumpMap_TexelSize;
float4 _EmissionColor;
float Vector1_f104b915aaef41b69539acbf337f0b81;
float4 _CheekMap_TexelSize;
float4 Vector4_700df69d953c4e0e8d13cc36c1e28d41;
float4 _LipMap_TexelSize;
float4 Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1;
float4 _EyeShadowMap_TexelSize;
float4 Vector4_79165151a1a14973895d00e05edb1141;
float4 _PupilMap_TexelSize;
float4 Vector4_3c5a0575ad994c0484082879b48be7eb;
float4 _MaskMap_TexelSize;
float Vector1_7bf270fe91494824b4209d2dc1faae23;
float Vector1_0de750b9c41b4a5daef844a1599f5ac7;
float Vector1_2871f666316541908d110962eef07f02;
float Vector1_b5cc7f6f25194a778cb438f45fbbce66;
float Vector1_8e760635099b4147956bb9600d13cac2;
float4 _GlitterMap_TexelSize;
float2 Vector2_55edcb19ba1d459dbb3c027e66abbc1e;
float Vector1_f6677799b193415b8be7686b658a6e85;
float4 Color_1bf9c5e6f5c34360a490da1c94e6a7c1;
float Vector1_353a19306a364e939d35b1adffceaf21;
float Vector1_9e8e677800b644e19c377f91787c52f4;
float4 Texture2D_f176501ab1eb4c009adb04a9e3357df5_TexelSize;
float Vector1_8198268cf31e477b821e90f882ffb838;
float4 Color_4411c24bb9114a90bac0609a3e38417f;
float4 Color_3d38e1bc34e4408ca62ad21c702a4991;
float2 Vector2_d7f0b0cac82442babeaa593fef472e04;
float Vector1_f66b7945f53b4d85aa034d136a32a8b2;
CBUFFER_END

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_BaseMap);
SAMPLER(sampler_BaseMap);
TEXTURE2D(_MRAMap);
SAMPLER(sampler_MRAMap);
TEXTURE2D(_BumpMap);
SAMPLER(sampler_BumpMap);
TEXTURE2D(_CheekMap);
SAMPLER(sampler_CheekMap);
TEXTURE2D(_LipMap);
SAMPLER(sampler_LipMap);
TEXTURE2D(_EyeShadowMap);
SAMPLER(sampler_EyeShadowMap);
TEXTURE2D(_PupilMap);
SAMPLER(sampler_PupilMap);
TEXTURE2D(_MaskMap);
SAMPLER(sampler_MaskMap);
TEXTURE2D(_GlitterMap);
SAMPLER(sampler_GlitterMap);
TEXTURE2D(Texture2D_f176501ab1eb4c009adb04a9e3357df5);
SAMPLER(samplerTexture2D_f176501ab1eb4c009adb04a9e3357df5);

// Graph Functions

void Unity_NormalUnpack_float(float4 In, out float3 Out)
{
				Out = UnpackNormal(In);
			}


float2 Unity_GradientNoise_Dir_float(float2 p)
{
	// Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
	p = p % 289;
	// need full precision, otherwise half overflows when p > 1
	float x = float(34 * p.x + 1) * p.x % 289 + p.y;
	x = (34 * x + 1) * x % 289;
	x = frac(x / 41) * 2 - 1;
	return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
}

void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
{
	float2 p = UV * Scale;
	float2 ip = floor(p);
	float2 fp = frac(p);
	float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
	float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
	float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
	float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
	fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
	Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
}

void Unity_Add_float(float A, float B, out float Out)
{
	Out = A + B;
}

void Unity_Multiply_float(float A, float B, out float Out)
{
	Out = A * B;
}

void Unity_Lerp_float(float A, float B, float T, out float Out)
{
	Out = lerp(A, B, T);
}

void Unity_NormalFromHeight_Tangent_float(float In, float Strength, float3 Position, float3x3 TangentMatrix, out float3 Out)
{
	float3 worldDerivativeX = ddx(Position);
	float3 worldDerivativeY = ddy(Position);

	float3 crossX = cross(TangentMatrix[2].xyz, worldDerivativeX);
	float3 crossY = cross(worldDerivativeY, TangentMatrix[2].xyz);
	float d = dot(worldDerivativeX, crossY);
	float sgn = d < 0.0 ? (-1.0f) : 1.0f;
	float surface = sgn / max(0.000000000000001192093f, abs(d));

	float dHdx = ddx(In);
	float dHdy = ddy(In);
	float3 surfGrad = surface * (dHdx*crossY + dHdy * crossX);
	Out = SafeNormalize(TangentMatrix[2].xyz - (Strength * surfGrad));
	Out = TransformWorldToTangent(Out, TangentMatrix);
}

void Unity_OneMinus_float(float In, out float Out)
{
	Out = 1 - In;
}

void Unity_Step_float(float Edge, float In, out float Out)
{
	Out = step(Edge, In);
}

void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
{
	Out = lerp(A, B, T);
}

// Graph Vertex
struct VertexDescription
{
	float3 Position;
	float3 Normal;
	float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
	VertexDescription description = (VertexDescription)0;
	description.Position = IN.ObjectSpacePosition;
	description.Normal = IN.ObjectSpaceNormal;
	description.Tangent = IN.ObjectSpaceTangent;
	return description;
}

// Graph Pixel
struct SurfaceDescription
{
	float3 NormalTS;
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
	SurfaceDescription surface = (SurfaceDescription)0;
	UnityTexture2D _Property_ef39b7e1c5c6465f842c5dfa050e47e1_Out_0 = UnityBuildTexture2DStructNoScale(_BumpMap);
	float4 _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0 = SAMPLE_TEXTURE2D(_Property_ef39b7e1c5c6465f842c5dfa050e47e1_Out_0.tex, _Property_ef39b7e1c5c6465f842c5dfa050e47e1_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_R_4 = _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0.r;
	float _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_G_5 = _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0.g;
	float _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_B_6 = _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0.b;
	float _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_A_7 = _SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0.a;
	float3 _NormalUnpack_b1e6ba1d5cc34fc6bed28052e3d03168_Out_1;
	Unity_NormalUnpack_float(_SampleTexture2D_5052915c79c64d74b80e8f174e90cfdc_RGBA_0, _NormalUnpack_b1e6ba1d5cc34fc6bed28052e3d03168_Out_1);
	float _Property_7671b3b7eef84a8c9d7825a9036c8bff_Out_0 = Vector1_b5cc7f6f25194a778cb438f45fbbce66;
	float _GradientNoise_4be9f93cabe14a849abe7b8ed37b6bbd_Out_2;
	Unity_GradientNoise_float(IN.uv0.xy, _Property_7671b3b7eef84a8c9d7825a9036c8bff_Out_0, _GradientNoise_4be9f93cabe14a849abe7b8ed37b6bbd_Out_2);
	float _Add_3e0bbf4ee4904868940bafe39dd7423f_Out_2;
	Unity_Add_float(_GradientNoise_4be9f93cabe14a849abe7b8ed37b6bbd_Out_2, 0.3, _Add_3e0bbf4ee4904868940bafe39dd7423f_Out_2);
	UnityTexture2D _Property_90c3e617459146b89270ca735ff67027_Out_0 = UnityBuildTexture2DStructNoScale(_MaskMap);
	float4 _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0 = SAMPLE_TEXTURE2D(_Property_90c3e617459146b89270ca735ff67027_Out_0.tex, _Property_90c3e617459146b89270ca735ff67027_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_R_4 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.r;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_G_5 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.g;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_B_6 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.b;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.a;
	float _Multiply_2e36cc2586dc491abb678f1f1cf3d350_Out_2;
	Unity_Multiply_float(_GradientNoise_4be9f93cabe14a849abe7b8ed37b6bbd_Out_2, _SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _Multiply_2e36cc2586dc491abb678f1f1cf3d350_Out_2);
	float _Lerp_c862be95f9354a0ab4024a518282ec79_Out_3;
	Unity_Lerp_float(0.3, _Add_3e0bbf4ee4904868940bafe39dd7423f_Out_2, _Multiply_2e36cc2586dc491abb678f1f1cf3d350_Out_2, _Lerp_c862be95f9354a0ab4024a518282ec79_Out_3);
	float _Property_6721bad2e28e4210a1fa01a48f73c858_Out_0 = Vector1_8e760635099b4147956bb9600d13cac2;
	float3 _NormalFromHeight_392055ed45084230899320a5058871be_Out_1;
	float3x3 _NormalFromHeight_392055ed45084230899320a5058871be_TangentMatrix = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
	float3 _NormalFromHeight_392055ed45084230899320a5058871be_Position = IN.WorldSpacePosition;
	Unity_NormalFromHeight_Tangent_float(_Lerp_c862be95f9354a0ab4024a518282ec79_Out_3,_Property_6721bad2e28e4210a1fa01a48f73c858_Out_0,_NormalFromHeight_392055ed45084230899320a5058871be_Position,_NormalFromHeight_392055ed45084230899320a5058871be_TangentMatrix, _NormalFromHeight_392055ed45084230899320a5058871be_Out_1);
	float _OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1;
	Unity_OneMinus_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1);
	float _Property_1a86dcb475f34e9c8bb3d74526142f51_Out_0 = Vector1_2871f666316541908d110962eef07f02;
	float _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2;
	Unity_GradientNoise_float(IN.uv0.xy, _Property_1a86dcb475f34e9c8bb3d74526142f51_Out_0, _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2);
	float _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2;
	Unity_Multiply_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2, _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2);
	float _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2;
	Unity_Add_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2, _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2);
	float _Step_d74a28341b3b47d2b929db9c36d76662_Out_2;
	Unity_Step_float(_OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1, _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2, _Step_d74a28341b3b47d2b929db9c36d76662_Out_2);
	float3 _Lerp_cfff89d8630c4d3b975d173579abd871_Out_3;
	Unity_Lerp_float3(_NormalUnpack_b1e6ba1d5cc34fc6bed28052e3d03168_Out_1, _NormalFromHeight_392055ed45084230899320a5058871be_Out_1, (_Step_d74a28341b3b47d2b929db9c36d76662_Out_2.xxx), _Lerp_cfff89d8630c4d3b975d173579abd871_Out_3);
	surface.NormalTS = _Lerp_cfff89d8630c4d3b975d173579abd871_Out_3;
	return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
	VertexDescriptionInputs output;
	ZERO_INITIALIZE(VertexDescriptionInputs, output);

	output.ObjectSpaceNormal = input.normalOS;
	output.ObjectSpaceTangent = input.tangentOS.xyz;
	output.ObjectSpacePosition = input.positionOS;

	return output;
}
	SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
	SurfaceDescriptionInputs output;
	ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
	float3 unnormalizedNormalWS = input.normalWS;
	const float renormFactor = 1.0 / length(unnormalizedNormalWS);

	// use bitangent on the fly like in hdrp
	// IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
	float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
	float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);

	output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
	output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);

	// to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
	// This is explained in section 2.2 in "surface gradient based bump mapping framework"
	output.WorldSpaceTangent = renormFactor * input.tangentWS.xyz;
	output.WorldSpaceBiTangent = renormFactor * bitang;

	output.WorldSpacePosition = input.positionWS;
	output.uv0 = input.texCoord0;
#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

	return output;
}

	// --------------------------------------------------
	// Main

	#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"

	ENDHLSL
}
Pass
{
	Name "Meta"
	Tags
	{
		"LightMode" = "Meta"
	}

		// Render State
		Cull Off

		// Debug
		// <None>

		// --------------------------------------------------
		// Pass

		HLSLPROGRAM

		// Pragmas
		#pragma target 2.0
	#pragma only_renderers gles gles3 glcore d3d11
	#pragma vertex vert
	#pragma fragment frag

		// DotsInstancingOptions: <None>
		// HybridV1InjectedBuiltinProperties: <None>

		// Keywords
		#pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
		// GraphKeywords: <None>

		// Defines
		#define _NORMALMAP 1
		#define _NORMAL_DROPOFF_TS 1
		#define ATTRIBUTES_NEED_NORMAL
		#define ATTRIBUTES_NEED_TANGENT
		#define ATTRIBUTES_NEED_TEXCOORD0
		#define ATTRIBUTES_NEED_TEXCOORD1
		#define ATTRIBUTES_NEED_TEXCOORD2
		#define VARYINGS_NEED_NORMAL_WS
		#define VARYINGS_NEED_TEXCOORD0
		#define VARYINGS_NEED_TEXCOORD1
		#define VARYINGS_NEED_VIEWDIRECTION_WS
		#define FEATURES_GRAPH_VERTEX
		/* WARNING: $splice Could not find named fragment 'PassInstancing' */
		#define SHADERPASS SHADERPASS_META
		/* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

		// Includes
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"

		// --------------------------------------------------
		// Structs and Packing

		struct Attributes
	{
		float3 positionOS : POSITION;
		float3 normalOS : NORMAL;
		float4 tangentOS : TANGENT;
		float4 uv0 : TEXCOORD0;
		float4 uv1 : TEXCOORD1;
		float4 uv2 : TEXCOORD2;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : INSTANCEID_SEMANTIC;
		#endif
	};
	struct Varyings
	{
		float4 positionCS : SV_POSITION;
		float3 normalWS;
		float4 texCoord0;
		float4 texCoord1;
		float3 viewDirectionWS;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};
	struct SurfaceDescriptionInputs
	{
		float3 ObjectSpaceNormal;
		float3 WorldSpaceNormal;
		float3 ObjectSpaceViewDirection;
		float3 WorldSpaceViewDirection;
		float4 uv0;
		float4 uv1;
	};
	struct VertexDescriptionInputs
	{
		float3 ObjectSpaceNormal;
		float3 ObjectSpaceTangent;
		float3 ObjectSpacePosition;
	};
	struct PackedVaryings
	{
		float4 positionCS : SV_POSITION;
		float3 interp0 : TEXCOORD0;
		float4 interp1 : TEXCOORD1;
		float4 interp2 : TEXCOORD2;
		float3 interp3 : TEXCOORD3;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};

		PackedVaryings PackVaryings(Varyings input)
	{
		PackedVaryings output;
		output.positionCS = input.positionCS;
		output.interp0.xyz = input.normalWS;
		output.interp1.xyzw = input.texCoord0;
		output.interp2.xyzw = input.texCoord1;
		output.interp3.xyz = input.viewDirectionWS;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}
	Varyings UnpackVaryings(PackedVaryings input)
	{
		Varyings output;
		output.positionCS = input.positionCS;
		output.normalWS = input.interp0.xyz;
		output.texCoord0 = input.interp1.xyzw;
		output.texCoord1 = input.interp2.xyzw;
		output.viewDirectionWS = input.interp3.xyz;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}

	// --------------------------------------------------
	// Graph

	// Graph Properties
	CBUFFER_START(UnityPerMaterial)
float4 _BaseMap_TexelSize;
float4 _BaseColor;
float4 _MRAMap_TexelSize;
float _Smoothness;
float _OcclusionStrength;
float4 _BumpMap_TexelSize;
float4 _EmissionColor;
float Vector1_f104b915aaef41b69539acbf337f0b81;
float4 _CheekMap_TexelSize;
float4 Vector4_700df69d953c4e0e8d13cc36c1e28d41;
float4 _LipMap_TexelSize;
float4 Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1;
float4 _EyeShadowMap_TexelSize;
float4 Vector4_79165151a1a14973895d00e05edb1141;
float4 _PupilMap_TexelSize;
float4 Vector4_3c5a0575ad994c0484082879b48be7eb;
float4 _MaskMap_TexelSize;
float Vector1_7bf270fe91494824b4209d2dc1faae23;
float Vector1_0de750b9c41b4a5daef844a1599f5ac7;
float Vector1_2871f666316541908d110962eef07f02;
float Vector1_b5cc7f6f25194a778cb438f45fbbce66;
float Vector1_8e760635099b4147956bb9600d13cac2;
float4 _GlitterMap_TexelSize;
float2 Vector2_55edcb19ba1d459dbb3c027e66abbc1e;
float Vector1_f6677799b193415b8be7686b658a6e85;
float4 Color_1bf9c5e6f5c34360a490da1c94e6a7c1;
float Vector1_353a19306a364e939d35b1adffceaf21;
float Vector1_9e8e677800b644e19c377f91787c52f4;
float4 Texture2D_f176501ab1eb4c009adb04a9e3357df5_TexelSize;
float Vector1_8198268cf31e477b821e90f882ffb838;
float4 Color_4411c24bb9114a90bac0609a3e38417f;
float4 Color_3d38e1bc34e4408ca62ad21c702a4991;
float2 Vector2_d7f0b0cac82442babeaa593fef472e04;
float Vector1_f66b7945f53b4d85aa034d136a32a8b2;
CBUFFER_END

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_BaseMap);
SAMPLER(sampler_BaseMap);
TEXTURE2D(_MRAMap);
SAMPLER(sampler_MRAMap);
TEXTURE2D(_BumpMap);
SAMPLER(sampler_BumpMap);
TEXTURE2D(_CheekMap);
SAMPLER(sampler_CheekMap);
TEXTURE2D(_LipMap);
SAMPLER(sampler_LipMap);
TEXTURE2D(_EyeShadowMap);
SAMPLER(sampler_EyeShadowMap);
TEXTURE2D(_PupilMap);
SAMPLER(sampler_PupilMap);
TEXTURE2D(_MaskMap);
SAMPLER(sampler_MaskMap);
TEXTURE2D(_GlitterMap);
SAMPLER(sampler_GlitterMap);
TEXTURE2D(Texture2D_f176501ab1eb4c009adb04a9e3357df5);
SAMPLER(samplerTexture2D_f176501ab1eb4c009adb04a9e3357df5);

// Graph Functions

void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
{
	Out = A * B;
}

void Unity_Add_float(float A, float B, out float Out)
{
	Out = A + B;
}

void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
{
	RGBA = float4(R, G, B, A);
	RGB = float3(R, G, B);
	RG = float2(R, G);
}

void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
{
	Out = lerp(A, B, T);
}

void Unity_OneMinus_float(float In, out float Out)
{
	Out = 1 - In;
}


float2 Unity_GradientNoise_Dir_float(float2 p)
{
	// Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
	p = p % 289;
	// need full precision, otherwise half overflows when p > 1
	float x = float(34 * p.x + 1) * p.x % 289 + p.y;
	x = (34 * x + 1) * x % 289;
	x = frac(x / 41) * 2 - 1;
	return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
}

void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
{
	float2 p = UV * Scale;
	float2 ip = floor(p);
	float2 fp = frac(p);
	float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
	float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
	float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
	float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
	fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
	Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
}

void Unity_Multiply_float(float A, float B, out float Out)
{
	Out = A * B;
}

void Unity_Step_float(float Edge, float In, out float Out)
{
	Out = step(Edge, In);
}

void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
{
	Out = UV * Tiling + Offset;
}

void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
{
	Out = A - B;
}

void Unity_Normalize_float3(float3 In, out float3 Out)
{
	Out = normalize(In);
}

void Unity_Add_float3(float3 A, float3 B, out float3 Out)
{
	Out = A + B;
}

void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
{
	Out = dot(A, B);
}

void Unity_Saturate_float(float In, out float Out)
{
	Out = saturate(In);
}

void Unity_Exponential2_float(float In, out float Out)
{
	Out = exp2(In);
}

void Unity_Power_float(float A, float B, out float Out)
{
	Out = pow(A, B);
}

void Unity_Add_float4(float4 A, float4 B, out float4 Out)
{
	Out = A + B;
}

// Graph Vertex
struct VertexDescription
{
	float3 Position;
	float3 Normal;
	float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
	VertexDescription description = (VertexDescription)0;
	description.Position = IN.ObjectSpacePosition;
	description.Normal = IN.ObjectSpaceNormal;
	description.Tangent = IN.ObjectSpaceTangent;
	return description;
}

// Graph Pixel
struct SurfaceDescription
{
	float3 BaseColor;
	float3 Emission;
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
	SurfaceDescription surface = (SurfaceDescription)0;
	UnityTexture2D _Property_46f41194bebd49dd90523a9187559d47_Out_0 = UnityBuildTexture2DStructNoScale(_BaseMap);
	float4 _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0 = SAMPLE_TEXTURE2D(_Property_46f41194bebd49dd90523a9187559d47_Out_0.tex, _Property_46f41194bebd49dd90523a9187559d47_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_R_4 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.r;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_G_5 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.g;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_B_6 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.b;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_A_7 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.a;
	float4 _Property_3cc81970230a4e2680f1056abe28f14c_Out_0 = _BaseColor;
	float4 _Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2;
	Unity_Multiply_float(_SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0, _Property_3cc81970230a4e2680f1056abe28f14c_Out_0, _Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2);
	UnityTexture2D _Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0 = UnityBuildTexture2DStructNoScale(_CheekMap);
	float4 _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0 = Vector4_700df69d953c4e0e8d13cc36c1e28d41;
	float _Split_5022297589804f21900b69c657b81fa0_R_1 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[0];
	float _Split_5022297589804f21900b69c657b81fa0_G_2 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[1];
	float _Split_5022297589804f21900b69c657b81fa0_B_3 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[2];
	float _Split_5022297589804f21900b69c657b81fa0_A_4 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[3];
	float4 _UV_5c27d34f7fe0493fa46cacf01b32cccc_Out_0 = IN.uv1;
	float4 _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2;
	Unity_Multiply_float((_Split_5022297589804f21900b69c657b81fa0_R_1.xxxx), _UV_5c27d34f7fe0493fa46cacf01b32cccc_Out_0, _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2);
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_R_1 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[0];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_G_2 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[1];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_B_3 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[2];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_A_4 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[3];
	float _Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2;
	Unity_Add_float(_Split_5022297589804f21900b69c657b81fa0_G_2, _Split_f75341ed066d43c2ba64dd1807c3cdd5_R_1, _Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2);
	float _Add_b8d09a71819044be96521761cc153267_Out_2;
	Unity_Add_float(_Split_f75341ed066d43c2ba64dd1807c3cdd5_G_2, _Split_5022297589804f21900b69c657b81fa0_B_3, _Add_b8d09a71819044be96521761cc153267_Out_2);
	float4 _Combine_0939f9cc49e54d3ea511e937525deee6_RGBA_4;
	float3 _Combine_0939f9cc49e54d3ea511e937525deee6_RGB_5;
	float2 _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6;
	Unity_Combine_float(_Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2, _Add_b8d09a71819044be96521761cc153267_Out_2, 0, 0, _Combine_0939f9cc49e54d3ea511e937525deee6_RGBA_4, _Combine_0939f9cc49e54d3ea511e937525deee6_RGB_5, _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6);
	float4 _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0 = SAMPLE_TEXTURE2D(_Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0.tex, _Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0.samplerstate, _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6);
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_R_4 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.r;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_G_5 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.g;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_B_6 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.b;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_A_7 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.a;
	float4 _Lerp_2241ae8feb5941da9183bb461c252132_Out_3;
	Unity_Lerp_float4(_Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2, _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0, (_SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_A_7.xxxx), _Lerp_2241ae8feb5941da9183bb461c252132_Out_3);
	UnityTexture2D _Property_5f8a386b21984e2988fde7598f635a9a_Out_0 = UnityBuildTexture2DStructNoScale(_LipMap);
	float4 _Property_c857b47c21154b86a27f46398299df91_Out_0 = Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1;
	float _Split_f308ae64287f48e8872c952e6828cb36_R_1 = _Property_c857b47c21154b86a27f46398299df91_Out_0[0];
	float _Split_f308ae64287f48e8872c952e6828cb36_G_2 = _Property_c857b47c21154b86a27f46398299df91_Out_0[1];
	float _Split_f308ae64287f48e8872c952e6828cb36_B_3 = _Property_c857b47c21154b86a27f46398299df91_Out_0[2];
	float _Split_f308ae64287f48e8872c952e6828cb36_A_4 = _Property_c857b47c21154b86a27f46398299df91_Out_0[3];
	float4 _UV_c1af69e74f4e4df791b33b8f07716d5b_Out_0 = IN.uv1;
	float4 _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2;
	Unity_Multiply_float((_Split_f308ae64287f48e8872c952e6828cb36_R_1.xxxx), _UV_c1af69e74f4e4df791b33b8f07716d5b_Out_0, _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2);
	float _Split_3123c7f71f9749b2aa01689ddefb9374_R_1 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[0];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_G_2 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[1];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_B_3 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[2];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_A_4 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[3];
	float _Add_f2f7dee5f2844fb8822bccad48406ade_Out_2;
	Unity_Add_float(_Split_f308ae64287f48e8872c952e6828cb36_G_2, _Split_3123c7f71f9749b2aa01689ddefb9374_R_1, _Add_f2f7dee5f2844fb8822bccad48406ade_Out_2);
	float _Add_5287d7b9aac546af90e5e834b37567d2_Out_2;
	Unity_Add_float(_Split_3123c7f71f9749b2aa01689ddefb9374_G_2, _Split_f308ae64287f48e8872c952e6828cb36_B_3, _Add_5287d7b9aac546af90e5e834b37567d2_Out_2);
	float4 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGBA_4;
	float3 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGB_5;
	float2 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6;
	Unity_Combine_float(_Add_f2f7dee5f2844fb8822bccad48406ade_Out_2, _Add_5287d7b9aac546af90e5e834b37567d2_Out_2, 0, 0, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGBA_4, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGB_5, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6);
	float4 _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_5f8a386b21984e2988fde7598f635a9a_Out_0.tex, _Property_5f8a386b21984e2988fde7598f635a9a_Out_0.samplerstate, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6);
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_R_4 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.r;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_G_5 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.g;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_B_6 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.b;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_A_7 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.a;
	float4 _Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3;
	Unity_Lerp_float4(_Lerp_2241ae8feb5941da9183bb461c252132_Out_3, _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0, (_SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_A_7.xxxx), _Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3);
	UnityTexture2D _Property_034f7053a4c04630b179945137478563_Out_0 = UnityBuildTexture2DStructNoScale(_EyeShadowMap);
	float4 _Property_ec0501c48b2f47fca24e4415b083a817_Out_0 = Vector4_79165151a1a14973895d00e05edb1141;
	float _Split_a65775607697471ebf0abd88cba1cc94_R_1 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[0];
	float _Split_a65775607697471ebf0abd88cba1cc94_G_2 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[1];
	float _Split_a65775607697471ebf0abd88cba1cc94_B_3 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[2];
	float _Split_a65775607697471ebf0abd88cba1cc94_A_4 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[3];
	float4 _UV_561d401f6e7242d99119d7be74ed408f_Out_0 = IN.uv1;
	float4 _Multiply_9434dd79d3204d6f97de52affd770331_Out_2;
	Unity_Multiply_float((_Split_a65775607697471ebf0abd88cba1cc94_R_1.xxxx), _UV_561d401f6e7242d99119d7be74ed408f_Out_0, _Multiply_9434dd79d3204d6f97de52affd770331_Out_2);
	float _Split_48b01121140e4699b1b0d4a54f925206_R_1 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[0];
	float _Split_48b01121140e4699b1b0d4a54f925206_G_2 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[1];
	float _Split_48b01121140e4699b1b0d4a54f925206_B_3 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[2];
	float _Split_48b01121140e4699b1b0d4a54f925206_A_4 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[3];
	float _Add_70cfb275974e4ed78884eb9ddb51407c_Out_2;
	Unity_Add_float(_Split_a65775607697471ebf0abd88cba1cc94_G_2, _Split_48b01121140e4699b1b0d4a54f925206_R_1, _Add_70cfb275974e4ed78884eb9ddb51407c_Out_2);
	float _Add_bf85759250cd46a5a834e59e8174d47f_Out_2;
	Unity_Add_float(_Split_48b01121140e4699b1b0d4a54f925206_G_2, _Split_a65775607697471ebf0abd88cba1cc94_B_3, _Add_bf85759250cd46a5a834e59e8174d47f_Out_2);
	float4 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGBA_4;
	float3 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGB_5;
	float2 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6;
	Unity_Combine_float(_Add_70cfb275974e4ed78884eb9ddb51407c_Out_2, _Add_bf85759250cd46a5a834e59e8174d47f_Out_2, 0, 0, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGBA_4, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGB_5, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6);
	float4 _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0 = SAMPLE_TEXTURE2D(_Property_034f7053a4c04630b179945137478563_Out_0.tex, _Property_034f7053a4c04630b179945137478563_Out_0.samplerstate, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6);
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_R_4 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.r;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_G_5 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.g;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_B_6 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.b;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_A_7 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.a;
	float4 _Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3;
	Unity_Lerp_float4(_Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3, _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0, (_SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_A_7.xxxx), _Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3);
	UnityTexture2D _Property_f0ad144d6d604946a0265c0ff45af34a_Out_0 = UnityBuildTexture2DStructNoScale(_PupilMap);
	float4 _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0 = Vector4_3c5a0575ad994c0484082879b48be7eb;
	float _Split_597b0aa14ac147bb8547d10058ea208e_R_1 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[0];
	float _Split_597b0aa14ac147bb8547d10058ea208e_G_2 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[1];
	float _Split_597b0aa14ac147bb8547d10058ea208e_B_3 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[2];
	float _Split_597b0aa14ac147bb8547d10058ea208e_A_4 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[3];
	float4 _UV_fa01ab9e6ed045c0932df0bd20747d29_Out_0 = IN.uv1;
	float4 _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2;
	Unity_Multiply_float((_Split_597b0aa14ac147bb8547d10058ea208e_R_1.xxxx), _UV_fa01ab9e6ed045c0932df0bd20747d29_Out_0, _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2);
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_R_1 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[0];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_G_2 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[1];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_B_3 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[2];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_A_4 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[3];
	float _Add_8655d6d32b1b40259250182a69e8b8b7_Out_2;
	Unity_Add_float(_Split_597b0aa14ac147bb8547d10058ea208e_G_2, _Split_6051d27c6349400fbb5a5932d8d2c7ad_R_1, _Add_8655d6d32b1b40259250182a69e8b8b7_Out_2);
	float _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2;
	Unity_Add_float(_Split_6051d27c6349400fbb5a5932d8d2c7ad_G_2, _Split_597b0aa14ac147bb8547d10058ea208e_B_3, _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2);
	float4 _Combine_3c3cf19616e143188639a90935b8a10b_RGBA_4;
	float3 _Combine_3c3cf19616e143188639a90935b8a10b_RGB_5;
	float2 _Combine_3c3cf19616e143188639a90935b8a10b_RG_6;
	Unity_Combine_float(_Add_8655d6d32b1b40259250182a69e8b8b7_Out_2, _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2, 0, 0, _Combine_3c3cf19616e143188639a90935b8a10b_RGBA_4, _Combine_3c3cf19616e143188639a90935b8a10b_RGB_5, _Combine_3c3cf19616e143188639a90935b8a10b_RG_6);
	float4 _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0 = SAMPLE_TEXTURE2D(_Property_f0ad144d6d604946a0265c0ff45af34a_Out_0.tex, _Property_f0ad144d6d604946a0265c0ff45af34a_Out_0.samplerstate, _Combine_3c3cf19616e143188639a90935b8a10b_RG_6);
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_R_4 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.r;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_G_5 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.g;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_B_6 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.b;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_A_7 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.a;
	float4 _Lerp_9134832094eb464f874ea325fccb805d_Out_3;
	Unity_Lerp_float4(_Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3, _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0, (_SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_A_7.xxxx), _Lerp_9134832094eb464f874ea325fccb805d_Out_3);
	UnityTexture2D _Property_33d05c2bee3a48cbad54c88a071627d0_Out_0 = UnityBuildTexture2DStructNoScale(_MaskMap);
	float4 _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0 = SAMPLE_TEXTURE2D(_Property_33d05c2bee3a48cbad54c88a071627d0_Out_0.tex, _Property_33d05c2bee3a48cbad54c88a071627d0_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_R_4 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.r;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_G_5 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.g;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_B_6 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.b;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_A_7 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.a;
	UnityTexture2D _Property_90c3e617459146b89270ca735ff67027_Out_0 = UnityBuildTexture2DStructNoScale(_MaskMap);
	float4 _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0 = SAMPLE_TEXTURE2D(_Property_90c3e617459146b89270ca735ff67027_Out_0.tex, _Property_90c3e617459146b89270ca735ff67027_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_R_4 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.r;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_G_5 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.g;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_B_6 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.b;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.a;
	float _OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1;
	Unity_OneMinus_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1);
	float _Property_1a86dcb475f34e9c8bb3d74526142f51_Out_0 = Vector1_2871f666316541908d110962eef07f02;
	float _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2;
	Unity_GradientNoise_float(IN.uv0.xy, _Property_1a86dcb475f34e9c8bb3d74526142f51_Out_0, _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2);
	float _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2;
	Unity_Multiply_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2, _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2);
	float _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2;
	Unity_Add_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2, _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2);
	float _Step_d74a28341b3b47d2b929db9c36d76662_Out_2;
	Unity_Step_float(_OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1, _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2, _Step_d74a28341b3b47d2b929db9c36d76662_Out_2);
	float4 _Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3;
	Unity_Lerp_float4(_Lerp_9134832094eb464f874ea325fccb805d_Out_3, _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0, (_Step_d74a28341b3b47d2b929db9c36d76662_Out_2.xxxx), _Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3);
	UnityTexture2D _Property_9e2e155797564e99b75bfe8d3f7be32d_Out_0 = UnityBuildTexture2DStructNoScale(_MRAMap);
	float4 _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0 = SAMPLE_TEXTURE2D(_Property_9e2e155797564e99b75bfe8d3f7be32d_Out_0.tex, _Property_9e2e155797564e99b75bfe8d3f7be32d_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_R_4 = _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0.r;
	float _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_G_5 = _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0.g;
	float _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_B_6 = _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0.b;
	float _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_A_7 = _SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_RGBA_0.a;
	float4 _Property_b6f5177f3ae44d2cb157e753cff0343c_Out_0 = _EmissionColor;
	float4 _Multiply_8c3b33adad4c4e69a14a0843a37bf4d0_Out_2;
	Unity_Multiply_float((_SampleTexture2D_f44afa47305f424ab5890c9eba4e15b8_A_7.xxxx), _Property_b6f5177f3ae44d2cb157e753cff0343c_Out_0, _Multiply_8c3b33adad4c4e69a14a0843a37bf4d0_Out_2);
	float _Property_80e0e6200a1642e1884a71644e4682bf_Out_0 = Vector1_f104b915aaef41b69539acbf337f0b81;
	float4 _Multiply_f86d698f353e49b8ac4e704412805883_Out_2;
	Unity_Multiply_float(_Multiply_8c3b33adad4c4e69a14a0843a37bf4d0_Out_2, (_Property_80e0e6200a1642e1884a71644e4682bf_Out_0.xxxx), _Multiply_f86d698f353e49b8ac4e704412805883_Out_2);
	UnityTexture2D _Property_fe9310b7c4f2436d8e27d43b3fe188aa_Out_0 = UnityBuildTexture2DStructNoScale(_GlitterMap);
	float2 _Property_2032db54a42245aaa9312efadd4f15e3_Out_0 = Vector2_55edcb19ba1d459dbb3c027e66abbc1e;
	float2 _TilingAndOffset_721ed8d53fd54eef98ca2df1ba7cfdf5_Out_3;
	Unity_TilingAndOffset_float(IN.uv0.xy, _Property_2032db54a42245aaa9312efadd4f15e3_Out_0, float2 (0, 0), _TilingAndOffset_721ed8d53fd54eef98ca2df1ba7cfdf5_Out_3);
	float4 _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_fe9310b7c4f2436d8e27d43b3fe188aa_Out_0.tex, UnityBuildSamplerStateStruct(SamplerState_Point_Repeat).samplerstate, _TilingAndOffset_721ed8d53fd54eef98ca2df1ba7cfdf5_Out_3);
	float _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_R_4 = _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0.r;
	float _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_G_5 = _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0.g;
	float _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_B_6 = _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0.b;
	float _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_A_7 = _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_RGBA_0.a;
	float3 _Vector3_ed002c12350a46b69f196e5d728582cd_Out_0 = float3(_SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_R_4, _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_G_5, _SampleTexture2D_8f1b742c428643178e7d31f3bf9e9c7a_B_6);
	float3 _Subtract_3a4ad3383c6f43b4825e534b6fcefded_Out_2;
	Unity_Subtract_float3(_Vector3_ed002c12350a46b69f196e5d728582cd_Out_0, float3(0.5, 0.5, 0.5), _Subtract_3a4ad3383c6f43b4825e534b6fcefded_Out_2);
	float3 _Normalize_956cacc929084d28952105a8c1bcea48_Out_1;
	Unity_Normalize_float3(_Subtract_3a4ad3383c6f43b4825e534b6fcefded_Out_2, _Normalize_956cacc929084d28952105a8c1bcea48_Out_1);
	float3 _Add_8543d53668cc40b5a1bc702cfb07701b_Out_2;
	Unity_Add_float3(_Normalize_956cacc929084d28952105a8c1bcea48_Out_1, IN.ObjectSpaceNormal, _Add_8543d53668cc40b5a1bc702cfb07701b_Out_2);
	float3 _Normalize_472c4ae9e2c94183aeab11d54efdf6e9_Out_1;
	Unity_Normalize_float3(_Add_8543d53668cc40b5a1bc702cfb07701b_Out_2, _Normalize_472c4ae9e2c94183aeab11d54efdf6e9_Out_1);
	float _DotProduct_ed89b1c6e5fa4f83ba62172883d90a01_Out_2;
	Unity_DotProduct_float3(_Normalize_472c4ae9e2c94183aeab11d54efdf6e9_Out_1, IN.ObjectSpaceViewDirection, _DotProduct_ed89b1c6e5fa4f83ba62172883d90a01_Out_2);
	float _Saturate_9dc8013924fd4863b579da0965a6c1e2_Out_1;
	Unity_Saturate_float(_DotProduct_ed89b1c6e5fa4f83ba62172883d90a01_Out_2, _Saturate_9dc8013924fd4863b579da0965a6c1e2_Out_1);
	float _Property_410af66ac63f4b6ca91752d4e6c8c4b1_Out_0 = Vector1_f6677799b193415b8be7686b658a6e85;
	float _Add_225974d87fe74eed99d56fbe9aea1572_Out_2;
	Unity_Add_float(_Property_410af66ac63f4b6ca91752d4e6c8c4b1_Out_0, 1, _Add_225974d87fe74eed99d56fbe9aea1572_Out_2);
	float _Exponential_8ae78e15f67946618ffb2645de1f1589_Out_1;
	Unity_Exponential2_float(_Add_225974d87fe74eed99d56fbe9aea1572_Out_2, _Exponential_8ae78e15f67946618ffb2645de1f1589_Out_1);
	float _Power_3eee35aa9ed846d7a8ccf6fe2caa881f_Out_2;
	Unity_Power_float(_Saturate_9dc8013924fd4863b579da0965a6c1e2_Out_1, _Exponential_8ae78e15f67946618ffb2645de1f1589_Out_1, _Power_3eee35aa9ed846d7a8ccf6fe2caa881f_Out_2);
	float4 _Property_c551a4d6fd90454c8320eac950ac91da_Out_0 = IsGammaSpace() ? LinearToSRGB(Color_1bf9c5e6f5c34360a490da1c94e6a7c1) : Color_1bf9c5e6f5c34360a490da1c94e6a7c1;
	float4 _Multiply_7499b43960a14a42bdb8aafd89235b59_Out_2;
	Unity_Multiply_float((_Power_3eee35aa9ed846d7a8ccf6fe2caa881f_Out_2.xxxx), _Property_c551a4d6fd90454c8320eac950ac91da_Out_0, _Multiply_7499b43960a14a42bdb8aafd89235b59_Out_2);
	float4 _Lerp_e45407912adb4284a451fec5b49c8abc_Out_3;
	Unity_Lerp_float4(_Multiply_f86d698f353e49b8ac4e704412805883_Out_2, _Multiply_7499b43960a14a42bdb8aafd89235b59_Out_2, (_Step_d74a28341b3b47d2b929db9c36d76662_Out_2.xxxx), _Lerp_e45407912adb4284a451fec5b49c8abc_Out_3);
	float4 _Add_7daf6aeef3334209844501eb66f273d6_Out_2;
	Unity_Add_float4(float4(0, 0, 0, 0), _Lerp_e45407912adb4284a451fec5b49c8abc_Out_3, _Add_7daf6aeef3334209844501eb66f273d6_Out_2);
	surface.BaseColor = (_Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3.xyz);
	surface.Emission = (_Add_7daf6aeef3334209844501eb66f273d6_Out_2.xyz);
	return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
	VertexDescriptionInputs output;
	ZERO_INITIALIZE(VertexDescriptionInputs, output);

	output.ObjectSpaceNormal = input.normalOS;
	output.ObjectSpaceTangent = input.tangentOS.xyz;
	output.ObjectSpacePosition = input.positionOS;

	return output;
}
	SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
	SurfaceDescriptionInputs output;
	ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
	float3 unnormalizedNormalWS = input.normalWS;
	const float renormFactor = 1.0 / length(unnormalizedNormalWS);


	output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
	output.ObjectSpaceNormal = normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale


	output.WorldSpaceViewDirection = input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
	output.ObjectSpaceViewDirection = TransformWorldToObjectDir(output.WorldSpaceViewDirection);
	output.uv0 = input.texCoord0;
	output.uv1 = input.texCoord1;
#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

	return output;
}

	// --------------------------------------------------
	// Main

	#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"

	ENDHLSL
}
Pass
{
		// Name: <None>
		Tags
		{
			"LightMode" = "Universal2D"
		}

		// Render State
		Cull Back
	Blend One Zero
	ZTest LEqual
	ZWrite On

		// Debug
		// <None>

		// --------------------------------------------------
		// Pass

		HLSLPROGRAM

		// Pragmas
		#pragma target 2.0
	#pragma only_renderers gles gles3 glcore d3d11
	#pragma multi_compile_instancing
	#pragma vertex vert
	#pragma fragment frag

		// DotsInstancingOptions: <None>
		// HybridV1InjectedBuiltinProperties: <None>

		// Keywords
		// PassKeywords: <None>
		// GraphKeywords: <None>

		// Defines
		#define _NORMALMAP 1
		#define _NORMAL_DROPOFF_TS 1
		#define ATTRIBUTES_NEED_NORMAL
		#define ATTRIBUTES_NEED_TANGENT
		#define ATTRIBUTES_NEED_TEXCOORD0
		#define ATTRIBUTES_NEED_TEXCOORD1
		#define VARYINGS_NEED_TEXCOORD0
		#define VARYINGS_NEED_TEXCOORD1
		#define FEATURES_GRAPH_VERTEX
		/* WARNING: $splice Could not find named fragment 'PassInstancing' */
		#define SHADERPASS SHADERPASS_2D
		/* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

		// Includes
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
	#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

		// --------------------------------------------------
		// Structs and Packing

		struct Attributes
	{
		float3 positionOS : POSITION;
		float3 normalOS : NORMAL;
		float4 tangentOS : TANGENT;
		float4 uv0 : TEXCOORD0;
		float4 uv1 : TEXCOORD1;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : INSTANCEID_SEMANTIC;
		#endif
	};
	struct Varyings
	{
		float4 positionCS : SV_POSITION;
		float4 texCoord0;
		float4 texCoord1;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};
	struct SurfaceDescriptionInputs
	{
		float4 uv0;
		float4 uv1;
	};
	struct VertexDescriptionInputs
	{
		float3 ObjectSpaceNormal;
		float3 ObjectSpaceTangent;
		float3 ObjectSpacePosition;
	};
	struct PackedVaryings
	{
		float4 positionCS : SV_POSITION;
		float4 interp0 : TEXCOORD0;
		float4 interp1 : TEXCOORD1;
		#if UNITY_ANY_INSTANCING_ENABLED
		uint instanceID : CUSTOM_INSTANCE_ID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
		#endif
	};

		PackedVaryings PackVaryings(Varyings input)
	{
		PackedVaryings output;
		output.positionCS = input.positionCS;
		output.interp0.xyzw = input.texCoord0;
		output.interp1.xyzw = input.texCoord1;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}
	Varyings UnpackVaryings(PackedVaryings input)
	{
		Varyings output;
		output.positionCS = input.positionCS;
		output.texCoord0 = input.interp0.xyzw;
		output.texCoord1 = input.interp1.xyzw;
		#if UNITY_ANY_INSTANCING_ENABLED
		output.instanceID = input.instanceID;
		#endif
		#if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
		output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
		#endif
		#if (defined(UNITY_STEREO_INSTANCING_ENABLED))
		output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
		#endif
		#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
		output.cullFace = input.cullFace;
		#endif
		return output;
	}

	// --------------------------------------------------
	// Graph

	// Graph Properties
	CBUFFER_START(UnityPerMaterial)
float4 _BaseMap_TexelSize;
float4 _BaseColor;
float4 _MRAMap_TexelSize;
float _Smoothness;
float _OcclusionStrength;
float4 _BumpMap_TexelSize;
float4 _EmissionColor;
float Vector1_f104b915aaef41b69539acbf337f0b81;
float4 _CheekMap_TexelSize;
float4 Vector4_700df69d953c4e0e8d13cc36c1e28d41;
float4 _LipMap_TexelSize;
float4 Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1;
float4 _EyeShadowMap_TexelSize;
float4 Vector4_79165151a1a14973895d00e05edb1141;
float4 _PupilMap_TexelSize;
float4 Vector4_3c5a0575ad994c0484082879b48be7eb;
float4 _MaskMap_TexelSize;
float Vector1_7bf270fe91494824b4209d2dc1faae23;
float Vector1_0de750b9c41b4a5daef844a1599f5ac7;
float Vector1_2871f666316541908d110962eef07f02;
float Vector1_b5cc7f6f25194a778cb438f45fbbce66;
float Vector1_8e760635099b4147956bb9600d13cac2;
float4 _GlitterMap_TexelSize;
float2 Vector2_55edcb19ba1d459dbb3c027e66abbc1e;
float Vector1_f6677799b193415b8be7686b658a6e85;
float4 Color_1bf9c5e6f5c34360a490da1c94e6a7c1;
float Vector1_353a19306a364e939d35b1adffceaf21;
float Vector1_9e8e677800b644e19c377f91787c52f4;
float4 Texture2D_f176501ab1eb4c009adb04a9e3357df5_TexelSize;
float Vector1_8198268cf31e477b821e90f882ffb838;
float4 Color_4411c24bb9114a90bac0609a3e38417f;
float4 Color_3d38e1bc34e4408ca62ad21c702a4991;
float2 Vector2_d7f0b0cac82442babeaa593fef472e04;
float Vector1_f66b7945f53b4d85aa034d136a32a8b2;
CBUFFER_END

// Object and Global properties
SAMPLER(SamplerState_Linear_Repeat);
SAMPLER(SamplerState_Point_Repeat);
TEXTURE2D(_BaseMap);
SAMPLER(sampler_BaseMap);
TEXTURE2D(_MRAMap);
SAMPLER(sampler_MRAMap);
TEXTURE2D(_BumpMap);
SAMPLER(sampler_BumpMap);
TEXTURE2D(_CheekMap);
SAMPLER(sampler_CheekMap);
TEXTURE2D(_LipMap);
SAMPLER(sampler_LipMap);
TEXTURE2D(_EyeShadowMap);
SAMPLER(sampler_EyeShadowMap);
TEXTURE2D(_PupilMap);
SAMPLER(sampler_PupilMap);
TEXTURE2D(_MaskMap);
SAMPLER(sampler_MaskMap);
TEXTURE2D(_GlitterMap);
SAMPLER(sampler_GlitterMap);
TEXTURE2D(Texture2D_f176501ab1eb4c009adb04a9e3357df5);
SAMPLER(samplerTexture2D_f176501ab1eb4c009adb04a9e3357df5);

// Graph Functions

void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
{
	Out = A * B;
}

void Unity_Add_float(float A, float B, out float Out)
{
	Out = A + B;
}

void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
{
	RGBA = float4(R, G, B, A);
	RGB = float3(R, G, B);
	RG = float2(R, G);
}

void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
{
	Out = lerp(A, B, T);
}

void Unity_OneMinus_float(float In, out float Out)
{
	Out = 1 - In;
}


float2 Unity_GradientNoise_Dir_float(float2 p)
{
	// Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
	p = p % 289;
	// need full precision, otherwise half overflows when p > 1
	float x = float(34 * p.x + 1) * p.x % 289 + p.y;
	x = (34 * x + 1) * x % 289;
	x = frac(x / 41) * 2 - 1;
	return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
}

void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
{
	float2 p = UV * Scale;
	float2 ip = floor(p);
	float2 fp = frac(p);
	float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
	float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
	float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
	float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
	fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
	Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
}

void Unity_Multiply_float(float A, float B, out float Out)
{
	Out = A * B;
}

void Unity_Step_float(float Edge, float In, out float Out)
{
	Out = step(Edge, In);
}

// Graph Vertex
struct VertexDescription
{
	float3 Position;
	float3 Normal;
	float3 Tangent;
};

VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
{
	VertexDescription description = (VertexDescription)0;
	description.Position = IN.ObjectSpacePosition;
	description.Normal = IN.ObjectSpaceNormal;
	description.Tangent = IN.ObjectSpaceTangent;
	return description;
}

// Graph Pixel
struct SurfaceDescription
{
	float3 BaseColor;
};

SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
{
	SurfaceDescription surface = (SurfaceDescription)0;
	UnityTexture2D _Property_46f41194bebd49dd90523a9187559d47_Out_0 = UnityBuildTexture2DStructNoScale(_BaseMap);
	float4 _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0 = SAMPLE_TEXTURE2D(_Property_46f41194bebd49dd90523a9187559d47_Out_0.tex, _Property_46f41194bebd49dd90523a9187559d47_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_R_4 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.r;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_G_5 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.g;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_B_6 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.b;
	float _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_A_7 = _SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0.a;
	float4 _Property_3cc81970230a4e2680f1056abe28f14c_Out_0 = _BaseColor;
	float4 _Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2;
	Unity_Multiply_float(_SampleTexture2D_df95a009d9374c2eb5e675bbb3e66274_RGBA_0, _Property_3cc81970230a4e2680f1056abe28f14c_Out_0, _Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2);
	UnityTexture2D _Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0 = UnityBuildTexture2DStructNoScale(_CheekMap);
	float4 _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0 = Vector4_700df69d953c4e0e8d13cc36c1e28d41;
	float _Split_5022297589804f21900b69c657b81fa0_R_1 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[0];
	float _Split_5022297589804f21900b69c657b81fa0_G_2 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[1];
	float _Split_5022297589804f21900b69c657b81fa0_B_3 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[2];
	float _Split_5022297589804f21900b69c657b81fa0_A_4 = _Property_46ce5c848a754966a2261f09e5bc9c9a_Out_0[3];
	float4 _UV_5c27d34f7fe0493fa46cacf01b32cccc_Out_0 = IN.uv1;
	float4 _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2;
	Unity_Multiply_float((_Split_5022297589804f21900b69c657b81fa0_R_1.xxxx), _UV_5c27d34f7fe0493fa46cacf01b32cccc_Out_0, _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2);
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_R_1 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[0];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_G_2 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[1];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_B_3 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[2];
	float _Split_f75341ed066d43c2ba64dd1807c3cdd5_A_4 = _Multiply_43134e158ee14608ba58f7dd5eaa6c0a_Out_2[3];
	float _Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2;
	Unity_Add_float(_Split_5022297589804f21900b69c657b81fa0_G_2, _Split_f75341ed066d43c2ba64dd1807c3cdd5_R_1, _Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2);
	float _Add_b8d09a71819044be96521761cc153267_Out_2;
	Unity_Add_float(_Split_f75341ed066d43c2ba64dd1807c3cdd5_G_2, _Split_5022297589804f21900b69c657b81fa0_B_3, _Add_b8d09a71819044be96521761cc153267_Out_2);
	float4 _Combine_0939f9cc49e54d3ea511e937525deee6_RGBA_4;
	float3 _Combine_0939f9cc49e54d3ea511e937525deee6_RGB_5;
	float2 _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6;
	Unity_Combine_float(_Add_5d4d39d70e364d359d2432123e9f7bf0_Out_2, _Add_b8d09a71819044be96521761cc153267_Out_2, 0, 0, _Combine_0939f9cc49e54d3ea511e937525deee6_RGBA_4, _Combine_0939f9cc49e54d3ea511e937525deee6_RGB_5, _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6);
	float4 _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0 = SAMPLE_TEXTURE2D(_Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0.tex, _Property_a6ebd7bc2f934758b07f5273a9c978a9_Out_0.samplerstate, _Combine_0939f9cc49e54d3ea511e937525deee6_RG_6);
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_R_4 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.r;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_G_5 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.g;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_B_6 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.b;
	float _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_A_7 = _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0.a;
	float4 _Lerp_2241ae8feb5941da9183bb461c252132_Out_3;
	Unity_Lerp_float4(_Multiply_d996221b1c124c6785f5f782cc062cf6_Out_2, _SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_RGBA_0, (_SampleTexture2D_7488b86cafee4f6c90dfd6ed2e805c56_A_7.xxxx), _Lerp_2241ae8feb5941da9183bb461c252132_Out_3);
	UnityTexture2D _Property_5f8a386b21984e2988fde7598f635a9a_Out_0 = UnityBuildTexture2DStructNoScale(_LipMap);
	float4 _Property_c857b47c21154b86a27f46398299df91_Out_0 = Vector4_9d3f8ed9076b4d2cae5ace115d16ffb1;
	float _Split_f308ae64287f48e8872c952e6828cb36_R_1 = _Property_c857b47c21154b86a27f46398299df91_Out_0[0];
	float _Split_f308ae64287f48e8872c952e6828cb36_G_2 = _Property_c857b47c21154b86a27f46398299df91_Out_0[1];
	float _Split_f308ae64287f48e8872c952e6828cb36_B_3 = _Property_c857b47c21154b86a27f46398299df91_Out_0[2];
	float _Split_f308ae64287f48e8872c952e6828cb36_A_4 = _Property_c857b47c21154b86a27f46398299df91_Out_0[3];
	float4 _UV_c1af69e74f4e4df791b33b8f07716d5b_Out_0 = IN.uv1;
	float4 _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2;
	Unity_Multiply_float((_Split_f308ae64287f48e8872c952e6828cb36_R_1.xxxx), _UV_c1af69e74f4e4df791b33b8f07716d5b_Out_0, _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2);
	float _Split_3123c7f71f9749b2aa01689ddefb9374_R_1 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[0];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_G_2 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[1];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_B_3 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[2];
	float _Split_3123c7f71f9749b2aa01689ddefb9374_A_4 = _Multiply_7e8e4312c6d44006a532fc5a041722a5_Out_2[3];
	float _Add_f2f7dee5f2844fb8822bccad48406ade_Out_2;
	Unity_Add_float(_Split_f308ae64287f48e8872c952e6828cb36_G_2, _Split_3123c7f71f9749b2aa01689ddefb9374_R_1, _Add_f2f7dee5f2844fb8822bccad48406ade_Out_2);
	float _Add_5287d7b9aac546af90e5e834b37567d2_Out_2;
	Unity_Add_float(_Split_3123c7f71f9749b2aa01689ddefb9374_G_2, _Split_f308ae64287f48e8872c952e6828cb36_B_3, _Add_5287d7b9aac546af90e5e834b37567d2_Out_2);
	float4 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGBA_4;
	float3 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGB_5;
	float2 _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6;
	Unity_Combine_float(_Add_f2f7dee5f2844fb8822bccad48406ade_Out_2, _Add_5287d7b9aac546af90e5e834b37567d2_Out_2, 0, 0, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGBA_4, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RGB_5, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6);
	float4 _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_5f8a386b21984e2988fde7598f635a9a_Out_0.tex, _Property_5f8a386b21984e2988fde7598f635a9a_Out_0.samplerstate, _Combine_0f43c8633e524a4ab7d2ec0050d34fa5_RG_6);
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_R_4 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.r;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_G_5 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.g;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_B_6 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.b;
	float _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_A_7 = _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0.a;
	float4 _Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3;
	Unity_Lerp_float4(_Lerp_2241ae8feb5941da9183bb461c252132_Out_3, _SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_RGBA_0, (_SampleTexture2D_cb5f317b70164be08753f0c7a2655e8a_A_7.xxxx), _Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3);
	UnityTexture2D _Property_034f7053a4c04630b179945137478563_Out_0 = UnityBuildTexture2DStructNoScale(_EyeShadowMap);
	float4 _Property_ec0501c48b2f47fca24e4415b083a817_Out_0 = Vector4_79165151a1a14973895d00e05edb1141;
	float _Split_a65775607697471ebf0abd88cba1cc94_R_1 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[0];
	float _Split_a65775607697471ebf0abd88cba1cc94_G_2 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[1];
	float _Split_a65775607697471ebf0abd88cba1cc94_B_3 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[2];
	float _Split_a65775607697471ebf0abd88cba1cc94_A_4 = _Property_ec0501c48b2f47fca24e4415b083a817_Out_0[3];
	float4 _UV_561d401f6e7242d99119d7be74ed408f_Out_0 = IN.uv1;
	float4 _Multiply_9434dd79d3204d6f97de52affd770331_Out_2;
	Unity_Multiply_float((_Split_a65775607697471ebf0abd88cba1cc94_R_1.xxxx), _UV_561d401f6e7242d99119d7be74ed408f_Out_0, _Multiply_9434dd79d3204d6f97de52affd770331_Out_2);
	float _Split_48b01121140e4699b1b0d4a54f925206_R_1 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[0];
	float _Split_48b01121140e4699b1b0d4a54f925206_G_2 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[1];
	float _Split_48b01121140e4699b1b0d4a54f925206_B_3 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[2];
	float _Split_48b01121140e4699b1b0d4a54f925206_A_4 = _Multiply_9434dd79d3204d6f97de52affd770331_Out_2[3];
	float _Add_70cfb275974e4ed78884eb9ddb51407c_Out_2;
	Unity_Add_float(_Split_a65775607697471ebf0abd88cba1cc94_G_2, _Split_48b01121140e4699b1b0d4a54f925206_R_1, _Add_70cfb275974e4ed78884eb9ddb51407c_Out_2);
	float _Add_bf85759250cd46a5a834e59e8174d47f_Out_2;
	Unity_Add_float(_Split_48b01121140e4699b1b0d4a54f925206_G_2, _Split_a65775607697471ebf0abd88cba1cc94_B_3, _Add_bf85759250cd46a5a834e59e8174d47f_Out_2);
	float4 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGBA_4;
	float3 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGB_5;
	float2 _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6;
	Unity_Combine_float(_Add_70cfb275974e4ed78884eb9ddb51407c_Out_2, _Add_bf85759250cd46a5a834e59e8174d47f_Out_2, 0, 0, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGBA_4, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RGB_5, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6);
	float4 _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0 = SAMPLE_TEXTURE2D(_Property_034f7053a4c04630b179945137478563_Out_0.tex, _Property_034f7053a4c04630b179945137478563_Out_0.samplerstate, _Combine_f4a8deb695704e5c9786f6ab35f89df9_RG_6);
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_R_4 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.r;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_G_5 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.g;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_B_6 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.b;
	float _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_A_7 = _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0.a;
	float4 _Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3;
	Unity_Lerp_float4(_Lerp_9f1d018c0296404ab10180d96ec46f3c_Out_3, _SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_RGBA_0, (_SampleTexture2D_9c9a73e3ef9f452e8de974f6a4220fe4_A_7.xxxx), _Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3);
	UnityTexture2D _Property_f0ad144d6d604946a0265c0ff45af34a_Out_0 = UnityBuildTexture2DStructNoScale(_PupilMap);
	float4 _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0 = Vector4_3c5a0575ad994c0484082879b48be7eb;
	float _Split_597b0aa14ac147bb8547d10058ea208e_R_1 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[0];
	float _Split_597b0aa14ac147bb8547d10058ea208e_G_2 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[1];
	float _Split_597b0aa14ac147bb8547d10058ea208e_B_3 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[2];
	float _Split_597b0aa14ac147bb8547d10058ea208e_A_4 = _Property_5a22c7a4eb544bd39aa30a910ffcc3a1_Out_0[3];
	float4 _UV_fa01ab9e6ed045c0932df0bd20747d29_Out_0 = IN.uv1;
	float4 _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2;
	Unity_Multiply_float((_Split_597b0aa14ac147bb8547d10058ea208e_R_1.xxxx), _UV_fa01ab9e6ed045c0932df0bd20747d29_Out_0, _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2);
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_R_1 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[0];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_G_2 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[1];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_B_3 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[2];
	float _Split_6051d27c6349400fbb5a5932d8d2c7ad_A_4 = _Multiply_9067a2a563e849779adf36aec0f7f645_Out_2[3];
	float _Add_8655d6d32b1b40259250182a69e8b8b7_Out_2;
	Unity_Add_float(_Split_597b0aa14ac147bb8547d10058ea208e_G_2, _Split_6051d27c6349400fbb5a5932d8d2c7ad_R_1, _Add_8655d6d32b1b40259250182a69e8b8b7_Out_2);
	float _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2;
	Unity_Add_float(_Split_6051d27c6349400fbb5a5932d8d2c7ad_G_2, _Split_597b0aa14ac147bb8547d10058ea208e_B_3, _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2);
	float4 _Combine_3c3cf19616e143188639a90935b8a10b_RGBA_4;
	float3 _Combine_3c3cf19616e143188639a90935b8a10b_RGB_5;
	float2 _Combine_3c3cf19616e143188639a90935b8a10b_RG_6;
	Unity_Combine_float(_Add_8655d6d32b1b40259250182a69e8b8b7_Out_2, _Add_5fee62da1bba4f8e9ad52034f6f7df51_Out_2, 0, 0, _Combine_3c3cf19616e143188639a90935b8a10b_RGBA_4, _Combine_3c3cf19616e143188639a90935b8a10b_RGB_5, _Combine_3c3cf19616e143188639a90935b8a10b_RG_6);
	float4 _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0 = SAMPLE_TEXTURE2D(_Property_f0ad144d6d604946a0265c0ff45af34a_Out_0.tex, _Property_f0ad144d6d604946a0265c0ff45af34a_Out_0.samplerstate, _Combine_3c3cf19616e143188639a90935b8a10b_RG_6);
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_R_4 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.r;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_G_5 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.g;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_B_6 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.b;
	float _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_A_7 = _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0.a;
	float4 _Lerp_9134832094eb464f874ea325fccb805d_Out_3;
	Unity_Lerp_float4(_Lerp_3865eb99f5384f8089bf4da6fa55a7a7_Out_3, _SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_RGBA_0, (_SampleTexture2D_a46b5467475f47c6b9ad6c49104c88e7_A_7.xxxx), _Lerp_9134832094eb464f874ea325fccb805d_Out_3);
	UnityTexture2D _Property_33d05c2bee3a48cbad54c88a071627d0_Out_0 = UnityBuildTexture2DStructNoScale(_MaskMap);
	float4 _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0 = SAMPLE_TEXTURE2D(_Property_33d05c2bee3a48cbad54c88a071627d0_Out_0.tex, _Property_33d05c2bee3a48cbad54c88a071627d0_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_R_4 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.r;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_G_5 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.g;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_B_6 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.b;
	float _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_A_7 = _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0.a;
	UnityTexture2D _Property_90c3e617459146b89270ca735ff67027_Out_0 = UnityBuildTexture2DStructNoScale(_MaskMap);
	float4 _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0 = SAMPLE_TEXTURE2D(_Property_90c3e617459146b89270ca735ff67027_Out_0.tex, _Property_90c3e617459146b89270ca735ff67027_Out_0.samplerstate, IN.uv0.xy);
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_R_4 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.r;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_G_5 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.g;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_B_6 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.b;
	float _SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7 = _SampleTexture2D_a6a20b1ab84d42c59036028210848629_RGBA_0.a;
	float _OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1;
	Unity_OneMinus_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1);
	float _Property_1a86dcb475f34e9c8bb3d74526142f51_Out_0 = Vector1_2871f666316541908d110962eef07f02;
	float _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2;
	Unity_GradientNoise_float(IN.uv0.xy, _Property_1a86dcb475f34e9c8bb3d74526142f51_Out_0, _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2);
	float _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2;
	Unity_Multiply_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _GradientNoise_d0fda5868f6b4db68479a71ea3297cf3_Out_2, _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2);
	float _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2;
	Unity_Add_float(_SampleTexture2D_a6a20b1ab84d42c59036028210848629_A_7, _Multiply_111d3aad4d3b47bc962dd03e407442da_Out_2, _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2);
	float _Step_d74a28341b3b47d2b929db9c36d76662_Out_2;
	Unity_Step_float(_OneMinus_44bcc4e64933434780f8b817d3a0dffc_Out_1, _Add_9b0f9aa955274ecab73a1af354d451a4_Out_2, _Step_d74a28341b3b47d2b929db9c36d76662_Out_2);
	float4 _Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3;
	Unity_Lerp_float4(_Lerp_9134832094eb464f874ea325fccb805d_Out_3, _SampleTexture2D_81ce0df4d3414290bb280579f286d0af_RGBA_0, (_Step_d74a28341b3b47d2b929db9c36d76662_Out_2.xxxx), _Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3);
	surface.BaseColor = (_Lerp_fd0649bfe0094f3b99ab1014b5f4359a_Out_3.xyz);
	return surface;
}

// --------------------------------------------------
// Build Graph Inputs

VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
{
	VertexDescriptionInputs output;
	ZERO_INITIALIZE(VertexDescriptionInputs, output);

	output.ObjectSpaceNormal = input.normalOS;
	output.ObjectSpaceTangent = input.tangentOS.xyz;
	output.ObjectSpacePosition = input.positionOS;

	return output;
}
	SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
{
	SurfaceDescriptionInputs output;
	ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





	output.uv0 = input.texCoord0;
	output.uv1 = input.texCoord1;
#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
#else
#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
#endif
#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

	return output;
}

	// --------------------------------------------------
	// Main

	#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"

	ENDHLSL
}
	}
		CustomEditor "ShaderGraph.PBRMasterGUI"
		FallBack "Hidden/Shader Graph/FallbackError"
}