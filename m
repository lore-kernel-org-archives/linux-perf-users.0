From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/13] perf script: Support physical address
Date: Mon,  4 Sep 2017 11:00:41 -0300
Message-ID: <20170904140044.22912-11-acme@kernel.org>
References: <20170904140044.22912-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170904140044.22912-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

Display the physical address at the tail if it is available.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Tested-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Stephane Eranian <eranian@google.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1504026672-7304-5-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt |  2 +-
 tools/perf/builtin-script.c              | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 5ee8796be96e..18dfcfa38454 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -117,7 +117,7 @@ OPTIONS
         Comma separated list of fields to print. Options are:
         comm, tid, pid, time, cpu, event, trace, ip, sym, dso, addr, symoff,
         srcline, period, iregs, brstack, brstacksym, flags, bpf-output, brstackinsn, brstackoff,
-        callindent, insn, insnlen, synth.
+        callindent, insn, insnlen, synth, phys_addr.
         Field list can be prepended with the type, trace, sw or hw,
         to indicate to which event type the field list applies.
         e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 378f76cdf923..3d4c3b5e1868 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -87,6 +87,7 @@ enum perf_output_field {
 	PERF_OUTPUT_BRSTACKINSN	    = 1U << 23,
 	PERF_OUTPUT_BRSTACKOFF	    = 1U << 24,
 	PERF_OUTPUT_SYNTH           = 1U << 25,
+	PERF_OUTPUT_PHYS_ADDR       = 1U << 26,
 };
 
 struct output_option {
@@ -119,6 +120,7 @@ struct output_option {
 	{.str = "brstackinsn", .field = PERF_OUTPUT_BRSTACKINSN},
 	{.str = "brstackoff", .field = PERF_OUTPUT_BRSTACKOFF},
 	{.str = "synth", .field = PERF_OUTPUT_SYNTH},
+	{.str = "phys_addr", .field = PERF_OUTPUT_PHYS_ADDR},
 };
 
 enum {
@@ -175,7 +177,8 @@ static struct {
 			      PERF_OUTPUT_EVNAME | PERF_OUTPUT_IP |
 			      PERF_OUTPUT_SYM | PERF_OUTPUT_DSO |
 			      PERF_OUTPUT_PERIOD |  PERF_OUTPUT_ADDR |
-			      PERF_OUTPUT_DATA_SRC | PERF_OUTPUT_WEIGHT,
+			      PERF_OUTPUT_DATA_SRC | PERF_OUTPUT_WEIGHT |
+			      PERF_OUTPUT_PHYS_ADDR,
 
 		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
 	},
@@ -382,6 +385,11 @@ static int perf_evsel__check_attr(struct perf_evsel *evsel,
 					PERF_OUTPUT_IREGS))
 		return -EINVAL;
 
+	if (PRINT_FIELD(PHYS_ADDR) &&
+		perf_evsel__check_stype(evsel, PERF_SAMPLE_PHYS_ADDR, "PHYS_ADDR",
+					PERF_OUTPUT_PHYS_ADDR))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -1446,6 +1454,9 @@ static void process_event(struct perf_script *script,
 	if (perf_evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
 		print_sample_bpf_output(sample);
 	print_insn(sample, attr, thread, machine);
+
+	if (PRINT_FIELD(PHYS_ADDR))
+		printf("%16" PRIx64, sample->phys_addr);
 	printf("\n");
 }
 
@@ -2729,7 +2740,7 @@ int cmd_script(int argc, const char **argv)
 		     "Valid types: hw,sw,trace,raw,synth. "
 		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,"
 		     "addr,symoff,period,iregs,brstack,brstacksym,flags,"
-		     "bpf-output,callindent,insn,insnlen,brstackinsn,synth",
+		     "bpf-output,callindent,insn,insnlen,brstackinsn,synth,phys_addr",
 		     parse_output_fields),
 	OPT_BOOLEAN('a', "all-cpus", &system_wide,
 		    "system-wide collection from all CPUs"),
-- 
2.13.5
