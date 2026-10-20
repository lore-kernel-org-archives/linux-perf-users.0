Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503970;
	b=Pw3bgeQHkpElWty42L4hlJyE8J3J+kCXkwDmKnYhAEohYKzTtoj8cstenXyeMImMIa8f
	 TS8+rCx2bEA8v2+iDSczF6Vt6PWHP5GFb5QOsIIFADCRcOdHXGa6mfEGCywkkRh8JD6nR
	 gwn9Uf6VryiGKZPvbSPeL/sqKqNu1klO7UCv+39TfP9SCE/C6V1Ut3nhGVMEX7zlDx4Ip
	 Vk57bharWhuHcXDer4tqEmgHatL3M6hvYUEvJ8LKYncFtPL/THL5vGlwU0jTuNDEQPcd5
	 xtFdeIMF4fFixiIKQcMJT6x4ArTogpSFSWeYTDJRW2ehzFcuByy3K11kyyWdBnTzVFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503970;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=o05/N5XctkzqpgC1ZA4yQ9odlH7Bn0l5cVVTJizsZfo=;
	b=vt/DYShMWCi1Qf12ygGWOa0UTap+/noQdp/xXJ/EvUvPqIPGvws7Tvq26lYUm3iwZGJT
	 enAwHBvy6Hj/t7XiBMYIxdJBhPE3HaEKTLhTait4psCNih2a+Y+fIauV4J90Inbh+RmAY
	 Hp4Y9mVwJfVTY6ZIxS6Z261PGbfteqsu+VXVW816vbw0GdwYbAV3TYRJlWul7xgXLFqKI
	 3JA+vn+WnBlqBurBgqbhTRD413K1ajiqbGdUWmzoSbu6H/zbCGlnoyBJD3hflE7tfNXmP
	 23eu+69+ZDVf/AzV9Voc4o/5suKSxQ8LCQ0MDbPIRDx+/l3Qc/b9Mjail7i/xnrCVlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=none smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.51
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEBA606A325;
	Tue, 20 Oct 2026 13:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FEBA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j8DFw1W1ZzYQtw9;
	Tue, 20 Oct 2026 21:45:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 33AD540561;
	Tue, 20 Oct 2026 21:45:58 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB3QOaGcNdq8xegBA--.22174S7;
	Tue, 20 Oct 2026 21:45:57 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH v8 05/15] perf annotate-arm64: Support load instruction tracking
Date: Tue, 20 Oct 2026 13:45:01 +0000
Message-Id: <a6085b6f08ba2ed533208ebe9227968770cd58ca.1792411435.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792411435.git.wutengda@huaweicloud.com>
References: <cover.1792411435.git.wutengda@huaweicloud.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB3QOaGcNdq8xegBA--.22174S7
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw1fWr13Kry7ZF4DWr43trb_yoWftrWfpF
	WDC34UK3y7Ar4SgrsIqF48Wr9xuw4xWr15Cr98Z39IyF47trn5Ka93Kay2qF45GrZruw13
	JwsFkr9xWw42kaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YV
	CY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRQYFCDUUUU
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

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 204 ++++++++++++++++++
 1 file changed, 204 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index c4cc8bca85cc..0b5d1abbc575 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -527,11 +527,212 @@ static void invalidate_unhandled_insn_regs(struct type_state *state,
 	/* TODO: Extend invalidation support to more special instructions. */
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
+	tsr->lifetime_active = false;
+	tsr->lifetime_end = 0;
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
 
 	if (is_readonly_insn(dl->ins.name))
@@ -542,6 +743,9 @@ static void update_insn_state_arm64(struct type_state *state,
 
 	if (ins__is_call(&dl->ins))
 		update_call_insn_state(state, dloc, cu_die, dl);
+	/* Memory to register transfers */
+	else if (is_standard_load_insn(dl->ins.name))
+		update_load_insn_state(state, dloc, dl, src, dst);
 	else
 		invalidate_unhandled_insn_regs(state, dl, dst);
 }
-- 
2.34.1

