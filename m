From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/10] perf bpf: Fix endianness problem when loading parameters in prologue
Date: Wed, 16 Aug 2017 17:20:49 -0300
Message-ID: <20170816202050.8865-10-acme@kernel.org>
References: <20170816202050.8865-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170816202050.8865-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Wang Nan <wangnan0@huawei.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Wang Nan <wangnan0@huawei.com>

Perf's BPF prologue generator unconditionally fetches 8 bytes for
function parameters, which causes problems on big endian machines. Thomas
gives a detailed analysis for this problem:

 http://lkml.kernel.org/r/968ebda5-abe4-8830-8d69-49f62529d151@linux.vnet.ibm.com

 ---- 8< ----
  I investigated perf test BPF for s390x and have a question regarding
  the 38.3 subtest (bpf-prologue test) which fails on s390x.

  When I turn on trace_printk in tests/bpf-script-test-prologue.c
  I see this output in /sys/kernel/debug/tracing/trace:

  [root@s8360047 perf]# cat /sys/kernel/debug/tracing/trace
  perf-30229 [000] d..2 170161.535791: : f_mode 2001d00000000 offset:0 orig:0
  perf-30229 [000] d..2 170161.535809: : f_mode 6001f00000000 offset:0 orig:0
  perf-30229 [000] d..2 170161.535815: : f_mode 6001f00000000 offset:1 orig:0
  perf-30229 [000] d..2 170161.535819: : f_mode 2001d00000000 offset:1 orig:0
  perf-30229 [000] d..2 170161.535822: : f_mode 2001d00000000 offset:2 orig:1
  perf-30229 [000] d..2 170161.535825: : f_mode 6001f00000000 offset:2 orig:1
  perf-30229 [000] d..2 170161.535828: : f_mode 6001f00000000 offset:3 orig:1
  perf-30229 [000] d..2 170161.535832: : f_mode 2001d00000000 offset:3 orig:1
  perf-30229 [000] d..2 170161.535835: : f_mode 2001d00000000 offset:4 orig:0
  perf-30229 [000] d..2 170161.535841: : f_mode 6001f00000000 offset:4 orig:0

  [...]

  There are 3 parameters the eBPF program tests/bpf-script-test-prologue.c
  accesses: f_mode (member of struct file at offset 140) offset and orig.  They
  are parameters of the lseek() system call triggered in this test case in
  function llseek_loop().

  What is really strange is the value of f_mode. It is an 8 byte value, whereas
  in the probe event it is defined as a 4 byte value.  The lower 4 bytes are all
  zero and do not belong to member f_mode.  The correct value should be 2001d for
  read-only and 6001f for read-write open mode.

  Here is the output of the 'perf test -vv bpf' trace:
  Try to find probe point from debuginfo.
  Matched function: null_lseek [2d9310d]
   Probe point found: null_lseek+0
  Searching 'file' variable in context.
  Converting variable file into trace event.
  converting f_mode in file
  f_mode type is unsigned int.
  Opening /sys/kernel/debug/tracing//README write=0
  Searching 'offset' variable in context.
  Converting variable offset into trace event.
  offset type is long long int.
  Searching 'orig' variable in context.
  Converting variable orig into trace event.
  orig type is int.
  Found 1 probe_trace_events.
  Opening /sys/kernel/debug/tracing//kprobe_events write=1
  Writing event: p:perf_bpf_probe/func _text+8794224 f_mode=+140(%r2):x32
 ---- 8< ----

This patch parses the type of each argument and converts data from memory to
expected type.

Now the test runs successfully on 4.13.0-rc5:

  [root@s8360046 perf]# ./perf test  bpf
  38: BPF filter                                 :
  38.1: Basic BPF filtering                      : Ok
  38.2: BPF pinning                              : Ok
  38.3: BPF prologue generation                  : Ok
  38.4: BPF relocation checker                   : Ok
  [root@s8360046 perf]#

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20170815092159.31912-1-tmricht@linux.vnet.ibm.com
Signed-off-by: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bpf-script-test-prologue.c |  4 ++-
 tools/perf/util/bpf-prologue.c              | 49 +++++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/bpf-script-test-prologue.c b/tools/perf/tests/bpf-script-test-prologue.c
index b4ebc75e25ae..43f1e16486f4 100644
--- a/tools/perf/tests/bpf-script-test-prologue.c
+++ b/tools/perf/tests/bpf-script-test-prologue.c
@@ -26,9 +26,11 @@ static void (*bpf_trace_printk)(const char *fmt, int fmt_size, ...) =
 	(void *) 6;
 
 SEC("func=null_lseek file->f_mode offset orig")
-int bpf_func__null_lseek(void *ctx, int err, unsigned long f_mode,
+int bpf_func__null_lseek(void *ctx, int err, unsigned long _f_mode,
 			 unsigned long offset, unsigned long orig)
 {
+	fmode_t f_mode = (fmode_t)_f_mode;
+
 	if (err)
 		return 0;
 	if (f_mode & FMODE_WRITE)
diff --git a/tools/perf/util/bpf-prologue.c b/tools/perf/util/bpf-prologue.c
index 1356220a9f1b..827f9140f3b8 100644
--- a/tools/perf/util/bpf-prologue.c
+++ b/tools/perf/util/bpf-prologue.c
@@ -58,6 +58,46 @@ check_pos(struct bpf_insn_pos *pos)
 	return 0;
 }
 
+/*
+ * Convert type string (u8/u16/u32/u64/s8/s16/s32/s64 ..., see
+ * Documentation/trace/kprobetrace.txt) to size field of BPF_LDX_MEM
+ * instruction (BPF_{B,H,W,DW}).
+ */
+static int
+argtype_to_ldx_size(const char *type)
+{
+	int arg_size = type ? atoi(&type[1]) : 64;
+
+	switch (arg_size) {
+	case 8:
+		return BPF_B;
+	case 16:
+		return BPF_H;
+	case 32:
+		return BPF_W;
+	case 64:
+	default:
+		return BPF_DW;
+	}
+}
+
+static const char *
+insn_sz_to_str(int insn_sz)
+{
+	switch (insn_sz) {
+	case BPF_B:
+		return "BPF_B";
+	case BPF_H:
+		return "BPF_H";
+	case BPF_W:
+		return "BPF_W";
+	case BPF_DW:
+		return "BPF_DW";
+	default:
+		return "UNKNOWN";
+	}
+}
+
 /* Give it a shorter name */
 #define ins(i, p) append_insn((i), (p))
 
@@ -258,9 +298,14 @@ gen_prologue_slowpath(struct bpf_insn_pos *pos,
 	}
 
 	/* Final pass: read to registers */
-	for (i = 0; i < nargs; i++)
-		ins(BPF_LDX_MEM(BPF_DW, BPF_PROLOGUE_START_ARG_REG + i,
+	for (i = 0; i < nargs; i++) {
+		int insn_sz = (args[i].ref) ? argtype_to_ldx_size(args[i].type) : BPF_DW;
+
+		pr_debug("prologue: load arg %d, insn_sz is %s\n",
+			 i, insn_sz_to_str(insn_sz));
+		ins(BPF_LDX_MEM(insn_sz, BPF_PROLOGUE_START_ARG_REG + i,
 				BPF_REG_FP, -BPF_REG_SIZE * (i + 1)), pos);
+	}
 
 	ins(BPF_JMP_IMM(BPF_JA, BPF_REG_0, 0, JMP_TO_SUCCESS_CODE), pos);
 
-- 
2.13.5
