// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Semi Transparent Standard"
{
	Properties
	{
		[HDR]_EmissiveValue("EmissiveValue", Float) = 0
		_MetallicMultiply("MetallicMultiply", Float) = 1
		_RoughnessMultiply("RoughnessMultiply", Float) = 1
		_EmissiveColour("EmissiveColour", Color) = (0,0,0,0)
		_Albedo("Albedo", 2D) = "white" {}
		_AmbientOcclusion("Ambient Occlusion", 2D) = "white" {}
		_Metallic("Metallic", 2D) = "white" {}
		_Cutoff( "Mask Clip Value", Float ) = 1
		_NormalMap("Normal Map", 2D) = "bump" {}
		_Mask("Mask", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Pass
		{
			ColorMask 0
			ZTest LEqual
			ZWrite On
		}

		Tags{ "RenderType" = "Opaque"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		ZWrite On
		Blend SrcAlpha OneMinusSrcAlpha , DstColor SrcColor
		BlendOp Add , RevSub
		CGPROGRAM
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows exclude_path:deferred 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float4 _EmissiveColour;
		uniform sampler2D _Mask;
		uniform float4 _Mask_ST;
		uniform float _EmissiveValue;
		uniform sampler2D _Metallic;
		uniform float4 _Metallic_ST;
		uniform float _MetallicMultiply;
		uniform float _RoughnessMultiply;
		uniform sampler2D _AmbientOcclusion;
		uniform float4 _AmbientOcclusion_ST;
		uniform float _Cutoff = 1;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			o.Normal = UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) );
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float4 tex2DNode14 = tex2D( _Albedo, uv_Albedo );
			o.Albedo = tex2DNode14.rgb;
			float2 uv_Mask = i.uv_texcoord * _Mask_ST.xy + _Mask_ST.zw;
			o.Emission = ( _EmissiveColour * ( tex2D( _Mask, uv_Mask ) * _EmissiveValue ) ).rgb;
			float2 uv_Metallic = i.uv_texcoord * _Metallic_ST.xy + _Metallic_ST.zw;
			float4 tex2DNode19 = tex2D( _Metallic, uv_Metallic );
			o.Metallic = ( tex2DNode19 * _MetallicMultiply ).r;
			o.Smoothness = ( tex2DNode19.a * _RoughnessMultiply );
			float2 uv_AmbientOcclusion = i.uv_texcoord * _AmbientOcclusion_ST.xy + _AmbientOcclusion_ST.zw;
			o.Occlusion = tex2D( _AmbientOcclusion, uv_AmbientOcclusion ).r;
			o.Alpha = 1;
			clip( tex2DNode14.a - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15301
2676;1052;1103;708;1517.674;703.1281;2.452394;True;True
Node;AmplifyShaderEditor.SamplerNode;22;-961.3511,148.6327;Float;True;Property;_Mask;Mask;9;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;-774.3019,372.196;Float;False;Property;_EmissiveValue;EmissiveValue;0;1;[HDR];Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-564.5824,874.671;Float;False;Property;_RoughnessMultiply;RoughnessMultiply;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;19;-925.1999,542.4009;Float;True;Property;_Metallic;Metallic;6;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-588.3998,540.4009;Float;False;Property;_MetallicMultiply;MetallicMultiply;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;11;-583.0758,115.8409;Float;False;Property;_EmissiveColour;EmissiveColour;3;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-560.6846,276.5094;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;23;-925.0978,970.301;Float;True;Property;_AmbientOcclusion;Ambient Occlusion;5;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-215.4814,139.3723;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;15;-913.3,-49.50001;Float;True;Property;_NormalMap;Normal Map;8;0;Create;True;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.EdgeLengthCullTessNode;27;-518.5068,-239.453;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-358.3998,534.401;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-370.8998,733.401;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;14;-916.3,-268.5001;Float;True;Property;_Albedo;Albedo;4;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;157.8766,-41.80914;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;Semi Transparent Standard;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;1;False;-1;0;False;-1;False;0;0;True;3;Custom;1;True;True;0;True;Opaque;;AlphaTest;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;4;10;25;False;0.5;True;1;5;False;-1;10;False;-1;7;2;False;-1;3;False;-1;0;False;-1;2;False;-1;88;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;7;-1;2;1;0;0;0;False;0;0;0;False;-1;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;22;0
WireConnection;17;1;18;0
WireConnection;34;0;11;0
WireConnection;34;1;17;0
WireConnection;2;0;19;0
WireConnection;2;1;4;0
WireConnection;7;0;19;4
WireConnection;7;1;8;0
WireConnection;0;0;14;0
WireConnection;0;1;15;0
WireConnection;0;2;34;0
WireConnection;0;3;2;0
WireConnection;0;4;7;0
WireConnection;0;5;23;0
WireConnection;0;10;14;4
ASEEND*/
//CHKSM=D95ECC0C22D1DAA84297F20AAC2A7C8752BB39A9