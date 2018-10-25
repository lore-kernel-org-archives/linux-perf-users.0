From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 35/37] tools script: Add --call-trace and --call-ret-trace
Date: Thu, 25 Oct 2018 08:10:29 -0300
Message-ID: <20181025111031.3440-36-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Kim Phillips <kim.phillips@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add short cut options to print PT call trace and call-ret-trace, for
calls and call and returns. Roughly corresponds to ftrace function
tracer and function graph tracer.

Just makes these common use cases nicer to use.

% perf record -a -e intel_pt// sleep 1
% perf script --call-trace
	    perf   900 [000] 194167.205652203: ([kernel.kallsyms])          perf_pmu_enable
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])          __x86_indirect_thunk_rax
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])          event_filter_match
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])          group_sched_in
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])              __x86_indirect_thunk_rax
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])              event_sched_in.isra.107
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_event_set_state.part.71
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                      perf_event_update_time
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_pmu_disable
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_log_itrace_start
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  __x86_indirect_thunk_rax
            perf   900 [000] 194167.205652203: ([kernel.kallsyms])                      perf_event_update_userpage

% perf script --call-ret-trace
	    perf   900 [000] 194167.205652203:   tr strt     ([unknown])        pt_config
            perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            pt_config
            perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            pt_event_add
            perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])            perf_pmu_enable
            perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            perf_pmu_nop_void
            perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            event_sched_in.isra.107
            perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])            __x86_indirect_thunk_rax
            perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            perf_pmu_nop_int
            perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            group_sched_in
            perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])            event_filter_match
            perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])            event_filter_match
            perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])            group_sched_in
            perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])                __x86_indirect_thunk_rax
            perf   900 [000] 194167.205652203:   return      ([kernel.kallsyms])                perf_pmu_nop_txn
            perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])                event_sched_in.isra.107
            perf   900 [000] 194167.205652203:   call        ([kernel.kallsyms])                    perf_event_set_state.part.71

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Link: http://lkml.kernel.org/r/20180920180540.14039-4-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt |  7 +++++++
 tools/perf/builtin-script.c              | 24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 00c655ab4968..805baabd238e 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -390,6 +390,13 @@ include::itrace.txt[]
 --xed::
 	Run xed disassembler on output. Requires installing the xed disassembler.
 
+--call-trace::
+	Show call stream for intel_pt traces. The CPUs are interleaved, but
+	can be filtered with -C.
+
+--call-ret-trace::
+	Show call and return stream for intel_pt traces.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-script-perl[1],
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 6099c722a679..566e1450898a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3122,6 +3122,26 @@ static int parse_xed(const struct option *opt __maybe_unused,
 	return 0;
 }
 
+static int parse_call_trace(const struct option *opt __maybe_unused,
+			    const char *str __maybe_unused,
+			    int unset __maybe_unused)
+{
+	parse_output_fields(NULL, "-ip,-addr,-event,-period,+callindent", 0);
+	itrace_parse_synth_opts(opt, "cewp", 0);
+	nanosecs = true;
+	return 0;
+}
+
+static int parse_callret_trace(const struct option *opt __maybe_unused,
+			    const char *str __maybe_unused,
+			    int unset __maybe_unused)
+{
+	parse_output_fields(NULL, "-ip,-addr,-event,-period,+callindent,+flags", 0);
+	itrace_parse_synth_opts(opt, "crewp", 0);
+	nanosecs = true;
+	return 0;
+}
+
 int cmd_script(int argc, const char **argv)
 {
 	bool show_full_info = false;
@@ -3213,6 +3233,10 @@ int cmd_script(int argc, const char **argv)
 			"Decode instructions from itrace", parse_insn_trace),
 	OPT_CALLBACK_OPTARG(0, "xed", NULL, NULL, NULL,
 			"Run xed disassembler on output", parse_xed),
+	OPT_CALLBACK_OPTARG(0, "call-trace", &itrace_synth_opts, NULL, NULL,
+			"Decode calls from from itrace", parse_call_trace),
+	OPT_CALLBACK_OPTARG(0, "call-ret-trace", &itrace_synth_opts, NULL, NULL,
+			"Decode calls and returns from itrace", parse_callret_trace),
 	OPT_STRING(0, "stop-bt", &symbol_conf.bt_stop_list_str, "symbol[,symbol...]",
 		   "Stop display of callgraph at these symbols"),
 	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
-- 
2.14.4
