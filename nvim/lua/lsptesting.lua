--local function on_did_change(_, _, result, _, bufnr)
--  if vim.api.nvim_get_mode().mode == "n" then
--    local params = {
--      textDocument = result.textDocument,
--      contentChanges = result.contentChanges,
--    }
--    vim.lsp.buf_request(bufnr, "textDocument/didChange", params, function(_, _, result, _, bufnr)
--      vim.lsp.util.buf_diagnostics_save(bufnr, result)
--      vim.lsp.diagnostic.set_loclist(result, bufnr)
--      vim.api.nvim_command("lopen")
--    end)
--  end
--end
--
--vim.lsp.handlers["textDocument/didChange"] = on_did_change
local function on_did_open(_, _, result, _, bufnr)
  if vim.api.nvim_get_mode().mode == "n" then
    local params = {
      textDocument = result.textDocument,
      contentChanges = result.contentChanges,
    }
    vim.lsp.buf_request(bufnr, "textDocument/didOpen", params, function(_, _, result, _, bufnr)
      vim.lsp.util.buf_diagnostics_save(bufnr, result)
      vim.lsp.diagnostic.set_loclist(result, bufnr)
      vim.api.nvim_command("lopen")
    end)
  end
end

vim.lsp.handlers["textDocument/didOpen"] = on_did_open

