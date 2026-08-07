local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local function setThemeColors()
    local themes = WindUI.GetThemes()
    if themes and themes.Dark then
        themes.Dark.Text = Color3.fromHex("00FFFF")
        themes.Dark.Placeholder = Color3.fromHex("00FFFF")
        themes.Dark.Button = Color3.fromHex("00FFFF")
        themes.Dark.TabTitle = Color3.fromHex("00FFFF")
    end
    WindUI:SetTheme("Dark")
end
setThemeColors()

local Window = WindUI:CreateWindow({
    Title = "北极星脚本·森林99夜",
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Author = "<font color='#FFFFFF'>欢迎付费版本用户</font>",
    Folder = "CloudHub",
    Size = UDim2.fromOffset(300, 270),
    Transparent = true,
    Theme = "Dark",
    BackgroundImageTransparency = 0.4,
    User = {
        Enabled = true,
        Callback = function() print("clicked") end,
        Anonymous = false
    },
    SideBarWidth = 200,
    ScrollBarEnabled = true,
})

task.wait(0.5)
local mainFrame = Window.UIElements.Main
if mainFrame then
    for _, label in ipairs(mainFrame:GetDescendants()) do
        if label:IsA("TextLabel") and label.Text == "北极星脚本·森林99夜" then
            local gradient = Instance.new("UIGradient")
            gradient.Name = "TitleRainbow"
            gradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromHex("FF0000")),
                ColorSequenceKeypoint.new(0.16, Color3.fromHex("FFA500")),
                ColorSequenceKeypoint.new(0.33, Color3.fromHex("FFFF00")),
                ColorSequenceKeypoint.new(0.5, Color3.fromHex("00FF00")),
                ColorSequenceKeypoint.new(0.66, Color3.fromHex("0000FF")),
                ColorSequenceKeypoint.new(0.83, Color3.fromHex("4B0082")),
                ColorSequenceKeypoint.new(1, Color3.fromHex("EE82EE"))
            })
            gradient.Rotation = 0
            gradient.Parent = label
            label.TextColor3 = Color3.fromHex("#FFFFFF")
            game:GetService("RunService").Heartbeat:Connect(function()
                if gradient and gradient.Parent then
                    gradient.Rotation = (gradient.Rotation + 1.5) % 360
                end
            end)
            break
        end
    end
end

if mainFrame then
    local stroke = Instance.new("UIStroke")
    stroke.Name = "MainBorder"
    stroke.Thickness = 2
    stroke.Color = Color3.new(1,1,1)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.LineJoinMode = Enum.LineJoinMode.Round
    stroke.Parent = mainFrame
    local gradient = Instance.new("UIGradient")
    gradient.Name = "BorderGradient"
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex("FF0000")),
        ColorSequenceKeypoint.new(0.16, Color3.fromHex("FFA500")),
        ColorSequenceKeypoint.new(0.33, Color3.fromHex("FFFF00")),
        ColorSequenceKeypoint.new(0.5, Color3.fromHex("00FF00")),
        ColorSequenceKeypoint.new(0.66, Color3.fromHex("0000FF")),
        ColorSequenceKeypoint.new(0.83, Color3.fromHex("4B0082")),
        ColorSequenceKeypoint.new(1, Color3.fromHex("EE82EE"))
    })
    gradient.Rotation = 0
    gradient.Parent = stroke
    game:GetService("RunService").Heartbeat:Connect(function()
        if gradient and gradient.Parent then
            gradient.Rotation = (gradient.Rotation + 1.5) % 360
        end
    end)
end

local TimeTag = Window:Tag({
    Title = "当前时间: 00:00:00",
    Icon = "clock",
    Color = Color3.fromHex("#FFFFFF"),
    Border = true
})
local function setupRainbowTime()
    wait(0.5)
    if Window and Window.UIElements then
        local mainFrame = Window.UIElements.Main
        if mainFrame then
            for _, label in ipairs(mainFrame:GetDescendants()) do
                if label:IsA("TextLabel") and label.Text and string.find(label.Text, "当前时间") then
                    local old = label:FindFirstChild("RainbowTextGradient")
                    if old then old:Destroy() end
                    local grad = Instance.new("UIGradient")
                    grad.Name = "RainbowTextGradient"
                    grad.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromHex("FF0000")),
                        ColorSequenceKeypoint.new(0.16, Color3.fromHex("FFA500")),
                        ColorSequenceKeypoint.new(0.33, Color3.fromHex("FFFF00")),
                        ColorSequenceKeypoint.new(0.5, Color3.fromHex("00FF00")),
                        ColorSequenceKeypoint.new(0.66, Color3.fromHex("0000FF")),
                        ColorSequenceKeypoint.new(0.83, Color3.fromHex("4B0082")),
                        ColorSequenceKeypoint.new(1, Color3.fromHex("EE82EE"))
                    })
                    grad.Rotation = 0
                    grad.Parent = label
                    label.TextColor3 = Color3.fromHex("#FFFFFF")
                    _G.TimeGradient = grad
                    return
                end
            end
        end
    end
    wait(1)
    setupRainbowTime()
end
spawn(setupRainbowTime)

local RunService = game:GetService("RunService")
local lastUpdate = 0
RunService.Heartbeat:Connect(function()
    local now = tick()
    if now - lastUpdate >= 0.1 then
        local bjTime = os.date("!%H:%M:%S", os.time() + 28800)
        TimeTag:SetTitle("当前时间: " .. bjTime)
        lastUpdate = now
    end
    if _G.TimeGradient and _G.TimeGradient.Parent then
        _G.TimeGradient.Rotation = (_G.TimeGradient.Rotation + 1.5) % 360
    end
end)

Window:EditOpenButton({
    Title = "<font color='#0000FF'>打开</font><font color='#00FF00'>脚本</font>",
    Icon = "star",
    CornerRadius = UDim.new(1, 14),
    StrokeThickness = 2,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex("FF0000")),
        ColorSequenceKeypoint.new(0.16, Color3.fromHex("FFA500")),
        ColorSequenceKeypoint.new(0.33, Color3.fromHex("FFFF00")),
        ColorSequenceKeypoint.new(0.5, Color3.fromHex("00FF00")),
        ColorSequenceKeypoint.new(0.66, Color3.fromHex("0000FF")),
        ColorSequenceKeypoint.new(0.83, Color3.fromHex("4B0082")),
        ColorSequenceKeypoint.new(1, Color3.fromHex("EE82EE"))
    })
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")

local config = {
    attackRange = 100,
    attackSpeed = 0.2,
    chopRange = 30,
    chopDelay = 0.7,
    collectRange = 25,
    coalRange = 15,
    logRange = 15,
    eatRange = 10,
    fullMapAttackSpeed = 0.001,
    speedValue = 1,
}

local MainSection = Window:Section({ Title = "功能", Opened = true })

local weaponTab = MainSection:Tab({ Title = "武器", Icon = "Sword" })

local function startKillAura(toolName, enabledVar, range, speed)
    return function(value)
        enabledVar = value
        if value then
            spawn(function()
                while enabledVar do
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("ToolHandle") then
                        local tool = char.ToolHandle.OriginalItem.Value
                        if tool and tool.Name == toolName then
                            local hrp = char.HumanoidRootPart
                            for _, enemy in next, workspace.Characters:GetChildren() do
                                if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("HitRegisters") then
                                    if (hrp.Position - enemy.HumanoidRootPart.Position).Magnitude <= range then
                                        RemoteEvents.ToolDamageObject:InvokeServer(enemy, tool, true, hrp.CFrame)
                                    end
                                end
                            end
                        end
                    end
                    task.wait(speed)
                end
            end)
        end
    end
end

local oldAxeEnabled, goodAxeEnabled, spearEnabled, boneClubEnabled = false, false, false, false
weaponTab:Toggle({ Title = "老斧头杀戮光环", Value = false, Callback = startKillAura("Old Axe", oldAxeEnabled, config.attackRange, config.attackSpeed) })
weaponTab:Toggle({ Title = "好斧头杀戮光环", Value = false, Callback = startKillAura("Good Axe", goodAxeEnabled, config.attackRange, config.attackSpeed) })
weaponTab:Toggle({ Title = "矛杀戮光环", Value = false, Callback = startKillAura("Spear", spearEnabled, config.attackRange, config.attackSpeed) })
weaponTab:Toggle({ Title = "骨棒杀戮光环", Value = false, Callback = startKillAura("Bone Club", boneClubEnabled, config.attackRange, config.attackSpeed) })

local autoChopEnabled = false
local function chopTrees()
    if not autoChopEnabled then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char.HumanoidRootPart
    local axe = LocalPlayer.Inventory:FindFirstChild("Good Axe") or LocalPlayer.Inventory:FindFirstChild("Old Axe")
    if not axe then
        WindUI:Notify({ Title = "自动砍树", Text = "缺少斧头", Duration = 3 })
        return
    end
    local treeLocations = {workspace.Map.Foliage, workspace.Map.Landmarks}
    for _, location in ipairs(treeLocations) do
        for _, tree in pairs(location:GetChildren()) do
            if tree:IsA("Model") and ({["Small Tree"]=true,["TreeBig1"]=true,["TreeBig2"]=true,["TreeBig3"]=true})[tree.Name] then
                local trunk = tree:FindFirstChild("Trunk") or tree:FindFirstChild("HumanoidRootPart") or tree.PrimaryPart
                if trunk and (hrp.Position - trunk.Position).Magnitude <= config.chopRange then
                    RemoteEvents.ReplicateSound:FireServer("FireAllClients", "WoodChop", {["Instance"] = char.Head, ["Volume"] = 0.4})
                    RemoteEvents.ToolDamageObject:InvokeServer(tree, axe, true, hrp.CFrame)
                    RemoteEvents.PlayEnemyHitSound:FireServer("FireAllClients", tree, axe)
                    task.wait(0.1)
                end
            end
        end
    end
end
weaponTab:Toggle({
    Title = "砍树光环",
    Value = false,
    Callback = function(value)
        autoChopEnabled = value
        if value then
            spawn(function()
                while autoChopEnabled do
                    chopTrees()
                    task.wait(config.chopDelay)
                end
            end)
        end
    end
})

weaponTab:Slider({
    Title = "杀戮范围",
    Value = { Min = 10, Max = 200, Default = config.attackRange },
    Callback = function(v) config.attackRange = v end
})
weaponTab:Slider({
    Title = "杀戮间隔 (秒)",
    Value = { Min = 0.05, Max = 1, Default = config.attackSpeed, Decimal = 2 },
    Callback = function(v) config.attackSpeed = v end
})
weaponTab:Slider({
    Title = "砍树范围",
    Value = { Min = 5, Max = 80, Default = config.chopRange },
    Callback = function(v) config.chopRange = v end
})
weaponTab:Slider({
    Title = "砍树间隔",
    Value = { Min = 0.1, Max = 2, Default = config.chopDelay, Decimal = 2 },
    Callback = function(v) config.chopDelay = v end
})

local animalTab = MainSection:Tab({ Title = "动物", Icon = "Sword" })
local function fullMapAttack(toolName, enabledVar, speed)
    return function(value)
        enabledVar = value
        if value then
            spawn(function()
                while enabledVar do
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("ToolHandle") then
                        local tool = char.ToolHandle.OriginalItem.Value
                        if tool and tool.Name == toolName then
                            for _, enemy in pairs(workspace.Characters:GetChildren()) do
                                if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("HitRegisters") then
                                    RemoteEvents.ToolDamageObject:InvokeServer(enemy, tool, true, char.HumanoidRootPart.CFrame)
                                end
                            end
                        end
                    end
                    task.wait(speed)
                end
            end)
        end
    end
end
local oldAxeFull, goodAxeFull, spearFull, boneFull = false, false, false, false
animalTab:Toggle({ Title = "全图击打（老斧头）", Value = false, Callback = fullMapAttack("Old Axe", oldAxeFull, config.fullMapAttackSpeed) })
animalTab:Toggle({ Title = "全图击打（好斧头）", Value = false, Callback = fullMapAttack("Good Axe", goodAxeFull, config.fullMapAttackSpeed) })
animalTab:Toggle({ Title = "全图击打（矛）", Value = false, Callback = fullMapAttack("Spear", spearFull, config.fullMapAttackSpeed) })
animalTab:Toggle({ Title = "全图击打（骨棒）", Value = false, Callback = fullMapAttack("Bone Club", boneFull, config.fullMapAttackSpeed) })
animalTab:Slider({
    Title = "全图攻击间隔 (秒)",
    Value = { Min = 0.001, Max = 0.5, Default = config.fullMapAttackSpeed, Decimal = 3 },
    Callback = function(v) config.fullMapAttackSpeed = v end
})

local itemTab = MainSection:Tab({ Title = "物品光环", Icon = "Sword" })

local function collectAllItems(bagName, enabledVar, range)
    return function(value)
        enabledVar = value
        if value then
            spawn(function()
                while enabledVar do
                    local char = LocalPlayer.Character
                    if char then
                        local hrp = char.HumanoidRootPart
                        local tempStorage = ReplicatedStorage.TempStorage
                        local bag = LocalPlayer.Inventory:FindFirstChild(bagName)
                        if bag then
                            for _, item in pairs(workspace.Items:GetChildren()) do
                                if item:IsA("Model") then
                                    local primaryPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
                                    if primaryPart and (hrp.Position - primaryPart.Position).Magnitude <= range then
                                        RemoteEvents.StopDraggingItem:FireServer(item)
                                        item.Parent = tempStorage
                                        RemoteEvents.RequestBagStoreItem:InvokeServer(bag, item)
                                        RemoteEvents.ReplicateSound:FireServer("FireAllClients", "BagGet", {["Instance"] = char.Head, ["Volume"] = 0.25})
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
end

local autoCollectOldSack, autoCollectGoodSack = false, false
itemTab:Toggle({ Title = "老袋子自动收集", Value = false, Callback = collectAllItems("Old Sack", autoCollectOldSack, config.collectRange) })
itemTab:Toggle({ Title = "好袋子收集光环", Value = false, Callback = collectAllItems("Good Sack", autoCollectGoodSack, config.collectRange) })
itemTab:Slider({
    Title = "收集范围",
    Value = { Min = 5, Max = 60, Default = config.collectRange },
    Callback = function(v) config.collectRange = v end
})

local autoCollectCoal = false
local function CollectCoal()
    if not autoCollectCoal then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char.HumanoidRootPart
    local tempStorage = ReplicatedStorage.TempStorage
    local sack = LocalPlayer.Inventory:FindFirstChild("Old Sack")
    if not sack then
        WindUI:Notify({ Title = "需要老袋子", Text = "请装备Old Sack", Duration = 3 })
        return
    end
    for _, item in pairs(workspace.Items:GetChildren()) do
        if item.Name == "Coal" and item:IsA("Model") then
            local primaryPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
            if primaryPart and (hrp.Position - primaryPart.Position).Magnitude <= config.coalRange then
                RemoteEvents.ReplicateSound:FireServer("FireAllClients", "BagGet", {["Instance"] = char.Head, ["Volume"] = 0.25})
                RemoteEvents.RequestStartDraggingItem:FireServer(item)
                item.Parent = tempStorage
                RemoteEvents.StopDraggingItem:FireServer(item)
                RemoteEvents.RequestBagStoreItem:InvokeServer(sack, item)
                task.wait(0.3)
            end
        end
    end
end
itemTab:Toggle({
    Title = "收集煤炭光环",
    Value = false,
    Callback = function(value)
        autoCollectCoal = value
        if value then
            spawn(function()
                while autoCollectCoal do
                    CollectCoal()
                    task.wait(0.5)
                end
            end)
        end
    end
})
itemTab:Slider({
    Title = "煤炭收集范围",
    Value = { Min = 5, Max = 40, Default = config.coalRange },
    Callback = function(v) config.coalRange = v end
})

local autoCollectLogs = false
local function CollectLogs()
    if not autoCollectLogs then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char.HumanoidRootPart
    local tempStorage = ReplicatedStorage.TempStorage
    local sack = LocalPlayer.Inventory:FindFirstChild("Old Sack")
    if not sack then
        WindUI:Notify({ Title = "需要老袋子", Text = "请装备Old Sack", Duration = 3 })
        return
    end
    for _, item in pairs(workspace.Items:GetChildren()) do
        if item.Name == "Log" and item:IsA("Model") then
            local primaryPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
            if primaryPart and (hrp.Position - primaryPart.Position).Magnitude <= config.logRange then
                RemoteEvents.ReplicateSound:FireServer("FireAllClients", "BagGet", {["Instance"] = char.Head, ["Volume"] = 0.25})
                RemoteEvents.RequestStartDraggingItem:FireServer(item)
                item.Parent = tempStorage
                RemoteEvents.StopDraggingItem:FireServer(item)
                RemoteEvents.RequestBagStoreItem:InvokeServer(sack, item)
                task.wait(0.3)
            end
        end
    end
end
itemTab:Toggle({
    Title = "收集木头光环",
    Value = false,
    Callback = function(value)
        autoCollectLogs = value
        if value then
            spawn(function()
                while autoCollectLogs do
                    CollectLogs()
                    task.wait(0.5)
                end
            end)
        end
    end
})
itemTab:Slider({
    Title = "木头收集范围",
    Value = { Min = 5, Max = 40, Default = config.logRange },
    Callback = function(v) config.logRange = v end
})

local foodTab = MainSection:Tab({ Title = "食物类光环", Icon = "Sword" })

local autoEatCarrots = false
local function EatCarrots()
    if not autoEatCarrots then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char.HumanoidRootPart
    local tempStorage = ReplicatedStorage.TempStorage
    for _, item in pairs(workspace.Items:GetChildren()) do
        if item.Name == "Carrot" and item:IsA("Model") then
            local primaryPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
            if primaryPart and (hrp.Position - primaryPart.Position).Magnitude <= config.eatRange then
                RemoteEvents.ReplicateSound:FireServer("FireAllClients", "Eat", {["Instance"] = char.Head, ["Volume"] = 0.15})
                item.Parent = tempStorage
                RemoteEvents.StopDraggingItem:FireServer(item)
                RemoteEvents.RequestConsumeItem:InvokeServer(item)
                task.wait(1)
            end
        end
    end
end
foodTab:Toggle({
    Title = "自动吃胡萝卜",
    Value = false,
    Callback = function(value)
        autoEatCarrots = value
        if value then
            spawn(function()
                while autoEatCarrots do
                    EatCarrots()
                    task.wait(0.5)
                end
            end)
        end
    end
})

local autoEatBerries = false
local function EatBerries()
    if not autoEatBerries then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char.HumanoidRootPart
    local tempStorage = ReplicatedStorage.TempStorage
    for _, item in pairs(workspace.Items:GetChildren()) do
        if item.Name == "Berry" and item:IsA("Model") then
            local primaryPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
            if primaryPart and (hrp.Position - primaryPart.Position).Magnitude <= config.eatRange then
                RemoteEvents.ReplicateSound:FireServer("FireAllClients", "Eat", {["Instance"] = char.Head, ["Volume"] = 0.15})
                item.Parent = tempStorage
                RemoteEvents.StopDraggingItem:FireServer(item)
                RemoteEvents.RequestConsumeItem:InvokeServer(item)
                task.wait(0.5)
            end
        end
    end
end
foodTab:Toggle({
    Title = "自动吃浆果",
    Value = false,
    Callback = function(value)
        autoEatBerries = value
        if value then
            spawn(function()
                while autoEatBerries do
                    EatBerries()
                    task.wait(0.3)
                end
            end)
        end
    end
})

local autoEatMorsel = false
local function EatCookedMorsel()
    if not autoEatMorsel then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char.HumanoidRootPart
    local tempStorage = ReplicatedStorage.TempStorage
    for _, item in pairs(workspace.Items:GetChildren()) do
        if item.Name == "Cooked Morsel" and item:IsA("Model") then
            local primaryPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
            if primaryPart and (hrp.Position - primaryPart.Position).Magnitude <= config.eatRange then
                RemoteEvents.ReplicateSound:FireServer("FireAllClients", "Eat", {["Instance"] = char.Head, ["Volume"] = 0.15})
                item.Parent = tempStorage
                RemoteEvents.StopDraggingItem:FireServer(item)
                RemoteEvents.RequestConsumeItem:InvokeServer(item)
                task.wait(1)
                return
            end
        end
    end
end
foodTab:Toggle({
    Title = "自动吃熟食",
    Value = false,
    Callback = function(value)
        autoEatMorsel = value
        if value then
            spawn(function()
                while autoEatMorsel do
                    EatCookedMorsel()
                    task.wait(0.5)
                end
            end)
        end
    end
})
foodTab:Slider({
    Title = "食物拾取范围",
    Value = { Min = 5, Max = 40, Default = config.eatRange },
    Callback = function(v) config.eatRange = v end
})

local teleportTab = MainSection:Tab({ Title = "收集物品", Icon = "Sword" })

local function teleportItemsToPlayer(itemName)
    local char = LocalPlayer.Character
    if not char then return 0 end
    local hrp = char.HumanoidRootPart
    if not hrp then return 0 end
    local items = {}
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant.Name == itemName then
            table.insert(items, descendant)
        end
    end
    for _, item in ipairs(items) do
        if item:IsA("BasePart") then
            item.CFrame = hrp.CFrame + Vector3.new(0, 0, -2)
        elseif item:IsA("Model") then
            local primaryPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
            if primaryPart then
                primaryPart.CFrame = hrp.CFrame + Vector3.new(0, 0, -2)
            end
        end
    end
    return #items
end

local itemList = {
    ["煤炭"] = "Coal",
    ["木头"] = "Log",
    ["生肉"] = "Meat",
    ["熟肉"] = "CookedMorsel",
    ["手电筒"] = "Old Flashlight",
    ["钉子"] = "Nail",
    ["风扇"] = "Broken Fan",
    ["燃料罐"] = "Fuel Canister",
    ["轮胎"] = "Tire",
    ["绷带"] = "Bandage",
    ["左轮"] = "Revolver",
    ["子弹"] = "Bullet",
    ["金属板"] = "Sheet Metal",
    ["浆果"] = "Berry",
    ["胡萝卜"] = "Carrot",
    ["宝箱"] = "HitBox",
    ["螺栓"] = "Bolt",
    ["椅子"] = "Chair",
    ["好袋子"] = "Good Sack",
    ["好斧头"] = "Good Axe",
    ["石头"] = "Stone",
    ["废料"] = "Scrap",
    ["木板"] = "WoodBoard",
    ["收音机"] = "Old Radio"
}

for displayName, itemName in pairs(itemList) do
    teleportTab:Button({
        Title = "收集所有" .. displayName,
        Callback = function()
            local count = teleportItemsToPlayer(itemName)
            WindUI:Notify({
                Title = "传送完成",
                Text = "已传送 " .. count .. " 个" .. displayName .. "到身边",
                Duration = 3
            })
        end
    })
end

local findTab = MainSection:Tab({ Title = "寻找类", Icon = "Sword" })

local function safeTeleport(targetCFrame)
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    if targetCFrame and targetCFrame.Position.Magnitude > 0 then
        hrp.CFrame = targetCFrame + Vector3.new(0, 3, 0)
        return true
    end
    return false
end

local function teleportToNPC(name)
    local success = false
    for _, model in pairs(workspace:GetChildren()) do
        if model:IsA("Model") and string.lower(model.Name) == string.lower(name) then
            local hrp = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
            if hrp then
                success = safeTeleport(hrp.CFrame * CFrame.new(0, 0, 2))
                break
            end
        end
    end
    if success then
        WindUI:Notify({ Title = "传送成功", Text = "已传送至" .. name, Duration = 3 })
    else
        WindUI:Notify({ Title = "未找到", Text = name .. "未刷新或不可达", Duration = 3 })
    end
end

findTab:Button({ Title = "寻找恐龙小子", Callback = function() teleportToNPC("dinokid") end })
findTab:Button({ Title = "寻找克拉肯小子", Callback = function() teleportToNPC("krakenkid") end })
findTab:Button({ Title = "寻找章鱼孩子", Callback = function()
    local success = false
    for _, obj in pairs(workspace:GetDescendants()) do
        if string.lower(obj.Name) == "squid" and obj:IsA("BasePart") then
            success = safeTeleport(obj.CFrame)
            break
        end
    end
    if success then
        WindUI:Notify({ Title = "传送成功", Text = "已传送至章鱼孩子", Duration = 3 })
    else
        WindUI:Notify({ Title = "未找到", Text = "章鱼孩子未刷新或不可达", Duration = 3 })
    end
end })
findTab:Button({ Title = "寻找考拉小子", Callback = function() teleportToNPC("koalakid") end })
findTab:Button({ Title = "传送回火旁", Callback = function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-0.0967, 7.9378, -0.1782)
end })

local miscTab = MainSection:Tab({ Title = "其余", Icon = "Sword" })

local speedConnection = nil
miscTab:Toggle({
    Title = "速度 (开/关)",
    Default = false,
    Callback = function(v)
        if v then
            speedConnection = game:GetService("RunService").Heartbeat:Connect(function()
                local char = LocalPlayer.Character
                if char and char.Humanoid and char.Humanoid.Parent then
                    if char.Humanoid.MoveDirection.Magnitude > 0 then
                        char:TranslateBy(char.Humanoid.MoveDirection * config.speedValue / 10)
                    end
                end
            end)
        elseif speedConnection then
            speedConnection:Disconnect()
            speedConnection = nil
        end
    end
})
miscTab:Slider({
    Title = "速度设置",
    Value = { Min = 1, Max = 150, Default = config.speedValue },
    Callback = function(v) config.speedValue = v end
})

local espTab = MainSection:Tab({ Title = "透视", Icon = "Sword" })

local function createESP(itemName, displayText, color, globalVarName)
    return function(value)
        if value then
            _G[globalVarName] = _G[globalVarName] or {}
            local function createBillboard(instance)
                local bill = Instance.new("BillboardGui", game.CoreGui)
                bill.AlwaysOnTop = true
                bill.Size = UDim2.new(0, 100, 0, 50)
                bill.Adornee = instance
                bill.MaxDistance = 2000
                local mid = Instance.new("Frame", bill)
                mid.AnchorPoint = Vector2.new(0.5, 0.5)
                mid.BackgroundColor3 = color
                mid.Size = UDim2.new(0, 8, 0, 8)
                mid.Position = UDim2.new(0.5, 0, 0.5, 0)
                Instance.new("UICorner", mid).CornerRadius = UDim.new(1, 0)
                Instance.new("UIStroke", mid)
                local txt = Instance.new("TextLabel", bill)
                txt.AnchorPoint = Vector2.new(0.5, 0.5)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = color
                txt.Size = UDim2.new(1, 0, 0, 20)
                txt.Position = UDim2.new(0.5, 0, 0.7, 0)
                txt.Text = displayText
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)
                table.insert(_G[globalVarName], bill)
                task.spawn(function()
                    while bill and bill.Parent do
                        if not instance or not instance:IsDescendantOf(workspace) then
                            bill:Destroy()
                            break
                        end
                        task.wait(0.5)
                    end
                end)
            end
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant.Name == itemName then
                    createBillboard(descendant)
                end
            end
        else
            if _G[globalVarName] then
                for _, bill in ipairs(_G[globalVarName]) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G[globalVarName] = nil
            end
        end
    end
end

local espItems = {
    {item = "Coal", text = "煤炭", color = Color3.new(0,1,0), var = "CoalESP"},
    {item = "Log", text = "木头", color = Color3.new(0,1,0), var = "LogESP"},
    {item = "Meat", text = "生肉", color = Color3.new(1,0,0), var = "MeatESP"},
    {item = "CookedMorsel", text = "熟肉", color = Color3.new(1,0.5,0), var = "CookedMorselESP"},
    {item = "Old Flashlight", text = "手电筒", color = Color3.new(1,1,0), var = "FlashlightESP"},
    {item = "Nail", text = "钉子", color = Color3.new(0.5,0.5,0.5), var = "NailESP"},
    {item = "Broken Fan", text = "风扇", color = Color3.new(0,0,1), var = "FanESP"},
    {item = "Fuel Canister", text = "燃料罐", color = Color3.new(1,0,1), var = "FuelESP"},
    {item = "Tire", text = "轮胎", color = Color3.new(0.5,0,0.5), var = "TireESP"},
    {item = "Bandage", text = "绷带", color = Color3.new(1,0.5,0.5), var = "BandageESP"},
    {item = "Revolver", text = "左轮", color = Color3.new(0,0,0), var = "RevolverESP"},
    {item = "Bullet", text = "子弹", color = Color3.new(0.5,0.5,0), var = "BulletESP"},
    {item = "Sheet Metal", text = "金属板", color = Color3.new(0.5,0.5,0.5), var = "MetalESP"},
    {item = "Berry", text = "浆果", color = Color3.new(1,0,0), var = "BerryESP"},
    {item = "Carrot", text = "胡萝卜", color = Color3.new(1,0.5,0), var = "CarrotESP"},
    {item = "HitBox", text = "宝箱", color = Color3.new(0,0.5,0), var = "BoxESP"},
    {item = "Toolbox", text = "工具箱", color = Color3.new(0,0.5,0.5), var = "ToolboxESP"},
    {item = "Bolt", text = "螺栓", color = Color3.new(0.5,0.5,0), var = "BoltESP"},
    {item = "Chair", text = "椅子", color = Color3.new(0.5,0,0), var = "ChairESP"},
    {item = "Good Sack", text = "好袋子", color = Color3.new(0.5,0.5,0.5), var = "GoodSackESP"},
    {item = "Good Axe", text = "好斧头", color = Color3.new(0.5,0.5,0.5), var = "GoodAxeESP"},
    {item = "Stone", text = "石头", color = Color3.new(0.5,0.5,0.5), var = "StoneESP"},
    {item = "Scrap", text = "废料", color = Color3.new(0.5,0.5,0.5), var = "ScrapESP"},
    {item = "WoodBoard", text = "木板", color = Color3.new(0.5,0.5,0.5), var = "WoodBoardESP"},
    {item = "Old Radio", text = "收音机", color = Color3.new(0.5,0.5,0.5), var = "RadioESP"}
}

for _, esp in ipairs(espItems) do
    espTab:Toggle({
        Title = esp.text .. "透视",
        Default = false,
        Callback = createESP(esp.item, esp.text, esp.color, esp.var)
    })
end