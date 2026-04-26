local M = {}

function M:peek(job)
	local start, cache = os.clock(), ya.file_cache(job)
	if not cache then
		return
	end

	local ok, err = self:preload(job)
	if not ok or err then
		ya.preview_widgets(job, {
			ui.Text(tostring(err)):area(job.area):wrap(ui.Text.WRAP),
		})
		return
	end

	ya.sleep(math.max(0, rt.preview.image_delay / 1000 + start - os.clock()))
	ya.image_show(cache, job.area)
	ya.preview_widgets(job, {})
end

function M:preload(job)
	local cache = ya.file_cache(job)
	if not cache or fs.cha(cache) then
		return true
	end

	local rnote = Command("rnote-cli")
		:arg({
			"thumbnail",
			"-s",
			"1024",
			tostring(job.file.url),
			tostring(cache),
		})
		:stdin(Command.NULL)
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:output()

	if not rnote or not rnote.status.success then
		local err_msg = rnote and rnote.stderr or "Failed to execute rnote-cli command"
		ya.err("Rnote error: " .. err_msg)
		return true, Err("Failed to convert `%s` to a thumbnail", job.file.name)
	end

	return true
end

return M
