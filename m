Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAE7396B9A;
	Fri,  3 Apr 2026 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209736; cv=none; b=JkUJbvqgepVtQBYo895XaWbuwtLjjF/z1ZkdVSqjM1TYuZISYM+wHsH6xwYtxP7KlV0ZB0HgUMEm4Jz9g74fzIpTGN1RW+xBIdhQwfKS5++sGiSQ2MPTykzhgMrKAi6kygrD4Id5e3vEH4Qb7C6UXJbFvHyvR0y5nr5h8LSk/bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209736; c=relaxed/simple;
	bh=x4JWNQs1NSQHGDqeUKUziyCIqoSczZdaJeojxpVsyjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dFlj3RA1d9kaubxuUAcUJO3E3J61lBsaHndcUWibUE8Bgx5Vit4To/4ROHVzSyZoSuvmMrhFi09RFTNbVVqeMnG5eFD+R5BwjorFyB+ml0XiGlS/sxZ1ilm+1y1xbQRuwRGpQR4wSY2ZJdLc9USiKZ2hXuWpRpSMjDxywmF3JrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fnDRd140MzKHMWy;
	Fri,  3 Apr 2026 17:47:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id AFA8740576;
	Fri,  3 Apr 2026 17:48:49 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with SMTP id _Ch0CgAnB1TwjM9p8K_UDA--.49742S9;
	Fri, 03 Apr 2026 17:48:49 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v2 07/16] perf annotate-arm64: Implement extract_op_location() callback
Date: Fri,  3 Apr 2026 09:47:51 +0000
Message-Id: <20260403094800.1418825-8-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260403094800.1418825-1-wutengda@huaweicloud.com>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAnB1TwjM9p8K_UDA--.49742S9
X-Coremail-Antispam: 1UD129KBjvJXoWxKrykZrWkXF1rAryUKr4UJwb_yoW7Gw48pw
	4j9343tr1Utr4Yqw1fZFs3WFy3Cw1fG3Wa9rWxCwsrZFs3Zr18Ja1xKF1a9a45JrZxu34j
	yF4DtrW8Zr15CaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRGMKuUUUUU
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

This enables 'perf annotate' to resolve memory locations and registers
required for data type profiling on arm64.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 64 +++++++++++++++++++
 tools/perf/util/annotate.c                    | 12 ++--
 tools/perf/util/annotate.h                    | 10 +++
 3 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 8209faaa6086..1fe4c503431b 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -191,6 +191,69 @@ static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch,
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
+			op_loc->addr_mode = INSN_ADDR_PRE_INDEX;
+		/* Post-index: [base], #imm */
+		else if (p[1] == ',' && strchr(p + 1, arch->objdump.imm_char))
+			op_loc->addr_mode = INSN_ADDR_POST_INDEX;
+		/* Signed offset: [base{, #imm}] */
+		else
+			op_loc->addr_mode = INSN_ADDR_SIGNED_OFFSET;
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
@@ -209,6 +272,7 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
 	arch->objdump.memory_ref_char	  = '[';
 	arch->objdump.imm_char		  = '#';
 	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
+	arch->extract_op_location	  = extract_op_location_arm64;
 
 	/* bl, blr */
 	err = regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 1bf69e00d76d..c4d1cb3a7ae4 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2452,19 +2452,21 @@ int annotate_check_args(void)
 
 int arch__dwarf_regnum(const struct arch *arch, const char *str)
 {
-	const char *p;
+	const char *p = str;
 	char *regname, *q;
 	int reg;
 
-	p = strchr(str, arch->objdump.register_char);
-	if (p == NULL)
-		return -1;
+	if (arch->objdump.register_char) {
+		p = strchr(str, arch->objdump.register_char);
+		if (p == NULL)
+			return -1;
+	}
 
 	regname = strdup(p);
 	if (regname == NULL)
 		return -1;
 
-	q = strpbrk(regname, ",) ");
+	q = strpbrk(regname, ",)] ");
 	if (q)
 		*q = '\0';
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 71195a27d38f..0391c6a9f011 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -496,12 +496,21 @@ int annotate_check_args(void);
 
 int arch__dwarf_regnum(const struct arch *arch, const char *str);
 
+enum annotated_addr_mode {
+	INSN_ADDR_NONE = 0,
+
+	INSN_ADDR_SIGNED_OFFSET,
+	INSN_ADDR_PRE_INDEX,
+	INSN_ADDR_POST_INDEX,
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
@@ -511,6 +520,7 @@ struct annotated_op_loc {
 	int reg2;
 	int offset;
 	u8 segment;
+	u8 addr_mode;
 	bool mem_ref;
 	bool multi_regs;
 	bool imm;
-- 
2.34.1

