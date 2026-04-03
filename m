Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA9C39DBC3;
	Fri,  3 Apr 2026 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209742; cv=none; b=BgY4ap26lTnZAppF1K9yjlSVwt3O1L8+9lDlUCkUNEhFWz77m1KecL2QI8pLCxQco7TXX1AezYj7H4B/bj2hiDe8Zt5aJM6+6iWJYIXDgeboOebDXndLJj6FgGb5U+lGO3KTF42N621XmHCCiIgBoz0zRRAeMyyClbaqnIyOTsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209742; c=relaxed/simple;
	bh=be0SmBUPCmCW8DlV7Hy91XSVD3LwgZvzqYVRGdzW1G8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DZMDkdWDvcZnkxECJsmH6lOtf7OqI9EIPXheygEuIwrdSIwD3hiMQzRvvnVAw+SibQu3QORg9q7R5qRLg82rSU/4XrCS2DVk/wVUcAm4/HXNqoq3reFT63+HOX906pz3ThFfLCZWmLsjqwY5QHMh4qlV8watcSptOMxOIaXPllE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fnDRd6Qw5zKHMYS;
	Fri,  3 Apr 2026 17:47:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 7D4F84056D;
	Fri,  3 Apr 2026 17:48:50 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with SMTP id _Ch0CgAnB1TwjM9p8K_UDA--.49742S18;
	Fri, 03 Apr 2026 17:48:50 +0800 (CST)
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
Subject: [PATCH v2 16/16] perf annotate-arm64: Support 'mrs' instruction to track 'current' pointer
Date: Fri,  3 Apr 2026 09:48:00 +0000
Message-Id: <20260403094800.1418825-17-wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgAnB1TwjM9p8K_UDA--.49742S18
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4kWryrGr43AFyUJr43ZFb_yoWrZFyfpa
	yqk345Gr4kGw42gwsxJFZ7ZryfK393Wa45Cr90y34SyF4xKr18t3Z5t3y7Cay5Gr1v9347
	Jr4DKrW5GanrCaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
	1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRepBfUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state() for arm64 to handle the 'mrs' instruction,
enabling the tracking of the 'current' task pointer in the kernel.

On arm64, the kernel uses the 'sp_el0' system register to store the
address of the currently executing 'struct task_struct'. This is
typically accessed via the 'get_current()' inline function, resulting
in the instruction 'mrs xN, sp_el0'.

To resolve the data type of the target register, first verify the
access is to 'sp_el0' within a kernel DSO. Then, locate the
'get_current()' inline function's DWARF Die at the current PC and
extract its return type (which is 'struct task_struct *').

Introduce a global 'task_struct_off' cache to store the DWARF offset
of this type. This is particularly important because the compiler-generated
stack canary check code (which loads from 'current') often exists in
code sections or leaf functions where the local Compilation Unit (CU)
lacks a full 'struct task_struct' definition. Caching the offset allows
'perf annotate' to consistently resolve task-related fields across the
entire kernel binary.

A real-world example is shown below:

  ffff8000800deee8 <kthread_blkcg>:
  ffff8000800deef0:  mrs  x0, sp_el0    // x0 = current
  ffff8000800deef4:  ldr  w1, [x0, #44] // Access task_struct member

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
 .../perf/util/annotate-arch/annotate-arm64.c  | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 89b6b596f984..b03b12594260 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -14,6 +14,7 @@
 #include "../debug.h"
 #include "../map.h"
 #include "../symbol.h"
+#include "../dso.h"
 
 struct arch_arm64 {
 	struct arch arch;
@@ -289,6 +290,8 @@ static void adjust_reg_index_state(struct type_state *state, int reg,
 	pr_debug_type_name(&tsr->type, tsr->kind);
 }
 
+static Dwarf_Off task_struct_off;
+
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
@@ -309,6 +312,56 @@ static void update_insn_state_arm64(struct type_state *state,
 	sreg = src->reg1;
 	dreg = dst->reg1;
 
+	if (!strcmp(dl->ins.name, "mrs")) {
+		Dwarf_Die func_die;
+		Dwarf_Attribute attr;
+		u64 ip, pc;
+
+		if (!has_reg_type(state, sreg))
+			return;
+
+		/* Handle case difference: LLVM (SP_EL0) vs objdump (sp_el0) */
+		if (!dso__kernel(map__dso(dloc->ms->map)) ||
+		    strcasecmp(dl->ops.target.raw, "sp_el0"))
+			return;
+
+		ip = dloc->ms->sym->start + dl->al.offset;
+		pc = map__rip_2objdump(dloc->ms->map, ip);
+
+		if (!task_struct_off ||
+		    !dwarf_offdie(dloc->di->dbg, task_struct_off, &type_die)) {
+			/*
+			 * Find the inline function 'get_current()' Dwarf_Die
+			 * and obtain its return value data type, which should
+			 * be 'struct task_struct *'.
+			 */
+			if (!die_find_inlinefunc(cu_die, pc, &func_die) ||
+			    !dwarf_attr_integrate(&func_die, DW_AT_type, &attr) ||
+			    !dwarf_formref_die(&attr, &type_die))
+				return;
+
+			/*
+			 * Cache the 'struct task_struct *' die offset globally.
+			 * This allows us to resolve stack canary accesses even
+			 * in CUs that lack a full task_struct definition (e.g.,
+			 * compiler-generated entry/exit code).
+			 */
+			task_struct_off = dwarf_dieoffset(&type_die);
+		}
+
+		tsr = &state->regs[sreg];
+		tsr->copied_from = -1;
+		tsr->type = type_die;
+		tsr->kind = TSR_KIND_TYPE;
+		tsr->offset = 0;
+		tsr->addr = 0;
+		tsr->ok = true;
+
+		pr_debug_dtp("mrs [%x] sp_el0 -> reg%d", insn_offset, sreg);
+		pr_debug_type_name(&type_die, tsr->kind);
+		return;
+	}
+
 	if (!strcmp(dl->ins.name, "adrp")) {
 		if (!has_reg_type(state, sreg) || !dl->ops.target.addr)
 			return;
-- 
2.34.1

