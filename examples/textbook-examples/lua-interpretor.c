#include <stdio.h>
#include <string.h>
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

static int l_sin (lua_State *L) {
    double d = lua_tonumber(L, 1);  /* get argument */
    lua_pushnumber(L, sin(d));  /* push result */
    return 1;  /* number of results */
}

int main (void) {
    char buff[256];
    int error;
    lua_State *L = luaL_newstate();
    luaL_openlibs(L);        /* opens the standard libraries */

    lua_pushcfunction(L, l_sin);
    lua_setglobal(L, "mysin");

    while (fgets(buff, sizeof(buff), stdin) != NULL) {
        error = luaL_loadstring(L, buff) || lua_pcall(L, 0, 0, 0);
        if (error) {
            fprintf(stderr, "%s\n", lua_tostring(L, -1));
            lua_pop(L, 1);  /* pop error message from the stack */
        }
    }
    lua_close(L);
    return 0; 
}
