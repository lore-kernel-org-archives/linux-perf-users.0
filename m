From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 40/43] perf list: Display metric expressions for --details option
Date: Thu, 14 Feb 2019 21:45:36 -0300
Message-ID: <20190215004539.23571-41-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Display metric expression itself when --details is specified.

Current list with no details:

  # perf list metrics
  ...
  TopDownL1:
    IPC
         [Instructions Per Cycle (per logical thread)]
    SLOTS
         [Total issue-pipeline slots]
  ...

Detailed output with metric formula:

  # perf list --details metrics
  ...
  TopDownL1:
    IPC
         [Instructions Per Cycle (per logical thread)]
         [inst_retired.any / cpu_clk_unhalted.thread]
    SLOTS
         [Total issue-pipeline slots]
         [4*(( cpu_clk_unhalted.thread_any / 2 ) if #smt_on else cycles)]
  ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190213123246.4015-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-list.c      | 8 ++++----
 tools/perf/util/metricgroup.c  | 8 +++++++-
 tools/perf/util/metricgroup.h  | 3 ++-
 tools/perf/util/parse-events.c | 2 +-
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index ead221e49f00..c9f98d00c0e9 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -82,9 +82,9 @@ int cmd_list(int argc, const char **argv)
 		else if (strcmp(argv[i], "sdt") == 0)
 			print_sdt_events(NULL, NULL, raw_dump);
 		else if (strcmp(argv[i], "metric") == 0)
-			metricgroup__print(true, false, NULL, raw_dump);
+			metricgroup__print(true, false, NULL, raw_dump, details_flag);
 		else if (strcmp(argv[i], "metricgroup") == 0)
-			metricgroup__print(false, true, NULL, raw_dump);
+			metricgroup__print(false, true, NULL, raw_dump, details_flag);
 		else if ((sep = strchr(argv[i], ':')) != NULL) {
 			int sep_idx;
 
@@ -102,7 +102,7 @@ int cmd_list(int argc, const char **argv)
 			s[sep_idx] = '\0';
 			print_tracepoint_events(s, s + sep_idx + 1, raw_dump);
 			print_sdt_events(s, s + sep_idx + 1, raw_dump);
-			metricgroup__print(true, true, s, raw_dump);
+			metricgroup__print(true, true, s, raw_dump, details_flag);
 			free(s);
 		} else {
 			if (asprintf(&s, "*%s*", argv[i]) < 0) {
@@ -119,7 +119,7 @@ int cmd_list(int argc, const char **argv)
 						details_flag);
 			print_tracepoint_events(NULL, s, raw_dump);
 			print_sdt_events(NULL, s, raw_dump);
-			metricgroup__print(true, true, NULL, raw_dump);
+			metricgroup__print(true, true, NULL, raw_dump, details_flag);
 			free(s);
 		}
 	}
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8529cbd3955b..b8d864ed4afe 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -270,7 +270,7 @@ static void metricgroup__print_strlist(struct strlist *metrics, bool raw)
 }
 
 void metricgroup__print(bool metrics, bool metricgroups, char *filter,
-			bool raw)
+			bool raw, bool details)
 {
 	struct pmu_events_map *map = perf_pmu__find_map(NULL);
 	struct pmu_event *pe;
@@ -329,6 +329,12 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 					if (asprintf(&s, "%s\n%*s%s]",
 						     pe->metric_name, 8, "[", pe->desc) < 0)
 						return;
+
+					if (details) {
+						if (asprintf(&s, "%s\n%*s%s]",
+							     s, 8, "[", pe->metric_expr) < 0)
+							return;
+					}
 				}
 
 				if (!s)
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 8a155dba0581..5c52097a5c63 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -27,6 +27,7 @@ int metricgroup__parse_groups(const struct option *opt,
 			const char *str,
 			struct rblist *metric_events);
 
-void metricgroup__print(bool metrics, bool groups, char *filter, bool raw);
+void metricgroup__print(bool metrics, bool groups, char *filter,
+			bool raw, bool details);
 bool metricgroup__has_metric(const char *metric);
 #endif
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 920e1e6551dd..4dcc01b2532c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2540,7 +2540,7 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag,
 
 	print_sdt_events(NULL, NULL, name_only);
 
-	metricgroup__print(true, true, NULL, name_only);
+	metricgroup__print(true, true, NULL, name_only, details_flag);
 }
 
 int parse_events__is_hardcoded_term(struct parse_events_term *term)
-- 
2.19.1
