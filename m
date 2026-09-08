Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898075476DD;
	Tue,  8 Sep 2026 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872547; cv=none; b=kI9oipWtGK5hsopkQDurjulU/jTRIfMK0OawN+O+Rp+Ea1dC2+xZVF1tNUBP1tiM+zsEsKP4YiG0yZgGtgsD3wEmutfflDXpw6ackcRceXCLu0EVZ5fA9UPu3c374CluKPa0wAtmPXDWiFCVAO/INXxHJU3/C4Ke6goIPmCc/e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872547; c=relaxed/simple;
	bh=1bXA1nM5G4aqYlvvbGGSrTGVguxKNxLbbeNYtScRjNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XM/vjhuiPmXtFTkxbKJ23b3l9jFNz7lu1d3/k/q1jOlcLJn9Yk6Dcn8XDiGu3cfR9RaPqgQqHEClkApNOWqDHjvkDNvZeKi4JF4d7aM99PcrPNeX4xUqPoP7OFKeoARWL7bHLSsQHo9sSe4J7jr07gzLt6LcYL7o0/G2aGtPRDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfPFX1ttQzYQvWX;
	Tue,  8 Sep 2026 21:01:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BF3954057A;
	Tue,  8 Sep 2026 21:01:55 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAni5gpB6BqC9rlBA--.34632S25;
	Tue, 08 Sep 2026 21:01:55 +0800 (CST)
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
Subject: [PATCH v5 23/26] perf annotate-arm64: Support 'add' instruction tracking
Date: Tue,  8 Sep 2026 13:01:19 +0000
Message-Id: <20260908130122.633500-24-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908130122.633500-1-wutengda@huaweicloud.com>
References: <20260908130122.633500-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAni5gpB6BqC9rlBA--.34632S25
X-Coremail-Antispam: 1UD129KBjvJXoWxXw15Xw1fJw1UJrWkurWruFg_yoWrtr4kpF
	ZFk34UWws2yrsFgrs3JFWfXr9akwsrGr1jkr98XwsayFW3trn5Ka93KrW2vFW5Gr93Cw13
	tw4DKrs3Xw42kaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY
	1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7sR_hiSJUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state_arm64() to track 'add' instructions for
structure member address calculation.

Unlike x86, the arm64 'add' instruction has an extra base register among
its source operands. Therefore, in terms of propagating the data type,
it is essentially performing a 'mov', except that before the 'mov', it
first needs to be updated by adding the offset or reg2.

A real-world example is shown below:

  ffff80008001c9a8 <flush_ptrace_hw_breakpoint>:
  ffff80008001c9c4:  add  x19, x0, #0xeb8   // x0 (task_struct*) + 0xeb8 -> x19
* ffff80008001c9d0:  ldr  x0, [x19]

Before this commit, the type flow broke at the 'add' instruction,
leaving the subsequent load with no type information:

  chk [28] reg19 offset=0 ok=0 kind=0 cfa : no type information
  final result: no type information

After this commit, the tracker correctly follows the member address
calculation:

  var [0] reg0 offset 0 type='struct task_struct*'
  add [1c] address of 0xeb8(reg0) -> reg19 type='struct task_struct*'
  chk [28] reg19 offset=0 ok=1 kind=1 (struct task_struct*) : Good!
  found by insn track: 0(reg19) type-offset=0xeb8
  final result: type='struct task_struct'

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 72 ++++++++++++++++++-
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 2f8bedf583c1..e237b9142684 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -864,6 +864,72 @@ static void update_mov_insn_state(struct type_state *state,
 	pr_debug_type_name(&tsr->type, tsr->kind);
 }
 
+static void update_add_insn_state(struct type_state *state,
+				  struct data_loc_info *dloc,
+				  struct disasm_line *dl,
+				  struct annotated_op_loc *src,
+				  struct annotated_op_loc *dst)
+{
+	struct type_state_reg *tsr;
+	struct type_state_reg src_tsr;
+	u32 insn_offset = dl->al.offset;
+	int sreg = src->reg1;
+	int dreg = dst->reg1;
+	int reg_offset;
+
+	if (!has_reg_type(state, dreg))
+		return;
+
+	tsr = &state->regs[dreg];
+	tsr->copied_from = -1;
+
+retry:
+	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
+		invalidate_reg_state(tsr);
+		return;
+	}
+
+	src_tsr = state->regs[sreg];
+
+	if (arch_get_reg_offset(dloc->arch, src, sreg, state, false, &reg_offset))
+		goto try_other_reg;
+
+	if (src_tsr.kind == TSR_KIND_CONST) {
+		tsr->kind = src_tsr.kind;
+		tsr->imm_value = src_tsr.imm_value + reg_offset;
+		tsr->offset = 0;
+		tsr->ok = src_tsr.ok;
+
+		pr_debug_dtp("add [%x] imm %#x(reg%d) -> reg%d\n",
+			     insn_offset, reg_offset, sreg, dreg);
+		return;
+	}
+
+	if (src_tsr.kind == TSR_KIND_POINTER ||
+	    (src_tsr.kind == TSR_KIND_TYPE &&
+	     dwarf_tag(&src_tsr.type) == DW_TAG_pointer_type)) {
+		tsr->type = src_tsr.type;
+		tsr->kind = src_tsr.kind;
+		tsr->imm_value = src_tsr.imm_value;
+		tsr->offset = src_tsr.offset + reg_offset;
+		tsr->ok = src_tsr.ok;
+
+		pr_debug_dtp("add [%x] address of %#x(reg%d) -> reg%d",
+			     insn_offset, reg_offset, sreg, dreg);
+		pr_debug_type_name(&tsr->type, tsr->kind);
+		return;
+	}
+
+try_other_reg:
+	/* Try another register if any */
+	if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2 &&
+	    !(src->extend_type || src->shift_type)) {
+		sreg = src->reg2;
+		goto retry;
+	}
+	invalidate_reg_state(tsr);
+}
+
 static void update_insn_state_arm64(struct type_state *state,
 				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
@@ -930,7 +996,7 @@ static void update_insn_state_arm64(struct type_state *state,
 	 * prevent stale type info from propagating to subsequent instructions.
 	 */
 	if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
-	    strcmp(dl->ins.name, "mov") &&
+	    strcmp(dl->ins.name, "add") && strcmp(dl->ins.name, "mov") &&
 	    !is_standard_load_insn(dl->ins.name)) {
 		pr_debug_dtp("%s [%x] invalidate reg%d",
 			     dl->ins.name, insn_offset, dst->reg1);
@@ -943,8 +1009,10 @@ static void update_insn_state_arm64(struct type_state *state,
 		return;
 	}
 
+	if (!strcmp(dl->ins.name, "add"))
+		update_add_insn_state(state, dloc, dl, src, dst);
 	/* Register to register or imm value to register transfers */
-	if (!strcmp(dl->ins.name, "mov"))
+	else if (!strcmp(dl->ins.name, "mov"))
 		update_mov_insn_state(state, dl, src, dst);
 	/* Memory to register transfers */
 	else if (is_standard_load_insn(dl->ins.name))
-- 
2.34.1

