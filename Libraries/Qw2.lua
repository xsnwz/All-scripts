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

library.new = function(info)

	local work = utils.create("ScreenGui", {
		Name = HttpService:GenerateGUID(true):gsub("[{}]", ""),
		Parent = (gethui) and gethui() or ((RunService:IsStudio()) and PlayerGui or game:GetService("CoreGui")),
		DisplayOrder = 999,
	})

	local glow = utils.create("ImageLabel", {
		Name = "@glow",
		Parent = work,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Position = UDim2.new(0.257956862, 329, 0.542102039, -32),
		Size = UDim2.new(0, 677, 0, 429),
		Image = "http://www.roblox.com/asset/?id=11801116249",
		ImageColor3 = Color3.fromRGB(10, 10, 10),
		ImageTransparency = 0.810,
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
		Size = UDim2.new(0, 649, 0, 411),
	})

	utils.create("UIStroke", {
		Color = Color3.fromRGB(255, 255, 255),
		Thickness = 1.2000000476837158,
		Transparency = 0.949999988079071,
		Parent = mainscreen,
	})


	utils.create("UICorner", {
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
		ImageColor3 = Color3.fromRGB(212, 212, 212),
		ImageRectOffset = Vector2.new(50, -300),
		ImageRectSize = Vector2.new(500, 500),
		ImageTransparency = 0.850,
	})

	utils.create("UICorner", {
		CornerRadius = UDim.new(0, 10),
		Parent = s1,
	})

	utils.create("UIGradient", {
		Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(62, 65, 191)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(80, 92, 255))},
		Rotation = 90,
		Parent = s1,
	})

	local scrollbar = utils.create("Frame", {
		Name = "@scrollbar",
		Parent = mainscreen,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1.000,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0.0997981206, 0),
		Size = UDim2.new(0, 147, 0, 363),
	})

	local scrollingbar = utils.create("ScrollingFrame", {
		Name = "@scrollingbar",
		Parent = scrollbar,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		ClipsDescendants = false,
		Position = UDim2.new(0.487537473, 0, 0.506803393, 0),
		Size = UDim2.new(0.975074947, 0, 1.01039839, 0),
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollBarThickness = 0,
	})

	local UIListLayout_list = utils.create("UIListLayout", {
		Name = "@scrollingbar_list",
		Parent = scrollingbar,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 5),
	})

	UIListLayout_list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		scrollingbar.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_list.AbsoluteContentSize.Y + 35)
	end)

	utils.create("UIPadding", {
		Name = "@scrollingbar_padding",
		Parent = scrollingbar,
		PaddingLeft = UDim.new(0, 8),
		PaddingTop = UDim.new(0, 5),
	})

	local container = utils.create("Frame", {
		Name = "@container",
		Parent = mainscreen,
		ClipsDescendants = true,
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Position = UDim2.new(0.229228482, 0, 0.0997980833, 0),
		Size = UDim2.new(0, 500, 0, 369),
	})

	local UIPageLayout = utils.create("UIPageLayout", {
		Parent = container,
		SortOrder = Enum.SortOrder.LayoutOrder,
		FillDirection = Enum.FillDirection.Vertical,
		EasingStyle = Enum.EasingStyle.Exponential,
		Padding = UDim.new(0, 40),
		Circular = true,
		GamepadInputEnabled = false,
		ScrollWheelInputEnabled = false,
		TouchInputEnabled = false,
		TweenTime = 0.35,
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
		Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(62, 65, 191)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(80, 92, 255))},
		Rotation = 90,
		Name = "@xeo_gradient_title",
		Parent = xeo_title,
	})

	utils.create("TextLabel", {
		Name = "@game_name",
		Parent = mainscreen,
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Position = UDim2.new(0.132265061, 0, 0.0311111119, 0),
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

	utils.dragify(glow, mainscreen, 0.1)

	library.tab = {
		Value = false
	}
	local PageOrders = -1
	function library.tab.tab(info)
		PageOrders = PageOrders + 1

		local buttonbar = utils.create("Frame", {
			Name = "@buttonbar",
			Parent = scrollingbar,
			BackgroundColor3 = Color3.fromRGB(100, 100, 100),
			BackgroundTransparency = 0.400,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 0.0787100419, 0),
			Size = UDim2.new(0, 120, 0, 23),
		})

		utils.create("UICorner", {
			Parent = buttonbar,
		})

		local TextLabel = utils.create("TextLabel", {
			Parent = buttonbar,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1.000,
			BorderSizePixel = 0,
			Position = UDim2.new(0.622539699, 0, 0.5, 0),
			Size = UDim2.new(0.754920959, 0, 1, 0),
			FontFace = Font.new("rbxassetid://12187374537", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
			Text = info.Title or "Tab",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 12.000,
			TextTransparency = 0.600,
			TextXAlignment = Enum.TextXAlignment.Left,
		})

		local interact = utils.create("TextButton", {
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
			ZIndex = 10
		})

		utils.create("UIGradient", {
			Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(62, 65, 191)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(80, 92, 255))},
			Rotation = 90,
			Parent = buttonbar,
		})

		utils.create("ImageLabel", {
			Parent = buttonbar,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.new(0.129999995, 0, 0.5, 0),
			Size = UDim2.new(0, 15, 0, 15),
			Image = "rbxassetid://100616113524439",
		})

		local UIStroke = utils.create("UIStroke", {
			Color = Color3.fromRGB(255, 255, 255),
			Transparency = 0.6499999761581421,
			Parent = buttonbar,
		})

		utils.create("UIGradient", {
			Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(62, 65, 191)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(80, 92, 255))},
			Rotation = 90,
			Parent = UIStroke,
		})

		local section = utils.create("Frame", {
			Name = "@section",
			Parent = container,
			BackgroundTransparency = 1.000,
			BorderSizePixel = 0,
			Size = UDim2.new(0, 500, 0, 364),
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
			Size = UDim2.new(0, 240, 0, 362),
			CanvasSize = UDim2.new(0, 0, 0, 372),
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

		local right = utils.create("ScrollingFrame", {
			Name = "@right",
			Parent = section,
			BackgroundTransparency = 1.000,
			BorderSizePixel = 0,
			Position = UDim2.new(0.49494949, 0, 0, 0),
			Size = UDim2.new(0, 240, 0, 362),
			CanvasSize = UDim2.new(0, 0, 0, 254),
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

		left_list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			left.CanvasSize = UDim2.new(0, 0, 0, left_list.AbsoluteContentSize.Y + 26)
		end)

		interact.MouseButton1Click:Connect(function()
			for _, value in pairs(scrollingbar:GetChildren()) do
				if value:IsA("Frame") and string.find(value["Name"], "buttonbar") and value:FindFirstChild("UIGradient") and value:FindFirstChild("TextLabel") and value:FindFirstChild("UIStroke") then
					utils.tween(value.TextLabel, { 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
						TextTransparency = 0.600,
					})
					utils.tween(value, { 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
						Size = UDim2FromTable({0, 120},{0, 23}),
						BackgroundColor3 = Color3.fromRGB(100, 100, 100),
					})
				end
			end
			UIPageLayout:JumpToIndex(section.LayoutOrder)
			utils.tween(TextLabel, { 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
				TextTransparency = 0,
			})
			utils.tween(buttonbar, { 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
				Size = UDim2FromTable({0, 134},{0, 23}),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			})
		end)

		if not library.tab.Value then 
			library.tab.Value = true 
			UIPageLayout:JumpToIndex(section.LayoutOrder)
			utils.tween(TextLabel, { 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
				TextTransparency = 0,
			})
			utils.tween(buttonbar, { 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
				Size = UDim2FromTable({0, 134},{0, 23}),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			})
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
			library.FuncMain.Toggle = function(info, Lock)
				local default = info.Default 
				local Lock = Lock or false
				local ToggleTable = {}
				

				local Toggle = utils.create("Frame", {
					Name = "@Toggle",
					Parent = pageframe,
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 0.147983715, 0),
					Size = UDim2.new(0, 232, 0, 33),
				})

				utils.create("TextLabel", {
					Parent = Toggle,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					Position = UDim2.new(0.432759017, 0, 0.5, 0),
					Size = UDim2.new(0.805172443, 0, 1, 0),
					FontFace = Font.new("rbxassetid://12187374537", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
					Text = info.Title or "null",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12.000,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
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
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0, 232, 0, 33),
					ZIndex = 3,
				})

				local lockimage_ = utils.create("ImageLabel", {
					Parent = lockframe,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					Position = UDim2.new(0.497485727, 0, 0.515432835, 0),
					Image = "http://www.roblox.com/asset/?id=3926305904",
					ImageColor3 = Color3.fromRGB(255, 25, 25),
					ImageRectOffset = Vector2.new(404, 364),
					ImageRectSize = Vector2.new(36, 36),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 4),
					Parent = lockframe,
				})

				local Frame = utils.create("Frame", {
					Parent = Toggle,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(34, 34, 34),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.921551645, 0, 0.5, 0),
					Size = UDim2.new(0, 20, 0, 20),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 4),
					Parent = Frame,
				})

				local Frame_2 = utils.create("Frame", {
					Parent = Frame,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Transparency = 1,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0, 0, 0, 0),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 4),
					Parent = Frame_2,
				})

				utils.create("UIStroke", {
					Color = Color3.fromRGB(100, 100, 100),
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Transparency = 0.8999999761581421,
					Parent = Frame_2,
				})

				utils.create("UIGradient", {
					Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(62, 65, 191)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(80, 92, 255))},
					Rotation = 90,
					Parent = Frame_2,
				})

				local ticks = utils.create("ImageLabel", {
					Parent = Frame_2,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2FromTable({0, 0},{0, 0}),
					Position = UDim2FromTable({0.5, 0},{0.5, 0}),
					Image = "rbxassetid://81465033289454",
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
					utils.tween(Frame_2, { .2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
						Size = UDim2FromTable({0, 20},{0, 20}),
						Transparency = 0,
					})

					utils.tween(ticks, { .2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
						Size = UDim2FromTable({0, 20},{0, 20}),
						Position = UDim2FromTable({0, 0},{0, 0}),
					})
					
					local Success, Response = pcall(function()
						info.Callback(default)
					end)

					if not Success then
						warn((info.Title or "null").." Callback Error " ..tostring(Response))
					end
				end
				
				button.MouseButton1Click:Connect(function()
					if not Lock then
						if not default then
							default = true
							
							utils.tween(Frame_2, { .2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
								Size = UDim2FromTable({0, 20},{0, 20}),
								Transparency = 0,
							})
							
							utils.tween(ticks, { .2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
								Size = UDim2FromTable({0, 20},{0, 20}),
								Position = UDim2FromTable({0, 0},{0, 0}),
							})
						else
							default = false
							
							utils.tween(Frame_2, { .2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
								Size = UDim2FromTable({0, 0},{0, 0}),
								Transparency = 1,
							})
							
							utils.tween(ticks, { .2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
								Size = UDim2FromTable({0, 0},{0, 0}),
								Position = UDim2FromTable({0.5, 0},{0.5, 0}),
							})
						end
						local Success, Response = pcall(function()
							info.Callback(default)
						end)

						if not Success then
							warn((info.Title or "null").." Callback Error " ..tostring(Response))
						end
					end
				end)
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
					Position = UDim2.new(0, 0, 0.340350866, 0),
					Size = UDim2.new(1, 0, 0, 27),
				})

				local dropdown_frame = utils.create("Frame", {
					Name = "dropdown_frame",
					Parent = Dropdown,
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Position = UDim2.new(0.0249999482, 0, 0, 0),
					Size = UDim2.new(0.950000167, 0, 1, 0),
				})

				local fking_title = utils.create("TextLabel", {
					Name = "title",
					Parent = dropdown_frame,
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Position = UDim2.new(0, 8, 0, 1),
					Size = UDim2.new(0, 179, 0, 23),
					ZIndex = 2,
					FontFace = Font.new("rbxassetid://12187374537", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
					Text = info.Title or "null",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12.000,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local dropdown_button = utils.create("TextButton", {
					Name = "dropdown_button",
					Parent = dropdown_frame,
					BackgroundColor3 = Color3.fromRGB(35, 35, 35),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 0, 1),
					Size = UDim2.new(0, 220, 0, 23),
					AutoButtonColor = false,
					Font = Enum.Font.SourceSans,
					Text = "",
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextSize = 14.000,
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 7),
					Parent = dropdown_button,
				})

				utils.create("UIStroke", {
					Color = Color3.fromRGB(50, 50, 50),
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Transparency = 0.25,
					Parent = dropdown_button,
				})

				local scrollbar_dropdown = utils.create("Frame", {
					Name = "scrollbar_dropdown",
					Parent = dropdown_button,
					BackgroundColor3 = Color3.fromRGB(35, 35, 35),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Position = UDim2.new(0, 0, 1.20000005, 0),
					Size = UDim2.new(1, 0, 0, 0),
				})

				local scrolling_dropdown = utils.create("ScrollingFrame", {
					Name = "scrolling_dropdown",
					Parent = scrollbar_dropdown,
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0, 121),
					CanvasSize = UDim2.new(0, 0, 0, 198),
					ScrollBarThickness = 0,
				})

				local scrolling_dropdown_uilist = utils.create("UIListLayout", {
					Name = "scrolling_dropdown_uilist",
					Parent = scrolling_dropdown,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 5),
				})
				
				scrolling_dropdown_uilist:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					scrolling_dropdown.CanvasSize = UDim2.new(0, 0, 0, scrolling_dropdown_uilist.AbsoluteContentSize.Y + 35)
				end)

				utils.create("UIPadding", {
					Name = "scrolling_dropdown_uipadding",
					Parent = scrolling_dropdown,
					PaddingLeft = UDim.new(0, 9),
					PaddingTop = UDim.new(0, 5),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 7),
					Parent = scrollbar_dropdown,
				})

				local icon = utils.create("ImageLabel", {
					Name = "Icon",
					Parent = dropdown_frame,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Rotation = -90,
					Position = UDim2.new(0, 204, 0, 13),
					Size = UDim2.new(0, 17, 0, 17),
					SizeConstraint = Enum.SizeConstraint.RelativeYY,
					ZIndex = 7,
					Image = "rbxassetid://7733717447",
				})
				
				local DropF = {}
				local DropG = true
				
				function DropF.Clear()
					fking_title.Text = (info.Title or "null")
					
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
					
					DropG = true
					
					utils.tween(icon, { 0.3,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
						Rotation = -90,
						ImageColor3 = Color3.fromRGB(255, 255, 255),
					})
					utils.tween(Dropdown, { 0.3,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out }, {
						Size = UDim2FromTable({1, 0},{0, 25}),
					})
					utils.tween(scrollbar_dropdown, { 0.3,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out }, {
						Size = UDim2.new(1, 0,0, 0),
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

						local TextBox = utils.create("TextBox", {
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
							TextColor3 = Color3.fromRGB(247, 247, 247),
							TextSize = 14.000,
							TextTransparency = 0.600,
						})

						utils.create("UIStroke", {
							Color = Color3.fromRGB(50, 50, 50),
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
							Transparency = 0.25,
							Parent = Search,
						})

						TextBox.Changed:Connect(function()
							if TextBox.Text ~= "" and TextBox.Text ~= "Search" then
								for _, button in pairs(scrolling_dropdown:GetChildren()) do
									if button:IsA("TextButton") and button:FindFirstChild("title") then
										if button.title.Text:lower():find(TextBox.Text:lower()) then
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

						local dropdown_button = utils.create("TextButton", {
							Name = "dropdown_button",
							Parent = scrolling_dropdown,
							BackgroundTransparency = 1.000,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							ClipsDescendants = true,
							Position = UDim2.new(0, 0, 0.206896558, 0),
							Size = UDim2.new(0, 211, 0, 23),
							AutoButtonColor = false,
							FontFace = Font.new("rbxassetid://12187374537", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
							Text = "",
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextSize = 14.000,
							TextTransparency = 0.650,
							TextXAlignment = Enum.TextXAlignment.Left,
						})

						local Frame = utils.create("Frame", {
							Parent = dropdown_button,
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundColor3 = Color3.fromRGB(20, 20, 20),
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Position = UDim2.new(0.03377489, 0, 0.499999583, 0),
							Size = UDim2.new(0, 15, 0, 15),
						})

						utils.create("UICorner", {
							CornerRadius = UDim.new(0, 4),
							Parent = Frame,
						})

						local Frame_2 = utils.create("Frame", {
							Parent = Frame,
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Transparency = 1,
							Position = UDim2.new(0.5, 0, 0.5, 0),
							Size = UDim2.new(0, 0, 0, 0),
						})

						utils.create("UICorner", {
							CornerRadius = UDim.new(0, 4),
							Parent = Frame_2,
						})

						utils.create("UIStroke", {
							Color = Color3.fromRGB(100, 100, 100),
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
							Transparency = 0.8999999761581421,
							Parent = Frame_2,
						})

						utils.create("UIGradient", {
							Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(62, 65, 191)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(80, 92, 255))},
							Rotation = 90,
							Parent = Frame_2,
						})

						local ticks = utils.create("ImageLabel", {
							Parent = Frame_2,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1.000,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Size = UDim2.new(0, 0, 0, 0),
							Position = UDim2.new(0.5, 0, 0.5, 0),
							Image = "rbxassetid://81465033289454",
						})

						local da_title = utils.create("TextLabel", {
							Name = "title",
							Parent = dropdown_button,
							BackgroundTransparency = 1.000,
							BorderSizePixel = 0,
							ClipsDescendants = true,
							Position = UDim2.new(0.107059926, 0, 0, 0),
							Size = UDim2.new(0, 186, 0, 25),
							ZIndex = 2,
							FontFace = Font.new("rbxassetid://12187374537", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
							Text = Text,
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextSize = 12.000,
							TextTransparency = 0.500,
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
							fking_title.Text = textLabel_7_text
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

								if not Success then
									warn((info.Title or "null").." Callback Error " ..tostring(Response))
								end
								UpdateTextLabel()
								utils.tween(da_title, { 0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
									TextTransparency = 0,
								})
								
								utils.tween(Frame_2, { .2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
									Size = UDim2FromTable({0, 15},{0, 15}),
									Transparency = 0,
								})

								utils.tween(ticks, { .2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
									Size = UDim2FromTable({0, 15},{0, 15}),
									Position = UDim2FromTable({0, 0},{0, 0}),
								})
								
							end
						else
							if da_title.Text == default then
								for i, v in next, scrolling_dropdown:GetChildren() do
									if v:IsA("TextButton") and v:FindFirstChild("title") and v:FindFirstChild("Frame") and v.Frame:FindFirstChild("Frame") and v.Frame.Frame:FindFirstChild("ImageLabel") then 
										utils.tween(v.title, { 0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
											TextTransparency = 0.5,
										})

										utils.tween(v.Frame.Frame, { .2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
											Size = UDim2FromTable({0, 0},{0, 0}),
											Transparency = 0,
										})

										utils.tween(v.Frame.Frame.ImageLabel, { .2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
											Size = UDim2FromTable({0, 0},{0, 0}),
											Position = UDim2FromTable({0.5, 0},{0.5, 0}),
										})
									end
								end

								utils.tween(da_title, { 0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
									TextTransparency = 0,
								})
								
								utils.tween(Frame_2, { .2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
									Size = UDim2FromTable({0, 15},{0, 15}),
									Transparency = 0,
								})

								utils.tween(ticks, { .2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
									Size = UDim2FromTable({0, 15},{0, 15}),
									Position = UDim2FromTable({0, 0},{0, 0}),
								})

								fking_title.Text = (info.Title or "null") .. " / " .. default
								local Success, Response = pcall(function()
									info.Callback(default)
								end)

								if not Success then
									warn((info.Title or "null").." Callback Error " ..tostring(Response))
								end
							end
						end

						dropdown_button.MouseButton1Click:Connect(function()
							if info.Multi then
								if not table.find(default, Text) then
									table.insert(default, Text)
									local Success, Response = pcall(function()
										info.Callback(default, Text)
									end)

									if not Success then
										warn((info.Title or "null").." Callback Error " ..tostring(Response))
									end
									UpdateTextLabel()
									utils.tween(da_title, { 0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
										TextTransparency = 0,
									})
									
									utils.tween(Frame_2, { .2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
										Size = UDim2FromTable({0, 15},{0, 15}),
										Transparency = 0,
									})

									utils.tween(ticks, { .2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
										Size = UDim2FromTable({0, 15},{0, 15}),
										Position = UDim2FromTable({0, 0},{0, 0}),
									})
								else
									utils.tween(da_title, { 0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
										TextTransparency = 0.5,
									})
									
									utils.tween(Frame_2, { .2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
										Size = UDim2FromTable({0, 0},{0, 0}),
										Transparency = 0,
									})

									utils.tween(ticks, { .2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
										Size = UDim2FromTable({0, 0},{0, 0}),
										Position = UDim2FromTable({0.5, 0},{0.5, 0}),
									})
									
									for i2, v2 in ipairs(default) do
										if v2 == Text then
											table.remove(default, i2)
											local Success, Response = pcall(function()
												info.Callback(default, Text)
											end)

											if not Success then
												warn((info.Title or "null").." Callback Error " ..tostring(Response))
											end
											UpdateTextLabel()
											break
										end
									end
								end
							else
								for i, v in next, scrolling_dropdown:GetChildren() do
									if v:IsA("TextButton") and v:FindFirstChild("title") and v:FindFirstChild("Frame") and v.Frame:FindFirstChild("Frame") and v.Frame.Frame:FindFirstChild("ImageLabel") then 
										utils.tween(v.title, { 0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
											TextTransparency = 0.5,
										})
										
										utils.tween(v.Frame.Frame, { .2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
											Size = UDim2FromTable({0, 0},{0, 0}),
											Transparency = 0,
										})

										utils.tween(v.Frame.Frame.ImageLabel, { .2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
											Size = UDim2FromTable({0, 0},{0, 0}),
											Position = UDim2FromTable({0.5, 0},{0.5, 0}),
										})
									end
								end

								utils.tween(da_title, { 0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
									TextTransparency = 0,
								})
								
								utils.tween(Frame_2, { .2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
									Size = UDim2FromTable({0, 15},{0, 15}),
									Transparency = 0,
								})

								utils.tween(ticks, { .2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out }, {
									Size = UDim2FromTable({0, 15},{0, 15}),
									Position = UDim2FromTable({0, 0},{0, 0}),
								})

								fking_title.Text = (info.Title or "null").." / "..Text
								default = Text
								local Success, Response = pcall(function()
									info.Callback(Text)
								end)

								if not Success then
									warn((info.Title or "null").." Callback Error " ..tostring(Response))
								end
							end
						end)
					end
				end
				
				dropdown_button.MouseButton1Click:Connect(function()
					utils.CircleAnim(fking_title, Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,255))
					if not DropG then
						DropG = true
						utils.tween(icon, { 0.3,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
							Rotation = -90,
							ImageColor3 = Color3.fromRGB(255, 255, 255),
						})
						utils.tween(Dropdown, { 0.3,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out }, {
							Size = UDim2FromTable({1, 0},{0, 27}),
						})
						utils.tween(scrollbar_dropdown, { 0.3,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out }, {
							Size = UDim2.new(1, 0,0, 0),
						})
					else
						DropG = false
						utils.tween(icon, { 0.3,Enum.EasingStyle.Back,Enum.EasingDirection.Out }, {
							Rotation = 0,
							ImageColor3 = Color3.fromRGB(60, 207, 117),
						})
						utils.tween(Dropdown, { 0.3,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out }, {
							Size = UDim2.new(1, 0,0, 147),
						})
						utils.tween(scrollbar_dropdown, { 0.3,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out }, {
							Size = UDim2FromTable({1, 0},{121, 0}),
						})
					end
				end)
				
				DropF.Add("Searchxsnwz")
				for _, v in next,list do
					DropF.Add(v)
				end
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
					Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(80, 92, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(62, 65, 191))},
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

					if not Success then
						warn((info.Title or "null").." Callback Error " ..tostring(Response))
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
			library.FuncMain.Button = function(info)

				local Button = utils.create("Frame", {
					Name = "@Button",
					Parent = pageframe,
					BackgroundColor3 = Color3.fromRGB(8925, 8925, 8925),
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 0.147983715, 0),
					Size = UDim2FromTable({0, 232},{0, 24}),
				})

				local buttonbar = utils.create("Frame", {
					Name = "@buttonbar",
					Parent = Button,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(35, 35, 35),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Position = UDim2FromTable({0.5, 0},{0.44, 0}),
					Size = UDim2FromTable({0.95, 0},{0.035, 19}),
				})

				utils.create("UICorner", {
					CornerRadius = UDim.new(0, 7),
					Parent = buttonbar,
				})

				utils.create("UIStroke", {
					Color = Color3.fromRGB(50, 50, 50),
					Transparency = 0.20000000298023224,
					Parent = buttonbar,
				})

				local b_title = utils.create("TextLabel", {
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
					b_title.TextSize = 0
					utils.tween(b_title, { .2, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
						TextSize = 12,
					})
					local Success, Response = pcall(function()
						info.Callback()
					end)

					if not Success then
						warn((info.Title or "null").." Callback Error " ..tostring(Response))
					end
				end)
			end
			return library.FuncMain
		end
		return library.page
	end
	return library.tab
end

return library
