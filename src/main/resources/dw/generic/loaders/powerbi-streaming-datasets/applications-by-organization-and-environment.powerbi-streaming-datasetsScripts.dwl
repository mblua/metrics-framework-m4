%dw 2.0
output application/json
---
payload ++
{	
	"host": p('powerbi-streaming-datasets.host'),
	"port": p('powerbi-streaming-datasets.port'),
	"url": ""
}