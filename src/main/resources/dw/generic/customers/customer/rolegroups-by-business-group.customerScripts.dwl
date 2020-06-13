%dw 2.0
var rolegroups = "cba80244-d52a-4733-87a1-f1df66690ee4,065ca283-ddc3-4fb5-8ad3-21521b4576d1,a60accc6-4b41-4195-8afa-82f4d858a248" splitBy "," 
output application/json
---
payload - ("url") - ("data") ++
{	
    "data": flatten(payload.data map ((organization,index) -> 
    (organization.roleGroups filter (
           (role, index) -> 
                    (!isEmpty(rolegroups filter ((item, index) -> 
                item == role.role_group_id 
                ))) 
       ) map (importantRole,index) ->
        {
            "rolegroup-name": importantRole.name,
            "total-users": importantRole.user_count,
            "business-group": organization.businessGroup,
            timestamp: (now() as String {format: "yyyy-MM-dd'T'00:00:00.000"}),
        })
        + 
        {
            "rolegroup-name": "Users",
            "total-users": organization.totalUsers,
            "business-group": organization.businessGroup,
            timestamp: (now() as String {format: "yyyy-MM-dd'T'00:00:00.000"}),
        }
    
    ) ),
	"url": "beta/lalala"
}