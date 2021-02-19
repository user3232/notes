
# Load tests

Load test can differentiate some features implementations.
Typically by comparing requests/second factors in heavy
load situations.

Tests uses http request generator and counters measuring
requests times, data passed, etc. to prepare summary.

simple comand line load test executor can be:

- [siege](http://manpages.ubuntu.com/manpages/trusty/man1/siege.1.html)
  - [example usage here](https://www.interserver.net/tips/kb/http-load-testing-siege/)
  - https://www.linode.com/docs/tools-reference/tools/load-testing-with-siege/
- other open tools [are here](https://www.digitalocean.com/community/tutorials/an-introduction-to-load-testing)
- https://serverfault.com/questions/2107/tools-for-load-testing-http-servers
- https://serverfault.com/questions/350454/how-do-you-do-load-testing-and-capacity-planning-for-web-sites


## Example

```console
$ sudo apt-get install siege -y
...
$ # 20 seconds (t20s)
$ # 4 concurent clients (-c)
$
$ siege -c 4 -t20s 'https://localhost:5001/api/questions?includeAnswers=true&opts=sql'
** SIEGE 4.0.4
** Preparing 4 concurrent users for battle.
The server is now under siege...
Lifting the server siege...
Transactions:		         513 hits
Availability:		      100.00 %
Elapsed time:		       19.73 secs
Data transferred:	        0.42 MB
Response time:		        0.15 secs
Transaction rate:	       26.00 trans/sec
Throughput:		        0.02 MB/sec
Concurrency:		        3.93
Successful transactions:         513
Failed transactions:	           0
Longest transaction:	        0.32
Shortest transaction:	        0.06

$ siege -c 4 -t20s 'https://localhost:5001/api/questions?includeAnswers=true&opts=none'
** SIEGE 4.0.4
** Preparing 4 concurrent users for battle.
The server is now under siege...
Lifting the server siege...
Transactions:		         300 hits
Availability:		      100.00 %
Elapsed time:		       19.98 secs
Data transferred:	        0.25 MB
Response time:		        0.26 secs
Transaction rate:	       15.02 trans/sec
Throughput:		        0.01 MB/sec
Concurrency:		        3.97
Successful transactions:         300
Failed transactions:	           0
Longest transaction:	        0.33
Shortest transaction:	        0.21
 
```