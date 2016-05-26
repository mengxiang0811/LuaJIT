#ifndef __POLICY_H__
#define __POLICY_H__

#include <stdint.h>

struct first_policy {
    int prefix;
};

struct first_policy *policy_create(int dest);
void policy_destroy(struct first_policy *fp);

void policy_change(struct first_policy *fp, int new_dest);
/*
 void policy_add(struct first_policy *fp);
*/

int policy_get_prefix(struct first_policy *fp);

#endif /* __POLICY_H__ */
