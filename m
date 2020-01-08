From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH] tools/perf/metricgroup: Fix printing event names of metric group with multiple events incase of overlapping events
Date: Wed,  8 Jan 2020 12:28:44 +0530
Message-ID: <20200108065844.4030-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kjain@linux.ibm.com, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jin Yao <yao.jin@linux.intel.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Commit f01642e4912b ("perf metricgroup: Support multiple
events for metricgroup") introduced support for multiple events
in a metric group. But with the current upstream, metric events
names are not printed properly incase we try to run multiple
metric groups with overlapping event.

With current upstream version, incase of overlapping metric events
issue is, we always start our comparision logic from start.
So, the events which already matched with some metric group also
take part in comparision logic. Because of that when we have overlapping
events, we end up matching current metric group event with already matched
one.

For example, in skylake machine we have metric event CoreIPC and
Instructions. Both of them need 'inst_retired.any' event value.
As events in Instructions is subset of events in CoreIPC, they
endup in pointing to same 'inst_retired.any' value.

In skylake platform:

command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1

 Performance counter stats for 'CPU(s) 0':

     1,254,992,790      inst_retired.any          # 1254992790.0
						    Instructions
                                                  #      1.3 CoreIPC
       977,172,805      cycles
     1,254,992,756      inst_retired.any

       1.000802596 seconds time elapsed

command:# sudo ./perf stat -M UPI,IPC sleep 1

   Performance counter stats for 'sleep 1':

           948,650      uops_retired.retire_slots
           866,182      inst_retired.any          #      0.7 IPC
           866,182      inst_retired.any
         1,175,671      cpu_clk_unhalted.thread

Patch fixes the issue by adding a static variable 'iterator_perf_evlist'
to keep track of events which already matched with some group. It points
to event in perf_evlist from where next match should start. Because we
need to make sure, we match correct set of events belongs to
corresponding metric group.

With this patch:
In skylake platform:

command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1

 Performance counter stats for 'CPU(s) 0':

       149,481,533      inst_retired.any          #      0.8 CoreIPC
       186,244,218      cycles
       149,479,362      inst_retired.any          # 149479362.0
							Instructions

       1.001655885 seconds time elapsed

command:# ./perf stat -M UPI,IPC sleep 1
 Performance counter stats for 'CPU(s) 0':

        16,858,849      uops_retired.retire_slots #      1.3 UPI
        12,529,178      inst_retired.any
        12,529,558      inst_retired.any          #      0.3 IPC
        39,936,071      cpu_clk_unhalted.thread

       1.001413978 seconds time elapsed


Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/util/metricgroup.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 35e151b8359b..58889b0496fb 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -90,16 +90,21 @@ struct egroup {
 	const char *metric_unit;
 };
 
+static int iterator_perf_evlist;
+
 static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 				      const char **ids,
 				      int idnum,
 				      struct evsel **metric_events)
 {
 	struct evsel *ev;
-	int i = 0;
+	int i = 0, j = 0;
 	bool leader_found;
 
 	evlist__for_each_entry (perf_evlist, ev) {
+		j++;
+		if (j <= iterator_perf_evlist)
+			continue;
 		if (!strcmp(ev->name, ids[i])) {
 			if (!metric_events[i])
 				metric_events[i] = ev;
@@ -146,6 +151,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			}
 		}
 	}
+	iterator_perf_evlist = j;
 
 	return metric_events[0];
 }
-- 
2.21.0
