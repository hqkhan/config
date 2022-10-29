local res, devicons = pcall(require, "nvim-web-devicons")

if not res then
  return
end
devicons.setup({})
