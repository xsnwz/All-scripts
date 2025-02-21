--< Functions >--
local utils = {}
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

if game:GetService("CoreGui"):FindFirstChild('SWP') then
	game:GetService("CoreGui"):FindFirstChild('SWP'):Destroy()
end

utils.win_create = function(args)
	local CoinCard = utils.create("ScreenGui", {
		Name = "SWP",
		Parent = game:GetService("CoreGui"),
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})
	
	local DropShadowHolder = utils.create("Frame", {
		Name = "DropShadowHolder",
		Parent = CoinCard,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.100000001, 0),
		Size = UDim2.new(0, 500, 0, 68),
		ZIndex = 0,
	})

	local DropShadow = utils.create("ImageLabel", {
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
		ImageTransparency = 0.500,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(49, 49, 450, 450),
	})

	local Main = utils.create("Frame", {
		Name = "Main",
		Parent = DropShadow,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.500,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, -47, 1, -47),
	})

	utils.create("UICorner", {
		CornerRadius = UDim.new(0, 5),
		Parent = Main,
	})

	local UIStroke_2 = utils.create("UIStroke", {
		Color = Color3.fromRGB(255, 255, 255),
		Parent = Main,
		Thickness = 2.5,
	})

	utils.create("UIGradient", {
		Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, Color3.fromRGB(219, 122, 18)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(191, 103, 10))
		},
		Parent = UIStroke_2,
	})

	local Top = utils.create("TextLabel", {
		Name = "Top",
		Parent = Main,
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0, 15),
		Size = UDim2.new(0, 500, 0, 18),
		Font = Enum.Font.GothamBold,
		Text = args["top"],
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 16.000,
		TextYAlignment = Enum.TextYAlignment.Bottom,
	})

	utils.create("UIGradient", {
		Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, Color3.fromRGB(219, 122, 18)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(191, 103, 10))
		},
		Parent = Top,
	})

	local Under = utils.create("TextLabel", {
		Name = "Under",
		Parent = Main,
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0, 35),
		Size = UDim2.new(0, 500, 0, 18),
		Font = Enum.Font.GothamBold,
		Text = args["btm"],
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 18.000,
		TextYAlignment = Enum.TextYAlignment.Bottom,
	})

	utils.create("UIGradient", {
		Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, Color3.fromRGB(219, 122, 18)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(191, 103, 10))
		},
		Parent = Under,
	})

	Top.Size = UDim2.new(0, Top.TextBounds.X, 0, 18)
	Under.Size = UDim2.new(0, Under.TextBounds.X, 0, 18)

	if Top.Size.X.Offset > Under.Size.X.Offset then
		DropShadowHolder.Size = UDim2.new(0, Top.TextBounds.X + 50, 0, 68)
	else
		DropShadowHolder.Size = UDim2.new(0, Under.TextBounds.X + 50, 0, 68)
	end

	Top:GetPropertyChangedSignal("Text"):Connect(function()
		Top.Size = UDim2.new(0, Top.TextBounds.X, 0, 18)
		if Top.Size.X.Offset > Under.Size.X.Offset then
			DropShadowHolder.Size = UDim2.new(0, Top.TextBounds.X + 50, 0, 68)
		else
			DropShadowHolder.Size = UDim2.new(0, Under.TextBounds.X + 50, 0, 68)
		end
	end)
	Under:GetPropertyChangedSignal("Text"):Connect(function()
		Under.Size = UDim2.new(0, Under.TextBounds.X, 0, 18)
		if Top.Size.X.Offset > Under.Size.X.Offset then
			DropShadowHolder.Size = UDim2.new(0, Top.TextBounds.X + 50, 0, 68)
		else
			DropShadowHolder.Size = UDim2.new(0, Under.TextBounds.X + 50, 0, 68)
		end
	end)
	
	local sub_function = {
		
	}
	
	sub_function.status_update = function(msg)
		if not msg or typeof(msg) ~= "string" then
			return
		end
		Under.Text = msg
	end
	
	return sub_function
end
