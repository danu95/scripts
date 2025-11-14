local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Markdown snippets
return {
  -- Insert an ANSWER block
  s('answer', {
    t { '[!ANSWER:] ' },
    i(0),
  }),

  -- Short alias
  s('a', {
    t { '[!ANSWER:] ' },
    i(0),
  }),


  -- Insert an OPEN block
  s('open', {
    t { '> [!OPEN:] ' },
    i(0),
  }),

  -- Short alias
  s('o', {
    t { '> [!OPEN:] ' },
    i(0),
  }),

}

-- Die farbliche Anpassung habe ich mit einem File in C:\Users\vonkaeneld\AppData\Local\nvim\after\ftplugin\markdown.lua erstellt. 




