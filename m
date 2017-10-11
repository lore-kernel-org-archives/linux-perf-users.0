From: ufo19890607 <ufo19890607@gmail.com>
Subject: [PATCH v3 1/4] Add two elements for perf_tool struct, and add three elements for perf_evsel struct, and add the per-event-dump option for perf script
Date: Thu, 12 Oct 2017 02:23:57 +0800
Message-ID: <1507746240-34638-2-git-send-email-ufo19890607@gmail.com>
References: <1507746240-34638-1-git-send-email-ufo19890607@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507746240-34638-1-git-send-email-ufo19890607@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

From: yuzhoujian <yuzhoujian@didichuxing.com>

This patch will add two elements for per_tool struct: per_event_dump
is used to mark the per-event-dump option, last_evsel_name is used
to save last evsel's name, and add three elements for perf_evsel struct:
dump_event_fp is used to save the file pointer of the dump_event file,
filename is used to save the file name of the dump_event file, samples
is used to save the number of samples for each evsel, and add the
OPT_BOOLEAN for per-event-dump in the perf_data_file struct.

Changes since v2:
- add the last_evsel_name for per_tool struct to save last evsel's name.
- add three elements for perf_evsel struct:dump_event_fp is used to save
 the file pointer of the dump_event file, filename is used to save the file
 name of the dump_event file, samples is used to save the number of samples
 for each evsel.

Changes since v1:
- remove the set for script.tool.per_event_dump variable,since the OPT_BOOLEAN
 will do the same thing.

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
---
 tools/perf/builtin-script.c | 3 +++
 tools/perf/util/evsel.h     | 4 ++++
 tools/perf/util/tool.h      | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 7167df2..4ffa716 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2729,6 +2729,7 @@ int cmd_script(int argc, const char **argv)
 			.cpu_map	 = process_cpu_map_event,
 			.ordered_events	 = true,
 			.ordering_requires_timestamps = true,
+			.per_event_dump = false,
 		},
 	};
 	struct perf_data_file file = {
@@ -2799,6 +2800,8 @@ int cmd_script(int argc, const char **argv)
 		    "Show context switch events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-namespace-events", &script.show_namespace_events,
 		    "Show namespace events (if recorded)"),
+	OPT_BOOLEAN('\0', "per-event-dump", &script.tool.per_event_dump,
+		    "print trace output to files named by the monitored events"),
 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
 	OPT_INTEGER(0, "max-blocks", &max_blocks,
 		    "Maximum number of code blocks to dump with brstackinsn"),
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index db65878..b1fb949 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -4,6 +4,7 @@
 #include <linux/list.h>
 #include <stdbool.h>
 #include <stddef.h>
+#include <stdio.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
 #include "xyarray.h"
@@ -128,9 +129,11 @@ struct perf_evsel {
 	unsigned long		*per_pkg_mask;
 	struct perf_evsel	*leader;
 	char			*group_name;
+	char			*filename;
 	bool			cmdline_group_boundary;
 	struct list_head	config_terms;
 	int			bpf_fd;
+	unsigned long		samples;
 	bool			auto_merge_stats;
 	bool			merged_stat;
 	const char *		metric_expr;
@@ -138,6 +141,7 @@ struct perf_evsel {
 	struct perf_evsel	**metric_events;
 	bool			collect_stat;
 	bool			weak_group;
+	FILE			*dump_event_fp;
 };
 
 union u64_swap {
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index d549e50..c7ce621 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -2,6 +2,7 @@
 #define __PERF_TOOL_H
 
 #include <stdbool.h>
+#include <stdio.h>
 
 #include <linux/types.h>
 
@@ -75,6 +76,8 @@ struct perf_tool {
 	bool		ordered_events;
 	bool		ordering_requires_timestamps;
 	bool		namespace_events;
+	bool		per_event_dump;
+	const char	*last_evsel_name;
 	enum show_feature_header show_feat_hdr;
 };
 
-- 
1.8.3.1
