local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--==================================================
-- SETTINGS
--==================================================

local PASSWORD = "ram"

local ESP_ENABLED = false
local TARGET_PLAYER = nil

local NORMAL_COLOR = Color3.fromRGB(180, 0, 255)
local TARGET_COLOR = Color3.fromRGB(0, 120, 255)

local NORMAL_RAINBOW = false
local TARGET_RAINBOW = false

local ESP_DATA = {}

--==================================================
-- 50 COLORS + RAINBOW
--==================================================

local COLORS = {
	{"Purple", Color3.fromRGB(180,0,255)},
	{"Blue", Color3.fromRGB(0,120,255)},
	{"Red", Color3.fromRGB(255,50,50)},
	{"Green", Color3.fromRGB(50,255,80)},
	{"Yellow", Color3.fromRGB(255,230,40)},
	{"White", Color3.fromRGB(255,255,255)},
	{"Orange", Color3.fromRGB(255,140,0)},
	{"Pink", Color3.fromRGB(255,80,180)},
	{"Cyan", Color3.fromRGB(0,255,255)},
	{"Lime", Color3.fromRGB(150,255,0)},
	{"Teal", Color3.fromRGB(0,200,180)},
	{"Gold", Color3.fromRGB(255,190,0)},
	{"Magenta", Color3.fromRGB(255,0,255)},
	{"Navy", Color3.fromRGB(40,70,200)},
	{"Sky Blue", Color3.fromRGB(80,190,255)},
	{"Mint", Color3.fromRGB(100,255,190)},
	{"Crimson", Color3.fromRGB(190,20,50)},
	{"Violet", Color3.fromRGB(120,40,255)},
	{"Brown", Color3.fromRGB(150,80,30)},
	{"Gray", Color3.fromRGB(160,160,160)},
	{"Dark Purple", Color3.fromRGB(75,0,120)},
	{"Lavender", Color3.fromRGB(190,150,255)},
	{"Indigo", Color3.fromRGB(75,0,180)},
	{"Royal Blue", Color3.fromRGB(65,105,225)},
	{"Aqua", Color3.fromRGB(0,255,220)},
	{"Turquoise", Color3.fromRGB(64,224,208)},
	{"Emerald", Color3.fromRGB(0,180,100)},
	{"Forest", Color3.fromRGB(20,110,50)},
	{"Olive", Color3.fromRGB(130,140,30)},
	{"Amber", Color3.fromRGB(255,190,40)},
	{"Coral", Color3.fromRGB(255,110,90)},
	{"Salmon", Color3.fromRGB(250,130,120)},
	{"Hot Pink", Color3.fromRGB(255,20,150)},
	{"Rose", Color3.fromRGB(255,70,110)},
	{"Maroon", Color3.fromRGB(120,0,30)},
	{"Silver", Color3.fromRGB(200,200,210)},
	{"Dark Gray", Color3.fromRGB(80,80,85)},
	{"Dark Red", Color3.fromRGB(130,0,0)},
	{"Dark Blue", Color3.fromRGB(0,40,120)},
	{"Dark Green", Color3.fromRGB(0,100,40)},
	{"Neon Green", Color3.fromRGB(50,255,0)},
	{"Neon Blue", Color3.fromRGB(0,200,255)},
	{"Neon Pink", Color3.fromRGB(255,0,100)},
	{"Peach", Color3.fromRGB(255,180,140)},
	{"Cream", Color3.fromRGB(255,245,200)},
	{"Ice Blue", Color3.fromRGB(170,230,255)},
	{"Electric Purple", Color3.fromRGB(140,0,255)},
	{"Electric Orange", Color3.fromRGB(255,90,0)},
	{"Electric Yellow", Color3.fromRGB(255,255,0)},
	{"Electric Cyan", Color3.fromRGB(0,255,180)},
	{"Rainbow", "Rainbow"}
}

local function rainbowColor()
	return Color3.fromHSV((os.clock() * 0.25) % 1, 1, 1)
end

local function getPlayerColor(player)
	if player == TARGET_PLAYER then
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

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GameESP"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

--==================================================
-- PASSWORD WINDOW
--==================================================

local PasswordFrame = Instance.new("Frame")
PasswordFrame.Size = UDim2.fromOffset(280, 170)
PasswordFrame.Position = UDim2.fromScale(0.5, 0.5)
PasswordFrame.AnchorPoint = Vector2.new(0.5, 0.5)
PasswordFrame.BackgroundColor3 = Color3.fromRGB(25,20,30)
PasswordFrame.Parent = ScreenGui

local PasswordCorner = Instance.new("UICorner")
PasswordCorner.CornerRadius = UDim.new(0,10)
PasswordCorner.Parent = PasswordFrame

local PasswordStroke = Instance.new("UIStroke")
PasswordStroke.Color = NORMAL_COLOR
PasswordStroke.Thickness = 2
PasswordStroke.Parent = PasswordFrame

local PasswordTitle = Instance.new("TextLabel")
PasswordTitle.Size = UDim2.new(1,0,0,40)
PasswordTitle.BackgroundTransparency = 1
PasswordTitle.Text = "ENTER PASSWORD"
PasswordTitle.TextColor3 = NORMAL_COLOR
PasswordTitle.TextSize = 18
PasswordTitle.Font = Enum.Font.GothamBold
PasswordTitle.Parent = PasswordFrame

local PasswordBox = Instance.new("TextBox")
PasswordBox.Size = UDim2.new(1,-30,0,42)
PasswordBox.Position = UDim2.fromOffset(15,50)
PasswordBox.BackgroundColor3 = Color3.fromRGB(40,35,45)
PasswordBox.TextColor3 = Color3.new(1,1,1)
PasswordBox.PlaceholderText = "Password..."
PasswordBox.Text = ""
PasswordBox.TextSize = 16
PasswordBox.Font = Enum.Font.Gotham
PasswordBox.ClearTextOnFocus = false
PasswordBox.Parent = PasswordFrame

local EnterButton = Instance.new("TextButton")
EnterButton.Size = UDim2.new(1,-30,0,42)
EnterButton.Position = UDim2.fromOffset(15,105)
EnterButton.BackgroundColor3 = Color3.fromRGB(40,30,50)
EnterButton.Text = "ENTER"
EnterButton.TextColor3 = NORMAL_COLOR
EnterButton.TextSize = 16
EnterButton.Font = Enum.Font.GothamBold
EnterButton.Parent = PasswordFrame

--==================================================
-- MENU BUTTON
-- Başlangıçta gizli!
--==================================================

local MenuButton = Instance.new("TextButton")
MenuButton.Size = UDim2.fromOffset(60,36)
MenuButton.Position = UDim2.fromOffset(10,100)
MenuButton.BackgroundColor3 = Color3.fromRGB(35,25,45)
MenuButton.Text = "MENU"
MenuButton.TextColor3 = NORMAL_COLOR
MenuButton.TextSize = 13
MenuButton.Font = Enum.Font.GothamBold
MenuButton.Visible = false
MenuButton.Parent = ScreenGui

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0,8)
MenuCorner.Parent = MenuButton

--==================================================
-- MAIN GUI
--==================================================

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromOffset(215,410)
MainFrame.Position = UDim2.fromOffset(20,150)
MainFrame.BackgroundColor3 = Color3.fromRGB(25,20,30)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0,10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = NORMAL_COLOR
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

--==================================================
-- TITLE / DRAG BAR
--==================================================

local TitleBar = Instance.new("TextLabel")
TitleBar.Size = UDim2.new(1,0,0,35)
TitleBar.BackgroundColor3 = Color3.fromRGB(35,25,45)
TitleBar.Text = "GAME ESP"
TitleBar.TextColor3 = NORMAL_COLOR
TitleBar.TextSize = 16
TitleBar.Font = Enum.Font.GothamBold
TitleBar.Active = true
TitleBar.Parent = MainFrame

--==================================================
-- BUTTON FUNCTION
--==================================================

local function createButton(text, y, color)

	local Button = Instance.new("TextButton")

	Button.Size = UDim2.fromOffset(185,40)
	Button.Position = UDim2.fromOffset(15,y)
	Button.BackgroundColor3 = Color3.fromRGB(40,30,50)
	Button.Text = text
	Button.TextColor3 = color
	Button.TextSize = 15
	Button.Font = Enum.Font.GothamBold
	Button.Parent = MainFrame

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0,7)
	Corner.Parent = Button

	return Button
end

--==================================================
-- CONTROLS
--==================================================

local ESPButton = createButton(
	"ESP: OFF",
	45,
	NORMAL_COLOR
)

local NameBox = Instance.new("TextBox")
NameBox.Size = UDim2.fromOffset(185,40)
NameBox.Position = UDim2.fromOffset(15,92)
NameBox.BackgroundColor3 = Color3.fromRGB(40,30,50)
NameBox.TextColor3 = Color3.new(1,1,1)
NameBox.PlaceholderText = "Player name..."
NameBox.Text = ""
NameBox.TextSize = 14
NameBox.Font = Enum.Font.Gotham
NameBox.ClearTextOnFocus = false
NameBox.Parent = MainFrame

local TargetButton = createButton(
	"SET TARGET",
	140,
	TARGET_COLOR
)

local NormalColorButton = createButton(
	"Normal: Purple",
	188,
	NORMAL_COLOR
)

local TargetColorButton = createButton(
	"Target: Blue",
	236,
	TARGET_COLOR
)

--==================================================
-- SCROLLABLE COLOR MENU
--==================================================

local ColorFrame = Instance.new("ScrollingFrame")
ColorFrame.Size = UDim2.fromOffset(185,125)
ColorFrame.Position = UDim2.fromOffset(15,283)
ColorFrame.BackgroundColor3 = Color3.fromRGB(30,25,35)
ColorFrame.BorderSizePixel = 0
ColorFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ColorFrame.CanvasSize = UDim2.fromOffset(0,0)
ColorFrame.ScrollBarThickness = 7
ColorFrame.ScrollingDirection = Enum.ScrollingDirection.Y
ColorFrame.Visible = false
ColorFrame.ZIndex = 20
ColorFrame.Parent = MainFrame

local ColorCorner = Instance.new("UICorner")
ColorCorner.CornerRadius = UDim.new(0,7)
ColorCorner.Parent = ColorFrame

local ColorLayout = Instance.new("UIListLayout")
ColorLayout.Padding = UDim.new(0,5)
ColorLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ColorLayout.SortOrder = Enum.SortOrder.LayoutOrder
ColorLayout.Parent = ColorFrame

local ColorPadding = Instance.new("UIPadding")
ColorPadding.PaddingTop = UDim.new(0,5)
ColorPadding.PaddingBottom = UDim.new(0,5)
ColorPadding.Parent = ColorFrame

local SelectedMode = "Normal"

--==================================================
-- COLOR BUTTONS
--==================================================

for index, info in ipairs(COLORS) do

	local ColorName = info[1]
	local ColorValue = info[2]

	local Button = Instance.new("TextButton")

	Button.Size = UDim2.fromOffset(165,28)
	Button.LayoutOrder = index
	Button.ZIndex = 21
	Button.Text = ColorName
	Button.TextSize = 13
	Button.Font = Enum.Font.GothamBold

	if ColorValue == "Rainbow" then
		Button.BackgroundColor3 = Color3.fromRGB(255,0,255)
	else
		Button.BackgroundColor3 = ColorValue
	end

	Button.TextColor3 = Color3.new(0,0,0)
	Button.Parent = ColorFrame

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0,5)
	Corner.Parent = Button

	Button.Activated:Connect(function()

		if ColorName == "Rainbow" then

			if SelectedMode == "Normal" then
				NORMAL_RAINBOW = true
				NormalColorButton.Text = "Normal: Rainbow"
			else
				TARGET_RAINBOW = true
				TargetColorButton.Text = "Target: Rainbow"
			end

		else

			if SelectedMode == "Normal" then

				NORMAL_RAINBOW = false
				NORMAL_COLOR = ColorValue

				NormalColorButton.Text =
					"Normal: "..ColorName

				NormalColorButton.TextColor3 =
					NORMAL_COLOR

			else

				TARGET_RAINBOW = false
				TARGET_COLOR = ColorValue

				TargetColorButton.Text =
					"Target: "..ColorName

				TargetColorButton.TextColor3 =
					TARGET_COLOR
			end
		end

		ColorFrame.Visible = false
	end)
end

NormalColorButton.Activated:Connect(function()

	SelectedMode = "Normal"
	ColorFrame.Visible = not ColorFrame.Visible
end)

TargetColorButton.Activated:Connect(function()

	SelectedMode = "Target"
	ColorFrame.Visible = not ColorFrame.Visible
end)

--==================================================
-- REMOVE ESP
--==================================================

local function removeESP(player)

	local Data = ESP_DATA[player]

	if not Data then
		return
	end

	if Data.Billboard then
		Data.Billboard:Destroy()
	end

	if Data.Highlight then
		Data.Highlight:Destroy()
	end

	ESP_DATA[player] = nil
end

--==================================================
-- CREATE ESP
--==================================================

local function createESP(player)

	if player == LocalPlayer then
		return
	end

	local Character = player.Character

	if not Character then
		return
	end

	local Head = Character:FindFirstChild("Head")
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if not Head or not Humanoid then
		return
	end

	removeESP(player)

	local Color = getPlayerColor(player)

	local Highlight = Instance.new("Highlight")
	Highlight.Name = "GameESPHighlight"
	Highlight.Adornee = Character
	Highlight.FillColor = Color
	Highlight.OutlineColor = Color
	Highlight.FillTransparency = 0.75
	Highlight.OutlineTransparency = 0
	Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	Highlight.Parent = Character

	local Billboard = Instance.new("BillboardGui")
	Billboard.Name = "GameESPInfo"
	Billboard.Adornee = Head
	Billboard.Size = UDim2.fromOffset(220,85)
	Billboard.StudsOffset = Vector3.new(0,3.2,0)
	Billboard.AlwaysOnTop = true
	Billboard.Parent = ScreenGui

	local NameLabel = Instance.new("TextLabel")
	NameLabel.Size = UDim2.new(1,0,0,27)
	NameLabel.BackgroundTransparency = 1
	NameLabel.Text = player.Name
	NameLabel.TextColor3 = Color
	NameLabel.TextStrokeTransparency = 0
	NameLabel.TextSize = 18
	NameLabel.Font = Enum.Font.GothamBold
	NameLabel.Parent = Billboard

	local HealthLabel = Instance.new("TextLabel")
	HealthLabel.Position = UDim2.fromOffset(0,27)
	HealthLabel.Size = UDim2.new(1,0,0,27)
	HealthLabel.BackgroundTransparency = 1
	HealthLabel.TextColor3 = Color
	HealthLabel.TextStrokeTransparency = 0
	HealthLabel.TextSize = 16
	HealthLabel.Font = Enum.Font.GothamBold
	HealthLabel.Parent = Billboard

	local DistanceLabel = Instance.new("TextLabel")
	DistanceLabel.Position = UDim2.fromOffset(0,54)
	DistanceLabel.Size = UDim2.new(1,0,0,27)
	DistanceLabel.BackgroundTransparency = 1
	DistanceLabel.TextColor3 = Color
	DistanceLabel.TextStrokeTransparency = 0
	DistanceLabel.TextSize = 15
	DistanceLabel.Font = Enum.Font.Gotham
	DistanceLabel.Parent = Billboard

	ESP_DATA[player] = {
		Billboard = Billboard,
		Highlight = Highlight,
		NameLabel = NameLabel,
		HealthLabel = HealthLabel,
		DistanceLabel = DistanceLabel
	}
end

--==================================================
-- UPDATE ESP
--==================================================

local function updateESP()

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

	if PasswordBox.Text == PASSWORD then

		PasswordFrame.Visible = false

		-- Ana GUI açılır
		MainFrame.Visible = true

		-- MENU artık görünür
		MenuButton.Visible = true

	else

		PasswordTitle.Text = "WRONG PASSWORD"
		PasswordBox.Text = ""

		task.delay(1,function()
			PasswordTitle.Text = "ENTER PASSWORD"
		end)
	end
end

EnterButton.Activated:Connect(checkPassword)

PasswordBox.FocusLost:Connect(function(enterPressed)

	if enterPressed then
		checkPassword()
	end
end)

--==================================================
-- MENU OPEN / CLOSE
--==================================================

MenuButton.Activated:Connect(function()

	MainFrame.Visible = not MainFrame.Visible

	if MainFrame.Visible then
		MenuButton.Text = "HIDE"
	else
		MenuButton.Text = "MENU"
	end
end)

--==================================================
-- ESP ON / OFF
--==================================================

ESPButton.Activated:Connect(function()

	ESP_ENABLED = not ESP_ENABLED

	if ESP_ENABLED then
		ESPButton.Text = "ESP: ON"
	else
		ESPButton.Text = "ESP: OFF"
	end

	updateESP()
end)

--==================================================
-- TARGET
--==================================================

TargetButton.Activated:Connect(function()

	local TypedName = NameBox.Text:lower()

	if TypedName == "" then
		return
	end

	local FoundPlayer = nil

	for _, player in ipairs(Players:GetPlayers()) do

		if player ~= LocalPlayer then

			if player.Name:lower() == TypedName
				or player.DisplayName:lower() == TypedName then

				FoundPlayer = player
				break
			end
		end
	end

	if FoundPlayer then

		TARGET_PLAYER = FoundPlayer

		TargetButton.Text =
			"TARGET: "..FoundPlayer.Name

		if ESP_ENABLED then
			updateESP()
		end

	else

		TargetButton.Text = "NOT FOUND"

		task.delay(1.5,function()
			TargetButton.Text = "SET TARGET"
		end)
	end
end)

--==================================================
-- PLAYER EVENTS
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

for _, player in ipairs(Players:GetPlayers()) do
	setupPlayer(player)
end

Players.PlayerAdded:Connect(setupPlayer)

Players.PlayerRemoving:Connect(function(player)

	removeESP(player)

	if TARGET_PLAYER == player then

		TARGET_PLAYER = nil
		TargetButton.Text = "SET TARGET"
	end
end)

--==================================================
-- LIVE HP / DISTANCE / RAINBOW
--==================================================

RunService.RenderStepped:Connect(function()

	if not ESP_ENABLED then
		return
	end

	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local MyRoot =
		Character:FindFirstChild("HumanoidRootPart")

	if not MyRoot then
		return
	end

	for player, Data in pairs(ESP_DATA) do

		local Character2 = player.Character

		if Character2 then

			local Humanoid =
				Character2:FindFirstChildOfClass("Humanoid")

			local Root =
				Character2:FindFirstChild("HumanoidRootPart")

			if Humanoid and Root then

				local Color =
					getPlayerColor(player)

				Data.Highlight.FillColor = Color
				Data.Highlight.OutlineColor = Color

				Data.NameLabel.TextColor3 = Color
				Data.HealthLabel.TextColor3 = Color
				Data.DistanceLabel.TextColor3 = Color

				Data.HealthLabel.Text =
					string.format(
						"HP: %d / %d",
						math.floor(Humanoid.Health),
						math.floor(Humanoid.MaxHealth)
					)

				local Distance =
					(Root.Position - MyRoot.Position).Magnitude

				Data.DistanceLabel.Text =
					string.format(
						"Distance: %d studs",
						math.floor(Distance)
					)
			end
		end
	end
end)

--==================================================
-- DRAGGABLE MAIN GUI
--==================================================

local dragging = false
local dragStart
local startPosition

TitleBar.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPosition = MainFrame.Position

		input.Changed:Connect(function()

			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)

	if not dragging then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then

		local Delta =
			input.Position - dragStart

		MainFrame.Position =
			UDim2.new(
				startPosition.X.Scale,
				startPosition.X.Offset + Delta.X,

				startPosition.Y.Scale,
				startPosition.Y.Offset + Delta.Y
			)
	end
end)
