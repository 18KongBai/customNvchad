---@class NotifyConfig
local notify = {
  enable = true,
  ---@type number in millionsecond
  timeout = 3000,

  ---@type  'fade_in_slide_out' | 'fade' | 'static' | 'slide'

  stages = "slide",

  ---@type 'default' | 'minimal' | 'simple' | 'compact' | 'wrapped-compact'

  render = "default",
}
local options = {
  stages = notify.stages,
  timeout = notify.timeout,
  render = notify.render,
}

return options
