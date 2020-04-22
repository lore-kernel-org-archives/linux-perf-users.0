From: Ian Rogers <irogers@google.com>
Subject: [PATCH v3] perf record: add dummy event during system wide synthesis
Date: Wed, 22 Apr 2020 10:36:15 -0700
Message-ID: <20200422173615.59436-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

During the processing of /proc during event synthesis new processes may
start. Add a dummy event if /proc is to be processed, to capture mmaps
for starting processes. This reuses the existing logic for
initial-delay.

v3 fixes the attr test of test-record-C0
v2 fixes the dummy event configuration and a branch stack issue.

Suggested-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c             | 19 +++++++---
 tools/perf/tests/attr/system-wide-dummy | 50 +++++++++++++++++++++++++
 tools/perf/tests/attr/test-record-C0    | 12 +++++-
 tools/perf/util/evsel.c                 |  5 ++-
 4 files changed, 78 insertions(+), 8 deletions(-)
 create mode 100644 tools/perf/tests/attr/system-wide-dummy

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1ab349abe904..8d1e93351298 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -805,19 +805,28 @@ static int record__open(struct record *rec)
 	int rc = 0;
 
 	/*
-	 * For initial_delay we need to add a dummy event so that we can track
-	 * PERF_RECORD_MMAP while we wait for the initial delay to enable the
-	 * real events, the ones asked by the user.
+	 * For initial_delay or system wide, we need to add a dummy event so
+	 * that we can track PERF_RECORD_MMAP to cover the delay of waiting or
+	 * event synthesis.
 	 */
-	if (opts->initial_delay) {
+	if (opts->initial_delay || target__has_cpu(&opts->target)) {
 		if (perf_evlist__add_dummy(evlist))
 			return -ENOMEM;
 
+		/* Disable tracking of mmaps on lead event. */
 		pos = evlist__first(evlist);
 		pos->tracking = 0;
+		/* Set up dummy event. */
 		pos = evlist__last(evlist);
 		pos->tracking = 1;
-		pos->core.attr.enable_on_exec = 1;
+		/*
+		 * Enable the dummy event when the process is forked for
+		 * initial_delay, immediately for system wide.
+		 */
+		if (opts->initial_delay)
+			pos->core.attr.enable_on_exec = 1;
+		else
+			pos->immediate = 1;
 	}
 
 	perf_evlist__config(evlist, opts, &callchain_param);
diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests/attr/system-wide-dummy
new file mode 100644
index 000000000000..eba723cc0d38
--- /dev/null
+++ b/tools/perf/tests/attr/system-wide-dummy
@@ -0,0 +1,50 @@
+# Event added by system-wide or CPU perf-record to handle the race of
+# processes starting while /proc is processed.
+[event]
+fd=1
+group_fd=-1
+cpu=*
+pid=-1
+flags=8
+type=1
+size=120
+config=9
+sample_period=4000
+sample_type=455
+read_format=4
+# Event will be enabled right away.
+disabled=0
+inherit=1
+pinned=0
+exclusive=0
+exclude_user=0
+exclude_kernel=0
+exclude_hv=0
+exclude_idle=0
+mmap=1
+comm=1
+freq=1
+inherit_stat=0
+enable_on_exec=0
+task=1
+watermark=0
+precise_ip=0
+mmap_data=0
+sample_id_all=1
+exclude_host=0
+exclude_guest=0
+exclude_callchain_kernel=0
+exclude_callchain_user=0
+mmap2=1
+comm_exec=1
+context_switch=0
+write_backward=0
+namespaces=0
+use_clockid=0
+wakeup_events=0
+bp_type=0
+config1=0
+config2=0
+branch_sample_type=0
+sample_regs_user=0
+sample_stack_user=0
diff --git a/tools/perf/tests/attr/test-record-C0 b/tools/perf/tests/attr/test-record-C0
index 93818054ae20..317730b906dd 100644
--- a/tools/perf/tests/attr/test-record-C0
+++ b/tools/perf/tests/attr/test-record-C0
@@ -9,6 +9,14 @@ cpu=0
 # no enable on exec for CPU attached
 enable_on_exec=0
 
-# PERF_SAMPLE_IP | PERF_SAMPLE_TID PERF_SAMPLE_TIME | # PERF_SAMPLE_PERIOD
+# PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
+# PERF_SAMPLE_ID | PERF_SAMPLE_PERIOD
 # + PERF_SAMPLE_CPU added by -C 0
-sample_type=391
+sample_type=455
+
+# Dummy event handles mmaps, comm and task.
+mmap=0
+comm=0
+task=0
+
+[event:system-wide-dummy]
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6a571d322bb2..ca8f9533d8f9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1163,11 +1163,14 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 	}
 
 	/*
+	 * A dummy event never triggers any actual counter and therefore
+	 * cannot be used with branch_stack.
+	 *
 	 * For initial_delay, a dummy event is added implicitly.
 	 * The software event will trigger -EOPNOTSUPP error out,
 	 * if BRANCH_STACK bit is set.
 	 */
-	if (opts->initial_delay && is_dummy_event(evsel))
+	if (is_dummy_event(evsel))
 		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
 }
 
-- 
2.26.2.303.gf8c07b1a785-goog
