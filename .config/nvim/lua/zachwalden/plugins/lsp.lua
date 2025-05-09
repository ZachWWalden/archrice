return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- Completion Engine
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		--"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
		-- LSP Extras
		"p00f/clangd_extensions.nvim",
		"onsails/lspkind.nvim",
	},
	config = function ()
		-- Setup mason
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
				}
			}
		})

		-- Configure mason-lspconfig
		require("mason-lspconfig").setup {
			ensure_installed = {
				'asm_lsp', -- ASM
				'bashls', -- Bash
				'clangd', -- C/C++
				'cmake', -- Cmake
				'cssls', -- CSS
				'dockerls', -- Docker
				'docker_compose_language_service', -- Docker Compose
				'golangci_lint_ls', -- Go
				'gradle_ls', -- Gradle
				'html', -- HTML
				'jsonls', -- JSON
				-- 'java_language_server', -- Java, ERROR Cannot compile on Arch linux due to missing jlink binary
				'ts_ls', -- TypeScript, JavaScript
				-- 'kotlin_language_server', -- Kotlin
				'ltex', -- LaTeX
				'lua_ls', -- Lua
				'autotools_ls', -- Make, Autoconf
				'marksman', -- Markdown
				'matlab_ls', -- MatLab
				'mesonlsp', -- Meson build
				-- 'nil_ls', -- Nix: Build Fails
				'openscad_lsp', -- OpenSCAD
				'pyright', -- Python
				'rust_analyzer', -- Rust
				'sqlls', -- SQL
				'svlangserver', -- SystemVerilog
				'lemminx', -- XML
			},
		}
		-- setup Completion
		local cmp = require'cmp'

		local ok, lspkind = pcall(require, "lspkind")
		if not ok then
			return
		end

		lspkind.init {
			symbol_map = {
				Copilot = "",
			},
		}

		cmp.setup({
			formatting = {
				-- Youtube: How to set up nice formatting for your sources.
				format = lspkind.cmp_format {
					with_text = true,
					menu = {
						buffer = "[buf]",
						nvim_lsp = "[LSP]",
						nvim_lua = "[api]",
						path = "[path]",
						--cmdline = "[cmd]",
						luasnip = "[snip]",
					},
				},
			},

			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				['<C-p>'] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
				['<C-n>'] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
				['<C-y>'] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = 'path' },
				{ name = 'nvim-lua', keyword_length = 1 },
				{ name = 'nvim_lsp', keyword_length = 1 },
				{ name = 'luasnip', keyword_length = 2 }, -- For luasnip users.
			}, {
				{ name = 'buffer', keyword_length = 3 },
				--{ name = 'cmdline', keyword_length = 3 },
			})
		})

		-- Set up .
		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		local lspconfig = require('lspconfig')
		-- Configure each lsp
		lspconfig.asm_lsp.setup {
			capabilities = capabilities,
		}
		lspconfig.bashls.setup {
			capabilities = capabilities,
		}
		require("clangd_extensions").setup({
			vim.keymap.set('n','<leader>csw', "<cmd>ClangdSwitchSourceHeader<CR>"),
			vim.keymap.set('n','<leader>cmu',"<cmd>ClangdMemoryUsage<CR>"),
			vim.keymap.set('n','<leader>cmU',"<cmd>ClangdMemoryUsage expand_preamble<CR>"),
		})
		lspconfig.clangd.setup {
			capabilities = capabilities,
		}
		lspconfig.cmake.setup {
			capabilities = capabilities,
		}
		--Enable (broadcasting) snippet capability for completion
		require'lspconfig'.cssls.setup {
			capabilities = capabilities,
		}
		lspconfig.dockerls.setup {
			capabilities = capabilities,
		}
		lspconfig.docker_compose_language_service.setup {
			capabilities = capabilities,
		}
		lspconfig.golangci_lint_ls.setup {
			capabilities = capabilities,
		}
		lspconfig.gradle_ls.setup {
			capabilities = capabilities,
		}
		lspconfig.html.setup {
			capabilities = capabilities,
		}
		lspconfig.jsonls.setup {
			capabilities = capabilities,
		}
		-- lspconfig.java_language_server.setup {
		-- 	capabilities = capabilities,
		-- }
		lspconfig.ts_ls.setup {
			capabilities = capabilities,
		}
		-- lspconfig.kotlin_language_server.setup {}
		lspconfig.ltex.setup {
			capabilities = capabilities,
			settings = {
				ltex = {
					language = "en-US",
				},
			},
		}
		lspconfig.lua_ls.setup {
			capabilities = capabilities,
			on_init = function(client)
				local path = client.workspace_folders[1].name
				if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
					client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
						Lua = {
							runtime = {
								-- Tell the language server which version of Lua you're using
								-- (most likely LuaJIT in the case of Neovim)
								version = 'LuaJIT'
							},
							-- Make the server aware of Neovim runtime files
							workspace = {
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME
									-- "${3rd}/luv/library"
									-- "${3rd}/busted/library",
								}
								-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
								-- library = vim.api.nvim_get_runtime_file("", true)
							},
							diagnostics = {
								globals = { 'vim' }
							}
						}
					})

					client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
				end
				return true
			end
		}
		lspconfig.autotools_ls.setup {
			capabilities = capabilities,
		}
		lspconfig.marksman.setup {
			capabilities = capabilities,
		}
		lspconfig.matlab_ls.setup {
			capabilities = capabilities,
		}
		lspconfig.mesonlsp.setup {
			capabilities = capabilities,
		}
		-- lspconfig.nil_ls.setup {
		-- 	capabilities = capabilities,
		-- }
		lspconfig.openscad_lsp.setup {
			capabilities = capabilities,
		}
		lspconfig.pyright.setup {
			capabilities = capabilities,
		}
		lspconfig.rust_analyzer.setup {
			capabilities = capabilities,
			settings = {
				['rust-analyzer'] = {
					diagnostics = {
						enable = true;
					}
				}
			}
		}
		lspconfig.sqlls.setup {
			capabilities = capabilities,
		}
		-- SvlangserverBuildIndex: Instructs language server to rerun indexing
		-- SvlangserverReportHierarchy: Generates hierarchy for the given module
		vim.keymap.set('n', '<leader>srh', "<cmd>SvlangserverReportHierarchy<CR>")
		lspconfig.svlangserver.setup {
			capabilities = capabilities,
		}
		lspconfig.lemminx.setup {
			capabilities = capabilities,
		}

		-- Global mappings.
		-- See `:help vim.diagnostic.*` for documentation on any of the below functions
		-- Handled by folke/trouble.nvim
		-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
		-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
		vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
				vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
				vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float)
				vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
				vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
				vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
				vim.keymap.set('n', '<leader>frmt', function()
					vim.lsp.buf.format { async = true }
				end, opts)
				vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
			end,
		})

		vim.diagnostic.config({
			virtual_text = true
		})
  end
}
