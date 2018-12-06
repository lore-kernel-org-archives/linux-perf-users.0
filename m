From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 75/75] perf trace: Add ordered processing
Date: Thu,  6 Dec 2018 18:26:02 -0300
Message-ID: <20181206212602.20474-76-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Dmitry Levin <ldv@altlinux.org>, Eugene Syromiatnikov <esyr@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@uudg.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Sort events to provide the precise outcome of ordered events, just like
is done with 'perf report' and 'perf top'.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Dmitry Levin <ldv@altlinux.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Luis Cláudio Gonçalves <lclaudio@uudg.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181205160509.1168-9-jolsa@kernel.org
[ split from a larger patch, added trace__ prefixes to new 'struct trace' methods ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 52 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 3b6b1fecf2bb..366ec3c8f580 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -127,6 +127,10 @@ struct trace {
 	bool			force;
 	bool			vfs_getname;
 	int			trace_pgfaults;
+	struct {
+		struct ordered_events	data;
+		u64			last;
+	} oe;
 };
 
 struct tp_field {
@@ -2652,6 +2656,42 @@ static int trace__deliver_event(struct trace *trace, union perf_event *event)
 	return 0;
 }
 
+static int trace__flush_ordered_events(struct trace *trace)
+{
+	u64 first = ordered_events__first_time(&trace->oe.data);
+	u64 flush = trace->oe.last - NSEC_PER_SEC;
+
+	/* Is there some thing to flush.. */
+	if (first && first < flush)
+		return ordered_events__flush_time(&trace->oe.data, flush);
+
+	return 0;
+}
+
+static int trace__deliver_ordered_event(struct trace *trace, union perf_event *event)
+{
+	struct perf_evlist *evlist = trace->evlist;
+	int err;
+
+	err = perf_evlist__parse_sample_timestamp(evlist, event, &trace->oe.last);
+	if (err && err != -1)
+		return err;
+
+	err = ordered_events__queue(&trace->oe.data, event, trace->oe.last, 0);
+	if (err)
+		return err;
+
+	return trace__flush_ordered_events(trace);
+}
+
+static int ordered_events__deliver_event(struct ordered_events *oe,
+					 struct ordered_event *event)
+{
+	struct trace *trace = container_of(oe, struct trace, oe.data);
+
+	return trace__deliver_event(trace, event->event);
+}
+
 static int trace__run(struct trace *trace, int argc, const char **argv)
 {
 	struct perf_evlist *evlist = trace->evlist;
@@ -2819,7 +2859,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		while ((event = perf_mmap__read_event(md)) != NULL) {
 			++trace->nr_events;
 
-			trace__deliver_event(trace, event);
+			err = trace__deliver_ordered_event(trace, event);
+			if (err)
+				goto out_disable;
 
 			perf_mmap__consume(md);
 
@@ -2842,6 +2884,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 				draining = true;
 
 			goto again;
+		} else {
+			if (trace__flush_ordered_events(trace))
+				goto out_disable;
 		}
 	} else {
 		goto again;
@@ -2852,6 +2897,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	perf_evlist__disable(evlist);
 
+	ordered_events__flush(&trace->oe.data, OE_FLUSH__FINAL);
+
 	if (!err) {
 		if (trace->summary)
 			trace__fprintf_thread_summary(trace, trace->output);
@@ -3562,6 +3609,9 @@ int cmd_trace(int argc, const char **argv)
 		}
 	}
 
+	ordered_events__init(&trace.oe.data, ordered_events__deliver_event, &trace);
+	ordered_events__set_copy_on_queue(&trace.oe.data, true);
+
 	/*
 	 * If we are augmenting syscalls, then combine what we put in the
 	 * __augmented_syscalls__ BPF map with what is in the
-- 
2.19.2
