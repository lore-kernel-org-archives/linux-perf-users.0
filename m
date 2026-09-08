Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1A4548544;
	Tue,  8 Sep 2026 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872526; cv=none; b=BUg05fZ/tgls/hCMlM2xeDd6cest4ru/fuhkhZTYQgstXyc9dLO+F74isadbV1cntIHQWnHYiVZgcVaGOiCnmXSJoQD2PHiibYbVaAhqRKne3bYft8MpI4SUbF90YMQTpySaQQBWmHiiJM7+v211gN8wwrKyXAjqWsi9S1v2G1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872526; c=relaxed/simple;
	bh=efqjTQ6fiQEz2JqGP5+95IdE1vOOyS2YwBR2iBhI5c0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hvXGceGQRYVVirxwyp+M58PVFUnC4jav3MgLu4cYkLSXFRNKcHrU0L2lJ1FZYRSqDaPpUkEI97iwfCiyk+CY2YLYvfPlEFLPknJwqOijH7PP4QVj9gpvHb8F9HlGHdm4HtinoqXXiPBtgyXbzgWfzKtJDZ7qrIeCVv5tL/zvFS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfPFT73pfzYQvSP;
	Tue,  8 Sep 2026 21:01:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7E73C4057A;
	Tue,  8 Sep 2026 21:01:53 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAni5gpB6BqC9rlBA--.34632S6;
	Tue, 08 Sep 2026 21:01:53 +0800 (CST)
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
Subject: [PATCH v5 04/26] perf annotate-arm64: Handle load and store instructions
Date: Tue,  8 Sep 2026 13:01:00 +0000
Message-Id: <20260908130122.633500-5-wutengda@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAni5gpB6BqC9rlBA--.34632S6
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4rXr15Xr4xurW5Gry7GFg_yoWxXrWfpa
	92k345tr42qr4rW3WftF4kZ34fGa18Ja4a9ry8Jwn3Ca1avryxtFn5Kr12kFs8Grykur43
	XFn0vry0vF98A3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRGMKuUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Add ldst_ops to handle load and store instructions in order to parse
the data types and offsets associated with PMU events for memory access
instructions. There are many variants of load and store instructions in
arm64, making it difficult to match all of these instruction names
completely. Therefore, only the instruction prefixes are matched. The
prefix 'ld|st' covers most of the memory access instructions, 'cas|swp'
matches atomic instructions, and 'prf' matches memory prefetch
instructions.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 140 ++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 151184210691..a7595a954cfa 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -14,6 +14,7 @@ struct arch_arm64 {
 	struct arch arch;
 	regex_t call_insn;
 	regex_t jump_insn;
+	regex_t ldst_insn; /* load and store instruction */
 };
 
 static bool arm64__is_reg(const char *op)
@@ -170,6 +171,130 @@ static const struct ins_ops arm64_mov_ops = {
 	.scnprintf = arm64_mov__scnprintf,
 };
 
+static bool arm64__insn_is_target_on_right(const char *ins_name)
+{
+	/*
+	 * Store instructions write to the memory operand on the right,
+	 * unlike standard syntax where the target is the left operand.
+	 */
+	return !strncmp(ins_name, "st", 2);
+}
+
+/*
+ * This function is used to parse arm64 load/store instructions into
+ * instruction operands.
+ *
+ * Typical instructions and their parsing logic:
+ *
+ * 1. Immediate offset:
+ *    ldr   x2, [x0]                -> target="x2", source="[x0]"
+ *    ldr   x2, [x0, #24]           -> target="x2", source="[x0, #24]"
+ *    ldp   x19, x20, [sp, #16]     -> target="x19, x20", source="[sp, #16]"
+ *
+ * 2. Pre-index addressing:
+ *    stp   x29, x30, [sp, #-64]!   -> target="[sp, #-64]!", source="x29, x30"
+ *
+ * 3. Post-index addressing:
+ *    str   x1, [x0], #8            -> target="[x0], #8", source="x1"
+ *    ldr   w1, [x21], #4           -> target="w1", source="[x21], #4"
+ *    ldp   x29, x30, [sp], #32     -> target="x29, x30", source="[sp], #32"
+ *
+ * 4. Register offset / extension:
+ *    ldr   x0, [x1, w0, sxtw #3]   -> target="x0", source="[x1, w0, sxtw #3]"
+ *    ldr   x0, [x1, x0, lsl #3]    -> target="x0", source="[x1, x0, lsl #3]"
+ *
+ * 5. Atomic operations:
+ *    cas   w3, w1, [x0]            -> target="w3, w1", source="[x0]"
+ *    swp   x3, x0, [x2]            -> target="x3, x0", source="[x2]"
+ *
+ * 6. Prefetch memory:
+ *    prfm  pstl1strm, [x4]         -> target="pstl1strm", source="[x4]"
+ *
+ * 7. PC-relative loads (No bracket found):
+ *    ldr   x0, ffff800080f40c68 <__kvm_nvhe_$d>  -> Fallback to default parser
+ *
+ * Parsing strategy:
+ * Use the '[' bracket as the boundary to split the operands into left
+ * and right sides. For non-store instructions, the left side is the
+ * target and the right side is the source. For store instructions, the
+ * roles are reversed.
+ */
+static int arm64_ldst__parse(const struct arch *arch, struct ins_operands *ops,
+			     struct map_symbol *ms, struct disasm_line *dl)
+{
+	char *raw, *s, *left, *right;
+	int ret = -1;
+
+	raw = rstrip_space_and_comment(ops->raw, arch->objdump.comment_char);
+	if (!raw)
+		return -1;
+
+	s = strchr(raw, arch->objdump.memory_ref_char);
+	if (!s) {
+		/* Fallback to default parser for PC-relative loads. */
+		free(raw);
+		return arm64_mov__parse(arch, ops, ms, dl);
+	}
+
+	right = strdup(s);
+	if (!right)
+		goto out_free_raw;
+
+	while (s > raw && *s != ',')
+		--s;
+
+	if (s == raw)
+		goto out_free_right;
+
+	*s = '\0';
+	left = strdup(raw);
+	*s = ',';
+	if (!left)
+		goto out_free_right;
+
+	free(raw);
+
+	if (arm64__insn_is_target_on_right(dl->ins.name)) {
+		ops->source.raw = left;
+		ops->source.mem_ref = false;
+
+		ops->target.raw = right;
+		ops->target.mem_ref = true;
+	} else {
+		ops->source.raw = right;
+		ops->source.mem_ref = true;
+
+		ops->target.raw = left;
+		ops->target.mem_ref = false;
+	}
+
+	ops->source.multi_regs = arm64__check_multi_regs(arch, ops->source.raw);
+	ops->target.multi_regs = arm64__check_multi_regs(arch, ops->target.raw);
+
+	return 0;
+
+out_free_right:
+	free(right);
+out_free_raw:
+	free(raw);
+	return ret;
+}
+
+static int arm64_ldst__scnprintf(const struct ins *ins, char *bf, size_t size,
+				 struct ins_operands *ops, int max_ins_name)
+{
+	if (arm64__insn_is_target_on_right(ins->name))
+		return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->raw);
+
+	return scnprintf(bf, size, "%-*s %s, %s", max_ins_name, ins->name,
+			 ops->target.raw, ops->source.name ?: ops->source.raw);
+}
+
+static struct ins_ops arm64_ldst_ops = {
+	.parse	   = arm64_ldst__parse,
+	.scnprintf = arm64_ldst__scnprintf,
+};
+
 static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const char *name)
 {
 	struct arch_arm64 *arm = container_of(arch, struct arch_arm64, arch);
@@ -180,6 +305,8 @@ static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch,
 		ops = &jump_ops;
 	else if (!regexec(&arm->call_insn, name, 2, match, 0))
 		ops = &call_ops;
+	else if (!regexec(&arm->ldst_insn, name, 2, match, 0))
+		ops = &arm64_ldst_ops;
 	else if (!strcmp(name, "ret"))
 		ops = &ret_ops;
 	else
@@ -205,6 +332,7 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 	arch->objdump.comment_char	  = '/';
 	arch->objdump.skip_functions_char = '+';
 	arch->objdump.memory_ref_char	  = '[';
+	arch->objdump.imm_char		  = '#';
 	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
 
 	/* bl, blr */
@@ -218,8 +346,20 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 	if (err)
 		goto out_free_call;
 
+	/*
+	 * The ARM64 architecture has many variants of load/store instructions.
+	 * It is quite challenging to match all of them completely. Here, we
+	 * only match the prefixes of these instructions.
+	 */
+	err = regcomp(&arm->ldst_insn, "^(ld|st|cas|prf|swp)",
+		      REG_EXTENDED);
+	if (err)
+		goto out_free_jump;
+
 	return arch;
 
+out_free_jump:
+	regfree(&arm->jump_insn);
 out_free_call:
 	regfree(&arm->call_insn);
 out_free_arm:
-- 
2.34.1

