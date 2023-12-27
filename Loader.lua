repeat task.wait() until game:GetService("Players").LocalPlayer
repeat task.wait() until game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main")
repeat task.wait() until (game.Players.LocalPlayer.Neutral == false) == true

local pbag = ({...})[1]
local __script__host = pbag[1]
local __script__token = pbag[2]
local __script__machine = pbag[3]
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local MeleeRequestList = {
    ["Death Step"] = "BuyDeathStep",
    ["Sharkman Karate"] = "BuySharkmanKarate",
    ["Electric Claw"] = "BuyElectricClaw",
    ["Dragon Talon"] = "BuyDragonTalon",
    ["Godhuman"] = "BuyGodhuman"
}
function getLevel()
    return LocalPlayer.Data.Level.Value
end
function getWorld() 
    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Dressrosa") == 0 and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Zou") == 0 then
        return 3
    elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Dressrosa") == 0 and not game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Zou") == 0 then
        return 2 
    else
        return 1
    end
end
function getItem(itemName) 
    for i,v in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
        if type(v) == "table" then
            if v.Type == "Material" then
                if v.Name == itemName then
                    return true
                end
            end
        end
    end
    return false
end
function getFruitMastery()
    if game:GetService("Players").LocalPlayer.Data.DevilFruit.Value == '' then return 0 end
    if LocalPlayer:FindFirstChild("Backpack") then 
        for i,v in pairs(LocalPlayer:FindFirstChild("Backpack"):GetChildren()) do 
            if v.ToolTip == "Blox Fruit" then 
                if v:FindFirstChild("Level") then 
                    return v.Level.Value
                end
            end
        end
    end
    repeat wait() until LocalPlayer.Character
    if LocalPlayer.Character:FindFirstChildOfClass("Tool") then 
        local Tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if Tool.ToolTip == "Blox Fruit" then
            if Tool:FindFirstChild("Level") then 
                return Tool.Level.Value
            end
        end
    end
    return 0
end

function getFruitName()
    return string.split(game:GetService("Players").LocalPlayer.Data.DevilFruit.Value,"-")[2]
end

function getAwakend()
    local SkillAWakenedList = {}
    local getAwakenedAbilitiesRequests = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getAwakenedAbilities")
    if getAwakenedAbilitiesRequests then
    for i, v in pairs(getAwakenedAbilitiesRequests) do
        if v["Awakened"] then 
                table.insert(SkillAWakenedList, i)
            end
        end
    end
    return SkillAWakenedList;
end

function getMeele()
    local MeleeName, RequestMeleeName = {}, nil;
    for i, v in pairs(MeleeRequestList) do 
        RequestMeleeName =  game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(v, true)
        if tonumber(RequestMeleeName) == 1 then 
            table.insert(MeleeName, i)
        end
    end
    return MeleeName
end

function getSword()
    local SwordList, RequestGetInvertory = {}, nil
    RequestGetInvertory = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")
    for i , v in pairs(RequestGetInvertory) do 
        if v['Type'] == "Sword" then 
            if v['Rarity'] >= 4 then
                table.insert(SwordList, v['Name'])
            end
        end
    end
    return SwordList
end

function GetFruitInU()
    local ReturnText = {}
    for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
        if type(v) == "table" then
            if v ~= nil then
                if v.Price >= 2300000  then
                    table.insert(ReturnText,string.split(v.Name,"-")[2])
                end
            end
        end
    end
    return ReturnText
end
function len(x)
    local q = 0
    for i, v in pairs(x) do
        q = q + 1
    end
    return q
end
function findItem(item) 
    RequestgetInventory = game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventory")
    for i, __ in pairs(RequestgetInventory) do
        if __["Name"] == item then
            return true
        end
    end
    return false
end
function getType()
    local ReturnText = {}
    if findItem("Cursed Dual Katana") then 
        table.insert(ReturnText, "CDK")
    end
    if game:GetService("Players").LocalPlayer.Data.Level.Value >= 2550 then
        table.insert(ReturnText, "MAX")
    end
    for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryWeapons")) do -- เช็คในกระเป๋า
        for i1,v1 in pairs(v) do
            if not table.find(ReturnText, "SG") then
                table.insert(ReturnText, "SG")
            end
            if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild('Soul Guitar') or game:GetService("Players").LocalPlayer.Character:FindFirstChild('Soul Guitar') then
                if not table.find(ReturnText, "SG") then
                    table.insert(ReturnText, "SG")
                end
            end
        end
    end
    local GodHuman = tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman",true))
    if GodHuman then
            if GodHuman == 1 then
                table.insert(ReturnText, "GOD")
            end
    end
    if len(ReturnText) == 0 then
        table.insert(ReturnText, "NOOB")
    end
    return table.concat(ReturnText, " ")
end

function getVK()
	for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryWeapons")) do -- เช็คในกระเป๋า
            for i1,v1 in pairs(v) do
                if v1 == 'Valkyrie Helm' then
                    return true
                end
            end
        end
     if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild('Valkyrie Helm') or game:GetService("Players").LocalPlayer.Character:FindFirstChild('Valkyrie Helm') then
           return true
        end
    return false
end

function sendRequest()
    request({
        Url = __script__host,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json",
            ["Authorization"] = __script__token,
        },
        Body = HttpService:JSONEncode({
            ["account"] = LocalPlayer.DisplayName,
            ["type"] = getType(),
            ["level"] = getLevel(),
            ["world"] = getWorld(),
            ["mirror"] = getItem("Mirror Fractal"),
            ["valk"] = getVK(),
            ["fruitMas"] = getFruitMastery(),
            ["fruit"] = getFruitName() or "None",
            ["awaken"] = getAwakend(),
            ["melee"] = getMeele(),
            ["beli"] = LocalPlayer.Data.Beli.Value,
            ["fragment"] = LocalPlayer.Data.Fragments.Value,
            ["machine"] = __script__machine,
            ["inventory"] = getSword(),
            ["fruitInv"] = GetFruitInU()
        })
    })
end

task.spawn(function()
    while true do
        pcall(function()
            sendRequest()
        end)
        task.wait(10)
    end
end)
