Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9863D6476;
	Sat,  8 Aug 2026 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786191877; cv=none; b=pfDE6touIKADPcTYHIPlQq+oZI9PUDLRowROlkkGtheuQTB5cpwSTtO0/JVGGe0YAL3pDl2fFajV8BZY6pWyPxapDhwZTH83x/F9Ktuuy+8UkZk1awMO4QhU/4pkqqg1a32ignJiO+acx4g5l5RQvtNfmGJM6Op87ygkMW3TViA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786191877; c=relaxed/simple;
	bh=5YeuKHpEOaBE6ODOFH8aCpiibLr97M6y7BQzxMRaeXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PboyvitXirdjfvD9IM68HKiUsXNvir61Q36nYxy8fwuOvJWLEbudr5Ej6OHbimCNNgZWE/rqlz6osWeQXAlAA6qbGWG+Q077ZrMyaByIpwmU+aitvdKbMZJdRqejx/9KymHyoGaISmGeX03LjuQzmRt93rArOxAqpvSth9wNOvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hHKtK4CcKzYQvmt;
	Sat,  8 Aug 2026 20:23:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BF93D4057D;
	Sat,  8 Aug 2026 20:24:19 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB34YjkH3dqbrhMBg--.41805S25;
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
Subject: [PATCH v4 23/23] perf annotate-arm64: Support 'mrs' instruction to track 'current' pointer
Date: Sat,  8 Aug 2026 12:24:00 +0000
Message-Id: <20260808122400.2961238-24-wutengda@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgB34YjkH3dqbrhMBg--.41805S25
X-Coremail-Antispam: 1UD129KBjvJXoW3JrW3KFykCr4xKw1DKryxAFb_yoWxJw4fpa
	yDC34DGrs7Jw4aganxJFWUZryfK393Ww15Kr90ywsayF47Kr1xK3WktFW2kay5Jr95uw17
	Jr4DKrs8Ww42vF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6x
	kF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
	6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjTRQYFCDUUUU
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

Introduce 'task_struct_cache' to cache the DWARF offset of task_struct
alongside its corresponding dbg handle. This is particularly important
because the compiler-generated stack canary check code (which loads from
'current->stack_canary') often exists in code sections or leaf functions
where the local Compilation Unit (CU) lacks a full 'struct task_struct'
definition. Caching the offset allows 'perf annotate' to consistently
resolve task-related fields across the entire kernel binary.

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
 .../perf/util/annotate-arch/annotate-arm64.c  | 97 ++++++++++++++++++-
 1 file changed, 95 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index b01fa6cf865f..9d1f315dcb28 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -15,6 +15,7 @@
 #include "../dso.h"
 #include "../map.h"
 #include "../symbol.h"
+#include "../strbuf.h"
 
 struct arch_arm64 {
 	struct arch arch;
@@ -889,6 +890,96 @@ static void update_adrp_insn_state(struct type_state *state,
 		     insn_offset, tsr->imm_value, dreg);
 }
 
+static struct {
+	Dwarf_Off dieoff;
+	Dwarf *dbg;
+} task_struct_cache;
+
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
+	 * Invalidate cached DIE offset if the debug info handle changed
+	 * (e.g. switching between vmlinux and a kernel module).
+	 */
+	if (task_struct_cache.dbg != dloc->di->dbg) {
+		task_struct_cache.dieoff = 0;
+		task_struct_cache.dbg = dloc->di->dbg;
+	}
+
+	if (!task_struct_cache.dieoff ||
+	    !dwarf_offdie(dloc->di->dbg, task_struct_cache.dieoff, &type_die)) {
+		struct strbuf sb;
+		char *type_name;
+		/*
+		 * Find the inline function 'get_current()' Dwarf_Die
+		 * and obtain its return value data type, which should
+		 * be 'struct task_struct*'.
+		 */
+		if (!die_find_inlinefunc(cu_die, pc, &func_die) ||
+		    !die_compare_name(&func_die, "get_current") ||
+		    !dwarf_attr_integrate(&func_die, DW_AT_type, &attr) ||
+		    !dwarf_formref_die(&attr, &type_die)) {
+			invalidate_reg_state(tsr);
+			return;
+		}
+
+		strbuf_init(&sb, 32);
+		die_get_typename_from_type(&type_die, &sb);
+		type_name = strbuf_detach(&sb, NULL);
+
+		if (!type_name || strcmp(type_name, "struct task_struct*")) {
+			invalidate_reg_state(tsr);
+			free(type_name);
+			return;
+		}
+
+		/*
+		 * Cache the 'struct task_struct*' die offset globally.
+		 * This allows us to resolve stack canary accesses even
+		 * in CUs that lack a full task_struct definition (e.g.,
+		 * compiler-generated entry/exit code).
+		 */
+		task_struct_cache.dieoff = dwarf_dieoffset(&type_die);
+		free(type_name);
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
+}
+
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
@@ -951,7 +1042,7 @@ static void update_insn_state_arm64(struct type_state *state,
 	 * prevent stale type info from propagating to subsequent instructions.
 	 */
 	if (has_reg_type(state, dst->reg1) &&
-	    strcmp(dl->ins.name, "adrp") &&
+	    strcmp(dl->ins.name, "mrs") && strcmp(dl->ins.name, "adrp") &&
 	    strcmp(dl->ins.name, "add") && strcmp(dl->ins.name, "mov") &&
 	    strncmp(dl->ins.name, "ld", 2) && strncmp(dl->ins.name, "st", 2)) {
 		pr_debug_dtp("%s [%x] invalidate reg%d",
@@ -965,7 +1056,9 @@ static void update_insn_state_arm64(struct type_state *state,
 		return;
 	}
 
-	if (!strcmp(dl->ins.name, "adrp"))
+	if (!strcmp(dl->ins.name, "mrs"))
+		update_mrs_insn_state(state, dloc, cu_die, dl, dst);
+	else if (!strcmp(dl->ins.name, "adrp"))
 		update_adrp_insn_state(state, dl, dst);
 	else if (!strcmp(dl->ins.name, "add"))
 		update_add_insn_state(state, dl, src, dst);
-- 
2.34.1

