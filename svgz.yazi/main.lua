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

	local svgz = Command("rsvg-convert")
		:arg({
			"-d",
			"300",
			"-p",
			"300",
			"-f",
			"png",
			tostring(job.file.url),
			"-o",
			tostring(cache),
		})
		:stdin(Command.NULL)
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:output()

	if not svgz or not svgz.status.success then
		local err_msg = svgz and svgz.stderr or "Failed to execute rsvg-convert command"
		ya.err("SVGZ error: " .. err_msg)
		return true, Err("Failed to convert `%s` to a thumbnail", job.file.name)
	end

	return true
end

return M
