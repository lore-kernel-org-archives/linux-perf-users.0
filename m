Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2433D16EF;
	Sat,  8 Aug 2026 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786191873; cv=none; b=OotKk8Pr5Qw6m/10beD7bVPAiEH74XSe+8kJrck0xb2cqagGfVhlJOUqHEzhTuRbC+/BY6Cda7gexJ+gZE565H/4vgG5TnnNew7fWvx1l9eSBFkmEHCii8FL1RpACvAUeSkCENI5Cb3K5De61lCzwzVwjV0SK+WwQI3DuIWcsxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786191873; c=relaxed/simple;
	bh=3IXt5lzOugwDrVmzWldpoURS7haQ8iXpNtrj1nacML8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NQZlW3Uzch3eLu2I6e5yf7BVYj9AM8wr7tEE6kDxCisbVtGROX79MamgS3u5+y13VkOJD8MhQ+evL5LCF0EPt6kuBidpXajoVOybCqNcsH0RZ1lGifu59X0a/HMl2zmnrYxvws918DAW1usew08zMNEWtAqVmbyO/TrGO1zlLWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hHKvD0fbgzKHNH6;
	Sat,  8 Aug 2026 20:24:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 361EC4056D;
	Sat,  8 Aug 2026 20:24:19 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB34YjkH3dqbrhMBg--.41805S20;
	Sat, 08 Aug 2026 20:24:18 +0800 (CST)
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
Subject: [PATCH v4 18/23] perf annotate-arm64: Support stack variable tracking
Date: Sat,  8 Aug 2026 12:23:55 +0000
Message-Id: <20260808122400.2961238-19-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260808122400.2961238-1-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB34YjkH3dqbrhMBg--.41805S20
X-Coremail-Antispam: 1UD129KBjvJXoW3Xry3ArWfKFWrWFWDWr17Jrb_yoW3uw4xpF
	WDGa4rWrs7Jr4SgFsxJr4UJr93Ww4kKw1jkryDuws2yFy7tF1rKayvyayavFW5Gr97Zw15
	Jw1DCr4DXw47taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YV
	CY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRQYFCDUUUU
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

Similar to loads, stores also support saving one or two registers
(in the case of 'stp'). Therefore, propagate_store_reg_state() is
introduced. The overall offset calculation follows the same logic as
the load implementation:

  src->reg1: reg_offset = get_reg_index_offset()
  src->reg2: reg_offset = get_reg_index_offset() + reg_size(src->reg1)

With these changes, the instruction tracker can now follow data types
as they move between registers and memory, specifically for function
local variables and compiler-spilled values on arm64.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 161 ++++++++++++++++--
 1 file changed, 148 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index ed0f0ef2877d..6e09e9707256 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -407,6 +407,7 @@ static void adjust_reg_index_state(struct type_state *state,
  * to the source struct's field offset.
  */
 static int propagate_load_reg_state(struct type_state *state,
+				    struct data_loc_info *dloc,
 				    struct disasm_line *dl, int dreg,
 				    struct annotated_op_loc *src,
 				    int reg_offset, const char *insn_name)
@@ -416,6 +417,8 @@ static int propagate_load_reg_state(struct type_state *state,
 	Dwarf_Die type_die;
 	u32 insn_offset = dl->al.offset;
 	int sreg = src->reg1;
+	int fbreg = dloc->fbreg;
+	int fboff = 0;
 
 	if (!has_reg_type(state, dreg))
 		return -1;
@@ -423,7 +426,52 @@ static int propagate_load_reg_state(struct type_state *state,
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
+		int offset = sreg == fbreg ? reg_offset - fboff : reg_offset;
+
+		stack = find_stack_state(state, offset);
+		if (stack == NULL) {
+			return -1;
+		} else if (!stack->compound) {
+			tsr->type = stack->type;
+			tsr->kind = stack->kind;
+			tsr->offset = stack->ptr_offset;
+			tsr->imm_value = stack->imm_value;
+			tsr->ok = true;
+		} else if (die_get_member_type(&stack->type,
+					       offset - stack->offset,
+					       &type_die)) {
+			tsr->type = type_die;
+			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
+			tsr->imm_value = 0;
+			tsr->ok = true;
+		} else {
+			return -1;
+		}
+
+		if (sreg == fbreg) {
+			pr_debug_dtp("%s [%x] -%#x(stack) -> reg%d",
+				     insn_name, insn_offset, -offset, dreg);
+		} else {
+			pr_debug_dtp("%s [%x] %#x(reg%d) -> reg%d",
+				     insn_name, insn_offset, offset, sreg, dreg);
+		}
+		pr_debug_type_name(&tsr->type, tsr->kind);
+		return 0;
+	}
+
 	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok)
 		return -1;
 
@@ -460,6 +508,7 @@ static int propagate_load_reg_state(struct type_state *state,
 }
 
 static void update_load_insn_state(struct type_state *state,
+				   struct data_loc_info *dloc,
 				   struct disasm_line *dl,
 				   struct annotated_op_loc *src,
 				   struct annotated_op_loc *dst)
@@ -472,7 +521,7 @@ static void update_load_insn_state(struct type_state *state,
 		goto out_err_adjust;
 
 	/* Handle the first destination register */
-	if (propagate_load_reg_state(state, dl, dst->reg1, src,
+	if (propagate_load_reg_state(state, dloc, dl, dst->reg1, src,
 				     reg_offset, insn_name))
 		goto out_err_adjust;
 
@@ -481,7 +530,7 @@ static void update_load_insn_state(struct type_state *state,
 		int reg_size = arm64__reg_size(dl->ops.target.raw);
 
 		if (reg_size < 0 ||
-		    propagate_load_reg_state(state, dl, dst->reg2, src,
+		    propagate_load_reg_state(state, dloc, dl, dst->reg2, src,
 					     reg_offset + reg_size, insn_name))
 			goto out_err_adjust;
 	}
@@ -498,6 +547,100 @@ static void update_load_insn_state(struct type_state *state,
 	goto out_adjust;
 }
 
+/*
+ * For store insns: propagate type from @sreg to the memory location
+ * referenced by @dreg, applying @reg_offset to the destination memory offset.
+ */
+static int propagate_store_reg_state(struct type_state *state,
+				     struct data_loc_info *dloc,
+				     struct disasm_line *dl, int sreg, int dreg,
+				     int reg_offset, const char *insn_name)
+{
+	struct type_state_reg *tsr;
+	u32 insn_offset = dl->al.offset;
+	int fbreg = dloc->fbreg;
+	int fboff = 0;
+
+	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok)
+		return -1;
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
+		int offset = dreg == fbreg ? reg_offset - fboff : reg_offset;
+
+		tsr = &state->regs[sreg];
+
+		stack = find_stack_state(state, offset);
+		if (stack) {
+			if (!stack->compound)
+				set_stack_state(stack, offset, tsr->kind, &tsr->type,
+						tsr->offset, tsr->imm_value);
+			/*
+			 * If it's a compound type, it means attempting to
+			 * write to a member value of the compound type without
+			 * changing the compound type itself, so do nothing.
+			 */
+		} else {
+			findnew_stack_state(state, offset, tsr->kind, &tsr->type,
+					    tsr->offset, tsr->imm_value);
+		}
+
+		if (dreg == fbreg) {
+			pr_debug_dtp("%s [%x] reg%d -> -%#x(stack)",
+				     insn_name, insn_offset, sreg, -offset);
+		} else {
+			pr_debug_dtp("%s [%x] reg%d -> %#x(reg%d)",
+				     insn_name, insn_offset, sreg, offset, dreg);
+		}
+		if (tsr->offset != 0) {
+			pr_debug_dtp(" reg%d offset %#x ->",
+				     sreg, tsr->offset);
+		}
+		pr_debug_type_name(&tsr->type, tsr->kind);
+	}
+	/*
+	 * Ignore other transfers since it'd set a value in a struct
+	 * and won't change the type.
+	 */
+
+	return 0;
+}
+
+static void update_store_insn_state(struct type_state *state,
+				    struct data_loc_info *dloc,
+				    struct disasm_line *dl,
+				    struct annotated_op_loc *src,
+				    struct annotated_op_loc *dst)
+{
+	int reg_offset = get_reg_index_offset(dst);
+	const char *insn_name = src->multi_regs ? "stp" : "str";
+
+	/* Handle the first source register */
+	propagate_store_reg_state(state, dloc, dl, src->reg1, dst->reg1,
+				  reg_offset, insn_name);
+
+	/* Handle the second source register (stp only) */
+	if (src->multi_regs) {
+		int reg_size = arm64__reg_size(dl->ops.source.raw);
+
+		if (reg_size >= 0)
+			propagate_store_reg_state(state, dloc, dl, src->reg2,
+						  dst->reg1, reg_offset + reg_size,
+						  insn_name);
+	}
+
+	adjust_reg_index_state(state, dst, insn_name, dl->al.offset);
+}
+
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
@@ -574,18 +717,10 @@ static void update_insn_state_arm64(struct type_state *state,
 
 	/* Memory to register transfers */
 	if (!strncmp(dl->ins.name, "ld", 2))
-		update_load_insn_state(state, dl, src, dst);
+		update_load_insn_state(state, dloc, dl, src, dst);
 	/* Register to memory transfers */
-	else if (!strncmp(dl->ins.name, "st", 2)) {
-		/*
-		 * Ignore transfers since it'd set a value in a struct
-		 * and won't change the type.
-		 *
-		 * Needs to update the pre-index and post-index addressing
-		 * modes for the destination register.
-		 */
-		adjust_reg_index_state(state, dst, "str", insn_offset);
-	}
+	else if (!strncmp(dl->ins.name, "st", 2))
+		update_store_insn_state(state, dloc, dl, src, dst);
 }
 #endif
 
-- 
2.34.1

