--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.9) ~  Much Love, Ferib 

]]--

-- Example Code:
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local HttpService = game:GetService("HttpService")
local configFileName = "MysteryHub_Config.json"

-- ==================== CONFIG ====================
local function SaveConfig(state)
    local data = HttpService:JSONEncode(state)
    writefile(configFileName, data)
end
local function LoadConfig()
    if isfile(configFileName) then
        local data = readfile(configFileName)
        return HttpService:JSONDecode(data)
    end
    return nil
end
local savedData = LoadConfig()
local State = {
    AUTO_Mod = savedData and savedData.AUTO_Mod or false,
    Select_Mode = savedData and savedData.Select_Mode or "Desert",
    Select_UnitSet = savedData and savedData.Select_UnitSet or "Set 1 (Desert)",
    Hide_Attackers = savedData and savedData.Hide_Attackers or true,
    AUTO_Farm = savedData and savedData.AUTO_Farm or false,
}

-- ==================== VARIABLES ====================
getgenv().Language = "TH"
getgenv().AutoSummon = false
getgenv().AutoSummonEx = false
getgenv().SummonMode = "Summon 10"
getgenv().SummonModeEx = "Exclusive 10"
getgenv().MysticNotify = true
getgenv().SummonArgs1 = nil
getgenv().SummonArgs10 = nil
getgenv().SummonArgsEx1 = nil
getgenv().SummonArgsEx10 = nil
getgenv().LastSummonMode = nil

local Remote = game:GetService("ReplicatedStorage")
    :WaitForChild("NetworkingContainer")
    :WaitForChild("DataRemote")

-- ==================== LANGUAGE ====================
local Lang = {
    TH = {
        SummonTab = "Summon", SettingsTab = "ตั้งค่า", FarmTab = "Farm",
        CatchSection = "CATCH REMOTE", AutoSection = "AUTO SUMMON",
        ExCatchSection = "⭐ CATCH EXCLUSIVE", ExAutoSection = "⭐ AUTO EXCLUSIVE",
        MysticSection = "MYSTIC NOTIFIER",
        LangSection = "LANGUAGE", SysSection = "SYSTEM",
        Catch1 = "จับค่า Summon 1", Catch1Desc = "กดแล้วกดสุ่ม 1 ครั้งในเกม",
        Catch10 = "จับค่า Summon 10", Catch10Desc = "กดแล้วกดสุ่ม 10 ครั้งในเกม",
        CatchEx1 = "จับค่า Exclusive 1", CatchEx1Desc = "กดแล้วกดสุ่ม Exclusive 1 ครั้ง",
        CatchEx10 = "จับค่า Exclusive 10", CatchEx10Desc = "กดแล้วกดสุ่ม Exclusive 10 ครั้ง",
        SelectMode = "เลือกโหมดสุ่ม", SelectModeEx = "เลือกโหมด Exclusive",
        AutoSummon = "Auto Summon", AutoSummonEx = "Auto Exclusive Summon",
        MysticNotifyToggle = "Mystic Notifier", MysticNotifyDesc = "แจ้งเตือนเมื่อสุ่มได้ตัว Mystic",
        Language = "เปลี่ยนภาษา", Destroy = "ปิด UI", DestroyDesc = "ปิดและลบ UI",
        Success1 = "จับค่า Summon 1 สำเร็จ", Success10 = "จับค่า Summon 10 สำเร็จ",
        SuccessEx1 = "จับค่า Exclusive 1 สำเร็จ", SuccessEx10 = "จับค่า Exclusive 10 สำเร็จ",
        Loaded = "Script Loaded!"
    },
    EN = {
        SummonTab = "Summon", SettingsTab = "Settings", FarmTab = "Farm",
        CatchSection = "CATCH REMOTE", AutoSection = "AUTO SUMMON",
        ExCatchSection = "⭐ CATCH EXCLUSIVE", ExAutoSection = "⭐ AUTO EXCLUSIVE",
        MysticSection = "MYSTIC NOTIFIER",
        LangSection = "LANGUAGE", SysSection = "SYSTEM",
        Catch1 = "Catch Summon 1", Catch1Desc = "Press then summon 1 time",
        Catch10 = "Catch Summon 10", Catch10Desc = "Press then summon 10 times",
        CatchEx1 = "Catch Exclusive 1", CatchEx1Desc = "Press then exclusive summon 1",
        CatchEx10 = "Catch Exclusive 10", CatchEx10Desc = "Press then exclusive summon 10",
        SelectMode = "Select Summon Mode", SelectModeEx = "Select Exclusive Mode",
        AutoSummon = "Auto Summon", AutoSummonEx = "Auto Exclusive Summon",
        MysticNotifyToggle = "Mystic Notifier", MysticNotifyDesc = "Notify when get Mystic unit",
        Language = "Change Language", Destroy = "Destroy UI", DestroyDesc = "Close and delete UI",
        Success1 = "Caught Summon 1", Success10 = "Caught Summon 10",
        SuccessEx1 = "Caught Exclusive 1", SuccessEx10 = "Caught Exclusive 10",
        Loaded = "Script Loaded!"
    },
    RU = {
        SummonTab = "Призыв", SettingsTab = "Настройки", FarmTab = "Фарм",
        CatchSection = "CATCH REMOTE", AutoSection = "АВТО ПРИЗЫВ",
        ExCatchSection = "⭐ CATCH EXCLUSIVE", ExAutoSection = "⭐ АВТО EXCLUSIVE",
        MysticSection = "MYSTIC УВЕДОМЛЕНИЕ",
        LangSection = "ЯЗЫК", SysSection = "СИСТЕМА",
        Catch1 = "Поймать Summon 1", Catch1Desc = "Нажмите и Summon 1",
        Catch10 = "Поймать Summon 10", Catch10Desc = "Нажмите и Summon 10",
        CatchEx1 = "Поймать Exclusive 1", CatchEx1Desc = "Нажмите и Exclusive 1",
        CatchEx10 = "Поймать Exclusive 10", CatchEx10Desc = "Нажмите и Exclusive 10",
        SelectMode = "Выбрать режим", SelectModeEx = "Выбрать Exclusive режим",
        AutoSummon = "Авто Призыв", AutoSummonEx = "Авто Exclusive Призыв",
        MysticNotifyToggle = "Mystic Уведомление", MysticNotifyDesc = "Уведомлять при Mystic",
        Language = "Язык", Destroy = "Закрыть UI", DestroyDesc = "Закрыть и удалить UI",
        Success1 = "Summon 1 пойман", Success10 = "Summon 10 пойман",
        SuccessEx1 = "Exclusive 1 пойман", SuccessEx10 = "Exclusive 10 пойман",
        Loaded = "Скрипт загружен!"
    }
}
local function T(key)
    return Lang[getgenv().Language] and Lang[getgenv().Language][key] or key
end

-- ==================== WINDOW ====================
local Window = WindUI:CreateWindow({
    Title = "Mystery Hub",
    Author = "Free Edition",
    Icon = "rbxassetid://106770711499312",
    Folder = "MysteryHub",
    Theme = "Dark",
    NewElements = true,
    HideSearchBar = true,
    OpenButton = {
        Enabled = true,
        Draggable = true,
        OnlyMobile = false,
        Icon = "rbxassetid://106770711499312",
        Size = UDim2.fromOffset(60, 60),
        CornerRadius = UDim.new(0, 14),
    }
})

-- ==================== SECTIONS ====================
local SummonSection = Window:Section({Title = T("SummonTab")})
local ExSection = Window:Section({Title = "Exclusive"})
local NotifierSection = Window:Section({Title = "Notifier"})
local FarmSection = Window:Section({Title = T("FarmTab")})
local SettingsSection = Window:Section({Title = T("SettingsTab")})

-- ==================== SUMMON TAB ====================
local SummonTab = SummonSection:Tab({Title = T("SummonTab"), Icon = "sparkles"})
SummonTab:Section({Title = T("CatchSection")})
local Catch1Btn = SummonTab:Button({
    Title = T("Catch1"), Desc = T("Catch1Desc"), Icon = "mouse-pointer-click",
    Callback = function()
        getgenv().LastSummonMode = "Summon 1"
        WindUI:Notify({Title = "Mystery Hub", Content = "⏳ " .. T("Catch1Desc"), Duration = 3})
    end
})
local Catch10Btn = SummonTab:Button({
    Title = T("Catch10"), Desc = T("Catch10Desc"), Icon = "mouse-pointer-click",
    Callback = function()
        getgenv().LastSummonMode = "Summon 10"
        WindUI:Notify({Title = "Mystery Hub", Content = "⏳ " .. T("Catch10Desc"), Duration = 3})
    end
})
SummonTab:Section({Title = T("AutoSection")})
local SummonDropdown = SummonTab:Dropdown({
    Title = T("SelectMode"), Values = {"Summon 1", "Summon 10"}, Value = 2,
    Callback = function(v) getgenv().SummonMode = v end
})
local AutoSummonToggle = SummonTab:Toggle({
    Title = T("AutoSummon"), Desc = "Automatically summon units", Value = false,
    Callback = function(v) getgenv().AutoSummon = v end
})

-- ==================== EXCLUSIVE TAB ====================
local ExclusiveTab = ExSection:Tab({Title = "Exclusive", Icon = "crown"})
ExclusiveTab:Section({Title = T("ExCatchSection")})
local CatchEx1Btn = ExclusiveTab:Button({
    Title = T("CatchEx1"), Desc = T("CatchEx1Desc"), Icon = "mouse-pointer-click",
    Callback = function()
        getgenv().LastSummonMode = "Exclusive 1"
        WindUI:Notify({Title = "Mystery Hub", Content = "⏳ " .. T("CatchEx1Desc"), Duration = 3})
    end
})
local CatchEx10Btn = ExclusiveTab:Button({
    Title = T("CatchEx10"), Desc = T("CatchEx10Desc"), Icon = "mouse-pointer-click",
    Callback = function()
        getgenv().LastSummonMode = "Exclusive 10"
        WindUI:Notify({Title = "Mystery Hub", Content = "⏳ " .. T("CatchEx10Desc"), Duration = 3})
    end
})
ExclusiveTab:Section({Title = T("ExAutoSection")})
local ExDropdown = ExclusiveTab:Dropdown({
    Title = T("SelectModeEx"), Values = {"Exclusive 1", "Exclusive 10"}, Value = 2,
    Callback = function(v) getgenv().SummonModeEx = v end
})
local AutoExToggle = ExclusiveTab:Toggle({
    Title = T("AutoSummonEx"), Desc = "Automatically exclusive summon", Value = false,
    Callback = function(v) getgenv().AutoSummonEx = v end
})

-- ==================== MYSTIC NOTIFIER TAB ====================
local MysticTab = NotifierSection:Tab({Title = "Mystic", Icon = "bell"})
MysticTab:Section({Title = T("MysticSection")})
local MysticToggle = MysticTab:Toggle({
    Title = T("MysticNotifyToggle"), Desc = T("MysticNotifyDesc"), Value = true,
    Callback = function(v) getgenv().MysticNotify = v end
})

-- ==================== FARM TAB ====================
local FarmTab = FarmSection:Tab({Title = T("FarmTab"), Icon = "swords"})
FarmTab:Section({Title = "📋 Unit Plans"})
FarmTab:Paragraph({Title = "Set 1 (Desert)", Desc = "Ninja Cameraman / Camera Helicopter"})
FarmTab:Paragraph({Title = "Set 2 (Cameraman HQ)", Desc = "Camera Spider / Ninja / Mech / Scientist"})
FarmTab:Paragraph({Title = "Set 3 (Toilet HQ)", Desc = "UTS / Mech Cameraman / Ninja / Scientist / Medic"})
FarmTab:Paragraph({Title = "Set 4 (Toilet HQ)", Desc = "UTC / Mech Cameraman / Dark / Scientist / Medic"})
FarmTab:Paragraph({Title = "Set 5 (Toilet HQ)", Desc = "UTC / Mech Cameraman / Dark / Scientist / CameraDrone"})
FarmTab:Section({Title = "🚜 AUTO FARM"})
FarmTab:Dropdown({
    Title = "Select Mode", Multi = false, Value = State.Select_Mode,
    Values = {"Desert", "Cameraman HQ", "Toilet HQ"},
    Callback = function(v) State.Select_Mode = v SaveConfig(State) end
})
FarmTab:Dropdown({
    Title = "Select Unit Set", Multi = false, Value = State.Select_UnitSet,
    Values = {"Set 1 (Desert)", "Set 2 (Cameraman HQ)", "Set 3 (Toilet HQ)", "Set 4 (Toilet HQ)", "Set 5 (Toilet HQ)"},
    Callback = function(v) State.Select_UnitSet = v SaveConfig(State) end
})
FarmTab:Toggle({
    Title = "Start Auto Mode", Value = State.AUTO_Mod,
    Callback = function(v) State.AUTO_Mod = v SaveConfig(State) end
})
FarmTab:Toggle({
    Title = "Auto Farm Legacy", Value = State.AUTO_Farm,
    Callback = function(v) State.AUTO_Farm = v SaveConfig(State) end
})

-- ==================== SETTINGS TAB ====================
local SettingsTab = SettingsSection:Tab({Title = T("SettingsTab"), Icon = "settings"})
local attackersFolder = workspace:WaitForChild("Attackers")
local function hideModel(model)
    for _, obj in ipairs(model:GetDescendants()) do
        if obj:IsA("BasePart") then obj.Transparency = 1 obj.CanCollide = false
        elseif obj:IsA("Decal") then obj.Transparency = 1
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") then obj.Enabled = false
        elseif obj:IsA("Highlight") then obj.Enabled = false
        end
    end
end
local function showModel(model)
    for _, obj in ipairs(model:GetDescendants()) do
        if obj:IsA("BasePart") then obj.Transparency = 0
        elseif obj:IsA("Decal") then obj.Transparency = 0
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") then obj.Enabled = true
        elseif obj:IsA("Highlight") then obj.Enabled = true
        end
    end
end
local function updateAttackers()
    for _, v in ipairs(attackersFolder:GetChildren()) do
        if State.Hide_Attackers then hideModel(v) else showModel(v) end
    end
end
attackersFolder.ChildAdded:Connect(function(child)
    task.wait(0.1)
    if State.Hide_Attackers then hideModel(child) end
end)
SettingsTab:Section({Title = "VISUAL"})
SettingsTab:Toggle({
    Title = "Hide Attackers", Value = State.Hide_Attackers,
    Callback = function(v) State.Hide_Attackers = v SaveConfig(State) updateAttackers() end
})
SettingsTab:Section({Title = T("LangSection")})
local LangDropdown = SettingsTab:Dropdown({
    Title = T("Language"), Values = {"TH", "EN", "RU"}, Value = 1,
    Callback = function(v)
        getgenv().Language = v
        local function Refresh(obj, titleKey, descKey)
            if not obj then return end
            pcall(function()
                if obj.SetTitle then obj:SetTitle(T(titleKey)) end
                if descKey and obj.SetDesc then obj:SetDesc(T(descKey)) end
            end)
        end
        Refresh(Catch1Btn, "Catch1", "Catch1Desc")
        Refresh(Catch10Btn, "Catch10", "Catch10Desc")
        Refresh(CatchEx1Btn, "CatchEx1", "CatchEx1Desc")
        Refresh(CatchEx10Btn, "CatchEx10", "CatchEx10Desc")
        Refresh(SummonDropdown, "SelectMode")
        Refresh(ExDropdown, "SelectModeEx")
        Refresh(AutoSummonToggle, "AutoSummon")
        Refresh(AutoExToggle, "AutoSummonEx")
        Refresh(MysticToggle, "MysticNotifyToggle", "MysticNotifyDesc")
        Refresh(LangDropdown, "Language")
        WindUI:Notify({Title = "Mystery Hub", Content = "🌐 Language: " .. v, Duration = 2})
    end
})
SettingsTab:Section({Title = T("SysSection")})
SettingsTab:Button({
    Title = T("Destroy"), Desc = T("DestroyDesc"), Icon = "trash-2",
    Callback = function() Window:Destroy() end
})

-- ==================== REMOTE HOOK ====================
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    if getnamecallmethod() == "FireServer" and self == Remote then
        if getgenv().LastSummonMode then
            local args = {...}
            if getgenv().LastSummonMode == "Summon 1" then
                getgenv().SummonArgs1 = args
                WindUI:Notify({Title = "Mystery Hub", Content = "✅ " .. T("Success1"), Duration = 3})
            elseif getgenv().LastSummonMode == "Summon 10" then
                getgenv().SummonArgs10 = args
                WindUI:Notify({Title = "Mystery Hub", Content = "✅ " .. T("Success10"), Duration = 3})
            elseif getgenv().LastSummonMode == "Exclusive 1" then
                getgenv().SummonArgsEx1 = args
                WindUI:Notify({Title = "Mystery Hub", Content = "✅ " .. T("SuccessEx1"), Duration = 3})
            elseif getgenv().LastSummonMode == "Exclusive 10" then
                getgenv().SummonArgsEx10 = args
                WindUI:Notify({Title = "Mystery Hub", Content = "✅ " .. T("SuccessEx10"), Duration = 3})
            end
            getgenv().LastSummonMode = nil
        end
    end
    return old(self, ...)
end)
setreadonly(mt, true)

-- ==================== AUTO SUMMON LOOPS ====================
task.spawn(function()
    while true do
        if getgenv().AutoSummon then
            local args = getgenv().SummonMode == "Summon 1" and getgenv().SummonArgs1 or getgenv().SummonArgs10
            if args then pcall(function() Remote:FireServer(unpack(args)) end) end
            task.wait(getgenv().SummonMode == "Summon 10" and 3 or 1.5)
        else task.wait(0.2) end
    end
end)
task.spawn(function()
    while true do
        if getgenv().AutoSummonEx then
            local args = getgenv().SummonModeEx == "Exclusive 1" and getgenv().SummonArgsEx1 or getgenv().SummonArgsEx10
            if args then pcall(function() Remote:FireServer(unpack(args)) end) end
            task.wait(getgenv().SummonModeEx == "Exclusive 10" and 3 or 1.5)
        else task.wait(0.2) end
    end
end)

-- ==================== SET 5 SCRIPT (TOILET HQ) ====================
local function runSet5ToiletHQ()
    local Players = game:GetService("Players")
    local RS = game:GetService("ReplicatedStorage")
    local player = Players.LocalPlayer
    local money = player:WaitForChild("leaderstats"):WaitForChild("Money")
    local troops = workspace:WaitForChild("Troops")

    local function sell(unit)
        if not unit or not unit.Parent then return end
        RS.NetworkingContainer.DataRemote:FireServer({{"\226\129\130$", unit}})
    end

    local waveLabel = player.PlayerGui.Match.TopFrame:WaitForChild("WaveNumber")
    local function getWave()
        local num = tonumber(tostring(waveLabel.Text):match("%d+"))
        return num or 0
    end

    local function canSkip()
        local wave = getWave()
        if wave == 20 or wave == 24 or wave == 26 or wave >= 49 then return false end
        if wave >= 1 and wave <= 19 then return true end
        if wave >= 21 and wave <= 23 then return true end
        if wave == 25 then return true end
        if wave >= 27 and wave <= 30 then return true end
        if wave >= 32 and wave <= 41 then return true end
        if wave >= 43 and wave <= 46 then return true end
        if wave == 48 then return true end
        return false
    end

    task.spawn(function()
        while task.wait(0.8) do
            pcall(function()
                if not canSkip() then return end
                local matchGui = player.PlayerGui:FindFirstChild("Match")
                if not matchGui then return end
                local skip = matchGui.TopFrame:FindFirstChild("SkipWave")
                if skip and skip.Visible then
                    RS.NetworkingContainer.DataRemote:FireServer({{"⁂("}})
                end
            end)
        end
    end)

    local function waitMoney(amount)
        while money.Value < amount do
            money:GetPropertyChangedSignal("Value"):Wait()
        end
        task.wait(0.1)
    end

    local function countUnit(unitName)
        local c = 0
        for _, v in ipairs(troops:GetChildren()) do
            if v.Name == unitName then c += 1 end
        end
        return c
    end

    local function place(unitName, position, slot)
        local before = countUnit(unitName)
        RS.NetworkingContainer.DataRemote:FireServer({{"\226\129\130\22", unitName, position, slot}})
        local t = 0
        while t < 10 do
            task.wait(0.3)
            if countUnit(unitName) > before then return true end
            t += 1
        end
        return false
    end

    local stunnedTroops = workspace:WaitForChild("StunnedTroops")
    local function upgrade(unit, tries)
        if not unit or not unit.Parent then return false end
        tries = tries or 5
        for i = 1, tries do
            while unit and unit.Parent == stunnedTroops do task.wait(0.3) end
            if not unit or not unit.Parent then return false end
            local troopLevel = unit:FindFirstChild("TroopLevel")
            if not troopLevel then return false end
            local oldLevel = troopLevel.Value
            RS.NetworkingContainer.DataRemote:FireServer({{"\226\129\130#", unit}})
            local t = 0
            while t < 2.5 do
                task.wait(0.1)
                if unit.Parent == stunnedTroops then break end
                if not unit or not unit.Parent then return false end
                troopLevel = unit:FindFirstChild("TroopLevel")
                if troopLevel and troopLevel.Value > oldLevel then return true end
                t += 0.1
            end
        end
        return false
    end

    local function updateValues(unitName)
        local index = 0
        for _, v in ipairs(troops:GetChildren()) do
            if v.Name == unitName then
                index += 1
                local val = v:FindFirstChild("Value") or Instance.new("IntValue")
                val.Name = "Value"
                val.Parent = v
                val.Value = index
            end
        end
    end

    local function getLatest(unitName)
        local latest, highest = nil, 0
        for _, v in ipairs(troops:GetChildren()) do
            if v.Name == unitName then
                local val = v:FindFirstChild("Value")
                if val and val.Value > highest then highest = val.Value latest = v end
            end
        end
        return latest
    end

    local function waitForUnit(unitName, timeout)
        timeout = timeout or 15
        local t = 0
        while t < timeout do
            for _, v in ipairs(troops:GetChildren()) do
                if v.Name == unitName then return v end
            end
            task.wait(0.2)
            t += 0.2
        end
        return nil
    end

    local function safePlace(unitName, pos, slot)
        local price = 100
        if unitName == "DarkSpeakerman" then price = 150
        elseif unitName == "MechCameraman" then price = 400
        elseif unitName == "CameraDrone" then price = 300
        elseif unitName == "UpgradedTitanCameraman" then price = 1500
        end
        waitMoney(price)
        local ok = false
        while not ok do ok = place(unitName, pos, slot) task.wait(0.4) end
        updateValues(unitName)
        return getLatest(unitName)
    end

    local dark = nil
    safePlace("DarkSpeakerman", Vector3.new(58.741, 16.779, 112.257), 1)
    dark = waitForUnit("DarkSpeakerman")
    if not dark then warn("DarkSpeakerman not spawned") return end

    waitMoney(100) upgrade(dark)
    local sci1 = safePlace("ScientistCameraman", Vector3.new(59.199, 16.779, 114.549), 1)
    local sci2 = safePlace("ScientistCameraman", Vector3.new(55.859, 16.779, 114.565), 1)
    local sci3 = safePlace("ScientistCameraman", Vector3.new(66.296, 16.779, 114.541), 1)
    waitMoney(200) upgrade(dark)
    local sci4 = safePlace("ScientistCameraman", Vector3.new(71.677, 16.779, 114.579), 1)
    waitMoney(300) upgrade(dark)
    waitMoney(400) upgrade(dark)
    waitMoney(300) upgrade(sci1)
    waitMoney(600) upgrade(sci1)
    waitMoney(300) upgrade(sci2)
    waitMoney(600) upgrade(sci2)
    waitMoney(300) upgrade(sci3)
    waitMoney(600) upgrade(sci3)
    waitMoney(300) upgrade(sci4)
    local mech1 = safePlace("MechCameraman", Vector3.new(99.577, 19.497, 114.551), 1)
    waitMoney(300) upgrade(mech1)
    waitMoney(500) upgrade(mech1)
    waitMoney(800) upgrade(mech1)
    waitMoney(600) upgrade(sci4)
    waitMoney(1000) upgrade(mech1)
    waitMoney(1000) upgrade(sci1)
    waitMoney(1000) upgrade(sci2)
    waitMoney(1000) upgrade(sci3)
    waitMoney(1000) upgrade(sci4)
    local mech2 = safePlace("MechCameraman", Vector3.new(90.467, 19.497, 114.522), 1)
    waitMoney(300) upgrade(mech2)
    waitMoney(500) upgrade(mech2)
    waitMoney(800) upgrade(mech2)
    waitMoney(1000) upgrade(mech2)
    local mech3 = safePlace("MechCameraman", Vector3.new(82.19, 19.497, 114.472), 1)
    waitMoney(300) upgrade(mech3)
    waitMoney(500) upgrade(mech3)
    waitMoney(800) upgrade(mech3)
    waitMoney(1000) upgrade(mech3)
    waitMoney(2000) upgrade(sci1)
    waitMoney(2000) upgrade(sci2)
    waitMoney(2000) upgrade(sci3)
    waitMoney(2000) upgrade(sci4)
    local mech4 = safePlace("MechCameraman", Vector3.new(74.151, 19.497, 110.099), 1)
    waitMoney(300) upgrade(mech4)
    waitMoney(500) upgrade(mech4)
    waitMoney(800) upgrade(mech4)
    waitMoney(1000) upgrade(mech4)
    local mech5 = safePlace("MechCameraman", Vector3.new(64.638, 19.497, 110.093), 1)
    waitMoney(300) upgrade(mech5)
    waitMoney(500) upgrade(mech5)
    waitMoney(800) upgrade(mech5)
    waitMoney(1000) upgrade(mech5)

    task.spawn(function()
        while true do
            task.wait(1)
            local wave = getWave()
            if wave >= 30 then break end
            if wave >= 20 then
                for _, unit in ipairs(troops:GetChildren()) do
                    if unit.Name == "MechCameraman" then
                        RS.NetworkingContainer.DataRemote:FireServer({{"\226\129\130#", unit}})
                    end
                end
            end
        end
    end)

    local utc1 = safePlace("UpgradedTitanCameraman", Vector3.new(61.02, 22.768, 121.944), 1)
    waitMoney(1500) upgrade(utc1)
    local crd1 = safePlace("CameraDrone", Vector3.new(67.658, 16.828, 129.162), 1)
    waitMoney(400) upgrade(crd1)
    waitMoney(3000) upgrade(utc1)
    waitMoney(4000) upgrade(utc1)
    waitMoney(8000) upgrade(utc1)
    local utc2 = safePlace("UpgradedTitanCameraman", Vector3.new(75.73, 22.768, 124.272), 1)
    waitMoney(1500) upgrade(utc2)
    waitMoney(3000) upgrade(utc2)
    waitMoney(4000) upgrade(utc2)
    waitMoney(8000) upgrade(utc2)
    waitMoney(10000) upgrade(utc1)
    waitMoney(10000) upgrade(utc2)
    waitMoney(800) upgrade(crd1)
    waitMoney(3000) upgrade(crd1)
    local utc3 = safePlace("UpgradedTitanCameraman", Vector3.new(89.361, 22.768, 124.301), 1)
    waitMoney(1500) upgrade(utc3)
    waitMoney(3000) upgrade(utc3)
    waitMoney(4000) upgrade(utc3)
    waitMoney(8000) upgrade(utc3)
    waitMoney(10000) upgrade(utc3)
    local utc4 = safePlace("UpgradedTitanCameraman", Vector3.new(104.203, 22.768, 125.339), 1)
    waitMoney(1500) upgrade(utc4)
    waitMoney(3000) upgrade(utc4)
    waitMoney(4000) upgrade(utc4)
    waitMoney(8000) upgrade(utc4)
    waitMoney(10000) upgrade(utc4)

    task.spawn(function()
        local done = false
        while task.wait(0.5) do
            if done then break end
            if getWave() >= 42 then
                done = true
                sell(dark)
                local utc5 = safePlace("UpgradedTitanCameraman", Vector3.new(44.475, 22.768, 118.138), 1)
                waitMoney(1500) upgrade(utc5)
                waitMoney(3000) upgrade(utc5)
                waitMoney(4000) upgrade(utc5)
                waitMoney(8000) upgrade(utc5)
                waitMoney(10000) upgrade(utc5)
            end
        end
    end)

    task.spawn(function()
        local done = false
        while task.wait(0.5) do
            if done then break end
            if getWave() >= 47 then
                done = true
                local sold = false
                for _, v in ipairs(troops:GetChildren()) do
                    if v.Name == "ScientistCameraman" then
                        sell(v) sold = true break
                    end
                end
                if sold then
                    local utc6 = safePlace("UpgradedTitanCameraman", Vector3.new(45.68, 22.768, 131.582), 1)
                    waitMoney(1500) upgrade(utc6)
                    waitMoney(3000) upgrade(utc6)
                    waitMoney(4000) upgrade(utc6)
                    waitMoney(8000) upgrade(utc6)
                    waitMoney(10000) upgrade(utc6)
                end
            end
        end
    end)

    task.spawn(function()
        local done = false
        while task.wait(0.5) do
            if done then break end
            if getWave() >= 50 then
                done = true
                for _, v in ipairs(troops:GetChildren()) do
                    if v.Name == "ScientistCameraman" then sell(v) task.wait(0.15) end
                end
            end
        end
    end)

    task.spawn(function()
        while true do
            task.wait(5)
            if getWave() >= 40 then
                pcall(function()
                    for _, unit in ipairs(troops:GetChildren()) do
                        if unit.Name == "UpgradedTitanCameraman" then
                            RS.NetworkingContainer.DataRemote:FireServer({{"\226\129\130#", unit}})
                        end
                    end
                end)
            end
        end
    end)
end

-- ==================== FARM LOOP ====================
local function runScript(url)
    local ok, err = pcall(function() loadstring(game:HttpGet(url))() end)
    if not ok then warn("Failed: " .. url .. " | " .. err) end
end

task.spawn(function()
    local lastLocation = ""
    local legacyLoaded = false
    local farmLoaded = false
    local set5Running = false

    while true do
        task.wait(2)

        local portal = workspace:FindFirstChild("Illusion")
            and workspace.Illusion:FindFirstChild("LegacyPortal")
            and workspace.Illusion.LegacyPortal:FindFirstChild("PortalZone")

        if (State.AUTO_Farm or State.AUTO_Mod) and portal and not legacyLoaded then
            legacyLoaded = true
            loadstring(game:HttpGet("https://mxzy.store/assets/OldTTD.txt"))()
        end

        if State.AUTO_Farm then
            if workspace:FindFirstChild("Lifts") then
                if lastLocation ~= "LegacyLobby" then
                    lastLocation = "LegacyLobby"
                    runScript("https://mxzy.store/assets/ModeToiletHQE.txt")
                end
            else
                if not farmLoaded then
                    farmLoaded = true
                    task.wait(4)
                    loadstring(game:HttpGet("https://mxzy.store/assets/AutofarmJ.txt"))()
                end
            end
        end

        if State.AUTO_Mod then
            if workspace:FindFirstChild("Lifts") then
                if lastLocation ~= "Lobby" then
                    lastLocation = "Lobby"
                    set5Running = false
                    if State.Select_Mode == "Desert" then
                        runScript("https://mxzy.store/assets/ModeDesertH.txt")
                    elseif State.Select_Mode == "Cameraman HQ" then
                        runScript("https://mxzy.store/assets/CameramanHQC.txt")
                    elseif State.Select_Mode == "Toilet HQ" then
                        runScript("https://mxzy.store/assets/ModeToiletHQE.txt")
                    end
                end
            else
                if lastLocation ~= "InGame" then
                    lastLocation = "InGame"
                    task.wait(4)
                    if State.Select_UnitSet == "Set 1 (Desert)" then
                        runScript("https://mxzy.store/assets/Set1L.txt")
                    elseif State.Select_UnitSet == "Set 2 (Cameraman HQ)" then
                        runScript("https://mxzy.store/assets/Set2x.txt")
                    elseif State.Select_UnitSet == "Set 3 (Toilet HQ)" then
                        runScript("https://mxzy.store/assets/Set3D.txt")
                    elseif State.Select_UnitSet == "Set 4 (Toilet HQ)" then
                        runScript("https://mxzy.store/assets/Set4C.txt")
                    elseif State.Select_UnitSet == "Set 5 (Toilet HQ)" then
                        if not set5Running then
                            set5Running = true
                            task.spawn(runSet5ToiletHQ)
                        end
                    end
                end
            end
        elseif not State.AUTO_Farm and not State.AUTO_Mod then
            lastLocation = ""
            farmLoaded = false
            legacyLoaded = false
            set5Running = false
        end
    end
end)

-- ==================== ANTI AFK ====================
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local LP = Players.LocalPlayer
repeat task.wait() until workspace.CurrentCamera
LP.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(0.1)
    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    VirtualUser:Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(0.1)
    VirtualUser:Button1Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

-- ==================== INIT ====================
task.wait(1)
updateAttackers()

task.spawn(function()
    task.wait(0.5)
    if Window.Minimize then Window:Minimize()
    elseif Window.Toggle then Window:Toggle() end
end)

task.wait(0.5)
WindUI:Notify({
    Title = "Mystery Hub",
    Content = T("Loaded"),
    Icon = "check",
    Duration = 5
})

print("Mystery Hub Loaded ✔")