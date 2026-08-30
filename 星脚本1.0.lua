local startTime = tick()  

local run = function(func) func() end

run(function()
    _G.MetatableConfig = {
        playersService = game:GetService("Players"),
        mt = getrawmetatable(game),
        oldIndex = nil,
        oldNamecall = nil
    }
end)

run(function()
    local config = _G.MetatableConfig
    local mt = config.mt
    local oldIndex = mt.__index
    
    setreadonly(mt, false)
    
    mt.__index = function(s, k)
        if s == game and k == "Players" then
            return config.playersService
        end
        if type(oldIndex) == "table" then
            return oldIndex[k]
        elseif type(oldIndex) == "function" then
            return oldIndex(s, k)
        end
    end
    
    setreadonly(mt, true)
end)

run(function()
    local config = _G.MetatableConfig
    local mt = config.mt
    local oldNamecall = mt.__namecall
    
    setreadonly(mt, false)
    
    mt.__namecall = function(self, ...)
        local method = getnamecallmethod()
        
        if method == "FireServer" then
        end
        
        if type(oldNamecall) == "function" then
            return oldNamecall(self, ...)
        elseif type(oldNamecall) == "table" then
            return oldNamecall[method](self, ...)
        end
    end
    
    setreadonly(mt, true)
end)

run(function()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    
    local oldNamecall = mt.__namecall
    mt.__namecall = function(self, ...)
        local method = getnamecallmethod()
        
        if method == "checkcaller" then
            return false  
        end
        
        return oldNamecall(self, ...)
    end
    
    if checkcaller then
        _G.checkcaller = function() return false end
    end
    
    setreadonly(mt, true)
end)

run(function()
    local original_getrawmetatable = getrawmetatable
    local clean_mt = getrawmetatable(game)  
    
    getrawmetatable = function(obj)
        if obj == game then
            return clean_mt  
        end
        return original_getrawmetatable(obj)
    end
end)

local XPHUBNotification = loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/refs/heads/main/Roblox-Pi-Script-Notification.lua"))()

XPHUBNotification:Notification({
    Title = "星脚本",
    Text = "欢迎使用星脚本 \n作者: 小星 帮助者: 小皮",
    Icon = "rbxassetid://136169594232359",
    Duration = 4
})
wait(1.5)
XPHUBNotification:Notification({
    Title = "星脚本",
    Text = "星脚本2026.8.8诞生",
    Icon = "rbxassetid://136169594232359",
    Duration = 4
})
wait(1.5)
XPHUBNotification:Notification({
    Title = "星脚本",
    Text = "星脚本是永久免费的禁止倒卖并且持续更新中 更新速度比较缓慢 请见谅",
    Icon = "rbxassetid://136169594232359",
    Duration = 4
})
wait(1.5)
----------------分割线--------------
local vu = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:connect(function()
		   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		   wait(1)
		   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)
--------------分割线--------------------------	
XPHUBNotification:Notification({
    Title = "星脚本",
    Text = "已自动开启防挂机 感谢您使用星脚本 祝您使用愉快 玩的开心",
    Icon = "rbxassetid://136169594232359",
    Duration = 4
})
--------------分割线-----------------------------
--通知
function Notify(top, text, ico, dur)
  game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = top,
    Text = text,
    Icon = ico,
    Duration = dur,
  })
end
--------------分割线-----------------------------
-- ========== [迁移] 替换为新版 UI 库 (black ui) ==========
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/sharksharksharkshark/-/main/black%20ui.txt"))()

local success, Window = pcall(function()
    return library:CreateWindow("星脚本", "精简版 2.0", 136169594232359)
end)
if not success or not Window then
    XPHUBNotification:Notification({
        Title = "星脚本", Text = "新版UI加载失败",
        Icon = "rbxassetid://136169594232359", Duration = 3
    })
    return
end

-- ================== UI 适配器 ==================
local UI = {}
UI.__sections = {}

local _mainTab = nil

function UI:CreateTab(window, name, icon)
    if not _mainTab then
        _mainTab = window:CreateTab(name)
    end
    local Tab = _mainTab
    local page = Tab:CreateFrame(name)
    page.Visible = false
    local tabObj = { Window = window, Tab = Tab, _page = page, _els = {} }
    setmetatable(tabObj, { __index = UI })
    return tabObj
end

function UI:section(name, defaultOpen)
    local handle = { _page = self._page, _tab = self, _els = {} }
    UI.__sections[name] = handle
    setmetatable(handle, { __index = UI })
    return handle
end

function UI:Label(text)
    local el = self._page:CreateLabel(text)
    self._els[text] = el
    return el
end

function UI:Button(name, a, b)
    local desc, cb
    if type(a) == "function" then cb = a else desc = a; cb = b end
    cb = cb or function() end
    return self._page:CreateButton(name, desc or "", cb)
end

function UI:Toggle(name, flag, default, cb)
    if type(default) ~= "boolean" then
        cb = flag; default = false
    end
    cb = cb or function() end
    local tgl = self._page:CreateToggle(name, "", function(v) cb(v) end)
    return tgl
end

function UI:Slider(name, flag, def, min, max, prec, cb)
    cb = cb or function() end
    local sld = self._page:CreateSlider(name, min or 0, max or 100, function(v) cb(v) end)
    return sld
end

function UI:Textbox(name, flag, placeholder, cb)
    cb = cb or function() end
    return self._page:CreateBox(placeholder or name, "Submit", function(v) cb(v) end)
end

function UI:Bind(name, defaultKey, cb)
    cb = cb or function() end
    return self._page:CreateBind(name, tostring(defaultKey or "Unknown"), function(v) cb(v) end)
end
UI.Keybind = UI.Bind

function UI:Dropdown(name, flag, options, cb)
    cb = cb or function() end
    self._page:CreateLabel("▼ " .. name)
    local opts = (type(options) == "table") and options or {}
    local current = opts[1]
    local valLabel = self._page:CreateLabel("当前: " .. tostring(current or "未选择"))
    local function upd()
        pcall(function() valLabel:UpdateLabel("当前: " .. tostring(current)) end)
    end
    for _, opt in ipairs(opts) do
        self._page:CreateButton(tostring(opt), "", function()
            current = opt
            upd()
            cb(opt)
        end)
    end
    local handle = {
        Get = function() return current end,
        Set = function(v) current = v; upd(); cb(v) end,
        SetValue = function(v) current = v; upd() end,
    }
    self._els[name] = handle
    return handle
end

function UI:ColorPicker(name, flag, default, cb)
    cb = cb or function() end
    return self._page:CreateColorPicker(name, function(col) cb(col) end)
end

UI.run = function(func) func() end
local run = UI.run


-- ============================================================
-- Tab 1: 信息
-- ============================================================
local PIJIAOBEN = UI:CreateTab(Window, "信息", "136169594232359")

local about = PIJIAOBEN:section("用户信息", true)

run(function()
    _G.UserInfoConfig = {
        dataFetched = {
            displayName = false, userName = false, userId = false,
            clientId = false, region = false, language = false,
            accountAge = false, executor = false, gameId = false,
            placeId = false, totalPlayers = false, ping = false,
            fps = false, xpTime = false
        }
    }
end)

run(function()
    _G.UserInfoServices = {
        Players = game:GetService("Players"),
        LocalPlayer = game:GetService("Players").LocalPlayer,
        RbxAnalyticsService = game:GetService("RbxAnalyticsService"),
        LocalizationService = game:GetService("LocalizationService"),
        RunService = game:GetService("RunService"),
        Stats = game:GetService("Stats")
    }
end)

run(function()
    _G.UserInfoLabels = {
        displayName = about:Label("您的用户昵称: 暂无数据"),
        userName = about:Label("您的用户名: 暂无数据"),
        userId = about:Label("您的用户ID: 暂无数据"),
        clientId = about:Label("您的客户端ID: 暂无数据"),
        region = about:Label("您的地区: 暂无数据"),
        language = about:Label("您的语言: 暂无数据"),
        accountAgeDays = about:Label("您的账户年龄(天): 暂无数据"),
        accountAgeYears = about:Label("您的账户年龄(年): 暂无数据"),
        executor = about:Label("您使用的注入器: 暂无数据"),
        gameId = about:Label("您当前服务器的ID: 暂无数据"),
        placeId = about:Label("您当前的服务器位置ID: 暂无数据"),
        totalPlayers = about:Label("当前服务器总人数: 0"),
        ping = about:Label("您的Ping: 0"),
        fps = about:Label("您的FPS: 0"),
        xpTime = about:Label("XP时间: 00:00:00")
    }
end)

run(function()
    local Players = _G.UserInfoServices.Players
    local LocalPlayer = _G.UserInfoServices.LocalPlayer
    local RbxAnalyticsService = _G.UserInfoServices.RbxAnalyticsService
    local LocalizationService = _G.UserInfoServices.LocalizationService
    local RunService = _G.UserInfoServices.RunService
    local Stats = _G.UserInfoServices.Stats
    local labels = _G.UserInfoLabels
    local dataFetched = _G.UserInfoConfig.dataFetched
    
    local function updateTotalPlayerCount()
        local total = #Players:GetPlayers()
        if labels.totalPlayers then
            labels.totalPlayers.Text = "当前服务器总人数: " .. total
        end
        dataFetched.totalPlayers = true
        return total
    end
    
    Players.PlayerAdded:Connect(updateTotalPlayerCount)
    Players.PlayerRemoving:Connect(updateTotalPlayerCount)
    updateTotalPlayerCount()
    
    local lastTime = os.clock()
    local colors = {
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(255, 127, 0),
        Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(0, 255, 0),
        Color3.fromRGB(0, 0, 255),
        Color3.fromRGB(75, 0, 130),
        Color3.fromRGB(148, 0, 211)
    }
    local colorIndex = 0
    
    RunService.Heartbeat:Connect(function()
        local pingValue = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
        labels.ping.Text = "您的Ping: " .. math.round(pingValue)
        dataFetched.ping = true
        
        local currentTime = os.clock()
        local fpsValue = 1 / (currentTime - lastTime)
        labels.fps.Text = "您的FPS: " .. math.floor(fpsValue)
        lastTime = currentTime
        dataFetched.fps = true
        
        local timeStr = os.date("%H:%M:%S")
        labels.xpTime.Text = "XP时间: " .. timeStr
        colorIndex = (colorIndex + 0.02) % #colors
        local current = math.floor(colorIndex) + 1
        local nextColor = current % #colors + 1
        labels.xpTime.TextColor3 = colors[current]:Lerp(colors[nextColor], colorIndex % 1)
        dataFetched.xpTime = true
    end)
    
    _G.UserInfoUpdater = {
        update = function()
            if not dataFetched.displayName and LocalPlayer.DisplayName then
                labels.displayName.Text = "您的用户昵称: " .. LocalPlayer.DisplayName
                dataFetched.displayName = true
            end
            
            if not dataFetched.userName and LocalPlayer.Character and LocalPlayer.Character.Name then
                labels.userName.Text = "您的用户名: " .. LocalPlayer.Character.Name
                dataFetched.userName = true
            end
            
            if not dataFetched.userId and LocalPlayer.UserId then
                labels.userId.Text = "您的用户ID: " .. LocalPlayer.UserId
                dataFetched.userId = true
            end
            
            if not dataFetched.clientId then
                pcall(function()
                    local clientId = RbxAnalyticsService:GetClientId()
                    if clientId and clientId ~= "" then
                        labels.clientId.Text = "您的客户端ID: " .. clientId
                        dataFetched.clientId = true
                    end
                end)
            end
            
            if not dataFetched.region then
                pcall(function()
                    local region = LocalizationService:GetCountryRegionForPlayerAsync(LocalPlayer)
                    if region and region ~= "" then
                        labels.region.Text = "您的地区: " .. region
                        dataFetched.region = true
                    end
                end)
            end
            
            if not dataFetched.language and LocalPlayer.LocaleId then
                labels.language.Text = "您的语言: " .. LocalPlayer.LocaleId
                dataFetched.language = true
            end
            
            if not dataFetched.accountAge and LocalPlayer.AccountAge then
                labels.accountAgeDays.Text = "您的账户年龄(天): " .. LocalPlayer.AccountAge
                local years = math.floor(LocalPlayer.AccountAge / 365 * 100) / 100
                labels.accountAgeYears.Text = "您的账户年龄(年): " .. years
                dataFetched.accountAge = true
            end
            
            if not dataFetched.executor then
                pcall(function()
                    local executor = identifyexecutor()
                    if executor and executor ~= "" then
                        labels.executor.Text = "您使用的注入器: " .. executor
                        dataFetched.executor = true
                    end
                end)
            end
            
            if not dataFetched.gameId and game.GameId then
                labels.gameId.Text = "您当前服务器的ID: " .. game.GameId
                dataFetched.gameId = true
            end
            
            if not dataFetched.placeId and game.PlaceId then
                labels.placeId.Text = "您当前的服务器位置ID: " .. game.PlaceId
                dataFetched.placeId = true
            end
        end,
        
        allDataFetched = function()
            for _, fetched in pairs(dataFetched) do
                if not fetched then return false end
            end
            return true
        end
    }
end)

run(function()
    _G.UserInfoUpdater.update()
end)

run(function()
    local LocalPlayer = _G.UserInfoServices.LocalPlayer
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        _G.UserInfoUpdater.update()
    end)
end)

run(function()
    spawn(function()
        while not _G.UserInfoUpdater.allDataFetched() do
            task.wait(15)
            _G.UserInfoUpdater.update()
        end
    end)
end)

-- 用户信息显示开关
run(function()
    _G.UserDisplayConfig = { enabled = false, userGui = nil }
end)

run(function()
    _G.UserDisplayServices = {
        Players = game:GetService("Players"),
        TweenService = game:GetService("TweenService"),
        RunService = game:GetService("RunService"),
        CoreGui = game:GetService("CoreGui"),
        LocalPlayer = game:GetService("Players").LocalPlayer
    }
end)

run(function()
    local TweenService = _G.UserDisplayServices.TweenService
    local CoreGui = _G.UserDisplayServices.CoreGui
    local LocalPlayer = _G.UserDisplayServices.LocalPlayer
    
    _G.UserDisplayModule = {
        create = function()
            if _G.UserDisplayConfig.userGui then
                _G.UserDisplayConfig.userGui:Destroy()
            end
            
            local userGui = Instance.new("ScreenGui")
            userGui.Name = "UserGui"
            userGui.Parent = CoreGui
            userGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            
            local userLabel = Instance.new("TextLabel")
            userLabel.Name = "UserLabel"
            userLabel.Parent = userGui
            userLabel.BackgroundTransparency = 1
            userLabel.Position = UDim2.new(0.80, 0.80, 0.00090, 0)
            userLabel.Size = UDim2.new(0, 135, 0, 50)
            userLabel.Font = Enum.Font.GothamSemibold
            userLabel.Text = "尊贵的星脚本用户: " .. LocalPlayer.DisplayName
            userLabel.TextColor3 = Color3.new(1, 1, 1)
            userLabel.TextSize = 25
            userLabel.TextWrapped = true
            
            local uiGradient = Instance.new("UIGradient")
            uiGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
                ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 127, 0)),
                ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 255, 0)),
                ColorSequenceKeypoint.new(0.30, Color3.fromRGB(0, 255, 0)),
                ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 255)),
                ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 0, 255)),
                ColorSequenceKeypoint.new(0.60, Color3.fromRGB(139, 0, 255)),
                ColorSequenceKeypoint.new(0.70, Color3.fromRGB(255, 0, 0)),
                ColorSequenceKeypoint.new(0.80, Color3.fromRGB(255, 127, 0)),
                ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 255, 0)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 0))
            }
            uiGradient.Rotation = 10
            uiGradient.Parent = userLabel
            
            local tweenInfo = TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
            local tween = TweenService:Create(uiGradient, tweenInfo, {Rotation = 360})
            tween:Play()
            
            _G.UserDisplayConfig.userGui = userGui
        end,
        
        destroy = function()
            if _G.UserDisplayConfig.userGui then
                _G.UserDisplayConfig.userGui:Destroy()
                _G.UserDisplayConfig.userGui = nil
            end
        end
    }
end)

run(function()
    about:Toggle("开启/关闭星脚本用户名称显示", "", false, function(state)
        _G.UserDisplayConfig.enabled = state
        if state then
            _G.UserDisplayModule.create()
        else
            _G.UserDisplayModule.destroy()
        end
    end)
end)

run(function()
    local Players = _G.UserDisplayServices.Players
    local LocalPlayer = Players.LocalPlayer
    LocalPlayer.CharacterAdded:Connect(function()
        if _G.UserDisplayConfig and _G.UserDisplayConfig.enabled then
            task.wait(0.5)
            _G.UserDisplayModule.destroy()
            _G.UserDisplayModule.create()
        end
    end)
end)

-- 作者信息
local about = PIJIAOBEN:section("作者信息", true)

about:Label("星脚本")
about:Label("永不跑路的脚本")
about:Label("作者: 小星")
about:Label("作者QQ: 2332507600")
about:Label("星脚本恩师: 小皮")
about:Label("星脚本QQ主群: 645313702")
about:Button("复制作者QQ", function()
    setclipboard("2332507600")
end)

local selectedItem = nil
local itemsMap = {
    ["星脚本QQ主群"] = "645313702",
    ["星脚本二周年晚会群"] = "753828002",
}

about:Dropdown("选择群号", "ItemSelector", {
    "星脚本QQ主群",
    "星脚本二周年晚会群",
}, function(selected)
    selectedItem = selected
end)

about:Button("复制群号", function()
    if selectedItem then
        local content = itemsMap[selectedItem]
        if content then
            setclipboard(content)
        end
    end
end)

-- UI设置
local uiSection = PIJIAOBEN:section("UI设置", true)

uiSection:Button("关闭脚本UI", function()
    game:GetService("CoreGui")["XPXPXPNBNB"]:Destroy()
end)

uiSection:Keybind("切换用户界面", Enum.KeyCode.Home, function(Value)
    ToggleUILib()
end)


-- ============================================================
-- Tab 2: 本地玩家
-- ============================================================
local PIJIAOBEN = UI:CreateTab(Window, "本地玩家", "136169594232359")

-- 速度
local speedSection = PIJIAOBEN:section("速度", false)

run(function()
    _G.MoveSpeed = {
        Enabled = false,
        Speed = 16,
        Mode = "WalkSpeed",
        Connection = nil
    }
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    
    local function getCharacter()
        if LocalPlayer and LocalPlayer.Character then return LocalPlayer.Character end
        return nil
    end
    
    local function getHumanoid()
        local char = getCharacter()
        if char then return char:FindFirstChildOfClass("Humanoid") end
        return nil
    end
    
    local function getRootPart()
        local char = getCharacter()
        if char then return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") end
        return nil
    end
    
    local function walkSpeedMode(speed)
        local humanoid = getHumanoid()
        if humanoid then humanoid.WalkSpeed = speed end
    end
    
    local function cframeMove(speed)
        local humanoid = getHumanoid()
        local rootPart = getRootPart()
        if not humanoid or not rootPart then return end
        local moveDirection = humanoid.MoveDirection
        if moveDirection.Magnitude > 0 then
            rootPart.CFrame = rootPart.CFrame + (moveDirection * speed * 0.1)
        end
    end
    
    local function velocityMove(speed)
        local humanoid = getHumanoid()
        local rootPart = getRootPart()
        if not humanoid or not rootPart then return end
        local moveDirection = humanoid.MoveDirection
        if moveDirection.Magnitude > 0 then
            rootPart.Velocity = Vector3.new(moveDirection.X * speed, rootPart.Velocity.Y, moveDirection.Z * speed)
        end
    end
    
    local function startMoveLoop()
        if _G.MoveSpeed.Connection then _G.MoveSpeed.Connection:Disconnect() end
        _G.MoveSpeed.Connection = RunService.Heartbeat:Connect(function()
            if not _G.MoveSpeed.Enabled then return end
            local humanoid = getHumanoid()
            local rootPart = getRootPart()
            if not humanoid or not rootPart then return end
            if humanoid.Health <= 0 then return end
            if _G.MoveSpeed.Mode == "WalkSpeed" then
                walkSpeedMode(_G.MoveSpeed.Speed)
            elseif _G.MoveSpeed.Mode == "CFrame" then
                cframeMove(_G.MoveSpeed.Speed)
            elseif _G.MoveSpeed.Mode == "Velocity" then
                velocityMove(_G.MoveSpeed.Speed)
            end
        end)
    end
    
    local function stopMoveLoop()
        if _G.MoveSpeed.Connection then
            _G.MoveSpeed.Connection:Disconnect()
            _G.MoveSpeed.Connection = nil
        end
        local humanoid = getHumanoid()
        if humanoid then humanoid.WalkSpeed = 16 end
    end
    
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if _G.MoveSpeed.Enabled then
            stopMoveLoop()
            startMoveLoop()
        end
    end)
    
    _G.MoveSpeedFunctions = { start = startMoveLoop, stop = stopMoveLoop }
end)

run(function()
    speedSection:Dropdown("移动模式", "Move Mode", {"WalkSpeed", "CFrame", "Velocity"}, function(Value)
        _G.MoveSpeed.Mode = Value
        if _G.MoveSpeed.Enabled then
            _G.MoveSpeedFunctions.stop()
            _G.MoveSpeedFunctions.start()
        end
    end)
    
    speedSection:Slider("设置速度", "Move Speed Slider", 16, 1, 600, false, function(Value)
        _G.MoveSpeed.Speed = Value
    end)
    
    speedSection:Textbox("设置速度", "Move Speed Input", "输入速度", function(Value)
        local speed = tonumber(Value)
        if speed then _G.MoveSpeed.Speed = speed end
    end)
    
    speedSection:Toggle("开启/关闭移动速度", "MoveSpeed Enabled", false, function(Value)
        _G.MoveSpeed.Enabled = Value
        if Value then _G.MoveSpeedFunctions.start() else _G.MoveSpeedFunctions.stop() end
    end)
end)

-- 跳跃
local jumpSection = PIJIAOBEN:section("跳跃", false)

run(function()
    _G.JumpConfig = {
        Enabled = false,
        JumpPower = 50,
        Connection = nil
    }
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    
    local function getHumanoid()
        if LocalPlayer.Character then return LocalPlayer.Character:FindFirstChildOfClass("Humanoid") end
        return nil
    end
    
    local function startJumpLoop()
        if _G.JumpConfig.Connection then _G.JumpConfig.Connection:Disconnect() end
        _G.JumpConfig.Connection = RunService.Heartbeat:Connect(function()
            if not _G.JumpConfig.Enabled then return end
            local humanoid = getHumanoid()
            if humanoid then humanoid.JumpPower = _G.JumpConfig.JumpPower end
        end)
    end
    
    local function stopJumpLoop()
        if _G.JumpConfig.Connection then
            _G.JumpConfig.Connection:Disconnect()
            _G.JumpConfig.Connection = nil
        end
        local humanoid = getHumanoid()
        if humanoid then humanoid.JumpPower = 50 end
    end
    
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if _G.JumpConfig.Enabled then
            stopJumpLoop()
            startJumpLoop()
        end
    end)
    
    _G.JumpFunctions = { start = startJumpLoop, stop = stopJumpLoop }
end)

run(function()
    jumpSection:Slider("设置跳跃高度", "JumpPower", 50, 1, 500, false, function(Value)
        _G.JumpConfig.JumpPower = Value
    end)
    
    jumpSection:Toggle("开启/关闭跳跃修改", "JumpEnabled", false, function(Value)
        _G.JumpConfig.Enabled = Value
        if Value then _G.JumpFunctions.start() else _G.JumpFunctions.stop() end
    end)
end)

-- 血量
local hpSection = PIJIAOBEN:section("血量", false)

run(function()
    _G.HPConfig = { Enabled = false, Health = 100 }
    
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    local function getHumanoid()
        if LocalPlayer.Character then return LocalPlayer.Character:FindFirstChildOfClass("Humanoid") end
        return nil
    end
    
    hpSection:Slider("设置血量", "HP", 100, 1, 9999, false, function(Value)
        _G.HPConfig.Health = Value
        local humanoid = getHumanoid()
        if humanoid then humanoid.MaxHealth = Value; humanoid.Health = Value end
    end)
    
    hpSection:Toggle("锁定血量", "HPLock", false, function(Value)
        _G.HPConfig.Enabled = Value
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.MaxHealth = Value and _G.HPConfig.Health or 100
            humanoid.Health = humanoid.MaxHealth
        end
    end)
    
    spawn(function()
        while true do
            task.wait(0.5)
            if _G.HPConfig.Enabled then
                local humanoid = getHumanoid()
                if humanoid and humanoid.Health < _G.HPConfig.Health then
                    humanoid.Health = _G.HPConfig.Health
                end
            end
        end
    end)
end)

-- 高度 (Noclip)
local noclipSection = PIJIAOBEN:section("穿墙", false)

run(function()
    _G.NoclipConfig = { Enabled = false, Connection = nil }
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    
    local function startNoclip()
        if _G.NoclipConfig.Connection then _G.NoclipConfig.Connection:Disconnect() end
        _G.NoclipConfig.Connection = RunService.Stepped:Connect(function()
            if not _G.NoclipConfig.Enabled then return end
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
    
    local function stopNoclip()
        if _G.NoclipConfig.Connection then
            _G.NoclipConfig.Connection:Disconnect()
            _G.NoclipConfig.Connection = nil
        end
    end
    
    noclipSection:Toggle("开启/关闭穿墙", "NoclipEnabled", false, function(Value)
        _G.NoclipConfig.Enabled = Value
        if Value then startNoclip() else stopNoclip() end
    end)
end)

-- 重力
local gravitySection = PIJIAOBEN:section("重力", false)

run(function()
    gravitySection:Slider("设置重力", "Gravity", 196.2, 0, 500, false, function(Value)
        workspace.Gravity = Value
    end)
end)

-- 亮度
local brightnessSection = PIJIAOBEN:section("亮度", false)

run(function()
    _G.BrightnessConfig = { Enabled = false, Value = 0 }
    
    local Lighting = game:GetService("Lighting")
    
    brightnessSection:Slider("设置环境亮度", "Brightness", 0, 0, 10, false, function(Value)
        _G.BrightnessConfig.Value = Value
        if _G.BrightnessConfig.Enabled then
            Lighting.Ambient = Color3.fromRGB(Value * 25.5, Value * 25.5, Value * 25.5)
        end
    end)
    
    brightnessSection:Toggle("开启/关闭环境亮度修改", "BrightnessEnabled", false, function(Value)
        _G.BrightnessConfig.Enabled = Value
        if Value then
            Lighting.Ambient = Color3.fromRGB(_G.BrightnessConfig.Value * 25.5, _G.BrightnessConfig.Value * 25.5, _G.BrightnessConfig.Value * 25.5)
        else
            Lighting.Ambient = Color3.fromRGB(0, 0, 0)
        end
    end)
end)

-- 相机
local cameraSection = PIJIAOBEN:section("相机", false)

run(function()
    _G.CameraConfig = { Enabled = false, FOV = 70 }
    
    local RunService = game:GetService("RunService")
    local Camera = workspace.CurrentCamera
    
    cameraSection:Slider("设置视野(FOV)", "FOV", 70, 10, 120, false, function(Value)
        _G.CameraConfig.FOV = Value
        if _G.CameraConfig.Enabled then
            Camera.FieldOfView = Value
        end
    end)
    
    cameraSection:Toggle("开启/关闭FOV修改", "FOVEnabled", false, function(Value)
        _G.CameraConfig.Enabled = Value
        Camera.FieldOfView = Value and _G.CameraConfig.FOV or 70
    end)
end)


-- ============================================================
-- Tab 3: 通用
-- ============================================================
local PIJIAOBEN = UI:CreateTab(Window, "通用", "136169594232359")

-- 核心功能
local mainSection = PIJIAOBEN:section("核心功能", false)

-- 隐身工具
mainSection:Button("隐身工具", function()
  loadstring(game:HttpGet("https://gist.githubusercontent.com/skid123skidlol/cd0d2dce51b3f20ad1aac941da06a1a1/raw/f58b98cce7d51e53ade94e7bb460e4f24fb7e0ff/%257BFE%257D%2520Invisible%2520Tool%2520(can%2520hold%2520tools)",true))()
end)

-- 上帝模式
mainSection:Button("上帝模式(无敌)", function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    LocalPlayer.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
        end
    end)
    
    if LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
        end
    end
    
    spawn(function()
        while true do
            task.wait(1)
            if LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.Health < humanoid.MaxHealth then
                    humanoid.Health = humanoid.MaxHealth
                end
            end
        end
    end)
    
    XPHUBNotification:Notification({
        Title = "星脚本", Text = "已开启上帝模式",
        Icon = "rbxassetid://136169594232359", Duration = 3
    })
end)

-- 飞行
mainSection:Button("飞行(Fly)", function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local flying = false
    local speed = 50
    local bodyGyro, bodyVelocity
    
    LocalPlayer.CharacterAdded:Connect(function()
        if flying then
            flying = false
            if bodyGyro then bodyGyro:Destroy() end
            if bodyVelocity then bodyVelocity:Destroy() end
        end
    end)
    
    spawn(function()
        RunService.Heartbeat:Connect(function(dt)
            if not flying then return end
            local character = LocalPlayer.Character
            if not character then return end
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if not rootPart then return end
            
            local moveDirection = Vector3.new()
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                moveDirection = humanoid.MoveDirection
            end
            
            local camCFrame = Camera.CFrame
            local forward = camCFrame.LookVector * moveDirection.Magnitude
            local right = camCFrame.RightVector * 0
            local up = Vector3.new(0, moveDirection.Y, 0)
            
            bodyVelocity.Velocity = (forward * speed) + (up * speed)
            bodyGyro.CFrame = camCFrame
        end)
    end)
    
    flying = true
    local character = LocalPlayer.Character
    if character then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            bodyGyro = Instance.new("BodyGyro")
            bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
            bodyGyro.P = 3000
            bodyGyro.Parent = rootPart
            
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
            bodyVelocity.P = 3000
            bodyVelocity.Parent = rootPart
        end
    end
    
    XPHUBNotification:Notification({
        Title = "星脚本", Text = "飞行已开启 (WASD移动, 空格上升)",
        Icon = "rbxassetid://136169594232359", Duration = 3
    })
end)

-- 范围(Hitbox)
local hitboxSection = PIJIAOBEN:section("范围(Hitbox)", false)

run(function()
    _G.HitboxConfig = {
        Enabled = false,
        Size = 5,
        Transparency = 0.5,
        Color = Color3.fromRGB(255, 0, 0),
        Material = Enum.Material.Neon
    }
    
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local originalSizes = {}
    
    local function applyHitbox(character, size)
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                if not originalSizes[part] then
                    originalSizes[part] = part.Size
                end
                part.Size = Vector3.new(size, size, size)
                part.Transparency = _G.HitboxConfig.Transparency
                part.Color = _G.HitboxConfig.Color
                part.Material = _G.HitboxConfig.Material
                part.CanCollide = false
            end
        end
    end
    
    local function restoreHitbox(character)
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") and originalSizes[part] then
                part.Size = originalSizes[part]
                part.Transparency = 0
                part.Material = Enum.Material.Plastic
                originalSizes[part] = nil
            end
        end
    end
    
    hitboxSection:Toggle("开启/关闭范围", "HitboxStatus", false, function(state)
        _G.HitboxConfig.Enabled = state
        if state then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    applyHitbox(player.Character, _G.HitboxConfig.Size)
                end
            end
        else
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    restoreHitbox(player.Character)
                end
            end
        end
    end)
    
    hitboxSection:Textbox("范围大小", "HitboxSize", "输入(默认5)", function(value)
        local num = tonumber(value)
        if num then _G.HitboxConfig.Size = num end
    end)
    
    hitboxSection:Textbox("范围透明度(0-1)", "HitboxTransparency", "输入(默认0.5)", function(value)
        local num = tonumber(value)
        if num and num >= 0 and num <= 1 then _G.HitboxConfig.Transparency = num end
    end)
    
    hitboxSection:Dropdown("范围颜色", "HitboxColor", {"红色","蓝色","黄色","绿色","青色","橙色","紫色","白色","黑色"}, function(value)
        local colorMap = {
            ["红色"] = Color3.fromRGB(255,0,0),
            ["蓝色"] = Color3.fromRGB(0,0,255),
            ["黄色"] = Color3.fromRGB(255,255,0),
            ["绿色"] = Color3.fromRGB(0,255,0),
            ["青色"] = Color3.fromRGB(0,255,255),
            ["橙色"] = Color3.fromRGB(255,165,0),
            ["紫色"] = Color3.fromRGB(128,0,128),
            ["白色"] = Color3.fromRGB(255,255,255),
            ["黑色"] = Color3.fromRGB(0,0,0),
        }
        _G.HitboxConfig.Color = colorMap[value] or Color3.fromRGB(255,0,0)
    end)
    
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            if _G.HitboxConfig.Enabled and player ~= LocalPlayer then
                task.wait(1)
                applyHitbox(character, _G.HitboxConfig.Size)
            end
        end)
    end)
end)

-- 旋转
local spinSection = PIJIAOBEN:section("旋转", false)

run(function()
    _G.SpinConfig = {
        Enabled = false,
        Speed = 5,
        Direction = "顺时针",
        Axis = "Y轴",
        Connection = nil
    }
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    
    local function getRootPart()
        if LocalPlayer.Character then
            return LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        end
        return nil
    end
    
    local function startSpin()
        if _G.SpinConfig.Connection then _G.SpinConfig.Connection:Disconnect() end
        _G.SpinConfig.Connection = RunService.Heartbeat:Connect(function()
            if not _G.SpinConfig.Enabled then return end
            local rootPart = getRootPart()
            if not rootPart then return end
            
            local speed = _G.SpinConfig.Speed
            if _G.SpinConfig.Direction == "逆时针" then speed = -speed end
            
            local axis
            if _G.SpinConfig.Axis == "X轴" then axis = Vector3.new(1, 0, 0)
            elseif _G.SpinConfig.Axis == "Y轴" then axis = Vector3.new(0, 1, 0)
            else axis = Vector3.new(0, 0, 1) end
            
            rootPart.CFrame = rootPart.CFrame * CFrame.Angles(axis.X * speed * 0.1, axis.Y * speed * 0.1, axis.Z * speed * 0.1)
        end)
    end
    
    local function stopSpin()
        if _G.SpinConfig.Connection then
            _G.SpinConfig.Connection:Disconnect()
            _G.SpinConfig.Connection = nil
        end
    end
    
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if _G.SpinConfig.Enabled then
            stopSpin()
            startSpin()
        end
    end)
    
    spinSection:Textbox("旋转速度", "SpinSpeed", "输入(默认5)", function(Value)
        local num = tonumber(Value)
        if num then _G.SpinConfig.Speed = num end
    end)
    
    spinSection:Dropdown("旋转方向", "SpinDirection", {"顺时针", "逆时针"}, function(Value)
        _G.SpinConfig.Direction = Value
    end)
    
    spinSection:Dropdown("旋转轴向", "SpinAxis", {"X轴", "Y轴", "Z轴"}, function(Value)
        _G.SpinConfig.Axis = Value
    end)
    
    spinSection:Toggle("开启/关闭旋转", "Spinbot", false, function(state)
        _G.SpinConfig.Enabled = state
        if state then startSpin() else stopSpin() end
    end)
end)

-- ESP
local espSection = PIJIAOBEN:section("ESP", false)

run(function()
    _G.ESPConfig = { Enabled = false, Boxes = {}, Connections = {} }
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    
    local function createESP(player)
        if player == LocalPlayer then return end
        if _G.ESPConfig.Boxes[player] then return end
        
        local box = Drawing.new("Square")
        box.Visible = false
        box.Color = Color3.fromRGB(0, 255, 0)
        box.Thickness = 2
        box.Filled = false
        
        _G.ESPConfig.Boxes[player] = box
        
        local conn = RunService.RenderStepped:Connect(function()
            if not _G.ESPConfig.Enabled then box.Visible = false; return end
            if not player.Character then box.Visible = false; return end
            
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if not rootPart then box.Visible = false; return end
            
            local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
            if onScreen then
                local size = 2000 / (Camera.CFrame.Position - rootPart.Position).Magnitude
                box.Size = Vector2.new(size, size * 1.5)
                box.Position = Vector2.new(screenPos.X - size/2, screenPos.Y - size * 0.75)
                box.Visible = true
            else
                box.Visible = false
            end
        end)
        
        table.insert(_G.ESPConfig.Connections, conn)
    end
    
    local function clearESP()
        for player, box in pairs(_G.ESPConfig.Boxes) do
            box:Remove()
        end
        _G.ESPConfig.Boxes = {}
        for _, conn in pairs(_G.ESPConfig.Connections) do
            conn:Disconnect()
        end
        _G.ESPConfig.Connections = {}
    end
    
    espSection:Toggle("开启/关闭ESP", "ESPEnabled", false, function(state)
        _G.ESPConfig.Enabled = state
        if state then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    createESP(player)
                end
            end
        else
            clearESP()
        end
    end)
    
    Players.PlayerAdded:Connect(function(player)
        if _G.ESPConfig.Enabled then
            player.CharacterAdded:Connect(function()
                task.wait(1)
                createESP(player)
            end)
        end
    end)
end)

-- 自瞄
local aimSection = PIJIAOBEN:section("自瞄", false)

run(function()
    _G.AimConfig = {
        Enabled = false,
        FOV = 100,
        Smoothness = 0.5,
        Target = nil
    }
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local mouse = LocalPlayer:GetMouse()
    
    local function getClosestPlayer()
        local closest = nil
        local closestDist = _G.AimConfig.FOV
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                        if dist < closestDist then
                            closestDist = dist
                            closest = player
                        end
                    end
                end
            end
        end
        
        return closest
    end
    
    local aimConnection = nil
    
    aimSection:Slider("自瞄范围(FOV)", "AimFOV", 100, 10, 500, false, function(Value)
        _G.AimConfig.FOV = Value
    end)
    
    aimSection:Slider("平滑度", "AimSmooth", 0.5, 0, 1, false, function(Value)
        _G.AimConfig.Smoothness = Value
    end)
    
    aimSection:Toggle("开启/关闭自瞄", "AimEnabled", false, function(state)
        _G.AimConfig.Enabled = state
        if state then
            aimConnection = RunService.RenderStepped:Connect(function()
                if not _G.AimConfig.Enabled then return end
                local target = getClosestPlayer()
                if target and target.Character then
                    local rootPart = target.Character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        local targetCFrame = CFrame.new(Camera.CFrame.Position, rootPart.Position)
                        Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, 1 - _G.AimConfig.Smoothness)
                    end
                end
            end)
        else
            if aimConnection then
                aimConnection:Disconnect()
                aimConnection = nil
            end
        end
    end)
end)

-- 传送
local teleportSection = PIJIAOBEN:section("传送", false)

run(function()
    teleportSection:Textbox("传送到坐标", "TeleportCoords", "格式: x,y,z", function(Value)
        local coords = {}
        for num in string.gmatch(Value, "[^,%s]+") do
            table.insert(coords, tonumber(num))
        end
        if #coords == 3 then
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            if LocalPlayer.Character then
                local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    rootPart.CFrame = CFrame.new(coords[1], coords[2], coords[3])
                    XPHUBNotification:Notification({
                        Title = "星脚本", Text = "已传送到坐标",
                        Icon = "rbxassetid://136169594232359", Duration = 2
                    })
                end
            end
        else
            XPHUBNotification:Notification({
                Title = "星脚本", Text = "格式错误，请用: x,y,z",
                Icon = "rbxassetid://136169594232359", Duration = 2
            })
        end
    end)
end)

run(function()
    teleportSection:Button("传送到鼠标位置", function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local mouse = LocalPlayer:GetMouse()
        
        if LocalPlayer.Character then
            local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if rootPart and mouse.Hit then
                rootPart.CFrame = CFrame.new(mouse.Hit.X, mouse.Hit.Y + 3, mouse.Hit.Z)
                XPHUBNotification:Notification({
                    Title = "星脚本", Text = "已传送到鼠标位置",
                    Icon = "rbxassetid://136169594232359", Duration = 2
                })
            end
        end
    end)
end)

-- 甩飞
local flingSection = PIJIAOBEN:section("甩飞", false)

run(function()
    _G.FlingConfig = { Enabled = false, Power = 500, Connection = nil }
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    
    flingSection:Slider("甩飞力度", "FlingPower", 500, 10, 5000, false, function(Value)
        _G.FlingConfig.Power = Value
    end)
    
    flingSection:Toggle("开启/关闭甩飞", "FlingEnabled", false, function(state)
        _G.FlingConfig.Enabled = state
        if state then
            _G.FlingConfig.Connection = RunService.Heartbeat:Connect(function()
                if not _G.FlingConfig.Enabled then return end
                if LocalPlayer.Character then
                    local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        -- 对附近玩家施加力
                        for _, player in pairs(Players:GetPlayers()) do
                            if player ~= LocalPlayer and player.Character then
                                local otherRoot = player.Character:FindFirstChild("HumanoidRootPart")
                                if otherRoot then
                                    local dist = (otherRoot.Position - rootPart.Position).Magnitude
                                    if dist < 20 then
                                        local direction = (otherRoot.Position - rootPart.Position).Unit
                                        otherRoot.Velocity = direction * _G.FlingConfig.Power
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        else
            if _G.FlingConfig.Connection then
                _G.FlingConfig.Connection:Disconnect()
                _G.FlingConfig.Connection = nil
            end
        end
    end)
end)

-- 游戏设置
local gameSection = PIJIAOBEN:section("游戏设置", false)

gameSection:Button("重置角色", function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    if LocalPlayer.Character then
        LocalPlayer.Character:BreakJoints()
    end
end)

gameSection:Button("复制当前位置", function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    if LocalPlayer.Character then
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local pos = rootPart.Position
            setclipboard(string.format("%.1f, %.1f, %.1f", pos.X, pos.Y, pos.Z))
            XPHUBNotification:Notification({
                Title = "星脚本", Text = "已复制坐标",
                Icon = "rbxassetid://136169594232359", Duration = 2
            })
        end
    end
end)

-- 修改时间
local timeSection = PIJIAOBEN:section("修改时间", false)

run(function()
    _G.TimeConfig = { Enabled = false, SelectedTime = "正午(12:00)" }
    
    local Lighting = game:GetService("Lighting")
    
    local timeMap = {
        ["凌晨(00:00)"] = 0,
        ["清晨(06:00)"] = 6,
        ["正午(12:00)"] = 12,
        ["傍晚(18:00)"] = 18,
        ["夜晚(22:00)"] = 22,
    }
    
    timeSection:Dropdown("选择时间", "TimeSelect", {
        "凌晨(00:00)", "清晨(06:00)", "正午(12:00)", "傍晚(18:00)", "夜晚(22:00)"
    }, function(Value)
        _G.TimeConfig.SelectedTime = Value
    end)
    
    timeSection:Button("确认修改时间", function()
        local hour = timeMap[_G.TimeConfig.SelectedTime]
        if hour then
            Lighting.TimeOfDay = tostring(hour) .. ":00:00"
            XPHUBNotification:Notification({
                Title = "星脚本", Text = "时间已修改为: " .. _G.TimeConfig.SelectedTime,
                Icon = "rbxassetid://136169594232359", Duration = 2
            })
        end
    end)
end)


-- ============================================================
-- Tab 4: 选择服务器（保留！）
-- ============================================================
local PIJIAOBEN = UI:CreateTab(Window, "选择服务器", "136169594232359")

local about = PIJIAOBEN:section("选择服务器", true)

run(function()
    _G.ScriptLoaderConfig = {
        scripts = {
            ["伐木大亨2"] = 'getgenv().XiaoPi="星脚本-伐木大亨2" loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/XingJiaoBen-2026-/refs/heads/main/%E6%98%9F%E8%84%9A%E6%9C%AC-%E4%BC%90%E6%9C%A8.lua"))()',
            ["在超市生活一周"] = 'getgenv().XiaoPi="星脚本-在超市生活一周" loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/XingJiaoBen-2026-/refs/heads/main/%E6%98%9F%E8%84%9A%E6%9C%AC-%E5%9C%A8%E8%B6%85%E5%B8%82%E7%94%9F%E6%B4%BB%E4%B8%80%E5%91%A8.lua"))()',
            ["极速传奇"] = 'getgenv().XiaoPi="星脚本-极速传奇" loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/XingJiaoBen-2026-/refs/heads/main/%E6%98%9F%E8%84%9A%E6%9C%AC-%E6%9E%81%E9%80%9F%E4%BC%A0%E5%A5%87.lua"))()',
            ["森林99夜"] = 'getgenv().XiaoPi="星脚本-森林99夜" loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/XingJiaoBen-2026-/refs/heads/main/%E6%98%9F%E8%84%9A%E6%9C%AC-%E6%A3%AE%E6%9E%9799%E5%A4%9C.lua"))()',
            ["忍者传奇"] = 'getgenv().XiaoPi="星脚本-忍者传奇" loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/XingJiaoBen-2026-/refs/heads/main/%E6%98%9F%E8%84%9A%E6%9C%AC-%E5%BF%8D%E8%80%85%E4%BC%A0%E5%A5%87.lua"))()',
            ["种植花园"] = 'getgenv().XiaoPi="星脚本-种植花园" loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/XingJiaoBen-2026-/refs/heads/main/%E6%98%9F%E8%84%9A%E6%9C%AC-%E7%A7%8D%E6%A4%8D%E8%8A%B1%E5%9B%AD.lua"))()',
            ["战争大亨"] = 'getgenv().XiaoPi="星脚本-战争大亨" loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/XingJiaoBen-2026-/refs/heads/main/%E6%98%9F%E8%84%9A%E6%9C%AC-%E6%88%98%E4%BA%89%E5%A4%A7%E4%BA%A8.lua"))()'
        },
        gameMapping = {
            [13822889] = "伐木大亨2",
            [127380660530951] = "在超市生活一周",
            [1119466531] = "极速传奇",
            [7326934954] = "森林99夜",
            [1335695570] = "忍者传奇",
            [7436755782] = "种植花园",
            [1526814825] = "战争大亨"
        },
        selectedScript = ""
    }
end)

run(function()
    about:Dropdown("选择服务器", "ServerSelector", {"伐木大亨2", "在超市生活一周", "极速传奇", "森林99夜", "忍者传奇", "种植花园", "战争大亨"}, function(Value)
        _G.ScriptLoaderConfig.selectedScript = Value
    end)
    
    about:Button("执行选择的服务器脚本", function()
        if _G.ScriptLoaderConfig.scripts[_G.ScriptLoaderConfig.selectedScript] then
            loadstring(_G.ScriptLoaderConfig.scripts[_G.ScriptLoaderConfig.selectedScript])()
        else
            XPHUBNotification:Notification({
                Title = "星脚本", Text = "请先选择一个脚本",
                Icon = "rbxassetid://136169594232359", Duration = 3
            })
        end
    end)
    
    about:Button("复制选择的服务器脚本", function()
        if _G.ScriptLoaderConfig.scripts[_G.ScriptLoaderConfig.selectedScript] then
            setclipboard(_G.ScriptLoaderConfig.scripts[_G.ScriptLoaderConfig.selectedScript])
            XPHUBNotification:Notification({
                Title = "星脚本", Text = "已复制脚本",
                Icon = "rbxassetid://136169594232359", Duration = 3
            })
        else
            XPHUBNotification:Notification({
                Title = "星脚本", Text = "请先选择一个脚本",
                Icon = "rbxassetid://136169594232359", Duration = 3
            })
        end
    end)
    
    about:Button("执行当前服务器脚本", function()
        local gameId = game.GameId
        local placeId = game.PlaceId
        local scriptName = _G.ScriptLoaderConfig.gameMapping[gameId] or _G.ScriptLoaderConfig.gameMapping[placeId]
        
        if scriptName and _G.ScriptLoaderConfig.scripts[scriptName] then
            loadstring(_G.ScriptLoaderConfig.scripts[scriptName])()
        else
            XPHUBNotification:Notification({
                Title = "星脚本", Text = "星脚本暂未支持当前服务器",
                Icon = "rbxassetid://136169594232359", Duration = 3
            })
        end
    end)
end)


-- ============================================================
-- 加载完成
-- ============================================================
local endTime = tick()
local loadTime = endTime - startTime

local function formatTime(seconds)
    if seconds < 1 then
        return math.floor(seconds * 1000) .. "毫秒"
    else
        return string.format("%.2f秒", seconds)
    end
end

XPHUBNotification:Notification({
    Title = "星脚本",
    Text = "功能已全部加载完毕\n耗时: " .. formatTime(loadTime),
    Icon = "rbxassetid://136169594232359",
    Duration = 3
})

-- 默认选中首页(信息)
do
    local tabs
    for _, v in ipairs(Window:GetChildren()) do
        if v:IsA("Frame") and v.Name == "Tabs" then tabs = v; break end
    end
    local firstBtn
    if tabs then
        for _, b in ipairs(tabs:GetChildren()) do
            if b:IsA("TextButton") and b.Name == "PageButton" then firstBtn = b; break end
        end
    end
    if firstBtn then
        local ok = pcall(function() firstBtn.MouseButton1Down:Fire() end)
        if not ok then
            for _, p in ipairs(Window:GetChildren()) do
                if p:IsA("ScrollingFrame") then p.Visible = false end
            end
            local idx = 0
            for _, b in ipairs(tabs:GetChildren()) do
                if b:IsA("TextButton") and b.Name == "PageButton" then idx = idx + 1; if idx == 1 then break end
            end
            idx = 0
            for _, p in ipairs(Window:GetChildren()) do
                if p:IsA("ScrollingFrame") then
                    idx = idx + 1
                    if idx == 1 then p.Visible = true; break end
                end
            end
        end
    end
end
