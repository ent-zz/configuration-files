

-- {{{ awesome functions

function startup()
	local fzipcode = io.open(tmp_dir .. "currentzip")
	currentzip = fzipcode:read()
	fzipcode:close()

	--populate some of the widgets
	batterystate()
	getmailcount()
	getweather(currentzip)
	getupdates()

	local fnewstart = io.open(tmp_dir .. "newstart", "r")
	local newstart = fnewstart:read()
	fnewstart:close()

	if newstart == "true" then
		awful.util.spawn(script_dir .. "startup.sh")
	else
		fnewstart = io.open(tmp_dir .. "newstart", "w")
		fnewstart:write("true")
		fnewstart:close()
	end
end


function restartfunction()
	local fnewstart = io.open(tmp_dir .. "newstart", "w")
	fnewstart:write("false")
	fnewstart:close()
	awesome.restart()
end

-- }}}




-- {{{ widget functions


prevlayout = "tile"
function displaylayout()
	local layoutname = awful.layout.getname(awful.layout.get(1))
	if layoutname == "tile" then layoutname = " []= " end
	if layoutname == "max" then layoutname = " [M] " end
	if layoutname == "magnifier" then layoutname = " &#62;#&#60; " end
	if layoutname == "floating" then layoutname = " &#62;&#60;&#62; " end
	layoutwidget.text = layoutname
end


function batterystate()
	local facstate = io.open("/sys/class/power_supply/AC/online")
	local fstate = io.open("/proc/acpi/battery/BAT0/state")
	local finfo = io.open("/proc/acpi/battery/BAT0/info")
	local acstate = facstate:read()
	local state = fstate:read("*all")
	local info = finfo:read("*all")
	facstate:close()
	fstate:close()
	finfo:close()

	if acstate and state and info then
		local _, _, cur = string.find(state, "remaining capacity:%s+(%d+).*")
		local _, _, cap = string.find(info, "last full capacity:%s+(%d+).*")
		local batpercent = math.floor(cur / cap * 100)
		if batpercent == 106 then batpercent = 100 end

		local fgcolor = widget_alarm

		if acstate == "1" then fgcolor = widget_green
		else
			if batpercent > 60 then
				fgcolor = widget_normal
			elseif batpercent > 30 then
				fgcolor = widget_warn
			end
		end

		batterywidget.text = "<span color=\"" .. fgcolor .. "\">" .. batpercent .. "%</span>"
	end
end


function currenttemp()
	local ftempfile = io.open("/proc/acpi/thermal_zone/THM/temperature")
	local tempfile = ftempfile:read()
	ftempfile:close()

	if tempfile then
		local _, _, temp = string.find(tempfile, "temperature:%s+(%d+).*")
		temp = temp + 0

		local fgcolor = widget_green

		if temp >= 60 then fgcolor = widget_alarm
		elseif temp >= 50 then fgcolor = widget_warn
		elseif temp > 40 then fgcolor = widget_normal
		end

		tempwidget.text = "<span color=\"" .. fgcolor .. "\">" .. temp .. " C</span>"
	end
end


function getmailcount()
	local mail = io.popen("/home/ent/bin/gmail.pl")
	local count = mail:read()
	mail:close()

	if count then
		count = count + 0
		local fgcolor = widget_normal
		if count > 0 then fgcolor = widget_green end
		mailwidget.text = "<span color=\"" .. fgcolor .. "\">" .. count .. "</span>"
	end
end


function getweather(ZIP)
	if ZIP then
		local fweather = io.popen("/home/ent/bin/weather.sh " .. ZIP)
		local weather = fweather:read()
		fweather:close()
		if weather then
			weatherwidget.text = weather
		end
	end
end


function getupdates()
	local fpacupdates = io.popen("pacman -Qu")
	local pacupdates = fpacupdates:read("*all")
	fpacupdates:close()

	if pacupdates then
		local _, _, updates = string.find(pacupdates, "Targets%s+.(%d+).*")
		local fgcolor = widget_normal
		if updates then
			updates = updates + 0
			fgcolor = widget_normal
			if updates > 0 then fgcolor = widget_green end
		else updates = 0
		end
		pacwidget.text = "<span color=\"" .. fgcolor .. "\">" .. updates .. "</span>"
	end
end


function mpd_status()
	local f = io.popen("mpc")
	local mpc = f:read("*all")
	f:close()
	if (mpc) then
		local _, _, status = string.find(mpc, "%[(.*)%]")

		if (status) then
			local _, _, song = string.find(mpc, "(.*)%[")
			song = string.gsub(song, "\n", "  ")
			local _, _, elapsedtime = string.find(mpc, "(%d*:%d*)/")
			local _, _, totaltime = string.find(mpc, "/(%d*:%d*)")

			mpdwidget.text = song .. elapsedtime .. " / " .. totaltime
		else
			mpdwidget.text = "mpd - stopped"
			status = "stopped"
		end

		if (status ~= lastmpdstatus) then
			lastmpdstatus = status
			if (status == "paused") then
				mpdicon.image = image(icon_dir .. "pause.png")
			else mpdicon.image = image(icon_dir .. "musicS.png")
			end
		end
	end
end


--- }}}







-- {{{ misc functions

function maxtoggle()
	local layout = awful.layout.getname(awful.layout.get(1))
	if layout == "max" then
		if prevlayout == "magnifier" then
			awful.layout.set(awful.layout.suit.magnifier, i)
		else awful.layout.set(awful.layout.suit.tile, i)
		end
	else
		prevlayout = layout
		awful.layout.set(awful.layout.suit.max, i)
	end
end


function tagset(tagarray)
	if tagarray then
		for i = 1, 5 do
			tags[i].selected = tagarray[i]
		end
	end
end


function chattoggle()
	if tags[5].selected then awful.tag.history.restore()
	else awful.tag.viewonly(tags[5]) 
	end
end

-- }}}
