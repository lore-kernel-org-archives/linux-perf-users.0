From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/44] perf list: Output tool events
Date: Tue,  2 Apr 2019 13:05:15 -0300
Message-ID: <20190402160549.13544-11-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add support in 'perf list' to output tool internal events, currently
only 'duration_time'.

Committer testing:

  $ perf list dur*

  List of pre-defined events (to be used in -e):

    duration_time                                      [Tool event]

  Metric Groups:

  $ perf list sw

  List of pre-defined events (to be used in -e):

    alignment-faults                                   [Software event]
    bpf-output                                         [Software event]
    context-switches OR cs                             [Software event]
    cpu-clock                                          [Software event]
    cpu-migrations OR migrations                       [Software event]
    dummy                                              [Software event]
    emulation-faults                                   [Software event]
    major-faults                                       [Software event]
    minor-faults                                       [Software event]
    page-faults OR faults                              [Software event]
    task-clock                                         [Software event]

    duration_time                                      [Tool event]

  $ perf list | grep duration
    duration_time                                      [Tool event]
         [L1D miss outstandings duration in cycles]
          page walk duration are excluded in Skylake]
          load. EPT page walk duration are excluded in Skylake]
          page walk duration are excluded in Skylake]
          store. EPT page walk duration are excluded in Skylake]
          (instruction fetch) request. EPT page walk duration are excluded in
          instruction fetch request. EPT page walk duration are excluded in
  $

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190326221823.11518-5-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-list.c      |  6 ++++--
 tools/perf/util/parse-events.c | 20 ++++++++++++++++++++
 tools/perf/util/parse-events.h |  1 +
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index a8394b4f1167..e0312a1c4792 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -70,10 +70,11 @@ int cmd_list(int argc, const char **argv)
 			print_symbol_events(NULL, PERF_TYPE_HARDWARE,
 					event_symbols_hw, PERF_COUNT_HW_MAX, raw_dump);
 		else if (strcmp(argv[i], "sw") == 0 ||
-			 strcmp(argv[i], "software") == 0)
+			 strcmp(argv[i], "software") == 0) {
 			print_symbol_events(NULL, PERF_TYPE_SOFTWARE,
 					event_symbols_sw, PERF_COUNT_SW_MAX, raw_dump);
-		else if (strcmp(argv[i], "cache") == 0 ||
+			print_tool_events(NULL, raw_dump);
+		} else if (strcmp(argv[i], "cache") == 0 ||
 			 strcmp(argv[i], "hwcache") == 0)
 			print_hwcache_events(NULL, raw_dump);
 		else if (strcmp(argv[i], "pmu") == 0)
@@ -113,6 +114,7 @@ int cmd_list(int argc, const char **argv)
 					    event_symbols_hw, PERF_COUNT_HW_MAX, raw_dump);
 			print_symbol_events(s, PERF_TYPE_SOFTWARE,
 					    event_symbols_sw, PERF_COUNT_SW_MAX, raw_dump);
+			print_tool_events(s, raw_dump);
 			print_hwcache_events(s, raw_dump);
 			print_pmu_events(s, raw_dump, !desc_flag,
 						long_desc_flag,
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 98c0fadaedb9..4432bfe039fd 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2457,6 +2457,25 @@ int print_hwcache_events(const char *event_glob, bool name_only)
 	return evt_num;
 }
 
+static void print_tool_event(const char *name, const char *event_glob,
+			     bool name_only)
+{
+	if (event_glob && !strglobmatch(name, event_glob))
+		return;
+	if (name_only)
+		printf("%s ", name);
+	else
+		printf("  %-50s [%s]\n", name, "Tool event");
+
+}
+
+void print_tool_events(const char *event_glob, bool name_only)
+{
+	print_tool_event("duration_time", event_glob, name_only);
+	if (pager_in_use())
+		printf("\n");
+}
+
 void print_symbol_events(const char *event_glob, unsigned type,
 				struct event_symbol *syms, unsigned max,
 				bool name_only)
@@ -2540,6 +2559,7 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag,
 
 	print_symbol_events(event_glob, PERF_TYPE_SOFTWARE,
 			    event_symbols_sw, PERF_COUNT_SW_MAX, name_only);
+	print_tool_events(event_glob, name_only);
 
 	print_hwcache_events(event_glob, name_only);
 
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 0c1f5b98f636..a052cd6ac63e 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -204,6 +204,7 @@ extern struct event_symbol event_symbols_sw[];
 void print_symbol_events(const char *event_glob, unsigned type,
 				struct event_symbol *syms, unsigned max,
 				bool name_only);
+void print_tool_events(const char *event_glob, bool name_only);
 void print_tracepoint_events(const char *subsys_glob, const char *event_glob,
 			     bool name_only);
 int print_hwcache_events(const char *event_glob, bool name_only);
-- 
2.20.1
