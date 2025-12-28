-- Test file for Claude MCP plugin
-- Open this file in Neovim and try the following:

-- Test 1: Ask a question
-- Command: :ClaudeAsk What is Lua?
-- Or: Press <leader>ca

-- Test 2: Get suggestion
-- Command: :ClaudeSuggest
-- Or: Press <leader>cs

-- Test 3: Explain this function
-- 1. Select the function below in visual mode
-- 2. Press <leader>ce
-- 3. Ask: "What does this function do?"

local function fibonacci(n)
  if n <= 1 then
    return n
  end
  return fibonacci(n - 1) + fibonacci(n - 2)
end

-- Test 4: Check server status
-- Command: :ClaudeMCPStart
-- Check :messages for "Claude MCP server started"

print("Claude MCP Test File - Ready!")
print("Try the commands above to test the integration")
