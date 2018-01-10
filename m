From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/27] perf script: Add support to display lost events
Date: Wed, 10 Jan 2018 18:28:38 -0300
Message-ID: <20180110212844.12441-22-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding option to display lost events:

  $ perf script --show-lost-events ...
   mplayer 13810 [002] 468011.402396:        100 cycles:ppp:  ff..
   mplayer 13810 [002] 468011.402396: PERF_RECORD_LOST lost 3880
   mplayer 13810 [002] 468011.402397:        100 cycles:ppp:  ff..

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180107160356.28203-10-jolsa@kernel.org
[ Use PRIu64 when printing u64 values, fixing the build in some arches ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt |  3 +++
 tools/perf/builtin-script.c              | 28 ++++++++++++++++++++++++++++
 tools/perf/util/event.c                  |  8 ++++++++
 3 files changed, 39 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 93ae8d60e3d3..806ec6391fd6 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -300,6 +300,9 @@ OPTIONS
 	Display context switch events i.e. events of type PERF_RECORD_SWITCH or
 	PERF_RECORD_SWITCH_CPU_WIDE.
 
+--show-lost-events
+	Display lost events i.e. events of type PERF_RECORD_LOST.
+
 --demangle::
 	Demangle symbol names to human readable form. It's enabled by default,
 	disable with --no-demangle.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index bb603495cf4a..c1cce474c0f1 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1489,6 +1489,7 @@ struct perf_script {
 	bool			show_mmap_events;
 	bool			show_switch_events;
 	bool			show_namespace_events;
+	bool			show_lost_events;
 	bool			allocated;
 	bool			per_event_dump;
 	struct cpu_map		*cpus;
@@ -2080,6 +2081,29 @@ static int process_switch_event(struct perf_tool *tool,
 	return 0;
 }
 
+static int
+process_lost_event(struct perf_tool *tool,
+		   union perf_event *event,
+		   struct perf_sample *sample,
+		   struct machine *machine)
+{
+	struct perf_script *script = container_of(tool, struct perf_script, tool);
+	struct perf_session *session = script->session;
+	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	struct thread *thread;
+
+	thread = machine__findnew_thread(machine, sample->pid,
+					 sample->tid);
+	if (thread == NULL)
+		return -1;
+
+	perf_sample__fprintf_start(sample, thread, evsel,
+				   PERF_RECORD_LOST, stdout);
+	perf_event__fprintf(event, stdout);
+	thread__put(thread);
+	return 0;
+}
+
 static void sig_handler(int sig __maybe_unused)
 {
 	session_done = 1;
@@ -2174,6 +2198,8 @@ static int __cmd_script(struct perf_script *script)
 		script->tool.context_switch = process_switch_event;
 	if (script->show_namespace_events)
 		script->tool.namespaces = process_namespaces_event;
+	if (script->show_lost_events)
+		script->tool.lost = process_lost_event;
 
 	if (perf_script__setup_per_event_dump(script)) {
 		pr_err("Couldn't create the per event dump files\n");
@@ -3110,6 +3136,8 @@ int cmd_script(int argc, const char **argv)
 		    "Show context switch events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-namespace-events", &script.show_namespace_events,
 		    "Show namespace events (if recorded)"),
+	OPT_BOOLEAN('\0', "show-lost-events", &script.show_lost_events,
+		    "Show lost events (if recorded)"),
 	OPT_BOOLEAN('\0', "per-event-dump", &script.per_event_dump,
 		    "Dump trace output to files named by the monitored events"),
 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 97a8ef9980db..44e603c27944 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1435,6 +1435,11 @@ size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp)
 		       event->context_switch.next_prev_tid);
 }
 
+static size_t perf_event__fprintf_lost(union perf_event *event, FILE *fp)
+{
+	return fprintf(fp, " lost %" PRIu64 "\n", event->lost.lost);
+}
+
 size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 {
 	size_t ret = fprintf(fp, "PERF_RECORD_%s",
@@ -1467,6 +1472,9 @@ size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 	case PERF_RECORD_SWITCH_CPU_WIDE:
 		ret += perf_event__fprintf_switch(event, fp);
 		break;
+	case PERF_RECORD_LOST:
+		ret += perf_event__fprintf_lost(event, fp);
+		break;
 	default:
 		ret += fprintf(fp, "\n");
 	}
-- 
2.14.3
