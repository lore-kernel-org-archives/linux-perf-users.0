From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 4/4 v4] perf stat: Add transaction flag (-T) support for s390
Date: Tue, 26 Jun 2018 09:17:01 +0200
Message-ID: <20180626071701.58190-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ak@linux.intel.com, jolsa@redhat.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

perf stat command line flag -T to display transaction counters is
currently supported for x86 only.
Add support for s390. It is based on the metrics flag -M transaction
using the architecture dependend json files. This requires a metric
named "transaction" in the json files for the platform.

Introduce new function metricgroup__has_metric() to check for
the existance of a metric_name transaction.

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
Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
---
---
 tools/perf/builtin-stat.c     | 12 ++++++++++++
 tools/perf/util/metricgroup.c | 22 ++++++++++++++++++++++
 tools/perf/util/metricgroup.h |  1 +
 3 files changed, 35 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 22547a490e1f..16df63e9a108 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2449,6 +2449,18 @@ static int add_default_attributes(void)
 		return 0;
 
 	if (transaction_run) {
+		/* Handle -T as -M transaction. Once platform specific metrics
+		 * support has been added to the json files, all archictures
+		 * will use this approach. To determine transaction support
+		 * on an architecture test for such a metric name.
+		 */
+		if (metricgroup__has_metric("transaction")) {
+			struct option opt = { .value = &evsel_list };
+
+			return metricgroup__parse_groups(&opt, "transaction",
+							 &metric_events);
+		}
+
 		if (pmu_have_event("cpu", "cycles-ct") &&
 		    pmu_have_event("cpu", "el-start"))
 			err = parse_events(evsel_list, transaction_attrs,
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 1ddc3d1d0147..96eab4ec34ff 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -490,3 +490,25 @@ int metricgroup__parse_groups(const struct option *opt,
 	metricgroup__free_egroups(&group_list);
 	return ret;
 }
+
+bool metricgroup__has_metric(const char *metric)
+{
+	struct pmu_events_map *map = perf_pmu__find_map(NULL);
+	struct pmu_event *pe;
+	int i;
+
+	if (!map)
+		return false;
+
+	for (i = 0; ; i++) {
+		pe = &map->table[i];
+
+		if (!pe->name && !pe->metric_group && !pe->metric_name)
+			break;
+		if (!pe->metric_expr)
+			continue;
+		if (match_metric(pe->metric_name, metric))
+			return true;
+	}
+	return false;
+}
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 06854e125ee7..8a155dba0581 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -28,4 +28,5 @@ int metricgroup__parse_groups(const struct option *opt,
 			struct rblist *metric_events);
 
 void metricgroup__print(bool metrics, bool groups, char *filter, bool raw);
+bool metricgroup__has_metric(const char *metric);
 #endif
-- 
2.14.3
