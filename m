From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 59/60] perf c2c: Add option to enable the LBR stitching approach
Date: Mon, 20 Apr 2020 08:53:15 -0300
Message-ID: <20200420115316.18781-60-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, Pavel Gerasimov <pavel.gerasimov@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Stephane Eranian <eranian@google.com>, Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

With the LBR stitching approach, the reconstructed LBR call stack can
break the HW limitation. However, it may reconstruct invalid call stacks
in some cases, e.g. exception handing such as setjmp/longjmp.  Also, it
may impact the processing time especially when the number of samples
with stitched LBRs are huge.

Add an option to enable the approach.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pavel Gerasimov <pavel.gerasimov@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>
Link: http://lore.kernel.org/lkml/20200319202517.23423-17-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-c2c.txt | 11 +++++++++++
 tools/perf/builtin-c2c.c              | 12 ++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index e6150f21267d..2133eb320cb0 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -111,6 +111,17 @@ REPORT OPTIONS
 --display::
 	Switch to HITM type (rmt, lcl) to display and sort on. Total HITMs as default.
 
+--stitch-lbr::
+	Show callgraph with stitched LBRs, which may have more complete
+	callgraph. The perf.data file must have been obtained using
+	perf c2c record --call-graph lbr.
+	Disabled by default. In common cases with call stack overflows,
+	it can recreate better call stacks than the default lbr call stack
+	output. But this approach is not full proof. There can be cases
+	where it creates incorrect call stacks from incorrect matches.
+	The known limitations include exception handing such as
+	setjmp/longjmp will have calls/returns not match.
+
 C2C RECORD
 ----------
 The perf c2c record command setup options related to HITM cacheline analysis
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 246ac0b4d54f..0d544c4fb4be 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -95,6 +95,7 @@ struct perf_c2c {
 	bool			 use_stdio;
 	bool			 stats_only;
 	bool			 symbol_full;
+	bool			 stitch_lbr;
 
 	/* HITM shared clines stats */
 	struct c2c_stats	hitm_stats;
@@ -273,6 +274,9 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 		return -1;
 	}
 
+	if (c2c.stitch_lbr)
+		al.thread->lbr_stitch_enable = true;
+
 	ret = sample__resolve_callchain(sample, &callchain_cursor, NULL,
 					evsel, &al, sysctl_perf_event_max_stack);
 	if (ret)
@@ -2601,6 +2605,12 @@ static int setup_callchain(struct evlist *evlist)
 		}
 	}
 
+	if (c2c.stitch_lbr && (mode != CALLCHAIN_LBR)) {
+		ui__warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
+			    "Please apply --call-graph lbr when recording.\n");
+		c2c.stitch_lbr = false;
+	}
+
 	callchain_param.record_mode = mode;
 	callchain_param.min_percent = 0;
 	return 0;
@@ -2752,6 +2762,8 @@ static int perf_c2c__report(int argc, const char **argv)
 	OPT_STRING('c', "coalesce", &coalesce, "coalesce fields",
 		   "coalesce fields: pid,tid,iaddr,dso"),
 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
+	OPT_BOOLEAN(0, "stitch-lbr", &c2c.stitch_lbr,
+		    "Enable LBR callgraph stitching approach"),
 	OPT_PARENT(c2c_options),
 	OPT_END()
 	};
-- 
2.21.1
