// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "JustinsHairShader_V02_01"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.3
		_Color1("Color 1", Color) = (0.8584906,0.8524513,0.1822268,0)
		_Color0("Color 0", Color) = (0.8026462,0.1579299,0.8584906,0)
		_Color2("Color 2", Color) = (0.3691939,0.6981132,0.3457636,0)
		_Color3("Color 3", Color) = (1,0,0,1)
		_Gradient_B_L("Gradient_B_L", 2D) = "white" {}
		_Gradient_B_R("Gradient_B_R", 2D) = "white" {}
		_Gradient_T_L("Gradient_T_L", 2D) = "white" {}
		_Gradient_T_R("Gradient_T_R", 2D) = "white" {}
		_Metalic("Metalic", Range( 0 , 1)) = 1
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_AO("AO", Range( 0 , 1)) = 0
		_Cutoff_Value("Cutoff_Value", Range( 0 , 1)) = 0.5
		_OpacityMask("OpacityMask", Range( 0 , 1)) = 0.5
		_Gradient_Value("Gradient_Value", Range( 0 , 2)) = 1
		_Hair_AlbedoTransparent_L1_01("Hair_AlbedoTransparent_L1_01", 2D) = "white" {}
		_Hair_AlbedoTransparent_L2_01("Hair_AlbedoTransparent_L2_01", 2D) = "white" {}
		_Hair_AlbedoTransparent_L3_01("Hair_AlbedoTransparent_L3_01", 2D) = "white" {}
		_Hair_AlbedoTransparent_L4_01("Hair_AlbedoTransparent_L4_01", 2D) = "white" {}
		[Normal]_Hair_Normal_01("Hair_Normal_01", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Off
		AlphaToMask On
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Hair_Normal_01;
		uniform float4 _Hair_Normal_01_ST;
		uniform sampler2D _Hair_AlbedoTransparent_L1_01;
		uniform float4 _Hair_AlbedoTransparent_L1_01_ST;
		uniform float4 _Color0;
		uniform sampler2D _Hair_AlbedoTransparent_L2_01;
		uniform float4 _Hair_AlbedoTransparent_L2_01_ST;
		uniform float4 _Color1;
		uniform sampler2D _Hair_AlbedoTransparent_L3_01;
		uniform float4 _Hair_AlbedoTransparent_L3_01_ST;
		uniform float4 _Color2;
		uniform sampler2D _Hair_AlbedoTransparent_L4_01;
		uniform float4 _Hair_AlbedoTransparent_L4_01_ST;
		uniform float4 _Color3;
		uniform float _Gradient_Value;
		uniform sampler2D _Gradient_T_L;
		uniform float4 _Gradient_T_L_ST;
		uniform sampler2D _Gradient_T_R;
		uniform float4 _Gradient_T_R_ST;
		uniform sampler2D _Gradient_B_L;
		uniform float4 _Gradient_B_L_ST;
		uniform sampler2D _Gradient_B_R;
		uniform float4 _Gradient_B_R_ST;
		uniform float _Metalic;
		uniform float _Smoothness;
		uniform float _AO;
		uniform float _Cutoff_Value;
		uniform float _OpacityMask;
		uniform float _Cutoff = 0.3;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Hair_Normal_01 = i.uv_texcoord * _Hair_Normal_01_ST.xy + _Hair_Normal_01_ST.zw;
			o.Normal = UnpackNormal( tex2D( _Hair_Normal_01, uv_Hair_Normal_01 ) );
			float2 uv_Hair_AlbedoTransparent_L1_01 = i.uv_texcoord * _Hair_AlbedoTransparent_L1_01_ST.xy + _Hair_AlbedoTransparent_L1_01_ST.zw;
			float4 tex2DNode17 = tex2D( _Hair_AlbedoTransparent_L1_01, uv_Hair_AlbedoTransparent_L1_01 );
			float4 temp_output_31_0 = ( tex2DNode17 * _Color0 * tex2DNode17.a );
			float2 uv_Hair_AlbedoTransparent_L2_01 = i.uv_texcoord * _Hair_AlbedoTransparent_L2_01_ST.xy + _Hair_AlbedoTransparent_L2_01_ST.zw;
			float4 tex2DNode18 = tex2D( _Hair_AlbedoTransparent_L2_01, uv_Hair_AlbedoTransparent_L2_01 );
			float4 temp_output_32_0 = ( tex2DNode18 * _Color1 * tex2DNode18.a );
			float4 blendOpSrc70 = temp_output_31_0;
			float4 blendOpDest70 = temp_output_32_0;
			float2 uv_Hair_AlbedoTransparent_L3_01 = i.uv_texcoord * _Hair_AlbedoTransparent_L3_01_ST.xy + _Hair_AlbedoTransparent_L3_01_ST.zw;
			float4 tex2DNode19 = tex2D( _Hair_AlbedoTransparent_L3_01, uv_Hair_AlbedoTransparent_L3_01 );
			float4 temp_output_33_0 = ( tex2DNode19 * _Color2 * tex2DNode19.a );
			float2 uv_Hair_AlbedoTransparent_L4_01 = i.uv_texcoord * _Hair_AlbedoTransparent_L4_01_ST.xy + _Hair_AlbedoTransparent_L4_01_ST.zw;
			float4 tex2DNode20 = tex2D( _Hair_AlbedoTransparent_L4_01, uv_Hair_AlbedoTransparent_L4_01 );
			float4 temp_output_27_0 = ( tex2DNode20 * _Color3 * tex2DNode20.a );
			float4 blendOpSrc72 = temp_output_33_0;
			float4 blendOpDest72 = temp_output_27_0;
			float4 blendOpSrc71 = ( saturate( 	max( blendOpSrc70, blendOpDest70 ) ));
			float4 blendOpDest71 = ( saturate( 	max( blendOpSrc72, blendOpDest72 ) ));
			float2 uv_Gradient_T_L = i.uv_texcoord * _Gradient_T_L_ST.xy + _Gradient_T_L_ST.zw;
			float4 tex2DNode5 = tex2D( _Gradient_T_L, uv_Gradient_T_L );
			float2 uv_Gradient_T_R = i.uv_texcoord * _Gradient_T_R_ST.xy + _Gradient_T_R_ST.zw;
			float4 tex2DNode4 = tex2D( _Gradient_T_R, uv_Gradient_T_R );
			float2 uv_Gradient_B_L = i.uv_texcoord * _Gradient_B_L_ST.xy + _Gradient_B_L_ST.zw;
			float4 tex2DNode2 = tex2D( _Gradient_B_L, uv_Gradient_B_L );
			float2 uv_Gradient_B_R = i.uv_texcoord * _Gradient_B_R_ST.xy + _Gradient_B_R_ST.zw;
			float4 tex2DNode1 = tex2D( _Gradient_B_R, uv_Gradient_B_R );
			o.Albedo = ( ( saturate( 	max( blendOpSrc71, blendOpDest71 ) )) * ( ( _Gradient_Value * tex2DNode5 * tex2DNode5.a ) + ( _Gradient_Value * tex2DNode4 * tex2DNode4.a ) + ( _Gradient_Value * tex2DNode2 * tex2DNode2.a ) + ( _Gradient_Value * tex2DNode1 * tex2DNode1.a ) ) ).rgb;
			float temp_output_16_0 = _Metalic;
			o.Metallic = temp_output_16_0;
			o.Smoothness = _Smoothness;
			o.Occlusion = _AO;
			o.Alpha = ( ( tex2DNode17.a + tex2DNode18.a + tex2DNode19.a + tex2DNode20.a ) * _Cutoff_Value );
			#if UNITY_PASS_SHADOWCASTER
			clip( _OpacityMask - _Cutoff );
			#endif
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			AlphaToMask Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16200
0;23;1348;837;-47.07491;367.3427;1.737598;True;True
Node;AmplifyShaderEditor.CommentaryNode;44;-1170.886,-1472.677;Float;False;649.7212;1535.16;Hair Layer Coloring;12;6;18;17;20;8;3;19;7;31;33;32;27;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;43;-1330.573,63.85233;Float;False;560.9637;970.7424;Fake AO Gradient;9;10;11;12;9;35;2;4;5;1;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;20;-1113.583,-339.4744;Float;True;Property;_Hair_AlbedoTransparent_L4_01;Hair_AlbedoTransparent_L4_01;18;0;Create;True;0;0;False;0;None;81a053fca92564b8b8dd467ec04354fd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;8;-1031.9,-512.5192;Float;False;Property;_Color2;Color 2;3;0;Create;True;0;0;False;0;0.3691939,0.6981132,0.3457636,0;0.372549,0.254902,0.1294118,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;6;-1041.349,-1232.141;Float;False;Property;_Color0;Color 0;2;0;Create;True;0;0;False;0;0.8026462,0.1579299,0.8584906,0;0.2745098,0.1764706,0.1176471,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;19;-1114.039,-698.1941;Float;True;Property;_Hair_AlbedoTransparent_L3_01;Hair_AlbedoTransparent_L3_01;17;0;Create;True;0;0;False;0;None;dc2e0439b5354485e845bb3a20bb5121;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;-1118.022,-1057.386;Float;True;Property;_Hair_AlbedoTransparent_L2_01;Hair_AlbedoTransparent_L2_01;16;0;Create;True;0;0;False;0;None;5eb0637fa9f944409a3dc4ed9d9c3fb7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;3;-1043.31,-872.0977;Float;False;Property;_Color1;Color 1;1;0;Create;True;0;0;False;0;0.8584906,0.8524513,0.1822268,0;0.372549,0.254902,0.1294118,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;7;-1001.417,-144.5172;Float;False;Property;_Color3;Color 3;4;0;Create;True;0;0;False;0;1,0,0,1;0.5372549,0.3686275,0.1882353,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;17;-1120.886,-1422.677;Float;True;Property;_Hair_AlbedoTransparent_L1_01;Hair_AlbedoTransparent_L1_01;15;0;Create;True;0;0;False;0;None;c83f36424302449579b7ab79b70ca031;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-775.4274,-1052.41;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;-1277.297,503.3879;Float;True;Property;_Gradient_B_L;Gradient_B_L;5;0;Create;True;0;0;False;0;f57f0b7d202e21e4989c1cde31585473;f57f0b7d202e21e4989c1cde31585473;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-1280.105,119.8541;Float;True;Property;_Gradient_T_L;Gradient_T_L;7;0;Create;True;0;0;False;0;a2796156087aeb542b1d74231b811923;a2796156087aeb542b1d74231b811923;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-1278.235,311.1094;Float;True;Property;_Gradient_T_R;Gradient_T_R;8;0;Create;True;0;0;False;0;37612640132428b4faf5ca8c99079977;37612640132428b4faf5ca8c99079977;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-757.3877,-691.4464;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;-1280.573,704.0171;Float;True;Property;_Gradient_B_R;Gradient_B_R;6;0;Create;True;0;0;False;0;f6a869b91e03cbc4c89fa57336a8af4b;f6a869b91e03cbc4c89fa57336a8af4b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-773.4569,-336.9258;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-757.1648,-1415.802;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-1252.349,919.5947;Float;False;Property;_Gradient_Value;Gradient_Value;14;0;Create;True;0;0;False;0;1;0.5;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-939.6098,113.8523;Float;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;72;-377.185,-937.5304;Float;True;Lighten;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;70;-383.7904,-1180.747;Float;True;Lighten;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-938.6098,456.2558;Float;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-939.6098,338.8524;Float;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;45;-455.8156,-369.8849;Float;False;597.8732;399.1021;Alpha;3;36;39;37;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-938.6098,219.8524;Float;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;67;286.0337,-1498.122;Float;False;2374.728;640.6228;Test this if possible for alpha blending;16;46;47;49;50;51;52;55;57;58;54;53;64;65;66;59;56;Dither;1,1,1,1;0;0
Node;AmplifyShaderEditor.BlendOpsNode;71;-48.00555,-1000.219;Float;True;Lighten;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-671.7311,234.3405;Float;True;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;39;-342.1627,-319.8849;Float;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-405.8156,-85.78281;Float;False;Property;_Cutoff_Value;Cutoff_Value;12;0;Create;True;0;0;False;0;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-92.94263,-228.3472;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;57;1552.547,-1087.5;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;1918.07,-1448.122;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;46;345.5338,-1399.664;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;906.5461,-1316.499;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;1.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;21;-197.9967,310.2609;Float;True;Property;_Hair_MetallicSmoothness_01;Hair_MetallicSmoothness_01;19;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;69;675.8565,-747.9561;Float;False;Constant;_INSERT_CARD_ALPHA;INSERT_CARD_ALPHA;25;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DitheringNode;65;2143.336,-1287.178;Float;False;2;False;3;0;FLOAT;0;False;1;SAMPLER2D;;False;2;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;56;1721.547,-1298.499;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;66;2417.762,-1287.179;Float;False;DitheredOpacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;22;51.26939,124.7856;Float;True;Property;_Hair_Normal_01;Hair_Normal_01;20;1;[Normal];Create;True;0;0;False;0;None;6aa023b317be84bfaa8d1a5d031dace9;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-178.1993,683.0581;Float;False;Property;_AO;AO;11;0;Create;True;0;0;False;0;0;0.403;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;139.0261,315.4072;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;53;754.5462,-1166.5;Float;False;Property;_EdgeMaskContrast;Edge Mask Contrast;24;0;Create;True;0;0;False;0;0.37;0.37;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;-277.9083,-640.3244;Float;True;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-177.0114,506.596;Float;False;Property;_Metalic;Metalic;9;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;442.2336,515.9819;Float;False;Property;_OpacityMask;OpacityMask;13;0;Create;True;0;0;False;0;0.5;0.914;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;55;1450.547,-1304.499;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;64;1899.149,-1116.713;Float;True;Property;_Texture0;Texture 0;22;0;Create;True;0;0;False;0;bdbe94d7623ec3940947b62544306f1c;bdbe94d7623ec3940947b62544306f1c;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;54;1095.546,-1155.5;Float;False;Property;_EdgeMaskMin;Edge Mask Min;21;0;Create;True;0;0;False;0;1.09;1.09;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;1353.547,-972.4999;Float;False;Property;_int1;int 1;23;0;Create;True;0;0;False;0;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;52;1105.546,-1314.499;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;50;736.5462,-1317.499;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;49;595.2452,-1317.151;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;410.9229,-175.9251;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-179.1993,604.0586;Float;False;Property;_Smoothness;Smoothness;10;0;Create;True;0;0;False;0;0;0.804;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;47;336.0337,-1240.065;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;751.0343,119.7782;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;JustinsHairShader_V02_01;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;1;False;-1;-1;False;-1;False;0;Custom;0.3;True;True;0;True;TransparentCutout;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;1;False;-1;0;False;-1;0;5;False;-1;10;False;-1;1;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;True;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;32;0;18;0
WireConnection;32;1;3;0
WireConnection;32;2;18;4
WireConnection;33;0;19;0
WireConnection;33;1;8;0
WireConnection;33;2;19;4
WireConnection;27;0;20;0
WireConnection;27;1;7;0
WireConnection;27;2;20;4
WireConnection;31;0;17;0
WireConnection;31;1;6;0
WireConnection;31;2;17;4
WireConnection;10;0;35;0
WireConnection;10;1;5;0
WireConnection;10;2;5;4
WireConnection;72;0;33;0
WireConnection;72;1;27;0
WireConnection;70;0;31;0
WireConnection;70;1;32;0
WireConnection;9;0;35;0
WireConnection;9;1;1;0
WireConnection;9;2;1;4
WireConnection;11;0;35;0
WireConnection;11;1;2;0
WireConnection;11;2;2;4
WireConnection;12;0;35;0
WireConnection;12;1;4;0
WireConnection;12;2;4;4
WireConnection;71;0;70;0
WireConnection;71;1;72;0
WireConnection;14;0;10;0
WireConnection;14;1;12;0
WireConnection;14;2;11;0
WireConnection;14;3;9;0
WireConnection;39;0;17;4
WireConnection;39;1;18;4
WireConnection;39;2;19;4
WireConnection;39;3;20;4
WireConnection;37;0;39;0
WireConnection;37;1;36;0
WireConnection;57;0;69;0
WireConnection;57;1;58;0
WireConnection;59;0;69;0
WireConnection;59;1;56;0
WireConnection;51;0;50;0
WireConnection;65;0;59;0
WireConnection;65;1;64;0
WireConnection;56;0;57;0
WireConnection;56;2;55;0
WireConnection;66;0;65;0
WireConnection;23;0;21;0
WireConnection;23;1;16;0
WireConnection;28;0;31;0
WireConnection;28;1;32;0
WireConnection;28;2;33;0
WireConnection;28;3;27;0
WireConnection;55;0;54;0
WireConnection;55;2;52;0
WireConnection;52;0;51;0
WireConnection;52;1;53;0
WireConnection;50;0;49;0
WireConnection;49;0;46;0
WireConnection;49;1;47;0
WireConnection;34;0;71;0
WireConnection;34;1;14;0
WireConnection;0;0;34;0
WireConnection;0;1;22;0
WireConnection;0;3;16;0
WireConnection;0;4;13;0
WireConnection;0;5;15;0
WireConnection;0;9;37;0
WireConnection;0;10;40;0
ASEEND*/
//CHKSM=D40FAD2A63EA15562191E7517E45892404850C83