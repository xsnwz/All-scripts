do 
	Players = game:GetService("Players")

	-- Module GetService
	RunService = game:GetService("RunService")
	VirtualInputManager = game:GetService('VirtualInputManager')
	UserInputService = game:GetService("UserInputService")
	GuiService = game:GetService("GuiService")
	TweenService = game:GetService("TweenService")
	MarketplaceService = game:GetService("MarketplaceService")
	HttpService = game:GetService("HttpService")
	repeat 
		LocalPlayer = Players.LocalPlayer
		wait()
	until LocalPlayer
	-- Module
	PlayerGui = LocalPlayer.PlayerGui
	Backpack = LocalPlayer.Backpack

	GetMouse = LocalPlayer:GetMouse()
end

local global_env = (getgenv and getgenv()) or _G

global_env.Theme = {
	Red = {
		["MainColor"] = Color3.fromRGB(250, 0, 0),
		["DeepMainColor"] = Color3.fromRGB(54, 42, 27),
		["Toggle"] = {
			["Main"] = Color3.fromRGB(213, 0, 0),
			["Deep"] = Color3.fromRGB(179, 0, 0),
		},
		["Button"] = {
			["Main"] = Color3.fromRGB(130, 0, 0),
			["Deep"] = Color3.fromRGB(76, 0, 0),
		},
		["Almost"] = {
			["Main"] = Color3.fromRGB(213, 0, 0),
			["Deep"] = Color3.fromRGB(50, 0, 0),
		}
	},
	Brow = {
		["MainColor"] = Color3.fromRGB(212, 167, 106),
		["DeepMainColor"] = Color3.fromRGB(54, 42, 27),
		["Toggle"] = {
			["Main"] = Color3.fromRGB(212, 167, 106),
			["Deep"] = Color3.fromRGB(162, 125, 81),
		},
		["Button"] = {
			["Main"] = Color3.fromRGB(212, 167, 106),
			["Deep"] = Color3.fromRGB(162, 125, 81),
		},
		["Almost"] = {
			["Main"] = Color3.fromRGB(212, 167, 106),
			["Deep"] = Color3.fromRGB(54, 42, 27),
		}
	}
}

if global_env.xsnwzlib then
	return
end

local library = {} library.__index = library
local utils = {} utils.__index = utils
library.theme = global_env.Theme.Brow
utils.tween = function(obj, info, properties, callback)
	local anim = TweenService:Create(obj, TweenInfo.new(unpack(info)), properties)
	anim:Play()

	if callback then
		anim.Completed:Connect(callback)
	end

	return anim
end


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

local ActualTypes = {
	RoundFrame = "ImageLabel",
	Shadow = "ImageLabel",
	Circle = "ImageLabel",
	CircleButton = "ImageButton",
	Frame = "Frame",
	Label = "TextLabel",
	Button = "TextButton",
	SmoothButton = "ImageButton",
	Box = "TextBox",
	ScrollingFrame = "ScrollingFrame",
	Menu = "ImageButton",
	NavBar = "ImageButton"
}

local Properties = {
	RoundFrame = {
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554237731",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(3,3,297,297)
	},
	SmoothButton = {
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554237731",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(3,3,297,297)
	},
	Shadow = {
		Name = "Shadow",
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554236805",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(23,23,277,277),
		Size = UDim2.fromScale(1,1) + UDim2.fromOffset(30,30),
		Position = UDim2.fromOffset(-15,-15)
	},
	Circle = {
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554831670"
	},
	CircleButton = {
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Image = "http://www.roblox.com/asset/?id=5554831670"
	},
	Frame = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1,1)
	},
	Label = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	Button = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	Box = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	ScrollingFrame = {
		BackgroundTransparency = 1,
		ScrollBarThickness = 0,
		CanvasSize = UDim2.fromScale(0,0),
		Size = UDim2.fromScale(1,1)
	},
	Menu = {
		Name = "More",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5555108481",
		Size = UDim2.fromOffset(20,20),
		Position = UDim2.fromScale(1,0.5) - UDim2.fromOffset(25,10)
	},
	NavBar = {
		Name = "SheetToggle",
		Image = "http://www.roblox.com/asset/?id=5576439039",
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(20,20),
		Position = UDim2.fromOffset(5,5),
		AutoButtonColor = false
	}
}

local Types = {
	"RoundFrame",
	"Shadow",
	"Circle",
	"CircleButton",
	"Frame",
	"Label",
	"Button",
	"SmoothButton",
	"Box",
	"ScrollingFrame",
	"Menu",
	"NavBar"
}

function FindType(String)
	for _, Type in next, Types do
		if Type:sub(1, #String):lower() == String:lower() then
			return Type
		end
	end
	return false
end

local Objects = {}

function Objects.new(Type)
	local TargetType = FindType(Type)
	if TargetType then
		local NewImage = Instance.new(ActualTypes[TargetType])
		if Properties[TargetType] then
			for Property, Value in next, Properties[TargetType] do
				NewImage[Property] = Value
			end
		end
		return NewImage
	else
		return Instance.new(Type)
	end
end

function GetXY(GuiObject)
	local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
	local Px, Py = math.clamp(GetMouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(GetMouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
	return Px/Max, Py/May
end

utils.CircleAnim = function(GuiObject, EndColour, StartColour)
	local PX, PY = GetXY(GuiObject)
	local Circle = Objects.new("Shadow")
	Circle.Size = UDim2.fromScale(0,0)
	Circle.Position = UDim2.fromScale(PX,PY)
	Circle.ImageColor3 = StartColour or GuiObject.ImageColor3
	Circle.ZIndex = 200
	Circle.Parent = GuiObject
	local Size = GuiObject.AbsoluteSize.X
	TweenService:Create(Circle, TweenInfo.new(0.4), {Position = UDim2.fromScale(PX,PY) - UDim2.fromOffset(Size/2,Size/2), ImageTransparency = 1, ImageColor3 = EndColour, Size = UDim2.fromOffset(Size,Size)}):Play()
	spawn(function()
		wait(0.4)
		Circle:Destroy()
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
		ImageColor3 = library.theme.MainColor,
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

local AkaliNotif;
if not RunService:IsStudio() then
	AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/xsnwz/All-scripts/refs/heads/main/Libraries/Notify.lua"))();
end

checkDevice()

library.new = function(info)
	local work = utils.create("ScreenGui", {
		Name = HttpService:GenerateGUID(true):gsub("[{}]", ""),
		Parent = (gethui) and gethui() or ((RunService:IsStudio()) and PlayerGui or game:GetService("CoreGui")),
		DisplayOrder = 999,
	})

	global_env.xsnwzlib = work

	local glow = utils.create("ImageLabel", {
		Name = "@glow",
		Parent = work,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Position = UDim2.new(0.518244326, 0, 0.5, 0),
		Size = UDim2.new(0, 0, 0, 0),
		Image = "http://www.roblox.com/asset/?id=11801116249",
		ImageColor3 = Color3.fromRGB(10, 10, 10),
		ImageTransparency = 0.810,
		SliceCenter = Rect.new(6.1967436e-39, 6.1967436e-39, 6.1967436e-39, 6.1967436e-39),
	})

	utils.tween(glow, {0.4, Enum.EasingStyle.Back}, {
		Size = UDim2FromTable({0, 520},{0, 470})
	})


	utils.create("UIListLayout", {
		Parent = glow,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = Enum.VerticalAlignment.Center,
	})

	local mainscreen = utils.create("Frame", {
		Name = "@mainscreen",
		Parent = glow,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(15, 15, 15),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 0, 0, 0),
	})

	utils.tween(mainscreen, {0.4, Enum.EasingStyle.Back}, {
		Size = UDim2FromTable({0, 500},{0, 450})
	})

	utils.create("UICorner", {
		CornerRadius = UDim.new(0, 10),
		Parent = mainscreen,
	})

	local noise = utils.create("ImageLabel", {
		Name = "noise",
		Parent = mainscreen,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1.0007385, 0, 1.00100422, 0),
		Image = "rbxassetid://9968344105",
		ImageTransparency = 0.970,
		ScaleType = Enum.ScaleType.Tile,
		TileSize = UDim2.new(0, 128, 0, 128),
	})

	utils.create("UICorner", {
		CornerRadius = UDim.new(0, 10),
		Parent = noise,
	})

	local s1 = utils.create("ImageLabel", {
		Name = "s1",
		Parent = mainscreen,
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		Image = "rbxassetid://106004313642464",
		ImageColor3 = library.theme.MainColor,
		ImageRectOffset = Vector2.new(50, -300),
		ImageRectSize = Vector2.new(500, 500),
		ImageTransparency = 0.850,
	})

	utils.create("UICorner", {
		CornerRadius = UDim.new(0, 10),
		Parent = s1,
	})


	local xeo_title = utils.create("TextLabel", {
		Name = "@xeo_title",
		Parent = mainscreen,
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Position = UDim2.new(0.0340000018, 0, 0.0311111119, 0),
		Size = UDim2.new(0, 57, 0, 18),
		FontFace = Font.new("rbxassetid://12187374537", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
		Text = info.Title or "xsnwz",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextScaled = true,
		TextSize = 14.000,
		TextStrokeTransparency = 0.000,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	utils.create("UIGradient", {
		Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, library.theme.MainColor), ColorSequenceKeypoint.new(1.00, library.theme.DeepMainColor)},
		Rotation = 86,
		Name = "@xeo_gradient_title",
		Parent = xeo_title,
	})

	local scrollbar = utils.create("Frame", {
		Name = "@scrollbar",
		Parent = mainscreen,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1.000,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0.0844444409, 0),
		Size = UDim2.new(0, 500, 0, 35),
	})

	local scrollingbar = utils.create("ScrollingFrame", {
		Name = "@scrollingbar",
		Parent = scrollbar,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.423076928, 0),
		Size = UDim2.new(1, 0, 1, 0),
		CanvasSize = UDim2.new(0, 0, 0, 30),
		ScrollBarThickness = 0,
	})

	local UIListLayout_list = utils.create("UIListLayout", {
		Name = "@scrollingbar_list",
		Parent = scrollingbar,
		FillDirection = Enum.FillDirection.Horizontal,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 5),
	})

	UIListLayout_list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		scrollingbar.CanvasSize = UDim2.new(0, UIListLayout_list.AbsoluteContentSize.X + 35, 0, 0)
	end)

	utils.create("UIPadding", {
		Name = "@scrollingbar_padding",
		Parent = scrollingbar,
		PaddingLeft = UDim.new(0, 10),
		PaddingTop = UDim.new(0, 5),
	})

	utils.create("TextLabel", {
		Name = "@game_name",
		Parent = mainscreen,
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Position = UDim2.new(0.159999996, 0, 0.0311111119, 0),
		Size = UDim2.new(0, 408, 0, 18),
		FontFace = Font.new("rbxassetid://12187374537", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
		Text = "- " .. ((game["PlaceId"] ~= 0) and tostring(MarketplaceService:GetProductInfo(game["PlaceId"])["Name"]) or "nill"),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 14.000,
		TextStrokeTransparency = 0.000,
		TextTransparency = 0.600,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local container = utils.create("Frame", {
		Name = "@container",
		Parent = mainscreen,
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0.155555561, 0),
		Size = UDim2.new(0, 500, 0, 380),
	})

	local UIPageLayout = utils.create("UIPageLayout", {
		Parent = container,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Circular = true,
		GamepadInputEnabled = false,
		ScrollWheelInputEnabled = false,
		TouchInputEnabled = false,
		TweenTime = 0.250,
	})

	utils.dragify(glow, mainscreen, 0)

	library.tab = {
		Value = false
	}
	local PageOrders = -1
	function library.tab.tab(info)
		PageOrders = PageOrders + 1
		local buttonbar = utils.create("Frame", {
			Name = "@buttonbar",
			Parent = scrollingbar,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BorderSizePixel = 0,
			Size = UDim2.new(0, 50, 0, 23),
		})

		utils.create("UICorner", {
			CornerRadius = UDim.new(0, 300),
			Parent = buttonbar,
		})

		local TextLabel = utils.create("TextLabel", {
			Parent = buttonbar,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1.000,
			BorderSizePixel = 0,
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(1, 0, 1, 0),
			FontFace = Font.new("rbxassetid://12187374537", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
			Text = info.Title or "null",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 12.000,
			TextTransparency = 0.900,
		})

		buttonbar.Size = UDim2.new(0, TextLabel.TextBounds.X + 23, 0, 23)

		local UIGradient = utils.create("UIGradient", {
			Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(54, 54, 54)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(15, 15, 15))},
			Rotation = 86,
			Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.54), NumberSequenceKeypoint.new(1.00, 0.00)},
			Parent = buttonbar,
		})

		local UIStroke = utils.create("UIStroke", {
			Color = Color3.fromRGB(77, 77, 77),
			Transparency = 0.8999999761581421,
			Parent = buttonbar,
		})

		utils.create("UIGradient", {
			Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(130, 0, 0)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(76, 0, 0))
			},
			Parent = UIStroke,
		})

		local ButtonTap = utils.create("TextButton", {
			Name = "@interact",
			Parent = buttonbar,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1.000,
			BorderSizePixel = 0,
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(1, 0, 1, 0),
			AutoButtonColor = false,
			Font = Enum.Font.SourceSans,
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 14.000,
			TextTransparency = 1.000,
		})


		local section = utils.create("Frame", {
			Name = "@section",
			Parent = container,
			BackgroundTransparency = 1.000,
			BorderSizePixel = 0,
			Size = UDim2.new(0, 500, 0, 375),
			LayoutOrder = PageOrders
		})

		utils.create("UIListLayout", {
			Name = "@section_list",
			Parent = section,
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 5),
		})

		utils.create("UIPadding", {
			Name = "@section_padding",
			Parent = section,
			PaddingLeft = UDim.new(0, 5),
		})

		local left = utils.create("ScrollingFrame", {
			Name = "@left",
			Parent = section,
			BackgroundTransparency = 1.000,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 4.06901037e-08, 0),
			Size = UDim2.new(0, 240, 0, 372),
			CanvasSize = UDim2.new(0, 0, 0, 359),
			ScrollBarThickness = 0,
		})

		local left_list = utils.create("UIListLayout", {
			Name = "@left_list",
			Parent = left,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 5),
		})

		utils.create("UIPadding", {
			Name = "@left_padding",
			Parent = left,
			PaddingLeft = UDim.new(0, 5),
			PaddingTop = UDim.new(0, 5),
		})

		left_list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			left.CanvasSize = UDim2.new(0, 0, 0, left_list.AbsoluteContentSize.Y + 26)
		end)

		local right = utils.create("ScrollingFrame", {
			Name = "@right",
			Parent = section,
			BackgroundTransparency = 1.000,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 4.06901037e-08, 0),
			Size = UDim2.new(0, 240, 0, 372),
			CanvasSize = UDim2.new(0, 0, 0, 237),
			ScrollBarThickness = 0,
		})

		local right_list = utils.create("UIListLayout", {
			Name = "@right_list",
			Parent = right,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 5),
		})

		utils.create("UIPadding", {
			Name = "@right_padding",
			Parent = right,
			PaddingLeft = UDim.new(0, 5),
			PaddingTop = UDim.new(0, 5),
		})

		right_list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			right.CanvasSize = UDim2.new(0, 0, 0, right_list.AbsoluteContentSize.Y + 26)
		end)

		ButtonTap.MouseButton1Click:Connect(function()
			for _, value in pairs(scrollingbar:GetChildren()) do
				if value:IsA("Frame") and string.find(value["Name"], "buttonbar") and value:FindFirstChild("UIGradient") and value:FindFirstChild("TextLabel") and value:FindFirstChild("UIStroke") then
					utils.tween(value.TextLabel, { 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
						TextTransparency = 0.9,
					})

					utils.tween(value.UIStroke, { 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
						Color = Color3.fromRGB(77, 77, 77),
					})
					value.UIGradient.Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(54, 54, 54)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
					}
					value.UIGradient.Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 0.54),
						NumberSequenceKeypoint.new(1, 0)
					}
				end
			end
			UIPageLayout:JumpToIndex(section.LayoutOrder)
			utils.tween(TextLabel, { 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
				TextTransparency = 0,
			})

			utils.tween(UIStroke, { 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
				Color = Color3.fromRGB(255, 0, 0),
			})
			UIGradient.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, library.theme.Almost.Main),
				ColorSequenceKeypoint.new(1, library.theme.Almost.Deep)
			}
			UIGradient.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(1, 0)
			}
		end)

		if not library.tab.Value then 
			library.tab.Value = true 
			UIPageLayout:JumpToIndex(section.LayoutOrder)
			utils.tween(TextLabel, { 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
				TextTransparency = 0,
			})

			utils.tween(UIStroke, { 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
				Color = Color3.fromRGB(255, 0, 0),
			})
			UIGradient.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, library.theme.Almost.Main),
				ColorSequenceKeypoint.new(1, library.theme.Almost.Deep)
			}
			UIGradient.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(1, 0)
			}
		end 

		library.page = {}
		library.page.page = function(info)
			local pageframe = utils.create("Frame", {
				Name = "@pageframe",
				Parent = (info.Side == 2) and right or left,
				BackgroundColor3 = Color3.fromRGB(20, 20, 20),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.new(0.99000001, 0, 0, 56),
			})

			utils.create("UICorner", {
				Parent = pageframe,
			})

			local UIListLayout_3 = utils.create("UIListLayout", {
				Name = "@pageframe_uilistlayout",
				Parent = pageframe,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 2),
			})

			UIListLayout_3:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				pageframe.Size = UDim2.new(0.99, 0, 0, UIListLayout_3.AbsoluteContentSize.Y)
			end)

			utils.create("UIStroke", {
				Color = Color3.fromRGB(77, 77, 77),
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Transparency = 0.8100000023841858,
				Parent = pageframe,
			})

			local pageframe_topbar = utils.create("Frame", {
				Name = "@pageframe_topbar",
				Parent = pageframe,
				BackgroundColor3 = Color3.fromRGB(18, 18, 18),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 25),
			})

			utils.create("UICorner", {
				Parent = pageframe_topbar,
			})

			utils.create("Frame", {
				Name = "@pageframe_topbar_line",
				Parent = pageframe_topbar,
				BackgroundColor3 = Color3.fromRGB(18, 18, 18),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0.83333379, 0),
				Size = UDim2.new(1, 0, 0, 6),
			})

			utils.create("TextLabel", {
				Name = "@pageframe_title",
				Parent = pageframe_topbar,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1.000,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.new(0.479999989, 0, 0.499999911, 0),
				Size = UDim2.new(0.897007406, 0, 0.444444478, 0),
				FontFace = Font.new("rbxassetid://12187374537", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
				Text = info.Title or "null",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 14.000,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
			})

			utils.create("Frame", {
				Name = "@pageframe_topbar_line",
				Parent = pageframe_topbar,
				BackgroundColor3 = Color3.fromRGB(77, 77, 77),
				BackgroundTransparency = 0.810,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 1, 0),
				Size = UDim2.new(1, 0, 0, 1),
			})

			library.FuncMain = {}
			library.FuncMain.Button = function(info)
				local Button = utils.create("Frame", {
					Name = "@Button",
					Parent = pageframe,
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 0.147983715, 0),
					Size = UDim2.new(0, 232, 0, 27),
				})

				local buttonbar = utils.create("Frame", {
					Name = "@buttonbar",
					Parent = Button,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0.949999988, 0, 0, 19),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 4),
					Parent = buttonbar,
				})

				local TextLabel = utils.create("TextLabel", {
					Parent = buttonbar,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(1, 0, 1, 0),
					FontFace = Font.new("rbxassetid://12187374537", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
					Text = info.Title or "null",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12.000,
				})

				utils.create("UIGradient", {
					Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, library.theme.Toggle.Main), ColorSequenceKeypoint.new(1.00, library.theme.Toggle.Deep)},
					Rotation = 86,
					Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.54), NumberSequenceKeypoint.new(1.00, 0.00)},
					Parent = buttonbar,
				})

				local UIStroke = utils.create("UIStroke", {
					Color = library.theme.MainColor,
					Transparency = 0.5199999809265137,
					Parent = buttonbar,
				})

				utils.create("UIGradient", {
					Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, library.theme.Button.Main), ColorSequenceKeypoint.new(1.00, library.theme.Button.Deep)},
					Parent = UIStroke,
				})

				local button = utils.create("TextButton", {
					Name = "@interact",
					Parent = buttonbar,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(1, 0, 1, 0),
					AutoButtonColor = false,
					Font = Enum.Font.SourceSans,
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextSize = 14.000,
					TextTransparency = 1.000,
				})

				button.MouseButton1Click:Connect(function()
					utils.CircleAnim(button, Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,255))
					TextLabel.TextSize = 0
					utils.tween(TextLabel, { .2, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
						TextSize = 12,
					})
					local Success, Response = pcall(function()
						info.Callback()
					end)

					if not Success and AkaliNotif then
						AkaliNotif.Notify({
							Description = "Qwerty | "..(info.Title or "null").." Callback Error " ..tostring(Response);
							Title = "Qwerty | Callback Error";
							Duration = 5;
						});
					end
				end)
			end

			library.FuncMain.Slider = function(info)
				local callback = info.Callback or function() end
				local Max = info.Max
				local Min = info.Min
				local de = info.Default
				local dragging = false
				local SliderTable = {}

				local Slider = utils.create("TextButton", {
					Name = "@Slider",
					Parent = pageframe,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(0, 232, 0, 27),
					AutoButtonColor = false,
					TextTransparency = 1.000,
				})

				utils.create("TextLabel", {
					Parent = Slider,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.295258611, 0, 0.300000012, 0),
					Size = UDim2.new(0.530172408, 0, 0.370370358, 0),
					FontFace = Font.new("rbxassetid://12187374537", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
					Text = info.Title or "null",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12.000,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local Frame = utils.create("Frame", {
					Parent = Slider,
					BackgroundColor3 = Color3.fromRGB(48, 48, 48),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.0199998002, 0, 0.666666687, 0),
					Size = UDim2.new(0, 221, 0, 3),
				})

				local Frame_2 = utils.create("Frame", {
					Parent = Frame,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(0.0199999996, 0, 0, 3),
				})

				utils.create("UIGradient", {
					Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, library.theme.Almost.Main), ColorSequenceKeypoint.new(1.00, library.theme.Almost.Deep)},
					Rotation = 90,
					Parent = Frame_2,
				})

				local Frame_3 = utils.create("Frame", {
					Parent = Frame,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.0199999996, 0, 0.5, 0),
					Size = UDim2.new(0, 9, 0, 9),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 300),
					Parent = Frame_3,
				})

				local TextBox_2 = utils.create("TextBox", {
					Parent = Slider,
					Active = false,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.804982305, 0, 0.300000012, 0),
					Size = UDim2.new(0.319654554, 0, 0.555555582, 0),
					ClearTextOnFocus = false,
					FontFace = Font.new("rbxassetid://12187374537", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
					Text = "100",
					TextColor3 = Color3.fromRGB(102, 102, 102),
					TextSize = 12.000,
					TextXAlignment = Enum.TextXAlignment.Right,
				})

				local function setSliderValue(value)
					value = math.clamp(value, Min, Max)
					local relative = (value - Min) / (Max - Min)
					Frame_2:TweenSize(UDim2.new(relative, 0, 1, 0), "Out", "Sine", 0.2, true)
					local pos1 = UDim2.new(math.clamp(relative, 0.02, 0.98), 0, 0.5, 0)
					Frame_3:TweenPosition(pos1, "Out", "Sine", 0.2, true)
					TextBox_2.Text = tostring(value)
					local Success, Response = pcall(function()
						callback(value)
					end)

					if not Success and AkaliNotif then
						AkaliNotif.Notify({
							Description = "Qwerty | "..(info.Title or "null").." Callback Error " ..tostring(Response);
							Title = "Qwerty | Callback Error";
							Duration = 5;
						});
					end
				end

				setSliderValue(de)

				TextBox_2.FocusLost:Connect(function()
					local value = tonumber(TextBox_2.Text)
					if not value then
						TextBox_2.Text = tostring(de)
						setSliderValue(de)
					else
						setSliderValue(value)
						de = value
					end
				end)

				local function move(input)
					local relativeX = (input.Position.X - Frame.AbsolutePosition.X) / Frame.AbsoluteSize.X
					relativeX = math.clamp(relativeX, 0, 1)
					local value = math.floor((relativeX * (Max - Min)) + Min)
					setSliderValue(value)
				end

				Slider.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = true
						move(input)
					end
				end)

				Slider.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = false
					end
				end)

				UserInputService.InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						move(input)
					end
				end)

				function SliderTable.SetValue(value)
					setSliderValue(value)
				end			

				return SliderTable
			end

			library.FuncMain.Dropdown = function(info)
				local default = info.Default or ((info.Multi) and {} or "")
				local list = info.List
				if info.Multi and typeof(default) ~= "table" then
					warn("Default Must be Table")
					return
				elseif not info.Multi and typeof(default) == "table" then
					warn("Default Must be string or number")
					return
				end

				local Dropdown = utils.create("Frame", {
					Name = "@Dropdown",
					Parent = pageframe,
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Position = UDim2.new(0, 0, 0.147983715, 0),
					Size = UDim2.new(0, 232, 0, 23),
				})

				local dropdown_frame = utils.create("Frame", {
					Name = "dropdown_frame",
					Parent = Dropdown,
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Position = UDim2.new(0.0250000004, 0, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
				})

				local title = utils.create("TextLabel", {
					Name = "title",
					Parent = dropdown_frame,
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					Position = UDim2.new(0.0260259584, 0, 0, 0),
					Size = UDim2.new(0, 209, 0, 20),
					ZIndex = 2,
					FontFace = Font.new("rbxassetid://12187374537", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
					Text = (info.Title or "null"),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12.000,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local scrollbar_dropdown = utils.create("Frame", {
					Name = "scrollbar_dropdown",
					Parent = title,
					BackgroundColor3 = Color3.fromRGB(35, 35, 35),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Position = UDim2.new(-0.0267694388, 0, 1.10000002, 0),
					Size = UDim2.new(1.04999995, 0, 0, 0),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 4),
					Parent = scrollbar_dropdown,
				})

				local scrolling_dropdown = utils.create("ScrollingFrame", {
					Name = "scrolling_dropdown",
					Parent = scrollbar_dropdown,
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0, 121),
					ScrollBarThickness = 0,
				})

				local scrolling_dropdown_uilist = utils.create("UIListLayout", {
					Name = "scrolling_dropdown_uilist",
					Parent = scrolling_dropdown,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 5),
				})

				utils.create("UIPadding", {
					Name = "scrolling_dropdown_uipadding",
					Parent = scrolling_dropdown,
					PaddingLeft = UDim.new(0, 9),
					PaddingTop = UDim.new(0, 5),
				})

				local dropdown_button_2 = utils.create("TextButton", {
					Name = "dropdown_button",
					Parent = dropdown_frame,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Size = UDim2.new(0.949999988, 0, 0, 19),
					AutoButtonColor = false,
					Font = Enum.Font.SourceSans,
					Text = "",
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextSize = 14.000,
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 4),
					Parent = dropdown_button_2,
				})

				utils.create("UIGradient", {
					Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(54, 54, 54)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(15, 15, 15))},
					Rotation = 90,
					Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.54), NumberSequenceKeypoint.new(1.00, 0.00)},
					Parent = dropdown_button_2,
				})

				scrolling_dropdown_uilist:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					scrolling_dropdown.CanvasSize = UDim2.new(0, 0, 0, scrolling_dropdown_uilist.AbsoluteContentSize.Y + 35)
				end)

				local DropF = {}
				local DropG = true

				function DropF.Clear()
					title.Text = (info.Title or "null")
					if info.Multi then
						default = {}
					else
						default = nil
					end
					local Success, Response = pcall(function()
						info.Callback(default)
					end)

					if not Success and AkaliNotif then
						AkaliNotif.Notify({
							Description = "Qwerty | "..(info.Title or "null").." Callback Error " ..tostring(Response);
							Title = "Qwerty | Callback Error";
							Duration = 5;
						});
					end
					DropG = true
					utils.tween(Dropdown, { 0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
						Size = UDim2.new(0, 232,0, 23),
					})
					utils.tween(scrollbar_dropdown, { 0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
						Size = UDim2.new(1.05, 0,0, 0),
					})
					for i, v in next, scrolling_dropdown:GetChildren() do
						if v:IsA("TextButton") then 
							v:Destroy()
						end
					end
				end

				function DropF.Add(Text)
					if Text == "Searchxsnwz" then
						local Search = utils.create("Frame", {
							Name = "Search",
							Parent = scrolling_dropdown,
							BackgroundColor3 = Color3.fromRGB(19, 19, 19),
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Position = UDim2.new(0, 0, 0.270586133, 0),
							Size = UDim2.new(0.949999988, 0, 0, 19),
						})

						utils.create("UICorner", {
							CornerRadius = UDim.new(0.400000006, 0),
							Parent = Search,
						})

						local TextLabel_5 = utils.create("TextBox", {
							Name = "TextLabel",
							Parent = Search,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1.000,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Size = UDim2.new(1, 0, 1, 0),
							FontFace = Font.new("rbxassetid://12187374537", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
							PlaceholderText = "Search",
							Text = "",
							TextTransparency = 0.6,
							TextColor3 = Color3.fromRGB(247, 247, 247),
							TextSize = 14.000,
						})

						TextLabel_5.Changed:Connect(function()
							if TextLabel_5.Text ~= "" and TextLabel_5.Text ~= "Search" then
								for _, button in pairs(scrolling_dropdown:GetChildren()) do
									if button:IsA("TextButton") then
										if button.Text:lower():find(TextLabel_5.Text:lower()) then
											button.Visible = true
										else
											if button.Name ~= "Search" then
												button.Visible = false
											end
										end
									end
								end
							else
								for _, button in pairs(scrolling_dropdown:GetChildren()) do
									if button:IsA("TextButton") then
										button.Visible = true
									end
								end
							end
						end)
					else
						local TextButton = utils.create("TextButton", {
							Name = "dropdown_button",
							Parent = scrolling_dropdown,
							BackgroundTransparency = 1.000,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							ClipsDescendants = true,
							Size = UDim2.new(1, 0, 0, 19),
							AutoButtonColor = false,
							FontFace = Font.new("rbxassetid://12187374537", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
							Text = Text or "null",
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextSize = 14.000,
							TextTransparency = 0.650,
							TextXAlignment = Enum.TextXAlignment.Left,
						})

						local function UpdateTextLabel()
							local maxDisplayCount = 3
							local textLabel_7_text = (info.Title or "null") .. " / "
							if #default > maxDisplayCount then
								textLabel_7_text = textLabel_7_text .. table.concat(default, ", ", 1, maxDisplayCount) .. ", ..."
							else
								if #default < 1 then
									textLabel_7_text = (info.Title or "null")
								else
									textLabel_7_text = (info.Title or "null").." / ".. table.concat(default, ", ")
								end
							end
							textLabel_7_text = textLabel_7_text
							title.Text = textLabel_7_text
						end
						--if info.Multi then
						--	UpdateTextLabel()
						--end

						local function isValueInTable(val, tbl)
							if type(tbl) ~= "table" then
								return false
							end

							for _, v in pairs(tbl) do
								if v == val then
									return true
								end
							end
							return false
						end


						if info.Multi then
							if isValueInTable(Text, default) then
								local Success, Response = pcall(function()
									info.Callback(default, Text)
								end)

								if not Success and AkaliNotif then
									AkaliNotif.Notify({
										Description = "Qwerty | "..(info.Title or "null").." Callback Error " ..tostring(Response);
										Title = "Qwerty | Callback Error";
										Duration = 5;
									});
								end
								UpdateTextLabel()
								utils.tween(TextButton, { 0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
									TextTransparency = 0,
								})
							end
						else
							if TextButton.Text == default then
								for i, v in next, scrolling_dropdown:GetChildren() do
									if v:IsA("TextButton") then 
										utils.tween(v, { 0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
											TextTransparency = 0.65,
										})
									end
								end

								utils.tween(TextButton, { 0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
									TextTransparency = 0,
								})

								title.Text = (info.Title or "null") .. " / " .. default
								local Success, Response = pcall(function()
									info.Callback(default)
								end)

								if not Success and AkaliNotif then
									AkaliNotif.Notify({
										Description = "Qwerty | "..(info.Title or "null").." Callback Error " ..tostring(Response);
										Title = "Qwerty | Callback Error";
										Duration = 5;
									});
								end
							end
						end

						TextButton.MouseButton1Click:Connect(function()
							if info.Multi then
								if not table.find(default, Text) then
									table.insert(default, Text)
									local Success, Response = pcall(function()
										info.Callback(default, Text)
									end)

									if not Success and AkaliNotif then
										AkaliNotif.Notify({
											Description = "Qwerty | "..(info.Title or "null").." Callback Error " ..tostring(Response);
											Title = "Qwerty | Callback Error";
											Duration = 5;
										});
									end
									UpdateTextLabel()
									utils.tween(TextButton, { 0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
										TextTransparency = 0,
									})
								else
									utils.tween(TextButton, { 0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
										TextTransparency = 0.65,
									})
									for i2, v2 in ipairs(default) do
										if v2 == Text then
											table.remove(default, i2)
											local Success, Response = pcall(function()
												info.Callback(default, Text)
											end)

											if not Success and AkaliNotif then
												AkaliNotif.Notify({
													Description = "Qwerty | "..(info.Title or "null").." Callback Error " ..tostring(Response);
													Title = "Qwerty | Callback Error";
													Duration = 5;
												});
											end
											UpdateTextLabel()
											break
										end
									end
								end
							else
								for i, v in next, scrolling_dropdown:GetChildren() do
									if v:IsA("TextButton") then 
										utils.tween(v, { 0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
											TextTransparency = 0.65,
										})
									end
								end

								utils.tween(TextButton, { 0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
									TextTransparency = 0,
								})

								title.Text = (info.Title or "null").." / "..Text
								default = Text
								local Success, Response = pcall(function()
									info.Callback(Text)
								end)

								if not Success and AkaliNotif then
									AkaliNotif.Notify({
										Description = "Qwerty | "..(info.Title or "null").." Callback Error " ..tostring(Response);
										Title = "Qwerty | Callback Error";
										Duration = 5;
									});
								end
							end
						end)
					end
				end

				dropdown_button_2.MouseButton1Click:Connect(function()
					utils.CircleAnim(dropdown_button_2, Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,255))
					if not DropG then
						DropG = true
						utils.tween(Dropdown, { 0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
							Size = UDim2.new(0, 232,0, 23),
						})
						utils.tween(scrollbar_dropdown, { 0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
							Size = UDim2.new(1.05, 0,0, 0),
						})
					else
						DropG = false
						utils.tween(Dropdown, { 0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
							Size = UDim2.new(1, 0,0, 147),
						})
						utils.tween(scrollbar_dropdown, { 0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
							Size = UDim2.new(1.05, 0,0, 121),
						})
					end
				end)
				DropF.Add("Searchxsnwz")
				for _, v in next,list do
					DropF.Add(v)
				end
				return DropF
			end

			library.FuncMain.Label = function(info)
				local LabelTable = {}

				local Button = utils.create("Frame", {
					Name = "@TextLabel",
					Parent = pageframe,
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 0.147983715, 0),
					Size = UDim2.new(0, 232, 0, 27),
				})

				local textreal = utils.create("TextLabel", {
					Parent = Button,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0.925000012, 0, 1, 0),
					FontFace = Font.new("rbxassetid://12187374537", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
					Text = info.Title or "nill",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12.000,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				function LabelTable.SetValue()
					return textreal
				end

				return LabelTable
			end

			library.FuncMain.Toggle = function(info,Lock)
				local default = info.Default 
				local Lock = Lock or false
				local ToggleTable = {}

				local Toggle = utils.create("Frame", {
					Name = "@Toggle",
					Parent = pageframe,
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 0.147983715, 0),
					Size = UDim2.new(0, 232, 0, 27),
				})

				utils.create("TextLabel", {
					Parent = Toggle,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					Position = UDim2.new(0.415948272, 0, 0.5, 0),
					Size = UDim2.new(0.771551728, 0, 1, 0),
					FontFace = Font.new("rbxassetid://12187374537", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
					Text = info.Title,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12.000,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local Frame = utils.create("Frame", {
					Parent = Toggle,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.899999976, 0, 0.5, 0),
					Size = UDim2.new(0, 30, 0, 15),
				})

				local Frame_2 = utils.create("Frame", {
					Parent = Frame,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(74, 74, 74),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.300000012, 0, 0.5, 0),
					Size = UDim2.new(0, 9, 0, 9),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 3),
					Parent = Frame_2,
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 4),
					Parent = Frame,
				})

				utils.create("UIStroke", {
					Color = Color3.fromRGB(100, 100, 100),
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Transparency = 0.8999999761581421,
					Parent = Frame,
				})

				local UIGradient = utils.create("UIGradient", {
					Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, library.theme.Toggle.Main), ColorSequenceKeypoint.new(1.00, library.theme.Toggle.Deep)},
					Enabled = false,
					Rotation = 86,
					Parent = Frame,
				})

				local button = utils.create("TextButton", {
					Parent = Toggle,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(1, 0, 1, 0),
					AutoButtonColor = false,
					Font = Enum.Font.SourceSans,
					Text = "",
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextSize = 14.000,
				})


				local lockframe = utils.create("Frame", {
					Name = "lockframe",
					Parent = Toggle,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0, 232, 0, 27),
				})

				local lockimage_ = utils.create("ImageLabel", {
					Parent = lockframe,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					Position = UDim2.new(0.497485727, 0, 0.515432835, 0),
					Size = UDim2.new(0, 0, 0, 0),
					Image = "http://www.roblox.com/asset/?id=3926305904",
					ImageColor3 = Color3.fromRGB(255, 25, 25),
					ImageRectOffset = Vector2.new(404, 364),
					ImageRectSize = Vector2.new(36, 36),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 4),
					Parent = lockframe,
				})

				if Lock == true then
					utils.tween(lockframe, { .2, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
						BackgroundTransparency = 0.7,
					})
					utils.tween(lockimage_, { .2, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
						Size = UDim2.new(0, 19, 0, 19),
					})
				end

				if default == true then
					local Success, Response = pcall(function()
						info.Callback(default)
					end)

					if not Success and AkaliNotif then
						AkaliNotif.Notify({
							Description = "Qwerty | "..(info.Title or "null").." Callback Error " ..tostring(Response);
							Title = "Qwerty | Callback Error";
							Duration = 5;
						});
					end
					UIGradient.Enabled = true
					utils.tween(Frame_2, { .2, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
						Position = UDim2.new(0.74, 0, 0.5, 0),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					})
					utils.tween(Frame, { .2, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					})
				end
				button.MouseButton1Click:Connect(function()
					if not Lock then
						if not default then
							default = true
							UIGradient.Enabled = true
							utils.tween(Frame_2, { .2, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
								Position = UDim2.new(0.74, 0, 0.5, 0),
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							})
							utils.tween(Frame, { .2, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							})
						else
							default = false
							UIGradient.Enabled = false
							utils.tween(Frame_2, { .2, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
								Position = UDim2.new(0.300000012, 0, 0.5, 0),
								BackgroundColor3 = Color3.fromRGB(74, 74, 74),
							})
							utils.tween(Frame, { .2, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
								BackgroundColor3 = Color3.fromRGB(25, 25, 25),
							})
						end
						local Success, Response = pcall(function()
							info.Callback(default)
						end)
						
						if not Success and AkaliNotif then
							AkaliNotif.Notify({
								Description = "Qwerty | "..(info.Title or "null").." Callback Error " ..tostring(Response);
								Title = "Qwerty | Callback Error";
								Duration = 5;
							});
						end
					end
				end)

				function ToggleTable:UnLock()
					Lock = false
					utils.tween(lockframe, { .2, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
						BackgroundTransparency = 1,
					})
					utils.tween(lockimage_, { .2, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
						Size = UDim2.new(0, 0, 0, 0),
					})
				end
				function ToggleTable:Lock()
					Lock = true
					utils.tween(lockframe, { .2, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
						BackgroundTransparency = 0.7,
					})
					utils.tween(lockimage_, { .2, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
						Size = UDim2.new(0, 19, 0, 19),
					})
				end

				function ToggleTable.SetValue(setval)
					if setval then
						default = true
						UIGradient.Enabled = true
						utils.tween(Frame_2, { .2, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
							Position = UDim2.new(0.74, 0, 0.5, 0),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						})
						utils.tween(Frame, { .2, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						})
					else
						default = false
						UIGradient.Enabled = false
						utils.tween(Frame_2, { .2, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
							Position = UDim2.new(0.300000012, 0, 0.5, 0),
							BackgroundColor3 = Color3.fromRGB(74, 74, 74),
						})
						utils.tween(Frame, { .2, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
							BackgroundColor3 = Color3.fromRGB(25, 25, 25),
						})
					end
					local Success, Response = pcall(function()
						info.Callback(default)
					end)

					if not Success and AkaliNotif then
						AkaliNotif.Notify({
							Description = "Qwerty | "..(info.Title or "null").." Callback Error " ..tostring(Response);
							Title = "Qwerty | Callback Error";
							Duration = 5;
						});
					end
				end

				return ToggleTable
			end
			return library.FuncMain
		end
		return library.page
	end
	return library.tab
end
return library
