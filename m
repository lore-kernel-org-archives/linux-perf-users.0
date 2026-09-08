Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE84555409D;
	Tue,  8 Sep 2026 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872787; cv=none; b=P5aFGbKfCLmTh9tJ8Fs2WbT/EIjVUOh7Rq37CJFE+2R1B8Dm0gEa6+Sd2TELzKhLv84Suk+MKXqal1jlq32QK8XiJJwkpENDjlMJTRoPdOcgdFrMMo49sMXLUnE/mn4Iy4eFwfbDmRYLWiJOoA1s3EZbVJ4CZyNXAu8HqJKW9ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872787; c=relaxed/simple;
	bh=Yrn5n8kaD5YJTxQbPrgxYVkdJxHBGTm/jSmBF3NX9FU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fDPx0eAs447QWGzi29lzpTQcZ2NBhDsm/meTEbSsNkjIiLp0vA6BgncDH74lQBnRsDvifqkQyoAsbJNf7OH2+/OYY3eKMkfBdBYmas6pVamSV35yYNbi3ioX1R8KZSs/cjdiRAQXazHxWGXZg9yTCBKIO2KyP/3oPOh8ODTAvBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hfPMb16yJzKHN5m;
	Tue,  8 Sep 2026 21:06:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 39B934058F;
	Tue,  8 Sep 2026 21:06:20 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBHurdFCKBqUhjWBA--.26443S4;
	Tue, 08 Sep 2026 21:06:19 +0800 (CST)
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
Subject: [PATCH v5 26/26] perf annotate-arm64: Support 'mrs' instruction to track 'current' pointer
Date: Tue,  8 Sep 2026 13:06:07 +0000
Message-Id: <d857b8bcea3aa9a218b2feebc4235095b25f5c72.1788872630.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgBHurdFCKBqUhjWBA--.26443S4
X-Coremail-Antispam: 1UD129KBjvJXoW3JrW3KFW3JFW3JrW5Kr48WFg_yoW7Xr4fpa
	yDC345Wr4kJr42ganxXFWxZr93Wws7W34Uur90qwsayFW7Kr1fKa1ktFW2ya15Jrykuw13
	GrWUKr4DWw4IvFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
	C0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
	6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x0262
	8vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26rxl6s0DMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280
	aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjTRlg4TDUUUU
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
index 33fef3d15378..d4b8c8d57dd7 100644
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
@@ -1037,6 +1039,71 @@ static void update_adrp_insn_state(struct type_state *state,
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
@@ -1103,7 +1170,7 @@ static void update_insn_state_arm64(struct type_state *state,
 	 * prevent stale type info from propagating to subsequent instructions.
 	 */
 	if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
-	    strcmp(dl->ins.name, "adrp") &&
+	    strcmp(dl->ins.name, "mrs") && strcmp(dl->ins.name, "adrp") &&
 	    strcmp(dl->ins.name, "add") && strcmp(dl->ins.name, "mov") &&
 	    !is_standard_load_insn(dl->ins.name)) {
 		pr_debug_dtp("%s [%x] invalidate reg%d",
@@ -1117,7 +1184,9 @@ static void update_insn_state_arm64(struct type_state *state,
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

