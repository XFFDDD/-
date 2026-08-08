--!nocheck
-- Functional reconstruction of Pastefy 3hjx6RH3 (GoofyScator V9).
-- Names are normalized to v<number>. See RECOVERY.md for fidelity notes.

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Workspace")
local v4 = v1.LocalPlayer
local v5 = "https://raw.githubusercontent.com/WasKKal/WasUI-For-Roblox/main/WasUI.lua"
local v6 = loadstring(game:HttpGet(v5))()
local v7 = v2:WaitForChild("Shared"):WaitForChild("Warp")
    :WaitForChild("Index"):WaitForChild("Event"):WaitForChild("Reliable")

local v8 = {
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

local v9 = false
local v10 = nil
local v11 = v8[1]

local function v12(v13, v14, v15)
    v6:Notify({Title = v13 or "TrashHub", Content = v14 or "", Duration = v15 or 3})
end

-- The trace proves this remote path and FireServer use. GoofyScator's original
-- Warp serializer generated binary buffers at runtime; its exact event names
-- and all typed writes were not exposed. Keep the protocol boundary isolated.
local function v13(v14, ...)
    local v15 = table.pack(...)
    return pcall(function()
        v7:FireServer(v14, table.unpack(v15, 1, v15.n))
    end)
end

local function v14()
    local v15 = v3:FindFirstChild("Gameplay")
    local v16 = v15 and v15:FindFirstChild("Plots")
    if not v16 then return nil end

    local v17 = v4.Character
    local v18 = v17 and v17:FindFirstChild("HumanoidRootPart")
    local v19, v20 = nil, math.huge
    for _, v21 in ipairs(v16:GetChildren()) do
        local v22 = v21:FindFirstChild("PlotLogic")
        local v23 = v22 and v22:FindFirstChild("ContainerHolder")
        if v23 then
            local v24 = v21:FindFirstChildWhichIsA("BasePart", true)
            local v25 = v18 and v24 and (v24.Position - v18.Position).Magnitude or 0
            if v25 < v20 then v19, v20 = v21, v25 end
        end
    end
    return v19
end

local function v15()
    local v16 = v14()
    local v17 = v16 and v16:FindFirstChild("PlotLogic")
    return v17 and v17:FindFirstChild("ContainerHolder")
end

local function v16()
    local v17 = v15()
    local v18 = {}
    if not v17 then return v18 end
    for _, v19 in ipairs(v17:GetChildren()) do
        if string.sub(v19.Name, 1, 10) == "CONTAINER_" then
            v18[#v18 + 1] = v19
        end
    end
    return v18
end

local function v17(v18)
    local v19 = 0
    for _ = 1, tonumber(v18) or 1 do
        if v13("PurchaseContainer", v11) then v19 += 1 end
        task.wait(0.1)
    end
    v12("购买", string.format("已购买 %d 个 %s", v19, v11))
    return v19
end

local function v18()
    local v19 = 0
    for _, v20 in ipairs(v16()) do
        -- An auxiliary buffer.fromstring("K") was observed here.
        if v13("OpenContainer", v20, buffer.fromstring("K")) then v19 += 1 end
        task.wait(0.1)
    end
    v12("开箱", string.format("已开启 %d 个箱子", v19))
    return v19
end

local function v19()
    local v20 = v14()
    local v21 = v20 and v20:FindFirstChild("ItemCache", true)
    local v22, v23 = 0, 0
    if v21 then
        for _, v24 in ipairs(v21:GetChildren()) do
            if v13("PickupItem", v24) then v22 += 1 else v23 += 1 end
            task.wait(0.05)
        end
    end
    v12("拾取完成", string.format("拾取 %d 件，跳过 %d 件", v22, v23))
    return v22, v23
end

local function v20()
    local v21 = v4.Character
    local v22 = v21 and v21:FindFirstChild("HumanoidRootPart")
    local v23 = v14()
    local v24 = v23 and v23:FindFirstChild("PlotDecor")
    local v25 = v24 and v24:FindFirstChild("House")
    local v26 = v25 and v25:FindFirstChild("Part", true)
    if v22 and v26 and v26:IsA("BasePart") then
        v22.CFrame = v26.CFrame + Vector3.new(0, 1.5, 0)
    end
    v13("DropAllItems")
    v12("丢弃", "已传送并丢弃所有物品")
end

local function v21()
    if v9 or v10 then return end
    v9 = true
    v10 = task.spawn(function()
        while v9 do
            v17(8)
            if not v9 then break end
            v18()
            if not v9 then break end
            v19()
            if not v9 then break end
            v20()
            task.wait(0.1)
        end
        v10 = nil
    end)
    v12("TrashHub", "已开启")
end

local function v22()
    v9 = false
    if v10 then task.cancel(v10); v10 = nil end
    v12("TrashHub", "已停止")
end

local v23 = v6:CreateWindow("TrashHub-集装箱RNG")
v23:SetWelcome("欢迎使用TrashHub")
local v24 = v23:AddTab("自动循环")
local v25 = v23:AddTab("手动操作")

v6:CreateDropdown(v24, "容器类型", v8, v11, function(v26) v11 = v26 end, false, "container_auto")
v6:CreateToggle(v24, false, function(v26) if v26 then v21() else v22() end end,
    "开启自动循环", nil, "auto_toggle")
v6:CreateDropdown(v25, "容器类型", v8, v11, function(v26) v11 = v26 end, false, "container_manual")
v6:CreateButton(v25, "购买指定箱子", function() v17(8) end)
v6:CreateButton(v25, "开启所有箱子", v18)
v6:CreateButton(v25, "拾取所有物品", v19)
v6:CreateButton(v25, "丢弃所有物品", v20)
v12("TrashHub", "加载完成", 3)

return {buy = v17, openAll = v18, pickupAll = v19, dropAll = v20,
    start = v21, stop = v22, containers = v8}
