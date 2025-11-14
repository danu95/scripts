local ls = require 'luasnip'
local s = ls.snippet
local f = ls.function_node
local t = ls.text_node
local i = ls.insert_node

-- Snippets that are active in *all* filetypes
return {
  -- Insert current date
  s('today', {
    f(function()
      return '## ' .. os.date '%Y-%m-%d' -- Example: 2025-09-02
    end, {}),
  }),

  -- Insert current day + date
  s('now', {
    f(function()
      return '## ' .. os.date '%A %d.%m.%Y' -- Example: Tuesday 02.09.2025
    end, {}),
  }),

  -- Insert current day + date
  s('tomorrow', {
    f(function()
      return '## ' .. os.date('%A %d.%m.%Y', os.time() + 24 * 60 * 60) -- Example: Tuesday 02.09.2025
    end, {}),
  }),

  -- Insert template
  s('temp1', {
    t {
      'from: [[]]',
      'to: [[]]',
      'tags: [[]]',
      'sources: [[]]',
    },
  }),
}
