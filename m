From: yuzhoujian <ufo19890607@gmail.com>
Subject: [PATCH v2 1/4] Add a new element for the struct perf_tool, and add the --per-event-dump option for perf script
Date: Tue, 26 Sep 2017 14:48:59 +0800
Message-ID: <1506408542-23564-2-git-send-email-yuzhoujian@didichuxing.com>
References: <1506408542-23564-1-git-send-email-yuzhoujian@didichuxing.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506408542-23564-1-git-send-email-yuzhoujian@didichuxing.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

This patch will add a new bool variable per_event_dump to mark the per-event-dump option,
and add the OPT_BOOLEAN for per-event-dump in the perf_data_file struct.

Changes since v1:
- remove the set for script.tool.per_event_dump variable,since the OPT_BOOLEAN
 will do the same thing.

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
---
 tools/perf/builtin-script.c | 3 +++
 tools/perf/util/tool.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9092de0..936af8b 100644
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
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index d549e50..ad40931 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -75,6 +75,7 @@ struct perf_tool {
 	bool		ordered_events;
 	bool		ordering_requires_timestamps;
 	bool		namespace_events;
+	bool		per_event_dump;
 	enum show_feature_header show_feat_hdr;
 };
 
-- 
1.8.3.1
