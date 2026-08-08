Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520DB3CE0A2;
	Sat,  8 Aug 2026 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786191870; cv=none; b=kx2Uc5w3cdHu07Dep5IvC19fGW6nY7es2EGj/eowQEO/49BBQsCbpN2ajZ86C3lOpYVt4F205eBIHkVR8izq59OEh+IuZsIU7WwDUHojqRtpUhJfgQ6htWhhGUUK02+NBVXx95jejQ/mmZhvOCgP01PB9ZInAAtzaSpY7KAjTE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786191870; c=relaxed/simple;
	bh=j46Non/kCvCuHskhj13We/pZwmVRvow++GkgVqV/xO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MyClIMC/LHGCwPiTaT1kSxP01Ib0UT7nReMGpYgrJ7slfoe0sZeAu+15/JNcfjKWLtA7bT5sSZhl/GBgdMIyfBCXDkknkqKvebvu637Gm1LeLEcwQDz9FsjNGS+gVfu+kCy6EYRg4p1E6UIfCSaBek3AQltT7ywSmHU8KeUz4LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hHKtH65HkzYQvhl;
	Sat,  8 Aug 2026 20:23:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0A6744056F;
	Sat,  8 Aug 2026 20:24:18 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB34YjkH3dqbrhMBg--.41805S9;
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
Subject: [PATCH v4 07/23] perf annotate: Introduce extract_op_location callback for arch-specific parsing
Date: Sat,  8 Aug 2026 12:23:44 +0000
Message-Id: <20260808122400.2961238-8-wutengda@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgB34YjkH3dqbrhMBg--.41805S9
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1DCrWrGrW8JF18XrWrKrg_yoWfZF4kpw
	4ku34rtF1rKr4YqwsrXFs5W3Wakw48WF1Y9r17K39rAFsFyrn5Jan7KF1ayF1rJrZ8ur1j
	vF4qvr4UXryFkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Assembly syntax for operands varies significantly across different
architectures, which prevents the operand location (op_loc) parsing
logic in annotate_get_insn_location() from being directly reused.

To simplify the core logic and improve maintainability, move the
operand parsing inside the for_each_insn_op_loc loop into arch-specific
extract_op_location callbacks. This refactoring is primarily a cleanup,
but includes a minor x86-specific change: errors from extract_reg_offset()
are now propagated, so unrecognized operands are correctly rejected
instead of being silently ignored, , and testing confirms no functional
regression from this change.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../util/annotate-arch/annotate-powerpc.c     | 10 ++
 tools/perf/util/annotate-arch/annotate-x86.c  | 82 ++++++++++++++++
 tools/perf/util/annotate.c                    | 94 ++-----------------
 tools/perf/util/disasm.h                      |  4 +
 4 files changed, 103 insertions(+), 87 deletions(-)

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
index 7e6136536393..6044a68966f1 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
+#include <stdlib.h>
 #include <linux/compiler.h>
+#include <linux/ctype.h>
 #include <linux/zalloc.h>
 #include <assert.h>
 #include <inttypes.h>
@@ -809,6 +811,85 @@ static void update_insn_state_x86(struct type_state *state,
 }
 #endif
 
+/*
+ * Get register number and access offset from the given instruction.
+ * It assumes AT&T x86 asm format like OFFSET(REG).
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
@@ -848,5 +929,6 @@ const struct arch *arch__new_x86(const struct e_machine_and_e_flags *id, const c
 #ifdef HAVE_LIBDW_SUPPORT
 	arch->update_insn_state = update_insn_state_x86;
 #endif
+	arch->extract_op_location = extract_op_location_x86;
 	return arch;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 9d8b4d6b859b..20be609ebed2 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2497,51 +2497,6 @@ int arch__dwarf_regnum(const struct arch *arch, const char *str)
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
@@ -2572,6 +2527,7 @@ int annotate_get_insn_location(const struct arch *arch, struct disasm_line *dl,
 	struct ins_operands *ops;
 	struct annotated_op_loc *op_loc;
 	int i;
+	int ret;
 
 	if (ins__is_lock(&dl->ins))
 		ops = dl->ops.locked.ops;
@@ -2597,49 +2553,13 @@ int annotate_get_insn_location(const struct arch *arch, struct disasm_line *dl,
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
+		if (arch->extract_op_location) {
+			ret = arch->extract_op_location(arch, dl, insn_str, i, op_loc);
+			if (ret)
+				return ret;
 		}
 	}
 
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 06c664fd4fc2..8796f92769f9 100644
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

