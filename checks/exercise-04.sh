#!/bin/bash
LC_ALL=C
printf "{\"problems\": [
        {\"name\": \"Wallace_Bits_Fast_2.cnf\", \"status\": \"SATISFIABLE\", \"total_time\": 2.57, \"search_time\": 2.34, \"search_percent\": 91.64, \"simplify_time\": 0.21, \"simplify_percent\": 8.35},
        {\"name\": \"Wallace_Bits_Fast_3.cnf\", \"status\": \"SATISFIABLE\", \"total_time\": 88.46, \"search_time\": 81.58, \"search_percent\": 92.27, \"simplify_time\": 6.84, \"simplify_percent\": 7.73},
        {\"name\": \"Wallace_Bits_Fast_7.cnf\", \"status\": \"SATISFIABLE\", \"total_time\": 2.48, \"search_time\": 1.84, \"search_percent\": 75.27, \"simplify_time\": 0.61, \"simplify_percent\": 24.72},
        {\"name\": \"coreJSONskipCollection\", \"status\": \"SATISFIABLE\", \"total_time\": 133.11, \"search_time\": 51.69, \"search_percent\": 47.01, \"simplify_time\": 58.28, \"simplify_percent\": 53.01},
        {\"name\": \"xor_op_n44_d3\", \"status\": \"UNKNOWN\", \"total_time\": 5000.01, \"search_time\": 4672.51, \"search_percent\": 93.46, \"simplify_time\": 327.06, \"simplify_percent\": 6.54}
       ]
   }" | jq -S '.problems[]| join(",")'
