return {
    {
        "uiiaoo/java-syntax.vim",
        config = function()
            vim.cmd [[
                highlight link javaDelimiter NONE
                highlight link javaIdentifier NONE
            ]]
        end,
        ft = "java",
    }, {
        "eiginn/iptables-vim",
        config = function()
            vim.cmd [[
                autocmd BufNewFile,BufFilePre,BufRead *.rules set filetype=iptables
            ]]
        end,
    }, {
        "tolecnal/icinga2-vim",
        config = function()
            vim.cmd [[
                autocmd BufNewFile,BufFilePre,BufRead */icinga/*/*.conf set filetype=icinga2
            ]]
        end,
    }, {
        "preservim/vim-markdown",
        config = function()
            vim.cmd [[
                let g:vim_markdown_folding_disabled = 1
                let g:vim_markdown_no_default_key_mappings = 1
                let g:vim_markdown_conceal = g:markdown_syntax_conceal
                let g:vim_markdown_conceal_code_blocks = g:markdown_syntax_conceal
                let g:vim_markdown_fenced_languages = g:markdown_fenced_languages
                let g:vim_markdown_new_list_item_indent = 0
                let g:vim_markdown_auto_insert_bullets = 0

                let g:vim_markdown_frontmatter = 1
                let g:vim_markdown_strikethrough = 1

                " enable math syntax highlight, but disable concealing
                let g:vim_markdown_math = 1
                let g:tex_conceal = ''
            ]]
        end,
        ft = "markdown",
    }, {
        "pearofducks/ansible-vim",
        config = function()
            vim.cmd [[
                let g:ansible_unindent_after_newline = 1
                let g:ansible_extra_keywords_highlight = 1
                let g:ansible_with_keywords_highlight = 'Constant'
                let g:ansible_template_syntaxes = { '*.conf.j2': 'conf', '*.rules.j2': 'iptables', '*.xml.j2': 'xml', '*.sh.j2': 'sh', '*.yml.j2': 'yaml.ansible', '*.py.j2': 'python', '*.jcfg.j2': 'conf', '*.rb.j2': 'ruby', '*iptables/*': 'iptables' }
                autocmd BufNewFile,BufFilePre,BufRead */playbooks/*.yml set filetype=yaml.ansible
            ]]
        end
    },
    "hashivim/vim-terraform",
    "mtdl9/vim-log-highlighting",
    "zah/nim.vim",
    -- CSV filetype, for :Select queries see https://github.com/mechatroner/rainbow_csv#examples-of-rbql-queries
    "mechatroner/rainbow_csv",
    -- PCRE/PYRE
    'Galicarnax/vim-regex-syntax',
    'LnL7/vim-nix',
    'PProvost/vim-ps1',
    'neoclide/jsonc.vim',
    'lilyinstarlight/vim-spl',  -- splunk search language
    'elixir-editors/vim-elixir',
    'towolf/vim-helm',
}
