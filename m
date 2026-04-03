Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D7B396D38;
	Fri,  3 Apr 2026 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209737; cv=none; b=lYuQghkwFe8mHp3tBkg0j8AM7bwZPTNHNbOG9MvLgArpwHlsPK1j7YrVG0zkEJOWNjvcOLQcThOB7s2LyAFh07jIUz8nb8hPSYWPYonJcX/1yy4NitX+IfyNjh0ViacCDZoeMgEd8nOcvVp89xVKnrKRBNCegyYCu1lZxjmjDkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209737; c=relaxed/simple;
	bh=bgKiTTSyQ4y4kJ+WUZohf6ydQwOsT/tfbaDDo5qvqlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dBpHkSkJvL6G9BFzBzBGLrDa3DA+1jHJ24Zf7GlQzZp0rTtGIxVTpIei0j9Xgbe0QndzcKOCv0zj7N0CKsqquS1LB/rZU321LHZPxRxvaPThy/fqGcIbN6PZ3DISBS4jTkn/g1csf9v0c2IIeXkuGdg1hTqlpSwEVLq3D0Erhhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fnDRd3D9vzKHMXS;
	Fri,  3 Apr 2026 17:47:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0FE4C4056F;
	Fri,  3 Apr 2026 17:48:50 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with SMTP id _Ch0CgAnB1TwjM9p8K_UDA--.49742S13;
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
Subject: [PATCH v2 11/16] perf annotate-arm64: Support stack variable tracking
Date: Fri,  3 Apr 2026 09:47:55 +0000
Message-Id: <20260403094800.1418825-12-wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgAnB1TwjM9p8K_UDA--.49742S13
X-Coremail-Antispam: 1UD129KBjvJXoWxGFyfArW5tw1DJrW3ur1xXwb_yoWrCrWxpa
	1DCFy3Kr47Kr47KFs3JFs3Xr93Wws7Kw17C3s0qwn2yFySkr1rKas5tFW2vFW5Jr97Z34U
	Gw1DKrs5Xw42gaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Extend update_insn_state() for arm64 to track data types stored on the
stack. This allows 'perf annotate' to maintain type information for
local variables that are spilled to or loaded from stack slots.

The implementation handles:
1. Stack Loads (LDR): Identify when a register is loaded from a stack
   slot and update the register's type state based on the tracked
   stack content or compound member types.
2. Stack Stores (STR): Update or create new stack state entries when
   a tracked register type is stored to the stack.

This enables the instruction tracker to follow data types as they move
between registers and memory, specifically for function local variables
and compiler-spilled values on arm64.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 83 ++++++++++++++++++-
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 28647a778802..f9100230c2f6 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -11,6 +11,8 @@
 #include "../disasm.h"
 #include "../annotate-data.h"
 #include "../debug.h"
+#include "../map.h"
+#include "../symbol.h"
 
 struct arch_arm64 {
 	struct arch arch;
@@ -297,6 +299,8 @@ static void update_insn_state_arm64(struct type_state *state,
 	Dwarf_Die type_die;
 	u32 insn_offset = dl->al.offset;
 	int sreg, dreg;
+	int fbreg = dloc->fbreg;
+	int fboff = 0;
 
 	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
 		return;
@@ -304,17 +308,59 @@ static void update_insn_state_arm64(struct type_state *state,
 	sreg = src->reg1;
 	dreg = dst->reg1;
 
+	if (dloc->fb_cfa) {
+		u64 ip = dloc->ms->sym->start + dl->al.offset;
+		u64 pc = map__rip_2objdump(dloc->ms->map, ip);
+
+		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
+			fbreg = -1;
+	}
+
 	/* Memory to register transfers */
 	if (!strncmp(dl->ins.name, "ld", 2)) {
 		struct type_state_reg dst_tsr;
 
-		if (!has_reg_type(state, sreg) ||
-		    !has_reg_type(state, dreg) ||
-		    !state->regs[dreg].ok)
+		if (!has_reg_type(state, sreg))
 			return;
 
 		tsr = &state->regs[sreg];
 		tsr->copied_from = -1;
+
+		/* Check stack variables with offset */
+		if (sreg == fbreg || sreg == state->stack_reg) {
+			struct type_state_stack *stack;
+			int offset = src->offset - fboff;
+
+			stack = find_stack_state(state, offset);
+			if (stack == NULL) {
+				tsr->ok = false;
+				return;
+			} else if (!stack->compound) {
+				tsr->type = stack->type;
+				tsr->kind = stack->kind;
+				tsr->offset = stack->ptr_offset;
+				tsr->ok = true;
+			} else if (die_get_member_type(&stack->type,
+						       offset - stack->offset,
+						       &type_die)) {
+				tsr->type = type_die;
+				tsr->kind = TSR_KIND_TYPE;
+				tsr->offset = 0;
+				tsr->ok = true;
+			} else {
+				tsr->ok = false;
+				return;
+			}
+
+			pr_debug_dtp("ldr [%x] -%#x(stack) -> reg%d",
+				     insn_offset, -offset, sreg);
+			pr_debug_type_name(&tsr->type, tsr->kind);
+			return;
+		}
+
+		if (!has_reg_type(state, dreg) || !state->regs[dreg].ok)
+			return;
+
 		dst_tsr = state->regs[dreg];
 
 		/* Dereference the pointer if it has one */
@@ -338,6 +384,37 @@ static void update_insn_state_arm64(struct type_state *state,
 
 	/* Register to memory transfers */
 	if (!strncmp(dl->ins.name, "st", 2)) {
+		/* Check stack variables with offset */
+		if (dreg == fbreg || dreg == state->stack_reg) {
+			struct type_state_stack *stack;
+			int offset = dst->offset - fboff;
+
+			if (!has_reg_type(state, sreg) ||
+			    !state->regs[sreg].ok)
+				return;
+
+			tsr = &state->regs[sreg];
+
+			stack = find_stack_state(state, offset);
+			if (stack) {
+				if (!stack->compound)
+					set_stack_state(stack, offset, tsr->kind,
+							&tsr->type, tsr->offset);
+			} else {
+				findnew_stack_state(state, offset, tsr->kind,
+						    &tsr->type, tsr->offset);
+			}
+
+			pr_debug_dtp("str [%x] reg%d -> -%#x(stack)",
+				     insn_offset, sreg, -offset);
+			if (tsr->offset != 0) {
+				pr_debug_dtp(" reg%d offset %#x ->",
+					     sreg, tsr->offset);
+			}
+			pr_debug_type_name(&tsr->type, tsr->kind);
+			return;
+		}
+
 		/*
 		 * Store instructions do not change the register type,
 		 * but the base register must be updated for pre/post-index
-- 
2.34.1

