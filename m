From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/27] perf script: Add support to display sample misc field
Date: Wed, 10 Jan 2018 18:28:37 -0300
Message-ID: <20180110212844.12441-21-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding support to display sample misc field in form
of letter for each bit:

  # perf script -F +misc ...
   sched-messaging  1414 K     28690.636582:       4590 cycles ...
   sched-messaging  1407 U     28690.636600:     325620 cycles ...
   sched-messaging  1414 K     28690.636608:      19473 cycles ...
  misc field  __________/

The misc bits are assigned to following letters:

  PERF_RECORD_MISC_KERNEL        K
  PERF_RECORD_MISC_USER          U
  PERF_RECORD_MISC_HYPERVISOR    H
  PERF_RECORD_MISC_GUEST_KERNEL  G
  PERF_RECORD_MISC_GUEST_USER    g
  PERF_RECORD_MISC_MMAP_DATA*    M
  PERF_RECORD_MISC_COMM_EXEC     E
  PERF_RECORD_MISC_SWITCH_OUT    S

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180107160356.28203-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt | 20 ++++++++-
 tools/perf/builtin-script.c              | 74 +++++++++++++++++++++++++++-----
 tools/perf/util/event.h                  |  1 +
 tools/perf/util/evsel.c                  |  1 +
 4 files changed, 84 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 7b622a812a72..93ae8d60e3d3 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -117,7 +117,7 @@ OPTIONS
         Comma separated list of fields to print. Options are:
         comm, tid, pid, time, cpu, event, trace, ip, sym, dso, addr, symoff,
         srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output, brstackinsn,
-	brstackoff, callindent, insn, insnlen, synth, phys_addr, metric.
+        brstackoff, callindent, insn, insnlen, synth, phys_addr, metric, misc.
         Field list can be prepended with the type, trace, sw or hw,
         to indicate to which event type the field list applies.
         e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
@@ -225,6 +225,24 @@ OPTIONS
 	that the metric computed is averaged over the whole sampling
 	period, not just for the sample point.
 
+	For sample events it's possible to display misc field with -F +misc option,
+	following letters are displayed for each bit:
+
+	  PERF_RECORD_MISC_KERNEL        K
+	  PERF_RECORD_MISC_USER          U
+	  PERF_RECORD_MISC_HYPERVISOR    H
+	  PERF_RECORD_MISC_GUEST_KERNEL  G
+	  PERF_RECORD_MISC_GUEST_USER    g
+	  PERF_RECORD_MISC_MMAP_DATA*    M
+	  PERF_RECORD_MISC_COMM_EXEC     E
+	  PERF_RECORD_MISC_SWITCH_OUT    S
+
+	  $ perf script -F +misc ...
+	   sched-messaging  1414 K     28690.636582:       4590 cycles ...
+	   sched-messaging  1407 U     28690.636600:     325620 cycles ...
+	   sched-messaging  1414 K     28690.636608:      19473 cycles ...
+	  misc field ___________/
+
 -k::
 --vmlinux=<file>::
         vmlinux pathname
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 330dcd9b9b8f..bb603495cf4a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -93,6 +93,7 @@ enum perf_output_field {
 	PERF_OUTPUT_PHYS_ADDR       = 1U << 26,
 	PERF_OUTPUT_UREGS	    = 1U << 27,
 	PERF_OUTPUT_METRIC	    = 1U << 28,
+	PERF_OUTPUT_MISC            = 1U << 29,
 };
 
 struct output_option {
@@ -128,6 +129,7 @@ struct output_option {
 	{.str = "synth", .field = PERF_OUTPUT_SYNTH},
 	{.str = "phys_addr", .field = PERF_OUTPUT_PHYS_ADDR},
 	{.str = "metric", .field = PERF_OUTPUT_METRIC},
+	{.str = "misc", .field = PERF_OUTPUT_MISC},
 };
 
 enum {
@@ -594,7 +596,8 @@ static int perf_sample__fprintf_uregs(struct perf_sample *sample,
 
 static int perf_sample__fprintf_start(struct perf_sample *sample,
 				      struct thread *thread,
-				      struct perf_evsel *evsel, FILE *fp)
+				      struct perf_evsel *evsel,
+				      u32 type, FILE *fp)
 {
 	struct perf_event_attr *attr = &evsel->attr;
 	unsigned long secs;
@@ -624,6 +627,47 @@ static int perf_sample__fprintf_start(struct perf_sample *sample,
 			printed += fprintf(fp, "[%03d] ", sample->cpu);
 	}
 
+	if (PRINT_FIELD(MISC)) {
+		int ret = 0;
+
+		#define has(m) \
+			(sample->misc & PERF_RECORD_MISC_##m) == PERF_RECORD_MISC_##m
+
+		if (has(KERNEL))
+			ret += fprintf(fp, "K");
+		if (has(USER))
+			ret += fprintf(fp, "U");
+		if (has(HYPERVISOR))
+			ret += fprintf(fp, "H");
+		if (has(GUEST_KERNEL))
+			ret += fprintf(fp, "G");
+		if (has(GUEST_USER))
+			ret += fprintf(fp, "g");
+
+		switch (type) {
+		case PERF_RECORD_MMAP:
+		case PERF_RECORD_MMAP2:
+			if (has(MMAP_DATA))
+				ret += fprintf(fp, "M");
+			break;
+		case PERF_RECORD_COMM:
+			if (has(COMM_EXEC))
+				ret += fprintf(fp, "E");
+			break;
+		case PERF_RECORD_SWITCH:
+		case PERF_RECORD_SWITCH_CPU_WIDE:
+			if (has(SWITCH_OUT))
+				ret += fprintf(fp, "S");
+		default:
+			break;
+		}
+
+		#undef has
+
+		ret += fprintf(fp, "%*s", 6 - ret, " ");
+		printed += ret;
+	}
+
 	if (PRINT_FIELD(TIME)) {
 		nsecs = sample->time;
 		secs = nsecs / NSEC_PER_SEC;
@@ -1502,7 +1546,7 @@ static void script_print_metric(void *ctx, const char *color,
 	if (!fmt)
 		return;
 	perf_sample__fprintf_start(mctx->sample, mctx->thread, mctx->evsel,
-				   mctx->fp);
+				   PERF_RECORD_SAMPLE, mctx->fp);
 	fputs("\tmetric: ", mctx->fp);
 	if (color)
 		color_fprintf(mctx->fp, color, fmt, val);
@@ -1516,7 +1560,7 @@ static void script_new_line(void *ctx)
 	struct metric_ctx *mctx = ctx;
 
 	perf_sample__fprintf_start(mctx->sample, mctx->thread, mctx->evsel,
-				   mctx->fp);
+				   PERF_RECORD_SAMPLE, mctx->fp);
 	fputs("\tmetric: ", mctx->fp);
 }
 
@@ -1584,7 +1628,8 @@ static void process_event(struct perf_script *script,
 
 	++es->samples;
 
-	perf_sample__fprintf_start(sample, thread, evsel, fp);
+	perf_sample__fprintf_start(sample, thread, evsel,
+				   PERF_RECORD_SAMPLE, fp);
 
 	if (PRINT_FIELD(PERIOD))
 		fprintf(fp, "%10" PRIu64 " ", sample->period);
@@ -1833,7 +1878,8 @@ static int process_comm_event(struct perf_tool *tool,
 		sample->tid = event->comm.tid;
 		sample->pid = event->comm.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel, stdout);
+	perf_sample__fprintf_start(sample, thread, evsel,
+				   PERF_RECORD_COMM, stdout);
 	perf_event__fprintf(event, stdout);
 	ret = 0;
 out:
@@ -1868,7 +1914,8 @@ static int process_namespaces_event(struct perf_tool *tool,
 		sample->tid = event->namespaces.tid;
 		sample->pid = event->namespaces.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel, stdout);
+	perf_sample__fprintf_start(sample, thread, evsel,
+				   PERF_RECORD_NAMESPACES, stdout);
 	perf_event__fprintf(event, stdout);
 	ret = 0;
 out:
@@ -1901,7 +1948,8 @@ static int process_fork_event(struct perf_tool *tool,
 		sample->tid = event->fork.tid;
 		sample->pid = event->fork.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel, stdout);
+	perf_sample__fprintf_start(sample, thread, evsel,
+				   PERF_RECORD_FORK, stdout);
 	perf_event__fprintf(event, stdout);
 	thread__put(thread);
 
@@ -1930,7 +1978,8 @@ static int process_exit_event(struct perf_tool *tool,
 		sample->tid = event->fork.tid;
 		sample->pid = event->fork.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel, stdout);
+	perf_sample__fprintf_start(sample, thread, evsel,
+				   PERF_RECORD_EXIT, stdout);
 	perf_event__fprintf(event, stdout);
 
 	if (perf_event__process_exit(tool, event, sample, machine) < 0)
@@ -1965,7 +2014,8 @@ static int process_mmap_event(struct perf_tool *tool,
 		sample->tid = event->mmap.tid;
 		sample->pid = event->mmap.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel, stdout);
+	perf_sample__fprintf_start(sample, thread, evsel,
+				   PERF_RECORD_MMAP, stdout);
 	perf_event__fprintf(event, stdout);
 	thread__put(thread);
 	return 0;
@@ -1996,7 +2046,8 @@ static int process_mmap2_event(struct perf_tool *tool,
 		sample->tid = event->mmap2.tid;
 		sample->pid = event->mmap2.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel, stdout);
+	perf_sample__fprintf_start(sample, thread, evsel,
+				   PERF_RECORD_MMAP2, stdout);
 	perf_event__fprintf(event, stdout);
 	thread__put(thread);
 	return 0;
@@ -2022,7 +2073,8 @@ static int process_switch_event(struct perf_tool *tool,
 		return -1;
 	}
 
-	perf_sample__fprintf_start(sample, thread, evsel, stdout);
+	perf_sample__fprintf_start(sample, thread, evsel,
+				   PERF_RECORD_SWITCH, stdout);
 	perf_event__fprintf(event, stdout);
 	thread__put(thread);
 	return 0;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 1ae95efbfb95..e5fbd6dd1b01 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -205,6 +205,7 @@ struct perf_sample {
 	u32 flags;
 	u16 insn_len;
 	u8  cpumode;
+	u16 misc;
 	char insn[MAX_INSN];
 	void *raw_data;
 	struct ip_callchain *callchain;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c435b2444153..d934f04e3110 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2042,6 +2042,7 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 	data->stream_id = data->id = data->time = -1ULL;
 	data->period = evsel->attr.sample_period;
 	data->cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
+	data->misc    = event->header.misc;
 	data->id = -1ULL;
 	data->data_src = PERF_MEM_DATA_SRC_NONE;
 
-- 
2.14.3
