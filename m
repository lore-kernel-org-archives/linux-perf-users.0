Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118F05476D7;
	Tue,  8 Sep 2026 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872757; cv=none; b=a3/dFZTXRj9YnDNS3uY1lGciLgUHaM24n+xFBJ9Wq7bvSs+UmQFUeey+ltwrM/cKJLvY88t/Fd0nTTVFpe+5rJkXJQ50FCMFnyXBv+xOiXgi+mjlUUOi+xyr2pOxSMoIXPHGYHFHwzW/AWRl8DTvXzRDhnPKnYdw/1sC5wxt+ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872757; c=relaxed/simple;
	bh=sjRLf1ZvmsodHnm3CvP0VHigBoL+XRcVKM3dKO7fQ58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DlD3sZGH3gk6wyFFSrSB/jH+U6LvcAvIhydzxKmyZVaEPEeBnr0mGawPNJlmDDdG6060P0iso6/PX1pzJF1LYV4nszHSAKPoLJxCwRaIAqsLN7Fu/YZw+ZJhC0t3XKxamnlfix1Dwvv9vV4Fl/BorY/73zfgcQYhavuW4D/zJxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfPKw06pmzYQw85;
	Tue,  8 Sep 2026 21:04:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7EC864057A;
	Tue,  8 Sep 2026 21:05:43 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDHLUoeCKBqX3XjBA--.22748S16;
	Tue, 08 Sep 2026 21:05:43 +0800 (CST)
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
Subject: [PATCH v5 14/26] perf annotate-data: Add arch_get_reg_offset helper
Date: Tue,  8 Sep 2026 13:05:17 +0000
Message-Id: <e2d2dc36b2d8f600b339cf66880b10e611dbf9ab.1788872630.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgDHLUoeCKBqX3XjBA--.22748S16
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1rZryUAryftry5tFyUtrb_yoW3XFyrpa
	95GFyrGr43Xr43WrsrXrZ8Xr9Y9wsrGF9xCryq934ayryaqr18Ka1vyryYk3yUJrZYyr17
	G3Z8tr47XwsrGaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
	AGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26rWY6Fy7MxkF7I0Ew4C2
	6cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa
	7xRxnoUUUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Add a helper to compute the effective offset from a base register
for instruction operands. Currently handles arm64 addressing modes
including post-indexed, single-register, SIB-style indexed with
shift/extension, and constant-offset register pairs.

Fallback to instruction's raw offset for other architectures.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/annotate-data.c | 106 +++++++++++++++++++++++++++-----
 tools/perf/util/annotate-data.h |   4 +-
 2 files changed, 94 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index c51b20a7af9b..754c0efe2077 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1118,6 +1118,74 @@ static void setup_stack_canary(struct data_loc_info *dloc)
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
@@ -1132,18 +1200,26 @@ static enum type_match_result check_matching_type(struct type_state *state,
 	Dwarf_Word size;
 	u32 insn_offset = dl->al.offset;
 	int reg = dloc->op->reg1;
-	int offset = dloc->op->offset;
+	int offset;
 	const char *offset_sign = "";
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
+	if (offset < 0)
+		offset_sign = "-";
+
 	pr_debug_dtp("chk [%x] reg%d offset=%s%#x ok=%d kind=%d ",
-		     insn_offset, reg, offset_sign, offset,
+		     insn_offset, reg, offset_sign, abs(offset),
 		     state->regs[reg].ok, state->regs[reg].kind);
 
 	if (!state->regs[reg].ok)
@@ -1166,7 +1242,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		 */
 		ptr_type = die_get_pointer_type(&state->regs[reg].type, &ptr_die);
 		if (!ptr_type) {
-			if (dloc->op->offset < 0 && reg != state->stack_reg)
+			if (offset < 0 && reg != state->stack_reg)
 				goto check_kernel;
 
 			return PERF_TMR_NO_POINTER;
@@ -1176,7 +1252,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		if (__die_get_real_type(ptr_type, type_die) == NULL)
 			return PERF_TMR_NO_POINTER;
 
-		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
+		dloc->type_offset = offset + state->regs[reg].offset;
 
 		if (dwarf_tag(type_die) == DW_TAG_typedef)
 			die_get_real_type(type_die, &sized_type);
@@ -1205,7 +1281,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		 */
 		*type_die = state->regs[reg].type;
 
-		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
+		dloc->type_offset = offset + state->regs[reg].offset;
 
 		/* Get the size of the actual type */
 		if (dwarf_aggregate_size(type_die, &size) < 0 ||
@@ -1224,7 +1300,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		 */
 		*type_die = state->regs[reg].type;
 
-		dloc->type_offset = dloc->op->offset;
+		dloc->type_offset = offset;
 
 		/* Get the size of the actual type */
 		if (dwarf_aggregate_size(type_die, &size) < 0 ||
@@ -1248,7 +1324,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 	}
 
 	if (state->regs[reg].kind == TSR_KIND_PERCPU_BASE) {
-		u64 var_addr = dloc->op->offset;
+		u64 var_addr = (s64) offset;
 		int var_offset;
 
 		pr_debug_dtp("percpu var");
@@ -1275,7 +1351,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 
 	if (state->regs[reg].kind == TSR_KIND_CONST &&
 	    dso__kernel(map__dso(dloc->ms->map))) {
-		if (dloc->op->offset < 0 && reg != state->stack_reg && reg != dloc->fbreg)
+		if (offset < 0 && reg != state->stack_reg && reg != dloc->fbreg)
 			goto check_kernel;
 	}
 check_non_register:
@@ -1362,7 +1438,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		    arch__is_x86(dloc->arch)) {
 			pr_debug_dtp("this-cpu var");
 
-			addr = dloc->op->offset;
+			addr = (s64) offset;
 
 			if (get_global_var_type(cu_die, dloc, dloc->ip, addr,
 						&offset, type_die)) {
@@ -1373,8 +1449,8 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		}
 
 		/* Access to global variable like "-0x7dcf0500(,%rdx,8)" */
-		if (dloc->op->offset < 0 && reg != state->stack_reg) {
-			addr = (s64) dloc->op->offset;
+		if (offset < 0 && reg != state->stack_reg) {
+			addr = (s64) offset;
 
 			if (get_global_var_type(cu_die, dloc, dloc->ip, addr,
 						&offset, type_die)) {
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 453e13bbe3e2..e6ca47e25e04 100644
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

