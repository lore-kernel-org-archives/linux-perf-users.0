Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280B139C013;
	Fri,  3 Apr 2026 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209744; cv=none; b=dAbx+0ZfE0k20b80GIDOaGA1eyCJ+nME8E4da/b2/uHx4MkX9TITxA+HMFlFALuOy1sKxsVjpGCvOfa8tig5aygHfY9pVL2bVn7X6AhihtfGFMEClpJmNzW1omFxPPOEpvjYrrh8KxzcIT8u2951iZyekALOV3UOzDWqYNUpclQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209744; c=relaxed/simple;
	bh=HwH4B5poXc31LIeDu685sY3ZXGe2zc0035ou0YyOWAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RpsND9Jb3EwJEFLcfE5AwqvbomRSuJCCH32IxS9V3P8vPofv2zrL/L+XIXRYAspOppkvT7ftF5G9Z4RCU7e10rni7xvo7giltzUZ8C8Hos7FR9CIYVP2YXdESi4bxU+Lo7D5CY3jc146NvPrI4drKUghXcNjiApAVfQedTBX1EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fnDRd55qwzKHMYF;
	Fri,  3 Apr 2026 17:47:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4E2FB40592;
	Fri,  3 Apr 2026 17:48:50 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with SMTP id _Ch0CgAnB1TwjM9p8K_UDA--.49742S16;
	Fri, 03 Apr 2026 17:48:50 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v2 14/16] perf annotate-arm64: Support 'adrp' instruction to track global variables
Date: Fri,  3 Apr 2026 09:47:58 +0000
Message-Id: <20260403094800.1418825-15-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260403094800.1418825-1-wutengda@huaweicloud.com>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAnB1TwjM9p8K_UDA--.49742S16
X-Coremail-Antispam: 1UD129KBjvJXoW3CrW5KF15KF4xCr4fAF1xGrg_yoWDuw1Up3
	4DGFy7Wa17Wr4Igrs3XFWUXryfWwsagFyjkryqvr1SyFyxtr1fGa4vyFWaqa18JrykAw17
	Jw1DKr4DXw47KaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRGMKuUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state() for arm64 to track global variable types
calculated via PC-relative addressing.

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
  ffff80008032e078:  ldr   x0, [x24]  // PMU sample

Before this commit, x24 was unknown, leading to no type information:

  chk [70] reg24 offset=0 ok=0 kind=0 cfa : no type information
  final result: no type information

After this commit, the tracker correctly follows the adrp/add flow:

  adrp [40] global addr=ffff80008202f000 -> reg24
  add [48] global addr=ffff80008202fd40 -> reg24
  chk [70] reg24 offset=0 ok=1 kind=7 global addr : Good!
  final result: type='struct folio*'

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 64 ++++++++++++++++++-
 tools/perf/util/annotate-arch/annotate-x86.c  |  6 +-
 tools/perf/util/annotate-data.c               | 32 ++++++++--
 tools/perf/util/annotate-data.h               |  7 +-
 4 files changed, 97 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index d2557b9d6909..6b954bbfaf8d 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -290,7 +290,7 @@ static void adjust_reg_index_state(struct type_state *state, int reg,
 }
 
 static void update_insn_state_arm64(struct type_state *state,
-				    struct data_loc_info *dloc, Dwarf_Die * cu_die __maybe_unused,
+				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
 {
 	struct annotated_insn_loc loc;
@@ -309,6 +309,23 @@ static void update_insn_state_arm64(struct type_state *state,
 	sreg = src->reg1;
 	dreg = dst->reg1;
 
+	if (!strcmp(dl->ins.name, "adrp")) {
+		if (!has_reg_type(state, sreg) || !dl->ops.target.addr)
+			return;
+
+		tsr = &state->regs[sreg];
+		tsr->copied_from = -1;
+		tsr->kind = TSR_KIND_GLOBAL_ADDR;
+		/* Partial page-relative address, finalized in next 'add/ldr' */
+		tsr->addr = dl->ops.target.addr;
+		tsr->offset = 0;
+		tsr->ok = true;
+
+		pr_debug_dtp("adrp [%x] global addr=%"PRIx64" -> reg%d\n",
+			     insn_offset, tsr->addr, sreg);
+		return;
+	}
+
 	if (!strcmp(dl->ins.name, "add")) {
 		struct type_state_reg dst_tsr;
 
@@ -342,6 +359,7 @@ static void update_insn_state_arm64(struct type_state *state,
 			tsr->type = dst_tsr.type;
 			tsr->kind = dst_tsr.kind;
 			tsr->offset = offset;
+			tsr->addr = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("add [%x] address of %s%#x(reg%d) -> reg%d",
@@ -350,6 +368,18 @@ static void update_insn_state_arm64(struct type_state *state,
 
 			pr_debug_type_name(&tsr->type, tsr->kind);
 		}
+
+		/* Handle PC-relative global address calculation (adrp/add pair) */
+		if (dst_tsr.kind == TSR_KIND_GLOBAL_ADDR) {
+			tsr->kind = dst_tsr.kind;
+			tsr->addr = dst_tsr.addr + dst->offset;
+			tsr->offset = 0;
+			tsr->ok = true;
+
+			pr_debug_dtp("add [%x] global addr=%"PRIx64" -> reg%d\n",
+				     insn_offset, tsr->addr, sreg);
+		}
+
 		return;
 	}
 
@@ -370,6 +400,7 @@ static void update_insn_state_arm64(struct type_state *state,
 		tsr->type = state->regs[dreg].type;
 		tsr->kind = state->regs[dreg].kind;
 		tsr->offset = state->regs[dreg].offset;
+		tsr->addr = state->regs[dreg].addr;
 		tsr->ok = true;
 
 		if (tsr->kind == TSR_KIND_TYPE || tsr->kind == TSR_KIND_POINTER)
@@ -444,6 +475,7 @@ static void update_insn_state_arm64(struct type_state *state,
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
 			tsr->offset = 0;
+			tsr->addr = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("ldr [%x] %#x(reg%d) -> reg%d",
@@ -451,6 +483,30 @@ static void update_insn_state_arm64(struct type_state *state,
 			pr_debug_type_name(&tsr->type, tsr->kind);
 
 			adjust_reg_index_state(state, dreg, dst, "ldr", insn_offset);
+			return;
+		}
+
+		/* Or check if it's a global variable */
+		if (dst_tsr.kind == TSR_KIND_GLOBAL_ADDR) {
+			u64 ip = dloc->ms->sym->start + dl->al.offset;
+			u64 addr = dst_tsr.addr + dst->offset;
+			int offset;
+
+			if (!get_global_var_type(cu_die, dloc, ip, addr, &offset,
+						 &type_die) ||
+			    !die_get_member_type(&type_die, offset, &type_die)) {
+				tsr->ok = false;
+				return;
+			}
+
+			tsr->type = type_die;
+			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = offset;
+			tsr->addr = addr;
+			tsr->ok = true;
+			pr_debug_dtp("ldr [%x] global (%"PRIx64") -> reg%d",
+				     insn_offset, addr, sreg);
+			pr_debug_type_name(&tsr->type, tsr->kind);
 		}
 		return;
 	}
@@ -472,10 +528,12 @@ static void update_insn_state_arm64(struct type_state *state,
 			if (stack) {
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
 
 			pr_debug_dtp("str [%x] reg%d -> -%#x(stack)",
diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index c63ca3250b95..24adfbef8b76 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -780,10 +780,12 @@ static void update_insn_state_x86(struct type_state *state,
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
index fd6416d43a2e..b75d50b2c46f 100644
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
@@ -577,7 +580,7 @@ struct type_state_stack *find_stack_state(struct type_state *state,
 }
 
 void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
-			    Dwarf_Die *type_die, int ptr_offset)
+			    Dwarf_Die *type_die, int ptr_offset, u64 addr)
 {
 	int tag;
 	Dwarf_Word size;
@@ -594,6 +597,7 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 	stack->offset = offset;
 	stack->ptr_offset = ptr_offset;
 	stack->kind = kind;
+	stack->addr = addr;
 
 	if (kind == TSR_KIND_POINTER) {
 		stack->compound = false;
@@ -616,18 +620,18 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
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
@@ -913,7 +917,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 				continue;
 
 			findnew_stack_state(state, offset, TSR_KIND_TYPE,
-					    &mem_die, /*ptr_offset=*/0);
+					    &mem_die, /*ptr_offset=*/0, /*addr=*/0);
 
 			if (var->reg == state->stack_reg) {
 				pr_debug_dtp("var [%"PRIx64"] %#x(reg%d)",
@@ -1256,6 +1260,24 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		if (dloc->op->offset < 0 && reg != state->stack_reg && reg != dloc->fbreg)
 			goto check_kernel;
 	}
+
+	if (state->regs[reg].kind == TSR_KIND_GLOBAL_ADDR) {
+		int var_offset;
+
+		pr_debug_dtp("global addr");
+
+		/*
+		 * The register holds the address of a global variable.  Try to
+		 * find the variable by the address and get its type.
+		 */
+		if (get_global_var_type(cu_die, dloc, dloc->ip, state->regs[reg].addr,
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
index c26130744260..bae15e1d6db8 100644
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
 bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
-- 
2.34.1

