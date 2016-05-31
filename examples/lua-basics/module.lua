local M = {}

local function about()
    print("***Author: Qiaobin Fu\n***Email:qiaobinf@bu.edu")
end

function M.sayhello()
    print("Hello from a new module file module.lua!")
    about()
end

return M
