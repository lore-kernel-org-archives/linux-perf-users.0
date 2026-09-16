Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B0A3AEF34;
	Wed, 16 Sep 2026 01:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522226; cv=none; b=W60ua9WJDds2iPiZhLnAS4XJuJcn0SqEz96DJ4KLy+qP03F+Ab6XOTIti2+zDHkAlfoNeG5s8pf6ueA9lwkuzK/CqueXoRBJ3x4RL3naeMO2keTrTMBnIw7fBD1ZOMgxHjTLIMRqN7YjsHkVX9obboxvaxLhPFA4aDdvCAo2bsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522226; c=relaxed/simple;
	bh=T8fOPDbSzuUwTalFsMDiF9HJRjwralWIhRfc7ujjM8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u4bB69R+qqUl+k5vPb7hqYeGql7UuBhVvk7vjF75BuRx9FbhKGTv++y20tdivDES+sR2oR7gTZEUy4BXmBxqU0JL2XP0sJHw0wAV/1CskXxhPmGgrd2XcXhZUm5Dpw+WtjBVvZrW5oW7ll5tYIA/sGUl7VbtFKNwfac65b7vAj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hl1XK2HyKzKHMXF;
	Wed, 16 Sep 2026 09:29:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EAB104056F;
	Wed, 16 Sep 2026 09:30:06 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAn+CoH8alqUcjbAQ--.36458S23;
	Wed, 16 Sep 2026 09:30:06 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v6 21/26] perf annotate-arm64: Support stack variable tracking
Date: Wed, 16 Sep 2026 01:29:35 +0000
Message-Id: <11bcde1a75d96b524cc5a7f6fa442025680e56a0.1789521520.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAn+CoH8alqUcjbAQ--.36458S23
X-Coremail-Antispam: 1UD129KBjvJXoW3XryDAw1rXry7XF1fAw4UCFg_yoWxuw1xpF
	4DGFy3WwsrJr4S9Fs3Xr48Xr93uws7Kr1qkr90van2yFy3tF1Ykayktayavay5Gr97Zw17
	Jw4DKr4DX3y7taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YV
	CY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRQYFCDUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state_arm64() to track data types stored on the
stack.

The implementation handles:
1. Stack Loads: Identify when a register is loaded from a stack
   slot and update the register's type state based on the tracked
   stack content or compound member types.
2. Stack Stores: Update or create new stack state entries when
   a tracked register type is stored to the stack.

Similar to loads, stores also support saving one or two registers
(in the case of 'stp'). Therefore, propagate_store_reg_state() is
introduced.

With these changes, the instruction tracker can now follow data types
as they move between registers and memory, specifically for function
local variables and compiler-spilled values on arm64.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 168 ++++++++++++++++--
 1 file changed, 158 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index a72c7703dd6b..8339aab0d314 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -542,6 +542,8 @@ static int propagate_load_reg_state(struct type_state *state,
 	u32 insn_offset = dl->al.offset;
 	int sreg = src->reg1;
 	int reg_offset;
+	int fbreg = dloc->fbreg;
+	int fboff = 0;
 
 	if (!has_reg_type(state, dreg))
 		return -1;
@@ -549,12 +551,57 @@ static int propagate_load_reg_state(struct type_state *state,
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
 	if (arch_get_reg_offset(dloc->arch, src, sreg, state, false, &reg_offset))
 		goto load_non_regoff;
 
 	reg_offset += mem_spacing;
 
+	/* Check stack variables with offset */
+	if (sreg != -1 && (sreg == fbreg || sreg == state->stack_reg)) {
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
+				     dl->ins.name, insn_offset, -offset, dreg);
+		} else {
+			pr_debug_dtp("%s [%x] %#x(reg%d) -> reg%d",
+				     dl->ins.name, insn_offset, offset, sreg, dreg);
+		}
+		pr_debug_type_name(&tsr->type, tsr->kind);
+		return 0;
+	}
+
 	if (!src_tsr || !src_tsr->ok)
 		return -1;
 
@@ -673,6 +720,115 @@ static bool is_standard_store_insn(const char *name)
 	       !strncmp(name, "stp", 3);     /* stp */
 }
 
+/*
+ * For store insns: propagate type from @sreg to the memory location referenced
+ * by @dst, applying @mem_spacing to account for multi-regs stores (e.g. stp).
+ */
+static void propagate_store_reg_state(struct type_state *state,
+				      struct data_loc_info *dloc,
+				      struct disasm_line *dl, int sreg,
+				      struct annotated_op_loc *dst,
+				      int mem_spacing)
+{
+	struct type_state_reg *tsr;
+	u32 insn_offset = dl->al.offset;
+	int dreg = dst->reg1;
+	int reg_offset;
+	int fbreg = dloc->fbreg;
+	int fboff = 0;
+
+	if (arch_get_reg_offset(dloc->arch, dst, dreg, state, false, &reg_offset))
+		return;
+
+	reg_offset += mem_spacing;
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
+	if (dreg != -1 && (dreg == fbreg || dreg == state->stack_reg)) {
+		struct type_state_stack *stack;
+		int offset = dreg == fbreg ? reg_offset - fboff : reg_offset;
+
+		if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
+			stack = find_stack_state(state, offset);
+			/* Preserve compound states when only a member is overwritten. */
+			if (stack && !stack->compound)
+				delete_stack_state(state, offset);
+
+			return;
+		}
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
+				     dl->ins.name, insn_offset, sreg, -offset);
+		} else {
+			pr_debug_dtp("%s [%x] reg%d -> %#x(reg%d)",
+				     dl->ins.name, insn_offset, sreg, offset, dreg);
+		}
+		if (tsr->offset != 0)
+			pr_debug_dtp(" reg%d offset %#x ->", sreg, tsr->offset);
+
+		pr_debug_type_name(&tsr->type, tsr->kind);
+	}
+	/*
+	 * Ignore other transfers since it'd set a value in a struct
+	 * and won't change the type.
+	 */
+}
+
+static void update_store_insn_state(struct type_state *state,
+				    struct data_loc_info *dloc,
+				    struct disasm_line *dl,
+				    struct annotated_op_loc *src,
+				    struct annotated_op_loc *dst)
+{
+	int mem_spacing = 0;
+
+	if (!has_reg_type(state, dst->reg1))
+		return;
+
+	/* Handle the first source register */
+	if (has_reg_type(state, src->reg1))
+		propagate_store_reg_state(state, dloc, dl, src->reg1,
+					  dst, mem_spacing);
+
+	if (!src->multi_regs || !has_reg_type(state, src->reg2))
+		goto out_adjust;
+
+	/* Handle the second source register */
+	mem_spacing = arm64__reg_size(dl->ops.source.raw);
+
+	if (mem_spacing >= 0)
+		propagate_store_reg_state(state, dloc, dl, src->reg2,
+					  dst, mem_spacing);
+
+out_adjust:
+	adjust_reg_index_state(state, dloc, dl, dst);
+}
+
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
@@ -755,16 +911,8 @@ static void update_insn_state_arm64(struct type_state *state,
 	if (is_standard_load_insn(dl->ins.name))
 		update_load_insn_state(state, dloc, dl, src, dst);
 	/* Register to memory transfers */
-	else if (is_standard_store_insn(dl->ins.name)) {
-		/*
-		 * Ignore transfers since it'd set a value in a struct
-		 * and won't change the type.
-		 *
-		 * Needs to update the pre-index and post-index addressing
-		 * modes for the destination register.
-		 */
-		adjust_reg_index_state(state, dloc, dl, dst);
-	}
+	else if (is_standard_store_insn(dl->ins.name))
+		update_store_insn_state(state, dloc, dl, src, dst);
 }
 #endif
 
-- 
2.34.1

