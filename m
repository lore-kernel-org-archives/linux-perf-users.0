From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/27] perf tools: Make the tool's warning messages optional
Date: Wed, 10 Jan 2018 18:28:39 -0300
Message-ID: <20180110212844.12441-23-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

I want to display the pure events status coming in the next patch and
the tool's warnings are superfluous in the output. Making it optional,
enabled by default.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180107160356.28203-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 6 ++++--
 tools/perf/util/tool.h    | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 54e30f1bcbd7..8d0fa2f8da16 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1773,7 +1773,8 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 	err = perf_session__flush_thread_stacks(session);
 out_err:
 	free(buf);
-	perf_session__warn_about_errors(session);
+	if (!tool->no_warn)
+		perf_session__warn_about_errors(session);
 	ordered_events__free(&session->ordered_events);
 	auxtrace__free_events(session);
 	return err;
@@ -1929,7 +1930,8 @@ static int __perf_session__process_events(struct perf_session *session,
 	err = perf_session__flush_thread_stacks(session);
 out_err:
 	ui_progress__finish();
-	perf_session__warn_about_errors(session);
+	if (!tool->no_warn)
+		perf_session__warn_about_errors(session);
 	/*
 	 * We may switching perf.data output, make ordered_events
 	 * reusable.
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 2532b558099b..183c91453522 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -76,6 +76,7 @@ struct perf_tool {
 	bool		ordered_events;
 	bool		ordering_requires_timestamps;
 	bool		namespace_events;
+	bool		no_warn;
 	enum show_feature_header show_feat_hdr;
 };
 
-- 
2.14.3
