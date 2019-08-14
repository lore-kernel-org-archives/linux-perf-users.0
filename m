From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/28] perf record: Add an option to take an AUX snapshot on exit
Date: Wed, 14 Aug 2019 15:40:41 -0300
Message-ID: <20190814184051.3125-19-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

It is sometimes useful to generate a snapshot when perf record exits;
I've been using a wrapper script around the workload that would do a
killall -USR2 perf when the workload exits.

This patch makes it easier and also works when perf record is attached
to a pre-existing task. A new snapshot option 'e' can be specified in
-S to enable this behavior:

root@elsewhere:~# perf record -e intel_pt// -Se sleep 1
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.085 MB perf.data ]

Co-developed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190806144101.62892-1-alexander.shishkin@linux.intel.com
[ Fixed up !HAVE_AUXTRACE_SUPPORT build in builtin-record.c, adding 2 missing __maybe_unused ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt | 11 ++++++--
 tools/perf/builtin-record.c              | 35 +++++++++++++++++++++---
 tools/perf/perf.h                        |  1 +
 tools/perf/util/auxtrace.c               | 14 ++++++++--
 tools/perf/util/auxtrace.h               |  2 +-
 5 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 15e0fa87241b..d5e58e0a2bca 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -422,9 +422,14 @@ CLOCK_BOOTTIME, CLOCK_REALTIME and CLOCK_TAI.
 -S::
 --snapshot::
 Select AUX area tracing Snapshot Mode. This option is valid only with an
-AUX area tracing event. Optionally the number of bytes to capture per
-snapshot can be specified. In Snapshot Mode, trace data is captured only when
-signal SIGUSR2 is received.
+AUX area tracing event. Optionally, certain snapshot capturing parameters
+can be specified in a string that follows this option:
+  'e': take one last snapshot on exit; guarantees that there is at least one
+       snapshot in the output file;
+  <size>: if the PMU supports this, specify the desired snapshot size.
+
+In Snapshot Mode trace data is captured only when signal SIGUSR2 is received
+and on exit if the above 'e' option is given.
 
 --proc-map-timeout::
 When processing pre-existing threads /proc/XXX/mmap, it may take a long time,
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d31d7a5a1be3..f71631f2bcb5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -613,19 +613,35 @@ static int record__auxtrace_read_snapshot_all(struct record *rec)
 	return rc;
 }
 
-static void record__read_auxtrace_snapshot(struct record *rec)
+static void record__read_auxtrace_snapshot(struct record *rec, bool on_exit)
 {
 	pr_debug("Recording AUX area tracing snapshot\n");
 	if (record__auxtrace_read_snapshot_all(rec) < 0) {
 		trigger_error(&auxtrace_snapshot_trigger);
 	} else {
-		if (auxtrace_record__snapshot_finish(rec->itr))
+		if (auxtrace_record__snapshot_finish(rec->itr, on_exit))
 			trigger_error(&auxtrace_snapshot_trigger);
 		else
 			trigger_ready(&auxtrace_snapshot_trigger);
 	}
 }
 
+static int record__auxtrace_snapshot_exit(struct record *rec)
+{
+	if (trigger_is_error(&auxtrace_snapshot_trigger))
+		return 0;
+
+	if (!auxtrace_record__snapshot_started &&
+	    auxtrace_record__snapshot_start(rec->itr))
+		return -1;
+
+	record__read_auxtrace_snapshot(rec, true);
+	if (trigger_is_error(&auxtrace_snapshot_trigger))
+		return -1;
+
+	return 0;
+}
+
 static int record__auxtrace_init(struct record *rec)
 {
 	int err;
@@ -654,7 +670,8 @@ int record__auxtrace_mmap_read(struct record *rec __maybe_unused,
 }
 
 static inline
-void record__read_auxtrace_snapshot(struct record *rec __maybe_unused)
+void record__read_auxtrace_snapshot(struct record *rec __maybe_unused,
+				    bool on_exit __maybe_unused)
 {
 }
 
@@ -664,6 +681,12 @@ int auxtrace_record__snapshot_start(struct auxtrace_record *itr __maybe_unused)
 	return 0;
 }
 
+static inline
+int record__auxtrace_snapshot_exit(struct record *rec __maybe_unused)
+{
+	return 0;
+}
+
 static int record__auxtrace_init(struct record *rec __maybe_unused)
 {
 	return 0;
@@ -1536,7 +1559,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		if (auxtrace_record__snapshot_started) {
 			auxtrace_record__snapshot_started = 0;
 			if (!trigger_is_error(&auxtrace_snapshot_trigger))
-				record__read_auxtrace_snapshot(rec);
+				record__read_auxtrace_snapshot(rec, false);
 			if (trigger_is_error(&auxtrace_snapshot_trigger)) {
 				pr_err("AUX area tracing snapshot failed\n");
 				err = -1;
@@ -1609,9 +1632,13 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			disabled = true;
 		}
 	}
+
 	trigger_off(&auxtrace_snapshot_trigger);
 	trigger_off(&switch_output_trigger);
 
+	if (opts->auxtrace_snapshot_on_exit)
+		record__auxtrace_snapshot_exit(rec);
+
 	if (forks && workload_exec_errno) {
 		char msg[STRERR_BUFSIZE];
 		const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 74d0124d38f3..dc0a7a237887 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -57,6 +57,7 @@ struct record_opts {
 	bool	     running_time;
 	bool	     full_auxtrace;
 	bool	     auxtrace_snapshot_mode;
+	bool	     auxtrace_snapshot_on_exit;
 	bool	     record_namespaces;
 	bool	     record_switch_events;
 	bool	     all_kernel;
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 65728cdeefb6..72ce4c5e7c78 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -539,9 +539,9 @@ int auxtrace_record__snapshot_start(struct auxtrace_record *itr)
 	return 0;
 }
 
-int auxtrace_record__snapshot_finish(struct auxtrace_record *itr)
+int auxtrace_record__snapshot_finish(struct auxtrace_record *itr, bool on_exit)
 {
-	if (itr && itr->snapshot_finish)
+	if (!on_exit && itr && itr->snapshot_finish)
 		return itr->snapshot_finish(itr);
 	return 0;
 }
@@ -577,6 +577,16 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
 	if (!str)
 		return 0;
 
+	/* PMU-agnostic options */
+	switch (*str) {
+	case 'e':
+		opts->auxtrace_snapshot_on_exit = true;
+		str++;
+		break;
+	default:
+		break;
+	}
+
 	if (itr)
 		return itr->parse_snapshot_options(itr, opts, str);
 
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 17eb04a1da4d..8ccabacd0b11 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -499,7 +499,7 @@ int auxtrace_record__info_fill(struct auxtrace_record *itr,
 			       size_t priv_size);
 void auxtrace_record__free(struct auxtrace_record *itr);
 int auxtrace_record__snapshot_start(struct auxtrace_record *itr);
-int auxtrace_record__snapshot_finish(struct auxtrace_record *itr);
+int auxtrace_record__snapshot_finish(struct auxtrace_record *itr, bool on_exit);
 int auxtrace_record__find_snapshot(struct auxtrace_record *itr, int idx,
 				   struct auxtrace_mmap *mm,
 				   unsigned char *data, u64 *head, u64 *old);
-- 
2.21.0
