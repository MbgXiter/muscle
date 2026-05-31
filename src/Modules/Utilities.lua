-- 🛠️ UTILITY FUNCTIONS
local Utilities = {}

-- Format number with commas
function Utilities.formatNumber(num)
	if num >= 1000000 then
		return string.format("%.1fM", num / 1000000)
	elseif num >= 1000 then
		return string.format("%.1fK", num / 1000)
	else
		return tostring(math.floor(num))
	end
end

-- Create tween animation
function Utilities.createTween(instance, duration, properties)
	local tweenInfo = TweenInfo.new(
		duration,
		Enum.EasingStyle.Quad,
		Enum.EasingDirection.InOut
	)
	local tween = game:GetService("TweenService"):Create(instance, tweenInfo, properties)
	return tween
end

-- Create neon glow effect
function Utilities.createNeonGlow(part, color)
	part.Material = Enum.Material.Neon
	part.Color = color
end

-- Clamp value between min and max
function Utilities.clamp(value, min, max)
	if value < min then return min end
	if value > max then return max end
	return value
end

-- Get random number between range
function Utilities.randomBetween(min, max)
	return math.random(min, max)
end

-- Wait with timeout
function Utilities.waitWithTimeout(duration)
	wait(duration)
end

return Utilities