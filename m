From: changbin.du@intel.com
Subject: [PATCH v2 2/2] perf sched map: re-annotate shortname if thread comm changed
Date: Tue,  6 Mar 2018 11:37:37 +0800
Message-ID: <1520307457-23668-3-git-send-email-changbin.du@intel.com>
References: <1520307457-23668-1-git-send-email-changbin.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520307457-23668-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, jolsa@redhat.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Changbin Du <changbin.du@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

This is to show the real name of thread that created via fork-exec.
See below example for shortname *A0*.

$ sudo ./perf sched map
              *A0   80393.050639 secs A0 => perf:22368
          *.   A0   80393.050748 secs .  => swapper:0
           .  *.    80393.050887 secs
      *B0  .   .    80393.052735 secs B0 => rcu_sched:8
      *.   .   .    80393.052743 secs
       .  *C0  .    80393.056264 secs C0 => kworker/2:1H:287
       .  *A0  .    80393.056270 secs
       .  *D0  .    80393.056769 secs D0 => ksoftirqd/2:22
-      .  *A0  .    80393.056804 secs
+      .  *A0  .    80393.056804 secs A0 => pi:22368
       .  *.   .    80393.056854 secs
      *B0  .   .    80393.060727 secs
      ...

Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Changbin Du <changbin.du@intel.com>

---
v2: add function perf_sched__process_comm() to process PERF_RECORD_COMM event.
---
 tools/perf/builtin-sched.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 5bfc8d5..7aa0600 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -257,6 +257,7 @@ struct thread_runtime {
 	u64 migrations;
 
 	char shortname[3];
+	bool comm_changed;
 };
 
 /* per event run time data */
@@ -1626,7 +1627,7 @@ static int map_switch_event(struct perf_sched *sched, struct perf_evsel *evsel,
 
 	timestamp__scnprintf_usec(timestamp, stimestamp, sizeof(stimestamp));
 	color_fprintf(stdout, color, "  %12s secs ", stimestamp);
-	if (new_shortname || (verbose > 0 && sched_in->tid)) {
+	if (new_shortname || tr->comm_changed || (verbose > 0 && sched_in->tid)) {
 		const char *pid_color = color;
 
 		if (thread__has_color(sched_in))
@@ -1634,6 +1635,7 @@ static int map_switch_event(struct perf_sched *sched, struct perf_evsel *evsel,
 
 		color_fprintf(stdout, pid_color, "%s => %s:%d",
 		       tr->shortname, thread__comm_str(sched_in), sched_in->tid);
+		tr->comm_changed = false;
 	}
 
 	if (sched->map.comp && new_cpu)
@@ -1737,6 +1739,37 @@ static int perf_sched__process_tracepoint_sample(struct perf_tool *tool __maybe_
 	return err;
 }
 
+static int perf_sched__process_comm(struct perf_tool *tool __maybe_unused,
+				    union perf_event *event,
+				    struct perf_sample *sample,
+				    struct machine *machine)
+{
+	struct thread *thread;
+	struct thread_runtime *tr;
+	int err;
+
+	err = perf_event__process_comm(tool, event, sample, machine);
+	if (err)
+		return err;
+
+	thread = machine__find_thread(machine, sample->pid, sample->tid);
+	if (!thread) {
+		pr_err("Internal error: can't find thread\n");
+		return -1;
+	}
+
+	tr = thread__get_runtime(thread);
+	if (tr == NULL) {
+		thread__put(thread);
+		return -1;
+	}
+
+	tr->comm_changed = true;
+	thread__put(thread);
+
+	return 0;
+}
+
 static int perf_sched__read_events(struct perf_sched *sched)
 {
 	const struct perf_evsel_str_handler handlers[] = {
@@ -3306,7 +3339,7 @@ int cmd_sched(int argc, const char **argv)
 	struct perf_sched sched = {
 		.tool = {
 			.sample		 = perf_sched__process_tracepoint_sample,
-			.comm		 = perf_event__process_comm,
+			.comm		 = perf_sched__process_comm,
 			.namespaces	 = perf_event__process_namespaces,
 			.lost		 = perf_event__process_lost,
 			.fork		 = perf_sched__process_fork_event,
-- 
2.7.4
