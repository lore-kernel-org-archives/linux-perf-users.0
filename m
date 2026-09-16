Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8536C3AF644;
	Wed, 16 Sep 2026 01:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522224; cv=none; b=b0seNUf91n2vHL68tlqmor+yaHgs38Zk4sm9mVB9vD6wiw/TKSXqgW4ilVPqlfgJXSlIhFWHOt6IsMjgpoFE8Qoo7S0/JmzRvm9F2LCrSc1yShoiBWplikcUTIEhPdRf3CYF8Z8H4GRPuFR481AhtuKpi2gT0GKilgtTwskoLo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522224; c=relaxed/simple;
	bh=rcv7nH7QlrFL27nFmZD6Zu4P0jLt/ggDFLp8hwCSTcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u4FIalpHu6d0SK3B16DKTiAC6nlcWcjlukVK2rjuIVFEUPAefgUIXRStb3KlUV4FxPyFu8nINJM+qBdvbrnnsPRQea15FiI6jYGqB++++Wwv8WEU8KKlnmImrp4DGC4frCvNsTkYuTleYpCghk1VNpHtG2pXroXWx67rVw9pCDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hl1XK3RxmzKHMWN;
	Wed, 16 Sep 2026 09:29:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1EEF140561;
	Wed, 16 Sep 2026 09:30:07 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAn+CoH8alqUcjbAQ--.36458S25;
	Wed, 16 Sep 2026 09:30:06 +0800 (CST)
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
Subject: [PATCH v6 23/26] perf annotate-arm64: Support 'add' instruction tracking
Date: Wed, 16 Sep 2026 01:29:37 +0000
Message-Id: <8bee20cb7054ce8d0b1cfa064a4d62d0a1b29d42.1789521520.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAn+CoH8alqUcjbAQ--.36458S25
X-Coremail-Antispam: 1UD129KBjvJXoWxXw15Xw1fJw1UJrWkurWruFg_yoWrtFW8pF
	Zru34UGw4Iyr4agan3JFWfXr9a9wsrGF1UCr9IqwsayFW3trn5Ka93KrWavFW5Gr93Cw13
	Jw4DKFs3Xw429aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YV
	CY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4UJV
	W0owCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7sRNg4S3UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state_arm64() to track 'add' instructions for
structure member address calculation.

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
 .../perf/util/annotate-arch/annotate-arm64.c  | 74 ++++++++++++++++++-
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 3358562893b1..68510813f08b 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -879,6 +879,74 @@ static void update_mov_insn_state(struct type_state *state,
 	pr_debug_type_name(&tsr->type, tsr->kind);
 }
 
+static void update_add_insn_state(struct type_state *state,
+				  struct data_loc_info *dloc,
+				  struct disasm_line *dl,
+				  struct annotated_op_loc *src,
+				  struct annotated_op_loc *dst)
+{
+	struct type_state_reg *tsr;
+	struct type_state_reg src_tsr;
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
+	tsr->lifetime_active = false;
+	tsr->lifetime_end = 0;
+
+retry:
+	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
+		invalidate_reg_state(tsr);
+		return;
+	}
+
+	src_tsr = state->regs[sreg];
+
+	if (arch_get_reg_offset(dloc->arch, src, sreg, state, false, &reg_offset))
+		goto add_non_regoff;
+
+	if (src_tsr.kind == TSR_KIND_CONST) {
+		tsr->kind = src_tsr.kind;
+		tsr->imm_value = src_tsr.imm_value + reg_offset;
+		tsr->offset = 0;
+		tsr->ok = src_tsr.ok;
+
+		pr_debug_dtp("add [%x] imm %#x(reg%d) -> reg%d\n",
+			     insn_offset, reg_offset, sreg, dreg);
+		return;
+	}
+
+	if (src_tsr.kind == TSR_KIND_POINTER ||
+	    (src_tsr.kind == TSR_KIND_TYPE &&
+	     dwarf_tag(&src_tsr.type) == DW_TAG_pointer_type)) {
+		tsr->type = src_tsr.type;
+		tsr->kind = src_tsr.kind;
+		tsr->imm_value = src_tsr.imm_value;
+		tsr->offset = src_tsr.offset + reg_offset;
+		tsr->ok = src_tsr.ok;
+
+		pr_debug_dtp("add [%x] address of %#x(reg%d) -> reg%d",
+			     insn_offset, reg_offset, sreg, dreg);
+		pr_debug_type_name(&tsr->type, tsr->kind);
+		return;
+	}
+
+add_non_regoff:
+	/* Try another register if any */
+	if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2 &&
+	    !(src->extend_type || src->shift_type)) {
+		sreg = src->reg2;
+		goto retry;
+	}
+	invalidate_reg_state(tsr);
+}
+
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
@@ -945,7 +1013,7 @@ static void update_insn_state_arm64(struct type_state *state,
 	 * prevent stale type info from propagating to subsequent instructions.
 	 */
 	if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
-	    strcmp(dl->ins.name, "mov") &&
+	    strcmp(dl->ins.name, "add") && strcmp(dl->ins.name, "mov") &&
 	    !is_standard_load_insn(dl->ins.name)) {
 		pr_debug_dtp("%s [%x] invalidate reg%d",
 			     dl->ins.name, insn_offset, dst->reg1);
@@ -958,8 +1026,10 @@ static void update_insn_state_arm64(struct type_state *state,
 		return;
 	}
 
+	if (!strcmp(dl->ins.name, "add"))
+		update_add_insn_state(state, dloc, dl, src, dst);
 	/* Register to register or imm value to register transfers */
-	if (!strcmp(dl->ins.name, "mov"))
+	else if (!strcmp(dl->ins.name, "mov"))
 		update_mov_insn_state(state, dl, src, dst);
 	/* Memory to register transfers */
 	else if (is_standard_load_insn(dl->ins.name))
-- 
2.34.1

