From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/23] perf util: Factor out sysctl__nmi_watchdog_enabled()
Date: Tue, 17 Mar 2020 18:32:40 -0300
Message-ID: <20200317213259.15494-5-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The NMI watchdog status is required for metric group constraint
examination.  Factor out sysctl__nmi_watchdog_enabled() to retrieve the
NMI watchdog status.

Users may count more than one metric group each time. If so, the NMI
watchdog status may be retrieved several times. To reduce the overhead,
cache the NMI watchdog status.

Replace the NMI watchdog status checking in print_footer() by
sysctl__nmi_watchdog_enabled().

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/1582581564-184429-4-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-display.c |  6 ++----
 tools/perf/util/util.c         | 18 ++++++++++++++++++
 tools/perf/util/util.h         |  2 ++
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index d89cb0da90f8..76c6052b12e2 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -16,6 +16,7 @@
 #include <linux/ctype.h>
 #include "cgroup.h"
 #include <api/fs/fs.h>
+#include "util.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -1097,7 +1098,6 @@ static void print_footer(struct perf_stat_config *config)
 {
 	double avg = avg_stats(config->walltime_nsecs_stats) / NSEC_PER_SEC;
 	FILE *output = config->output;
-	int n;
 
 	if (!config->null_run)
 		fprintf(output, "\n");
@@ -1131,9 +1131,7 @@ static void print_footer(struct perf_stat_config *config)
 	}
 	fprintf(output, "\n\n");
 
-	if (config->print_free_counters_hint &&
-	    sysctl__read_int("kernel/nmi_watchdog", &n) >= 0 &&
-	    n > 0)
+	if (config->print_free_counters_hint && sysctl__nmi_watchdog_enabled())
 		fprintf(output,
 "Some events weren't counted. Try disabling the NMI watchdog:\n"
 "	echo 0 > /proc/sys/kernel/nmi_watchdog\n"
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 969ae560dad9..d707c9624dd9 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -55,6 +55,24 @@ int sysctl__max_stack(void)
 	return sysctl_perf_event_max_stack;
 }
 
+bool sysctl__nmi_watchdog_enabled(void)
+{
+	static bool cached;
+	static bool nmi_watchdog;
+	int value;
+
+	if (cached)
+		return nmi_watchdog;
+
+	if (sysctl__read_int("kernel/nmi_watchdog", &value) < 0)
+		return false;
+
+	nmi_watchdog = (value > 0) ? true : false;
+	cached = true;
+
+	return nmi_watchdog;
+}
+
 bool test_attr__enabled;
 
 bool perf_host  = true;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 9969b8b46f7c..f486fdd3a538 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -29,6 +29,8 @@ size_t hex_width(u64 v);
 
 int sysctl__max_stack(void);
 
+bool sysctl__nmi_watchdog_enabled(void);
+
 int fetch_kernel_version(unsigned int *puint,
 			 char *str, size_t str_sz);
 #define KVER_VERSION(x)		(((x) >> 16) & 0xff)
-- 
2.21.1
