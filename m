Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BDE3D170B;
	Sat,  8 Aug 2026 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786191875; cv=none; b=JpPJiEhlwefcSHVlmxTCtKmF6q4RhMPa/O2hrcL5F/Ce3rFhXSGQjvYYsy2a4NeDclC8nMz7obVNV7tnGmc8niqXAMJVHH8jQqXYl+JM0wXQoUxgPCfG71Iz7xKL7sXxIw5Fbjjpcac1cAOV6D5NyXdykMGNs2cQRkS0Xo5jZZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786191875; c=relaxed/simple;
	bh=9EQ/2KNMbKSX2g/SuKtXyzMGLbGPEUtEI/q7VKvXk/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RUukn5AV8l7Aqj0/tW2vHnmvztIzApvhM0hgAdzaFF9UN5w2lF4Vryjhv/OIw/KAw+BiZyyNHQgyRuRx1+xjxrxT4KE12rXbaL/+Ah2jr0GI4M1p7ZCvivaezVVGpo2qiWnIJcMbBFumt0Z57854lVrfqBJ2Z3uYhBL+bC+FfC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hHKvC4fL1zKHNG5;
	Sat,  8 Aug 2026 20:24:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BCB4B4057D;
	Sat,  8 Aug 2026 20:24:18 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB34YjkH3dqbrhMBg--.41805S16;
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
Subject: [PATCH v4 14/23] perf annotate-arm64: Support load instruction tracking
Date: Sat,  8 Aug 2026 12:23:51 +0000
Message-Id: <20260808122400.2961238-15-wutengda@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgB34YjkH3dqbrhMBg--.41805S16
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr1xCF4DXrWxGrWrGFW8Xrb_yoW3GrWxpF
	WDG34rKrZrtr4agFsaqFWDJr9xuwn7Gw15Cr98Za1ayF9Fyr1rKa9YkFy3uF45GrZruw43
	Ja1DtrWDXw47CaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Extend update_insn_state_arm64() to handle LDR instructions, tracking
register state changes when data is loaded from memory to registers.

The implementation handles the three primary arm64 addressing modes:
1. Signed offset: [base, #imm|reg]
2. Pre-index: [base, #imm]!
3. Post-index: [base], #imm

Before updating, check the addressing mode via get_reg_index_offset() to
obtain the actual source's reg_offset, and then propagate the type.

Since a load instruction may have two destination registers (in ldp cases),
introduce propagate_load_reg_state() to propagate the type for a specified
destination register using a given reg_offset. The respective reg_offset
values for the two registers are as follows:

  dst->reg1: reg_offset = get_reg_index_offset()
  dst->reg2: reg_offset = get_reg_index_offset() + reg_size(dst->reg1)

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
 .../perf/util/annotate-arch/annotate-arm64.c  | 148 +++++++++++++++++-
 1 file changed, 147 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index acff14ca01e0..6557c0ad11b2 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -358,11 +358,152 @@ static int extract_op_location_arm64(const struct arch *arch,
 }
 
 #ifdef HAVE_LIBDW_SUPPORT
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
+static int get_reg_index_offset(struct annotated_op_loc *op_loc)
+{
+	return op_loc->addr_mode == PERF_ADDR_MODE_POST_INDEX ? 0 : op_loc->offset;
+}
+
+/* Apply addressing mode (pre-index, post-index) to register state */
+static void adjust_reg_index_state(struct type_state *state,
+				   struct annotated_op_loc *op_loc,
+				   const char *insn_name, u32 insn_offset)
+{
+	struct type_state_reg *tsr;
+	int reg = op_loc->reg1;
+
+	if (op_loc->addr_mode != PERF_ADDR_MODE_PRE_INDEX &&
+	    op_loc->addr_mode != PERF_ADDR_MODE_POST_INDEX)
+		return;
+
+	if (!has_reg_type(state, reg) || !state->regs[reg].ok)
+		return;
+
+	tsr = &state->regs[reg];
+	tsr->copied_from = -1;
+	tsr->offset = op_loc->offset + tsr->offset;
+
+	pr_debug_dtp("%s [%x] %s-index %#x(reg%d) -> reg%d", insn_name,
+		     insn_offset, op_loc->addr_mode == PERF_ADDR_MODE_PRE_INDEX ?
+		     "pre" : "post", op_loc->offset, reg, reg);
+	pr_debug_type_name(&tsr->type, tsr->kind);
+}
+
+/*
+ * For load insns: propagate type from @src to @dreg, applying @reg_offset
+ * to the source struct's field offset.
+ */
+static int propagate_load_reg_state(struct type_state *state,
+				    struct disasm_line *dl, int dreg,
+				    struct annotated_op_loc *src,
+				    int reg_offset, const char *insn_name)
+{
+	struct type_state_reg *tsr;
+	struct type_state_reg src_tsr;
+	Dwarf_Die type_die;
+	u32 insn_offset = dl->al.offset;
+	int sreg = src->reg1;
+
+	if (!has_reg_type(state, dreg))
+		return -1;
+
+	tsr = &state->regs[dreg];
+	tsr->copied_from = -1;
+
+retry:
+	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok)
+		return -1;
+
+	src_tsr = state->regs[sreg];
+
+	/* Dereference the pointer if it has one */
+	if (src_tsr.kind == TSR_KIND_TYPE &&
+	    die_deref_ptr_type(&src_tsr.type,
+			       src_tsr.offset + reg_offset, &type_die)) {
+		tsr->type = type_die;
+		tsr->kind = TSR_KIND_TYPE;
+		tsr->offset = 0;
+		tsr->ok = true;
+
+		if (src->multi_regs) {
+			pr_debug_dtp("%s [%x] %#x(reg%d, reg%d) -> reg%d",
+				     insn_name, insn_offset, reg_offset,
+				     src->reg1, src->reg2, dreg);
+		} else {
+			pr_debug_dtp("%s [%x] %#x(reg%d) -> reg%d",
+				     insn_name, insn_offset, reg_offset,
+				     sreg, dreg);
+		}
+		pr_debug_type_name(&tsr->type, tsr->kind);
+		return 0;
+	}
+	/* Or try another register if any */
+	else if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2) {
+		sreg = src->reg2;
+		goto retry;
+	}
+
+	return -1;
+}
+
+static void update_load_insn_state(struct type_state *state,
+				   struct disasm_line *dl,
+				   struct annotated_op_loc *src,
+				   struct annotated_op_loc *dst)
+{
+	int reg_offset = get_reg_index_offset(src);
+	const char *insn_name = dst->multi_regs ? "ldp" : "ldr";
+
+	if (!has_reg_type(state, dst->reg1) ||
+	    (dst->multi_regs && !has_reg_type(state, dst->reg2)))
+		goto out_err_adjust;
+
+	/* Handle the first destination register */
+	if (propagate_load_reg_state(state, dl, dst->reg1, src,
+				     reg_offset, insn_name))
+		goto out_err_adjust;
+
+	/* Handle the second destination register (ldp only) */
+	if (dst->multi_regs) {
+		int reg_size = arm64__reg_size(dl->ops.target.raw);
+
+		if (reg_size < 0 ||
+		    propagate_load_reg_state(state, dl, dst->reg2, src,
+					     reg_offset + reg_size, insn_name))
+			goto out_err_adjust;
+	}
+
+out_adjust:
+	adjust_reg_index_state(state, src, insn_name, dl->al.offset);
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
 
@@ -418,7 +559,8 @@ static void update_insn_state_arm64(struct type_state *state,
 	 * Invalidate destination register(s) for unsupported instructions to
 	 * prevent stale type info from propagating to subsequent instructions.
 	 */
-	if (has_reg_type(state, dst->reg1)) {
+	if (has_reg_type(state, dst->reg1) &&
+	    strncmp(dl->ins.name, "ld", 2)) {
 		pr_debug_dtp("%s [%x] invalidate reg%d",
 			     dl->ins.name, insn_offset, dst->reg1);
 		invalidate_reg_state(&state->regs[dst->reg1]);
@@ -429,6 +571,10 @@ static void update_insn_state_arm64(struct type_state *state,
 		pr_debug_dtp("\n");
 		return;
 	}
+
+	/* Memory to register transfers */
+	if (!strncmp(dl->ins.name, "ld", 2))
+		update_load_insn_state(state, dl, src, dst);
 }
 #endif
 
-- 
2.34.1

