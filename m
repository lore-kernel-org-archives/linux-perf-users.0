Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1E3D0923;
	Sat,  8 Aug 2026 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786191875; cv=none; b=l5lodDsNeenvqTUCN/aYEBWIc91HBOv4LTgxcgvXpRepptu1wQJB6huW2QckCuDn3paHp7yH6oeN+rhhunk4s9xesdwQJzOXk4lrnbWBkrKo+dWQcx2D26fBWYechlVkBLdUGKtwVCjsWI6rq4BvJc3E2n8pT4RHVd/TQQIPlh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786191875; c=relaxed/simple;
	bh=7u4xceCCsVqH8RuaYm3grHt25MM1DGb/u9ow3E5maFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DpzMVDrKp94jaTkNXWz3HtiLvOdmhBn/QDzUjMO1eRYDkxMGqqnsuG1SLEXnknJFqtiwwd4JMI1bwNefsTK/iZwWnFaO9l8LbUeLPVYewO6a7Xp7LSy+NiZT39u8jgESX/U2jcfIQwSZpH5HzA+4aF4q1Wt/Iq1u7kC5hOHZ45U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hHKvD2N58zKHNHb;
	Sat,  8 Aug 2026 20:24:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 705F6409C0;
	Sat,  8 Aug 2026 20:24:19 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB34YjkH3dqbrhMBg--.41805S22;
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
Subject: [PATCH v4 20/23] perf annotate-arm64: Support 'add' instruction tracking
Date: Sat,  8 Aug 2026 12:23:57 +0000
Message-Id: <20260808122400.2961238-21-wutengda@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgB34YjkH3dqbrhMBg--.41805S22
X-Coremail-Antispam: 1UD129KBjvJXoW3XF1rAr4ftr43JFWxGF48WFg_yoW7Xryfpa
	9I934UGrsrtrsFgFs3trWfXr9akrsrJF1jkr90qwnIyFyayr1rKa9xKrW2yFW5Gryfur17
	Jw4DKrZ8Xw429aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Extend update_insn_state() for arm64 to track 'add' instructions for
structure member address calculation, which commonly appear as:

  add  dreg, base, #offset
  add  dreg, base, reg2     (reg2 holds a constant)

Unlike x86, the arm64 'add' instruction has an extra base register among
its source operands. Therefore, in terms of propagating the data type,
it is essentially performing a 'mov', except that before the 'mov', it
first needs to be updated by adding the offset or reg2.

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
 .../perf/util/annotate-arch/annotate-arm64.c  | 87 ++++++++++++++++++-
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 7b780bad8c07..eaeb4433fc3a 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -688,6 +688,87 @@ static void update_mov_insn_state(struct type_state *state,
 	pr_debug_type_name(&tsr->type, tsr->kind);
 }
 
+static void update_add_insn_state(struct type_state *state,
+				  struct disasm_line *dl,
+				  struct annotated_op_loc *src,
+				  struct annotated_op_loc *dst)
+{
+	struct type_state_reg *tsr;
+	struct type_state_reg src_tsr;
+	u32 insn_offset = dl->al.offset;
+	int sreg = src->reg1;
+	int dreg = dst->reg1;
+	u64 imm_value;
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
+	imm_value = src->offset;
+	if (src->multi_regs) {
+		int reg2 = (sreg == src->reg1) ? src->reg2 : src->reg1;
+
+		if (!has_reg_type(state, reg2) || !state->regs[reg2].ok) {
+			/* Unable to resolve type for dst, bail out */
+			invalidate_reg_state(tsr);
+			return;
+		}
+		if (state->regs[reg2].kind == TSR_KIND_CONST)
+			imm_value = state->regs[reg2].imm_value;
+	}
+
+	if (src_tsr.kind == TSR_KIND_CONST) {
+		tsr->kind = src_tsr.kind;
+		tsr->imm_value = src_tsr.imm_value + imm_value;
+		tsr->offset = 0;
+		tsr->ok = src_tsr.ok;
+
+		pr_debug_dtp("add [%x] imm %#"PRIx64"(reg%d) -> reg%d\n",
+			     insn_offset, imm_value, sreg, dreg);
+		return;
+	}
+
+	if (src_tsr.kind == TSR_KIND_POINTER ||
+	    (src_tsr.kind == TSR_KIND_TYPE &&
+	     dwarf_tag(&src_tsr.type) == DW_TAG_pointer_type)) {
+		tsr->type = src_tsr.type;
+		tsr->kind = src_tsr.kind;
+		tsr->imm_value = src_tsr.imm_value;
+		tsr->offset = src_tsr.offset + imm_value;
+		tsr->ok = src_tsr.ok;
+
+		pr_debug_dtp("add [%x] address of %#"PRIx64"(reg%d) -> reg%d",
+			     insn_offset, imm_value, sreg, dreg);
+		pr_debug_type_name(&tsr->type, tsr->kind);
+		return;
+	}
+
+	/* Try another register if any */
+	if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2) {
+		sreg = src->reg2;
+		goto retry;
+	}
+	invalidate_reg_state(tsr);
+}
+
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
@@ -750,7 +831,7 @@ static void update_insn_state_arm64(struct type_state *state,
 	 * prevent stale type info from propagating to subsequent instructions.
 	 */
 	if (has_reg_type(state, dst->reg1) &&
-	    strcmp(dl->ins.name, "mov") &&
+	    strcmp(dl->ins.name, "add") && strcmp(dl->ins.name, "mov") &&
 	    strncmp(dl->ins.name, "ld", 2) && strncmp(dl->ins.name, "st", 2)) {
 		pr_debug_dtp("%s [%x] invalidate reg%d",
 			     dl->ins.name, insn_offset, dst->reg1);
@@ -763,8 +844,10 @@ static void update_insn_state_arm64(struct type_state *state,
 		return;
 	}
 
+	if (!strcmp(dl->ins.name, "add"))
+		update_add_insn_state(state, dl, src, dst);
 	/* Register to register or imm value to register transfers */
-	if (!strcmp(dl->ins.name, "mov"))
+	else if (!strcmp(dl->ins.name, "mov"))
 		update_mov_insn_state(state, dl, src, dst);
 	/* Memory to register transfers */
 	else if (!strncmp(dl->ins.name, "ld", 2))
-- 
2.34.1

