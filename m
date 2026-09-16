Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C883AB260;
	Wed, 16 Sep 2026 01:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522250; cv=none; b=fVEa4umMNam5kJ8VFV1wu+tLYCGI1ZjgZ7b5FTgPdVaT+QiQTgGUMCfTb2nEcqcYp397x892pjMFEuSj+uqWY1x6GffE6/W0ZqM4FjlJLzhrXT5ZZZB0Kso0kyQvuxCmXrPuXkjLuFXWw1ybecADV6ocjzrCOqRI4xJjWPKEaO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522250; c=relaxed/simple;
	bh=l5B4CuMX9B2TkuTVEtSvt5S51IaKguCrelLXzRTnzeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nqx2ChgGWHEq+pzHaR2Kh53sfOLfyM4T5SPLVsNooEjr3wxG2X5ukuBknj3i8j1miQB/mne+0rZHVjhSjf7/FLASN79iHtcLDdMSY7AxIB+sOhjwd/xYv+00BpjgjMVweB7rkhUMOpdFFgTzFVsxE3IYHFiIddXCdQfGKzBrrqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hl1Y42KhZzKHMPn;
	Wed, 16 Sep 2026 09:30:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id ED4EB4056B;
	Wed, 16 Sep 2026 09:30:45 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgBHwPo_8alqshDTAQ--.7335S4;
	Wed, 16 Sep 2026 09:30:45 +0800 (CST)
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
Subject: [PATCH v6 26/26] perf annotate-arm64: Support 'mrs' instruction to track 'current' pointer
Date: Wed, 16 Sep 2026 01:30:18 +0000
Message-Id: <a98490f9cdae934fa44a209d8807a2f4365582f5.1789521520.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHwPo_8alqshDTAQ--.7335S4
X-Coremail-Antispam: 1UD129KBjvJXoW3JrW3KFW3JFW3Jr1xWw13XFb_yoW7Xr4fpa
	yDC34UWr4kJr42ganxXFWxZr93Wws7W34UCr98XwsayFW2kr1fta1ktFW2ya1rJrykuw13
	G3yUKr4DGw4IvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM2
	8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0pR5KsUUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state_arm64() to handle the 'mrs' instruction,
enabling the tracking of the 'current' task pointer in the kernel.

On arm64, the kernel uses the 'sp_el0' system register to store the
address of the currently executing 'struct task_struct'. This is
typically accessed via the 'get_current()' inline function, resulting
in the instruction 'mrs xN, sp_el0'.

To resolve the data type of the target register, first verify the
access is to 'sp_el0' within a kernel DSO. Then, locate the
'get_current()' inline function's DWARF Die at the current PC and
extract its return type (which should be 'struct task_struct*').

A real-world example is shown below:

  ffff8000800deee8 <kthread_blkcg>:
  ffff8000800deef0:  mrs  x0, sp_el0    // x0 = current
* ffff8000800deef4:  ldr  w1, [x0, #44]

Before this commit, the type flow starts with no information:

  chk [c] reg0 offset=0x2c ok=0 kind=0 cfa : no type information
  final result: no type information

After this commit, the tracker identifies the 'current' pointer
from the system register:

  mrs [8] sp_el0 -> reg0 type='struct task_struct*'
  chk [c] reg0 offset=0x2c ok=1 kind=1 (struct task_struct*) : Good!
  found by insn track: 0x2c(reg0) type-offset=0x2c
  final result: type='struct task_struct'

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 73 ++++++++++++++++++-
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index f4b7b0eb44f4..a4e4a38310cc 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -4,6 +4,7 @@
 #include <inttypes.h>
 #include <stdlib.h>
 #include <string.h>
+#include <strings.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
@@ -15,6 +16,7 @@
 #include "../dso.h"
 #include "../map.h"
 #include "../symbol.h"
+#include "../strbuf.h"
 
 struct arch_arm64 {
 	struct arch arch;
@@ -1054,6 +1056,71 @@ static void update_adrp_insn_state(struct type_state *state,
 		     insn_offset, tsr->imm_value, dreg);
 }
 
+static void update_mrs_insn_state(struct type_state *state,
+				  struct data_loc_info *dloc, Dwarf_Die *cu_die,
+				  struct disasm_line *dl,
+				  struct annotated_op_loc *dst)
+{
+	struct type_state_reg *tsr;
+	Dwarf_Die type_die;
+	u32 insn_offset = dl->al.offset;
+	int dreg = dst->reg1;
+	Dwarf_Die func_die;
+	Dwarf_Attribute attr;
+	u64 ip, pc;
+	struct strbuf sb;
+	char *type_name;
+
+	if (!has_reg_type(state, dreg))
+		return;
+
+	tsr = &state->regs[dreg];
+	tsr->copied_from = -1;
+
+	/* Handle case difference: LLVM (SP_EL0) vs objdump (sp_el0) */
+	if (!dso__kernel(map__dso(dloc->ms->map)) ||
+	    strcasecmp(dl->ops.source.raw, "sp_el0")) {
+		invalidate_reg_state(tsr);
+		return;
+	}
+
+	ip = dloc->ms->sym->start + dl->al.offset;
+	pc = map__rip_2objdump(dloc->ms->map, ip);
+
+	/*
+	 * Find the inline function 'get_current()' Dwarf_Die and obtain its
+	 * return value data type, which should be 'struct task_struct*'.
+	 */
+	if (!die_find_inlinefunc(cu_die, pc, &func_die) ||
+	    !die_compare_name(&func_die, "get_current") ||
+	    !dwarf_attr_integrate(&func_die, DW_AT_type, &attr) ||
+	    !dwarf_formref_die(&attr, &type_die)) {
+		invalidate_reg_state(tsr);
+		return;
+	}
+
+	strbuf_init(&sb, 32);
+	die_get_typename_from_type(&type_die, &sb);
+	type_name = strbuf_detach(&sb, NULL);
+
+	if (!type_name || strcmp(type_name, "struct task_struct*")) {
+		invalidate_reg_state(tsr);
+		goto out_free;
+	}
+
+	tsr->type = type_die;
+	tsr->kind = TSR_KIND_TYPE;
+	tsr->offset = 0;
+	tsr->imm_value = 0;
+	tsr->ok = true;
+
+	pr_debug_dtp("mrs [%x] sp_el0 -> reg%d", insn_offset, dreg);
+	pr_debug_type_name(&type_die, tsr->kind);
+
+out_free:
+	free(type_name);
+}
+
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
@@ -1120,7 +1187,7 @@ static void update_insn_state_arm64(struct type_state *state,
 	 * prevent stale type info from propagating to subsequent instructions.
 	 */
 	if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
-	    strcmp(dl->ins.name, "adrp") &&
+	    strcmp(dl->ins.name, "mrs") && strcmp(dl->ins.name, "adrp") &&
 	    strcmp(dl->ins.name, "add") && strcmp(dl->ins.name, "mov") &&
 	    !is_standard_load_insn(dl->ins.name)) {
 		pr_debug_dtp("%s [%x] invalidate reg%d",
@@ -1134,7 +1201,9 @@ static void update_insn_state_arm64(struct type_state *state,
 		return;
 	}
 
-	if (!strcmp(dl->ins.name, "adrp"))
+	if (!strcmp(dl->ins.name, "mrs"))
+		update_mrs_insn_state(state, dloc, cu_die, dl, dst);
+	else if (!strcmp(dl->ins.name, "adrp"))
 		update_adrp_insn_state(state, dl, dst);
 	else if (!strcmp(dl->ins.name, "add"))
 		update_add_insn_state(state, dloc, dl, src, dst);
-- 
2.34.1

