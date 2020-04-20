From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 57/60] perf script: Add option to enable the LBR stitching approach
Date: Mon, 20 Apr 2020 08:53:13 -0300
Message-ID: <20200420115316.18781-58-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, Pavel Gerasimov <pavel.gerasimov@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Stephane Eranian <eranian@google.com>, Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

With the LBR stitching approach, the reconstructed LBR call stack can
break the HW limitation. However, it may reconstruct invalid call stacks
in some cases, e.g. exception handing such as setjmp/longjmp.  Also, it
may impact the processing time especially when the number of samples
with stitched LBRs are huge.

Add an option to enable the approach.

Committer testing:

Using the same perf.data as with the latest cset committer testing
section:

  $ perf script --stitch-lbr
  <SNIP>
  tchain_edit 11131 15164.984292:     437491 cycles:u:
                    401106 f43+0x0 (/wb/tchain_edit)
                    40114c f42+0x18 (/wb/tchain_edit)
                    401172 f41+0xe (/wb/tchain_edit)
                    401194 f40+0x0 (/wb/tchain_edit)
                    40119b f39+0x0 (/wb/tchain_edit)
                    4011a2 f38+0x0 (/wb/tchain_edit)
                    4011a9 f37+0x0 (/wb/tchain_edit)
                    4011b0 f36+0x0 (/wb/tchain_edit)
                    4011b7 f35+0x0 (/wb/tchain_edit)
                    4011be f34+0x0 (/wb/tchain_edit)
                    4011c5 f33+0x0 (/wb/tchain_edit)
                    4011cc f32+0x0 (/wb/tchain_edit)
                    401207 f31+0x34 (/wb/tchain_edit)
                    401212 f30+0x0 (/wb/tchain_edit)
                    401219 f29+0x0 (/wb/tchain_edit)
                    401220 f28+0x0 (/wb/tchain_edit)
                    401227 f27+0x0 (/wb/tchain_edit)
                    40122e f26+0x0 (/wb/tchain_edit)
                    401235 f25+0x0 (/wb/tchain_edit)
                    40123c f24+0x0 (/wb/tchain_edit)
                    401243 f23+0x0 (/wb/tchain_edit)
                    40124a f22+0x0 (/wb/tchain_edit)
                    401251 f21+0x0 (/wb/tchain_edit)
                    401258 f20+0x0 (/wb/tchain_edit)
                    40125f f19+0x0 (/wb/tchain_edit)
                    401266 f18+0x0 (/wb/tchain_edit)
                    40126d f17+0x0 (/wb/tchain_edit)
                    401274 f16+0x0 (/wb/tchain_edit)
                    40127b f15+0x0 (/wb/tchain_edit)
                    401282 f14+0x0 (/wb/tchain_edit)
                    401289 f13+0x0 (/wb/tchain_edit)
                    401290 f12+0x0 (/wb/tchain_edit)
                    401297 f11+0x0 (/wb/tchain_edit)
                    40129e f10+0x0 (/wb/tchain_edit)
                    4012a5 f9+0x0 (/wb/tchain_edit)
                    4012ac f8+0x0 (/wb/tchain_edit)
                    4012b3 f7+0x0 (/wb/tchain_edit)
                    4012ba f6+0x0 (/wb/tchain_edit)
                    4012c1 f5+0x0 (/wb/tchain_edit)
                    4012c8 f4+0x0 (/wb/tchain_edit)
                    4012cf f3+0x0 (/wb/tchain_edit)
                    4012d6 f2+0x0 (/wb/tchain_edit)
                    4012dd f1+0x0 (/wb/tchain_edit)
                    4012e4 main+0x0 (/wb/tchain_edit)
              7f41a5016f41 __libc_start_main+0xf1 (/usr/lib64/libc-2.29.so)
  <SNIP>
  $

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
Link: http://lore.kernel.org/lkml/20200319202517.23423-15-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt | 11 +++++++++++
 tools/perf/builtin-script.c              | 12 ++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 963487e82edc..372dfd110e6d 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -440,6 +440,17 @@ include::itrace.txt[]
 --show-on-off-events::
 	Show the --switch-on/off events too.
 
+--stitch-lbr::
+	Show callgraph with stitched LBRs, which may have more complete
+	callgraph. The perf.data file must have been obtained using
+	perf record --call-graph lbr.
+	Disabled by default. In common cases with call stack overflows,
+	it can recreate better call stacks than the default lbr call stack
+	output. But this approach is not full proof. There can be cases
+	where it creates incorrect call stacks from incorrect matches.
+	The known limitations include exception handing such as
+	setjmp/longjmp will have calls/returns not match.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-script-perl[1],
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 06b511c0a539..a2236542900d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1697,6 +1697,7 @@ struct perf_script {
 	bool			show_cgroup_events;
 	bool			allocated;
 	bool			per_event_dump;
+	bool			stitch_lbr;
 	struct evswitch		evswitch;
 	struct perf_cpu_map	*cpus;
 	struct perf_thread_map *threads;
@@ -1923,6 +1924,9 @@ static void process_event(struct perf_script *script,
 	if (PRINT_FIELD(IP)) {
 		struct callchain_cursor *cursor = NULL;
 
+		if (script->stitch_lbr)
+			al->thread->lbr_stitch_enable = true;
+
 		if (symbol_conf.use_callchain && sample->callchain &&
 		    thread__resolve_callchain(al->thread, &callchain_cursor, evsel,
 					      sample, NULL, NULL, scripting_max_stack) == 0)
@@ -3170,6 +3174,12 @@ static void script__setup_sample_type(struct perf_script *script)
 		else
 			callchain_param.record_mode = CALLCHAIN_FP;
 	}
+
+	if (script->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
+		pr_warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
+			   "Please apply --call-graph lbr when recording.\n");
+		script->stitch_lbr = false;
+	}
 }
 
 static int process_stat_round_event(struct perf_session *session,
@@ -3481,6 +3491,8 @@ int cmd_script(int argc, const char **argv)
 		   "file", "file saving guest os /proc/kallsyms"),
 	OPT_STRING(0, "guestmodules", &symbol_conf.default_guest_modules,
 		   "file", "file saving guest os /proc/modules"),
+	OPT_BOOLEAN('\0', "stitch-lbr", &script.stitch_lbr,
+		    "Enable LBR callgraph stitching approach"),
 	OPTS_EVSWITCH(&script.evswitch),
 	OPT_END()
 	};
-- 
2.21.1
