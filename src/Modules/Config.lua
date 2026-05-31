-- ⚙️ MUSCLE LEGENDS CONFIG
local Config = {}

-- 💰 Currency Settings
Config.Currency = {
	StartingMoney = 100,
	MoneyPerExercise = 10,
	MoneyPerStone = 5,
}

-- 📊 Stats Settings
Config.Stats = {
	Strength = { baseGain = 1, max = 999 },
	Speed = { baseGain = 0.5, max = 999 },
	Endurance = { baseGain = 0.75, max = 999 },
	Focus = { baseGain = 0.5, max = 999 },
}

-- 🏋️ Exercise Settings
Config.Exercises = {
	Dumbbell = {
		name = "Dumbbell",
		duration = 5,
		strengthGain = 2,
		enduranceGain = 1,
		cooldown = 2,
	},
	Running = {
		name = "Running",
		duration = 5,
		speedGain = 2,
		enduranceGain = 1.5,
		cooldown = 2,
	},
	PushUps = {
		name = "Push-ups",
		duration = 5,
		strengthGain = 1.5,
		enduranceGain = 2,
		cooldown = 2,
	},
	Meditation = {
		name = "Meditation",
		duration = 5,
		focusGain = 2,
		enduranceGain = 0.5,
		cooldown = 2,
	},
}

-- 🐛 Pet Settings
Config.Pet = {
	Name = "Glitch Bot",
	FollowDistance = 10,
	DamagePerHit = 5,
	AttackCooldown = 1,
	PunchXP = 3,
}

-- 🎨 UI Settings
Config.UI = {
	PrimaryColor = Color3.fromRGB(0, 255, 255), -- Cyan
	SecondaryColor = Color3.fromRGB(255, 0, 255), -- Magenta
	BackgroundColor = Color3.fromRGB(15, 15, 35), -- Dark
	AccentColor = Color3.fromRGB(0, 255, 100), -- Green
	TextColor = Color3.fromRGB(255, 255, 255), -- White
}

-- 📈 Level Settings
Config.Leveling = {
	BaseXPRequired = 100,
	XPMultiplier = 1.2,
	MaxLevel = 100,
}

return Config