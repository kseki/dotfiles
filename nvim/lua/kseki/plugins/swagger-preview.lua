local setup, swagger_preview = pcall(require, "swagger-preview")
if not setup then
	return
end

swagger_preview.setup({
	port = 8000,
	host = "localhost",
})
