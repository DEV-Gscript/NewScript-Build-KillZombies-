--[[
    DEV_G // WORK.INK KEY LOADER
    Work.ink Key System
    Supported target executors:
      - Delta
      - Xeno

    Get Key:
      https://work.ink/35dD/token

    Work.ink validation:
      GET https://work.ink/_api/v2/token/isValid/<TOKEN>

    NOTE:
      Work.ink tokens are validated against Work.ink.
      This loader does not contain Vampauth credentials or secrets.
]]

local Config = {
    WorkinkGetKeyURL = "https://work.ink/35dD/token",
    WorkinkAPIBase = "https://work.ink/_api/v2/token/isValid/",
    MainScriptURL = "https://raw.githubusercontent.com/DEV-Gscript/NewScript-Build-KillZombies-/refs/heads/main/Build%26KillZombies",
    DiscordURL = "https://discord.gg/RF7AffpSSV",

    KeyFileName = "Mykey.txt",

    NotificationsEnabled = true,
    AutoExecute = true,

    -- Set true if you want every successful verification to consume the token.
    -- Leave false for normal saved-key / revalidation behavior.
    SingleUseKey = false,

    GUIName = "DEV_G_Workink_Loader",
    MainGuiName = "DEV_G Free +",
}

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local LocalPlayer = Players.LocalPlayer

--========================================================
-- SAFE HELPERS
--========================================================

local function notify(title, text, duration)
    if not Config.NotificationsEnabled then return end
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = tostring(title),
            Text = tostring(text),
            Duration = duration or 4
        })
    end)
end

local function safeWrite(path, content)
    if type(writefile) ~= "function" then
        return false
    end

    local ok = pcall(writefile, path, tostring(content))
    return ok
end

local function safeRead(path)
    if type(readfile) ~= "function" or type(isfile) ~= "function" then
        return nil
    end

    local existsOk, exists = pcall(isfile, path)
    if not existsOk or not exists then
        return nil
    end

    local ok, result = pcall(readfile, path)
    if ok and type(result) == "string" and result ~= "" then
        return result
    end

    return nil
end

local function safeDelete(path)
    if type(delfile) ~= "function" or type(isfile) ~= "function" then
        return
    end

    pcall(function()
        if isfile(path) then
            delfile(path)
        end
    end)
end

local function jsonDecode(value)
    local ok, result = pcall(function()
        return HttpService:JSONDecode(value)
    end)

    return ok and result or nil
end

local function httpRequest(options)
    local requestFunction =
        (type(request) == "function" and request)
        or (type(http_request) == "function" and http_request)
        or (type(syn_request) == "function" and syn_request)
        or (type(http) == "table" and type(http.request) == "function" and http.request)

    if requestFunction then
        local ok, response = pcall(function()
            return requestFunction(options)
        end)

        if ok and type(response) == "table" then
            return response
        end
    end

    local ok, response = pcall(function()
        return HttpService:RequestAsync({
            Url = options.Url,
            Method = options.Method or "GET",
            Headers = options.Headers or {},
            Body = options.Body
        })
    end)

    if ok and type(response) == "table" then
        return response
    end

    return nil
end

--========================================================
-- KEY STORAGE
--========================================================

local function saveKey(key)
    return safeWrite(Config.KeyFileName, key)
end

local function loadKey()
    return safeRead(Config.KeyFileName)
end

local function clearKey()
    safeDelete(Config.KeyFileName)
end

--========================================================
-- WORK.INK
--========================================================

local Workink = {}

function Workink.Check(token)
    if type(token) ~= "string" then
        return false, "Enter a key."
    end

    token = token:gsub("^%s+", ""):gsub("%s+$", "")

    if token == "" then
        return false, "Enter a key."
    end

    local url = Config.WorkinkAPIBase .. HttpService:UrlEncode(token)

    if Config.SingleUseKey then
        url = url .. "?deleteToken=1"
    end

    local response = httpRequest({
        Url = url,
        Method = "GET",
        Headers = {
            ["Accept"] = "application/json"
        }
    })

    if not response then
        return false, "Work.ink request failed."
    end

    local statusCode =
        response.StatusCode
        or response.statusCode
        or response.status_code
        or 0

    local body =
        response.Body
        or response.body
        or ""

    local data = jsonDecode(body)

    if type(data) ~= "table" then
        if statusCode == 429 then
            return false, "Work.ink rate limit. Try again shortly."
        end

        return false, "Invalid Work.ink response."
    end

    if data.valid == true then
        return true, data
    end

    if statusCode == 429 then
        return false, "Work.ink rate limit. Try again shortly."
    elseif statusCode >= 400 then
        return false, "Work.ink rejected the key."
    end

    return false, "Invalid or expired key."
end

--========================================================
-- GET KEY
--========================================================

local function openGetKey()
    local opened = false

    pcall(function()
        GuiService:OpenBrowserWindow(Config.WorkinkGetKeyURL)
        opened = true
    end)

    if not opened and type(setclipboard) == "function" then
        pcall(setclipboard, Config.WorkinkGetKeyURL)
    elseif not opened and type(toclipboard) == "function" then
        pcall(toclipboard, Config.WorkinkGetKeyURL)
    end

    return opened
end

--========================================================
-- MAIN SCRIPT
--========================================================

local function StartMainScript()
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")

    pcall(function()
        local old = playerGui:FindFirstChild(Config.MainGuiName)
        if old then
            old:Destroy()
        end
    end)

    local ok, result = pcall(function()
        return game:HttpGet(Config.MainScriptURL)
    end)

    if not ok or type(result) ~= "string" or result == "" then
        notify("DEV_G", "Failed to download the main script.", 6)
        return false
    end

    local loader, compileError = loadstring(result)

    if not loader then
        notify("DEV_G", "Main script compile error: " .. tostring(compileError), 8)
        return false
    end

    local runOk, runError = pcall(loader)

    if not runOk then
        notify("DEV_G", "Main script error: " .. tostring(runError), 8)
        return false
    end

    return true
end

--========================================================
-- GUI
--========================================================

local function destroyOldGUI()
    pcall(function()
        local coreGui = game:GetService("CoreGui")
        local old = coreGui:FindFirstChild(Config.GUIName)
        if old then
            old:Destroy()
        end
    end)

    pcall(function()
        local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        if pg then
            local old = pg:FindFirstChild(Config.GUIName)
            if old then
                old:Destroy()
            end
        end
    end)
end

local function CreateGUI()
    destroyOldGUI()

    local parent

    local okCore, core = pcall(function()
        return game:GetService("CoreGui")
    end)

    if okCore and core then
        parent = core
    else
        parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = Config.GUIName
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = parent

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 390, 0, 390)
    MainFrame.Position = UDim2.new(0.5, -195, 0.5, -195)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 13, 17)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 14)
    corner.Parent = MainFrame

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1.5
    stroke.Color = Color3.fromRGB(45, 48, 58)
    stroke.Parent = MainFrame

    local Top = Instance.new("Frame")
    Top.Size = UDim2.new(1, 0, 0, 64)
    Top.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
    Top.BorderSizePixel = 0
    Top.Parent = MainFrame

    local topCorner = Instance.new("UICorner")
    topCorner.CornerRadius = UDim.new(0, 14)
    topCorner.Parent = Top

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -70, 0, 30)
    Title.Position = UDim2.new(0, 20, 0, 9)
    Title.BackgroundTransparency = 1
    Title.Text = "DEV_G"
    Title.TextColor3 = Color3.fromRGB(0, 190, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 21
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Top

    local Subtitle = Instance.new("TextLabel")
    Subtitle.Size = UDim2.new(1, -70, 0, 18)
    Subtitle.Position = UDim2.new(0, 21, 0, 36)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = "Work.ink Secure Loader"
    Subtitle.TextColor3 = Color3.fromRGB(135, 140, 150)
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.TextSize = 12
    Subtitle.TextXAlignment = Enum.TextXAlignment.Left
    Subtitle.Parent = Top

    local Close = Instance.new("TextButton")
    Close.Size = UDim2.new(0, 34, 0, 34)
    Close.Position = UDim2.new(1, -45, 0, 15)
    Close.BackgroundTransparency = 1
    Close.Text = "×"
    Close.TextColor3 = Color3.fromRGB(255, 80, 90)
    Close.Font = Enum.Font.GothamBold
    Close.TextSize = 25
    Close.Parent = Top

    Close.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local Info = Instance.new("TextLabel")
    Info.Size = UDim2.new(1, -40, 0, 42)
    Info.Position = UDim2.new(0, 20, 0, 82)
    Info.BackgroundTransparency = 1
    Info.Text = "Enter your Work.ink key below. Your key is checked directly with Work.ink."
    Info.TextColor3 = Color3.fromRGB(175, 180, 190)
    Info.Font = Enum.Font.Gotham
    Info.TextSize = 13
    Info.TextWrapped = true
    Info.TextXAlignment = Enum.TextXAlignment.Left
    Info.Parent = MainFrame

    local KeyBox = Instance.new("TextBox")
    KeyBox.Size = UDim2.new(1, -40, 0, 48)
    KeyBox.Position = UDim2.new(0, 20, 0, 135)
    KeyBox.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
    KeyBox.BorderSizePixel = 0
    KeyBox.PlaceholderText = "Paste your Work.ink key..."
    KeyBox.PlaceholderColor3 = Color3.fromRGB(100, 105, 115)
    KeyBox.Text = ""
    KeyBox.TextColor3 = Color3.fromRGB(240, 240, 245)
    KeyBox.Font = Enum.Font.Gotham
    KeyBox.TextSize = 14
    KeyBox.ClearTextOnFocus = false
    KeyBox.Parent = MainFrame

    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 9)
    keyCorner.Parent = KeyBox

    local keyStroke = Instance.new("UIStroke")
    keyStroke.Color = Color3.fromRGB(45, 48, 58)
    keyStroke.Thickness = 1
    keyStroke.Parent = KeyBox

    local Verify = Instance.new("TextButton")
    Verify.Size = UDim2.new(0.48, -10, 0, 44)
    Verify.Position = UDim2.new(0, 20, 0, 198)
    Verify.BackgroundColor3 = Color3.fromRGB(0, 145, 220)
    Verify.BorderSizePixel = 0
    Verify.Text = "VERIFY KEY"
    Verify.TextColor3 = Color3.new(1, 1, 1)
    Verify.Font = Enum.Font.GothamBold
    Verify.TextSize = 13
    Verify.Parent = MainFrame

    local verifyCorner = Instance.new("UICorner")
    verifyCorner.CornerRadius = UDim.new(0, 9)
    verifyCorner.Parent = Verify

    local GetKey = Instance.new("TextButton")
    GetKey.Size = UDim2.new(0.48, -10, 0, 44)
    GetKey.Position = UDim2.new(0.52, -10, 0, 198)
    GetKey.BackgroundColor3 = Color3.fromRGB(30, 33, 40)
    GetKey.BorderSizePixel = 0
    GetKey.Text = "GET KEY"
    GetKey.TextColor3 = Color3.fromRGB(235, 235, 240)
    GetKey.Font = Enum.Font.GothamBold
    GetKey.TextSize = 13
    GetKey.Parent = MainFrame

    local getCorner = Instance.new("UICorner")
    getCorner.CornerRadius = UDim.new(0, 9)
    getCorner.Parent = GetKey

    local Status = Instance.new("TextLabel")
    Status.Name = "Status"
    Status.Size = UDim2.new(1, -40, 0, 38)
    Status.Position = UDim2.new(0, 20, 0, 255)
    Status.BackgroundTransparency = 1
    Status.Text = "STATUS: READY"
    Status.TextColor3 = Color3.fromRGB(135, 140, 150)
    Status.Font = Enum.Font.GothamMedium
    Status.TextSize = 12
    Status.TextXAlignment = Enum.TextXAlignment.Left
    Status.Parent = MainFrame

    local Discord = Instance.new("TextButton")
    Discord.Size = UDim2.new(1, -40, 0, 40)
    Discord.Position = UDim2.new(0, 20, 0, 300)
    Discord.BackgroundColor3 = Color3.fromRGB(42, 45, 55)
    Discord.BorderSizePixel = 0
    Discord.Text = "JOIN DISCORD"
    Discord.TextColor3 = Color3.fromRGB(235, 235, 240)
    Discord.Font = Enum.Font.GothamBold
    Discord.TextSize = 12
    Discord.Parent = MainFrame

    local discordCorner = Instance.new("UICorner")
    discordCorner.CornerRadius = UDim.new(0, 9)
    discordCorner.Parent = Discord

    local Tier = Instance.new("TextLabel")
    Tier.Size = UDim2.new(1, -40, 0, 24)
    Tier.Position = UDim2.new(0, 20, 0, 350)
    Tier.BackgroundTransparency = 1
    Tier.Text = "WORK.INK • KEY PROTECTED"
    Tier.TextColor3 = Color3.fromRGB(90, 95, 105)
    Tier.Font = Enum.Font.Gotham
    Tier.TextSize = 10
    Tier.TextXAlignment = Enum.TextXAlignment.Center
    Tier.Parent = MainFrame

    local busy = false

    local function setStatus(text, color)
        Status.Text = text
        Status.TextColor3 = color
    end

    local function finish(token)
        saveKey(token)

        setStatus(
            "VERIFIED • LOADING...",
            Color3.fromRGB(50, 230, 130)
        )

        notify("DEV_G", "Work.ink key verified.", 4)

        task.wait(0.5)
        ScreenGui:Destroy()

        return StartMainScript()
    end

    Verify.MouseButton1Click:Connect(function()
        if busy then return end

        local token = KeyBox.Text:gsub("^%s+", ""):gsub("%s+$", "")

        if token == "" then
            setStatus("STATUS: ENTER A KEY", Color3.fromRGB(255, 90, 100))
            return
        end

        busy = true
        Verify.AutoButtonColor = false
        GetKey.AutoButtonColor = false

        setStatus("STATUS: VERIFYING WITH WORK.INK...", Color3.fromRGB(90, 180, 255))

        task.spawn(function()
            local success, result = Workink.Check(token)

            if success then
                finish(token)
            else
                setStatus(
                    "STATUS: " .. tostring(result),
                    Color3.fromRGB(255, 90, 100)
                )

                notify("DEV_G", tostring(result), 5)

                busy = false
                Verify.AutoButtonColor = true
                GetKey.AutoButtonColor = true
            end
        end)
    end)

    GetKey.MouseButton1Click:Connect(function()
        local opened = openGetKey()

        if opened then
            setStatus(
                "STATUS: KEY PAGE OPENED",
                Color3.fromRGB(90, 190, 255)
            )
        else
            setStatus(
                "STATUS: KEY URL COPIED",
                Color3.fromRGB(90, 190, 255)
            )
        end

        notify("DEV_G", "Work.ink key page opened/copied.", 3)
    end)

    Discord.MouseButton1Click:Connect(function()
        if type(setclipboard) == "function" then
            pcall(setclipboard, Config.DiscordURL)
        elseif type(toclipboard) == "function" then
            pcall(toclipboard, Config.DiscordURL)
        end

        setStatus(
            "STATUS: DISCORD LINK COPIED",
            Color3.fromRGB(130, 150, 255)
        )

        notify("DEV_G", "Discord invite copied.", 3)
    end)

    -- Auto-login always performs a fresh Work.ink validation.
    task.spawn(function()
        task.wait(0.35)

        local savedKey = loadKey()

        if not savedKey or savedKey == "" then
            setStatus(
                "STATUS: ENTER KEY OR PRESS GET KEY",
                Color3.fromRGB(135, 140, 150)
            )
            return
        end

        if not Config.AutoExecute then
            KeyBox.Text = savedKey
            setStatus(
                "STATUS: SAVED KEY FOUND",
                Color3.fromRGB(135, 140, 150)
            )
            return
        end

        setStatus(
            "STATUS: AUTO-LOGIN VERIFYING...",
            Color3.fromRGB(90, 180, 255)
        )

        local success, result = Workink.Check(savedKey)

        if success then
            KeyBox.Text = savedKey
            finish(savedKey)
        else
            clearKey()
            KeyBox.Text = ""

            setStatus(
                "STATUS: SAVED KEY INVALID — GET A NEW KEY",
                Color3.fromRGB(255, 160, 70)
            )

            notify("DEV_G", tostring(result), 5)
        end
    end)
end

--========================================================
-- ENTRY
--========================================================

if not LocalPlayer then
    return
end

CreateGUI()
