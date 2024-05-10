return {
    {
        "jackMort/ChatGPT.nvim",
        config = function()
            require("chatgpt").setup({
                api_key_cmd = "cat " .. vim.fn.expand("$HOME/.config/openai")
            })
        end,
        lazy = false,
        keys = function()
            local function key(mode, binding, cmd, desc)
                return {
                    binding,
                    cmd,
                    mode = mode,
                    noremap = true,
                    silent = true,
                    nowait = true,
                    desc = "ChatGPT " .. desc,
                }
            end

            -- https://github.com/Robitx/gp.nvim?tab=readme-ov-file#native
            return {
                key({ "n", "v" }, "<C-g>e", "<cmd>ChatGPTRun explain_code<CR>", "Explain Code"),
                key({ "n", "i" }, "<C-g><tab>", "<cmd>ChatGPTCompleteCode<CR>", "Complete Code"),
            }
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "folke/trouble.nvim",
            "nvim-telescope/telescope.nvim"
        }
    },
    {
        "robitx/gp.nvim",
        keys = function()
            local function key(mode, binding, cmd, desc)
                return {
                    binding,
                    cmd,
                    mode = mode,
                    noremap = true,
                    silent = true,
                    nowait = true,
                    desc = "GPT " .. desc,
                }
            end

            -- https://github.com/Robitx/gp.nvim?tab=readme-ov-file#native
            return {
                -- Chat commands
                key({ "n", "i" }, "<C-g>c", "<cmd>GpChatNew<cr>", "New Chat"),
                key({ "n", "i" }, "<C-g>t", "<cmd>GpChatToggle<cr>", "Toggle Chat"),
                key({ "n", "i" }, "<C-g>f", "<cmd>GpChatFinder<cr>", "Chat Finder"),

                key("v", "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", "Visual Chat New"),
                key("v", "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", "Visual Chat Paste"),
                key("v", "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", "Visual Toggle Chat"),

                key({ "n", "i" }, "<C-g><C-x>", "<cmd>GpChatNew split<cr>", "New Chat split"),
                key({ "n", "i" }, "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", "New Chat vsplit"),
                key({ "n", "i" }, "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", "New Chat tabnew"),

                key("v", "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", "Visual Chat New split"),
                key("v", "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", "Visual Chat New vsplit"),
                key("v", "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", "Visual Chat New tabnew"),

                -- Prompt commands
                key({ "n", "i" }, "<C-g>r", "<cmd>GpRewrite<cr>", "Inline Rewrite"),
                key({ "n", "i" }, "<C-g>a", "<cmd>GpAppend<cr>", "Append (after)"),
                key({ "n", "i" }, "<C-g>b", "<cmd>GpPrepend<cr>", "Prepend (before)"),

                key("v", "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", "Visual Rewrite"),
                key("v", "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", "Visual Append (after)"),
                key("v", "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", "Visual Prepend (before)"),
                key("v", "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", "Implement selection"),

                key({ "n", "i" }, "<C-g>gp", "<cmd>GpPopup<cr>", "Popup"),
                key({ "n", "i" }, "<C-g>ge", "<cmd>GpEnew<cr>", "GpEnew"),
                key({ "n", "i" }, "<C-g>gn", "<cmd>GpNew<cr>", "GpNew"),
                key({ "n", "i" }, "<C-g>gv", "<cmd>GpVnew<cr>", "GpVnew"),
                key({ "n", "i" }, "<C-g>gt", "<cmd>GpTabnew<cr>", "GpTabnew"),

                key("v", "<C-g>gp", ":<C-u>'<,'>GpPopup<cr>", "Visual Popup"),
                key("v", "<C-g>ge", ":<C-u>'<,'>GpEnew<cr>", "Visual GpEnew"),
                key("v", "<C-g>gn", ":<C-u>'<,'>GpNew<cr>", "Visual GpNew"),
                key("v", "<C-g>gv", ":<C-u>'<,'>GpVnew<cr>", "Visual GpVnew"),
                key("v", "<C-g>gt", ":<C-u>'<,'>GpTabnew<cr>", "Visual GpTabnew"),

                key({ "n", "i" }, "<C-g>x", "<cmd>GpContext<cr>", "Toggle Context"),
                key("v", "<C-g>x", ":<C-u>'<,'>GpContext<cr>", "Visual Toggle Context"),

                key({ "n", "i", "v", "x" }, "<C-g>s", "<cmd>GpStop<cr>", "Stop"),
                key({ "n", "i", "v", "x" }, "<C-g>n", "<cmd>GpNextAgent<cr>", "Next Agent"),
            }
        end,
        config = function()
            require("gp").setup({
                openai_api_key = { "cat", vim.fn.expand("$HOME/.config/openai") },

                -- remove emojis
                chat_user_prefix = "## Question",
                chat_assistant_prefix = { "## Answer", "[{{agent}}]" },
                command_prompt_prefix_template = "Ask {{agent}}: ",
            }
            )
        end,
    },
}
