#include <stdio.h>
#include <string.h>
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

#include <dirent.h>
#include <errno.h>
#include <string.h>

static int l_dir (lua_State *L) {
    DIR *dir;
    struct dirent *entry;
    int i;
    const char *path = luaL_checkstring(L, 1);
    /* open directory */
    dir = opendir(path);
    if (dir == NULL) {  /* error opening the directory? */
        lua_pushnil(L);  /* return nil... */
        lua_pushstring(L, strerror(errno));  /* and error message */
        return 2;  /* number of results */
    }
    /* create result table */
    lua_newtable(L);
    i = 1;
    while ((entry = readdir(dir)) != NULL) {
        lua_pushnumber(L, i++);  /* push key */
        lua_pushstring(L, entry->d_name);  /* push value */
        lua_settable(L, -3);
    }
    closedir(dir);
    return 1;  /* table is already on top */
}

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

    lua_pushcfunction(L, l_dir);
    lua_setglobal(L, "mydir");

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
