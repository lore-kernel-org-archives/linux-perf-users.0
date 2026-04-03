Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2A539769B;
	Fri,  3 Apr 2026 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209741; cv=none; b=Nar+wqCen+VsgR4pLkaX3emEamTallezswk6u5iFtWWOhwvTC3Vj0TF0kBBOIa6UQ2F6tY0UQLtyagPEHg9d9GIhS75GO0K3jQ4/6gA6rw4aqarlyeu9o38WlDqpmSLeoGE+CKkw+ZWFSh+/ARQ9lEFEJ4Gt/1vueM0axbHKEDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209741; c=relaxed/simple;
	bh=l+GBruTgRRKT9WRInpqaaEMpoWeOzWVnxd7MPQTPdqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u4Mdwd28WmgZZqkXY6x4rnZ+eFznl93Qc9DTXlXs1z/zntlErsQdXaKk/dQOdhT6tpAlIZsu2olWR7XEEZLdU9Ph7zrfxUHLGYAtQ8b7yNcEiCU7V56YfkwCNAXWZJKMeXE8sdClvaAblEBVGkWm0WnR3R29XqHs/zNLx/e3cQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fnDS80pRwzYQtv2;
	Fri,  3 Apr 2026 17:48:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8636C4056F;
	Fri,  3 Apr 2026 17:48:49 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with SMTP id _Ch0CgAnB1TwjM9p8K_UDA--.49742S7;
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
Subject: [PATCH v2 05/16] perf annotate: Introduce extract_op_location callback for arch-specific parsing
Date: Fri,  3 Apr 2026 09:47:49 +0000
Message-Id: <20260403094800.1418825-6-wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgAnB1TwjM9p8K_UDA--.49742S7
X-Coremail-Antispam: 1UD129KBjvJXoWxtr13tF4kJw4kuF18Kw4UArb_yoWDGF4fpw
	4Du34Yyr1rKr4YqwsrXFs5W3Wakw4rWF1Y9r47K39rAFn2yrn5Jan2gF1avF1rtrZxur1j
	vF4qvrW8XryrGaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Assembly syntax for operands varies significantly across different
architectures, which prevents the operand location (op_loc) parsing
logic in annotate_get_insn_location() from being directly reused.

To simplify the core logic and improve maintainability, move the
operand parsing inside the for_each_insn_op_loc loop into arch-specific
extract_op_location callbacks. This refactoring is intended to be a
cleanup with no functional changes.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../util/annotate-arch/annotate-powerpc.c     | 10 ++
 tools/perf/util/annotate-arch/annotate-x86.c  | 82 ++++++++++++++++
 tools/perf/util/annotate.c                    | 96 ++-----------------
 tools/perf/util/annotate.h                    |  2 +
 tools/perf/util/disasm.h                      |  4 +
 5 files changed, 105 insertions(+), 89 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-powerpc.c b/tools/perf/util/annotate-arch/annotate-powerpc.c
index 218207b52581..8d0b8def5955 100644
--- a/tools/perf/util/annotate-arch/annotate-powerpc.c
+++ b/tools/perf/util/annotate-arch/annotate-powerpc.c
@@ -390,6 +390,15 @@ static void update_insn_state_powerpc(struct type_state *state,
 }
 #endif /* HAVE_LIBDW_SUPPORT */
 
+static int extract_op_location_powerpc(const struct arch *arch __maybe_unused,
+				       struct disasm_line *dl,
+				       const char *op_str __maybe_unused, int op_idx,
+				       struct annotated_op_loc *op_loc)
+{
+	get_powerpc_regs(dl->raw.raw_insn, !op_idx, op_loc);
+	return 0;
+}
+
 const struct arch *arch__new_powerpc(const struct e_machine_and_e_flags *id,
 				     const char *cpuid __maybe_unused)
 {
@@ -406,5 +415,6 @@ const struct arch *arch__new_powerpc(const struct e_machine_and_e_flags *id,
 #ifdef HAVE_LIBDW_SUPPORT
 	arch->update_insn_state = update_insn_state_powerpc;
 #endif
+	arch->extract_op_location = extract_op_location_powerpc;
 	return arch;
 }
diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index c77aabd48eba..c63ca3250b95 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -3,6 +3,7 @@
 #include <linux/compiler.h>
 #include <assert.h>
 #include <inttypes.h>
+#include <ctype.h>
 #include "../annotate-data.h"
 #include "../debug.h"
 #include "../disasm.h"
@@ -808,6 +809,86 @@ static void update_insn_state_x86(struct type_state *state,
 }
 #endif
 
+/*
+ * Get register number and access offset from the given instruction.
+ * It assumes AT&T x86 asm format like OFFSET(REG).  Maybe it needs
+ * to revisit the format when it handles different architecture.
+ * Fills @reg and @offset when return 0.
+ */
+static int extract_reg_offset(const struct arch *arch, const char *str,
+			      struct annotated_op_loc *op_loc)
+{
+	char *p;
+
+	if (arch->objdump.register_char == 0)
+		return -1;
+
+	/*
+	 * It should start from offset, but it's possible to skip 0
+	 * in the asm.  So 0(%rax) should be same as (%rax).
+	 *
+	 * However, it also start with a segment select register like
+	 * %gs:0x18(%rbx).  In that case it should skip the part.
+	 */
+	if (*str == arch->objdump.register_char) {
+		/* FIXME: Handle other segment registers */
+		if (!strncmp(str, "%gs:", 4))
+			op_loc->segment = INSN_SEG_X86_GS;
+
+		while (*str && !isdigit(*str) &&
+		       *str != arch->objdump.memory_ref_char)
+			str++;
+	}
+
+	op_loc->offset = strtol(str, &p, 0);
+	op_loc->reg1 = arch__dwarf_regnum(arch, p);
+	if (op_loc->reg1 == -1)
+		return -1;
+
+	/* Get the second register */
+	if (op_loc->multi_regs)
+		op_loc->reg2 = arch__dwarf_regnum(arch, p + 1);
+
+	return 0;
+}
+
+static int extract_op_location_x86(const struct arch *arch,
+				   struct disasm_line *dl __maybe_unused,
+				   const char *op_str, int op_idx __maybe_unused,
+				   struct annotated_op_loc *op_loc)
+{
+	const char *s = op_str;
+	char *p = NULL;
+
+	if (op_str == NULL)
+		return 0;
+
+	if (strchr(op_str, arch->objdump.memory_ref_char)) {
+		op_loc->mem_ref = true;
+		return extract_reg_offset(arch, op_str, op_loc);
+	}
+
+	/* FIXME: Handle other segment registers */
+	if (!strncmp(op_str, "%gs:", 4)) {
+		op_loc->segment = INSN_SEG_X86_GS;
+		op_loc->offset = strtol(op_str + 4,
+					&p, 0);
+		if (p && p != op_str + 4)
+			op_loc->imm = true;
+		return 0;
+	}
+
+	if (*s == arch->objdump.register_char) {
+		op_loc->reg1 = arch__dwarf_regnum(arch, s);
+	} else if (*s == arch->objdump.imm_char) {
+		op_loc->offset = strtol(s + 1, &p, 0);
+		if (p && p != s + 1)
+			op_loc->imm = true;
+	}
+
+	return 0;
+}
+
 const struct arch *arch__new_x86(const struct e_machine_and_e_flags *id, const char *cpuid)
 {
 	struct arch *arch = zalloc(sizeof(*arch));
@@ -847,5 +928,6 @@ const struct arch *arch__new_x86(const struct e_machine_and_e_flags *id, const c
 #ifdef HAVE_LIBDW_SUPPORT
 	arch->update_insn_state = update_insn_state_x86;
 #endif
+	arch->extract_op_location = extract_op_location_x86;
 	return arch;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 63f0ee9d4c03..1bf69e00d76d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2450,7 +2450,7 @@ int annotate_check_args(void)
 	return 0;
 }
 
-static int arch__dwarf_regnum(const struct arch *arch, const char *str)
+int arch__dwarf_regnum(const struct arch *arch, const char *str)
 {
 	const char *p;
 	char *regname, *q;
@@ -2473,51 +2473,6 @@ static int arch__dwarf_regnum(const struct arch *arch, const char *str)
 	return reg;
 }
 
-/*
- * Get register number and access offset from the given instruction.
- * It assumes AT&T x86 asm format like OFFSET(REG).  Maybe it needs
- * to revisit the format when it handles different architecture.
- * Fills @reg and @offset when return 0.
- */
-static int extract_reg_offset(const struct arch *arch, const char *str,
-			      struct annotated_op_loc *op_loc)
-{
-	char *p;
-
-	if (arch->objdump.register_char == 0)
-		return -1;
-
-	/*
-	 * It should start from offset, but it's possible to skip 0
-	 * in the asm.  So 0(%rax) should be same as (%rax).
-	 *
-	 * However, it also start with a segment select register like
-	 * %gs:0x18(%rbx).  In that case it should skip the part.
-	 */
-	if (*str == arch->objdump.register_char) {
-		if (arch__is_x86(arch)) {
-			/* FIXME: Handle other segment registers */
-			if (!strncmp(str, "%gs:", 4))
-				op_loc->segment = INSN_SEG_X86_GS;
-		}
-
-		while (*str && !isdigit(*str) &&
-		       *str != arch->objdump.memory_ref_char)
-			str++;
-	}
-
-	op_loc->offset = strtol(str, &p, 0);
-	op_loc->reg1 = arch__dwarf_regnum(arch, p);
-	if (op_loc->reg1 == -1)
-		return -1;
-
-	/* Get the second register */
-	if (op_loc->multi_regs)
-		op_loc->reg2 = arch__dwarf_regnum(arch, p + 1);
-
-	return 0;
-}
-
 /**
  * annotate_get_insn_location - Get location of instruction
  * @arch: the architecture info
@@ -2548,6 +2503,7 @@ int annotate_get_insn_location(const struct arch *arch, struct disasm_line *dl,
 	struct ins_operands *ops;
 	struct annotated_op_loc *op_loc;
 	int i;
+	int ret;
 
 	if (ins__is_lock(&dl->ins))
 		ops = dl->ops.locked.ops;
@@ -2573,50 +2529,12 @@ int annotate_get_insn_location(const struct arch *arch, struct disasm_line *dl,
 		/* Invalidate the register by default */
 		op_loc->reg1 = -1;
 		op_loc->reg2 = -1;
+		op_loc->mem_ref = mem_ref;
+		op_loc->multi_regs = multi_regs;
 
-		if (insn_str == NULL) {
-			if (!arch__is_powerpc(arch))
-				continue;
-		}
-
-		/*
-		 * For powerpc, call get_powerpc_regs function which extracts the
-		 * required fields for op_loc, ie reg1, reg2, offset from the
-		 * raw instruction.
-		 */
-		if (arch__is_powerpc(arch)) {
-			op_loc->mem_ref = mem_ref;
-			op_loc->multi_regs = multi_regs;
-			get_powerpc_regs(dl->raw.raw_insn, !i, op_loc);
-		} else if (strchr(insn_str, arch->objdump.memory_ref_char)) {
-			op_loc->mem_ref = true;
-			op_loc->multi_regs = multi_regs;
-			extract_reg_offset(arch, insn_str, op_loc);
-		} else {
-			const char *s = insn_str;
-			char *p = NULL;
-
-			if (arch__is_x86(arch)) {
-				/* FIXME: Handle other segment registers */
-				if (!strncmp(insn_str, "%gs:", 4)) {
-					op_loc->segment = INSN_SEG_X86_GS;
-					op_loc->offset = strtol(insn_str + 4,
-								&p, 0);
-					if (p && p != insn_str + 4)
-						op_loc->imm = true;
-					continue;
-				}
-			}
-
-			if (*s == arch->objdump.register_char) {
-				op_loc->reg1 = arch__dwarf_regnum(arch, s);
-			}
-			else if (*s == arch->objdump.imm_char) {
-				op_loc->offset = strtol(s + 1, &p, 0);
-				if (p && p != s + 1)
-					op_loc->imm = true;
-			}
-		}
+		ret = arch->extract_op_location(arch, dl, insn_str, i, op_loc);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 696e36dbf013..71195a27d38f 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -494,6 +494,8 @@ int annotate_parse_percent_type(const struct option *opt, const char *_str,
 
 int annotate_check_args(void);
 
+int arch__dwarf_regnum(const struct arch *arch, const char *str);
+
 /**
  * struct annotated_op_loc - Location info of instruction operand
  * @reg1: First register in the operand
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index d3730ed86dba..94ee67bcbce7 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -16,6 +16,7 @@ struct symbol;
 struct data_loc_info;
 struct type_state;
 struct disasm_line;
+struct annotated_op_loc;
 
 struct e_machine_and_e_flags {
 	uint32_t e_flags;
@@ -49,6 +50,9 @@ struct arch {
 				struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				struct disasm_line *dl);
 #endif
+	int		(*extract_op_location)(const struct arch *arch, struct disasm_line *dl,
+					       const char *op_str, int op_idx,
+					       struct annotated_op_loc *op_loc);
 };
 
 struct ins {
-- 
2.34.1

