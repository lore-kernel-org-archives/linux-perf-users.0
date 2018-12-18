From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/63] perf trace: Allow selecting use the use of the ordered_events code
Date: Tue, 18 Dec 2018 19:06:37 -0300
Message-ID: <20181218220733.15839-8-acme@kernel.org>
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

I was trigger happy on this one, as using ordered_events as implemented
by Jiri for use with the --block code under discussion on lkml incurs
in delaying processing to form batches that then get ordered and then
printed.

With 'perf trace' we want to process the events as they go, without that
delay, and doing it that way works well for the common case which is to
trace a thread or a workload started by 'perf trace'.

So revert back to not using ordered_events but add an option to select
that mode so that users can experiment with their particular use case to
see if works better, i.e. if the added delay is not a problem and the
ordering helps.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8ki7sld6rusnjhhtaly26i5o@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-trace.txt |  6 ++++++
 tools/perf/builtin-trace.c              | 25 +++++++++++++++++++------
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index e113450503d2..631e687be4eb 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -205,6 +205,12 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	because the file may be huge. A time out is needed in such cases.
 	This option sets the time out limit. The default value is 500 ms.
 
+--sort-events::
+	Do sorting on batches of events, use when noticing out of order events that
+	may happen, for instance, when a thread gets migrated to a different CPU
+	while processing a syscall.
+
+
 PAGEFAULTS
 ----------
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1ff5603db940..406bceda6a2b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -110,6 +110,7 @@ struct trace {
 	} stats;
 	unsigned int		max_stack;
 	unsigned int		min_stack;
+	bool			sort_events;
 	bool			raw_augmented_syscalls;
 	bool			not_ev_qualifier;
 	bool			live;
@@ -2656,7 +2657,7 @@ static int __trace__deliver_event(struct trace *trace, union perf_event *event)
 	return 0;
 }
 
-static int trace__flush_events(struct trace *trace)
+static int __trace__flush_events(struct trace *trace)
 {
 	u64 first = ordered_events__first_time(&trace->oe.data);
 	u64 flush = trace->oe.last - NSEC_PER_SEC;
@@ -2668,12 +2669,19 @@ static int trace__flush_events(struct trace *trace)
 	return 0;
 }
 
+static int trace__flush_events(struct trace *trace)
+{
+	return !trace->sort_events ? 0 : __trace__flush_events(trace);
+}
+
 static int trace__deliver_event(struct trace *trace, union perf_event *event)
 {
-	struct perf_evlist *evlist = trace->evlist;
 	int err;
 
-	err = perf_evlist__parse_sample_timestamp(evlist, event, &trace->oe.last);
+	if (!trace->sort_events)
+		return __trace__deliver_event(trace, event);
+
+	err = perf_evlist__parse_sample_timestamp(trace->evlist, event, &trace->oe.last);
 	if (err && err != -1)
 		return err;
 
@@ -2897,7 +2905,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	perf_evlist__disable(evlist);
 
-	ordered_events__flush(&trace->oe.data, OE_FLUSH__FINAL);
+	if (trace->sort_events)
+		ordered_events__flush(&trace->oe.data, OE_FLUSH__FINAL);
 
 	if (!err) {
 		if (trace->summary)
@@ -3516,6 +3525,8 @@ int cmd_trace(int argc, const char **argv)
 		     "Set the maximum stack depth when parsing the callchain, "
 		     "anything beyond the specified depth will be ignored. "
 		     "Default: kernel.perf_event_max_stack or " __stringify(PERF_MAX_STACK_DEPTH)),
+	OPT_BOOLEAN(0, "sort-events", &trace.sort_events,
+			"Sort batch of events before processing, use if getting out of order events"),
 	OPT_BOOLEAN(0, "print-sample", &trace.print_sample,
 			"print the PERF_RECORD_SAMPLE PERF_SAMPLE_ info, for debugging"),
 	OPT_UINTEGER(0, "proc-map-timeout", &proc_map_timeout,
@@ -3609,8 +3620,10 @@ int cmd_trace(int argc, const char **argv)
 		}
 	}
 
-	ordered_events__init(&trace.oe.data, ordered_events__deliver_event, &trace);
-	ordered_events__set_copy_on_queue(&trace.oe.data, true);
+	if (trace.sort_events) {
+		ordered_events__init(&trace.oe.data, ordered_events__deliver_event, &trace);
+		ordered_events__set_copy_on_queue(&trace.oe.data, true);
+	}
 
 	/*
 	 * If we are augmenting syscalls, then combine what we put in the
-- 
2.19.2
