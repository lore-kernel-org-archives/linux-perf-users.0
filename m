From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/44] perf script: Support user regs
Date: Fri, 22 Sep 2017 11:41:50 -0300
Message-ID: <20170922144220.9411-15-acme@kernel.org>
References: <20170922144220.9411-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170922144220.9411-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Teach perf script to print user regs.

  % perf record --user-regs=ip,sp ...
  % perf script -F ip,sym,uregs
  ...
   ffffffff9e060c24 native_write_msr ABI:2    SP:0x7ffd0ea06c38    IP:0x7fe77f55b637
   ffffffff9e060c24 native_write_msr ABI:2    SP:0x7ffd0ea06c38    IP:0x7fe77f55b637
   ffffffff9e060c24 native_write_msr ABI:2    SP:0x7ffd0ea06c38    IP:0x7fe77f55b637
   ffffffff9e060c24 native_write_msr ABI:2    SP:0x7ffd0ea06c38    IP:0x7fe77f55b637
   ffffffff9e00cc12 intel_pmu_handle_irq ABI:2    SP:0x7ffd0ea06c38    IP:0x7fe77f55b637

v2: Rebased on top of phys-addr patches

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Link: http://lkml.kernel.org/r/20170905184057.26135-1-andi@firstfloor.org
[ Use PRIu64 for regs->abi in print_sample_uregs() ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt |  4 ++--
 tools/perf/builtin-script.c              | 30 +++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 18dfcfa38454..bcc1ba35a2d8 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -116,8 +116,8 @@ OPTIONS
 --fields::
         Comma separated list of fields to print. Options are:
         comm, tid, pid, time, cpu, event, trace, ip, sym, dso, addr, symoff,
-        srcline, period, iregs, brstack, brstacksym, flags, bpf-output, brstackinsn, brstackoff,
-        callindent, insn, insnlen, synth, phys_addr.
+        srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output, brstackinsn,
+        brstackoff, callindent, insn, insnlen, synth, phys_addr.
         Field list can be prepended with the type, trace, sw or hw,
         to indicate to which event type the field list applies.
         e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 3d4c3b5e1868..725dbd3dd104 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -88,6 +88,7 @@ enum perf_output_field {
 	PERF_OUTPUT_BRSTACKOFF	    = 1U << 24,
 	PERF_OUTPUT_SYNTH           = 1U << 25,
 	PERF_OUTPUT_PHYS_ADDR       = 1U << 26,
+	PERF_OUTPUT_UREGS	    = 1U << 27,
 };
 
 struct output_option {
@@ -109,6 +110,7 @@ struct output_option {
 	{.str = "srcline", .field = PERF_OUTPUT_SRCLINE},
 	{.str = "period", .field = PERF_OUTPUT_PERIOD},
 	{.str = "iregs", .field = PERF_OUTPUT_IREGS},
+	{.str = "uregs", .field = PERF_OUTPUT_UREGS},
 	{.str = "brstack", .field = PERF_OUTPUT_BRSTACK},
 	{.str = "brstacksym", .field = PERF_OUTPUT_BRSTACKSYM},
 	{.str = "data_src", .field = PERF_OUTPUT_DATA_SRC},
@@ -385,6 +387,11 @@ static int perf_evsel__check_attr(struct perf_evsel *evsel,
 					PERF_OUTPUT_IREGS))
 		return -EINVAL;
 
+	if (PRINT_FIELD(UREGS) &&
+		perf_evsel__check_stype(evsel, PERF_SAMPLE_REGS_USER, "UREGS",
+					PERF_OUTPUT_UREGS))
+		return -EINVAL;
+
 	if (PRINT_FIELD(PHYS_ADDR) &&
 		perf_evsel__check_stype(evsel, PERF_SAMPLE_PHYS_ADDR, "PHYS_ADDR",
 					PERF_OUTPUT_PHYS_ADDR))
@@ -509,6 +516,24 @@ static void print_sample_iregs(struct perf_sample *sample,
 	}
 }
 
+static void print_sample_uregs(struct perf_sample *sample,
+			  struct perf_event_attr *attr)
+{
+	struct regs_dump *regs = &sample->user_regs;
+	uint64_t mask = attr->sample_regs_user;
+	unsigned i = 0, r;
+
+	if (!regs || !regs->regs)
+		return;
+
+	printf(" ABI:%" PRIu64 " ", regs->abi);
+
+	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
+		u64 val = regs->regs[i++];
+		printf("%5s:0x%"PRIx64" ", perf_reg_name(r), val);
+	}
+}
+
 static void print_sample_start(struct perf_sample *sample,
 			       struct thread *thread,
 			       struct perf_evsel *evsel)
@@ -1444,6 +1469,9 @@ static void process_event(struct perf_script *script,
 	if (PRINT_FIELD(IREGS))
 		print_sample_iregs(sample, attr);
 
+	if (PRINT_FIELD(UREGS))
+		print_sample_uregs(sample, attr);
+
 	if (PRINT_FIELD(BRSTACK))
 		print_sample_brstack(sample, thread, attr);
 	else if (PRINT_FIELD(BRSTACKSYM))
@@ -2739,7 +2767,7 @@ int cmd_script(int argc, const char **argv)
 		     "+field to add and -field to remove."
 		     "Valid types: hw,sw,trace,raw,synth. "
 		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,"
-		     "addr,symoff,period,iregs,brstack,brstacksym,flags,"
+		     "addr,symoff,period,iregs,uregs,brstack,brstacksym,flags,"
 		     "bpf-output,callindent,insn,insnlen,brstackinsn,synth,phys_addr",
 		     parse_output_fields),
 	OPT_BOOLEAN('a', "all-cpus", &system_wide,
-- 
2.13.5
