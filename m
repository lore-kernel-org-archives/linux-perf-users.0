From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH v3 04/11] perf tools report: Parse time quantum
Date: Thu, 28 Feb 2019 10:35:43 -0800
Message-ID: <20190228183550.14126-5-andi@firstfloor.org>
References: <20190228183550.14126-1-andi@firstfloor.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190228183550.14126-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Many workloads change over time. perf report currently aggregates
the whole time range reported in perf.data.

This patch adds an option for a time quantum to quantisize the
perf.data over time.

This just adds the option, will be used in follow on patches
for a time sort key.

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---
v2:
Move time_quantum to symbol_conf. check for zero time quantum
---
 tools/perf/Documentation/perf-report.txt |  4 +++
 tools/perf/builtin-report.c              | 41 ++++++++++++++++++++++++
 tools/perf/util/symbol.c                 |  1 +
 tools/perf/util/symbol_conf.h            |  1 +
 4 files changed, 47 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 51dbc519dbce..9ec1702bccdd 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -497,6 +497,10 @@ include::itrace.txt[]
 	The period/hits keywords set the base the percentage is computed
 	on - the samples period or the number of samples (hits).
 
+--time-quantum::
+	Configure time quantum for time sort key. Default 100ms.
+	Accepts s, us, ms, ns units.
+
 include::callchain-overhead-calculation.txt[]
 
 SEE ALSO
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 09180e559ad6..f071f19d12d6 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -47,6 +47,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <regex.h>
+#include "sane_ctype.h"
 #include <signal.h>
 #include <linux/bitmap.h>
 #include <linux/stringify.h>
@@ -926,6 +927,43 @@ report_parse_callchain_opt(const struct option *opt, const char *arg, int unset)
 	return parse_callchain_report_opt(arg);
 }
 
+static int
+parse_time_quantum(const struct option *opt, const char *arg,
+		   int unset __maybe_unused)
+{
+	unsigned long *time_q = opt->value;
+	char *end;
+
+	*time_q = strtoul(arg, &end, 0);
+	if (end == arg)
+		goto parse_err;
+	if (*time_q == 0) {
+		pr_err("time quantum cannot be 0");
+		return -1;
+	}
+	while (isspace(*end))
+		end++;
+	if (*end == 0)
+		return 0;
+	if (!strcmp(end, "s")) {
+		*time_q *= 1000000000;
+		return 0;
+	}
+	if (!strcmp(end, "ms")) {
+		*time_q *= 1000000;
+		return 0;
+	}
+	if (!strcmp(end, "us")) {
+		*time_q *= 1000;
+		return 0;
+	}
+	if (!strcmp(end, "ns"))
+		return 0;
+parse_err:
+	pr_err("Cannot parse time quantum `%s'\n", arg);
+	return -1;
+}
+
 int
 report_parse_ignore_callees_opt(const struct option *opt __maybe_unused,
 				const char *arg, int unset __maybe_unused)
@@ -1148,6 +1186,9 @@ int cmd_report(int argc, const char **argv)
 		     "Set percent type local/global-period/hits",
 		     annotate_parse_percent_type),
 	OPT_BOOLEAN(0, "ns", &symbol_conf.nanosecs, "Show times in nanosecs"),
+	OPT_CALLBACK(0, "time-quantum", &symbol_conf.time_quantum, "time (ms|us|ns)",
+		     "Set time quantum for time sort key (default 100ms)",
+		     parse_time_quantum),
 	OPT_END()
 	};
 	struct perf_data data = {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index eb873ea1c405..0f80743a1c25 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -45,6 +45,7 @@ struct symbol_conf symbol_conf = {
 	.demangle		= true,
 	.demangle_kernel	= false,
 	.cumulate_callchain	= true,
+	.time_quantum		= 100000000, /* 100ms */
 	.show_hist_headers	= true,
 	.symfs			= "",
 	.event_group		= true,
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 095a297c8b47..a5684a71b78e 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -56,6 +56,7 @@ struct symbol_conf {
 			*sym_list_str,
 			*col_width_list_str,
 			*bt_stop_list_str;
+	unsigned long	time_quantum;
        struct strlist	*dso_list,
 			*comm_list,
 			*sym_list,
-- 
2.17.2
