From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH v4 6/8] perf/tools: Enhance JSON/metric infrastructure to handle "?"
Date: Mon,  9 Mar 2020 11:55:50 +0530
Message-ID: <20200309062552.29911-7-kjain@linux.ibm.com>
References: <20200309062552.29911-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200309062552.29911-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de, kjain@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Patch enhances current metric infrastructure to handle "?" in the metric
expression. The "?" can be use for parameters whose value not known while
creating metric events and which can be replace later at runtime to
the proper value. It also add flexibility to create multiple events out
of single metric event added in json file.

Patch adds function 'arch_get_runtimeparam' which is a arch specific
function, returns the count of metric events need to be created.
By default it return 1.

One loop is added in function 'metricgroup__add_metric', which create
multiple events at run time depend on return value of
'arch_get_runtimeparam' and merge that event in 'group_list'.

This infrastructure needed for hv_24x7 socket/chip level events.
"hv_24x7" chip level events needs specific chip-id to which the
data is requested. Function 'arch_get_runtimeparam' implemented
in header.c which extract number of sockets from sysfs file
"sockets" under "/sys/devices/hv_24x7/interface/".

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/arch/powerpc/util/header.c |  22 +++++
 tools/perf/util/expr.h                |   1 +
 tools/perf/util/expr.l                |  19 +++-
 tools/perf/util/metricgroup.c         | 124 ++++++++++++++++++++------
 tools/perf/util/metricgroup.h         |   1 +
 tools/perf/util/stat-shadow.c         |   8 ++
 6 files changed, 148 insertions(+), 27 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index 3b4cdfc5efd6..036f6b2ce202 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -7,6 +7,11 @@
 #include <string.h>
 #include <linux/stringify.h>
 #include "header.h"
+#include "metricgroup.h"
+#include "evlist.h"
+#include <dirent.h>
+#include "pmu.h"
+#include <api/fs/fs.h>
 
 #define mfspr(rn)       ({unsigned long rval; \
 			 asm volatile("mfspr %0," __stringify(rn) \
@@ -16,6 +21,8 @@
 #define PVR_VER(pvr)    (((pvr) >>  16) & 0xFFFF) /* Version field */
 #define PVR_REV(pvr)    (((pvr) >>   0) & 0xFFFF) /* Revison field */
 
+#define SOCKETS_INFO_FILE_PATH "/devices/hv_24x7/interface/"
+
 int
 get_cpuid(char *buffer, size_t sz)
 {
@@ -44,3 +51,18 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
 
 	return bufp;
 }
+
+int arch_get_runtimeparam(void)
+{
+	int count;
+	char path[PATH_MAX];
+	char filename[] = "sockets";
+
+	snprintf(path, PATH_MAX,
+		 SOCKETS_INFO_FILE_PATH "%s", filename);
+
+	if (sysfs__read_ull(path, (unsigned long long *)&count) < 0)
+		return 1;
+	else
+		return count;
+}
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 9377538f4097..d17664e628db 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -15,6 +15,7 @@ struct parse_ctx {
 	struct parse_id ids[MAX_PARSE_ID];
 };
 
+int expr__runtimeparam;
 void expr__ctx_init(struct parse_ctx *ctx);
 void expr__add_id(struct parse_ctx *ctx, const char *id, double val);
 int expr__parse(double *final_val, struct parse_ctx *ctx, const char *expr);
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 1928f2a3dddc..ec4b00671f67 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -45,6 +45,21 @@ static char *normalize(char *str)
 			*dst++ = '/';
 		else if (*str == '\\')
 			*dst++ = *++str;
+        else if (*str == '?') {
+
+			int size = snprintf(NULL, 0, "%d", expr__runtimeparam);
+			char * paramval = (char *)malloc(size);
+			int i = 0;
+
+			if(!paramval)
+				*dst++ = '0';
+			else {
+				sprintf(paramval, "%d", expr__runtimeparam);
+				while(i < size)
+					*dst++ = paramval[i++];
+				free(paramval);
+			}
+		}
 		else
 			*dst++ = *str;
 		str++;
@@ -72,8 +87,8 @@ number		[0-9]+
 
 sch		[-,=]
 spec		\\{sch}
-sym		[0-9a-zA-Z_\.:@]+
-symbol		{spec}*{sym}*{spec}*{sym}*
+sym		[0-9a-zA-Z_\.:@?]+
+symbol		{spec}*{sym}*{spec}*{sym}*{spec}*{sym}
 
 %%
 	{
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index c3a8c701609a..11eeeb929b91 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -474,6 +474,98 @@ static bool metricgroup__has_constraint(struct pmu_event *pe)
 	return false;
 }
 
+int __weak arch_get_runtimeparam(void)
+{
+	return 1;
+}
+
+static int metricgroup__add_metric_runtime_param(struct strbuf *events,
+			struct list_head *group_list, struct pmu_event *pe)
+{
+	int i, count;
+	int ret = -EINVAL;
+
+	count = arch_get_runtimeparam();
+
+	/* This loop is added to create multiple
+	 * events depend on count value and add
+	 * those events to group_list.
+	 */
+
+	for (i = 0; i < count; i++) {
+		const char **ids;
+		int idnum;
+		struct egroup *eg;
+		char value[PATH_MAX];
+
+		expr__runtimeparam = i;
+
+		if (expr__find_other(pe->metric_expr,
+					NULL, &ids, &idnum) < 0)
+			return ret;
+
+		if (events->len > 0)
+			strbuf_addf(events, ",");
+
+		if (metricgroup__has_constraint(pe))
+			metricgroup__add_metric_non_group(events, ids, idnum);
+		else
+			metricgroup__add_metric_weak_group(events, ids, idnum);
+
+		eg = malloc(sizeof(struct egroup));
+		if (!eg) {
+			ret = -ENOMEM;
+			return ret;
+		}
+		sprintf(value, "%s%c%d", pe->metric_name, '_', i);
+		eg->ids = ids;
+		eg->idnum = idnum;
+		eg->metric_name = strdup(value);
+		eg->metric_expr = pe->metric_expr;
+		eg->metric_unit = pe->unit;
+		list_add_tail(&eg->nd, group_list);
+		ret = 0;
+
+		if (ret != 0)
+			break;
+	}
+	return ret;
+}
+static int metricgroup__add_metric_param(struct strbuf *events,
+			struct list_head *group_list, struct pmu_event *pe)
+{
+
+	const char **ids;
+	int idnum;
+	struct egroup *eg;
+	int ret = -EINVAL;
+
+	if (expr__find_other(pe->metric_expr,
+					     NULL, &ids, &idnum) < 0)
+		return ret;
+	if (events->len > 0)
+		strbuf_addf(events, ",");
+
+	if (metricgroup__has_constraint(pe))
+		metricgroup__add_metric_non_group(events, ids, idnum);
+	else
+		metricgroup__add_metric_weak_group(events, ids, idnum);
+
+	eg = malloc(sizeof(struct egroup));
+	if (!eg)
+		ret = -ENOMEM;
+
+	eg->ids = ids;
+	eg->idnum = idnum;
+	eg->metric_name = pe->metric_name;
+	eg->metric_expr = pe->metric_expr;
+	eg->metric_unit = pe->unit;
+	list_add_tail(&eg->nd, group_list);
+	ret = 0;
+
+	return ret;
+}
+
 static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				   struct list_head *group_list)
 {
@@ -493,35 +585,17 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 			continue;
 		if (match_metric(pe->metric_group, metric) ||
 		    match_metric(pe->metric_name, metric)) {
-			const char **ids;
-			int idnum;
-			struct egroup *eg;
 
 			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 
-			if (expr__find_other(pe->metric_expr,
-					     NULL, &ids, &idnum) < 0)
-				continue;
-			if (events->len > 0)
-				strbuf_addf(events, ",");
-
-			if (metricgroup__has_constraint(pe))
-				metricgroup__add_metric_non_group(events, ids, idnum);
+			if (strstr(pe->metric_expr, "?"))
+				ret = metricgroup__add_metric_runtime_param(events,
+							group_list, pe);
 			else
-				metricgroup__add_metric_weak_group(events, ids, idnum);
-
-			eg = malloc(sizeof(struct egroup));
-			if (!eg) {
-				ret = -ENOMEM;
-				break;
-			}
-			eg->ids = ids;
-			eg->idnum = idnum;
-			eg->metric_name = pe->metric_name;
-			eg->metric_expr = pe->metric_expr;
-			eg->metric_unit = pe->unit;
-			list_add_tail(&eg->nd, group_list);
-			ret = 0;
+				ret = metricgroup__add_metric_param(events,
+							group_list, pe);
+			if (ret == -EINVAL)
+				continue;
 		}
 	}
 	return ret;
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 475c7f912864..81224ba1270d 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -34,4 +34,5 @@ int metricgroup__parse_groups(const struct option *opt,
 void metricgroup__print(bool metrics, bool groups, char *filter,
 			bool raw, bool details);
 bool metricgroup__has_metric(const char *metric);
+int arch_get_runtimeparam(void);
 #endif
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 0fd713d3674f..92c4c9abbaa0 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -777,6 +777,14 @@ static void generic_metric(struct perf_stat_config *config,
 	}
 
 	if (!metric_events[i]) {
+
+		if (strstr(metric_expr, "?")) {
+			char *tmp = strrchr(metric_name, '_');
+
+			tmp++;
+			expr__runtimeparam = strtol(tmp, &tmp, 10);
+		}
+
 		if (expr__parse(&ratio, &pctx, metric_expr) == 0) {
 			char *unit;
 			char metric_bf[64];
-- 
2.18.1
