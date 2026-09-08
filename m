Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4163548572;
	Tue,  8 Sep 2026 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872785; cv=none; b=js/SY8LDgXf53F8/TDDPzlGTSsf1TvkAU0ziemQh/3EqeoDy+VEiTQafh+XUyb1W6aIIo5y/1Xxrs9aiWWwD1uzZQRXLD7tCBCriGBuoSu4NItyTpdZYnF5ZDxAdXCQpVLp+rQVwkR5vq9LgykoFbsi9tvFoY9oku0yiQsxYTT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872785; c=relaxed/simple;
	bh=EHVD5fqPR9gI1/IWrXrCmVkZK0PlrrQmg7nTwXcFqlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YS2+dHMLTJnR7pmHxcXLcUDh2AfzSv1YKCpGW4/1LGXnyQ4M5KWV1dUpQPkHUkWBqNPPmOOpxhHRtOBFpKAzZpF9W5UKxENX0dAEhWPH1OukWF9DIBbbcxdSM1OY9RncOzcwapXgjKJF6s4CBPzI/5xUzrRya3UBE7iymXBzIkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfPLc4bK8zYQv3L;
	Tue,  8 Sep 2026 21:05:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2556340574;
	Tue,  8 Sep 2026 21:06:20 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBHurdFCKBqUhjWBA--.26443S3;
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
Subject: [PATCH v5 25/26] perf annotate-arm64: Support per-cpu variable access tracking
Date: Tue,  8 Sep 2026 13:06:06 +0000
Message-Id: <4cebb0f4d2db4d66c4ec19c4c007d6761e5aad8e.1788872630.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgBHurdFCKBqUhjWBA--.26443S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr15KrWDAF15Cr4ftw4UCFg_yoWxWFyfp3
	95KryUW34ktrsrWws3tFW5XryF9393Ja4Ik34Y9w1avr1Igr1UG397KrW5tF4UGFnay3W7
	tr9xtrZrXrnFkaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
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
	aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjTRLSdqDUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state_arm64() to handle per-cpu variable addressing.

On arm64, per-cpu variables are accessed by adding a per-cpu offset
(typically from the '__per_cpu_offset' array) to the address of a global
variable or a structure field with '__percpu' modifier (e.g.,
's32 __percpu *counters' in struct percpu_counter). This results in
instruction patterns like:

  ldr   x0, [x6, x5]   // Pattern A: direct load per-cpu instance
  add   x0, x6, x5     // Pattern B: compute per-cpu address

where x6 holds the per-cpu offset retrieved from:

  adrp  x4, <page>
  add   x4, x4, #offset          // x4 = &__per_cpu_offset
  ldr   x6, [x4, w0, sxtw #3]    // x6 = __per_cpu_offset[cpu]

and x5 is one of the following:

  case 1: global variable
    adrp  x5, <page>
    add   x5, x5, #offset        // x5 = &global_var

  case 2: '__percpu' field embedded in a structure
    ldr   x5, [x25, #32]         // x5 = &percpu_field

To handle such cases:

1. Identify per-cpu base initialization: Detect 'adrp + ldr' pairs that
   resolve to the '__per_cpu_offset' symbol and mark the destination
   register as TSR_KIND_PERCPU_BASE.
2. Propagate type information: During subsequent 'ldr' or 'add'
   instructions, if one register is TSR_KIND_PERCPU_BASE, attempt to
   resolve the type from the other register.

A real-world example is shown below:

  ffff8000808f2d28 <cppc_set_perf>:
  ffff8000808f2d38:  adrp  x2, ffff800082033000
  ffff8000808f2d3c:  add   x5, x2, #0x3f8         // x5 = &__per_cpu_offset
  ffff8000808f2d44:  adrp  x2, ffff800081f73000
  ffff8000808f2d48:  add   x2, x2, #0x6b8         // x2 = &cpu_pcc_subspace_idx
  ffff8000808f2d6c:  ldr   x5, [x5, w0, sxtw #3]  // x5 = __per_cpu_offset[cpu]
* ffff8000808f2d80:  ldr   w23, [x5, x2]          // per_cpu_var(cpu_pcc_subspace_idx)

Before this commit, the tracker could not link x5 back to a per-cpu
context, resulting in an incorrect data type resolution:

  adrp [10] global addr=0xffff800082033000 -> reg2
  add [14] global 0x3f8(reg2) -> reg5
  adrp [1c] global addr=0xffff800081f73000 -> reg2
  add [20] global 0x6b8(reg2) -> reg2
  ldr [44] global (reg5, reg0) -> reg5 type='long unsigned int[]' size=0x1000
  chk [58] reg5 offset=0 ok=1 kind=1 (long unsigned int[]) : Good!
  found by insn track: 0(reg5, reg2) type-offset=0
  final result:  type='long unsigned int' size=0x8

After this commit, the tracker correctly identifies the per-cpu flow and
resolves the actual variable type:

  ldr [44] global (reg5, reg0) -> reg5 percpu base
  chk [58] reg5 offset=0 ok=1 kind=2 percpu var : retry
  chk [58] reg2 offset=0 ok=1 kind=7 global addr : Good!
  found by insn track: 0(reg5, reg2) type-offset=0
  final result:  type='int' size=0x4

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 47 ++++++++++++++++++-
 tools/perf/util/annotate-data.c               | 22 ++++++++-
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 9daf95905545..33fef3d15378 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -12,6 +12,7 @@
 #include "../disasm.h"
 #include "../annotate-data.h"
 #include "../debug.h"
+#include "../dso.h"
 #include "../map.h"
 #include "../symbol.h"
 
@@ -627,13 +628,23 @@ static int propagate_load_reg_state(struct type_state *state,
 		u64 ip = dloc->ms->sym->start + dl->al.offset;
 		u64 addr = src_tsr->imm_value + reg_offset;
 		int offset;
+		u8 kind;
+		const char *var_name = NULL;
+
+		/* it might be per-cpu offset */
+		if (dso__kernel(map__dso(dloc->ms->map)) &&
+		    get_global_var_info(dloc, addr, &var_name, &offset) &&
+		    !strcmp(var_name, "__per_cpu_offset"))
+			kind = TSR_KIND_PERCPU_BASE;
+		else
+			kind = TSR_KIND_TYPE;
 
 		if (!get_global_var_type(cu_die, dloc, ip, addr, &offset, &type_die) ||
 		    !die_get_member_type(&type_die, offset, &type_die))
 			return -1;
 
 		tsr->type = type_die;
-		tsr->kind = TSR_KIND_TYPE;
+		tsr->kind = kind;
 		tsr->offset = 0;
 		tsr->imm_value = 0;
 		tsr->ok = true;
@@ -649,6 +660,12 @@ static int propagate_load_reg_state(struct type_state *state,
 		return 0;
 	}
 
+	/*
+	 * If src_tsr->kind is TSR_KIND_PERCPU_BASE, treat it as an array.
+	 * No special handling is needed here; just fall through to retry
+	 * and resolve the type from the second register.
+	 */
+
 	/* Or try another register if any */
 	if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2 &&
 	    !(src->extend_type || src->shift_type)) {
@@ -949,6 +966,34 @@ static void update_add_insn_state(struct type_state *state,
 		return;
 	}
 
+	if (src_tsr.kind == TSR_KIND_PERCPU_BASE) {
+		int reg2;
+
+		if (!src->multi_regs) {
+			invalidate_reg_state(tsr);
+			return;
+		}
+
+		reg2 = (sreg == src->reg1) ? src->reg2 : src->reg1;
+
+		if (!has_reg_type(state, reg2) || !state->regs[reg2].ok) {
+			invalidate_reg_state(tsr);
+			return;
+		}
+
+		/* Treat percpu as array: inherit type from reg2 */
+		tsr->type = state->regs[reg2].type;
+		tsr->kind = state->regs[reg2].kind;
+		tsr->offset = state->regs[reg2].offset;
+		tsr->imm_value = state->regs[reg2].imm_value;
+		tsr->ok = state->regs[reg2].ok;
+
+		pr_debug_dtp("add [%x] percpu (reg%d, reg%d) -> reg%d",
+			     insn_offset, src->reg1, src->reg2, dreg);
+		pr_debug_type_name(&tsr->type, tsr->kind);
+		return;
+	}
+
 try_other_reg:
 	/* Try another register if any */
 	if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2 &&
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 6897bd275e59..eb6a592cda84 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1339,11 +1339,31 @@ static enum type_match_result check_matching_type(struct type_state *state,
 	}
 
 	if (state->regs[reg].kind == TSR_KIND_PERCPU_BASE) {
-		u64 var_addr = (s64) offset;
+		u64 var_addr;
 		int var_offset;
 
 		pr_debug_dtp("percpu var");
 
+		if (arch__is_arm64(dloc->arch)) {
+			int reg2;
+
+			if (!retry || !dloc->op->multi_regs ||
+			    dloc->op->reg1 == dloc->op->reg2 ||
+			    dloc->op->extend_type || dloc->op->shift_type)
+				return PERF_TMR_BAIL_OUT;
+
+			reg2 = dloc->op->reg2;
+			if (!has_reg_type(state, reg2) || !state->regs[reg2].ok)
+				return PERF_TMR_NO_TYPE;
+
+			pr_debug_dtp(" : retry\n");
+			retry = false;
+			reg = reg2;
+			goto again;
+		}
+
+		var_addr = (s64) offset;
+
 		if (dloc->op->multi_regs) {
 			int reg2 = dloc->op->reg2;
 
-- 
2.34.1

