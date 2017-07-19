From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 81/86] perf/x86/intel: Record branch type
Date: Wed, 19 Jul 2017 11:29:45 -0300
Message-ID: <20170719142950.3747-82-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Perf already has support for disassembling the branch instruction
and using the branch type for filtering. The patch just records
the branch type in perf_branch_entry.

Before recording, the patch converts the x86 branch type to
common branch type.

Change log:

v10: Set the branch_map array to be static. The previous version
     has it on stack then makes the compiler to create it every
     time when the function gets called.

v9: Use __ffs() to find first bit in type in common_branch_type().
    It lets the code be clear.

v8: Change PERF_BR_NONE to PERF_BR_UNKNOWN.

v7: Just convert following x86 branch types to common branch types.

X86_BR_CALL      -> PERF_BR_CALL
X86_BR_RET       -> PERF_BR_RET
X86_BR_JCC       -> PERF_BR_COND
X86_BR_JMP       -> PERF_BR_UNCOND
X86_BR_IND_CALL  -> PERF_BR_IND_CALL
X86_BR_ZERO_CALL -> PERF_BR_CALL
X86_BR_IND_JMP   -> PERF_BR_IND
X86_BR_SYSCALL   -> PERF_BR_SYSCALL
X86_BR_SYSRET    -> PERF_BR_SYSRET

Others are set to PERF_BR_NONE

v6: Not changed.

v5: Just fix the merge error. No other update.

v4: Comparing to previous version, the major changes are:

1. Uses a lookup table to convert x86 branch type to common branch
   type.

2. Move the JCC forward/JCC backward and cross page computing to
   user space.

3. Initialize branch type to 0 in intel_pmu_lbr_read_32 and
   intel_pmu_lbr_read_64

Signed-off-by: Yao Jin <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Link: http://lkml.kernel.org/r/1500379995-6449-3-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 arch/x86/events/intel/lbr.c | 52 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index eb261656a320..0edda489cf36 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -109,6 +109,9 @@ enum {
 	X86_BR_ZERO_CALL	= 1 << 15,/* zero length call */
 	X86_BR_CALL_STACK	= 1 << 16,/* call stack */
 	X86_BR_IND_JMP		= 1 << 17,/* indirect jump */
+
+	X86_BR_TYPE_SAVE	= 1 << 18,/* indicate to save branch type */
+
 };
 
 #define X86_BR_PLM (X86_BR_USER | X86_BR_KERNEL)
@@ -510,6 +513,7 @@ static void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 		cpuc->lbr_entries[i].in_tx	= 0;
 		cpuc->lbr_entries[i].abort	= 0;
 		cpuc->lbr_entries[i].cycles	= 0;
+		cpuc->lbr_entries[i].type	= 0;
 		cpuc->lbr_entries[i].reserved	= 0;
 	}
 	cpuc->lbr_stack.nr = i;
@@ -596,6 +600,7 @@ static void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		cpuc->lbr_entries[out].in_tx	 = in_tx;
 		cpuc->lbr_entries[out].abort	 = abort;
 		cpuc->lbr_entries[out].cycles	 = cycles;
+		cpuc->lbr_entries[out].type	 = 0;
 		cpuc->lbr_entries[out].reserved	 = 0;
 		out++;
 	}
@@ -673,6 +678,10 @@ static int intel_pmu_setup_sw_lbr_filter(struct perf_event *event)
 
 	if (br_type & PERF_SAMPLE_BRANCH_CALL)
 		mask |= X86_BR_CALL | X86_BR_ZERO_CALL;
+
+	if (br_type & PERF_SAMPLE_BRANCH_TYPE_SAVE)
+		mask |= X86_BR_TYPE_SAVE;
+
 	/*
 	 * stash actual user request into reg, it may
 	 * be used by fixup code for some CPU
@@ -926,6 +935,43 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 	return ret;
 }
 
+#define X86_BR_TYPE_MAP_MAX	16
+
+static int branch_map[X86_BR_TYPE_MAP_MAX] = {
+	PERF_BR_CALL,		/* X86_BR_CALL */
+	PERF_BR_RET,		/* X86_BR_RET */
+	PERF_BR_SYSCALL,	/* X86_BR_SYSCALL */
+	PERF_BR_SYSRET,		/* X86_BR_SYSRET */
+	PERF_BR_UNKNOWN,	/* X86_BR_INT */
+	PERF_BR_UNKNOWN,	/* X86_BR_IRET */
+	PERF_BR_COND,		/* X86_BR_JCC */
+	PERF_BR_UNCOND,		/* X86_BR_JMP */
+	PERF_BR_UNKNOWN,	/* X86_BR_IRQ */
+	PERF_BR_IND_CALL,	/* X86_BR_IND_CALL */
+	PERF_BR_UNKNOWN,	/* X86_BR_ABORT */
+	PERF_BR_UNKNOWN,	/* X86_BR_IN_TX */
+	PERF_BR_UNKNOWN,	/* X86_BR_NO_TX */
+	PERF_BR_CALL,		/* X86_BR_ZERO_CALL */
+	PERF_BR_UNKNOWN,	/* X86_BR_CALL_STACK */
+	PERF_BR_IND,		/* X86_BR_IND_JMP */
+};
+
+static int
+common_branch_type(int type)
+{
+	int i;
+
+	type >>= 2; /* skip X86_BR_USER and X86_BR_KERNEL */
+
+	if (type) {
+		i = __ffs(type);
+		if (i < X86_BR_TYPE_MAP_MAX)
+			return branch_map[i];
+	}
+
+	return PERF_BR_UNKNOWN;
+}
+
 /*
  * implement actual branch filter based on user demand.
  * Hardware may not exactly satisfy that request, thus
@@ -942,7 +988,8 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 	bool compress = false;
 
 	/* if sampling all branches, then nothing to filter */
-	if ((br_sel & X86_BR_ALL) == X86_BR_ALL)
+	if (((br_sel & X86_BR_ALL) == X86_BR_ALL) &&
+	    ((br_sel & X86_BR_TYPE_SAVE) != X86_BR_TYPE_SAVE))
 		return;
 
 	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
@@ -963,6 +1010,9 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 			cpuc->lbr_entries[i].from = 0;
 			compress = true;
 		}
+
+		if ((br_sel & X86_BR_TYPE_SAVE) == X86_BR_TYPE_SAVE)
+			cpuc->lbr_entries[i].type = common_branch_type(type);
 	}
 
 	if (!compress)
-- 
2.9.4
