Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67F03AAF74;
	Wed, 16 Sep 2026 01:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522252; cv=none; b=CptlbR4Wk1uHamxioh4/nTL54vNGjY9ZZAn1v9vWJkMY0hPoWDQ50Hb4zEr/Euy90d4jhjRnPVQxPf6Guq8TzJQWTa/V/u0Lb5EVvL0WEqx3iL2RYoMT+ksqEuapjufdtSBxfiLi5RjTNYCYdFYhxv6ITKdwjS6itw5uLDEr/3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522252; c=relaxed/simple;
	bh=T40kEutOn8ITViARUJiEcJEfzEa0SOgxcP+gjzasNto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YL35MYsOhtWNAsUBj1i2NpXGHhGR6qyY5ZFOkMxaIkoOk9lCJfnTy1LVGEKGX0mX6CqKT+XWRF3Bz0sv2TyxCqntIZysfLpRBG8TLhNxwYo8rFK2JkFBHStbBMaV45bStxPVBhN1acce9J/GjQO2cAOr1fMNP6Ybk+Yq4kWcmgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hl1Y41D1zzKHMQm;
	Wed, 16 Sep 2026 09:30:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C7A694056F;
	Wed, 16 Sep 2026 09:30:45 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgBHwPo_8alqshDTAQ--.7335S3;
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
Subject: [PATCH v6 25/26] perf annotate-arm64: Support per-cpu variable access tracking
Date: Wed, 16 Sep 2026 01:30:17 +0000
Message-Id: <735c23b4a55db2c67be4920792922550ff4f6409.1789521520.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHwPo_8alqshDTAQ--.7335S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr15KrWDAF15Cr4ftw4UCFg_yoWxAr1xp3
	95Kry5W34vqrsrWws3tFW5XryF9a93Jas2k34Y9w1a9r1xKr1UG397KrW5tF4UGFnay3W7
	tr9xtrZrXrnFkaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
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
	xVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0pROJ5rUUUUU=
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
index b25a3c70675c..f4b7b0eb44f4 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -12,6 +12,7 @@
 #include "../disasm.h"
 #include "../annotate-data.h"
 #include "../debug.h"
+#include "../dso.h"
 #include "../map.h"
 #include "../symbol.h"
 
@@ -643,13 +644,23 @@ static int propagate_load_reg_state(struct type_state *state,
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
@@ -666,6 +677,12 @@ static int propagate_load_reg_state(struct type_state *state,
 	}
 
 load_non_regoff:
+	/*
+	 * If src_tsr->kind is TSR_KIND_PERCPU_BASE, treat it as an array.
+	 * No special handling is needed here; just fall through to retry
+	 * and resolve the type from the second register.
+	 */
+
 	/* Try another register if any */
 	if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2 &&
 	    !(src->extend_type || src->shift_type)) {
@@ -967,6 +984,34 @@ static void update_add_insn_state(struct type_state *state,
 	}
 
 add_non_regoff:
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
 	/* Try another register if any */
 	if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2 &&
 	    !(src->extend_type || src->shift_type)) {
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 592ad8b1bc96..a2434b978ec7 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1342,11 +1342,31 @@ static enum type_match_result check_matching_type(struct type_state *state,
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

