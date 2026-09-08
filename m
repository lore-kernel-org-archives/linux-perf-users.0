Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64261559C96;
	Tue,  8 Sep 2026 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872761; cv=none; b=LKk+Q9Vlyjxy6QMJDN5x7CH+ff5ntaU7BHg/C8Xu9VjCU+ITQYMZpvaMkjD8ZrvM3KJ7yE66gxIQQmXds8/7MxYCP3KcvbfokPKJjgQMLjXqE2MLWQnlh3CTzKZxnsS4VqD+xen9si0g2vWWbV2RRWo4PytHcf5M7q9VFd6wY/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872761; c=relaxed/simple;
	bh=WkLaZun02m9M3g8IXoovbpbpJ5MgOqi819t+HLC/GRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mjWjPFCvSuH7P4XwYmuatSBJPpHrvaDefRTY6no+7y3YtQVZsmbc75ceFm5061ZIubO0pXAY/j6/4MfoL1vmLxlL+DTcgXkEokh7GtMcb4+Xr+7J42hCKXJP/McVzip/U+Gxmv8S48TmBHJVs0UzsoaBVl8d5+HpG5SJRyTBh1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfPKw5DmrzYQwBQ;
	Tue,  8 Sep 2026 21:04:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3D1C740576;
	Tue,  8 Sep 2026 21:05:44 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDHLUoeCKBqX3XjBA--.22748S24;
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
Subject: [PATCH v5 22/26] perf annotate-arm64: Support 'mov' instruction tracking
Date: Tue,  8 Sep 2026 13:05:25 +0000
Message-Id: <6516a18b5618a169c2e180c296632e12c7f6697a.1788872630.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgDHLUoeCKBqX3XjBA--.22748S24
X-Coremail-Antispam: 1UD129KBjvJXoWxKw15JF18trWxGr4fGw47XFb_yoW7GFWrpa
	1DCw15G39Fqr42grsIqF47Xr9a9w4Igr12kryqq39IyFW3tr1rKa97tFWavF45JrykCw17
	Ja1DKFW5Xw42kaUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I64
	8v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Wrv_ZF1lc7CjxVAKzI0E
	Y4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW0oVCq3wCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7xRx
	noUUUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state_arm64() to support register-to-register and
immediate-to-register 'mov' instructions.

For register-to-register 'mov' (e.g., mov dreg, sreg), propagate data type
information from the source register to the destination register.

For immediate-to-register 'mov' (e.g., mov dreg, #imm), store the immediate
value in the destination register's imm_value field and set its kind to
TSR_KIND_CONST, allowing subsequent instructions to resolve it as a
constant.

A real-world example is shown below:

  ffff8000803eebf8 <get_vma_policy>:
  ffff8000803eec20:  mov  x21, x0          // x0 (struct vm_area_struct*) -> x21
  ffff8000803eec28:  ldr  x2, [x0, #112]
  ffff8000803eec2c:  cbz  x2, ffff8000803eec94 <get_vma_policy+0x9c>
* ffff8000803eec94:  ldr  x0, [x21, #152]

Before this commit, the type of x21 was unknown, causing the subsequent
inference to fail:

  var [0] reg0 offset 0 type='struct vm_area_struct*' size=0x8
  chk [9c] reg21 offset=0x98 ok=0 kind=0 cfa : no type information
  final result: no type information

After this commit, the type of x21 is correctly inferred as 'vm_area_struct':

  var [0] reg0 offset 0 type='struct vm_area_struct*' size=0x8
  mov [28] reg0 -> reg21 type='struct vm_area_struct*' size=0x8
  chk [9c] reg21 offset=0x98 ok=1 kind=1 (struct vm_area_struct*) : Good!
  found by insn track: 0x98(reg21) type-offset=0x98
  final result:  type='struct vm_area_struct' size=0xb0

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 60 ++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index d520975c5936..2f8bedf583c1 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 #include <errno.h>
+#include <inttypes.h>
 #include <stdlib.h>
 #include <string.h>
 #include <linux/ctype.h>
@@ -605,6 +606,7 @@ static int propagate_load_reg_state(struct type_state *state,
 		tsr->type = type_die;
 		tsr->kind = TSR_KIND_TYPE;
 		tsr->offset = 0;
+		tsr->imm_value = 0;
 		tsr->ok = true;
 
 		if (src->multi_regs) {
@@ -810,6 +812,58 @@ static void update_store_insn_state(struct type_state *state,
 	adjust_reg_index_state(state, dloc, dl, dst);
 }
 
+static void update_mov_insn_state(struct type_state *state,
+				  struct disasm_line *dl,
+				  struct annotated_op_loc *src,
+				  struct annotated_op_loc *dst)
+{
+	struct type_state_reg *tsr;
+	u32 insn_offset = dl->al.offset;
+	int sreg = src->reg1;
+	int dreg = dst->reg1;
+
+	if (!has_reg_type(state, dreg))
+		return;
+
+	tsr = &state->regs[dreg];
+	tsr->copied_from = -1;
+
+	if (src->imm) {
+		invalidate_reg_state(tsr);
+		tsr->kind = TSR_KIND_CONST;
+		tsr->imm_value = (s64)src->offset;
+		tsr->offset = 0;
+		tsr->ok = true;
+
+		pr_debug_dtp("mov [%x] imm=%#"PRIx64" -> reg%d\n",
+			     insn_offset, tsr->imm_value, dreg);
+		return;
+	}
+
+	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
+		invalidate_reg_state(tsr);
+		return;
+	}
+
+	tsr->type = state->regs[sreg].type;
+	tsr->kind = state->regs[sreg].kind;
+	tsr->imm_value = state->regs[sreg].imm_value;
+	tsr->offset = state->regs[sreg].offset;
+	tsr->ok = state->regs[sreg].ok;
+	/*
+	 * lifetime_active and lifetime_end represent DWARF variable lifetime
+	 * ranges tied to the source register. Copying them risks incorrectly
+	 * invalidating the destination register after a call instruction,
+	 * so intentionally omit them.
+	 */
+
+	if (tsr->kind == TSR_KIND_TYPE || tsr->kind == TSR_KIND_POINTER)
+		tsr->copied_from = sreg;
+
+	pr_debug_dtp("mov [%x] reg%d -> reg%d", insn_offset, sreg, dreg);
+	pr_debug_type_name(&tsr->type, tsr->kind);
+}
+
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
@@ -876,6 +930,7 @@ static void update_insn_state_arm64(struct type_state *state,
 	 * prevent stale type info from propagating to subsequent instructions.
 	 */
 	if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
+	    strcmp(dl->ins.name, "mov") &&
 	    !is_standard_load_insn(dl->ins.name)) {
 		pr_debug_dtp("%s [%x] invalidate reg%d",
 			     dl->ins.name, insn_offset, dst->reg1);
@@ -888,8 +943,11 @@ static void update_insn_state_arm64(struct type_state *state,
 		return;
 	}
 
+	/* Register to register or imm value to register transfers */
+	if (!strcmp(dl->ins.name, "mov"))
+		update_mov_insn_state(state, dl, src, dst);
 	/* Memory to register transfers */
-	if (is_standard_load_insn(dl->ins.name))
+	else if (is_standard_load_insn(dl->ins.name))
 		update_load_insn_state(state, dloc, dl, src, dst);
 	/* Register to memory transfers */
 	else if (is_standard_store_insn(dl->ins.name))
-- 
2.34.1

