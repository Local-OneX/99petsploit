---@LocalOnex
---Make sure to stop library from loading
---TODO: Extract entire map to your workspace folder. 

map = map or workspace:FindFirstChild("Map")
map = map or workspace:FindFirstChild("Map2")
map = map or workspace:FindFirstChild("Map3")

synsaveinstance = loadstring(game:HttpGet("https://raw.githubusercontent.com/luau/SynSaveInstance/main/saveinstance.luau", true), "saveinstance")()

player = game.Players.LocalPlayer
character = player.Character
rootPart = character:FindFirstChild("HumanoidRootPart")
torso = player.Character:FindFirstChild("UpperTorso")
zonesFolder = workspace.ALWAYS_RENDERING:Clone()
zonesFolder.Name = map.Name
zonesFolder:ClearAllChildren()
BUFFER_DELTA = 1.5
SAVE_INDIVIDUAL = false

workspace.StreamingEnabled = false
torso.Anchored = true

warn("Initilizing")
warn(string.format("This will take ≈%s seconds!", #map:GetChildren() * BUFFER_DELTA))
extracted = 0
for i, v in ipairs(map:GetChildren()) do

	local pos;
	if v:FindFirstChild("SPAWNS") then
		pos = v:FindFirstChild("SPAWNS"):FindFirstChild("Spawn").Position
	elseif v:FindFirstChild("PERSISTENT") then
		pos =  v:FindFirstChild("PERSISTENT"):FindFirstChild("Teleport").Position
	elseif v:FindFirstChild("GROUND") then
		pos = v:FindFirstChild("GROUND"):FindFirstChild("Ground").Position
	end

	if not pos then
		warn(string.format("Couldn't save %s", v.Name))
		continue
	end

	character:PivotTo(CFrame.new(pos)) 
	local object = v:Clone()
	object.Parent = zonesFolder

	if SAVE_INDIVIDUAL then
		synsaveinstance {
			Object = object, 
		}
	end

	extracted += 1

	print(string.format("Successfully extracted %s ≈%s seconds left.", v.Name, (#map:GetChildren() - extracted) * BUFFER_DELTA))
	task.wait(BUFFER_DELTA)
end

torso.Anchored = false 
synsaveinstance {
	Object = zonesFolder, 
}

print(string.format("Successfully extracted %s", map.Name)) 
