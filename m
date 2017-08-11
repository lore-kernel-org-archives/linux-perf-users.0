From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH] perf bpf: Fix endianness problem when loading parameters in prologue
Date: Fri, 11 Aug 2017 10:46:04 +0000 (UTC)
Message-ID: <20170812184959.32694-1-wangnan0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Aug 2017 18:49:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, tmricht@linux.vnet.ibm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Wang Nan <wangnan0@huawei.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Li Zefan <lizefan@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

Perf BPF prologue generator unconditionally fetches 8 bytes for function
parameters, which causes problem on big endian machine. Thomas gives a
detail analysis for this problem:

 http://lkml.kernel.org/r/968ebda5-abe4-8830-8d69-49f62529d151@linux.vnet.ibm.com

This patch parses the type of each argument and converts data from
memory to expected type.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Li Zefan <lizefan@huawei.com>
---
 tools/perf/tests/bpf-script-test-prologue.c |  4 ++-
 tools/perf/util/bpf-prologue.c              | 49 +++++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/bpf-script-test-prologue.c b/tools/perf/tests/bpf-script-test-prologue.c
index b4ebc75..43f1e16 100644
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
index 6cdbee1..ce28993 100644
--- a/tools/perf/util/bpf-prologue.c
+++ b/tools/perf/util/bpf-prologue.c
@@ -57,6 +57,46 @@ check_pos(struct bpf_insn_pos *pos)
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
 
@@ -257,9 +297,14 @@ gen_prologue_slowpath(struct bpf_insn_pos *pos,
 	}
 
 	/* Final pass: read to registers */
-	for (i = 0; i < nargs; i++)
-		ins(BPF_LDX_MEM(BPF_DW, BPF_PROLOGUE_START_ARG_REG + i,
+	for (i = 0; i < nargs; i++) {
+		int insn_sz = argtype_to_ldx_size(args[i].type);
+
+		pr_debug("prologue: load arg %d, insn_sz is %s\n",
+			 i, insn_sz_to_str(insn_sz));
+		ins(BPF_LDX_MEM(insn_sz, BPF_PROLOGUE_START_ARG_REG + i,
 				BPF_REG_FP, -BPF_REG_SIZE * (i + 1)), pos);
+	}
 
 	ins(BPF_JMP_IMM(BPF_JA, BPF_REG_0, 0, JMP_TO_SUCCESS_CODE), pos);
 
-- 
2.10.1
