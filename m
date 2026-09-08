Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E378356511D;
	Tue,  8 Sep 2026 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872785; cv=none; b=OeDeUNLj0i8cJ0wrmvBJPXHzHBzglcPv6BHyXxGD8YudvZUcvC8uG9BdoaJklT6CNFZrd6Qu/75unOBe5tjYSOrb3MsREnpzZJUFaZ0RZUbKpMTfscC/47nWT/SdHvxgcqznPV26JsbyRStnMWZhNEXC2IDMVG1UAxxiSe1Z1Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872785; c=relaxed/simple;
	bh=ZPujJxZpLlaDoEeWHuxg2Eo6F68T1VGrt/XUDbbutgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BlhcC0upF1qFK8YCBfS87GFhy3muty69btxDcShWlP26bMTXTaykdSP4UMvK/ABcB46JrA+OfliRLykBzKfms2wI0yCw6AFMCpB0oGsX+xLqCjiEIoHiyep3rYZxnbDP1TcSO7fAhdIOmAFGlMaXJGtOE+Vl03SpRLeZ5mvKtbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfPLc3pDWzYQtrD;
	Tue,  8 Sep 2026 21:05:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0AF1340577;
	Tue,  8 Sep 2026 21:06:20 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBHurdFCKBqUhjWBA--.26443S2;
	Tue, 08 Sep 2026 21:06:19 +0800 (CST)
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
Subject: [PATCH v5 24/26] perf annotate-arm64: Support 'adrp' instruction to track global variables
Date: Tue,  8 Sep 2026 13:06:05 +0000
Message-Id: <c9dae8385eb67cc4a05c4ad1bbaafec164ab0043.1788872630.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBHurdFCKBqUhjWBA--.26443S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4UZr1xXrWfGr13CF17ZFb_yoWfKw4rpF
	yDC34UWw47tr4Sgrs3XFWUXr9a9ws7GFyjkryqvrsayFW7trn3Ga97tFWaqFW5GF95Zw13
	Jw1DKr4DXw42kaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBlb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIE
	c7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc7CjxVAKzI0EY4vE52x082I5Mx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW0oVCq
	3wCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7sRM2-ntUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state_arm64() to track global variable types
calculated via page-relative addressing.

On arm64, global variables are typically accessed by first calculating
the page address using 'adrp', followed by an 'add' or 'ldr' to get the
specific symbol address. Without tracking 'adrp', the instruction
tracker loses the base address, making it impossible to resolve
global symbols and their associated DWARF types.

Introduce TSR_KIND_GLOBAL_ADDR to represent a partial global address
state. When encountering 'adrp', store the page-aligned target address
in the register's type state. Upon a subsequent 'add' or 'ldr'
instruction that references a TSR_KIND_GLOBAL_ADDR register, combine
the page address with the immediate offset.

A real-world example is shown below:

  ffff80008032e008 <folios_put_refs>:
  ffff80008032e048:  adrp  x24, ffff80008202f000 <nr_cpu_ids>
  ffff80008032e050:  add   x24, x24, #0xd40
* ffff80008032e078:  ldr   x0, [x24]

Before this commit, x24 was unknown, leading to no type information:

  chk [70] reg24 offset=0 ok=0 kind=0 cfa : no type information
  final result: no type information

After this commit, the tracker correctly follows the adrp/add flow:

  adrp [40] global addr=0xffff80008202f000 -> reg24
  add [48] global 0xd40(reg24) -> reg24
  chk [70] reg24 offset=0 ok=1 kind=7 global addr : Good!
  final result: type='struct folio*'

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 83 +++++++++++++++++--
 tools/perf/util/annotate-data.c               | 25 +++++-
 tools/perf/util/annotate-data.h               |  1 +
 3 files changed, 99 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index e237b9142684..9daf95905545 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -524,7 +524,7 @@ static bool is_standard_load_insn(const char *name)
  * loads (e.g. second target reg in 'ldp'), which is added to the reg offset.
  */
 static int propagate_load_reg_state(struct type_state *state,
-				    struct data_loc_info *dloc,
+				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl, int dreg,
 				    struct annotated_op_loc *src,
 				    struct type_state_reg **src_states,
@@ -622,6 +622,33 @@ static int propagate_load_reg_state(struct type_state *state,
 		return 0;
 	}
 
+	/* Or check if it's a global variable */
+	if (src_tsr->kind == TSR_KIND_GLOBAL_ADDR) {
+		u64 ip = dloc->ms->sym->start + dl->al.offset;
+		u64 addr = src_tsr->imm_value + reg_offset;
+		int offset;
+
+		if (!get_global_var_type(cu_die, dloc, ip, addr, &offset, &type_die) ||
+		    !die_get_member_type(&type_die, offset, &type_die))
+			return -1;
+
+		tsr->type = type_die;
+		tsr->kind = TSR_KIND_TYPE;
+		tsr->offset = 0;
+		tsr->imm_value = 0;
+		tsr->ok = true;
+
+		if (src->multi_regs) {
+			pr_debug_dtp("%s [%x] global (reg%d, reg%d) -> reg%d",
+				     dl->ins.name, insn_offset, src->reg1, src->reg2, dreg);
+		} else {
+			pr_debug_dtp("%s [%x] global (reg%d) -> reg%d",
+				     dl->ins.name, insn_offset, sreg, dreg);
+		}
+		pr_debug_type_name(&tsr->type, tsr->kind);
+		return 0;
+	}
+
 	/* Or try another register if any */
 	if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2 &&
 	    !(src->extend_type || src->shift_type)) {
@@ -634,7 +661,7 @@ static int propagate_load_reg_state(struct type_state *state,
 }
 
 static void update_load_insn_state(struct type_state *state,
-				   struct data_loc_info *dloc,
+				   struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				   struct disasm_line *dl,
 				   struct annotated_op_loc *src,
 				   struct annotated_op_loc *dst)
@@ -663,7 +690,7 @@ static void update_load_insn_state(struct type_state *state,
 	}
 
 	/* Handle the first destination register */
-	if (propagate_load_reg_state(state, dloc, dl, dst->reg1,
+	if (propagate_load_reg_state(state, dloc, cu_die, dl, dst->reg1,
 				     src, src_states, /*mem_offset=*/0))
 		goto out_err_adjust;
 
@@ -681,7 +708,7 @@ static void update_load_insn_state(struct type_state *state,
 			mem_offset = arm64__reg_size(dl->ops.target.raw);
 
 		if (mem_offset < 0 ||
-		    propagate_load_reg_state(state, dloc, dl, dst->reg2,
+		    propagate_load_reg_state(state, dloc, cu_die, dl, dst->reg2,
 					     src, src_states, mem_offset))
 			goto out_err_adjust;
 	}
@@ -894,14 +921,16 @@ static void update_add_insn_state(struct type_state *state,
 	if (arch_get_reg_offset(dloc->arch, src, sreg, state, false, &reg_offset))
 		goto try_other_reg;
 
-	if (src_tsr.kind == TSR_KIND_CONST) {
+	if (src_tsr.kind == TSR_KIND_CONST || src_tsr.kind == TSR_KIND_GLOBAL_ADDR) {
 		tsr->kind = src_tsr.kind;
+		/* For 'adrp + add' pair: resolve the full global variable address. */
 		tsr->imm_value = src_tsr.imm_value + reg_offset;
 		tsr->offset = 0;
 		tsr->ok = src_tsr.ok;
 
-		pr_debug_dtp("add [%x] imm %#x(reg%d) -> reg%d\n",
-			     insn_offset, reg_offset, sreg, dreg);
+		pr_debug_dtp("add [%x] %s %#x(reg%d) -> reg%d\n",
+			     insn_offset, src_tsr.kind == TSR_KIND_CONST ?
+			     "imm" : "global", reg_offset, sreg, dreg);
 		return;
 	}
 
@@ -930,6 +959,39 @@ static void update_add_insn_state(struct type_state *state,
 	invalidate_reg_state(tsr);
 }
 
+static void update_adrp_insn_state(struct type_state *state,
+				   struct disasm_line *dl,
+				   struct annotated_op_loc *dst)
+{
+	struct type_state_reg *tsr;
+	u32 insn_offset = dl->al.offset;
+	int dreg = dst->reg1;
+
+	if (!has_reg_type(state, dreg))
+		return;
+
+	tsr = &state->regs[dreg];
+	tsr->copied_from = -1;
+
+	if (!dl->ops.source.addr) {
+		invalidate_reg_state(tsr);
+		return;
+	}
+
+	tsr->kind = TSR_KIND_GLOBAL_ADDR;
+	/*
+	 * Stores a partial page-relative address. The full absolute address
+	 * of the global variable will be resolved when a subsequent 'add' or
+	 * 'ldr' instruction consumes this register.
+	 */
+	tsr->imm_value = dl->ops.source.addr;
+	tsr->offset = 0;
+	tsr->ok = true;
+
+	pr_debug_dtp("adrp [%x] global addr=%#"PRIx64" -> reg%d\n",
+		     insn_offset, tsr->imm_value, dreg);
+}
+
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
@@ -996,6 +1058,7 @@ static void update_insn_state_arm64(struct type_state *state,
 	 * prevent stale type info from propagating to subsequent instructions.
 	 */
 	if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
+	    strcmp(dl->ins.name, "adrp") &&
 	    strcmp(dl->ins.name, "add") && strcmp(dl->ins.name, "mov") &&
 	    !is_standard_load_insn(dl->ins.name)) {
 		pr_debug_dtp("%s [%x] invalidate reg%d",
@@ -1009,14 +1072,16 @@ static void update_insn_state_arm64(struct type_state *state,
 		return;
 	}
 
-	if (!strcmp(dl->ins.name, "add"))
+	if (!strcmp(dl->ins.name, "adrp"))
+		update_adrp_insn_state(state, dl, dst);
+	else if (!strcmp(dl->ins.name, "add"))
 		update_add_insn_state(state, dloc, dl, src, dst);
 	/* Register to register or imm value to register transfers */
 	else if (!strcmp(dl->ins.name, "mov"))
 		update_mov_insn_state(state, dl, src, dst);
 	/* Memory to register transfers */
 	else if (is_standard_load_insn(dl->ins.name))
-		update_load_insn_state(state, dloc, dl, src, dst);
+		update_load_insn_state(state, dloc, cu_die, dl, src, dst);
 	/* Register to memory transfers */
 	else if (is_standard_store_insn(dl->ins.name))
 		update_store_insn_state(state, dloc, dl, src, dst);
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 1936822c73f2..6897bd275e59 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -70,6 +70,9 @@ void pr_debug_type_name(Dwarf_Die *die, enum type_state_kind kind)
 	case TSR_KIND_CANARY:
 		pr_info(" stack canary\n");
 		return;
+	case TSR_KIND_GLOBAL_ADDR:
+		pr_info(" global address\n");
+		return;
 	case TSR_KIND_TYPE:
 	default:
 		break;
@@ -609,7 +612,8 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 	stack->kind = kind;
 	stack->imm_value = imm_value;
 
-	if (kind == TSR_KIND_POINTER || kind == TSR_KIND_CONST) {
+	if (kind == TSR_KIND_POINTER || kind == TSR_KIND_CONST ||
+	    kind == TSR_KIND_GLOBAL_ADDR) {
 		stack->compound = false;
 		return;
 	}
@@ -1365,6 +1369,25 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		if (offset < 0 && reg != state->stack_reg && reg != dloc->fbreg)
 			goto check_kernel;
 	}
+
+	if (state->regs[reg].kind == TSR_KIND_GLOBAL_ADDR) {
+		u64 var_addr = state->regs[reg].imm_value + offset;
+		int var_offset;
+
+		pr_debug_dtp("global addr");
+
+		/*
+		 * The register holds the address of a global variable. Try to
+		 * find the variable by the address and get its type.
+		 */
+		if (get_global_var_type(cu_die, dloc, dloc->ip, var_addr,
+					&var_offset, type_die)) {
+			dloc->type_offset = var_offset;
+			return PERF_TMR_OK;
+		}
+		/* No need to retry global variables */
+		return PERF_TMR_BAIL_OUT;
+	}
 check_non_register:
 	if (reg == dloc->fbreg || reg == state->stack_reg) {
 		struct type_state_stack *stack;
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 02d5602c5e20..885d441e3768 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -37,6 +37,7 @@ enum type_state_kind {
 	TSR_KIND_PERCPU_POINTER,
 	TSR_KIND_POINTER,
 	TSR_KIND_CANARY,
+	TSR_KIND_GLOBAL_ADDR,
 };
 
 /**
-- 
2.34.1

