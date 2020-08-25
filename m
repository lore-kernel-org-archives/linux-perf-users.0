From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Perf test 67 dumps core on s390
Date: Tue, 25 Aug 2020 09:12:11 +0200
Message-ID: <20200825071211.16959-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Linux 5.9 introduced perf test case "Parse and process metrics" and
on s390 this test case always dumps core:

[root@t35lp67 perf]# ./perf test -vvvv -F 67
67: Parse and process metrics                             :
--- start ---
metric expr inst_retired.any / cpu_clk_unhalted.thread for IPC
parsing metric: inst_retired.any / cpu_clk_unhalted.thread
Segmentation fault (core dumped)
[root@t35lp67 perf]#

I debugged this core dump and gdb shows this call chain:

(gdb) where
 #0  0x000003ffabc3192a in __strnlen_c_1 () from /lib64/libc.so.6
 #1  0x000003ffabc293de in strcasestr () from /lib64/libc.so.6
 #2  0x0000000001102ba2 in match_metric(list=0x1e6ea20 "inst_retired.any",
          n=<optimized out>)
     at util/metricgroup.c:368
 #3  find_metric (map=<optimized out>, map=<optimized out>,
         metric=0x1e6ea20 "inst_retired.any")
    at util/metricgroup.c:765
 #4  __resolve_metric (ids=0x0, map=<optimized out>, metric_list=0x0,
         metric_no_group=<optimized out>, m=<optimized out>)
    at util/metricgroup.c:844
 #5  resolve_metric (ids=0x0, map=0x0, metric_list=0x0,
        metric_no_group=<optimized out>)
    at util/metricgroup.c:881
 #6  metricgroup__add_metric (metric=<optimized out>,
      metric_no_group=metric_no_group@entry=false, events=<optimized out>,
      events@entry=0x3ffd84fb878, metric_list=0x0,
      metric_list@entry=0x3ffd84fb868, map=0x0)
    at util/metricgroup.c:943
 #7  0x00000000011034ae in metricgroup__add_metric_list (map=0x13f9828 <map>,
      metric_list=0x3ffd84fb868, events=0x3ffd84fb878,
      metric_no_group=<optimized out>, list=<optimized out>)
    at util/metricgroup.c:988
 #8  parse_groups (perf_evlist=perf_evlist@entry=0x1e70260,
        str=str@entry=0x12f34b2 "IPC", metric_no_group=<optimized out>,
        metric_no_merge=<optimized out>,
        fake_pmu=fake_pmu@entry=0x1462f18 <perf_pmu.fake>,
        metric_events=0x3ffd84fba58, map=0x1)
    at util/metricgroup.c:1040
 #9  0x0000000001103eb2 in metricgroup__parse_groups_test(
	evlist=evlist@entry=0x1e70260, map=map@entry=0x13f9828 <map>,
	str=str@entry=0x12f34b2 "IPC",
	metric_no_group=metric_no_group@entry=false,
	metric_no_merge=metric_no_merge@entry=false,
	metric_events=0x3ffd84fba58)
    at util/metricgroup.c:1082
 #10 0x00000000010c84d8 in __compute_metric (ratio2=0x0, name2=0x0,
        ratio1=<synthetic pointer>, name1=0x12f34b2 "IPC",
	vals=0x3ffd84fbad8, name=0x12f34b2 "IPC")
    at tests/parse-metric.c:159
 #11 compute_metric (ratio=<synthetic pointer>, vals=0x3ffd84fbad8,
	name=0x12f34b2 "IPC")
    at tests/parse-metric.c:189
 #12 test_ipc () at tests/parse-metric.c:208
.....
..... omitted many more lines

This test case was added with
commit 218ca91df477 ("perf tests: Add parse metric test for frontend metric").

When I compile with make DEBUG=y it works fine and I do not get a
core dump.
It turned out that the above listed function call chain worked on
a struct pmu_event array which requires a trailing element with zeroes
which was missing. The marco map_for_each_event() loops over that
array tests for members metric_expr/metric_name/metric_group
being non-NULL. Adding this element fixes the issue.

Output after:
  [root@t35lp46 perf]# ./perf test 67
  67: Parse and process metrics                             : Ok
  [root@t35lp46 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 tools/perf/tests/parse-metric.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index fc0838a7abc2..80c71a10999d 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -70,6 +70,11 @@ static struct pmu_event pme_test[] = {
 {
 	.metric_expr	= "1/m3",
 	.metric_name	= "M3",
+},
+{
+	.metric_expr	= NULL,
+	.metric_name	= NULL,
+	.metric_group	= NULL
 }
 };
 
-- 
2.26.2
