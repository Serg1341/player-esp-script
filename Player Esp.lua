local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

--==================================================
-- SETTINGS
--==================================================

local PASSWORD = "ram"

local NORMAL_COLOR = Color3.fromRGB(180, 0, 255)
local TARGET_COLOR = Color3.fromRGB(0, 120, 255)

local NORMAL_RAINBOW = false
local TARGET_RAINBOW = false

local ESP_ENABLED = false
local targetPlayer = nil
local espData = {}

--==================================================
-- 50 COLORS + RAINBOW
--==================================================

local COLORS = {
	{"Purple", Color3.fromRGB(180, 0, 255)},
	{"Blue", Color3.fromRGB(0, 120, 255)},
	{"Red", Color3.fromRGB(255, 50, 50)},
	{"Green", Color3.fromRGB(50, 255, 80)},
	{"Yellow", Color3.fromRGB(255, 230, 40)},
	{"White", Color3.fromRGB(255, 255, 255)},
	{"Orange", Color3.fromRGB(255, 140, 0)},
	{"Pink", Color3.fromRGB(255, 80, 180)},
	{"Cyan", Color3.fromRGB(0, 255, 255)},
	{"Lime", Color3.fromRGB(150, 255, 0)},
	{"Teal", Color3.fromRGB(0, 200, 180)},
	{"Gold", Color3.fromRGB(255, 190, 0)},
	{"Magenta", Color3.fromRGB(255, 0, 255)},
	{"Navy", Color3.fromRGB(40, 70, 200)},
	{"Sky Blue", Color3.fromRGB(80, 190, 255)},
	{"Mint", Color3.fromRGB(100, 255, 190)},
	{"Crimson", Color3.fromRGB(190, 20, 50)},
	{"Violet", Color3.fromRGB(120, 40, 255)},
	{"Brown", Color3.fromRGB(150, 80, 30)},
	{"Gray", Color3.fromRGB(160, 160, 160)},
	{"Dark Purple", Color3.fromRGB(75, 0, 120)},
	{"Lavender", Color3.fromRGB(190, 150, 255)},
	{"Indigo", Color3.fromRGB(75, 0, 180)},
	{"Royal Blue", Color3.fromRGB(65, 105, 225)},
	{"Aqua", Color3.fromRGB(0, 255, 220)},
	{"Turquoise", Color3.fromRGB(64, 224, 208)},
	{"Emerald", Color3.fromRGB(0, 180, 100)},
	{"Forest", Color3.fromRGB(20, 110, 50)},
	{"Olive", Color3.fromRGB(130, 140, 30)},
	{"Amber", Color3.fromRGB(255, 190, 40)},
	{"Coral", Color3.fromRGB(255, 110, 90)},
	{"Salmon", Color3.fromRGB(250, 130, 120)},
	{"Hot Pink", Color3.fromRGB(255, 20, 150)},
	{"Rose", Color3.fromRGB(255, 70, 110)},
	{"Maroon", Color3.fromRGB(120, 0, 30)},
	{"Silver", Color3.fromRGB(200, 200, 210)},
	{"Dark Gray", Color3.fromRGB(80, 80, 85)},
	{"Dark Red", Color3.fromRGB(130, 0, 0)},
	{"Dark Blue", Color3.fromRGB(0, 40, 120)},
	{"Dark Green", Color3.fromRGB(0, 100, 40)},
	{"Neon Green", Color3.fromRGB(50, 255, 0)},
	{"Neon Blue", Color3.fromRGB(0, 200, 255)},
	{"Neon Pink", Color3.fromRGB(255, 0, 100)},
	{"Peach", Color3.fromRGB(255, 180, 140)},
	{"Cream", Color3.fromRGB(255, 245, 200)},
	{"Ice Blue", Color3.fromRGB(170, 230, 255)},
	{"Electric Purple", Color3.fromRGB(140, 0, 255)},
	{"Electric Orange", Color3.fromRGB(255, 90, 0)},
	{"Electric Yellow", Color3.fromRGB(255, 255, 0)},
	{"Electric Cyan", Color3.fromRGB(0, 255, 180)},
	{"Rainbow", "Rainbow"}
}

--==================================================
-- RAINBOW
--==================================================

local function rainbowColor()

	return Color3.fromHSV(
		(os.clock() * 0.25) % 1,
		1,
		1
	)
end

local function getPlayerColor(player)

	if player == targetPlayer then

		if TARGET_RAINBOW then
			return rainbowColor()
		end

		return TARGET_COLOR
	end

	if NORMAL_RAINBOW then
		return rainbowColor()
	end

	return NORMAL_COLOR
end

--==================================================
-- SCREEN GUI
--==================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GameESP"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

--==================================================
-- PASSWORD
--==================================================

local passwordFrame = Instance.new("Frame")
passwordFrame.Size = UDim2.fromOffset(280, 170)
passwordFrame.Position = UDim2.fromScale(0.5, 0.5)
passwordFrame.AnchorPoint = Vector2.new(0.5, 0.5)
passwordFrame.BackgroundColor3 = Color3.fromRGB(25, 20, 30)
passwordFrame.Parent = screenGui

local passwordCorner = Instance.new("UICorner")
passwordCorner.CornerRadius = UDim.new(0, 10)
passwordCorner.Parent = passwordFrame

local passwordTitle = Instance.new("TextLabel")
passwordTitle.Size = UDim2.new(1, 0, 0, 40)
passwordTitle.BackgroundTransparency = 1
passwordTitle.Text = "ENTER PASSWORD"
passwordTitle.TextColor3 = NORMAL_COLOR
passwordTitle.TextSize = 18
passwordTitle.Font = Enum.Font.GothamBold
passwordTitle.Parent = passwordFrame

local passwordBox = Instance.new("TextBox")
passwordBox.Size = UDim2.new(1, -30, 0, 42)
passwordBox.Position = UDim2.fromOffset(15, 50)
passwordBox.BackgroundColor3 = Color3.fromRGB(40, 35, 45)
passwordBox.TextColor3 = Color3.new(1, 1, 1)
passwordBox.PlaceholderText = "Password..."
passwordBox.Text = ""
passwordBox.TextSize = 16
passwordBox.Font = Enum.Font.Gotham
passwordBox.ClearTextOnFocus = false
passwordBox.Parent = passwordFrame

local enterButton = Instance.new("TextButton")
enterButton.Size = UDim2.new(1, -30, 0, 42)
enterButton.Position = UDim2.fromOffset(15, 105)
enterButton.BackgroundColor3 = Color3.fromRGB(40, 30, 50)
enterButton.TextColor3 = NORMAL_COLOR
enterButton.Text = "ENTER"
enterButton.TextSize = 16
enterButton.Font = Enum.Font.GothamBold
enterButton.Parent = passwordFrame

--==================================================
-- MAIN GUI
--==================================================

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.fromOffset(215, 410)
mainFrame.Position = UDim2.fromOffset(20, 150)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 20, 30)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = NORMAL_COLOR
mainStroke.Thickness = 2
mainStroke.Parent = mainFrame

--==================================================
-- TITLE BAR
--==================================================

local titleBar = Instance.new("TextLabel")
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 25, 45)
titleBar.Text = "GAME ESP"
titleBar.TextColor3 = NORMAL_COLOR
titleBar.TextSize = 16
titleBar.Font = Enum.Font.GothamBold
titleBar.Active = true
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBar

--==================================================
-- BUTTON FUNCTION
--==================================================

local function makeButton(text, y, color)

	local button = Instance.new("TextButton")

	button.Size = UDim2.fromOffset(185, 40)
	button.Position = UDim2.fromOffset(15, y)
	button.BackgroundColor3 = Color3.fromRGB(40, 30, 50)
	button.TextColor3 = color
	button.Text = text
	button.TextSize = 15
	button.Font = Enum.Font.GothamBold
	button.Parent = mainFrame

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 7)
	corner.Parent = button

	return button
end

--==================================================
-- CONTROLS
--==================================================

local espButton =
	makeButton("ESP: OFF", 45, NORMAL_COLOR)

local nameBox = Instance.new("TextBox")
nameBox.Size = UDim2.fromOffset(185, 40)
nameBox.Position = UDim2.fromOffset(15, 92)
nameBox.BackgroundColor3 = Color3.fromRGB(40, 30, 50)
nameBox.TextColor3 = Color3.new(1, 1, 1)
nameBox.PlaceholderText = "Player name..."
nameBox.Text = ""
nameBox.TextSize = 14
nameBox.Font = Enum.Font.Gotham
nameBox.Parent = mainFrame

local targetButton =
	makeButton("SET TARGET", 140, TARGET_COLOR)

local normalColorButton =
	makeButton("Normal: Purple", 188, NORMAL_COLOR)

local targetColorButton =
	makeButton("Target: Blue", 236, TARGET_COLOR)

--==================================================
-- SCROLLABLE COLOR LIST
--==================================================

local colorFrame = Instance.new("ScrollingFrame")

colorFrame.Size = UDim2.fromOffset(185, 125)
colorFrame.Position = UDim2.fromOffset(15, 283)

colorFrame.BackgroundColor3 =
	Color3.fromRGB(30, 25, 35)

colorFrame.BorderSizePixel = 0

colorFrame.AutomaticCanvasSize =
	Enum.AutomaticSize.Y

colorFrame.CanvasSize =
	UDim2.fromOffset(0, 0)

colorFrame.ScrollBarThickness = 7

colorFrame.ScrollingDirection =
	Enum.ScrollingDirection.Y

colorFrame.Visible = false

colorFrame.ZIndex = 20

colorFrame.Parent = mainFrame

local colorCorner = Instance.new("UICorner")
colorCorner.CornerRadius = UDim.new(0, 7)
colorCorner.Parent = colorFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 5)
layout.HorizontalAlignment =
	Enum.HorizontalAlignment.Center
layout.SortOrder =
	Enum.SortOrder.LayoutOrder
layout.Parent = colorFrame

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 5)
padding.PaddingBottom = UDim.new(0, 5)
padding.Parent = colorFrame

local selectedMode = "Normal"

--==================================================
-- COLOR BUTTONS
--==================================================

for index, colorInfo in ipairs(COLORS) do

	local colorName = colorInfo[1]
	local colorValue = colorInfo[2]

	local button = Instance.new("TextButton")

	button.Size = UDim2.fromOffset(165, 28)

	button.BackgroundColor3 =
		colorValue == "Rainbow"
		and Color3.fromRGB(255, 0, 255)
		or colorValue

	button.Text = colorName

	button.TextColor3 =
		Color3.new(0, 0, 0)

	button.TextSize = 13
	button.Font = Enum.Font.GothamBold

	button.LayoutOrder = index

	button.ZIndex = 21
	button.Parent = colorFrame

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 5)
	corner.Parent = button

	button.Activated:Connect(function()

		if colorName == "Rainbow" then

			if selectedMode == "Normal" then

				NORMAL_RAINBOW = true
				normalColorButton.Text =
					"Normal: Rainbow"

			else

				TARGET_RAINBOW = true
				targetColorButton.Text =
					"Target: Rainbow"
			end

		else

			if selectedMode == "Normal" then

				NORMAL_RAINBOW = false
				NORMAL_COLOR = colorValue

				normalColorButton.Text =
					"Normal: " .. colorName

				normalColorButton.TextColor3 =
					NORMAL_COLOR

			else

				TARGET_RAINBOW = false
				TARGET_COLOR = colorValue

				targetColorButton.Text =
					"Target: " .. colorName

				targetColorButton.TextColor3 =
					TARGET_COLOR
			end
		end

		colorFrame.Visible = false

		if ESP_ENABLED then
			updateESP()
		end
	end)
end

normalColorButton.Activated:Connect(function()

	selectedMode = "Normal"

	colorFrame.Visible =
		not colorFrame.Visible
end)

targetColorButton.Activated:Connect(function()

	selectedMode = "Target"

	colorFrame.Visible =
		not colorFrame.Visible
end)

--==================================================
-- REMOVE ESP
--==================================================

local function removeESP(player)

	local data = espData[player]

	if not data then
		return
	end

	if data.Billboard then
		data.Billboard:Destroy()
	end

	if data.Highlight then
		data.Highlight:Destroy()
	end

	espData[player] = nil
end

--==================================================
-- CREATE ESP
--==================================================

function createESP(player)

	if player == LocalPlayer then
		return
	end

	local character = player.Character

	if not character then
		return
	end

	local head =
		character:FindFirstChild("Head")

	local humanoid =
		character:FindFirstChildOfClass("Humanoid")

	if not head or not humanoid then
		return
	end

	removeESP(player)

	local color =
		getPlayerColor(player)

	local highlight =
		Instance.new("Highlight")

	highlight.Name =
		"GameESPHighlight"

	highlight.Adornee =
		character

	highlight.FillColor =
		color

	highlight.OutlineColor =
		color

	highlight.FillTransparency =
		0.75

	highlight.OutlineTransparency =
		0

	highlight.DepthMode =
		Enum.HighlightDepthMode.AlwaysOnTop

	highlight.Parent =
		character

	local billboard =
		Instance.new("BillboardGui")

	billboard.Name =
		"GameESPInfo"

	billboard.Adornee =
		head

	billboard.Size =
		UDim2.fromOffset(220, 85)

	billboard.StudsOffset =
		Vector3.new(0, 3.2, 0)

	billboard.AlwaysOnTop =
		true

	billboard.Parent =
		screenGui

	local nameLabel =
		Instance.new("TextLabel")

	nameLabel.Size =
		UDim2.new(1, 0, 0, 27)

	nameLabel.BackgroundTransparency =
		1

	nameLabel.Text =
		player.Name

	nameLabel.TextColor3 =
		color

	nameLabel.TextStrokeTransparency =
		0

	nameLabel.TextSize =
		18

	nameLabel.Font =
		Enum.Font.GothamBold

	nameLabel.Parent =
		billboard

	local healthLabel =
		Instance.new("TextLabel")

	healthLabel.Position =
		UDim2.fromOffset(0, 27)

	healthLabel.Size =
		UDim2.new(1, 0, 0, 27)

	healthLabel.BackgroundTransparency =
		1

	healthLabel.TextColor3 =
		color

	healthLabel.TextStrokeTransparency =
		0

	healthLabel.TextSize =
		16

	healthLabel.Font =
		Enum.Font.GothamBold

	healthLabel.Parent =
		billboard

	local distanceLabel =
		Instance.new("TextLabel")

	distanceLabel.Position =
		UDim2.fromOffset(0, 54)

	distanceLabel.Size =
		UDim2.new(1, 0, 0, 27)

	distanceLabel.BackgroundTransparency =
		1

	distanceLabel.TextColor3 =
		color

	distanceLabel.TextStrokeTransparency =
		0

	distanceLabel.TextSize =
		15

	distanceLabel.Font =
		Enum.Font.Gotham

	distanceLabel.Parent =
		billboard

	espData[player] = {

		Billboard = billboard,

		Highlight = highlight,

		NameLabel = nameLabel,

		HealthLabel = healthLabel,

		DistanceLabel = distanceLabel
	}
end

--==================================================
-- UPDATE ESP
--==================================================

function updateESP()

	for _, player in ipairs(Players:GetPlayers()) do

		if player ~= LocalPlayer then

			if ESP_ENABLED then
				createESP(player)
			else
				removeESP(player)
			end
		end
	end
end

--==================================================
-- PASSWORD
--==================================================

local function checkPassword()

	if passwordBox.Text == PASSWORD then

		passwordFrame.Visible = false
		mainFrame.Visible = true

	else

		passwordTitle.Text =
			"WRONG PASSWORD"

		passwordBox.Text = ""

		task.delay(1, function()

			passwordTitle.Text =
				"ENTER PASSWORD"
		end)
	end
end

enterButton.Activated:Connect(checkPassword)

passwordBox.FocusLost:Connect(function(enterPressed)

	if enterPressed then
		checkPassword()
	end
end)

--==================================================
-- ESP BUTTON
--==================================================

espButton.Activated:Connect(function()

	ESP_ENABLED =
		not ESP_ENABLED

	espButton.Text =
		ESP_ENABLED
		and "ESP: ON"
		or "ESP: OFF"

	updateESP()
end)

--==================================================
-- TARGET
--==================================================

targetButton.Activated:Connect(function()

	local typedName =
		nameBox.Text:lower()

	if typedName == "" then
		return
	end

	local foundPlayer

	for _, player in ipairs(Players:GetPlayers()) do

		if player ~= LocalPlayer then

			if player.Name:lower() == typedName
				or player.DisplayName:lower() == typedName then

				foundPlayer = player
				break
			end
		end
	end

	if foundPlayer then

		targetPlayer =
			foundPlayer

		targetButton.Text =
			"TARGET: " ..
			foundPlayer.Name

		if ESP_ENABLED then
			updateESP()
		end

	else

		targetButton.Text =
			"NOT FOUND"

		task.delay(1.5, function()

			targetButton.Text =
				"SET TARGET"
		end)
	end
end)

--==================================================
-- PLAYERS
--==================================================

local function setupPlayer(player)

	if player == LocalPlayer then
		return
	end

	player.CharacterAdded:Connect(function()

		task.wait(0.5)

		if ESP_ENABLED then
			createESP(player)
		end
	end)
end

for _, player in ipairs(
	Players:GetPlayers()
) do

	setupPlayer(player)
end

Players.PlayerAdded:Connect(
	setupPlayer
)

Players.PlayerRemoving:Connect(function(player)

	if targetPlayer == player then

		targetPlayer = nil

		targetButton.Text =
			"SET TARGET"
	end

	removeESP(player)
end)

--==================================================
-- LIVE HP / DISTANCE / RAINBOW
--==================================================

RunService.RenderStepped:Connect(function()

	if not ESP_ENABLED then
		return
	end

	local character =
		LocalPlayer.Character

	if not character then
		return
	end

	local myRoot =
		character:FindFirstChild(
			"HumanoidRootPart"
		)

	if not myRoot then
		return
	end

	for player, data in pairs(espData) do

		local character2 =
			player.Character

		if character2 then

			local humanoid =
				character2:FindFirstChildOfClass(
					"Humanoid"
				)

			local root =
				character2:FindFirstChild(
					"HumanoidRootPart"
				)

			if humanoid and root then

				local color =
					getPlayerColor(player)

				-- Rainbow / color update

				data.Highlight.FillColor =
					color

				data.Highlight.OutlineColor =
					color

				data.NameLabel.TextColor3 =
					color

				data.HealthLabel.TextColor3 =
					color

				data.DistanceLabel.TextColor3 =
					color

				-- HP

				data.HealthLabel.Text =
					string.format(
						"HP: %d / %d",

						math.floor(
							humanoid.Health
						),

						math.floor(
							humanoid.MaxHealth
						)
					)

				-- Distance

				local distance =
					(root.Position -
						myRoot.Position).Magnitude

				data.DistanceLabel.Text =
					string.format(
						"Distance: %d studs",

						math.floor(distance)
					)
			end
		end
	end
end)

--==================================================
-- DRAG GUI
--==================================================

local dragging = false
local dragStart
local startPosition

titleBar.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		dragging = true

		dragStart =
			input.Position

		startPosition =
			mainFrame.Position

		input.Changed:Connect(function()

			if input.UserInputState ==
				Enum.UserInputState.End then

				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)

	if not dragging then
		return
	end

	if input.UserInputType ==
		Enum.UserInputType.MouseMovement
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		local delta =
			input.Position - dragStart

		mainFrame.Position =
			UDim2.new(

				startPosition.X.Scale,

				startPosition.X.Offset +
					delta.X,

				startPosition.Y.Scale,

				startPosition.Y.Offset +
					delta.Y
			)
	end
end)
