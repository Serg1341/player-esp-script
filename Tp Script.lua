local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PASSWORD = "ram"

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "TeleportSystem"
Gui.ResetOnSpawn = false
Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

--==================================================
-- PASSWORD
--==================================================

local PasswordFrame = Instance.new("Frame")
PasswordFrame.Size = UDim2.fromOffset(280,160)
PasswordFrame.Position = UDim2.fromScale(0.5,0.5)
PasswordFrame.AnchorPoint = Vector2.new(0.5,0.5)
PasswordFrame.BackgroundColor3 = Color3.fromRGB(25,25,30)
PasswordFrame.Parent = Gui

Instance.new("UICorner",PasswordFrame).CornerRadius = UDim.new(0,10)

local PasswordTitle = Instance.new("TextLabel")
PasswordTitle.Size = UDim2.new(1,0,0,40)
PasswordTitle.BackgroundTransparency = 1
PasswordTitle.Text = "PASSWORD"
PasswordTitle.TextColor3 = Color3.fromRGB(180,0,255)
PasswordTitle.TextSize = 18
PasswordTitle.Font = Enum.Font.GothamBold
PasswordTitle.Parent = PasswordFrame

local PasswordBox = Instance.new("TextBox")
PasswordBox.Size = UDim2.new(1,-30,0,40)
PasswordBox.Position = UDim2.fromOffset(15,50)
PasswordBox.BackgroundColor3 = Color3.fromRGB(45,45,50)
PasswordBox.TextColor3 = Color3.new(1,1,1)
PasswordBox.PlaceholderText = "Enter password..."
PasswordBox.Text = ""
PasswordBox.TextSize = 15
PasswordBox.Parent = PasswordFrame

local EnterButton = Instance.new("TextButton")
EnterButton.Size = UDim2.new(1,-30,0,40)
EnterButton.Position = UDim2.fromOffset(15,105)
EnterButton.BackgroundColor3 = Color3.fromRGB(50,35,60)
EnterButton.Text = "ENTER"
EnterButton.TextColor3 = Color3.fromRGB(180,0,255)
EnterButton.TextSize = 15
EnterButton.Font = Enum.Font.GothamBold
EnterButton.Parent = PasswordFrame

Instance.new("UICorner",EnterButton).CornerRadius = UDim.new(0,7)

--==================================================
-- MENU BUTTON
--==================================================

local MenuButton = Instance.new("TextButton")
MenuButton.Size = UDim2.fromOffset(70,40)
MenuButton.Position = UDim2.fromOffset(15,120)
MenuButton.BackgroundColor3 = Color3.fromRGB(30,25,35)
MenuButton.Text = "MENU"
MenuButton.TextColor3 = Color3.fromRGB(180,0,255)
MenuButton.TextSize = 14
MenuButton.Font = Enum.Font.GothamBold
MenuButton.Visible = false
MenuButton.Parent = Gui

Instance.new("UICorner",MenuButton).CornerRadius = UDim.new(0,8)

--==================================================
-- MAIN MENU
--==================================================

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(250,300)
Main.Position = UDim2.fromOffset(20,170)
Main.BackgroundColor3 = Color3.fromRGB(25,25,30)
Main.Visible = false
Main.Active = true
Main.Parent = Gui

Instance.new("UICorner",Main).CornerRadius = UDim.new(0,10)

--==================================================
-- TITLE / DRAG AREA
--==================================================

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,42)
Title.BackgroundColor3 = Color3.fromRGB(35,30,40)
Title.Text = "TELEPORT"
Title.TextColor3 = Color3.fromRGB(180,0,255)
Title.TextSize = 17
Title.Font = Enum.Font.GothamBold
Title.Active = true
Title.Parent = Main

Instance.new("UICorner",Title).CornerRadius = UDim.new(0,10)

--==================================================
-- PLAYER NAME
--==================================================

local NameBox = Instance.new("TextBox")
NameBox.Size = UDim2.new(1,-30,0,40)
NameBox.Position = UDim2.fromOffset(15,55)
NameBox.BackgroundColor3 = Color3.fromRGB(45,45,50)
NameBox.TextColor3 = Color3.new(1,1,1)
NameBox.PlaceholderText = "Player name..."
NameBox.Text = ""
NameBox.TextSize = 14
NameBox.Parent = Main

Instance.new("UICorner",NameBox).CornerRadius = UDim.new(0,7)

--==================================================
-- TELEPORT BUTTON
--==================================================

local TeleportButton = Instance.new("TextButton")
TeleportButton.Size = UDim2.new(1,-30,0,40)
TeleportButton.Position = UDim2.fromOffset(15,105)
TeleportButton.BackgroundColor3 = Color3.fromRGB(50,35,60)
TeleportButton.Text = "TELEPORT"
TeleportButton.TextColor3 = Color3.fromRGB(180,0,255)
TeleportButton.TextSize = 15
TeleportButton.Font = Enum.Font.GothamBold
TeleportButton.Parent = Main

Instance.new("UICorner",TeleportButton).CornerRadius = UDim.new(0,7)

--==================================================
-- PLAYER LIST
--==================================================

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(1,-30,0,125)
PlayerList.Position = UDim2.fromOffset(15,160)
PlayerList.BackgroundColor3 = Color3.fromRGB(30,30,35)
PlayerList.BorderSizePixel = 0
PlayerList.ScrollBarThickness = 6
PlayerList.AutomaticCanvasSize = Enum.AutomaticSize.Y
PlayerList.CanvasSize = UDim2.new()
PlayerList.Parent = Main

Instance.new("UICorner",PlayerList).CornerRadius = UDim.new(0,7)

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0,4)
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListLayout.Parent = PlayerList

--==================================================
-- PLAYER SEARCH
--==================================================

local function FindPlayer(text)

	text = text:lower()

	for _,p in ipairs(Players:GetPlayers()) do

		if p ~= LocalPlayer then

			if p.Name:lower() == text
				or p.DisplayName:lower() == text then

				return p
			end
		end
	end

	return nil
end

--==================================================
-- TELEPORT
--==================================================

local function TeleportToPlayer()

	local target = FindPlayer(NameBox.Text)

	if not target then
		Title.Text = "PLAYER NOT FOUND"

		task.delay(1.5,function()
			Title.Text = "TELEPORT"
		end)

		return
	end

	local character = LocalPlayer.Character
	local targetCharacter = target.Character

	if not character or not targetCharacter then return end

	local root = character:FindFirstChild("HumanoidRootPart")
	local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")

	if root and targetRoot then
		root.CFrame = targetRoot.CFrame * CFrame.new(3,0,0)
	end
end

TeleportButton.Activated:Connect(TeleportToPlayer)

NameBox.FocusLost:Connect(function(enterPressed)

	if enterPressed then
		TeleportToPlayer()
	end
end)

--==================================================
-- PLAYER LIST UPDATE
--==================================================

local function UpdatePlayerList()

	for _,child in ipairs(PlayerList:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end

	for _,p in ipairs(Players:GetPlayers()) do

		if p ~= LocalPlayer then

			local button = Instance.new("TextButton")
			button.Size = UDim2.fromOffset(210,32)
			button.BackgroundColor3 = Color3.fromRGB(45,40,50)
			button.TextColor3 = Color3.new(1,1,1)
			button.Text = p.Name
			button.TextSize = 13
			button.Font = Enum.Font.Gotham
			button.Parent = PlayerList

			Instance.new("UICorner",button).CornerRadius = UDim.new(0,6)

			button.Activated:Connect(function()
				NameBox.Text = p.Name
			end)
		end
	end
end

UpdatePlayerList()

Players.PlayerAdded:Connect(UpdatePlayerList)
Players.PlayerRemoving:Connect(UpdatePlayerList)

--==================================================
-- MENU
--==================================================

MenuButton.Activated:Connect(function()

	Main.Visible = not Main.Visible

	if Main.Visible then
		MenuButton.Text = "HIDE"
	else
		MenuButton.Text = "MENU"
	end
end)

--==================================================
-- PASSWORD
--==================================================

local function CheckPassword()

	if PasswordBox.Text == PASSWORD then

		PasswordFrame.Visible = false
		MenuButton.Visible = true

	else

		PasswordTitle.Text = "WRONG PASSWORD"
		PasswordBox.Text = ""

		task.delay(1,function()
			PasswordTitle.Text = "PASSWORD"
		end)
	end
end

EnterButton.Activated:Connect(CheckPassword)

PasswordBox.FocusLost:Connect(function(enterPressed)

	if enterPressed then
		CheckPassword()
	end
end)

--==================================================
-- DRAG SYSTEM
--==================================================

local Dragging = false
local DragStart
local StartPosition

Title.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		Dragging = true
		DragStart = input.Position
		StartPosition = Main.Position
	end
end)

UIS.InputChanged:Connect(function(input)

	if not Dragging then return end

	if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then

		local Delta = input.Position - DragStart

		Main.Position = UDim2.new(
			StartPosition.X.Scale,
			StartPosition.X.Offset + Delta.X,
			StartPosition.Y.Scale,
			StartPosition.Y.Offset + Delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		Dragging = false
	end
end)
