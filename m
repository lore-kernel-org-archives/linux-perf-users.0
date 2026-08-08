Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFCE379C24;
	Sat,  8 Aug 2026 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786191876; cv=none; b=oCw6DfbUJ2pXjWZaxgZAGKB7NxSc6WItOq8TKywfiR5chWz1uPtXnDuK75fraOI0+b3wmGCko7tk9ZfDgWjwI9jKY9+VvQNIDs+zI5YoafmM7miTsTiEXFMke/QB5lMaSvelO4rV4ZtZqPGJzARUfT6cYjzXfu1OvLY21leY4MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786191876; c=relaxed/simple;
	bh=5AQ1sfkblPfhUK5+sAYKrPa+Vd/BWYqjSpK/LOsiOcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z+9RsHrZGD95UoYVuVEwEnASmRhbysj3E2VDa8A2Z1YakIRiASbLmDU2hUFyAb35jCf31slZCYjG5NuP1UpVwn7ozedqveKiiIe+Ugawceumz1lrxeYssAHoQdi96GhZQ/1nBiQHsYSqDvgH9gGdi+xHdUeAKJypgs5Qk6lxGVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hHKvD3BrfzKHNJR;
	Sat,  8 Aug 2026 20:24:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8F1BD409C8;
	Sat,  8 Aug 2026 20:24:19 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB34YjkH3dqbrhMBg--.41805S23;
	Sat, 08 Aug 2026 20:24:19 +0800 (CST)
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
Subject: [PATCH v4 21/23] perf annotate-arm64: Support 'adrp' instruction to track global variables
Date: Sat,  8 Aug 2026 12:23:58 +0000
Message-Id: <20260808122400.2961238-22-wutengda@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgB34YjkH3dqbrhMBg--.41805S23
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4UZr1xXrWfGr13CF17ZFb_yoWfKw1DpF
	WDC34UWw47tr4SgFs3JFWUXr9a9ws7Ga4jkryqvwsayFW7trn3GayktFWavFW5GF95Zw13
	Jw4DKr4DXw42kaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRQYFCDUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state() for arm64 to track global variable types
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
 .../perf/util/annotate-arch/annotate-arm64.c  | 82 +++++++++++++++++--
 tools/perf/util/annotate-data.c               | 25 +++++-
 tools/perf/util/annotate-data.h               |  1 +
 3 files changed, 98 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index eaeb4433fc3a..7eb3bef26a64 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -408,7 +408,7 @@ static void adjust_reg_index_state(struct type_state *state,
  * to the source struct's field offset.
  */
 static int propagate_load_reg_state(struct type_state *state,
-				    struct data_loc_info *dloc,
+				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl, int dreg,
 				    struct annotated_op_loc *src,
 				    int reg_offset, const char *insn_name)
@@ -500,6 +500,32 @@ static int propagate_load_reg_state(struct type_state *state,
 		pr_debug_type_name(&tsr->type, tsr->kind);
 		return 0;
 	}
+	/* Or check if it's a global variable */
+	else if (src_tsr.kind == TSR_KIND_GLOBAL_ADDR) {
+		u64 ip = dloc->ms->sym->start + dl->al.offset;
+		u64 addr = src_tsr.imm_value + reg_offset;
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
+				     insn_name, insn_offset, src->reg1, src->reg2, dreg);
+		} else {
+			pr_debug_dtp("%s [%x] global (reg%d) -> reg%d",
+				     insn_name, insn_offset, sreg, dreg);
+		}
+		pr_debug_type_name(&tsr->type, tsr->kind);
+		return 0;
+	}
 	/* Or try another register if any */
 	else if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2) {
 		sreg = src->reg2;
@@ -510,7 +536,7 @@ static int propagate_load_reg_state(struct type_state *state,
 }
 
 static void update_load_insn_state(struct type_state *state,
-				   struct data_loc_info *dloc,
+				   struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				   struct disasm_line *dl,
 				   struct annotated_op_loc *src,
 				   struct annotated_op_loc *dst)
@@ -523,7 +549,7 @@ static void update_load_insn_state(struct type_state *state,
 		goto out_err_adjust;
 
 	/* Handle the first destination register */
-	if (propagate_load_reg_state(state, dloc, dl, dst->reg1, src,
+	if (propagate_load_reg_state(state, dloc, cu_die, dl, dst->reg1, src,
 				     reg_offset, insn_name))
 		goto out_err_adjust;
 
@@ -532,7 +558,7 @@ static void update_load_insn_state(struct type_state *state,
 		int reg_size = arm64__reg_size(dl->ops.target.raw);
 
 		if (reg_size < 0 ||
-		    propagate_load_reg_state(state, dloc, dl, dst->reg2, src,
+		    propagate_load_reg_state(state, dloc, cu_die, dl, dst->reg2, src,
 					     reg_offset + reg_size, insn_name))
 			goto out_err_adjust;
 	}
@@ -735,14 +761,16 @@ static void update_add_insn_state(struct type_state *state,
 			imm_value = state->regs[reg2].imm_value;
 	}
 
-	if (src_tsr.kind == TSR_KIND_CONST) {
+	if (src_tsr.kind == TSR_KIND_CONST || src_tsr.kind == TSR_KIND_GLOBAL_ADDR) {
 		tsr->kind = src_tsr.kind;
+		/* For 'adrp + add' pair: resolve the full global variable address. */
 		tsr->imm_value = src_tsr.imm_value + imm_value;
 		tsr->offset = 0;
 		tsr->ok = src_tsr.ok;
 
-		pr_debug_dtp("add [%x] imm %#"PRIx64"(reg%d) -> reg%d\n",
-			     insn_offset, imm_value, sreg, dreg);
+		pr_debug_dtp("add [%x] %s %#"PRIx64"(reg%d) -> reg%d\n",
+			     insn_offset, src_tsr.kind == TSR_KIND_CONST ?
+			     "imm" : "global", imm_value, sreg, dreg);
 		return;
 	}
 
@@ -769,6 +797,39 @@ static void update_add_insn_state(struct type_state *state,
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
@@ -831,6 +892,7 @@ static void update_insn_state_arm64(struct type_state *state,
 	 * prevent stale type info from propagating to subsequent instructions.
 	 */
 	if (has_reg_type(state, dst->reg1) &&
+	    strcmp(dl->ins.name, "adrp") &&
 	    strcmp(dl->ins.name, "add") && strcmp(dl->ins.name, "mov") &&
 	    strncmp(dl->ins.name, "ld", 2) && strncmp(dl->ins.name, "st", 2)) {
 		pr_debug_dtp("%s [%x] invalidate reg%d",
@@ -844,14 +906,16 @@ static void update_insn_state_arm64(struct type_state *state,
 		return;
 	}
 
-	if (!strcmp(dl->ins.name, "add"))
+	if (!strcmp(dl->ins.name, "adrp"))
+		update_adrp_insn_state(state, dl, dst);
+	else if (!strcmp(dl->ins.name, "add"))
 		update_add_insn_state(state, dl, src, dst);
 	/* Register to register or imm value to register transfers */
 	else if (!strcmp(dl->ins.name, "mov"))
 		update_mov_insn_state(state, dl, src, dst);
 	/* Memory to register transfers */
 	else if (!strncmp(dl->ins.name, "ld", 2))
-		update_load_insn_state(state, dloc, dl, src, dst);
+		update_load_insn_state(state, dloc, cu_die, dl, src, dst);
 	/* Register to memory transfers */
 	else if (!strncmp(dl->ins.name, "st", 2))
 		update_store_insn_state(state, dloc, dl, src, dst);
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 9dcdc3c7e688..7fe5b979563f 100644
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
@@ -1279,6 +1283,25 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		if (dloc->op->offset < 0 && reg != state->stack_reg && reg != dloc->fbreg)
 			goto check_kernel;
 	}
+
+	if (state->regs[reg].kind == TSR_KIND_GLOBAL_ADDR) {
+		u64 var_addr = state->regs[reg].imm_value + dloc->op->offset;
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
index 06fc4dbfb35c..8158e43b30df 100644
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

