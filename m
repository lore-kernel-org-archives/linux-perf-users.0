Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797D02C032E;
	Tue, 23 Jun 2026 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782219776; cv=none; b=cvwEtz+XPu3vfJTtZLRN0mKbxCJ7Uft0MO5t7utS+nMIpxNW/CV0basQMNGdvP6VJkYy/ItzOTQiWNGfiw+sOV4CJUZih+83YGLd/6PHL2/3AXmkuo3KqPP9uzxZS5o+05lCj+vO2wAe+B2Bt5mheaRNc6C55shW4ZcUCJzby+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782219776; c=relaxed/simple;
	bh=uBf/NUPqaQGVnyIgV8+S7JgiGUW6XUvHG83C1Yx2nX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J/dCNmfUF2wGzgfcejQuRa90JLwN67Wm7Rok9Ks6lSKcGsYSNorFax6KqBgJiOzD2a/r9nu+0t14oDQDTjC6hKJopXAwTQ/OXeYUw8Kj7P4wnCg3q5xrKOwg2JHLuz43Psgn0HprTflCmULpN3QiDvds+hj2aoDnjLNUAvwxqB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=keNibqYu; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="keNibqYu"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782219764; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=6MX40+WYzxJE1JvzdWd5EDFR/m/9Jpa98+SSThGGxRw=;
	b=keNibqYuX2ev86v6J0Xsi0BgbnHxzwg/53G9sVBYfloOP/GJRWHekFBUQi3PM24RLMxUzIhgKN0Y8QBjyvbyEQsId5r++Yj7kK5G2M9plp7LWAWzQArS1dfzCv5IFjHlUPJQSi7iLbqasIug1yPtic8q4M8WmuogMpko5jKcoBU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X5UKIn1_1782219762;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X5UKIn1_1782219762 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Jun 2026 21:02:42 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 5/5] perf annotate-arch: Add ARM64 data type profiling support
Date: Tue, 23 Jun 2026 21:02:34 +0800
Message-Id: <20260623130234.8709-6-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260623130234.8709-1-xueshuai@linux.alibaba.com>
References: <20260623130234.8709-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add data type profiling support for ARM64, enabling 'perf annotate
--code-with-type' to show which data types each memory instruction
accesses. This follows the PowerPC model of raw 32-bit instruction
decoding rather than x86's text-based operand parsing.

Instruction classification (check_arm64_insn):
  Classify instructions by raw encoding into load/store, arithmetic
  (add immediate, adrp), and register move categories. GP load/store
  is detected by bits[27:25] pattern with LDR (literal) excluded to
  avoid misinterpreting its different register field layout. ADRP, ADD
  immediate (with ADDG/SUBG excluded via tighter mask), and MOV
  (register) have their own mask/val pairs derived from the ARM ARM.

Load/store operand parsing:
  Set mem_ref=true for all GP load/store instructions. Detect register
  offset addressing mode to set multi_regs=true when Rm is used as a
  second source operand.

Register state tracking (update_insn_state_arm64):
  Track three instruction patterns for type propagation:

  - ADRP Xd, #page: Compute the PC-relative page address using
    sign_extend64() and either resolve the global variable type
    directly or store the address as TSR_KIND_CONST for later
    resolution by ADD.

  - ADD Xd, Xn, #imm: If Xn holds an ADRP result (TSR_KIND_CONST),
    compute the full variable address and resolve via
    get_global_var_type(). This handles the common ARM64 global
    variable access pattern: adrp+add+ldr.

  - MOV Xd, Xm: Propagate type state including kind, offset, and
    imm_value from the source to destination register.

Known limitations:
  - The adrp+ldr pattern (without intermediate ADD, using lo12 folded
    into the LDR offset) is not yet handled. This requires extending
    check_matching_type() to resolve TSR_KIND_CONST with the load
    offset, which can be added incrementally.
  - Pointer chain tracking (load-from-memory propagating type to the
    destination register) is not implemented, matching PowerPC's
    current scope.

Architecture initialization:
  Register the update_insn_state callback for instruction-level type
  state tracking.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 332 ++++++++++++++++++
 1 file changed, 332 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index b98aaf9a8a7b..887ed22c4ca0 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -1,12 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/bitops.h>
 #include <linux/compiler.h>
+#include <linux/kernel.h>
 #include <errno.h>
+#include <inttypes.h>
 #include <stdlib.h>
 #include <string.h>
 #include <linux/zalloc.h>
 #include <regex.h>
 #include "../annotate.h"
+#include "../debug.h"
 #include "../disasm.h"
+#ifdef HAVE_LIBDW_SUPPORT
+#include "../annotate-data.h"
+#include "../map.h"
+#include "../symbol.h"
+#endif
 
 struct arch_arm64 {
 	struct arch arch;
@@ -14,6 +23,47 @@ struct arch_arm64 {
 	regex_t jump_insn;
 };
 
+/*
+ * ARM64 instruction encoding masks and values.
+ * Derived from ARM Architecture Reference Manual, C4.1 A64 encoding index.
+ *
+ * These mirror the definitions in arch/arm64/include/asm/insn.h but are
+ * duplicated here because that header depends on kernel-only macros
+ * (BUILD_BUG_ON, __always_inline).
+ */
+
+/* GP Load/Store: bit[27]=1, bit[26]=0 (GP, not SIMD/FP), bit[25]=0 */
+#define A64_INSN_GP_LS_MASK	0x0e000000
+#define A64_INSN_GP_LS_VAL	0x08000000
+
+/* LDR/LDRSW (literal): bits[29:27]=011, bit[26]=0 -- must be excluded from GP LS */
+#define A64_INSN_LDR_LIT_MASK	0x3b000000
+#define A64_INSN_LDR_LIT_VAL	0x18000000
+
+/*
+ * Load/Store register (register offset):
+ * bits[29:27]=111, bits[25:24]=00, bit[21]=1, bits[11:10]=10
+ */
+#define A64_INSN_LS_REG_OFF_MASK	0x3b200c00
+#define A64_INSN_LS_REG_OFF_VAL	0x38200800
+
+/* ADRP: mask=0x9F000000, val=0x90000000 */
+#define A64_INSN_ADRP_MASK	0x9f000000
+#define A64_INSN_ADRP_VAL	0x90000000
+
+/* ADD (immediate): mask=0x7F800000, val=0x11000000 (excludes ADDG/SUBG) */
+#define A64_INSN_ADD_IMM_MASK	0x7f800000
+#define A64_INSN_ADD_IMM_VAL	0x11000000
+
+/* MOV (register) = ORR Xd/Wd, XZR/WZR, Xm/Wm: Rn=11111, imm6=000000 */
+#define A64_INSN_MOV_REG_MASK	0x7fe0ffe0
+#define A64_INSN_MOV_REG_VAL	0x2a0003e0
+
+/* Instruction field extraction */
+#define A64_RT(insn)	((insn) & 0x1f)
+#define A64_RN(insn)	(((insn) >> 5) & 0x1f)
+#define A64_RM(insn)	(((insn) >> 16) & 0x1f)
+
 static int arm64_mov__parse(const struct arch *arch __maybe_unused,
 			    struct ins_operands *ops,
 			    struct map_symbol *ms __maybe_unused,
@@ -69,6 +119,285 @@ static const struct ins_ops arm64_mov_ops = {
 	.scnprintf = mov__scnprintf,
 };
 
+/*
+ * ARM64 load/store instruction parser.
+ * Sets mem_ref and multi_regs based on raw instruction encoding.
+ */
+static int arm64_load_store__parse(const struct arch *arch __maybe_unused,
+				   struct ins_operands *ops,
+				   struct map_symbol *ms __maybe_unused,
+				   struct disasm_line *dl)
+{
+	u32 insn = dl->raw.raw_insn;
+
+	ops->source.mem_ref = true;
+	ops->source.multi_regs = false;
+
+	/* Load/Store register (register offset) uses Rm as second source */
+	if ((insn & A64_INSN_LS_REG_OFF_MASK) == A64_INSN_LS_REG_OFF_VAL)
+		ops->source.multi_regs = true;
+
+	ops->target.mem_ref = false;
+	ops->target.multi_regs = false;
+
+	return 0;
+}
+
+static int arm64_load_store__scnprintf(const struct ins *ins, char *bf,
+				       size_t size,
+				       struct ins_operands *ops,
+				       int max_ins_name)
+{
+	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name,
+			 ops->raw);
+}
+
+static const struct ins_ops arm64_load_store_ops = {
+	.parse     = arm64_load_store__parse,
+	.scnprintf = arm64_load_store__scnprintf,
+};
+
+static int arm64_arithmetic__parse(const struct arch *arch __maybe_unused,
+				   struct ins_operands *ops,
+				   struct map_symbol *ms __maybe_unused,
+				   struct disasm_line *dl __maybe_unused)
+{
+	ops->source.mem_ref = false;
+	ops->source.multi_regs = false;
+	ops->target.mem_ref = false;
+	ops->target.multi_regs = false;
+
+	return 0;
+}
+
+static int arm64_arithmetic__scnprintf(const struct ins *ins, char *bf,
+				       size_t size,
+				       struct ins_operands *ops,
+				       int max_ins_name)
+{
+	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name,
+			 ops->raw);
+}
+
+static const struct ins_ops arm64_arithmetic_ops = {
+	.parse     = arm64_arithmetic__parse,
+	.scnprintf = arm64_arithmetic__scnprintf,
+};
+
+/*
+ * Classify ARM64 instructions by raw encoding for data type profiling.
+ */
+const struct ins_ops *check_arm64_insn(struct disasm_line *dl)
+{
+	u32 insn = dl->raw.raw_insn;
+
+	/* Exclude LDR/LDRSW (literal) before matching GP Load/Store */
+	if ((insn & A64_INSN_LDR_LIT_MASK) == A64_INSN_LDR_LIT_VAL)
+		return NULL;
+
+	if ((insn & A64_INSN_GP_LS_MASK) == A64_INSN_GP_LS_VAL)
+		return &arm64_load_store_ops;
+
+	if ((insn & A64_INSN_MOV_REG_MASK) == A64_INSN_MOV_REG_VAL)
+		return &arm64_arithmetic_ops;
+
+	if ((insn & A64_INSN_ADRP_MASK) == A64_INSN_ADRP_VAL)
+		return &arm64_arithmetic_ops;
+
+	if ((insn & A64_INSN_ADD_IMM_MASK) == A64_INSN_ADD_IMM_VAL)
+		return &arm64_arithmetic_ops;
+
+	return NULL;
+}
+
+#ifdef HAVE_LIBDW_SUPPORT
+
+static inline bool arm64_is_adrp(u32 insn)
+{
+	return (insn & A64_INSN_ADRP_MASK) == A64_INSN_ADRP_VAL;
+}
+
+static inline bool arm64_is_add_imm(u32 insn)
+{
+	return (insn & A64_INSN_ADD_IMM_MASK) == A64_INSN_ADD_IMM_VAL;
+}
+
+static inline bool arm64_is_mov_reg(u32 insn)
+{
+	return (insn & A64_INSN_MOV_REG_MASK) == A64_INSN_MOV_REG_VAL;
+}
+
+/*
+ * Compute the page address from an ADRP instruction.
+ * ADRP Xd, #imm: Xd = (PC & ~0xFFF) + (imm << 12)
+ * immhi = bits[23:5] (19 bits), immlo = bits[30:29] (2 bits)
+ * imm = sign_extend(immhi:immlo, 21)
+ */
+static u64 arm64_adrp_target(u64 pc, u32 insn)
+{
+	u64 immhi = (insn >> 5) & 0x7ffff;
+	u64 immlo = (insn >> 29) & 0x3;
+	u64 imm = (immhi << 2) | immlo;
+
+	return (pc & ~0xfffULL) + (sign_extend64(imm, 20) << 12);
+}
+
+/*
+ * Track register state for ARM64 instructions.
+ *
+ * Handles three instruction patterns:
+ *
+ * 1. ADRP Xd, #page - computes a PC-relative page address.
+ *    Track the computed address so a subsequent LDR can resolve
+ *    the global variable.
+ *
+ * 2. ADD Xd, Xn, #imm - if Xn holds a tracked address (from ADRP),
+ *    propagate the adjusted address to Xd.
+ *
+ * 3. MOV Xd, Xm - propagate type state from Xm to Xd.
+ */
+static void update_insn_state_arm64(struct type_state *state,
+				    struct data_loc_info *dloc,
+				    Dwarf_Die *cu_die,
+				    struct disasm_line *dl)
+{
+	u32 insn = dl->raw.raw_insn;
+	int rd, rn;
+	struct type_state_reg *tsr;
+
+	if (arm64_is_adrp(insn)) {
+		u64 pc, page_addr;
+		int offset;
+		Dwarf_Die type_die;
+
+		rd = A64_RT(insn);
+		if (!has_reg_type(state, rd))
+			return;
+
+		tsr = &state->regs[rd];
+
+		pc = map__rip_2objdump(dloc->ms->map,
+				       dloc->ms->sym->start + dl->al.offset);
+		page_addr = arm64_adrp_target(pc, insn);
+
+		/*
+		 * Try to resolve the global variable at this page address.
+		 * If not found, store it as a constant for later ADD resolution.
+		 */
+		if (get_global_var_type(cu_die, dloc,
+					dloc->ms->sym->start + dl->al.offset,
+					page_addr, &offset, &type_die)) {
+			tsr->type = type_die;
+			tsr->kind = TSR_KIND_POINTER;
+			tsr->offset = offset;
+			tsr->ok = true;
+
+			pr_debug_dtp("adrp [%x] global addr=%#"PRIx64" -> reg%d",
+				     (u32)dl->al.offset, page_addr, rd);
+			pr_debug_type_name(&tsr->type, tsr->kind);
+		} else {
+			tsr->kind = TSR_KIND_CONST;
+			tsr->imm_value = page_addr;
+			tsr->ok = true;
+
+			pr_debug_dtp("adrp [%x] page=%#"PRIx64" -> reg%d\n",
+				     (u32)dl->al.offset, page_addr, rd);
+		}
+		return;
+	}
+
+	if (arm64_is_add_imm(insn)) {
+		int imm12, shift;
+		u64 var_addr;
+		int offset;
+		Dwarf_Die type_die;
+
+		rd = A64_RT(insn);
+		rn = A64_RN(insn);
+
+		if (!has_reg_type(state, rd) || !has_reg_type(state, rn))
+			return;
+
+		tsr = &state->regs[rd];
+
+		if (!state->regs[rn].ok) {
+			tsr->ok = false;
+			return;
+		}
+
+		imm12 = (insn >> 10) & 0xfff;
+		shift = ((insn >> 22) & 0x1) ? 12 : 0;
+
+		/*
+		 * If Rn holds an ADRP result (TSR_KIND_CONST), compute
+		 * the full address and try to resolve the global variable.
+		 */
+		if (state->regs[rn].kind == TSR_KIND_CONST) {
+			var_addr = state->regs[rn].imm_value +
+				   ((u64)imm12 << shift);
+
+			if (get_global_var_type(cu_die, dloc,
+						dloc->ms->sym->start + dl->al.offset,
+						var_addr, &offset, &type_die)) {
+				tsr->type = type_die;
+				tsr->kind = TSR_KIND_POINTER;
+				tsr->offset = offset;
+				tsr->ok = true;
+
+				pr_debug_dtp("add [%x] global addr=%#"PRIx64" -> reg%d",
+					     (u32)dl->al.offset, var_addr, rd);
+				pr_debug_type_name(&tsr->type, tsr->kind);
+				return;
+			}
+		}
+
+		/* Otherwise propagate existing type with adjusted offset */
+		if (state->regs[rn].kind == TSR_KIND_TYPE ||
+		    state->regs[rn].kind == TSR_KIND_POINTER) {
+			tsr->type = state->regs[rn].type;
+			tsr->kind = state->regs[rn].kind;
+			tsr->offset = state->regs[rn].offset + (imm12 << shift);
+			tsr->ok = true;
+
+			pr_debug_dtp("add [%x] imm=%#x reg%d -> reg%d",
+				     (u32)dl->al.offset, imm12 << shift, rn, rd);
+			pr_debug_type_name(&tsr->type, tsr->kind);
+		} else {
+			tsr->ok = false;
+		}
+		return;
+	}
+
+	if (arm64_is_mov_reg(insn)) {
+		int rm;
+
+		rd = A64_RT(insn);
+		rm = A64_RM(insn);
+
+		if (!has_reg_type(state, rd))
+			return;
+
+		tsr = &state->regs[rd];
+
+		if (!has_reg_type(state, rm) || !state->regs[rm].ok) {
+			tsr->ok = false;
+			return;
+		}
+
+		tsr->type = state->regs[rm].type;
+		tsr->kind = state->regs[rm].kind;
+		tsr->offset = state->regs[rm].offset;
+		tsr->imm_value = state->regs[rm].imm_value;
+		tsr->ok = true;
+
+		pr_debug_dtp("mov [%x] reg%d -> reg%d",
+			     (u32)dl->al.offset, rm, rd);
+		pr_debug_type_name(&tsr->type, tsr->kind);
+		return;
+	}
+}
+#endif /* HAVE_LIBDW_SUPPORT */
+
 static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const char *name)
 {
 	struct arch_arm64 *arm = container_of(arch, struct arch_arm64, arch);
@@ -105,6 +434,9 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 	arch->objdump.skip_functions_char = '+';
 	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
 	annotate_opts.show_asm_raw = true;
+#ifdef HAVE_LIBDW_SUPPORT
+	arch->update_insn_state = update_insn_state_arm64;
+#endif
 
 	/* bl, blr */
 	err = regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
-- 
2.51.2.612.gdc70283dfc

