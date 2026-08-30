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
    return library:CreateWindow("星脚本", "新版 2.0", 136169594232359)
end)
if not success or not Window then
    XPHUBNotification:Notification({
        Title = "星脚本", Text = "新版UI加载失败",
        Icon = "rbxassetid://136169594232359", Duration = 3
    })
    return
end

-- ================== UI 适配器 ==================
-- 新版库原生: CreateTab / CreateFrame / CreateButton / CreateToggle /
--   CreateLabel / CreateSlider / CreateBox / CreateBind / CreateColorPicker
-- 旧版代码通过「tab:section(...)」拿到 section 句柄，再调 :Button/:Toggle/...
-- 本适配器把这些调用桥接到新版 API，业务/逻辑代码零改动。
local UI = {}
UI.__sections = {}   -- 记录所有 section 句柄，供 SetValue/UpdateLabel 动态查找

--[[
  新版 black ui 库的真实模型（见 black ui.txt）:
    window:CreateTab(name)       -> 创建【左侧整个导航栏】(一个 Tabs Frame, 宽140), 全脚本只应调一次;
    tab:CreateFrame(pageName)    -> ①在 Window 建一个内容 ScrollingFrame,
                                   ②在【该 tab 的 Tabs 导航栏】里注册一个 PageButton 按钮。
  Tab 切换由库的 PageButton 点击逻辑完成: 遍历 Window 子级隐藏其它 ScrollingFrame, 显示自己。

  因此正确用法是: 只 CreateTab 一次拿到【唯一】左侧导航栏, 然后每个功能页都调一次
  Tab:CreateFrame(name), 在同一导航栏里各注册一个按钮。内容页与按钮一一对应。

  之前的错误: 16 个页各自 CreateTab + CreateFrame -> 生成 16 个互相重叠的左侧导航栏,
  每个栏只有 1 个按钮, 视觉上互相遮盖只剩顶层 -> "左边没名字, 但按下去有功能"。
--]]
local _mainTab = nil      -- 唯一左侧导航栏(tab 对象, 带 :CreateFrame)

function UI:CreateTab(window, name, icon)
    -- 全脚本只创建一次左侧导航栏; 后续所有 "Tab" 都复用它, 通过 CreateFrame 注册按钮。
    if not _mainTab then
        _mainTab = window:CreateTab(name)
    end
    local Tab = _mainTab
    -- 每个功能页在【同一】导航栏里注册一个 PageButton + 一个内容 ScrollingFrame。
    local page = Tab:CreateFrame(name)
    page.Visible = false  -- 默认隐藏, 由库的 Tab 切换逻辑负责显示当前页
    local tabObj = { Window = window, Tab = Tab, _page = page, _els = {} }
    setmetatable(tabObj, { __index = UI })
    return tabObj
end

-- section: 不再创建新 Frame，而是复用所属页的内容 Frame。
function UI:section(name, defaultOpen)
    local handle = { _page = self._page, _tab = self, _els = {} }
    UI.__sections[name] = handle
    setmetatable(handle, { __index = UI })
    return handle
end

local function curPage(self)
    return self._page
end

-- Label
function UI:Label(text)
    local el = self._page:CreateLabel(text)
    self._els[text] = el
    return el
end

-- Button  (旧: Button(name, [desc,] callback))
function UI:Button(name, a, b)
    local desc, cb
    if type(a) == "function" then cb = a else desc = a; cb = b end
    cb = cb or function() end
    return self._page:CreateButton(name, desc or "", cb)
end

-- Toggle (旧: Toggle(name, flag, default, callback))
-- 新版 CreateToggle(title, desc, callback) 无默认值 -> 适配器吃掉 default 并在创建后触发一次
function UI:Toggle(name, flag, default, cb)
    if type(default) ~= "boolean" then
        -- 兼容 :Toggle(name, callback)
        cb = flag; default = false
    end
    cb = cb or function() end
    local tgl = self._page:CreateToggle(name, "", function(v) cb(v) end)
    return tgl
end

-- Slider (旧: Slider(title, flag, def, min, max, prec, callback))
function UI:Slider(name, flag, def, min, max, prec, cb)
    cb = cb or function() end
    local sld = self._page:CreateSlider(name, min or 0, max or 100, function(v) cb(v) end)
    return sld
end

-- Textbox (旧: Textbox(name, flag, placeholder, callback))
function UI:Textbox(name, flag, placeholder, cb)
    cb = cb or function() end
    return self._page:CreateBox(placeholder or name, "Submit", function(v) cb(v) end)
end

-- Bind / Keybind (新版原生 CreateBind)
function UI:Bind(name, defaultKey, cb)
    cb = cb or function() end
    return self._page:CreateBind(name, tostring(defaultKey or "Unknown"), function(v) cb(v) end)
end
UI.Keybind = UI.Bind

-- Dropdown (旧: Dropdown(name, flag, optionsTable, callback))
-- 新版无原生下拉 -> 用一组 Button + 当前值 Label 模拟
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

-- ColorPicker (新版有 CreateColorPicker(name, callback), 直接用)
function UI:ColorPicker(name, flag, default, cb)
    cb = cb or function() end
    return self._page:CreateColorPicker(name, function(col) cb(col) end)
end

UI.run = function(func) func() end
local run = UI.run


local PIJIAOBEN = UI:CreateTab(Window, "信息", "136169594232359")

local about = PIJIAOBEN:section("用户信息", true)

local run = function(func) func() end

run(function()
    _G.UserInfoConfig = {
        dataFetched = {
            displayName = false,
            userName = false,
            userId = false,
            clientId = false,
            region = false,
            language = false,
            accountAge = false,
            executor = false,
            gameId = false,
            placeId = false,
            totalPlayers = false,      
            ping = false,             
            fps = false,               
            xpTime = false            
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
                if not fetched then
                    return false
                end
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

local run = function(func) func() end

run(function()
    _G.UserDisplayConfig = {
        enabled = false,
        userGui = nil
    }
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

local about = PIJIAOBEN:section("作者信息",true)

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
    ["星脚本QQ主群"] = "1065725086",
    ["星脚本二周年晚会群"] = "753828002",
    ["星脚本QQ主群"] = "645313702",
}

about:Dropdown("选择群号/链接", "ItemSelector", {
    "皮脚本QQ主群",
    "皮脚本二周年晚会群",
    "星脚本QQ主群",
}, function(selected)
    selectedItem = selected
end)

about:Button("复制群号/链接", function()
    if selectedItem then
        local content = itemsMap[selectedItem]
        if content then
            setclipboard(content)
        end
    end
end)

local about = PIJIAOBEN:section("最大帮助者",true)

about:Label("万分感谢小皮师傅对我的支持与帮助")
about:Label("给我提供了许多的功能源码")
about:Label("谢谢您的支持与帮助^ω^")

local XP = PIJIAOBEN:section("UI设置", true)

XP:Button("关闭脚本UI",function()
            game:GetService("CoreGui")["XPXPXPNBNB"]:Destroy()
end)

XP:Keybind("切换用户界面", Enum.KeyCode.Home, function(Value)
            ToggleUILib()
end)     

local PIJIAOBEN = UI:CreateTab(Window, "本地玩家", "136169594232359")

local about = PIJIAOBEN:section("速度", false)

local run = function(func) func() end

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
        if LocalPlayer and LocalPlayer.Character then
            return LocalPlayer.Character
        end
        return nil
    end
    
    local function getHumanoid()
        local char = getCharacter()
        if char then
            return char:FindFirstChildOfClass("Humanoid")
        end
        return nil
    end
    
    local function getRootPart()
        local char = getCharacter()
        if char then
            return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
        end
        return nil
    end
    
    local function walkSpeedMode(speed)
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.WalkSpeed = speed
        end
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
            rootPart.Velocity = Vector3.new(
                moveDirection.X * speed,
                rootPart.Velocity.Y,
                moveDirection.Z * speed
            )
        end
    end
    
    local function translateMove(speed)
        local humanoid = getHumanoid()
        local rootPart = getRootPart()
        
        if not humanoid or not rootPart then return end
        
        local moveDirection = humanoid.MoveDirection
        if moveDirection.Magnitude > 0 then
            rootPart.CFrame = rootPart.CFrame + (moveDirection * speed * 0.1)
        end
    end
    
    local function startMoveLoop()
        if _G.MoveSpeed.Connection then
            _G.MoveSpeed.Connection:Disconnect()
        end
        
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
            elseif _G.MoveSpeed.Mode == "Translate" then
                translateMove(_G.MoveSpeed.Speed)
            end
        end)
    end
    
    local function stopMoveLoop()
        if _G.MoveSpeed.Connection then
            _G.MoveSpeed.Connection:Disconnect()
            _G.MoveSpeed.Connection = nil
        end
        
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.WalkSpeed = 16
        end
    end
    
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if _G.MoveSpeed.Enabled then
            stopMoveLoop()
            startMoveLoop()
        end
    end)
    
    _G.MoveSpeedFunctions = {
        start = startMoveLoop,
        stop = stopMoveLoop
    }
end)

run(function()    
    about:Dropdown("移动模式", "Move Mode", {
        "WalkSpeed",
        "CFrame",
        "Velocity",
        "Translate"
    }, function(Value)
        _G.MoveSpeed.Mode = Value
        
        if _G.MoveSpeed.Enabled then
            _G.MoveSpeedFunctions.stop()
            _G.MoveSpeedFunctions.start()
        end
    end)
    
    about:Slider("设置速度", "Move Speed Slider", 16, 1, 600, false, function(Value)
        _G.MoveSpeed.Speed = Value
    end)
    
    about:Textbox("设置速度", "Move Speed Input", "输入速度", function(Value)
        local speed = tonumber(Value)
        if speed then
            _G.MoveSpeed.Speed = speed
        end
    end)
    
    about:Toggle("开启/关闭移动速度", "MoveSpeed Enabled", false, function(Value)
        _G.MoveSpeed.Enabled = Value
        if Value then
            _G.MoveSpeedFunctions.start()
        else
            _G.MoveSpeedFunctions.stop()
        end
    end)
end)

local about = PIJIAOBEN:section("跳跃", false)

local run = function(func) func() end

run(function()
    _G.Jump = {
        Enabled = false,
        JumpPower = 50,
        Mode = "Humanoid",
        Multiplier = 1,
        InfJ = false,
        Connection = nil,
        InfJConnection = nil,
        JumpRequestConnection = nil
    }
    
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    
    local function getCharacter()
        if LocalPlayer and LocalPlayer.Character then
            return LocalPlayer.Character
        end
        return nil
    end
    
    local function getHumanoid()
        local char = getCharacter()
        if char then
            return char:FindFirstChildOfClass("Humanoid")
        end
        return nil
    end
    
    local function getRootPart()
        local char = getCharacter()
        if char then
            return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
        end
        return nil
    end
    
    local function checkGrounded()
        local humanoid = getHumanoid()
        if humanoid then
            return humanoid:GetState() == Enum.HumanoidStateType.Landed or 
                   humanoid:GetState() == Enum.HumanoidStateType.Running or
                   humanoid:GetState() == Enum.HumanoidStateType.Walking
        end
        return false
    end
    
    local function humanoidJump(power, multiplier)
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.JumpPower = power * multiplier
        end
    end
    
    local function performJump()
        local humanoid = getHumanoid()
        local rootPart = getRootPart()
        
        if not humanoid or not rootPart or humanoid.Health <= 0 then return end
        
        if _G.Jump.Mode == "Humanoid" then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            
        elseif _G.Jump.Mode == "CFrame" then
            local jumpHeight = _G.Jump.JumpPower * _G.Jump.Multiplier * 0.1
            rootPart.CFrame = rootPart.CFrame + Vector3.new(0, jumpHeight, 0)
            
        elseif _G.Jump.Mode == "Velocity" then
            rootPart.Velocity = Vector3.new(rootPart.Velocity.X, _G.Jump.JumpPower * _G.Jump.Multiplier * 1.5, rootPart.Velocity.Z)
            
        elseif _G.Jump.Mode == "Infinite" then
            rootPart.Velocity = Vector3.new(rootPart.Velocity.X, _G.Jump.JumpPower * _G.Jump.Multiplier * 1.5, rootPart.Velocity.Z)
        end
    end
    
    local function setupJumpRequest()
        if _G.Jump.JumpRequestConnection then
            _G.Jump.JumpRequestConnection:Disconnect()
            _G.Jump.JumpRequestConnection = nil
        end
        
        if not _G.Jump.Enabled then return end
        
        _G.Jump.JumpRequestConnection = UserInputService.JumpRequest:Connect(function()
            if not _G.Jump.Enabled then return end
            
            local humanoid = getHumanoid()
            if not humanoid or humanoid.Health <= 0 then return end
            
            if not _G.Jump.InfJ and _G.Jump.Mode ~= "Infinite" then
                if not checkGrounded() then return end
            end
            
            performJump()
        end)
    end
    
    local function setupInfiniteJump()
        if _G.Jump.InfJConnection then
            _G.Jump.InfJConnection:Disconnect()
            _G.Jump.InfJConnection = nil
        end
        
        if not _G.Jump.InfJ or not _G.Jump.Enabled then return end
    end
    
    local function startJumpLoop()
        if _G.Jump.Connection then
            _G.Jump.Connection:Disconnect()
            _G.Jump.Connection = nil
        end
        
        if not _G.Jump.Enabled then return end
        
        setupJumpRequest()
        
        _G.Jump.Connection = RunService.Heartbeat:Connect(function()
            if not _G.Jump.Enabled then return end
            
            local humanoid = getHumanoid()
            
            if not humanoid then return end
            if humanoid.Health <= 0 then return end
            
            if _G.Jump.Mode == "Humanoid" then
                humanoidJump(_G.Jump.JumpPower, _G.Jump.Multiplier)
            end
        end)
    end
    
    local function stopJumpLoop()
        if _G.Jump.Connection then
            _G.Jump.Connection:Disconnect()
            _G.Jump.Connection = nil
        end
        
        if _G.Jump.InfJConnection then
            _G.Jump.InfJConnection:Disconnect()
            _G.Jump.InfJConnection = nil
        end
        
        if _G.Jump.JumpRequestConnection then
            _G.Jump.JumpRequestConnection:Disconnect()
            _G.Jump.JumpRequestConnection = nil
        end
        
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.JumpPower = 50
        end
    end
    
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if _G.Jump.Enabled then
            stopJumpLoop()
            startJumpLoop()
        end
    end)
    
    _G.JumpFunctions = {
        start = startJumpLoop,
        stop = stopJumpLoop,
        updateInfJ = setupInfiniteJump,
        updateJumpRequest = setupJumpRequest
    }
end)

run(function() 
    about:Toggle("开启/关闭跳跃", "Jump Enabled", false, function(Value)
        _G.Jump.Enabled = Value
        if Value then
            _G.JumpFunctions.start()
        else
            _G.JumpFunctions.stop()
        end
    end)
    
    about:Dropdown("跳跃模式", "Jump Mode", {
        "Humanoid",
        "CFrame",
        "Velocity",
        "Infinite"
    }, function(Value)
        _G.Jump.Mode = Value
        
        if _G.Jump.Enabled then
            _G.JumpFunctions.stop()
            _G.JumpFunctions.start()
        end
    end)
    
    about:Slider("设置跳跃高度", "Jump Power", 50, 50, 400, false, function(Value)
        _G.Jump.JumpPower = Value
    end)
    
    about:Textbox("设置跳跃倍数", "Jump Multiplier", "输入倍数", function(Value)
        local multiplier = tonumber(Value)
        if multiplier and multiplier > 0 then
            _G.Jump.Multiplier = multiplier
        end
    end)
    
    about:Toggle("无限跳跃", "Inf Jump", false, function(Value)
        _G.Jump.InfJ = Value
    end)
end)

local about = PIJIAOBEN:section("血量", false)

local run = function(func) func() end

run(function()
    _G.Health = {
        Enabled = false,
        MaxHealthEnabled = false,
        Health = 100,
        MaxHealth = 100,
        Connection = nil
    }
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    
    local function getCharacter()
        if LocalPlayer and LocalPlayer.Character then
            return LocalPlayer.Character
        end
        return nil
    end
    
    local function getHumanoid()
        local char = getCharacter()
        if char then
            return char:FindFirstChildOfClass("Humanoid")
        end
        return nil
    end
    
    local function setHealth(value)
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.Health = value
        end
    end
    
    local function setMaxHealth(value)
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.MaxHealth = value
        end
    end
    
    local function startLoop()
        if _G.Health.Connection then
            _G.Health.Connection:Disconnect()
        end
        
        _G.Health.Connection = RunService.Heartbeat:Connect(function()
            local humanoid = getHumanoid()
            if not humanoid then return end
            if humanoid.Health <= 0 then return end
            
            if _G.Health.MaxHealthEnabled then
                setMaxHealth(_G.Health.MaxHealth)
            end
            
            if _G.Health.Enabled then
                setHealth(_G.Health.Health)
            end
        end)
    end
    
    local function stopLoop()
        if _G.Health.Connection then
            _G.Health.Connection:Disconnect()
            _G.Health.Connection = nil
        end
    end
    
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if _G.Health.Enabled or _G.Health.MaxHealthEnabled then
            stopLoop()
            startLoop()
        end
    end)
    
    _G.HealthFunctions = {
        start = startLoop,
        stop = stopLoop
    }
end)

run(function()
    about:Toggle("开启/关闭血量", "Health Enabled", false, function(Value)
        _G.Health.Enabled = Value
        if _G.Health.Enabled or _G.Health.MaxHealthEnabled then
            _G.HealthFunctions.start()
        else
            _G.HealthFunctions.stop()
        end
    end)
    
    about:Slider("设置血量", "Health Slider", 100, 100, 10000, false, function(Value)
        _G.Health.Health = Value
    end)
    
    about:Textbox("设置血量", "Health Input", "输入血量值", function(Value)
        local health = tonumber(Value)
        if health then
            _G.Health.Health = health
        end
    end)
    
    about:Toggle("开启/关闭血量上限", "MaxHealth Enabled", false, function(Value)
        _G.Health.MaxHealthEnabled = Value
        if _G.Health.Enabled or _G.Health.MaxHealthEnabled then
            _G.HealthFunctions.start()
        else
            _G.HealthFunctions.stop()
        end
    end)
    
    about:Slider("设置血量上限", "MaxHealth Slider", 100, 100, 10000, false, function(Value)
        _G.Health.MaxHealth = Value
    end)
    
    about:Textbox("设置血量上限", "MaxHealth Input", "输入血量上限值", function(Value)
        local maxHealth = tonumber(Value)
        if maxHealth then
            _G.Health.MaxHealth = maxHealth
        end
    end)
end)

local about = PIJIAOBEN:section("高度", false)

local heightConfig = {
    currentHeight = 2,
    originalHeight = 2,  
    enabled = false
}

local function applyHeight()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.HipHeight = heightConfig.enabled and heightConfig.currentHeight or heightConfig.originalHeight
    end
end

local function initOriginalHeight()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        heightConfig.originalHeight = char.Humanoid.HipHeight
    end
end

initOriginalHeight()

game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid")
    heightConfig.originalHeight = char.Humanoid.HipHeight
    applyHeight()
end)

about:Textbox("设置高度", tostring(heightConfig.currentHeight), "输入", function(value)
    heightConfig.currentHeight = tonumber(value) or heightConfig.currentHeight
    if heightConfig.enabled then applyHeight() end
end)

about:Toggle("开启/关闭修改高度", "", false, function(state)
    heightConfig.enabled = state
    applyHeight()
end)

local about = PIJIAOBEN:section("重力", false)

local run = function(func) func() end

run(function()
    _G.Gravity = {
        Enabled = false,
        NoGravity = false,
        CurrentGravity = 196.2,
        LoopConnection = nil
    }
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")
    local LocalPlayer = Players.LocalPlayer
    
    local function applyGravity()
        if not _G.Gravity.Enabled then return end
        
        if _G.Gravity.NoGravity then
            Workspace.Gravity = 0
        else
            Workspace.Gravity = _G.Gravity.CurrentGravity
        end
    end
    
    local function resetGravity()
        Workspace.Gravity = 196.2
    end
    
    local function startLoop()
        if _G.Gravity.LoopConnection then
            _G.Gravity.LoopConnection:Disconnect()
        end
        
        _G.Gravity.LoopConnection = RunService.Heartbeat:Connect(function()
            applyGravity()
        end)
    end
    
    local function stopLoop()
        if _G.Gravity.LoopConnection then
            _G.Gravity.LoopConnection:Disconnect()
            _G.Gravity.LoopConnection = nil
        end
        resetGravity()
    end
    
    _G.GravityFunctions = {
        apply = applyGravity,
        reset = resetGravity,
        start = startLoop,
        stop = stopLoop
    }
end)

run(function()
    about:Toggle("开启/关闭修改重力", "Gravity Enabled", false, function(state)
        _G.Gravity.Enabled = state
        if state then
            _G.GravityFunctions.apply()
            _G.GravityFunctions.start()
        else
            _G.GravityFunctions.stop()
        end
    end)

    about:Slider("设置重力值", "Gravity Slider", 196.2, 0, 1000, false, function(Value)
        _G.Gravity.CurrentGravity = tonumber(Value) or _G.Gravity.CurrentGravity
        if _G.Gravity.Enabled and not _G.Gravity.NoGravity then
            _G.GravityFunctions.apply()
        end
    end)
end)
    
    about:Toggle("无重力模式", "No Gravity", false, function(Value)
        _G.Gravity.NoGravity = Value
        if _G.Gravity.Enabled then
            _G.GravityFunctions.apply()
        end
    end)
    
local about = PIJIAOBEN:section("亮度", false)

local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local NightVision = {
    Active = false,
    Brightness = 1,
    UpdateInterval = 0.2,
    OriginalSettings = {
        Ambient = Lighting.Ambient,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        Brightness = Lighting.Brightness,
        ClockTime = Lighting.ClockTime
    },
    Connection = nil
}

about:Slider("设置夜视亮度", "NV_Brightness", 1, 1, 30, false, function(Value)
    NightVision.Brightness = Value
    if NightVision.Active then
        Lighting.Brightness = Value
    end
end)

about:Toggle("开启/关闭夜视", "NV_Toggle", false, function(Enabled)
    if NightVision.Connection then
        NightVision.Connection:Disconnect()
        NightVision.Connection = nil
    end

    NightVision.Active = Enabled

    if Enabled then
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        Lighting.Brightness = NightVision.Brightness
        Lighting.ClockTime = 12

        NightVision.Connection = RunService.Heartbeat:Connect(function()
            Lighting.Ambient = Color3.new(1, 1, 1)
            Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
            Lighting.Brightness = NightVision.Brightness
        end)
    else
        for setting, value in pairs(NightVision.OriginalSettings) do
            Lighting[setting] = value
        end
    end
end)

local about = PIJIAOBEN:section("相机", false)

local run = function(func) func() end

run(function()
    _G.Camera = {
        ZoomEnabled = false,
        FOVEnabled = false,
        ZoomDistance = 128,
        FieldOfView = 70,
        Connection = nil
    }
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")
    local LocalPlayer = Players.LocalPlayer
    
    local function applyCameraSettings()
        if not LocalPlayer then return end
        
        if _G.Camera.ZoomEnabled then
            LocalPlayer.CameraMaxZoomDistance = _G.Camera.ZoomDistance
        end
        
        if _G.Camera.FOVEnabled and Workspace.CurrentCamera then
            Workspace.CurrentCamera.FieldOfView = _G.Camera.FieldOfView
        end
    end
    
    local function resetCameraSettings()
        if LocalPlayer then
            LocalPlayer.CameraMaxZoomDistance = 128
        end
        
        if Workspace.CurrentCamera then
            Workspace.CurrentCamera.FieldOfView = 70
        end
    end
    
    local function startLoop()
        if _G.Camera.Connection then
            _G.Camera.Connection:Disconnect()
        end
        
        _G.Camera.Connection = RunService.Heartbeat:Connect(function()
            applyCameraSettings()
        end)
    end
    
    local function stopLoop()
        if _G.Camera.Connection then
            _G.Camera.Connection:Disconnect()
            _G.Camera.Connection = nil
        end
        resetCameraSettings()
    end
    
    Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        if _G.Camera.FOVEnabled and Workspace.CurrentCamera then
            Workspace.CurrentCamera.FieldOfView = _G.Camera.FieldOfView
        end
    end)
    
    _G.CameraFunctions = {
        apply = applyCameraSettings,
        reset = resetCameraSettings,
        start = startLoop,
        stop = stopLoop
    }
end)

run(function()
    about:Toggle("开启/关闭缩放距离", "Zoom Enabled", false, function(Value)
        _G.Camera.ZoomEnabled = Value
        if _G.Camera.ZoomEnabled or _G.Camera.FOVEnabled then
            _G.CameraFunctions.start()
        else
            _G.CameraFunctions.stop()
        end
    end)
    
    about:Slider("设置缩放距离", "Zoom Distance", 128, 128, 200000, false, function(Value)
        _G.Camera.ZoomDistance = Value
        if _G.Camera.ZoomEnabled then
            game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = Value
        end
    end)
    
    about:Toggle("开启/关闭焦距", "FOV Enabled", false, function(Value)
        _G.Camera.FOVEnabled = Value
        if _G.Camera.ZoomEnabled or _G.Camera.FOVEnabled then
            _G.CameraFunctions.start()
        else
            _G.CameraFunctions.stop()
        end
    end)
    
    about:Slider("设置焦距", "Field of View", 70, 0.1, 250, false, function(Value)
        _G.Camera.FieldOfView = Value
        if _G.Camera.FOVEnabled and game.Workspace.CurrentCamera then
            game.Workspace.CurrentCamera.FieldOfView = Value
        end
    end)
end)

local about = PIJIAOBEN:section("快速跑步", false)

about:Textbox("设置快速跑步", "run", "输入", function(v)
            Speed = v
end)

about:Toggle("开启/关闭快速跑步","switch",false,function(v)
            if v == true then
                sudu = game:GetService("RunService").Heartbeat:Connect(function()
                    if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character.Humanoid and game:GetService("Players").LocalPlayer.Character.Humanoid.Parent then
                        if game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
                            game:GetService("Players").LocalPlayer.Character:TranslateBy(game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection * Speed / 0.5)
                        end
                    end
                end)
            elseif not v and sudu then
                sudu:Disconnect()
                sudu = nil
            end
end)

local PIJIAOBEN = UI:CreateTab(Window, "通用", "136169594232359")

local about = PIJIAOBEN:section("通用", false)

about:Button("隐身道具", function()
  loadstring(game:HttpGet("https://gist.githubusercontent.com/skid123skidlol/cd0d2dce51b3f20ad1aac941da06a1a1/raw/f58b98cce7d51e53ade94e7bb460e4f24fb7e0ff/%257BFE%257D%2520Invisible%2520Tool%2520(can%2520hold%2520tools)",true))()
end)

about:Toggle("循环恢复血量", "HF", false, function(HF)
    if HF then while true do game.Players.LocalPlayer.Character.Humanoid.Health = 9e9 wait() end end
end)

about:Button("锁定视野", function()
loadstring(game:HttpGet("https://pastefy.app/nekmtvpA/raw"))()
end)

about:Toggle('解锁最大视野', "Cam", false, function(Value)
    Cam1 = Value
        if Cam1 then
            Cam2()
        end
    end    
)
Cam2 = function()
    while Cam1 do
    wait(0.1)
    game:GetService('Players').LocalPlayer.CameraMaxZoomDistance = 9e9
    end
    while not Cam1 do
    wait(0.1)
    game:GetService('Players').LocalPlayer.CameraMaxZoomDistance = 32
    end
end

about:Button(
    "查看游戏中的所有玩家（包括血量条）",
    function()
loadstring(game:HttpGet(('https://pastebin.com/raw/G2zb992X'),true))()
    end)

about:Button("工具包",function()
        loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/BTools.txt"))()
end)

about:Button("老外传送至玩家身边",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Infinity2346/Tect-Menu/main/Teleport%20Gui.lua'))()
end)
  
about:Button("点击传送道具", function()
loadstring(game:HttpGet("https://pastefy.app/Jf2QXOwa/raw"))()
end)

about:Toggle("穿墙", "NoClip", false, function(NC)
  local Workspace = game:GetService("Workspace") local Players = game:GetService("Players") if NC then Clipon = true else Clipon = false end Stepped = game:GetService("RunService").Stepped:Connect(function() if not Clipon == false then for a, b in pairs(Workspace:GetChildren()) do if b.Name == Players.LocalPlayer.Name then for i, v in pairs(Workspace[Players.LocalPlayer.Name]:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end end end else Stepped:Disconnect() end end)
end)

about:Button("星飞行",function()
             loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/XingJiaoBen-2026-/refs/heads/main/%E6%98%9F%E9%A3%9E%E8%A1%8C.Lua"))()
end)

about:Button("皮飞车",function()
             loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/Pi-feiche.lua"))()
end)

about:Button("皮自瞄",function()
             loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/3683e49998644fb7.txt_2024-08-09_094310.OTed.lua"))()
end)

about:Button("皮甩飞", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/%E7%9A%AE%E7%94%A9%E9%A3%9E.lua"))()
end)

about:Button("甩飞所有人",function()
          loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
end)

about:Button("死亡笔记",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/1_1.txt_2024-08-08_153358.OTed.lua"))()
end)

about:Button("铁拳",function()
  loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))()
end)

about:Button("电脑键盘",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
end)

about:Toggle("防甩飞", "Anti ragdoll", false, function(state)
    local player = game.Players.LocalPlayer
    local runService = game:GetService("RunService")
    
    if state then
       
        _G.AntiRagdoll = runService.Stepped:Connect(function()
            for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                if otherPlayer ~= player and otherPlayer.Character then
                    local char = otherPlayer.Character
                   
                    for _, v in pairs(char:GetDescendants()) do
                        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                            v.CanCollide = false
                            
                            v.Massless = true
                        end
                    end
                   
                    local rootPart = char:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        rootPart.Massless = true
                    end
                end
            end
        end)
    else
        if _G.AntiRagdoll then
            _G.AntiRagdoll:Disconnect()
            _G.AntiRagdoll = nil
        end
        
        for _, otherPlayer in pairs(game.Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character then
                local char = otherPlayer.Character
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = true
                        v.Massless = false
                    end
                end
            end
        end
    end
end)
about:Toggle("无法移动", "Fake flag", false, function(state)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        if state then
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Anchored = true
                end
            end
        else
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Anchored = false
                end
            end
        end
end)

about:Button("自杀",function()
game.Players.LocalPlayer.Character.Humanoid.Health=0
end)

about:Button("踏空行走",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))()
end)

about:Button("通用ESP",function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Lucasfin000/SpaceHub/main/UESP'))()
end)

about:Button("踢人脚本(仅娱乐)",function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/c8320f69b6aa4f5d.txt_2024-08-08_214628.OTed.lua"))()
end)

about:Button("动画中心",function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Animation-Hub/main/Animation%20Gui", true))()
end)

about:Button("爬墙",function()
  loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end)

about:Button("替身",function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/SkrillexMe/SkrillexLoader/main/SkrillexLoadMain')))()
end)
    
about:Button("碰到就飞",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe./main/Fling%20GUI"))()
end)

about:Button("操人脚本", function()
loadstring(game:HttpGet("https://pastefy.app/BkeffrT5/raw"))()
end)

about:Button("圈圈自瞄(可调)", function()
loadstring(game:HttpGet("https://pastefy.app/YnfF3sje/raw"))()
end)

about:Button("iw指令", function()
  loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
end)

about:Toggle("人物不可见状态(隐身)", "Invisible Character", false, function(state)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.Transparency = state and 1 or 0
            part.CanCollide = not state
        elseif part:IsA("Accessory") then
            part.Handle.Transparency = state and 1 or 0
        end
    end
end)

local getBackpackRunning = false

about:Toggle("获取所有玩家背包道具", "GetBackPack", false, function(state)
    getBackpackRunning = state
    
    if state then
        task.spawn(function()
            while getBackpackRunning do
                for _, player in ipairs(game.Players:GetPlayers()) do
                    if not getBackpackRunning then break end
                    
                    if player ~= game.Players.LocalPlayer then
                        for _, item in ipairs(player.Backpack:GetChildren()) do
                            if not getBackpackRunning then break end
                            
                            pcall(function()
                                item.Parent = game.Players.LocalPlayer.Backpack
                            end)
                            task.wait()
                        end
                    end
                end
                task.wait(0.5)
            end
        end)
    end
end)

about:Button("获取所有玩家道具",function()
for i,v in pairs (game.Players:GetChildren()) do
wait()
for i,b in pairs (v.Backpack:GetChildren()) do
b.Parent = game.Players.LocalPlayer.Backpack
end
end
end)

about:Button("获取当前道具",function()
loadstring(game:HttpGet("https://pastefy.app/3FU05Dyt/raw"))()
end)

about:Button("装备全部道具",function()
loadstring(game:HttpGet("https://pastefy.app/uBqVR9JC/raw"))()
end)

about:Button("删除道具",function()
loadstring(game:HttpGet("https://pastefy.app/r4LHK4p0/raw"))()
end)

about:Button("删除所有道具",function()
loadstring(game:HttpGet("https://pastefy.app/8HB71Lbj/raw"))()
end)

local maxDistance = 10

about:Textbox("互动距离", "", "输入(默认10米)", function(text)
    local distance = tonumber(text)
    if distance and distance > 0 then
        maxDistance = distance
    else
        warn("请输入有效的距离数值")
    end
end)

about:Toggle("自动互动","AutoInteract",false,function(state)
    if state then
        autoInteract = true
        while autoInteract do
            local player = game.Players.LocalPlayer
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local playerPosition = character.HumanoidRootPart.Position
                
                for _,descendant in pairs(workspace:GetDescendants()) do
                    if descendant:IsA("ProximityPrompt") then
                        local objectPosition = descendant.Parent and descendant.Parent:IsA("BasePart") and descendant.Parent.Position
                        if objectPosition then
                            local distance = (playerPosition - objectPosition).Magnitude
                            if distance <= maxDistance then
                                fireproximityprompt(descendant)
                            end
                        else
                            fireproximityprompt(descendant)
                        end
                    end
                end
            end
            task.wait(0.25)
        end
    else
        autoInteract = false
    end
end)

local customHoldDuration = 0

about:Textbox("互动时间", "", "输入(默认0秒)", function(text)
    local duration = tonumber(text)
    if duration and duration >= 0 then
        customHoldDuration = duration
    else
        warn("请输入有效的时间数值")
    end
end)

about:Toggle("快速互动", "InstantProximityPrompt", false, function(Value)
    local promptConnection = nil
    
    if Value then
        promptConnection = game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(v)
            v.HoldDuration = customHoldDuration
        end)
    else
        if promptConnection then
            promptConnection:Disconnect()
            promptConnection = nil
        end
    end
end)

local xrayOn = false

local function toggleXRay()
    xrayOn = not xrayOn
    for i, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA("BasePart") then
            if xrayOn then
                if not descendant:FindFirstChild("OriginalTransparency") then
                    local originalTransparency = Instance.new("NumberValue")
                    originalTransparency.Name = "OriginalTransparency"
                    originalTransparency.Value = descendant.Transparency
                    originalTransparency.Parent = descendant
                end
                descendant.Transparency = 0.5
            else
                if descendant:FindFirstChild("OriginalTransparency") then
                    descendant.Transparency = descendant.OriginalTransparency.Value
                end
            end
        end
    end
end


about:Toggle("X-Ray", "text", false, function(Value)
    if Value then
        toggleXRay()
    else
        toggleXRay()
    end
end)

about:Toggle("无限跳", "IJ", false, function(IJ)
    getgenv().InfJ = IJ game:GetService("UserInputService").JumpRequest:connect(function() if InfJ == true then game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping") end end)
end)

about:Toggle('上帝模式', 'No Description', false, function(Value)
    if Value then
        local LP = game:GetService("Players").LocalPlayer
        local HRP = LP.Character and LP.Character.HumanoidRootPart
        local Clone = HRP:Clone()
        Clone.Parent = LP.Character
    else
        game.Players.LocalPlayer.Character.Head:Destroy()
    end
end)

about:Button("聊天气泡美化",function()
loadstring(game:HttpGet("https://pastefy.app/lCEPuiQO/raw"))()
end)

about:Toggle("靠近敌人自动攻击[需要先装备武器]", "Toggle", false, function(state)
    if state then
        local connections = getgenv().configs and getgenv().configs.connections
        if connections then
            local Disable = getgenv().configs.Disable
            for _, v in pairs(connections) do
                v:Disconnect()
            end
            Disable:Fire()
            Disable:Destroy()
            table.clear(getgenv().configs)
        end

        local Disable = Instance.new("BindableEvent")
        getgenv().configs = {
            connections = {},
            Disable = Disable,
            Size = Vector3.new(10, 10, 10),
            DeathCheck = true
        }

        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local lp = Players.LocalPlayer
        local Run = true
        local Ignorelist = OverlapParams.new()
        Ignorelist.FilterType = Enum.RaycastFilterType.Include

        local function getchar(plr)
            plr = plr or lp
            return plr.Character
        end

        local function gethumanoid(plr)
            local char = plr:IsA("Model") and plr or getchar(plr)
            if char then
                return char:FindFirstChildWhichIsA("Humanoid")
            end
        end

        local function IsAlive(Humanoid)
            return Humanoid and Humanoid.Health > 0
        end

        local function GetTouchInterest(Tool)
            return Tool and Tool:FindFirstChildWhichIsA("TouchTransmitter", true)
        end

        local function GetCharacters(LocalPlayerChar)
            local Characters = {}
            for _, v in pairs(Players:GetPlayers()) do
                table.insert(Characters, getchar(v))
            end
            for i, char in pairs(Characters) do
                if char == LocalPlayerChar then
                    table.remove(Characters, i)
                    break
                end
            end
            return Characters
        end

        local function Attack(Tool, TouchPart, ToTouch)
            if Tool:IsDescendantOf(workspace) then
                Tool:Activate()
                firetouchinterest(TouchPart, ToTouch, 1)
                firetouchinterest(TouchPart, ToTouch, 0)
            end
        end

        table.insert(getgenv().configs.connections, Disable.Event:Connect(function()
            Run = false
        end))

        while Run do
            local char = getchar()
            if IsAlive(gethumanoid(char)) then
                local Tool = char and char:FindFirstChildWhichIsA("Tool")
                local TouchInterest = Tool and GetTouchInterest(Tool)

                if TouchInterest then
                    local TouchPart = TouchInterest.Parent
                    local Characters = GetCharacters(char)
                    Ignorelist.FilterDescendantsInstances = Characters
                    local InstancesInBox = workspace:GetPartBoundsInBox(TouchPart.CFrame, TouchPart.Size + getgenv().configs.Size, Ignorelist)

                    for _, v in pairs(InstancesInBox) do
                        local Character = v:FindFirstAncestorWhichIsA("Model")
                        if table.find(Characters, Character) then
                            if getgenv().configs.DeathCheck and IsAlive(gethumanoid(Character)) then
                                Attack(Tool, TouchPart, v)
                            elseif not getgenv().configs.DeathCheck then
                                Attack(Tool, TouchPart, v)
                            end
                        end
                    end
                end
            end
            RunService.Heartbeat:Wait()
        end
    else
        local Disable = getgenv().configs.Disable
        if Disable then
            Disable:Fire()
            Disable:Destroy()
        end

        for _, connection in pairs(getgenv().configs.connections) do
            connection:Disconnect()
        end
        table.clear(getgenv().configs.connections)
        Run = false
    end
end)
    			
about:Toggle("坐下", "Sound", false, function(Value)
		if Value then
		    game.Players.LocalPlayer.Character.Humanoid.Sit = true
		else
		game.Players.LocalPlayer.Character.Humanoid.Sit = false		    
      end
end)

about:Toggle("声音折磨", "Sound", false, function(bool)
    getgenv().spamSoond = bool
        if bool then
            spamSound()
        end
end)

function spamSound()
	while getgenv().spamSoond == true do
		local class_check = game.IsA
		local sound = Instance.new('Sound')
		local sound_stop = sound.Play
		local get_descendants = game.GetDescendants

		for i,v in next, get_descendants(game) do 
			if class_check(v,"Sound") then
				sound_stop(v)
			end
		end

		get_descendants = nil
		sound:Remove()
		get_descendants = nil
		sound_stop = nil
        task.wait()
	end
end
about:Toggle("七彩建筑", "BasePart", false, function(Value)
		if Value then
		Break = false
		local BaseParts = {}
local Mats = Enum.Material:GetEnumItems()

for i,v in pairs(game.Workspace:GetDescendants()) do
    if v:IsA("BasePart") then
        table.insert(BaseParts, v)
    end
end

game.Workspace.DescendantAdded:Connect(function(v)
    if v:IsA("BasePart") then
        table.insert(BaseParts, v)
    end
end)

while task.wait(0.025) do
    for i,v in pairs(BaseParts) do
        v.Material = Mats[math.random(1, #Mats)]
        v.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
    if Break then break end
    end
end
		else
		Break = true
		end
end)

local player = game.Players.LocalPlayer
local enabled = false
local deathPos = nil
local waitTime = 0

about:Textbox("等待时间(秒)", "", "输入(默认0秒)", function(time)
    waitTime = tonumber(time) or 0
end)

about:Toggle("原地复活", "", false, function(state)
    enabled = state
end)

player.CharacterAdded:Connect(function(char)
    if enabled and deathPos then
        wait(waitTime)
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(deathPos)
        end
    end
end)

player.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.Died:Connect(function()
        if enabled then
            deathPos = char.HumanoidRootPart.Position
        end
    end)
end)

about:Button("人物螺旋上天",function()
loadstring(game:HttpGet("https://pastefy.app/xV1T3PAi/raw"))()
end)

about:Button("无限R币", function()
    loadstring(game:HttpGet("https://pastefy.app/SxhPVOyM/raw"))()
end)

local originalChatVisible = nil  

about:Toggle("显示聊天框", "", false, function(state)
    chatEnabled = state 
    
    if state then
        if originalChatVisible == nil then
            originalChatVisible = game:GetService("StarterGui"):GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
        end        
        game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
        
        if heartbeatConnection then heartbeatConnection:Disconnect() end
        heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
            game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
        end)
    else
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
            heartbeatConnection = nil
        end
        
        if originalChatVisible ~= nil then
            game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, originalChatVisible)
        else
            game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
        end
    end
end)

about:Button("获得管理员权限",function()
loadstring(game:HttpGet("https://pastebin.com/raw/sZpgTVas"))()
end)

about:Button("显示时间", function()
loadstring(game:HttpGet("https://pastebin.com/raw/RycMWV3a"))()
end)

about:Button("F3X", function()
  loadstring(game:GetObjects("rbxassetid://6695644299")[1].Source)()
end)

local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/IceMinisterq/Notification-Library/Main/Library.lua"))()

local notifyEnabled = false
local playerAddedConn = nil
local playerRemovedConn = nil

about:Toggle("玩家进出服务器通知", "", false, function(state)
    notifyEnabled = state
    
    if playerAddedConn then playerAddedConn:Disconnect() end
    if playerRemovedConn then playerRemovedConn:Disconnect() end
    
    if state then
        playerAddedConn = game.Players.ChildAdded:Connect(function(player)
            pcall(function()
                if notifyEnabled then
                    NotificationLibrary:SendNotification("Success", player.Name.." 加入了游戏", 5)
                end
            end)
        end)
        
        playerRemovedConn = game.Players.ChildRemoved:Connect(function(player)
            pcall(function()
                if notifyEnabled then
                    NotificationLibrary:SendNotification("Error", player.Name.." 离开了游戏", 5)
                end
            end)
        end)
    end
end)

local about = PIJIAOBEN:section("游戏设置", false)

about:Button("重新加入游戏", function()
    loadstring(game:HttpGet("https://pastefy.app/XXabqNiv/raw"))()  
end)
about:Button("保存游戏", function()
  saveinstance()
end)
about:Button("离开游戏", function()
  game:Shutdown()
end)

local about = PIJIAOBEN:section("修改时间", false)

local lighting = game:GetService("Lighting")
local selectedTimeValue = "12:00:00"

about:Dropdown("选择时间", "", {
    "午夜 00:00",
    "凌晨 03:00",
    "清晨 06:00", 
    "上午 09:00",
    "中午 12:00",
    "下午 15:00",
    "傍晚 18:00",
    "夜晚 21:00"
}, function(selectedTime)
    if selectedTime == "午夜 00:00" then
        selectedTimeValue = "00:00:00"
    elseif selectedTime == "凌晨 03:00" then
        selectedTimeValue = "03:00:00"
    elseif selectedTime == "清晨 06:00" then
        selectedTimeValue = "06:00:00"
    elseif selectedTime == "上午 09:00" then
        selectedTimeValue = "09:00:00"
    elseif selectedTime == "中午 12:00" then
        selectedTimeValue = "12:00:00"
    elseif selectedTime == "下午 15:00" then
        selectedTimeValue = "15:00:00"
    elseif selectedTime == "傍晚 18:00" then
        selectedTimeValue = "18:00:00"
    elseif selectedTime == "夜晚 21:00" then
        selectedTimeValue = "21:00:00"
    end
end)

about:Button("确认修改时间", function()
    lighting.TimeOfDay = selectedTimeValue
end)

local about = PIJIAOBEN:section("设置相机", false)

local run = function(func) func() end

run(function()
    _G.CameraControlConfig = {
        enabled = false,
        disableAutoReset = false,
        originalSettings = nil,
        cameraTypeMap = {
            ["自定义"] = Enum.CameraType.Custom,
            ["附加"] = Enum.CameraType.Attach,
            ["固定"] = Enum.CameraType.Fixed,
            ["跟随"] = Enum.CameraType.Follow,
            ["动态观察"] = Enum.CameraType.Orbital,
            ["可脚本化"] = Enum.CameraType.Scriptable,
            ["跟踪"] = Enum.CameraType.Track,
            ["观看"] = Enum.CameraType.Watch
        },
        cameraModeMap = {
            ["经典"] = Enum.CameraMode.Classic,
            ["第一人称"] = Enum.CameraMode.LockFirstPerson
        }
    }
end)

run(function()
    _G.CameraControlServices = {
        Players = game:GetService("Players"),
        Workspace = game:GetService("Workspace"),
        LocalPlayer = game:GetService("Players").LocalPlayer,
        Camera = game:GetService("Workspace").CurrentCamera
    }
end)

run(function()
    local Camera = _G.CameraControlServices.Camera
    local LocalPlayer = _G.CameraControlServices.LocalPlayer
    local config = _G.CameraControlConfig
    
    if not config.originalSettings then
        config.originalSettings = {
            CameraType = Camera.CameraType,
            CameraMode = LocalPlayer.CameraMode,
            OcclusionMode = LocalPlayer.DevCameraOcclusionMode
        }
    end
    
    local function executeWithProtection(func)
        config.disableAutoReset = true
        local success, err = pcall(func)
        if not success then
            warn("相机设置失败: " .. tostring(err))
        end
        config.disableAutoReset = false
    end
    
    local function safeSet(func)
        if not config.enabled then return end
        executeWithProtection(func)
    end
    
    local function restoreOriginalSettings()
        executeWithProtection(function()
            Camera.CameraType = config.originalSettings.CameraType
            LocalPlayer.CameraMode = config.originalSettings.CameraMode
            LocalPlayer.DevCameraOcclusionMode = config.originalSettings.OcclusionMode
        end)
    end
    
    _G.CameraControlCore = {
        safeSet = safeSet,
        restore = restoreOriginalSettings,
        setEnabled = function(state)
            if state == config.enabled then return end
            config.enabled = state
            if not state then
                restoreOriginalSettings()
            end
        end,
        setCameraType = function(value)
            safeSet(function()
                if config.cameraTypeMap[value] then
                    Camera.CameraType = config.cameraTypeMap[value]
                end
            end)
        end,
        setCameraMode = function(value)
            safeSet(function()
                if config.cameraModeMap[value] then
                    LocalPlayer.CameraMode = config.cameraModeMap[value]
                end
            end)
        end,
        setOcclusionMode = function(state)
            safeSet(function()
                LocalPlayer.DevCameraOcclusionMode = state and Enum.DevCameraOcclusionMode.Invisicam or Enum.DevCameraOcclusionMode.Zoom
            end)
        end
    }
end)

run(function()
    local Camera = _G.CameraControlServices.Camera
    local LocalPlayer = _G.CameraControlServices.LocalPlayer
    local core = _G.CameraControlCore
    local config = _G.CameraControlConfig
    
    about:Toggle("开启/关闭相机控制", "CameraControlEnabled", false, function(State)
        core.setEnabled(State)
    end)
    
    about:Dropdown("相机类型", "CameraType", {"自定义", "附加", "固定", "跟随", "动态观察", "可脚本化", "跟踪", "观看"}, function(Value)
        core.setCameraType(Value)
    end)
    
    about:Toggle("开启遮挡模式", "DevCameraOcclusionMode", false, function(State)
        core.setOcclusionMode(State)
    end)
    
    about:Dropdown("相机模式", "CameraMode", {"经典", "第一人称"}, function(Value)
        core.setCameraMode(Value)
    end)
    
    Camera:GetPropertyChangedSignal("CameraType"):Connect(function()
        if not config.enabled or config.disableAutoReset then return end
        local func = function()
            Camera.CameraType = Enum.CameraType.Scriptable
        end
        config.disableAutoReset = true
        pcall(func)
        config.disableAutoReset = false
    end)
    
    LocalPlayer:GetPropertyChangedSignal("CameraMode"):Connect(function()
        if not config.enabled or config.disableAutoReset then return end
        local func = function()
            LocalPlayer.CameraMode = Enum.CameraMode.Classic
        end
        config.disableAutoReset = true
        pcall(func)
        config.disableAutoReset = false
    end)
    
    LocalPlayer:GetPropertyChangedSignal("DevCameraOcclusionMode"):Connect(function()
        if not config.enabled or config.disableAutoReset then return end
        local func = function()
            LocalPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam
        end
        config.disableAutoReset = true
        pcall(func)
        config.disableAutoReset = false
    end)
end)

local about = PIJIAOBEN:section("指令", false)

about:Button("指令脚本", function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
end)

about:Label("bang能够掀人")
about:Label("noface没有脸")
about:Label("headsit坐在玩家头上加玩家名字")
about:Label("float悬浮")
about:Label("re重置人物但位置不变")
about:Label("dance跳舞")
about:Label("nolegs没有腿")
about:Label("walltp碰到墙壁传送到墙壁顶部")
about:Label("bring+玩家名字可以让玩家吸到你手上但是只能用于一些服务器")
about:Label("carpet趴着走")
about:Label("infjump无限跳跃")
about:Label("xray透视地图所有物体变透明")
about:Label("bang玩家开头两个英文吸在玩家身后")
about:Label("noanim没有动作")
about:Label("spin人物旋转")
about:Label("sitwalk坐着走")
about:Label("trip让你的人物摔倒")
about:Label("antikick防踢")
about:Label("lay躺下")
about:Label("sit坐")
about:Label("god加血")
about:Label("invisfling配合加血可以旋转")
about:Label("goto+玩家名字传送")
about:Label("unxray关闭透视")
about:Label("noclip穿墙")

local about = PIJIAOBEN:section("念力", false)

about:Button("念力工具", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/refs/heads/main/Mindpower.lua"))()
end)

about:Label("Q - 靠近")
about:Label("E - 离远")
about:Label("Y - 投掷")
about:Label("J - 超级投掷")
about:Label("U - 使物体自转")
about:Label("P - 使物体悬浮在空中")
about:Label("X - 走得更远一点")
about:Label("L - 使方块变直并锁定在前部")

about:Button("让手上的道具飘起来", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/WmD8MuSx"))()
end)

about:Label("J-飞起来")
about:Label("K-回到手中")

local about = PIJIAOBEN:section("子弹追踪", false)

local run = function(func) func() end

run(function()
    local Workspace = game:GetService("Workspace")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Camera = Workspace.CurrentCamera
    local RunService = game:GetService("RunService")
    
    local old
    local main = {
        enable = false,
        teamcheck = false,
        friendcheck = false,
        enablenpc = false,
        trackDistance = 500,
        aliveCheck = false,
        wallCheck = false
    }
    
    local playerCache = {}
    local npcCache = {}
    local lastCacheUpdate = 0
    local CACHE_UPDATE_INTERVAL = 0.1
    
    local function isVisible(targetHead)
        if not main.wallCheck then return true end
        
        if not LocalPlayer.Character then return false end
        local cameraPart = Camera or Workspace.CurrentCamera
        if not cameraPart then return false end
        
        local origin = cameraPart.CFrame.Position
        local target = targetHead.Position
        
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        raycastParams.FilterDescendantsInstances = {
            LocalPlayer.Character,
            cameraPart,
            Workspace:FindFirstChild("Camera")
        }
        raycastParams.IgnoreWater = true
        
        local direction = (target - origin)
        local distance = direction.Magnitude
        local unitDirection = direction.Unit
        
        local result = Workspace:Raycast(origin, unitDirection * distance, raycastParams)
        
        if not result then
            return true
        end
        
        local hitInstance = result.Instance
        if hitInstance then
            local targetCharacter = targetHead.Parent
            if targetCharacter then
                if hitInstance:IsDescendantOf(targetCharacter) then
                    return true
                end
                
                if hitInstance:IsA("Terrain") or (hitInstance:IsA("Part") and hitInstance.Material == Enum.Material.Water) then
                    return true
                end
            end
        end
        
        return false
    end
    
    local function isAlive(character)
        if not character then return false end
        if not main.aliveCheck then return true end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return false end
        
        if humanoid.Health <= 0 then return false end
        
        if humanoid:GetState() == Enum.HumanoidStateType.Dead then return false end
        
        local head = character:FindFirstChild("Head")
        local root = character:FindFirstChild("HumanoidRootPart")
        if not head or not root then return false end
        
        return true
    end
    
    local function updatePlayerCache()
        local currentTime = tick()
        if currentTime - lastCacheUpdate < CACHE_UPDATE_INTERVAL then
            return
        end
        lastCacheUpdate = currentTime
        
        playerCache = {}
        
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            return
        end
        
        local localHrp = LocalPlayer.Character.HumanoidRootPart
        local localPos = localHrp.Position
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local skip = false
                
                if main.teamcheck and player.Team == LocalPlayer.Team then
                    skip = true
                end
                
                if not skip and main.friendcheck and LocalPlayer:IsFriendsWith(player.UserId) then
                    skip = true
                end
                
                if not skip then
                    local character = player.Character
                    local root = character:FindFirstChild("HumanoidRootPart")
                    local head = character:FindFirstChild("Head")
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    
                    if root and head and humanoid and humanoid.Health > 0 and isAlive(character) then
                        local distance = (root.Position - localPos).Magnitude
                        if distance < main.trackDistance then
                            if main.wallCheck then
                                if isVisible(head) then
                                    table.insert(playerCache, {
                                        head = head,
                                        root = root,
                                        distance = distance,
                                        position = root.Position
                                    })
                                end
                            else
                                table.insert(playerCache, {
                                    head = head,
                                    root = root,
                                    distance = distance,
                                    position = root.Position
                                })
                            end
                        end
                    end
                end
            end
        end
        
        table.sort(playerCache, function(a, b)
            return a.distance < b.distance
        end)
    end
    
    local function updateNPCCache()
        if not main.enablenpc then return end
        
        local currentTime = tick()
        if currentTime - lastCacheUpdate < CACHE_UPDATE_INTERVAL then
            return
        end
        
        npcCache = {}
        
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            return
        end
        
        local localHrp = LocalPlayer.Character.HumanoidRootPart
        local localPos = localHrp.Position
        
        for _, object in ipairs(Workspace:GetChildren()) do
            if object:IsA("Model") then
                local humanoid = object:FindFirstChildOfClass("Humanoid")
                local hrp = object:FindFirstChild("HumanoidRootPart") or object.PrimaryPart
                local head = object:FindFirstChild("Head")
                
                if humanoid and hrp and head and humanoid.Health > 0 and isAlive(object) then
                    local isPlayer = false
                    for _, pl in ipairs(Players:GetPlayers()) do
                        if pl.Character == object then
                            isPlayer = true
                            break
                        end
                    end
                    
                    if not isPlayer then
                        local distance = (hrp.Position - localPos).Magnitude
                        if distance < main.trackDistance then
                            if main.wallCheck then
                                if isVisible(head) then
                                    table.insert(npcCache, {
                                        head = head,
                                        hrp = hrp,
                                        distance = distance,
                                        position = hrp.Position
                                    })
                                end
                            else
                                table.insert(npcCache, {
                                    head = head,
                                    hrp = hrp,
                                    distance = distance,
                                    position = hrp.Position
                                })
                            end
                        end
                    end
                end
            end
        end
        
        table.sort(npcCache, function(a, b)
            return a.distance < b.distance
        end)
    end
    
    local function getClosestHead()
        if not main.enable then return nil end
        updatePlayerCache()
        
        if #playerCache > 0 then
            return playerCache[1].head
        end
        return nil
    end
    
    local function getClosestNpcHead()
        if not main.enablenpc then return nil end
        updateNPCCache()
        
        if #npcCache > 0 then
            return npcCache[1].head
        end
        return nil
    end
    
    _G.BulletTrack = main
    
    old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if method == "Raycast" and not checkcaller() then
            local origin = args[1] or Camera.CFrame.Position
            
            if main.enable then
                local closestHead = getClosestHead()
                if closestHead and closestHead.Parent then
                    return {
                        Instance = closestHead,
                        Position = closestHead.Position,
                        Normal = (origin - closestHead.Position).Unit,
                        Material = Enum.Material.Plastic,
                        Distance = (closestHead.Position - origin).Magnitude
                    }
                end
            end
            
            if main.enablenpc then
                local closestNpcHead = getClosestNpcHead()
                if closestNpcHead and closestNpcHead.Parent then
                    return {
                        Instance = closestNpcHead,
                        Position = closestNpcHead.Position,
                        Normal = (origin - closestNpcHead.Position).Unit,
                        Material = Enum.Material.Plastic,
                        Distance = (closestNpcHead.Position - origin).Magnitude
                    }
                end
            end
        end
        return old(self, ...)
    end))
    
    if RunService:IsClient() then
        RunService.Heartbeat:Connect(function()
            if main.enable then
                updatePlayerCache()
            end
            if main.enablenpc then
                updateNPCCache()
            end
        end)
    end
    
    about:Toggle("开启/关闭子弹追踪", "BulletTrack", false, function(state)
        main.enable = state
        if state then
            updatePlayerCache()
        else
            playerCache = {}
        end
    end)
    
    about:Toggle("队伍验证", "TeamCheck", false, function(state)
        main.teamcheck = state
        playerCache = {}
    end)
    
    about:Toggle("好友验证", "FriendCheck", false, function(state)
        main.friendcheck = state
        playerCache = {}
    end)
    
    about:Toggle("NPC子弹追踪", "NPCBulletTrack", false, function(state)
        main.enablenpc = state
        if state then
            updateNPCCache()
        else
            npcCache = {}
        end
    end)
    
    about:Toggle("活体检测", "AliveCheck", false, function(state)
        main.aliveCheck = state
        playerCache = {}
        npcCache = {}
        if main.enable then
            updatePlayerCache()
        end
        if main.enablenpc then
            updateNPCCache()
        end
    end)
    
    about:Toggle("墙体检测", "WallCheck", false, function(state)
        main.wallCheck = state
        playerCache = {}
        npcCache = {}
        if main.enable then
            updatePlayerCache()
        end
        if main.enablenpc then
            updateNPCCache()
        end
    end)
    
    about:Slider("追踪距离", "TrackDistance", 500, 50, 2000, false, function(value)
        main.trackDistance = value
        playerCache = {}
        npcCache = {}
        if main.enable then
            updatePlayerCache()
        end
        if main.enablenpc then
            updateNPCCache()
        end
    end)
end)

run(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    LocalPlayer.CharacterAdded:Connect(function()
        if _G.BulletTrack and _G.BulletTrack.enable then
            
        end
    end)
end)

run(function()
    local Players = game:GetService("Players")
    
    Players.PlayerRemoving:Connect(function()
        
    end)
end)

local about = PIJIAOBEN:section("其他注入器", false)

about:Button("syn", function()
  loadstring(game:HttpGet("https://pastebin.com/raw/tWGxhNq0"))()
end)
about:Button("syn2", function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/Chillz-s-scripts/main/Synapse-X-Remake.lua"))()
end)
about:Button("阿尔宙斯V3", function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/chillz-workshop/main/Arceus%20X%20V3"))()
end)     
about:Button("水滴注入器", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/crceck123/roblox-script/main/hydrogen_skin_for_evon.lua"))()
end)

local about = PIJIAOBEN:section("加入其他服务器/游戏", false)
local run = function(func) func() end

run(function()
    local gameList = {
        {name = "极速传奇", id = 3101667897},
        {name = "鲨口生求2", id = 8908228901},
        {name = "监狱人生", id = 155615604},
        {name = "忍者传奇", id = 3956818381},
        {name = "Break in", id = 1318971886},
        {name = "自然灾害生存", id = 189707},
        {name = "力量传奇", id = 3623096087},
        {name = "餐厅大亨2", id = 3398014311},
        
        {name = "宠物模拟器99", id = 6428883829},
        {name = "农场模拟器", id = 1304589227},
        {name = "采矿模拟器", id = 6135357899},
        {name = "大亨模拟器", id = 1844618970},
        {name = "发型模拟器", id = 10544864600},
        {name = "武器模拟器", id = 8384872237},
        
        {name = "彩虹朋友", id = 6872265039},
        {name = "门", id = 6516141723},
        {name = "灯塔", id = 7318977327},
        {name = "逃生房", id = 9087401012},
        {name = "致命公司", id = 9646825774},
        {name = "恐怖酒店", id = 9932641247},
        
        {name = "布鲁克黑文", id = 4924922222},
        {name = "收养我", id = 920587237},
        {name = "机甲战争", id = 10409701476},
        {name = "皇家高中", id = 10162927896},
        {name = "梦幻家园", id = 4345344080},
        
        {name = "冲突", id = 7141568546},
        {name = "街区战斗", id = 9125849471},
        {name = "SB格斗", id = 10252183831},
        {name = "超能力格斗", id = 5125457760},
        {name = "传奇格斗", id = 6793688702},
        
        {name = "军队模拟器", id = 2680928287},
        {name = "僵尸起义", id = 3506833665},
        {name = "RBLX战争", id = 4769604914},
        {name = "战区", id = 6886857129},
        {name = "狙击手", id = 4831568045},
        
        {name = "汽车大亨", id = 3245227284},
        {name = "披萨大亨", id = 1494580807},
        {name = "游乐园大亨", id = 8258508852},
        {name = "购物中心大亨", id = 4711749966},
        {name = "酒店大亨", id = 3827451625},
        
        {name = "越狱", id = 2442804977},
        {name = "谋杀之谜2", id = 9338002133},
        {name = "间谍", id = 6935114469},
        {name = "倒计时", id = 7053266494},
        {name = "下水道", id = 9557237248},
        {name = "建筑模拟器", id = 5372314644},
        
        {name = "工作吧", id = 2970301419},
        {name = "过山车", id = 5282906834},
        {name = "赛车手", id = 2858373443},
        {name = "挖掘", id = 11554442389},
        {name = "滑雪", id = 9562645286}
    }
    
    _G.GameData = {
        list = gameList,
        getNames = function()
            local names = {}
            for _, game in ipairs(gameList) do
                table.insert(names, game.name)
            end
            return names
        end,
        getGameId = function(name)
            for _, game in ipairs(gameList) do
                if game.name == name then
                    return game.id
                end
            end
            return nil
        end
    }
end)

run(function()
    local selectedGameId = _G.GameData.list[1].id
    local TeleportService = game:GetService("TeleportService")
    local Players = game:GetService("Players")
    local gameNames = _G.GameData.getNames()
    
    about:Dropdown("选择游戏", "GameSelector", gameNames, function(selectedGame)
        selectedGameId = _G.GameData.getGameId(selectedGame)
    end)
    
    about:Button("加入游戏", function()
        local player = Players.LocalPlayer
        if not player then return end
        
        local success, err = pcall(function()
            TeleportService:Teleport(selectedGameId, player)
        end)
        
        if not success then
            pcall(function()
                TeleportService:TeleportToPlaceInstance(selectedGameId, game.PlaceId, player)
            end)
        end
    end)
end)

run(function()
    local TeleportService = game:GetService("TeleportService")
    
    TeleportService.TeleportInitFailed:Connect(function(player, placeId, errorMessage)
        
    end)
end)

local about = PIJIAOBEN:section("翻译", false)

local run = function(func) func() end

run(function()
    _G.TranslationConfig = {
        Active = false,
        Mode = "智能翻译",
        Speed = 2,
        TranslateNumbers = false,
        TranslateSymbols = false,
        TranslateNames = false,
        TranslateUI = true,
        TranslateChat = true,
        TargetLanguage = "zh-CN"
    }
end)


run(function()
    _G.TranslationConstants = {
        TARGET_LANGUAGE = "zh-CN",
        MAX_TEXT_LENGTH = 5000, 
        
        DANGEROUS_COMMANDS = {
            "neon", "shine", "ghost", "gold", "spin", 
            "bighead", "smallhead", "giantdwarf", "squash"
        },
        
        SUPPORTED_UI_TYPES = {
            "TextLabel", "TextButton", "TextBox", 
            "Frame", "ScrollingFrame", "ImageButton", "ImageLabel"
        },
        
        LANGUAGE_PATTERNS = {
            ["zh-CN"] = {
                pattern = "[\199-\244][\128-\191]*[\128-\191]",
                exclude = "[\227][\128-\191][\128-\191]"
            },
            ["zh-TW"] = {
                pattern = "[\227][\128-\191][\128-\191]"
            },
            ["ja"] = {
                pattern = "[\227-\229][\128-\191][\128-\191]"
            },
            ["ko"] = {
                pattern = "[\234-\235][\128-\191][\128-\191]"
            },
            ["ar"] = {
                pattern = "[\216-\219][\128-\191]"
            },
            ["ru"] = {
                pattern = "[\208-\209][\128-\191]"
            },
            ["th"] = {
                pattern = "[\224-\231][\128-\191]"
            },
            ["en"] = {
                pattern = "[A-Za-z]",
                exclude = "[\199-\244][\128-\191]*[\128-\191]"
            }
        }
    }
end)

run(function()
    _G.TranslationServices = {
        HttpService = game:GetService("HttpService"),
        Players = game:GetService("Players"),
        RunService = game:GetService("RunService"),
        Chat = game:GetService("Chat"),
        
        player = game:GetService("Players").LocalPlayer,
        playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"),
        CoreGui = game:GetService("CoreGui")
    }
end)

run(function()
    _G.TranslationUtils = {
        translatedCache = {},
        translatedObjects = {},
        connection = nil,
        
        isDangerousText = function(text)
            if not text or type(text) ~= "string" then return false end
            local lowerText = text:lower()
            for _, cmd in ipairs(_G.TranslationConstants.DANGEROUS_COMMANDS) do
                if lowerText:find(cmd) then
                    return true
                end
            end
            return false
        end,
        
        shouldSkipTranslation = function(text)
            if not text or text == "" or _G.TranslationUtils.translatedCache[text] then
                return true
            end
            
            if text:match("^%s*$") then
                _G.TranslationUtils.translatedCache[text] = text
                return true
            end
            
            if not _G.TranslationConfig.TranslateNumbers and text:match("^[0-9%.%s,:/%%$#@!%^%&%*%(%)%-_=+%[%]{}|;:'\",.<>/?]+$") then
                _G.TranslationUtils.translatedCache[text] = text
                return true
            end
            
            if not _G.TranslationConfig.TranslateSymbols and text:match("^[^%w%s]+$") then
                _G.TranslationUtils.translatedCache[text] = text
                return true
            end
            
            if #text > _G.TranslationConstants.MAX_TEXT_LENGTH or _G.TranslationUtils.isDangerousText(text) then
                _G.TranslationUtils.translatedCache[text] = text
                return true
            end
            
            return false
        end,
        
        detectLanguage = function(text)
            if not text or type(text) ~= "string" or text == "" then
                return "en"
            end
            
            local patterns = _G.TranslationConstants.LANGUAGE_PATTERNS
            
            if text:match(patterns["zh-CN"].pattern) and 
               (not patterns["zh-CN"].exclude or not text:match(patterns["zh-CN"].exclude)) then
                return "zh-CN"
            end
            
            if text:match(patterns["zh-TW"].pattern) then
                return "zh-TW"
            end
            
            if text:match(patterns["ja"].pattern) then
                return "ja"
            end
            
            if text:match(patterns["ko"].pattern) then
                return "ko"
            end
            
            if text:match(patterns["ar"].pattern) then
                return "ar"
            end
            
            if text:match(patterns["ru"].pattern) then
                return "ru"
            end
            
            if text:match(patterns["th"].pattern) then
                return "th"
            end
            
            return "en"
        end,
        
        hasTextContent = function(gui)
            if gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox") then
                return gui.Text and gui.Text ~= ""
            elseif gui:IsA("ImageButton") or gui:IsA("ImageLabel") then
                return gui:GetAttribute("Text") or gui.Name ~= ""
            end
            return false
        end,
        
        getTextContent = function(gui)
            if gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox") then
                return gui.Text
            elseif gui:IsA("ImageButton") or gui:IsA("ImageLabel") then
                return gui:GetAttribute("Text") or gui.Name
            end
            return nil
        end,
        
        setTextContent = function(gui, text)
            if gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox") then
                gui.Text = text
            elseif gui:IsA("ImageButton") or gui:IsA("ImageLabel") then
                gui:SetAttribute("OriginalText", _G.TranslationUtils.getTextContent(gui))
                gui:SetAttribute("Text", text)
            end
        end,
        
        splitText = function(text, maxLength)
            local parts = {}
            local currentPos = 1
            while currentPos <= #text do
                local endPos = math.min(currentPos + maxLength - 1, #text)
                table.insert(parts, text:sub(currentPos, endPos))
                currentPos = endPos + 1
            end
            return parts
        end
    }
end)

run(function()
    local HttpService = _G.TranslationServices.HttpService
    local playerGui = _G.TranslationServices.playerGui
    local CoreGui = _G.TranslationServices.CoreGui
    local Chat = _G.TranslationServices.Chat
    local RunService = _G.TranslationServices.RunService
    
    _G.TranslationCore = {
        translateWithGoogle = function(text, targetLang)
            if not text or text == "" then return text end
            
            local sourceLang = _G.TranslationUtils.detectLanguage(text)
            
          
            if sourceLang == targetLang then
                return text
            end
            
          
            local url = string.format(
                "https://translate.googleapis.com/translate_a/single?client=gtx&sl=%s&tl=%s&dt=t&q=%s",
                sourceLang,
                targetLang,
                HttpService:UrlEncode(text)
            )
            
            local success, response = pcall(function()
                return game:HttpGet(url)
            end)
            
            if success and response then
                local ok, data = pcall(HttpService.JSONDecode, HttpService, response)
                if ok and data and data[1] then
                    local translatedText = ""
                    for _, segment in ipairs(data[1]) do
                        if segment[1] then
                            translatedText = translatedText .. segment[1]
                        end
                    end
                    
                    if translatedText ~= "" and translatedText ~= text then
                        return translatedText
                    end
                end
            end
            
            return text
        end,
        
        translate = function(text)
            if _G.TranslationUtils.shouldSkipTranslation(text) then
                return _G.TranslationUtils.translatedCache[text] or text
            end
            
            local translatedText
            
           
            if _G.TranslationConfig.Mode == "仅翻译英文" then
                if _G.TranslationUtils.detectLanguage(text) == "en" then
                    translatedText = _G.TranslationCore.translateWithGoogle(text, _G.TranslationConfig.TargetLanguage)
                else
                    translatedText = text
                end
            elseif _G.TranslationConfig.Mode == "仅翻译日文" then
                if _G.TranslationUtils.detectLanguage(text) == "ja" then
                    translatedText = _G.TranslationCore.translateWithGoogle(text, _G.TranslationConfig.TargetLanguage)
                else
                    translatedText = text
                end
            elseif _G.TranslationConfig.Mode == "仅翻译韩文" then
                if _G.TranslationUtils.detectLanguage(text) == "ko" then
                    translatedText = _G.TranslationCore.translateWithGoogle(text, _G.TranslationConfig.TargetLanguage)
                else
                    translatedText = text
                end
            else
                
                translatedText = _G.TranslationCore.translateWithGoogle(text, _G.TranslationConfig.TargetLanguage)
            end
            
            if translatedText and translatedText ~= text then
                _G.TranslationUtils.translatedCache[text] = translatedText
                return translatedText
            end
            
            _G.TranslationUtils.translatedCache[text] = text
            return text
        end,
        
        scanAndTranslate = function()
            local count = 0
            
            if _G.TranslationConfig.TranslateUI then
                for _, gui in ipairs(playerGui:GetDescendants()) do
                    if not _G.TranslationUtils.translatedObjects[gui] and _G.TranslationUtils.hasTextContent(gui) then
                        local text = _G.TranslationUtils.getTextContent(gui)
                        if text and text ~= "" then
                            _G.TranslationUtils.translatedObjects[gui] = true
                            local translatedText = _G.TranslationCore.translate(text)
                            if _G.TranslationUtils.getTextContent(gui) == text then
                                _G.TranslationUtils.setTextContent(gui, translatedText)
                                count = count + 1
                            end
                        end
                    end
                end
                
                for _, gui in ipairs(CoreGui:GetDescendants()) do
                    if not _G.TranslationUtils.translatedObjects[gui] and _G.TranslationUtils.hasTextContent(gui) then
                        local text = _G.TranslationUtils.getTextContent(gui)
                        if text and text ~= "" then
                            _G.TranslationUtils.translatedObjects[gui] = true
                            local translatedText = _G.TranslationCore.translate(text)
                            if _G.TranslationUtils.getTextContent(gui) == text then
                                _G.TranslationUtils.setTextContent(gui, translatedText)
                                count = count + 1
                            end
                        end
                    end
                end
            end
            
            if _G.TranslationConfig.TranslateChat then
                for _, message in ipairs(Chat:GetChildren()) do
                    if message:IsA("TextLabel") and not _G.TranslationUtils.translatedObjects[message] then
                        local text = message.Text
                        if text and text ~= "" then
                            _G.TranslationUtils.translatedObjects[message] = true
                            local translatedText = _G.TranslationCore.translate(text)
                            if message.Text == text then
                                message.Text = translatedText
                                count = count + 1
                            end
                        end
                    end
                end
            end
            
            return count
        end,
        
        updateTranslation = function()
            if _G.TranslationUtils.connection then
                _G.TranslationUtils.connection:Disconnect()
                _G.TranslationUtils.connection = nil
            end
            
            if _G.TranslationConfig.Active then
                local count = _G.TranslationCore.scanAndTranslate()
                
                _G.TranslationUtils.connection = RunService.Heartbeat:Connect(function()
                    if _G.TranslationConfig.Active then
                        local count = _G.TranslationCore.scanAndTranslate()
                        task.wait(2 / _G.TranslationConfig.Speed)
                    end
                end)
            end
        end,
        
        clearCache = function()
            _G.TranslationUtils.translatedCache = {}
            _G.TranslationUtils.translatedObjects = {}
        end
    }
end)

run(function()
    about:Toggle("自动翻译", "TranslationActive", false, function(state)
        _G.TranslationConfig.Active = state
        _G.TranslationCore.updateTranslation()
    end)

    about:Dropdown("翻译模式", "TranslationMode", {"智能翻译", "快速翻译", "精确翻译", "仅翻译英文", "仅翻译日文", "仅翻译韩文"}, function(value)
        _G.TranslationConfig.Mode = value
    end)

    about:Slider("翻译速度", "TranslationSpeed", 2, 1, 10, function(value)
        _G.TranslationConfig.Speed = value
        if _G.TranslationConfig.Active then
            _G.TranslationCore.updateTranslation()
        end
    end)

    about:Toggle("翻译数字", "TranslateNumbers", false, function(state)
        _G.TranslationConfig.TranslateNumbers = state
    end)

    about:Toggle("翻译符号", "TranslateSymbols", false, function(state)
        _G.TranslationConfig.TranslateSymbols = state
    end)

    about:Toggle("翻译名称", "TranslateNames", false, function(state)
        _G.TranslationConfig.TranslateNames = state
    end)

    about:Toggle("翻译界面", "TranslateUI", true, function(state)
        _G.TranslationConfig.TranslateUI = state
        if _G.TranslationConfig.Active then
            _G.TranslationCore.updateTranslation()
        end
    end)

    about:Toggle("翻译聊天", "TranslateChat", true, function(state)
        _G.TranslationConfig.TranslateChat = state
        if _G.TranslationConfig.Active then
            _G.TranslationCore.updateTranslation()
        end
    end)

    about:Button("立即翻译", function()
        local count = _G.TranslationCore.scanAndTranslate()
        
    end)

    about:Button("清空缓存", function()
        _G.TranslationCore.clearCache()
        
    end)
end)


run(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    LocalPlayer.CharacterAdded:Connect(function()
       
    end)
end)

local about = PIJIAOBEN:section("美化", false)

local run = function(func) func() end

run(function()
    _G.BeautifyConfig = {
        Headless = false,
        BrokenLeg = false,
        DeleteHats = false,
        RainbowCharacter = false,
        DeleteAllClothes = false
    }
end)

run(function()
    _G.BeautifyServices = {
        Players = game:GetService("Players"),
        RunService = game:GetService("RunService"),
        LocalPlayer = game:GetService("Players").LocalPlayer
    }
end)

run(function()
    local Players = _G.BeautifyServices.Players
    local LocalPlayer = _G.BeautifyServices.LocalPlayer
    
    _G.HeadlessModule = {
        enable = function()
            local char = LocalPlayer.Character
            if char then
                local head = char:FindFirstChild("Head")
                if head then
                    head.Transparency = 1
                    local decal = head:FindFirstChildOfClass("Decal")
                    if decal then
                        decal:Destroy()
                    end
                end
            end
        end,
        
        disable = function()
            local char = LocalPlayer.Character
            if char then
                local head = char:FindFirstChild("Head")
                if head then
                    head.Transparency = 0
                end
            end
        end
    }
    
    about:Toggle("美化无头", "BeautifyHeadless", false, function(state)
        _G.BeautifyConfig.Headless = state
        if state then
            _G.HeadlessModule.enable()
        else
            _G.HeadlessModule.disable()
        end
    end)
end)

run(function()
    local Players = _G.BeautifyServices.Players
    local LocalPlayer = _G.BeautifyServices.LocalPlayer
    
    _G.BrokenLegModule = {
        enable = function()
            local char = LocalPlayer.Character
            if char then
                local rightLeg = char:FindFirstChild("RightLeg") or char:FindFirstChild("Right Leg")
                if rightLeg then
                    for _, child in pairs(rightLeg:GetChildren()) do
                        if child:IsA("SpecialMesh") then
                            child:Destroy()
                        end
                    end
                    
                    local specialMesh = Instance.new("SpecialMesh")
                    specialMesh.MeshId = "rbxassetid://101851696"
                    specialMesh.TextureId = "rbxassetid://115727863"
                    specialMesh.Scale = Vector3.new(1, 1, 1)
                    specialMesh.Parent = rightLeg
                end
            end
        end,
        
        disable = function()
            local char = LocalPlayer.Character
            if char then
                local rightLeg = char:FindFirstChild("RightLeg") or char:FindFirstChild("Right Leg")
                if rightLeg then
                    for _, child in pairs(rightLeg:GetChildren()) do
                        if child:IsA("SpecialMesh") then
                            child:Destroy()
                        end
                    end
                end
            end
        end
    }
    
    about:Toggle("美化断腿", "BeautifyBrokenLeg", false, function(state)
        _G.BeautifyConfig.BrokenLeg = state
        if state then
            _G.BrokenLegModule.enable()
        else
            _G.BrokenLegModule.disable()
        end
    end)
end)

run(function()
    local Players = _G.BeautifyServices.Players
    local LocalPlayer = _G.BeautifyServices.LocalPlayer
    
    _G.DeleteHatsModule = {
        enable = function()
            local char = LocalPlayer.Character
            if char then
                for _, accessory in pairs(char:GetChildren()) do
                    if accessory:IsA("Accessory") then
                        accessory:Destroy()
                    end
                end
            end
        end,
        
        disable = function()
           
        end
    }
    
    about:Toggle("删除帽子", "DeleteHats", false, function(state)
        _G.BeautifyConfig.DeleteHats = state
        if state then
            _G.DeleteHatsModule.enable()
        end
    end)
end)

run(function()
    local Players = _G.BeautifyServices.Players
    local RunService = _G.BeautifyServices.RunService
    local LocalPlayer = _G.BeautifyServices.LocalPlayer
    
    local rainbowConnection = nil
    
    _G.RainbowModule = {
        enable = function()
            if rainbowConnection then
                rainbowConnection:Disconnect()
            end
            
            rainbowConnection = RunService.RenderStepped:Connect(function()
                local char = LocalPlayer.Character
                if not char then return end
                
                local hue = (tick() % 5) / 5
                local rainbowColor = Color3.fromHSV(hue, 1, 1)
                
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.Color = rainbowColor
                        
                        local glow = part:FindFirstChild("RainbowGlow") or Instance.new("SurfaceAppearance")
                        glow.Name = "RainbowGlow"
                        glow.ColorMap = "rbxassetid://9018903989"
                        glow.Parent = part
                    end
                end
            end)
        end,
        
        disable = function()
            if rainbowConnection then
                rainbowConnection:Disconnect()
                rainbowConnection = nil
            end
            
            local char = LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.Color = Color3.fromRGB(163, 162, 165)
                        
                        local glow = part:FindFirstChild("RainbowGlow")
                        if glow then
                            glow:Destroy()
                        end
                    end
                end
            end
        end
    }
    
    about:Toggle("彩虹人物", "RainbowCharacter", false, function(state)
        _G.BeautifyConfig.RainbowCharacter = state
        if state then
            _G.RainbowModule.enable()
        else
            _G.RainbowModule.disable()
        end
    end)
end)


run(function()
    local Players = _G.BeautifyServices.Players
    local LocalPlayer = _G.BeautifyServices.LocalPlayer
    
    _G.DeleteClothesModule = {
        enable = function()
            local char = LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("Shirt") or part:IsA("Pants") or part:IsA("ShirtGraphic") then
                        part:Destroy()
                    end
                end
            end
        end,
        
        disable = function()
            
        end
    }
    
    about:Toggle("删除全部衣服", "DeleteAllClothes", false, function(state)
        _G.BeautifyConfig.DeleteAllClothes = state
        if state then
            _G.DeleteClothesModule.enable()
        end
    end)
end)

run(function()
    local Players = _G.BeautifyServices.Players
    local LocalPlayer = _G.BeautifyServices.LocalPlayer
    
    LocalPlayer.CharacterAdded:Connect(function()
        
        task.wait(0.5)
        
        if _G.BeautifyConfig.Headless then
            _G.HeadlessModule.enable()
        end
        
        if _G.BeautifyConfig.BrokenLeg then
            _G.BrokenLegModule.enable()
        end
        
        if _G.BeautifyConfig.DeleteHats then
            _G.DeleteHatsModule.enable()
        end
        
        if _G.BeautifyConfig.RainbowCharacter then
            _G.RainbowModule.enable()
        end
        
        if _G.BeautifyConfig.DeleteAllClothes then
            _G.DeleteClothesModule.enable()
        end
    end)
end)

local FPS = PIJIAOBEN:section("FPS", false)

local FPSModule = {
    CurrentFPS = 60,
    DefaultFPS = 60,
    FPSLocked = false,
    FPSVisible = false,
    MSVisible = false,
    LockLoop = nil,
    UpdateConnection = nil,
    DisplayGui = nil,
    FPSText = nil,
    MSText = nil,
    FPSCount = 0,
    LastTime = nil,
    FPSEnabled = false  
}

local fpsOptions = {"30", "60", "75", "120", "144", "165", "240", "360", "max"}

local function SendNotification(text, duration)
    pcall(function()
        XPHUBNotification:Notification({
            Title = "FPS控制",
            Text = text,
            Icon = "rbxassetid://136169594232359",
            Duration = duration or 3
        })
    end)
end

FPS:Textbox("设置FPS", "FPS", "输入", function(value)
    local newFPS = tonumber(value)
    if newFPS and newFPS > 0 and newFPS <= 360 then
        FPSModule.CurrentFPS = newFPS
        if FPSModule.FPSEnabled or FPSModule.FPSLocked then
            setfpscap(FPSModule.CurrentFPS)
        end
    elseif value:lower() == "max" then
        FPSModule.CurrentFPS = 999
        if FPSModule.FPSEnabled or FPSModule.FPSLocked then
            setfpscap(999)
        end
    else
        SendNotification("无效FPS数值 (请输入1-360之间的数字或 'max')", 4)
    end
end)

FPS:Dropdown("FPS上限", "", fpsOptions, function(selected)
    if selected == "max" then
        FPSModule.CurrentFPS = 999
        if FPSModule.FPSEnabled or FPSModule.FPSLocked then
            setfpscap(999)
        end
    else
        local value = tonumber(selected)
        if value then
            FPSModule.CurrentFPS = value
            if FPSModule.FPSEnabled or FPSModule.FPSLocked then
                setfpscap(value)
            end
        end
    end
end)

FPS:Toggle("开启FPS", "", false, function(state)
    FPSModule.FPSEnabled = state
    if state then
        setfpscap(FPSModule.CurrentFPS)
    else
        setfpscap(0)
        if FPSModule.FPSLocked then
            FPSModule.FPSLocked = false
            if FPSModule.LockLoop then
                FPSModule.LockLoop:Disconnect()
                FPSModule.LockLoop = nil
            end
        end
    end
end)

FPS:Toggle("锁定FPS", "", false, function(state)
    FPSModule.FPSLocked = state
    
    if FPSModule.LockLoop then
        FPSModule.LockLoop:Disconnect()
        FPSModule.LockLoop = nil
    end
    
    if state then
        FPSModule.LockLoop = game:GetService("RunService").Heartbeat:Connect(function()
            setfpscap(FPSModule.CurrentFPS)
        end)
    end
end)

FPS:Button("恢复默认", function()
    FPSModule.CurrentFPS = FPSModule.DefaultFPS
    if FPSModule.FPSEnabled or FPSModule.FPSLocked then
        setfpscap(FPSModule.CurrentFPS)
    end
    SendNotification("已恢复默认FPS: " .. FPSModule.DefaultFPS, 2)
end)

FPS:Toggle("显示FPS", "", false, function(state)
    FPSModule.FPSVisible = state
    FPSModule:UpdateDisplay()
end)

FPS:Toggle("显示MS", "", false, function(state)
    FPSModule.MSVisible = state
    FPSModule:UpdateDisplay()
end)

function FPSModule:UpdateDisplay()
    if self.FPSVisible or self.MSVisible then
        if not self.DisplayGui then
            self.DisplayGui = Instance.new("ScreenGui")
            self.DisplayGui.Name = "FPS_MS_Display"
            self.DisplayGui.ResetOnSpawn = false
            self.DisplayGui.Parent = game:GetService("CoreGui")
            
            self.FPSText = Instance.new("TextLabel")
            self.FPSText.Name = "FPSText"
            self.FPSText.Parent = self.DisplayGui
            self.FPSText.Size = UDim2.new(0, 200, 0, 35)
            self.FPSText.Position = UDim2.new(1, -210, 0, 2)
            self.FPSText.Text = "FPS: 0.0"
            self.FPSText.BackgroundTransparency = 1
            self.FPSText.TextColor3 = Color3.new(0, 255, 0)
            self.FPSText.TextSize = 25
            self.FPSText.Font = Enum.Font.SourceSansBold
            self.FPSText.TextXAlignment = Enum.TextXAlignment.Right
            
            self.MSText = Instance.new("TextLabel")
            self.MSText.Name = "MSText"
            self.MSText.Parent = self.DisplayGui
            self.MSText.Size = UDim2.new(0, 200, 0, 35)
            self.MSText.Position = UDim2.new(1, -210, 0, 37)  
            self.MSText.Text = "MS: 0.0"
            self.MSText.BackgroundTransparency = 1
            self.MSText.TextColor3 = Color3.new(0, 255, 255)
            self.MSText.TextSize = 25
            self.MSText.Font = Enum.Font.SourceSansBold
            self.MSText.TextXAlignment = Enum.TextXAlignment.Right
        end
        
        self.FPSText.Visible = self.FPSVisible
        self.MSText.Visible = self.MSVisible
        
        if self.FPSVisible and self.MSVisible then
            self.FPSText.Position = UDim2.new(1, -210, 0, 2)
            self.MSText.Position = UDim2.new(1, -210, 0, 37)
        elseif self.FPSVisible then
            self.FPSText.Position = UDim2.new(1, -210, 0, 2)
        elseif self.MSVisible then
            self.MSText.Position = UDim2.new(1, -210, 0, 2)
        end
        
        if not self.UpdateConnection then
            self.LastTime = tick()
            self.FPSCount = 0
            
            self.UpdateConnection = game:GetService("RunService").RenderStepped:Connect(function()
                self.FPSCount = self.FPSCount + 1
                local currentTime = tick()
                local delta = currentTime - self.LastTime
                
                if delta >= 0.5 then
                    local fps = self.FPSCount / delta
                    local ms = (delta / self.FPSCount) * 1000
                    
                    if self.FPSVisible and self.FPSText then
                        self.FPSText.Text = string.format("FPS: %.1f", fps)
                        if fps >= 60 then
                            self.FPSText.TextColor3 = Color3.new(0, 1, 0)
                        elseif fps >= 30 then
                            self.FPSText.TextColor3 = Color3.new(1, 1, 0)
                        else
                            self.FPSText.TextColor3 = Color3.new(1, 0, 0)
                        end
                    end
                    
                    if self.MSVisible and self.MSText then
                        self.MSText.Text = string.format("MS: %.1f", ms)
                        if ms <= 16 then
                            self.MSText.TextColor3 = Color3.new(0, 1, 0)
                        elseif ms <= 33 then
                            self.MSText.TextColor3 = Color3.new(1, 1, 0)
                        else
                            self.MSText.TextColor3 = Color3.new(1, 0, 0)
                        end
                    end
                    
                    self.FPSCount = 0
                    self.LastTime = currentTime
                end
            end)
        end
    else
        if self.UpdateConnection then
            self.UpdateConnection:Disconnect()
            self.UpdateConnection = nil
        end
        if self.DisplayGui then
            self.DisplayGui:Destroy()
            self.DisplayGui = nil
            self.FPSText = nil
            self.MSText = nil
        end
        self.LastTime = nil
        self.FPSCount = 0
    end
end

function FPSModule:Init()
    self.LastTime = tick()
    self.FPSCount = 0
end

FPSModule:Init()

game:GetService("Players").LocalPlayer.OnTeleport:Connect(function()
    if FPSModule.UpdateConnection then
        FPSModule.UpdateConnection:Disconnect()
        FPSModule.UpdateConnection = nil
    end
    if FPSModule.LockLoop then
        FPSModule.LockLoop:Disconnect()
        FPSModule.LockLoop = nil
    end
    if FPSModule.DisplayGui then
        FPSModule.DisplayGui:Destroy()
        FPSModule.DisplayGui = nil
    end
    FPSModule.LastTime = nil
    FPSModule.FPSCount = 0
end)

local about = PIJIAOBEN:section("自动朝向", false)

local plr = game:GetService("Players").LocalPlayer
local char = nil
local flags = {
    rotation = false
}

local settings = {
    attackRange = 15
}

local verification = {
    teamCheck = false,
    aliveCheck = false,
    friendCheck = false,
    wallCheck = false,
    npcCheck = false  
}

local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

local connection = nil

local function isNPC(target)
    if Players:GetPlayerFromCharacter(target) then
        return false
    end
    
    if CollectionService:HasTag(target, "NPC") or 
       CollectionService:HasTag(target, "npc") or
       CollectionService:HasTag(target, "Enemy") or
       CollectionService:HasTag(target, "enemy") then
        return true
    end
    
    local name = target.Name:lower()
    if name:find("npc") or 
       name:find("enemy") or 
       name:find("怪物") or 
       name:find("boss") or
       name:find("mob") then
        return true
    end
   
    local humanoid = target:FindFirstChildOfClass("Humanoid")
    if humanoid then
        if humanoid:GetAttribute("IsNPC") or
           humanoid:GetAttribute("isNPC") then
            return true
        end
      
        if not Players:GetPlayerFromCharacter(target) then
            local hasPlayerController = false
            for _, descendant in ipairs(target:GetDescendants()) do
                if descendant:IsA("PlayerController") or
                   descendant:IsA("Controller") then
                    hasPlayerController = true
                    break
                end
            end
            if not hasPlayerController then
                return true
            end
        end
    end
    
    return false
end

local function Distance(target)
    if not char or not char:FindFirstChild("HumanoidRootPart") then 
        return math.huge 
    end
    local targetPart = target.PrimaryPart or target:FindFirstChild("HumanoidRootPart")
    if not targetPart then return math.huge end
    return (char.HumanoidRootPart.Position - targetPart.Position).magnitude
end

local function isFriend(targetPlayer)
    local success, result = pcall(function()
        return plr:IsFriendsWith(targetPlayer.UserId)
    end)
    return success and result
end

local function isDead(targetPlayer)
    local targetChar = targetPlayer.Character
    if not targetChar or not targetChar:FindFirstChildOfClass("Humanoid") then
        return true
    end
    return targetChar.Humanoid.Health <= 0
end

local function isSameTeam(targetPlayer)
    return plr.Team and targetPlayer.Team and plr.Team == targetPlayer.Team
end

local function isWallBetween(targetPlayer)
    if not verification.wallCheck then return false end
    
    local targetChar = targetPlayer.Character
    if not targetChar then return false end
    
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    if not targetRoot then return false end
    
    if not char then return false end
    
    local rayOrigin = char.HumanoidRootPart.Position
    local direction = (targetRoot.Position - rayOrigin)
    local rayDistance = direction.Magnitude
    direction = direction.Unit
    
    local ignoreList = {char, targetChar}
    
    for _, descendant in ipairs(char:GetDescendants()) do
        if descendant:IsA("BasePart") then
            table.insert(ignoreList, descendant)
        end
    end
    
    for _, descendant in ipairs(targetChar:GetDescendants()) do
        if descendant:IsA("BasePart") then
            table.insert(ignoreList, descendant)
        end
    end
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = ignoreList
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.IgnoreWater = true
    
    local raycastResult = workspace:Raycast(rayOrigin, direction * rayDistance, raycastParams)
    
    return raycastResult ~= nil
end

local function shouldSkipTarget(targetPlayer)
    if targetPlayer == plr then
        return true
    end
    
    if verification.teamCheck and isSameTeam(targetPlayer) then
        return true
    end
    
    if verification.friendCheck and isFriend(targetPlayer) then
        return true
    end
    
    if verification.aliveCheck and isDead(targetPlayer) then
        return true
    end
    
    if verification.wallCheck and isWallBetween(targetPlayer) then
        return true
    end
    
    return false
end

local function scanForNPCs()
    local npcs = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj ~= char then
            local humanoid = obj:FindFirstChildOfClass("Humanoid")
            local rootPart = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart
            if humanoid and rootPart and humanoid.Health > 0 then
                if isNPC(obj) then
                    table.insert(npcs, obj)
                end
            end
        end
    end
    return npcs
end

task.spawn(function()
    while not char do
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            char = plr.Character
        else
            task.wait(0.1)
        end
    end
end)

plr.CharacterAdded:Connect(function(newChar)
    char = newChar
end)

about:Toggle("开启/关闭自动朝向", "", false, function(Value)
    flags.rotation = Value
    
    if Value then
        connection = RunService.Heartbeat:Connect(function()
            if not flags.rotation or not char or not char:FindFirstChild("HumanoidRootPart") then return end
            
            pcall(function()
                for _, player in pairs(Players:GetPlayers()) do
                    if not shouldSkipTarget(player) then
                        local targetChar = player.Character
                        if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
                            if Distance(targetChar) <= settings.attackRange then  
                                local humanoid = char:FindFirstChildOfClass("Humanoid")
                                if humanoid then
                                    local wasAutoRotate = humanoid.AutoRotate
                                    humanoid.AutoRotate = false
                                    local pos = targetChar.HumanoidRootPart.Position
                                    char.HumanoidRootPart.CFrame = CFrame.lookAt(
                                        char.HumanoidRootPart.Position,
                                        Vector3.new(pos.X, char.HumanoidRootPart.Position.Y, pos.Z)
                                    )
                                    humanoid.AutoRotate = wasAutoRotate
                                end
                            end
                        end
                    end
                end
                
                if verification.npcCheck then
                    local npcs = scanForNPCs()
                    for _, npc in ipairs(npcs) do
                        local rootPart = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
                        if rootPart and Distance(npc) <= settings.attackRange then
                            local humanoid = char:FindFirstChildOfClass("Humanoid")
                            if humanoid then
                                local wasAutoRotate = humanoid.AutoRotate
                                humanoid.AutoRotate = false
                                local pos = rootPart.Position
                                char.HumanoidRootPart.CFrame = CFrame.lookAt(
                                    char.HumanoidRootPart.Position,
                                    Vector3.new(pos.X, char.HumanoidRootPart.Position.Y, pos.Z)
                                )
                                humanoid.AutoRotate = wasAutoRotate
                            end
                        end
                    end
                end
            end)
        end)
    else
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end)

about:Textbox("设置自动朝向范围", '', "输入", function(Value)
    local num = tonumber(Value)
    if num and num > 0 then
        settings.attackRange = num
    end
end)

about:Toggle("团队验证", "SkipTeam", false, function(Value)
    verification.teamCheck = Value
end)

about:Toggle("活体验证", "SkipDead", false, function(Value)
    verification.aliveCheck = Value
end)

about:Toggle("好友验证", "SkipFriends", false, function(Value)
    verification.friendCheck = Value
end)

about:Toggle("墙壁验证", "SkipWalls", false, function(Value)
    verification.wallCheck = Value
end)

about:Toggle("朝向NPC", "NPC Check", false, function(Value)
    verification.npcCheck = Value
end)

local ToolTestVersion = PIJIAOBEN:section("开发工具", false)

ToolTestVersion:Button("控制台", function()
game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
end)
ToolTestVersion:Button("汉化版Dex", function()
loadstring(game:HttpGet("https://gitee.com/cmbhbh/cmbh/raw/master/Bex.lua"))()
end)
ToolTestVersion:Button("DEX-ExplorerV1 Mobile", function()
getgenv().Key = "Bash"
loadstring(game:HttpGet("https://raw.githubusercontent.com/crceck123/roblox-script/main/MC_IY%20Dex.txt"))()
end)
ToolTestVersion:Button("DEX-ExplorerV1 Mobile", function()
loadstring(game:HttpGet("https://github.com/XiaoYunCN/VIP/raw/main/DEX-Explorer_Mobile.lua", true))()
end)
ToolTestVersion:Button("DEX-ExplorerV2", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IlIlIlIlIlIlIlIlIlIlIlIlIlIlIlIl/Script/main/Tools/Dex-ExplorerV2.lua", true))()
end)
ToolTestVersion:Button("DEX-V3", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IlIlIlIlIlIlIlIlIlIlIlIlIlIlIlIl/Script/main/Tools/DarkDexV3.lua", true))()
end)
ToolTestVersion:Button("SimpleSpy", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IlIlIlIlIlIlIlIlIlIlIlIlIlIlIlIl/Script/main/Tools/SimpleSpyMobile.lua", true))()
end)
ToolTestVersion:Button("FrostHook_Spy", function()
loadstring(game:HttpGet("https://github.com/Nootchtai/FrostHook_Spy/raw/master/Spy.lua", true))()
end)
ToolTestVersion:Button("WebHook工具", function()
loadstring(game:HttpGet("https://github.com/XiaoYunUwU/XiaoYunUwU/raw/main/WebhookTool", true))()
end)

local about = PIJIAOBEN:section("车辆加速", false)

local run = function(func) func() end

run(function()
    _G.VehicleAccelConfig = {
        enabled = false,
        fixedGui = false,
        accelerating = false,
        currentSpeed = 0,
        maxSpeed = 300,
        accelRate = 5,
        decelRate = 10,
        button = nil,
        border = nil,
        connection = nil,
        screenGui = nil
    }
end)

run(function()
    _G.VehicleAccelServices = {
        RunService = game:GetService("RunService"),
        Players = game:GetService("Players"),
        LocalPlayer = game:GetService("Players").LocalPlayer,
        CoreGui = game:GetService("CoreGui")
    }
end)

run(function()
    local getRainbowColor = function()
        local hue = (tick() % 5) / 5
        return Color3.fromHSV(hue, 1, 1)
    end
    
    _G.VehicleAccelUI = {
        createButton = function(screenGui)
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(0, 90, 0, 50)
            button.Position = UDim2.new(0.5, 250, 1, -210)
            button.AnchorPoint = Vector2.new(0.5, 1)
            button.Text = "加速"
            button.Font = Enum.Font.SourceSansBold
            button.TextSize = 24
            button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            button.BackgroundTransparency = 0.5
            button.TextColor3 = Color3.new(1, 1, 1)
            button.Parent = screenGui
            button.Draggable = not _G.VehicleAccelConfig.fixedGui
            button.Visible = _G.VehicleAccelConfig.enabled
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = button
            
            local border = Instance.new("Frame")
            border.Size = UDim2.new(1, 4, 1, 4)
            border.Position = UDim2.new(0, -2, 0, -2)
            border.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            border.BorderSizePixel = 0
            border.Parent = button
            border.ZIndex = 0
            
            local borderCorner = Instance.new("UICorner")
            borderCorner.CornerRadius = UDim.new(0, 10)
            borderCorner.Parent = border
            
            spawn(function()
                while border and border.Parent do
                    border.BackgroundColor3 = getRainbowColor()
                    wait(0.1)
                end
            end)
            
            button.MouseButton1Down:Connect(function()
                _G.VehicleAccelConfig.accelerating = true
            end)
            
            button.MouseButton1Up:Connect(function()
                _G.VehicleAccelConfig.accelerating = false
            end)
            
            _G.VehicleAccelConfig.button = button
            _G.VehicleAccelConfig.border = border
        end,
        
        destroyButton = function()
            if _G.VehicleAccelConfig.button then
                _G.VehicleAccelConfig.button:Destroy()
                _G.VehicleAccelConfig.button = nil
                _G.VehicleAccelConfig.border = nil
            end
        end,
        
        setVisible = function(visible)
            if _G.VehicleAccelConfig.button then
                _G.VehicleAccelConfig.button.Visible = visible
            end
        end,
        
        setDraggable = function(draggable)
            if _G.VehicleAccelConfig.button then
                _G.VehicleAccelConfig.button.Draggable = draggable
            end
        end,
        
        createGui = function()
            if _G.VehicleAccelConfig.screenGui then
                _G.VehicleAccelConfig.screenGui:Destroy()
            end
            
            local screenGui = Instance.new("ScreenGui")
            screenGui.Name = "VehicleAccelGui"
            screenGui.Parent = _G.VehicleAccelServices.CoreGui
            _G.VehicleAccelConfig.screenGui = screenGui
            
            _G.VehicleAccelUI.createButton(screenGui)
        end,
        
        destroyGui = function()
            if _G.VehicleAccelConfig.screenGui then
                _G.VehicleAccelConfig.screenGui:Destroy()
                _G.VehicleAccelConfig.screenGui = nil
                _G.VehicleAccelConfig.button = nil
                _G.VehicleAccelConfig.border = nil
            end
        end
    }
end)

run(function()
    local RunService = _G.VehicleAccelServices.RunService
    local LocalPlayer = _G.VehicleAccelServices.LocalPlayer
    
    _G.VehicleAccelCore = {
        update = function(dt)
            local character = LocalPlayer.Character
            if not character then return end
            
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if not humanoid then return end
            
            local seatPart = humanoid.SeatPart
            if not seatPart then return end
            
            local vehicle = seatPart:FindFirstAncestorOfClass("Model")
            if not vehicle then return end
            
            local part = vehicle.PrimaryPart or vehicle:FindFirstChildWhichIsA("BasePart", true)
            if not part then return end
            
            local config = _G.VehicleAccelConfig
            
            if config.accelerating then
                config.currentSpeed = math.clamp(config.currentSpeed + config.accelRate, 0, config.maxSpeed)
                if config.button then
                    config.button.Text = tostring(math.floor(config.currentSpeed))
                end
            elseif config.currentSpeed > 0 then
                config.currentSpeed = math.max(0, config.currentSpeed - config.decelRate)
                if config.button then
                    config.button.Text = tostring(math.floor(config.currentSpeed))
                end
            end
            
            if config.currentSpeed > 0 then
                local velocity = part.AssemblyLinearVelocity
                local lookVector = seatPart.CFrame.LookVector
                part.AssemblyLinearVelocity = velocity + (lookVector * (config.currentSpeed * dt))
            end
        end,
        
        start = function()
            if _G.VehicleAccelConfig.connection then
                _G.VehicleAccelConfig.connection:Disconnect()
            end
            _G.VehicleAccelConfig.connection = RunService.RenderStepped:Connect(function(dt)
                if _G.VehicleAccelConfig.enabled then
                    _G.VehicleAccelCore.update(dt)
                end
            end)
        end,
        
        stop = function()
            if _G.VehicleAccelConfig.connection then
                _G.VehicleAccelConfig.connection:Disconnect()
                _G.VehicleAccelConfig.connection = nil
            end
        end
    }
end)

run(function()
    _G.VehicleAccelUI.createGui()
    
    about:Toggle("车辆加速", "Toggle", false, function(Value)
        _G.VehicleAccelConfig.enabled = Value
        _G.VehicleAccelUI.setVisible(Value)
        
        if Value then
            _G.VehicleAccelCore.start()
        else
            _G.VehicleAccelCore.stop()
            _G.VehicleAccelConfig.accelerating = false
            _G.VehicleAccelConfig.currentSpeed = 0
            if _G.VehicleAccelConfig.button then
                _G.VehicleAccelConfig.button.Text = "加速"
            end
        end
    end)
    
    about:Toggle("固定加速按钮", "FixGui", false, function(Value)
        _G.VehicleAccelConfig.fixedGui = Value
        _G.VehicleAccelUI.setDraggable(not Value)
    end)
    
    about:Textbox("最大速度", "MaxSpeed", "300", function(value)
        local num = tonumber(value)
        if num and num > 0 then
            _G.VehicleAccelConfig.maxSpeed = num
        end
    end)
    
    about:Textbox("每帧加速速度", "AccelRate", "5", function(value)
        local num = tonumber(value)
        if num and num > 0 then
            _G.VehicleAccelConfig.accelRate = num
        end
    end)
    
    about:Textbox("每帧减速速度", "DecelRate", "10", function(value)
        local num = tonumber(value)
        if num and num > 0 then
            _G.VehicleAccelConfig.decelRate = num
        end
    end)
end)

run(function()
    local Players = _G.VehicleAccelServices.Players
    local LocalPlayer = Players.LocalPlayer
    
    LocalPlayer.CharacterAdded:Connect(function()
        _G.VehicleAccelConfig.accelerating = false
        _G.VehicleAccelConfig.currentSpeed = 0
        if _G.VehicleAccelConfig.button then
            _G.VehicleAccelConfig.button.Text = "加速"
        end
    end)
end)

local SaveSection = PIJIAOBEN:section("坐标", false)

local run = function(func) func() end

run(function()
    _G.CoordConfig = {
        tempCoord = "",
        tempPos = {x = 0, y = 0, z = 0},
        inputName = "",
        importInput = "",
        manualInput = "",
        folderName = "坐标记录",
        savedCoordinates = {},
        buttonHistory = {}
    }
end)

run(function()
    _G.CoordServices = {
        Players = game:GetService("Players"),
        RunService = game:GetService("RunService"),
        LocalPlayer = game:GetService("Players").LocalPlayer,
        StarterGui = game:GetService("StarterGui"),
        HttpService = game:GetService("HttpService")
    }
end)

run(function()
    local folderName = _G.CoordConfig.folderName
    
    _G.CoordFile = {
        init = function()
            if not isfolder(folderName) then
                makefolder(folderName)
            end
        end,
        
        getCoordinateList = function()
            local files = listfiles(folderName)
            local coords = {}
            for _, file in ipairs(files) do
                local name = file:match("([^\\/]+)%.txt$")
                if name then
                    local content = readfile(file)
                    local x, y, z = content:match("([%-%d%.]+),?%s*([%-%d%.]+),?%s*([%-%d%.]+)")
                    if x and y and z then
                        table.insert(coords, {
                            name = name,
                            x = tonumber(x),
                            y = tonumber(y),
                            z = tonumber(z),
                            file = file
                        })
                    end
                end
            end
            return coords
        end,
        
        saveCoordinate = function(name, pos)
            local filePath = folderName .. "/" .. name .. ".txt"
            if isfile(filePath) then
                return false, "坐标名称已存在"
            end
            writefile(filePath, string.format("%.2f,%.2f,%.2f", pos.X, pos.Y, pos.Z))
            return true, "保存成功"
        end,
        
        quickSave = function(pos)
            local timeStr = os.date("%Y%m%d_%H%M%S")
            local fileName = "坐标_" .. timeStr
            local filePath = folderName .. "/" .. fileName .. ".txt"
            writefile(filePath, string.format("%.2f,%.2f,%.2f", pos.X, pos.Y, pos.Z))
            return fileName
        end,
        
        deleteCoordinate = function(name)
            local filePath = folderName .. "/" .. name .. ".txt"
            if isfile(filePath) then
                delfile(filePath)
                return true
            end
            return false
        end,
        
        updateCoordinate = function(name, pos)
            local filePath = folderName .. "/" .. name .. ".txt"
            if isfile(filePath) then
                writefile(filePath, string.format("%.2f,%.2f,%.2f", pos.X, pos.Y, pos.Z))
                return true
            end
            return false
        end
    }
end)

run(function()
    local LocalPlayer = _G.CoordServices.LocalPlayer
    
    _G.CoordTeleport = {
        teleportToPos = function(targetPos)
            local character = LocalPlayer.Character
            if character then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    rootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
                    return true
                end
            end
            return false
        end,
        
        getCurrentPos = function()
            local character = LocalPlayer.Character
            if character then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local pos = rootPart.Position
                    return pos.X, pos.Y, pos.Z
                end
            end
            return nil, nil, nil
        end
    }
end)

run(function()
    local function sendNotification(title, text, isError)
        local notification = {
            Title = title or "星脚本",
            Text = text,
            Icon = "rbxassetid://136169594232359",
            Duration = 3
        }
        
        if isError then
            notification.Title = "错误"
            notification.Text = text
        end
        
        if XPHUBNotification and XPHUBNotification.Notification then
            XPHUBNotification:Notification(notification)
        end
    end
    
    _G.CoordNotification = {
        success = function(text)
            sendNotification("星脚本", text)
        end,
        
        error = function(text)
            sendNotification("错误", text, true)
        end,
        
        info = function(text)
            sendNotification("提示", text)
        end
    }
end)

run(function()
    local LocalPlayer = _G.CoordServices.LocalPlayer
    local RunService = _G.CoordServices.RunService
    local folderName = _G.CoordConfig.folderName
    local SaveSection = SaveSection
    local ListSection = ListSection
    
    _G.CoordFile.init()
    
    local coordDisplay = SaveSection:Label("当前坐标: 获取中...")
    
    local function updateCurrentCoord()
        local x, y, z = _G.CoordTeleport.getCurrentPos()
        if x and y and z then
            _G.CoordConfig.tempPos = {x = x, y = y, z = z}
            coordDisplay.Text = string.format("当前坐标: X:%.1f Y:%.1f Z:%.1f", x, y, z)
        else
            coordDisplay.Text = "当前坐标: 无法获取"
        end
    end
    
    updateCurrentCoord()
    
    RunService.RenderStepped:Connect(function()
        updateCurrentCoord()
    end)
    
    SaveSection:Button("复制当前坐标", function()
        local x, y, z = _G.CoordTeleport.getCurrentPos()
        if x and y and z then
            local coordText = string.format("%.2f, %.2f, %.2f", x, y, z)
            setclipboard(coordText)
            _G.CoordNotification.success("坐标已复制")
        else
            _G.CoordNotification.error("请先获取坐标")
        end
    end)
    
    SaveSection:Textbox("位置名", "输入名字", "输入位置名称(留空自动命名)", function(val)
        _G.CoordConfig.inputName = val
    end)
    
    SaveSection:Button("保存位置", function()
        local x, y, z = _G.CoordTeleport.getCurrentPos()
        if not x or not y or not z then
            _G.CoordNotification.error("无法获取当前位置")
            return
        end
        
        local name = _G.CoordConfig.inputName
        if name == "" then
            local timeStr = os.date("%H%M%S")
            name = "坐标_" .. timeStr
        end
        
        local success, msg = _G.CoordFile.saveCoordinate(name, Vector3.new(x, y, z))
        if success then
            _G.CoordNotification.success("已保存: " .. name)
            _G.CoordConfig.inputName = ""
        else
            _G.CoordNotification.error(msg)
        end
    end)
    
    SaveSection:Button("快速保存", function()
        local x, y, z = _G.CoordTeleport.getCurrentPos()
        if x and y and z then
            local fileName = _G.CoordFile.quickSave(Vector3.new(x, y, z))
            _G.CoordNotification.success("快速保存: " .. fileName)
        else
            _G.CoordNotification.error("无法获取当前位置")
        end
    end)
    
    SaveSection:Textbox("删除位置名", "删除名字", "输入要删除的位置名称", function(val)
        _G.CoordConfig.inputName = val
    end)
    
    SaveSection:Button("删除位置", function()
        if _G.CoordConfig.inputName == "" then
            _G.CoordNotification.error("请输入要删除的位置名称")
            return
        end
        
        local success = _G.CoordFile.deleteCoordinate(_G.CoordConfig.inputName)
        if success then
            _G.CoordNotification.success("已删除: " .. _G.CoordConfig.inputName)
            _G.CoordConfig.inputName = ""
        else
            _G.CoordNotification.error("未找到文件: " .. _G.CoordConfig.inputName)
        end
    end)
    
    SaveSection:Button("导出所有坐标", function()
        local coords = _G.CoordFile.getCoordinateList()
        if #coords == 0 then
            _G.CoordNotification.error("没有保存的坐标")
            return
        end
        
        local exportData = {}
        for _, coord in ipairs(coords) do
            table.insert(exportData, string.format("%s: %.2f,%.2f,%.2f", coord.name, coord.x, coord.y, coord.z))
        end
        
        local exportText = table.concat(exportData, "\n")
        setclipboard(exportText)
        _G.CoordNotification.success("已导出 " .. #coords .. " 个坐标到剪贴板")
    end)
    
    SaveSection:Button("清空所有坐标", function()
        local coords = _G.CoordFile.getCoordinateList()
        if #coords == 0 then
            _G.CoordNotification.error("没有保存的坐标")
            return
        end
        
        for _, coord in ipairs(coords) do
            _G.CoordFile.deleteCoordinate(coord.name)
        end
        _G.CoordNotification.success("已清空 " .. #coords .. " 个坐标")
    end)
    
    SaveSection:Textbox("导入坐标", "导入坐标", "名称 X,Y,Z", function(val)
        _G.CoordConfig.importInput = val
    end)
    
    SaveSection:Button("导入单个坐标", function()
        if not _G.CoordConfig.importInput or _G.CoordConfig.importInput == "" then
            _G.CoordNotification.error("请输入: 名称 X,Y,Z")
            return
        end
        
        local name, x, y, z = _G.CoordConfig.importInput:match("([^%s]+)%s+([%-%d%.]+),([%-%d%.]+),([%-%d%.]+)")
        if name and x and y and z then
            local success, msg = _G.CoordFile.saveCoordinate(name, Vector3.new(tonumber(x), tonumber(y), tonumber(z)))
            if success then
                _G.CoordNotification.success("已导入: " .. name)
            else
                _G.CoordNotification.error(msg)
            end
        else
            _G.CoordNotification.error("格式错误，请使用: 名称 X,Y,Z")
        end
    end)
    
    local function loadButtons()
        local coords = _G.CoordFile.getCoordinateList()
        
        for _, coord in ipairs(coords) do
            if not _G.CoordConfig.buttonHistory[coord.name] then
                _G.CoordConfig.buttonHistory[coord.name] = true
                ListSection:Button("传送: " .. coord.name .. " (" .. coord.x .. "," .. coord.y .. "," .. coord.z .. ")", function()
                    local success = _G.CoordTeleport.teleportToPos(Vector3.new(coord.x, coord.y, coord.z))
                    if success then
                        _G.CoordNotification.success("已传送到: " .. coord.name)
                    else
                        _G.CoordNotification.error("传送失败，角色不存在")
                    end
                end)
            end
        end
    end
    
    SaveSection:Button("刷新列表", function()
        loadButtons()
        _G.CoordNotification.success("列表已刷新")
    end)
    
    SaveSection:Button("传送到当前位置", function()
        local x, y, z = _G.CoordTeleport.getCurrentPos()
        if x and y and z then
            _G.CoordTeleport.teleportToPos(Vector3.new(x, y, z))
            _G.CoordNotification.success("已传送到当前位置")
        else
            _G.CoordNotification.error("无法获取当前位置")
        end
    end)
    
    SaveSection:Textbox("输入坐标传送", "输入坐标", "X Y Z 或 X,Y,Z", function(val)
        _G.CoordConfig.manualInput = val
    end)
    
    SaveSection:Button("传送到输入坐标", function()
        if not _G.CoordConfig.manualInput or _G.CoordConfig.manualInput == "" then
            _G.CoordNotification.error("请输入坐标")
            return
        end
        
        local x, y, z = _G.CoordConfig.manualInput:match("([%-%d%.]+)[%s,]+([%-%d%.]+)[%s,]+([%-%d%.]+)")
        if x and y and z then
            local success = _G.CoordTeleport.teleportToPos(Vector3.new(tonumber(x), tonumber(y), tonumber(z)))
            if success then
                _G.CoordNotification.success(string.format("已传送到 (%.1f, %.1f, %.1f)", tonumber(x), tonumber(y), tonumber(z)))
            else
                _G.CoordNotification.error("传送失败")
            end
        else
            _G.CoordNotification.error("格式错误，请使用: X Y Z 或 X,Y,Z")
        end
    end)
    
    pcall(loadButtons)
end)

local PIJIAOBEN = UI:CreateTab(Window, "选择服务器", "136169594232359")

local about = PIJIAOBEN:section("选择服务器", true)

local run = function(func) func() end

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

} --[[迁移修复: 闭合 _G.ScriptLoaderConfig = { ... }]]

run(function()
    about:Dropdown("选择服务器", "ServerSelector", {"伐木大亨2", "在超市生活一周","极速传奇","森林99夜","忍者传奇","种植花园","战争大亨"}, function(Value)
        _G.ScriptLoaderConfig.selectedScript = Value
    end)
    
    about:Button("执行选择的服务器的脚本", function()
        if _G.ScriptLoaderConfig.scripts[_G.ScriptLoaderConfig.selectedScript] then
            loadstring(_G.ScriptLoaderConfig.scripts[_G.ScriptLoaderConfig.selectedScript])()
        else
            XPHUBNotification:Notification({
                Title = "星脚本",
                Text = "请先选择一个脚本",
                Icon = "rbxassetid://136169594232359",
                Duration = 3
            })
        end
    end)
    
    about:Button("复制选择的服务器的脚本", function()
        if _G.ScriptLoaderConfig.scripts[_G.ScriptLoaderConfig.selectedScript] then
            setclipboard(_G.ScriptLoaderConfig.scripts[_G.ScriptLoaderConfig.selectedScript])
            XPHUBNotification:Notification({
                Title = "星脚本",
                Text = "已复制脚本",
                Icon = "rbxassetid://136169594232359",
                Duration = 3
            })
        else
            XPHUBNotification:Notification({
                Title = "星脚本",
                Text = "请先选择一个脚本",
                Icon = "rbxassetid://136169594232359",
                Duration = 3
            })
        end
    end)
    
    about:Button("执行当前服务器的脚本", function()
        local gameId = game.GameId
        local placeId = game.PlaceId
        
        local scriptName = _G.ScriptLoaderConfig.gameMapping[gameId] or _G.ScriptLoaderConfig.gameMapping[placeId]
        
        if scriptName and _G.ScriptLoaderConfig.scripts[scriptName] then
            loadstring(_G.ScriptLoaderConfig.scripts[scriptName])()
        else
            XPHUBNotification:Notification({
                Title = "星脚本",
                Text = "星脚本暂未支持当前服务器",
                Icon = "rbxassetid://136169594232359",
                Duration = 3
            })
        end
    end)
end)
end)

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

--[[
  默认选中首页(信息): 现在所有功能页都在【同一个】左侧导航栏(Tabs)里各注册了一个 PageButton,
  点击 PageButton 会触发库的切换逻辑(隐藏其它 Page, 显示自己)。这里在加载完成后,
  找到导航栏里的第一个 PageButton 并模拟点击, 让"信息"页默认可见。
  若 Fire 不可用则降级: 直接显示第一个 Page ScrollingFrame。
--]]


do
    local tabs = nil
    for _, v in ipairs(Window:GetChildren()) do
        if v:IsA("Frame") and v.Name == "Tabs" then
            tabs = v
            break
        end
    end

    local firstBtn = nil
    if tabs then
        for _, b in ipairs(tabs:GetChildren()) do
            if b:IsA("TextButton") and b.Name == "PageButton" then
                firstBtn = b
                break
            end
        end
    end

    if firstBtn then
        local ok = pcall(function()
            firstBtn.MouseButton1Down:Fire()
        end)
        if not ok then
            local idx = 0
            for _, b in ipairs(tabs:GetChildren()) do
                if b:IsA("TextButton") and b.Name == "PageButton" then
                    idx = idx + 1
                    if idx == 1 then
                        b.MouseButton1Down:Fire()
                        break
                    end
                end
            end
        end
    end
end

