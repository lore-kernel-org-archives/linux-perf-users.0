Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD92E36C5B3;
	Wed,  1 Jul 2026 03:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878099; cv=none; b=pl4obhIRLnVohBi0rkQcOMPgouRYZ4agpszBloM5zcVfxtiAhoMvLB7suYthbj0XLpX8S6Hf5oOrkx12k6UqkkQbTZGZOIGOaADLDRWzKtU/M7k46smQcFW9woyj/RPCw7DTpQRUvdT0ZMSjL6Y1FC0HJsCfUqCLtJgs5nkxSik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878099; c=relaxed/simple;
	bh=4wL8En1DoyUSlUB2jwQOEEhr+LZZ3tmWUkjWe8XspkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D0/XqfpCsqRrBNSZ/+xDPIvA+0CYjtTH7C6CMYXt453zBXgxOREmiqpcpeohhXs33P6cvu1gUne8cKC3CFi/w0YdaaxggsDiM7T3G+SwU19UCbu01IBIrrSUw7HNWJr1jiZJgqhksF1VWVQq8JbJIj20//b8/N3xNq5MTCJ45Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gqmN06Z1LzYQttB;
	Wed,  1 Jul 2026 11:53:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C298740561;
	Wed,  1 Jul 2026 11:54:46 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBXiyWAj0RqCne9AQ--.26189S21;
	Wed, 01 Jul 2026 11:54:46 +0800 (CST)
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
Subject: [PATCH v3 19/21] perf annotate-arm64: Support 'adrp' instruction to track global variables
Date: Wed,  1 Jul 2026 03:53:53 +0000
Message-Id: <20260701035355.752944-20-wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgBXiyWAj0RqCne9AQ--.26189S21
X-Coremail-Antispam: 1UD129KBjvAXoW3CrW5KF15KF4xCw4fXF1UWrg_yoW8Jw43Go
	W3tF43ArZ7ArW8C3y09r1xJryY9rWvk3y5Ja15ta4q93W3Cw1j9rs3K3WfZ34xXr1agF1D
	Ar1Dta18trykAws3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOG7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
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
 .../perf/util/annotate-arch/annotate-arm64.c  | 89 +++++++++++++++++--
 tools/perf/util/annotate-arch/annotate-x86.c  |  6 +-
 tools/perf/util/annotate-data.c               | 33 +++++--
 tools/perf/util/annotate-data.h               |  7 +-
 4 files changed, 121 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 1fed18811719..6f96e75d313d 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -7,6 +7,7 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <regex.h>
+#include <inttypes.h>
 #include "../annotate.h"
 #include "../disasm.h"
 #include "../annotate-data.h"
@@ -359,7 +360,7 @@ static void adjust_reg_index_state(struct type_state *state,
 }
 
 static void update_load_insn_state(struct type_state *state,
-				   struct data_loc_info *dloc,
+				   struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				   struct disasm_line *dl,
 				   struct annotated_op_loc *src,
 				   struct annotated_op_loc *dst)
@@ -402,6 +403,7 @@ static void update_load_insn_state(struct type_state *state,
 			tsr->type = stack->type;
 			tsr->kind = stack->kind;
 			tsr->offset = stack->ptr_offset;
+			tsr->addr = stack->addr;
 			tsr->ok = true;
 		} else if (die_get_member_type(&stack->type,
 					       offset - stack->offset,
@@ -409,6 +411,7 @@ static void update_load_insn_state(struct type_state *state,
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
 			tsr->offset = 0;
+			tsr->addr = 0;
 			tsr->ok = true;
 		} else {
 			invalidate_reg_state(tsr);
@@ -441,6 +444,7 @@ static void update_load_insn_state(struct type_state *state,
 		tsr->type = type_die;
 		tsr->kind = TSR_KIND_TYPE;
 		tsr->offset = 0;
+		tsr->addr = 0;
 		tsr->ok = true;
 
 		if (src->multi_regs) {
@@ -453,6 +457,33 @@ static void update_load_insn_state(struct type_state *state,
 		}
 		pr_debug_type_name(&tsr->type, tsr->kind);
 	}
+	/* Or check if it's a global variable */
+	else if (src_tsr.kind == TSR_KIND_GLOBAL_ADDR) {
+		u64 ip = dloc->ms->sym->start + dl->al.offset;
+		u64 addr = src_tsr.addr + reg_offset;
+		int offset;
+
+		if (!get_global_var_type(cu_die, dloc, ip, addr, &offset, &type_die) ||
+		    !die_get_member_type(&type_die, offset, &type_die)) {
+			invalidate_reg_state(tsr);
+			goto out_adjust;
+		}
+
+		tsr->type = type_die;
+		tsr->kind = TSR_KIND_TYPE;
+		tsr->offset = 0;
+		tsr->addr = 0;
+		tsr->ok = true;
+
+		if (src->multi_regs) {
+			pr_debug_dtp("ldr [%x] global (reg%d, reg%d) -> reg%d",
+				     insn_offset, src->reg1, src->reg2, dreg);
+		} else {
+			pr_debug_dtp("ldr [%x] global (reg%d) -> reg%d",
+				     insn_offset, sreg, dreg);
+		}
+		pr_debug_type_name(&tsr->type, tsr->kind);
+	}
 	/* Or try another register if any */
 	else if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2) {
 		sreg = src->reg2;
@@ -498,10 +529,10 @@ static void update_store_insn_state(struct type_state *state,
 		if (stack) {
 			if (!stack->compound)
 				set_stack_state(stack, offset, tsr->kind,
-						&tsr->type, tsr->offset);
+						&tsr->type, tsr->offset, tsr->addr);
 		} else {
 			findnew_stack_state(state, offset, tsr->kind,
-					    &tsr->type, tsr->offset);
+					    &tsr->type, tsr->offset, tsr->addr);
 		}
 
 		if (dst->reg1 == fbreg) {
@@ -547,6 +578,7 @@ static void update_mov_insn_state(struct type_state *state,
 		tsr->kind = TSR_KIND_CONST;
 		tsr->imm_value = src->offset;
 		tsr->offset = 0;
+		tsr->addr = 0;
 		tsr->ok = true;
 
 		pr_debug_dtp("mov [%x] imm=%#x -> reg%d\n",
@@ -563,6 +595,7 @@ static void update_mov_insn_state(struct type_state *state,
 	tsr->kind = state->regs[sreg].kind;
 	tsr->imm_value = state->regs[sreg].imm_value;
 	tsr->offset = state->regs[sreg].offset;
+	tsr->addr = state->regs[sreg].addr;
 	tsr->ok = state->regs[sreg].ok;
 
 	if (tsr->kind == TSR_KIND_TYPE || tsr->kind == TSR_KIND_POINTER)
@@ -641,6 +674,7 @@ static void update_add_insn_state(struct type_state *state,
 		tsr->type = src_tsr.type;
 		tsr->kind = src_tsr.kind;
 		tsr->offset = offset;
+		tsr->addr = 0;
 		tsr->ok = src_tsr.ok;
 
 		pr_debug_dtp("add [%x] address of %s%#x(reg%d) -> reg%d",
@@ -649,6 +683,16 @@ static void update_add_insn_state(struct type_state *state,
 
 		pr_debug_type_name(&tsr->type, tsr->kind);
 	}
+	/* Handle page-relative global address calculation */
+	else if (src_tsr.kind == TSR_KIND_GLOBAL_ADDR) {
+		tsr->kind = src_tsr.kind;
+		tsr->addr = src_tsr.addr + reg_offset;
+		tsr->offset = 0;
+		tsr->ok = true;
+
+		pr_debug_dtp("add [%x] global %#x(reg%d) -> reg%d\n",
+			     insn_offset, reg_offset, sreg, dreg);
+	}
 	/* Or try another register if any */
 	else if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2) {
 		sreg = src->reg2;
@@ -656,8 +700,37 @@ static void update_add_insn_state(struct type_state *state,
 	}
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
+	/* Partial page-relative address, finalized in next 'add/ldr' */
+	tsr->addr = dl->ops.source.addr;
+	tsr->offset = 0;
+	tsr->ok = true;
+
+	pr_debug_dtp("adrp [%x] global addr=%#"PRIx64" -> reg%d\n",
+		     insn_offset, tsr->addr, dreg);
+}
+
 static void update_insn_state_arm64(struct type_state *state,
-				    struct data_loc_info *dloc, Dwarf_Die *cu_die __maybe_unused,
+				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
 {
 	struct annotated_insn_loc loc;
@@ -673,6 +746,7 @@ static void update_insn_state_arm64(struct type_state *state,
 	 * the destination register itself to prevent incorrect type propagation.
 	 */
 	if (has_reg_type(state, dst->reg1) &&
+	    strcmp(dl->ins.name, "adrp") &&
 	    strcmp(dl->ins.name, "add") && strcmp(dl->ins.name, "mov") &&
 	    strncmp(dl->ins.name, "ld", 2) && strncmp(dl->ins.name, "st", 2)) {
 		pr_debug_dtp("%s [%x] invalidate reg%d\n",
@@ -681,6 +755,11 @@ static void update_insn_state_arm64(struct type_state *state,
 		return;
 	}
 
+	if (!strcmp(dl->ins.name, "adrp")) {
+		update_adrp_insn_state(state, dl, dst);
+		return;
+	}
+
 	if (!strcmp(dl->ins.name, "add")) {
 		update_add_insn_state(state, dl, src, dst);
 		return;
@@ -694,7 +773,7 @@ static void update_insn_state_arm64(struct type_state *state,
 
 	/* Memory to register transfers */
 	if (!strncmp(dl->ins.name, "ld", 2)) {
-		update_load_insn_state(state, dloc, dl, src, dst);
+		update_load_insn_state(state, dloc, cu_die, dl, src, dst);
 		return;
 	}
 
diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index ef84b9593a39..9977ca079143 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -772,10 +772,12 @@ static void update_insn_state_x86(struct type_state *state,
 				 */
 				if (!stack->compound)
 					set_stack_state(stack, offset, tsr->kind,
-							&tsr->type, tsr->offset);
+							&tsr->type, tsr->offset,
+							tsr->addr);
 			} else {
 				findnew_stack_state(state, offset, tsr->kind,
-						    &tsr->type, tsr->offset);
+						    &tsr->type, tsr->offset,
+						    tsr->addr);
 			}
 
 			if (dst->reg1 == fbreg) {
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index c51b20a7af9b..6fa5cd373a46 100644
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
@@ -590,7 +593,7 @@ struct type_state_stack *find_stack_state(struct type_state *state,
 }
 
 void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
-			    Dwarf_Die *type_die, int ptr_offset)
+			    Dwarf_Die *type_die, int ptr_offset, u64 addr)
 {
 	int tag;
 	Dwarf_Word size;
@@ -607,6 +610,7 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 	stack->offset = offset;
 	stack->ptr_offset = ptr_offset;
 	stack->kind = kind;
+	stack->addr = addr;
 
 	if (kind == TSR_KIND_POINTER) {
 		stack->compound = false;
@@ -629,18 +633,18 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 struct type_state_stack *findnew_stack_state(struct type_state *state,
 						    int offset, u8 kind,
 						    Dwarf_Die *type_die,
-						    int ptr_offset)
+						    int ptr_offset, u64 addr)
 {
 	struct type_state_stack *stack = find_stack_state(state, offset);
 
 	if (stack) {
-		set_stack_state(stack, offset, kind, type_die, ptr_offset);
+		set_stack_state(stack, offset, kind, type_die, ptr_offset, addr);
 		return stack;
 	}
 
 	stack = malloc(sizeof(*stack));
 	if (stack) {
-		set_stack_state(stack, offset, kind, type_die, ptr_offset);
+		set_stack_state(stack, offset, kind, type_die, ptr_offset, addr);
 		list_add(&stack->list, &state->stack_vars);
 	}
 	return stack;
@@ -935,7 +939,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 				continue;
 
 			findnew_stack_state(state, offset, TSR_KIND_TYPE,
-					    &mem_die, /*ptr_offset=*/0);
+					    &mem_die, /*ptr_offset=*/0, /*addr=*/0);
 
 			if (var->reg == state->stack_reg) {
 				pr_debug_dtp("var [%"PRIx64"] %#x(reg%d)",
@@ -1278,6 +1282,25 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		if (dloc->op->offset < 0 && reg != state->stack_reg && reg != dloc->fbreg)
 			goto check_kernel;
 	}
+
+	if (state->regs[reg].kind == TSR_KIND_GLOBAL_ADDR) {
+		u64 var_addr = state->regs[reg].addr + dloc->op->offset;
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
index 453e13bbe3e2..a3e1ef7097f0 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -37,6 +37,7 @@ enum type_state_kind {
 	TSR_KIND_PERCPU_POINTER,
 	TSR_KIND_POINTER,
 	TSR_KIND_CANARY,
+	TSR_KIND_GLOBAL_ADDR,
 };
 
 /**
@@ -187,6 +188,7 @@ struct type_state_reg {
 	u64 lifetime_end;
 	u8 kind;
 	u8 copied_from;
+	u64 addr;
 };
 
 /* Type information in a stack location, dynamically allocated */
@@ -199,6 +201,7 @@ struct type_state_stack {
 	int size;
 	bool compound;
 	u8 kind;
+	u64 addr;
 };
 
 /*
@@ -253,9 +256,9 @@ bool has_reg_type(struct type_state *state, int reg);
 struct type_state_stack *findnew_stack_state(struct type_state *state,
 						int offset, u8 kind,
 						Dwarf_Die *type_die,
-						int ptr_offset);
+						int ptr_offset, u64 addr);
 void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
-				Dwarf_Die *type_die, int ptr_offset);
+				Dwarf_Die *type_die, int ptr_offset, u64 addr);
 struct type_state_stack *find_stack_state(struct type_state *state,
 						int offset);
 void invalidate_reg_state(struct type_state_reg *reg);
-- 
2.34.1

