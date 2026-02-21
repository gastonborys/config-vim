local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Función para fecha actual en formato YYYY-MM-DD
local function current_date()
    return os.date("%Y-%m-%d")
end

ls.add_snippets("typescript", {
  -- Snippet para comentario de clase
  s("clsdoc", {
    t({"/**", " * @description "}), i(1, "Descripción de la clase"),
    t({"", " * @author "}), i(2, "TuNombre"),
    t({"", " * @date "}), f(current_date, {}),
    t({"", " */"}),
  }),
})
