local present, leap = pcall(require, 'leap')

if not present then
  return
end

-- 初始化默认按键
leap.add_default_mappings(true);
--[[ s 键位 => 启动键
s + 'xxxx' 搜索所有当前行下方xxxx关键词 并跳转到第一个搜索到的地方
S + ‘xxxxx’ 搜索所有当前行上方的关键词 
搜索后 按s可以跳转到下一个高亮地方或者enter键
s + enter 重复上次搜索内容 ]]
