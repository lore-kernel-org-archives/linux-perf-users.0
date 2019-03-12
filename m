From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/30] perf report: Parse time quantum
Date: Mon, 11 Mar 2019 23:01:39 -0300
Message-ID: <20190312020204.22092-6-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Many workloads change over time. 'perf report' currently aggregates the
whole time range reported in perf.data.

This patch adds an option for a time quantum to quantisize the perf.data
over time.

This just adds the option, will be used in follow on patches for a time
sort key.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20190305144758.12397-6-andi@firstfloor.org
[ Use NSEC_PER_[MU]SEC ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt |  4 +++
 tools/perf/builtin-report.c              | 42 ++++++++++++++++++++++++
 tools/perf/util/symbol.c                 |  2 ++
 tools/perf/util/symbol_conf.h            |  1 +
 4 files changed, 49 insertions(+)

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
index 515864ba504a..05c8dd41106c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -47,9 +47,11 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <regex.h>
+#include "sane_ctype.h"
 #include <signal.h>
 #include <linux/bitmap.h>
 #include <linux/stringify.h>
+#include <linux/time64.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
@@ -926,6 +928,43 @@ report_parse_callchain_opt(const struct option *opt, const char *arg, int unset)
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
+		*time_q *= NSEC_PER_SEC;
+		return 0;
+	}
+	if (!strcmp(end, "ms")) {
+		*time_q *= NSEC_PER_MSEC;
+		return 0;
+	}
+	if (!strcmp(end, "us")) {
+		*time_q *= NSEC_PER_USEC;
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
@@ -1148,6 +1187,9 @@ int cmd_report(int argc, const char **argv)
 		     "Set percent type local/global-period/hits",
 		     annotate_parse_percent_type),
 	OPT_BOOLEAN(0, "ns", &symbol_conf.nanosecs, "Show times in nanosecs"),
+	OPT_CALLBACK(0, "time-quantum", &symbol_conf.time_quantum, "time (ms|us|ns|s)",
+		     "Set time quantum for time sort key (default 100ms)",
+		     parse_time_quantum),
 	OPT_END()
 	};
 	struct perf_data data = {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index eb873ea1c405..6b73a0eeb6a1 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <linux/kernel.h>
 #include <linux/mman.h>
+#include <linux/time64.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/param.h>
@@ -45,6 +46,7 @@ struct symbol_conf symbol_conf = {
 	.demangle		= true,
 	.demangle_kernel	= false,
 	.cumulate_callchain	= true,
+	.time_quantum		= 100 * NSEC_PER_MSEC, /* 100ms */
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
2.20.1
