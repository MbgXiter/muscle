-- 💪 MUSCLE LEGENDS CYBERPUNK - MAIN LOADER
-- Copy paste script ini di Roblox Studio Console atau exploit

local GameConfig = {
    -- 💰 Currency
    StartingMoney = 500,
    MoneyPerExercise = 25,
    MoneyPerStone = 15,
    
    -- 📊 Stats
    Stats = {
        Strength = 10,
        Speed = 10,
        Endurance = 10,
        Focus = 10,
    },
    
    -- 🎨 UI Colors (Cyberpunk Neon)
    Colors = {
        Cyan = Color3.fromRGB(0, 255, 255),
        Magenta = Color3.fromRGB(255, 0, 255),
        Purple = Color3.fromRGB(150, 100, 255),
        DarkBG = Color3.fromRGB(15, 15, 35),
        LighterBG = Color3.fromRGB(30, 30, 60),
        Green = Color3.fromRGB(0, 255, 100),
        Red = Color3.fromRGB(255, 50, 50),
        White = Color3.fromRGB(255, 255, 255),
    },
}

-- 📚 Utility Functions
local Utils = {}

function Utils.formatNumber(num)
    if num >= 1000000 then
        return string.format("%.1fM", num / 1000000)
    elseif num >= 1000 then
        return string.format("%.1fK", num / 1000)
    else
        return tostring(math.floor(num))
    end
end

function Utils.createTween(instance, duration, properties)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
    local tween = game:GetService("TweenService"):Create(instance, tweenInfo, properties)
    return tween
end

function Utils.createNeonFrame(parent, name, size, position, color)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = GameConfig.Colors.DarkBG
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or GameConfig.Colors.Cyan
    stroke.Thickness = 2
    stroke.Parent = frame
    
    return frame
end

function Utils.createNeonText(parent, name, text, size, position, color)
    local label = Instance.new("TextLabel")
    label.Name = name
    label.Text = text
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.TextColor3 = color or GameConfig.Colors.Cyan
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = parent
    return label
end

function Utils.createNeonButton(parent, name, text, size, position, callback)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Text = text
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = GameConfig.Colors.LighterBG
    button.TextColor3 = GameConfig.Colors.Cyan
    button.Font = Enum.Font.GothamBold
    button.BorderSizePixel = 0
    button.Parent = parent
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = GameConfig.Colors.Magenta
    stroke.Thickness = 2
    stroke.Parent = button
    
    button.MouseEnter:Connect(function()
        stroke.Color = GameConfig.Colors.Green
        local tween = Utils.createTween(button, 0.2, {BackgroundColor3 = GameConfig.Colors.LighterBG})
        tween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        stroke.Color = GameConfig.Colors.Magenta
    end)
    
    if callback then
        button.MouseButton1Click:Connect(callback)
    end
    
    return button
end

-- 📊 Player Data
local PlayerData = {
    Money = GameConfig.StartingMoney,
    Level = 1,
    Experience = 0,
    Stats = {
        Strength = GameConfig.Stats.Strength,
        Speed = GameConfig.Stats.Speed,
        Endurance = GameConfig.Stats.Endurance,
        Focus = GameConfig.Stats.Focus,
    },
    IsExercising = false,
    ExerciseCooldown = 0,
}

-- 🏋️ EXERCISE SYSTEM
local ExerciseSystem = {}

local ExerciseData = {
    Dumbbell = {
        name = "🏋️ Dumbbell",
        duration = 5,
        strengthGain = 2,
        enduranceGain = 1,
        moneyGain = 25,
    },
    Running = {
        name = "🏃 Running",
        duration = 5,
        speedGain = 2,
        enduranceGain = 1.5,
        moneyGain = 20,
    },
    PushUps = {
        name = "💪 Push-ups",
        duration = 5,
        strengthGain = 1.5,
        enduranceGain = 2,
        moneyGain = 22,
    },
    Meditation = {
        name = "🧘 Meditation",
        duration = 5,
        focusGain = 2,
        enduranceGain = 0.5,
        moneyGain = 15,
    },
}

function ExerciseSystem.startExercise(exerciseType)
    if PlayerData.IsExercising then
        print("⏳ Sedang latihan, tunggu sebentar...")
        return
    end
    
    local exercise = ExerciseData[exerciseType]
    if not exercise then
        print("❌ Latihan tidak ditemukan")
        return
    end
    
    PlayerData.IsExercising = true
    print("✅ Mulai latihan: " .. exercise.name)
    
    local startTime = tick()
    local updateConnection
    
    updateConnection = game:GetService("RunService").Heartbeat:Connect(function()
        local elapsed = tick() - startTime
        local progress = math.min(elapsed / exercise.duration, 1)
        
        -- Update UI progress jika ada
        if _G.ExerciseProgressBar then
            _G.ExerciseProgressBar.Bar.Size = UDim2.new(progress, 0, 1, 0)
        end
        
        if elapsed >= exercise.duration then
            updateConnection:Disconnect()
            
            -- Add stats
            if exercise.strengthGain then
                PlayerData.Stats.Strength = PlayerData.Stats.Strength + exercise.strengthGain
            end
            if exercise.speedGain then
                PlayerData.Stats.Speed = PlayerData.Stats.Speed + exercise.speedGain
            end
            if exercise.enduranceGain then
                PlayerData.Stats.Endurance = PlayerData.Stats.Endurance + exercise.enduranceGain
            end
            if exercise.focusGain then
                PlayerData.Stats.Focus = PlayerData.Stats.Focus + exercise.focusGain
            end
            
            PlayerData.Money = PlayerData.Money + exercise.moneyGain
            PlayerData.Experience = PlayerData.Experience + 10
            PlayerData.IsExercising = false
            
            print("🎉 Latihan selesai! +" .. exercise.moneyGain .. "💰")
            
            if _G.updateStatsUI then
                _G.updateStatsUI()
            end
        end
    end)
end

-- 🐛 PET SYSTEM (Glitch Bot)
local PetSystem = {}

local PetStats = {
    Name = "🐛 Glitch Bot",
    Level = 1,
    Health = 100,
    Damage = 10,
    FollowDistance = 15,
    IsAttacking = false,
}

function PetSystem.punchStone()
    if PetStats.IsAttacking then
        print("⏳ Pet sedang menyerang...")
        return
    end
    
    PetStats.IsAttacking = true
    print("💥 " .. PetStats.Name .. " memukul batu!")
    
    local xpGain = 5
    local moneyGain = 10
    
    PlayerData.Money = PlayerData.Money + moneyGain
    PlayerData.Experience = PlayerData.Experience + xpGain
    PetStats.Level = math.floor(PlayerData.Experience / 50) + 1
    PetStats.Damage = 10 + (PetStats.Level * 2)
    
    print("✨ XP: +" .. xpGain .. " | 💰 Money: +" .. moneyGain)
    print("🐛 Pet Level: " .. PetStats.Level .. " | Damage: " .. PetStats.Damage)
    
    wait(2)
    PetStats.IsAttacking = false
    
    if _G.updateStatsUI then
        _G.updateStatsUI()
    end
end

-- 🎮 MAIN UI SYSTEM
local UISystem = {}

function UISystem.createMainUI()
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    -- Main Container
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MuscleLegendsUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    -- Background
    local mainBG = Utils.createNeonFrame(screenGui, "MainBG", UDim2.new(0.3, 0, 0.8, 0), UDim2.new(0.02, 0, 0.1, 0), GameConfig.Colors.Cyan)
    
    -- Title
    Utils.createNeonText(mainBG, "Title", "💪 MUSCLE LEGENDS", UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, 5), GameConfig.Colors.Magenta)
    
    -- Player Stats Container
    local statsContainer = Utils.createNeonFrame(mainBG, "StatsContainer", UDim2.new(1, -20, 0, 180), UDim2.new(0, 10, 0, 50), GameConfig.Colors.Purple)
    
    -- Money Display
    local moneyLabel = Utils.createNeonText(statsContainer, "Money", "💰 Money: " .. Utils.formatNumber(PlayerData.Money), UDim2.new(1, 0, 0, 30), UDim2.new(0, 10, 0, 10), GameConfig.Colors.Green)
    
    -- Level Display
    local levelLabel = Utils.createNeonText(statsContainer, "Level", "⭐ Level: " .. PlayerData.Level, UDim2.new(1, 0, 0, 30), UDim2.new(0, 10, 0, 45), GameConfig.Colors.Cyan)
    
    -- Stats Display
    local strengthLabel = Utils.createNeonText(statsContainer, "Strength", "💪 Strength: " .. math.floor(PlayerData.Stats.Strength), UDim2.new(1, 0, 0, 25), UDim2.new(0, 10, 0, 80), GameConfig.Colors.Cyan)
    local speedLabel = Utils.createNeonText(statsContainer, "Speed", "⚡ Speed: " .. math.floor(PlayerData.Stats.Speed), UDim2.new(1, 0, 0, 25), UDim2.new(0, 10, 0, 105), GameConfig.Colors.Cyan)
    local enduranceLabel = Utils.createNeonText(statsContainer, "Endurance", "🔥 Endurance: " .. math.floor(PlayerData.Stats.Endurance), UDim2.new(1, 0, 0, 25), UDim2.new(0, 10, 0, 130), GameConfig.Colors.Cyan)
    local focusLabel = Utils.createNeonText(statsContainer, "Focus", "🧠 Focus: " .. math.floor(PlayerData.Stats.Focus), UDim2.new(1, 0, 0, 25), UDim2.new(0, 10, 0, 155), GameConfig.Colors.Cyan)
    
    -- Exercise Buttons Container
    local buttonsContainer = Utils.createNeonFrame(mainBG, "ButtonsContainer", UDim2.new(1, -20, 0, 280), UDim2.new(0, 10, 0, 250), GameConfig.Colors.Magenta)
    
    Utils.createNeonText(buttonsContainer, "ExerciseTitle", "🏋️ LATIHAN", UDim2.new(1, 0, 0, 25), UDim2.new(0, 10, 0, 10), GameConfig.Colors.Green)
    
    -- Dumbbell Button
    Utils.createNeonButton(buttonsContainer, "DumbbellBtn", "🏋️ Dumbbell", UDim2.new(0.45, 0, 0, 40), UDim2.new(0, 10, 0, 45), function()
        ExerciseSystem.startExercise("Dumbbell")
    end)
    
    -- Running Button
    Utils.createNeonButton(buttonsContainer, "RunningBtn", "🏃 Running", UDim2.new(0.45, 0, 0, 40), UDim2.new(0.5, 0, 0, 45), function()
        ExerciseSystem.startExercise("Running")
    end)
    
    -- Push-ups Button
    Utils.createNeonButton(buttonsContainer, "PushUpsBtn", "💪 Push-ups", UDim2.new(0.45, 0, 0, 40), UDim2.new(0, 10, 0, 95), function()
        ExerciseSystem.startExercise("PushUps")
    end)
    
    -- Meditation Button
    Utils.createNeonButton(buttonsContainer, "MeditationBtn", "🧘 Meditation", UDim2.new(0.45, 0, 0, 40), UDim2.new(0.5, 0, 0, 95), function()
        ExerciseSystem.startExercise("Meditation")
    end)
    
    -- Exercise Progress Bar
    local progressContainer, progressBar = Utils.createNeonFrame(buttonsContainer, "ProgressContainer", UDim2.new(1, -20, 0, 20), UDim2.new(0, 10, 0, 145)), nil
    progressContainer.BackgroundColor3 = GameConfig.Colors.LighterBG
    local stroke = Instance.new("UIStroke")
    stroke.Color = GameConfig.Colors.Cyan
    stroke.Thickness = 1
    stroke.Parent = progressContainer
    
    progressBar = Instance.new("Frame")
    progressBar.Name = "Bar"
    progressBar.Size = UDim2.new(0, 0, 1, 0)
    progressBar.BackgroundColor3 = GameConfig.Colors.Green
    progressBar.BorderSizePixel = 0
    progressBar.Parent = progressContainer
    
    _G.ExerciseProgressBar = progressContainer
    
    -- Pet Section
    local petContainer = Utils.createNeonFrame(mainBG, "PetContainer", UDim2.new(1, -20, 0, 100), UDim2.new(0, 10, 0, 545), GameConfig.Colors.Purple)
    
    Utils.createNeonText(petContainer, "PetTitle", "🐛 PET SYSTEM", UDim2.new(1, 0, 0, 20), UDim2.new(0, 10, 0, 5), GameConfig.Colors.Green)
    Utils.createNeonText(petContainer, "PetName", PetStats.Name .. " | Lvl: " .. PetStats.Level, UDim2.new(1, 0, 0, 20), UDim2.new(0, 10, 0, 30), GameConfig.Colors.Cyan)
    Utils.createNeonText(petContainer, "PetDamage", "⚔️ Damage: " .. PetStats.Damage, UDim2.new(1, 0, 0, 20), UDim2.new(0, 10, 0, 55), GameConfig.Colors.Cyan)
    
    -- Stone Punch Button
    Utils.createNeonButton(petContainer, "PunchStoneBtn", "💥 Pukul Batu", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, 65), function()
        PetSystem.punchStone()
    end)
    
    -- Update Stats UI Function
    _G.updateStatsUI = function()
        moneyLabel.Text = "💰 Money: " .. Utils.formatNumber(PlayerData.Money)
        levelLabel.Text = "⭐ Level: " .. PlayerData.Level
        strengthLabel.Text = "💪 Strength: " .. math.floor(PlayerData.Stats.Strength)
        speedLabel.Text = "⚡ Speed: " .. math.floor(PlayerData.Stats.Speed)
        enduranceLabel.Text = "🔥 Endurance: " .. math.floor(PlayerData.Stats.Endurance)
        focusLabel.Text = "🧠 Focus: " .. math.floor(PlayerData.Stats.Focus)
        PlayerData.Level = math.floor(PlayerData.Experience / 50) + 1
    end
    
    print("✅ UI telah dibuat!")
end

-- 🚀 START GAME
print("\n" .. string.rep("=", 50))
print("💪 MUSCLE LEGENDS - CYBERPUNK EDITION 💪")
print(string.rep("=", 50))
print("🎮 Loading game...")

wait(1)
UISystem.createMainUI()

print("✅ Game sudah siap dimulai!")
print("📊 Command untuk testing:")
print("  - ExerciseSystem.startExercise('Dumbbell')")
print("  - PetSystem.punchStone()")
print("  - print(PlayerData)")
print("\n")