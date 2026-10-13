Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7184D4FC8CC;
	Tue, 13 Oct 2026 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898123; cv=none; b=p2J68HumPLwMKy67PKVVQ/z7rhF2X/0TxejZ9v0f1qs+z4Jss4UHVD6V7Sn6cu3QDwT9o0hmHG0c103ANcXw8kuPjPG2Lg7YJzee1lqJd/ANtEkVLVOizXN8XGQzCQjffRH2a9rVpCUIc0luzGITzuJxNzQWoQDTlyqj3bWgpTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898123; c=relaxed/simple;
	bh=9XxmlHZ+Js+tB7wSGVZC1wJuimLlxvsQGez7dDEu7HA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bMtRJ+sT9irf0bNP3/FztCgvMBUVo08A7hLZU0KTk8FAUt01ZpYqjEoHQzF61vLClydQVdg4ydJxdS7c6qXy19DNuYsimuNuvzHM9PbeU4jDs85uJ0eH6AgpWL4guQc/7t2GdaYjs7VwVPFvRTUYh4YYkJO1qBMMhSRET8POGdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j3wB86WjMzYQv9t;
	Tue, 13 Oct 2026 21:27:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 33BE640561;
	Tue, 13 Oct 2026 21:28:36 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDnIvL3Mc5qfU4wAQ--.7133S5;
	Tue, 13 Oct 2026 21:28:35 +0800 (CST)
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
Subject: [PATCH v7 03/15] perf annotate-data: Add arch_get_reg_offset helper
Date: Tue, 13 Oct 2026 13:28:01 +0000
Message-Id: <f5639b97bb0aa19662cb1c230db8dc73fc00d986.1791629326.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1791629326.git.wutengda@huaweicloud.com>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnIvL3Mc5qfU4wAQ--.7133S5
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1xWw4DKr1DWr15WFW7Arb_yoWfWF4Dpa
	98GFyrWr47Wr4SgrsrXF98Xr9Y9wsrGr93Cryq9wnIyFyaqF18Ka1vyryYk3y8JrZYyw17
	J3W5tr47Xw47KaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I
	0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMI
	IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
	87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRNMKZ3UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Add a helper to compute the effective offset from a base register
for instruction operands. Currently handles arm64 addressing modes
including post-indexed, single-register, SIB-style indexed with
shift/extension, and constant-offset register pairs.

Fallback to instruction's raw offset for other architectures.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/annotate-data.c | 115 ++++++++++++++++++++++++++------
 tools/perf/util/annotate-data.h |   4 +-
 2 files changed, 98 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 398795ba3694..24d82739b2ec 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1241,6 +1241,74 @@ static void setup_stack_canary(struct data_loc_info *dloc)
 	}
 }
 
+int arch_get_reg_offset(const struct arch *arch, struct annotated_op_loc *op_loc,
+			int breg, struct type_state *state, bool apply_index,
+			int *offset)
+{
+	if (arch__is_arm64(arch)) {
+		int reg2;
+
+		/* Post-indexed addressing: offset is 0 when not applying index */
+		if (op_loc->addr_mode == PERF_AAM_POST_INDEX && !apply_index) {
+			*offset = 0;
+			return 0;
+		}
+
+		/* Single-register addressing: return the stored offset directly */
+		if (!op_loc->multi_regs) {
+			*offset = op_loc->offset;
+			return 0;
+		}
+
+		/*
+		 * SIB (Scale-Index-Base) style indexed addressing, e.g.:
+		 *   Array element load:  ldr  dst, [base, index, lsl #3]
+		 *   Array element load:  ldr  dst, [base, index, uxtw #3]
+		 *   Array address calc:  add  dst, base, index lsl #3
+		 *
+		 * The index reg only computes element offset without modifying
+		 * the underlying data type; the dst type is inherited from base.
+		 * Therefore, the base reg offset can be treated as 0.
+		 */
+		if (op_loc->extend_type || op_loc->shift_type) {
+			/* A memory reference implies breg is a pointer. */
+			if (op_loc->mem_ref) {
+				*offset = 0;
+				return 0;
+			}
+			/*
+			 * Otherwise, require breg to be a known pointer to avoid
+			 * treating integer arithmetic as indexed address calculation.
+			 */
+			if (has_reg_type(state, breg) && state->regs[breg].ok &&
+			    (state->regs[breg].kind == TSR_KIND_POINTER ||
+			     (state->regs[breg].kind == TSR_KIND_TYPE &&
+			      dwarf_tag(&state->regs[breg].type) == DW_TAG_pointer_type))) {
+				*offset = 0;
+				return 0;
+			}
+			return -1;
+		}
+
+		/*
+		 * For register-based addressing without shift/extension,
+		 * reg2 may be a constant offset. Use its value as the offset
+		 * from the base register.
+		 */
+		reg2 = op_loc->reg1 == breg ? op_loc->reg2 : op_loc->reg1;
+		if (has_reg_type(state, reg2) && state->regs[reg2].ok &&
+			state->regs[reg2].kind == TSR_KIND_CONST) {
+			*offset = (s64)state->regs[reg2].imm_value;
+			return 0;
+		}
+
+		return -1;
+	}
+
+	*offset = op_loc->offset;
+	return 0;
+}
+
 /*
  * It's at the target address, check if it has a matching type.
  * It returns PERF_TMR_BAIL_OUT when it looks up per-cpu variables which
@@ -1254,18 +1322,25 @@ static enum type_match_result check_matching_type(struct type_state *state,
 {
 	u32 insn_offset = dl->al.offset;
 	int reg = dloc->op->reg1;
-	int offset = dloc->op->offset;
-	const char *offset_sign = "";
+	int offset;
+	const char *offset_sign;
 	bool retry = true;
 
-	if (offset < 0) {
-		offset = -offset;
-		offset_sign = "-";
+again:
+	if (arch_get_reg_offset(dloc->arch, dloc->op, reg, state, false, &offset)) {
+		/*
+		 * Fall back to the instruction's offset. This prevents the
+		 * register type of the instruction from being completely lost.
+		 * Compared to dropping this type inference entirely, providing
+		 * a rough type hint is likely more useful.
+		 */
+		offset = dloc->op->offset;
 	}
 
-again:
+	offset_sign = offset < 0 ? "-" : "";
+
 	pr_debug_dtp("chk [%x] reg%d offset=%s%#x ok=%d kind=%d ",
-		     insn_offset, reg, offset_sign, offset,
+		     insn_offset, reg, offset_sign, abs(offset),
 		     state->regs[reg].ok, state->regs[reg].kind);
 
 	if (!state->regs[reg].ok)
@@ -1288,7 +1363,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		 */
 		ptr_type = die_get_pointer_type(&state->regs[reg].type, &ptr_die);
 		if (!ptr_type) {
-			if (dloc->op->offset < 0 && reg != state->stack_reg)
+			if (offset < 0 && reg != state->stack_reg)
 				goto check_kernel;
 
 			return PERF_TMR_NO_POINTER;
@@ -1298,7 +1373,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		if (__die_get_real_type(ptr_type, type_die) == NULL)
 			return PERF_TMR_NO_POINTER;
 
-		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
+		dloc->type_offset = offset + state->regs[reg].offset;
 
 		if (dwarf_tag(type_die) == DW_TAG_typedef)
 			die_get_real_type(type_die, &sized_type);
@@ -1322,7 +1397,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		 */
 		*type_die = state->regs[reg].type;
 
-		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
+		dloc->type_offset = offset + state->regs[reg].offset;
 
 		return check_type_offset(type_die, dloc->type_offset);
 	}
@@ -1336,7 +1411,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		 */
 		*type_die = state->regs[reg].type;
 
-		dloc->type_offset = dloc->op->offset;
+		dloc->type_offset = offset;
 
 		if (check_type_offset(type_die, dloc->type_offset) != PERF_TMR_OK)
 			return PERF_TMR_BAIL_OUT;
@@ -1358,7 +1433,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 	}
 
 	if (state->regs[reg].kind == TSR_KIND_PERCPU_BASE) {
-		u64 var_addr = dloc->op->offset;
+		u64 var_addr = (s64) offset;
 		int var_offset;
 
 		pr_debug_dtp("percpu var");
@@ -1385,7 +1460,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 
 	if (state->regs[reg].kind == TSR_KIND_CONST &&
 	    dso__kernel(map__dso(dloc->ms->map))) {
-		if (dloc->op->offset < 0 && reg != state->stack_reg && reg != dloc->fbreg)
+		if (offset < 0 && reg != state->stack_reg && reg != dloc->fbreg)
 			goto check_kernel;
 	}
 check_non_register:
@@ -1394,7 +1469,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 
 		pr_debug_dtp("%s", reg == dloc->fbreg ? "fbreg" : "stack");
 
-		stack = find_stack_state(state, dloc->type_offset);
+		stack = find_stack_state(state, offset);
 		if (stack == NULL) {
 			if (retry) {
 				pr_debug_dtp(" : retry\n");
@@ -1417,7 +1492,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 
 		*type_die = stack->type;
 		/* Update the type offset from the start of slot */
-		dloc->type_offset -= stack->offset;
+		dloc->type_offset = offset - stack->offset;
 
 		return PERF_TMR_OK;
 	}
@@ -1435,7 +1510,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		if (reg != fbreg)
 			return PERF_TMR_NO_TYPE;
 
-		stack = find_stack_state(state, dloc->type_offset - fboff);
+		stack = find_stack_state(state, offset - fboff);
 		if (stack == NULL) {
 			if (retry) {
 				pr_debug_dtp(" : retry\n");
@@ -1458,7 +1533,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 
 		*type_die = stack->type;
 		/* Update the type offset from the start of slot */
-		dloc->type_offset -= fboff + stack->offset;
+		dloc->type_offset = offset - fboff - stack->offset;
 
 		return PERF_TMR_OK;
 	}
@@ -1472,7 +1547,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		    arch__is_x86(dloc->arch)) {
 			pr_debug_dtp("this-cpu var");
 
-			addr = dloc->op->offset;
+			addr = (s64) offset;
 
 			if (get_global_var_type(cu_die, dloc, dloc->ip, addr,
 						&offset, type_die)) {
@@ -1483,8 +1558,8 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		}
 
 		/* Access to global variable like "-0x7dcf0500(,%rdx,8)" */
-		if (dloc->op->offset < 0 && reg != state->stack_reg) {
-			addr = (s64) dloc->op->offset;
+		if (offset < 0 && reg != state->stack_reg) {
+			addr = (s64) offset;
 
 			if (get_global_var_type(cu_die, dloc, dloc->ip, addr,
 						&offset, type_die)) {
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index d0dc056fb13a..453efdf6afa6 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -274,7 +274,9 @@ bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 bool get_global_var_info(struct data_loc_info *dloc, u64 addr,
 				const char **var_name, int *var_offset);
 void pr_debug_type_name(Dwarf_Die *die, enum type_state_kind kind);
-
+int arch_get_reg_offset(const struct arch *arch, struct annotated_op_loc *op_loc,
+			int breg, struct type_state *state, bool apply_index,
+			int *offset);
 #else /* HAVE_LIBDW_SUPPORT */
 
 static inline struct annotated_data_type *
-- 
2.34.1

