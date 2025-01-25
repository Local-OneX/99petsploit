---@LocalOnex
---TODO: Extract entire map to your workspace folder.

map = map or workspace:FindFirstChild("Map")
map = map or workspace:FindFirstChild("Map2")
map = map or workspace:FindFirstChild("Map3")

synsaveinstance = loadstring(game:HttpGet("https://raw.githubusercontent.com/luau/SynSaveInstance/main/saveinstance.luau", true), "saveinstance")()

player = game.Players.LocalPlayer
character = player.Character
rootPart = character.Humanoid:FindFirstChild("HumanoidRootPart")
zonesFolder = Instance.new("Folder")  
BUFFER_DELTA = .1

warn("Initilizing")
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
	
	local object = v:Clone()
	object.Parent = zonesFolder
	
	synsaveinstance {
		Object = object,
		FilePath = object.Name
	}
	
	print(string.format("Successfully extracted %s", v.Name))
	task.wait(BUFFER_DELTA)
end

synsaveinstance {
	Object = zonesFolder,
	FilePath = map.Name.."_EXTRACTED"
}

print(string.format("Successfully extracted %s", "Map")) 
