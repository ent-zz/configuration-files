globalkeys = awful.util.table.join(

--defaults

	 awful.key({ modkey }, "Left",   awful.tag.viewprev)
	,awful.key({ modkey }, "Right",  awful.tag.viewnext)
--	,awful.key({ modkey }, "Escape", awful.tag.history.restore)
	,awful.key({ modkey }, "j",      function () awful.client.focus.byidx(-1) if client.focus then client.focus:raise() end end)
	,awful.key({ modkey }, "k",      function () awful.client.focus.byidx( 1) if client.focus then client.focus:raise() end end)
	,awful.key({ modkey }, "w",      function () mymainmenu:show(true) end)

	-- Layout manipulation
	,awful.key({ modkey, "Shift"   }, "j",  function () awful.client.swap.byidx(-1) end)
	,awful.key({ modkey, "Shift"   }, "k",  function () awful.client.swap.byidx( 1) end)
--	,awful.key({ modkey, "Control" }, "j",  function () awful.screen.focus( 1)      end)
--	,awful.key({ modkey, "Control" }, "k",  function () awful.screen.focus(-1)      end)
--	,awful.key({ modkey,           }, "u",  awful.client.urgent.jumpto)
--	,awful.key({ modkey,           }, "Tab" function () awful.client.focus.history.previous() if client.focus then client.focus:raise() end end)

	-- Standard program
	,awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end)
--	,awful.key({ modkey, "Control" }, "r", awesome.restart)
	,awful.key({ modkey, "Shift"   }, "q", awesome.quit)

--	,awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end)
--	,awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end)
--	,awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end)
--	,awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end)
--	,awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end)
--	,awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end)
	,awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end)
	,awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end)

	-- Prompt
	,awful.key({ modkey }, "p",
	          function ()
	              awful.prompt.run({ prompt = "Run: " },
	              promptbox,
	              awful.util.spawn, awful.completion.shell,
	              awful.util.getdir("cache") .. "/history")
	          end)

-- custom keybinds

	,awful.key({ modkey, "Control" }, 'r',   function () restartfunction() end)
	,awful.key({ modkey 	       }, "Tab", awful.tag.history.restore)
	,awful.key({ modkey, "Shift"   }, "Tab", function () awful.client.focus.history.previous() if client.focus then client.focus:raise() end end)
	,awful.key({ modkey 	       }, '`',   function () chattoggle() end )
	,awful.key({ modkey, "Shift"   }, '`',   function () awful.util.spawn(script_dir .. "startup.sh") end)
	,awful.key({ modkey 	       }, 'm',   function () maxtoggle() end)
	,awful.key({ modkey 	       }, 's',	 function () awful.util.spawn(terminal .. " -name screen -e " .. script_dir .. "screenlaunch.sh") end)
	,awful.key({ modkey 	       }, 'a',	 function () awful.util.spawn(terminal .. " -name ssh -e " .. script_dir .. "sshlaunch.sh") end)
	,awful.key({ modkey 	       }, 'c',	 function () awful.util.spawn(terminal .. " -name finch -e " .. script_dir "chatlaunch.sh") end)
	,awful.key({ modkey 	       }, 'f',	 function () awful.util.spawn(browser) end)
	,awful.key({ modkey 	       }, "F1",  function () tagset(tagset1) end)
	,awful.key({ modkey 	       }, "F2",  function () tagset(tagset2) end)
)

-- Client awful tagging: this is useful to tag some clients and then do stuff like move to tag on them
clientkeys = awful.util.table.join(
--	 awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end)
	 awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end)
	,awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     )
--	,awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end)
--	,awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        )
	,awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end)
--	,awful.key({ modkey 	       }, "t", awful.client.togglemarked)
--	,awful.key({ modkey,	       }, "m",
--	    function (c)
--	        c.maximized_horizontal = not c.maximized_horizontal
--	        c.maximized_vertical   = not c.maximized_vertical
--	    end)
)


for i = 1, 5 do
    table.foreach(awful.key({ modkey }, i,
                  function ()
                        if tags[i] then
                            awful.tag.viewonly(tags[i])
                        end
                  end), function(_, k) table.insert(globalkeys, k) end)
    table.foreach(awful.key({ modkey, "Control" }, i,
                  function ()
                      if tags[i] then
                          tags[i].selected = not tags[i].selected
                      end
                  end), function(_, k) table.insert(globalkeys, k) end)
    table.foreach(awful.key({ modkey, "Shift" }, i,
                  function ()
                      if client.focus and tags[i] then
                          awful.client.movetotag(tags[i])
                      end
                  end), function(_, k) table.insert(globalkeys, k) end)
    table.foreach(awful.key({ modkey, "Control", "Shift" }, i,
                  function ()
                      if client.focus and tags[i] then
                          awful.client.toggletag(tags[i])
                      end
                  end), function(_, k) table.insert(globalkeys, k) end)
end

-- Set keys
root.keys(globalkeys)
-- }}}
