-- JHub Interface Script
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Sidebar = Instance.new("Frame")
local ContentFrame = Instance.new("Frame")
local BlurEffect = Instance.new("BlurEffect")

-- Add blur effect to the game
BlurEffect.Parent = game:GetService("Lighting")
BlurEffect.Size = 10

-- Parent the ScreenGui to the game's CoreGui
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Main frame configuration
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Active = true
MainFrame.Draggable = true

-- Add glass effect
local glassEffect = Instance.new("ImageLabel")
glassEffect.Name = "GlassEffect"
glassEffect.Parent = MainFrame
glassEffect.BackgroundTransparency = 1
glassEffect.Size = UDim2.new(1, 0, 1, 0)
glassEffect.Image = "rbxassetid://4595286933"
glassEffect.ImageColor3 = Color3.fromRGB(255, 255, 255)
glassEffect.ImageTransparency = 0.9
glassEffect.ScaleType = Enum.ScaleType.Slice
glassEffect.SliceCenter = Rect.new(10, 10, 118, 118)

-- Sidebar configuration
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Sidebar.BackgroundTransparency = 0.6
Sidebar.BorderSizePixel = 0
Sidebar.Position = UDim2.new(0, 0, 0, 0)
Sidebar.Size = UDim2.new(0, 150, 1, 0)

-- Content frame configuration
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ContentFrame.BackgroundTransparency = 0.5
ContentFrame.BorderSizePixel = 0
ContentFrame.Position = UDim2.new(0, 160, 0, 10)
ContentFrame.Size = UDim2.new(1, -170, 1, -20)

-- Title configuration
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = Sidebar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 20)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "JHub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24.000

-- Add rounded corners to main elements
local function addRoundedCorners(instance, radius)
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, radius)
    UICorner.Parent = instance
end

-- Add rounded corners to main elements
addRoundedCorners(MainFrame, 10)
addRoundedCorners(Sidebar, 10)
addRoundedCorners(ContentFrame, 10)

-- Create modern checkbox
local function createModernCheckbox(parent, text, position, callback)
    local CheckboxFrame = Instance.new("Frame")
    CheckboxFrame.Name = text .. "Frame"
    CheckboxFrame.Parent = parent
    CheckboxFrame.BackgroundTransparency = 1
    CheckboxFrame.Position = position
    CheckboxFrame.Size = UDim2.new(0.9, 0, 0, 40)

    local CheckboxButton = Instance.new("TextButton")
    CheckboxButton.Name = "Button"
    CheckboxButton.Parent = CheckboxFrame
    CheckboxButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CheckboxButton.BackgroundTransparency = 0.5
    CheckboxButton.BorderSizePixel = 0
    CheckboxButton.Position = UDim2.new(0, 0, 0.5, -12)
    CheckboxButton.Size = UDim2.new(0, 24, 0, 24)
    CheckboxButton.Text = ""
    CheckboxButton.AutoButtonColor = false
    addRoundedCorners(CheckboxButton, 6)

    local CheckboxFill = Instance.new("Frame")
    CheckboxFill.Name = "Fill"
    CheckboxFill.Parent = CheckboxButton
    CheckboxFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    CheckboxFill.BackgroundTransparency = 1
    CheckboxFill.BorderSizePixel = 0
    CheckboxFill.Position = UDim2.new(0, 2, 0, 2)
    CheckboxFill.Size = UDim2.new(1, -4, 1, -4)
    addRoundedCorners(CheckboxFill, 4)

    local CheckboxLabel = Instance.new("TextLabel")
    CheckboxLabel.Name = "Label"
    CheckboxLabel.Parent = CheckboxFrame
    CheckboxLabel.BackgroundTransparency = 1
    CheckboxLabel.Position = UDim2.new(0, 35, 0, 0)
    CheckboxLabel.Size = UDim2.new(1, -35, 1, 0)
    CheckboxLabel.Font = Enum.Font.GothamSemibold
    CheckboxLabel.Text = text
    CheckboxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    CheckboxLabel.TextSize = 14.000
    CheckboxLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Add hover and click effects
    local isChecked = false
    local tweenService = game:GetService("TweenService")
    
    local function updateCheckbox(checked)
        isChecked = checked
        local transparency = checked and 0 or 1
        local bgColor = checked and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(40, 40, 40)
        
        -- Animate the transition
        tweenService:Create(CheckboxFill, TweenInfo.new(0.2), {
            BackgroundTransparency = transparency
        }):Play()
        
        tweenService:Create(CheckboxButton, TweenInfo.new(0.2), {
            BackgroundColor3 = bgColor
        }):Play()
        
        callback(checked)
    end

    CheckboxButton.MouseEnter:Connect(function()
        tweenService:Create(CheckboxButton, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.3
        }):Play()
    end)

    CheckboxButton.MouseLeave:Connect(function()
        tweenService:Create(CheckboxButton, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.5
        }):Play()
    end)

    CheckboxButton.MouseButton1Click:Connect(function()
        updateCheckbox(not isChecked)
    end)

    return {
        frame = CheckboxFrame,
        setChecked = updateCheckbox,
        isChecked = function() return isChecked end
    }
end

-- Create category buttons
local function createCategoryButton(name, position, selected)
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Parent = Sidebar
    button.BackgroundColor3 = selected and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(20, 20, 20)
    button.BackgroundTransparency = 0.8
    button.BorderSizePixel = 0
    button.Position = UDim2.new(0.1, 0, 0, position)
    button.Size = UDim2.new(0.8, 0, 0, 40)
    button.Font = Enum.Font.GothamSemibold
    button.Text = name
    button.TextColor3 = selected and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
    button.TextSize = 14.000
    button.AutoButtonColor = false

    -- Add hover effect
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = button

    -- Add selection indicator
    local SelectionIndicator = Instance.new("Frame")
    SelectionIndicator.Name = "SelectionIndicator"
    SelectionIndicator.Parent = button
    SelectionIndicator.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    SelectionIndicator.BorderSizePixel = 0
    SelectionIndicator.Position = UDim2.new(0, -5, 0, 5)
    SelectionIndicator.Size = UDim2.new(0, 2, 1, -10)
    SelectionIndicator.Visible = selected

    return button
end

-- Create category frames
local function createCategoryFrame(name, visible)
    local frame = Instance.new("ScrollingFrame")
    frame.Name = name .. "Category"
    frame.Parent = ContentFrame
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Visible = visible
    frame.ScrollBarThickness = 4
    frame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    frame.ScrollBarImageTransparency = 0.5
    frame.CanvasSize = UDim2.new(0, 0, 0, 250)
    frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    return frame
end

-- Create categories
local PlayerButton = createCategoryButton("Player", 100, true)
local VisualsButton = createCategoryButton("Visuals", 150, false)
local MiscButton = createCategoryButton("Misc", 200, false)

local PlayerCategory = createCategoryFrame("Player", true)
local VisualsCategory = createCategoryFrame("Visuals", false)
local MiscCategory = createCategoryFrame("Misc", false)

-- Function to switch categories
local function switchCategory(selectedButton)
    -- Reset all buttons
    for _, button in pairs(Sidebar:GetChildren()) do
        if button:IsA("TextButton") then
            button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            button.TextColor3 = Color3.fromRGB(200, 200, 200)
            button.SelectionIndicator.Visible = false
        end
    end
    
    -- Reset all categories
    for _, frame in pairs(ContentFrame:GetChildren()) do
        if frame:IsA("ScrollingFrame") then
            frame.Visible = false
        end
    end
    
    -- Set selected button and category
    selectedButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    selectedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    selectedButton.SelectionIndicator.Visible = true
    
    -- Show selected category
    local categoryName = selectedButton.Text .. "Category"
    local selectedCategory = ContentFrame:FindFirstChild(categoryName)
    if selectedCategory then
        selectedCategory.Visible = true
        selectedCategory.CanvasPosition = Vector2.new(0, 0) -- Reset scroll position
    end
end

-- Create keybind button
local function createKeybindButton(parent, text, position)
    local KeybindFrame = Instance.new("Frame")
    KeybindFrame.Name = text .. "Frame"
    KeybindFrame.Parent = parent
    KeybindFrame.BackgroundTransparency = 1
    KeybindFrame.Position = position
    KeybindFrame.Size = UDim2.new(0.9, 0, 0, 40)

    local KeybindLabel = Instance.new("TextLabel")
    KeybindLabel.Name = "Label"
    KeybindLabel.Parent = KeybindFrame
    KeybindLabel.BackgroundTransparency = 1
    KeybindLabel.Position = UDim2.new(0, 0, 0, 0)
    KeybindLabel.Size = UDim2.new(0.6, 0, 1, 0)
    KeybindLabel.Font = Enum.Font.GothamSemibold
    KeybindLabel.Text = text
    KeybindLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeybindLabel.TextSize = 14.000
    KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left

    local KeybindButton = Instance.new("TextButton")
    KeybindButton.Name = "Button"
    KeybindButton.Parent = KeybindFrame
    KeybindButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    KeybindButton.BackgroundTransparency = 0.5
    KeybindButton.BorderSizePixel = 0
    KeybindButton.Position = UDim2.new(0.7, 0, 0.5, -15)
    KeybindButton.Size = UDim2.new(0.3, 0, 0, 30)
    KeybindButton.Font = Enum.Font.GothamSemibold
    KeybindButton.Text = "RightShift"
    KeybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeybindButton.TextSize = 12.000
    addRoundedCorners(KeybindButton, 6)

    local listening = false
    local currentKey = Enum.KeyCode.RightShift

    KeybindButton.MouseButton1Click:Connect(function()
        listening = true
        KeybindButton.Text = "..."
    end)

    game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if listening and input.UserInputType == Enum.UserInputType.Keyboard then
            listening = false
            currentKey = input.KeyCode
            KeybindButton.Text = currentKey.Name
            _G.menuToggleKey = currentKey
        elseif not listening and not gameProcessed and input.KeyCode == _G.menuToggleKey then
            MainFrame.Visible = not MainFrame.Visible
            BlurEffect.Enabled = MainFrame.Visible
        end
    end)

    return KeybindFrame
end

-- Initialize Misc category elements
local function initializeMisc()
    -- Toggle Menu Keybind
    local toggleKeybind = createKeybindButton(MiscCategory, "Toggle Menu", UDim2.new(0.05, 0, 0, 20))
    
    -- Rainbow UI Checkbox
    local rainbowUI = createModernCheckbox(MiscCategory, "Rainbow UI", UDim2.new(0.05, 0, 0, 70), function(checked)
        _G.rainbowUI = checked
        if checked then
            _G.rainbowUpdateConnection = game:GetService("RunService").RenderStepped:Connect(function()
                local hue = (tick() % 5) / 5
                local color = Color3.fromHSV(hue, 1, 1)
                
                for _, button in pairs(Sidebar:GetChildren()) do
                    if button:IsA("TextButton") and button.SelectionIndicator.Visible then
                        button.SelectionIndicator.BackgroundColor3 = color
                    end
                end
                
                for _, frame in pairs(ContentFrame:GetDescendants()) do
                    if frame:IsA("Frame") and frame.Name == "Fill" then
                        frame.BackgroundColor3 = color
                    end
                end
            end)
        else
            if _G.rainbowUpdateConnection then
                _G.rainbowUpdateConnection:Disconnect()
            end
            
            local defaultColor = Color3.fromRGB(0, 170, 255)
            for _, button in pairs(Sidebar:GetChildren()) do
                if button:IsA("TextButton") then
                    button.SelectionIndicator.BackgroundColor3 = defaultColor
                end
            end
            for _, frame in pairs(ContentFrame:GetDescendants()) do
                if frame:IsA("Frame") and frame.Name == "Fill" then
                    frame.BackgroundColor3 = defaultColor
                end
            end
        end
    end)
    
    -- UI Transparency Slider
    local transparencySlider = createModernSlider(MiscCategory, "UI Transparency", 0.3, 0, 0.9, "Transparency")
    transparencySlider.Position = UDim2.new(0.05, 0, 0, 120)
    
    -- Reset Button
    local resetButton = Instance.new("TextButton")
    resetButton.Name = "ResetButton"
    resetButton.Parent = MiscCategory
    resetButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    resetButton.BackgroundTransparency = 0.5
    resetButton.BorderSizePixel = 0
    resetButton.Position = UDim2.new(0.05, 0, 0, 180)
    resetButton.Size = UDim2.new(0.9, 0, 0, 40)
    resetButton.Font = Enum.Font.GothamSemibold
    resetButton.Text = "Reset All Settings"
    resetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetButton.TextSize = 14.000
    addRoundedCorners(resetButton, 6)
    
    resetButton.MouseButton1Click:Connect(function()
        -- Reset all settings
        _G.isFlying = false
        if _G.stopFlying then _G.stopFlying() end
        
        -- Reset player settings
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
        
        -- Reset ESP
        if _G.espInstances then
            for _, esp in pairs(_G.espInstances) do
                if esp and esp.Parent then esp:Destroy() end
            end
            _G.espInstances = {}
        end
        
        -- Reset lighting
        if _G.originalLightingValues then
            local lighting = game:GetService("Lighting")
            lighting.Brightness = _G.originalLightingValues.Brightness
            lighting.ClockTime = _G.originalLightingValues.ClockTime
            lighting.FogEnd = _G.originalLightingValues.FogEnd
            lighting.GlobalShadows = _G.originalLightingValues.GlobalShadows
            lighting.Ambient = _G.originalLightingValues.Ambient
        end
        
        -- Reset UI
        MainFrame.BackgroundTransparency = 0.3
        Sidebar.BackgroundTransparency = 0.6
        ContentFrame.BackgroundTransparency = 0.5
        _G.rainbowUI = false
        
        -- Reset all checkboxes
        for _, frame in pairs(MiscCategory:GetDescendants()) do
            if frame:IsA("Frame") and frame.Name:match("Frame$") then
                local checkbox = frame:FindFirstChild("Button")
                if checkbox and checkbox:FindFirstChild("Fill") then
                    checkbox.Fill.BackgroundTransparency = 1
                    checkbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                end
            end
        end
    end)
end

-- Connect category buttons
PlayerButton.MouseButton1Click:Connect(function()
    switchCategory(PlayerButton)
end)

VisualsButton.MouseButton1Click:Connect(function()
    switchCategory(VisualsButton)
end)

MiscButton.MouseButton1Click:Connect(function()
    switchCategory(MiscButton)
end)

-- Create modern slider
local function createModernSlider(parent, title, defaultValue, minValue, maxValue, property)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = property .. "Frame"
    SliderFrame.Parent = parent
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Position = UDim2.new(0.05, 0, 0, 0)
    SliderFrame.Size = UDim2.new(0.9, 0, 0, 60)

    local SliderTitle = Instance.new("TextLabel")
    SliderTitle.Name = "Title"
    SliderTitle.Parent = SliderFrame
    SliderTitle.BackgroundTransparency = 1
    SliderTitle.Size = UDim2.new(1, 0, 0, 20)
    SliderTitle.Font = Enum.Font.GothamSemibold
    SliderTitle.Text = title .. ": " .. defaultValue
    SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderTitle.TextSize = 14.000
    SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

    local SliderBackground = Instance.new("Frame")
    SliderBackground.Name = "Background"
    SliderBackground.Parent = SliderFrame
    SliderBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SliderBackground.BackgroundTransparency = 0.5
    SliderBackground.BorderSizePixel = 0
    SliderBackground.Position = UDim2.new(0, 0, 0, 30)
    SliderBackground.Size = UDim2.new(1, 0, 0, 6)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 3)
    UICorner.Parent = SliderBackground

    local SliderFill = Instance.new("Frame")
    SliderFill.Name = "Fill"
    SliderFill.Parent = SliderBackground
    SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    SliderFill.BorderSizePixel = 0
    SliderFill.Size = UDim2.new(0, 0, 1, 0)

    local UICorner2 = Instance.new("UICorner")
    UICorner2.CornerRadius = UDim.new(0, 3)
    UICorner2.Parent = SliderFill

    local SliderKnob = Instance.new("TextButton")
    SliderKnob.Name = "Knob"
    SliderKnob.Parent = SliderBackground
    SliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderKnob.Position = UDim2.new(0, -6, 0.5, -6)
    SliderKnob.Size = UDim2.new(0, 12, 0, 12)
    SliderKnob.Text = ""
    SliderKnob.AutoButtonColor = false

    local UICorner3 = Instance.new("UICorner")
    UICorner3.CornerRadius = UDim.new(0, 6)
    UICorner3.Parent = SliderKnob

    -- Slider functionality
    local dragging = false
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    local function updateSlider(input)
        local sliderPosition = math.clamp((input.Position.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X, 0, 1)
        SliderKnob.Position = UDim2.new(sliderPosition, -6, 0.5, -6)
        SliderFill.Size = UDim2.new(sliderPosition, 0, 1, 0)
        local value = math.floor(minValue + (maxValue - minValue) * sliderPosition)
        SliderTitle.Text = title .. ": " .. value
        humanoid[property] = value
    end

    SliderKnob.MouseButton1Down:Connect(function()
        dragging = true
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)

    -- Set default value
    local defaultPosition = (defaultValue - minValue) / (maxValue - minValue)
    SliderKnob.Position = UDim2.new(defaultPosition, -6, 0.5, -6)
    SliderFill.Size = UDim2.new(defaultPosition, 0, 1, 0)
    humanoid[property] = defaultValue

    return SliderFrame
end

-- Global state variables
_G.isFlying = false
local isNoclip = false
local hasInfiniteJump = false

-- Replace Fly button with checkbox
local flyCheckbox = createModernCheckbox(PlayerCategory, "Fly", UDim2.new(0.05, 0, 0, 180), function(checked)
    _G.isFlying = checked
    if checked then
        startFlying()
    else
        stopFlying()
    end
end)

-- Add Noclip functionality
local noClipCheckbox = createModernCheckbox(PlayerCategory, "Noclip", UDim2.new(0.05, 0, 0, 230), function(checked)
    isNoclip = checked
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    
    -- Setup noclip
    local function updateNoclip()
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid:ChangeState(isNoclip and 11 or 0)
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = not isNoclip
                end
            end
        end
    end
    
    -- Connect/disconnect noclip
    if checked then
        game:GetService("RunService").Stepped:Connect(function()
            if isNoclip then
                updateNoclip()
            end
        end)
    else
        updateNoclip()
    end
end)

-- Add Infinite Jump functionality
local infiniteJumpCheckbox = createModernCheckbox(PlayerCategory, "Infinite Jump", UDim2.new(0.05, 0, 0, 280), function(checked)
    hasInfiniteJump = checked
    
    if checked then
        -- Connect infinite jump
        local player = game.Players.LocalPlayer
        local function onJumpRequest()
            if hasInfiniteJump and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
        
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if hasInfiniteJump then
                onJumpRequest()
            end
        end)
    end
end)

-- Close button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -30, 0, 10)
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 24.000

CloseButton.MouseButton1Click:Connect(function()
    BlurEffect:Destroy()
    ScreenGui:Destroy()
end)

-- Fly functionality
local function initializeFly()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local connection = nil
    local flySpeed = 50
    
    function startFlying()
        if not _G.isFlying then return end
        
        -- Store the original state
        humanoid.PlatformStand = true
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Name = "FlyVelocity"
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = character.HumanoidRootPart
        
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.Name = "FlyGyro"
        bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bodyGyro.P = 9000
        bodyGyro.Parent = character.HumanoidRootPart
        
        -- Animation setup
        local animator = humanoid:WaitForChild("Animator")
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://507766388" -- Swimming animation
        local flyAnim = animator:LoadAnimation(animation)
        flyAnim:Play()
        flyAnim:AdjustSpeed(0.5)
        
        -- Fly controls
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if not _G.isFlying then 
                connection:Disconnect()
                return 
            end
            
            local camera = workspace.CurrentCamera
            local lookVector = camera.CFrame.LookVector
            local rightVector = camera.CFrame.RightVector
            local upVector = camera.CFrame.UpVector
            
            -- Update character orientation
            character.HumanoidRootPart.CFrame = CFrame.new(character.HumanoidRootPart.Position, character.HumanoidRootPart.Position + lookVector)
            bodyGyro.CFrame = camera.CFrame
            
            -- Calculate velocity based on input
            local moveVector = Vector3.new(0, 0, 0)
            local userInput = game:GetService("UserInputService")
            
            -- Forward/Backward
            if userInput:IsKeyDown(Enum.KeyCode.W) then
                moveVector = moveVector + lookVector
            end
            if userInput:IsKeyDown(Enum.KeyCode.S) then
                moveVector = moveVector - lookVector
            end
            
            -- Left/Right
            if userInput:IsKeyDown(Enum.KeyCode.A) then
                moveVector = moveVector - rightVector
            end
            if userInput:IsKeyDown(Enum.KeyCode.D) then
                moveVector = moveVector + rightVector
            end
            
            -- Up/Down based on camera angle
            if userInput:IsKeyDown(Enum.KeyCode.Space) then
                moveVector = moveVector + upVector
            end
            if userInput:IsKeyDown(Enum.KeyCode.LeftControl) then
                moveVector = moveVector - upVector
            end
            
            -- Normalize and apply speed
            if moveVector.Magnitude > 0 then
                moveVector = moveVector.Unit * flySpeed
            end
            
            -- Smooth velocity transition
            local currentVel = bodyVelocity.Velocity
            local targetVel = moveVector
            bodyVelocity.Velocity = currentVel:Lerp(targetVel, 0.2)
        end)
    end
    
    function stopFlying()
        local bodyVelocity = character.HumanoidRootPart:FindFirstChild("FlyVelocity")
        local bodyGyro = character.HumanoidRootPart:FindFirstChild("FlyGyro")
        
        if connection then
            connection:Disconnect()
            connection = nil
        end
        
        -- Stop animation
        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
            if track.Animation.AnimationId == "rbxassetid://507766388" then
                track:Stop()
            end
        end
        
        if bodyVelocity then bodyVelocity:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
        
        -- Reset character state properly
        humanoid.PlatformStand = false
        humanoid:ChangeState(Enum.HumanoidStateType.Landed)
        
        -- Force update the character's position to ensure proper landing
        character.HumanoidRootPart.CFrame = CFrame.new(
            character.HumanoidRootPart.Position,
            character.HumanoidRootPart.Position + character.HumanoidRootPart.CFrame.LookVector
        )
        
        -- Reset velocity
        character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
    end
    
    -- Make functions globally accessible
    _G.startFlying = startFlying
    _G.stopFlying = stopFlying
    
    -- Handle character respawn
    player.CharacterAdded:Connect(function(newCharacter)
        character = newCharacter
        humanoid = character:WaitForChild("Humanoid")
        if _G.isFlying then
            wait(0.5) -- Wait for character to load
            startFlying()
        end
    end)
end

-- Add elements to Visuals category
local espCheckbox = createModernCheckbox(VisualsCategory, "ESP", UDim2.new(0.05, 0, 0, 20), function(checked)
    -- Store ESP instances
    if not _G.espInstances then
        _G.espInstances = {}
    end
    
    -- Remove all existing ESP
    local function removeAllESP()
        for _, esp in pairs(_G.espInstances) do
            if esp and esp.Parent then
                esp:Destroy()
            end
        end
        _G.espInstances = {}
    end
    
    local function createESP(player)
        -- Remove existing ESP for this player if it exists
        if _G.espInstances[player.Name] then
            _G.espInstances[player.Name]:Destroy()
        end
        
        local esp = Instance.new("Highlight")
        esp.Name = "ESP_" .. player.Name
        esp.FillColor = Color3.fromRGB(255, 0, 0)
        esp.OutlineColor = Color3.fromRGB(255, 255, 255)
        esp.FillTransparency = 0.5
        esp.OutlineTransparency = 0
        
        -- Store the ESP instance
        _G.espInstances[player.Name] = esp
        
        local function updateESP()
            if player.Character and checked then
                esp.Parent = player.Character
                esp.Enabled = true
            else
                esp.Enabled = false
                esp.Parent = nil
            end
        end
        
        updateESP()
        player.CharacterAdded:Connect(updateESP)
        player.CharacterRemoving:Connect(function()
            esp.Enabled = false
            esp.Parent = nil
        end)
    end
    
    if checked then
        -- Create ESP for all players
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                createESP(player)
            end
        end
        
        -- Handle new players
        game.Players.PlayerAdded:Connect(function(player)
            if player ~= game.Players.LocalPlayer then
                createESP(player)
            end
        end)
        
        -- Handle players leaving
        game.Players.PlayerRemoving:Connect(function(player)
            if _G.espInstances[player.Name] then
                _G.espInstances[player.Name]:Destroy()
                _G.espInstances[player.Name] = nil
            end
        end)
    else
        removeAllESP()
    end
end)

local fullbrightCheckbox = createModernCheckbox(VisualsCategory, "Fullbright", UDim2.new(0.05, 0, 0, 70), function(checked)
    local lighting = game:GetService("Lighting")
    
    -- Store original lighting values if not stored
    if not _G.originalLightingValues then
        _G.originalLightingValues = {
            Brightness = lighting.Brightness,
            ClockTime = lighting.ClockTime,
            FogEnd = lighting.FogEnd,
            GlobalShadows = lighting.GlobalShadows,
            Ambient = lighting.Ambient
        }
    end
    
    if checked then
        -- Enable fullbright
        lighting.Brightness = 2
        lighting.ClockTime = 14
        lighting.FogEnd = 100000
        lighting.GlobalShadows = false
        lighting.Ambient = Color3.fromRGB(255, 255, 255)
        
        -- Remove all atmosphere effects
        for _, atmo in pairs(lighting:GetChildren()) do
            if atmo:IsA("Atmosphere") or atmo:IsA("Sky") then
                atmo.Parent = nil
            end
        end
    else
        -- Restore original lighting
        lighting.Brightness = _G.originalLightingValues.Brightness
        lighting.ClockTime = _G.originalLightingValues.ClockTime
        lighting.FogEnd = _G.originalLightingValues.FogEnd
        lighting.GlobalShadows = _G.originalLightingValues.GlobalShadows
        lighting.Ambient = _G.originalLightingValues.Ambient
        
        -- Restore atmosphere effects
        for _, atmo in pairs(workspace:GetChildren()) do
            if (atmo:IsA("Atmosphere") or atmo:IsA("Sky")) and atmo.Parent == nil then
                atmo.Parent = lighting
            end
        end
    end
end)

-- Initialize Player category elements
local function initializePlayer()
    -- Walk Speed Slider
    local WalkSpeedSlider = createModernSlider(PlayerCategory, "Walk Speed", 16, 16, 500, "WalkSpeed")
    WalkSpeedSlider.Position = UDim2.new(0.05, 0, 0, 20)

    -- Jump Power Slider
    local JumpPowerSlider = createModernSlider(PlayerCategory, "Jump Power", 50, 50, 500, "JumpPower")
    JumpPowerSlider.Position = UDim2.new(0.05, 0, 0, 100)

    -- Initialize flying functionality
    initializeFly()
end

-- Initialize all features
local function initializeAll()
    initializePlayer()
    initializeMisc()
end

initializeAll() 