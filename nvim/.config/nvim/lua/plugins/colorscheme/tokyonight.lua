return {
  {
    "folke/tokyonight.nvim",
    opts = {
      on_highlights = function(hl, colors)
        -- remove underline from semantic tokens & base types
        hl["@type"] = { fg = colors.green, underline = false }
        hl["@variable"] = { underline = false }

        hl["@lsp.type.class"] = { underline = false }
        hl["@lsp.type.variable"] = { underline = false }

        hl["@lsp.mod.readonly"] = { underline = false }
        hl["@lsp.mod.constructor"] = { underline = false }
        hl["@lsp.mod.public"] = { underline = false }

        hl["@lsp.typemod.class.public"] = { underline = false }
        hl["@lsp.typemod.class.constructor"] = { underline = false }
        hl["@lsp.typemod.variable.readonly"] = { underline = false }
        hl["@lsp.typemod.variable.declaration"] = { underline = false }

        -- Disable reference highlights (cursor positions)
        hl.LspReferenceRead = { bg = "none", underline = false }
        hl.LspReferenceText = { bg = "none", underline = false }
        hl.LspReferenceWrite = { bg = "none", underline = false }
      end,
    },
  },
}
