Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634606;
	b=qmTq6wWJQbdBlFgwFt6YhqkNXD9CRv1ge+lARe0Ih1P9dcB2y1CeYvpp9l+E46KTk1K/
	 ZS6b+/qCmDZNVfoQRe/rmEQtN0FF7CZBRfhn+3DmNAgwnkq9e1Jos+9oDs/mW6zf2cGgC
	 nP6yW8L1+639iMNsDEwYy8mKfP3+b8q/FdRyQFMwfSpRkgmcx1Ft7OoLXJDRfqzJxN3aK
	 nJvlQbT3FN7pcIEs00/AFuPGo+nCujOHxcr5Poe4Z653c2/eLqzGFndnTIAkl7nANP50C
	 d2HSeRuA4jF/+0jxHbRNPH1X0Nl73sAt/5w7JCOFivB9zrkiFcLvKFoYm4J+DdyyomA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634606;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=b03U+UWXjRLL4FuQkseJvaJe5+hYbNIVkqTDrj3Ro0Q=;
	b=J4RLjyq40JLwkovX/clPq4dglsTvpS6x/SW+C7salpNoL3HEFFdJwyetjlP9LYmsMfAu
	 P+285MW8Aec+IwPMT+75ajeLyoir5qtlGtb7p4lO0F8juqwOTdUyzxgde6YUu168E+MWt
	 WbmH7ss7TQsEnAW8HKxN5insirUBg8VP5a9fL8NDWP0E3jafqBNdlLyb9jdMSGXvisp29
	 MMX/OTozVNKTG5XypHzmjXDNF08EFzOeoSqkSGv6IDLZKrGpthD6GdKyCfXvNgEn7+OFb
	 MYzXXmlZu7KvOHsa8w3Fj4ZQ61WlbVQGksbPaKVoZx0IhGKGnOlJh21PhSV62lxa/xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oKCY13d2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468EC606A321;
	Wed, 25 Nov 2026 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oKCY13d2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C251F000C0;
	Wed, 25 Nov 2026 19:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634605;
	bh=b03U+UWXjRLL4FuQkseJvaJe5+hYbNIVkqTDrj3Ro0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oKCY13d28EN6YUtjj1FqaU10gzDEeAzMiB4NNcdWX/oa4womZQRQ6gcGVUS3hciNU
	 affJegTBFvZTl3rDORco8qaiLATUxyZbQkBKcVMGw1klBmk3XUV0MRb1cXyo4Xld4k
	 hM5Q1xVWp54wCMjZq/R1EyE92Zd3+NOKgUydoEH+jk7jviNCajSkS0hBjeCKNx/rym
	 vsRZOkN2D2dwiHKSwoXCqWyPDZiMltFF0hWcLsu863coRQ5zoeZZ4Vs4YKiFEeaCGr
	 wI7F1guk95fq7AXJ3PgU/BV8/xwn1sNudxK+ROu0MdEcqD1kVyfgBD1yr/NlqLQns9
	 V7dGM++Qvo7yw==
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
Subject: [PATCH v13 02/19] perf annotate: Handle absolute addressing in data type profiling
Date: Wed, 25 Nov 2026 16:22:55 -0300
Message-ID: <20261125192312.34134-3-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125192312.34134-1-acme@kernel.org>
References: <20261125192312.34134-1-acme@kernel.org>
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

x86 code accesses globals with absolute addresses, and 64-bit code also
uses the same encoding for MMIO: the 64-bit kernel's
__default_send_IPI_dest_field uses a disp32 the CPU sign extends, an
absolute SIB with no base and no index.  From an allmodconfig clang build,
arch/x86/kernel/ipi.o:

  890:  8b 04 25 00 c3 5f ff    mov    0xffffffffff5fc300,%eax
  8b1:  89 3c 25 10 c3 5f ff    mov    %edi,0xffffffffff5fc310

These accesses are local APIC MMIO, but demonstrate the absolute SIB
encoding.  Absolute global accesses in 32-bit code can be resolved to
types as well.

llvm-objdump prints the same displacements as -0xa03d00 and -0xa03cf0.
The operand parser only recognized offset(reg), so the resolver skipped
the access as not a memory reference.

Parse a bare hex number as an absolute memory operand, including the
negative disp32 llvm-objdump prints, and use the address in the resolver.
The displacement is sign extended for 64-bit objects and zero extended
for 32-bit ones; values that do not fit, zero and relocatable addends are
skipped.  A bare number is an address only in AT&T output, where an
immediate carries $; Intel syntax prints both bare, so there it is not
taken for an address.  Branch targets do not come through the operand
strings at all: call and jump operands are resolved by their own parse
methods.

An absolute global load records the type in the destination register, so
the state is TSR_KIND_TYPE; a POINTER state records the address itself.
Guard the comparisons that made a -1 frame base equal the -1 "no
register" of an absolute operand.  A no-register operand is not looked up
as a variable, but the %gs:40 kernel stack canary is still recognized;
other segment-relative operands are skipped.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate-arch/annotate-x86.c | 44 +++++++++++++++++---
 tools/perf/util/annotate.c                   | 31 +++++++++++++-
 tools/perf/util/annotate.h                   |  7 ++++
 3 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index e38a4e7a54d5585c..58991569db9b0da2 100644
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
 
@@ -944,6 +954,13 @@ static void extract_op_location_x86(const struct arch *arch,
 	} else {
 		const char *s = op_str;
 		char *p = NULL;
+		/*
+		 * AT&T marks an immediate with $ and prints an absolute
+		 * access bare; Intel syntax prints both bare, so a number
+		 * is only an address in AT&T disassembly.
+		 */
+		bool att = !annotate_opts.disassembler_style ||
+			   strstarts(annotate_opts.disassembler_style, "att");
 
 		/* FIXME: Handle other segment registers */
 		if (!strncmp(op_str, "%gs:", 4)) {
@@ -960,6 +977,21 @@ static void extract_op_location_x86(const struct arch *arch,
 			op_loc->offset = strtol(s + 1, &p, 0);
 			if (p && p != s + 1)
 				op_loc->imm = true;
+		} else if (att && (*s == '-' || strstarts(s, "0x"))) {
+			u64 offset = strtoull(s, NULL, 0);
+			bool exact;
+
+			/*
+			 * The offset is an int: a disp32 fits it as a u32 or,
+			 * sign extended, as an int, which is how the LLVM
+			 * disassembler prints one that does not fit an int.
+			 */
+			exact = (s64)(int)offset == (s64)offset;
+			if (offset != 0 && (offset <= UINT_MAX || exact)) {
+				/* An absolute address: 32-bit code, or a 64-bit disp32 */
+				op_loc->mem_ref = true;
+				op_loc->offset = offset;
+			}
 		}
 	}
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e270d16ce1778487..c41d23d97c005abc 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2755,6 +2755,21 @@ int arch__dwarf_regnum(const struct arch *arch, const char *str)
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
@@ -2772,7 +2787,7 @@ int arch__dwarf_regnum(const struct arch *arch, const char *str)
  *   mov  (%rax), %rcx   # src_reg1 = rax, src_mem = 1, src_offset = 0
  *                       # dst_reg1 = rcx, dst_mem = 0
  *
- *   mov  0x18, %r8      # src_reg1 = -1, src_mem = 0
+ *   mov  0x18, %r8      # src_reg1 = -1, src_mem = 1, src_offset = 0x18
  *                       # dst_reg1 = r8, dst_mem = 0
  *
  *   mov  %rsi, 8(%rbx,%rcx,4)  # src_reg1 = rsi, src_mem = 0, src_multi_regs = 0
@@ -3046,6 +3061,13 @@ __hist_entry__get_data_type(struct hist_entry *he, const struct arch *arch,
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
@@ -3054,7 +3076,9 @@ __hist_entry__get_data_type(struct hist_entry *he, const struct arch *arch,
 			op_loc->reg1 = DWARF_REG_PC;
 		}
 
-		mem_type = find_data_type(&dloc);
+		mem_type = NULL;
+		if (op_loc->reg1 != -1)
+			mem_type = find_data_type(&dloc);
 
 		if (mem_type == NULL && is_stack_canary(arch, op_loc)) {
 			istat->good++;
@@ -3062,6 +3086,9 @@ __hist_entry__get_data_type(struct hist_entry *he, const struct arch *arch,
 			return &canary_type;
 		}
 
+		if (op_loc->reg1 == -1)
+			continue;
+
 		if (mem_type)
 			istat->good++;
 		else
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index e0fc48ec561225d9..58adf7f84146be5f 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -18,6 +18,7 @@
 #include "branch.h"
 #include "evsel.h"
 
+struct dso;
 struct hist_browser_timer;
 struct hist_entry;
 struct map;
@@ -637,6 +638,12 @@ struct annotated_insn_loc {
 	     i < INSN_OP_MAX;						\
 	     i++, op_loc++)
 
+/* Bare number operand: an absolute address, as 32-bit code and the kernel use */
+bool annotated_op_loc__is_abs(const struct annotated_op_loc *op_loc,
+			      const struct dso *dso);
+u64 annotated_op_loc__abs_addr(const struct annotated_op_loc *op_loc,
+			       const struct dso *dso);
+
 /* Get detailed location info in the instruction */
 int annotate_get_insn_location(const struct arch *arch, struct disasm_line *dl,
 			       struct annotated_insn_loc *loc);
-- 
2.56.0

