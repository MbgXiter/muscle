-- 🎨 CYBERPUNK THEME & UI STYLING
local CyberpunkTheme = {}

CyberpunkTheme.Colors = {
	Cyan = Color3.fromRGB(0, 255, 255),
	Magenta = Color3.fromRGB(255, 0, 255),
	Purple = Color3.fromRGB(150, 100, 255),
	DarkBG = Color3.fromRGB(15, 15, 35),
	LighterBG = Color3.fromRGB(30, 30, 60),
	Green = Color3.fromRGB(0, 255, 100),
	Red = Color3.fromRGB(255, 50, 50),
	Orange = Color3.fromRGB(255, 150, 0),
	White = Color3.fromRGB(255, 255, 255),
}

-- Create neon frame with glow
function CyberpunkTheme.createNeonFrame(parent, name, size, position)
	local frame = Instance.new("Frame")
	frame.Name = name
	frame.Size = size
	frame.Position = position
	frame.BackgroundColor3 = CyberpunkTheme.Colors.DarkBG
	frame.BorderSizePixel = 0
	frame.Parent = parent
	
	-- Add stroke for neon effect
	local stroke = Instance.new("UIStroke")
	stroke.Color = CyberpunkTheme.Colors.Cyan
	stroke.Thickness = 2
	stroke.Parent = frame
	
	return frame
end

-- Create neon text label
function CyberpunkTheme.createNeonText(parent, name, text, size, position, color)
	local label = Instance.new("TextLabel")
	label.Name = name
	label.Text = text
	label.Size = size
	label.Position = position
	label.BackgroundTransparency = 1
	label.TextColor3 = color or CyberpunkTheme.Colors.Cyan
	label.TextScaled = true
	label.Font = Enum.Font.GothamBold
	label.Parent = parent
	
	return label
end

-- Create neon button
function CyberpunkTheme.createNeonButton(parent, name, text, size, position)
	local button = Instance.new("TextButton")
	button.Name = name
	button.Text = text
	button.Size = size
	button.Position = position
	button.BackgroundColor3 = CyberpunkTheme.Colors.LighterBG
	button.TextColor3 = CyberpunkTheme.Colors.Cyan
	button.Font = Enum.Font.GothamBold
	button.BorderSizePixel = 0
	button.Parent = parent
	
	-- Add stroke
	local stroke = Instance.new("UIStroke")
	stroke.Color = CyberpunkTheme.Colors.Magenta
	stroke.Thickness = 2
	stroke.Parent = button
	
	-- Hover effect
	button.MouseEnter:Connect(function()
		stroke.Color = CyberpunkTheme.Colors.Green
	end)
	
	button.MouseLeave:Connect(function()
		stroke.Color = CyberpunkTheme.Colors.Magenta
	end)
	
	return button
end

-- Create progress bar with neon effect
function CyberpunkTheme.createNeonProgressBar(parent, name, size, position)
	local container = Instance.new("Frame")
	container.Name = name
	container.Size = size
	container.Position = position
	container.BackgroundColor3 = CyberpunkTheme.Colors.LighterBG
	container.BorderSizePixel = 0
	container.Parent = parent
	
	local stroke = Instance.new("UIStroke")
	stroke.Color = CyberpunkTheme.Colors.Cyan
	stroke.Thickness = 1
	stroke.Parent = container
	
	local bar = Instance.new("Frame")
	bar.Name = "Bar"
	bar.Size = UDim2.new(0.5, 0, 1, 0)
	bar.Position = UDim2.new(0, 0, 0, 0)
	bar.BackgroundColor3 = CyberpunkTheme.Colors.Green
	bar.BorderSizePixel = 0
	bar.Parent = container
	
	return container, bar
end

return CyberpunkTheme