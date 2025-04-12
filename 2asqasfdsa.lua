_G.AutoCollect = false
_G.AutoSell = false
_G.ChoosenEgg = "Common Egg"
_G.AutoEgg = false
_G.Triple = false
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
	Name = "Flare Beta",
	Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
	LoadingTitle = "",
	LoadingSubtitle = "by lozkoo",
	Theme = "Amethyst", -- Check https://docs.sirius.menu/rayfield/configuration/themes

	DisableRayfieldPrompts = false,
	DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

	ConfigurationSaving = {
		Enabled = true,
		FolderName = nil, -- Create a custom folder for your hub/game
		FileName = "Flare"
	},

	Discord = {
		Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
		Invite = "5fTqqVnrws", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
		RememberJoins = true -- Set this to false to make them join the discord every time they load it up
	},

	KeySystem = true, -- Set this to true to use our key system
	KeySettings = {
		Title = "Get the Key!",
		Subtitle = "Key System",
		Note = "Get key from getflarekey.netlify.app/", -- Use this to tell the user how to get a key
		FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
		SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
		GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
		Key = {"fasdfdsew-3f9sedikgf9wek5t320dsf-sdfds"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
	}
})

local Tab = Window:CreateTab("Auto Collect", 121401017387099)
local Toggle = Tab:CreateToggle({
	Name = "Auto Collect Pickups (BETA) (OP)",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		_G.AutoCollect = not _G.AutoCollect
	end,
})
local TabEgg = Window:CreateTab("Eggs", 137826917687849)
local options = {
	 "Crystal Egg",
	 "Inferno Egg",
	 "Nightmare Egg",
	 "Spotted Egg",
	 "Aura Egg",
	 "Rainbow Egg",
	 "Hell Egg",
	"Void Egg",
	 "Lunar Egg",
	  "Spikey Egg",
	"Season 1 Egg",
	 "Magma Egg",
	"Iceshard Egg",
	"Common Egg"
}
 
local Dropdown = TabEgg:CreateDropdown({
	Name = "Choose Egg",
	Options = options,
	CurrentOption = {"Common Egg"},
	MultipleOptions = false,
	Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(cf) 
		_G.ChoosenEgg = cf[1]
	end,
})
local Toggle = TabEgg:CreateToggle({
	Name = "Auto Egg",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		_G.AutoEgg = not _G.AutoEgg
	end,
})

local Toggle = TabEgg:CreateToggle({
	Name = "Triple Egg on Auto (Gamepass probably required)",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		_G.Triple = not _G.Triple
	end,
})

local Tab2 = Window:CreateTab("Bubble", 139415836850114)
local Toggle = Tab2:CreateToggle({
	Name = "Auto Bubble",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		_G.AutoBubble = not _G.AutoBubble
	end,
})
local Toggle = Tab2:CreateToggle({
	Name = "Auto Sell",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		_G.AutoSell = not _G.AutoSell
	end,
})


 

task.spawn(function()
	while wait() do
		if _G.AutoBubble then
			local args = {
				[1] = "BlowBubble"
			}

			game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))

		end
		if _G.AutoSell then
			local args = {
				[1] = "SellBubble"
			}

			game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))

		end
		if _G.AutoEgg  then
			local args = {
				[1] = "HatchEgg",
				[2] = _G.ChoosenEgg or "Common Egg",
				[3] = _G.Triple and 3 or 1
			}

			game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))

		end
		if _G.AutoCollect then
			for _, v in pairs(game.Workspace.Rendered:GetChildren()) do
				if v.Name == "Chunker" then
					for _, e in pairs(v:GetChildren()) do

						if not string.find(e.Name, "Egg") then
							local args = {
								[1] = e.Name
							}
							game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pickups"):WaitForChild("CollectPickup"):FireServer(unpack(args))
							e:Destroy()
						end
					end
				end 
			end
		end
	end
end)