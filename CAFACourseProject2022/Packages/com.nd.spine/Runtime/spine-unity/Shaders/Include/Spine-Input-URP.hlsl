#ifndef URP_LIT_INPUT_INCLUDED
#define URP_LIT_INPUT_INCLUDED

#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"

////////////////////////////////////////
// Defines
//
#undef LIGHTMAP_ON

CBUFFER_START(UnityPerMaterial)
float4 _MainTex_ST;
half _Cutoff;
float4 _Color;
float _Intensity;
CBUFFER_END

sampler2D _MainTex;

#endif // URP_LIT_INPUT_INCLUDED
