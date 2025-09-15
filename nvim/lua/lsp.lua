require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require('mason-lspconfig').setup({
    ensure_installed = { 'pylsp', 'lua_ls', 'rust_analyzer', 'clangd', 'jdtls', 'intelephense', 'ts_ls', 'cssls' },
})

local lspconfig = require('lspconfig')

-- Common on_attach function
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format({ async = true }) end, opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

--[[
-- Lua (lua_ls)
lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        }
    }
})

-- Rust (rust_analyzer)
lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = { command = "clippy" },
        }
    }
})

-- Java (jdtls)
lspconfig.jdtls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "jdtls" }, -- Java language server
})
]]

-- C/C++ (clangd)
lspconfig.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "clangd" }, -- Ensure correct executable
})

-- Python (pylsp)
lspconfig.pylsp.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        pylsp = {
            plugins = {
                pyflakes = { enabled = true },  -- Linter
                pycodestyle = { enabled = false }, -- Disable style warnings
                jedi_completion = { fuzzy = true }, -- Fuzzy completion
            }
        }
    }
})

-- PHP (intelephense)
lspconfig.intelephense.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = function(fname)
        return vim.fn.getcwd()
    end,
})

-- JavaScript/TypeScript (tsserver)
lspconfig.ts_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

-- CSS/SCSS (cssls)
lspconfig.cssls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
