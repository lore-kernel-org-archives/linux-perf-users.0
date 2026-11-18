Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039054;
	b=GoXcjvBTp+GCoXzYv/DTBrEm69UDVGkZV4PImYuecuSh9CTL/kNaAh/cX6qeLW6Bke1p
	 0kesWoSh5VVYY2LJGshSNO7MlTQ2Ug6yFF5jkSx1OOTiHA6TojSqJ2Bqj9LFTfR37RlOD
	 D4ikw2iFfAIeKSEc9J51entkm9rLidXaUGucJ+qL2881M+fVvTy+4cXkvHJlV8gVGqAwk
	 wKQPP1G0b7su5e3rAURPHajkyiA7WcH9IiCHbxweC8am/oaUOwd61J2DYu1pYhGBm/BWj
	 mrs32yP0ND5kQ3xb5s0QWghe27hhiJ5af74qbjTM0143vs1HCKcLi2Jzebq6qPq43uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039054;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9CIjXzr8V0sZXnCo8edQ+bMF29NqYglN+Z7eVSvcmyg=;
	b=NsevlGgkxfQDzl/qcA8Ny2gPB351fYysVE/cEBPYF+9UfiwdxVyAUKPHRroDKwAMwDM3
	 sxLyBQq6O+VXIW0N/H5N8K0GQP11KFpWNBFxriKfNyj66TMsjiI8i/AQ6CUrp2quZh6aK
	 rELRDVjVhAkjQ/wfyQB++2asul3XP8GyKUqbzsOY1h8Mi2hKcB5scvUv+xwvgRAyJ72eo
	 8kb7E3WCfkjgjy5fWVs6/IU37JotgnhExlJIdTymGd2tD60teohbmGzoZhaZek/XTX9sY
	 qgzdzReBrhfAtiYo/ys0UPbaEghgg5RVSMW/93MyJQrB2ob6t8wdVXzkZ1dsQm7TQNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ab+aAsGm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36575606A325;
	Wed, 18 Nov 2026 21:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ab+aAsGm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269881F000C4;
	Wed, 18 Nov 2026 21:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039054;
	bh=9CIjXzr8V0sZXnCo8edQ+bMF29NqYglN+Z7eVSvcmyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ab+aAsGmEhv4ToRyYqB7QTLy4Qg/htXHJJE2CNAOU06dKyqrqB5lSgVc6FhlqRvrt
	 6Oe4dnbcqOXbcu1cA2SlynLfQgVCuFOfIjtr5I55Ak+c+zB1mIX9zEkCqZw+F1y9lb
	 Cm5RM2lnUpYj6hE/PWuZrSVy6ylL9sPo8s95qnGaytn1pddHJvxlcJe5lF2yk1Wzeh
	 Uozre0Sx+Cme1Jqfkpm4wn6isi75FqrodNZriTM+qjbqE5jPjxwZyfJg7bfeKgUKXN
	 8giqKUMAWG8nAymMXVzbG1zZw0+EqOO7kLAnQ2Or+ia1v7HaGYsUdgWkdd0jZUxHp1
	 jJg9CRc5tpHzA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v7 03/13] perf annotate: Handle absolute addressing in data type profiling
Date: Wed, 18 Nov 2026 18:57:05 -0300
Message-ID: <20261118215716.114868-4-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118215716.114868-1-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

32-bit x86 accesses globals with absolute addresses, like
"movl %eax,0x8c73448", but the operand parser only recognized the
offset(reg) forms, so the operand had no memory reference and the
resolver skipped it as not a memory access.

Parse a bare hex number as an absolute memory operand, including the
negative disp32 the LLVM disassembler prints for values that do not fit
an int, and use the address in the resolver; calls, whose operand is a
branch target, are left out.  Let the instruction tracking record the
type of an absolute global load in the destination register.  The
displacement is sign extended for 64-bit objects, as the CPU does, and
zero extended for 32-bit ones.  Values that do not fit the int offset,
zero and the operands of relocatable objects, which are unrelocated
addends, are skipped.

With bare numbers being memory operands, a frame base register of -1,
"none", would also compare equal to the -1 "no register" of an absolute
operand and take it for a stack access, so guard those comparisons.
Operands left with no register, like a user space "%gs:imm", are no
longer looked up as variables, which can change the data type stats of
those samples.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate-arch/annotate-x86.c | 43 ++++++++++++++++----
 tools/perf/util/annotate.c                   | 27 +++++++++++-
 tools/perf/util/annotate.h                   |  7 ++++
 3 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index e38a4e7a54d5585c..7bcc93405b907628 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
 #include <stdlib.h>
+#include <limits.h>
 #include <linux/compiler.h>
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
@@ -230,6 +231,11 @@ static bool vtable_get_rettype(Dwarf_Die *class_die, int offset,
 	return die_get_real_type(&func_die, type_die) != NULL;
 }
 
+static bool is_stack_or_fb_reg(struct type_state *state, int fbreg, int reg)
+{
+	return (fbreg != -1 && reg == fbreg) || reg == state->stack_reg;
+}
+
 static void update_insn_state_x86(struct type_state *state,
 				  struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				  struct disasm_line *dl)
@@ -437,7 +443,7 @@ static void update_insn_state_x86(struct type_state *state,
 		invalidate_reg_state(tsr);
 
 		/* Case 1: Based on stack pointer or frame pointer */
-		if (sreg == fbreg || sreg == state->stack_reg) {
+		if (is_stack_or_fb_reg(state, fbreg, sreg)) {
 			struct type_state_stack *stack;
 			int offset = src->offset - fboff;
 
@@ -626,7 +632,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 retry:
 		/* Check stack variables with offset */
-		if (sreg == fbreg || sreg == state->stack_reg) {
+		if (is_stack_or_fb_reg(state, fbreg, sreg)) {
 			struct type_state_stack *stack;
 			int offset = src->offset - fboff;
 
@@ -717,13 +723,17 @@ static void update_insn_state_x86(struct type_state *state,
 			pr_debug_type_name(&tsr->type, tsr->kind);
 		}
 		/* Or check if it's a global variable */
-		else if (sreg == DWARF_REG_PC) {
+		else if (sreg == DWARF_REG_PC ||
+			 annotated_op_loc__is_abs(src, map__dso(dloc->ms->map))) {
 			struct map_symbol *ms = dloc->ms;
 			u64 ip = ms->sym->start + dl->al.offset;
 			u64 addr;
 			int offset;
 
-			addr = annotate_calc_pcrel(ms, ip, src->offset, dl);
+			if (sreg == DWARF_REG_PC)
+				addr = annotate_calc_pcrel(ms, ip, src->offset, dl);
+			else
+				addr = annotated_op_loc__abs_addr(src, map__dso(ms->map));
 
 			if (!get_global_var_type(cu_die, dloc, ip, addr, &offset,
 						 &type_die) ||
@@ -737,7 +747,7 @@ static void update_insn_state_x86(struct type_state *state,
 			tsr->offset = 0;
 			tsr->ok = true;
 
-			pr_debug_dtp("mov [%x] global addr=%"PRIx64" -> reg%d",
+			pr_debug_dtp("mov [%x] global addr=%#"PRIx64" -> reg%d",
 				     insn_offset, addr, dst->reg1);
 			pr_debug_type_name(&type_die, tsr->kind);
 		}
@@ -827,7 +837,7 @@ static void update_insn_state_x86(struct type_state *state,
 	/* Case 3. register to memory transfers */
 	if (!src->mem_ref && dst->mem_ref) {
 		/* Check stack variables with offset */
-		if (dst->reg1 == fbreg || dst->reg1 == state->stack_reg) {
+		if (is_stack_or_fb_reg(state, fbreg, dst->reg1)) {
 			struct type_state_stack *stack;
 			int offset = dst->offset - fboff;
 
@@ -931,7 +941,7 @@ static int extract_reg_offset(const struct arch *arch, const char *str,
 }
 
 static void extract_op_location_x86(const struct arch *arch,
-				    struct disasm_line *dl __maybe_unused,
+				    struct disasm_line *dl,
 				    const char *op_str, int op_idx __maybe_unused,
 				    struct annotated_op_loc *op_loc)
 {
@@ -960,6 +970,25 @@ static void extract_op_location_x86(const struct arch *arch,
 			op_loc->offset = strtol(s + 1, &p, 0);
 			if (p && p != s + 1)
 				op_loc->imm = true;
+		} else if ((*s == '-' || strstarts(s, "0x")) &&
+			   !ins__is_call(&dl->ins)) {
+			bool neg = *s == '-';
+			u64 offset = strtoull(s + neg, NULL, 0);
+
+			if (neg)
+				offset = -offset;
+			/*
+			 * Keep only what fits the int, as disp32 or as a u32;
+			 * a 64-bit absolute value is left out.  The LLVM
+			 * disassembler prints a disp32 that does not fit an
+			 * int as a negative number.
+			 */
+			if (offset != 0 && (offset <= UINT_MAX ||
+					    (s64)(int)offset == (s64)offset)) {
+				/* An absolute address: 32-bit code, or a 64-bit disp32 */
+				op_loc->mem_ref = true;
+				op_loc->offset = offset;
+			}
 		}
 	}
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 86a4beec6528e9bd..74e3d8e6436cad3c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2605,6 +2605,21 @@ int arch__dwarf_regnum(const struct arch *arch, const char *str)
 	return reg < 0 ? -1 : reg;
 }
 
+/* A relocatable object's operand is an unrelocated addend, not an address */
+bool annotated_op_loc__is_abs(const struct annotated_op_loc *op_loc,
+			      const struct dso *dso)
+{
+	return !dso__rel(dso) && op_loc->mem_ref && op_loc->reg1 == -1 && op_loc->reg2 == -1 &&
+	       op_loc->segment == INSN_SEG_NONE && op_loc->offset != 0;
+}
+
+/* The disp32 of a 64-bit object is sign extended, a 32-bit one is not */
+u64 annotated_op_loc__abs_addr(const struct annotated_op_loc *op_loc,
+			       const struct dso *dso)
+{
+	return dso__is_64_bit(dso) ? (u64)(s64)op_loc->offset : (u32)op_loc->offset;
+}
+
 /**
  * annotate_get_insn_location - Get location of instruction
  * @arch: the architecture info
@@ -2622,7 +2637,7 @@ int arch__dwarf_regnum(const struct arch *arch, const char *str)
  *   mov  (%rax), %rcx   # src_reg1 = rax, src_mem = 1, src_offset = 0
  *                       # dst_reg1 = rcx, dst_mem = 0
  *
- *   mov  0x18, %r8      # src_reg1 = -1, src_mem = 0
+ *   mov  0x18, %r8      # src_reg1 = -1, src_mem = 1, src_offset = 0x18
  *                       # dst_reg1 = r8, dst_mem = 0
  *
  *   mov  %rsi, 8(%rbx,%rcx,4)  # src_reg1 = rsi, src_mem = 0, src_multi_regs = 0
@@ -2894,6 +2909,13 @@ __hist_entry__get_data_type(struct hist_entry *he, const struct arch *arch,
 			dloc.var_addr = annotate_calc_pcrel(ms, dloc.ip,
 							    op_loc->offset, dl);
 		}
+		/* An absolute address: 32-bit code, or a 64-bit disp32 */
+		else if (annotated_op_loc__is_abs(op_loc, map__dso(ms->map))) {
+			struct dso *dso = map__dso(ms->map);
+
+			dloc.var_addr = annotated_op_loc__abs_addr(op_loc, dso);
+			op_loc->reg1 = DWARF_REG_PC;
+		}
 
 		/* This CPU access in kernel - pretend PC-relative addressing */
 		if (dso__kernel(map__dso(ms->map)) && arch__is_x86(arch) &&
@@ -2902,6 +2924,9 @@ __hist_entry__get_data_type(struct hist_entry *he, const struct arch *arch,
 			op_loc->reg1 = DWARF_REG_PC;
 		}
 
+		if (op_loc->reg1 == -1)
+			continue;
+
 		mem_type = find_data_type(&dloc);
 
 		if (mem_type == NULL && is_stack_canary(arch, op_loc)) {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 1b47c1156b9a72e1..1b0991d4e98c911e 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -18,6 +18,7 @@
 #include "branch.h"
 #include "evsel.h"
 
+struct dso;
 struct hist_browser_timer;
 struct hist_entry;
 struct map;
@@ -638,6 +639,12 @@ struct annotated_insn_loc {
 	     i < INSN_OP_MAX;						\
 	     i++, op_loc++)
 
+/* Bare number operand, as used by 32-bit code to access globals */
+bool annotated_op_loc__is_abs(const struct annotated_op_loc *op_loc,
+			      const struct dso *dso);
+u64 annotated_op_loc__abs_addr(const struct annotated_op_loc *op_loc,
+			       const struct dso *dso);
+
 /* Get detailed location info in the instruction */
 int annotate_get_insn_location(const struct arch *arch, struct disasm_line *dl,
 			       struct annotated_insn_loc *loc);
-- 
2.56.1

