local present, lazygit = pcall(require, "lazygit.nvim")

if not present then
  return
end

lazygit.setup()
