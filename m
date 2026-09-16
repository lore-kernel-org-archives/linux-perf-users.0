Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8243B19B6;
	Wed, 16 Sep 2026 01:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522227; cv=none; b=UlEYbEegvpkpNEAwGP422EcB0AI8SJjGQKazmekFmIyDNonKJXueptqePmu7EbImALzHCRFwXBSP4XLl6goyHNvBDLheln1sCajLbZx5z0wCdim8gXcRKFGm9gONlzOpe/HR4Zwcs51ady5fSpWj2cHcDxs9M6z3KTQGfwF3QR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522227; c=relaxed/simple;
	bh=ctMIgjR5Un14E+eIFJElBQe/il1/i+7Wb6QgNq/U6/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EZ9yusimYCIRLZdoCPa/WrtsJb+4fk/yWhF2d+psge8XwIHJlh8of7pGX7RR6HH+jdWbuceBEuhtB3SUwiwJK3PYnAt+GOV8o+qsSakYCzvW0PpSHeEbNnFUPDEvKoV6ojurdyppXwTD+Pj7YmV+Hy4GGkjMNCAILXKcI3PHa4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hl1XV0zv3zYQtqt;
	Wed, 16 Sep 2026 09:30:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 448C340579;
	Wed, 16 Sep 2026 09:30:06 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAn+CoH8alqUcjbAQ--.36458S16;
	Wed, 16 Sep 2026 09:30:05 +0800 (CST)
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
Subject: [PATCH v6 14/26] perf annotate-data: Add arch_get_reg_offset helper
Date: Wed, 16 Sep 2026 01:29:28 +0000
Message-Id: <ea1159a887a2f756d64097651f9ac87904968bec.1789521520.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAn+CoH8alqUcjbAQ--.36458S16
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1rZryUAF1fJw4rJFy3XFb_yoWfWrWkpa
	98GFyfGr47Wr4SgrsrXF98Xr9Y9ws7Gr93Cryq93sIyFyaqr18Ka1vyryYk3yUJrZYyw17
	G3W5tr47Xw47GaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Add a helper to compute the effective offset from a base register
for instruction operands. Currently handles arm64 addressing modes
including post-indexed, single-register, SIB-style indexed with
shift/extension, and constant-offset register pairs.

Fallback to instruction's raw offset for other architectures.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/annotate-data.c | 115 ++++++++++++++++++++++++++------
 tools/perf/util/annotate-data.h |   4 +-
 2 files changed, 98 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 9196f54b7297..d9f0bfd3f0a7 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1122,6 +1122,74 @@ static void setup_stack_canary(struct data_loc_info *dloc)
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
+			/* Memory references use the breg as the address base. */
+			if (op_loc->mem_ref) {
+				*offset = 0;
+				return 0;
+			}
+			/*
+			 * Otherwise, require breg to be a known pointer type to
+			 * avoid treating integer operations as address calculations.
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
@@ -1136,18 +1204,25 @@ static enum type_match_result check_matching_type(struct type_state *state,
 	Dwarf_Word size;
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
@@ -1170,7 +1245,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		 */
 		ptr_type = die_get_pointer_type(&state->regs[reg].type, &ptr_die);
 		if (!ptr_type) {
-			if (dloc->op->offset < 0 && reg != state->stack_reg)
+			if (offset < 0 && reg != state->stack_reg)
 				goto check_kernel;
 
 			return PERF_TMR_NO_POINTER;
@@ -1180,7 +1255,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		if (__die_get_real_type(ptr_type, type_die) == NULL)
 			return PERF_TMR_NO_POINTER;
 
-		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
+		dloc->type_offset = offset + state->regs[reg].offset;
 
 		if (dwarf_tag(type_die) == DW_TAG_typedef)
 			die_get_real_type(type_die, &sized_type);
@@ -1209,7 +1284,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		 */
 		*type_die = state->regs[reg].type;
 
-		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
+		dloc->type_offset = offset + state->regs[reg].offset;
 
 		/* Get the size of the actual type */
 		if (dwarf_aggregate_size(type_die, &size) < 0 ||
@@ -1228,7 +1303,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		 */
 		*type_die = state->regs[reg].type;
 
-		dloc->type_offset = dloc->op->offset;
+		dloc->type_offset = offset;
 
 		/* Get the size of the actual type */
 		if (dwarf_aggregate_size(type_die, &size) < 0 ||
@@ -1252,7 +1327,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 	}
 
 	if (state->regs[reg].kind == TSR_KIND_PERCPU_BASE) {
-		u64 var_addr = dloc->op->offset;
+		u64 var_addr = (s64) offset;
 		int var_offset;
 
 		pr_debug_dtp("percpu var");
@@ -1279,7 +1354,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 
 	if (state->regs[reg].kind == TSR_KIND_CONST &&
 	    dso__kernel(map__dso(dloc->ms->map))) {
-		if (dloc->op->offset < 0 && reg != state->stack_reg && reg != dloc->fbreg)
+		if (offset < 0 && reg != state->stack_reg && reg != dloc->fbreg)
 			goto check_kernel;
 	}
 check_non_register:
@@ -1288,7 +1363,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 
 		pr_debug_dtp("%s", reg == dloc->fbreg ? "fbreg" : "stack");
 
-		stack = find_stack_state(state, dloc->type_offset);
+		stack = find_stack_state(state, offset);
 		if (stack == NULL) {
 			if (retry) {
 				pr_debug_dtp(" : retry\n");
@@ -1311,7 +1386,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 
 		*type_die = stack->type;
 		/* Update the type offset from the start of slot */
-		dloc->type_offset -= stack->offset;
+		dloc->type_offset = offset - stack->offset;
 
 		return PERF_TMR_OK;
 	}
@@ -1329,7 +1404,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		if (reg != fbreg)
 			return PERF_TMR_NO_TYPE;
 
-		stack = find_stack_state(state, dloc->type_offset - fboff);
+		stack = find_stack_state(state, offset - fboff);
 		if (stack == NULL) {
 			if (retry) {
 				pr_debug_dtp(" : retry\n");
@@ -1352,7 +1427,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 
 		*type_die = stack->type;
 		/* Update the type offset from the start of slot */
-		dloc->type_offset -= fboff + stack->offset;
+		dloc->type_offset = offset - fboff - stack->offset;
 
 		return PERF_TMR_OK;
 	}
@@ -1366,7 +1441,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		    arch__is_x86(dloc->arch)) {
 			pr_debug_dtp("this-cpu var");
 
-			addr = dloc->op->offset;
+			addr = (s64) offset;
 
 			if (get_global_var_type(cu_die, dloc, dloc->ip, addr,
 						&offset, type_die)) {
@@ -1377,8 +1452,8 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		}
 
 		/* Access to global variable like "-0x7dcf0500(,%rdx,8)" */
-		if (dloc->op->offset < 0 && reg != state->stack_reg) {
-			addr = (s64) dloc->op->offset;
+		if (offset < 0 && reg != state->stack_reg) {
+			addr = (s64) offset;
 
 			if (get_global_var_type(cu_die, dloc, dloc->ip, addr,
 						&offset, type_die)) {
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 2af70e3cf73f..68e3feda2eda 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -265,7 +265,9 @@ bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
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

