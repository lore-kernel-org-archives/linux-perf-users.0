From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 03/11] perf tools report: Support nano seconds
Date: Sun, 24 Feb 2019 07:37:14 -0800
Message-ID: <20190224153722.27020-4-andi@firstfloor.org>
References: <20190224153722.27020-1-andi@firstfloor.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190224153722.27020-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, eranian@google.com, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Upcoming changes add timestamp output in perf report. Add a --ns
argument similar to perf script to support nanoseconds resolution
when needed.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-report.txt | 3 +++
 tools/perf/builtin-report.c              | 1 +
 tools/perf/builtin-script.c              | 1 -
 tools/perf/util/sort.c                   | 1 +
 tools/perf/util/sort.h                   | 2 ++
 5 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 1a27bfe05039..51dbc519dbce 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -477,6 +477,9 @@ include::itrace.txt[]
 	Please note that not all mmaps are stored, options affecting which ones
 	are include 'perf record --data', for instance.
 
+--ns::
+	Show time stamps in nanoseconds.
+
 --stats::
 	Display overall events statistics without any further processing.
 	(like the one at the end of the perf report -D command)
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 2e8c74d6430c..bb8918a747ba 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1147,6 +1147,7 @@ int cmd_report(int argc, const char **argv)
 	OPT_CALLBACK(0, "percent-type", &report.annotation_opts, "local-period",
 		     "Set percent type local/global-period/hits",
 		     annotate_parse_percent_type),
+	OPT_BOOLEAN(0, "ns", &nanosecs, "Show times in nanosecs"),
 	OPT_END()
 	};
 	struct perf_data data = {
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 261055302d08..628c04543974 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -59,7 +59,6 @@ static bool			no_callchain;
 static bool			latency_format;
 static bool			system_wide;
 static bool			print_flags;
-static bool			nanosecs;
 static const char		*cpu_list;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 static struct perf_stat_config	stat_config;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 2b6c1ccb878c..d1010a966f9b 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -31,6 +31,7 @@ const char	*field_order;
 regex_t		ignore_callees_regex;
 int		have_ignore_callees = 0;
 enum sort_mode	sort__mode = SORT_MODE__NORMAL;
+bool		nanosecs = false;
 
 /*
  * Replaces all occurrences of a char used with the:
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 2fbee0b1011c..98223d952404 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -278,6 +278,8 @@ struct sort_entry {
 extern struct sort_entry sort_thread;
 extern struct list_head hist_entry__sort_list;
 
+extern bool nanosecs;
+
 struct perf_evlist;
 struct tep_handle;
 int setup_sorting(struct perf_evlist *evlist);
-- 
2.17.2
