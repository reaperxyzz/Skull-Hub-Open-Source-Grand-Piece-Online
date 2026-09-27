if getgenv().SkullHubGPO then
	return
end

getgenv().SkullHubGPO = true

if game.GameId ~= 648454481 then
	getgenv().SkullHubGPO = nil
	return warn("[Skull Hub] Not Grand Piece Online (GameId " .. tostring(game.GameId) .. ")")
end

repeat
	task.wait()
until game:IsLoaded()

if setthreadidentity then
	pcall(setthreadidentity, 8)
end

local fn

fn = function(arg)
	return cloneref and cloneref(arg) or arg
end

local v
v = fn(game:GetService("Players"))
local v2
v2 = fn(game:GetService("RunService"))
local v3
v3 = fn(game:GetService("UserInputService"))
local v4
v4 = fn(game:GetService("Lighting"))
local v5
v5 = fn(game:GetService("TeleportService"))
local v6
v6 = fn(game:GetService("ReplicatedStorage"))
local localPlayer
localPlayer = v.LocalPlayer
local fn2

fn2 = function(arg)
	local ok, result = pcall(tostring, arg)
	return ok and result or ""
end

local fn3

fn3 = function(arg, arg2)
	local vector = Vector3.new(arg2.X - arg.X, 0, arg2.Z - arg.Z)

	if vector.Magnitude < 0.05 then
		local character = v.LocalPlayer.Character
		character = character and character:FindFirstChild("HumanoidRootPart")
		character = character and character.CFrame.LookVector or Vector3.new(0, 0, -1)
		vector = Vector3.new(character.X, 0, character.Z)

		if vector.Magnitude < 0.05 then
			vector = Vector3.new(0, 0, -1)
		end
	end

	return CFrame.new(arg, arg + vector.Unit)
end

local fn4

fn4 = function(arg, arg2, ...)
	local v7 = table.pack(pcall(arg2, ...))

	if not v7[1] then
		local v8 = v7[2]
		warn(("[Skull Hub][%s] %s"):format(tostring(arg), fn2(v8)))
		return false
	end

	return true, table.unpack(v7, 2, v7.n)
end

local tbl
tbl = {}
local env = getfenv(0)

for _, v7 in ipairs({
	"getgenv",
	"gethui",
	"cloneref",
	"setthreadidentity",
	"hookfunction",
	"hookmetamethod",
	"firesignal",
	"getactors",
	"run_on_actor",
	"create_comm_channel",
	"get_comm_channel",
	"filtergc",
	"getgc",
	"setstackhidden",
	"islclosure",
	"isexecutorfunc",
	"setfpscap",
	"setfflag",
	"writefile",
	"readfile",
	"isfile",
	"request",
	"http_request",
	"getconnections",
	"queue_on_teleport",
	"newcclosure",
	"checkcaller",
	"getnamecallmethod",
	"getrenv",
	"fireproximityprompt",
	"firetouchinterest",
}) do
	local ok, result = pcall(function()
		return env[v7]
	end)

	tbl[v7] = ok and type(result) == "function"
end

local fn5, fn6, fn7

local function fn8(arg, arg2)
	return function(...)
		local ok, result = pcall(arg, ...)

		if not ok then
			warn(("[Skull Hub][%s] %s"):format(tostring(arg2 or "thread"), fn2(result)))
		end
	end
end

fn5 = function(arg, arg2, ...)
	return task.spawn(fn8(arg2, arg), ...)
end

fn6 = function(arg, arg2, arg3)
	return task.delay(arg, fn8(arg3, arg2))
end

fn7 = function(arg, arg2, arg3)
	return arg:Connect(fn8(arg3, arg2))
end

local function fn9()
	local n = os.clock() + 90

	while os.clock() < n do
		local loaded = localPlayer:FindFirstChild("Loaded")
		if not (loaded and loaded.Value == true) then
			task.wait(0.1)
			continue
		end
		break
	end

	if localPlayer:GetAttribute("inventoryVerified") ~= nil then
		local n2 = os.clock() + 60

		while os.clock() < n2 do
			if localPlayer:GetAttribute("inventoryVerified") ~= true then
				task.wait(0.1)
				continue
			end
			break
		end
	end

	local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
	if not playerGui then
		return
	end
	local n2 = os.clock() + 25

	while os.clock() < n2 do
		if playerGui:FindFirstChild("Intro") or playerGui:FindFirstChild("Intro2") then
			task.wait(0.1)
			continue
		end
		break
	end
end

fn9()

if type(getgenv().KaitunConfig) == "table" then
	getgenv().hq99 = true
end

getgenv().SkullHubGPOKaitun = nil

local function fn10()
	local kaitunConfig = getgenv().KaitunConfig
	if type(kaitunConfig) ~= "table" then
		return
	end

	local function fn11(arg)
		local v7 = kaitunConfig[arg]
		if type(v7) == "table" then
			return v7
		end
		return {}
	end

	local function fn12(arg)
		if type(arg) ~= "string" then
			return ""
		end
		return (arg:gsub("^%s+", ""):gsub("%s+$", ""))
	end

	local farmLevel = fn11("Farm Level")
	local str = fn12(farmLevel.Method):lower()
	local str2

	if str == "rifle" or str == "gun" then
		str2 = "Rifle"
	else
		str2 = "Melee"
	end

	local str3 = fn12(farmLevel.Mode):lower()
	local str4, flag

	if str3 == "" or str3:find("full") or str3:find("progres") then
		str4 = "Level (auto)"
		flag = true
	elseif str3:find("buso") or str3:find("haki") or str3:find("armament") then
		str4 = "Buso Haki (Ray)"
		flag = false
	elseif str3:find("juzo") or str3:find("boss") then
		str4 = "Boss: Juzo (Sea 2)"
		flag = false
	elseif str3:find("quest") then
		str4 = "Quest (level)"
		flag = false
	elseif str3:find("near") or str3:find("hostile") or str3:find("mob") then
		str4 = "Nearest hostile"
		flag = false
	else
		str4 = "Level (auto)"
		flag = false
	end

	local str5 = fn12(farmLevel.Move):lower()
	local str6

	if str5:find("only") or str5:find("no glide") then
		str6 = "Walk only"
	elseif str5:find("walk") then
		str6 = "Walk"
	else
		str6 = "Glide"
	end

	local num = tonumber(farmLevel["Tween Speed"] or farmLevel.TweenSpeed)
	local n

	if num then
		n = math.clamp(math.floor(num), 16, 100)
	else
		n = 46
	end

	local tbl2 = {}
	local v7 = pairs
	local privateServer = fn11("Private Server")

	for k, v8 in v7(privateServer) do
		if type(k) == "string" then
			local v9 = fn12(v8)

			if v9 ~= "" and not v9:lower():match("^pscode_?%d*$") then
				tbl2[k:lower()] = v9
			end
		end
	end

	local tbl3 = {}
	local tbl4 = {}
	local autoRedeemCodes = kaitunConfig["Auto Redeem Codes"]

	if type(autoRedeemCodes) == "table" then
		for _, autoRedeemCode in ipairs(autoRedeemCodes) do
			local v8 = fn12(autoRedeemCode)
			local str7 = v8:lower()

			if v8 ~= "" and not str7:match("^code%d*$") and not tbl4[str7] then
				tbl4[str7] = true
				tbl3[#tbl3 + 1] = v8
			end
		end
	end

	local Performance = fn11("Performance")
	local Webhook = fn11("Webhook")
	local num2 = tonumber(Performance["FPS Cap"])
	local genv = getgenv()
	local skullHubGPOKaitun = { method = str2, mode = str4, full = flag, move = str6, tween = n, ps = tbl2, codes = tbl3 }
	local autoOutfit = kaitunConfig["Auto Random Outfit"] == true

	if not autoOutfit then
		autoOutfit = fn12(kaitunConfig["Auto Random Outfit"]):lower() == "true"
	end

	skullHubGPOKaitun.autoOutfit = autoOutfit
	skullHubGPOKaitun.webhook = fn12(Webhook.URL)
	skullHubGPOKaitun.mention = fn12(Webhook["Mention ID"])

	skullHubGPOKaitun.fp = {
		phase = nil,
		busy = false,
		rodTries = 0,
		rodNextAt = 0,
		fishRestarts = 0,
		puffTries = 0,
		puffNextAt = 0,
	}

	skullHubGPOKaitun.detail = ""
	skullHubGPOKaitun.progRows = {}
	skullHubGPOKaitun.resRows = {}
	skullHubGPOKaitun.fpsCap = num2 and math.clamp(math.floor(num2), 5, 240) or 60
	skullHubGPOKaitun.boostFps = Performance["Boost FPS"] ~= false
	skullHubGPOKaitun.blackScreen = Performance["Black Screen"] ~= false
	skullHubGPOKaitun.deleteMap = Performance["Delete Map"] ~= false
	skullHubGPOKaitun.log = {}
	skullHubGPOKaitun.paragraphs = {}
	skullHubGPOKaitun.started = os.clock()
	skullHubGPOKaitun.status = "Booting"
	skullHubGPOKaitun.where = "Loading"
	skullHubGPOKaitun.level = nil
	genv.SkullHubGPOKaitun = skullHubGPOKaitun
end

fn10()

local function fn11()
	local skullHubGPOKaitun = getgenv().SkullHubGPOKaitun
	if not skullHubGPOKaitun then
		return
	end

	skullHubGPOKaitun.note = function(arg)
		local str = tostring(arg or "")
		table.insert(skullHubGPOKaitun.log, str)

		while #skullHubGPOKaitun.log > 40 do
			table.remove(skullHubGPOKaitun.log, 1)
		end

		warn("[Skull Hub][Kaitun] " .. str)
	end

	skullHubGPOKaitun.serialize = function(arg, arg2)
		local n = arg2 or 0
		local kind = type(arg)
		if kind == "string" then
			return string.format("%q", arg)
		end

		if kind == "number" or kind == "boolean" then
			return tostring(arg)
		end

		if kind ~= "table" or n > 4 then
			return nil
		end
		local tbl2 = {}

		for k, v7 in pairs(arg) do
			local v8 = skullHubGPOKaitun.serialize(v7, n + 1)

			if v8 then
				if type(k) == "string" then
					tbl2[#tbl2 + 1] = ("[%q]=%s"):format(k, v8)
				elseif type(k) == "number" then
					tbl2[#tbl2 + 1] = ("[%d]=%s"):format(k, v8)
				end
			end
		end

		return "{" .. table.concat(tbl2, ",") .. "}"
	end

	skullHubGPOKaitun.queueSelf = function()
		if skullHubGPOKaitun.queued then
			return true
		end

		if not queue_on_teleport then
			return false
		end
		local v7 = skullHubGPOKaitun.serialize(getgenv().KaitunConfig)
		if not v7 then
			return false
		end

		local ok = pcall(queue_on_teleport, table.concat({
			"getgenv().KaitunConfig = " .. v7,
			"repeat task.wait() until game:IsLoaded()",
			"loadstring(game:HttpGet('https://raw.githubusercontent.com/hungquan99/SkullHub/main/loader.lua'))()",
		}, "\n"))

		skullHubGPOKaitun.queued = ok
		return ok
	end

	skullHubGPOKaitun.rejoinMenu = function(arg)
		local rejoinAt = skullHubGPOKaitun.rejoinAt

		if rejoinAt then
			local rejoinAt2 = skullHubGPOKaitun.rejoinAt
			rejoinAt = os.clock() - rejoinAt2 < 20
		end

		if rejoinAt then
			return
		end

		local ok, result = pcall(function()
			return fn(game:GetService("GuiService")):GetErrorMessage()
		end)

		if ok and type(result) == "string" and result:lower():find("banned", 1, true) then
			skullHubGPOKaitun.status = "BANNED - not rejoining"
			return
		end
		skullHubGPOKaitun.rejoinAt = os.clock()
		skullHubGPOKaitun.status = "Disconnected - rejoining the main menu"
		skullHubGPOKaitun.where = "Rejoining"
		skullHubGPOKaitun.note("Rejoining the main menu (" .. fn2(arg):sub(1, 80) .. ").")
		skullHubGPOKaitun.queueSelf()

		pcall(function()
			v5:Teleport(1730877806, localPlayer)
		end)
	end

	skullHubGPOKaitun.armRejoin = function()
		if skullHubGPOKaitun.rejoinArmed then
			return
		end
		skullHubGPOKaitun.rejoinArmed = true
		local v7 = fn(game:GetService("GuiService"))

		local function fn12(arg)
			local v8 = fn2(arg)
			if v8 == "" then
				return
			end

			if v8:lower():find("banned", 1, true) then
				if not skullHubGPOKaitun.banSaid then
					skullHubGPOKaitun.banSaid = true
					skullHubGPOKaitun.status = "BANNED - not rejoining"
					skullHubGPOKaitun.note("The game reported a ban - auto rejoin skipped.")
				end

				return
			end

			skullHubGPOKaitun.rejoinMenu(v8)
		end

		fn7(v7.ErrorMessageChanged, "KaitunRejoin", fn12)

		fn5("KaitunRejoinPoll", function()
			while true do
				task.wait(5)

				local ok, result = pcall(function()
					return v7:GetErrorMessage()
				end)

				if ok and type(result) == "string" and result ~= "" then
					fn12(result)
				end
			end
		end)
	end

	local tbl2 = { "Eye", "Mouth", "Hair1", "Hair2", "Shirt", "Pants", "Shoe" }
	local tbl3 = { "Hair1Color", "Hair2Color", "ShirtPri", "ShirtSec", "PantsPri", "PantsSec", "ShoeColor" }

	skullHubGPOKaitun.outfitIsDefault = function(arg)
		for _, v7 in ipairs(tbl2) do
			local v8 = arg:FindFirstChild(v7)
			if not (v8 and v8:IsA("IntValue")) then
				return nil
			end

			if v8.Value ~= 1 then
				return false
			end
		end

		for _, v7 in ipairs(tbl3) do
			local v8 = arg:FindFirstChild(v7)
			if not (v8 and v8:IsA("Color3Value")) then
				return nil
			end
			local value = v8.Value
			if value.R < 0.999 or value.G < 0.999 or value.B < 0.999 then
				return false
			end
		end

		return true
	end

	skullHubGPOKaitun.randomOutfit = function()
		if not skullHubGPOKaitun.autoOutfit or skullHubGPOKaitun.outfitTried then
			return
		end
		skullHubGPOKaitun.outfitTried = true
		local v7 = v6:WaitForChild("Stats" .. localPlayer.Name, 30)
		local customization = v7 and v7:WaitForChild("Customization", 15)
		local events = v6:FindFirstChild("Events")
		local set = events and events:FindFirstChild("set")
		if not (customization and set and set:IsA("RemoteEvent")) then
			skullHubGPOKaitun.note("Auto Random Outfit: Customization data or Events.set not found - skipped.")
			return
		end
		local v8 = skullHubGPOKaitun.outfitIsDefault(customization)
		if v8 == nil then
			skullHubGPOKaitun.note("Auto Random Outfit: unknown Customization layout - skipped, nothing sent.")
			return
		end

		if v8 == false then
			skullHubGPOKaitun.note("Auto Random Outfit: outfit already customised - kept.")
			return
		end
		skullHubGPOKaitun.status = "Randomizing outfit"
		local v9 = Random.new()

		local function fn12()
			local nextInteger = v9.NextInteger
			return Color3.fromRGB(v9:NextInteger(0, 255), v9:NextInteger(0, 255), nextInteger(v9, 0, 255))
		end

		local n = math.floor(tonumber(workspace:GetAttribute("TotalHairs")) or 256)

		if n < 1 then
			n = 256
		end

		local race = customization:FindFirstChild("Race")
		race = race and tostring(race.Value):match("Fishman") ~= nil
		local n2 = 1
		local n3 = 7

		if race then
			n2 = 8
			n3 = 13
		end

		local tbl4 = {}
		local tbl5 = { "Eye", v9:NextInteger(1, 74) }
		local tbl6 = { "Mouth", v9:NextInteger(1, 36) }
		local tbl7 = { "Hair1", v9:NextInteger(1, n) }
		local tbl8 = { "Hair1Color", fn12() }
		local tbl9 = { "Hair2", v9:NextInteger(1, n) }
		local tbl10 = { "Hair2Color", fn12() }
		local tbl11 = { "Shirt", v9:NextInteger(1, 24) }
		local tbl12 = { "ShirtPri", fn12() }
		local tbl13 = { "ShirtSec", fn12() }
		local tbl14 = { "Pants", v9:NextInteger(1, 22) }
		local tbl15 = { "PantsPri", fn12() }
		local tbl16 = { "PantsSec", fn12() }
		local tbl17 = { "Shoe", v9:NextInteger(1, 12) }
		local tbl18 = { "ShoeColor", fn12() }
		local tbl19 = { "SkinColor", v9:NextInteger(n2, n3) }
		tbl4[1] = tbl5
		tbl4[2] = tbl6
		tbl4[3] = tbl7
		tbl4[4] = tbl8
		tbl4[5] = tbl9
		tbl4[6] = tbl10
		tbl4[7] = tbl11
		tbl4[8] = tbl12
		tbl4[9] = tbl13
		tbl4[10] = tbl14
		tbl4[11] = tbl15
		tbl4[12] = tbl16
		tbl4[13] = tbl17
		tbl4[14] = tbl18
		tbl4[15] = tbl19

		for _, v10 in ipairs(tbl4) do
			pcall(function()
				set:FireServer(v10[1], v10[2])
			end)

			task.wait(0.15)
		end

		local function fn13()
			local n4 = 0

			for _, v10 in ipairs(tbl4) do
				local v11 = customization:FindFirstChild(v10[1])

				if v11 then
					local v12 = v10[2]
					local value = v11.Value

					if typeof(v12) == "Color3" and typeof(value) == "Color3" then
						if math.abs(v12.R - value.R) < 0.01 and math.abs(v12.G - value.G) < 0.01 and math.abs(v12.B - value.B) < 0.01 then
							n4 += 1
						end
					elseif value == v12 then
						n4 += 1
					end
				end
			end

			return n4
		end

		local n4 = os.clock() + 8
		local v10 = fn13()

		while v10 < #tbl4 and os.clock() < n4 do
			task.wait(0.5)
			v10 = fn13()
		end

		if v10 == #tbl4 then
			skullHubGPOKaitun.note(("Auto Random Outfit: randomised (%d/%d fields confirmed)."):format(v10, #tbl4))
		else
			skullHubGPOKaitun.note(("Auto Random Outfit: only %d/%d fields confirmed by the server."):format(v10, #tbl4))
		end
	end

	skullHubGPOKaitun.buildHUD = function()
		if skullHubGPOKaitun.hud then
			return
		end
		local UserInputService = game:GetService("UserInputService")

		local ok, parent = pcall(function()
			return gethui and gethui()
		end)

		if not (ok and parent) then
			local ok2

			ok2, parent = pcall(function()
				return game:GetService("CoreGui")
			end)

			parent = ok2 and parent or localPlayer:WaitForChild("PlayerGui")
		end

		local skullHubKaitunHUD = parent:FindFirstChild("SkullHubKaitunHUD")

		if skullHubKaitunHUD then
			skullHubKaitunHUD:Destroy()
		end

		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "SkullHubKaitunHUD"
		screenGui.ResetOnSpawn = false
		screenGui.IgnoreGuiInset = true
		screenGui.DisplayOrder = 2147483647
		screenGui.Parent = parent
		skullHubGPOKaitun.hud = screenGui
		local frame = Instance.new("Frame")
		frame.Position = UDim2.new(0, 12, 0, 60)
		frame.Size = UDim2.new(0, 300, 0, 226)
		frame.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
		frame.BackgroundTransparency = 0.08
		frame.BorderSizePixel = 0
		frame.Parent = screenGui
		Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
		local uiStroke = Instance.new("UIStroke")
		uiStroke.Color = Color3.fromRGB(70, 70, 78)
		uiStroke.Transparency = 0.35
		uiStroke.Parent = frame
		local imageLabel = Instance.new("ImageLabel")
		imageLabel.BackgroundTransparency = 1
		imageLabel.Position = UDim2.new(0, 10, 0, 5)
		imageLabel.Size = UDim2.new(0, 18, 0, 18)
		imageLabel.Image = "rbxassetid://95183678717613"
		imageLabel.Parent = frame
		local textLabel = Instance.new("TextLabel")
		textLabel.BackgroundTransparency = 1
		textLabel.Position = UDim2.new(0, 32, 0, 6)
		textLabel.Size = UDim2.new(1, -82, 0, 18)
		textLabel.Font = Enum.Font.GothamBold
		textLabel.TextSize = 13
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.Text = "SKULL HUB - GPO [Kaitun]"
		textLabel.Parent = frame
		local image = "rbxassetid://71457658246709"
		local image2 = "rbxassetid://98648581502859"
		local imageButton = Instance.new("ImageButton")
		imageButton.AnchorPoint = Vector2.new(1, 0)
		imageButton.Position = UDim2.new(1, -8, 0, 6)
		imageButton.Size = UDim2.new(0, 18, 0, 18)
		imageButton.BackgroundTransparency = 1
		imageButton.Image = image
		imageButton.ImageColor3 = Color3.fromRGB(180, 180, 190)
		imageButton.Parent = frame
		local frame2 = Instance.new("Frame")
		frame2.BackgroundTransparency = 1
		frame2.Position = UDim2.new(0, 10, 0, 26)
		frame2.Size = UDim2.new(1, -20, 1, -34)
		frame2.Parent = frame

		local function createTextLabel(arg, textSize, textColor3, arg2)
			local textLabel2 = Instance.new("TextLabel")
			textLabel2.BackgroundTransparency = 1
			textLabel2.Position = UDim2.new(0, 0, 0, arg)
			textLabel2.Size = UDim2.new(1, 0, 0, textSize + 3)

			if arg2 then
				textLabel2.Font = Enum.Font.GothamBold
			else
				textLabel2.Font = Enum.Font.Gotham
			end

			textLabel2.TextSize = textSize
			textLabel2.TextXAlignment = Enum.TextXAlignment.Left
			textLabel2.TextYAlignment = Enum.TextYAlignment.Top
			textLabel2.TextColor3 = textColor3
			textLabel2.TextTruncate = Enum.TextTruncate.AtEnd
			textLabel2.Text = ""
			textLabel2.Parent = frame2
			return textLabel2
		end

		local v7 = createTextLabel(0, 11, Color3.fromRGB(150, 150, 160))
		local v8 = createTextLabel(16, 12, Color3.fromRGB(120, 220, 140), true)
		local v9 = createTextLabel(34, 11, Color3.fromRGB(120, 190, 255), true)
		local v10 = createTextLabel(50, 11, Color3.fromRGB(210, 210, 220))
		local v11 = createTextLabel(66, 11, Color3.fromRGB(150, 150, 160))
		createTextLabel(86, 11, Color3.fromRGB(150, 150, 160), true).Text = "Recent actions"
		local tbl4 = {}

		for i = 1, 4 do
			tbl4[i] = createTextLabel(100 + (i - 1) * 14, 11, Color3.fromRGB(190, 190, 200))
		end

		local scrollingFrame = Instance.new("ScrollingFrame")
		scrollingFrame.BackgroundTransparency = 1
		scrollingFrame.BorderSizePixel = 0
		scrollingFrame.Position = UDim2.new(0, 10, 0, 26)
		scrollingFrame.Size = UDim2.new(1, -20, 1, -66)
		scrollingFrame.ScrollBarThickness = 3
		scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(90, 90, 100)
		scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
		scrollingFrame.Visible = false
		scrollingFrame.Parent = frame
		local tbl5 = {}

		for i = 1, 22 do
			local frame3 = Instance.new("Frame")
			frame3.BackgroundTransparency = 1
			frame3.Position = UDim2.new(0, 0, 0, (i - 1) * 15)
			frame3.Size = UDim2.new(1, -6, 0, 14)
			frame3.Visible = false
			frame3.Parent = scrollingFrame
			local textLabel2 = Instance.new("TextLabel")
			textLabel2.BackgroundTransparency = 1
			textLabel2.Size = UDim2.new(0.58, 0, 1, 0)
			textLabel2.Font = Enum.Font.Gotham
			textLabel2.TextSize = 11
			textLabel2.TextXAlignment = Enum.TextXAlignment.Left
			textLabel2.TextTruncate = Enum.TextTruncate.AtEnd
			textLabel2.TextColor3 = Color3.fromRGB(205, 205, 215)
			textLabel2.Text = ""
			textLabel2.Parent = frame3
			local textLabel3 = Instance.new("TextLabel")
			textLabel3.BackgroundTransparency = 1
			textLabel3.AnchorPoint = Vector2.new(1, 0)
			textLabel3.Position = UDim2.new(1, 0, 0, 0)
			textLabel3.Size = UDim2.new(0.42, 0, 1, 0)
			textLabel3.Font = Enum.Font.GothamBold
			textLabel3.TextSize = 11
			textLabel3.TextXAlignment = Enum.TextXAlignment.Right
			textLabel3.TextTruncate = Enum.TextTruncate.AtEnd
			textLabel3.TextColor3 = Color3.fromRGB(150, 150, 160)
			textLabel3.Text = ""
			textLabel3.Parent = frame3
			tbl5[i] = { row = frame3, name = textLabel2, value = textLabel3 }
		end

		local function createTextButton(arg, text)
			local textButton = Instance.new("TextButton")

			if arg == 0 then
				textButton.Position = UDim2.new(arg, 10, 1, -32)
			else
				textButton.Position = UDim2.new(arg, 4, 1, -32)
			end

			textButton.Size = UDim2.new(0.5, -14, 0, 24)
			textButton.BackgroundColor3 = Color3.fromRGB(34, 34, 40)
			textButton.BorderSizePixel = 0
			textButton.AutoButtonColor = true
			textButton.Font = Enum.Font.GothamBold
			textButton.TextSize = 11
			textButton.TextColor3 = Color3.fromRGB(190, 190, 200)
			textButton.Text = text
			textButton.Parent = frame
			Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 6)
			return textButton
		end

		local viewProgress = createTextButton(0, "View Progress")
		local viewResources = createTextButton(0.5, "View Resources")
		local v12 = nil
		local color = Color3.fromRGB(190, 190, 200)

		local function fn12(arg)
			if v12 == arg then
				v12 = nil
			else
				v12 = arg
			end

			scrollingFrame.Visible = v12 ~= nil
			frame2.Visible = v12 == nil

			if v12 == "prog" then
				viewProgress.TextColor3 = Color3.fromRGB(120, 220, 140)
			else
				viewProgress.TextColor3 = color
			end

			if v12 == "res" then
				viewResources.TextColor3 = Color3.fromRGB(120, 190, 255)
			else
				viewResources.TextColor3 = color
			end
		end

		fn7(viewProgress.MouseButton1Click, "HUDProg", function()
			fn12("prog")
		end)

		fn7(viewResources.MouseButton1Click, "HUDRes", function()
			fn12("res")
		end)

		local function fn13(arg, arg2)
			local viewportSize = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize
			local x = viewportSize and viewportSize.X or 1280
			viewportSize = viewportSize and viewportSize.Y or 720
			local y = frame.AbsoluteSize.Y
			return math.clamp(arg, 0, math.max(0, x - frame.AbsoluteSize.X)), math.clamp(arg2, 0, math.max(0, viewportSize - y))
		end

		local flag = false
		local v13 = nil
		local v14 = nil

		local function fn14(arg)
			if arg.UserInputType == Enum.UserInputType.MouseButton1 or arg.UserInputType == Enum.UserInputType.Touch then
				local position = arg.Position
				local position2 = frame.Position
				flag = true
				v13 = position
				v14 = position2
			end
		end

		fn7(frame.InputBegan, "HUDDrag", fn14)
		fn7(textLabel.InputBegan, "HUDDrag", fn14)

		fn7(UserInputService.InputChanged, "HUDDrag", function(arg)
			if flag and (arg.UserInputType == Enum.UserInputType.MouseMovement or arg.UserInputType == Enum.UserInputType.Touch) then
				local n = arg.Position - v13
				local v15, v16 = fn13(v14.X.Offset + n.X, v14.Y.Offset + n.Y)
				frame.Position = UDim2.new(0, v15, 0, v16)
			end
		end)

		fn7(UserInputService.InputEnded, "HUDDrag", function(arg)
			if arg.UserInputType == Enum.UserInputType.MouseButton1 or arg.UserInputType == Enum.UserInputType.Touch then
				flag = false
			end
		end)

		local currentCamera = workspace.CurrentCamera

		if currentCamera then
			fn7(currentCamera:GetPropertyChangedSignal("ViewportSize"), "HUDClamp", function()
				local v15, v16 = fn13(frame.Position.X.Offset, frame.Position.Y.Offset)
				frame.Position = UDim2.new(0, v15, 0, v16)
			end)
		end

		local flag2 = false

		fn7(imageButton.MouseButton1Click, "HUDCollapse", function()
			flag2 = not flag2
			frame2.Visible = not flag2 and v12 == nil
			scrollingFrame.Visible = not flag2 and v12 ~= nil
			viewProgress.Visible = not flag2
			viewResources.Visible = not flag2

			if flag2 then
				imageButton.Image = image2
				frame.Size = UDim2.new(0, 300, 0, 30)
			else
				imageButton.Image = image
				frame.Size = UDim2.new(0, 300, 0, 226)
			end

			local v15, v16 = fn13(frame.Position.X.Offset, frame.Position.Y.Offset)
			frame.Position = UDim2.new(0, v15, 0, v16)
		end)

		local function fn15(arg)
			local n = math.floor(arg)
			return string.format("%02d:%02d:%02d", math.floor(n / 3600), math.floor(n / 60) % 60, n % 60)
		end

		fn5("KaitunHUD", function()
			while screenGui.Parent do
				local started = skullHubGPOKaitun.started
				v7.Text = "Uptime " .. fn15(os.clock() - started)
				v8.Text = tostring(skullHubGPOKaitun.status or "Starting...")
				v9.Text = tostring(skullHubGPOKaitun.where or "Location unknown")
				v10.Text = tostring(skullHubGPOKaitun.detail or "")
				local str = ""

				if skullHubGPOKaitun.psCode then
					str = "" .. "  PS:" .. skullHubGPOKaitun.psCode
				end

				if skullHubGPOKaitun.webhook ~= "" then
					str ..= "  (webhook on)"
				end

				local str2 = tostring(skullHubGPOKaitun.mode)

				if skullHubGPOKaitun.full then
					str2 = "Full Progression"
				end

				v11.Text = ("%s / %s / %s %s%s"):format(str2, tostring(skullHubGPOKaitun.method), tostring(skullHubGPOKaitun.move), tostring(skullHubGPOKaitun.tween), str)

				for i = 1, #tbl4 do
					local v15 = skullHubGPOKaitun.log[#skullHubGPOKaitun.log - i + 1]

					if v15 then
						tbl4[i].Text = "- " .. v15
					else
						tbl4[i].Text = ""
					end
				end

				if scrollingFrame.Visible then
					local progRows

					if v12 == "prog" then
						progRows = skullHubGPOKaitun.progRows
					else
						progRows = skullHubGPOKaitun.resRows
					end

					if type(progRows) ~= "table" then
						progRows = {}
					end

					for i, v15 in ipairs(tbl5) do
						local v16 = progRows[i]
						v15.row.Visible = v16 ~= nil

						if v16 then
							v15.name.Text = tostring(v16.name)
							v15.value.Text = tostring(v16.note)

							if v16.state == "done" then
								v15.value.TextColor3 = Color3.fromRGB(120, 220, 140)
							elseif v16.state == "part" then
								v15.value.TextColor3 = Color3.fromRGB(240, 200, 120)
							elseif v16.state == "todo" then
								v15.value.TextColor3 = Color3.fromRGB(235, 120, 120)
							else
								v15.value.TextColor3 = Color3.fromRGB(150, 150, 160)
							end
						end
					end

					scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, math.max(0, #progRows * 15))
				end

				task.wait(0.5)
			end
		end)
	end
end

fn11()

if getgenv().SkullHubGPOKaitun and game.PlaceId == 1730877806 then
	getgenv().SkullHubGPOKaitun.where = "Main menu"
	getgenv().SkullHubGPOKaitun.buildHUD()
	getgenv().SkullHubGPOKaitun.armRejoin()

	fn5("KaitunJoin", function()
		local skullHubGPOKaitun = getgenv().SkullHubGPOKaitun
		local events = v6:WaitForChild("Events", 30)
		local reserved = events and events:FindFirstChild("reserved")
		local playgame = events and events:FindFirstChild("playgame")

		if not playgame then
			skullHubGPOKaitun.status = "FAILED - Events.playgame missing"
			skullHubGPOKaitun.note("Events.playgame not found - cannot leave the menu.")
			return
		end

		skullHubGPOKaitun.queueSelf()
		local ok, result = pcall(skullHubGPOKaitun.randomOutfit)

		if not ok then
			skullHubGPOKaitun.note("Auto Random Outfit failed: " .. fn2(result))
		end

		local v7 = skullHubGPOKaitun.ps[localPlayer.Name:lower()] or skullHubGPOKaitun.ps[localPlayer.DisplayName:lower()]

		if v7 then
			skullHubGPOKaitun.note(("Private server for %s: %s"):format(localPlayer.Name, v7))
		else
			skullHubGPOKaitun.note(("No private server row for %s - joining a public server."):format(localPlayer.Name))
		end

		local tbl2 = {
			Regular = true,
			["Trade Hub"] = "tradeHub",
			["Fish Hub"] = "fishHub",
			["Universe Hub"] = "universeHub",
		}

		local function fn12(arg)
			local tbl3 = {}

			if arg:IsA("TextLabel") or arg:IsA("TextButton") then
				tbl3[#tbl3 + 1] = tostring(arg.Text)
			end

			for _, descendant in ipairs(arg:GetDescendants()) do
				if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
					tbl3[#tbl3 + 1] = tostring(descendant.Text)
				end
			end

			return table.concat(tbl3, "\n"):lower()
		end

		local function fn13(arg)
			local v8 = fn12(arg)
			if v8:find("sea to go", 1, true) or v8:find("which sea", 1, true) or v8:find("first sea", 1, true) and v8:find("second sea", 1, true) then
				return "sea"
			end
			local frame = arg:FindFirstChild("Frame")
			if not (frame and frame:FindFirstChild("RemoteEvent")) then
				return nil
			end

			if arg.Name == "chooseType" or v8:find("private server", 1, true) then
				return "hub"
			end
			return nil
		end

		local function fn14(arg, arg2)
			local str = arg2:lower()

			for _, descendant in ipairs(arg:GetDescendants()) do
				if descendant:IsA("ImageButton") or descendant:IsA("TextButton") then
					local name = descendant.Name
					if (fn12(descendant) .. "\n" .. name:lower()):find(str, 1, true) then
						return descendant
					end
				end
			end

			return nil
		end

		local function fn15(arg, arg2)
			if not tbl.firesignal then
				return false, "this executor has no firesignal - answer the sea prompt by hand"
			end

			if tbl.getconnections then
				local flag = false

				for _, v8 in ipairs({ "MouseButton1Click", "Activated" }) do
					local ok2, result2 = pcall(getconnections, arg2[v8])

					if ok2 and type(result2) == "table" and #result2 > 0 then
						pcall(firesignal, arg2[v8])
						flag = true
					end
				end

				if flag then
					return true
				end
				return false, "that button has no handler connected"
			end

			pcall(firesignal, arg2.MouseButton1Click)
			task.wait(1)

			if arg.Parent then
				pcall(firesignal, arg2.Activated)
			end

			return true
		end

		local tbl3 = {}
		local tbl4 = {}

		local function fn16()
			local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
			if not playerGui then
				return false
			end

			for k in pairs(tbl3) do
				if not k.Parent then
					tbl3[k] = nil
				end
			end

			for k in pairs(tbl4) do
				if not k.Parent then
					tbl4[k] = nil
				end
			end

			local flag = false

			for _, child in ipairs(playerGui:GetChildren()) do
				local isScreenGui = child:IsA("ScreenGui") and fn13(child) or nil

				if isScreenGui then
					flag = true

					if not tbl3[child] then
						if isScreenGui == "hub" then
							local frame = child:FindFirstChild("Frame")
							frame = frame and frame:FindFirstChild("RemoteEvent")
							local regular = tbl2.Regular

							if frame and regular ~= nil then
								tbl3[child] = true

								pcall(function()
									frame:FireServer(regular)
								end)

								skullHubGPOKaitun.note("Answered the server-type prompt with \"Regular\".")
							end
						else
							local first = fn14(child, "First")

							if not first then
								if not tbl4[child] then
									tbl4[child] = true
									skullHubGPOKaitun.note("The sea prompt is open but no First/Second button was found - answer it by hand.")
								end
							else
								local v8, v9 = fn15(child, first)

								if v8 then
									tbl3[child] = true
									skullHubGPOKaitun.note(("Answered the sea prompt with %s Sea."):format("First"))
								elseif not tbl4[child] then
									tbl4[child] = true
									skullHubGPOKaitun.note("Could not press the sea button: " .. tostring(v9))
								end
							end
						end
					end
				end
			end

			return flag
		end

		if v7 and reserved then
			skullHubGPOKaitun.status = "Reserving private server"
			local flag = false
			local v8 = nil

			fn5("KaitunReserve", function()
				local ok2, result2 = pcall(function()
					return reserved:InvokeServer(v7)
				end)

				flag = true

				if ok2 then
					v8 = result2
				end
			end)

			local n = os.clock() + 20
			local flag2

			while true do
				flag2 = false

				if os.clock() < n then
					if fn16() then
						flag2 = true
						break
					elseif not flag then
						task.wait(0.25)
						continue
					end

					break
				else
					break
				end
			end

			if flag2 then
				skullHubGPOKaitun.status = "Joining private server"
				skullHubGPOKaitun.note("Code accepted - answered \"Regular\", the server is teleporting us.")
				local n2 = os.clock() + 45

				while os.clock() < n2 do
					fn16()
					task.wait(1)
				end

				skullHubGPOKaitun.note("Still in the menu 45s after answering - falling back to a public server.")
			else
				skullHubGPOKaitun.note("Private server REFUSED (\"" .. tostring(v8) .. "\") - joining a public regular server instead.")
			end
		end

		for i = 1, 5 do
			skullHubGPOKaitun.status = ("Joining public regular server (try %d/5)"):format(i)

			pcall(function()
				playgame:FireServer("Main Game")
			end)

			local n = os.clock() + 30

			while os.clock() < n do
				fn16()
				task.wait(0.5)
			end

			skullHubGPOKaitun.note("Still in the menu after 30s - retrying.")
		end

		skullHubGPOKaitun.status = "FAILED - could not leave the menu"
		skullHubGPOKaitun.note("Gave up after 5 join attempts.")
	end)

	return
end

local tbl2

tbl2 = {
	stage = "idle",
	mainHooks = 0,
	actorHooks = 0,
	found = {},
	swapped = 0,
	heartbeat = nil,
	protected = false,
	failWhy = nil,
	maxSpeedHooked = false,
	inMenu = game.PlaceId == 1730877806,
	why = function()
		if tbl2.protected then
			return nil
		end
		return ("Anti-cheat protection is NOT installed (%s). Farm, movement and combat are blocked - with the anti-cheat live, one error is a ban. Rejoin, or use an executor that supports run_on_actor."):format(tostring(tbl2.failWhy or "the bypass did not finish"))
	end,
}

do
	local function fn12()
		if not tbl.getactors then
			return nil
		end
		local ok, result = pcall(getactors)
		if not ok or type(result) ~= "table" then
			return nil
		end

		for _, v7 in ipairs(result) do
			if v7.Name == "paul greyrat" then
				return v7
			end
		end

		return nil
	end

	local function fn13(arg)
		if not (tbl.getgc and tbl.islclosure) then
			return nil
		end

		for _, v7 in ipairs(getgc(true)) do
			if type(v7) == "function" then
				local ok, result = pcall(debug.getinfo, v7, "nS")
				local flag

				if not ok or not result then
					flag = false
				else
					local flag2 = arg.Name and result.name ~= arg.Name
					flag = true

					if flag2 then
						flag = false
					end
				end

				local flag2

				if flag and arg.Constants and #arg.Constants > 0 then
					local ok2, result2 = pcall(debug.getconstants, v7)

					if not ok2 or type(result2) ~= "table" then
						flag2 = false
					else
						for _, constant in ipairs(arg.Constants) do
							local flag3 = false

							for _, v8 in ipairs(result2) do
								if fn2(v8):find(constant, 1, true) then
									flag3 = true
									break
								end
							end

							if not flag3 then
								flag = false
								break
							end
						end

						flag2 = flag
					end
				else
					flag2 = flag
				end

				if flag2 then
					return v7
				end
			end
		end

		return nil
	end

	local function fn14(arg)
		if tbl.filtergc then
			local ok, result = pcall(filtergc, "function", arg, true)
			if ok and type(result) == "function" then
				return result
			end
			return nil
		end

		return fn13(arg)
	end

	local tbl3 = {
		{
			key = "core",
			filter = {
				Constants = {
					"Core",
					"Remote",
					"Functions",
					"Anti",
					"Send",
					"Get",
					"Detected",
					"Disconnect",
					"Kill",
				},
			},
		},
		{ key = "tamper", filter = { Constants = { "abs", "crash", "Tamper Protection 0xE28D" } } },
		{ key = "readonly", filter = { Constants = { "Read-only" }, Name = "__newindex" } },
		{
			key = "unenc",
			filter = {
				Constants = {
					"warn",
					"Unencrypted remote commands are deprecated; moving",
					"to Remote.Commands. Replace `Remote.Unencrypted` with `Remote.Commands`!",
					"format",
					"AddLog",
				},
				Name = "__newindex",
			},
		},
		{ key = "kill", filter = { Constants = { "Running" }, Name = "kill" } },
	}

	local function fn15()
		return task.wait(9e9)
	end

	local function fn16()
		if not tbl.hookfunction then
			warn("[Skull Hub] hookfunction missing - bypass unavailable on this executor")
			return 0
		end
		local n = 0

		for _, v7 in ipairs(tbl3) do
			local v8 = fn14(v7.filter)

			if v8 then
				if pcall(hookfunction, v8, fn15) then
					n += 1
				end
			end
		end

		return n
	end

	local function fn17()
		if not (tbl.run_on_actor and tbl.create_comm_channel and tbl.get_comm_channel and tbl.hookfunction) then
			tbl2.failWhy = "this executor lacks run_on_actor / create_comm_channel / hookfunction"
			warn("[Skull Hub] actor bridge unavailable - AC actor left untouched")
			return nil
		end

		local v7 = fn12()

		if not v7 then
			tbl2.failWhy = "the anti-cheat actor 'paul greyrat' was not found"
			warn("[Skull Hub] AC actor 'paul greyrat' not found")
			return nil
		end

		local v8 = create_comm_channel()
		local flag = false
		local v9 = nil

		local actorReply = fn7(get_comm_channel(v8).Event, "ActorReply", function(arg)
			v9 = arg
			flag = true
		end)

		run_on_actor(v7, [[local resId = ...
local res = get_comm_channel(resId)

-- The responder must ALWAYS report back, including on error. A responder that dies before
-- firing leaves the main VM waiting on a reply that never comes.
local report = { hooks = 0, banRemote = false, upvaluesSwapped = 0, found = {}, err = nil }
local ok, err = pcall(function()
    local RS = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")

    -- 1. THE SEND FUNNEL — the whole wall, and now the FIRST thing done in this VM.
    --
    -- Every detection code goes through this one remote: the eleven honeypot metamethods
    -- (1.512 … 11.512), the error handler (1318 / 1319 / 691 / 692 / 915106), the character
    -- watchers (5161 / 79196 / 14015 / 10620), the environment probes (306 / -999 / 512 / 664 /
    -- 798 / 2.5 / 0.5 / 9532 / 23 / 24 / 150x / 15xxxx) and the self-check that fires 64386.
    -- ONE report is enough — measured live, a single 1318 reaching the server kicked instantly.
    --
    -- ⚠️ Two call forms, and hookfunction only covers one of them. Measured on this executor:
    --      local F = Remote.FireServer ; F(Remote, x)   -- direct call  -> INTERCEPTED
    --      Remote:FireServer(x)                          -- namecall     -> NOT intercepted
    -- The AC's own sends are all the direct form (it stores Crab_Strangler.FireServer at
    -- anti:46 and calls it as FireServer(Crab_Strangler, code)), so the hook does cover its
    -- current code. But a build that switches to colon syntax would walk straight through it,
    -- and the cost of that is a kick. So the remote reference itself is swapped out first,
    -- which is call-form independent.
    local BanRemote = RS:FindFirstChild("Crab_Strangler")
    if BanRemote then
        report.banRemote = true

        -- 1a. Point the anti-cheat at a dead remote. Every closure that sends a report holds
        -- Crab_Strangler as an upvalue — verified in the decompile for the honeypot
        -- metamethods, the ScriptContext.Error handler, CharAdded's Humanoid.Changed handler
        -- and the main watchdog loop. Swapping that upvalue for an unparented RemoteEvent means
        -- the send goes nowhere no matter how it is called, and — unlike disabling a connection
        -- or freezing a detector — it leaves every one of those code paths RUNNING, which is
        -- what keeps `u59.Connected` true and the RudeusGrey heartbeat ticking.
        local decoy = Instance.new("RemoteEvent")
        getgenv().__SkullHubDecoy = decoy   -- keep it alive; a collected decoy un-does the swap
        for _, v in next, getgc(true) do
            if type(v) == "function" and islclosure(v) then
                local okInfo, info = pcall(debug.getinfo, v, "u")
                local nups = (okInfo and info and info.nups) or 0
                for i = 1, nups do
                    local okUp, val = pcall(debug.getupvalue, v, i)
                    if okUp and val == BanRemote then
                        if pcall(debug.setupvalue, v, i, decoy) then
                            report.upvaluesSwapped += 1
                        end
                    end
                end
            end
        end

        -- 1b. Safety net for any sender that resolves the remote fresh instead of from an
        -- upvalue. Returns immediately rather than freezing: the previous version returned
        -- task.wait(9e9), which parks whichever game thread made the call, and the AC's own
        -- honeypot already stalls itself afterwards.
        --
        -- ⚠️ This hook MUST fall through for every other `self`. The AC's own watchdog calls
        -- `pcall(FireServer, workspace, <bait table>)` and requires it to raise
        -- "Expected ':' not '.' calling member function FireServer" — swallowing that call
        -- instead of letting it throw is reported as code 664.
        local probe = Instance.new("RemoteEvent")
        local oldFire
        oldFire = hookfunction(probe.FireServer, function(self, ...)
            if self == BanRemote or self == decoy then return end
            return oldFire(self, ...)
        end)
        probe:Destroy()
        report.hooks += 1
        report.fireHooked = true
    end

    -- ⭐⭐⭐ 1c. THE CRASH FUSE - the half of the punishment the decoy swap does NOT cover.
    --
    -- Every detection site in `anti` is two statements, not one:
    --
    --     FireServer(Crab_Strangler, <code>, <detail>)   -- tell the server
    --     if u18 == true then return end                 -- (false on GPO, so never taken)
    --     task_delay(12, function()                      -- AND crash this client locally
    --         while true do task_spawn(function() while true do end end) end
    --     end)
    --
    -- Redirecting `Crab_Strangler` silences the first line completely. It does nothing at all
    -- about the second, which is a purely local denial-of-service on ourselves: twelve seconds
    -- after ANY detection the actor VM starts spawning infinite loops inside infinite loops and
    -- the client dies. There is no kick dialog and no moderation prompt - from the outside it
    -- looks exactly like "Sorry, there was a problem reaching our servers".
    --
    -- ⚠️ This was missed on the first pass because the report funnel looked like the whole
    -- punishment path. It is not. A silenced report with a live fuse means the account is never
    -- reported but the session still dies on a timer, which is precisely the symptom that showed
    -- up three times in testing.
    --
    -- `task_delay` was captured into an upvalue at anti:16, but `local task_delay = task.delay`
    -- copies a reference to the SAME C closure, so hooking `task.delay` patches the captured
    -- copy too. And this hook is installed INSIDE the anti-cheat's own actor, where the AC is
    -- the only code running - nothing of the game's is affected by it.
    --
    -- The 12 is the AC's own constant and is what makes this targeted rather than a blanket
    -- disable: ordinary scheduling still works, only the fuse is dropped.
    do
        local realDelay = nil
        realDelay = hookfunction(task.delay, function(secs, fn, ...)
            if secs == 12 and type(fn) == "function" then
                -- Hand back a dormant thread so any caller that inspects the return still gets
                -- the right shape. The AC ignores it at every site, but cheap insurance.
                report.fuseBlocked = (report.fuseBlocked or 0) + 1
                return coroutine.create(function() end)
            end
            return realDelay(secs, fn, ...)
        end)
        report.hooks += 1
        report.delayHooked = true
    end

    -- 1d. …and the named function that wraps it, when it survives as a real closure rather than
    -- being inlined at each site. Its contract is read and unambiguous: it takes nothing,
    -- returns nothing, and its only effect is the crash loop above. A no-op is exactly correct.
    for _, v in next, getgc(true) do
        if type(v) == "function" and islclosure(v) then
            local okInfo, info = pcall(debug.getinfo, v, "n")
            if okInfo and info and info.name == "crashClient" then
                if pcall(hookfunction, v, function() end) then
                    report.crashClientHooked = true
                    report.hooks += 1
                end
                break
            end
        end
    end

    -- 2. The heartbeat, read once so the main VM can start watching it. The AC writes
    -- `workspace:SetAttribute("RudeusGrey", tick())` on every iteration of its watchdog loop
    -- and nothing on the client ever reads it back — it exists for the server. If it ever
    -- stops advancing, something we did stopped the AC's loop, and that is its own detection.
    report.heartbeat = workspace:GetAttribute("RudeusGrey")

    -- 3. Locate the detectors. One getgc walk, early exit once all are found.
    local WANTED = {
        detectDelta = true, CheckFunc = true, checkStack = true, CharAdded = true,
        GetMaxSpeed = true, isMethamethodValid = true, Rename = true,
        compareTables = true, RandomGen = true,
    }
    local targets, remaining = {}, 9
    for _, v in next, getgc(true) do
        if remaining == 0 then break end
        if type(v) == "function" and islclosure(v) then
            if not (isexecutorfunc and isexecutorfunc(v)) then
                local okInfo, info = pcall(debug.getinfo, v, "n")
                local name = okInfo and info and info.name
                if name and WANTED[name] and not targets[name] then
                    targets[name] = v
                    remaining -= 1
                end
            end
        end
    end
    for name in next, WANTED do
        report.found[name] = targets[name] ~= nil
    end

    -- 4. Neutralise ONLY the two that are both LIVE on 10225 and have a read return contract.
    local function neutralise(fn, replacement, hideStack)
        if not fn then return false end
        if hideStack and setstackhidden then pcall(setstackhidden, fn, true) end
        if pcall(hookfunction, fn, replacement) then
            report.hooks += 1
            return true
        end
        return false
    end

    -- GetMaxSpeed is the ceiling in `CharAdded`'s Humanoid.Changed handler:
    --   if Humanoid.WalkSpeed > GetMaxSpeed(char) then FireServer(Crab_Strangler, 79196) end
    -- with GetMaxSpeed = max(46, base * clamp(GetScale(), 1, 20) + (SpeedBypass or 0)).
    -- A large FINITE number retires that check. Finite on purpose: math.huge poisons the
    -- arithmetic on the other side of the comparison.
    --
    -- ⚠️ This governs the HUMANOID's WalkSpeed only. It has nothing to do with the server-side
    -- displacement check that produces the 267 travel kick — see the movement section.
    -- ⚠️ Record that the HOOK landed, not that the function was FOUND. `found.GetMaxSpeed` only
    -- says the closure exists; walking above 46 on a found-but-unhooked GetMaxSpeed is code 79196.
    report.maxSpeedHooked = neutralise(targets.GetMaxSpeed, function() return 1e6 end, false)

    -- checkStack walks the call stack looking for foreign frames; false is "nothing found".
    -- Live on 10225: its result feeds codes 1502 / 151206 / 159125.
    neutralise(targets.checkStack, function() return false end, true)

    -- ⭐ detectDelta is NO LONGER HOOKED, and that is a 10225 change, not an oversight.
    -- On this build it is declared at anti:767 and never called — dead code. The client-side
    -- punisher it used to be is gone; what remains is the server's own displacement check,
    -- which no client hook can reach. Hooking a dead function buys nothing and is one more
    -- modified closure for `isMethamethodValid`-style probes to trip over.
    --
    -- Deliberately NOT hooked, and each for a specific reason:
    --   CheckFunc          raises on purpose (workspace[{}] = true). A normal return IS the
    --                      tell, and the watchdog checks the exact message → code 2.5.
    --   compareTables      rawequal-based; never read whether true means match or tamper.
    --   isMethamethodValid never read what "valid" means to its caller.
    --   Rename             never read its contract.
    --   RandomGen          a generator whose return feeds live state, not a detector.
    --   CharAdded          freezing it kills the Gravity poll that keeps the loop alive.
    -- With the funnel silenced none of these can report anything anyway.
end)

if not ok then report.err = tostring(err) end
res:Fire(report)
]], v8)

		local n = 0

		while not flag and n < 15 do
			n += task.wait(0.1)
		end

		actorReply:Disconnect()

		if not flag then
			tbl2.failWhy = "the anti-cheat actor did not answer within 15s"
			warn("[Skull Hub] actor bypass timed out")
			return nil
		end

		if v9 and v9.err then
			warn("[Skull Hub] actor bypass error: " .. tostring(v9.err))
		end

		return v9
	end

	fn4("Bypass", function()
		tbl2.stage = "actor"
		local v7 = fn17()

		if v7 then
			tbl2.actorHooks = v7.hooks or 0
			tbl2.banRemote = v7.banRemote
			tbl2.found = v7.found or {}
			tbl2.swapped = v7.upvaluesSwapped or 0
			tbl2.heartbeat = v7.heartbeat
			tbl2.fuseHooked = v7.delayHooked == true
			tbl2.maxSpeedHooked = v7.maxSpeedHooked == true
			local v8 = tbl2
			local flag = v7.banRemote == true

			if flag then
				flag = (v7.upvaluesSwapped or 0) > 0
			end

			v8.protected = flag and v7.fireHooked == true and v7.delayHooked == true

			if not tbl2.protected then
				local v9 = tbl2
				local failWhy = v7.err and "actor bypass error: " .. tostring(v7.err) or not v7.banRemote and "the report remote Crab_Strangler was not found"

				if not failWhy then
					failWhy = (v7.upvaluesSwapped or 0) == 0 and "no anti-cheat sender could be redirected"
				end

				v9.failWhy = failWhy or "the FireServer / crash-fuse hook did not install"
			end

			print(("[Skull Hub] Bypass [1/2] - report funnel %s (%d senders redirected), crash fuse %s, %d actor hooks"):format(v7.banRemote and "silenced" or "NOT found", tbl2.swapped, tbl2.fuseHooked and "blocked" or "NOT blocked", tbl2.actorHooks))
		else
			warn("[Skull Hub] actor bypass failed - the AC's report funnel is still live")
		end

		tbl2.mainHooks = fn16() or 0
		print(("[Skull Hub] Bypass [2/2] - %d/%d main-VM anchors"):format(tbl2.mainHooks, #tbl3))
		tbl2.stage = tbl2.protected and "done" or "partial"

		if not tbl2.protected then
			warn("[Skull Hub] " .. tbl2.why())
		end
	end)
end

tbl2.heartbeatStale = false

fn5("HeartbeatWatch", function()
	while true do
		task.wait(2)
		local attribute = workspace:GetAttribute("RudeusGrey")
		tbl2.heartbeat = attribute

		if type(attribute) == "number" then
			local n = tick() - attribute
			local flag = n > 6

			if flag and not tbl2.heartbeatStale then
				tbl2.heartbeatStale = true
				warn(("[Skull Hub] ⚠️ the anti-cheat's RudeusGrey heartbeat is %.1fs stale - its loop has stopped. Rejoin; do not keep farming."):format(n))
				continue
			end

			if not flag then
				tbl2.heartbeatStale = false
			end
		end
	end
end)

local tbl3

tbl3 = {
	infM1 = false,
	infM1Hooked = false,
	resetM1 = nil,
	handler = nil,
	hookedNamecall = false,
	lastReset = 0,
	resetCount = 0,
}

local fn12, quest, tbl4, tbl5, fn13, n, tbl6, fn14

do
	local combatRegister = v6:FindFirstChild("Events") and v6.Events:FindFirstChild("CombatRegister")

	fn4("ResolveM1", function()
		local g = getrenv and getrenv() or nil
		g = g and g._G or nil
		if type(g) ~= "table" then
			return
		end

		if type(g.resetM1) == "function" then
			tbl3.resetM1 = g.resetM1
			local ok, handler = pcall(debug.getupvalue, g.resetM1, 1)

			if ok and type(handler) == "table" and handler.PunchCombo ~= nil then
				tbl3.handler = handler
			end
		end
	end)

	local function fn15()
		if tbl3.resetM1 then
			if pcall(tbl3.resetM1) then
				return true
			end
		end

		local handler = tbl3.handler

		if type(handler) == "table" then
			handler.PunchCombo = 0
			handler.PreCombo = 0
			handler.prehit = false
			handler.PunchCooldown = false
			handler.resetid = nil
			return true
		end

		return false
	end

	fn12 = function()
		if tbl3.hookedNamecall then
			return true
		end

		if not tbl.hookmetamethod then
			warn("[Skull Hub] hookmetamethod missing - infinite M1 unavailable on this executor")
			return false
		end

		local InfiniteM1 = fn4("InfiniteM1", function()
			local v7 = nil

			local function fn16(arg, ...)
				local v8 = table.pack(...)

				pcall(function(arg2)
					if not (tbl3.infM1 and combatRegister) then
						return
					end

					if checkcaller() or getnamecallmethod() ~= "InvokeServer" then
						return
					end

					if arg ~= combatRegister then
						return
					end
					local v9 = arg2
					if type(v9) ~= "table" or v9[1] ~= "swingsfx" or v9[3] ~= 5 then
						return
					end

					fn5("InfM1Reset", function()
						task.wait(0.5)

						if tbl3.infM1 and fn15() then
							tbl3.resetCount = tbl3.resetCount + 1
							tbl3.lastReset = os.clock()
						end
					end)
				end, ...)

				return v7(arg, table.unpack(v8, 1, v8.n))
			end

			v7 = hookmetamethod
			v7 = v7(game, "__namecall", newcclosure(fn16))
			tbl3.hookedNamecall = true
		end)

		tbl3.infM1Hooked = tbl3.hookedNamecall
		return InfiniteM1
	end

	quest = v6:FindFirstChild("Events") and v6.Events:FindFirstChild("Quest")

	tbl4 = {
		on = false,
		thread = nil,
		mode = "Level (auto)",
		status = "Idle",
		quest = nil,
		autoTurnIn = true,
		moveMode = "Glide",
		glideRoute = true,
		moveSpeed = 80,
		hoverY = 6,
		reach = 11,
		mobTimeout = 45,
		lag = nil,
		travel = true,
		travelRange = 20000,
		bad = setmetatable({}, { __mode = "k" }),
		mobSince = nil,
		retreatHP = 0.35,
		resumeHP = 0.75,
		retreating = false,
		throttle = 0.05,
		swingGap = 0.5,
		fastM1 = true,
		noKnockback = true,
		multiHit = true,
		skipBoss = true,
		avoidIslands = true,
		setSpawn = true,
		spawnTried = {},
		noRobo = { ["Kori Island"] = true },
		method = "Melee",
		gunName = "Rifle",
		gunStandoff = 55,
		gunMargin = 15,
		gunMaxRange = 350,
		gunBreach = 14,
		gunEye = 2.5,
		gunArmWait = 10,
		gunFastCycle = true,
		useGunPosts = true,
		gunPosts = {
			Bandit = Vector3.new(-483.05606, 9.074995, -3404.859),
			["Fishman Karate User"] = Vector3.new(7827.021, -2159.832, -17123.52),
		},
		levelTarget = 675,
		peliMob = "Bandit",
		fishMob = "Fishman Karate User",
		fishQuest = "Help becky",
		fishUseQuest = true,
		seaGate = true,
		firstSeaPlace = 3978370137,
		secondSeaPlace = 7465136166,
		juzoName = "Juzo the Diamondback",
		juzoIsland = "Turtleback Cave",
		juzoArena = Vector3.new(1774, 28, -10600),
		juzoSafe = Vector3.new(1807, 95, -10850),
		juzoSafeRadius = 60,
		juzoDodgeHeight = 20,
		juzoDashMarker = "CrystalDashFirstRigDestroy",
		juzoDashSecs = 1.5,
		juzoDangerAnims = {
			["110432084683680"] = true,
			["106700313119224"] = true,
			["135302592663206"] = true,
			["96218002160034"] = true,
		},
		juzoAirY = 120,
		juzoWait = 900,
		juzoDrops = { "Mythical Fruit Chest", "Turtleback Helmet", "Turtleback Armor", "Kira kira no Mi" },
		juzoUI = false,
		merchOn = false,
		merchWant = {},
		merchRange = 6000,
		merchPerVisit = 10,
		merchGap = 0.45,
		merchReserve = 0,
		geppoOn = false,
	}

	tbl5 = { nav = nil, boss = nil, spawnEvent = nil }

	fn13 = function()
		local character = localPlayer.Character
		if not character then
			return nil, nil
		end

		local function fn16(arg)
			if arg:FindFirstChild("SwordEquip") then
				return arg, "Sword"
			end

			if arg:GetAttribute("MeleeTool") then
				return arg, arg.Name
			end
			return nil, nil
		end

		for _, child in ipairs(character:GetChildren()) do
			if child:IsA("Tool") then
				local v7, v8 = fn16(child)
				if v7 then
					return v7, v8
				end
			end
		end

		for _, child in ipairs(localPlayer.Backpack:GetChildren()) do
			if child:IsA("Tool") then
				local v7, v8 = fn16(child)
				if v7 then
					child.Parent = character
					return child, v8
				end
			end
		end

		return nil, nil
	end

	local function fn16(arg, arg2)
		local primaryPart = arg and arg.PrimaryPart
		if not primaryPart then
			return CFrame.new()
		end
		local position = primaryPart.Position
		local n2 = 0
		local n3 = 0
		local n4 = 0

		for _, v7 in ipairs(arg2) do
			if typeof(v7) == "Instance" and v7:IsA("BasePart") and v7.Parent then
				n2 += v7.Position.X
				n3 += v7.Position.Z
				n4 += 1
			end
		end

		if n4 == 0 then
			return fn3(position, (workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -1000)).Position)
		end
		return fn3(position, Vector3.new(n2 / n4, position.Y, n3 / n4))
	end

	n = 9

	tbl6 = {
		combo = 1,
		lastTick = 0,
		nextHit = 0,
		lastDamage = 0,
		lastSwing = nil,
		fastAt = nil,
		fastOff = nil,
		land = {},
		endlags = 0,
		endlagSound = nil,
		endlagConn = nil,
		stunLife = 0.6,
		stunMargin = 0.05,
		wrapFloor = 0.53,
		wrapMiss = 0,
		stunClean = 0,
		stunGaps = 0,
		stunMob = nil,
		stunConns = {},
		stunLive = {},
		stunCount = 0,
		stunClearAt = nil,
		stunSince = 0,
		blockAt = nil,
	}

	tbl3.getHandler = function()
		if tbl3.handler then
			return tbl3.handler
		end

		local ok, handler = pcall(function()
			local g = getrenv and getrenv()._G
			if type(g) ~= "table" or type(g.resetM1) ~= "function" then
				return nil
			end
			local v7 = debug.getupvalue(g.resetM1, 1)
			if type(v7) == "table" and v7.PunchCombo ~= nil then
				return v7
			end
			return nil
		end)

		if ok and handler then
			tbl3.handler = handler
		end

		return tbl3.handler
	end

	tbl3.repair = function()
		local v7 = tbl3.getHandler()

		pcall(function()
			local g = getrenv and getrenv()._G
			if type(g) ~= "table" then
				return
			end
			local value = v7 and rawget(v7, "Callbacks")
			local value2 = value and rawget(value, "Climb")
			local value3 = type(value2) == "table" and rawget(value2, "ClimbingObject") or nil
			local flag = value3 and value3.Enabled == true
			local flag2 = false

			if flag then
				flag2 = true
			end

			if g.canuse == false and not flag2 then
				g.canuse = true
			end
		end)

		if v7 and v7.PunchCooldown == true then
			if not pcall(function()
				getrenv()._G.resetM1()
			end) then
				v7.PunchCooldown = false
				v7.resetid = nil
			end
		end
	end

	tbl3.animLen = {}
	tbl3.animRetry = {}
	tbl3.swordInfoRetry = 0
	tbl3.LAND_WINDOW = 24
	tbl3.LAND_MIN = 0.7

	tbl3.swordInfo = function()
		if tbl3._swordInfo then
			return tbl3._swordInfo
		end
		local swordInfoRetry = tbl3.swordInfoRetry
		if os.clock() < swordInfoRetry then
			return nil
		end
		tbl3.swordInfoRetry = os.clock() + 5

		pcall(function()
			local swordInfo = v6.Modules.SwordHandle.SwordInfo
			local n2 = type(getthreadidentity) == "function" and getthreadidentity() or 8

			if type(setthreadidentity) == "function" then
				pcall(setthreadidentity, 2)
			end

			local ok, swordInfo2 = pcall(require, swordInfo)

			if type(setthreadidentity) == "function" then
				pcall(setthreadidentity, n2)
			end

			if ok and type(swordInfo2) == "table" then
				tbl3._swordInfo = swordInfo2
			end
		end)

		return tbl3._swordInfo
	end

	tbl3.frameName = function(arg, arg2)
		if arg2 > 3 then
			return "Ground" .. arg .. arg2
		end
		return arg .. arg2
	end

	tbl3.animLength = function(arg, arg2)
		local animationId = arg2.AnimationId
		local v7 = tbl3.animLen[animationId]
		if type(v7) == "number" then
			return v7, false
		end

		if v7 == "pending" then
			return nil, true
		end
		local flag = v7 == "failed"

		if flag then
			flag = os.clock() < (tbl3.animRetry[animationId] or 0)
		end

		if flag then
			return nil, false
		end
		tbl3.animLen[animationId] = "pending"

		fn5("M1AnimLength", function()
			local ok, result = pcall(function()
				local humanoid = arg:FindFirstChildOfClass("Humanoid")
				humanoid = humanoid and humanoid:FindFirstChildOfClass("Animator")
				if not humanoid then
					return 0
				end
				local v8 = humanoid:LoadAnimation(arg2)
				local now = os.clock()

				while v8.Length == 0 and os.clock() - now < 3 do
					task.wait()
				end

				local length = v8.Length

				pcall(function()
					v8:Destroy()
				end)

				return length
			end)

			if ok and type(result) == "number" and result > 0 then
				tbl3.animLen[animationId] = result
			else
				local animLen = tbl3.animLen
				local v8 = animationId
				local animRetry = tbl3.animRetry
				local v9 = animationId
				local n2 = os.clock() + 10
				animLen[v8] = "failed"
				animRetry[v9] = n2
			end
		end)

		return nil, true
	end

	tbl3.swingAnim = function(arg, arg2, arg3)
		local tool = arg:FindFirstChildWhichIsA("Tool")
		if not tool or arg:GetAttribute("customM1") ~= nil then
			return nil
		end
		local v7 = tbl3.swordInfo()
		local combatAnimations = v6:FindFirstChild("CombatAnimations")
		if not (v7 and combatAnimations) then
			return nil
		end
		local stats = v6:FindFirstChild("Stats" .. localPlayer.Name)
		stats = stats and stats:FindFirstChild("Stats")
		local fightingStyle = stats and stats:FindFirstChild("FightingStyle")
		stats = stats and stats:FindFirstChild("DF")
		local g = getrenv and getrenv()._G

		if type(g) == "table" and type(g.isFruitSupressed) == "function" and stats then
			local ok, result = pcall(g.isFruitSupressed, localPlayer)
			if ok and result and tool.Name == stats.Value then
				return nil
			end
		end

		fightingStyle = fightingStyle and fightingStyle.Value or ""
		local v8

		if fightingStyle ~= "" and combatAnimations:FindFirstChild(fightingStyle) and tool:GetAttribute("MeleeTool") ~= nil and tool:GetAttribute("customM1") == nil then
			v8 = localPlayer.Backpack:FindFirstChild(fightingStyle) or tool
		else
			v8 = tool
		end

		local weaponOverride = v8:FindFirstChild("weaponOverride")
		weaponOverride = weaponOverride and weaponOverride.Value or nil
		local offhandSlashes, str

		if v7[v8.Name] or weaponOverride then
			local swords = v6.Modules.SwordHandle:FindFirstChild("Swords")
			local v9

			if swords then
				v9 = swords:FindFirstChild(v8.Name) or weaponOverride and swords:FindFirstChild(weaponOverride)
			else
				v9 = swords
			end

			if not v9 then
				return nil
			end

			if v8:GetAttribute("Offhand") == true and v7[v8.Name] and v7[v8.Name].hasOffhand == true then
				offhandSlashes = v9:FindFirstChild("OffhandSlashes")
			else
				offhandSlashes = v9:FindFirstChild("Slashes")
			end

			offhandSlashes = offhandSlashes and offhandSlashes:FindFirstChild(tbl3.frameName("Slash", arg2))
			str = "Sword"
		else
			if v8.Name == "BlackLeg" then
				offhandSlashes = arg:FindFirstChild("Diable") and combatAnimations:FindFirstChild("Diable") or combatAnimations:FindFirstChild("BlackLeg")
				str = "BlackLeg"
			elseif combatAnimations:FindFirstChild(v8.Name) then
				offhandSlashes = combatAnimations:FindFirstChild(v8.Name)
				str = v8.Name
			else
				offhandSlashes = combatAnimations:FindFirstChild("Melee")
				str = "Melee"
			end

			offhandSlashes = offhandSlashes and offhandSlashes:FindFirstChild(tbl3.frameName("Punch", arg2))
		end

		if not (offhandSlashes and offhandSlashes:IsA("Animation")) then
			return nil
		end
		local v9 = v7[tool.Name]
		local animationWeight = v9 and v9.AnimationWeight or 1.5
		local customM1AnimSpeed

		if v9 and v9.customM1AnimSpeed then
			customM1AnimSpeed = v9.customM1AnimSpeed
		else
			local v10, v11 = tbl3.animLength(arg, offhandSlashes)
			if v11 then
				return "wait"
			end

			if v10 and arg3 and arg3 > 0 then
				customM1AnimSpeed = v10 / arg3
			elseif arg:FindFirstChild("VenomDemonModel") then
				customM1AnimSpeed = 1
			else
				customM1AnimSpeed = v9 and v9.animspeed or 1.75
			end
		end

		return offhandSlashes, str, customM1AnimSpeed, animationWeight
	end

	tbl3.dropFast = function(fastOff)
		if tbl6.fastOff then
			return
		end
		tbl6.fastOff = fastOff
		tbl6.combo = 1
		tbl6.nextHit = math.max(tbl6.nextHit, os.clock() + 1.5)
		warn("[Skull Hub] Fast M1 off for this session: " .. tostring(fastOff))

		if tbl5.notify then
			pcall(tbl5.notify, "Skull Hub", "Fast M1 turned itself off: " .. tostring(fastOff) .. ". Swinging at the normal game rhythm. Toggle Fast M1 to try again.", 10)
		end
	end

	tbl3.onServerEndlag = function()
		local now = os.clock()
		tbl6.endlags = (tbl6.endlags or 0) + 1
		tbl6.combo = 1
		tbl6.nextHit = math.max(tbl6.nextHit, now + 1.5 + 0.016666666666666666)
		if tbl6.blockAt and now - tbl6.blockAt < 2 then
			return
		end

		if tbl6.fastAt and now - tbl6.fastAt < 3 then
			tbl3.dropFast("the server pushed an M1 lockout")
		end
	end

	tbl3.anyBlocking = function(arg)
		for _, v7 in ipairs(arg) do
			local parent = v7.Parent
			if parent and parent:FindFirstChild("Blocking") then
				tbl6.blockAt = os.clock()
				return true
			end
		end

		return false
	end

	tbl3.STUN_MARGIN_MIN = 0.05
	tbl3.STUN_MARGIN_MAX = 0.07

	tbl3.unwatchStun = function()
		for _, stunConn in ipairs(tbl6.stunConns) do
			pcall(function()
				stunConn:Disconnect()
			end)
		end

		local v7 = tbl6
		local v8 = tbl6
		tbl6.stunConns = {}
		v7.stunLive = {}
		v8.stunCount = 0
		local v9 = tbl6
		tbl6.stunMob = nil
		v9.stunClearAt = nil
	end

	tbl3.isStunObj = function(arg)
		return arg:IsA("ObjectValue") and arg:GetAttribute("isStun") ~= nil
	end

	tbl3.watchStun = function(stunMob)
		if stunMob == tbl6.stunMob then
			return
		end
		tbl3.unwatchStun()
		if typeof(stunMob) ~= "Instance" or not stunMob:IsA("Model") then
			return
		end
		local v7 = tbl6
		local v8 = tbl6
		local now = os.clock()
		v7.stunMob = stunMob
		v8.stunSince = now
		tbl6.stunLives = tbl6.stunLives or {}

		for _, child in ipairs(stunMob:GetChildren()) do
			if tbl3.isStunObj(child) then
				tbl6.stunLive[child] = os.clock()
				tbl6.stunCount = tbl6.stunCount + 1
			end
		end

		tbl6.stunConns[#tbl6.stunConns + 1] = fn7(stunMob.ChildAdded, "M1StunAdd", function(arg)
			if tbl6.stunMob ~= stunMob then
				return
			end

			if arg.Name == "Blocking" then
				tbl6.blockAt = os.clock()
				return
			end

			if not tbl3.isStunObj(arg) then
				return
			end
			local now2 = os.clock()

			if tbl6.stunCount == 0 then
				if tbl6.stunClearAt and tbl6.stunClearAt >= tbl6.stunSince and tbl6.prevSwing and tbl6.lastSwing and tbl6.plannedStep and tbl6.lastSwing - tbl6.prevSwing <= tbl6.plannedStep + 0.05 and tbl6.fastAt and now2 - tbl6.fastAt < 1 and tbl6.stunClearAt > tbl6.prevSwing then
					tbl6.stunGaps = tbl6.stunGaps + 1
					tbl6.stunClean = 0
					tbl6.stunMargin = math.min(tbl6.stunMargin + 0.01, tbl3.STUN_MARGIN_MAX)
				end
			else
				tbl6.stunClean = tbl6.stunClean + 1

				if tbl6.stunClean >= 20 then
					tbl6.stunClean = 0
					tbl6.stunMargin = math.max(tbl6.stunMargin - 0.005, tbl3.STUN_MARGIN_MIN)
				end
			end

			tbl6.stunLive[arg] = now2
			tbl6.stunCount = tbl6.stunCount + 1
		end)

		tbl6.stunConns[#tbl6.stunConns + 1] = fn7(stunMob.ChildRemoved, "M1StunRemove", function(arg)
			if tbl6.stunMob ~= stunMob then
				return
			end
			local v9 = tbl6.stunLive[arg]
			if not v9 then
				return
			end
			local now2 = os.clock()
			tbl6.stunLive[arg] = nil
			tbl6.stunCount = math.max(tbl6.stunCount - 1, 0)

			if tbl6.stunCount == 0 then
				tbl6.stunClearAt = now2
			end

			local n2 = now2 - v9

			if n2 >= 0.2 and n2 <= 1.5 then
				local stunLives = tbl6.stunLives
				stunLives[#stunLives + 1] = n2

				if #stunLives > 15 then
					table.remove(stunLives, 1)
				end

				if #stunLives >= 5 then
					local v10 = table.clone(stunLives)
					table.sort(v10)
					tbl6.stunLife = v10[math.floor(#v10 / 2) + 1]
				end
			end
		end)
	end

	tbl3.watchEndlag = function()
		local backpack = localPlayer:FindFirstChild("Backpack")
		backpack = backpack and backpack:FindFirstChild("InputCallbacks")
		backpack = backpack and backpack:FindFirstChild("Attack")
		backpack = backpack and backpack:FindFirstChild("M1EndLag")
		if not (backpack and backpack:IsA("Sound")) or backpack == tbl6.endlagSound then
			return
		end

		if tbl6.endlagConn then
			pcall(function()
				tbl6.endlagConn:Disconnect()
			end)
		end

		tbl6.endlagSound = backpack

		tbl6.endlagConn = fn7(backpack.Played, "M1EndlagWatch", function()
			tbl3.onServerEndlag()
		end)
	end

	tbl3.noteLanding = function(arg, arg2)
		if arg2 then
			if arg then
				tbl6.wrapMiss = 0
			else
				tbl6.wrapMiss = tbl6.wrapMiss + 1

				if tbl6.wrapMiss >= 2 then
					tbl6.wrapMiss = 0
					tbl6.wrapFloor = math.min(tbl6.wrapFloor + 0.01, 0.58)
				end
			end
		end

		local land = tbl6.land
		land[#land + 1] = arg

		if #land > tbl3.LAND_WINDOW then
			table.remove(land, 1)
		end

		if #land < tbl3.LAND_WINDOW then
			return
		end
		local n2 = 0

		for _, v7 in ipairs(land) do
			if v7 then
				n2 += 1
			end
		end

		if n2 / #land < tbl3.LAND_MIN then
			tbl3.dropFast(("only %d of the last %d fast hits did damage"):format(n2, #land))
		end
	end

	fn14 = function(arg)
		if not combatRegister then
			return false
		end
		local character = localPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if not character or not humanoid or humanoid.Health <= 0 then
			return false
		end
		local tbl7 = {}

		for _, v7 in ipairs(arg) do
			if typeof(v7) == "Instance" then
				if v7:IsA("Model") then
					local humanoidRootPart = v7:FindFirstChild("HumanoidRootPart") or v7:FindFirstChild("UpperTorso") or v7:FindFirstChild("Torso") or v7:FindFirstChild("Head")

					if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
						tbl7[#tbl7 + 1] = humanoidRootPart
					end
				elseif v7:IsA("BasePart") then
					tbl7[#tbl7 + 1] = v7
				end
			end
		end

		if #tbl7 == 0 then
			return false
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return false
		end
		local tbl8 = {}

		for _, v7 in ipairs(tbl7) do
			if (v7.Position - humanoidRootPart.Position).Magnitude <= n then
				tbl8[#tbl8 + 1] = v7
			end
		end

		if #tbl8 == 0 then
			tbl4.outOfEnvelope = (tbl4.outOfEnvelope or 0) + 1
			return false
		end
		local v7 = tbl8
		local now = os.clock()
		if now - tbl6.lastTick < tbl4.throttle then
			return false
		end

		if now < tbl6.nextHit then
			local n2 = tbl6.nextHit - now
			if n2 > 0.08 then
				return false
			end
			task.wait(n2)
			now = os.clock()
		end

		tbl3.repair()
		tbl3.watchEndlag()
		local v8, v9 = fn13()
		if not v9 then
			return false
		end
		local v10, v11, v12 = tbl5.hitBox()

		if type(v12) ~= "number" or v12 <= 0 then
			v12 = nil
		end

		if v12 and tbl6.lastSwing and now >= tbl6.lastSwing + 1 + v12 then
			tbl6.combo = 1
		end

		local n2 = character:GetAttribute("customM1") == "LeopardHybird" and 4 or 5
		local n3 = tbl4.noKnockback and n2 - 1 or n2
		local n4 = math.clamp(tbl6.combo, 1, n3)
		local v13 = nil
		local n5 = nil
		local n6 = nil
		local result = nil

		if v12 then
			local ok, result2, result3, result4
			ok, result2, result, result3, result4 = pcall(tbl3.swingAnim, character, n4, v12)
			local v14 = nil

			if ok then
				v13 = result2
				n5 = result3
				n6 = result4
			else
				result = v14
			end

			if v13 == "wait" then
				return false
			end
		end

		local flag = v13 ~= nil

		if flag then
			v9 = result
		end

		local flag2 = tbl4.fastM1 and not tbl6.fastOff and flag and n3 < n2
		local n7 = (v12 or tbl4.swingGap) + 0.016666666666666666 + math.random() * 0.01
		local flag3 = not flag
		local nextGap

		if flag3 then
			nextGap = math.max(n7, tbl4.swingGap)
		else
			nextGap = n7
		end

		if flag2 then
			nextGap = math.max((v12 or 0) + 0.016666666666666666, tbl6.wrapFloor, tbl6.stunLife - tbl6.stunMargin) + math.random() * 0.004
		end

		if typeof(arg[1]) == "Instance" and arg[1]:IsA("Model") then
			tbl3.watchStun(arg[1])
		end

		local combo

		if n3 <= n4 then
			if n2 <= n3 then
				nextGap = (v12 or tbl4.swingGap) + 0.15 + 1.5 + (character:FindFirstChild("VenomDemonModel") and 2 or 0) + 0.016666666666666666
				combo = 1
			else
				combo = 1

				if not flag2 then
					nextGap = 1 + (v12 or 0.5) + 0.016666666666666666 + 0.03
				end
			end
		else
			combo = n4 + 1
		end

		local v14 = tbl6
		local nextGap2 = tbl6.nextGap
		tbl6.prevSwing = tbl6.lastSwing
		v14.plannedStep = nextGap2
		tbl6.nextGap = nextGap
		local v15 = tbl6
		local v16 = tbl6
		local v17 = tbl6
		tbl6.combo = combo
		v15.nextHit = now + nextGap
		v16.lastSwing = now
		v17.lastTick = now

		if flag2 then
			tbl6.fastAt = now
		end

		local flag4 = flag2 and n4 == 1 and tbl6.prevSwing ~= nil and now - tbl6.prevSwing < 1
		local str = "Ground"

		if flag3 then
			local combatAnimations = v6:FindFirstChild("CombatAnimations")
			local v18 = combatAnimations and combatAnimations:FindFirstChild(v9)
			v13 = v18 and v18:FindFirstChild(tbl3.frameName("Punch", n4)) or nil
			n5 = 2
			n6 = 1.5
		end

		fn5("M1Swing", function()
			combatRegister:InvokeServer({ "swingsfx", v9, n4, "Ground", false, v13, n5, n6 })
		end)

		local n8 = 0.1

		if flag then
			n8 = 0

			pcall(function()
				local g = getrenv()._G
				local attribute = localPlayer:GetAttribute("Ping")
				n8 = math.max(v12 * (type(g.m1HitDelay) == "number" and g.m1HitDelay or 0) - (type(attribute) == "number" and attribute or 0), 0)
			end)
		end

		fn6(n8, "M1Damage", function()
			if flag then
				task.wait()
			end

			local character2 = localPlayer.Character
			local humanoid2 = character2 and character2:FindFirstChildOfClass("Humanoid")
			local primaryPart = character2 and character2.PrimaryPart
			if not character2 or not humanoid2 or humanoid2.Health <= 0 or not primaryPart then
				return
			end
			local tbl9 = {}

			for _, v18 in ipairs(v7) do
				if v18.Parent then
					tbl9[#tbl9 + 1] = v18
				end
			end

			if #tbl9 == 0 then
				return
			end

			local tbl10 = {
				"damage",
				tbl9,
				v9,
				{ n4, "Ground", v9 },
				true,
				aircombo = str,
				flag and primaryPart.CFrame or fn16(character2, tbl9),
			}

			local tbl11 = nil

			if flag2 and not tbl3.anyBlocking(tbl9) then
				tbl11 = {}

				for _, v18 in ipairs(tbl9) do
					local humanoid3 = v18.Parent and v18.Parent:FindFirstChildOfClass("Humanoid")

					if humanoid3 then
						tbl11[#tbl11 + 1] = { humanoid3, humanoid3.Health }
					end
				end
			end

			tbl6.lastDamage = os.clock()
			pcall(combatRegister.InvokeServer, combatRegister, tbl10)

			if tbl11 and #tbl11 > 0 then
				fn6(0.45, "M1Landed", function()
					local flag5 = false

					for _, v18 in ipairs(tbl11) do
						local v19 = v18[1]
						if v19.Parent and v19.Parent:FindFirstChild("Blocking") then
							tbl6.blockAt = os.clock()
							return
						end

						if not v19.Parent or v19.Health <= 0 or v19.Health < v18[2] then
							flag5 = true
							break
						end
					end

					tbl3.noteLanding(flag5, flag4)
				end)
			end
		end)

		return true
	end
end

local n2
n2 = 50
local n3
n3 = 3
local flag
flag = true

tbl4.setAltitudeCap = function(arg)
	n2 = math.clamp(tonumber(arg) or 50, 10, 55)
end

tbl4.setAvoidWalls = function(arg)
	flag = arg and true or false
end

local n4
n4 = 10
local n5
n5 = 600
local n6
n6 = 2.5
local n7
n7 = 2
local n8
n8 = 4.5
local tbl7

tbl7 = {
	continuous = 0,
	lastAt = 0,
	avgDt = 0.016666666666666666,
	maxFrame = function()
		return math.clamp(tbl7.avgDt * 1.5, 0.1, 0.35)
	end,
}

local fn15, fn16, fn17, tbl8, fn18, fn19, raycastParams, overlapParams, fn20, fn21
local tbl9, fn22, fn23, fn24, fn25, fn26, n9, fn27, fn28, tbl10
local fn29, drive, fn30

do
	local function fn31()
		local character = localPlayer.Character
		character = character and character:FindFirstChild("realPos")
		return character and character:IsA("CFrameValue") and character or nil
	end

	local tbl11 = { mode = "probing", seenChange = false, last = nil, movedFor = 0, since = os.clock() }

	fn15 = function()
		return tbl11.mode == "live"
	end

	fn16 = function()
		if not fn15() then
			return nil
		end
		local character = localPlayer.Character
		character = character and character:FindFirstChild("HumanoidRootPart")
		local v7 = fn31()
		if not (character and v7) then
			return nil
		end
		return (v7.Value.Position - character.Position).Magnitude
	end

	local function fn32()
	end

	fn17 = function()
	end

	tbl8 = {
		flagged = false,
		haltOnAC = false,
		acHits = 0,
		lastRP = nil,
		lastRoot = nil,
		frozenFor = 0,
		movedWhileFrozen = 0,
		stillFrozen = 0,
		onFlag = nil,
	}

	local tbl12 = { samples = {}, sustained = 0 }

	local function fn33()
		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

		if not humanoidRootPart then
			local v7 = tbl12
			local v8 = tbl12
			tbl12.samples = {}
			v7.sustained = 0
			v8.last = nil
			return
		end

		local now = os.clock()
		local position = humanoidRootPart.Position

		if tbl12.last then
			table.insert(tbl12.samples, { t = now, d = (position - tbl12.last).Magnitude })
		end

		tbl12.last = position

		while #tbl12.samples > 0 and now - tbl12.samples[1].t > 0.5 do
			table.remove(tbl12.samples, 1)
		end

		local n10 = 0

		for _, sample in ipairs(tbl12.samples) do
			n10 += sample.d
		end

		local n11 = #tbl12.samples > 0 and now - tbl12.samples[1].t or 0
		tbl12.sustained = n11 > 0.25 and n10 / n11 or 0
	end

	fn18 = function()
		return tbl12.sustained
	end

	local n10 = 40

	local function fn34(rp, arg, arg2)
		if tbl11.rp ~= rp then
			local v7 = tbl11
			tbl11.rp = rp
			v7.mode = "probing"
			local v8 = tbl11
			local v9 = tbl11
			tbl11.seenChange = false
			v8.last = nil
			v9.movedFor = 0
		end

		if tbl11.mode == "live" then
			return
		end
		local position = rp.Value.Position

		if tbl11.last and (position - tbl11.last).Magnitude > 0.01 then
			tbl11.seenChange = true
		end

		tbl11.last = position
		if tbl11.seenChange and position ~= Vector3.zero then
			tbl11.mode = "live"
			return
		end
		tbl11.movedFor = tbl11.movedFor + arg2

		if position == Vector3.zero and tbl11.movedFor > 5 then
			tbl11.mode = "dead"
		elseif n10 < tbl11.movedFor then
			tbl11.mode = "dead"
		end
	end

	local tbl13 = { base = nil, char = nil, gained = 0, at = 0 }

	local function fn35()
		local character = localPlayer.Character
		if not character then
			return
		end

		if tbl13.char ~= character then
			local v7 = tbl13
			local v8 = tbl13
			tbl13.char = character
			v7.base = nil
			v8.gained = 0
		end

		local attribute = character:GetAttribute("AntiCheatTriggers")
		if type(attribute) ~= "number" then
			return
		end

		if not tbl13.base then
			tbl13.base = attribute
			return
		end

		if attribute < tbl13.base then
			tbl13.base = attribute
			return
		end

		if attribute <= tbl13.base + tbl13.gained then
			return
		end
		local n11 = tbl13.base + tbl13.gained
		local n12 = attribute - tbl13.base + tbl13.gained
		local v7 = tbl13
		local v8 = tbl13
		local gained = attribute - tbl13.base
		local now = os.clock()
		v7.gained = gained
		v8.at = now
		tbl8.acHits = tbl8.acHits + n12
		local fastAt = tbl6.fastAt

		if fastAt then
			local fastAt2 = tbl6.fastAt
			fastAt = os.clock() - fastAt2 < 5
		end

		if fastAt then
			pcall(tbl3.dropFast, ("AntiCheatTriggers rose %d -> %d during fast M1"):format(n11, attribute))
		end

		if not tbl8.haltOnAC then
			if tbl5.notify then
				pcall(tbl5.notify, "Skull Hub", ("Anti-cheat flag %d -> %d (%d this session). Still farming - the halt is off in Movement > Safety."):format(n11, attribute, tbl8.acHits), 8)
			end

			warn(("[Skull Hub] AntiCheatTriggers %d -> %d; continuing (haltOnAC off)."):format(n11, attribute))
			return
		end

		if not tbl8.flagged then
			tbl8.flagged = true
			tbl4.status = ("STOPPED - the server's anti-cheat flagged us (AntiCheatTriggers %d -> %d). Do not re-run until you know why."):format(tbl13.base, attribute)

			if tbl5.notify then
				pcall(tbl5.notify, "Skull Hub", tbl4.status, 12)
			end

			if tbl8.onFlag then
				pcall(tbl8.onFlag)
			end
		end
	end

	fn19 = function(arg)
		fn32()
		fn33(arg)
		fn35()
		local character = localPlayer.Character
		character = character and character:FindFirstChild("HumanoidRootPart")
		local v7 = fn31()

		if not (character and v7) then
			local v8 = tbl8
			tbl8.lastRP = nil
			v8.lastRoot = nil
			return
		end

		local position = v7.Value.Position
		local position2 = character.Position
		fn34(v7, position2, tbl8.lastRoot and (position2 - tbl8.lastRoot).Magnitude or 0)

		if not fn15() then
			local v8 = tbl8
			tbl8.lastRP = position
			v8.lastRoot = position2
			local v9 = tbl8
			local v10 = tbl8
			tbl8.frozenFor = 0
			v9.movedWhileFrozen = 0
			v10.stillFrozen = 0
			return
		end

		if tbl8.lastRP and tbl8.lastRoot then
			local magnitude = (position2 - tbl8.lastRoot).Magnitude

			if (position - tbl8.lastRP).Magnitude < 0.05 and magnitude > 0.05 then
				tbl8.frozenFor = tbl8.frozenFor + arg
				tbl8.movedWhileFrozen = tbl8.movedWhileFrozen + magnitude
			else
				local v8 = tbl8
				tbl8.frozenFor = 0
				v8.movedWhileFrozen = 0
			end

			if tbl8.frozenFor > 2.5 and tbl8.movedWhileFrozen > 25 and not tbl8.flagged then
				tbl8.flagged = true

				if tbl8.onFlag then
					pcall(tbl8.onFlag)
				end
			end

			if (position - position2).Magnitude > 25 and fn18() < 1 then
				tbl8.stillFrozen = tbl8.stillFrozen + arg

				if tbl8.stillFrozen > 3 and not tbl8.flagged then
					tbl8.flagged = true

					if tbl8.onFlag then
						pcall(tbl8.onFlag)
					end
				end
			else
				tbl8.stillFrozen = 0
			end
		end

		local v8 = tbl8
		tbl8.lastRP = position
		v8.lastRoot = position2
	end

	raycastParams = RaycastParams.new()
	raycastParams.IgnoreWater = false
	overlapParams = OverlapParams.new()
	local flag2 = false
	local n11 = 0

	fn20 = function()
		if os.clock() - n11 < 1 then
			return
		end
		n11 = os.clock()
		local character = localPlayer.Character
		character = character and character:FindFirstChild("HumanoidRootPart")

		if character and character.Position.Y < -1200 then
			local islands = workspace:FindFirstChild("Islands")
			islands = islands and islands:FindFirstChild("Fishman Island")

			if islands then
				pcall(function()
					for _, child in ipairs(islands:GetChildren()) do
						if child:IsA("MeshPart") and child.MeshId == "rbxassetid://6223193062" and (child.CanCollide or child.CanQuery) then
							child.CanCollide = false
							child.CanQuery = false
						end
					end
				end)
			end
		end

		local filterDescendantsInstances = {}

		for _, v7 in ipairs({ "Islands", "Env", "Ships" }) do
			local v8 = workspace:FindFirstChild(v7)

			if v8 then
				filterDescendantsInstances[#filterDescendantsInstances + 1] = v8
			end
		end

		if #filterDescendantsInstances > 0 then
			flag2 = true
			raycastParams.FilterType = Enum.RaycastFilterType.Include
			raycastParams.FilterDescendantsInstances = filterDescendantsInstances
		elseif flag2 then
			raycastParams.FilterType = Enum.RaycastFilterType.Include
			raycastParams.FilterDescendantsInstances = {}
		else
			local filterDescendantsInstances2 = {}
			local character2 = localPlayer.Character

			if character2 then
				filterDescendantsInstances2[#filterDescendantsInstances2 + 1] = character2
			end

			for _, player in ipairs(v:GetPlayers()) do
				if player ~= localPlayer and player.Character then
					filterDescendantsInstances2[#filterDescendantsInstances2 + 1] = player.Character
				end
			end

			for _, v7 in ipairs({ "NPCs", "Effects", "Debris", "Thrown" }) do
				local v8 = workspace:FindFirstChild(v7)

				if v8 then
					filterDescendantsInstances2[#filterDescendantsInstances2 + 1] = v8
				end
			end

			raycastParams.FilterType = Enum.RaycastFilterType.Exclude
			raycastParams.FilterDescendantsInstances = filterDescendantsInstances2
		end

		pcall(function()
			raycastParams.RespectCanCollide = true
		end)

		overlapParams.FilterType = raycastParams.FilterType
		overlapParams.FilterDescendantsInstances = raycastParams.FilterDescendantsInstances

		pcall(function()
			overlapParams.RespectCanCollide = true
		end)

		pcall(function()
			overlapParams.RespectCanCollide = true
		end)
	end

	local tbl14 = { y = nil, at = 0 }

	local tbl15 = {
		[Enum.HumanoidStateType.Running] = true,
		[Enum.HumanoidStateType.RunningNoPhysics] = true,
		[Enum.HumanoidStateType.Landed] = true,
		[Enum.HumanoidStateType.Climbing] = true,
		[Enum.HumanoidStateType.Swimming] = true,
	}

	local tbl16 = {
		[Enum.HumanoidStateType.Running] = true,
		[Enum.HumanoidStateType.RunningNoPhysics] = true,
		[Enum.HumanoidStateType.Landed] = true,
	}

	local n12 = 1.5

	fn32 = function()
		local character = localPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		character = character and character:FindFirstChild("HumanoidRootPart")
		if not (humanoid and character) then
			return
		end

		local ok, result = pcall(function()
			return humanoid:GetState()
		end)

		if not (ok and tbl15[result]) then
			return
		end
		local y = character.Position.Y

		if tbl14.y ~= nil and y > tbl14.y then
			local lastAt = tbl7.lastAt
			if os.clock() - lastAt < n12 then
				return
			end

			if not tbl16[result] then
				return
			end
		end

		local v7 = tbl14
		local v8 = tbl14
		local now = os.clock()
		v7.y = y
		v8.at = now
	end

	fn21 = function(arg)
		fn20()
		local hit = workspace:Raycast(arg - Vector3.new(0, 1.5, 0), Vector3.new(0, -900, 0), raycastParams)
		if not hit then
			return nil
		end

		if arg.Y - 1 <= hit.Position.Y then
			return nil
		end
		return hit.Position.Y
	end

	local function fn36(arg)
		local v7 = fn21(arg)
		if not v7 then
			return 0
		end
		return arg.Y - v7
	end

	tbl9 = {
		y = nil,
		at = 0,
		pos = nil,
		seeded = false,
		note = function(y, pos)
			if type(y) ~= "number" or y ~= y then
				return
			end
			local v7 = tbl9
			local v8 = tbl9
			local v9 = tbl9
			local now = os.clock()
			v7.y = y
			v8.at = now
			v9.pos = pos
			tbl9.seeded = true
		end,
		ground = function(arg)
			local v7 = fn21(arg)
			if v7 then
				tbl9.note(v7, arg)
				return v7
			end

			if tbl9.usable(arg) then
				return tbl9.y
			end
			return nil
		end,
		ref = function(arg)
			local v7 = fn21(arg)
			if v7 then
				tbl9.note(v7, arg)
				return v7
			end

			if tbl9.usable(arg) then
				return tbl9.y
			end

			if tbl14.y then
				return tbl14.y
			end
			return nil
		end,
		reset = function()
			local v7 = tbl9
			local v8 = tbl9
			local v9 = tbl9
			tbl9.y = nil
			v7.at = 0
			v8.pos = nil
			v9.seeded = false
		end,
	}

	local function fn37(arg, arg2)
		fn20()
		if raycastParams.FilterType ~= Enum.RaycastFilterType.Include then
			return nil
		end
		local v7 = workspace
		local raycast = v7.Raycast
		local v8 = raycast(v7, arg + Vector3.new(0, 1, 0), Vector3.new(0, arg2 or n2, 0), raycastParams)
		return v8 and v8.Position.Y or nil
	end

	local n13 = 120

	fn22 = function()
		local ok, result = pcall(function()
			return getrenv()._G.SeaLevel
		end)

		if ok and type(result) == "number" then
			return result
		end
		local env2 = workspace:FindFirstChild("Env")
		env2 = env2 and env2:FindFirstChild("WaterStuff")
		env2 = env2 and env2:FindFirstChild("Falls")
		return env2 and env2.Position.Y or nil
	end

	local n14 = 150

	fn23 = function(arg, arg2)
		return arg2 ~= nil and arg < arg2 - n14
	end

	local n15 = 1
	local n16 = 12
	local n17 = 1.5
	local tbl17 = { fn = nil, tried = false, key = nil, at = 0, y = nil }

	fn24 = function(arg)
		local v7 = fn22()
		if not v7 then
			return nil
		end

		if not tbl17.tried then
			tbl17.tried = true

			pcall(function()
				local g = getrenv and getrenv()._G

				if type(g) == "table" and type(g.getWavePosition) == "function" then
					local getWavePosition = g.getWavePosition

					tbl17.fn = function(arg2)
						return getWavePosition(arg2)
					end
				end
			end)

			if not tbl17.fn then
				pcall(function()
					local oceanSimulator = v6:FindFirstChild("OceanSimulator")
					oceanSimulator = oceanSimulator and require(oceanSimulator) or nil

					if type(oceanSimulator) == "table" and type(oceanSimulator.GetWaveHeightAtPosition) == "function" then
						tbl17.fn = function(arg2)
							return oceanSimulator.GetWaveHeightAtPosition(arg2)
						end
					end
				end)
			end
		end

		if not tbl17.fn then
			return v7 + n17
		end
		local key = math.floor(arg.X / 16) * 4096 + math.floor(arg.Z / 16)
		local y = tbl17.key == key and tbl17.y

		if y then
			local at = tbl17.at
			y = os.clock() - at < 0.1
		end

		if y then
			return tbl17.y
		end
		local ok, result = pcall(tbl17.fn, Vector3.new(arg.X, 0, arg.Z))
		if not (ok and type(result) == "number" and result == result) then
			return v7 + n17
		end
		local y2 = math.max(result, v7)
		local v8 = tbl17
		local v9 = tbl17
		local v10 = tbl17
		local now = os.clock()
		v8.key = key
		v9.at = now
		v10.y = y2
		return y2
	end

	fn25 = function(arg, arg2)
		local v7 = fn22()
		local v8 = fn21(arg)

		if v7 and (not v8 or v8 < v7) and not fn23(arg.Y, v7) then
			local v9 = fn24(arg) or v7
			local n18 = v9 + n16
			local v10 = fn37(arg)
			local n19

			if v10 then
				n19 = math.max(n18, v10 + n3)
			else
				n19 = n18
			end

			local z = arg.Z
			return Vector3.new(arg.X, math.clamp(arg.Y, v9 + n15, n19), z)
		end

		local tbl18 = {}

		if arg2 then
			tbl18[#tbl18 + 1] = arg2 + n2
		end

		if tbl14.y then
			tbl18[#tbl18 + 1] = tbl14.y + n2
		end

		local flag3 = v8 and arg.Y - v8 <= n13
		local n18 = nil

		if flag3 then
			tbl18[#tbl18 + 1] = v8 + n2
			n18 = v8 + n3
		end

		local v9 = fn37(arg)

		if v9 then
			local n19 = v9 - n3

			if not n18 or n19 > n18 then
				tbl18[#tbl18 + 1] = n19
			end
		end

		local y = arg.Y

		for _, v10 in ipairs(tbl18) do
			y = math.min(y, v10)
		end

		local n19

		if n18 then
			n19 = math.max(y, n18)
		else
			n19 = y
		end

		return Vector3.new(arg.X, n19, arg.Z)
	end

	local vector = Vector3.new(4, 4, 4)
	local ok = nil

	fn26 = function(arg, arg2)
		fn20()
		if arg2.Magnitude < 0.05 then
			return nil
		end
		local n18 = arg + Vector3.new(0, 1, 0)

		if ok == nil then
			ok = pcall(function()
				return workspace:Blockcast(CFrame.new(n18), Vector3.new(4, 4, 4), Vector3.new(0, 0, 0.1), raycastParams)
			end)
		end

		if ok then
			local ok2, result = pcall(function()
				return workspace:Blockcast(CFrame.new(n18), Vector3.new(4, 4, 4), arg2, raycastParams)
			end)

			if ok2 then
				return result
			end
			ok = false
		end

		local unit = arg2.Unit
		local n19 = vector.X * 0.5
		local n20 = Vector3.new(-unit.Z, 0, unit.X) * n19
		local vector2 = Vector3.new(0, vector.Y * 0.5, 0)

		for _, v7 in ipairs({ Vector3.zero, n20, -n20, vector2, -vector2 }) do
			local hit = workspace:Raycast(n18 + v7, arg2, raycastParams)
			if hit then
				return hit
			end
		end

		return nil
	end

	n9 = 1

	fn27 = function(arg, arg2, arg3)
		if not flag then
			return arg2
		end
		local n18 = arg2 - arg
		if n18.Magnitude < 0.05 then
			return arg2
		end

		if not fn26(arg, n18) then
			return arg2
		end
		local vector2 = Vector3.new(n18.X, 0, n18.Z)
		local n19 = vector2.Magnitude > 0.1 and vector2.Unit * math.min(vector2.Magnitude, 60) or nil

		if n19 then
			for i = 4, n2, 4 do
				local v7 = fn25(Vector3.new(arg.X, arg.Y + i, arg.Z), arg3 or arg.Y)
				if v7.Y <= arg.Y + 0.5 then
					break
				end

				if n2 < fn36(v7) then
					break
				end

				if not fn26(v7, n19) then
					return v7
				end
			end
		end

		if vector2.Magnitude > 0.1 then
			local vector3 = Vector3.new(-vector2.Unit.Z, 0, vector2.Unit.X)

			for _, v7 in ipairs({ 16, 30, 48, 70 }) do
				for _, v8 in ipairs({ n9, -n9 }) do
					local v9 = fn25(arg + vector3 * v7 * v8, arg3 or arg.Y)

					if not fn26(arg, v9 - arg) then
						if not fn26(v9, arg2 - v9) then
							n9 = v8
							return v9
						end
					end
				end
			end
		end

		return nil
	end

	fn28 = function()
		return math.clamp(tbl4.moveSpeed, 16, 100)
	end

	local n18 = 65
	local n19 = 0.1
	tbl10 = { over = false, peak = 0, at = 0, where = "", ground = nil, floor = nil, hits = 0 }
	local n20 = 1200

	tbl9.usable = function(arg)
		if not (tbl9.seeded and tbl9.y and tbl9.pos) then
			return false
		end
		local v7 = fn22()
		if v7 and fn23(tbl9.y, v7) ~= fn23(arg.Y, v7) then
			return false
		end
		return Vector3.new(arg.X - tbl9.pos.X, 0, arg.Z - tbl9.pos.Z).Magnitude <= n20
	end

	fn29 = function(arg)
		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if not (humanoidRootPart and humanoid and humanoid.Health > 0) then
			tbl10.over = false
			return
		end
		local now = os.clock()
		local state = humanoid:GetState()
		local flag3 = (state == Enum.HumanoidStateType.Freefall or state == Enum.HumanoidStateType.Jumping) and math.abs(humanoidRootPart.AssemblyLinearVelocity.Y) > 10 and now - tbl7.lastAt > 0.3

		if humanoidRootPart:FindFirstChild("geppo") or character:GetAttribute("ServerClimb") ~= nil or humanoidRootPart.CollisionGroup == "noclip" or flag3 then
			tbl10.manualAt = now
		elseif tbl10.manualAt and (humanoid.FloorMaterial ~= Enum.Material.Air or tbl7.lastAt > tbl10.manualAt or now - tbl10.manualAt > 10) then
			tbl10.manualAt = nil
		end

		if tbl10.manualAt then
			tbl10.over = false
			return
		end

		if n19 <= now - tbl10.at then
			tbl10.at = now
			local position = humanoidRootPart.Position
			local v7 = fn22()
			local v8 = fn21(position)

			if v8 then
				tbl9.note(v8, position)
			end

			local y, floor

			if v7 and (not v8 or v8 < v7) and not fn23(position.Y, v7) then
				y = fn24(position) or v7
				floor = y + n15 + 1
			else
				y = v8 or tbl9.usable(position) and tbl9.y or nil
				floor = y and y + n3 or nil
			end

			local v9 = tbl10
			tbl10.ground = y
			v9.floor = floor

			if not y then
				tbl10.over = false
			else
				local peak = position.Y - y

				if n18 < peak then
					if not tbl10.over then
						local v10 = tbl10
						tbl10.over = true
						v10.peak = peak
						tbl10.hits = tbl10.hits + 1
						tbl10.where = tostring(tbl4.status or "?")

						if tbl5.notify then
							local where = tbl10.where
							local sub = where.sub
							pcall(tbl5.notify, "Skull Hub", ("Altitude backstop: %d studs up during \"%s\" - bringing it down."):format(math.floor(peak), sub(where, 1, 60)), 8)
						end
					end

					tbl10.peak = math.max(tbl10.peak, peak)
				elseif peak <= n2 then
					tbl10.over = false
				end
			end
		end

		if not (tbl10.over and tbl10.ground) then
			return
		end
		local floor = tbl10.floor or tbl10.ground + n3
		local position = humanoidRootPart.Position
		if position.Y <= floor then
			tbl10.over = false
			return
		end
		humanoidRootPart.CFrame = humanoidRootPart.CFrame - Vector3.new(0, math.min(fn28() * math.min(arg or 0.016666666666666666, tbl7.maxFrame()), position.Y - floor), 0)
		humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
		tbl7.lastAt = os.clock()
		tbl4.status = ("Too high (%d studs) - descending"):format(math.floor(position.Y - tbl10.ground))
	end

	local function fn38(arg)
		local n21 = arg or 2
		local n22 = os.clock() + n21
		local v7 = fn15()
		local character = localPlayer.Character
		character = character and character:FindFirstChild("HumanoidRootPart")
		if not character then
			return false
		end
		local position = character.Position
		local v8 = fn22()
		local v9 = fn21(position)

		if v8 and (not v9 or v9 < v8) and not fn23(position.Y, v8) then
			local v10 = fn24(position) or v8
			local z = position.Z
			position = Vector3.new(position.X, math.max(position.Y, v10 + n15 + 1), z)
		end

		local n23 = character.CFrame - character.CFrame.Position

		local settleHold = fn7(v2.Heartbeat, "SettleHold", function(arg2)
			local character2 = localPlayer.Character
			character2 = character2 and character2:FindFirstChild("HumanoidRootPart")
			if not character2 then
				return
			end
			local n24 = math.min(arg2 or 0.016666666666666666, tbl7.maxFrame()) * 60
			local n25 = character2.Position:Lerp(position, 1 - 0.75 ^ n24)

			if 3 * n24 < (n25 - character2.Position).Magnitude then
				n25 = character2.Position + (n25 - character2.Position).Unit * 3 * n24
			end

			character2.CFrame = CFrame.new(n25) * n23
			character2.AssemblyLinearVelocity = Vector3.zero
			character2.AssemblyAngularVelocity = Vector3.zero
		end)

		local flag3

		while true do
			flag3 = false

			if not (os.clock() < n22) then
				break
			elseif v7 then
				local v10 = fn16()

				if v10 and v10 <= n4 then
					flag3 = true
					break
				else
					task.wait(0.05)
				end
			else
				task.wait(0.05)
			end
		end

		settleHold:Disconnect()
		if flag3 then
			return true
		end

		if not v7 then
			return true
		end
		return (fn16() or 0) <= n4 * 3
	end

	drive = {
		tw = nil,
		autoRotate = nil,
		STEP = 4,
		CLEAR = n3 + 0.5,
		GRADE = 1.75,
		SETTLE_TOL = 1.5,
		GAP = 0.75,
		CLIMB_STEP = 2,
		CLIMB_MAX = 20,
		OVERHANG = 8,
		BOX = Vector3.new(3.5, 5, 2.5),
		service = game:GetService("TweenService"),
		carry = 0,
		carryBeat = -1,
		beat = 0,
		TURN = 12,
		stop = function()
			local tw = drive.tw
			drive.tw = nil
			drive.carry = 0

			if tw then
				pcall(function()
					tw:Cancel()
				end)
			end

			local character = localPlayer.Character
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

			if humanoidRootPart then
				humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
				humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
			end

			if drive.autoRotate ~= nil then
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")

				if humanoid then
					pcall(function()
						humanoid.AutoRotate = drive.autoRotate
					end)
				end

				drive.autoRotate = nil
			end
		end,
		cast = function(arg, arg2)
			if not flag then
				return nil
			end

			if arg2.Magnitude < 0.05 then
				return nil
			end
			fn20()
			local vector2 = Vector3.new(arg2.X, 0, arg2.Z)
			local cframe = vector2.Magnitude > 0.05 and CFrame.lookAt(arg, arg + vector2) or CFrame.new(arg)

			if ok ~= false then
				local ok2, result = pcall(function()
					return workspace:Blockcast(cframe, drive.BOX, arg2, raycastParams)
				end)

				if ok2 then
					return result
				end
			end

			return fn26(arg, arg2)
		end,
		hug = function(arg, arg2, arg3)
			fn20()
			local vector2 = Vector3.new(arg, arg3, arg2)
			local hit = workspace:Raycast(vector2, Vector3.new(0, -1000, 0), raycastParams)
			hit = hit and hit.Position.Y
			local v7 = fn22()
			if v7 and (not hit or hit < v7) and not fn23(arg3, v7) then
				local v8 = fn24(vector2) or v7
				return v8 + n15, v8
			end

			if hit then
				return hit + drive.CLEAR, hit
			end
			return nil, nil
		end,
		segment = function(arg, arg2, arg3, arg4, arg5)
			if not drive.beatConn then
				drive.beatConn = fn7(v2.Heartbeat, "GlideBeat", function()
					drive.beat = drive.beat + 1
				end)
			end

			local humanoid = arg.Parent and arg.Parent:FindFirstChildOfClass("Humanoid")

			if humanoid and drive.autoRotate == nil then
				drive.autoRotate = humanoid.AutoRotate
				humanoid.AutoRotate = false
			end

			local n21 = math.max(arg4, 1)
			local carry = drive.carryBeat == drive.beat and drive.carry or 0
			drive.carry = 0
			local magnitude = (arg2 - arg.Position).Magnitude
			if magnitude < 0.05 then
				v2.Heartbeat:Wait()
				return true
			end
			local v7 = fn3(arg2, arg3 or arg2)
			local n22 = v7 - v7.Position
			local n23 = os.clock() + magnitude / n21 * 2 + 1
			local magnitude2

			while true do
				if not arg.Parent or arg5() or os.clock() > n23 then
					arg.AssemblyLinearVelocity = Vector3.zero
					return false
				end
				local cFrame = arg.CFrame
				local n24 = arg2 - cFrame.Position
				magnitude2 = n24.Magnitude
				local n25 = math.min(carry, magnitude2)

				if n25 > 0 then
					local n26 = math.min(1, drive.TURN * n25 / n21)
					local n27 = cFrame - cFrame.Position
					arg.CFrame = CFrame.new(cFrame.Position + n24.Unit * n25) * n27:Lerp(n22, n26)
					tbl7.lastAt = os.clock()
				end

				arg.AssemblyLinearVelocity = Vector3.zero
				arg.AssemblyAngularVelocity = Vector3.zero
				if carry >= magnitude2 then
					break
				end
				local maxFrame = tbl7.maxFrame
				carry = n21 * math.min(v2.Heartbeat:Wait(), maxFrame())
			end

			local v8 = drive
			local beat = drive.beat
			drive.carry = carry - magnitude2
			v8.carryBeat = beat
			return true
		end,
		climb = function(arg, arg2, arg3, arg4, arg5)
			local n21 = os.clock() + math.max(arg3 - arg.Position.Y, 0) / math.max(arg4, 1) * 3 + 3
			local n22 = 0

			while os.clock() < n21 do
				if not arg.Parent then
					return "abort"
				end
				local position = arg.Position

				if not drive.cast(position, arg2 * (n22 + drive.GAP + 1.5)) then
					local n23 = n22 + drive.BOX.Z + drive.GAP * 2 + 1
					local n24 = drive.cast(position, arg2 * n23)

					if n24 then
						local n25 = drive.BOX.Z * 0.5
						local gap = drive.GAP
						n24 = (n24.Position - position):Dot(arg2) - n25 - gap
					end

					n23 = n24 or n23

					if n22 + drive.GAP + 1 <= n23 then
						if not drive.segment(arg, position + arg2 * n23, position + arg2 * (n23 + 1), arg4, arg5) then
							return "abort"
						end
						return "top"
					end
				end

				if arg3 - 0.05 <= position.Y then
					return "cap"
				end
				local vector2 = Vector3.new(0, math.min(drive.CLIMB_STEP, arg3 - position.Y), 0)

				if drive.cast(position, vector2) then
					local n23 = nil

					for i = 1, math.floor(drive.OVERHANG - n22) do
						local n24 = position - arg2 * i
						n23 = nil

						if not drive.cast(position, n24 - position) then
							if not drive.cast(n24, vector2) then
								n23 = n24 - arg2 * drive.GAP

								if n22 + i + drive.GAP <= drive.OVERHANG and not drive.cast(position, n23 - position) then
									n22 = n22 + i + drive.GAP
								else
									n22 += i
									n23 = n24
								end

								break
							else
								n23 = nil
								continue
							end
						end

						break
					end

					if not n23 then
						return "ceiling"
					end

					if not drive.segment(arg, n23, n23 + arg2, arg4, arg5) then
						return "abort"
					end
					continue
				end

				if not drive.segment(arg, position + vector2, position + arg2, arg4, arg5) then
					return "abort"
				end
			end

			return "timeout"
		end,
		ROUTE_MIN = 18,
		ROUTE_MAX = 900,
		ROUTE_REACH = 1.5,
		ROUTE_OFF = 12,
		ROUTE_DRIFT = 20,
		ROUTE_GAP = 1,
		ROUTE_TRIES = 4,
		ROUTE_PASS = 4,
		ROUTE_STALL = 25,
		NUDGE = { 2, 4, 6 },
		NET_STALL = 20,
		NET_STEP = 4,
		AGENT = { AgentRadius = 2.5, AgentHeight = 6, AgentCanJump = true, AgentMaxSlope = 45 },
	}

	drive.paths = fn(game:GetService("PathfindingService"))

	drive.wet = function(arg)
		local v7 = fn22()
		if not v7 or fn23(arg.Y, v7) then
			return false
		end
		local v8 = fn21(arg + Vector3.new(0, 4, 0))
		return not v8 or v8 < v7
	end

	drive.plan = function(arg, arg2)
		if drive.ROUTE_MAX < (arg2 - arg).Magnitude then
			return nil, false
		end

		if drive.wet(arg) or drive.wet(arg2) then
			return nil, false
		end

		local ok2, result = pcall(function()
			return drive.paths:CreatePath(drive.AGENT)
		end)

		if not (ok2 and result) then
			return nil, false
		end

		local flag3 = pcall(function()
			result:ComputeAsync(arg, arg2)
		end) and result.Status == Enum.PathStatus.Success

		local tbl18 = nil

		if flag3 then
			local ok3, result2 = pcall(function()
				return result:GetWaypoints()
			end)

			local flag4 = ok3 and type(result2) == "table" and #result2 >= 2
			tbl18 = nil

			if flag4 then
				tbl18 = {}

				for i = 2, #result2 do
					tbl18[#tbl18 + 1] = result2[i].Position
				end
			end
		end

		pcall(function()
			result:Destroy()
		end)

		return tbl18, true
	end

	drive.sidestep = function(arg, arg2, arg3, arg4)
		local vector2 = Vector3.new(-arg2.Z, 0, arg2.X)

		if arg4 and (arg4.Position - arg):Dot(vector2) > 0 then
			vector2 = -vector2
		end

		local n21 = arg3 * drive.GRADE

		for _, v7 in ipairs(drive.NUDGE) do
			for i = 1, -1, -2 do
				local n22 = arg + arg2 * arg3 + vector2 * v7 * i
				local v8 = drive.hug(n22.X, n22.Z, arg.Y + n21 + 0.5)

				if v8 and math.abs(v8 - arg.Y) <= n21 then
					local vector3 = Vector3.new(n22.X, v8, n22.Z)
					if not drive.cast(arg, vector3 - arg) then
						return vector3
					end
				end
			end
		end

		return nil
	end

	drive.BODY = Vector3.new(3.5, 2.5, 2.5)

	drive.tall = function(arg, arg2, arg3)
		if not flag or ok == false then
			return nil
		end
		fn20()
		local n21 = arg + Vector3.new(0, 1, 0)

		local ok2, result = pcall(function()
			local v7 = workspace
			local body = drive.BODY
			local n22 = arg2 * arg3
			return v7:Blockcast(CFrame.lookAt(n21, n21 + arg2), body, n22, raycastParams)
		end)

		return ok2 and result or nil
	end

	drive.treeFolder = function()
		local env2 = workspace:FindFirstChild("Env")
		return env2 and env2:FindFirstChild("Trees") or nil
	end

	drive.isTree = function(arg)
		if not arg then
			return false
		end
		local instance = typeof(arg) == "Instance" and arg or arg.Instance
		if not instance then
			return false
		end
		local v7 = drive.treeFolder()
		return v7 ~= nil and instance:IsDescendantOf(v7)
	end

	tbl5.drive = drive

	local function fn39(arg, arg2, arg3, arg4)
		arg2 = arg2 or 8

		local function fn40()
			return typeof(arg) == "function" and arg() or arg
		end

		local character = localPlayer.Character
		character = character and character:FindFirstChild("HumanoidRootPart")
		local v7 = fn40()
		if not (character and v7) then
			return false
		end
		local n21 = math.clamp((v7 - character.Position).Magnitude / math.max(fn28(), 1) * 3.5 + 15, 12, 420)
		local n22 = os.clock() + n21
		local position = character.Position
		local lastAt = tbl7.lastAt

		if n7 < os.clock() - lastAt then
			tbl7.continuous = 0
		end

		local magnitude = Vector3.new(v7.X - character.Position.X, 0, v7.Z - character.Position.Z).Magnitude
		local now = os.clock()
		local n23 = 1
		local v8 = nil
		local v9 = magnitude
		local n24 = 0
		local v10 = nil
		local now2 = os.clock()

		local function fn41(arg5)
			v10 = v8[n23]
			n23 += 1
			n24 = 0

			if n23 > #v8 then
				v8 = nil
				local now3 = os.clock()
				v9 = arg5
				now = now3
			end
		end

		local now3 = os.clock()

		local function fn42()
			if arg3 and arg3() then
				return true
			end

			if tbl8.flagged or tbl10.over then
				return true
			end
			local character2 = localPlayer.Character
			character2 = character2 and character2:FindFirstChildOfClass("Humanoid")
			return not character2 or character2.Health <= 0
		end

		local tbl18 = nil
		local huge = math.huge
		local v11 = nil
		local n25 = 0
		local n26 = -math.huge

		while os.clock() < n22 do
			if arg3 and arg3() then
				return false
			end

			if tbl8.flagged then
				return false
			end
			local character2 = localPlayer.Character
			local humanoidRootPart = character2 and character2:FindFirstChild("HumanoidRootPart")
			character2 = character2 and character2:FindFirstChildOfClass("Humanoid")
			if not humanoidRootPart or not character2 or character2.Health <= 0 then
				return false
			end
			local v12 = fn40()
			if not v12 then
				return false
			end
			local position2 = humanoidRootPart.Position
			if (v12 - position2).Magnitude <= arg2 then
				tbl4.lag = fn16()
				return true
			end
			local magnitude2 = Vector3.new(v12.X - position2.X, 0, v12.Z - position2.Z).Magnitude

			if v8 and tbl18 and v8[n23] then
				local v13 = v8[n23]
				local v14 = tbl18[n23]
				magnitude2 = Vector3.new(v13.X - position2.X, 0, v13.Z - position2.Z).Magnitude + v14
			end

			if magnitude2 < huge - drive.NET_STEP then
				now2 = os.clock()
				huge = magnitude2
			else
				local netStall = drive.NET_STALL
				if os.clock() - now2 > netStall then
					tbl4.status = ("Glide made no headway for %ds - re-planning"):format(drive.NET_STALL)
					return false
				end
			end

			local v13 = fn28()
			local v14 = fn16()
			tbl4.lag = v14
			tbl7.continuous = tbl7.continuous + (position2 - position).Magnitude
			tbl7.lastAt = os.clock()
			local flag3 = fn18() > v13 * 1.25

			if flag3 then
				tbl4.status = "Slowing down"
			end

			local flag4 = v14 ~= nil and v14 > math.max(n4 * 3, v13 * 0.5)

			if n5 <= tbl7.continuous then
				local status = tbl4.status
				tbl4.status = ("Resting %ds - mandatory stop every %d studs"):format(2.5, 600)
				fn17()
				local now4 = os.clock()
				fn38(2.5)
				now2 += os.clock() - now4
				tbl4.status = status
				tbl7.continuous = 0
				position = localPlayer.Character
				position = position and position:FindFirstChild("HumanoidRootPart")
				position = position and position.Position or position2
				now = os.clock()
				continue
			end

			if flag4 or flag3 then
				local status = tbl4.status
				tbl4.status = fn15() and "Letting the server catch up..." or ("Something is pushing us - settling %.1fs"):format(0.6)
				fn38(fn15() and 2 or 0.6)
				tbl4.status = status
				position = localPlayer.Character
				position = position and position:FindFirstChild("HumanoidRootPart")
				position = position and position.Position or position2
				now = os.clock()
				continue
			end

			if tbl10.over then
				v2.Heartbeat:Wait()
				position = position2
				continue
			end

			local vector2 = Vector3.new(v12.X - position2.X, 0, v12.Z - position2.Z)
			local magnitude3 = vector2.Magnitude

			if arg4 then
				if v8 and (v12 - v11).Magnitude > drive.ROUTE_DRIFT then
					v8 = nil
					now = os.clock()
					v9 = magnitude3
				end

				if v8 then
					local v15 = v8[n23]
					local vector3 = Vector3.new(v15.X - position2.X, 0, v15.Z - position2.Z)
					local magnitude4 = vector3.Magnitude
					local vector4 = Vector3.new(v15.X - v10.X, 0, v15.Z - v10.Z)
					local flag5 = magnitude4 <= drive.ROUTE_PASS and vector4.Magnitude > 0.05 and vector3:Dot(vector4) <= 0

					if magnitude4 <= drive.ROUTE_REACH or flag5 then
						v10 = v15
						n23 += 1
						n24 = 0
						now = os.clock()

						if n23 > #v8 then
							v8 = nil
							v9 = magnitude3
						end

						position = position2
						continue
					end

					if magnitude4 > drive.ROUTE_OFF or n24 > drive.ROUTE_STALL then
						v8 = nil
						now = os.clock()
						v9 = magnitude3
					end
				end

				local flag5 = not v8 and n25 < drive.ROUTE_TRIES and magnitude3 >= drive.ROUTE_MIN

				if flag5 then
					local routeGap = drive.ROUTE_GAP
					flag5 = os.clock() - n26 >= routeGap
				end

				if flag5 then
					n26 = os.clock()
					local v15, v16 = drive.plan(position2, v12)

					if v16 then
						n25 += 1
					end

					if v15 then
						n23 = 1
						n24 = 0
						v8 = v15
						v10 = position2
						tbl18 = {}
						local magnitude4 = Vector3.new(v12.X - v15[#v15].X, 0, v12.Z - v15[#v15].Z).Magnitude
						tbl18[#v15] = magnitude4

						for i = #v15 - 1, 1, -1 do
							magnitude4 += Vector3.new(v15[i + 1].X - v15[i].X, 0, v15[i + 1].Z - v15[i].Z).Magnitude
							tbl18[i] = magnitude4
						end

						local n27 = 0
						local v17 = position2

						for _, v18 in ipairs(v15) do
							n27 += (v18 - v17).Magnitude
							v17 = v18
						end

						local n28 = math.max(n22, math.min(now3 + 420, os.clock() + n27 / math.max(v13, 1) * 3.5 + 15))
						now = os.clock()
						v9 = magnitude3
						v11 = v12
						n22 = n28
					end

					if v16 then
						position = position2
						continue
					end
				end
			end

			if magnitude3 < v9 - 1 then
				now = os.clock()
				v9 = magnitude3
			end

			if os.clock() - now > n8 then
				tbl4.status = "Glide stuck - re-planning"
				return false
			end

			if magnitude3 < 0.5 then
				local v15, v16 = drive.hug(position2.X, position2.Z, math.max(position2.Y, v12.Y) + 0.5)
				local y = v12.Y

				if v15 then
					y = math.clamp(v12.Y, v15, math.max(v15, v16 + n2))
				end

				if math.abs(y - position2.Y) < 0.25 then
					return false
				end
				local vector3 = Vector3.new(position2.X, y, position2.Z)
				if drive.cast(position2, vector3 - position2) then
					return false
				end

				if drive.segment(humanoidRootPart, vector3, position2 + humanoidRootPart.CFrame.LookVector, v13, fn42) then
					now = os.clock()
				end

				position = position2
				continue
			end

			local magnitude4

			if v8 then
				local v15 = v8[n23]
				vector2 = Vector3.new(v15.X - position2.X, 0, v15.Z - position2.Z)
				magnitude4 = vector2.Magnitude
				n24 += 1
			else
				magnitude4 = magnitude3
			end

			local unit = vector2.Unit
			local v15, v16 = drive.hug(position2.X, position2.Z, position2.Y + 0.5)

			if v15 and v15 < position2.Y - drive.SETTLE_TOL then
				local vector3 = Vector3.new(position2.X, v15, position2.Z)

				if not drive.cast(position2, vector3 - position2) then
					if drive.segment(humanoidRootPart, vector3, position2 + unit, v13, fn42) then
						now = os.clock()
					end

					position = position2
					continue
				end
			end

			local n27 = math.min(drive.STEP, magnitude4)
			local n28 = position2 + unit * n27
			local n29 = n27 * drive.GRADE
			local y = drive.hug(n28.X, n28.Z, position2.Y + n29 + 0.5) or position2.Y
			local flag5 = y - position2.Y > n29
			local vector3

			if flag5 then
				vector3 = nil
			elseif y - position2.Y < -n29 then
				vector3 = Vector3.new(n28.X, position2.Y, n28.Z)
			else
				vector3 = Vector3.new(n28.X, y, n28.Z)
			end

			local v17 = vector3 and drive.cast(position2, vector3 - position2)

			if v17 then
				vector3 = nil
			end

			if (v8 or drive.isTree(v17)) and not vector3 then
				v17 = v17 and drive.tall(position2, unit, n27)

				if flag5 or v17 then
					if v8 and magnitude4 <= drive.ROUTE_PASS then
						fn41(magnitude3)
						position = position2
						continue
					end

					vector3 = drive.sidestep(position2, unit, n27, v17 or nil)
				end
			end

			if vector3 then
				drive.segment(humanoidRootPart, vector3, vector3 + unit, v13, fn42)
				position = position2
				continue
			end

			local v18 = drive.cast(position2, unit * (n27 + drive.BOX.Z))
			local v19 = drive.isTree(v18)
			local v20 = (v8 or v19) and v18 and drive.tall(position2, unit, n27 + drive.BOX.Z)

			if v20 then
				if v8 and magnitude4 <= drive.ROUTE_PASS then
					fn41(magnitude3)
					position = position2
					continue
				end

				local v21 = drive.sidestep(position2, unit, n27, v20)

				if v21 then
					drive.segment(humanoidRootPart, v21, v21 + unit, v13, fn42)
					position = position2
					continue
				end
			end

			if v18 then
				local n30 = drive.BOX.Z * 0.5
				local gap = drive.GAP
				local n31 = math.min((v18.Position - position2):Dot(unit) - n30 - gap, magnitude4)

				if n31 > 0.25 then
					drive.segment(humanoidRootPart, position2 + unit * n31, position2 + unit * (n31 + 1), v13, fn42)
					position = position2
					continue
				end
			end

			local flag6 = tbl5.useGameClimb and type(tbl5.gameClimb) == "function" and not v19 and not tbl5.stairBusy
			local flag7

			if flag6 then
				flag7 = not (type(tbl5.onStairs) == "function" and tbl5.onStairs(position2))
			else
				flag7 = flag6
			end

			if flag7 and tbl5.islandAt(position2) == "Kori Island" then
				local status = tbl4.status
				local now4 = os.clock()
				local ok2, result, result2 = pcall(tbl5.gameClimb, humanoidRootPart, unit, fn42)
				n22 += os.clock() - now4
				now += os.clock() - now4
				now2 += os.clock() - now4
				tbl4.status = status

				if ok2 and result then
					if result2 then
						v8 = nil
						n23 = 1
						v10 = nil
						n24 = 0
						now = os.clock()
						v9 = magnitude3
						position = position2
						continue
					end

					tbl4.status = "Buso: game climb did not get up this wall - re-planning"
					return false
				end
			end

			if type(tbl5.wallPhase) == "function" and tbl5.wallPhase(humanoidRootPart, v12, unit) then
				v8 = nil
				n23 = 1
				v10 = nil
				n24 = 0
				now = os.clock()
				v9 = magnitude3
				position = position2
				continue
			end

			if v19 or drive.isTree(drive.cast(position2, unit * (drive.BOX.Z + drive.GAP + 1.5))) then
				tbl4.status = "A tree is in the way - going round it rather than climbing it"
				return false
			end
			local status = tbl4.status
			local n30 = math.min(n2, drive.CLIMB_MAX)
			tbl4.status = "Climbing a wall"
			local v21 = drive.climb(humanoidRootPart, unit, (v16 or position2.Y - drive.CLEAR) + n30, v13, fn42)
			tbl4.status = status

			if v21 == "top" then
				if not v8 then
					now = os.clock()
				end
			elseif v21 ~= "abort" then
				if v21 == "ceiling" then
					tbl4.status = "Overhang above - can't climb past it"
				elseif v21 == "cap" then
					tbl4.status = ("Wall is over %d studs tall - not climbing it"):format(n30)
				else
					tbl4.status = "Climb took too long - re-planning"
				end

				return false
			end

			position = position2
		end

		return false
	end

	fn30 = function(arg, arg2, arg3, arg4)
		local ok2, result = pcall(fn39, arg, arg2, arg3, arg4)
		drive.stop()

		if not ok2 then
			tbl4.status = "Glide error - re-planning"
			warn("[Skull Hub] glide: " .. tostring(result))
			return false
		end

		return result
	end
end

local fn31

fn31 = function()
	local character = localPlayer.Character
	return character and character:FindFirstChildOfClass("Humanoid"), character and character:FindFirstChild("HumanoidRootPart")
end

local fn32
local n10 = 0

fn32 = function()
	local v7, v8 = fn31()
	if not v7 then
		return
	end

	if v7.Sit then
		v7.Sit = false
	end

	if v7.PlatformStand then
		v7.PlatformStand = false
	end

	if v7.SeatPart then
		pcall(function()
			v7:ChangeState(Enum.HumanoidStateType.Jumping)
		end)

		if v8 then
			v8.CFrame = v8.CFrame + Vector3.new(0, 3, 0)
		end
	end

	local character = localPlayer.Character

	if (character and tonumber(character:GetAttribute("npcChatting")) or 0) > 0 and os.clock() - n10 > 1.5 then
		n10 = os.clock()

		pcall(function()
			quest:InvokeServer({ "npcChat", false })
		end)
	end
end

local tbl11

do
	local tbl12 = {
		[Enum.HumanoidStateType.Physics] = true,
		[Enum.HumanoidStateType.FallingDown] = true,
		[Enum.HumanoidStateType.GettingUp] = true,
	}

	local function fn33(arg)
		if not arg then
			return false
		end

		local ok, result = pcall(function()
			return arg:GetState()
		end)

		return ok and tbl12[result] or false
	end

	local function fn34()
		return tbl2.protected and tbl2.maxSpeedHooked and 100 or 46
	end

	local function fn35()
		return math.clamp(tbl4.moveSpeed, 16, fn34())
	end

	local vector = Vector3.new(28, 1, 28)
	local n11 = 22
	local tbl13 = { part = nil, conn = nil }

	local function fn36()
		if tbl13.conn then
			tbl13.conn:Disconnect()
			tbl13.conn = nil
		end

		if tbl13.part then
			pcall(function()
				tbl13.part:Destroy()
			end)

			tbl13.part = nil
		end
	end

	local function fn37(arg)
		local v7 = fn22()
		if not v7 then
			return false, nil
		end

		if fn23(arg.Y, v7) then
			return false, nil
		end
		local v8 = fn21(arg)
		if v8 and v8 >= v7 then
			return false, nil
		end
		return true, fn24(arg) or v7
	end

	local function fn38()
		if tbl13.conn then
			return
		end
		local v7, v8 = fn31()
		if not v8 then
			return
		end
		local part = Instance.new("Part")
		part.Name = "WaterPlane"
		part.Anchored = true
		part.CanCollide = true
		part.CanQuery = false
		part.CanTouch = false
		part.Transparency = 1
		part.Size = vector
		part.TopSurface = Enum.SurfaceType.Smooth
		part.BottomSurface = Enum.SurfaceType.Smooth
		part.CFrame = CFrame.new(v8.Position.X, v8.Position.Y - 3.5, v8.Position.Z)
		part.Parent = workspace
		tbl13.part = part

		tbl13.conn = fn7(v2.Heartbeat, "SeaFloor", function(arg)
			local part2 = tbl13.part
			local v9, v10 = fn31()
			if not (part2 and part2.Parent and v10) then
				return
			end
			local v11, v12 = fn37(v10.Position)
			if not v11 then
				return
			end
			local n12 = v12 + 1
			local n13 = part2.Position.Y + vector.Y * 0.5
			local n14 = n11 * math.min(arg or 0.016666666666666666, tbl7.maxFrame())
			part2.CFrame = CFrame.new(v10.Position.X, n13 + math.clamp(n12 - n13, -n14, n14) - vector.Y * 0.5, v10.Position.Z)
		end)
	end

	local fn39 = nil
	local n12 = 0.65

	local tbl14 = {
		goal = nil,
		conn = nil,
		jumpAt = 0,
		prevSpeed = nil,
		lastPos = nil,
		lastAt = 0,
		pinnedFor = 0,
		commitTo = nil,
		commitUntil = 0,
	}

	local function fn40()
		if tbl14.conn then
			tbl14.conn:Disconnect()
			tbl14.conn = nil
		end

		tbl14.goal = nil
		local v7 = tbl14
		local v8 = tbl14
		local v9 = tbl14
		tbl14.lastPos = nil
		v7.pinnedFor = 0
		v8.commitTo = nil
		v9.commitUntil = 0
		fn39()
		local v10 = fn31()

		if v10 then
			pcall(function()
				v10:Move(Vector3.zero, false)
			end)

			if tbl14.prevSpeed then
				pcall(function()
					v10.WalkSpeed = tbl14.prevSpeed
				end)
			end
		end

		tbl14.prevSpeed = nil
	end

	local function fn41()
		if tbl14.conn then
			return
		end
		local v7 = fn31()

		if v7 and not tbl14.prevSpeed then
			tbl14.prevSpeed = v7.WalkSpeed
		end

		tbl14.conn = fn7(v2.RenderStepped, "WalkDriver", function()
			local goal = tbl14.goal
			if not goal or tbl8.flagged then
				return
			end
			local v8, v9 = fn31()
			if not (v8 and v9) or v8.Health <= 0 then
				return
			end

			if fn33(v8) then
				return
			end
			local v10 = fn35()

			if math.abs(v8.WalkSpeed - v10) > 0.01 then
				v8.WalkSpeed = v10
			end

			local vector2 = Vector3.new(goal.X - v9.Position.X, 0, goal.Z - v9.Position.Z)
			if vector2.Magnitude < 0.5 then
				v8:Move(Vector3.zero, false)
				return
			end
			v8:Move(vector2.Unit, false)
		end)
	end

	local n13 = 200
	local n14 = 400
	local n15 = 6.666666666666667
	local tbl15 = { spent = 0, at = 0 }

	local function fn42()
		local now = os.clock()

		if tbl15.at > 0 then
			tbl15.spent = math.max(0, tbl15.spent - (now - tbl15.at) * n15)
		end

		tbl15.at = now
		return n14 - tbl15.spent
	end

	local function fn43(arg, arg2)
		if fn42() <= 20 then
			return false
		end
		local v7, v8 = fn31()
		if not (v8 and arg) then
			return false
		end
		local n16 = arg - v8.Position
		if n16.Magnitude < 1 then
			return true
		end
		tbl15.spent = tbl15.spent + math.min(n16.Magnitude, 200)
		fn39()
		fn40()
		return fn30(fn25(n16.Magnitude <= n13 and arg or v8.Position + n16.Unit * n13, tbl9.ref(v8.Position)), 10, arg2)
	end

	tbl11 = {
		cap = fn34,
		speed = fn35,
		floatStop = fn36,
		overWater = fn37,
		floatRun = fn38,
		stop = function()
			fn40()
			fn36()
		end,
		stopDriver = fn40,
		runDriver = fn41,
		running = function()
			return tbl14.conn ~= nil
		end,
		viaTween = function(arg, ...)
			local flag2 = tbl14.conn ~= nil

			if flag2 then
				fn40()
			end

			local v7 = pcall
			local v8 = table.pack(...)
			v8.n = 2 + v8.n - 1
			table.move(v8, 1, v8.n, 2, v8)
			v8[1] = arg
			local v9, v10 = v7(table.unpack(v8, 1, v8.n))

			if flag2 then
				fn41()
			end

			if not v9 then
				warn("[Skull Hub] walk->tween: " .. tostring(v10))
				return false
			end
			return v10
		end,
		hopLeft = fn42,
		hopSpend = function(arg)
			tbl15.spent = tbl15.spent + (tonumber(arg) or 0)
		end,
	}

	tbl5.phase = {
		maxThick = 14,
		clear = 3,
		maxJump = 20,
		probe = 6,
		maxDrop = 40,
		gap = 1.5,
		at = 0,
		from = nil,
	}

	tbl5.wallPhase = function(arg, arg2, arg3)
		local phase = tbl5.phase
		local at = phase.at
		if os.clock() - at < phase.gap then
			return false
		end

		if fn42() <= 20 then
			return false
		end
		local position = arg.Position
		local unit = arg3

		if not unit then
			local vector2 = Vector3.new(arg2.X - position.X, 0, arg2.Z - position.Z)
			if vector2.Magnitude < 1 then
				return false
			end
			unit = vector2.Unit
		end

		fn20()
		local hit = workspace:Raycast(position, unit * phase.probe, raycastParams)
		if not hit then
			return false
		end

		if math.abs(hit.Normal.Y) > 0.5 then
			return false
		end
		local raycastParams2 = RaycastParams.new()
		raycastParams2.FilterType = Enum.RaycastFilterType.Include
		raycastParams2.FilterDescendantsInstances = { hit.Instance }
		local hit2 = workspace:Raycast(hit.Position + unit * 400, -unit * 400, raycastParams2)
		if not hit2 then
			return false
		end
		local magnitude = (hit2.Position - hit.Position).Magnitude
		if magnitude < 0.1 or magnitude > phase.maxThick then
			return false
		end
		local n16 = hit2.Position + unit * phase.clear
		local magnitude2 = (n16 - position).Magnitude
		if phase.maxJump < magnitude2 then
			return false
		end
		local v7 = fn21(n16)
		if not v7 or n16.Y - v7 > phase.maxDrop then
			return false
		end
		local vector2 = Vector3.new(n16.X, v7 + 3, n16.Z)
		local overlapParams2 = OverlapParams.new()
		overlapParams2.FilterType = raycastParams.FilterType
		overlapParams2.FilterDescendantsInstances = raycastParams.FilterDescendantsInstances
		if #workspace:GetPartBoundsInBox(CFrame.new(vector2 + Vector3.new(0, 0.5, 0)), Vector3.new(2.5, 5, 2.5), overlapParams2) > 0 then
			return false
		end

		if phase.from and (n16 - phase.from).Magnitude < 6 then
			return false
		end
		phase.at = os.clock()
		phase.from = position
		tbl15.spent = tbl15.spent + magnitude2

		tbl11.viaTween(function()
			arg.CFrame = CFrame.new(vector2, vector2 + unit)
		end)

		fn39()
		local v8 = tbl14
		tbl14.lastPos = nil
		v8.pinnedFor = 0
		return true
	end

	tbl11.phase = tbl5.wallPhase

	tbl5.GAME_CLIMB = {
		MIN_TIME = 5,
		LEDGE_WAIT = 2.5,
		STEP_ON = 3,
		FULL = 19.5,
		WAIT_MAX = 25,
		SNAP_REACH = 8,
		SNAP_INSET = 3,
		HEAD = 4,
		SNAP_DOWN = 3,
		SNAP_DOWN_END = 8,
	}

	tbl5.useGameClimb = false

	tbl5.gameClimbHandle = function()
		local character = localPlayer.Character

		local function fn44()
			local v7 = tbl3.getHandler()
			local value = v7 and rawget(v7, "Callbacks")
			local value2 = type(value) == "table" and rawget(value, "Climb") or nil
			return value2, type(value2) == "table" and rawget(value2, "ClimbingObject") or nil
		end

		local v7, v8 = fn44()

		if type(v8) == "table" and rawget(v8, "char") ~= character then
			tbl3.handler = nil
			v7, v8 = fn44()
		end

		if not (character and type(v7) == "table" and type(v8) == "table" and rawget(v8, "char") == character and type(v7.PC_Activate) == "function") then
			return nil
		end
		local v9 = nil

		pcall(function()
			for _, v10 in pairs(debug.getupvalues(getmetatable(v8).step)) do
				if type(v10) == "table" and type(v10.GetMoveVector) == "function" then
					v9 = v10
					break
				end
			end
		end)

		if not v9 then
			return nil
		end
		return v7, v8, v9
	end

	tbl5.gameClimb = function(arg, arg2, arg3)
		local gameClimb = tbl5.GAME_CLIMB
		local parent = arg and arg.Parent
		parent = parent and parent:FindFirstChildOfClass("Humanoid")
		if not (parent and parent.Health > 0 and arg2) then
			return false
		end
		local vector2 = Vector3.new(arg2.X, 0, arg2.Z)
		if vector2.Magnitude < 0.5 then
			return false
		end
		local unit = vector2.Unit
		local v7, v8, v9 = tbl5.gameClimbHandle()
		if not v7 then
			return false
		end

		if v8.Enabled == true then
			return false
		end
		local raycastParams2 = RaycastParams.new()
		raycastParams2.FilterType = Enum.RaycastFilterType.Include
		local filterDescendantsInstances = {}

		for _, v10 in ipairs({ "Islands", "Env", "Ships" }) do
			local v11 = workspace:FindFirstChild(v10)

			if v11 then
				filterDescendantsInstances[#filterDescendantsInstances + 1] = v11
			end
		end

		raycastParams2.FilterDescendantsInstances = filterDescendantsInstances
		local position = arg.Position
		local cframe = CFrame.lookAt(position, position + unit)
		local z = arg.Size.Z
		local n16 = tonumber(v8.LengthScan) or 2 + arg.Size.Y * 2
		if not workspace:Raycast((cframe * CFrame.new(0, 0, z)).Position, unit * (n16 + z - 0.5), raycastParams2) then
			return false
		end
		drive.stop()
		local waitMax = gameClimb.WAIT_MAX
		local n17 = os.clock() + waitMax

		while true do
			if (tonumber(v8.climbingtime) or 0) < gameClimb.FULL or rawget(v7, "climbCD") == true then
				if not (os.clock() > n17 or not arg.Parent or arg3()) then
					tbl4.status = ("Waiting for climb stamina (%d/20)"):format(math.floor(tonumber(v8.climbingtime) or 0))
					task.wait(0.25)
					continue
				end
			end

			break
		end

		if not arg.Parent or arg3() then
			return false
		end

		if v8.Enabled == true or rawget(v7, "climbCD") == true then
			return false
		end

		if (tonumber(v8.climbingtime) or 0) < gameClimb.MIN_TIME then
			return false
		end
		tbl4.status = "Buso: climbing the wall (game climb)"
		local overlapParams2 = OverlapParams.new()
		overlapParams2.FilterType = Enum.RaycastFilterType.Include
		overlapParams2.FilterDescendantsInstances = filterDescendantsInstances

		local function fn44(arg4)
			local snapDown = arg4 or gameClimb.SNAP_DOWN
			local position2 = arg.Position
			local hit = workspace:Raycast(position2, unit * 6, raycastParams2)
			local n18 = (hit and Vector3.new(hit.Position.X, 0, hit.Position.Z) or Vector3.new(position2.X, 0, position2.Z)) + unit * gameClimb.SNAP_INSET
			local hit2 = workspace:Raycast(Vector3.new(n18.X, position2.Y + gameClimb.SNAP_REACH + 1, n18.Z), Vector3.new(0, -(gameClimb.SNAP_REACH + snapDown + 2), 0), raycastParams2)
			if not hit2 or hit2.Normal.Y < 0.7 then
				return nil
			end

			if hit2.Position.Y > position2.Y + gameClimb.SNAP_REACH or hit2.Position.Y < position2.Y - snapDown then
				return nil
			end
			local vector3 = Vector3.new(n18.X, hit2.Position.Y + drive.CLEAR, n18.Z)
			if #workspace:GetPartBoundsInBox(CFrame.new(vector3 + Vector3.new(0, 0.5, 0)), Vector3.new(2.5, 5, 2.5), overlapParams2) > 0 then
				return nil
			end

			if workspace:Raycast(vector3, Vector3.new(0, gameClimb.HEAD, 0), raycastParams2) then
				return nil
			end
			return vector3
		end

		local position2 = arg.Position
		arg.CFrame = CFrame.lookAt(position2, position2 + unit)
		arg.AssemblyLinearVelocity = Vector3.zero
		local y = position2.Y
		local value = rawget(v9, "GetMoveVector")

		rawset(v9, "GetMoveVector", function()
			return Vector3.new(0, 0, -1)
		end)

		local flag2 = false
		local v10 = nil

		pcall(function()
			v7:PC_Activate()
			if v8.Enabled ~= true and rawget(v8, "ledge") ~= true then
				return
			end
			local n18 = os.clock() + math.min(tonumber(v8.climbingtime) or 20, 20) + 1
			local now = nil

			while os.clock() < n18 do
				if not (not arg.Parent or arg3()) then
					v10 = fn44()

					if not v10 then
						if rawget(v8, "ledge") == true then
							if not flag2 then
								now = os.clock()
								flag2 = true
							end

							local ledgeWait = gameClimb.LEDGE_WAIT
							if not (os.clock() - now > ledgeWait) then
								v2.Heartbeat:Wait()
								continue
							end
						elseif not (flag2 or v8.Enabled ~= true) then
							v2.Heartbeat:Wait()
							continue
						end
					end
				end

				break
			end
		end)

		rawset(v9, "GetMoveVector", value)

		if v8.Enabled == true then
			pcall(function()
				v7:PC_Activate()
			end)

			if v8.Enabled == true then
				pcall(function()
					v8.Enabled = false
					v8:stop()
				end)
			end
		end

		pcall(function()
			local g = getrenv and getrenv()._G

			if type(g) == "table" and g.canuse == false and v8.Enabled ~= true then
				g.canuse = true
			end
		end)

		if arg.Parent and not tbl8.flagged then
			v10 = fn44(gameClimb.SNAP_DOWN_END) or v10
		end

		local flag3 = v10 and arg.Parent and not tbl8.flagged
		local flag4 = false

		if flag3 then
			local magnitude = (v10 - arg.Position).Magnitude

			if magnitude <= gameClimb.SNAP_REACH + gameClimb.SNAP_INSET + gameClimb.SNAP_DOWN_END and fn42() > magnitude then
				tbl15.spent = tbl15.spent + magnitude
				local n18 = v10 + unit

				tbl11.viaTween(function()
					arg.CFrame = CFrame.new(v10, n18)
					arg.AssemblyLinearVelocity = Vector3.zero
					arg.AssemblyAngularVelocity = Vector3.zero
				end)

				fn39()
				local v11 = tbl14
				tbl14.lastPos = nil
				v11.pinnedFor = 0
				flag4 = true
			end
		end

		if flag2 and not flag4 and arg.Parent then
			fn20()
			local n18 = arg.Position + unit * gameClimb.STEP_ON
			local hit = workspace:Raycast(Vector3.new(n18.X, arg.Position.Y + 2, n18.Z), Vector3.new(0, -9, 0), raycastParams)

			if hit and hit.Normal.Y >= 0.7 then
				local vector3 = Vector3.new(n18.X, hit.Position.Y + drive.CLEAR, n18.Z)
				drive.segment(arg, vector3, vector3 + unit, fn28(), arg3)
			end
		end

		return true, arg.Parent ~= nil and arg.Position.Y > y + 4
	end

	local n16 = 0.8

	local function fn44(arg, arg2, arg3)
		local vector2 = Vector3.new(arg2.X - arg.X, 0, arg2.Z - arg.Z)
		if vector2.Magnitude < 0.5 then
			return arg2, false
		end
		local commitTo = tbl14.commitTo

		if commitTo then
			local commitUntil = tbl14.commitUntil
			commitTo = os.clock() < commitUntil
		end

		if commitTo then
			if Vector3.new(tbl14.commitTo.X - arg.X, 0, tbl14.commitTo.Z - arg.Z).Magnitude > 3 then
				return Vector3.new(tbl14.commitTo.X, arg.Y, tbl14.commitTo.Z), true
			end
		end

		tbl14.commitTo = nil
		local n17 = vector2.Unit * math.min(vector2.Magnitude, 14)
		if not arg3 and not fn26(arg, n17) then
			return arg2, false
		end
		local v7 = fn27(arg, arg + n17)

		if v7 then
			if Vector3.new(v7.X - arg.X, 0, v7.Z - arg.Z).Magnitude > 1 then
				local v8 = tbl14
				local v9 = tbl14
				local commitUntil = os.clock() + n16
				v8.commitTo = v7
				v9.commitUntil = commitUntil
				return Vector3.new(v7.X, arg.Y, v7.Z), true
			end
		end

		if arg3 then
			local n18 = Vector3.new(-vector2.Unit.Z, 0, vector2.Unit.X) * 24 * n9
			n9 = -n9
			local commitTo2 = arg + n18
			local v8 = tbl14
			local v9 = tbl14
			local commitUntil = os.clock() + n16
			v8.commitTo = commitTo2
			v9.commitUntil = commitUntil
			return Vector3.new(commitTo2.X, arg.Y, commitTo2.Z), true
		end

		return arg2, true
	end

	local v7 = fn(game:GetService("PathfindingService"))
	local tbl16 = { AgentRadius = 2.5, AgentHeight = 6, AgentCanJump = true, AgentMaxSlope = 45 }
	local n17 = 18
	local n18 = 900
	local n19 = 4
	local n20 = 1
	local n21 = 4
	local n22 = 20
	local tbl17 = { pts = nil, i = 1, at = 0, goal = nil }

	fn39 = function()
		local v8 = tbl17
		local v9 = tbl17
		tbl17.pts = nil
		v8.i = 1
		v9.goal = nil
	end

	local function fn45(arg, goal)
		local at = tbl17.at
		if os.clock() - at < n20 then
			return false
		end
		local magnitude = (goal - arg).Magnitude
		if magnitude < n17 or magnitude > n18 then
			return false
		end

		if fn37(arg) or fn37(goal) then
			return false
		end
		tbl17.at = os.clock()

		local ok, result = pcall(function()
			return v7:CreatePath(tbl16)
		end)

		if not ok or not result then
			return false
		end

		if not pcall(function()
			result:ComputeAsync(arg, goal)
		end) or result.Status ~= Enum.PathStatus.Success then
			pcall(function()
				result:Destroy()
			end)

			return false
		end

		local waypoints = result:GetWaypoints()

		pcall(function()
			result:Destroy()
		end)

		if #waypoints < 2 then
			return false
		end
		local v8 = tbl17
		local v9 = tbl17
		tbl17.pts = waypoints
		v8.i = 2
		v9.goal = goal
		return true
	end

	local function fn46(arg, arg2, arg3)
		if not tbl17.pts then
			return nil
		end

		if tbl17.goal and (arg2 - tbl17.goal).Magnitude > n22 then
			fn39()
			return nil
		end
		local v8 = tbl17.pts[tbl17.i]

		if Vector3.new(v8.Position.X - arg.X, 0, v8.Position.Z - arg.Z).Magnitude <= n19 then
			if v8.Action == Enum.PathWaypointAction.Jump and arg3 then
				pcall(function()
					arg3.Jump = true
				end)
			end

			tbl17.i = tbl17.i + 1
		end

		if #tbl17.pts < tbl17.i then
			fn39()
			return nil
		end
		return tbl17.pts[tbl17.i].Position
	end

	local n23 = 3.5
	local n24 = 1.5
	tbl11.NET_STALL = 30

	tbl11.to = function(arg, arg2, arg3)
		arg2 = arg2 or 8

		local function fn47()
			return typeof(arg) == "function" and arg() or arg
		end

		local v8 = fn47()
		local v9
		v9, v9 = fn31()
		if not (v8 and v9) then
			return false
		end
		fn32()
		fn41()
		local n25 = math.clamp((v8 - v9.Position).Magnitude / math.max(fn35(), 1) * 4 + 25, 25, 600)
		local n26 = os.clock() + n25
		local now = os.clock()
		local now2 = os.clock()
		fn39()
		local huge = math.huge
		local huge2 = math.huge
		local n27 = 0
		local n28 = 0

		while os.clock() < n26 do
			if arg3 and arg3() then
				fn40()
				return false
			end

			if tbl8.flagged then
				fn40()
				return false
			end
			local v10, v11 = fn31()
			if not (v10 and v11) or v10.Health <= 0 then
				fn40()
				return false
			end
			local v12 = fn47()
			if not v12 then
				fn40()
				return false
			end
			local magnitude = Vector3.new(v12.X - v11.Position.X, 0, v12.Z - v11.Position.Z).Magnitude
			local n29 = math.abs(v12.Y - v11.Position.Y)
			if magnitude <= arg2 and n29 <= math.max(arg2, 26) then
				fn40()
				return true
			end

			if magnitude < huge - n24 then
				now2 = os.clock()
				huge = magnitude
			else
				local netStall = tbl11.NET_STALL

				if os.clock() - now2 > netStall then
					tbl4.status = ("Walk made no headway for %ds - re-planning"):format(tbl11.NET_STALL)
					fn40()
					return false
				end
			end

			if fn37(v11.Position) then
				fn38()
			else
				fn36()
			end

			fn32()
			local now3 = os.clock()
			local flag2 = false

			if tbl14.lastPos then
				if v10.MoveDirection.Magnitude > 0.1 and (v11.Position - tbl14.lastPos).Magnitude < 0.5 and not fn33(v10) then
					tbl14.pinnedFor = (tbl14.pinnedFor or 0) + now3 - (tbl14.lastAt or now3)
					flag2 = tbl14.pinnedFor > 0.6
				else
					tbl14.pinnedFor = 0
				end
			end

			local v13 = tbl14
			tbl14.lastPos = v11.Position
			v13.lastAt = now3

			if flag2 then
				tbl14.pinnedFor = 0
			end

			if flag2 and tbl5.wallPhase(v11, v12) then
				tbl4.status = "Stepped through a wall"
				now = os.clock()
				flag2 = false
				huge2 = magnitude
			end

			if flag2 and tbl17.pts then
				fn39()
			elseif not tbl17.pts and n27 < n21 then
				if fn45(v11.Position, v12) then
					n27 += 1
					tbl14.pinnedFor = 0
					now = os.clock()
					huge2 = magnitude
				end
			end

			local v14 = fn46(v11.Position, v12, v10)
			local flag3 = false

			if not v14 then
				v14, flag3 = fn44(v11.Position, v12, flag2)
			end

			tbl14.goal = v14

			if flag3 and not fn33(v10) and now3 - tbl14.jumpAt > n12 then
				tbl14.jumpAt = now3

				pcall(function()
					v10.Jump = true
				end)
			end

			if fn33(v10) then
				now = os.clock()
				tbl4.status = "Knocked down - waiting it out"
			elseif magnitude < huge2 - n24 then
				now = os.clock()
				huge2 = magnitude
			elseif n23 < os.clock() - now then
				n28 += 1
				if n28 > 3 then
					fn40()
					return false
				end
				tbl4.status = ("Stuck - short hop (%d studs of escape left)"):format(math.floor(fn42()))
				if not fn43(v12, arg3) then
					fn40()
					return false
				end
				fn41()
				now = os.clock()
				huge2 = math.huge
			end

			task.wait(0.05)
		end

		fn40()
		return false
	end
end

local fn33

fn33 = function(arg, arg2, arg3)
	if tbl5.fishUnfreeze then
		tbl5.fishUnfreeze()
	end

	fn32()

	if tbl4.moveMode == "Glide" then
		if fn30(arg, arg2, arg3, tbl4.glideRoute) then
			return true
		end

		if arg3 and arg3() then
			return false
		end

		if tbl8.flagged then
			return false
		end
		local v7
		v7, v7 = fn31()
		if not v7 or tbl11.overWater(v7.Position) then
			return false
		end
		tbl4.status = "Glide blocked - one walk leg"
		local v8 = tbl11.to(arg, arg2, arg3)
		tbl11.floatStop()
		return v8
	end

	if tbl11.to(arg, arg2, arg3) then
		return true
	end

	if arg3 and arg3() then
		return false
	end

	if tbl8.flagged then
		return false
	end

	if tbl4.moveMode == "Walk only" then
		return false
	end
	tbl4.status = "Walk blocked - one glide leg"
	return fn30(arg, arg2, arg3)
end

local fn34

fn34 = function(arg, arg2, arg3)
	tbl11.stop()
	return fn30(arg, arg2, arg3)
end

local fn35, fn36

do
	local n11 = 250
	local n12 = 1

	fn35 = function(arg)
		local v7 = fn22()
		local v8 = fn21(arg)
		if v7 and (not v8 or v8 < v7) and not fn23(arg.Y, v7) then
			return Vector3.new(arg.X, (fn24(arg) or v7) + n12, arg.Z)
		end
		return Vector3.new(arg.X, (v8 or arg.Y) + 3, arg.Z)
	end

	fn36 = nil

	tbl5.STAIRS = {
		{
			name = "Kori Island stairs",
			sea = 1,
			island = "Kori Island",
			minGoalY = 40,
			maxFromY = 30,
			slack = 10,
			box = { min = Vector3.new(-4380, 0, -3160), max = Vector3.new(-4350, 60, -3080) },
			path = {
				Vector3.new(-4365, 7, -3154),
				Vector3.new(-4365, 12, -3140),
				Vector3.new(-4365, 31, -3121),
				Vector3.new(-4365, 52, -3100),
				Vector3.new(-4365, 53, -3086),
				Vector3.new(-4372.723, 52.482323, -3078),
			},
		},
	}

	tbl5.stairRoute = function(arg, arg2)
		if not (arg and arg2) then
			return nil
		end
		local whichSea = tbl5.whichSea and tbl5.whichSea()

		for _, stair in ipairs(tbl5.STAIRS) do
			local flag2 = (not stair.sea or stair.sea == whichSea) and arg2.Y >= stair.minGoalY and arg.Y < stair.maxFromY

			if flag2 then
				local island = stair.island
				flag2 = tbl5.islandAt(arg2) == island
			end

			if flag2 then
				return stair
			end
		end

		return nil
	end

	tbl5.onStairs = function(arg)
		if not arg then
			return false
		end
		local whichSea = tbl5.whichSea and tbl5.whichSea()

		for _, stair in ipairs(tbl5.STAIRS) do
			local box = stair.box
			if box and (not stair.sea or stair.sea == whichSea) and arg.X >= box.min.X and arg.X <= box.max.X and arg.Y >= box.min.Y and arg.Y <= box.max.Y and arg.Z >= box.min.Z and arg.Z <= box.max.Z then
				return true
			end
		end

		return false
	end

	tbl5.followStairs = function(arg, arg2)
		local function fn37(arg3)
			local character = localPlayer.Character
			character = character and character:FindFirstChild("HumanoidRootPart")
			return character and (arg3 - character.Position).Magnitude or nil
		end

		for i, v7 in ipairs(arg.path) do
			if arg2 and arg2() then
				return false
			end

			if tbl8.flagged then
				return false
			end

			if tbl4 then
				tbl4.status = ("Taking the %s (%d/%d)"):format(arg.name, i, #arg.path)
			end

			if i == 1 then
				fn36(v7, 5, arg2)
			else
				fn33(v7, 3, arg2)
			end

			local v8 = fn37(v7)
			if not v8 or v8 > arg.slack then
				return false
			end
		end

		return true
	end

	fn36 = function(arg, arg2, arg3)
		if tbl5.fishUnfreeze then
			tbl5.fishUnfreeze()
		end

		arg2 = arg2 or 8
		local character = localPlayer.Character
		character = character and character:FindFirstChild("HumanoidRootPart")
		if not (character and arg) then
			return false
		end
		local v7 = fn22()

		if tbl5.whichSea() == 1 and fn23(character.Position.Y, v7) and not fn23(arg.Y, v7) then
			local fishman = tbl5.fishman

			if fishman and type(fishman.leave) == "function" and not fishman.leaving then
				if not fishman.leave(arg3) then
					return false
				end
				character = localPlayer.Character
				character = character and character:FindFirstChild("HumanoidRootPart")
				if not character then
					return false
				end
			end
		end

		if not tbl5.stairBusy then
			local v8 = tbl5.stairRoute(character.Position, arg)

			if v8 then
				tbl5.stairBusy = true
				local ok, result = pcall(tbl5.followStairs, v8, arg3)
				tbl5.stairBusy = false
				if arg3 and arg3() then
					return false
				end
				character = localPlayer.Character
				character = character and character:FindFirstChild("HumanoidRootPart")
				if not character then
					return false
				end

				if not (ok and result) and tbl4 then
					tbl4.status = ("%s did not work out - carrying on the direct way"):format(v8.name)
				end
			end
		end

		local v8 = tbl5.leaveCave(arg, arg3)
		if arg3 and arg3() then
			return false
		end

		if v8 then
			local character2 = localPlayer.Character
			character = character2 and character2:FindFirstChild("HumanoidRootPart")
			if not character then
				return false
			end
		end

		local flag2 = v8 ~= nil
		local magnitude = (arg - character.Position).Magnitude
		local flag3 = tbl5.landDetour(character.Position, arg) ~= nil
		if magnitude <= n11 and not flag3 then
			return fn33(arg, arg2, arg3)
		end
		local flag4 = tbl4.moveMode ~= "Glide"
		local v9 = flag4 and tbl11.speed() or fn28()
		local n13 = flag4 and 0 or math.floor(magnitude / n5) * n6
		local n14 = math.clamp(magnitude / math.max(v9, 1) * 6 + n13 + 120, 120, 2400)
		local n15 = os.clock() + n14
		local n16 = 0
		local huge = math.huge
		local n17 = 0
		local n18 = 1

		while os.clock() < n15 do
			if arg3 and arg3() then
				return false
			end

			if tbl8.flagged then
				return false
			end
			local character2 = localPlayer.Character
			local humanoidRootPart = character2 and character2:FindFirstChild("HumanoidRootPart")
			character2 = character2 and character2:FindFirstChildOfClass("Humanoid")
			if not humanoidRootPart or not character2 or character2.Health <= 0 then
				return false
			end
			local magnitude2 = (arg - humanoidRootPart.Position).Magnitude
			if magnitude2 <= arg2 then
				return true
			end
			local v10 = nil
			local str = nil
			local v11 = nil

			if tbl4.avoidIslands then
				v10, str, v11 = tbl5.landDetour(humanoidRootPart.Position, arg)
			end

			if magnitude2 <= n11 and not v10 then
				return fn33(arg, arg2, arg3)
			end
			local v12

			if n16 > 0 and not flag2 then
				v8 = tbl5.leaveCave(arg, arg3) or v8
				if arg3 and arg3() then
					return false
				end
				humanoidRootPart = localPlayer.Character
				humanoidRootPart = humanoidRootPart and humanoidRootPart:FindFirstChild("HumanoidRootPart")
				if not humanoidRootPart then
					return false
				end
				magnitude2 = (arg - humanoidRootPart.Position).Magnitude
				if magnitude2 <= arg2 then
					return true
				end
				flag2 = true

				if tbl4.avoidIslands then
					v12, str, v11 = tbl5.landDetour(humanoidRootPart.Position, arg)
				else
					v12 = v10
				end
			else
				v12 = v10
			end

			local n19, v13

			if v12 then
				n19 = nil

				if v11 then
					n19 = nil
					huge = math.huge
					n17 = 0
					v13 = v12
				else
					v13 = v12
				end
			else
				str = nil
				n19 = nil

				if tbl4.avoidIslands then
					v13, str, n19 = tbl5.seaDetour(humanoidRootPart.Position, arg, v8)
					local v14 = nil
					local v15 = nil

					if not v13 then
						v13 = arg
						str = v14
						n19 = v15
					end
				else
					v13 = arg
				end
			end

			local n20 = v13 - humanoidRootPart.Position

			if n20.Magnitude < 1 then
				n20 = arg - humanoidRootPart.Position
				str = nil
				n19 = nil
				v13 = arg
			end

			n19 = n19 or str and n20.Magnitude + (arg - v13).Magnitude or magnitude2

			if n19 < huge - 40 then
				n17 = 0
				huge = n19
			else
				n17 += 1
				if n17 > 8 then
					tbl4.status = ("No headway in %d legs (%d studs to go) - re-planning"):format(8, math.floor(magnitude2))
					return false
				end
			end

			local unit = n20.Unit
			local n21 = humanoidRootPart.Position + unit * math.min(250, n20.Magnitude)
			local n22

			if n16 > 0 then
				local n23 = Vector3.new(-unit.Z, 0, unit.X) * 120 * ((n16 - 1) % 5 + 1) * n18

				if tbl4.avoidIslands and tbl5.navOnIsland(n21 + n23, arg, humanoidRootPart.Position) then
					if tbl5.navOnIsland(n21 - n23, arg, humanoidRootPart.Position) then
						n23 = Vector3.zero
					else
						n23 = -n23
					end
				end

				n22 = n21 + n23
			else
				n22 = n21
			end

			local v14 = fn35(n22)

			if v12 then
				local v15 = tbl4
				local str2 = "Going round %s, not through it - %d studs to go"
				local format = str2.format
				str = str or "the island"
				v15.status = format(str2, str, math.floor(magnitude2))
			elseif str then
				tbl4.status = ("Travelling - %d studs to go (going round %s)"):format(math.floor(magnitude2), str)
			elseif flag4 then
				tbl4.status = ("Walking - %d studs to go"):format(math.floor(magnitude2))
			else
				local v15 = tbl4
				local format = ("Gliding - %d studs to go (rest in %d)").format
				local n23 = math.floor(magnitude2)
				local v16 = table.pack(math.floor(math.max(n5 - tbl7.continuous, 0)))
				v16.n = 3 + v16.n - 1
				table.move(v16, 1, v16.n, 3, v16)
				v16[1] = "Gliding - %d studs to go (rest in %d)"
				v16[2] = n23
				v15.status = format(table.unpack(v16, 1, v16.n))
			end

			if fn33(v14, 25, arg3) then
				local humanoidRootPart2 = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")

				if humanoidRootPart2 and (arg - humanoidRootPart2.Position).Magnitude < magnitude2 - 40 then
					n16 = 0
				end

				continue
			end

			if arg3 and arg3() then
				return false
			end
			n16 += 1
			n18 = -n18
			if not (n16 > 9) then
				continue
			end
			return false
		end

		return false
	end
end

local fn37

fn37 = function(arg, arg2)
	local n11 = os.clock() + (arg2 or 15)

	while true do
		for _, v7 in ipairs(arg) do
			if v7 then
				local v8 = workspace.NPCs:FindFirstChild(v7)
				if v8 then
					return v8
				end
			end
		end

		task.wait(0.25)
		if not (n11 < os.clock()) then
			continue
		end
		break
	end

	return nil
end

local fn38, fn39
local tbl12 = { pos = nil, look = nil, conn = nil }

fn38 = function(arg, look)
	local v7 = tbl12
	local v8 = tbl12
	v7.pos = fn25(arg, look and look.Y or tbl9.ref(arg))
	v8.look = look
	if tbl12.conn then
		return
	end

	tbl12.conn = fn7(v2.Heartbeat, "HoldDriver", function(arg2)
		local pos = tbl12.pos
		if not pos or tbl8.flagged then
			return
		end

		if tbl10.over then
			return
		end
		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		character = character and character:FindFirstChildOfClass("Humanoid")
		if not humanoidRootPart or not character or character.Health <= 0 then
			return
		end
		local n11 = math.min(arg2 or 0.016666666666666666, tbl7.maxFrame())
		local n12 = humanoidRootPart.Position:Lerp(pos, 1 - 0.65 ^ (n11 * 60))
		local n13 = n12 - humanoidRootPart.Position
		local n14 = fn28() * n11

		if n14 < n13.Magnitude then
			n12 = humanoidRootPart.Position + n13.Unit * n14
		end

		humanoidRootPart.CFrame = fn3(n12, tbl12.look or pos)
		humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
		humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
	end)
end

fn39 = function()
	local v7 = tbl12
	tbl12.pos = nil
	v7.look = nil
end

fn17 = fn39

tbl5.settleOnto = function(cFrame, arg, arg2)
	if typeof(cFrame) ~= "CFrame" then
		return false
	end

	if tbl5.fishUnfreeze then
		tbl5.fishUnfreeze()
	end

	local n11 = cFrame - cFrame.Position
	tbl11.stopDriver()
	fn39()
	local n12 = os.clock() + 5
	local n13 = 0.016666666666666666

	while os.clock() < n12 do
		if arg and arg() then
			return false
		end

		if tbl8.flagged then
			return false
		end
		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		character = character and character:FindFirstChildOfClass("Humanoid")
		if not (humanoidRootPart and humanoidRootPart.Parent and character and character.Health > 0) then
			return false
		end
		local n14 = cFrame.Position - humanoidRootPart.Position
		local magnitude = n14.Magnitude
		if arg2 and magnitude > arg2 then
			return false
		end

		if magnitude <= 0.25 then
			humanoidRootPart.CFrame = cFrame
			humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
			humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
			return true
		end

		humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position + n14.Unit * math.min(magnitude, fn28() * n13)) * n11
		humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
		humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
		n13 = v2.Heartbeat:Wait() or 0.016666666666666666
	end

	return false
end

local fn40

fn40 = function()
	if tbl5.fishUnfreeze then
		tbl5.fishUnfreeze()
	end

	fn39()
	tbl11.stop()
	drive.stop()
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")

	if character then
		character.AssemblyLinearVelocity = Vector3.zero
		character.AssemblyAngularVelocity = Vector3.zero
	end

	tbl7.continuous = 0

	pcall(function()
		local g = getrenv and getrenv()._G

		if type(g) == "table" and g.canuse == false then
			g.canuse = true
		end
	end)
end

fn7(v2.Heartbeat, "MotionWatch", function(arg)
	local v7 = tbl7
	local avgDt = tbl7.avgDt
	local min = math.min
	local n11 = arg or 0.016666666666666666
	local avgDt2 = tbl7.avgDt
	v7.avgDt = avgDt + (min(n11, 1) - avgDt2) * 0.05
	fn19(arg)
	fn29(arg)
end)

local tbl13
tbl13 = { list = {}, byName = {}, loaded = false, err = nil }
local fn41

fn41 = function()
	if tbl13.loaded then
		return true
	end

	local QuestDB = fn4("QuestDB", function()
		local v7 = require(v6.Modules.NPCInteractions):getquests()

		for k, v8 in pairs(v7) do
			if type(v8) == "table" and v8.QuestName and v8.lvlReq and type(v8.QuestInfo) == "table" and v8.QuestInfo.Type == "Defeat" and v8.QuestInfo.MobName then
				local tbl14 = {
					giver = k,
					npc = v8.NPC,
					name = v8.QuestName,
					lvlReq = v8.lvlReq,
					mob = v8.QuestInfo.MobName,
					amount = v8.QuestInfo.Ammount or 1,
					exp = v8.QuestInfo.Rewards and v8.QuestInfo.Rewards.EXP or 0,
					misc = v8.MiscQuest == true,
				}

				tbl14.boss = tbl14.amount <= 1
				tbl13.list[#tbl13.list + 1] = tbl14
				tbl13.byName[tbl14.name] = tbl14
			end
		end

		table.sort(tbl13.list, function(arg, arg2)
			if arg.lvlReq ~= arg2.lvlReq then
				return arg.lvlReq > arg2.lvlReq
			end
			return arg.exp > arg2.exp
		end)

		tbl13.loaded = #tbl13.list > 0
	end)

	if not tbl13.loaded then
		tbl13.err = "getquests() returned nothing usable"
	end

	return QuestDB and tbl13.loaded
end

local fn42

fn42 = function()
	return v6:FindFirstChild("Stats" .. localPlayer.Name)
end

local fn43

fn43 = function()
	local v7 = fn42()
	return v7 and v7.Stats.Level.Value or 0
end

local fn44

fn44 = function()
	local v7 = fn42()
	return v7 and v7.Quest.CurrentQuest.Value or "None"
end

local fn45

fn45 = function()
	local v7 = fn42()
	return v7 and v7.Quest.QuestProgress.Value or 0
end

local fn46
local tbl14 = { map = {}, at = 0, ok = false }

fn46 = function()
	local at = tbl14.at
	if os.clock() - at < (tbl14.ok and 60 or 5) then
		return tbl14.map
	end
	tbl14.at = os.clock()

	local ok, result = pcall(function()
		return quest:InvokeServer({ "getQuestLocations" })
	end)

	if ok and type(result) == "table" then
		local map = {}

		for k, v7 in pairs(result) do
			if typeof(v7) == "CFrame" then
				map[k] = v7.Position
			elseif typeof(v7) == "Vector3" then
				map[k] = v7
			end
		end

		if next(map) then
			local v7 = tbl14
			tbl14.map = map
			v7.ok = true
		end
	end

	return tbl14.map
end

local fn47

fn47 = function(arg)
	local v7 = workspace.NPCs:FindFirstChild(arg.giver)
	local npc

	if v7 then
		npc = v7
	else
		npc = arg.npc and workspace.NPCs:FindFirstChild(arg.npc)
	end

	if npc then
		return npc:GetPivot().Position, true
	end
	local v8 = fn46()
	return arg.npc and v8[arg.npc] or v8[arg.giver], false
end

local fn48

do
	local n11 = 250

	local function fn49(arg)
		local v7 = fn47(arg)
		if not v7 then
			return nil
		end
		local character = localPlayer.Character
		character = character and character:FindFirstChild("HumanoidRootPart")
		if not character then
			return nil
		end
		local magnitude = (v7 - character.Position).Magnitude
		if magnitude <= 400 then
			return magnitude
		end

		if not tbl4.travel then
			return nil
		end

		if tbl4.travelRange < magnitude then
			return nil
		end

		if n11 < math.abs(v7.Y - (fn22() or 0)) then
			return nil
		end
		return magnitude
	end

	local n12 = 10

	fn48 = function()
		local v7 = fn43()
		local tbl15 = {}
		local lvlReq = nil

		for _, v8 in ipairs(tbl13.list) do
			local flag2 = v8.lvlReq <= v7

			if flag2 then
				flag2 = not (tbl4.skipBoss and v8.boss)
			end

			if flag2 then
				flag2 = not (v8.misc and v8.exp <= 0)
			end

			if flag2 then
				if not (lvlReq and v8.lvlReq < lvlReq - n12) then
					local v9 = fn49(v8)

					if v9 then
						lvlReq = lvlReq or v8.lvlReq
						tbl15[#tbl15 + 1] = { q = v8, d = v9 }
					end

					continue
				end
			else
				continue
			end

			break
		end

		local v8 = nil
		local q = nil

		for _, v9 in ipairs(tbl15) do
			local n13 = 1 + v9.d / 3000
			local n14 = v9.q.exp / math.max(v9.q.amount, 1) / n13

			if not v8 or n14 > v8 then
				q = v9.q
				v8 = n14
			end
		end

		return q
	end
end

tbl5.boss = { at = 0, set = {} }

tbl5.bossModels = function()
	local at = tbl5.boss.at
	if os.clock() - at < 2 then
		return tbl5.boss.set
	end
	tbl5.boss.at = os.clock()
	local set = {}

	pcall(function()
		local replication = v6:FindFirstChild("Replication")
		replication = replication and replication:FindFirstChild("Bosses")
		if not replication then
			return
		end

		for _, child in ipairs(replication:GetChildren()) do
			local value = child:IsA("ObjectValue") and child.Value or nil
			value = value and value.Parent

			if value then
				set[value] = true
			end
		end
	end)

	tbl5.boss.set = set
	return set
end

tbl5.isBoss = function(arg)
	return tbl5.bossModels()[arg] == true
end

local fn49

local function fn50(arg)
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	if not character then
		return {}, {}
	end
	local tbl15 = {}
	local tbl16 = {}

	for _, child in ipairs(workspace.NPCs:GetChildren()) do
		if (arg == nil or child.Name == arg) and child:FindFirstChild("Head") then
			local humanoid = child:FindFirstChildOfClass("Humanoid")
			local info = child:FindFirstChild("Info")
			local hostile = info and info:FindFirstChild("Hostile")
			local flag2 = arg ~= nil or hostile and hostile.Value == true
			local v7 = tbl4.bad[child]

			if v7 and os.clock() < v7 then
				flag2 = false
			end

			if tbl4.skipBoss and tbl5.isBoss(child) then
				flag2 = false
			end

			if humanoid and humanoid.Health > 0 and flag2 then
				local position = character.Position
				local tbl17 = { mob = child, dist = (child:GetPivot().Position - position).Magnitude }
				info = info and info:FindFirstChild("Target")

				if info and info:IsA("ObjectValue") and info.Value == character then
					tbl15[#tbl15 + 1] = tbl17
				else
					tbl16[#tbl16 + 1] = tbl17
				end
			end
		end
	end

	local function fn51(arg2, arg3)
		return arg2.dist < arg3.dist
	end

	table.sort(tbl15, fn51)
	table.sort(tbl16, fn51)
	return tbl15, tbl16
end

fn49 = function(arg)
	local v7, v8 = fn50(arg)
	local v9 = v7[1] or v8[1]
	return v9 and v9.mob or nil
end

local fn51

fn51 = function()
	return not tbl4.on or tbl8.flagged
end

local fn52

fn52 = function(arg)
	local character = localPlayer.Character
	local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
	local position = arg.Position
	local vector = humanoidRootPart and Vector3.new(humanoidRootPart.Position.X - position.X, 0, humanoidRootPart.Position.Z - position.Z) or Vector3.new(0, 0, 1)

	if vector.Magnitude < 0.5 then
		vector = Vector3.new(0, 0, 1)
	end

	local onHeadHover = tbl5.onHeadHover and tbl5.onHeadHover(arg)
	local onHeadStandoff = onHeadHover and tbl5.ON_HEAD_STANDOFF or math.clamp(tbl4.reach * 0.45, 2, 12)

	if not onHeadHover then
		onHeadHover = math.min(tbl4.hoverY, tbl5.maxHover() or tbl4.hoverY)
	end

	local n11 = position + vector.Unit * onHeadStandoff
	local y = position.Y
	return fn25(n11 + Vector3.new(0, onHeadHover, 0), y)
end

tbl5.spawnEvent = v6:FindFirstChild("Events") and v6.Events:FindFirstChild("SetSpawn")

tbl5.currentSpawn = function()
	local v7 = fn42()
	local spawnPoint = v7 and v7:FindFirstChild("Stats") and v7.Stats:FindFirstChild("SpawnPoint")
	return spawnPoint and spawnPoint.Value or nil
end

tbl5.islandNear = function(arg, arg2)
	local islands = workspace:FindFirstChild("Islands")
	if not (islands and arg) then
		return nil, nil
	end
	local flag2 = nil
	local name = nil
	local v7 = nil

	for _, child in ipairs(islands:GetChildren()) do
		local spawnPoint = child:FindFirstChild("SpawnPoint")

		if spawnPoint and spawnPoint:IsA("BasePart") then
			local magnitude = (spawnPoint.Position - arg).Magnitude

			if not flag2 or magnitude < flag2 then
				name = child.Name
				flag2 = magnitude
				v7 = spawnPoint
			end
		end
	end

	if flag2 then
		flag2 = flag2 <= (arg2 or 1200)
	end

	if flag2 then
		return name, v7
	end
	return nil, nil
end

tbl5.islandAt = function(arg)
	local islands = workspace:FindFirstChild("Islands")
	if not (islands and arg) then
		return nil
	end
	local v7 = nil
	local name = nil

	for _, child in ipairs(islands:GetChildren()) do
		local attribute = child:GetAttribute("islandCFrame")
		local attribute2 = child:GetAttribute("islandSize")

		if typeof(attribute) == "CFrame" and typeof(attribute2) == "Vector3" then
			local v8 = attribute:PointToObjectSpace(arg)
			local n11 = attribute2.X * 0.5
			local flag2 = math.abs(v8.X) <= n11

			if flag2 then
				local n12 = attribute2.Y * 0.5
				flag2 = math.abs(v8.Y) <= n12
			end

			if flag2 then
				local n12 = attribute2.Z * 0.5
				flag2 = math.abs(v8.Z) <= n12
			end

			if flag2 then
				local n12 = attribute2.X * attribute2.Y * attribute2.Z

				if not v7 or n12 < v7 then
					name = child.Name
					v7 = n12
				end
			end
		end
	end

	return name
end

do
	local n11 = 90
	local n12 = 60
	local n13 = 15

	local tbl15 = {
		["Land of the Sky"] = { 3158, 1862, -10008, 4633, 1198, 4976 },
		["Coco Island"] = { -3069, -18, -11790, 379, 270, 326 },
		["Sphinx Island"] = { -4080, 18, -9122, 960, 614, 1050 },
		Colosseum = { -2023, 40, -7896, 784, 303, 877 },
		["Fishman Island"] = { 8117, -2239, -17723, 2797, 2048, 2797 },
		["Gravito's Fort"] = { 315, 57, -11883, 1205, 682, 1234 },
		["Fishman Cave"] = { 1836, -14, -12258, 173, 180, 189 },
		["Island Of Zou"] = { -3568, 58, -5255, 1415, 378, 1415 },
		["Kori Island"] = { -4266, 40, -2976, 646, 331, 551 },
		["???? Shrine"] = { -7348, -36, -14949, 48, 132, 26 },
		["Shell's Town"] = { -1238, 80, -5484, 1196, 364, 1140 },
		["Marine Fort F-1"] = { 455, -10, -4463, 523, 185, 518 },
		["Mysterious Cliff"] = { 83, 160, -8302, 498, 546, 498 },
		["Orange Town"] = { -4623, -109, -6642, 916, 322, 938 },
		["Restaurant Baratie"] = { -2973, 85, -6785, 243, 234, 245 },
		["Reverse Mountain"] = { -9148, 805, -8397, 3005, 2382, 4428 },
		["Roca Island"] = { 1792, -33, -6464, 1062, 477, 1007 },
		Sandora = { -1810, 15, -3352, 700, 232, 748 },
		["Shark Park"] = { -1753, 0, -10277, 1073, 342, 921 },
		["Town of Beginnings"] = { -522, -6, -3396, 619, 187, 733 },
		["Marine Base G-1"] = { -6037, 269, -11329, 1341, 1704, 1806 },
		["Logue Town"] = { -6837, -35, -7643, 862, 426, 839 },
		["A rock"] = { 2539, -54, -8366, 33, 117, 37 },
	}

	tbl5.nav = { discs = {}, box = {}, at = 0 }

	tbl5.islandDiscs = function()
		local at = tbl5.nav.at
		if os.clock() - at < n13 and #tbl5.nav.discs > 0 then
			return tbl5.nav.discs
		end
		tbl5.nav.at = os.clock()

		if not next(tbl5.nav.box) and tbl5.whichSea() == 1 then
			for k, v7 in pairs(tbl15) do
				tbl5.nav.box[k] = { cx = v7[1], cy = v7[2], cz = v7[3], sx = v7[4], sy = v7[5], sz = v7[6] }
			end
		end

		local islands = workspace:FindFirstChild("Islands")

		if islands then
			for _, child in ipairs(islands:GetChildren()) do
				if child:IsA("Model") then
					local attribute = child:GetAttribute("islandPosition")
					local attribute2 = child:GetAttribute("islandSize")
					local attribute3 = child:GetAttribute("islandCFrame")

					if typeof(attribute) == "Vector3" and typeof(attribute2) == "Vector3" and attribute2.X > 1 and attribute2.Z > 1 then
						tbl5.nav.box[child.Name] = {
							cx = attribute.X,
							cy = attribute.Y,
							cz = attribute.Z,
							sx = attribute2.X,
							sy = attribute2.Y,
							sz = attribute2.Z,
							cf = typeof(attribute3) == "CFrame" and attribute3 or nil,
						}
					else
						local ok, result, result2 = pcall(child.GetBoundingBox, child)

						if ok and typeof(result) == "CFrame" and typeof(result2) == "Vector3" and result2.X > 1 and result2.Z > 1 then
							tbl5.nav.box[child.Name] = {
								cx = result.X,
								cy = result.Y,
								cz = result.Z,
								sx = result2.X,
								sy = result2.Y,
								sz = result2.Z,
								cf = result,
							}
						end
					end
				end
			end
		end

		local n14 = fn22() or 0
		local discs = {}
		local rects = {}

		for k, v7 in pairs(tbl5.nav.box) do
			local v8, v9, v10, v11, v12 = tbl5.footprint(v7)
			local n15 = v7.cy + v12

			if n15 >= n14 and v7.cy - v12 <= n14 + n12 then
				discs[#discs + 1] = { name = k, x = v7.cx, z = v7.cz, r = math.max(v10, v11) }

				rects[#rects + 1] = {
					name = k,
					x = v7.cx,
					z = v7.cz,
					ux = v8,
					uz = v9,
					hu = v10,
					hv = v11,
					top = n15,
					R = math.sqrt(v10 * v10 + v11 * v11),
				}
			end
		end

		local nav = tbl5.nav
		tbl5.nav.discs = discs
		nav.rects = rects
		return discs
	end

	tbl5.islandRects = function()
		tbl5.islandDiscs()
		return tbl5.nav.rects or {}
	end

	tbl5.footprint = function(arg)
		local cf = arg.cf
		if not cf then
			return 1, 0, arg.sx * 0.5, arg.sz * 0.5, arg.sy * 0.5
		end
		local tbl16 = { cf.RightVector, cf.UpVector, cf.LookVector }
		local tbl17 = { arg.sx, arg.sy, arg.sz }
		local n14 = 1

		for i = 2, 3 do
			local n15 = math.abs(tbl16[i].Y)

			if math.abs(tbl16[n14].Y) < n15 then
				n14 = i
			end
		end

		local n15 = n14 == 1 and 2 or 1
		local x = tbl16[n15].X
		local z = tbl16[n15].Z
		local v7 = math.sqrt(x * x + z * z)
		local n16, n17

		if v7 < 0.001 then
			n16 = 1
			n17 = 0
		else
			n16 = x / v7
			n17 = z / v7
		end

		local n18 = 0
		local n19 = 0
		local n20 = 0

		for i = 1, 3 do
			local v8 = tbl16[i]
			local n21 = tbl17[i] * 0.5
			n18 += math.abs(v8.X * n16 + v8.Z * n17) * n21
			n19 += math.abs(v8.Z * n16 - v8.X * n17) * n21
			n20 += math.abs(v8.Y) * n21
		end

		return n16, n17, n18, n19, n20
	end

	local function fn53(arg, arg2)
		for _, v7 in ipairs(arg) do
			local n14 = arg2.X - v7.x
			local n15 = arg2.Z - v7.z
			local n16 = v7.r + n11
			if n14 * n14 + n15 * n15 <= n16 * n16 then
				return v7
			end
		end

		return nil
	end

	tbl5.seaDetourDisc = function(arg, arg2, arg3)
		local v7 = tbl5.islandDiscs()
		if #v7 == 0 then
			return nil
		end
		local v8 = fn53(v7, arg)
		local v9 = fn53(v7, arg2)

		if arg3 and v8 and v8.name == arg3 then
			v8 = nil
		end

		local x = arg.X
		local z = arg.Z
		local n14 = arg2.X - arg.X
		local n15 = arg2.Z - arg.Z
		local n16 = n14 * n14 + n15 * n15
		if n16 < 1 then
			return nil
		end
		local v10, v11, v12 = ipairs(v7)
		local v13 = nil
		local v14 = nil
		local n17 = nil

		for _, v15 in v10, v11, v12 do
			if v15 ~= v8 and v15 ~= v9 then
				local n18 = ((v15.x - x) * n14 + (v15.z - z) * n15) / n16

				if n18 > 0 and n18 <= 1 then
					local n19 = v15.x - x + n14 * n18
					local n20 = v15.z - z + n15 * n18
					local n21 = v15.r + n11

					if n19 * n19 + n20 * n20 < n21 * n21 and (not v13 or n18 < v13) then
						n17 = n14 * (v15.z - z) - n15 * (v15.x - x) > 0 and -1

						if n17 then
							v13 = n18
							v14 = v15
						else
							n17 = 1
							v13 = n18
							v14 = v15
						end
					end
				end
			end
		end

		if not v14 then
			return nil
		end
		local n18 = 1 / math.sqrt(n16)
		local n19 = n14 * n18 * n17
		local n20 = v14.r + n11
		local n21 = v14.x + -(n15 * n18) * n17 * n20
		local name = v14.name
		return Vector3.new(n21, arg.Y, v14.z + n19 * n20), name
	end

	tbl5.NAV = {
		PAD = 45,
		ON = 15,
		EDGE = 15,
		NEAR = 40,
		STEP = 20,
		WALL = 35,
		HIGH = 80,
		RAYS = 4000,
		POPS = 80,
		SWING = 30,
		rays = 0,
	}

	tbl5.navGap = function(arg, arg2, arg3)
		local n14 = arg2 - arg.x
		local n15 = arg3 - arg.z
		local hu = arg.hu
		local n16 = math.abs(n14 * arg.ux + n15 * arg.uz) - hu
		local n17 = math.abs(n15 * arg.ux - n14 * arg.uz) - arg.hv
		if n16 <= 0 and n17 <= 0 then
			return math.max(n16, n17)
		end
		local n18 = math.max(n16, 0)
		local n19 = math.max(n17, 0)
		return math.sqrt(n18 * n18 + n19 * n19)
	end

	tbl5.navSegHit = function(arg, arg2, arg3, arg4, arg5, arg6)
		local n14 = arg4 - arg2
		local n15 = arg5 - arg3
		local n16 = n14 * n14 + n15 * n15
		local n17 = arg.x - arg2
		local n18 = arg.z - arg3
		local n19 = n16 > 0 and math.clamp((n17 * n14 + n18 * n15) / n16, 0, 1) or 0
		local n20 = n17 - n14 * n19
		local n21 = n18 - n15 * n19
		local n22 = arg.R + arg6
		if n20 * n20 + n21 * n21 > n22 * n22 then
			return false
		end
		local n23 = arg2 - arg.x
		local n24 = arg3 - arg.z
		local n25 = n23 * arg.ux + n24 * arg.uz
		local n26 = n24 * arg.ux - n23 * arg.uz
		local n27 = n14 * arg.ux + n15 * arg.uz
		local n28 = n15 * arg.ux - n14 * arg.uz
		local n29 = 0
		local n30 = 1

		for i = 1, 2 do
			local n31, v7, v8

			if i == 1 then
				n31 = arg.hu + arg6
				v7 = n25
				v8 = n27
			else
				n31 = arg.hv + arg6
				v7 = n26
				v8 = n28
			end

			if math.abs(v8) < 1e-09 then
				if n31 <= math.abs(v7) then
					return false
				end
				continue
			end

			local n32 = (-n31 - v7) / v8
			local n33 = (n31 - v7) / v8

			if not (n33 < n32) then
				local v9 = n33
				n33 = n32
				n32 = v9
			end

			if n29 < n33 then
				n29 = n33
			end

			if n32 < n30 then
				n30 = n32
			end

			if not (n30 <= n29) then
				continue
			end
			return false
		end

		return true
	end

	tbl5.navWall = function(arg, arg2, arg3, arg4, arg5, arg6)
		local nav = tbl5.NAV
		local n14 = arg3 - arg2.X
		local n15 = arg4 - arg2.Z
		local v7 = math.sqrt(n14 * n14 + n15 * n15)
		if v7 < 1 then
			return false
		end
		local n16 = n14 / v7
		local n17 = n15 / v7
		fn20()
		local n18 = arg.top + 5
		local vector = Vector3.new(0, -(n18 - arg6 + 60), 0)
		local v8 = arg5

		for i = nav.STEP, v7, nav.STEP do
			local n19 = arg2.X + n16 * i
			local n20 = arg2.Z + n17 * i
			if n11 < tbl5.navGap(arg, n19, n20) then
				break
			end
			nav.rays = nav.rays + 1
			if nav.RAYS < nav.rays then
				return true
			end
			local hit = workspace:Raycast(Vector3.new(n19, n18, n20), vector, raycastParams)
			local n21 = hit and math.max(hit.Position.Y, arg6) or arg6
			if n21 - v8 > nav.WALL or n21 > arg5 + nav.HIGH then
				return true
			end
			v8 = n21
		end

		return false
	end

	tbl5.seaDetour = function(arg, arg2, arg3)
		if not (arg and arg2) then
			return nil
		end
		local v7 = tbl5.islandRects()
		if #v7 == 0 then
			return tbl5.seaDetourDisc(arg, arg2, arg3)
		end
		local nav = tbl5.NAV
		local x = arg.X
		local z = arg.Z
		local x2 = arg2.X
		local z2 = arg2.Z
		if (x2 - x) ^ 2 + (z2 - z) ^ 2 < 1 then
			return nil
		end
		local tbl16 = {}
		local flag2 = false

		for _, v8 in ipairs(v7) do
			if n11 < tbl5.navGap(v8, x2, z2) then
				local v9 = tbl5.navGap(v8, x, z)
				local tbl17 = { r = v8, m = n11 }

				if v9 <= nav.ON or arg3 and v8.name == arg3 and v9 <= n11 then
					tbl17.home = true
					flag2 = true
				elseif v9 < n11 + nav.EDGE then
					tbl17.m = math.max(v9 - nav.EDGE, 0)
				end

				tbl16[#tbl16 + 1] = tbl17
			end
		end

		if #tbl16 == 0 then
			return nil
		end
		local n14 = fn22() or 0

		if flag2 then
			flag2 = math.max(fn21(arg) or n14, n14)
		end

		local v8 = flag2 or n14
		nav.rays = 0
		local tbl17 = { { x = x2, z = z2 } }
		local n15 = n11 + nav.PAD

		for _, v9 in ipairs(tbl16) do
			local r = v9.r

			for _, v10 in ipairs({ { 1, 1 }, { 1, -1 }, { -1, -1 }, { -1, 1 } }) do
				local n16 = v10[1] * (r.hu + n15)
				local n17 = v10[2] * (r.hv + n15)
				local n18 = r.x + n16 * r.ux - n17 * r.uz
				local n19 = r.z + n16 * r.uz + n17 * r.ux
				local flag3 = (n18 - x) ^ 2 + (n19 - z) ^ 2 > nav.NEAR * nav.NEAR

				if flag3 then
					for _, v11 in ipairs(tbl16) do
						local flag4 = v11 ~= v9

						if flag4 then
							local m = v11.m
							flag4 = tbl5.navGap(v11.r, n18, n19) < m
						end

						if flag4 then
							flag3 = false
							break
						end
					end
				end

				if flag3 then
					tbl17[#tbl17 + 1] = { x = n18, z = n19, name = r.name }
				end
			end
		end

		local function fn54(arg4, arg5, arg6, arg7, arg8)
			for _, v9 in ipairs(tbl16) do
				if v9.home and arg8 then
					if tbl5.navWall(v9.r, arg, arg6, arg7, v8, n14) then
						return false
					end
					continue
				end

				if tbl5.navSegHit(v9.r, arg4, arg5, arg6, arg7, v9.m) then
					return false
				end
			end

			return true
		end

		local function fn55(arg4, arg5)
			return math.sqrt((arg4.x - arg5.x) ^ 2 + (arg4.z - arg5.z) ^ 2)
		end

		local n16 = #tbl17
		local tbl18 = {}
		local tbl19 = {}
		local tbl20 = {}
		local tbl21 = { x = x, z = z }
		local tbl22 = {}

		for i = 1, n16 do
			tbl22[i] = i
		end

		table.sort(tbl22, function(arg4, arg5)
			local v9 = tbl17[arg4]
			local n17 = fn55(tbl21, tbl17[arg4]) + fn55(v9, tbl17[1])
			local v10 = tbl17[arg5]
			return n17 < fn55(tbl21, tbl17[arg5]) + fn55(v10, tbl17[1])
		end)

		for _, v9 in ipairs(tbl22) do
			if fn54(x, z, tbl17[v9].x, tbl17[v9].z, true) then
				tbl18[v9] = fn55(tbl21, tbl17[v9])
				tbl19[v9] = 0
			end
		end

		for i = 1, nav.POPS do
			local v9 = nil
			local v10 = nil

			for i2 = 1, n16 do
				if tbl18[i2] and not tbl20[i2] then
					local n17 = tbl18[i2] + fn55(tbl17[i2], tbl17[1])

					if not v9 or n17 < v9 then
						v9 = n17
						v10 = i2
					end
				end
			end

			if not v10 then
				break
			end

			if v10 == 1 then
				if tbl19[1] == 0 then
					return nil
				end
				local n17 = 1

				while tbl19[n17] and tbl19[n17] ~= 0 do
					n17 = tbl19[n17]
				end

				local v11 = tbl17[n17]
				local name = v11.name
				local v12 = tbl18[1]
				return Vector3.new(v11.x, arg.Y, v11.z), name, v12
			end

			tbl20[v10] = true
			local v11 = tbl17[v10]

			for i2 = 1, n16 do
				if not tbl20[i2] then
					local n17 = tbl18[v10] + fn55(v11, tbl17[i2])

					if (not tbl18[i2] or n17 < tbl18[i2]) and fn54(v11.x, v11.z, tbl17[i2].x, tbl17[i2].z, false) then
						tbl18[i2] = n17
						tbl19[i2] = v10
					end
				end
			end
		end

		return tbl5.seaDetourDisc(arg, arg2, arg3)
	end

	tbl5.navOnIsland = function(arg, arg2, arg3)
		if not (arg and arg2 and arg3) then
			return nil
		end

		for _, v7 in ipairs(tbl5.islandRects()) do
			local swing = tbl5.NAV.SWING
			local flag2 = tbl5.navGap(v7, arg.X, arg.Z) < swing and tbl5.navGap(v7, arg2.X, arg2.Z) > n11

			if flag2 then
				local on = tbl5.NAV.ON
				flag2 = tbl5.navGap(v7, arg3.X, arg3.Z) > on
			end

			if flag2 then
				return v7.name
			end
		end

		return nil
	end

	tbl5.RING = {
		RISE = 40,
		STEP = 20,
		RUN = 2,
		HOP = 40,
		MIN = 120,
		TIE = 10,
		SWEEP = 330,
		IN = 12,
		SLACK = 60,
	}

	tbl5.ringTrip = nil

	tbl5.topAt = function(arg, arg2)
		return fn21(Vector3.new(arg, 500, arg2))
	end

	tbl5.homeDisc = function(arg)
		local v7 = tbl5.islandDiscs()
		local v8 = fn53(v7, arg)
		if v8 then
			return v8
		end
		local v9, v10, v11 = ipairs(v7)
		local v12 = nil
		local v13 = nil

		for _, v14 in v9, v10, v11 do
			local n14 = arg.X - v14.x
			local n15 = arg.Z - v14.z
			local n16 = math.sqrt(n14 * n14 + n15 * n15) - v14.r + n11

			if n16 <= tbl5.RING.SLACK and (not v12 or n16 < v12) then
				v12 = n16
				v13 = v14
			end
		end

		return v13
	end

	tbl5.barrierOn = function(arg, arg2, arg3, arg4)
		local ring = tbl5.RING
		local n14 = arg2.X - arg.X
		local n15 = arg2.Z - arg.Z
		local v7 = math.sqrt(n14 * n14 + n15 * n15)
		if v7 < ring.STEP * 2 then
			return nil
		end
		local n16 = n14 / v7
		local n17 = n15 / v7
		local n18 = arg3.r + n11
		local n19 = 0
		local v8 = nil

		for i = ring.STEP, v7 - ring.STEP, ring.STEP do
			local n20 = arg.X + n16 * i
			local n21 = arg.Z + n17 * i
			local n22 = n20 - arg3.x
			local n23 = n21 - arg3.z
			local flag2 = n22 * n22 + n23 * n23 <= n18 * n18 and tbl5.topAt(n20, n21) or nil

			if flag2 and flag2 > arg4 then
				n19 += 1

				if not v8 or flag2 > v8 then
					v8 = flag2
				end

				if ring.RUN <= n19 then
					return v8
				end
				continue
			end

			n19 = 0
			v8 = nil
		end

		return nil
	end

	tbl5.landDetour = function(arg, arg2)
		if not (arg and arg2 and tbl4.avoidIslands) then
			return nil
		end
		local ring = tbl5.RING
		local n14 = fn22()
		if n14 and (fn23(arg.Y, n14) or fn23(arg2.Y, n14)) then
			return nil
		end
		local min = ring.MIN
		if Vector3.new(arg2.X - arg.X, 0, arg2.Z - arg.Z).Magnitude < min then
			return nil
		end
		local v7 = tbl5.homeDisc(arg)
		if not v7 then
			return nil
		end
		local max, y, rise, n15, flag2, n16, v8, ringTrip, flag3, at, flag4, flag5, n17, n18, v9, v10, v11, v12, v13, y2, z, n19, now, swept, n20, vector, n21, y3, z2, name

		for _, v14 in ipairs(tbl5.islandRects()) do
			if v14.name == v7.name then
				local on = tbl5.NAV.ON
				if tbl5.navGap(v14, arg.X, arg.Z) > on and tbl5.navGap(v14, arg2.X, arg2.Z) > n11 then
					tbl5.ringTrip = nil
					return nil
				end
				max = math.max
				y = fn21(arg) or arg.Y
				n14 = n14 or -math.huge
				rise = ring.RISE
				n15 = max(y, n14) + rise
				flag2 = tbl5.topAt(arg2.X, arg2.Z)
				flag2 = flag2 and flag2 > n15
				if flag2 then
					return nil
				end

				if not tbl5.barrierOn(arg, arg2, v7, n15) then
					tbl5.ringTrip = nil
					return nil
				end
				n16 = v7.r + n11 - ring.IN
				v8 = math.atan2(arg.Z - v7.z, arg.X - v7.x)
				ringTrip = tbl5.ringTrip
				flag3 = ringTrip and ringTrip.island == v7.name

				if flag3 then
					at = ringTrip.at
					flag3 = os.clock() - at < 120
				end

				flag4 = flag3 and (ringTrip.gx - arg2.X) ^ 2 + (ringTrip.gz - arg2.Z) ^ 2 < 400
				flag5 = false

				if not flag4 then
					n17 = (math.atan2(arg2.Z - v7.z, arg2.X - v7.x) - v8 + 3.1415926535897931) % 6.2831853071795862 - 3.1415926535897931
					n18 = n17 >= 0 and 1 or -1

					if math.abs(math.abs(n17) - 3.1415926535897931) < math.rad(ring.TIE) then
						v9 = math.rad(ring.HOP)
						v10, v11, v12 = ipairs({ 1, -1 })
						v13 = nil

						for _, v15 in v10, v11, v12 do
							y2 = arg.Y
							z = v7.z
							n19 = tbl5.barrierOn(arg, Vector3.new(v7.x + math.cos(v8 + v9 * v15) * n16, y2, z + math.sin(v8 + v9 * v15) * n16), v7, n15) or -math.huge
							local flag6 = not v13 or n19 < v13

							if flag6 then
								v13 = n19
								n18 = v15
							end
						end
					end

					ringTrip = {
						island = v7.name,
						gx = arg2.X,
						gz = arg2.Z,
						dir = n18,
						swept = 0,
						th = v8,
						at = os.clock(),
					}

					tbl5.ringTrip = ringTrip
					flag5 = true
				end

				ringTrip.swept = ringTrip.swept + math.abs((v8 - ringTrip.th + 3.1415926535897931) % 6.2831853071795862 - 3.1415926535897931)
				now = os.clock()
				ringTrip.th = v8
				ringTrip.at = now
				swept = ringTrip.swept
				if math.rad(ring.SWEEP) < swept then
					tbl5.ringTrip = nil
					return nil
				end
				n20 = v8 + ringTrip.dir * math.rad(ring.HOP)
				vector = Vector3.new
				n21 = v7.x + math.cos(n20) * n16
				y3 = arg.Y
				z2 = v7.z
				name = v7.name
				return vector(n21, y3, z2 + math.sin(n20) * n16), name, flag5
			end
		end

		max = math.max
		y = fn21(arg) or arg.Y
		n14 = n14 or -math.huge
		rise = ring.RISE
		n15 = max(y, n14) + rise
		flag2 = tbl5.topAt(arg2.X, arg2.Z)
		if flag2 and flag2 > n15 then
			return nil
		end

		if not tbl5.barrierOn(arg, arg2, v7, n15) then
			tbl5.ringTrip = nil
			return nil
		end
		n16 = v7.r + n11 - ring.IN
		v8 = math.atan2(arg.Z - v7.z, arg.X - v7.x)
		ringTrip = tbl5.ringTrip
		flag3 = ringTrip and ringTrip.island == v7.name

		if flag3 then
			at = ringTrip.at
			flag3 = os.clock() - at < 120
		end

		flag4 = flag3 and (ringTrip.gx - arg2.X) ^ 2 + (ringTrip.gz - arg2.Z) ^ 2 < 400
		flag5 = false

		if not flag4 then
			n17 = (math.atan2(arg2.Z - v7.z, arg2.X - v7.x) - v8 + 3.1415926535897931) % 6.2831853071795862 - 3.1415926535897931
			n18 = n17 >= 0 and 1 or -1

			if math.abs(math.abs(n17) - 3.1415926535897931) < math.rad(ring.TIE) then
				v9 = math.rad(ring.HOP)
				v10, v11, v12 = ipairs({ 1, -1 })
				v13 = nil

				for _, v14 in v10, v11, v12 do
					y2 = arg.Y
					z = v7.z
					n19 = tbl5.barrierOn(arg, Vector3.new(v7.x + math.cos(v8 + v9 * v14) * n16, y2, z + math.sin(v8 + v9 * v14) * n16), v7, n15) or -math.huge

					if not v13 or n19 < v13 then
						v13 = n19
						n18 = v14
					end
				end
			end

			ringTrip = { island = v7.name, gx = arg2.X, gz = arg2.Z, dir = n18, swept = 0, th = v8, at = os.clock() }
			tbl5.ringTrip = ringTrip
			flag5 = true
		end

		ringTrip.swept = ringTrip.swept + math.abs((v8 - ringTrip.th + 3.1415926535897931) % 6.2831853071795862 - 3.1415926535897931)
		now = os.clock()
		ringTrip.th = v8
		ringTrip.at = now
		swept = ringTrip.swept
		if math.rad(ring.SWEEP) < swept then
			tbl5.ringTrip = nil
			return nil
		end
		n20 = v8 + ringTrip.dir * math.rad(ring.HOP)
		vector = Vector3.new
		n21 = v7.x + math.cos(n20) * n16
		y3 = arg.Y
		z2 = v7.z
		name = v7.name
		return vector(n21, y3, z2 + math.sin(n20) * n16), name, flag5
	end

	tbl5.CAVE = {
		BEARINGS = 24,
		REACH = 90,
		ROOF = 150,
		ENCLOSED = 0.5,
		OPEN = 0.35,
		HOPS = 3,
		MIN_OPEN = 20,
		BACK = 5,
		LOCAL = 150,
	}

	tbl5.caveFan = function(arg)
		local cave = tbl5.CAVE
		fn20()
		local n14 = arg + Vector3.new(0, 1, 0)
		local tbl16 = {}
		local n15 = 0

		for i = 0, cave.BEARINGS - 1 do
			local n16 = i / cave.BEARINGS * 3.1415926535897931 * 2
			local vector = Vector3.new(math.sin(n16), 0, -math.cos(n16))
			local hit = workspace:Raycast(n14, vector * cave.REACH, raycastParams)
			tbl16[#tbl16 + 1] = { dir = vector, dist = hit and (hit.Position - n14).Magnitude or cave.REACH, hit = hit ~= nil }

			if hit then
				n15 += 1
			end
		end

		return n15 / cave.BEARINGS, tbl16
	end

	tbl5.caveRoofed = function(arg)
		fn20()
		return workspace:Raycast(arg + Vector3.new(0, 2, 0), Vector3.new(0, tbl5.CAVE.ROOF, 0), raycastParams) ~= nil
	end

	tbl5.caveExit = function(arg, arg2)
		local cave = tbl5.CAVE
		local v7 = fn22()

		if v7 then
			v7 = fn23(arg.Y, v7) or fn23(arg2.Y, v7)
		end

		if v7 then
			return nil
		end
		local vector = Vector3.new(arg2.X - arg.X, 0, arg2.Z - arg.Z)
		if vector.Magnitude < 30 then
			return nil
		end
		local v8 = tbl5.islandDiscs()
		local name = fn53(v8, arg)
		if name and fn53(v8, arg2) == name and vector.Magnitude <= cave.LOCAL then
			return nil
		end
		fn20()
		local unit = vector.Unit
		if not workspace:Raycast(arg + Vector3.new(0, 1, 0), unit * math.min(cave.REACH, vector.Magnitude), raycastParams) then
			return nil
		end
		local v9, v10 = tbl5.caveFan(arg)
		if v9 < cave.ENCLOSED then
			return nil
		end
		local flag2 = tbl5.caveRoofed(arg)

		if not flag2 then
			for _, v11 in ipairs(v10) do
				if v11.hit and v11.dist >= 14 and tbl5.caveRoofed(arg + v11.dir * 12) then
					flag2 = true
					break
				end
			end
		end

		if not flag2 then
			return nil
		end
		local tbl16 = {}
		local unit2 = nil

		for i = 1, cave.HOPS do
			local v11, v12 = tbl5.caveFan(arg)
			local v13 = nil
			local v14 = nil

			for _, v15 in ipairs(v12) do
				if v15.dist >= cave.MIN_OPEN then
					local reach = v15.hit and v15.dist - cave.BACK or cave.REACH
					local n14 = arg + v15.dir * reach
					local n15 = reach + (tbl5.caveRoofed(n14) and 0 or 60) + 25 * v15.dir:Dot(unit)

					if unit2 and v15.dir:Dot(unit2) < -0.5 then
						n15 -= 100
					end

					if not v13 or n15 > v14 then
						v13 = n14
						v14 = n15
					end
				end
			end

			if not v13 then
				break
			end
			tbl16[#tbl16 + 1] = v13
			local flag3 = not tbl5.caveRoofed(v13)

			if flag3 then
				local open = cave.OPEN
				flag3 = tbl5.caveFan(v13) <= open
			end

			if flag3 then
				name = name and name.name or nil
				return tbl16, name
			end
			unit2 = (v13 - arg).Unit
			arg = v13
		end

		if #tbl16 > 0 and not tbl5.caveRoofed(tbl16[#tbl16]) then
			return tbl16, name and name.name or nil
		end
		return nil
	end
end

tbl5.leaveCave = function(arg, arg2)
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	if not (character and arg) then
		return nil
	end
	local ok, result, result2 = pcall(tbl5.caveExit, character.Position, arg)
	if not (ok and result) then
		return nil
	end

	for i, v7 in ipairs(result) do
		if arg2 and arg2() then
			return nil
		end
		tbl4.status = ("Leaving the %s - out through the mouth first (%d/%d)"):format(result2 or "cave", i, #result)
		if not fn33(fn35(v7), 8, arg2) then
			return nil
		end
	end

	return result2 or ""
end

do
	local n11 = 300
	local n12 = 12
	tbl5.ROBO_MARKER_NEAR = 60

	tbl5.setSpawnHere = function(arg)
		if not (tbl4.setSpawn and tbl5.spawnEvent) then
			return false
		end
		local character = localPlayer.Character
		character = character and character:FindFirstChild("HumanoidRootPart")
		if not character then
			return false
		end
		local robo = workspace.NPCs:FindFirstChild("Robo")
		local v7, v8 = tbl5.islandNear(character.Position, 1200)
		if not v7 and not robo then
			return false
		end
		local flag2 = not robo
		if flag2 and v7 and tbl4.noRobo[v7] then
			return false
		end
		local spawnFiredAt = tbl4.spawnFiredAt

		if spawnFiredAt then
			local spawnFiredAt2 = tbl4.spawnFiredAt
			spawnFiredAt = os.clock() - spawnFiredAt2 < 30
		end

		if spawnFiredAt then
			return false
		end

		if v7 then
			local v9 = tbl4.spawnTried[v7]
			if v9 and os.clock() - v9 < n11 then
				return false
			end

			if tbl5.currentSpawn() == v7 then
				return false
			end
		end

		if flag2 and v8 then
			if (v8.Position - character.Position).Magnitude > 40 then
				tbl4.status = ("Setting spawn at %s"):format(v7 or "this island")
				fn36(v8.Position + Vector3.new(0, 3, 0), 14, arg)
			end

			local now = os.clock()

			while true do
				robo = workspace.NPCs:FindFirstChild("Robo")

				if robo then
					break
				else
					task.wait(0.3)
					if not (os.clock() - now > 20 or arg and arg()) then
						continue
					end
					break
				end
			end

			local flag3 = not robo and v7

			if flag3 then
				flag3 = not (arg and arg())
			end

			if flag3 then
				local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")

				if humanoidRootPart and v8.Parent and (v8.Position - humanoidRootPart.Position).Magnitude <= tbl5.ROBO_MARKER_NEAR then
					tbl4.noRobo[v7] = true
					tbl4.status = ("%s has no Robo - not setting spawn here"):format(v7)
				end
			end
		end

		if not robo then
			return false
		end
		local humanoidRootPart = robo:FindFirstChild("HumanoidRootPart") or robo.PrimaryPart or robo:FindFirstChild("Head")

		if humanoidRootPart and (humanoidRootPart.Position - character.Position).Magnitude > n12 then
			tbl4.status = ("Going to Robo to set spawn at %s"):format(v7 or "this island")
			fn33(humanoidRootPart.Position + Vector3.new(0, 2, 0), n12 - 3, arg)
			local humanoidRootPart2 = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart2 then
				return false
			end
			v7 = tbl5.islandNear(humanoidRootPart2.Position, 1200) or v7
			if humanoidRootPart.Parent ~= robo or (humanoidRootPart.Position - humanoidRootPart2.Position).Magnitude > n12 * 2 then
				return false
			end
		end

		local v9 = tbl5.currentSpawn()
		tbl4.spawnFiredAt = os.clock()

		pcall(function()
			tbl5.spawnEvent:FireServer(nil, robo)
		end)

		local now = os.clock()

		while true do
			task.wait(0.25)
			if not (tbl5.currentSpawn() ~= v9 or os.clock() - now > 5) then
				continue
			end
			break
		end

		local v10 = tbl5.currentSpawn()
		if v10 ~= v9 then
			tbl4.status = ("Spawn point set to %s"):format(tostring(v10))
			return true
		end

		if v7 then
			tbl4.spawnTried[v7] = os.clock()
		end

		tbl4.status = ("Could not set spawn at %s - faction-locked"):format(v7 or "this island")
		return false
	end
end

tbl5.hostileRange = function(arg)
	local info = arg:FindFirstChild("Info")
	info = info and info:FindFirstChild("HostileRange")
	return info and info.Value or 25
end

tbl5.isHostile = function(arg)
	local info = arg:FindFirstChild("Info")
	info = info and info:FindFirstChild("Hostile")
	return info and info.Value == true or false
end

tbl5.mobRoot = function(arg)
	return arg:FindFirstChild("HumanoidRootPart") or arg.PrimaryPart or arg:FindFirstChild("Head")
end

tbl5.mobAlive = function(arg)
	if not arg or not arg.Parent then
		return false
	end
	local humanoid = arg:FindFirstChildOfClass("Humanoid")
	return humanoid and humanoid.Health > 0 or false
end

tbl5.hitbox = { tool = nil, size = nil, offset = nil }

tbl5.hitBox = function()
	local character = localPlayer.Character
	if not character then
		return nil, nil
	end
	local tool = character:FindFirstChildWhichIsA("Tool")
	local str = (tool and tool.Name or "") .. "|" .. tostring(character:GetAttribute("customM1"))
	if tbl5.hitbox.tool == str and tbl5.hitbox.size then
		return tbl5.hitbox.size, tbl5.hitbox.offset, tbl5.hitbox.cd
	end
	local v7 = nil
	local v8 = nil
	local v9 = nil

	pcall(function()
		local g = getrenv and getrenv()._G
		if type(g) ~= "table" or type(g.getHitBox) ~= "function" then
			return
		end
		local n11 = type(getthreadidentity) == "function" and getthreadidentity() or 8

		if type(setthreadidentity) == "function" then
			pcall(setthreadidentity, 2)
		end

		local ok, result, result2, result3 = pcall(g.getHitBox, character)

		if type(setthreadidentity) == "function" then
			pcall(setthreadidentity, n11)
		end

		if ok and typeof(result) == "Vector3" then
			local cframe = typeof(result2) == "CFrame" and result2 or CFrame.new()
			v7 = result
			v8 = cframe

			if type(result3) == "number" and result3 > 0 then
				v9 = result3
			end
		end
	end)

	tbl5.hitbox.tool = v7 and str or nil
	local hitbox = tbl5.hitbox
	local hitbox2 = tbl5.hitbox
	tbl5.hitbox.size = v7
	hitbox.offset = v8
	hitbox2.cd = v9
	return v7, v8, v9
end

tbl5.swingTargets = function(arg)
	if not tbl4.multiHit then
		return { arg }
	end
	local character = localPlayer.Character
	local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return { arg }
	end
	local v7, v8 = tbl5.hitBox()
	if not v7 then
		return { arg }
	end
	local tbl15 = { arg }
	local tbl16 = { [arg] = true }

	pcall(function()
		local g = getrenv and getrenv()._G
		if type(g) ~= "table" or type(g.getTargetByPart) ~= "function" then
			return
		end
		local filterDescendantsInstances = {}

		if type(g.getTargets) == "function" then
			local ok, result = pcall(g.getTargets, character, nil, nil, nil, nil, true)

			if ok and type(result) == "table" then
				for _, v9 in ipairs(result) do
					if typeof(v9) == "Instance" and v9.Parent then
						filterDescendantsInstances[#filterDescendantsInstances + 1] = v9.Parent
					end
				end
			end
		end

		if #filterDescendantsInstances == 0 then
			return
		end
		local overlapParams2 = OverlapParams.new()
		overlapParams2.FilterType = Enum.RaycastFilterType.Include
		overlapParams2.FilterDescendantsInstances = filterDescendantsInstances
		overlapParams2.MaxParts = 200
		local partBoundsInBox = workspace:GetPartBoundsInBox(humanoidRootPart.CFrame * v8, v7, overlapParams2)

		for _, v9 in ipairs(partBoundsInBox) do
			if not (#tbl15 >= 6) then
				local ok, result = pcall(g.getTargetByPart, v9)
				result = ok and result or nil

				if result and result ~= character and not tbl16[result] then
					local rag = result:FindFirstChild("Rag")
					local humanoid = result:FindFirstChildOfClass("Humanoid")
					local flag2 = humanoid and humanoid.Health > 0

					if flag2 then
						flag2 = not (rag and rag.Value ~= nil)
					end

					flag2 = flag2 and not result:FindFirstChild("gripping") and result:IsDescendantOf(workspace.NPCs)

					if flag2 then
						flag2 = not (tbl4.skipBoss and tbl5.isBoss(result))
					end

					if flag2 then
						tbl16[result] = true
						tbl15[#tbl15 + 1] = result
					end
				end

				continue
			end

			break
		end
	end)

	return tbl15
end

tbl5.VERT_MARGIN = 2
tbl5.MOB_HALF = 1.1

tbl5.maxHover = function()
	local v7 = tbl5.hitBox()
	if not v7 then
		return nil
	end
	return math.max(v7.Y / 2 + tbl5.MOB_HALF - tbl5.VERT_MARGIN, 1)
end

tbl5.ON_HEAD_MOBS = { Yeti = true }
tbl5.ON_HEAD_STANDOFF = 1
tbl5.ON_HEAD_MARGIN = 0.15
tbl5.ON_HEAD_WINDOW = 1.5
tbl5.ON_HEAD_SAMPLE = 0.1
tbl5.headTops = {}

tbl5.mobTop = function(arg)
	local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return nil
	end
	local v7 = nil

	for _, descendant in ipairs(arg:GetDescendants()) do
		if descendant:IsA("BasePart") then
			local cFrame = descendant.CFrame
			local n11 = descendant.Size / 2
			local x = n11.X
			local n12 = cFrame.Y + math.abs(cFrame.RightVector.Y) * x
			local y = n11.Y
			local z = n11.Z
			local n13 = n12 + math.abs(cFrame.UpVector.Y) * y + math.abs(cFrame.LookVector.Y) * z

			if not v7 or n13 > v7 then
				v7 = n13
			end
		end
	end

	return v7 and v7 - humanoidRootPart.Position.Y or nil
end

tbl5.lowTop = function(arg)
	local now = os.clock()
	local tbl15 = tbl5.headTops[arg]

	if not tbl15 then
		for k in pairs(tbl5.headTops) do
			if not k.Parent then
				tbl5.headTops[k] = nil
			end
		end

		tbl15 = { at = -math.huge, samples = {} }
		tbl5.headTops[arg] = tbl15
	end

	if now - tbl15.at >= tbl5.ON_HEAD_SAMPLE then
		tbl15.at = now
		local v7 = tbl5.mobTop(arg)

		if v7 then
			table.insert(tbl15.samples, { now, v7 })
		end
	end

	local v7 = nil

	for i = #tbl15.samples, 1, -1 do
		local v8 = tbl15.samples[i]

		if tbl5.ON_HEAD_WINDOW < now - v8[1] then
			table.remove(tbl15.samples, i)
		elseif not v7 or v8[2] < v7 then
			v7 = v8[2]
		end
	end

	return v7
end

tbl5.onHeadHover = function(arg)
	local parent = arg and arg.Parent
	if not (parent and tbl5.ON_HEAD_MOBS[parent.Name]) then
		return nil
	end
	local v7 = tbl5.hitBox()
	if not v7 then
		return nil
	end
	local n11 = v7.Y / 2 + (tbl5.lowTop(parent) or arg.Size.Y / 2) - tbl5.ON_HEAD_MARGIN
	local n12 = n - 0.1
	local v8 = math.sqrt(math.max(n12 * n12 - tbl5.ON_HEAD_STANDOFF * tbl5.ON_HEAD_STANDOFF, 1))
	return math.max(math.min(n11, v8), 1)
end

tbl5.boxHolds = function(arg)
	local v7, v8 = tbl5.hitBox()
	local character = localPlayer.Character
	local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
	if not (v7 and humanoidRootPart and arg) then
		return true
	end
	local parent = arg.Parent

	if parent and parent:IsA("Model") then
		local ok, result = pcall(function()
			local overlapParams2 = OverlapParams.new()
			overlapParams2.FilterType = Enum.RaycastFilterType.Include
			overlapParams2.FilterDescendantsInstances = { parent }
			overlapParams2.CollisionGroup = "ALL"
			overlapParams2.MaxParts = 1
			return #workspace:GetPartBoundsInBox(humanoidRootPart.CFrame * v8, v7, overlapParams2)
		end)

		if ok then
			return result > 0
		end
	end

	local v9 = (humanoidRootPart.CFrame * v8):PointToObjectSpace(arg.Position)
	local n11 = arg.Size / 2
	local n12 = math.min(n11.X, n11.Z)
	local n13 = v7.X / 2 + n12
	local flag2 = math.abs(v9.X) <= n13

	if flag2 then
		local n14 = v7.Y / 2 + n11.Y
		flag2 = math.abs(v9.Y) <= n14
	end

	return flag2 and math.abs(v9.Z) <= v7.Z / 2 + n12
end

tbl5.gun = {
	mod = nil,
	aimAt = nil,
	conn = nil,
	spot = nil,
	spotAt = 0,
	shots = 0,
	blocked = 0,
	note = "idle",
}

tbl5.gameG = function()
	if tbl5.G then
		return tbl5.G
	end

	local ok, g = pcall(function()
		return getrenv()._G
	end)

	if ok and type(g) == "table" then
		tbl5.G = g
	end

	return tbl5.G
end

tbl5.gunModule = function()
	local gun = tbl5.gun
	if gun.mod ~= nil then
		return gun.mod or nil
	end

	local ok, result = pcall(function()
		return require(v6.Modules.GunHandle)
	end)

	gun.mod = ok and type(result) == "table" and type(result.GetEquippedGun) == "function" and result or false
	return gun.mod or nil
end

tbl5.gunEquip = function()
	local character = localPlayer.Character
	if not character then
		return nil
	end
	local gunName = tbl4.gunName
	local backpack = localPlayer:FindFirstChildOfClass("Backpack")
	local v7 = character:FindFirstChild(gunName)

	if v7 and v7:IsA("Tool") then
		if backpack then
			for _, child in ipairs(character:GetChildren()) do
				if child:IsA("Tool") and child ~= v7 then
					child.Parent = backpack
				end
			end
		end

		return v7
	end

	local unequiped = backpack and backpack:FindFirstChild("Unequiped")
	local v8 = backpack and (backpack:FindFirstChild(gunName) or unequiped and unequiped:FindFirstChild(gunName))

	if v8 and v8:IsA("Tool") then
		for _, child in ipairs(character:GetChildren()) do
			if child:IsA("Tool") then
				child.Parent = backpack
			end
		end

		v8.Parent = character
		return v8
	end

	if not tbl5.ownsItem(gunName) then
		return nil
	end

	if tbl5.itemEquiped(gunName) then
		tbl4.status = ("Waiting for the %s to replicate"):format(gunName)
		return nil
	end

	if os.clock() - (tbl5.gun.equipAt or 0) > 2 then
		tbl5.gun.equipAt = os.clock()
		tbl4.status = ("Equipping the %s from your inventory"):format(gunName)
		local events = v6:FindFirstChild("Events")
		events = events and events:FindFirstChild("Tools")

		if events then
			pcall(function()
				events:InvokeServer("equip", gunName)
			end)
		end
	end

	return nil
end

tbl5.gunHandle = function(arg)
	local gun = tbl5.gun
	if gun.obj and gun.objTool == arg and rawget(gun.obj, "Equiped") == true then
		return gun.obj
	end
	gun.obj = nil
	gun.objTool = nil
	if not (getconnections and debug and debug.getupvalue) then
		return nil
	end

	pcall(function()
		for _, v7 in ipairs(getconnections(arg.Equipped)) do
			local function_ = v7.Function

			if function_ then
				for i = 1, 24 do
					local ok, obj = pcall(debug.getupvalue, function_, i)
					local flag2 = ok and type(obj) == "table" and rawget(obj, "Anims") ~= nil

					if flag2 then
						local gunName = tbl4.gunName
						flag2 = rawget(obj, "Name") == gunName
					end

					if flag2 then
						local v8 = gun
						local v9 = arg
						gun.obj = obj
						v8.objTool = v9
						return
					end
				end
			end
		end
	end)

	return gun.obj
end

tbl5.gunObject = function()
	local v7 = tbl5.gunModule()
	if not v7 then
		return nil, "GunHandle module missing"
	end
	local character = localPlayer.Character
	if not character then
		return nil, "no character"
	end
	local v8 = tbl5.gunEquip()
	if not v8 then
		return nil, tbl5.hasGun() and "equipping the " .. tbl4.gunName .. "…" or ("no %s in your inventory"):format(tbl4.gunName)
	end

	if not character:FindFirstChild(tbl4.gunName .. "Gun") then
		return nil, "waiting for the server to hand the gun over"
	end
	local v9 = tbl5.gunHandle(v8)
	local result

	if not v9 then
		local ok

		ok, result = pcall(function()
			return v7:GetEquippedGun(character)
		end)

		if not (ok and type(result) == "table" and result.Name == tbl4.gunName) then
			result = v9
		end
	else
		result = v9
	end

	if not result then
		return nil, "cannot reach the gun object (executor lacks getconnections?)"
	end
	return result
end

tbl5.useGun = function()
	if tbl4.method ~= "Rifle" then
		return false
	end

	if tbl4.mode == "Buso Haki (Ray)" then
		return false
	end

	if tbl5.level and tbl5.level.stage == "peli" then
		return false
	end
	return tbl5.gunObject() ~= nil
end

tbl5.gunAim = function(aimAt)
	tbl5.gun.aimAt = aimAt

	if aimAt and not tbl5.gun.conn then
		tbl5.gun.conn = fn7(v2.RenderStepped, "GunAim", function()
			local aimAt2 = tbl5.gun.aimAt
			if not aimAt2 then
				return
			end
			local v7 = tbl5.gameG()

			if v7 then
				v7.MouseCF = CFrame.new(aimAt2)
			end
		end)
	end
end

tbl5.gunAimStop = function()
	tbl5.gun.aimAt = nil

	if tbl5.gun.conn then
		pcall(function()
			tbl5.gun.conn:Disconnect()
		end)

		tbl5.gun.conn = nil
	end
end

tbl5.gunRearm = function()
	local gun = tbl5.gun
	tbl5.gunAimStop()
	gun.obj = nil
	gun.objTool = nil
	gun.spot = nil
	gun.spotAt = 0
	gun.equipAt = 0
	gun.note = "re-arming after respawn"
	if tbl4.method ~= "Rifle" then
		return
	end
	local character = localPlayer.Character
	local gunArmWait = tbl4.gunArmWait
	local n11 = os.clock() + gunArmWait

	while os.clock() < n11 do
		if localPlayer.Character ~= character then
			return
		end

		if tbl5.gunObject() then
			gun.note = "ready"
			return
		end
		task.wait(0.15)
	end
end

tbl5.gunReady = function(arg)
	if tbl4.method ~= "Rifle" then
		return false
	end

	if tbl4.mode == "Buso Haki (Ray)" then
		return false
	end

	if tbl5.level and tbl5.level.stage == "peli" then
		return false
	end

	if tbl5.gunObject() then
		tbl5.gun.note = "ready"
		return true
	end

	if not tbl5.hasGun() then
		return false
	end
	local gunArmWait = tbl4.gunArmWait
	local n11 = os.clock() + gunArmWait

	while tbl4.on and os.clock() < n11 do
		if arg and arg() then
			return false
		end
		local v7, v8 = tbl5.gunObject()
		if v7 then
			tbl5.gun.note = "ready"
			return true
		end
		tbl4.status = ("Waiting for the %s - %s"):format(tbl4.gunName, v8 or "?")
		task.wait(0.1)
	end

	tbl5.gun.note = "gun never arrived - falling back to melee"
	return false
end

tbl5.gunBreached = function(arg)
	local npCs = workspace:FindFirstChild("NPCs")
	if not npCs then
		return false
	end

	for _, child in ipairs(npCs:GetChildren()) do
		local humanoid = child:FindFirstChildOfClass("Humanoid")

		if humanoid and humanoid.Health > 0 and tbl5.isHostile(child) then
			local v7 = tbl5.mobRoot(child)
			if v7 and (v7.Position - arg).Magnitude < tbl4.gunBreach then
				return true
			end
		end
	end

	return false
end

tbl5.gunSafeAt = function(arg)
	local npCs = workspace:FindFirstChild("NPCs")
	if not npCs then
		return true
	end

	for _, child in ipairs(npCs:GetChildren()) do
		local humanoid = child:FindFirstChildOfClass("Humanoid")

		if humanoid and humanoid.Health > 0 and tbl5.isHostile(child) then
			local flag2 = tbl5.mobRoot(child)

			if flag2 then
				local gunMargin = tbl4.gunMargin
				flag2 = (flag2.Position - arg).Magnitude < tbl5.hostileRange(child) + gunMargin
			end

			if flag2 then
				return false
			end
		end
	end

	return true
end

tbl5.gunSees = function(arg, arg2)
	fn20()
	local n11 = arg + Vector3.new(0, tbl4.gunEye, 0)
	local n12 = arg2 - n11
	if n12.Magnitude < 0.1 then
		return true
	end
	return workspace:Raycast(n11, n12, raycastParams) == nil
end

tbl5.gunSpot = function(arg)
	local head = arg:FindFirstChild("Head")
	local v7 = tbl5.mobRoot(arg)
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	if not (head and v7 and character) then
		return nil
	end
	fn20()
	local position = v7.Position
	local gunMargin = tbl4.gunMargin
	local n11 = math.max(tbl4.gunStandoff, tbl5.hostileRange(arg) + gunMargin)
	local n12 = -math.huge
	local v8 = nil

	for _, v9 in ipairs({ 1, 1.25, 1.55 }) do
		local n13 = n11 * v9

		if n13 <= tbl4.gunMaxRange then
			for i = 0, 15 do
				local n14 = i / 16 * 3.1415926535897931 * 2
				local n15 = position + Vector3.new(math.cos(n14) * n13, 0, math.sin(n14) * n13)
				local v10 = fn21(n15 + Vector3.new(0, 60, 0))

				if v10 then
					local vector = Vector3.new(n15.X, v10 + 3.5, n15.Z)

					if tbl5.gunSafeAt(vector) and tbl5.gunSees(vector, head.Position) then
						local n16 = (vector.Y - position.Y) * 3 - (vector - character.Position).Magnitude * 0.35

						if n16 > n12 then
							n12 = n16
							v8 = vector
						end
					end
				end
			end
		end
	end

	return v8
end

tbl5.gunPost = function(arg)
	if not tbl4.useGunPosts then
		return nil
	end
	return arg and tbl4.gunPosts[arg] or nil
end

tbl5.gunTakePost = function(arg)
	if not tbl5.useGun() then
		return false
	end
	local v7 = tbl5.gunPost(arg)
	if not v7 then
		return false
	end
	local character = localPlayer.Character
	local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return false
	end
	local magnitude = (humanoidRootPart.Position - v7).Magnitude
	if magnitude <= 8 then
		tbl5.gun.spot = v7
		return false
	end
	tbl5.gunAimStop()
	fn39()
	tbl4.status = ("Taking the %s firing post (%d studs)"):format(arg, math.floor(magnitude))
	fn36(v7 + Vector3.new(0, 3, 0), 6, fn51)
	fn40()
	return true
end

tbl5.gunFastAim = function(arg)
	local aim = arg.Anims and arg.Anims.aim
	if not aim then
		return false
	end
	local v7 = tbl5.gunModule()
	local aimTimes = v7 and v7.aimTimes and v7.aimTimes[arg.Name] or 0.3

	task.spawn(function()
		pcall(function()
			arg:Aim()
		end)
	end)

	local n11 = os.clock() + 0.4

	while os.clock() < n11 do
		if arg.IsAiming == true then
			return true
		end

		pcall(function()
			aim.TimePosition = aimTimes
		end)

		v2.RenderStepped:Wait()
	end

	pcall(function()
		aim:Stop()
	end)

	return false
end

tbl5.gunShoot = function(arg)
	local v7, v8 = tbl5.gunObject()
	if not v7 then
		return false, v8
	end
	local head = arg:FindFirstChild("Head")
	if not head then
		return false, "target has no head"
	end
	tbl5.gunAim(head.Position)

	if v7.Reloaded == false then
		if v7.Ready == false then
			if not tbl4.gunFastCycle then
				task.wait(0.05)
				return false, "reloading"
			end
			v7.Ready = true
		end

		tbl4.status = ("Reloading the %s"):format(tbl4.gunName)
		if not pcall(function()
			v7:Reload()
		end) then
			return false, "reload threw"
		end

		if v7.Reloaded == false then
			return false, "the reload was refused - you must be standing on the ground"
		end
		return false, "reloaded"
	end

	if v7.IsAiming ~= true then
		if v7.Ready ~= true then
			task.wait(0.05)
			return false, "not ready"
		end

		if tbl4.gunFastCycle then
			if not tbl5.gunFastAim(v7) then
				return false, "aim did not take"
			end
		else
			if not pcall(function()
				v7:Aim()
			end) then
				return false, "aim threw"
			end

			if v7.IsAiming ~= true then
				return false, "aim did not take"
			end
		end
	end

	if v7.Ready ~= true then
		task.wait(0.05)
		return false, "not ready"
	end
	local character = localPlayer.Character
	local hole = character and character:FindFirstChild(tbl4.gunName .. "Gun")
	hole = hole and hole:FindFirstChild("Hole")

	if hole then
		fn20()
		if workspace:Raycast(hole.Position, head.Position - hole.Position, raycastParams) then
			tbl5.gun.blocked = (tbl5.gun.blocked or 0) + 1
			return false, "muzzle blocked"
		end
	end

	tbl5.gun.blocked = 0
	local position = head.Position
	local v9 = tbl5.gameG()

	if v9 then
		v9.MouseCF = CFrame.new(position)
	end

	tbl5.gun.aimAt = position

	if tbl4.gunFastCycle then
		task.spawn(function()
			pcall(function()
				v7:Fire()
			end)
		end)

		local n11 = os.clock() + 0.5

		while v7.Reloaded ~= false and os.clock() < n11 do
			v2.Heartbeat:Wait()
		end

		if v7.Reloaded ~= false then
			return false, "fire did not take"
		end
	elseif not pcall(function()
				v7:Fire()
			end) then
		return false, "fire threw"
	end

	tbl5.gun.shots = tbl5.gun.shots + 1
	return true, "fired at the head"
end

tbl5.shootMob = function(arg, arg2)
	local mobTimeout = tbl4.mobTimeout
	local n11 = os.clock() + mobTimeout
	local humanoid = arg:FindFirstChildOfClass("Humanoid")
	local health = humanoid and humanoid.Health or nil

	local function fn53()
		local humanoid2 = arg:FindFirstChildOfClass("Humanoid")
		return health and humanoid2 and humanoid2.Health < health - 1 or false
	end

	while tbl4.on and arg.Parent and os.clock() < n11 do
		if arg2 and arg2() then
			tbl5.gunAimStop()
			fn40()
			return false
		end

		local humanoid2 = arg:FindFirstChildOfClass("Humanoid")

		if not humanoid2 or humanoid2.Health <= 0 then
			tbl5.gunAimStop()
			fn39()
			return true
		end

		local head = arg:FindFirstChild("Head")
		local v7 = tbl5.mobRoot(arg)

		if not (head and v7) then
			tbl5.gunAimStop()
			fn39()
			return false
		end

		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		character = character and character:FindFirstChildOfClass("Humanoid")

		if not (humanoidRootPart and character) or character.Health <= 0 then
			tbl5.gunAimStop()
			fn39()
			return false
		end

		if character.Health / math.max(character.MaxHealth, 1) < tbl4.retreatHP then
			tbl5.gunAimStop()
			fn39()
			return false
		end

		local gun = tbl5.gun
		local v8 = tbl5.gunPost(arg.Name)

		if v8 then
			local now = os.clock()
			gun.spot = v8
			gun.spotAt = now
		elseif not gun.spot or (gun.spot - v7.Position).Magnitude > tbl4.gunMaxRange or not tbl5.gunSees(gun.spot, head.Position) or tbl5.gunBreached(humanoidRootPart.Position) then
			local v9 = tbl5.gunSpot(arg)

			if not v9 then
				tbl5.gunAimStop()
				fn39()
				tbl4.bad[arg] = os.clock() + 20
				tbl4.status = ("No safe firing spot on %s"):format(arg.Name)
				task.wait(0.4)
				return false
			end

			local now = os.clock()
			gun.spot = v9
			gun.spotAt = now
		end

		if v8 and (v8 - v7.Position).Magnitude > tbl4.gunMaxRange then
			tbl5.gunAimStop()
			tbl4.bad[arg] = os.clock() + 10
			tbl4.status = ("%s is out of range of the post"):format(arg.Name)
			task.wait(0.3)
			return false
		end

		local magnitude = (humanoidRootPart.Position - gun.spot).Magnitude

		if magnitude > 6 then
			tbl5.gunAimStop()
			fn39()
			tbl4.status = ("Moving to a firing spot (%d studs)"):format(math.floor(magnitude))

			if not fn33(gun.spot, 5, fn51) then
				gun.spot = nil

				if not fn51() then
					if not fn53() then
						tbl4.bad[arg] = os.clock() + 20
					end

					fn40()
				end

				return false
			end

			fn40()
			task.wait(0.35)
		end

		local v9, v10 = tbl5.gunShoot(arg)
		tbl5.gun.note = v10 or "?"
		local flag2 = v10 == "muzzle blocked"

		if flag2 then
			flag2 = (tbl5.gun.blocked or 0) >= 6
		end

		if flag2 then
			tbl5.gun.blocked = 0

			if v8 then
				tbl5.gunAimStop()
				tbl4.bad[arg] = os.clock() + 15
				tbl4.status = ("%s is behind cover from the post"):format(arg.Name)
				return false
			end

			gun.spot = nil
		end

		tbl4.status = ("Shooting %s (%d%%) - %s"):format(arg.Name, math.floor(humanoid2.Health / math.max(humanoid2.MaxHealth, 1) * 100), tbl5.gun.note)
		local flag3 = not v9

		if flag3 then
			flag3 = not (tbl4.gunFastCycle and v10 == "reloaded")
		end

		if flag3 then
			task.wait(0.08)
		end
	end

	tbl5.gunAimStop()
	fn40()
	return not arg.Parent
end

local fn53

fn53 = function(arg, arg2)
	if tbl5.gunReady(fn51) then
		return tbl5.shootMob(arg, arg2)
	end
	local mobTimeout = tbl4.mobTimeout
	local n11 = os.clock() + mobTimeout
	local humanoid = arg:FindFirstChildOfClass("Humanoid")
	local health = humanoid and humanoid.Health or nil

	local function fn54()
		local humanoid2 = arg:FindFirstChildOfClass("Humanoid")
		return health and humanoid2 and humanoid2.Health < health - 1 or false
	end

	while tbl4.on and arg.Parent and os.clock() < n11 do
		if arg2 and arg2() then
			fn40()
			return false
		end
		local humanoid2 = arg:FindFirstChildOfClass("Humanoid")
		if not humanoid2 or humanoid2.Health <= 0 then
			fn39()
			return true
		end
		local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart") or arg:FindFirstChild("Head")
		if not humanoidRootPart then
			fn39()
			return false
		end
		local character = localPlayer.Character
		local humanoidRootPart2 = character and character:FindFirstChild("HumanoidRootPart")
		character = character and character:FindFirstChildOfClass("Humanoid")
		if not humanoidRootPart2 or not character or character.Health <= 0 then
			fn39()
			return false
		end
		local retreatHP = tbl4.retreatHP
		if character.Health / math.max(character.MaxHealth, 1) < retreatHP then
			fn39()
			return false
		end
		local v7 = fn52(humanoidRootPart)
		if (humanoidRootPart2.Position - v7).Magnitude > 900 then
			fn39()
			return false
		end

		if tbl4.reach < (humanoidRootPart2.Position - v7).Magnitude then
			fn39()

			if not fn33(function()
				local humanoidRootPart3 = arg:FindFirstChild("HumanoidRootPart") or arg:FindFirstChild("Head")
				return humanoidRootPart3 and fn52(humanoidRootPart3) or nil
			end, tbl4.reach * 0.6, fn51) and not fn51() then
				if not fn54() then
					tbl4.bad[arg] = os.clock() + 30
				end

				fn40()
				return false
			end
		else
			fn38(v7, humanoidRootPart.Position)
		end

		if not (tbl5.ON_HEAD_MOBS[arg.Name] and not tbl5.boxHolds(humanoidRootPart)) then
			fn14(tbl5.swingTargets(arg))
		end

		tbl4.status = ("Fighting %s (%d%%)"):format(arg.Name, math.floor(humanoid2.Health / math.max(humanoid2.MaxHealth, 1) * 100))
		task.wait(0.05)
	end

	fn40()
	return not arg.Parent
end

local fn54, fn55, fn56, fn57, fn58

local function fn59(arg, arg2)
	local v7, v8 = fn47(arg)
	if not v7 then
		return nil
	end
	fn39()
	local character = localPlayer.Character
	local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
	humanoidRootPart = humanoidRootPart and (v7 - humanoidRootPart.Position).Magnitude or 0

	if v8 or humanoidRootPart < 400 then
		tbl4.status = ("%s %s"):format(arg2, arg.giver)
	else
		tbl4.status = ("%s %s - sailing %d studs"):format(arg2, arg.giver, math.floor(humanoidRootPart))
	end

	if not fn36(v7 + Vector3.new(0, 3, 0), 8, fn51) then
		if fn51() then
			return nil
		end
	end

	return fn37({ arg.giver, arg.npc }, 15)
end

fn54 = function()
	pcall(function()
		quest:InvokeServer({ "npcChat", true })
	end)
end

fn55 = function()
	pcall(function()
		quest:InvokeServer({ "npcChat", false })
	end)
end

tbl5.PAID_QUESTS = { ["Road to Armament"] = true }

tbl5.quitQuest = function()
	if tbl5.PAID_QUESTS[fn44()] then
		return false
	end

	pcall(function()
		quest:InvokeServer({ "quit" })
	end)

	return true
end

fn56 = function()
	local character = localPlayer.Character
	if not character then
		return
	end

	for i = 1, 8 do
		local n11 = tonumber(character:GetAttribute("npcChatting")) or 0
		if n11 <= 0 then
			return
		end
		tbl4.status = ("Clearing a stuck NPC dialogue (%d)"):format(n11)
		fn55()
		task.wait(0.6)
		character = localPlayer.Character
		if not character then
			return
		end
	end
end

fn57 = function(arg)
	if not fn59(arg, "Turning in at") then
		return false
	end
	fn54()
	task.wait(0.4)

	pcall(function()
		quest:InvokeServer({ "returnitem" })
	end)

	task.wait(1)
	fn55()
	return fn44() == "None"
end

fn58 = function(arg)
	if not fn59(arg, ("Taking '%s' from"):format(arg.name)) then
		return false
	end
	fn54()
	task.wait(0.4)

	if fn44() ~= "None" then
		if not tbl5.quitQuest() then
			fn55()
			tbl4.status = ("Holding '%s' - a paid quest, not dropping it"):format(fn44())
			return false
		end

		task.wait(1.2)
	end

	pcall(function()
		quest:InvokeServer({ "takequest", arg.name })
	end)

	task.wait(1)
	fn55()
	local name = arg.name
	return fn44() == name
end

local fn60

local function fn61(arg, arg2)
	local vector = Vector3.zero
	local n11 = 0

	for _, child in ipairs(workspace.NPCs:GetChildren()) do
		local info = child:FindFirstChild("Info")
		info = info and info:FindFirstChild("Hostile")
		local humanoid = child:FindFirstChildOfClass("Humanoid")

		if humanoid and humanoid.Health > 0 and info and info:IsA("BoolValue") and info.Value == true then
			local position = child:GetPivot().Position

			if (position - arg.Position).Magnitude <= arg2 then
				vector += position
				n11 += 1
			end
		end
	end

	if n11 == 0 then
		return nil, 0
	end
	return vector / n11, n11
end

fn60 = function(arg, arg2, arg3)
	fn40()
	local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		task.wait(0.5)
		return
	end
	local v7, v8 = fn61(humanoidRootPart, 160)

	if v7 then
		local n11 = humanoidRootPart.Position - v7

		if n11.Magnitude < 1 then
			n11 = Vector3.new(0, 0, 1)
		end

		tbl4.status = ("Low HP (%d%%) - backing off from %d mob%s"):format(math.floor(arg3 * 100), v8, v8 == 1 and "" or "s")
		fn34(fn25(humanoidRootPart.Position + n11.Unit * 220, tbl9.ref(humanoidRootPart.Position)), 20, fn51)
	else
		tbl4.status = ("Recovering - %d%% HP"):format(math.floor(arg3 * 100))
		task.wait(1)
	end
end

tbl5.level = { stage = "idle", note = "", triedBuy = 0 }

tbl5.peli = function()
	local stats = fn42()
	stats = stats and stats:FindFirstChild("Stats")
	stats = stats and stats:FindFirstChild("Peli")
	return stats and tonumber(stats.Value) or 0
end

tbl5.maxPeli = function()
	if tbl5.maxPel then
		return tbl5.maxPel
	end

	local ok, maxPel = pcall(function()
		local Leveling = require(v6.Modules.Leveling)
		return type(Leveling) == "table" and tonumber(Leveling.MaxPeli) or nil
	end)

	if ok and maxPel and maxPel > 0 then
		tbl5.maxPel = maxPel
		return maxPel
	end
	return 1000000
end

tbl5.maxLevel = function()
	if tbl5.maxLvl then
		return tbl5.maxLvl
	end

	local ok, result = pcall(function()
		local Leveling = require(v6.Modules.Leveling)
		return type(Leveling) == "table" and tonumber(Leveling.MaxLevel) or nil
	end)

	tbl5.maxLvl = ok and result and result > 1 and result or tbl4.levelTarget
	return tbl5.maxLvl
end

local n11
n11 = 18

tbl5.shopModel = function(arg)
	local buyableItems = workspace:FindFirstChild("BuyableItems")
	if not buyableItems then
		return nil, nil, nil
	end
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	local v7 = nil
	local v8 = nil
	local v9 = nil

	for _, child in ipairs(buyableItems:GetChildren()) do
		if child.Name == arg and child:IsA("Model") then
			v7 = v7 or child
			local shopPart = child:FindFirstChild("ShopPart")

			if shopPart then
				local magnitude = character and (shopPart.Position - character.Position).Magnitude or 0

				if not v8 or magnitude < v8 then
					v7 = child
					v8 = magnitude
					v9 = child
				end
			end
		end
	end

	return v9, v7, v8
end

tbl5.gunPrice = function()
	local v7, v8 = tbl5.shopModel(tbl4.gunName)
	local info = v8 and v8:FindFirstChild("Info")
	info = info and info:FindFirstChild("Price")
	return info and tonumber(info.Value) or 300
end

tbl5.invJSON = function(arg)
	local v7 = fn42()
	local inventory = v7 and v7:FindFirstChild("Inventory")
	local v8 = inventory and inventory:FindFirstChild(arg)
	if not (v8 and type(v8.Value) == "string") then
		return nil
	end

	local ok, result = pcall(function()
		return game:GetService("HttpService"):JSONDecode(v8.Value)
	end)

	if ok and type(result) == "table" then
		return result
	end
	return nil
end

tbl5.ownsItem = function(arg)
	local Inventory = tbl5.invJSON("Inventory")
	local flag2 = Inventory ~= nil
	local flag3

	if flag2 then
		flag3 = (tonumber(Inventory[arg]) or 0) > 0
	else
		flag3 = flag2
	end

	return flag3
end

tbl5.itemEquiped = function(arg)
	local Equiped = tbl5.invJSON("Equiped")
	if not Equiped then
		return false
	end

	for _, v7 in ipairs(Equiped) do
		if v7 == arg then
			return true
		end
	end

	return false
end

tbl5.hasGun = function()
	local gunName = tbl4.gunName
	local character = localPlayer.Character
	if character and character:FindFirstChild(gunName) then
		return true
	end
	local backpack = localPlayer:FindFirstChildOfClass("Backpack")
	if backpack and backpack:FindFirstChild(gunName) then
		return true
	end
	return tbl5.ownsItem(gunName)
end

tbl5.buyGun = function()
	local v7, v8 = tbl5.shopModel(tbl4.gunName)
	local shopPart = v7 or v8

	if shopPart then
		shopPart = (v7 or v8):FindFirstChild("ShopPart")
	end

	shopPart = shopPart and shopPart.Position or Vector3.new(-531.118, 5.726, -3452.102)
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	if not character then
		task.wait(0.5)
		return false
	end

	if (shopPart - character.Position).Magnitude > 9 then
		tbl4.status = ("Going to the %s shop (%d Peli in hand)"):format(tbl4.gunName, tbl5.peli())

		if not fn36(shopPart + Vector3.new(0, 3, 0), 8, fn51) then
			tbl4.status = "Could not reach the weapon shop."
			task.wait(1.5)
			return false
		end

		return false
	end

	local v9, v10, v11 = tbl5.shopModel(tbl4.gunName)

	if not v9 then
		tbl4.status = "At the shop but the stand has not streamed in yet."
		task.wait(0.8)
		return false
	end

	if v11 and v11 > n11 then
		local gunName = tbl4.gunName
		tbl4.status = ("%d studs from the %s stand - the server refuses past ~20"):format(math.floor(v11), gunName)
		task.wait(0.8)
		return false
	end

	local events = v6:FindFirstChild("Events")
	events = events and events:FindFirstChild("Shop")

	if not events then
		tbl4.status = "Shop remote missing - cannot buy."
		task.wait(2)
		return false
	end

	tbl5.level.triedBuy = tbl5.level.triedBuy + 1
	tbl4.status = ("Buying the %s for %d Peli"):format(tbl4.gunName, tbl5.gunPrice())

	local ok, result = pcall(function()
		return events:InvokeServer(v9, 1)
	end)

	task.wait(1)

	if ok and result == false and not tbl5.hasGun() then
		local gunPrice = tbl5.gunPrice
		tbl4.status = ("The shop refused the %s (%d Peli in hand, it costs %d)"):format(tbl4.gunName, tbl5.peli(), gunPrice())
	end

	return tbl5.hasGun()
end

tbl5.peliQuest = function()
	local v7 = fn43()
	local v8 = nil

	for _, v9 in ipairs(tbl13.list) do
		if v9.mob == tbl4.peliMob and not v9.boss and v9.lvlReq <= v7 then
			if not v8 or v9.lvlReq > v8.lvlReq then
				v8 = v9
			end
		end
	end

	return v8
end

tbl5.peliStep = function(arg)
	local v7 = tbl5.peli()
	local v8 = tbl5.peliQuest()

	if not v8 then
		tbl4.status = ("Peli %d/%d - no %s quest for level %d, killing them bare"):format(v7, arg, tbl4.peliMob, fn43())
		if tbl5.gunTakePost(tbl4.peliMob) then
			return
		end
		local v9 = fn49(tbl4.peliMob)

		if v9 then
			fn53(v9)
		else
			task.wait(1)
		end

		return
	end

	local v9 = fn44()

	if v9 == "None" then
		tbl4.status = ("Peli %d/%d - taking %s"):format(v7, arg, v8.name)

		if not fn58(v8) then
			task.wait(1)
		end

		return
	end

	if v9 ~= v8.name then
		tbl4.status = ("Peli %d/%d - dropping '%s' to farm %s"):format(v7, arg, v9, v8.mob)

		if not tbl5.quitQuest() then
			tbl4.status = ("Holding '%s' - a paid quest, not dropping it. Finish it first (Mode: Buso Haki (Ray))."):format(v9)
			task.wait(3)
			return
		end

		task.wait(1.2)
		return
	end

	if v8.amount <= fn45() then
		tbl4.status = ("Peli %d/%d - turning in %s"):format(v7, arg, v8.name)

		if not fn57(v8) then
			task.wait(1)
		end

		return
	end

	if tbl5.gunTakePost(v8.mob) then
		return
	end
	local v10 = fn49(v8.mob)

	if v10 then
		local amount = v8.amount
		tbl4.status = ("Peli %d/%d - %s %d/%d"):format(v7, arg, v8.mob, fn45(), amount)
		fn53(v10)
		return
	end

	tbl4.status = ("Peli %d/%d - waiting for %s to respawn"):format(v7, arg, v8.mob)
	task.wait(0.6)
end

tbl5.onFishman = function()
	local fishman = tbl5.fishman

	if fishman and type(fishman.here) == "function" then
		local ok, result = pcall(fishman.here, false)
		if ok then
			return result and true or false
		end
	end

	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	return character and character.Position.Y < -1200 or false
end

tbl5.goFishman = function()
	local fishman = tbl5.fishman

	if not (fishman and type(fishman.trip) == "function") then
		tbl4.status = "The Fishman Island trip is not available yet - open the UI once."
		task.wait(2)
		return false
	end

	if fishman.state.on then
		tbl4.status = "Fishman trip: " .. tostring(fishman.state.status)
		task.wait(0.5)
		return false
	end

	fishman.state.on = true

	fn5("LevelFishAbort", function()
		while fishman.state.on do
			if not tbl4.on or tbl8.flagged then
				fishman.state.on = false
				return
			end
			task.wait(0.25)
		end
	end)

	local ok, result = pcall(fishman.trip)
	fishman.state.on = false
	pcall(fishman.cleanup)
	tbl4.status = "Fishman trip: " .. tostring(fishman.state.status)

	if not (ok and result) then
		task.wait(1.5)
	end

	return ok and result and true or false
end

tbl5.fishStep = function()
	local v7 = fn43()
	local v8 = tbl13.byName[tbl4.fishQuest]
	local mob = v8 and v8.mob or tbl4.fishMob

	if v8 and tbl4.fishUseQuest and v7 >= v8.lvlReq then
		local v9 = fn44()

		if v9 == "None" then
			tbl4.status = ("Level %d - taking %s from %s"):format(v7, v8.name, v8.giver)

			if not fn58(v8) then
				task.wait(1)
			end

			return
		end

		local flag2 = v9 == v8.name

		if flag2 then
			local amount = v8.amount
			flag2 = fn45() >= amount
		end

		if flag2 then
			if tbl4.autoTurnIn then
				tbl4.status = ("Turning in %s"):format(v8.name)

				if not fn57(v8) then
					task.wait(1)
				end

				return
			end
		end
	end

	if tbl5.gunTakePost(mob) then
		return
	end
	local v9 = fn49(mob)

	if v9 then
		tbl4.mobSince = nil
		local flag2

		if v8 then
			local name = v8.name
			flag2 = fn44() == name
		else
			flag2 = v8
		end

		if flag2 then
			local amount = v8.amount
			flag2 = ("  [%d/%d]"):format(fn45(), amount)
		end

		flag2 = flag2 or ""
		tbl4.status = ("Level %d/%d - farming %s%s"):format(v7, tbl5.maxLevel(), mob, flag2)
		fn53(v9)
		return
	end

	tbl4.mobSince = tbl4.mobSince or os.clock()
	local mobSince = tbl4.mobSince

	if os.clock() - mobSince > 15 and v8 and not tbl5.gunPost(mob) then
		local v10, v11 = fn47(v8)
		local character = localPlayer.Character
		character = character and character:FindFirstChild("HumanoidRootPart")

		if v10 and character and not v11 and (v10 - character.Position).Magnitude > 150 then
			tbl4.status = ("No %s nearby - going back to %s"):format(mob, v8.giver)
			fn36(v10 + Vector3.new(0, 3, 0), 14, fn51)
			tbl4.mobSince = os.clock()
			return
		end
	end

	tbl4.status = ("Level %d/%d - waiting for %s to respawn"):format(v7, tbl5.maxLevel(), mob)
	task.wait(0.8)
end

tbl5.whichSea = function()
	if game.PlaceId == tbl4.firstSeaPlace then
		return 1
	end

	if game.PlaceId == tbl4.secondSeaPlace then
		return 2
	end
	return nil
end

tbl5.seaOK = function(arg)
	if not tbl4.seaGate then
		return true
	end
	local v7 = tbl5.whichSea()
	if arg == "Level (auto)" and v7 ~= 1 then
		return false, "Level (auto) is First Sea content - its quest ladder, the Peli phase and the Fishman Island leg all live there. Use it in the First Sea."
	end

	if arg == "Buso Haki (Ray)" and v7 ~= 1 then
		return false, "Ray (Busoshoku Haki) is on Kori Island, in the First Sea."
	end

	if arg == "Boss: Juzo (Sea 2)" and v7 ~= 2 then
		return false, "Juzo the Diamondback is on Turtleback Cave, in the Second Sea. Sail there first (Movement -> Travel -> Second Sea)."
	end
	return true
end

tbl5.juzoFind = function()
	local flag2 = false
	local flag3 = false
	local v7 = nil

	pcall(function()
		local replication = v6:FindFirstChild("Replication")
		replication = replication and replication:FindFirstChild("Bosses")
		if not replication then
			return
		end

		for _, child in ipairs(replication:GetChildren()) do
			local value = child:IsA("ObjectValue") and child.Value or nil
			value = value and value.Parent

			if value and value.Name == tbl4.juzoName then
				v7 = value
				flag2 = true
				return
			end

			local flag4 = not value

			if flag4 and child.Name == tbl4.juzoName then
				flag2 = true
			end

			if flag4 then
				flag3 = true
			end
		end
	end)

	if not v7 then
		local npCs = workspace:FindFirstChild("NPCs")
		npCs = npCs and npCs:FindFirstChild(tbl4.juzoName)

		if npCs then
			flag2 = true
			v7 = npCs
		end
	end

	return v7, flag2, flag3
end

tbl5.juzoDrops = function(arg)
	local tbl15 = {}

	pcall(function()
		local attribute = arg:GetAttribute("PossibleDrops")
		if type(attribute) ~= "string" then
			return
		end

		local ok, result = pcall(function()
			return game:GetService("HttpService"):JSONDecode(attribute)
		end)

		if ok and type(result) == "table" then
			for k in pairs(result) do
				tbl15[#tbl15 + 1] = k
			end
		end
	end)

	return tbl15
end

tbl5.juzoWatchDrops = function()
	if tbl5.juzo.dropConn then
		return
	end
	local playerGui = localPlayer:FindFirstChild("PlayerGui")
	local notifications = playerGui and playerGui:FindFirstChild("Notifications")
	if not notifications then
		return
	end

	tbl5.juzo.dropConn = fn7(notifications.DescendantAdded, "JuzoDrops", function(arg)
		if not arg:IsA("TextLabel") then
			return
		end

		if tbl4.mode ~= "Boss: Juzo (Sea 2)" then
			return
		end
		local lastDrop = fn2(arg.Text):gsub("<[^>]*>", ""):gsub("^%s+", ""):gsub("%s+$", "")
		if lastDrop == "" then
			return
		end
		local dropSet = tbl5.juzo.dropSet
		if not (dropSet and dropSet[lastDrop]) then
			return
		end
		tbl5.juzo.lastDrop = lastDrop

		if tbl5.notify then
			tbl5.notify("Skull Hub", ("Juzo dropped: %s"):format(lastDrop), 10)
		end

		if tbl5.wh then
			tbl5.wh.milestone("Juzo drop", ("**%s**\nAfter %d %s this session."):format(lastDrop, tbl5.juzo.kills, tbl5.juzo.kills == 1 and "kill" or "kills"))
		end
	end)
end

tbl5.juzoBusy = function(busyOf)
	local juzo = tbl5.juzo
	local busyAt = juzo.busyAt

	if busyAt then
		local busyAt2 = juzo.busyAt
		busyAt = os.clock() - busyAt2 < 0.1
	end

	if busyAt and juzo.busyOf == busyOf then
		return juzo.busyVal, juzo.busyWhy
	end
	local v7, v8 = tbl5.juzoBusyNow(busyOf)
	juzo.busyAt = os.clock()
	juzo.busyOf = busyOf
	juzo.busyVal = v7
	juzo.busyWhy = v8
	return v7, v8
end

tbl5.juzoBusyNow = function(arg)
	if arg:FindFirstChild(tbl4.juzoDashMarker, true) then
		return true, "crystal dash"
	end

	local ok, result = pcall(function()
		return arg:GetPivot().Position
	end)

	if ok and result.Y > tbl4.juzoAirY then
		return true, "airborne"
	end
	local flag2 = false

	pcall(function()
		local humanoid = arg:FindFirstChildOfClass("Humanoid")
		local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
		if not animator then
			return
		end

		for _, v7 in ipairs(animator:GetPlayingAnimationTracks()) do
			local animationId = v7.Animation and v7.Animation.AnimationId
			local v8

			if animationId then
				v8 = tbl4.juzoDangerAnims[animationId:match("%d+") or ""]
			else
				v8 = animationId
			end

			if v8 then
				flag2 = true
				return
			end
		end
	end)

	if flag2 then
		return true, "wind-up"
	end
	return false
end

tbl5.juzoDodge = function(arg, arg2)
	tbl4.status = ("Juzo: %s - backing off"):format(arg2)
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")

	local ok, result = pcall(function()
		return arg:GetPivot().Position
	end)

	local n12

	if ok and character then
		local vector = Vector3.new(character.Position.X - result.X, 0, character.Position.Z - result.Z)

		if vector.Magnitude < 1 then
			vector = Vector3.new(0, 0, 1)
		end

		n12 = result + vector.Unit * tbl4.juzoSafeRadius
	else
		n12 = tbl4.juzoSafe
	end

	local juzoArena = tbl4.juzoArena
	fn38(n12 + Vector3.new(0, tbl4.juzoDodgeHeight, 0), juzoArena)
	task.wait(tbl4.juzoDashSecs)
end

tbl5.juzo = { since = nil, kills = 0, lastModel = nil, lastDrops = nil }

local function fn62()
	local tbl15 = {}

	for _, juzoDrop in ipairs(tbl4.juzoDrops) do
		tbl15[juzoDrop] = true
	end

	return tbl15
end

tbl5.juzo.dropSet = fn62()

tbl5.juzoStep = function()
	tbl5.juzoWatchDrops()
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	if not character then
		task.wait(0.5)
		return
	end
	local v7, v8, v9 = tbl5.juzoFind()

	if not v8 then
		if v9 then
			tbl5.juzo.pendSince = tbl5.juzo.pendSince or os.clock()
			local pendSince = tbl5.juzo.pendSince

			if os.clock() - pendSince < 10 then
				tbl4.status = "A boss is spawning - waiting to see which"
				task.wait(1)
				return
			end
		else
			tbl5.juzo.pendSince = nil
		end

		if tbl5.juzo.wasUp then
			tbl5.juzo.wasUp = false
			tbl5.juzo.kills = tbl5.juzo.kills + 1

			if tbl5.wh then
				tbl5.wh.milestone("Juzo killed", ("%d this session.%s"):format(tbl5.juzo.kills, tbl5.juzo.lastDrops and "\nHis drop table: " .. tbl5.juzo.lastDrops or ""))
			end
		end

		tbl5.juzo.since = tbl5.juzo.since or os.clock()
		local since = tbl5.juzo.since
		local n12 = os.clock() - since
		fn39()

		if tbl4.juzoWait < n12 then
			tbl4.status = ("Juzo has not respawned in %d min - server may be stale."):format(math.floor(tbl4.juzoWait / 60))
		else
			tbl4.status = ("Juzo is down - waiting for the respawn (%ds, %d killed)"):format(math.floor(n12), tbl5.juzo.kills)
		end

		task.wait(2)
		return
	end

	tbl5.juzo.since = nil
	tbl5.juzo.pendSince = nil
	tbl5.juzo.wasUp = true

	if not v7 then
		tbl4.status = "Juzo is up - travelling to Turtleback Cave"
		fn39()
		fn36(tbl4.juzoArena, 40, fn51)
		return
	end

	if tbl5.juzo.lastModel ~= v7 then
		tbl5.juzo.lastModel = v7
		local v10 = tbl5.juzoDrops(v7)

		if #v10 > 0 then
			tbl5.juzo.lastDrops = table.concat(v10, ", ")
			local dropSet = {}

			for _, v11 in ipairs(v10) do
				dropSet[v11] = true
			end

			tbl5.juzo.dropSet = dropSet
		end
	end

	local humanoid = v7:FindFirstChildOfClass("Humanoid")

	if not humanoid or humanoid.Health <= 0 then
		fn39()
		task.wait(1)
		return
	end

	local magnitude = (character.Position - tbl4.juzoArena).Magnitude

	if magnitude > 1000 then
		tbl4.status = ("Juzo: %d studs out - travelling in"):format(magnitude)
		fn39()
		fn36(tbl4.juzoArena, 40, fn51)
		return
	end

	local v10, v11 = tbl5.juzoBusy(v7)
	if v10 then
		tbl5.juzoDodge(v7, v11)
		return
	end
	tbl4.status = ("Fighting Juzo (%d%%)"):format(math.floor(humanoid.Health / math.max(humanoid.MaxHealth, 1) * 100))

	fn53(v7, function()
		return (tbl5.juzoBusy(v7))
	end)
end

tbl5.merch = {
	home = nil,
	homeFail = 0,
	lastVisit = nil,
	bought = 0,
	spent = 0,
	status = "Idle",
	note = nil,
	stock = {},
	seenAt = 0,
}

do
	local n12 = 12
	local n13 = 0.5
	local n14 = 3
	local n15 = 6

	tbl5.merchGapTo = function(arg)
		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		character = character and character:FindFirstChildOfClass("Humanoid")
		if not (humanoidRootPart and humanoidRootPart.Parent and character and character.Health > 0) then
			return nil
		end
		return (humanoidRootPart.Position - arg).Magnitude
	end

	tbl5.merchInReach = function(arg, arg2)
		local v7 = tbl5.merchGapTo(arg)
		local flag2 = v7 ~= nil

		if flag2 then
			flag2 = v7 <= (arg2 or 25)
		end

		return flag2, v7
	end

	tbl5.merchApproach = function(arg, arg2)
		for i = 1, 3 do
			if arg2 and arg2() then
				return false, "stopped"
			end

			if tbl8.flagged then
				return false, "the server flagged our position - not sending"
			end
			local v7, v8 = tbl5.merchInReach(arg, 18)
			if v7 then
				return true
			end

			if not v8 then
				tbl5.merch.status = "Waiting for the character before going to the merchant…"
				task.wait(1)
			else
				tbl5.merch.status = ("Travelling to the merchant (%d studs, try %d/%d)"):format(v8, i, 3)
				fn36(arg + Vector3.new(0, 3, 0), 18, arg2)
			end

			if not tbl5.merchAt() then
				return false, "he left while we were on the way"
			end
		end

		local v7, v8 = tbl5.merchInReach(arg, 18)
		return false, v8 and ("could not reach him - stopped %d studs short"):format(v8) or "could not reach him - no character"
	end

	tbl5.merchGuider = function()
		local compassGuider = v6:FindFirstChild("CompassGuider")
		return compassGuider and compassGuider:FindFirstChild("Traveling Merchant") or nil
	end

	tbl5.merchAt = function()
		local v7 = tbl5.merchGuider()
		if not v7 or not v7:GetAttribute("isEnabled") then
			return nil
		end
		local value = v7.Value
		return typeof(value) == "Vector3" and value.Magnitude > 1 and value or nil
	end

	tbl5.merch.skyY = 600
	tbl5.merch.maxTries = 2

	tbl5.merch.skip = {
		["Land of the Sky"] = "he is on Land of the Sky - a sky island the mover cannot fly to",
		["Fishman Island"] = "he is on Fishman Island - 2,135 studs under the sea",
	}

	tbl5.islandBottom = function(arg)
		local islands = workspace:FindFirstChild("Islands")
		islands = islands and islands:FindFirstChild(arg)
		if not islands then
			return nil
		end
		local attribute = islands:GetAttribute("islandPosition")
		local attribute2 = islands:GetAttribute("islandSize")
		if typeof(attribute) ~= "Vector3" or typeof(attribute2) ~= "Vector3" then
			return nil
		end
		return attribute.Y - attribute2.Y * 0.5
	end

	tbl5.merchReachable = function(arg)
		if not arg then
			return false, "he is not in this sea right now"
		end
		local v7 = tbl5.islandAt(arg)
		local v8 = v7 and tbl5.merch.skip[v7]
		if v8 then
			return false, v8
		end
		local v9 = fn22()
		if not v9 then
			return true
		end

		if fn23(arg.Y, v9) then
			return false, ("he is %d studs under the sea - no walked route"):format(v9 - arg.Y)
		end
		local v10 = v7 and tbl5.islandBottom(v7)

		if v10 then
			if v10 > v9 then
				return false, ("%s floats %d studs above the sea - there is no route up"):format(v7, v10 - v9)
			end
			return true
		end

		if arg.Y > v9 + tbl5.merch.skyY then
			return false, ("he is %d studs up with no island under him"):format(arg.Y - v9)
		end
		return true
	end

	tbl5.merchRemote = function()
		local events = v6:FindFirstChild("Events")
		return events and events:FindFirstChild("TravelingMerchentRemote") or nil
	end

	tbl5.merchReply = function(arg)
		if not arg[1] then
			return "error: " .. tostring(arg[2]):sub(1, 120)
		end

		if arg.n < 2 then
			return "no values"
		end
		local tbl15 = {}

		for i = 2, math.min(arg.n, 5) do
			local v7 = arg[i]
			local str = tostring(v7)

			if type(v7) == "table" then
				local ok

				ok, str = pcall(function()
					return game:GetService("HttpService"):JSONEncode(v7)
				end)

				str = ok and str or "table"
			end

			tbl15[#tbl15 + 1] = str:sub(1, 80)
		end

		return table.concat(tbl15, ", ")
	end

	tbl5.merchShopInstance = function()
		local playerGui = localPlayer:FindFirstChild("PlayerGui")
		return playerGui and playerGui:FindFirstChild("MerchentShop") or nil
	end

	tbl5.merchShop = function()
		local v7 = tbl5.merchShopInstance()
		if not v7 then
			return nil
		end

		if v7:IsA("ScreenGui") and not v7.Enabled then
			return nil
		end
		return v7
	end

	tbl5.merchStock = function()
		local stock = {}
		local v7 = tbl5.merchShop()
		if not v7 then
			return stock
		end
		local attribute = v7:GetAttribute("Prices")
		if type(attribute) ~= "string" or attribute == "" then
			return stock
		end

		local ok, result = pcall(function()
			return game:GetService("HttpService"):JSONDecode(attribute)
		end)

		if not ok or type(result) ~= "table" then
			return stock
		end

		for k, v8 in pairs(result) do
			if type(k) == "string" and type(v8) == "table" then
				local num = tonumber(v8.price or v8.Price or v8.cost or v8.Cost)
				stock[k] = { remaining = tonumber(v8.remaining) or 0, price = num or tbl5.merchPriceGUI(k) }
			end
		end

		tbl5.merch.stock = stock
		return stock
	end

	tbl5.merchPriceGUI = function(arg)
		local v7 = tbl5.merchShop()
		if not v7 then
			return nil
		end

		local ok, result = pcall(function()
			local price = v7.Main.List.Redeemables:FindFirstChild(arg)
			price = price and price:FindFirstChild("Price", true)

			if price then
				local v8 = tonumber
				local str = price.Text:gsub("[^%d]", "")
				price = v8(str)
			end

			return price or nil
		end)

		return ok and result or nil
	end

	tbl5.merchDwell = function()
		local v7 = tbl5.merchShop()
		if not v7 then
			return nil
		end

		local ok, result = pcall(function()
			local match, v8 = v7.Main.List.RefreshFrame.RefreshTimer.Text:match("Refresh in: (%d+):(%d+)")
			return match and v8 and tonumber(match) * 60 + tonumber(v8) or nil
		end)

		return ok and result or nil
	end

	tbl5.merchOpen = function(arg, arg2)
		local v7 = tbl5.merchShop()
		if v7 then
			return v7
		end
		local v8 = tbl5.merchRemote()
		if not v8 then
			return nil, "TravelingMerchentRemote is missing on this build"
		end
		arg2 = arg2 or tbl5.merchAt()

		if arg2 then
			local v9, v10 = tbl5.merchInReach(arg2, 25)
			if not v9 then
				return nil, v10 and ("too far from him to talk (%d studs) - not sending"):format(v10) or "no character to talk to him with"
			end
		end

		local flag2 = nil

		for i = 1, 3 do
			if arg and arg() then
				return nil, "stopped"
			end

			if not tbl5.merchAt() then
				return nil, "he left before the shop opened"
			end

			if arg2 then
				local v9, v10 = tbl5.merchInReach(arg2, 25)
				if not v9 then
					return nil, v10 and ("too far from him to talk (%d studs) - not sending"):format(v10) or "no character to talk to him with"
				end
			end

			local v9 = table.pack(pcall(function()
				return v8:InvokeServer("OpenShop")
			end))

			local v10 = v9[1]
			local v11 = v9[2]
			flag2 = v9[3]
			local v12 = v9[4]

			if v10 and v11 == true then
				local n16 = os.clock() + 6

				while os.clock() < n16 do
					if arg and arg() then
						return nil, "stopped"
					end
					local v13 = tbl5.merchShop()
					if v13 then
						return v13
					end
					task.wait(0.15)
				end

				return nil, "he accepted but the shop panel never arrived"
			end

			local v13 = arg2 and tbl5.merchGapTo(arg2)
			flag2 = v10 and type(flag2) == "string" and flag2

			if not flag2 then
				flag2 = ("the server would not open his shop (reply: %s; %s studs from him)"):format(tbl5.merchReply(v9), v13 and tostring(math.floor(v13)) or "?")
			end

			if not (v10 and type(v12) == "number" and i ~= 3) then
				break
			end
			task.wait(math.clamp(v12, 0.5, 5))
		end

		return nil, flag2
	end

	tbl5.merch.closeWords = { "close", "exit", "leave" }

	tbl5.merchCloseButton = function(arg)
		local v7 = nil

		for _, descendant in ipairs(arg:GetDescendants()) do
			if (descendant:IsA("TextButton") or descendant:IsA("ImageButton")) and descendant.Visible then
				local str = (descendant:IsA("TextButton") and descendant.Text or ""):lower()
				local str2 = descendant.Name:lower()
				if str == "close" or str2 == "close" then
					return descendant
				end

				for _, closeWord in ipairs(tbl5.merch.closeWords) do
					if str:find(closeWord, 1, true) or str2:find(closeWord, 1, true) then
						v7 = v7 or descendant
					end
				end

				local flag2 = not v7
				local flag3

				if flag2 then
					flag3 = str == "x" or str2 == "x"
				else
					flag3 = flag2
				end

				if flag3 then
					v7 = descendant
				end
			end
		end

		return v7
	end

	tbl5.merchPressClose = function(arg)
		if tbl.getconnections then
			for _, v7 in ipairs({ "Activated", "MouseButton1Click" }) do
				local ok, result = pcall(getconnections, arg[v7])

				if ok and type(result) == "table" and #result > 0 then
					local v8, v9, v10 = ipairs(result)
					local flag2 = false

					for _, v11 in v8, v9, v10 do
						local ok2, result2 = pcall(function()
							return v11.Function
						end)

						if ok2 and type(result2) == "function" then
							task.spawn(function()
								pcall(result2)
							end)

							flag2 = true
						end
					end

					if not flag2 and tbl.firesignal then
						pcall(firesignal, arg[v7])
						flag2 = true
					end

					if flag2 then
						return true
					end
				end
			end

			return false
		end

		if not tbl.firesignal then
			return false
		end
		pcall(firesignal, arg.MouseButton1Click)
		task.wait(0.6)

		if tbl5.merchShop() then
			pcall(firesignal, arg.Activated)
		end

		return true
	end

	tbl5.merchClose = function()
		local v7 = tbl5.merchShop()
		if not v7 then
			return true
		end
		local v8 = tbl5.merchCloseButton(v7)

		if v8 and tbl5.merchPressClose(v8) then
			local n16 = os.clock() + 2

			while os.clock() < n16 do
				if not tbl5.merchShop() then
					return true
				end
				task.wait(0.1)
			end
		end

		local v9 = tbl5.merchShopInstance()

		if v9 then
			if v9:IsA("ScreenGui") then
				pcall(function()
					v9.Enabled = false
				end)
			else
				pcall(function()
					v9:Destroy()
				end)
			end

			tbl5.merch.note = v8 and "Could not press the shop's Close button - hid the panel instead." or "The shop had no Close button - hid the panel instead."
		end

		return tbl5.merchShop() == nil
	end

	tbl5.merchArm = function()
		if tbl5.merch.conn then
			return
		end
		local v7 = tbl5.merchGuider()
		if not v7 then
			return
		end

		tbl5.merch.conn = fn7(v7:GetAttributeChangedSignal("isEnabled"), "MerchWatch", function()
			if not v7:GetAttribute("isEnabled") then
				tbl5.merch.lastVisit = nil
				tbl5.merch.note = nil
				tbl5.merch.tries = 0
				tbl5.merch.visitAt = nil
			end
		end)
	end

	tbl5.merchDue = function()
		tbl5.merchArm()
		if not tbl4.merchOn then
			return false
		end

		if tbl8.flagged then
			return false
		end

		if tbl5.merchBusy() then
			return false
		end

		if not next(tbl4.merchWant) then
			return false
		end
		local v7 = tbl5.merchAt()
		if not v7 then
			return false
		end
		local v8, v9 = tbl5.merchReachable(v7)

		if not v8 then
			if tbl5.merch.note ~= v9 then
				tbl5.merch.note = v9
				tbl5.merch.status = "Skipping the merchant - " .. tostring(v9)
			end

			return false
		end

		if tbl5.merch.lastVisit and (tbl5.merch.lastVisit - v7).Magnitude < 5 then
			return false
		end
		local flag2 = tbl5.merch.visitAt and (tbl5.merch.visitAt - v7).Magnitude < 5

		if flag2 then
			flag2 = (tbl5.merch.tries or 0) >= tbl5.merch.maxTries
		end

		if flag2 then
			return false
		end
		local character = localPlayer.Character
		character = character and character:FindFirstChild("HumanoidRootPart")
		if not character then
			return false
		end

		if tbl4.merchRange < (character.Position - v7).Magnitude then
			return false
		end
		return true
	end

	tbl5.merchBusy = function()
		local busy = tbl5.merch.busy
		local flag2 = type(busy) == "number"

		if flag2 then
			flag2 = os.clock() - busy < (tbl5.merch.busyFor or 420)
		end

		return flag2
	end

	tbl5.merchGoHome = function(arg)
		local home = tbl5.merch.home
		if not home then
			return true
		end

		local function fn63()
			local character = localPlayer.Character
			character = character and character:FindFirstChild("HumanoidRootPart")
			return character and (home.Position - character.Position).Magnitude or nil
		end

		local function fn64()
			local v7 = fn63()
			if not v7 or v7 > n12 then
				return false
			end
			tbl5.merch.status = "Settling back onto the spot you left…"
			tbl5.settleOnto(home, arg, n12 * 2)
			local v8 = fn63()
			return v8 ~= nil and v8 <= n13
		end

		if fn64() then
			local merch = tbl5.merch
			tbl5.merch.home = nil
			merch.homeFail = 0
			return true
		end

		if not fn63() then
			return false
		end

		if arg and arg() then
			return false
		end
		tbl5.merch.status = "Walking back to where you were…"
		fn36(home.Position + Vector3.new(0, 3, 0), 8, arg)

		if fn64() then
			local merch = tbl5.merch
			tbl5.merch.home = nil
			merch.homeFail = 0
			return true
		end

		arg = arg and arg()
		if arg then
			return false
		end
		tbl5.merch.homeFail = (tbl5.merch.homeFail or 0) + 1

		if n14 <= tbl5.merch.homeFail then
			tbl5.merch.status = "Could not walk back - carrying on from here."

			if tbl5.wh then
				tbl5.wh.problem("Lost the spot after the merchant", "Three walks back from the Traveling Merchant failed. Carrying on from wherever the character is now.")
			end

			local merch = tbl5.merch
			tbl5.merch.home = nil
			merch.homeFail = 0
		end

		return false
	end

	tbl5.merchBuyOne = function(arg, arg2, arg3)
		local v7 = tbl5.merchRemote()
		local v8 = tbl5.merchShop()
		if not (v7 and v8) then
			return false, "shop closed"
		end
		local remaining = (tbl5.merchStock()[arg] or {}).remaining or 0
		if remaining <= 0 then
			return false, "out of stock"
		end

		if arg3 then
			local v9, v10 = tbl5.merchInReach(arg3)
			if not v9 then
				return false, v10 and ("no longer at him (%d studs)"):format(v10) or "lost the character"
			end
		end

		if not tbl5.merchAt() then
			return false, "he left mid-visit"
		end
		local attribute = v8:GetAttribute("Seed")
		local attribute2 = v8:GetAttribute("SessionKey")

		if attribute == nil or attribute2 == nil then
			local n16 = os.clock() + 3

			while (attribute == nil or attribute2 == nil) and os.clock() < n16 do
				if arg2 and arg2() then
					return false, "stopped"
				end
				task.wait(0.2)
				local v9 = tbl5.merchShop()
				if not v9 then
					return false, "shop closed"
				end
				attribute = v9:GetAttribute("Seed")
				attribute2 = v9:GetAttribute("SessionKey")
			end

			if attribute == nil then
				return false, "the shop never received its Seed - not sending"
			end

			if attribute2 == nil then
				return false, "the shop never received its SessionKey - not sending"
			end
		end

		local v9 = table.pack(pcall(function()
			return v7:InvokeServer(arg, attribute, attribute2)
		end))

		local flag2 = v9[1]
		local v10 = v9[2]
		local v11 = v9[3]
		local v12

		if type(v9[4]) == "string" then
			v12 = v9[4]
		else
			v12 = nil

			if type(v9[3]) == "string" then
				v12 = v9[3]
			end
		end

		if flag2 and v10 == false then
			arg3 = arg3 and tbl5.merchGapTo(arg3)
			local flag3 = type(v12) == "string" and v12

			if not flag3 then
				flag3 = ("the server refused the purchase (reply: %s; seed %s %s; %s studs from him)"):format(tbl5.merchReply(v9), typeof(attribute), tostring(attribute):sub(1, 24), arg3 and tostring(math.floor(arg3)) or "?")
			end

			return false, flag3
		end

		flag2 = flag2 and v10 == true
		task.wait(tbl4.merchGap)
		if flag2 and arg2 and arg2() then
			return true
		end

		if arg2 and arg2() then
			return false, "stopped"
		end

		if flag2 then
			if type(v11) == "number" then
				return true
			end
			local n16 = os.clock() + 1

			while os.clock() < n16 do
				if ((tbl5.merchStock()[arg] or {}).remaining or remaining) < remaining then
					return true
				end
				task.wait(0.2)
			end

			return true
		end

		local n16 = os.clock() + 2

		while os.clock() < n16 do
			if arg2 and arg2() then
				return false, "stopped"
			end

			if ((tbl5.merchStock()[arg] or {}).remaining or remaining) < remaining then
				return true
			end

			if not tbl5.merchShop() then
				return false, "shop closed"
			end
			task.wait(0.2)
		end

		return false, "no answer from the server and the stock did not move"
	end

	tbl5.merchRun = function(arg)
		local v7 = tbl5.merchAt()
		if not v7 and not tbl5.merch.home then
			return false
		end

		if tbl5.merchBusy() then
			return false
		end
		local home = tbl5.merch.home
		local position = v7 or home and home.Position
		position = position and tbl5.merchGapTo(position)
		local n16 = 360

		if position then
			local magnitude

			if v7 and home then
				magnitude = (v7 - home.Position).Magnitude
			else
				magnitude = 0

				if v7 then
					magnitude = position
				end
			end

			n16 = math.max(360, (position + magnitude) * 1.5 / fn28() + 120)
		end

		tbl5.merch.busy = os.clock()
		tbl5.merch.busyFor = n16 + 60
		local flag2 = false
		local n17 = os.clock() + n16
		local v8 = arg

		local function fn63()
			if v8 and v8() then
				return true
			end

			if n17 < os.clock() then
				flag2 = true
				return true
			end
			return false
		end

		local function fn64(arg2)
			tbl5.merch.busy = nil
			return arg2
		end

		local v9, v10 = tbl5.merchReachable(v7)

		if not v9 then
			tbl5.merch.status = "Skipping the merchant - " .. tostring(v10)
			tbl5.merch.note = v10
			tbl5.merch.lastVisit = v7

			if tbl5.merch.home then
				tbl5.merchGoHome(fn63)
			end

			return (fn64(false))
		end

		local character = localPlayer.Character
		character = character and character:FindFirstChild("HumanoidRootPart")
		if not character then
			return (fn64(false))
		end

		if tbl5.merch.home then
			local flag3 = tbl5.merch.lastVisit and (tbl5.merch.lastVisit - v7).Magnitude < 5
			local flag4 = tbl5.merch.visitAt and (tbl5.merch.visitAt - v7).Magnitude < 5

			if flag4 then
				flag4 = (tbl5.merch.tries or 0) >= tbl5.merch.maxTries
			end

			if flag3 or flag4 or not next(tbl4.merchWant) then
				tbl5.merchGoHome(fn63)
				return (fn64(false))
			end
		end

		tbl5.merch.home = tbl5.merch.home or character.CFrame

		if not (tbl5.merch.visitAt and (tbl5.merch.visitAt - v7).Magnitude < 5) then
			local merch = tbl5.merch
			tbl5.merch.visitAt = v7
			merch.tries = 0
		end

		tbl5.merch.tries = (tbl5.merch.tries or 0) + 1
		tbl5.merch.lastVisit = v7
		local v11, v12 = tbl5.merchApproach(v7, fn63)

		if not v11 then
			fn39()
			tbl5.merch.status = "Merchant: " .. tostring(v12)
			tbl5.merch.note = v12

			if v12 == "stopped" and not flag2 then
				tbl5.merch.lastVisit = nil
				tbl5.merch.tries = math.max((tbl5.merch.tries or 1) - 1, 0)
			elseif flag2 then
				tbl5.merch.status = "Merchant: gave up - the trip ran out of time"
				tbl5.merch.note = "the trip ran out of time"
			else
				local flag3 = tbl5.merchAt()

				if flag3 then
					flag3 = (tbl5.merch.tries or 1) < tbl5.merch.maxTries
				end

				if flag3 then
					tbl5.merch.lastVisit = nil
				end
			end

			tbl5.merchGoHome(fn63)
			return (fn64(false))
		end

		fn38(v7 + Vector3.new(0, 3, 0), v7)
		local n18 = os.clock() + 2

		while os.clock() < n18 do
			if not fn63() then
				local v13 = tbl5.merchGapTo(v7)
				if not (v13 and v13 <= n15) then
					task.wait(0.1)
					continue
				end
			end

			break
		end

		tbl5.merchClose()
		local v13, v14 = tbl5.merchOpen(fn63, v7)

		if not v13 then
			fn39()
			tbl5.merch.status = "Merchant: " .. tostring(v14)
			tbl5.merch.note = v14

			if (tbl5.merch.tries or 1) < tbl5.merch.maxTries and not flag2 then
				tbl5.merch.lastVisit = nil
			end

			tbl5.merchGoHome(fn63)
			return (fn64(false))
		end

		local v15 = tbl5.merchStock()
		local tbl15 = {}

		for k, v16 in pairs(v15) do
			local flag3 = tbl4.merchWant[k]

			if flag3 then
				flag3 = (v16.remaining or 0) > 0
			end

			if flag3 and v16.price then
				tbl15[#tbl15 + 1] = { item = k, price = v16.price, remaining = v16.remaining }
			end
		end

		table.sort(tbl15, function(arg2, arg3)
			return arg2.price < arg3.price
		end)

		local n19 = 0
		local n20 = 0

		for _, v16 in ipairs(tbl15) do
			if not fn63() then
				if tbl8.flagged then
					tbl5.merch.note = "the server flagged our position - stopped buying"
					break
				elseif not (tbl4.merchPerVisit <= n19) then
					local n21 = 0

					while true do
						if n21 < v16.remaining and n19 < tbl4.merchPerVisit then
							if not fn63() then
								if not tbl8.flagged then
									if tbl4.merchWant[v16.item] then
										local v17 = tbl5.peli()

										if v17 - v16.price < tbl4.merchReserve then
											tbl5.merch.note = ("Out of Peli for %s (%d needed, %d spare)"):format(v16.item, v16.price, math.max(v17 - tbl4.merchReserve, 0))
											break
										else
											local v18, v19 = tbl5.merchBuyOne(v16.item, fn63, v7)

											if not v18 then
												if v19 and v19 ~= "stopped" then
													tbl5.merch.note = ("%s: %s"):format(v16.item, v19)
												end

												break
											else
												n21 += 1
												n19 += 1
												n20 += v16.price
												tbl5.merch.status = ("Bought %d x %s"):format(n21, v16.item)

												if type(tbl5.merch.onBought) == "function" then
													pcall(tbl5.merch.onBought, v16.item, v16.price)
												end

												if tbl5.wh then
													tbl5.wh.milestone("Merchant", ("Bought **%s** for %d Peli."):format(v16.item, v16.price))
												end

												continue
											end
										end
									end
								end
							end
						end

						break
					end

					continue
				end
			end

			break
		end

		tbl5.merch.bought = tbl5.merch.bought + n19
		tbl5.merch.spent = tbl5.merch.spent + n20
		tbl5.merchClose()
		fn39()

		if n19 > 0 then
			tbl5.merch.status = ("Bought %d item%s for %d Peli - heading back"):format(n19, n19 == 1 and "" or "s", n20)
		elseif #tbl15 > 0 then
			tbl5.merch.status = ("Bought nothing - %s"):format(tbl5.merch.note or "every purchase failed")

			if (tbl5.merch.tries or 1) < tbl5.merch.maxTries then
				tbl5.merch.lastVisit = nil
			end
		else
			tbl5.merch.status = "Nothing to buy here - heading back"
		end

		tbl5.merchGoHome(fn63)
		return (fn64(n19 > 0))
	end

	tbl5.geppo = { home = nil, homeFail = 0, tries = 0, failedAt = nil, status = "Idle" }

	tbl5.GEPPO = {
		PRICE = 50000,
		POS = Vector3.new(-3086.05, 94.58, -11755.55),
		TALK = 5,
		SEND = 8,
		RETRY = 600,
		TRIES = 3,
	}

	tbl5.geppoOwned = function()
		local v7 = fn42()
		local skills = v7 and v7:FindFirstChild("Skills")
		skills = skills and skills:FindFirstChild("skyWalk")
		if not skills then
			return nil
		end
		return skills.Value == true
	end

	tbl5.geppoDue = function()
		if not tbl4.geppoOn then
			return false, "off"
		end

		if tbl5.whichSea() ~= 1 then
			return false, "Yi is on Coco Island - First Sea only."
		end

		if tbl8.flagged then
			return false, "flagged this session - rejoin first."
		end
		local v7 = tbl5.geppoOwned()
		if v7 == nil then
			return false, "cannot read your skills yet."
		end

		if v7 then
			return false, "You already know Sky Walk (Geppo)."
		end
		local price = tbl5.GEPPO.PRICE
		if tbl5.peli() < price then
			return false, ("Need %d Peli, you have %d."):format(tbl5.GEPPO.PRICE, tbl5.peli())
		end

		if tbl5.geppo.tries >= tbl5.GEPPO.TRIES then
			return false, ("Gave up after %d attempts this session."):format(tbl5.geppo.tries)
		end
		local failedAt = tbl5.geppo.failedAt
		local flag2

		if failedAt then
			local retry = tbl5.GEPPO.RETRY
			flag2 = os.clock() - failedAt < retry
		else
			flag2 = failedAt
		end

		if flag2 then
			return false, ("Last attempt failed - retrying in %ds."):format(math.floor(tbl5.GEPPO.RETRY - os.clock() - failedAt))
		end
		return true
	end

	tbl5.geppoGoHome = function(arg)
		local home = tbl5.geppo.home
		if not home then
			return true
		end

		local function fn63()
			local character = localPlayer.Character
			character = character and character:FindFirstChild("HumanoidRootPart")
			return character and (home.Position - character.Position).Magnitude or nil
		end

		local function fn64()
			local v7 = fn63()
			if not v7 or v7 > n12 then
				return false
			end
			tbl5.settleOnto(home, arg, n12 * 2)
			local v8 = fn63()
			return v8 ~= nil and v8 <= n13
		end

		local flag2 = not fn64() and fn63()

		if flag2 then
			flag2 = not (arg and arg())
		end

		if flag2 then
			tbl5.geppo.status = "Walking back to where you were…"
			fn36(home.Position + Vector3.new(0, 3, 0), 8, arg)
		end

		if fn64() then
			local geppo = tbl5.geppo
			tbl5.geppo.home = nil
			geppo.homeFail = 0
			return true
		end

		arg = arg and arg()
		if arg then
			return false
		end
		tbl5.geppo.homeFail = tbl5.geppo.homeFail + 1

		if n14 <= tbl5.geppo.homeFail then
			tbl5.geppo.status = "Could not walk back - carrying on from here."
			local geppo = tbl5.geppo
			tbl5.geppo.home = nil
			geppo.homeFail = 0
		end

		return false
	end
end

tbl5.geppoRun = function(arg)
	local geppo = tbl5.GEPPO
	local geppo2 = tbl5.geppo

	if not tbl5.geppoDue() then
		if geppo2.home then
			tbl5.geppoGoHome(arg)
		end

		return false
	end

	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	if not character then
		return false
	end
	geppo2.home = geppo2.home or character.CFrame

	local function fn63(geppo3)
		fn39()
		geppo2.status = "Geppo: " .. geppo3
		geppo2.failedAt = os.clock()
		tbl5.geppoGoHome(arg)
		return false
	end

	local function fn64()
		fn39()
		geppo2.status = "Geppo: stopped"
		tbl5.geppoGoHome(arg)
		return false
	end

	fn56()
	local yi = workspace.NPCs:FindFirstChild("Yi")
	local position = yi and yi:GetPivot().Position or geppo.POS

	if (position - character.Position).Magnitude > 60 then
		geppo2.status = ("Travelling to Yi on Coco Island (%d studs)"):format(math.floor((position - character.Position).Magnitude))
		fn36(position + Vector3.new(0, 3, 0), 12, arg)
		if arg and arg() then
			return (fn64())
		end
	end

	yi = yi or fn37({ "Yi" }, 15)
	if arg and arg() then
		return (fn64())
	end
	geppo2.tries = geppo2.tries + 1
	if not yi then
		return (fn63("Yi did not load - not on Coco Island?"))
	end
	local humanoidRootPart = yi:FindFirstChild("HumanoidRootPart") or yi.PrimaryPart or yi:FindFirstChild("UpperTorso")
	if not humanoidRootPart then
		return (fn63("Yi has no body part to walk to."))
	end

	local function fn65()
		local character2 = localPlayer.Character
		character2 = character2 and character2:FindFirstChild("HumanoidRootPart")
		return character2 and (humanoidRootPart.Position - character2.Position).Magnitude or nil, character2
	end

	local v7, v8 = fn65()

	for i = 1, 3 do
		if v7 and v7 <= geppo.TALK + 1 then
			break
		end

		if arg and arg() then
			return (fn64())
		end

		if not v8 then
			task.wait(1)
		else
			geppo2.status = ("Walking up to Yi (%d studs)"):format(math.floor(v7))
			local vector = Vector3.new(v8.Position.X - humanoidRootPart.Position.X, 0, v8.Position.Z - humanoidRootPart.Position.Z)
			fn33(humanoidRootPart.Position + (vector.Magnitude > 0.1 and vector.Unit or Vector3.new(0, 0, 1)) * geppo.TALK, 2, arg)
		end

		v7, v8 = fn65()
	end

	if not v7 or v7 > geppo.SEND then
		return (fn63(v7 and ("could not reach Yi - stopped %d studs short"):format(math.floor(v7)) or "no character"))
	end

	if tbl8.flagged then
		return (fn63("the server flagged our position - not sending"))
	end
	fn38(v8.Position, humanoidRootPart.Position)
	local v9, v10 = tbl5.geppoDue()

	if not v9 then
		fn39()
		geppo2.status = "Geppo: " .. tostring(v10)
		tbl5.geppoGoHome(arg)
		return false
	end

	geppo2.status = "Talking to Yi…"
	local v11 = tbl5.peli()
	fn54()
	task.wait(2.5)
	local events = v6:FindFirstChild("Events")
	local learnStyle = events and events:FindFirstChild("learnStyle")

	if learnStyle then
		pcall(function()
			learnStyle:FireServer("skyWalkTrainer")
		end)

		local now = os.clock()

		while true do
			task.wait(0.25)
			if not (tbl5.geppoOwned() or os.clock() - now > 6) then
				continue
			end
			break
		end
	end

	task.wait(0.5)
	fn55()
	fn39()
	if not learnStyle then
		return (fn63("`Events.learnStyle` is missing - the game changed."))
	end

	if not tbl5.geppoOwned() then
		return (fn63("Yi did not teach it (nothing changed) - will retry later."))
	end
	geppo2.failedAt = nil
	geppo2.status = ("Learned Sky Walk (Geppo) for %d Peli - heading back"):format(math.max(v11 - tbl5.peli(), 0))

	if tbl5.wh then
		tbl5.wh.milestone("Geppo", "Learned **Sky Walk (Geppo)** from Yi on Coco Island.")
	end

	tbl5.geppoGoHome(arg)
	return true
end

tbl5.BUSO = {
	MODE = "Buso Haki (Ray)",
	QUEST = "Road to Armament",
	PRICE = 25000,
	RAY_POS = Vector3.new(-4244.98, 169.51, -2990.58),
	YETI_POS = Vector3.new(-4474, 56.4, -2948),
	TALK = 5,
	SEND = 9,
	TRIES = 3,
}

tbl5.buso = { paid = false, takeTries = 0, turnIns = 0, halted = nil }
tbl5.SPAWN_ISLANDS = { "Colosseum", "Fishman Cave", "Kori Island", "Marine Fort F-1", "Sandora", "Town of Beginnings" }
tbl5.CHECKPOINT = { HOME = "Kori Island", TRIES = 3, TRIPS = 40, REACH = 120 }
tbl5.checkpoint = { tries = 0, trips = 0, done = false, status = "not started" }

tbl5.checkpointIslands = function()
	local islands = workspace:FindFirstChild("Islands")
	if not islands then
		return {}
	end
	local attribute = islands:FindFirstChild(tbl5.CHECKPOINT.HOME)
	attribute = attribute and attribute:GetAttribute("islandPosition")
	if typeof(attribute) ~= "Vector3" then
		return {}
	end
	local tbl15 = {}

	for _, spawnIsland in ipairs(tbl5.SPAWN_ISLANDS) do
		if spawnIsland ~= tbl5.CHECKPOINT.HOME and not tbl4.noRobo[spawnIsland] then
			local v7 = tbl4.spawnTried[spawnIsland]

			if not v7 or os.clock() - v7 > 300 then
				local attribute2 = islands:FindFirstChild(spawnIsland)
				attribute2 = attribute2 and attribute2:GetAttribute("islandPosition")

				if typeof(attribute2) == "Vector3" then
					tbl15[#tbl15 + 1] = { name = spawnIsland, pos = attribute2, dist = (attribute2 - attribute).Magnitude }
				end
			end
		end
	end

	table.sort(tbl15, function(arg, arg2)
		return arg.dist < arg2.dist
	end)

	return tbl15
end

tbl5.checkpointSet = function()
	local v7 = tbl5.currentSpawn()
	if not v7 or v7 == tbl5.CHECKPOINT.HOME then
		return false
	end

	for _, spawnIsland in ipairs(tbl5.SPAWN_ISLANDS) do
		if v7 == spawnIsland then
			return true
		end
	end

	return false
end

tbl5.checkpointRun = function(arg)
	local checkpoint = tbl5.CHECKPOINT
	local checkpoint2 = tbl5.checkpoint

	if tbl5.checkpointSet() then
		if not checkpoint2.done then
			local status = ("spawn set to %s"):format(tostring(tbl5.currentSpawn()))
			checkpoint2.done = true
			checkpoint2.status = status
		end

		return true
	end

	if checkpoint.TRIES <= checkpoint2.tries then
		return true
	end

	if not tbl4.setSpawn then
		return true
	end
	local v7 = tbl5.checkpointIslands()

	if #v7 == 0 then
		tbl4.status = "Buso: waiting for the island list before setting a checkpoint"
		task.wait(1)
		return false
	end

	local v8 = v7[1]
	checkpoint2.status = ("going to %s (%d studs from Kori)"):format(v8.name, math.floor(v8.dist))
	tbl4.status = ("Buso: checkpoint at %s before Kori (%d/%d)"):format(v8.name, checkpoint2.tries + 1, checkpoint.TRIES)
	fn36(v8.pos, checkpoint.REACH, arg)
	if arg and arg() then
		return false
	end
	local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")

	if humanoidRootPart then
		local name = v8.name
		humanoidRootPart = tbl5.islandAt(humanoidRootPart.Position) == name or (v8.pos - humanoidRootPart.Position).Magnitude <= checkpoint.REACH * 4
	end

	if not humanoidRootPart then
		checkpoint2.trips = (checkpoint2.trips or 0) + 1

		if checkpoint.TRIPS < checkpoint2.trips then
			checkpoint2.tries = checkpoint.TRIES
			checkpoint2.status = "could not reach any Robo island - going to Kori anyway"
			tbl4.status = "Buso: could not reach a checkpoint island - going to Kori anyway."
			task.wait(2)
			return true
		end

		return false
	end

	checkpoint2.tries = checkpoint2.tries + 1

	if tbl5.setSpawnHere(arg) or tbl5.checkpointSet() then
		local status = ("spawn set to %s"):format(tostring(tbl5.currentSpawn()))
		checkpoint2.done = true
		checkpoint2.status = status
		tbl4.status = ("Buso: checkpoint set at %s"):format(tostring(tbl5.currentSpawn()))
		return true
	end

	checkpoint2.status = ("%s did not take - trying the next island"):format(v8.name)

	if checkpoint.TRIES <= checkpoint2.tries then
		checkpoint2.status = "gave up - going to Kori without a checkpoint"
		tbl4.status = "Buso: no island would take a spawn point - going to Kori anyway."
		task.wait(2)
		return true
	end

	return false
end

tbl5.busoLearned = function()
	local v7 = fn42()
	local stats = v7 and v7:FindFirstChild("Stats")
	stats = stats and stats:FindFirstChild("BusoMastery")
	if not stats then
		return nil
	end

	if (tonumber(stats.Value) or 0) > 0 then
		return true
	end
	local quest2 = v7:FindFirstChild("Quest")
	quest2 = quest2 and quest2:FindFirstChild("CompletedQuests")

	if quest2 then
		local ok, result = pcall(function()
			return game:GetService("HttpService"):JSONDecode(quest2.Value)
		end)

		if ok and type(result) == "table" then
			for _, v8 in ipairs(result) do
				if v8 == tbl5.BUSO.QUEST then
					return true
				end
			end
		end
	end

	return false
end

tbl5.busoReachRay = function(arg)
	local buso = tbl5.BUSO
	local ray = workspace.NPCs:FindFirstChild("Ray")
	local character = localPlayer.Character
	local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return nil
	end
	local position = ray and ray:GetPivot().Position or fn47(arg) or buso.RAY_POS

	if (position - humanoidRootPart.Position).Magnitude > 60 then
		tbl4.status = ("Buso: travelling to Ray on Kori Island (%d studs)"):format(math.floor((position - humanoidRootPart.Position).Magnitude))
		tbl5.useGameClimb = true
		pcall(fn36, position + Vector3.new(0, 3, 0), 12, fn51)
		tbl5.useGameClimb = false
		if fn51() then
			return nil
		end
	end

	ray = ray or fn37({ "Ray" }, 15)
	if not ray then
		tbl4.status = "Buso: Ray did not load - not on Kori Island yet?"
		return nil
	end
	local humanoidRootPart2 = ray:FindFirstChild("HumanoidRootPart") or ray.PrimaryPart or ray:FindFirstChild("UpperTorso")
	if not humanoidRootPart2 then
		return nil
	end

	local function fn63()
		local character2 = localPlayer.Character
		local humanoidRootPart3 = character2 and character2:FindFirstChild("HumanoidRootPart")
		return humanoidRootPart3 and (humanoidRootPart2.Position - humanoidRootPart3.Position).Magnitude or nil, humanoidRootPart3
	end

	local v7, v8 = fn63()

	for i = 1, 3 do
		if v7 and v7 <= buso.TALK + 1 then
			break
		end

		if fn51() then
			return nil
		end

		if not v8 then
			task.wait(1)
		else
			tbl4.status = ("Buso: walking up to Ray (%d studs)"):format(math.floor(v7))
			local vector = Vector3.new(v8.Position.X - humanoidRootPart2.Position.X, 0, v8.Position.Z - humanoidRootPart2.Position.Z)
			local unit = vector.Magnitude > 0.1 and vector.Unit or Vector3.new(0, 0, 1)
			tbl5.useGameClimb = true
			pcall(fn33, humanoidRootPart2.Position + unit * buso.TALK, 2, fn51)
			tbl5.useGameClimb = false
		end

		v7, v8 = fn63()
	end

	if not v7 or v7 > buso.SEND or tbl8.flagged then
		tbl4.status = v7 and ("Buso: could not reach Ray - stopped %d studs short"):format(math.floor(v7)) or "Buso: no character"
		return nil
	end
	return ray
end

tbl5.busoStep = function()
	local buso = tbl5.BUSO
	local buso2 = tbl5.buso
	local v7 = tbl5.busoLearned()

	if v7 == nil then
		tbl4.status = "Buso: reading your stats…"
		task.wait(1)
		return
	end

	if v7 then
		fn40()
		tbl4.status = "Busoshoku Haki is learned ✔ - nothing left to do in this mode."
		task.wait(3)
		return
	end

	if buso2.halted then
		fn40()
		tbl4.status = buso2.halted
		task.wait(3)
		return
	end

	if not tbl5.checkpointRun(fn51) then
		return
	end
	fn41()
	local v8 = tbl13.byName[buso.QUEST]

	if not v8 then
		tbl4.status = "Buso: 'Road to Armament' is not in the game's quest list - the game changed."
		task.wait(3)
		return
	end

	tbl4.quest = v8
	local v9 = fn44()

	if v9 ~= v8.name then
		if buso2.paid then
			local now = os.clock()

			while true do
				task.wait(0.5)
				if not (tbl5.busoLearned() or os.clock() - now > 10) then
					continue
				end
				break
			end

			if tbl5.busoLearned() then
				return
			end
			buso2.halted = "Buso: Ray's quest ended without Busoshoku Haki. Not paying 25,000 again automatically - switch the mode off and on to retry."
			return
		end

		local v10 = fn43()

		if v10 < v8.lvlReq then
			fn40()
			tbl4.status = ("Buso: needs level %d, you are %d."):format(v8.lvlReq, v10)
			task.wait(3)
			return
		end

		local price = buso.PRICE

		if tbl5.peli() < price then
			fn40()
			tbl4.status = ("Buso: needs %d Peli, you have %d."):format(buso.PRICE, tbl5.peli())
			task.wait(3)
			return
		end

		if v9 ~= "None" then
			tbl4.status = ("Buso: dropping '%s' to take Ray's quest"):format(v9)

			if not tbl5.quitQuest() then
				tbl4.status = ("Buso: holding '%s', a paid quest - finish it first."):format(v9)
				task.wait(3)
				return
			end

			task.wait(1.2)
			return
		end

		local questCD = localPlayer:FindFirstChild("QuestCD")

		if questCD and questCD.Value == true then
			tbl4.status = "Buso: quest cooldown - waiting"
			task.wait(1)
			return
		end

		if buso.TRIES <= buso2.takeTries then
			buso2.halted = ("Buso: Ray refused the quest %d times - stopped. Check level/Peli and switch the mode off and on to retry."):format(buso2.takeTries)
			return
		end
		fn56()
		local v11 = tbl5.busoReachRay(v8)
		if not v11 then
			task.wait(1)
			return
		end
		buso2.takeTries = buso2.takeTries + 1
		tbl4.status = "Buso: talking to Ray…"
		local v12 = tbl5.peli()
		local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")

		if humanoidRootPart then
			fn38(humanoidRootPart.Position, v11:GetPivot().Position)
		end

		fn54()
		task.wait(2.5)

		if fn44() == "None" then
			pcall(function()
				quest:InvokeServer({ "takequest", v8.name })
			end)
		end

		local now = os.clock()

		while true do
			task.wait(0.25)
			local name = v8.name
			if not (fn44() == name or os.clock() - now > 4) then
				continue
			end
			break
		end

		fn55()
		fn39()
		local name = v8.name

		if fn44() == name then
			buso2.paid = true
			buso2.takeTries = 0
			local amount = v8.amount
			local mob = v8.mob
			tbl4.status = ("Buso: took '%s' (paid %d Peli) - farming %d %s"):format(v8.name, math.max(v12 - tbl5.peli(), 0), amount, mob)

			if tbl5.wh then
				tbl5.wh.milestone("Buso Haki", ("Took **%s** from Ray - %d %s to go."):format(v8.name, v8.amount, v8.mob))
			end
		else
			tbl4.status = ("Buso: Ray did not give the quest (try %d/%d)"):format(buso2.takeTries, buso.TRIES)
			task.wait(3)
		end

		return
	end

	buso2.paid = true

	if v8.amount <= fn45() then
		if buso.TRIES <= buso2.turnIns then
			local amount = v8.amount
			local turnIns = buso2.turnIns
			buso2.halted = ("Buso: %d/%d Yetis done but the hand-in did not complete after %d tries. Talk to Ray by hand - the quest is NOT dropped."):format(fn45(), amount, turnIns)
			return
		end

		local now = os.clock()

		while true do
			task.wait(0.5)
			local v10 = tbl5.busoLearned()
			local flag2

			if v10 then
				flag2 = v10
			else
				local name = v8.name
				flag2 = fn44() ~= name
			end

			flag2 = flag2 or os.clock() - now > 3
			if not flag2 then
				continue
			end
			break
		end

		local v10 = tbl5.busoLearned()
		local flag2

		if v10 then
			flag2 = v10
		else
			local name = v8.name
			flag2 = fn44() ~= name
		end

		if flag2 then
			return
		end
		fn56()
		local v11 = tbl5.busoReachRay(v8)
		if not v11 then
			task.wait(1)
			return
		end
		buso2.turnIns = buso2.turnIns + 1
		tbl4.status = ("Buso: handing the quest in to Ray (try %d/%d)"):format(buso2.turnIns, buso.TRIES)
		local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")

		if humanoidRootPart then
			fn38(humanoidRootPart.Position, v11:GetPivot().Position)
		end

		fn54()
		task.wait(0.6)

		pcall(function()
			quest:InvokeServer({ "returnitem" })
		end)

		local now2 = os.clock()

		while true do
			task.wait(0.25)
			local flag3 = tbl5.busoLearned()

			if not flag3 then
				local name = v8.name
				flag3 = fn44() ~= name
			end

			if not (flag3 or os.clock() - now2 > 5) then
				continue
			end
			break
		end

		fn55()
		fn39()

		if tbl5.busoLearned() then
			tbl4.status = "Busoshoku Haki learned ✔"

			if tbl5.wh then
				tbl5.wh.milestone("Buso Haki", "Learned **Busoshoku Haki** from Ray.")
			end
		else
			task.wait(3)
		end

		return
	end

	local v10 = fn49(v8.mob)

	if v10 then
		tbl4.mobSince = nil
		local amount = v8.amount
		tbl4.status = ("Buso: %s %d/%d"):format(v8.mob, fn45(), amount)
		fn53(v10)
		return
	end

	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")

	if character and (buso.YETI_POS - character.Position).Magnitude > 150 then
		tbl4.status = ("Buso: going to the Yetis (%d studs)"):format(math.floor((buso.YETI_POS - character.Position).Magnitude))
		fn36(buso.YETI_POS + Vector3.new(0, 3, 0), 12, fn51)
		return
	end

	local amount = v8.amount
	tbl4.status = ("Buso: waiting for Yetis to respawn (%d/%d)"):format(fn45(), amount)
	task.wait(0.6)
end

tbl5.levelStep = function()
	local level = tbl5.level
	local v7 = fn43()

	if v7 >= tbl5.maxLevel() and not tbl4.maxLevelFarm then
		level.stage = "done"
		tbl4.status = ("Max level (%d). Nothing left to farm."):format(v7)
		task.wait(3)
		return
	end

	if tbl4.method == "Rifle" and not tbl5.hasGun() then
		local v8 = tbl5.gunPrice()

		if v8 <= tbl5.peli() then
			level.stage = "buy"
			tbl5.buyGun()
		else
			level.stage = "peli"
			tbl5.peliStep(v8)
		end

		return
	end

	if not tbl5.onFishman() then
		if tbl4.rowboatGate and tbl5.rowboatDue() then
			local n12 = tbl5.rowboatPrice() or 0

			if tbl5.peli() < n12 then
				level.stage = "peli"
				tbl5.peliStep(n12)
				return
			end

			level.stage = "rowboat"
			tbl5.buyRowboat(fn51)
			return
		end

		level.stage = "travel"
		tbl4.status = "Heading for Fishman Island…"
		tbl5.goFishman()
		return
	end

	level.stage = "farm"
	tbl5.fishStep()
end

tbl5.rowboatPrice = function()
	local Rowboat, info = tbl5.shopModel("Rowboat")
	info = info and info:FindFirstChild("Info")
	info = info and info:FindFirstChild("Price")
	return info and tonumber(info.Value) or nil
end

tbl5.ROWBOAT = { POS = Vector3.new(-530.1, 6.42, -3489.24), TRIES = 3 }
tbl5.rowboat = { tries = 0, nextAt = 0, status = "Idle" }

tbl5.rowboatOwned = function()
	local Inventory = tbl5.invJSON("Inventory")
	if not Inventory then
		return nil
	end
	return (tonumber(Inventory.Rowboat) or 0) > 0
end

tbl5.rowboatDue = function()
	if tbl5.whichSea() ~= 1 then
		return false
	end

	if tbl5.rowboatPrice() == nil then
		return false
	end

	if tbl5.rowboatOwned() ~= false then
		return false
	end

	if tbl5.ROWBOAT.TRIES <= tbl5.rowboat.tries then
		return false
	end
	local nextAt = tbl5.rowboat.nextAt
	return os.clock() >= nextAt
end

tbl5.buyRowboat = function(arg)
	local rowboat = tbl5.ROWBOAT
	local rowboat2 = tbl5.rowboat

	local function fn63(rowboat3)
		rowboat2.status = rowboat3
		tbl4.status = "Rowboat: " .. rowboat3
	end

	if tbl5.rowboatOwned() then
		fn63("owned")
		return true
	end
	local Rowboat, v7 = tbl5.shopModel("Rowboat")
	local shopPart = Rowboat or v7

	if shopPart then
		shopPart = (Rowboat or v7):FindFirstChild("ShopPart")
	end

	shopPart = shopPart and shopPart.Position or rowboat.POS
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	if not character then
		task.wait(0.5)
		return false
	end

	if (shopPart - character.Position).Magnitude > 9 then
		fn63(("going to the Rowboat stand (%d studs)"):format(math.floor((shopPart - character.Position).Magnitude)))

		if not fn36(shopPart + Vector3.new(0, 3, 0), 8, arg) then
			arg = arg and arg()

			if not arg then
				fn63("could not reach the Rowboat stand")
				task.wait(1.5)
			end

			return false
		end

		return false
	end

	local Rowboat2, v8, v9 = tbl5.shopModel("Rowboat")

	if not Rowboat2 then
		fn63("at the stand but it has not streamed in yet")
		task.wait(0.8)
		return false
	end

	if v9 and v9 > n11 then
		fn63(("%d studs from the stand - the server refuses past ~20"):format(math.floor(v9)))
		task.wait(0.8)
		return false
	end

	local info = Rowboat2:FindFirstChild("Info")
	info = info and info:FindFirstChild("Price")
	local n12 = info and tonumber(info.Value) or 0

	if tbl5.peli() < n12 then
		fn63(("need %d Peli, have %d"):format(n12, tbl5.peli()))
		task.wait(1)
		return false
	end

	local events = v6:FindFirstChild("Events")
	events = events and events:FindFirstChild("Shop")

	if not events then
		fn63("Shop remote missing - cannot buy")
		rowboat2.tries = rowboat.TRIES
		return false
	end

	if tbl8.flagged or arg and arg() then
		return false
	end
	rowboat2.tries = rowboat2.tries + 1
	fn63(("buying a Rowboat for %d Peli (try %d/%d)"):format(n12, rowboat2.tries, rowboat.TRIES))

	local ok, result = pcall(function()
		return events:InvokeServer(Rowboat2, 1)
	end)

	local now = os.clock()

	while true do
		task.wait(0.5)
		if not (tbl5.rowboatOwned() or os.clock() - now > 6) then
			continue
		end
		break
	end

	if tbl5.rowboatOwned() then
		rowboat2.nextAt = 0
		fn63(("bought for %d Peli"):format(n12))

		if tbl5.notify then
			pcall(tbl5.notify, "Skull Hub", "Bought a Rowboat.", 6)
		end

		return true
	end

	rowboat2.nextAt = os.clock() + math.min(60 * rowboat2.tries, 600)
	local str

	if not ok then
		str = "the remote threw"
	else
		str = "server answered " .. tostring(result)
	end

	if rowboat.TRIES <= rowboat2.tries then
		fn63(("purchase did not land after %d tries (%s) - carrying on without it"):format(rowboat2.tries, str))
	else
		fn63(("purchase did not land (%s) - retrying in %ds"):format(str, math.floor(rowboat2.nextAt - os.clock())))
	end

	return false
end

do
	local function fn63()
		if tbl8.flagged then
			fn40()
			tbl4.status = "STOPPED - the server stopped tracking you. Rejoin before doing anything else."
			task.wait(1)
			return
		end

		local character = localPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")

		if not character or not humanoid or humanoid.Health <= 0 then
			fn40()
			tbl4.status = "Waiting for respawn"
			task.wait(1)
			return
		end

		local n12 = humanoid.Health / math.max(humanoid.MaxHealth, 1)

		if n12 < tbl4.retreatHP then
			tbl4.retreating = true
		end

		if tbl4.retreating then
			if not (tbl4.resumeHP <= n12) then
				fn60(character, humanoid, n12)
				return
			end
			tbl4.retreating = false
		end

		if tbl4.method == "Rifle" and tbl4.mode ~= "Buso Haki (Ray)" and tbl5.level.stage ~= "peli" and tbl5.hasGun() then
			tbl5.gunEquip()
		else
			fn13()
		end

		if tbl4.setSpawn then
			tbl5.setSpawnHere(fn51)
		end

		if tbl5.merchDue() or tbl5.merch.home then
			tbl5.merchRun(fn51)
			return
		end

		if tbl5.geppoDue() or tbl5.geppo.home then
			tbl5.geppoRun(fn51)
			return
		end
		local v7, v8 = tbl5.seaOK(tbl4.mode)

		if not v7 then
			fn40()
			tbl4.status = "Wrong sea - " .. v8
			task.wait(2)
			return
		end

		if tbl4.mode == "Buso Haki (Ray)" then
			tbl5.busoStep()
			return
		end

		if tbl4.mode == "Boss: Juzo (Sea 2)" then
			tbl5.juzoStep()
			return
		end

		if tbl4.mode == "Level (auto)" then
			tbl5.levelStep()
			return
		end

		if tbl4.mode == "Nearest hostile" then
			local v9 = fn49(nil)

			if v9 then
				fn53(v9)
			else
				tbl4.status = "No hostile mob nearby"
				task.wait(0.5)
			end

			return
		end

		local v9 = fn44()

		if v9 == "None" then
			local v10 = fn48()

			if not v10 then
				tbl4.status = tbl4.travel and ("No reachable quest for level %d - the next ones need a boat or the sky."):format(fn43()) or ("No quest on this island for level %d - turn Island travel on."):format(fn43())
				task.wait(2)
				return
			end

			tbl4.quest = v10
			tbl4.mobSince = nil

			if not fn58(v10) then
				task.wait(1)
			end

			return
		end

		local quest2 = tbl13.byName[v9] or tbl4.quest

		if not quest2 then
			tbl4.status = "Unknown quest '" .. v9 .. "' - farming nearest hostile"
			local v10 = fn49(nil)

			if v10 then
				fn53(v10)
			else
				task.wait(1)
			end

			return
		end

		tbl4.quest = quest2

		if quest2.amount <= fn45() then
			if tbl4.autoTurnIn then
				if not fn57(quest2) then
					task.wait(1)
				end
			else
				tbl4.status = "Quest complete - auto turn-in off"
				task.wait(1)
			end

			return
		end

		if tbl5.gunTakePost(quest2.mob) then
			return
		end
		local v10 = fn49(quest2.mob)

		if v10 then
			tbl4.mobSince = nil
			fn53(v10)
			return
		end

		tbl4.mobSince = tbl4.mobSince or os.clock()
		local mobSince = tbl4.mobSince
		local n13 = os.clock() - mobSince

		if n13 > 75 then
			tbl4.status = ("Cannot find %s - dropping this quest"):format(quest2.mob)

			if not tbl5.quitQuest() then
				tbl4.status = ("Cannot find %s - but '%s' is a paid quest, not dropping it"):format(quest2.mob, v9)
			end

			tbl4.mobSince = nil
			task.wait(1.2)
			return
		end

		if n13 > 12 then
			local v11, v12 = fn47(quest2)
			local character2 = localPlayer.Character
			character2 = character2 and character2:FindFirstChild("HumanoidRootPart")

			if v11 and character2 and not v12 and (v11 - character2.Position).Magnitude > 400 then
				tbl4.status = ("No %s nearby - going back to %s"):format(quest2.mob, quest2.giver)
				fn36(v11 + Vector3.new(0, 3, 0), 12, fn51)
				tbl4.mobSince = os.clock()
				return
			end
		end

		local amount = quest2.amount
		tbl4.status = ("Waiting for %s to respawn (%d/%d)"):format(quest2.mob, fn45(), amount)
		task.wait(0.6)
	end

	tbl5.trouble = false

	tbl5.watchTrouble = function()
		if tbl5.troubleThread then
			return
		end

		tbl5.troubleThread = fn5("TroubleWatch", function()
			local flag2

			while true do
				task.wait(1)
				flag2 = false

				pcall(function()
					local robloxPromptGui = fn(game:GetService("CoreGui")):FindFirstChild("RobloxPromptGui", true)
					if not robloxPromptGui then
						return
					end

					for _, descendant in ipairs(robloxPromptGui:GetDescendants()) do
						if descendant:IsA("TextLabel") and type(descendant.Text) == "string" then
							local str = descendant.Text:lower()
							if str:find("banned") or str:find("kicked") or str:find("moderation") then
								flag2 = true
								break
							end
						end
					end
				end)

				if not (flag2 and not tbl5.trouble) then
					continue
				end
				break
			end

			tbl5.trouble = true
			tbl4.on = false
			tbl8.flagged = true
			tbl4.status = "STOPPED - the game reported a moderation action. Do not re-run."
			flag2 = fn40
			flag2()
		end)
	end

	local function fn64()
		if tbl4.thread then
			return
		end

		tbl4.thread = fn5("FarmLoop", function()
			fn56()
			tbl5.watchTrouble()
			tbl7.continuous = 0
			tbl3.repair()

			while tbl4.on do
				local ok, result = pcall(fn63)

				if not ok then
					tbl4.status = "Error: " .. fn2(result)
					task.wait(1)
				end

				task.wait()
			end

			tbl5.gunAimStop()
			fn40()
			tbl4.thread = nil
			tbl4.status = "Idle"
		end)
	end

	local lib, lib2, lib3

	if not getgenv().SkullHubGPOKaitun then
		lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/hungquan99/Interface/refs/heads/main/Enhanced/betafluentv2.lua"))()
		lib2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/hungquan99/FluentUI/master/Addons/SaveManager.lua"))()
		lib3 = loadstring(game:HttpGet("https://raw.githubusercontent.com/hungquan99/FluentUI/master/Addons/InterfaceManager.lua"))()
	else
		local function fn65()
			local skullHubGPOKaitun = getgenv().SkullHubGPOKaitun
			local tbl15 = {}

			local function fn66(arg, arg2)
				if type(arg.Callback) == "function" then
					pcall(arg.Callback, arg2)
				end

				if type(arg.Changed) == "function" then
					pcall(arg.Changed, arg2)
				end
			end

			local function fn67(arg, arg2)
				local tbl16 = {
					Idx = arg,
					Title = arg2.Title,
					Description = arg2.Description,
					Callback = arg2.Callback,
					Changed = nil,
					OnChanged = function(arg3, changed)
						arg3.Changed = changed

						if type(changed) == "function" then
							pcall(changed, arg3.Value)
						end
					end,
					SetTitle = function(arg3, title)
						arg3.Title = title
					end,
					SetDesc = function(arg3, description)
						arg3.Description = description
						local paragraphKey = arg3.__paragraphKey
						local str

						if paragraphKey then
							str = paragraphKey
						else
							str = arg3.Title and tostring(arg3.Title)
						end

						if str then
							skullHubGPOKaitun.paragraphs[str] = description
						end
					end,
					Visible = function()
					end,
					Destroy = function(arg3)
						if arg3.Idx then
							tbl15[arg3.Idx] = nil
						end
					end,
				}

				if arg then
					tbl15[arg] = tbl16
				end

				return tbl16
			end

			local function fn68(arg, arg2)
				local n12 = 10 ^ (arg2 or 0)
				return math.floor(arg * n12 + 0.5) / n12
			end

			local index = {}
			index.__index = index

			index.AddSection = function(arg, arg2, arg3, arg4, arg5)
				local obj = setmetatable({ Idx = arg5 }, index)

				if arg5 then
					tbl15[arg5] = obj
				end

				return obj
			end

			index.AddSubTab = function(arg, arg2)
				return setmetatable({ Idx = arg2 }, index)
			end

			index.AddTab = function(arg, arg2)
				return setmetatable({ Idx = type(arg2) == "table" and arg2.Title or nil }, index)
			end

			index.AddToggle = function(arg, arg2, arg3)
				local v7 = fn67(arg2, arg3)
				v7.Value = not not arg3.Default

				v7.SetValue = function(arg4, arg5)
					arg4.Value = not not arg5
					fn66(arg4, arg4.Value)
				end

				fn66(v7, v7.Value)
				return v7
			end

			index.AddSlider = function(arg, arg2, arg3)
				local v7 = fn67(arg2, arg3)
				v7.Min = tonumber(arg3.Min) or 0
				v7.Max = tonumber(arg3.Max) or 100
				v7.Rounding = tonumber(arg3.Rounding) or 0

				v7.SetValue = function(arg4, arg5)
					arg4.Value = fn68(math.clamp(tonumber(arg5) or arg4.Min, arg4.Min, arg4.Max), arg4.Rounding)
					fn66(arg4, arg4.Value)
				end

				v7:SetValue(tonumber(arg3.Default) or v7.Min)
				return v7
			end

			index.AddDropdown = function(arg, arg2, arg3)
				local v7 = fn67(arg2, arg3)
				v7.Values = arg3.Values or {}
				v7.Multi = arg3.Multi and true or false

				v7.SetValues = function(arg4, values)
					if values then
						arg4.Values = values
					end
				end

				v7.SetValue = function(arg4, value)
					if arg4.Multi then
						local value2 = {}

						if type(value) == "table" then
							for k, v8 in pairs(value) do
								if v8 and table.find(arg4.Values, k) then
									value2[k] = true
								end
							end
						end

						arg4.Value = value2
					elseif not value then
						arg4.Value = nil
					elseif table.find(arg4.Values, value) then
						arg4.Value = value
					end

					fn66(arg4, arg4.Value)
				end

				if v7.Multi then
					local value = {}

					if type(arg3.Default) == "table" then
						for _, v8 in pairs(arg3.Default) do
							if type(v8) == "string" then
								value[v8] = true
							end
						end
					end

					v7.Value = value
				elseif type(arg3.Default) == "string" and table.find(v7.Values, arg3.Default) then
					v7.Value = arg3.Default
				elseif type(arg3.Default) == "number" then
					v7.Value = v7.Values[arg3.Default]
				end

				return v7
			end

			index.AddInput = function(arg, arg2, arg3)
				local v7 = fn67(arg2, arg3)
				v7.Value = arg3.Default or ""

				v7.SetValue = function(arg4, arg5)
					local value = tostring(arg5 or "")

					if arg3.MaxLength and #value > arg3.MaxLength then
						value = value:sub(1, arg3.MaxLength)
					end

					arg4.Value = value
					fn66(arg4, arg4.Value)
				end

				return v7
			end

			index.AddButton = function(arg, arg2)
				local tbl16 = arg2 or {}
				local v7 = fn67(nil, tbl16)

				v7.Fire = function()
					if type(tbl16.Callback) == "function" then
						pcall(tbl16.Callback)
					end
				end

				return v7
			end

			index.AddParagraph = function(arg, arg2)
				local tbl16 = arg2 or {}
				local v7 = fn67(nil, tbl16)
				v7.Value = tbl16.Content

				if tbl16.Title then
					local paragraphKey = (arg.Idx and tostring(arg.Idx) .. ":" or "") .. tostring(tbl16.Title)
					v7.__paragraphKey = paragraphKey
					skullHubGPOKaitun.paragraphs[paragraphKey] = tbl16.Content
				end

				return v7
			end

			local obj = setmetatable({}, { __index = function()
				return function()
				end
			end })

			return {
				Options = tbl15,
				Kaitun = true,
				CreateWindow = function()
					local obj2 = setmetatable({}, index)

					obj2.SelectTab = function()
					end

					obj2.Minimize = function()
					end

					obj2.Dialog = function()
						return { Close = function()
						end }
					end

					return obj2
				end,
				CreateMinimizer = function()
				end,
				Tooltip = function()
					return { Attach = function()
					end }
				end,
				Notify = function(arg, arg2)
					local tbl16 = arg2 or {}
					skullHubGPOKaitun.note(tostring(tbl16.Content or tbl16.Title or ""))
				end,
			}, obj, obj
		end

		lib, lib2, lib3 = fn65()
	end

	local function notify(arg, arg2, arg3)
		lib:Notify({ Title = arg or "Skull Hub", Content = arg2 or "", Duration = arg3 or 5 })
	end

	tbl5.notify = notify

	tbl2.menuHold = function(arg)
		if not tbl2.inMenu then
			return false
		end

		if not arg then
			notify("Skull Hub", "This does not work in the main menu - join a game server first.", 6)
		elseif os.clock() - (tbl2.heldAt or -1e9) > 3 then
			tbl2.heldAt = os.clock()
			notify("Skull Hub", "Main menu: toggle saved. It starts once you join a game server.", 8)
		end

		return true
	end

	tbl2.MENU_STATUS = "Main menu - starts once you join a game server."

	tbl2.refuse = function(arg)
		if tbl2.menuHold(arg) then
			return true
		end
		local v7 = tbl2.why()
		if not v7 then
			return false
		end

		if os.clock() - (tbl2.saidAt or -1e9) > 3 then
			tbl2.saidAt = os.clock()
			notify("Skull Hub", v7, 15)
		end

		if arg then
			pcall(function()
				lib.Options[arg]:SetValue(false)
			end)
		end

		return true
	end

	local rightAlt = Enum.KeyCode.RightAlt

	local v7 = lib:CreateWindow({
		Title = "Skull Hub",
		SubTitle = "Grand Piece Online",
		Search = true,
		Icon = "rbxassetid://95183678717613",
		TabWidth = 130,
		Size = UDim2.fromOffset(500, 370),
		Acrylic = false,
		Theme = "Darker",
		DropdownsOutsideWindow = true,
		MinimizeKey = rightAlt,
		Sidebar = { Collapsible = true, DefaultCollapsed = true, AutoCollapse = true, CollapsedWidth = 45 },
	})

	local tbl15 = {
		Farm = v7:AddTab({
			Title = "Farm",
			Icon = "sparkle",
			Tooltip = true,
			TooltipDesc = "Auto farm: quests, level ladder, movement tuning and combat pacing",
		}),
		Fishing = v7:AddTab({ Title = "Fishing", Icon = "fish", Tooltip = true, TooltipDesc = "Auto fishing" }),
		Stats = v7:AddTab({
			Title = "Stats",
			Icon = "trending-up",
			Tooltip = true,
			TooltipDesc = "Spend stat points automatically as you level",
		}),
		Movement = v7:AddTab({
			Title = "Movement",
			Icon = "footprints",
			Tooltip = true,
			TooltipDesc = "Walk speed, jump, noclip, safety limits and long-distance travel",
		}),
		Misc = v7:AddTab({
			Title = "Misc",
			Icon = "wrench",
			Tooltip = true,
			TooltipDesc = "Quality-of-life tools, anti-cheat protection status and performance",
		}),
		Webhook = v7:AddTab({
			Title = "Webhook",
			Icon = "bell",
			Tooltip = true,
			TooltipDesc = "Report catches, milestones and problems to a Discord webhook",
		}),
		Settings = v7:AddTab({
			Title = "Settings",
			Icon = "settings",
			Tooltip = true,
			TooltipDesc = "Interface options and config save/load",
		}),
	}

	local tbl16 = {
		Farm1 = tbl15.Farm:AddSubTab("Level Farm", "trending-up"),
		Farm2 = tbl15.Farm:AddSubTab("Tuning", "sliders-horizontal"),
		Farm3 = tbl15.Farm:AddSubTab("Combat", "zap"),
		Fish1 = tbl15.Fishing:AddSubTab("Auto Fish", "fishing-rod"),
		Fish2 = tbl15.Fishing:AddSubTab("Catch & Bait", "coins"),
		Fish3 = tbl15.Fishing:AddSubTab("Bait Economy", "hammer"),
		Stats1 = tbl15.Stats:AddSubTab("Auto Stats", "align-end-horizontal"),
		Move1 = tbl15.Movement:AddSubTab("Speed & Jump", "gauge"),
		Move2 = tbl15.Movement:AddSubTab("Safety", "shield"),
		Move3 = tbl15.Movement:AddSubTab("Travel", "map-pin"),
		Misc1 = tbl15.Misc:AddSubTab("Utility", "sparkles"),
		Misc2 = tbl15.Misc:AddSubTab("Performance", "gauge"),
		Misc3 = tbl15.Misc:AddSubTab("Bypass", "shield-check"),
		Misc4 = tbl15.Misc:AddSubTab("Merchant", "store"),
		Misc5 = tbl15.Misc:AddSubTab("Private Server", "door-open"),
		Settings1 = tbl15.Settings:AddSubTab("Interface", "mouse-pointer-click"),
		Settings2 = tbl15.Settings:AddSubTab("Configs", "sliders-horizontal"),
		Hook1 = tbl15.Webhook:AddSubTab("Discord", "webhook"),
		Hook2 = tbl15.Webhook:AddSubTab("What to send", "list-checks"),
	}

	if tbl4.juzoUI or lib.Kaitun then
		tbl16.Farm4 = tbl15.Farm:AddSubTab("Boss (Sea 2)", "skull")
	end

	local function fn65()
		if type(lib.Tooltip) ~= "function" then
			return
		end

		for _, v8 in ipairs({
			{ tbl16.Farm1, "Level Farm", "Pick the farm mode and weapon, then turn Auto Farm on" },
			{ tbl16.Farm2, "Tuning", "How the farm moves: mover, speed, hover, reach, retreat" },
			{ tbl16.Farm3, "Combat", "M1 pacing, knockback handling and the infinite-M1 reset" },
			{ tbl16.Fish1, "Auto Fish", "Run the loop, aim the cast, tune the reel" },
			{ tbl16.Fish2, "Catch & Bait", "Bait and what to sell" },
			{ tbl16.Fish3, "Bait Economy", "Craft bait from your catch and restock from the shop" },
			{ tbl16.Stats1, "Auto Stats", "Which stat to pump, the cap, and bulk spending" },
			{ tbl16.Move1, "Speed & Jump", "Walk speed, jump power and infinite jump" },
			{
				tbl16.Move2,
				"Safety",
				"Noclip, the speed ceiling, and what to do when the anti-cheat flags you",
			},
			{ tbl16.Move3, "Travel", "Long-distance trips, including the Fishman Island route" },
			{ tbl16.Misc1, "Utility", "Anti-AFK, low graphics and rejoin" },
			{ tbl16.Misc2, "Performance", "FPS cap, FPS boost, black screen and map stripping" },
			{ tbl16.Misc3, "Bypass", "Live status of the anti-cheat protection this script installs" },
			{ tbl16.Misc5, "Private Server", "Join a private server by code, automatically" },
			{ tbl16.Settings1, "Interface", "Theme, transparency and the auto-execute toggle" },
			{ tbl16.Settings2, "Configs", "Save, load and autoload your settings" },
			{ tbl16.Hook1, "Discord", "Paste a webhook URL and test it" },
			{ tbl16.Hook2, "What to send", "Pick which catches and events get reported" },
		}) do
			local v9 = v8[1]
			local v10 = v8[2]
			local v11 = v8[3]

			if v9 and v9.Button then
				pcall(function()
					lib:Tooltip():Attach(v9.Button, v10, v11)
				end)
			end
		end
	end

	fn65()

	local tbl17 = {
		speedOn = false,
		jumpOn = false,
		speed = 16,
		jump = 50,
		infJump = false,
		noclip = false,
		noclipForce = false,
		water = false,
		suspend = false,
	}

	local function fn66()
		local tbl18 = { walkSpeed = 16, jumpPower = 50, jumpHeight = 7.2 }
		local flag2 = false
		local tbl19 = {}

		local function fn67(arg)
			if not (arg and tbl17.speedOn) or tbl17.suspend then
				return
			end
			flag2 = true
			arg.WalkSpeed = tbl17.speed
			flag2 = false
		end

		local function fn68(arg)
			if not (arg and tbl17.jumpOn) then
				return
			end
			flag2 = true
			arg.JumpPower = tbl17.jump
			arg.JumpHeight = tbl17.jump / 50 * tbl18.jumpHeight
			flag2 = false
		end

		local function fn69(arg)
			if not arg then
				return
			end
			flag2 = true
			arg.WalkSpeed = tbl18.walkSpeed
			arg.JumpPower = tbl18.jumpPower
			arg.JumpHeight = tbl18.jumpHeight
			flag2 = false
		end

		local function fn70()
			for _, v8 in ipairs(tbl19) do
				pcall(function()
					v8:Disconnect()
				end)
			end

			table.clear(tbl19)
			local n12 = 0
			local character, humanoid

			while true do
				character = localPlayer.Character
				humanoid = character and character:FindFirstChildOfClass("Humanoid")
				if character and humanoid and character:GetAttribute("characterLoaded") then
					break
				end
				n12 += task.wait(0.1)
				if not (n12 >= 20) then
					continue
				end
				break
			end

			if not (character and humanoid) then
				return
			end
			tbl18.walkSpeed = humanoid.WalkSpeed
			tbl18.jumpPower = humanoid.JumpPower
			tbl18.jumpHeight = humanoid.JumpHeight

			tbl19[#tbl19 + 1] = fn7(humanoid:GetPropertyChangedSignal("WalkSpeed"), "WalkSpeed", function()
				if flag2 or not tbl17.speedOn or tbl17.suspend then
					return
				end

				if humanoid.WalkSpeed ~= tbl17.speed then
					fn67(humanoid)
				end
			end)

			tbl19[#tbl19 + 1] = fn7(humanoid:GetPropertyChangedSignal("JumpPower"), "JumpPower", function()
				local v8 = flag2
				local flag3

				if flag2 then
					flag3 = v8
				else
					flag3 = not tbl17.jumpOn
				end

				if flag3 then
					return
				end

				if humanoid.JumpPower ~= tbl17.jump then
					fn68(humanoid)
				end
			end)

			fn67(humanoid)
			fn68(humanoid)
		end

		fn7(localPlayer.CharacterAdded, "CharAdded", function()
			tbl9.reset()
			fn5("BindChar", fn70)
		end)

		fn5("BindChar", fn70)

		fn7(localPlayer.CharacterAdded, "GunRearm", function()
			fn5("GunRearm", tbl5.gunRearm)
		end)

		local v8 = tbl16.Move1:AddSection("Walk Speed", "gauge")
		local GPOSpeedToggle = v8:AddToggle("GPOSpeedToggle", { Title = "Enable Walk Speed", Default = false })

		local GPOSpeedSlider = v8:AddSlider("GPOSpeedSlider", {
			Title = "Walk Speed",
			Description = "GPO default is 16.",
			Default = 16,
			Min = 16,
			Max = 200,
			Rounding = 0,
			Callback = function(speed)
				tbl17.speed = speed
				local character = localPlayer.Character
				fn67(character and character:FindFirstChildOfClass("Humanoid"))
			end,
		})

		GPOSpeedToggle:OnChanged(function(speedOn)
			if speedOn and tbl2.refuse("GPOSpeedToggle") then
				return
			end
			tbl17.speedOn = speedOn
			local character = localPlayer.Character
			character = character and character:FindFirstChildOfClass("Humanoid")

			if speedOn then
				tbl17.speed = GPOSpeedSlider.Value or tbl17.speed
				fn67(character)
			elseif character then
				flag2 = true
				character.WalkSpeed = tbl18.walkSpeed
				flag2 = false
			end
		end)

		local Jump = tbl16.Move1:AddSection("Jump", "arrow-up")
		local GPOJumpToggle = Jump:AddToggle("GPOJumpToggle", { Title = "Enable Jump Power", Default = false })

		local GPOJumpSlider = Jump:AddSlider("GPOJumpSlider", {
			Title = "Jump Power",
			Description = "GPO default is 50.",
			Default = 50,
			Min = 50,
			Max = 350,
			Rounding = 0,
			Callback = function(jump)
				tbl17.jump = jump
				local character = localPlayer.Character
				fn68(character and character:FindFirstChildOfClass("Humanoid"))
			end,
		})

		GPOJumpToggle:OnChanged(function(jumpOn)
			if jumpOn and tbl2.refuse("GPOJumpToggle") then
				return
			end
			tbl17.jumpOn = jumpOn
			local character = localPlayer.Character
			character = character and character:FindFirstChildOfClass("Humanoid")

			if jumpOn then
				tbl17.jump = GPOJumpSlider.Value or tbl17.jump
				fn68(character)
			elseif character then
				flag2 = true
				character.JumpPower = tbl18.jumpPower
				character.JumpHeight = tbl18.jumpHeight
				flag2 = false
			end
		end)

		Jump:AddToggle("GPOInfJump", { Title = "Infinite Jump", Default = false }):OnChanged(function(infJump)
			if infJump and tbl2.refuse("GPOInfJump") then
				return
			end
			tbl17.infJump = infJump
		end)

		fn7(v3.JumpRequest, "InfJump", function()
			if not tbl17.infJump then
				return
			end
			local character = localPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end)

		Jump:AddButton({
			Title = "Reset to Default",
			Description = "Speed 16 / Jump 50, everything off.",
			Callback = function()
				local v9 = tbl17
				local v10 = tbl17
				local v11 = tbl17
				tbl17.speedOn = false
				v9.jumpOn = false
				v10.infJump = false
				v11.noclip = false
				tbl17.noclipForce = false

				pcall(function()
					GPOSpeedToggle:SetValue(false)
					GPOJumpToggle:SetValue(false)
				end)

				local character = localPlayer.Character
				fn69(character and character:FindFirstChildOfClass("Humanoid"))
				notify("Skull Hub", "Movement restored to default.", 4)
			end,
		})

		local v9 = tbl16.Move2:AddSection("Speed Ceiling", "shield"):AddParagraph({ Title = "Speed ceiling", Content = "SpeedBypass: 0" })

		fn5("SpeedStatus", function()
			while true do
				task.wait(1)
				local character = localPlayer.Character
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")

				if character and humanoid then
					local n12 = tonumber(character:GetAttribute("SpeedBypass")) or 0
					local maxSpeedHooked = tbl2.protected and tbl2.maxSpeedHooked

					pcall(function()
						v9:SetDesc(([[WalkSpeed: %d
SpeedBypass grant: %d
Anti-cheat floor: 46 (always allowed)
GetMaxSpeed hook: %s]]):format(math.floor(humanoid.WalkSpeed), n12, maxSpeedHooked and "landed - ceiling retired" or "NOT landed - stay at or under 46"))
					end)
				end
			end
		end)

		local v10 = tbl16.Move2:AddSection("Anti-Cheat Flags", "siren")
		local v11 = v10:AddParagraph({ Title = "Flag counter", Content = "AntiCheatTriggers: reading..." })

		v10:AddToggle("GPOHaltOnAC", {
			Title = "Stop everything if flagged",
			Description = "Off by default. On: the first flag kills the farm and all movement.",
			Default = false,
		}):OnChanged(function(haltOnAC)
			tbl8.haltOnAC = haltOnAC
		end)

		fn5("ACStatus", function()
			while true do
				task.wait(2)
				local character = localPlayer.Character
				local attribute = character and character:GetAttribute("AntiCheatTriggers")

				pcall(function()
					v11:SetDesc(("AntiCheatTriggers: %s\nGained this session: %d\nOn flag: %s"):format(attribute == nil and "none (never flagged)" or tostring(attribute), tbl8.acHits, tbl8.haltOnAC and "STOP everything" or "keep farming"))
				end)
			end
		end)

		tbl16.Move2:AddSection("Noclip", "eye-off"):AddToggle("GPONoclip", {
			Title = "Noclip",
			Description = "Re-asserted every frame. Riskier on a combat game - use briefly.",
			Default = false,
		}):OnChanged(function(noclip)
			if noclip and tbl2.refuse("GPONoclip") then
				return
			end
			tbl17.noclip = noclip
		end)

		fn7(v2.Stepped, "Noclip", function()
			if not (tbl17.noclip or tbl17.noclipForce) then
				return
			end
			local character = localPlayer.Character
			if not character then
				return
			end

			for _, descendant in ipairs(character:GetDescendants()) do
				if descendant:IsA("BasePart") and descendant.CanCollide then
					descendant.CanCollide = false
				end
			end
		end)

		tbl16.Move3:AddSection("Walk on Water", "waves"):AddToggle("GPOWalkWater", { Title = "Walk on Water", Default = false }):OnChanged(function(water)
			if water and tbl2.refuse("GPOWalkWater") then
				return
			end
			tbl17.water = water

			if not water then
				tbl11.floatStop()
			end
		end)

		fn5("WalkWater", function()
			while true do
				task.wait(0.25)

				if tbl17.water then
					local character = localPlayer.Character
					character = character and character:FindFirstChild("HumanoidRootPart")

					if character and not tbl11.running() then
						if tbl11.overWater(character.Position) then
							tbl11.floatRun()
							continue
						end
						tbl11.floatStop()
					end
				end
			end
		end)
	end

	fn66()

	local function fn67()
		local tbl18 = {
			on = false,
			status = "Idle",
			enter = Vector3.new(1837.627, 9.238, -12168.056),
			pool = Vector3.new(1836.648, -4.394, -12192.628),
			pad = Vector3.new(1793.727, -92.762, -12327.454),
			exit = Vector3.new(8585.816, -2136.123, -17087.814),
		}

		local n12 = 30
		local n13 = 8
		local n14 = 3
		local n15 = 0.8
		local n16 = 2.5
		local n17 = 45

		local function fn68()
			local ok, result = pcall(function()
				return getrenv()._G
			end)

			return ok and type(result) == "table" and result or nil
		end

		local function fn69()
			local islands = workspace:FindFirstChild("Islands")
			islands = islands and islands:FindFirstChild("Fishman Cave")
			local enter = islands and islands:FindFirstChild("Enter")
			return enter and enter:IsA("BasePart") and enter or nil
		end

		local function fn70(arg)
			local areaTeleporters = workspace:FindFirstChild("AreaTeleporters")
			local firstSea = areaTeleporters and areaTeleporters:FindFirstChild("FirstSea")
			local fishman = firstSea and firstSea:FindFirstChild("Fishman")
			fishman = fishman and fishman:FindFirstChild(arg)
			return fishman and fishman:IsA("BasePart") and fishman or nil
		end

		local function fn71()
			return fn70("Part")
		end

		local function fn72(arg)
			local character = localPlayer.Character
			character = character and character:FindFirstChild("HumanoidRootPart")

			if not character and arg then
				local n18 = os.clock() + 8

				while true do
					task.wait(0.2)
					character = localPlayer.Character
					character = character and character:FindFirstChild("HumanoidRootPart")
					if not (character or os.clock() > n18) then
						continue
					end
					break
				end
			end

			if not character then
				return false
			end
			return fn23(character.Position.Y, fn22())
		end

		local function fn73(arg)
			local v8 = fn68()
			if not v8 then
				return
			end
			v8.swimmingDecension = arg and true or false

			if arg then
				v8.swimmingAscension = false

				if v8.canuse == false then
					v8.canuse = true
				end
			end
		end

		local function fn74()
			local character = localPlayer.Character
			character = character and character:GetAttribute("timeUntilDrown")
			return type(character) == "number" and character <= n14
		end

		local tbl19 = { goal = nil, conn = nil, prevSpeed = nil }

		local function fn75(goal)
			tbl19.goal = goal
			if tbl19.conn then
				return
			end
			local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

			if humanoid and not tbl19.prevSpeed then
				tbl19.prevSpeed = humanoid.WalkSpeed
			end

			tbl19.conn = fn7(v2.RenderStepped, "FishmanWalk", function()
				local goal2 = tbl19.goal
				if not goal2 or tbl8.flagged then
					return
				end
				local character = localPlayer.Character
				local humanoid2 = character and character:FindFirstChildOfClass("Humanoid")
				character = character and character:FindFirstChild("HumanoidRootPart")
				if not (humanoid2 and character) or humanoid2.Health <= 0 then
					return
				end
				local v8 = tbl11.speed()

				if math.abs(humanoid2.WalkSpeed - v8) > 0.01 then
					humanoid2.WalkSpeed = v8
				end

				local vector = Vector3.new(goal2.X - character.Position.X, 0, goal2.Z - character.Position.Z)
				if vector.Magnitude < 0.5 then
					humanoid2:Move(Vector3.zero, false)
					return
				end
				humanoid2:Move(vector.Unit, false)
			end)
		end

		local function fn76()
			tbl19.goal = nil

			if tbl19.conn then
				pcall(function()
					tbl19.conn:Disconnect()
				end)
			end

			tbl19.conn = nil
			local character = localPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				pcall(function()
					humanoid:Move(Vector3.zero, false)
				end)

				if tbl19.prevSpeed then
					pcall(function()
						humanoid.WalkSpeed = tbl19.prevSpeed
					end)
				end
			end

			tbl19.prevSpeed = nil
		end

		local tbl20 = { y = nil, conn = nil }

		local function fn77(y)
			tbl20.y = y
			if tbl20.conn or not y then
				return
			end

			tbl20.conn = fn7(v2.Heartbeat, "FishmanHold", function()
				local y2 = tbl20.y
				if not y2 or tbl8.flagged then
					return
				end
				local character = localPlayer.Character
				local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
				if not humanoidRootPart then
					return
				end
				local assemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity
				local n18 = y2 - humanoidRootPart.Position.Y
				humanoidRootPart.AssemblyLinearVelocity = Vector3.new(assemblyLinearVelocity.X, math.abs(n18) < 0.3 and 0 or math.clamp(n18 * 2, -n13, 8), assemblyLinearVelocity.Z)
			end)
		end

		local function fn78()
			tbl20.y = nil

			if tbl20.conn then
				pcall(function()
					tbl20.conn:Disconnect()
				end)
			end

			tbl20.conn = nil
		end

		local function fn79()
			fn76()
			fn78()
		end

		local function fn80(arg, arg2)
			local x = arg2.X
			return (Vector3.new(arg.X, 0, arg.Z) - Vector3.new(x, 0, arg2.Z)).Magnitude
		end

		local tbl21 = {
			CLEAR = { 3, 4.5, 6 },
			MAX_THICK = 12,
			PROBE = 6,
			NEAR = 4,
			MAX_JUMP = 16,
			HEAD = 4,
			GAP = 0.25,
			at = 0,
		}

		local function fn81()
			local raycastParams2 = RaycastParams.new()
			raycastParams2.FilterType = Enum.RaycastFilterType.Include
			local filterDescendantsInstances = {}

			for _, v8 in ipairs({ "Islands", "Env", "Ships" }) do
				local v9 = workspace:FindFirstChild(v8)

				if v9 then
					filterDescendantsInstances[#filterDescendantsInstances + 1] = v9
				end
			end

			raycastParams2.FilterDescendantsInstances = filterDescendantsInstances
			return raycastParams2, filterDescendantsInstances
		end

		local function fn82(arg, arg2, arg3)
			local v8 = tbl21
			local at = v8.at
			if os.clock() - at < v8.GAP then
				return false
			end

			if tbl8.flagged then
				return false
			end
			local position = arg.Position
			local vector = Vector3.new(arg2.X - position.X, 0, arg2.Z - position.Z)
			if vector.Magnitude < 1 then
				return false
			end
			local unit = vector.Unit
			local v9, v10 = fn81()
			local hit = workspace:Raycast(position, unit * v8.PROBE, v9)
			if not hit then
				return false
			end

			if math.abs(hit.Normal.Y) > 0.5 then
				return false
			end

			if v8.NEAR < (hit.Position - position).Magnitude then
				return false
			end
			local raycastParams2 = RaycastParams.new()
			raycastParams2.FilterType = Enum.RaycastFilterType.Include
			raycastParams2.FilterDescendantsInstances = { hit.Instance }
			local hit2 = workspace:Raycast(hit.Position + unit * 400, -unit * 400, raycastParams2)
			if not hit2 then
				return false
			end
			local magnitude = (hit2.Position - hit.Position).Magnitude
			if magnitude < 0.1 or magnitude > v8.MAX_THICK then
				return false
			end
			local overlapParams2 = OverlapParams.new()
			overlapParams2.FilterType = Enum.RaycastFilterType.Include
			overlapParams2.FilterDescendantsInstances = v10

			for _, v11 in ipairs(v8.CLEAR) do
				local n18 = hit2.Position + unit * v11
				local hit3 = workspace:Raycast(Vector3.new(n18.X, arg3 + 8, n18.Z), Vector3.new(0, -40, 0), v9)

				if hit3 then
					local vector2 = Vector3.new(n18.X, hit3.Position.Y + drive.CLEAR, n18.Z)
					local magnitude2 = (vector2 - position).Magnitude

					if magnitude2 <= v8.MAX_JUMP and tbl11.hopLeft() > magnitude2 and #workspace:GetPartBoundsInBox(CFrame.new(vector2 + Vector3.new(0, 0.5, 0)), Vector3.new(2.5, 5, 2.5), overlapParams2) == 0 and not workspace:Raycast(vector2, Vector3.new(0, v8.HEAD, 0), v9) then
						v8.at = os.clock()
						tbl11.hopSpend(magnitude2)
						arg.CFrame = CFrame.new(vector2, vector2 + unit)
						arg.AssemblyLinearVelocity = Vector3.zero
						arg.AssemblyAngularVelocity = Vector3.zero
						return true
					end
				end
			end

			return false
		end

		local function fn83(arg, arg2, arg3, arg4)
			fn75(arg)
			local n18 = os.clock() + (arg3 or 12)

			while os.clock() < n18 do
				if arg4() then
					return false
				end

				if tbl8.flagged then
					return false
				end
				local character = localPlayer.Character
				character = character and character:FindFirstChild("HumanoidRootPart")
				if not character then
					return false
				end

				if fn80(character.Position, arg) <= arg2 then
					fn76()
					return true
				end
				task.wait(0.1)
			end

			fn76()
			return false
		end

		local n18 = 6

		local function fn84(arg)
			if not (localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")) then
				return false, "lost the character at the cave pool"
			end

			local function fn85()
				return arg() or tbl8.flagged
			end

			local n19 = 0

			while true do
				if arg() then
					return false, "stopped"
				else
					if tbl8.flagged then
						return false, "the server stopped tracking you"
					end
					local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
					if not humanoidRootPart then
						return false, "lost the character at the cave pool"
					end
					local position = humanoidRootPart.Position
					local vector = Vector3.new(tbl18.pool.X - position.X, 0, tbl18.pool.Z - position.Z)

					if vector.Magnitude <= 0.25 then
						fn73(true)
						local n20 = os.clock() + n12

						while os.clock() < n20 do
							if arg() then
								return false, "stopped"
							end

							if tbl8.flagged then
								return false, "the server stopped tracking you"
							end

							if fn74() then
								return false, "out of air on the way down"
							end

							if fn72(false) then
								return true
							end
							local humanoidRootPart2 = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
							if not humanoidRootPart2 then
								return false, "lost the character in the shaft"
							end
							local position2 = humanoidRootPart2.Position
							fn20()
							local hit = workspace:Raycast(position2, Vector3.new(0, -(n18 + n3 + 2), 0), raycastParams)
							local n21 = 6

							if hit then
								if tbl18.pad.Y + 8 < hit.Position.Y then
									return false, ("the shaft is blocked at y = %d"):format(math.floor(hit.Position.Y))
								end
								n21 = position2.Y - hit.Position.Y - n3
								if n21 <= 0.5 then
									return true
								end
							end

							local max = math.max
							tbl18.status = ("Tweening down the shaft - %d studs down, %d to go"):format(math.floor(tbl18.pool.Y - position2.Y), max(math.floor(position2.Y - tbl18.pad.Y), 0))
							local vector2 = Vector3.new(tbl18.pool.X, position2.Y - n21, tbl18.pool.Z)
							if not drive.segment(humanoidRootPart2, vector2, vector2 + humanoidRootPart2.CFrame.LookVector, 25, fn85) then
								return false, "the descent was interrupted"
							end
						end

						return false, "the descent ran out of time"
					end

					n19 += 1
					if n19 > 40 then
						return false, "could not line up on the shaft mouth"
					end
					local n20 = position + vector.Unit * math.min(drive.STEP, vector.Magnitude)
					if drive.cast(position, n20 - position) then
						return false, "something is between the character and the shaft mouth"
					end

					if not drive.segment(humanoidRootPart, n20, n20 + vector.Unit, 25, fn85) then
						break
					end
				end
			end

			return false, "stopped before reaching the shaft mouth"
		end

		local function fn85(arg)
			tbl18.status = "Dropping into the water…"
			fn40()
			local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")

			if humanoidRootPart and fn80(humanoidRootPart.Position, tbl18.pool) > n16 then
				tbl18.status = "Walking onto the pool mouth…"
				fn83(tbl18.pool, 2.5, 15, arg)
				if arg() then
					return false, "Stopped."
				end
				tbl18.status = "Dropping into the water…"
			end

			local n19 = os.clock() + 12
			local flag2

			while true do
				task.wait(0.15)

				if arg() then
					return false, "Stopped."
				else
					local v8 = fn68()
					flag2 = v8 ~= nil and v8.swimming == true
					if flag2 or os.clock() > n19 then
						break
					end
				end
			end

			if not flag2 then
				return false, "Got to the pool mouth but never entered the water - nudge the character into it and retry."
			end
			tbl18.status = "Centring in the shaft…"

			if not fn83(tbl18.pool, 2.5, 12, arg) then
				if arg() then
					return false, "Stopped."
				end
				return false, "Fell in off-centre and could not swim back onto the shaft."
			end

			fn73(true)
			fn75(tbl18.pool)
			local n20 = os.clock() + n12
			local huge = math.huge
			local now = nil
			local y

			while true do
				if arg() then
					return false, "Stopped."
				else
					if tbl8.flagged then
						return false, "Stopped - the server stopped tracking you."
					end

					if fn74() then
						return false, "Out of air on the way down - aborted."
					end

					if fn72(false) then
						return true
					end
					local humanoidRootPart2 = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
					if not humanoidRootPart2 then
						return false, "Lost the character on the way down."
					end
					y = humanoidRootPart2.Position.Y
					local max = math.max
					tbl18.status = ("Diving - %d studs down, %d to go"):format(math.floor(tbl18.pool.Y - y), max(math.floor(y - tbl18.pad.Y), 0))
					if y <= tbl18.pad.Y - 1 then
						return true
					end

					if huge - 0.4 < y then
						now = now or os.clock()
						if os.clock() - now >= n15 and y < tbl18.pool.Y - 20 then
							return true
						end
					else
						now = nil
					end

					local n21 = math.min(huge, y)
					if n20 < os.clock() then
						break
					end
					task.wait(0.15)
					huge = n21
				end
			end

			return false, ("The dive stalled at y = %d (the floor is -97). Retry, or check that nothing is holding _G.canuse false."):format(math.floor(y))
		end

		local n19 = 10
		local n20 = 16
		local n21 = 60

		tbl5.fishman = {
			state = tbl18,
			trip = function()
				local function fn86()
					return not tbl18.on
				end

				local function fn87(arg, status)
					fn73(false)
					tbl17.noclipForce = false
					fn79()
					fn40()
					tbl18.status = status
					return arg
				end

				local function fn88()
					local character = localPlayer.Character
					return character and character:FindFirstChild("HumanoidRootPart")
				end

				if fn72() then
					tbl18.status = "Already on Fishman Island."
					return true
				end
				tbl18.status = "Streaming Fishman Cave…"

				pcall(function()
					localPlayer:RequestStreamAroundAsync(tbl18.pool, 500)
				end)

				local v8

				for i = 1, 12 do
					v8 = fn71()
					if v8 then
						tbl18.pad = v8.Position
						break
					end

					if fn86() then
						return (fn87(false, "Stopped."))
					end
					task.wait(0.25)
				end

				local v9 = fn69()

				if v9 then
					tbl18.enter = v9.Position
				end

				local v10 = fn88()

				if v10 and (tbl18.enter - v10.Position).Magnitude > 25 then
					tbl18.status = "Sailing to Fishman Cave…"

					if not fn36(tbl18.enter + Vector3.new(0, 4, 0), 18, fn86) then
						if fn86() then
							return (fn87(false, "Stopped."))
						end
						return (fn87(false, tbl8.flagged and "Stopped - the server stopped tracking you." or "Could not reach Fishman Cave. Try again from closer to it."))
					end
				end

				if fn86() then
					return (fn87(false, "Stopped."))
				end
				tbl18.status = "Moving to the cave pool…"
				fn33(tbl18.pool, 12, fn86)
				if fn86() then
					return (fn87(false, "Stopped."))
				end

				if tbl8.flagged then
					return (fn87(false, "Stopped - the server stopped tracking you."))
				end
				local v11 = fn88()
				if not v11 then
					return (fn87(false, "Lost the character at the cave pool."))
				end
				local v12 = fn80(v11.Position, tbl18.pool)
				if v12 > n17 then
					return (fn87(false, ("Stopped %d studs off the pool mouth - too far to line up from. Walk towards (1837, -4, -12193) yourself and press the button again."):format(math.floor(v12))))
				end
				tbl18.status = "Lining up on the shaft…"
				fn40()
				local v13, v14 = fn84(fn86)

				if not v13 then
					if fn86() then
						return (fn87(false, "Stopped."))
					end

					if tbl8.flagged then
						return (fn87(false, "Stopped - the server stopped tracking you."))
					end

					if fn74() then
						return (fn87(false, "Out of air at the cave pool - surfacing instead of diving."))
					end
					tbl18.status = ("Tween down refused (%s) - using the game's dive"):format(tostring(v14))
					local v15, v16 = fn85(fn86)
					if not v15 then
						return (fn87(false, tostring(v16)))
					end
				end

				drive.stop()
				local v15 = fn88()
				local y = v15 and v15.Position.Y or tbl18.pad.Y - 1
				tbl17.noclipForce = false
				v8 = fn71() or v8

				if v8 then
					tbl18.pad = v8.Position
				end

				fn75(tbl18.pad)
				fn77(y)
				local now = os.clock()
				local n22 = os.clock() + 45
				local n23 = 0
				local v16 = nil
				local exitTo = nil
				local flag2, flag3, v17

				while true do
					flag2 = false
					flag3 = false

					if not (os.clock() < n22) then
						exitTo = 1
						break
					else
						if fn86() then
							exitTo = 2
							break
						elseif tbl8.flagged then
							exitTo = 3
							break
						elseif fn74() then
							exitTo = 4
							break
						elseif fn72(true) then
							exitTo = 5
							break
						else
							fn73(true)
							local v18 = fn88()

							if not v18 then
								exitTo = 6
								break
							else
								local flag4, flag5

								if fn82(v18, tbl18.pad, y) then
									n23 += 1
									v18 = fn88()

									if not v18 then
										exitTo = 7
										break
									else
										v17 = fn80(v18.Position, tbl18.pad)
										tbl18.status = ("Walking to the teleporter - %d studs, %d walls"):format(math.floor(v17), n23)
										flag4 = v17 <= 1.5 and math.abs(v18.Position.Y - y) <= 2.5

										if flag4 then
											exitTo = 8
											break
										else
											flag5 = not v16 or v17 < v16 - 1.5

											if flag5 then
												now = os.clock()
												v16 = v17
											end

											if not (os.clock() - now > 8) then
												task.wait(0.1)
												continue
											end
										end
									end
								else
									v17 = fn80(v18.Position, tbl18.pad)
									tbl18.status = ("Walking to the teleporter - %d studs, %d walls"):format(math.floor(v17), n23)
									flag4 = v17 <= 1.5 and math.abs(v18.Position.Y - y) <= 2.5

									if flag4 then
										exitTo = 8
										break
									else
										flag5 = not v16 or v17 < v16 - 1.5

										if flag5 then
											now = os.clock()
											v16 = v17
										end

										if not (os.clock() - now > 8) then
											task.wait(0.1)
											continue
										end
									end
								end
							end
						end

						break
					end
				end

				if exitTo ~= 1 then
					if exitTo == 2 then
						return (fn87(false, "Stopped."))
					end

					if exitTo == 3 then
						return (fn87(false, "Stopped - the server stopped tracking you."))
					end

					if exitTo == 4 then
						return (fn87(false, "Out of air on the crossing - aborted."))
					end

					if exitTo == 5 then
						flag2 = true
						flag3 = true
					else
						if exitTo == 6 then
							return (fn87(false, "Lost the character inside the rock."))
						end

						if exitTo == 7 then
							return (fn87(false, "Lost the character inside the rock."))
						end

						if exitTo ~= 8 then
							return (fn87(false, ("Stuck against a cave wall %d studs short of the teleporter - retry from the cave mouth."):format(math.floor(v17))))
						end
						flag2 = true
					end
				end

				if not flag2 then
					return (fn87(false, "Could not reach the teleporter pad. Retry from the cave mouth."))
				end

				if flag3 then
					fn79()
					task.wait(2)
					return (fn87(true, "On Fishman Island."))
				end

				tbl17.noclipForce = false
				fn78()
				fn73(true)
				fn75(tbl18.pad)
				tbl18.status = "On the teleporter - waiting for the drop…"
				local now2 = os.clock()
				local n24 = now2 + 30
				local flag4 = false
				local exitTo2 = nil
				local flag5, v18

				while true do
					flag5 = false

					if not (os.clock() < n24) then
						exitTo2 = 1
						break
					else
						if fn86() then
							exitTo2 = 2
							break
						elseif fn72(true) then
							exitTo2 = 3
							break
						elseif tbl8.flagged then
							exitTo2 = 4
							break
						elseif not fn74() then
							fn73(true)
							v18 = fn88()

							if v18 then
								local n25 = v18.Position.Y - y
								tbl18.status = n25 > 3 and ("Lifted %d studs off the pad - diving back down…"):format(math.floor(n25)) or "On the teleporter - waiting for the drop…"
							end

							if not flag4 and os.clock() - now2 > 6 and tbl.firetouchinterest and v8 then
								v18 = fn88()
								flag4 = true

								if v18 then
									pcall(function()
										firetouchinterest(v18, v8, 0)
										task.wait(0.05)
										firetouchinterest(v18, v8, 1)
									end)
								end
							end

							task.wait(0.2)
							continue
						end

						break
					end
				end

				if exitTo2 ~= 1 then
					if exitTo2 == 2 then
						return (fn87(false, "Stopped."))
					end

					if exitTo2 ~= 3 then
						if exitTo2 == 4 then
							return (fn87(false, "Stopped - the server stopped tracking you."))
						end
						return (fn87(false, "Ran out of air waiting on the teleporter - aborted."))
					end

					flag5 = true
				end

				if flag5 then
					fn79()
					task.wait(2)
					return (fn87(true, "On Fishman Island."))
				end

				if fn86() then
					return (fn87(false, "Stopped."))
				end
				v18 = fn88()
				return (fn87(false, tbl8.flagged and "Stopped - the server stopped tracking you." or ("Stood on the teleporter for 30s and nothing happened (%d studs off the floor at the end). Retry - and re-check that the pad still exists on this build."):format(math.floor(v18 and v18.Position.Y - y or 0))))
			end,
			here = fn72,
			leave = function(arg)
				local fn86 = arg or function()
					return false
				end

				if not fn72(false) then
					return true
				end

				if tbl8.flagged then
					tbl18.status = "Stopped - the server stopped tracking you."
					return false
				end
				tbl5.fishman.leaving = true

				local function fn87(arg2, status)
					tbl5.fishman.leaving = false
					fn79()
					fn40()
					tbl18.status = status
					return arg2
				end

				local function fn88()
					local character = localPlayer.Character
					return character and character:FindFirstChild("HumanoidRootPart")
				end

				local Part2 = fn70("Part2")

				if Part2 then
					tbl18.exit = Part2.Position
				end

				local exit = tbl18.exit

				local function fn89()
					return exit.Y - (Part2 and Part2.Parent and Part2.Size.Y or 14.9) / 2
				end

				if not fn88() then
					return (fn87(false, "Lost the character on Fishman Island."))
				end
				fn40()

				local function fn90()
					local position = fn88()
					position = position and position.Position or exit
					local vector = Vector3.new(position.X - exit.X, 0, position.Z - exit.Z)
					local n22 = exit + (vector.Magnitude > 0.5 and vector.Unit or Vector3.new(0, 0, 1)) * n19
					local x = n22.X
					local z = n22.Z
					return Vector3.new(x, fn89() + 3, z)
				end

				local flag2 = false

				local function fn91()
					if fn86() then
						return true
					end
					local v8 = fn88()
					if v8 and v8.Position.Y > fn89() + n21 then
						flag2 = true
						return true
					end
					return false
				end

				local n22 = os.clock() + 180
				local flag3 = false
				local n23 = 0
				local huge = math.huge
				local n24 = 0
				local n25 = 1

				while os.clock() < n22 do
					if fn86() then
						return (fn87(false, "Stopped."))
					end

					if tbl8.flagged then
						return (fn87(false, "Stopped - the server stopped tracking you."))
					end

					if not fn72(false) then
						task.wait(1)
						return (fn87(true, "Left Fishman Island."))
					end
					local v8 = fn88()
					if not v8 then
						return (fn87(false, "Lost the character on Fishman Island."))
					end

					if flag2 or v8.Position.Y > fn89() + n21 then
						return (fn87(false, ("Stopped - the tween rose %d studs over the exit pillar's base. Walk into the blue column next to Leza yourself."):format(math.floor(v8.Position.Y - fn89()))))
					end
					Part2 = fn70("Part2")

					if Part2 then
						exit = Part2.Position
						tbl18.exit = exit
					end

					local v9 = fn80(v8.Position, exit)

					if v9 <= n20 and not flag3 then
						tbl18.status = ("At the exit pillar - stepping in (%d studs)"):format(math.floor(v9))

						if n23 == 0 then
							fn75(exit)
							n23 = os.clock() + 4
						elseif n23 < os.clock() then
							fn76()
							flag3 = true
							n23 = 0
						end

						task.wait(0.2)
					else
						fn76()
						tbl18.status = ("Tweening to the exit pillar - %d studs"):format(math.floor(v9))
						fn30(fn90, 4, fn91, tbl4.glideRoute ~= false)
						local v10 = fn88()
						local v11 = v10 and fn80(v10.Position, exit) or v9

						if v11 < huge - 5 then
							n24 = 0
							huge = v11
						else
							n24 += 1
						end

						if n24 >= 3 and v10 and not flag2 then
							local vector = Vector3.new(exit.X - v10.Position.X, 0, exit.Z - v10.Position.Z)
							n24 = 0

							if vector.Magnitude > 1 then
								local unit = vector.Unit
								local n26 = Vector3.new(-unit.Z, 0, unit.X) * 28 * n25
								n25 = -n25
								tbl18.status = "Tween blocked - stepping round"
								fn30(v10.Position + n26 + unit * 12, 4, fn91, false)
							end
						end

						task.wait(0.1)
						flag3 = false
						n23 = 0
					end
				end

				return (fn87(false, "Could not reach the exit pillar. Walk into the blue column next to Leza yourself, then try again."))
			end,
			leaving = false,
			cleanup = function()
				fn73(false)
				tbl17.noclipForce = false
				fn79()
				fn40()
			end,
		}
	end

	fn67()

	local function fn68()
		local tbl18 = {
			on = false,
			settling = false,
			status = "Idle",
			place = 7465136166,
			level = 325,
			scroll = Vector3.new(-7348.887, 0.421, -14950.206),
			puff = Vector3.new(-8011.4, 69.574, -8540.139),
			gate = Vector3.new(-8913.3, 66.4, -8399.3),
		}

		local n12 = 45
		local n13 = 45
		local n14 = 1200

		local function fn69()
			local stats = v6:FindFirstChild("Stats" .. localPlayer.Name)
			stats = stats and stats:FindFirstChild("Stats")
			stats = stats and stats:FindFirstChild("Level")
			return stats and tonumber(stats.Value) or nil
		end

		local function fn70()
			local islands = workspace:FindFirstChild("Islands")
			islands = islands and islands:FindFirstChild("Reverse Mountain")
			islands = islands and islands:FindFirstChild("Gate")
			islands = islands and islands:FindFirstChild("Barrier")
			return islands and islands:IsA("BasePart") and islands or nil
		end

		local function fn71()
			local v8 = fn70()
			if not v8 then
				return nil
			end
			return v8.CastShadow == false
		end

		local function fn72(canQuery)
			local v8 = fn70()

			if v8 then
				pcall(function()
					v8.CanQuery = canQuery
				end)
			end
		end

		local function fn73()
			local effects = workspace:FindFirstChild("Effects")
			effects = effects and effects:FindFirstChild("World Scroll")
			return effects and effects:IsA("BasePart") and effects or nil
		end

		local function fn74()
			local effects = workspace:FindFirstChild("Effects")
			effects = effects and effects:FindFirstChild("2ndSeaTeleport")
			return effects and effects:IsA("BasePart") and effects or nil
		end

		local function fn75()
			local character = localPlayer.Character
			if character and character:FindFirstChild("World Scroll") then
				return true
			end
			local backpack = localPlayer:FindFirstChildOfClass("Backpack")
			if backpack and backpack:FindFirstChild("World Scroll") then
				return true
			end
			return tbl5.ownsItem("World Scroll")
		end

		local function fn76()
			if not tbl18.on or tbl8.flagged then
				return true
			end
			local deadline = tbl18.deadline

			if deadline then
				local deadline2 = tbl18.deadline
				deadline = os.clock() > deadline2
			end

			if deadline then
				if not tbl18.timedOut then
					tbl18.timedOut = true
					tbl18.status = "Gave up - the errand ran out of time"
				end

				return true
			end

			local stopFn = tbl18.stopFn

			if stopFn then
				local ok, result = pcall(stopFn)
				if ok and result then
					return true
				end
			end

			return false
		end

		local function fn77()
			fn72(true)
			tbl17.noclipForce = false
			local character = localPlayer.Character
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

			if humanoidRootPart and humanoidRootPart.Anchored then
				pcall(function()
					humanoidRootPart.Anchored = false
				end)
			end

			fn40()
		end

		tbl18.SNAP = { RANGE = 60, HOP = 10, SPEED = 40, BOX = Vector3.new(2.5, 5, 2.5) }

		local function fn78(arg)
			fn20()
			local v8 = workspace
			local box = tbl18.SNAP.BOX
			return #v8:GetPartBoundsInBox(CFrame.new(arg + Vector3.new(0, 0.5, 0)), box, overlapParams) == 0
		end

		local function fn79(arg)
			fn20()

			for _, v8 in ipairs({
				Vector3.zero,
				Vector3.new(3, 0, 0),
				Vector3.new(-3, 0, 0),
				Vector3.new(0, 0, 3),
				Vector3.new(0, 0, -3),
			}) do
				local n15 = arg + v8
				local hit = workspace:Raycast(Vector3.new(n15.X, arg.Y + 12, n15.Z), Vector3.new(0, -40, 0), raycastParams)

				if hit and hit.Normal.Y > 0.7 then
					local vector = Vector3.new(n15.X, hit.Position.Y + 3, n15.Z)
					if fn78(vector) then
						return vector
					end
				end
			end

			return nil
		end

		local function fn80()
			local character = localPlayer.Character
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart then
				return nil
			end
			local v8 = fn73()
			return (humanoidRootPart.Position - (v8 and v8.Position or tbl18.scroll)).Magnitude
		end

		local function fn81()
			local snap = tbl18.SNAP
			if tbl8.flagged or fn76() then
				return false
			end
			local character = localPlayer.Character
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
			character = character and character:FindFirstChildOfClass("Humanoid")
			if not (humanoidRootPart and character and character.Health > 0) then
				return false
			end
			local v8 = fn73()
			local v9 = fn79(v8 and v8.Position or tbl18.scroll)
			if not v9 then
				return false
			end
			local position = humanoidRootPart.Position
			local magnitude = (v9 - position).Magnitude
			if magnitude < 2 then
				return true
			end

			if magnitude > snap.RANGE + 5 then
				return false
			end

			if tbl11.hopLeft() < magnitude + 5 then
				return false
			end
			local vector = Vector3.new(v9.X - position.X, 0, v9.Z - position.Z)
			local unit = vector.Magnitude > 0.5 and vector.Unit or humanoidRootPart.CFrame.LookVector
			local n15 = math.max(math.ceil(magnitude / snap.HOP), 1)
			tbl18.status = "Jumping onto the World Scroll pedestal"
			local n16 = 1
			local humanoidRootPart2

			while n16 <= n15 do
				if tbl8.flagged or fn76() then
					return false
				end
				local character2 = localPlayer.Character
				humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")
				if not humanoidRootPart2 then
					return false
				end
				local flag2 = n16 == n15 and v9 or position:Lerp(v9, n16 / n15)

				if n16 < n15 and not fn78(flag2) then
					n16 += 1
					flag2 = n16 == n15 and v9 or position:Lerp(v9, n16 / n15)
					if n16 < n15 and not fn78(flag2) then
						return false
					end
				end

				local magnitude2 = (flag2 - humanoidRootPart2.Position).Magnitude
				if tbl5.phase.maxJump + 0.5 < magnitude2 then
					return false
				end
				tbl11.hopSpend(magnitude2)

				tbl11.viaTween(function()
					humanoidRootPart2.CFrame = CFrame.new(flag2, flag2 + unit)
					humanoidRootPart2.AssemblyLinearVelocity = Vector3.zero
				end)

				task.wait(math.max(magnitude2 / snap.SPEED, 0.2))
				n16 += 1
			end

			local character2 = localPlayer.Character
			humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")
			return humanoidRootPart2 ~= nil and (humanoidRootPart2.Position - v9).Magnitude <= 4
		end

		local function fn82()
			if fn75() then
				return true
			end
			local position = fn73()
			position = position and position.Position or tbl18.scroll
			tbl18.status = "Sailing to the World Scroll"

			if not fn36(position + Vector3.new(0, 3, 0), 8, function()
				if fn76() then
					return true
				end
				local v8 = fn80()
				return v8 ~= nil and v8 <= tbl18.SNAP.RANGE
			end) then
				if fn76() then
					return false
				end
			end

			local v8 = fn80()

			if v8 and v8 <= tbl18.SNAP.RANGE and not fn75() then
				fn81()
			end

			local huge = math.huge
			local n15 = 0

			for i = 1, 40 do
				if fn76() then
					return false
				end

				if fn75() then
					return true
				end
				local v9 = fn73()
				local proximityPrompt = v9 and v9:FindFirstChildOfClass("ProximityPrompt")
				local character = localPlayer.Character
				character = character and character:FindFirstChild("HumanoidRootPart")

				if character then
					character = (character.Position - (v9 and v9.Position or tbl18.scroll)).Magnitude
				end

				character = character or nil
				local n16 = proximityPrompt and math.max(proximityPrompt.MaxActivationDistance - 1, 3) or 0

				if proximityPrompt and character and character <= n16 then
					tbl18.status = "Grabbing the World Scroll"

					pcall(function()
						proximityPrompt:InputHoldBegin()
						task.wait(math.max(proximityPrompt.HoldDuration, 0.1) + 0.15)
						proximityPrompt:InputHoldEnd()
					end)
				else
					tbl18.status = character and ("Closing on the World Scroll (%d studs)"):format(character) or "Closing on the World Scroll"

					if character then
						if character < huge - 5 then
							n15 = 0
							huge = character
						else
							n15 += 1
							if n15 > 5 then
								tbl18.status = ("Cannot close the last %d studs to the World Scroll - stopped"):format(math.floor(character))
								return false
							end
						end
					end

					if not (character ~= nil and character <= tbl18.SNAP.RANGE and fn81()) then
						fn36((v9 and v9.Position or tbl18.scroll) + Vector3.new(0, 3, 0), 6, fn76)
					end
				end

				task.wait(0.6)
			end

			return fn75()
		end

		local function fn83()
			local playerGui = localPlayer:FindFirstChild("PlayerGui")
			local npcchat = playerGui and playerGui:FindFirstChild("NPCCHAT")
			if not npcchat then
				return true
			end
			local frame = npcchat:FindFirstChild("Frame")

			if frame and tbl.firesignal then
				for _, v8 in ipairs({ "endChat", "go" }) do
					local v9 = frame:FindFirstChild(v8)

					if v9 and v9.Visible then
						pcall(function()
							firesignal(v9.Activated)
						end)

						task.wait(0.35)
						if not playerGui:FindFirstChild("NPCCHAT") then
							return true
						end
					end
				end
			end

			for i = 1, 12 do
				if not playerGui:FindFirstChild("NPCCHAT") then
					return true
				end
				task.wait(0.25)
			end

			tbl18.status = "Forcing the dialogue closed"

			pcall(function()
				local g = getrenv and getrenv()._G

				if type(g) == "table" then
					if type(g.hideUI) == "function" then
						g.hideUI(false)
					end

					g.canuse = true
				end
			end)

			local character = localPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")

			if humanoid and humanoid.WalkSpeed <= 0 then
				pcall(function()
					humanoid.WalkSpeed = 16
				end)
			end

			local npcchat2 = playerGui:FindFirstChild("NPCCHAT")

			if npcchat2 then
				pcall(function()
					npcchat2:Destroy()
				end)
			end

			return true
		end

		local function fn84()
			if fn71() == true then
				return true
			end
			tbl18.status = "Sailing to Gatekeeper Puff"

			if not fn36(tbl18.puff + Vector3.new(0, 3, 0), 8, fn76) then
				if fn76() then
					return false
				end
			end

			local gatekeeperPuff = nil

			for i = 1, 40 do
				if fn76() then
					return false
				end
				gatekeeperPuff = workspace:FindFirstChild("NPCs") and workspace.NPCs:FindFirstChild("Gatekeeper Puff")
				if gatekeeperPuff then
					break
				end
				tbl18.status = "Waiting for Gatekeeper Puff to load"
				task.wait(0.5)
			end

			if not gatekeeperPuff then
				tbl18.status = "Gatekeeper Puff never loaded - stopped"
				return false
			end

			if fn71() == true then
				return true
			end
			local v8 = nil

			for _, descendant in ipairs(gatekeeperPuff:GetDescendants()) do
				if descendant:IsA("ProximityPrompt") then
					v8 = descendant
					break
				end
			end

			if not v8 then
				tbl18.status = "Puff has no interact prompt - stopped"
				return false
			end
			fn40()
			task.wait(0.3)

			local function fn85()
				local v9 = v8

				for _, descendant in ipairs(gatekeeperPuff:GetDescendants()) do
					if descendant:IsA("ProximityPrompt") then
						v9 = descendant
						break
					end
				end

				pcall(function()
					v9:InputHoldBegin()
					task.wait(math.max(v9.HoldDuration, 0.1) + 0.15)
					v9:InputHoldEnd()
				end)

				if tbl.fireproximityprompt then
					pcall(function()
						fireproximityprompt(v9)
					end)
				end
			end

			local playerGui = localPlayer:FindFirstChild("PlayerGui")

			for i = 1, 3 do
				if fn76() then
					return false
				end
				tbl18.status = ("Talking to Gatekeeper Puff (%d/3)"):format(i)
				fn85()
				task.wait(1)
				if playerGui and playerGui:FindFirstChild("NPCCHAT") or fn71() == true then
					break
				end
			end

			local n15 = os.clock() + n12
			local exitTo = nil

			while true do
				if not (os.clock() < n15) then
					exitTo = 1
					break
				else
					if not fn76() then
						if fn71() == true then
							exitTo = 1
							break
						else
							tbl18.status = "Opening the gate (cutscene)"
							task.wait(0.5)
							continue
						end
					end

					break
				end
			end

			if exitTo == 1 then
				if fn71() ~= true then
					tbl18.status = "The gate did not open - stopped"
					fn83()
					return false
				end

				local humanoidRootPart = nil

				for i = 1, 30 do
					if fn76() then
						return false
					end
					local character = localPlayer.Character
					humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
					if not (humanoidRootPart and humanoidRootPart.Anchored) then
						break
					end
					tbl18.status = "Gate open - waiting for the cutscene to release us"
					task.wait(0.5)
				end

				if humanoidRootPart and humanoidRootPart.Anchored then
					pcall(function()
						humanoidRootPart.Anchored = false
					end)
				end

				fn83()
				return true
			end

			return false
		end

		local function fn85()
			fn72(false)
			local n15 = fn22() or 0
			local v8 = fn74()
			local vector

			if v8 then
				vector = Vector3.new(v8.Position.X + v8.Size.X * 0.5 - 60, n15 + 5, v8.Position.Z)
			else
				vector = Vector3.new(-8514.8, n15 + 5, tbl18.gate.Z)
			end

			tbl18.status = "Crossing to the Second Sea gate"
			fn36(vector, 10, fn76)
			if fn76() then
				return false
			end
			local n16 = os.clock() + n13

			while os.clock() < n16 do
				if fn76() then
					return false
				end

				if game.PlaceId == tbl18.place then
					return true
				end
				local character = localPlayer.Character
				local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
				local v9 = fn74()

				if humanoidRootPart and v9 then
					local n17 = humanoidRootPart.Position - v9.Position
					local n18 = v9.Size * 0.5
					local x = n18.X
					local flag2 = math.abs(n17.X) <= x

					if flag2 then
						local y = n18.Y
						flag2 = math.abs(n17.Y) <= y
					end

					if flag2 then
						local z = n18.Z
						flag2 = math.abs(n17.Z) <= z
					end

					if flag2 then
						tbl18.status = "Inside the gate - waiting for the teleport"

						if tbl.firetouchinterest then
							pcall(function()
								firetouchinterest(humanoidRootPart, v9, 0)
								task.wait(0.1)
								firetouchinterest(humanoidRootPart, v9, 1)
							end)
						end
					else
						tbl18.status = "Walking into the gate"
						fn36(vector, 10, fn76)
					end
				end

				task.wait(0.8)
			end

			tbl18.status = "Reached the gate but the server did not teleport - stopped"
			return false
		end

		local function fn86()
			if game.PlaceId == tbl18.place then
				tbl18.status = "Already in the Second Sea"
				return true
			end
			local v8 = fn69()
			if not v8 then
				tbl18.status = "Cannot read your level - stopped"
				return false
			end

			if v8 < tbl18.level then
				tbl18.status = ("Level %d - Puff needs %d. Nothing to bypass; go and level up."):format(v8, tbl18.level)
				return false
			end
			fn72(false)

			if fn71() ~= true then
				if not fn82() then
					if fn76() then
						tbl18.status = "Aborted"
					else
						tbl18.status = "Could not pick up the World Scroll - stopped"
					end

					return false
				end

				if not fn84() then
					if fn76() then
						tbl18.status = "Aborted"
					end

					return false
				end
			end

			if not fn85() then
				if fn76() then
					tbl18.status = "Aborted"
				end

				return false
			end

			tbl18.status = "Teleporting to the Second Sea"
			return true
		end

		tbl5.sea = {
			state = tbl18,
			trip = fn86,
			quest = function(stopFn)
				if tbl18.on then
					tbl18.status = "The Second Sea trip is already running"
					return false
				end
				local v8 = fn69()
				if not v8 then
					tbl18.status = "Cannot read your level - stopped"
					return false
				end

				if v8 < tbl18.level then
					tbl18.status = ("Level %d - Puff needs %d."):format(v8, tbl18.level)
					return false
				end
				local v9 = tbl18
				tbl18.on = true
				v9.stopFn = stopFn
				local v10 = tbl18
				tbl18.deadline = os.clock() + n14
				v10.timedOut = false

				local ok, result = pcall(function()
					fn72(false)

					if not fn82() then
						if fn76() then
							tbl18.status = "Aborted"
						else
							tbl18.status = "Could not pick up the World Scroll - stopped"
						end

						return false
					end

					if fn71() == true then
						tbl18.status = "Scroll in hand - Puff's gate is already open"
						return true
					end

					if not fn84() then
						if fn76() then
							tbl18.status = "Aborted"
						end

						return false
					end

					tbl18.status = "Gatekeeper Puff opened the gate"
					return true
				end)

				local v11 = tbl18
				tbl18.on = false
				v11.stopFn = nil
				tbl18.deadline = nil
				fn77()
				if not ok then
					tbl18.status = "Errored - stopped (see the console)"
					return false
				end
				return result == true
			end,
			cleanup = fn77,
			stats = fn69,
			hasScroll = fn75,
			gateOpen = fn71,
		}

		local v8 = tbl16.Move3:AddSection("Second Sea", "map")
		local v9 = v8:AddParagraph({ Title = "Second Sea", Content = "Idle" })

		fn5("SecondSeaStatus", function()
			local status = nil

			while true do
				task.wait(0.4)

				if tbl18.status ~= status then
					status = tbl18.status

					pcall(function()
						v9:SetDesc(status)
					end)
				end
			end
		end)

		local GPOSecondSeaGo = v8:AddToggle("GPOSecondSeaGo", {
			Title = "Auto Second Sea",
			Description = "Grabs the World Scroll, opens the Reverse Mountain gate with Gatekeeper Puff and walks into the teleporter. Needs level 325. Turns itself off on arrival or failure. Turn Auto Farm off first - they share the mover.",
			Default = false,
		})

		local function fn87(status)
			tbl18.status = status
			notify("Skull Hub", status, 8)
			tbl18.settling = true

			pcall(function()
				GPOSecondSeaGo:SetValue(false)
			end)

			tbl18.settling = false
		end

		GPOSecondSeaGo:OnChanged(function(arg)
			if tbl18.settling then
				return
			end

			if not arg then
				if tbl18.on then
					tbl18.on = false
					tbl18.status = "Aborting…"
				elseif tbl2.inMenu then
					tbl18.status = "Idle"
				end

				return
			end

			if tbl18.on then
				return
			end

			if tbl2.menuHold("GPOSecondSeaGo") then
				tbl18.status = tbl2.MENU_STATUS
				return
			end
			local v10 = tbl2.why()
			if v10 then
				fn87(v10)
				return
			end

			if tbl8.flagged then
				fn87("You are flagged this session - rejoin before travelling.")
				return
			end

			if tbl4.on then
				fn87("Turn Auto Farm off first - it drives the same mover.")
				return
			end
			local v11 = fn69()
			if v11 and v11 < tbl18.level then
				fn87(("Level %d - Puff needs %d."):format(v11, tbl18.level))
				return
			end
			tbl18.on = true

			fn5("SecondSeaTrip", function()
				local ok, result = pcall(fn86)

				if not ok then
					tbl18.status = "Errored - stopped (see the console)"
				end

				tbl18.on = false
				fn77()
				tbl18.settling = true

				pcall(function()
					GPOSecondSeaGo:SetValue(false)
				end)

				tbl18.settling = false
				notify("Skull Hub", tbl18.status, ok and result and 6 or 10)
			end)
		end)
	end

	fn68()

	local function fn69()
		local tbl18 = {
			{ "Town of Beginnings", -531.9, 5.3, -3456 },
			{ "Sandora", -1710.2, 4.1, -3377.1 },
			{ "Kori Island", -4245, 169.5, -2990.6, note = "The only anchor on it is 170 studs up." },
			{ "Marine Fort F-1", 559.5, 19.2, -4561.1 },
			{ "Island Of Zou", -2991.9, 8.4, -5331 },
			{ "Shell's Town", -1379.8, 3.2, -5063.6 },
			{ "Roca Island", 1532.4, 155.7, -6573.1, note = "Anchor is 156 studs up, on the plateau." },
			{ "Orange Town", -4550.2, 6.3, -6681.8 },
			{ "Restaurant Baratie", -2968.3, 6.6, -6697.6 },
			{ "Logue Town", -6853.4, 25.3, -7647.2 },
			{ "Colosseum", -2044.1, 7.8, -7789.2 },
			{ "Mysterious Cliff", 84, 412.8, -8279.7, note = "Anchor is 413 studs up the cliff." },
			{ "A rock", 2540.5, 7.3, -8366.2 },
			{ "Reverse Mountain", -8011.4, 69.6, -8540.1, note = "Drops you at Gatekeeper Puff." },
			{ "Sphinx Island", -4268.4, 42.2, -8942.8 },
			{ "Shark Park", -1889.7, 12.6, -10231.5 },
			{ "Marine Base G-1", -5807.5, 17.1, -11332.1 },
			{ "Gravito's Fort", 184.7, 41.5, -11658.7 },
			{ "Coco Island", -3161.8, 7.5, -11715.2 },
			{ "Fishman Cave", 1821.3, 4.4, -12181, note = "The surface cave mouth, not the island." },
			{ "???? Shrine", -7348.9, 0.4, -14950.2, note = "The World Scroll pedestal." },
			{
				"Land of the Sky",
				3479.3,
				1439,
				-9071.9,
				unproven = true,
				note = "A SKY island 1,439 studs up. No altitude near that has ever been flown here without a kick - expect this one to fail.",
			},
			{
				"Fishman Island",
				7731.1,
				-2176.1,
				-17222.7,
				kind = "fishman",
				note = "Takes the game's own dive route. About nine thousand studs - give it minutes.",
			},
			{
				"Second Sea",
				0,
				0,
				0,
				kind = "sea",
				note = "A different PLACE. Needs level 325 and a World Scroll. The hub does not survive the teleport - turn Settings -> Auto Execute on first.",
			},
		}

		local tbl19 = {
			{ "Desert Kingdom", -3743, 14.4, 363.6 },
			{ "Rovo Island", -6207.6, 13.6, 416.4 },
			{ "Foro Island", 8358.4, 4.8, 4342.7 },
			{
				"Mysterious Reef",
				10137.3,
				-74.7,
				-25.5,
				note = "Anchor is 75 studs BELOW sea level - it is a reef.",
			},
			{ "Sakura Stronghold", 6485.1, 93.7, -142.5 },
			{ "Sashi Island", -1567.7, 39.1, -6497.1 },
			{
				"Thriller Bark",
				9522.9,
				18.1,
				-7081.7,
				note = "The island box reaches 3,535 studs up; the anchor is at sea level.",
			},
			{ "Sett's Arena", -7804.3, 149.3, -9630.6, note = "Anchor is 149 studs up." },
			{ "Dokkan Island", 9328.2, 176, -11903.3, note = "Anchor is 176 studs up." },
			{ "Rose Kingdom", 6945, 40.5, 11146.5 },
			{ "Spirit Island", -1330.6, 69.4, 10196.9, note = "Anchor is 69 studs up." },
			{ "Whole Cake Island", -6678.1, 14.3, 10258.2 },
			{ "Blossom Falls", -2988.1, 119.9, 12816.7, note = "Anchor is 120 studs up." },
			{
				"Turtleback Cave",
				1774,
				28,
				-10600,
				note = "Juzo the Diamondback's island. This anchor is the measured arena floor, not the box centre - the centre is 105 studs higher, inside the hill.",
			},
			{
				"Colosseum of Arc",
				1911,
				179,
				6560,
				note = "Anchored on Mei, who stands 154 studs up just outside the arena - the Colosseum itself has no quest giver inside it.",
			},
			{ "Impel Base", 5912, 45, -10210, note = "No quest giver - island centre." },
			{
				"Umi Island",
				12786,
				-18,
				2762,
				note = "No quest giver - island centre. The far east of the map.",
			},
			{
				"Reverse Mountain",
				-9044,
				113,
				435,
				note = "No quest giver - island centre. NOT the First Sea's Reverse Mountain; this is a different place at different coordinates.",
			},
			{
				"Ghost Ship",
				5134,
				-570,
				-11901,
				unproven = true,
				note = "Centre sits 570 studs BELOW sea level. Nothing here has ever routed down to that depth outside the Fishman bubble - expect this one to fail.",
			},
			{
				"Mirror World",
				-8115,
				19955,
				9528,
				unproven = true,
				note = "Centre is TWENTY THOUSAND studs up. The measured limits are a ~600-stud continuous budget and a glide band a few dozen studs over the water - this is not reachable by sailing and is listed only so it is not silently missing.",
			},
		}

		if game.PlaceId ~= 7465136166 then
			tbl19 = tbl18
		end

		local tbl20 = {}
		local tbl21 = {}

		for _, v8 in ipairs(tbl19) do
			tbl20[v8[1]] = v8
			tbl21[#tbl21 + 1] = v8[1]
		end

		table.sort(tbl21)
		local tbl22 = { on = false, kind = "surface", pick = tbl21[1], status = "Idle", settling = false }

		local function fn70()
			return not tbl22.on
		end

		local function fn71(arg)
			local vector = Vector3.new(arg[2], arg[3], arg[4])
			local ok, result = pcall(fn46)
			if not ok or type(result) ~= "table" then
				return vector
			end
			local v8, v9, v10 = pairs(result)
			local v11 = nil
			local position = nil

			for _, v12 in v8, v9, v10 do
				if typeof(v12) == "CFrame" then
					local magnitude = (v12.Position - vector).Magnitude

					if magnitude < 400 and (not v11 or magnitude < v11) then
						position = v12.Position
						v11 = magnitude
					end
				end
			end

			return position or vector
		end

		local function fn72(arg)
			if not tbl5.whichSea() and arg.kind ~= "sea" then
				return "Island travel only works in the First or Second Sea - you are somewhere else."
			end

			if tbl8.flagged then
				return "You are flagged this session - rejoin before travelling."
			end

			if tbl4.on then
				return "Turn Auto Farm off first - it drives the same mover."
			end
			local fishman = tbl5.fishman
			local sea = tbl5.sea
			if fishman and fishman.state and fishman.state.on then
				return "The Fishman Island route is already running - stop that first."
			end

			if sea and sea.state and sea.state.on then
				return "The Auto Second Sea toggle is already running - stop that first."
			end

			if arg.kind == "sea" then
				local stats = sea and sea.stats and sea.stats()
				local level = sea and sea.state and sea.state.level or 325
				if stats and stats < level then
					return ("Level %d - the Second Sea needs %d."):format(stats, level)
				end
			end

			return nil
		end

		local function fn73(arg)
			if arg.kind == "fishman" then
				local fishman = tbl5.fishman
				if not (fishman and fishman.trip) then
					tbl22.status = "Fishman route unavailable."
					return false
				end

				if fishman.here and fishman.here(false) then
					tbl22.status = "Already on Fishman Island."
					return true
				end
				fishman.state.on = true
				local ok, result = pcall(fishman.trip)
				fishman.state.on = false
				pcall(fishman.cleanup)
				tbl22.status = fishman.state.status
				return ok and result and true or false
			end

			if arg.kind == "sea" then
				local sea = tbl5.sea
				if not (sea and sea.trip) then
					tbl22.status = "Second Sea route unavailable."
					return false
				end
				sea.state.on = true
				local ok, result = pcall(sea.trip)
				sea.state.on = false
				pcall(sea.cleanup)
				tbl22.status = sea.state.status
				return ok and result and true or false
			end

			local v8 = fn71(arg)
			tbl22.status = ("Travelling to %s"):format(arg[1])
			local v9 = fn36(v8, 60, fn70)
			if fn70() then
				tbl22.status = "Aborted"
				return false
			end

			if not v9 and not tbl8.flagged then
				local character = localPlayer.Character
				local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

				if humanoidRootPart then
					local position = humanoidRootPart.Position
					local magnitude = (Vector2.new(position.X, position.Z) - Vector2.new(v8.X, v8.Z)).Magnitude
					if magnitude <= 150 then
						tbl22.status = ("Arrived at %s - %d studs from the anchor, close enough."):format(arg[1], math.floor(magnitude))
						return true
					end
				end
			end

			if v9 then
				tbl22.status = ("Arrived at %s"):format(arg[1])
			else
				local v10 = tbl22
				local status = tbl8.flagged and "Flagged mid-trip - stopped. Rejoin before trying again."

				if not status then
					status = ("Could not reach %s - gave up. %s"):format(arg[1], tbl4.status or "")
				end

				v10.status = status
			end

			return v9
		end

		local v8 = tbl16.Move3:AddSection("Island Travel", "compass")
		local v9 = v8:AddParagraph({ Title = "Island Travel", Content = "Idle" })

		fn5("TravelStatus", function()
			local v10 = nil

			while true do
				task.wait(0.4)
				local status = tbl22.status

				if tbl22.on and tbl22.kind == "surface" and tbl4.status and tbl4.status ~= "" then
					status = tbl4.status
				elseif tbl22.on and tbl22.kind == "fishman" then
					local fishman = tbl5.fishman
					local status2 = fishman and fishman.state and fishman.state.status

					if status2 and status2 ~= "" then
						status = status2
					end
				end

				if status ~= v10 then
					v10 = status

					pcall(function()
						v9:SetDesc(status)
					end)
				end
			end
		end)

		v8:AddDropdown("GPOTravelPick", {
			Title = "Destination",
			Description = game.PlaceId == 7465136166 and ("Where to sail. All %d islands in the Second Sea. Thirteen are anchored on a real quest giver; the rest use the island's own centre and say so."):format(#tbl21) or "Where to sail. Every island in the First Sea, plus the Second Sea.",
			Values = tbl21,
			Multi = false,
			Default = tbl22.pick,
		}):OnChanged(function(pick)
			if type(pick) ~= "string" or not tbl20[pick] then
				return
			end
			tbl22.pick = pick
			local v10 = tbl20[pick]

			if not tbl22.on then
				tbl22.status = v10.note and ("%s - %s"):format(pick, v10.note) or ("%s - ready."):format(pick)
			end

			if v10.unproven then
				notify("Skull Hub", v10.note, 10)
			end
		end)

		local GPOTravelGo = v8:AddToggle("GPOTravelGo", {
			Title = "Auto Travel",
			Description = "Sails to the destination above and switches itself off on arrival. Turn it off to abort. Turn Auto Farm off first - they share the mover.",
			Default = false,
		})

		GPOTravelGo:OnChanged(function(arg)
			if tbl22.settling then
				return
			end

			if not arg then
				if tbl22.on then
					tbl22.on = false
					tbl22.status = "Aborting…"
				elseif tbl2.inMenu then
					tbl22.status = "Idle"
				end

				return
			end

			if tbl22.on then
				return
			end

			if tbl2.menuHold("GPOTravelGo") then
				tbl22.status = tbl2.MENU_STATUS
				return
			end
			local v10 = tbl20[tbl22.pick]
			local status

			if not v10 then
				status = "Pick a destination first."
			else
				status = tbl2.why() or fn72(v10)
			end

			if status then
				tbl22.status = status
				notify("Skull Hub", status, 8)
				tbl22.settling = true

				pcall(function()
					GPOTravelGo:SetValue(false)
				end)

				tbl22.settling = false
				return
			end

			tbl22.on = true
			tbl22.kind = v10.kind or "surface"
			tbl22.status = ("Starting - %s"):format(v10[1])

			fn5("TravelTrip", function()
				local ok, result = pcall(fn73, v10)

				if not ok then
					tbl22.status = "Errored - stopped (see the console)"
				end

				tbl22.on = false
				fn40()
				tbl22.settling = true

				pcall(function()
					GPOTravelGo:SetValue(false)
				end)

				tbl22.settling = false
				notify("Skull Hub", tbl22.status, ok and result and 6 or 10)
			end)
		end)
	end

	fn69()

	local function fn70()
		local wh = {
			url = "",
			on = false,
			catches = true,
			catchMin = "Legendary",
			fruits = true,
			fruitStores = true,
			milestones = true,
			problems = true,
			summary = true,
			summaryMins = 30,
			showName = false,
			mention = "",
			sent = 0,
			failed = 0,
			lastErr = nil,
			lastAt = 0,
		}

		tbl5.wh = wh
		local str = "https://github.com/hungquan99/Interface/blob/main/Images/skullhub.png?raw=true"
		local str2 = "Grand Piece Online"
		local tbl18 = { Common = 1, Uncommon = 2, Rare = 3, Epic = 4, Legendary = 5, Mythical = 6 }
		local tbl19 = { good = 3066993, info = 3447003, warn = 16098851, bad = 15158332, rare = 10181046 }
		local tbl20 = {}
		local flag2 = false

		local function fn71()
			local env2 = getfenv(0)
			return tbl.request and env2.request or tbl.http_request and env2.http_request or type(env2.syn) == "table" and type(env2.syn.request) == "function" and env2.syn.request or nil
		end

		local function fn72(arg)
			local v8 = fn71()
			if not v8 then
				wh.lastErr = "This executor has no request function - webhooks are unavailable."
				return false
			end

			local ok, result = pcall(function()
				return game:GetService("HttpService"):JSONEncode(arg)
			end)

			if not ok then
				wh.lastErr = "Could not encode the payload."
				return false
			end
			local ok2, result2 = pcall(v8, { Url = wh.url, Method = "POST", Headers = { ["Content-Type"] = "application/json" }, Body = result })
			if not ok2 then
				wh.lastErr = "request() errored: " .. fn2(result2)
				return false
			end
			local n12 = tonumber(result2 and (result2.StatusCode or result2.Status)) or 0

			if n12 == 429 then
				local n13 = 5

				pcall(function()
					local data = game:GetService("HttpService"):JSONDecode(result2.Body)

					if type(data) == "table" and tonumber(data.retry_after) then
						n13 = math.clamp(tonumber(data.retry_after), 1, 60)
					end
				end)

				task.wait(n13)
				return false, true
			end

			if n12 >= 200 and n12 < 300 then
				wh.sent = wh.sent + 1
				wh.lastAt = os.time()
				wh.lastErr = nil
				return true
			end

			wh.lastErr = ("Discord answered %d%s"):format(n12, (n12 == 401 or n12 == 404) and " - check the URL" or "")
			return false
		end

		local function fn73()
			if flag2 then
				return
			end
			flag2 = true

			fn5("WebhookPump", function()
				while true do
					local v8 = table.remove(tbl20, 1)

					if not v8 then
						break
					else
						local v9, v10 = fn72(v8)

						if not v9 then
							wh.failed = wh.failed + 1

							if v10 and not v8._retried then
								v8._retried = true
								table.insert(tbl20, 1, v8)
							end
						end

						task.wait(2.5)
					end
				end

				flag2 = false
			end)
		end

		local function fn74(arg, arg2)
			local v8 = fn2(arg)
			if #v8 <= arg2 then
				return v8
			end
			return v8:sub(1, arg2 - 1) .. "…"
		end

		local function fn75()
			return ("||[%s] %s||"):format(tostring(fn43()), wh.showName and localPlayer.Name or "Hidden")
		end

		wh.push = function(arg, arg2, arg3, arg4, arg5, arg6)
			if not wh.on or wh.url == "" then
				return
			end

			if arg == "catch" and not wh.catches then
				return
			end

			if arg == "fruit" and not wh.fruits then
				return
			end

			if arg == "fruitstore" and not wh.fruitStores then
				return
			end

			if arg == "milestone" and not wh.milestones then
				return
			end

			if arg == "problem" and not wh.problems then
				return
			end

			if arg == "summary" and not wh.summary then
				return
			end

			if #tbl20 > 40 then
				return
			end
			local tbl21 = {}
			local tbl22 = { name = "Name", value = fn75() }
			local tbl23 = { name = fn74(arg2, 256), value = fn74(arg3 ~= nil and arg3 or "-", 1024) }
			tbl21[1] = tbl22
			tbl21[2] = tbl23

			if type(arg5) == "table" then
				for _, v8 in ipairs(arg5) do
					if not (#tbl21 >= 25) then
						tbl21[#tbl21 + 1] = {
							name = fn74(v8[1], 256),
							value = fn74(v8[2] ~= nil and v8[2] or "-", 1024),
							inline = v8[3] ~= false,
						}

						continue
					end

					break
				end
			end

			table.insert(tbl20, {
				username = "Skull Hub",
				content = arg6 and wh.mention ~= "" and "<@" .. wh.mention .. ">" or nil,
				embeds = {
					{
						title = str2,
						color = arg4 or tbl19.info,
						fields = tbl21,
						footer = { text = "Skull Hub", icon_url = str },
						timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
					},
				},
			})

			fn73()
		end

		wh.problem = function(arg, arg2)
			wh.push("problem", arg, arg2, tbl19.bad, nil, true)
		end

		wh.milestone = function(arg, arg2)
			wh.push("milestone", arg, arg2, tbl19.good)
		end

		wh.catch = function(arg, arg2, arg3)
			if (tbl18[arg2] or 0) < (tbl18[wh.catchMin] or 5) then
				return
			end
			wh.push("catch", ("Caught a %s"):format(tostring(arg)), ("Rarity: **%s**"):format(tostring(arg2)), tbl19.rare, arg3, true)
		end

		wh.fruitCaught = function(arg, arg2, arg3)
			wh.push("fruit", ("Fished up a Devil Fruit: %s"):format(tostring(arg)), ("Rarity: **%s**"):format(tostring(arg2 or "?")), tbl19.rare, arg3, true)
		end

		wh.fruitStored = function(arg, arg2, arg3)
			wh.push("fruitstore", ("Stored %s in Fruit Storage"):format(tostring(arg)), arg2, tbl19.good, arg3)
		end

		local Connection = tbl16.Hook1:AddSection("Connection", "webhook")
		local v8 = Connection:AddParagraph({ Title = "Status", Content = "Off." })

		fn5("WebhookStatus", function()
			local v9 = nil

			while true do
				task.wait(1)
				local str3

				if not wh.on then
					str3 = "Off."
				elseif wh.url == "" then
					str3 = "On, but no URL has been pasted yet."
				else
					str3 = ("Sent %d, failed %d."):format(wh.sent, wh.failed)

					if wh.lastAt > 0 then
						str3 ..= (" Last at %s."):format(os.date("%H:%M:%S", wh.lastAt))
					end
				end

				if wh.lastErr then
					str3 ..= "\n\n⚠ " .. wh.lastErr
				end

				if str3 ~= v9 then
					v9 = str3

					pcall(function()
						v8:SetDesc(str3)
					end)
				end
			end
		end)

		Connection:AddInput("GPOWebhookURL", {
			Title = "Webhook URL",
			Placeholder = "https://discord.com/api/webhooks/...",
			Default = "",
			Finished = true,
			Callback = function(arg)
				local url = tostring(arg or ""):gsub("^%s+", ""):gsub("%s+$", "")

				if url ~= "" and not url:match("^https://[%w%.]*discord[%w%.]*%.com/api/webhooks/") then
					wh.lastErr = "That does not look like a Discord webhook URL."
				else
					wh.lastErr = nil
				end

				wh.url = url
			end,
		})

		Connection:AddInput("GPOWebhookMention", {
			Title = "Mention ID",
			Description = "Your Discord user id. Pings you on problems and rare catches. Leave empty for no ping.",
			Placeholder = "123456789012345678",
			Default = "",
			Finished = true,
			Callback = function(arg)
				wh.mention = tostring(arg or ""):gsub("%D", "")
			end,
		})

		Connection:AddToggle("GPOWebhookOn", {
			Title = "Send to Discord",
			Description = "Nothing is sent while this is off.",
			Default = false,
			Callback = function(on)
				wh.on = on
			end,
		})

		Connection:AddButton({
			Title = "Send a test message",
			Description = "Posts one embed so you can confirm the URL works.",
			Callback = function()
				if wh.url == "" then
					notify("Skull Hub", "Paste a webhook URL first.", 6)
					return
				end
				local on = wh.on
				wh.on = true
				local push = wh.push
				local tbl21 = {}
				local tbl22 = {}
				local str3 = tostring(game.PlaceId)
				tbl22[1] = "Place"
				tbl22[2] = str3
				tbl22[3] = true
				tbl21[1] = tbl22
				push("summary", "Skull Hub is connected", "If you can read this, the webhook works.", 3447003, tbl21, true)
				wh.on = on
				notify("Skull Hub", "Test queued - check the channel.", 6)
			end,
		})

		local v9 = tbl16.Hook2:AddSection("What to report", "list-checks")

		v9:AddToggle("GPOWebhookCatches", {
			Title = "Report catches",
			Description = "One message per fish at or above the rarity below.",
			Default = true,
			Callback = function(catches)
				wh.catches = catches
			end,
		})

		v9:AddDropdown("GPOWebhookCatchMin", {
			Title = "Only at or above",
			Description = "A Common every twelve seconds is not a notification.",
			Values = { "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythical" },
			Default = "Legendary",
			Multi = false,
			Callback = function(arg)
				wh.catchMin = tostring(arg)
			end,
		})

		v9:AddToggle("GPOWebhookFruits", {
			Title = "Report Devil Fruit catches",
			Description = "Every Devil Fruit you fish up, whatever the rarity above. Pings you. Works while fishing by hand too.",
			Default = true,
			Callback = function(fruits)
				wh.fruits = fruits
			end,
		})

		v9:AddToggle("GPOWebhookFruitStore", {
			Title = "Report fruits stored",
			Description = "Each Devil Fruit that Auto Store Fruits puts into Fruit Storage.",
			Default = true,
			Callback = function(fruitStores)
				wh.fruitStores = fruitStores
			end,
		})

		v9:AddToggle("GPOWebhookMilestones", {
			Title = "Report milestones",
			Description = "Bait crafted, bait restocked, catch sold.",
			Default = true,
			Callback = function(milestones)
				wh.milestones = milestones
			end,
		})

		v9:AddToggle("GPOWebhookProblems", {
			Title = "Report problems",
			Description = "The rod getting unstuck, running out of bait, the anti-cheat flag, and the loop stopping. This is the one worth leaving on.",
			Default = true,
			Callback = function(problems)
				wh.problems = problems
			end,
		})

		local Summary = tbl16.Hook2:AddSection("Summary", "bell")

		Summary:AddToggle("GPOWebhookSummary", {
			Title = "Periodic summary",
			Description = "A running total on the interval below.",
			Default = true,
			Callback = function(summary)
				wh.summary = summary
			end,
		})

		Summary:AddSlider("GPOWebhookMins", {
			Title = "Summary every",
			Description = "Minutes.",
			Default = 30,
			Min = 5,
			Max = 180,
			Rounding = 0,
			Callback = function(arg)
				wh.summaryMins = tonumber(arg) or 30
			end,
		})

		tbl16.Hook2:AddSection("Privacy", "eye-off"):AddToggle("GPOWebhookName", {
			Title = "Include my username",
			Description = "Off by default - your account name does not leave the machine unless you turn this on.",
			Default = false,
			Callback = function(showName)
				wh.showName = showName
			end,
		})

		fn5("WebhookSummary", function()
			local now = os.clock()

			while true do
				task.wait(20)
				local fish = tbl5.fish
				local summary = wh.on and wh.summary and fish

				if summary then
					summary = os.clock() - now >= (wh.summaryMins or 30) * 60
				end

				if summary then
					now = os.clock()
					local on = fish.on
					local flag3

					if on then
						flag3 = on
					else
						flag3 = (fish.casts or 0) > 0
					end

					if flag3 then
						local push = wh.push
						local tbl21 = {}
						local tbl22 = {}
						local str3 = tostring(fish.casts or 0)
						tbl22[1] = "Casts"
						tbl22[2] = str3
						tbl22[3] = true
						local tbl23 = {}
						local str4 = tostring(fish.caught or 0)
						tbl23[1] = "Caught"
						tbl23[2] = str4
						tbl23[3] = true
						local tbl24 = {}
						local str5 = tostring(fish.sold or 0)
						tbl24[1] = "Sold"
						tbl24[2] = str5
						tbl24[3] = true
						local tbl25 = {}
						local str6 = tostring(fish.resets or 0)
						tbl25[1] = "Unstuck"
						tbl25[2] = str6
						tbl25[3] = true
						local tbl26 = {}
						local str7 = tostring(fish.crafted or 0)
						tbl26[1] = "Bait crafted"
						tbl26[2] = str7
						tbl26[3] = true
						local tbl27 = {}
						local str8 = tostring(fish.bought or 0)
						tbl27[1] = "Bait bought"
						tbl27[2] = str8
						tbl27[3] = true
						local tbl28 = {}
						local str9 = fish.on and "yes" or "no"
						tbl28[1] = "Running"
						tbl28[2] = str9
						tbl28[3] = true
						local tbl29 = {}
						local v10 = fn2(fish.status)
						tbl29[1] = "Status"
						tbl29[2] = v10
						tbl29[3] = false
						tbl21[1] = tbl22
						tbl21[2] = tbl23
						tbl21[3] = tbl24
						tbl21[4] = tbl25
						tbl21[5] = tbl26
						tbl21[6] = tbl27
						tbl21[7] = tbl28
						tbl21[8] = tbl29
						push("summary", "Fishing summary", nil, 3447003, tbl21)
					end
				end
			end
		end)
	end

	fn70()

	local function fn71()
		local fish = {
			on = false,
			status = "Idle",
			bait = "Best",
			autoSell = true,
			sell = { Common = true, Uncommon = true, Rare = true, Epic = false, Legendary = false },
			holdAtMaxPeli = false,
			dropAtMax = false,
			dropKeep = 0,
			dropBusy = false,
			dropNextAt = 0,
			dropFails = 0,
			dropped = 0,
			dropStatus = "Idle",
			casts = 0,
			caught = 0,
			sold = 0,
			resets = 0,
			stallSig = nil,
			stallAt = nil,
			lastGood = 0,
			craftOn = false,
			buyOn = false,
			craft = { ["Rare Fish Bait"] = true, ["Legendary Fish Bait"] = true, ["Common Fish Bait"] = false },
			craftMax = 10,
			buyAmount = 50,
			baitFloor = 20,
			crafted = 0,
			bought = 0,
			home = nil,
			restockFail = 0,
			homeFail = 0,
			restockNext = 0,
			client = nil,
			clientTool = nil,
			sellBroken = false,
			aimSea = true,
			aimDist = 70,
			spot = nil,
			bob = nil,
			bobT = nil,
			bobErr = nil,
			bobMiss = 0,
			spotFail = 0,
			bites = 0,
			lost = { land = 0, moved = 0, nobite = 0, reset = 0, reel = 0, gone = 0, miss = 0 },
			reelSense = 8,
			reelMode = "Legit",
			human = { on = true, reelMin = 7, reelMax = 14, miss = 4, delayMax = 4, every = 30, breakMax = 150 },
			humanLeft = nil,
			plannedMiss = false,
			storeFruit = true,
			fruitStatus = "Idle",
		}

		tbl5.fish = fish
		local n12 = 8
		local n13 = 45
		local n14 = 60
		local n15 = 240
		local n16 = 12
		local n17 = 0.75
		local n18 = 40
		local n19 = 5
		local tbl18 = { Common = 1, Uncommon = 2, Rare = 3, Epic = 4, Legendary = 5, Mythical = 6 }
		local tbl19 = { ["Common Fish Bait"] = 1, ["Rare Fish Bait"] = 2, ["Legendary Fish Bait"] = 3 }

		local function fn72()
			if fish.td ~= nil then
				return fish.td or nil
			end

			local ok, result = pcall(function()
				return require(v6.Modules.ToolDesc)
			end)

			fish.td = ok and type(result) == "table" and result or false
			return fish.td or nil
		end

		local function fn73(arg)
			local v8 = fn72()
			v8 = v8 and v8[arg]
			local flag2 = type(v8) == "table"

			if flag2 then
				flag2 = tostring(v8.Type or "")
			end

			return flag2 or nil
		end

		local function fn74(arg)
			local v8 = fn72()
			local v9 = v8 and v8[arg]
			local flag2 = type(v9) == "table"

			if flag2 then
				flag2 = tostring(v9.Rare or "")
			end

			return flag2 or nil
		end

		local fruitStorage = v6:FindFirstChild("Events") and v6.Events:FindFirstChild("FruitStorage")
		fish.fruitTry = {}
		fish.fruitSkip = {}
		fish.fruitKeyMap = {}
		local tbl20 = { Fruit = true, FruitRemover = true }

		local function fn75(arg)
			if not arg then
				return nil
			end
			local v8 = fish.fruitKeyMap[arg]
			if v8 then
				return v8
			end

			if tbl20[fn73(arg) or ""] then
				return arg
			end
			local match = tostring(arg):match("^([^%-]+)%-")
			local v9

			if match then
				v9 = tbl20[fn73(match) or ""]
			else
				v9 = match
			end

			if v9 then
				return match
			end
			return nil
		end

		local function fn76()
			local Inventory = tbl5.invJSON("Inventory")
			local tbl21 = {}
			if not Inventory then
				return nil
			end

			for k, v8 in pairs(Inventory) do
				if tbl20[fn73(k) or ""] then
					tbl21[k] = tonumber(v8) or 0
				end
			end

			return tbl21
		end

		local function fn77()
			local ok, result = pcall(function()
				local g = getrenv and getrenv()._G
				if type(g) == "table" and type(g.HasItem) == "function" then
					return g.HasItem(localPlayer, "Prestige Fruitbag")
				end
				return nil
			end)

			if ok and type(result) == "boolean" then
				return result
			end
			local Inventory = tbl5.invJSON("Inventory")
			return Inventory ~= nil and Inventory["Prestige Fruitbag"] ~= nil
		end

		local function fn78(arg)
			local v8 = fn72()
			local v9 = v8 and v8[arg]
			return (type(v9) == "table" and tonumber(v9.Max) or 1) + (type(v9) == "table" and tostring(v9.Type) == "Fruit" and fn77() and 1 or 0)
		end

		local function fn79(arg)
			local ok, result = pcall(function()
				local g = getrenv and getrenv()._G
				if type(g) == "table" and type(g.HasItem) == "function" then
					return g.HasItem(localPlayer, arg)
				end
				return nil
			end)

			if ok and type(result) == "boolean" then
				return result
			end
			local Inventory = tbl5.invJSON("Inventory")
			return Inventory ~= nil and Inventory[arg] ~= nil
		end

		local function fn80(arg)
			if arg == "Dark Root" then
				return false
			end
			local gamepasses = fn42()
			gamepasses = gamepasses and gamepasses:FindFirstChild("Gamepasses")
			gamepasses = gamepasses and gamepasses:FindFirstChild("FruitBag")
			if fn79("Fruit Bag") or fn79("Prestige Fruitbag") or gamepasses and gamepasses.Value ~= false then
				return false
			end
			local v8 = fn76()
			if not v8 then
				return false
			end

			for k, v9 in pairs(v8) do
				if k ~= "Dark Root" and v9 > 0 and fn73(k) == "Fruit" then
					return true, k
				end
			end

			return false
		end

		local function fn81()
			local tbl21 = {}
			local character = localPlayer.Character
			character = character and character:FindFirstChildOfClass("Tool")

			if character and character:FindFirstChild("FruitEater") then
				tbl21[#tbl21 + 1] = { tool = character, equipped = true }
			end

			local backpack = localPlayer:FindFirstChildOfClass("Backpack")

			if backpack then
				for _, child in ipairs(backpack:GetChildren()) do
					if child:IsA("Tool") and child:FindFirstChild("FruitEater") then
						tbl21[#tbl21 + 1] = { tool = child, equipped = false }
					end
				end
			end

			return tbl21
		end

		local function fn82(arg, arg2, arg3)
			local name = arg.Name
			local v8 = fish.fruitSkip[name]
			if v8 and os.clock() < v8 then
				return false, ("refused by the server, retrying in %ds"):format(math.max(0, math.floor(v8 - os.clock())))
			end

			if v8 then
				fish.fruitSkip[name] = nil
			end

			if arg3 and name ~= "Dark Root" then
				return false, ("storage already holds %s (no Fruit Bag on this account)"):format(arg3)
			end
			local v9 = fn75(name)

			if v9 and arg2 then
				local n20 = arg2[v9] or 0
				local v10 = fn78(v9)
				if v10 <= n20 then
					return false, ("already at max (%d/%d stored)"):format(n20, v10)
				end
			end

			return true, nil
		end

		local function fn83()
			local v8 = fn81()
			if #v8 == 0 then
				fish.fruitStatus = "Idle - no Devil Fruit in the backpack"
				return false
			end
			local v9 = fn76()
			local v10, v11 = fn80("")

			if not v10 then
				v11 = nil
			end

			local tbl21 = {}
			local v12 = nil

			for _, v13 in ipairs(v8) do
				local v14, v15 = fn82(v13.tool, v9, v11)

				if v14 then
					v12 = v12 or v13
				else
					tbl21[#tbl21 + 1] = ("%s: %s"):format(v13.tool.Name, v15 or "?")
				end
			end

			if not v12 then
				fish.fruitStatus = ("Nothing left to store - %s"):format(table.concat(tbl21, " | "))
				return false
			end
			local tool = v12.tool

			if not v12.equipped then
				local character = localPlayer.Character
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")

				if humanoid then
					pcall(function()
						humanoid:EquipTool(tool)
					end)
				elseif character then
					tool.Parent = character
				end

				fish.fruitStatus = ("Equipping %s to store it"):format(tool.Name)
				task.wait(0.35)
				return true
			end

			local fruitEater = tool:FindFirstChild("FruitEater")
			fruitEater = fruitEater and fruitEater:FindFirstChild("Busy")
			if fruitEater and fruitEater.Value == true then
				fish.fruitStatus = ("%s is busy - waiting"):format(tool.Name)
				return true
			end

			if not fruitStorage then
				fish.fruitStatus = "FruitStorage remote not found - cannot store"
				return false
			end
			local name = tool.Name
			local str = fn75(name)
			local v13 = str and v9
			local n20 = 0

			if v13 then
				n20 = v9[str] or 0
			end

			local v14 = fish
			local str2 = "Storing %s%s"
			local format = str2.format
			local str3

			if str then
				str3 = (" (%d/%d held)"):format(v9 and v9[str] or 0, fn78(str))
			else
				str3 = str
			end

			v14.fruitStatus = format(str2, name, str3 or "")

			pcall(function()
				fruitStorage:InvokeServer(true)
			end)

			local now = os.clock()
			local flag2 = false

			while true do
				task.wait(0.1)
				local character = localPlayer.Character
				local backpack = localPlayer:FindFirstChildOfClass("Backpack")
				local parent = tool.Parent

				if parent == nil or parent ~= character and parent ~= backpack then
					flag2 = true
				end

				if not flag2 and str then
					local v15 = fn76()
					local flag3

					if v15 then
						flag3 = (v15[str] or 0) > n20
					else
						flag3 = v15
					end

					if flag3 then
						flag2 = true
					end
				end

				if not (flag2 or os.clock() - now > 1.5) then
					continue
				end
				break
			end

			if flag2 then
				fish.fruitTry[name] = nil
				local v15 = fn76()

				if not str and v9 and v15 then
					for k, v16 in pairs(v15) do
						if (v9[k] or 0) < v16 then
							fish.fruitKeyMap[name] = k
							str = k
							break
						end
					end
				end

				local v16 = v15 and str and v15[str] or nil
				fish.fruitStatus = ("Stored %s%s"):format(name, v16 and (" - %d/%d now in storage"):format(v16, fn78(str)) or "")
				local str4

				if str and v16 and v16 > n20 then
					str4 = ("%d/%d of this fruit now in storage."):format(v16, fn78(str))
				else
					str4 = "The server took the fruit (storage count not confirmed yet)."
				end

				if tbl5.wh then
					str = str and fn74(str)

					if not str or str == "" then
						str = "?"
					end

					tbl5.wh.fruitStored(name, str4, { { "Rarity", str, true } })
				end

				local skullHubGPOKaitun = getgenv().SkullHubGPOKaitun

				if skullHubGPOKaitun and type(skullHubGPOKaitun.milestone) == "function" then
					skullHubGPOKaitun.milestone("Fruit stored", ("**%s** - %s"):format(name, str4))
				end

				return true
			end

			local n21 = (fish.fruitTry[name] or 0) + 1
			fish.fruitTry[name] = n21

			if n21 >= 3 then
				fish.fruitTry[name] = nil
				fish.fruitSkip[name] = os.clock() + 120
				local character = localPlayer.Character
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")

				if humanoid then
					pcall(function()
						humanoid:UnequipTools()
					end)
				end

				fish.fruitStatus = ("%s was refused 3 times - skipping it for 2 min, trying the next fruit"):format(name)
			else
				fish.fruitStatus = ("%s did not store (try %d/3) - retrying"):format(name, n21)
			end

			return true
		end

		fn5("StoreFruits", function()
			while true do
				task.wait(1)

				if fish.storeFruit and not tbl2.inMenu then
					local ok, result = pcall(fn83)

					if not ok then
						warn("[Skull Hub][StoreFruits]", fn2(result))
					end
				end
			end
		end)

		fish.fruitCatches = 0

		local function fn84(arg, arg2, arg3)
			if arg ~= "FishingReward" or type(arg3) ~= "table" then
				return
			end
			local reward = arg3.Reward
			if type(reward) ~= "string" then
				return
			end
			local match

			if fn73(reward) == "Fruit" then
				match = reward
			else
				match = reward:match("^([^%-]+)%-")
				if not (match and fn73(match) == "Fruit") then
					return
				end
			end

			local character = localPlayer.Character
			local goal = arg3.Goal
			if not (character and typeof(goal) == "Instance") then
				return
			end
			local flag2 = goal == character

			if not flag2 and goal:IsA("ObjectValue") then
				flag2 = goal.Value == character or goal.Name == character:GetFullName()
			end

			if not flag2 then
				return
			end
			local now = os.clock()
			local flag3 = fish.lastFruitCatch == reward
			local flag4

			if flag3 then
				flag4 = now - (fish.lastFruitCatchAt or 0) < 3
			else
				flag4 = flag3
			end

			if flag4 then
				return
			end
			local v8 = fish
			fish.lastFruitCatch = reward
			v8.lastFruitCatchAt = now
			fish.fruitCatches = fish.fruitCatches + 1
			local v9 = fn74(match)

			if v9 == "" then
				v9 = nil
			end

			local rewardType = arg3.RewardType

			if type(rewardType) ~= "string" or rewardType == "" then
				rewardType = "?"
			end

			warn(("[Skull Hub] Devil Fruit fished up: %s (%s)"):format(reward, v9 or "?"))

			if tbl5.notify then
				pcall(tbl5.notify, "Skull Hub", ("Devil Fruit fished up: %s%s"):format(reward, v9 and " (" .. v9 .. ")" or ""), 10)
			end

			if tbl5.wh then
				local fruitCaught = tbl5.wh.fruitCaught
				local tbl21 = {}
				local tbl22 = { "Catch tier", rewardType, true }
				local tbl23 = {}
				local str = tostring(fish.fruitCatches)
				tbl23[1] = "Fruits this session"
				tbl23[2] = str
				tbl23[3] = true
				local tbl24 = {}
				local str2 = fish.storeFruit and "On" or "Off"
				tbl24[1] = "Auto Store Fruits"
				tbl24[2] = str2
				tbl24[3] = true
				tbl21[1] = tbl22
				tbl21[2] = tbl23
				tbl21[3] = tbl24
				fruitCaught(reward, v9, tbl21)
			end

			local skullHubGPOKaitun = getgenv().SkullHubGPOKaitun

			if skullHubGPOKaitun and type(skullHubGPOKaitun.milestone) == "function" then
				skullHubGPOKaitun.milestone("Devil Fruit", ("Fished up **%s**%s."):format(reward, v9 and " (" .. v9 .. ")" or ""))
			end
		end

		local events = v6:FindFirstChild("Events")

		for _, v8 in ipairs({ "ClientEffect", "ClientEffectUnrealiable" }) do
			local v9 = events and events:FindFirstChild(v8)

			if v9 and (v9:IsA("RemoteEvent") or v9:IsA("UnreliableRemoteEvent")) then
				fn7(v9.OnClientEvent, "FruitCatch", fn84)
			end
		end

		local function fn85(arg, arg2)
			local Inventory = tbl5.invJSON("Inventory")
			if not Inventory then
				return nil
			end
			local n20 = -1
			local v8 = nil

			for k, v9 in pairs(Inventory) do
				if (tonumber(v9) or 0) > 0 and arg(k) then
					local v10 = arg2(k)

					if n20 < v10 then
						n20 = v10
						v8 = k
					end
				end
			end

			return v8
		end

		local function bestRod()
			return fn85(function(arg)
				return fn73(arg) == "Fishing Rod"
			end, function(arg)
				return tbl18[fn74(arg)] or 0
			end)
		end

		local function rodInHand()
			local character = localPlayer.Character
			if not character then
				return nil
			end

			for _, child in ipairs(character:GetChildren()) do
				if child:IsA("Tool") and fn73(child.Name) == "Fishing Rod" then
					return child, child.Name
				end
			end

			return nil
		end

		local function pickRod()
			local v8
			v8, v8 = rodInHand()
			if v8 then
				fish.rodChosen = v8
				return v8
			end

			if fish.rodChosen and tbl5.ownsItem(fish.rodChosen) then
				return fish.rodChosen
			end
			fish.rodChosen = bestRod()
			return fish.rodChosen
		end

		local function rodShown()
			local v8
			v8, v8 = rodInHand()
			return v8 or fish.rodChosen or bestRod()
		end

		local function baitCount(arg)
			local Inventory = tbl5.invJSON("Inventory")
			return Inventory and tonumber(Inventory[arg]) or 0
		end

		fish.bestRod = bestRod
		fish.baitCount = baitCount
		fish.pickRod = pickRod
		fish.rodInHand = rodInHand
		fish.rodShown = rodShown

		local function fn86()
			if fish.bait ~= "Best" then
				if baitCount(fish.bait) > 0 then
					return fish.bait
				end
				return nil, ("Out of %s."):format(fish.bait)
			end

			local v8 = fn85(function(arg)
				return tbl19[arg] ~= nil
			end, function(arg)
				return tbl19[arg] or 0
			end)

			if v8 then
				return v8
			end
			return nil, "Out of bait - buy some Fish Bait and it will carry on."
		end

		local function fn87()
			if not fish.buyOn then
				return false
			end
			local n20 = tonumber(fish.baitFloor) or 0
			if n20 <= 0 then
				return false
			end
			return baitCount("Common Fish Bait") < n20
		end

		local n20 = 180

		local function fn88(arg)
			local character = localPlayer.Character
			if not character then
				return nil
			end
			local backpack = localPlayer:FindFirstChildOfClass("Backpack")
			local v8 = character:FindFirstChild(arg)
			if v8 and v8:IsA("Tool") then
				return v8
			end
			local unequiped = backpack and backpack:FindFirstChild("Unequiped")
			local v9

			if backpack then
				v9 = backpack:FindFirstChild(arg) or unequiped and unequiped:FindFirstChild(arg)
			else
				v9 = backpack
			end

			if v9 and v9:IsA("Tool") then
				for _, child in ipairs(character:GetChildren()) do
					if child:IsA("Tool") and child ~= v9 then
						child.Parent = backpack
					end
				end

				v9.Parent = character
				return v9
			end

			if not tbl5.ownsItem(arg) then
				return nil
			end

			if tbl5.itemEquiped(arg) then
				fish.status = ("Waiting for the %s to replicate"):format(arg)
				return nil
			end

			if os.clock() - (fish.equipAt or 0) > 2 then
				fish.equipAt = os.clock()
				fish.status = ("Equipping the %s"):format(arg)
				local events2 = v6:FindFirstChild("Events")
				events2 = events2 and events2:FindFirstChild("Tools")

				if events2 then
					pcall(function()
						events2:InvokeServer("equip", arg)
					end)
				end
			end

			return nil
		end

		local function fn89(arg, arg2)
			local character = localPlayer.Character
			local backpack = localPlayer:FindFirstChildOfClass("Backpack")
			if not (arg and character and backpack and arg.Parent == character) then
				return false
			end
			fish.resets = (fish.resets or 0) + 1
			fish.lost.reset = fish.lost.reset + 1
			fish.status = ("Rod stuck (%s) - re-equipping."):format(arg2 or "no progress")

			if tbl5.wh then
				local problem = tbl5.wh.problem
				local str = "The fishing client was wedged: %s. Re-equipped the rod (%d times this session)."
				local format = str.format
				local v8 = tostring
				arg2 = arg2 or "no progress"
				local resets = fish.resets
				problem("Rod unstuck", format(str, v8(arg2), resets))
			end

			tbl5.gunAimStop()
			tbl17.suspend = false
			local client = fish.client
			arg.Parent = backpack
			local n21 = os.clock() + 3

			while true do
				if client and os.clock() < n21 then
					if not (rawget(client, "FishingSessionKey") == nil and rawget(client, "Debounce") ~= false) then
						task.wait(0.1)
						continue
					end
				end

				break
			end

			task.wait(0.15)

			if not fn88(arg.Name) and arg.Parent == backpack then
				pcall(function()
					arg.Parent = localPlayer.Character
				end)
			end

			local v8 = fish
			fish.stallSig = nil
			v8.stallAt = nil
			fish.lastGood = os.clock()
			task.wait(0.4)
			return true
		end

		local function fn90(arg)
			if not arg then
				return false
			end
			local value = rawget(arg, "Model")
			if not value then
				return false
			end
			return value.Parent == nil
		end

		local function fn91(arg)
			local value = rawget(arg, "Bobble")
			local stallSig, str, n21

			if fn90(value) and rawget(arg, "Debounce") ~= false then
				stallSig = "gone"
				str = "the server destroyed the float while the line was out"
				n21 = 3
			elseif rawget(arg, "Debounce") == false then
				stallSig = "debounce"
				str = "the game's reel-back never finished"
				n21 = 25
			elseif value == nil and rawget(arg, "FishingSessionKey") ~= nil then
				stallSig = "orphan"
				str = "the server still holds an open session with nothing in the water"
				n21 = 6
			elseif value == nil and rawget(arg, "IsCharging") == true then
				n21 = n12 + 5
				stallSig = "charging"
				str = "the charge latch never cleared"
			else
				local flag2 = value ~= nil and not rawget(arg, "FishCaught")
				stallSig = nil
				str = nil
				n21 = nil

				if flag2 then
					n21 = n13 + 20
					stallSig = "bite"
					str = "the bobble will not come back in"
				end
			end

			if not stallSig then
				local v8 = fish
				fish.stallSig = nil
				v8.stallAt = nil
				return nil
			end

			if fish.stallSig ~= stallSig then
				local v8 = fish
				local v9 = fish
				local now = os.clock()
				v8.stallSig = stallSig
				v9.stallAt = now
				return nil
			end

			if os.clock() - (fish.stallAt or 0) < n21 then
				return nil
			end
			return str
		end

		local function fn92(arg)
			if fish.client and fish.clientTool == arg and rawget(fish.client, "Tool") == arg then
				return fish.client
			end
			local v8 = fish
			fish.client = nil
			v8.clientTool = nil
			if not (tbl.getconnections and debug and debug.getupvalue) then
				return nil
			end

			local function fn93(arg2)
				return type(arg2) == "table" and rawget(arg2, "Tool") == arg and rawget(arg2, "MaxDistance") ~= nil and rawget(arg2, "SelectedBait") ~= nil
			end

			pcall(function()
				for _, v9 in ipairs({ arg.Unequipped, arg.Equipped, arg.Activated }) do
					for _, v10 in ipairs(getconnections(v9)) do
						local function_ = v10.Function

						if function_ then
							for i = 1, 24 do
								local ok, client, client2 = pcall(debug.getupvalue, function_, i)
								if not ok then
									break
								end

								if fn93(client) then
									local v11 = fish
									local v12 = arg
									fish.client = client
									v11.clientTool = v12
									return
								end

								if fn93(client2) then
									local v11 = fish
									local v12 = arg
									fish.client = client2
									v11.clientTool = v12
									return
								end
							end
						end
					end
				end
			end)

			return fish.client
		end

		local n21 = 400

		local function fn93(arg, arg2)
			fn20()
			local n22 = arg.Y + n21
			local character = localPlayer.Character
			character = character and character:FindFirstChild("HumanoidRootPart")
			local n23

			if character then
				n23 = math.max(n22, character.Position.Y + n21)
			else
				n23 = n22
			end

			local hit = workspace:Raycast(Vector3.new(arg.X, n23, arg.Z), Vector3.new(0, -(n23 - arg2 - 400), 0), raycastParams)
			if not hit then
				return true
			end
			return hit.Position.Y < arg2 - 1
		end

		local tbl21 = { 80, 120, 170, 230, 300 }

		local function fn94(arg)
			return { math.min(20, arg * 0.3), arg * 0.35, arg * 0.5, arg * 0.7 }
		end

		local function fn95()
			local v8 = fn22()
			local character = localPlayer.Character
			character = character and character:FindFirstChild("HumanoidRootPart")
			if not (v8 and character) then
				return nil
			end
			local position = character.Position
			local lookVector = character.CFrame.LookVector
			local v9 = math.atan2(lookVector.X, lookVector.Z)
			local aimDist = fish.aimDist

			local function fn96(arg, arg2)
				local vector = Vector3.new
				local cos = math.cos
				return Vector3.new(position.X, v8, position.Z) + vector(math.sin(arg), 0, cos(arg)) * arg2
			end

			local function fn97(arg)
				return math.abs((arg - v9 + 3.1415926535897931) % 6.2831853071795862 - 3.1415926535897931)
			end

			local v10 = fn94(aimDist)
			local n22 = 0
			local v11 = nil

			for i = 0, 23 do
				local n23 = v9 + 0.26179938779914941 * i

				if not fish.aimSea then
					local flag2 = true

					for _, v12 in ipairs(v10) do
						if not fn93(fn96(n23, v12), v8) then
							flag2 = false
							break
						end
					end

					if flag2 then
						return (fn96(n23, aimDist))
					end
					continue
				end

				local n24 = 0
				local flag2 = true

				for _, v12 in ipairs(v10) do
					if fn93(fn96(n23, v12), v8) then
						n24 += 1
					else
						flag2 = false
					end
				end

				local n25

				if flag2 then
					local v12 = v10[#v10]

					for _, v13 in ipairs(tbl21) do
						if not (v12 < v13) then
							continue
						elseif fn93(fn96(n23, v13), v8) then
							v12 = v13
							continue
						end

						break
					end

					n25 = 1000000 + v12 * 10
				else
					for _, v12 in ipairs(tbl21) do
						if fn93(fn96(n23, v12), v8) then
							n24 += 1
						end
					end

					n25 = n24 * 10
				end

				local n26 = n25 - fn97(n23)

				if n22 < n26 then
					n22 = n26
					v11 = n23
				end
			end

			if v11 then
				return (fn96(v11, aimDist))
			end
			return nil
		end

		local n22 = 150
		local n23 = 196.2

		local function fn96()
			local env2 = workspace:FindFirstChild("Env")
			env2 = env2 and env2:FindFirstChild("WaterStuff")
			env2 = env2 and env2:FindFirstChild("Falls")
			if env2 then
				return env2.Position.Y
			end
			return fn22()
		end

		local function rodTip(arg)
			local bobbleSpawn = arg and arg:FindFirstChild("BobbleSpawn", true)

			if bobbleSpawn then
				local ok, result = pcall(function()
					return bobbleSpawn.WorldPosition
				end)

				if ok and typeof(result) == "Vector3" then
					return result
				end
			end

			local character = localPlayer.Character
			character = character and character:FindFirstChild("HumanoidRootPart")
			return character and character.Position + Vector3.new(0, 3, 0) or nil
		end

		local function fn97(arg, arg2)
			if arg <= 0 then
				return 0
			end

			if arg2 <= 0.01 then
				arg2 = 0.01
			end

			local v8 = math.sqrt(arg * arg + arg2 * arg2)
			local n24 = n22 * arg / v8
			local n25 = n22 * -arg2 / v8
			return n24 * (n25 + math.sqrt(n25 * n25 + 2 * n23 * arg2)) / n23
		end

		local function solveAim(arg, arg2)
			local n24 = arg.Y - fn96()
			if n24 <= 0.05 then
				return nil, 0, 0
			end
			local vector = Vector3.new(arg2.X - arg.X, 0, arg2.Z - arg.Z)
			local magnitude = vector.Magnitude
			local v8 = fn97(1, n24)
			local v9 = fn97(400, n24)
			if magnitude < v8 or magnitude > v9 then
				return nil, v8, v9
			end
			local unit = magnitude > 0.01 and vector.Unit or Vector3.new(0, 0, 1)
			local n25 = 1
			local n26 = 400

			for i = 1, 40 do
				local n27 = (n25 + n26) * 0.5

				if not (fn97(n27, n24) < magnitude) then
					n26 = n27
				else
					n25 = n27
				end
			end

			local z = arg.Z
			return Vector3.new(arg.X, fn96(), z) + unit * (n25 + n26) * 0.5, v8, v9
		end

		local n24 = 25
		local n25 = 60

		local function fn98(arg)
			local bob = fish.bob
			if not (bob and arg) then
				return
			end
			local vector = Vector3.new(bob.X - arg.X, 0, bob.Z - arg.Z)
			fish.bobErr = vector.Magnitude
			if vector.Magnitude <= 0.25 then
				return
			end
			local n26 = (fish.bobT or bob) + (vector.Magnitude > n24 and vector.Unit * n24 or vector)

			if not (n25 < (n26 - bob).Magnitude) then
				bob = n26
			end

			fish.bobT = bob
		end

		local function faceFlat(arg)
			local character = localPlayer.Character
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
			if not (humanoidRootPart and arg) then
				return
			end
			local vector = Vector3.new(arg.X - humanoidRootPart.Position.X, 0, arg.Z - humanoidRootPart.Position.Z)
			if vector.Magnitude < 0.05 then
				return
			end

			pcall(function()
				humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position, humanoidRootPart.Position + vector.Unit)
			end)
		end

		fish.rodTip = rodTip
		fish.solveAim = solveAim
		fish.faceFlat = faceFlat
		local flag2 = nil

		local function fn99(arg)
			if flag2 == nil then
				local ok, result = pcall(function()
					return fn(game:GetService("VirtualInputManager"))
				end)

				flag2 = ok and result or false
			end

			if not flag2 then
				return false
			end
			local currentCamera = workspace.CurrentCamera
			currentCamera = currentCamera and currentCamera.ViewportSize or Vector2.new(800, 600)

			return (pcall(function()
				flag2:SendTouchEvent(1, arg and 0 or 2, currentCamera.X * 0.8, currentCamera.Y * 0.25)
			end))
		end

		local function fn100(arg, holding, arg2)
			if arg2.holding == holding then
				return
			end
			arg2.holding = holding

			if arg2.touch then
				if fn99(holding) then
					return
				end
				arg2.touch = false
			end

			if tbl.firesignal then
				pcall(function()
					firesignal(holding and arg.Activated or arg.Deactivated)
				end)
			end

			pcall(function()
				if holding then
					arg:Activate()
				else
					arg:Deactivate()
				end
			end)
		end

		local function fn101(arg)
			if arg.fr and arg.fr.Parent then
				return arg.fr
			end
			arg.fr = nil
			arg.pl = nil
			arg.goal = nil
			local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
			if not playerGui then
				return nil
			end

			for _, child in ipairs(playerGui:GetChildren()) do
				if child:IsA("BillboardGui") then
					local frame = child:FindFirstChild("Frame")
					local player = frame and frame:FindFirstChild("Player")
					local goal = frame and frame:FindFirstChild("Goal")

					if player and goal then
						arg.fr = frame
						arg.pl = player
						arg.goal = goal
						return frame
					end
				end
			end

			return nil
		end

		local function fn102(arg, arg2, arg3)
			local v8 = tbl5.gameG()
			local tbl22 = { holding = nil, touch = v8 and v8.mobile == true or false }
			local tbl23 = {}
			local n26 = math.clamp(tonumber(fish.reelSense) or 8, 1, 10)
			local n27 = 0.011 - 0.001 * n26
			local n28 = n27 * 2
			local n29 = 0.06 + 0.006 * n26
			local n30 = 0.01 + 0.039 * n26
			local now = os.clock()
			local n31 = 0
			local v9 = nil
			local n32 = 0
			local v10 = nil
			local n33 = 0
			local flag3 = nil
			local flag4 = fish.reelMode == "Instant"
			local n34 = nil

			local function fn103(barRadius)
				local num = tonumber(rawget(arg, "BarRadius"))
				if num == barRadius then
					return
				end

				if n34 == nil then
					n34 = num or 0.25
				end

				arg.BarRadius = barRadius
			end

			local function fn104()
				fn103((tonumber(rawget(arg, "Max")) or 2) / 2)
			end

			local tbl24 = nil

			if flag4 and fish.human and fish.human.on then
				local human = fish.human
				local n35 = math.clamp(tonumber(human.reelMin) or 7, 6, 45)
				local n36 = math.max(n35, math.clamp(tonumber(human.reelMax) or 14, 6, 45))
				local n37 = (math.random() + math.random()) / 2
				local now2 = os.clock()
				local num = tonumber(rawget(arg, "MinigameStartTime"))
				tbl24 = { T = n35 + (n36 - n35) * n37 ^ 1.35 }
				tbl24.fail = math.random() * 100 < math.clamp(tonumber(human.miss) or 0, 0, 50)
				tbl24.on = true
				tbl24.A = 0.25 + math.random() * 0.65
				tbl24.B = 0.15 + math.random() * 0.45
				tbl24.clickNext = 0
				tbl24.clickDown = false
				tbl24.t0 = num and num <= now2 and now2 - num < 5 and num or now2
				tbl24.failAt = tbl24.T * (0.25 + math.random() * 0.45)
			end

			fish.plannedMiss = tbl24 ~= nil and tbl24.fail or false
			local num = nil

			if tbl.setfpscap then
				num = tonumber(tbl5.fpsCap)

				if not num and type(getfpscap) == "function" then
					local result
					num, result = pcall(getfpscap)
					num = num and tonumber(result) or nil
				end

				local ok = num and num > 0 and num < 15 and pcall(setfpscap, 15)
				local v11 = nil

				if not ok then
					num = v11
				end
			end

			local function fn105()
				if n34 == nil then
					return
				end
				local v11 = n34
				n34 = nil

				pcall(function()
					arg.BarRadius = v11
				end)
			end

			local fishReel = fn7(v2.RenderStepped, "FishReel", function()
				if flag3 ~= nil then
					return
				end

				if arg3() or tbl8.flagged then
					fn105()
					fn100(arg2, false, tbl22)
					flag3 = false
					return
				end

				if not rawget(arg, "Bobble") then
					fn105()
					fn100(arg2, false, tbl22)
					flag3 = true
					return
				end

				if fn90(rawget(arg, "Bobble")) then
					fn105()
					fn100(arg2, false, tbl22)
					flag3 = true
					return
				end

				if flag4 and tbl24 then
					local n35 = tonumber(rawget(arg, "Max")) or 2
					local n36 = tonumber(rawget(arg, "MaxFishTime")) or 7.5
					local n37 = tonumber(rawget(arg, "FishTime")) or 2
					local t0 = tbl24.t0
					local n38 = os.clock() - t0

					if tbl24.fail and n38 >= tbl24.failAt then
						tbl24.on = false
					elseif tbl24.T <= n38 then
						tbl24.on = true
					else
						local n39 = 2 + (n36 - 2) * math.min(n38 / tbl24.T, 1)

						if tbl24.on and n37 >= math.min(n39 + tbl24.A, n36 - 0.35) then
							tbl24.on = false
							tbl24.A = 0.25 + math.random() * 0.65
						elseif not tbl24.on and n37 <= n39 - tbl24.B then
							tbl24.on = true
							tbl24.B = 0.15 + math.random() * 0.45
						end
					end

					fn103(tbl24.on and n35 / 2 or n35 * 0.01)
					local clickDown

					if tbl24.on then
						if tbl24.clickNext <= n38 then
							tbl24.clickDown = not tbl24.clickDown
							tbl24.clickNext = n38 + (tbl24.clickDown and 0.08 + math.random() * 0.47 or 0.12 + math.random() * 0.78)
						end

						clickDown = tbl24.clickDown
					else
						local scale = fn101(tbl23) and tbl23.goal and tbl23.goal.Position.Y.Scale
						clickDown = type(scale) == "number" and scale > 0.5 or false
					end

					fn100(arg2, clickDown, tbl22)

					if os.clock() >= n33 then
						n33 = os.clock() + 0.15
						local n39 = math.floor(math.clamp(n37 / n36, 0, 1) * 100)
						fish.status = tbl24.fail and ("Reeling %d%% - humanized, letting this one go"):format(n39) or ("Reeling %d%% - humanized, landing at ~%.1f s"):format(n39, tbl24.T)
					end

					return
				end

				if flag4 then
					fn104()

					if n33 <= os.clock() then
						n33 = os.clock() + 0.15
						local num2 = tonumber(rawget(arg, "FishTime"))
						local n35 = tonumber(rawget(arg, "MaxFishTime")) or 7.5
						fish.status = num2 and ("Reeling %d%% - anchored"):format(math.floor(math.clamp(num2 / n35, 0, 1) * 100)) or "Reeling - anchored"
					end

					return
				end

				if not fn101(tbl23) then
					return
				end
				local n35 = tonumber(rawget(arg, "Max")) or 2
				local n36 = tonumber(rawget(arg, "BarRadius")) or 0.25
				local num2 = tonumber(rawget(arg, "Acceleration"))
				local num3 = tonumber(rawget(arg, "BarPosition"))
				local num4 = tonumber(rawget(arg, "Velocity"))
				local now2 = os.clock()
				local n37, n38

				if num3 and num4 and n35 > 0 then
					n37 = num3 / n35
					n38 = num4 / n35
				else
					n37 = tbl23.pl.Position.Y.Scale
					local n39 = now2 - now

					if v9 and n39 > 0 then
						n31 = n31 * 0.6 + (n37 - v9) / n39 * 0.4
					end

					v9 = n37
					now = now2
					n38 = n31
					local v11 = n31

					if num2 then
						n38 = v11
					else
						num2 = 3
					end
				end

				local scale = tbl23.goal.Position.Y.Scale
				local n39 = now2 - (tbl22.gAt or now2)

				if v10 and n39 > 0 then
					n32 = n32 * 0.5 + (scale - v10) / n39 * 0.5
				end

				local v11 = tbl22
				v10 = scale
				v11.gAt = now2
				local n40 = math.clamp(scale + n32 * n30, n36 / n35, 1 - n36 / n35)
				local n41 = n40 - n37
				local flag5

				if math.abs(n41) <= n36 / 2 / n35 then
					local n42 = n40 - n37 + n38 * n29

					if n27 < n42 then
						flag5 = false
					elseif n42 < -n27 then
						flag5 = true
					else
						flag5 = tbl22.holding
					end
				else
					local n42 = (num2 or 3) / n35
					local n43 = n42 > 0 and math.abs(n38) / n42 or 0
					local n44 = n40 - n37 + n38 * n43 - 0.5 * n42 * n43 * n43 * (n38 > 0 and 1 or -1)

					if n41 > 0 then
						flag5 = not (n44 > n28)
					else
						flag5 = n44 < -n28
					end
				end

				if flag5 == nil then
					flag5 = n41 < 0
				end

				fn100(arg2, flag5, tbl22)

				if n33 <= now2 then
					n33 = now2 + 0.15
					local num5 = tonumber(rawget(arg, "FishTime"))
					local n42 = tonumber(rawget(arg, "MaxFishTime")) or 7.5
					fish.status = num5 and ("Reeling %d%% - bar %.2f, goal %.2f"):format(math.floor(math.clamp(num5 / n42, 0, 1) * 100), n37, scale) or ("Reeling - bar %.2f, goal %.2f"):format(n37, scale)
				end
			end)

			local n35 = os.clock() + n14

			while flag3 == nil and os.clock() < n35 do
				task.wait(0.05)
			end

			pcall(function()
				fishReel:Disconnect()
			end)

			fn105()
			fn100(arg2, false, tbl22)

			if num then
				pcall(setfpscap, math.clamp(tonumber(tbl5.fpsCap) or num, 1, 1000))
			end

			if flag3 ~= nil then
				return flag3
			end

			pcall(function()
				arg:_reelBack()
			end)

			return false
		end

		local function fn103()
			local Inventory = tbl5.invJSON("Inventory")
			local tbl22 = {}
			if not Inventory then
				return tbl22, 0
			end
			local n26 = 0

			for k, v8 in pairs(Inventory) do
				local n27 = tonumber(v8) or 0

				if n27 > 0 and fn73(k) == "Fish" then
					tbl22[k] = n27
					n26 += n27
				end
			end

			return tbl22, n26
		end

		local function fn104()
			if fish.recipes then
				return fish.recipes
			end
			local recipes = {}

			local ok, result = pcall(function()
				return require(v6.Modules.Blueprints)
			end)

			if ok and type(result) == "table" then
				for k, v8 in pairs(result) do
					if type(v8) == "table" and tbl19[k] and type(v8.Requirements) == "table" then
						local key, v9 = next(v8.Requirements)

						if key and v9 then
							local requirementsExtra = v8.RequirementsExtra and v8.RequirementsExtra[key]

							recipes[k] = {
								cat = key,
								need = tonumber(v9) or 1,
								multi = requirementsExtra and requirementsExtra.AllowMultiple and true or false,
							}
						end
					end
				end
			end

			fish.recipes = recipes
			return recipes
		end

		local function fn105(arg)
			local Inventory = tbl5.invJSON("Inventory")
			local tbl22 = {}
			if not Inventory then
				return tbl22, 0
			end
			local v8 = fn72()
			local n26 = 0

			for k, v9 in pairs(Inventory) do
				local n27 = tonumber(v9) or 0
				local flag3 = n27 > 0 and v8 and v8[k]

				if type(flag3) == "table" and flag3.BaseItem == arg then
					tbl22[#tbl22 + 1] = { name = k, n = n27 }
					n26 += n27
				end
			end

			table.sort(tbl22, function(arg2, arg3)
				return arg2.n > arg3.n
			end)

			return tbl22, n26
		end

		local function fn106()
			local tbl22 = {}
			if not fish.craftOn then
				return tbl22
			end

			for k, v8 in pairs(fn104()) do
				if fish.craft[k] then
					local max = math.max
					local n26 = tonumber(fish.craftMax) or 10
					local need = v8.need
					local n27 = max(1, n26) * need
					local n28 = 0

					for _, v9 in ipairs(fn105(v8.cat)) do
						if not (n27 <= n28) then
							tbl22[v9.name] = true
							n28 += v9.n
							continue
						end

						break
					end
				end
			end

			return tbl22
		end

		local function fn107(arg)
			local v8 = fn104()[arg]
			if not v8 then
				return 0, "no recipe for " .. tostring(arg)
			end
			local v9, v10 = fn105(v8.cat)
			local multi = v8.multi and v10

			if not multi then
				multi = v9[1] and v9[1].n or 0
			end

			local n26 = math.floor(multi / v8.need)

			if n26 < 1 then
				if not v8.multi and v10 >= v8.need then
					return 0, ("%s is split across stacks - the recipe can only spend one at a time"):format(v8.cat)
				end
				return 0, ("not enough %s (%d of %d)"):format(v8.cat, multi, v8.need)
			end

			local n27 = math.min(n26, math.max(1, tonumber(fish.craftMax) or 10))
			local tbl22 = {}

			if v8.multi then
				for _, v11 in ipairs(v9) do
					tbl22[v11.name] = v8.cat
				end
			else
				tbl22[v8.cat] = v9[1] and v9[1].name
				if not tbl22[v8.cat] then
					return 0, "nothing to spend"
				end
			end

			local craftingRemote = v6:FindFirstChild("CraftingRemote")
			if not craftingRemote then
				return 0, "CraftingRemote is missing on this build"
			end
			local v11 = baitCount(arg)

			local ok, result = pcall(function()
				return craftingRemote:InvokeServer({ Method = "Craft", BlueprintItem = arg, ExtraData = tbl22, Count = n27 })
			end)

			task.wait(1.2)
			local v12 = baitCount(arg)

			if v11 < v12 then
				local n28 = v12 - v11
				fish.crafted = (fish.crafted or 0) + n28
				return n28
			end

			if ok and result == false then
				return 0, "the server refused the craft (out of range?)"
			end
			return 0, "the craft did nothing"
		end

		local function fn108(arg)
			local v8, v9, v10 = tbl5.shopModel("Common Fish Bait")
			if not v8 then
				return 0, v9 and "the bait stand has not streamed in" or "there is no bait stand in this world"
			end

			if v10 and v10 > n11 then
				return 0, ("%d studs from the stand - the server refuses past ~20"):format(math.floor(v10))
			end
			local events2 = v6:FindFirstChild("Events")
			events2 = events2 and events2:FindFirstChild("Shop")
			if not events2 then
				return 0, "the Shop remote is missing"
			end
			local info = v8:FindFirstChild("Info")
			local price = info and info:FindFirstChild("Price")
			price = price and tonumber(price.Value) or 45
			local v11 = tbl5.peli()
			local n26 = math.max(1, math.min(arg, math.floor(v11 / math.max(1, price))))
			if n26 < 1 then
				return 0, ("not enough Peli (%d, one bait is %d)"):format(v11, price)
			end
			local commonFishBait = baitCount("Common Fish Bait")

			local ok, result = pcall(function()
				return events2:InvokeServer(v8, n26)
			end)

			task.wait(1.2)
			local commonFishBait2 = baitCount("Common Fish Bait")

			if commonFishBait < commonFishBait2 then
				local n27 = commonFishBait2 - commonFishBait
				fish.bought = (fish.bought or 0) + n27
				return n27
			end

			if not ok then
				return 0, "the Shop remote threw"
			end

			if result == false then
				return 0, ("the server refused the sale (%d Peli in hand, %d each, %d studs away)"):format(v11, price, math.floor(v10 or -1))
			end
			return 0, "the shop took nothing"
		end

		local n26 = 12
		local n27 = 0.5
		local n28 = 3

		local function goHome(arg)
			local home = fish.home
			if not home then
				return true
			end

			local function fn109()
				local character = localPlayer.Character
				character = character and character:FindFirstChild("HumanoidRootPart")
				return character and (home.Position - character.Position).Magnitude or nil
			end

			local function fn110()
				local v8 = fn109()
				if not v8 or v8 > n26 then
					return false
				end
				fish.status = "Settling back onto the fishing spot…"
				tbl5.settleOnto(home, arg, n26 * 2)
				local v9 = fn109()
				return v9 ~= nil and v9 <= n27
			end

			if fn110() then
				local v8 = fish
				fish.home = nil
				v8.homeFail = 0
				return true
			end

			if not fn109() then
				return false
			end

			if arg and arg() then
				return false
			end
			fish.status = "Heading back to the water…"
			fn36(home.Position + Vector3.new(0, 3, 0), 8, arg)

			if fn110() then
				local v8 = fish
				fish.home = nil
				v8.homeFail = 0
				return true
			end

			arg = arg and arg()
			if arg then
				return false
			end
			fish.homeFail = (fish.homeFail or 0) + 1

			if n28 <= fish.homeFail then
				fish.status = "Could not walk back to the fishing spot - carrying on from here."

				if tbl5.wh then
					tbl5.wh.problem("Lost the fishing spot", "Three walks back to the spot this run started from failed. Fishing from wherever the character is now.")
				end

				local v8 = fish
				fish.home = nil
				v8.homeFail = 0
			end

			return false
		end

		fish.goHome = goHome

		local function fn109(arg)
			local character = localPlayer.Character
			character = character and character:FindFirstChild("HumanoidRootPart")
			if not character then
				task.wait(0.5)
				return false
			end
			fish.home = fish.home or fish.spot or character.CFrame
			local flag3 = false

			if fish.craftOn then
				local npCs = workspace:FindFirstChild("NPCs")
				npCs = npCs and npCs:FindFirstChild("Blacksmith Sen")
				local tbl22 = {}

				for k, v8 in pairs(fn104()) do
					if fish.craft[k] then
						local v9, v10 = fn105(v8.cat)

						if v8.need <= v10 then
							tbl22[#tbl22 + 1] = k
						end
					end
				end

				if #tbl22 > 0 and npCs then
					local position = npCs:GetPivot().Position

					if (position - character.Position).Magnitude > n16 then
						fish.status = "Going to Blacksmith Sen to craft bait…"

						if not fn36(position + Vector3.new(0, 3, 0), n16 - 2, arg) then
							fish.status = "Could not reach Blacksmith Sen."
							task.wait(1.5)
							goHome(arg)
							return false
						end
					end

					table.sort(tbl22, function(arg2, arg3)
						return (tbl19[arg2] or 0) > (tbl19[arg3] or 0)
					end)

					for _, v8 in ipairs(tbl22) do
						if arg() then
							return false
						end
						fish.status = "Crafting " .. v8 .. "…"
						local v9, v10 = fn107(v8)

						if v9 > 0 then
							local status = ("Crafted %d %s"):format(v9, v8)
							fish.status = status
							flag3 = true

							if tbl5.wh then
								tbl5.wh.milestone("Bait crafted", status)
							end
						elseif v10 then
							fish.status = ("Could not craft %s - %s"):format(v8, v10)
						end

						task.wait(0.3)
					end
				end
			end

			local buyOn = not flag3 and fish.buyOn

			if buyOn then
				buyOn = baitCount("Common Fish Bait") < (tonumber(fish.baitFloor) or 20)
			end

			if buyOn then
				local shopPart = tbl5.shopModel("Common Fish Bait")
				shopPart = shopPart and shopPart:FindFirstChild("ShopPart")
				local position = shopPart and shopPart.Position or Vector3.new(-1344.12, 1.33, -4983.39)

				if (position - character.Position).Magnitude > 9 then
					fish.status = ("Going to the bait stand (%d Peli in hand)"):format(tbl5.peli())

					if not fn36(position + Vector3.new(0, 3, 0), 8, arg) then
						fish.status = "Could not reach the bait stand."
						task.wait(1.5)
						goHome(arg)
						return false
					end
				end

				if arg() then
					return false
				end
				local n29 = math.max(1, tonumber(fish.buyAmount) or 50)
				local v8, couldNotRestock = fn108(n29)

				if v8 > 0 then
					local status = ("Bought %d Common Fish Bait"):format(v8)
					fish.status = status
					flag3 = true

					if tbl5.wh then
						tbl5.wh.milestone("Bait restocked", status)
					end
				elseif couldNotRestock then
					fish.status = "Could not buy bait - " .. couldNotRestock

					if tbl5.wh then
						tbl5.wh.problem("Out of bait", "Could not restock: " .. couldNotRestock)
					end

					task.wait(2)
				end
			end

			goHome(arg)
			return flag3
		end

		fish.dropMaxPeli = function()
			if not fish.dropAtMax or fish.dropBusy then
				return false
			end

			if tbl2.inMenu then
				fish.dropStatus = tbl2.MENU_STATUS
				return false
			end
			local dropNextAt = fish.dropNextAt
			if os.clock() < dropNextAt then
				return false
			end
			local v8 = tbl5.maxPeli()
			local v9 = tbl5.peli()
			if v9 < v8 then
				return false
			end
			local n29 = math.floor(v9 - math.max(tonumber(fish.dropKeep) or 0, 0))
			if n29 <= 0 then
				return false
			end
			local character = localPlayer.Character
			character = character and character:FindFirstChildOfClass("Humanoid")
			if not (character and character.Health > 0) then
				return false
			end
			local events2 = v6:FindFirstChild("Events")
			local moneyDrop = events2 and events2:FindFirstChild("MoneyDrop")

			if not (moneyDrop and moneyDrop:IsA("RemoteEvent")) then
				fish.dropStatus = "Events.MoneyDrop is missing on this build."
				fish.dropNextAt = os.clock() + 600
				return false
			end

			fish.dropBusy = true
			fish.dropNextAt = os.clock() + 5
			fish.dropStatus = ("At max Peli - dropping %d as a Peli bag…"):format(n29)

			pcall(function()
				moneyDrop:FireServer(tostring(n29))
			end)

			local n30 = os.clock() + 5

			while true do
				task.wait(0.25)
				if not (tbl5.peli() < v9 or os.clock() > n30) then
					continue
				end
				break
			end

			local v10 = tbl5.peli()
			fish.dropBusy = false

			if v10 < v9 then
				fish.dropFails = 0
				fish.dropped = fish.dropped + v9 - v10
				fish.dropStatus = ("Dropped %d Peli (%d this session). Wallet: %d."):format(v9 - v10, fish.dropped, v10)
				pcall(notify, "Skull Hub", ("Max Peli - dropped %d as a Peli bag."):format(v9 - v10), 6)
				return true
			end

			fish.dropFails = fish.dropFails + 1
			local n31 = math.min(60 * 2 ^ (fish.dropFails - 1), 600)
			fish.dropNextAt = os.clock() + n31
			fish.dropStatus = ("The server did not take the drop - trying again in %ds."):format(n31)
			return false
		end

		local function fn110()
			if fish.sellBroken then
				return
			end
			local fishingShopRemote = v6:FindFirstChild("FishingShopRemote")

			if not fishingShopRemote then
				fish.sellBroken = true
				fish.status = "FishingShopRemote is missing on this build - auto sell is off."
				return
			end

			local v8, v9 = fn103()
			local v10 = fn106()
			local n29 = 0
			local n30 = 0

			for k in pairs(v8) do
				if v10[k] then
					n29 += 1
				elseif fish.sell[fn74(k)] then
					n30 += 1

					pcall(function()
						fishingShopRemote:InvokeServer({ Method = "SellFish", Fish = k, All = true })
					end)

					task.wait(0.1)
				end
			end

			if n30 == 0 then
				if n29 > 0 then
					fish.status = ("Keeping %d fish type(s) for crafting."):format(n29)
				end

				return
			end

			task.wait(0.6)
			local value = select(2, fn103())

			if value < v9 then
				fish.sold = fish.sold + v9 - value
			else
				fish.sellBroken = true
				fish.status = "The sell remote did nothing (" .. tostring(v9) .. " fish before and after) - auto sell is off. Sell at the Fish Seller by hand."
			end
		end

		fish.freezeOn = false
		fish.frozenRoot = nil

		fish.unfreeze = function()
			local frozenRoot = fish.frozenRoot
			if not frozenRoot then
				return
			end
			fish.frozenRoot = nil

			pcall(function()
				if frozenRoot.Parent and frozenRoot.Anchored then
					frozenRoot.Anchored = false
				end
			end)
		end

		fish.freeze = function()
			if not (fish.freezeOn and fish.on) then
				return
			end
			local character = localPlayer.Character
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart or fish.frozenRoot == humanoidRootPart then
				return
			end
			fish.unfreeze()
			if humanoidRootPart.Anchored then
				return
			end

			pcall(function()
				humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
				humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
				humanoidRootPart.Anchored = true
			end)

			if humanoidRootPart.Anchored then
				fish.frozenRoot = humanoidRootPart
			end
		end

		tbl5.fishUnfreeze = fish.unfreeze

		local function fn111(arg)
			local v8 = fn22()
			local character = localPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
			if not (humanoid and humanoidRootPart and v8) then
				task.wait(0.5)
				return false
			end

			if fn23(humanoidRootPart.Position.Y, v8) then
				local fishman = tbl5.fishman

				if not (fishman and type(fishman.leave) == "function") then
					fish.status = "On Fishman Island, where fishing is impossible - open the Movement tab once so the exit route is available."
					task.wait(2)
					return false
				end

				fish.status = "Fishing does not work on Fishman Island - leaving first…"

				if not fishman.leave(arg) then
					fish.status = "Could not leave Fishman Island: " .. tostring(fishman.state.status)
					task.wait(2)
				end

				return false
			end

			if humanoid.FloorMaterial == Enum.Material.Air then
				fish.status = "In the air - land somewhere before casting."
				task.wait(0.5)
				return false
			end

			local v9 = pickRod()

			if not v9 then
				fish.status = "No fishing rod in your inventory. Buy one, then turn this back on."
				task.wait(3)
				return false
			end

			local v10 = fn88(v9)
			if not v10 then
				task.wait(0.6)
				return false
			end
			local v11 = fn92(v10)

			if not v11 then
				fish.status = "Cannot reach the game's fishing object - this executor is missing getconnections or debug.getupvalue."
				task.wait(3)
				return false
			end

			local str = fn91(v11)
			local flag3 = not str

			if flag3 then
				flag3 = os.clock() - (fish.lastGood or 0) > n15
			end

			if flag3 then
				str = ("nothing has been landed in %ds"):format(240)
			end

			if str then
				fn89(v10, str)
				return false
			end

			if not rawget(v11, "Bobble") then
				local v12 = tbl5.gameG()

				if v12 and v12.canuse == false or rawget(v11, "Debounce") == false then
					fish.status = "Waiting for the game to hand the character back…"
					task.wait(0.5)
					return false
				end

				if v12 and type(v12.check) == "table" and type(v12.check.inspect) == "function" then
					local ok, result = pcall(v12.check.inspect, v12.check, character)

					if ok and result == false then
						fish.status = "Waiting - the character is stunned, sitting, blocking or busy…"
						task.wait(0.5)
						return false
					end
				end

				if fish.home then
					goHome(arg)
					fish.lastGood = os.clock()
					return false
				end

				local flag4 = fn87()

				if flag4 then
					flag4 = os.clock() >= (fish.restockNext or 0)
				end

				if flag4 then
					fish.status = ("Down to %d Common Fish Bait (restock below %d) - going now…"):format(baitCount("Common Fish Bait"), tonumber(fish.baitFloor) or 0)
					fn109(arg)
					fish.lastGood = os.clock()

					if fn87() then
						fish.restockNext = os.clock() + n20
					end

					return false
				end

				local v13, status = fn86()

				if not v13 then
					if fish.craftOn or fish.buyOn then
						local v14 = fish
						status = status or "Out of bait."
						v14.status = status .. " Restocking…"
						local v15 = fn109(arg)
						fish.lastGood = os.clock()
						if v15 then
							fish.restockFail = 0
							return false
						end
						fish.restockFail = (fish.restockFail or 0) + 1

						if fish.restockFail >= 3 then
							goHome(arg)
							fish.status = "Out of bait and cannot restock - stopping. Buy or craft some bait and turn this back on."

							if tbl5.wh then
								tbl5.wh.problem("Auto Fish stopped", "Out of bait, and three restock trips came back empty.")
							end

							fish.on = false
							return false
						end

						task.wait(1)
						return false
					end

					fish.status = status or "Out of bait."
					task.wait(3)
					return false
				end

				v11.SelectedBait = v13

				if fish.spot then
					local magnitude = (fish.spot.Position - humanoidRootPart.Position).Magnitude

					if magnitude > 1500 then
						fish.spot = nil
						fish.status = "The pinned stance is on the other side of the map - unpinned."
						fish.toast = "Fishing stance unpinned: you are 1500+ studs from it."
					elseif n17 < magnitude then
						fish.spotFail = (fish.spotFail or 0) + 1

						if fish.spotFail <= n19 then
							fish.status = ("Back onto the pinned spot (%.1f studs off)"):format(magnitude)

							if magnitude > n18 then
								fn36(fish.spot.Position + Vector3.new(0, 3, 0), 8, arg)
							end

							tbl5.settleOnto(fish.spot, arg, 40)
							return false
						end

						fish.status = ("Cannot hold the pinned stance (%.1f studs off) - casting from here. Re-pin it somewhere the character can stand still."):format(magnitude)
					else
						fish.spotFail = 0
					end
				end

				local v14

				if fish.bob then
					faceFlat(fish.bob)
					task.wait()
					local v15 = rodTip(v10)
					local n29 = 0
					v14 = nil
					local n30 = 0

					if v15 then
						v14, n30, n29 = solveAim(v15, fish.bobT or fish.bob)
					end

					if not v14 then
						local magnitude = v15 and Vector3.new(fish.bob.X - v15.X, 0, fish.bob.Z - v15.Z).Magnitude or 0
						fish.status = v15 and ("The pinned bobber spot is %d studs away - from this stance the rod only reaches %d-%d. Move closer or re-pin it."):format(math.floor(magnitude), math.floor(n30), math.floor(n29)) or "Cannot find the rod's BobbleSpawn attachment."
						fish.bobMiss = (fish.bobMiss or 0) + 1
						task.wait(2)
						return false
					end
				else
					v14 = fn95()

					if not v14 then
						fish.status = "No open water within " .. tostring(fish.aimDist + 90) .. " studs - stand on a dock or a beach."
						task.wait(2)
						return false
					end
				end

				tbl11.stopDriver()
				fish.freeze()
				tbl5.gunAim(v14)
				tbl17.suspend = true
				fish.status = "Casting…"

				local ok = pcall(function()
					v11:_charge()
				end)

				fish.casts = fish.casts + 1
				local n29 = os.clock() + n12

				while true do
					if ok and os.clock() < n29 then
						if not arg() then
							if not rawget(v11, "Bobble") then
								task.wait(0.1)
								continue
							end
						end
					end

					break
				end

				tbl5.gunAimStop()
				tbl17.suspend = false

				if not rawget(v11, "Bobble") then
					if rawget(v11, "FishingSessionKey") ~= nil then
						fn89(v10, "the throw was accepted but no bobble appeared")
						return false
					end

					pcall(function()
						v11.IsCharging = false
					end)

					fish.status = "The cast did not land - retrying."
					task.wait(1)
					return false
				end
			end

			fish.status = "Waiting for a bite…"
			fish.freeze()
			local n29 = os.clock() + n13
			local now = nil
			local position = nil

			while os.clock() < n29 do
				if arg() then
					return false
				end

				if tbl8.flagged then
					return false
				end

				if humanoid and humanoid.MoveDirection.Magnitude > 0.1 then
					now = os.clock()
				end

				local value = rawget(v11, "Bobble")

				if not value then
					now = now and os.clock() - now < 1.5

					if now then
						fish.lost.moved = fish.lost.moved + 1
						fish.status = "The cast was cancelled by movement - recasting."
					else
						fish.lost.land = fish.lost.land + 1
						fish.status = "The cast came back empty - recasting."
					end

					return false
				end

				if fn90(value) then
					fish.lost.gone = fish.lost.gone + 1
					fish.status = "The server destroyed the float - reeling in and recasting."

					pcall(function()
						v11:_reelBack()
					end)

					task.wait(1)

					if rawget(v11, "Bobble") then
						fn89(v10, "the float was destroyed and the reel-back was refused")
					end

					return false
				end

				if not position and rawget(value, "Landed") then
					local value2 = rawget(value, "Model")

					if value2 and value2.Parent then
						position = value2.Position
						fish.lastLanding = position
						fn98(position)
					end
				end

				if rawget(v11, "FishCaught") then
					break
				end
				task.wait(0.1)
			end

			if not rawget(v11, "FishCaught") then
				fish.lost.nobite = fish.lost.nobite + 1
				fish.status = "Nothing bit in " .. tostring(45) .. "s - reeling in."

				pcall(function()
					v11:_reelBack()
				end)

				task.wait(1)

				if rawget(v11, "Bobble") then
					fn89(v10, "the reel-back was refused")
				end

				return false
			end

			fish.bites = fish.bites + 1
			local v12, v13 = fn103()
			fn102(v11, v10, arg)
			task.wait(0.8)
			local v14, v15 = fn103()

			if v13 < v15 then
				fish.caught = fish.caught + v15 - v13
				fish.status = ("Caught one - %d this session."):format(fish.caught)

				if tbl5.wh and tbl5.wh.on then
					for k, v16 in pairs(v14) do
						if (v12[k] or 0) < v16 then
							local catch = tbl5.wh.catch
							local v17 = fn74(k)
							local tbl22 = {}
							local tbl23 = {}
							local str2 = tostring(fish.caught)
							tbl23[1] = "Caught this session"
							tbl23[2] = str2
							tbl23[3] = true
							local tbl24 = {}
							local str3 = tostring(v16)
							tbl24[1] = "Now holding"
							tbl24[2] = str3
							tbl24[3] = true
							tbl22[1] = tbl23
							tbl22[2] = tbl24
							catch(k, v17, tbl22)
						end
					end
				end
			elseif fish.plannedMiss then
				fish.lost.miss = (fish.lost.miss or 0) + 1
				fish.status = "Let that one go (humanize)."
			else
				fish.lost.reel = fish.lost.reel + 1
				fish.status = "Lost that one."
			end

			fish.plannedMiss = false
			fish.lastGood = os.clock()
			fish.spotFail = 0

			if fish.dropAtMax then
				pcall(fish.dropMaxPeli)
			end

			if fish.autoSell and not fish.sellBroken then
				local holdAtMaxPeli = fish.holdAtMaxPeli and tbl5.maxPeli() or nil

				if holdAtMaxPeli and tbl5.peli() >= holdAtMaxPeli then
					fish.status = ("Peli is at the cap (%d) - keeping the catch."):format(holdAtMaxPeli)
				else
					fn110()

					if fish.dropAtMax then
						pcall(fish.dropMaxPeli)
					end
				end
			end

			return true
		end

		local v8 = tbl16.Fish1:AddSection("Fishing loop", "play")
		local v9 = tbl16.Fish1:AddSection("Pinned spot", "map-pin")
		local v10 = tbl16.Fish1:AddSection("Where it casts", "crosshair")
		local v11 = tbl16.Fish1:AddSection("Reel minigame", "gauge")
		local v12 = v8:AddParagraph({ Title = "Auto Fish", Content = "Idle" })

		fish.humanOn = function()
			return fish.reelMode == "Instant" and fish.human ~= nil and fish.human.on == true
		end

		fish.humanPause = function(arg)
			local human = fish.human

			local function fn112(arg2, arg3, arg4)
				local n29 = os.clock() + arg2

				while true do
					if not arg() and os.clock() < n29 then
						if arg4 then
							local ok, result = pcall(function()
								return tbl5.merchDue and tbl5.merchDue() or tbl5.geppoDue and tbl5.geppoDue()
							end)

							if not (ok and result) then
								fish.status = arg3:format(math.max(0, n29 - os.clock()))
								task.wait(0.25)
								continue
							end
						else
							fish.status = arg3:format(math.max(0, n29 - os.clock()))
							task.wait(0.25)
							continue
						end
					end

					break
				end

				fish.lastGood = os.clock()
			end

			fn112(0.6 + (math.clamp(tonumber(human.delayMax) or 4, 0.6, 30) - 0.6) * ((math.random() + math.random()) / 2) ^ 1.6, "Humanize: next cast in %.1f s")
			local n29 = math.floor(tonumber(human.every) or 0)
			if n29 <= 0 then
				fish.humanLeft = nil
				return
			end

			if arg() then
				return
			end

			if not fish.humanLeft then
				fish.humanLeft = math.max(1, math.floor(n29 * (0.6 + math.random() * 0.8) + 0.5))
			end

			fish.humanLeft = fish.humanLeft - 1
			if fish.humanLeft > 0 then
				return
			end
			fish.humanLeft = nil
			fn112(math.clamp(tonumber(human.breakMax) or 150, 10, 1800) * (0.3 + math.random() * 0.7), "Humanize: taking a break - %.0f s left", true)
		end

		fn5("FishStatus", function()
			local v13

			while true do
				task.wait(0.4)
				local str = ("%s\n\nCasts %d - caught %d - sold %d"):format(fish.status, fish.casts, fish.caught, fish.sold)

				if fish.casts > 0 then
					local lost = fish.lost
					str ..= ("\nReel %d%% (%d/%d)  -  end to end %d%%"):format(fish.bites > 0 and math.floor(fish.caught / fish.bites * 100 + 0.5) or 100, fish.caught, fish.bites, math.floor(fish.caught / fish.casts * 100 + 0.5))
					local tbl22 = {}

					if lost.land > 0 then
						tbl22[#tbl22 + 1] = ("float landed badly %d"):format(lost.land)
					end

					if lost.moved > 0 then
						tbl22[#tbl22 + 1] = ("cancelled by movement %d"):format(lost.moved)
					end

					if lost.nobite > 0 then
						tbl22[#tbl22 + 1] = ("no bite %d"):format(lost.nobite)
					end

					if lost.reel > 0 then
						tbl22[#tbl22 + 1] = ("lost on the reel %d"):format(lost.reel)
					end

					if lost.gone > 0 then
						tbl22[#tbl22 + 1] = ("float destroyed %d"):format(lost.gone)
					end

					if lost.reset > 0 then
						tbl22[#tbl22 + 1] = ("rod unstuck %d"):format(lost.reset)
					end

					if (lost.miss or 0) > 0 then
						tbl22[#tbl22 + 1] = ("let go on purpose %d"):format(lost.miss)
					end

					if #tbl22 > 0 then
						str ..= "\nLost: " .. table.concat(tbl22, ", ")
					end
				end

				if fish.bob then
					str ..= ("\nBobber pinned - last miss %s"):format(fish.bobErr and ("%.1f studs"):format(fish.bobErr) or "not measured yet")
				end

				if (fish.resets or 0) > 0 then
					str ..= (" - unstuck %d"):format(fish.resets)
				end

				local flag3 = (fish.crafted or 0) > 0

				if not flag3 then
					flag3 = (fish.bought or 0) > 0
				end

				if flag3 then
					str ..= ("\nBait: crafted %d, bought %d"):format(fish.crafted or 0, fish.bought or 0)
				end

				if str ~= v13 then
					v13 = str

					pcall(function()
						v12:SetDesc(str)
					end)
				end

				if fish.toast then
					local toast = fish.toast
					fish.toast = nil
					pcall(notify, "Skull Hub", toast, 8)
				end
			end
		end)

		local GPOAutoFish = v8:AddToggle("GPOAutoFish", {
			Title = "Auto Fish",
			Description = "Equips your best rod, casts, plays the reel and sells the catch.",
			Default = false,
		})

		GPOAutoFish:OnChanged(function(arg)
			if arg and fish.on then
				return
			end

			if not arg then
				fish.on = false
				fish.unfreeze()

				if tbl2.inMenu then
					fish.status = "Idle"
				end

				return
			end

			if tbl2.refuse("GPOAutoFish") then
				fish.status = tbl2.inMenu and tbl2.MENU_STATUS or "BLOCKED - anti-cheat protection not installed"
				return
			end

			if tbl4.on then
				notify("Skull Hub", "Turn Auto Farm off first - Auto Fish shares its mover.", 8)
				GPOAutoFish:SetValue(false)
				return
			end

			fish.on = true
			fish.status = "Starting…"
			fish.lastGood = os.clock()
			local v13 = fish
			fish.stallSig = nil
			v13.stallAt = nil
			fish.restockNext = 0
			fish.homeFail = 0
			local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")

			if fish.home and (not humanoidRootPart or (fish.home.Position - humanoidRootPart.Position).Magnitude > 1500) then
				fish.home = nil
			end

			fn5("AutoFish", function()
				local function fn112()
					return not fish.on
				end

				while fish.on do
					if tbl8.flagged then
						fish.status = "Stopped - the server stopped tracking you."
						fish.on = false
						break
					else
						if not fish.home and (tbl5.merchDue() or tbl5.merch.home) then
							local ok, result = pcall(tbl5.merchRun, fn112)

							if not ok then
								fish.status = "Merchant errand failed: " .. fn2(result)
							end

							fish.lastGood = os.clock()
						end

						if not fish.home and not tbl5.merch.home and (tbl5.geppoDue() or tbl5.geppo.home) then
							local ok, result = pcall(tbl5.geppoRun, fn112)

							if not ok then
								fish.status = "Geppo errand failed: " .. fn2(result)
							end

							fish.lastGood = os.clock()
						end

						local casts = fish.casts
						local ok, result = pcall(fn111, fn112)
						fish.unfreeze()

						if not ok then
							tbl5.gunAimStop()
							tbl17.suspend = false
							fish.status = "Cast failed: " .. fn2(result)
							task.wait(1)
						elseif fish.casts > casts and fish.humanOn() then
							local ok2, result2 = pcall(fish.humanPause, fn112)

							if not ok2 then
								fish.status = "Humanize pause failed: " .. fn2(result2)
							end
						end

						task.wait(0.2)
					end
				end

				fish.unfreeze()
				tbl5.gunAimStop()
				tbl17.suspend = false

				if fish.status == "Starting…" then
					fish.status = "Idle"
				end
			end)
		end)

		v8:AddToggle("GPOFishFreeze", {
			Title = "Freeze character while fishing",
			Description = "Holds you still from the throw until the catch is reeled in, so nothing pushes you off the spot.",
			Default = false,
		}):OnChanged(function(arg)
			fish.freezeOn = arg and true or false

			if not arg then
				fish.unfreeze()
			end
		end)

		v8:AddButton({
			Title = "Sell fish now",
			Description = "Sells the rarities ticked on Catch & Bait.",
			Callback = function()
				fn5("FishSellOnce", function()
					fish.sellBroken = false
					local value = select(2, fn103())
					fn110()
					local value2 = select(2, fn103())
					notify("Skull Hub", value > value2 and ("Sold %d fish."):format(value - value2) or fish.status, 7)
				end)
			end,
		})

		local GPOFishSpot = nil
		local GPOFishBob = nil

		local function fn112(arg)
			if not arg then
				return ""
			end
			local lookVector = arg.LookVector
			return ("%.2f, %.2f, %.2f, %.1f"):format(arg.X, arg.Y, arg.Z, math.deg(math.atan2(lookVector.X, lookVector.Z)))
		end

		local function fn113(arg)
			if not arg then
				return ""
			end
			return ("%.2f, %.2f, %.2f"):format(arg.X, arg.Y, arg.Z)
		end

		local function fn114(arg)
			local tbl22 = {}
			local v13 = tostring
			local str = arg or ""

			for match in v13(str):gmatch("[-%d%.]+") do
				tbl22[#tbl22 + 1] = tonumber(match)
			end

			return tbl22
		end

		local v13 = v9:AddParagraph({ Title = "Pinned spot", Content = "Nothing pinned." })

		fn5("FishPin", function()
			local v14 = nil

			while true do
				task.wait(0.5)
				local str

				if not (fish.spot or fish.bob) then
					str = "Nothing pinned - the loop stands where you leave it and picks a bearing per cast.\nStand where you want to fish, cast once by hand, then press both buttons below."

					if fish.lastLanding then
						str ..= ("\nYour last float landed at %s."):format(fn113(fish.lastLanding))
					end
				else
					str = ("Stance: %s\nBobber: %s"):format(fish.spot and fn112(fish.spot) or "not pinned", fish.bob and fn113(fish.bob) or "not pinned")
					local character = localPlayer.Character
					local clientTool = fish.clientTool

					if not (clientTool and clientTool.Parent == character) then
						clientTool = nil
					end

					clientTool = clientTool and fish.rodTip(clientTool)

					if clientTool then
						local v15, v16, v17 = fish.solveAim(clientTool, clientTool + Vector3.new(10000, 0, 0))
						local floor = math.floor
						str ..= ("\nFrom this stance the rod reaches %d-%d studs."):format(math.floor(v16), floor(v17))

						if fish.bob then
							local magnitude = Vector3.new(fish.bob.X - clientTool.X, 0, fish.bob.Z - clientTool.Z).Magnitude
							str ..= ("  Bobber is %d away%s."):format(math.floor(magnitude), (magnitude < v16 or magnitude > v17) and " - OUT OF RANGE" or "")
						end
					end

					if fish.bobErr then
						str ..= ("\nLast landing missed the pin by %.1f studs."):format(fish.bobErr)
					end
				end

				if str ~= v14 then
					v14 = str

					pcall(function()
						v13:SetDesc(str)
					end)
				end
			end
		end)

		v9:AddButton({
			Title = "Pin the stance to where I am",
			Description = "Saves the exact position AND facing you are standing in. Every cast starts from it, and a bait or merchant errand walks back onto it exactly.",
			Callback = function()
				local character = localPlayer.Character
				character = character and character:FindFirstChild("HumanoidRootPart")
				if not character then
					notify("Skull Hub", "No character to read.", 5)
					return
				end
				local lookVector = character.CFrame.LookVector
				local vector = Vector3.new(lookVector.X, 0, lookVector.Z)

				if vector.Magnitude < 0.05 then
					vector = Vector3.new(0, 0, 1)
				end

				fish.spot = CFrame.new(character.Position, character.Position + vector.Unit)
				local v14 = fish
				local v15 = fish
				fish.bobT = nil
				v14.bobErr = nil
				v15.spotFail = 0

				pcall(function()
					GPOFishSpot:SetValue(fn112(fish.spot))
				end)

				notify("Skull Hub", "Stance pinned.", 5)
			end,
		})

		v9:AddButton({
			Title = "Pin the bobber to where the float is",
			Description = "Cast once - by hand or with the loop - and press this while the float is sitting on the water. Every later cast is solved to land on that exact point.",
			Callback = function()
				local client = fish.client
				local value = client and rawget(client, "Bobble")
				local value2 = value and rawget(value, "Model")
				if not (value2 and value2.Parent) then
					notify("Skull Hub", "No float in the water - cast first, then press this while it is floating.", 8)
					return
				end

				if not rawget(value, "Landed") then
					notify("Skull Hub", "The float is still in the air - wait for it to settle.", 6)
					return
				end
				local v14 = fish
				local v15 = fish
				local v16 = fish
				fish.bob = value2.Position
				v14.bobT = nil
				v15.bobErr = nil
				v16.bobMiss = 0

				pcall(function()
					GPOFishBob:SetValue(fn113(fish.bob))
				end)

				notify("Skull Hub", "Bobber spot pinned.", 5)
			end,
		})

		v9:AddButton({
			Title = "Unpin both",
			Description = "Back to standing where you leave it and picking a bearing per cast.",
			Callback = function()
				local v14 = fish
				local v15 = fish
				local v16 = fish
				fish.spot = nil
				v14.bob = nil
				v15.bobT = nil
				v16.bobErr = nil

				pcall(function()
					GPOFishSpot:SetValue("")
				end)

				pcall(function()
					GPOFishBob:SetValue("")
				end)

				notify("Skull Hub", "Unpinned.", 5)
			end,
		})

		GPOFishSpot = v9:AddInput("GPOFishSpot", {
			Title = "Stance (x, y, z, heading)",
			Placeholder = "empty = not pinned",
			Default = "",
			Finished = true,
			Callback = function(arg)
				local v14 = fn114(arg)
				if #v14 < 3 then
					fish.spot = nil
					return
				end
				local vector = Vector3.new(v14[1], v14[2], v14[3])
				local v15 = math.rad(v14[4] or 0)
				local v16 = fish
				local v17 = fish
				fish.bobT = nil
				v16.bobErr = nil
				v17.spotFail = 0
				local cos = math.cos
				fish.spot = CFrame.new(vector, vector + Vector3.new(math.sin(v15), 0, cos(v15)))
			end,
		})

		GPOFishBob = v9:AddInput("GPOFishBob", {
			Title = "Bobber (x, y, z)",
			Placeholder = "empty = not pinned",
			Default = "",
			Finished = true,
			Callback = function(arg)
				local v14 = fn114(arg)
				local v15 = fish
				fish.bobT = nil
				v15.bobErr = nil
				if #v14 < 3 then
					fish.bob = nil
					return
				end
				fish.bob = Vector3.new(v14[1], v14[2], v14[3])
			end,
		})

		v10:AddToggle("GPOFishAimSea", {
			Title = "Always throw out to sea",
			Description = "Aims at the most open water around you. Off = throws where you face.",
			Default = true,
		}):OnChanged(function(arg)
			fish.aimSea = arg and true or false
		end)

		v10:AddSlider("GPOFishAimDist", {
			Title = "Cast distance",
			Description = "Studs. The bobble lands about half this far out.",
			Default = 70,
			Min = 30,
			Max = 200,
			Rounding = 0,
			Callback = function(arg)
				fish.aimDist = tonumber(arg) or 70
			end,
		})

		v11:AddDropdown("GPOFishReelMode", {
			Title = "How to reel",
			Description = "Legit plays the bar like a hand would. Instant holds it on target.",
			Values = { "Legit", "Instant" },
			Default = "Legit",
			Multi = false,
			Tooltip = "How to reel",
			TooltipDesc = "Legit: the tuned controller drives the real click, ~7 s a fish and it can still miss one. Instant: the bar sits on target for the whole minigame, so every bite lands in a flat 5.5 s - which is the fastest the game itself allows. Use Humanize with Instant.",
			Callback = function(reelMode)
				if reelMode then
					fish.reelMode = reelMode
				end
			end,
		})

		v11:AddSlider("GPOFishReelSense", {
			Title = "Reel sensitivity",
			Description = "Legit mode only. Higher = corrects sooner. Lower it if the bar wobbles.",
			Default = 8,
			Min = 1,
			Max = 10,
			Rounding = 0,
			Callback = function(arg)
				fish.reelSense = tonumber(arg) or 8
			end,
		})

		v11:AddToggle("GPOFishHuman", {
			Title = "Humanize (Instant only)",
			Description = "Random reel time, clicks while reeling, the odd missed fish, random pauses between casts and breaks. Slower, and much less machine-like in the server's log.",
			Default = true,
		}):OnChanged(function(arg)
			fish.human.on = arg and true or false
			fish.humanLeft = nil
		end)

		v11:AddSlider("GPOFishHumanReelMin", {
			Title = "Humanize: fastest reel (s)",
			Description = "Instant alone always takes 5.5 s. Each fish picks a time between these two.",
			Default = 7,
			Min = 6,
			Max = 30,
			Rounding = 0,
			Callback = function(arg)
				fish.human.reelMin = tonumber(arg) or 7
			end,
		})

		v11:AddSlider("GPOFishHumanReelMax", {
			Title = "Humanize: slowest reel (s)",
			Description = "Set below the fastest and the fastest is used for both.",
			Default = 14,
			Min = 6,
			Max = 30,
			Rounding = 0,
			Callback = function(arg)
				fish.human.reelMax = tonumber(arg) or 14
			end,
		})

		v11:AddSlider("GPOFishHumanMiss", {
			Title = "Humanize: miss on purpose (%)",
			Description = "Share of bites let go. Each one costs a bait.",
			Default = 4,
			Min = 0,
			Max = 20,
			Rounding = 0,
			Callback = function(arg)
				fish.human.miss = tonumber(arg) or 4
			end,
		})

		v11:AddSlider("GPOFishHumanDelay", {
			Title = "Humanize: longest pause between casts (s)",
			Description = "Each pause is random, from 0.6 s up to this, mostly short.",
			Default = 4,
			Min = 1,
			Max = 15,
			Rounding = 0,
			Callback = function(arg)
				fish.human.delayMax = tonumber(arg) or 4
			end,
		})

		v11:AddSlider("GPOFishHumanEvery", {
			Title = "Humanize: break every ~N casts",
			Description = "0 = never. The real count varies by 40% either way.",
			Default = 30,
			Min = 0,
			Max = 100,
			Rounding = 0,
			Callback = function(arg)
				fish.human.every = tonumber(arg) or 30
				fish.humanLeft = nil
			end,
		})

		v11:AddSlider("GPOFishHumanBreak", {
			Title = "Humanize: longest break (s)",
			Description = "Each break lasts 30-100% of this. The Traveling Merchant can end it early.",
			Default = 150,
			Min = 20,
			Max = 600,
			Rounding = 0,
			Callback = function(arg)
				fish.human.breakMax = tonumber(arg) or 150
			end,
		})

		local Bait = tbl16.Fish2:AddSection("Bait", "worm")
		local Selling = tbl16.Fish2:AddSection("Selling", "coins")
		local v14 = tbl16.Fish2:AddSection("Devil Fruits", "gem")
		local Notes = tbl16.Fish2:AddSection("Notes", "info")

		Bait:AddDropdown("GPOFishBait", {
			Title = "Bait",
			Description = "Best = the rarest one you hold.",
			Values = { "Best", "Common Fish Bait", "Rare Fish Bait", "Legendary Fish Bait" },
			Default = "Best",
			Multi = false,
			Callback = function(bait)
				if bait then
					fish.bait = bait
				end
			end,
		})

		Selling:AddToggle("GPOFishAutoSell", { Title = "Sell after every catch", Description = "Off = keep everything.", Default = true }):OnChanged(function(arg)
			fish.autoSell = arg and true or false
		end)

		Selling:AddToggle("GPOFishHoldAtMaxPeli", { Title = "Stop selling at max Peli", Default = false }):OnChanged(function(arg)
			fish.holdAtMaxPeli = arg and true or false
		end)

		Selling:AddToggle("GPOFishDropMaxPeli", {
			Title = "Auto drop Peli at max",
			Description = "At 1,000,000 Peli, drops it as a Peli bag. Runs even when the fishing loop is off.",
			Default = false,
		}):OnChanged(function(arg)
			fish.dropAtMax = arg and true or false

			if fish.dropAtMax then
				local v15 = fish
				fish.dropFails = 0
				v15.dropNextAt = 0
			end

			if not fish.dropAtMax then
				fish.dropStatus = "Idle"
			end
		end)

		Selling:AddSlider("GPOFishDropKeep", {
			Title = "Peli to keep when dropping",
			Description = "Stays in your wallet (bait costs Peli). 0 = drop it all.",
			Default = 0,
			Min = 0,
			Max = 900000,
			Rounding = 0,
			Callback = function(arg)
				fish.dropKeep = math.floor(tonumber(arg) or 0)
			end,
		})

		local v15 = Selling:AddParagraph({ Title = "Peli drop", Content = "Idle" })

		fn5("FishDropPeli", function()
			local v16 = nil

			while true do
				task.wait(2)

				if fish.dropAtMax then
					pcall(fish.dropMaxPeli)
				end

				local dropStatus = fish.dropStatus or "Idle"
				if dropStatus == v16 then
					continue
				end
				v16 = dropStatus

				pcall(function()
					v15:SetDesc(dropStatus)
				end)
			end
		end)

		local GPOFishSellRarity = Selling:AddDropdown("GPOFishSellRarity", {
			Title = "Rarities to sell",
			Description = "Unticked is kept. Legendary makes Legendary Fish Bait.",
			Values = { "Common", "Uncommon", "Rare", "Epic", "Legendary" },
			Default = { "Common", "Uncommon", "Rare" },
			Multi = true,
			Callback = function(arg)
				if type(arg) ~= "table" then
					return
				end
				local sell = {}

				for k, v16 in pairs(arg) do
					if v16 then
						sell[k] = true
					end
				end

				fish.sell = sell
			end,
		})

		pcall(function()
			GPOFishSellRarity:SetValue({ Common = true, Uncommon = true, Rare = true })
		end)

		v14:AddToggle("GPOFishStoreFruit", {
			Title = "Auto Store Fruits",
			Description = "Equips a caught Devil Fruit and sends it to Fruit Storage instead of leaving it sitting in the Backpack. Checks YOUR inventory per fruit: one of each (two with a Prestige Fruitbag), and a fruit already at its max is skipped so the next fruit in the backpack gets stored instead. Without any Fruit Bag the account only holds one fruit at a time.",
			Default = true,
		}):OnChanged(function(arg)
			fish.storeFruit = arg and true or false
		end)

		local v16 = v14:AddParagraph({ Title = "Fruit Storage", Content = "Idle" })

		fn5("FishFruitStatus", function()
			local v17 = nil

			while true do
				task.wait(0.5)
				local fruitStatus = fish.fruitStatus or "Idle"
				if fruitStatus == v17 then
					continue
				end
				v17 = fruitStatus

				pcall(function()
					v16:SetDesc(fruitStatus)
				end)
			end
		end)

		Notes:AddParagraph({
			Title = "Good to know",
			Content = [[Out of bait, the loop restocks when the Bait Economy tab is set up, and waits when it is not.

Fishing does not work on Fishman Island - it leaves through the blue pillar first.]],
		})

		local Crafting = tbl16.Fish3:AddSection("Crafting", "hammer")
		local Restocking = tbl16.Fish3:AddSection("Restocking", "shopping-cart")
		local Notes2 = tbl16.Fish3:AddSection("Notes", "info")

		Crafting:AddToggle("GPOFishCraft", {
			Title = "Craft bait from my catch",
			Description = "When the bait runs out, walk to Blacksmith Sen and turn caught fish into bait. Enough fish for one trip is held back from the auto-sell; the surplus still sells.",
			Default = false,
			Callback = function(craftOn)
				fish.craftOn = craftOn
			end,
		})

		local GPOFishCraftWhich = Crafting:AddDropdown("GPOFishCraftWhich", {
			Title = "Recipes to use",
			Description = "Rare needs 2 fish, the others 1. Only Common bait can be bought, so Rare and Legendary are the ones worth crafting.",
			Values = { "Common Fish Bait", "Rare Fish Bait", "Legendary Fish Bait" },
			Default = { "Rare Fish Bait", "Legendary Fish Bait" },
			Multi = true,
			Callback = function(arg)
				local craft = {}

				if type(arg) == "table" then
					for k, v17 in pairs(arg) do
						if v17 then
							craft[k] = true
						end
					end
				end

				fish.craft = craft
			end,
		})

		pcall(function()
			GPOFishCraftWhich:SetValue({ ["Rare Fish Bait"] = true, ["Legendary Fish Bait"] = true })
		end)

		Crafting:AddSlider("GPOFishCraftMax", {
			Title = "Craft at most",
			Description = "Per trip, per recipe. A whole catch is worth more sold than turned into bait you will not get through.",
			Default = 10,
			Min = 1,
			Max = 50,
			Rounding = 0,
			Callback = function(arg)
				fish.craftMax = tonumber(arg) or 10
			end,
		})

		Crafting:AddButton({
			Title = "Craft bait now",
			Description = "Runs the same errand by hand, without waiting to run dry.",
			Callback = function()
				fn5("FishCraftOnce", function()
					if tbl2.refuse() then
						return
					end

					if fish.on then
						notify("Skull Hub", "Turn Auto Fish off first - it owns the mover.", 7)
						return
					end
					local tbl22 = { c = fish.craftOn, b = fish.buyOn }
					fish.craftOn = true
					fish.buyOn = false

					local v17 = fn109(function()
						return false
					end)

					local v18 = fish
					local c = tbl22.c
					local b = tbl22.b
					fish.craftOn = c
					v18.buyOn = b
					notify("Skull Hub", v17 and fish.status or "Nothing to craft right now.", 7)
				end)
			end,
		})

		Restocking:AddToggle("GPOFishBuy", {
			Title = "Buy bait when low",
			Description = "Walks to the bait stand and buys Common Fish Bait. Only used when crafting could not cover it.",
			Default = false,
			Callback = function(buyOn)
				fish.buyOn = buyOn
			end,
		})

		Restocking:AddSlider("GPOFishBaitFloor", {
			Title = "Restock below",
			Description = "Common Fish Bait in hand at which it goes shopping, between casts.",
			Default = 20,
			Min = 1,
			Max = 200,
			Rounding = 0,
			Callback = function(arg)
				fish.baitFloor = tonumber(arg) or 20
			end,
		})

		Restocking:AddSlider("GPOFishBuyAmount", {
			Title = "Buy this many",
			Description = "Capped by what you can afford at 45 Peli each.",
			Default = 50,
			Min = 1,
			Max = 500,
			Rounding = 0,
			Callback = function(arg)
				fish.buyAmount = tonumber(arg) or 50
			end,
		})

		local v17 = Notes2:AddParagraph({ Title = "Bait in hand", Content = "-" })

		fn5("FishBaitStatus", function()
			local v18 = nil

			while true do
				task.wait(2)
				local tbl22 = {}

				for _, v19 in ipairs({ "Common Fish Bait", "Rare Fish Bait", "Legendary Fish Bait" }) do
					tbl22[#tbl22 + 1] = ("%s %d"):format(v19:gsub(" Fish Bait", ""), baitCount(v19))
				end

				local str = table.concat(tbl22, "  -  ") .. ("\n%d Peli"):format(tbl5.peli())

				if fish.craftOn then
					local tbl23 = {}

					for k, v19 in pairs(fn104()) do
						if fish.craft[k] then
							local v20, v21 = fn105(v19.cat)
							local n29 = #tbl23 + 1
							local floor = math.floor
							local n30 = v21 / v19.need
							tbl23[n29] = ("%s: %d ready"):format(k:gsub(" Fish Bait", ""), floor(n30))
						end
					end

					table.sort(tbl23)

					if #tbl23 > 0 then
						str ..= "\n\nCraftable now - " .. table.concat(tbl23, ", ")
					end
				end

				if str ~= v18 then
					v18 = str

					pcall(function()
						v17:SetDesc(str)
					end)
				end
			end
		end)

		Notes2:AddParagraph({
			Title = "Worth knowing",
			Content = "A Common Fish sells for about 56 Peli and a Common Fish Bait costs 45, so selling the fish and buying the bait beats crafting it one-for-one. Rare and Legendary bait cannot be bought at all - crafting is the only source, which is what this tab is really for.",
		})
	end

	fn71()

	local function fn72()
		tbl16.Misc1:AddSection("Anti-AFK", "coffee"):AddToggle("GPOAntiAFK", { Title = "Anti AFK", Default = true }):OnChanged(function(skullHubGPOAntiAFK)
			getgenv().SkullHubGPOAntiAFK = skullHubGPOAntiAFK
		end)
	end

	fn72()
	getgenv().SkullHubGPOAntiAFK = true

	fn7(localPlayer.Idled, "AntiAFK", function()
		if not getgenv().SkullHubGPOAntiAFK then
			return
		end
		local v8 = fn(game:GetService("VirtualUser"))
		v8:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
		task.wait(1)
		v8:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	end)

	local function fn73()
		local tbl18 = { on = false, as = "Skull Hub", plateOff = false }
		local tbl19 = {}

		local function fn74()
			local tbl20 = {}
			local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
			if not playerGui then
				return tbl20, nil
			end
			local name = localPlayer.Name
			local healthBars = playerGui:FindFirstChild("HealthBars")
			healthBars = healthBars and healthBars:FindFirstChild(name)

			if healthBars then
				local nameT = healthBars:FindFirstChild("NameT")

				if nameT and nameT:IsA("TextLabel") then
					tbl20[#tbl20 + 1] = { l = nameT, exact = true }
				end
			end

			local playerlist = playerGui:FindFirstChild("Playerlist")

			if playerlist then
				for _, descendant in ipairs(playerlist:GetDescendants()) do
					if descendant.Name == name then
						local main = descendant:FindFirstChild("Main")
						main = main and main:FindFirstChild("TextLabel")

						if main and main:IsA("TextLabel") then
							tbl20[#tbl20 + 1] = { l = main, exact = true }
						end
					end
				end
			end

			local inventory = playerGui:FindFirstChild("Inventory")
			inventory = inventory and inventory:FindFirstChild("Main")
			inventory = inventory and inventory:FindFirstChild("Titles")
			inventory = inventory and inventory:FindFirstChild("CurrentTitle")

			if inventory and inventory:IsA("TextLabel") then
				tbl20[#tbl20 + 1] = { l = inventory, exact = false }
			end

			return tbl20, healthBars
		end

		local function fn75(arg)
			local v8, v9 = fn74()
			if not v9 then
				return
			end

			for _, child in ipairs(v9:GetChildren()) do
				if child:IsA("GuiObject") and child.Visible == arg then
					pcall(function()
						child.Visible = not arg
					end)
				end
			end
		end

		local function fn76()
			local v8 = fn74()
			local name = localPlayer.Name

			if tbl18.on then
				local text = tostring(tbl18.as)
				local str = name:gsub("(%W)", "%%%1")
				local str2 = text:gsub("%%", "%%%%")

				for _, v9 in ipairs(v8) do
					local text2 = v9.l.Text

					if type(text2) == "string" then
						if v9.exact then
							if text2 ~= text then
								if text2:find(name, 1, true) then
									tbl19[v9.l] = text2
								end

								v9.l.Text = text
							end
						elseif text2:find(name, 1, true) then
							tbl19[v9.l] = text2
							v9.l.Text = text2:gsub(str, str2)
						end
					end
				end
			end

			fn75(tbl18.plateOff)
		end

		local function fn77()
			local v8 = fn74()
			local name = localPlayer.Name

			for _, v9 in ipairs(v8) do
				local v10 = tbl19[v9.l]

				if v10 then
					if v9.l.Text ~= v10 then
						v9.l.Text = v10
					end
				elseif v9.exact and v9.l.Text ~= name then
					v9.l.Text = name
				end
			end

			table.clear(tbl19)
			fn75(false)
		end

		fn5("HideName", function()
			local flag2 = false

			while true do
				if tbl18.on or tbl18.plateOff then
					fn76()
					flag2 = true
				elseif flag2 then
					fn77()
					flag2 = false
				end

				task.wait(0.5)
			end
		end)

		local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")

		if playerGui then
			fn7(playerGui.DescendantAdded, "HideNameRebuild", function(arg)
				if not (tbl18.on or tbl18.plateOff) then
					return
				end

				if not (arg:IsA("TextLabel") or arg:IsA("BillboardGui")) then
					return
				end
				fn6(0.05, "HideNameRebuild", fn76)
			end)
		end

		local Privacy = tbl16.Misc1:AddSection("Privacy", "eye-off")

		Privacy:AddToggle("GPOHideName", {
			Title = "Hide my name",
			Description = "Replaces your account name above your head, on the leaderboard and in the inventory title line. Local only - other players still see the real one.",
			Default = false,
		}):OnChanged(function(arg)
			tbl18.on = arg and true or false

			if arg then
				pcall(fn76)
			end
		end)

		Privacy:AddInput("GPOHideNameAs", {
			Title = "Show instead",
			Description = "Leave it empty to show nothing at all.",
			Default = "Skull Hub",
			Placeholder = "Skull Hub",
			Finished = true,
			Callback = function(arg)
				tbl18.as = tostring(arg or "")

				if tbl18.on then
					pcall(fn76)
				end
			end,
		})

		Privacy:AddToggle("GPOHideNameplate", {
			Title = "Hide my whole nameplate",
			Description = "Takes the level, crew tag, bounty and health bar over your head with it, not just the name.",
			Default = true,
		}):OnChanged(function(arg)
			tbl18.plateOff = arg and true or false

			if arg or tbl18.on then
				pcall(fn76)
			else
				pcall(fn77)
			end
		end)
	end

	fn73()

	tbl5.skipTutorial = function(arg)
		if not (arg and arg:IsA("ScreenGui")) then
			return
		end

		if tbl5.tutorialBusy then
			return
		end
		tbl5.tutorialBusy = true
		local script = arg:WaitForChild("Script", 10)
		local remoteEvent = script and script:WaitForChild("RemoteEvent", 10)
		if not remoteEvent then
			tbl5.tutorialBusy = false
			return
		end

		for i = 1, 3 do
			if arg.Parent then
				pcall(function()
					remoteEvent:FireServer()
				end)

				local n12 = os.clock() + 3

				while arg.Parent and os.clock() < n12 do
					task.wait(0.2)
				end

				continue
			end

			break
		end

		if not arg.Parent and workspace.CurrentCamera and workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then
			local character = localPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")

			pcall(function()
				if humanoid then
					workspace.CurrentCamera.CameraSubject = humanoid
				end

				workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
			end)
		end

		tbl5.tutorialBusy = false

		if not arg.Parent then
			notify("Skull Hub", "New-account tutorial skipped.", 4)
		end
	end

	fn5("TutorialWatch", function()
		local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
		if not playerGui then
			return
		end

		fn7(playerGui.ChildAdded, "TutorialAdded", function(arg)
			if arg.Name == "Tutoiral" then
				tbl5.skipTutorial(arg)
			end
		end)

		for _, child in ipairs(playerGui:GetChildren()) do
			if child.Name == "Tutoiral" then
				tbl5.skipTutorial(child)
			end
		end
	end)

	local function fn74()
		tbl16.Misc1:AddSection("Utility", "wrench"):AddButton({
			Title = "Rejoin",
			Description = "Teleport back into this same place.",
			Callback = function()
				fn4("Rejoin", function()
					v5:Teleport(game.PlaceId, localPlayer)
				end)
			end,
		})
	end

	fn74()

	local function fn75()
		local v8 = tbl16.Misc2:AddSection("Frame Rate", "gauge")

		v8:AddSlider("GPOFPSCap", {
			Title = "FPS Cap",
			Description = "Lower is lighter. 240 = uncapped for practical purposes.",
			Default = 240,
			Min = 5,
			Max = 240,
			Rounding = 0,
			Callback = function(arg)
				tbl5.fpsCap = tonumber(arg)

				if tbl.setfpscap then
					pcall(setfpscap, arg)
				end
			end,
		})

		local obj = setmetatable({}, { __mode = "k" })

		local function fn76(arg)
			local model = arg:FindFirstAncestorOfClass("Model")

			while model do
				local v9 = obj[model]
				if v9 ~= nil then
					return v9
				end
				local flag2 = model:FindFirstChildOfClass("Humanoid") ~= nil
				obj[model] = flag2
				if flag2 then
					return true
				end
				model = model:FindFirstAncestorOfClass("Model")
			end

			return false
		end

		local tbl18 = {
			Decal = true,
			Texture = true,
			ParticleEmitter = true,
			Trail = true,
			Beam = true,
			Fire = true,
			Smoke = true,
			Sparkles = true,
			SurfaceAppearance = true,
			PointLight = true,
			SpotLight = true,
			SurfaceLight = true,
		}

		local flag2 = false

		v8:AddToggle("GPOBoostFPS", {
			Title = "Boost FPS",
			Description = "Flat materials, no shadows/fog/particles, frozen world animations. One-way - rejoin to undo.",
			Default = false,
		}):OnChanged(function(arg)
			if not arg then
				return
			end
			flag2 = true

			fn4("BoostFPS", function()
				v4.GlobalShadows = false
				v4.FogEnd = 9e9
				v4.Brightness = 1

				for _, child in ipairs(v4:GetChildren()) do
					if child:IsA("PostEffect") then
						child.Enabled = false
					end
				end

				pcall(function()
					local level01 = Enum.QualityLevel.Level01
					settings().Rendering.QualityLevel = level01
				end)

				pcall(function()
					workspace.Terrain.WaterWaveSize = 0
					workspace.Terrain.WaterWaveSpeed = 0
					workspace.Terrain.WaterReflectance = 0
				end)

				local function fn77(arg2)
					if arg2:IsA("BasePart") then
						if not fn76(arg2) then
							arg2.Material = Enum.Material.Plastic
							arg2.Reflectance = 0
							arg2.CastShadow = false
						end
					elseif tbl18[arg2.ClassName] then
						if not fn76(arg2) then
							if arg2:IsA("Decal") or arg2:IsA("Texture") then
								arg2.Transparency = 1
							elseif arg2:IsA("SurfaceAppearance") then
								arg2:Destroy()
							else
								arg2.Enabled = false
							end
						end
					end
				end

				for _, descendant in ipairs(workspace:GetDescendants()) do
					pcall(fn77, descendant)
				end

				fn7(workspace.DescendantAdded, "BoostFPSNew", function(arg2)
					if not flag2 then
						return
					end
					pcall(fn77, arg2)
				end)
			end)

			notify("Skull Hub", "FPS boost applied.", 4)
		end)

		tbl16.Misc2:AddSection("Visual", "monitor"):AddToggle("GPOBlackScreen", {
			Title = "Black Screen",
			Description = "Stops 3D rendering entirely. Draggable Hide/Show button included. Reversible.",
			Default = false,
		}):OnChanged(function(arg)
			fn4("BlackScreen", function()
				local hui = gethui and gethui() or game:GetService("CoreGui")
				local skullHubBlackScreen = hui:FindFirstChild("SkullHubBlackScreen")

				if skullHubBlackScreen then
					skullHubBlackScreen:Destroy()
				end

				if not arg then
					pcall(function()
						v2:Set3dRenderingEnabled(true)
					end)

					return
				end

				local TweenService = game:GetService("TweenService")
				local screenGui = Instance.new("ScreenGui")
				screenGui.Name = "SkullHubBlackScreen"
				screenGui.IgnoreGuiInset = true
				screenGui.ResetOnSpawn = false
				screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
				screenGui.DisplayOrder = -100
				screenGui.Parent = hui
				local frame = Instance.new("Frame")
				frame.Size = UDim2.new(1, 0, 1, 0)
				frame.Position = UDim2.new(0, 0, 0, 0)
				frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				frame.BackgroundTransparency = 0
				frame.ZIndex = 100
				frame.Parent = screenGui
				local textButton = Instance.new("TextButton")
				textButton.Size = UDim2.new(0, 140, 0, 45)
				textButton.Position = UDim2.new(0.5, -70, 1, -70)
				textButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
				textButton.Text = "Toggle Screen"
				textButton.Font = Enum.Font.GothamBold
				textButton.TextSize = 16
				textButton.AutoButtonColor = true
				textButton.ZIndex = 9999
				textButton.Parent = screenGui
				local uiCorner = Instance.new("UICorner")
				uiCorner.CornerRadius = UDim.new(0, 12)
				uiCorner.Parent = textButton
				local uiStroke = Instance.new("UIStroke")
				uiStroke.Thickness = 1.5
				uiStroke.Color = Color3.fromRGB(255, 255, 255)
				uiStroke.Transparency = 0.8
				uiStroke.Parent = textButton

				pcall(function()
					v2:Set3dRenderingEnabled(false)
				end)

				local flag3 = true
				local n12 = 0

				local function fn77(arg2)
					pcall(function()
						v2:Set3dRenderingEnabled(arg2)
					end)
				end

				fn7(textButton.MouseButton1Click, "BlackScreenToggle", function()
					flag3 = not flag3
					n12 += 1
					local v9 = n12
					textButton.Text = flag3 and "Hide Screen" or "Show Screen"

					if not flag3 then
						fn77(true)
					end

					local tbl19 = { BackgroundTransparency = flag3 and 0 or 1 }
					local tween = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), tbl19)

					if flag3 then
						fn7(tween.Completed, "BlackScreenTweenDone", function()
							if v9 == n12 and flag3 and screenGui.Parent then
								fn77(false)
							end
						end)
					end

					tween:Play()
				end)

				local flag4 = false
				local v9 = nil
				local v10 = nil

				fn7(textButton.InputBegan, "BlackScreenDrag", function(arg2)
					if arg2.UserInputType == Enum.UserInputType.MouseButton1 or arg2.UserInputType == Enum.UserInputType.Touch then
						local position = arg2.Position
						local position2 = textButton.Position
						flag4 = true
						v9 = position
						v10 = position2
					end
				end)

				fn7(v3.InputChanged, "BlackScreenDrag", function(arg2)
					local flag5 = flag4

					if flag4 then
						flag5 = arg2.UserInputType == Enum.UserInputType.MouseMovement or arg2.UserInputType == Enum.UserInputType.Touch
					end

					if flag5 then
						local n13 = arg2.Position - v9
						textButton.Position = UDim2.new(v10.X.Scale, v10.X.Offset + n13.X, v10.Y.Scale, v10.Y.Offset + n13.Y)
					end
				end)

				fn7(v3.InputEnded, "BlackScreenDrag", function(arg2)
					if arg2.UserInputType == Enum.UserInputType.MouseButton1 or arg2.UserInputType == Enum.UserInputType.Touch then
						flag4 = false
					end
				end)
			end)
		end)

		local flag3 = false

		tbl16.Misc2:AddSection("World", "globe"):AddToggle("GPODeleteMap", {
			Title = "Delete Map",
			Description = "Hides every island, building, ship and the ocean, and strips world effects. Collision and everything the farm navigates by stay exactly as they were. One-way - rejoin to undo.",
			Default = false,
		}):OnChanged(function(arg)
			if not arg then
				return
			end

			if flag3 then
				return
			end
			flag3 = true

			fn4("DeleteMapHide", function()
				local function fn77(arg2)
					if arg2:IsA("BasePart") and not fn76(arg2) then
						arg2.LocalTransparencyModifier = 1
					end
				end

				for _, v9 in ipairs({ "Islands", "Env", "Ships", "BuyableItems", "ZipLines", "Jails", "Boards" }) do
					local v10 = workspace:FindFirstChild(v9)

					if v10 then
						for _, descendant in ipairs(v10:GetDescendants()) do
							pcall(fn77, descendant)
						end

						fn7(v10.DescendantAdded, "DeleteMapHide", function(arg2)
							pcall(fn77, arg2)
						end)
					end
				end

				local clouds = workspace.Terrain:FindFirstChildOfClass("Clouds")

				if clouds then
					clouds.Enabled = false
				end
			end)

			fn5("DeleteMapOcean", function()
				local settings_ = v6:WaitForChild("Stats" .. localPlayer.Name, 30)
				settings_ = settings_ and settings_:WaitForChild("Settings", 30)
				settings_ = settings_ and settings_:WaitForChild("OceanMovement", 30)

				while true do
					if settings_ and settings_.Value ~= false then
						settings_.Value = false
					end

					local ocean = workspace:FindFirstChild("Ocean")
					ocean = ocean and ocean:FindFirstChild("OceanMeshes")

					if ocean then
						ocean.Parent = nil
					end

					task.wait(3)
				end
			end)

			fn4("DeleteMap", function()
				local tbl19 = { SurfaceAppearance = true, Decal = true, Texture = true }

				local function fn77(arg2)
					local className = arg2.ClassName

					if tbl19[className] then
						if not fn76(arg2) then
							arg2:Destroy()
						end
					elseif tbl18[className] then
						if not fn76(arg2) then
							arg2.Enabled = false
						end
					elseif className == "Animator" and not fn76(arg2) then
						for _, v9 in ipairs(arg2:GetPlayingAnimationTracks()) do
							pcall(function()
								v9:Stop(0)
							end)
						end
					end
				end

				for _, descendant in ipairs(workspace:GetDescendants()) do
					pcall(fn77, descendant)
				end

				fn7(workspace.DescendantAdded, "DeleteMapNew", function(arg2)
					if not flag3 then
						return
					end
					pcall(fn77, arg2)
				end)

				local function fn78(arg2)
					if arg2:IsA("BasePart") and not fn76(arg2) then
						arg2.Transparency = 1
						arg2.CastShadow = false
					else
						fn77(arg2)
					end
				end

				local effects = workspace:FindFirstChild("Effects")

				if effects then
					for _, descendant in ipairs(effects:GetDescendants()) do
						pcall(fn78, descendant)
					end

					fn7(effects.DescendantAdded, "EffectsDim", function(arg2)
						if not flag3 then
							return
						end
						pcall(fn78, arg2)
					end)
				end
			end)

			notify("Skull Hub", "Scenery and effects stripped.", 4)
		end)
	end

	fn75()

	local function fn76()
		local tbl18 = {}

		for _, v8 in ipairs({
			"hookfunction",
			"hookmetamethod",
			"getactors",
			"run_on_actor",
			"create_comm_channel",
			"getconnections",
			"getgc",
		}) do
			if not tbl[v8] then
				tbl18[#tbl18 + 1] = v8
			end
		end

		local v8 = tbl16.Misc3:AddSection("Protection", "shield-check"):AddParagraph({ Title = "Protection", Content = "Starting…" })

		local function fn77()
			local banRemote = tbl2.banRemote

			if banRemote then
				banRemote = (tbl2.swapped or 0) > 0
			end

			local tbl19 = {}
			banRemote = banRemote and "✔ Report funnel silenced (" .. tostring(tbl2.swapped) .. " senders redirected)" or "✘ Report funnel NOT silenced"
			local str = tbl2.fuseHooked and "✔ Crash fuse blocked" or "✘ Crash fuse NOT blocked"
			local str2 = tbl2.maxSpeedHooked and "✔ Speed check disabled" or "✘ Speed check still on"
			local str3 = tbl2.heartbeatStale and "⚠ Anti-cheat heartbeat STALE - rejoin" or "✔ Anti-cheat heartbeat healthy"
			local v9 = table.pack(("Hooks: %d actor, %d main"):format(tbl2.actorHooks, tbl2.mainHooks))
			tbl19[1] = banRemote
			tbl19[2] = str
			tbl19[3] = str2
			tbl19[4] = str3

			do
				local values = table.pack(table.unpack(v9, 1, v9.n))
				table.move(values, 1, values.n, 5, tbl19)
			end

			if #tbl18 > 0 then
				tbl19[#tbl19 + 1] = "Missing on this executor: " .. table.concat(tbl18, ", ")
			end

			if not tbl2.protected then
				tbl19[#tbl19 + 1] = "⛔ Farm, movement and combat are BLOCKED: " .. tostring(tbl2.failWhy or "the bypass did not finish")
			end

			pcall(function()
				v8:SetDesc(table.concat(tbl19, "\n"))
			end)
		end

		fn77()

		fn5("BypassStatus", function()
			for i = 1, 40 do
				task.wait(0.5)
				fn77()
				if not (tbl2.stage == "done" or tbl2.stage == "partial") then
					continue
				end
				break
			end
		end)
	end

	fn76()

	local function fn77()
		local v8 = fn41()
		local Run = tbl16.Farm1:AddSection("Run", "wheat")

		local v9 = Run:AddParagraph({
			Title = "Status",
			Content = v8 and ("Ready - %d quests loaded (level %d to %d)."):format(#tbl13.list, tbl13.list[#tbl13.list].lvlReq, tbl13.list[1].lvlReq) or "Quest list failed to load. Only \"Nearest mob\" mode will work.",
		})

		fn5("FarmStatus", function()
			local v10 = nil

			while true do
				task.wait(0.5)
				local quest2 = tbl4.quest
				local str = ("%s\nLevel %d  |  Quest: %s"):format(tbl4.status, fn43(), fn44())

				if tbl8.flagged then
					str ..= "\n⚠ SERVER STOPPED TRACKING YOU - rejoin now"
				elseif tbl4.on then
					if tbl4.lag then
						str ..= ("\nServer sync: %.0f studs behind"):format(tbl4.lag)
					else
						str ..= "\nServer sync: not published by this build"
					end
				end

				local flag2

				if quest2 then
					local name = quest2.name
					flag2 = fn44() == name
				else
					flag2 = quest2
				end

				if flag2 then
					local amount = quest2.amount
					local mob = quest2.mob
					str ..= ("  (%d/%d %s)"):format(fn45(), amount, mob)
				end

				if tbl3.infM1 and tbl4.method ~= "Rifle" then
					str ..= ("\nInfinite M1 on - %d resets"):format(tbl3.resetCount)
				end

				if tbl4.method == "Rifle" then
					local str2 = "\n%s: %s  |  %d shots  |  %d Peli\n%s"
					local format = str2.format
					local gunName = tbl4.gunName
					local str3 = tbl5.hasGun() and "in inventory" or "NOT OWNED"
					local v11 = tostring
					local note = tbl5.gun.note
					str ..= format(str2, gunName, str3, tbl5.gun.shots, tbl5.peli(), v11(note))
				end

				if tbl4.mode == "Buso Haki (Ray)" then
					local v11 = tbl5.busoLearned()
					str ..= ("\nBuso Haki: %s"):format(v11 == nil and "?" or v11 and "LEARNED" or "not learned")
				elseif tbl4.mode == "Level (auto)" then
					str ..= ("\nLadder: %s"):format(tbl5.level.stage)
				elseif tbl4.mode == "Boss: Juzo (Sea 2)" then
					str ..= ("\nJuzo: %d killed this session"):format(tbl5.juzo.kills)

					if tbl5.juzo.lastDrops then
						str ..= ("\nDrop table: %s"):format(tbl5.juzo.lastDrops)
					end
				end

				if str ~= v10 then
					v10 = str

					pcall(function()
						v9:SetDesc(str)
					end)
				end
			end
		end)

		tbl8.onFlag = function()
			tbl4.on = false
			tbl5.gunAimStop()
			fn40()
			tbl4.status = "STOPPED - server stopped tracking you"
			notify("Skull Hub", "The server has stopped tracking your position. Everything is turned off.\nRejoin now - this state does not recover.", 15)
			warn("[Skull Hub] realPos frozen - flagged. All movement stopped.")
		end

		local GPOFarmToggle = Run:AddToggle("GPOFarmToggle", {
			Title = "Auto Farm",
			Description = "Takes quests, kills the mob, turns in. Repeats for EXP.",
			Default = false,
		})

		GPOFarmToggle:OnChanged(function(status)
			if tbl2.inMenu then
				tbl4.on = false

				if status then
					tbl2.menuHold("GPOFarmToggle")
				end

				local v10 = tbl4
				status = status and tbl2.MENU_STATUS or "Idle"
				v10.status = status
				return
			end

			if status and tbl8.flagged then
				notify("Skull Hub", "You are flagged this session - rejoin before farming again.", 10)

				pcall(function()
					GPOFarmToggle:SetValue(false)
				end)

				return
			end

			if status and tbl2.refuse("GPOFarmToggle") then
				tbl4.status = "BLOCKED - anti-cheat protection not installed"
				return
			end
			tbl4.on = status

			if status then
				if not quest and tbl4.mode == "Quest (level)" then
					notify("Skull Hub", "Quest remote missing - can't run quest farm.", 8)
					tbl4.on = false

					pcall(function()
						GPOFarmToggle:SetValue(false)
					end)

					return
				end

				local v10, v11 = tbl5.seaOK(tbl4.mode)

				if not v10 then
					notify("Skull Hub", v11, 10)
					tbl4.on = false

					pcall(function()
						GPOFarmToggle:SetValue(false)
					end)

					return
				end

				fn64()
			else
				tbl4.status = "Stopping…"
			end
		end)

		Run:AddDropdown("GPOFarmMode", {
			Title = "Mode",
			Description = "Level (auto) runs the whole ladder by itself. Quest = the normal take/kill/turn-in loop. Nearest mob = just fight what's around. Buso Haki (Ray) = pay Ray 25,000 Peli (Lv 80+, Kori Island), kill Yetis with melee, learn Buso.",
			Values = (tbl4.juzoUI or lib.Kaitun) and { "Level (auto)", "Quest (level)", "Nearest hostile", "Buso Haki (Ray)", "Boss: Juzo (Sea 2)" } or { "Level (auto)", "Quest (level)", "Nearest hostile", "Buso Haki (Ray)" },
			Default = "Quest (level)",
			Multi = false,
			Callback = function(mode)
				tbl4.mode = mode
				local v10, v11 = tbl5.seaOK(mode)

				if not v10 then
					notify("Skull Hub", v11, 8)
				end
			end,
		})

		Run:AddDropdown("GPOFarmMethod", {
			Title = "Method",
			Description = "Melee walks in and punches. Rifle stands out of aggro range and shoots.",
			Values = { "Melee", "Rifle" },
			Default = "Rifle",
			Multi = false,
			Callback = function(method)
				if tbl4.method ~= method then
					tbl5.gun.spot = nil
				end

				tbl4.method = method

				if method ~= "Rifle" then
					tbl5.gunAimStop()
				else
					fn5("GunRearm", tbl5.gunRearm)
				end
			end,
		})

		local Behavior = tbl16.Farm1:AddSection("Behavior", "list-checks")

		Behavior:AddToggle("GPOFarmTurnIn", {
			Title = "Auto turn in",
			Description = "Walk back to the NPC when the kills are done.",
			Default = true,
		}):OnChanged(function(autoTurnIn)
			tbl4.autoTurnIn = autoTurnIn
		end)

		Behavior:AddToggle("GPOFarmTravel", { Title = "Island travel", Description = "Off = stay on this island.", Default = true }):OnChanged(function(travel)
			tbl4.travel = travel
		end)

		Behavior:AddSlider("GPOFarmTravelRange", {
			Title = "Furthest trip",
			Description = "Studs. The whole First Sea is about 17,000 across.",
			Default = 20000,
			Min = 500,
			Max = 20000,
			Rounding = 0,
			Callback = function(travelRange)
				tbl4.travelRange = travelRange
			end,
		})

		Behavior:AddToggle("GPOFarmSkipBoss", { Title = "Skip boss quests", Description = "Never takes or engages a boss.", Default = true }):OnChanged(function(skipBoss)
			tbl4.skipBoss = skipBoss
		end)

		Behavior:AddToggle("GPOFarmSetSpawn", {
			Title = "Set spawn on each island",
			Description = "Set your respawn point on arrival.",
			Default = true,
		}):OnChanged(function(setSpawn)
			tbl4.setSpawn = setSpawn
		end)

		Behavior:AddToggle("GPOFishQuest", {
			Title = "Take Becky's quest when eligible",
			Description = "Level (auto) only. Off = farm the mob for raw EXP instead.",
			Default = true,
		}):OnChanged(function(fishUseQuest)
			tbl4.fishUseQuest = fishUseQuest
		end)

		local gunName = tbl4.gunName

		Behavior:AddParagraph({
			Title = "Level (auto)",
			Content = "Farms to level " .. tostring(tbl5.maxLevel()) .. " on its own.\n\n" .. [[`Melee` sails to Fishman Island and farms Fishman Karate User.

]] .. "`Rifle` farms Bandits first to afford the " .. gunName .. " (" .. tostring(tbl5.gunPrice()) .. " Peli), buys it, then does the same - but from a safe distance.",
		})

		local Movement = tbl16.Farm2:AddSection("Movement", "footprints")

		Movement:AddDropdown("GPOFarmMoveMode", {
			Title = "How it moves",
			Description = "Walk is the safe one.",
			Values = { "Walk", "Walk only", "Glide" },
			Default = "Glide",
			Multi = false,
			Callback = function(moveMode)
				tbl4.moveMode = moveMode
			end,
		})

		Movement:AddSlider("GPOFarmSpeed", {
			Title = "Travel speed",
			Description = "Walking is held at 46 unless the speed bypass landed.",
			Default = 46,
			Min = 16,
			Max = 100,
			Rounding = 0,
			Callback = function(moveSpeed)
				tbl4.moveSpeed = moveSpeed
			end,
		})

		Movement:AddToggle("GPOFarmAvoidWalls", {
			Title = "Go around walls",
			Description = "Jump, then step around what is in the way.",
			Default = true,
		}):OnChanged(function(arg)
			tbl4.setAvoidWalls(arg)
		end)

		Movement:AddToggle("GPOFarmGlideRoute", {
			Title = "Glide follows paths",
			Description = "Glide goes along streets and around buildings. Off = straight line, over them.",
			Default = true,
		}):OnChanged(function(arg)
			tbl4.glideRoute = arg and true or false
		end)

		Movement:AddToggle("GPOFarmAvoidIslands", {
			Title = "Sail around islands",
			Description = "Steer round islands that are not the destination.",
			Default = true,
		}):OnChanged(function(arg)
			tbl4.avoidIslands = arg and true or false
		end)

		Movement:AddSlider("GPOFarmHoverCap", {
			Title = "Max height",
			Description = "Only used while gliding. 55 was safe, 80 was a kick.",
			Default = 50,
			Min = 10,
			Max = 55,
			Rounding = 0,
			Callback = function(arg)
				tbl4.setAltitudeCap(arg)
			end,
		})

		Movement:AddSlider("GPOFarmHover", {
			Title = "Hover height",
			Description = "Float above the mob so it misses you.",
			Default = 6,
			Min = 0,
			Max = 8,
			Rounding = 0,
			Callback = function(hoverY)
				tbl4.hoverY = hoverY
			end,
		})

		local v10 = tbl16.Farm2:AddSection("Combat range & timing", "crosshair")

		v10:AddSlider("GPOFarmReach", {
			Title = "Approach distance",
			Description = "How close it gets before swinging.",
			Default = 11,
			Min = 4,
			Max = 14,
			Rounding = 0,
			Callback = function(reach)
				tbl4.reach = reach
			end,
		})

		v10:AddSlider("GPOFarmRetreat", {
			Title = "Back off below HP %",
			Description = "Break contact and heal.",
			Default = 35,
			Min = 0,
			Max = 80,
			Rounding = 0,
			Callback = function(arg)
				tbl4.retreatHP = arg / 100
			end,
		})

		v10:AddSlider("GPOFarmResume", {
			Title = "Fight again above HP %",
			Description = "Keep this above the back-off number.",
			Default = 65,
			Min = 20,
			Max = 100,
			Rounding = 0,
			Callback = function(arg)
				tbl4.resumeHP = arg / 100
			end,
		})

		v10:AddSlider("GPOFarmTimeout", {
			Title = "Mob timeout",
			Description = "Seconds before giving up on a mob.",
			Default = 45,
			Min = 10,
			Max = 180,
			Rounding = 0,
			Callback = function(mobTimeout)
				tbl4.mobTimeout = mobTimeout
			end,
		})

		local Melee = tbl16.Farm3:AddSection("Melee", "sword")

		Melee:AddToggle("GPOM1MultiHit", { Title = "Hit every mob in range", Default = true }):OnChanged(function(arg)
			tbl4.multiHit = arg and true or false
			tbl5.hitbox.tool = nil
		end)

		Melee:AddToggle("GPOM1NoKnockback", {
			Title = "M1 without knockback",
			Description = "Mobs stay put instead of flying away.",
			Default = true,
		}):OnChanged(function(noKnockback)
			tbl4.noKnockback = noKnockback
		end)

		local GPOInfiniteM1 = Melee:AddToggle("GPOInfiniteM1", {
			Title = "Infinite M1",
			Description = "Stops the 5th hit knocking mobs away, so you can keep hitting.",
			Default = false,
		})

		GPOInfiniteM1:OnChanged(function(infM1)
			if infM1 then
				if tbl2.refuse("GPOInfiniteM1") then
					tbl3.infM1 = false
					return
				end

				if not tbl3.resetM1 and not tbl3.handler then
					notify("Skull Hub", "Couldn't find the combat handler - Infinite M1 unavailable.", 8)
					tbl3.infM1 = false

					pcall(function()
						GPOInfiniteM1:SetValue(false)
					end)

					return
				end

				if not fn12() then
					tbl3.infM1 = false

					pcall(function()
						GPOInfiniteM1:SetValue(false)
					end)

					return
				end
			end

			tbl3.infM1 = infM1
		end)

		Melee:AddToggle("GPOM1Fast", {
			Title = "Stun-lock M1",
			Description = "Evenly spaced M1 (~0.55 s) with no combo pause, so mobs stay stunned and never block. Turns itself off for the session if the server pushes back.",
			Default = true,
		}):OnChanged(function(arg)
			tbl4.fastM1 = arg and true or false

			if tbl4.fastM1 then
				local v11 = tbl6
				tbl6.fastOff = nil
				v11.land = {}
			end
		end)
	end

	fn77()

	local function fn78()
		local v8 = tbl16.Farm4:AddSection("Juzo the Diamondback", "skull")

		v8:AddParagraph({
			Title = "What this is",
			Content = [[The Second Sea boss on Turtleback Cave. Drops the Mythical Fruit Chest, Turtleback Armor/Helmet and the Kira kira no Mi.

Pick "Boss: Juzo (Sea 2)" as the Farm mode on the Level Farm tab, then turn Auto Farm on. It uses the same movement, combat and safety engine as every other mode - including the Rifle method if you have that selected.]],
		})

		local v9 = v8:AddParagraph({ Title = "Juzo status", Content = "Idle" })

		fn5("JuzoStatus", function()
			local v10 = nil

			while true do
				task.wait(1)
				local str

				if tbl5.whichSea() ~= 2 then
					str = "You are not in the Second Sea. Juzo cannot be farmed from here.\nMovement -> Travel -> Second Sea will take you there."
				else
					local v11, v12 = tbl5.juzoFind()
					local str2

					if v11 then
						local humanoid = v11:FindFirstChildOfClass("Humanoid")
						str2 = ("Juzo is UP and loaded - %d%% HP"):format(humanoid and math.floor(humanoid.Health / math.max(humanoid.MaxHealth, 1) * 100) or 0)
					elseif v12 then
						str2 = "Juzo is UP (too far away to load - the boss registry can still see him)"
					else
						str2 = "Juzo is DOWN - waiting for the respawn"
					end

					str = str2 .. ("\n%d killed this session"):format(tbl5.juzo.kills)

					if tbl5.juzo.lastDrops then
						str ..= ("\nDrop table: %s"):format(tbl5.juzo.lastDrops)
					end
				end

				if str ~= v10 then
					v10 = str

					pcall(function()
						v9:SetDesc(str)
					end)
				end
			end
		end)

		v8:AddToggle("GPOJuzoSeaGate", {
			Title = "Sea gate",
			Description = "Refuse to run a sea-locked mode in the wrong sea. Level (auto) is First Sea only, Juzo is Second Sea only. Leave this on.",
			Default = true,
		}):OnChanged(function(seaGate)
			tbl4.seaGate = seaGate
		end)

		local Dodging = tbl16.Farm4:AddSection("Dodging", "shield")

		Dodging:AddParagraph({
			Title = "How it dodges",
			Content = [[Juzo carries the Kira no Mi, so his Crystal Dash is the fruit's own effect: the game renames the diamond rig to "CrystalDashFirstRigDestroy" and deletes it 1.5s later. That instance existing IS the dash window - the timing comes from the game, not from a guess.

The farm also backs off when he goes airborne. While either is true it holds position away from him instead of standing in the hit - across the ground, not straight up, because altitude is capped at ~50 studs by the tracker safety rule.]],
		})

		Dodging:AddSlider("GPOJuzoSafeRadius", {
			Title = "Retreat distance",
			Description = "How far to back off from Juzo, across the ground, while an attack is in flight. This is the part of the dodge that does the work.",
			Default = tbl4.juzoSafeRadius,
			Min = 25,
			Max = 200,
			Rounding = 0,
			Callback = function(juzoSafeRadius)
				tbl4.juzoSafeRadius = juzoSafeRadius
			end,
		})

		Dodging:AddSlider("GPOJuzoDodgeHeight", {
			Title = "Retreat height (capped)",
			Description = "Extra altitude on the retreat. Anything past ~50 is thrown away by the altitude clamp - 80 studs up froze the server's position tracker, so the mover will not go there. Back off further instead of higher.",
			Default = tbl4.juzoDodgeHeight,
			Min = 0,
			Max = 50,
			Rounding = 0,
			Callback = function(juzoDodgeHeight)
				tbl4.juzoDodgeHeight = juzoDodgeHeight
			end,
		})

		Dodging:AddSlider("GPOJuzoAirY", {
			Title = "Airborne height",
			Description = "Juzo above this Y counts as mid-leap. The arena floor sits near y=28.",
			Default = tbl4.juzoAirY,
			Min = 60,
			Max = 250,
			Rounding = 0,
			Callback = function(juzoAirY)
				tbl4.juzoAirY = juzoAirY
			end,
		})

		local Respawn = tbl16.Farm4:AddSection("Respawn", "clock")

		Respawn:AddParagraph({
			Title = "No rejoin, on purpose",
			Content = [[The public Juzo scripts call Kick() the moment they cannot see him, because they poll workspace.NPCs and cannot tell "despawned" from "not streamed in yet".

This reads the game's own registry (ReplicatedStorage.Replication.Bosses) instead, which is not subject to streaming and answers from anywhere on the map. So it just waits - no kick, no rejoin loop, and nothing that looks like a join-rate signature from the server's side.]],
		})

		Respawn:AddSlider("GPOJuzoWait", {
			Title = "Respawn patience (minutes)",
			Description = "How long to wait before saying the server may be stale. It keeps waiting either way - this only changes the status line.",
			Default = math.floor(tbl4.juzoWait / 60),
			Min = 5,
			Max = 60,
			Rounding = 0,
			Callback = function(arg)
				tbl4.juzoWait = arg * 60
			end,
		})
	end

	if tbl4.juzoUI or lib.Kaitun then
		fn78()
	end

	local function fn79()
		local v8 = tbl16.Misc4:AddSection("Traveling Merchant", "store")

		v8:AddParagraph({
			Title = "What this does",
			Content = [[When the Traveling Merchant turns up, whatever is running - Auto Fish or Auto Farm - remembers exactly where it was standing, sails over, buys what you ticked below, and walks back to that same spot to carry on.

It also works on its own: with nothing else running, use the button at the bottom.

Nothing is bought until you tick something. An empty list means it never goes.]],
		})

		local v9 = v8:AddParagraph({ Title = "Merchant status", Content = "Idle" })

		fn5("MerchStatus", function()
			local v10 = nil

			while true do
				task.wait(1)
				tbl5.merchArm()
				local v11 = tbl5.merchAt()
				local str

				if not v11 then
					str = "The merchant is not in this sea right now."
				else
					local character = localPlayer.Character
					character = character and character:FindFirstChild("HumanoidRootPart")
					local magnitude = character and (character.Position - v11).Magnitude
					str = ("HERE at %d, %d, %d"):format(v11.X, v11.Y, v11.Z)

					if magnitude then
						str ..= ("\n%d studs away (limit %d)%s"):format(magnitude, tbl4.merchRange, magnitude > tbl4.merchRange and " - TOO FAR, will not go" or "")
					end

					local v12 = tbl5.islandAt(v11)

					if v12 then
						str ..= ("\nOn: %s"):format(v12)
					end

					local v13, v14 = tbl5.merchReachable(v11)

					if not v13 then
						str ..= ("\n⚠ WILL NOT GO - %s"):format(tostring(v14))
					end

					local v15 = tbl5.merchDwell()

					if v15 then
						str ..= ("\nRestocks in %d:%02d"):format(v15 // 60, v15 % 60)
					end
				end

				local str2 = str .. ("\n%s\nBought %d for %d Peli this session. You have %d."):format(tbl5.merch.status, tbl5.merch.bought, tbl5.merch.spent, tbl5.peli())

				if tbl5.merch.note then
					str2 ..= ("\n%s"):format(tbl5.merch.note)
				end

				if tbl5.merch.home then
					str2 ..= "\n⚠ Part-way through an errand - it still has to walk back."
				end

				if str2 ~= v10 then
					v10 = str2

					pcall(function()
						v9:SetDesc(str2)
					end)
				end
			end
		end)

		v8:AddToggle("GPOMerchOn", {
			Title = "Auto Merchant",
			Description = "Let Auto Fish / Auto Farm break off to shop when he appears.",
			Default = false,
		}):OnChanged(function(merchOn)
			tbl4.merchOn = merchOn
		end)

		v8:AddDropdown("GPOMerchWant", {
			Title = "Buy these",
			Description = "Nothing is ever bought unless it is ticked here. Cheapest ticked item first, so a small purse buys the most things.",
			Values = {
				"Bisento",
				"Blossom Skirt",
				"Bomi's Log Pose",
				"Coffin Boat",
				"Crab Cutlass",
				"Crimson Nightcoat",
				"Cute Turkey Bucket Hat",
				"Dark Root",
				"Desert Merchant Outfit",
				"Golden Hook",
				"Golden Staff",
				"Gravity Blade",
				"Hoverboard",
				"Jitte",
				"Karoo Mount",
				"Kessui",
				"Knight's Gauntlet",
				"Legendary Fish Bait",
				"Legendary Fruit Chest",
				"Merchants Banana Rod",
				"Mythical Fruit Chest",
				"Pilgrim Hat",
				"Powderpunk Outfit",
				"Race Reroll",
				"Raiui",
				"Rare Fish Bait",
				"Rare Fruit Chest",
				"Raylo's Outfit",
				"SP Reset Essence",
				"Sea-Breeze Haori",
				"Sea-Breeze Skirt",
				"Shadowrunner Mask",
				"Shadowrunner's Outfit",
				"Sorcerer Hunter Costume",
				"Spare Fruit Bag",
				"Special Tailor Token",
				"Spirit Color Essence",
				"Street Enforcer Outfit",
				"Striker",
				"Tari's Karoo Coat",
				"Thrilled Ship",
				"Tropical Parrot",
				"Turkey Costume",
				"Turkey Head",
				"Ulquiorra Outfit",
				"Wastelander Goggles",
			},
			Multi = true,
			Default = {},
			Callback = function(arg)
				if type(arg) ~= "table" then
					return
				end
				local merchWant = {}

				for k, v10 in pairs(arg) do
					if v10 then
						merchWant[k] = true
					end
				end

				tbl4.merchWant = merchWant
			end,
		})

		local Limits = tbl16.Misc4:AddSection("Limits", "sliders-horizontal")

		Limits:AddSlider("GPOMerchRange", {
			Title = "Maximum trip (studs)",
			Description = "He will not be visited from further than this. His dwell time cannot be read until the shop is open - i.e. until after the trip - so a very long sail risks arriving after he has gone. He was seen 12,400 studs away during testing.",
			Default = tbl4.merchRange,
			Min = 500,
			Max = 15000,
			Rounding = 0,
			Callback = function(merchRange)
				tbl4.merchRange = merchRange
			end,
		})

		Limits:AddSlider("GPOMerchPerVisit", {
			Title = "Max purchases per visit",
			Description = "A hard cap, whatever the stock and your Peli say.",
			Default = tbl4.merchPerVisit,
			Min = 1,
			Max = 50,
			Rounding = 0,
			Callback = function(merchPerVisit)
				tbl4.merchPerVisit = merchPerVisit
			end,
		})

		Limits:AddSlider("GPOMerchReserve", {
			Title = "Keep back (Peli)",
			Description = "Never spend below this. Useful when the level farm still has to buy a Rifle.",
			Default = tbl4.merchReserve,
			Min = 0,
			Max = 100000,
			Rounding = 0,
			Callback = function(merchReserve)
				tbl4.merchReserve = merchReserve
			end,
		})

		tbl16.Misc4:AddSection("Go now", "footprints"):AddButton({
			Title = "Go to the merchant now",
			Description = "Runs the errand once, right now, and walks back. Turn Auto Farm and Auto Fish off first - they drive the same mover.",
			Callback = function()
				fn5("MerchNow", function()
					if tbl2.refuse() then
						return
					end
					local fish = tbl5.fish
					if tbl4.on or fish and fish.on then
						notify("Skull Hub", "Turn Auto Farm and Auto Fish off first - they drive the same mover.", 8)
						return
					end

					if tbl8.flagged then
						notify("Skull Hub", "You are flagged this session - rejoin first.", 8)
						return
					end
					local v10 = tbl5.merchAt()
					if not v10 then
						notify("Skull Hub", "The merchant is not in this sea right now.", 6)
						return
					end
					local v11, v12 = tbl5.merchReachable(v10)
					if not v11 then
						notify("Skull Hub", ("Cannot go: %s."):format(tostring(v12)), 10)
						return
					end

					if not next(tbl4.merchWant) then
						notify("Skull Hub", "Tick something under \"Buy these\" first - otherwise there is nothing to buy and the trip is wasted.", 8)
						return
					end
					tbl5.merch.lastVisit = nil

					tbl5.merchRun(function()
						return tbl8.flagged
					end)
				end)
			end,
		})
	end

	fn79()

	local function fn80()
		local v8 = tbl16.Misc4:AddSection("Auto Buy Geppo (Yi)", "footprints")

		v8:AddParagraph({
			Title = "What this does",
			Content = [[Learns Sky Walk (the Geppo jump) from Yi on Coco Island for 50,000 Peli - First Sea only.

With Auto Farm or Auto Fish running it is done as an errand between beats, and walks back to where you were. With nothing running it goes on its own.

It stops for good once you know Sky Walk, and waits while you have under 50,000 Peli.]],
		})

		local v9 = v8:AddParagraph({ Title = "Geppo status", Content = "Idle" })

		fn5("GeppoStatus", function()
			local v10

			while true do
				task.wait(1)
				local fish = tbl5.fish
				local on = tbl4.on or fish and fish.on
				local v11, v12 = tbl5.geppoDue()

				if tbl4.geppoOn and not on and not tbl5.geppo.running and not tbl5.merch.home and (v11 or tbl5.geppo.home) then
					tbl5.geppo.running = true

					local ok, result = pcall(tbl5.geppoRun, function()
						local fish2 = tbl5.fish
						return not tbl4.geppoOn or tbl4.on or fish2 and fish2.on or tbl8.flagged
					end)

					tbl5.geppo.running = false

					if not ok then
						tbl5.geppo.status = "Geppo errand failed: " .. fn2(result)
					end

					v11, v12 = tbl5.geppoDue()
				end

				local v13 = tbl5.geppoOwned()
				local str = ("Sky Walk: %s  |  Peli: %d"):format(v13 == nil and "?" or v13 and "LEARNED" or "not learned", tbl5.peli()) .. "\n" .. tbl5.geppo.status

				if not v11 and v12 ~= "off" then
					str ..= "\n" .. tostring(v12)
				end

				if tbl5.geppo.home then
					str ..= "\n⚠ Part-way through an errand - it still has to walk back."
				end

				if str ~= v10 then
					v10 = str

					pcall(function()
						v9:SetDesc(str)
					end)
				end
			end
		end)

		v8:AddToggle("GPOGeppoOn", {
			Title = "Auto Buy Geppo",
			Description = "Go to Yi (Coco Island) and learn Sky Walk once you can afford it.",
			Default = false,
		}):OnChanged(function(geppoOn)
			tbl4.geppoOn = geppoOn
		end)
	end

	fn80()

	local function fn81()
		local v8 = tbl16.Misc1:AddSection("Auto Equip Title", "award")
		local tbl18 = { "Godly Fisherman", "Master Fisherman", "Skilled Fisherman", "Novice Fisherman", "Fruit Fisher" }
		local str = "Best fishing title (auto)"
		tbl5.title = { on = false, want = str, status = "Idle", fails = {}, nextAt = 0 }

		local function fn82()
			local v9 = fn42()
			return v9 and v9:FindFirstChild("Titles") or nil
		end

		tbl5.titleCurrent = function()
			local equipedTitle = fn82()
			equipedTitle = equipedTitle and equipedTitle:FindFirstChild("EquipedTitle")
			return equipedTitle and tostring(equipedTitle.Value) or nil
		end

		tbl5.titleOwned = function()
			local tbl19 = {}
			local tbl20 = {}
			local v9 = fn82()
			local allTitles = v9 and v9:FindFirstChild("AllTitles")
			if not (allTitles and type(allTitles.Value) == "string" and allTitles.Value ~= "") then
				return tbl19, tbl20
			end

			local ok, result = pcall(function()
				return game:GetService("HttpService"):JSONDecode(allTitles.Value)
			end)

			if not (ok and type(result) == "table") then
				return tbl19, tbl20
			end

			for k in pairs(result) do
				if type(k) == "string" and k ~= "" then
					tbl19[k] = true
					tbl20[#tbl20 + 1] = k
				end
			end

			table.sort(tbl20)
			return tbl19, tbl20
		end

		tbl5.titleBest = function()
			local v9 = tbl5.titleOwned()

			for _, v10 in ipairs(tbl18) do
				if v9[v10] then
					return v10
				end
			end

			return nil
		end

		tbl5.titleEquip = function(arg)
			if type(arg) ~= "string" or arg == "" then
				return false, "no title chosen"
			end
			local title = tbl5.title
			if title.fails[arg] then
				return false, ("the server refused \"%s\" earlier"):format(arg)
			end

			if tbl5.titleCurrent() == arg then
				return true
			end

			if not tbl5.titleOwned()[arg] then
				return false, ("you do not own \"%s\""):format(arg)
			end
			local events = v6:FindFirstChild("Events")
			local titles = events and events:FindFirstChild("Titles")
			if not titles then
				return false, "the Titles remote is missing on this build"
			end

			local ok, result = pcall(function()
				return titles:InvokeServer(arg, false)
			end)

			if not ok then
				return false, "the equip call errored"
			end
			local n12 = os.clock() + 2

			while os.clock() < n12 do
				if tbl5.titleCurrent() == arg then
					return true
				end
				task.wait(0.15)
			end

			if result == false then
				title.fails[arg] = true
				return false, ("the server refused \"%s\""):format(arg)
			end
			return false, ("\"%s\" was sent but never took effect"):format(arg)
		end

		local function fn83()
			local title = tbl5.title
			local want = title.want

			if want == str then
				want = tbl5.titleBest()
				if not want then
					title.status = "You own none of the fishing titles - nothing to equip."
					return
				end
			end

			local v9 = tbl5.titleCurrent()
			if v9 == nil then
				title.status = "Waiting for your stats to load…"
				return
			end

			if v9 == want then
				title.status = ("Wearing %s."):format(want)
				return
			end
			local nextAt = title.nextAt
			if os.clock() < nextAt then
				return
			end
			title.nextAt = os.clock() + 30
			local v10, v11 = tbl5.titleEquip(want)

			if v10 then
				title.status = ("Equipped %s."):format(want)

				if tbl5.wh then
					tbl5.wh.milestone("Title", ("Equipped the **%s** title."):format(want))
				end
			else
				title.status = ("Could not equip %s: %s"):format(want, tostring(v11))
			end
		end

		local v9 = v8:AddParagraph({ Title = "Title status", Content = "Idle" })

		fn5("AutoTitle", function()
			local v10 = nil

			while true do
				task.wait(5)

				if tbl2.inMenu then
					if tbl5.title.on then
						tbl5.title.status = tbl2.MENU_STATUS
					elseif tbl5.title.status == tbl2.MENU_STATUS then
						tbl5.title.status = "Idle"
					end
				elseif tbl5.title.on then
					local ok, result = pcall(fn83)

					if not ok then
						tbl5.title.status = "Errored: " .. fn2(result)
					end
				end

				local v11 = tbl5.titleCurrent()
				local str2 = (("Active (perks): %s"):format(v11 == nil and "?" or v11 == "" and "none" or v11) .. ("\nBest fishing title you own: %s"):format(tbl5.titleBest() or "none")) .. "\n" .. tostring(tbl5.title.status)

				if str2 ~= v10 then
					v10 = str2

					pcall(function()
						v9:SetDesc(str2)
					end)
				end
			end
		end)

		v8:AddToggle("GPOAutoTitle", {
			Title = "Auto Equip Title",
			Description = "Keep a title equipped in the Active (perk) slot. The Vanity slot is never touched. Only titles you already own are ever sent.",
			Default = false,
		}):OnChanged(function(on)
			tbl5.title.on = on
		end)

		local v10, v11 = tbl5.titleOwned()
		local tbl19 = { "Best fishing title (auto)" }

		for _, v12 in ipairs(v11) do
			tbl19[#tbl19 + 1] = v12
		end

		local GPOAutoTitlePick = v8:AddDropdown("GPOAutoTitlePick", {
			Title = "Which title",
			Description = "\"" .. str .. "\" ranks the five fishing titles by their real perk (Godly 2x rare > Master 1.25x > Skilled 15% lure > Novice 5% > Fruit Fisher, which has no perk on this build) and wears the best one you own.",
			Values = tbl19,
			Multi = false,
			Default = str,
		})

		GPOAutoTitlePick:OnChanged(function(want)
			if type(want) ~= "string" or want == "" then
				return
			end
			tbl5.title.want = want
			tbl5.title.nextAt = 0
		end)

		v8:AddButton({
			Title = "Refresh the list",
			Description = "Re-read the titles you own. Use it after earning a new one.",
			Callback = function()
				local v12, v13 = tbl5.titleOwned()
				local tbl20 = { "Best fishing title (auto)" }

				for _, v14 in ipairs(v13) do
					tbl20[#tbl20 + 1] = v14
				end

				pcall(function()
					GPOAutoTitlePick:SetValues(tbl20)
				end)

				notify("Skull Hub", ("You own %d title%s."):format(#v13, #v13 == 1 and "" or "s"), 6)
			end,
		})
	end

	fn81()

	local function fn82()
		local n12 = 1730877806
		local ps = { code = "", on = false, status = "Off.", tried = false, hub = "Regular", sea = "Auto" }
		tbl5.ps = ps
		local skullHubGPOPS = getgenv().SkullHubGPOPS

		if type(skullHubGPOPS) == "table" then
			ps.code = tostring(skullHubGPOPS.code or "")
			ps.on = skullHubGPOPS.on == true
			local hub = tostring(skullHubGPOPS.hub or "")

			if hub == "Regular" or hub == "Trade Hub" or hub == "Universe Hub" or hub == "Fish Hub" then
				ps.hub = hub
			end

			local sea = tostring(skullHubGPOPS.sea or "")

			if sea == "Auto" or sea == "First" or sea == "Second" then
				ps.sea = sea
			end
		end

		local v8 = tbl16.Misc5:AddSection("Private Server", "door-open")
		local v9 = v8:AddParagraph({ Title = "Status", Content = "Off." })

		fn5("PSStatus", function()
			local v10 = nil

			while true do
				task.wait(1)
				local status = ps.status
				local reservedCode = v6:FindFirstChild("reservedCode")

				if reservedCode and type(reservedCode.Value) == "string" and reservedCode.Value ~= "" then
					status ..= "\n\nThis server: " .. reservedCode.Value
				elseif game.PlaceId ~= n12 then
					status ..= "\n\nThis server: public"
				end

				if status ~= v10 then
					v10 = status

					pcall(function()
						v9:SetDesc(status)
					end)
				end
			end
		end)

		local function fn83()
			local reservedCode = v6:FindFirstChild("reservedCode")
			return reservedCode and type(reservedCode.Value) == "string" and reservedCode.Value ~= "" and reservedCode.Value == ps.code
		end

		local function fn84()
			if not tbl.queue_on_teleport then
				return false
			end

			return (pcall(queue_on_teleport, table.concat({
				("getgenv().SkullHubGPOPS = { code = %q, on = true, hub = %q, sea = %q }"):format(ps.code, ps.hub, ps.sea),
				"repeat task.wait() until game:IsLoaded()",
				"loadstring(game:HttpGet('https://raw.githubusercontent.com/hungquan99/SkullHub/main/loader.lua'))()",
			}, "\n")))
		end

		local tbl18 = {
			Regular = true,
			["Trade Hub"] = "tradeHub",
			["Fish Hub"] = "fishHub",
			["Universe Hub"] = "universeHub",
		}

		local function fn85()
			local stats = v6:FindFirstChild("Stats" .. localPlayer.Name)
			stats = stats and stats:FindFirstChild("Stats")
			stats = stats and stats:FindFirstChild("CurrentSea")

			if stats then
				stats = tostring(stats.Value):lower()
			end

			return (stats or ""):find("second", 1, true) and "Second" or "First"
		end

		local function fn86(arg)
			local tbl19 = {}

			if arg:IsA("TextLabel") or arg:IsA("TextButton") then
				tbl19[#tbl19 + 1] = tostring(arg.Text)
			end

			for _, descendant in ipairs(arg:GetDescendants()) do
				if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
					tbl19[#tbl19 + 1] = tostring(descendant.Text)
				end
			end

			return table.concat(tbl19, "\n"):lower()
		end

		local function fn87(arg)
			local v10 = fn86(arg)
			if v10:find("sea to go", 1, true) or v10:find("which sea", 1, true) or v10:find("first sea", 1, true) and v10:find("second sea", 1, true) then
				return "sea"
			end
			local frame = arg:FindFirstChild("Frame")
			if not (frame and frame:FindFirstChild("RemoteEvent")) then
				return nil
			end

			if arg.Name == "chooseType" or v10:find("private server", 1, true) then
				return "hub"
			end
			return nil
		end

		local function fn88(arg, arg2)
			local str = arg2:lower()

			for _, descendant in ipairs(arg:GetDescendants()) do
				if descendant:IsA("ImageButton") or descendant:IsA("TextButton") then
					local name = descendant.Name
					if (fn86(descendant) .. "\n" .. name:lower()):find(str, 1, true) then
						return descendant
					end
				end
			end

			return nil
		end

		local function fn89(arg, arg2)
			if not tbl.firesignal then
				return false, "this executor has no firesignal - answer the sea prompt by hand"
			end

			if tbl.getconnections then
				local flag2 = false

				for _, v10 in ipairs({ "MouseButton1Click", "Activated" }) do
					local ok, result = pcall(getconnections, arg2[v10])

					if ok and type(result) == "table" and #result > 0 then
						pcall(firesignal, arg2[v10])
						flag2 = true
					end
				end

				if flag2 then
					return true
				end
				return false, "that button has no handler connected"
			end

			pcall(firesignal, arg2.MouseButton1Click)
			task.wait(1)

			if arg.Parent then
				pcall(firesignal, arg2.Activated)
			end

			return true
		end

		local tbl19 = {}

		local function fn90()
			local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
			if not playerGui then
				return false
			end

			for k in pairs(tbl19) do
				if not k.Parent then
					tbl19[k] = nil
				end
			end

			local flag2 = false

			for _, child in ipairs(playerGui:GetChildren()) do
				local isScreenGui = child:IsA("ScreenGui") and fn87(child) or nil

				if isScreenGui then
					flag2 = true

					if not tbl19[child] then
						if isScreenGui == "hub" then
							local frame = child:FindFirstChild("Frame")
							local remoteEvent = frame and frame:FindFirstChild("RemoteEvent")
							local v10 = tbl18[ps.hub]

							if remoteEvent and v10 ~= nil then
								tbl19[child] = true

								pcall(function()
									remoteEvent:FireServer(v10)
								end)

								ps.status = ("Answered %q - the server is teleporting us."):format(ps.hub)
							end
						else
							local sea = ps.sea

							if sea ~= "First" and sea ~= "Second" then
								sea = fn85()
							end

							local v10 = fn88(child, sea)

							if not v10 then
								ps.status = "The sea prompt is open but no First/Second button was found - answer it by hand."
							else
								local v11, v12 = fn89(child, v10)

								if v11 then
									tbl19[child] = true
									ps.status = ("Answered the sea prompt with %s Sea."):format(sea)
								else
									ps.status = "Could not press the sea button: " .. tostring(v12)
								end
							end
						end
					end
				end
			end

			return flag2
		end

		local function fn91()
			local events = v6:WaitForChild("Events", 30)
			local reserved = events and events:FindFirstChild("reserved")

			if not reserved then
				ps.status = "Events.reserved is missing - cannot join by code."
				notify("Skull Hub", "Events.reserved is missing - cannot join by code.", 8)
				return
			end

			fn84()
			ps.status = "Reserving " .. ps.code .. "..."
			local flag2 = false
			local v10 = nil

			fn5("PSReserve", function()
				local ok, result = pcall(function()
					return reserved:InvokeServer(ps.code)
				end)

				flag2 = true

				if ok then
					v10 = result
				end
			end)

			local n13 = os.clock() + 20
			local flag3

			while true do
				flag3 = false

				if os.clock() < n13 then
					if fn90() then
						flag3 = true
						break
					else
						local flag4 = false

						if flag2 then
							flag3 = flag4
							break
						else
							task.wait(0.25)
						end
					end
				else
					break
				end
			end

			if not flag3 then
				ps.status = "Refused (\"" .. fn2(v10) .. "\"). Check the code."
				notify("Skull Hub", "The private server refused that code: " .. fn2(v10), 10)
				return
			end

			ps.status = "Code accepted - joining " .. ps.code .. "..."
			notify("Skull Hub", ("Code accepted - answering %q, the server is teleporting us."):format(ps.hub), 6)
			local n14 = os.clock() + 45

			while os.clock() < n14 do
				fn90()
				task.wait(1)
			end

			ps.status = "Still in the menu 45s after answering - try again."
		end

		local function fn92()
			if not ps.on then
				return
			end

			if ps.code == "" then
				ps.status = "No code entered."
				return
			end

			if game.PlaceId == n12 then
				fn91()
				return
			end

			if fn83() then
				ps.status = "Already in " .. ps.code .. "."
				return
			end

			if ps.tried then
				ps.status = "Did not land in " .. ps.code .. ". Toggle off and on to retry."
				return
			end
			ps.tried = true

			if not fn84() then
				notify("Skull Hub", "This executor has no queue_on_teleport - the hub will not come back after the teleport. Re-execute it once you are in the menu.", 10)
			end

			ps.status = "Going to the menu place..."
			task.wait(1)

			fn4("PSTeleport", function()
				v5:Teleport(1730877806, localPlayer)
			end)
		end

		local GPOPSCode = v8:AddInput("GPOPSCode", {
			Title = "Private Server Code",
			Placeholder = "code",
			Default = "",
			Finished = true,
			Callback = function(arg)
				local code = tostring(arg or ""):gsub("^%s+", ""):gsub("%s+$", "")

				if code ~= ps.code then
					ps.tried = false
				end

				ps.code = code
			end,
		})

		if ps.code ~= "" then
			pcall(function()
				GPOPSCode:SetValue(ps.code)
			end)
		end

		local GPOPSHubType = v8:AddDropdown("GPOPSHubType", {
			Title = "Server type",
			Description = "Which of the four buttons to press on the game's \"Which private server do you want to join?\" prompt.",
			Values = { "Regular", "Trade Hub", "Universe Hub", "Fish Hub" },
			Default = "Regular",
			Multi = false,
			Callback = function(arg)
				local hub = tostring(arg or "")

				if tbl18[hub] ~= nil then
					ps.hub = hub
				end
			end,
		})

		pcall(function()
			GPOPSHubType:SetValue(ps.hub)
		end)

		local GPOPSSea = v8:AddDropdown("GPOPSSea", {
			Title = "Sea (Regular only)",
			Description = "Auto = the sea your character is already in.",
			Values = { "Auto", "First Sea", "Second Sea" },
			Default = "Auto",
			Multi = false,
			Callback = function(arg)
				local str = tostring(arg or "")
				local v10 = ps
				local str2 = str == "First Sea" and "First"
				local sea

				if str2 then
					sea = str2
				else
					sea = str == "Second Sea" and "Second"
				end

				v10.sea = sea or "Auto"
			end,
		})

		pcall(function()
			local v10 = GPOPSSea
			local setValue = v10.SetValue
			local str = ps.sea == "First" and "First Sea"
			local str2

			if str then
				str2 = str
			else
				str2 = ps.sea == "Second" and "Second Sea"
			end

			setValue(v10, str2 or "Auto")
		end)

		local GPOPSAutoJoin = v8:AddToggle("GPOPSAutoJoin", {
			Title = "Auto Join PS",
			Description = "Teleports out to the menu place, joins the code above, and comes back with the hub still running.",
			Default = false,
		})

		GPOPSAutoJoin:OnChanged(function(on)
			ps.on = on

			if not on then
				ps.status = "Off."
				ps.tried = false
				return
			end

			ps.tried = false
			fn5("PSJoin", fn92)
		end)

		if ps.on then
			pcall(function()
				GPOPSAutoJoin:SetValue(true)
			end)
		end

		v8:AddButton({
			Title = "Join now",
			Description = "Runs the join once, right now, ignoring the retry latch.",
			Callback = function()
				local v10 = ps
				ps.on = true
				v10.tried = false
				fn5("PSJoinNow", fn92)
			end,
		})
	end

	fn82()

	local function fn83()
		local stats = v6:FindFirstChild("Events") and v6.Events:FindFirstChild("stats")

		local tbl18 = {
			{ key = "Strength", label = "Strength" },
			{ key = "Defense", label = "Defense" },
			{ key = "Stamina", label = "Stamina" },
			{ key = "SwordMastery", label = "Sword Mastery" },
			{ key = "GunMastery", label = "Gun Mastery" },
			{ key = "DevilFruitMastery", label = "Devil Fruit" },
			{ key = "FightingStyleMastery", label = "Fighting Style Mastery" },
		}

		local stats2 = { on = false, targets = {}, cap = 800, bulk = true, thread = nil, status = "Off" }

		local function fn84()
			local playerGui = localPlayer:FindFirstChild("PlayerGui")
			playerGui = playerGui and playerGui:FindFirstChild("Statistics")
			return playerGui and playerGui:FindFirstChild("Main")
		end

		local function fn85()
			local v8 = fn42()
			return v8 and v8:FindFirstChild("Stats")
		end

		local function fn86()
			local tbl19 = {}
			local tbl20 = {}
			local v8 = fn85()
			local stats3 = fn84()
			stats3 = stats3 and stats3:FindFirstChild("Stats")

			if stats3 then
				for _, child in ipairs(stats3:GetChildren()) do
					if child:IsA("ImageLabel") then
						local stat = child:FindFirstChild("Stat")
						local amount = child:FindFirstChild("Amount")
						local v9 = v8 and v8:FindFirstChild(child.Name)

						tbl19[child.Name] = {
							label = stat and stat.Text ~= "" and stat.Text or child.Name,
							value = v9 and v9.Value or amount and tonumber(amount.Text) or 0,
							add = child:FindFirstChild("Add"),
							usable = child.Visible,
						}

						tbl20[#tbl20 + 1] = child.Name
					end
				end
			end

			if #tbl20 == 0 then
				local function fn87(arg)
					local v9 = v8 and v8:FindFirstChild(arg)
					return v9 ~= nil and v9.Value ~= ""
				end

				local tbl21 = { DevilFruitMastery = fn87("DF"), FightingStyleMastery = fn87("FightingStyle") }

				for _, v9 in ipairs(tbl18) do
					local v10 = v8 and v8:FindFirstChild(v9.key)

					if v10 then
						local flag2 = tbl21[v9.key]

						if flag2 == nil then
							flag2 = true
						end

						tbl19[v9.key] = { label = v9.label, value = v10.Value, add = nil, usable = flag2 }
						tbl20[#tbl20 + 1] = v9.key
					end
				end
			end

			return tbl19, tbl20
		end

		local function fn87()
			local skillPoints = fn85()
			skillPoints = skillPoints and skillPoints:FindFirstChild("SkillPoints")
			if skillPoints then
				return skillPoints.Value
			end
			local v8 = fn84()
			local topOptions = v8 and v8:FindFirstChild("TopOptions")
			topOptions = topOptions and topOptions:FindFirstChild("AvailableSP")
			return topOptions and tonumber(string.match(topOptions.Text, "%d+")) or 0
		end

		local function fn88(arg, arg2, arg3)
			if stats then
				stats:FireServer(arg, nil, arg2)
				return true
			end

			if arg3 and arg3.add and tbl.firesignal then
				for i = 1, math.min(arg2, 25) do
					pcall(firesignal, arg3.add.Activated)
					task.wait(0.05)
				end

				return true
			end

			return false
		end

		local statLabels = {}
		local statKeyOf = {}
		local v8, v9 = fn86()

		for _, v10 in ipairs(v9) do
			statLabels[#statLabels + 1] = v8[v10].label
			statKeyOf[v8[v10].label] = v10
		end

		tbl5.stats = stats2
		tbl5.statLabels = statLabels
		tbl5.statKeyOf = statKeyOf
		local v10 = tbl16.Stats1:AddSection("Auto Stats", "trending-up")
		local v11 = v10:AddParagraph({ Title = "Status", Content = "Off" })

		local function fn89()
			local v12 = fn87()
			if v12 <= 0 then
				stats2.status = "No points to spend"
				return
			end
			local v13 = fn86()

			for _, target in ipairs(stats2.targets) do
				local v14 = v13[target]

				if v14 and v14.usable and v14.value < stats2.cap then
					local n12 = stats2.bulk and math.min(v12, stats2.cap - v14.value) or 1
					if n12 >= 1 and fn88(target, n12, v14) then
						stats2.status = ("+%d into %s (was %d, cap %d)"):format(n12, v14.label, v14.value, stats2.cap)
						return
					end
				end
			end

			local label = nil

			for _, target in ipairs(stats2.targets) do
				if v13[target] and not v13[target].usable then
					label = v13[target].label
				end
			end

			if label then
				stats2.status = ("Can't spend into %s yet - the game hides that stat for you"):format(label)
			elseif stats or tbl.firesignal then
				stats2.status = "Every picked stat is at its cap"
			else
				stats2.status = "No stats remote and no firesignal - can't spend on this executor"
			end
		end

		local function fn90()
			if stats2.thread then
				return
			end

			stats2.thread = fn5("StatsLoop", function()
				while stats2.on do
					if #stats2.targets == 0 then
						stats2.status = "Pick a stat below"
						task.wait(0.5)
					else
						local ok, result = pcall(fn89)

						if not ok then
							stats2.status = "Error: " .. fn2(result)
							task.wait(1)
						end

						task.wait(0.4)
					end
				end

				stats2.thread = nil
				stats2.status = "Off"
			end)
		end

		fn5("StatsStatus", function()
			local v12 = nil

			while true do
				task.wait(0.5)
				local v13 = fn86()
				local str = ("%s\nUnspent points: %d"):format(stats2.status, fn87())
				local tbl19 = {}

				for _, target in ipairs(stats2.targets) do
					if v13[target] then
						tbl19[#tbl19 + 1] = ("%s %d"):format(v13[target].label, v13[target].value)
					end
				end

				if #tbl19 > 0 then
					str ..= "\n" .. table.concat(tbl19, "  |  ")
				end

				if str ~= v12 then
					v12 = str

					pcall(function()
						v11:SetDesc(str)
					end)
				end
			end
		end)

		v10:AddToggle("GPOAutoStats", {
			Title = "Auto Stats",
			Description = "Spends skill points into the stats you pick below.",
			Default = false,
		}):OnChanged(function(on)
			stats2.on = on

			if tbl2.inMenu then
				if on then
					tbl2.menuHold("GPOAutoStats")
				end

				stats2.status = on and tbl2.MENU_STATUS or "Off"
				return
			end

			if on then
				fn90()
			end
		end)

		v10:AddDropdown("GPOStatPick", {
			Title = "Stats to level",
			Description = "Points go into these, in the order they are listed here.",
			Values = statLabels,
			Default = {},
			Multi = true,
			Callback = function(arg)
				local tbl19 = {}

				if type(arg) == "table" then
					for k, v12 in pairs(arg) do
						if v12 == true then
							tbl19[k] = true
						elseif type(v12) == "string" then
							tbl19[v12] = true
						end
					end
				end

				local targets = {}

				for _, statLabel in ipairs(statLabels) do
					if tbl19[statLabel] and statKeyOf[statLabel] then
						targets[#targets + 1] = statKeyOf[statLabel]
					end
				end

				stats2.targets = targets
			end,
		})

		v10:AddSlider("GPOStatCap", {
			Title = "Stop at",
			Description = "Stop adding to a stat once it reaches this.",
			Default = 800,
			Min = 10,
			Max = 2000,
			Rounding = 0,
			Callback = function(cap)
				stats2.cap = cap
			end,
		})

		v10:AddToggle("GPOStatBulk", {
			Title = "Spend in bulk",
			Description = "On: dump every spare point at once. Off: one point at a time.",
			Default = true,
		}):OnChanged(function(bulk)
			stats2.bulk = bulk
		end)

		tbl16.Stats1:AddSection("Manual", "hand"):AddButton({
			Title = "Spend points now",
			Description = "One pass, without turning the loop on.",
			Callback = function()
				fn4("StatsOnce", fn89)
				notify("Skull Hub", stats2.status, 5)
			end,
		})
	end

	fn83()

	tbl16.Settings1:AddToggle("AexecToggle", { Title = "Auto Execute", Default = false }):OnChanged(function(arg)
		if arg then
			fn5("AutoExec", function()
				pcall(function()
					if queue_on_teleport then
						queue_on_teleport([[repeat task.wait() until game:IsLoaded()
loadstring(game:HttpGet('https://raw.githubusercontent.com/hungquan99/SkullHub/main/loader.lua'))()
]])
					end
				end)
			end)

			notify("Skull Hub", "Auto execute is enabled!", 5)
		else
			notify("Skull Hub", "Auto execute is disabled!", 5)
		end
	end)

	v7:SelectTab(1)
	lib:CreateMinimizer()
	lib2:SetLibrary(lib)
	lib3:SetLibrary(lib)
	lib2:IgnoreThemeSettings()
	lib2:SetIgnoreIndexes({ "GPOTravelGo" })
	lib3:SetFolder("Skull Hub")
	lib2:SetFolder("Skull Hub/Grand Piece Online")
	lib3:BuildInterfaceSection(tbl16.Settings1)
	lib2:BuildConfigSection(tbl16.Settings2)
	v7:SelectTab(1)
	notify("Skull Hub", "Grand Piece Online script loaded successfully!", 5)
	lib2:LoadAutoloadConfig()

	local function fn84()
		local skullHubGPOKaitun = getgenv().SkullHubGPOKaitun
		if not skullHubGPOKaitun then
			return
		end
		local options = lib.Options

		local function fn85(arg, arg2)
			local v8 = options[arg]
			if not v8 or type(v8.SetValue) ~= "function" then
				skullHubGPOKaitun.note("control \"" .. tostring(arg) .. "\" not found - skipped.")
				return false
			end
			local ok, result = pcall(v8.SetValue, v8, arg2)

			if not ok then
				skullHubGPOKaitun.note("\"" .. tostring(arg) .. "\" failed: " .. fn2(result))
			end

			return ok
		end

		skullHubGPOKaitun.buildHUD()
		skullHubGPOKaitun.armRejoin()

		fn4("KaitunWebhook", function()
			if skullHubGPOKaitun.webhook == "" then
				return
			end
			local request_ = syn and syn.request or http_request or request
			local request_2

			if request_ then
				request_2 = request_
			else
				request_2 = http and http.request
			end

			if type(request_2) ~= "function" then
				skullHubGPOKaitun.note("Webhook set but this executor has no HTTP request function.")
				return
			end
			local v8 = fn(game:GetService("HttpService"))
			local str = "https://github.com/hungquan99/Interface/blob/main/Images/skullhub.png?raw=true"

			local function fn86(arg)
				local ok, result = pcall(request_2, {
					Url = skullHubGPOKaitun.webhook,
					Method = "POST",
					Headers = { ["Content-Type"] = "application/json" },
					Body = v8:JSONEncode(arg),
				})

				local flag2

				if ok then
					flag2 = type(result) ~= "table" or not result.StatusCode or result.StatusCode < 300
				else
					flag2 = ok
				end

				return flag2
			end

			local function fn87(arg, arg2)
				local str2 = nil

				if skullHubGPOKaitun.mention ~= "" then
					str2 = "<@" .. skullHubGPOKaitun.mention .. ">"
				end

				local str3

				if arg and arg2 > arg + 1 then
					str3 = ("Level %d -> %d  (+%d)"):format(arg, arg2, arg2 - arg)
				else
					str3 = ("Level %d"):format(arg2)
				end

				if tbl5.maxLevel() <= arg2 then
					str3 ..= "\nMax level reached - the level ladder has nothing left to farm."
				end

				return fn86({
					username = "Skull Hub",
					content = str2,
					embeds = {
						{
							title = "Grand Piece Online - Kaitun",
							color = 3447003,
							fields = {
								{ name = "Name", value = ("||[%d] %s||"):format(arg2, localPlayer.Name) },
								{ name = "Level Up", value = str3 },
							},
							footer = { text = "Skull Hub", icon_url = str },
							timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
						},
					},
				})
			end

			skullHubGPOKaitun.milestone = function(arg, arg2, arg3)
				fn5("KaitunMilestone", function()
					local str2 = nil

					if skullHubGPOKaitun.mention ~= "" then
						str2 = "<@" .. skullHubGPOKaitun.mention .. ">"
					end

					local v9 = fn86
					local tbl18 = { username = "Skull Hub", content = str2 }
					local embeds = {}
					local tbl19 = { title = "Grand Piece Online - Kaitun", color = 3066993 }
					local fields = {}
					local tbl20 = { name = "Name", value = ("||%s||"):format(localPlayer.Name) }
					local tbl21 = { name = tostring(arg), value = tostring(arg2) }
					fields[1] = tbl20
					fields[2] = tbl21
					tbl19.fields = fields
					tbl19.footer = { text = "Skull Hub", icon_url = str }
					tbl19.timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
					embeds[1] = tbl19
					tbl18.embeds = embeds
					local v10 = v9(tbl18)

					if arg3 then
						pcall(arg3, v10 == true)
					end
				end)
			end

			local v9 = fn42()
			local level = v9 and v9:FindFirstChild("Stats") and v9.Stats:FindFirstChild("Level")
			if not level then
				skullHubGPOKaitun.note("Level value not found - the webhook has nothing to watch.")
				return
			end
			skullHubGPOKaitun.level = level.Value
			skullHubGPOKaitun.lastSentLevel = skullHubGPOKaitun.level
			local n12 = nil

			fn7(level.Changed, "KaitunLevel", function(arg)
				local level2 = tonumber(arg)
				local flag2 = not level2

				if not flag2 then
					flag2 = level2 <= (skullHubGPOKaitun.level or 0)
				end

				if flag2 then
					skullHubGPOKaitun.level = level2 or skullHubGPOKaitun.level
					return
				end
				skullHubGPOKaitun.level = level2
				n12 = os.clock() + 5
			end)

			fn5("KaitunWebhook", function()
				while true do
					task.wait(1)

					local ok, result = pcall(function()
						if not (n12 and os.clock() >= n12) then
							return
						end
						local level2 = skullHubGPOKaitun.level
						n12 = nil
						local lastSentLevel = skullHubGPOKaitun.lastSentLevel or level2
						local n13 = level2 - lastSentLevel
						local flag2 = level2 >= tbl5.maxLevel() and lastSentLevel < tbl5.maxLevel()
						if n13 < 100 and not flag2 then
							return
						end

						if fn87(lastSentLevel, level2) then
							skullHubGPOKaitun.lastSentLevel = level2
							skullHubGPOKaitun.note(("Webhook sent - level %d (+%d since last send)."):format(level2, n13))
						else
							skullHubGPOKaitun.note("Webhook send FAILED (bad URL, or rate-limited).")
						end
					end)

					if not ok then
						skullHubGPOKaitun.note("Webhook tick errored: " .. fn2(result))
						task.wait(5)
					end
				end
			end)
		end)

		local function fn86(arg)
			local stats = fn42()
			stats = stats and stats:FindFirstChild("Stats")
			stats = stats and stats:FindFirstChild(arg)
			return stats and tonumber(stats.Value) or nil
		end

		local n12 = 400
		local n13 = 600
		local n14 = 500

		skullHubGPOKaitun.statPolicy = function()
			local stats = tbl5.stats
			if not stats then
				return
			end
			local GunMastery = fn86("GunMastery")
			local Strength = fn86("Strength")
			local Defense = fn86("Defense")
			if not (GunMastery and Strength and Defense) then
				return
			end
			local str, n15

			if skullHubGPOKaitun.method == "Rifle" and GunMastery < n12 then
				str = "GunMastery"
				n15 = 400
			elseif Strength < n13 then
				str = "Strength"
				n15 = 600
			else
				str = nil
				n15 = nil

				if Defense < n14 then
					str = "Defense"
					n15 = 500
				end
			end

			local statSig = "done"

			if str then
				statSig = str .. ":" .. n15
			end

			if statSig == skullHubGPOKaitun.statSig then
				return
			end
			skullHubGPOKaitun.statSig = statSig

			if str then
				fn85("GPOStatCap", n15)
				stats.targets = { str }

				if not stats.on then
					fn85("GPOAutoStats", true)
				end

				if str == "Strength" then
					skullHubGPOKaitun.note(("Stats: Strength (melee) to %d."):format(n15))
				elseif str == "Defense" then
					skullHubGPOKaitun.note(("Stats: Defense to %d - the offence stats are capped."):format(n15))
				else
					skullHubGPOKaitun.note(("Stats: Gun Mastery to %d."):format(n15))
				end
			else
				stats.targets = {}

				if stats.on then
					fn85("GPOAutoStats", false)
				end

				skullHubGPOKaitun.note("Stats: targets reached - the remaining points stay unspent.")
			end
		end

		local tbl18 = {
			STAND = Vector3.new(-1339.1877, 4.0750246, -4981.712),
			SPOT = "-1370.33, 4.13, -4997.44, -1.4",
			SPOT_POS = Vector3.new(-1370.33, 4.13, -4997.44),
			BOB = "-1370.79, -3.50, -4978.45",
			BUSO_LATCH = "SkullHub_GPO_BusoHalt_" .. tostring(localPlayer.UserId) .. ".txt",
			SPAWN_ISLAND = "Shell's Town",
			PUFF_LATCH = "SkullHub_GPO_Puff_" .. tostring(localPlayer.UserId) .. ".txt",
			SPRESET = "SP Reset Essence",
			SPRESET_LATCH = "SkullHub_GPO_SPReset_" .. tostring(localPlayer.UserId) .. ".txt",
			SPRESET_PRICE = "SkullHub_GPO_SPResetPrice_" .. tostring(localPlayer.UserId) .. ".txt",
			SPRESET_WH = "SkullHub_GPO_SPResetWebhook_" .. tostring(localPlayer.UserId) .. ".txt",
			PUFF_LEVEL = 325,
			PUFF_TRIES = 3,
			PUFF_RETRY = 120,
		}

		if tbl.isfile then
			local ok, result = pcall(isfile, tbl18.BUSO_LATCH)

			if ok and result then
				skullHubGPOKaitun.busoHalt = true
			end

			local ok2, result2 = pcall(isfile, tbl18.PUFF_LATCH)

			if ok2 and result2 then
				skullHubGPOKaitun.puffDone = true
			end

			local ok3, result3 = pcall(isfile, tbl18.SPRESET_LATCH)

			if ok3 and result3 then
				skullHubGPOKaitun.spResetDone = true

				if tbl.readfile then
					local ok4, result4 = pcall(readfile, tbl18.SPRESET_LATCH)

					if ok4 and type(result4) == "string" and result4 ~= "" then
						skullHubGPOKaitun.spResetHow = "acquired " .. result4:gsub("%s+$", "")
					end
				end
			end

			local ok4, result4 = pcall(isfile, tbl18.SPRESET_WH)

			if ok4 and result4 then
				skullHubGPOKaitun.spResetWHSent = true
			end
		end

		skullHubGPOKaitun.spResetNotify = function()
			if not skullHubGPOKaitun.spResetDone or skullHubGPOKaitun.spResetWHSent or not skullHubGPOKaitun.milestone then
				return
			end
			local spResetWHAt = skullHubGPOKaitun.spResetWHAt

			if spResetWHAt then
				local spResetWHAt2 = skullHubGPOKaitun.spResetWHAt
				spResetWHAt = os.clock() - spResetWHAt2 < 60
			end

			if spResetWHAt then
				return
			end

			if (skullHubGPOKaitun.spResetWHTries or 0) >= 10 then
				return
			end
			skullHubGPOKaitun.spResetWHAt = os.clock()
			skullHubGPOKaitun.spResetWHTries = (skullHubGPOKaitun.spResetWHTries or 0) + 1
			local tbl19 = {}
			local str = ("Got an **%s** - the standing merchant order is done."):format(tbl18.SPRESET)
			local str2 = "How: " .. tostring(skullHubGPOKaitun.spResetHow or "acquired")
			local v8 = table.pack(("Peli now: %d"):format(tbl5.peli()))
			tbl19[1] = str
			tbl19[2] = str2

			do
				local values = table.pack(table.unpack(v8, 1, v8.n))
				table.move(values, 1, values.n, 3, tbl19)
			end

			skullHubGPOKaitun.milestone("SP Reset Essence", table.concat(tbl19, "\n"), function(arg)
				if arg then
					skullHubGPOKaitun.spResetWHSent = true
					skullHubGPOKaitun.spResetWHAt = nil

					if tbl.writefile then
						pcall(writefile, tbl18.SPRESET_WH, os.date("!%Y-%m-%dT%H:%M:%SZ"))
					end

					skullHubGPOKaitun.note("SP Reset Essence webhook delivered.")
				else
					skullHubGPOKaitun.note(("SP Reset Essence webhook was not accepted (try %d/10) - retrying in 60s."):format(skullHubGPOKaitun.spResetWHTries or 0))
				end
			end)
		end

		local function fn87(arg, arg2)
			if skullHubGPOKaitun.spResetDone then
				return
			end
			skullHubGPOKaitun.spResetDone = true
			tbl4.merchWant = {}
			local str = tostring(arg)
			local spResetHow

			if tonumber(arg2) then
				spResetHow = ("%s for %d Peli"):format(str, tonumber(arg2))
			else
				spResetHow = str
			end

			skullHubGPOKaitun.spResetHow = spResetHow

			if tbl.writefile then
				pcall(writefile, tbl18.SPRESET_LATCH, os.date("!%Y-%m-%dT%H:%M:%SZ") .. " " .. spResetHow)
			end

			skullHubGPOKaitun.note(("%s acquired (%s) - Auto Merchant switched off. Delete %s from the executor workspace to buy another."):format(tbl18.SPRESET, spResetHow, tbl18.SPRESET_LATCH))
			skullHubGPOKaitun.spResetNotify()
		end

		tbl5.merch.onBought = function(arg, arg2)
			if arg == tbl18.SPRESET then
				fn87("bought from the merchant", arg2)
			end
		end

		local num = nil

		if tbl.isfile and tbl.readfile then
			local ok, result = pcall(function()
				if isfile(tbl18.SPRESET_PRICE) then
					return readfile(tbl18.SPRESET_PRICE)
				end
				return nil
			end)

			if ok then
				num = tonumber(result)
			end

			if num and num <= 0 then
				num = nil
			end
		end

		skullHubGPOKaitun.spResetTick = function()
			if not skullHubGPOKaitun.spResetDone and tbl5.ownsItem(tbl18.SPRESET) then
				fn87("already in the inventory")
			end

			skullHubGPOKaitun.spResetNotify()
			local stock = tbl5.merch.stock
			local flag2 = type(stock) == "table" and stock[tbl18.SPRESET] or nil
			flag2 = flag2 and tonumber(flag2.price)

			if flag2 and flag2 > 0 and flag2 ~= num then
				num = flag2

				if tbl.writefile then
					pcall(writefile, tbl18.SPRESET_PRICE, tostring(flag2))
				end

				skullHubGPOKaitun.note(("%s costs %d Peli - trips are gated on having that much from now on."):format(tbl18.SPRESET, flag2))
			end

			local spResetSig = num == nil or tbl5.peli() >= num
			spResetSig = not skullHubGPOKaitun.spResetDone and spResetSig

			if spResetSig and skullHubGPOKaitun.spResetSig then
				local note = tbl5.merch.note

				if note and note ~= skullHubGPOKaitun.merchWhy then
					skullHubGPOKaitun.merchWhy = note
					skullHubGPOKaitun.note("Merchant: " .. tostring(note))
				elseif not note then
					skullHubGPOKaitun.merchWhy = nil
				end
			end

			if skullHubGPOKaitun.spResetSig == spResetSig then
				return
			end
			skullHubGPOKaitun.spResetSig = spResetSig

			if spResetSig then
				tbl4.merchWant = { [tbl18.SPRESET] = true }

				if tbl4.merchRange < 15000 then
					fn85("GPOMerchRange", 15000)
				end

				if not tbl4.merchOn then
					fn85("GPOMerchOn", true)
				end

				skullHubGPOKaitun.note(("Auto Merchant on - buying one %s and nothing else (%s)."):format(tbl18.SPRESET, num and ("%d Peli, and we have %d"):format(num, tbl5.peli()) or "price unknown until the first shop opens"))
			else
				tbl4.merchWant = {}

				if tbl4.merchOn then
					fn85("GPOMerchOn", false)
				end

				if not skullHubGPOKaitun.spResetDone then
					skullHubGPOKaitun.note(("Auto Merchant off - %s costs %d Peli and we have %d. It comes back on once the farm has earned it."):format(tbl18.SPRESET, num or 0, tbl5.peli()))
				end
			end
		end

		local tbl19 = { level = true, peli_geppo = true, geppo = true, stats_buso = true, peli_buso = true, buso = true }

		local tbl20 = {
			read = "reading your stats",
			rowboat = "buy a Rowboat",
			level = "level to the cap",
			peli_geppo = "farm Peli for Geppo",
			geppo = "learn Geppo from Yi",
			stats_buso = "raise Strength before Buso",
			peli_buso = "farm Peli for Buso",
			buso = "Buso Haki (Ray)",
			puff = "Gatekeeper Puff (the World Scroll)",
			fish = "AFK fishing at Shell's Town",
		}

		skullHubGPOKaitun.puffDue = function()
			if skullHubGPOKaitun.puffDone then
				return false
			end

			if skullHubGPOKaitun.fp.busy and skullHubGPOKaitun.fp.phase == "puff" then
				return true
			end
			local sea = tbl5.sea
			if not (sea and sea.quest and sea.hasScroll and sea.gateOpen) then
				return false
			end

			if tbl5.whichSea() ~= 1 then
				return false
			end
			local puffLevel = tbl18.PUFF_LEVEL
			if fn43() < puffLevel then
				return false
			end

			if (skullHubGPOKaitun.fp.puffTries or 0) >= tbl18.PUFF_TRIES then
				return false
			end

			if sea.hasScroll() and sea.gateOpen() == true then
				return false
			end
			return true
		end

		skullHubGPOKaitun.fpPhase = function()
			if fn43() < tbl5.maxLevel() then
				return "level"
			end

			if tbl5.rowboatDue() then
				return "rowboat"
			end
			local v8 = tbl5.geppoOwned()
			local v9 = tbl5.busoLearned()
			if v8 == nil or v9 == nil then
				return "read"
			end

			if not v8 and tbl5.geppo.tries < tbl5.GEPPO.TRIES then
				local price = tbl5.GEPPO.PRICE
				if tbl5.peli() < price then
					return "peli_geppo"
				end
				return "geppo"
			end

			if not v9 then
				if skullHubGPOKaitun.busoHalt or tbl5.buso.halted then
					if skullHubGPOKaitun.puffDue() then
						return "puff"
					end
					return "fish"
				end

				local quest2 = tbl5.BUSO.QUEST

				if not (fn44() == quest2) then
					local Strength = fn86("Strength") or 0
					local SkillPoints = fn86("SkillPoints") or 0
					if Strength < n13 and SkillPoints > 0 then
						return "stats_buso"
					end
					local price = tbl5.BUSO.PRICE
					if tbl5.peli() < price then
						return "peli_buso"
					end
				end

				return "buso"
			end

			if skullHubGPOKaitun.puffDue() then
				return "puff"
			end
			return "fish"
		end

		skullHubGPOKaitun.fpApply = function(arg)
			if arg == "read" then
				return
			end
			local fish = tbl5.fish

			if tbl19[arg] then
				tbl4.maxLevelFarm = arg ~= "level"
				local flag2 = arg == "peli_geppo" or arg == "geppo"

				if tbl4.geppoOn ~= flag2 then
					fn85("GPOGeppoOn", flag2)
				end

				local str = "Level (auto)"

				if arg == "buso" then
					str = tbl5.BUSO.MODE
				end

				if tbl4.mode ~= str then
					fn85("GPOFarmMode", str)
				end

				fish = fish and fish.on

				if fish then
					fn85("GPOAutoFish", false)
				end

				return
			end

			tbl4.maxLevelFarm = false

			if tbl4.geppoOn then
				fn85("GPOGeppoOn", false)
			end

			if (arg == "rowboat" or arg == "puff") and fish and fish.on then
				fn85("GPOAutoFish", false)
			end
		end

		skullHubGPOKaitun.fpWhere = function(arg)
			local v8 = fn43()
			local v9 = tbl5.maxLevel()
			local v10 = tbl5.peli()

			if arg == "level" then
				if tbl5.level.stage == "peli" and tbl4.rowboatGate and not tbl5.onFishman() and (skullHubGPOKaitun.method ~= "Rifle" or tbl5.hasGun()) then
					return ("Level %d/%d - Peli for the Rowboat %d/%d"):format(v8, v9, v10, tbl5.rowboatPrice() or 0)
				end

				if tbl5.level.stage == "rowboat" then
					return ("Level %d/%d - Rowboat: %s"):format(v8, v9, tostring(tbl5.rowboat.status))
				end
				return ("Level %d/%d - %s"):format(v8, v9, fn44())
			end

			if arg == "peli_geppo" then
				return ("Max level - Becky for Geppo Peli %d/%d"):format(v10, tbl5.GEPPO.PRICE)
			end

			if arg == "geppo" then
				return "Geppo: " .. tostring(tbl5.geppo.status)
			end

			if arg == "stats_buso" then
				return ("Max level - Strength %d/%d before Buso"):format(fn86("Strength") or 0, 600)
			end

			if arg == "peli_buso" then
				return ("Max level - Becky for Buso Peli %d/%d"):format(v10, tbl5.BUSO.PRICE)
			end

			if arg == "buso" then
				local quest2 = tbl5.BUSO.QUEST
				if fn44() == quest2 then
					return ("Buso: Yeti %d"):format(fn45())
				end

				if not tbl5.checkpointSet() and tbl5.checkpoint.tries < tbl5.CHECKPOINT.TRIES and tbl4.setSpawn then
					return "Buso: checkpoint - " .. tostring(tbl5.checkpoint.status)
				end
				return "Buso: going to Ray"
			end

			if arg == "puff" then
				local sea = tbl5.sea
				return "Puff: " .. tostring(sea and sea.state and sea.state.status or "working")
			end
			return tbl20[arg] or tostring(arg)
		end

		skullHubGPOKaitun.fpRows = function(arg)
			local tbl21 = {}

			local function fn88(arg2, arg3, arg4)
				tbl21[#tbl21 + 1] = { name = arg2, note = arg3, state = arg4 }
			end

			local v8 = fn43()
			local v9 = tbl5.maxLevel()
			local v10 = tbl5.peli()

			if skullHubGPOKaitun.full then
				fn88("Plan", tbl20[arg] or tostring(arg), nil)
			end

			if v9 <= v8 then
				fn88("Level", ("%d / %d"):format(v8, v9), "done")
			else
				fn88("Level", ("%d / %d"):format(v8, v9), "part")
			end

			if skullHubGPOKaitun.full then
				local v11 = tbl5.rowboatOwned()

				if v11 then
					fn88("Rowboat", "owned", "done")
				elseif v11 == nil or tbl5.rowboatPrice() == nil then
					fn88("Rowboat", "?", "todo")
				elseif tbl5.ROWBOAT.TRIES <= tbl5.rowboat.tries then
					fn88("Rowboat", "gave up this session", "todo")
				else
					fn88("Rowboat", ("%d Peli - not owned"):format(tbl5.rowboatPrice() or 0), "todo")
				end
			end

			local GunMastery = fn86("GunMastery") or 0
			local Strength = fn86("Strength") or 0
			local Defense = fn86("Defense") or 0

			if skullHubGPOKaitun.method == "Rifle" then
				if n12 <= GunMastery then
					fn88("Gun Mastery", ("%d / %d"):format(GunMastery, 400), "done")
				else
					fn88("Gun Mastery", ("%d / %d"):format(GunMastery, 400), "part")
				end
			end

			if Strength >= n13 then
				fn88("Strength (melee)", ("%d / %d"):format(Strength, 600), "done")
			else
				fn88("Strength (melee)", ("%d / %d"):format(Strength, 600), "part")
			end

			if Strength >= n13 and (skullHubGPOKaitun.method ~= "Rifle" or GunMastery >= n12) then
				if n14 <= Defense then
					fn88("Defense", ("%d / %d"):format(Defense, 500), "done")
				else
					fn88("Defense", ("%d / %d"):format(Defense, 500), "part")
				end
			end

			local v11 = tbl5.geppoOwned()

			if v11 then
				fn88("Geppo (Sky Walk)", "learned", "done")
			elseif v11 == nil then
				fn88("Geppo (Sky Walk)", "?", "todo")
			else
				fn88("Geppo (Sky Walk)", ("Peli %d / %d"):format(v10, tbl5.GEPPO.PRICE), "todo")
			end

			local v12 = tbl5.busoLearned()

			if v12 then
				fn88("Buso Haki", "learned", "done")
			elseif v12 == nil then
				fn88("Buso Haki", "?", "todo")
			elseif skullHubGPOKaitun.busoHalt or tbl5.buso.halted then
				fn88("Buso Haki", "HALTED", "todo")
			else
				local quest2 = tbl5.BUSO.QUEST

				if fn44() == quest2 then
					fn88("Buso Haki", ("Yeti %d"):format(fn45()), "part")
				else
					fn88("Buso Haki", "not learned", "todo")
				end
			end

			if skullHubGPOKaitun.full and tbl5.sea and tbl5.sea.hasScroll then
				local sea = tbl5.sea
				local v13 = sea.hasScroll()

				if skullHubGPOKaitun.puffDone or v13 and sea.gateOpen() == true then
					fn88("World Scroll (Puff)", "done", "done")
				elseif tbl18.PUFF_TRIES <= (skullHubGPOKaitun.fp.puffTries or 0) then
					fn88("World Scroll (Puff)", "gave up this session", "todo")
				elseif v13 then
					fn88("World Scroll (Puff)", "scroll in hand - the gate is next", "part")
				else
					fn88("World Scroll (Puff)", "not picked up", "todo")
				end
			end

			if skullHubGPOKaitun.full then
				if skullHubGPOKaitun.spResetDone then
					local str = ""

					if skullHubGPOKaitun.webhook ~= "" then
						if skullHubGPOKaitun.spResetWHSent then
							str = " - webhook sent"
						else
							str = " - webhook pending"
						end
					end

					fn88("SP Reset Essence", "acquired" .. str, "done")
				elseif num and v10 < num then
					fn88("SP Reset Essence", ("saving Peli %d / %d"):format(v10, num), "todo")
				elseif tbl5.merchBusy() or tbl5.merch.home then
					fn88("SP Reset Essence", "merchant errand - " .. tostring(tbl5.merch.status or "..."), "part")
				else
					local v13 = tbl5.merchAt()
					local str = ""

					if num then
						str = (" (%d Peli)"):format(num)
					end

					if not v13 then
						fn88("SP Reset Essence", "waiting for the merchant" .. str, "todo")
					else
						local v14, v15 = tbl5.merchReachable(v13)
						local str2 = tbl5.islandAt(v13) or "the sea"
						local flag2 = tbl5.merch.visitAt and (tbl5.merch.visitAt - v13).Magnitude < 5

						if flag2 then
							flag2 = (tbl5.merch.tries or 0) >= tbl5.merch.maxTries
						end

						local flag3 = tbl5.merch.lastVisit and (tbl5.merch.lastVisit - v13).Magnitude < 5

						if not v14 then
							fn88("SP Reset Essence", "skipping him - " .. tostring(v15), "todo")
						elseif flag2 or flag3 then
							fn88("SP Reset Essence", ("visited him on %s - %s"):format(str2, tostring(tbl5.merch.note or "not bought this visit")), "todo")
						elseif tbl5.merchDue() then
							fn88("SP Reset Essence", ("merchant on %s%s - going to him"):format(str2, str), "part")
						else
							local v16 = tbl5.merchGapTo(v13)

							if v16 and v16 > tbl4.merchRange then
								fn88("SP Reset Essence", ("merchant on %s - %d studs, over the %d limit"):format(str2, v16, tbl4.merchRange), "todo")
							else
								fn88("SP Reset Essence", ("merchant on %s - not due yet"):format(str2), "todo")
							end
						end
					end
				end
			end

			if v12 == false and tbl4.setSpawn then
				local v13 = tbl5.currentSpawn()

				if tbl5.checkpointSet() then
					fn88("Spawn checkpoint", tostring(v13), "done")
				elseif tbl5.CHECKPOINT.TRIES <= tbl5.checkpoint.tries then
					fn88("Spawn checkpoint", "gave up - " .. tostring(v13 or "unset"), "todo")
				else
					fn88("Spawn checkpoint", tostring(tbl5.checkpoint.status), "part")
				end
			end

			local fish = tbl5.fish
			local bestRod

			if fish then
				local rodShown = fish.rodShown and fish.rodShown()

				if rodShown then
					bestRod = rodShown
				else
					bestRod = fish.bestRod and fish.bestRod()
				end
			else
				bestRod = fish
			end

			if bestRod then
				fn88("Fishing Rod", tostring(bestRod), "done")
			else
				fn88("Fishing Rod", "not owned", "todo")
			end

			if fish and fish.on then
				fn88("Auto Fish", "running", "done")
			else
				fn88("Auto Fish", "off", "todo")
			end

			return tbl21
		end

		skullHubGPOKaitun.resRowsBuild = function()
			local tbl21 = {}

			local function fn88(arg, arg2)
				tbl21[#tbl21 + 1] = { name = arg, note = arg2 }
			end

			fn88("Peli", tostring(tbl5.peli()))
			fn88("Skill points", tostring(fn86("SkillPoints") or 0))
			fn88("Strength", tostring(fn86("Strength") or 0))
			fn88("Gun Mastery", tostring(fn86("GunMastery") or 0))
			fn88("Defense", tostring(fn86("Defense") or 0))
			fn88("Sword Mastery", tostring(fn86("SwordMastery") or 0))
			fn88("Buso Mastery", tostring(fn86("BusoMastery") or 0))
			local fish = tbl5.fish

			if fish and fish.baitCount then
				fn88("Common Fish Bait", tostring(fish.baitCount("Common Fish Bait")))
				fn88("Rare Fish Bait", tostring(fish.baitCount("Rare Fish Bait")))
				fn88("Legendary Fish Bait", tostring(fish.baitCount("Legendary Fish Bait")))
				fn88("Casts / caught / sold", ("%d / %d / %d"):format(fish.casts or 0, fish.caught or 0, fish.sold or 0))
			end

			fn88("Quest", fn44())
			return tbl21
		end

		skullHubGPOKaitun.fishSetup = function()
			local fish = tbl5.fish
			if not fish then
				skullHubGPOKaitun.note("The fishing section did not build - cannot fish.")
				return false
			end

			local function fn88()
				return tbl8.flagged or skullHubGPOKaitun.fp.phase ~= "fish"
			end

			local function fn89()
				local character = localPlayer.Character
				local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
				return humanoidRootPart and humanoidRootPart.Position
			end

			if tbl4.on then
				fn85("GPOFarmToggle", false)
			end

			local now = os.clock()

			while tbl4.thread and os.clock() - now < 30 do
				task.wait(0.5)
			end

			if tbl4.thread then
				skullHubGPOKaitun.fp.setup = "waiting for the farm loop to stop"
				return false
			end

			if not fish.bestRod() then
				local rodNextAt = skullHubGPOKaitun.fp.rodNextAt
				if os.clock() < rodNextAt then
					skullHubGPOKaitun.fp.setup = "rod purchase backing off"
					return false
				end
				local v8 = fn89()
				if not v8 then
					return false
				end

				if (tbl18.STAND - v8).Magnitude > 12 then
					skullHubGPOKaitun.fp.setup = "travelling to the Shell's Town rod stand"
					fn36(tbl18.STAND + Vector3.new(0, 3, 0), 8, fn88)
					if fn88() then
						return false
					end
				end

				local v9, v10, v11 = tbl5.shopModel("Fishing Rod")
				local events = v6:FindFirstChild("Events")
				events = events and events:FindFirstChild("Shop")
				skullHubGPOKaitun.fp.rodTries = skullHubGPOKaitun.fp.rodTries + 1
				local n15 = math.min(30 * skullHubGPOKaitun.fp.rodTries, 300)

				if not (v9 and events) or v11 and v11 > n11 then
					skullHubGPOKaitun.fp.rodNextAt = os.clock() + n15
					skullHubGPOKaitun.note(("Rod stand not in reach (%s) - retrying in %ds."):format(v11 and math.floor(v11) .. " studs" or "not streamed", n15))
					return false
				end

				local info = (v9 or v10):FindFirstChild("Info")
				info = info and info:FindFirstChild("Price")
				info = info and tonumber(info.Value) or 50

				if tbl5.peli() < info then
					skullHubGPOKaitun.fp.rodNextAt = os.clock() + n15
					skullHubGPOKaitun.note(("Not enough Peli for a Fishing Rod (%d/%d)."):format(tbl5.peli(), info))
					return false
				end

				skullHubGPOKaitun.fp.setup = "buying a Fishing Rod"

				local ok, result = pcall(function()
					return events:InvokeServer(v9, 1)
				end)

				local now2 = os.clock()

				while true do
					task.wait(0.5)
					if not (fish.bestRod() or os.clock() - now2 > 6) then
						continue
					end
					break
				end

				if not fish.bestRod() then
					skullHubGPOKaitun.fp.rodNextAt = os.clock() + n15
					skullHubGPOKaitun.note(("The Fishing Rod purchase did not land (%s) - retrying in %ds."):format(ok and tostring(result) or "remote threw", n15))
					return false
				end

				skullHubGPOKaitun.note(("Bought a Fishing Rod for %d Peli."):format(info))
			end

			fn85("GPOFishReelMode", "Instant")
			fn85("GPOFishHuman", true)
			fn85("GPOFishCraft", false)
			fn85("GPOFishBait", "Best")
			fn85("GPOFishBaitFloor", 20)
			fn85("GPOFishBuyAmount", 50)
			fn85("GPOFishBuy", true)

			if not fish.spot then
				fn85("GPOFishSpot", tbl18.SPOT)
			end

			if not fish.bob then
				fn85("GPOFishBob", tbl18.BOB)
			end

			local v8 = fn89()
			if not v8 then
				return false
			end

			if (tbl18.SPOT_POS - v8).Magnitude > 30 then
				skullHubGPOKaitun.fp.setup = "travelling to the fishing spot"
				fn36(tbl18.SPOT_POS + Vector3.new(0, 3, 0), 8, fn88)
				if fn88() then
					return false
				end
			end

			local setSpawn = tbl4.setSpawn

			if setSpawn then
				local spawnIsland = tbl18.SPAWN_ISLAND
				setSpawn = tbl5.currentSpawn() ~= spawnIsland
			end

			local flag2

			if setSpawn then
				flag2 = (skullHubGPOKaitun.fp.fishSpawnTries or 0) < 3
			else
				flag2 = setSpawn
			end

			if flag2 then
				skullHubGPOKaitun.fp.fishSpawnTries = (skullHubGPOKaitun.fp.fishSpawnTries or 0) + 1
				skullHubGPOKaitun.fp.setup = "setting the spawn point at Shell's Town"
				pcall(tbl5.setSpawnHere, fn88)
				if fn88() then
					return false
				end
				local spawnIsland = tbl18.SPAWN_ISLAND

				if tbl5.currentSpawn() == spawnIsland then
					skullHubGPOKaitun.note("Spawn point set to Shell's Town.")

					if skullHubGPOKaitun.milestone then
						skullHubGPOKaitun.milestone("Checkpoint", "Spawn point set to **Shell's Town** for the fishing phase.")
					end
				else
					skullHubGPOKaitun.note(("Could not set the spawn at Shell's Town (try %d/3) - fishing anyway."):format(skullHubGPOKaitun.fp.fishSpawnTries))
				end
			end

			skullHubGPOKaitun.fp.setup = "starting Auto Fish"
			fn85("GPOAutoFish", true)
			if fish.on then
				skullHubGPOKaitun.note("Auto Fish is running at Shell's Town.")
				return true
			end
			return false
		end

		skullHubGPOKaitun.fpTick = function()
			local flag2 = not skullHubGPOKaitun.booted
			local flag3

			if flag2 then
				local started = skullHubGPOKaitun.started
				flag3 = os.clock() - started < 90
			else
				flag3 = flag2
			end

			if flag3 then
				return
			end

			if tbl5.whichSea() ~= 1 then
				skullHubGPOKaitun.where = "WRONG SEA - Full Progression runs in the First Sea"
				skullHubGPOKaitun.status = "Idle"

				if tbl4.on then
					fn85("GPOFarmToggle", false)
				end

				if tbl5.fish and tbl5.fish.on then
					fn85("GPOAutoFish", false)
				end

				return
			end

			skullHubGPOKaitun.spResetTick()
			local buso = tbl5.buso
			local flag4 = buso.halted and buso.paid and not skullHubGPOKaitun.busoHalt

			if flag4 then
				local quest2 = tbl5.BUSO.QUEST
				flag4 = fn44() ~= quest2
			end

			if flag4 then
				skullHubGPOKaitun.busoHalt = true

				if tbl.writefile then
					pcall(writefile, tbl18.BUSO_LATCH, tostring(buso.halted))
				end

				skullHubGPOKaitun.note("Buso quest ended without Haki - not paying again. Delete " .. tbl18.BUSO_LATCH .. " from the executor workspace to retry.")

				if skullHubGPOKaitun.milestone then
					skullHubGPOKaitun.milestone("Buso Haki - stopped", tostring(buso.halted))
				end
			end

			local v8 = skullHubGPOKaitun.fpPhase()
			local seen = skullHubGPOKaitun.fp.seen

			if not seen and v8 ~= "read" then
				seen = {
					max = fn43() >= tbl5.maxLevel(),
					geppo = tbl5.geppoOwned() == true,
					buso = tbl5.busoLearned() == true,
					fish = false,
				}

				skullHubGPOKaitun.fp.seen = seen
			end

			if seen and skullHubGPOKaitun.milestone then
				if not seen.max and fn43() >= tbl5.maxLevel() then
					seen.max = true
					skullHubGPOKaitun.milestone("Max level", ("Reached level %d - Geppo and Buso next."):format(fn43()))
				end

				if not seen.geppo and tbl5.geppoOwned() == true then
					seen.geppo = true
					skullHubGPOKaitun.milestone("Geppo", "Learned **Sky Walk (Geppo)** from Yi.")
				end

				if not seen.buso and tbl5.busoLearned() == true then
					seen.buso = true
					skullHubGPOKaitun.milestone("Buso Haki", "Learned **Busoshoku Haki** from Ray.")
				end
			end

			if v8 ~= skullHubGPOKaitun.fp.phase then
				skullHubGPOKaitun.fp.phase = v8
				skullHubGPOKaitun.note("Plan: " .. tostring(tbl20[v8] or v8) .. ".")
			end

			skullHubGPOKaitun.fpApply(v8)
			skullHubGPOKaitun.progRows = skullHubGPOKaitun.fpRows(v8)
			if v8 == "read" then
				skullHubGPOKaitun.where = "Reading your stats..."
				return
			end
			local v9 = tbl5.peli()
			local home = tbl5.merchBusy() or tbl5.merch.home
			local where = nil

			if home then
				where = "Merchant errand - " .. tostring(tbl5.merch.status or "...")
			end

			if tbl19[v8] then
				skullHubGPOKaitun.detail = ("Peli %d  |  STR %d  GUN %d  |  SP %d"):format(v9, fn86("Strength") or 0, fn86("GunMastery") or 0, fn86("SkillPoints") or 0)
				local v10, v11 = tbl5.seaOK(tbl4.mode)

				if not v10 then
					skullHubGPOKaitun.where = "WRONG SEA - " .. tostring(v11)

					if tbl4.on then
						fn85("GPOFarmToggle", false)
					end

					return
				end

				local v12 = skullHubGPOKaitun
				where = where or skullHubGPOKaitun.fpWhere(v8)
				v12.where = where
				skullHubGPOKaitun.status = tostring(tbl4.status)
				local flag5 = not tbl4.on

				if flag5 then
					flag5 = not (tbl5.fish and tbl5.fish.on)
				end

				if flag5 then
					skullHubGPOKaitun.note("Farm is off - starting it.")
					fn85("GPOFarmToggle", true)
				end

				return
			end

			if v8 == "rowboat" then
				skullHubGPOKaitun.detail = ("Peli %d  |  Rowboat tries %d/%d"):format(v9, tbl5.rowboat.tries, tbl5.ROWBOAT.TRIES)
				skullHubGPOKaitun.where = "Rowboat: " .. tostring(tbl5.rowboat.status)
				skullHubGPOKaitun.status = tostring(tbl4.status)
				if skullHubGPOKaitun.fp.busy then
					return
				end
				skullHubGPOKaitun.fp.busy = true

				fn5("KaitunRowboat", function()
					local ok, result = pcall(function()
						if tbl4.on then
							fn85("GPOFarmToggle", false)
						end

						local now = os.clock()

						while tbl4.thread and os.clock() - now < 30 do
							task.wait(0.5)
						end

						if tbl4.thread then
							return
						end

						if tbl5.fish and tbl5.fish.on then
							fn85("GPOAutoFish", false)
						end

						if tbl5.buyRowboat(function()
							return tbl8.flagged or skullHubGPOKaitun.fp.phase ~= "rowboat"
						end) then
							skullHubGPOKaitun.note("Bought a Rowboat.")

							if skullHubGPOKaitun.milestone then
								skullHubGPOKaitun.milestone("Rowboat", "Bought a **Rowboat** in Town of Beginnings.")
							end
						end
					end)

					if not ok then
						skullHubGPOKaitun.note("Rowboat job errored: " .. fn2(result))
					end

					skullHubGPOKaitun.fp.busy = false
				end)

				return
			end

			if v8 == "puff" then
				local sea = tbl5.sea
				skullHubGPOKaitun.detail = ("Peli %d  |  Puff tries %d/%d"):format(v9, skullHubGPOKaitun.fp.puffTries or 0, tbl18.PUFF_TRIES)
				skullHubGPOKaitun.where = skullHubGPOKaitun.fpWhere(v8)
				skullHubGPOKaitun.status = tostring(tbl4.status)
				if skullHubGPOKaitun.fp.busy then
					return
				end

				if os.clock() < (skullHubGPOKaitun.fp.puffNextAt or 0) then
					skullHubGPOKaitun.where = ("World Scroll errand backing off - retrying in %ds (try %d/%d)"):format(math.floor(skullHubGPOKaitun.fp.puffNextAt - os.clock()), skullHubGPOKaitun.fp.puffTries or 0, tbl18.PUFF_TRIES)
					return
				end

				if sea.state and sea.state.on then
					skullHubGPOKaitun.where = "Waiting for the Movement tab's Second Sea trip to finish"
					return
				end
				skullHubGPOKaitun.fp.busy = true

				fn5("KaitunPuff", function()
					local ok, result = pcall(function()
						if sea.state then
							sea.state.status = "Waiting for the farm to let go of the mover"
						end

						if tbl4.on then
							fn85("GPOFarmToggle", false)
						end

						local now = os.clock()

						while tbl4.thread and os.clock() - now < 30 do
							task.wait(0.5)
						end

						if tbl4.thread then
							return
						end

						if tbl5.fish and tbl5.fish.on then
							fn85("GPOAutoFish", false)
						end

						local function fn88()
							return tbl8.flagged or skullHubGPOKaitun.fp.phase ~= "puff"
						end

						if sea.quest(fn88) then
							skullHubGPOKaitun.puffDone = true

							if tbl.writefile then
								pcall(writefile, tbl18.PUFF_LATCH, os.date("!%Y-%m-%dT%H:%M:%SZ"))
							end

							skullHubGPOKaitun.note("Gatekeeper Puff done - World Scroll in hand and the gate is open.")

							if skullHubGPOKaitun.milestone then
								skullHubGPOKaitun.milestone("Gatekeeper Puff", "Picked up the **World Scroll** and opened the Reverse Mountain gate. Staying in the First Sea.")
							end
						elseif not fn88() or sea.state and sea.state.timedOut then
							skullHubGPOKaitun.fp.puffTries = (skullHubGPOKaitun.fp.puffTries or 0) + 1
							local puffRetry = tbl18.PUFF_RETRY
							skullHubGPOKaitun.fp.puffNextAt = os.clock() + puffRetry
							skullHubGPOKaitun.note(("Puff errand stopped (%s) - try %d/%d, next in %ds."):format(tostring(sea.state and sea.state.status), skullHubGPOKaitun.fp.puffTries, tbl18.PUFF_TRIES, tbl18.PUFF_RETRY))
						end
					end)

					if not ok then
						skullHubGPOKaitun.note("Puff job errored: " .. fn2(result))
					end

					skullHubGPOKaitun.fp.busy = false
				end)

				return
			end

			local fish = tbl5.fish

			if fish then
				skullHubGPOKaitun.detail = ("Casts %d  caught %d  sold %d  |  Peli %d"):format(fish.casts or 0, fish.caught or 0, fish.sold or 0, v9)
			end

			if skullHubGPOKaitun.fp.busy then
				skullHubGPOKaitun.where = "Setting up fishing - " .. tostring(skullHubGPOKaitun.fp.setup or "...")
				skullHubGPOKaitun.status = tostring(tbl4.status)
				return
			end

			if fish and fish.on then
				skullHubGPOKaitun.where = where or "AFK fishing at Shell's Town"
				skullHubGPOKaitun.status = tostring(fish.status)

				if seen and not seen.fish then
					seen.fish = true

					if skullHubGPOKaitun.milestone then
						skullHubGPOKaitun.milestone("Fishing", "Rod and bait sorted - AFK fishing at Shell's Town.")
					end
				end

				return
			end

			if os.clock() < (skullHubGPOKaitun.fp.fishNextAt or 0) then
				skullHubGPOKaitun.where = ("Fishing stopped (%s) - retrying in %ds"):format(fish and tostring(fish.status) or "?", math.floor(skullHubGPOKaitun.fp.fishNextAt - os.clock()))
				return
			end
			skullHubGPOKaitun.fp.busy = true
			skullHubGPOKaitun.fp.fishNextAt = os.clock() + 60
			skullHubGPOKaitun.fp.setup = "starting"

			fn5("KaitunFishSetup", function()
				local ok, result = pcall(skullHubGPOKaitun.fishSetup)

				if not ok then
					skullHubGPOKaitun.note("Fishing setup errored: " .. fn2(result))
				end

				skullHubGPOKaitun.fp.busy = false
			end)
		end

		local function fn88()
			local codes = skullHubGPOKaitun.codes or {}
			if #codes == 0 then
				return
			end
			local events = v6:FindFirstChild("Events")
			local redeemCode = events and events:FindFirstChild("RedeemCode")
			if not (redeemCode and redeemCode:IsA("RemoteFunction")) then
				skullHubGPOKaitun.note("Auto Redeem Codes: ReplicatedStorage.Events.RedeemCode is not there - skipped.")
				return
			end

			local function fn89()
				local tbl21 = {}
				local codes2 = fn42()
				codes2 = codes2 and codes2:FindFirstChild("Codes")
				local used = codes2 and codes2:FindFirstChild("Used")

				if used and type(used.Value) == "string" and used.Value ~= "" then
					local ok, result = pcall(function()
						return game:GetService("HttpService"):JSONDecode(used.Value)
					end)

					if ok and type(result) == "table" then
						for k, v8 in pairs(result) do
							local flag2 = type(v8) == "string" and v8 or type(k) == "string" and k or nil

							if flag2 then
								tbl21[flag2:lower()] = true
							end
						end
					end
				end

				return tbl21
			end

			local v8 = fn89()
			local n15 = 0
			local n16 = 0
			local n17 = 0

			for _, code in ipairs(codes) do
				if v8[code:lower()] then
					n15 += 1
					skullHubGPOKaitun.note(("Code \"%s\" is already on this account - skipped."):format(code))
				else
					n16 += 1

					local ok, result = pcall(function()
						return redeemCode:InvokeServer(code)
					end)

					if not ok then
						skullHubGPOKaitun.note(("Code \"%s\" errored on send: %s"):format(code, fn2(result)))
					else
						task.wait(1.5)

						if fn89()[code:lower()] then
							n17 += 1
							skullHubGPOKaitun.note(("Code \"%s\" redeemed."):format(code))

							if skullHubGPOKaitun.milestone then
								skullHubGPOKaitun.milestone("Code redeemed", ("**%s**"):format(code))
							end
						else
							skullHubGPOKaitun.note(("Code \"%s\" sent; the account's redeemed list did not change (expired, or the server does not record this kind). Server said: %s. Not retried."):format(code, fn2(result)))
						end
					end

					task.wait(3)
				end
			end

			skullHubGPOKaitun.note(("Auto Redeem Codes: %d sent (%d confirmed), %d already used."):format(n16, n17, n15))
		end

		fn5("KaitunBoot", function()
			skullHubGPOKaitun.status = "Applying config"
			skullHubGPOKaitun.note(("Kaitun: %s / %s"):format(skullHubGPOKaitun.mode, skullHubGPOKaitun.method))
			local reservedCode = v6:FindFirstChild("reservedCode")

			if reservedCode and type(reservedCode.Value) == "string" and reservedCode.Value ~= "" then
				skullHubGPOKaitun.psCode = reservedCode.Value
				skullHubGPOKaitun.note("In private server " .. reservedCode.Value .. ".")
			else
				skullHubGPOKaitun.note("In a public server (no private-server code on this instance).")
			end

			skullHubGPOKaitun.queueSelf()

			fn5("KaitunRedeem", function()
				local ok, result = pcall(fn88)

				if not ok then
					skullHubGPOKaitun.note("Auto Redeem Codes errored: " .. fn2(result))
				end
			end)

			fn85("GPOAutoTitle", true)
			fn85("GPOAutoTitlePick", "Best fishing title (auto)")
			fn85("GPOFPSCap", skullHubGPOKaitun.fpsCap)

			if skullHubGPOKaitun.boostFps then
				fn85("GPOBoostFPS", true)
			end

			if skullHubGPOKaitun.deleteMap then
				fn85("GPODeleteMap", true)
			end

			if skullHubGPOKaitun.blackScreen then
				fn85("GPOBlackScreen", true)
			end

			fn85("GPOStatBulk", true)
			skullHubGPOKaitun.statPolicy()

			if skullHubGPOKaitun.full then
				tbl4.rowboatGate = true
				tbl4.maxLevelFarm = false
			end

			fn85("GPOFarmMoveMode", skullHubGPOKaitun.move)
			fn85("GPOFarmSpeed", skullHubGPOKaitun.tween)
			fn85("GPOFarmMethod", skullHubGPOKaitun.method)
			fn85("GPOFarmMode", skullHubGPOKaitun.mode)

			if tbl2.why() then
				skullHubGPOKaitun.status = "BLOCKED - anti-cheat protection not installed"
			elseif skullHubGPOKaitun.full then
				skullHubGPOKaitun.status = "Deciding the plan"
			else
				skullHubGPOKaitun.status = "Starting the farm"
				fn85("GPOFarmToggle", true)
			end

			skullHubGPOKaitun.booted = true
		end)

		skullHubGPOKaitun.legacyTick = function()
			local v8 = fn43()
			local flag2 = skullHubGPOKaitun.mode == "Level (auto)" and v8 >= tbl5.maxLevel()
			local v9, v10 = tbl5.seaOK(skullHubGPOKaitun.mode)
			skullHubGPOKaitun.progRows = skullHubGPOKaitun.fpRows(skullHubGPOKaitun.mode)
			skullHubGPOKaitun.detail = ("Peli %d  |  STR %d  GUN %d  |  SP %d"):format(tbl5.peli(), fn86("Strength") or 0, fn86("GunMastery") or 0, fn86("SkillPoints") or 0)
			local flag3 = not v9

			if flag3 then
				skullHubGPOKaitun.where = "WRONG SEA - " .. v10
			elseif flag2 then
				skullHubGPOKaitun.where = ("Level %d/%d - max level"):format(v8, tbl5.maxLevel())
			elseif skullHubGPOKaitun.mode == "Boss: Juzo (Sea 2)" then
				skullHubGPOKaitun.where = ("Level %d - Juzo, %d killed"):format(v8, tbl5.juzo.kills)
			else
				skullHubGPOKaitun.where = ("Level %d/%d - %s"):format(v8, tbl5.maxLevel(), fn44())
			end

			skullHubGPOKaitun.status = tostring(tbl4.status)

			if flag3 then
				if tbl4.on then
					fn85("GPOFarmToggle", false)
				end

				if not skullHubGPOKaitun.seaSaid then
					skullHubGPOKaitun.seaSaid = true
					skullHubGPOKaitun.note("Config mode \"" .. tostring(skullHubGPOKaitun.mode) .. "\" cannot run in this place. " .. v10)
				end

				skullHubGPOKaitun.status = "Wrong sea for the configured mode - idle"
			elseif flag2 then
				if tbl4.on then
					fn85("GPOFarmToggle", false)
				end

				skullHubGPOKaitun.status = "Max level - idle"
			elseif not tbl4.on then
				skullHubGPOKaitun.seaSaid = nil
				skullHubGPOKaitun.note("Farm was off - restarting it.")
				fn85("GPOFarmToggle", true)
			end
		end

		fn5("KaitunSupervisor", function()
			local n15 = nil

			while true do
				task.wait(2)

				local ok, result = pcall(function()
					skullHubGPOKaitun.statPolicy()
					skullHubGPOKaitun.resRows = skullHubGPOKaitun.resRowsBuild()
					local rejoinAt = skullHubGPOKaitun.rejoinAt

					if rejoinAt then
						local rejoinAt2 = skullHubGPOKaitun.rejoinAt
						rejoinAt = os.clock() - rejoinAt2 < 30
					end

					if rejoinAt then
						return
					end
					local v8 = tbl2.why()

					if v8 then
						skullHubGPOKaitun.status = "BLOCKED - anti-cheat protection not installed"
						skullHubGPOKaitun.where = tostring(tbl2.failWhy or "the bypass did not finish")

						if not skullHubGPOKaitun.acSaid then
							skullHubGPOKaitun.acSaid = true
							skullHubGPOKaitun.note(v8)
						end

						return
					end

					if tbl8.flagged then
						skullHubGPOKaitun.where = "FLAGGED - rejoining the main menu"

						if not n15 then
							n15 = os.clock() + 5
							skullHubGPOKaitun.note("Server stopped tracking us - rejoining the main menu in 5s.")
						elseif n15 <= os.clock() then
							skullHubGPOKaitun.rejoinMenu("server stopped tracking us")
						end

						return
					end

					if skullHubGPOKaitun.full then
						skullHubGPOKaitun.fpTick()
					else
						skullHubGPOKaitun.legacyTick()
					end
				end)

				if not ok then
					skullHubGPOKaitun.status = "Supervisor error - retrying"
					skullHubGPOKaitun.note("Supervisor tick errored: " .. fn2(result))
					task.wait(3)
				end
			end
		end)
	end

	fn84()
end
