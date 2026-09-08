Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B765505FC;
	Tue,  8 Sep 2026 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872750; cv=none; b=b9azXtYV6cUR7kmd7x4+beFLN8MujvAzZBStztWMPbr6WT4UZJS8XmgzvTg5gegaUD6dEPkeUO7t3ZmcUqC2kQGbfm0wpQX7MuJ9n8M8XpIhtOphKut0C5fzdFRrI6y5PfP7aGozrzaj+mg6GVbYHBma7kaDvceqVe2+ewayMRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872750; c=relaxed/simple;
	bh=6rKBnKbc8LbbUcnehDkEMcRqihU2QGf4nLMbOmEmLso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FpGnFvGqUzjIvMwHcdJj8gzgrVDcx+o02JLGzk/VWiBKLbFSAQvKZ37qGIvLNtatpTKttlrax+Q4d/X8HZWPXxqbmV2ANqV3VrH961a5ocq638pZBgNqZADC5Sgkfgzqjppbh1/fDwhzSVCv2JA1Hy2eiTQybAXInnlH3I3iixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfPKv1mrNzYQw0n;
	Tue,  8 Sep 2026 21:04:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BA5AC40579;
	Tue,  8 Sep 2026 21:05:42 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDHLUoeCKBqX3XjBA--.22748S8;
	Tue, 08 Sep 2026 21:05:42 +0800 (CST)
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
Subject: [PATCH v5 06/26] perf annotate: Introduce extract_op_location callback for arch-specific parsing
Date: Tue,  8 Sep 2026 13:05:09 +0000
Message-Id: <a9f1bafb17bc2e2c6152f6e3a0c63b9d72a0e657.1788872630.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDHLUoeCKBqX3XjBA--.22748S8
X-Coremail-Antispam: 1UD129KBjvJXoWxtr13tF45uFy8Wr1kuw1xZrb_yoWfKr48pw
	4Du34Yyr1rKr4YqwsxXFs5W3Wakw4rWF1Y9r17KwsrAFn2vrn5Jan2gF1ayF1rtrZ5ur1j
	vF1qqr48XryrGaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
	AGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26rWY6Fy7MxkF7I0Ew4C2
	6cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa
	7xRxnoUUUUUUU==
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
 .../util/annotate-arch/annotate-powerpc.c     |  9 ++
 tools/perf/util/annotate-arch/annotate-x86.c  | 79 ++++++++++++++++
 tools/perf/util/annotate.c                    | 94 +------------------
 tools/perf/util/annotate.h                    |  2 +
 tools/perf/util/disasm.h                      |  4 +
 5 files changed, 99 insertions(+), 89 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-powerpc.c b/tools/perf/util/annotate-arch/annotate-powerpc.c
index 218207b52581..00b93296fc94 100644
--- a/tools/perf/util/annotate-arch/annotate-powerpc.c
+++ b/tools/perf/util/annotate-arch/annotate-powerpc.c
@@ -390,6 +390,14 @@ static void update_insn_state_powerpc(struct type_state *state,
 }
 #endif /* HAVE_LIBDW_SUPPORT */
 
+static void extract_op_location_powerpc(const struct arch *arch __maybe_unused,
+					struct disasm_line *dl,
+					const char *op_str __maybe_unused, int op_idx,
+					struct annotated_op_loc *op_loc)
+{
+	get_powerpc_regs(dl->raw.raw_insn, !op_idx, op_loc);
+}
+
 const struct arch *arch__new_powerpc(const struct e_machine_and_e_flags *id,
 				     const char *cpuid __maybe_unused)
 {
@@ -406,5 +414,6 @@ const struct arch *arch__new_powerpc(const struct e_machine_and_e_flags *id,
 #ifdef HAVE_LIBDW_SUPPORT
 	arch->update_insn_state = update_insn_state_powerpc;
 #endif
+	arch->extract_op_location = extract_op_location_powerpc;
 	return arch;
 }
diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index 7e6136536393..1acf31a2c759 100644
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
@@ -809,6 +811,82 @@ static void update_insn_state_x86(struct type_state *state,
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
+static void extract_op_location_x86(const struct arch *arch,
+				    struct disasm_line *dl __maybe_unused,
+				    const char *op_str, int op_idx __maybe_unused,
+				    struct annotated_op_loc *op_loc)
+{
+	if (op_str == NULL)
+		return;
+
+	if (strchr(op_str, arch->objdump.memory_ref_char)) {
+		op_loc->mem_ref = true;
+		extract_reg_offset(arch, op_str, op_loc);
+	} else {
+		const char *s = op_str;
+		char *p = NULL;
+
+		/* FIXME: Handle other segment registers */
+		if (!strncmp(op_str, "%gs:", 4)) {
+			op_loc->segment = INSN_SEG_X86_GS;
+			op_loc->offset = strtol(op_str + 4, &p, 0);
+			if (p && p != op_str + 4)
+				op_loc->imm = true;
+			return;
+		}
+
+		if (*s == arch->objdump.register_char) {
+			op_loc->reg1 = arch__dwarf_regnum(arch, s);
+		} else if (*s == arch->objdump.imm_char) {
+			op_loc->offset = strtol(s + 1, &p, 0);
+			if (p && p != s + 1)
+				op_loc->imm = true;
+		}
+	}
+}
+
 const struct arch *arch__new_x86(const struct e_machine_and_e_flags *id, const char *cpuid)
 {
 	struct arch *arch = zalloc(sizeof(*arch));
@@ -848,5 +926,6 @@ const struct arch *arch__new_x86(const struct e_machine_and_e_flags *id, const c
 #ifdef HAVE_LIBDW_SUPPORT
 	arch->update_insn_state = update_insn_state_x86;
 #endif
+	arch->extract_op_location = extract_op_location_x86;
 	return arch;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f3d17d153b67..a3d48cf88dad 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2472,7 +2472,7 @@ int annotate_check_args(void)
 	return 0;
 }
 
-static int arch__dwarf_regnum(const struct arch *arch, const char *str)
+int arch__dwarf_regnum(const struct arch *arch, const char *str)
 {
 	const char *p;
 	char *regname, *q;
@@ -2495,51 +2495,6 @@ static int arch__dwarf_regnum(const struct arch *arch, const char *str)
 	return reg < 0 ? -1 : reg;
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
@@ -2595,50 +2550,11 @@ int annotate_get_insn_location(const struct arch *arch, struct disasm_line *dl,
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
+		if (arch->extract_op_location)
+			arch->extract_op_location(arch, dl, insn_str, i, op_loc);
 	}
 
 	return 0;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index fa08d09b80f7..11b6e4780c02 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -492,6 +492,8 @@ int annotate_parse_percent_type(const struct option *opt, const char *_str,
 
 int annotate_check_args(void);
 
+int arch__dwarf_regnum(const struct arch *arch, const char *str);
+
 /**
  * struct annotated_op_loc - Location info of instruction operand
  * @reg1: First register in the operand
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 06c664fd4fc2..62c2949c4c30 100644
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
+	void		(*extract_op_location)(const struct arch *arch, struct disasm_line *dl,
+					       const char *op_str, int op_idx,
+					       struct annotated_op_loc *op_loc);
 };
 
 struct ins {
-- 
2.34.1

