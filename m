Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009E91A23AF;
	Fri, 14 Mar 2025 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940445; cv=none; b=SXPdSif+cdbJpnanPxY9BU8rTW80FZRHhD435vahlYU2TTDmpsMyeFSc6oTBvdR5/xlca5DCpjZmeuxqeigYegj6xgkQAuKwkFiUnh2j0nSueWoUjiVV/BLZr4Do2pkaIixwbG8PNhnzgKJYkhV2IjYH6jOSvz9bqmEyvq+Zf6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940445; c=relaxed/simple;
	bh=q2yqBFQZAYDkjfuTRJZqypQntEg7cDJWbhXojvKxSxA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivHWU76iAdiSeyk6ctqimfzmyuy/Ln0yMf5xdtiL0W/JlR9PB+iTop3r8CbpAPcZ8e0uGQIhpwXpVRKIIXy1tmc6Zy4ghnXNLQesHo2FcP1HyewUX+Vu84dMiNZL/UEzFuD+giDXOGiXf3pvh12GKqpGw3OX6CzZoWCVeOIiGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZDcdX1Jxdz2RTXM;
	Fri, 14 Mar 2025 16:16:16 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 264DF14022D;
	Fri, 14 Mar 2025 16:20:40 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Mar 2025 16:20:39 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <namhyung@kernel.org>, <acme@kernel.org>, <leo.yan@linux.dev>,
	<james.clark@linaro.org>, <mark.rutland@arm.com>, <john.g.garry@oracle.com>,
	<will@kernel.org>, <irogers@google.com>
CC: <mike.leach@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<kjain@linux.ibm.com>, <mhiramat@kernel.org>, <atrajeev@linux.vnet.ibm.com>,
	<sesse@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH 3/7] perf annotate: Add 'extract_reg_offset' callback function to extract register number and access offset
Date: Sat, 15 Mar 2025 00:21:33 +0800
Message-ID: <20250314162137.528204-4-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250314162137.528204-1-lihuafei1@huawei.com>
References: <20250314162137.528204-1-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500004.china.huawei.com (7.202.181.242)

The assembly syntax for memory access instructions varies significantly
across different architectures, which makes it difficult to reuse the
code for extracting register numbers and access offsets in the function
annotate_get_insn_location().

To simplify the code, the extraction of register numbers and access
offsets from operands is written as a callback function for the
architecture, facilitating the implementation of architecture-specific
extraction logic.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 .../perf/arch/powerpc/annotate/instructions.c |  10 ++
 tools/perf/arch/x86/annotate/instructions.c   |  99 ++++++++++++++++
 tools/perf/util/annotate.c                    | 107 +-----------------
 tools/perf/util/disasm.c                      |   2 +
 tools/perf/util/disasm.h                      |   4 +
 5 files changed, 117 insertions(+), 105 deletions(-)

diff --git a/tools/perf/arch/powerpc/annotate/instructions.c b/tools/perf/arch/powerpc/annotate/instructions.c
index ca567cfdcbdb..fd6516890f3b 100644
--- a/tools/perf/arch/powerpc/annotate/instructions.c
+++ b/tools/perf/arch/powerpc/annotate/instructions.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
+#include <dwarf-regs.h>
 
 static struct ins_ops *powerpc__associate_instruction_ops(struct arch *arch, const char *name)
 {
@@ -315,3 +316,12 @@ static int powerpc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 
 	return 0;
 }
+
+static int extract_reg_offset_powerpc(struct arch *arch __maybe_unused,
+				      struct disasm_line *dl,
+				      const char *insn_str __maybe_unused, int insn_ops,
+				      struct annotated_op_loc *op_loc)
+{
+	get_powerpc_regs(dl->raw.raw_insn, insn_ops == INSN_OP_SOURCE, op_loc);
+	return 0;
+}
diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index ae94b1f0b9cc..83e0fc4b9788 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -596,3 +596,102 @@ static void update_insn_state_x86(struct type_state *state,
 	/* Case 4. memory to memory transfers (not handled for now) */
 }
 #endif
+
+/*
+ * Get register number and access offset from the given instruction.
+ * It assumes AT&T x86 asm format like OFFSET(REG).  Maybe it needs
+ * to revisit the format when it handles different architecture.
+ * Fills @reg and @offset when return 0.
+ */
+static int extract_reg_offset(struct arch *arch, const char *str,
+			      struct annotated_op_loc *op_loc)
+{
+	char *p;
+	char *regname;
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
+
+	p = strchr(p, arch->objdump.register_char);
+	if (p == NULL)
+		return -1;
+
+	regname = strdup(p);
+	if (regname == NULL)
+		return -1;
+
+	op_loc->reg1 = get_dwarf_regnum(regname, arch->e_machine, arch->e_flags);
+	free(regname);
+
+	/* Get the second register */
+	if (op_loc->multi_regs) {
+		p = strchr(p + 1, arch->objdump.register_char);
+		if (p == NULL)
+			return -1;
+
+		regname = strdup(p);
+		if (regname == NULL)
+			return -1;
+
+		op_loc->reg2 = get_dwarf_regnum(regname, arch->e_machine, arch->e_flags);
+		free(regname);
+	}
+	return 0;
+}
+
+static int extract_reg_offset_x86(struct arch *arch, struct disasm_line *dl __maybe_unused,
+				  const char *insn_str, int insn_ops __maybe_unused,
+				  struct annotated_op_loc *op_loc)
+{
+	if (insn_str == NULL)
+		return 0;
+
+	if (op_loc->mem_ref) {
+		extract_reg_offset(arch, insn_str, op_loc);
+	} else {
+		char *s, *p = NULL;
+
+		/* FIXME: Handle other segment registers */
+		if (!strncmp(insn_str, "%gs:", 4)) {
+			op_loc->segment = INSN_SEG_X86_GS;
+			op_loc->offset = strtol(insn_str + 4, &p, 0);
+			if (p && p != insn_str + 4)
+				op_loc->imm = true;
+			return 0;
+		}
+
+		s = strdup(insn_str);
+		if (s == NULL)
+			return -1;
+
+		if (*s == arch->objdump.register_char)
+			op_loc->reg1 = get_dwarf_regnum(s, arch->e_machine, arch->e_flags);
+		else if (*s == arch->objdump.imm_char) {
+			op_loc->offset = strtol(s + 1, &p, 0);
+			if (p && p != s + 1)
+				op_loc->imm = true;
+		}
+		free(s);
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 860ea6c72411..288200e4b2b5 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2318,69 +2318,6 @@ int annotate_check_args(void)
 	return 0;
 }
 
-/*
- * Get register number and access offset from the given instruction.
- * It assumes AT&T x86 asm format like OFFSET(REG).  Maybe it needs
- * to revisit the format when it handles different architecture.
- * Fills @reg and @offset when return 0.
- */
-static int extract_reg_offset(struct arch *arch, const char *str,
-			      struct annotated_op_loc *op_loc)
-{
-	char *p;
-	char *regname;
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
-		if (arch__is(arch, "x86")) {
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
-
-	p = strchr(p, arch->objdump.register_char);
-	if (p == NULL)
-		return -1;
-
-	regname = strdup(p);
-	if (regname == NULL)
-		return -1;
-
-	op_loc->reg1 = get_dwarf_regnum(regname, arch->e_machine, arch->e_flags);
-	free(regname);
-
-	/* Get the second register */
-	if (op_loc->multi_regs) {
-		p = strchr(p + 1, arch->objdump.register_char);
-		if (p == NULL)
-			return -1;
-
-		regname = strdup(p);
-		if (regname == NULL)
-			return -1;
-
-		op_loc->reg2 = get_dwarf_regnum(regname, arch->e_machine, arch->e_flags);
-		free(regname);
-	}
-	return 0;
-}
-
 /**
  * annotate_get_insn_location - Get location of instruction
  * @arch: the architecture info
@@ -2437,51 +2374,11 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 		op_loc->reg1 = -1;
 		op_loc->reg2 = -1;
 
-		if (insn_str == NULL) {
-			if (!arch__is(arch, "powerpc"))
-				continue;
-		}
-
 		op_loc->mem_ref = mem_ref;
 		op_loc->multi_regs = multi_regs;
 
-		/*
-		 * For powerpc, call get_powerpc_regs function which extracts the
-		 * required fields for op_loc, ie reg1, reg2, offset from the
-		 * raw instruction.
-		 */
-		if (arch__is(arch, "powerpc")) {
-			get_powerpc_regs(dl->raw.raw_insn, !i, op_loc);
-		} else if (mem_ref) {
-			extract_reg_offset(arch, insn_str, op_loc);
-		} else {
-			char *s, *p = NULL;
-
-			if (arch__is(arch, "x86")) {
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
-			s = strdup(insn_str);
-			if (s == NULL)
-				return -1;
-
-			if (*s == arch->objdump.register_char)
-				op_loc->reg1 = get_dwarf_regnum(s, arch->e_machine, arch->e_flags);
-			else if (*s == arch->objdump.imm_char) {
-				op_loc->offset = strtol(s + 1, &p, 0);
-				if (p && p != s + 1)
-					op_loc->imm = true;
-			}
-			free(s);
-		}
+		if (arch->extract_reg_offset(arch, dl, insn_str, i, op_loc))
+			return -1;
 	}
 
 	return 0;
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index d91526cff9df..905eceb824a4 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -155,6 +155,7 @@ static struct arch architectures[] = {
 #ifdef HAVE_LIBDW_SUPPORT
 		.update_insn_state = update_insn_state_x86,
 #endif
+		.extract_reg_offset = extract_reg_offset_x86,
 	},
 	{
 		.name = "powerpc",
@@ -162,6 +163,7 @@ static struct arch architectures[] = {
 #ifdef HAVE_LIBDW_SUPPORT
 		.update_insn_state = update_insn_state_powerpc,
 #endif
+		.extract_reg_offset = extract_reg_offset_powerpc,
 	},
 	{
 		.name = "riscv64",
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index c135db2416b5..44ac5aa892f7 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -16,6 +16,7 @@ struct symbol;
 struct data_loc_info;
 struct type_state;
 struct disasm_line;
+struct annotated_op_loc;
 
 struct arch {
 	const char	*name;
@@ -44,6 +45,9 @@ struct arch {
 				struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				struct disasm_line *dl);
 #endif
+	int		(*extract_reg_offset)(struct arch *arch, struct disasm_line *dl,
+					      const char *insn_str, int insn_ops,
+					      struct annotated_op_loc *op_loc);
 	/** @e_machine: ELF machine associated with arch. */
 	unsigned int e_machine;
 	/** @e_flags: Optional ELF flags associated with arch. */
-- 
2.25.1

