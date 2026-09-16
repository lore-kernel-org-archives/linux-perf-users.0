Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5BB3ACEE0;
	Wed, 16 Sep 2026 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522222; cv=none; b=u0tSSVpUnRjz/E9wOdRx5spAVxV2uDYcLfgonKsFhyBizCukYUZ/0+Lii4Aam90wD7+1HjW0cNLVtMtJWhEwJ4wz0jas+ocTBBcwbLg4KmqaqFOfpT1qymSk9UfBskzI0z/GN+U49yrerbuz+bQKUhB3B+eGpNl0Mr5Tpx+DR+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522222; c=relaxed/simple;
	bh=F+tb4jFPXVYucjTKi8or58Nt3w6Jxx47TwjlWNG0AlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gHpfkg9lKuvBv285JbhIQ5//oYuGgkN1dn54/Ryh+oHThhosAfp11eWuhjR7c7RiLZFsaRPx1SXvG/TpWqCkoieMW6qya6GXdbX6f08wU9G0r/VFbVDpC0aYBMXicucpHJ4m8RRx366D4AR8FrK9IzPgGgky9EWCdGVv1uqrUPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hl1XJ1lcgzKHMTD;
	Wed, 16 Sep 2026 09:29:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CEB9B40592;
	Wed, 16 Sep 2026 09:30:05 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAn+CoH8alqUcjbAQ--.36458S11;
	Wed, 16 Sep 2026 09:30:05 +0800 (CST)
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
Subject: [PATCH v6 09/26] perf annotate-arm64: Implement extract_op_location() callback
Date: Wed, 16 Sep 2026 01:29:23 +0000
Message-Id: <7d425a8afe73f5684cf7baaffd2d5398f89f32a3.1789521520.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAn+CoH8alqUcjbAQ--.36458S11
X-Coremail-Antispam: 1UD129KBjvJXoWxKF1kXw17Jr1UAFW3Ww4xCrg_yoW3Zr45pr
	4Uu345tr1UJwsIqw4Svrs8WF15Cw4Ika4qgry3C3sIyFsavF1fX3Wxta4avFyrJrZxX34j
	yrs0vr48Xr17CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxc
	IEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc7CjxVAKzI0EY4vE52x082I5
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr
	0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRNg4S3UUUU
	U==
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
 .../perf/util/annotate-arch/annotate-arm64.c  | 133 ++++++++++++++++++
 tools/perf/util/annotate.h                    |  61 ++++++++
 2 files changed, 194 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index a7595a954cfa..508a95d0ad4b 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -316,6 +316,138 @@ static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch,
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
+static const char *next_operand_field(const char *s)
+{
+	s = strchr(s, ',');
+	return s ? skip_spaces(s + 1) : NULL;
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
+		s = next_operand_field(s);
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
+	s = next_operand_field(s);
+	if (s == NULL)
+		return;
+
+	/* Extract secondary register or immediate offset */
+	if (op_loc->multi_regs) {
+		op_loc->reg2 = arch__dwarf_regnum(arch, s);
+		s = next_operand_field(s);
+	} else if (*s == arch->objdump.imm_char) {
+		op_loc->offset = strtol(s + 1, NULL, 0);
+		s = next_operand_field(s);
+	}
+
+check_modifiers:
+	/*
+	 * Look for a following shift or extension modifier:
+	 *   "lsl #3"   -> extend_type = PERF_EXT_NONE,
+	 *                 shift_type = PERF_SHIFT_LSL, amount = 3
+	 *   "uxtw #3"  -> extend_type = PERF_EXT_UXTW,
+	 *                 shift_type = PERF_SHIFT_LSL, amount = 3
+	 *   "uxtw"     -> extend_type = PERF_EXT_UXTW,
+	 *                 shift_type = PERF_SHIFT_LSL, amount = 0
+	 */
+	if (s == NULL)
+		return;
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
@@ -334,6 +466,7 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 	arch->objdump.memory_ref_char	  = '[';
 	arch->objdump.imm_char		  = '#';
 	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
+	arch->extract_op_location	  = extract_op_location_arm64;
 
 	/* bl, blr */
 	err = regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 6cd3ef537564..c528fbef8b38 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -532,6 +532,10 @@ int arch__dwarf_regnum(const struct arch *arch, const char *str);
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
@@ -541,6 +545,10 @@ struct annotated_op_loc {
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
@@ -564,6 +572,59 @@ enum annotated_x86_segment {
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

