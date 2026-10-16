local Config = {
    -- [1] PlatoBoost Settings
    ServiceId       = 33470,
    PlatoSecret     = "527e39a9-de92-4ed8-87ff-82c5d0b4512f",

    -- [2] Anti-Bypass / Global Secret Variable
    Secret          = "43o5oi3245kmgdklfsaslkdfj",

    -- [3] Scripts & Links
    MainScriptURL   = "https://raw.githubusercontent.com/DEV-Gscript/Scripts/refs/heads/main/Build-And-Kill-Zombies",

    -- [4] Social Media Settings
    ShowDiscord     = true,
    DiscordURL      = "https://discord.gg/RF7AffpSSV",

    ShowInstagram   = false,
    InstagramURL    = "https://www.instagram.com/oyb0i/",

    ShowYoutube     = false,
    YoutubeURL      = "https://www.youtube.com/channel/UCAlXXV1Hbvf7WbfXARuVtiQ",

    -- [5] File System
    KeyFileName     = "Mykey.txt",
    CacheFileName   = "Mykey_cache.txt",

    -- [6] Session Cache
    SessionCacheHours = 24,

    -- [7] GUI Management
    OldGuiName      = "DEV_G Free +",
    MainGuiName     = "DEV_G Free +",

    -- [8] Hub Information & UI Text
    HubName         = "DEV_G Free +",
    HubDescription  = "Stronger Security & More Frequent Updates",

    -- [9] ADMIN KEYS (bypass PlatoBoost entirely)
    AdminKeys = {
        "DEV_G-OWNER-MASTER-KEY0",
        "DEV_G-OWNER-MASTER-KEY1",
    }
}

-------------------------------------------------------------------------------
--! LIBRARIES (JSON & CRYPTOGRAPHY) - DO NOT MODIFY
-------------------------------------------------------------------------------
local a=2^32;local b=a-1;local function c(d,e)local f,g=0,1;while d~=0 or e~=0 do local h,i=d%2,e%2;local j=(h+i)%2;f=f+j*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return f%a end;local function k(d,e,l,...)local m;if e then d=d%a;e=e%a;m=c(d,e)if l then m=k(m,l,...)end;return m elseif d then return d%a else return 0 end end;local function n(d,e,l,...)local m;if e then d=d%a;e=e%a;m=(d+e-c(d,e))/2;if l then m=n(m,l,...)end;return m elseif d then return d%a else return b end end;local function o(p)return b-p end;local function q(d,r)if r<0 then return lshift(d,-r)end;return math.floor(d%2^32/2^r)end;local function s(p,r)if r>31 or r<-31 then return 0 end;return q(p%a,r)end;local function lshift(d,r)if r<0 then return s(d,-r)end;return d*2^r%2^32 end;local function t(p,r)p=p%a;r=r%32;local u=n(p,2^r-1)return s(p,r)+lshift(u,32-r)end;local v={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(x)return string.gsub(x,".",function(l)return string.format("%02x",string.byte(l))end)end;local function y(z,A)local x=""for B=1,A do local C=z%256;x=string.char(C)..x;z=(z-C)/256 end;return x end;local function D(x,B)local A=0;for B=B,B+3 do A=A*256+string.byte(x,B)end;return A end;local function E(F,G)local H=64-(G+9)%64;G=y(8*G,8)F=F.."\128"..string.rep("\0",H)..G;assert(#F%64==0)return F end;local function I(J)J[1]=0x6a09e667;J[2]=0xbb67ae85;J[3]=0x3c6ef372;J[4]=0xa54ff53a;J[5]=0x510e527f;J[6]=0x9b05688c;J[7]=0x1f83d9ab;J[8]=0x5be0cd19;return J end;local function K(F,B,J)local L={}for M=1,16 do L[M]=D(F,B+(M-1)*4)end;for M=17,64 do local N=L[M-15]local O=k(t(N,7),t(N,18),s(N,3))N=L[M-2]L[M]=(L[M-16]+O+L[M-7]+k(t(N,17),t(N,19),s(N,10)))%a end;local d,e,l,P,Q,R,S,T=J[1],J[2],J[3],J[4],J[5],J[6],J[7],J[8]for B=1,64 do local O=k(t(d,2),t(d,13),t(d,22))local U=k(n(d,e),n(d,l),n(e,l))local V=(O+U)%a;local W=k(t(Q,6),t(Q,11),t(Q,25))local X=k(n(Q,R),n(o(Q),S))local Y=(T+W+X+v[B]+L[B])%a;T=S;S=R;R=Q;Q=(P+Y)%a;P=l;l=e;e=d;d=(Y+V)%a end;J[1]=(J[1]+d)%a;J[2]=(J[2]+e)%a;J[3]=(J[3]+l)%a;J[4]=(J[4]+P)%a;J[5]=(J[5]+Q)%a;J[6]=(J[6]+R)%a;J[7]=(J[7]+S)%a;J[8]=(J[8]+T)%a end;local function Z(F)F=E(F,#F)local J=I({})for B=1,#F,64 do K(F,B,J)end;return w(y(J[1],4)..y(J[2],4)..y(J[3],4)..y(J[4],4)..y(J[5],4)..y(J[6],4)..y(J[7],4)..y(J[8],4))end;local e;local l={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local P={["/"]="/"}for Q,R in pairs(l)do P[R]=Q end;local S=function(T)return"\\"..(l[T]or string.format("u%04x",T:byte()))end;local B=function(M)return"null"end;local v=function(M,z)local _={}z=z or{}if z[M]then error("circular reference")end;z[M]=true;if rawget(M,1)~=nil or next(M)==nil then local A=0;for Q in pairs(M)do if type(Q)~="number"then error("invalid table: mixed or invalid key types")end;A=A+1 end;if A~=#M then error("invalid table: sparse array")end;for a0,R in ipairs(M)do table.insert(_,e(R,z))end;z[M]=nil;return"["..table.concat(_,",").."]"else for Q,R in pairs(M)do if type(Q)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(_,e(Q,z)..":"..e(R,z))end;z[M]=nil;return"{"..table.concat(_,",").."}"end end;local g=function(M)return'"'..M:gsub('[%z\1-\31\\\"]',S)..'"'end;local a1=function(M)if M~=M or M<=-math.huge or M>=math.huge then error("unexpected number value '"..tostring(M).."'")end;return string.format("%.14g",M)end;local j={["nil"]=B,["table"]=v,["string"]=g,["number"]=a1,["boolean"]=tostring}e=function(M,z)local x=type(M)local a2=j[x]if a2 then return a2(M,z)end;error("unexpected type '"..x.."'")end;local a3=function(M)return e(M)end;local a4;local N=function(...)local _={}for a0=1,select("#",...)do _[select(a0,...)]=true end;return _ end;local L=N(" ","\t","\r","\n")local p=N(" ","\t","\r","\n","]","}",",")local a5=N("\\","/",'"',"b","f","n","r","t","u")local m=N("true","false","null")local a6={["true"]=true,["false"]=false,["null"]=nil}local a7=function(a8,a9,aa,ab)for a0=a9,#a8 do if aa[a8:sub(a0,a0)]~=ab then return a0 end end;return#a8+1 end;local ac=function(a8,a9,J)local ad=1;local ae=1;for a0=1,a9-1 do ae=ae+1;if a8:sub(a0,a0)=="\n"then ad=ad+1;ae=1 end end;error(string.format("%s at line %d col %d",J,ad,ae))end;local af=function(A)local a2=math.floor;if A<=0x7f then return string.char(A)elseif A<=0x7ff then return string.char(a2(A/64)+192,A%64+128)elseif A<=0xffff then return string.char(a2(A/4096)+224,a2(A%4096/64)+128,A%64+128)elseif A<=0x10ffff then return string.char(a2(A/262144)+240,a2(A%262144/4096)+128,a2(A%4096/64)+128,A%64+128)end;error(string.format("invalid unicode codepoint '%x'",A))end;local ag=function(ah)local ai=tonumber(ah:sub(1,4),16)local aj=tonumber(ah:sub(7,10),16)if aj then return af((ai-0xd800)*0x400+aj-0xdc00+0x10000)else return af(ai)end end;local ak=function(a8,a0)local _=""local al=a0+1;local Q=al;while al<=#a8 do local am=a8:byte(al)if am<32 then ac(a8,al,"control character in string")elseif am==92 then _=_..a8:sub(Q,al-1)al=al+1;local T=a8:sub(al,al)if T=="u"then local an=a8:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",al+1)or a8:match("^%x%x%x%x",al+1)or ac(a8,al-1,"invalid unicode escape in string")_=_..ag(an)al=al+#an else if not a5[T]then ac(a8,al-1,"invalid escape char '"..T.."' in string")end;_=_..P[T]end;Q=al+1 elseif am==34 then _=_..a8:sub(Q,al-1)return _,al+1 end;al=al+1 end;ac(a8,a0,"expected closing quote for string")end;local ao=function(a8,a0)local am=a7(a8,a0,p)local ah=a8:sub(a0,am-1)local A=tonumber(ah)if not A then ac(a8,a0,"invalid number '"..ah.."'")end;return A,am end;local ap=function(a8,a0)local am=a7(a8,a0,p)local aq=a8:sub(a0,am-1)if not m[aq]then ac(a8,a0,"invalid literal '"..aq.."'")end;return a6[aq],am end;local ar=function(a8,a0)local _={}local A=1;a0=a0+1;while 1 do local am;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="]"then a0=a0+1;break end;am,a0=a4(a8,a0)_[A]=am;A=A+1;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="]"then break end;if as~=","then ac(a8,a0,"expected ']' or ','")end end;return _,a0 end;local at=function(a8,a0)local _={}a0=a0+1;while 1 do local au,M;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="}"then a0=a0+1;break end;if a8:sub(a0,a0)~='"'then ac(a8,a0,"expected string for key")end;au,a0=a4(a8,a0)a0=a7(a8,a0,L,true)if a8:sub(a0,a0)~=":"then ac(a8,a0,"expected ':' after key")end;a0=a7(a8,a0+1,L,true)M,a0=a4(a8,a0)_[au]=M;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="}"then break end;if as~=","then ac(a8,a0,"expected '}' or ','")end end;return _,a0 end;local av={['"']=ak,["0"]=ao,["1"]=ao,["2"]=ao,["3"]=ao,["4"]=ao,["5"]=ao,["6"]=ao,["7"]=ao,["8"]=ao,["9"]=ao,["-"]=ao,["t"]=ap,["f"]=ap,["n"]=ap,["["]=ar,["{"]=at}a4=function(a8,a9)local as=a8:sub(a9,a9)local a2=av[as]if a2 then return a2(a8,a9)end;ac(a8,a9,"unexpected character '"..as.."'")end;local aw=function(a8)if type(a8)~="string"then error("expected argument of type string, got "..type(a8))end;local _,a9=a4(a8,a7(a8,1,L,true))a9=a7(a8,a9,L,true)if a9<=#a8 then ac(a8,a9,"trailing garbage")end;return _ end;
local lEncode, lDecode, lDigest = a3, aw, Z;

-------------------------------------------------------------------------------
--! ROBUST FILE SYSTEM HELPERS
-------------------------------------------------------------------------------
local function safeWrite(path, content)
    if not writefile then return false, "writefile not supported" end
    local ok, err = pcall(writefile, path, tostring(content))
    if ok then return true end
    warn("[KeySystem] writefile failed: " .. tostring(err))
    return false, tostring(err)
end

local function safeRead(path)
    if not isfile or not readfile then return nil end
    local ok, exists = pcall(isfile, path)
    if not ok or not exists then return nil end
    local ok2, content = pcall(readfile, path)
    if not ok2 or not content or content == "" then return nil end
    return content
end

local function safeDelete(path)
    if not delfile then return end
    pcall(function()
        if isfile and isfile(path) then delfile(path) end
    end)
end

-------------------------------------------------------------------------------
--! HWID (cached, pcall-guarded)
-------------------------------------------------------------------------------
local _hwidCache = nil
local function getHwid()
    if _hwidCache then return _hwidCache end

    local ok, result
    if type(gethwid) == "function" then
        ok, result = pcall(gethwid)
    else
        ok, result = pcall(function()
            return game:GetService("RbxAnalyticsService"):GetClientId()
        end)
    end

    if not ok or type(result) ~= "string" or result == "" then
        result = "uid_" .. tostring(game:GetService("Players").LocalPlayer.UserId)
    end

    _hwidCache = result
    return _hwidCache
end

-------------------------------------------------------------------------------
--! SESSION CACHE (HWID-bound)
-------------------------------------------------------------------------------
local function saveSessionCache(key)
    local line = tostring(key) .. "|" .. tostring(os.time()) .. "|" .. tostring(getHwid())
    safeWrite(Config.CacheFileName, line)
end

local function loadSessionCache()
    local content = safeRead(Config.CacheFileName)
    if not content then return nil end
    local key, ts, cachedHwid = content:match("^(.-)|(%d+)|(.+)$")
    if not key or not ts or not cachedHwid then return nil end
    if cachedHwid ~= tostring(getHwid()) then return nil, "hwid-mismatch" end
    ts = tonumber(ts)
    if not ts then return nil end
    local ageHours = (os.time() - ts) / 3600
    if ageHours > Config.SessionCacheHours then return nil, "expired" end
    return key, ageHours
end

local function clearSessionCache()
    safeDelete(Config.CacheFileName)
end

-------------------------------------------------------------------------------
--! ADMIN KEY CHECK
-------------------------------------------------------------------------------
local function isAdminKey(key)
    if not key or key == "" then return false end
    for _, adminKey in ipairs(Config.AdminKeys) do
        if key == adminKey then return true end
    end
    return false
end

-------------------------------------------------------------------------------
--! CORE FUNCTIONS
-------------------------------------------------------------------------------
local useNonce = true

local function safeRequest(options)
    local req = request or http_request or syn_request or (http and http.request)
    if not req then return nil, "HTTP requests not supported" end
    local success, response = pcall(function() return req(options) end)
    if success and type(response) == "table" then
        return response
    else
        return nil, "Connection Error: " .. tostring(response or "Unknown")
    end
end

local fSetClipboard = setclipboard or toclipboard or function() end
local fStringChar, fToString, fOsTime, fMathRandom, fMathFloor = string.char, tostring, os.time, math.random, math.floor

local cachedLink, cachedTime = "", 0
local host = "https://api.platoboost.com"

local function checkConnectivity()
    local response = safeRequest({Url = host .. "/public/connectivity", Method = "GET"})
    if not response or (response.StatusCode ~= 200 and response.StatusCode ~= 429) then
        host = "https://api.platoboost.net"
        local fallback = safeRequest({Url = host .. "/public/connectivity", Method = "GET"})
        if not fallback then return false end
    end
    return true
end

local function generateNonce()
    local str = ""
    for _ = 1, 16 do str = str .. fStringChar(fMathFloor(fMathRandom() * 26) + 97) end
    return str
end

local function cacheLink()
    local isConnected = checkConnectivity()
    if not isConnected then
        return false, "Delta/Network Error! Use VPN or change Executor."
    end
    if cachedTime + (10*60) < fOsTime() then
        local response, err = safeRequest({
            Url = host .. "/public/start",
            Method = "POST",
            Body = lEncode({service = Config.ServiceId, identifier = lDigest(getHwid())}),
            Headers = {["Content-Type"] = "application/json"}
        })
        if response and response.StatusCode == 200 then
            local decoded = lDecode(response.Body)
            if decoded.success then
                cachedLink = decoded.data.url
                cachedTime = fOsTime()
                return true, cachedLink
            end
        end
        return false, err or "Server Unreachable"
    end
    return true, cachedLink
end

local function redeemKey(key, skipServer)
    if isAdminKey(key) then
        print("[KeySystem] Admin key detected. Bypassing PlatoBoost.")
        safeWrite(Config.KeyFileName, key)
        saveSessionCache(key)
        return true, "Success (Admin)", false
    end

    if skipServer then
        local cachedKey, age = loadSessionCache()
        if cachedKey and cachedKey == key then
            print(string.format("[KeySystem] Session cache hit (%.2f hours old).", age or 0))
            return true, "Success (Cached)", true
        end
    end

    local nonce = generateNonce()
    local body = {identifier = lDigest(getHwid()), key = key}
    if useNonce then body.nonce = nonce end

    local response, err = safeRequest({
        Url = host .. "/public/redeem/" .. fToString(Config.ServiceId),
        Method = "POST",
        Body = lEncode(body),
        Headers = {["Content-Type"] = "application/json"}
    })

    if response and response.StatusCode == 200 then
        local decoded = lDecode(response.Body)
        print("[KeySystem] Server response:", lEncode(decoded))
        if decoded.success and decoded.data.valid then
            if useNonce then
                if decoded.data.hash ~= lDigest("true" .. "-" .. nonce .. "-" .. Config.PlatoSecret) then
                    return false, "Integrity Check Failed", false
                end
            end
            safeWrite(Config.KeyFileName, key)
            saveSessionCache(key)
            return true, "Success", false
        end
        return false, decoded.message or "Invalid Key", false
    end
    return false, err or "Server Error", false
end

-------------------------------------------------------------------------------
--! MAIN SCRIPT LAUNCH
-------------------------------------------------------------------------------
local function StartMainScript()
    local player = game:GetService("Players").LocalPlayer
    local pGui = player:WaitForChild("PlayerGui")
    if pGui:FindFirstChild(Config.OldGuiName) then
        pGui[Config.OldGuiName]:Destroy()
        task.wait(0.1)
    end
    _G[Config.Secret] = true

    local ok, err = pcall(function()
        local src = game:HttpGet(Config.MainScriptURL)
        if type(src) ~= "string" or src == "" then
            error("Main script returned empty source")
        end
        local fn, compileErr = loadstring(src)
        if not fn then error("Compile: " .. tostring(compileErr)) end
        fn()
    end)

    if not ok then
        warn("[DEV_G] Main script error: " .. tostring(err))
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "DEV_G",
                Text = "Main script error: " .. tostring(err):sub(1, 200),
                Duration = 8,
            })
        end)
    end
end

-------------------------------------------------------------------------------
--! MODERN GUI
-------------------------------------------------------------------------------
local C = {
    bg       = Color3.fromRGB(16, 16, 18),
    panel    = Color3.fromRGB(22, 22, 25),
    panelHi  = Color3.fromRGB(30, 30, 34),
    border   = Color3.fromRGB(46, 46, 52),
    borderHi = Color3.fromRGB(60, 60, 68),
    text     = Color3.fromRGB(232, 230, 226),
    textDim  = Color3.fromRGB(140, 138, 135),
    textOff  = Color3.fromRGB(85, 84, 82),
    accent   = Color3.fromRGB(220, 160, 80),
    accentDim= Color3.fromRGB(150, 110, 55),
    success  = Color3.fromRGB(96, 196, 128),
    danger   = Color3.fromRGB(214, 84, 84),
}

local function corner(parent, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 6)
    c.Parent = parent
    return c
end

local function stroke(parent, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = parent
    return s
end

local function CreateGUI()
    local player = game:GetService("Players").LocalPlayer

    local targetParent
    local ok = pcall(function()
        if gethui then targetParent = gethui() end
    end)
    if not targetParent then
        ok = pcall(function() targetParent = game:GetService("CoreGui") end)
    end
    if not targetParent then
        targetParent = player:WaitForChild("PlayerGui")
    end

    if targetParent:FindFirstChild("OYB_KeySystem") then targetParent.OYB_KeySystem:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "OYB_KeySystem"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = targetParent

    -- social button height + gap for layout math
    local SOCIAL_H = 38
    local SOCIAL_GAP = 8
    local socialCount = 0
    if Config.ShowDiscord then socialCount = socialCount + 1 end
    if Config.ShowInstagram then socialCount = socialCount + 1 end
    if Config.ShowYoutube then socialCount = socialCount + 1 end

    local HEADER_H   = 54
    local PAD        = 16
    local INPUT_H    = 44
    local ACTION_H   = 40
    local STATUS_H   = 22
    local SOCIAL_BLOCK = socialCount > 0 and (socialCount * SOCIAL_H + (socialCount - 1) * SOCIAL_GAP + 14) or 0
    local TOTAL_H = HEADER_H + PAD + SOCIAL_BLOCK + INPUT_H + 10 + ACTION_H + 12 + STATUS_H + PAD

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 360, 0, TOTAL_H)
    MainFrame.Position = UDim2.new(0.5, -180, 0.5, -math.floor(TOTAL_H / 2))
    MainFrame.BackgroundColor3 = C.bg
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    corner(MainFrame, 10)
    stroke(MainFrame, C.border, 1, 0)

    -- ===================== HEADER =====================
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, HEADER_H)
    Header.BackgroundColor3 = C.panel
    Header.BorderSizePixel = 0
    Header.Parent = MainFrame
    corner(Header, 10)

    local headerPatch = Instance.new("Frame")
    headerPatch.Size = UDim2.new(1, 0, 0, 12)
    headerPatch.Position = UDim2.new(0, 0, 1, -12)
    headerPatch.BackgroundColor3 = C.panel
    headerPatch.BorderSizePixel = 0
    headerPatch.Parent = Header

    local headerSep = Instance.new("Frame")
    headerSep.Size = UDim2.new(1, 0, 0, 1)
    headerSep.Position = UDim2.new(0, 0, 1, 0)
    headerSep.BackgroundColor3 = C.border
    headerSep.BorderSizePixel = 0
    headerSep.Parent = Header

    -- Logo mark: solid accent square with D glyph
    local Logo = Instance.new("Frame")
    Logo.Size = UDim2.new(0, 30, 0, 30)
    Logo.Position = UDim2.new(0, 14, 0.5, -15)
    Logo.BackgroundColor3 = C.accent
    Logo.BorderSizePixel = 0
    Logo.Parent = Header
    corner(Logo, 6)

    local LogoGlyph = Instance.new("TextLabel")
    LogoGlyph.Size = UDim2.new(1, 0, 1, 0)
    LogoGlyph.BackgroundTransparency = 1
    LogoGlyph.Text = "D"
    LogoGlyph.TextColor3 = C.bg
    LogoGlyph.Font = Enum.Font.GothamBlack
    LogoGlyph.TextSize = 16
    LogoGlyph.Parent = Logo

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -130, 0, 18)
    Title.Position = UDim2.new(0, 54, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Text = Config.HubName
    Title.TextColor3 = C.text
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 15
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Header

    local Subtitle = Instance.new("TextLabel")
    Subtitle.Size = UDim2.new(1, -130, 0, 14)
    Subtitle.Position = UDim2.new(0, 54, 0, 30)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = "key verification"
    Subtitle.TextColor3 = C.textOff
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.TextSize = 11
    Subtitle.TextXAlignment = Enum.TextXAlignment.Left
    Subtitle.Parent = Header

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 26, 0, 26)
    CloseBtn.Position = UDim2.new(1, -36, 0.5, -13)
    CloseBtn.BackgroundColor3 = C.panelHi
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = C.textDim
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 12
    CloseBtn.AutoButtonColor = false
    CloseBtn.Parent = Header
    corner(CloseBtn, 4)

    CloseBtn.MouseEnter:Connect(function()
        CloseBtn.BackgroundColor3 = C.danger
        CloseBtn.TextColor3 = Color3.new(1,1,1)
    end)
    CloseBtn.MouseLeave:Connect(function()
        CloseBtn.BackgroundColor3 = C.panelHi
        CloseBtn.TextColor3 = C.textDim
    end)
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    -- ===================== CONTENT =====================
    local Content = Instance.new("Frame")
    Content.Name = "Content"
    Content.Size = UDim2.new(1, -PAD * 2, 1, -HEADER_H - PAD * 2)
    Content.Position = UDim2.new(0, PAD, 0, HEADER_H + PAD)
    Content.BackgroundTransparency = 1
    Content.Parent = MainFrame

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    layout.Parent = Content

    -- ===================== SOCIAL BUTTONS =====================
    local function makeSocialButton(text, iconAssetId, color, url, layoutOrder)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, SOCIAL_H)
        btn.BackgroundColor3 = C.panel
        btn.Text = ""
        btn.AutoButtonColor = false
        btn.LayoutOrder = layoutOrder
        btn.Parent = Content
        corner(btn, 6)
        stroke(btn, C.border, 1, 0)

        local stripe = Instance.new("Frame")
        stripe.Size = UDim2.new(0, 3, 0, 18)
        stripe.Position = UDim2.new(0, 10, 0.5, -9)
        stripe.BackgroundColor3 = color
        stripe.BorderSizePixel = 0
        stripe.Parent = btn
        corner(stripe, 2)

        if iconAssetId then
            local icon = Instance.new("ImageLabel")
            icon.Size = UDim2.new(0, 18, 0, 18)
            icon.Position = UDim2.new(0, 22, 0.5, -9)
            icon.BackgroundTransparency = 1
            icon.Image = iconAssetId
            icon.ImageColor3 = C.text
            icon.Parent = btn
        end

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -80, 1, 0)
        lbl.Position = UDim2.new(0, 50, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = C.text
        lbl.Font = Enum.Font.GothamMedium
        lbl.TextSize = 13
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = btn

        local arrow = Instance.new("TextLabel")
        arrow.Size = UDim2.new(0, 24, 1, 0)
        arrow.Position = UDim2.new(1, -30, 0, 0)
        arrow.BackgroundTransparency = 1
        arrow.Text = "→"
        arrow.TextColor3 = C.textOff
        arrow.Font = Enum.Font.GothamBold
        arrow.TextSize = 14
        arrow.Parent = btn

        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = C.panelHi
            stroke(btn, C.borderHi, 1, 0)
            arrow.TextColor3 = C.accent
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundColor3 = C.panel
            local s = btn:FindFirstChildOfClass("UIStroke")
            if s then s:Destroy() end
            stroke(btn, C.border, 1, 0)
            arrow.TextColor3 = C.textOff
        end)
        btn.MouseButton1Click:Connect(function()
            fSetClipboard(url)
            if statusLabelRef then
                statusLabelRef.Text = "copied  ·  " .. text:lower()
                statusLabelRef.TextColor3 = C.accent
            end
            local inviteCode = string.match(url, "discord%.gg/([%w-]+)")
            if syn and syn.request and inviteCode then
                syn.request({Url = "http://localhost:1111/discord?invite=" .. inviteCode, Method = "GET"})
            end
        end)
        return btn
    end

    local statusLabelRef = nil
    local socialOrder = 0

    if Config.ShowDiscord then
        socialOrder = socialOrder + 1
        makeSocialButton("join discord", "rbxassetid://18505728201", Color3.fromRGB(88, 101, 242), Config.DiscordURL, socialOrder)
    end
    if Config.ShowInstagram then
        socialOrder = socialOrder + 1
        makeSocialButton("follow instagram", "rbxassetid://18355586382", Color3.fromRGB(225, 48, 108), Config.InstagramURL, socialOrder)
    end
    if Config.ShowYoutube then
        socialOrder = socialOrder + 1
        makeSocialButton("subscribe youtube", "rbxassetid://82532989017804", Color3.fromRGB(230, 60, 60), Config.YoutubeURL, socialOrder)
    end

    -- Small spacer between social block and input
    if socialCount > 0 then
        local spacer = Instance.new("Frame")
        spacer.Size = UDim2.new(1, 0, 0, 6)
        spacer.BackgroundTransparency = 1
        spacer.LayoutOrder = 100
        spacer.Parent = Content
    end

    -- ===================== KEY INPUT =====================
    local inputWrap = Instance.new("Frame")
    inputWrap.Size = UDim2.new(1, 0, 0, INPUT_H)
    inputWrap.BackgroundColor3 = C.panel
    inputWrap.BorderSizePixel = 0
    inputWrap.LayoutOrder = 101
    inputWrap.Parent = Content
    corner(inputWrap, 6)
    stroke(inputWrap, C.border, 1, 0)

    local inputAccent = Instance.new("Frame")
    inputAccent.Size = UDim2.new(0, 2, 0, 22)
    inputAccent.Position = UDim2.new(0, 12, 0.5, -11)
    inputAccent.BackgroundColor3 = C.accentDim
    inputAccent.BorderSizePixel = 0
    inputAccent.Parent = inputWrap
    corner(inputAccent, 1)

    local KeyInput = Instance.new("TextBox")
    KeyInput.Size = UDim2.new(1, -32, 1, 0)
    KeyInput.Position = UDim2.new(0, 24, 0, 0)
    KeyInput.BackgroundTransparency = 1
    KeyInput.PlaceholderText = "enter key"
    KeyInput.PlaceholderColor3 = C.textOff
    KeyInput.Text = ""
    KeyInput.Font = Enum.Font.Code
    KeyInput.TextSize = 13
    KeyInput.TextColor3 = C.text
    KeyInput.TextXAlignment = Enum.TextXAlignment.Left
    KeyInput.ClearTextOnFocus = false
    KeyInput.Parent = inputWrap

    KeyInput.Focused:Connect(function()
        inputAccent.BackgroundColor3 = C.accent
        local s = inputWrap:FindFirstChildOfClass("UIStroke")
        if s then s.Color = C.borderHi end
    end)
    KeyInput.FocusLost:Connect(function()
        inputAccent.BackgroundColor3 = C.accentDim
        local s = inputWrap:FindFirstChildOfClass("UIStroke")
        if s then s.Color = C.border end
    end)

    -- ===================== ACTIONS =====================
    local ActionRow = Instance.new("Frame")
    ActionRow.Size = UDim2.new(1, 0, 0, ACTION_H)
    ActionRow.BackgroundTransparency = 1
    ActionRow.LayoutOrder = 102
    ActionRow.Parent = Content

    local VerifyBtn = Instance.new("TextButton")
    VerifyBtn.Size = UDim2.new(0.6, -4, 1, 0)
    VerifyBtn.Position = UDim2.new(0, 0, 0, 0)
    VerifyBtn.BackgroundColor3 = C.accent
    VerifyBtn.Text = "VERIFY"
    VerifyBtn.TextColor3 = C.bg
    VerifyBtn.Font = Enum.Font.GothamBold
    VerifyBtn.TextSize = 13
    VerifyBtn.AutoButtonColor = false
    VerifyBtn.Parent = ActionRow
    corner(VerifyBtn, 6)

    local GetKeyBtn = Instance.new("TextButton")
    GetKeyBtn.Size = UDim2.new(0.4, -4, 1, 0)
    GetKeyBtn.Position = UDim2.new(0.6, 4, 0, 0)
    GetKeyBtn.BackgroundColor3 = C.panel
    GetKeyBtn.Text = "GET KEY"
    GetKeyBtn.TextColor3 = C.text
    GetKeyBtn.Font = Enum.Font.GothamBold
    GetKeyBtn.TextSize = 13
    GetKeyBtn.AutoButtonColor = false
    GetKeyBtn.Parent = ActionRow
    corner(GetKeyBtn, 6)
    stroke(GetKeyBtn, C.border, 1, 0)

    VerifyBtn.MouseEnter:Connect(function()
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(235, 178, 100)
    end)
    VerifyBtn.MouseLeave:Connect(function()
        VerifyBtn.BackgroundColor3 = C.accent
    end)

    GetKeyBtn.MouseEnter:Connect(function()
        GetKeyBtn.BackgroundColor3 = C.panelHi
        local s = GetKeyBtn:FindFirstChildOfClass("UIStroke")
        if s then s.Color = C.borderHi end
    end)
    GetKeyBtn.MouseLeave:Connect(function()
        GetKeyBtn.BackgroundColor3 = C.panel
        local s = GetKeyBtn:FindFirstChildOfClass("UIStroke")
        if s then s.Color = C.border end
    end)

    -- ===================== STATUS =====================
    local StatusRow = Instance.new("Frame")
    StatusRow.Size = UDim2.new(1, 0, 0, STATUS_H)
    StatusRow.BackgroundTransparency = 1
    StatusRow.LayoutOrder = 103
    StatusRow.Parent = Content

    local StatusDot = Instance.new("Frame")
    StatusDot.Size = UDim2.new(0, 6, 0, 6)
    StatusDot.Position = UDim2.new(0, 3, 0.5, -3)
    StatusDot.BackgroundColor3 = C.textOff
    StatusDot.BorderSizePixel = 0
    StatusDot.Parent = StatusRow
    corner(StatusDot, 3)

    local Status = Instance.new("TextLabel")
    Status.Name = "StatusLabel"
    Status.Size = UDim2.new(1, -20, 1, 0)
    Status.Position = UDim2.new(0, 18, 0, 0)
    Status.BackgroundTransparency = 1
    Status.Text = "idle"
    Status.TextColor3 = C.textDim
    Status.Font = Enum.Font.Code
    Status.TextSize = 12
    Status.TextXAlignment = Enum.TextXAlignment.Left
    Status.Parent = StatusRow
    statusLabelRef = Status

    -- Breathing animation on the status dot
    local dotPhase = 0
    local RunService = game:GetService("RunService")
    local dotConn
    dotConn = RunService.Heartbeat:Connect(function(dt)
        if not StatusDot.Parent then
            if dotConn then dotConn:Disconnect() end
            return
        end
        dotPhase = (dotPhase + dt * 2) % (math.pi * 2)
        local alpha = 0.5 + 0.5 * math.sin(dotPhase)
        StatusDot.BackgroundTransparency = 1 - alpha
    end)

    local function setStatus(text, color, dotColor)
        Status.Text = text
        Status.TextColor3 = color or C.textDim
        StatusDot.BackgroundColor3 = dotColor or color or C.textOff
    end

    -- ===================== HANDLERS =====================
    local busy = false

    VerifyBtn.MouseButton1Click:Connect(function()
        if busy then return end
        local key = KeyInput.Text
        if key == "" then
            setStatus("enter a key", C.danger, C.danger)
            return
        end
        busy = true
        VerifyBtn.Text = "···"
        setStatus("verifying", C.accent, C.accent)
        task.spawn(function()
            local success, msg = redeemKey(key, false)
            if success then
                setStatus("verified", C.success, C.success)
                task.wait(0.5)
                ScreenGui:Destroy()
                StartMainScript()
            else
                setStatus(tostring(msg):lower(), C.danger, C.danger)
                VerifyBtn.Text = "VERIFY"
                busy = false
            end
        end)
    end)

    GetKeyBtn.MouseButton1Click:Connect(function()
        setStatus("fetching link", C.accent, C.accent)
        local success, link = cacheLink()
        if success then
            fSetClipboard(link)
            setStatus("link copied", C.success, C.success)
        else
            setStatus(tostring(link):lower(), C.danger, C.danger)
        end
    end)

    KeyInput.FocusLost:Connect(function(enter)
        if enter and not busy and KeyInput.Text ~= "" then
            VerifyBtn.MouseButton1Click:Fire()
        end
    end)

    -- ===================== AUTO-LOGIN =====================
    task.spawn(function()
        task.wait(0.35)
        local savedKey = safeRead(Config.KeyFileName)
        if not savedKey then
            setStatus("no saved key", C.textDim)
            return
        end

        local cachedKey, age = loadSessionCache()
        if cachedKey and cachedKey == savedKey then
            setStatus(string.format("auto-login (cached, %.1fh)", age or 0), C.success, C.success)
            KeyInput.Text = savedKey
            task.wait(0.5)
            ScreenGui:Destroy()
            StartMainScript()
            return
        end

        setStatus("checking saved key", C.accent, C.accent)
        KeyInput.Text = savedKey
        local success, msg = redeemKey(savedKey, false)
        if success then
            setStatus("auto-login ok", C.success, C.success)
            task.wait(0.5)
            ScreenGui:Destroy()
            StartMainScript()
        else
            safeDelete(Config.KeyFileName)
            clearSessionCache()
            KeyInput.Text = ""
            setStatus("saved key expired", C.accent, C.accent)
        end
    end)
end

-------------------------------------------------------------------------------
--! ENTRY POINT
-------------------------------------------------------------------------------
local player = game:GetService("Players").LocalPlayer
local pGui = player:WaitForChild("PlayerGui")

if pGui:FindFirstChild(Config.MainGuiName) then
    StartMainScript()
    return
end

CreateGUI()
