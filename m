Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C536C0D2;
	Wed,  1 Jul 2026 03:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878100; cv=none; b=Vxr/ter8OMKl57QZwVoz15AQHn+D6BQlUo908iNiEcUp6+DzVh+czuQjQ8q5RsDbJomQbRLlzQQtlca5OVbz5lUgVXvbxLu/dLa0+sKVTt9U+IwUZ4O041lKRzus/Wj5CyI5zdszaAMh6ZEBWPuUIbpQCAVM11deX6g0qrHgqak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878100; c=relaxed/simple;
	bh=+FSvKGx4UNK8xcHkjhsXhYHL7gVypSXdcGSQ4na/n3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fr6/syL89fuLMVfeuhFOEncHN0f01fpt6BPZe3HuUIoI8vlFzfg+oWMFUxEtXrs/igFsfIyZM5AZxBHwrpaGmL3WoVFGNNCdleq/A5a4Y64lD6zv8JW8YLmZp1JB3zbm7VzUyheZ43zSyeA/1FC4zJyiHABXkGDQR/P6Mzurw/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gqmN04JJtzYQtsn;
	Wed,  1 Jul 2026 11:53:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 745B840B1D;
	Wed,  1 Jul 2026 11:54:46 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBXiyWAj0RqCne9AQ--.26189S18;
	Wed, 01 Jul 2026 11:54:46 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Li Huafei <lihuafei1@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v3 16/21] perf annotate-arm64: Support stack variable tracking
Date: Wed,  1 Jul 2026 03:53:50 +0000
Message-Id: <20260701035355.752944-17-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701035355.752944-1-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBXiyWAj0RqCne9AQ--.26189S18
X-Coremail-Antispam: 1UD129KBjvJXoW3Xry3Kw18Gw18GFW8trWfAFb_yoW7Kr47pF
	WDCa4agrsrtr4SgFs3JFZrJr93Wws7Kr1jkr90vwn2yFy2yrn5Ka95tFW2vFW5JrZ7Zw1U
	Jw1DKr4DX3y29aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6x
	kF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0piPkusUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state() for arm64 to track data types stored on the
stack. This allows 'perf annotate' to maintain type information for
local variables that are spilled to or loaded from stack slots.

The implementation handles:

1. Stack Loads (LDR): Identify when a register is loaded from a stack
   slot and update the register's type state based on the tracked
   stack content or compound member types.

2. Stack Stores (STR): Update or create new stack state entries when
   a tracked register type is stored to the stack.

With these changes, the instruction tracker can now follow data types
as they move between registers and memory, specifically for function
local variables and compiler-spilled values on arm64.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 124 +++++++++++++++++-
 1 file changed, 117 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index f283596bb058..255ccaf33130 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -11,6 +11,8 @@
 #include "../disasm.h"
 #include "../annotate-data.h"
 #include "../debug.h"
+#include "../map.h"
+#include "../symbol.h"
 
 struct arch_arm64 {
 	struct arch arch;
@@ -357,6 +359,7 @@ static void adjust_reg_index_state(struct type_state *state,
 }
 
 static void update_load_insn_state(struct type_state *state,
+				   struct data_loc_info *dloc,
 				   struct disasm_line *dl,
 				   struct annotated_op_loc *src,
 				   struct annotated_op_loc *dst)
@@ -368,6 +371,8 @@ static void update_load_insn_state(struct type_state *state,
 	int reg_offset;
 	int sreg = src->reg1;
 	int dreg = dst->reg1;
+	int fbreg = dloc->fbreg;
+	int fboff = 0;
 
 	if (!has_reg_type(state, dreg))
 		goto out_adjust;
@@ -375,7 +380,52 @@ static void update_load_insn_state(struct type_state *state,
 	tsr = &state->regs[dreg];
 	tsr->copied_from = -1;
 
+	if (dloc->fb_cfa) {
+		u64 ip = dloc->ms->sym->start + dl->al.offset;
+		u64 pc = map__rip_2objdump(dloc->ms->map, ip);
+
+		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
+			fbreg = -1;
+	}
+
 retry:
+	/* Check stack variables with offset */
+	if (sreg == fbreg || sreg == state->stack_reg) {
+		struct type_state_stack *stack;
+		int offset = src->offset - fboff;
+
+		stack = find_stack_state(state, offset);
+		if (stack == NULL) {
+			invalidate_reg_state(tsr);
+			goto out_adjust;
+		} else if (!stack->compound) {
+			tsr->type = stack->type;
+			tsr->kind = stack->kind;
+			tsr->offset = stack->ptr_offset;
+			tsr->ok = true;
+		} else if (die_get_member_type(&stack->type,
+					       offset - stack->offset,
+					       &type_die)) {
+			tsr->type = type_die;
+			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
+			tsr->ok = true;
+		} else {
+			invalidate_reg_state(tsr);
+			goto out_adjust;
+		}
+
+		if (sreg == fbreg) {
+			pr_debug_dtp("ldr [%x] -%#x(stack) -> reg%d",
+				     insn_offset, -offset, dreg);
+		} else {
+			pr_debug_dtp("ldr [%x] %#x(reg%d) -> reg%d",
+				     insn_offset, offset, sreg, dreg);
+		}
+		pr_debug_type_name(&tsr->type, tsr->kind);
+		goto out_adjust;
+	}
+
 	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
 		invalidate_reg_state(tsr);
 		return;
@@ -413,6 +463,70 @@ static void update_load_insn_state(struct type_state *state,
 	adjust_reg_index_state(state, src, "ldr", insn_offset);
 }
 
+static void update_store_insn_state(struct type_state *state,
+				    struct data_loc_info *dloc,
+				    struct disasm_line *dl,
+				    struct annotated_op_loc *src,
+				    struct annotated_op_loc *dst)
+{
+	struct type_state_reg *tsr;
+	u32 insn_offset = dl->al.offset;
+	int sreg = src->reg1;
+	int dreg = dst->reg1;
+	int fbreg = dloc->fbreg;
+	int fboff = 0;
+
+	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok)
+		goto out_adjust;
+
+	if (dloc->fb_cfa) {
+		u64 ip = dloc->ms->sym->start + dl->al.offset;
+		u64 pc = map__rip_2objdump(dloc->ms->map, ip);
+
+		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
+			fbreg = -1;
+	}
+
+	/* Check stack variables with offset */
+	if (dreg == fbreg || dreg == state->stack_reg) {
+		struct type_state_stack *stack;
+		int offset = dst->offset - fboff;
+
+		tsr = &state->regs[sreg];
+
+		stack = find_stack_state(state, offset);
+		if (stack) {
+			if (!stack->compound)
+				set_stack_state(stack, offset, tsr->kind,
+						&tsr->type, tsr->offset);
+		} else {
+			findnew_stack_state(state, offset, tsr->kind,
+					    &tsr->type, tsr->offset);
+		}
+
+		if (dst->reg1 == fbreg) {
+			pr_debug_dtp("str [%x] reg%d -> -%#x(stack)",
+				     insn_offset, sreg, -offset);
+		} else {
+			pr_debug_dtp("str [%x] reg%d -> %#x(reg%d)",
+				     insn_offset, sreg, offset, dreg);
+		}
+		if (tsr->offset != 0) {
+			pr_debug_dtp(" reg%d offset %#x ->",
+				     sreg, tsr->offset);
+		}
+		pr_debug_type_name(&tsr->type, tsr->kind);
+	}
+
+out_adjust:
+	/*
+	 * Store instructions do not change the register type,
+	 * but the base register must be updated for pre/post-index
+	 * modes.
+	 */
+	adjust_reg_index_state(state, dst, "str", insn_offset);
+}
+
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die __maybe_unused,
 				    struct disasm_line *dl)
@@ -439,18 +553,14 @@ static void update_insn_state_arm64(struct type_state *state,
 
 	/* Memory to register transfers */
 	if (!strncmp(dl->ins.name, "ld", 2)) {
-		update_load_insn_state(state, dl, src, dst);
+		update_load_insn_state(state, dloc, dl, src, dst);
 		return;
 	}
 
 	/* Register to memory transfers */
 	if (!strncmp(dl->ins.name, "st", 2)) {
-		/*
-		 * Store instructions do not change the register type,
-		 * but the base register must be updated for pre/post-index
-		 * modes.
-		 */
-		adjust_reg_index_state(state, dst, "str", insn_offset);
+		update_store_insn_state(state, dloc, dl, src, dst);
+		return;
 	}
 }
 #endif
-- 
2.34.1

