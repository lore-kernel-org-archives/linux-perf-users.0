From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/60] perf script: Simplify auxiliary event printing functions
Date: Mon, 20 Apr 2020 08:52:33 -0300
Message-ID: <20200420115316.18781-18-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

This simplifies the print functions for the following perf script
options:

	--show-task-events
	--show-namespace-events
	--show-cgroup-events
	--show-mmap-events
	--show-switch-events
	--show-lost-events
	--show-bpf-events

Example:
	# perf record --switch-events -a -e cycles -c 10000 sleep 1
 Before:
	# perf script --show-task-events --show-namespace-events --show-cgroup-events --show-mmap-events --show-switch-events --show-lost-events --show-bpf-events > out-before.txt
 After:
	# perf script --show-task-events --show-namespace-events --show-cgroup-events --show-mmap-events --show-switch-events --show-lost-events --show-bpf-events > out-after.txt
	# diff -s out-before.txt out-after.txt
	Files out-before.txt and out-after.tx are identical

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200402141548.21283-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 304 ++++++++----------------------------
 1 file changed, 66 insertions(+), 238 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 1f57a7ecdf3d..8bf3ba280312 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2040,7 +2040,7 @@ static int cleanup_scripting(void)
 
 static bool filter_cpu(struct perf_sample *sample)
 {
-	if (cpu_list)
+	if (cpu_list && sample->cpu != (u32)-1)
 		return !test_bit(sample->cpu, cpu_bitmap);
 	return false;
 }
@@ -2138,41 +2138,59 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	return err;
 }
 
-static int process_comm_event(struct perf_tool *tool,
-			      union perf_event *event,
-			      struct perf_sample *sample,
-			      struct machine *machine)
+static int print_event_with_time(struct perf_tool *tool,
+				 union perf_event *event,
+				 struct perf_sample *sample,
+				 struct machine *machine,
+				 pid_t pid, pid_t tid, u64 timestamp)
 {
-	struct thread *thread;
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
 	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
-	int ret = -1;
+	struct thread *thread = NULL;
 
-	thread = machine__findnew_thread(machine, event->comm.pid, event->comm.tid);
-	if (thread == NULL) {
-		pr_debug("problem processing COMM event, skipping it.\n");
-		return -1;
+	if (evsel && !evsel->core.attr.sample_id_all) {
+		sample->cpu = 0;
+		sample->time = timestamp;
+		sample->pid = pid;
+		sample->tid = tid;
 	}
 
-	if (perf_event__process_comm(tool, event, sample, machine) < 0)
-		goto out;
+	if (filter_cpu(sample))
+		return 0;
 
-	if (!evsel->core.attr.sample_id_all) {
-		sample->cpu = 0;
-		sample->time = 0;
-		sample->tid = event->comm.tid;
-		sample->pid = event->comm.pid;
-	}
-	if (!filter_cpu(sample)) {
+	if (tid != -1)
+		thread = machine__findnew_thread(machine, pid, tid);
+
+	if (thread && evsel) {
 		perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_COMM, stdout);
-		perf_event__fprintf(event, stdout);
+					   event->header.type, stdout);
 	}
-	ret = 0;
-out:
+
+	perf_event__fprintf(event, stdout);
+
 	thread__put(thread);
-	return ret;
+
+	return 0;
+}
+
+static int print_event(struct perf_tool *tool, union perf_event *event,
+		       struct perf_sample *sample, struct machine *machine,
+		       pid_t pid, pid_t tid)
+{
+	return print_event_with_time(tool, event, sample, machine, pid, tid, 0);
+}
+
+static int process_comm_event(struct perf_tool *tool,
+			      union perf_event *event,
+			      struct perf_sample *sample,
+			      struct machine *machine)
+{
+	if (perf_event__process_comm(tool, event, sample, machine) < 0)
+		return -1;
+
+	return print_event(tool, event, sample, machine, event->comm.pid,
+			   event->comm.tid);
 }
 
 static int process_namespaces_event(struct perf_tool *tool,
@@ -2180,37 +2198,11 @@ static int process_namespaces_event(struct perf_tool *tool,
 				    struct perf_sample *sample,
 				    struct machine *machine)
 {
-	struct thread *thread;
-	struct perf_script *script = container_of(tool, struct perf_script, tool);
-	struct perf_session *session = script->session;
-	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
-	int ret = -1;
-
-	thread = machine__findnew_thread(machine, event->namespaces.pid,
-					 event->namespaces.tid);
-	if (thread == NULL) {
-		pr_debug("problem processing NAMESPACES event, skipping it.\n");
-		return -1;
-	}
-
 	if (perf_event__process_namespaces(tool, event, sample, machine) < 0)
-		goto out;
+		return -1;
 
-	if (!evsel->core.attr.sample_id_all) {
-		sample->cpu = 0;
-		sample->time = 0;
-		sample->tid = event->namespaces.tid;
-		sample->pid = event->namespaces.pid;
-	}
-	if (!filter_cpu(sample)) {
-		perf_sample__fprintf_start(sample, thread, evsel,
-					   PERF_RECORD_NAMESPACES, stdout);
-		perf_event__fprintf(event, stdout);
-	}
-	ret = 0;
-out:
-	thread__put(thread);
-	return ret;
+	return print_event(tool, event, sample, machine, event->namespaces.pid,
+			   event->namespaces.tid);
 }
 
 static int process_cgroup_event(struct perf_tool *tool,
@@ -2218,34 +2210,11 @@ static int process_cgroup_event(struct perf_tool *tool,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
-	struct thread *thread;
-	struct perf_script *script = container_of(tool, struct perf_script, tool);
-	struct perf_session *session = script->session;
-	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
-	int ret = -1;
-
-	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
-	if (thread == NULL) {
-		pr_debug("problem processing CGROUP event, skipping it.\n");
-		return -1;
-	}
-
 	if (perf_event__process_cgroup(tool, event, sample, machine) < 0)
-		goto out;
+		return -1;
 
-	if (!evsel->core.attr.sample_id_all) {
-		sample->cpu = 0;
-		sample->time = 0;
-	}
-	if (!filter_cpu(sample)) {
-		perf_sample__fprintf_start(sample, thread, evsel,
-					   PERF_RECORD_CGROUP, stdout);
-		perf_event__fprintf(event, stdout);
-	}
-	ret = 0;
-out:
-	thread__put(thread);
-	return ret;
+	return print_event(tool, event, sample, machine, sample->pid,
+			    sample->tid);
 }
 
 static int process_fork_event(struct perf_tool *tool,
@@ -2253,69 +2222,24 @@ static int process_fork_event(struct perf_tool *tool,
 			      struct perf_sample *sample,
 			      struct machine *machine)
 {
-	struct thread *thread;
-	struct perf_script *script = container_of(tool, struct perf_script, tool);
-	struct perf_session *session = script->session;
-	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
-
 	if (perf_event__process_fork(tool, event, sample, machine) < 0)
 		return -1;
 
-	thread = machine__findnew_thread(machine, event->fork.pid, event->fork.tid);
-	if (thread == NULL) {
-		pr_debug("problem processing FORK event, skipping it.\n");
-		return -1;
-	}
-
-	if (!evsel->core.attr.sample_id_all) {
-		sample->cpu = 0;
-		sample->time = event->fork.time;
-		sample->tid = event->fork.tid;
-		sample->pid = event->fork.pid;
-	}
-	if (!filter_cpu(sample)) {
-		perf_sample__fprintf_start(sample, thread, evsel,
-					   PERF_RECORD_FORK, stdout);
-		perf_event__fprintf(event, stdout);
-	}
-	thread__put(thread);
-
-	return 0;
+	return print_event_with_time(tool, event, sample, machine,
+				     event->fork.pid, event->fork.tid,
+				     event->fork.time);
 }
 static int process_exit_event(struct perf_tool *tool,
 			      union perf_event *event,
 			      struct perf_sample *sample,
 			      struct machine *machine)
 {
-	int err = 0;
-	struct thread *thread;
-	struct perf_script *script = container_of(tool, struct perf_script, tool);
-	struct perf_session *session = script->session;
-	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
-
-	thread = machine__findnew_thread(machine, event->fork.pid, event->fork.tid);
-	if (thread == NULL) {
-		pr_debug("problem processing EXIT event, skipping it.\n");
+	/* Print before 'exit' deletes anything */
+	if (print_event_with_time(tool, event, sample, machine, event->fork.pid,
+				  event->fork.tid, event->fork.time))
 		return -1;
-	}
-
-	if (!evsel->core.attr.sample_id_all) {
-		sample->cpu = 0;
-		sample->time = 0;
-		sample->tid = event->fork.tid;
-		sample->pid = event->fork.pid;
-	}
-	if (!filter_cpu(sample)) {
-		perf_sample__fprintf_start(sample, thread, evsel,
-					   PERF_RECORD_EXIT, stdout);
-		perf_event__fprintf(event, stdout);
-	}
 
-	if (perf_event__process_exit(tool, event, sample, machine) < 0)
-		err = -1;
-
-	thread__put(thread);
-	return err;
+	return perf_event__process_exit(tool, event, sample, machine);
 }
 
 static int process_mmap_event(struct perf_tool *tool,
@@ -2323,33 +2247,11 @@ static int process_mmap_event(struct perf_tool *tool,
 			      struct perf_sample *sample,
 			      struct machine *machine)
 {
-	struct thread *thread;
-	struct perf_script *script = container_of(tool, struct perf_script, tool);
-	struct perf_session *session = script->session;
-	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
-
 	if (perf_event__process_mmap(tool, event, sample, machine) < 0)
 		return -1;
 
-	thread = machine__findnew_thread(machine, event->mmap.pid, event->mmap.tid);
-	if (thread == NULL) {
-		pr_debug("problem processing MMAP event, skipping it.\n");
-		return -1;
-	}
-
-	if (!evsel->core.attr.sample_id_all) {
-		sample->cpu = 0;
-		sample->time = 0;
-		sample->tid = event->mmap.tid;
-		sample->pid = event->mmap.pid;
-	}
-	if (!filter_cpu(sample)) {
-		perf_sample__fprintf_start(sample, thread, evsel,
-					   PERF_RECORD_MMAP, stdout);
-		perf_event__fprintf(event, stdout);
-	}
-	thread__put(thread);
-	return 0;
+	return print_event(tool, event, sample, machine, event->mmap.pid,
+			   event->mmap.tid);
 }
 
 static int process_mmap2_event(struct perf_tool *tool,
@@ -2357,33 +2259,11 @@ static int process_mmap2_event(struct perf_tool *tool,
 			      struct perf_sample *sample,
 			      struct machine *machine)
 {
-	struct thread *thread;
-	struct perf_script *script = container_of(tool, struct perf_script, tool);
-	struct perf_session *session = script->session;
-	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
-
 	if (perf_event__process_mmap2(tool, event, sample, machine) < 0)
 		return -1;
 
-	thread = machine__findnew_thread(machine, event->mmap2.pid, event->mmap2.tid);
-	if (thread == NULL) {
-		pr_debug("problem processing MMAP2 event, skipping it.\n");
-		return -1;
-	}
-
-	if (!evsel->core.attr.sample_id_all) {
-		sample->cpu = 0;
-		sample->time = 0;
-		sample->tid = event->mmap2.tid;
-		sample->pid = event->mmap2.pid;
-	}
-	if (!filter_cpu(sample)) {
-		perf_sample__fprintf_start(sample, thread, evsel,
-					   PERF_RECORD_MMAP2, stdout);
-		perf_event__fprintf(event, stdout);
-	}
-	thread__put(thread);
-	return 0;
+	return print_event(tool, event, sample, machine, event->mmap2.pid,
+			   event->mmap2.tid);
 }
 
 static int process_switch_event(struct perf_tool *tool,
@@ -2391,10 +2271,7 @@ static int process_switch_event(struct perf_tool *tool,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
-	struct thread *thread;
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
-	struct perf_session *session = script->session;
-	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 
 	if (perf_event__process_switch(tool, event, sample, machine) < 0)
 		return -1;
@@ -2405,20 +2282,8 @@ static int process_switch_event(struct perf_tool *tool,
 	if (!script->show_switch_events)
 		return 0;
 
-	thread = machine__findnew_thread(machine, sample->pid,
-					 sample->tid);
-	if (thread == NULL) {
-		pr_debug("problem processing SWITCH event, skipping it.\n");
-		return -1;
-	}
-
-	if (!filter_cpu(sample)) {
-		perf_sample__fprintf_start(sample, thread, evsel,
-					   PERF_RECORD_SWITCH, stdout);
-		perf_event__fprintf(event, stdout);
-	}
-	thread__put(thread);
-	return 0;
+	return print_event(tool, event, sample, machine, sample->pid,
+			   sample->tid);
 }
 
 static int
@@ -2427,23 +2292,8 @@ process_lost_event(struct perf_tool *tool,
 		   struct perf_sample *sample,
 		   struct machine *machine)
 {
-	struct perf_script *script = container_of(tool, struct perf_script, tool);
-	struct perf_session *session = script->session;
-	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
-	struct thread *thread;
-
-	thread = machine__findnew_thread(machine, sample->pid,
-					 sample->tid);
-	if (thread == NULL)
-		return -1;
-
-	if (!filter_cpu(sample)) {
-		perf_sample__fprintf_start(sample, thread, evsel,
-					   PERF_RECORD_LOST, stdout);
-		perf_event__fprintf(event, stdout);
-	}
-	thread__put(thread);
-	return 0;
+	return print_event(tool, event, sample, machine, sample->pid,
+			   sample->tid);
 }
 
 static int
@@ -2462,33 +2312,11 @@ process_bpf_events(struct perf_tool *tool __maybe_unused,
 		   struct perf_sample *sample,
 		   struct machine *machine)
 {
-	struct thread *thread;
-	struct perf_script *script = container_of(tool, struct perf_script, tool);
-	struct perf_session *session = script->session;
-	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
-
 	if (machine__process_ksymbol(machine, event, sample) < 0)
 		return -1;
 
-	if (!evsel->core.attr.sample_id_all) {
-		perf_event__fprintf(event, stdout);
-		return 0;
-	}
-
-	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
-	if (thread == NULL) {
-		pr_debug("problem processing MMAP event, skipping it.\n");
-		return -1;
-	}
-
-	if (!filter_cpu(sample)) {
-		perf_sample__fprintf_start(sample, thread, evsel,
-					   event->header.type, stdout);
-		perf_event__fprintf(event, stdout);
-	}
-
-	thread__put(thread);
-	return 0;
+	return print_event(tool, event, sample, machine, sample->pid,
+			   sample->tid);
 }
 
 static void sig_handler(int sig __maybe_unused)
-- 
2.21.1
