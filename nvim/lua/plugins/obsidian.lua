local is_mac = package.config:sub(1,1) == "/"

local notes_path
if is_mac then
  notes_path = "/Users/toor/Obsidian/Notes"
else
  notes_path = "/home/toor/Obsidian/notes"
end

require("obsidian").setup({
  workspaces = {
    {
      name = "Notes",
      path = notes_path,
    },
  },
})

