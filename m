Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794706874;
	b=3hjtt482JqZDq7n2ZlDw98J30Q3w49FMo1Rbb8XuXmjK0Hr1Ct1z0v54XlQczcNl1cCd
	 lVX2Kvw7+j8XcC8pPxOy54sCtpA3flzFRaYM4ufb21RNQCssgj9Uu+toncH/lei+KYhuH
	 bDRNceE1XFHGhKpNTa0HofJZyTrCjsZER002K2ksZsJh82P2Je1g14eBJkrJ+dT23+tMP
	 Vi1XRNX6mJP8QsmWEiASIhovrRJO/+Jr/QtMBWTyD8VBkggOaVBEvxZysQYRCzRbXipR2
	 49q2DN2Wyv4d/pFO6mmnPoE1zwzcs3e8593TN8RCOUIXXcB6C3gb7QOcjeVO4NVd6yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706874;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=E35K9K39zctrqz1uDeaaQPmr4VKQVSrP8XLVA9lUfgQ=;
	b=3NsYKoRlp8tpe/ZG3y/Jl9iKSvookWIdxlYpPTNzGZdqaKQEeZsCnTi62GjE81ACMpdd
	 C65f6OS8Y1tra7zjqkIkuUFXBTlCiKX8L+8DWsDZajSBtEtDLuFpqDFcKQlix1rRH6iU1
	 I4THz0UwAKk0m/S+YkMOyluY/KQYYsMRIAvg3H78ePGrk3CA/lm/oPHVKn8cAuZjC1fOG
	 f4Cg3OWeNURGa1uNpi5tYPOJEoaGSAHth3x5EHWqICl+CCJELh7nJYLXf8wN6yngwID47
	 /sj2SoDVVGjNucmkGDAA8udMg3qOcvYxr1/JTr+3wso0H5BGVGdq+1x/lNhI6QYbkQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHDwuJj4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6071606A330;
	Sun, 15 Nov 2026 01:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHDwuJj4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA781F000C7;
	Sun, 15 Nov 2026 01:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794706874;
	bh=E35K9K39zctrqz1uDeaaQPmr4VKQVSrP8XLVA9lUfgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dHDwuJj4UUIUQkoVeAJW2x98aEnIbcpbKdwBWQ8wkvk1msN61W0OA+X7/t8+YuKMO
	 qrG9kWq0Eqgwti8fOO79/dnpt2qSCU0RfFjT9JElzZP9HEpGwrsr6vmu7u4Qm9rqBm
	 krxsNEo4MvwllE088dhaqd7j0uCZd786/QZl42AKgleDx2Ihf/C3gBhHaa2xPKvC+j
	 cmIGdtNzON3ZR2kMNZ8EUeT9HUZtn8gOlUFe83OkotPf+AHcrHFQl4m3DezIIdBMHX
	 F3XXZdVh7A3xs5wzu1w/fbZ9J69upRrh0B6fbIclHTzdRGF7loVSRrL6kheclVj9ks
	 xkiT7nOYBbb/g==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 02/12] perf annotate: Handle absolute addressing in data type profiling
Date: Sat, 14 Nov 2026 22:40:50 -0300
Message-ID: <20261115014102.2879372-3-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115014102.2879372-1-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
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

32-bit x86 accesses globals with absolute addresses, like
"movl %eax,0x8c73448", but the operand parser only recognized the
offset(reg) forms, so the operand had no memory reference, the resolver
saw a zero data address and resolved nothing.

Parse a bare number as an absolute memory operand, leaving jumps and
calls out, use the address in the resolver, and let the instruction
tracking record the type of an absolute global load in the destination
register.  The displacement is sign extended for 64-bit objects, as the
CPU does, and zero extended for 32-bit ones; a zero address is skipped
by both users, since it is what an unrelocated operand looks like.

With bare numbers being memory operands, a frame base register of -1,
"none", would also compare equal to the -1 "no register" of an absolute
operand and take it for a stack access, so guard those comparisons.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate-arch/annotate-x86.c | 41 ++++++++++++++++++--
 tools/perf/util/annotate.c                   | 20 +++++++++-
 tools/perf/util/annotate.h                   |  6 +++
 3 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index e38a4e7a54d5585c..297f2fe9bec79c83 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -230,6 +230,11 @@ static bool vtable_get_rettype(Dwarf_Die *class_die, int offset,
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
@@ -437,7 +442,7 @@ static void update_insn_state_x86(struct type_state *state,
 		invalidate_reg_state(tsr);
 
 		/* Case 1: Based on stack pointer or frame pointer */
-		if (sreg == fbreg || sreg == state->stack_reg) {
+		if (is_stack_or_fb_reg(state, fbreg, sreg)) {
 			struct type_state_stack *stack;
 			int offset = src->offset - fboff;
 
@@ -626,7 +631,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 retry:
 		/* Check stack variables with offset */
-		if (sreg == fbreg || sreg == state->stack_reg) {
+		if (is_stack_or_fb_reg(state, fbreg, sreg)) {
 			struct type_state_stack *stack;
 			int offset = src->offset - fboff;
 
@@ -741,6 +746,29 @@ static void update_insn_state_x86(struct type_state *state,
 				     insn_offset, addr, dst->reg1);
 			pr_debug_type_name(&type_die, tsr->kind);
 		}
+		/* Or an absolute address, as used by 32-bit code */
+		else if (annotated_op_loc__is_abs(src)) {
+			struct map_symbol *ms = dloc->ms;
+			u64 ip = ms->sym->start + dl->al.offset;
+			u64 addr = annotated_op_loc__abs_addr(src, map__dso(ms->map));
+			int offset;
+
+			if (!get_global_var_type(cu_die, dloc, ip, addr, &offset,
+						 &type_die) ||
+			    !die_get_member_type(&type_die, offset, &type_die)) {
+				invalidate_reg_state(tsr);
+				return;
+			}
+
+			tsr->type = type_die;
+			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
+			tsr->ok = true;
+
+			pr_debug_dtp("mov [%x] global addr=%#"PRIx64" -> reg%d",
+				     insn_offset, addr, dst->reg1);
+			pr_debug_type_name(&type_die, tsr->kind);
+		}
 		/* And check percpu access with base register */
 		else if (has_reg_type(state, sreg) &&
 			 state->regs[sreg].kind == TSR_KIND_PERCPU_BASE) {
@@ -827,7 +855,7 @@ static void update_insn_state_x86(struct type_state *state,
 	/* Case 3. register to memory transfers */
 	if (!src->mem_ref && dst->mem_ref) {
 		/* Check stack variables with offset */
-		if (dst->reg1 == fbreg || dst->reg1 == state->stack_reg) {
+		if (is_stack_or_fb_reg(state, fbreg, dst->reg1)) {
 			struct type_state_stack *stack;
 			int offset = dst->offset - fboff;
 
@@ -931,7 +959,7 @@ static int extract_reg_offset(const struct arch *arch, const char *str,
 }
 
 static void extract_op_location_x86(const struct arch *arch,
-				    struct disasm_line *dl __maybe_unused,
+				    struct disasm_line *dl,
 				    const char *op_str, int op_idx __maybe_unused,
 				    struct annotated_op_loc *op_loc)
 {
@@ -960,6 +988,11 @@ static void extract_op_location_x86(const struct arch *arch,
 			op_loc->offset = strtol(s + 1, &p, 0);
 			if (p && p != s + 1)
 				op_loc->imm = true;
+		} else if (isdigit(*s) && !ins__is_jump(&dl->ins) &&
+			   !ins__is_call(&dl->ins)) {
+			/* Absolute address, as used by 32-bit code */
+			op_loc->mem_ref = true;
+			op_loc->offset = strtoull(s, NULL, 0);
 		}
 	}
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 86a4beec6528e9bd..56fffe598634c441 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2605,6 +2605,19 @@ int arch__dwarf_regnum(const struct arch *arch, const char *str)
 	return reg < 0 ? -1 : reg;
 }
 
+bool annotated_op_loc__is_abs(const struct annotated_op_loc *op_loc)
+{
+	return op_loc->mem_ref && op_loc->reg1 == -1 && op_loc->reg2 == -1 &&
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
@@ -2622,7 +2635,7 @@ int arch__dwarf_regnum(const struct arch *arch, const char *str)
  *   mov  (%rax), %rcx   # src_reg1 = rax, src_mem = 1, src_offset = 0
  *                       # dst_reg1 = rcx, dst_mem = 0
  *
- *   mov  0x18, %r8      # src_reg1 = -1, src_mem = 0
+ *   mov  0x18, %r8      # src_reg1 = -1, src_mem = 1, src_offset = 0x18
  *                       # dst_reg1 = r8, dst_mem = 0
  *
  *   mov  %rsi, 8(%rbx,%rcx,4)  # src_reg1 = rsi, src_mem = 0, src_multi_regs = 0
@@ -2894,6 +2907,11 @@ __hist_entry__get_data_type(struct hist_entry *he, const struct arch *arch,
 			dloc.var_addr = annotate_calc_pcrel(ms, dloc.ip,
 							    op_loc->offset, dl);
 		}
+		/* Absolute addressing, as used by 32-bit code */
+		else if (annotated_op_loc__is_abs(op_loc)) {
+			dloc.var_addr = annotated_op_loc__abs_addr(op_loc, map__dso(ms->map));
+			op_loc->reg1 = DWARF_REG_PC;
+		}
 
 		/* This CPU access in kernel - pretend PC-relative addressing */
 		if (dso__kernel(map__dso(ms->map)) && arch__is_x86(arch) &&
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 1b47c1156b9a72e1..43d365807daf2107 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -18,6 +18,7 @@
 #include "branch.h"
 #include "evsel.h"
 
+struct dso;
 struct hist_browser_timer;
 struct hist_entry;
 struct map;
@@ -638,6 +639,11 @@ struct annotated_insn_loc {
 	     i < INSN_OP_MAX;						\
 	     i++, op_loc++)
 
+/* Bare number operand, as used by 32-bit code to access globals */
+bool annotated_op_loc__is_abs(const struct annotated_op_loc *op_loc);
+u64 annotated_op_loc__abs_addr(const struct annotated_op_loc *op_loc,
+			       const struct dso *dso);
+
 /* Get detailed location info in the instruction */
 int annotate_get_insn_location(const struct arch *arch, struct disasm_line *dl,
 			       struct annotated_insn_loc *loc);
-- 
2.56.0

