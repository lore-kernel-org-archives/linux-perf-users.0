From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH] tools/perf/metricgroup: Fix printing event names of metric group with multiple events
Date: Wed, 20 Nov 2019 14:10:59 +0530
Message-ID: <20191120084059.24458-1-kjain@linux.ibm.com>
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
names are not printed properly

In power9 platform:
command:# ./perf stat --metric-only -M translation -C 0 -I 1000 sleep 2
     1.000208486
     2.000368863
     2.001400558

Similarly in skylake platform:
command:./perf stat --metric-only -M Power -I 1000
     1.000579994
     2.002189493

With current upstream version, issue is with event name comparison
logic in find_evsel_group(). Current logic is to compare events
belonging to a metric group to the events in perf_evlist.
Since the break statement is missing in the loop used for comparison
between metric group and perf_evlist events, the loop continues to
execute even after getting a pattern match, and end up in discarding
the matches.
Incase of single metric event belongs to metric group, its working fine,
because in case of single event once it compare all events it reaches to
end of perf_evlist.

Example for single metric event in power9 platform
command:# ./perf stat --metric-only  -M branches_per_inst -I 1000 sleep 1
     1.000094653                  0.2
     1.001337059                  0.0

Patch fixes the issue by making sure once we found all events
belongs to that metric event matched in find_evsel_group(), we
successfully break from that loop by adding corresponding condition.

With this patch:
In power9 platform:

command:# ./perf stat --metric-only -M translation -C 0 -I 1000 sleep 2
result:#           time derat_4k_miss_rate_percent  derat_4k_miss_ratio
     derat_miss_ratio derat_64k_miss_rate_percent derat_64k_miss_ratio
         dslb_miss_rate_percent islb_miss_rate_percent
     1.000135672                         0.0                  0.3
                  1.0                          0.0                  0.2
                 0.0                     0.0
     2.000380617                         0.0                  0.0
                                              0.0                  0.0
                0.0                     0.0

command:# ./perf stat --metric-only -M Power -I 1000

Similarly in skylake platform:
result:#           time    Turbo_Utilization    C3_Core_Residency
            C6_Core_Residency    C7_Core_Residency     C2_Pkg_Residency
             C3_Pkg_Residency     C6_Pkg_Residency     C7_Pkg_Residency
     1.000563580                  0.3                  0.0
                  2.6                44.2                 21.9
                  0.0                  0.0                  0.0
     2.002235027                  0.4                  0.0
                  2.7           43.0                 20.7
                  0.0                  0.0               0.0

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
 tools/perf/util/metricgroup.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index a7c0424dbda3..940a6e7a6854 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -103,8 +103,11 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 		if (!strcmp(ev->name, ids[i])) {
 			if (!metric_events[i])
 				metric_events[i] = ev;
+			i++;
+			if (i == idnum)
+				break;
 		} else {
-			if (++i == idnum) {
+			if (i + 1 == idnum) {
 				/* Discard the whole match and start again */
 				i = 0;
 				memset(metric_events, 0,
@@ -124,7 +127,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 		}
 	}
 
-	if (i != idnum - 1) {
+	if (i != idnum) {
 		/* Not whole match */
 		return NULL;
 	}
-- 
2.21.0
