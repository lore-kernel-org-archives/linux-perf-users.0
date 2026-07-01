Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B00B36CDE2;
	Wed,  1 Jul 2026 03:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878098; cv=none; b=q2UCWrnT4SvEfPHqNugZPW1KyIIUy9JvWGXaUdMR2UGYkuUtyXFg40NRZmdMRoxT4IFJT3Dc6Ebk/u/SzneJVIeQeUaaHqg4+zlhhAIzp+z8XDKJg6AHjVDv7BzkshNZeKvNRo6yfcUDV9gHVT9hOfQWm18FkWQXh+uIWuJfaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878098; c=relaxed/simple;
	bh=yLqobnLvOwlmio6Rns+JxmiItbufiWBxmekTU2edxJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FYOc0SJgMd25Stkv9MyqVXGOCrcNDeFeoc04TJPEXCaODdHAqzRgoxFW3J7HwTd/UJkR0dyfYWSalQ4qEk0/pTxgqfYrsCL53UTZhQ/6eWbssRiMfDDbNxRCh6VNFeHawo0/vJ61ISeMzd1HNLrnL0MSQyhv52zkHl/hFxVgCIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gqmN075kyzYQttK;
	Wed,  1 Jul 2026 11:53:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D6D4A40570;
	Wed,  1 Jul 2026 11:54:46 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBXiyWAj0RqCne9AQ--.26189S22;
	Wed, 01 Jul 2026 11:54:46 +0800 (CST)
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
Subject: [PATCH v3 20/21] perf annotate-arm64: Support per-cpu variable access tracking
Date: Wed,  1 Jul 2026 03:53:54 +0000
Message-Id: <20260701035355.752944-21-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701035355.752944-1-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBXiyWAj0RqCne9AQ--.26189S22
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr15KrWDAF4kuw1kJFW8WFg_yoWxKr1kp3
	s5Kry5W34ktrs7WwsaqFW7XFyF9393Gas2k345Zw1ayryIkr1DGa92kryYvFWUGF93Aw17
	trs8Kw47XrsFkaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7
	CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc7CjxVAKzI0EY4vE52x082I5MxAI
	w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
	6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRNg4S3UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state() for arm64 to handle per-cpu variable
addressing.

On arm64, per-cpu variables are accessed by adding a per-cpu offset
(typically from the '__per_cpu_offset' array) to the address of a global
variable or a local variable with '__percpu' modifier(e.g.,
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

  case 2: local variable with '__percpu' modifier
    ldr   x1, [x25, #32]         // x1 = local_percpu_ptr

To handle such cases:

1. Identify per-cpu base initialization: Detect 'adrp+add' pairs that
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
* ffff8000808f2d80:  ldr   w23, [x5, x2]          // per_cpu(cpu_pcc_subspace_idx, cpu)

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
 .../perf/util/annotate-arch/annotate-arm64.c  | 60 ++++++++++++++++++-
 tools/perf/util/annotate-data.c               | 24 +++++++-
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 6f96e75d313d..ec6fd59d51a2 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -462,6 +462,15 @@ static void update_load_insn_state(struct type_state *state,
 		u64 ip = dloc->ms->sym->start + dl->al.offset;
 		u64 addr = src_tsr.addr + reg_offset;
 		int offset;
+		u8 kind;
+		const char *var_name = NULL;
+
+		/* it might be per-cpu offset */
+		if (get_global_var_info(dloc, addr, &var_name, &offset) &&
+		    !strcmp(var_name, "__per_cpu_offset"))
+			kind = TSR_KIND_PERCPU_BASE;
+		else
+			kind = TSR_KIND_TYPE;
 
 		if (!get_global_var_type(cu_die, dloc, ip, addr, &offset, &type_die) ||
 		    !die_get_member_type(&type_die, offset, &type_die)) {
@@ -470,7 +479,7 @@ static void update_load_insn_state(struct type_state *state,
 		}
 
 		tsr->type = type_die;
-		tsr->kind = TSR_KIND_TYPE;
+		tsr->kind = kind;
 		tsr->offset = 0;
 		tsr->addr = 0;
 		tsr->ok = true;
@@ -484,6 +493,28 @@ static void update_load_insn_state(struct type_state *state,
 		}
 		pr_debug_type_name(&tsr->type, tsr->kind);
 	}
+	/* Or check if it's a per-cpu access */
+	else if (src_tsr.kind == TSR_KIND_PERCPU_BASE) {
+		int reg2;
+
+		if (!src->multi_regs || src->reg1 == src->reg2 ||
+		    sreg == src->reg2 /* retried */) {
+			invalidate_reg_state(tsr);
+			goto out_adjust;
+		}
+
+		reg2 = src->reg2;
+		if (!has_reg_type(state, reg2) || !state->regs[reg2].ok ||
+		    (state->regs[reg2].kind != TSR_KIND_GLOBAL_ADDR &&
+		     state->regs[reg2].kind != TSR_KIND_TYPE)) {
+			invalidate_reg_state(tsr);
+			goto out_adjust;
+		} else {
+			/* Treat percpu as array: resolve type from reg2 */
+			sreg = src->reg2;
+			goto retry;
+		}
+	}
 	/* Or try another register if any */
 	else if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2) {
 		sreg = src->reg2;
@@ -693,6 +724,33 @@ static void update_add_insn_state(struct type_state *state,
 		pr_debug_dtp("add [%x] global %#x(reg%d) -> reg%d\n",
 			     insn_offset, reg_offset, sreg, dreg);
 	}
+	/* Handle per-cpu base address calculation for per-cpu variables */
+	else if (src_tsr.kind == TSR_KIND_PERCPU_BASE) {
+		/*
+		 * A per-cpu base acts like an array index. Adding it to
+		 * a global variable or typed register should preserve
+		 * the original variable's type. Inherit the type from
+		 * the typed register.
+		 */
+		if (!src->multi_regs || !has_reg_type(state, src->reg2) ||
+		    !state->regs[src->reg2].ok ||
+		    (state->regs[src->reg2].kind != TSR_KIND_GLOBAL_ADDR &&
+		     state->regs[src->reg2].kind != TSR_KIND_TYPE)) {
+			invalidate_reg_state(tsr);
+			return;
+		}
+
+		tsr->type = state->regs[src->reg2].type;
+		tsr->kind = state->regs[src->reg2].kind;
+		tsr->offset = state->regs[src->reg2].offset;
+		tsr->addr = state->regs[src->reg2].addr;
+		tsr->ok = state->regs[src->reg2].ok;
+
+		pr_debug_dtp("add [%x] percpu (reg%d) -> reg%d",
+			     insn_offset, sreg, dreg);
+		pr_debug_type_name(&tsr->type, tsr->kind);
+		return;
+	}
 	/* Or try another register if any */
 	else if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2) {
 		sreg = src->reg2;
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 6fa5cd373a46..b0bf0437168b 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1252,11 +1252,33 @@ static enum type_match_result check_matching_type(struct type_state *state,
 	}
 
 	if (state->regs[reg].kind == TSR_KIND_PERCPU_BASE) {
-		u64 var_addr = dloc->op->offset;
+		u64 var_addr;
 		int var_offset;
 
 		pr_debug_dtp("percpu var");
 
+		if (arch__is_arm64(dloc->arch)) {
+			int reg2;
+
+			if (!dloc->op->multi_regs ||
+			    dloc->op->reg1 == dloc->op->reg2 || !retry)
+				return PERF_TMR_BAIL_OUT;
+
+			reg2 = dloc->op->reg2;
+			if (!has_reg_type(state, reg2) ||
+			    !state->regs[reg2].ok ||
+			    (state->regs[reg2].kind != TSR_KIND_GLOBAL_ADDR &&
+			     state->regs[reg2].kind != TSR_KIND_TYPE))
+				return PERF_TMR_NO_TYPE;
+
+			pr_debug_dtp(" : retry\n");
+			retry = false;
+			reg = reg2;
+			goto again;
+		}
+
+		var_addr = dloc->op->offset;
+
 		if (dloc->op->multi_regs) {
 			int reg2 = dloc->op->reg2;
 
-- 
2.34.1

