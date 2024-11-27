return {
	'ackeraa/todo.nvim',
	config = function()
		require("todo").setup {
			opts = {
				file_path = "/home/zach/.config/nvim/todolist.txt"
			},
		}
	end
}
