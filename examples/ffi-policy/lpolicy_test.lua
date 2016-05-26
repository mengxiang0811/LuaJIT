-- Load the LuaJIT FFI library.
ffi = require 'ffi'

-- -- Declare the C function.
ffi.cdef[[
struct first_policy *policy_create(int dest);
void policy_destroy(struct first_policy *fp);
void policy_change(struct first_policy *fp, int new_dest);
int policy_get_prefix(struct first_policy *fp);
]]
-- -- Ask LuaJIT to load the library that contains the function.
lpolicy = ffi.load('lpolicy')

print("hello world")
-- -- Call the function.
p = lpolicy.policy_create(123456)
print("val=" .. lpolicy.policy_get_prefix(p))

lpolicy.policy_change(p, 654321)
print(p)
print("new val=" .. lpolicy.policy_get_prefix(p))
