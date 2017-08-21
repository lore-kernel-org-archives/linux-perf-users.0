From: sathnaga@linux.vnet.ibm.com
Subject: [PATCH v3 0/2] Fixup for discontiguous/sparse numa nodes
Date: Mon, 21 Aug 2017 15:45:40 +0530
Message-ID: <cover.1503310062.git.sathnaga@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: srikar@linux.vnet.ibm.com, bala24@linux.vnet.ibm.com, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

Certain systems would have sparse/discontinguous
numa nodes.
perf bench numa doesnt work well on such nodes.
1. It shows wrong values.
2. It can hang.
3. It can show redundant information for non-existant nodes.

 #numactl -H
available: 2 nodes (0,8)
node 0 cpus: 0 1 2 3 4 5 6 7
node 0 size: 61352 MB
node 0 free: 57168 MB
node 8 cpus: 8 9 10 11 12 13 14 15
node 8 size: 65416 MB
node 8 free: 36593 MB
node distances:
node   0   8
  0:  10  40
  8:  40  10

Scenario 1:

Before Fix:
 # perf bench numa mem --no-data_rand_walk -p 2 -t 20 -G 0 -P 3072 -T 0 -l 50 -c -s 1000
...
...
 # 40 tasks will execute (on 9 nodes, 16 CPUs): ----> Wrong number of nodes
...
 #    2.0%  [0.2 mins]  1/1   0/0   0/0   0/0   0/0   0/0   0/0   0/0   4/1  [ 4/2 ] l:  0-0   (  0) ----> Shows info on non-existant nodes.

After Fix:
 # ./perf bench numa mem --no-data_rand_walk -p 2 -t 20 -G 0 -P 3072 -T 0 -l 50 -c -s 1000
...
...
 # 40 tasks will execute (on 2 nodes, 16 CPUs):
... 
 #    2.0%  [0.2 mins]  9/1   0/0  [ 9/1 ] l:  0-0   (  0)
 #    4.0%  [0.4 mins] 21/2  19/1  [ 2/3 ] l:  0-1   (  1) {1-2}

Scenario 2:

Before Fix:
 # perf bench numa all
 # Running numa/mem benchmark...
....
...
 # Running RAM-bw-remote, "perf bench numa mem -p 1 -t 1 -P 1024 -C 0 -M 1 -s 20 -zZq --thp  1 --no-data_rand_walk"
perf: bench/numa.c:306: bind_to_memnode: Assertion `!(ret)' failed. ------------> Got hung

After Fix:
 # ./perf bench numa all
 # Running numa/mem benchmark...
....
...
 # Running RAM-bw-remote, "perf bench numa mem -p 1 -t 1 -P 1024 -C 0 -M 1 -s 20 -zZq --thp  1 --no-data_rand_walk"

 # NOTE: ignoring bind NODEs starting at NODE#1
 # NOTE: 0 tasks mem-bound, 1 tasks unbound
         20.017 secs slowest (max) thread-runtime
         20.000 secs fastest (min) thread-runtime
         20.006 secs average thread-runtime
          0.043 % difference between max/avg runtime
        413.794 GB data processed, per thread
        413.794 GB data processed, total
          0.048 nsecs/byte/thread runtime
         20.672 GB/sec/thread speed
         20.672 GB/sec total speed

Changes in v2:
Fixed review comments for function names and alloc failure handle

Changes in v3:
Coding Style fixes.


Satheesh Rajendran (2):
  perf/bench/numa: Add functions to detect sparse numa nodes
  perf/bench/numa: Handle discontiguous/sparse numa nodes

 tools/perf/bench/numa.c | 61 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 7 deletions(-)

-- 
2.7.4
