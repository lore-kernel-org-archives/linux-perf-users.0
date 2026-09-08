Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6778454B1A0;
	Tue,  8 Sep 2026 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872552; cv=none; b=YM6ejVhRx8LlD18YpsHPAzPJ6jMAGrl50RRAtXaJfyuvV6z5VVwqiVyhtWny7FkZrwKntp2ida0ajADCR2tqThHdz6furN8MLS3bnx0HFjYtbikS4rTC6spQdIMYsBTxUnk1yFp0Gg4+TkW8l2mWpNvTqCLuPsL51rNZV4UGG7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872552; c=relaxed/simple;
	bh=dlOHna5VA+Qea77GmBgJ9+CqcJ64xlT5jCLlh/OQpYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NhigwQu0Ifs5sigqpHPxsm47HCuOCONuaOoDA1vDjbFjR6A4M2UIfYxWCYckqD7LdT6JgZQxNLjgJY2LMnbsXRWW2pTw5WQqExISuBv/wEm87Yy4yRHm29sbP514XIjWP07s2we10/tE36L5/tDQf2J1SAztlZiPu1cpiVUI8MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfPFX0CvHzYQvV8;
	Tue,  8 Sep 2026 21:01:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 86FCC4057A;
	Tue,  8 Sep 2026 21:01:55 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAni5gpB6BqC9rlBA--.34632S23;
	Tue, 08 Sep 2026 21:01:54 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
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
Subject: [PATCH v5 21/26] perf annotate-arm64: Support stack variable tracking
Date: Tue,  8 Sep 2026 13:01:17 +0000
Message-Id: <20260908130122.633500-22-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908130122.633500-1-wutengda@huaweicloud.com>
References: <20260908130122.633500-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAni5gpB6BqC9rlBA--.34632S23
X-Coremail-Antispam: 1UD129KBjvJXoW3XryDCr1rWr1UJrW3Wr1DAwb_yoWxZr18pF
	4DGFyagrs7Ar4SgFs3XF48Xr93Cws7KF1qkr90kan2yFy3tr1FkayktFWavay5Jr97Zw13
	Jw1DKrsrXw47taDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
	1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7sR_hiSJUUUUU==
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
 .../perf/util/annotate-arch/annotate-arm64.c  | 159 ++++++++++++++++--
 1 file changed, 149 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 9d43e2c2041c..d520975c5936 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -535,6 +535,8 @@ static int propagate_load_reg_state(struct type_state *state,
 	u32 insn_offset = dl->al.offset;
 	int sreg = src->reg1;
 	int reg_offset;
+	int fbreg = dloc->fbreg;
+	int fboff = 0;
 
 	if (!has_reg_type(state, dreg))
 		return -1;
@@ -542,12 +544,57 @@ static int propagate_load_reg_state(struct type_state *state,
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
 		return -1;
 
 	reg_offset += mem_offset;
 
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
 
@@ -663,6 +710,106 @@ static bool is_standard_store_insn(const char *name)
 	       !strncmp(name, "stp", 3);     /* stp */
 }
 
+/*
+ * For store insns: propagate type from @sreg to the memory location referenced
+ * by @dst, applying @mem_offset to account for multi-regs stores (e.g. stp).
+ */
+static void propagate_store_reg_state(struct type_state *state,
+				      struct data_loc_info *dloc,
+				      struct disasm_line *dl, int sreg,
+				      struct annotated_op_loc *dst,
+				      int mem_offset)
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
+	reg_offset += mem_offset;
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
+	/* Handle the first source register */
+	propagate_store_reg_state(state, dloc, dl, src->reg1, dst, /*mem_offset=*/0);
+
+	/* Handle the second source register (if any) */
+	if (src->multi_regs) {
+		int mem_offset = arm64__reg_size(dl->ops.source.raw);
+
+		if (mem_offset >= 0)
+			propagate_store_reg_state(state, dloc, dl, src->reg2,
+						  dst, mem_offset);
+	}
+
+	adjust_reg_index_state(state, dloc, dl, dst);
+}
+
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
@@ -745,16 +892,8 @@ static void update_insn_state_arm64(struct type_state *state,
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

