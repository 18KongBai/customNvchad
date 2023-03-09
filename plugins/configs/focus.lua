local present, focus = pcall(require, "focus")

if not present then
  return
end

focus.setup {
  absolutenumber_unfocussed = true,
  autoresize = true,
  excluded_filetypes = { "toggleterm" },
}
