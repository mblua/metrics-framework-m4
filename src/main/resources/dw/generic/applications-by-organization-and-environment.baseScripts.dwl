%dw 2.0
output application/json
---
{	
	"metric-id":"applications-by-organization-and-environment",
	"data": 
   // (
        vars.rawData map (organization, index) ->
         organization.runtimeManagerData.armApps map  
                ( 
                    (environment, index) -> 
                    {
"business-group":organization.businessGroup,
                       "timestamp": now() as String {format: "yyyy-MM-dd'T'00:00:00.000"},
                       "environment": environment.environment,
                       "total-applications":
                       //1
                        
sizeOf
                            (
                       (environment.data.data map (application, index) -> 
                                    { 
                                        name: application.name, 
                                    uptime: application.uptime 
                                    } 
                                ) 
groupBy ($.name) mapObject 
                            ((value, key, index) ->  
                            ( 
                                { 
                                    (value[0].name):  
                                        if(sizeOf(value)>1) 
                                            uptime: value reduce ($.uptime + $$.uptime) 
                                        else 
                                        uptime:value[0].uptime  
                                } 
                            )
                            ) 
                             )   






                    }
                ) filter ((item, index) -> (!isEmpty(item) ))  reduce ($ ++ $$) 
       
}