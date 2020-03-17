From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/23] perf metricgroup: Support metric constraint
Date: Tue, 17 Mar 2020 18:32:41 -0300
Message-ID: <20200317213259.15494-6-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some metric groups have metric constraints. A metric group can be
scheduled as a group only when some constraints are applied.  For
example, Page_Walks_Utilization has a metric constraint,
"NO_NMI_WATCHDOG".

When NMI watchdog is disabled, the metric group can be scheduled as a
group. Otherwise, splitting the metric group into standalone metrics.

Add a new function, metricgroup__has_constraint(), to check whether all
constraints are applied. If not, splitting the metric group into
standalone metrics.

Currently, only one constraint, "NO_NMI_WATCHDOG", is checked. Print a
warning for the metric group with the constraint, when NMI WATCHDOG is
enabled.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/1582581564-184429-5-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 54 ++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 1cd042cb262e..c3a8c701609a 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -22,6 +22,8 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 #include <subcmd/parse-options.h>
+#include <api/fs/fs.h>
+#include "util.h"
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct evsel *evsel,
@@ -429,6 +431,49 @@ static void metricgroup__add_metric_weak_group(struct strbuf *events,
 		strbuf_addf(events, "}:W");
 }
 
+static void metricgroup__add_metric_non_group(struct strbuf *events,
+					      const char **ids,
+					      int idnum)
+{
+	int i;
+
+	for (i = 0; i < idnum; i++)
+		strbuf_addf(events, ",%s", ids[i]);
+}
+
+static void metricgroup___watchdog_constraint_hint(const char *name, bool foot)
+{
+	static bool violate_nmi_constraint;
+
+	if (!foot) {
+		pr_warning("Splitting metric group %s into standalone metrics.\n", name);
+		violate_nmi_constraint = true;
+		return;
+	}
+
+	if (!violate_nmi_constraint)
+		return;
+
+	pr_warning("Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constraint:\n"
+		   "    echo 0 > /proc/sys/kernel/nmi_watchdog\n"
+		   "    perf stat ...\n"
+		   "    echo 1 > /proc/sys/kernel/nmi_watchdog\n");
+}
+
+static bool metricgroup__has_constraint(struct pmu_event *pe)
+{
+	if (!pe->metric_constraint)
+		return false;
+
+	if (!strcmp(pe->metric_constraint, "NO_NMI_WATCHDOG") &&
+	    sysctl__nmi_watchdog_enabled()) {
+		metricgroup___watchdog_constraint_hint(pe->metric_name, false);
+		return true;
+	}
+
+	return false;
+}
+
 static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				   struct list_head *group_list)
 {
@@ -460,7 +505,10 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 			if (events->len > 0)
 				strbuf_addf(events, ",");
 
-			metricgroup__add_metric_weak_group(events, ids, idnum);
+			if (metricgroup__has_constraint(pe))
+				metricgroup__add_metric_non_group(events, ids, idnum);
+			else
+				metricgroup__add_metric_weak_group(events, ids, idnum);
 
 			eg = malloc(sizeof(struct egroup));
 			if (!eg) {
@@ -502,6 +550,10 @@ static int metricgroup__add_metric_list(const char *list, struct strbuf *events,
 		}
 	}
 	free(nlist);
+
+	if (!ret)
+		metricgroup___watchdog_constraint_hint(NULL, true);
+
 	return ret;
 }
 
-- 
2.21.1
