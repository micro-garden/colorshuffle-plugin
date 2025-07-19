VERSION = "0.0.1"

math.randomseed(os.time())

local config = import("micro/config")
local shell = import("micro/shell")
local micro = import("micro")

local builtin = {
	"atom-dark",
	"bubblegum",
	"cmc-16",
	"cmc-tc",
	"darcula",
	"default",
	"dracula-tc",
	"dukedark-tc",
	"dukelight-tc",
	"dukeubuntu-tc",
	"geany",
	"gotham",
	"gruvbox",
	"gruvbox-tc",
	"material-tc",
	"monokai",
	"monokai-dark",
	"one-dark",
	"railscast",
	"simple",
	"solarized",
	"solarized-tc",
	"sunny-day",
	"twilight",
	"zenburn",
}

function extractNames(lines)
	local list = {}
	for line in lines:gmatch("[^\r\n]+") do
		local name = line:match("([^/\\]+)%.micro$")
		if name then
			table.insert(list, name)
		end
	end
	return list
end

function getAvailableColorSchemes()
	local dir = config.ConfigDir .. "/colorschemes"

	-- Try Unix-style ls
	local out, err = shell.ExecCommand("ls", "-1", dir)
	if out and out ~= "" then
		return extractNames(out)
	end

	-- Try Windows-style dir via cmd
	out, err = shell.ExecCommand("cmd", "/C", "dir", "/b", dir .. "\\*.micro")
	if out and out ~= "" then
		return extractNames(out)
	end

	-- If both methods fail
	micro.InfoBar():Error("Unable to list color schemes.")
	return {}
end

function mergeColorSchemes()
	local merged = getAvailableColorSchemes()

	for _, b in ipairs(builtin) do
		table.insert(merged, b)
	end

	local seen = {}
	local unique = {}
	for _, name in ipairs(merged) do
		if not seen[name] then
			seen[name] = true
			table.insert(unique, name)
		end
	end

	--table.sort(unique)
	return unique
end

local colors = mergeColorSchemes()

function randomColorScheme()
	local old = config.GetGlobalOption("colorscheme")
	local scheme
	repeat
		scheme = colors[math.random(1, #colors)]
	until scheme ~= old
	config.SetGlobalOption("colorscheme", scheme)
	--micro.InfoBar():Message("Color scheme set to: " .. scheme)
end

function onBufferOpen(buf)
	randomColorScheme()
end

function init()
	config.MakeCommand("colorshuffle", randomColorScheme, config.NoComplete)
	config.TryBindKey("Ctrl-Alt-s", "lua:colorshuffle.randomColorScheme", false)
	config.AddRuntimeFile("colorshuffle", config.RTHelp, "help/colorshuffle.md")
end
