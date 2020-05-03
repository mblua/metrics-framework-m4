%dw 2.0
output application/json
---
payload map (organization,index) -> 
{
    businessGroup:organization.businessGroup,
    roleGroups: organization.coreServicesData.rolegroups
}
