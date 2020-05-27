
Shader "Sine Wave/Modern/Justin's Hair Shader 1.0" {
	Properties{
		//_Color("Color", Color) = (1,1,1,1)
		_Color1("Color 1", Color) = (0.8584906,0.8524513,0.1822268,1)
		_Color0("Color 0", Color) = (0.8026462,0.1579299,0.8584906,1)
		_Color2("Color 2", Color) = (0.3691939,0.6981132,0.3457636,1)
		_Color3("Color 3", Color) = (1,0,0,1)
		_Gradient_B_L("Gradient_B_L", 2D) = "white" {}
		_Gradient_B_R("Gradient_B_R", 2D) = "white" {}
		_Gradient_T_L("Gradient_T_L", 2D) = "white" {}
		_Gradient_T_R("Gradient_T_R", 2D) = "white" {}
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
		_TangentMap("Tangent Map (RG)", 2D) = "white" {}
		_Fresnel("Fresnel Power", Range(0,30)) = 1.0
		_FresnelDamp("Fresnel Damp", Range(0,1)) = 1.0
		_Anisotropy("Anisotropy", Range(0,1)) = 1.0
		_Distortion("Translucent Distortion", Range(0,5)) = 1.0
		_Scale("Translucent Scale", Range(0,5)) = 1.0
		_Power("Translucent Power", Range(0,5)) = 1.0
		_Cutoff("Alpha Cutoff", Range(0,1)) = 0.5
		//_Albedo("Albedo", Range(0,1)) = 1.0
	}
		SubShader{
			Tags { "RenderType" = "Transparent" "Queue" = "Transparent"}
			LOD 200

			Cull Back

			CGPROGRAM
			#include "UnityCG.cginc"
			#include "CGIncludes/UnityAnisotropicBRDF.cginc"
			#include "CGIncludes/UnityAnisotropicLighting.cginc"
			#include "CGIncludes/UnityTranslucentLighting.cginc"
			#define UNITY_BRDF_PBS BRDF_Unity_Anisotropic
			// Physically based Standard lighting model, and enable shadows on all light types
			#pragma surface AnisotropicSurface StandardTranslucent vertex:vert fullforwardshadows alphatest:_Cutoff nolightmap

			// Use shader model 3.0 target, to get nicer looking lighting
			#pragma target 3.0

			sampler2D _MainTex;
			sampler2D _TangentMap;
			float _Anisotropy;

			uniform float4 _Color0;
			uniform sampler2D _Gradient_T_L;
			uniform float4 _Gradient_T_L_ST;
			uniform float4 _Color1;
			uniform sampler2D _Gradient_T_R;
			uniform float4 _Gradient_T_R_ST;
			uniform float4 _Color2;
			uniform sampler2D _Gradient_B_L;
			uniform float4 _Gradient_B_L_ST;
			uniform float4 _Color3;
			uniform sampler2D _Gradient_B_R;
			uniform float4 _Gradient_B_R_ST;
			uniform float _Metalic;
			uniform float _Smoothness;
			uniform float _AO;

			//Vertex struct
			struct Input
			{
				float2 uv_MainTex;
				float3 normal;
				float3 viewDir;
				float3 normalDir;
				float3 tangentDir;
				float3 bitangentDir;

				//float4 _Color0;
				//float4 _Color1;
				//float4 _Color2;
				//float4 _Color3;
				//float4 _Gradient_T_L_ST;
				//float4 _Gradient_T_R_ST;
				//float4 _Gradient_B_L_ST;
				//float4 _Gradient_B_R_ST;
				//sampler2D _Gradient_B_L;

			};

			//Vertex shader
			void vert(inout appdata_full v, out Input o)
			{
				v.normal *= -1;

				UNITY_INITIALIZE_OUTPUT(Input, o);
				//Normal 2 World
				o.normalDir = normalize(UnityObjectToWorldNormal(v.normal));
				//Tangent 2 World
				float3 tangentMul = normalize(mul(unity_ObjectToWorld, v.tangent.xyz));
				o.tangentDir = float4(tangentMul, v.tangent.w);
				// Bitangent
				o.bitangentDir = cross(o.normalDir, o.tangentDir);
			}

			half _Glossiness;
			half _Metallic;
			fixed4 _Color;

			void AnisotropicSurface(Input IN, inout SurfaceOutputStandardAnisotropic o)
			{
				float2 uv_Gradient_T_L = IN.uv_MainTex * _Gradient_T_L_ST.xy + _Gradient_T_L_ST.zw;
				float4 tex2DNode5 = tex2D(_Gradient_T_L, uv_Gradient_T_L);
				float2 uv_Gradient_T_R = IN.uv_MainTex * _Gradient_T_R_ST.xy + _Gradient_T_R_ST.zw;
				float4 tex2DNode4 = tex2D(_Gradient_T_R, uv_Gradient_T_R);
				float2 uv_Gradient_B_L = IN.uv_MainTex * _Gradient_B_L_ST.xy + _Gradient_B_L_ST.zw;
				float4 tex2DNode2 = tex2D(_Gradient_B_L, uv_Gradient_B_L);
				float2 uv_Gradient_B_R = IN.uv_MainTex * _Gradient_B_R_ST.xy + _Gradient_B_R_ST.zw;
				float4 tex2DNode1 = tex2D(_Gradient_B_R, uv_Gradient_B_R);

				fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * ((_Color0 * tex2DNode5 * tex2DNode5.a) + (_Color1 * tex2DNode4 * tex2DNode4.a) + (_Color2 * tex2DNode2 * tex2DNode2.a) + (_Color3 * tex2DNode1 * tex2DNode1.a));
				//fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
				o.Albedo = c;
				o.Metallic = _Metallic;
				o.Smoothness = _Glossiness;
				o.Alpha = c.a;
				o.Anisotropy = _Anisotropy;

				float3x3 worldToTangent;
				worldToTangent[0] = float3(1, 0, 0);
				worldToTangent[1] = float3(0, 1, 0);
				worldToTangent[2] = float3(0, 0, 1);

				float3 tangentTS = tex2D(_TangentMap, IN.uv_MainTex);
				float3 tangentTWS = mul(tangentTS, worldToTangent);
				float3 fTangent;
				if (tangentTS.z < 1)
					fTangent = tangentTWS;
				else
					fTangent = IN.tangentDir;
				o.WorldVectors = float3x3(fTangent, IN.bitangentDir, IN.normalDir);
			}
			ENDCG

			Cull Back

			CGPROGRAM
			#include "UnityCG.cginc"
			#include "CGIncludes/UnityAnisotropicBRDF.cginc"
			#include "CGIncludes/UnityAnisotropicLighting.cginc"
			#include "CGIncludes/UnityTranslucentLighting.cginc"
			#define UNITY_BRDF_PBS BRDF_Unity_Anisotropic
				// Physically based Standard lighting model, and enable shadows on all light types
				#pragma surface AnisotropicSurface StandardTranslucent vertex:vert fullforwardshadows alpha:fade nolightmap

				// Use shader model 3.0 target, to get nicer looking lighting
				#pragma target 3.0

				sampler2D _MainTex;
				sampler2D _TangentMap;
				float _Anisotropy;

				//Vertex struct
				struct Input
				{
					float2 uv_MainTex;
					float3 normal;
					float3 viewDir;
					float3 normalDir;
					float3 tangentDir;
					float3 bitangentDir;
				};

				//Vertex shader
				void vert(inout appdata_full v, out Input o)
				{
					UNITY_INITIALIZE_OUTPUT(Input, o);
					//Normal 2 World
					o.normalDir = normalize(UnityObjectToWorldNormal(v.normal));
					//Tangent 2 World
					float3 tangentMul = normalize(mul(unity_ObjectToWorld, v.tangent.xyz));
					o.tangentDir = float4(tangentMul, v.tangent.w);
					// Bitangent
					o.bitangentDir = cross(o.normalDir, o.tangentDir);
				}

				half _Glossiness;
				half _Metallic;
				fixed4 _Color;
				uniform float4 _Color0;
				uniform sampler2D _Gradient_T_L;
				uniform float4 _Gradient_T_L_ST;
				uniform float4 _Color1;
				uniform sampler2D _Gradient_T_R;
				uniform float4 _Gradient_T_R_ST;
				uniform float4 _Color2;
				uniform sampler2D _Gradient_B_L;
				uniform float4 _Gradient_B_L_ST;
				uniform float4 _Color3;
				uniform sampler2D _Gradient_B_R;
				uniform float4 _Gradient_B_R_ST;
				uniform float _Metalic;
				uniform float _Smoothness;
				uniform float _AO;

				void AnisotropicSurface(Input IN, inout SurfaceOutputStandardAnisotropic o) 
				{

					float2 uv_Gradient_T_L = IN.uv_MainTex * _Gradient_T_L_ST.xy + _Gradient_T_L_ST.zw;
					float4 tex2DNode5 = tex2D(_Gradient_T_L, uv_Gradient_T_L);
					float2 uv_Gradient_T_R = IN.uv_MainTex * _Gradient_T_R_ST.xy + _Gradient_T_R_ST.zw;
					float4 tex2DNode4 = tex2D(_Gradient_T_R, uv_Gradient_T_R);
					float2 uv_Gradient_B_L = IN.uv_MainTex * _Gradient_B_L_ST.xy + _Gradient_B_L_ST.zw;
					float4 tex2DNode2 = tex2D(_Gradient_B_L, uv_Gradient_B_L);
					float2 uv_Gradient_B_R = IN.uv_MainTex * _Gradient_B_R_ST.xy + _Gradient_B_R_ST.zw;
					float4 tex2DNode1 = tex2D(_Gradient_B_R, uv_Gradient_B_R);
					//o.Albedo = ((_Color0 * tex2DNode5 * tex2DNode5.a) + (_Color1 * tex2DNode4 * tex2DNode4.a) + (_Color2 * tex2DNode2 * tex2DNode2.a) + (_Color3 * tex2DNode1 * tex2DNode1.a)).rgb;

					//fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
					fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * ((_Color0 * tex2DNode5 * tex2DNode5.a) + (_Color1 * tex2DNode4 * tex2DNode4.a) + (_Color2 * tex2DNode2 * tex2DNode2.a) + (_Color3 * tex2DNode1 * tex2DNode1.a));
					o.Albedo = c;
					o.Metallic = _Metallic;
					o.Smoothness = _Glossiness;
					o.Alpha = c.a;
					o.Anisotropy = _Anisotropy;

					float3x3 worldToTangent;
					worldToTangent[0] = float3(1, 0, 0);
					worldToTangent[1] = float3(0, 1, 0);
					worldToTangent[2] = float3(0, 0, 1);

					float3 tangentTS = tex2D(_TangentMap, IN.uv_MainTex);
					float3 tangentTWS = mul(tangentTS, worldToTangent);
					float3 fTangent;
					if (tangentTS.z < 1)
						fTangent = tangentTWS;
					else
						fTangent = IN.tangentDir;
					o.WorldVectors = float3x3(fTangent, IN.bitangentDir, IN.normalDir);
				}
				ENDCG
		}
			FallBack "Diffuse"
}
