From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 77/86] perf tool: Add show_feature_header to perf_tool
Date: Wed, 19 Jul 2017 11:29:41 -0300
Message-ID: <20170719142950.3747-78-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

Add show_feat_hdr to control level of printed information of feature
headers.

Signed-off-by: David Carrillo-Cisneros <davidcc@google.com>
Acked-by: David Ahern <dsahern@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20170718042549.145161-15-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 4 ++++
 tools/perf/builtin-script.c | 3 +++
 tools/perf/util/tool.h      | 7 +++++++
 3 files changed, 14 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 79a33eb1a10d..40c3a92c8006 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -988,6 +988,10 @@ int cmd_report(int argc, const char **argv)
 	/* Force tty output for header output and per-thread stat. */
 	if (report.header || report.header_only || report.show_threads)
 		use_browser = 0;
+	if (report.header || report.header_only)
+		report.tool.show_feat_hdr = SHOW_FEAT_HEADER;
+	if (report.show_full_info)
+		report.tool.show_feat_hdr = SHOW_FEAT_HEADER_FULL_INFO;
 
 	if (strcmp(input_name, "-") != 0)
 		setup_browser(true);
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 83cdc0a61fd6..6e44552a0551 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2972,10 +2972,13 @@ int cmd_script(int argc, const char **argv)
 		return -1;
 
 	if (header || header_only) {
+		script.tool.show_feat_hdr = SHOW_FEAT_HEADER;
 		perf_session__fprintf_info(session, stdout, show_full_info);
 		if (header_only)
 			goto out_delete;
 	}
+	if (show_full_info)
+		script.tool.show_feat_hdr = SHOW_FEAT_HEADER_FULL_INFO;
 
 	if (symbol__init(&session->header.env) < 0)
 		goto out_delete;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 829471a1c6d7..baeca808dfda 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -34,6 +34,12 @@ typedef int (*event_oe)(struct perf_tool *tool, union perf_event *event,
 typedef s64 (*event_op3)(struct perf_tool *tool, union perf_event *event,
 			 struct perf_session *session);
 
+enum show_feature_header {
+	SHOW_FEAT_NO_HEADER = 0,
+	SHOW_FEAT_HEADER,
+	SHOW_FEAT_HEADER_FULL_INFO,
+};
+
 struct perf_tool {
 	event_sample	sample,
 			read;
@@ -68,6 +74,7 @@ struct perf_tool {
 	bool		ordered_events;
 	bool		ordering_requires_timestamps;
 	bool		namespace_events;
+	enum show_feature_header show_feat_hdr;
 };
 
 #endif /* __PERF_TOOL_H */
-- 
2.9.4
