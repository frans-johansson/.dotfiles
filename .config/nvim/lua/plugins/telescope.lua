-- Telescope fuzzy finding (all the things)
return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },
        },
        config = function()

            require('telescope').setup {
                defaults = {
                    mappings = {
                        i = {
                            ['<C-u>'] = false,
                            ['<C-d>'] = false,
                        },
                    },
                },
            }

            -- Enable telescope fzf native, if installed
            pcall(require('telescope').load_extension, 'fzf')

            local map = require('helpers.keys').map
            map('n', '<leader>?', require('telescope.builtin').oldfiles, '[?] Find recently opened files')
            map('n', '<leader><space>', require('telescope.builtin').buffers, '[ ] Find existing buffers')
            map('n', '<leader>/', function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, '[/] Fuzzily search in current buffer')

            map('n', '<leader>sf', require('telescope.builtin').find_files, '[S]earch [F]iles')
            map('n', '<leader>sh', require('telescope.builtin').help_tags, '[S]earch [H]elp')
            map('n', '<leader>sw', require('telescope.builtin').grep_string, '[S]earch current [W]ord')
            map('n', '<leader>sg', require('telescope.builtin').live_grep, '[S]earch by [G]rep')
            map('n', '<leader>sd', require('telescope.builtin').diagnostics, '[S]earch [D]iagnostics')
            map('n', '<leader>sb', require('telescope.builtin').buffers, '[S]earch [B]uffers')

            map('n', '<C-p>', require('telescope.builtin').keymaps, 'Search keymaps')

            -- Set up project managment
            -- require('project_nvim').setup()
            -- require('telescope').load_extension('projects')
        end
    },
}
