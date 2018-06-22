From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 4/4 v2] perf stat: Add transaction flag (-T) support for s390
Date: Fri, 22 Jun 2018 10:07:50 +0200
Message-ID: <20180622080750.25545-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

perf stat command line flag -T to display transaction counters is
currently supported for x86 only.
Add support for s390. It is based on the metrics flag -M transaction
using the architecture dependend json files This requires a metric
named transaction in the json files for the platform.

As suggested by Andi Kleen, this is the new approach to support
transactions counters. Other architectures will follow.

Output before:
[root@p23lp27 perf]# ./perf stat -T -- sleep 1
Cannot set up transaction events
[root@p23lp27 perf]#

Output after:
[root@s35lp76 perf]# ./perf stat -T -- ~/mytesttx 1 >/tmp/111

 Performance counter stats for '/root/mytesttx 1':

                 1      tx_c_tend           #     13.0 transaction
                 1      tx_nc_tend
                11      tx_nc_tabort
                 0      tx_c_tabort_special
                 0      tx_c_tabort_no_special

       0.001070109 seconds time elapsed

[root@s35lp76 perf]#

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/builtin-stat.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a4f662a462c6..c8e2c5a1692f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2425,6 +2425,18 @@ static int add_default_attributes(void)
 	if (transaction_run) {
 		struct parse_events_error errinfo;
 
+		/* Handle -T as -M transaction. Once platform specific metrics
+		 * support has been added to the json files, all archictures
+		 * will use this approach. To determine transaction support
+		 * on an architecture test for such an alias.
+		 */
+		if (pmu_have_event("cpum_cf", "TX_NC_TEND")) {
+			struct option opt = { .value = &evsel_list };
+
+			return metricgroup__parse_groups(&opt, "transaction",
+							 &metric_events);
+		}
+
 		if (pmu_have_event("cpu", "cycles-ct") &&
 		    pmu_have_event("cpu", "el-start"))
 			err = parse_events(evsel_list, transaction_attrs,
-- 
2.14.3
