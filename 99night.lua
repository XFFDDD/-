local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:Notify({
    Title = "在森林中的99夜",
    Content = "已开启",
    Duration = 5,
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local hum = Character.HumanoidRootPart
local PlayerGui = LocalPlayer.PlayerGui

local Window = WindUI:CreateWindow({
    Title = "星脚本--森林中的99夜",
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Author = "欢迎星脚本用户",
    Folder = "CloudHub",
    Size = UDim2.fromOffset(300, 270),
    Transparent = true,
    Theme = "Dark",
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
        if label:IsA("TextLabel") and label.Text == "北极星脚本--森林中的99夜" then
            local gradient = Instance.new("UIGradient")
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
    stroke.Thickness = 2
    stroke.Color = Color3.new(1, 1, 1)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.LineJoinMode = Enum.LineJoinMode.Round
    stroke.Parent = mainFrame
    local gradient = Instance.new("UIGradient")
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

Window:EditOpenButton({
    Title = "打开脚本",
    Icon = "star",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    Draggable = true,
})

local TimeTag = Window:Tag({
    Title = "当前时间: " .. os.date("%H:%M:%S"),
    Icon = "clock",
    Color = Color3.fromHex("#FFFFFF"),
    Border = true
})

Window:Tag({
    Title = "皮门天下",
    Icon = "",
    Color = Color3.fromHex("#FFFFFF"),
    Border = true
})

local function setupRainbowText()
    wait(0.5)
    if Window and Window.UIElements then
        local mainFrame = Window.UIElements.Main
        if mainFrame then
            for _, label in ipairs(mainFrame:GetDescendants()) do
                if label:IsA("TextLabel") and label.Text and (string.find(label.Text, "皮门天下") or string.find(label.Text, "当前时间")) then
                    local oldGradient = label:FindFirstChild("RainbowTextGradient")
                    if oldGradient then oldGradient:Destroy() end
                    local rainbowGradient = Instance.new("UIGradient")
                    rainbowGradient.Name = "RainbowTextGradient"
                    rainbowGradient.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromHex("FF0000")),
                        ColorSequenceKeypoint.new(0.16, Color3.fromHex("FFA500")),
                        ColorSequenceKeypoint.new(0.33, Color3.fromHex("FFFF00")),
                        ColorSequenceKeypoint.new(0.5, Color3.fromHex("00FF00")),
                        ColorSequenceKeypoint.new(0.66, Color3.fromHex("0000FF")),
                        ColorSequenceKeypoint.new(0.83, Color3.fromHex("4B0082")),
                        ColorSequenceKeypoint.new(1, Color3.fromHex("EE82EE"))
                    })
                    rainbowGradient.Rotation = 0
                    rainbowGradient.Parent = label
                    label.TextColor3 = Color3.fromHex("#FFFFFF")
                    game:GetService("RunService").Heartbeat:Connect(function()
                        if rainbowGradient and rainbowGradient.Parent then
                            rainbowGradient.Rotation = (rainbowGradient.Rotation + 1.5) % 360
                        end
                    end)
                end
            end
        end
    end
    wait(1)
    setupRainbowText()
end

spawn(setupRainbowText)

local RunService = game:GetService("RunService")
RunService.Heartbeat:Connect(function()
    TimeTag:SetTitle("当前时间: " .. os.date("%H:%M:%S"))
end)

MainSection = Window:Section({
    Title = "功能",
    Opened = true,
})

Main = MainSection:Tab({ Title = "武器", Icon = "Sword" })

local oldAxeEnabled = false
Main:Toggle({
    Title = "老斧头杀戮光环",
    Value = false,
    Callback = function(value)
        oldAxeEnabled = value
        if value then
            spawn(function()
                while oldAxeEnabled do
                    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("ToolHandle") then
                        local tool = game.Players.LocalPlayer.Character.ToolHandle.OriginalItem.Value
                        if tool and tool.Name == "Old Axe" then
                            for _, enemy in next, workspace.Characters:GetChildren() do
                                if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("HitRegisters") then
                                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude <= 100 then
                                        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject"):InvokeServer(enemy, tool, true, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                                    end
                                end
                            end
                        end
                    end
                    wait(0.2)
                end
            end)
        end
    end
})

local goodAxeEnabled = false
Main:Toggle({
    Title = "好斧头杀戮光环",
    Value = false,
    Callback = function(value)
        goodAxeEnabled = value
        if value then
            spawn(function()
                while goodAxeEnabled do
                    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("ToolHandle") then
                        local tool = game.Players.LocalPlayer.Character.ToolHandle.OriginalItem.Value
                        if tool and tool.Name == "Good Axe" then
                            for _, enemy in next, workspace.Characters:GetChildren() do
                                if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("HitRegisters") then
                                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude <= 100 then
                                        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject"):InvokeServer(enemy, tool, true, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                                    end
                                end
                            end
                        end
                    end
                    wait(0.2)
                end
            end)
        end
    end
})

local spearEnabled = false
Main:Toggle({
    Title = "矛杀戮光环",
    Value = false,
    Callback = function(value)
        spearEnabled = value
        if value then
            spawn(function()
                while spearEnabled do
                    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("ToolHandle") then
                        local tool = game.Players.LocalPlayer.Character.ToolHandle.OriginalItem.Value
                        if tool and tool.Name == "Spear" then
                            for _, enemy in next, workspace.Characters:GetChildren() do
                                if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("HitRegisters") then
                                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude <= 100 then
                                        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject"):InvokeServer(enemy, tool, true, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                                    end
                                end
                            end
                        end
                    end
                    wait(0.2)
                end
            end)
        end
    end
})

local boneClubEnabled = false
Main:Toggle({
    Title = "骨棒杀戮光环",
    Value = false,
    Callback = function(value)
        boneClubEnabled = value
        if value then
            spawn(function()
                while boneClubEnabled do
                    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("ToolHandle") then
                        local tool = game.Players.LocalPlayer.Character.ToolHandle.OriginalItem.Value
                        if tool and tool.Name == "Bone Club" then
                            for _, enemy in next, workspace.Characters:GetChildren() do
                                if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("HitRegisters") then
                                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude <= 100 then
                                        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject"):InvokeServer(enemy, tool, true, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                                    end
                                end
                            end
                        end
                    end
                    wait(0.2)
                end
            end)
        end
    end
})

local autoChopEnabled = false
local chopRange = 30
local chopDelay = 0.7

local function chopTrees()
    if not autoChopEnabled then return end
    
    local player = game:GetService("Players").LocalPlayer
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local axe = player.Inventory:FindFirstChild("Good Axe") or player.Inventory:FindFirstChild("Old Axe")
    if not axe then
        WindUI:Notify({
            Title = "自动砍树",
            Text = "斧头",
            Duration = 3
        })
        return
    end

    local hrp = player.Character.HumanoidRootPart
    
    local treeLocations = {workspace.Map.Foliage, workspace.Map.Landmarks}
    
    for _, location in ipairs(treeLocations) do
        for _, tree in pairs(location:GetChildren()) do
            if tree:IsA("Model") and ({["Small Tree"]=true,["TreeBig1"]=true,["TreeBig2"]=true,["TreeBig3"]=true})[tree.Name] then
                local trunk = tree:FindFirstChild("Trunk") or tree:FindFirstChild("HumanoidRootPart") or tree.PrimaryPart
                if trunk and (hrp.Position - trunk.Position).Magnitude <= chopRange then
                    game:GetService("ReplicatedStorage").RemoteEvents.ReplicateSound:FireServer(
                        "FireAllClients",
                        "WoodChop",
                        {
                            ["Instance"] = player.Character.Head,
                            ["Volume"] = 0.4
                        }
                    )
                    
                    game:GetService("ReplicatedStorage").RemoteEvents.ToolDamageObject:InvokeServer(
                        tree,
                        axe,
                        true,
                        hrp.CFrame
                    )
                    
                    game:GetService("ReplicatedStorage").RemoteEvents.PlayEnemyHitSound:FireServer(
                        "FireAllClients",
                        tree,
                        axe
                    )
                    
                    task.wait(0.1)
                end
            end
        end
    end
}

Main:Toggle({
    Title = "砍树光环",
    Value = false,
    Callback = function(value)
        autoChopEnabled = value
        if value then
            spawn(function()
                while autoChopEnabled do
                    chopTrees()
                    task.wait(chopDelay)
                end
            end)
            WindUI:Notify({
                Title = "开启",
                Text = "已启用",
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "关闭",
                Text = "关闲",
                Duration = 3
            })
        end
    end
})

Main = MainSection:Tab({ Title = "动物", Icon = "Sword" })

local attackSpeed = 0.001
local fullMapRange = math.huge 
local treeAttackSpeed = 0.001 

local function fullMapWeaponAttack(toolName)
    if not game.Players.LocalPlayer.Character then return end
    if not game.Players.LocalPlayer.Character:FindFirstChild("ToolHandle") then return end
    
    local tool = game.Players.LocalPlayer.Character.ToolHandle.OriginalItem.Value
    if not tool or tool.Name ~= toolName then return end
    
    for _, enemy in pairs(workspace.Characters:GetChildren()) do
        if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("HitRegisters") then
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject"):InvokeServer(
                enemy, 
                tool, 
                true, 
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            )
        end
    end
end

local oldAxeEnabled = false
Main:Toggle({
    Title = "全图击打动物（老斧头）",
    Value = false,
    Callback = function(value)
        oldAxeEnabled = value
        if value then
            coroutine.wrap(function()
                while oldAxeEnabled do
                    fullMapWeaponAttack("Old Axe")
                    task.wait(attackSpeed)
                end
            end)()
        end
    end
})

local goodAxeEnabled = false
Main:Toggle({
    Title = "全图击打动物（好斧头）",
    Value = false,
    Callback = function(value)
        goodAxeEnabled = value
        if value then
            coroutine.wrap(function()
                while goodAxeEnabled do
                    fullMapWeaponAttack("Good Axe")
                    task.wait(attackSpeed)
                end
            end)()
        end
    end
})

local spearEnabled = false
Main:Toggle({
    Title = "全图击打动物（矛）",
    Value = false,
    Callback = function(value)
        spearEnabled = value
        if value then
            coroutine.wrap(function()
                while spearEnabled do
                    fullMapWeaponAttack("Spear")
                    task.wait(attackSpeed)
                end
            end)()
        end
    end
})

local boneClubEnabled = false
Main:Toggle({
    Title = "全图击打动物（骨棒）",
    Value = false,
    Callback = function(value)
        boneClubEnabled = value
        if value then
            coroutine.wrap(function()
                while boneClubEnabled do
                    fullMapWeaponAttack("Bone Club")
                    task.wait(attackSpeed)
                end
            end)()
        end
    end
})

Main = MainSection:Tab({ Title = "物品光环", Icon = "Sword" })

local autoCollectEnabledOldSack = false
local autoCollectEnabledGoodSack = false
local collectionRange = 25 

local function collectAllItems(bagName)
    local enabled = bagName == "Old Sack" and autoCollectEnabledOldSack or autoCollectEnabledGoodSack
    if not enabled then return end
    
    local player = game:GetService("Players").LocalPlayer
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = player.Character.HumanoidRootPart
    local tempStorage = game:GetService("ReplicatedStorage").TempStorage
    
    for _, item in pairs(workspace.Items:GetChildren()) do
        if item:IsA("Model") then
            local primaryPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
            if primaryPart and (hrp.Position - primaryPart.Position).Magnitude <= collectionRange then
                game:GetService("ReplicatedStorage").RemoteEvents.StopDraggingItem:FireServer(item)
                
                local bag = player.Inventory:FindFirstChild(bagName)
                if bag then
                    item.Parent = tempStorage
                    game:GetService("ReplicatedStorage").RemoteEvents.RequestBagStoreItem:InvokeServer(bag, item)
                    
                    game:GetService("ReplicatedStorage").RemoteEvents.ReplicateSound:FireServer(
                        "FireAllClients", 
                        "BagGet", 
                        {
                            ["Instance"] = player.Character.Head,
                            ["Volume"] = 0.25
                        }
                    )
                    
                    WindUI:Notify({
                        Title = "自动收集",
                        Text = "已收集: "..item.Name,
                        Duration = 1
                    })
                end
            end
        end
    end
}

Main:Toggle({
    Title = "老袋子自动收集",
    Value = false,
    Callback = function(value)
        autoCollectEnabledOldSack = value
        if value then
            spawn(function()
                while autoCollectEnabledOldSack do
                    collectAllItems("Old Sack")
                    wait(0.5)
                end
            end)
            WindUI:Notify({
                Title = "自动收集",
                Text = "已启用老袋子自动收集所有物品",
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "自动收集",
                Text = "已禁用自动收集",
                Duration = 3
            })
        end
    end
})

Main:Toggle({
    Title = "好袋子收集光环",
    Value = false,
    Callback = function(value)
        autoCollectEnabledGoodSack = value
        if value then
            spawn(function()
                while autoCollectEnabledGoodSack do
                    collectAllItems("Good Sack")
                    wait(0.5)
                end
            end)
            WindUI:Notify({
                Title = "自动收集",
                Text = "已启用好袋子自动收集",
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "自动收集",
                Text = "已关自动收集",
                Duration = 3
            })
        end
    end
})

local autoCollectCoal = false
local collectRange = 15

local function CollectCoal()
    if not autoCollectCoal then return end
    
    local player = game:GetService("Players").LocalPlayer
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = player.Character.HumanoidRootPart
    local tempStorage = game:GetService("ReplicatedStorage").TempStorage
    local sack = player.Inventory:FindFirstChild("Old Sack")
    
    if not sack then
        WindUI:Notify({
            Title = "需要老袋子",
            Text = "请先装备Old Sack",
            Duration = 3
        })
        return
    end

    for _, item in pairs(workspace.Items:GetChildren()) do
        if item.Name == "Coal" and item:IsA("Model") then
            local primaryPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
            if primaryPart and (hrp.Position - primaryPart.Position).Magnitude <= collectRange then
                game:GetService("ReplicatedStorage").RemoteEvents.ReplicateSound:FireServer(
                    "FireAllClients",
                    "BagGet",
                    {
                        ["Instance"] = player.Character.Head,
                        ["Volume"] = 0.25
                    }
                )
                
                game:GetService("ReplicatedStorage").RemoteEvents.RequestStartDraggingItem:FireServer(item)
                
                item.Parent = tempStorage
                game:GetService("ReplicatedStorage").RemoteEvents.StopDraggingItem:FireServer(item)
                
                game:GetService("ReplicatedStorage").RemoteEvents.RequestBagStoreItem:InvokeServer(sack, item)
                
                task.wait(0.3)
            end
        end
    end
}

Main:Toggle({
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

local autoCollectLogs = false
local collectRange = 15
local collectDelay = 0.3

local function CollectLogs()
    if not autoCollectLogs then return end
    
    local player = game:GetService("Players").LocalPlayer
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = player.Character.HumanoidRootPart
    local tempStorage = game:GetService("ReplicatedStorage").TempStorage
    local sack = player.Inventory:FindFirstChild("Old Sack")
    
    if not sack then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "需要袋子",
            Text = "请装备Old Sack",
            Duration = 3
        })
        return
    end

    for _, item in pairs(workspace.Items:GetChildren()) do
        if item.Name == "Log" and item:IsA("Model") then
            local primaryPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
            if primaryPart and (hrp.Position - primaryPart.Position).Magnitude <= collectRange then
                game:GetService("ReplicatedStorage").RemoteEvents.ReplicateSound:FireServer(
                    "FireAllClients",
                    "BagGet",
                    {
                        ["Instance"] = player.Character.Head,
                        ["Volume"] = 0.25
                    }
                )
                
                game:GetService("ReplicatedStorage").RemoteEvents.RequestStartDraggingItem:FireServer(item)
                
                item.Parent = tempStorage
                game:GetService("ReplicatedStorage").RemoteEvents.StopDraggingItem:FireServer(item)
                
                game:GetService("ReplicatedStorage").RemoteEvents.RequestBagStoreItem:InvokeServer(sack, item)
                
                task.wait(collectDelay)
            end
        end
    end
}

Main:Toggle({
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
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "自动收集",
                Text = "已启用木头自动收集",
                Duration = 3
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "自动收集",
                Text = "已禁用木头收集",
                Duration = 3
            })
        end
    end
})

Main = MainSection:Tab({ Title = "食物类光环", Icon = "Sword" })

local autoEatCarrots = false
local eatRange = 10

local function EatCarrots()
    if not autoEatCarrots then return end
    
    local player = game:GetService("Players").LocalPlayer
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = player.Character.HumanoidRootPart
    local tempStorage = game:GetService("ReplicatedStorage").TempStorage
    
    for _, item in pairs(workspace.Items:GetChildren()) do
        if item.Name == "Carrot" and item:IsA("Model") then
            local primaryPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
            if primaryPart and (hrp.Position - primaryPart.Position).Magnitude <= eatRange then
                game:GetService("ReplicatedStorage").RemoteEvents.ReplicateSound:FireServer(
                    "FireAllClients",
                    "Eat",
                    {
                        ["Instance"] = player.Character.Head,
                        ["Volume"] = 0.15
                    }
                )
                
                item.Parent = tempStorage
                game:GetService("ReplicatedStorage").RemoteEvents.StopDraggingItem:FireServer(item)
                game:GetService("ReplicatedStorage").RemoteEvents.RequestConsumeItem:InvokeServer(item)
                
                task.wait(1)
            end
        end
    end
}

Main:Toggle({
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
local eatRange = 10

local function EatBerries()
    if not autoEatBerries then return end
    
    local player = game:GetService("Players").LocalPlayer
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = player.Character.HumanoidRootPart
    local tempStorage = game:GetService("ReplicatedStorage").TempStorage
    
    for _, item in pairs(workspace.Items:GetChildren()) do
        if item.Name == "Berry" and item:IsA("Model") then
            local primaryPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
            if primaryPart and (hrp.Position - primaryPart.Position).Magnitude <= eatRange then
                game:GetService("ReplicatedStorage").RemoteEvents.ReplicateSound:FireServer(
                    "FireAllClients", 
                    "Eat",
                    {
                        ["Instance"] = player.Character.Head,
                        ["Volume"] = 0.15
                    }
                )
                
                item.Parent = tempStorage
                game:GetService("ReplicatedStorage").RemoteEvents.StopDraggingItem:FireServer(item)
                
                game:GetService("ReplicatedStorage").RemoteEvents.RequestConsumeItem:InvokeServer(item)
                
                task.wait(0.5)
            end
        end
    end
}

Main:Toggle({
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
local eatRange = 10
local eatCooldown = 1

local function EatCookedMorsel()
    if not autoEatMorsel then return end
    
    local player = game:GetService("Players").LocalPlayer
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = player.Character.HumanoidRootPart
    local tempStorage = game:GetService("ReplicatedStorage").TempStorage
    
    for _, item in pairs(workspace.Items:GetChildren()) do
        if item.Name == "Cooked Morsel" and item:IsA("Model") then
            local primaryPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
            if primaryPart and (hrp.Position - primaryPart.Position).Magnitude <= eatRange then
                game:GetService("ReplicatedStorage").RemoteEvents.ReplicateSound:FireServer(
                    "FireAllClients",
                    "Eat",
                    {
                        ["Instance"] = player.Character.Head,
                        ["Volume"] = 0.15
                    }
                )
                
                item.Parent = tempStorage
                game:GetService("ReplicatedStorage").RemoteEvents.StopDraggingItem:FireServer(item)
                
                game:GetService("ReplicatedStorage").RemoteEvents.RequestConsumeItem:InvokeServer(item)
                
                task.wait(eatCooldown)
                return
            end
        end
    end
}

Main:Toggle({
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

teleportSection = MainSection:Tab({ Title = "收集物品", Icon = "Sword" })

local function teleportItemsToPlayer(itemName)
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local items = {}
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant.Name == itemName then
            table.insert(items, descendant)
        end
    end
    
    for _, item in ipairs(items) do
        if item:IsA("BasePart") then
            item.CFrame = humanoidRootPart.CFrame + Vector3.new(0, 0, -2)
        elseif item:IsA("Model") then
            local primaryPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
            if primaryPart then
                primaryPart.CFrame = humanoidRootPart.CFrame + Vector3.new(0, 0, -2)
            end
        end
    end
    
    return #items
}

teleportSection:Button({
    Title = "收集所有煤炭",
    Callback = function()
        local count = teleportItemsToPlayer("Coal")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个煤炭到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有木头",
    Callback = function()
        local count = teleportItemsToPlayer("Log")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个木头板到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有生肉",
    Callback = function()
        local count = teleportItemsToPlayer("Meat")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个生肉到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有熟肉",
    Callback = function()
        local count = teleportItemsToPlayer("CookedMorsel")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个熟肉到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有手电筒",
    Callback = function()
        local count = teleportItemsToPlayer("Old Flashlight")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个手电筒到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有钉子",
    Callback = function()
        local count = teleportItemsToPlayer("Nail")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个钉子到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有风扇",
    Callback = function()
        local count = teleportItemsToPlayer("Broken Fan")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个风扇到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有燃料罐",
    Callback = function()
        local count = teleportItemsToPlayer("Fuel Canister")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个燃料罐到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有轮胎",
    Callback = function()
        local count = teleportItemsToPlayer("Tire")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个轮胎到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有绷带",
    Callback = function()
        local count = teleportItemsToPlayer("Bandage")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个绷带到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有左轮",
    Callback = function()
        local count = teleportItemsToPlayer("Revolver")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个左轮到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有子弹",
    Callback = function()
        local count = teleportItemsToPlayer("Bullet")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个子弹到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有金属板",
    Callback = function()
        local count = teleportItemsToPlayer("Sheet Metal")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个金属板到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有浆果",
    Callback = function()
        local count = teleportItemsToPlayer("Berry")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个浆果到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有胡萝卜",
    Callback = function()
        local count = teleportItemsToPlayer("Carrot")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个胡萝卜到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有宝箱",
    Callback = function()
        local count = teleportItemsToPlayer("HitBox")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个箱子到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有螺栓",
    Callback = function()
        local count = teleportItemsToPlayer("Bolt")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个螺栓到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有椅子",
    Callback = function()
        local count = teleportItemsToPlayer("Chair")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个椅子到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有好袋子",
    Callback = function()
        local count = teleportItemsToPlayer("Good Sack")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个好袋子到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有好斧头",
    Callback = function()
        local count = teleportItemsToPlayer("Good Axe")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个好斧头到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有石头",
    Callback = function()
        local count = teleportItemsToPlayer("Stone")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个石头到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有废料",
    Callback = function()
        local count = teleportItemsToPlayer("Scrap")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个废料到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有木板",
    Callback = function()
        local count = teleportItemsToPlayer("WoodBoard")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个木板到身边",
            Duration = 3
        })
    end
})

teleportSection:Button({
    Title = "收集所有收音机",
    Callback = function()
        local count = teleportItemsToPlayer("Old Flashlight")
        WindUI:Notify({
            Title = "传送完成",
            Text = "已传送 "..count.." 个收音机到身边",
            Duration = 3
        })
    end
})

Main = MainSection:Tab({ Title = "透视", Icon = "Sword" })

Main:Toggle({
    Title = "煤炭透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.CoalESPInstances = _G.CoalESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.CoalESPInstances, bill)

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
            local function findAndTrackCoal()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Coal" then
                        createBillboard(descendant, "煤炭", Color3.new(0, 1, 0)) 
                    end
                end
            end
            findAndTrackCoal()
        else
            if _G.CoalESPInstances then
                for _, bill in ipairs(_G.CoalESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.CoalESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "木头透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.CoalESPInstances = _G.CoalESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.CoalESPInstances, bill)

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
            local function findAndTrackCoal()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Log" then
                        createBillboard(descendant, "木头", Color3.new(0, 1, 0)) 
                    end
                end
            end
            findAndTrackCoal()
        else
            if _G.CoalESPInstances then
                for _, bill in ipairs(_G.CoalESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.CoalESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "生肉透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.RawMeatESPInstances = _G.RawMeatESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.RawMeatESPInstances, bill)

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
            local function findAndTrackRawMeat()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Meat" then
                        createBillboard(descendant, "生肉", Color3.new(1, 0, 0)) 
                    end
                end
            end
            findAndTrackRawMeat()
        else
            if _G.RawMeatESPInstances then
                for _, bill in ipairs(_G.RawMeatESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.RawMeatESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "熟肉透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.CookedMeatESPInstances = _G.CookedMeatESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.CookedMeatESPInstances, bill)

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
            local function findAndTrackCookedMeat()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "CookedMorsel" then
                        createBillboard(descendant, "熟肉", Color3.new(1, 0.5, 0)) 
                    end
                end
            end
            findAndTrackCookedMeat()
        else
            if _G.CookedMeatESPInstances then
                for _, bill in ipairs(_G.CookedMeatESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.CookedMeatESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "手电筒透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.FlashlightESPInstances = _G.FlashlightESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.FlashlightESPInstances, bill)

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
            local function findAndTrackFlashlight()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Old Flashlight" then
                        createBillboard(descendant, "手电筒", Color3.new(1, 1, 0)) 
                    end
                end
            end
            findAndTrackFlashlight()
        else
            if _G.FlashlightESPInstances then
                for _, bill in ipairs(_G.FlashlightESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.FlashlightESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "钉子透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.NailESPInstances = _G.NailESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.NailESPInstances, bill)

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
            local function findAndTrackNail()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Nail" then
                        createBillboard(descendant, "钉子", Color3.new(0.5, 0.5, 0.5)) 
                    end
                end
            end
            findAndTrackNail()
        else
            if _G.NailESPInstances then
                for _, bill in ipairs(_G.NailESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.NailESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "风扇透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.FanESPInstances = _G.FanESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.FanESPInstances, bill)

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
            local function findAndTrackFan()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Broken Fan" then
                        createBillboard(descendant, "风扇", Color3.new(0, 0, 1)) 
                    end
                end
            end
            findAndTrackFan()
        else
            if _G.FanESPInstances then
                for _, bill in ipairs(_G.FanESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.FanESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "燃料罐透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.FuelTankESPInstances = _G.FuelTankESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.FuelTankESPInstances, bill)

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
            local function findAndTrackFuelTank()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Fuel Canister" then
                        createBillboard(descendant, "燃料罐", Color3.new(1, 0, 1)) 
                    end
                end
            end
            findAndTrackFuelTank()
        else
            if _G.FuelTankESPInstances then
                for _, bill in ipairs(_G.FuelTankESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.FuelTankESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "轮胎透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.TireESPInstances = _G.TireESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.TireESPInstances, bill)

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
            local function findAndTrackTire()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Tire" then
                        createBillboard(descendant, "轮胎", Color3.new(0.5, 0, 0.5)) 
                    end
                end
            end
            findAndTrackTire()
        else
            if _G.TireESPInstances then
                for _, bill in ipairs(_G.TireESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.TireESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "绷带透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.BandageESPInstances = _G.BandageESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.BandageESPInstances, bill)

                task.spawn(function()
                    while bill and bill.Parent do
                        if not instance or not instance:IsDescendantOf(workspace) then
                            bill:Disconnect()
                            bill:Destroy()
                            break
                        end
                        task.wait(0.5)
                    end
                end)
            end
            local function findAndTrackBandage()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Bandage" then
                        createBillboard(descendant, "绷带", Color3.new(1, 0.5, 0.5)) 
                    end
                end
            end
            findAndTrackBandage()
        else
            if _G.BandageESPInstances then
                for _, bill in ipairs(_G.BandageESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.BandageESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "左轮透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.RevolverESPInstances = _G.RevolverESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.RevolverESPInstances, bill)

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
            local function findAndTrackRevolver()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Revolver" then
                        createBillboard(descendant, "左轮", Color3.new(0, 0, 0)) 
                    end
                end
            end
            findAndTrackRevolver()
        else
            if _G.RevolverESPInstances then
                for _, bill in ipairs(_G.RevolverESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.RevolverESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "子弹透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.BulletESPInstances = _G.BulletESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.BulletESPInstances, bill)

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
            local function findAndTrackBullet()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Bullet" then
                        createBillboard(descendant, "子弹", Color3.new(0.5, 0.5, 0)) 
                    end
                end
            end
            findAndTrackBullet()
        else
            if _G.BulletESPInstances then
                for _, bill in ipairs(_G.BulletESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.BulletESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "金属板透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.MetalPlateESPInstances = _G.MetalPlateESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.MetalPlateESPInstances, bill)

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
            local function findAndTrackMetalPlate()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Sheet Metal" then
                        createBillboard(descendant, "金属板", Color3.new(0.5, 0.5, 0.5)) 
                    end
                end
            end
            findAndTrackMetalPlate()
        else
            if _G.MetalPlateESPInstances then
                for _, bill in ipairs(_G.MetalPlateESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.MetalPlateESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "浆果透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.BerryESPInstances = _G.BerryESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.BerryESPInstances, bill)

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
            local function findAndTrackBerry()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Berry" then
                        createBillboard(descendant, "浆果", Color3.new(1, 0, 0)) 
                    end
                end
            end
            findAndTrackBerry()
        else
            if _G.BerryESPInstances then
                for _, bill in ipairs(_G.BerryESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.BerryESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "胡萝卜透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.CarrotESPInstances = _G.CarrotESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.CarrotESPInstances, bill)

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
            local function findAndTrackCarrot()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Carrot" then
                        createBillboard(descendant, "胡萝卜", Color3.new(1, 0.5, 0)) 
                    end
                end
            end
            findAndTrackCarrot()
        else
            if _G.CarrotESPInstances then
                for _, bill in ipairs(_G.CarrotESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.CarrotESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "宝箱透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.BoxESPInstances = _G.BoxESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.BoxESPInstances, bill)

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
            local function findAndTrackBox()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "HitBox" then
                        createBillboard(descendant, "箱子", Color3.new(0, 0.5, 0)) 
                    end
                end
            end
            findAndTrackBox()
        else
            if _G.BoxESPInstances then
                for _, bill in ipairs(_G.BoxESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.BoxESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "工具箱透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.ToolboxESPInstances = _G.ToolboxESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.ToolboxESPInstances, bill)

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
            local function findAndTrackToolbox()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Toolbox" then
                        createBillboard(descendant, "工具箱", Color3.new(0, 0.5, 0.5)) 
                    end
                end
            end
            findAndTrackToolbox()
        else
            if _G.ToolboxESPInstances then
                for _, bill in ipairs(_G.ToolboxESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.ToolboxESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "螺栓透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.BoltESPInstances = _G.BoltESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.BoltESPInstances, bill)

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
            local function findAndTrackBolt()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Bolt" then
                        createBillboard(descendant, "螺栓", Color3.new(0.5, 0.5, 0)) 
                    end
                end
            end
            findAndTrackBolt()
        else
            if _G.BoltESPInstances then
                for _, bill in ipairs(_G.BoltESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.BoltESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "椅子透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.ChairESPInstances = _G.ChairESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.ChairESPInstances, bill)

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
            local function findAndTrackChair()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Chair" then
                        createBillboard(descendant, "椅子", Color3.new(0.5, 0, 0)) 
                    end
                end
            end
            findAndTrackChair()
        else
            if _G.ChairESPInstances then
                for _, bill in ipairs(_G.ChairESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.ChairESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "好袋子透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.GoodBagESPInstances = _G.GoodBagESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.GoodBagESPInstances, bill)

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
            local function findAndTrackGoodBag()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Good Sack" then
                        createBillboard(descendant, "好袋子", Color3.new(0.5, 0.5, 0.5)) 
                    end
                end
            end
            findAndTrackGoodBag()
        else
            if _G.GoodBagESPInstances then
                for _, bill in ipairs(_G.GoodBagESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.GoodBagESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "好斧头透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.GoodAxeESPInstances = _G.GoodAxeESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.GoodAxeESPInstances, bill)

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
            local function findAndTrackGoodAxe()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Good Axe" then
                        createBillboard(descendant, "好斧头", Color3.new(0.5, 0.5, 0.5)) 
                    end
                end
            end
            findAndTrackGoodAxe()
        else
            if _G.GoodAxeESPInstances then
                for _, bill in ipairs(_G.GoodAxeESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.GoodAxeESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "石头透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.StoneESPInstances = _G.StoneESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.StoneESPInstances, bill)

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
            local function findAndTrackStone()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Stone" then
                        createBillboard(descendant, "石头", Color3.new(0.5, 0.5, 0.5)) 
                    end
                end
            end
            findAndTrackStone()
        else
            if _G.StoneESPInstances then
                for _, bill in ipairs(_G.StoneESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.StoneESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "废料透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.ScrapESPInstances = _G.ScrapESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.ScrapESPInstances, bill)

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
            local function findAndTrackScrap()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Scrap" then
                        createBillboard(descendant, "废料", Color3.new(0.5, 0.5, 0.5)) 
                    end
                end
            end
            findAndTrackScrap()
        else
            if _G.ScrapESPInstances then
                for _, bill in ipairs(_G.ScrapESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.ScrapESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "木板透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.WoodBoardESPInstances = _G.WoodBoardESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.WoodBoardESPInstances, bill)

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
            local function findAndTrackWoodBoard()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "WoodBoard" then
                        createBillboard(descendant, "木板", Color3.new(0.5, 0.5, 0.5)) 
                    end
                end
            end
            findAndTrackWoodBoard()
        else
            if _G.WoodBoardESPInstances then
                for _, bill in ipairs(_G.WoodBoardESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.WoodBoardESPInstances = nil
            end
        end
    end
})

Main:Toggle({
    Title = "收音机透视",
    Default = false,
    Callback = function(Value)
        if Value then
            _G.RadioESPInstances = _G.RadioESPInstances or {}
            local function createBillboard(instance, name, color)
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
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                table.insert(_G.RadioESPInstances, bill)

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
            local function findAndTrackRadio()
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant.Name == "Old Radio" then
                        createBillboard(descendant, "收音机", Color3.new(0.5, 0.5, 0.5)) 
                    end
                end
            end
            findAndTrackRadio()
        else
            if _G.RadioESPInstances then
                for _, bill in ipairs(_G.RadioESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.RadioESPInstances = nil
            end
        end
    end
})

Main = MainSection:Tab({ Title = "寻找类", Icon = "Sword" })

local function safeTeleport(targetCFrame)
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    
    
    if targetCFrame and targetCFrame.Position.Magnitude > 0 then
    
        local adjustedCFrame = targetCFrame + Vector3.new(0, 3, 0)
        hrp.CFrame = adjustedCFrame
        return true
    end
    return false
end

local function teleportToDinoKid()
    local success = false
    for _, model in pairs(workspace:GetChildren()) do
        if model:IsA("Model") and model.Name:lower() == "dinokid" then
            local humanoidRoot = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
            if humanoidRoot then
                success = safeTeleport(humanoidRoot.CFrame * CFrame.new(0, 0, 2))
                break
            end
        end
    end
    
    if success then
        WindUI:Notify({
            Title = "传送成功",
            Text = "已传送至恐龙小子",
            Duration = 3
        })
    else
        WindUI:Notify({
            Title = "未找到",
            Text = "恐龙小子未刷新或不可达",
            Duration = 3
        })
    end
end

Main:Button({
    Title = "寻找恐龙小子",
    Callback = teleportToDinoKid
})

local function teleportToKrakenKid()
    local success = false
    for _, model in pairs(workspace:GetChildren()) do
        if model:IsA("Model") and model.Name:lower() == "krakenkid" then
            local humanoidRoot = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
            if humanoidRoot then
                success = safeTeleport(humanoidRoot.CFrame * CFrame.new(0, 0, 2))
                break
            end
        end
    end
    
    if success then
        WindUI:Notify({
            Title = "传送成功",
            Text = "已传送至克拉肯小子",
            Duration = 3
        })
    else
        WindUI:Notify({
            Title = "未找到",
            Text = "克拉肯小子未刷新或不可达",
            Duration = 3
        })
    end
end

Main:Button({
    Title = "寻找克拉肯小子",
    Callback = teleportToKrakenKid
})

local function teleportToSquid()
    local success = false
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower() == "squid" and obj:IsA("BasePart") then
            success = safeTeleport(obj.CFrame)
            break
        end
    end
    
    if success then
        WindUI:Notify({
            Title = "传送成功",
            Text = "已传送至章鱼孩子",
            Duration = 3
        })
    else
        WindUI:Notify({
            Title = "未找到",
            Text = "章鱼孩子未刷新或不可达",
            Duration = 3
        })
    end
end

Main:Button({
    Title = "寻找章鱼孩子",
    Callback = teleportToSquid
})

local function teleportToKoalaKid()
    local success = false
    for _, model in pairs(workspace:GetChildren()) do
        if model:IsA("Model") and model.Name:lower() == "koalakid" then
            local humanoidRoot = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
            if humanoidRoot then
                success = safeTeleport(humanoidRoot.CFrame * CFrame.new(0, 0, 2))
                break
            end
        end
    end
    
    if success then
        WindUI:Notify({
            Title = "传送成功",
            Text = "已传送至考拉小子",
            Duration = 3
        })
    else
        WindUI:Notify({
            Title = "未找到",
            Text = "考拉小子未刷新或不可达",
            Duration = 3
        })
    end
end

Main:Button({
    Title = "寻找考拉小子",
    Callback = teleportToKoalaKid
})

Main:Button({
    Title = "传送回火旁",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-0.09672313928604126, 7.937822341918945, -0.1782056838274002)
    end
})

Main = MainSection:Tab({ Title = "其余", Icon = "Sword" })

Main:Toggle({
    Title = "速度 (开/关)",
    Default = false,
    Callback = function(v)
        if v == true then
            sudu = game:GetService("RunService").Heartbeat:Connect(function()
                if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character.Humanoid and game:GetService("Players").LocalPlayer.Character.Humanoid.Parent then
                    if game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
                        game:GetService("Players").LocalPlayer.Character:TranslateBy(game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection * Speed / 10)
                    end
                end
            end)
        elseif not v and sudu then
            sudu:Disconnect()
            sudu = nil
        end
    end
})

Main:Slider({
    Title = "速度设置",
    Desc = "滑动调整",
    Value = {
        Min = 1,
        Max = 150,
        Default = 1,
    },
    Callback = function(Value)
        Speed = Value
    end
})