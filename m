Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE8E396567;
	Fri,  3 Apr 2026 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209739; cv=none; b=XTGgbhmlfDh1w7JkB3qs3QAc29FyG23jt0UKl4PtuI94I8Dt3d1BPJrDGocuSt8PZPZfYV1uTzSydtjPvCYSZd0k4i1P5+WL5zGQZ6jsve1ZsT9MIzTm3uJVlrYeajFY+6+R3ELEPEenxTPrn1enF5an2+HJy8lpN6WDgHbk+Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209739; c=relaxed/simple;
	bh=satA8hu4LdtxjRRIBv1FmksXC6dIYImV6/HnLYpwsok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m7mgpbQus6C5ccJ/H6Aq0SlYNAx3TAnY9TwCNBpr7YR8YAfpK1UPvLCThwjNR1ox7gKvDAVnOAc9tdoxlG+t09T6QOpAK8I1ij2BQkSUdRwoKxGF/8JCzLIyy21ziOSClZWDsnUSVdAles+qNxnZgLU5mm/4NvSXCOIuJA/PfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fnDS83JTYzYQtvZ;
	Fri,  3 Apr 2026 17:48:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id DC29340576;
	Fri,  3 Apr 2026 17:48:49 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with SMTP id _Ch0CgAnB1TwjM9p8K_UDA--.49742S11;
	Fri, 03 Apr 2026 17:48:49 +0800 (CST)
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
Subject: [PATCH v2 09/16] perf annotate-arm64: Support load instruction tracking
Date: Fri,  3 Apr 2026 09:47:53 +0000
Message-Id: <20260403094800.1418825-10-wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgAnB1TwjM9p8K_UDA--.49742S11
X-Coremail-Antispam: 1UD129KBjvJXoW3WF1xtFy5XFWxWFyDGrWDXFb_yoW7Wr1rpa
	1DC3s8Kr47tr4agFs3XFZ7Xry3Kw1Dur1YkrZ8uwsIyFWIyr1rta1kKryakFWrJrZrCry7
	JF4ktryUWw1DCaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Implement update_insn_state() for arm64 to track register state changes
during load (LDR) instructions. This is essential for maintaining accurate
type information when data is moved from memory to registers.

The implementation handles the three primary arm64 addressing modes:
1. Signed offset: [base, #imm]
2. Pre-index: [base, #imm]!
3. Post-index: [base], #imm

Introduce adjust_reg_index_state() to handle the side effects of pre-index
and post-index addressing, where the base register is updated with the
offset after or before the memory access. This ensures that the register's
offset within a structure is correctly tracked across sequential
instructions.

A real-world example is shown below:

  ffff80008011f5b0 <pick_task_stop>:
  ffff80008011f5b8:  ldr  x0, [x0, #2712] // x0: struct rq* -> task_struct*
  ffff80008011f5c0:  ldr  w1, [x0, #104]  // PMU sample at offset 0x68

Before this commit, the type of x0 was incorrectly inferred as 'struct rq':

  find data type for 0x68(reg0) at pick_task_stop+0x10
  var [8] reg0 offset 0 type='struct rq*'
  chk [10] reg0 offset=0x68 ok=1 kind=1 (struct rq*) : Good!
  final result:  type='struct rq'

After this commit, the type of x0 is correctly inferred as 'struct task_struct':

  find data type for 0x68(reg0) at pick_task_stop+0x10
  var [8] reg0 offset 0 type='struct rq*'
  ldr [8] 0xa98(reg0) -> reg0 type='struct task_struct*'
  chk [10] reg0 offset=0x68 ok=1 kind=1 (struct task_struct*) : Good!
  final result: type='struct task_struct'

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 1fe4c503431b..cac2bf0021c9 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -9,6 +9,8 @@
 #include <regex.h>
 #include "../annotate.h"
 #include "../disasm.h"
+#include "../annotate-data.h"
+#include "../debug.h"
 
 struct arch_arm64 {
 	struct arch arch;
@@ -254,6 +256,88 @@ static int extract_op_location_arm64(const struct arch *arch,
 	return 0;
 }
 
+#ifdef HAVE_LIBDW_SUPPORT
+static int get_mem_offset(struct annotated_op_loc *op_loc, int type_offset)
+{
+	if (op_loc->addr_mode == INSN_ADDR_POST_INDEX)
+		return type_offset;
+
+	return op_loc->offset + type_offset;
+}
+
+static void adjust_reg_index_state(struct type_state *state, int reg,
+				   struct annotated_op_loc *op_loc,
+				   const char *insn_name, u32 insn_offset)
+{
+	struct type_state_reg *tsr;
+
+	if (!has_reg_type(state, reg) ||
+	    (op_loc->addr_mode != INSN_ADDR_PRE_INDEX &&
+	    op_loc->addr_mode != INSN_ADDR_POST_INDEX))
+		return;
+
+	tsr = &state->regs[reg];
+	tsr->offset = op_loc->offset + tsr->offset;
+	tsr->ok = true;
+
+	pr_debug_dtp("%s [%x] %s-index %#x(reg%d) -> reg%d", insn_name,
+		     insn_offset, op_loc->addr_mode == INSN_ADDR_PRE_INDEX ?
+		     "pre" : "post", op_loc->offset, reg, reg);
+	pr_debug_type_name(&tsr->type, tsr->kind);
+}
+
+static void update_insn_state_arm64(struct type_state *state,
+				    struct data_loc_info *dloc, Dwarf_Die * cu_die __maybe_unused,
+				    struct disasm_line *dl)
+{
+	struct annotated_insn_loc loc;
+	struct annotated_op_loc *src = &loc.ops[INSN_OP_SOURCE];
+	struct annotated_op_loc *dst = &loc.ops[INSN_OP_TARGET];
+	struct type_state_reg *tsr;
+	Dwarf_Die type_die;
+	u32 insn_offset = dl->al.offset;
+	int sreg, dreg;
+
+	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
+		return;
+
+	sreg = src->reg1;
+	dreg = dst->reg1;
+
+	/* Memory to register transfers */
+	if (!strncmp(dl->ins.name, "ld", 2)) {
+		struct type_state_reg dst_tsr;
+
+		if (!has_reg_type(state, sreg) ||
+		    !has_reg_type(state, dreg) ||
+		    !state->regs[dreg].ok)
+			return;
+
+		tsr = &state->regs[sreg];
+		tsr->copied_from = -1;
+		dst_tsr = state->regs[dreg];
+
+		/* Dereference the pointer if it has one */
+		if (dst_tsr.kind == TSR_KIND_TYPE &&
+		    die_deref_ptr_type(&dst_tsr.type,
+				       get_mem_offset(dst, dst_tsr.offset),
+				       &type_die)) {
+			tsr->type = type_die;
+			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
+			tsr->ok = true;
+
+			pr_debug_dtp("ldr [%x] %#x(reg%d) -> reg%d",
+				     insn_offset, dst->offset, dreg, sreg);
+			pr_debug_type_name(&tsr->type, tsr->kind);
+
+			adjust_reg_index_state(state, dreg, dst, "ldr", insn_offset);
+		}
+		return;
+	}
+}
+#endif
+
 const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 				   const char *cpuid __maybe_unused)
 {
@@ -273,6 +357,9 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 	arch->objdump.imm_char		  = '#';
 	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
 	arch->extract_op_location	  = extract_op_location_arm64;
+#ifdef HAVE_LIBDW_SUPPORT
+	arch->update_insn_state		  = update_insn_state_arm64;
+#endif
 
 	/* bl, blr */
 	err = regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
-- 
2.34.1

