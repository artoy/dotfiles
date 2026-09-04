local D = {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
    },
  },
  keys = {
    {
      "<F5>",
      function()
        require("dap").continue()
      end,
      desc = "DAP: Continue / start",
    },
    {
      "<F10>",
      function()
        require("dap").step_over()
      end,
      desc = "DAP: Step over",
    },
    {
      "<F11>",
      function()
        require("dap").step_into()
      end,
      desc = "DAP: Step into",
    },
    {
      "<F12>",
      function()
        require("dap").step_out()
      end,
      desc = "DAP: Step out",
    },
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "DAP: Toggle breakpoint",
    },
    {
      "<leader>du",
      function()
        require("dapui").toggle()
      end,
      desc = "DAP: Toggle UI",
    },
    {
      "<leader>de",
      function()
        require("dapui").eval()
      end,
      mode = { "n", "v" },
      desc = "DAP: Evaluate expression",
    },
    {
      "<leader>dr",
      function()
        require("dap").repl.open()
      end,
      desc = "DAP: Open REPL",
    },
    {
      "<leader>dq",
      function()
        require("dap").terminate()
      end,
      desc = "DAP: Terminate",
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    local function find_lldb_dap()
      local candidates = {
        vim.fn.exepath("lldb-dap"),
        vim.fn.exepath("lldb-vscode"),
      }

      -- Apple's lldb-dap is available through Xcode, but is not usually in PATH.
      if vim.fn.has("mac") == 1 and vim.fn.executable("xcrun") == 1 then
        local xcrun_path = vim.fn.system({ "xcrun", "--find", "lldb-dap" })
        if vim.v.shell_error == 0 then
          table.insert(candidates, vim.trim(xcrun_path))
        end
      end

      for _, path in ipairs(candidates) do
        if path ~= "" and vim.fn.executable(path) == 1 then
          return path
        end
      end
    end

    local lldb_dap = find_lldb_dap()
    if not lldb_dap then
      vim.notify(
        "nvim-dap: lldb-dap was not found. Install LLVM/Xcode Command Line Tools.",
        vim.log.levels.WARN
      )
      return
    end

    dap.adapters["lldb-dap"] = {
      type = "executable",
      command = lldb_dap,
      name = "lldb-dap",
    }

    local function executable()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end

    local function arguments()
      return vim.fn.split(vim.fn.input("Arguments: "))
    end

    dap.configurations.cpp = {
      {
        name = "LLDB: Launch",
        type = "lldb-dap",
        request = "launch",
        program = executable,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
      },
      {
        name = "LLDB: Launch with arguments",
        type = "lldb-dap",
        request = "launch",
        program = executable,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = arguments,
      },
      {
        name = "LLDB: Attach to process",
        type = "lldb-dap",
        request = "attach",
        pid = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
    }

    -- The same native debugger is useful for C sources as well.
    dap.configurations.c = dap.configurations.cpp
  end,
}

return D
