local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/refs/heads/main/main%20(1).lua"))()

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
    Title = "星脚本-在超市生活一周",
    Icon = "rbxassetid://136169594232359",
    IconThemed = true,
    Author = "<font color='#FFFFFF'>作者: 小星</font>",
    Folder = "星脚本",
    Size = UDim2.fromOffset(300, 270),
    Transparent = true,
    Theme = "Dark",
    BackgroundImageTransparency = 0.4,
    User = {
        Enabled = true,
        Callback = function()
        end,
        Anonymous = true
    },
    SideBarWidth = 200,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    Background = "https://raw.githubusercontent.com/zilinskaslandon/zzzzzzzzzzz/refs/heads/main/111785626782282.jpg"
})

task.wait(0.5)

local mainFrame = Window.UIElements.Main
if mainFrame then
    for _, label in ipairs(mainFrame:GetDescendants()) do
        if label:IsA("TextLabel") and label.Text == "星脚本-在超市生活一周" then
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

local mainFrame = Window.UIElements.Main
if mainFrame then
    local stroke = Instance.new("UIStroke")
    stroke.Name = "MainBorder"
    stroke.Thickness = 2
    stroke.Color = Color3.new(1, 1, 1)
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

local rainbowGradient = nil

local function setupRainbowText()
    wait(0.5)

    if Window and Window.UIElements then
        local mainFrame = Window.UIElements.Main
        if mainFrame then
            local textLabels = {}
            for _, descendant in ipairs(mainFrame:GetDescendants()) do
                if descendant:IsA("TextLabel") and descendant.Visible then
                    table.insert(textLabels, descendant)
                end
            end

            for _, label in ipairs(textLabels) do
                if label.Text and string.find(label.Text, "当前时间") then
                    local oldGradient = label:FindFirstChild("RainbowTextGradient")
                    if oldGradient then oldGradient:Destroy() end

                    rainbowGradient = Instance.new("UIGradient")
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
                    return
                end
            end
        end
    end

    wait(1)
    setupRainbowText()
end

spawn(setupRainbowText)

local RunService = game:GetService("RunService")
local lastUpdate = 0

RunService.Heartbeat:Connect(function()
    local now = tick()
    if now - lastUpdate >= 0.1 then
        local bjTime = os.date("!%H:%M:%S", os.time() + 28800)
        TimeTag:SetTitle("当前时间: " .. bjTime)
        lastUpdate = now
    end

    if rainbowGradient and rainbowGradient.Parent then
        rainbowGradient.Rotation = (rainbowGradient.Rotation + 1.5) % 360
    end
end)

local originalOpen = Window.Open
Window.Open = function(...)
    local result = originalOpen(...)
    wait(0.5)
    setupRainbowText()
    return result
end

local TimeTag = Window:Tag({
    Title = "皮门天下",
    Icon = "",
    Color = Color3.fromHex("#FFFFFF"),
    Border = true
})

local rainbowGradient = nil

local function setupRainbowText()
    wait(0.5)

    if Window and Window.UIElements then
        local mainFrame = Window.UIElements.Main
        if mainFrame then
            local textLabels = {}
            for _, descendant in ipairs(mainFrame:GetDescendants()) do
                if descendant:IsA("TextLabel") and descendant.Visible then
                    table.insert(textLabels, descendant)
                end
            end

            for _, label in ipairs(textLabels) do
                if label.Text and string.find(label.Text, "皮门天下") then
                    local oldGradient = label:FindFirstChild("RainbowTextGradient")
                    if oldGradient then oldGradient:Destroy() end

                    rainbowGradient = Instance.new("UIGradient")
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
                    return
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
    if rainbowGradient and rainbowGradient.Parent then
        rainbowGradient.Rotation = (rainbowGradient.Rotation + 1.5) % 360
    end
end)

local originalOpen = Window.Open
Window.Open = function(...)
    local result = originalOpen(...)
    wait(0.5)
    setupRainbowText()
    return result
end

Window:EditOpenButton({
    Title = "<font color='#0000FF'>星脚本</font>-<font color='#00FF00'>在超市生活一周</font> ",
    Icon = "rbxassetid://136169594232359",
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

local MainSection = Window:Section({
    Title = "主要功能",
    Opened = true
})

local collectTab = MainSection:Tab({
    Title = "自动收集",
    Icon = "rbxassetid://136169594232359"
})

collectTab:Toggle({
    Title = "自动收集食物",
    Default = false,
    Callback = function(state)
        while state and task.wait() do
            for _, v in next, workspace.Map.Util.Items:GetChildren() do
                if v.ToolStats.ItemType.Value == "Food" then
                    game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
                end
            end
        end
    end
})

collectTab:Toggle({
    Title = "自动收集手电筒",
    Default = false,
    Callback = function(state)
        while state and task.wait() do
            for _, v in next, workspace.Map.Util.Items:GetChildren() do
                if v.ToolStats.ItemType.Value == "Flashlight" then
                    game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
                end
            end
        end
    end
})

collectTab:Toggle({
    Title = "自动收集近战武器",
    Default = false,
    Callback = function(state)
        while state and task.wait() do
            for _, v in next, workspace.Map.Util.Items:GetChildren() do
                if v.ToolStats.ItemType.Value == "Melee" then
                    game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
                end
            end
        end
    end
})

collectTab:Toggle({
    Title = "自动收集枪",
    Default = false,
    Callback = function(state)
        while state and task.wait() do
            for _, v in next, workspace.Map.Util.Items:GetChildren() do
                if v.ToolStats.ItemType.Value == "Gun" then
                    game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
                end
            end
        end
    end
})

collectTab:Toggle({
    Title = "自动收集药品",
    Default = false,
    Callback = function(state)
        while state and task.wait() do
            for _, v in next, workspace.Map.Util.Items:GetChildren() do
                if v.ToolStats.ItemType.Value == "Health" then
                    game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
                end
            end
        end
    end
})

local combatTab = MainSection:Tab({
    Title = "枪类功能",
    Icon = "rbxassetid://136169594232359"
})

combatTab:Toggle({
    Title = "自动装弹",
    Default = false,
    Callback = function(state)
        while state and task.wait() do
            game:GetService("ReplicatedStorage").Remotes.Weapon.GunReloaded:FireServer(v, 1)
        end
    end
})

combatTab:Toggle({
    Title = "自动开枪",
    Default = false,
    Callback = function(state)
        while state and task.wait() do
            for _, v in next, game.Players.LocalPlayer.Backpack:GetChildren() do
                if v:FindFirstChild("ToolStats") and v.ToolStats:FindFirstChild("Ammo") then
                    for _, e in next, workspace.Enemies:GetChildren() do
                        if e.Humanoid.Health > 0 then
                            local BulletsPerShot = v.ToolStats.BulletsPerShot.Value
                            local DirectionTbl = {}
                            for i = 1, BulletsPerShot do
                                table.insert(DirectionTbl, Vector3.new(e.Head.Position.X, e.Head.Position.Y, e.Head.Position.Z).Unit)
                            end
                            local args = {
                                [1] = {
                                    ["FiringPlayer"] = game:GetService("Players").LocalPlayer,
                                    ["FiredTime"] = os.time,
                                    ["FiringPlayerUserId"] = game.Players.LocalPlayer.UserId,
                                    ["Origin"] = Vector3.new(game.Players.LocalPlayer.Character:GetPivot().Position),
                                    ["UID"] = game.Players.LocalPlayer.UserId .. "_1",
                                    ["WeaponInstance"] = v,
                                    ["ThisBulletProperties"] = {
                                        ["BulletSpread"] = v.ToolStats.BulletSpread.Value,
                                        ["BulletsPerShot"] = v.ToolStats.BulletsPerShot.Value,
                                        ["BulletPenetration"] = v.ToolStats.BulletPenetration.Value,
                                        ["BulletSpeed"] = v.ToolStats.BulletSpeed.Value,
                                        ["FireSound"] = v.ToolStats.FireSound.Value,
                                        ["BulletSize"] = v.ToolStats.BulletSize.Value
                                    },
                                    ["DirectionTbl"] = DirectionTbl
                                }
                            }
                            game:GetService("ReplicatedStorage").Remotes.Weapon.GunFired:FireServer(unpack(args))
                        end
                    end
                end
            end
        end
    end
})

combatTab:Toggle({
    Title = "修改枪",
    Default = false,
    Callback = function(state)
        while state and task.wait() do
            for _, v in next, game.Players.Backpack:GetChildren() do
                if v.ToolStats:FindFirstChild("Ammo") then
                    v.ToolStats.ReloadTime.Value = 0
                    v.ToolStats.FireDelay.Value = 0
                    v.ToolStats.Ammo.Value = math.huge
                    v.ToolStats.Damage.Value = math.huge
                end
            end
        end
    end
})

local playerTab = MainSection:Tab({
    Title = "玩家功能",
    Icon = "rbxassetid://136169594232359"
})

playerTab:Toggle({
    Title = "无限体力与饥饿度",
    Default = false,
    Callback = function(state)
        while state and task.wait() do
            game.Players.LocalPlayer.Character.CharacterData.MaxStamina.Value = math.huge
            game.Players.LocalPlayer.Character.CharacterData.MaxEnergy.Value = math.huge
            game.Players.LocalPlayer.Character.CharacterData.Energy.Value = game.Players.LocalPlayer.Character.CharacterData.MaxEnergy.Value
            game.Players.LocalPlayer.Character.CharacterData.Stamina.Value = game.Players.LocalPlayer.Character.CharacterData.MaxStamina.Value
        end
    end
})

playerTab:Toggle({
    Title = "夜晚自动躲避",
    Default = false,
    Callback = function(state)
        while state and task.wait() do
            if game:GetService("ReplicatedStorage").GameInfo.TimeOfDay.Value == "Night" then
                oldpos = game.Players.LocalPlayer.Character:GetPivot().Position
                repeat
                    task.wait()
                    game.Players.LocalPlayer.Character:PivotTo(CFrame.new(306.18927001953125, 36.67450714111328, -519.2435913085938))
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                until game:GetService("ReplicatedStorage").GameInfo.TimeOfDay.Value ~= "Night"
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
            else
                task.wait()
            end
        end
    end
}