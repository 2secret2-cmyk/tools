script_name("atools_checker")

scripts = {}

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then
		return
	end

	onSystemInitialized()

	while not isSampAvailable() do
		wait(100)
	end

	local slot0_000C = {}

	for arg4, arg5 in ipairs(scripts) do
		if arg5.name == "atoolsW" then
			arg5.version = tonumber(arg5.version)
			arg5.size = getSizeFile(arg5.path)

			table.insert(slot0_000C, arg5)
		end
	end

	if #slot0_000C > 1 then
		local slot1_001F = 1

		for arg5, slot6_002C in ipairs(slot0_000C) do
			print(arg6.filename, arg6.size)

			if arg0[slot1_001F].version < arg6.version then
				deleteScript(arg0[slot1_001F])
				table.remove(arg0, slot1_001F)

				local slot1_0031 = arg5
			end
		end
	end

	if #slot0_000C > 1 then
		local slot1_0034 = 1

		for arg5, slot6_002C in ipairs(slot0_000C) do
			if arg0[slot1_0034].size < arg6.size then
				deleteScript(arg0[slot1_0034])
				table.remove(arg0, slot1_0034)

				local slot1_0043 = arg5
			end
		end
	end

	if #slot0_000C > 1 then
		for slot4_0000, arg5 in ipairs(slot0_000C) do
			if arg4 > 1 then
				table.remove(arg0, arg4)
				deleteScript(arg5)
			end
		end
	end
end

function onSystemInitialized()
	if not initialized then
		loadScriptsList()

		initialized = true
	end
end

function onScriptLoad(arg0)
	if getScriptFromList(arg0) ~= nil then
		slot1_0059:enable(arg0)
	else
		addScriptToList(arg0)
	end
end

function onScriptTerminate(arg0)
	if getScriptFromList(arg0) ~= nil then
		slot1_0062:disable(arg0)
	end
end

function loadScriptsList()
	for arg3, arg4 in ipairs(script.list()) do
		addScriptToList(arg4)
	end
end

function getScriptFromList(arg0)
	for arg4, arg5 in pairs(scripts) do
		if arg5.path == arg0.path then
			return arg5
		end
	end

	return nil
end

function addScriptToList(arg0)
	if getScriptFromList(arg0) == nil then
		table.insert(scripts, Script:new(arg0))
	end
end

function deleteScript(arg0)
	if getScriptFromList(arg0) ~= nil then
		slot1_0086:unload()
		os.remove(slot1_0086.path)
	end
end

function getSizeFile(arg0)
	local slot1_0091 = io.open(arg0, "r")

	slot1_0091:seek("set", slot1_0091:seek())
	slot1_0091:close()

	return slot1_0091:seek("end")
end

Script = {
	new = (function (arg0, arg1)
		local slot2_00A2 = {
			loaded = true,
			updateInfo = (function (arg0, arg1)
				arg0.script = arg1
				arg0.name = arg1.name
				arg0.description = arg1.description
				arg0.version_num = arg1.version_num
				arg0.version = arg1.version
				arg0.authors = arg1.authors
				arg0.dependencies = arg1.dependencies
				arg0.path = arg1.path
				arg0.filename = arg1.filename
				arg0.directory = arg1.directory
				arg0.frozen = arg1.frozen
				arg0.dead = arg1.dead
			end),
			load = (function (arg0)
				arg0:updateInfo(uv0.load(arg0.path))
			end),
			unload = (function (arg0)
				arg0.script:unload()
			end),
			pause = (function (arg0)
				arg0.script:pause()

				arg0.frozen = arg0.script.frozen
			end),
			resume = (function (arg0)
				arg0.script:resume()

				arg0.frozen = arg0.script.frozen
			end),
			reload = (function (arg0)
				arg0.script:reload()
			end),
			enable = (function (arg0, arg1)
				if arg0.loaded ~= true then
					arg0:updateInfo(arg1)
				end

				arg0.loaded = true
			end),
			disable = (function (arg0)
				arg0.loaded = false
			end)
		}

		slot2_00A2:updateInfo(arg1)
		setmetatable(slot2_00A2, arg0)

		arg0.__index = arg0

		return slot2_00A2
	end)
}
