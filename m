From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/63] perf trace: Rename delivery functions to ease making ordered_events selectable
Date: Tue, 18 Dec 2018 19:06:36 -0300
Message-ID: <20181218220733.15839-7-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just hide a bit more how events gets delivered, hiding ordered_events
details from the main loop.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lxwwf3238ta4neq2zh1y1h45@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 366ec3c8f580..1ff5603db940 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2641,7 +2641,7 @@ static int trace__set_filter_pids(struct trace *trace)
 	return err;
 }
 
-static int trace__deliver_event(struct trace *trace, union perf_event *event)
+static int __trace__deliver_event(struct trace *trace, union perf_event *event)
 {
 	struct perf_evlist *evlist = trace->evlist;
 	struct perf_sample sample;
@@ -2656,7 +2656,7 @@ static int trace__deliver_event(struct trace *trace, union perf_event *event)
 	return 0;
 }
 
-static int trace__flush_ordered_events(struct trace *trace)
+static int trace__flush_events(struct trace *trace)
 {
 	u64 first = ordered_events__first_time(&trace->oe.data);
 	u64 flush = trace->oe.last - NSEC_PER_SEC;
@@ -2668,7 +2668,7 @@ static int trace__flush_ordered_events(struct trace *trace)
 	return 0;
 }
 
-static int trace__deliver_ordered_event(struct trace *trace, union perf_event *event)
+static int trace__deliver_event(struct trace *trace, union perf_event *event)
 {
 	struct perf_evlist *evlist = trace->evlist;
 	int err;
@@ -2681,7 +2681,7 @@ static int trace__deliver_ordered_event(struct trace *trace, union perf_event *e
 	if (err)
 		return err;
 
-	return trace__flush_ordered_events(trace);
+	return trace__flush_events(trace);
 }
 
 static int ordered_events__deliver_event(struct ordered_events *oe,
@@ -2689,7 +2689,7 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 {
 	struct trace *trace = container_of(oe, struct trace, oe.data);
 
-	return trace__deliver_event(trace, event->event);
+	return __trace__deliver_event(trace, event->event);
 }
 
 static int trace__run(struct trace *trace, int argc, const char **argv)
@@ -2859,7 +2859,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		while ((event = perf_mmap__read_event(md)) != NULL) {
 			++trace->nr_events;
 
-			err = trace__deliver_ordered_event(trace, event);
+			err = trace__deliver_event(trace, event);
 			if (err)
 				goto out_disable;
 
@@ -2885,7 +2885,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 			goto again;
 		} else {
-			if (trace__flush_ordered_events(trace))
+			if (trace__flush_events(trace))
 				goto out_disable;
 		}
 	} else {
-- 
2.19.2
