--lpolicy = require("lpolicy")
package.loadlib("./build/lpolicy.dylib", "luaopen_lpolicy")()

print("hello world")
--p = lpolicy.new(123456, "EMAIL")
--print("val=" .. p:get_prefix())

--p:change(654321)
--print(p)

