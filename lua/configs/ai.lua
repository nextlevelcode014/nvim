-- Configuração para IA Local (Ollama + Gen.nvim)

local M = {}

-- Configurar prompts customizados para Gen.nvim
M.setup_gen_prompts = function()
  require("gen").prompts["Explain_Code"] = {
    prompt = "Explain the following code in detail, including what it does, how it works, and any potential improvements:\n\n$text",
    replace = false,
  }

  require("gen").prompts["Review_Code"] = {
    prompt = "Review the following code for potential bugs, security issues, performance problems, and suggest improvements:\n\n$text",
    replace = false,
  }

  require("gen").prompts["Optimize_Code"] = {
    prompt = "Optimize the following code for better performance, readability, and maintainability. Provide the improved version:\n\n$text",
    replace = true,
  }

  require("gen").prompts["Add_Tests"] = {
    prompt = "Generate comprehensive unit tests for the following code. Include edge cases and error handling:\n\n$text",
    replace = false,
  }

  require("gen").prompts["Fix_Code"] = {
    prompt = "Fix any bugs or issues in the following code and explain the changes:\n\n$text",
    replace = true,
  }

  require("gen").prompts["Document_Code"] = {
    prompt = "Add comprehensive documentation and comments to the following code. Include docstrings for functions and classes:\n\n$text",
    replace = true,
  }

  require("gen").prompts["Refactor_Code"] = {
    prompt = "Refactor the following code to improve its structure, readability, and maintainability while preserving functionality:\n\n$text",
    replace = true,
  }

  require("gen").prompts["Convert_Language"] = {
    prompt = "Convert the following code to $input language while maintaining the same functionality:\n\n$text",
    replace = true,
  }

  require("gen").prompts["Create_API"] = {
    prompt = "Create a REST API endpoint for the following functionality. Include proper error handling, validation, and documentation:\n\n$text",
    replace = false,
  }

  require("gen").prompts["SQL_Query"] = {
    prompt = "Generate an optimized SQL query based on the following requirements:\n\n$text",
    replace = false,
  }

  -- Prompts específicos por linguagem

  -- Python
  require("gen").prompts["Python_Class"] = {
    prompt = "Create a Python class based on the following requirements. Include proper initialization, methods, and docstrings:\n\n$text",
    replace = false,
  }

  require("gen").prompts["Python_FastAPI"] = {
    prompt = "Create a FastAPI endpoint based on the following requirements. Include proper type hints, validation, and error handling:\n\n$text",
    replace = false,
  }

  -- TypeScript/React
  require("gen").prompts["React_Component"] = {
    prompt = "Create a React functional component with TypeScript based on the following requirements. Include proper props typing and hooks usage:\n\n$text",
    replace = false,
  }

  require("gen").prompts["TypeScript_Interface"] = {
    prompt = "Create TypeScript interfaces and types based on the following data structure or requirements:\n\n$text",
    replace = false,
  }

  -- Rust
  require("gen").prompts["Rust_Struct"] = {
    prompt = "Create a Rust struct with appropriate methods and trait implementations based on the following requirements:\n\n$text",
    replace = false,
  }

  require("gen").prompts["Rust_Error_Handling"] = {
    prompt = "Improve the error handling in the following Rust code using proper Result types and error propagation:\n\n$text",
    replace = true,
  }

  -- C/C++
  require("gen").prompts["C_Function"] = {
    prompt = "Create a C function with proper memory management and error handling based on the following requirements:\n\n$text",
    replace = false,
  }
end

-- Configurar modelos disponíveis
M.available_models = {
  "codellama",
  "deepseek-coder:1.3b",
  "codellama:13b",
  "codellama:34b",
  "deepseek-coder",
  "deepseek-coder:6.7b",
  "starcoder2",
  "phi3",
  "llama3",
  "mistral",
  "qwen2.5-coder",
}

-- Função para trocar modelo
M.switch_model = function(model)
  if model and vim.tbl_contains(M.available_models, model) then
    require("gen").setup {
      model = model,
      display_mode = "float",
      show_prompt = false,
      show_model = true,
      no_auto_close = false,
      init = function(options)
        pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
      end,
      command = function(options)
        local body = {
          model = options.model,
          prompt = options.prompt,
          stream = true,
        }
        return "curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d '"
          .. vim.json.encode(body)
          .. "'"
      end,
      debug = false,
    }
    vim.notify("Switched to model: " .. model, vim.log.levels.INFO)
  else
    vim.notify("Model not available: " .. (model or "nil"), vim.log.levels.WARN)
    vim.notify("Available models: " .. table.concat(M.available_models, ", "), vim.log.levels.INFO)
  end
end

-- Função para listar modelos instalados
M.list_installed_models = function()
  local handle = io.popen "ollama list 2>/dev/null | tail -n +2 | awk '{print $1}' | grep -v '^$'"
  if handle then
    local result = handle:read "*a"
    handle:close()

    local models = {}
    for model in result:gmatch "[^\r\n]+" do
      table.insert(models, model)
    end

    if #models > 0 then
      vim.ui.select(models, {
        prompt = "Select AI model:",
        format_item = function(item)
          return item
        end,
      }, function(choice)
        if choice then
          M.switch_model(choice)
        end
      end)
    else
      vim.notify("No Ollama models found. Install with: ollama pull codellama", vim.log.levels.WARN)
    end
  else
    vim.notify("Ollama not available. Please install Ollama first.", vim.log.levels.ERROR)
  end
end

-- Configurar keymaps específicos para IA
M.setup_keymaps = function()
  local map = vim.keymap.set

  -- Debug: verificar se a função está sendo chamada
  vim.notify("Setting up AI keymaps...", vim.log.levels.INFO)

  -- Menu de seleção de modelo
  map("n", "<Leader>am", M.list_installed_models, { desc = "AI: Select model" })

  -- Prompts específicos (modo visual)
  map("v", "<Leader>ae", ":Gen Explain_Code<CR>", { desc = "AI: Explain selected code" })
  map("v", "<Leader>ar", ":Gen Review_Code<CR>", { desc = "AI: Review selected code" })
  map("v", "<Leader>ao", ":Gen Optimize_Code<CR>", { desc = "AI: Optimize selected code" })
  map("v", "<Leader>af", ":Gen Fix_Code<CR>", { desc = "AI: Fix selected code" })
  map("v", "<Leader>ad", ":Gen Document_Code<CR>", { desc = "AI: Document selected code" })
  map("v", "<Leader>aR", ":Gen Refactor_Code<CR>", { desc = "AI: Refactor selected code" })

  -- Também adicionar em modo normal para funcionar com linha atual
  map("n", "<Leader>ae", "V:Gen Explain_Code<CR>", { desc = "AI: Explain current line" })
  map("n", "<Leader>ar", "V:Gen Review_Code<CR>", { desc = "AI: Review current line" })
  map("n", "<Leader>ao", "V:Gen Optimize_Code<CR>", { desc = "AI: Optimize current line" })
  map("n", "<Leader>af", "V:Gen Fix_Code<CR>", { desc = "AI: Fix current line" })
  map("n", "<Leader>ad", "V:Gen Document_Code<CR>", { desc = "AI: Document current line" })
  map("n", "<Leader>aR", "V:Gen Refactor_Code<CR>", { desc = "AI: Refactor current line" })

  -- Prompts por linguagem
  map("n", "<Leader>apc", ":Gen Python_Class<CR>", { desc = "AI: Create Python class" })
  map("n", "<Leader>apf", ":Gen Python_FastAPI<CR>", { desc = "AI: Create FastAPI endpoint" })
  map("n", "<Leader>arc", ":Gen React_Component<CR>", { desc = "AI: Create React component" })
  map("n", "<Leader>ati", ":Gen TypeScript_Interface<CR>", { desc = "AI: Create TypeScript interface" })
  map("n", "<Leader>ars", ":Gen Rust_Struct<CR>", { desc = "AI: Create Rust struct" })
  map("n", "<Leader>are", ":Gen Rust_Error_Handling<CR>", { desc = "AI: Improve Rust error handling" })
  map("n", "<Leader>acf", ":Gen C_Function<CR>", { desc = "AI: Create C function" })

  -- Keymap para listar todos os prompts disponíveis
  map("n", "<Leader>al", ":Gen<CR>", { desc = "AI: List all prompts" })
end

-- Função para retornar a configuração
M.get_gen_config = function()
  return {
    model = "codellama", -- Modelo padrão
    display_mode = "float",
    show_prompt = false,
    show_model = true,
    no_auto_close = false,
    init = function(options)
      pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
    end,
    command = function(options)
      local body = {
        model = options.model,
        prompt = options.prompt,
        stream = true,
      }
      return "curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d '"
        .. vim.json.encode(body)
        .. "'"
    end,
    debug = false,
    -- Importante: inicializar os prompts após a configuração
    list = {},
  }
end

-- Função para debug - verificar keymaps carregados
M.check_keymaps = function()
  local keymaps = vim.api.nvim_get_keymap "n"
  local ai_keymaps = {}

  for _, keymap in pairs(keymaps) do
    if keymap.lhs and string.match(keymap.lhs, "<Leader>a") then
      table.insert(ai_keymaps, {
        key = keymap.lhs,
        desc = keymap.desc or "No description",
        rhs = keymap.rhs or keymap.callback,
      })
    end
  end

  if #ai_keymaps > 0 then
    print "AI Keymaps loaded:"
    for _, km in pairs(ai_keymaps) do
      print("  " .. km.key .. " -> " .. km.desc)
    end
  else
    print "No AI keymaps found!"
  end

  return ai_keymaps
end

-- A função setup configura tudo
M.setup = function()
  -- Primeiro configurar o Gen.nvim com as configurações básicas
  local config = M.get_gen_config()
  require("gen").setup(config)

  -- Aguardar um pouco para o plugin carregar
  vim.defer_fn(function()
    -- Depois configurar os prompts personalizados
    M.setup_gen_prompts()

    -- E por último os keymaps
    M.setup_keymaps()

    -- Confirmar que os keymaps foram criados
    vim.notify("AI keymaps loaded successfully!", vim.log.levels.INFO)
  end, 100)
end

return M
