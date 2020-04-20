From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 56/60] perf report: Add option to enable the LBR stitching approach
Date: Mon, 20 Apr 2020 08:53:12 -0300
Message-ID: <20200420115316.18781-57-acme@kernel.org>
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

  # To display the perf.data header info, please use
  # --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 6K of event 'cycles'
  # Event count (approx.): 6492797701
  #
  # Children      Self  Command          Shared Object       Symbol
  # ........  ........  ...............  ..................
  # .................................
  #
    99.99%    99.99%  tchain_edit      tchain_edit        [.] f43
            |
            ---main
               f1
               f2
               f3
               f4
               f5
               f6
               f7
               f8
               f9
               f10
               f11
               f12
               f13
               f14
               f15
               f16
               f17
               f18
               f19
               f20
               f21
               f22
               f23
               f24
               f25
               f26
               f27
               f28
               f29
               f30
               f31
               |
                --99.65%--f32
                          f33
                          f34
                          f35
                          f36
                          f37
                          f38
                          f39
                          f40
                          f41
                          f42
                          f43

Committer testing:

  $ perf record --call-graph lbr /wb/tchain_edit
  [ perf record: Woken up 23 times to write data ]
  [ perf record: Captured and wrote 5.578 MB perf.data (6839 samples) ]
  $ perf report --header-only | egrep 'cpu(desc|.*capabilities)'
  # cpudesc : Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz
  # cpu pmu capabilities: branches=32, max_precise=3, pmu_name=skylake
  $

Before:

  $ perf report --no-children --stdio
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 6K of event 'cycles:u'
  # Event count (approx.): 6459523879
  #
  # Overhead  Command      Shared Object     Symbol
  # ........  ...........  ................  .......................
  #
      99.95%  tchain_edit  tchain_edit       [.] f43
              |
               --99.92%--f43
                         f42
                         f41
                         f40
                         f39
                         f38
                         f37
                         f36
                         f35
                         f34
                         f33
                         f32
                         f31
                         f30
                         f29
                         f28
                         f27
                         f26
                         f25
                         f24
                         f23
                         f22
                         f21
                         f20
                         f19
                         f18
                         f17
                         f16
                         f15
                         f14
                         f13
                         f12
                         f11

       0.03%  tchain_edit  tchain_edit       [.] f42
       0.01%  tchain_edit  tchain_edit       [.] f41
       0.00%  tchain_edit  tchain_edit       [.] f31
       0.00%  tchain_edit  ld-2.29.so        [.] _dl_relocate_object
       0.00%  tchain_edit  ld-2.29.so        [.] memmove
       0.00%  tchain_edit  [unknown]         [k] 0xffffffff93a00b17

After:

  $ perf report --stitch-lbr --no-children --stdio
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 6K of event 'cycles:u'
  # Event count (approx.): 6459496645
  #
  # Overhead  Command      Shared Object     Symbol
  # ........  ...........  ................  ........................
  #
      99.97%  tchain_edit  tchain_edit       [.] f43
              |
               --99.93%--f43
                         f42
                         f41
                         f40
                         f39
                         f38
                         f37
                         f36
                         f35
                         f34
                         f33
                         f32
                         f31
                         f30
                         f29
                         f28
                         f27
                         f26
                         f25
                         f24
                         f23
                         f22
                         f21
                         f20
                         f19
                         f18
                         f17
                         f16
                         f15
                         f14
                         f13
                         f12
                         f11
                         f10
                         f9
                         f8
                         f7
                         f6
                         f5
                         f4
                         f3
                         f2
                         f1
                         main
                         __libc_start_main

       0.02%  tchain_edit  [unknown]         [k] 0xffffffff93a00b17
       0.01%  tchain_edit  tchain_edit       [.] f31
       0.00%  tchain_edit  ld-2.29.so        [.] _dl_important_hwcaps

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
Link: http://lore.kernel.org/lkml/20200319202517.23423-14-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt | 11 +++++++++++
 tools/perf/builtin-report.c              | 12 ++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index f569b9ea4002..d068103690cc 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -488,6 +488,17 @@ include::itrace.txt[]
 	This option extends the perf report to show reference callgraphs,
 	which collected by reference event, in no callgraph event.
 
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
 --socket-filter::
 	Only report the samples on the processor socket that match with this filter
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index c0cebd53ecf9..0c32767b1c56 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -84,6 +84,7 @@ struct report {
 	bool			header_only;
 	bool			nonany_branch_mode;
 	bool			group_set;
+	bool			stitch_lbr;
 	int			max_stack;
 	struct perf_read_values	show_threads_values;
 	struct annotation_options annotation_opts;
@@ -267,6 +268,9 @@ static int process_sample_event(struct perf_tool *tool,
 		return -1;
 	}
 
+	if (rep->stitch_lbr)
+		al.thread->lbr_stitch_enable = true;
+
 	if (symbol_conf.hide_unresolved && al.sym == NULL)
 		goto out_put;
 
@@ -408,6 +412,12 @@ static int report__setup_sample_type(struct report *rep)
 			callchain_param.record_mode = CALLCHAIN_FP;
 	}
 
+	if (rep->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
+		ui__warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
+			    "Please apply --call-graph lbr when recording.\n");
+		rep->stitch_lbr = false;
+	}
+
 	/* ??? handle more cases than just ANY? */
 	if (!(perf_evlist__combined_branch_type(session->evlist) &
 				PERF_SAMPLE_BRANCH_ANY))
@@ -1258,6 +1268,8 @@ int cmd_report(int argc, const char **argv)
 			"Show full source file name path for source lines"),
 	OPT_BOOLEAN(0, "show-ref-call-graph", &symbol_conf.show_ref_callgraph,
 		    "Show callgraph from reference event"),
+	OPT_BOOLEAN(0, "stitch-lbr", &report.stitch_lbr,
+		    "Enable LBR callgraph stitching approach"),
 	OPT_INTEGER(0, "socket-filter", &report.socket_filter,
 		    "only show processor socket that match with this filter"),
 	OPT_BOOLEAN(0, "raw-trace", &symbol_conf.raw_trace,
-- 
2.21.1
