shared = {}
shared.BC_1 = true
shared.BC_2 = nil

if shared.BC_1 and shared.BC_2 == nil then
	L_1 = game:GetService("Workspace");
	L_2 = game:GetService("Lighting");
	L_3 = L_1.Terrain;
	L_4 = game:GetService("Players");
	L_5 = L_4.LocalPlayer.Character;

	L_3.WaterWaveSize = 0;L_3.WaterWaveSpeed = 0;L_3.WaterReflectance = 0;L_3.WaterTransparency = 0;
	L_2.GlobalShadows = false;L_2.FogEnd = tonumber(9e9);L_2.Brightness = 0;
	settings().Rendering.QualityLevel = "Level01";
	settings().Rendering.GraphicsMode = "NoGraphics";
	--sethiddenproperty(L_2, "Technology", "Compatibility");
	for i,v in pairs(L_1:GetDescendants()) do
		if v.ClassName == "Part" or v.ClassName == "SpawnLocation" or v.ClassName == "WedgePart" or v.ClassName == "Terrain" or v.ClassName == "MeshPart" then
			v.Material = "Plastic";v.Reflectance = 0;v.CastShadow = false;
		elseif v.ClassName == "Decal" or v:IsA("Texture") then
			v.Texture = 0;v.Transparency = 1;
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.LightInfluence = 0;v.Texture = 0;v.Lifetime = NumberRange.new(0);
		elseif v:IsA("Explosion") then
			v.BlastPressure = 0;v.BlastRadius = 0;
		elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
			v.Enabled = false;
		elseif v:IsA("MeshPart") then
			v.Material = "Plastic";v.Reflectance = 0;v.TextureId = 0;v.CastShadow = false;v.RenderFidelity = Enum.RenderFidelity.Performance;
		elseif v.ClassName == "SpecialMesh" then
			v.TextureId = "rbxassetid://0";
		elseif v.ClassName == "Shirt" or v.ClassName == "Pants" or v.ClassName == "Accessory" then
			v:Destroy();
		end
	end
	for i,v in pairs(L_2:GetDescendants()) do
		if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
			v.Enabled = false;
		end
	end
	for i,v in pairs(L_5:GetDescendants()) do
		if v.ClassName == "Shirt" or v.ClassName == "Pants" or v.ClassName == "Accessory" then
			v:Destroy();
		end
	end

	shared.BC_2 = true
end
