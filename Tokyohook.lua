-- New example script written by wally
-- You can suggest changes with a pull request or something

local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    -- Set Center to true if you want the menu to appear in the center
    -- Set AutoShow to true if you want the menu to appear when it is created
    -- Position and Size are also valid options here
    -- but you do not need to define them unless you are changing them :)

    Title = 'Project Delta | Made by $ Tokyo#9999',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

-- CALLBACK NOTE:
-- Passing in callback functions via the initial element parameters (i.e. Callback = function(Value)...) works
-- HOWEVER, using Toggles/Options.INDEX:OnChanged(function(Value) ... ) is the RECOMMENDED way to do this.
-- I strongly recommend decoupling UI code from logic code. i.e. Create your UI elements FIRST, and THEN setup :OnChanged functions later.

-- You do not have to set your tabs & groups up this way, just a prefrence.

local Tabs = {
    -- Creates a new tab titled Main
    Main = Window:AddTab('Main'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

-- Groupbox and Tabbox inherit the same functions
-- except Tabboxes you have to call the functions on a tab (Tabbox:AddTab(name))
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Groupbox')

-- We can also get our Main tab via the following code:
-- local LeftGroupBox = Window.Tabs.Main:AddLeftGroupbox('Groupbox')

-- Tabboxes are a tiny bit different, but here's a basic example:
--[[
local TabBox = Tabs.Main:AddLeftTabbox() -- Add Tabbox on left side
local Tab1 = TabBox:AddTab('Tab 1')
local Tab2 = TabBox:AddTab('Tab 2')
-- You can now call AddToggle, etc on the tabs you added to the Tabbox
]]

-- Groupbox:AddToggle
-- Arguments: Index, Options

LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Silent Aim',
    Default = true, -- Default value (true / false)
    Tooltip = 'Locks onto any player close to the mouse.', -- Information shown when you hover over the toggle

    Callback = function(Value)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fableoforigins/Tokyohook/main/Project%20Delta%20SILENT%20AIM%20%26%20PERFECT%20PREDICTION.txt"))()
    end
})

LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Hit Logs',
    Default = true, -- Default value (true / false)
    Tooltip = 'Shows the logs of your projectiles.', -- Information shown when you hover over the toggle

    Callback = function(Value)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fableoforigins/Tokyohook/main/Project%20Delta%20HITMARKERS.txt"))()
    end
})

LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Box Esp',
    Default = true, -- Default value (true / false)
    Tooltip = 'This esp is very buggy do not recommend.', -- Information shown when you hover over the toggle

    Callback = function(Value)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fableoforigins/Tokyohook/main/ROBLOX%203D%20BOX%20ESP%20-%20MARCH%202023.txt"))()
    end
})

LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Remove Jumpcooldown',
    Default = true, -- Default value (true / false)
    Tooltip = 'removes jump cool down.', -- Information shown when you hover over the toggle

    Callback = function(Value)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fableoforigins/Tokyohook/main/a%20bhop.txt"))()
    end
})

LeftGroupBox:AddToggle('MyToggle', {
    Text = 'No Recoil',
    Default = true, -- Default value (true / false)
    Tooltip = 'Makes every single gun have ZERO recoil.', -- Information shown when you hover over the toggle

    Callback = function(Value)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fableoforigins/Tokyohook/main/a%20norecoil.txt"))()
    end
})

LeftGroupBox:AddToggle('MyToggle', {
    Text = 'This is a toggle',
    Default = true, -- Default value (true / false)
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the toggle

    Callback = function(Value)
        print('[cb] MyToggle changed to:', Value)
    end
})

LeftGroupBox:AddToggle('MyToggle', {
    Text = 'This is a toggle',
    Default = true, -- Default value (true / false)
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the toggle

    Callback = function(Value)
        print('[cb] MyToggle changed to:', Value)
    end
})

LeftGroupBox:AddToggle('MyToggle', {
    Text = 'This is a toggle',
    Default = true, -- Default value (true / false)
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the toggle

    Callback = function(Value)
        print('[cb] MyToggle changed to:', Value)
    end
})

-- Fetching a toggle object for later use:
-- Toggles.MyToggle.Value

-- Toggles is a table added to getgenv() by the library
-- You index Toggles with the specified index, in this case it is 'MyToggle'
-- To get the state of the toggle you do toggle.Value

-- Calls the passed function when the toggle is updated
Toggles.MyToggle:OnChanged(function()
    -- here we get our toggle object & then get its value
    print('MyToggle changed to:', Toggles.MyToggle.Value)
end)

-- This should print to the console: "My toggle state changed! New value: false"
Toggles.MyToggle:SetValue(false)

-- 1/15/23
-- Deprecated old way of creating buttons in favor of using a table
-- Added DoubleClick button functionality

--[[
    Groupbox:AddButton
    Arguments: {
        Text = string,
        Func = function,
        DoubleClick = boolean
        Tooltip = string,
    }
    You can call :AddButton on a button to add a SubButton!
]]

--[[
    NOTE: You can chain the button methods!
    EXAMPLE:
    LeftGroupBox:AddButton({ Text = 'Kill all', Func = Functions.KillAll, Tooltip = 'This will kill everyone in the game!' })
        :AddButton({ Text = 'Kick all', Func = Functions.KickAll, Tooltip = 'This will kick everyone in the game!' })
]]

-- Groupbox:AddLabel
-- Arguments: Text, DoesWrap

-- Groupbox:AddDivider
-- Arguments: None
LeftGroupBox:AddDivider()

--[[
    Groupbox:AddSlider
    Arguments: Idx, SliderOptions
    SliderOptions: {
        Text = string,
        Default = number,
        Min = number,
        Max = number,
        Suffix = string,
        Rounding = number,
        Compact = boolean,
        HideMax = boolean,
    }
    Text, Default, Min, Max, Rounding must be specified.
    Suffix is optional.
    Rounding is the number of decimal places for precision.
    Compact will hide the title label of the Slider
    HideMax will only display the value instead of the value & max value of the slider
    Compact will do the same thing
]]

-- Options is a table added to getgenv() by the library
-- You index Options with the specified index, in this case it is 'MySlider'
-- To get the value of the slider you do slider.Value


-- This should print to the console: "MySlider was changed! New value: 3"

-- Groupbox:AddInput
-- Arguments: Idx, Info


-- Groupbox:AddDropdown
-- Arguments: Idx, Info


-- Multi dropdowns

-- Label:AddColorPicker
-- Arguments: Idx, Info

-- You can also ColorPicker & KeyPicker to a Toggle as well


-- Long text label to demonstrate UI scrolling behaviour.

-- Dependency boxes let us control the visibility of UI elements depending on another UI elements state.
-- e.g. we have a 'Feature Enabled' toggle, and we only want to show that features sliders, dropdowns etc when it's enabled!
-- Dependency box example:


-- We can also nest dependency boxes!
-- When we do this, our SupDepbox automatically relies on the visiblity of the Depbox - on top of whatever additional dependencies we set


-- Library functions
-- Sets the watermark visibility
Library:SetWatermarkVisibility(true)

-- Example of dynamically-updating watermark with common traits (fps and ping)
local FrameTimer = tick()
local FrameCounter = 0;
local FPS = 60;

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1;

    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter;
        FrameTimer = tick();
        FrameCounter = 0;
    end;

    Library:SetWatermark(('Tokyoware | %s fps | %s ms'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ));
end);

Library.KeybindFrame.Visible = true; -- todo: add a function for this

Library:OnUnload(function()
    WatermarkConnection:Disconnect()

    print('Unloaded!')
    Library.Unloaded = true
end)

-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- ThemeManager (Allows you to have a menu theme system)

-- Hand the library over to our managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- Adds our MenuKeybind to the ignore list
-- (do you want each config to have a different menu key? probably not.)
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')

-- Builds our config menu on the right side of our tab
SaveManager:BuildConfigSection(Tabs['UI Settings'])

-- Builds our theme menu (with plenty of built in themes) on the left side
-- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()