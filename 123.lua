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
    Title = "小星--伐木大亨2",
    Icon = "rbxassetid://18941716391",
    IconThemed = true,
    Author = "<font color='#00FFFF'>作者: 小星</font>",
    Folder = "星脚本",
    Size = UDim2.fromOffset(370, 450),
    Transparent = true,
    Theme = "Dark",
    BackgroundImageTransparency = 0.4,
    User = { Enabled = true, Anonymous = true },
    SideBarWidth = 200,
    HideSearchBar = false,
    ScrollBarEnabled = true,
})

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local mouse = lp:GetMouse()
local a = game:GetService("Workspace")
local b = game:GetService("ReplicatedStorage")
local c = game:GetService("Players").LocalPlayer

local bai = {
    axedupe = false,
    soltnumber = "1",
    waterwalk = false,
    awaysday = false,
    awaysdnight = false,
    nofog = false,
    axeflying = false,
    playernamedied = "",
    tptree = "",
    moneyaoumt = 1,
    moneytoplayername = "",
    donationRecipient = tostring(game.Players.LocalPlayer),
    autodropae = false,
    farAxeEquip = nil,
    cuttreeselect = "Generic",
    autofarm = false,
    PlankToBlueprint = nil,
    plankModel = nil,
    blueprintModel = nil,
    saymege = "",
    autosay = false,
    saymount = 1,
    sayfast = false,
    autofarm1 = false,
    bringamount = 1,
    bringtree = false,
    dxmz = "",
    color = 0,
    0,
    0,
    zlwjia = "",
    mtwjia = nil,
    zix = 1,
    zlz = 3,
    axeFling = nil,
    itemtoopen = "",
    openItem = nil,
    car = nil,
    load = false,
    autobuyamount = 1,
    autopick = false,
    loaddupeaxewaittime = 3.1,
    walkspeed = 16,
    JumpPower = 50,
    pickupaxeamount = 1,
    whthmose = false,
    itemset = nil,
    LoneCaveAxeDetection = nil,
    cuttree = false,
    LoneCaveCharacterAddedDetection = nil,
    LoneCaveDeathDetection = nil,
    lovecavecutcframe = nil,
    lovecavepast = nil,
    zlmt = nil,
    shuzhe = false,
    modwood = false,
    tchonmt = nil,
    cskais = false,
    dledetree = false,
    delereeset = nil,
    treecutset = nil,
    autobuyset = nil,
    wood = 7,
    cswjia = nil,
    boxOpenConnection = nil,
    autobuystop = false,
    dropdown = {},
    autocsdx = nil,
    kuangxiu = nil,
    xzemuban = false,
    daiwp = false,
    stopcar = false,
    buyitem = "Button0"
}

local function notify(title, text, duration)
    duration = duration or 4
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = tostring(title or "提示"),
        Text = tostring(text or ""),
        Duration = duration,
    })
end

local function tp(pos)
    if typeof(pos) == "CFrame" then
        lp.Character:SetPrimaryPartCFrame(pos)
    elseif typeof(pos) == "Vector3" then
        lp.Character:MoveTo(pos)
    end
end

local function droptool(Position)
    local aQ = game.Players.LocalPlayer.Character
    if aQ:FindFirstChildOfClass("Tool") then
        local y = aQ:FindFirstChildOfClass("Tool")
        if y:FindFirstChild("ToolName") then
            game.ReplicatedStorage.Interaction.ClientInteracted:FireServer(b, "Drop tool", Position or game.Players.LocalPlayer.Character.Head.CFrame)
        end
    end
    for a, b in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if b.Name == "Tool" and b.ClassName == "Tool" then
            game.ReplicatedStorage.Interaction.ClientInteracted:FireServer(b, "Drop tool", Position or game.Players.LocalPlayer.Character.Head.CFrame)
        end
    end
end

local function getTieredAxe()
    return {
        ['Beesaxe'] = 13,
        ['AxeAmber'] = 12,
        ['ManyAxe'] = 15,
        ['BasicHatchet'] = 0,
        ['RustyAxe'] = -1,
        ['Axe1'] = 2,
        ['Axe2'] = 3,
        ['AxeAlphaTesters'] = 9,
        ['Rukiryaxe'] = 8,
        ['Axe3'] = 4,
        ['AxeBetaTesters'] = 10,
        ['FireAxe'] = 11,
        ['SilverAxe'] = 5,
        ['EndTimesAxe'] = 16,
        ['AxeChicken'] = 6,
        ['CandyCaneAxe'] = 1,
        ['AxeTwitter'] = 7,
        ['CandyCornAxe'] = 14
    }
end

local function getAxeList()
    local aP = {}
    for J, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        table.insert(aP, v)
    end
    local aQ = game.Players.LocalPlayer.Character
    if aQ:FindFirstChildOfClass("Tool") then
        table.insert(aP, aQ:FindFirstChildOfClass("Tool"))
    end
    return aP
end

local function barkgetBestAxe()
    local aQ = game.Players.LocalPlayer.Character
    if aQ:FindFirstChildOfClass("Tool") then
        local y = aQ:FindFirstChildOfClass("Tool")
        if y:FindFirstChild("ToolName") then
            return y
        end
    end
    local aU = -1
    local aV = nil
    local aT = getTieredAxe()
    for J, v in pairs(getAxeList()) do
        if v:FindFirstChild("ToolName") then
            if aT[v.ToolName.Value] > aU then
                aV = v
                aU = aT[v.ToolName.Value]
            end
        end
    end
    return aV
end

local function barkgetBestAxe2()
    local pc = game.Players.LocalPlayer.Character
    local axe_damage
    local best_axe
    for i, v in pairs(getAxeList()) do
        if v.name == "Tool" then
            local damage = get_axe_damage(v, "Generic")
            if best_axe == nil then
                best_axe = v
                axe_damage = damage
            elseif get_axe_damage(best_axe, "Generic") < damage then
                best_axe = v
                axe_damage = damage
            end
        end
    end
    return best_axe
end

function get_axe_damage(tool, tree)
    local axe_class = require(game.ReplicatedStorage.AxeClasses['AxeClass_' .. tool.ToolName.Value])
    local axe_table = axe_class.new()
    if axe_table["SpecialTrees"] then
        if axe_table["SpecialTrees"][tree] then
            return axe_table["SpecialTrees"][tree].Damage
        else
            return axe_table.Damage
        end
    else
        return axe_table.Damage
    end
end

function get_axe_cooldown(tool)
    local success, return_value = pcall(function()
        local axe_class = require(game.ReplicatedStorage.AxeClasses['AxeClass_' .. tool.ToolName.Value])
        local axe_table = axe_class.new()
        return axe_table.SwingCooldown
    end)
    if success then
        return return_value
    else
        warn("ERROR WHILE REQUIRING MODULE: " .. return_value)
        return 1
    end
end

function get_axe_swingdelay(tool)
    local axe_cooldown = get_axe_cooldown(tool)
    local start = tick()
    game.ReplicatedStorage.TestPing:InvokeServer()
    local ping = (tick() - start) / 2
    local swing_delay = 0.65 * axe_cooldown - ping
    return swing_delay
end

local function getToolStats(toolName)
    if typeof(toolName) ~= "string" then
        toolName = toolName.ToolName.Value
    end
    return require(game:GetService("ReplicatedStorage").AxeClasses['AxeClass_' .. toolName]).new()
end

local function getBestAxe(treeClass)
    local tools = {}
    lp.Character.Humanoid:UnequipTools()
    for _, v in pairs(lp.Backpack:GetChildren()) do
        if v.Name ~= "BlueprintTool" then
            table.insert(tools, v)
        end
    end
    if #tools == 0 then
        notify("小星", "你需要斧头", 4)
        return nil
    end
    local toolStats = {}
    local tool
    for _, v in next, tools do
        if treeClass == "LoneCave" and v.ToolName.Value == "EndTimesAxe" then
            tool = v
            break
        end
        local axeStats = getToolStats(v)
        if axeStats.SpecialTrees and axeStats.SpecialTrees[treeClass] then
            for i, v in next, axeStats.SpecialTrees[treeClass] do
                axeStats[i] = v
            end
        end
        table.insert(toolStats, {
            tool = v,
            damage = axeStats.Damage
        })
    end
    if not tool and treeClass == "LoneCave" then
        notify("小星", "你需要末日斧头", 4)
        return nil
    end
    table.sort(toolStats, function(a, b)
        return a.damage > b.damage
    end)
    return true, tool or toolStats[1].tool
end

local function cutPart(event, section, height, tool, treeClass)
    local axeStats = getToolStats(tool)
    if axeStats.SpecialTrees and axeStats.SpecialTrees[treeClass] then
        for i, v in next, axeStats.SpecialTrees[treeClass] do
            axeStats[i] = v
        end
    end
    game:GetService('ReplicatedStorage').Interaction.RemoteProxy:FireServer(event, {
        tool = tool,
        faceVector = Vector3.new(-1, 0, 0),
        height = height or 0.3,
        sectionId = section or 1,
        hitPoints = axeStats.Damage,
        cooldown = axeStats.SwingCooldown,
        cuttingClass = "Axe"
    })
end

local function getBiggestTree(treeClass)
    for _, v in next, workspace:children() do
        if tostring(v) == "TreeRegion" then
            for _, g in next, v:children() do
                if g:FindFirstChild("TreeClass") and tostring(g.TreeClass.Value) == treeClass and g:FindFirstChild("Owner") then
                    if g.Owner.Value == nil or tostring(g.Owner.Value) == tostring(game.Players.LocalPlayer) then
                        if #g:children() > 5 and g:FindFirstChild("WoodSection") then
                            for h, j in next, g:children() do
                                if j:FindFirstChild("ID") and j.ID.Value == 1 and j.Size.Y > .5 then
                                    return j
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

local function bringTree(treeClass)
    local success, data = getBestAxe(treeClass)
    if not success then return end
    local treeCut = false
    local childAdded = workspace.LogModels.ChildAdded:Connect(function(child)
        local owner = child:WaitForChild("Owner")
        if owner.Value == lp and child.TreeClass.Value == treeClass then
            childAdded:Disconnect()
            child.PrimaryPart = child:FindFirstChild("WoodSection")
            treeCut = true
            task.spawn(function()
                for i = 1, 60 do
                    game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(child)
                    game["Run Service"].Heartbeat:wait()
                end
            end)
            task.wait(0.1)
            child.PrimaryPart = child.WoodSection
            spawn(function()
                for i = 1, 60 do
                    child.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
                    child:PivotTo(bai.treecutset)
                    game["Run Service"].Heartbeat:wait()
                end
            end)
            wait(0.5)
            if treeClass == "LoneCave" then
                lp.Character.Head:Destroy()
                lp.CharacterAdded:Wait()
                wait(2)
            end
            tp(bai.treecutset)
        end
    end)
    if treeClass == "LoneCave" then
        local GM = game.Players.LocalPlayer.Character.HumanoidRootPart.RootJoint
        GM:Clone().Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
        GM:Destroy()
    end
    local tree = getBiggestTree(treeClass)
    if not tree then
        notify("小星", "没有找到树", 3)
        return
    end
    spawn(function()
        repeat
            tp(tree.CFrame + Vector3.new(3, 3, 0))
            cutPart(tree.Parent.CutEvent, 1, 0.3, data, treeClass)
            game["Run Service"].Heartbeat:wait()
        until treeCut
    end)
end

local function autofarm(treeClass)
    local oldpos = lp.Character.HumanoidRootPart.CFrame
    local success, data = getBestAxe(treeClass)
    if not success then return end
    local tree = getBiggestTree(treeClass)
    if not tree then
        notify("小星", "没有找到树", 3)
        return
    end
    local treeCut = false
    local childAdded = workspace.LogModels.ChildAdded:Connect(function(child)
        local owner = child:WaitForChild("Owner")
        if owner.Value == lp and child.TreeClass.Value == treeClass then
            childAdded:Disconnect()
            child.PrimaryPart = child:FindFirstChild("WoodSection")
            treeCut = true
            for i = 1, 70 do
                game:GetService('ReplicatedStorage').Interaction.ClientIsDragging:FireServer(child.WoodSection)
                child:MoveTo(oldpos)
                task.wait()
            end
        end
    end)
    task.wait(0.15)
    task.spawn(function()
        repeat
            tp(tree.trunk.CFrame * CFrame.new(4, 3, 4))
            task.wait()
        until treeCut
    end)
    task.wait()
    repeat
        cutPart(tree.tree.CutEvent, 1, 0.3, data, treeClass)
        task.wait(0.1)
    until treeCut
    if bai.autofarm1 == false then
        notify("小星", "完成", 3)
    end
    tp(oldpos)
end

local function sellwood()
    local oldpos = lp.Character.HumanoidRootPart.CFrame
    for i, v in next, game:GetService("Workspace").LogModels:GetChildren() do
        if v:FindFirstChild("Owner") and v.Owner.Value == game.Players.LocalPlayer then
            tp(v.WoodSection.CFrame)
            spawn(function()
                for i2, v2 in next, v:GetChildren() do
                    if v2.Name == "WoodSection" then
                        local FreezeWood = Instance.new("BodyVelocity", v2)
                        FreezeWood.Velocity = Vector3.new(0, 0, 0)
                        FreezeWood.P = 100000
                        spawn(function()
                            for i = 1, 50 do
                                game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(v)
                                v:PivotTo(CFrame.new(314.54, -0.5, 86.823))
                                v2.CFrame = CFrame.new(314.54, -0.5, 86.823)
                                game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(v)
                                game:GetService('RunService').Heartbeat:wait()
                            end
                        end)
                        task.wait(1)
                    end
                end
            end)
            task.wait(2)
        end
    end
    tp(oldpos)
end

local function getPlanks()
    local plankList = {}
    for _, plank in next, game:GetService('Workspace').PlayerModels:children() do
        if plank:FindFirstChild('WoodSection') and plank:FindFirstChild('Owner') and plank.Owner.Value == game:GetService('Players').LocalPlayer and not table.find(plankList, plank) then
            table.insert(plankList, plank)
        end
    end
    return plankList
end

local function lowerBridge(value)
    if value == 'Higher' then
        for _, v in pairs(game.workspace.Bridge.VerticalLiftBridge.Lift:GetChildren()) do
            v.CFrame = v.CFrame + Vector3.new(0, 26, 0)
        end
    elseif value == 'Lower' then
        for _, v in pairs(game.workspace.Bridge.VerticalLiftBridge.Lift:GetChildren()) do
            v.CFrame = v.CFrame + Vector3.new(0, -26, 0)
        end
    end
end

local function OpenSelectedItem(item)
    local itemBox = item:FindFirstChild('BoxItemName') or item:FindFirstChild('PurchasedBoxItemName')
    if itemBox and item:FindFirstChild('Type') and item.Type.Value ~= 'Structure' then
        game:GetService('ReplicatedStorage').Interaction.ClientInteracted:FireServer(item, 'Open box')
        notify('小星', '成功打开', 4)
    end
end

local function OwnerCheck(item)
    if item:FindFirstChild('Owner') then
        return tostring(item.Owner.Value)
    end
end

local function WhitelistCheck(player)
    return game:GetService('ReplicatedStorage').Interaction.ClientIsWhitelisted:InvokeServer(player) == true
end

local function farAxeEquip()
    local done = false
    if bai.farAxeEquip == nil then
        notify('小星', '选择一把斧头', 4)
        bai.farAxeEquip = mouse.Button1Down:connect(function()
            local target = mouse.Target
            if target.Parent:IsA('Model') and target.Parent:FindFirstChild('ToolName') then
                if OwnerCheck(target.Parent) == tostring(lp) or WhitelistCheck(target.Parent.Owner.Value) then
                    game:GetService('ReplicatedStorage').Interaction.ClientInteracted:FireServer(target.Parent, 'Pick up tool')
                    done = true
                end
            end
        end)
        repeat
            wait()
        until done
        notify('小星', '已装备', 4)
        if bai.farAxeEquip then
            bai.farAxeEquip:Disconnect()
            bai.farAxeEquip = nil
        end
    else
        notify('错误', '已经激活', 4)
    end
end

local function applyLight(value)
    if value then
        local light = Instance.new('PointLight', lp.Character.Head)
        light.Name = 'bai'
        light.Range = 150
        light.Brightness = 1.7
    else
        pcall(function()
            lp.Character.Head.bai:remove()
        end)
    end
end

local function carTeleport(cframe)
    if game.Players.LocalPlayer.Character then
        Character = game.Players.LocalPlayer.Character
        if Character.Humanoid.SeatPart ~= nil then
            Car = Character.Humanoid.SeatPart.Parent
            spawn(function()
                for i = 1, 5 do
                    wait()
                    Car:SetPrimaryPartCFrame(cframe * CFrame.Angles(math.rad(Character.HumanoidRootPart.Orientation.x), math.rad(Character.HumanoidRootPart.Orientation.y), 0))
                    game.ReplicatedStorage.Interaction.ClientRequestOwnership:FireServer(Car.Main)
                    game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(Car.Main)
                end
            end)
        end
    end
end

local function CheckIfSlotAvailable(Slot)
    for a, b in pairs(game.ReplicatedStorage.LoadSaveRequests.GetMetaData:InvokeServer(game.Players.LocalPlayer)) do
        if a == Slot then
            for c, d in pairs(b) do
                if c == "NumSaves" and d ~= 0 then
                    return true
                else
                    return false
                end
            end
        end
    end
end

local function CheckSlotNumber()
    if bai.soltnumber == "1" or bai.soltnumber == "2" or bai.soltnumber == "3" or bai.soltnumber == "4" or bai.soltnumber == "5" or bai.soltnumber == "6" then
        local SlotNumber = tonumber(bai.soltnumber)
        return SlotNumber
    else
        return false
    end
end

function CanClientLoad()
    if not game:GetService("ReplicatedStorage").LoadSaveRequests.ClientMayLoad:InvokeServer(lp) then
        notify("小星", "等待加载时间,请耐心的等待", 4)
        repeat
            game:GetService("RunService").Stepped:wait()
        until game:GetService("ReplicatedStorage").LoadSaveRequests.ClientMayLoad:InvokeServer(lp)
    end
    return true
end

function GetLoadedSlot()
    return lp.CurrentSaveSlot.Value
end

function LoadSlot(slot)
    local CheckLoad
    spawn(function()
        CheckLoad = game:GetService('ReplicatedStorage').LoadSaveRequests.ClientMayLoad:InvokeServer(lp)
        if not CheckLoad then
            repeat
                wait()
            until CheckLoad
        end
        game:GetService('ReplicatedStorage').LoadSaveRequests.RequestLoad:InvokeServer(slot, lp)
        return slot
    end)
end

function Teleport(d)
    for e = 1, 3 do
        task.wait()
        c.Character.HumanoidRootPart.CFrame = d
    end
    return d
end

GetShopID = {
    ["WoodRus"] = {
        ["Character"] = a.Stores.WoodRUs.Thom,
        ["Name"] = "Thom",
        ["ID"] = tonumber(7)
    },
    ["FurnitureStore"] = {
        ["Character"] = a.Stores.FurnitureStore.Corey,
        ["Name"] = "Corey",
        ["ID"] = tonumber(8)
    },
    ["CarStore"] = {
        ["Character"] = a.Stores.CarStore.Jenny,
        ["Name"] = "Jenny",
        ["ID"] = tonumber(9)
    },
    ["ShackShop"] = {
        ["Character"] = a.Stores.ShackShop.Bob,
        ["Name"] = "Bob",
        ["ID"] = tonumber(10)
    },
    ["FineArt"] = {
        ["Character"] = a.Stores.FineArt.Timothy,
        ["Name"] = "Timothy",
        ["ID"] = tonumber(11)
    },
    ["LogicStore"] = {
        ["Character"] = a.Stores.LogicStore.Lincoln,
        ["Name"] = "Lincoln",
        ["ID"] = tonumber(12)
    }
}

BuyItem = function(m)
    return b.NPCDialog.PlayerChatted:InvokeServer(m, "ConfirmPurchase")
end

function finditem(o)
    for e, h in next, a.Stores:children() do
        if h.Name == "ShopItems" and h:FindFirstChild("Box") then
            for i, j in next, h:children() do
                if j.BoxItemName.Value == o then
                    for i, w in next, h:children() do
                        if w.BoxItemName.Value == "Bed1" or w.BoxItemName.Value == "Seat_Couch" then
                            ID = GetShopID.FurnitureStore
                            Cashier = game.Workspace.Stores.FurnitureStore.Corey.HumanoidRootPart.CFrame
                            Counter = game.Workspace.Stores.FurnitureStore.Counter.CFrame + Vector3.new(0, .4, 0)
                        elseif w.BoxItemName.Value == "Sawmill" or w.BoxItemName.Value == "Sawmill2" then
                            ID = GetShopID.WoodRus
                            Cashier = game.Workspace.Stores.WoodRUs.Thom.HumanoidRootPart.CFrame
                            Counter = game.Workspace.Stores.WoodRUs.Counter.CFrame + Vector3.new(0, .4, 0)
                        elseif w.BoxItemName.Value == "Trailer2" or w.BoxItemName.Value == "UtilityTruck2" then
                            ID = GetShopID.CarStore
                            Cashier = game.Workspace.Stores.CarStore.Jenny.HumanoidRootPart.CFrame
                            Counter = game.Workspace.Stores.CarStore.Counter.CFrame + Vector3.new(0, .4, 0)
                        elseif w.BoxItemName.Value == "CanOfWorms" or w.BoxItemName.Value == "Dynamite" then
                            ID = GetShopID.ShackShop
                            Cashier = game.Workspace.Stores.ShackShop.Bob.HumanoidRootPart.CFrame
                            Counter = game.Workspace.Stores.ShackShop.Counter.CFrame + Vector3.new(0, .4, 0)
                        elseif w.BoxItemName.Value == "Painting1" or w.BoxItemName.Value == "Painting2" then
                            ID = GetShopID.FineArt
                            Cashier = game.Workspace.Stores.FineArt.Timothy.HumanoidRootPart.CFrame
                            Counter = game.Workspace.Stores.FineArt.Counter.CFrame + Vector3.new(0, .4, 0)
                        elseif w.BoxItemName.Value == "GateXOR" or w.BoxItemName.Value == "NeonWireOrange" then
                            ID = GetShopID.LogicStore
                            Cashier = game.Workspace.Stores.LogicStore.Lincoln.HumanoidRootPart.CFrame
                            Counter = game.Workspace.Stores.LogicStore.Counter.CFrame + Vector3.new(0, .4, 0)
                        end
                    end
                    return {j, Cashier, ID, Counter}
                end
            end
        end
    end
end

function autobuyv2(o)
    local item = nil
    local ltem = nil
    item = finditem(o)
    if item == nil then
        notify("小星", "没有找到商品或者没有刷新，请你等待", 4)
        repeat
            task.wait()
            item = finditem(o)
        until item ~= nil
    end
    ltem = item[1]
    Teleport(ltem.Main.CFrame)
    task.wait()
    game:GetService('RunService').Stepped:wait()
    for e = 1, 15 do
        game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(ltem)
        ltem:PivotTo(item[4])
        game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(ltem)
        game:GetService('RunService').Stepped:wait()
    end
    Teleport(item[4] + Vector3.new(5, 0, 5))
    repeat
        BuyItem(item[3])
        game:GetService('RunService').Stepped:wait()
    until tostring(ltem.Parent) ~= "ShopItems"
    return o
end

function autobuy(o, r)
    bai.autocsdx = game.Workspace.PlayerModels.ChildAdded:connect(function(v)
        v:WaitForChild('Owner', 60)
        if v.Owner.Value == lp then
            for i = 1, 20 do
                game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(v)
                v:PivotTo(bai.autobuyset)
                game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(v)
                game:GetService('RunService').Stepped:wait()
            end
        end
    end)
    for e = 1, r do
        if bai.autobuystop == false then
            autobuyv2(o)
            task.wait()
        end
    end
    spawn(function()
        wait(1)
        bai.autocsdx:Disconnect()
        bai.autocsdx = nil
    end)
    return o, r
end

local cashierIds = {}
spawn(function()
    local connection = game.ReplicatedStorage.NPCDialog.PromptChat.OnClientEvent:connect(function(ba, data)
        if cashierIds[data.Name] == nil then
            cashierIds[data.Name] = data.ID
        end
    end)
    game.ReplicatedStorage.NPCDialog.SetChattingValue:InvokeServer(1)
    wait(2)
    connection:Disconnect()
    connection = nil
    game.ReplicatedStorage.NPCDialog.SetChattingValue:InvokeServer(0)
end)

local function getSpecialID(Shop)
    return cashierIds[Shop]
end

function shuaxinlb(zji)
    bai.dropdown = {}
    if zji == true then
        for p, I in next, game.Players:GetChildren() do
            table.insert(bai.dropdown, I.Name)
        end
    else
        for p, I in next, game.Players:GetChildren() do
            if I ~= lp then
                table.insert(bai.dropdown, I.Name)
            end
        end
    end
end
shuaxinlb(true)

function gplr(String)
    local Found = {}
    local strl = String:lower()
    if strl == "all" then
        for i, v in pairs(game:GetService("Players"):GetPlayers()) do
            table.insert(Found, v)
        end
    elseif strl == "others" then
        for i, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v.Name ~= lp.Name then
                table.insert(Found, v)
            end
        end
    elseif strl == "me" then
        for i, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v.Name == lp.Name then
                table.insert(Found, v)
            end
        end
    else
        for i, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v.Name:lower():sub(1, #String) == String:lower() then
                table.insert(Found, v)
            end
        end
    end
    return Found
end

local function donate(plr, amount)
    local spawnf = function(func, ...)
        return coroutine.wrap(func)(...)
    end
    if tostring(plr) == tostring(lp) then
        notify('错误', '请选择玩家', 4)
        return
    end
    if bai.donationRecipient == nil or not game:GetService('Players'):FindFirstChild(plr) then
        notify('错误', '没有找到玩家', 4)
        return
    end
    if tonumber(bai.moneyaoumt) >= 60000000 then
        notify('错误', '数字太高', 4)
        return
    end
    if tonumber(bai.moneyaoumt) <= 0 then
        notify('错误', '数字太高', 4)
        return
    end
    if lp.CurrentSaveSlot.Value <= 0 then
        notify('错误', '基地没有加载', 4)
        return
    end
    if not lp:FindFirstChild('CurrentlySavingOrLoading') then
        notify('错误', '正在保存', 4)
        return
    end
    if tonumber(bai.moneyaoumt) > lp.leaderstats.Money.Value then
        notify('错误', '你没有足够的钱', 4)
        return
    end
    local scr = getsenv(lp.PlayerGui.DonateGUI.DonateClient)
    local scr2 = getsenv(lp.PlayerGui.NoticeGUI.NoticeClient)
    scr.setPlatformControls = function() end
    scr.openWindow()
    game:GetService('RunService').Heartbeat:wait()
    local oldAmount = bai.Players:FindFirstChild(plr).leaderstats.Money.Value
    local success, errormsg = spawnf(function()
        game:GetService('ReplicatedStorage').Transactions.ClientToServer.Donate:InvokeServer(game:GetService('Players'):FindFirstChild(plr), tonumber(amount), tonumber(lp.CurrentSaveSlot.Value))
    end)
    game:GetService('RunService').Heartbeat:wait()
    for i, v in next, getupvalues(scr.sendDonation) do
        if i == 1 then
            debug.setupvalue(scr.sendDonation, i, game.Players:FindFirstChild(plr))
        end
    end
    scr.sendDonation()
    game:GetService('RunService').Heartbeat:wait()
    scr2.exitNotice()
    notify('小星', '正在尝试转钱', 2)
    wait(6)
    if game:GetService('Players'):FindFirstChild(plr).leaderstats.Money.Value ~= oldAmount + amount then
        notify('错误', '错误可能需要冷却', 4)
        scr2.exitNotice()
        return
    end
    notify('小星', '转钱' .. tostring(amount) .. ' 给 ' .. tostring(plr), 4)
    scr2.exitNotice()
end

local function PlankToBlueprint()
    local target
    notify('小星', '选择一个木头和蓝图', 2)
    bai.PlankToBlueprint = game:GetService('Players').LocalPlayer:GetMouse().Button1Down:Connect(function()
        if game:GetService('Players').LocalPlayer:GetMouse().Target then
            target = game:GetService('Players').LocalPlayer:GetMouse().Target
        end
        if target.Parent:FindFirstChild('Type') and target.Parent.Type.Value == 'Blueprint' then
            bai.blueprintModel = game:GetService('Players').LocalPlayer:GetMouse().Parent
            notify('小星', '蓝图已选择', 2)
        end
        if tostring(target.Parent) == 'Plank' and target.Parent:FindFirstChild('Owner') and tostring(target.Parent.Owner.Value) == tostring(lp) then
            bai.plankModel = target.Parent
            notify('小星', '木头已选择', 2)
        end
    end)
    repeat
        wait()
    until bai.plankModel and bai.blueprintModel
    bai.PlankToBlueprint:Disconnect()
    bai.PlankToBlueprint = nil
    tp(CFrame.new(bai.plankModel:FindFirstChildOfClass('Part').CFrame.p + Vector3.new(0, 3, 4)))
    wait(.2)
    for i = 1, 30 do
        pcall(function()
            game:GetService('ReplicatedStorage').Interaction.ClientIsDragging:FireServer(bai.plankModel)
            bai.plankModel.WoodSection.CFrame = CFrame.new(bai.blueprintModel.Main.CFrame.p + Vector3.new(0, 1.5, 0))
            game:GetService('RunService').Stepped:wait()
        end)
    end
    notify('小星', '完成', 2)
    bai.blueprintModel = nil
    bai.plankModel = nil
end

local function burnAllShopItems()
    local found = false
    for _, PressurePlate in pairs(game.Workspace.PlayerModels:children()) do
        if PressurePlate:FindFirstChild('ItemName') and PressurePlate.ItemName.Value == 'PressurePlate' then
            if PressurePlate.Output.BrickColor ~= BrickColor.new('Electric blue') then
                repeat
                    wait()
                    lp.Character.HumanoidRootPart.CFrame = CFrame.new(PressurePlate.Plate.CFrame.p + Vector3.new(0, .3, 0))
                until PressurePlate.Output.BrickColor == BrickColor.new('Electric blue') or not PressurePlate
                found = true
            end
        end
    end
    if not found then
        notify('小星', '没有找到压力板', 4)
        return
    end
end

function axefily()
    bai.axeFling = mouse.Button1Down:Connect(function()
        local axe = nil
        local axeConnection = workspace.PlayerModels.ChildAdded:connect(function(v)
            v:WaitForChild('Owner', 60)
            if v.Owner.Value == lp then
                print(v)
                axe = v
                wait(2)
                game.ReplicatedStorage.Interaction.ClientInteracted:FireServer(axe, 'Pick up tool')
            end
        end)
        local oldpos = lp.Character.HumanoidRootPart.CFrame
        droptool(oldpos)
        repeat
            task.wait(0.1)
        until axe ~= nil
        axeConnection:Disconnect()
        axeConnection = nil
        local fling = Instance.new('BodyPosition', axe.Main)
        fling.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        fling.P = 650000
        fling.Position = lp:GetMouse().Hit.p
        spawn(function()
            while bai.whthmose == true do
                task.wait(0.1)
                fling.Position = lp:GetMouse().Hit.p
            end
        end)
        local flingPower = 9e9
        axe.Main.CanCollide = false
        repeat
            task.wait()
            axe.Main.RotVelocity = Vector3.new(5, 5, 5) * flingPower
        until (axe.Main.CFrame.p - fling.Position).Magnitude < 1
        wait(7)
        fling:Destroy()
        axe.Main.CanCollide = true
    end)
end

local function Press(Button)
    game.ReplicatedStorage.Interaction.RemoteProxy:FireServer(Button)
end

local MainSection = Window:Section({ Title = "主要功能", Opened = true })
local Tab1 = MainSection:Tab({ Title = "玩家", Icon = "rbxassetid://18941716391" })
local Tab2 = MainSection:Tab({ Title = "砍树", Icon = "rbxassetid://18941716391" })
local Tab3 = MainSection:Tab({ Title = "木头", Icon = "rbxassetid://18941716391" })
local Tab4 = MainSection:Tab({ Title = "传送", Icon = "rbxassetid://18941716391" })
local Tab5 = MainSection:Tab({ Title = "商店", Icon = "rbxassetid://18941716391" })
local Tab6 = MainSection:Tab({ Title = "环境", Icon = "rbxassetid://18941716391" })
local Tab7 = MainSection:Tab({ Title = "魔鬼", Icon = "rbxassetid://18941716391" })
local Tab8 = MainSection:Tab({ Title = "其他", Icon = "rbxassetid://18941716391" })

Tab1:Slider({
    Title = "移动速度",
    Value = { Min = 16, Max = 600, Default = 16 },
    Callback = function(s)
        bai.walkspeed = s
        spawn(function()
            while task.wait() do
                pcall(function()
                    game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = bai.walkspeed
                end)
            end
        end)
    end
})

Tab1:Slider({
    Title = "跳跃高度",
    Value = { Min = 50, Max = 600, Default = 50 },
    Callback = function(s)
        bai.JumpPower = s
        spawn(function()
            while task.wait() do
                pcall(function()
                    game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = bai.JumpPower
                end)
            end
        end)
    end
})

Tab1:Slider({
    Title = "重力",
    Value = { Min = -999, Max = 999, Default = 196 },
    Callback = function(s)
        game.workspace.Gravity = s
    end
})

Tab1:Slider({
    Title = "相机焦距",
    Value = { Min = 0, Max = 9999, Default = 100 },
    Callback = function(s)
        lp.CameraMaxZoomDistance = s
    end
})

Tab1:Button({
    Title = "解锁最大焦距",
    Callback = function()
        lp.CameraMaxZoomDistance = 9e9
    end
})

Tab1:Button({
    Title = "飞行",
    Callback = function()
        loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\40\39\104\116\116\112\115\58\47\47\103\105\115\116\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\109\101\111\122\111\110\101\89\84\47\98\102\48\51\55\100\102\102\57\102\48\97\55\48\48\49\55\51\48\52\100\100\100\54\55\102\100\99\100\51\55\48\47\114\97\119\47\101\49\52\101\55\52\102\52\50\53\98\48\54\48\100\102\53\50\51\51\52\51\99\102\51\48\98\55\56\55\48\55\52\101\98\51\99\53\100\50\47\97\114\99\101\117\115\37\50\53\50\48\120\37\50\53\50\48\102\108\121\37\50\53\50\48\50\37\50\53\50\48\111\98\102\108\117\99\97\116\111\114\39\41\44\116\114\117\101\41\41\40\41\10\10")()
    end
})

Tab1:Toggle({
    Title = "穿墙",
    Default = false,
    Callback = function(state)
        if state then
            Clipping = game:GetService("RunService").Stepped:connect(function()
                for i, v in next, game.Players.LocalPlayer.Character:GetChildren() do
                    if v:IsA("Part") or v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end)
        else
            if Clipping then Clipping:Disconnect() end
        end
    end
})

Tab1:Toggle({
    Title = "自身发光",
    Default = false,
    Callback = function(state)
        if state then
            local light = Instance.new('PointLight', lp.Character.Head)
            light.Name = 'bai'
            light.Range = 150
            light.Brightness = 1.7
        else
            pcall(function()
                lp.Character.Head.bai:remove()
            end)
        end
    end
})

Tab1:Button({
    Title = "安全自杀",
    Callback = function()
        lp.Character.Head:Destroy()
    end
})

Tab1:Button({
    Title = "点击传送",
    Callback = function()
        local mouse = game.Players.LocalPlayer:GetMouse()
        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "点击传送工具"
        tool.Activated:connect(function()
            local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
            pos = CFrame.new(pos.X, pos.Y, pos.Z)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
        end)
        tool.Parent = game.Players.LocalPlayer.Backpack
    end
})

Tab1:Button({
    Title = "回家",
    Callback = function()
        for i, v in pairs(game.Workspace.Properties:GetChildren()) do
            if v.Owner.Value == game.Players.LocalPlayer then
                tp(v.OriginSquare.CFrame + Vector3.new(0, 10, 0))
            end
        end
    end
})

Tab2:Dropdown({
    Title = "选择树",
    Values = {"普通树", "幻影木", "沼泽黄金", "樱花", "蓝木", "冰木", "火山木", "橡木", "巧克力木", "小星桦木", "黄金木", "雪地松", "僵尸木", "大巧克力树", "椰子树", "南瓜木", "幽灵木"},
    Value = "普通树",
    Callback = function(b)
        if b == '普通树' then
            bai.cuttreeselect = "Generic"
        elseif b == '沼泽黄金' then
            bai.cuttreeselect = "GoldSwampy"
        elseif b == '樱花' then
            bai.cuttreeselect = "Cherry"
        elseif b == '蓝木' then
            bai.cuttreeselect = "CaveCrawler"
        elseif b == '冰木' then
            bai.cuttreeselect = "Frost"
        elseif b == '火山木' then
            bai.cuttreeselect = "Volcano"
        elseif b == '橡木' then
            bai.cuttreeselect = "Oak"
        elseif b == '巧克力木' then
            bai.cuttreeselect = "Walnut"
        elseif b == '小星桦木' then
            bai.cuttreeselect = "Birch"
        elseif b == '黄金木' then
            bai.cuttreeselect = "SnowGlow"
        elseif b == '雪地松' then
            bai.cuttreeselect = "Pine"
        elseif b == '僵尸木' then
            bai.cuttreeselect = "GreenSwampy"
        elseif b == '大巧克力树' then
            bai.cuttreeselect = "Koa"
        elseif b == '椰子树' then
            bai.cuttreeselect = "Palm"
        elseif b == '南瓜木' then
            bai.cuttreeselect = "SpookyNeon"
        elseif b == '幽灵木' then
            bai.cuttreeselect = "Spooky"
        elseif b == '幻影木' then
            bai.cuttreeselect = "LoneCave"
        end
    end
})

Tab2:Button({
    Title = "砍树",
    Callback = function()
        bai.treecutset = lp.Character.HumanoidRootPart.CFrame
        bringTree(bai.cuttreeselect)
    end
})

Tab2:Toggle({
    Title = "自动砍树",
    Default = false,
    Callback = function(state)
        if state then
            bai.autofarm = true
            task.spawn(function()
                while task.wait(0.3) do
                    if bai.autofarm == true then
                        bai.treecutset = lp.Character.HumanoidRootPart.CFrame
                        bringTree(bai.cuttreeselect)
                    end
                end
            end)
        else
            bai.autofarm = false
        end
    end
})

Tab2:Toggle({
    Title = "自动赚钱",
    Default = false,
    Callback = function(state)
        if state then
            bai.autofarm1 = true
            pcall(function()
                while task.wait() do
                    if bai.autofarm1 == true then
                        game:GetService("Players").LocalPlayer.Character:MoveTo(Vector3.new(315, -0.296, 102.791))
                        autofarm(bai.cuttreeselect)
                        wait(1)
                        game:GetService("Players").LocalPlayer.Character:MoveTo(Vector3.new(315, -0.296, 102.791))
                        wait(20)
                    end
                end
            end)
        else
            bai.autofarm1 = false
            for i, v in pairs(game.Workspace.Properties:GetChildren()) do
                if v.Owner.Value == game.Players.LocalPlayer then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.OriginSquare.CFrame + Vector3.new(0, 10, 0)
                end
            end
        end
    end
})

Tab2:Button({
    Title = "加载复制斧头",
    Callback = function()
        CanClientLoad()
        wait(1)
        lp.Character.Head:Destroy()
        wait(bai.loaddupeaxewaittime)
        LoadSlot(GetLoadedSlot())
        wait(6)
        lp.Character.HumanoidRootPart.CFrame = oldpos
    end
})

Tab2:Textbox({
    Title = "死亡后加载时间",
    Value = "3.1",
    PlaceholderText = "输入秒数",
    Callback = function(txt)
        bai.loaddupeaxewaittime = tonumber(txt) or 3.1
    end
})

Tab2:Toggle({
    Title = "自动扔斧头",
    Default = false,
    Callback = function(state)
        bai.autodropae = true
        if state then
            while wait() do
                if bai.autodropae == true then
                    local oldpos = lp.Character.HumanoidRootPart.CFrame
                    droptool(oldpos)
                end
            end
        else
            bai.autodropae = false
        end
    end
})

Tab2:Toggle({
    Title = "自动捡斧头",
    Default = false,
    Callback = function(state)
        if state then
            bai.autopick = true
            while bai.autopick == true do
                task.wait(0.1)
                for a, b in pairs(workspace.PlayerModels:GetChildren()) do
                    if b:FindFirstChild("Owner") and b.Owner.Value == game.Players.LocalPlayer then
                        if b:FindFirstChild("Type") and b.Type.Value == "Tool" then
                            game:GetService('ReplicatedStorage').Interaction.ClientInteracted:FireServer(b, 'Pick up tool')
                        end
                    end
                end
            end
        else
            bai.autopick = false
        end
    end
})

Tab2:Button({
    Title = "远程装备斧头",
    Callback = function()
        farAxeEquip()
    end
})

Tab2:Toggle({
    Title = "斧头跟随鼠标",
    Default = false,
    Callback = function(state)
        bai.whthmose = state
    end
})

Tab2:Toggle({
    Title = "斧头炸家",
    Default = false,
    Callback = function(state)
        if state then
            axefily()
        else
            if bai.axeFling then
                bai.axeFling:Disconnect(0.1)
                bai.axeFling = nil
            end
        end
    end
})

Tab3:Button({
    Title = "传送木头到脚下",
    Callback = function()
        local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        for i, v in next, game:GetService("Workspace").LogModels:GetChildren() do
            if v:FindFirstChild("Owner") and v.Owner.Value == game.Players.LocalPlayer then
                if not v.PrimaryPart then
                    v.PrimaryPart = v:FindFirstChild("WoodSection")
                end
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v:FindFirstChild("WoodSection").CFrame.p)
                spawn(function()
                    for i = 1, 50 do
                        game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(v)
                        task.wait()
                    end
                end)
                for i = 1, 50 do
                    task.wait()
                    v:PivotTo(OldPos)
                end
                task.wait()
            end
        end
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OldPos
    end
})

Tab3:Button({
    Title = "传送木板到脚下",
    Callback = function()
        local logFolder = getPlanks()
        local oldPos = game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame
        for _, log in next, logFolder do
            if log:FindFirstChild('WoodSection') then
                spawn(function()
                    for i = 1, 20 do
                        game:GetService('ReplicatedStorage').Interaction.ClientIsDragging:FireServer(log)
                        task.wait()
                    end
                end)
                wait(0.18)
                if not log.PrimaryPart then
                    log.PrimaryPart = log.WoodSection
                end
                log:SetPrimaryPartCFrame(oldPos)
            end
        end
    end
})

Tab3:Button({
    Title = "卖木头",
    Callback = function()
        sellwood()
    end
})

Tab3:Toggle({
    Title = "自动卖木头",
    Default = false,
    Callback = function(state)
        while wait() do
            if state then
                sellwood()
            end
        end
    end
})

Tab3:Button({
    Title = "卖木板",
    Callback = function()
        for _, Plank in pairs(game.Workspace.PlayerModels:GetChildren()) do
            if Plank.Name == "Plank" and Plank:findFirstChild("Owner") then
                if Plank.Owner.Value == game.Players.LocalPlayer then
                    for i, v in pairs(Plank:GetChildren()) do
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
                            game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(Plank)
                        end
                    end)
                end
            end
        end
    end
})

Tab3:Toggle({
    Title = "自动卖木板",
    Default = false,
    Callback = function(state)
        while wait() do
            if state then
                for _, Plank in pairs(game.Workspace.PlayerModels:GetChildren()) do
                    if Plank.Name == "Plank" and Plank:findFirstChild("Owner") then
                        if Plank.Owner.Value == game.Players.LocalPlayer then
                            for i, v in pairs(Plank:GetChildren()) do
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
                                    game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(Plank)
                                end
                            end)
                        end
                    end
                end
            end
        end
    end
})

Tab3:Button({
    Title = "木板填充蓝图",
    Callback = function()
        PlankToBlueprint()
    end
})

Tab3:Toggle({
    Title = "拖拽器增强",
    Default = false,
    Callback = function(state)
        if state then
            workspace.ChildAdded:connect(function(Dragger)
                if tostring(Dragger) == 'Dragger' then
                    local BodyGyro = Dragger:WaitForChild('BodyGyro')
                    local BodyPosition = Dragger:WaitForChild('BodyPosition')
                    repeat
                        game:GetService('RunService').Stepped:wait()
                    until workspace:FindFirstChild('Dragger')
                    BodyPosition.P = 120000
                    BodyPosition.D = 1000
                    BodyPosition.maxForce = Vector3.new(1, 1, 1) * 1000000
                    BodyGyro.maxTorque = Vector3.new(1, 1, 1) * 200
                    BodyGyro.P = 1200
                    BodyGyro.D = 140
                end
            end)
        else
            workspace.ChildAdded:connect(function(Dragger)
                if tostring(Dragger) == 'Dragger' then
                    local BodyGyro = Dragger:WaitForChild('BodyGyro')
                    local BodyPosition = Dragger:WaitForChild('BodyPosition')
                    repeat
                        game:GetService('RunService').Stepped:wait()
                    until workspace:FindFirstChild('Dragger')
                    BodyPosition.P = 10000
                    BodyPosition.D = 800
                    BodyPosition.maxForce = Vector3.new(17000, 17000, 17000)
                    BodyGyro.maxTorque = Vector3.new(200, 200, 200)
                    BodyGyro.P = 1200
                    BodyGyro.D = 140
                end
            end)
        end
    end
})

Tab4:Dropdown({
    Title = "传送",
    Values = {"出生点", "木材反斗城", "土地商店", "桥", "码头", "椰子岛", "洞穴", "鲨鱼斧合成", "火山", "沼泽", "家具店", "盒子车行", "连锁逻辑店", "鲍勃的小店", "画廊", "雪山", "灵视神殿", "怪人", "小绿盒", "滑雪小屋", "黄金木洞穴", "小鸟斧头", "灯塔", "回家"},
    Value = "出生点",
    Callback = function(b)
        if b == '木材反斗城' then
            tp(CFrame.new(270, 4, 60))
        elseif b == '出生点' then
            tp(CFrame.new(174, 10.5, 66))
        elseif b == '土地商店' then
            tp(CFrame.new(270, 3, -98))
        elseif b == '桥' then
            tp(CFrame.new(112, 37, -892))
        elseif b == '码头' then
            tp(CFrame.new(1136, 0, -206))
        elseif b == '椰子岛' then
            tp(CFrame.new(2614, -4, -34))
        elseif b == '洞穴' then
            tp(CFrame.new(3590, -177, 415))
        elseif b == '火山' then
            tp(CFrame.new(-1588, 623, 1069))
        elseif b == '沼泽' then
            tp(CFrame.new(-1216, 131, -822))
        elseif b == '家具店' then
            tp(CFrame.new(486, 3, -1722))
        elseif b == '盒子车行' then
            tp(CFrame.new(509, 3, -1458))
        elseif b == '雪山' then
            tp(CFrame.new(1487, 415, 3259))
        elseif b == '连锁逻辑店' then
            tp(CFrame.new(4615, 7, -794))
        elseif b == '鲍勃的小店' then
            tp(CFrame.new(292, 8, -2544))
        elseif b == '画廊' then
            tp(CFrame.new(5217, -166, 721))
        elseif b == '灵视神殿' then
            tp(CFrame.new(-1608, 195, 928))
        elseif b == '怪人' then
            tp(CFrame.new(1071, 16, 1141))
        elseif b == '小绿盒' then
            tp(CFrame.new(-1667, 349, 1474))
        elseif b == '滑雪小屋' then
            tp(CFrame.new(1244, 59, 2290))
        elseif b == '黄金木洞穴' then
            tp(CFrame.new(-1080, -5, -942))
        elseif b == '鲨鱼斧合成' then
            tp(CFrame.new(330.259735, 45.7998505, 1943.30823, 0.972010553, -8.07546598e-08, 0.234937176, 7.63610259e-08, 1, 2.77986647e-08, -0.234937176, -9.08055142e-09, 0.972010553))
        elseif b == '小鸟斧头' then
            tp(CFrame.new(4813.1, 33.5, -978.8))
        elseif b == '灯塔' then
            tp(CFrame.new(1464.8, 356.3, 3257.2))
        else
            if b == '回家' then
                for i, v in pairs(game.Workspace.Properties:GetChildren()) do
                    if v.Owner.Value == game.Players.LocalPlayer then
                        tp(v.OriginSquare.CFrame + Vector3.new(0, 10, 0))
                    end
                end
            end
        end
    end
})

Tab4:Dropdown({
    Title = "汽车传送",
    Values = {"出生点", "木材反斗城", "土地商店", "桥", "码头", "椰子岛", "洞穴", "鲨鱼斧合成", "火山", "沼泽", "家具店", "盒子车行", "连锁逻辑店", "鲍勃的小店", "画廊", "雪山", "灵视神殿", "怪人", "小绿盒", "滑雪小屋", "黄金木洞穴", "小鸟斧头", "灯塔", "回家"},
    Value = "出生点",
    Callback = function(b)
        if b == '木材反斗城' then
            carTeleport(CFrame.new(270, 4, 60))
        elseif b == '出生点' then
            carTeleport(CFrame.new(174, 10.5, 66))
        elseif b == '土地商店' then
            carTeleport(CFrame.new(270, 3, -98))
        elseif b == '桥' then
            carTeleport(CFrame.new(112, 37, -892))
        elseif b == '码头' then
            carTeleport(CFrame.new(1136, 0, -206))
        elseif b == '椰子岛' then
            carTeleport(CFrame.new(2614, -4, -34))
        elseif b == '洞穴' then
            carTeleport(CFrame.new(3590, -177, 415))
        elseif b == '火山' then
            carTeleport(CFrame.new(-1588, 623, 1069))
        elseif b == '沼泽' then
            carTeleport(CFrame.new(-1216, 131, -822))
        elseif b == '家具店' then
            carTeleport(CFrame.new(486, 3, -1722))
        elseif b == '盒子车行' then
            carTeleport(CFrame.new(509, 3, -1458))
        elseif b == '雪山' then
            carTeleport(CFrame.new(1487, 415, 3259))
        elseif b == '连锁逻辑店' then
            carTeleport(CFrame.new(4615, 7, -794))
        elseif b == '鲍勃的小店' then
            carTeleport(CFrame.new(292, 8, -2544))
        elseif b == '画廊' then
            carTeleport(CFrame.new(5217, -166, 721))
        elseif b == '灵视神殿' then
            carTeleport(CFrame.new(-1608, 195, 928))
        elseif b == '怪人' then
            carTeleport(CFrame.new(1071, 16, 1141))
        elseif b == '小绿盒' then
            carTeleport(CFrame.new(-1667, 349, 1474))
        elseif b == '滑雪小屋' then
            carTeleport(CFrame.new(1244, 59, 2290))
        elseif b == '黄金木洞穴' then
            carTeleport(CFrame.new(-1080, -5, -942))
        elseif b == '鲨鱼斧合成' then
            carTeleport(CFrame.new(330.259735, 45.7998505, 1943.30823, 0.972010553, -8.07546598e-08, 0.234937176, 7.63610259e-08, 1, 2.77986647e-08, -0.234937176, -9.08055142e-09, 0.972010553))
        elseif b == '小鸟斧头' then
            carTeleport(CFrame.new(4813.1, 33.5, -978.8))
        elseif b == '灯塔' then
            carTeleport(CFrame.new(1464.8, 356.3, 3257.2))
        else
            if b == '回家' then
                for i, v in pairs(game.Workspace.Properties:GetChildren()) do
                    if v.Owner.Value == game.Players.LocalPlayer then
                        carTeleport(v.OriginSquare.CFrame + Vector3.new(0, 10, 0))
                    end
                end
            end
        end
    end
})

Tab4:Textbox({
    Title = "输入飞行速度",
    Value = "",
    PlaceholderText = "输入数字",
    Callback = function(s)
        while (true) do
            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
            game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChildOfClass("BodyVelocity"):Destroy()
            game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChildOfClass("BodyGyro"):Destroy()
            wait()
            local BV = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
            local BG = Instance.new("BodyGyro", game.Players.LocalPlayer.Character.HumanoidRootPart)
            BG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            BG.D = 5000
            BG.P = 50000
            BG.CFrame = game.Workspace.CurrentCamera.CFrame
            BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            BV.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * tonumber(s)
        end
    end
})

Tab4:Toggle({
    Title = "汽车穿墙",
    Default = false,
    Callback = function(state)
        if state then
            vnoclipParts = {}
            local seat = lp.Character:FindFirstChildOfClass('Humanoid').SeatPart
            local vehicleModel = seat.Parent
            repeat
                if vehicleModel.ClassName ~= "Model" then
                    vehicleModel = vehicleModel.Parent
                end
            until vehicleModel.ClassName == "Model"
            wait(0.1)
            for i, v in pairs(vehicleModel:GetDescendants()) do
                if v:IsA("BasePart") and v.CanCollide then
                    table.insert(vnoclipParts, v)
                    v.CanCollide = false
                end
            end
        else
            for i, v in pairs(vnoclipParts) do
                v.CanCollide = true
            end
            vnoclipParts = {}
        end
    end
})

Tab4:Slider({
    Title = "汽车速度",
    Value = { Min = 3, Max = 600, Default = 3 },
    Callback = function(s)
        local speed = s
        for i, v in pairs(game.Workspace.PlayerModels:GetChildren()) do
            if v:FindFirstChild("Seat") and v:FindFirstChild("Configuration") then
                v.Configuration.MaxSpeed.Value = speed
            end
        end
    end
})

Tab5:Button({
    Title = "买桥",
    Callback = function()
        game.ReplicatedStorage.NPCDialog.PlayerChatted:InvokeServer({
            ['Character'] = workspace.Bridge.TollBooth0.Seranok,
            ['Name'] = 'Seranok',
            ['ID'] = getSpecialID('Seranok'),
            ['Dialog'] = workspace.Bridge.TollBooth0.Seranok.Dialog
        }, 'ConfirmPurchase')
    end
})

Tab5:Button({
    Title = "买船票",
    Callback = function()
        game.ReplicatedStorage.NPCDialog.PlayerChatted:InvokeServer({
            ['Character'] = workspace.Ferry.Ferry.Hoover,
            ['Name'] = 'Hoover',
            ['ID'] = getSpecialID('Hoover'),
            ['Dialog'] = workspace.Ferry.Ferry.Hoover.Dialog
        }, 'ConfirmPurchase')
    end
})

Tab5:Button({
    Title = "买黄金蓝图",
    Callback = function()
        game.ReplicatedStorage.NPCDialog.PlayerChatted:InvokeServer({
            ['Character'] = workspace.Region_Main['Strange Man'],
            ['Name'] = 'Strange Man',
            ['ID'] = getSpecialID('Strange Man'),
            ['Dialog'] = workspace.Region_Main['Strange Man'].Dialog
        }, 'ConfirmPurchase')
    end
})

Tab5:Textbox({
    Title = "购买数量",
    Value = "1",
    PlaceholderText = "输入数字",
    Callback = function(txt)
        bai.autobuyamount = txt
    end
})

Tab5:Dropdown({
    Title = "自动购买物品",
    Values = {"按钮", "控制杆", "电线", "4/4x1木楔", "3/4x1木楔", "2/4x1木楔", "1/4X1木楔", "3/3x1木楔", "2/3x1木楔", "1/3x1木楔", "2/2x1木楔", "1/2x1木楔", "1/1x1木楔", "篱笆", "压力板", "1/3木楔", "锯木机01", "锯木机02L", "波纹墙角立柱", "传送带", "普通凳子", "倾斜传送带", "3/4木楔", "2/3木楔", "光滑的墙", "光滑墙角", "普通锯木厂", "4/4木楔", "光滑墙立柱", "篱笆角", "矮篱笆角", "矮波纹墙", "长桌", "矮篱笆", "光滑墙角立柱", "破旧锯木厂", "普通门", "矮光滑墙", "工作灯", "弯传送带", "切换传送带", "宽敞门", "3/3木楔", "400元小汽车", "波纹墙立柱", "锯木机02", "漏斗式传送带", "小型地板", "小型瓷砖", "矮波纹墙角", "波纹墙", "大型地板", "微型瓷砖", "微型地板", "1/1木楔", "左转直式传送带", "银斧头", "切割机", "基础斧头", "右转传送带", "普通斧头", "转向传送带支架", "传送带支架", "楼梯", "陡峭楼梯", "钢斧", "标志杆", "梯子", "大型瓷砖", "瓷砖", "硬化斧", "半截门", "木头清扫机", "沙子袋", "小型拖车", "531式拖车", "小汽车XL", "大卡车", "长沙发", "洗碗机", "薄柜子", "冰箱", "火炉", "马桶", "双人沙发", "床", "落地灯", "台灯", "微型玻璃板", "小型玻璃板", "玻璃板", "大型玻璃板", "玻璃门", "琥珀色冰柱灯串", "红色冰柱灯串", "绿色冰柱灯串", "蓝色冰柱灯串", "烟花发射器", "惊悚冰柱灯串", "单人沙发", "双人床", "灯泡", "工作台面", "薄工作台面", "带水槽的工作台面", "照明灯", "墙灯", "橱柜角", "宽橱柜角", "橱柜", "炸药", "毛毛虫软糖", "未知标题", "困扰装饰画", "户外水彩素描", "阴郁的黄昏海景", "北极灯串", "菠萝画", "孤独的长颈鹿", "信号维持器", "与门", "异与门", "木材检测器", "OR门", "拉杆", "信号延时器", "信号变换器", "激光", "激光探测器", "舱门", "橙色发光线", "绿色发光线", "黄色发光线", "小星色发光线", "紫色发光线", "红色发光线", "青色发光线", "蓝色发光线", "定时开关"},
    Value = "按钮",
    Callback = function(a)
        if a == '按钮' then
            bai.buyitem = 'Button0'
        elseif a == '控制杆' then
            bai.buyitem = 'Lever0'
        elseif a == '电线' then
            bai.buyitem = 'Wire'
        elseif a == '4/4x1木楔' then
            bai.buyitem = 'Wedge1_Thin'
        elseif a == '3/4x1木楔' then
            bai.buyitem = 'Wedge2_Thin'
        elseif a == '2/4x1木楔' then
            bai.buyitem = 'Wedge3_Thin'
        elseif a == '1/4x1木楔' then
            bai.buyitem = 'Wedge4_Thin'
        elseif a == '3/3x1木楔' then
            bai.buyitem = 'Wedge5_Thin'
        elseif a == '2/3x1木楔' then
            bai.buyitem = 'Wedge6_Thin'
        elseif a == '1/3x1木楔' then
            bai.buyitem = 'Wedge7_Thin'
        elseif a == '2/2x1木楔' then
            bai.buyitem = 'Wedge8_Thin'
        elseif a == '1/2x1木楔' then
            bai.buyitem = 'Wedge9_Thin'
        elseif a == '1/1x1木楔' then
            bai.buyitem = 'Wedge10_Thin'
        elseif a == '篱笆' then
            bai.buyitem = 'Wall3TallThin'
        elseif a == '压力板' then
            bai.buyitem = 'PressurePlate'
        elseif a == '1/3木楔' then
            bai.buyitem = 'Wedge7'
        elseif a == '锯木机01' then
            bai.buyitem = 'Sawmill3'
        elseif a == '锯木机02L' then
            bai.buyitem = 'Sawmill4L'
        elseif a == '波纹墙角立柱' then
            bai.buyitem = 'Wall1ShortCorner'
        elseif a == '传送带' then
            bai.buyitem = 'StraightConveyor'
        elseif a == '普通凳子' then
            bai.buyitem = 'Chair1'
        elseif a == '倾斜传送带' then
            bai.buyitem = 'TiltConveyor'
        elseif a == '3/4木楔' then
            bai.buyitem = 'Wedge2'
        elseif a == '2/3木楔' then
            bai.buyitem = 'Wedge6'
        elseif a == '光滑的墙' then
            bai.buyitem = "Wall2"
        elseif a == '光滑墙角' then
            bai.buyitem = 'Wall2TallCorner'
        elseif a == '普通锯木厂' then
            bai.buyitem = 'Sawmill2'
        elseif a == '4/4木楔' then
            bai.buyitem = 'Wedge1'
        elseif a == '光滑墙立柱' then
            bai.buyitem = 'Wall2Short'
        elseif a == '篱笆角' then
            bai.buyitem = 'Wall3TallCorner'
        elseif a == '矮篱笆角' then
            bai.buyitem = 'Wall3Corner'
        elseif a == '矮波纹墙' then
            bai.buyitem = 'Wall1Thin'
        elseif a == '长桌' then
            bai.buyitem = 'Table2'
        elseif a == '矮篱笆' then
            bai.buyitem = 'Wall3'
        elseif a == '光滑墙角立柱' then
            bai.buyitem = 'Wall2ShortCorner'
        elseif a == '破旧锯木厂' then
            bai.buyitem = 'Sawmill'
        elseif a == '普通门' then
            bai.buyitem = 'Door1'
        elseif a == '矮光滑墙' then
            bai.buyitem = 'Wall2'
        elseif a == '工作灯' then
            bai.buyitem = 'WorkLight'
        elseif a == '弯传送带' then
            bai.buyitem = 'TightTurnConveyor'
        elseif a == '切换传送带' then
            bai.buyitem = 'ConveyorSwitch'
        elseif a == '宽敞门' then
            bai.buyitem = 'Door3'
        elseif a == '3/3木楔' then
            bai.buyitem = 'Wedge5'
        elseif a == '400元小汽车' then
            bai.buyitem = 'UtilityTruck'
        elseif a == '波纹墙立柱' then
            bai.buyitem = 'Wall1ShortThin'
        elseif a == '锯木机02' then
            bai.buyitem = 'Sawmill4L'
        elseif a == '漏斗式传送带' then
            bai.buyitem = 'ConveyorFunnel'
        elseif a == '小型地板' then
            bai.buyitem = 'Floor1Small'
        elseif a == '小型瓷砖' then
            bai.buyitem = 'Floor2Small'
        elseif a == '矮波纹墙角' then
            bai.buyitem = 'Wall1Corner'
        elseif a == '波纹墙' then
            bai.buyitem = 'Wall1Tall'
        elseif a == '大型地板' then
            bai.buyitem = 'Floor1Large'
        elseif a == '微型瓷砖' then
            bai.buyitem = 'Floor2Tiny'
        elseif a == '微型地板' then
            bai.buyitem = 'Floor1Tiny'
        elseif a == '1/1木楔' then
            bai.buyitem = 'Wedge10'
        elseif a == '左转直式传送带' then
            bai.buyitem = 'StraightSwitchConveyorLeft'
        elseif a == '银斧头' then
            bai.buyitem = 'SilverAxe'
        elseif a == '切割机' then
            bai.buyitem = 'ChopSaw'
        elseif a == '基础斧头' then
            bai.buyitem = 'BasicHatchet'
        elseif a == '右转传送带' then
            bai.buyitem = 'StraightSwitchConveyorRight'
        elseif a == '普通斧头' then
            bai.buyitem = 'Axe1'
        elseif a == '转向传送带支架' then
            bai.buyitem = 'TightTurnConveyorSupports'
        elseif a == '传送带支架' then
            bai.buyitem = 'ConveyorSupports'
        elseif a == '楼梯' then
            bai.buyitem = 'Stair2'
        elseif a == '陡峭楼梯' then
            bai.buyitem = 'Stair1'
        elseif a == '钢斧' then
            bai.buyitem = 'Axe2'
        elseif a == '标志杆' then
            bai.buyitem = 'Post'
        elseif a == '梯子' then
            bai.buyitem = 'Ladder1'
        elseif a == '大型瓷砖' then
            bai.buyitem = 'Floor2Large'
        elseif a == '瓷砖' then
            bai.buyitem = 'Floor2'
        elseif a == '硬化斧' then
            bai.buyitem = 'Axe3'
        elseif a == '半截门' then
            bai.buyitem = 'Door2'
        elseif a == '木头清扫机' then
            bai.buyitem = 'LogSweeper'
        elseif a == '沙子袋' then
            bai.buyitem = 'BagOfSand'
        elseif a == '小型拖车' then
            bai.buyitem = 'SmallTrailer'
        elseif a == '531式拖车' then
            bai.buyitem = 'Trailer2'
        elseif a == '小汽车XL' then
            bai.buyitem = 'UtilityTruck2'
        elseif a == '大卡车' then
            bai.buyitem = 'Pickup1'
        elseif a == '长沙发' then
            bai.buyitem = 'Seat_Couch'
        elseif a == '洗碗机' then
            bai.buyitem = 'Dishwasher'
        elseif a == '薄柜子' then
            bai.buyitem = 'Cabinet1Thin'
        elseif a == '冰箱' then
            bai.buyitem = 'Refridgerator'
        elseif a == '马桶' then
            bai.buyitem = 'Toilet'
        elseif a == '双人沙发' then
            bai.buyitem = 'Seat_Loveseat'
        elseif a == '床' then
            bai.buyitem = 'Bed1'
        elseif a == '落地灯' then
            bai.buyitem = 'FloorLamp1'
        elseif a == '台灯' then
            bai.buyitem = 'Lamp1'
        elseif a == '微型玻璃板' then
            bai.buyitem = 'GlassPane1'
        elseif a == '小型玻璃板' then
            bai.buyitem = 'GlassPane2'
        elseif a == '玻璃板' then
            bai.buyitem = 'GlassPane3'
        elseif a == '大型玻璃板' then
            bai.buyitem = 'GlassPane4'
        elseif a == '玻璃门' then
            bai.buyitem = 'GlassDoor1'
        elseif a == '琥珀色冰柱灯串' then
            bai.buyitem = 'IcicleWireAmber'
        elseif a == '红色冰柱灯串' then
            bai.buyitem = 'IcicleWireRed'
        elseif a == '绿色冰柱灯串' then
            bai.buyitem = 'IcicleWireGreen'
        elseif a == '蓝色冰柱灯串' then
            bai.buyitem = 'IcicleWireBlue'
        elseif a == '烟花发射器' then
            bai.buyitem = 'FireworkLauncher'
        elseif a == '惊悚冰柱灯串' then
            bai.buyitem = 'IcicleWireHalloween'
        elseif a == '单人沙发' then
            bai.buyitem = 'Seat_Armchair'
        elseif a == '双人床' then
            bai.buyitem = 'Bed2'
        elseif a == '灯泡' then
            bai.buyitem = 'LightBulb'
        elseif a == '工作台面' then
            bai.buyitem = 'CounterTop1'
        elseif a == '薄工作台面' then
            bai.buyitem = 'CounterTop1Thin'
        elseif a == '带水槽的工作台面' then
            bai.buyitem = 'CounterTop1Sink'
        elseif a == '照明灯' then
            bai.buyitem = 'WallLight2'
        elseif a == '墙灯' then
            bai.buyitem = 'WallLight1'
        elseif a == '橱柜角' then
            bai.buyitem = 'Cabinet1CornerTight'
        elseif a == '宽橱柜角' then
            bai.buyitem = 'Cabinet1CornerWide'
        elseif a == '橱柜' then
            bai.buyitem = 'Cabinet1'
        elseif a == '毛毛虫软糖' then
            bai.buyitem = 'CanOfWorms'
        elseif a == '炸药' then
            bai.buyitem = 'Dynamite'
        elseif a == '未知标题' then
            bai.buyitem = 'Painting1'
        elseif a == '困扰装饰画' then
            bai.buyitem = 'Painting2'
        elseif a == '户外水彩素描' then
            bai.buyitem = 'Painting3'
        elseif a == '阴郁的黄昏海景' then
            bai.buyitem = 'Painting6'
        elseif a == '北极灯串' then
            bai.buyitem = 'Painting7'
        elseif a == '菠萝画' then
            bai.buyitem = 'Painting8'
        elseif a == '孤独的长颈鹿' then
            bai.buyitem = 'Painting9'
        elseif a == '信号维持器' then
            bai.buyitem = 'SignalSustain'
        elseif a == '与门' then
            bai.buyitem = 'GateAND'
        elseif a == '异与门' then
            bai.buyitem = 'GateXOR'
        elseif a == '木材检测器' then
            bai.buyitem = 'WoodChecker'
        elseif a == 'OR门' then
            bai.buyitem = 'GateOR'
        elseif a == '拉杆' then
            bai.buyitem = 'Lever0'
        elseif a == '信号延时器' then
            bai.buyitem = 'SignalDelay'
        elseif a == '信号变换器' then
            bai.buyitem = 'GateNOT'
        elseif a == '激光' then
            bai.buyitem = 'Laser'
        elseif a == '激光探测器' then
            bai.buyitem = 'LaserReceiver'
        elseif a == '舱门' then
            bai.buyitem = 'Hatch'
        elseif a == '橙色发光线' then
            bai.buyitem = 'NeonWireOrange'
        elseif a == '绿色发光线' then
            bai.buyitem = 'NeonWireGreen'
        elseif a == '黄色发光线' then
            bai.buyitem = 'NeonWireYellow'
        elseif a == '小星色发光线' then
            bai.buyitem = 'NeonWireWhite'
        elseif a == '紫色发光线' then
            bai.buyitem = 'NeonWireViolet'
        elseif a == '红色发光线' then
            bai.buyitem = 'NeonWireRed'
        elseif a == '青色发光线' then
            bai.buyitem = 'NeonWireCyan'
        elseif a == '蓝色发光线' then
            bai.buyitem = 'NeonWireBlue'
        elseif a == '定时开关' then
            bai.buyitem = 'ClockSwitch'
        end
    end
})

Tab5:Button({
    Title = "自动购买",
    Callback = function()
        bai.autobuystop = false
        bai.autobuyset = lp.Character.HumanoidRootPart.CFrame
        autobuy(bai.buyitem, bai.autobuyamount)
        task.wait()
        tp(bai.autobuyset)
    end
})

Tab5:Button({
    Title = "停止购买",
    Callback = function()
        bai.autobuystop = true
        pcall(function()
            bai.autocsdx:Disconnect()
            bai.autocsdx = nil
        end)
    end
})

Tab6:Toggle({
    Title = "终日白天",
    Default = false,
    Callback = function(state)
        if state then
            bai.awaysday = true
            while task.wait() do
                if bai.awaysday == true then
                    game:GetService('Lighting').TimeOfDay = '12:00:00'
                end
            end
        else
            bai.awaysday = false
        end
    end
})

Tab6:Toggle({
    Title = "终日黑夜",
    Default = false,
    Callback = function(state)
        if state then
            bai.awaysdnight = true
            while task.wait() do
                if bai.awaysdnight == true then
                    game:GetService('Lighting').TimeOfDay = '2:00:00'
                end
            end
        else
            bai.awaysdnight = false
        end
    end
})

Tab6:Toggle({
    Title = "消除阴影",
    Default = false,
    Callback = function(state)
        game:GetService("Lighting").GlobalShadows = not state
    end
})

Tab6:Toggle({
    Title = "去除雾",
    Default = false,
    Callback = function(state)
        if state then
            bai.nofog = true
            while task.wait() do
                if bai.nofog == true then
                    game:GetService('Lighting').FogEnd = 1000000
                end
            end
        else
            bai.nofog = false
        end
    end
})

Tab6:Toggle({
    Title = "水上行走",
    Default = false,
    Callback = function(state)
        for i, v in next, game.workspace.Water:children() do
            if v.ClassName == 'Part' then
                bai.waterwalk, v.CanCollide = state, state
            end
        end
        for i, v in next, game:GetService('Workspace').Bridge.VerticalLiftBridge.WaterModel:children() do
            if v:IsA('BasePart') then
                v.CanCollide = state
            end
        end
    end
})

Tab6:Toggle({
    Title = "放下桥",
    Default = false,
    Callback = function(state)
        if state then
            lowerBridge("Lower")
        else
            lowerBridge("Higher")
        end
    end
})

Tab6:Button({
    Title = "删除火山石头",
    Callback = function()
        for i, v in pairs(workspace["Region_Volcano"]:children()) do
            if v.Name == "PartSpawner" then
                v.Parent = game.Lighting
            end
        end
    end
})

Tab6:Button({
    Title = "删除雪山石头",
    Callback = function()
        for i, v in pairs(workspace["Region_Snow"]:children()) do
            if v.Name == "PartSpawner" then
                v.Parent = game.Lighting
            end
        end
    end
})

Tab6:Button({
    Title = "删除迷宫门",
    Callback = function()
        spawn(function()
            pcall(function()
                local door7 = game:GetService('Workspace')['Region_MazeCave'].Blockade.Blockade7
                door7:Destroy()
            end)
        end)
        spawn(function()
            pcall(function()
                local door6 = game:GetService('Workspace')['Region_MazeCave'].Blockade.Blockade6
                door6:Destroy()
            end)
        end)
        spawn(function()
            pcall(function()
                local door5 = game:GetService('Workspace')['Region_MazeCave'].Blockade.Blockade5
                door5:Destroy()
            end)
        end)
        spawn(function()
            pcall(function()
                local door4 = game:GetService('Workspace')['Region_MazeCave'].Blockade.Blockade4
                door4:Destroy()
            end)
        end)
        spawn(function()
            pcall(function()
                local door3 = game:GetService('Workspace')['Region_MazeCave'].Blockade.Blockade3
                door3:Destroy()
            end)
        end)
        spawn(function()
            pcall(function()
                local door2 = game:GetService('Workspace')['Region_MazeCave'].Blockade.Blockade2
                door2:Destroy()
            end)
        end)
        spawn(function()
            pcall(function()
                local door1 = game:GetService('Workspace')['Region_MazeCave'].Blockade.Blockade1
                door1:Destroy()
            end)
        end)
        spawn(function()
            pcall(function()
                local door = game:GetService('Workspace')['Region_MazeCave'].Blockade.Blockade0
                door:Destroy()
            end)
        end)
    end
})

Tab6:Button({
    Title = "启动所有压力板",
    Callback = function()
        burnAllShopItems()
    end
})

Tab6:Button({
    Title = "圣诞节地图",
    Callback = function()
        for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v.Name == "Ground" then
                v.BrickColor = BrickColor.new("White")
                v.Material = "Sand"
            end
            if v.Name == "Slate" then
                v.BrickColor = BrickColor.new("White")
            end
            if v.Name == "LeafPart" then
                v.BrickColor = BrickColor.new("White")
                v.Material = "Sand"
            end
            if v.Name == "Sand" then
                v.BrickColor = BrickColor.new("White")
            end
        end
    end
})

Tab6:Button({
    Title = "秋天地图",
    Callback = function()
        for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v.Name == "Ground" then
                v.BrickColor = BrickColor.new("Burnt Sienna")
                v.Material = "Sand"
            end
            if v.Name == "Slate" then
                v.BrickColor = BrickColor.new("Burnt Sienna")
            end
            if v.Name == "LeafPart" then
                v.BrickColor = BrickColor.new("Burnt Sienna")
                v.Material = "Sand"
            end
        end
    end
})

Tab7:Dropdown({
    Title = "选择玩家",
    Values = bai.dropdown,
    Value = bai.dropdown[1] or "",
    Callback = function(v)
        bai.playernamedied = v
    end
})

Tab7:Button({
    Title = "刷新玩家列表",
    Callback = function()
        shuaxinlb(true)
    end
})

Tab7:Button({
    Title = "传送到玩家旁边",
    Callback = function()
        local HumRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
        local tp_player = game:GetService("Players")[bai.playernamedied]
        if tp_player then
            for i = 1, 5 do
                wait()
                HumRoot.CFrame = tp_player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            end
        end
    end
})

Tab7:Button({
    Title = "传送到玩家基地",
    Callback = function()
        local ME = game.Players.LocalPlayer.Character.HumanoidRootPart
        for i, v in pairs(game.Workspace.Properties:GetChildren()) do
            if v.Owner.Value == game.Players[bai.playernamedied] then
                ME.CFrame = v.OriginSquare.CFrame + Vector3.new(0, 10, 0)
            end
        end
    end
})

Tab7:Button({
    Title = "汽车传送到玩家旁边",
    Callback = function()
        local tp_player = game:GetService("Players")[bai.playernamedied]
        if tp_player then
            carTeleport(tp_player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0))
        end
    end
})

Tab7:Button({
    Title = "汽车传送到玩家基地",
    Callback = function()
        for i, v in pairs(game.Workspace.Properties:GetChildren()) do
            if v.Owner.Value == game.Players[bai.playernamedied] then
                carTeleport(v.OriginSquare.CFrame + Vector3.new(0, 10, 0))
            end
        end
    end
})

Tab7:Button({
    Title = "斧头杀人",
    Callback = function()
        local tool = getTool()
        if not tool then
            notify("小星", "你需要斧头", 4)
            return
        end
        local KillPlayer = bai.playernamedied
        local Player = gplr(KillPlayer)
        if Player[1] then
            Player = Player[1]
            local LocalPlayer = game.Players.LocalPlayer
            if LocalPlayer.Character.PrimaryPart ~= nil then
                local Character = LocalPlayer.Character
                local previous = LocalPlayer.Character.PrimaryPart.CFrame
                Character.Archivable = true
                local Clone = Character:Clone()
                LocalPlayer.Character = Clone
                wait(0.5)
                LocalPlayer.Character = Character
                wait(0.2)
                if LocalPlayer.Character and Player.Character and Player.Character.PrimaryPart ~= nil then
                    if LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):Destroy()
                    end
                    local Humanoid = Instance.new("Humanoid")
                    Humanoid.Parent = LocalPlayer.Character
                    local Tool = nil
                    if LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                        Tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    elseif LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChildOfClass("Tool") then
                        Tool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                    end
                    if Tool ~= nil then
                        Tool.Parent = LocalPlayer.Backpack
                        Player.Character.HumanoidRootPart.Anchored = true
                        local Arm = game.Players.LocalPlayer.Character['Right Arm'].CFrame * CFrame.new(0, -1, 0, 1, 0, 0, 0, 0, 1, 0, -1, 0)
                        Tool.Grip = Arm:ToObjectSpace(Player.Character.PrimaryPart.CFrame):Inverse()
                        Tool.Parent = LocalPlayer.Character
                        Workspace.CurrentCamera.CameraSubject = Tool.Handle
                        repeat
                            wait()
                        until not Tool or Tool and (Tool.Parent == Workspace or Tool.Parent == Player.Character)
                        Player.Character.HumanoidRootPart.Anchored = false
                        wait(0.1)
                        Humanoid.Health = 0
                        LocalPlayer.Character = nil
                    end
                end
                spawn(function()
                    LocalPlayer.CharacterAdded:Wait()
                    Player.Character.HumanoidRootPart.Anchored = false
                    if Player.Character.Humanoid.Health <= 15 then
                        notify("小星", "成功", 4)
                        repeat
                            wait()
                        until LocalPlayer.Character.PrimaryPart ~= nil
                        wait(0.4)
                        LocalPlayer.Character:SetPrimaryPartCFrame(previous)
                    end
                end)
            end
        end
    end
})

Tab7:Button({
    Title = "虚空搞人",
    Callback = function()
        local tool = getTool()
        if not tool then
            notify("小星", "你需要斧头", 4)
            return
        end
        Target = bai.playernamedied
        NOW = CFrame.new(9e9, 9e9, 9e9)
        game.Players.LocalPlayer.Character.Humanoid.Name = 1
        local l = game.Players.LocalPlayer.Character["1"]:Clone()
        l.Parent = game.Players.LocalPlayer.Character
        l.Name = "Humanoid"
        wait(0.1)
        game.Players.LocalPlayer.Character["1"]:Destroy()
        game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
        game.Players.LocalPlayer.Character.Animate.Disabled = true
        wait(1.1)
        game.Players.LocalPlayer.Character.Animate.Disabled = false
        game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType = "None"
        for i, v in pairs(game:GetService('Players').LocalPlayer.Backpack:GetChildren()) do
            if v.Name:sub(1, 4) == "Tool" then
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
            end
        end
        local function tp(player, player2)
            local char1, char2 = player.Character, player2.Character
            if char1 and char2 then
                char1.HumanoidRootPart.CFrame = char2.HumanoidRootPart.CFrame
            end
        end
        local function getout(player, player2)
            local char1, char2 = player.Character, player2.Character
            if char1 and char2 then
                char1:MoveTo(char2.Head.Position)
            end
        end
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = NOW
        wait(0.1)
        tp(game.Players[Target], game.Players.LocalPlayer)
        wait(0.1)
        tp(game.Players[Target], game.Players.LocalPlayer)
        wait(0.3)
        tp(game.Players[Target], game.Players.LocalPlayer)
        for i = 1, 20 do
            getout(game.Players.LocalPlayer, game.Players[Target])
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = NOW
        end
    end
})

Tab7:Toggle({
    Title = "查看玩家",
    Default = false,
    Callback = function(state)
        if state then
            game:GetService('Workspace').CurrentCamera.CameraSubject = game:GetService('Players'):FindFirstChild(bai.playernamedied).Character.Humanoid
        else
            game:GetService('Workspace').CurrentCamera.CameraSubject = lp.Character.Humanoid
        end
    end
})

Tab7:Toggle({
    Title = "查看玩家基地",
    Default = false,
    Callback = function(state)
        local see = nil
        for i, v in pairs(game.Workspace.Properties:GetChildren()) do
            if v.Owner.Value == game.Players[bai.playernamedied] then
                see = v.OriginSquare
            end
        end
        if state then
            if see == nil then
                notify("小星", "没有找到基地", 4)
                return
            end
            game:GetService('Workspace').CurrentCamera.CameraSubject = see
        else
            game:GetService('Workspace').CurrentCamera.CameraSubject = lp.Character.Humanoid
        end
    end
})

Tab8:Input({
    Title = "要说的话",
    Value = "",
    PlaceholderText = "填写内容",
    Callback = function(txt)
        bai.saymege = txt
    end
})

Tab8:Textbox({
    Title = "说话次数",
    Value = "1",
    PlaceholderText = "输入数字",
    Callback = function(txt)
        bai.saymount = txt
    end
})

Tab8:Button({
    Title = "说话",
    Callback = function()
        bai.sayfast = true
        for i = 1, bai.saymount do
            if bai.sayfast == true then
                game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents.SayMessageRequest:FireServer(bai.saymege, 'All')
            end
        end
    end
})

Tab8:Button({
    Title = "停止说话",
    Callback = function()
        bai.sayfast = false
    end
})

Tab8:Toggle({
    Title = "全自动说话",
    Default = false,
    Callback = function(state)
        if state then
            bai.autosay = true
            while task.wait() do
                if bai.autosay == true then
                    game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents.SayMessageRequest:FireServer(bai.saymege, 'All')
                end
            end
        else
            bai.autosay = false
        end
    end
})

Tab8:Button({
    Title = "获得4个小工具",
    Callback = function()
        if lp.Backpack:FindFirstChildOfClass('HopperBin') then
            return
        end
        for index = 1, 4 do
            Instance.new('HopperBin', lp.Backpack).BinType = index
        end
    end
})

Tab8:Button({
    Title = "获得小绿盒",
    Callback = function()
        local greenBox = game:GetService('Workspace')['Region_Volcano'].VolcanoWin
        firetouchinterest(greenBox, lp.Character.HumanoidRootPart, 0)
        firetouchinterest(greenBox, lp.Character.HumanoidRootPart, 1)
    end
})

Tab8:Button({
    Title = "重进服务器",
    Callback = function()
        game:GetService("TeleportService"):Teleport(13822889)
    end
})

Tab8:Button({
    Title = "生成上火山捷径",
    Callback = function()
        local Model = Instance.new("Model", game:GetService("Workspace"))
        Model.Name = "Lumber"
        local Part1 = Instance.new("Part", Model)
        Part1.Name = "Bridge"
        Part1.Reflectance = 0
        Part1.Transparency = 0
        Part1.Anchored = true
        Part1.Archivable = true
        Part1.CanCollide = true
        Part1.Locked = false
        Part1.BrickColor = BrickColor.new("Medium green")
        Part1.Material = Enum.Material.Fabric
        Part1.Position = Vector3.new(4380.8090820313, -11.749999046326, -101.56007385254)
        Part1.Size = Vector3.new(254.85998535156, 0.10000000149012, 1012.0200805664)
        Part1.Rotation = Vector3.new(0, 0, 0)
        local Part2 = Instance.new("Part", Model)
        Part2.Name = "Part"
        Part2.Reflectance = 0
        Part2.Transparency = 0
        Part2.Anchored = true
        Part2.Archivable = true
        Part2.CanCollide = true
        Part2.Locked = false
        Part2.BrickColor = BrickColor.new("Medium green")
        Part2.Material = Enum.Material.Fabric
        Part2.Position = Vector3.new(-1498.7203369141, 628.11077880859, 1146.8332519531)
        Part2.Size = Vector3.new(54.889999389648, 0.38999998569489, 46.719993591309)
        Part2.Rotation = Vector3.new(0, 30, 0)
        local Part3 = Instance.new("Part", Model)
        Part3.Name = "RoadVol"
        Part3.Reflectance = 0
        Part3.Transparency = 0
        Part3.Anchored = true
        Part3.Archivable = true
        Part3.CanCollide = true
        Part3.Locked = false
        Part3.BrickColor = BrickColor.new("Medium green")
        Part3.Material = Enum.Material.Fabric
        Part3.Position = Vector3.new(-604.03656005859, 301.07205200195, 637.69116210938)
        Part3.Size = Vector3.new(40, 0.20000000298023, 2030.8299560547)
        Part3.Rotation = Vector3.new(147.75, 55.680000305176, -152.4700012207)
        local WedgePart8 = Instance.new("WedgePart", Model)
        WedgePart8.Name = "UP"
        WedgePart8.Reflectance = 0
        WedgePart8.Transparency = 0
        WedgePart8.Anchored = true
        WedgePart8.Archivable = true
        WedgePart8.CanCollide = true
        WedgePart8.Locked = false
        WedgePart8.BrickColor = BrickColor.new("Beige")
        WedgePart8.Material = Enum.Material.Fabric
        WedgePart8.Position = Vector3.new(341.31372070313, -5.8850064277649, -772.25903320313)
        WedgePart8.Size = Vector3.new(65.220001220703, 11.829997062683, 159.52000427246)
        WedgePart8.Rotation = Vector3.new(0, -21.549999237061, 0)
        local WedgePart9 = Instance.new("WedgePart", Model)
        WedgePart9.Name = "UP2"
        WedgePart9.Reflectance = 0
        WedgePart9.Transparency = 0
        WedgePart9.Anchored = true
        WedgePart9.Archivable = true
        WedgePart9.CanCollide = true
        WedgePart9.Locked = false
        WedgePart9.BrickColor = BrickColor.new("Beige")
        WedgePart9.Material = Enum.Material.Fabric
        WedgePart9.Position = Vector3.new(384.87704467773, -5.8850121498108, -1050.4354248047)
        WedgePart9.Size = Vector3.new(65.220001220703, 11.829997062683, 155.8099822998)
        WedgePart9.Rotation = Vector3.new(180, -25.35000038147, 180)
        local WedgePart10 = Instance.new("WedgePart", Model)
        WedgePart10.Name = "Vol1"
        WedgePart10.Reflectance = 0
        WedgePart10.Transparency = 0
        WedgePart10.Anchored = true
        WedgePart10.Archivable = true
        WedgePart10.CanCollide = true
        WedgePart10.Locked = false
        WedgePart10.BrickColor = BrickColor.new("Medium green")
        WedgePart10.Material = Enum.Material.Fabric
        WedgePart10.Position = Vector3.new(-1133.5314941406, 499.67663574219, 943.49224853516)
        WedgePart10.Size = Vector3.new(39.729999542236, 10.650003433228, 823.29010009766)
        WedgePart10.Rotation = Vector3.new(-32.25, -55.680000305176, -27.529998779297)
        local WedgePart11 = Instance.new("WedgePart", Model)
        WedgePart11.Name = "Vol2"
        WedgePart11.Reflectance = 0
        WedgePart11.Transparency = 0
        WedgePart11.Anchored = true
        WedgePart11.Archivable = true
        WedgePart11.CanCollide = true
        WedgePart11.Locked = false
        WedgePart11.BrickColor = BrickColor.new("Medium green")
        WedgePart11.Material = Enum.Material.Fabric
        WedgePart11.Position = Vector3.new(-1526.9182128906, 623.2353515625, 1112.2694091797)
        WedgePart11.Size = Vector3.new(33.96000289917, 10.470000267029, 43.559997558594)
        WedgePart11.Rotation = Vector3.new(0, 32.899997711182, 0)
        local WedgePart12 = Instance.new("WedgePart", Model)
        WedgePart12.Name = "Wedge2"
        WedgePart12.Reflectance = 0
        WedgePart12.Transparency = 0
        WedgePart12.Anchored = true
        WedgePart12.Archivable = true
        WedgePart12.CanCollide = true
        WedgePart12.Locked = false
        WedgePart12.BrickColor = BrickColor.new("Medium green")
        WedgePart12.Material = Enum.Material.Fabric
        WedgePart12.Position = Vector3.new(-580.31176757813, 50.62678527832, -2443.0573730469)
        WedgePart12.Size = Vector3.new(58.749996185303, 1, 69.490005493164)
        WedgePart12.Rotation = Vector3.new(-179.08000183105, 14.309999465942, -178.72999572754)
        local WedgePart13 = Instance.new("WedgePart", Model)
        WedgePart13.Name = "Wedge"
        WedgePart13.Reflectance = 0
        WedgePart13.Transparency = 0
        WedgePart13.Anchored = true
        WedgePart13.Archivable = true
        WedgePart13.CanCollide = true
        WedgePart13.Locked = false
        WedgePart13.BrickColor = BrickColor.new("Medium green")
        WedgePart13.Material = Enum.Material.Fabric
        WedgePart13.Position = Vector3.new(-554.13073730469, 37.368190765381, -2545.1484375)
        WedgePart13.Size = Vector3.new(59.18998336792, 30.919998168945, 140.86001586914)
        WedgePart13.Rotation = Vector3.new(0.91999995708466, -14.309999465942, -1.2699999809265)
        local Part14 = Instance.new("Part", Model)
        Part14.Name = "Wall"
        Part14.Reflectance = 0
        Part14.Transparency = 0.60000002384186
        Part14.Anchored = false
        Part14.Archivable = true
        Part14.CanCollide = true
        Part14.Locked = false
        Part14.BrickColor = BrickColor.new("Medium stone grey")
        Part14.Material = Enum.Material.Fabric
        Part14.Position = Vector3.new(-1522.0369873047, 632.79083251953, 1160.2779541016)
        Part14.Size = Vector3.new(46.590003967285, 8.9700002670288, 1.0400000810623)
        Part14.Rotation = Vector3.new(-180, 60, -180)
        local Part15 = Instance.new("Part", Model)
        Part15.Name = "Fence2"
        Part15.Reflectance = 0
        Part15.Transparency = 0.5
        Part15.Anchored = true
        Part15.Archivable = true
        Part15.CanCollide = true
        Part15.Locked = false
        Part15.BrickColor = BrickColor.new("Beige")
        Part15.Material = Enum.Material.Fabric
        Part15.Position = Vector3.new(-620.37908935547, 319.05871582031, 669.19006347656)
        Part15.Size = Vector3.new(2037.669921875, 16.129999160767, 2)
        Part15.Rotation = Vector3.new(0.0099999997764826, 30, -17.510000228882)
        local Part16 = Instance.new("Part", Model)
        Part16.Name = "Fence"
        Part16.Reflectance = 0
        Part16.Transparency = 0.5
        Part16.Anchored = true
        Part16.Archivable = true
        Part16.CanCollide = true
        Part16.Locked = false
        Part16.BrickColor = BrickColor.new("Beige")
        Part16.Material = Enum.Material.Fabric
        Part16.Position = Vector3.new(-639.38134765625, 319.06237792969, 636.27484130859)
        Part16.Size = Vector3.new(2037.669921875, 16.129999160767, 2)
        Part16.Rotation = Vector3.new(0.0099999997764826, 30, -17.510000228882)
        wait(4.6)
    end
})

Tab8:Button({
    Title = "沼泽捷径",
    Callback = function()
        local part = Instance.new("Part", workspace)
        part.CFrame = CFrame.new(-499.196075, 155.460663, -166.186081, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        part.Size = Vector3.new(295.87, 1, 40.14)
        local part2 = Instance.new("Part", workspace)
        part2.CFrame = CFrame.new(-53.5482712, 75.8732529, -166.035767, 0.965925813, 0.258819044, 0, -0.258819044, 0.965925813, 0, 0, 0, 1)
        part2.Size = Vector3.new(617.23, 0.72, 40)
        part2.Rotation = Vector3.new(0, 0, -15)
        part.BrickColor = BrickColor.new(255, 255, 255)
        part.Material = Enum.Material.DiamondPlate
        part.Anchored = true
        part2.BrickColor = BrickColor.new(255, 255, 255)
        part2.Material = Enum.Material.DiamondPlate
        part2.Anchored = true
    end
})

Tab8:Button({
    Title = "黄金木捷径",
    Callback = function()
        local f0 = Instance.new("Folder", workspace)
        f0.Name = "SGlowPath"
        local part = Instance.new("Part", f0)
        part.CFrame = CFrame.new(8.54199982, -0.914913177, -812.122375, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        part.Size = Vector3.new(55, 1, 186)
        local part = Instance.new("Part", f0)
        part.CFrame = CFrame.new(-309.958008, -0.834023476, -879.710388, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        part.Size = Vector3.new(582, 1, 50)
        local part = Instance.new("Part", f0)
        part.CFrame = CFrame.new(-606.630554, -0.843258381, -748.689453, 0.965925813, 0, -0.258819044, 0, 1, 0, 0.258819044, 0, 0.965925813)
        part.Size = Vector3.new(47, 1, 246)
        part.Rotation = Vector3.new(0, -15, 0)
        local part = Instance.new("Part", f0)
        part.CFrame = CFrame.new(-763.458679, -0.723966122, -652.31958, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        part.Size = Vector3.new(227, 1, 38)
        local part = Instance.new("Part", f0)
        part.CFrame = CFrame.new(-842.989868, -0.602809906, -713.690918, 0.965925872, 0, -0.258818835, 0, 1, 0, 0.258818835, 0, 0.965925872)
        part.Size = Vector3.new(43, 1, 108)
        part.Rotation = Vector3.new(0, -15, 0)
        local part = Instance.new("Part", f0)
        part.CFrame = CFrame.new(-775.692932, -0.588047981, -815.868713, 0.707106829, 0, -0.707106769, 0, 1, 0, 0.707106769, 0, 0.707106829)
        part.Size = Vector3.new(42, 1, 170)
        part.Rotation = Vector3.new(0, -45, 0)
        local part = Instance.new("Part", f0)
        part.CFrame = CFrame.new(-728.159668, -0.591278076, -952.04364, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        part.Size = Vector3.new(55, 1, 182)
        local part = Instance.new("Part", f0)
        part.CFrame = CFrame.new(-864.098999, -0.257263005, -985.877014, 0.965925872, 0, 0.258818835, 0, 1, 0, -0.258818835, 0, 0.965925872)
        part.Size = Vector3.new(235, 1, 56)
        part.Rotation = Vector3.new(0, 15, 0)
        local part = Instance.new("Part", f0)
        part.CFrame = CFrame.new(-1015.87311, -11.1293316, -945.632751, 0.933012664, -0.258819044, 0.25, 0.267445326, 0.963572919, -0.000555455685, -0.240749463, 0.0673795789, 0.968245745)
        part.Size = Vector3.new(82, 1, 55)
        part.Rotation = Vector3.new(0.03, 14.48, 15.51)
        for J, v in pairs(f0:children()) do
            v.BrickColor = BrickColor.new(255, 255, 255)
            v.Material = Enum.Material.DiamondPlate
            v.Anchored = true
        end
    end
})

Tab8:Button({
    Title = "冰木捷径",
    Callback = function()
        local f0 = Instance.new("Folder", workspace)
        f0.Name = "FrostPath"
        local part = Instance.new("Part", f0)
        part.CFrame = CFrame.new(744.516663, 71.5780411, 861.148438, 1, -1.04308164e-07, -1.78813934e-07, 1.47034342e-07, 0.965925932, 0.258818656, 1.45724101e-07, -0.258818656, 0.965925932)
        part.Size = Vector3.new(40, 1, 202)
        part.Rotation = Vector3.new(-15, 0, 0)
        local part = Instance.new("Part", f0)
        part.CFrame = CFrame.new(744.273, 97.5341, 1003.82)
        part.Size = Vector3.new(41, 1, 90)
        local part = Instance.new("Part", f0)
        part.CFrame = CFrame.new(775.181458, 100.246162, 1027.58276, 0.965925813, -0.258819044, 0, 0.258819044, 0.965925813, 0, 0, 0, 1)
        part.Size = Vector3.new(46, 1, 43)
        part.Rotation = Vector3.new(0, 0, 15)
        local part = Instance.new("Part", f0)
        part.CFrame = CFrame.new(815.776672, 106.550224, 1027.4032, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        part.Size = Vector3.new(38, 1, 42)
        local part = Instance.new("Part", f0)
        part.CFrame = CFrame.new(815.849976, 257.424072, 1608.79456, 1, 0, 0, 0, 0.965925813, 0.258819044, 0, -0.258819044, 0.965925813)
        part.Size = Vector3.new(38, 1, 1164)
        part.Rotation = Vector3.new(-15, 0, 0)
        local part = Instance.new("Part", f0)
        part.CFrame = CFrame.new(900.612122, 407.759827, 2194.72363, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        part.Size = Vector3.new(208, 1, 50)
        local part = Instance.new("Part", f0)
        part.CFrame = CFrame.new(1268.40649, 407.26062, 2798.83594, 0.91354543, 0, 0.406736642, 0, 1, 0, -0.406736642, 0, 0.91354543)
        part.Size = Vector3.new(41, 2, 1364)
        part.Rotation = Vector3.new(0, 24, 0)
        for J, v in pairs(f0:children()) do
            v.BrickColor = BrickColor.new(255, 255, 255)
            v.Material = Enum.Material.DiamondPlate
            v.Anchored = true
        end
    end
})

Tab8:Button({
    Title = "更简单的砍幻影",
    Callback = function()
        local yellow1 = Instance.new("Part", workspace)
        yellow1.Name = "Lol Truck There Easy"
        yellow1.Position = Vector3.new(-5.915, -217, -1250.256)
        yellow1.Size = Vector3.new(1207.06, 1, 1160.09)
        yellow1.BrickColor = BrickColor.Random()
        yellow1.Anchored = true
        yellow1.CanCollide = true
    end
})

Tab8:Button({
    Title = "生成去椰子岛的捷径",
    Callback = function()
        local palm1 = Instance.new("Part", workspace)
        palm1.Name = "K Truck's Goin' There"
        palm1.Position = Vector3.new(1753.475, -10, -45.351)
        palm1.Size = Vector3.new(1600, 1, 50)
        palm1.BrickColor = BrickColor.Random()
        palm1.Anchored = true
        palm1.CanCollide = true
    end
})

Tab8:Button({
    Title = "拿出可口可乐",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/BEgB0gEJ', true))()
    end
})

Tab8:Button({
    Title = "变成警察",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/8wB54iNk', true))()
    end
})

Tab8:Button({
    Title = "出现悬浮板",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/MrfVCM9y', true))()
    end
})

Tab8:Button({
    Title = "托马斯小火车",
    Callback = function()
        loadstring(game:HttpGet(('http://pastebin.com/raw/tMr759X7'), true))()
    end
})

Tab8:Button({
    Title = "圆球",
    Callback = function()
        loadstring(game:HttpGet(('https://pastebin.com/raw/ZFSTSi9B'), true))()
    end
})

Tab8:Button({
    Title = "喷漆",
    Callback = function()
        loadstring(game:HttpGet(('http://pastebin.com/raw/raYkCjyy'), true))()
    end
})

Tab8:Button({
    Title = "删除树/木板工具",
    Callback = function()
        local a = game:GetService("ReplicatedStorage")
        local b = game:GetService("Players").LocalPlayer
        local c = b:GetMouse()
        local f = Instance.new("Tool", b.Backpack)
        f.Name = "点击你要删除的树或木板"
        f.RequiresHandle = false
        f.Activated:Connect(function()
            local g = c.Target.Parent
            local h = b.Character.HumanoidRootPart.CFrame
            if not g:FindFirstChild("WoodSection") then
                return
            end
            local i
            if g:FindFirstChild("Owner") and g.Owner.Value == b or g.Owner.Value == nil then
                if not g:FindFirstChild("RootCut") and g.Parent.Name == "TreeRegion" then
                    for e, j in next, g:children() do
                        if j.Name == "WoodSection" and j:FindFirstChild("ID") and j:FindFirstChild("ID").Value == tonumber(1) then
                            i = j
                        end
                    end
                else
                    i = g.WoodSection
                end
                tp(i.CFrame)
                for e = 1, 3 do
                    spawn(function()
                        for e = 1, 20 do
                            a.Interaction.ClientIsDragging:FireServer(g)
                            a.Interaction.DestroyStructure:FireServer(g)
                            game:GetService('RunService').Stepped:wait()
                        end
                    end)
                    task.wait(.1)
                end
            else
                return
            end
            task.wait()
            tp(h)
        end)
        f.Parent = game.Players.LocalPlayer.Backpack
    end
})

Tab8:Button({
    Title = "远程打开东西",
    Callback = function()
        notify('小星', '选择一个东西去打开', 4)
        bai.openItem = mouse.Button1Down:Connect(function()
            if mouse.Target then
                bai.itemtoopen = mouse.Target
            end
            OpenSelectedItem(bai.itemtoopen.Parent)
        end)
    end
})

Tab8:Button({
    Title = "关闭远程打开",
    Callback = function()
        if bai.openItem then
            bai.openItem:Disconnect()
            bai.openItem = nil
        end
        notify('小星', '打开东西已关闭', 4)
        bai.itemToOpen = nil
    end
})

Tab8:Button({
    Title = "设置传送点",
    Callback = function()
        pcall(function()
            game.Workspace.baiBasedropCord:Destroy()
            bai.itemset = nil
        end)
        local baiBasedropCord = Instance.new("Part", game.Workspace)
        baiBasedropCord.CanCollide = false
        baiBasedropCord.Anchored = true
        baiBasedropCord.Shape = Enum.PartType.Ball
        baiBasedropCord.Color = Color3.fromRGB(0, 217, 255)
        baiBasedropCord.Transparency = 0
        baiBasedropCord.Size = Vector3.new(2, 2, 2)
        baiBasedropCord.CFrame = lp.Character.HumanoidRootPart.CFrame
        baiBasedropCord.Material = Enum.Material.Marble
        baiBasedropCord.Name = "baiBasedropCord"
        bai.itemset = lp.Character.HumanoidRootPart.CFrame
    end
})

Tab8:Button({
    Title = "删除传送点",
    Callback = function()
        pcall(function()
            game.Workspace.baiBasedropCord:Destroy()
            bai.itemset = nil
        end)
    end
})

Tab8:Button({
    Title = "获得传送物品工具",
    Callback = function()
        if bai.itemset == nil then
            notify("小星", "请你放传送点", 4)
            return
        end
        local Tool = Instance.new("Tool", game:GetService("Players").LocalPlayer.Backpack)
        Tool.Name = "点击你想要传送的物品"
        Tool.RequiresHandle = false
        Tool.Activated:connect(function()
            bai.cskais = true
            if mouse.Target.Parent:FindFirstChild("PurchasedBoxItemName") then
                bai.dxmz = (mouse.Target.Parent.PurchasedBoxItemName.Value)
            elseif mouse.Target.Parent:FindFirstChild("ItemName") then
                bai.dxmz = (mouse.Target.Parent.ItemName.Value)
            end
            for _, v in next, workspace.PlayerModels:children() do
                local check = v:FindFirstChild('ItemName') or v:FindFirstChild('PurchasedBoxItemName')
                local check2 = v:FindFirstChild('Type')
                local main
                if bai.cskais == true then
                    if check and check.Value == bai.dxmz and v:FindFirstChild('Owner') and tostring(v.Owner.Value) == bai.cswjia or check2 and check2.Value == bai.dxmz and v:FindFirstChild('Owner') and tostring(v.Owner.Value) == bai.cswjia then
                        local main = v:FindFirstChild('Main')
                        if (lp.Character.HumanoidRootPart.CFrame.p - main.CFrame.p).magnitude > 5 then
                            tp(v.Main.CFrame + Vector3.new(4, 0, 4))
                        end
                        for e = 1, 20 do
                            game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(v)
                            v.Main.CFrame = bai.itemset
                            game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(v)
                            game:GetService('RunService').Stepped:wait()
                        end
                    end
                end
            end
        end)
        Tool.Parent = game.Players.LocalPlayer.Backpack
    end
})

Tab8:Textbox({
    Title = "x轴",
    Value = "1",
    PlaceholderText = "输入数字",
    Callback = function(txt)
        bai.zix = txt
    end
})

Tab8:Textbox({
    Title = "z轴",
    Value = "3",
    PlaceholderText = "输入数字",
    Callback = function(txt)
        bai.zlz = txt
    end
})

Tab8:Button({
    Title = "获取整理工具",
    Callback = function()
        Identify = Instance.new("Tool")
        Identify.RequiresHandle = false
        Identify.Name = "点击要整理的物品"
        Identify.Activated:connect(function()
            local Player = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 4, 0)
            local Items = {}
            if mouse.Target.Parent:FindFirstChild("PurchasedBoxItemName") then
                bai.dxmz = (mouse.Target.Parent.PurchasedBoxItemName.Value)
                function ItemStacker(ItemType, XAxis, ZAxis)
                    for i, v in pairs(game:GetService("Workspace").PlayerModels:GetChildren()) do
                        if v:FindFirstChild("Owner") and tostring(v.Owner.Value) == bai.zlwjia then
                            if v:FindFirstChild("PurchasedBoxItemName") and tostring(v.PurchasedBoxItemName.Value) == ItemType then
                                table.insert(Items, v)
                            end
                        end
                    end
                    local Count = 0
                    for Y = 1, math.ceil(#Items / (XAxis * ZAxis)) do
                        for X = 1, XAxis do
                            for Z = 1, ZAxis do
                                Count = Count + 1
                                tp(Items[Count].Main.CFrame + Vector3.new(3, 0, 3))
                                for e = 1, 40 do
                                    game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(Items[Count])
                                    Items[Count].Main.CFrame = CFrame.new(X * Items[1].Main.Size.X, Y * Items[1].Main.Size.Y, Z * Items[1].Main.Size.Z) + Player
                                    game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(Items[Count])
                                    game:GetService('RunService').Stepped:wait()
                                end
                            end
                        end
                    end
                end
                ItemStacker(bai.dxmz, bai.zlz, bai.zix)
                notify('', '' .. mouse.Target.Parent.PurchasedBoxItemName.Value, 5)
            elseif mouse.Target.Parent:FindFirstChild("ItemName") then
                bai.dxmz = (mouse.Target.Parent.ItemName.Value)
                local Player = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 5.5, 0)
                function ItemStackerft(ItemType, XAxis, ZAxis)
                    for i, v in pairs(game:GetService("Workspace").PlayerModels:GetChildren()) do
                        if v:FindFirstChild("Owner") and tostring(v.Owner.Value) == bai.zlwjia then
                            if (v:FindFirstChild('DraggableItem') and tostring(v.DraggableItem.Parent) == ItemType) then
                                table.insert(Items, v)
                            end
                        end
                    end
                    local Count = 0
                    for Y = 1, math.ceil(#Items / (XAxis * ZAxis)) do
                        for X = 1, XAxis do
                            for Z = 1, ZAxis do
                                Count = Count + 1
                                tp(Items[Count].Main.CFrame + Vector3.new(3, 0, 3))
                                for e = 1, 40 do
                                    game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(Items[Count])
                                    Items[Count].Main.CFrame = CFrame.new(X * Items[1].Main.Size.X, Y * Items[1].Main.Size.Y, Z * Items[1].Main.Size.Z) + Player
                                    game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(Items[Count])
                                    game:GetService('RunService').Stepped:wait()
                                end
                            end
                        end
                    end
                end
                ItemStackerft(bai.dxmz, bai.zlz, bai.zix)
                notify('', '' .. mouse.Target.Parent.ItemName.Value, 5)
            end
        end)
        Identify.Parent = game.Players.LocalPlayer.Backpack
    end
})

Tab8:Button({
    Title = "刷粉车-获得选择工具",
    Callback = function()
        Identify = Instance.new("Tool")
        Identify.RequiresHandle = false
        Identify.Name = "点击汽车重生垫"
        Identify.Parent = game.Players.LocalPlayer.Backpack
        Identify.Activated:connect(function()
            if Mouse.Target and Mouse.Target.Parent.Type and Mouse.Target.Parent.Type.Value == "Vehicle Spot" then
                if not Mouse.Target.Parent:FindFirstChild("SelectionBox") then
                    bai.car = Mouse.Target.Parent:FindFirstChild("ButtonRemote_SpawnButton", true)
                    local SB = Instance.new("SelectionBox", Mouse.Target.Parent)
                    SB.Adornee = Mouse.Target.Parent
                else
                    Mouse.Target.Parent.SelectionBox:Destroy()
                end
                notify("小星", "汽车已选择", 4)
            end
        end)
    end
})

Tab8:Button({
    Title = "刷粉车-开始",
    Callback = function()
        local C = nil
        local FP = nil
        bai.stopcar = false
        local a = game:GetService("Workspace").PlayerModels.ChildAdded:connect(function(v)
            v:WaitForChild("Owner")
            if v:WaitForChild("PaintParts") then
                FP = v.PaintParts.Part
            end
        end)
        if bai.car ~= nil then
            repeat
                task.wait(0.45)
                Press(bai.car)
                repeat
                    wait()
                until FP ~= C
                C = FP
            until FP.BrickColor.Name == "Hot pink" or bai.stopcar == true
            a:Disconnect()
            a = nil
        else
            notify("小星", "你暂时没有选择汽车", 4)
        end
    end
})

Tab8:Button({
    Title = "刷粉车-停止",
    Callback = function()
        bai.stopcar = true
        bai.car = nil
        for i, v in next, game:GetService("Workspace").PlayerModels:GetChildren() do
            if v:FindFirstChild("SelectionBox") and v:FindFirstChild("ButtonRemote_SpawnButton", true) then
                v.SelectionBox:Destroy()
            end
        end
    end
})

notify("小星", "脚本加载完成！", 3)