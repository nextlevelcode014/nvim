require "nvchad.mappings"

local map = vim.keymap.set

-- Mappings básicos
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Salvamento rápido
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Save file" })

-- === DEBUG MAPPINGS (DAP) ===
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map("n", "<Leader>dd", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { desc = "Debugger set conditional breakpoint" })
map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

-- DAP UI
map("n", "<Leader>du", "<cmd>lua require'dapui'.toggle()<CR>", { desc = "Toggle Debug UI" })

-- === RUST SPECIFIC ===
map("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Rust: Run testables" })
map("n", "<Leader>rr", "<cmd>RustLsp runnables<CR>", { desc = "Rust: Show runnables" })
map("n", "<Leader>rd", "<cmd>RustLsp debuggables<CR>", { desc = "Rust: Show debuggables" })
map("n", "<Leader>rc", "<cmd>RustLsp openCargo<CR>", { desc = "Rust: Open Cargo.toml" })
map("n", "<Leader>rp", "<cmd>RustLsp parentModule<CR>", { desc = "Rust: Go to parent module" })
map("n", "<Leader>rm", "<cmd>RustLsp expandMacro<CR>", { desc = "Rust: Expand macro" })

-- === TESTING ===
map("n", "<Leader>tr", "<cmd>lua require('neotest').run.run()<CR>", { desc = "Run nearest test" })
map("n", "<Leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", { desc = "Run tests in file" })
map("n", "<Leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", { desc = "Debug nearest test" })
map("n", "<Leader>ts", "<cmd>lua require('neotest').run.stop()<CR>", { desc = "Stop test" })
map("n", "<Leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<CR>", { desc = "Open test output" })
map("n", "<Leader>tS", "<cmd>lua require('neotest').summary.toggle()<CR>", { desc = "Toggle test summary" })

-- === AI INTEGRATION ===
map({ "n", "v" }, "<Leader>ai", ":Gen<CR>", { desc = "AI: Generate code" })
map("n", "<Leader>ac", ":Gen Chat<CR>", { desc = "AI: Chat" })
map("n", "<Leader>ae", ":Gen Explain_Code<CR>", { desc = "AI: Explain code" })
map("n", "<Leader>ar", ":Gen Review_Code<CR>", { desc = "AI: Review code" })
map("n", "<Leader>ao", ":Gen Optimize_Code<CR>", { desc = "AI: Optimize code" })
map("n", "<Leader>at", ":Gen Add_Tests<CR>", { desc = "AI: Add tests" })

-- Codeium
map("i", "<C-g>", function() return vim.fn["codeium#Accept"]() end, { expr = true, desc = "Codeium: Accept suggestion" })
map("i", "<C-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true, desc = "Codeium: Clear suggestion" })
map("i", "<C-]>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true, desc = "Codeium: Next suggestion" })
map("i", "<C-[>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true, desc = "Codeium: Previous suggestion" })

-- === FORMATAÇÃO ===
map("n", "<Leader>fm", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file or range" })

-- === LSP ENHANCEMENTS ===
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
map("n", "K", vim.lsp.buf.hover, { desc = "Show hover info" })
map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Show signature help" })
map("n", "<Leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<Leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- === PYTHON SPECIFIC ===
map("n", "<Leader>pr", "<cmd>!python3 %<CR>", { desc = "Python: Run current file" })
map("n", "<Leader>pi", "<cmd>!python3 -i %<CR>", { desc = "Python: Run interactive" })

-- === TYPESCRIPT/JAVASCRIPT SPECIFIC ===
map("n", "<Leader>tso", "<cmd>TSToolsOrganizeImports<CR>", { desc = "TS: Organize imports" })
map("n", "<Leader>tss", "<cmd>TSToolsSortImports<CR>", { desc = "TS: Sort imports" })
map("n", "<Leader>tsr", "<cmd>TSToolsRemoveUnused<CR>", { desc = "TS: Remove unused imports" })
map("n", "<Leader>tsf", "<cmd>TSToolsFixAll<CR>", { desc = "TS: Fix all" })
map("n", "<Leader>tsa", "<cmd>TSToolsAddMissingImports<CR>", { desc = "TS: Add missing imports" })

-- Node.js execution
map("n", "<Leader>nr", "<cmd>!node %<CR>", { desc = "Node: Run current file" })

-- === C/C++ SPECIFIC ===
map("n", "<Leader>cc", "<cmd>!gcc % -o %< && ./%<<CR>", { desc = "C: Compile and run" })
map("n", "<Leader>cpp", "<cmd>!g++ % -o %< && ./%<<CR>", { desc = "C++: Compile and run" })

-- === MOVEMENT ENHANCEMENTS ===
-- Mover linhas para cima/baixo
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down in insert mode" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up in insert mode" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- === WINDOW NAVIGATION ===
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- === BUFFER MANAGEMENT ===
map("n", "<Leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<Leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<Leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- === TERMINAL ===
map("n", "<Leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Toggle horizontal terminal" })
map("n", "<Leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Toggle vertical terminal" })
map("n", "<Leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle floating terminal" })
map("t", "<C-\\>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })

-- === SEARCH AND REPLACE ===
map("n", "<Leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace word under cursor" })
map("v", "<Leader>s", ":s/", { desc = "Replace in selection" })

-- === QUICK FIXES ===
map("n", "<Leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file executable" })
map("n", "<Leader>so", "<cmd>source %<CR>", { desc = "Source current file" })
