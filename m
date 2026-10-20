Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503974;
	b=p2tAi1zNzfkY/hLvu6UJwvSt1Y8ml+vuXs9TU7U/fmuLf9TpiEG0vqQ+oIeZAt6n3SiK
	 6vYprzetI3ll4HSXtdGzVdCeT3qH3zOTT9/B6grcQGBucZfI8yxWBpk5dCn+QYQmOZjWa
	 zCO3VkIFmXDHxudVwsV9dnWLde4K1oI0SCiFujWyTm0/g2XVlx4Y1gohtD7IWn+eBlDip
	 P5Blt2p9XAyJZLnHJ7cg9FzxmI0M0bPKgmI+XHi4l9AovPW6pRmCtOfa2XL9fGZ4mcyw5
	 US2sDxEKqroxP+2jQokjCsXDLmgAZ6pqBLm7uZADNrb0+Tm0Up5BSvuYDjIGtk9JaMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503974;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=pJb9O1ttqrpY6ZY6ytezjVnemP1lnFwe1IE4T3Lsp88=;
	b=yfvGaedx2ozjxXIMv/vxNTCnsskCFcHl9LPY2tMF0xSnlOVdt2KN3aieTN5J+Gu+y9Lb
	 YvcdXeKDCwdH5fmFZVr/MH0oIeoE1t4TpYK7a8VQmd8I/NoJDYdfHfgNKFvvkaQYdGu+6
	 Lxw84XtIH/pTq2TYDb1rIkBJaS5PbCWrpl18mLdnzKZ/OnPUEzAhwqzJHtgbcVXSWn8Sy
	 HyM7t8JmR68v6HO50OfMq3dDY+WKg08U0nDPyAxnLx63e7THpBeKhFF6Z4KAuq8Ci1q+4
	 U/uX91z07m/VqMrYbrnoOa/wArnLCnnzdC/28gM6zLPAIVmQhdefyV+mhfWrQHtOemQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.51
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AAA60A2608;
	Tue, 20 Oct 2026 13:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3AAA60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j8DFx1ddpzYQtwx;
	Tue, 20 Oct 2026 21:45:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3C55040576;
	Tue, 20 Oct 2026 21:45:59 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB3QOaGcNdq8xegBA--.22174S15;
	Tue, 20 Oct 2026 21:45:58 +0800 (CST)
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
Subject: [PATCH v8 13/15] perf annotate-arm64: Support 'adrp' instruction to track global variables
Date: Tue, 20 Oct 2026 13:45:09 +0000
Message-Id: <145ac934f72c090987c2e6d0be28b28972f843c7.1792411435.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgB3QOaGcNdq8xegBA--.22174S15
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4UZr1xXrWfGr13CF17ZFb_yoWftw15pF
	yDC34UWw47Ar4Sgrs3JFWUXr9a9ws7Ga4j9ryqywsayFy7trn3GayktFWaqF45GF95Zw13
	Jw1qkr4DXw42kaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Extend update_insn_state_arm64() to track global variable types
calculated via page-relative addressing.

On arm64, global variables are typically accessed by first calculating
the page address using 'adrp', followed by an 'add' or 'ldr' to get the
specific symbol address. Without tracking 'adrp', the instruction
tracker loses the base address, making it impossible to resolve
global symbols and their associated DWARF types.

Introduce TSR_KIND_GLOBAL_ADDR to represent a partial global address
state. When encountering 'adrp', store the page-aligned target address
in the register's type state. Upon a subsequent 'add' or 'ldr'
instruction that references a TSR_KIND_GLOBAL_ADDR register, combine
the page address with the immediate offset.

A real-world example is shown below:

  ffff80008032e008 <folios_put_refs>:
  ffff80008032e048:  adrp  x24, ffff80008202f000 <nr_cpu_ids>
  ffff80008032e050:  add   x24, x24, #0xd40
* ffff80008032e078:  ldr   x0, [x24]

Before this commit, x24 was unknown, leading to no type information:

  chk [70] reg24 offset=0 ok=0 kind=0 cfa : no type information
  final result: no type information

After this commit, the tracker correctly follows the adrp/add flow:

  adrp [40] global addr=0xffff80008202f000 -> reg24
  add [48] global 0xd40(reg24) -> reg24
  chk [70] reg24 offset=0 ok=1 kind=7 global addr : Good!
  final result: type='struct folio*'

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 82 +++++++++++++++++--
 tools/perf/util/annotate-data.c               | 25 +++++-
 tools/perf/util/annotate-data.h               |  1 +
 3 files changed, 99 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 61df9c4f4877..bd060a823b76 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -613,7 +613,7 @@ static bool is_standard_load_insn(const char *name)
  * which is added to the reg offset.
  */
 static int propagate_load_reg_state(struct type_state *state,
-				    struct data_loc_info *dloc,
+				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl, int dreg,
 				    struct annotated_op_loc *src,
 				    struct type_state_reg **src_states,
@@ -722,6 +722,33 @@ static int propagate_load_reg_state(struct type_state *state,
 		return 0;
 	}
 
+	/* Or check if it's a global variable */
+	if (src_tsr->kind == TSR_KIND_GLOBAL_ADDR) {
+		u64 ip = dloc->ms->sym->start + dl->al.offset;
+		u64 addr = src_tsr->imm_value + reg_offset;
+		int offset;
+
+		if (!get_global_var_type(cu_die, dloc, ip, addr, &offset, &type_die) ||
+		    !die_get_member_type(&type_die, offset, &type_die))
+			return -1;
+
+		tsr->type = type_die;
+		tsr->kind = TSR_KIND_TYPE;
+		tsr->offset = 0;
+		tsr->imm_value = 0;
+		tsr->ok = true;
+
+		if (src->multi_regs) {
+			pr_debug_dtp("%s [%x] global (reg%d, reg%d) -> reg%d",
+				     dl->ins.name, insn_offset, src->reg1, src->reg2, dreg);
+		} else {
+			pr_debug_dtp("%s [%x] global (reg%d) -> reg%d",
+				     dl->ins.name, insn_offset, sreg, dreg);
+		}
+		pr_debug_type_name(&tsr->type, tsr->kind);
+		return 0;
+	}
+
 load_non_regoff:
 	/* Try another register if any */
 	if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2 &&
@@ -735,7 +762,7 @@ static int propagate_load_reg_state(struct type_state *state,
 }
 
 static void update_load_insn_state(struct type_state *state,
-				   struct data_loc_info *dloc,
+				   struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				   struct disasm_line *dl,
 				   struct annotated_op_loc *src,
 				   struct annotated_op_loc *dst)
@@ -769,7 +796,7 @@ static void update_load_insn_state(struct type_state *state,
 
 	/* Handle the first destination register */
 	if (has_reg_type(state, dst->reg1)) {
-		if (propagate_load_reg_state(state, dloc, dl, dst->reg1,
+		if (propagate_load_reg_state(state, dloc, cu_die, dl, dst->reg1,
 					     src, src_states, mem_spacing))
 			invalidate_reg_state(&state->regs[dst->reg1]);
 	}
@@ -784,7 +811,7 @@ static void update_load_insn_state(struct type_state *state,
 		mem_spacing = arm64__reg_size(dl->ops.target.raw);
 
 	if (mem_spacing < 0 ||
-	    propagate_load_reg_state(state, dloc, dl, dst->reg2,
+	    propagate_load_reg_state(state, dloc, cu_die, dl, dst->reg2,
 				     src, src_states, mem_spacing))
 		invalidate_reg_state(&state->regs[dst->reg2]);
 
@@ -991,14 +1018,16 @@ static void update_add_insn_state(struct type_state *state,
 	if (arch_get_reg_offset(dloc->arch, src, sreg, state, false, &reg_offset))
 		goto add_non_regoff;
 
-	if (src_tsr.kind == TSR_KIND_CONST) {
+	if (src_tsr.kind == TSR_KIND_CONST || src_tsr.kind == TSR_KIND_GLOBAL_ADDR) {
 		tsr->kind = src_tsr.kind;
+		/* For 'adrp + add' pair: resolve the full global variable address. */
 		tsr->imm_value = src_tsr.imm_value + reg_offset;
 		tsr->offset = 0;
 		tsr->ok = src_tsr.ok;
 
-		pr_debug_dtp("add [%x] imm %#x(reg%d) -> reg%d\n",
-			     insn_offset, reg_offset, sreg, dreg);
+		pr_debug_dtp("add [%x] %s %#x(reg%d) -> reg%d\n",
+			     insn_offset, src_tsr.kind == TSR_KIND_CONST ?
+			     "imm" : "global", reg_offset, sreg, dreg);
 		return;
 	}
 
@@ -1027,6 +1056,41 @@ static void update_add_insn_state(struct type_state *state,
 	invalidate_reg_state(tsr);
 }
 
+static void update_adrp_insn_state(struct type_state *state,
+				   struct disasm_line *dl,
+				   struct annotated_op_loc *dst)
+{
+	struct type_state_reg *tsr;
+	u32 insn_offset = dl->al.offset;
+	int dreg = dst->reg1;
+
+	if (!has_reg_type(state, dreg))
+		return;
+
+	tsr = &state->regs[dreg];
+	tsr->copied_from = -1;
+
+	if (!dl->ops.source.addr) {
+		invalidate_reg_state(tsr);
+		return;
+	}
+
+	tsr->kind = TSR_KIND_GLOBAL_ADDR;
+	/*
+	 * Stores a partial page-relative address. The full absolute address
+	 * of the global variable will be resolved when a subsequent 'add' or
+	 * 'ldr' instruction consumes this register.
+	 */
+	tsr->imm_value = dl->ops.source.addr;
+	tsr->offset = 0;
+	tsr->lifetime_active = false;
+	tsr->lifetime_end = 0;
+	tsr->ok = true;
+
+	pr_debug_dtp("adrp [%x] global addr=%#"PRIx64" -> reg%d\n",
+		     insn_offset, tsr->imm_value, dreg);
+}
+
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
@@ -1043,6 +1107,8 @@ static void update_insn_state_arm64(struct type_state *state,
 
 	if (ins__is_call(&dl->ins))
 		update_call_insn_state(state, dloc, cu_die, dl);
+	else if (!strcmp(dl->ins.name, "adrp"))
+		update_adrp_insn_state(state, dl, dst);
 	else if (!strcmp(dl->ins.name, "add"))
 		update_add_insn_state(state, dloc, dl, src, dst);
 	/* Register to register or imm value to register transfers */
@@ -1050,7 +1116,7 @@ static void update_insn_state_arm64(struct type_state *state,
 		update_mov_insn_state(state, dl, src, dst);
 	/* Memory to register transfers */
 	else if (is_standard_load_insn(dl->ins.name))
-		update_load_insn_state(state, dloc, dl, src, dst);
+		update_load_insn_state(state, dloc, cu_die, dl, src, dst);
 	/* Register to memory transfers */
 	else if (is_standard_store_insn(dl->ins.name))
 		update_store_insn_state(state, dloc, dl, src, dst);
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 1d47db3a9dd9..43cd09c0662a 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -71,6 +71,9 @@ void pr_debug_type_name(Dwarf_Die *die, enum type_state_kind kind)
 	case TSR_KIND_CANARY:
 		pr_info(" stack canary\n");
 		return;
+	case TSR_KIND_GLOBAL_ADDR:
+		pr_info(" global address\n");
+		return;
 	case TSR_KIND_TYPE:
 	default:
 		break;
@@ -723,7 +726,8 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 	stack->kind = kind;
 	stack->imm_value = imm_value;
 
-	if (kind == TSR_KIND_POINTER || kind == TSR_KIND_CONST) {
+	if (kind == TSR_KIND_POINTER || kind == TSR_KIND_CONST ||
+	    kind == TSR_KIND_GLOBAL_ADDR) {
 		stack->compound = false;
 		return;
 	}
@@ -1474,6 +1478,25 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		if (offset < 0 && reg != state->stack_reg && reg != dloc->fbreg)
 			goto check_kernel;
 	}
+
+	if (state->regs[reg].kind == TSR_KIND_GLOBAL_ADDR) {
+		u64 var_addr = state->regs[reg].imm_value + offset;
+		int var_offset;
+
+		pr_debug_dtp("global addr");
+
+		/*
+		 * The register holds the address of a global variable. Try to
+		 * find the variable by the address and get its type.
+		 */
+		if (get_global_var_type(cu_die, dloc, dloc->ip, var_addr,
+					&var_offset, type_die)) {
+			dloc->type_offset = var_offset;
+			return PERF_TMR_OK;
+		}
+		/* No need to retry global variables */
+		return PERF_TMR_BAIL_OUT;
+	}
 check_non_register:
 	if (reg == dloc->fbreg || reg == state->stack_reg) {
 		struct type_state_stack *stack;
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 425d9ddfad41..eee1f8dae3dc 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -37,6 +37,7 @@ enum type_state_kind {
 	TSR_KIND_PERCPU_POINTER,
 	TSR_KIND_POINTER,
 	TSR_KIND_CANARY,
+	TSR_KIND_GLOBAL_ADDR,
 };
 
 /**
-- 
2.34.1

