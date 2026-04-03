Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0E23976A3;
	Fri,  3 Apr 2026 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209742; cv=none; b=jmn9PCwl7P2q39SJlWRRalNxGFCusbBCEVhJexisKFl523Yc5+UbadwAF+eh2bnjntoVGM2b6h7ed9h+f08KeTSXEIHcO3t4RFmH+uNNHQeUlKZdcc4d/2h01/Mik3wOc13NL7zG0/m2uHYkjlQgnEKX+nSa2oNFQpEhT08A30Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209742; c=relaxed/simple;
	bh=YYgRVQPoXLeg5GtRdYhoI2GMx2/4EwJ9HUOZBW6pSc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D7jEAzyhM2x4cqZ6SwyybHQk+CIjT6qcgWti6OsWJI2ckrax/wEz/REOprn5yxm8iTheJ4tWxVNgu/bTWZX6IEZawRsHEoxeg27e3SUo2FHAPkFsPrIbz4jWAmx9EyCPIdBDuyY3otya0shwdCP845BWt/UGLRsjijOOIYt52Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fnDRd5jzHzKHMYF;
	Fri,  3 Apr 2026 17:47:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 662BC4058C;
	Fri,  3 Apr 2026 17:48:50 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with SMTP id _Ch0CgAnB1TwjM9p8K_UDA--.49742S17;
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
Subject: [PATCH v2 15/16] perf annotate-arm64: Support per-cpu variable access tracking
Date: Fri,  3 Apr 2026 09:47:59 +0000
Message-Id: <20260403094800.1418825-16-wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgAnB1TwjM9p8K_UDA--.49742S17
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr1rWr45Wr1fJr4kWrWxZwb_yoWxKF4kp3
	95KFyUGrZ8trs3GwsaqFW3XryF9393Kas2krWY9w1akrW29r1UGa97KrWYgF4UGrykAw4x
	trn8tr43Xw4DKaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Extend update_insn_state() for arm64 to handle per-cpu variable
addressing.

On arm64, per-cpu variables are accessed by adding a per-cpu offset
(typically from the '__per_cpu_offset' array) to the global variable's
address. This logic often results in the following instruction pattern:

  adrp  x4, <page>
  add   x4, x4, #offset          // x4 = &__per_cpu_offset
  ldr   x6, [x4, w0, sxtw #3]    // x6 = __per_cpu_offset[cpu]
  ...
  adrp  x5, <page>
  add   x5, x5, #offset          // x5 = &global_var
  ldr   x0, [x6, x5]             // Pattern A: direct load per-cpu instance
  OR
  add   x0, x6, x5               // Pattern B: compute per-cpu addr

To handle such cases:

1. Identify per-cpu base initialization: Detect 'adrp/add' pairs that
   resolve to the '__per_cpu_offset' symbol and mark the destination
   register as TSR_KIND_PERCPU_BASE.
2. Propagate type information: During subsequent 'ldr' or 'add' steps,
   if one operand is a PERCPU_BASE and the other is a global variable,
   inherit the type from the global variable to correctly identify the
   per-cpu instance.

A real-world example is shown below:

  ffff8000808f2d28 <cppc_set_perf>:
  ffff8000808f2d38:  adrp  x2, ffff800082033000 <event_array+0x58>
  ffff8000808f2d3c:  add   x5, x2, #0x3f8         // x5 = &__per_cpu_offset
  ffff8000808f2d44:  adrp  x2, ffff800081f73000 <vmcore_cb_srcu_srcu_data+0x80>
  ffff8000808f2d48:  add   x2, x2, #0x6b8         // x2 = &cpu_pcc_subspace_idx
  ffff8000808f2d6c:  ldr   x5, [x5, w0, sxtw #3]  // x5 = __per_cpu_offset[cpu]
  ffff8000808f2d80:  ldr   w23, [x5, x2]          // PMU sample, per_cpu(cpu_pcc_subspace_idx, cpu)

Before this commit, the tracker could not link x5 back to a per-cpu
context, resulting in an incorrect data type resolution:

  adrp [10] global addr=ffff800082033000 -> reg2
  add [14] global addr=ffff8000820333f8 -> reg5
  adrp [1c] global addr=ffff800081f73000 -> reg2
  add [20] global addr=ffff800081f736b8 -> reg2
  ldr [44] global (ffff8000820333f8) -> reg5 type='long unsigned int[]' size=0x1000
  chk [58] reg5 offset=0 ok=1 kind=1 (long unsigned int[]) : Good!
  found by insn track: 0(reg5, reg2) type-offset=0
  final result:  type='long unsigned int' size=0x8

After this commit, the tracker correctly identifies the per-cpu flow and
resolves the actual variable type:

  ldr [44] global (ffff8000820333f8) -> reg5 percpu base
  chk [58] reg5 offset=0 ok=1 kind=2 percpu var : Good!
  found by insn track: 0(reg5, reg2) type-offset=0
  final result:  type='int' size=0x4

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 69 ++++++++++++++++++-
 tools/perf/util/annotate-data.c               | 33 ++++++---
 2 files changed, 92 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 6b954bbfaf8d..89b6b596f984 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -378,6 +378,26 @@ static void update_insn_state_arm64(struct type_state *state,
 
 			pr_debug_dtp("add [%x] global addr=%"PRIx64" -> reg%d\n",
 				     insn_offset, tsr->addr, sreg);
+			return;
+		}
+
+		/* Handle per-cpu base addresses */
+		if (dst_tsr.kind == TSR_KIND_PERCPU_BASE) {
+			if (!dst->multi_regs || !has_reg_type(state, dst->reg2) ||
+			    state->regs[dst->reg2].kind != TSR_KIND_GLOBAL_ADDR ||
+			    !state->regs[dst->reg2].ok)
+				return;
+
+			/* Inherit type from the global variable */
+			tsr->type = state->regs[dst->reg2].type;
+			tsr->kind = state->regs[dst->reg2].kind;
+			tsr->offset = state->regs[dst->reg2].offset;
+			tsr->addr = state->regs[dst->reg2].addr;
+			tsr->ok = true;
+
+			pr_debug_dtp("add [%x] percpu %#"PRIx64" -> reg%d",
+				     insn_offset, tsr->addr, sreg);
+			pr_debug_type_name(&tsr->type, tsr->kind);
 		}
 
 		return;
@@ -491,6 +511,15 @@ static void update_insn_state_arm64(struct type_state *state,
 			u64 ip = dloc->ms->sym->start + dl->al.offset;
 			u64 addr = dst_tsr.addr + dst->offset;
 			int offset;
+			u8 kind;
+			const char *var_name = NULL;
+
+			/* it might be per-cpu offset */
+			if (get_global_var_info(dloc, addr, &var_name, &offset) &&
+			    !strcmp(var_name, "__per_cpu_offset"))
+				kind = TSR_KIND_PERCPU_BASE;
+			else
+				kind = TSR_KIND_TYPE;
 
 			if (!get_global_var_type(cu_die, dloc, ip, addr, &offset,
 						 &type_die) ||
@@ -500,13 +529,49 @@ static void update_insn_state_arm64(struct type_state *state,
 			}
 
 			tsr->type = type_die;
-			tsr->kind = TSR_KIND_TYPE;
+			tsr->kind = kind;
 			tsr->offset = offset;
-			tsr->addr = addr;
+			tsr->addr = 0;
 			tsr->ok = true;
+
 			pr_debug_dtp("ldr [%x] global (%"PRIx64") -> reg%d",
 				     insn_offset, addr, sreg);
 			pr_debug_type_name(&tsr->type, tsr->kind);
+			return;
+		}
+
+		/* Or check if it's a per-cpu base address */
+		if (dst_tsr.kind == TSR_KIND_PERCPU_BASE) {
+			u64 ip = dloc->ms->sym->start + dl->al.offset;
+			u64 addr;
+			int offset;
+			/*
+			 * If reg2 is a global variable, this means reg1 is
+			 * an index into the variable's per-cpu array, so
+			 * dereference type from reg2.
+			 */
+			if (!dst->multi_regs || !has_reg_type(state, dst->reg2) ||
+			    state->regs[dst->reg2].kind != TSR_KIND_GLOBAL_ADDR ||
+			    !state->regs[dst->reg2].ok)
+				return;
+
+			addr = state->regs[dst->reg2].addr;
+			if (!get_global_var_type(cu_die, dloc, ip, addr, &offset,
+						 &type_die) ||
+			    !die_get_member_type(&type_die, offset, &type_die)) {
+				tsr->ok = false;
+				return;
+			}
+
+			tsr->type = type_die;
+			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = offset;
+			tsr->addr = 0;
+			tsr->ok = true;
+
+			pr_debug_dtp("ldr [%x] percpu (reg%d, reg%d) -> reg%d",
+				     insn_offset, dreg, dst->reg2, sreg);
+			pr_debug_type_name(&tsr->type, tsr->kind);
 		}
 		return;
 	}
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index b75d50b2c46f..7161417d1c76 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1230,20 +1230,37 @@ static enum type_match_result check_matching_type(struct type_state *state,
 	}
 
 	if (state->regs[reg].kind == TSR_KIND_PERCPU_BASE) {
-		u64 var_addr = dloc->op->offset;
+		u64 var_addr;
 		int var_offset;
 
 		pr_debug_dtp("percpu var");
 
-		if (dloc->op->multi_regs) {
-			int reg2 = dloc->op->reg2;
+		if (arch__is_arm64(dloc->arch)) {
+			int reg2;
 
-			if (dloc->op->reg2 == reg)
-				reg2 = dloc->op->reg1;
+			if (!dloc->op->multi_regs)
+				return PERF_TMR_BAIL_OUT;
 
-			if (has_reg_type(state, reg2) && state->regs[reg2].ok &&
-			    state->regs[reg2].kind == TSR_KIND_CONST)
-				var_addr += state->regs[reg2].imm_value;
+			reg2 = dloc->op->reg2;
+			if (!has_reg_type(state, reg2) ||
+			    state->regs[reg2].kind != TSR_KIND_GLOBAL_ADDR ||
+			    !state->regs[reg2].ok)
+				return PERF_TMR_BAIL_OUT;
+
+			var_addr = state->regs[reg2].addr;
+		} else {
+			var_addr = dloc->op->offset;
+
+			if (dloc->op->multi_regs) {
+				int reg2 = dloc->op->reg2;
+
+				if (dloc->op->reg2 == reg)
+					reg2 = dloc->op->reg1;
+
+				if (has_reg_type(state, reg2) && state->regs[reg2].ok &&
+				    state->regs[reg2].kind == TSR_KIND_CONST)
+					var_addr += state->regs[reg2].imm_value;
+			}
 		}
 
 		if (get_global_var_type(cu_die, dloc, dloc->ip, var_addr,
-- 
2.34.1

