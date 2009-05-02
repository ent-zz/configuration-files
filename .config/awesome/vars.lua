modkey = "Mod4"
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

browser = "firefox"

theme = "custom"

root_dir = "/home/ent/.config/awesome/"
tmp_dir = root_dir .. "tmp/"
script_dir = root_dir .. "scripts/"
theme_dir = root_dir .. "themes/"
icon_dir = theme_dir .. theme .. "/icons/"
beautiful.init(theme_dir .. theme .. "/" .. theme .. ".theme")

usetitlebar = false

currentzip = 00000
lastmpdstatus =  "playing"

apptags = {
	["screen"]        = { screen = 1, tag = 1 },
	["Firefox"]       = { screen = 1, tag = 2 },
	["Gran Paradiso"] = { screen = 1, tag = 2 },
	["ssh"]	          = { screen = 1, tag = 3 },
	["Gimp"]          = { screen = 1, tag = 4 },
	["finch"]         = { screen = 1, tag = 5 },
	["Pidgin"]        = { screen = 1, tag = 5 }
}

floatapps = {
	["Pidgin"] = true,
	["Gimp"]   = true,
	["MPlayer"] = true
}

layouts = {
	awful.layout.suit.tile,
	--awful.layout.suit.tile.left,
	--awful.layout.suit.tile.bottom,
	--awful.layout.suit.tile.top,
	--awful.layout.suit.fair,
	--awful.layout.suit.fair.horizontal,
	--awful.layout.suit.max,
	--awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier,
	--awful.layout.suit.floating
}

tags = {}
tags[1] = tag("term")
tags[2] = tag("www")
tags[3] = tag("ssh")
tags[4] = tag("misc") 
tags[5] = tag("chat")

for i = 1, 5 do
	tags[i].screen = 1
	awful.layout.set(layouts[1], tags[i])
end
tags[1].selected = true

widget_normal = beautiful.fg_normal
if beautiful.fg_warn then widget_warn = beautiful.fg_warn
	else widget_warn = widget_normal end
if beautiful.fg_alarm then widget_alarm = beautiful.fg_alarm
	else widget_alarm = widget_normal end
if beautiful.fg_green then widget_green = beautiful.fg_green
	else widget_green = widget_normal end

tagset1 = { true, true, false, false, false }
tagset2 = { true, false, true, false, false }

