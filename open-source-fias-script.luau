getgenv().gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local searchString = "fight in a school"
if not string.find(string.lower(getgenv().gameName), string.lower(searchString)) then
    game.Players.LocalPlayer:Kick("Incorrect game!")
end

getgenv().executor = identifyexecutor()
if string.match(getgenv().executor, "Xeno") or string.match(getgenv().executor, "Solara") then
    game.Players.LocalPlayer:Kick("Unsupported Executor!")
    return
end

print("SCRIPT RAN!!")

--FIGHT IN A SCHOOL

local TeleportService = game:GetService("TeleportService")
local httpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local camera = workspace.CurrentCamera

local servers1 = {}
local servers2 = {}

local whitelistedPlayers = {}
local givenwhitelistedPlayers = {}
local aurawhitelistedplayers = {}
local oldaurawhitelistedplayers = {}
local spraywhitelistedplayers = {}

local playersToKill = {}

local ThrowPlayerKeybind
local SPEEDBOOST
local noclip1 
local ToggleGrabPlayers
local GrabOject
local DuelsFolder = game.workspace:WaitForChild("Duels")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local interface = LocalPlayer:WaitForChild("Communicate"):WaitForChild("Interface")
local teleportRemote = interface:WaitForChild("RemoteEvent")
local remoteFunction = interface:WaitForChild("RemoteFunction")
local Main = PlayerGui:WaitForChild("Main")
local Notifications = Main:WaitForChild("Notifications")
local ChatGui = Main:WaitForChild("Chat")
local Main2 = ChatGui:WaitForChild("Main")
local Core = Main2:WaitForChild("Core")
local CanvasGroup = Core:WaitForChild("CanvasGroup")
local ChatList = CanvasGroup:WaitForChild("List")
local mouse = LocalPlayer:GetMouse()
local emotes = game:GetService("ReplicatedStorage").Animations.Emotes
local KillFarm
local AttackAura
local AutoShove
local OldAura 

usernames = {
    "itseasttt",
    "motionfemale",
    "ImRated1K",
    "RealBasedH",
    "WhosMuerte",
    "LukieeSZN",
    "Colbionys",
    "ImOzzyKnows",
    "Lerksyyz",
    "notmwadd",
    "wtwowen",
    "YTverowtv",
    "ZhykirFilmedIt",
    "GloveHats",
    "TheFroppi",
    "REALDAYGOBABY",
    "AJDaHollow",
    "TrippinZee",
    "ItsFlexico",
    "Wittyyb",
    "FightnMyRelapse"
}

VK = {
    ["A"] = 0x41, ["B"] = 0x42, ["C"] = 0x43, ["D"] = 0x44,
    ["E"] = 0x45, ["F"] = 0x46, ["G"] = 0x47, ["H"] = 0x48,
    ["I"] = 0x49, ["J"] = 0x4A, ["K"] = 0x4B, ["L"] = 0x4C,
    ["M"] = 0x4D, ["N"] = 0x4E, ["O"] = 0x4F, ["P"] = 0x50,
    ["Q"] = 0x51, ["R"] = 0x52, ["S"] = 0x53, ["T"] = 0x54,
    ["U"] = 0x55, ["V"] = 0x56, ["W"] = 0x57, ["X"] = 0x58,
    ["Y"] = 0x59, ["Z"] = 0x5A,
    ["a"] = 0x41, ["b"] = 0x42, ["c"] = 0x43, ["d"] = 0x44,
    ["e"] = 0x45, ["f"] = 0x46, ["g"] = 0x47, ["h"] = 0x48,
    ["i"] = 0x49, ["j"] = 0x4A, ["k"] = 0x4B, ["l"] = 0x4C,
    ["m"] = 0x4D, ["n"] = 0x4E, ["o"] = 0x4F, ["p"] = 0x50,
    ["q"] = 0x51, ["r"] = 0x52, ["s"] = 0x53, ["t"] = 0x54,
    ["u"] = 0x55, ["v"] = 0x56, ["w"] = 0x57, ["x"] = 0x58,
    ["y"] = 0x59, ["z"] = 0x5A,

    ["0"] = 0x30, ["1"] = 0x31, ["2"] = 0x32, ["3"] = 0x33,
    ["4"] = 0x34, ["5"] = 0x35, ["6"] = 0x36, ["7"] = 0x37,
    ["8"] = 0x38, ["9"] = 0x39,

    ["_"] = { vk = 0xBD, shift = true },
}

VK_SHIFT = 0x10 
OPENCMD = 0x222

function typeChar(c)
    local entry = VK[c]
    if not entry then
        warn("Character not supported:", c)
        return
    end

    local vk, needShift

    if type(entry) == "table" then
        vk = entry.vk
        needShift = entry.shift
    else
        vk = entry
        needShift = false
    end

    if needShift then
        keypress(VK_SHIFT)
        task.wait(0.02)
    end

    keypress(vk)
    if keyrelease then keyrelease(vk) end

    if needShift then
        if keyrelease then keyrelease(VK_SHIFT) end
    end
end

function typeExclamation()
    keypress(0x10)
    keypress(0x31)
    keyrelease(0x31)  
    keyrelease(0x10)
end

JoinString = "join"

function typeJoin()
	for c in JoinString:gmatch(".") do
		typeChar(c)
	end
end

getgenv().hookedFunctions = getgenv().hookedFunctions or {}

local function tryHook(func)
    if type(func) ~= "function" then return end
    if getgenv().hookedFunctions[func] then return end

    local ok, info = pcall(debug.getinfo, func)
    if not ok or not info then return end

    if info.name == "UpdateStruggle" then
        getgenv().hookedFunctions[func] = true
        hookfunction(func, function() return end)
    end
end

wait(3)

for _, func in ipairs(getgc(true)) do
    tryHook(func)
end

LocalPlayer.CharacterAdded:Connect(function(char)
    local oldValue = KillFarm.CurrentValue
    local oldValue2 = AttackAura.CurrentValue
    local oldValue3 = OldAura.CurrentValue
    local oldValue4 = AutoShove.CurrentValue

    KillFarm:Set(false)
    AttackAura:Set(false)
    OldAura:Set(false)
    AutoShove:Set(false)


    local core = char:WaitForChild("Core", 3)
    if core then
        task.wait(6)
        for _, func in ipairs(getgc(true)) do
            tryHook(func)
        end
        task.wait(1)
        KillFarm:Set(oldValue)
        AttackAura:Set(oldValue2)
        OldAura:Set(oldValue3)
        AutoShove:Set(oldValue4)
    end
end)

local Config = {
    Sensitivity = 0.3,
    MinPitch = -80,
    MaxPitch = 80,
    CameraDistance = 12,
    VerticalOffset = 2,
}

Config.MinPitch = math.rad(Config.MinPitch)
Config.MaxPitch = math.rad(Config.MaxPitch)

local yaw = 0
local pitch = 0
local isCameraMovementActive = false

local function onInputChanged(input, gameProcessedEvent)
    if not isCameraMovementActive or gameProcessedEvent then return end

    if input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Delta
        
        yaw = yaw - delta.X * math.rad(Config.Sensitivity)
        pitch = pitch - delta.Y * math.rad(Config.Sensitivity)
        
        pitch = math.clamp(pitch, Config.MinPitch, Config.MaxPitch)
    end
end

local function onInputBegan(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        isCameraMovementActive = true
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
    end
end

local function onInputEnded(input, gameProcessedEvent)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        isCameraMovementActive = false
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    end
end

local function onRenderStep()
    local character = LocalPlayer.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")

    if not rootPart then return end
    
    camera.CameraType = Enum.CameraType.Scriptable
    
    local focalPoint = rootPart.Position + Vector3.new(0, Config.VerticalOffset, 0)
    
    local rotation = CFrame.Angles(0, yaw, 0) * CFrame.Angles(pitch, 0, 0)
    
    local position = focalPoint + rotation:VectorToWorldSpace(Vector3.new(0, 0, Config.CameraDistance))
    
    camera.CFrame = CFrame.new(position, focalPoint)
end

local function setupCamera()
    camera.CameraType = Enum.CameraType.Scriptable
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
end

setupCamera()

UserInputService.InputChanged:Connect(onInputChanged)
UserInputService.InputBegan:Connect(onInputBegan)
UserInputService.InputEnded:Connect(onInputEnded)
RunService.RenderStepped:Connect(onRenderStep)

LocalPlayer.CharacterAdded:Connect(function(character)
    setupCamera()
end)

local function getUserIdFromName(username)
    local success, userID = pcall(function()
        return Players:GetUserIdFromNameAsync(username)
    end)
    if success then
        return userID
    end
end

local function getRemote()
    local character = LocalPlayer.Character
    if not character then return end

    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local rightHand = character:FindFirstChild("RightHand")
    local core = character:FindFirstChild("Core")
    if not rootPart or not rightHand or not core then return end

    return core:FindFirstChild("Communicate"):FindFirstChildOfClass("RemoteEvent")
end

getgenv().attackGUIDs = getgenv().attackGUIDs or {}

local httpService = game:GetService("HttpService")

local function attack(user, attackType)
    if not user or not user.Character then return end
    local re = getRemote()
    if not re then return end

    local head = user.Character:FindFirstChild("Head")
    if not head then return end
    local pointHead = head.Position

    local res = workspace:Raycast(
        head.Parent.HumanoidRootPart.Position,
        (head.Parent.UpperTorso.Position - head.Parent.HumanoidRootPart.Position).Unit * 100,
        RaycastParams.new()
    )

    local guid = httpService:GenerateGUID(true)
    table.insert(getgenv().attackGUIDs, guid)

    task.spawn(function()
        if attackType == "POSTER_HIT" then
            re:FireServer(attackType, {
                Hit = head,
                Character = head.Parent,
                Limb = "RightHand",
                Point = pointHead,
            })
        elseif attackType == "Slam" then
            re:FireServer("Slam", {
                Character = head.Parent,
                Point = pointHead,
                Hit = head,
                Limb = "",
                Classs = guid,
                Result = res,
            })
            re:FireServer("Struggle", nil, nil, true)
        else
            re:FireServer(attackType, {
                Point = pointHead,
                Combo = 1,
                IsKnockdown = false,
                Class = LocalPlayer.leaderstats.Class.Value,
                Character = head.Parent,
                Hit = head,
                Limb = "RightHand",
                Classs = guid,            
            })
            re:FireServer("Struggle", nil, nil, true)
        end
    end)
end


local lastGrabbedPlayer = nil
local inputConnection = nil

local function release()
	if not lastGrabbedPlayer then
		return
	end

	if inputConnection then
		inputConnection:Disconnect()
		inputConnection = nil
	end

	if lastGrabbedPlayer.Character then
		local remote = getRemote()
		remote:FireServer("Throw", {
			Object = lastGrabbedPlayer.Character,
            Type = GrabOject.CurrentOption[1]
		})
	end
	lastGrabbedPlayer = nil
end

local function grab(targetUser)
	release()

	if not targetUser or not targetUser.Character or targetUser == LocalPlayer then
		return
	end

	lastGrabbedPlayer = targetUser

	local remote = getRemote()

	remote:FireServer("Pickup", {
		Object = targetUser.Character,
		Type = GrabOject.CurrentOption[1]
	}, false)

	local character = targetUser.Character
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		humanoid.Died:Once(function()
			if lastGrabbedPlayer == targetUser then
				release()
			end
		end)
	end
	
	targetUser.CharacterAdded:Once(function(newCharacter)
		if lastGrabbedPlayer == targetUser then
			release()
		end
	end)

	inputConnection = UserInputService.InputBegan:Connect(function(key, gameProcessedEvent)
		if gameProcessedEvent then return end

		if key.KeyCode == Enum.KeyCode[ThrowPlayerKeybind.CurrentKeybind] then
			if lastGrabbedPlayer and lastGrabbedPlayer.Character then
				remote:FireServer("Throw", {
					Object = lastGrabbedPlayer.Character,
					Type = GrabOject.CurrentOption[1]
				}, false)
                lastGrabbedPlayer = nil
			end
		end
	end)
end

LocalPlayer.CharacterAdded:Connect(function(newChar)
	release()
end)

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
Name = "l10 FIAS SCRIPT",
Icon = 0, 
LoadingTitle = "Loading...",
LoadingSubtitle = "by Luto",
ShowText = "Luto Scripts", 
Theme = "Default", 

ToggleUIKeybind = "K",

DisableRayfieldPrompts = true,
DisableBuildWarnings = true, 

ConfigurationSaving = {
    Enabled = true,
    FolderName = "FIASLUTOSCRIPT", 
    FileName = "config"
},

Discord = {
    Enabled = false, 
    Invite = "noinvitelink", 
    RememberJoins = true 
},
})

local CombatTab      = Window:CreateTab("Combat")
local PlayersTab     = Window:CreateTab("Players")
local MovementTab    = Window:CreateTab("Movement")
local AutoFarmTab    = Window:CreateTab("Auto Farm")
local EventsTab      = Window:CreateTab("Events")
local ServerMiscTab  = Window:CreateTab("Server / Misc")
local SettingsTab    = Window:CreateTab("Settings")

local ThemesList = SettingsTab:CreateDropdown({
Name = "Themes",
Options = {"Default","AmberGlow","Amethyst","Bloom","DarkBlue","Green","Light","Ocean","Serenity"},
CurrentOption = {"Default"},
MultipleOptions = false,
Flag = "ThemesList1", 
Callback = function(Options)
        Window.ModifyTheme(Options[1])
        Rayfield:Notify({ Title = "SCRIPT", Content = "Changed theme to: "..Options[1], Duration = 2})
end,
})

local Divider122225 = SettingsTab:CreateDivider() 

getgenv().Label = CombatTab:CreateLabel("Wait 6 seconds before using killfarm, autoshove, oldaura, attackaura after death to prevent anticheat kicks", "rewind")

getgenv().Divider1222225 = CombatTab:CreateDivider() 

local GodAura = CombatTab:CreateToggle({
Name = "God Aura",
CurrentValue = false,
Flag = "GodAura1",
Callback = function(value)
    if value == true then
        Rayfield:Notify({ Title = "GOD AURA", Content = "ENABLED", Duration = 2})
    else
        Rayfield:Notify({ Title = "GOD AURA", Content = "DISABLED", Duration = 2})
    end
end
})

local GodAuraRange = CombatTab:CreateSlider({
Name = "God Aura Range",
Range = {1, 380},
Increment = 1,
Suffix = "M",
CurrentValue = 10,
Flag = "GodAuraRange1", 
Callback = function()
    
end
})

local GodAuraSpeed = CombatTab:CreateSlider({
Name = "God Aura Speed",
Range = {0, 10},
Increment = 0.01,
Suffix = "s",
CurrentValue = 0.05,
Flag = "GodAuraSpeed1", 
Callback = function()
        
end
})

local oringalAttackSpeed = CombatTab:CreateButton({
Name = "Return God Aura Speed",
Callback = function()
        GodAuraSpeed:Set(0.05)
Rayfield:Notify({ Title = "GOD AURA", Content = "RETURNED TO ORINGAL", Duration = 2})
end,
})

local IngoreHP = CombatTab:CreateToggle({
    Name = "Ingore HP",
    CurrentValue = false,
    Flag = "IngoreHP1",
    Callback = function(value)
        if value then
            Rayfield:Notify({ Title = "IGNORE HP", Content = "ENABLED", Duration = 2})
        else
            Rayfield:Notify({ Title = "IGNORE HP", Content = "DISABLED", Duration = 2})
        end
    end
})

local WhitelistedUsers = CombatTab:CreateParagraph({
    Title = "Whitelisted Users:", 
    Content = "None"
})

local WhitelistUserInput = CombatTab:CreateInput({
    Name = "Add to Whitelist",
    Default = "",
    PlaceholderText = "type display/user",
    RemoveTextAfterFocusLost = true,
    Flag = "WhitelistUsers1",
    Callback = function(Text)
        for i, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer then
                if v.Name:lower():find(Text:lower(), 1, true) or v.DisplayName:lower():find(Text:lower(), 1, true) then
                    if not table.find(whitelistedPlayers, v.DisplayName) then
                        table.insert(whitelistedPlayers, v.DisplayName)
                        
                        WhitelistedUsers:Set({
                            Title = "Whitelisted Users:",
                            Content = table.concat(whitelistedPlayers, ", ")
                        })
                        
                        Rayfield:Notify({ Title = "WHITELIST", Content = "Added: "..v.DisplayName.." to whitelist", Duration = 2})
                        break
                    end
                end
            end
        end
    end,
})

local RemoveWhitelistInput = CombatTab:CreateInput({
    Name = "Remove from Whitelist",
    Default = "",
    PlaceholderText = "type display/user",
    RemoveTextAfterFocusLost = true,
    Flag = "BlacklistUsers1",
    Callback = function(Text)
        local playerNameToRemove = nil
        for i, v in pairs(Players:GetPlayers()) do
            if v.Name:lower():find(Text:lower(), 1, true) or v.DisplayName:lower():find(Text:lower(), 1, true) then
                playerNameToRemove = v.DisplayName
                break
            end
        end

        if playerNameToRemove then
            local index = table.find(whitelistedPlayers, playerNameToRemove)
            if index then
                table.remove(whitelistedPlayers, index)

                local newContent = #whitelistedPlayers > 0 and table.concat(whitelistedPlayers, ", ") or "None"
                
                WhitelistedUsers:Set({
                    Title = "Whitelisted Users:",
                    Content = newContent
                })

                Rayfield:Notify({ Title = "WHITELIST", Content = "Removed :"..playerNameToRemove.." from whitelist", Duration = 2})
            end
        end
    end,
})

local Divider1 = CombatTab:CreateDivider()

AttackAura = CombatTab:CreateToggle({
Name = "Attack Aura",
CurrentValue = false,
Flag = "AttackAura1",
Callback = function(value)
    if value == true then
        Rayfield:Notify({ Title = "ATTACK AURA", Content = "ENABLED", Duration = 2})
    else
        Rayfield:Notify({ Title = "ATTACK AURA", Content = "DISABLED", Duration = 2})
    end
end
})

local WhitelistedUsers35 = CombatTab:CreateParagraph({
    Title = "Whitelisted Users:", 
    Content = "None"
})

local WhitelistUserInput35 = CombatTab:CreateInput({
    Name = "Add to Whitelist",
    Default = "",
    PlaceholderText = "type display/user",
    RemoveTextAfterFocusLost = true,
    Flag = "WhitelistUsers1",
    Callback = function(Text)
        for i, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer then
                if v.Name:lower():find(Text:lower(), 1, true) or v.DisplayName:lower():find(Text:lower(), 1, true) then
                    if not table.find(aurawhitelistedplayers, v.DisplayName) then
                        table.insert(aurawhitelistedplayers, v.DisplayName)
                        
                        WhitelistedUsers35:Set({
                            Title = "Whitelisted Users:",
                            Content = table.concat(aurawhitelistedplayers, ", ")
                        })
                        
                        Rayfield:Notify({ Title = "WHITELIST", Content = "Added: "..v.DisplayName.." to whitelist", Duration = 2})
                        break
                    end
                end
            end
        end
    end,
})

local RemoveWhitelistInput35 = CombatTab:CreateInput({
    Name = "Remove from Whitelist",
    Default = "",
    PlaceholderText = "type display/user",
    RemoveTextAfterFocusLost = true,
    Flag = "BlacklistUsers1",
    Callback = function(Text)
        local playerNameToRemove = nil
        for i, v in pairs(Players:GetPlayers()) do
            if v.Name:lower():find(Text:lower(), 1, true) or v.DisplayName:lower():find(Text:lower(), 1, true) then
                playerNameToRemove = v.DisplayName
                break
            end
        end

        if playerNameToRemove then
            local index = table.find(aurawhitelistedplayers, playerNameToRemove)
            if index then
                table.remove(aurawhitelistedplayers, index)

                local newContent = #aurawhitelistedplayers > 0 and table.concat(aurawhitelistedplayers, ", ") or "None"
                
                WhitelistedUsers35:Set({
                    Title = "Whitelisted Users:",
                    Content = newContent
                })

                Rayfield:Notify({ Title = "WHITELIST", Content = "Removed :"..playerNameToRemove.." from whitelist", Duration = 2})
            end
        end
    end,
})

local Divider1 = CombatTab:CreateDivider()

OldAura = CombatTab:CreateToggle({
Name = "Old Aura",
CurrentValue = false,
Flag = "OldAura1",
Callback = function(value)
    if value == true then
        Rayfield:Notify({ Title = "OLD AURA", Content = "ENABLED", Duration = 2})
    else
        Rayfield:Notify({ Title = "OLD AURA", Content = "DISABLED", Duration = 2})
    end
end
})

local AttackOptions = CombatTab:CreateDropdown({
    Name = "Attack Options",
    Options = {"Slam","Attack","Heavy","Shove"},
    CurrentOption = {"Slam"},
    MultipleOptions = true,
    Flag = "AttackOptions1", 
    Callback = function(Options)

    end,
})

local Weaken = CombatTab:CreateToggle({
Name = "AutoWeaken",
CurrentValue = false,
Flag = "Weaken",
Callback = function(value)
    if value == true then
        Rayfield:Notify({ Title = "WEAKEN", Content = "ENABLED", Duration = 2})
    else
        Rayfield:Notify({ Title = "WEAKEN", Content = "DISABLED", Duration = 2})
    end
end
})

local WhitelistedUsers353 = CombatTab:CreateParagraph({
    Title = "Whitelisted Users:", 
    Content = "None"
})

local WhitelistUserInput353 = CombatTab:CreateInput({
    Name = "Add to Whitelist",
    Default = "",
    PlaceholderText = "type display/user",
    RemoveTextAfterFocusLost = true,
    Flag = "WhitelistUsers1",
    Callback = function(Text)
        for i, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer then
                if v.Name:lower():find(Text:lower(), 1, true) or v.DisplayName:lower():find(Text:lower(), 1, true) then
                    if not table.find(oldaurawhitelistedplayers, v.DisplayName) then
                        table.insert(oldaurawhitelistedplayers, v.DisplayName)
                        
                        WhitelistedUsers353:Set({
                            Title = "Whitelisted Users:",
                            Content = table.concat(oldaurawhitelistedplayers, ", ")
                        })
                        
                        Rayfield:Notify({ Title = "WHITELIST", Content = "Added: "..v.DisplayName.." to whitelist", Duration = 2})
                        break
                    end
                end
            end
        end
    end,
})

local RemoveWhitelistInput353 = CombatTab:CreateInput({
    Name = "Remove from Whitelist",
    Default = "",
    PlaceholderText = "type display/user",
    RemoveTextAfterFocusLost = true,
    Flag = "BlacklistUsers1",
    Callback = function(Text)
        local playerNameToRemove = nil
        for i, v in pairs(Players:GetPlayers()) do
            if v.Name:lower():find(Text:lower(), 1, true) or v.DisplayName:lower():find(Text:lower(), 1, true) then
                playerNameToRemove = v.DisplayName
                break
            end
        end

        if playerNameToRemove then
            local index = table.find(oldaurawhitelistedplayers, playerNameToRemove)
            if index then
                table.remove(oldaurawhitelistedplayers, index)

                local newContent = #oldaurawhitelistedplayers > 0 and table.concat(oldaurawhitelistedplayers, ", ") or "None"
                
                WhitelistedUsers353:Set({
                    Title = "Whitelisted Users:",
                    Content = newContent
                })

                Rayfield:Notify({ Title = "WHITELIST", Content = "Removed :"..playerNameToRemove.." from whitelist", Duration = 2})
            end
        end
    end,
})

local Divider1 = CombatTab:CreateDivider()

local conn25 
local conn35

local function moveSprayTool2()
    if LocalPlayer.Backpack:FindFirstChild("Spraycan") then
        LocalPlayer.Backpack.Spraycan.Parent = LocalPlayer.Character
    end
end

local function enableHoldSpray()
    if conn25 then
        conn25:Disconnect()
        conn25 = nil
    end
    if conn35 then
        conn35:Disconnect()
        conn35 = nil
    end

    moveSprayTool2()

    conn25 = LocalPlayer.Backpack.ChildAdded:Connect(function(child)
        if child.Name == "Spraycan" then
            child.Parent = LocalPlayer.Character
        end
    end)

    conn35 = LocalPlayer.CharacterAdded:Connect(function(char)
        task.wait(1) 
        moveSprayTool2()

        if conn25 then conn25:Disconnect() end
        conn25 = LocalPlayer.Backpack.ChildAdded:Connect(function(child)
            if child.Name == "Spraycan" then
                child.Parent = LocalPlayer.Character
            end
        end)
    end)
end

local function disableHoldSpray()
    if conn25 then
        conn25:Disconnect()
        conn25 = nil
    end
    if conn35 then
        conn35:Disconnect()
        conn35 = nil
    end
end

local SprayCanAura = CombatTab:CreateToggle({
Name = "Spray Can Aura",
CurrentValue = false,
Flag = "SprayCanAura1",
Callback = function(value)
    if value == true then
        Rayfield:Notify({ Title = "Spray Can AURA", Content = "ENABLED", Duration = 2})
        enableHoldSpray()
    else
        Rayfield:Notify({ Title = "Spray Can AURA", Content = "DISABLED", Duration = 2})
        disableHoldSpray()
    end
end
})

local WhitelistedUsers1122 = CombatTab:CreateParagraph({
    Title = "Whitelisted Users:", 
    Content = "None"
})

local WhitelistUserInput12223 = CombatTab:CreateInput({
    Name = "Add to Whitelist",
    Default = "",
    PlaceholderText = "type display/user",
    RemoveTextAfterFocusLost = true,
    Flag = "WhitelistUsers1",
    Callback = function(Text)
        for i, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer then
                if v.Name:lower():find(Text:lower(), 1, true) or v.DisplayName:lower():find(Text:lower(), 1, true) then
                    if not table.find(spraywhitelistedplayers, v.DisplayName) then
                        table.insert(spraywhitelistedplayers, v.DisplayName)
                        
                        WhitelistedUsers1122:Set({
                            Title = "Whitelisted Users:",
                            Content = table.concat(spraywhitelistedplayers, ", ")
                        })
                        
                        Rayfield:Notify({ Title = "WHITELIST", Content = "Added: "..v.DisplayName.." to whitelist", Duration = 2})
                        break
                    end
                end
            end
        end
    end,
})

local RemoveWhitelistInput12223 = CombatTab:CreateInput({
    Name = "Remove from Whitelist",
    Default = "",
    PlaceholderText = "type display/user",
    RemoveTextAfterFocusLost = true,
    Flag = "BlacklistUsers1",
    Callback = function(Text)
        local playerNameToRemove = nil
        for i, v in pairs(Players:GetPlayers()) do
            if v.Name:lower():find(Text:lower(), 1, true) or v.DisplayName:lower():find(Text:lower(), 1, true) then
                playerNameToRemove = v.DisplayName
                break
            end
        end

        if playerNameToRemove then
            local index = table.find(spraywhitelistedplayers, playerNameToRemove)
            if index then
                table.remove(spraywhitelistedplayers, index)

                local newContent = #spraywhitelistedplayers > 0 and table.concat(spraywhitelistedplayers, ", ") or "None"
                
                WhitelistedUsers1122:Set({
                    Title = "Whitelisted Users:",
                    Content = newContent
                })

                Rayfield:Notify({ Title = "WHITELIST", Content = "Removed :"..playerNameToRemove.." from whitelist", Duration = 2})
            end
        end
    end,
})

local Divider1 = CombatTab:CreateDivider()

local killButton = PlayersTab:CreateButton({
Name = "Kill Player",
Callback = function()
    Rayfield:Notify({ Title = "PLAYER TARGETING", Content = "Kill command initiated for selected players.", Duration = 3})
    for _, plr in pairs(Players:GetPlayers()) do
        if table.find(playersToKill, plr.Name) or table.find(playersToKill, plr.DisplayName) then
            local humanoid = plr.Character and plr.Character:FindFirstChild("Humanoid")
            if humanoid and humanoid.Health > 0 then
                task.spawn(function()
                    repeat
                        attack(plr, "POSTER_HIT")
                        task.wait(0.01)
                    until humanoid.Health == 0
                end)
            end
        end
    end
end,
})

local damageButton = PlayersTab:CreateButton({
    Name = "Damage Player",
    Callback = function()
        Rayfield:Notify({ Title = "PLAYER TARGETING", Content = "Damage command sent to selected players.", Duration = 2})
        for _, plr in pairs(Players:GetPlayers()) do
            if table.find(playersToKill, plr.Name) or table.find(playersToKill, plr.DisplayName) then
                local humanoid = plr.Character and plr.Character:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    attack(plr, "POSTER_HIT")
                end
            end
        end
    end,
})

local LoopKillSpeed = PlayersTab:CreateSlider({
Name = "Attack speed loopkill",
Range = {0, 10},
Increment = 0.001,
Suffix = "S",
CurrentValue = 0.05,
Flag = "LoopKillSpeed1", 
Callback = function()

end
})

local ingoreHptoggle = PlayersTab:CreateToggle({
    Name = "Ingore Hp",
    CurrentValue = false,
    Flag = "ingoreHptoggle1w",
    Callback = function(value)
        if value == true then
            Rayfield:Notify({ Title = "SCRIPT", Content = "INGORE HP ENABLED"})
        else
            Rayfield:Notify({ Title = "SCRIPT", Content = "INGORE HP DISABLED"})
        end
    end
})

getgenv().LoopKillToggle = PlayersTab:CreateToggle({
    Name = "Loop Kill Player",
    CurrentValue = false,
    Flag = "LoopKillToggle1",
    Callback = function(value)
        if value == true then
            Rayfield:Notify({ Title = "SCRIPT", Content = "LOOPKILL ENABLED"})
        else
            Rayfield:Notify({ Title = "SCRIPT", Content = "LOOPKILL DISABLED"})
        end
    end
})

task.spawn(function()
    while true do 
        wait(LoopKillSpeed.CurrentValue)
        if LoopKillToggle.CurrentValue then
            for _, plr in pairs(Players:GetPlayers()) do
                if table.find(playersToKill, plr.Name) or table.find(playersToKill, plr.DisplayName) then
                    local humanoid = plr.Character and plr.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        if ingoreHptoggle.CurrentValue then
                            attack(plr, "POSTER_HIT")
                        else
                            if humanoid.Health > 0 then
                                attack(plr, "POSTER_HIT")
                            end
                        end
                    end
                end
            end
        end
    end
end)

local KillingPlayers = PlayersTab:CreateParagraph({
    Title = "Players Selected:", 
    Content = "None"
})

local addtoKillTable = PlayersTab:CreateInput({
    Name = "Add to Table",
    Default = "",
    PlaceholderText = "type display/user",
    RemoveTextAfterFocusLost = true,
    Flag = "addtoKillTable1",
    Callback = function(Text)
        for i, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer then
                if v.Name:lower():find(Text:lower(), 1, true) or v.DisplayName:lower():find(Text:lower(), 1, true) then
                    if not table.find(playersToKill, v.DisplayName) then
                        table.insert(playersToKill, v.DisplayName)
                        
                        KillingPlayers:Set({
                            Title = "Whitelisted Users:",
                            Content = table.concat(playersToKill, ", ")
                        })
                        
                        Rayfield:Notify({ Title = "KILL TABLE", Content = "Added: "..v.DisplayName.." to table", Duration = 2})
                        break
                    end
                end
            end
        end
    end,
})

local removefromKillTable = PlayersTab:CreateInput({
    Name = "Remove from Table",
    Default = "",
    PlaceholderText = "type display/user",
    RemoveTextAfterFocusLost = true,
    Flag = "removefromKillTable1",
    Callback = function(Text)
        local playerNameToRemove = nil
        for i, v in pairs(Players:GetPlayers()) do
            if v.Name:lower():find(Text:lower(), 1, true) or v.DisplayName:lower():find(Text:lower(), 1, true) then
                playerNameToRemove = v.DisplayName
                break
            end
        end

        if playerNameToRemove then
            local index = table.find(playersToKill, playerNameToRemove)
            if index then
                table.remove(playersToKill, index)

                local newContent = #playersToKill > 0 and table.concat(playersToKill, ", ") or "None"
                
                KillingPlayers:Set({
                    Title = "Whitelisted Users:",
                    Content = newContent
                })

                Rayfield:Notify({ Title = "KILL TABLE", Content = "Removed :"..playerNameToRemove.." from table", Duration = 2})
            end
        end
    end,
})

local emoteList

getgenv().LoopEmote = nil
getgenv().LoopEmote = SettingsTab:CreateToggle({
    Name = "Loop Emote",
    CurrentValue = false,
    Flag = "LoopEmote1"
})

local function updateLoopEmote()
    local character = LocalPlayer.Character
    if not character then return end

    local hum = character:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then return end

    local targetAnim = emotes:FindFirstChild(emoteList.CurrentOption[1]).Main
    if not targetAnim then return end

    if getgenv().LoopEmote.CurrentTrack then
        getgenv().LoopEmote.CurrentTrack.Looped = false
        getgenv().LoopEmote.CurrentTrack:Stop()
        getgenv().LoopEmote.CurrentTrack = nil
    end

    if getgenv().LoopEmote.CurrentValue then
        local track = animator:LoadAnimation(targetAnim)
        track.Looped = true
        track:Play()
        getgenv().LoopEmote.CurrentTrack = track
    end
end

getgenv().LoopEmote.Callback = function(value)
    if not value then
        Rayfield:Notify({Title = "SCRIPT", Content = "LoopEmote DISABLED"})
        if getgenv().LoopEmote.CurrentTrack then
            getgenv().LoopEmote.CurrentTrack.Looped = false
            getgenv().LoopEmote.CurrentTrack:Stop()
            getgenv().LoopEmote.CurrentTrack = nil
        end
    else
        Rayfield:Notify({Title = "SCRIPT", Content = "LoopEmote ENABLED"})
        updateLoopEmote()
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if getgenv().LoopEmote.CurrentValue then
        updateLoopEmote()
    end
end)


local emoteNames = {}
for i, v in pairs(emotes:GetChildren()) do
    if not table.find(emoteNames, v.Name) then
        table.insert(emoteNames, v.Name)
    end
end

emoteList = SettingsTab:CreateDropdown({
    Name = "Select Emote",
    Options = emoteNames,
    CurrentOption = {"L Dance"},
    MultipleOptions = false,
    Flag = "emoteList1",
    Callback = function()
        updateLoopEmote() 
    end,
})

local emoteButton = SettingsTab:CreateButton({
    Name = "Run Emote",
    Callback = function()
        local character = LocalPlayer.Character
        if not character then return end

        local hum = character:FindFirstChildOfClass("Humanoid")
        if not hum then return end

        local animator = hum:FindFirstChildOfClass("Animator")
        if not animator then return end

        local targetAnim = emotes:FindFirstChild(emoteList.CurrentOption[1]).Main
        if targetAnim then
            local track = animator:LoadAnimation(targetAnim)
            track.Looped = false
            track:Play()
        end
    end,
})

task.spawn(function()
    while true do
        task.wait(0.1)
        if getgenv().LoopEmote.CurrentValue then
            local track = getgenv().LoopEmote.CurrentTrack
            if track and not track.IsPlaying then
                track:Play()
            end
        end
    end
end)

local Divider1100033 = SettingsTab:CreateDivider()

getgenv().MuteSound = nil

getgenv().RemoveHitSound = SettingsTab:CreateToggle({
    Name = "Remove Hit Sound",
    CurrentValue = false,
    Flag = "RemoveHitSound1",
    Callback = function(value)
        if value == true then
            Rayfield:Notify({ Title = "SCRIPT", Content = "RemoveHitSound ENABLED"})

            if getgenv().MuteSound then
                getgenv().MuteSound:Disconnect()
                getgenv().MuteSound = nil
            end

            getgenv().MuteSound = workspace.DescendantAdded:Connect(function(child)
                if child.Name == "HardPunch" then
                    child:Destroy()
                end
            end)
        else
            Rayfield:Notify({ Title = "SCRIPT", Content = "RemoveHitSound DISABLED"})

            if getgenv().MuteSound then
                getgenv().MuteSound:Disconnect()
                getgenv().MuteSound = nil
            end
        end
    end
})

getgenv().Divider1100033 = SettingsTab:CreateDivider()
function swapAnimations()
    task.wait(1.5)

    local plrStyles = getPlrAnimations()
    local leaderstats = LocalPlayer:WaitForChild("leaderstats")
    local currentStyle = leaderstats.Class
    local currentStyleValue = currentStyle.Value

    currentStyle.Changed:Connect(function(value)
        currentStyleValue = value
    end)

    if plrStyles:FindFirstChild(currentStyleValue) and plrStyles:FindFirstChild(selectedStyle) then
        for _, v in pairs(plrStyles:FindFirstChild(currentStyleValue):GetChildren()) do
            v.Parent = plrStyles:FindFirstChild(selectedStyle)
        end
        for _, v in pairs(plrStyles:FindFirstChild(selectedStyle):GetChildren()) do
            v.Parent = plrStyles:FindFirstChild(currentStyleValue)
        end
        Rayfield:Notify({ Title = "STYLE HANDLER", Content = "Style changed to: "..selectedStyle, Duration = 2})
    end
end

LocalPlayer.CharacterAdded:Connect(function(character)
    local core = character:WaitForChild("Core")
    local animations = core:WaitForChild("Animations")
    local styles = animations:WaitForChild("Styles")

    swapAnimations()
end)

GodAuraKeybind = SettingsTab:CreateKeybind({
Name = "Enable/Disable GodAura",
CurrentKeybind = "V",
HoldToInteract = false,
Flag = "GodAuraKeybind1", 
Callback = function(Value)
    GodAura:Set(not GodAura.CurrentValue)
end,
})

local OldAuraKeybind = SettingsTab:CreateKeybind({
Name = "Enable/Disable OldAura",
CurrentKeybind = "E",
HoldToInteract = false,
Flag = "OldAuraKeybind1", 
Callback = function(Value)
    OldAura:Set(not OldAura.CurrentValue)
end,
})

local NoclipKeybind = SettingsTab:CreateKeybind({
Name = "Enable/Disable Noclip",
CurrentKeybind = "C",
HoldToInteract = false,
Flag = "NoclipKeybind1", 
Callback = function(Value)
    noclip1:Set(not noclip1.CurrentValue)
end,
})

SPEEDBOOSTKEY = SettingsTab:CreateKeybind({
Name = "Enable/Disable SPEEDBOOST",
CurrentKeybind = "T",
HoldToInteract = false,
Flag = "SPEEDBOOSTKEY1", 
Callback = function(Value)
    SPEEDBOOST:Set(not SPEEDBOOST.CurrentValue)
end,
})

GrabPlayerKeybind = SettingsTab:CreateKeybind({
Name = "Grab Player",
CurrentKeybind = "Z",
HoldToInteract = false,
Flag = "GrabPlayerKeybind1", 
Callback = function(Value)
        if ToggleGrabPlayers.CurrentValue == true then
            local MAX_DISTANCE = 5

            local localCharacter = LocalPlayer.Character
            if not localCharacter then return end

            local localRoot = localCharacter:FindFirstChild("HumanoidRootPart")
            if not localRoot then return end

            local closestPlayer = nil
            local minDistance = MAX_DISTANCE

            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local targetCharacter = player.Character
                    local targetRoot = targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart")
                    
                    if targetRoot and targetCharacter.Parent and targetCharacter.Parent.Name == "Live" then
                        local humanoid = targetCharacter:FindFirstChildOfClass("Humanoid")
                        if humanoid and humanoid.Health > 0 then
                            local distance = (localRoot.Position - targetRoot.Position).Magnitude
                            
                            if distance < minDistance then
                                minDistance = distance
                                closestPlayer = player
                            end
                        end
                    end
                end
            end

            pcall(function()
                if closestPlayer then
                    grab(closestPlayer)
                end
            end)
        end
end
})

local SLAMKEYTEST123 = SettingsTab:CreateKeybind({
    Name = "SLAM NEAREST PLAYER",
    CurrentKeybind = "N",
    HoldToInteract = false,
    Flag = "SLAMKEYTEST123", 
    Callback = function(Value)
        local character = LocalPlayer.Character
        if not character then return end

        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end

        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local primaryPart = plr.Character:FindFirstChild("HumanoidRootPart")
                    if primaryPart then
                        local distance = (rootPart.Position - primaryPart.Position).Magnitude
                        if distance <= 20 then
                            attack(plr, "Slam")
                        end
                    end
                end
            end
        end
    end,
})

getgenv().LOCATECC_Stop = false
getgenv().LOCATECC_Running = false

getgenv().safeWait = function(duration)
    local elapsed = 0
    local step = 0.01
    while elapsed < duration do
        if getgenv().LOCATECC_Stop then return true end
        task.wait(step)
        elapsed = elapsed + step
    end
    return getgenv().LOCATECC_Stop
end

getgenv().safeKeyPress = function(key, holdTime)
    if getgenv().LOCATECC_Stop then return true end
    keypress(key)
    if getgenv().safeWait(0.01) then return true end
    keyrelease(key)
    return getgenv().LOCATECC_Stop
end

local function scramble(tbl)
    local n = #tbl
    for i = n, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
end

getgenv().LOCATECC = SettingsTab:CreateKeybind({
    Name = "ATTEMPT JOIN CONTENT CREATORS",
    CurrentKeybind = "P",
    HoldToInteract = false,
    Flag = "LOCATECC1",
    Callback = function(Value)
        if getgenv().LOCATECC_Running then return end

        getgenv().LOCATECC_Stop = false
        getgenv().LOCATECC_Running = true

        task.spawn(function()
            for i, user in pairs(usernames) do
                if getgenv().LOCATECC_Stop then break end
                if getgenv().safeWait(0.01) then break end
                if getgenv().safeKeyPress(222) then break end
                typeExclamation()
                if getgenv().safeWait(0.01) then break end
                typeJoin()
                if getgenv().safeWait(0) then break end
                if getgenv().safeKeyPress(32) then break end

                for c in user:gmatch(".") do
                    if getgenv().LOCATECC_Stop then break end
                    typeChar(c)
                    if getgenv().safeWait(0.01) then break end
                end

                if getgenv().LOCATECC_Stop then break end
                if getgenv().safeKeyPress(13) then break end
            end

            usernames = scramble(usernames)

            getgenv().LOCATECC_Running = false
            getgenv().LOCATECC_Stop = false
        end)
    end,
})


getgenv().LOCATECC_CANCEL = SettingsTab:CreateKeybind({
    Name = "CANCEL ATTEMPT JOIN CONTENT CREATORS",
    CurrentKeybind = "O",
    HoldToInteract = false,
    Flag = "LOCATECC_CANCEL",
    Callback = function(Value)
        getgenv().LOCATECC_Stop = true
    end,
})


local WALKSPEED
SPEEDBOOST = MovementTab:CreateToggle({
    Name = "Boost Speed",
    CurrentValue = false,
    Flag = "SPEEDBOOST1",
    Callback = function(value)
        if value then
            Rayfield:Notify({ Title = "SPEED BOOST", Content = "ENABLED", Duration = 2})
        else
            Rayfield:Notify({ Title = "SPEED BOOST", Content = "DISABLED", Duration = 2})
        end
    end
})

task.spawn(function()
    while true do
        task.wait()
        if SPEEDBOOST.CurrentValue == true then
            if LocalPlayer.Character 
                and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") 
                and LocalPlayer.Character:FindFirstChild("Humanoid") then
                
                local HRP = LocalPlayer.Character.HumanoidRootPart
                local Humanoid = LocalPlayer.Character.Humanoid
                
                HRP.AssemblyLinearVelocity =
                    (HRP.AssemblyLinearVelocity * Vector3.new(0, 1, 0))
                    + Humanoid.MoveDirection * WALKSPEED.CurrentValue
            end
        end
    end
end)

WALKSPEED = MovementTab:CreateSlider({
    Name = "WALKSPEED",
    Range = {1, 100},
    Increment = 1,
    Suffix = "S",
    CurrentValue = 24,
    Flag = "WALKSPEED1", 
    Callback = function(value)
    end
})

noclip1 = MovementTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "noclip12",
    Callback = function(value)
        if value == false then
            Rayfield:Notify({ Title = "NOCLIP", Content = "DISABLED", Duration = 2})
            pcall(function()
                for i, v in pairs(LocalPlayer.Character:GetChildren()) do
                    if v:IsA("BasePart") then
                        if v.CanCollide == false then
                            v.CanCollide = true
                        end
                    end
                end
            end)
        else
            Rayfield:Notify({ Title = "NOCLIP", Content = "ENABLED", Duration = 2})
        end
    end
})

task.spawn(function()
    while true do
        task.wait(0.075)
        if noclip1.CurrentValue == true then
            pcall(function()
                for i, v in pairs(LocalPlayer.Character:GetChildren()) do
                    if v:IsA("BasePart") then
                        if v.CanCollide == true then
                            v.CanCollide = false
                        end
                    end
                end
            end)
        end
    end
end)

local GiveGodAura = CombatTab:CreateToggle({
    Name = "Give God Aura",
    CurrentValue = false,
    Flag = "GiveGodAura1",
    Callback = function(value)
        if value == true then
            Rayfield:Notify({ Title = "GIVE GOD AURA", Content = "ENABLED", Duration = 2})
        else
            Rayfield:Notify({ Title = "GIVE GOD AURA", Content = "DISABLED", Duration = 2})
        end
    end
})

local GivenGodAuraOwner = CombatTab:CreateInput({
    Name = "CHOSEN ONE",
    CurrentValue = "",
    PlaceholderText = "type display/user/Id",
    RemoveTextAfterFocusLost = false,
    Flag = "GivenGodAuraOwner1",
    Callback = function(v)

    end
})

local GivenGodAuraRange = CombatTab:CreateSlider({
Name = "God Aura Range",
Range = {1, 380},
Increment = 1,
Suffix = "M",
CurrentValue = 10,
Flag = "GodAuraRange1", 
Callback = function()
    
end
})

local GivenGodAuraSpeed = CombatTab:CreateSlider({
Name = "God Aura Speed",
Range = {0.01, 10},
Increment = 0.01,
Suffix = "s",
CurrentValue = 0.05,
Flag = "GodAuraSpeed1", 
Callback = function()
        
end
})

local GivenoringalAttackSpeed = CombatTab:CreateButton({
Name = "Return God Aura Speed",
Callback = function()
        GivenGodAuraSpeed:Set(0.05)
        Rayfield:Notify({ Title = "GOD AURA", Content = "RETURNED TO ORINGAL", Duration = 2})
end,
})

local GivenWhitelistedUsers = CombatTab:CreateParagraph({
    Title = "Whitelisted Users:", 
    Content = "None"
})

local GivenWhitelistUserInput = CombatTab:CreateInput({
    Name = "Add to Whitelist",
    Default = "",
    PlaceholderText = "type display/user",
    RemoveTextAfterFocusLost = true,
    Flag = "GivenWhitelistUserInput1",
    Callback = function(Text)
        for i, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer then
                if v.Name:lower():find(Text:lower(), 1, true) or v.DisplayName:lower():find(Text:lower(), 1, true) then
                    if not table.find(givenwhitelistedPlayers, v.DisplayName) then
                        table.insert(givenwhitelistedPlayers, v.DisplayName)
                        
                        GivenWhitelistedUsers:Set({
                            Title = "Whitelisted Users:",
                            Content = table.concat(givenwhitelistedPlayers, ", ")
                        })
                        
                        Rayfield:Notify({ Title = "WHITELIST", Content = "Added: "..v.DisplayName.." to whitelist", Duration = 2})
                        break
                    end
                end
            end
        end
    end,
})

local GivenRemoveWhitelistInput = CombatTab:CreateInput({
    Name = "Remove from Whitelist",
    Default = "",
    PlaceholderText = "type display/user",
    RemoveTextAfterFocusLost = true,
    Flag = "GivenRemoveWhitelistInput1",
    Callback = function(Text)
        local playerNameToRemove = nil
        for i, v in pairs(Players:GetPlayers()) do
            if v.Name:lower():find(Text:lower(), 1, true) or v.DisplayName:lower():find(Text:lower(), 1, true) then
                playerNameToRemove = v.DisplayName
                break
            end
        end

        if playerNameToRemove then
            local index = table.find(givenwhitelistedPlayers, playerNameToRemove)
            if index then
                table.remove(givenwhitelistedPlayers, index)

                local newContent = #givenwhitelistedPlayers > 0 and table.concat(givenwhitelistedPlayers, ", ") or "None"
                
                GivenWhitelistedUsers:Set({
                    Title = "Whitelisted Users:",
                    Content = newContent
                })

                Rayfield:Notify({ Title = "WHITELIST", Content = "Removed :"..playerNameToRemove.." from whitelist", Duration = 2})
            end
        end
    end,
})

local ExcludeLocalPlayer = CombatTab:CreateToggle({
    Name = "Exclude Local Player",
    CurrentValue = false,
    Flag = "ExcludeLocalPlayer1",
    Callback = function(value)
        if value == true then
            Rayfield:Notify({ Title = "EXCLUDE PLAYER", Content = "You will now be whitelisted from 'Give Aura'", Duration = 3})
            if not table.find(givenwhitelistedPlayers, game.Players.LocalPlayer.DisplayName) then
                table.insert(givenwhitelistedPlayers, game.Players.LocalPlayer.DisplayName) 
            end
        else
            Rayfield:Notify({ Title = "EXCLUDE PLAYER", Content = "You are no longer whitelisted from 'Give Aura'", Duration = 3})
            if table.find(givenwhitelistedPlayers, game.Players.LocalPlayer.DisplayName) then
                table.remove(givenwhitelistedPlayers, table.find(givenwhitelistedPlayers, game.Players.LocalPlayer.DisplayName))
            end
        end
    end
})

local conn8 = nil
local AllowChatCommands = CombatTab:CreateToggle({
    Name = "Allow Commands",
    CurrentValue = false,
    Flag = "ExcludeLocalPlayer1",
    Callback = function(value)
        if value then
            Rayfield:Notify({ Title = "CHAT COMMANDS", Content = "ENABLED for 'CHOSEN ONE'", Duration = 2})
        else
            Rayfield:Notify({ Title = "CHAT COMMANDS", Content = "DISABLED for 'CHOSEN ONE'", Duration = 2})
        end

        if value == true then
            if conn8 then
                conn8:Disconnect()
                conn8 = nil
            end
            conn8 = ChatList.ChildAdded:Connect(function(msg)
                if msg:IsA("Frame") then
                    local mainChatCell = msg:FindFirstChild("Main")
                    if not mainChatCell then return end

                    local labelChatCell = mainChatCell:FindFirstChild("Label")
                    if not labelChatCell then return end

                    local text = labelChatCell.Text:lower()

                    for _, plr in ipairs(Players:GetPlayers()) do
                        if plr.Name:lower() == GivenGodAuraOwner.CurrentValue:lower() or plr.DisplayName:lower() == GivenGodAuraOwner.CurrentValue:lower() then
                            if string.find(text, plr.Name:lower()) then
                                local command = string.match(text, "^.-: /(.*)")
                                if command then
                                    if command:find("^aura$") then
                                        local v = GiveGodAura.CurrentValue
                                        GiveGodAura:Set(not v)
                                    elseif command:find("^aurarange") then
                                        local number = string.match(command, "aurarange%s+(%d+)")
                                        if number then
                                            number = tonumber(number)
                                            if number >= 1 and number <= 380 then
                                                GivenGodAuraRange:Set(number)
                                            end
                                        end
                                    elseif command:find("^auraspeed") then
                                        local number = string.match(command, "auraspeed%s+([%d%.]+)")
                                        if number then
                                            number = tonumber(number)
                                            if number >= 0.01 and number <= 10 then
                                                GivenGodAuraSpeed:Set(number)
                                            end
                                        end
                                    elseif command:find("whitelist") then
                                        local name = string.match(command, "whitelist%s+(.+)")
                                        local nametoWhitelist
                                        if name then
                                            for i, v in pairs(Players:GetPlayers()) do
                                                if v ~= LocalPlayer then
                                                    if v.Name:lower() == name:lower() or v.DisplayName:lower() == name:lower() then
                                                        nametoWhitelist = v.DisplayName
                                                        break
                                                    end
                                                end
                                            end
                                            if not table.find(givenwhitelistedPlayers, nametoWhitelist) then
                                                table.insert(givenwhitelistedPlayers, nametoWhitelist)
                                                
                                                GivenWhitelistedUsers:Set({
                                                    Title = "Whitelisted Users:",
                                                    Content = table.concat(givenwhitelistedPlayers, ", ")
                                                })
                                                
                                                Rayfield:Notify({ Title = "WHITELIST", Content = "Added: "..nametoWhitelist.." to whitelist from request of GivenAura", Duration = 2})
                                            end
                                        end
                                    elseif command:find("blacklist") then
                                        local name = string.match(command, "blacklist%s+(.+)")
                                        local nameToBlacklist
                                        if name then
                                            for i, v in pairs(Players:GetPlayers()) do
                                                if v ~= LocalPlayer then
                                                    if v.Name:lower() == name:lower() or v.DisplayName:lower() == name:lower() then
                                                        nameToBlacklist = v.DisplayName
                                                        break
                                                    end
                                                end
                                            end
                                            if nameToBlacklist then
                                                local index = table.find(givenwhitelistedPlayers, nameToBlacklist)
                                                if index then
                                                    table.remove(givenwhitelistedPlayers, index)

                                                    local newContent = #givenwhitelistedPlayers > 0 and table.concat(givenwhitelistedPlayers, ", ") or "None"
                                                    
                                                    GivenWhitelistedUsers:Set({
                                                        Title = "Whitelisted Users:",
                                                        Content = newContent
                                                    })

                                                    Rayfield:Notify({ 
                                                        Title = "WHITELIST", 
                                                        Content = "Removed: "..nameToBlacklist.." from whitelist from request of GivenAura", 
                                                        Duration = 2
                                                    })
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        else
            if conn8 then
                conn8:Disconnect()
                conn8 = nil
            end
        end
    end
})

local Divider1 = CombatTab:CreateDivider()

local disableArena = CombatTab:CreateToggle({
Name = "Disable Arena",
CurrentValue = false,
Flag = "disableArena1",
Callback = function(value)
        if value == true then
            Rayfield:Notify({ Title = "SCRIPT", Content = "DISABLED ARENA", Duration = 2})
        else
            Rayfield:Notify({ Title = "SCRIPT", Content = "ENABLED ARENA", Duration = 2})
        end
end
})

local pads = {}
for _, model in pairs(DuelsFolder:GetChildren()) do
    if model:IsA("Model") and model:FindFirstChild("Pads") then
        for _, basePart in pairs(model.Pads:GetDescendants()) do
            if basePart:IsA("BasePart") then
                table.insert(pads, basePart)
            end
        end
    end
end

task.spawn(function()
    while true do
        task.wait(0.08)

        if disableArena.CurrentValue then
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer then
                    if not table.find(whitelistedPlayers, plr.DisplayName) then 
                        local char = plr.Character
                        local hrp = char and char:FindFirstChild("HumanoidRootPart")
                        local hum = char and char:FindFirstChildOfClass("Humanoid")

                        if hrp and hum and hum.Health > 0 then
                            for _, pad in pairs(pads) do
                                if (hrp.Position - pad.Position).Magnitude <= 12 then
                                    attack(plr, "POSTER_HIT")
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

local conn2 
local conn3 

local function moveFightTool()
    if LocalPlayer.Backpack:FindFirstChild("Fight") then
        LocalPlayer.Backpack.Fight.Parent = LocalPlayer.Character
    end
end

local function enableHoldFist()
    if conn2 then
        conn2:Disconnect()
        conn2 = nil
    end
    if conn3 then
        conn3:Disconnect()
        conn3 = nil
    end

    moveFightTool()

    conn2 = LocalPlayer:WaitForChild("Backpack").ChildAdded:Connect(function(child)
        if child.Name == "Fight" then
            child.Parent = LocalPlayer.Character
        end
    end)

    conn3 = LocalPlayer.CharacterAdded:Connect(function(char)
        task.wait(1) 
        moveFightTool()

        if conn2 then conn2:Disconnect() end
        conn2 = LocalPlayer:WaitForChild("Backpack").ChildAdded:Connect(function(child)
            if child.Name == "Fight" then
                child.Parent = LocalPlayer.Character
            end
        end)
    end)

    Rayfield:Notify({ Title = "SCRIPT", Content = "ENABLED HOLD FIST", Duration = 2})
end

local function disableHoldFist()
    if conn2 then
        conn2:Disconnect()
        conn2 = nil
    end
    if conn3 then
        conn3:Disconnect()
        conn3 = nil
    end

    Rayfield:Notify({ Title = "SCRIPT", Content = "DISABLED HOLD FIST", Duration = 2})
end

local HoldFistToggle = CombatTab:CreateToggle({
    Name = "Hold Fist",
    CurrentValue = false,
    Flag = "HoldFist",
    Callback = function(value)
        if value then
             Rayfield:Notify({ Title = "AUTO HOLD FIST", Content = "ENABLED", Duration = 2})
            enableHoldFist()
        else
            Rayfield:Notify({ Title = "AUTO HOLD FIST", Content = "DISABLED", Duration = 2})
            disableHoldFist()
        end
    end
})

AutoShove = CombatTab:CreateToggle({
Name = "Auto Shove",
CurrentValue = false,
Flag = "AutoShove1",
Callback = function(value)
    if value == true then
        Rayfield:Notify({ Title = "AUTO SHOVE", Content = "ENABLED", Duration = 2})
    else
        Rayfield:Notify({ Title = "AUTO SHOVE", Content = "DISABLED", Duration = 2})
    end
end
})

ToggleGrabPlayers = CombatTab:CreateToggle({
Name = "Grab Players",
CurrentValue = false,
Flag = "ToggleGrabPlayers1",
Callback = function(value)
        if value == true then
            Rayfield:Notify({ Title = "SCRIPT", Content = "ENABLED GRAB ABILITY", Duration = 2})
        else
            Rayfield:Notify({ Title = "SCRIPT", Content = "DISABLED GRAB ABILITY", Duration = 2})
        end
end
})

GrabOject = CombatTab:CreateDropdown({
Name = "Grab Type",
Options = {"Basketballs","Bench","Classroom Chairs","Desk","FireExtinguisher","Football","Normal Chairs","Sink","Trash","VendingMachine","Wet Floor Sign"},
CurrentOption = {"Football"},
MultipleOptions = false,
Flag = "ThemesList1", 
    Callback = function(Options)

    end,
})

local mousConn
local KillMouseClickTarget = PlayersTab:CreateToggle({
    Name = "Kill Mouse Player",
    CurrentValue = false,
    Flag = "KillMouseClickTarget1",
    Callback = function(value)
        if value then
            Rayfield:Notify({ Title = "MOUSE TARGET", Content = "Kill on click ENABLED", Duration = 2})
        else
            Rayfield:Notify({ Title = "MOUSE TARGET", Content = "Kill on click DISABLED", Duration = 2})
        end

        if value == true then
            if mousConn then
                mousConn:Disconnect()
                mousConn = nil
            end

            mousConn = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
                if not gameProcessedEvent and input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local mouseTarget = mouse.Target
                    if not mouseTarget then return end

                    local model = mouseTarget:FindFirstAncestorWhichIsA("Model")
                    if model and model.Parent and model.Parent.Name == "Live" then
                        local humanoid = model:FindFirstChildOfClass("Humanoid")
                        local targetPlr = Players:GetPlayerFromCharacter(model)

                        if targetPlr == LocalPlayer then
                            return
                        end
                    
                        if model and humanoid and humanoid.Health > 0 and targetPlr then
                            task.spawn(function()
                                while humanoid and humanoid.Health > 0 do
                                    attack(targetPlr, "POSTER_HIT")
                                    task.wait()
                                end
                            end)
                        end
                    end
                end
            end)
        else
            if mousConn then
                mousConn:Disconnect()
                mousConn = nil
            end
        end
    end
})

local mousConn2
local DamageMouseTargetToggle = PlayersTab:CreateToggle({
    Name = "Damage Mouse Player",
    CurrentValue = false,
    Flag = "DamageMouseTargetToggle1",
    Callback = function(value)
        if value then
            Rayfield:Notify({ Title = "MOUSE TARGET", Content = "Damage on click ENABLED", Duration = 2})
        else
            Rayfield:Notify({ Title = "MOUSE TARGET", Content = "Damage on click DISABLED", Duration = 2})
        end

        if value == true then
            if mousConn2 then
                mousConn2:Disconnect()
                mousConn2 = nil
            end

            mousConn2 = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
                if not gameProcessedEvent and input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local mouseTarget = mouse.Target
                    if not mouseTarget then return end

                    local model = mouseTarget:FindFirstAncestorWhichIsA("Model")
                    if model and model.Parent and model.Parent.Name == "Live" then
                        local humanoid = model:FindFirstChildOfClass("Humanoid")
                        local targetPlr = Players:GetPlayerFromCharacter(model)

                        if targetPlr == LocalPlayer then
                            return
                        end
                    
                        if model and humanoid and humanoid.Health > 0 and targetPlr then
                            attack(targetPlr, "POSTER_HIT")
                        end
                    end
                end
            end)
        else
            if mousConn2 then
                mousConn2:Disconnect()
                mousConn2 = nil
            end
        end
    end
})

getgenv().KillAll = PlayersTab:CreateButton({
    Name = "Kill All",
    Callback = function()
        pcall(function()
            for i, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer then
                    task.spawn(function()
                        repeat
                            wait(0.01)
                            attack(v, "POSTER_HIT")
                        until v.Character.Humanoid.Health == 0
                    end)
                end
            end
        end)
    end,
})

getgenv().DamageAll = PlayersTab:CreateButton({
    Name = "Damage All",
    Callback = function()
        pcall(function()
            for i, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer then
                    task.spawn(function()
                        attack(v, "POSTER_HIT")
                    end)
                end
            end
        end)
    end,
})

local alreadySpawned = false
local alreadySpawned2 = false
local EarRapeToggle
local LoopKillUser
local PlayerInput

local function spawnAttackTasks()
    for i = 1, 7 do
        task.spawn(function()
            while EarRapeToggle.CurrentValue do
                attack(LocalPlayer, "POSTER_HIT")
                task.wait()
            end
        end)
    end
end

local function spawnAttackTasks2()
    for i = 1, 7 do
        task.spawn(function()
            while LoopKillUser.CurrentValue do
                wait()
                for i, v in pairs(Players:GetPlayers()) do
                    if v.Name:lower() == PlayerInput.CurrentValue:lower() or v.DisplayName:lower() == PlayerInput.CurrentValue:lower() then
                        attack(v, "POSTER_HIT")
                    end
                end
            end
        end)
    end
end

EarRapeToggle = ServerMiscTab:CreateToggle({
    Name = "EAR RAPE ( KILLS YOU )",
    CurrentValue = false,
    Flag = "EarRapeToggle1",
    Callback = function(value)
        if value then
            Rayfield:Notify({ Title = "EAR RAPE", Content = "ENABLED", Duration = 2})
        else
            Rayfield:Notify({ Title = "EAR RAPE", Content = "DISABLED", Duration = 2})
        end

        if value and not alreadySpawned then
            alreadySpawned = true
            spawnAttackTasks()
        elseif not value then
            alreadySpawned = false
        end
    end
})

LocalPlayer.CharacterAdded:Connect(function()
    if EarRapeToggle.CurrentValue and not alreadySpawned then
        alreadySpawned = true
        spawnAttackTasks()
    end
end)

local LoopKillAll = ServerMiscTab:CreateToggle({
    Name = "LOOP KILL ALL",
    CurrentValue = false,
    Flag = "LoopKillAll1",
    Callback = function(value)
        if value then
            Rayfield:Notify({ Title = "LOOP KILL ALL", Content = "ENABLED", Duration = 2})
        else
            Rayfield:Notify({ Title = "LOOP KILL ALL", Content = "DISABLED", Duration = 2})
        end
    end
})

task.spawn(function()
    while true do
        task.wait(0.045)
        if LoopKillAll.CurrentValue == true then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    pcall(function()
                        attack(v, "POSTER_HIT")
                    end)
                end
            end
        end
    end
end)

LoopKillUser = ServerMiscTab:CreateToggle({
    Name = "LOOP KILL USER v2",
    CurrentValue = false,
    Flag = "LoopKillAll1",
    Callback = function(value)
        if value then
            Rayfield:Notify({ Title = "LOOP KILL USER", Content = "ENABLED", Duration = 2})
        else
            Rayfield:Notify({ Title = "LOOP KILL USER", Content = "DISABLED", Duration = 2})
        end

        if value and not alreadySpawned then
            alreadySpawned = true
            spawnAttackTasks2()
        elseif not value then
            alreadySpawned = false
        end
    end
})

PlayerInput = ServerMiscTab:CreateInput({
    Name = "User to loopkill",
    CurrentValue = "",
    PlaceholderText = "type display/user/Id",
    RemoveTextAfterFocusLost = false,
    Flag = "LocatePlayerInput1",
    Callback = function(v)

    end
})

local LagUser
local PlayerInput3

LagUser = ServerMiscTab:CreateToggle({
    Name = "Lag user",
    CurrentValue = false,
    Flag = "LagUser1",
    Callback = function(value)
        if value then
            Rayfield:Notify({ Title = "LAG USER", Content = "ENABLED", Duration = 2})
        else
            Rayfield:Notify({ Title = "LAG USER", Content = "DISABLED", Duration = 2})
        end
    end
})

PlayerInput3 = ServerMiscTab:CreateInput({
    Name = "User to lag",
    CurrentValue = "",
    PlaceholderText = "username",
    RemoveTextAfterFocusLost = false,
    Flag = "PlayerInput31",
    Callback = function(v)

    end
})

task.spawn(function()
    while true do
        task.wait() 
        if LagUser.CurrentValue == true and PlayerInput3.CurrentValue ~= "" then
            local target = game.Players:FindFirstChild(PlayerInput3.CurrentValue)
            if target then
                for i = 1, 2 do
                    task.spawn(function()
                        local args = {
                            [1] = "Send_Money",
                            [2] = 1,
                            [3] = target
                        }
                        local success, result = pcall(function()
                            return remoteFunction:InvokeServer(unpack(args))
                        end)
                    end)
                end
            end
        end
    end
end)

local Dividerert35 = ServerMiscTab:CreateDivider()

local playerusertoconvert
local convertusertodisplay = ServerMiscTab:CreateButton({
    Name = "Convert user to display",
    Callback = function()
        for i, v in pairs(Players:GetPlayers()) do
            if v.Name:lower() == playerusertoconvert.CurrentValue:lower() or v.DisplayName:lower() == playerusertoconvert.CurrentValue:lower() then
                setclipboard(v.Name)
                Rayfield:Notify({
                    Title = "CLIPBOARD",
                    Content = "Copied player name: "..v.Name.." from displayname "..v.DisplayName,
                    Duration = 2
                })
                break
            end
        end
    end,
})

playerusertoconvert = ServerMiscTab:CreateInput({
    Name = "User to Convert",
    CurrentValue = "",
    PlaceholderText = "username",
    RemoveTextAfterFocusLost = false,
    Flag = "LocatePlayerInput1",
    Callback = function(v)
    end
})

local Divider35 = ServerMiscTab:CreateDivider()

local CrashUser
local PlayerInput2

CrashUser = ServerMiscTab:CreateToggle({
    Name = "CRASH USER 2,500 LUNCH MONEY",
    CurrentValue = false,
    Flag = "CrashUser1",
    Callback = function(value)
        if value then
            Rayfield:Notify({ Title = "CRASH USER", Content = "ENABLED", Duration = 2})
        else
            Rayfield:Notify({ Title = "CRASH USER", Content = "DISABLED", Duration = 2})
        end
    end
})

PlayerInput2 = ServerMiscTab:CreateInput({
    Name = "User to crash",
    CurrentValue = "",
    PlaceholderText = "username",
    RemoveTextAfterFocusLost = false,
    Flag = "LocatePlayerInput1",
    Callback = function(v)
    end
})

local CrashThreads = ServerMiscTab:CreateSlider({
    Name = "Crash Threads",
    Range = {1, 250},
    Increment = 1,
    Suffix = "T",
    CurrentValue = 25,
    Flag = "CrashThreads1", 
    Callback = function()
        
    end
})

task.spawn(function()
    while true do
        task.wait() 
        if CrashUser.CurrentValue == true and PlayerInput2.CurrentValue ~= "" then
            local target = game.Players:FindFirstChild(PlayerInput2.CurrentValue)
            if target then
                for i = 1, CrashThreads.CurrentValue do
                    task.spawn(function()
                        local args = {
                            [1] = "Send_Money",
                            [2] = 1.0123456789123346,
                            [3] = target
                        }
                        local success, result = pcall(function()
                            return remoteFunction:InvokeServer(unpack(args))
                        end)
                    end)
                end
            end
        end
    end
end)

local function fireServerBuy(amm, target)
    for i = 1, amm do
        local args = {
            [1] = "Send_Money",
            [2] = 1.0123456789123346,
            [3] = target
        }
        local success, result = pcall(function()
            return remoteFunction:InvokeServer(unpack(args))
        end)
        wait()
    end
end

local PlayerInput4
local LunchMoneyAmount
local CrashThreads2

local Crashv2 = ServerMiscTab:CreateButton({
    Name = "CrashV2",
    Callback = function()
        local target = nil
        for _, v in pairs(Players:GetPlayers()) do
            if v.Name:lower() == PlayerInput4.CurrentValue:lower() 
            or v.DisplayName:lower() == PlayerInput4.CurrentValue:lower() then
                target = v
                break
            end
        end

        if not target then
            Rayfield:Notify({
                Title = "CrashV2",
                Content = "Target player not found!",
                Duration = 3
            })
            return
        end

        local totalAmount = tonumber(LunchMoneyAmount.CurrentValue) or 0
        local threads = tonumber(CrashThreads2.CurrentValue) or 1
        if totalAmount <= 0 then return end
        if threads < 1 then threads = 1 end

        local perThread = math.ceil(totalAmount / threads)

        for t = 1, threads do
            task.spawn(function()
                fireServerBuy(perThread, target)
            end)
        end

        Rayfield:Notify({
            Title = "CrashV2",
            Content = string.format("Started %d threads (%d per thread)", threads, perThread),
            Duration = 5
        })
    end,
})

PlayerInput4 = ServerMiscTab:CreateInput({
    Name = "User to crash",
    CurrentValue = "",
    PlaceholderText = "username/displayname",
    RemoveTextAfterFocusLost = false,
    Flag = "PlayerInput412",
    Callback = function(v)

    end
})

LunchMoneyAmount = ServerMiscTab:CreateInput({
    Name = "Amount",
    CurrentValue = "",
    PlaceholderText = "number",
    RemoveTextAfterFocusLost = false,
    Flag = "LunchMoneyAmount1",
    Callback = function(v)

    end
})


CrashThreads2 = ServerMiscTab:CreateSlider({
    Name = "Crash Threads",
    Range = {1, 1000},
    Increment = 1,
    Suffix = "T",
    CurrentValue = 25,
    Flag = "CrashThreads2", 
    Callback = function()
        
    end
})

local Divider335 = ServerMiscTab:CreateDivider()

local cone21
local AntiCrash = ServerMiscTab:CreateToggle({
    Name = "Anticrash",
    CurrentValue = false,
    Flag = "AntiCrash1",
    Callback = function(value)
        if value then
            Rayfield:Notify({ Title = "ANTI-CRASH", Content = "ENABLED", Duration = 2})
        else
            Rayfield:Notify({ Title = "ANTI-CRASH", Content = "DISABLED", Duration = 2})
        end

        if value then
            if cone21 then
                cone21:Disconnect()
                cone21 = nil
            end
            cone21 = Notifications.ChildAdded:Connect(function(child)
                child:Destroy()
            end)
        else
            if cone21 then
                cone21:Disconnect()
                cone21 = nil
            end
        end
    end
})

local Divider335 = ServerMiscTab:CreateDivider()

local CrashUserV3
local PlayerInput10
CrashUserV3 = ServerMiscTab:CreateToggle({
    Name = "CRASH USER PARTY JOIN METHOD",
    CurrentValue = false,
    Flag = "CrashUserV3",
    Callback = function(value)
        if value then
            Rayfield:Notify({ Title = "CRASH USER", Content = "ENABLED", Duration = 2})
        else
            Rayfield:Notify({ Title = "CRASH USER", Content = "DISABLED", Duration = 2})
        end
    end
})
local CrashThreads4

PlayerInput10 = ServerMiscTab:CreateInput({
    Name = "User to crash",
    CurrentValue = "",
    PlaceholderText = "username",
    RemoveTextAfterFocusLost = false,
    Flag = "LocatePlayerInput1",
    Callback = function(v)
    end
})

CrashThreads4 = ServerMiscTab:CreateSlider({
    Name = "Crash Threads",
    Range = {1, 25},
    Increment = 1,
    Suffix = "T",
    CurrentValue = 10,
    Flag = "CrashThreads4", 
    Callback = function()
        
    end
})

task.spawn(function()
    while true do
        task.wait() 
        if CrashUserV3.CurrentValue == true and PlayerInput10.CurrentValue ~= "" then
            local target = game.Players:FindFirstChild(PlayerInput10.CurrentValue)
            if target then
                for i = 1, CrashThreads4.CurrentValue do
                    task.spawn(function()
                        local args = {
                            "AcceptPartyInvite",
                            target
                        }
                        teleportRemote:FireServer(unpack(args))
                        local args2 = {
                            "Leave_Party",
                            target
                        }
                        teleportRemote:FireServer(unpack(args2))
                    end)
                end
            end
        end
    end
end)

local conn8934
local CrashOnJoin = ServerMiscTab:CreateToggle({
    Name = "Crash on Game Join",
    CurrentValue = false,
    Flag = "CrashOnJoin1",
    Callback = function(value)
        if value then
            Rayfield:Notify({ Title = "CrashOnJoin", Content = "ENABLED", Duration = 2})
            
            if conn8934 then
                conn8934:Disconnect()
                conn8934 = nil
            end

            conn8934 = Players.PlayerAdded:Connect(function(p)
                local char = p.Character or p.CharacterAdded:Wait()
                local root = char:WaitForChild("HumanoidRootPart")
                char:WaitForChild("Core")
                if p.Name == PlayerInput10.CurrentValue then
                    local old = CrashThreads4.CurrentValue
                    CrashThreads4:Set(8)
                    CrashUserV3:Set(true)
                    task.wait(18)
                    CrashUserV3:Set(false)
                    CrashThreads4:Set(old)
                end
            end)
        else
            Rayfield:Notify({ Title = "CrashOnJoin", Content = "DISABLED", Duration = 2})
            if conn8934 then
                conn8934:Disconnect()
                conn8934 = nil
            end
        end
    end
})


local Divider33425 = ServerMiscTab:CreateDivider()

local CrashUserV4
CrashUserV4 = ServerMiscTab:CreateToggle({
    Name = "SPAM INVITE",
    CurrentValue = false,
    Flag = "CrashUserV41",
    Callback = function(value)
        if value then
            Rayfield:Notify({ Title = "SPAM USER", Content = "ENABLED", Duration = 2})
        else
            Rayfield:Notify({ Title = "SPAM USER", Content = "DISABLED", Duration = 2})
        end
    end
})

local PlayerInput5 = ServerMiscTab:CreateInput({
    Name = "User to spam invites",
    CurrentValue = "",
    PlaceholderText = "username",
    RemoveTextAfterFocusLost = false,
    Flag = "LocatePlayerInput1",
    Callback = function(v)
    end
})


task.spawn(function()
    while true do
        task.wait()
        if CrashUserV4.CurrentValue == true and PlayerInput5.CurrentValue ~= "" then
            local target = game.Players:FindFirstChild(PlayerInput5.CurrentValue)
            if target then
                task.spawn(function()
                    local inviteArgs = {
                        [1] = "InviteToParty",
                        [2] = target
                    }

                    local args = {
                        [1] = "KickFromParty",
                        [2] = target
                    }

                    teleportRemote:FireServer(unpack(inviteArgs))
                    task.wait(0.1)
                    teleportRemote:FireServer(unpack(args))
                end)
            end
        end
    end
end)


local Divider33a25 = ServerMiscTab:CreateDivider()

local JoinpartUser

local JoinPartyButton = ServerMiscTab:CreateButton({
    Name = "Join Party",
    Callback = function()
        for i, v in pairs(Players:GetPlayers()) do
            if v.Name:lower() == JoinpartUser.CurrentValue:lower() or v.DisplayName:lower() == JoinpartUser.CurrentValue:lower() then
                local args = {
                    "AcceptPartyInvite",
                    v
                }
                teleportRemote:FireServer(unpack(args))
                break
            end
        end
    end,
})

JoinpartUser = ServerMiscTab:CreateInput({
    Name = "User to join party",
    CurrentValue = "",
    PlaceholderText = "type display/user/Id",
    RemoveTextAfterFocusLost = false,
    Flag = "JoinpartUser1",
    Callback = function(v)

    end
})

local LeaveCurrentParty = ServerMiscTab:CreateButton({
    Name = "Leave Current Party",
    CurrentValue = "",
    PlaceholderText = "type display/user/Id",
    RemoveTextAfterFocusLost = false,
    Flag = "JoinpartUser1",
    Callback = function(v)
        for i, v in pairs(Players:GetPlayers()) do
            local args2 = {
                "Leave_Party",
                v
            }
            teleportRemote:FireServer(unpack(args2))
        end
    end
})

LocalPlayer.CharacterAdded:Connect(function()
    if LoopKillUser.CurrentValue and not alreadySpawned2 then
        alreadySpawned2 = true
        spawnAttackTasks2()
    end
end)

KillFarm  = AutoFarmTab:CreateToggle({
Name = "Kill Farm",
CurrentValue = false,
Flag = "KillFarm1",
Callback = function(value)
        if value == true then
            Rayfield:Notify({ Title = "SCRIPT", Content = "ENABLED KillFarm", Duration = 2})
            enableHoldFist()
        else
            Rayfield:Notify({ Title = "SCRIPT", Content = "DISABLED KillFarm", Duration = 2})
            disableHoldFist()
        end
end
})

local Divideaar33a25 = AutoFarmTab:CreateDivider()

getgenv().Label2 = AutoFarmTab:CreateLabel("RESPECT FARM")

TPPLOT1  = AutoFarmTab:CreateToggle({
    Name = "TP PLOT 1",
    CurrentValue = false,
    Flag = "TPPLOT12",
    Callback = function(value)

    end
})

task.spawn(function()
    while true do
        task.wait(0.01)
        if TPPLOT1.CurrentValue == true then
            pcall(function()
                LocalPlayer.Character:MoveTo(Vector3.new(-74, 5, -4))
            end)
        end
    end
end)

TPPLOT2  = AutoFarmTab:CreateToggle({
    Name = "TP PLOT 2",
    CurrentValue = false,
    Flag = "TPPLOT21",
    Callback = function(value)

    end
})

task.spawn(function()
    while true do
        task.wait(0.01)
        if TPPLOT2.CurrentValue == true then
            pcall(function()
                LocalPlayer.Character:MoveTo(Vector3.new(-83, 5, -5))
            end)
        end
    end
end)

AUTORESETPLAYER  = AutoFarmTab:CreateToggle({
    Name = "AUTO RESET PLAYER",
    CurrentValue = false,
    Flag = "TPPLOT21",
    Callback = function(value)

    end
})

task.spawn(function()
    while true do
        wait(0.01)
        if AUTORESETPLAYER.CurrentValue == true then
            task.wait(3)
            pcall(function()
                LocalPlayer.Character.Humanoid:TakeDamage(100)
            end)
        end
    end
end)

local attackInterval
local LoopDamage  = EventsTab:CreateToggle({
Name = "HUNGER / HEALTH GAMES",
CurrentValue = false,
Flag = "LoopDamage",
Callback = function(value)
        if value == true then
            Rayfield:Notify({ Title = "SCRIPT", Content = "ENABLED HUNGER GAMES", Duration = 2})
        else
            Rayfield:Notify({ Title = "SCRIPT", Content = "DISABLED HUNGER GAMES", Duration = 2})
        end
    end
})

attackInterval = EventsTab:CreateSlider({
    Name = "Time between messages",
    Range = {1, 10},
    Increment = 0.01,
    Suffix = "S",
    CurrentValue = 1.30,
    Flag = "attackInterval1", 
    Callback = function()
        
    end
})

local Divider3352 = EventsTab:CreateDivider()

getgenv().GiveAllKillAura  = EventsTab:CreateToggle({
Name = "Killaura For All",
CurrentValue = false,
Flag = "GiveAllKillAura1",
Callback = function(value)
        if value == true then
            Rayfield:Notify({ Title = "SCRIPT", Content = "ENABLED GiveAllKillAura", Duration = 2})
        else
            Rayfield:Notify({ Title = "SCRIPT", Content = "DISABLED GiveAllKillAura", Duration = 2})
        end
    end
})


getgenv().GiveAllGodAuraRange = EventsTab:CreateSlider({
Name = "God Aura Range",
Range = {1, 380},
Increment = 1,
Suffix = "M",
CurrentValue = 10,
Flag = "GodAuraRange1", 
Callback = function()
    
end
})

getgenv().GiveAllGodAuraSpeed = EventsTab:CreateSlider({
Name = "God Aura Speed",
Range = {0, 10},
Increment = 0.01,
Suffix = "s",
CurrentValue = 0.05,
Flag = "GodAuraSpeed1", 
Callback = function()
        
end
})

getgenv().ExcludeLocalPlayer2  = EventsTab:CreateToggle({
Name = "Exclude Local Player",
CurrentValue = false,
Flag = "ExcludeLocalPlayer21",
Callback = function(value)
        if value == true then
            Rayfield:Notify({ Title = "SCRIPT", Content = "ENABLED Exclude Local Player", Duration = 2})
        else
            Rayfield:Notify({ Title = "SCRIPT", Content = "DISABLED Exclude Local Player", Duration = 2})
        end
    end
})


ThrowPlayerKeybind = SettingsTab:CreateKeybind({
Name = "Throw Player",
CurrentKeybind = "X",
HoldToInteract = false,
Flag = "ThrowPlayerKeybind1", 
Callback = function(Keybind)

end,
})

local Divider3352 = ServerMiscTab:CreateDivider()

local function Color3ToHex(c)
    local r, g, b = math.floor(c.R * 255), math.floor(c.G * 255), math.floor(c.B * 255)
    return string.format("#%02X%02X%02X", r, g, b)
end

local msgInput
local timeSlider

getgenv().SendMessage = ServerMiscTab:CreateButton({
    Name = "Send Message",
    Callback = function()
        local role = getgenv().chatRoleTag.CurrentValue or ""
        local msg = msgInput.CurrentValue or ""
        local size = getgenv().chatMessageSize.CurrentValue or ""
        local msgColor = getgenv().chatMessageColor.Color or Color3.new(0,0,0)
        local tagColor = getgenv().RoleTagColor.Color or Color3.new(0,0,0)

        if msg == "" then
            return
        end

        local msgHex = Color3ToHex(msgColor)
        local tagHex = Color3ToHex(tagColor)

        local formattedMsg = ""

        if role ~= "" then
            formattedMsg ..= '<font color="'..tagHex..'"'
            if size ~= "" then formattedMsg ..= ' size="'..size..'"' end
            formattedMsg ..= '>'..role..'</font> '
        end

        formattedMsg ..= '<font'
        if msgHex ~= "" then formattedMsg ..= ' color="'..msgHex..'"' end
        if size ~= "" then formattedMsg ..= ' size="'..size..'"' end
        formattedMsg ..= '>'..msg..'</font>'

        if teleportRemote then
            teleportRemote:FireServer("Broadcast", formattedMsg, 1)
        end
    end
})

local ChatSpam = ServerMiscTab:CreateToggle({
    Name = "ChatSpam",
    CurrentValue = false,
    Flag = "ChatSpam1",
    Callback = function(value)
        if value == true then
            Rayfield:Notify({ Title = "SCRIPT", Content = "ENABLED CHAT SPAM", Duration = 2})
        else
            Rayfield:Notify({ Title = "SCRIPT", Content = "DISABLED CHAT SPAM", Duration = 2})
        end
    end
})

getgenv().chatMessageColor = ServerMiscTab:CreateColorPicker({
    Name = "Message Color",
    Color = Color3.fromRGB(0, 0, 0),
    Flag = "MessageColorPicker",
    Callback = function(Value)
    end
})

getgenv().RoleTagColor = ServerMiscTab:CreateColorPicker({
    Name = "Role Tag Color",
    Color = Color3.fromRGB(0, 0, 0),
    Flag = "RoleTagColorPicker",
    Callback = function(Value)
    end
})

getgenv().chatMessageSize = ServerMiscTab:CreateInput({
    Name = "Chat Message Size",
    CurrentValue = "",
    PlaceholderText = "Enter font size (e.g. 14)",
    RemoveTextAfterFocusLost = false,
    Flag = "chatMessageSizeFlag",
    Callback = function(value)
    end
})

getgenv().chatRoleTag = ServerMiscTab:CreateInput({
    Name = "Chat Role Tag",
    CurrentValue = "",
    PlaceholderText = "Enter role name (e.g. [MOD])",
    RemoveTextAfterFocusLost = false,
    Flag = "chatRoleTagFlag",
    Callback = function(value)
    end
})

task.spawn(function()
    while true do
        wait(0.01)

        if ChatSpam.CurrentValue == true then
            local delay = timeSlider.CurrentValue or 1
            wait(delay)

            local role = getgenv().chatRoleTag.CurrentValue or ""
            local msg = msgInput.CurrentValue or ""
            local size = getgenv().chatMessageSize.CurrentValue or ""
            local msgColor = getgenv().chatMessageColor.Color or Color3.new(0,0,0)
            local tagColor = getgenv().RoleTagColor.Color or Color3.new(0,0,0)

            if msg == "" then continue end

            local msgHex = Color3ToHex(msgColor)
            local tagHex = Color3ToHex(tagColor)
            local formattedMsg = ""

            if role ~= "" and tagHex == msgHex and tagHex ~= "" then
                local attrs = ' color="'..tagHex..'"' .. (size ~= "" and ' size="'..size..'"' or "")
                formattedMsg = '<font'..attrs..'>'..role..' '..msg..'</font>'
            else
                if role ~= "" then
                    local attrs = (tagHex ~= "" and ' color="'..tagHex..'"' or "") .. (size ~= "" and ' size="'..size..'"' or "")
                    formattedMsg ..= '<font'..attrs..'>'..role..'</font> '
                end

                if msgHex == "" and size == "" then
                    formattedMsg ..= msg
                else
                    local attrs = (msgHex ~= "" and ' color="'..msgHex..'"' or "") .. (size ~= "" and ' size="'..size..'"' or "")
                    formattedMsg ..= '<font'..attrs..'>'..msg..'</font>'
                end
            end

            if teleportRemote then
                teleportRemote:FireServer("Broadcast", formattedMsg, 1)
            end
        end
    end
end)

 msgInput = ServerMiscTab:CreateInput({
    Name = "Msg to Spam",
    CurrentValue = "",
    PlaceholderText = "",
    RemoveTextAfterFocusLost = false,
    Flag = "msgInput1",
    Callback = function(v)

    end
})

timeSlider = ServerMiscTab:CreateSlider({
    Name = "Time between messages",
    Range = {1, 10},
    Increment = 1,
    Suffix = "S",
    CurrentValue = 3,
    Flag = "timeSlider1", 
    Callback = function()
        
    end
})

getgenv().FreeCode = ServerMiscTab:CreateButton({
    Name = "Set to Free Code",
    Callback = function()
        msgInput:Set("FREE CODE 11")
        getgenv().chatMessageSize:Set(84)
        timeSlider:Set(7)
        getgenv().chatMessageColor:Set(Color3.fromRGB(255,0,0))
    end
})

local Divider3352 = ServerMiscTab:CreateDivider()
local TeleportToVC = ServerMiscTab:CreateButton({
Name = "Teleport To VC",
Callback = function()
        local success, result = pcall(function()
            return httpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/18248633989/servers/Public?sortOrder=Asc&limit=100"))
        end)
        if success and result and result.data then
            for i, v in ipairs(result.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    table.insert(servers1, v.id)
                end
            end
        end
    
        if #servers1 > 0 then
            local serverid = servers1[math.random(1,#servers1)]
            Rayfield:Notify({ Title = "SCRIPT", Content = "ATTEMPTING TELEPORT", Duration = 2})
            TeleportService:TeleportToPlaceInstance(18248633989, serverid, game.Players.LocalPlayer)
        end
end,
})

local TeleportToPRO = ServerMiscTab:CreateButton({
Name = "Teleport To PRO",
Callback = function()
        local success, result = pcall(function()
            return httpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/86098085533596/servers/Public?sortOrder=Asc&limit=100"))
        end)
        if success and result and result.data then
            for i, v in ipairs(result.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    table.insert(servers2, v.id)
                end
            end
        end

        if #servers2 > 0 then
            local serverid = servers2[math.random(1,#servers2)]
            Rayfield:Notify({ Title = "SCRIPT", Content = "ATTEMPTING TELEPORT", Duration = 2})
            TeleportService:TeleportToPlaceInstance(86098085533596, serverid, game.Players.LocalPlayer)
        end
end,
})

local Rejoin = ServerMiscTab:CreateButton({
Name = "REJOIN",
Callback = function()
    pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
    end)
end,
})

local Divider3352 = ServerMiscTab:CreateDivider()

local TeleportInfoParagraph
local LocatePlayerInput
local TeleporToPlayer = ServerMiscTab:CreateButton({
    Name = "Get Player Server Info",
    Callback = function()
        local targetJobId = nil
        local targetKey
        local targetServerName = "Unknown"
        local targetRegion = "Unknown"
        local targetPlayerCount = "0"
        local data = nil
        
        repeat
            task.wait(1)
            Rayfield:Notify({ Title = "SERVER INFO", Content = "Getting data...", Duration = 2})
            local success, result = pcall(function()
                return remoteFunction:InvokeServer("GetServerBrowsingData")
            end)
            if success and result ~= nil then
                data = result
                Rayfield:Notify({ Title = "SERVER INFO", Content = "Got data", Duration = 2})
            else
                Rayfield:Notify({ Title = "SERVER INFO", Content = "Failed to get data from server, retrying...", Duration = 2})
            end
        until data ~= nil

        local targetUserId = getUserIdFromName(LocatePlayerInput.CurrentValue)

        for _, v in pairs(data) do
            local key = v.key
            local jobID = v.value.Place_ID
            local playerList = v.value.Player_ID_Array

            for _, userID in pairs(playerList) do
                if targetUserId == userID then
                    targetJobId = jobID
                    targetKey = key
                    targetServerName = v.value.Name or "Unknown"
                    targetPlayerCount = tostring(v.value.Player_Count or 0) .. "/" .. tostring(game.Players.MaxPlayers)
                    if v.value.Region then
                        targetRegion = v.value.Region.region .. "/" .. v.value.Region.regionName .. " (" .. v.value.Region.countryCode .. ")"
                    end
                end
            end
        end

        if targetJobId then
            TeleportInfoParagraph:Set({
                Title = "SERVER INFO:",
                Content = 
                    "Server Name: " .. targetServerName .. "\n" ..
                    "Region: " .. targetRegion .. "\n" ..
                    "Players: " .. targetPlayerCount .. "\n"
            })
            Rayfield:Notify({ Title = "SERVER INFO", Content = "FOUND PLAYER SERVER", Duration = 2})
        else
            Rayfield:Notify({ Title = "SERVER INFO", Content = "FAILED TO FIND PLAYER SERVER", Duration = 2})

            TeleportInfoParagraph:Set({
                Title = "SERVER INFO:",
                Content = "PLAYER IS NOT IN SERVERS ( RESETTING PARAGRAPH )"
            })

            wait(3)

            TeleportInfoParagraph:Set({
                Title = "SERVER INFO:",
                Content = "None"
            })
        end
    end,
})

LocatePlayerInput = ServerMiscTab:CreateInput({
    Name = "User to attempt teleport",
    CurrentValue = "",
    PlaceholderText = "type display/user/Id",
    RemoveTextAfterFocusLost = false,
    Flag = "LocatePlayerInput1",
    Callback = function(v)
        
    end
})

TeleportInfoParagraph = ServerMiscTab:CreateParagraph({
    Title = "SERVER INFO:", 
    Content = "None"
})

getgenv().ServerHopDivider = ServerMiscTab:CreateDivider()

getgenv().ServerHopToggle = ServerMiscTab:CreateToggle({
    Name = "Auto Server Hop",
    CurrentValue = false,
    Flag = "ServerHopToggle1",
    Callback = function(value)
        if value then
            Rayfield:Notify({ Title = "SCRIPT", Content = "ENABLED AUTO SERVER HOP", Duration = 2})
        else
            Rayfield:Notify({ Title = "SCRIPT", Content = "DISABLED AUTO SERVER HOP", Duration = 2})
        end
    end
})

getgenv().ServerHopThreshold = ServerMiscTab:CreateSlider({
    Name = "Minimum Players",
    Range = {1, 20},
    Increment = 1,
    Suffix = " players",
    CurrentValue = 10,
    Flag = "ServerHopThreshold1", 
    Callback = function() end
})

getgenv().AvailableServers = {}
getgenv().HttpService = game:GetService("HttpService")
getgenv().TeleportService = game:GetService("TeleportService")

task.spawn(function()
    while true do
        task.wait(1.5) 

        if getgenv().ServerHopToggle.CurrentValue then
            if #game.Players:GetPlayers() < getgenv().ServerHopThreshold.CurrentValue then
                local success, result = pcall(function()
                    return getgenv().HttpService:JSONDecode(
                        game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
                    )
                end)

                if success and result and result.data then
                    table.clear(getgenv().AvailableServers)
                    for _, v in ipairs(result.data) do
                        if v.playing > getgenv().ServerHopThreshold.CurrentValue + 5 
                        and v.playing < v.maxPlayers 
                        and v.id ~= game.JobId then 
                            table.insert(getgenv().AvailableServers, v.id)
                        end
                    end
                end


                if #getgenv().AvailableServers > 0 then
                    local serverId = getgenv().AvailableServers[math.random(1, #getgenv().AvailableServers)]
                    Rayfield:Notify({ Title = "SCRIPT", Content = "ATTEMPTING SERVER HOP", Duration = 2})
                    getgenv().TeleportService:TeleportToPlaceInstance(game.PlaceId, serverId, game.Players.LocalPlayer)
                end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(GodAuraSpeed.CurrentValue)
        pcall(function()
            if GodAura.CurrentValue == true then
                local character = LocalPlayer.Character
                if not character then return end

                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if not rootPart then return end

                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and not table.find(whitelistedPlayers, plr.DisplayName) and plr.Character then
                        local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            if not IngoreHP.CurrentValue and humanoid.Health <= 0 then
                                
                            else
                                local primaryPart = plr.Character:FindFirstChild("HumanoidRootPart")
                                if primaryPart then
                                    local distance = (rootPart.Position - primaryPart.Position).Magnitude
                                    if distance <= GodAuraRange.CurrentValue then
                                        attack(plr, "POSTER_HIT")
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

task.spawn(function()
    while true do
        task.wait(attackInterval.CurrentValue)
        pcall(function()
            if LoopDamage.CurrentValue == true then
                local character = LocalPlayer.Character
                if not character then return end

                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if not rootPart then return end

                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character then
                        local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid.Health > 0 then
                            attack(plr, "POSTER_HIT")
                        end
                    end
                end
            end
        end)
    end
end)

local maxDistance = 20
task.spawn(function()
    while true do
        task.wait(0.035)
        pcall(function()
            if OldAura.CurrentValue == true then
                local character = LocalPlayer.Character
                if not character then return end

                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if not rootPart then return end

                local attackFunctions = {
                    ["Slam"] = function(target)
                        attack(target, "Slam")
                    end,
                    ["Heavy"] = function(target)
                        attack(target, "Heavy")
                    end,
                    ["Attack"] = function(target)
                        attack(target, "Attack")
                    end,
                    ["Shove"] = function(target)
                        attack(target, "Shove")
                    end,
                }

                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character and not table.find(oldaurawhitelistedplayers, plr.DisplayName) then
                        local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
                        local primaryPart = plr.Character:FindFirstChild("HumanoidRootPart")
                        if humanoid and humanoid.Health > 0 and primaryPart then
                            local distance = (rootPart.Position - primaryPart.Position).Magnitude
                            if distance <= maxDistance then
                                for _, attackName in pairs(AttackOptions.CurrentOption) do
                                    local attackFunc = attackFunctions[attackName]
                                    if attackFunc then
                                        task.spawn(function()
                                            attackFunc(plr)
                                        end)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)


task.spawn(function()
    while true do
        task.wait(0.01)
        pcall(function()
            if Weaken.CurrentValue == true then
                if OldAura.CurrentValue == true then
                    local character = LocalPlayer.Character
                    if not character then return end

                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if not rootPart then return end

                    for _, plr in pairs(Players:GetPlayers()) do
                        if not table.find(oldaurawhitelistedplayers, plr.DisplayName) then 
                            if plr ~= LocalPlayer and plr.Character then
                                local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
                                if humanoid then
                                    local primaryPart = plr.Character:FindFirstChild("HumanoidRootPart")
                                    if primaryPart then
                                        local distance = (rootPart.Position - primaryPart.Position).Magnitude
                                        if distance <= 1.25 then
                                            attack(plr, "POSTER_HIT")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

task.spawn(function()
    while true do
        task.wait(0.035)
        pcall(function()
            if AttackAura.CurrentValue == true then
                local character = LocalPlayer.Character
                if not character then return end

                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if not rootPart then return end

                for _, plr in pairs(Players:GetPlayers()) do
                    if not table.find(aurawhitelistedplayers, plr.DisplayName) then 
                        if plr ~= LocalPlayer and plr.Character then
                            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
                            if humanoid then
                                local primaryPart = plr.Character:FindFirstChild("HumanoidRootPart")
                                if primaryPart then
                                    local distance = (rootPart.Position - primaryPart.Position).Magnitude
                                    if distance <= 6 then
                                        attack(plr, "Attack")
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

local args = {
    [1] = "EQUIP_SPRAYCAN"
}

local args2 = {
    [1] = "SPRAYCAN"
}


task.spawn(function()
    while true do
        task.wait(0.035)
        pcall(function()
            if SprayCanAura.CurrentValue == true then
                local character = LocalPlayer.Character
                if not character then return end

                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if not rootPart then return end

                for _, plr in pairs(Players:GetPlayers()) do
                    if not table.find(aurawhitelistedplayers, plr.DisplayName) then 
                        if plr ~= LocalPlayer and plr.Character then
                            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
                            if humanoid then
                                local primaryPart = plr.Character:FindFirstChild("HumanoidRootPart")
                                if primaryPart then
                                    local distance = (rootPart.Position - primaryPart.Position).Magnitude
                                    if distance <= 6 then
                                        local re = getRemote()
                                        re:FireServer(unpack(args))
                                        re:FireServer(unpack(args2))
                                        local spray = LocalPlayer.Character:FindFirstChild("Spraycan")
                                        if spray then
                                            spray:Destroy()
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

task.spawn(function()
    while true do
        task.wait(GivenGodAuraSpeed.CurrentValue)
        pcall(function()
            if GiveGodAura.CurrentValue == true then
                local character
                for i, v in pairs(Players:GetPlayers()) do
                    local targetName = GivenGodAuraOwner.CurrentValue:lower()
                    if v.DisplayName:lower() == targetName or v.Name:lower() == targetName then
                        character = v.Character
                    end
                end
                if not character then return end

                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if not rootPart then return end
                for _, plr in pairs(Players:GetPlayers()) do
                    if not table.find(givenwhitelistedPlayers, plr.DisplayName) then 
                        if plr.Character ~= character and plr.Character and plr.Character.Humanoid.Health > 0 then
                            local primaryPart = plr.Character:FindFirstChild("HumanoidRootPart")
                            if primaryPart then
                                local distance = (rootPart.Position - primaryPart.Position).Magnitude
                                if distance <= GivenGodAuraRange.CurrentValue then
                                    attack(plr, "POSTER_HIT")
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

task.spawn(function()
    while true do
        task.wait(getgenv().GiveAllGodAuraSpeed.CurrentValue)
        pcall(function()
            if getgenv().GiveAllKillAura.CurrentValue == true then
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer then
                        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChildOfClass("Humanoid") then
                            if plr.Character.Humanoid.Health > 0 then
                                local primaryPart = plr.Character.HumanoidRootPart
                                for _, attacker in pairs(Players:GetPlayers()) do
                                    if attacker ~= plr and attacker.Character and attacker.Character:FindFirstChild("HumanoidRootPart") then
                                        local rootPart = attacker.Character.HumanoidRootPart
                                        local distance = (rootPart.Position - primaryPart.Position).Magnitude

                                        if distance <= getgenv().GiveAllGodAuraRange.CurrentValue then
                                            if not (getgenv().ExcludeLocalPlayer2.CurrentValue and plr == LocalPlayer) then
                                                attack(plr, "POSTER_HIT")
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

task.spawn(function()
    while true do
        task.wait(0.05)
        pcall(function()
            if AutoShove.CurrentValue == true then
                local character = LocalPlayer.Character
                if not character then return end

                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if not rootPart then return end

                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                        if not table.find(whitelistedPlayers, plr.DisplayName) then
                            local targetPart = plr.Character:FindFirstChild("HumanoidRootPart")
                            if targetPart then
                                local distance = (rootPart.Position - targetPart.Position).Magnitude
                                if distance <= 25 then
                                    attack(plr, "Shove")
                                    task.wait(0.03)
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

getgenv().FINISH_HEALTH = getgenv().FINISH_HEALTH or 36
getgenv().currentTarget = nil
getgenv().lastTarget = nil
getgenv().targetStartTime = 0

local function invalidateTarget()
    getgenv().lastTarget = getgenv().currentTarget 
    getgenv().currentTarget = nil
    getgenv().targetStartTime = 0
end

task.spawn(function()
    while true do
        task.wait(0.023)

        if KillFarm and KillFarm.CurrentValue then
            local localPlayer = Players.LocalPlayer
            if localPlayer then
                local localChar = localPlayer.Character
                local localHRP = localChar and localChar:FindFirstChild("HumanoidRootPart")
                if localHRP then
                    
                    if getgenv().currentTarget then
                        local targetChar = getgenv().currentTarget.Character
                        local targetHum = targetChar and targetChar:FindFirstChildOfClass("Humanoid")

                        if not targetChar or not targetHum or targetHum.Health <= 0 
                            or targetChar:FindFirstChildWhichIsA("Highlight") 
                            or (os.clock() - getgenv().targetStartTime > 5) then
                            invalidateTarget()
                        end
                    end

                    if not getgenv().currentTarget then
                        local closestDist = math.huge
                        local closestPlr = nil

                        for _, plr in pairs(Players:GetPlayers()) do
                            if plr ~= localPlayer and plr ~= getgenv().lastTarget then 
                                local char = plr.Character
                                if char and not char:FindFirstChildWhichIsA("Highlight") then
                                    local hrp = char:FindFirstChild("HumanoidRootPart")
                                    local hum = char:FindFirstChildOfClass("Humanoid")
                                    if hrp and hum and hum.Health > 0 then
                                        local dist = (localHRP.Position - hrp.Position).Magnitude
                                        if dist < closestDist then
                                            closestDist = dist
                                            closestPlr = plr
                                        end
                                    end
                                end
                            end
                        end

                        if closestPlr then
                            getgenv().currentTarget = closestPlr
                            getgenv().targetStartTime = os.clock()
                        else
                            getgenv().lastTarget = nil 
                        end
                    end

                    if getgenv().currentTarget then
                        local targetChar = getgenv().currentTarget.Character
                        local targetHum = targetChar and targetChar:FindFirstChildOfClass("Humanoid")
                        local targetHRP = targetChar and targetChar:FindFirstChild("HumanoidRootPart")

                        if targetChar and targetHum and targetHRP then
                            localChar:MoveTo(targetHRP.Position)

                            if targetHum.Health <= getgenv().FINISH_HEALTH then
                                task.spawn(function() attack(getgenv().currentTarget, "Slam") end)
                                task.spawn(function() attack(getgenv().currentTarget, "Heavy") end)
                                task.spawn(function() attack(getgenv().currentTarget, "Attack") end)
                            else
                                attack(getgenv().currentTarget, "POSTER_HIT")
                            end
                        else
                            invalidateTarget()
                        end
                    end
                end
            end
        else
            getgenv().currentTarget = nil
            getgenv().lastTarget = nil
            getgenv().targetStartTime = 0
        end
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if not player then return end

    local index
    for i, nameInList in ipairs(whitelistedPlayers) do
        if nameInList:lower() == player.DisplayName:lower() or nameInList:lower() == player.Name:lower() then
            index = i
            break
        end
    end
    
    if index then
        table.remove(whitelistedPlayers, index)
        local newContent = #whitelistedPlayers > 0 and table.concat(whitelistedPlayers, ", ") or "None"
        WhitelistedUsers:Set({ Title = "Whitelisted Users:", Content = newContent })
        Rayfield:Notify({ Title = "WHITELIST", Content = "Removed: " .. player.DisplayName .. " from whitelist | Reason: Left game!", Duration = 2 })
    end

    local killIndex
    for i, nameInList in ipairs(playersToKill) do
        if nameInList:lower() == player.DisplayName:lower() or nameInList:lower() == player.Name:lower() then
            killIndex = i
            break
        end
    end
                      
    if killIndex then
        table.remove(playersToKill, killIndex)
        local newKillContent = #playersToKill > 0 and table.concat(playersToKill, ", ") or "None"
        KillingPlayers:Set({ Title = "Users To Kill:", Content = newKillContent })
        Rayfield:Notify({ Title = "SCRIPT", Content = "Removed: " .. player.DisplayName .. " from killing player textbox | Reason: Left game!", Duration = 2 })
    end
    
    local index2
    for i, nameInList in ipairs(givenwhitelistedPlayers) do
        if nameInList:lower() == player.DisplayName:lower() or nameInList:lower() == player.Name:lower() then
            index2 = i
            break
        end
    end

    if index2 then
        table.remove(givenwhitelistedPlayers, index2)
        local newContent = #givenwhitelistedPlayers > 0 and table.concat(givenwhitelistedPlayers, ", ") or "None"
        GivenWhitelistedUsers:Set({ Title = "Whitelisted Users:", Content = newContent })
        Rayfield:Notify({ Title = "WHITELIST", Content = "Removed :"..player.DisplayName.." from whitelist".. "reason: ".. "left game!", Duration = 2})
    end

    local index3
    for i, nameInList in ipairs(aurawhitelistedplayers) do
        if nameInList:lower() == player.DisplayName:lower() or nameInList:lower() == player.Name:lower() then
            index3 = i
            break
        end
    end
    if index3 then
        table.remove(aurawhitelistedplayers, index3)
        local newContent = #aurawhitelistedplayers > 0 and table.concat(aurawhitelistedplayers, ", ") or "None"
        WhitelistedUsers35:Set({ Title = "Whitelisted Users:", Content = newContent })
        Rayfield:Notify({ Title = "WHITELIST", Content = "Removed :"..player.DisplayName.." from whitelist".. "reason: ".. "left game!", Duration = 2})
    end

    local index4
    for i, nameInList in ipairs(oldaurawhitelistedplayers) do
        if nameInList:lower() == player.DisplayName:lower() or nameInList:lower() == player.Name:lower() then
            index4 = i
            break
        end
    end
    if index4 then
        table.remove(oldaurawhitelistedplayers, index4)
        local newContent = #oldaurawhitelistedplayers > 0 and table.concat(oldaurawhitelistedplayers, ", ") or "None"
        WhitelistedUsers353:Set({ Title = "Whitelisted Users:", Content = newContent })
        Rayfield:Notify({ Title = "WHITELIST", Content = "Removed :"..player.DisplayName.." from whitelist".. "reason: ".. "left game!", Duration = 2})
    end

    local index5
    for i, nameInList in ipairs(spraywhitelistedplayers) do
        if nameInList:lower() == player.DisplayName:lower() or nameInList:lower() == player.Name:lower() then
            index5 = i
            break
        end
    end
    if index5 then
        table.remove(spraywhitelistedplayers, index5)
        local newContent = #spraywhitelistedplayers > 0 and table.concat(spraywhitelistedplayers, ", ") or "None"
        WhitelistedUsers1122:Set({ Title = "Whitelisted Users:", Content = newContent })
        Rayfield:Notify({ Title = "WHITELIST", Content = "Removed :"..player.DisplayName.." from whitelist".. "reason: ".. "left game!", Duration = 2})
    end

    if player.DisplayName:lower() == GivenGodAuraOwner.CurrentValue:lower() or player.Name:lower() == GivenGodAuraOwner.CurrentValue:lower() then
        Rayfield:Notify({ Title = "SCRIPT", Content = "Removed :"..player.DisplayName.." from chosen one textbox".. "reason: ".. "left game!", Duration = 2})
        GivenGodAuraOwner:Set("")
    end
end)

ChatList.ChildAdded:Connect(function(msg)
    if msg:IsA("Frame") then
        local mainChatCell = msg:FindFirstChild("Main")
        if not mainChatCell then return end

        local labelChatCell = mainChatCell:FindFirstChild("Label")
        if not labelChatCell then return end

        local text = labelChatCell.Text:lower()

        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Name == LocalPlayer.Name or plr.DisplayName == LocalPlayer.DisplayName then
                if string.find(text, plr.Name:lower()) then
                    local command = string.match(text, "^.-: /(.*)")
                    if command then
                        if command:find("^aura$") then
                            GodAura:Set(not GodAura.CurrentValue)
                        elseif command:find("^aurarange") then
                            local number = string.match(command, "aurarange%s+(%d+)")
                            if number then
                                number = tonumber(number)
                                if number >= 1 and number <= 380 then
                                    GodAuraRange:Set(number)
                                end
                            end
                        elseif command:find("^auraspeed") then
                            local number = string.match(command, "auraspeed%s+([%d%.]+)")
                            if number then
                                number = tonumber(number)
                                if number >= 0.01 and number <= 10 then
                                    GodAuraSpeed:Set(number)
                                end
                            end
                        elseif command:find("whitelist") then
                            local name = string.match(command, "whitelist%s+(.+)")
                            local nametoWhitelist
                            if name then
                                for i, v in pairs(Players:GetPlayers()) do
                                    if v ~= LocalPlayer then
                                        if v.Name:lower() == name or v.DisplayName:lower() == name then
                                            nametoWhitelist = v.DisplayName
                                            break
                                        end
                                    end
                                end
                                if not table.find(WhitelistedUsers, nametoWhitelist) then
                                    table.insert(whitelistedPlayers, nametoWhitelist)
                                    
                                    WhitelistedUsers:Set({
                                        Title = "Whitelisted Users:",
                                        Content = table.concat(whitelistedPlayers, ", ")
                                    })
                                end
                                if not table.find(aurawhitelistedplayers, nametoWhitelist) then
                                    table.insert(aurawhitelistedplayers, nametoWhitelist)
                                    
                                    WhitelistedUsers35:Set({
                                        Title = "Whitelisted Users:",
                                        Content = table.concat(aurawhitelistedplayers, ", ")
                                    })
                                end
                                if not table.find(spraywhitelistedplayers, nametoWhitelist) then
                                    table.insert(spraywhitelistedplayers, nametoWhitelist)
                                    
                                    WhitelistedUsers1122:Set({
                                        Title = "Whitelisted Users:",
                                        Content = table.concat(spraywhitelistedplayers, ", ")
                                    })
                                end
                                if not table.find(oldaurawhitelistedplayers, nametoWhitelist) then
                                    table.insert(oldaurawhitelistedplayers, nametoWhitelist)
                                    
                                    WhitelistedUsers353:Set({
                                        Title = "Whitelisted Users:",
                                        Content = table.concat(oldaurawhitelistedplayers, ", ")
                                    })
                                end
                            end
                        elseif command:find("blacklist") then
                            local name = string.match(command, "blacklist%s+(.+)")
                            local nameToBlacklist
                            if name then
                                for i, v in pairs(Players:GetPlayers()) do
                                    if v ~= LocalPlayer then
                                        if v.Name:lower() == name or v.DisplayName:lower() == name then
                                            nameToBlacklist = v.DisplayName
                                            break
                                        end
                                    end
                                end
                                if nameToBlacklist then
                                    local index = table.find(whitelistedPlayers, nameToBlacklist)
                                    if index then
                                        table.remove(whitelistedPlayers, index)
                                        local newContent = #whitelistedPlayers > 0 and table.concat(whitelistedPlayers, ", ") or "None"
                                        WhitelistedUsers:Set({
                                            Title = "Whitelisted Users:",
                                            Content = newContent
                                        })
                                    end

                                    local index2 = table.find(aurawhitelistedplayers, nameToBlacklist)
                                    if index2 then
                                        table.remove(aurawhitelistedplayers, index2)
                                        local newContent = #aurawhitelistedplayers > 0 and table.concat(aurawhitelistedplayers, ", ") or "None"
                                        WhitelistedUsers35:Set({
                                            Title = "Whitelisted Users:",
                                            Content = newContent
                                        })
                                    end

                                    local index3 = table.find(spraywhitelistedplayers, nameToBlacklist)
                                    if index3 then
                                        table.remove(spraywhitelistedplayers, index3)
                                        local newContent = #spraywhitelistedplayers > 0 and table.concat(spraywhitelistedplayers, ", ") or "None"
                                        WhitelistedUsers1122:Set({
                                            Title = "Whitelisted Users:",
                                            Content = newContent
                                        })
                                    end

                                    local index4 = table.find(oldaurawhitelistedplayers, nameToBlacklist)
                                    if index4 then
                                        table.remove(oldaurawhitelistedplayers, index4)
                                        local newContent = #oldaurawhitelistedplayers > 0 and table.concat(oldaurawhitelistedplayers, ", ") or "None"
                                        WhitelistedUsers353:Set({
                                            Title = "Whitelisted Users:",
                                            Content = newContent
                                        })
                                    end
                                end
                            end
                        elseif command:find("disablearena") then
                            local v = disableArena.CurrentValue
                            disableArena:Set(not v)
                        elseif command:find("autoshove") then
                            local v = AutoShove.CurrentValue
                            AutoShove:Set(not v)
                        elseif command:find("kill") then
                            local name = string.match(command, "kill%s+(.+)")
                            if name then
                                for i, v in pairs(Players:GetPlayers()) do
                                    if v ~= LocalPlayer then
                                        if v.Name:lower() == name or v.DisplayName:lower() == name then
                                            repeat
                                                attack(v, "POSTER_HIT")
                                                wait(0.01)
                                            until v.Character.Humanoid.Health == 0
                                        end
                                    end
                                end
                            end
                        elseif command:find("dmg") then
                            local name = string.match(command, "dmg%s+(.+)")
                            if name then
                                for i, v in pairs(Players:GetPlayers()) do
                                    if v ~= LocalPlayer then
                                        if v.Name:lower() == name or v.DisplayName:lower() == name then
                                            attack(v, "POSTER_HIT")
                                        end
                                    end
                                end
                            end
                        elseif command:find("byebyeserver") then
                            LoopKillAll:Set(not LoopKillAll.CurrentValue)
                        end
                    end
                end
            end
        end
    end
end)
