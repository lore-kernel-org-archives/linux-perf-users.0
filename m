Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0453E545D9B;
	Tue,  8 Sep 2026 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872551; cv=none; b=SNKP2z8Ojt7ehPGqyUBtKOsqPqteGVmEIgcuj74XqoMDeEdgMGI1HSvztLKthYoX2b02iem9k391LUq7lp2IhrB4d8dveV3gV8SilvIhxrNHnWawZ+odo8tiHDtITtiEw7UPk7dNQVEgPVPItYI9KZ6R7AeBPDI5jBTEpoLhOBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872551; c=relaxed/simple;
	bh=1w6BN86PhU2QkpYdAW7SZj5CTkrvUjcDgdKClncLJaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q2cB6ywdxi0dlInI3ouVi2NNfjoVtmvAhIK5E+Afd8e1UUkEmFvdtazSS1I/Asa3hIEQtdtvRhzgRXA4bU/nQiKrfSB+6c4nyu4d+elpSdHQJP2M9/KFCdN3UOffwGKC1dmgbkq/Q5LIA9wYoVpyiQ8JY7t/Z7oNokAN+ESNtkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfPFW1mjNzYQvVf;
	Tue,  8 Sep 2026 21:01:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BA5864057C;
	Tue,  8 Sep 2026 21:01:54 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAni5gpB6BqC9rlBA--.34632S18;
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
Subject: [PATCH v5 16/26] perf annotate-arm64: Support load instruction tracking
Date: Tue,  8 Sep 2026 13:01:12 +0000
Message-Id: <20260908130122.633500-17-wutengda@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAni5gpB6BqC9rlBA--.34632S18
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw1xKw4rtFyfXrWxXFW7XFb_yoWfuryfpF
	WDC3y5GrsrArs3WrsaqF48Wr9xuwn7Gr15Cr98Za9IyF42yrn5Ka93KFy2vF45Gr9ruw13
	Ja1DKrnrXw42kaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0pRepBfUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state_arm64() to handle load instructions, tracking
register state changes when data is loaded from memory to registers.

Two main categories are considered: standard load (e.g, ldr variants)
and load pair (ldp), for example:

  ldr dst, [src, #imm]
  ldp dst1, dst2, [src, #imm]

For data type propagation, a load pair can be treated as two standard
loads combined, first loading dst1 and then dst2. The difference is
that when loading dst2, an additional memory offset 'mem_offset' after
the first load must be added. This mem_offset can be derived from the
instruction mnemonic and the size of the dst register. Each load operation
is handled by introducing propagate_load_reg_state().

When processing a load pair, the case where dst and src registers are
the same (e.g., ldp x0, x1, [x0]) also needs to be considered. Therefore,
before propagating data types, a snapshot of the src register's state
must be saved and then passed to propagate_load_reg_state().

Finally, handle the side effects of pre-index and post-index addressing
via adjust_reg_index_state().

A real-world example is shown below:

  ffff80008011f5b0 <pick_task_stop>:
  ffff80008011f5b8:  ldr  x0, [x0, #2712] // x0: struct rq* -> task_struct*
* ffff80008011f5c0:  ldr  w1, [x0, #104]

Before this commit, the type of x0 was incorrectly inferred as 'struct rq':

  find data type for 0x68(reg0) at pick_task_stop+0x10
  var [8] reg0 offset 0 type='struct rq*'
  chk [10] reg0 offset=0x68 ok=1 kind=1 (struct rq*) : Good!
  final result:  type='struct rq'

After this commit, the type of x0 is correctly inferred as 'struct task_struct':

  find data type for 0x68(reg0) at pick_task_stop+0x10
  var [8] reg0 offset 0 type='struct rq*'
  ldr [8] 0xa98(reg0) -> reg0 type='struct task_struct*'
  chk [10] reg0 offset=0x68 ok=1 kind=1 (struct task_struct*) : Good!
  final result: type='struct task_struct'

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 202 +++++++++++++++++-
 1 file changed, 201 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 9a3226526522..c239ad9473dc 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -455,11 +455,206 @@ static bool is_readonly_branch_or_cmp(const char *name)
 	       !strcmp(name, "ccmp") || !strcmp(name, "ccmn");
 }
 
+static int arm64__reg_size(const char *reg)
+{
+	if (!reg || !*reg || !arm64__is_reg(reg))
+		return -1;
+
+	if (reg[0] == 'w')
+		return 4;
+
+	if (reg[0] == 'x' || !strncmp(reg, "sp", 2))
+		return 8;
+
+	return -1;
+}
+
+/* Apply addressing mode (pre-index, post-index) to register state */
+static void adjust_reg_index_state(struct type_state *state,
+				   struct data_loc_info *dloc,
+				   struct disasm_line *dl,
+				   struct annotated_op_loc *op_loc)
+{
+	struct type_state_reg *tsr;
+	int reg = op_loc->reg1;
+	int offset;
+
+	if (op_loc->addr_mode != PERF_AAM_PRE_INDEX &&
+	    op_loc->addr_mode != PERF_AAM_POST_INDEX)
+		return;
+
+	if (!has_reg_type(state, reg) || !state->regs[reg].ok)
+		return;
+
+	tsr = &state->regs[reg];
+	tsr->copied_from = -1;
+
+	if (arch_get_reg_offset(dloc->arch, op_loc, reg, state, true, &offset)) {
+		invalidate_reg_state(tsr);
+		return;
+	}
+
+	tsr->offset += offset;
+
+	pr_debug_dtp("%s [%x] %s-index %#x(reg%d) -> reg%d", dl->ins.name,
+		     (u32) dl->al.offset, op_loc->addr_mode == PERF_AAM_PRE_INDEX ?
+		     "pre" : "post", offset, reg, reg);
+	pr_debug_type_name(&tsr->type, tsr->kind);
+}
+
+/*
+ * Match standard load variants (ldr, ldur, ldar, ldp) that follow
+ * straightforward load semantics: memory source on the right
+ * and target registers on the left (written). Excludes exclusive loads
+ * (ldxr, ldxp, etc.) and acquire/exclusive combination variants.
+ */
+static bool is_standard_load_insn(const char *name)
+{
+	return !strncmp(name, "ldr", 3)  ||  /* ldr, ldrb, ldrh, ldrsb, ldrsh, ldrsw */
+	       !strncmp(name, "ldur", 4) ||  /* ldur, ldurb, ldurh, ldursb, ldursh, ldursw */
+	       !strncmp(name, "ldar", 4) ||  /* ldar, ldarb, ldarh */
+	       !strncmp(name, "ldp", 3);     /* ldp, ldpsw */
+}
+
+/*
+ * For load insns: propagate type from source reg state @src_states to @dreg.
+ *
+ * @mem_offset accounts for additional memory byte offset when handling multi-reg
+ * loads (e.g. second target reg in 'ldp'), which is added to the reg offset.
+ */
+static int propagate_load_reg_state(struct type_state *state,
+				    struct data_loc_info *dloc,
+				    struct disasm_line *dl, int dreg,
+				    struct annotated_op_loc *src,
+				    struct type_state_reg **src_states,
+				    int mem_offset)
+{
+	struct type_state_reg *tsr;
+	struct type_state_reg *src_tsr = src_states[0];
+	Dwarf_Die type_die;
+	u32 insn_offset = dl->al.offset;
+	int sreg = src->reg1;
+	int reg_offset;
+
+	if (!has_reg_type(state, dreg))
+		return -1;
+
+	tsr = &state->regs[dreg];
+	tsr->copied_from = -1;
+
+retry:
+	if (arch_get_reg_offset(dloc->arch, src, sreg, state, false, &reg_offset))
+		return -1;
+
+	reg_offset += mem_offset;
+
+	if (!src_tsr || !src_tsr->ok)
+		return -1;
+
+	/* Dereference the pointer if it has one */
+	if (src_tsr->kind == TSR_KIND_TYPE &&
+	    die_deref_ptr_type(&src_tsr->type,
+			       src_tsr->offset + reg_offset, &type_die)) {
+		tsr->type = type_die;
+		tsr->kind = TSR_KIND_TYPE;
+		tsr->offset = 0;
+		tsr->ok = true;
+
+		if (src->multi_regs) {
+			pr_debug_dtp("%s [%x] %#x(reg%d, reg%d) -> reg%d",
+				     dl->ins.name, insn_offset, reg_offset,
+				     src->reg1, src->reg2, dreg);
+		} else {
+			pr_debug_dtp("%s [%x] %#x(reg%d) -> reg%d",
+				     dl->ins.name, insn_offset, reg_offset,
+				     sreg, dreg);
+		}
+		pr_debug_type_name(&tsr->type, tsr->kind);
+		return 0;
+	}
+
+	/* Or try another register if any */
+	if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2 &&
+	    !(src->extend_type || src->shift_type)) {
+		sreg = src->reg2;
+		src_tsr = src_states[1];
+		goto retry;
+	}
+
+	return -1;
+}
+
+static void update_load_insn_state(struct type_state *state,
+				   struct data_loc_info *dloc,
+				   struct disasm_line *dl,
+				   struct annotated_op_loc *src,
+				   struct annotated_op_loc *dst)
+{
+	struct type_state_reg snapshots[2];
+	struct type_state_reg *src_states[2] = {};
+
+	if (!src->mem_ref ||  /* exclude PC-relative loads */
+	    !has_reg_type(state, dst->reg1) ||
+	    (dst->multi_regs && !has_reg_type(state, dst->reg2)))
+		goto out_err_adjust;
+
+	/*
+	 * Snapshot source register states before updating destination registers.
+	 * This avoids state corruption in aliased instructions (e.g., ldp x0, x1, [x0]),
+	 * ensuring the second destination load still uses the original base
+	 * register state.
+	 */
+	if (has_reg_type(state, src->reg1)) {
+		snapshots[0] = state->regs[src->reg1];
+		src_states[0] = &snapshots[0];
+	}
+	if (src->multi_regs && has_reg_type(state, src->reg2)) {
+		snapshots[1] = state->regs[src->reg2];
+		src_states[1] = &snapshots[1];
+	}
+
+	/* Handle the first destination register */
+	if (propagate_load_reg_state(state, dloc, dl, dst->reg1,
+				     src, src_states, /*mem_offset=*/0))
+		goto out_err_adjust;
+
+	/* Handle the second destination register (if any) */
+	if (dst->multi_regs) {
+		int mem_offset;
+
+		/*
+		 * ldpsw loads two 32-bit signed words into 64-bit registers.
+		 * Memory spacing between elements is 4 bytes, not the register size.
+		 */
+		if (!strcmp(dl->ins.name, "ldpsw"))
+			mem_offset = 4;
+		else
+			mem_offset = arm64__reg_size(dl->ops.target.raw);
+
+		if (mem_offset < 0 ||
+		    propagate_load_reg_state(state, dloc, dl, dst->reg2,
+					     src, src_states, mem_offset))
+			goto out_err_adjust;
+	}
+
+out_adjust:
+	adjust_reg_index_state(state, dloc, dl, src);
+	return;
+
+out_err_adjust:
+	if (has_reg_type(state, dst->reg1))
+		invalidate_reg_state(&state->regs[dst->reg1]);
+	if (dst->multi_regs && has_reg_type(state, dst->reg2))
+		invalidate_reg_state(&state->regs[dst->reg2]);
+	goto out_adjust;
+}
+
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
 {
 	struct annotated_insn_loc loc;
+	struct annotated_op_loc *src = &loc.ops[INSN_OP_SOURCE];
 	struct annotated_op_loc *dst = &loc.ops[INSN_OP_TARGET];
 	u32 insn_offset = dl->al.offset;
 
@@ -519,7 +714,8 @@ static void update_insn_state_arm64(struct type_state *state,
 	 * Invalidate destination register(s) for unsupported instructions to
 	 * prevent stale type info from propagating to subsequent instructions.
 	 */
-	if (has_reg_type(state, dst->reg1) && !dst->mem_ref) {
+	if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
+	    !is_standard_load_insn(dl->ins.name)) {
 		pr_debug_dtp("%s [%x] invalidate reg%d",
 			     dl->ins.name, insn_offset, dst->reg1);
 		invalidate_reg_state(&state->regs[dst->reg1]);
@@ -530,6 +726,10 @@ static void update_insn_state_arm64(struct type_state *state,
 		pr_debug_dtp("\n");
 		return;
 	}
+
+	/* Memory to register transfers */
+	if (is_standard_load_insn(dl->ins.name))
+		update_load_insn_state(state, dloc, dl, src, dst);
 }
 #endif
 
-- 
2.34.1

