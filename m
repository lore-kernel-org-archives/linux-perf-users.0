Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB99370D70;
	Wed,  1 Jul 2026 03:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878101; cv=none; b=L/DKZyeFPbkIux/jguB6RPaTTUGbjk5dFSkMsM+WOSTVGDvlXZDE6Ed6lcFCfyWeRX06ewtIRn6fYpcQl8wJfkRqFS9McCbHVzIHTGKQqZEOhjRdfQ7sC5ZkGZvgXZSrKMxts7g4GzJB0iLE/JkZLfb2WFm9l9exseOPyrTLkdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878101; c=relaxed/simple;
	bh=tizzVsgy1z8TTVa9ljAt8sEDrxbVLKFdbc/IvOfkhTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VAv7H9TFIBaaEklyndsiJM8U1mpgLllNvcUSCSfml99j1qjD4dAlWamZR8OYuFWjzUmBaD/EK+CuoqZT0/hAczqu2ygBwaj2GlJxVSsJuJRNT+k1t94726gDJUw0tCwoq7Pq9lSB2s6qE/+2BsaNwklRKU1JQryWwSz8E17dpVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gqmNs4HWtzKHMXJ;
	Wed,  1 Jul 2026 11:54:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A8FEB40594;
	Wed,  1 Jul 2026 11:54:46 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBXiyWAj0RqCne9AQ--.26189S20;
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
Subject: [PATCH v3 18/21] perf annotate-arm64: Support 'add' instruction tracking
Date: Wed,  1 Jul 2026 03:53:52 +0000
Message-Id: <20260701035355.752944-19-wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgBXiyWAj0RqCne9AQ--.26189S20
X-Coremail-Antispam: 1UD129KBjvJXoWxtF15GryfZFyUtr48Cw47XFb_yoW7WF4Upa
	s0k34UWrs7tr42grs3XrWfXr9akws7Gr1jkryqqwnIyF9Iyr1rKa9xKFWayay5Gryfuw17
	tw4DKrZ8Zw4I9aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7
	CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc7CjxVAKzI0EY4vE52x082I5MxAI
	w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
	6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRNg4S3UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state() for arm64 to track 'add' instructions for
structure member address calculation, which commonly appear as:

  add  dreg, base, #offset
  add  dreg, base, reg2     (reg2 holds a constant)

For such instructions, determine the final offset value from either the
immediate or the constant in reg2. If the base register contains a
pointer or structure type, compute the resulting offset and invoke
die_get_member_type() to verify it corresponds to a valid member within
that type. On success, update the destination register's type state with
the new offset while retaining the base type information.

A real-world example is shown below:

  ffff80008001c9a8 <flush_ptrace_hw_breakpoint>:
  ffff80008001c9c4:  add  x19, x0, #0xeb8   // x0 (task_struct*) + 0xeb8 -> x19
* ffff80008001c9d0:  ldr  x0, [x19]

Before this commit, the type flow broke at the 'add' instruction,
leaving the subsequent load with no type information:

  chk [28] reg19 offset=0 ok=0 kind=0 cfa : no type information
  final result: no type information

After this commit, the tracker correctly follows the member address
calculation:

  var [0] reg0 offset 0 type='struct task_struct*'
  add [1c] address of 0xeb8(reg0) -> reg19 type='struct task_struct*'
  chk [28] reg19 offset=0 ok=1 kind=1 (struct task_struct*) : Good!
  found by insn track: 0(reg19) type-offset=0xeb8
  final result: type='struct task_struct'

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 91 ++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index be07a85057c8..1fed18811719 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -572,6 +572,90 @@ static void update_mov_insn_state(struct type_state *state,
 	pr_debug_type_name(&tsr->type, tsr->kind);
 }
 
+static void update_add_insn_state(struct type_state *state,
+				  struct disasm_line *dl,
+				  struct annotated_op_loc *src,
+				  struct annotated_op_loc *dst)
+{
+	struct type_state_reg *tsr;
+	struct type_state_reg src_tsr;
+	Dwarf_Die type_die;
+	u32 insn_offset = dl->al.offset;
+	int sreg = src->reg1;
+	int dreg = dst->reg1;
+	int reg_offset;
+
+	if (!has_reg_type(state, dreg))
+		return;
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
+
+	/*
+	 * Handle 'add' instructions of the form:
+	 *   add  dreg, base, #offset     (immediate offset)
+	 *   add  dreg, base, reg2        (reg2 holds a constant)
+	 *
+	 * For case 2, retrieve the constant value from reg2
+	 * and use it as the offset.
+	 */
+	reg_offset = src->offset;
+	if (src->multi_regs) {
+		int reg2 = (sreg == src->reg1) ? src->reg2 : src->reg1;
+
+		if (has_reg_type(state, reg2) && state->regs[reg2].ok &&
+		    state->regs[reg2].kind == TSR_KIND_CONST)
+			reg_offset = state->regs[reg2].imm_value;
+	}
+
+	/* Handle calculation of a register holding a typed pointer */
+	if (src_tsr.kind == TSR_KIND_POINTER ||
+	    (src_tsr.kind == TSR_KIND_TYPE &&
+	     dwarf_tag(&src_tsr.type) == DW_TAG_pointer_type)) {
+		s32 offset;
+
+		if (src_tsr.kind == TSR_KIND_TYPE &&
+		    __die_get_real_type(&src_tsr.type, &type_die) == NULL) {
+			invalidate_reg_state(tsr);
+			return;
+		}
+
+		if (src_tsr.kind == TSR_KIND_POINTER)
+			type_die = src_tsr.type;
+
+		/* Check if the target type has a member at the new offset */
+		offset = reg_offset + src_tsr.offset;
+		if (die_get_member_type(&type_die, offset, &type_die) == NULL) {
+			invalidate_reg_state(tsr);
+			return;
+		}
+
+		tsr->type = src_tsr.type;
+		tsr->kind = src_tsr.kind;
+		tsr->offset = offset;
+		tsr->ok = src_tsr.ok;
+
+		pr_debug_dtp("add [%x] address of %s%#x(reg%d) -> reg%d",
+			     insn_offset, reg_offset < 0 ? "-" : "",
+			     abs(reg_offset), sreg, dreg);
+
+		pr_debug_type_name(&tsr->type, tsr->kind);
+	}
+	/* Or try another register if any */
+	else if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2) {
+		sreg = src->reg2;
+		goto retry;
+	}
+}
+
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die __maybe_unused,
 				    struct disasm_line *dl)
@@ -589,7 +673,7 @@ static void update_insn_state_arm64(struct type_state *state,
 	 * the destination register itself to prevent incorrect type propagation.
 	 */
 	if (has_reg_type(state, dst->reg1) &&
-	    strcmp(dl->ins.name, "mov") &&
+	    strcmp(dl->ins.name, "add") && strcmp(dl->ins.name, "mov") &&
 	    strncmp(dl->ins.name, "ld", 2) && strncmp(dl->ins.name, "st", 2)) {
 		pr_debug_dtp("%s [%x] invalidate reg%d\n",
 			     dl->ins.name, insn_offset, dst->reg1);
@@ -597,6 +681,11 @@ static void update_insn_state_arm64(struct type_state *state,
 		return;
 	}
 
+	if (!strcmp(dl->ins.name, "add")) {
+		update_add_insn_state(state, dl, src, dst);
+		return;
+	}
+
 	/* Register to register or imm value to register transfers */
 	if (!strcmp(dl->ins.name, "mov")) {
 		update_mov_insn_state(state, dl, src, dst);
-- 
2.34.1

