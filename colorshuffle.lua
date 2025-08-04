VERSION = "0.0.5"

math.randomseed(os.time())

local micro = import("micro")
local config = import("micro/config")

local function convert_userdata_array_to_table(ud)
	local result = {}
	for i = 1, #ud do
		result[i] = ud[i]
	end
	return result
end

local function get_colorschemes()
	local raw = config.ListRuntimeFiles(config.RTColorscheme)
	return convert_userdata_array_to_table(raw)
end

local colors = get_colorschemes()

function ColorShuffleCmd()
	local old = config.GetGlobalOption("colorscheme")
	local scheme
	repeat
		scheme = colors[math.random(1, #colors)]
	until scheme ~= old
	config.SetGlobalOption("colorscheme", scheme)
	--micro.InfoBar():Message("Color scheme set to: " .. scheme)
end

function onBufferOpen(buf)
	if not config.GetGlobalOption("colorshuffle.enabled") then
		return
	end

	ColorShuffleCmd()
end

function preinit()
	config.RegisterCommonOption("colorshuffle", "enabled", true)
end

function init()
	colors = get_colorschemes()

	config.MakeCommand("colorshuffle", ColorShuffleCmd, config.NoComplete)
	config.TryBindKey("Ctrl-Alt-s", "lua:colorshuffle.ColorShuffleCmd", false)
	config.AddRuntimeFile("colorshuffle", config.RTHelp, "help/colorshuffle.md")
end
