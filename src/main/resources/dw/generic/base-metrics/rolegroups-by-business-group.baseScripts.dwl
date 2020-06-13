%dw 2.0
output application/json
---
{
    "metric-id":"rolegroups-by-business-group",
	"data": 
    (
        vars.rawData map (organization,index) -> 
        {
            "businessGroup": organization.businessGroup,
            "roleGroups": organization.coreServicesData.rolegroups,
            "totalUsers": sizeOf(organization.coreServicesData.users)
        }
    )
}