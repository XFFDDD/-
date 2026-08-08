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
    Title = "TrashHub - 集装箱RNG",
    Icon = "rbxassetid://18941716391",
    IconThemed = true,
    Author = "<font color='#00FFFF'>作者: TrashHub 移植版</font>",
    Folder = "TrashHub_WindUI",
    Size = UDim2.fromOffset(350, 300),
    Transparent = true,
    Theme = "Dark",
    BackgroundImageTransparency = 0.4,
    SideBarWidth = 200,
    HideSearchBar = false,
    ScrollBarEnabled = true,
})

task.wait(0.5)
local mainFrame = Window.UIElements.Main
if mainFrame then
    for _, label in ipairs(mainFrame:GetDescendants()) do
        if label:IsA("TextLabel") and label.Text == "TrashHub - 集装箱RNG" then
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

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local RemoteEvent = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Warp")
    :WaitForChild("Index"):WaitForChild("Event"):WaitForChild("Reliable")

local ContainerTypes = {
    "JunkContainer", "OverpoweredContainer", "MilitaryContainer",
    "ScratchedContainer", "SealedContainer", "MetalContainer",
    "SparkleContainer", "AlienContainer", "FrozenContainer",
    "CorruptedContainer", "LavaContainer", "StormedContainer",
    "LightningContainer", "InfernalContainer", "TutorialContainer",
    "MysticContainer", "GlitchedContainer", "AstralContainer",
    "DreamContainer", "CelestialContainer", "FireContainer",
    "BasicFlowerContainer", "GoodFlowerContainer", "GoldenContainer",
    "DiamondContainer", "EmeraldContainer", "RubyContainer",
    "SapphireContainer", "SpaceContainer", "DeepSpaceContainer",
    "VortexContainer", "BlackHoleContainer", "CamoContainer",
    "ObsidianContainer", "GoldenAuraContainer", "ChristmasContainer",
    "MedievalContainer", "ConstructionContainer", "EggContainer",
    "RareFlowerContainer",
}

local isRunning = false
local loopTask = nil
local selectedContainer = ContainerTypes[1]

local function Notify(title, content, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title or "TrashHub",
        Text = content or "",
        Duration = duration or 3,
    })
end

local function FireServer(remoteName, ...)
    local args = table.pack(...)
    return pcall(function()
        RemoteEvent:FireServer(remoteName, table.unpack(args, 1, args.n))
    end)
end

local function GetNearestPlot()
    local gameplay = Workspace:FindFirstChild("Gameplay")
    local plots = gameplay and gameplay:FindFirstChild("Plots")
    if not plots then return nil end

    local character = LocalPlayer.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    local nearestPlot, nearestDist = nil, math.huge

    for _, plot in ipairs(plots:GetChildren()) do
        local plotLogic = plot:FindFirstChild("PlotLogic")
        local containerHolder = plotLogic and plotLogic:FindFirstChild("ContainerHolder")
        if containerHolder then
            local basePart = plot:FindFirstChildWhichIsA("BasePart", true)
            local dist = rootPart and basePart and (basePart.Position - rootPart.Position).Magnitude or 0
            if dist < nearestDist then
                nearestPlot, nearestDist = plot, dist
            end
        end
    end
    return nearestPlot
end

local function GetContainerHolder()
    local plot = GetNearestPlot()
    local logic = plot and plot:FindFirstChild("PlotLogic")
    return logic and logic:FindFirstChild("ContainerHolder")
end

local function GetContainers()
    local holder = GetContainerHolder()
    local containers = {}
    if not holder then return containers end
    for _, child in ipairs(holder:GetChildren()) do
        if string.sub(child.Name, 1, 10) == "CONTAINER_" then
            table.insert(containers, child)
        end
    end
    return containers
end

local function BuyContainers(count)
    local success = 0
    for _ = 1, tonumber(count) or 1 do
        if FireServer("PurchaseContainer", selectedContainer) then
            success = success + 1
        end
        task.wait(0.1)
    end
    Notify("购买", string.format("已购买 %d 个 %s", success, selectedContainer))
    return success
end

local function OpenAllContainers()
    local opened = 0
    for _, container in ipairs(GetContainers()) do
        if FireServer("OpenContainer", container, buffer.fromstring("K")) then
            opened = opened + 1
        end
        task.wait(0.1)
    end
    Notify("开箱", string.format("已开启 %d 个箱子", opened))
    return opened
end

local function PickupAllItems()
    local plot = GetNearestPlot()
    local itemCache = plot and plot:FindFirstChild("ItemCache", true)
    local picked, skipped = 0, 0
    if itemCache then
        for _, item in ipairs(itemCache:GetChildren()) do
            if FireServer("PickupItem", item) then
                picked = picked + 1
            else
                skipped = skipped + 1
            end
            task.wait(0.05)
        end
    end
    Notify("拾取完成", string.format("拾取 %d 件，跳过 %d 件", picked, skipped))
    return picked, skipped
end

local function DropAllItems()
    local character = LocalPlayer.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    local plot = GetNearestPlot()
    local decor = plot and plot:FindFirstChild("PlotDecor")
    local house = decor and decor:FindFirstChild("House")
    local housePart = house and house:FindFirstChild("Part", true)
    if rootPart and housePart and housePart:IsA("BasePart") then
        rootPart.CFrame = housePart.CFrame + Vector3.new(0, 1.5, 0)
    end
    FireServer("DropAllItems")
    Notify("丢弃", "已传送并丢弃所有物品")
end

local function StartAutoLoop()
    if isRunning or loopTask then return end
    isRunning = true
    loopTask = task.spawn(function()
        while isRunning do
            BuyContainers(8)
            if not isRunning then break end
            OpenAllContainers()
            if not isRunning then break end
            PickupAllItems()
            if not isRunning then break end
            DropAllItems()
            task.wait(0.1)
        end
        loopTask = nil
    end)
    Notify("TrashHub", "自动循环已开启")
end

local function StopAutoLoop()
    isRunning = false
    if loopTask then task.cancel(loopTask); loopTask = nil end
    Notify("TrashHub", "自动循环已停止")
end

local MainSection = Window:Section({
    Title = "控制面板",
    Opened = true
})

local autoTab = MainSection:Tab({
    Title = "自动循环",
    Icon = "rbxassetid://18941716391"
})

autoTab:Dropdown({
    Title = "容器类型",
    Values = ContainerTypes,
    Value = selectedContainer,
    Callback = function(value)
        selectedContainer = value
    end
})

autoTab:Toggle({
    Title = "开启自动循环",
    Default = false,
    Callback = function(value)
        if value then
            StartAutoLoop()
        else
            StopAutoLoop()
        end
    end
})

local manualTab = MainSection:Tab({
    Title = "手动操作",
    Icon = "rbxassetid://18941716391"
})

manualTab:Dropdown({
    Title = "容器类型",
    Values = ContainerTypes,
    Value = selectedContainer,
    Callback = function(value)
        selectedContainer = value
    end
})

manualTab:Button({
    Title = "购买 8 个指定箱子",
    Callback = function()
        BuyContainers(8)
    end
})

manualTab:Button({
    Title = "开启所有箱子",
    Callback = OpenAllContainers
})

manualTab:Button({
    Title = "拾取所有物品",
    Callback = PickupAllItems
})

manualTab:Button({
    Title = "丢弃所有物品",
    Callback = DropAllItems
})

Notify("TrashHub", "WindUI 界面加载完成", 3)

return {
    buy = BuyContainers,
    openAll = OpenAllContainers,
    pickupAll = PickupAllItems,
    dropAll = DropAllItems,
    start = StartAutoLoop,
    stop = StopAutoLoop,
    containers = ContainerTypes,
}