From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCh v6] tools/perf/metricgroup: Fix printing event names of metric group with multiple events incase of overlapping events
Date: Fri, 21 Feb 2020 15:40:37 +0530
Message-ID: <20200221101037.28820-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kjain@linux.ibm.com, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jin Yao <yao.jin@linux.intel.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
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

Patch fixes the issue by adding a new bool pointer 'evlist_used' to keep
track of events which already matched with some group by setting it true.
So, we skip all used events in list when we start comparision logic.
Patch also make some changes in comparision logic, incase we get a match
miss, we discard the whole match and start again with first event id in
metric event.

With this patch:
In skylake platform:

command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1

 Performance counter stats for 'CPU(s) 0':

         3,348,415      inst_retired.any          #      0.3 CoreIPC
        11,779,026      cycles
         3,348,381      inst_retired.any          # 3348381.0
                                                    Instructions

       1.001649056 seconds time elapsed

command:# ./perf stat -M UPI,IPC sleep 1

 Performance counter stats for 'sleep 1':

         1,023,148      uops_retired.retire_slots #      1.1 UPI
           924,976      inst_retired.any
           924,976      inst_retired.any          #      0.6 IPC
         1,489,414      cpu_clk_unhalted.thread

       1.003064672 seconds time elapsed

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/util/metricgroup.c | 49 +++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 19 deletions(-)

Changelog:
v5 -> v6
- Remove bool cast
- Add Acked-by tag

v4 -> v5
- Made small fix to return from function 'metricgroup__setup_events'
  in case calloc fail

v3 -> v4
- Make 'evlist_used' a bool pointer.

v2 -> v3
- Add array in place of variable to keep track of matched events.
  Because incase we miss match in previous approach, all events will
  be rolled over in next condition. So, rather we add array and set  
  it incase that variable already match with some group.
  - Suggested by Jiri Olsa

v1 -> v2
- Rather then adding static variable in metricgroup.c,
  add a new variable in evlist itself with name 'evlist_iter'

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 02aee946b6c1..33bb138f7902 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -93,13 +93,16 @@ struct egroup {
 static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 				      const char **ids,
 				      int idnum,
-				      struct evsel **metric_events)
+				      struct evsel **metric_events,
+				      bool *evlist_used)
 {
 	struct evsel *ev;
-	int i = 0;
+	int i = 0, j = 0;
 	bool leader_found;
 
 	evlist__for_each_entry (perf_evlist, ev) {
+		if (evlist_used[j++])
+			continue;
 		if (!strcmp(ev->name, ids[i])) {
 			if (!metric_events[i])
 				metric_events[i] = ev;
@@ -107,22 +110,17 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			if (i == idnum)
 				break;
 		} else {
-			if (i + 1 == idnum) {
-				/* Discard the whole match and start again */
-				i = 0;
-				memset(metric_events, 0,
-				       sizeof(struct evsel *) * idnum);
-				continue;
-			}
-
-			if (!strcmp(ev->name, ids[i]))
-				metric_events[i] = ev;
-			else {
-				/* Discard the whole match and start again */
-				i = 0;
-				memset(metric_events, 0,
-				       sizeof(struct evsel *) * idnum);
-				continue;
+			/* Discard the whole match and start again */
+			i = 0;
+			memset(metric_events, 0,
+				sizeof(struct evsel *) * idnum);
+
+			if (!strcmp(ev->name, ids[i])) {
+				if (!metric_events[i])
+					metric_events[i] = ev;
+				i++;
+				if (i == idnum)
+					break;
 			}
 		}
 	}
@@ -144,7 +142,10 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			    !strcmp(ev->name, metric_events[i]->name)) {
 				ev->metric_leader = metric_events[i];
 			}
+			j++;
 		}
+		ev = metric_events[i];
+		evlist_used[ev->idx] = true;
 	}
 
 	return metric_events[0];
@@ -160,6 +161,13 @@ static int metricgroup__setup_events(struct list_head *groups,
 	int ret = 0;
 	struct egroup *eg;
 	struct evsel *evsel;
+	bool *evlist_used;
+
+	evlist_used = calloc(perf_evlist->core.nr_entries, sizeof(bool));
+	if (!evlist_used) {
+		ret = -ENOMEM;
+		return ret;
+	}
 
 	list_for_each_entry (eg, groups, nd) {
 		struct evsel **metric_events;
@@ -170,7 +178,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 			break;
 		}
 		evsel = find_evsel_group(perf_evlist, eg->ids, eg->idnum,
-					 metric_events);
+					 metric_events, evlist_used);
 		if (!evsel) {
 			pr_debug("Cannot resolve %s: %s\n",
 					eg->metric_name, eg->metric_expr);
@@ -194,6 +202,9 @@ static int metricgroup__setup_events(struct list_head *groups,
 		expr->metric_events = metric_events;
 		list_add(&expr->nd, &me->head);
 	}
+
+	free(evlist_used);
+
 	return ret;
 }
 
-- 
2.21.0
