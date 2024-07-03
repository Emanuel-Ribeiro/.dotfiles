-- personal shit
vim.g.mapleader = " "

-- abre o "explorador de arquivos"
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move o conteudo selecionado no modo visual pra cima ou pra baixo
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- copia o conteudo selecionado no modo visual para o ctrl v
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")

-- cola o conteudo que esta no registro deletando o texto selecionado no modo visual sem que o texto deletado substitua o registro
vim.keymap.set("x", "<leader>p", "\"_dP")

-- deleta sem colocar o conteudo no registro
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- copia do cursor até o final da linha e coloca no registro
vim.keymap.set("n", "Y", "yg$")

-- junta a linha de baixo no final da linha sem mover o cursor
vim.keymap.set("n", "J", "mzJ`z")

-- rola a tela meia pagina para cima ou para baixo e deixa o cursor no meio da tela
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- sai do modo insert
vim.keymap.set("i", "jj", "<Esc>")

-- remap pra scrollar sem escaralhar a posiçao do cursor com word wrap ligado
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- desabilitando o modo de comando deepweb do vim
vim.keymap.set("n", "Q", "<nop>")

-- usa o lsp pra formatar o arquivo
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format()
end)

-- substitui todas as ocorrencias da palavra em que o cursor estiver em cima
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- da permissao de execução para o arquivo atual
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
-- end personal shit

-- Fterm
vim.api.nvim_set_keymap("n", "<leader>tt", ":lua require('Fterm').toggle()<CR>", {noremap=true})
vim.api.nvim_set_keymap("t", "<leader>tt", '<C-\\><C-n>:lua require("Fterm").toggle()<CR>', {noremap=true})

-- twilight
vim.api.nvim_set_keymap("n", "tw", ":Twilight<enter>", {noremap=false})

-- buffers
vim.api.nvim_set_keymap("n", "tk", ":blast<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "tj", ":bfirst<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "th", ":bprev<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "tl", ":bnext<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "td", ":bdelete<enter>", {noremap=false})

-- files
vim.api.nvim_set_keymap("n", "QQ", ":q!<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "WW", ":w!<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "E", "$", {noremap=false})
vim.api.nvim_set_keymap("n", "B", "^", {noremap=false})
vim.api.nvim_set_keymap("n", "TT", ":TransparentToggle<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "ss", ":noh<CR>", {noremap=true})

-- Noice
vim.api.nvim_set_keymap("n", "<leader>nn", ":Noice dismiss<CR>", {noremap=true})

vim.keymap.set("n", "<leader>ee", "<cmd>GoIfErr<cr>",
  {silent = true, noremap = true}
)
