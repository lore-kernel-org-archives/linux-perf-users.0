From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH v2] perf inject: Make it possible to merge raw_syscalls:sys_enter/exit
Date: Fri, 12 Aug 2016 23:38:57 +0200
Message-ID: <20160812213857.24006-1-milian.wolff@kdab.com>
References: <1459554637-22126-1-git-send-email-milian.wolff@kdab.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:59514 "EHLO mail.kdab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752793AbcHLVj3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 12 Aug 2016 17:39:29 -0400
In-Reply-To: <1459554637-22126-1-git-send-email-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@kernel.org, Milian Wolff <milian.wolff@kdab.com>

This makes it much more useful to report data recorded with
`perf trace record`. E.g.:

    #include <unistd.h>

    int main()
    {
        sleep(1);
        usleep(1000);
        usleep(1);
        return 0;
    }

    Compile and trace it:

# gcc -g sleep.c -o ex_sleep
# perf trace record --call-graph dwarf ex_sleep

Previously, the report is not so useful as it aggregates by the number
of syscalls:

# perf report --stdio --show-nr-samples --show-total-period \
              --no-children --sort sym --max-stack 1

    #
    # Samples: 46  of event 'raw_syscalls:sys_enter'
    # Event count (approx.): 46
    #
    # Overhead       Samples        Period  Symbol
    # ........  ............  ............  ..............................
    #
    100.00%            46            46  [k] syscall_trace_enter_phase2
                |
                |--30.43%--open64
                |
                |--17.39%--_xstat
                |
                |--15.22%--mmap64
                |
                |--8.70%--mprotect
                |
                |--6.52%--__nanosleep
                |
                |--4.35%--close
                |
                |--4.35%--_fxstat
                |
                |--2.17%--_exit
                |
                |--2.17%--munmap
                |
                |--2.17%--access
                |
                |--2.17%--read
                |
                |--2.17%--brk
                |
                |--2.17%--init_tls

And then the same for sys_exit. Note how the period count equals the
sample count. Yes, open, stat and mmap are called often, but are
these syscalls really expensive? Hard to tell.

This patch adds a new inject command to aggregate the
sys_enter and sys_exit events and sets the period to the elapsed time:

# perf inject -t -i perf.data -o perf.data.merged

This makes the report much nicer:

# perf report --stdio --show-total-period --no-children --sort sym \
              --max-stack 1  -i perf.data.merged

    #
    # Total Lost Samples: 0
    #
    # Samples: 45  of event 'raw_syscalls:sys_enter'
    # Event count (approx.): 1001520568
    #
    # Overhead        Period  Symbol
    # ........  ............  ..............................
    #
    100.00%    1001520568  [k] syscall_trace_enter_phase2
                |
                |--99.99%--__nanosleep

Note that the other syscalls in this example are so cheap they are
filtered out of the report by default. You can bring them back via
e.g. `--call-graph graph,0`, or by omitting `--no-children` or
via --percent-limit 0.

The report of the merged data can also again use the raw number
of syscalls for merging, with a pretty unwieldy command:

# perf report -i perf.data.merged --sort sym --show-nr-samples \
              -g graph,0,caller,function,count --stdio --max-stack 1

    #
    # Samples: 45  of event 'raw_syscalls:sys_enter'
    # Event count (approx.): 1001520568
    #
    # Children      Self       Samples  Symbol
    # ........  ........  ............  ..............................
    #
    100.00%   100.00%            45  [k] syscall_trace_enter_phase2
                |
                |--3--__nanosleep
                |
                |--14--open64
                |
                |--7--mmap64
                |
                |--8--_xstat
                |
                |--4--mprotect
                |
                |--1--munmap
                |
                |--2--_fxstat
                |
                |--1--access
                |
                |--2--close
                |
                |--1--read
                |
                |--1--init_tls
                |
                |--1--brk

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/builtin-inject.c | 154 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 126 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 73c1c4c..f1d5a8d 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -31,6 +31,7 @@ struct perf_inject {
 	bool			have_auxtrace;
 	bool			strip;
 	bool			jit_mode;
+	bool			trace;
 	const char		*input_name;
 	struct perf_data_file	output;
 	u64			bytes_written;
@@ -451,17 +452,14 @@ repipe:
 	return 0;
 }
 
-static int perf_inject__sched_process_exit(struct perf_tool *tool,
-					   union perf_event *event __maybe_unused,
-					   struct perf_sample *sample,
-					   struct perf_evsel *evsel __maybe_unused,
-					   struct machine *machine __maybe_unused)
+static int perf_inject__free_cloned_event(struct perf_tool *tool,
+					  u32 tid)
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
 	struct event_entry *ent;
 
 	list_for_each_entry(ent, &inject->samples, node) {
-		if (sample->tid == ent->tid) {
+		if (tid == ent->tid) {
 			list_del_init(&ent->node);
 			free(ent);
 			break;
@@ -471,21 +469,18 @@ static int perf_inject__sched_process_exit(struct perf_tool *tool,
 	return 0;
 }
 
-static int perf_inject__sched_switch(struct perf_tool *tool,
-				     union perf_event *event,
-				     struct perf_sample *sample,
-				     struct perf_evsel *evsel,
-				     struct machine *machine)
+static int perf_inject__clone_event(struct perf_tool *tool,
+				    union perf_event *event,
+				    struct perf_sample *sample)
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
 	struct event_entry *ent;
 
-	perf_inject__sched_process_exit(tool, event, sample, evsel, machine);
-
+	perf_inject__free_cloned_event(tool, sample->tid);
 	ent = malloc(event->header.size + sizeof(struct event_entry));
 	if (ent == NULL) {
 		color_fprintf(stderr, PERF_COLOR_RED,
-			     "Not enough memory to process sched switch event!");
+			     "Not enough memory to clone event!");
 		return -1;
 	}
 
@@ -495,35 +490,104 @@ static int perf_inject__sched_switch(struct perf_tool *tool,
 	return 0;
 }
 
+static struct event_entry *perf_inject__find_cloned_event(struct perf_tool *tool,
+							  u32 tid)
+{
+	struct event_entry *ent;
+	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
+
+	list_for_each_entry(ent, &inject->samples, node) {
+		if (tid == ent->tid)
+			return ent;
+	}
+	return NULL;
+}
+
+static int perf_inject__repipe_cloned_event_sample(struct perf_tool *tool,
+						   struct perf_evsel *evsel,
+						   struct machine *machine,
+						   union perf_event *event_sw,
+						   struct perf_sample sample_sw)
+{
+	perf_event__synthesize_sample(event_sw, evsel->attr.sample_type,
+				      evsel->attr.read_format, &sample_sw,
+				      false);
+	build_id__mark_dso_hit(tool, event_sw, &sample_sw, evsel, machine);
+	return perf_event__repipe(tool, event_sw, &sample_sw, machine);
+}
+
+static int perf_inject__sched_process_exit(struct perf_tool *tool,
+					   union perf_event *event __maybe_unused,
+					   struct perf_sample *sample,
+					   struct perf_evsel *evsel __maybe_unused,
+					   struct machine *machine __maybe_unused)
+{
+	perf_inject__free_cloned_event(tool, sample->tid);
+	return 0;
+}
+
+static int perf_inject__sched_switch(struct perf_tool *tool,
+				     union perf_event *event,
+				     struct perf_sample *sample,
+				     struct perf_evsel *evsel __maybe_unused,
+				     struct machine *machine __maybe_unused)
+{
+	return perf_inject__clone_event(tool, event, sample);
+}
+
 static int perf_inject__sched_stat(struct perf_tool *tool,
 				   union perf_event *event __maybe_unused,
 				   struct perf_sample *sample,
 				   struct perf_evsel *evsel,
 				   struct machine *machine)
 {
-	struct event_entry *ent;
 	union perf_event *event_sw;
 	struct perf_sample sample_sw;
-	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
 	u32 pid = perf_evsel__intval(evsel, sample, "pid");
+	struct event_entry *ent = perf_inject__find_cloned_event(tool, pid);
 
-	list_for_each_entry(ent, &inject->samples, node) {
-		if (pid == ent->tid)
-			goto found;
-	}
+	if (ent == NULL)
+		return 0;
 
-	return 0;
-found:
 	event_sw = &ent->event[0];
 	perf_evsel__parse_sample(evsel, event_sw, &sample_sw);
 
 	sample_sw.period = sample->period;
 	sample_sw.time	 = sample->time;
-	perf_event__synthesize_sample(event_sw, evsel->attr.sample_type,
-				      evsel->attr.read_format, &sample_sw,
-				      false);
-	build_id__mark_dso_hit(tool, event_sw, &sample_sw, evsel, machine);
-	return perf_event__repipe(tool, event_sw, &sample_sw, machine);
+
+	return perf_inject__repipe_cloned_event_sample(tool, evsel, machine,
+						       event_sw, sample_sw);
+}
+
+static int perf_inject__raw_syscalls_sys_enter(struct perf_tool *tool,
+				     union perf_event *event,
+				     struct perf_sample *sample,
+				     struct perf_evsel *evsel __maybe_unused,
+				     struct machine *machine __maybe_unused)
+{
+	return perf_inject__clone_event(tool, event, sample);
+}
+
+static int perf_inject__raw_syscalls_sys_exit(struct perf_tool *tool,
+				   union perf_event *event __maybe_unused,
+				   struct perf_sample *sample,
+				   struct perf_evsel *evsel,
+				   struct machine *machine)
+{
+	union perf_event *event_sw;
+	struct perf_sample sample_sw;
+	struct event_entry *ent = perf_inject__find_cloned_event(tool, sample->tid);
+
+	if (ent == NULL)
+		return 0;
+
+	event_sw = &ent->event[0];
+	perf_evsel__parse_sample(evsel, event_sw, &sample_sw);
+
+	sample_sw.period = sample->time - sample_sw.time;
+
+	return perf_inject__repipe_cloned_event_sample(tool, evsel, machine,
+						       event_sw, sample_sw);
 }
 
 static void sig_handler(int sig __maybe_unused)
@@ -656,6 +720,24 @@ static int __cmd_inject(struct perf_inject *inject)
 			else if (!strncmp(name, "sched:sched_stat_", 17))
 				evsel->handler = perf_inject__sched_stat;
 		}
+	} else if (inject->trace) {
+		struct perf_evsel *evsel;
+
+		evlist__for_each_entry(session->evlist, evsel) {
+			const char *name = perf_evsel__name(evsel);
+
+			if (!strcmp(name, "raw_syscalls:sys_exit")) {
+				if (perf_evsel__check_stype(evsel, PERF_SAMPLE_TID, "TID"))
+					return -EINVAL;
+
+				evsel->handler = perf_inject__raw_syscalls_sys_exit;
+			} else if (!strcmp(name, "raw_syscalls:sys_enter")) {
+				if (perf_evsel__check_stype(evsel, PERF_SAMPLE_TID, "TID"))
+					return -EINVAL;
+
+				evsel->handler = perf_inject__raw_syscalls_sys_enter;
+			}
+		}
 	} else if (inject->itrace_synth_opts.set) {
 		session->itrace_synth_opts = &inject->itrace_synth_opts;
 		inject->itrace_synth_opts.inject = true;
@@ -717,6 +799,19 @@ static int __cmd_inject(struct perf_inject *inject)
 			if (inject->strip)
 				strip_fini(inject);
 		}
+		if (inject->trace) {
+			// remove the now empty sys_exit event list
+			struct perf_evsel *evsel, *tmp;
+
+			evlist__for_each_entry_safe(session->evlist, tmp, evsel) {
+				const char *name = perf_evsel__name(evsel);
+
+				if (!strcmp(name, "raw_syscalls:sys_exit")) {
+				    perf_evlist__remove(session->evlist, evsel);
+				    perf_evsel__delete(evsel);
+				}
+			}
+		}
 		session->header.data_offset = output_data_offset;
 		session->header.data_size = inject->bytes_written;
 		perf_session__write_header(session, session->evlist, fd, true);
@@ -775,6 +870,9 @@ int cmd_inject(int argc, const char **argv, const char *prefix __maybe_unused)
 		OPT_BOOLEAN('s', "sched-stat", &inject.sched_stat,
 			    "Merge sched-stat and sched-switch for getting events "
 			    "where and how long tasks slept"),
+		OPT_BOOLEAN('t', "trace", &inject.trace,
+			    "Merge raw_syscalls:sys_enter and raw_syscalls:sys_exit trace "
+			    "events to measure how long the individual syscalls took"),
 #ifdef HAVE_JITDUMP
 		OPT_BOOLEAN('j', "jit", &inject.jit_mode, "merge jitdump files into perf.data file"),
 #endif
@@ -815,7 +913,7 @@ int cmd_inject(int argc, const char **argv, const char *prefix __maybe_unused)
 		return -1;
 	}
 
-	inject.tool.ordered_events = inject.sched_stat;
+	inject.tool.ordered_events = inject.sched_stat || inject.trace;
 
 	file.path = inject.input_name;
 	inject.session = perf_session__new(&file, true, &inject.tool);
-- 
2.9.2
