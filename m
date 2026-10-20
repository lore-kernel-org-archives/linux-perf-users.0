Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503974;
	b=sxIrUAeS6ieuZ3k2kPk4PA91UsVdq3+DBk37E5d+cg46ptz8hog8Y4U3FMaazWKnKc1B
	 syucPippurBRJ2rweeLpcCBJxcTdpozYXiIakFx1MDMb7ZExEEnV4VwZIUbn/sC7fOXJ+
	 A9SAFwlcxEDvQt3xmt51lcV7UXDT15iJQ6VE9urAzCkwpfcqV5f/9ZGOLDpSUzA4YKCPH
	 FMuG34iqvy5JqLP5Kphq3axMVmWsNbOTJ6LDSkv12rsCSQko5nMF3NxUMV6OLzv3CrPd5
	 EYWDnmdFZi1kQWDfkWFtCTQDWuFKBYXtKUz0OsChcPI64GLnWUv9vMERbzL/eCGNviw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503974;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=WrrCHu9wlaQnBe+Zb5n/IWw+Av9wKsl6jUclsZ8b+IY=;
	b=t6yPOYXmE9eOpJPkExNtJn7PKX1KFY2PrE+dEHOmLBrZYOoEiX70yqo2gnFAgKJlLV9n
	 nu3TWQEvWTWNQf9ThNA8gGaoIbaYMvq+dbHqCeZrH6/6jM4xjnmlWowy6nwCRGLsyOuWb
	 Cp+WBciDy7ZoSJDfLXr1Tlfjun24cs1fMjwmlvv71YooP/OUCh4QuLWareAYUrmqvN+cJ
	 INlC5HHADvX8rWcAaNxN2nWtFrTVcfTNVxW6toVB9xUtdoUbLkO0QfiNrB9z2KMDkz9+P
	 Iwp7yq+2dZP1litW+7tyFyAzymMS3DFq9XdKM7R7EyZdvN9A6p8raN6wQg++daxnqXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.56
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E986260A382B;
	Tue, 20 Oct 2026 13:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E986260A382B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4j8DFn3Q13zKHMcJ;
	Tue, 20 Oct 2026 21:45:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 669DD40577;
	Tue, 20 Oct 2026 21:45:59 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB3QOaGcNdq8xegBA--.22174S16;
	Tue, 20 Oct 2026 21:45:59 +0800 (CST)
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
Subject: [PATCH v8 14/15] perf annotate-arm64: Support per-cpu variable access tracking
Date: Tue, 20 Oct 2026 13:45:10 +0000
Message-Id: <7ba30d22a8bd97b53b1536d1b3d7895290e7b72c.1792411435.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792411435.git.wutengda@huaweicloud.com>
References: <cover.1792411435.git.wutengda@huaweicloud.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB3QOaGcNdq8xegBA--.22174S16
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr15KrWDAw18Zr45CF13CFg_yoWxZw1Up3
	95KFy5Gr1vqr4a9ws3tr4UXryrua97Ga4vk34Ykw1a9ryIgw18G397KrW5KFWUGr9ay3W7
	tr9xtrWDXr1qkaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
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

And x5 holds the base address being offset, which can come from one of
two cases:

  Case 1: global variable
    adrp  x5, <page>
    add   x5, x5, #offset        // x5 = &global_var

  Case 2: '__percpu' field embedded in a structure
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

Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 25 ++++++++++++-
 tools/perf/util/annotate-data.c               | 36 +++++++++++++++----
 2 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index bd060a823b76..270f35876511 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -12,6 +12,7 @@
 #include "../disasm.h"
 #include "../annotate-data.h"
 #include "../debug.h"
+#include "../dso.h"
 #include "../map.h"
 #include "../symbol.h"
 
@@ -727,13 +728,23 @@ static int propagate_load_reg_state(struct type_state *state,
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
@@ -749,6 +760,12 @@ static int propagate_load_reg_state(struct type_state *state,
 		return 0;
 	}
 
+	/*
+	 * If src_tsr->kind is TSR_KIND_PERCPU_BASE, treat it as an array.
+	 * No special handling is needed here; just fall through to retry
+	 * and resolve the type from the second register.
+	 */
+
 load_non_regoff:
 	/* Try another register if any */
 	if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2 &&
@@ -1046,6 +1063,12 @@ static void update_add_insn_state(struct type_state *state,
 		return;
 	}
 
+	/*
+	 * If src_tsr->kind is TSR_KIND_PERCPU_BASE, treat it as an array.
+	 * No special handling is needed here; just fall through to retry
+	 * and resolve the type from the second register.
+	 */
+
 add_non_regoff:
 	/* Try another register if any */
 	if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2 &&
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 43cd09c0662a..b3de1ca688a2 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1307,13 +1307,17 @@ int arch_get_reg_offset(const struct arch *arch, struct annotated_op_loc *op_loc
 
 		/*
 		 * For register-based addressing without shift/extension,
-		 * reg2 may be a constant offset. Use its value as the offset
-		 * from the base register.
+		 * derive the offset from the type of reg2.
 		 */
 		reg2 = op_loc->reg1 == breg ? op_loc->reg2 : op_loc->reg1;
-		if (has_reg_type(state, reg2) && state->regs[reg2].ok &&
-			state->regs[reg2].kind == TSR_KIND_CONST) {
-			*offset = (s64)state->regs[reg2].imm_value;
+		if (has_reg_type(state, reg2) && state->regs[reg2].ok) {
+			if (state->regs[reg2].kind == TSR_KIND_CONST)
+				*offset = (s64)state->regs[reg2].imm_value;
+			else if (state->regs[reg2].kind == TSR_KIND_PERCPU_BASE)
+				*offset = 0;  /* it does not contribute to the offset */
+			else
+				return -1;
+
 			return 0;
 		}
 
@@ -1448,11 +1452,31 @@ static enum type_match_result check_matching_type(struct type_state *state,
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

