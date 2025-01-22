
getgenv().script_key = ""
getgenv().Theme = {
	LightBlue = {
		BackgroundColor = Color3.fromRGB(249, 249, 251),
		ShadowColor = Color3.fromRGB(30, 30, 30),
		ForegroundColor = Color3.fromRGB(77, 97, 122),
		TitleColor = Color3.fromRGB(42, 42, 42),
		StrokeColor = Color3.fromRGB(132, 143, 154),
		DescriptionColor = Color3.fromRGB(170, 178, 198),
		UnactiveColor = Color3.fromRGB(138, 149, 166),
		ActiveColor = Color3.fromRGB(0, 179, 255),
		MainColor = Color3.fromRGB(0, 179, 255),
		IconColor = Color3.fromRGB(107, 218, 255),
		UltilitiesIconColor = Color3.fromRGB(93, 93, 93),
		ConfirmButtonColor = Color3.fromRGB(107, 218, 255),
		SliderOuterColor = Color3.fromRGB(221, 227, 232),
		SliderInnerColor = Color3.fromRGB(0, 105, 254),
		SliderCircleShadow = Color3.fromRGB(0, 0, 0),
		ColorPickerDotStrokeColor = Color3.fromRGB(0, 0, 0),
		ColorPickerConfirmButtonColor = Color3.fromRGB(200, 200, 200),
		ScrollingFrameColor = Color3.fromRGB(0, 0, 0),
		BackgroundImage = nil,
		LoadingScreenImage = nil,
	},

	DarkBlue = {
		BackgroundColor = Color3.fromRGB(30, 30, 30),
		ShadowColor = Color3.fromRGB(30, 30, 30),
		ForegroundColor = Color3.fromRGB(255, 255, 255),
		TitleColor = Color3.fromRGB(255, 255, 255),
		StrokeColor = Color3.fromRGB(132, 143, 154),
		DescriptionColor = Color3.fromRGB(170, 178, 198),
		UnactiveColor = Color3.fromRGB(138, 149, 166),
		ActiveColor = Color3.fromRGB(0, 179, 255),
		MainColor = Color3.fromRGB(0, 179, 255),
		IconColor = Color3.fromRGB(107, 218, 255),
		UltilitiesIconColor = Color3.fromRGB(255, 255, 255),
		ConfirmButtonColor = Color3.fromRGB(107, 218, 255),
		SliderOuterColor = Color3.fromRGB(221, 227, 232),
		SliderInnerColor = Color3.fromRGB(0, 105, 254),
		SliderCircleShadow = Color3.fromRGB(0, 0, 0),
		ColorPickerDotStrokeColor = Color3.fromRGB(0, 0, 0),
		ColorPickerConfirmButtonColor = Color3.fromRGB(200, 200, 200),
		ScrollingFrameColor = Color3.fromRGB(0, 0, 0),
		BackgroundImage = nil,
		LoadingScreenImage = nil,
	},

	GreyDark = {
		BackgroundColor = Color3.fromRGB(0, 0, 0),
		ShadowColor = Color3.fromRGB(0, 0, 0),
		ForegroundColor = Color3.fromRGB(200, 200, 200),
		TitleColor = Color3.fromRGB(200, 200, 200),
		StrokeColor = Color3.fromRGB(10, 10, 10),
		DescriptionColor = Color3.fromRGB(200, 200, 200),
		UnactiveColor = Color3.fromRGB(10, 10, 10),
		ActiveColor = Color3.fromRGB(200, 200, 200),
		MainColor = Color3.fromRGB(200, 200, 200),
		IconColor = Color3.fromRGB(200, 200, 200),
		UltilitiesIconColor = Color3.fromRGB(200, 200, 200),
		ConfirmButtonColor = Color3.fromRGB(107, 218, 255),
		SliderOuterColor = Color3.fromRGB(10, 10, 10),
		SliderInnerColor = Color3.fromRGB(200, 200, 200),
		SliderCircleShadow = Color3.fromRGB(0, 0, 0),
		ColorPickerDotStrokeColor = Color3.fromRGB(0, 0, 0),
		ColorPickerConfirmButtonColor = Color3.fromRGB(200, 200, 200),
		ScrollingFrameColor = Color3.fromRGB(0, 0, 0),
		BackgroundImage = nil,
		LoadingScreenImage = nil,
	}
}

local library = 
	{
		toggles = {},
		config = {},
	}

-- library.theme = library.themes.WhiteBlue
library.theme = getgenv().Theme.DarkBlue

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

--[[
    
    ██╗    ██╗       █████╗ ███████╗██╗   ██╗██████╗ ███████╗
    ██║    ██║      ██╔══██╗╚══███╔╝██║   ██║██╔══██╗██╔════╝
    ██║ █╗ ██║█████╗███████║  ███╔╝ ██║   ██║██████╔╝█████╗  
    ██║███╗██║╚════╝██╔══██║ ███╔╝  ██║   ██║██╔══██╗██╔══╝  
    ╚███╔███╔╝      ██║  ██║███████╗╚██████╔╝██║  ██║███████╗
    ╚══╝╚══╝       ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝
]]

repeat task.wait() until game:IsLoaded()

local folder, cfg, assets, themes =
	"w-azure",
"config",
-- "logs",
-- "profiles",
"assets", 
"themes"

local keys = {
	[Enum.KeyCode.LeftShift] = "L-SHIFT",
	[Enum.KeyCode.RightShift] = "R-SHIFT",
	[Enum.KeyCode.LeftControl] = "L-CTRL",
	[Enum.KeyCode.RightControl] = "R-CTRL",
	[Enum.KeyCode.LeftAlt] = "L-ALT",
	[Enum.KeyCode.RightAlt] = "R-ALT",
	[Enum.KeyCode.CapsLock] = "CAPSLOCK",
	[Enum.KeyCode.One] = "1",
	[Enum.KeyCode.Two] = "2",
	[Enum.KeyCode.Three] = "3",
	[Enum.KeyCode.Four] = "4",
	[Enum.KeyCode.Five] = "5",
	[Enum.KeyCode.Six] = "6",
	[Enum.KeyCode.Seven] = "7",
	[Enum.KeyCode.Eight] = "8",
	[Enum.KeyCode.Nine] = "9",
	[Enum.KeyCode.Zero] = "0",
	[Enum.KeyCode.KeypadOne] = "NUM-1",
	[Enum.KeyCode.KeypadTwo] = "NUM-2",
	[Enum.KeyCode.KeypadThree] = "NUM-3",
	[Enum.KeyCode.KeypadFour] = "NUM-4",
	[Enum.KeyCode.KeypadFive] = "NUM-5",
	[Enum.KeyCode.KeypadSix] = "NUM-6",
	[Enum.KeyCode.KeypadSeven] = "NUM-7",
	[Enum.KeyCode.KeypadEight] = "NUM-8",
	[Enum.KeyCode.KeypadNine] = "NUM-9",
	[Enum.KeyCode.KeypadZero] = "NUM-0",
	[Enum.KeyCode.Minus] = "-",
	[Enum.KeyCode.Equals] = "=",
	[Enum.KeyCode.Tilde] = "~",
	[Enum.KeyCode.LeftBracket] = "[",
	[Enum.KeyCode.RightBracket] = "]",
	[Enum.KeyCode.RightParenthesis] = ")",
	[Enum.KeyCode.LeftParenthesis] = "(",
	[Enum.KeyCode.Semicolon] = ",",
	[Enum.KeyCode.Quote] = "'",
	[Enum.KeyCode.BackSlash] = "\\",
	[Enum.KeyCode.Comma] = ",",
	[Enum.KeyCode.Period] = ".",
	[Enum.KeyCode.Slash] = "/",
	[Enum.KeyCode.Asterisk] = "*",
	[Enum.KeyCode.Plus] = "+",
	[Enum.KeyCode.Period] = ".",
	[Enum.KeyCode.Backquote] = "`",
	[Enum.UserInputType.MouseButton1] = "MOUSE-1",
	[Enum.UserInputType.MouseButton2] = "MOUSE-2",
	[Enum.UserInputType.MouseButton3] = "MOUSE-3"
}

local Blacklisted = {
	Enum.KeyCode.W,
	Enum.KeyCode.A,
	Enum.KeyCode.S,
	Enum.KeyCode.D,
	Enum.KeyCode.Backquote,
	Enum.KeyCode.Escape,
	Enum.KeyCode.Tab, 
	Enum.KeyCode.Space
}

local request = 
	request or function(...)
		local args = ...;
		return game:HttpGet(args["Url"])
	end


local utils =
	{}

utils.generatePath = 
	function(...)
		local args = ...;
		local path = ""

		table.foreach(args, function(i, v)
			path = (path == "") and v or (path .. "/" .. v)
		end)

		return path
	end

utils.makePath = 
	function(...)
		local args = {...}
		local path = utils.generatePath(args)

		if not isfolder(path) then
			makefolder(path)
		end
	end

utils.writeFile = 
	function(path, content)
		if not isfile(path) then
			writefile(path, content)
		end
	end

utils.makePath(folder)
utils.makePath(folder, cfg)
utils.makePath(folder, assets)
utils.makePath(folder, themes)

if not isfile(utils.generatePath({folder, assets, "sample.mp4"})) then
	local sampleVideo = game:HttpGet("https://cdn.dribbble.com/users/1499967/screenshots/17530828/media/c06a1472498fca081bea338fb4062210.mp4")

	print(utils.generatePath({folder, assets, "sample.mp4"}))
	print(sampleVideo)

	utils.writeFile(utils.generatePath({folder, assets, "sample.mp4"}), sampleVideo)
end

utils.GetTextBounds= function(Text, Font, Size, Resolution)
	local Bounds = game:GetService("TextService"):GetTextSize(Text, Size, Font, Resolution or Vector2.new(1920, 1080))
	return { [1] = Bounds.X, [2] = Bounds.Y }
end

local Mouse = game.Players.LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")

utils.getXY = function(GuiObject)
	local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
	local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
	return Px/Max, Py/May
end

utils.formatNumber = function(number)
	if number >= 1000000000 then
		local formattedNumber = string.format("%.1fB", number / 1000000000)
		if math.floor(number % 1000000000) ~= 0 then
			formattedNumber = formattedNumber .. "+"
		else
			formattedNumber = string.format("%.0fB", number / 1000000000)
		end
		return formattedNumber
	elseif number >= 1000000 then
		local formattedNumber = string.format("%.1fM", number / 1000000)
		if math.floor(number % 1000000) ~= 0 then
			formattedNumber = formattedNumber .. "+"
		else
			formattedNumber = string.format("%.0fM", number / 1000000)
		end
		return formattedNumber
	elseif number >= 1000 then
		local formattedNumber = string.format("%.1fK", number / 1000)
		if math.floor(number % 1000) ~= 0 then
			formattedNumber = formattedNumber .. "+"
		else
			formattedNumber = string.format("%.0fK", number / 1000)
		end
		return formattedNumber
	else
		return tostring(number)
	end
end

utils.updatesize = 
	function(uil, obj)
		local cS = uil.AbsoluteContentSize
		game.TweenService:Create(obj, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
			CanvasSize = UDim2.new(0, cS.X, 0, cS.Y + 50)
		}):Play()
	end

utils.updatesizeX =
	function(uil, obj)
		local cS = uil.AbsoluteContentSize

		game.TweenService:Create(obj, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
			CanvasSize = UDim2.new(0, cS.X, 0, cS.Y)
		}):Play()
	end

utils.scrollXtoFrame =
	function(scrollingFrame, targetObject)
		local objectPosition = targetObject.Position.X.Offset
		local frameWidth = scrollingFrame.AbsoluteSize.X
		local contentWidth = scrollingFrame.CanvasSize.X.Offset

		local newCanvasPosition = math.clamp(objectPosition - frameWidth / 2, 0, math.max(0, contentWidth - frameWidth))

		game.TweenService:Create(scrollingFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			CanvasPosition = Vector2.new(newCanvasPosition, scrollingFrame.CanvasPosition.Y)
		}):Play()
	end

utils.random = 
	function(_length)
		local characters = "abcdefghijklmnopqrstuvwxyz1234567890"
		characters = string.split(characters, "")

		local randomString = ""

		for i = 1, _length do
			local randomIndex = math.random(1, #characters)

			if not tonumber(characters[randomIndex]) then
				local uppercase = math.random(1, 2) == 2 and true or false
				randomString = randomString .. (uppercase and characters[randomIndex]:upper() or characters[randomIndex])
			else
				randomString = randomString .. characters[randomIndex]
			end
		end

		return randomString
	end

utils.create = 
	function(class, prop)
		local obj = Instance.new(class)

		for prop, v in next, prop do
			obj[prop] = v
		end

		pcall(function()
			obj.AutoButtonColor = false
		end)

		obj.Name = utils.random(16)

		return obj
	end

utils.smoothscrolling = 
	loadstring(game:HttpGet("https://raw.githubusercontent.com/nameless-users/All-scripts/refs/heads/main/Modules/SmoothScroll.lua", true))()

local TweenStyle = Enum.EasingStyle.Sine
local TweenDirection = Enum.EasingDirection.InOut
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

if not game:GetService("CoreGui"):FindFirstChild("NotificationLibrary") then
	local notificationLibrary = Instance.new("ScreenGui")
	notificationLibrary.Name = "NotificationLibrary"
	notificationLibrary.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	notificationLibrary.Parent = game:GetService("CoreGui")

	local notificationHolder = Instance.new("Frame")
	notificationHolder.Name = "NotificationHolder"
	notificationHolder.AnchorPoint = Vector2.new(0, 0.5)
	notificationHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	notificationHolder.BackgroundTransparency = 1
	notificationHolder.Position = UDim2.fromScale(0, 0.5)
	notificationHolder.Size = UDim2.fromScale(0.8, 1)
	notificationHolder.Parent = notificationLibrary

	local notificationUIListLayout = Instance.new("UIListLayout")
	notificationUIListLayout.Name = "NotificationUIListLayout"
	notificationUIListLayout.FillDirection = Enum.FillDirection.Vertical
	notificationUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	notificationUIListLayout.Padding = UDim.new(0, 4)
	notificationUIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	notificationUIListLayout.Parent = notificationHolder

	local notificationUIPadding = Instance.new("UIPadding")
	notificationUIPadding.Name = "NotificationUIPadding"
	notificationUIPadding.PaddingBottom = UDim.new(0, 10)
	notificationUIPadding.PaddingLeft = UDim.new(0, 10)
	notificationUIPadding.Parent = notificationHolder
end

local NotificationLib = game:GetService("CoreGui"):FindFirstChild("NotificationLibrary")
local Holder = NotificationLib:FindFirstChild("NotificationHolder")

library.notify = 
	function(...)
		local Text, Duration = unpack({ ... })
		Duration = Duration or 5

		local Color = library.theme.MainColor
		local ImageColor = library.theme.IconColor
		local TextColor = library.theme.TitleColor
		local DescriptionColor = library.theme.DescriptionColor

		local NotificationFrame = utils.create("Frame", {
			Parent = Holder,
			BackgroundColor3 = Color3.fromRGB(252, 252, 253),
			ClipsDescendants = true,
			Size = UDim2.new(0, 0, 0, 60),
			BackgroundTransparency = 1,
		})

		utils.create("UICorner", {
			Parent = NotificationFrame,
			CornerRadius = UDim.new(0, 4),
		})

		local OuterFrame = utils.create("Frame", {
			Parent = NotificationFrame,
			AnchorPoint = Vector2.new(0, 1),
			BackgroundColor3 = Color,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 1, 0),
			Size = UDim2.new(1, 0, 0, 3),
			ZIndex = 2,
			BackgroundTransparency = 1,
		})

		local NotificationIcon = utils.create("ImageLabel", {
			Parent = NotificationFrame,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0, 8, 0, 5),
			Size = UDim2.new(0, 25, 0, 25),
			Image = "http://www.roblox.com/asset/?id=13286125855",
			ImageColor3 = ImageColor,
			ImageTransparency = 1,
		})

		local NotificationTitle = utils.create("TextLabel", {
			Parent = NotificationFrame,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0, 40, 0, 8),
			Size = UDim2.new(0, 200, 0, 20),
			Font = Enum.Font.Gotham,
			Text = "W-azure",
			TextColor3 = TextColor,
			TextSize = 14.000,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTransparency = 1,
		})

		local NotificationText = utils.create("TextLabel", {
			Parent = NotificationFrame,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0, 10, 0.5, 0),
			Size = UDim2.new(0, 200, 0, 20),
			Font = Enum.Font.GothamBold,
			Text = Text,
			TextColor3 = DescriptionColor,
			TextSize = 14.000,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTransparency = 1,
		})

		local NotifText = NotificationText
		local TextBounds = NotifText.TextBounds

		coroutine.wrap(function()
			local InTween = TweenService:Create(
				NotificationFrame,
				TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
				{ Size = UDim2.new(0, TextBounds.X + 50, 0, 60) }
			)
			InTween:Play()

			spawn(function()
				task.wait(0.1)
				TweenService:Create(
					NotificationFrame,
					TweenInfo.new(0, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
					{ BackgroundTransparency = 0 }
				):Play()
				TweenService:Create(
					OuterFrame,
					TweenInfo.new(0, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
					{ BackgroundTransparency = 0 }
				):Play()
				TweenService:Create(
					NotificationText,
					TweenInfo.new(0, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
					{ TextTransparency = 0 }
				):Play()
				TweenService:Create(
					NotificationTitle,
					TweenInfo.new(0, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
					{ TextTransparency = 0 }
				):Play()
				TweenService:Create(
					NotificationIcon,
					TweenInfo.new(0, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
					{ ImageTransparency = 0 }
				):Play()
			end)

			InTween.Completed:Wait()

			local LineTween = TweenService:Create(
				OuterFrame,
				TweenInfo.new(Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
				{ Size = UDim2.new(0, 0, 0, 3) }
			)
			LineTween:Play()
			LineTween.Completed:Wait()

			local OutTween = TweenService:Create(
				NotificationFrame,
				TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
				{ Size = UDim2.new(0, 0, 0, 60) }
			)
			OutTween:Play()

			spawn(function()
				task.wait(0.175)
				TweenService:Create(
					NotificationFrame,
					TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
					{ BackgroundTransparency = 1 }
				):Play()
				TweenService:Create(
					OuterFrame,
					TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
					{ BackgroundTransparency = 1 }
				):Play()
				TweenService:Create(
					NotificationText,
					TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
					{ TextTransparency = 1 }
				):Play()
				TweenService:Create(
					NotificationTitle,
					TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
					{ TextTransparency = 1 }
				):Play()
				TweenService:Create(
					NotificationIcon,
					TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
					{ ImageTransparency = 1 }
				):Play()
			end)

			OutTween.Completed:Wait()
			NotificationFrame:Destroy()
		end)()
	end

utils.loadasset = function(url)
	local function getAsset()
		local getasset = getcustomasset or getsynasset or nil
		if getasset == nil then
			error("getcustomasset function is missing!")
		end
		return getasset
	end

	if isfile(url) then
		local getasset = getAsset()

		local fakeImageID
		local succ, err = pcall(function()
			fakeImageID = getasset(url)
		end)

		if succ then
			return fakeImageID, 0
		else
			return false, err
		end
	end

	local image, imageName, filePath
	local succ, err = pcall(function()
		image = game:HttpGet(url)
		imageName = string.match(url, "([^/]+)$")
		filePath = folder .. "/" .. assets .. "/" .. imageName
		writefile(filePath, image)
	end)

	if not succ then
		return false, err
	end

	local fakeImageID
	succ, err = pcall(function()
		fakeImageID = getAsset()(filePath)
	end)

	if succ then
		return fakeImageID, 0
	else
		return false, err
	end
end    

utils.tween = 
	function(obj, info, properties, callback)
		local anim = game:GetService("TweenService"):Create(obj, TweenInfo.new(unpack(info)), properties)
		anim:Play()

		if callback then
			anim.Completed:Connect(callback)
		end

		return anim
	end

utils.dragify = function(object, hoverobj, speed, additionalObject)
	local start, objectPosition, dragging

	speed = speed or 0

	hoverobj.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			start = input.Position
			objectPosition = object.Position
		end
	end)

	hoverobj.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
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

utils.keyTabAnimate = function(old, new)
	if new then
		new.GroupTransparency = 1
		new.Position = UDim2.new(-1, 0, new.Position.Y.Scale, new.Position.Y.Offset)
	end

	local oldpos = UDim2.new(0.284999996, 0, 0.479000002, 0)

	if old then
		oldpos = old.Position
		utils.tween(old, {0.35, TweenStyle, TweenDirection}, {
			GroupTransparency = 1,
			Position = UDim2.new(1, 0, old.Position.Y.Scale, old.Position.Y.Offset)
		})
	end

	task.wait(0.1)

	if new then
		utils.tween(new, {0.35, TweenStyle, TweenDirection}, {
			GroupTransparency = 0,
			Position = oldpos
		})
	end
end


utils._break = function()
	return "break"
end

if shared._wazure ~= nil then
	return library.notify("Please close the current UI or restart the game!")
end

if library.theme.LoadingScreenImage then
	local ImageID, err = utils.loadasset(library.theme.LoadingScreenImage)
	if ImageID then
		library.theme.LoadingScreenImage = ImageID
	end
end

if library.theme.BackgroundImage then
	local ImageID, err = utils.loadasset(library.theme.BackgroundImage)
	if ImageID then
		library.theme.BackgroundImage = ImageID
	end
end

local ScreenGui = utils.create('ScreenGui', {
	Parent = game.CoreGui,
	IgnoreGuiInset = true,
	ResetOnSpawn = false,
	DisplayOrder = 100,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})

shared._wazure = ScreenGui

local LoaderSucced = false

library.createLoader = 
	function(...)
		if (typeof(...) ~= "table") then
			return
		end

		local states = ...;

		local LoadingScreen = utils.create('CanvasGroup', {
			Name = "LoadingScreen",
			Parent = ScreenGui,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = library.theme.BackgroundColor or Color3.fromRGB(249, 249, 251),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(0, 400, 0, 300),
			ZIndex = 2,
			GroupTransparency = 1
		})

		local LoadingScreenImage = utils.create('ImageLabel', {
			Parent = LoadingScreen,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			ClipsDescendants = true,
			Size = UDim2.new(1, 0, 1, 0),
			ZIndex = 0,
			Image = library.theme.LoadingScreenImage,
			ScaleType = Enum.ScaleType.Crop,
		})

		local LoadingScreenShadow = utils.create('ImageLabel', {
			Parent = ScreenGui,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0.50545156, 0, 0.498888582, 0),
			Size = UDim2.new(0, 486, 0, 391),
			Image = "rbxassetid://8992584561",
			ImageColor3 = library.theme.ShadowColor or Color3.fromRGB(21, 38, 59),
			ImageTransparency = 1,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(73, 73, 73, 73),
			SliceScale = 0.980,
		})

		utils.create('UICorner', {
			CornerRadius = UDim.new(0, 12),
			Parent = LoadingScreen,
		})

		local CloseButton = utils.create('ImageButton', {
			Parent = LoadingScreen,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0.949999988, 0, 0.0500000007, 0),
			Size = UDim2.new(0, 15, 0, 15),
			ZIndex = 3,
			Image = "rbxassetid://11293981586",
			ImageColor3 = Color3.fromRGB(0, 0, 0),
		})

		local LoadingUltilities = utils.create('CanvasGroup', {
			Parent = LoadingScreen,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Size = UDim2.new(1, 0, 1, 0),
			GroupTransparency = 0
		})

		local Logo = utils.create('ImageLabel', {
			Parent = LoadingUltilities,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0.5, 0, 0.5, -10),
			Size = UDim2.new(0, 50, 0, 50),
			ZIndex = 2,
			Image = "http://www.roblox.com/asset/?id=13286125855",
			ImageColor3 = library.theme.IconColor,
		})

		local LoadingBar = utils.create('Frame', {
			Parent = LoadingUltilities,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			Position = UDim2.new(0.5, 0, 0.899999976, 0),
			Size = UDim2.new(0.899999976, 0, 0, 15),
			ZIndex = 2,
		})

		utils.create('UICorner', {
			CornerRadius = UDim.new(0, 12),
			Parent = LoadingBar,
		})

		utils.create('UIStroke', {
			Color = library.theme.StrokeColor,
			Parent = LoadingBar,
		})

		local LoadingBarInner = utils.create('Frame', {
			Parent = LoadingBar,
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = library.theme.MainColor,
			Position = UDim2.new(0, 2, 0.519999981, 0),
			Size = UDim2.new(0, 20, 0.899999976, 0),
			ZIndex = 2
		})

		utils.create('UICorner', {
			CornerRadius = UDim.new(0, 12),
			Parent = LoadingBarInner,
		})

		local StateText = utils.create('TextLabel', {
			Parent = LoadingUltilities,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0.5, 0, 0.839999974, 0),
			Size = UDim2.new(0.889999986, 0, 0, 20),
			ZIndex = 2,
			Font = Enum.Font.Gotham,
			Text = "Checking",
			TextColor3 = library.theme.ForegroundColor,
			TextSize = 12.000,
			TextXAlignment = Enum.TextXAlignment.Left,
		})

		utils.create('UICorner', {
			CornerRadius = UDim.new(0, 12),
			Parent = LoadingScreenImage,
		})

		if (LoadingScreenImage.Image == nil) then
			LoadingScreenImage.Visible = false
		end

		local KeyUltilities = utils.create('CanvasGroup', {
			Name = "KeyUltilities",
			Parent = LoadingScreen,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Size = UDim2.new(1, 0, 1, 0),
			GroupTransparency = 1
		})

		utils.create('ImageLabel', {
			Name = "Logo",
			Parent = KeyUltilities,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0, 12, 0, 10),
			Size = UDim2.new(0, 25, 0, 25),
			ZIndex = 2,
			Image = "http://www.roblox.com/asset/?id=13286125855",
			ImageColor3 = library.theme.IconColor,
		})

		utils.create('TextLabel', {
			Parent = KeyUltilities,
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0, 20, 0.200000003, 0),
			Size = UDim2.new(0, 200, 0, 20),
			ZIndex = 2,
			Font = Enum.Font.Gotham,
			Text = "Key Authentication",
			TextColor3 = library.theme.ForegroundColor,
			TextSize = 19.000,
			TextXAlignment = Enum.TextXAlignment.Left,
		})

		utils.create('TextLabel', {
			Parent = KeyUltilities,
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0, 20, 0.300000012, 0),
			Size = UDim2.new(0, 360, 0, 20),
			ZIndex = 2,
			Font = Enum.Font.Gotham,
			Text = "It seems like you forgot to define a key",
			TextColor3 = library.theme.ForegroundColor,
			TextSize = 15.000,
			TextXAlignment = Enum.TextXAlignment.Left,
		})

		utils.create('TextLabel', {
			Parent = KeyUltilities,
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0, 20, 0.416666657, 0),
			Size = UDim2.new(0, 360, 0, 30),
			ZIndex = 2,
			Font = Enum.Font.Gotham,
			Text = "After this time, please get the script from the bot in our Discord server",
			TextColor3 = library.theme.ForegroundColor,
			TextSize = 15.000,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			-- // Generated by natsu.ps1#4977's plugin
		})

		utils.create('TextLabel', {
			Parent = KeyUltilities,
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0, 20, 0.600000024, 0),
			Size = UDim2.new(0, 360, 0, 20),
			ZIndex = 2,
			Font = Enum.Font.Gotham,
			Text = "Please enter your valid key here:",
			TextColor3 = library.theme.ForegroundColor,
			TextSize = 15.000,
			TextXAlignment = Enum.TextXAlignment.Left,
		})

		local FeildFrame = utils.create('Frame', {
			Name = "FeildFrame",
			Parent = KeyUltilities,
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			Position = UDim2.new(0, 18, 0.703333318, 0),
			Size = UDim2.new(0, 289, 0, 30),
			ZIndex = 2,
		})

		utils.create('UICorner', {
			Parent = FeildFrame,
		})

		utils.create('UIStroke', {
			Color = library.theme.StrokeColor,
			Thickness = 0.800,
			Parent = FeildFrame,
		})

		local KeyTextBox = utils.create('TextBox', {
			Parent = FeildFrame,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			ClipsDescendants = true,
			Position = UDim2.new(0.0484429076, 0, 0, 0),
			Size = UDim2.new(0.916954994, 0, 1, 0),
			ClearTextOnFocus = false,
			Font = Enum.Font.Gotham,
			PlaceholderColor3 = Color3.fromRGB(157, 157, 157),
			PlaceholderText = "Your key goes here.",
			Text = "",
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 14.000,
			TextXAlignment = Enum.TextXAlignment.Left,
		})

		local ConfirmButton = utils.create('TextButton', {
			Name = "ConfirmButton",
			Parent = KeyUltilities,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0.920000017, 0, 0.899999976, 0),
			Size = UDim2.new(0, 40, 0, 40),
			ZIndex = 2,
			Font = Enum.Font.SourceSans,
			Text = "",
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 14.000,
		})

		local InnerConfirmButton = utils.create('Frame', {
			Name = "InnerConfirmButton",
			Parent = ConfirmButton,
			BackgroundColor3 = library.theme.BackgroundColor,
			Position = UDim2.new(0.25, 0, 0.25, 0),
			Size = UDim2.new(0.75, 0, 0.75, 0),
			ZIndex = 2,
		})

		utils.create('UICorner', {
			Parent = InnerConfirmButton,
		})

		utils.create('UIStroke', {
			Color = Color3.fromRGB(255, 255, 255),
			Thickness = 0.800,
			Parent = InnerConfirmButton,
		})

		local NextIcon = utils.create('ImageLabel', {
			Parent = InnerConfirmButton,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(0.5, 0, 0.5, 0),
			ZIndex = 2,
			Image = "rbxassetid://11419703997",
		})

		local FailedKeyUltilities = utils.create('CanvasGroup', {
			Name = "FailedUltilities",
			Parent = LoadingScreen,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Size = UDim2.new(1, 0, 1, 0), 
			GroupTransparency = 1
		})

		utils.create('TextLabel', {
			Parent = FailedKeyUltilities,
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0, 20, 0.200000003, 0),
			Size = UDim2.new(0, 200, 0, 20),
			ZIndex = 2,
			Font = Enum.Font.Gotham,
			Text = "Key Authentication",
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 19.000,
			TextXAlignment = Enum.TextXAlignment.Left,
		})

		utils.create('TextLabel', {
			Parent = FailedKeyUltilities,
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0, 20, 0.300000012, 0),
			Size = UDim2.new(0, 360, 0, 20),
			ZIndex = 2,
			Font = Enum.Font.Gotham,
			Text = "It seems like you got a invaild key",
			TextColor3 = Color3.fromRGB(68, 68, 68),
			TextSize = 15.000,
			TextXAlignment = Enum.TextXAlignment.Left,
		})

		utils.create('TextLabel', {
			Parent = FailedKeyUltilities,
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0, 20, 0.416666657, 0),
			Size = UDim2.new(0, 360, 0, 30),
			ZIndex = 2,
			Font = Enum.Font.Gotham,
			Text = "Please check the key again or dm Helpers, Mods, Owner",
			TextColor3 = Color3.fromRGB(68, 68, 68),
			TextSize = 15.000,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
		})

		local sec = utils.create('TextLabel', {
			Parent = FailedKeyUltilities,
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0, 20, 0.600000024, 0),
			Size = UDim2.new(0, 360, 0, 20),
			ZIndex = 2,
			Font = Enum.Font.Gotham,
			Text = "You will be kicked on 5 seconds.",
			TextColor3 = Color3.fromRGB(68, 68, 68),
			TextSize = 15.000,
			TextXAlignment = Enum.TextXAlignment.Left,
		})

		utils.create('ImageLabel', {
			Name = "Logo",
			Parent = FailedKeyUltilities,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0, 12, 0, 10),
			Size = UDim2.new(0, 25, 0, 25),
			ZIndex = 2,
			Image = "http://www.roblox.com/asset/?id=13286125855",
			ImageColor3 = library.theme.IconColor,
		})

		local Authorization = nil
		local Index = nil

		task.spawn(function()
			while true do
				wait(0.25)

				if #KeyTextBox.Text >= 1 then
					utils.tween(InnerConfirmButton, {0.12, TweenStyle, TweenDirection}, {
						BackgroundColor3 = library.theme.ConfirmButtonColor
					})
				else
					utils.tween(InnerConfirmButton, {0.12, TweenStyle, TweenDirection}, {
						BackgroundColor3 = library.theme.BackgroundColor
					})
				end
			end
		end)

		local isAuthorizationCompleted = false

		local function executeCallback(callback, isAuthorization, isSuccess)
			if not callback then return end

			if isAuthorization then
				if not getgenv().script_key or getgenv().script_key == "" then
					task.wait(4)
					utils.keyTabAnimate(LoadingUltilities, KeyUltilities)
					isAuthorizationCompleted = false
					return utils._break()
				end

				local success = callback(getgenv().script_key)
				if not success then
					task.wait(4)
					utils.keyTabAnimate(LoadingUltilities, FailedKeyUltilities)
					isAuthorizationCompleted = false

					task.spawn(function()
						local second = tick()
						while task.wait(1) do
							if tick() - second >= 5 then
								game:Shutdown()
							end
						end
					end)

					return utils._break()
				end

				isAuthorizationCompleted = true
			else
				local success, err = pcall(callback)
				if not success then
					-- Handle the error if needed
				else
					utils.tween(LoadingScreen, {0.12, TweenStyle, TweenDirection}, {
						GroupTransparency = 1
					})

					utils.tween(LoadingScreenShadow, {0.12, TweenStyle, TweenDirection}, {
						ImageTransparency = 1
					})
				end
			end
		end        

		local function processState(state)
			local completedPercentage = state.CompletedPercentage
			local isAuthorization = state.IsAuthorization
			local isSuccess = state.IsSuccess
			local name = state.Name
			local callback = state.Callback

			if completedPercentage then
				completedPercentage = completedPercentage == 100 and 99 or completedPercentage
				TweenService:Create(
					LoadingBarInner,
					TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
					{ Size = UDim2.new(completedPercentage / 100, 0, 0.899999976, 0) }
				):Play()
			end

			if isAuthorization then
				Authorization = state
			end

			if name then
				StateText.Text = name
			end

			executeCallback(callback, isAuthorization, isSuccess)

			task.wait(1)
		end

		ConfirmButton.MouseButton1Down:Connect(function()
			local keyText = KeyTextBox.Text
			if #keyText >= 1 then
				getgenv().script_key = keyText
				utils.keyTabAnimate(KeyUltilities, LoadingUltilities)

				for _, state in pairs(states) do
					if not isAuthorizationCompleted and state.IsAuthorization then
						processState(state)
					elseif isAuthorizationCompleted and state ~= Authorization then
						processState(state)
					end
				end
			end
		end)

		task.spawn(function()
			for _, state in pairs(states) do
				if state.IsAuthorization then
					if not getgenv().script_key or getgenv().script_key == "" then
						isAuthorizationCompleted = false
					else
						isAuthorizationCompleted = true
						processState(state)
					end
				end
			end
		end)


		local closeButton = CloseButton

		closeButton.MouseEnter:Connect(function()
			utils.tween(closeButton, {0.25, TweenStyle, TweenDirection}, {ImageTransparency = 0.2})
		end)

		closeButton.MouseLeave:Connect(function()
			utils.tween(closeButton, {0.25, TweenStyle, TweenDirection}, {ImageTransparency = 0})
		end)

		closeButton.MouseButton1Down:Connect(function()
			task.wait(0.25)
			utils.tween(closeButton, {0.25, TweenStyle, TweenDirection}, {ImageTransparency = 0})

			task.wait(2)
			local t = utils.tween(LoadingScreen, {0.25, TweenStyle, TweenDirection}, {GroupTransparency = 1})
			t.Completed:Connect(function()
				ScreenGui:Destroy()
				shared._wazure = nil
			end)
		end)

		utils.tween(LoadingScreen, {0.35, Enum.EasingStyle.Sine, TweenDirection}, {GroupTransparency = 0})
		utils.tween(LoadingScreenShadow, {0.35, Enum.EasingStyle.Sine, TweenDirection}, {ImageTransparency = 0.5})
	end

library.createWindow = 
	function(skipLoader)
		-- title = title or "W-Azure"

		if not shared._wazure then
			return library.notify("Please close the current UI or restart the game!")
		end

		if not LoaderSucced and not skipLoader then
			game:Shutdown()
		end

		local WindowFunctions = {}

		local MainScreen = utils.create('CanvasGroup', {
			Name = "MainScreen",
			Parent = ScreenGui,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(0, 650, 0, 400),
			ZIndex = 2,
			GroupTransparency = 1
		})

		local MainScreenShadow = utils.create('ImageLabel', {
			Name = "MainScreenShadow",
			Parent = ScreenGui,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0.500619709, 0, 0.504444122, 0),
			Size = UDim2.new(0, 757, 0, 526),
			Visible = true,
			ZIndex = 0,
			Image = "rbxassetid://8992584561",
			ImageColor3 = library.theme.ShadowColor,
			ImageTransparency = 1,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(73, 73, 73, 73),
			SliceScale = 0.980,
		})

		local MainFrame = utils.create('Frame', {
			Name = "MainFrame",
			Parent = MainScreen,
			BackgroundColor3 = library.theme.BackgroundColor,
			Size = UDim2.new(1, 0, 1, 0),
		})

		local MainFrameImage = utils.create('ImageLabel', {
			Parent = MainFrame,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			ClipsDescendants = true,
			Size = UDim2.new(1, 0, 1, 0),
			ZIndex = 0,
			Image = library.theme.BackgroundImage,
			ScaleType = Enum.ScaleType.Crop,
		})

		utils.create('UICorner', {
			CornerRadius = UDim.new(0, 10),
			Parent = MainFrame,
		})

		utils.create('UICorner', {
			CornerRadius = UDim.new(0, 10),
			Parent = MainFrameImage,
		})

		utils.create('TextLabel', {
			Parent = MainFrame,
			AnchorPoint = Vector2.new(1, 1),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.new(0.981538475, 0, 0.991249979, 0),
			Size = UDim2.new(0, 188, 0, 46),
			Font = Enum.Font.Gotham,
			Text = "Acean Hub",
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 12.000,
			TextTransparency = 0.800,
			TextXAlignment = Enum.TextXAlignment.Right,
			TextYAlignment = Enum.TextYAlignment.Bottom,
		})

		local NavigatorFrame = utils.create('Frame', {
			Name = "NavigatorFrame",
			Parent = MainFrame,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Size = UDim2.new(1, 0, 0, 50),
			ZIndex = 5,
		})

		local LogoFrame = utils.create('Frame', {
			Name = "LogoFrame",
			Parent = NavigatorFrame,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Size = UDim2.new(0.0461538471, 30, 1, 0),
		})

		local Logo = utils.create('ImageLabel', {
			Name = "Logo",
			Parent = LogoFrame,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0, 15, 0, 10),
			Size = UDim2.new(0, 30, 0, 30),
			Image = "http://www.roblox.com/asset/?id=13286125855",
			ImageColor3 = library.theme.IconColor,
		})

		local AvatarFrame = utils.create('Frame', {
			Name = "AvatarFrame",
			Parent = NavigatorFrame,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0.877384663, 0, 0, 0),
			Size = UDim2.new(0.0784615353, 30, 1, 0),
		})
		local ProfileAvatar = utils.create('Frame', {
			Name = "ProfileAvatar",
			Parent = AvatarFrame,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0.699999988, -4, 0.5, 0),
			Size = UDim2.new(0, 30, 0, 30),
			ZIndex = 2,
		})

		local AvatarImage = utils.create('ImageLabel', {
			Parent = ProfileAvatar,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			ClipsDescendants = true,
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(1, 0, 1, 0),
			ZIndex = 2,
			Image = "http://www.roblox.com/asset/?id=12163350994",
			ScaleType = Enum.ScaleType.Crop,
		})

		local ProfileAvatarShadow = utils.create('ImageLabel', {
			Name = "ProfileAvatarShadow",
			Parent = AvatarFrame,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0.699999988, -4, 0.50999999, 0),
			Size = UDim2.new(0, 65, 0, 65),
			Image = "rbxassetid://8992584561",
			ImageColor3 = library.theme.ShadowColor,
			ImageTransparency = 0.500,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(146, 146, 146, 146),
			SliceScale = 10.000,
		})

		local SettingsIcon = utils.create('ImageButton', {
			Parent = AvatarFrame,
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			Position = UDim2.new(0, 0, 0.5, 0),
			Size = UDim2.new(0, 20, 0, 20),
			Image = "http://www.roblox.com/asset/?id=6031280882",
			ImageColor3 = Color3.fromRGB(21, 38, 59),
			ImageTransparency = 1
		})

		local TabFrame = utils.create('ScrollingFrame', {
			Name = "TabFrame",
			Parent = NavigatorFrame,
			Active = true,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderSizePixel = 0,
			Position = UDim2.new(0.0923076943, 0, 0, 0),
			Size = UDim2.new(0.631230831, 100, 1, 0),
			CanvasSize = UDim2.new(0, 0, 0, 0),
			HorizontalScrollBarInset = Enum.ScrollBarInset.Always,
			ScrollBarThickness = 0,
			VerticalScrollBarInset = Enum.ScrollBarInset.Always,
			ScrollingDirection = Enum.ScrollingDirection.X,
			-- AutomaticCanvasSize = Enum.AutomaticSize.X,
		})

		-- utils.smoothscrolling.Enable(TabFrame)

		local TabFrameUIL = utils.create('UIListLayout', {
			Parent = TabFrame,
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 5),
		})

		utils.create('UIPadding', {
			Parent = TabFrame,
			PaddingRight = UDim.new(0.180000007, 0),
			PaddingTop = UDim.new(0, 10),
		})

		TabFrame.ChildAdded:Connect(function()
			utils.updatesizeX(TabFrameUIL, TabFrame)
		end)

		TabFrame.ChildRemoved:Connect(function()
			utils.updatesizeX(TabFrameUIL, TabFrame)
		end)

		local ContentFrame = utils.create('Frame', {
			Name = "ContentFrame",
			Parent = MainFrame,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			ClipsDescendants = true,
			Position = UDim2.new(0, 0, 0.125, 0),
			Size = UDim2.new(1, 0, 0, 350),
		})

		utils.create('UICorner', {
			CornerRadius = UDim.new(0, 3192),
			Parent = AvatarImage,
		})

		utils.create('UICorner', {
			CornerRadius = UDim.new(0, 3192),
			Parent = ProfileAvatar,
		})

		local content, ready = game:GetService("Players"):GetUserThumbnailAsync(game.Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
		if ready then
			AvatarImage.Image = content
		end

		local Tabs = {}

		WindowFunctions.createTab = function(tabName, defaultTab)
			local TabFunctions = {
				Enabled = defaultTab,
				AdditionalTab = nil
			}

			table.insert(Tabs, TabFunctions)

			local Tab = utils.create('Frame', {
				Parent = TabFrame,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1.000,
				Position = UDim2.new(0.447922885, 0, 0, 0),
				Size = UDim2.new(0, 0, 0, 34),
			}) 

			local TabName = utils.create('TextButton', {
				Parent = Tab,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1.000,
				Size = UDim2.new(1, 0, 1, 0),
				Font = Enum.Font.Gotham,
				TextColor3 = library.theme.UnactiveColor,
				TextSize = 14.000,
				Text = tabName
			})

			local TabStroke = utils.create('UIStroke', {
				Color = library.theme.ActiveColor,
				Transparency = 1.000,
				Parent = Tab,
			})

			local TabCanvasGroup = utils.create('CanvasGroup', {
				Parent = ContentFrame,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(255, 0, 0),
				BackgroundTransparency = 1.000,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.new(0.284999996, 0, 0.479000002, 0),
				Size = UDim2.new(0.55400002, -10, 0.957000017, -5),
				GroupTransparency = 1
			})

			TabFunctions["TabInstance"] = TabCanvasGroup

			local TabContent = utils.create('ScrollingFrame', {
				Name = "TabContent",
				Parent = TabCanvasGroup,
				Active = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1.000,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 1, 0),
				ScrollBarThickness = 0,
				ScrollBarImageColor3 = library.theme.ForegroundColor
			})

			-- utils.smoothscrolling.Enable(TabContent, 30, 0.01)

			local TabContentUIL = utils.create('UIListLayout', {
				Parent = TabContent,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 8),
			})

			task.spawn(function()
				while task.wait() do
					utils.updatesize(TabContentUIL, TabContent)
				end
			end)

			utils.create('UIPadding', {
				Parent = TabContent,
				PaddingLeft = UDim.new(0, 10),
				PaddingTop = UDim.new(0, 2),
			})

			utils.create('UICorner', {
				CornerRadius = UDim.new(0, 4),
				Parent = Tab,
			})

			local TextSize = utils.GetTextBounds(tabName, Enum.Font.Gotham, 14)
			Tab.Size = UDim2.new(0, TextSize[1] + 20, 0, 34)

			TabFunctions.Enable = function()
				for i, v in pairs(Tabs) do
					if v.Disable and v.Enabled and v ~= TabFunctions then
						v.Disable()
					end
				end

				TabCanvasGroup.Visible = true
				utils.keyTabAnimate(nil, TabCanvasGroup)

				spawn(function()
					repeat wait() until TabFunctions.additionalTab
					TabFunctions.additionalTab.Visible = true
					utils.tween(TabFunctions.additionalTab, {0.35, TweenStyle, TweenDirection}, {
						GroupTransparency = 0,
						Position = UDim2.new(0.776, -5, 0.479000002, 0)
					})
				end)

				utils.tween(TabStroke, {0.12, Enum.EasingStyle.Sine, TweenDirection}, {Transparency = 0})
				utils.tween(TabName, {0.12, Enum.EasingStyle.Sine, TweenDirection}, {TextColor3 = library.theme.ActiveColor})

				TabFunctions.Enabled = true

				-- utils.scrollXtoFrame(TabFrame, Tab)
			end

			TabFunctions.Disable = function()
				local a = utils.tween(TabCanvasGroup, {0.35, TweenStyle, TweenDirection}, {
					GroupTransparency = 1,
					Position = UDim2.new(1, 0, 0.479000002, 0)
				})

				a.Completed:Connect(function()
					TabCanvasGroup.Visible = false
				end)

				if TabFunctions.additionalTab then
					local b = utils.tween(TabFunctions.additionalTab, {0.35, TweenStyle, TweenDirection}, {
						GroupTransparency = 1,
						Position = UDim2.new(1, 0, 0.479000002, 0)
					})

					b.Completed:Connect(function()
						TabFunctions.additionalTab.Visible = false
					end)
				end

				utils.tween(TabStroke, {0.12, Enum.EasingStyle.Sine, TweenDirection}, {Transparency = 1})
				utils.tween(TabName, {0.12, Enum.EasingStyle.Sine, TweenDirection}, {TextColor3 = library.theme.UnactiveColor})

				TabFunctions.Enabled = false
			end

			if defaultTab then
				-- TabFunctions.Disable()
				TabFunctions.Enable()
			else
				TabFunctions.Disable()
			end

			TabName.MouseButton1Down:Connect(function()
				if not TabFunctions.Enabled and not getgenv().TabDelay then
					-- print(tabName)
					TabFunctions.Enable()

					task.spawn(function()
						getgenv().TabDelay = true
						task.wait(0.2)
						getgenv().TabDelay = false
					end)
				end
			end)

			TabFunctions.createTabHeader = function(Title, Description)
				Title = Title or tabName

				local TabHeaderFunctions = {}

				local TabHeader = utils.create('Frame', {
					Name = "TabHeader",
					Parent = TabContent,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					LayoutOrder = -1,
					AutomaticSize = Enum.AutomaticSize.Y,
					Position = UDim2.new(0.0285510346, 0, 0.00579710165, 0),
					Size = UDim2.new(0, 325, 0, 45),
				})

				utils.create('UIListLayout', {
					Parent = TabHeader,
					SortOrder = Enum.SortOrder.LayoutOrder,
				})

				local _Title = utils.create('TextLabel', {
					Name = "Title",
					Parent = TabHeader,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.0158730168, 0, 0.00579710165, 0),
					Size = UDim2.new(0, 200, 0, 25),
					Font = Enum.Font.FredokaOne,
					Text = Title,
					TextColor3 = library.theme.TitleColor,
					TextSize = 28.000,
					AutomaticSize = Enum.AutomaticSize.Y,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
				})

				local _Description = utils.create('TextLabel', {
					Name = "Description",
					Parent = TabHeader,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.0158730168, 0, 0.0782608688, 0),
					Size = UDim2FromTable({0.769, 0},{0, 0}),
					Font = Enum.Font.FredokaOne,
					Text = Description or "\"Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...\"",
					TextColor3 = library.theme.DescriptionColor,
					TextSize = 16.000,
					TextWrapped = true,
					AutomaticSize = Enum.AutomaticSize.Y,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
				})

				TabHeaderFunctions.updateTitle = function(newTitle)
					_Title.Text = newTitle
				end

				TabHeaderFunctions.updateDescription = function(newDesc)
					_Description.Text = newDesc
				end

				return TabHeaderFunctions
			end

			TabFunctions.createLabel = function(name, icon)
				local Button = utils.create('Frame', {
					Parent = TabContent,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.0285714287, 0, 0.181081086, 0),
					Size = UDim2.new(0, 330, 0, 40),
				})

				utils.create('ImageLabel', {
					Parent = Button,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0, 2, 0.5, 0),
					Size = UDim2.new(0, 25, 0, 25),
					Image = icon or "rbxassetid://12974446859",
					ImageColor3 = library.theme.UltilitiesIconColor,
					-- // Generated by natsu.ps1#4977's plugin
				})

				local Title = utils.create('TextLabel', {
					Parent = Button,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					Position = UDim2.new(0, 40, 0, 0),
					Size = UDim2.new(0, 100, 1, 0),
					Font = Enum.Font.Gotham,
					Text = name or "Button",
					TextColor3 = library.theme.TitleColor,
					TextSize = 14.000,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				utils.create('UIPadding', {
					Parent = Button,
					PaddingLeft = UDim.new(0, 10),
				})

				utils.create('UICorner', {
					Parent = Button,
				})

				utils.create('UIStroke', {
					Color = library.theme.StrokeColor,
					Thickness = 0.800,
					Parent = Button,
				})

				local LabelFunctions = {}

				LabelFunctions.Update = function(prop)
					for prop, v in next, prop do
						Title[prop] = v
					end
				end

				return LabelFunctions
			end

			TabFunctions.createButton = function(name, icon, callback)
				callback = callback or function()
					return true
				end

				local Button = utils.create('Frame', {
					Parent = TabContent,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.0285714287, 0, 0.181081086, 0),
					Size = UDim2.new(0, 330, 0, 40),
				})

				local InvisibleButton = utils.create('TextButton', {
					Parent = Button,
					BackgroundTransparency = 1,
					TextTransparency = 1,
					Size = UDim2.fromScale(1, 1)
				})

				utils.create('ImageLabel', {
					Parent = Button,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0, 2, 0.5, 0),
					Size = UDim2.new(0, 25, 0, 25),
					Image = icon or "rbxassetid://12974446859",
					ImageColor3 = library.theme.UltilitiesIconColor,
					-- // Generated by natsu.ps1#4977's plugin
				})

				utils.create('TextLabel', {
					Parent = Button,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					Position = UDim2.new(0, 40, 0, 0),
					Size = UDim2.new(0, 100, 1, 0),
					Font = Enum.Font.Gotham,
					Text = name or "Button",
					TextColor3 = library.theme.TitleColor,
					TextSize = 14.000,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				utils.create('UIPadding', {
					Parent = Button,
					PaddingLeft = UDim.new(0, 10),
				})

				utils.create('UICorner', {
					Parent = Button,
				})

				utils.create('UIStroke', {
					Color = library.theme.StrokeColor,
					Thickness = 0.800,
					Parent = Button,
				})

				local ButtonIcon = utils.create('ImageButton', {
					Parent = Button,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(252, 250, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.930000007, 0, 0.5, 0),
					Size = UDim2.new(0, 18, 0, 18),
					Image = "rbxassetid://12974400739",
					ImageColor3 = Color3.fromRGB(0, 105, 254),
					-- // Generated by natsu.ps1#4977's plugin
				})

				ButtonIcon.MouseEnter:Connect(function()
					utils.tween(ButtonIcon, {0.2, Enum.EasingStyle.Sine, TweenDirection}, {ImageTransparency = 0.3})
				end)

				ButtonIcon.MouseLeave:Connect(function()
					utils.tween(ButtonIcon, {0.2, Enum.EasingStyle.Sine, TweenDirection}, {ImageTransparency = 0})
				end)

				InvisibleButton.MouseEnter:Connect(function()
					utils.tween(ButtonIcon, {0.2, Enum.EasingStyle.Sine, TweenDirection}, {ImageTransparency = 0.3})
				end)

				InvisibleButton.MouseLeave:Connect(function()
					utils.tween(ButtonIcon, {0.2, Enum.EasingStyle.Sine, TweenDirection}, {ImageTransparency = 0})
				end)

				ButtonIcon.MouseButton1Down:Connect(function()
					task.spawn(function()
						task.wait(0.1)
						utils.tween(ButtonIcon, {0.2, Enum.EasingStyle.Sine, TweenDirection}, {ImageTransparency = 0.5})
						task.wait(0.2)
						utils.tween(ButtonIcon, {0.2, Enum.EasingStyle.Sine, TweenDirection}, {ImageTransparency = 0})
					end)

					pcall(callback)
				end)

				InvisibleButton.MouseButton1Down:Connect(function()
					task.spawn(function()
						task.wait(0.1)
						utils.tween(ButtonIcon, {0.2, Enum.EasingStyle.Sine, TweenDirection}, {ImageTransparency = 0.5})
						task.wait(0.2)
						utils.tween(ButtonIcon, {0.2, Enum.EasingStyle.Sine, TweenDirection}, {ImageTransparency = 0})
					end)

					pcall(callback)
				end)
			end

			TabFunctions.createToggle = function(name, icon, default, callback)
				callback = callback or function()
					return true    
				end

				local ToggleFunctions = {
					Enabled = default or false
				}

				local Toggle = utils.create('Frame', {
					Name = "Toggle",
					Parent = TabContent,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.0285714287, 0, 0.181081086, 0),
					Size = UDim2.new(0, 330, 0, 40),
					ZIndex = 10
				})

				local InvisibleButton = utils.create('TextButton', {
					Parent = Toggle,
					BackgroundTransparency = 1,
					TextTransparency = 1,
					Size = UDim2.fromScale(1, 1)
				})

				utils.create('UIStroke', {
					Color = library.theme.StrokeColor,
					Thickness = 0.800,
					Parent = Toggle,
				})

				utils.create('UICorner', {
					Parent = Toggle,
				})

				utils.create('ImageLabel', {
					Parent = Toggle,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0, 2, 0.5, 0),
					Size = UDim2.new(0, 25, 0, 25),
					Image = icon or "rbxassetid://12974446859",
					ImageColor3 = library.theme.UltilitiesIconColor,
				})

				utils.create('TextLabel', {
					Parent = Toggle,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					Position = UDim2.new(0, 40, 0, 0),
					Size = UDim2.new(0, 100, 1, 0),
					Font = Enum.Font.Gotham,
					Text = name or "Toggle",
					TextColor3 = library.theme.TitleColor,
					TextSize = 14.000,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				utils.create('UIPadding', {
					Parent = Toggle,
					PaddingLeft = UDim.new(0, 10),
				})

				local ToggleFrame = utils.create('Frame', {
					Name = "Toggle",
					Parent = Toggle,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = library.theme.UnactiveColor,
					Position = UDim2.new(0.906060576, 0, 0.5, 0),
					Size = UDim2.new(0, 43, 0, 26),
					ZIndex = 10
				})

				utils.create('UICorner', {
					CornerRadius = UDim.new(0, 3192),
					Parent = ToggleFrame,
				})

				local ToggleInner = utils.create('TextButton', {
					AutoButtonColor = false,
					Name = "ToggleInner",
					Parent = ToggleFrame,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = library.theme.BackgroundColor,
					Position = UDim2.new(0.300000012, 0, 0.5, 0),
					Size = UDim2.new(0, 22, 0, 22),
					Text = "",
					ZIndex = 0
				})

				local ToggleButton = utils.create("TextButton", {
					BackgroundTransparency = 1,
					Parent = ToggleFrame,
					Text = "",
					Size = UDim2.fromScale(1, 1)
				})

				utils.create('UICorner', {
					CornerRadius = UDim.new(0, 20),
					Parent = ToggleInner,
				})

				if default then
					ToggleFunctions.Enabled = true
					pcall(callback, ToggleFunctions.Enabled)

					utils.tween(ToggleFrame, {.16, Enum.EasingStyle.Quad, TweenDirection}, {BackgroundColor3 = library.theme.ActiveColor})
					utils.tween(ToggleInner, {.16, Enum.EasingStyle.Quad, TweenDirection}, {Position = UDim2.new(0.7, 0, 0.5, 0)})
				end

				ToggleFunctions.Enable = function()
					ToggleFunctions.Enabled = true
					pcall(callback, ToggleFunctions.Enabled)

					utils.tween(ToggleFrame, {.16, Enum.EasingStyle.Quad, TweenDirection}, {BackgroundColor3 = library.theme.ActiveColor})
					utils.tween(ToggleInner, {.16, Enum.EasingStyle.Quad, TweenDirection}, {Position = UDim2.new(0.7, 0, 0.5, 0)})
				end

				ToggleFunctions.Disable = function()
					ToggleFunctions.Enabled = false
					pcall(callback, ToggleFunctions.Enabled)

					utils.tween(ToggleFrame, {.16, Enum.EasingStyle.Quad, TweenDirection}, {BackgroundColor3 = library.theme.UnactiveColor})
					utils.tween(ToggleInner, {.16, Enum.EasingStyle.Quad, TweenDirection}, {Position = UDim2.new(0.3, 0, 0.5, 0)})
				end

				ToggleButton.MouseButton1Down:Connect(function()
					-- print(ToggleFunctions.Enabled)
					if ToggleFunctions.Enabled == true then
						-- print(name, "dis")
						ToggleFunctions.Disable()
					else
						-- print(name, "ena")
						ToggleFunctions.Enable()
					end
				end)

				InvisibleButton.MouseButton1Down:Connect(function()
					-- print(ToggleFunctions.Enabled)
					if ToggleFunctions.Enabled == true then
						-- print(name, "dis")
						ToggleFunctions.Disable()
					else
						-- print(name, "ena")
						ToggleFunctions.Enable()
					end
				end)

				Toggle.InputBegan:Connect(function(a)
					if a.UserInputType == Enum.UserInputType then
						-- print(ToggleFunctions.Enabled)
						if ToggleFunctions.Enabled == true then
							-- print(name, "dis")
							ToggleFunctions.Disable()
						else
							-- print(name, "ena")
							ToggleFunctions.Enable()
						end
					end
				end)

				return ToggleFunctions
			end

			TabFunctions.createSlider = function(name, icon, min, max, default, callback)
				min = min or 0
				max = max or 10

				if default > max or default < min then
					default = min
				end

				callback = callback or function()

				end

				local SliderFunctions = {

				}

				local Slider = utils.create('Frame', {
					Name = "Slider",
					Parent = TabContent,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.0285510346, 0, 0.524637699, 0),
					Size = UDim2.new(0, 330, 0, 65),
				})

				utils.create('ImageLabel', {
					Parent = Slider,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0, 2, 0, 20),
					Size = UDim2.new(0, 25, 0, 25),
					Image = icon or "rbxassetid://12974446859",
					ImageColor3 = library.theme.UltilitiesIconColor or Color3.fromRGB(93, 93, 93),
				})

				utils.create('TextLabel', {
					Parent = Slider,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					Position = UDim2.new(0, 40, 0, 0),
					Size = UDim2.new(0, 100, 0, 40),
					Font = Enum.Font.Gotham,
					Text = name or "Slider",
					TextColor3 = library.theme.TitleColor,
					TextSize = 14.000,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				utils.create('UICorner', {
					Parent = Slider,
				})

				utils.create('UIStroke', {
					Color = library.theme.StrokeColor,
					Thickness = 0.800,
					Parent = Slider,
				})

				local OuterSlider = utils.create('ImageLabel', {
					Name = "OuterSlider",
					Parent = Slider,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.5, -6, 0.699999988, 0),
					Size = UDim2.new(0, 304, 0, 5),
					Image = "rbxassetid://3570695787",
					ImageColor3 = library.theme.SliderOuterColor,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(100, 100, 100, 100),
					SliceScale = 0.120,
					ZIndex = 4,
					ClipsDescendants = true
				})

				local CoverSlider = utils.create('Frame', {
					Name = "CoverSlider",
					Parent = OuterSlider,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0, 0, 0.5, 0),
					Size = UDim2.new(1, 0, 5, 0),
					Visible = true,
					ZIndex = 6
				})

				local InnerSlider = utils.create('ImageLabel', {
					Name = "InnerSlider",
					Parent = OuterSlider,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Size = UDim2.new(0, 0, 1, 0),
					Image = "rbxassetid://3570695787",
					ImageColor3 = library.theme.SliderInnerColor,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(100, 100, 100, 100),
					SliceScale = 0.120,
				})

				local Circle = utils.create('Frame', {
					Parent = InnerSlider,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = library.theme.BackgroundColor,
					Position = UDim2.new(0.899999976, 0, 0.5, 0),
					Size = UDim2.new(0, 20, 0, 20),
					ZIndex = 2,
					Visible = false
				})

				utils.create('UICorner', {
					CornerRadius = UDim.new(0, 3192),
					Parent = Circle
				})

				utils.create('ImageLabel', {
					Parent = InnerSlider,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.819999993, -4, 1.10999751, 0),
					Size = UDim2.new(0, 45, 0, 51),
					Image = "rbxassetid://8992584561",
					ImageColor3 = library.theme.SliderCircleShadow,
					ImageTransparency = 0.500,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(146, 146, 146, 146),
					SliceScale = 10.000,
					Visible = false
				})

				utils.create('UIPadding', {
					Parent = Slider,
					PaddingLeft = UDim.new(0, 10),
				})

				local ValueFrame = utils.create('Frame', {
					Name = "ValueFrame",
					Parent = Slider,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.349189907, -1, 0, 8),
					Size = UDim2.new(0, 200, 0, 20),
				})

				local Value = utils.create('Frame', {
					Parent = ValueFrame,
					BackgroundColor3 = library.theme.BackgroundColor,
					Size = UDim2.new(0, 30, 0, 20),
					AutomaticSize = Enum.AutomaticSize.X
				})

				utils.create('UIStroke', {
					Color = library.theme.StrokeColor or Color3.fromRGB(200, 200, 200),
					Thickness = 0.800,
					Parent = Value,
				})

				utils.create('UICorner', {
					CornerRadius = UDim.new(0, 5),
					Parent = Value,
				})

				local ValueTextBox = utils.create('TextBox', {
					Name = "ValueTextBox",
					Parent = Value,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Size = UDim2.new(1, 0, 1, 0),
					ClearTextOnFocus = false,
					Font = Enum.Font.Ubuntu,
					Text = tostring(default),
					TextColor3 = library.theme.TitleColor,
					PlaceholderColor3 = library.theme.TitleColor,
					TextSize = 12.000,
					AutomaticSize = Enum.AutomaticSize.X
				})

				utils.create('UIListLayout', {
					Parent = ValueFrame,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					SortOrder = Enum.SortOrder.LayoutOrder,
				})

				local Info = {
					Minimum = min,
					Maximum = max,
					Default = default or min
				}

				if default then
					pcall(callback, default)
				end

				Info.Default = math.clamp(Info.Default, Info.Minimum, Info.Maximum)
				local DefaultScale = tonumber((Info.Default - Info.Minimum) / (Info.Maximum - Info.Minimum))

				InnerSlider.Size = UDim2.new(DefaultScale, 0, 1, 0)

				local MinSize = 0
				local MaxSize = 1

				local SizeFromScale = (MinSize +  (MaxSize - MinSize)) * DefaultScale
				SizeFromScale = SizeFromScale - (SizeFromScale % 2)

				local touch = false
				local valuee = default

				SliderFunctions.move = function()
					local Px = utils.getXY(OuterSlider)
					local SizeFromScale = (MinSize +  (MaxSize - MinSize)) * Px
					local Value = math.floor(Info.Minimum + ((Info.Maximum - Info.Minimum) * Px))
					SizeFromScale = SizeFromScale - (SizeFromScale % 2)

					TweenService:Create(InnerSlider, TweenInfo.new(0.1), {Size = UDim2.new(Px,0,1,0)}):Play()
					-- TweenService:Create(Circle, TweenInfo.new(0.1), {Position = UDim2.new(Circle.Position.X.Scale + (Px / 10), 0, 0.5, 0)}):Play()

					ValueTextBox.Text = tostring(Value)
					valuee = Value
					Value = tonumber(Info.Minimum + (Info.Maximum - Info.Minimum) * Px)

					pcall(callback, Value)
				end

				CoverSlider.InputBegan:Connect(function(i)
					if i.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
					SliderFunctions.move()

					local MouseMove, MouseKill

					MouseMove = Mouse.Move:Connect(function()
						SliderFunctions.move()
					end)

					MouseKill = UserInputService.InputEnded:Connect(function(UserInput)
						if UserInput.UserInputType == Enum.UserInputType.MouseButton1 then
							MouseMove:Disconnect()
							MouseKill:Disconnect() 
						end
					end)
				end)

				SliderFunctions.SetValue = function(value)
					value = tonumber(value)
					if value > max or value < min then ValueTextBox.Text = valuee return end

					-- print("aaaaaaaaaaaaaa")

					local aaa = {
						Minimum = min,
						Maximum = max,
						Value = value
					}

					aaa.Value = math.clamp(aaa.Value, aaa.Minimum, aaa.Maximum)
					local ValueScale = tonumber((aaa.Value - aaa.Minimum) / (aaa.Maximum - aaa.Minimum))

					InnerSlider.Size = UDim2.new(ValueScale, 0, 1, 0)

					valuee = value
					ValueTextBox.Text = valuee

					pcall(callback, value)
				end

				local function isValidNumber(text)
					return tonumber(text) ~= nil
				end

				ValueTextBox.FocusLost:Connect(function(enterPressed)
					if enterPressed then
						local value = ValueTextBox.Text

						if isValidNumber(value) then
							SliderFunctions.SetValue(value)
						else
							ValueTextBox.Text = value
						end
					end
				end)

				UserInputService.InputBegan:Connect(function(input, isProcessed)
					if input.KeyCode == Enum.KeyCode.Return and ValueTextBox:IsFocused() then
						ValueTextBox:ReleaseFocus()
					end
				end)

				return SliderFunctions
			end

			TabFunctions.createDropdown = function(name, icon, multi_selection, list, default, callback, items)
				items = items and tonumber(items) or 5

				local DropdownFunctions = {
					Values = {},
					ValuesFunctions = {}
				}

				local Dropdown = utils.create('Frame', {
					Name = "Dropdown",
					Parent = TabContent,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					ClipsDescendants = true,
					Position = UDim2.new(0.0285632666, 0, 0.315199256, 0),
					Size = UDim2.new(0, 330, 0, 40),
				})

				local InvisibleButton = utils.create('TextButton', {
					Parent = Dropdown,
					BackgroundTransparency = 1,
					TextTransparency = 1,
					Size = UDim2.fromScale(1, 1)
				})

				utils.create('UICorner', {
					Parent = Dropdown,
				})

				utils.create('UIStroke', {
					Color = library.theme.StrokeColor,
					Thickness = 0.800,
					Parent = Dropdown,
				})

				local DropButton = utils.create('ImageButton', {
					Parent = Dropdown,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(252, 250, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0, 316, 0, 20),
					Size = UDim2.new(0, 18, 0, 18),
					Image = "rbxassetid://12974428978",
					ImageColor3 = library.theme.UnactiveColor,
				})

				utils.create('ImageLabel', {
					Parent = Dropdown,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0, 12, 0, 20),
					Size = UDim2.new(0, 25, 0, 25),
					Image = icon or "rbxassetid://12974446859",
					ImageColor3 = library.theme.UltilitiesIconColor,
				})

				utils.create('TextLabel', {
					Parent = Dropdown,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					Position = UDim2.new(0, 50, 0, 0),
					Size = UDim2.new(0, 100, 0, 40),
					Font = Enum.Font.Gotham,
					Text = name or "Dropdown",
					TextColor3 = library.theme.TitleColor,
					TextSize = 14.000,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local DropdownList = utils.create('CanvasGroup', {
					Name = "DropdownList",
					Parent = Dropdown,
					AnchorPoint = Vector2.new(0.5, 0),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.5, 0, 0, 40),
					Size = UDim2FromTable({0.909, 0},{0.75, 0}),
					GroupTransparency = 1,
				})

				local List = utils.create('ScrollingFrame', {
					Name = "List",
					Parent = DropdownList,
					Active = true,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Size = UDim2.new(1, 0, 1, 0),
					ScrollBarThickness = 1,
					BorderSizePixel = 0,
					ScrollBarImageColor3 = library.theme.ScrollingFrameColor
				})

				local ListUIL = utils.create('UIListLayout', {
					Parent = List,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 5),
				})

				task.spawn(function()
					while task.wait() do 
						utils.updatesize(ListUIL, List)
					end
				end)

				utils.create('UIPadding', {
					Parent = List,
					PaddingLeft = UDim.new(0, 10),
					PaddingTop = UDim.new(0, 5),
				})

				-- utils.smoothscrolling.Enable(List)

				local Dropped = false
				local DropdownSize = Dropdown.Size
				local DropdownListSize = DropdownList.Size

				local itemsInList = #list

				for i = 0, items, 1 do
					if i > itemsInList then
						break
					end

					DropdownSize = DropdownSize + UDim2.new(0, 0, 0, 42)
					-- DropdownListSize = DropdownListSize + UDim2.new(0, 0, 0, 42)
				end

				DropdownFunctions.ToggleDrop = function()
					Dropped = not Dropped
					if Dropped then
						utils.tween(Dropdown, {0.35, Enum.EasingStyle.Exponential, TweenDirection}, {Size = DropdownSize})
						utils.tween(DropButton, {0.35, Enum.EasingStyle.Sine, TweenDirection}, {ImageColor3 = library.theme.ActiveColor})

						wait(0.32)
						utils.tween(DropdownList, {0.35, Enum.EasingStyle.Sine, TweenDirection}, {GroupTransparency = 0})
					else
						utils.tween(DropdownList, {0.35, Enum.EasingStyle.Sine, TweenDirection}, {GroupTransparency = 1})
						wait(0.2)

						utils.tween(Dropdown, {0.5, Enum.EasingStyle.Exponential, TweenDirection}, {Size = UDim2.new(0, 330, 0, 40)})
						utils.tween(DropButton, {0.35, Enum.EasingStyle.Sine, TweenDirection}, {ImageColor3 = library.theme.UnactiveColor})
					end
				end

				DropdownFunctions.AddValue = function(value)
					local ValueFunctions = {
						Enabled = false
					}

					table.insert(DropdownFunctions.ValuesFunctions, ValueFunctions)

					local Button = utils.create('Frame', {
						Name = "Button",
						Parent = List,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0.0166666675, 0, 0.0476190485, 0),
						Size = UDim2.new(0, 270, 0, 40),
					})

					local InvisibleButton = utils.create('TextButton', {
						Parent = Button,
						BackgroundTransparency = 1,
						TextTransparency = 1,
						Size = UDim2.fromScale(1, 1)
					})

					utils.updatesize(ListUIL, List)

					utils.create('ImageLabel', {
						Parent = Button,
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0, 2, 0.5, 0),
						Size = UDim2.new(0, 25, 0, 25),
						Image = icon or "rbxassetid://12974446859",
						ImageColor3 = library.theme.UltilitiesIconColor,
					})

					utils.create('TextLabel', {
						Parent = Button,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(27, 42, 53),
						Position = UDim2.new(0, 40, 0, 0),
						Size = UDim2.new(0, 100, 1, 0),
						Font = Enum.Font.Gotham,
						Text = tostring(value) or "Button",
						TextColor3 = library.theme.TitleColor,
						TextSize = 14.000,
						TextXAlignment = Enum.TextXAlignment.Left,
					})

					utils.create('UIPadding', {
						Parent = Button,
						PaddingLeft = UDim.new(0, 10),
					})

					utils.create('UICorner', {
						Parent = Button,
					})

					local ButtonStroke = utils.create('UIStroke', {
						Color = library.theme.StrokeColor or Color3.fromRGB(200, 200, 200),
						Thickness = 0.800,
						Transparency = 1.000,
						Parent = Button,
					})

					ValueFunctions.Enable = function()

						if multi_selection then
							table.insert(DropdownFunctions.Values, value)
							pcall(callback, DropdownFunctions.Values)
						else
							for i, v in pairs(DropdownFunctions.ValuesFunctions) do 
								if v.Disable and v.Enabled then
									v.Disable()
								end
							end

							pcall(callback, value)
						end

						-- wait(0.2)
						-- utils.tween(ValueButton, {0.12, Enum.EasingStyle.Sine, TweenDirection}, {ImageColor3 = library.theme.ActiveColor})
						utils.tween(ButtonStroke, {0.12, Enum.EasingStyle.Sine, TweenDirection}, {Transparency = 0})
					end

					ValueFunctions.Disable = function()
						if multi_selection then
							local index = table.find(DropdownFunctions.Values, value)

							if index then      
								table.remove(DropdownFunctions.Values, index)
							end
							pcall(callback, DropdownFunctions.Values)
						else
							pcall(callback, nil)
						end

						-- task.wait(0.001)
						-- utils.tween(ValueButton, {0.12, Enum.EasingStyle.Sine, TweenDirection}, {ImageColor3 = library.theme.UnactiveColor})
						utils.tween(ButtonStroke, {0.12, Enum.EasingStyle.Sine, TweenDirection}, {Transparency = 1})
					end

					ValueFunctions.Delete = function()
						table.remove(DropdownFunctions.ValuesFunctions, table.find(DropdownFunctions.ValuesFunctions, ValueFunctions))
						ValueFunctions.Disable()
						Button:Destroy()
					end

					InvisibleButton.MouseButton1Down:Connect(function()
						ValueFunctions.Enabled = not ValueFunctions.Enabled
						if ValueFunctions.Enabled then
							ValueFunctions.Enable()
						else
							ValueFunctions.Disable()
						end
					end)

					return ValueFunctions
				end

				for i, v in pairs(list) do
					local val = DropdownFunctions.AddValue(v)

					if multi_selection and type(multi_selection) == "table" then
						if table.find(default, v) then
							val:Enable()
						end
					elseif multi_selection and type(multi_selection) ~= "table" then
						if v == default then
							val:Enable()
						end
					elseif not multi_selection and type(multi_selection) ~= "table" then
						if v == default then
							val:Enable()
						end
					end
				end

				DropdownFunctions.DeleteAll = function()
					for i, v in pairs(DropdownFunctions.ValuesFunctions) do
						if v.Delete then
							v.Delete()
						end
					end

					for i, v in pairs(DropdownFunctions.ValuesFunctions) do
						if v.Delete then
							v.Delete()
						end
					end

					for i, v in pairs(DropdownFunctions.ValuesFunctions) do
						if v.Delete then
							v.Delete()
						end
					end

					if Dropped then
						DropdownFunctions.ToggleDrop()
					end
				end

				DropdownFunctions.Refresh = function(list, _default)
					DropdownFunctions.DeleteAll()

					for i, v in pairs(list) do
						local val = DropdownFunctions.AddValue(v)

						if _default then
							if multi_selection and type(multi_selection) == "table" then
								if table.find(_default, v) then
									val:Enable()
								end
							elseif multi_selection and type(multi_selection) ~= "table" then
								if v == _default then
									val:Enable()
								end
							elseif not multi_selection and type(multi_selection) ~= "table" then
								if v == _default then
									val:Enable()
								end
							end
						end
					end
				end

				DropButton.MouseButton1Down:Connect(function()
					DropdownFunctions.ToggleDrop()
				end)

				InvisibleButton.MouseButton1Down:Connect(function()
					DropdownFunctions.ToggleDrop()
				end)

				return DropdownFunctions
			end

			TabFunctions.createTextBox = function(name, icon, default, callback)
				local TextBox = utils.create('Frame', {
					Name = "TextBox",
					Parent = TabContent,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.0285714287, 0, 0.181081086, 0),
					Size = UDim2.new(0, 330, 0, 40),
				})

				utils.create('ImageLabel', {
					Parent = TextBox,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0, 2, 0.5, 0),
					Size = UDim2.new(0, 25, 0, 25),
					Image = icon or "rbxassetid://12974446859",
					ImageColor3 = library.theme.UltilitiesIconColor or Color3.fromRGB(93, 93, 93),
				})

				utils.create('TextLabel', {
					Parent = TextBox,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					Position = UDim2.new(0, 40, 0, 0),
					Size = UDim2.new(0, 100, 1, 0),
					Font = Enum.Font.Gotham,
					Text = name or "TextBox",
					TextColor3 = library.theme.TitleColor or Color3.fromRGB(0, 0, 0),
					TextSize = 14.000,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				utils.create('UIPadding', {
					Parent = TextBox,
					PaddingLeft = UDim.new(0, 10),
				})

				utils.create('UICorner', {
					Parent = TextBox,
				})

				utils.create('UIStroke', {
					Color = library.theme.StrokeColor or Color3.fromRGB(200, 200, 200),
					Thickness = 0.800,
					Parent = TextBox,
				})

				local TextBoxFrame = utils.create('Frame', {
					Name = "TextBoxFrame",
					Parent = TextBox,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.349189907, -1, 0, 8),
					Size = UDim2.new(0, 200, 0, 20),
					-- ClipsDescendants = true
				})

				local TextBoxOuter = utils.create('Frame', {
					Name = "TextBoxOuter",
					Parent = TextBoxFrame,
					BackgroundColor3 = library.theme.BackgroundColor or Color3.fromRGB(255, 255, 255),
					Size = UDim2.new(0, 30, 0, 20),
					AutomaticSize = Enum.AutomaticSize.X
				})

				utils.create('UIStroke', {
					Color = library.theme.StrokeColor or Color3.fromRGB(200, 200, 200),
					Thickness = 0.800,
					Parent = TextBoxOuter,
				})

				utils.create('UICorner', {
					CornerRadius = UDim.new(0, 5),
					Parent = TextBoxOuter,
				})

				local TaiXuuBet88 = utils.create('TextBox', {
					Name = "TaiXuuBet88",
					Parent = TextBoxOuter,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Size = UDim2.new(1, 0, 1, 0),
					ClearTextOnFocus = false,
					Font = Enum.Font.Ubuntu,
					Text = tostring(default) or "nil",
					TextColor3 = library.theme.TitleColor,
					TextSize = 12.000,
					AutomaticSize = Enum.AutomaticSize.X
				})

				utils.create('UIListLayout', {
					Parent = TextBoxFrame,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					SortOrder = Enum.SortOrder.LayoutOrder,
				})

				if default and tostring(default) then
					pcall(callback, tostring(default))
				end

				TaiXuuBet88.FocusLost:Connect(function(enterPressed)
					if enterPressed then
						pcall(callback, TaiXuuBet88.Text)
					end
				end)

				UserInputService.InputBegan:Connect(function(input, isProcessed)
					if input.KeyCode == Enum.KeyCode.Return and TaiXuuBet88:IsFocused() then
						TaiXuuBet88:ReleaseFocus()
					end
				end)
			end

			TabFunctions.createKeybind = function(name, icon, default, callback)
				if table.find(Blacklisted, default) then
					default = nil
				end

				local Keybind = utils.create('Frame', {
					Name = "Keybind",
					Parent = TabContent,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.0285714287, 0, 0.181081086, 0),
					Size = UDim2.new(0, 330, 0, 40),
				})

				utils.create('ImageLabel', {
					Parent = Keybind,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0, 2, 0.5, 0),
					Size = UDim2.new(0, 25, 0, 25),
					Image = icon or "rbxassetid://12974446859",
					ImageColor3 = Color3.fromRGB(93, 93, 93),
				})

				utils.create('TextLabel', {
					Parent = Keybind,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					Position = UDim2.new(0, 40, 0, 0),
					Size = UDim2.new(0, 100, 1, 0),
					Font = Enum.Font.Gotham,
					Text = name or "Keybind",
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextSize = 14.000,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				utils.create('UIPadding', {
					Parent = Keybind,
					PaddingLeft = UDim.new(0, 10),
				})

				utils.create('UICorner', {
					Parent = Keybind,
				})

				utils.create('UIStroke', {
					Color = library.theme.StrokeColor or Color3.fromRGB(200, 200, 200),
					Thickness = 0.800,
					Parent = Keybind,
				})

				local KeybindOuter = utils.create('Frame', {
					Name = "KeybindOuter",
					Parent = Keybind,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.349189907, -1, 0, 8),
					Size = UDim2.new(0, 200, 0, 20),
				})

				local KeybindInner = utils.create('Frame', {
					Name = "KeybindInner",
					Parent = KeybindOuter,
					BackgroundColor3 = library.theme.BackgroundColor or Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 30, 0, 20),
					-- AutoButtonColor = false,
					AutomaticSize = Enum.AutomaticSize.X,
					-- Text = ""
				})

				local KeybindButton = utils.create("TextButton", {
					Parent = KeybindInner,
					BackgroundTransparency = 1,
					Text = "",
					Size = UDim2.new(1, 0, 1, 0)
				})

				utils.create('UIStroke', {
					Color = library.theme.StrokeColor or Color3.fromRGB(200, 200, 200),
					Thickness = 0.800,
					Parent = KeybindInner,
				})

				utils.create('UICorner', {
					CornerRadius = UDim.new(0, 5),
					Parent = KeybindInner,
				})

				local TaiXuuBet88 = utils.create('TextLabel', {
					Name = "TaiXuuBet88",
					Parent = KeybindInner,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Size = UDim2.new(1, 0, 1, 0),
					-- ClearTextOnFocus = false,
					Font = Enum.Font.Ubuntu,
					Text = "nil",
					TextColor3 = library.theme.TitleColor or Color3.fromRGB(0, 0, 0),
					TextSize = 12.000,
					-- TextEditable = false,
					AutomaticSize = Enum.AutomaticSize.X
				})

				utils.create('UIListLayout', {
					Parent = KeybindOuter,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					SortOrder = Enum.SortOrder.LayoutOrder,
				})

				local KeybindTextLabel = TaiXuuBet88
				local DefaultKey = default or nil
				local isBinding = false
				local boundKey, bindingInProgress

				KeybindTextLabel.Text = DefaultKey and DefaultKey.Name or "nil"

				local StartBinding = function()
					local previousKey = KeybindTextLabel.Text
					KeybindTextLabel.Text = "..."
					isBinding = true
					bindingInProgress = true

					UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
						if gameProcessedEvent then
							return
						end

						if input.UserInputType == Enum.UserInputType.Keyboard then
							if bindingInProgress then
								if table.find(Blacklisted, input.KeyCode) then
									if table.find(keys, input.KeyCode) then
										KeybindTextLabel.Text = keys[Enum.KeyCode[previousKey]]
										boundKey = previousKey.KeyCode.Name
										pcall(callback, previousKey.KeyCode)
									else
										KeybindTextLabel.Text = "nil"
										boundKey = nil
									end
								else
									KeybindTextLabel.Text = input.KeyCode.Name
									boundKey = input.KeyCode.Name
									pcall(callback, input.KeyCode)
									bindingInProgress = false
									wait(2)
									isBinding = false
								end
							end
						end
					end)
				end

				-- Bind the StartBinding function to the MouseButton1Down event of TextButton
				KeybindButton.MouseButton1Down:Connect(function()
					if not isBinding then
						StartBinding()
					end
				end)
			end

			TabFunctions.createColorPicker = function(name, icon, default, callback)
				local ColorPickerFunctions = { 
					Enabled = false
				}
				TabFunctions.ColorPickers = TabFunctions.ColorPickers or {}
				table.insert(TabFunctions, ColorPickerFunctions)

				default = default or Color3.fromRGB(255, 255, 255)

				local ColorPicker = utils.create('Frame', {
					Name = "ColorPicker",
					Parent = TabContent,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.0285714287, 0, 0.181081086, 0),
					Size = UDim2.new(0, 330, 0, 40),
				})

				utils.create('ImageLabel', {
					Parent = ColorPicker,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0, 2, 0.5, 0),
					Size = UDim2.new(0, 25, 0, 25),
					Image = icon or "rbxassetid://12974446859",
					ImageColor3 =library.theme.UltilitiesIconColor or Color3.fromRGB(93, 93, 93),
				})

				utils.create('TextLabel', {
					Parent = ColorPicker,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					Position = UDim2.new(0, 40, 0, 0),
					Size = UDim2.new(0, 100, 1, 0),
					Font = Enum.Font.Gotham,
					Text = name or "Color Picker",
					TextColor3 = library.theme.TitleColor or Color3.fromRGB(0, 0, 0),
					TextSize = 14.000,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				utils.create('UIPadding', {
					Parent = ColorPicker,
					PaddingLeft = UDim.new(0, 10),
				})

				utils.create('UICorner', {
					Parent = ColorPicker,
				})

				utils.create('UIStroke', {
					Color = library.theme.StrokeColor or Color3.fromRGB(200, 200, 200),
					Thickness = 0.800,
					Parent = ColorPicker,
				})

				local CPOuter = utils.create('Frame', {
					Name = "CPOuter",
					Parent = ColorPicker,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.349189907, -1, 0, 8),
					Size = UDim2.new(0, 200, 0, 20),
				})

				local CPInner = utils.create('Frame', {
					Name = "KeybindInner",
					Parent = CPOuter,
					BackgroundColor3 = default,
					Size = UDim2.new(0, 30, 0, 20),
				})

				local CPInnerButton = utils.create("TextButton", {
					Parent = CPInner, 
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					Text = ""
				})

				utils.create('UIStroke', {
					Color = library.theme.StrokeColor or Color3.fromRGB(200, 200, 200),
					Thickness = 0.800,
					Parent = CPInner,
				})

				utils.create('UICorner', {
					CornerRadius = UDim.new(0, 5),
					Parent = CPInner,
				})

				utils.create('UIListLayout', {
					Parent = CPOuter,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					SortOrder = Enum.SortOrder.LayoutOrder,
				})

				local ColorPicker = utils.create('CanvasGroup', {
					Name = "ColorPicker",
					Parent = ContentFrame,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.569230795, 0, 0.0114285713, 0),
					Size = UDim2.new(0, 262, 0, 330),
					GroupTransparency = 1
				})

				ColorPickerFunctions.Enable = function()
					for i, v in pairs(TabFunctions.ColorPickers) do
						if v.Disable then
							v.Disable()
						end
					end

					utils.tween(ColorPicker, {0.35, Enum.EasingStyle.Exponential, TweenDirection}, {GroupTransparency = 0})
				end

				ColorPickerFunctions.Disable = function()
					utils.tween(ColorPicker, {0.35, Enum.EasingStyle.Exponential, TweenDirection}, {GroupTransparency = 1})
				end

				CPInnerButton.MouseButton1Down:Connect(function()
					ColorPickerFunctions.Enabled = not ColorPickerFunctions.Enabled
					if ColorPickerFunctions.Enabled then
						ColorPickerFunctions.Enable()
					else
						ColorPickerFunctions.Disable()
					end
				end)

				ColorPickerFunctions["CP"] = ColorPicker

				local ColorPickerFrame = utils.create('Frame', {
					Name = "ColorPickerFrame",
					Parent = ColorPicker,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, 0, 0.5, -2),
					Size = UDim2.new(0.980000019, 0, 0.980000019, 0),
				})

				utils.create('UIStroke', {
					Color = library.theme.StrokeColor or Color3.fromRGB(200, 200, 200),
					Thickness = 0.800,
					Parent = ColorPickerFrame,
				})

				utils.create('UICorner', {
					Parent = ColorPickerFrame,
				})

				local ConfirmButton = utils.create('TextButton', {
					Name = "ConfirmButton",
					Parent = ColorPickerFrame,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.920000017, -10, 0.899999976, 5),
					Size = UDim2.new(0, 40, 0, 40),
					ZIndex = 2,
					Font = Enum.Font.SourceSans,
					Text = "",
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextSize = 14.000,
				})

				local InnerConfirmButton = utils.create('Frame', {
					Name = "InnerConfirmButton",
					Parent = ConfirmButton,
					BackgroundColor3 = library.theme.ConfirmButtonColor or Color3.fromRGB(107, 218, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					Position = UDim2.new(0.25, 0, 0.25, 0),
					Size = UDim2.new(0.75, 0, 0.75, 0),
					ZIndex = 2,
				})

				utils.create('UICorner', {
					Parent = InnerConfirmButton,
				})

				local InnerConfirmButtonIcon = utils.create('ImageLabel', {
					Parent = InnerConfirmButton,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0.5, 0, 0.5, 0),
					ZIndex = 2,
					Image = "rbxassetid://11419703997",
					ImageColor3 = library.theme.ColorPickerConfirmButtonColor or Color3.fromRGB(200, 200, 200),
				})

				utils.create('UIStroke', {
					Color = library.theme.StrokeColor or Color3.fromRGB(200, 200, 200),
					Thickness = 0.800,
					Parent = InnerConfirmButton,
				})

				local TopBarColorPicker = utils.create('Frame', {
					Name = "TopBarColorPicker",
					Parent = ColorPickerFrame,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0.00309214601, 30),
				})

				utils.create('TextLabel', {
					Parent = TopBarColorPicker,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 14, 0, 8),
					Size = UDim2.new(0, 200, 0, 20),
					Font = Enum.Font.Gotham,
					TextColor3 = library.theme.TitleColor or Color3.fromRGB(42, 42, 42),
					TextSize = 14.000,
					TextXAlignment = Enum.TextXAlignment.Left,
					Text = name or "Color Picker"
				})

				local CloseButton = utils.create('ImageButton', {
					Parent = TopBarColorPicker,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.930000007, 0, 0.5, 0),
					Size = UDim2.new(0, 16, 0, 16),
					Image = "rbxassetid://2777727756",
					ImageColor3 = Color3.fromRGB(93, 93, 93),
					-- // Generated by natsu.ps1#4977's plugin
				})

				local RGB = utils.create('ImageLabel', {
					Name = "RGB",
					Parent = ColorPickerFrame,
					AnchorPoint = Vector2.new(0.5, 0),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderColor3 = Color3.fromRGB(40, 40, 40),
					Position = UDim2.new(0.409999996, 0, 0.100000001, 0),
					Size = UDim2.new(0.699999988, 0, 0.600000024, 0),
					ZIndex = 4,
					Image = "rbxassetid://1433361550",
					SliceCenter = Rect.new(10, 10, 90, 90),
				})

				local Marker = utils.create('Frame', {
					Name = "Marker",
					Parent = RGB,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 2,
					Position = UDim2.new(0.5, 0, 1, 0),
					Size = UDim2.new(0, 4, 0, 4),
					ZIndex = 5,
				})

				utils.create('UIStroke', {
					Thickness = 2.000,
					Parent = Marker,
					Color = library.theme.ColorPickerDotStrokeColor
				})
			end

			TabFunctions.createAdditionalTab = function()
				local AdditionalTabFunctions = {
				}

				local AdditionalTabCanvasGroup = utils.create('CanvasGroup', {
					Parent = ContentFrame,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 0, 0),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2FromTable({0.776, -5},{0.479, 0}),
					Size = UDim2FromTable({0.426, -10},{0.957, -5}),
					GroupTransparency = 1
				})

				TabFunctions.additionalTab = AdditionalTabCanvasGroup

				local AdditionalTabContent = utils.create('ScrollingFrame', {
					Name = "TabContent",
					Parent = AdditionalTabCanvasGroup,
					Active = true,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 1, 0),
					ScrollBarThickness = 0,
					ScrollBarImageColor3 = library.theme.ForegroundColor
				})

				-- utils.smoothscrolling.Enable(TabContent, 30, 0.01)

				local AdditionalTabContentUIL = utils.create('UIListLayout', {
					Parent = AdditionalTabContent,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 8),
				})

				task.spawn(function()
					while task.wait() do
						utils.updatesize(AdditionalTabContentUIL, AdditionalTabContent)
					end
				end)

				utils.create('UIPadding', {
					Parent = AdditionalTabContent,
					PaddingLeft = UDim.new(0, 10),
					PaddingTop = UDim.new(0, 2),
				})

				u2 = UDim2FromTable

				AdditionalTabFunctions.createTabHeader = function(Title, Description)
					Title = Title or tabName

					local TabHeaderFunctions = {}

					local TabHeader = utils.create('Frame', {
						Name = "TabHeader",
						Parent = AdditionalTabContent,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						LayoutOrder = -1,
						AutomaticSize = Enum.AutomaticSize.Y,
						Position = UDim2.new(0.0285510346, 0, 0.00579710165, 0),
						Size = UDim2.new(0, 200, 0, 75),
					})

					utils.create('UIListLayout', {
						Parent = TabHeader,
						SortOrder = Enum.SortOrder.LayoutOrder,
					})

					local _Title = utils.create('TextLabel', {
						Name = "Title",
						Parent = TabHeader,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0.0158730168, 0, 0.00579710165, 0),
						Size = UDim2.new(0, 200, 0, 25),
						Font = Enum.Font.FredokaOne,
						Text = Title,
						TextColor3 = library.theme.TitleColor,
						TextSize = 28.000,
						AutomaticSize = Enum.AutomaticSize.Y,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Top,
					})

					local _Description = utils.create('TextLabel', {
						Name = "Description",
						Parent = TabHeader,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0.0158730168, 0, 0.0782608688, 0),
						Size = UDim2.new(0, 200, 0, 50),
						Font = Enum.Font.FredokaOne,
						Text = Description or "\"Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...\"",
						TextColor3 = Color3.fromRGB(170, 178, 198),
						TextSize = 16.000,
						TextWrapped = true,
						AutomaticSize = Enum.AutomaticSize.Y,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Top,
					})

					TabHeaderFunctions.updateTitle = function(newTitle)
						_Title.Text = newTitle
					end

					TabHeaderFunctions.updateDescription = function(newDesc)
						_Description.Text = newDesc
					end

					return TabHeaderFunctions
				end

				AdditionalTabFunctions.createLabel = function(name, icon)
					local Button = utils.create('Frame', {
						Parent = AdditionalTabContent,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0.0285714287, 0, 0.181081086, 0),
						Size = UDim2.new(0, 246, 0, 40),
					})

					utils.create('ImageLabel', {
						Parent = Button,
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0, 2, 0.5, 0),
						Size = UDim2.new(0, 25, 0, 25),
						Image = icon or "rbxassetid://12974446859",
						ImageColor3 = library.theme.UltilitiesIconColor,
					})

					local Title = utils.create('TextLabel', {
						Parent = Button,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(27, 42, 53),
						Position = UDim2.new(0, 40, 0, 0),
						Size = UDim2.new(0, 100, 1, 0),
						Font = Enum.Font.Gotham,
						Text = name or "Button",
						TextColor3 = library.theme.TitleColor,
						TextSize = 14.000,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Left,
					})

					utils.create('UIPadding', {
						Parent = Button,
						PaddingLeft = UDim.new(0, 10),
					})

					utils.create('UICorner', {
						Parent = Button,
					})

					utils.create('UIStroke', {
						Color = library.theme.StrokeColor,
						Thickness = 0.800,
						Parent = Button,
					})

					local AdditionalLabelFunctions = {}

					AdditionalLabelFunctions.Update = function(prop)
						for prop, v in next, prop do
							Title[prop] = v
						end
					end

					return AdditionalLabelFunctions
				end

				AdditionalTabFunctions.createButton = function(name, icon, callback)
					callback = callback or function()
						return true
					end

					local Button = utils.create('Frame', {
						Parent = AdditionalTabContent,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0.0285714287, 0, 0.181081086, 0),
						Size = UDim2.new(0, 246, 0, 40),
					})

					local InvisibleButton = utils.create('TextButton', {
						Parent = Button,
						BackgroundTransparency = 1,
						TextTransparency = 1,
						Size = UDim2.fromScale(1, 1)
					})

					utils.create('ImageLabel', {
						Parent = Button,
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0, 2, 0.5, 0),
						Size = UDim2.new(0, 25, 0, 25),
						Image = icon or "rbxassetid://12974446859",
						ImageColor3 = library.theme.UltilitiesIconColor,
						-- // Generated by natsu.ps1#4977's plugin
					})

					local Title = utils.create('TextLabel', {
						Parent = Button,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(27, 42, 53),
						Position = UDim2.new(0, 40, 0, 0),
						Size = u2({0.534, 0},{1, 0}),
						Font = Enum.Font.Gotham,
						Text = name or "Button",
						TextColor3 = library.theme.TitleColor,
						TextSize = 14.000,
						TextXAlignment = Enum.TextXAlignment.Left,
					})

					utils.create('UIPadding', {
						Parent = Button,
						PaddingLeft = UDim.new(0, 10),
					})

					utils.create('UICorner', {
						Parent = Button,
					})

					utils.create('UIStroke', {
						Color = library.theme.StrokeColor,
						Thickness = 0.800,
						Parent = Button,
					})

					local ButtonIcon = utils.create('ImageButton', {
						Parent = Button,
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(252, 250, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2FromTable({0.91, 0},{0, 20}),
						Size = UDim2.new(0, 18, 0, 18),
						Image = "rbxassetid://12974400739",
						ImageColor3 = Color3.fromRGB(0, 105, 254),
						-- // Generated by natsu.ps1#4977's plugin
					})

					ButtonIcon.MouseEnter:Connect(function()
						utils.tween(ButtonIcon, {0.2, Enum.EasingStyle.Sine, TweenDirection}, {ImageTransparency = 0.3})
					end)

					ButtonIcon.MouseLeave:Connect(function()
						utils.tween(ButtonIcon, {0.2, Enum.EasingStyle.Sine, TweenDirection}, {ImageTransparency = 0})
					end)

					InvisibleButton.MouseEnter:Connect(function()
						utils.tween(ButtonIcon, {0.2, Enum.EasingStyle.Sine, TweenDirection}, {ImageTransparency = 0.3})
					end)

					InvisibleButton.MouseLeave:Connect(function()
						utils.tween(ButtonIcon, {0.2, Enum.EasingStyle.Sine, TweenDirection}, {ImageTransparency = 0})
					end)

					ButtonIcon.MouseButton1Down:Connect(function()
						task.spawn(function()
							task.wait(0.1)
							utils.tween(ButtonIcon, {0.2, Enum.EasingStyle.Sine, TweenDirection}, {ImageTransparency = 0.5})
							task.wait(0.2)
							utils.tween(ButtonIcon, {0.2, Enum.EasingStyle.Sine, TweenDirection}, {ImageTransparency = 0})
						end)

						pcall(callback)
					end)

					InvisibleButton.MouseButton1Down:Connect(function()
						task.spawn(function()
							task.wait(0.1)
							utils.tween(ButtonIcon, {0.2, Enum.EasingStyle.Sine, TweenDirection}, {ImageTransparency = 0.5})
							task.wait(0.2)
							utils.tween(ButtonIcon, {0.2, Enum.EasingStyle.Sine, TweenDirection}, {ImageTransparency = 0})
						end)

						pcall(callback)
					end)
				end

				AdditionalTabFunctions.createToggle = function(name, icon, default, callback)
					callback = callback or function()
						return true    
					end

					local ToggleFunctions = {
						Enabled = default or false
					}

					local Toggle = utils.create('Frame', {
						Name = "Toggle",
						Parent = AdditionalTabContent,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0.0285714287, 0, 0.181081086, 0),
						Size = UDim2.new(0, 246, 0, 40),
						ZIndex = 10
					})

					local InvisibleButton = utils.create('TextButton', {
						Parent = Toggle,
						BackgroundTransparency = 1,
						TextTransparency = 1,
						Size = UDim2.fromScale(1, 1)
					})

					utils.create('UIStroke', {
						Color = library.theme.StrokeColor,
						Thickness = 0.800,
						Parent = Toggle,
					})

					utils.create('UICorner', {
						Parent = Toggle,
					})

					utils.create('ImageLabel', {
						Parent = Toggle,
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0, 2, 0, 20),
						Size = UDim2.new(0, 25, 0, 25),
						Image = icon or "rbxassetid://12974446859",
						ImageColor3 = library.theme.UltilitiesIconColor,
					})

					local Title = utils.create('TextLabel', {
						Parent = Toggle,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						AnchorPoint = Vector2.new(0, 0.5),
						BorderColor3 = Color3.fromRGB(27, 42, 53),
						Position = UDim2.new(0, 40, 0.5, 0),
						Size = u2({0.534, 0},{1, 0}),
						Font = Enum.Font.Gotham,
						Text = name or "Toggle",
						TextColor3 = library.theme.TitleColor,
						TextSize = 14.000,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextWrapped = true
					})

					utils.create('UIPadding', {
						Parent = Toggle,
						PaddingLeft = UDim.new(0, 10),
					})

					local ToggleFrame = utils.create('Frame', {
						Name = "Toggle",
						Parent = Toggle,
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = library.theme.UnactiveColor,
						Position = u2({0.87, 0},{0, 20}),
						Size = UDim2.new(0, 43, 0, 26),
						ZIndex = 10
					})

					utils.create('UICorner', {
						CornerRadius = UDim.new(0, 3192),
						Parent = ToggleFrame,
					})

					local ToggleInner = utils.create('TextButton', {
						AutoButtonColor = false,
						Name = "ToggleInner",
						Parent = ToggleFrame,
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = library.theme.BackgroundColor,
						Position = UDim2.new(0.300000012, 0, 0.5, 0),
						Size = UDim2.new(0, 22, 0, 22),
						Text = "",
						ZIndex = 0
					})

					local ToggleButton = utils.create("TextButton", {
						BackgroundTransparency = 1,
						Parent = ToggleFrame,
						Text = "",
						Size = UDim2.fromScale(1, 1)
					})

					utils.create('UICorner', {
						CornerRadius = UDim.new(0, 20),
						Parent = ToggleInner,
					})

					if default then
						ToggleFunctions.Enabled = true
						pcall(callback, ToggleFunctions.Enabled)

						utils.tween(ToggleFrame, {.16, Enum.EasingStyle.Quad, TweenDirection}, {BackgroundColor3 = library.theme.ActiveColor})
						utils.tween(ToggleInner, {.16, Enum.EasingStyle.Quad, TweenDirection}, {Position = UDim2.new(0.7, 0, 0.5, 0)})
					end

					ToggleFunctions.Enable = function()
						ToggleFunctions.Enabled = true
						pcall(callback, ToggleFunctions.Enabled)

						utils.tween(ToggleFrame, {.16, Enum.EasingStyle.Quad, TweenDirection}, {BackgroundColor3 = library.theme.ActiveColor})
						utils.tween(ToggleInner, {.16, Enum.EasingStyle.Quad, TweenDirection}, {Position = UDim2.new(0.7, 0, 0.5, 0)})
					end

					ToggleFunctions.Disable = function()
						ToggleFunctions.Enabled = false
						pcall(callback, ToggleFunctions.Enabled)

						utils.tween(ToggleFrame, {.16, Enum.EasingStyle.Quad, TweenDirection}, {BackgroundColor3 = library.theme.UnactiveColor})
						utils.tween(ToggleInner, {.16, Enum.EasingStyle.Quad, TweenDirection}, {Position = UDim2.new(0.3, 0, 0.5, 0)})
					end

					ToggleButton.MouseButton1Down:Connect(function()
						if ToggleFunctions.Enabled == true then
							ToggleFunctions.Disable()
						else
							ToggleFunctions.Enable()
						end
					end)

					InvisibleButton.MouseButton1Down:Connect(function()
						if ToggleFunctions.Enabled == true then
							ToggleFunctions.Disable()
						else
							ToggleFunctions.Enable()
						end
					end)

					Toggle.InputBegan:Connect(function(a)
						if a.UserInputType == Enum.UserInputType then
							if ToggleFunctions.Enabled == true then
								ToggleFunctions.Disable()
							else
								ToggleFunctions.Enable()
							end
						end
					end)

					return ToggleFunctions
				end

				AdditionalTabFunctions.createSlider = function(name, icon, min, max, default, callback)
					min = min or 0
					max = max or 10

					if default > max or default < min then
						default = min
					end

					callback = callback or function()

					end

					local SliderFunctions = {

					}

					local Slider = utils.create('Frame', {
						Name = "Slider",
						Parent = AdditionalTabContent,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0.0285510346, 0, 0.524637699, 0),
						Size = u2({0, 246},{0, 65}),
					})

					utils.create('ImageLabel', {
						Parent = Slider,
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0, 2, 0, 20),
						Size = UDim2.new(0, 25, 0, 25),
						Image = icon or "rbxassetid://12974446859",
						ImageColor3 = library.theme.UltilitiesIconColor or Color3.fromRGB(93, 93, 93),
					})

					utils.create('TextLabel', {
						Parent = Slider,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(27, 42, 53),
						Position = UDim2.new(0, 40, 0, 0),
						Size = UDim2.new(0, 100, 0, 40),
						Font = Enum.Font.Gotham,
						Text = name or "Slider",
						TextColor3 = library.theme.TitleColor,
						TextSize = 14.000,
						TextXAlignment = Enum.TextXAlignment.Left,
					})

					utils.create('UICorner', {
						Parent = Slider,
					})

					utils.create('UIStroke', {
						Color = library.theme.StrokeColor,
						Thickness = 0.800,
						Parent = Slider,
					})

					local OuterSlider = utils.create('ImageLabel', {
						Name = "OuterSlider",
						Parent = Slider,
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0.503, -6, 0.699999988, 0),
						Size = u2({0, 221},{0, 5}),
						Image = "rbxassetid://3570695787",
						ImageColor3 = library.theme.SliderOuterColor,
						ScaleType = Enum.ScaleType.Slice,
						SliceCenter = Rect.new(100, 100, 100, 100),
						SliceScale = 0.120,
						ZIndex = 4
					})

					local CoverSlider = utils.create('Frame', {
						Name = "CoverSlider",
						Parent = OuterSlider,
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0, 0, 0.5, 0),
						Size = UDim2.new(1, 0, 5, 0),
						Visible = true,
						ZIndex = 6
					})

					local InnerSlider = utils.create('ImageLabel', {
						Name = "InnerSlider",
						Parent = OuterSlider,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Size = UDim2.new(0, 0, 1, 0),
						Image = "rbxassetid://3570695787",
						ImageColor3 = library.theme.SliderInnerColor,
						ScaleType = Enum.ScaleType.Slice,
						SliceCenter = Rect.new(100, 100, 100, 100),
						SliceScale = 0.120,
					})

					local Circle = utils.create('Frame', {
						Parent = InnerSlider,
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundColor3 = library.theme.BackgroundColor,
						Position = UDim2.new(0.899999976, 0, 0.5, 0),
						Size = UDim2.new(0, 20, 0, 20),
						ZIndex = 2,
						Visible = false
					})

					utils.create('UICorner', {
						CornerRadius = UDim.new(0, 3192),
						Parent = Circle
					})

					utils.create('ImageLabel', {
						Parent = InnerSlider,
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0.819999993, -4, 1.10999751, 0),
						Size = UDim2.new(0, 45, 0, 51),
						Image = "rbxassetid://8992584561",
						ImageColor3 = library.theme.SliderCircleShadow,
						ImageTransparency = 0.500,
						ScaleType = Enum.ScaleType.Slice,
						SliceCenter = Rect.new(146, 146, 146, 146),
						SliceScale = 10.000,
						Visible = false
					})

					utils.create('UIPadding', {
						Parent = Slider,
						PaddingLeft = UDim.new(0, 10),
					})

					local ValueFrame = utils.create('Frame', {
						Name = "ValueFrame",
						Parent = Slider,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0.349189907, -1, 0, 8),
						Size = UDim2.new(0, 147, 0, 20),
					})

					local Value = utils.create('Frame', {
						Parent = ValueFrame,
						BackgroundColor3 = library.theme.BackgroundColor,
						Size = UDim2.new(0, 30, 0, 20),
						AutomaticSize = Enum.AutomaticSize.X
					})

					utils.create('UIStroke', {
						Color = library.theme.StrokeColor or Color3.fromRGB(200, 200, 200),
						Thickness = 0.800,
						Parent = Value,
					})

					utils.create('UICorner', {
						CornerRadius = UDim.new(0, 5),
						Parent = Value,
					})

					local ValueTextBox = utils.create('TextBox', {
						Name = "ValueTextBox",
						Parent = Value,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Size = UDim2.new(1, 0, 1, 0),
						ClearTextOnFocus = false,
						Font = Enum.Font.Ubuntu,
						Text = tostring(default),
						TextColor3 = library.theme.TitleColor,
						PlaceholderColor3 = library.theme.TitleColor,
						TextSize = 12.000,
						AutomaticSize = Enum.AutomaticSize.X
					})

					utils.create('UIListLayout', {
						Parent = ValueFrame,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						SortOrder = Enum.SortOrder.LayoutOrder,
					})

					local Info = {
						Minimum = min,
						Maximum = max,
						Default = default or min
					}

					Info.Default = math.clamp(Info.Default, Info.Minimum, Info.Maximum)
					local DefaultScale = tonumber((Info.Default - Info.Minimum) / (Info.Maximum - Info.Minimum))

					InnerSlider.Size = UDim2.new(DefaultScale, 0, 1, 0)

					local MinSize = 0
					local MaxSize = 1

					local SizeFromScale = (MinSize +  (MaxSize - MinSize)) * DefaultScale
					SizeFromScale = SizeFromScale - (SizeFromScale % 2)

					local touch = false
					local valuee = default

					SliderFunctions.move = function()
						local Px = utils.getXY(OuterSlider)
						local SizeFromScale = (MinSize +  (MaxSize - MinSize)) * Px
						local Value = math.floor(Info.Minimum + ((Info.Maximum - Info.Minimum) * Px))
						SizeFromScale = SizeFromScale - (SizeFromScale % 2)

						TweenService:Create(InnerSlider, TweenInfo.new(0.1), {Size = UDim2.new(Px,0,1,0)}):Play()
						-- TweenService:Create(Circle, TweenInfo.new(0.1), {Position = UDim2.new(Circle.Position.X.Scale + (Px / 10), 0, 0.5, 0)}):Play()

						ValueTextBox.Text = tostring(Value)
						valuee = Value

						Value = tonumber(Info.Minimum + (Info.Maximum - Info.Minimum) * Px)

						pcall(callback, Value)
					end

					CoverSlider.InputBegan:Connect(function(i)
						if i.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
						SliderFunctions.move()

						local MouseMove, MouseKill

						MouseMove = Mouse.Move:Connect(function()
							SliderFunctions.move()
						end)

						MouseKill = UserInputService.InputEnded:Connect(function(UserInput)
							if UserInput.UserInputType == Enum.UserInputType.MouseButton1 then
								MouseMove:Disconnect()
								MouseKill:Disconnect() 
							end
						end)
					end)

					SliderFunctions.SetValue = function(value)
						value = tonumber(value)
						if value > max or value < min then ValueTextBox.Text = valuee return end

						-- print("aaaaaaaaaaaaaa")

						local aaa = {
							Minimum = min,
							Maximum = max,
							Value = value
						}

						aaa.Value = math.clamp(aaa.Value, aaa.Minimum, aaa.Maximum)
						local ValueScale = tonumber((aaa.Value - aaa.Minimum) / (aaa.Maximum - aaa.Minimum))

						InnerSlider.Size = UDim2.new(ValueScale, 0, 1, 0)

						valuee = value
						ValueTextBox.Text = valuee

						pcall(callback, value)
					end

					local function isValidNumber(text)
						return tonumber(text) ~= nil
					end

					ValueTextBox.FocusLost:Connect(function(enterPressed)
						if enterPressed then
							local value = ValueTextBox.Text

							if isValidNumber(value) then
								SliderFunctions.SetValue(value)
							end
						end
					end)

					UserInputService.InputBegan:Connect(function(input, isProcessed)
						if input.KeyCode == Enum.KeyCode.Return and ValueTextBox:IsFocused() then
							ValueTextBox:ReleaseFocus()
						end
					end)

					return SliderFunctions
				end

				AdditionalTabFunctions.createDropdown = function(name, icon, multi_selection, list, default, callback, items)
					items = items and tonumber(items) or 5

					local DropdownFunctions = {
						Values = {},
						ValuesFunctions = {}
					}

					local Dropdown = utils.create('Frame', {
						Name = "Dropdown",
						Parent = AdditionalTabContent,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						ClipsDescendants = true,
						Position = UDim2.new(0.0285632666, 0, 0.315199256, 0),
						Size = UDim2.new(0, 246, 0, 40),
					})

					local InvisibleButton = utils.create('TextButton', {
						Parent = Dropdown,
						BackgroundTransparency = 1,
						TextTransparency = 1,
						Size = UDim2.fromScale(1, 1)
					})

					utils.create('UICorner', {
						Parent = Dropdown,
					})

					utils.create('UIStroke', {
						Color = library.theme.StrokeColor,
						Thickness = 0.800,
						Parent = Dropdown,
					})

					local DropButton = utils.create('ImageButton', {
						Parent = Dropdown,
						AnchorPoint = Vector2.new(1, 0.5),
						BackgroundColor3 = Color3.fromRGB(252, 250, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0, 230, 0, 20),
						Size = UDim2.new(0, 18, 0, 18),
						Image = "rbxassetid://12974428978",
						ImageColor3 = library.theme.UnactiveColor,
						ZIndex = 2
					})

					utils.create('ImageLabel', {
						Parent = Dropdown,
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0, 12, 0, 20),
						Size = UDim2.new(0, 25, 0, 25),
						Image = icon or "rbxassetid://12974446859",
						ImageColor3 = library.theme.UltilitiesIconColor,
					})

					utils.create('TextLabel', {
						Parent = Dropdown,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(27, 42, 53),
						Position = UDim2.new(0, 50, 0, 0),
						Size = UDim2.new(0, 100, 0, 40),
						Font = Enum.Font.Gotham,
						Text = name or "Dropdown",
						TextColor3 = library.theme.TitleColor,
						TextSize = 14.000,
						TextXAlignment = Enum.TextXAlignment.Left,
					})

					local DropdownList = utils.create('CanvasGroup', {
						Name = "DropdownList",
						Parent = Dropdown,
						AnchorPoint = Vector2.new(0.5, 0),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0.5, 0, 0, 40),
						Size = u2({0.909, 0},{0.75, 0}),
						GroupTransparency = 1,
						AutomaticSize = Enum.AutomaticSize.Y
					})

					local List = utils.create('ScrollingFrame', {
						Name = "List",
						Parent = DropdownList,
						Active = true,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Size = UDim2.new(1, 0, 1, 0),
						ScrollBarThickness = 1,
						BorderSizePixel = 0,
						ScrollBarImageColor3 = library.theme.ScrollingFrameColor,
						ScrollBarImageTransparency = 0.5
					})

					local ListUIL = utils.create('UIListLayout', {
						Parent = List,
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, 5),
					})

					task.spawn(function()
						while task.wait() do 
							utils.updatesize(ListUIL, List)
						end
					end)

					utils.create('UIPadding', {
						Parent = List,
						PaddingLeft = UDim.new(0, 5),
						PaddingTop = UDim.new(0, 5),
					})

					-- utils.smoothscrolling.Enable(List)

					local Dropped = false
					local DropdownSize = Dropdown.Size

					local itemsInList = #list

					for i = 0, items, 1 do
						if i > itemsInList then
							break
						end

						DropdownSize = DropdownSize + UDim2.new(0, 0, 0, 42)
					end

					DropdownFunctions.ToggleDrop = function()
						Dropped = not Dropped
						if Dropped then
							utils.tween(Dropdown, {0.35, Enum.EasingStyle.Exponential, TweenDirection}, {Size = DropdownSize})
							utils.tween(DropButton, {0.35, Enum.EasingStyle.Sine, TweenDirection}, {ImageColor3 = library.theme.ActiveColor})

							wait(0.32)
							utils.tween(DropdownList, {0.35, Enum.EasingStyle.Sine, TweenDirection}, {GroupTransparency = 0})
						else
							utils.tween(DropdownList, {0.35, Enum.EasingStyle.Sine, TweenDirection}, {GroupTransparency = 1})
							wait(0.2)

							utils.tween(Dropdown, {0.5, Enum.EasingStyle.Exponential, TweenDirection}, {Size = UDim2.new(0, 246, 0, 40)})
							utils.tween(DropButton, {0.35, Enum.EasingStyle.Sine, TweenDirection}, {ImageColor3 = library.theme.UnactiveColor})
						end
					end

					DropdownFunctions.AddValue = function(value)
						local ValueFunctions = {
							Enabled = false
						}

						table.insert(DropdownFunctions.ValuesFunctions, ValueFunctions)

						local Button = utils.create('Frame', {
							Name = "Button",
							Parent = List,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1.000,
							Position = UDim2.new(0.0166666675, 0, 0.0476190485, 0),
							Size = UDim2.new(0, 198, 0, 40),
						})

						local InvisibleButton = utils.create('TextButton', {
							Parent = Button,
							BackgroundTransparency = 1,
							TextTransparency = 1,
							Size = UDim2.fromScale(1, 1)
						})

						utils.create('ImageLabel', {
							Parent = Button,
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1.000,
							Position = UDim2.new(0, 2, 0.5, 0),
							Size = UDim2.new(0, 25, 0, 25),
							Image = icon or "rbxassetid://12974446859",
							ImageColor3 = library.theme.UltilitiesIconColor,
						})

						utils.create('TextLabel', {
							Parent = Button,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1.000,
							BorderColor3 = Color3.fromRGB(27, 42, 53),
							Position = UDim2.new(0, 40, 0, 0),
							Size = UDim2.new(0, 100, 1, 0),
							Font = Enum.Font.Gotham,
							Text = tostring(value) or "Button",
							TextColor3 = library.theme.TitleColor,
							TextSize = 14.000,
							TextXAlignment = Enum.TextXAlignment.Left,
						})

						utils.create('UIPadding', {
							Parent = Button,
							PaddingLeft = UDim.new(0, 16),
						})

						utils.create('UICorner', {
							Parent = Button,
						})

						local ButtonStroke = utils.create('UIStroke', {
							Color = library.theme.StrokeColor or Color3.fromRGB(200, 200, 200),
							Thickness = 0.800,
							Transparency = 1.000,
							Parent = Button,
						})

						ValueFunctions.Enable = function()
							if multi_selection then
								table.insert(DropdownFunctions.Values, value)
								pcall(callback, DropdownFunctions.Values)
							else
								for i, v in pairs(DropdownFunctions.ValuesFunctions) do 
									if v.Disable and v.Enabled then
										v.Disable()
									end
								end

								pcall(callback, value)
							end

							-- wait(0.2)
							-- utils.tween(ValueButton, {0.12, Enum.EasingStyle.Sine, TweenDirection}, {ImageColor3 = library.theme.ActiveColor})
							utils.tween(ButtonStroke, {0.12, Enum.EasingStyle.Sine, TweenDirection}, {Transparency = 0})
						end

						ValueFunctions.Disable = function()
							if multi_selection then
								local index = table.find(DropdownFunctions.Values, value)

								if index then      
									table.remove(DropdownFunctions.Values, index)
								end
								pcall(callback, DropdownFunctions.Values)
							else
								pcall(callback, nil)
							end

							-- task.wait(0.001)
							-- utils.tween(ValueButton, {0.12, Enum.EasingStyle.Sine, TweenDirection}, {ImageColor3 = library.theme.UnactiveColor})
							utils.tween(ButtonStroke, {0.12, Enum.EasingStyle.Sine, TweenDirection}, {Transparency = 1})
						end

						ValueFunctions.Delete = function()
							table.remove(DropdownFunctions.ValuesFunctions, table.find(DropdownFunctions.ValuesFunctions, ValueFunctions))
							ValueFunctions.Disable()
							Button:Destroy()
						end

						InvisibleButton.MouseButton1Down:Connect(function()
							ValueFunctions.Enabled = not ValueFunctions.Enabled
							if ValueFunctions.Enabled then
								ValueFunctions.Enable()
							else
								ValueFunctions.Disable()
							end
						end)

						return ValueFunctions
					end

					for i, v in pairs(list) do
						local val = DropdownFunctions.AddValue(v)
						if multi_selection and type(multi_selection) == "table" then
							if table.find(default, v) then
								val:Enable()
							end
						elseif multi_selection and type(multi_selection) ~= "table" then
							print(v == default)
							if v == default then
								val:Enable()
							end
						elseif not multi_selection and type(multi_selection) ~= "table" then
							if v == default then
								val:Enable()
							end
						end
					end

					DropdownFunctions.DeleteAll = function()
						for i, v in pairs(DropdownFunctions.ValuesFunctions) do
							if v.Delete then
								v.Delete()
							end
						end

						for i, v in pairs(DropdownFunctions.ValuesFunctions) do
							if v.Delete then
								v.Delete()
							end
						end

						for i, v in pairs(DropdownFunctions.ValuesFunctions) do
							if v.Delete then
								v.Delete()
							end
						end

						if Dropped then
							DropdownFunctions.ToggleDrop()
						end
					end

					DropdownFunctions.Refresh = function(list, _default)
						DropdownFunctions.DeleteAll()

						for i, v in pairs(list) do
							local val = DropdownFunctions.AddValue(v)

							if _default then
								if multi_selection and type(multi_selection) == "table" then
									if table.find(_default, v) then
										val:Enable()
									end
								elseif multi_selection and type(multi_selection) ~= "table" then
									if v == _default then
										val:Enable()
									end
								elseif not multi_selection and type(multi_selection) ~= "table" then
									if v == _default then
										val:Enable()
									end
								end
							end
						end
					end

					DropButton.MouseButton1Down:Connect(function()
						DropdownFunctions.ToggleDrop()
					end)

					InvisibleButton.MouseButton1Down:Connect(function()
						DropdownFunctions.ToggleDrop()
					end)

					return DropdownFunctions
				end

				AdditionalTabFunctions.createTextBox = function(name, icon, default, callback)
					local TextBox = utils.create('Frame', {
						Name = "TextBox",
						Parent = TabContent,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0.0285714287, 0, 0.181081086, 0),
						Size = UDim2.new(0, 330, 0, 40),
					})

					utils.create('ImageLabel', {
						Parent = TextBox,
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0, 2, 0.5, 0),
						Size = UDim2.new(0, 25, 0, 25),
						Image = icon or "rbxassetid://12974446859",
						ImageColor3 = library.theme.UltilitiesIconColor or Color3.fromRGB(93, 93, 93),
					})

					local Title = utils.create('TextLabel', {
						Parent = TextBox,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(27, 42, 53),
						Position = UDim2.new(0, 40, 0, 0),
						Size = u2({0.534, 0},{1, 0}),
						Font = Enum.Font.Gotham,
						Text = name or "TextBox",
						TextColor3 = library.theme.TitleColor or Color3.fromRGB(0, 0, 0),
						TextSize = 14.000,
						TextXAlignment = Enum.TextXAlignment.Left,
					})  

					utils.create('UIPadding', {
						Parent = TextBox,
						PaddingLeft = UDim.new(0, 10),
					})

					utils.create('UICorner', {
						Parent = TextBox,
					})

					utils.create('UIStroke', {
						Color = library.theme.StrokeColor or Color3.fromRGB(200, 200, 200),
						Thickness = 0.800,
						Parent = TextBox,
					})

					local TextBoxFrame = utils.create('Frame', {
						Name = "TextBoxFrame",
						Parent = TextBox,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0.349189907, -1, 0, 8),
						Size = UDim2.new(0, 200, 0, 20),
						-- ClipsDescendants = true
					})

					local TextBoxOuter = utils.create('Frame', {
						Name = "TextBoxOuter",
						Parent = TextBoxFrame,
						BackgroundColor3 = library.theme.BackgroundColor or Color3.fromRGB(255, 255, 255),
						Size = UDim2.new(0, 30, 0, 20),
						AutomaticSize = Enum.AutomaticSize.X
					})

					utils.create('UIStroke', {
						Color = library.theme.StrokeColor or Color3.fromRGB(200, 200, 200),
						Thickness = 0.800,
						Parent = TextBoxOuter,
					})

					utils.create('UICorner', {
						CornerRadius = UDim.new(0, 5),
						Parent = TextBoxOuter,
					})

					local TaiXuuBet88 = utils.create('TextBox', {
						Name = "TaiXuuBet88",
						Parent = TextBoxOuter,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Size = UDim2.new(1, 0, 1, 0),
						ClearTextOnFocus = false,
						Font = Enum.Font.Ubuntu,
						Text = tostring(default) or "nil",
						TextColor3 = library.theme.TitleColor,
						TextSize = 12.000,
						AutomaticSize = Enum.AutomaticSize.X
					})

					utils.create('UIListLayout', {
						Parent = TextBoxFrame,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						SortOrder = Enum.SortOrder.LayoutOrder,
					})

					if default and tostring(default) then
						pcall(callback, tostring(default))
					end

					TaiXuuBet88.FocusLost:Connect(function(enterPressed)
						if enterPressed then
							pcall(callback, TaiXuuBet88.Text)
						end
					end)

					UserInputService.InputBegan:Connect(function(input, isProcessed)
						if input.KeyCode == Enum.KeyCode.Return and TaiXuuBet88:IsFocused() then
							TaiXuuBet88:ReleaseFocus()
						end
					end)
				end

				AdditionalTabFunctions.createKeybind = function(name, icon, default, callback)
					if table.find(Blacklisted, default) then
						default = nil
					end

					local Keybind = utils.create('Frame', {
						Name = "Keybind",
						Parent = TabContent,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0.0285714287, 0, 0.181081086, 0),
						Size = UDim2.new(0, 330, 0, 40),
					})

					utils.create('ImageLabel', {
						Parent = Keybind,
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0, 2, 0.5, 0),
						Size = UDim2.new(0, 25, 0, 25),
						Image = icon or "rbxassetid://12974446859",
						ImageColor3 = Color3.fromRGB(93, 93, 93),
					})

					local Title = utils.create('TextLabel', {
						Parent = Keybind,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(27, 42, 53),
						Position = UDim2.new(0, 40, 0, 0),
						Size = u2({0.534, 0},{1, 0}),
						Font = Enum.Font.Gotham,
						Text = name or "Keybind",
						TextColor3 = Color3.fromRGB(0, 0, 0),
						TextSize = 14.000,
						TextXAlignment = Enum.TextXAlignment.Left,
					})

					utils.create('UIPadding', {
						Parent = Keybind,
						PaddingLeft = UDim.new(0, 10),
					})

					utils.create('UICorner', {
						Parent = Keybind,
					})

					utils.create('UIStroke', {
						Color = library.theme.StrokeColor or Color3.fromRGB(200, 200, 200),
						Thickness = 0.800,
						Parent = Keybind,
					})

					local KeybindOuter = utils.create('Frame', {
						Name = "KeybindOuter",
						Parent = Keybind,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Position = UDim2.new(0.349189907, -1, 0, 8),
						Size = UDim2.new(0, 200, 0, 20),
					})

					local KeybindInner = utils.create('Frame', {
						Name = "KeybindInner",
						Parent = KeybindOuter,
						BackgroundColor3 = library.theme.BackgroundColor or Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						Size = UDim2.new(0, 30, 0, 20),
						-- AutoButtonColor = false,
						AutomaticSize = Enum.AutomaticSize.X,
						-- Text = ""
					})

					local KeybindButton = utils.create("TextButton", {
						Parent = KeybindInner,
						BackgroundTransparency = 1,
						Text = "",
						Size = UDim2.new(1, 0, 1, 0)
					})

					utils.create('UIStroke', {
						Color = library.theme.StrokeColor or Color3.fromRGB(200, 200, 200),
						Thickness = 0.800,
						Parent = KeybindInner,
					})

					utils.create('UICorner', {
						CornerRadius = UDim.new(0, 5),
						Parent = KeybindInner,
					})

					local TaiXuuBet88 = utils.create('TextLabel', {
						Name = "TaiXuuBet88",
						Parent = KeybindInner,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						Size = UDim2.new(1, 0, 1, 0),
						-- ClearTextOnFocus = false,
						Font = Enum.Font.Ubuntu,
						Text = "nil",
						TextColor3 = library.theme.TitleColor or Color3.fromRGB(0, 0, 0),
						TextSize = 12.000,
						-- TextEditable = false,
						AutomaticSize = Enum.AutomaticSize.X
					})

					utils.create('UIListLayout', {
						Parent = KeybindOuter,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						SortOrder = Enum.SortOrder.LayoutOrder,
					})

					local KeybindTextLabel = TaiXuuBet88
					local DefaultKey = default or nil
					local isBinding = false
					local boundKey, bindingInProgress

					KeybindTextLabel.Text = DefaultKey and DefaultKey.Name or "nil"

					local StartBinding = function()
						local previousKey = KeybindTextLabel.Text
						KeybindTextLabel.Text = "..."
						isBinding = true
						bindingInProgress = true

						UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
							if gameProcessedEvent then
								return
							end

							if input.UserInputType == Enum.UserInputType.Keyboard then
								if bindingInProgress then
									if table.find(Blacklisted, input.KeyCode) then
										if table.find(keys, input.KeyCode) then
											KeybindTextLabel.Text = keys[Enum.KeyCode[previousKey]]
											boundKey = previousKey.KeyCode.Name
											pcall(callback, previousKey.KeyCode)
										else
											KeybindTextLabel.Text = "nil"
											boundKey = nil
										end
									else
										KeybindTextLabel.Text = input.KeyCode.Name
										boundKey = input.KeyCode.Name
										pcall(callback, input.KeyCode)
										bindingInProgress = false
										wait(2)
										isBinding = false
									end
								end
							end
						end)
					end

					-- Bind the StartBinding function to the MouseButton1Down event of TextButton
					KeybindButton.MouseButton1Down:Connect(function()
						if not isBinding then
							StartBinding()
						end
					end)
				end

				return AdditionalTabFunctions
			end

			return TabFunctions
		end

		utils.dragify(MainScreen, NavigatorFrame, 0.08, MainScreenShadow)
		utils.tween(MainScreen, {0.35, Enum.EasingStyle.Sine, TweenDirection}, {GroupTransparency = 0})
		utils.tween(MainScreenShadow, {0.35, Enum.EasingStyle.Sine, TweenDirection}, {ImageTransparency = 0.5})

		return WindowFunctions
	end

return library
