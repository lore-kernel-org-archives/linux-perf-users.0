Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A0E519908;
	Tue, 13 Oct 2026 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898129; cv=none; b=XwEqJnIqFemhxVCtvJzLUH7E4/j5+ydlj4jCLPKZfyps39NuLJ9KpdWNc0zfn8fGB7Qetvam4dvp0bOJgnxgaMCJKG3POwR6UMqHcobdNtt+n+eVHayyznzf3/CI/kuri1yMiHqKnZKY94SeL9HS1dtM1EUXUZMKfklYiR1Mit4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898129; c=relaxed/simple;
	bh=ySHv1kS7mvMH0236M8Ln3I8uykdI/YAmZJSCQ+PsVU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aGIt1JGesub/RPRKLLWmvqKP7jbrCzM5knxTPFSRBe03uyGwKgfKEKnN175lZWI8EQAiBi84wTeY8ip6VRVSLaLjskbZ+PZ4/9YyFOeKo7Y+1gxCd6/qP/ptN8CFDCwunV10BtfnD8Hr2EKtXqCca+RfVQEXOCwi5qZlCdSUP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j3wBB2cSszYQvF2;
	Tue, 13 Oct 2026 21:27:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9FD2540ABE;
	Tue, 13 Oct 2026 21:28:37 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDnIvL3Mc5qfU4wAQ--.7133S17;
	Tue, 13 Oct 2026 21:28:37 +0800 (CST)
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
Subject: [PATCH v7 15/15] perf annotate-arm64: Support 'mrs' instruction to track 'current' pointer
Date: Tue, 13 Oct 2026 13:28:13 +0000
Message-Id: <0615c314accfce4f3db561db1b1e02efcc5fd66b.1791629326.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDnIvL3Mc5qfU4wAQ--.7133S17
X-Coremail-Antispam: 1UD129KBjvJXoW3JrW3KFW3JFWxKFyUAw1rtFb_yoW7XF4Dpa
	yDC34UWrs7Jr42gFsxXFWxZr93Wws7W34UCr98XwsayFW7Kr1fKa1ktFW2ya1rJrykuw13
	G3yUKr4DGw4IvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 73 ++++++++++++++++++-
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 5683215f0770..6da558f7e864 100644
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
@@ -1030,6 +1032,71 @@ static void update_adrp_insn_state(struct type_state *state,
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
@@ -1096,7 +1163,7 @@ static void update_insn_state_arm64(struct type_state *state,
 	 * prevent stale type info from propagating to subsequent instructions.
 	 */
 	if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
-	    strcmp(dl->ins.name, "adrp") &&
+	    strcmp(dl->ins.name, "mrs") && strcmp(dl->ins.name, "adrp") &&
 	    strcmp(dl->ins.name, "add") && strcmp(dl->ins.name, "mov") &&
 	    !is_standard_load_insn(dl->ins.name)) {
 		pr_debug_dtp("%s [%x] invalidate reg%d",
@@ -1110,7 +1177,9 @@ static void update_insn_state_arm64(struct type_state *state,
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

