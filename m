Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A715476CB;
	Tue,  8 Sep 2026 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872537; cv=none; b=rbh+/wpwb3lAPBPIINt/e8UhqGApM4yld/gXEG5Gc9IOOyimZEh3EMSB52wie+ekCaF3QBLxekbCZ5AZf6KV1uqcelJ9KOdH9vY2d48ACY5wLTY3TpljkDirEO4IxSvPzxZAWpKe9tWld9S/VDLmbB3DVgLAuinY9ahgF7piO00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872537; c=relaxed/simple;
	bh=CcK+4nFWsUiyZbQZ7UMqjjrWJ1Hdg+cSYuZQxqhCf5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LMjq1lVSUFwb+ERmWtFZ3LDgBthZtvd912p8ZdU6DeaLucJebdKA5uFT5wigpx/ffzNe4ubdC8xIloSyR/ZNLeMQlEO6roIweQ26v3Tru97DW96dFEcToOkT9BEAJE6iMESxeVjjIG7mhsCb5E3yMDC1lMTPU9CTlC94as05A+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hfPGS4wxBzKHN6F;
	Tue,  8 Sep 2026 21:01:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0A21B40570;
	Tue,  8 Sep 2026 21:01:54 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAni5gpB6BqC9rlBA--.34632S11;
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
Subject: [PATCH v5 09/26] perf annotate-arm64: Implement extract_op_location() callback
Date: Tue,  8 Sep 2026 13:01:05 +0000
Message-Id: <20260908130122.633500-10-wutengda@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAni5gpB6BqC9rlBA--.34632S11
X-Coremail-Antispam: 1UD129KBjvJXoWxKF1kXw1kCrWfAFyUKw45Jrb_yoW3Cry7pr
	4Uu34rtr1UJwsIqw4Svrs8Wr15Cw4Ika4qgrW3CwnIyFsavFyfW3Wxta4a9FyrJrZxX3yj
	yrsYvr48Xr17GaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRGMKuUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Implement the extract_op_location() callback for the arm64 architecture
to handle its specific assembly syntax and addressing modes.

The extractor handles:
1. Immediate operands (e.g., '#0x10' or '#0xc600, lsl #16').
2. Memory references with diverse addressing modes:
   - Signed offset: [base{, #imm|reg}]
   - Pre-index: [base, #imm]!
   - Post-index: [base], #imm|reg
3. Multi-register operands and primary/secondary register extraction.
4. Register extension specifiers (e.g., uxtw, sxtx) and shift amounts
   for shifted/extended operands.

With this callback in place, 'perf annotate' can now resolve memory
locations and register types on arm64, marking the initial enablement
of data type profiling for this architecture.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 127 ++++++++++++++++++
 tools/perf/util/annotate.h                    |  61 +++++++++
 2 files changed, 188 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index a7595a954cfa..d8a5904359b1 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -316,6 +316,132 @@ static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch,
 	return ops;
 }
 
+static enum annotated_ext_type arm64__check_ext_type(const char *op)
+{
+	if (!strncmp(op, "uxtb", 4)) return PERF_EXT_UXTB;
+	if (!strncmp(op, "uxth", 4)) return PERF_EXT_UXTH;
+	if (!strncmp(op, "uxtw", 4)) return PERF_EXT_UXTW;
+	if (!strncmp(op, "uxtx", 4)) return PERF_EXT_UXTX;
+	if (!strncmp(op, "sxtb", 4)) return PERF_EXT_SXTB;
+	if (!strncmp(op, "sxth", 4)) return PERF_EXT_SXTH;
+	if (!strncmp(op, "sxtw", 4)) return PERF_EXT_SXTW;
+	if (!strncmp(op, "sxtx", 4)) return PERF_EXT_SXTX;
+
+	return PERF_EXT_NONE;
+}
+
+static enum annotated_shift_type arm64__check_shift_type(const char *op)
+{
+	if (!strncmp(op, "lsl", 3)) return PERF_SHIFT_LSL;
+	if (!strncmp(op, "lsr", 3)) return PERF_SHIFT_LSR;
+	if (!strncmp(op, "asr", 3)) return PERF_SHIFT_ASR;
+	if (!strncmp(op, "ror", 3)) return PERF_SHIFT_ROR;
+
+	return PERF_SHIFT_NONE;
+}
+
+static void extract_op_location_arm64(const struct arch *arch,
+				      struct disasm_line *dl __maybe_unused,
+				      const char *op_str, int op_idx __maybe_unused,
+				      struct annotated_op_loc *op_loc)
+{
+	const char *s = op_str;
+	char *p = NULL;
+
+	if (op_str == NULL)
+		return;
+
+	/*
+	 * Handle immediate operand.
+	 * e.g., "#0xc600" -> offset = 0xc600, imm = true
+	 *
+	 * After parsing, check for post-modifiers like "lsl #16", which
+	 * typically occur in instructions such as movk, movz, movn, etc.
+	 */
+	if (*s == arch->objdump.imm_char) {
+		op_loc->offset = strtol(s + 1, &p, 0);
+		if (p && p != s + 1) {
+			op_loc->imm = true;
+			s = p;
+		}
+		goto check_modifiers;
+	}
+
+	/*
+	 * Handle memory references, identify arm64 specific addressing modes.
+	 * Reference: Arm Architecture Reference Manual
+	 *            (DDI 0487), Chapter C1.3.3: Load/store addressing modes.
+	 */
+	if (*s == arch->objdump.memory_ref_char) {
+		op_loc->mem_ref = true;
+
+		p = strchr(s, ']');
+		if (p == NULL)
+			return;
+
+		/* Pre-index: [base, #imm]! */
+		if (p[1] == '!')
+			op_loc->addr_mode = PERF_AAM_PRE_INDEX;
+		/* Post-index: [base], #imm|reg */
+		else if (p[1] == ',' &&
+			 (strchr(p + 1, arch->objdump.imm_char) ||
+			  arm64__is_reg(skip_spaces(p + 2))))
+			op_loc->addr_mode = PERF_AAM_POST_INDEX;
+		/* Signed offset: [base{, #imm|reg}] */
+		else
+			op_loc->addr_mode = PERF_AAM_SIGNED_OFFSET;
+
+		s++;
+	}
+
+	/* Extract the primary register */
+	op_loc->reg1 = arch__dwarf_regnum(arch, s);
+	if (op_loc->reg1 == -1)
+		return;
+
+	/* Move to the next operand field, if present */
+	s = strchr(s, ',');
+	if (s == NULL)
+		return;
+	s = skip_spaces(s + 1);
+
+	/* Extract secondary register or immediate offset */
+	if (op_loc->multi_regs)
+		op_loc->reg2 = arch__dwarf_regnum(arch, s);
+	else if (*s == arch->objdump.imm_char)
+		op_loc->offset = strtol(s + 1, NULL, 0);
+
+check_modifiers:
+	/*
+	 * Look for a following shift or extension modifier:
+	 *   ", lsl #3"   -> extend_type = PERF_EXT_NONE,
+	 *                   shift_type = PERF_SHIFT_LSL, amount = 3
+	 *   ", uxtw #3"  -> extend_type = PERF_EXT_UXTW,
+	 *                   shift_type = PERF_SHIFT_LSL, amount = 3
+	 *   ", uxtw"     -> extend_type = PERF_EXT_UXTW,
+	 *                   shift_type = PERF_SHIFT_LSL, amount = 0
+	 */
+	s = strchr(s, ',');
+	if (s == NULL)
+		return;
+	s = skip_spaces(s + 1);
+
+	op_loc->extend_type = arm64__check_ext_type(s);
+	op_loc->shift_type = arm64__check_shift_type(s);
+	/* ARM64 extended operands are implicitly shifted by LSL. */
+	if (op_loc->extend_type != PERF_EXT_NONE)
+		op_loc->shift_type = PERF_SHIFT_LSL;
+
+	/* Parse shift amount if present */
+	op_loc->amount = 0;
+	if (op_loc->extend_type != PERF_EXT_NONE ||
+	    op_loc->shift_type != PERF_SHIFT_NONE) {
+		s = strchr(s, arch->objdump.imm_char);
+		if (s)
+			op_loc->amount = (u8)strtol(s + 1, NULL, 0);
+	}
+}
+
 const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 				   const char *cpuid __maybe_unused)
 {
@@ -334,6 +460,7 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 	arch->objdump.memory_ref_char	  = '[';
 	arch->objdump.imm_char		  = '#';
 	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
+	arch->extract_op_location	  = extract_op_location_arm64;
 
 	/* bl, blr */
 	err = regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 11b6e4780c02..f0ff4b7e8a28 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -500,6 +500,10 @@ int arch__dwarf_regnum(const struct arch *arch, const char *str);
  * @reg2: Second register in the operand
  * @offset: Memory access offset in the operand
  * @segment: Segment selector register
+ * @addr_mode: Addressing mode, only valid if @mem_ref is true
+ * @extend_type: Operand extension type (enum annotated_ext_type)
+ * @shift_type: Operand shift type (enum annotated_shift_type)
+ * @amount: Number of bits to shift
  * @mem_ref: Whether the operand accesses memory
  * @multi_regs: Whether the second register is used
  * @imm: Whether the operand is an immediate value (in offset)
@@ -509,6 +513,10 @@ struct annotated_op_loc {
 	int reg2;
 	int offset;
 	u8 segment;
+	u8 addr_mode;
+	u8 extend_type;
+	u8 shift_type;
+	u8 amount;
 	bool mem_ref;
 	bool multi_regs;
 	bool imm;
@@ -532,6 +540,59 @@ enum annotated_x86_segment {
 	INSN_SEG_X86_SS,
 };
 
+/*
+ * ARM64 addressing modes for memory operations.
+ *
+ * [Xn, #imm]  -> SIGNED_OFFSET  (base + offset, base unchanged)
+ * [Xn, #imm]! -> PRE_INDEX      (base += offset, then access)
+ * [Xn], #imm  -> POST_INDEX     (access, then base += offset)
+ */
+enum annotated_addr_mode {
+	PERF_AAM_NONE = 0,
+
+	PERF_AAM_SIGNED_OFFSET,
+	PERF_AAM_PRE_INDEX,
+	PERF_AAM_POST_INDEX,
+};
+
+/*
+ * ARM64 register extension types.
+ * UXT* = zero-extend, SXT* = sign-extend.
+ * B=8bit, H=16bit, W=32bit, X=64bit.
+ *
+ * Example: UXTW = zero-extend 32-bit Wn to 64-bit Xn
+ */
+enum annotated_ext_type {
+	PERF_EXT_NONE = 0,
+
+	PERF_EXT_UXTB,
+	PERF_EXT_UXTH,
+	PERF_EXT_UXTW,
+	PERF_EXT_UXTX,
+	PERF_EXT_SXTB,
+	PERF_EXT_SXTH,
+	PERF_EXT_SXTW,
+	PERF_EXT_SXTX,
+};
+
+/*
+ * ARM64 operand shift types.
+ * LSL = logical shift left.
+ * LSR = logical shift right.
+ * ASR = arithmetic shift right.
+ * ROR = rotate right.
+ *
+ * Example: LSL #3 = shift the operand left by 3 bits.
+ */
+enum annotated_shift_type {
+	PERF_SHIFT_NONE = 0,
+
+	PERF_SHIFT_LSL,
+	PERF_SHIFT_LSR,
+	PERF_SHIFT_ASR,
+	PERF_SHIFT_ROR,
+};
+
 /**
  * struct annotated_insn_loc - Location info of instruction
  * @ops: Array of location info for source and target operands
-- 
2.34.1

