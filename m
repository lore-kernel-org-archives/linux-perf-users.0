From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/19] perf script: Allow creating per-event dump files
Date: Fri,  3 Nov 2017 10:54:49 -0300
Message-ID: <20171103135503.4921-6-acme@kernel.org>
References: <20171103135503.4921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103135503.4921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Introduce a new option to dump trace output to files named by the
monitored events and update perf-script documentation accordingly.

Shown below is output of perf script command with the newly introduced
option.

         $ perf record -e cycles -e cs -ag -- sleep 1
         $ perf script --per-event-dump
         $ ls
         perf.data.cycles.dump perf.data.cs.dump

Without per-event-dump support, drawing flamegraphs for different events
would require post processing to separate events. You can monitor only
one event at a time if you want to get flamegraphs for different events.
Using this option, you can get the trace output files named by the
monitored events, and could draw flamegraphs according to the event's
name.

Based-on-a-patch-by: yuzhoujian <yuzhoujian@didichuxing.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1508921599-10832-3-git-send-email-yuzhoujian@didichuxing.com
Link: http://lkml.kernel.org/n/tip-8ngzsjdhgiovkupl3r5yy570@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt |  4 +++
 tools/perf/builtin-script.c              | 59 +++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 25e677344728..2811fcf684cb 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -325,6 +325,10 @@ include::itrace.txt[]
 	Set the maximum number of program blocks to print with brstackasm for
 	each sample.
 
+--per-event-dump::
+	Create per event files with a "perf.data.EVENT.dump" name instead of
+        printing to stdout, useful, for instance, for generating flamegraphs.
+
 --inline::
 	If a callgraph address belongs to an inlined function, the inline stack
 	will be printed. Each entry has function name and file/line. Enabled by
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b27f21638207..fb5e49b3bc44 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1392,6 +1392,7 @@ struct perf_script {
 	bool			show_switch_events;
 	bool			show_namespace_events;
 	bool			allocated;
+	bool			per_event_dump;
 	struct cpu_map		*cpus;
 	struct thread_map	*threads;
 	int			name_width;
@@ -1438,7 +1439,7 @@ static void process_event(struct perf_script *script,
 	struct thread *thread = al->thread;
 	struct perf_event_attr *attr = &evsel->attr;
 	unsigned int type = output_type(attr->type);
-	FILE *fp = stdout;
+	FILE *fp = evsel->priv;
 
 	if (output[type].fields == 0)
 		return;
@@ -1887,6 +1888,52 @@ static void sig_handler(int sig __maybe_unused)
 	session_done = 1;
 }
 
+static void perf_script__fclose_per_event_dump(struct perf_script *script)
+{
+	struct perf_evlist *evlist = script->session->evlist;
+	struct perf_evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (!evsel->priv)
+			break;
+		fclose(evsel->priv);
+		evsel->priv = NULL;
+	}
+}
+
+static int perf_script__fopen_per_event_dump(struct perf_script *script)
+{
+	struct perf_evsel *evsel;
+
+	evlist__for_each_entry(script->session->evlist, evsel) {
+		char filename[PATH_MAX];
+		snprintf(filename, sizeof(filename), "%s.%s.dump",
+			 script->session->file->path, perf_evsel__name(evsel));
+		evsel->priv = fopen(filename, "w");
+		if (evsel->priv == NULL)
+			goto out_err_fclose;
+	}
+
+	return 0;
+
+out_err_fclose:
+	perf_script__fclose_per_event_dump(script);
+	return -1;
+}
+
+static int perf_script__setup_per_event_dump(struct perf_script *script)
+{
+	struct perf_evsel *evsel;
+
+	if (script->per_event_dump)
+		return perf_script__fopen_per_event_dump(script);
+
+	evlist__for_each_entry(script->session->evlist, evsel)
+		evsel->priv = stdout;
+
+	return 0;
+}
+
 static int __cmd_script(struct perf_script *script)
 {
 	int ret;
@@ -1908,8 +1955,16 @@ static int __cmd_script(struct perf_script *script)
 	if (script->show_namespace_events)
 		script->tool.namespaces = process_namespaces_event;
 
+	if (perf_script__setup_per_event_dump(script)) {
+		pr_err("Couldn't create the per event dump files\n");
+		return -1;
+	}
+
 	ret = perf_session__process_events(script->session);
 
+	if (script->per_event_dump)
+		perf_script__fclose_per_event_dump(script);
+
 	if (debug_mode)
 		pr_err("Misordered timestamps: %" PRIu64 "\n", nr_unordered);
 
@@ -2827,6 +2882,8 @@ int cmd_script(int argc, const char **argv)
 		    "Show context switch events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-namespace-events", &script.show_namespace_events,
 		    "Show namespace events (if recorded)"),
+	OPT_BOOLEAN('\0', "per-event-dump", &script.per_event_dump,
+		    "Dump trace output to files named by the monitored events"),
 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
 	OPT_INTEGER(0, "max-blocks", &max_blocks,
 		    "Maximum number of code blocks to dump with brstackinsn"),
-- 
2.13.6
