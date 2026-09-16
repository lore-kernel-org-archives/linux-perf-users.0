Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F52B39A040;
	Wed, 16 Sep 2026 01:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522251; cv=none; b=hZwNtDTurm7FkWcnO+YyUlZGpOaJ0miOtcqYI4U0AtEr94WpNwgWs+5CTZK7uwmVp0+oX4IZqbT8wBJvoCqLcjNu6gsJly+Y18mrtpdeKxBzuqYTlejngFk06n7bT7Q7jg1F2bk3z9+uc2yERt7h+zCGOacqVRzw6/pHab0Z2QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522251; c=relaxed/simple;
	bh=6Zxq7rBPqyzY8BE7dFTeqVuI5+vxJ04T/nniM2/l5fM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i35yYA/G3eIqb6adz/+oZlliNhDI86wTf6Ow21t9QzdIlCfiz8Zynv0lu2CG7JHbuzqYHjnwtw/toN0s+tWMJYOXHiDqzmCaCO86Opu8g5DiqqCwpJv034z0HX3BvEReEGhYUYTvfRpoUH8uVoYxTzN+4YpYYBilBvTf7cmUlxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hl1YF42QFzYQtm5;
	Wed, 16 Sep 2026 09:30:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AB7EB40576;
	Wed, 16 Sep 2026 09:30:45 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgBHwPo_8alqshDTAQ--.7335S2;
	Wed, 16 Sep 2026 09:30:45 +0800 (CST)
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
Subject: [PATCH v6 24/26] perf annotate-arm64: Support 'adrp' instruction to track global variables
Date: Wed, 16 Sep 2026 01:30:16 +0000
Message-Id: <f2e85e2ea4bf16a01f0f930c6f0f9f50fe8bc57b.1789521520.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHwPo_8alqshDTAQ--.7335S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4UZr1xXrWfGr13CF17ZFb_yoWDJry5pF
	yDC34UW3y7tr4Sgrs3JFWUXr9a9ws7GFyj9ryqywsayFW7trn3GayktFWaqF45WF95Zw13
	Jw4qgr4DXw42kaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
	Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjTRXUUUUUUUU
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
index 68510813f08b..b25a3c70675c 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -531,7 +531,7 @@ static bool is_standard_load_insn(const char *name)
  * which is added to the reg offset.
  */
 static int propagate_load_reg_state(struct type_state *state,
-				    struct data_loc_info *dloc,
+				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl, int dreg,
 				    struct annotated_op_loc *src,
 				    struct type_state_reg **src_states,
@@ -638,6 +638,33 @@ static int propagate_load_reg_state(struct type_state *state,
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
 load_non_regoff:
 	/* Try another register if any */
 	if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2 &&
@@ -651,7 +678,7 @@ static int propagate_load_reg_state(struct type_state *state,
 }
 
 static void update_load_insn_state(struct type_state *state,
-				   struct data_loc_info *dloc,
+				   struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				   struct disasm_line *dl,
 				   struct annotated_op_loc *src,
 				   struct annotated_op_loc *dst)
@@ -685,7 +712,7 @@ static void update_load_insn_state(struct type_state *state,
 
 	/* Handle the first destination register */
 	if (has_reg_type(state, dst->reg1)) {
-		if (propagate_load_reg_state(state, dloc, dl, dst->reg1,
+		if (propagate_load_reg_state(state, dloc, cu_die, dl, dst->reg1,
 					     src, src_states, mem_spacing))
 			invalidate_reg_state(&state->regs[dst->reg1]);
 	}
@@ -700,7 +727,7 @@ static void update_load_insn_state(struct type_state *state,
 		mem_spacing = arm64__reg_size(dl->ops.target.raw);
 
 	if (mem_spacing < 0 ||
-	    propagate_load_reg_state(state, dloc, dl, dst->reg2,
+	    propagate_load_reg_state(state, dloc, cu_die, dl, dst->reg2,
 				     src, src_states, mem_spacing))
 		invalidate_reg_state(&state->regs[dst->reg2]);
 
@@ -911,14 +938,16 @@ static void update_add_insn_state(struct type_state *state,
 	if (arch_get_reg_offset(dloc->arch, src, sreg, state, false, &reg_offset))
 		goto add_non_regoff;
 
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
 
@@ -947,6 +976,39 @@ static void update_add_insn_state(struct type_state *state,
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
@@ -1013,6 +1075,7 @@ static void update_insn_state_arm64(struct type_state *state,
 	 * prevent stale type info from propagating to subsequent instructions.
 	 */
 	if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
+	    strcmp(dl->ins.name, "adrp") &&
 	    strcmp(dl->ins.name, "add") && strcmp(dl->ins.name, "mov") &&
 	    !is_standard_load_insn(dl->ins.name)) {
 		pr_debug_dtp("%s [%x] invalidate reg%d",
@@ -1026,14 +1089,16 @@ static void update_insn_state_arm64(struct type_state *state,
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
index 9ca59bc2f841..592ad8b1bc96 100644
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
@@ -613,7 +616,8 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 	stack->kind = kind;
 	stack->imm_value = imm_value;
 
-	if (kind == TSR_KIND_POINTER || kind == TSR_KIND_CONST) {
+	if (kind == TSR_KIND_POINTER || kind == TSR_KIND_CONST ||
+	    kind == TSR_KIND_GLOBAL_ADDR) {
 		stack->compound = false;
 		return;
 	}
@@ -1368,6 +1372,25 @@ static enum type_match_result check_matching_type(struct type_state *state,
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
index a0d7e20ed725..21ae6970cd13 100644
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

