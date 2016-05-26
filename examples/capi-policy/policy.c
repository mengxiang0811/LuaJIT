#include <stdlib.h>
#include "policy.h"

struct first_policy *policy_create(int dest)
{
    struct first_policy *fp;
    
    fp = malloc(sizeof(*fp));
    fp->prefix = dest;    
    
    return fp;
}

void policy_destroy(struct first_policy *fp)
{
    if (fp == NULL)
        return;
    
    free(fp);
}

void policy_change(struct first_policy *fp, int new_dest)
{
    if (fp == NULL)
        return;

    fp->prefix = new_dest;
}

/*
void policy_add(struct first_policy *fp)
{
    if (fp == NULL)
        return;
}
*/

int policy_get_prefix(struct first_policy *fp)
{
    if (fp == NULL)
        return 0;

    return fp->prefix;
}
