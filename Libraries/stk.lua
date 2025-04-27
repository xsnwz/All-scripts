do 
	-- Module GetService
	RunService = game:GetService("RunService")
	VirtualInputManager = game:GetService('VirtualInputManager')
	UserInputService = game:GetService("UserInputService")
	GuiService = game:GetService("GuiService")
	TweenService = game:GetService("TweenService")
	HttpService = game:GetService("HttpService")
	Players = game:GetService("Players")
	MarketplaceService = game:GetService("MarketplaceService")

	repeat 
		LocalPlayer = Players.LocalPlayer
		wait()
	until LocalPlayer

	PlayerGui = LocalPlayer.PlayerGui
	GetMouse = LocalPlayer:GetMouse()
end

local library = {} library.__index = library
local utils = {} utils.__index = utils

utils.create = function(class, prop)
	local obj = Instance.new(class)

	for prop, v in next, prop do
		obj[prop] = v
	end

	pcall(function()
		obj.AutoButtonColor = false
	end)

	return obj
end

utils.tween = function(obj, info, properties, callback)
	local anim = TweenService:Create(obj, TweenInfo.new(unpack(info)), properties)
	anim:Play()

	if callback then
		anim.Completed:Connect(callback)
	end

	return anim
end


local function UpSize(Scroll)
	local OffsetY = 0
	for _, child in Scroll:GetChildren() do
		if child.Name ~= "UIListLayout" then
			OffsetY = OffsetY + Scroll.UIListLayout.Padding.Offset + child.Size.Y.Offset
		end
	end
	Scroll.CanvasSize = UDim2.new(0, 0, 0, OffsetY)
end
local function AutoUp(Scroll)
	Scroll.ChildAdded:Connect(function()
		UpSize(Scroll)
	end)
	Scroll.ChildRemoved:Connect(function()
		UpSize(Scroll)
	end)
end

local function EnterMouse(frameenter)
	local old = frameenter.BackgroundColor3
	local oldfunc = {}
	if old == Color3.fromRGB(255, 255, 255) then
		local oldtrans = frameenter.BackgroundTransparency
		frameenter.MouseEnter:Connect(function()
			utils.tween(frameenter, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
				BackgroundTransparency = frameenter.BackgroundTransparency - 0.035
			})
		end)
		frameenter.MouseLeave:Connect(function()
			utils.tween(frameenter, {0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
				BackgroundTransparency = oldtrans
			})
		end)
	else
		frameenter.MouseEnter:Connect(function()
			utils.tween(frameenter, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
				BackgroundColor3 = Color3.fromRGB((old.R * 255) + 8, (old.G * 255) + 8, (old.B * 255) + 8)
			})
		end)
		frameenter.MouseLeave:Connect(function()
			utils.tween(frameenter, {0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
				BackgroundColor3 = old
			})
		end)
	end
end

utils.dragify = function(object, hoverobj, speed, additionalObject)
	local start, objectPosition, dragging, dragInput

	speed = speed or 0

	hoverobj.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
			dragging = true
			start = input.Position
			objectPosition = object.Position
		end
	end)

	hoverobj.InputEnded:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
			dragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
			dragInput = input

			utils.tween(object, { speed }, {
				Position = UDim2.new(
					objectPosition.X.Scale,
					objectPosition.X.Offset + (input.Position - start).X,
					objectPosition.Y.Scale,
					objectPosition.Y.Offset + (input.Position - start).Y
				),
			})

			if additionalObject then
				utils.tween(additionalObject, { speed + 0.0000001 }, {
					Position = UDim2.new(
						objectPosition.X.Scale,
						objectPosition.X.Offset + (input.Position - start).X,
						objectPosition.Y.Scale,
						objectPosition.Y.Offset + (input.Position - start).Y
					),
				})
			end
		end
	end)
end

function UDim2FromTable(...)
	local args = {...}

	if #args == 4 then
		return UDim2.new(unpack(args))
	elseif #args ~= 2 then
		error("Input must be either four values or two sub-tables.")
	end

	local xScale, xOffset = unpack(args[1])
	local yScale, yOffset = unpack(args[2])

	return UDim2.new(xScale, xOffset, yScale, yOffset)
end

local function CreateToggle()

	local xenoscriptsbtn = utils.create("ScreenGui", {
		Name = "scripts.btn",
		Parent = (RunService:IsStudio()) and PlayerGui or game:GetService("CoreGui"),
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 999,
		ResetOnSpawn = false,
	})

	local Frame = utils.create("Frame", {
		Parent = xenoscriptsbtn,
		AnchorPoint = Vector2.new(0, 1),
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 15, 1, -15),
		Size = UDim2.new(0, 0, 0, 0),
	})
	utils.tween(Frame, {0.4, Enum.EasingStyle.Back}, {
		Size = UDim2FromTable({0, 50},{0, 50})
	})

	local TextButtonv = utils.create("TextButton", {
		Parent = Frame,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, 0, 1, 0),
		TextTransparency = 1.000,
	})

	local ImageLabel = utils.create("ImageLabel", {
		Parent = Frame,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, 0, 1, 0),
		Image = "rbxassetid://108345599379709",
		ScaleType = Enum.ScaleType.Crop,
	})

	local s1 = utils.create("ImageLabel", {
		Name = "s1",
		Parent = ImageLabel,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1.000,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		Image = "rbxassetid://106004313642464",
		ImageColor3 = Color3.fromRGB(14, 5, 63),
		ImageRectOffset = Vector2.new(50, -300),
		ImageRectSize = Vector2.new(500, 500),
		ImageTransparency = 0.850,
	})

	utils.create("UICorner", {
		CornerRadius = UDim.new(0, 300),
		Parent = s1,
	})

	utils.dragify(Frame, TextButtonv, 0)

	return TextButtonv,ImageLabel
end

local global_env = (getgenv and getgenv()) or _G

function checkDevice()
	if LocalPlayer then
		local FeariseToggle,vvvvvv = CreateToggle()
		FeariseToggle.MouseButton1Click:Connect(function()
			if global_env.xsnwzlib then
				global_env.xsnwzlib.Enabled = not global_env.xsnwzlib.Enabled
			end
		end)
	end
end

checkDevice()

library.new = function(libraryinfo)
	local SitinkGui = utils.create("ScreenGui", {
		Name = "SitinkGui",
		Parent = (gethui) and gethui() or ((RunService:IsStudio()) and PlayerGui or game:GetService("CoreGui")),
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})
	
	global_env.xsnwzlib = SitinkGui
	
	
	local Main = utils.create("Frame", {
		Name = "Main",
		Parent = SitinkGui,
		BackgroundColor3 = Color3.fromRGB(45, 45, 45),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = libraryinfo.Size or UDim2.new(0, 500, 0, 300),
	})

	Main.Position = UDim2.new(0, (SitinkGui.AbsoluteSize.X // 2 - Main.Size.X.Offset // 2), 0, (SitinkGui.AbsoluteSize.Y // 2 - Main.Size.Y.Offset // 2))

	utils.create("UICorner", {
		CornerRadius = UDim.new(0, 5),
		Parent = Main,
	})

	local Top = utils.create("Frame", {
		Name = "Top",
		Parent = Main,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 34),
	})

	local TopTitle = utils.create("TextLabel", {
		Name = "TopTitle",
		Parent = Top,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 12, 0, 10),
		Size = UDim2.new(0, 0, 0, 14),
		Font = Enum.Font.GothamBold,
		Text = libraryinfo.Title or "Sitink Hub",
		TextColor3 = (libraryinfo["Color"]) and libraryinfo["Color"] or Color3.fromRGB(127, 146, 242),
		TextSize = 14.000,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local TopDescription = utils.create("TextLabel", {
		Name = "TopDescription",
		Parent = Top,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 16 + TopTitle.TextBounds.X, 0, 10), 
		Size = UDim2.new(0, 0, 0, 14),
		Font = Enum.Font.GothamBold,
		Text = libraryinfo.Desc or "- .gg/qwertyhub",
		TextColor3 = Color3.fromRGB(230, 230, 230),
		TextSize = 14.000,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	TopTitle:GetPropertyChangedSignal("TextBounds"):Connect(function()
		TopDescription.Position = UDim2.new(0, 16 + TopTitle.TextBounds.X, 0, 10)
	end)

	TopTitle:GetPropertyChangedSignal("Text"):Connect(function()
		TopDescription.Position = UDim2.new(0, 16 + TopTitle.TextBounds.X, 0, 10)
	end)

	local CloseButton = utils.create("TextButton", {
		Name = "CloseButton",
		Parent = Top,
		AnchorPoint = Vector2.new(1, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(1, 0, 0, 0),
		Size = UDim2.new(0, 34, 0, 34),
		Font = Enum.Font.SourceSans,
		Text = "",
		TextColor3 = Color3.fromRGB(0, 0, 0),
		TextSize = 14.000,
	})

	utils.create("ImageLabel", {
		Name = "CloseImage",
		Parent = CloseButton,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, -15, 1, -15),
		Image = "rbxassetid://18328658828",
	})

	local DropShadowHolder = utils.create("Frame", {
		Name = "DropShadowHolder",
		Parent = Main,
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 0,
	})

	utils.create("ImageLabel", {
		Name = "DropShadow",
		Parent = DropShadowHolder,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, 47, 1, 47),
		ZIndex = 0,
		Image = "rbxassetid://6015897843",
		ImageColor3 = Color3.fromRGB(0, 0, 0),
		ImageTransparency = 0.600,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(49, 49, 450, 450),
	})

	local LayersTab = utils.create("Frame", {
		Name = "LayersTab",
		Parent = Main,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 10, 0, 34),
		Size = UDim2.new(0, 135, 1, -44),
	})

	local ScrollTab = utils.create("ScrollingFrame", {
		Name = "ScrollTab",
		Parent = LayersTab,
		Active = true,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 40),
		Size = UDim2.new(1, 0, 1, -40),
		CanvasSize = UDim2.new(0, 0, 0, 56),
		ScrollBarThickness = 0,
	})

	utils.create("UIListLayout", {
		Parent = ScrollTab,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 3),
	})

	local Info = utils.create("Frame", {
		Name = "Info",
		Parent = LayersTab,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 35),
	})

	utils.create("UICorner", {
		CornerRadius = UDim.new(0, 3),
		Parent = Info,
	})

	utils.create("TextLabel", {
		Name = "NamePlayer",
		Parent = Info,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 35, 0, 0),
		Size = UDim2.new(1, -35, 1, 0),
		Font = Enum.Font.GothamBold,
		Text = libraryinfo.Info_Title or "Qwerty Hub Info" ,
		TextColor3 = Color3.fromRGB(230, 230, 230),
		TextSize = 12.000,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local LogoFrame = utils.create("Frame", {
		Name = "LogoFrame",
		Parent = Info,
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 5, 0.5, 0),
		Size = UDim2.new(0, 25, 0, 25),
	})

	local LogoPlayer = utils.create("ImageLabel", {
		Name = "LogoPlayer",
		Parent = LogoFrame,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, 0, 1, 0),
		Image = libraryinfo.Player_Logo and "rbxassetid://"..libraryinfo.Player_Logo or "",
	})

	utils.create("UICorner", {
		CornerRadius = UDim.new(0, 1000),
		Parent = LogoPlayer,
	})

	utils.create("UICorner", {
		CornerRadius = UDim.new(0, 1000),
		Parent = LogoFrame,
	})

	local InfoButton =utils.create("TextButton", {
		Name = "InfoButton",
		Parent = Info,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		Font = Enum.Font.SourceSans,
		Text = "",
		TextColor3 = Color3.fromRGB(0, 0, 0),
		TextSize = 14.000,
	})

	local AnotherFrame = utils.create("Frame", {
		Name = "AnotherFrame",
		Parent = Main,
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.500,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		Visible = false,
		ZIndex = 2,
	})

	utils.create("UICorner", {
		CornerRadius = UDim.new(0, 3),
		Parent = AnotherFrame,
	})

	local AnotherButton = utils.create("TextButton", {
		Name = "AnotherButton",
		Parent = AnotherFrame,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		Font = Enum.Font.SourceSans,
		Text = "",
		TextColor3 = Color3.fromRGB(0, 0, 0),
		TextSize = 14.000,
	})

	local LogFrame = utils.create("Frame", {
		Name = "LogFrame",
		Parent = AnotherFrame,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 =  libraryinfo.Info_Color or Color3.fromRGB(0, 0, 0),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Position = UDim2.new(0.5, 0, 0.5, 0),
	})

	utils.create("UICorner", {
		CornerRadius = UDim.new(0, 5),
		Parent = LogFrame,
	})

	local LogUnder = utils.create("Frame", {
		Name = "LogUnder",
		Parent = LogFrame,
		BackgroundColor3 = Color3.fromRGB(10, 10, 10),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 50),
		Size = UDim2.new(1, 0, 1, -50),
	})

	utils.create("UICorner", {
		CornerRadius = UDim.new(0, 3),
		Parent = LogUnder,
	})

	utils.create("TextLabel", {
		Name = "LogTitle",
		Parent = LogUnder,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 12, 0, 34),
		Size = UDim2.new(0, 35, 0, 16),
		Font = Enum.Font.GothamBold,
		Text = libraryinfo.Player_Title or "Tobiee",
		TextColor3 = Color3.fromRGB(230, 230, 230),
		TextSize = 18.000,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	utils.create("TextLabel", {
		Name = "LogDescription",
		Parent = LogUnder,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 12, 0, 50),
		Size = UDim2.new(0, 35, 0, 14),
		Font = Enum.Font.GothamBold,
		Text = libraryinfo.Player_Desc or "discord.cac",
		TextColor3 = Color3.fromRGB(230, 230, 230),
		TextSize = 12.000,
		TextTransparency = 0.500,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local LogoInfo = utils.create("ImageLabel", {
		Name = "LogoInfo",
		Parent = LogFrame,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 15, 0, 25),
		Size = UDim2.new(0, 50, 0, 50),
		Image = libraryinfo.Info_Logo and "rbxassetid://"..libraryinfo.Info_Logo or "",
	})

	utils.create("UICorner", {
		CornerRadius = UDim.new(0, 100),
		Parent = LogoInfo,
	})

	utils.create("UIStroke", {
		Color = Color3.fromRGB(10, 10, 10),
		Thickness = 4,
		Parent = LogoInfo,
	})

	local Layers = utils.create("Frame", {
		Name = "Layers",
		Parent = Main,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 158, 0, 34),
		Size = UDim2.new(1, -166, 1, -44),
	})

	local RealLayers = utils.create("Frame", {
		Name = "RealLayers",
		Parent = Layers,
		AnchorPoint = Vector2.new(1, 1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Position = UDim2.new(1, 0, 1, 0),
		Size = UDim2.new(1, 0, 1, -25),
	})

	local LayersFolder = utils.create("Folder", {
		Name = "LayersFolder",
		Parent = RealLayers,
	})

	local UIPageLayout = utils.create("UIPageLayout", {
		Parent = LayersFolder,
		SortOrder = Enum.SortOrder.LayoutOrder,
		EasingDirection = Enum.EasingDirection.InOut,
		EasingStyle = Enum.EasingStyle.Quad,
		TweenTime = 0.300,
	})

	local TopLayers = utils.create("Frame", {
		Name = "TopLayers",
		Parent = Layers,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 25),
	})

	local NameBack = utils.create("Frame", {
		Name = "NameBack",
		Parent = TopLayers,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(0, 32, 1, 0),
	})

	local BackButton = utils.create("TextButton", {
		Name = "BackButton",
		Parent = NameBack,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(0, 29, 1, 0),
		Font = Enum.Font.GothamBold,
		Text = "",
		TextColor3 = Color3.fromRGB(230, 230, 230),
		TextSize = 13.000,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local NameBack_2 = utils.create("Frame", {
		Name = "NameBack",
		Parent = TopLayers,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 32, 0, 0),
		Size = UDim2.new(1, -32, 1, 0),
	})

	local BackButton_2 = utils.create("TextButton", {
		Name = "BackButton",
		Parent = NameBack_2,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 25, 0, 0),
		Size = UDim2.new(1, -25, 1, 0),
		Font = Enum.Font.GothamBold,
		Text = "",
		TextColor3 = Color3.fromRGB(230, 230, 230),
		TextSize = 13.000,
		TextTransparency = 0.999,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local ForwardImage = utils.create("ImageLabel", {
		Name = "ForwardImage",
		Parent = NameBack_2,
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, -1, 0.5, 1),
		Rotation = -90.000,
		Size = UDim2.new(0, 22, 0, 22),
		Image = "rbxassetid://16851841101",
		ImageColor3 = Color3.fromRGB(230, 230, 230),
		ImageTransparency = 0.999,
	})

	local in_tween = false
	InfoButton.Activated:Connect(function()
		if in_tween then
			return
		end
		in_tween = true
		AnotherFrame.Visible = true
		
		utils.tween(LogFrame, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut}, {
			Size = UDim2.new(0, 250, 0, 125)
		}, function()
			in_tween = false
		end)
	end)

	EnterMouse(InfoButton)

	utils.dragify(Main, Top, 0.15)

	AnotherButton.Activated:Connect(function()
		if in_tween then
			return
		end
		in_tween = true
		AnotherFrame.Visible = true
		
		utils.tween(LogFrame, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut}, {
			Size = UDim2.new(0, 0, 0, 0)
		}, function()
			AnotherFrame.Visible = false
			in_tween = false
		end)
	end)

	local function JumpTo(TabOrder, TabName)
		BackButton.LayoutOrder = TabOrder
		BackButton.Text = TabName
		UIPageLayout:JumpToIndex(TabOrder)
		
		utils.tween(BackButton, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut}, {
			TextTransparency = 0
		})
		
		utils.tween(BackButton_2, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut}, {
			TextTransparency = 0.999
		})
		
		utils.tween(ForwardImage, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut}, {
			ImageTransparency = 0.999
		})
		
		BackButton.Size = UDim2.new(0, BackButton.TextBounds.X + 3, 1, 0)
		NameBack.Size = UDim2.new(0, BackButton.Size.X.Offset, 1, 0)
		BackButton_2.Position = UDim2.new(0, NameBack.Size.X.Offset, 0, 0)
		NameBack_2.Size = UDim2.new(1,-(NameBack_2.Position.X.Offset), 1, 0)
	end
	BackButton.Activated:Connect(function()
		JumpTo(BackButton.LayoutOrder, BackButton.Text)
	end)
	library.tab = {
		Value = false
	}
	local PageOrders = 0
	function library.tab.tab(info)
		local ScrollLayer = utils.create("ScrollingFrame", {
			Name = "ScrollLayer",
			Parent = LayersFolder,
			Active = true,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0.999,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 1, 0),
			CanvasSize = UDim2.new(0, 0, 0, 48),
			ScrollBarThickness = 3,
			LayoutOrder = PageOrders
		})

		AutoUp(ScrollLayer)

		utils.create("UIListLayout", {
			Parent = ScrollLayer,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 4),
		})

		local Tab = utils.create("Frame", {
			Name = "Tab",
			Parent = ScrollTab,
			BackgroundColor3 = Color3.fromRGB(28, 28, 28),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			LayoutOrder = PageOrders,
			Size = UDim2.new(1, 0, 0, 25),
		})

		utils.create("UICorner", {
			CornerRadius = UDim.new(0, 3),
			Parent = Tab,
		})

		local ChoosingFrame = utils.create("Frame", {
			Name = "ChoosingFrame",
			Parent = Tab,
			AnchorPoint = Vector2.new(0, 1),
			BackgroundColor3 = (libraryinfo["Color"]) and libraryinfo["Color"] or Color3.fromRGB(127, 146, 242),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 5, 1, -6),
			Size = UDim2.new(0, 2, 0, 0),
		})

		local UIStroke = utils.create("UIStroke", {
			Color = (libraryinfo["Color"]) and libraryinfo["Color"] or Color3.fromRGB(127, 146, 242),
			Thickness = 0.800000011920929,
			Transparency = 0.9990000128746033,
			Parent = ChoosingFrame,
		})

		utils.create("UICorner", {
			CornerRadius = UDim.new(0, 3),
			Parent = ChoosingFrame,
		})

		local TabName = utils.create("TextLabel", {
			Name = "TabName",
			Parent = Tab,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0.999,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 14, 0, 0),
			Size = UDim2.new(1, -25, 1, 0),
			Font = Enum.Font.GothamBold,
			LineHeight = 0.900,
			Text = info.Title or "",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 12.000,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
		})

		local TabButton = utils.create("TextButton", {
			Name = "TabButton",
			Parent = Tab,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0.999,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 1, 0),
			Font = Enum.Font.SourceSans,
			Text = "",
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 14.000,
		})

		if PageOrders == 0 then
			UIPageLayout:JumpToIndex(PageOrders)

			BackButton.Text = TabName.Text
			BackButton.Size = UDim2.new(0, BackButton.TextBounds.X, 1, 0)

			NameBack.Size = UDim2.new(0, BackButton.Size.X.Offset + 3, 1, 0)

			NameBack_2.Position = UDim2.new(0, NameBack.Size.X.Offset, 0, 0)
			NameBack_2.Size = UDim2.new(1, -(NameBack_2.Position.X.Offset), 1, 0)

			ChoosingFrame.AnchorPoint = Vector2.new(0, 0)
			ChoosingFrame.Position = UDim2.new(0, 5, 0, 6)
			ChoosingFrame.Size = UDim2.new(0, 2, 0, 14)

			Tab.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

			UIStroke.Transparency = 0
		end

		TabButton.Activated:Connect(function()
			if Tab.LayoutOrder ~= UIPageLayout.CurrentPage.LayoutOrder then
				for _, TabFrame in ScrollTab:GetChildren() do
					if TabFrame.Name ~= "UIListLayout" then
						TabFrame.ChoosingFrame.AnchorPoint = Vector2.new(0, 1)
						TabFrame.ChoosingFrame.Position = UDim2.new(0, 5, 1, -6)
						utils.tween(
							TabFrame,
							{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
							{BackgroundColor3 = Color3.fromRGB(28, 28, 28)}
						)
						utils.tween(
							TabFrame.ChoosingFrame,
							{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
							{Size = UDim2.new(0, 2, 0, 0), Transparency = 0.999}
						)
						utils.tween(
							TabFrame.ChoosingFrame.UIStroke,
							{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
							{Transparency = 0.999}
						)
					end
				end
				ChoosingFrame.AnchorPoint = Vector2.new(0, 0)
				ChoosingFrame.Position = UDim2.new(0, 5, 0, 6)
				utils.tween(
					Tab,
					{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
					{BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
				)
				utils.tween(
					ChoosingFrame,
					{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
					{Size = UDim2.new(0, 2, 0, 14), Transparency = 0}
				)
				utils.tween(
					UIStroke,
					{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
					{Transparency = 0}
				)
				JumpTo(Tab.LayoutOrder, TabName.Text)
			end
		end)

		library.sections = {}

		local SelectionOrders = 0 
		library.sections.section = function(info)
			local selection_ScrollLayer = utils.create("ScrollingFrame", {
				Name = "ScrollLayer",
				Parent = LayersFolder,
				Active = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.999,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				LayoutOrder = PageOrders,
				Size = UDim2.new(1, 0, 1, 0),
				CanvasSize = UDim2.new(0, 0, 0, 0),
				ScrollBarThickness = 3,
			})

			utils.create("UIListLayout", {
				Parent = selection_ScrollLayer,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 4),
			})

			AutoUp(selection_ScrollLayer)

			local Section = utils.create("Frame", {
				Name = "Section",
				Parent = ScrollLayer,
				BackgroundColor3 = Color3.fromRGB(42, 42, 42),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.new(1, -8, 0, 44),
				LayoutOrder = SelectionOrders
			})

			utils.create("UICorner", {
				CornerRadius = UDim.new(0, 3),
				Parent = Section,
			})

			utils.create("TextLabel", {
				Name = "SectionName",
				Parent = Section,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.999,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.new(0, 10, 0, 10),
				Size = UDim2.new(1, -70, 0, 13),
				Font = Enum.Font.GothamBold,
				Text = info.Title or "",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 13.000,
				TextXAlignment = Enum.TextXAlignment.Left,
			})

			local SectionDescription = utils.create("TextLabel", {
				Name = "SectionDescription",
				Parent = Section,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.999,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.new(0, 10, 0, 22),
				Size = UDim2.new(1, -70, 0, 11),
				Font = Enum.Font.GothamBold,
				LineHeight = 0.900,
				Text = info.Desc or "",
				TextColor3 = Color3.fromRGB(230, 230, 230),
				TextSize = 11.000,
				TextTransparency = 0.500,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
			})

			utils.create("ImageLabel", {
				Name = "SectionImage",
				Parent = Section,
				AnchorPoint = Vector2.new(1, 0.5),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.999,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.new(1, -10, 0.5, 0),
				Rotation = -90.000,
				Size = UDim2.new(0, 22, 0, 22),
				Image = "rbxassetid://16851841101",
				ImageTransparency = 0.700,
			})

			local SectionButton = utils.create("TextButton", {
				Name = "SectionButton",
				Parent = Section,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.999,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 1, 0),
				Font = Enum.Font.SourceSans,
				Text = "",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 14.000,
			})
			EnterMouse(Section)

			SectionButton.Activated:Connect(function()
				UIPageLayout:JumpToIndex(selection_ScrollLayer.LayoutOrder)
				utils.tween(
					BackButton,
					{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
					{TextTransparency = 0.7}
				)
				BackButton_2.Text = info.Title
				utils.tween(
					BackButton_2,
					{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
					{TextTransparency = 0}
				)
				utils.tween(
					ForwardImage,
					{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
					{ImageTransparency = 0}
				)
			end)

			if SectionDescription.Text == "" then
				Section.Size = UDim2.new(1, -8, 0, 33)
			else
				SectionDescription:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
					SectionDescription.TextWrapped = false
					SectionDescription.Size = UDim2.new(1, -70, 0, 11 + (11 * (SectionDescription.TextBounds.X // SectionDescription.AbsoluteSize.X)))
					Section.Size = UDim2.new(1, -8, 0, SectionDescription.AbsoluteSize.Y + 33)
					SectionDescription.TextWrapped = true
					UpSize(ScrollLayer)
				end)

				SectionDescription.TextWrapped = false
				SectionDescription.Size = UDim2.new(1, -70, 0, 11 + (11 * (SectionDescription.TextBounds.X // SectionDescription.AbsoluteSize.X)))
				Section.Size = UDim2.new(1, -8, 0, SectionDescription.AbsoluteSize.Y + 33)
				SectionDescription.TextWrapped = true
				UpSize(selection_ScrollLayer)
			end

			library.FuncMain = {}
			library.FuncMain.Toggle = function(info)
				if info.Default == nil or typeof(info.Default) ~= "boolean" then
					return
				end
				local default = info.Default
				local ToggleTable = {}

				local Toggle = utils.create("Frame", {
					Name = "Toggle",
					Parent = selection_ScrollLayer,
					BackgroundColor3 = Color3.fromRGB(42, 42, 42),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(1, -8, 0, 44),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 3),
					Parent = Toggle,
				})

				local ToggleContent = utils.create("TextLabel", {
					Name = "ToggleContent",
					Parent = Toggle,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 22),
					Size = UDim2.new(1, -70, 0, 11),
					Font = Enum.Font.GothamBold,
					LineHeight = 0.900,
					Text = info.Desc or "",
					TextColor3 = Color3.fromRGB(230, 230, 230),
					TextSize = 11.000,
					TextTransparency = 0.500,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				utils.create("TextLabel", {
					Name = "ToggleTitle",
					Parent = Toggle,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 10),
					Size = UDim2.new(1, -70, 0, 12),
					Font = Enum.Font.GothamBold,
					Text = info.Title or "",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12.000,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local ToggleSwitch = utils.create("Frame", {
					Name = "ToggleSwitch",
					Parent = Toggle,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(230, 230, 230),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(1, -10, 0.5, 0),
					Size = UDim2.new(0, 40, 0, 18),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(1, 0),
					Parent = ToggleSwitch,
				})

				local ToggleSwitch2 = utils.create("Frame", {
					Name = "ToggleSwitch2",
					Parent = ToggleSwitch,
					BackgroundColor3 = Color3.fromRGB(40, 40, 40),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 1, 0, 1),
					Size = UDim2.new(1, -2, 1, -2),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(1, 0),
					Parent = ToggleSwitch2,
				})

				local SwitchImage = utils.create("ImageLabel", {
					Name = "SwitchImage",
					Parent = ToggleSwitch2,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(0, 16, 0, 16),
					Image = "rbxassetid://3926305904",
					ImageRectOffset = Vector2.new(124, 124),
					ImageRectSize = Vector2.new(36, 36),
				})

				local ToggleButton = utils.create("TextButton", {
					Name = "ToggleButton",
					Parent = Toggle,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 1, 0),
					Font = Enum.Font.SourceSans,
					Text = "",
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextSize = 14.000,
				})

				if ToggleContent.Text == "" then
					Toggle.Size = UDim2.new(1, -8, 0, 33)
				else
					ToggleContent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
						ToggleContent.TextWrapped = false
						ToggleContent.Size = UDim2.new(1, -70, 0, 11 + (11 * (ToggleContent.TextBounds.X // ToggleContent.AbsoluteSize.X)))
						Toggle.Size = UDim2.new(1, -8, 0, ToggleContent.AbsoluteSize.Y + 33)
						ToggleContent.TextWrapped = true
					end)

					ToggleContent.TextWrapped = false
					ToggleContent.Size = UDim2.new(1, -70, 0, 11 + (11 * (ToggleContent.TextBounds.X // ToggleContent.AbsoluteSize.X)))
					Toggle.Size = UDim2.new(1, -8, 0, ToggleContent.AbsoluteSize.Y + 33)
					ToggleContent.TextWrapped = true
				end

				function ToggleTable.SetValue(setval)
					if setval then
						utils.tween(
							ToggleSwitch,
							{0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
							{BackgroundColor3 = (libraryinfo["Color"]) and libraryinfo["Color"] or Color3.fromRGB(127, 146, 242)}
						)
						utils.tween(
							ToggleSwitch2,
							{0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
							{BackgroundColor3 = (libraryinfo["Color"]) and libraryinfo["Color"] or Color3.fromRGB(127, 146, 242)}
						)
						utils.tween(
							SwitchImage,
							{0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
							{Position = UDim2.new(0, 22, 0, 0)}
						)
					else
						utils.tween(
							ToggleSwitch,
							{0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
							{BackgroundColor3 = Color3.fromRGB(230, 230, 230)}
						)
						utils.tween(
							ToggleSwitch2,
							{0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
							{BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
						)
						utils.tween(
							SwitchImage,
							{0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
							{Position = UDim2.new(0, 0, 0, 0)}
						)
					end
					default = setval
					local Success, Response = pcall(function()
						info.Callback(default)
					end)

					if not Success then
						warn((info.Title or "null").." Callback Error " ..tostring(Response))
					end
				end

				EnterMouse(Toggle)
				ToggleButton.Activated:Connect(function()
					default = not default
					ToggleTable.SetValue(default)
				end)
				ToggleTable.SetValue(default) 
				return ToggleTable
			end
			library.FuncMain.Paragraph = function(info)
				local ParagraphFunc = {}
				local Paragraph = utils.create("Frame", {
					Name = "Paragraph",
					Parent = selection_ScrollLayer,
					BackgroundColor3 = Color3.fromRGB(42, 42, 42),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					LayoutOrder = 2,
					Size = UDim2.new(1, -8, 0, 44),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 3),
					Parent = Paragraph,
				})

				local ParagraphContent = utils.create("TextLabel", {
					Name = "ParagraphContent",
					Parent = Paragraph,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 22),
					Size = UDim2.new(1, -150, 0, 11),
					Font = Enum.Font.GothamBold,
					LineHeight = 0.900,
					Text = info.Desc or "",
					TextColor3 = Color3.fromRGB(230, 230, 230),
					TextSize = 11.000,
					TextTransparency = 0.500,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local ParagraphTitle = utils.create("TextLabel", {
					Name = "ParagraphTitle",
					Parent = Paragraph,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 10),
					Size = UDim2.new(1, -20, 0, 12),
					Font = Enum.Font.GothamBold,
					Text = info.Title or "",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12.000,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				if ParagraphContent.Text == "" then
					Paragraph.Size = UDim2.new(1, -8, 0, 33)
				else
					ParagraphContent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
						ParagraphContent.TextWrapped = false
						ParagraphContent.Size = UDim2.new(1, -150, 0, 11 + (11 * (ParagraphContent.TextBounds.X // ParagraphContent.AbsoluteSize.X)))
						Paragraph.Size = UDim2.new(1, -8, 0, ParagraphContent.AbsoluteSize.Y + 33)
						ParagraphContent.TextWrapped = true
					end)

					ParagraphContent.TextWrapped = false
					ParagraphContent.Size = UDim2.new(1, -150, 0, 11 + (11 * (ParagraphContent.TextBounds.X // ParagraphContent.AbsoluteSize.X)))
					Paragraph.Size = UDim2.new(1, -8, 0, ParagraphContent.AbsoluteSize.Y + 33)
					ParagraphContent.TextWrapped = true
				end

				function ParagraphFunc:Set(Value)
					ParagraphTitle.Text = Value.Title or ParagraphTitle.Text
					ParagraphContent.Text =  Value.Content or ParagraphContent.Text
					if ParagraphContent.Text == "" then
						Paragraph.Size = UDim2.new(1, -8, 0, 33)
					else
						ParagraphContent.TextWrapped = false
						ParagraphContent.Size = UDim2.new(1, -150, 0, 11 + (11 * (ParagraphContent.TextBounds.X // ParagraphContent.AbsoluteSize.X)))
						Paragraph.Size = UDim2.new(1, -8, 0, ParagraphContent.AbsoluteSize.Y + 33)
						ParagraphContent.TextWrapped = true
					end
				end
				return ParagraphFunc
			end
			library.FuncMain.Seperator = function(info)
				local SeperatorFunc = {}
				local Seperator = utils.create("TextLabel", {
					Name = "Seperator",
					Parent = selection_ScrollLayer,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(1, -8, 0, 16),
					Font = Enum.Font.GothamBold,
					Text = info.Title,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 11.000,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
				})
				Seperator:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
					Seperator.TextWrapped = false
					Seperator.Size = UDim2.new(1, -8, 0, 16 + (11 * (Seperator.TextBounds.X // Seperator.AbsoluteSize.X)))
					Seperator.TextWrapped = true
				end)

				Seperator.TextWrapped = false
				Seperator.Size = UDim2.new(1, -8, 0, 16 + (11 * (Seperator.TextBounds.X // Seperator.AbsoluteSize.X)))
				Seperator.TextWrapped = true

				function SeperatorFunc.Set(Value)
					Seperator.Text = Value or "Seperator"
				end
				return SeperatorFunc
			end
			library.FuncMain.Button = function(info)
				local Button = utils.create("Frame", {
					Name = "Button",
					Parent = selection_ScrollLayer,
					BackgroundColor3 = Color3.fromRGB(42, 42, 42),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					LayoutOrder = 4,
					Size = UDim2.new(1, -8, 0, 44),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 3),
					Parent = Button,
				})

				local ButtonContent = utils.create("TextLabel", {
					Name = "ButtonContent",
					Parent = Button,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 22),
					Size = UDim2.new(1, -150, 0, 11),
					Font = Enum.Font.GothamBold,
					LineHeight = 0.900,
					Text = info.Desc or "",
					TextColor3 = Color3.fromRGB(230, 230, 230),
					TextSize = 11.000,
					TextTransparency = 0.500,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				utils.create("TextLabel", {
					Name = "ButtonTitle",
					Parent = Button,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 10),
					Size = UDim2.new(1, -150, 0, 12),
					Font = Enum.Font.GothamBold,
					Text = info.Title or "",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12.000,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local ButtonButton = utils.create("TextButton", {
					Name = "ButtonButton",
					Parent = Button,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 1, 0),
					Font = Enum.Font.SourceSans,
					Text = "",
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextSize = 14.000,
				})

				local ClickFrame = utils.create("Frame", {
					Name = "ClickFrame",
					Parent = Button,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(60, 60, 60),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(1, -10, 0.5, 0),
					Size = UDim2.new(0, 120, 0, 26),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 3),
					Parent = ClickFrame,
				})

				utils.create("TextLabel", {
					Name = "ClickText",
					Parent = ClickFrame,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 1, 0),
					Font = Enum.Font.GothamBold,
					Text = "Click",
					TextColor3 = Color3.fromRGB(230, 230, 230),
					TextSize = 12.000,
				})

				if ButtonContent.Text == "" then
					Button.Size = UDim2.new(1, -8, 0, 33)
				else
					ButtonContent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
						ButtonContent.TextWrapped = false
						ButtonContent.Size = UDim2.new(1, -150, 0, 11 + (11 * (ButtonContent.TextBounds.X // ButtonContent.AbsoluteSize.X)))
						Button.Size = UDim2.new(1, -8, 0, ButtonContent.AbsoluteSize.Y + 33)
						ButtonContent.TextWrapped = true
					end)

					ButtonContent.TextWrapped = false
					ButtonContent.Size = UDim2.new(1, -150, 0, 11 + (11 * (ButtonContent.TextBounds.X // ButtonContent.AbsoluteSize.X)))
					Button.Size = UDim2.new(1, -8, 0, ButtonContent.AbsoluteSize.Y + 33)
					ButtonContent.TextWrapped = true
				end

				ButtonButton.Activated:Connect(function()
					local Success, Response = pcall(function()
						info.Callback()
					end)

					if not Success then
						warn((info.Title or "null").." Callback Error " ..tostring(Response))
					end
				end)
				EnterMouse(Button)
			end

			library.FuncMain.Slider = function(info)
				local callback = info.Callback or function() end
				local Max = info.Max
				local Min = info.Min
				local de = info.Default
				local Increment = info.Increment
				local dragging = false
				local SliderTable = {}

				local Slider = utils.create("Frame", {
					Name = "Slider",
					Parent = selection_ScrollLayer,
					BackgroundColor3 = Color3.fromRGB(42, 42, 42),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					LayoutOrder = 10,
					Size = UDim2.new(1, -8, 0, 44),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 3),
					Parent = Slider,
				})

				local SliderContent = utils.create("TextLabel", {
					Name = "SliderContent",
					Parent = Slider,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 22),
					Size = UDim2.new(1, -150, 0, 11),
					Font = Enum.Font.GothamBold,
					LineHeight = 0.900,
					Text = info.Desc or "",
					TextColor3 = Color3.fromRGB(230, 230, 230),
					TextSize = 11.000,
					TextTransparency = 0.500,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				utils.create("TextLabel", {
					Name = "SliderTitle",
					Parent = Slider,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 10),
					Size = UDim2.new(1, -150, 0, 12),
					Font = Enum.Font.GothamBold,
					Text = info.Title,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12.000,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local SliderFrame = utils.create("Frame", {
					Name = "SliderFrame",
					Parent = Slider,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.800,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(1, -10, 0.5, 0),
					Size = UDim2.new(0, 100, 0, 2),
				})

				utils.create("UICorner", {
					Parent = SliderFrame,
				})

				local SliderDrag = utils.create("Frame", {
					Name = "SliderDrag",
					Parent = SliderFrame,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = (libraryinfo["Color"]) and libraryinfo["Color"] or Color3.fromRGB(127, 146, 242),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 0.5, 0),
					Size = UDim2.fromScale((de - Min) / (Max - Min), 1),
				})

				utils.create("UICorner", {
					Parent = SliderDrag,
				})

				local SliderFrDrag = utils.create("Frame", {
					Name = "SliderFrDrag",
					Parent = SliderFrame,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2FromTable({-2.08, 0},{0.5, 0}),
					Size = UDim2FromTable({3.12, 0},{0, 33}),
				})

				local SliderNumber = utils.create("TextBox", {
					Name = "SliderNumber",
					Parent = Slider,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(1, -115, 0.5, 0),
					Size = UDim2.new(0, 40, 0, 13),
					Font = Enum.Font.GothamBold,
					PlaceholderColor3 = Color3.fromRGB(230, 230, 230),
					PlaceholderText = "",
					Text = tostring(de),
					TextColor3 = Color3.fromRGB(230, 230, 230),
					TextSize = 11.000,
					TextXAlignment = Enum.TextXAlignment.Right,
				})


				if SliderContent.Text == "" then
					Slider.Size = UDim2.new(1, -8, 0, 33)
				else
					SliderContent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
						SliderContent.TextWrapped = false
						SliderContent.Size = UDim2.new(1, -150, 0, 11 + (11 * (SliderContent.TextBounds.X // SliderContent.AbsoluteSize.X)))
						Slider.Size = UDim2.new(1, -8, 0, SliderContent.AbsoluteSize.Y + 33)
						SliderContent.TextWrapped = true
					end)

					SliderContent.TextWrapped = false
					SliderContent.Size = UDim2.new(1, -150, 0, 11 + (11 * (SliderContent.TextBounds.X // SliderContent.AbsoluteSize.X)))
					Slider.Size = UDim2.new(1, -8, 0, SliderContent.AbsoluteSize.Y + 33)
					SliderContent.TextWrapped = true
				end

				local function Round(Number, Factor)
					local Result = math.floor(Number/Factor + (math.sign(Number) * 0.5)) * Factor
					if Result < 0 then 
						Result = Result + Factor 
					end
					return Result
				end

				function SliderTable.Set(Value)
					Value = math.clamp(Round(Value, Increment), Min, Max)
					SliderNumber.Text = tostring(Value)
					utils.tween(
						SliderDrag,
						{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out},
						{Size = UDim2.fromScale((Value - Min) / (Max - Min), 1)}
					)

					local Success, Response = pcall(function()
						callback()
					end)

					if not Success then
						warn((info.Title or "null").." Callback Error " ..tostring(Response))
					end
				end

				SliderNumber.FocusLost:Connect(function()
					local value = tonumber(SliderNumber.Text)
					if not value then
						SliderNumber.Text = tostring(de)
						SliderTable.Set(de)
					else
						SliderTable.Set(value)
						de = value
					end
				end)

				SliderFrDrag.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then 
						dragging = true 
						SliderTable.Set(Min + ((Max - Min) * math.clamp((Input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1))) 
					end 
				end)
				SliderFrDrag.InputEnded:Connect(function(Input) 
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then 
						dragging = false 
					end 
				end)
				UserInputService.InputChanged:Connect(function(Input)
					if dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then 
						SliderTable.Set(Min + ((Max - Min) * math.clamp((Input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1))) 
					end
				end)

				SliderTable.Set(de)
			end

			library.FuncMain.Dropdown = function(info)
				local default = info.Default or ((info.Multi) and {} or "")
				local list = info.List
				local Canoff = info.Canoff or false
				if info.Multi and typeof(default) ~= "table" then
					warn("Default Must be Table")
					return
				elseif not info.Multi and typeof(default) == "table" then
					warn("Default Must be string or number")
					return
				end

				local Dropdown = utils.create("Frame", {
					Name = "Dropdown",
					Parent = selection_ScrollLayer,
					BackgroundColor3 = Color3.fromRGB(42, 42, 42),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					LayoutOrder = 12,
					Size = UDim2.new(1, -8, 0, 44),
				})
				
				Dropdown:GetPropertyChangedSignal("Size"):Connect(function()
					UpSize(selection_ScrollLayer)
				end)

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 3),
					Parent = Dropdown,
				})

				utils.create("TextLabel", {
					Name = "DropdownTitle",
					Parent = Dropdown,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 6),
					Size = UDim2.new(1, -20, 0, 12),
					Font = Enum.Font.GothamBold,
					Text = info.Title or "",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12.000,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local DropdownButton = utils.create("TextButton", {
					Name = "DropdownButton",
					Parent = Dropdown,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 1, 0),
					Font = Enum.Font.SourceSans,
					Text = "",
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextSize = 14.000,
				})

				local DropdownFrame = utils.create("Frame", {
					Name = "DropdownFrame",
					Parent = Dropdown,
					BackgroundColor3 = Color3.fromRGB(53, 53, 53),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Position = UDim2.new(0, 8, 0, 20),
					Size = UDim2.new(1, -16, 0, 18),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 3),
					Parent = DropdownFrame,
				})

				local DropdownBox = utils.create("TextBox", {
					Name = "DropdownBox",
					Parent = DropdownFrame,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 5, 0, 0),
					Size = UDim2.new(1, -24, 1, 0),
					Font = Enum.Font.GothamBold,
					PlaceholderColor3 = Color3.fromRGB(120, 120, 120),
					PlaceholderText = "Select Options",
					Text = "",
					TextColor3 = Color3.fromRGB(120, 120, 120),
					TextSize = 12.000,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				utils.create("ImageLabel", {
					Name = "DropdownImage",
					Parent = DropdownFrame,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(1, 0, 0.5, 0),
					Rotation = 90.000,
					Size = UDim2.new(0, 18, 0, 18),
					Image = "rbxassetid://18449693202",
					ImageColor3 = Color3.fromRGB(230, 230, 230),
				})

				local DropdownUnder = utils.create("Frame", {
					Name = "DropdownUnder",
					Parent = Dropdown,
					BackgroundColor3 = Color3.fromRGB(53, 53, 53),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Position = UDim2.new(0, 8, 0, 46),
					Size = UDim2.new(1, -16, 0, 116),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 3),
					Parent = DropdownUnder,
				})

				local ScrollUnder = utils.create("ScrollingFrame", {
					Name = "ScrollUnder",
					Parent = DropdownUnder,
					Active = true,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(1, -10, 1, -10),
					CanvasSize = UDim2.new(0, 0, 0, 0),
					ScrollBarThickness = 0,
				})

				utils.create("UIListLayout", {
					Parent = ScrollUnder,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 3),
				})

				AutoUp(ScrollUnder)

				local DropF = {}
				local DropG = true


				function DropF.Clear()
					if info.Multi then
						default = {}
					else
						default = nil
					end
					local Success, Response = pcall(function()
						info.Callback(default)
					end)

					if not Success then
						warn((info.Title or "null").." Callback Error " ..tostring(Response))
					end

					for _, DropFrame in ScrollUnder:GetChildren() do
						if DropFrame.Name == "Option" then
							DropdownBox.Text = ""
							DropFrame:Destroy()
						end
					end
				end
				
				function DropF.Set(...)
					local Value, Optionx = ...
					default = Value or default
					if info.Multi then
						for _, Drop in ScrollUnder:GetChildren() do
							if Drop.Name ~= "UIListLayout" and not table.find(default, Drop.OptionText.Text) then
								Drop.ChoosingFrame.AnchorPoint = Vector2.new(0, 1)
								Drop.ChoosingFrame.Position = UDim2.new(0, 5, 1, -5)
								utils.tween(
									Drop,
									{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
									{BackgroundColor3 = Color3.fromRGB(53, 53, 53)}
								)
								utils.tween(
									Drop.ChoosingFrame,
									{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
									{Size = UDim2.new(0, 2, 0, 0), Transparency = 0.999}
								)
								utils.tween(
									Drop.ChoosingFrame.UIStroke,
									{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
									{Transparency = 0.999}
								)
							elseif Drop.Name ~= "UIListLayout" and table.find(default, Drop.OptionText.Text) then
								Drop.ChoosingFrame.AnchorPoint = Vector2.new(0, 0)
								Drop.ChoosingFrame.Position = UDim2.new(0, 5, 0, 5)
								utils.tween(
									Drop,
									{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
									{BackgroundColor3 = Color3.fromRGB(70, 70, 70)}
								)
								utils.tween(
									Drop.ChoosingFrame,
									{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
									{Size = UDim2.new(0, 2, 0, 10), Transparency = 0}
								)
								utils.tween(
									Drop.ChoosingFrame.UIStroke,
									{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
									{Transparency = 0}
								)
							end
						end
						local DropdownValueTable = table.concat(default, ", ")
						if DropdownValueTable == "" then
							DropdownBox.Text = ""
						else
							DropdownBox.Text = tostring(DropdownValueTable)
						end
					else
						for _, Drop in ScrollUnder:GetChildren() do
							if Drop.Name ~= "UIListLayout" and Value ~= Drop.OptionText.Text then
								Drop.ChoosingFrame.AnchorPoint = Vector2.new(0, 1)
								Drop.ChoosingFrame.Position = UDim2.new(0, 5, 1, -5)
								utils.tween(
									Drop,
									{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
									{BackgroundColor3 = Color3.fromRGB(53, 53, 53)}
								)
								utils.tween(
									Drop.ChoosingFrame,
									{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
									{Size = UDim2.new(0, 2, 0, 0), Transparency = 0.999}
								)
								utils.tween(
									Drop.ChoosingFrame.UIStroke,
									{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
									{Transparency = 0.999}
								)
							end
						end
						Optionx.ChoosingFrame.AnchorPoint = Vector2.new(0, 0)
						Optionx.ChoosingFrame.Position = UDim2.new(0, 5, 0, 5)
						utils.tween(
							Optionx,
							{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
							{BackgroundColor3 = Color3.fromRGB(70, 70, 70)}
						)
						utils.tween(
							Optionx.ChoosingFrame,
							{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
							{Size = UDim2.new(0, 2, 0, 10), Transparency = 0}
						)
						utils.tween(
							Optionx.ChoosingFrame.UIStroke,
							{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
							{Transparency = 0}
						)
						DropdownBox.Text = default
					end
					info.Callback(default)
				end

				function DropF.Add(OptionName)
					local OptionName = OptionName or "Option"

					local Option = utils.create("Frame", {
						Name = "Option",
						Parent = ScrollUnder,
						BackgroundColor3 = Color3.fromRGB(53, 53, 53),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						LayoutOrder = 1,
						Size = UDim2.new(1, 0, 0, 20),
					})

					utils.create("UICorner", {
						CornerRadius = UDim.new(0, 3),
						Parent = Option,
					})

					local ChoosingFrame = utils.create("Frame", {
						Name = "ChoosingFrame",
						Parent = Option,
						AnchorPoint = Vector2.new(0, 1),
						BackgroundColor3 = (libraryinfo["Color"]) and libraryinfo["Color"] or Color3.fromRGB(127, 146, 242),
						BackgroundTransparency = 0.999,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 5, 1, -5),
						Size = UDim2.new(0, 2, 0, 0),
					})

					utils.create("UIStroke", {
						Color = (libraryinfo["Color"]) and libraryinfo["Color"] or Color3.fromRGB(127, 146, 242),
						Thickness = 0.800000011920929,
						Transparency = 0.9990000128746033,
						Parent = ChoosingFrame,
					})

					utils.create("UICorner", {
						CornerRadius = UDim.new(0, 3),
						Parent = ChoosingFrame,
					})

					local OptionText = utils.create("TextLabel", {
						Name = "OptionText",
						Parent = Option,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 0.999,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 14, 0, 0),
						Size = UDim2.new(1, -25, 1, 0),
						Font = Enum.Font.GothamBold,
						LineHeight = 0.900,
						Text = OptionName,
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 11.000,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Left,
					})

					local OptionButton = utils.create("TextButton", {
						Name = "OptionButton",
						Parent = Option,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 0.999,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Size = UDim2.new(1, 0, 1, 0),
						Font = Enum.Font.SourceSans,
						Text = "",
						TextColor3 = Color3.fromRGB(0, 0, 0),
						TextSize = 14.000,
					})
					
					OptionButton.Activated:Connect(function()
						if info.Multi then
							if not table.find(default, OptionText.Text) then
								table.insert(default, OptionText.Text)
								DropF.Set(default)
							else
								for i, value in pairs(default) do
									if value == OptionText.Text then
										table.remove(default, i)
										break
									end
								end
								DropF.Set(default)
							end
						else
							DropF.Set(OptionText.Text, Option)
						end
					end)
				end
				
				local StartInput = false
				DropdownButton.Activated:Connect(function()
					if Dropdown.Size.Y.Offset > 44 then
						utils.tween(
							Dropdown,
							{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
							{Size = UDim2.new(1, -8, 0, 44)}
						)
					else
						utils.tween(
							Dropdown,
							{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
							{Size = UDim2.new(1, -8, 0, 168)}
						)
					end
				end)

				DropdownBox.Focused:Connect(function()
					StartInput = true
					utils.tween(
						Dropdown,
						{0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut},
						{Size = UDim2.new(1, -8, 0, 168)}
					)
				end)
				DropdownBox.FocusLost:Connect(function()
					StartInput = false
				end)
				DropdownBox:GetPropertyChangedSignal("Text"):Connect(function()
					if DropdownBox.Text == "" then
						for i, v in ScrollUnder:GetChildren() do
							if v.Name ~= "UIListLayout" then
								v.Visible = true
							end
						end
					else
						if StartInput then
							for i, v in ScrollUnder:GetChildren() do
								if v.Name ~= "UIListLayout" then
									v.Visible = string.find(string.lower(v.OptionText.Text), string.lower(DropdownBox.Text))
								end
							end
						end
					end
				end)
				
				for _, v in next,list do
					DropF.Add(v)
				end
				
				DropF.Set(default)
			end

			library.FuncMain.TextInput = function(info)
				local TextInputFunc = {}
				local TextInput = utils.create("Frame", {
					Name = "TextInput",
					Parent = selection_ScrollLayer,
					BackgroundColor3 = Color3.fromRGB(42, 42, 42),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					LayoutOrder = 6,
					Size = UDim2.new(1, -8, 0, 44),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 3),
					Parent = TextInput,
				})

				local TextInputContent = utils.create("TextLabel", {
					Name = "TextInputContent",
					Parent = TextInput,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 22),
					Size = UDim2.new(1, -150, 0, 11),
					Font = Enum.Font.GothamBold,
					LineHeight = 0.900,
					Text = info.Desc or "",
					TextColor3 = Color3.fromRGB(230, 230, 230),
					TextSize = 11.000,
					TextTransparency = 0.500,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				utils.create("TextLabel", {
					Name = "TextInputTitle",
					Parent = TextInput,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 10),
					Size = UDim2.new(1, -150, 0, 12),
					Font = Enum.Font.GothamBold,
					Text = info.Title or "",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12.000,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local InputFrame = utils.create("Frame", {
					Name = "InputFrame",
					Parent = TextInput,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(53, 53, 53),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Position = UDim2.new(1, -10, 0.5, 0),
					Size = UDim2.new(0, 120, 0, 26),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 3),
					Parent = InputFrame,
				})

				local TextBox = utils.create("TextBox", {
					Name = "InputBox",
					Parent = InputFrame,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 5, 0, 0),
					Size = UDim2.new(1, -10, 1, 0),
					Font = Enum.Font.GothamBold,
					ClearTextOnFocus = (info["Clear_Text_On_Focus"]) and info["Clear Text On Focus"] or true,
					PlaceholderText = (info["Place_Holder_Text"]) and info["Place_Holder_Text"] or "Enter your text here...",
					Text = info.Default or "",
					TextColor3 = Color3.fromRGB(230, 230, 230),
					TextSize = 11.000,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				if TextInputContent.Text == "" then
					TextInput.Size = UDim2.new(1, -8, 0, 33)
				else
					TextInputContent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
						TextInputContent.TextWrapped = false
						TextInputContent.Size = UDim2.new(1, -150, 0, 11 + (11 * (TextInputContent.TextBounds.X // TextInputContent.AbsoluteSize.X)))
						TextInput.Size = UDim2.new(1, -8, 0, TextInputContent.AbsoluteSize.Y + 33)
						TextInputContent.TextWrapped = true
					end)

					TextInputContent.TextWrapped = false
					TextInputContent.Size = UDim2.new(1, -150, 0, 11 + (11 * (TextInputContent.TextBounds.X // TextInputContent.AbsoluteSize.X)))
					TextInput.Size = UDim2.new(1, -8, 0, TextInputContent.AbsoluteSize.Y + 33)
					TextInputContent.TextWrapped = true
				end

				function TextInputFunc.Set(Value)
					TextBox.Text = Value
					local Success, Response = pcall(function()
						info.Callback(Value)
					end)

					if not Success then
						warn((info.Title or "null").." Callback Error " ..tostring(Response))
					end
				end

				TextBox.FocusLost:Connect(function()
					TextInputFunc.Set(TextBox.Text)
				end)
			end

			SelectionOrders = SelectionOrders + 1
			PageOrders = PageOrders + 1
			return library.FuncMain
		end
		PageOrders = PageOrders + 1
		return library.sections
	end
	return library.tab
end
return library
