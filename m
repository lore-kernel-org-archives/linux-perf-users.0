Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93063368A5;
	Wed,  1 Jul 2026 03:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878097; cv=none; b=OzO9oYHUyKsvsB4yzFQpmBscxnyMDr7/wYyQU1/BYHOKJ5IVadisjKOkUP5WKF/ALgSsRFSz0XxlOn1guQuMQTmQY0ZsNBYjOiI8E1K0+Qfw23TCCfa05G85xopeuGYGo/N1pwgWxwpuxwPZ8ADt0mJTDJuhOAQgyTdoD8oeHfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878097; c=relaxed/simple;
	bh=ADrfowPkLRf4ZXEM3AyAfzU5RoiI/brduXrsy8p8VVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JfgsCJfa6Ad+E2NHy1J55mD6rcFsvt8yAx3vX7qKvXiPsR8ftbi71GtzhGcRcMz4lzLHXE+Q49ND2jZqjZjjd/VldXop6yib4g9vWoYZKnmecEfRy73T9g/yfA5ms0/sgmFyZzad894K43S9+WBvRLmH0o12CnFFeG6hcSpbwis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gqmNr5TL2zKHMTR;
	Wed,  1 Jul 2026 11:54:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id CD0C740AE3;
	Wed,  1 Jul 2026 11:54:45 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBXiyWAj0RqCne9AQ--.26189S11;
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
Subject: [PATCH v3 09/21] perf annotate-arm64: Implement extract_op_location() callback
Date: Wed,  1 Jul 2026 03:53:43 +0000
Message-Id: <20260701035355.752944-10-wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgBXiyWAj0RqCne9AQ--.26189S11
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4rXw1rur4fAry5XF43ZFb_yoWrZF15pw
	4j9345tr17tr4Yq3WfZFs7WFy3Cw1fGas09rWfA39xArs7ZF1kXa1IkF1a9Fy3Jr9xC34j
	vF4UtrW8Zr1UGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Implement the extract_op_location() callback for the arm64 architecture
to handle its specific assembly syntax and addressing modes.

The extractor handles:
1. Standalone immediate operands (e.g., #0x10).
2. Memory references with diverse addressing modes:
   - Signed offset: [base, #imm]
   - Pre-index: [base, #imm]!
   - Post-index: [base], #imm
3. Multi-register operands and primary/secondary register extraction.

With this callback in place, 'perf annotate' can now resolve memory
locations and register types on arm64, marking the initial enablement
of data type profiling for this architecture.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 64 +++++++++++++++++++
 tools/perf/util/annotate.h                    | 10 +++
 2 files changed, 74 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 451500def8c1..77b6f4841c84 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -261,6 +261,69 @@ static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch,
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
+	 * Handle memory references (e.g., [x0, #8]), identify
+	 * arm64 specific addressing modes
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
+		/* Post-index: [base], #imm */
+		else if (p[1] == ',' && strchr(p + 1, arch->objdump.imm_char))
+			op_loc->addr_mode = PERF_ADDR_MODE_POST_INDEX;
+		/* Signed offset: [base{, #imm}] */
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
+	/* Parse secondary register or immediate offset */
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
@@ -279,6 +342,7 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 	arch->objdump.memory_ref_char	  = '[';
 	arch->objdump.imm_char		  = '#';
 	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
+	arch->extract_op_location	  = extract_op_location_arm64;
 
 	/* bl, blr */
 	err = regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 5a0a913af53a..670dc7944628 100644
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

