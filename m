Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565873AA4EB;
	Wed, 16 Sep 2026 01:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522229; cv=none; b=JxOtaP+dUvZ6RpdrEy5bJJk2FMkeDbV0Pt9J2AQJULqxBWkkTed5CJlKyBxbqSw5lO27nWT5dr3kWsuwagWuhVj8CdHSizEhU2mZ08v/ra17eWLEOHJpnc3jUfSsd4/v7iKV2n7iP42w2ALSPFJp5qTSWWM4qjKXKZMyDE6duw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522229; c=relaxed/simple;
	bh=CYAWsgGfQzpw61WJo1udQTT4iUZ56p41ZSuuO/R4r3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=unamXiJNGvInG1iyIR6RftDni/F2TOLOby/X5uAdek6snN6VHJZ0bdSwyDo5rRKtcOX9I9c6AEf5TBGq5zBHDI3n0YESGdfzK2x5RJ/Rm0atXpaSVcMjXqsi/ao6mCawJm4drZqJ9zT6AVhSMen/muizvRcNv/8HAU/J9Nva5eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hl1XV2r5YzYQts3;
	Wed, 16 Sep 2026 09:30:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7EE484057B;
	Wed, 16 Sep 2026 09:30:06 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAn+CoH8alqUcjbAQ--.36458S18;
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
Subject: [PATCH v6 16/26] perf annotate-arm64: Support load instruction tracking
Date: Wed, 16 Sep 2026 01:29:30 +0000
Message-Id: <f95afe942520e925f209a2cd20c5f55d28c272b9.1789521520.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAn+CoH8alqUcjbAQ--.36458S18
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw1fWr13Kry7ZF4DWr43trb_yoWDJF1fpF
	WDC345Kw47Ar4SgrsIqF48Wr9xuw4xWr15Cr98Za9FyF47trn5Ka93tay2vF45GrZruw13
	Jw4Dtr98Xw42yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxc
	IEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc7CjxVAKzI0EY4vE52x082I5
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr
	0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRNg4S3UUUU
	U==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state_arm64() to handle load instructions, tracking
register state changes when data is loaded from memory to registers.

Two main categories are considered: standard load (e.g, ldr variants)
and load pair (ldp), for example:

  ldr dst, [src, #imm]
  ldp dst1, dst2, [src, #imm]

For data type propagation, a load pair can be treated as two standard
loads combined, first loading dst1 and then dst2. The difference is
that when loading dst2, an additional memory spacing 'mem_spacing' after
the first load must be added. This mem_spacing can be derived from the
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
 .../perf/util/annotate-arch/annotate-arm64.c  | 206 +++++++++++++++++-
 1 file changed, 205 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index d3d994a22cf9..11b2bdceaacb 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -461,11 +461,210 @@ static bool is_readonly_branch_or_cmp(const char *name)
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
+ * @mem_spacing accounts for the additional in-memory spacing between the two
+ * loads when handling multi-reg loads (e.g. the second target reg in 'ldp'),
+ * which is added to the reg offset.
+ */
+static int propagate_load_reg_state(struct type_state *state,
+				    struct data_loc_info *dloc,
+				    struct disasm_line *dl, int dreg,
+				    struct annotated_op_loc *src,
+				    struct type_state_reg **src_states,
+				    int mem_spacing)
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
+		goto load_non_regoff;
+
+	reg_offset += mem_spacing;
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
+		pr_debug_dtp("%s [%x] %#x(reg%d) -> reg%d",
+			     dl->ins.name, insn_offset, reg_offset, sreg, dreg);
+		pr_debug_type_name(&tsr->type, tsr->kind);
+		return 0;
+	}
+
+	/* Handle dereference of TSR_KIND_POINTER registers */
+	if (src_tsr->kind == TSR_KIND_POINTER &&
+	    die_get_member_type(&src_tsr->type,
+				src_tsr->offset + reg_offset, &type_die)) {
+		tsr->type = src_tsr->type;
+		tsr->kind = TSR_KIND_TYPE;
+		tsr->offset = src_tsr->offset + reg_offset;
+		tsr->imm_value = 0;
+		tsr->ok = true;
+
+		pr_debug_dtp("%s [%x] addr %#x(reg%d) -> reg%d",
+			     dl->ins.name, insn_offset, reg_offset, sreg, dreg);
+		pr_debug_type_name(&tsr->type, tsr->kind);
+		return 0;
+	}
+
+load_non_regoff:
+	/* Try another register if any */
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
+	int mem_spacing = 0;
+
+	if (!src->mem_ref ||  /* exclude PC-relative loads */
+	    !has_reg_type(state, src->reg1)) {
+		/* Invalidate tracked destination registers */
+		if (has_reg_type(state, dst->reg1))
+			invalidate_reg_state(&state->regs[dst->reg1]);
+		if (dst->multi_regs && has_reg_type(state, dst->reg2))
+			invalidate_reg_state(&state->regs[dst->reg2]);
+		goto out_adjust;
+	}
+
+	/*
+	 * Snapshot source register states before updating destination registers.
+	 * This preserves the original source state for aliased loads (e.g.,
+	 * ldp x0, x1, [x0]), where updating the first destination may overwrite
+	 * the source register.
+	 */
+	snapshots[0] = state->regs[src->reg1];
+	src_states[0] = &snapshots[0];
+	if (src->multi_regs && has_reg_type(state, src->reg2)) {
+		snapshots[1] = state->regs[src->reg2];
+		src_states[1] = &snapshots[1];
+	}
+
+	/* Handle the first destination register */
+	if (has_reg_type(state, dst->reg1)) {
+		if (propagate_load_reg_state(state, dloc, dl, dst->reg1,
+					     src, src_states, mem_spacing))
+			invalidate_reg_state(&state->regs[dst->reg1]);
+	}
+
+	if (!dst->multi_regs || !has_reg_type(state, dst->reg2))
+		goto out_adjust;
+
+	/* Handle the second destination register */
+	if (!strcmp(dl->ins.name, "ldpsw"))
+		mem_spacing = 4;  /* ldpsw loads two 32-bit signed words (4-byte spacing) */
+	else
+		mem_spacing = arm64__reg_size(dl->ops.target.raw);
+
+	if (mem_spacing < 0 ||
+	    propagate_load_reg_state(state, dloc, dl, dst->reg2,
+				     src, src_states, mem_spacing))
+		invalidate_reg_state(&state->regs[dst->reg2]);
+
+out_adjust:
+	adjust_reg_index_state(state, dloc, dl, src);
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
 
@@ -525,7 +724,8 @@ static void update_insn_state_arm64(struct type_state *state,
 	 * Invalidate destination register(s) for unsupported instructions to
 	 * prevent stale type info from propagating to subsequent instructions.
 	 */
-	if (has_reg_type(state, dst->reg1) && !dst->mem_ref) {
+	if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
+	    !is_standard_load_insn(dl->ins.name)) {
 		pr_debug_dtp("%s [%x] invalidate reg%d",
 			     dl->ins.name, insn_offset, dst->reg1);
 		invalidate_reg_state(&state->regs[dst->reg1]);
@@ -536,6 +736,10 @@ static void update_insn_state_arm64(struct type_state *state,
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

