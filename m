Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5703B3D1CA7;
	Sat,  8 Aug 2026 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786191877; cv=none; b=La2d3LQPenj1J1ZP9FJFQcjFcZHnqV4DBC2iOoHVjNIbfblZN9rQM/YTUqsCpy/hAkC0Uc9hRRef45pnq2JkUgeu56AgQk4IJceB3g3cj9QHy0KHcCn7i8uEvUmUQrZxJqkSzWJnvLWm49+SONFLVdEjdW42OIi/YqPgvvSCSq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786191877; c=relaxed/simple;
	bh=zgfSk2lLxyj4JKe4KxNn+D6SHc58gazangOP8YM6bMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=agRtIrSeD4MDSrbmgpKCSZ2nlvlS3S/JLsC4iE6ASwFIpD2KQt6I3e83/jrsARdIvbK/NcseqvnMJ0Ra/MlwPiT56VHJHBBUYOr5EqaPmbXrk/ZjBsGQSZbULexDG6rmKCxCt7Dnmsoa3qSh2ACkH05Euz9TtCeBhqGPMzji68c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hHKtJ01RbzYQvjg;
	Sat,  8 Aug 2026 20:23:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2DABF4058F;
	Sat,  8 Aug 2026 20:24:18 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB34YjkH3dqbrhMBg--.41805S10;
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
Subject: [PATCH v4 08/23] perf annotate-arm64: Implement extract_op_location() callback
Date: Sat,  8 Aug 2026 12:23:45 +0000
Message-Id: <20260808122400.2961238-9-wutengda@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgB34YjkH3dqbrhMBg--.41805S10
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4rXw1rur4fAry5XF43ZFb_yoWruFWDpw
	4jk345tr17tr4aq3WfZrs7WFy3Cw4fGF1Y9rWxC39xArs7ZFn2qa1IkF1a9Fy5JrZxC34j
	vF4DtFW8XryUGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRQYFCDUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Implement the extract_op_location() callback for the arm64 architecture
to handle its specific assembly syntax and addressing modes.

The extractor handles:
1. Standalone immediate operands (e.g., #0x10).
2. Memory references with diverse addressing modes:
   - Signed offset: [base{, #imm|reg}]
   - Pre-index: [base, #imm]!
   - Post-index: [base], #imm|reg
3. Multi-register operands and primary/secondary register extraction.

With this callback in place, 'perf annotate' can now resolve memory
locations and register types on arm64, marking the initial enablement
of data type profiling for this architecture.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 67 +++++++++++++++++++
 tools/perf/util/annotate.h                    | 10 +++
 2 files changed, 77 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 32752a3bc756..6b4f1228afa9 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -287,6 +287,72 @@ static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch,
 	return ops;
 }
 
+static int extract_op_location_arm64(const struct arch *arch,
+				     struct disasm_line *dl __maybe_unused,
+				     const char *op_str, int op_idx __maybe_unused,
+				     struct annotated_op_loc *op_loc)
+{
+	const char *s = op_str;
+	char *p = NULL;
+
+	if (op_str == NULL)
+		return 0;
+
+	/* Handle standalone immediate operands (e.g., #0x10) */
+	if (*s == arch->objdump.imm_char) {
+		op_loc->offset = strtol(s + 1, &p, 0);
+		if (p && p != s + 1)
+			op_loc->imm = true;
+		return 0;
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
+			return -1;
+
+		/* Pre-index: [base, #imm]! */
+		if (p[1] == '!')
+			op_loc->addr_mode = PERF_ADDR_MODE_PRE_INDEX;
+		/* Post-index: [base], #imm|reg */
+		else if (p[1] == ',' &&
+			 (strchr(p + 1, arch->objdump.imm_char) ||
+			  arm64__is_reg(skip_spaces(p + 2))))
+			op_loc->addr_mode = PERF_ADDR_MODE_POST_INDEX;
+		/* Signed offset: [base{, #imm|reg}] */
+		else
+			op_loc->addr_mode = PERF_ADDR_MODE_SIGNED_OFFSET;
+
+		s++;
+	}
+
+	/* Extract the primary register */
+	op_loc->reg1 = arch__dwarf_regnum(arch, s);
+	if (op_loc->reg1 == -1)
+		return -1;
+
+	/* Move to the next symbol of the operand, if any */
+	s = strchr(s, ',');
+	if (s == NULL)
+		return 0;
+	s = skip_spaces(s + 1);
+
+	/* Extract secondary register or immediate offset */
+	if (op_loc->multi_regs)
+		op_loc->reg2 = arch__dwarf_regnum(arch, s);
+	else if (*s == arch->objdump.imm_char)
+		op_loc->offset = strtol(s + 1, &p, 0);
+
+	return 0;
+}
+
 const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 				   const char *cpuid __maybe_unused)
 {
@@ -305,6 +371,7 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 	arch->objdump.memory_ref_char	  = '[';
 	arch->objdump.imm_char		  = '#';
 	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
+	arch->extract_op_location	  = extract_op_location_arm64;
 
 	/* bl, blr */
 	err = regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 11b6e4780c02..a44c933f55f5 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -494,12 +494,21 @@ int annotate_check_args(void);
 
 int arch__dwarf_regnum(const struct arch *arch, const char *str);
 
+enum annotated_addr_mode {
+	PERF_ADDR_MODE_NONE = 0,
+
+	PERF_ADDR_MODE_SIGNED_OFFSET,
+	PERF_ADDR_MODE_PRE_INDEX,
+	PERF_ADDR_MODE_POST_INDEX,
+};
+
 /**
  * struct annotated_op_loc - Location info of instruction operand
  * @reg1: First register in the operand
  * @reg2: Second register in the operand
  * @offset: Memory access offset in the operand
  * @segment: Segment selector register
+ * @addr_mode: Addressing mode, only valid if @mem_ref is true
  * @mem_ref: Whether the operand accesses memory
  * @multi_regs: Whether the second register is used
  * @imm: Whether the operand is an immediate value (in offset)
@@ -509,6 +518,7 @@ struct annotated_op_loc {
 	int reg2;
 	int offset;
 	u8 segment;
+	u8 addr_mode;
 	bool mem_ref;
 	bool multi_regs;
 	bool imm;
-- 
2.34.1

