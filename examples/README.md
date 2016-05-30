#LuaJIT Examples

##LuaJIT FFI Library Example
The [LuaJIT FFI Library](http://luajit.org/ext_ffi.html) allows calling external C functions and using C data structures from pure Lua code.

In the folder `ffi-policy`, I created a very simple policy management library, and called by pure Lua code.

##Lua C API example
In the folder `capi-policy`, I created a very simple policy management library through Lua C APIs, which needs us to maintain a <b>*virtual stack*</b> to exchange data between C and Lua. Works with Lua 5.2.0

##Useful Online Materials
  * [Lua](http://www.lua.org/)
  * [LuaJIT](http://luajit.org/) is a Just-In-Time Compiler (JIT) for the Lua programming language.
  * [lua-users.org](http://lua-users.org) is an internet site for and by users of the programming language Lua.
