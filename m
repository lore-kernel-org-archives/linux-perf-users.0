Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FAD282F31;
	Wed,  1 Jul 2026 03:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878093; cv=none; b=FCBA0OYRmV0H8bz/rQ0PbFMiI2BjJrqTIW7V7HsCG1IwozPeH2u3hs39iYSfREnWkbmHswgZZB6Zr1ciwqXUSRIRvZ2p4RHebhmyXDP1YgBdQu3nFS8W59feuWkPIDJse4g9YOVcOAF/6GTdrfpLx5dfVVdjTRU2KjyGCMk5Vrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878093; c=relaxed/simple;
	bh=BDhjaAxeAwFqbrEb71d1HQqBeTuvZqsog164jWRx6mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KBAXphXI7OTWxzPipzPKcTegX2TRSi1WTbhxvS+ywBLHAfCGWOAYKZ/84WO82CeVk8HJSbkRO9KtdgBMSKqLptw7Hvli4Cl3Hha2l/GRSkqDq8b0SwvJip+mu7ZPPLs0Gq8QSNh4TUvSCyAJNAIk9C7B5ApBImz6OTu9bK8fVz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gqmMz4DK7zYQtn6;
	Wed,  1 Jul 2026 11:53:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 70A7040ABD;
	Wed,  1 Jul 2026 11:54:45 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBXiyWAj0RqCne9AQ--.26189S7;
	Wed, 01 Jul 2026 11:54:45 +0800 (CST)
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
Subject: [PATCH v3 05/21] perf annotate-arm64: Handle load and store instructions
Date: Wed,  1 Jul 2026 03:53:39 +0000
Message-Id: <20260701035355.752944-6-wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgBXiyWAj0RqCne9AQ--.26189S7
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4rXr1rZFWfGw1xGrWkXrb_yoW7Cryrpa
	92k345tr42qr4rW3WfJF4kX34fGa1rJw43tryxJws3CayYvryktFn5Kw12kFs8Gr95uw4Y
	qFn0yry0vF98A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6x
	kF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0piPkusUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Add ldst_ops to handle load and store instructions in order to parse
the data types and offsets associated with PMU events for memory access
instructions. There are many variants of load and store instructions in
ARM64, making it difficult to match all of these instruction names
completely. Therefore, only the instruction prefixes are matched. The
prefix 'ld|st' covers most of the memory access instructions, 'cas|swp'
matches atomic instructions, and 'prf' matches memory prefetch
instructions.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index a1667237114a..451500def8c1 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -14,6 +14,7 @@ struct arch_arm64 {
 	struct arch arch;
 	regex_t call_insn;
 	regex_t jump_insn;
+	regex_t ldst_insn; /* load and store instruction */
 };
 
 static bool arm64__is_reg(const char *op)
@@ -141,6 +142,104 @@ static const struct ins_ops arm64_mov_ops = {
 	.scnprintf = arm64_mov__scnprintf,
 };
 
+static bool arm64__insn_is_source_first(struct disasm_line *dl)
+{
+	/*
+	 * Store instructions invert the standard syntax by placing the source
+	 * register before the destination memory address.
+	 */
+	return !strncmp(dl->ins.name, "st", 2);
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
+ * Parsing strategy:
+ * Use the '[' bracket as the boundary to split the operands into left
+ * and right sides. For non-store instructions, the left side is the
+ * target and the right side is the source. For store instructions, the
+ * roles are reversed.
+ */
+static int arm64_ldst__parse(const struct arch *arch,
+			     struct ins_operands *ops,
+			     struct map_symbol *ms __maybe_unused,
+			     struct disasm_line *dl)
+{
+	char *s, *left, *right;
+
+	right = s = strchr(ops->raw, arch->objdump.memory_ref_char);
+	if (!s)
+		return -1;
+
+	while (s > ops->raw && *s != ',')
+		--s;
+
+	if (s == ops->raw)
+		return -1;
+
+	*s = '\0';
+	left = strdup(ops->raw);
+
+	*s = ',';
+	if (!left)
+		return -1;
+
+	right = strdup(right);
+	if (!right) {
+		zfree(&left);
+		return -1;
+	}
+
+	if (arm64__insn_is_source_first(dl)) {
+		ops->source.raw = left;
+		ops->source.mem_ref = false;
+
+		ops->target.raw = right;
+		ops->target.mem_ref = true;
+		ops->target.multi_regs = arm64__check_multi_regs(arch, ops->target.raw);
+	} else {
+		ops->source.raw = right;
+		ops->source.mem_ref = true;
+		ops->source.multi_regs = arm64__check_multi_regs(arch, ops->source.raw);
+
+		ops->target.raw = left;
+		ops->target.mem_ref = false;
+	}
+
+	return 0;
+}
+
+static struct ins_ops arm64_ldst_ops = {
+	.parse	   = arm64_ldst__parse,
+};
+
 static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const char *name)
 {
 	struct arch_arm64 *arm = container_of(arch, struct arch_arm64, arch);
@@ -151,6 +250,8 @@ static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch,
 		ops = &jump_ops;
 	else if (!regexec(&arm->call_insn, name, 2, match, 0))
 		ops = &call_ops;
+	else if (!regexec(&arm->ldst_insn, name, 2, match, 0))
+		ops = &arm64_ldst_ops;
 	else if (!strcmp(name, "ret"))
 		ops = &ret_ops;
 	else
@@ -175,6 +276,8 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 	arch->id = *id;
 	arch->objdump.comment_char	  = '/';
 	arch->objdump.skip_functions_char = '+';
+	arch->objdump.memory_ref_char	  = '[';
+	arch->objdump.imm_char		  = '#';
 	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
 
 	/* bl, blr */
@@ -188,8 +291,20 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
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

