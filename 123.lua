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

local lp = game:GetService("Players").LocalPlayer
local mouse = lp:GetMouse()
local workspace = game:GetService("Workspace")
local replicatedStorage = game:GetService("ReplicatedStorage")

local bai = {
    soltnumber = "1",
    cuttreeselect = "Generic",
    moneyaoumt = 1,
    moneytoplayername = "",
    saymege = "",
    saymount = 1,
    bringamount = 1,
    loaddupeaxewaittime = 3.1,
    walkspeed = 16,
    JumpPower = 50,
    zix = 1,
    zlz = 3,
    autobuyamount = 1,
    dropdown = {},
    zlwjia = "",
    mtwjia = nil,
    cswjia = "",
    tchonmt = nil,
    zlmt = nil,
    playernamedied = "",
    itemset = nil,
    autobuyset = nil,
    treecutset = nil,
    car = nil,
    autoSellPlank = false,
    autoSellWood = false,
    autofarm = false,
    autofarm1 = false,
    autosay = false,
    autopick = false,
    autodropae = false,
    autobuystop = false,
    whthmose = false,
    shuzhe = false,
    modwood = false,
    cskais = false,
    xzemuban = false,
    stopcar = false,
    bringtree = false,
    sayfast = false,
}

function notify(title, text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title or "提示",
        Text = text or "",
        Duration = duration or 3
    })
end

function tp(pos)
    if typeof(pos) == "CFrame" then
        lp.Character:SetPrimaryPartCFrame(pos)
    elseif typeof(pos) == "Vector3" then
        lp.Character:MoveTo(pos)
    end
end

function carTeleport(cframe)
    local char = lp.Character
    if char and char.Humanoid.SeatPart then
        local car = char.Humanoid.SeatPart.Parent
        spawn(function()
            for i = 1, 5 do
                wait()
                car:SetPrimaryPartCFrame(cframe)
                replicatedStorage.Interaction.ClientRequestOwnership:FireServer(car.Main)
                replicatedStorage.Interaction.ClientIsDragging:FireServer(car.Main)
            end
        end)
    end
end

function droptool(Position)
    local char = lp.Character
    if char:FindFirstChildOfClass("Tool") then
        local tool = char:FindFirstChildOfClass("Tool")
        if tool:FindFirstChild("ToolName") then
            replicatedStorage.Interaction.ClientInteracted:FireServer(tool, "Drop tool", Position or char.Head.CFrame)
        end
    end
    for _, tool in pairs(lp.Backpack:GetChildren()) do
        if tool.Name == "Tool" and tool.ClassName == "Tool" then
            replicatedStorage.Interaction.ClientInteracted:FireServer(tool, "Drop tool", Position or char.Head.CFrame)
        end
    end
end

function getTools()
    lp.Character.Humanoid:UnequipTools()
    local tools = {}
    for _, v in pairs(lp.Backpack:GetChildren()) do
        if v.Name ~= "BlueprintTool" then
            table.insert(tools, v)
        end
    end
    return tools
end

function getToolStats(toolName)
    if typeof(toolName) ~= "string" then
        toolName = toolName.ToolName.Value
    end
    return require(replicatedStorage.AxeClasses['AxeClass_' .. toolName]).new()
end

function getTieredAxe()
    return {
        ['Beesaxe'] = 13, ['AxeAmber'] = 12, ['ManyAxe'] = 15,
        ['BasicHatchet'] = 0, ['RustyAxe'] = -1, ['Axe1'] = 2,
        ['Axe2'] = 3, ['AxeAlphaTesters'] = 9, ['Rukiryaxe'] = 8,
        ['Axe3'] = 4, ['AxeBetaTesters'] = 10, ['FireAxe'] = 11,
        ['SilverAxe'] = 5, ['EndTimesAxe'] = 16, ['AxeChicken'] = 6,
        ['CandyCaneAxe'] = 1, ['AxeTwitter'] = 7, ['CandyCornAxe'] = 14
    }
end

function getAxeList()
    local list = {}
    for _, v in pairs(lp.Backpack:GetChildren()) do
        table.insert(list, v)
    end
    local char = lp.Character
    if char:FindFirstChildOfClass("Tool") then
        table.insert(list, char:FindFirstChildOfClass("Tool"))
    end
    return list
end

function barkgetBestAxe()
    local char = lp.Character
    if char:FindFirstChildOfClass("Tool") then
        local tool = char:FindFirstChildOfClass("Tool")
        if tool:FindFirstChild("ToolName") then
            return tool
        end
    end
    local bestTier = -1
    local bestTool = nil
    local tiers = getTieredAxe()
    for _, v in pairs(getAxeList()) do
        if v:FindFirstChild("ToolName") then
            if tiers[v.ToolName.Value] > bestTier then
                bestTool = v
                bestTier = tiers[v.ToolName.Value]
            end
        end
    end
    return bestTool
end

function get_axe_cooldown(tool)
    local success, result = pcall(function()
        local axeClass = require(replicatedStorage.AxeClasses['AxeClass_' .. tool.ToolName.Value])
        return axeClass.new().SwingCooldown
    end)
    return success and result or 1
end

function getBestSawmill()
    local best = nil
    for _, v in pairs(workspace.PlayerModels:GetChildren()) do
        if v:FindFirstChild("Owner") and v:FindFirstChild("ItemName") and v.Owner.Value == lp and
            v.ItemName.Value:sub(1, 7) == "Sawmill" then
            if not best then
                best = v
            elseif #v.ItemName.Value > #best.ItemName.Value then
                best = v
            end
        end
    end
    return best
end

function getBiggestTree(treeClass)
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name == "TreeRegion" then
            for _, tree in pairs(v:GetChildren()) do
                if tree:FindFirstChild("TreeClass") and tree.TreeClass.Value == treeClass and
                    tree:FindFirstChild("Owner") then
                    if tree.Owner.Value == nil or tree.Owner.Value == lp then
                        if #tree:GetChildren() > 5 and tree:FindFirstChild("WoodSection") then
                            for _, section in pairs(tree:GetChildren()) do
                                if section:FindFirstChild("ID") and section.ID.Value == 1 and section.Size.Y > 0.5 then
                                    return section
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return false
end

function getPlanks()
    local plankList = {}
    for _, plank in pairs(workspace.PlayerModels:GetChildren()) do
        if plank:FindFirstChild('WoodSection') and plank:FindFirstChild('Owner') and plank.Owner.Value == lp then
            table.insert(plankList, plank)
        end
    end
    return plankList
end

function CheckSlotNumber()
    local slot = tonumber(bai.soltnumber)
    if slot and slot >= 1 and slot <= 6 then
        return slot
    end
    return false
end

function CheckIfSlotAvailable(Slot)
    local metaData = replicatedStorage.LoadSaveRequests.GetMetaData:InvokeServer(lp)
    for slot, data in pairs(metaData) do
        if slot == Slot and data.NumSaves and data.NumSaves ~= 0 then
            return true
        end
    end
    return false
end

function CanClientLoad()
    while not replicatedStorage.LoadSaveRequests.ClientMayLoad:InvokeServer(lp) do
        wait()
    end
    return true
end

function LoadSlot(slot)
    CanClientLoad()
    replicatedStorage.LoadSaveRequests.RequestLoad:InvokeServer(slot, lp)
end

function getMouseTarget()
    local mousePos = game:GetService("UserInputService"):GetMouseLocation()
    return workspace:FindPartOnRayWithIgnoreList(
        Ray.new(workspace.CurrentCamera.CFrame.p, workspace.CurrentCamera:ViewportPointToRay(mousePos.x, mousePos.y, 0).Direction * 1000),
        lp.Character:GetDescendants()
    )
end

function Press(Button)
    replicatedStorage.Interaction.RemoteProxy:FireServer(Button)
end

function BuyItem(shopData)
    return replicatedStorage.NPCDialog.PlayerChatted:InvokeServer(shopData, "ConfirmPurchase")
end

function shuaxinlb(zji)
    bai.dropdown = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        if zji or player ~= lp then
            table.insert(bai.dropdown, player.Name)
        end
    end
end
shuaxinlb(true)

function sellwood()
    local oldpos = lp.Character.HumanoidRootPart.CFrame
    for _, log in pairs(workspace.LogModels:GetChildren()) do
        if log:FindFirstChild("Owner") and log.Owner.Value == lp then
            tp(log.WoodSection.CFrame)
            spawn(function()
                for i = 1, 50 do
                    replicatedStorage.Interaction.ClientIsDragging:FireServer(log)
                    log:PivotTo(CFrame.new(314.54, -0.5, 86.823))
                    replicatedStorage.Interaction.ClientIsDragging:FireServer(log)
                    wait()
                end
            end)
            wait(2)
        end
    end
    tp(oldpos)
end

function bringTree(treeClass)
    local success, data = barkgetBestAxe()
    if not data then
        notify("小星", "需要斧头", 3)
        return
    end
    
    local treeCut = false
    local tree = getBiggestTree(treeClass)
    if not tree then
        notify("小星", "没有找到树", 3)
        return
    end
    
    local connection = workspace.LogModels.ChildAdded:Connect(function(child)
        local owner = child:WaitForChild("Owner")
        if owner.Value == lp and child.TreeClass.Value == treeClass then
            child.PrimaryPart = child:FindFirstChild("WoodSection")
            treeCut = true
            spawn(function()
                for i = 1, 60 do
                    replicatedStorage.Interaction.ClientIsDragging:FireServer(child)
                    child:PivotTo(bai.treecutset)
                    wait()
                end
            end)
        end
    end)
    
    spawn(function()
        repeat
            tp(tree.CFrame + Vector3.new(3, 3, 0))
            local axeStats = getToolStats(data)
            replicatedStorage.Interaction.RemoteProxy:FireServer(tree.Parent.CutEvent, {
                tool = data,
                faceVector = Vector3.new(-1, 0, 0),
                height = 0.3,
                sectionId = 1,
                hitPoints = axeStats.Damage,
                cooldown = axeStats.SwingCooldown,
                cuttingClass = "Axe"
            })
            wait()
        until treeCut
    end)
    
    wait(5)
    connection:Disconnect()
end

function autofarm(treeClass)
    local oldpos = lp.Character.HumanoidRootPart.CFrame
    local success, data = barkgetBestAxe()
    if not data then
        notify("小星", "需要斧头", 3)
        return
    end
    
    local tree = getBiggestTree(treeClass)
    if not tree then
        notify("小星", "没有找到树", 3)
        return
    end
    
    local treeCut = false
    local connection = workspace.LogModels.ChildAdded:Connect(function(child)
        if child.Owner.Value == lp and child.TreeClass.Value == treeClass then
            child.PrimaryPart = child:FindFirstChild("WoodSection")
            treeCut = true
            for i = 1, 70 do
                replicatedStorage.Interaction.ClientIsDragging:FireServer(child.WoodSection)
                child:MoveTo(oldpos)
                wait()
            end
        end
    end)
    
    spawn(function()
        repeat
            tp(tree.trunk.CFrame * CFrame.new(4, 3, 4))
            wait()
        until treeCut
    end)
    
    local axeStats = getToolStats(data)
    repeat
        replicatedStorage.Interaction.RemoteProxy:FireServer(tree.tree.CutEvent, {
            tool = data,
            faceVector = Vector3.new(-1, 0, 0),
            height = 0.3,
            sectionId = 1,
            hitPoints = axeStats.Damage,
            cooldown = axeStats.SwingCooldown,
            cuttingClass = "Axe"
        })
        wait(axeStats.SwingCooldown)
    until treeCut
    
    tp(oldpos)
    connection:Disconnect()
end

function farAxeEquip()
    local done = false
    notify("小星", "点击一把斧头装备", 3)
    local connection = mouse.Button1Down:Connect(function()
        local target = mouse.Target
        if target.Parent:FindFirstChild('ToolName') then
            replicatedStorage.Interaction.ClientInteracted:FireServer(target.Parent, 'Pick up tool')
            done = true
            notify("小星", "已装备", 2)
        end
    end)
    repeat wait() until done
    connection:Disconnect()
end

function autobuyv2(itemName)
    local item = nil
    for _, store in pairs(workspace.Stores:GetChildren()) do
        if store.Name == "ShopItems" then
            for _, box in pairs(store:GetChildren()) do
                if box:FindFirstChild("BoxItemName") and box.BoxItemName.Value == itemName then
                    item = box
                    break
                end
            end
        end
        if item then break end
    end
    
    if not item then
        notify("小星", "没有找到商品", 3)
        return
    end
    
    local counter = CFrame.new(270, 4, 60)
    tp(item.Main.CFrame)
    wait()
    
    for i = 1, 15 do
        replicatedStorage.Interaction.ClientIsDragging:FireServer(item)
        item:PivotTo(counter)
        replicatedStorage.Interaction.ClientIsDragging:FireServer(item)
        wait()
    end
    
    tp(counter + Vector3.new(5, 0, 5))
    
    local shopID = { ID = 7 }
    repeat
        BuyItem(shopID)
        wait()
    until item.Parent ~= "ShopItems"
end

function autobuy(itemName, amount)
    bai.autobuystop = false
    bai.autobuyset = lp.Character.HumanoidRootPart.CFrame
    
    local connection = workspace.PlayerModels.ChildAdded:Connect(function(child)
        child:WaitForChild('Owner', 60)
        if child.Owner.Value == lp then
            for i = 1, 20 do
                replicatedStorage.Interaction.ClientIsDragging:FireServer(child)
                child:PivotTo(bai.autobuyset)
                replicatedStorage.Interaction.ClientIsDragging:FireServer(child)
                wait()
            end
        end
    end)
    
    for i = 1, amount do
        if bai.autobuystop then break end
        autobuyv2(itemName)
        wait()
    end
    
    wait(1)
    connection:Disconnect()
end

function applyLight(value)
    if value then
        local light = Instance.new('PointLight', lp.Character.Head)
        light.Name = 'baiLight'
        light.Range = 150
        light.Brightness = 1.7
    else
        pcall(function() lp.Character.Head.baiLight:Destroy() end)
    end
end

function NoClip(enabled)
    if enabled then
        game:GetService("RunService").Stepped:Connect(function()
            for _, v in pairs(lp.Character:GetChildren()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end)
    end
end

function TurnInvisible()
    for _, v in pairs(lp.Character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = 1
        end
    end
end

function TurnVisible()
    for _, v in pairs(lp.Character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = 0
        end
    end
end

function lowerBridge(value)
    local lift = workspace.Bridge.VerticalLiftBridge.Lift
    local offset = value == 'Lower' and -26 or 26
    for _, v in pairs(lift:GetChildren()) do
        v.CFrame = v.CFrame + Vector3.new(0, offset, 0)
    end
end

function getPosition()
    return lp.Character and lp.Character.HumanoidRootPart.CFrame or CFrame.new()
end

function OpenSelectedItem(item)
    local itemBox = item:FindFirstChild('BoxItemName') or item:FindFirstChild('PurchasedBoxItemName')
    if itemBox and item:FindFirstChild('Type') and item.Type.Value ~= 'Structure' then
        replicatedStorage.Interaction.ClientInteracted:FireServer(item, 'Open box')
        notify('小星', '成功打开', 3)
    end
end

function PlankToBlueprint()
    local target
    notify('小星', '点击一个木头再点一个蓝图', 3)
    local connection = mouse.Button1Down:Connect(function()
        local clicked = mouse.Target
        if clicked.Parent:FindFirstChild('Type') and clicked.Parent.Type.Value == 'Blueprint' then
            bai.blueprintModel = clicked.Parent
            notify('小星', '蓝图已选择', 2)
        end
        if clicked.Parent.Name == 'Plank' and clicked.Parent:FindFirstChild('Owner') and clicked.Parent.Owner.Value == lp then
            bai.plankModel = clicked.Parent
            notify('小星', '木头已选择', 2)
        end
    end)
    repeat wait() until bai.plankModel and bai.blueprintModel
    connection:Disconnect()
    
    tp(CFrame.new(bai.plankModel.WoodSection.CFrame.p + Vector3.new(0, 3, 4)))
    wait(.2)
    for i = 1, 30 do
        pcall(function()
            replicatedStorage.Interaction.ClientIsDragging:FireServer(bai.plankModel)
            bai.plankModel.WoodSection.CFrame = CFrame.new(bai.blueprintModel.Main.CFrame.p + Vector3.new(0, 1.5, 0))
            wait()
        end)
    end
    notify('小星', '完成', 2)
    bai.blueprintModel = nil
    bai.plankModel = nil
end

function donate(plr, amount)
    if tostring(plr) == tostring(lp) then
        notify('错误', '请选择玩家', 3)
        return
    end
    if not game:GetService('Players'):FindFirstChild(plr) then
        notify('错误', '没有找到玩家', 3)
        return
    end
    if tonumber(amount) > lp.leaderstats.Money.Value then
        notify('错误', '钱不够', 3)
        return
    end
    
    local scr = getsenv(lp.PlayerGui.DonateGUI.DonateClient)
    scr.openWindow()
    wait()
    game.ReplicatedStorage.Transactions.ClientToServer.Donate:InvokeServer(game:GetService('Players'):FindFirstChild(plr), tonumber(amount), tonumber(lp.CurrentSaveSlot.Value))
    wait()
    scr.sendDonation()
    notify('小星', '转钱 ' .. amount .. ' 给 ' .. plr, 4)
end

function lowerBridge(value)
    if value == 'Higher' then
        for _, v in pairs(workspace.Bridge.VerticalLiftBridge.Lift:GetChildren()) do
            v.CFrame = v.CFrame + Vector3.new(0, 26, 0)
        end
    elseif value == 'Lower' then
        for _, v in pairs(workspace.Bridge.VerticalLiftBridge.Lift:GetChildren()) do
            v.CFrame = v.CFrame + Vector3.new(0, -26, 0)
        end
    end
end

function burnAllShopItems()
    local found = false
    for _, plate in pairs(workspace.PlayerModels:GetChildren()) do
        if plate:FindFirstChild('ItemName') and plate.ItemName.Value == 'PressurePlate' then
            if plate.Output.BrickColor ~= BrickColor.new('Electric blue') then
                repeat
                    wait()
                    lp.Character.HumanoidRootPart.CFrame = CFrame.new(plate.Plate.CFrame.p + Vector3.new(0, .3, 0))
                until plate.Output.BrickColor == BrickColor.new('Electric blue')
                found = true
            end
        end
    end
    if not found then
        notify('小星', '没有找到压力板', 3)
    end
end

function axefily()
    bai.axeFling = mouse.Button1Down:Connect(function()
        local axe = nil
        local connection = workspace.PlayerModels.ChildAdded:Connect(function(v)
            v:WaitForChild('Owner', 60)
            if v.Owner.Value == lp then
                axe = v
                wait(2)
                replicatedStorage.Interaction.ClientInteracted:FireServer(axe, 'Pick up tool')
            end
        end)
        
        local oldpos = lp.Character.HumanoidRootPart.CFrame
        droptool(oldpos)
        repeat wait(0.1) until axe ~= nil
        connection:Disconnect()
        
        local fling = Instance.new('BodyPosition', axe.Main)
        fling.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        fling.P = 650000
        fling.Position = mouse.Hit.p
        
        spawn(function()
            while bai.whthmose do
                wait(0.1)
                fling.Position = mouse.Hit.p
            end
        end)
        
        axe.Main.CanCollide = false
        repeat
            wait()
            axe.Main.RotVelocity = Vector3.new(5, 5, 5) * 9e9
        until (axe.Main.CFrame.p - fling.Position).Magnitude < 1
        wait(7)
        fling:Destroy()
        axe.Main.CanCollide = true
    end)
end

local Window = WindUI:CreateWindow({
    Title = "小星 - 伐木大亨2",
    Icon = "rbxassetid://18941716391",
    IconThemed = true,
    Author = "<font color='#00FFFF'>作者: 小星</font>",
    Folder = "星脚本",
    Size = UDim2.fromOffset(320, 280),
    Transparent = true,
    Theme = "Dark",
    BackgroundImageTransparency = 0.4,
    User = { Enabled = true, Anonymous = true },
    SideBarWidth = 200,
    HideSearchBar = false,
    ScrollBarEnabled = true,
})

task.wait(0.5)

local mainFrame = Window.UIElements.Main
if mainFrame then
    for _, label in ipairs(mainFrame:GetDescendants()) do
        if label:IsA("TextLabel") and label.Text == "小星 - 伐木大亨2" then
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

Window:EditOpenButton({
    Title = "<font color='#00FFFF'>星</font>-<font color='#FF00FF'>脚本</font> ",
    Icon = "rbxassetid://18941716391",
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

local mainTab = Window:Section({ Title = "主要功能", Opened = true })

local playerTab = mainTab:Tab({ Title = "玩家", Icon = "rbxassetid://10882439086" })

playerTab:Slider({
    Title = "移动速度",
    Value = { Min = 16, Max = 600, Default = 16 },
    Callback = function(v)
        bai.walkspeed = v
        spawn(function()
            while wait() do
                pcall(function()
                    lp.Character.Humanoid.WalkSpeed = bai.walkspeed
                end)
            end
        end)
    end
})

playerTab:Slider({
    Title = "跳跃高度",
    Value = { Min = 50, Max = 600, Default = 50 },
    Callback = function(v)
        bai.JumpPower = v
        spawn(function()
            while wait() do
                pcall(function()
                    lp.Character.Humanoid.JumpPower = bai.JumpPower
                end)
            end
        end)
    end
})

playerTab:Slider({
    Title = "重力",
    Value = { Min = -999, Max = 999, Default = 198 },
    Callback = function(v)
        workspace.Gravity = v
    end
})

playerTab:Toggle({
    Title = "穿墙模式",
    Default = false,
    Callback = function(v)
        NoClip(v)
    end
})

playerTab:Toggle({
    Title = "自身发光",
    Default = false,
    Callback = function(v)
        applyLight(v)
    end
})

playerTab:Toggle({
    Title = "隐身模式",
    Default = false,
    Callback = function(v)
        if v then TurnInvisible() else TurnVisible() end
    end
})

playerTab:Button({
    Title = "飞行模式",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/meozoneYT/bf037dff9f0a70017304ddd67fdcd370/raw/e14e74f425b060df5233343cf30b8757074eb3c5/arceus%2520x%2520fly%25202%2520obfuscator"))()
    end
})

playerTab:Button({
    Title = "安全自杀",
    Callback = function()
        if lp.Character and lp.Character:FindFirstChild("Head") then
            lp.Character.Head:Destroy()
        end
    end
})

local tpTab = mainTab:Tab({ Title = "传送", Icon = "rbxassetid://10728953248" })

local tpLocations = {
    '出生点', '木材反斗城', '土地商店', '桥', '码头', '椰子岛', '洞穴',
    '鲨鱼斧合成', '火山', '沼泽', '家具店', '盒子车行', '连锁逻辑店',
    '鲍勃的小店', '画廊', '雪山', '灵视神殿', '怪人', '小绿盒',
    '滑雪小屋', '黄金木洞穴', '小鸟斧头', '灯塔', '回家'
}

local tpCoords = {
    ['出生点'] = CFrame.new(174, 10.5, 66),
    ['木材反斗城'] = CFrame.new(270, 4, 60),
    ['土地商店'] = CFrame.new(270, 3, -98),
    ['桥'] = CFrame.new(112, 37, -892),
    ['码头'] = CFrame.new(1136, 0, -206),
    ['椰子岛'] = CFrame.new(2614, -4, -34),
    ['洞穴'] = CFrame.new(3590, -177, 415),
    ['鲨鱼斧合成'] = CFrame.new(330.259735, 45.7998505, 1943.30823),
    ['火山'] = CFrame.new(-1588, 623, 1069),
    ['沼泽'] = CFrame.new(-1216, 131, -822),
    ['家具店'] = CFrame.new(486, 3, -1722),
    ['盒子车行'] = CFrame.new(509, 3, -1458),
    ['连锁逻辑店'] = CFrame.new(4615, 7, -794),
    ['鲍勃的小店'] = CFrame.new(292, 8, -2544),
    ['画廊'] = CFrame.new(5217, -166, 721),
    ['雪山'] = CFrame.new(1487, 415, 3259),
    ['灵视神殿'] = CFrame.new(-1608, 195, 928),
    ['怪人'] = CFrame.new(1071, 16, 1141),
    ['小绿盒'] = CFrame.new(-1667, 349, 1474),
    ['滑雪小屋'] = CFrame.new(1244, 59, 2290),
    ['黄金木洞穴'] = CFrame.new(-1080, -5, -942),
    ['小鸟斧头'] = CFrame.new(4813.1, 33.5, -978.8),
    ['灯塔'] = CFrame.new(1464.8, 356.3, 3257.2),
}

tpTab:Dropdown({
    Title = "传送位置",
    Values = tpLocations,
    Value = "出生点",
    Callback = function(v)
        if v == '回家' then
            for _, prop in pairs(workspace.Properties:GetChildren()) do
                if prop.Owner.Value == lp then
                    tp(prop.OriginSquare.CFrame + Vector3.new(0, 10, 0))
                end
            end
        elseif tpCoords[v] then
            tp(tpCoords[v])
        end
    end
})

tpTab:Dropdown({
    Title = "汽车传送",
    Values = tpLocations,
    Value = "出生点",
    Callback = function(v)
        if v == '回家' then
            for _, prop in pairs(workspace.Properties:GetChildren()) do
                if prop.Owner.Value == lp then
                    carTeleport(prop.OriginSquare.CFrame + Vector3.new(0, 10, 0))
                end
            end
        elseif tpCoords[v] then
            carTeleport(tpCoords[v])
        end
    end
})

local treeTab = mainTab:Tab({ Title = "砍树", Icon = "rbxassetid://10728953248" })

local treeTypes = {'普通树', '幻影木', '沼泽黄金', '樱花', '蓝木', '冰木', '火山木', '橡木', '巧克力木', '小星桦木', '黄金木', '雪地松', '僵尸木', '大巧克力树', '椰子树', '南瓜木', '幽灵木'}
local treeMap = {
    ['普通树'] = 'Generic', ['幻影木'] = 'LoneCave', ['沼泽黄金'] = 'GoldSwampy',
    ['樱花'] = 'Cherry', ['蓝木'] = 'CaveCrawler', ['冰木'] = 'Frost',
    ['火山木'] = 'Volcano', ['橡木'] = 'Oak', ['巧克力木'] = 'Walnut',
    ['小星桦木'] = 'Birch', ['黄金木'] = 'SnowGlow', ['雪地松'] = 'Pine',
    ['僵尸木'] = 'GreenSwampy', ['大巧克力树'] = 'Koa', ['椰子树'] = 'Palm',
    ['南瓜木'] = 'SpookyNeon', ['幽灵木'] = 'Spooky'
}

treeTab:Dropdown({
    Title = "选择树种",
    Values = treeTypes,
    Value = "普通树",
    Callback = function(v)
        bai.cuttreeselect = treeMap[v] or 'Generic'
    end
})

treeTab:Textbox({
    Title = "带来树数量",
    Value = "1",
    PlaceholderText = "输入数量",
    Callback = function(v)
        bai.bringamount = tonumber(v) or 1
    end
})

treeTab:Button({
    Title = "带来树",
    Callback = function()
        bai.bringtree = true
        bai.treecutset = lp.Character.HumanoidRootPart.CFrame
        wait(0.2)
        for i = 1, bai.bringamount do
            if bai.bringtree then
                bringTree(bai.cuttreeselect)
                wait()
            end
        end
    end
})

treeTab:Button({
    Title = "停止带树",
    Callback = function()
        bai.bringtree = false
    end
})

treeTab:Toggle({
    Title = "自动砍树",
    Default = false,
    Callback = function(v)
        bai.autofarm = v
        if v then
            spawn(function()
                while bai.autofarm do
                    bringTree(bai.cuttreeselect)
                    wait(0.3)
                end
            end)
        end
    end
})

treeTab:Toggle({
    Title = "自动赚钱",
    Default = false,
    Callback = function(v)
        bai.autofarm1 = v
        if v then
            spawn(function()
                while bai.autofarm1 do
                    lp.Character:MoveTo(Vector3.new(315, -0.296, 102.791))
                    autofarm(bai.cuttreeselect)
                    wait(1)
                    lp.Character:MoveTo(Vector3.new(315, -0.296, 102.791))
                    wait(20)
                end
            end)
        end
    end
})

treeTab:Button({
    Title = "传送至树",
    Callback = function()
        for _, v in pairs(workspace:GetChildren()) do
            if v.Name == "TreeRegion" then
                for _, tree in pairs(v:GetChildren()) do
                    if tree:FindFirstChild("TreeClass") and tree.TreeClass.Value == bai.cuttreeselect then
                        tp(tree.WoodSection.CFrame + Vector3.new(0, 5, 0))
                        return
                    end
                end
            end
        end
        notify("小星", "没有找到树", 3)
    end
})

local axeTab = mainTab:Tab({ Title = "斧头", Icon = "rbxassetid://10728953248" })

axeTab:Toggle({
    Title = "自动扔斧头",
    Default = false,
    Callback = function(v)
        bai.autodropae = v
        if v then
            spawn(function()
                while bai.autodropae do
                    droptool(lp.Character.HumanoidRootPart.CFrame)
                    wait()
                end
            end)
        end
    end
})

axeTab:Toggle({
    Title = "自动捡斧头",
    Default = false,
    Callback = function(v)
        bai.autopick = v
        if v then
            spawn(function()
                while bai.autopick do
                    wait(0.1)
                    for _, item in pairs(workspace.PlayerModels:GetChildren()) do
                        if item:FindFirstChild("Owner") and item.Owner.Value == lp and
                            item:FindFirstChild("Type") and item.Type.Value == "Tool" then
                            replicatedStorage.Interaction.ClientInteracted:FireServer(item, 'Pick up tool')
                        end
                    end
                end
            end)
        end
    end
})

axeTab:Textbox({
    Title = "死亡加载时间(秒)",
    Value = "3.1",
    PlaceholderText = "输入秒数",
    Callback = function(v)
        bai.loaddupeaxewaittime = tonumber(v) or 3.1
    end
})

axeTab:Button({
    Title = "加载复制斧头",
    Callback = function()
        CanClientLoad()
        wait(1)
        if lp.Character and lp.Character:FindFirstChild("Head") then
            lp.Character.Head:Destroy()
        end
        wait(bai.loaddupeaxewaittime)
        LoadSlot(CheckSlotNumber() or 1)
        wait(6)
        for _, prop in pairs(workspace.Properties:GetChildren()) do
            if prop.Owner.Value == lp then
                tp(prop.OriginSquare.CFrame + Vector3.new(0, 10, 0))
                break
            end
        end
    end
})

axeTab:Button({
    Title = "远程装备斧头",
    Callback = function()
        farAxeEquip()
    end
})

axeTab:Toggle({
    Title = "斧头跟随鼠标",
    Default = false,
    Callback = function(v)
        bai.whthmose = v
    end
})

axeTab:Toggle({
    Title = "斧头炸家",
    Default = false,
    Callback = function(v)
        if v then
            axefily()
        else
            if bai.axeFling then
                bai.axeFling:Disconnect()
                bai.axeFling = nil
            end
        end
    end
})

local woodTab = mainTab:Tab({ Title = "木头", Icon = "rbxassetid://10728953248" })

woodTab:Button({
    Title = "传送木头",
    Callback = function()
        local oldpos = lp.Character.HumanoidRootPart.CFrame
        for _, log in pairs(workspace.LogModels:GetChildren()) do
            if log:FindFirstChild("Owner") and log.Owner.Value == lp then
                tp(log.WoodSection.CFrame)
                spawn(function()
                    for i = 1, 50 do
                        replicatedStorage.Interaction.ClientIsDragging:FireServer(log)
                        wait()
                    end
                end)
                for i = 1, 50 do
                    wait()
                    log:PivotTo(oldpos)
                end
                wait()
            end
        end
        tp(oldpos)
    end
})

woodTab:Button({
    Title = "传送木板",
    Callback = function()
        local oldpos = lp.Character.HumanoidRootPart.CFrame
        for _, plank in pairs(getPlanks()) do
            if plank:FindFirstChild('WoodSection') then
                spawn(function()
                    for i = 1, 20 do
                        replicatedStorage.Interaction.ClientIsDragging:FireServer(plank)
                        wait()
                    end
                end)
                wait(0.18)
                plank:SetPrimaryPartCFrame(oldpos)
            end
        end
    end
})

woodTab:Button({
    Title = "卖木头",
    Callback = function()
        sellwood()
    end
})

woodTab:Toggle({
    Title = "自动卖木头",
    Default = false,
    Callback = function(v)
        bai.autoSellWood = v
        if v then
            spawn(function()
                while bai.autoSellWood do
                    sellwood()
                    wait()
                end
            end)
        end
    end
})

woodTab:Button({
    Title = "卖木板",
    Callback = function()
        for _, plank in pairs(workspace.PlayerModels:GetChildren()) do
            if plank.Name == "Plank" and plank:FindFirstChild("Owner") and plank.Owner.Value == lp then
                for _, v in pairs(plank:GetChildren()) do
                    if v.Name == "WoodSection" then
                        spawn(function()
                            for i = 1, 100 do
                                wait()
                                v.CFrame = CFrame.new(Vector3.new(315, -0.296, 85.791)) * CFrame.Angles(math.rad(90), 0, 0)
                            end
                        end)
                    end
                end
                spawn(function()
                    for i = 1, 100 do
                        wait()
                        replicatedStorage.Interaction.ClientIsDragging:FireServer(plank)
                    end
                end)
            end
        end
    end
})

woodTab:Toggle({
    Title = "自动卖木板",
    Default = false,
    Callback = function(v)
        bai.autoSellPlank = v
        if v then
            spawn(function()
                while bai.autoSellPlank do
                    for _, plank in pairs(workspace.PlayerModels:GetChildren()) do
                        if plank.Name == "Plank" and plank:FindFirstChild("Owner") and plank.Owner.Value == lp then
                            for _, v in pairs(plank:GetChildren()) do
                                if v.Name == "WoodSection" then
                                    spawn(function()
                                        for i = 1, 10 do
                                            wait()
                                            v.CFrame = CFrame.new(Vector3.new(315, -0.296, 85.791)) * CFrame.Angles(math.rad(90), 0, 0)
                                        end
                                    end)
                                end
                            end
                            spawn(function()
                                for i = 1, 20 do
                                    wait()
                                    replicatedStorage.Interaction.ClientIsDragging:FireServer(plank)
                                end
                            end)
                        end
                    end
                    wait()
                end
            end)
        end
    end
})

woodTab:Button({
    Title = "木板填充蓝图",
    Callback = function()
        PlankToBlueprint()
    end
})

local miscTab = mainTab:Tab({ Title = "其他", Icon = "rbxassetid://10728953248" })

miscTab:Textbox({
    Title = "要说的话",
    Value = "",
    PlaceholderText = "输入内容",
    Callback = function(v)
        bai.saymege = v
    end
})

miscTab:Textbox({
    Title = "说话次数",
    Value = "1",
    PlaceholderText = "输入数字",
    Callback = function(v)
        bai.saymount = tonumber(v) or 1
    end
})

miscTab:Button({
    Title = "说话",
    Callback = function()
        bai.sayfast = true
        for i = 1, bai.saymount do
            if bai.sayfast then
                replicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(bai.saymege, 'All')
            end
        end
    end
})

miscTab:Button({
    Title = "停止说话",
    Callback = function()
        bai.sayfast = false
        bai.autosay = false
    end
})

miscTab:Toggle({
    Title = "自动说话",
    Default = false,
    Callback = function(v)
        bai.autosay = v
        if v then
            spawn(function()
                while bai.autosay do
                    replicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(bai.saymege, 'All')
                    wait()
                end
            end)
        end
    end
})

miscTab:Button({
    Title = "重进服务器",
    Callback = function()
        game:GetService("TeleportService"):Teleport(13822889)
    end
})

miscTab:Toggle({
    Title = "远程打开物品",
    Default = false,
    Callback = function(v)
        if v then
            notify('小星', '点击物品打开', 3)
            bai.openItem = mouse.Button1Down:Connect(function()
                if mouse.Target then
                    OpenSelectedItem(mouse.Target.Parent)
                end
            end)
        else
            if bai.openItem then
                bai.openItem:Disconnect()
                bai.openItem = nil
            end
        end
    end
})

miscTab:Button({
    Title = "获得小绿盒",
    Callback = function()
        local greenBox = workspace.Region_Volcano.VolcanoWin
        firetouchinterest(greenBox, lp.Character.HumanoidRootPart, 0)
        firetouchinterest(greenBox, lp.Character.HumanoidRootPart, 1)
    end
})

miscTab:Button({
    Title = "点击传送工具",
    Callback = function()
        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "点击传送工具"
        tool.Activated:Connect(function()
            local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
            tp(CFrame.new(pos.X, pos.Y, pos.Z))
        end)
        tool.Parent = lp.Backpack
        notify("小星", "已获得点击传送工具", 3)
    end
})

local playerListTab = mainTab:Tab({ Title = "玩家列表", Icon = "rbxassetid://10882439086" })

local playerDropdown = playerListTab:Dropdown({
    Title = "选择玩家",
    Values = bai.dropdown,
    Value = bai.dropdown[1] or "",
    Callback = function(v)
        bai.playernamedied = v
        bai.moneytoplayername = v
        bai.mtwjia = v
        bai.zlwjia = v
        bai.cswjia = v
    end
})

playerListTab:Button({
    Title = "刷新列表",
    Callback = function()
        shuaxinlb(true)
        playerDropdown:SetOptions(bai.dropdown)
    end
})

playerListTab:Button({
    Title = "传送到玩家",
    Callback = function()
        local target = game:GetService('Players'):FindFirstChild(bai.playernamedied)
        if target and target.Character then
            tp(target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0))
        end
    end
})

playerListTab:Button({
    Title = "传送到玩家基地",
    Callback = function()
        for _, prop in pairs(workspace.Properties:GetChildren()) do
            if prop.Owner.Value == game:GetService('Players'):FindFirstChild(bai.playernamedied) then
                tp(prop.OriginSquare.CFrame + Vector3.new(0, 10, 0))
            end
        end
    end
})

playerListTab:Button({
    Title = "汽车传送玩家",
    Callback = function()
        local target = game:GetService('Players'):FindFirstChild(bai.playernamedied)
        if target and target.Character then
            carTeleport(target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0))
        end
    end
})

playerListTab:Button({
    Title = "汽车传送玩家基地",
    Callback = function()
        for _, prop in pairs(workspace.Properties:GetChildren()) do
            if prop.Owner.Value == game:GetService('Players'):FindFirstChild(bai.playernamedied) then
                carTeleport(prop.OriginSquare.CFrame + Vector3.new(0, 10, 0))
            end
        end
    end
})

playerListTab:Textbox({
    Title = "转钱数量",
    Value = "1",
    PlaceholderText = "输入数量",
    Callback = function(v)
        bai.moneyaoumt = tonumber(v) or 1
    end
})

playerListTab:Button({
    Title = "转钱",
    Callback = function()
        donate(bai.moneytoplayername, bai.moneyaoumt)
    end
})

playerListTab:Button({
    Title = "斧头杀人",
    Callback = function()
        local tool = barkgetBestAxe()
        if not tool then
            notify("小星", "需要斧头", 3)
            return
        end
        local target = game:GetService('Players'):FindFirstChild(bai.playernamedied)
        if not target or not target.Character then
            notify("小星", "目标不存在", 3)
            return
        end
        local oldpos = lp.Character.HumanoidRootPart.CFrame
        local char = lp.Character
        local clone = char:Clone()
        lp.Character = clone
        wait(0.5)
        lp.Character = char
        wait(0.2)
        if lp.Character and target.Character then
            if lp.Character:FindFirstChildOfClass("Humanoid") then
                lp.Character:FindFirstChildOfClass("Humanoid"):Destroy()
            end
            local humanoid = Instance.new("Humanoid")
            humanoid.Parent = lp.Character
            target.Character.HumanoidRootPart.Anchored = true
            if tool then
                tool.Parent = lp.Backpack
                tool.Parent = lp.Character
            end
            wait(0.1)
            humanoid.Health = 0
            lp.Character = nil
            target.Character.HumanoidRootPart.Anchored = false
            wait()
            lp.CharacterAdded:Wait()
            wait(0.4)
            lp.Character:SetPrimaryPartCFrame(oldpos)
        end
    end
})

local envTab = Window:Section({ Title = "环境", Opened = false })

envTab:Toggle({
    Title = "终日白天",
    Default = false,
    Callback = function(v)
        if v then
            spawn(function()
                while v do
                    game:GetService('Lighting').TimeOfDay = '12:00:00'
                    wait()
                end
            end)
        end
    end
})

envTab:Toggle({
    Title = "终日黑夜",
    Default = false,
    Callback = function(v)
        if v then
            spawn(function()
                while v do
                    game:GetService('Lighting').TimeOfDay = '2:00:00'
                    wait()
                end
            end)
        end
    end
})

envTab:Toggle({
    Title = "消除雾",
    Default = false,
    Callback = function(v)
        if v then
            spawn(function()
                while v do
                    game:GetService('Lighting').FogEnd = 1000000
                    wait()
                end
            end)
        else
            game:GetService('Lighting').FogEnd = 100000
        end
    end
})

envTab:Toggle({
    Title = "水上行走",
    Default = false,
    Callback = function(v)
        for _, water in pairs(workspace.Water:GetChildren()) do
            if water:IsA("BasePart") then
                water.CanCollide = v
            end
        end
        for _, water in pairs(workspace.Bridge.VerticalLiftBridge.WaterModel:GetChildren()) do
            if water:IsA("BasePart") then
                water.CanCollide = v
            end
        end
    end
})

envTab:Toggle({
    Title = "放下桥",
    Default = false,
    Callback = function(v)
        if v then
            lowerBridge("Lower")
        else
            lowerBridge("Higher")
        end
    end
})

envTab:Button({
    Title = "启动所有压力板",
    Callback = function()
        burnAllShopItems()
    end
})

envTab:Button({
    Title = "删除岩浆",
    Callback = function()
        for _, v in pairs(workspace.Region_Volcano:GetDescendants()) do
            if v.Name == "Lava" then
                for _, part in pairs(v:GetChildren()) do
                    if part:IsA("Part") then
                        part.Transparency = 1
                    end
                end
            end
        end
    end
})

envTab:Button({
    Title = "删除水",
    Callback = function()
        for _, v in pairs(workspace.Water:GetChildren()) do
            if v.Name == "Water" then
                v.Transparency = 1
            end
        end
    end
})

envTab:Button({
    Title = "删除迷宫门",
    Callback = function()
        for i = 0, 7 do
            pcall(function()
                workspace.Region_MazeCave.Blockade['Blockade' .. i]:Destroy()
            end)
        end
    end
})

envTab:Button({
    Title = "查看游戏时间",
    Callback = function()
        notify("小星", "当前时间: " .. tostring(game.Lighting.TimeOfDay), 3)
    end
})

local autoBuyTab = Window:Section({ Title = "自动购买", Opened = false })

local itemList = {
    '按钮', '控制杆', '电线', '4/4x1木楔', '3/4x1木楔', '2/4x1木楔', '1/4X1木楔',
    '3/3x1木楔', '2/3x1木楔', '1/3x1木楔', '2/2x1木楔', '1/2x1木楔', '1/1x1木楔',
    '篱笆', '压力板', '1/3木楔', '锯木机01', '锯木机02L', '波纹墙角立柱', '传送带',
    '普通凳子', '倾斜传送带', '3/4木楔', '2/3木楔', '光滑的墙', '光滑墙角',
    '普通锯木厂', '4/4木楔', '光滑墙立柱', '篱笆角', '矮篱笆角', '矮波纹墙',
    '长桌', '矮篱笆', '光滑墙角立柱', '破旧锯木厂', '普通门', '矮光滑墙',
    '工作灯', '弯传送带', '切换传送带', '宽敞门', '3/3木楔', '400元小汽车',
    '波纹墙立柱', '锯木机02', '漏斗式传送带', '小型地板', '小型瓷砖',
    '矮波纹墙角', '波纹墙', '大型地板', '微型瓷砖', '微型地板', '1/1木楔',
    '左转直式传送带', '银斧头', '切割机', '基础斧头', '右转传送带', '普通斧头',
    '转向传送带支架', '传送带支架', '波纹墙角立柱', '楼梯', '陡峭楼梯', '钢斧',
    '标志杆', '梯子', '大型瓷砖', '瓷砖', '硬化斧', '半截门', '木头清扫机',
    '光滑墙立柱', '沙子袋', '小型拖车', '531式拖车', '小汽车XL', '大卡车',
    '长沙发', '洗碗机', '薄柜子', '冰箱', '火炉', '马桶', '双人沙发', '床',
    '落地灯', '台灯', '微型玻璃板', '小型玻璃板', '玻璃板', '大型玻璃板',
    '玻璃门', '琥珀色冰柱灯串', '红色冰柱灯串', '绿色冰柱灯串', '蓝色冰柱灯串',
    '烟花发射器', '惊悚冰柱灯串', '单人沙发', '双人床', '灯泡', '工作台面',
    '薄工作台面', '带水槽的工作台面', '照明灯', '墙灯', '橱柜角', '宽橱柜角',
    '橱柜', '炸药', '毛毛虫软糖', '困扰装饰画', '户外水彩素描', '阴郁的黄昏海景',
    '北极灯串', '菠萝画', '孤独的长颈鹿', '信号维持器', '与门', '异与门',
    '木材检测器', 'OR门', '拉杆', '信号延时器', '信号变换器', '激光', '激光探测器',
    '舱门', '橙色发光线', '绿色发光线', '黄色发光线', '白色发光线', '紫色发光线',
    '红色发光线', '青色发光线', '蓝色发光线', '定时开关'
}

local itemMap = {
    ['按钮'] = 'Button0', ['控制杆'] = 'Lever0', ['电线'] = 'Wire',
    ['4/4x1木楔'] = 'Wedge1_Thin', ['3/4x1木楔'] = 'Wedge2_Thin',
    ['2/4x1木楔'] = 'Wedge3_Thin', ['1/4X1木楔'] = 'Wedge4_Thin',
    ['3/3x1木楔'] = 'Wedge5_Thin', ['2/3x1木楔'] = 'Wedge6_Thin',
    ['1/3x1木楔'] = 'Wedge7_Thin', ['2/2x1木楔'] = 'Wedge8_Thin',
    ['1/2x1木楔'] = 'Wedge9_Thin', ['1/1x1木楔'] = 'Wedge10_Thin',
    ['篱笆'] = 'Wall3TallThin', ['压力板'] = 'PressurePlate',
    ['1/3木楔'] = 'Wedge7', ['锯木机01'] = 'Sawmill3',
    ['锯木机02L'] = 'Sawmill4L', ['波纹墙角立柱'] = 'Wall1ShortCorner',
    ['传送带'] = 'StraightConveyor', ['普通凳子'] = 'Chair1',
    ['倾斜传送带'] = 'TiltConveyor', ['3/4木楔'] = 'Wedge2',
    ['2/3木楔'] = 'Wedge6', ['光滑的墙'] = 'Wall2',
    ['光滑墙角'] = 'Wall2TallCorner', ['普通锯木厂'] = 'Sawmill2',
    ['4/4木楔'] = 'Wedge1', ['光滑墙立柱'] = 'Wall2Short',
    ['篱笆角'] = 'Wall3TallCorner', ['矮篱笆角'] = 'Wall3Corner',
    ['矮波纹墙'] = 'Wall1Thin', ['长桌'] = 'Table2',
    ['矮篱笆'] = 'Wall3', ['光滑墙角立柱'] = 'Wall2ShortCorner',
    ['破旧锯木厂'] = 'Sawmill', ['普通门'] = 'Door1',
    ['矮光滑墙'] = 'Wall2', ['工作灯'] = 'WorkLight',
    ['弯传送带'] = 'TightTurnConveyor', ['切换传送带'] = 'ConveyorSwitch',
    ['宽敞门'] = 'Door3', ['3/3木楔'] = 'Wedge5',
    ['400元小汽车'] = 'UtilityTruck', ['波纹墙立柱'] = 'Wall1ShortThin',
    ['锯木机02'] = 'Sawmill4L', ['漏斗式传送带'] = 'ConveyorFunnel',
    ['小型地板'] = 'Floor1Small', ['小型瓷砖'] = 'Floor2Small',
    ['矮波纹墙角'] = 'Wall1Corner', ['波纹墙'] = 'Wall1Tall',
    ['大型地板'] = 'Floor1Large', ['微型瓷砖'] = 'Floor2Tiny',
    ['微型地板'] = 'Floor1Tiny', ['1/1木楔'] = 'Wedge10',
    ['左转直式传送带'] = 'StraightSwitchConveyorLeft', ['银斧头'] = 'SilverAxe',
    ['切割机'] = 'ChopSaw', ['基础斧头'] = 'BasicHatchet',
    ['右转传送带'] = 'StraightSwitchConveyorRight', ['普通斧头'] = 'Axe1',
    ['转向传送带支架'] = 'TightTurnConveyorSupports', ['传送带支架'] = 'ConveyorSupports',
    ['楼梯'] = 'Stair2', ['陡峭楼梯'] = 'Stair1', ['钢斧'] = 'Axe2',
    ['标志杆'] = 'Post', ['梯子'] = 'Ladder1', ['大型瓷砖'] = 'Floor2Large',
    ['瓷砖'] = 'Floor2', ['硬化斧'] = 'Axe3', ['半截门'] = 'Door2',
    ['木头清扫机'] = 'LogSweeper', ['光滑墙立柱'] = 'Wall2ShortThin',
    ['沙子袋'] = 'BagOfSand', ['小型拖车'] = 'SmallTrailer',
    ['531式拖车'] = 'Trailer2', ['小汽车XL'] = 'UtilityTruck2',
    ['大卡车'] = 'Pickup1', ['长沙发'] = 'Seat_Couch',
    ['洗碗机'] = 'Dishwasher', ['薄柜子'] = 'Cabinet1Thin',
    ['冰箱'] = 'Refridgerator', ['马桶'] = 'Toilet',
    ['双人沙发'] = 'Seat_Loveseat', ['床'] = 'Bed1',
    ['落地灯'] = 'FloorLamp1', ['台灯'] = 'Lamp1',
    ['微型玻璃板'] = 'GlassPane1', ['小型玻璃板'] = 'GlassPane2',
    ['玻璃板'] = 'GlassPane3', ['大型玻璃板'] = 'GlassPane4',
    ['玻璃门'] = 'GlassDoor1', ['琥珀色冰柱灯串'] = 'IcicleWireAmber',
    ['红色冰柱灯串'] = 'IcicleWireRed', ['绿色冰柱灯串'] = 'IcicleWireGreen',
    ['蓝色冰柱灯串'] = 'IcicleWireBlue', ['烟花发射器'] = 'FireworkLauncher',
    ['惊悚冰柱灯串'] = 'IcicleWireHalloween', ['单人沙发'] = 'Seat_Armchair',
    ['双人床'] = 'Bed2', ['灯泡'] = 'LightBulb',
    ['工作台面'] = 'CounterTop1', ['薄工作台面'] = 'CounterTop1Thin',
    ['带水槽的工作台面'] = 'CounterTop1Sink', ['照明灯'] = 'WallLight2',
    ['墙灯'] = 'WallLight1', ['橱柜角'] = 'Cabinet1CornerTight',
    ['宽橱柜角'] = 'Cabinet1CornerWide', ['橱柜'] = 'Cabinet1',
    ['毛毛虫软糖'] = 'CanOfWorms', ['炸药'] = 'Dynamite',
    ['困扰装饰画'] = 'Painting2', ['户外水彩素描'] = 'Painting3',
    ['阴郁的黄昏海景'] = 'Painting6', ['北极灯串'] = 'Painting7',
    ['菠萝画'] = 'Painting8', ['孤独的长颈鹿'] = 'Painting9',
    ['信号维持器'] = 'SignalSustain', ['与门'] = 'GateAND',
    ['异与门'] = 'GateXOR', ['木材检测器'] = 'WoodChecker',
    ['OR门'] = 'GateOR', ['拉杆'] = 'Lever0',
    ['信号延时器'] = 'SignalDelay', ['信号变换器'] = 'GateNOT',
    ['激光'] = 'Laser', ['激光探测器'] = 'LaserReceiver',
    ['舱门'] = 'Hatch', ['橙色发光线'] = 'NeonWireOrange',
    ['绿色发光线'] = 'NeonWireGreen', ['黄色发光线'] = 'NeonWireYellow',
    ['白色发光线'] = 'NeonWireWhite', ['紫色发光线'] = 'NeonWireViolet',
    ['红色发光线'] = 'NeonWireRed', ['青色发光线'] = 'NeonWireCyan',
    ['蓝色发光线'] = 'NeonWireBlue', ['定时开关'] = 'ClockSwitch'
}

local selectedItem = "Button0"

autoBuyTab:Dropdown({
    Title = "选择物品",
    Values = itemList,
    Value = "按钮",
    Callback = function(v)
        selectedItem = itemMap[v] or 'Button0'
    end
})

autoBuyTab:Textbox({
    Title = "购买数量",
    Value = "1",
    PlaceholderText = "输入数量",
    Callback = function(v)
        bai.autobuyamount = tonumber(v) or 1
    end
})

autoBuyTab:Button({
    Title = "开始购买",
    Callback = function()
        bai.autobuystop = false
        bai.autobuyset = lp.Character.HumanoidRootPart.CFrame
        autobuy(selectedItem, bai.autobuyamount)
        wait()
        tp(bai.autobuyset)
    end
})

autoBuyTab:Button({
    Title = "停止购买",
    Callback = function()
        bai.autobuystop = true
        if bai.autocsdx then
            bai.autocsdx:Disconnect()
            bai.autocsdx = nil
        end
    end
})

autoBuyTab:Button({
    Title = "买鲨鱼斧头",
    Callback = function()
        bai.autobuystop = false
        bai.autobuyset = CFrame.new(319, 43, 1914)
        autobuy("BagOfSand", 1)
        wait(0.1)
        bai.autobuyset = CFrame.new(317, 43, 1918)
        autobuy('CanOfWorms', 1)
        wait(0.1)
        bai.autobuyset = CFrame.new(322, 43, 1916)
        autobuy('LightBulb', 1)
        tp(bai.autobuyset)
        
        local axeConnection = workspace.PlayerModels.ChildAdded:Connect(function(child)
            local main = child:FindFirstChild('Main', 60)
            if main and main:FindFirstChild('Mesh') and main.Mesh.TextureId == 'rbxassetid://273892918' then
                repeat wait() until child:FindFirstChild('ToolName')
                tp(CFrame.new(child.Main.CFrame.p))
                repeat
                    wait()
                    replicatedStorage.Interaction.ClientIsDragging:FireServer(child)
                    replicatedStorage.Interaction.ClientInteracted:FireServer(child, 'Pick up tool')
                until child.Parent ~= 'PlayerModels'
                axeConnection:Disconnect()
                if bai.boxOpenConnection then
                    bai.boxOpenConnection:Disconnect()
                    bai.boxOpenConnection = nil
                end
            end
        end)
        
        bai.boxOpenConnection = workspace.PlayerModels.ChildAdded:Connect(function(child)
            wait(0.5)
            local owner = child:FindFirstChild('Owner', 60)
            if owner and owner.Value == lp then
                local itemName = child:FindFirstChild('ItemName') or child:FindFirstChild('PurchasedBoxItemName')
                if itemName and (itemName.Value == 'BagOfSand' or itemName.Value == 'CanOfWorms' or itemName.Value == 'LightBulb') then
                    wait(0.1)
                    replicatedStorage.Interaction.ClientInteracted:FireServer(child, 'Open box')
                end
            end
        end)
    end
})

autoBuyTab:Button({
    Title = "买黄金蓝图",
    Callback = function()
        local strangeMan = workspace.Region_Main['Strange Man']
        BuyItem({
            Character = strangeMan,
            Name = 'Strange Man',
            ID = 13,
            Dialog = strangeMan.Dialog
        })
    end
})

autoBuyTab:Button({
    Title = "买桥",
    Callback = function()
        local seranok = workspace.Bridge.TollBooth0.Seranok
        BuyItem({
            Character = seranok,
            Name = 'Seranok',
            ID = 14,
            Dialog = seranok.Dialog
        })
    end
})

autoBuyTab:Button({
    Title = "买船票",
    Callback = function()
        local hoover = workspace.Ferry.Ferry.Hoover
        BuyItem({
            Character = hoover,
            Name = 'Hoover',
            ID = 15,
            Dialog = hoover.Dialog
        })
    end
})

local organizeTab = Window:Section({ Title = "整理", Opened = false })

organizeTab:Dropdown({
    Title = "选择玩家",
    Values = bai.dropdown,
    Value = bai.dropdown[1] or "",
    Callback = function(v)
        bai.zlwjia = v
    end
})

organizeTab:Dropdown({
    Title = "选择木头类型",
    Values = treeTypes,
    Value = "普通树",
    Callback = function(v)
        bai.zlmt = treeMap[v] or 'Generic'
    end
})

organizeTab:Textbox({
    Title = "X轴数量",
    Value = "1",
    PlaceholderText = "输入数字",
    Callback = function(v)
        bai.zix = tonumber(v) or 1
    end
})

organizeTab:Textbox({
    Title = "Z轴数量",
    Value = "3",
    PlaceholderText = "输入数字",
    Callback = function(v)
        bai.zlz = tonumber(v) or 3
    end
})

organizeTab:Toggle({
    Title = "竖向整理",
    Default = false,
    Callback = function(v)
        bai.shuzhe = v
    end
})

organizeTab:Button({
    Title = "开始整理木板",
    Callback = function()
        if not bai.zlmt then
            notify("小星", "请选择木头类型", 3)
            return
        end
        local oldpos = lp.Character.HumanoidRootPart.Position
        for _, plank in pairs(workspace.PlayerModels:GetChildren()) do
            if plank.Name == "Plank" and plank:FindFirstChild("Owner") and plank.Owner.Value == game:GetService('Players'):FindFirstChild(bai.zlwjia) then
                if plank.TreeClass.Value == bai.zlmt then
                    tp(plank.WoodSection.CFrame)
                    for i = 1, 50 do
                        replicatedStorage.Interaction.ClientIsDragging:FireServer(plank)
                        if bai.shuzhe then
                            plank.WoodSection.CFrame = CFrame.new(oldpos)
                        else
                            plank.WoodSection.Position = oldpos
                        end
                        replicatedStorage.Interaction.ClientIsDragging:FireServer(plank)
                        wait()
                    end
                end
            end
        end
        notify("小星", "整理完成", 3)
    end
})

organizeTab:Button({
    Title = "获取整理工具",
    Callback = function()
        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "点击要整理的物品"
        tool.Activated:Connect(function()
            local playerPos = lp.Character.HumanoidRootPart.Position - Vector3.new(0, 4, 0)
            local items = {}
            local target = mouse.Target.Parent
            local itemType = nil
            
            if target:FindFirstChild("PurchasedBoxItemName") then
                itemType = target.PurchasedBoxItemName.Value
            elseif target:FindFirstChild("ItemName") then
                itemType = target.ItemName.Value
            else
                notify("小星", "请点击一个物品", 3)
                return
            end
            
            for _, v in pairs(workspace.PlayerModels:GetChildren()) do
                if v:FindFirstChild("Owner") and v.Owner.Value == game:GetService('Players'):FindFirstChild(bai.zlwjia) then
                    local check = v:FindFirstChild("PurchasedBoxItemName") or v:FindFirstChild("ItemName")
                    if check and check.Value == itemType then
                        table.insert(items, v)
                    end
                end
            end
            
            local count = 0
            for y = 1, math.ceil(#items / (bai.zlz * bai.zix)) do
                for x = 1, bai.zlz do
                    for z = 1, bai.zix do
                        count = count + 1
                        if items[count] then
                            tp(items[count].Main.CFrame + Vector3.new(3, 0, 3))
                            for i = 1, 40 do
                                replicatedStorage.Interaction.ClientIsDragging:FireServer(items[count])
                                items[count].Main.CFrame = CFrame.new(x * items[1].Main.Size.X,
                                    y * items[1].Main.Size.Y, z * items[1].Main.Size.Z) + playerPos
                                replicatedStorage.Interaction.ClientIsDragging:FireServer(items[count])
                                wait()
                            end
                        end
                    end
                end
            end
            notify("小星", "整理完成: " .. itemType, 3)
        end)
        tool.Parent = lp.Backpack
        notify("小星", "已获得整理工具", 3)
    end
})

organizeTab:Button({
    Title = "刷新列表",
    Callback = function()
        shuaxinlb(true)
        organizeTab:SetOptions(bai.dropdown)
    end
})

local fillTab = Window:Section({ Title = "填充蓝图", Opened = false })

fillTab:Dropdown({
    Title = "选择木头类型",
    Values = treeTypes,
    Value = "普通树",
    Callback = function(v)
        bai.tchonmt = treeMap[v] or 'Generic'
    end
})

fillTab:Button({
    Title = "获取填充工具",
    Callback = function()
        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "点击蓝图填充"
        tool.Activated:Connect(function()
            local target = getMouseTarget()
            if target and target.Parent:FindFirstChild("Type") and target.Parent.Type.Value == "Blueprint" and
                target.Parent:FindFirstChild("Owner") then
                local function lumbsmasher_legitpaint(wood_class, blueprint)
                    local oldpos = lp.Character.HumanoidRootPart.CFrame
                    local remote = replicatedStorage.PlaceStructure.ClientPlacedStructure
                    local bp_type = blueprint.ItemName.Value
                    
                    local wood = 1
                    if lp.SuperBlueprint and lp.SuperBlueprint.Value then
                        wood = 1
                    end
                    
                    local tool = barkgetBestAxe()
                    if not tool then
                        notify("小星", "需要斧头", 3)
                        return
                    end
                    
                    local required_wood = wood
                    local woodSection = nil
                    local minSize = 9e99
                    
                    for _, v in pairs(workspace:GetChildren()) do
                        if v.Name == 'TreeRegion' then
                            for _, tree in pairs(v:GetChildren()) do
                                if tree:FindFirstChild('Leaves') and tree:FindFirstChild('WoodSection') and
                                    tree:FindFirstChild('TreeClass') and tree.TreeClass.Value == wood_class then
                                    for _, section in pairs(tree:GetChildren()) do
                                        if section.Name == 'WoodSection' then
                                            local size = section.Size.X * section.Size.Y * section.Size.Z
                                            if size > required_wood and #section.ChildIDs:GetChildren() == 0 then
                                                if minSize > section.Size.X then
                                                    minSize = section.Size.X
                                                    woodSection = section
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    
                    if not woodSection then
                        notify("小星", "没有找到树", 3)
                        return
                    end
                    
                    local chopped = false
                    local treeConn = workspace.LogModels.ChildAdded:Connect(function(add)
                        local owner = add:WaitForChild('Owner')
                        if add.Owner.Value == lp and add.TreeClass.Value == wood_class and add:FindFirstChild("WoodSection") then
                            chopped = add
                            treeConn:Disconnect()
                        end
                    end)
                    
                    local cutSize = required_wood / (woodSection.Size.X * woodSection.Size.X) + 0.01
                    local axeStats = getToolStats(tool)
                    
                    local function axeCut(v, id, h)
                        replicatedStorage.Interaction.RemoteProxy:FireServer(v.CutEvent, {
                            tool = tool,
                            faceVector = Vector3.new(0, 0, -1),
                            height = h,
                            sectionId = id,
                            hitPoints = axeStats.Damage,
                            cooldown = 0.112,
                            cuttingClass = "Axe"
                        })
                        wait()
                    end
                    
                    local iterations = 0
                    while not chopped do
                        iterations = iterations + 1
                        if iterations > 1000 then
                            replicatedStorage.Interaction.ClientIsDragging:FireServer(woodSection.Parent)
                            replicatedStorage.Interaction.DestroyStructure:FireServer(woodSection.Parent)
                            chopped = true
                        end
                        tp(woodSection.CFrame + Vector3.new(4, 2, 2))
                        axeCut(woodSection.Parent, woodSection.ID.Value, woodSection.Size.Y - cutSize)
                    end
                    
                    local target_cframe = blueprint.MainCFrame and blueprint.MainCFrame.Value or blueprint.PrimaryPart.CFrame
                    local sawmill = getBestSawmill()
                    if not sawmill then
                        notify("小星", "需要锯木机", 3)
                        return
                    end
                    
                    local fill_target_cframe = sawmill.Particles.CFrame + Vector3.new(0, 1, 0)
                    
                    local sawed = false
                    local sawConn = workspace.PlayerModels.ChildAdded:Connect(function(add)
                        local owner = add:WaitForChild('Owner')
                        if add.Owner.Value == lp and add:FindFirstChild("WoodSection") then
                            if not add:FindFirstChild('TreeClass') then
                                repeat wait() until add:FindFirstChild('TreeClass')
                            end
                            if add.TreeClass.Value == wood_class then
                                sawed = add
                                sawConn:Disconnect()
                            end
                        end
                    end)
                    
                    iterations = 0
                    while chopped and chopped.Parent ~= nil do
                        if sawed then break end
                        iterations = iterations + 1
                        if iterations > 300 then
                            notify("小星", "处理树失败", 3)
                            break
                        end
                        tp(CFrame.new(chopped.WoodSection.Position) + Vector3.new(0, 4, 0))
                        replicatedStorage.Interaction.ClientIsDragging:FireServer(chopped)
                        chopped.PrimaryPart = chopped.WoodSection
                        chopped:SetPrimaryPartCFrame(sawmill.Particles.CFrame)
                        replicatedStorage.Interaction.ClientIsDragging:FireServer(chopped)
                        wait(2)
                    end
                    
                    repeat wait() until sawed
                    
                    local placed = false
                    local structConn = workspace.PlayerModels.ChildAdded:Connect(function(child)
                        local owner = child:WaitForChild("Owner")
                        if owner.Value == lp and child:FindFirstChild("Type") and child.Type.Value == "Structure" then
                            if not child:FindFirstChild("BuildDependentWood") then
                                notify("小星", "填充失败", 3)
                                return
                            end
                            structConn:Disconnect()
                            local wood_type = child:FindFirstChild("BlueprintWoodClass") and child.BlueprintWoodClass.Value or nil
                            remote:FireServer(child.ItemName.Value, target_cframe, lp, wood_type, child, true, nil)
                            placed = true
                        end
                    end)
                    
                    iterations = 0
                    while sawed and sawed.Parent ~= nil do
                        if iterations > 50 then
                            replicatedStorage.Interaction.DestroyStructure:FireServer(sawed)
                            replicatedStorage.Interaction.DestroyStructure:FireServer(blueprint)
                            notify("小星", "尝试太多次", 3)
                            break
                        end
                        iterations = iterations + 1
                        if sawed.Parent == nil then break end
                        
                        local conn, bpMade
                        conn = workspace.PlayerModels.ChildAdded:Connect(function(child)
                            if child:WaitForChild("Owner") and child.Owner.Value == lp and
                                child:FindFirstChild("Type") and child.Type.Value == "Blueprint" then
                                conn:Disconnect()
                                blueprint = child
                                bpMade = true
                            end
                        end)
                        
                        replicatedStorage.PlaceStructure.ClientPlacedBlueprint:FireServer(bp_type,
                            sawed.WoodSection.CFrame, lp, blueprint, blueprint.Parent ~= nil)
                        
                        local waitIter = 0
                        repeat
                            if waitIter > 500 then
                                notify("小星", "没有找到蓝图", 3)
                                break
                            end
                            wait()
                            waitIter = waitIter + 1
                        until bpMade or placed
                        
                        if placed then
                            pcall(conn.Disconnect, conn)
                        end
                    end
                    
                    repeat wait() until placed
                    tp(oldpos)
                    notify("小星", "填充完成", 3)
                end
                
                lumbsmasher_legitpaint(bai.tchonmt, target.Parent)
            end
        end)
        tool.Parent = lp.Backpack
        notify("小星", "已获得填充工具", 3)
    end
})

fillTab:Button({
    Title = "填充所有蓝图",
    Callback = function()
        if not bai.tchonmt then
            notify("小星", "请选择木头类型", 3)
            return
        end
        for _, v in pairs(workspace.PlayerModels:GetChildren()) do
            if v:FindFirstChild("Type") and v.Type.Value == "Blueprint" and v:FindFirstChild("Owner") and v.Owner.Value == lp then
                local oldpos = lp.Character.HumanoidRootPart.CFrame
                local remote = replicatedStorage.PlaceStructure.ClientPlacedStructure
                local bp_type = v.ItemName.Value
                
                local wood = 1
                if lp.SuperBlueprint and lp.SuperBlueprint.Value then
                    wood = 1
                end
                
                local tool = barkgetBestAxe()
                if not tool then
                    notify("小星", "需要斧头", 3)
                    return
                end
                
                local required_wood = wood
                local woodSection = nil
                local minSize = 9e99
                
                for _, region in pairs(workspace:GetChildren()) do
                    if region.Name == 'TreeRegion' then
                        for _, tree in pairs(region:GetChildren()) do
                            if tree:FindFirstChild('Leaves') and tree:FindFirstChild('WoodSection') and
                                tree:FindFirstChild('TreeClass') and tree.TreeClass.Value == bai.tchonmt then
                                for _, section in pairs(tree:GetChildren()) do
                                    if section.Name == 'WoodSection' then
                                        local size = section.Size.X * section.Size.Y * section.Size.Z
                                        if size > required_wood and #section.ChildIDs:GetChildren() == 0 then
                                            if minSize > section.Size.X then
                                                minSize = section.Size.X
                                                woodSection = section
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                
                if not woodSection then
                    notify("小星", "没有找到树", 3)
                    return
                end
                
                local chopped = false
                local treeConn = workspace.LogModels.ChildAdded:Connect(function(add)
                    local owner = add:WaitForChild('Owner')
                    if add.Owner.Value == lp and add.TreeClass.Value == bai.tchonmt and add:FindFirstChild("WoodSection") then
                        chopped = add
                        treeConn:Disconnect()
                    end
                end)
                
                local cutSize = required_wood / (woodSection.Size.X * woodSection.Size.X) + 0.01
                local axeStats = getToolStats(tool)
                
                local function axeCut(evt, id, h)
                    replicatedStorage.Interaction.RemoteProxy:FireServer(evt, {
                        tool = tool,
                        faceVector = Vector3.new(0, 0, -1),
                        height = h,
                        sectionId = id,
                        hitPoints = axeStats.Damage,
                        cooldown = 0.112,
                        cuttingClass = "Axe"
                    })
                    wait()
                end
                
                local iterations = 0
                while not chopped do
                    iterations = iterations + 1
                    if iterations > 1000 then
                        replicatedStorage.Interaction.ClientIsDragging:FireServer(woodSection.Parent)
                        replicatedStorage.Interaction.DestroyStructure:FireServer(woodSection.Parent)
                        chopped = true
                    end
                    tp(woodSection.CFrame + Vector3.new(4, 2, 2))
                    axeCut(woodSection.Parent, woodSection.ID.Value, woodSection.Size.Y - cutSize)
                end
                
                local target_cframe = v.MainCFrame and v.MainCFrame.Value or v.PrimaryPart.CFrame
                local sawmill = getBestSawmill()
                if not sawmill then
                    notify("小星", "需要锯木机", 3)
                    return
                end
                
                local fill_target_cframe = sawmill.Particles.CFrame + Vector3.new(0, 1, 0)
                
                local sawed = false
                local sawConn = workspace.PlayerModels.ChildAdded:Connect(function(add)
                    local owner = add:WaitForChild('Owner')
                    if add.Owner.Value == lp and add:FindFirstChild("WoodSection") then
                        if not add:FindFirstChild('TreeClass') then
                            repeat wait() until add:FindFirstChild('TreeClass')
                        end
                        if add.TreeClass.Value == bai.tchonmt then
                            sawed = add
                            sawConn:Disconnect()
                        end
                    end
                end)
                
                iterations = 0
                while chopped and chopped.Parent ~= nil do
                    if sawed then break end
                    iterations = iterations + 1
                    if iterations > 300 then
                        notify("小星", "处理树失败", 3)
                        break
                    end
                    tp(CFrame.new(chopped.WoodSection.Position) + Vector3.new(0, 4, 0))
                    replicatedStorage.Interaction.ClientIsDragging:FireServer(chopped)
                    chopped.PrimaryPart = chopped.WoodSection
                    chopped:SetPrimaryPartCFrame(sawmill.Particles.CFrame)
                    replicatedStorage.Interaction.ClientIsDragging:FireServer(chopped)
                    wait(2)
                end
                
                repeat wait() until sawed
                
                local placed = false
                local structConn = workspace.PlayerModels.ChildAdded:Connect(function(child)
                    local owner = child:WaitForChild("Owner")
                    if owner.Value == lp and child:FindFirstChild("Type") and child.Type.Value == "Structure" then
                        if not child:FindFirstChild("BuildDependentWood") then
                            notify("小星", "填充失败", 3)
                            return
                        end
                        structConn:Disconnect()
                        local wood_type = child:FindFirstChild("BlueprintWoodClass") and child.BlueprintWoodClass.Value or nil
                        remote:FireServer(child.ItemName.Value, target_cframe, lp, wood_type, child, true, nil)
                        placed = true
                    end
                end)
                
                iterations = 0
                while sawed and sawed.Parent ~= nil do
                    if iterations > 50 then
                        replicatedStorage.Interaction.DestroyStructure:FireServer(sawed)
                        replicatedStorage.Interaction.DestroyStructure:FireServer(v)
                        notify("小星", "尝试太多次", 3)
                        break
                    end
                    iterations = iterations + 1
                    if sawed.Parent == nil then break end
                    
                    local conn, bpMade
                    conn = workspace.PlayerModels.ChildAdded:Connect(function(child)
                        if child:WaitForChild("Owner") and child.Owner.Value == lp and
                            child:FindFirstChild("Type") and child.Type.Value == "Blueprint" then
                            conn:Disconnect()
                            v = child
                            bpMade = true
                        end
                    end)
                    
                    replicatedStorage.PlaceStructure.ClientPlacedBlueprint:FireServer(bp_type,
                        sawed.WoodSection.CFrame, lp, v, v.Parent ~= nil)
                    
                    local waitIter = 0
                    repeat
                        if waitIter > 500 then
                            notify("小星", "没有找到蓝图", 3)
                            break
                        end
                        wait()
                        waitIter = waitIter + 1
                    until bpMade or placed
                    
                    if placed then
                        pcall(conn.Disconnect, conn)
                    end
                end
                
                repeat wait() until placed
                tp(oldpos)
                wait()
            end
        end
        notify("小星", "所有蓝图填充完成", 3)
    end
})

local transferTab = Window:Section({ Title = "传送物品", Opened = false })

transferTab:Dropdown({
    Title = "选择玩家",
    Values = bai.dropdown,
    Value = bai.dropdown[1] or "",
    Callback = function(v)
        bai.cswjia = v
    end
})

transferTab:Button({
    Title = "刷新列表",
    Callback = function()
        shuaxinlb(true)
        transferTab:SetOptions(bai.dropdown)
    end
})

transferTab:Button({
    Title = "设置传送点",
    Callback = function()
        pcall(function()
            workspace.baiBasedropCord:Destroy()
        end)
        local dropCord = Instance.new("Part", workspace)
        dropCord.CanCollide = false
        dropCord.Anchored = true
        dropCord.Shape = Enum.PartType.Ball
        dropCord.Color = Color3.fromRGB(0, 217, 255)
        dropCord.Transparency = 0
        dropCord.Size = Vector3.new(2, 2, 2)
        dropCord.CFrame = lp.Character.HumanoidRootPart.CFrame
        dropCord.Material = Enum.Material.Marble
        dropCord.Name = "baiBasedropCord"
        bai.itemset = lp.Character.HumanoidRootPart.CFrame
        notify("小星", "传送点已设置", 3)
    end
})

transferTab:Button({
    Title = "删除传送点",
    Callback = function()
        pcall(function()
            workspace.baiBasedropCord:Destroy()
            bai.itemset = nil
        end)
        notify("小星", "传送点已删除", 3)
    end
})

transferTab:Button({
    Title = "获取传送工具",
    Callback = function()
        if not bai.itemset then
            notify("小星", "请先设置传送点", 3)
            return
        end
        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "点击要传送的物品"
        tool.Activated:Connect(function()
            bai.cskais = true
            local target = mouse.Target.Parent
            local itemType = nil
            
            if target:FindFirstChild("PurchasedBoxItemName") then
                itemType = target.PurchasedBoxItemName.Value
            elseif target:FindFirstChild("ItemName") then
                itemType = target.ItemName.Value
            else
                notify("小星", "请点击一个物品", 3)
                return
            end
            
            for _, v in pairs(workspace.PlayerModels:GetChildren()) do
                local check = v:FindFirstChild('ItemName') or v:FindFirstChild('PurchasedBoxItemName')
                local check2 = v:FindFirstChild('Type')
                if bai.cskais then
                    if check and check.Value == itemType and v:FindFirstChild('Owner') and v.Owner.Value == game:GetService('Players'):FindFirstChild(bai.cswjia) then
                        local main = v:FindFirstChild('Main')
                        if main then
                            if (lp.Character.HumanoidRootPart.CFrame.p - main.CFrame.p).magnitude > 5 then
                                tp(v.Main.CFrame + Vector3.new(4, 0, 4))
                            end
                            for i = 1, 20 do
                                replicatedStorage.Interaction.ClientIsDragging:FireServer(v)
                                v.Main.CFrame = bai.itemset
                                replicatedStorage.Interaction.ClientIsDragging:FireServer(v)
                                wait()
                            end
                        end
                    end
                end
            end
            notify("小星", "传送完成", 3)
        end)
        tool.Parent = lp.Backpack
        notify("小星", "已获得传送工具", 3)
    end
})

transferTab:Button({
    Title = "停止传送",
    Callback = function()
        bai.cskais = false
    end
})

local carTab = Window:Section({ Title = "汽车", Opened = false })

carTab:Slider({
    Title = "汽车速度",
    Value = { Min = 3, Max = 600, Default = 3 },
    Callback = function(v)
        for _, model in pairs(workspace.PlayerModels:GetChildren()) do
            if model:FindFirstChild("Seat") and model:FindFirstChild("Configuration") then
                model.Configuration.MaxSpeed.Value = v
            end
        end
    end
})

carTab:Toggle({
    Title = "汽车穿墙",
    Default = false,
    Callback = function(v)
        local parts = {}
        if v then
            local seat = lp.Character:FindFirstChildOfClass('Humanoid').SeatPart
            if seat then
                local vehicle = seat.Parent
                while vehicle.ClassName ~= "Model" do
                    vehicle = vehicle.Parent
                end
                for _, part in pairs(vehicle:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        table.insert(parts, part)
                        part.CanCollide = false
                    end
                end
            end
        else
            for _, part in pairs(parts) do
                part.CanCollide = true
            end
            parts = {}
        end
    end
})

carTab:Button({
    Title = "汽车飞行(需先设置速度)",
    Callback = function()
        local speed = 100
        spawn(function()
            while wait() do
                pcall(function()
                    local hrp = lp.Character.HumanoidRootPart
                    hrp.Anchored = false
                    local bv = hrp:FindFirstChildOfClass("BodyVelocity")
                    local bg = hrp:FindFirstChildOfClass("BodyGyro")
                    if not bv then
                        bv = Instance.new("BodyVelocity", hrp)
                        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    end
                    if not bg then
                        bg = Instance.new("BodyGyro", hrp)
                        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                        bg.D = 5000
                        bg.P = 50000
                    end
                    bg.CFrame = workspace.CurrentCamera.CFrame
                    bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * speed
                end)
            end
        end)
    end
})

carTab:Button({
    Title = "获取选车工具",
    Callback = function()
        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "点击汽车重生垫"
        tool.Activated:Connect(function()
            local target = mouse.Target
            if target and target.Parent.Type and target.Parent.Type.Value == "Vehicle Spot" then
                if not target.Parent:FindFirstChild("SelectionBox") then
                    bai.car = target.Parent:FindFirstChild("ButtonRemote_SpawnButton", true)
                    local sb = Instance.new("SelectionBox", target.Parent)
                    sb.Adornee = target.Parent
                    notify("小星", "汽车已选择", 3)
                else
                    target.Parent.SelectionBox:Destroy()
                    bai.car = nil
                end
            end
        end)
        tool.Parent = lp.Backpack
        notify("小星", "已获得选车工具", 3)
    end
})

carTab:Button({
    Title = "刷粉车",
    Callback = function()
        if not bai.car then
            notify("小星", "请先选择汽车", 3)
            return
        end
        bai.stopcar = false
        local conn = workspace.PlayerModels.ChildAdded:Connect(function(child)
            child:WaitForChild("Owner")
            if child:WaitForChild("PaintParts") then
                local part = child.PaintParts.Part
                spawn(function()
                    while not bai.stopcar and part and part.BrickColor.Name ~= "Hot pink" do
                        Press(bai.car)
                        wait(0.45)
                    end
                end)
            end
        end)
        wait(10)
        conn:Disconnect()
    end
})

carTab:Button({
    Title = "停止刷车",
    Callback = function()
        bai.stopcar = true
        bai.car = nil
        for _, v in pairs(workspace.PlayerModels:GetChildren()) do
            if v:FindFirstChild("SelectionBox") and v:FindFirstChild("ButtonRemote_SpawnButton", true) then
                v.SelectionBox:Destroy()
            end
        end
    end
})

local carTpTab = Window:Section({ Title = "汽车传送", Opened = false })

carTpTab:Dropdown({
    Title = "传送位置",
    Values = tpLocations,
    Value = "出生点",
    Callback = function(v)
        if v == '回家' then
            for _, prop in pairs(workspace.Properties:GetChildren()) do
                if prop.Owner.Value == lp then
                    carTeleport(prop.OriginSquare.CFrame + Vector3.new(0, 10, 0))
                end
            end
        elseif tpCoords[v] then
            carTeleport(tpCoords[v])
        end
    end
})

local baseTab = Window:Section({ Title = "基地", Opened = false })

baseTab:Button({
    Title = "免费土地",
    Callback = function()
        for _, prop in pairs(workspace.Properties:GetChildren()) do
            if prop:FindFirstChild("Owner") and prop.Owner.Value == nil then
                replicatedStorage.PropertyPurchasing.ClientPurchasedProperty:FireServer(prop,
                    prop.OriginSquare.OriginCFrame.Value.p + Vector3.new(0, 3, 0))
                wait(0.5)
                for _, v in pairs(workspace.Properties:GetChildren()) do
                    if v.Owner.Value == lp then
                        tp(v.OriginSquare.CFrame + Vector3.new(0, 10, 0))
                    end
                end
            end
        end
    end
})

baseTab:Button({
    Title = "最大土地",
    Callback = function()
        local base = nil
        local square = nil
        for _, v in pairs(workspace.Properties:GetChildren()) do
            if v:FindFirstChild("Owner") and v.Owner.Value == lp then
                base = v
                square = v.OriginSquare
                break
            end
        end
        if not base then
            notify("小星", "没有找到基地", 3)
            return
        end
        
        local function makebase(pos)
            replicatedStorage.PropertyPurchasing.ClientExpandedProperty:FireServer(base, pos)
        end
        
        local spos = square.Position
        makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z))
        makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z))
        makebase(CFrame.new(spos.X, spos.Y, spos.Z + 40))
        makebase(CFrame.new(spos.X, spos.Y, spos.Z - 40))
        makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z + 40))
        makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z - 40))
        makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z + 40))
        makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z - 40))
        makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z))
        makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z))
        makebase(CFrame.new(spos.X, spos.Y, spos.Z + 80))
        makebase(CFrame.new(spos.X, spos.Y, spos.Z - 80))
        makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z + 80))
        makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z - 80))
        makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z + 80))
        makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z - 80))
        makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z + 80))
        makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z + 80))
        makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z + 40))
        makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z - 40))
        makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z + 40))
        makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z - 40))
        makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z - 80))
        makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z - 80))
        notify("小星", "土地扩展完成", 3)
    end
})

baseTab:Textbox({
    Title = "存档编号(1-6)",
    Value = "1",
    PlaceholderText = "输入数字",
    Callback = function(v)
        bai.soltnumber = v
    end
})

baseTab:Button({
    Title = "加载存档",
    Callback = function()
        local slot = CheckSlotNumber()
        if not slot then
            notify("小星", "请输入有效存档号(1-6)", 3)
            return
        end
        if CheckIfSlotAvailable(slot) then
            LoadSlot(slot)
            notify("小星", "加载中...", 3)
        else
            notify("小星", "存档不可用", 3)
        end
    end
})

baseTab:Button({
    Title = "一键复制",
    Callback = function()
        local slot = CheckSlotNumber()
        if not slot then
            notify("小星", "请输入有效存档号(1-6)", 3)
            return
        end
        local conn = workspace.PlayerModels.ChildAdded:Connect(function()
            wait()
            game:Shutdown()
        end)
        LoadSlot(slot)
    end
})

local funTab = Window:Section({ Title = "娱乐", Opened = false })

funTab:Button({
    Title = "可口可乐",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/BEgB0gEJ', true))()
    end
})

funTab:Button({
    Title = "变警察",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/8wB54iNk', true))()
    end
})

funTab:Button({
    Title = "悬浮板",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/MrfVCM9y', true))()
    end
})

funTab:Button({
    Title = "托马斯小火车",
    Callback = function()
        loadstring(game:HttpGet('http://pastebin.com/raw/tMr759X7', true))()
    end
})

funTab:Button({
    Title = "圆球",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/ZFSTSi9B', true))()
    end
})

funTab:Button({
    Title = "喷漆",
    Callback = function()
        loadstring(game:HttpGet('http://pastebin.com/raw/raYkCjyy', true))()
    end
})

local shortcutTab = Window:Section({ Title = "捷径", Opened = false })

shortcutTab:Button({
    Title = "上火山捷径",
    Callback = function()
        local model = Instance.new("Model", workspace)
        model.Name = "Lumber"
        
        local part1 = Instance.new("Part", model)
        part1.Name = "Bridge"
        part1.Anchored = true
        part1.BrickColor = BrickColor.new("Medium green")
        part1.Material = Enum.Material.Fabric
        part1.Position = Vector3.new(4380.809, -11.75, -101.56)
        part1.Size = Vector3.new(254.86, 0.1, 1012.02)
        
        local part2 = Instance.new("Part", model)
        part2.Name = "RoadVol"
        part2.Anchored = true
        part2.BrickColor = BrickColor.new("Medium green")
        part2.Material = Enum.Material.Fabric
        part2.Position = Vector3.new(-604.036, 301.072, 637.691)
        part2.Size = Vector3.new(40, 0.2, 2030.83)
        part2.Rotation = Vector3.new(147.75, 55.68, -152.47)
        
        local wedge1 = Instance.new("WedgePart", model)
        wedge1.Name = "Vol1"
        wedge1.Anchored = true
        wedge1.BrickColor = BrickColor.new("Medium green")
        wedge1.Material = Enum.Material.Fabric
        wedge1.Position = Vector3.new(-1133.531, 499.677, 943.492)
        wedge1.Size = Vector3.new(39.73, 10.65, 823.29)
        wedge1.Rotation = Vector3.new(-32.25, -55.68, -27.53)
        
        local wedge2 = Instance.new("WedgePart", model)
        wedge2.Name = "Vol2"
        wedge2.Anchored = true
        wedge2.BrickColor = BrickColor.new("Medium green")
        wedge2.Material = Enum.Material.Fabric
        wedge2.Position = Vector3.new(-1526.918, 623.235, 1112.269)
        wedge2.Size = Vector3.new(33.96, 10.47, 43.56)
        wedge2.Rotation = Vector3.new(0, 32.9, 0)
        
        notify("小星", "火山捷径已生成", 3)
    end
})

shortcutTab:Button({
    Title = "椰子岛捷径",
    Callback = function()
        local part = Instance.new("Part", workspace)
        part.Name = "Palm Island Bridge"
        part.Position = Vector3.new(1753.475, -10, -45.351)
        part.Size = Vector3.new(1600, 1, 50)
        part.BrickColor = BrickColor.Random()
        part.Anchored = true
        part.CanCollide = true
        notify("小星", "椰子岛捷径已生成", 3)
    end
})

shortcutTab:Button({
    Title = "沼泽捷径",
    Callback = function()
        local part1 = Instance.new("Part", workspace)
        part1.CFrame = CFrame.new(-499.196, 155.461, -166.186)
        part1.Size = Vector3.new(295.87, 1, 40.14)
        part1.BrickColor = BrickColor.new(255, 255, 255)
        part1.Material = Enum.Material.DiamondPlate
        part1.Anchored = true
        
        local part2 = Instance.new("Part", workspace)
        part2.CFrame = CFrame.new(-53.548, 75.873, -166.036) * CFrame.Angles(0, 0, math.rad(-15))
        part2.Size = Vector3.new(617.23, 0.72, 40)
        part2.BrickColor = BrickColor.new(255, 255, 255)
        part2.Material = Enum.Material.DiamondPlate
        part2.Anchored = true
        notify("小星", "沼泽捷径已生成", 3)
    end
})

shortcutTab:Button({
    Title = "黄金木捷径",
    Callback = function()
        local folder = Instance.new("Folder", workspace)
        folder.Name = "SGlowPath"
        
        local positions = {
            {8.542, -0.915, -812.122, 55, 1, 186},
            {-309.958, -0.834, -879.710, 582, 1, 50},
            {-606.631, -0.843, -748.689, 47, 1, 246, 0, -15, 0},
            {-763.459, -0.724, -652.320, 227, 1, 38},
            {-842.990, -0.603, -713.691, 43, 1, 108, 0, -15, 0},
            {-775.693, -0.588, -815.869, 42, 1, 170, 0, -45, 0},
            {-728.160, -0.591, -952.044, 55, 1, 182},
            {-864.099, -0.257, -985.877, 235, 1, 56, 0, 15, 0},
            {-1015.873, -11.129, -945.633, 82, 1, 55, 0.03, 14.48, 15.51}
        }
        
        for _, pos in pairs(positions) do
            local part = Instance.new("Part", folder)
            part.CFrame = CFrame.new(pos[1], pos[2], pos[3])
            part.Size = Vector3.new(pos[4], pos[5], pos[6])
            if pos[7] then
                part.Rotation = Vector3.new(pos[7], pos[8], pos[9])
            end
            part.BrickColor = BrickColor.new(255, 255, 255)
            part.Material = Enum.Material.DiamondPlate
            part.Anchored = true
        end
        notify("小星", "黄金木捷径已生成", 3)
    end
})

shortcutTab:Button({
    Title = "冰木捷径",
    Callback = function()
        local folder = Instance.new("Folder", workspace)
        folder.Name = "FrostPath"
        
        local positions = {
            {744.517, 71.578, 861.148, 40, 1, 202, -15, 0, 0},
            {744.273, 97.534, 1003.82, 41, 1, 90},
            {775.181, 100.246, 1027.583, 46, 1, 43, 0, 0, 15},
            {815.777, 106.550, 1027.403, 38, 1, 42},
            {815.850, 257.424, 1608.795, 38, 1, 1164, -15, 0, 0},
            {900.612, 407.760, 2194.724, 208, 1, 50},
            {1268.406, 407.261, 2798.836, 41, 2, 1364, 0, 24, 0}
        }
        
        for _, pos in pairs(positions) do
            local part = Instance.new("Part", folder)
            part.CFrame = CFrame.new(pos[1], pos[2], pos[3])
            part.Size = Vector3.new(pos[4], pos[5], pos[6])
            if pos[7] then
                part.Rotation = Vector3.new(pos[7], pos[8], pos[9])
            end
            part.BrickColor = BrickColor.new(255, 255, 255)
            part.Material = Enum.Material.DiamondPlate
            part.Anchored = true
        end
        notify("小星", "冰木捷径已生成", 3)
    end
})

shortcutTab:Button({
    Title = "幻影捷径",
    Callback = function()
        local part = Instance.new("Part", workspace)
        part.Name = "Lone Cave Bridge"
        part.Position = Vector3.new(-5.915, -217, -1250.256)
        part.Size = Vector3.new(1207.06, 1, 1160.09)
        part.BrickColor = BrickColor.Random()
        part.Anchored = true
        part.CanCollide = true
        notify("小星", "幻影捷径已生成", 3)
    end
})

shortcutTab:Button({
    Title = "删除灵视神殿石头",
    Callback = function()
        pcall(function()
            workspace.Region_Mountainside.BoulderRegen.Boulder:Destroy()
            workspace.Region_Mountainside.Door.Door:Destroy()
        end)
        notify("小星", "已删除", 3)
    end
})

shortcutTab:Button({
    Title = "关/开家具店门",
    Callback = function()
        pcall(function()
            replicatedStorage.Interaction.RemoteProxy:FireServer(workspace.Stores.FurnitureStore.LDoor.ButtonRemote_Toggle)
            wait(0.5)
            replicatedStorage.Interaction.RemoteProxy:FireServer(workspace.Stores.FurnitureStore.RDoor.ButtonRemote_Toggle)
        end)
    end
})

shortcutTab:Button({
    Title = "关/开逻辑店门",
    Callback = function()
        pcall(function()
            replicatedStorage.Interaction.RemoteProxy:FireServer(workspace.Stores.LogicStore.LDoor.ButtonRemote_Toggle)
            wait(0.5)
            replicatedStorage.Interaction.RemoteProxy:FireServer(workspace.Stores.LogicStore.RDoor.ButtonRemote_Toggle)
        end)
    end
})

shortcutTab:Button({
    Title = "关/开车行门",
    Callback = function()
        pcall(function()
            replicatedStorage.Interaction.RemoteProxy:FireServer(workspace.Stores.CarStore.LDoor.ButtonRemote_Toggle)
            wait(0.5)
            replicatedStorage.Interaction.RemoteProxy:FireServer(workspace.Stores.CarStore.RDoor.ButtonRemote_Toggle)
        end)
    end
})

shortcutTab:Button({
    Title = "打开鲨鱼斧门",
    Callback = function()
        pcall(function()
            replicatedStorage.Interaction.RemoteProxy:FireServer(workspace.Region_Snow.Den.Hatch.ButtonRemote_Hinge)
        end)
    end
})

shortcutTab:Button({
    Title = "删除鲨鱼斧门",
    Callback = function()
        pcall(function()
            workspace.Region_Snow.Den.Hatch:Destroy()
        end)
    end
})

shortcutTab:Button({
    Title = "带来沼泽桥",
    Callback = function()
        local oldPos = lp.Character.HumanoidRootPart.CFrame
        local slab = workspace.Region_Mountainside.SlabRegen:FindFirstChild('Slab')
        if slab then
            if not slab.PrimaryPart then
                slab.PrimaryPart = slab.PushMe
            end
            tp(CFrame.new(slab.PrimaryPart.CFrame.p))
            wait(.2)
            spawn(function()
                for i = 1, 100 do
                    slab:SetPrimaryPartCFrame(CFrame.new(oldPos.p))
                    replicatedStorage.Interaction.ClientIsDragging:FireServer(slab)
                    wait()
                end
            end)
            wait(1)
            tp(CFrame.new(oldPos.p))
            notify("小星", "桥已带来", 3)
        end
    end
})