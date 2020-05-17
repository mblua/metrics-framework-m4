%dw 2.0
//studio-begin
fun getProperty(propertyName) = Mule::p(propertyName)
//studio-end
//playground-begin
/*fun getProperty(propertyName) = getPropertyFromObject(payload,propertyName)
fun getPropertyFromObject(object,path) = getPropertyFromObject(object[analizePath(path).actualElement],analizePath(path).newPath) default object

fun analizePath(path) = {
    originalPath:path,
    newPath: ((path splitBy  ".") - (path splitBy  ".")[0]) reduce ( $$ ++ "." ++ $),
    actualElement: (path splitBy  ".")[0]
}

*/
//playground-end

var loaderPropertiesPath = "generic.metrics-loaders." ++ getProperty("generic.loader")

var customerPropertiesPath = "generic.metrics-customers." ++ getProperty("generic.customer")

var baseMetrics = getProperty("generic.metrics-base.available") splitBy "," map ((item, index) -> 
{
    id: item,
    scripts: getProperty("generic.metrics-base." ++ item ++ ".scripts") splitBy  ",",
    executionResult: null
}
)

var loaderMetrics = getProperty(loaderPropertiesPath ++ ".available") splitBy "," map ((item, index) -> 
{
    id: item,
    scripts: getProperty    
(loaderPropertiesPath ++ "." ++ item ++ ".scripts")   
    splitBy  ","
}
)

var customerMetrics = getProperty(customerPropertiesPath ++ ".available") splitBy "," map ((item, index) -> 
{
    id: item,
    scripts: getProperty    
(customerPropertiesPath ++ "." ++ item ++ ".scripts")   
    splitBy  ","
}
)
output application/json
---
log("WARNING",customerMetrics)