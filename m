Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA39436C9C1;
	Wed,  1 Jul 2026 03:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878100; cv=none; b=n6mKerVmtwcHPZXXk3f1gV6pQBNlWyv2XhsQt9vWb416tIdpTIAK3dzQ4RzI42LHfjlCsQO08V1OL+S22VOtPrgvcptjrF85wBF+NOKwhxY6dZka5BHV9ojV6V1RiCXXUsM7mm3JmwIaer9nmkZdYmb3HpevjIhis5usOX01jh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878100; c=relaxed/simple;
	bh=ws0zCIiOj1BbJk2TO2+6drSyQsoXK8jcM/als+QYpic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nrKL4HsAFlyiC/R54pD4BPA7mMGw7bfMG3eVQYBclDleJJzwCUAGUBJ2xLCdT5bueaxGZDIKtGVq0jaxrZ96pDq2fAUlN3hhhcic0Vc1zTUWSLD7OC6kRWijjr8idEWKLHXukZ7dH7BJAQqB/T1lxjJad25fjQhYdhHEMEDjG50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gqmN0393fzYQtsr;
	Wed,  1 Jul 2026 11:53:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4758D40590;
	Wed,  1 Jul 2026 11:54:46 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBXiyWAj0RqCne9AQ--.26189S16;
	Wed, 01 Jul 2026 11:54:45 +0800 (CST)
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
Subject: [PATCH v3 14/21] perf annotate-arm64: Support load instruction tracking
Date: Wed,  1 Jul 2026 03:53:48 +0000
Message-Id: <20260701035355.752944-15-wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgBXiyWAj0RqCne9AQ--.26189S16
X-Coremail-Antispam: 1UD129KBjvJXoW3WF1xtFy5XFWxWFyfZFy5Jwb_yoW7ZF1Upa
	98G345KrZrtr4agFsaqFZ7Jr9I9wn7Gr15Cr98uwsIyFW2yrn5Ka95KFy3uFW5trZ3ur13
	Jw4DtrZrXwnrCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Extend update_insn_state_arm64() to handle LDR instructions, tracking
register state changes when data is loaded from memory to registers.
This is essential for maintaining accurate type information when data
is moved from memory to registers.

The implementation handles the three primary arm64 addressing modes:
1. Signed offset: [base, #imm]
2. Pre-index: [base, #imm]!
3. Post-index: [base], #imm

Introduce adjust_reg_index_state() to handle the side effects of pre-index
and post-index addressing, where the base register is updated with the
offset after or before the memory access. This ensures that the register's
offset within a structure is correctly tracked across sequential
instructions.

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
 .../perf/util/annotate-arch/annotate-arm64.c  | 96 ++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 48b1c94273eb..b48545f35620 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -327,11 +327,98 @@ static int extract_op_location_arm64(const struct arch *arch,
 }
 
 #ifdef HAVE_LIBDW_SUPPORT
+static int get_reg_index_offset(struct annotated_op_loc *op_loc)
+{
+	return op_loc->addr_mode == PERF_ADDR_MODE_POST_INDEX ? 0 : op_loc->offset;
+}
+
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
+static void update_load_insn_state(struct type_state *state,
+				   struct disasm_line *dl,
+				   struct annotated_op_loc *src,
+				   struct annotated_op_loc *dst)
+{
+	struct type_state_reg *tsr;
+	struct type_state_reg src_tsr;
+	Dwarf_Die type_die;
+	u32 insn_offset = dl->al.offset;
+	int reg_offset;
+	int sreg = src->reg1;
+	int dreg = dst->reg1;
+
+	if (!has_reg_type(state, dreg))
+		goto out_adjust;
+
+	tsr = &state->regs[dreg];
+	tsr->copied_from = -1;
+
+retry:
+	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
+		invalidate_reg_state(tsr);
+		return;
+	}
+
+	src_tsr = state->regs[sreg];
+	reg_offset = get_reg_index_offset(src);
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
+			pr_debug_dtp("ldr [%x] %#x(reg%d, reg%d) -> reg%d",
+				     insn_offset, reg_offset, src->reg1,
+				     src->reg2, dreg);
+		} else {
+			pr_debug_dtp("ldr [%x] %#x(reg%d) -> reg%d",
+				     insn_offset, reg_offset, sreg, dreg);
+		}
+		pr_debug_type_name(&tsr->type, tsr->kind);
+	}
+	/* Or try another register if any */
+	else if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2) {
+		sreg = src->reg2;
+		goto retry;
+	}
+
+out_adjust:
+	adjust_reg_index_state(state, src, "ldr", insn_offset);
+}
+
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die __maybe_unused,
 				    struct disasm_line *dl)
 {
 	struct annotated_insn_loc loc;
+	struct annotated_op_loc *src = &loc.ops[INSN_OP_SOURCE];
 	struct annotated_op_loc *dst = &loc.ops[INSN_OP_TARGET];
 	u32 insn_offset = dl->al.offset;
 
@@ -342,12 +429,19 @@ static void update_insn_state_arm64(struct type_state *state,
 	 * For unsupported instructions with a destination register, invalidate
 	 * the destination register itself to prevent incorrect type propagation.
 	 */
-	if (has_reg_type(state, dst->reg1)) {
+	if (has_reg_type(state, dst->reg1) &&
+	    strncmp(dl->ins.name, "ld", 2)) {
 		pr_debug_dtp("%s [%x] invalidate reg%d\n",
 			     dl->ins.name, insn_offset, dst->reg1);
 		invalidate_reg_state(&state->regs[dst->reg1]);
 		return;
 	}
+
+	/* Memory to register transfers */
+	if (!strncmp(dl->ins.name, "ld", 2)) {
+		update_load_insn_state(state, dl, src, dst);
+		return;
+	}
 }
 #endif
 
-- 
2.34.1

