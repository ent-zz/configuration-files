
-------------
--misc widgets
taglist = awful.widget.taglist.new(1, awful.widget.taglist.label.all, nil)
tasklist = awful.widget.tasklist.new(function(c) return awful.widget.tasklist.label.currenttags(c, 1) end, nil)
promptbox = widget({ type = 'textbox' })
systray = widget({ type = 'systray', align = 'right' })

spacer = widget({ type = 'textbox', align = 'right' })
spacer.text = " <span color='#446655'>|</span> "
space = widget({ type = 'textbox', align = 'right'  })
space.text = ' '

myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}
mymainmenu = awful.menu.new({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                        { "open terminal", terminal }
                                      }
                            })
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-------------
--layout display

layoutwidget = widget({ type = 'textbox', name = 'layoutwidget' })


-------------
--date / time

clockicon = widget({ type = 'imagebox', align = 'right' })
clockicon.image = image(icon_dir .. "clock.png")

clockbox = widget({ type = 'textbox', align = 'right' })


-------------
--mpd

mpdicon = widget({ type = 'imagebox', name = 'mpdicon', align = 'right' })
mpdicon.image = image(icon_dir .. 'musicS.png')

mpdwidget = widget({ type = 'textbox', name = 'mpdwidget', align = 'right' })
--wicked.register(mpdwidget, wicked.widgets.mpd, '$1')


--------------
--battery

batteryicon = widget({ type = 'imagebox', name = 'batteryicon', align = 'right' })
batteryicon.image = image(icon_dir .. 'bat_full.png')

batterywidget = widget({ type = 'textbox', name = 'batterywidget', align = 'right' })


-------------
--temperature

tempicon = widget({ type = 'imagebox', name = 'tempicon', align = 'right' })
tempicon.image = image(icon_dir .. "temp.png")

tempwidget = widget({ type = 'textbox', name = 'tempwidget', align = 'right' })


-------------
--gmail

mailicon = widget({ type = 'imagebox', name = 'mailicon', align = 'right' })
mailicon.image = image(icon_dir .. "mail.png")

mailwidget = widget({ type = 'textbox', name = 'mailwidget', align = 'right' })


--------------
--weather

weathericon = widget({ type = 'imagebox', name = 'weathericon', align = 'right' })
weathericon.image = image(icon_dir .. "raincloud.png")

weatherwidget = widget({ type = 'textbox', name = 'weatherwidget', align = 'right' })


---------------
--cpu

cpuicon = widget({ type = 'imagebox', name = 'cpuicon', align = 'right' })
cpuicon.image = image(icon_dir .. "cpu.png")

cpu0widget = widget({ type = 'progressbar', name = 'cpu0widget', align = 'right' })
cpu0widget.width = 10
cpu0widget.height = 0.9
cpu0widget.gap = 0
cpu0widget.border_padding = 1
cpu0widget.border_width = 0
cpu0widget.ticks_count = 4
cpu0widget.ticks_gap = 1
cpu0widget.vertical = true
cpu0widget:bar_properties_set("cpu", {
	bg = beautiful.bg_widget,
	fg = beautiful.fg_widget,
	fg_center = beautiful.fg_center_widget,
	fg_end = beautiful.fg_end_widget,
	fg_off = beautiful.fg_off_widget,
	min_value = 0,
	max_value = 100
})
wicked.register(cpu0widget, wicked.widgets.cpu, "$2", 1, "cpu")

cpu1widget = widget({ type = 'progressbar', name = 'cpu1widget', align = 'right' })
cpu1widget.width = 10
cpu1widget.height = 0.9
cpu1widget.gap = 0
cpu1widget.border_padding = 1
cpu1widget.border_width = 0
cpu1widget.ticks_count = 4
cpu1widget.ticks_gap = 1
cpu1widget.vertical = true
cpu1widget:bar_properties_set("cpu", {
	bg = beautiful.bg_widget,
	fg = beautiful.fg_widget,
	fg_center = beautiful.fg_center_widget,
	fg_end = beautiful.fg_end_widget,
	fg_off = beautiful.fg_off_widget,
	min_value = 0,
	max_value = 100
})
wicked.register(cpu1widget, wicked.widgets.cpu, "$3", 1, "cpu")


----------------
--ram

memicon = widget({ type = 'imagebox', name = 'memicon', align = 'right' })
memicon.image = image(icon_dir .. "mem.png")

memwidget = widget({ type = 'textbox', name = 'memwidget', align = 'right' })
wicked.register(memwidget, wicked.widgets.mem, "$2", 1)

------------------
--pacman updates

pacicon = widget({ type = 'imagebox', name = 'pacicon', align = 'right' })
pacicon.image = image(icon_dir .. "pacman.png")

pacwidget = widget({ type = 'textbox', name = 'pacwidget', align = 'right' })





------------------
--statusbar(s)

statusbar1 = wibox( { position = "top", height = "14", fg = beautiful.fg_normal, bg = beautiful.bg_normal } )
statusbar1.widgets = {
    taglist, layoutwidget, promptbox, tasklist,		  --stuff on the left
    space, --mpdicon, space, mpdwidget, spacer,		  --mpd
    weathericon, space, weatherwidget, spacer,		  --weather
    mailicon, space, mailwidget, spacer,		  --gmail
    pacicon, space, pacwidget, spacer,			  --pacman updates
    cpuicon, space, cpu0widget, space, cpu1widget, space, --cpu graphs
    tempicon, space, tempwidget, spacer,		  --cpu temp
    memicon, space, memwidget, spacer,			  --ram
    batteryicon, space, batterywidget, spacer,		  --battery
    clockicon, space, clockbox,				  --date/time
    systray						  --systray (just in case)
}
statusbar1.screen = 1

