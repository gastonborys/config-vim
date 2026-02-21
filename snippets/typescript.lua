local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {

	s("ccomment", fmt([[
	/*
	 * @description {}
	 *
	 * @author Gastón Borysiuk
	 * @date {}
	*/
	]], {
		i(1, "Descripción"),
		f(function()
			return os.date("%Y-%m-%d")
		end, {}),
	})),

	s("cfunc", fmt([[
	/*
	 * @description {}
	 *
	 * @param {} {}
	 * @returns {}
	 *
	 * @author Gastón Borysiuk
	 * @date {}
	*/
	]], {
		i(1, "Descripción de la función"),
		i(2, "paramName"),
		i(3, "Descripción del parámetro"),
		i(4, "ReturnType"),
		f(function()
			return os.date("%Y-%m-%d")
		end, {}),
	})),

}
