From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH v2 6/8] perf/tools: Enhance JSON/metric infrastructure to
 handle "?"
Date: Fri, 21 Feb 2020 11:40:20 +0530
Message-ID: <20200221061022.3047-7-kjain@linux.ibm.com>
References: <20200221061022.3047-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
In-Reply-To: <20200221061022.3047-1-kjain@linux.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
To: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, suka@us.ibm.com
Cc: mark.rutland@arm.com, ravi.bangoria@linux.ibm.com, maddy@linux.vnet.ibm.com, tglx@linutronix.de, jmario@redhat.com, peterz@infradead.org, gregkh@linuxfoundation.org, mpetlan@redhat.com, alexander.shishkin@linux.intel.com, linux-perf-users@vger.kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, anju@linux.vnet.ibm.com, mamatha4@linux.vnet.ibm.com, kjain@linux.ibm.com, jolsa@kernel.org, namhyung@kernel.org, mingo@kernel.org, kan.liang@linux.intel.com
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
 tools/perf/arch/powerpc/util/header.c |  40 +++++++++
 tools/perf/util/expr.h                |   1 +
 tools/perf/util/expr.y                |  17 +++-
 tools/perf/util/metricgroup.c         | 112 ++++++++++++++++----------
 tools/perf/util/metricgroup.h         |   1 +
 tools/perf/util/stat-shadow.c         |   5 ++
 6 files changed, 134 insertions(+), 42 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index 3b4cdfc5efd6..28425edb901c 100644
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
@@ -44,3 +51,36 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
 
 	return bufp;
 }
+
+int arch_get_runtimeparam(void)
+{
+	int count = 0;
+	DIR *dir;
+	char path[PATH_MAX];
+	const char *sysfs = sysfs__mountpoint();
+	char filename[] = "sockets";
+	FILE *file;
+	char buf[16], *num;
+	int data;
+
+	if (!sysfs)
+		goto out;
+	snprintf(path, PATH_MAX,
+		 "%s" SOCKETS_INFO_FILE_PATH, sysfs);
+	dir = opendir(path);
+	if (!dir)
+		goto out;
+	strcat(path, filename);
+	file = fopen(path, "r");
+	if (!file)
+		goto out;
+
+	data = fread(buf, 1, sizeof(buf), file);
+	if (data == 0)
+		goto out;
+	count = strtol(buf, &num, 10);
+out:
+	if (!count)
+		count = 1;
+	return count;
+}
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 046160831f90..85ebea68b0c5 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -15,6 +15,7 @@ struct parse_ctx {
 	struct parse_id ids[MAX_PARSE_ID];
 };
 
+extern int expr__runtimeparam;
 void expr__ctx_init(struct parse_ctx *ctx);
 void expr__add_id(struct parse_ctx *ctx, const char *id, double val);
 #ifndef IN_EXPR_Y
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 7d226241f1d7..8d1d51451873 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -37,6 +37,8 @@
 %type <num> expr if_expr
 
 %{
+int expr__runtimeparam;
+
 static int expr__lex(YYSTYPE *res, const char **pp);
 
 static void expr__error(double *final_val __maybe_unused,
@@ -102,7 +104,7 @@ static int expr__symbol(YYSTYPE *res, const char *p, const char **pp)
 	if (*p == '#')
 		*dst++ = *p++;
 
-	while (isalnum(*p) || *p == '_' || *p == '.' || *p == ':' || *p == '@' || *p == '\\') {
+	while (isalnum(*p) || *p == '_' || *p == '.' || *p == ':' || *p == '@' || *p == '\\' || *p == '?') {
 		if (p - s >= MAXIDLEN)
 			return -1;
 		/*
@@ -113,6 +115,19 @@ static int expr__symbol(YYSTYPE *res, const char *p, const char **pp)
 			*dst++ = '/';
 		else if (*p == '\\')
 			*dst++ = *++p;
+		else if (*p == '?') {
+			int size = snprintf(NULL, 0, "%d", expr__runtimeparam);
+			char * paramval = (char *)malloc(size);
+			int i = 0;
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
 			*dst++ = *p;
 		p++;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 02aee946b6c1..f629828cc0de 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -399,6 +399,11 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	strlist__delete(metriclist);
 }
 
+int __weak arch_get_runtimeparam(void)
+{
+	return 1;
+}
+
 static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				   struct list_head *group_list)
 {
@@ -419,52 +424,77 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 			continue;
 		if (match_metric(pe->metric_group, metric) ||
 		    match_metric(pe->metric_name, metric)) {
-			const char **ids;
-			int idnum;
-			struct egroup *eg;
-			bool no_group = false;
+			int k, count;
+
+			if (strstr(pe->metric_expr, "?"))
+				count = arch_get_runtimeparam();
+			else
+				count = 1;
+
+			/* This loop is added to create multiple
+			 * events depend on count value and add
+			 * those events to group_list.
+			 */
+			for (k = 0; k < count; k++) {
+				const char **ids;
+				int idnum;
+				struct egroup *eg;
+				bool no_group = false;
+				char value[PATH_MAX];
+
+				pr_debug("metric expr %s for %s\n",
+					 pe->metric_expr, pe->metric_name);
+				expr__runtimeparam = k;
+				if (expr__find_other(pe->metric_expr, NULL,
+						     &ids, &idnum) < 0)
+					continue;
+				if (events->len > 0)
+					strbuf_addf(events, ",");
+				for (j = 0; j < idnum; j++) {
+					pr_debug("found event %s\n", ids[j]);
+					/*
+					 * Duration time maps to a software
+					 * event and can make groups not count.
+					 * Always use it outside a group.
+					 */
+					if (!strcmp(ids[j], "duration_time")) {
+						if (j > 0)
+							strbuf_addf(events,
+								    "}:W,");
+						strbuf_addf(events,
+							    "duration_time");
+						no_group = true;
+						continue;
+					}
+					strbuf_addf(events, "%s%s",
+						    j == 0 || no_group ? "{" :
+						    ",", ids[j]);
+					no_group = false;
+				}
+				if (!no_group)
+					strbuf_addf(events, "}:W");
 
-			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
+				eg = malloc(sizeof(struct egroup));
+				if (!eg) {
+					ret = -ENOMEM;
+					break;
+				}
+				eg->ids = ids;
+				eg->idnum = idnum;
 
-			if (expr__find_other(pe->metric_expr,
-					     NULL, &ids, &idnum) < 0)
-				continue;
-			if (events->len > 0)
-				strbuf_addf(events, ",");
-			for (j = 0; j < idnum; j++) {
-				pr_debug("found event %s\n", ids[j]);
-				/*
-				 * Duration time maps to a software event and can make
-				 * groups not count. Always use it outside a
-				 * group.
-				 */
-				if (!strcmp(ids[j], "duration_time")) {
-					if (j > 0)
-						strbuf_addf(events, "}:W,");
-					strbuf_addf(events, "duration_time");
-					no_group = true;
-					continue;
+				if (strstr(pe->metric_expr, "?")) {
+					sprintf(value, "%s%c%d",
+						pe->metric_name, '_', k);
+				} else {
+					strcpy(value, pe->metric_name);
 				}
-				strbuf_addf(events, "%s%s",
-					j == 0 || no_group ? "{" : ",",
-					ids[j]);
-				no_group = false;
-			}
-			if (!no_group)
-				strbuf_addf(events, "}:W");
 
-			eg = malloc(sizeof(struct egroup));
-			if (!eg) {
-				ret = -ENOMEM;
-				break;
+				eg->metric_name = strdup(value);
+				eg->metric_expr = pe->metric_expr;
+				eg->metric_unit = pe->unit;
+				list_add_tail(&eg->nd, group_list);
+				ret = 0;
 			}
-			eg->ids = ids;
-			eg->idnum = idnum;
-			eg->metric_name = pe->metric_name;
-			eg->metric_expr = pe->metric_expr;
-			eg->metric_unit = pe->unit;
-			list_add_tail(&eg->nd, group_list);
-			ret = 0;
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
index 2c41d47f6f83..147a39b1ff5b 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -780,7 +780,12 @@ static void generic_metric(struct perf_stat_config *config,
 
 	if (!metric_events[i]) {
 		const char *p = metric_expr;
+		if (strstr(p, "?")) {
+			char *tmp = strrchr(metric_name, '_');
 
+			tmp++;
+			expr__runtimeparam = strtol(tmp, &tmp, 10);
+		}
 		if (expr__parse(&ratio, &pctx, &p) == 0) {
 			char *unit;
 			char metric_bf[64];
-- 
2.18.1
