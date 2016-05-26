#include <stdlib.h>
#include <string.h>

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

#include "policy.h"

/* Userdata object that will hold the policy and name. */
typedef struct {
    struct first_policy *fp;
    char      *service;
} lua_policy;

static int lpolicy_new(lua_State *L)
{
    lua_policy *lp;
    const char          *service;
    int                  destination;
    
    /* Check the arguments are valid. */
    destination = luaL_checkint(L, 1);
    service = luaL_checkstring(L, 2);

    if (service == NULL)
        luaL_error(L, "service name cannot be empty");
    
    lp = (lua_policy *)lua_newuserdata(L, sizeof(*lp));
    lp->fp    = NULL;
    lp->service = NULL;
    
    /* Add the metatable to the stack. */
    luaL_getmetatable(L, "LPolicy");
    /* Set the metatable on the userdata. */
    lua_setmetatable(L, -2);
    
    /* Create the data that comprises the userdata (the policy). */
    lp->fp      = policy_create(destination);
    lp->service = strdup(service);
    
    return 1;
}

static int lpolicy_change(lua_State *L)
{
    lua_policy *lp;
    int         new_dest;
    
    lp       = (lua_policy *)luaL_checkudata(L, 1, "LPolicy");
    new_dest = luaL_checkint(L, 2);
    policy_change(lp->fp, new_dest);
    
    return 0;
}

static int lpolicy_get_prefix(lua_State *L)
{
    lua_policy *lp;
    
    lp = (lua_policy *)luaL_checkudata(L, 1, "LPolicy");
    lua_pushinteger(L, policy_get_prefix(lp->fp));
    
    return 1;
}

static int lpolicy_getservice(lua_State *L)
{
    lua_policy *lp;
    
    lp = (lua_policy *)luaL_checkudata(L, 1, "LPolicy");
    lua_pushstring(L, lp->service);
    
    return 1;
}

static int lpolicy_destroy(lua_State *L)
{
    lua_policy *lp;
    
    lp = (lua_policy *)luaL_checkudata(L, 1, "LPolicy");
    
    if (lp->fp != NULL)
        policy_destroy(lp->fp);
    lp->fp = NULL;
    
    if (lp->service != NULL)
        free(lp->service);
    lp->service = NULL;
     
    return 0;
}

static int lpolicy_tostring(lua_State *L)
{
    lua_policy *lp;
    
    lp = (lua_policy *)luaL_checkudata(L, 1, "LPolicy");
    
    lua_pushfstring(L, "%d: %s", policy_get_prefix(lp->fp), lp->service);
    
    return 1;
}
 
static const struct luaL_Reg lpolicy_methods[] = {
    { "change",      lpolicy_change      },
    { "get_prefix",  lpolicy_get_prefix  },
    { "getservice",  lpolicy_getservice  },
    { "__gc",        lpolicy_destroy     },
    { "__tostring",  lpolicy_tostring    },
    { NULL,          NULL                },
};

static const struct luaL_Reg lpolicy_functions[] = {
    { "new", lpolicy_new    },
    { NULL,  NULL           }
};

int luaopen_lpolicy(lua_State *L)
{
    /* Create the metatable and put it on the stack. */
    luaL_newmetatable(L, "LPolicy");
    /* Duplicate the metatable on the stack (We know have 2). */
    lua_pushvalue(L, -1);
    /* 
     * Pop the first metatable off the stack and assign it to __index
     * of the second one. We set the metatable for the table to itself.
     * 
     * This is equivalent to the following in lua:
     * metatable = {}
     * metatable.__index = metatable
     */
    lua_setfield(L, -2, "__index");
    
    /* Set the methods to the metatable that should be accessed via object:func */
    //luaL_setfuncs(L, lpolicy_methods, 0);
    luaL_register(L, "lpolicy", lpolicy_methods);
    
    /* 
     * Register the object.func functions into the table that is at the top of the
     * stack. 
     */
    //luaL_newlib(L, lpolicy_functions);
    //luaL_register(L, "lpolicy", lpolicy_functions);
    
    return 1;
}
