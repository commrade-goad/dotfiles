require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_snipmate').lazy_load()

local ls = require("luasnip")  -- Load LuaSnip
local s = ls.snippet           -- Shortcut for defining a snippet
local t = ls.text_node         -- Shortcut for text nodes
local i = ls.insert_node       -- Shortcut for insert nodes

ls.add_snippets("sh", {
    s("shebang", {
        t("#!/usr/bin/env sh"),
        t({ "", "" }),
        i(0),
    }),
})

ls.add_snippets("bash", {
    s("shebang", {
        t("#!/usr/bin/env bash"),
        t({ "", "" }),
        i(0),
    }),
})

ls.add_snippets("zsh", {
    s("shebang", {
        t("#!/usr/bin/env zsh"),
        t({ "", "" }),
        i(0),
    }),
})

ls.add_snippets("cpp", {
    s("uns", {
        t("using namespace std;"),
        t({ "", "" }),
        i(0),
    }),
})
