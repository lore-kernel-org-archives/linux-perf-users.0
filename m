Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325AA3CCA15;
	Sat,  8 Aug 2026 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786191869; cv=none; b=XJN1BsnDnRqJ9Q5SLF2aFhumz0rT9b+cPk/sPl5kMMndqMoMqPJ+ikDXg7o7d8MMgqvjnPEsKSlSb42Uf0TBZTMnAPldjrrZSEFRreBhnIykKMZGhko77XWCCF3vvTXWKdeKw+XDYv5veROnjK9hQJpQqTdwfWYTRnQevkxSiqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786191869; c=relaxed/simple;
	bh=DIWPjGhgFL2oNitibJUYkj4dRBVK4sRIVlI7HhAotbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rVkAGr1UCH83HXvC3zlQ3vyoR0XTtGNbvdg6t2ZXPat7ufuprwI+dcx1CvVTDcA+CzK9NAZYkMr+PpM9pKOvy1KurKToA31d4jk8cOoXPa3F05tgSzK/JpYudNy+K8FK29RbDyTOcO/V5z+wt+FUgJ2pRHxrgNwfZbTjhmO9Y6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hHKtH3rr7zYQvbt;
	Sat,  8 Aug 2026 20:23:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B2EE6408D6;
	Sat,  8 Aug 2026 20:24:17 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB34YjkH3dqbrhMBg--.41805S6;
	Sat, 08 Aug 2026 20:24:17 +0800 (CST)
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
Subject: [PATCH v4 04/23] perf annotate-arm64: Handle load and store instructions
Date: Sat,  8 Aug 2026 12:23:41 +0000
Message-Id: <20260808122400.2961238-5-wutengda@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgB34YjkH3dqbrhMBg--.41805S6
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4rXr1xXFyxGF4DKr17Wrg_yoW7uF18pa
	s2k345tr42qr4rW3Z3JF4kXw1fGa18Jw43KryxJwn3C3yY9ry8tFn5Kw12kF45Gr95uw4a
	qFn0yry0vF98A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YV
	CY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRQYFCDUUUU
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
 .../perf/util/annotate-arch/annotate-arm64.c  | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 5e824fd617ee..32752a3bc756 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -14,6 +14,7 @@ struct arch_arm64 {
 	struct arch arch;
 	regex_t call_insn;
 	regex_t jump_insn;
+	regex_t ldst_insn; /* load and store instruction */
 };
 
 static bool arm64__is_reg(const char *op)
@@ -163,6 +164,108 @@ static const struct ins_ops arm64_mov_ops = {
 	.scnprintf = arm64_mov__scnprintf,
 };
 
+static bool arm64__insn_is_source_on_left(struct disasm_line *dl)
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
+ * 7. PC-relative loads (No bracket found):
+ *    ldr   x0, ffff800080f40c68 <__kvm_nvhe_$d>  -> Fallback to default parser
+ *
+ * Parsing strategy:
+ * Use the '[' bracket as the boundary to split the operands into left
+ * and right sides. For non-store instructions, the left side is the
+ * target and the right side is the source. For store instructions, the
+ * roles are reversed.
+ */
+static int arm64_ldst__parse(const struct arch *arch,
+			     struct ins_operands *ops,
+			     struct map_symbol *ms,
+			     struct disasm_line *dl)
+{
+	char *s, *left, *right;
+
+	right = s = strchr(ops->raw, arch->objdump.memory_ref_char);
+	if (!s) {
+		/* Fallback to default parser for PC-relative loads. */
+		return arm64_mov__parse(arch, ops, ms, dl);
+	}
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
+	right = rstrip_space_and_comment(right, arch->objdump.comment_char);
+	if (!right) {
+		zfree(&left);
+		return -1;
+	}
+
+	if (arm64__insn_is_source_on_left(dl)) {
+		ops->source.raw = left;
+		ops->source.mem_ref = false;
+		ops->target.raw = right;
+		ops->target.mem_ref = true;
+	} else {
+		ops->source.raw = right;
+		ops->source.mem_ref = true;
+		ops->target.raw = left;
+		ops->target.mem_ref = false;
+	}
+
+	ops->source.multi_regs = arm64__check_multi_regs(arch, ops->source.raw);
+	ops->target.multi_regs = arm64__check_multi_regs(arch, ops->target.raw);
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
@@ -173,6 +276,8 @@ static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch,
 		ops = &jump_ops;
 	else if (!regexec(&arm->call_insn, name, 2, match, 0))
 		ops = &call_ops;
+	else if (!regexec(&arm->ldst_insn, name, 2, match, 0))
+		ops = &arm64_ldst_ops;
 	else if (!strcmp(name, "ret"))
 		ops = &ret_ops;
 	else
@@ -197,6 +302,8 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 	arch->id = *id;
 	arch->objdump.comment_char	  = '/';
 	arch->objdump.skip_functions_char = '+';
+	arch->objdump.memory_ref_char	  = '[';
+	arch->objdump.imm_char		  = '#';
 	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
 
 	/* bl, blr */
@@ -210,8 +317,20 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
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

