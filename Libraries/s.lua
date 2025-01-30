local library = {}

local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

library.CreateWindow = function(name)
	spawn(function()
		while wait() do
			local blur_name = "ddos"
			if not Lighting:FindFirstChild(blur_name) then
				local blur = Instance.new("BlurEffect")
				blur.Parent = game:GetService("Lighting")
				blur.Name = blur_name
				blur.Size = 50
			elseif Lighting:FindFirstChild("cock") and Lighting[blur_name].Enabled == false then
				Lighting[blur_name].Enabled = true
			end
		end
	end)

	local AutoDungeon = Instance.new("ScreenGui")
	local HopFrame = Instance.new("Frame")
	local YuukiHub = Instance.new("TextLabel")
	local UIStroke = Instance.new("UIStroke")
	local GGzzz = Instance.new("TextLabel")
	local DropShadowHolder = Instance.new("Frame")
	local DropShadow = Instance.new("ImageLabel")
	local ClickTo = Instance.new("TextLabel")
	local GrindingLevel = Instance.new("TextLabel")

	AutoDungeon.Name = "Auto Dungeon"
	AutoDungeon.Parent = RunService:IsStudio() and Players.LocalPlayer.PlayerGui or game:GetService("CoreGui")
	AutoDungeon.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	HopFrame.Name = "HopFrame"
	HopFrame.Parent = AutoDungeon
	HopFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	HopFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	HopFrame.BackgroundTransparency = 0.999
	HopFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	HopFrame.BorderSizePixel = 0
	HopFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	HopFrame.Size = UDim2.new(1, 0, 1, 0)

	YuukiHub.Name = "Yuuki Hub"
	YuukiHub.Parent = HopFrame
	YuukiHub.AnchorPoint = Vector2.new(0.5, 0.5)
	YuukiHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	YuukiHub.BackgroundTransparency = 0.999
	YuukiHub.BorderColor3 = Color3.fromRGB(0, 0, 0)
	YuukiHub.BorderSizePixel = 0
	YuukiHub.Position = UDim2.new(0.5, 0, 0.5, -45)
	YuukiHub.Size = UDim2.new(0, 200, 0, 80)
	YuukiHub.Font = Enum.Font.GothamMedium
	YuukiHub.Text = name
	YuukiHub.TextColor3 = Color3.fromRGB(175, 187, 230)
	YuukiHub.TextSize = 85.000

	UIStroke.Parent = YuukiHub
	UIStroke.Color = Color3.fromRGB(175, 187, 230)
	UIStroke.Thickness = 1.5
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	UIStroke.LineJoinMode = Enum.LineJoinMode.Round

	GGzzz.Name = "GGzzz"
	GGzzz.Parent = HopFrame
	GGzzz.AnchorPoint = Vector2.new(0.5, 0.5)
	GGzzz.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	GGzzz.BackgroundTransparency = 0.999
	GGzzz.BorderColor3 = Color3.fromRGB(0, 0, 0)
	GGzzz.BorderSizePixel = 0
	GGzzz.Position = UDim2.new(0.5, 0, 0.5, 0)
	GGzzz.Size = UDim2.new(0, 200, 0, 30)
	GGzzz.Font = Enum.Font.Gotham
	GGzzz.Text = "Status : Wait"
	GGzzz.TextColor3 = Color3.fromRGB(255, 255, 255)
	GGzzz.TextSize = 20.000

	DropShadowHolder.Name = "DropShadowHolder"
	DropShadowHolder.Parent = HopFrame
	DropShadowHolder.BackgroundTransparency = 1.000
	DropShadowHolder.BorderSizePixel = 0
	DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
	DropShadowHolder.ZIndex = 0

	DropShadow.Name = "DropShadow"
	DropShadow.Parent = DropShadowHolder
	DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow.BackgroundTransparency = 1.000
	DropShadow.BorderSizePixel = 0
	DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow.Size = UDim2.new(1, 47, 1, 47)
	DropShadow.ZIndex = 0
	DropShadow.Image = "rbxassetid://18274042189"
	DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	DropShadow.ImageTransparency = 0.999
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

	ClickTo.Name = "ClickTo"
	ClickTo.Parent = HopFrame
	ClickTo.AnchorPoint = Vector2.new(0.5, 0.5)
	ClickTo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ClickTo.BackgroundTransparency = 0.999
	ClickTo.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ClickTo.BorderSizePixel = 0
	ClickTo.Position = UDim2.new(0.49925372, 0, 0.481707305, 50)
	ClickTo.Size = UDim2.new(1, 0, 1, 0)
	ClickTo.Font = Enum.Font.Gotham
	ClickTo.Text = "\n \nEnjoy https://kekma.net"
	ClickTo.TextColor3 = Color3.fromRGB(255, 255, 255)
	ClickTo.TextSize = 16.000
	ClickTo.TextTransparency = 0.500

	GrindingLevel.Name = "Grinding Level"
	GrindingLevel.Parent = HopFrame
	GrindingLevel.AnchorPoint = Vector2.new(0.5, 0.5)
	GrindingLevel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	GrindingLevel.BackgroundTransparency = 0.999
	GrindingLevel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	GrindingLevel.BorderSizePixel = 0
	GrindingLevel.Position = UDim2.new(0.5, 0, 0.5, 32)
	GrindingLevel.Size = UDim2.new(0, 200, 0, 16)
	GrindingLevel.Font = Enum.Font.Gotham
	GrindingLevel.Text = "Time: 00:00:00"
	GrindingLevel.TextColor3 = Color3.fromRGB(255, 255, 255)
	GrindingLevel.TextSize = 16.000

	local func = {}
	func.time = function(text)
		GrindingLevel.Text = "Time: "..text
	end
	func.status = function(text)
		GGzzz.Text = "Status : "..text
	end
	return func
end
return library
