--TODO: Initilize ps99 modules to work on Solara executor, because Solara doesn't support `require`.

local Network = {}

local function _getRemote(remoteName)
	local remote = game.ReplicatedStorage:WaitForChild("Network"):WaitForChild(remoteName)
	
	return remote
end 
