// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "CSG/Special" {
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader {
        Tags { "RenderType"="Opaque" "Queue"="Geometry+1"}
        Cull front
		//ZTest NotEqual
        Colormask 0
       
        CGINCLUDE
            struct appdata {
                float4 vertex : POSITION;
            };
            struct v2f {
                float4 pos : SV_POSITION;
            };
            v2f vert(appdata v) {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
            float4 frag(v2f i) : SV_Target {
                return float4(1,1,0,1);
            }
        ENDCG
        Pass
        {
            Tags {"Queue"="Geometry+3" }
            Cull Front
            ColorMask 0
           
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            ENDCG
       
        }
        Pass
        {
            Tags {"Queue"="Geometry+4" }
            Cull Back
            ZTest Equal
            ColorMask rgba
           
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            ENDCG
       
        }
    }
    FallBack "Diffuse"
}