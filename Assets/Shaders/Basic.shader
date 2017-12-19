// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Basic" {
	Properties{
		_MainTex("Texture", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
		_SecondTex("Texture", 2D) = "white" {}
		_Tween("Tween", Range(0, 1)) = 0
	}
	SubShader {
		Tags {
			"Queue" = "Transparent"
		}

		Pass {
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag

#include "UnityCG.cginc"

struct appdata {
	float4 vertex : POSITION;
	float2 uv : TEXCOORD0;
};

struct v2f {
	float4 vertex : SV_POSITION;
	float2 uv : TEXCOORD0;
};

v2f vert(appdata v) {
	v2f o;
	o.vertex = UnityObjectToClipPos(v.vertex);
	o.uv = v.uv;
	return o;
}

sampler2D _MainTex;
sampler2D _SecondTex;
float4 _Color;
float4 _Color2;
float _Tween;

float4 frag(v2f i) : SV_Target{
	//_Color = float4(i.uv.r, i.uv.g, 1, 1);
	//float4 color = tex2D(_MainTex, i.uv * 3) * _Color;
	_Color = float4(1 - _Tween, 1 - _Tween, 1 - _Tween, 1 - _Tween);
	_Color2 = float4(_Tween, _Tween, _Tween, _Tween);
	float4 color = (tex2D(_MainTex, i.uv) * _Color) + (tex2D(_SecondTex, i.uv) * _Color2);
	return color;
}
			ENDCG
		}
	}
}
