Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600EE519902;
	Tue, 13 Oct 2026 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898129; cv=none; b=hP9vV3sSz7Rz8m2l8ZI5/v4p579sa9vrzQ2xJWGxtdRjyBj+68u8VQMqZBBBOqJGngOiZJRcDS4wF/18RVLNjE9Mb+1YszxezS80uzlzX5tYdPM1XcCt/uSwGSCCVV0mVhrY+JuvsRr4tUkHaE23Hn/x/EwDpJDNO/O4WGztJsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898129; c=relaxed/simple;
	bh=j945j5VQjTTDM3pdxHFxNmylrhxEMCvE6NjwYp2z/ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KLU6CCRn1QTiKlL9pxySmRGSk8OKRZx3x05OHMV5yEe1ocZmVKfaRGUC7/JP55F8aR3xxLqjIRRRYv4w9vRU3xDQnG8MulGjXjD6n9ibBEIMTag+zUaXaYPT7C3BQ9W4aKnIV3qiNQ5+zERnuyZvJLaT74c40u6AbGmk4WoZ/DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j3wB965fBzYQvGK;
	Tue, 13 Oct 2026 21:27:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2641440AA1;
	Tue, 13 Oct 2026 21:28:37 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDnIvL3Mc5qfU4wAQ--.7133S13;
	Tue, 13 Oct 2026 21:28:36 +0800 (CST)
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
Subject: [PATCH v7 11/15] perf annotate-arm64: Support 'mov' instruction tracking
Date: Tue, 13 Oct 2026 13:28:09 +0000
Message-Id: <9e8a4f59ac1750e136795fbd58aa6613dab30f93.1791629326.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDnIvL3Mc5qfU4wAQ--.7133S13
X-Coremail-Antispam: 1UD129KBjvJXoWxKw15JF18trWxGr4fGw47XFb_yoW7GryDp3
	WDC345G39Fqr42gFsIqF47Xr9a9w4xKr12kryqqwsIyFW3tw1rKa97KFWavF45JrykCr17
	Gw4DKFZ8Xw42kaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YV
	CY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRQYFCDUUUU
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

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 56 ++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index d17d9b2456dc..ed574aba0b56 100644
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
@@ -614,6 +615,7 @@ static int propagate_load_reg_state(struct type_state *state,
 		tsr->type = type_die;
 		tsr->kind = TSR_KIND_TYPE;
 		tsr->offset = 0;
+		tsr->imm_value = 0;
 		tsr->ok = true;
 
 		pr_debug_dtp("%s [%x] %#x(reg%d) -> reg%d",
@@ -827,6 +829,54 @@ static void update_store_insn_state(struct type_state *state,
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
+	tsr->lifetime_active = state->regs[sreg].lifetime_active;
+	tsr->lifetime_end = state->regs[sreg].lifetime_end;
+	tsr->ok = state->regs[sreg].ok;
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
@@ -893,6 +943,7 @@ static void update_insn_state_arm64(struct type_state *state,
 	 * prevent stale type info from propagating to subsequent instructions.
 	 */
 	if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
+	    strcmp(dl->ins.name, "mov") &&
 	    !is_standard_load_insn(dl->ins.name)) {
 		pr_debug_dtp("%s [%x] invalidate reg%d",
 			     dl->ins.name, insn_offset, dst->reg1);
@@ -905,8 +956,11 @@ static void update_insn_state_arm64(struct type_state *state,
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

