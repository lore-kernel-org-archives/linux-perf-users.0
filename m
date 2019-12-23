From: Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 9/9] perf script: Add --show-cgroup-events option
Date: Mon, 23 Dec 2019 15:07:59 +0900
Message-ID: <20191223060759.841176-10-namhyung@kernel.org>
References: <20191223060759.841176-1-namhyung@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191223060759.841176-1-namhyung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

The --show-cgroup-events option is to print CGROUP events in the
output like others.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-script.txt |  3 ++
 tools/perf/builtin-script.c              | 41 ++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 2599b057e47b..3dd297600427 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -319,6 +319,9 @@ OPTIONS
 --show-bpf-events
 	Display bpf events i.e. events of type PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT.
 
+--show-cgroup-events
+	Display cgroup events i.e. events of type PERF_RECORD_CGROUP.
+
 --demangle::
 	Demangle symbol names to human readable form. It's enabled by default,
 	disable with --no-demangle.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e2406b291c1c..3db4afc29430 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1681,6 +1681,7 @@ struct perf_script {
 	bool			show_lost_events;
 	bool			show_round_events;
 	bool			show_bpf_events;
+	bool			show_cgroup_events;
 	bool			allocated;
 	bool			per_event_dump;
 	struct evswitch		evswitch;
@@ -2199,6 +2200,41 @@ static int process_namespaces_event(struct perf_tool *tool,
 	return ret;
 }
 
+static int process_cgroup_event(struct perf_tool *tool,
+				union perf_event *event,
+				struct perf_sample *sample,
+				struct machine *machine)
+{
+	struct thread *thread;
+	struct perf_script *script = container_of(tool, struct perf_script, tool);
+	struct perf_session *session = script->session;
+	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	int ret = -1;
+
+	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
+	if (thread == NULL) {
+		pr_debug("problem processing CGROUP event, skipping it.\n");
+		return -1;
+	}
+
+	if (perf_event__process_cgroup(tool, event, sample, machine) < 0)
+		goto out;
+
+	if (!evsel->core.attr.sample_id_all) {
+		sample->cpu = 0;
+		sample->time = 0;
+	}
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_CGROUP, stdout);
+		perf_event__fprintf(event, stdout);
+	}
+	ret = 0;
+out:
+	thread__put(thread);
+	return ret;
+}
+
 static int process_fork_event(struct perf_tool *tool,
 			      union perf_event *event,
 			      struct perf_sample *sample,
@@ -2538,6 +2574,8 @@ static int __cmd_script(struct perf_script *script)
 		script->tool.context_switch = process_switch_event;
 	if (script->show_namespace_events)
 		script->tool.namespaces = process_namespaces_event;
+	if (script->show_cgroup_events)
+		script->tool.cgroup = process_cgroup_event;
 	if (script->show_lost_events)
 		script->tool.lost = process_lost_event;
 	if (script->show_round_events) {
@@ -3463,6 +3501,7 @@ int cmd_script(int argc, const char **argv)
 			.mmap2		 = perf_event__process_mmap2,
 			.comm		 = perf_event__process_comm,
 			.namespaces	 = perf_event__process_namespaces,
+			.cgroup		 = perf_event__process_cgroup,
 			.exit		 = perf_event__process_exit,
 			.fork		 = perf_event__process_fork,
 			.attr		 = process_attr,
@@ -3563,6 +3602,8 @@ int cmd_script(int argc, const char **argv)
 		    "Show context switch events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-namespace-events", &script.show_namespace_events,
 		    "Show namespace events (if recorded)"),
+	OPT_BOOLEAN('\0', "show-cgroup-events", &script.show_cgroup_events,
+		    "Show cgroup events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-lost-events", &script.show_lost_events,
 		    "Show lost events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-round-events", &script.show_round_events,
-- 
2.24.1.735.g03f4e72817-goog
